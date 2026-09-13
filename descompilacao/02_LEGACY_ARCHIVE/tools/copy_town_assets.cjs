const fs = require('fs');
const path = require('path');

const mappings = [
  // Cenário e Props
  { src: 'legacy/raw_assets/Scripts_AS/17000003/images/1.jpg', dest: 'client/public/assets/town/bg_konoha_shrine.jpg' },
  { src: 'legacy/raw_assets/Scripts_AS/98000155/images/1.png', dest: 'client/public/assets/town/ichiraku_shop.png' },
  { src: 'legacy/raw_assets/Scripts_AS/28000000/images/133.png', dest: 'client/public/assets/town/prop_lanterns.png' },
  { src: 'legacy/raw_assets/Scripts_AS/28000000/images/130.png', dest: 'client/public/assets/town/prop_sign.png' },
  { src: 'legacy/raw_assets/Scripts_AS/28000000/images/122.png', dest: 'client/public/assets/town/ichiraku_noren.png' },

  // Personagens e NPCs
  { src: 'legacy/raw_assets/Scripts_AS/01000000/images/47.png', dest: 'client/public/assets/town/ninja_blade.png' },
  { src: 'legacy/raw_assets/Scripts_AS/28000000/images/116.png', dest: 'client/public/assets/town/npc_teuchi.png' },
  { src: 'legacy/raw_assets/Scripts_AS/28000000/images/128.png', dest: 'client/public/assets/town/npc_ayame.png' },

  // HUD Inferior e Perfil
  { src: 'legacy/raw_assets/Scripts_AS/13000000/images/183.png', dest: 'client/public/assets/ui/bottom_bar.png' },
  { src: 'legacy/raw_assets/Scripts_AS/13000000/images/283.png', dest: 'client/public/assets/ui/btn_team.png' },
  { src: 'legacy/raw_assets/Scripts_AS/13000000/images/288.png', dest: 'client/public/assets/ui/btn_bag.png' },
  { src: 'legacy/raw_assets/Scripts_AS/13000000/images/221.png', dest: 'client/public/assets/ui/btn_formation.png' },
  { src: 'legacy/raw_assets/Scripts_AS/13000000/images/226.png', dest: 'client/public/assets/ui/btn_summon.png' },
  { src: 'legacy/raw_assets/Scripts_AS/13000000/images/160.png', dest: 'client/public/assets/ui/btn_map.png' },
  { src: 'legacy/raw_assets/Scripts_AS/13000000/images/323.png', dest: 'client/public/assets/ui/profile_frame.png' },
  { src: 'legacy/raw_assets/Scripts_AS/13000000/images/376.png', dest: 'client/public/assets/ui/currency_bar.png' },
  { src: 'legacy/raw_assets/Scripts_AS/13000000/images/329.png', dest: 'client/public/assets/ui/avatar_blade.png' }
];

let copied = 0;
let errors = 0;

for (const item of mappings) {
  const srcPath = path.resolve(item.src);
  const destPath = path.resolve(item.dest);

  if (!fs.existsSync(srcPath)) {
    console.error(`[ERRO] Arquivo de origem inexistente: ${item.src}`);
    errors++;
    continue;
  }

  const destDir = path.dirname(destPath);
  if (!fs.existsSync(destDir)) {
    fs.mkdirSync(destDir, { recursive: true });
  }

  fs.copyFileSync(srcPath, destPath);
  const stat = fs.statSync(destPath);
  console.log(`[OK] ${item.dest} (${(stat.size / 1024).toFixed(1)} KB)`);
  copied++;
}

console.log(`\nFinalizado: ${copied} arquivos copiados com sucesso, ${errors} erros.`);
if (errors > 0) {
  process.exit(1);
}
