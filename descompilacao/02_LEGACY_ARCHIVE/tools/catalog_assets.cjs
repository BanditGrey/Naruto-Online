/**
 * Naruto Online - Automated Asset Cataloger & Reverse-Engineering Indexer
 * 
 * Deeply scans decompiled SWF assets, parses binary PNG/JPG headers,
 * cross-references AS3 hexadecimal module mappings, and outputs:
 * - docs/ASSETS_CATALOG.json
 * - docs/ASSETS_MAPPING.md
 */

const fs = require('fs');
const path = require('path');

const ROOT_DIR = 'D:/naruto Online';
const RAW_ASSETS_DIR = path.join(ROOT_DIR, 'legacy/raw_assets/Scripts_AS');
const DOCS_DIR = path.join(ROOT_DIR, 'docs');

// AS3 Module & Hex Directory Mapping
const AS3_MODULE_MAP = {
  '00000000': { type: 'SWF_COMMON', desc: 'Resources/Swf/Common/ (MC_DefaultRoleTexture, Hit FX, Popup Frames)' },
  '01000000': { type: 'SWF_CREATE_CHAR', desc: 'Resources/Swf/CreateChar/ (5 Playable Ninja Classes, Select UI)' },
  '02000000': { type: 'SWF_CHAT', desc: 'Resources/Swf/Chat/ (Chat Window, Emoticons, Channels)' },
  '07000000': { type: 'SWF_ILLUSTRATION', desc: 'Ninja Class Illustrations, Full-body Character Artwork' },
  '13000000': { type: 'SWF_LOBBY', desc: 'Resources/Swf/Lobby/ (Main Town HUD, Shortcut Bar, Avatar Frame, Bag)' },
  '17000000': { type: 'SWF_BATTLE', desc: 'Resources/Swf/Battle/ (Arena Backdrops, Battle Stage HUD, HP Bars)' },
  '17000003': { type: 'SWF_PLOT_SCENE', desc: 'Resources/Swf/Plot/ (Shrine Gate Scenery, Exterior Background)' },
  '24000000': { type: 'SWF_NINJA_UPGRADE', desc: 'Ninja Awakening & Star Upgrade Interface' },
  '28000000': { type: 'SWF_VILLAGE_NPCS', desc: 'Konoha Village NPCs & Props (Teuchi, Ayame, Signposts, Lanterns)' },
  '34000000': { type: 'SWF_SUMMON_SYSTEM', desc: 'Summon Beast System (TongLing & Pet Details)' },
  '3C000000': { type: 'SWF_SHOP', desc: 'Shop, Mall & Merchant Exchange Window Frames' },
  '46000000': { type: 'SWF_DAILY_QUEST', desc: 'Daily Quests & Task Scroll Boards' },
  '81000000': { type: 'SWF_BATTLE_CORE', desc: 'Battle Logic & Combat Results (RESOURCE_Battle 0x81000000)' },
  '98000155': { type: 'SWF_RAMEN_EVENT', desc: 'Ichiraku Ramen Shop Festival Building & Stand' }
};

// Fast binary header reader for PNG & JPEG
function getImageInfo(filePath) {
  try {
    const stat = fs.statSync(filePath);
    if (stat.size < 16) return null;
    const fd = fs.openSync(filePath, 'r');
    const buf = Buffer.alloc(Math.min(stat.size, 65536));
    fs.readSync(fd, buf, 0, buf.length, 0);
    fs.closeSync(fd);

    // PNG Parser
    if (buf.length >= 24 && buf.toString('ascii', 1, 4) === 'PNG') {
      const width = buf.readUInt32BE(16);
      const height = buf.readUInt32BE(20);
      const colorType = buf[25];
      const hasAlpha = colorType === 4 || colorType === 6;
      return { format: 'png', width, height, hasAlpha, size: stat.size };
    }

    // JPEG Parser
    if (buf.length >= 4 && buf[0] === 0xFF && buf[1] === 0xD8) {
      let offset = 2;
      while (offset < buf.length) {
        if (buf[offset] !== 0xFF) { offset++; continue; }
        const marker = buf[offset + 1];
        if (marker === 0xD9 || marker === 0xDA) break;
        if (offset + 4 > buf.length) break;
        const len = buf.readUInt16BE(offset + 2);
        if ([0xC0, 0xC1, 0xC2, 0xC3, 0xC5, 0xC6, 0xC7, 0xC9, 0xCA, 0xCB, 0xCD, 0xCE, 0xCF].includes(marker)) {
          if (offset + 9 > buf.length) break;
          const height = buf.readUInt16BE(offset + 5);
          const width = buf.readUInt16BE(offset + 7);
          return { format: 'jpg', width, height, hasAlpha: false, size: stat.size };
        }
        offset += 2 + len;
      }
    }
  } catch (e) {}
  return null;
}

