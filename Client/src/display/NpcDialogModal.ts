import { Container, Text, TextStyle, Sprite, Assets } from 'pixi.js';

export interface DialogData {
  npcId: number;
  name: string;
  npcTitle: string;
  talk: string;
  action: string;
}

export class NpcDialogModal extends Container {
  private bgSprite!: Sprite;
  private ribbonSprite!: Sprite;
  private actionBtnSprite!: Sprite;
  private btnNormalTex: any = null;
  private btnHoverTex: any = null;

  private nameLabel: Text;
  private titleLabel: Text;
  private talkLabel: Text;
  private actionBtn: Container;
  private actionBtnText: Text;
  private currentData: DialogData | null = null;
  public onActionClick?: (action: string, npcId: number) => void;

  constructor() {
    super();
    this.visible = false;
    // Centralizado horizontalmente no canvas 1250x650 (723x267 canônico)
    this.position.set(Math.floor((1250 - 723) / 2), 650 - 267 - 12);

    this.actionBtn = new Container();
    this.actionBtnText = new Text({ text: '' });
    this.nameLabel = new Text({ text: '' });
    this.titleLabel = new Text({ text: '' });
    this.talkLabel = new Text({ text: '' });

    this.initCanonicalAssets();
  }

  private async initCanonicalAssets(): Promise<void> {
    try {
      // 1. Pergaminho Original do Diálogo (12000001 / 16.jpg - 723x267)
      const bgTex = await Assets.load('/assets/ui/dialog/npc_dialog_bg.jpg');
      this.bgSprite = new Sprite(bgTex);
      this.addChildAt(this.bgSprite, 0);

      // 2. Fita Vertical Canônica do Nome do NPC (12000001 / 36.png - 43x164)
      const ribbonTex = await Assets.load('/assets/ui/dialog/npc_name_ribbon.png');
      this.ribbonSprite = new Sprite(ribbonTex);
      this.ribbonSprite.position.set(28, 26);
      this.addChild(this.ribbonSprite);

      // 3. Botão Canônico de Ação (12000001 / 48.png & 45.png - 87x35)
      this.btnNormalTex = await Assets.load('/assets/ui/dialog/btn_confirm.png');
      this.btnHoverTex = await Assets.load('/assets/ui/dialog/btn_confirm_hover.png');
      this.actionBtnSprite = new Sprite(this.btnNormalTex);
      this.actionBtn.addChildAt(this.actionBtnSprite, 0);
    } catch (e) {
      console.warn('[DIALOG] Falha ao carregar assets canônicos de diálogo:', e);
    }

    // Nome do NPC na fita vertical
    this.nameLabel = new Text({
      text: '',
      style: new TextStyle({
        fontFamily: 'SimSun, "Microsoft YaHei", sans-serif',
        fontSize: 12,
        fontWeight: 'bold',
        fill: '#4a2608',
        align: 'center',
        wordWrap: true,
        wordWrapWidth: 32
      })
    });
    this.nameLabel.anchor.set(0.5, 0);
    this.nameLabel.position.set(49, 74);
    this.addChild(this.nameLabel);

    // Título / Ocupação do NPC
    this.titleLabel = new Text({
      text: '',
      style: new TextStyle({
        fontFamily: 'SimSun, "Microsoft YaHei", sans-serif',
        fontSize: 11,
        fontWeight: 'bold',
        fill: '#8c531b'
      })
    });
    this.titleLabel.position.set(92, 30);
    this.addChild(this.titleLabel);

    // Texto de Fala (Fonte canônica sobre o pergaminho claro)
    this.talkLabel = new Text({
      text: '',
      style: new TextStyle({
        fontFamily: 'SimSun, "Microsoft YaHei", sans-serif',
        fontSize: 13.5,
        fontWeight: 'bold',
        fill: '#2c1808',
        wordWrap: true,
        wordWrapWidth: 590,
        lineHeight: 22
      })
    });
    this.talkLabel.position.set(92, 58);
    this.addChild(this.talkLabel);

    // Configuração do Botão Canônico de Ação (posicionado no canto inferior direito)
    this.actionBtn.position.set(585, 204);
    this.actionBtn.eventMode = 'static';
    this.actionBtn.cursor = 'pointer';

    this.actionBtnText = new Text({
      text: 'Confirmar',
      style: new TextStyle({
        fontFamily: 'SimSun, "Microsoft YaHei", sans-serif',
        fontSize: 11,
        fontWeight: 'bold',
        fill: '#ffffff',
        stroke: { color: '#4a1500', width: 2 }
      })
    });
    this.actionBtnText.anchor.set(0.5, 0.5);
    this.actionBtnText.position.set(43, 17);
    this.actionBtn.addChild(this.actionBtnText);

    this.actionBtn.on('pointerenter', () => {
      if (this.btnHoverTex && this.actionBtnSprite) this.actionBtnSprite.texture = this.btnHoverTex;
    });
    this.actionBtn.on('pointerleave', () => {
      if (this.btnNormalTex && this.actionBtnSprite) this.actionBtnSprite.texture = this.btnNormalTex;
    });
    this.actionBtn.on('pointertap', () => {
      if (this.currentData && this.onActionClick) {
        this.onActionClick(this.currentData.action, this.currentData.npcId);
      }
      this.hide();
    });
    this.addChild(this.actionBtn);

    // Botão Fechar Canônico (✕) no canto superior direito do pergaminho
    const closeBtn = new Text({
      text: '✕',
      style: new TextStyle({
        fontSize: 14,
        fill: '#6e4720',
        fontWeight: 'bold'
      })
    });
    closeBtn.position.set(696, 12);
    closeBtn.eventMode = 'static';
    closeBtn.cursor = 'pointer';
    closeBtn.on('pointertap', () => this.hide());
    this.addChild(closeBtn);
  }

  public showDialog(data: DialogData): void {
    this.currentData = data;
    this.nameLabel.text = data.name;
    this.titleLabel.text = data.npcTitle ? `[${data.npcTitle}]` : '';
    this.talkLabel.text = `"${data.talk}"`;

    if (data.action === 'quest_accept') {
      this.actionBtnText.text = 'Aceitar';
    } else if (data.action === 'quest_finish') {
      this.actionBtnText.text = 'Entregar';
    } else if (data.action === 'tavern') {
      this.actionBtnText.text = 'Taverna';
    } else if (data.action === 'gate_to_konoha') {
      this.actionBtnText.text = 'Entrar';
    } else if (data.action === 'gate_to_suburb') {
      this.actionBtnText.text = 'Voltar';
    } else {
      this.actionBtnText.text = 'Continuar';
    }

    this.visible = true;
  }

  public hide(): void {
    this.visible = false;
  }
}
