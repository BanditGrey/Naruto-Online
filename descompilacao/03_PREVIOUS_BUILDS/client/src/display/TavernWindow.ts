import { Container, Graphics, Sprite, Text, Assets } from 'pixi.js';
import { clientSocket, WebPacketWriter, WebPacketReader } from '../network/clientSocket.ts';
import { OPCODES } from '../../../shared/opcodes.ts';

export interface TavernNinjaInfo {
  hero_id: number;
  name: string;
  profession: number; // 1: Ninjutsu, 3: Genjutsu, 4: Taijutsu
  cost: number;
  avatar: string;
  quality: number;
  hp: number;
  atk: number;
  def: number;
  spd: number;
}

export class TavernWindow extends Container {
  private contentContainer: Container;
  private txtSouls: Text | null = null;
  private txtMoraResult: Text | null = null;
  private recruitedHeroIds: Set<number> = new Set();
  private souls: number = 0;
  private onCloseCallback?: () => void;
  private recruitsContainer: Container;

  public static readonly WIDTH = 780;
  public static readonly HEIGHT = 520;

  private static readonly NINJAS: TavernNinjaInfo[] = [
    {
      hero_id: 101,
      name: 'Naruto Uzumaki',
      profession: 4,
      cost: 50,
      avatar: '/assets/ninjas/ninja_naruto.png',
      quality: 3,
      hp: 2200,
      atk: 380,
      def: 260,
      spd: 190,
    },
    {
      hero_id: 102,
      name: 'Sasuke Uchiha',
      profession: 1,
      cost: 80,
      avatar: '/assets/ninjas/ninja_sasuke.png',
      quality: 4,
      hp: 1850,
      atk: 460,
      def: 210,
      spd: 230,
    },
    {
      hero_id: 103,
      name: 'Sakura Haruno',
      profession: 3,
      cost: 40,
      avatar: '/assets/ninjas/ninja_sakura.png',
      quality: 3,
      hp: 1600,
      atk: 310,
      def: 240,
      spd: 200,
    },
    {
      hero_id: 104,
      name: 'Kakashi Hatake',
      profession: 1,
      cost: 150,
      avatar: '/assets/town/ninja_blade.png',
      quality: 5,
      hp: 3200,
      atk: 620,
      def: 390,
      spd: 280,
    },
  ];

  constructor(onClose?: () => void) {
    super();
    this.onCloseCallback = onClose;
    this.eventMode = 'static';
    this.zIndex = 50000;

    // Overlay de fundo
    const blocker = new Graphics();
    blocker.rect(-2000, -2000, 4000, 4000);
    blocker.fill({ color: 0x000000, alpha: 0.5 });
    blocker.eventMode = 'static';
    blocker.on('pointertap', () => this.close());
    this.addChild(blocker);

    this.contentContainer = new Container();
    this.contentContainer.eventMode = 'static';
    this.addChild(this.contentContainer);

    this.recruitsContainer = new Container();
    this.contentContainer.addChild(this.recruitsContainer);

    this.setupWindow();
    this.setupMoraMiniGame();
    this.setupNetwork();
  }

