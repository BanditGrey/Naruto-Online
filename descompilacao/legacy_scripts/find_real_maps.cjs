const fs = require('fs');
const path = require('path');

console.log("--- INVESTIGANDO ESTRUTURA REAL DE MAPAS (TILES / SCENES) ---");

// 1. Procurar diretórios com nomes característicos de mapas e cidades
function searchMapDirs(dir) {
  if (!fs.existsSync(dir)) return;
  const entries = fs.readdirSync(dir, { withFileTypes: true });
  for (const ent of entries) {
    const full = path.join(dir, ent.name);
    if (ent.isDirectory()) {
      const lower = ent.name.toLowerCase();
      if (lower.includes('map') || lower.includes('scene') || lower.includes('town') || lower.includes('city') || lower.includes('konoha')) {
        console.log("[PASTA DE MAPA]:", full);
        const subFiles = fs.readdirSync(full);
        console.log(`  -> Contém ${subFiles.length} itens (Exemplos: ${subFiles.slice(0, 5).join(', ')})`);
      }
      if (!full.includes('node_modules') && !full.includes('.git')) {
        searchMapDirs(full);
      }
    }
  }
}

// 2. Procurar arquivos com extensões de dados de mapa (.map, .dat, .bin, .json) ou SWFs de mapas
function searchMapFiles(dir) {
  if (!fs.existsSync(dir)) return;
  const entries = fs.readdirSync(dir, { withFileTypes: true });
  for (const ent of entries) {
    const full = path.join(dir, ent.name);
    if (ent.isDirectory()) {
      if (!full.includes('node_modules') && !full.includes('.git')) {
        searchMapFiles(full);
      }
    } else {
      const lower = ent.name.toLowerCase();
      if (lower.endsWith('.map') || lower.endsWith('.scene') || (lower.includes('map') && (lower.endsWith('.xml') || lower.endsWith('.json') || lower.endsWith('.swf')))) {
        const sz = (fs.statSync(full).size / 1024).toFixed(1);
        console.log(`[ARQUIVO DE MAPA] ${ent.name} (${sz} KB) -> ${full}`);
      }
    }
  }
}

console.log("\n1. Varrimento de pastas de mapas:");
searchMapDirs("D:/naruto Online/01_VN_OFFICIAL_SOURCE");
searchMapDirs("D:/naruto Online/02_LEGACY_ARCHIVE");

console.log("\n2. Varrimento de arquivos de configuração / SWFs de mapa:");
searchMapFiles("D:/naruto Online/01_VN_OFFICIAL_SOURCE");
searchMapFiles("D:/naruto Online/02_LEGACY_ARCHIVE");
