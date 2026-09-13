import * as fs from "node:fs";
import * as path from "node:path";
import * as http from "node:http";
import { fileURLToPath } from "node:url";

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

export class FlashAssetServer {
  private baseDir: string;
  private swfsDir: string;
  private texDir: string;
  private binDir: string;
  private audioDir: string;
  private webDir: string;

  private urlToFilePath: Map<string, string> = new Map();
  private keyToFilePath: Map<string, string> = new Map();
  private swfFilesBySize: Map<number, string> = new Map();
  private binFilesBySize: Map<number, string> = new Map();
  private resourceXmlContent: string = "";

  constructor(projectRoot: string = path.resolve(__dirname, "../../..")) {
    this.baseDir = path.join(projectRoot, "decompiled");
    this.swfsDir = path.join(this.baseDir, "swfs");
    this.texDir = path.join(this.baseDir, "texclient");
    this.binDir = path.join(this.baseDir, "bin_database");
    this.audioDir = path.join(this.baseDir, "audio");
    this.webDir = path.join(this.baseDir, "web_portal");

    this.indexLocalFiles();
    this.indexNaruManifest();
    this.generateResourceXml();
  }

  private indexLocalFiles() {
    if (fs.existsSync(this.swfsDir)) {
      const files = fs.readdirSync(this.swfsDir);
      for (const file of files) {
        if (file.endsWith(".bak") || file.endsWith(".tmp")) continue;
        const fullPath = path.join(this.swfsDir, file);
        try {
          const stats = fs.statSync(fullPath);
          if (stats.isFile()) {
            this.swfFilesBySize.set(stats.size, fullPath);
          }
        } catch {
          // ignore
        }
      }
    }

    if (fs.existsSync(this.binDir)) {
      const files = fs.readdirSync(this.binDir);
      for (const file of files) {
        if (file.endsWith(".bak") || file.endsWith(".tmp")) continue;
        const fullPath = path.join(this.binDir, file);
        try {
          const stats = fs.statSync(fullPath);
          if (stats.isFile()) {
            this.binFilesBySize.set(stats.size, fullPath);
          }
        } catch {
          // ignore
        }
      }
    }
  }