  private setupWindow(): void {
    // 1. Moldura / Fundo da Taverna (bg_tavern.jpg)
    const tavernTex = Assets.get('/assets/tavern/bg_tavern.jpg');
    if (tavernTex) {
      const bg = new Sprite(tavernTex);
      bg.width = TavernWindow.WIDTH;
      bg.height = TavernWindow.HEIGHT;
      this.contentContainer.addChild(bg);
    } else {
      const fallback = new Graphics();
      fallback.roundRect(0, 0, TavernWindow.WIDTH, TavernWindow.HEIGHT, 12);
      fallback.fill(0x18181b);
      this.contentContainer.addChild(fallback);
    }

    // Moldura escura translúcida para contraste
    const overlay = new Graphics();
    overlay.roundRect(12, 12, TavernWindow.WIDTH - 24, TavernWindow.HEIGHT - 24, 10);
    overlay.fill({ color: 0x090d16, alpha: 0.88 });
    overlay.stroke({ color: 0xf59e0b, width: 2.5 });
    this.contentContainer.addChild(overlay);

    // 2. Título
    const title = new Text({
      text: '🍶 Taverna Shinobi - Recrutamento & Jokenpô (Mora)',
      style: {
        fill: '#fbbf24',
        fontSize: 16,
        fontWeight: 'bold',
        stroke: { color: '#000000', width: 3 },
      },
    });
    title.position.set(30, 24);
    this.contentContainer.addChild(title);

    // 3. Contador de Almas Ninjas
    this.txtSouls = new Text({
      text: `Almas Ninjas: 0`,
      style: {
        fill: '#38bdf8',
        fontSize: 13,
        fontWeight: 'bold',
        stroke: { color: '#000000', width: 2 },
      },
    });
    this.txtSouls.position.set(TavernWindow.WIDTH - 240, 26);
    this.contentContainer.addChild(this.txtSouls);

    // 4. Botão Fechar
    const closeBtn = new Container();
    closeBtn.position.set(TavernWindow.WIDTH - 44, 22);
    closeBtn.eventMode = 'static';
    closeBtn.cursor = 'pointer';

    const closeTex = Assets.get('/assets/ui/btn_close.png');
    if (closeTex) {
      const closeSprite = new Sprite(closeTex);
      closeBtn.addChild(closeSprite);
    } else {
      const closeG = new Graphics();
      closeG.circle(10, 10, 10);
      closeG.fill(0xdc2626);
      closeBtn.addChild(closeG);
    }
    closeBtn.on('pointertap', () => this.close());
    this.contentContainer.addChild(closeBtn);
  }

  /**
   * Painel esquerdo: Mini-game autêntico de Mora (Jokenpô)
   */
  private setupMoraMiniGame(): void {
    const moraBox = new Container();
    moraBox.position.set(30, 68);

    const boxBg = new Graphics();
    boxBg.roundRect(0, 0, 260, 420, 8);
    boxBg.fill({ color: 0x1e293b, alpha: 0.8 });
    boxBg.stroke({ color: 0x64748b, width: 1.5 });
    moraBox.addChild(boxBg);

    const subTitle = new Text({
      text: 'Desafio Mora (Jokenpô)',
      style: { fill: '#fbbf24', fontSize: 13, fontWeight: 'bold' },
    });
    subTitle.position.set(16, 14);
    moraBox.addChild(subTitle);

    const desc = new Text({
      text: 'Jogue contra o Mestre da Taverna para ganhar Almas Ninjas e recrutar guerreiros!',
      style: { fill: '#94a3b8', fontSize: 11, wordWrap: true, wordWrapWidth: 228 },
    });
    desc.position.set(16, 38);
    moraBox.addChild(desc);

    // Botões de escolha: Pedra (0), Tesoura (1), Papel (2)
    const choices = [
      { id: 0, name: 'Pedra', icon: '/assets/tavern/mora_rock.png', color: 0x3b82f6, x: 20 },
      { id: 1, name: 'Tesoura', icon: '/assets/tavern/mora_scissors.png', color: 0xef4444, x: 100 },
      { id: 2, name: 'Papel', icon: '/assets/tavern/mora_paper.png', color: 0x10b981, x: 180 },
    ];

    choices.forEach((c) => {
      const btn = new Container();
      btn.position.set(c.x, 110);
      btn.eventMode = 'static';
      btn.cursor = 'pointer';

      const btnBg = new Graphics();
      btnBg.roundRect(0, 0, 60, 60, 8);
      btnBg.fill(c.color);
      btnBg.stroke({ color: 0xffffff, width: 2 });
      btn.addChild(btnBg);

      const moraTex = Assets.get(c.icon);
      if (moraTex) {
        const spr = new Sprite(moraTex);
        spr.width = 44;
        spr.height = 44;
        spr.position.set(8, 8);
        btn.addChild(spr);
      }

      const txtName = new Text({
        text: c.name,
        style: { fill: '#ffffff', fontSize: 10, fontWeight: 'bold' },
      });
      txtName.anchor.set(0.5, 0);
      txtName.position.set(30, 64);
      btn.addChild(txtName);

      btn.on('pointertap', () => {
        this.playMora(c.id);
      });

      moraBox.addChild(btn);
    });

    // Texto de feedback do resultado
    this.txtMoraResult = new Text({
      text: 'Escolha Pedra, Tesoura ou Papel para começar!',
      style: {
        fill: '#fcd34d',
        fontSize: 12,
        fontWeight: 'bold',
        wordWrap: true,
        wordWrapWidth: 228,
        align: 'center',
        stroke: { color: '#000000', width: 2 },
      },
    });
    this.txtMoraResult.anchor.set(0.5, 0);
    this.txtMoraResult.position.set(130, 210);
    moraBox.addChild(this.txtMoraResult);

    // Tabela de recompensas
    const rewardsInfo = new Text({
      text: 'Recompensas de Mora:\n• Vitória: +25 Almas\n• Empate: +5 Almas\n• Derrota: +2 Almas',
      style: { fill: '#cbd5e1', fontSize: 11, lineHeight: 18 },
    });
    rewardsInfo.position.set(20, 310);
    moraBox.addChild(rewardsInfo);

    this.contentContainer.addChild(moraBox);
  }

