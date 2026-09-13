const fs = require('fs');
const path = require('path');

const content = `import * as fs from "node:fs";
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
  private swfFilesBySize: Map<number, string> = new Map();
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
        const urlMatch = block.match(/URL\\s*:\\s*(.+)/);
        const sizeMatch = block.match(/File Size\\s*:\\s*(.+)/);
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
          const p = path.join(this.binDir, basename);
          if (fs.existsSync(p)) localPath = p;
        } else if (ext === ".mp3") {
          const p = path.join(this.audioDir, basename);
          if (fs.existsSync(p)) localPath = p;
        } else if ([".js", ".css", ".png", ".jpg", ".jpeg", ".gif"].includes(ext)) {
          const p = path.join(this.webDir, basename);
          if (fs.existsSync(p)) localPath = p;
        }

        if (localPath) {
          this.urlToFilePath.set(relPath.toLowerCase(), localPath);
        }
      }

      console.log(\`[Flash Asset Server] Mapeadas \${this.urlToFilePath.size} URLs oficiais para arquivos locais em disco\`);
    } catch (err) {
      console.error("[Flash Asset Server] Erro ao ler naru.txt:", err);
    }
  }

  private generateResourceXml() {
    const naruPath = path.join(this.webDir, "naru.txt");
    let xml = '<?xml version="1.0" encoding="utf-8"?>\\n<Root>\\n';
    const seenKeys = new Set<string>();

    const tAppPath = path.join(this.swfsDir, "TApplication.swf");
    const tAppSize = fs.existsSync(tAppPath) ? fs.statSync(tAppPath).size : 3184675;
    xml += \`  <Data>\\n    <key>TApplication.swf</key>\\n    <version>2026090412</version>\\n    <size>\${tAppSize}</size>\\n  </Data>\\n\`;
    seenKeys.add("TApplication.swf");

    if (fs.existsSync(naruPath)) {
      try {
        const content = fs.readFileSync(naruPath, "utf16le");
        const blocks = content.split("==================================================");

        for (const block of blocks) {
          const urlMatch = block.match(/URL\\s*:\\s*(.+)/);
          const sizeMatch = block.match(/File Size\\s*:\\s*(.+)/);
          if (!urlMatch) continue;

          const rawUrl = urlMatch[1].trim();
          const rawSize = sizeMatch ? sizeMatch[1].trim() : "0";
          const sizeBytes = parseInt(rawSize.replace(/[^0-9]/g, ""), 10) || 0;

          const m = rawUrl.match(/\\/public\\/(?:ushf\\/)?(\\d+)\\/(.+)/);
          if (m) {
            const version = m[1];
            const key = m[2];
            if (!seenKeys.has(key)) {
              seenKeys.add(key);
              xml += \`  <Data>\\n    <key>\${key}</key>\\n    <version>\${version}</version>\\n    <size>\${sizeBytes}</size>\\n  </Data>\\n\`;
            }
          }
        }
      } catch {
        // ignore
      }
    }

    if (fs.existsSync(this.swfsDir)) {
      const files = fs.readdirSync(this.swfsDir);
      for (const f of files) {
        if (f.endsWith(".swf") && !seenKeys.has(f)) {
          seenKeys.add(f);
          const size = fs.statSync(path.join(this.swfsDir, f)).size;
          xml += \`  <Data>\\n    <key>\${f}</key>\\n    <version>2026090412</version>\\n    <size>\${size}</size>\\n  </Data>\\n\`;
        }
      }
    }

    xml += "</Root>";
    this.resourceXmlContent = xml;
    console.log(\`[Flash Asset Server] Catálogo resource_2026090412.xml gerado com \${seenKeys.size} entradas\`);
  }

  public handleRequest(req: http.IncomingMessage, res: http.ServerResponse): boolean {
    const rawUrl = req.url || "/";
    const cleanUrl = rawUrl.split("?")[0];
    const lowerUrl = cleanUrl.toLowerCase();

    // 1. Cross-Domain Policy XML para Flash HTTP
    if (lowerUrl === "/crossdomain.xml") {
      const crossdomainXml =
        '<?xml version="1.0"?>\\n' +
        '<!DOCTYPE cross-domain-policy SYSTEM "http://www.adobe.com/xml/dtds/cross-domain-policy.dtd">\\n' +
        '<cross-domain-policy>\\n' +
        '  <allow-access-from domain="*" to-ports="*"/>\\n' +
        '</cross-domain-policy>\\n';
      res.writeHead(200, {
        "Content-Type": "text/xml; charset=utf-8",
        "Access-Control-Allow-Origin": "*",
        "Content-Length": Buffer.byteLength(crossdomainXml),
      });
      res.end(crossdomainXml);
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
      const stat = fs.statSync(filePath);
      res.writeHead(200, {
        "Content-Type": contentType,
        "Content-Length": stat.size,
        "Access-Control-Allow-Origin": "*",
        "Cache-Control": "public, max-age=864000",
      });
      const stream = fs.createReadStream(filePath);
      stream.pipe(res);
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
    return \`<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="pt-BR" xml:lang="pt-BR">
<head>
  <meta charset="utf-8">
  <title>Naruto Online - Servidor Local Joyfun Oficial (Flash)</title>
  <meta name="google" value="notranslate" />
  <script type="text/javascript" src="/public/script/swfobject.js"></script>
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
      "agent=113",
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
</html>\`;
  }
}
`;

fs.writeFileSync('D:\\\\naruto Online\\\\server\\\\src\\\\network\\\\flashAssetServer.ts', content, 'utf8');
console.log('flashAssetServer.ts created successfully!');
