const fs = require('fs');
const path = require('path');

const srcBin = 'D:/naruto Online/archive_vn/binaries/unpacked/01000000_NormalServer_decompressed_18MB.bin';
const outDir = 'D:/naruto Online/core_project/server/src/data';

if (!fs.existsSync(srcBin)) {
  console.error('Arquivo binario mestre nao encontrado em:', srcBin);
  process.exit(1);
}

fs.mkdirSync(outDir, { recursive: true });

console.log('Carregando banco mestre VN...');
const buf = fs.readFileSync(srcBin);
const totalRecords = buf.readUInt32LE(0);
console.log(`Meta declarada no cabecalho: ${totalRecords} registros`);

// 1. Extrator de Itens com Resync Robusto
const items = [];
let cursor = 4;
let lastId = 0;

while (cursor < buf.length - 12 && items.length < totalRecords) {
  const id = buf.readUInt32LE(cursor);
  
  // Validação: IDs de itens Joyfun ficam entre 10.000.000 e 99.999.999
  if (id >= 10000000 && id <= 99999999) {
    const nameLen = buf.readUInt16LE(cursor + 4);
    
    if (nameLen > 0 && nameLen < 150 && cursor + 6 + nameLen <= buf.length) {
      const name = buf.subarray(cursor + 6, cursor + 6 + nameLen).toString('utf8');
      
      // Busca pela string descritiva no bloco adiante
      let desc = '';
      const lookAheadMax = Math.min(cursor + 400, buf.length);
      for (let j = cursor + 6 + nameLen; j < lookAheadMax - 4; j++) {
        // Checa se o ID se repete como marcador de fechamento de atributo
        if (buf.readUInt32LE(j) === id) {
          // O comprimento da descrição fica 2 bytes antes ou logo após
          const descLen = buf.readUInt16LE(j - 2);
          if (descLen > 0 && descLen < 1000 && j - 2 - descLen >= cursor + 6 + nameLen) {
            desc = buf.subarray(j - 2 - descLen, j - 2).toString('utf8');
          }
          break;
        }
      }

      items.push({
        id,
        name: name.trim(),
        description: desc.trim()
      });

      lastId = id;
      cursor += 6 + nameLen;
      continue;
    }
  }
  
  cursor++;
}

fs.writeFileSync(path.join(outDir, 'items.json'), JSON.stringify(items, null, 2), 'utf8');
console.log(`✓ items.json gerado! Total capturado: ${items.length} itens.`);

// 2. Extrator Exaustivo de Ninjas / Personagens
console.log('Varrendo todos os nomes canônicos da franquia no banco...');
const str = buf.toString('latin1');
const ninjaKeywords = [
  'Naruto', 'Sasuke', 'Sakura', 'Kakashi', 'Itachi', 'Madara', 'Obito', 'Minato',
  'Hashirama', 'Tobirama', 'Pain', 'Jiraiya', 'Tsunade', 'Orochimaru', 'Danzou',
  'Gaara', 'Lee', 'Neji', 'Hinata', 'Shikamaru', 'Kiba', 'Shino', 'Chouji', 'Ino',
  'Tenten', 'Kankuro', 'Temari', 'Deidara', 'Sasori', 'Hidan', 'Kakuzu', 'Kisame',
  'Konan', 'Nagato', 'Killer', 'Raikage', 'Mizukage', 'Tsuchikage', 'Zabuza',
  'Haku', 'Kabuto', 'Yamato', 'Sai', 'Kushina', 'Kaguya', 'Shisui', 'Guy'
];

const heroes = [];
const seenNames = new Set();

ninjaKeywords.forEach(kw => {
  let pos = 0;
  while ((pos = str.indexOf(kw, pos)) !== -1) {
    // Pega a janela de texto em torno do nome
    const start = Math.max(0, pos - 20);
    const end = Math.min(str.length, pos + 40);
    const slice = buf.subarray(start, end);

    // Extrai o ID numérico associado nos bytes anteriores
    let foundId = null;
    for (let k = start; k < pos; k++) {
      const val = buf.readUInt32LE(k);
      if (val >= 1000 && val <= 99999999) {
        foundId = val;
      }
    }

    // Limpa a string de caracteres de controle
    const rawName = slice.toString('utf8');
    const cleanMatch = rawName.match(new RegExp(`([A-Z0-9][a-zA-Z0-9\\s_#.-]{1,25}${kw}[a-zA-Z0-9\\s_#.-]{0,25})`, 'i'));

    if (cleanMatch) {
      const finalName = cleanMatch[1].replace(/[^\x20-\x7E\u00C0-\u024F\u1EA0-\u1EF9]/g, ' ').replace(/\s+/g, ' ').trim();
      if (!seenNames.has(finalName) && finalName.length >= 3) {
        seenNames.add(finalName);
        heroes.push({
          id: foundId || (heroes.length + 1),
          name: finalName
        });
      }
    }

    pos += kw.length;
  }
});

heroes.sort((a, b) => a.name.localeCompare(b.name));
fs.writeFileSync(path.join(outDir, 'heroes.json'), JSON.stringify(heroes, null, 2), 'utf8');
console.log(`✓ heroes.json gerado! Total: ${heroes.length} herois/variacoes identificadas.`);
