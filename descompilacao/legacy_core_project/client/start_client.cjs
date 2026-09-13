const { spawn } = require('child_process');
const fs = require('fs');
const path = require('path');

const outLog = fs.openSync(path.join(__dirname, 'vite_stdout.log'), 'a');
const errLog = fs.openSync(path.join(__dirname, 'vite_stderr.log'), 'a');
const viteCli = path.join(__dirname, 'node_modules', 'vite', 'bin', 'vite.js');

console.log('Iniciando processo do Vite...');
const child = spawn(process.execPath, [viteCli, '--port', '3000', '--host'], {
  cwd: __dirname,
  detached: true,
  stdio: ['ignore', outLog, errLog]
});

child.unref();
console.log('Vite disparado em background com PID:', child.pid);
