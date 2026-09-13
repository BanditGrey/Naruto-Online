const fs = require('fs');
const path = require('path');
const dir = 'descompilacao/02_LEGACY_ARCHIVE/decompiled/texclient';
if (fs.existsSync(dir)) {
  const files = fs.readdirSync(dir);
  for (const f of files) {
    try {
      const full = path.join(dir, f);
      const buf = fs.readFileSync(full);
      const id = buf.readUInt32LE(0);
      const texLen = buf.readUInt32LE(4);
      const decoders = buf.readUInt16LE(8 + texLen);
      if ((id >= 11100000 && id <= 11100200) || (id >= 11110000 && id <= 11110200) || (id >= 11200000 && id <= 11220000)) {
        console.log(`${f} -> ID: ${id} (0x${id.toString(16)}), decoders: ${decoders}, size: ${buf.length}`);
      }
    } catch(e) {}
  }
}
