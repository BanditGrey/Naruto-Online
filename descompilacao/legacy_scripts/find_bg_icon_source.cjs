const fs = require('fs');
const path = require('path');

console.log("--- RASTREANDO TEXTURESBACKGROUNDICON NOS SCRIPTS AS3 ---");

function grepDir(dir, pattern) {
  if (!fs.existsSync(dir)) return;
  const entries = fs.readdirSync(dir, { withFileTypes: true });
  for (const ent of entries) {
    const full = path.join(dir, ent.name);
    if (ent.isDirectory()) {
      if (!full.includes('node_modules') && !full.includes('.git')) grepDir(full, pattern);
    } else if (ent.name.endsWith('.as')) {
      try {
        const text = fs.readFileSync(full, 'utf8');
        if (text.includes(pattern)) {
          console.log(`\n[ENCONTRADO]: ${full}`);
          const lines = text.split('\n');
          lines.forEach((l, idx) => {
            if (l.includes(pattern) || l.includes('LoadPrimary') || l.includes('URL') || l.includes('Format')) {
              console.log(`  L${idx + 1}: ${l.trim()}`);
            }
          });
        }
      } catch (e) {}
    }
  }
}

grepDir("D:/naruto Online/02_LEGACY_ARCHIVE/decompiled", "TexturesBackgroundIcon");
