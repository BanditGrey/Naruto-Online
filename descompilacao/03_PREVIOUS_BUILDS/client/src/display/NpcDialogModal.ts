import { Container, Graphics, Sprite, Text, Assets, FederatedPointerEvent } from 'pixi.js';

export interface DialogAction {
  label: string;
  onClick: () => void;
  color?: number;
}

export interface NpcDialogData {
  npcName: string;
  roleTitle: string;
  avatarPath?: string;
  dialogue: string;
  actions: DialogAction[];
}

export class NpcDialogModal extends Container {
  private backdrop!: Graphics;
  private dialogBox!: Container;
  private portraitBg!: Graphics;
  private portraitSprite!: Sprite;
  private nameLabel!: Text;
  private roleLabel!: Text;
  private dialogueLabel!: Text;
  private actionsContainer!: Container;
  private closeBtn!: Container;
  public isOpen: boolean = false;

  constructor() {
    super();

    this.visible = false;
    this.zIndex = 60000;

    // 1. Fundo semitransparente sutil
    this.backdrop = new Graphics();
    this.backdrop.rect(0, 0, 1250, 650);
    this.backdrop.fill({ color: 0x000000, alpha: 0.45 });
    this.backdrop.eventMode = 'static';
    this.backdrop.on('pointerdown', (e: FederatedPointerEvent) => {
      e.stopPropagation();
      this.hide();
    });
    this.addChild(this.backdrop);

    // 2. Caixa de Diálogo principal posicionada no terço inferior (X: 125, Y: 435, W: 1000, H: 195)
    this.dialogBox = new Container();
    this.dialogBox.position.set(125, 435);
    this.dialogBox.eventMode = 'static';
    this.dialogBox.on('pointerdown', (e: FederatedPointerEvent) => {
      e.stopPropagation();
    });
    this.addChild(this.dialogBox);

    this.buildDialogBox();
  }

  private buildDialogBox(): void {
    const boxW = 1000;
    const boxH = 195;

    // Sombra da caixa
    const shadow = new Graphics();
    shadow.roundRect(6, 6, boxW, boxH, 12);
    shadow.fill({ color: 0x000000, alpha: 0.6 });
    this.dialogBox.addChild(shadow);

    // Corpo da janela de diálogo (estilo pergaminho laqueado)
    const boxBg = new Graphics();
    boxBg.roundRect(0, 0, boxW, boxH, 12);
    boxBg.fill({ color: 0x18181b, alpha: 0.96 }); // Fundo quase negro/carvão
    boxBg.stroke({ color: 0xd97706, width: 3 }); // Dourado âmbar
    this.dialogBox.addChild(boxBg);

    // Faixa ornamental superior
    const headerLine = new Graphics();
    headerLine.rect(4, 4, boxW - 8, 36);
    headerLine.fill({ color: 0x78350f, alpha: 0.6 });
    headerLine.stroke({ color: 0xb45309, width: 1 });
    this.dialogBox.addChild(headerLine);

    // Moldura do Retrato à esquerda (W: 150, H: 155)
    this.portraitBg = new Graphics();
    this.portraitBg.roundRect(16, 16, 150, 160, 8);
    this.portraitBg.fill({ color: 0x27272a, alpha: 0.95 });
    this.portraitBg.stroke({ color: 0xf59e0b, width: 2.5 });
    this.dialogBox.addChild(this.portraitBg);

    this.portraitSprite = new Sprite();
    this.portraitSprite.position.set(18, 18);
    this.portraitSprite.width = 146;
    this.portraitSprite.height = 156;
    this.dialogBox.addChild(this.portraitSprite);

    // Nome do NPC
    this.nameLabel = new Text({
      text: 'NPC',
      style: {
        fontFamily: 'Arial, sans-serif',
        fontSize: 18,
        fontWeight: 'bold',
        fill: '#fef08a',
        stroke: { color: '#451a03', width: 3 },
      },
    });
    this.nameLabel.position.set(185, 12);
    this.dialogBox.addChild(this.nameLabel);

    // Cargo / Título do NPC
    this.roleLabel = new Text({
      text: '[Título]',
      style: {
        fontFamily: 'Arial, sans-serif',
        fontSize: 13,
        fontWeight: '600',
        fill: '#fbbf24',
        stroke: { color: '#000000', width: 2 },
      },
    });
    this.roleLabel.position.set(360, 15);
    this.dialogBox.addChild(this.roleLabel);

    // Texto da fala
    this.dialogueLabel = new Text({
      text: '',
      style: {
        fontFamily: 'Arial, sans-serif',
        fontSize: 14,
        fill: '#f4f4f5',
        wordWrap: true,
        wordWrapWidth: 540,
        lineHeight: 22,
      },
    });
    this.dialogueLabel.position.set(185, 52);
    this.dialogBox.addChild(this.dialogueLabel);

    // Container de botões de ação (alinhado à direita: X=740)
    this.actionsContainer = new Container();
    this.actionsContainer.position.set(740, 48);
    this.dialogBox.addChild(this.actionsContainer);

    // Botão Fechar no canto superior direito
    this.closeBtn = new Container();
    this.closeBtn.position.set(boxW - 32, 10);
    this.closeBtn.eventMode = 'static';
    this.closeBtn.cursor = 'pointer';

    const xBg = new Graphics();
    xBg.circle(10, 10, 12);
    xBg.fill({ color: 0x991b1b, alpha: 0.9 });
    xBg.stroke({ color: 0xfca5a5, width: 1.5 });
    this.closeBtn.addChild(xBg);

    const xTxt = new Text({
      text: '✕',
      style: { fill: '#ffffff', fontSize: 11, fontWeight: 'bold' },
    });
    xTxt.position.set(6, 3);
    this.closeBtn.addChild(xTxt);

    this.closeBtn.on('pointerdown', () => this.hide());
    this.dialogBox.addChild(this.closeBtn);
  }

