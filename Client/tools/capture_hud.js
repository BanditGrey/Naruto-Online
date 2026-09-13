import puppeteer from 'puppeteer-core';
import fs from 'fs';
import path from 'path';

const EDGE_PATH = 'C:\\Program Files (x86)\\Microsoft\\Edge\\Application\\msedge.exe';
const OUTPUT_DIR = path.resolve('./tools/inspection');

if (!fs.existsSync(OUTPUT_DIR)) {
  fs.mkdirSync(OUTPUT_DIR, { recursive: true });
}

async function capture() {
  console.log('[AUDIT] Iniciando navegador headless Edge...');
  const browser = await puppeteer.launch({
    executablePath: EDGE_PATH,
    headless: true,
    args: ['--no-sandbox', '--disable-setuid-sandbox', '--window-size=1300,750']
  });

  const page = await browser.newPage();
  await page.setViewport({ width: 1300, height: 750, deviceScaleFactor: 1 });

  console.log('[AUDIT] Acessando http://localhost:3000...');
  await page.goto('http://localhost:3000', { waitUntil: 'networkidle0', timeout: 15000 });

  // Aguarda o canvas ser criado e desenhado
  await page.waitForSelector('#game-container canvas', { timeout: 10000 });
  
  // Aguarda 2.5s para garantir que todas as texturas e fontes estejam renderizadas no PixiJS
  await new Promise(r => setTimeout(r, 2500));

  const gameContainer = await page.$('#game-container');
  if (!gameContainer) {
    throw new Error('Elemento #game-container não encontrado!');
  }

  // Se estiver na tela de criação de personagem, clica em "Iniciar Jogo"
  const charInput = await page.$('#shinobi-direct-input');
  if (charInput) {
    console.log('[AUDIT] Detectada tela de criação de personagem (#shinobi-direct-input). Clicando em "Iniciar Jogo"...');
    const bBox = await gameContainer.boundingBox();
    if (bBox) {
      await page.mouse.click(bBox.x + 625, bBox.y + 582);
      await new Promise(r => setTimeout(r, 3500));
    }
  }

  // 1. Captura da Tela Completa (1250x650)
  const fullPath = path.join(OUTPUT_DIR, 'hud_full.png');
  await gameContainer.screenshot({ path: fullPath });
  console.log(`[AUDIT] Screenshot completo salvo: ${fullPath}`);

  // 2. Captura dos Quadrantes Críticos
  const bBox = await gameContainer.boundingBox();
  if (bBox) {
    // Top-Left (Perfil, Moedas, Vigor, Poder Ninja)
    await page.screenshot({
      path: path.join(OUTPUT_DIR, 'hud_top_left.png'),
      clip: { x: bBox.x, y: bBox.y, width: 440, height: 230 }
    });

    // Top-Right (Radar, Relógio, Assistente, Caminho Hokage, Missões)
    await page.screenshot({
      path: path.join(OUTPUT_DIR, 'hud_top_right.png'),
      clip: { x: bBox.x + 940, y: bBox.y, width: 310, height: 350 }
    });

    // Bottom-Left (Chatbox, Regras da Folha, Abas de Canais, Input)
    await page.screenshot({
      path: path.join(OUTPUT_DIR, 'hud_bottom_left.png'),
      clip: { x: bBox.x, y: bBox.y + 400, width: 350, height: 250 }
    });

    // Bottom-Right (Barra de EXP, Botões de Atalho, Mochila, Ninjas)
    await page.screenshot({
      path: path.join(OUTPUT_DIR, 'hud_bottom_right.png'),
      clip: { x: bBox.x + 750, y: bBox.y + 550, width: 500, height: 100 }
    });

    console.log('[AUDIT] Quadrantes capturados com sucesso em tools/inspection/');
  }

  // 3. Captura da Mochila Canônica (Tecla B)
  console.log('[AUDIT] Abrindo Mochila (tecla B)...');
  await page.keyboard.press('KeyB');
  await new Promise(r => setTimeout(r, 800));
  await gameContainer.screenshot({ path: path.join(OUTPUT_DIR, 'hud_modal_backpack.png') });

  // Clica no Slot 1 (Ramen Ichiraku) para abrir o detalhe do item
  console.log('[AUDIT] Clicando no Ramen Ichiraku na Mochila...');
  const canvasBox = await gameContainer.boundingBox();
  if (canvasBox) {
    const ramenX = canvasBox.x + 395 + 118 + 25;
    const ramenY = canvasBox.y + 117 + 88 + 25;
    await page.mouse.click(ramenX, ramenY);
    await new Promise(r => setTimeout(r, 600));
    await gameContainer.screenshot({ path: path.join(OUTPUT_DIR, 'hud_modal_item_detail.png') });

    // Clica no botão "Usar"
    console.log('[AUDIT] Clicando em "Usar" para consumir Ramen...');
    const useX = canvasBox.x + 474 + 150;
    const useY = canvasBox.y + 202 + 182;
    await page.mouse.click(useX, useY);
    await new Promise(r => setTimeout(r, 800));
    await gameContainer.screenshot({ path: path.join(OUTPUT_DIR, 'hud_modal_backpack_after_use.png') });

    // Clica no botão "Organizar"
    console.log('[AUDIT] Clicando em "Organizar" na Mochila...');
    const sortX = canvasBox.x + 395 + 300 + 40;
    const sortY = canvasBox.y + 117 + 308 + 15;
    await page.mouse.click(sortX, sortY);
    await new Promise(r => setTimeout(r, 800));
    await gameContainer.screenshot({ path: path.join(OUTPUT_DIR, 'hud_modal_backpack_after_sort.png') });
  }

  await page.keyboard.press('KeyB'); // Fecha
  await new Promise(r => setTimeout(r, 300));

  // 4. Captura da Formação Canônica (Tecla T)
  console.log('[AUDIT] Abrindo Formação (tecla T)...');
  await page.keyboard.press('KeyT');
  await new Promise(r => setTimeout(r, 600));
  await gameContainer.screenshot({ path: path.join(OUTPUT_DIR, 'hud_modal_formation.png') });

  // Testa clique no Kakashi no banco e posicionamento no Tatami 1
  if (canvasBox) {
    const modalX = canvasBox.x + 172;
    const modalY = canvasBox.y + 47;
    console.log('[AUDIT] Selecionando Kakashi no banco...');
    await page.mouse.click(modalX + 138 + 20, modalY + 442 + 20);
    await new Promise(r => setTimeout(r, 500));

    console.log('[AUDIT] Posicionando Kakashi no Tatami 1...');
    await page.mouse.click(modalX + 260, modalY + 170);
    await new Promise(r => setTimeout(r, 800));
    await gameContainer.screenshot({ path: path.join(OUTPUT_DIR, 'hud_modal_formation_deployed.png') });
  }

  await page.keyboard.press('KeyT'); // Fecha
  await new Promise(r => setTimeout(r, 300));

  // 5. Captura do Perfil dos Ninjas (Tecla C) & Avanço Shinobi Real
  console.log('[AUDIT] Abrindo Ninjas (tecla C)...');
  await page.keyboard.press('KeyC');
  await new Promise(r => setTimeout(r, 600));
  await gameContainer.screenshot({ path: path.join(OUTPUT_DIR, 'hud_modal_hero.png') });

  if (canvasBox) {
    console.log('[AUDIT] Clicando em "Avanço Shinobi (+60)" para upgrade real no servidor...');
    const upgradeX = canvasBox.x + 603;
    const upgradeY = canvasBox.y + 341;
    await page.mouse.click(upgradeX, upgradeY);
    await new Promise(r => setTimeout(r, 800));
    await gameContainer.screenshot({ path: path.join(OUTPUT_DIR, 'hud_modal_hero_upgraded.png') });
  }

  await page.keyboard.press('KeyC'); // Fecha
  await new Promise(r => setTimeout(r, 300));

  // 6. Captura do Correio Canônico (Tecla M)
  console.log('[AUDIT] Abrindo Correio Ninja (tecla M)...');
  await page.keyboard.press('KeyM');
  await new Promise(r => setTimeout(r, 800));
  await gameContainer.screenshot({ path: path.join(OUTPUT_DIR, 'hud_modal_mail.png') });

  if (canvasBox) {
    const claimX = canvasBox.x + 265 + 590;
    const claimY = canvasBox.y + 95 + 342;
    console.log('[AUDIT] Clicando em "Receber" no correio com recompensa...');
    await page.mouse.click(claimX, claimY);
    await new Promise(r => setTimeout(r, 1000));
    await gameContainer.screenshot({ path: path.join(OUTPUT_DIR, 'hud_modal_mail_claimed.png') });
  }

  await page.keyboard.press('KeyM'); // Fecha
  await new Promise(r => setTimeout(r, 300));

  // 7. Captura do Rastreador de Missões & Diálogo Automatizado
  if (canvasBox) {
    console.log('[AUDIT] Clicando no Rastreador de Missões para auto-caminho...');
    const questLinkX = canvasBox.x + 1084;
    const questLinkY = canvasBox.y + 220;
    await page.mouse.click(questLinkX, questLinkY);
    // Aguarda o personagem caminhar até o Hokage e o diálogo abrir
    await new Promise(r => setTimeout(r, 2200));
    await gameContainer.screenshot({ path: path.join(OUTPUT_DIR, 'hud_quest_dialog.png') });

    // Clica no botão de ação do diálogo ("Aceitar")
    console.log('[AUDIT] Clicando no botão do diálogo de missão ("Aceitar")...');
    const dialogBtnX = canvasBox.x + 891;
    const dialogBtnY = canvasBox.y + 592;
    await page.mouse.click(dialogBtnX, dialogBtnY);
    await new Promise(r => setTimeout(r, 1000));
    await gameContainer.screenshot({ path: path.join(OUTPUT_DIR, 'hud_quest_accepted.png') });
  }

  // 8. Captura da Taverna Shinobi & Jokenpô de Almas (Tecla Y)
  console.log('[AUDIT] Abrindo Taverna Shinobi (tecla Y)...');
  await page.keyboard.press('KeyY');
  await new Promise(r => setTimeout(r, 800));
  await gameContainer.screenshot({ path: path.join(OUTPUT_DIR, 'hud_modal_tavern.png') });

  if (canvasBox) {
    // Clica no botão "Pedra ✊"
    console.log('[AUDIT] Jogando Pedra ✊ no Jokenpô contra Tsunade...');
    const moraBtnX = canvasBox.x + 340;
    const moraBtnY = canvasBox.y + 413;
    await page.mouse.click(moraBtnX, moraBtnY);
    await new Promise(r => setTimeout(r, 800));
    await gameContainer.screenshot({ path: path.join(OUTPUT_DIR, 'hud_modal_tavern_mora.png') });

    // Clica no botão "Recrutar" para Naruto
    console.log('[AUDIT] Clicando em "Recrutar" para recrutar Naruto...');
    const recruitBtnX = canvasBox.x + 911;
    const recruitBtnY = canvasBox.y + 171;
    await page.mouse.click(recruitBtnX, recruitBtnY);
    await new Promise(r => setTimeout(r, 800));
    await gameContainer.screenshot({ path: path.join(OUTPUT_DIR, 'hud_modal_tavern_recruited.png') });
  }

  await page.keyboard.press('KeyY'); // Fecha
  await new Promise(r => setTimeout(r, 300));

  // 9. Captura da Guilda Shinobi (Tecla O) & Doação Real
  console.log('[AUDIT] Abrindo Guilda Shinobi (tecla O)...');
  await page.keyboard.press('KeyO');
  await new Promise(r => setTimeout(r, 800));
  await gameContainer.screenshot({ path: path.join(OUTPUT_DIR, 'hud_modal_guild.png') });

  if (canvasBox) {
    console.log('[AUDIT] Clicando em "Doar Ryo" na Guilda (envio de pacote real)...');
    const donateX = canvasBox.x + 338;
    const donateY = canvasBox.y + 312;
    await page.mouse.click(donateX, donateY);
    await new Promise(r => setTimeout(r, 800));
    await gameContainer.screenshot({ path: path.join(OUTPUT_DIR, 'hud_modal_guild_donated.png') });
  }

  await page.keyboard.press('KeyO'); // Fecha
  await new Promise(r => setTimeout(r, 300));

  // 10. Captura de Atividades & Código Ninja (CDK) Real
  if (canvasBox) {
    console.log('[AUDIT] Clicando no ícone "Código" no topo para abrir CDK...');
    const cdkIconX = canvasBox.x + 796;
    const cdkIconY = canvasBox.y + 26;
    await page.mouse.click(cdkIconX, cdkIconY);
    await new Promise(r => setTimeout(r, 800));
    await gameContainer.screenshot({ path: path.join(OUTPUT_DIR, 'hud_modal_gift_cdk.png') });

    console.log('[AUDIT] Clicando em "Resgatar" no código CDK (envio de pacote real)...');
    const claimBtnX = canvasBox.x + 810;
    const claimBtnY = canvasBox.y + 303;
    await page.mouse.click(claimBtnX, claimBtnY);
    await new Promise(r => setTimeout(r, 800));
    await gameContainer.screenshot({ path: path.join(OUTPUT_DIR, 'hud_modal_gift_claimed.png') });
  }

  await page.keyboard.press('Escape'); // Fecha todos
  await new Promise(r => setTimeout(r, 500));

  // 11. Teste de Combate PvE Real com Relatório de Turnos & Vitória (Tecla P)
  console.log('[AUDIT] Disparando Combate PvE em turnos reais (tecla P)...');
  await page.keyboard.press('KeyP');
  await new Promise(r => setTimeout(r, 1200));
  await gameContainer.screenshot({ path: path.join(OUTPUT_DIR, 'hud_battle_victory.png') });

  if (canvasBox) {
    console.log('[AUDIT] Clicando em "Confirmar" no modal de vitória de combate...');
    const okBtnX = canvasBox.x + 625;
    const okBtnY = canvasBox.y + 436;
    await page.mouse.click(okBtnX, okBtnY);
    await new Promise(r => setTimeout(r, 600));
  }

  await page.keyboard.press('Escape'); // Garante que tudo esteja fechado
  await new Promise(r => setTimeout(r, 500));
  await gameContainer.screenshot({ path: path.join(OUTPUT_DIR, 'hud_all_real_systems_verified.png') });

  await browser.close();
  console.log('[AUDIT] Auditoria de HUD e Modais concluída.');
}

capture().catch(err => {
  console.error('[AUDIT] Erro na captura:', err);
  process.exit(1);
});
