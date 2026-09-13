import { Container, Graphics, Sprite, Text, Assets, FederatedPointerEvent } from 'pixi.js';
import { BaseModal } from './BaseModal';
import { clientSocket, WebPacketWriter } from '../network/clientSocket.ts';
import { OPCODES } from '../../../shared/opcodes.ts';

export interface TavernNinjaOption {
  id: number;
  name: string;
  role: string;
  profession: number; // 1: Ninjutsu, 3: Genjutsu, 4: Taijutsu
  avatarKey: string;
  avatarPath: string;
  cost: number;
  quality: number;
  hp: number;
  atk: number;
  def: number;
  spd: number;
}

export class TavernModal extends BaseModal {
  private soulsCount: number = 120;
  private lblSouls!: Text;
  private recruitedHeroIds: Set<number> = new Set();

  private tavernNinjas: TavernNinjaOption[] = [
    {
      id: 101,
      name: 'Naruto Uzumaki',
      role: 'Vanguarda / Clone',
      profession: 4,
      avatarKey: 'naruto',
      avatarPath: '/assets/ninjas/ninja_naruto.png',
      cost: 50,
      quality: 4,
      hp: 2200,
      atk: 380,
      def: 260,
      spd: 190,
    },
    {
      id: 102,
      name: 'Sasuke Uchiha',
      role: 'Assalto / Chidori',
      profession: 1,
      avatarKey: 'sasuke',
      avatarPath: '/assets/ninjas/ninja_sasuke.png',
      cost: 80,
      quality: 4,
      hp: 1850,
      atk: 460,
      def: 210,
      spd: 230,
    },
    {
      id: 103,
      name: 'Sakura Haruno',
      role: 'Apoio / Cura',
      profession: 3,
      avatarKey: 'sakura',
      avatarPath: '/assets/ninjas/ninja_sakura.png',
      cost: 40,
      quality: 3,
      hp: 1600,
      atk: 310,
      def: 240,
      spd: 200,
    },
    {
      id: 104,
      name: 'Kakashi Hatake',
      role: 'Assalto / Raikiri',
      profession: 1,
      avatarKey: 'kakashi',
      avatarPath: '/assets/animated/npcs/kakashi/idle_0.png',
      cost: 150,
      quality: 5,
      hp: 3200,
      atk: 620,
      def: 390,
      spd: 280,
    },
    {
      id: 105,
      name: 'Rock Lee',
      role: 'Vanguarda / Lótus',
      profession: 4,
      avatarKey: 'rock_lee',
      avatarPath: '/assets/animated/npcs/rock_lee/idle_0.png',
      cost: 60,
      quality: 3,
      hp: 2050,
      atk: 420,
      def: 230,
      spd: 210,
    },
    {
      id: 106,
      name: 'Neji Hyuga',
      role: 'Assalto / 64 Golpes',
      profession: 4,
      avatarKey: 'neji',
      avatarPath: '/assets/animated/npcs/neji/idle_0.png',
      cost: 70,
      quality: 4,
      hp: 1950,
      atk: 440,
      def: 250,
      spd: 220,
    },
  ];

  // Elementos do Minigame Mora
  private moraResultContainer!: Container;
  private moraResultText!: Text;
  private moraDetailText!: Text;
  private recruitButtons: Map<number, Container> = new Map();

  constructor() {
    super({
      title: 'Taverna da Folha - Recrutamento Shinobi & Minigame Mora',
      width: 960,
      height: 560,
    });
    this.initContent();
  }

  public override open(): void {
    super.open();
    clientSocket.send(OPCODES.CS_Enter_Tavern, new WebPacketWriter());
  }

  protected initContent(): void {
    // 1. Painel Esquerdo: Minigame Mora (Jokenpô Clássico) (X: 20, Y: 52, W: 340, H: 485)
    this.buildMoraMinigame(20, 52);

    // 2. Painel Direito: Lista de Ninjas Visitantes (X: 375, Y: 52, W: 565, H: 485)
    this.buildNinjaList(375, 52);
  }

