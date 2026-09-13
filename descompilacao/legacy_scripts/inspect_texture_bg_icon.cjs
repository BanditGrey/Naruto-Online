const fs = require('fs');
const path = require('path');

function searchFile(dir, fileName) {
  if (!fs.existsSync(dir)) return null;
  const entries = fs.readdirSync(dir, { withFileTypes: true });
  for (const ent of entries) {
    const full = path.join(dir, ent.name);
    if (ent.isDirectory()) {
      if (!full.includes('node_modules') && !full.includes('.git')) {
        const res = searchFile(full, fileName);
        if (res) return res;
      }
    } else if (ent.name.toLowerCase() === fileName.toLowerCase()) {
      return full;
    }
  }
  return null;
}

console.log("--- LOCALIZANDO TEXTURESBACKGROUNDICON.AS ---");
const filePath = searchFile("D:/naruto Online/02_LEGACY_ARCHIVE", "TexturesBackgroundIcon.as") ||
                 searchFile("D:/naruto Online/02_LEGACY_ARCHIVE", "TTexturesBackgroundIcon.as");

if (filePath) {
  console.log("Arquivo encontrado em: " + filePath);
  const content = fs.readFileSync(filePath, 'utf8');
  const lines = content.split('\n');
  lines.forEach((line, idx) => {
    const l = line.toLowerCase();
    if (l.includes('url') || l.includes('path') || l.includes('format') || l.includes('.swf') || l.includes('res') || l.includes('scene') || l.includes('geturl')) {
      console.log(`[L${idx + 1}]: ${line.trim()}`);
    }
  });
} else {
  console.log("Procurando onde TexturesBackgroundIcon é declarado...");
  const corePath = searchFile("D:/naruto Online/02_LEGACY_ARCHIVE", "SResourcesCore.as");
  if (corePath) {
    const content = fs.readFileSync(corePath, 'utf8');
    content.split('\n').filter(l => l.includes('TexturesBackgroundIcon')).forEach(l => console.log(l.trim()));
  }
}
