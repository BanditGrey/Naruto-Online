const fs = require('fs');
const path = require('path');

const srcDir = "D:/naruto Online/core_project/server/src";
if (fs.existsSync(srcDir)) {
  const files = fs.readdirSync(srcDir);
  console.log("Arquivos em server/src:", files);
  
  for (const file of files) {
    const fullPath = path.join(srcDir, file);
    if (fs.statSync(fullPath).isFile()) {
      console.log(`\n--- server/src/${file} ---`);
      console.log(fs.readFileSync(fullPath, 'utf8'));
    }
  }
}
