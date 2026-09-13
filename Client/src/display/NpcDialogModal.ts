import { Container, Graphics, Text, TextStyle, Sprite, Assets } from 'pixi.js';

export interface DialogData {
  npcId: number;
  name: string;
  npcTitle: string;
  talk: string;
  action: string;
}

export class NpcDialogModal extends Container {
  private boxBg: Graphics;
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
    this.position.set(225, 420); // Centralizado na parte inferior (largura 800)

    // Fundo da caixa de diálogo
    this.boxBg = new Graphics()
      .roundRect(0, 0, 800, 180, 10)
      .fill({ color: 0x090d16, alpha: 0.95 })
      .stroke({ color: 0xd4af37, width: 2 });
    this.addChild(this.boxBg);

    // Nome do NPC
    this.nameLabel = new Text({
      text: '',
      style: new TextStyle({ fontSize: 18, fontWeight: 'bold', fill: '#ffd700' })
    });
    this.nameLabel.position.set(30, 20);
    this.addChild(this.nameLabel);

    // Título / Papel do NPC
    this.titleLabel = new Text({
      text: '',
      style: new TextStyle({ fontSize: 13, fill: '#8b949e', fontStyle: 'italic' })
    });
    this.titleLabel.position.set(220, 24);
    this.addChild(this.titleLabel);

    // Texto de Fala
    this.talkLabel = new Text({
      text: '',
      style: new TextStyle({
        fontSize: 15,
        fill: '#f0f6fc',
        wordWrap: true,
        wordWrapWidth: 740,
        lineHeight: 22
      })
    });
    this.talkLabel.position.set(30, 56);
    this.addChild(this.talkLabel);

    // Botão de Ação (ex: Aceitar Missão / Viajar)
    this.actionBtn = new Container();
    this.actionBtn.position.set(580, 120);
    this.actionBtn.eventMode = 'static';
    this.actionBtn.cursor = 'pointer';

    const btnBg = new Graphics()
      .roundRect(0, 0, 190, 36, 6)
      .fill(0x238636)
      .stroke({ color: 0x3fb950, width: 1.5 });
    this.actionBtn.addChild(btnBg);

    this.actionBtnText = new Text({
      text: 'CONFIRMAR',
      style: new TextStyle({ fontSize: 12, fontWeight: 'bold', fill: '#fff' })
    });
    this.actionBtnText.anchor.set(0.5, 0.5);
    this.actionBtnText.position.set(95, 18);
    this.actionBtn.addChild(this.actionBtnText);

    this.actionBtn.on('pointertap', () => {
      if (this.currentData && this.onActionClick) {
        this.onActionClick(this.currentData.action, this.currentData.npcId);
      }
      this.hide();
    });
    this.addChild(this.actionBtn);

    // Botão Fechar (X)
    const closeBtn = new Text({
      text: '✕',
      style: new TextStyle({ fontSize: 16, fill: '#8b949e', fontWeight: 'bold' })
    });
    closeBtn.position.set(765, 15);
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
      this.actionBtnText.text = 'ACEITAR MISSÃO';
    } else if (data.action === 'quest_finish') {
      this.actionBtnText.text = 'ENTREGAR MISSÃO';
    } else if (data.action === 'tavern') {
      this.actionBtnText.text = 'ENTRAR NA TAVERNA';
    } else if (data.action === 'gate_to_konoha') {
      this.actionBtnText.text = 'ENTRAR EM KONOHA';
    } else if (data.action === 'gate_to_suburb') {
      this.actionBtnText.text = 'VOLTAR AOS SUBÚRBIOS';
    } else {
      this.actionBtnText.text = 'CONTINUAR';
    }

    this.visible = true;
  }

  public hide(): void {
    this.visible = false;
  }
}
