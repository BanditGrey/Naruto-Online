const fs = require('fs');
const path = require('path');

console.log("--- INSPECIONANDO PASTA EXTRAÍDA DE 1C000000 ---");

const targetDir = "D:/naruto Online/02_LEGACY_ARCHIVE/decompiled/extracted_swf_assets/1C000000";

if (fs.existsSync(targetDir)) {
  function scan(dir) {
    const entries = fs.readdirSync(dir, { withFileTypes: true });
    for (const ent of entries) {
      const full = path.join(dir, ent.name);
      if (ent.isDirectory()) {
        scan(full);
      } else {
        const sz = (fs.statSync(full).size / 1024).toFixed(1);
        console.log(`[ARQUIVO]: ${ent.name} (${sz} KB) -> ${full}`);
      }
    }
  }
  scan(targetDir);
} else {
  console.log("Diretório não encontrado: " + targetDir);
}
