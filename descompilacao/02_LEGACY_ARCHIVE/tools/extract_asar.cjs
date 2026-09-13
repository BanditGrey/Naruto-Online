const fs = require('fs');
const path = require('path');

const asarPath = path.join('D:', 'naruto Online', 'official_client', 'resources', 'app.asar');
const outDir = path.join('D:', 'naruto Online', 'official_client', 'resources', 'app_extracted');
fs.mkdirSync(outDir, { recursive: true });

const asar = fs.readFileSync(asarPath);

// Parse header
const headerJsonSize = asar.readUInt32LE(12);
const jsonStr = asar.slice(16, 16 + headerJsonSize).toString('utf8');

let braceCount = 0, jsonEnd = -1;
for (let i = 0; i < jsonStr.length; i++) {
  if (jsonStr[i] === '{') braceCount++;
  if (jsonStr[i] === '}') braceCount--;
  if (braceCount === 0) { jsonEnd = i; break; }
}
const header = JSON.parse(jsonStr.slice(0, jsonEnd + 1));
const headerTotalSize = 8 + asar.readUInt32LE(4);

function extractFiles(filesObj, currentDir, depth) {
  for (const [name, info] of Object.entries(filesObj)) {
    // Skip fake/obfuscated entries (hex-only names with no extension, or names > 60 chars)
    if (name.length > 60) continue;
    if (!name.includes('.') && /^[0-9a-f]+$/i.test(name) && name.length > 10) continue;
    
    const outPath = path.join(currentDir, name);
    
    if (info.files) {
      fs.mkdirSync(outPath, { recursive: true });
      extractFiles(info.files, outPath, depth + 1);
    } else if (info.offset !== undefined) {
      const offset = headerTotalSize + parseInt(info.offset, 10);
      const size = info.size;
      if (size > 10 * 1024 * 1024) {
        console.log('SKIP (too large):', name, size);
        continue;
      }
      if (offset + size <= asar.length) {
        fs.mkdirSync(path.dirname(outPath), { recursive: true });
        fs.writeFileSync(outPath, asar.slice(offset, offset + size));
        console.log('OK:', path.relative(outDir, outPath), `(${size} bytes)`);
      } else {
        console.log('SKIP (out of bounds):', name, size);
      }
    }
  }
}

extractFiles(header.files, outDir, 0);
console.log('\nExtraction complete!');
