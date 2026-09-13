const fs = require('fs');
const zlib = require('zlib');
const sharp = require('sharp');
const path = require('path');

const srcDir = 'C:/Users/Daniel/Desktop/naruto online';
const outBase = 'D:/naruto Online/client/public/assets/animated';

async function extractTex(fileName, subFolder, pakIndices = [0]) {
  const fullPath = path.join(srcDir, fileName);
  if (!fs.existsSync(fullPath)) return;
  const buf = fs.readFileSync(fullPath);
  let offset = 0;
  const id = buf.readUInt32LE(offset); offset += 4;
  const texDataLen = buf.readUInt32LE(offset); offset += 4;
  const texData = buf.subarray(offset, offset + texDataLen);
  offset += texDataLen;
  const decoderCount = buf.readUInt16LE(offset); offset += 2;

  const targetDir = path.join(outBase, subFolder);
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

      frames.push('/assets/animated/' + subFolder + '/' + outFileName);
      curX += sw;
    }

    metadata.animations[animKey] = {
      frameCount: slices.length,
      frames: frames
    };
    console.log('Saved ' + subFolder + ' ' + animKey + ' (' + slices.length + ' frames)');
  }

  fs.writeFileSync(path.join(targetDir, 'meta.json'), JSON.stringify(metadata, null, 2));
}

async function run() {
  console.log('Extracting NPCs...');
  await extractTex('01513823~1.TexClient', 'npcs/hokage3', [0]);
  await extractTex('01513824.TexClient', 'npcs/iruka', [0]);
  await extractTex('01513825~1.TexClient', 'npcs/kakashi', [0]);
  await extractTex('01513826.TexClient', 'npcs/naruto', [0]);
  await extractTex('01513827~1.TexClient', 'npcs/sasuke', [0]);
  await extractTex('01513828.TexClient', 'npcs/ibiki', [0]);
  await extractTex('01513829.TexClient', 'npcs/anko', [0]);
  await extractTex('0151382A~1.TexClient', 'npcs/hayate', [0]);
  await extractTex('0151382C~1.TexClient', 'npcs/gaara', [0]);
  await extractTex('0151382E.TexClient', 'npcs/konohamaru', [0]);
  await extractTex('01513821.TexClient', 'npcs/city_gate', [0]);

  console.log('Extracting Heroes...');
  await extractTex('00A95FC5.TexClient', 'heroes/hero_taijutsu_m', [0, 5]);
  await extractTex('00A95FC6~2.TexClient', 'heroes/hero_taijutsu_f', [0, 5]);
  await extractTex('00A95F64~1.TexClient', 'heroes/hero_ninjutsu_f', [0, 5]);
  await extractTex('00A95F65.TexClient', 'heroes/hero_genjutsu_m', [0, 5]);
  await extractTex('00AB0D14.TexClient', 'heroes/hero_ninjutsu_m', [0, 5]);
  await extractTex('00AB0D16~1.TexClient', 'heroes/hero_genjutsu_f', [0, 5]);

  console.log('Extraction complete!');
}

run().catch(console.error);
