const fs = require('fs');
const code = fs.readFileSync('D:\\naruto Online\\official_client\\resources\\app_extracted\\lib\\lpt1.unpacked.js', 'utf8');

// Find new l(
let idx = -1;
while ((idx = code.indexOf('new l(', idx + 1)) !== -1) {
  console.log('new l( at', idx);
  console.log(code.slice(idx - 100, idx + 400));
}
