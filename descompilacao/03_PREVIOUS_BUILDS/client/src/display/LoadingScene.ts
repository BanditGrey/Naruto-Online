import { Container, Graphics, Text, Sprite, Ticker } from 'pixi.js';
import { gameApp, type Scene } from '../core/GameApp.ts';
import { assetManager } from '../core/AssetManager.ts';
import { clientSocket } from '../network/clientSocket.ts';
import { LoginScene } from './LoginScene.ts';

/**
 * Dicas autênticas extraídas de TProcessorMiniLoad.as (STRING_LoadingTips)
 */
const AUTHENTIC_TIPS = [
  'Dica Ninja: Ninjutsu e Taijutsu causam dano físico aos inimigos, enquanto Genjutsu causa dano estratégico!',
  'Dica Ninja: A formação da sua equipe é a chave mestra para vencer qualquer desafio!',
  'Dica Ninja: Equipamentos forjados e talismãs sagrados são essenciais para o seu avanço.',
  'Dica Ninja: Invocar Bestas concede atributos adicionais massivos na Arena e eventos.',
  'Dica Ninja: Trocar uma única habilidade na batalha pode mudar completamente o resultado!',
  'Dica Ninja: Jades refinados aumentam expressivamente os atributos de Chakra e Força.',
  'Dica Ninja: Quanto maior for o seu posto ninja, mais aliados você poderá liderar em combate!',
  'Dica Ninja: Desafie a Arena de Konoha para acumular Tesouros e elevar sua Reputação.',
];

/**
 * Tela de Carregamento Oficial do Jogo (Fase 1)
 * Fiel ao index.swf e MC_Loading.as
 * Resolução Virtual Fixa: 1250 x 650
 */
export class LoadingScene extends Container implements Scene {
  private bgSprite!: Sprite;
  private logoSprite!: Sprite;

  // Componente MC_Loading
  private loadingContainer!: Container;
  private barFrame!: Sprite;
  private barTrack!: Sprite;
  private barFill!: Sprite;
  private barFillMask!: Graphics;
  private headIcon!: Sprite;
  private emblemSprite!: Sprite;

  // Textos oficiais
  private txtPercent!: Text;
  private txtStatus!: Text;
  private txtTip!: Text;

  // Progresso e animação
  private currentProgress: number = 0;
  private targetProgress: number = 0;
  private isLoaded: boolean = false;
  private tickerFn!: () => void;
  private tipTimer: number = 0;
  private tipIndex: number = 0;
  private emblemPulse: number = 0;
  private headBob: number = 0;

  constructor() {
    super();
  }

  public async init(): Promise<void> {
    // 1. Carrega imediatamente os assets do loader oficial
    await assetManager.loadBundle('loader');

    // 2. Constrói a cena visual após ter as texturas
    this.setupVisuals();

    // 3. Inicia o processo de carregamento dos módulos do jogo
    this.startLoadingProcess();
  }

