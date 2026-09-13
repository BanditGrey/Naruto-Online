import { Application, Container, Graphics } from 'pixi.js';

export interface Scene extends Container {
  init?(): Promise<void> | void;
  update?(delta: number): void;
}

/**
 * Engine central do jogo baseada em PixiJS (v8)
 * Configurada com resolução canônica oficial de 1250 x 650 e letterboxing automático
 */
export class GameApp {
  public static readonly VIRTUAL_WIDTH: number = 1250;
  public static readonly VIRTUAL_HEIGHT: number = 650;

  public app: Application;
  public stageContainer: Container;
  private stageMask: Graphics;
  public currentScene: Scene | null = null;
  private isInitialized: boolean = false;
  private resizeHandler!: () => void;

  constructor() {
    this.app = new Application();
    this.stageContainer = new Container();
    this.stageMask = new Graphics();
  }

  public async init(): Promise<void> {
    if (this.isInitialized) return;

    await this.app.init({
      backgroundColor: 0x070a12,
      resizeTo: window,
      antialias: true,
      resolution: window.devicePixelRatio || 1,
      autoDensity: true,
    });

    document.body.appendChild(this.app.canvas);

    // Máscara retangular fixa para os limites oficiais de 1250x650
    this.stageMask.rect(0, 0, GameApp.VIRTUAL_WIDTH, GameApp.VIRTUAL_HEIGHT);
    this.stageMask.fill(0xffffff);
    this.stageContainer.mask = this.stageMask;
    this.stageContainer.addChild(this.stageMask);

    this.app.stage.addChild(this.stageContainer);

    this.setupResize();
    this.updateLayout();

    this.isInitialized = true;
    console.log(
      `[GameApp] Engine iniciada com sucesso! Resolução canônica: ${GameApp.VIRTUAL_WIDTH}x${GameApp.VIRTUAL_HEIGHT}`
    );
  }

  public get stage(): Container {
    return this.stageContainer;
  }

  public get rawStage(): Container {
    return this.app.stage;
  }

  public get screen() {
    return {
      width: GameApp.VIRTUAL_WIDTH,
      height: GameApp.VIRTUAL_HEIGHT,
      windowWidth: this.app.screen.width,
      windowHeight: this.app.screen.height,
    };
  }

  /**
   * Troca de cena controlada com ciclo de vida e destruição de listeners
   */
  public async changeScene(newScene: Scene): Promise<void> {
    if (this.currentScene) {
      console.log(`[GameApp] Destruindo cena anterior: ${this.currentScene.constructor.name}`);
      this.stageContainer.removeChild(this.currentScene);
      try {
        this.currentScene.destroy({ children: true });
      } catch (e) {
        console.warn('[GameApp] Aviso ao destruir cena:', e);
      }
      this.currentScene = null;
    }

    this.currentScene = newScene;
    this.stageContainer.addChild(newScene);

    if (typeof newScene.init === 'function') {
      await newScene.init();
    }

    console.log(`[GameApp] Nova cena ativa: ${newScene.constructor.name}`);
  }

  /**
   * Letterboxing / Pillarboxing responsivo mantendo a proporção 1250x650
   */
  public updateLayout(): void {
    const windowW = window.innerWidth;
    const windowH = window.innerHeight;

    const scaleX = windowW / GameApp.VIRTUAL_WIDTH;
    const scaleY = windowH / GameApp.VIRTUAL_HEIGHT;
    const uniformScale = Math.min(scaleX, scaleY);

    this.stageContainer.scale.set(uniformScale);

    const actualW = GameApp.VIRTUAL_WIDTH * uniformScale;
    const actualH = GameApp.VIRTUAL_HEIGHT * uniformScale;

    const offsetX = Math.floor((windowW - actualW) / 2);
    const offsetY = Math.floor((windowH - actualH) / 2);

    this.stageContainer.position.set(offsetX, offsetY);
  }

  private setupResize(): void {
    this.resizeHandler = () => {
      this.updateLayout();
    };
    window.addEventListener('resize', this.resizeHandler);
  }

  public destroy(): void {
    if (this.resizeHandler) {
      window.removeEventListener('resize', this.resizeHandler);
    }
    this.app.destroy(true, { children: true });
  }
}

export const gameApp = new GameApp();
