const fs = require('fs');
const zlib = require('zlib');
const sharp = require('sharp');
const path = require('path');

const srcDir = 'C:/Users/Daniel/Desktop/naruto online';
const outBase = 'D:/naruto Online/client/public/assets/animated';

async function extractOne(fileName, charName) {
  const fullPath = path.join(srcDir, fileName);
  const buf = fs.readFileSync(fullPath);
  let offset = 0;
  const id = buf.readUInt32LE(offset); offset += 4;
  const texDataLen = buf.readUInt32LE(offset); offset += 4;
  const texData = buf.subarray(offset, offset + texDataLen);
  offset += texDataLen;
  const decoderCount = buf.readUInt16LE(offset); offset += 2;

  const targetDir = path.join(outBase, charName);
  fs.mkdirSync(targetDir, { recursive: true });

  for (let d = 0; d < decoderCount; d++) {
    const pakLen = buf.readUInt32LE(offset); offset += 4;
    const pakRaw = buf.subarray(offset, offset + pakLen);
    offset += pakLen;

    if (d !== 0 && d !== 5) continue;

    const pakUncompressed = zlib.inflateSync(pakRaw);
    let poff = 0;
    const pType = pakUncompressed.readInt8(poff); poff += 1;
    const pWidth = pakUncompressed.readUInt16BE(poff); poff += 2;
    const pHeight = pakUncompressed.readUInt16BE(poff); poff += 2;
    const pQuality = pakUncompressed.readInt8(poff); poff += 1;
    const pAlphaQuality = pakUncompressed.readInt8(poff); poff += 1;
    const pAlphaFilter = pakUncompressed.readInt8(poff); poff += 1;
    const pLen = pakUncompressed.readUInt16BE(poff); poff += 2;

    const slices = [];
    for (let i = 0; i < pLen; i++) {
      const ox = pakUncompressed.readInt16BE(poff); poff += 2;
      const oy = pakUncompressed.readInt16BE(poff); poff += 2;
      const sw = pakUncompressed.readInt16BE(poff); poff += 2;
      const sh = pakUncompressed.readInt16BE(poff); poff += 2;
      slices.push({ ox: ox, oy: oy, sw: sw, sh: sh });
    }
    const imgDataLen = pakUncompressed.readUInt32BE(poff); poff += 4;
    const imgBuf = pakUncompressed.subarray(poff, poff + imgDataLen);
    poff += imgDataLen;

    let alphaBuf = null;
    if (pAlphaQuality !== 0 && pQuality !== pAlphaQuality) {
      const alphaLen = pakUncompressed.readUInt32BE(poff); poff += 4;
      alphaBuf = pakUncompressed.subarray(poff, poff + alphaLen);
      poff += alphaLen;
    }

    const { data: rawRgb, info: rgbInfo } = await sharp(imgBuf).raw().toBuffer({ resolveWithObject: true });
    let rawAlpha = null;
    let alphaInfo = null;
    if (alphaBuf) {
      const res = await sharp(alphaBuf).raw().toBuffer({ resolveWithObject: true });
      rawAlpha = res.data;
      alphaInfo = res.info;
    }

    const animKey = (d === 0) ? 'idle' : 'run';

    let curX = 0;
    for (let s = 0; s < slices.length; s++) {
      const sl = slices[s];
      const sw = sl.sw > 0 ? sl.sw : 1;
      const sh = sl.sh > 0 ? sl.sh : 1;
      const frameRgba = Buffer.alloc(sw * sh * 4);

      for (let y = 0; y < sh; y++) {
        for (let x = 0; x < sw; x++) {
          const stripIdx = ((y * rgbInfo.width) + (curX + x));
          const dstIdx = (y * sw + x) * 4;
          frameRgba[dstIdx + 0] = rawRgb[stripIdx * 3 + 0];
          frameRgba[dstIdx + 1] = rawRgb[stripIdx * 3 + 1];
          frameRgba[dstIdx + 2] = rawRgb[stripIdx * 3 + 2];
          if (rawAlpha) {
            frameRgba[dstIdx + 3] = rawAlpha[stripIdx * alphaInfo.channels + 0];
          } else {
            const alphaStripIdx = (((Math.floor(rgbInfo.height / 2) + y) * rgbInfo.width) + (curX + x));
            frameRgba[dstIdx + 3] = rawRgb[alphaStripIdx * 3 + 0];
          }
        }
      }

      const outFileName = animKey + '_' + s + '.png';
      await sharp(frameRgba, { raw: { width: sw, height: sh, channels: 4 } })
        .png()
        .toFile(path.join(targetDir, outFileName));
      curX += sw;
    }
  }
}

extractOne('00AB0D18~1.TexClient', 'naruto_base').then(() => console.log('Extracted naruto_base'));