  private setupVisuals(): void {
    const W = 1250;
    const H = 650;

    // 1. Fundo base escuro
    const baseBg = new Graphics();
    baseBg.rect(0, 0, W, H);
    baseBg.fill(0x0a0d14);
    this.addChild(baseBg);

    // 2. Fundo Splash Oficial (flash_bg.jpg - 1500 x 650)
    const splashTex = assetManager.getTexture('loader/bg_splash');
    this.bgSprite = new Sprite(splashTex);
    this.bgSprite.width = W;
    this.bgSprite.height = H;
    this.addChild(this.bgSprite);

    // 3. Vinheta sutil na parte inferior para garantir legibilidade dos textos
    const vignette = new Graphics();
    vignette.rect(0, H - 140, W, 140);
    vignette.fill({ color: 0x000000, alpha: 0.55 });
    this.addChild(vignette);

    // 4. Logotipo oficial de Ninja World / Naruto Online
    const logoTex = assetManager.getTexture('loader/logo_official');
    this.logoSprite = new Sprite(logoTex);
    this.logoSprite.scale.set(1.4);
    this.logoSprite.position.set(30, 24);
    this.addChild(this.logoSprite);

    // 5. Container MC_Loading posicionado na parte inferior central
    this.loadingContainer = new Container();
    const barFrameW = 398;
    const barFrameH = 95;
    const containerX = (W - barFrameW) / 2;
    const containerY = H - 110;
    this.loadingContainer.position.set(containerX, containerY);
    this.addChild(this.loadingContainer);

    // Pincelada tradicional sumi-e (1.png) como base de fundo da barra
    const brushTex = assetManager.getTexture('loader/logo');
    const brushSprite = new Sprite(brushTex);
    brushSprite.anchor.set(0.5, 0.5);
    brushSprite.position.set(barFrameW / 2, 48);
    brushSprite.alpha = 0.85;
    this.loadingContainer.addChild(brushSprite);

    // 6. Moldura oficial da barra (15.png - 398 x 95)
    this.barFrame = new Sprite(assetManager.getTexture('loader/bar_frame'));
    this.barFrame.position.set(0, 0);

    // 7. Trilho da barra (30.png - 342 x 17)
    this.barTrack = new Sprite(assetManager.getTexture('loader/bar_track'));
    this.barTrack.position.set(28, 40);

    // 8. Preenchimento da barra (25.png - 341 x 15)
    this.barFill = new Sprite(assetManager.getTexture('loader/bar_fill'));
    this.barFill.position.set(29, 41);
    this.barFill.width = 0;
    this.barFill.visible = false;

    this.loadingContainer.addChild(this.barTrack);
    this.loadingContainer.addChild(this.barFill);
    this.loadingContainer.addChild(this.barFrame);

    // 9. Ícone Naruto / Kyuubi (head.png - 108 x 110)
    this.headIcon = new Sprite(assetManager.getTexture('loader/head'));
    this.headIcon.scale.set(0.65);
    this.headIcon.anchor.set(0.5, 0.5);
    this.headIcon.position.set(29, 48);
    this.loadingContainer.addChild(this.headIcon);

    // 10. Emblema Kyuubi / Efeito de fogo (emblem.png - 184 x 128)
    this.emblemSprite = new Sprite(assetManager.getTexture('loader/emblem'));
    this.emblemSprite.scale.set(0.45);
    this.emblemSprite.anchor.set(0.5, 0.5);
    this.emblemSprite.position.set(barFrameW - 10, 48);
    this.loadingContainer.addChild(this.emblemSprite);

    // 11. Texto da porcentagem (TF_ProgressBig)
    this.txtPercent = new Text({
      text: '0%',
      style: {
        fontFamily: 'Arial, sans-serif',
        fontSize: 14,
        fontWeight: 'bold',
        fill: '#ffe169',
        stroke: { color: '#000000', width: 3 },
      },
    });
    this.txtPercent.anchor.set(0.5, 0.5);
    this.txtPercent.position.set(barFrameW / 2, 48);
    this.loadingContainer.addChild(this.txtPercent);

    // 12. Texto de status (TF_ProgressSmall)
    this.txtStatus = new Text({
      text: 'Carregando arquivos da engine...',
      style: {
        fontFamily: 'Arial, sans-serif',
        fontSize: 12,
        fill: '#d1d5db',
        stroke: { color: '#000000', width: 2 },
      },
    });
    this.txtStatus.anchor.set(0.5, 1);
    this.txtStatus.position.set(W / 2, containerY - 8);
    this.addChild(this.txtStatus);

    // 13. Dica Ninja Rotativa (TF_LoadingTips)
    this.tipIndex = Math.floor(Math.random() * AUTHENTIC_TIPS.length);
    this.txtTip = new Text({
      text: AUTHENTIC_TIPS[this.tipIndex],
      style: {
        fontFamily: 'Arial, sans-serif',
        fontSize: 11,
        fill: '#9ca3af',
        fontStyle: 'italic',
        stroke: { color: '#000000', width: 2 },
      },
    });
    this.txtTip.anchor.set(0.5, 0);
    this.txtTip.position.set(W / 2, containerY + barFrameH + 2);
    this.addChild(this.txtTip);

    // 14. Ticker para interpolação suave da barra e rotação de dicas
    this.tickerFn = () => {
      // Interpolação contínua e suave do progresso
      if (this.currentProgress < this.targetProgress) {
        this.currentProgress += (this.targetProgress - this.currentProgress) * 0.12;
        if (Math.abs(this.targetProgress - this.currentProgress) < 0.002) {
          this.currentProgress = this.targetProgress;
        }
        this.updateProgressBar(this.currentProgress);
      }

      // Animação de corrida de Naruto (bobbing e inclinação)
      this.headBob += 0.22;
      if (this.headIcon) {
        this.headIcon.position.y = 48 + Math.sin(this.headBob) * 3;
        this.headIcon.rotation = Math.sin(this.headBob) * 0.08;
      }

      // Pulsação suave do emblema
      this.emblemPulse += 0.05;
      if (this.emblemSprite) {
        this.emblemSprite.scale.set(0.45 + Math.sin(this.emblemPulse) * 0.02);
      }

      // Rotação de dicas a cada 4 segundos
      this.tipTimer += 1 / 60;
      if (this.tipTimer >= 4.0) {
        this.tipTimer = 0;
        this.tipIndex = (this.tipIndex + 1) % AUTHENTIC_TIPS.length;
        this.txtTip.text = AUTHENTIC_TIPS[this.tipIndex];
      }
    };
    Ticker.shared.add(this.tickerFn);
  }

