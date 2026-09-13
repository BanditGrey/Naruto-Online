const http = require('http');
const fs = require('fs');
const path = require('path');
const { spawn } = require('child_process');

const PORT = 4545;
const BASE_DIR = 'D:\\naruto Online';
const HISTORY_FILE = path.join(BASE_DIR, 'dev_codex_history.json');
const HTML_FILE = path.join(BASE_DIR, 'dev_codex.html');

if (!fs.existsSync(HISTORY_FILE)) {
  fs.writeFileSync(HISTORY_FILE, JSON.stringify([], null, 2), 'utf8');
}

function loadHistory() {
  try { return JSON.parse(fs.readFileSync(HISTORY_FILE, 'utf8')); }
  catch (e) { return []; }
}

function saveHistory(h) {
  fs.writeFileSync(HISTORY_FILE, JSON.stringify(h, null, 2), 'utf8');
}

const server = http.createServer((req, res) => {
  if (req.method === 'GET' && req.url === '/') {
    res.writeHead(200, { 'Content-Type': 'text/html; charset=utf-8' });
    return res.end(fs.readFileSync(HTML_FILE, 'utf8'));
  }

  if (req.method === 'GET' && req.url === '/api/history') {
    res.writeHead(200, { 'Content-Type': 'application/json; charset=utf-8' });
    return res.end(JSON.stringify(loadHistory()));
  }

  if (req.method === 'DELETE' && req.url === '/api/history') {
    saveHistory([]);
    res.writeHead(200, { 'Content-Type': 'application/json' });
    return res.end(JSON.stringify({ ok: true }));
  }

  if (req.method === 'POST' && req.url === '/api/run') {
    let body = '';
    req.on('data', chunk => body += chunk);
    req.on('end', () => {
      try {
        const { code } = JSON.parse(body);
        const scriptPath = path.join(BASE_DIR, '_active_task.ps1');
        
        // Injeta configuração obrigatória de UTF-8 em todos os comandos
        const wrappedCode = `$OutputEncoding = [System.Text.Encoding]::UTF8` + "\r\n" +
                            `[Console]::OutputEncoding = [System.Text.Encoding]::UTF8` + "\r\n" +
                            `chcp 65001 > $null` + "\r\n" +
                            code;

        fs.writeFileSync(scriptPath, '\ufeff' + wrappedCode, 'utf8');

        const ps = spawn('powershell.exe', ['-NoProfile', '-ExecutionPolicy', 'Bypass', '-File', scriptPath], {
          cwd: BASE_DIR
        });

        const stdoutChunks = [];
        const stderrChunks = [];

        ps.stdout.on('data', d => stdoutChunks.push(d));
        ps.stderr.on('data', d => stderrChunks.push(d));

        ps.on('close', () => {
          try { if (fs.existsSync(scriptPath)) fs.unlinkSync(scriptPath); } catch (e) {}

          const stdout = Buffer.concat(stdoutChunks).toString('utf8');
          const stderr = Buffer.concat(stderrChunks).toString('utf8');
          const output = stdout + (stderr ? '\n[ERRO]\n' + stderr : '');

          const history = loadHistory();
          history.unshift({
            timestamp: Date.now(),
            command: code,
            output: output
          });
          if (history.length > 100) history.pop();
          saveHistory(history);

          res.writeHead(200, { 'Content-Type': 'application/json; charset=utf-8' });
          res.end(JSON.stringify({ output }));
        });
      } catch (err) {
        res.writeHead(500, { 'Content-Type': 'application/json; charset=utf-8' });
        res.end(JSON.stringify({ output: 'Falha: ' + err.message }));
      }
    });
    return;
  }

  res.writeHead(404);
  res.end();
});

server.listen(PORT, () => {
  console.log('Naruto Dev Codex (UTF-8) ativo em: http://localhost:' + PORT);
});