  private indexNaruManifest() {
    const naruPath = path.join(this.webDir, "naru.txt");
    if (!fs.existsSync(naruPath)) {
      console.warn("[Flash Asset Server] naru.txt not found at:", naruPath);
      return;
    }

    try {
      const content = fs.readFileSync(naruPath, "utf16le");
      const blocks = content.split("==================================================");

      for (const block of blocks) {
        const urlMatch = block.match(/URL\s*:\s*(.+)/);
        const sizeMatch = block.match(/File Size\s*:\s*(.+)/);
        if (!urlMatch) continue;

        const rawUrl = urlMatch[1].trim();
        const rawSize = sizeMatch ? sizeMatch[1].trim() : "";
        const sizeBytes = parseInt(rawSize.replace(/[^0-9]/g, ""), 10) || 0;

        const cleanUrl = rawUrl.split("?")[0];
        const basename = path.basename(cleanUrl);
        const ext = path.extname(cleanUrl).toLowerCase();

        let relPath = cleanUrl;
        try {
          const parsed = new URL(cleanUrl);
          relPath = parsed.pathname;
        } catch {
          // not full URL
        }

        let localPath: string | null = null;
        if (ext === ".swf") {
          if (this.swfFilesBySize.has(sizeBytes)) {
            localPath = this.swfFilesBySize.get(sizeBytes)!;
          } else if (fs.existsSync(path.join(this.swfsDir, basename))) {
            localPath = path.join(this.swfsDir, basename);
          }
        } else if (ext === ".texclient") {
          const p = path.join(this.texDir, basename);
          if (fs.existsSync(p)) localPath = p;
        } else if (ext === ".bin") {
          if (this.binFilesBySize.has(sizeBytes)) {
            localPath = this.binFilesBySize.get(sizeBytes)!;
          } else if (fs.existsSync(path.join(this.binDir, basename))) {
            localPath = path.join(this.binDir, basename);
          }
        } else if (ext === ".mp3") {
          const p = path.join(this.audioDir, basename);
          if (fs.existsSync(p)) localPath = p;
        } else if ([".js", ".css", ".png", ".jpg", ".jpeg", ".gif"].includes(ext)) {
          const p = path.join(this.webDir, basename);
          if (fs.existsSync(p)) localPath = p;
        }

        if (localPath) {
          this.urlToFilePath.set(relPath.toLowerCase(), localPath);

          // Extrai chave canônica de recurso (ex: "resources/swf/vital/00000001.swf")
          const m = rawUrl.match(/\/public\/(?:ushf\/)?\d+\/(.+)/i) || rawUrl.match(/Resources\/.+/i);
          if (m) {
            const key = (m[1] || m[0]).toLowerCase();
            // Prioridade absoluta para versão USHF oficial
            if (!this.keyToFilePath.has(key) || rawUrl.includes("/ushf/")) {
              this.keyToFilePath.set(key, localPath);
            }
          }
        }
      }

      // Garantir mapeamento das versões canônicas USHF para binários raiz
      const tAppUshf = path.join(this.swfsDir, "TApplication~1.swf");
      if (fs.existsSync(tAppUshf)) {
        this.keyToFilePath.set("tapplication.swf", tAppUshf);
      }
      const indexUshf = path.join(this.swfsDir, "index~1.swf");
      if (fs.existsSync(indexUshf)) {
        this.keyToFilePath.set("index.swf", indexUshf);
      }

      console.log(`[Flash Asset Server] Mapeadas ${this.urlToFilePath.size} URLs e ${this.keyToFilePath.size} chaves canônicas`);
    } catch (err) {
      console.error("[Flash Asset Server] Erro ao ler naru.txt:", err);
    }
  }

  private generateResourceXml() {
    const naruPath = path.join(this.webDir, "naru.txt");
    let xml = '<?xml version="1.0" encoding="utf-8"?>\n<Root>\n';
    const seenKeys = new Map<string, { version: string; size: number }>();

    const tAppPath = path.join(this.swfsDir, "TApplication~1.swf");
    const tAppSize = fs.existsSync(tAppPath) ? fs.statSync(tAppPath).size : 3310154;

    if (fs.existsSync(naruPath)) {
      try {
        const content = fs.readFileSync(naruPath, "utf16le");
        const blocks = content.split("==================================================");

        for (const block of blocks) {
          const urlMatch = block.match(/URL\s*:\s*(.+)/);
          const sizeMatch = block.match(/File Size\s*:\s*(.+)/);
          if (!urlMatch) continue;

          const rawUrl = urlMatch[1].trim();
          const rawSize = sizeMatch ? sizeMatch[1].trim() : "0";
          const sizeBytes = parseInt(rawSize.replace(/[^0-9]/g, ""), 10) || 0;

          const m = rawUrl.match(/\/public\/(?:ushf\/)?(\d+)\/(.+)/);
          if (m) {
            const version = m[1];
            const key = m[2];
            const isUshf = rawUrl.includes("/ushf/");
            if (!seenKeys.has(key) || isUshf) {
              seenKeys.set(key, { version, size: sizeBytes });
            }
          }
        }
      } catch {
        // ignore
      }
    }

    // Garantir que TApplication.swf no catálogo tem a versão e tamanho exatos do binário patcheado
    seenKeys.set("TApplication.swf", { version: "2026071712", size: tAppSize });

    for (const [key, data] of seenKeys.entries()) {
      xml += `  <Data>\n    <key>${key}</key>\n    <version>${data.version}</version>\n    <size>${data.size}</size>\n  </Data>\n`;
    }

    xml += "</Root>";
    this.resourceXmlContent = xml;
    console.log(`[Flash Asset Server] Catálogo resource_2026090412.xml gerado com ${seenKeys.size} entradas`);
  }

