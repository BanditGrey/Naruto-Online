const fs = require('fs');
const vm = require('vm');

const code = fs.readFileSync('D:\\naruto Online\\official_client\\resources\\app_extracted\\lib\\lpt1.unpacked.js', 'utf8');

const endOfA0f = code.indexOf('function ar(');
const setupCode = code.slice(0, endOfA0f);

const sandbox = {};
vm.createContext(sandbox);
vm.runInContext(setupCode + '; globalThis.a0f = a0f;', sandbox);

function bh(a, b) {
  const ayVal = a + 0x4e1;
  const arVal = ayVal + 0x88;
  const a0fVal = arVal - 0x1f7;
  return sandbox.a0f(a0fVal, b);
}

try {
  console.log('bh(-0xaa, "S%E@") =', bh(-0xaa, 'S%E@'));
  console.log('bh(-0x16b, "Gnt$") =', bh(-0x16b, 'Gnt$'));
  console.log('bh(-0x167, "h!H!") =', bh(-0x167, 'h!H!'));
  console.log('bh(-0xa9, "WIss") =', bh(-0xa9, 'WIss'));
  console.log('bh(-0xa7, "AT&9") =', bh(-0xa7, 'AT&9'));
  console.log('bh(-0x15e, "br%K") =', bh(-0x15e, 'br%K'));
  console.log('bh(-0xdb, "rb!!") =', bh(-0xdb, 'rb!!'));
  console.log('bh(-0x9b, "@M)8") =', bh(-0x9b, '@M)8'));
  console.log('bh(-0xed, "VStH") =', bh(-0xed, 'VStH'));
  console.log('bh(-0xa6, "8E!S") =', bh(-0xa6, '8E!S'));
  console.log('bh(-0x19c, "$Lip") =', bh(-0x19c, '$Lip'));
} catch (e) {
  console.log('Error decoding:', e.message);
}