console.log('--- Starting Automated Asset Cataloging ---');
console.log('Source Directory:', RAW_ASSETS_DIR);

const catalog = {
  timestamp: new Date().toISOString(),
  stats: {
    totalScanned: 0,
    backgrounds: 0,
    charactersAndNpcs: 0,
    uiElements: 0,
    fxAndSkills: 0,
    icons: 0,
    other: 0
  },
  categories: {
    backgrounds: [],
    characters_npcs: [],
    ui_hud: [],
    fx_skills: [],
    icons: []
  },
  keyVillageAssets: {
    scenery: [],
    npcs: [],
    bottomBar: [],
    topProfileHUD: []
  }
};

function walk(dir) {
  const list = fs.readdirSync(dir, { withFileTypes: true });
  for (const item of list) {
    const fullPath = path.join(dir, item.name);
    if (item.isDirectory()) {
      walk(fullPath);
    } else if (item.isFile()) {
      const ext = path.extname(item.name).toLowerCase();
      if (ext === '.png' || ext === '.jpg' || ext === '.jpeg') {
        catalog.stats.totalScanned++;
        const info = getImageInfo(fullPath);
        if (!info) continue;

        const relPath = path.relative(RAW_ASSETS_DIR, fullPath).replace(/\\/g, '/');
        const folder = relPath.split('/')[0];
        const fileName = path.basename(relPath);

        const assetRecord = {
          relPath: 'legacy/raw_assets/Scripts_AS/' + relPath,
          folder,
          fileName,
          format: info.format,
          width: info.width,
          height: info.height,
          hasAlpha: info.hasAlpha,
          size: info.size,
          moduleInfo: AS3_MODULE_MAP[folder] || (folder.startsWith('00CF') ? { type: 'SWF_SKILL', desc: 'Resources/Swf/Skill/ (Jutsu Effect)' } : null)
        };

        classifyAsset(assetRecord);
      }
    }
  }
}

