import puppeteer from 'puppeteer-core';
import fs from 'fs';
import path from 'path';

const EDGE_PATH = 'C:\\Program Files (x86)\\Microsoft\\Edge\\Application\\msedge.exe';
const REF_DIR = path.resolve('./tools/official_references');

if (!fs.existsSync(REF_DIR)) {
  fs.mkdirSync(REF_DIR, { recursive: true });
}

async function fetchImages() {
  console.log('[REF] Iniciando busca por referências visuais oficiais do Naruto Online...');
  const browser = await puppeteer.launch({
    executablePath: EDGE_PATH,
    headless: true,
    args: ['--no-sandbox', '--disable-setuid-sandbox', '--window-size=1400,900']
  });

  const page = await browser.newPage();
  await page.setViewport({ width: 1400, height: 900 });

  const queries = [
    { name: 'formation_ref', q: 'naruto online tactical deployment formation screenshot' },
    { name: 'hud_gameplay_ref', q: 'naruto online game ui hud gameplay screenshot' },
    { name: 'inventory_ref', q: 'naruto online backpack inventory window screenshot' }
  ];

  for (const item of queries) {
    try {
      console.log(`[REF] Buscando: ${item.q}...`);
      const searchUrl = `https://www.bing.com/images/search?q=${encodeURIComponent(item.q)}&form=HDRSC2`;
      await page.goto(searchUrl, { waitUntil: 'domcontentloaded', timeout: 20000 });
      await new Promise(r => setTimeout(r, 2000));

      const imgUrls = await page.evaluate(() => {
        const results = [];
        const mImages = document.querySelectorAll('a.iusc');
        for (let i = 0; i < Math.min(mImages.length, 6); i++) {
          try {
            const m = JSON.parse(mImages[i].getAttribute('m'));
            if (m && m.murl) results.push(m.murl);
          } catch {}
        }
        return results;
      });

      console.log(`[REF] Encontradas ${imgUrls.length} imagens para ${item.name}`);

      let downloaded = 0;
      for (let i = 0; i < imgUrls.length && downloaded < 2; i++) {
        const url = imgUrls[i];
        try {
          const resp = await fetch(url, { headers: { 'User-Agent': 'Mozilla/5.0' }, signal: AbortSignal.timeout(8000) });
          if (resp.ok) {
            const buffer = Buffer.from(await resp.arrayBuffer());
            const ext = url.toLowerCase().includes('.png') ? 'png' : 'jpg';
            const savePath = path.join(REF_DIR, `${item.name}_${downloaded + 1}.${ext}`);
            fs.writeFileSync(savePath, buffer);
            console.log(`[REF] Salvo: ${savePath} (${buffer.length} bytes)`);
            downloaded++;
          }
        } catch (e) {
          console.warn(`[REF] Falha ao baixar ${url}:`, e.message);
        }
      }
    } catch (err) {
      console.error(`[REF] Erro na busca de ${item.name}:`, err.message);
    }
  }

  await browser.close();
  console.log('[REF] Download de referências concluído!');
}

fetchImages().catch(err => {
  console.error('[REF] Erro fatal:', err);
  process.exit(1);
});
