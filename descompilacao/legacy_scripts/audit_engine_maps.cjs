const fs = require('fs');
const path = require('path');

console.log("=== INICIANDO AUDITORIA PROFUNDA DO MOTOR E CENAS ===");

const report = {
  timestamp: new Date().toISOString(),
  sceneConfigs: [],
  textureRepositories: [],
  discoveredBackgrounds: []
};

// 1. Procurar arquivos de configuração de cenas ou dicionários de mapas
function searchJsonConfigs(dir) {
  if (!fs.existsSync(dir)) return;
  const entries = fs.readdirSync(dir, { withFileTypes: true });
  for (const ent of entries) {
    const full = path.join(dir, ent.name);
    if (ent.isDirectory()) {
      if (!full.includes('node_modules') && !full.includes('.git')) searchJsonConfigs(full);
    } else if (ent.name.toLowerCase().endsWith('.json') || ent.name.toLowerCase().endsWith('.xml')) {
      try {
        const content = fs.readFileSync(full, 'utf8');
        if (content.includes('scene') || content.includes('Map') || content.includes('Konoha')) {
          report.sceneConfigs.push({ file: full, size: fs.statSync(full).size });
        }
      } catch (e) {}
    }
  }
}

searchJsonConfigs("D:/naruto Online/01_VN_OFFICIAL_SOURCE");
searchJsonConfigs("D:/naruto Online/02_LEGACY_ARCHIVE");

// 2. Procurar instâncias de TLayerBackGround e classes de Scene nos AS3 descompilados
function searchAs3Scenes(dir) {
  if (!fs.existsSync(dir)) return;
  const entries = fs.readdirSync(dir, { withFileTypes: true });
  for (const ent of entries) {
    const full = path.join(dir, ent.name);
    if (ent.isDirectory()) {
      if (!full.includes('node_modules') && !full.includes('.git')) searchAs3Scenes(full);
    } else if (ent.name.endsWith('.as') && (ent.name.includes('Scene') || ent.name.includes('Map') || ent.name.includes('BackGround'))) {
      try {
        const text = fs.readFileSync(full, 'utf8');
        if (text.includes('SceneID') || text.includes('MAP_WIDTH')) {
          report.textureRepositories.push({ file: full, snippet: text.substring(0, 300).replace(/\s+/g, ' ') });
        }
      } catch (e) {}
    }
  }
}

searchAs3Scenes("D:/naruto Online/02_LEGACY_ARCHIVE/decompiled");

// 3. Filtrar imagens reais de cenário (w > 1000, h > 500, excluindo UI boxes)
function getDimensions(buf) {
  if (buf[0] === 0x89 && buf[1] === 0x50 && buf[2] === 0x4E && buf[3] === 0x47) {
    return { w: buf.readUInt32BE(16), h: buf.readUInt32BE(20) };
  }
  if (buf[0] === 0xFF && buf[1] === 0xD8) {
    let offset = 2;
    while (offset < buf.length) {
      if (buf[offset] === 0xFF && (buf[offset + 1] >= 0xC0 && buf[offset + 1] <= 0xC3)) {
        return { h: buf.readUInt16BE(offset + 5), w: buf.readUInt16BE(offset + 7) };
      }
      offset += 2 + buf.readUInt16BE(offset + 2);
    }
  }
  return null;
}

function scanTrueBackgrounds(dir) {
  if (!fs.existsSync(dir)) return;
  const entries = fs.readdirSync(dir, { withFileTypes: true });
  for (const ent of entries) {
    const full = path.join(dir, ent.name);
    if (ent.isDirectory()) {
      if (!full.includes('node_modules') && !full.includes('.git') && !full.includes('client/public')) {
        scanTrueBackgrounds(full);
      }
    } else if (/\.(png|jpg|jpeg)$/i.test(ent.name)) {
      try {
        const stat = fs.statSync(full);
        // Mapas de mundo/cenários costumam ter arquivos maiores que 50KB e proporção estritamente horizontal ampla
        if (stat.size > 45000) {
          const fd = fs.openSync(full, 'r');
          const header = Buffer.alloc(2048);
          fs.readSync(fd, header, 0, 2048, 0);
          fs.closeSync(fd);
          const dim = getDimensions(header);
          if (dim && dim.w >= 1000 && dim.h >= 500 && dim.w > dim.h * 1.3) {
            report.discoveredBackgrounds.push({
              path: full,
              width: dim.w,
              height: dim.h,
              sizeKB: (stat.size / 1024).toFixed(1)
            });
          }
        }
      } catch (e) {}
    }
  }
}

scanTrueBackgrounds("D:/naruto Online/01_VN_OFFICIAL_SOURCE");
scanTrueBackgrounds("D:/naruto Online/02_LEGACY_ARCHIVE");

const outLog = "D:/naruto Online/core_project/client/public/engine_map_audit.json";
fs.writeFileSync(outLog, JSON.stringify(report, null, 2), 'utf8');

console.log("=== AUDITORIA CONCLUÍDA ===");
console.log(`- Configurações de cena encontradas: ${report.sceneConfigs.length}`);
console.log(`- Classes AS3 de mapa/fundo mapeadas: ${report.textureRepositories.length}`);
console.log(`- Cenários horizontais autênticos (W >= 1000, H >= 500): ${report.discoveredBackgrounds.length}`);
console.log(`Relatório salvo em: ${outLog}`);
