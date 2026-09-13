const fs = require('fs');
const audit = JSON.parse(fs.readFileSync('D:/naruto Online/core_project/client/public/engine_map_audit.json', 'utf8'));

console.log("--- LISTA DOS 28 CENÁRIOS AUTÊNTICOS DO MOTOR ---");
audit.discoveredBackgrounds.forEach((bg, idx) => {
  console.log("#" + (idx + 1) + " | " + bg.width + "x" + bg.height + " (" + bg.sizeKB + " KB) -> " + bg.path);
});
