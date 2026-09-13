const fs = require('fs');
const path = require('path');

const asarPath = path.join('D:', 'naruto Online', 'official_client', 'resources', 'app.asar');
const asarBuf = fs.readFileSync(asarPath);

// Target string in error.html
const oldStr = 'https://www.plaync100.net';
const newStr = 'http://127.0.0.1:5173    '; // exact 26 chars!

console.log('oldStr length:', oldStr.length);
console.log('newStr length:', newStr.length);

let count = 0;
let offset = 0;
while ((offset = asarBuf.indexOf(oldStr, offset)) !== -1) {
  console.log(`Found "${oldStr}" at offset ${offset}`);
  // Replace in place
  asarBuf.write(newStr, offset, newStr.length, 'utf8');
  offset += newStr.length;
  count++;
}

console.log(`Replaced ${count} occurrences.`);
fs.writeFileSync(asarPath, asarBuf);
console.log('Saved app.asar successfully! File size:', fs.statSync(asarPath).size);
