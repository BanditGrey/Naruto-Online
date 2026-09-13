const fs = require('fs');
const code = fs.readFileSync('D:\\naruto Online\\official_client\\resources\\app_extracted\\lib\\lpt1.unpacked.js', 'utf8');

let idx = -1;
while ((idx = code.indexOf('sCwVj', idx + 1)) !== -1) {
  console.log('sCwVj at', idx);
  console.log(code.slice(idx - 100, idx + 400));
}