  private setupNetwork(): void {
    clientSocket.on(OPCODES.SC_Enter_Tavern, (reader: WebPacketReader) => {
      try {
        const payloadStr = reader.readStringUTF();
        if (!payloadStr) return;
        const data = JSON.parse(payloadStr);
        if (data.currency) {
          this.souls = data.currency.ninja_souls || 0;
          if (this.txtSouls) this.txtSouls.text = `Almas Ninjas: ${this.souls}`;
        }
        if (data.team) {
          this.recruitedHeroIds = new Set(data.team.map((m: any) => m.hero_id));
        }
        this.renderRecruitList();
      } catch (e) {
        console.error('[TavernWindow] Erro ao processar SC_Enter_Tavern:', e);
      }
    });

    clientSocket.on(OPCODES.SC_TavernMoraRet, (reader: WebPacketReader) => {
      try {
        const payloadStr = reader.readStringUTF();
        if (!payloadStr) return;
        const res = JSON.parse(payloadStr);

        const choiceNames = ['Pedra', 'Tesoura', 'Papel'];
        const resultTitles: Record<string, string> = {
          win: '🏆 Vitória!',
          draw: '🤝 Empate!',
          lose: '❌ Derrota!',
        };

        if (this.txtMoraResult) {
          this.txtMoraResult.text = `${resultTitles[res.result]}\nVocê: ${choiceNames[res.clientChoice]} vs Mestre: ${choiceNames[res.serverChoice]}\n+${res.soulsAwarded} Almas Ninjas ganhas!`;
        }

        if (res.currency) {
          this.souls = res.currency.ninja_souls || 0;
          if (this.txtSouls) this.txtSouls.text = `Almas Ninjas: ${this.souls}`;
        }
        this.renderRecruitList();
      } catch (e) {
        console.error('[TavernWindow] Erro ao processar SC_TavernMoraRet:', e);
      }
    });

    clientSocket.on(OPCODES.SC_TavernRecruitRet, (reader: WebPacketReader) => {
      try {
        const payloadStr = reader.readStringUTF();
        if (!payloadStr) return;
        const res = JSON.parse(payloadStr);

        if (this.txtMoraResult) {
          this.txtMoraResult.text = res.message || (res.success ? 'Ninja recrutado com sucesso!' : 'Falha no recrutamento.');
        }

        if (res.currency) {
          this.souls = res.currency.ninja_souls || 0;
          if (this.txtSouls) this.txtSouls.text = `Almas Ninjas: ${this.souls}`;
        }

        if (res.team) {
          this.recruitedHeroIds = new Set(res.team.map((m: any) => m.hero_id));
        }

        this.renderRecruitList();
      } catch (e) {
        console.error('[TavernWindow] Erro ao processar SC_TavernRecruitRet:', e);
      }
    });

    this.requestTavernData();
  }

  public requestTavernData(): void {
    const pw = new WebPacketWriter();
    clientSocket.send(OPCODES.CS_Enter_Tavern, pw);
  }

  public open(): void {
    this.visible = true;
    this.requestTavernData();
  }

  public close(): void {
    this.visible = false;
    if (this.onCloseCallback) this.onCloseCallback();
  }

  private playMora(choice: number): void {
    const pw = new WebPacketWriter();
    pw.writeByte(choice);
    clientSocket.send(OPCODES.CS_TavernMoraReq, pw);
  }

  private recruitNinja(heroId: number): void {
    const pw = new WebPacketWriter();
    pw.writeInt(heroId);
    clientSocket.send(OPCODES.CS_TavernRecruitReq, pw);
  }

