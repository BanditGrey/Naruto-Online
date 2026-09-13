import { Container, Graphics, Sprite, Text, Assets, FederatedPointerEvent } from 'pixi.js';

export interface BaseModalOptions {
  title: string;
  width?: number;
  height?: number;
  hasBackdrop?: boolean;
  onClose?: () => void;
}

export abstract class BaseModal extends Container {
  protected modalWidth: number;
  protected modalHeight: number;
  protected titleText: string;
  protected backdrop!: Graphics;
  protected windowContainer!: Container;
  protected windowBg!: Graphics;
  protected headerBar!: Graphics;
  protected titleLabel!: Text;
  protected closeBtn!: Container;
  public isOpen: boolean = false;
  private onCloseCallback?: () => void;

  constructor(options: BaseModalOptions) {
    super();

    this.titleText = options.title;
    this.modalWidth = options.width || 800;
    this.modalHeight = options.height || 540;
    this.onCloseCallback = options.onClose;

    this.visible = false;
    this.zIndex = 50000;

    // 1. Fundo escurecido semitransparente (Backdrop)
    if (options.hasBackdrop !== false) {
      this.backdrop = new Graphics();
      this.backdrop.rect(0, 0, 1250, 650);
      this.backdrop.fill({ color: 0x000000, alpha: 0.65 });
      this.backdrop.eventMode = 'static';
      this.backdrop.cursor = 'default';
      this.backdrop.on('pointerdown', (e: FederatedPointerEvent) => {
        e.stopPropagation();
      });
      this.addChild(this.backdrop);
    }

    // 2. Container central da janela
    this.windowContainer = new Container();
    this.windowContainer.position.set(
      (1250 - this.modalWidth) / 2,
      (650 - this.modalHeight) / 2
    );
    this.addChild(this.windowContainer);

    // 3. Moldura estilizada oriental de madeira e ouro
    this.buildWindowFrame();

    // 4. Cabeçalho com título e botão fechar
    this.buildHeader();
  }

  protected buildWindowFrame(): void {
    // Sombra projetada da janela
    const shadow = new Graphics();
    shadow.roundRect(8, 8, this.modalWidth, this.modalHeight, 10);
    shadow.fill({ color: 0x000000, alpha: 0.5 });
    this.windowContainer.addChild(shadow);

    // Fundo da janela (pergaminho escuro tradicional)
    this.windowBg = new Graphics();
    this.windowBg.roundRect(0, 0, this.modalWidth, this.modalHeight, 10);
    this.windowBg.fill({ color: 0x1c1917, alpha: 0.96 }); // Stone-900 escuro oriental
    this.windowBg.stroke({ color: 0xb45309, width: 3 }); // Borda dourada/âmbar
    this.windowContainer.addChild(this.windowBg);

    // Borda interna ornamental fina
    const innerBorder = new Graphics();
    innerBorder.roundRect(4, 4, this.modalWidth - 8, this.modalHeight - 8, 8);
    innerBorder.stroke({ color: 0xd97706, width: 1, alpha: 0.6 });
    this.windowContainer.addChild(innerBorder);
  }

  protected buildHeader(): void {
    // Faixa superior de título
    this.headerBar = new Graphics();
    this.headerBar.roundRect(4, 4, this.modalWidth - 8, 42, 6);
    this.headerBar.fill({ color: 0x78350f, alpha: 0.85 }); // Âmbar amadeirado
    this.headerBar.stroke({ color: 0xf59e0b, width: 1 });
    this.windowContainer.addChild(this.headerBar);

    // Ícone ninja ornamental no cabeçalho
    const iconTag = new Graphics();
    iconTag.poly([16, 12, 28, 25, 16, 38]);
    iconTag.fill(0xf59e0b);
    this.windowContainer.addChild(iconTag);

    // Título da janela
    this.titleLabel = new Text({
      text: this.titleText,
      style: {
        fontFamily: 'Arial, sans-serif',
        fontSize: 16,
        fontWeight: 'bold',
        fill: '#fef08a', // Dourado claro
        stroke: { color: '#451a03', width: 3 },
      },
    });
    this.titleLabel.position.set(36, 13);
    this.windowContainer.addChild(this.titleLabel);

    // Botão Fechar [X]
    this.closeBtn = new Container();
    this.closeBtn.position.set(this.modalWidth - 36, 11);
    this.closeBtn.eventMode = 'static';
    this.closeBtn.cursor = 'pointer';

    const closeTex = Assets.get('/assets/ui/btn_close.png');
    if (closeTex) {
      const spr = new Sprite(closeTex);
      spr.width = 28;
      spr.height = 28;
      this.closeBtn.addChild(spr);
    } else {
      const btnBg = new Graphics();
      btnBg.circle(14, 14, 13);
      btnBg.fill({ color: 0x991b1b, alpha: 0.9 });
      btnBg.stroke({ color: 0xfca5a5, width: 1.5 });
      this.closeBtn.addChild(btnBg);

      const xText = new Text({
        text: '✕',
        style: { fill: '#ffffff', fontSize: 13, fontWeight: 'bold' },
      });
      xText.position.set(8, 6);
      this.closeBtn.addChild(xText);
    }

    this.closeBtn.on('pointerdown', (e: FederatedPointerEvent) => {
      e.stopPropagation();
      this.close();
    });

    this.closeBtn.on('pointerenter', () => {
      this.closeBtn.alpha = 0.8;
      this.closeBtn.scale.set(1.05);
    });
    this.closeBtn.on('pointerleave', () => {
      this.closeBtn.alpha = 1.0;
      this.closeBtn.scale.set(1.0);
    });

    this.windowContainer.addChild(this.closeBtn);
  }

  /**
   * Método abstrato implementado pelas subclasses para renderizar o conteúdo específico
   */
  protected abstract initContent(): void;

  public open(): void {
    this.visible = true;
    this.isOpen = true;
    this.alpha = 1;
    this.windowContainer.scale.set(1.0);
  }

  public close(): void {
    this.visible = false;
    this.isOpen = false;
    if (this.onCloseCallback) {
      this.onCloseCallback();
    }
  }

  public toggle(): void {
    if (this.isOpen) {
      this.close();
    } else {
      this.open();
    }
  }
}