  public handleRequest(req: http.IncomingMessage, res: http.ServerResponse): boolean {
    const rawUrl = req.url || "/";
    const cleanUrl = rawUrl.split("?")[0];
    const lowerUrl = cleanUrl.toLowerCase();

    console.log(`[HTTP Asset Req] ${req.method} ${rawUrl}`);

    // 1. Cross-Domain Policy XML para Flash HTTP
    if (lowerUrl === "/crossdomain.xml") {
      const crossdomainXml =
        '<?xml version="1.0"?>\n' +
        '<!DOCTYPE cross-domain-policy SYSTEM "http://www.adobe.com/xml/dtds/cross-domain-policy.dtd">\n' +
        '<cross-domain-policy>\n' +
        '  <site-control permitted-cross-domain-policies="all"/>\n' +
        '  <allow-access-from domain="*" to-ports="*" secure="false"/>\n' +
        '  <allow-http-request-headers-from domain="*" headers="*" secure="false"/>\n' +
        '</cross-domain-policy>\n';
      res.writeHead(200, {
        "Content-Type": "text/x-cross-domain-policy; charset=utf-8",
        "Access-Control-Allow-Origin": "*",
        "Cache-Control": "no-cache, no-store, must-revalidate",
        "Pragma": "no-cache",
        "Expires": "0",
        "Content-Length": Buffer.byteLength(crossdomainXml),
      });
      res.end(crossdomainXml);
      return true;
    }

    // 1b. Logger de telemetria / ExternalInterface do Flash
    if (lowerUrl === "/debug_flash") {
      const parsed = new URL(rawUrl, "http://127.0.0.1:8080");
      const d = parsed.searchParams.get("d");
      if (d) {
        try {
          const payload = JSON.parse(d);
          console.log(`[Flash Ext] ${payload.type}:`, JSON.stringify(payload.args));
        } catch {
          console.log(`[Flash Ext] raw:`, d);
        }
      }
      res.writeHead(200, { "Content-Type": "text/plain", "Access-Control-Allow-Origin": "*" });
      res.end("OK");
      return true;
    }

    // 2. Launcher oficial do Flash Player
    if (lowerUrl === "/" || lowerUrl === "/index.html" || lowerUrl === "/flash.html") {
      const html = this.getOfficialFlashLauncherHtml();
      res.writeHead(200, {
        "Content-Type": "text/html; charset=utf-8",
        "Access-Control-Allow-Origin": "*",
        "Content-Length": Buffer.byteLength(html),
      });
      res.end(html);
      return true;
    }

    // 3. Catálogo de Recursos XML
    if (lowerUrl.includes("resource") && lowerUrl.endsWith(".xml")) {
      res.writeHead(200, {
        "Content-Type": "text/xml; charset=utf-8",
        "Access-Control-Allow-Origin": "*",
        "Cache-Control": "no-cache, no-store, must-revalidate",
        "Pragma": "no-cache",
        "Expires": "0",
        "Content-Length": Buffer.byteLength(this.resourceXmlContent),
      });
      res.end(this.resourceXmlContent);
      return true;
    }

    // 4. Arquivos JS essenciais do portal (ex: swfobject.js, swffit.js)
    if (lowerUrl.endsWith("swfobject.js")) {
      const swfobjectPath = path.join(this.webDir, "swfobject.js");
      if (fs.existsSync(swfobjectPath)) {
        this.serveFile(res, swfobjectPath, "application/javascript");
        return true;
      }
    }

    // 5. Mapeamento direto de URL oficial
    if (this.urlToFilePath.has(lowerUrl)) {
      const filePath = this.urlToFilePath.get(lowerUrl)!;
      if (fs.existsSync(filePath)) {
        this.serveFile(res, filePath, this.getContentType(filePath));
        return true;
      }
    }

    // 5b. Mapeamento por chave canônica de recurso (ex: Resources/Swf/Vital/00000001.swf)
    const keyMatch = lowerUrl.match(/resources\/.+/i);
    if (keyMatch) {
      const key = keyMatch[0].toLowerCase();
      if (this.keyToFilePath.has(key)) {
        const filePath = this.keyToFilePath.get(key)!;
        if (fs.existsSync(filePath)) {
          this.serveFile(res, filePath, this.getContentType(filePath));
          return true;
        }
      }
    }

    // 5c. Binários de inicialização (TApplication e index)
    if (lowerUrl.endsWith("tapplication.swf")) {
      const filePath = this.keyToFilePath.get("tapplication.swf") || path.join(this.swfsDir, "TApplication~1.swf");
      if (fs.existsSync(filePath)) {
        this.serveFile(res, filePath, "application/x-shockwave-flash");
        return true;
      }
    }

    if (lowerUrl.endsWith("index.swf")) {
      const filePath = this.keyToFilePath.get("index.swf") || path.join(this.swfsDir, "index~1.swf");
      if (fs.existsSync(filePath)) {
        this.serveFile(res, filePath, "application/x-shockwave-flash");
        return true;
      }
    }

    // 6. Resolução por nome de arquivo (fallback)
    const basename = path.basename(cleanUrl);
    const ext = path.extname(cleanUrl).toLowerCase();

    let candidatePath: string | null = null;
    if (ext === ".swf") {
      const direct = path.join(this.swfsDir, basename);
      if (fs.existsSync(direct)) candidatePath = direct;
    } else if (ext === ".texclient") {
      const direct = path.join(this.texDir, basename);
      if (fs.existsSync(direct)) candidatePath = direct;
    } else if (ext === ".bin") {
      const direct = path.join(this.binDir, basename);
      if (fs.existsSync(direct)) candidatePath = direct;
    } else if (ext === ".mp3") {
      const direct = path.join(this.audioDir, basename);
      if (fs.existsSync(direct)) candidatePath = direct;
    } else if ([".js", ".css", ".png", ".jpg", ".jpeg", ".gif"].includes(ext)) {
      const direct = path.join(this.webDir, basename);
      if (fs.existsSync(direct)) candidatePath = direct;
    }

    if (candidatePath && fs.existsSync(candidatePath)) {
      this.serveFile(res, candidatePath, this.getContentType(candidatePath));
      return true;
    }

    return false;
  }