  private updateProgressBar(progress: number): void {
    const p = Math.max(0, Math.min(1, progress));
    const maxBarW = 341;
    const currentW = Math.floor(maxBarW * p);

    // Atualiza largura da barra diretamente sem travamento de máscara
    this.barFill.width = Math.max(1, currentW);
    this.barFill.visible = currentW > 0;

    // Move Naruto correndo ao longo do trilho
    if (this.headIcon) {
      this.headIcon.position.x = 29 + currentW;
    }

    // Atualiza porcentagem
    const pct = Math.floor(p * 100);
    this.txtPercent.text = `${pct}%`;
  }

  private async startLoadingProcess(): Promise<void> {
    // Etapa 1: Pré-aquecimento da Engine e protocolos
    this.txtStatus.text = 'Inicializando protocolos de rede shinobi...';
    this.targetProgress = 0.15;
    await new Promise((r) => setTimeout(r, 200));
    this.targetProgress = 0.30;
    await new Promise((r) => setTimeout(r, 250));

    // Etapa 2: Conexão WebSocket com o servidor do jogo
    this.txtStatus.text = 'Conectando ao Gateway de Konohagakure...';
    this.targetProgress = 0.48;
    try {
      if (!clientSocket.isConnected()) {
        await clientSocket.connect();
      }
    } catch (err) {
      console.warn('[LoadingScene] Aviso ao conectar socket:', err);
    }
    this.targetProgress = 0.62;
    await new Promise((r) => setTimeout(r, 250));

    // Etapa 3: Carregamento dos dados de personagem e assets de criação
    this.txtStatus.text = 'Carregando catálogo de técnicas e ninjas...';
    this.targetProgress = 0.78;
    await assetManager.loadBundle('login');
    await assetManager.loadBundle('create_char');
    this.targetProgress = 0.90;
    await new Promise((r) => setTimeout(r, 250));

    // Etapa 4: Conclusão
    this.txtStatus.text = 'Mundo ninja pronto! Entrando em Konohagakure...';
    this.targetProgress = 1.0;
    this.isLoaded = true;

    // Aguarda o término fluido da animação da barra alcançar 100%
    while (this.currentProgress < 0.99) {
      await new Promise((r) => setTimeout(r, 50));
    }
    await new Promise((r) => setTimeout(r, 400));
    this.transitionToNextScene();
  }

  private transitionToNextScene(): void {
    if (this.tickerFn) {
      Ticker.shared.remove(this.tickerFn);
    }

    // Transiciona para a tela oficial de login e autenticação
    gameApp.changeScene(new LoginScene());
  }

  public destroy(options?: any): void {
    if (this.tickerFn) {
      Ticker.shared.remove(this.tickerFn);
    }
    super.destroy(options);
  }
}