  /**
   * Painel direito: Lista de ninjas para recrutamento
   */
  private renderRecruitList(): void {
    this.recruitsContainer.removeChildren();
    this.recruitsContainer.position.set(310, 68);

    const cardW = 210;
    const cardH = 200;
    const gapX = 16;
    const gapY = 16;

    TavernWindow.NINJAS.forEach((ninja, index) => {
      const col = index % 2;
      const row = Math.floor(index / 2);

      const card = new Container();
      card.position.set(col * (cardW + gapX), row * (cardH + gapY));

      const isRecruited = this.recruitedHeroIds.has(ninja.hero_id);

      // Fundo do card
      const cardBg = new Graphics();
      cardBg.roundRect(0, 0, cardW, cardH, 8);
      cardBg.fill({ color: 0x1e293b, alpha: 0.9 });
      const borderCol = ninja.quality === 5 ? 0xf59e0b : ninja.quality === 4 ? 0xa855f7 : 0x38bdf8;
      cardBg.stroke({ color: isRecruited ? 0x22c55e : borderCol, width: 2 });
      card.addChild(cardBg);

      // Avatar
      const avatarTex = Assets.get(ninja.avatar) || Assets.get('/assets/town/ninja_blade.png');
      if (avatarTex) {
        const spr = new Sprite(avatarTex);
        spr.width = 64;
        spr.height = 64;
        spr.position.set(12, 14);
        card.addChild(spr);
      }

      // Nome e Disciplina
      const profNames: Record<number, string> = { 1: 'Ninjutsu', 3: 'Genjutsu', 4: 'Taijutsu' };
      const txtName = new Text({
        text: ninja.name,
        style: { fill: '#ffffff', fontSize: 12, fontWeight: 'bold' },
      });
      txtName.position.set(84, 14);
      card.addChild(txtName);

      const txtProf = new Text({
        text: `${profNames[ninja.profession]} | Nv. 1`,
        style: { fill: '#94a3b8', fontSize: 10 },
      });
      txtProf.position.set(84, 32);
      card.addChild(txtProf);

      // Atributos
      const statsTxt = new Text({
        text: `❤️ HP: ${ninja.hp}\n⚔️ ATK: ${ninja.atk}\n🛡️ DEF: ${ninja.def}\n⚡ SPD: ${ninja.spd}`,
        style: { fill: '#cbd5e1', fontSize: 10, lineHeight: 15 },
      });
      statsTxt.position.set(14, 86);
      card.addChild(statsTxt);

      // Botão de Ação / Recrutado
      const btn = new Container();
      btn.position.set(14, cardH - 38);

      const bgBtn = new Graphics();
      bgBtn.roundRect(0, 0, cardW - 28, 28, 6);

      if (isRecruited) {
        bgBtn.fill(0x15803d);
        btn.addChild(bgBtn);

        const txt = new Text({
          text: '✓ Na Equipe',
          style: { fill: '#ffffff', fontSize: 11, fontWeight: 'bold' },
        });
        txt.anchor.set(0.5);
        txt.position.set((cardW - 28) / 2, 14);
        btn.addChild(txt);
      } else {
        const canAfford = this.souls >= ninja.cost;
        bgBtn.fill(canAfford ? 0xd97706 : 0x475569);
        btn.addChild(bgBtn);

        const txt = new Text({
          text: `Recrutar (${ninja.cost} Almas)`,
          style: { fill: '#ffffff', fontSize: 11, fontWeight: 'bold' },
        });
        txt.anchor.set(0.5);
        txt.position.set((cardW - 28) / 2, 14);
        btn.addChild(txt);

        if (canAfford) {
          btn.eventMode = 'static';
          btn.cursor = 'pointer';
          btn.on('pointertap', () => {
            this.recruitNinja(ninja.hero_id);
          });
        }
      }

      card.addChild(btn);
      this.recruitsContainer.addChild(card);
    });
  }

  public destroy(options?: any): void {
    clientSocket.off(OPCODES.SC_Enter_Tavern);
    clientSocket.off(OPCODES.SC_TavernMoraRet);
    clientSocket.off(OPCODES.SC_TavernRecruitRet);
    super.destroy(options);
  }
}
