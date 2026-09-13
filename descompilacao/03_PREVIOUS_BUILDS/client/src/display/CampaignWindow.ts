import { Container, Graphics, Sprite, Text, Assets } from 'pixi.js';

export interface CampaignStage {
  id: number;
  title: string;
  chapter: string;
  levelReq: number;
  enemyName: string;
  enemyDesc: string;
  rewards: string;
  monsterGroupId: number;
}

export class CampaignWindow extends Container {
  private contentContainer: Container;
  private onStartBattleCallback: (groupId: number) => void;
  private onCloseCallback?: () => void;

  public static readonly WIDTH = 760;
  public static readonly HEIGHT = 480;

  private static readonly STAGES: CampaignStage[] = [
    {
      id: 1,
      chapter: 'Capítulo I',
      title: 'O Teste dos Guizos',
      levelReq: 1,
      enemyName: 'Kakashi Hatake (Jōnin)',
      enemyDesc: 'Supere o teste de sobrevivência e tome um dos guizos para se formar como Genin.',
      rewards: '💰 500 Ryo • 📜 250 EXP • ⚔️ Kunai de Aço',
      monsterGroupId: 1,
    },
    {
      id: 2,
      chapter: 'Capítulo II',
      title: 'Missão no País das Ondas',
      levelReq: 3,
      enemyName: 'Zabuza Momochi & Haku',
      enemyDesc: 'Proteja o construtor da ponte Tazuna contra os temidos assassinos da Névoa.',
      rewards: '💰 1.200 Ryo • 📜 600 EXP • 🛡️ Colete Shinobi',
      monsterGroupId: 2,
    },
    {
      id: 3,
      chapter: 'Capítulo III',
      title: 'O Exame Chūnin - Floresta da Morte',
      levelReq: 5,
      enemyName: 'Ninjas da Chuva & Orochimaru',
      enemyDesc: 'Sobreviva na floresta proibida e conquiste os dois pergaminhos do Céu e da Terra.',
      rewards: '💰 2.500 Ryo • 📜 1.200 EXP • ✨ Anel de Chakra',
      monsterGroupId: 3,
    },
  ];

  constructor(onStartBattle: (groupId: number) => void, onClose?: () => void) {
    super();
    this.onStartBattleCallback = onStartBattle;
    this.onCloseCallback = onClose;
    this.eventMode = 'static';
    this.zIndex = 50000;

    // Overlay escuro
    const blocker = new Graphics();
    blocker.rect(-2000, -2000, 4000, 4000);
    blocker.fill({ color: 0x000000, alpha: 0.5 });
    blocker.eventMode = 'static';
    blocker.on('pointertap', () => this.close());
    this.addChild(blocker);

    this.contentContainer = new Container();
    this.contentContainer.eventMode = 'static';
    this.addChild(this.contentContainer);

    this.setupWindow();
    this.renderStages();
  }

  private setupWindow(): void {
    // Fundo da Janela
    const bg = new Graphics();
    bg.roundRect(0, 0, CampaignWindow.WIDTH, CampaignWindow.HEIGHT, 12);
    bg.fill({ color: 0x0f172a, alpha: 0.95 });
    bg.stroke({ color: 0xf59e0b, width: 2.5 });
    this.contentContainer.addChild(bg);

    // Título
    const title = new Text({
      text: '🗺️ Campanhas e Capítulos Shinobi (PvE)',
      style: {
        fill: '#fbbf24',
        fontSize: 16,
        fontWeight: 'bold',
        stroke: { color: '#000000', width: 3 },
      },
    });
    title.position.set(28, 20);
    this.contentContainer.addChild(title);

    // Botão Fechar
    const closeBtn = new Container();
    closeBtn.position.set(CampaignWindow.WIDTH - 40, 18);
    closeBtn.eventMode = 'static';
    closeBtn.cursor = 'pointer';

    const closeTex = Assets.get('/assets/ui/btn_close.png');
    if (closeTex) {
      const spr = new Sprite(closeTex);
      closeBtn.addChild(spr);
    } else {
      const c = new Graphics();
      c.circle(10, 10, 10);
      c.fill(0xdc2626);
      closeBtn.addChild(c);
    }
    closeBtn.on('pointertap', () => this.close());
    this.contentContainer.addChild(closeBtn);
  }

  private renderStages(): void {
    const startY = 64;
    const cardW = CampaignWindow.WIDTH - 56;
    const cardH = 115;
    const gap = 16;

    CampaignWindow.STAGES.forEach((stage, idx) => {
      const card = new Container();
      card.position.set(28, startY + idx * (cardH + gap));

      const bg = new Graphics();
      bg.roundRect(0, 0, cardW, cardH, 8);
      bg.fill({ color: 0x1e293b, alpha: 0.9 });
      bg.stroke({ color: idx === 0 ? 0x22c55e : 0x475569, width: 1.5 });
      card.addChild(bg);

      // Capítulo e Título
      const txtTitle = new Text({
        text: `${stage.chapter}: ${stage.title}`,
        style: { fill: '#38bdf8', fontSize: 13, fontWeight: 'bold' },
      });
      txtTitle.position.set(16, 12);
      card.addChild(txtTitle);

      // Nível Recomendado
      const txtLevel = new Text({
        text: `Nv. Mín: ${stage.levelReq}`,
        style: { fill: '#fbbf24', fontSize: 11, fontWeight: 'bold' },
      });
      txtLevel.position.set(cardW - 190, 12);
      card.addChild(txtLevel);

      // Descrição do Inimigo
      const txtDesc = new Text({
        text: `Inimigo: ${stage.enemyName}\n${stage.enemyDesc}`,
        style: { fill: '#cbd5e1', fontSize: 11, wordWrap: true, wordWrapWidth: cardW - 200, lineHeight: 16 },
      });
      txtDesc.position.set(16, 36);
      card.addChild(txtDesc);

      // Recompensas
      const txtRewards = new Text({
        text: `Recompensas: ${stage.rewards}`,
        style: { fill: '#a7f3d0', fontSize: 10, fontWeight: 'bold' },
      });
      txtRewards.position.set(16, 88);
      card.addChild(txtRewards);

      // Botão Desafiar
      const btnChallenge = new Container();
      btnChallenge.position.set(cardW - 140, 52);
      btnChallenge.eventMode = 'static';
      btnChallenge.cursor = 'pointer';

      const btnBg = new Graphics();
      btnBg.roundRect(0, 0, 120, 36, 6);
      btnBg.fill(0xdc2626);
      btnBg.stroke({ color: 0xef4444, width: 1.5 });
      btnChallenge.addChild(btnBg);

      const btnTxt = new Text({
        text: '⚔️ Desafiar',
        style: { fill: '#ffffff', fontSize: 12, fontWeight: 'bold' },
      });
      btnTxt.anchor.set(0.5);
      btnTxt.position.set(60, 18);
      btnChallenge.addChild(btnTxt);

      btnChallenge.on('pointertap', () => {
        this.close();
        this.onStartBattleCallback(stage.monsterGroupId);
      });

      card.addChild(btnChallenge);
      this.contentContainer.addChild(card);
    });
  }

  public open(): void {
    this.visible = true;
  }

  public close(): void {
    this.visible = false;
    if (this.onCloseCallback) this.onCloseCallback();
  }
}
