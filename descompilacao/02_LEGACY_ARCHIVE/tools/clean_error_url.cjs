const fs = require('fs');
const path = require('path');

const asarPath = path.join('D:', 'naruto Online', 'official_client', 'resources', 'app.asar');
const asarBuf = fs.readFileSync(asarPath);

const oldChunk = 'const url = "http://127.0.0.1:5173    ";';
const newChunk = 'const url = "http://127.0.0.1:5173";/**/';

console.log('oldChunk length:', oldChunk.length);
console.log('newChunk length:', newChunk.length);

const offset = asarBuf.indexOf(oldChunk);
if (offset !== -1) {
  console.log(`Patching at offset ${offset}`);
  asarBuf.write(newChunk, offset, newChunk.length, 'utf8');
  fs.writeFileSync(asarPath, asarBuf);
  console.log('Successfully written clean URL with comment padding!');
} else {
  console.log('Chunk not found');
}
