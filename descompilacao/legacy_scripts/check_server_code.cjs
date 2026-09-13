const fs = require('fs');
const path = require('path');

const serverDir = "D:/naruto Online/core_project/server";
if (fs.existsSync(serverDir)) {
  const files = fs.readdirSync(serverDir);
  console.log("Arquivos na pasta server:", files);
  
  // Ler o arquivo principal do servidor (geralmente index.ts, server.ts ou app.ts)
  const entries = ['index.ts', 'server.ts', 'app.ts', 'index.js', 'server.js'];
  for (const entry of entries) {
    const fullPath = path.join(serverDir, entry);
    if (fs.existsSync(fullPath)) {
      console.log(`\n--- Conteúdo de server/${entry} ---`);
      console.log(fs.readFileSync(fullPath, 'utf8').substring(0, 1000));
    }
  }
}

const serverPkg = "D:/naruto Online/core_project/server/package.json";
if (fs.existsSync(serverPkg)) {
  console.log("\n--- server/package.json ---");
  console.log(fs.readFileSync(serverPkg, 'utf8'));
}
