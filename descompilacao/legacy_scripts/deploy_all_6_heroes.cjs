const fs = require('fs');
const path = require('path');
const zlib = require('zlib');
const sharp = require('sharp');

const clientBase = 'Client/public/assets/animated';
const cdnBase = 'descompilacao/01_VN_OFFICIAL_SOURCE/archive_vn/assets_cdn';

async function extractHero(texPath, heroName, heroId) {
  const buf = fs.readFileSync(texPath);
  let offset = 0;
  const id = buf.readUInt32LE(offset); offset += 4;
  const texLen = buf.readUInt32LE(offset); offset += 4;
  offset += texLen;
  const decoders = buf.readUInt16LE(offset); offset += 2;

  const targetDirs = [
    path.join(clientBase, heroName),
    path.join(clientBase, 'heroes', heroName)
  ];

  for (const d of targetDirs) {
    fs.mkdirSync(d, { recursive: true });
    // Clean old files in folder
    for (const f of fs.readdirSync(d)) {
      if (f.startsWith('idle_') || f.startsWith('run_') || f === 'meta.json') {
        fs.unlinkSync(path.join(d, f));
      }
    }
  }

  const metadata = {
    id: heroId,
    animations: {}
  };

  for (let d = 0; d < decoders; d++) {
    const pakLen = buf.readUInt32LE(offset); offset += 4;
    const pakRaw = buf.subarray(offset, offset + pakLen); offset += pakLen;
    if (d !== 0 && d !== 5) continue; // idle (0) and run (5)

    const pak = zlib.inflateSync(pakRaw);
    let poff = 0;
    const pType = pak.readInt8(poff); poff += 1;
    const pWidth = pak.readUInt16BE(poff); poff += 2;
    const pHeight = pak.readUInt16BE(poff); poff += 2;
    const pQuality = pak.readInt8(poff); poff += 1;
    const pAlphaQuality = pak.readInt8(poff); poff += 1;
    const pAlphaFilter = pak.readInt8(poff); poff += 1;
    const pLen = pak.readUInt16BE(poff); poff += 2;

    const slices = [];
    for (let i = 0; i < pLen; i++) {
      slices.push({
        ox: pak.readInt16BE(poff),
        oy: pak.readInt16BE(poff + 2),
        sw: pak.readInt16BE(poff + 4),
        sh: pak.readInt16BE(poff + 6)
      });
      poff += 8;
    }

    const imgDataLen = pak.readUInt32BE(poff); poff += 4;
    const imgBuf = pak.subarray(poff, poff + imgDataLen); poff += imgDataLen;

    let alphaBuf = null;
    if (pAlphaQuality !== 0 && pQuality !== pAlphaQuality) {
      const alphaLen = pak.readUInt32BE(poff); poff += 4;
      alphaBuf = pak.subarray(poff, poff + alphaLen); poff += alphaLen;
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
    const framePaths = [];

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

      const frameFile = `${animKey}_${s}.png`;
      const frameImg = await sharp(frameRgba, { raw: { width: sw, height: sh, channels: 4 } }).png().toBuffer();
      
      for (const d of targetDirs) {
        fs.writeFileSync(path.join(d, frameFile), frameImg);
      }

      framePaths.push(`/assets/animated/${heroName}/${frameFile}`);
      curX += sw;
    }

    metadata.animations[animKey] = {
      frameCount: slices.length,
      frames: framePaths
    };
    console.log(`✓ ${heroName} (${animKey}): ${slices.length} frames`);
  }

  for (const d of targetDirs) {
    fs.writeFileSync(path.join(d, 'meta.json'), JSON.stringify(metadata, null, 2));
  }
}

async function main() {
  console.log('=== EXTRAINDO OS 6 PROTAGONISTAS 100% ORIGINAIS DA CDN OFICIAL ===');
  await extractHero(path.join(cdnBase, '00A95F61.TexClient'), 'hero_taijutsu_m', 11100001);
  await extractHero(path.join(cdnBase, '00A95F62.TexClient'), 'hero_taijutsu_f', 11100002);
  await extractHero(path.join(cdnBase, '00A95F63.TexClient'), 'hero_ninjutsu_m', 11100003);
  await extractHero(path.join(cdnBase, '00A95F64.TexClient'), 'hero_ninjutsu_f', 11100004);
  await extractHero(path.join(cdnBase, '00A95F65.TexClient'), 'hero_genjutsu_m', 11100005);
  await extractHero(path.join(cdnBase, '00A95F66.TexClient'), 'hero_genjutsu_f', 11100006);
  console.log('=== TODOS OS 6 PROTAGONISTAS CANÔNICOS EXTRAÍDOS COM SUCESSO! ===');
}

main().catch(console.error);
