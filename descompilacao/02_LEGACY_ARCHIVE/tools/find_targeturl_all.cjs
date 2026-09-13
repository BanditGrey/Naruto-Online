const fs = require('fs');
const code = fs.readFileSync('D:\\naruto Online\\official_client\\resources\\app_extracted\\lib\\lpt1.unpacked.js', 'utf8');

let idx = -1;
while ((idx = code.indexOf("targetUrl", idx + 1)) !== -1) {
  console.log('--- targetUrl at', idx, '---');
  console.log(code.slice(Math.max(0, idx - 80), idx + 250).replace(/\n/g, ' '));
}
