const fs = require('fs');
const path = require('path');

const asarPath = path.join('D:', 'naruto Online', 'official_client', 'resources', 'app.asar.bak');
const asar = fs.readFileSync(asarPath);

const headerSize = asar.readUInt32LE(12);
const jsonStr = asar.slice(16, 16 + headerSize).toString('utf8');

const idx = jsonStr.indexOf('"nativefier.json"');
console.log('nativefier.json entry in header:', jsonStr.slice(idx, idx + 100));

const dataStart = 8 + asar.readUInt32LE(4);
console.log('Data starts at:', dataStart);

const regex = /"nativefier\.json":\{"size":(\d+),"offset":"(\d+)"\}/;
const match = regex.exec(jsonStr);
if (match) {
  const size = parseInt(match[1], 10);
  const offset = parseInt(match[2], 10);
  console.log('nativefier.json size:', size, 'offset:', offset);
  const fileStart = dataStart + offset;
  console.log('Exact byte location in asar:', fileStart, 'to', fileStart + size);
  const data = asar.slice(fileStart, fileStart + size);
  console.log('Data length:', data.length);
  console.log('Data text (base64):', data.toString('utf8').slice(0, 100));
}