  private buildMoraMinigame(startX: number, startY: number): void {
    const moraBox = new Graphics();
    moraBox.roundRect(startX, startY, 340, 485, 8);
    moraBox.fill({ color: 0x18181b, alpha: 0.95 });
    moraBox.stroke({ color: 0xb45309, width: 2 });
    this.windowContainer.addChild(moraBox);

    // Cabeçalho do Minigame
    const title = new Text({
      text: 'DESAFIO MORA (JOKENPÔ)',
      style: { fill: '#fbbf24', fontSize: 13, fontWeight: 'bold' },
    });
    title.position.set(startX + 16, startY + 12);
    this.windowContainer.addChild(title);

    const desc = new Text({
      text: 'Dispute com os ninjas da taverna para acumular Almas Ninjas!\nVitória: +25 almas | Empate: +5 almas | Derrota: +2 almas',
      style: { fill: '#94a3b8', fontSize: 10, lineHeight: 16, wordWrap: true, wordWrapWidth: 310 },
    });
    desc.position.set(startX + 16, startY + 36);
    this.windowContainer.addChild(desc);

    // Placa de Almas Ninjas acumuladas
    const soulsBg = new Graphics();
    soulsBg.roundRect(startX + 16, startY + 85, 308, 38, 6);
    soulsBg.fill({ color: 0x451a03, alpha: 0.9 });
    soulsBg.stroke({ color: 0xf59e0b, width: 1.5 });
    this.windowContainer.addChild(soulsBg);

    this.lblSouls = new Text({
      text: `🌀 Suas Almas Ninjas: ${this.soulsCount}`,
      style: { fill: '#fef08a', fontSize: 13, fontWeight: 'bold' },
    });
    this.lblSouls.position.set(startX + 26, startY + 95);
    this.windowContainer.addChild(this.lblSouls);

    // 3 Botões de Escolha: Pedra ✊, Papel ✋, Tesoura ✌️
    const choices = [
      { id: 0, label: 'PEDRA ✊', icon: '/assets/tavern/mora_rock.png', color: 0xd97706, y: startY + 140 },
      { id: 2, label: 'PAPEL ✋', icon: '/assets/tavern/mora_paper.png', color: 0x2563eb, y: startY + 205 },
      { id: 1, label: 'TESOURA ✌️', icon: '/assets/tavern/mora_scissors.png', color: 0x16a34a, y: startY + 270 },
    ];

    for (const c of choices) {
      const btn = this.createMoraButton(c.id, c.label, c.icon, c.color, startX + 16, c.y);
      this.windowContainer.addChild(btn);
    }

    // Painel de Resultado da disputa
    this.moraResultContainer = new Container();
    this.moraResultContainer.position.set(startX + 16, startY + 350);

    const resBg = new Graphics();
    resBg.roundRect(0, 0, 308, 115, 8);
    resBg.fill({ color: 0x09090b, alpha: 0.9 });
    resBg.stroke({ color: 0x3f3f46, width: 1.5 });
    this.moraResultContainer.addChild(resBg);

    this.moraResultText = new Text({
      text: 'Escolha uma mão para jogar!',
      style: { fill: '#fef08a', fontSize: 13, fontWeight: 'bold' },
    });
    this.moraResultText.position.set(16, 14);
    this.moraResultContainer.addChild(this.moraResultText);

    this.moraDetailText = new Text({
      text: 'Aguardando sua jogada contra o taverneiro...',
      style: { fill: '#a1a1aa', fontSize: 11, lineHeight: 18, wordWrap: true, wordWrapWidth: 280 },
    });
    this.moraDetailText.position.set(16, 42);
    this.moraResultContainer.addChild(this.moraDetailText);

    this.windowContainer.addChild(this.moraResultContainer);
  }

  private createMoraButton(choiceId: number, label: string, iconPath: string, color: number, x: number, y: number): Container {
    const btn = new Container();
    btn.position.set(x, y);
    btn.eventMode = 'static';
    btn.cursor = 'pointer';

    const bg = new Graphics();
    bg.roundRect(0, 0, 308, 52, 8);
    bg.fill({ color, alpha: 0.85 });
    bg.stroke({ color: 0xfef08a, width: 1.5 });
    btn.addChild(bg);

    const spr = new Sprite();
    spr.width = 38;
    spr.height = 38;
    spr.position.set(12, 7);
    const tex = Assets.get(iconPath);
    if (tex) spr.texture = tex;
    btn.addChild(spr);

    const txt = new Text({
      text: label,
      style: { fill: '#ffffff', fontSize: 14, fontWeight: 'bold', stroke: { color: '#000000', width: 3 } },
    });
    txt.position.set(65, 16);
    btn.addChild(txt);

    btn.on('pointerenter', () => {
      btn.alpha = 0.85;
      btn.scale.set(1.02);
    });
    btn.on('pointerleave', () => {
      btn.alpha = 1.0;
      btn.scale.set(1.0);
    });
    btn.on('pointertap', () => {
      this.playMora(choiceId);
    });

    return btn;
  }

  private buildNinjaList(startX: number, startY: number): void {
    const listBg = new Graphics();
    listBg.roundRect(startX, startY, 565, 485, 8);
    listBg.fill({ color: 0x111827, alpha: 0.95 });
    listBg.stroke({ color: 0x92400e, width: 2 });
    this.windowContainer.addChild(listBg);

    const title = new Text({
      text: 'NINJAS DISPONÍVEIS PARA RECRUTAMENTO',
      style: { fill: '#fbbf24', fontSize: 13, fontWeight: 'bold' },
    });
    title.position.set(startX + 16, startY + 12);
    this.windowContainer.addChild(title);

    // Renderiza cada ninja da taverna em cartões horizontais
    let curY = startY + 40;
    for (const ninja of this.tavernNinjas) {
      const card = this.createNinjaCard(ninja, startX + 16, curY);
      this.windowContainer.addChild(card);
      curY += 70;
    }
  }

