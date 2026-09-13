const fs = require('fs');
const path = require('path');

const serverDir = "D:/naruto Online/core_project";
const files = fs.readdirSync(serverDir);
console.log("Arquivos na raiz do core_project:", files);

const packageJsonPath = path.join(serverDir, 'package.json');
if (fs.existsSync(packageJsonPath)) {
  const pkg = JSON.parse(fs.readFileSync(packageJsonPath, 'utf8'));
  console.log("\nScripts do package.json:", pkg.scripts);
}

// Procurar onde o fetch ou http é chamado no client/src
const clientMain = path.join(serverDir, 'client/src/main.ts');
if (fs.existsSync(clientMain)) {
  const code = fs.readFileSync(clientMain, 'utf8');
  code.split('\n').forEach((line, idx) => {
    if (line.includes('fetch') || line.includes('axios') || line.includes('http')) {
      console.log(`[Client L${idx+1}]: ${line.trim()}`);
    }
  });
}
