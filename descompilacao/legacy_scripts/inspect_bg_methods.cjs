const fs = require('fs');

const bgScriptPath = "D:/naruto Online/02_LEGACY_ARCHIVE/decompiled/scripts_as3_latest/Processors/Game/Lobby/MainScene/TLayerBackGround.as";
const content = fs.readFileSync(bgScriptPath, 'utf8');

console.log("--- BUSCANDO MÉTODOS DE TEXTURA E CARREGAMENTO ---");

// Procura ocorrências de carregamento, URLs, nomes de arquivos e texturas
const lines = content.split('\n');
lines.forEach((line, idx) => {
  const l = line.toLowerCase();
  if (l.includes('load') || l.includes('texture') || l.includes('bitmap') || l.includes('url') || l.includes('res') || l.includes('map') || l.includes('bg') || l.includes('path')) {
    if (!l.includes('protected static const') && l.trim().length > 0) {
      console.log(`[L${idx + 1}]: ${line.trim()}`);
    }
  }
});
