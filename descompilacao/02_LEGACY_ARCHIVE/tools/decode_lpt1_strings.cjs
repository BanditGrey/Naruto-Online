const fs = require('fs');
const vm = require('vm');

const code = fs.readFileSync('D:\\naruto Online\\official_client\\resources\\app_extracted\\lib\\lpt1.unpacked.js', 'utf8');

// The file has a self-executing function. Let's find the dictionary a0e and decoder a0f.
// In obfuscated code, a0e returns the array, a0f decodes using RC4 or table.
// Let's create a sandbox that defines a0e, a0f, ar, ay.
const ayPos = code.indexOf('function ay(');
const setupCode = code.slice(0, ayPos + 40); // includes function ay(a,b){return ar(a- -0x88,b)}

// Let's execute in vm
const sandbox = {
  console: console
};
vm.createContext(sandbox);

// Let's run up to line 15350
try {
  // Let's wrap so we can expose ar and ay
  const modified = code.slice(0, 15350) + '\nglobalThis.ay = ay;\nglobalThis.ar = ar;\n';
  vm.runInContext(modified, sandbox);
  console.log('ay and ar exposed successfully!');
} catch (e) {
  console.log('Error executing setup:', e.message);
}
