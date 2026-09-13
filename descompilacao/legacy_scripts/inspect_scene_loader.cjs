const fs = require('fs');
const path = require('path');

console.log("--- INSPECIONANDO ARQUITETURA DE MAINSCENE ---");

// 1. Ler TLayerBackGround.as
const bgScriptPath = "D:/naruto Online/02_LEGACY_ARCHIVE/decompiled/scripts_as3_latest/Processors/Game/Lobby/MainScene/TLayerBackGround.as";
if (fs.existsSync(bgScriptPath)) {
  const content = fs.readFileSync(bgScriptPath, 'utf8');
  console.log("\n[TLayerBackGround.as - Trecho de Carregamento]:");
  const lines = content.split('\n');
  lines.slice(0, 45).forEach(l => console.log(l));
} else {
  console.log("TLayerBackGround.as não encontrado no caminho padrão.");
}

// 2. Analisar referências a mapas/cenas no CDN_ASSETS_MAP.json
const cdnMapPath = "D:/naruto Online/01_VN_OFFICIAL_SOURCE/archive_vn/metadata/CDN_ASSETS_MAP.json";
if (fs.existsSync(cdnMapPath)) {
  console.log("\n[CDN_ASSETS_MAP.json - Busca de Cenários/Mapas]:");
  try {
    const data = JSON.parse(fs.readFileSync(cdnMapPath, 'utf8'));
    let matches = [];
    for (const k in data) {
      const v = JSON.stringify(data[k]);
      if (k.toLowerCase().includes('map') || k.toLowerCase().includes('scene') || v.toLowerCase().includes('map') || v.toLowerCase().includes('scene') || v.toLowerCase().includes('town')) {
        matches.push({ key: k, value: data[k] });
      }
    }
    console.log(`Encontradas ${matches.length} referências.`);
    matches.slice(0, 15).forEach(m => console.log(JSON.stringify(m)));
  } catch (e) {
    console.log("Erro ao ler JSON:", e.message);
  }
}