  public show(data: NpcDialogData): void {
    this.isOpen = true;
    this.visible = true;

    this.nameLabel.text = data.npcName;
    this.roleLabel.text = `[${data.roleTitle}]`;
    this.roleLabel.position.x = this.nameLabel.position.x + this.nameLabel.width + 12;
    this.dialogueLabel.text = data.dialogue;

    // Atualiza textura do retrato
    if (data.avatarPath) {
      const tex = Assets.get(data.avatarPath);
      if (tex) {
        this.portraitSprite.texture = tex;
        this.portraitSprite.visible = true;
      } else {
        this.portraitSprite.visible = false;
      }
    } else {
      this.portraitSprite.visible = false;
    }

    // Limpa ações anteriores
    this.actionsContainer.removeChildren();

    // Renderiza botões de ação
    let curY = 0;
    for (const act of data.actions) {
      const btn = this.createActionButton(act.label, act.onClick, act.color || 0xd97706);
      btn.position.set(0, curY);
      this.actionsContainer.addChild(btn);
      curY += 44;
    }

    this.alpha = 1;
    this.dialogBox.position.y = 435;
  }

  public hide(): void {
    this.isOpen = false;
    this.visible = false;
  }

  private createActionButton(label: string, onClick: () => void, color: number): Container {
    const btn = new Container();
    btn.eventMode = 'static';
    btn.cursor = 'pointer';

    const btnW = 230;
    const btnH = 36;

    const bg = new Graphics();
    bg.roundRect(0, 0, btnW, btnH, 6);
    bg.fill({ color, alpha: 0.9 });
    bg.stroke({ color: 0xfef08a, width: 1.5 });
    btn.addChild(bg);

    const txt = new Text({
      text: label,
      style: {
        fontFamily: 'Arial, sans-serif',
        fontSize: 12,
        fontWeight: 'bold',
        fill: '#ffffff',
        stroke: { color: '#000000', width: 2 },
      },
    });
    txt.anchor.set(0.5, 0.5);
    txt.position.set(btnW / 2, btnH / 2);
    btn.addChild(txt);

    btn.on('pointerenter', () => {
      btn.alpha = 0.85;
      btn.scale.set(1.02);
    });
    btn.on('pointerleave', () => {
      btn.alpha = 1.0;
      btn.scale.set(1.0);
    });
    btn.on('pointerdown', (e: FederatedPointerEvent) => {
      e.stopPropagation();
      this.hide();
      onClick();
    });

    return btn;
  }
}

