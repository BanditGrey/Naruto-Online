const fs = require('fs');
const code = fs.readFileSync('D:\\naruto Online\\official_client\\resources\\app_extracted\\lib\\lpt1.unpacked.js', 'utf8');

const readyIdx = code.indexOf("'ready'");
console.log('ready at:', readyIdx);
if (readyIdx > -1) {
  console.log(code.slice(readyIdx - 100, readyIdx + 1200));
}
