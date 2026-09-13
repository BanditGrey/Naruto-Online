const fs = require('fs');
const code = fs.readFileSync('D:\\naruto Online\\official_client\\resources\\app_extracted\\lib\\lpt1.unpacked.js', 'utf8');

// Find function M(
const idx = code.indexOf('function M(');
console.log('function M( at', idx);
if (idx > -1) {
  console.log(code.slice(idx, idx + 1500));
}
