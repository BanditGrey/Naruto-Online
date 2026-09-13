const fs = require('fs');
const path = require('path');

const swfPath = 'D:/naruto Online/decompiled/swfs/TApplication_uncomp.swf';
const outRawPath = 'D:/naruto Online/decompiled/swfs/TApplication_patched_raw.swf';

const originalHex = 'd030208019d62080ec01d7d166ab0a8019d6d066ea70d2d066f970204fa3d00103d066ea70d2d066f97066d913204fa6d00103d066f97046aa4c0080ec01d7d066ef7020d066fa70204f864303d320130b0000d3d066f97066e64b61e512d066ea70d2d066f97066e94b204fa8d00103d066ea70d220204fa9d00103d02761de0860f60a60abab044fca140147';
const origBuf = Buffer.from(originalHex, 'hex');

const part1 = 'd030208019d62080ec01d7d166ab0a8019d6d066ea70d2d066f970204fa3d00103d066ea70d2d066f97066d913204fa6d00103d066f97046aa4c0080ec01d7';
const part2 = 'd320130b0000d3d066f97066e64b61e512';
// d02761de08 (Visible=false) + d04fae7200 (ProcessorCreateRole) + d04fb77200 (ProcessorCloseSocketLoading) + d04fb07200 (ProcessorOnEnterTown) + d04fb17100 (ProcessorOnInitRequests) + 47 (returnvoid)
const part3 = 'd02761de08d04fae7200d04fb77200d04fb07200d04fb1710047';
const newHex = part1 + part2 + part3;
const newBuf = Buffer.from(newHex, 'hex');

const padNeeded = origBuf.length - newBuf.length;
const paddedNewBuf = Buffer.concat([newBuf, Buffer.alloc(padNeeded, 0x02)]);

const swf = fs.readFileSync(swfPath);
const offset = swf.indexOf(origBuf);

if (offset === -1) {
  console.error('Target original bytecode not found in uncompressed SWF!');
  process.exit(1);
}

console.log(`Found target bytecode at offset ${offset} (0x${offset.toString(16)})`);
paddedNewBuf.copy(swf, offset);

fs.writeFileSync(outRawPath, swf);
console.log('Saved patched uncompressed SWF to:', outRawPath);
