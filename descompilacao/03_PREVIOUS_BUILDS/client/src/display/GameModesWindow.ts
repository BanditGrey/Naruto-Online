import { Container, Graphics, Sprite, Text, Assets, TextStyle } from 'pixi.js';

export interface GameModeItem {
  id: string;
  title: string;
  tag: string;
  color: number;
  desc: string;
  icon: string;
  reward: string;
  groupId: number;
}

export class GameModesWindow extends Container {
  private contentContainer: Container;
  private onSelectModeCallback: (mode: GameModeItem) => void;
  private onCloseCallback?: () => void;

  public static readonly WIDTH = 960;
  public static readonly HEIGHT = 580;

  private static readonly MODES: GameModeItem[] = [
    {
      id: 'campaign',
      title: 'CAMPANHA SHINOBI (CALABOUÇOS)',
      tag: 'História Canônica • Fases Progressivas',
      color: 0x059669,
      desc: 'Avance pelos capítulos da história oficial enfrentando bandos de renegados, Zabuza, Orochimaru, Akatsuki e conquiste pergaminhos raros.',
      icon: '📜',
      reward: 'Ryos • EXP • Equipamentos Canônicos',
      groupId: 1,
    },
    {
      id: 'world_boss',
      title: 'CHEFE DE MUNDO — KYUUBI (KURAMA)',
      tag: 'Batalha Global • Dano Acumulativo',
      color: 0xdc2626,
      desc: 'A Raposa de Nove Caudas atacou a vila! Junte-se a todos os ninjas do servidor para causar dano massivo e disputar o topo do ranking mundial.',
      icon: '🦊',
      reward: 'Almas Ninjas Lendárias • Ouro • Prestígio',
      groupId: 999,
    },
    {
      id: 'tower',
      title: 'EXAME CHŪNIN — TORRE DOS DESAFIOS',
      tag: 'Andar 1 ao 50 • Dificuldade Extrema',
      color: 0xd97706,
      desc: 'Prove seu valor diante dos instrutores shinobi. Cada andar vencido concede selos proibidos e pontos de talentos dos 8 Portões Internos.',
      icon: '⛩️',
      reward: 'Talentos • Pontos de Portões • Jades',
      groupId: 101,
    },
    {
      id: 'arena',
      title: 'ARENA NINJA RANQUEADA (PVP)',
      tag: 'Duelos Táticos 3x3 • Ranking de Konoha',
      color: 0x2563eb,
      desc: 'Desafie as melhores formações shinobi de outros jogadores. Suba no ranking de Konohagakure e receba salários diários em moedas e cupons.',
      icon: '⚔️',
      reward: 'Títulos Shinobi • Ryos Diários • Glória',
      groupId: 201,
    },
  ];

  constructor(onSelectMode: (mode: GameModeItem) => void, onClose?: () => void) {
    super();
    this.onSelectModeCallback = onSelectMode;
    this.onCloseCallback = onClose;
    this.eventMode = 'static';
    this.zIndex = 50000;

    const blocker = new Graphics();
    blocker.rect(-2000, -2000, 4000, 4000);
    blocker.fill({ color: 0x000000, alpha: 0.7 });
    blocker.eventMode = 'static';
    blocker.on('pointertap', () => this.close());
    this.addChild(blocker);

    this.contentContainer = new Container();
    this.contentContainer.eventMode = 'static';
    this.addChild(this.contentContainer);

    this.setupWindow();
  }

