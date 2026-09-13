const fs = require('fs');
const zlib = require('zlib');

const filePath = 'C:/Users/Daniel/Desktop/naruto online/00AAE601~3.TexClient';
const buf = fs.readFileSync(filePath);

let offset = 0;
const id = buf.readUInt32LE(offset); offset += 4;
const texDataLen = buf.readUInt32LE(offset); offset += 4;
const texData = buf.subarray(offset, offset + texDataLen);
offset += texDataLen;
const decoderCount = buf.readUInt16LE(offset); offset += 2;

console.log('Neji TexClient: ID=' + id + ', decoderCount=' + decoderCount);

for (let d = 0; d < decoderCount; d++) {
  const pakLen = buf.readUInt32LE(offset); offset += 4;
  const pakRaw = buf.subarray(offset, offset + pakLen);
  offset += pakLen;
  const pakUncompressed = zlib.inflateSync(pakRaw);
  let poff = 0;
  const pType = pakUncompressed.readInt8(poff); poff += 1;
  const pWidth = pakUncompressed.readUInt16BE(poff); poff += 2;
  const pHeight = pakUncompressed.readUInt16BE(poff); poff += 2;
  const pQuality = pakUncompressed.readInt8(poff); poff += 1;
  const pAlphaQuality = pakUncompressed.readInt8(poff); poff += 1;
  const pAlphaFilter = pakUncompressed.readInt8(poff); poff += 1;
  const pLen = pakUncompressed.readUInt16BE(poff); poff += 2;
  console.log('Pak ' + d + ': w=' + pWidth + ', h=' + pHeight + ', quality=' + pQuality + ', alphaQ=' + pAlphaQuality + ', alphaFilter=' + pAlphaFilter + ', slices=' + pLen);
  
  const slices = [];
  for (let i = 0; i < pLen; i++) {
    const ox = pakUncompressed.readInt16BE(poff); poff += 2;
    const oy = pakUncompressed.readInt16BE(poff); poff += 2;
    const sw = pakUncompressed.readInt16BE(poff); poff += 2;
    const sh = pakUncompressed.readInt16BE(poff); poff += 2;
    slices.push({ ox, oy, sw, sh });
  }
  const imgDataLen = pakUncompressed.readUInt32BE(poff); poff += 4;
  console.log('Pak ' + d + ' imgDataLen=' + imgDataLen + ', magic=' + pakUncompressed.subarray(poff, poff + 4).toString('hex'));
  poff += imgDataLen;

  let hasAlpha = false;
  if (pAlphaQuality !== 0 && pQuality !== pAlphaQuality) {
    const alphaLen = pakUncompressed.readUInt32BE(poff); poff += 4;
    console.log('Pak ' + d + ' alphaLen=' + alphaLen + ', magic=' + pakUncompressed.subarray(poff, poff + 4).toString('hex'));
    hasAlpha = true;
  }
}
