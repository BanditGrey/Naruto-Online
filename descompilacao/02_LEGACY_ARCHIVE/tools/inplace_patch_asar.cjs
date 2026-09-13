const fs = require('fs');
const path = require('path');
const crypto = require('crypto');

function rc4(key, input) {
  let s = [];
  for (let i = 0; i < 256; i++) s[i] = i;
  let j = 0;
  for (let i = 0; i < 256; i++) {
    j = (j + s[i] + key.charCodeAt(i % key.length)) % 256;
    let temp = s[i]; s[i] = s[j]; s[j] = temp;
  }
  let i = 0; j = 0;
  let res = Buffer.alloc(input.length);
  for (let y = 0; y < input.length; y++) {
    i = (i + 1) % 256;
    j = (j + s[i]) % 256;
    let temp = s[i]; s[i] = s[j]; s[j] = temp;
    res[y] = input[y] ^ s[(s[i] + s[j]) % 256];
  }
  return res;
}

const asarPath = path.join('D:', 'naruto Online', 'official_client', 'resources', 'app.asar');
const bakPath = path.join('D:', 'naruto Online', 'official_client', 'resources', 'app.asar.bak');

const asarBuf = Buffer.from(fs.readFileSync(bakPath));

const TARGET_PLAIN_LEN = 1275;
const TARGET_B64_LEN = 1700;
const OFFSET = 882483;

// Extract exact original ciphertext and plaintext
const originalB64 = asarBuf.slice(OFFSET, OFFSET + TARGET_B64_LEN).toString('utf8');
const originalCipher = Buffer.from(originalB64, 'base64');
let plain = rc4('nativefier.json', originalCipher).toString('utf8');

console.log('Original plaintext length:', plain.length);

const targetUrl = 'http://127.0.0.1:8080';
const newUid = crypto.createHash('md5').update(targetUrl).digest('hex');
console.log('Computed MD5 UID for targetUrl:', newUid);

// 1. Replace targetUrl
plain = plain.replace('https://www.plaync100.net', targetUrl);

// 2. Replace uid with MD5(targetUrl)
plain = plain.replace('c4fde3281a0bfae85c60090595ef6c76', newUid);

// 3. Replace disableDevTool: "true" -> "false"
plain = plain.replace('"disableDevTool":"true"', '"disableDevTool":"false"');

// 4. Replace resizable: "false" -> "true"
plain = plain.replace('"resizable":"false"', '"resizable":"true"');

// 5. Replace errorPage: "true" -> "false"
plain = plain.replace('"errorPage": "true"', '"errorPage": "false"');

// 6. Replace disableCache: "false" -> "true"
plain = plain.replace('"disableCache":"false"', '"disableCache": "true"');

console.log('Modified length before compensation:', plain.length);

// Difference to reach exactly TARGET_PLAIN_LEN
const diff = TARGET_PLAIN_LEN - plain.length;
console.log('Characters to compensate:', diff);

// Compensate by adding spaces into "name":""
if (diff > 0) {
  plain = plain.replace('"name":""', '"name":"' + ' '.repeat(diff) + '"');
}

console.log('Final plaintext length:', plain.length, 'Target:', TARGET_PLAIN_LEN);

// Verify parseable JSON and verify MD5 check!
const parsed = JSON.parse(plain.trim());
console.log('\n--- VERIFICATION OF SECURITY CHECKS ---');
console.log('targetUrl:', parsed.targetUrl);
console.log('uid:      ', parsed.uid);
const checkHash = crypto.createHash('md5').update(parsed.targetUrl).digest('hex');
console.log('MD5 check:', checkHash === parsed.uid ? 'PASS (IDENTICAL!)' : 'FAIL!');

if (checkHash !== parsed.uid) {
  throw new Error('MD5 check failed!');
}

// Encrypt back
const newCipher = rc4('nativefier.json', Buffer.from(plain, 'utf8'));
const newB64 = newCipher.toString('base64');

console.log('New base64 length:', newB64.length, 'Target:', TARGET_B64_LEN);
if (newB64.length !== TARGET_B64_LEN) {
  throw new Error(`Length mismatch! Expected ${TARGET_B64_LEN}, got ${newB64.length}`);
}

// Write in-place into asarBuf
asarBuf.write(newB64, OFFSET, TARGET_B64_LEN, 'utf8');

// Ensure the total size is unchanged
console.log('Final asarBuf size:', asarBuf.length, '(must be 884205)');

fs.writeFileSync(asarPath, asarBuf);
console.log('\n[SUCCESS] Successfully written in-place patch to app.asar!');
