const fs = require('fs');
const path = require('path');
const base = 'D:/naruto Online/legacy/raw_assets/Scripts_AS';

function getImageDimensions(filePath) {
  try {
    const fd = fs.openSync(filePath, 'r');
    const buffer = Buffer.alloc(30);
    fs.readSync(fd, buffer, 0, 30, 0);
    fs.closeSync(fd);

    if (buffer[0] === 0x89 && buffer[1] === 0x50 && buffer[2] === 0x4e && buffer[3] === 0x47) {
      return { w: buffer.readUInt32BE(16), h: buffer.readUInt32BE(20), type: 'png' };
    }
    if (buffer[0] === 0xff && buffer[1] === 0xd8) {
      const full = fs.readFileSync(filePath);
      let idx = 2;
      while (idx < full.length - 8) {
        if (full[idx] === 0xff && (full[idx+1] >= 0xc0 && full[idx+1] <= 0xc3)) {
          return { h: full.readUInt16BE(idx + 5), w: full.readUInt16BE(idx + 7), type: 'jpg' };
        }
        idx++;
      }
    }
  } catch (e) {}
  return null;
}

const large = [];
for (const d of fs.readdirSync(base, { withFileTypes: true })) {
  if (!d.isDirectory()) continue;
  const imgDir = path.join(base, d.name, 'images');
  if (!fs.existsSync(imgDir)) continue;
  for (const f of fs.readdirSync(imgDir)) {
    const p = path.join(imgDir, f);
    const dim = getImageDimensions(p);
    if (dim && dim.w >= 700 && dim.h >= 350) {
      const scrDir = path.join(base, d.name, 'scripts');
      let scripts = [];
      if (fs.existsSync(scrDir)) {
        scripts = fs.readdirSync(scrDir).filter(s => !s.startsWith('_') && s.endsWith('.as'));
      }
      large.push({ folder: d.name, file: f, ...dim, size: fs.statSync(p).size, scripts: scripts.slice(0, 3).join(',') });
    }
  }
}

large.sort((a, b) => b.w - a.w);
console.log('Total de imagens >= 700x350: ' + large.length);
for (const item of large) {
  console.log(item.folder + '/images/' + item.file + ' | ' + item.w + 'x' + item.h + ' (' + item.type + ') | ' + (item.size/1024).toFixed(1) + 'KB | Scripts: ' + item.scripts);
}
