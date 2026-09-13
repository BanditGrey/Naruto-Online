const fs = require('fs');
const path = require('path');

const outputHtml = 'D:/naruto Online/core_project/client/public/map_gallery.html';
const copyDir = 'D:/naruto Online/core_project/client/public/gallery_thumbs';

if (!fs.existsSync(copyDir)) fs.mkdirSync(copyDir, { recursive: true });

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

const found = [];

function scanDir(dir) {
  if (!fs.existsSync(dir)) return;
  const entries = fs.readdirSync(dir, { withFileTypes: true });
  for (const entry of entries) {
    const full = path.join(dir, entry.name);
    if (entry.isDirectory()) {
      if (!full.includes('node_modules') && !full.includes('.git') && !full.includes('client/dist')) {
        scanDir(full);
      }
    } else if (/\.(png|jpg|jpeg)$/i.test(entry.name)) {
      try {
        const stat = fs.statSync(full);
        if (stat.size > 25000) {
          const fd = fs.openSync(full, 'r');
          const header = Buffer.alloc(2048);
          fs.readSync(fd, header, 0, 2048, 0);
          fs.closeSync(fd);
          const dim = getDimensions(header);
          if (dim && dim.w >= 700 && dim.h >= 300 && dim.w > dim.h) {
            const safeName = 'map_' + found.length + '_' + entry.name.replace(/[^a-zA-Z0-9._-]/g, '_');
            const targetPath = path.join(copyDir, safeName);
            fs.copyFileSync(full, targetPath);
            found.push({
              origPath: full,
              thumbUrl: '/gallery_thumbs/' + safeName,
              name: entry.name,
              w: dim.w,
              h: dim.h,
              size: (stat.size / 1024).toFixed(1)
            });
          }
        }
      } catch (e) {}
    }
  }
}

console.log('Escaneando todos os cenários e mapas...');
scanDir('D:/naruto Online/01_VN_OFFICIAL_SOURCE');
scanDir('D:/naruto Online/02_LEGACY_ARCHIVE');

console.log('Encontrados ' + found.length + ' cenários horizontais.');

let cardsHtml = '';
for (let i = 0; i < found.length; i++) {
  const f = found[i];
  cardsHtml += '<div class="card">' +
    '<div class="badge">#' + (i + 1) + ' | ' + f.w + 'x' + f.h + ' (' + f.size + ' KB)</div>' +
    '<img src="' + f.thumbUrl + '" loading="lazy" />' +
    '<div class="name">' + f.name + '</div>' +
    '<div class="path">' + f.origPath + '</div>' +
  '</div>';
}

const html = '<!DOCTYPE html>' +
'<html>' +
'<head>' +
  '<meta charset="UTF-8">' +
  '<title>Galeria de Mapas e Cenários Reais</title>' +
  '<style>' +
    'body { background: #0d1117; color: #c9d1d9; font-family: sans-serif; padding: 20px; }' +
    'h1 { color: #58a6ff; font-size: 20px; margin-bottom: 8px; }' +
    'p { font-size: 13px; color: #8b949e; margin-bottom: 20px; }' +
    '.grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(360px, 1fr)); gap: 16px; }' +
    '.card { background: #161b22; border: 2px solid #30363d; border-radius: 8px; overflow: hidden; transition: 0.2s; padding: 10px; }' +
    '.card:hover { border-color: #ffd700; transform: translateY(-3px); }' +
    '.card img { width: 100%; height: 200px; object-fit: cover; border-radius: 4px; background: #000; }' +
    '.badge { font-size: 11px; color: #ffd700; font-weight: bold; margin-bottom: 6px; }' +
    '.name { font-size: 13px; font-weight: bold; margin-top: 8px; color: #fff; word-break: break-all; }' +
    '.path { font-size: 10px; color: #8b949e; margin-top: 4px; word-break: break-all; }' +
  '</style>' +
'</head>' +
'<body>' +
  '<h1>Seletor de Cenários e Mapas Encontrados no Projeto</h1>' +
  '<p>Veja as miniaturas abaixo e aponte qual o número (#) da imagem que é a vila oficial de Konoha:</p>' +
  '<div class="grid">' + cardsHtml + '</div>' +
'</body>' +
'</html>';

fs.writeFileSync(outputHtml, html, 'utf8');
console.log('✓ Galeria gerada com sucesso em: ' + outputHtml);
