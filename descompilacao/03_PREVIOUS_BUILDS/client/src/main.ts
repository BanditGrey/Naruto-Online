import { gameApp } from './core/GameApp.ts';
import { LoadingScene } from './display/LoadingScene.ts';

async function bootstrap() {
  console.log('[Bootstrap] Inicializando Naruto Online Web Client...');

  // 1. Inicializa o motor gráfico PixiJS com resolução canônica (1250 x 650)
  await gameApp.init();
  (window as any).gameApp = gameApp;

  // 2. Carrega a cena inicial de carregamento e splash
  const loadingScene = new LoadingScene();
  await gameApp.changeScene(loadingScene);

  console.log('[Bootstrap] LoadingScene inicializada!');
}

window.addEventListener('DOMContentLoaded', () => {
  bootstrap().catch((err) => {
    console.error('[Bootstrap Error]', err);
  });
});
