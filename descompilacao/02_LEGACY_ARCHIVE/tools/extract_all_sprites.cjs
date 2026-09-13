const fs = require('fs');
const zlib = require('zlib');
const sharp = require('sharp');
const path = require('path');

const srcDir = 'C:/Users/Daniel/Desktop/naruto online';
const outBase = 'D:/naruto Online/client/public/assets/animated';

async function extractTexClient(fileName, charName, pakIndices = [0]) {
  const fullPath = path.join(srcDir, fileName);
  if (!fs.existsSync(fullPath)) {
    console.warn('File not found: ' + fullPath);
    return;
  }
  const buf = fs.readFileSync(fullPath);
  let offset = 0;
  const id = buf.readUInt32LE(offset); offset += 4;
  const texDataLen = buf.readUInt32LE(offset); offset += 4;
  const texData = buf.subarray(offset, offset + texDataLen);
  offset += texDataLen;
  const decoderCount = buf.readUInt16LE(offset); offset += 2;

  const targetDir = path.join(outBase, charName);
  fs.mkdirSync(targetDir, { recursive: true });

  const metadata = { id: id, animations: {} };

  for (let d = 0; d < decoderCount; d++) {
    const pakLen = buf.readUInt32LE(offset); offset += 4;
    const pakRaw = buf.subarray(offset, offset + pakLen);
    offset += pakLen;

    if (!pakIndices.includes(d)) continue;

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

    const animKey = (d === 0) ? 'idle' : ((d === 5) ? 'run' : ('anim_' + d));
    const frames = [];

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

      frames.push('/assets/animated/' + charName + '/' + outFileName);
      curX += sw;
    }

    metadata.animations[animKey] = {
      frameCount: slices.length,
      frames: frames
    };
    console.log('Extracted ' + charName + ' ' + animKey + ': ' + slices.length + ' frames');
  }

  fs.writeFileSync(path.join(targetDir, 'meta.json'), JSON.stringify(metadata, null, 2));
}

async function run() {
  await extractTexClient('01513823~1.TexClient', 'hokage3', [0]);
  await extractTexClient('01513824.TexClient', 'iruka', [0]);
  await extractTexClient('01513825~1.TexClient', 'kakashi', [0]);
  await extractTexClient('01513826.TexClient', 'naruto', [0]);
  await extractTexClient('01513827~1.TexClient', 'sasuke', [0]);
  await extractTexClient('01513828.TexClient', 'sakura', [0]);
  await extractTexClient('01513829.TexClient', 'rock_lee', [0]);
  await extractTexClient('0151382A~1.TexClient', 'neji', [0]);
  await extractTexClient('0151382E.TexClient', 'hinata', [0]);
  await extractTexClient('01513821.TexClient', 'city_gate', [0]);
  
  // Players (Idle and Run)
  await extractTexClient('00A95FC5.TexClient', 'hero_taijutsu_m', [0, 5]);
  await extractTexClient('00A95FC6~2.TexClient', 'hero_taijutsu_f', [0, 5]);
  await extractTexClient('00A95F64~1.TexClient', 'hero_ninjutsu_f', [0, 5]);
  await extractTexClient('00A95F65.TexClient', 'hero_genjutsu_m', [0, 5]);
  await extractTexClient('00AB0D14.TexClient', 'hero_ninjutsu_m', [0, 5]);
  await extractTexClient('00AB0D16~1.TexClient', 'hero_genjutsu_f', [0, 5]);
  console.log('ALL SPRITES EXTRACTED SUCCESSFULLY!');
}

run().catch(console.error);
