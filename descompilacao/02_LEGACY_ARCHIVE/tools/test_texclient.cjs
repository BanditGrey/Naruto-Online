const fs = require('fs');
const zlib = require('zlib');

const filePath = 'C:/Users/Daniel/Desktop/naruto online/01513823.TexClient';
const buf = fs.readFileSync(filePath);
console.log('Total file size:', buf.length);

let offset = 0;
const id = buf.readUInt32LE(offset); offset += 4;
console.log('ID:', id, '0x' + id.toString(16));

const texDataLen = buf.readUInt32LE(offset); offset += 4;
console.log('TexDataLen:', texDataLen);
const texData = buf.subarray(offset, offset + texDataLen);
offset += texDataLen;

const decoderCount = buf.readUInt16LE(offset); offset += 2;
console.log('DecoderCount:', decoderCount);

for (let d = 0; d < decoderCount; d++) {
  const pakLen = buf.readUInt32LE(offset); offset += 4;
  console.log('Pak ' + d + ' length:', pakLen);
  const pakRaw = buf.subarray(offset, offset + pakLen);
  offset += pakLen;
  
  const pakUncompressed = zlib.inflateSync(pakRaw);
  console.log('Pak ' + d + ' uncompressed size:', pakUncompressed.length);
  
  let poff = 0;
  const pType = pakUncompressed.readInt8(poff); poff += 1;
  const pWidth = pakUncompressed.readUInt16BE(poff); poff += 2;
  const pHeight = pakUncompressed.readUInt16BE(poff); poff += 2;
  const pQuality = pakUncompressed.readInt8(poff); poff += 1;
  const pAlphaQuality = pakUncompressed.readInt8(poff); poff += 1;
  const pAlphaFilter = pakUncompressed.readInt8(poff); poff += 1;
  const pLen = pakUncompressed.readUInt16BE(poff); poff += 2;
  
  console.log('Pak ' + d + ' metadata: type=' + pType + ', w=' + pWidth + ', h=' + pHeight + ', quality=' + pQuality + ', alphaQ=' + pAlphaQuality + ', alphaFilter=' + pAlphaFilter + ', frames=' + pLen);
  
  const slices = [];
  if (pType === 1) {
    for (let i = 0; i < pLen; i++) {
      const ox = pakUncompressed.readInt16BE(poff); poff += 2;
      const oy = pakUncompressed.readInt16BE(poff); poff += 2;
      const sw = pakUncompressed.readInt16BE(poff); poff += 2;
      const sh = pakUncompressed.readInt16BE(poff); poff += 2;
      slices.push({ ox, oy, sw, sh });
    }
    console.log('Slices:', slices);
    const imgDataLen = pakUncompressed.readUInt32BE(poff); poff += 4;
    console.log('Pak ' + d + ' imgDataLen: ' + imgDataLen + ', poff: ' + poff);
    const magic = pakUncompressed.subarray(poff, poff + 4).toString('hex');
    console.log('Pak ' + d + ' image magic: ' + magic);
    
    // Save image to test
    const imgBuf = pakUncompressed.subarray(poff, poff + imgDataLen);
    fs.writeFileSync('tools/pak_' + d + '_img.dat', imgBuf);
    poff += imgDataLen;

    if (pAlphaQuality !== 0 && pQuality !== pAlphaQuality) {
      const alphaLen = pakUncompressed.readUInt32BE(poff); poff += 4;
      console.log('Pak ' + d + ' alphaLen: ' + alphaLen);
      if (alphaLen > 0) {
        const alphaBuf = pakUncompressed.subarray(poff, poff + alphaLen);
        fs.writeFileSync('tools/pak_' + d + '_alpha.dat', alphaBuf);
        poff += alphaLen;
      }
    }
  }
}

if (offset < buf.length) {
  const seqCount = buf.readUInt16LE(offset); offset += 2;
  console.log('SeqCount in stream:', seqCount, 'remaining bytes:', buf.length - offset);
}

let toff = 0;
console.log('TexData total length:', texData.length);
while (toff < texData.length) {
  const seqId = texData.readUInt32LE(toff); toff += 4;
  const seqProps = texData.readUInt8(toff); toff += 1;
  const frameCount = texData.readUInt16LE(toff); toff += 2;
  console.log('Sequence id=' + seqId + ', props=' + seqProps + ', frames=' + frameCount);
  for (let f = 0; f < frameCount; f++) {
    const bx = texData.readInt16LE(toff); toff += 2;
    const by = texData.readInt16LE(toff); toff += 2;
    const bw = texData.readUInt16LE(toff); toff += 2;
    const bh = texData.readUInt16LE(toff); toff += 2;
    const px = texData.readInt16LE(toff); toff += 2;
    const py = texData.readInt16LE(toff); toff += 2;
    const dur = texData.readUInt16LE(toff); toff += 2;
    if (f === 0) console.log('   Frame 0: bounds=(' + bx + ',' + by + ',' + bw + ',' + bh + ') pivot=(' + px + ',' + py + ') dur=' + dur);
  }
}
