const fs = require('fs');
const zlib = require('zlib');
const sharp = require('sharp');
const path = require('path');

const srcDir = 'C:/Users/Daniel/Desktop/naruto online';

async function testHero(file, name) {
  const buf = fs.readFileSync(path.join(srcDir, file));
  let offset = 0;
  const id = buf.readUInt32LE(offset); offset += 4;
  const texDataLen = buf.readUInt32LE(offset); offset += 4;
  offset += texDataLen;
  const decoderCount = buf.readUInt16LE(offset); offset += 2;
  const pakLen = buf.readUInt32LE(offset); offset += 4;
  const pakRaw = buf.subarray(offset, offset + pakLen);
  const pakUncompressed = zlib.inflateSync(pakRaw);
  let poff = 0;
  poff += 7; // type, w, h, q, aq, af
  const pLen = pakUncompressed.readUInt16BE(poff); poff += 2;
  const slices = [];
  for (let i = 0; i < pLen; i++) {
    slices.push({ ox: pakUncompressed.readInt16BE(poff), oy: pakUncompressed.readInt16BE(poff+2), sw: pakUncompressed.readInt16BE(poff+4), sh: pakUncompressed.readInt16BE(poff+6) });
    poff += 8;
  }
  const imgLen = pakUncompressed.readUInt32BE(poff); poff += 4;
  const imgBuf = pakUncompressed.subarray(poff, poff + imgLen);
  poff += imgLen;
  const alphaLen = pakUncompressed.readUInt32BE(poff); poff += 4;
  const alphaBuf = pakUncompressed.subarray(poff, poff + alphaLen);

  const { data: rawRgb, info: rgbInfo } = await sharp(imgBuf).raw().toBuffer({ resolveWithObject: true });
  const { data: rawAlpha, info: aInfo } = await sharp(alphaBuf).raw().toBuffer({ resolveWithObject: true });

  const sw = slices[0].sw;
  const sh = slices[0].sh;
  const frameRgba = Buffer.alloc(sw * sh * 4);
  for (let y = 0; y < sh; y++) {
    for (let x = 0; x < sw; x++) {
      const sIdx = (y * rgbInfo.width) + x;
      const dIdx = (y * sw + x) * 4;
      frameRgba[dIdx] = rawRgb[sIdx * 3];
      frameRgba[dIdx+1] = rawRgb[sIdx * 3 + 1];
      frameRgba[dIdx+2] = rawRgb[sIdx * 3 + 2];
      frameRgba[dIdx+3] = rawAlpha[sIdx * aInfo.channels];
    }
  }
  await sharp(frameRgba, { raw: { width: sw, height: sh, channels: 4 } }).png().toFile('tools/test_' + name + '.png');
  console.log('Saved tools/test_' + name + '.png (' + sw + 'x' + sh + ')');
}

testHero('00A98673~1.TexClient', 'hero_11110003').catch(console.error);