  private serveFile(res: http.ServerResponse, filePath: string, contentType: string) {
    try {
      const data = fs.readFileSync(filePath);
      res.writeHead(200, {
        "Content-Type": contentType,
        "Content-Length": data.length,
        "Access-Control-Allow-Origin": "*",
        "Cache-Control": "no-cache, no-store, must-revalidate",
        "Pragma": "no-cache",
        "Expires": "0",
      });
      res.end(data);
    } catch {
      res.writeHead(500);
      res.end("Internal Server Error");
    }
  }

  private getContentType(filePath: string): string {
    const ext = path.extname(filePath).toLowerCase();
    switch (ext) {
      case ".swf":
        return "application/x-shockwave-flash";
      case ".xml":
        return "text/xml; charset=utf-8";
      case ".js":
        return "application/javascript; charset=utf-8";
      case ".css":
        return "text/css; charset=utf-8";
      case ".png":
        return "image/png";
      case ".jpg":
      case ".jpeg":
        return "image/jpeg";
      case ".gif":
        return "image/gif";
      case ".mp3":
        return "audio/mpeg";
      case ".bin":
      case ".texclient":
      default:
        return "application/octet-stream";
    }
  }

  public getOfficialFlashLauncherHtml(): string {
    return `<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="pt-BR" xml:lang="pt-BR">
<head>
  <meta charset="utf-8">
  <title>Naruto Online - Servidor Local Joyfun Oficial (Flash)</title>
  <meta name="google" value="notranslate" />
  <script type="text/javascript" src="/public/script/swfobject.js"></script>
  <script type="text/javascript">
    function reportFlash(type, args) {
      try {
        var params = Array.prototype.slice.call(args || []);
        var d = encodeURIComponent(JSON.stringify({ type: type, args: params }));
        var img = new Image();
        img.src = '/debug_flash?d=' + d;
      } catch(e) {}
    }

    var flashExtMethods = [
      'AddFavorite', 'ClientURLNavigate', 'accountBound', 'analyUser',
      'btnclick', 'clickdo', 'collectData', 'createRole',
      'feed', 'flash_log', 'gameRolePost', 'guide',
      'invite', 'load_finish', 'login', 'member_icon',
      'openBox', 'register', 'reloadgame', 'role',
      'showPop', 'statistics', 'task'
    ];
    flashExtMethods.forEach(function(fn) {
      window[fn] = function() {
        console.log('[Flash Ext Call]', fn, arguments);
        reportFlash(fn, arguments);
        return 1;
      };
    });

    window.onerror = function(msg, url, line) {
      reportFlash('WINDOW_ERROR', [msg, url, line]);
    };
  </script>
  <style>
    * { box-sizing: border-box; }
    html, body {
      margin: 0;
      padding: 0;
      width: 100vw;
      height: 100vh;
      overflow: hidden;
      background-color: #000000;
    }
    #flashContainer {
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      display: flex;
      justify-content: center;
      align-items: center;
      background-color: #000000;
    }
    #flashContent {
      width: 100%;
      height: 100%;
    }
    #noFlashMsg {
      color: #f39c12;
      font-family: Arial, sans-serif;
      text-align: center;
      padding: 40px;
    }
  </style>
</head>
<body>
  <div id="flashContainer">
    <div id="flashContent">
      <div id="noFlashMsg">
        <h2>Carregando Naruto Online Oficial (Flash)...</h2>
        <p>Se esta mensagem não desaparecer, certifique-se de que o Pepper Flash Player (.dll) está ativo no cliente.</p>
      </div>
    </div>
  </div>

  <script type="text/javascript">
    var swfVersionStr = "0.0.0";
    var xiSwfUrlStr = "/public/ushf/2026090412/index.swf";

    var flashvars = [
      "flag=1",
      "isNew=0",
      "isAdult=0",
      "token=token_daniel_test",
      "username=daniel",
      "time=" + Math.floor(Date.now() / 1000),
      "agent=75",
      "userIp=127.0.0.1",
      "server=1",
      "isCombin=0",
      "version=2026090412",
      "gatewayPort=8080",
      "ServerVersion=2026090412",
      "gatewayIP=127.0.0.1",
      "cdnRoot=" + encodeURIComponent("http://127.0.0.1:8080/public/ushf/"),
      "payurl=" + encodeURIComponent("http://127.0.0.1:8080/pay"),
      "support=" + encodeURIComponent("http://127.0.0.1:8080"),
      "officeurl=" + encodeURIComponent("http://127.0.0.1:8080"),
      "fightreporturl=" + encodeURIComponent("http://127.0.0.1:8080/fightreport/")
    ].join("&");

    var params = {
      flashvars: flashvars,
      quality: "high",
      bgcolor: "#000000",
      allowfullscreen: "true",
      allowScriptAccess: "always",
      allowFullscreenInteractive: "true",
      wmode: "direct"
    };

    var attributes = {
      id: "loading",
      name: "loading",
      align: "middle"
    };

    swfobject.embedSWF(
      xiSwfUrlStr,
      "flashContent",
      "100%",
      "100%",
      swfVersionStr,
      xiSwfUrlStr,
      flashvars,
      params,
      attributes
    );
  </script>
</body>
</html>`;
  }
}
