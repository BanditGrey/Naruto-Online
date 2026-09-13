const fs = require('fs');
const path = require('path');

const srcDir = path.join(__dirname, '..', 'legacy', 'raw_assets', 'Scripts_AS', '01000000', 'images');
const destDir = path.join(__dirname, '..', 'client', 'public', 'assets', 'create_char');

if (!fs.existsSync(destDir)) {
  fs.mkdirSync(destDir, { recursive: true });
}

const copyMap = [
  // Fundo & UI
  { src: '1.jpg', dest: 'bg_create.jpg' },
  { src: '107.png', dest: 'name_bar.png' },
  { src: '76.png', dest: 'btn_create.png' },
  { src: '111.png', dest: 'btn_dice.png' },

  // Vórtices das 3 Disciplinas
  { src: '28.png', dest: 'tab_genjutsu.png' },
  { src: '39.png', dest: 'tab_taijutsu.png' },
  { src: '46.png', dest: 'tab_ninjutsu.png' },

  // Modelos em Destaque dos 6 Protagonistas
  { src: '29.jpg', dest: 'hero_genjutsu_m.png' },
  { src: '54.jpg', dest: 'hero_genjutsu_f.png' },
  { src: '38.jpg', dest: 'hero_taijutsu_m.png' },
  { src: '68.jpg', dest: 'hero_taijutsu_f.png' },
  { src: '47.png', dest: 'hero_ninjutsu_m.png' },
  { src: '61.jpg', dest: 'hero_ninjutsu_f.png' },

  // Previews / Thumbnails
  { src: '3.jpg', dest: 'thumb_genjutsu_m.png' },
  { src: '7.jpg', dest: 'thumb_genjutsu_f.png' },
  { src: '10.jpg', dest: 'thumb_taijutsu_m.png' },
  { src: '13.jpg', dest: 'thumb_taijutsu_f.png' },
  { src: '16.jpg', dest: 'thumb_ninjutsu_m.png' },
  { src: '19.jpg', dest: 'thumb_ninjutsu_f.png' }
];

console.log(`[Asset Migration] Copiando assets de criação de ${srcDir} para ${destDir}...`);

for (const item of copyMap) {
  const srcPath = path.join(srcDir, item.src);
  const destPath = path.join(destDir, item.dest);
  if (fs.existsSync(srcPath)) {
    fs.copyFileSync(srcPath, destPath);
    console.log(`  -> Copiado: ${item.src} => ${item.dest} (${(fs.statSync(destPath).size / 1024).toFixed(1)} KB)`);
  } else {
    console.warn(`  [AVISO] Arquivo não encontrado: ${srcPath}`);
  }
}

console.log(`[Asset Migration] Concluído com sucesso!`);