  private setupWindow(): void {
    const W = GameModesWindow.WIDTH;
    const H = GameModesWindow.HEIGHT;

    // Fundo
    const bg = new Graphics();
    bg.roundRect(0, 0, W, H, 14);
    bg.fill(0x0a0f1d);
    bg.stroke({ color: 0xe11d48, width: 3 });
    this.contentContainer.addChild(bg);

    // Topo
    const topBar = new Graphics();
    topBar.roundRect(0, 0, W, 52, 12);
    topBar.fill(0x881337);
    topBar.stroke({ color: 0xf43f5e, width: 1.5 });
    this.contentContainer.addChild(topBar);

    const title = new Text({
      text: '⚔️ ARENA DE COMBATES & MODOS DE JOGO DE KONOHAGAKURE',
      style: {
        fill: '#ffe4e6',
        fontSize: 16,
        fontWeight: 'bold',
        stroke: { color: '#000000', width: 3 },
        letterSpacing: 1.5,
      },
    });
    title.position.set(24, 15);
    this.contentContainer.addChild(title);

    // Botão Fechar
    const btnClose = new Container();
    btnClose.position.set(W - 40, 14);
    btnClose.eventMode = 'static';
    btnClose.cursor = 'pointer';

    const closeG = new Graphics();
    closeG.circle(12, 12, 12);
    closeG.fill(0xdc2626);
    closeG.stroke({ color: 0xffffff, width: 1.5 });
    btnClose.addChild(closeG);

    const closeX = new Text({
      text: '✕',
      style: { fill: '#ffffff', fontSize: 13, fontWeight: 'bold' },
    });
    closeX.anchor.set(0.5);
    closeX.position.set(12, 12);
    btnClose.addChild(closeX);

    btnClose.on('pointertap', () => this.close());
    this.contentContainer.addChild(btnClose);

    // Grid 2x2 com os 4 Modos de Jogo Canônicos
    GameModesWindow.MODES.forEach((mode, idx) => {
      const col = idx % 2;
      const row = Math.floor(idx / 2);
      const cardW = 445;
      const cardH = 230;
      const cardX = 24 + col * (cardW + 22);
      const cardY = 75 + row * (cardH + 18);

      const card = new Container();
      card.position.set(cardX, cardY);
      card.eventMode = 'static';
      card.cursor = 'pointer';

      const cardBg = new Graphics();
      cardBg.roundRect(0, 0, cardW, cardH, 10);
      cardBg.fill(0x131d31);
      cardBg.stroke({ color: mode.color, width: 2 });
      card.addChild(cardBg);

      // Ícone e Título
      const icon = new Text({ text: mode.icon, style: { fontSize: 28 } });
      icon.position.set(18, 16);
      card.addChild(icon);

      const titleTxt = new Text({
        text: mode.title,
        style: { fill: '#f8fafc', fontSize: 14, fontWeight: 'bold' },
      });
      titleTxt.position.set(58, 16);
      card.addChild(titleTxt);

      const tagTxt = new Text({
        text: mode.tag,
        style: { fill: '#fbbf24', fontSize: 11, fontWeight: '600' },
      });
      tagTxt.position.set(58, 38);
      card.addChild(tagTxt);

      // Descrição
      const descTxt = new Text({
        text: mode.desc,
        style: { fill: '#cbd5e1', fontSize: 11, wordWrap: true, wordWrapWidth: cardW - 36, lineHeight: 18 },
      });
      descTxt.position.set(18, 70);
      card.addChild(descTxt);

      // Recompensas
      const rewBg = new Graphics();
      rewBg.roundRect(18, 135, cardW - 36, 32, 6);
      rewBg.fill(0x1e293b);
      card.addChild(rewBg);

      const rewTxt = new Text({
        text: `🎁 Recompensas: ${mode.reward}`,
        style: { fill: '#38bdf8', fontSize: 11, fontWeight: 'bold' },
      });
      rewTxt.position.set(28, 142);
      card.addChild(rewTxt);

      // Botão Entrar
      const btnEnter = new Container();
      btnEnter.position.set(18, 178);
      const btnEnterBg = new Graphics();
      btnEnterBg.roundRect(0, 0, cardW - 36, 40, 6);
      btnEnterBg.fill(mode.color);
      btnEnter.addChild(btnEnterBg);

      const btnEnterTxt = new Text({
        text: '⚔️ ENTRAR EM COMBATE ⚔️',
        style: { fill: '#ffffff', fontSize: 12, fontWeight: 'bold', letterSpacing: 1 },
      });
      btnEnterTxt.anchor.set(0.5);
      btnEnterTxt.position.set((cardW - 36) / 2, 20);
      btnEnter.addChild(btnEnterTxt);

      card.addChild(btnEnter);

      card.on('pointerenter', () => {
        cardBg.fill(0x1e2d4a);
      });

      card.on('pointerleave', () => {
        cardBg.fill(0x131d31);
      });

      card.on('pointertap', () => {
        this.onSelectModeCallback(mode);
        this.close();
      });

      this.contentContainer.addChild(card);
    });
  }

  public open(parent?: Container): void {
    if (parent && !this.parent) {
      parent.addChild(this);
    }
    this.visible = true;
  }

  public close(): void {
    this.visible = false;
    if (this.onCloseCallback) {
      this.onCloseCallback();
    }
  }
}
