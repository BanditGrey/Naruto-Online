const fs = require('fs');
const code = fs.readFileSync('D:\\naruto Online\\official_client\\resources\\app_extracted\\lib\\lpt1.unpacked.js', 'utf8');

const idx = code.indexOf('function N(P)');
console.log('function N(P) at', idx);
console.log(code.slice(idx, idx + 2500));
