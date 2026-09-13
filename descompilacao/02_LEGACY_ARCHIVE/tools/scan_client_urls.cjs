const fs = require('fs');
const path = require('path');
const base = path.join('D:', 'naruto Online', 'official_client', 'resources', 'app_extracted');

const content = fs.readFileSync(path.join(base, 'lib', 'localserver.js'), 'utf8');

// Look for nativefier and key patterns
const patterns = ['targetUrl', 'nativefier', 'mainWindow', 'BrowserWindow', 'loadURL', 
  'createServer', 'listen', 'localhost', 'plaync100', 'socket', 'XMLSocket',
  '127.0.0.1', '0.0.0.0', 'flash', 'pepper', 'ppapi', 'ppflash', 'cross-domain',
  'policy-file', 'loadFlash', 'swf', '.swf', 'index.swf', 'main.swf', 'loading',
  'electron', 'app.on', 'ready', 'webPreferences', 'plugins'];

patterns.forEach(pat => {
  let idx = -1;
  let found = 0;
  while ((idx = content.indexOf(pat, idx + 1)) !== -1 && found < 3) {
    console.log('Found "' + pat + '" at offset', idx);
    console.log('  Context: ...' + content.slice(Math.max(0, idx - 60), idx + 80).replace(/\n/g, ' ') + '...');
    console.log('');
    found++;
  }
});

// Also check preload.js
const preload = fs.readFileSync(path.join(base, 'lib', 'static', 'preload.js'), 'utf8');
console.log('=== preload.js patterns ===');
['targetUrl', 'BrowserWindow', 'loadURL', 'plaync100', 'flash', 'swf', 'socket', 'createServer'].forEach(pat => {
  const idx = preload.indexOf(pat);
  if (idx > -1) {
    console.log('Found "' + pat + '" at offset', idx);
    console.log('  Context: ...' + preload.slice(Math.max(0, idx - 40), idx + 100).replace(/\n/g, ' ') + '...');
  }
});

// Also check register.js
const register = fs.readFileSync(path.join(base, 'lib', 'static', 'register.js'), 'utf8');
console.log('\n=== register.js patterns ===');
['targetUrl', 'BrowserWindow', 'loadURL', 'plaync100', 'flash', 'swf', 'socket', 'createServer', 'ppapi', 'pepper'].forEach(pat => {
  const idx = register.indexOf(pat);
  if (idx > -1) {
    console.log('Found "' + pat + '" at offset', idx);
    console.log('  Context: ...' + register.slice(Math.max(0, idx - 40), idx + 100).replace(/\n/g, ' ') + '...');
  }
});

// Check pub.key
console.log('\n=== pub.key ===');
console.log(fs.readFileSync(path.join(base, 'lib', 'static', 'pub.key'), 'utf8'));
