const fs = require('fs');
const path = require('path');

const dir = 'C:/Users/Daniel/Desktop/naruto online';
const files = fs.readdirSync(dir).filter(f => f.endsWith('.TexClient'));

const targets = [
  11100001, 11100002, 11100003, 11100004, 11100005, 11100006,
  11100101, 11100102, 11100103, 11100104, 11100105, 11100106,
  11210004, 11210006, 11210007, 11210008,
  22100001, 22100003, 22100004, 22100005, 22100006, 22100007, 22100008, 22100009, 22100010, 22100012, 22100014
];

for (const f of files) {
  try {
    const fullPath = path.join(dir, f);
    const buf = fs.readFileSync(fullPath);
    let offset = 0;
    const id = buf.readUInt32LE(offset); offset += 4;
    const texDataLen = buf.readUInt32LE(offset); offset += 4;
    const texData = buf.subarray(offset, offset + texDataLen);
    offset += texDataLen;
    const decoderCount = buf.readUInt16LE(offset); offset += 2;

    let toff = 0;
    let totalFrames = 0;
    let seqs = [];
    while (toff < texData.length) {
      const seqId = texData.readUInt32LE(toff); toff += 4;
      const seqProps = texData.readUInt8(toff); toff += 1;
      const frameCount = texData.readUInt16LE(toff); toff += 2;
      totalFrames += frameCount;
      seqs.push({ seqId, frameCount });
      toff += frameCount * 14;
    }

    if (targets.includes(id)) {
      console.log(f + ' -> ID: ' + id + ' (0x' + id.toString(16) + '), size: ' + buf.length + ', decoders: ' + decoderCount + ', seqs: ' + seqs.length + ', frames: ' + totalFrames);
    }
  } catch(e) {}
}
