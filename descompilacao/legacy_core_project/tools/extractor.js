const fs = require('fs');
const path = require('path');

const srcBin = 'D:/naruto Online/archive_vn/binaries/unpacked/01000000_NormalServer_decompressed_18MB.bin';
const outDir = 'D:/naruto Online/core_project/server/src/data';

if (!fs.existsSync(srcBin)) {
  console.error('Arquivo binario mestre nao encontrado em:', srcBin);
  process.exit(1);
}

console.log('Carregando banco mestre VN (18.9 MB)...');
const buf = fs.readFileSync(srcBin);
const totalRecords = buf.readUInt32LE(0);
console.log(`Registros de cabecalho primario: ${totalRecords}`);

// 1. Extração de Itens / Artigos (Tabela principal)
const items = [];
let offset = 4;
for (let i = 0; i < totalRecords; i++) {
  if (offset >= buf.length - 8) break;
  
  const id = buf.readUInt32LE(offset);
  offset += 4;
  
  if (offset >= buf.length - 2) break;
  const nameLen = buf.readUInt16LE(offset);
  offset += 2;
  
  if (nameLen > 300 || offset + nameLen > buf.length) break;
  const name = buf.subarray(offset, offset + nameLen).toString('utf8');
  offset += nameLen;
  
  // Salto dos bytes fixos de atributos do registro
  offset += 36;
  
  let description = '';
  if (offset < buf.length - 2) {
    const descLen = buf.readUInt16LE(offset);
    if (descLen < 2000 && offset + 2 + descLen <= buf.length) {
      description = buf.subarray(offset + 2, offset + 2 + descLen).toString('utf8');
      offset += 2 + descLen;
    }
  }
  
  if (id > 0 && name.trim().length > 0) {
    items.push({ id, name: name.trim(), description: description.trim() });
  }
}

fs.writeFileSync(path.join(outDir, 'items.json'), JSON.stringify(items, null, 2), 'utf8');
console.log(`✓ items.json gerado com ${items.length} itens.`);

// 2. Extração de Ninjas e Heróis (BaseHero)
const str = buf.toString('latin1');
const heroRegex = /([0-9]{5,8})[\x00-\x20]+([A-Z][a-zA-Z0-9\s]{2,25}(?:Sasuke|Naruto|Madara|Obito|Itachi|Kakashi|Sakura|Minato|Hashirama|Tobirama|Pain|Jiraiya|Tsunade|Orochimaru|Danzou|Gaara|Lee|Neji|Hinata|Shikamaru|Kiba|Shino|Chouji|Ino|Tenten|Kankuro|Temari)[a-zA-Z0-9\s]*)/g;

const heroes = [];
const seenIds = new Set();
let m;

while ((m = heroRegex.exec(str)) !== null) {
  const id = parseInt(m[1], 10);
  const name = m[2].trim();
  if (!seenIds.has(id) && name.length >= 3) {
    seenIds.add(id);
    heroes.push({ id, name });
  }
}

// Ordenar heróis por ID
heroes.sort((a, b) => a.id - b.id);

fs.writeFileSync(path.join(outDir, 'heroes.json'), JSON.stringify(heroes, null, 2), 'utf8');
console.log(`✓ heroes.json gerado com ${heroes.length} ninjas unicos.`);
console.log('Processo de extracao concluido com sucesso!');
