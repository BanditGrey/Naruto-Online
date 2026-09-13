const fs = require('fs');
const path = require('path');

console.log("--- INVESTIGANDO TIPO DE RECURSO 28 (0x1C) ---");

// 1. Inspecionar ConstructRepositoryTexture em TResourcesCore.as
const coreScript = "D:/naruto Online/02_LEGACY_ARCHIVE/decompiled/scripts_as3_latest/Foundation/Resources/TResourcesCore.as";
if (fs.existsSync(coreScript)) {
  const content = fs.readFileSync(coreScript, 'utf8');
  const lines = content.split('\n');
  let print = false;
  let count = 0;
  for (let i = 0; i < lines.length; i++) {
    if (lines[i].includes('ConstructRepositoryTexture')) {
      print = true;
    }
    if (print) {
      console.log(`[L${i+1}]: ${lines[i]}`);
      count++;
      if (count > 25) break;
    }
  }
}

// 2. Procurar arquivos no disco iniciados por 1C (28 em hex) ou contendo BackgroundIcon
console.log("\n--- BUSCANDO ARQUIVOS COM PREFIXO 1C (HEX DE 28) ---");
function scanFor1C(dir) {
  if (!fs.existsSync(dir)) return;
  const entries = fs.readdirSync(dir, { withFileTypes: true });
  for (const ent of entries) {
    const full = path.join(dir, ent.name);
    if (ent.isDirectory()) {
      if (!full.includes('node_modules') && !full.includes('.git')) scanFor1C(full);
    } else {
      const lower = ent.name.toLowerCase();
      if (lower.startsWith('1c') || lower.includes('backgroundicon')) {
        const sz = (fs.statSync(full).size / 1024).toFixed(1);
        console.log(`  ${ent.name} (${sz} KB) -> ${full}`);
      }
    }
  }
}

scanFor1C("D:/naruto Online/01_VN_OFFICIAL_SOURCE");
scanFor1C("D:/naruto Online/02_LEGACY_ARCHIVE");
