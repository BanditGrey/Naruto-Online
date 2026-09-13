const fs = require('fs');
const code = fs.readFileSync('D:\\naruto Online\\official_client\\resources\\app_extracted\\lib\\lpt1.unpacked.js', 'utf8');

// Let's print from index of 'loadURL'
let idx = code.indexOf('loadURL');
while (idx !== -1) {
  console.log('--- loadURL at', idx, '---');
  console.log(code.slice(idx - 150, idx + 200).replace(/\n/g, ' '));
  idx = code.indexOf('loadURL', idx + 1);
}
