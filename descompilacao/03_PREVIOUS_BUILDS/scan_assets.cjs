const fs = require('fs');
const path = require('path');

function getImageDimensions(filePath) {
  try {
    const fd = fs.openSync(filePath, 'r');
    const buffer = Buffer.alloc(30);
    fs.readSync(fd, buffer, 0, 30, 0);
    fs.closeSync(fd);

    if (buffer[0] === 0x89 && buffer[1] === 0x50 && buffer[2] === 0x4e && buffer[3] === 0x47) {
      const width = buffer.readUInt32BE(16);
      const height = buffer.readUInt32BE(20);
      return { width, height, type: 'png' };
    }

    if (buffer[0] === 0xff && buffer[1] === 0xd8) {
      const full = fs.readFileSync(filePath);
      let idx = 2;
      while (idx < full.length - 8) {
        if (full[idx] === 0xff && (full[idx+1] >= 0xc0 && full[idx+1] <= 0xc3)) {
          const height = full.readUInt16BE(idx + 5);
          const width = full.readUInt16BE(idx + 7);
          return { width, height, type: 'jpg' };
        }
        idx++;
      }
    }
  } catch (e) {}
  return null;
}

const largeImages = [];
const characterSprites = [];

function scanDir(dir) {
  let entries;
  try { entries = fs.readdirSync(dir, { withFileTypes: true }); } catch (e) { return; }
  for (const entry of entries) {
    const fullPath = path.join(dir, entry.name);
    if (entry.isDirectory()) {
      scanDir(fullPath);
    } else if (entry.isFile()) {
      const ext = path.extname(entry.name).toLowerCase();
      if (ext === '.png' || ext === '.jpg' || ext === '.jpeg') {
        const dim = getImageDimensions(fullPath);
        if (!dim) continue;
        const stats = fs.statSync(fullPath);

        // Candidatos a Cenário (largura >= 600, altura >= 300)
        if (dim.width >= 600 && dim.height >= 300) {
          largeImages.push({ path: fullPath, ...dim, size: stats.size });
        }

        // Candidatos a Personagem (altura entre 80 e 200, largura entre 30 e 150)
        if (dim.type === 'png' && dim.height >= 80 && dim.height <= 200 && dim.width >= 30 && dim.width <= 150) {
          characterSprites.push({ path: fullPath, ...dim, size: stats.size });
        }
      }
    }
  }
}

console.log('Varrendo imagens em legacy/raw_assets...');
scanDir('D:/naruto Online/legacy/raw_assets');
console.log('Imagens grandes (>= 600x300):', largeImages.length);
console.log('Candidatos a Personagens (80-200h x 30-150w):', characterSprites.length);

largeImages.sort((a, b) => (b.width * b.height) - (a.width * a.height));
console.log('\n--- TOP 25 CENÁRIOS / IMAGENS GRANDES ---');
for (const img of largeImages.slice(0, 25)) {
  console.log(`${img.width}x${img.height} (${img.type}) | ${(img.size/1024).toFixed(1)}KB | ${img.path}`);
}

console.log('\n--- PASTAS DOS CANDIDATOS A PERSONAGENS ---');
const charFolders = {};
for (const c of characterSprites) {
  const parts = c.path.split(path.sep);
  const folder = parts[parts.length - 3] || 'unknown';
  charFolders[folder] = (charFolders[folder] || 0) + 1;
}
console.log('Pastas com mais sprites de personagens:', charFolders);
