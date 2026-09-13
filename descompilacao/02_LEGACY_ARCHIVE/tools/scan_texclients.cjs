const fs = require('fs');
const path = require('path');

const dir = 'C:/Users/Daniel/Desktop/naruto online';
const files = fs.readdirSync(dir).filter(f => f.endsWith('.TexClient'));

console.log('Total TexClient files found:', files.length);

const animated = [];

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

    if (totalFrames > 1 || seqs.length > 1) {
      animated.push({ file: f, id, hex: '0x' + id.toString(16), decoderCount, seqs, totalFrames, size: buf.length });
    }
  } catch (e) {
  }
}

console.log('Total animated TexClient files:', animated.length);
animated.sort((a, b) => b.totalFrames - a.totalFrames);
console.log('Top 30 animated TexClients:');
for (const a of animated.slice(0, 30)) {
  console.log(a.file + ' (id: ' + a.id + ' / ' + a.hex + ', size: ' + a.size + '): seqs=' + a.seqs.length + ', totalFrames=' + a.totalFrames + ', detail=' + JSON.stringify(a.seqs));
}