  private createNinjaCard(ninja: TavernNinjaOption, x: number, y: number): Container {
    const card = new Container();
    card.position.set(x, y);

    const isRecruited = this.recruitedHeroIds.has(ninja.id);

    const bg = new Graphics();
    bg.roundRect(0, 0, 533, 62, 6);
    bg.fill({ color: isRecruited ? 0x064e3b : 0x1f2937, alpha: 0.95 });
    bg.stroke({ color: isRecruited ? 0x10b981 : 0xd97706, width: 1.5 });
    card.addChild(bg);

    // Retrato
    const avatarSpr = new Sprite();
    avatarSpr.width = 48;
    avatarSpr.height = 48;
    avatarSpr.position.set(7, 7);
    const tex = Assets.get(ninja.avatarPath);
    if (tex) avatarSpr.texture = tex;
    card.addChild(avatarSpr);

    // Nome e Cargo
    const nameTxt = new Text({
      text: `${ninja.name} (${ninja.role})`,
      style: { fill: '#fef08a', fontSize: 12, fontWeight: 'bold' },
    });
    nameTxt.position.set(65, 8);
    card.addChild(nameTxt);

    // Atributos
    const statsTxt = new Text({
      text: `HP: ${ninja.hp} | ATK: ${ninja.atk} | DEF: ${ninja.def} | SPD: ${ninja.spd}`,
      style: { fill: '#94a3b8', fontSize: 10 },
    });
    statsTxt.position.set(65, 30);
    card.addChild(statsTxt);

    // Custo / Botão Recrutar
    const btnRecruit = new Container();
    btnRecruit.position.set(405, 13);
    btnRecruit.eventMode = 'static';
    btnRecruit.cursor = 'pointer';

    const canAfford = this.soulsCount >= ninja.cost && !isRecruited;
    const btnBg = new Graphics();
    btnBg.roundRect(0, 0, 115, 36, 6);
    btnBg.fill({ color: isRecruited ? 0x065f46 : (canAfford ? 0x15803d : 0x4b5563), alpha: 0.95 });
    btnBg.stroke({ color: isRecruited ? 0x34d399 : (canAfford ? 0xfef08a : 0x6b7280), width: 1.5 });
    btnRecruit.addChild(btnBg);

    const btnTxt = new Text({
      text: isRecruited ? '✓ RECRUTADO' : `RECRUTAR (${ninja.cost} 🌀)`,
      style: { fill: '#ffffff', fontSize: 10, fontWeight: 'bold' },
    });
    btnTxt.anchor.set(0.5, 0.5);
    btnTxt.position.set(57, 18);
    btnRecruit.addChild(btnTxt);

    if (canAfford) {
      btnRecruit.on('pointertap', () => {
        this.recruitNinja(ninja.id);
      });
    }

    card.addChild(btnRecruit);
    this.recruitButtons.set(ninja.id, btnRecruit);

    return card;
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

  public handleMoraResult(data: { clientChoice: number; serverChoice: number; result: string; soulsAwarded: number; currency: { ninja_souls: number } }): void {
    const names = ['Pedra ✊', 'Tesoura ✌️', 'Papel ✋'];
    const myHand = names[data.clientChoice] || 'Desconhecido';
    const serverHand = names[data.serverChoice] || 'Desconhecido';

    let title = '';
    let color = '#fef08a';

    if (data.result === 'win') {
      title = '🎉 VITÓRIA NA MORA!';
      color = '#22c55e';
    } else if (data.result === 'draw') {
      title = '🤝 EMPATE!';
      color = '#38bdf8';
    } else {
      title = '💔 DERROTA!';
      color = '#ef4444';
    }

    this.moraResultText.text = title;
    this.moraResultText.style.fill = color;
    this.moraDetailText.text = `Você: ${myHand}  VS  Taverneiro: ${serverHand}\nRecompensa: +${data.soulsAwarded} Almas Ninjas acumuladas!`;

    if (data.currency?.ninja_souls !== undefined) {
      this.soulsCount = data.currency.ninja_souls;
      this.lblSouls.text = `🌀 Suas Almas Ninjas: ${this.soulsCount}`;
    }
  }

  public handleRecruitResult(data: { success: boolean; message: string; team?: any[]; currency?: { ninja_souls: number } }): void {
    if (data.currency?.ninja_souls !== undefined) {
      this.soulsCount = data.currency.ninja_souls;
      this.lblSouls.text = `🌀 Suas Almas Ninjas: ${this.soulsCount}`;
    }

    if (data.team) {
      for (const m of data.team) {
        this.recruitedHeroIds.add(m.hero_id);
      }
    }

    this.moraResultText.text = data.success ? '✨ NINJA RECRUTADO!' : '⚠️ FALHA NO RECRUTAMENTO';
    this.moraResultText.style.fill = data.success ? '#22c55e' : '#f59e0b';
    this.moraDetailText.text = data.message;
  }

  public updateTavernState(team: any[], currency: { ninja_souls: number }): void {
    this.soulsCount = currency.ninja_souls || 0;
    if (this.lblSouls) {
      this.lblSouls.text = `🌀 Suas Almas Ninjas: ${this.soulsCount}`;
    }

    this.recruitedHeroIds.clear();
    for (const m of team) {
      this.recruitedHeroIds.add(m.hero_id);
    }
  }
}

