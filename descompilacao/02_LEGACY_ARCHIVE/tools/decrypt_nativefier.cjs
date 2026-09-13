const crypto = require('crypto');
const fs = require('fs');
const path = require('path');

const base = path.join('D:', 'naruto Online', 'official_client', 'resources', 'app_extracted');
const encrypted = fs.readFileSync(path.join(base, 'nativefier.json'), 'utf8');

// Try multiple potential RC4 keys
const keys = [
  'www.plaync100.net',
  'nativefier',
  'plaync100',
  'www.plaync100.net.exe',
  'plaync100.net',
  'Naruto',
  'naruto',
  'NarutoOnline',
];

for (const key of keys) {
  try {
    const decipher = crypto.createDecipheriv('rc4', Buffer.from(key), Buffer.alloc(0));
    const decrypted = Buffer.concat([decipher.update(Buffer.from(encrypted, 'base64')), decipher.final()]);
    const str = decrypted.toString('utf8');
    // Check if it looks like valid JSON
    if (str.includes('{') && str.includes('targetUrl')) {
      console.log('SUCCESS with key: "' + key + '"');
      console.log(str);
      process.exit(0);
    } else if (str.charAt(0) === '{') {
      console.log('Possible match with key "' + key + '":');
      console.log(str.slice(0, 300));
    }
  } catch(e) {
    console.log('Key "' + key + '" error:', e.message);
  }
}

console.log('None of the simple keys worked. Analyzing lpt1.js for the actual key...');

// Read the obfuscated code and try to extract the key
const lpt1 = fs.readFileSync(path.join(base, 'lib', 'lpt1.js'), 'utf8');
// The structure is: createDecipheriv('rc4', KEY, '')  then update(nativefier_content, 'base64') then parse
// The key is likely computed from the RSA pub key or from a constant in the code

// Try the RSA public key content as key
const pubKey = fs.readFileSync(path.join(base, 'lib', 'static', 'pub.key'), 'utf8');
const pubKeyRaw = pubKey.replace(/-----.*-----/g, '').replace(/[\r\n]/g, '');
try {
  const decipher = crypto.createDecipheriv('rc4', Buffer.from(pubKeyRaw, 'base64'), Buffer.alloc(0));
  const decrypted = Buffer.concat([decipher.update(Buffer.from(encrypted, 'base64')), decipher.final()]);
  const str = decrypted.toString('utf8');
  if (str.charAt(0) === '{') {
    console.log('SUCCESS with pub.key as RC4 key:');
    console.log(str);
  }
} catch(e) {
  console.log('pub.key as RC4 key error:', e.message);
}