function classifyAsset(asset) {
  const { width, height, hasAlpha, folder, fileName } = asset;

  // 1. FX / Skills (00CF... or 055D...)
  if (folder.startsWith('00CF') || folder.startsWith('055D')) {
    catalog.stats.fxAndSkills++;
    catalog.categories.fx_skills.push(asset);
    return;
  }

  // 2. Cenários e Backgrounds (> 800x350)
  if (width >= 800 && height >= 350) {
    catalog.stats.backgrounds++;
    catalog.categories.backgrounds.push(asset);

    if (folder === '17000003' && fileName === '1.jpg') {
      catalog.keyVillageAssets.scenery.push({ ...asset, role: 'Konoha Outdoor Shrine / Torii Gate Entrance (1250x650)' });
    } else if (folder === '17000000' && (fileName === '155.jpg' || fileName === '1.jpg')) {
      catalog.keyVillageAssets.scenery.push({ ...asset, role: 'Battle Arena Background (1250x650)' });
    } else if (folder === '98000155' && fileName === '1.png') {
      catalog.keyVillageAssets.scenery.push({ ...asset, role: 'Ramen Ichiraku Building Facade (1000x500)' });
    }
    return;
  }

  // 3. UI Elements: Bottom Shortcut Bar, Top Avatar Frame, Currency Bar
  if (folder === '13000000') {
    if (fileName === '183.png') {
      catalog.stats.uiElements++;
      catalog.categories.ui_hud.push({ ...asset, role: 'Bottom Shortcut Bar & EXP Frame (Gold Curved Edge)' });
      catalog.keyVillageAssets.bottomBar.push({ ...asset, role: 'Bottom Main Frame' });
      return;
    }
    if (fileName === '160.png' || fileName === '163.png') {
      catalog.stats.uiElements++;
      catalog.categories.ui_hud.push({ ...asset, role: 'World Map Navigation Button' });
      catalog.keyVillageAssets.bottomBar.push({ ...asset, role: 'World Map Button' });
      return;
    }
    if (fileName === '283.png') {
      catalog.stats.uiElements++;
      catalog.categories.ui_hud.push({ ...asset, role: 'Team / Ninja Management Button (Team 7)' });
      catalog.keyVillageAssets.bottomBar.push({ ...asset, role: 'Team Button' });
      return;
    }
    if (fileName === '288.png') {
      catalog.stats.uiElements++;
      catalog.categories.ui_hud.push({ ...asset, role: 'Bag / Backpack Button (Ninja Pouch)' });
      catalog.keyVillageAssets.bottomBar.push({ ...asset, role: 'Bag Button' });
      return;
    }
    if (fileName === '221.png') {
      catalog.stats.uiElements++;
      catalog.categories.ui_hud.push({ ...asset, role: 'Formation / Tactical Deployment Board Button' });
      catalog.keyVillageAssets.bottomBar.push({ ...asset, role: 'Formation Button' });
      return;
    }
    if (fileName === '226.png') {
      catalog.stats.uiElements++;
      catalog.categories.ui_hud.push({ ...asset, role: 'Summon / Tongling Contract Scroll Button' });
      catalog.keyVillageAssets.bottomBar.push({ ...asset, role: 'Summon Button' });
      return;
    }
    if (fileName === '323.png') {
      catalog.stats.uiElements++;
      catalog.categories.ui_hud.push({ ...asset, role: 'Player Name, Level & HP/Chakra HUD Frame' });
      catalog.keyVillageAssets.topProfileHUD.push({ ...asset, role: 'Player Status Bar' });
      return;
    }
    if (fileName === '376.png') {
      catalog.stats.uiElements++;
      catalog.categories.ui_hud.push({ ...asset, role: 'Currency Bar (Ryo Silver, Gold Ingots, Coupons)' });
      catalog.keyVillageAssets.topProfileHUD.push({ ...asset, role: 'Currency HUD Bar' });
      return;
    }
    if (['325.png', '327.png', '329.png', '331.png', '333.png', '335.png', '337.png', '339.png', '341.png', '343.png'].includes(fileName)) {
      catalog.stats.uiElements++;
      catalog.categories.ui_hud.push({ ...asset, role: `Class Circular Avatar Portrait (${fileName})` });
      catalog.keyVillageAssets.topProfileHUD.push({ ...asset, role: `Avatar Portrait (${fileName})` });
      return;
    }
  }

  // 4. Personagens e NPCs (Transparent sprites with human proportions)
  if (hasAlpha && height >= 70 && height <= 450 && width >= 35 && width <= 400 && height >= width * 0.7) {
    let matchedRole = null;
    if (folder === '01000000' && fileName === '47.png') {
      matchedRole = 'Playable Ninja Protagonist - Midnight Blade (Lâmina das Trevas)';
    } else if (folder === '28000000' && fileName === '114.png') {
      matchedRole = 'NPC Teuchi (Ichiraku Ramen Chef - Cooking Pose)';
    } else if (folder === '28000000' && fileName === '116.png') {
      matchedRole = 'NPC Teuchi (Ichiraku Ramen Chef - Greeting / Talking Pose)';
    } else if (folder === '28000000' && fileName === '128.png') {
      matchedRole = 'NPC Ayame (Ichiraku Ramen Waitress / Daughter)';
    } else if (folder === '28000000' && fileName === '130.png') {
      matchedRole = 'Village Prop - Konoha Wooden Street Post / Sign';
    } else if (folder === '28000000' && fileName === '133.png') {
      matchedRole = 'Village Prop - Traditional Paper Lanterns (Trio Hanging)';
    } else if (folder === '28000000' && fileName === '122.png') {
      matchedRole = 'Village Prop - Ichiraku Ramen Curtain Noren Banner';
    } else if (folder === '00000000' && fileName === '356.png') {
      matchedRole = 'Official Role Dummy Puppet (MC_DefaultRoleTexture)';
    } else if (folder === '98000155' && fileName === '39.png') {
      matchedRole = 'Mascot Baby Naruto with Pacifier';
    } else if (folder === '98000003' && fileName === '2.png') {
      matchedRole = 'NPC Hinata Hyūga with Anbu Fox Mask';
    } else if (folder === '98000114' && fileName === '4.png') {
      matchedRole = 'NPC Sakura Haruno';
    } else if (folder === '98000104' && fileName === '3.png') {
      matchedRole = 'NPC Sasuke Uchiha with Scroll & Kunai';
    }

    if (matchedRole) {
      catalog.stats.charactersAndNpcs++;
      catalog.categories.characters_npcs.push({ ...asset, role: matchedRole });
      catalog.keyVillageAssets.npcs.push({ ...asset, role: matchedRole });
      return;
    }
  }

  // 5. Ícones (Square icons 30x30 to 90x90)
  if (Math.abs(width - height) <= 12 && width >= 32 && width <= 90) {
    catalog.stats.icons++;
    catalog.categories.icons.push(asset);
    return;
  }

  // 6. Generic UI / Other
  if (width >= 100 || height >= 100) {
    catalog.stats.uiElements++;
    catalog.categories.ui_hud.push(asset);
  } else {
    catalog.stats.other++;
  }
}

