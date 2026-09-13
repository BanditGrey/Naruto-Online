const fs = require('fs');
const path = require('path');

const dir = 'descompilacao/02_LEGACY_ARCHIVE/legacy/raw_assets/Scripts_AS/13000000/scripts';
const files = fs.readdirSync(dir);

console.log('--- FUNCTION BUTTONS ---');
for (const f of files.filter(f => f.startsWith('Shortcuts_Function_Btn_'))) {
  const content = fs.readFileSync(path.join(dir, f), 'utf8');
  const match = content.match(/symbol="([^"]+)"/);
  console.log(f.padEnd(45) + ' -> ' + (match ? match[1] : 'none'));
}

console.log('\n--- ACTIVITY BUTTONS ---');
for (const f of files.filter(f => f.startsWith('Shortcuts_Activity_Btn_') || f.startsWith('Shortcuts_ActiveList_Btn_'))) {
  const content = fs.readFileSync(path.join(dir, f), 'utf8');
  const match = content.match(/symbol="([^"]+)"/);
  console.log(f.padEnd(45) + ' -> ' + (match ? match[1] : 'none'));
}

