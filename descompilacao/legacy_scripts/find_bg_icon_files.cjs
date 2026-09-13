const fs = require('fs');
const path = require('path');

console.log("--- PROCURANDO ARQUIVOS EM Resources/Textures/BackgroundIcon ---");

function scanForBackgroundIcon(dir) {
  if (!fs.existsSync(dir)) return;
  const entries = fs.readdirSync(dir, { withFileTypes: true });
  for (const ent of entries) {
    const full = path.join(dir, ent.name);
    if (ent.isDirectory()) {
      const lower = ent.name.toLowerCase();
      if (lower === 'backgroundicon' || lower === 'background' || lower.includes('bgicon')) {
        console.log(`\n[DIRETÓRIO ENCONTRADO]: ${full}`);
        const files = fs.readdirSync(full);
        console.log(`Total de arquivos: ${files.length}`);
        files.slice(0, 20).forEach(f => {
          const sz = (fs.statSync(path.join(full, f)).size / 1024).toFixed(1);
          console.log(`  ${f} (${sz} KB)`);
        });
      }
      if (!full.includes('node_modules') && !full.includes('.git')) {
        scanForBackgroundIcon(full);
      }
    } else {
      const lower = ent.name.toLowerCase();
      if (lower.includes('backgroundicon') || (lower.endsWith('.texclient') && lower.includes('icon'))) {
        console.log(`[ARQUIVO]: ${full} (${(fs.statSync(full).size / 1024).toFixed(1)} KB)`);
      }
    }
  }
}

scanForBackgroundIcon("D:/naruto Online/01_VN_OFFICIAL_SOURCE");
scanForBackgroundIcon("D:/naruto Online/02_LEGACY_ARCHIVE");