// Execute scan
walk(RAW_ASSETS_DIR);

console.log('--- Scan Completed ---');
console.log('Total Scanned Images:', catalog.stats.totalScanned);
console.log('Backgrounds:', catalog.stats.backgrounds);
console.log('Characters & NPCs:', catalog.stats.charactersAndNpcs);
console.log('UI & HUD Elements:', catalog.stats.uiElements);
console.log('FX & Skills Frames:', catalog.stats.fxAndSkills);
console.log('Icons:', catalog.stats.icons);
console.log('Other / Uncategorized:', catalog.stats.other);

// Ensure docs folder exists
if (!fs.existsSync(DOCS_DIR)) fs.mkdirSync(DOCS_DIR, { recursive: true });

// Write ASSETS_CATALOG.json
const catalogPath = path.join(DOCS_DIR, 'ASSETS_CATALOG.json');
fs.writeFileSync(catalogPath, JSON.stringify(catalog, null, 2), 'utf8');
console.log('Wrote ASSETS_CATALOG.json to:', catalogPath);

// Generate ASSETS_MAPPING.md
const lines = [
  '# Naruto Online - Catálogo e Mapeamento Definitivo de Assets',
  '',
  'Documentação oficial gerada pelo Antigravity através de engenharia reversa do código ActionScript 3 (`legacy/scripts_as3/`) e catalogação automatizada dos assets descompactados (`legacy/raw_assets/`).',
  '',
  '---',
  '',
  '## 1. Engenharia Reversa do Sistema de Resolução de IDs (AS3)',
  '',
  'O cliente original do Naruto Online Flash empregava o padrão **Hexadecimal de 8 Dígitos** em todas as suas requisições de rede e carregadores de recursos (`Foundation.Utilities.TUtilityHexadecimal.Format(id, 8)`).',
  '',
  '### Mecanismo de Resolução (`TResourceLoader.as`)',
  '```actionscript',
  'protected function ResourceURL(param1:TResourceRequest) : String',
  '{',
  '   return this.FResourcePath + TUtilityHexadecimal.Format(param1.Identifier, 8) + this.FResourceSuffix;',
  '}',
  '```',
  '',
  '### Mapeamento dos Módulos Principais',
  '| Prefixo Hexadecimal | Repositório Virtual AS3 | Identificador Decimal | Descrição e Conteúdo |',
  '| :--- | :--- | :--- | :--- |',
  '| **`00000000`** | `Resources/Swf/Common/` | `0` | Controles comuns, popups, `MC_DefaultRoleTexture` (boneco manequim). |',
  '| **`01000000`** | `Resources/Swf/CreateChar/` | `16777216` | Tela de criação de personagem: 5 classes ninjas e ilustrações. |',
  '| **`02000000`** | `Resources/Swf/Chat/` | `33554432` | Sistema de chat, caixas de diálogo e emoticons. |',
  '| **`07000000`** | `Resources/Swf/Illustration/`| `117440512` | Retratos ilustrados de alta resolução dos protagonistas. |',
  '| **`13000000`** | `Resources/Swf/Lobby/` | `318767104` | HUD da Vila da Folha, barra inferior, menu, botões de atalho, avatar. |',
  '| **`17000000`** | `Resources/Swf/Battle/` | `385875968` | Cenários da Arena (`155.jpg`), barras de HP de combate, slots de grade. |',
  '| **`17000003`** | `Resources/Swf/Plot/` | `385875971` | Cenários exteriores de Konoha (Pórtico/Templo xintoísta `1.jpg`). |',
  '| **`28000000`** | `Resources/Swf/NPC/` | `671088640` | NPCs autênticos da Vila (Teuchi, Ayame, placas de rua, lanternas). |',
  '| **`3C000000`** | `Resources/Swf/Shop/` | `1006632960` | Molduras de janelas e painéis de loja/inventário. |',
  '| **`81000000`** | `Resources/Swf/BattleCore/` | `2164260864` | Núcleo do motor de batalha (`RESOURCE_Battle`). |',
  '| **`00CFXXXX`** | `Resources/Swf/Skill/` | `13600000+` | Animações de jutsus e auras de chakra (`00CF8507` = Skill `13600007`). |',
  '| **`9800XXXX`** | `Resources/Swf/Events/` | Variável | Instalações e eventos (Restaurante Ichiraku `98000155`, banners). |',
  '',
  '---',
  '',
  '## 2. Estatísticas Consolidadas da Varredura',
  '',
  `- **Total de Imagens Mapeadas:** \`${catalog.stats.totalScanned}\` arquivos (.png e .jpg)`,
  `- **Cenários / Fundos Panorâmicos (>800x350):** \`${catalog.stats.backgrounds}\``,
  `- **Personagens, NPCs e Mascotes Identificados:** \`${catalog.stats.charactersAndNpcs}\``,
  `- **Elementos de Interface de Usuário (HUD/UI):** \`${catalog.stats.uiElements}\``,
  `- **Frames de Habilidades e Efeitos (Jutsus):** \`${catalog.stats.fxAndSkills}\``,
  `- **Ícones Quadrados de Itens/Equipamentos:** \`${catalog.stats.icons}\``,
  '',
  '---',
  '',
  '## 3. Identificação Específica dos Elementos da Vila da Folha (Konoha)',
  '',
  'Abaixo estão os endereços exatos para replicar pixel por pixel a Vila de Konoha original:',
  '',
  '### A. Cenário Exterior e Instalações',
  '| Elemento | Origem Legada (`legacy/raw_assets/...`) | Destino no Cliente (`client/public/assets/...`) | Dimensões | Descrição |',
  '| :--- | :--- | :--- | :--- | :--- |',
  '| **Pórtico Exterior Konoha** | `Scripts_AS/17000003/images/1.jpg` | `town/bg_konoha_shrine.jpg` | $1250 \\times 650$ | Entrada exterior com corda sagrada shimenawa, colunas e nuvens |',
  '| **Fachada Ichiraku Ramen** | `Scripts_AS/98000155/images/1.png` | `town/ichiraku_ramen_shop.png` | $1000 \\times 500$ | Prédio completo do Restaurante Ichiraku com toldo e balcão |',
  '| **Cortina Noren Ichiraku** | `Scripts_AS/28000000/images/122.png` | `town/ichiraku_noren.png` | $285 \\times 109$ | Faixa tradicional pendurada sobre a entrada do restaurante |',
  '| **Poste / Placa da Vila** | `Scripts_AS/28000000/images/130.png` | `town/prop_street_sign.png` | $53 \\times 110$ | Poste de madeira com placa e emblema da Folha |',
  '| **Lanternas Japonesas** | `Scripts_AS/28000000/images/133.png` | `town/prop_lanterns.png` | $51 \\times 135$ | Três lanternas tradicionais iluminadas penduradas |',
  '',
  '### B. Personagens e NPCs da Vila',
  '| Personagem | Origem Legada (`legacy/raw_assets/...`) | Destino no Cliente (`client/public/assets/...`) | Dimensões | Papel no Jogo |',
  '| :--- | :--- | :--- | :--- | :--- |',
  '| **Lâmina das Trevas** | `Scripts_AS/01000000/images/47.png` | `town/ninja_class_1.png` | $398 \\times 448$ | Protagonista Relâmpago com bandana da Folha e Fūma Shuriken |',
  '| **Teuchi (Chef Ramen)** | `Scripts_AS/28000000/images/116.png` | `town/npc_teuchi.png` | $175 \\times 156$ | Dono do Ichiraku cozinhando e conversando com clientes |',
  '| **Ayame (Garçonete)** | `Scripts_AS/28000000/images/128.png` | `town/npc_ayame.png` | $94 \\times 124$ | Filha do Teuchi servindo clientes no balcão de ramen |',
  '| **Sasuke Uchiha** | `Scripts_AS/98000104/images/3.png` | `town/npc_sasuke.png` | $185 \\times 220$ | Pose com kunai e pergaminho na boca |',
  '| **Sakura Haruno** | `Scripts_AS/98000114/images/4.png` | `town/npc_sakura.png` | $190 \\times 230$ | Pose ninja com luvas medicinais |',
  '| **Hinata Hyūga** | `Scripts_AS/98000003/images/2.png` | `town/npc_hinata.png` | $120 \\times 180$ | Hinata chibi com máscara anbu |',
  '| **Mascote Bebê Naruto** | `Scripts_AS/98000155/images/39.png` | `town/mascot_baby_naruto.png` | $141 \\times 235$ | Mascote especial com chupeta e bandana |',
  '| **Manequim Provisório** | `Scripts_AS/00000000/images/356.png` | `town/puppet_dummy.png` | $47 \\times 125$ | Boneco manequim oficial da Tencent (`MC_DefaultRoleTexture`) |',
  '',
  '### C. Barra Inferior de Atalhos Clássica',
  '| Elemento | Origem Legada (`legacy/raw_assets/...`) | Destino no Cliente (`client/public/assets/...`) | Dimensões | Função |',
  '| :--- | :--- | :--- | :--- | :--- |',
  '| **Barra Dourada Curvada** | `Scripts_AS/13000000/images/183.png` | `ui/bottom_bar_frame.png` | $813 \\times 83$ | Base de madeira e suporte dourado circular inferior |',
  '| **Botão Equipe (Team)** | `Scripts_AS/13000000/images/283.png` | `ui/btn_team.png` | $47 \\times 52$ | Ícone do Time 7 (Naruto, Sasuke e Sakura) |',
  '| **Botão Mochila (Bag)** | `Scripts_AS/13000000/images/288.png` | `ui/btn_bag.png` | $52 \\times 53$ | Bolsa ninja de couro marrom com shuriken e kunai |',
  '| **Botão Formação** | `Scripts_AS/13000000/images/221.png` | `ui/btn_formation.png` | $53 \\times 54$ | Tabuleiro tático com 3 peças de formação |',
  '| **Botão Invocação** | `Scripts_AS/13000000/images/226.png` | `ui/btn_summon.png` | $52 \\times 54$ | Pergaminho de contrato de invocação da Kurama |',
  '| **Botão Mapa Mundi** | `Scripts_AS/13000000/images/160.png` | `ui/btn_world_map.png` | $74 \\times 84$ | Globo terrestre em pergaminho (encaixe circular direito) |',
  '',
  '### D. Painel Superior Esquerdo (Perfil do Jogador)',
  '| Elemento | Origem Legada (`legacy/raw_assets/...`) | Destino no Cliente (`client/public/assets/...`) | Dimensões | Função |',
  '| :--- | :--- | :--- | :--- | :--- |',
  '| **Moldura do Status** | `Scripts_AS/13000000/images/323.png` | `ui/avatar_status_frame.png` | $260 \\times 105$ | Base entalhada com encaixe circular de retrato e barras HP/Chakra |',
  '| **Barra de Recursos/Moedas**| `Scripts_AS/13000000/images/376.png` | `ui/currency_bar.png` | $473 \\times 49$ | Exibição de Ryo (Prata), Lingotes de Ouro e Cupons |',
  '| **Retrato Lâmina das Trevas**| `Scripts_AS/13000000/images/329.png` | `ui/avatar_blade.png` | $80 \\times 80$ | Retrato circular do protagonista com máscara Anbu |',
  '| **Retrato Kunoichi Vento** | `Scripts_AS/13000000/images/327.png` | `ui/avatar_dancer.png` | $80 \\times 80$ | Retrato circular da Dançarina dos Ventos |',
  '| **Retrato Olho das Chamas** | `Scripts_AS/13000000/images/325.png` | `ui/avatar_fire.png` | $80 \\times 80$ | Retrato circular do ninja de Fogo |',
  '',
  '---',
  '',
  '## 4. Estrutura Recomendada para o Cliente PixiJS',
  '',
  'Para montar a cena visual definitiva em `client/public/assets/`:',
  '',
  '```text',
  'client/public/assets/',
  '├── town/',
  '│   ├── bg_konoha.jpg           <-- 17000003/images/1.jpg (1250x650)',
  '│   ├── ichiraku_shop.png       <-- 98000155/images/1.png (Fachada Ichiraku)',
  '│   ├── prop_lanterns.png       <-- 28000000/images/133.png (Lanternas)',
  '│   ├── prop_sign.png           <-- 28000000/images/130.png (Poste)',
  '│   ├── ninja_class_1.png       <-- 01000000/images/47.png (Lâmina das Trevas)',
  '│   ├── npc_teuchi.png          <-- 28000000/images/116.png (Chef Teuchi)',
  '│   └── npc_ayame.png           <-- 28000000/images/128.png (Ayame)',
  '│',
  '├── battle/',
  '│   ├── bg_arena.jpg            <-- 17000000/images/155.jpg (Arena 1250x650)',
  '│   └── hp_bar.png              <-- 17000000/images/14.png',
  '│',
  '└── ui/',
  '    ├── bottom_bar.png          <-- 13000000/images/183.png',
  '    ├── btn_team.png            <-- 13000000/images/283.png',
  '    ├── btn_bag.png             <-- 13000000/images/288.png',
  '    ├── btn_formation.png       <-- 13000000/images/221.png',
  '    ├── btn_summon.png          <-- 13000000/images/226.png',
  '    ├── btn_map.png             <-- 13000000/images/160.png',
  '    ├── avatar_frame.png        <-- 13000000/images/323.png',
  '    ├── currency_bar.png        <-- 13000000/images/376.png',
  '    └── avatar_blade.png        <-- 13000000/images/329.png',
  '```'
];

const mappingPath = path.join(DOCS_DIR, 'ASSETS_MAPPING.md');
fs.writeFileSync(mappingPath, lines.join('\n'), 'utf8');
console.log('Wrote ASSETS_MAPPING.md to:', mappingPath);
console.log('--- Cataloging finished successfully! ---');
