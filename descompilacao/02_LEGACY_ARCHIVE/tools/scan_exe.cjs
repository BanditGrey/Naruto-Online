const fs = require('fs');
const path = require('path');

// Search the EXE for strings
const exePath = path.join('D:', 'naruto Online', 'official_client', 'www.plaync100.net.exe');
const exe = fs.readFileSync(exePath);
console.log('EXE size:', exe.length, 'bytes');

const str = exe.toString('latin1');

// The EXE name tells us the target: www.plaync100.net
const patterns = ['plaync100', 'naruto', 'oasgames', 'joyfun', 'flashvars', 'XMLSocket', 
  'main.swf', 'loading.swf', 'socket_server', 'pepper', 'ppapi-flash',
  'ppapi', '--ppapi-flash-path', '--ppapi-flash-version',
  'targetUrl', 'www.plaync', 'http://www.', 'https://www.',
  'nativefier'];

patterns.forEach(pat => {
  let idx = -1;
  let count = 0;
  while ((idx = str.indexOf(pat, idx + 1)) !== -1 && count < 3) {
    // Extract surrounding printable text
    let start = idx;
    while (start > 0 && str.charCodeAt(start - 1) >= 32 && str.charCodeAt(start - 1) < 127) start--;
    let end = idx + pat.length;
    while (end < str.length && str.charCodeAt(end) >= 32 && str.charCodeAt(end) < 127) end++;
    const full = str.slice(start, end);
    if (full.length < 500) {
      console.log('Found "' + pat + '" at offset ' + idx + ':');
      console.log('  ' + full);
    }
    count++;
  }
});

// Also search for common Electron/Chromium flash args
const chromiumArgs = ['--disable-web-security', '--allow-file-access', '--no-sandbox',
  '--ppapi-flash-path', '--ppapi-flash-version', 'pepflashplayer'];
chromiumArgs.forEach(arg => {
  const idx = str.indexOf(arg);
  if (idx > -1) {
    let start = Math.max(0, idx - 40);
    let end = Math.min(str.length, idx + arg.length + 40);
    console.log('Chromium arg "' + arg + '" at ' + idx + ': ' + str.slice(start, end).replace(/[^\x20-\x7e]/g, '.'));
  }
});
