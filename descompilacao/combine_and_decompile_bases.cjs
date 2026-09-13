const fs = require('fs');
const path = require('path');
const { execFileSync } = require('child_process');

const FFDEC_EXE = 'C:\\Program Files (x86)\\FFDec\\ffdec-cli.exe';
const BASE1_CDN = 'D:/naruto Online/descompilacao/01_VN_OFFICIAL_SOURCE/archive_vn/assets_cdn';
const BASE2_SWFS = 'D:/naruto Online/descompilacao/02_LEGACY_ARCHIVE/decompiled/swfs';
const OUT_DIR = 'D:/naruto Online/descompilacao/combined_canonical';

if (!fs.existsSync(OUT_DIR)) {
  fs.mkdirSync(OUT_DIR, { recursive: true });
}

const TARGET_MODULES = [
  { id: '29000000', name: 'Mail_Sistema_Correio' },
  { id: '32000000', name: 'Welcome_Gift_Novidades' },
  { id: '13000000', name: 'HUD_Shortcuts_TopBar' },
  { id: '15000000', name: 'Hero_Stats_Equipamentos' },
  { id: '21000000', name: 'Hero_Recruit_Roster' },
  { id: '35000000', name: 'Family_Guilda' },
  { id: '03000000', name: 'Backpack_Mochila' },
  { id: '07000000', name: 'Talent_Skill_Tree' }
];

console.log('===============================================================');
console.log('  DESCOMPILACAO & COMBINACAO ORGANIZADA DAS DUAS BASES (FFDec) ');
console.log('===============================================================');

for (const mod of TARGET_MODULES) {
  const p1 = path.join(BASE1_CDN, mod.id + '.swf');
  const p2 = path.join(BASE2_SWFS, mod.id + '.swf');

  const s1 = fs.existsSync(p1) ? fs.statSync(p1).size : 0;
  const s2 = fs.existsSync(p2) ? fs.statSync(p2).size : 0;

  console.log('\n[MODULO ' + mod.id + '] ' + mod.name);
  console.log('  Base 1 (VN CDN):     ' + (s1 > 0 ? (s1 + ' bytes') : 'AUSENTE'));
  console.log('  Base 2 (Legacy SWF): ' + (s2 > 0 ? (s2 + ' bytes') : 'AUSENTE'));

  let chosenPath = '';
  let chosenBase = '';

  if (s1 >= s2 && s1 > 0) {
    chosenPath = p1;
    chosenBase = 'Base 1 (VN CDN - Mais Recente/Completa)';
  } else if (s2 > 0) {
    chosenPath = p2;
    chosenBase = 'Base 2 (Legacy Archive)';
  }

  if (!chosenPath) {
    console.warn('  [AVISO] Modulo ' + mod.id + ' nao encontrado em nenhuma das bases.');
    continue;
  }

  console.log('  => Escolhida: ' + chosenBase);

  const targetFolder = path.join(OUT_DIR, mod.id);
  if (fs.existsSync(targetFolder) && fs.readdirSync(targetFolder).length > 0) {
    console.log('  OK: Ja descompilado anteriormente em ' + targetFolder);
    continue;
  }

  fs.mkdirSync(targetFolder, { recursive: true });
  console.log('  Iniciando descompilacao via FFDec para: ' + targetFolder + '...');

  try {
    execFileSync(FFDEC_EXE, ['-export', 'script,image,sprite', targetFolder, chosenPath], { stdio: 'inherit', timeout: 180000 });
    console.log('  OK: Concluido com sucesso!');
  } catch (err) {
    console.error('  ERRO ao descompilar ' + mod.id + ':', err.message);
  }
}

console.log('\n===============================================================');
console.log('  PROCESSO DE DESCOMPILACAO E FUSAO CONCLUIDO COM SUCESSO!     ');
console.log('===============================================================');
