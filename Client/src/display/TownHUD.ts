import { Container, Graphics, Sprite, Text, TextStyle, Assets } from 'pixi.js';
import { PlayerProfile } from './TownScene.js';
import { InventoryItemDto, MailDto } from '../network/Packets.js';

export interface ItemMeta {
  name: string;
  icon: string;
  desc: string;
  type: 'consumable' | 'equip' | 'quest' | 'material';
  canUse: boolean;
}

export const ITEM_CATALOG: Record<number, ItemMeta> = {
  1001: { name: 'Kunai de Ferro', icon: '/assets/items/item_kunai.png', desc: 'Arma de arremesso forjada no País do Fogo. Essencial para todo Genin.', type: 'equip', canUse: false },
  2001: { name: 'Ramen Ichiraku', icon: '/assets/items/item_ramen_bowl.png', desc: 'A deliciosa tigela de ramen preferida de Naruto. Restaura 20 de Vigor e 250 de Vida.', type: 'consumable', canUse: true },
  3001: { name: 'Pergaminho de Chakra', icon: '/assets/items/item_chakra_scroll.png', desc: 'Contém ensinamentos ninjas de manipulação de chakra. Concede 150 EXP.', type: 'consumable', canUse: true },
  4001: { name: 'Bandana de Konoha', icon: '/assets/items/item_headband.png', desc: 'Símbolo sagrado de honra e lealdade à Vila da Folha.', type: 'equip', canUse: false },
  4002: { name: 'Colete Shinobi', icon: '/assets/items/item_vest.png', desc: 'Uniforme tradicional com bolsos reforçados para pergaminhos e armas.', type: 'equip', canUse: false },
  4003: { name: 'Sandálias Ninja', icon: '/assets/items/item_sandals.png', desc: 'Calçado leve para mobilidade silenciosa e velocidade sobre árvores.', type: 'equip', canUse: false },
  4004: { name: 'Anel Ninja', icon: '/assets/items/item_ring.png', desc: 'Amuleto gravado que estabiliza e canaliza o fluxo interno de chakra.', type: 'equip', canUse: false },
  4005: { name: 'Faixa de Batalha', icon: '/assets/items/item_belt.png', desc: 'Faixa resistente que dá firmeza na cintura e protege a região lombar.', type: 'equip', canUse: false }
};

export interface HudCallbacks {
  onQuestClick?: (npcName: string) => void;
  onBgmToggle?: () => void;
  onBattleTest?: () => void;
  onChatSend?: (channel: string, message: string) => void;
  onBackpackOpen?: () => void;
  onBackpackMerge?: () => void;
  onBackpackUseItem?: (guidHigh: number, guidLow: number) => void;
  onFormationChange?: (heroId: number, newPos: number) => void;
  onMailOpen?: () => void;
  onMailGetAttachment?: (mailId: number) => void;
  onTavernMora?: (moraHand: number, npcId: number) => void;
  onTavernRecruit?: (heroId: number) => void;
  onGuildOpen?: () => void;
  onGuildDonate?: (amount: number) => void;
  onRedeemCdk?: (code: string) => void;
  onHeroUpgrade?: () => void;
}


export class TownHUD extends Container {
  private profile: PlayerProfile;
  private callbacks: HudCallbacks;

  // Subcontainers
  private topProfileCont: Container;
  private currencyCont: Container;
  private activityCont: Container;
  private radarCont: Container;
  private bottomBarCont: Container;
  private questTrackerCont: Container;
  private chatBoxCont: Container;
  private modalLayer: Container;

  // Elementos reativos
  private hpFill!: Graphics;
  private hpText!: Text;
  private silverText!: Text;
  private couponText!: Text;
  private goldText!: Text;
  private coordsText!: Text;
  private cityNameText!: Text;
  private bgmLabelText!: Text;
  private questTitleText!: Text;
  private questTargetText!: Text;
  private currentQuestTargetNpc: string = 'Hokage';

  // Chat Feed
  private chatMessagesCont!: Container;
  private chatInputDom: HTMLInputElement | null = null;
  private currentChatChannel: string = 'Mundo';
  private chatChannelBadgeText!: Text;
  private tabButtons: { name: string; container: Container; txt: Text }[] = [];

  // Modais
  private bagModal: Container | null = null;
  private bagItems: InventoryItemDto[] = [];
  private activeBagTab: string = 'Todos';
  private bagSlotsCont: Container = new Container();
  private bagCapacityText!: Text;
  private bagRyoText!: Text;
  private bagCouponText!: Text;
  private itemDetailPopup: Container | null = null;
  private bagTabButtons: { name: string; cont: Container; txt: Text }[] = [];
  private formationModal: Container | null = null;
  private tatamiPositions: Record<number, { x: number; y: number }> = {
    1: { x: 260, y: 170 },
    2: { x: 390, y: 170 },
    3: { x: 520, y: 170 },
    4: { x: 260, y: 240 },
    5: { x: 390, y: 240 },
    6: { x: 520, y: 240 },
    7: { x: 260, y: 310 },
    8: { x: 390, y: 310 },
    9: { x: 520, y: 310 }
  };
  private formationNinjas: { heroId: number; name: string; portrait: string; pos: number }[] = [
    { heroId: 1000, name: 'Líder', portrait: '/assets/ui/portrait_329.png', pos: 5 },
    { heroId: 11100006, name: 'Naruto', portrait: '/assets/ui/portrait_325.png', pos: 2 },
    { heroId: 11100007, name: 'Sasuke', portrait: '/assets/ui/portrait_327.png', pos: 3 },
    { heroId: 11100013, name: 'Sakura', portrait: '/assets/ui/portrait_331.png', pos: 8 }
  ];
  private benchNinjas: { heroId: number; name: string; portrait: string }[] = [
    { heroId: 11100005, name: 'Kakashi', portrait: '/assets/ui/portrait_333.png' },
    { heroId: 11100014, name: 'Tsunade', portrait: '/assets/ui/portrait_335.png' },
    { heroId: 11100011, name: 'Jiraiya', portrait: '/assets/ui/portrait_337.png' }
  ];
  private selectedFormationNinja: { heroId: number; name: string; fromBench: boolean } | null = null;
  private formationTokensCont: Container = new Container();
  private benchSlotsCont: Container = new Container();
  private formationStatusText!: Text;
  private heroModal: Container | null = null;
  private mailModal: Container | null = null;
  private mailList: MailDto[] = [];
  private selectedMail: MailDto | null = null;
  private mailListCont: Container = new Container();
  private mailDetailCont: Container = new Container();
  private mailTabButtons: { name: string; cont: Container; txt: Text }[] = [];
  private activeMailTab: string = 'Entrada';
  private tavernModal: Container | null = null;
  private tavernSouls = { blue: 25, purple: 15, gold: 5 };
  private tavernSoulsText!: Text;
  private tavernResultText!: Text;
  private tavernMyHandText!: Text;
  private tavernNpcHandText!: Text;
  private guildModal: Container | null = null;
  private activityGiftModal: Container | null = null;
  private giftModalTitleText!: Text;
  private guildContributionText!: Text;
  private playerGuildContribution: number = 1500;
  private combatPowerText!: Text;
  private heroCombatPower: number = 290;
  private heroCombatPowerLabel!: Text;
  private battleVictoryModal: Container | null = null;
  private cdkClaimLabel: Text | null = null;

  // Teclado
  private keyHandler: (e: KeyboardEvent) => void;

  constructor(profile: PlayerProfile, callbacks: HudCallbacks) {
    super();
    this.profile = profile;
    this.callbacks = callbacks;

    this.topProfileCont = new Container();
    this.currencyCont = new Container();
    this.activityCont = new Container();
    this.radarCont = new Container();
    this.bottomBarCont = new Container();
    this.questTrackerCont = new Container();
    this.chatBoxCont = new Container();
    this.modalLayer = new Container();

    this.addChild(this.topProfileCont);
    this.addChild(this.currencyCont);
    this.addChild(this.activityCont);
    this.addChild(this.radarCont);
    this.addChild(this.bottomBarCont);
    this.addChild(this.questTrackerCont);
    this.addChild(this.chatBoxCont);
    this.addChild(this.modalLayer);

    this.buildCurrencyBar();
    this.buildTopProfileHUD();
    this.buildActivityBar();
    this.buildRadarCompass();
    this.buildQuestTracker();
    this.buildChatBox();
    this.buildBottomShortcutBar();
    this.buildModals();

    // Listener global de atalhos (B = Mochila, T = Formação, C = Ninja, M = Correio, Esc = Fechar)
    this.keyHandler = (e: KeyboardEvent) => {
      if (document.activeElement === this.chatInputDom) return;
      const key = e.key.toUpperCase();
      if (key === 'B') {
        this.toggleBackpack();
      } else if (key === 'T') {
        this.toggleFormation();
      } else if (key === 'C') {
        this.toggleHero();
      } else if (key === 'M') {
        this.toggleMail();
      } else if (key === 'Y') {
        this.toggleTavern();
      } else if (key === 'O') {
        this.toggleGuild();
      } else if (key === 'P') {
        if (this.callbacks.onBattleTest) {
          this.callbacks.onBattleTest();
        }
      } else if (e.key === 'Escape') {
        this.closeAllModals();
      }
    };
    window.addEventListener('keydown', this.keyHandler);
  }

  /* =========================================================================
   * 1. TOP-LEFT: BARRA DE MOEDAS CANÔNICA (376.png) + RECARGA (1321.png)
   * ========================================================================= */
  private async buildCurrencyBar(): Promise<void> {
    this.currencyCont.position.set(6, 0);

    try {
      const curTex = await Assets.load('/assets/ui/hud/376.png');
      const curSprite = new Sprite(curTex);
      this.currencyCont.addChild(curSprite);
    } catch {
      const bg = new Graphics()
        .roundRect(0, 0, 385, 46, 6)
        .fill({ color: 0x161b22, alpha: 0.9 })
        .stroke({ color: 0x30363d, width: 1.5 });
      this.currencyCont.addChild(bg);
    }

    // Slot 1: Ryo / Prata (centro do recesso x = 74, y = 16)
    this.silverText = new Text({
      text: `${(this.profile.silver || 10000).toLocaleString()}`,
      style: new TextStyle({
        fontFamily: 'SimSun, "Microsoft YaHei", sans-serif',
        fontSize: 10.5,
        fontWeight: 'bold',
        fill: '#ecf0f1',
        stroke: { color: '#000000', width: 2 }
      })
    });
    this.silverText.anchor.set(0.5, 0.5);
    this.silverText.position.set(74, 16);
    this.currencyCont.addChild(this.silverText);

    // Slot 2: Lingotes de Ouro (centro do recesso x = 180, y = 16)
    this.goldText = new Text({
      text: `${this.profile.gold || 0}`,
      style: new TextStyle({
        fontFamily: 'SimSun, "Microsoft YaHei", sans-serif',
        fontSize: 10.5,
        fontWeight: 'bold',
        fill: '#ffd700',
        stroke: { color: '#000000', width: 2 }
      })
    });
    this.goldText.anchor.set(0.5, 0.5);
    this.goldText.position.set(180, 16);
    this.currencyCont.addChild(this.goldText);

    // Slot 3: Cupons (centro do recesso x = 304, y = 16)
    this.couponText = new Text({
      text: '200',
      style: new TextStyle({
        fontFamily: 'SimSun, "Microsoft YaHei", sans-serif',
        fontSize: 10.5,
        fontWeight: 'bold',
        fill: '#f39c12',
        stroke: { color: '#000000', width: 2 }
      })
    });
    this.couponText.anchor.set(0.5, 0.5);
    this.couponText.position.set(304, 16);
    this.currencyCont.addChild(this.couponText);

    // Botão Recarga Oficial (1321.png) - anexado na terminação do pergaminho
    const rechargeCont = new Container();
    rechargeCont.position.set(362, -4);
    rechargeCont.eventMode = 'static';
    rechargeCont.cursor = 'pointer';

    try {
      const recTex = await Assets.load('/assets/ui/hud/1321.png');
      const recSprite = new Sprite(recTex);
      recSprite.scale.set(0.74);
      rechargeCont.addChild(recSprite);
    } catch {
      const fb = new Graphics()
        .roundRect(0, 0, 48, 42, 4)
        .fill(0xc0392b)
        .stroke({ color: 0xf1c40f, width: 1.5 });
      rechargeCont.addChild(fb);
    }

    const recLabel = new Text({
      text: 'Recarga',
      style: new TextStyle({
        fontFamily: 'SimSun, "Microsoft YaHei", sans-serif',
        fontSize: 8.5,
        fontWeight: 'bold',
        fill: '#ffd700',
        stroke: { color: '#4a1500', width: 2.5 }
      })
    });
    recLabel.anchor.set(0.5, 0.5);
    recLabel.position.set(22, 23);
    rechargeCont.addChild(recLabel);

    rechargeCont.on('pointerenter', () => { rechargeCont.scale.set(1.05); });
    rechargeCont.on('pointerleave', () => { rechargeCont.scale.set(1.0); });
    rechargeCont.on('pointertap', () => {
      alert('🌟 Portal Oficial de Recarga Shinobi');
    });
    this.currencyCont.addChild(rechargeCont);
  }

  /* =========================================================================
   * 2. TOP-LEFT: PERFIL DO JOGADOR, VIGOR & PODER DE LUTA (432.png + 323.png)
   * ========================================================================= */
  private async buildTopProfileHUD(): Promise<void> {
    this.topProfileCont.position.set(6, 36);

    // 1. Moldura Oficial Flash (432.png - 305x109)
    try {
      const frameTex = await Assets.load('/assets/ui/hud/432.png');
      const frameSprite = new Sprite(frameTex);
      this.topProfileCont.addChild(frameSprite);
    } catch {
      const fallback = new Graphics()
        .roundRect(0, 0, 305, 109, 8)
        .fill({ color: 0x12151d, alpha: 0.9 })
        .stroke({ color: 0xd4af37, width: 2 });
      this.topProfileCont.addChild(fallback);
    }

    // 2. Retrato Circular Autêntico do Ninja no disco seigaiha (centro exato 47, 54)
    const portraitMap: Record<number, string> = {
      4: this.profile.gender === 1 ? 'portrait_325.png' : 'portrait_327.png',
      1: this.profile.gender === 1 ? 'portrait_329.png' : 'portrait_331.png',
      3: this.profile.gender === 1 ? 'portrait_333.png' : 'portrait_335.png',
      2: this.profile.gender === 1 ? 'portrait_337.png' : 'portrait_339.png',
      5: this.profile.gender === 1 ? 'portrait_341.png' : 'portrait_343.png'
    };
    const portraitFile = portraitMap[this.profile.profession] || 'portrait_325.png';

    const avatarCircleCont = new Container();
    avatarCircleCont.position.set(47, 54);

    try {
      const pTex = await Assets.load(`/assets/ui/${portraitFile}`);
      const portraitSprite = new Sprite(pTex);
      portraitSprite.anchor.set(0.5, 0.5);
      portraitSprite.width = 68;
      portraitSprite.height = 68;

      const circleMask = new Graphics()
        .circle(0, 0, 33)
        .fill(0xffffff);

      portraitSprite.mask = circleMask;
      avatarCircleCont.addChild(circleMask);
      avatarCircleCont.addChild(portraitSprite);
    } catch {
      const fallbackCircle = new Graphics()
        .circle(0, 0, 33)
        .fill(0x334455);
      avatarCircleCont.addChild(fallbackCircle);
    }
    this.topProfileCont.addChild(avatarCircleCont);

    // 3. Emblema de Nível (Lv.1) dentro da barra verde superior (x = 100, y = 23)
    const levelTxt = new Text({
      text: `Lv.${this.profile.level || 1}`,
      style: new TextStyle({
        fontFamily: 'SimSun, "Microsoft YaHei", sans-serif',
        fontSize: 11,
        fontWeight: 'bold',
        fill: '#ffd700',
        stroke: { color: '#2a1604', width: 2.5 }
      })
    });
    levelTxt.anchor.set(0, 0.5);
    levelTxt.position.set(100, 23);
    this.topProfileCont.addChild(levelTxt);

    // 4. Nome do Jogador dentro da barra verde superior (x = 142, y = 23)
    const nameTxt = new Text({
      text: this.profile.name || 'Dasi',
      style: new TextStyle({
        fontFamily: 'SimSun, "Microsoft YaHei", sans-serif',
        fontSize: 11.5,
        fontWeight: 'bold',
        fill: '#f0e6d2',
        stroke: { color: '#1a1006', width: 2.5 }
      })
    });
    nameTxt.anchor.set(0, 0.5);
    nameTxt.position.set(142, 23);
    this.topProfileCont.addChild(nameTxt);

    // 5. Label "Vigor" na área de madeira à esquerda do slot preto (x = 114, y = 57)
    const vigorLabel = new Text({
      text: 'Vigor',
      style: new TextStyle({
        fontFamily: 'SimSun, "Microsoft YaHei", sans-serif',
        fontSize: 9.5,
        fontWeight: 'bold',
        fill: '#ff7675',
        stroke: { color: '#2c0b0e', width: 2 }
      })
    });
    vigorLabel.anchor.set(0.5, 0.5);
    vigorLabel.position.set(114, 57);
    this.topProfileCont.addChild(vigorLabel);

    // 6. Barra de Vigor Vermelha: Preenchendo com precisão o recesso preto de 432.png (x: 138, y: 53, w: 110, h: 8)
    this.hpFill = new Graphics()
      .roundRect(138, 53, 72, 8, 2)
      .fill(0xd63031);
    this.topProfileCont.addChild(this.hpFill);

    this.hpText = new Text({
      text: '50/80',
      style: new TextStyle({
        fontFamily: 'SimSun, "Microsoft YaHei", sans-serif',
        fontSize: 8.5,
        fontWeight: 'bold',
        fill: '#ffffff',
        stroke: { color: '#000000', width: 2 }
      })
    });
    this.hpText.anchor.set(0.5, 0.5);
    this.hpText.position.set(194, 57);
    this.topProfileCont.addChild(this.hpText);

    // Botão "+" ao lado direito do recesso de vigor (x = 258, y = 57)
    const staminaAddBtn = new Graphics()
      .circle(258, 57, 5.5)
      .fill(0x27ae60)
      .stroke({ color: 0xf1c40f, width: 1 });
    this.topProfileCont.addChild(staminaAddBtn);

    const staminaPlusText = new Text({
      text: '+',
      style: new TextStyle({ fontSize: 8.5, fontWeight: 'bold', fill: '#ffffff' })
    });
    staminaPlusText.anchor.set(0.5, 0.5);
    staminaPlusText.position.set(258, 56.5);
    this.topProfileCont.addChild(staminaPlusText);

    // 7. Botão e Label "Acelerar" no disco do alvo original
    const speedLabel = new Text({
      text: 'Acelerar',
      style: new TextStyle({
        fontFamily: 'SimSun, "Microsoft YaHei", sans-serif',
        fontSize: 8,
        fontWeight: 'bold',
        fill: '#ffd700',
        stroke: { color: '#000000', width: 2 }
      })
    });
    speedLabel.anchor.set(0.5, 0);
    speedLabel.position.set(282, 64);
    this.topProfileCont.addChild(speedLabel);

    // 8. Selo "VIP 0" posicionado abaixo do disco do avatar (x: 10, y: 92)
    const vipCont = new Container();
    vipCont.position.set(10, 92);
    vipCont.eventMode = 'static';
    vipCont.cursor = 'pointer';

    const vipBg = new Graphics()
      .roundRect(0, 0, 50, 16, 3)
      .fill(0xa93226)
      .stroke({ color: 0xf1c40f, width: 1.5 });
    vipCont.addChild(vipBg);

    const vipTxt = new Text({
      text: 'VIP 0',
      style: new TextStyle({
        fontFamily: 'SimSun, "Microsoft YaHei", sans-serif',
        fontSize: 9,
        fontWeight: 'bold',
        fill: '#ffd700',
        stroke: { color: '#300a00', width: 2 }
      })
    });
    vipTxt.anchor.set(0.5, 0.5);
    vipTxt.position.set(25, 8);
    vipCont.addChild(vipTxt);

    vipCont.on('pointertap', () => {
      alert('👑 Privilégios VIP Shinobi (VIP 0)');
    });
    this.topProfileCont.addChild(vipCont);

    // Botões utilitários ao lado do VIP (Tela Cheia e Bolsa rápida)
    const fsBtn = new Container();
    fsBtn.position.set(66, 92);
    fsBtn.eventMode = 'static';
    fsBtn.cursor = 'pointer';
    const fsBg = new Graphics().roundRect(0, 0, 16, 16, 2).fill(0x2d3436).stroke({ color: 0x27ae60, width: 1 });
    const fsTxt = new Text({ text: '⛶', style: new TextStyle({ fontSize: 10, fill: '#2ecc71' }) });
    fsTxt.anchor.set(0.5, 0.5);
    fsTxt.position.set(8, 8);
    fsBtn.addChild(fsBg, fsTxt);
    fsBtn.on('pointertap', () => {
      if (!document.fullscreenElement) {
        document.documentElement.requestFullscreen().catch(() => {});
      } else {
        document.exitFullscreen().catch(() => {});
      }
    });
    this.topProfileCont.addChild(fsBtn);

    // 9. Placa Oficial de Poder de Luta (323.png) com escala canônica compacta (0.68)
    const powerCont = new Container();
    powerCont.position.set(6, 122);

    try {
      const powerTex = await Assets.load('/assets/ui/hud/323.png');
      const powerSprite = new Sprite(powerTex);
      powerSprite.scale.set(0.68);
      powerCont.addChild(powerSprite);
    } catch {
      const fb = new Graphics()
        .roundRect(0, 0, 160, 64, 6)
        .fill({ color: 0x1f1917, alpha: 0.95 })
        .stroke({ color: 0x8e44ad, width: 1.5 });
      powerCont.addChild(fb);
    }

    // Botão "+" circular dentro do disco do 323.png (centro 32, 32 em escala 0.68)
    const sealBtn = new Container();
    sealBtn.position.set(32, 32);
    sealBtn.eventMode = 'static';
    sealBtn.cursor = 'pointer';

    const sealBg = new Graphics()
      .circle(0, 0, 18)
      .fill(0xd35400)
      .stroke({ color: 0xf1c40f, width: 1.5 });
    sealBtn.addChild(sealBg);

    const sealText = new Text({
      text: '+',
      style: new TextStyle({
        fontFamily: 'Arial Black, Impact, sans-serif',
        fontSize: 14,
        fontWeight: 'bold',
        fill: '#ffffff',
        stroke: { color: '#300a00', width: 2 }
      })
    });
    sealText.anchor.set(0.5, 0.5);
    sealBtn.addChild(sealText);
    powerCont.addChild(sealBtn);

    // Título "Poder Ninja" dentro da faixa verde superior de 323.png
    const powerTitle = new Text({
      text: 'Poder Ninja',
      style: new TextStyle({
        fontFamily: 'SimSun, "Microsoft YaHei", sans-serif',
        fontSize: 9.5,
        fontWeight: 'bold',
        fill: '#ffd700',
        stroke: { color: '#2a1604', width: 2 }
      })
    });
    powerTitle.anchor.set(0.5, 0.5);
    powerTitle.position.set(104, 13);
    powerCont.addChild(powerTitle);

    // Valor Numérico "290" dentro da faixa dourada inferior de 323.png
    const powerValue = new Text({
      text: '290',
      style: new TextStyle({
        fontFamily: 'Impact, Arial Black, sans-serif',
        fontSize: 20,
        fontWeight: 'bold',
        fill: '#ffd700',
        stroke: { color: '#3e1a00', width: 3 }
      })
    });
    powerValue.anchor.set(0.5, 0.5);
    powerValue.position.set(104, 40);
    powerCont.addChild(powerValue);
    this.combatPowerText = powerValue;

    this.topProfileCont.addChild(powerCont);
  }

  /* =========================================================================
   * 3. TOP BANNER: ATIVIDADES & EVENTOS EM PORTUGUÊS (1001.png - 1087.png)
   * ========================================================================= */
  private async buildActivityBar(): Promise<void> {
    // Alinhado a partir de x = 445 para dar folga segura após o botão de Recarga
    this.activityCont.position.set(445, 6);

    const activities = [
      { id: 'update', file: '1001.png', label: 'Novidades' },
      { id: 'monthly', file: '1010.png', label: 'Mensal' },
      { id: 'spend_rank', file: '1020.png', label: 'Consumo' },
      { id: 'recharge_rank', file: '1029.png', label: 'Ranking' },
      { id: 'black_market', file: '1038.png', label: 'M. Negro' },
      { id: 'ninja_gather', file: '1047.png', label: 'Encontro' },
      { id: 'mystic_shop', file: '1056.png', label: 'L. Secreta' },
      { id: 'recharge_gift', file: '1069.png', label: '1ª Recarga' },
      { id: 'newbie_gift', file: '1078.png', label: 'Iniciante' },
      { id: 'cdk_code', file: '1087.png', label: 'Código' }
    ];

    let currentX = 0;
    const spacing = 39;

    for (const act of activities) {
      const btn = new Container();
      btn.position.set(currentX, 0);
      btn.eventMode = 'static';
      btn.cursor = 'pointer';

      try {
        const tex = await Assets.load(`/assets/ui/hud/${act.file}`);
        const sp = new Sprite(tex);
        sp.anchor.set(0.5, 0);
        sp.scale.set(0.56);
        btn.addChild(sp);
      } catch {
        const fb = new Graphics()
          .circle(0, 16, 13)
          .fill(0xd4af37);
        btn.addChild(fb);
      }

      const labelTxt = new Text({
        text: act.label,
        style: new TextStyle({
          fontFamily: 'SimSun, "Microsoft YaHei", sans-serif',
          fontSize: 8,
          fontWeight: 'bold',
          fill: '#f0e6d2',
          align: 'center',
          stroke: { color: '#1a1006', width: 2 }
        })
      });
      labelTxt.anchor.set(0.5, 0);
      labelTxt.position.set(0, 42);
      btn.addChild(labelTxt);

      btn.on('pointerenter', () => { btn.scale.set(1.08); });
      btn.on('pointerleave', () => { btn.scale.set(1.0); });
      btn.on('pointertap', () => {
        this.toggleActivityGift(act.label);
      });

      this.activityCont.addChild(btn);
      currentX += spacing;
    }
  }

  /* =========================================================================
   * 4. TOP-RIGHT: RADAR, BÚSSOLA CANÔNICA (81.png), RELÓGIO & ASSISTENTE
   * ========================================================================= */
  private async buildRadarCompass(): Promise<void> {
    // Alinhado no canto superior direito com margem de segurança contra cortes (1250 - 192 = 1058)
    this.radarCont.position.set(1250 - 192, 0);

    // Caminho Hokage (1100.png) - à esquerda do assistente
    const hokageRoad = new Container();
    hokageRoad.position.set(-96, 12);
    hokageRoad.eventMode = 'static';
    hokageRoad.cursor = 'pointer';

    try {
      const roadTex = await Assets.load('/assets/ui/hud/1100.png');
      const roadSp = new Sprite(roadTex);
      roadSp.anchor.set(0.5, 0);
      roadSp.scale.set(0.58);
      hokageRoad.addChild(roadSp);
    } catch {
      // Fallback
    }

    const roadTxt = new Text({
      text: 'Caminho\nHokage',
      style: new TextStyle({
        fontFamily: 'SimSun, "Microsoft YaHei", sans-serif',
        fontSize: 8,
        fontWeight: 'bold',
        fill: '#ffd700',
        align: 'center',
        lineHeight: 10,
        stroke: { color: '#000000', width: 2 }
      })
    });
    roadTxt.anchor.set(0.5, 0);
    roadTxt.position.set(0, 42);
    hokageRoad.addChild(roadTxt);
    hokageRoad.on('pointertap', () => alert('📜 Caminho do Hokage'));
    this.radarCont.addChild(hokageRoad);

    // Assistente Ninja (867.png) - à esquerda do minimapa
    const helper = new Container();
    helper.position.set(-46, 12);
    helper.eventMode = 'static';
    helper.cursor = 'pointer';

    try {
      const helperTex = await Assets.load('/assets/ui/hud/867.png');
      const helperSp = new Sprite(helperTex);
      helperSp.anchor.set(0.5, 0);
      helperSp.scale.set(0.58);
      helper.addChild(helperSp);
    } catch {
      // Fallback
    }

    const helperTxt = new Text({
      text: 'Assistente',
      style: new TextStyle({
        fontFamily: 'SimSun, "Microsoft YaHei", sans-serif',
        fontSize: 8.5,
        fontWeight: 'bold',
        fill: '#ffd700',
        align: 'center',
        stroke: { color: '#000000', width: 2 }
      })
    });
    helperTxt.anchor.set(0.5, 0);
    helperTxt.position.set(0, 42);
    helper.addChild(helperTxt);
    helper.on('pointertap', () => alert('🤖 Assistente Shinobi'));
    this.radarCont.addChild(helper);

    // Relógio do Servidor: perfeitamente visível no topo
    const serverTimeTxt = new Text({
      text: 'Horário Ninja 23:12',
      style: new TextStyle({
        fontFamily: 'Arial, sans-serif',
        fontSize: 9,
        fontWeight: 'bold',
        fill: '#ffd700',
        stroke: { color: '#000000', width: 2 }
      })
    });
    serverTimeTxt.position.set(46, 3);
    this.radarCont.addChild(serverTimeTxt);

    // Bússola Circular Canônica do Minimapa (81.png - 200x147)
    const minimapCont = new Container();
    minimapCont.position.set(0, 16);
    minimapCont.eventMode = 'static';
    minimapCont.cursor = 'pointer';

    try {
      const miniTex = await Assets.load('/assets/ui/hud/81.png');
      const miniSp = new Sprite(miniTex);
      miniSp.scale.set(0.90);
      minimapCont.addChild(miniSp);
    } catch {
      const fb = new Graphics()
        .circle(85, 65, 55)
        .fill(0x2c3e50)
        .stroke({ color: 0xd4af37, width: 2 });
      minimapCont.addChild(fb);
    }

    // Texto central "Mapa"
    const mapLabel = new Text({
      text: 'Mapa',
      style: new TextStyle({
        fontFamily: 'SimSun, "Microsoft YaHei", sans-serif',
        fontSize: 14,
        fontWeight: 'bold',
        fill: '#ffffff',
        stroke: { color: '#1a1006', width: 3 }
      })
    });
    mapLabel.anchor.set(0.5, 0.5);
    mapLabel.position.set(88, 42);
    minimapCont.addChild(mapLabel);

    // Coordenadas
    this.coordsText = new Text({
      text: 'X: 450  Y: 480',
      style: new TextStyle({
        fontFamily: 'Arial, sans-serif',
        fontSize: 9,
        fontWeight: 'bold',
        fill: '#ffd700',
        stroke: { color: '#000000', width: 2 }
      })
    });
    this.coordsText.anchor.set(0.5, 0);
    this.coordsText.position.set(88, 62);
    minimapCont.addChild(this.coordsText);

    // Botão Som
    const soundArea = new Container();
    soundArea.position.set(22, 78);
    soundArea.eventMode = 'static';
    soundArea.cursor = 'pointer';

    this.bgmLabelText = new Text({
      text: '🔊',
      style: new TextStyle({ fontSize: 11 })
    });
    this.bgmLabelText.anchor.set(0.5, 0.5);
    soundArea.addChild(this.bgmLabelText);
    soundArea.on('pointertap', (e) => {
      e.stopPropagation();
      if (this.callbacks.onBgmToggle) this.callbacks.onBgmToggle();
    });
    minimapCont.addChild(soundArea);

    minimapCont.on('pointertap', () => {
      alert('🗺 Mapa Mundi Shinobi / Vila da Folha');
    });
    this.radarCont.addChild(minimapCont);
  }

  /* =========================================================================
   * 5. RIGHT-SIDE: RASTREADOR DE MISSÕES & MARCO DE NÍVEL
   * ========================================================================= */
  private async buildQuestTracker(): Promise<void> {
    this.questTrackerCont.position.set(1250 - 216, 158);

    // Botão Flutuante "Loja Ryo"
    const shopRyoCont = new Container();
    shopRyoCont.position.set(-28, 16);
    shopRyoCont.eventMode = 'static';
    shopRyoCont.cursor = 'pointer';

    const shopRyoCircle = new Graphics()
      .circle(0, 0, 15)
      .fill(0xf39c12)
      .stroke({ color: 0xffffff, width: 1.5 });
    shopRyoCont.addChild(shopRyoCircle);

    const ryoIconTxt = new Text({
      text: '🪙',
      style: new TextStyle({ fontSize: 13 })
    });
    ryoIconTxt.anchor.set(0.5, 0.5);
    shopRyoCont.addChild(ryoIconTxt);

    const ryoLabel = new Text({
      text: 'Loja Ryo',
      style: new TextStyle({
        fontFamily: 'SimSun, "Microsoft YaHei", sans-serif',
        fontSize: 8.5,
        fontWeight: 'bold',
        fill: '#ffd700',
        stroke: { color: '#000000', width: 2 }
      })
    });
    ryoLabel.anchor.set(0.5, 0);
    ryoLabel.position.set(0, 16);
    shopRyoCont.addChild(ryoLabel);
    shopRyoCont.on('pointertap', () => alert('🏪 Loja de Itens por Ryo'));
    this.questTrackerCont.addChild(shopRyoCont);

    // Painel Canônico do Rastreador de Missões (Flash 13000000 - task_tracker_panel.png)
    try {
      const panelTex = await Assets.load('/assets/ui/task_tracker_panel.png');
      const panelSp = new Sprite(panelTex);
      panelSp.width = 208;
      panelSp.height = 155;
      this.questTrackerCont.addChild(panelSp);
    } catch {}

    // Título da Missão dentro da área de pergaminho
    this.questTitleText = new Text({
      text: '[Principal] O Livro Roubado',
      style: new TextStyle({
        fontFamily: 'SimSun, "Microsoft YaHei", sans-serif',
        fontSize: 10,
        fontWeight: 'bold',
        fill: '#ffd700',
        stroke: { color: '#000000', width: 2 }
      })
    });
    this.questTitleText.position.set(10, 32);
    this.questTrackerCont.addChild(this.questTitleText);

    // Link clicável do NPC com auto-caminho
    const targetCont = new Container();
    targetCont.position.set(10, 52);
    targetCont.eventMode = 'static';
    targetCont.cursor = 'pointer';

    this.questTargetText = new Text({
      text: 'Entregar para:\nHiruzen Sarutobi (Vila da Folha)',
      style: new TextStyle({
        fontFamily: 'SimSun, "Microsoft YaHei", sans-serif',
        fontSize: 9.5,
        fill: '#3498db',
        fontWeight: 'bold',
        lineHeight: 13
      })
    });
    targetCont.addChild(this.questTargetText);

    targetCont.on('pointerenter', () => { this.questTargetText.style.fill = '#f1c40f'; });
    targetCont.on('pointerleave', () => { this.questTargetText.style.fill = '#3498db'; });
    targetCont.on('pointertap', () => {
      if (this.callbacks.onQuestClick) {
        this.callbacks.onQuestClick(this.currentQuestTargetNpc);
      }
    });
    this.questTrackerCont.addChild(targetCont);

    // Recompensa estimada
    const rewardTxt = new Text({
      text: 'Recompensa: EXP 1.200 | 500 Ryo',
      style: new TextStyle({
        fontFamily: 'SimSun, "Microsoft YaHei", sans-serif',
        fontSize: 8.5,
        fontWeight: 'bold',
        fill: '#2ecc71',
        stroke: { color: '#000000', width: 1.5 }
      })
    });
    rewardTxt.position.set(10, 106);
    this.questTrackerCont.addChild(rewardTxt);

    // Marco Canônico "Meta: Nível 10!" com Ribbon Autêntico Flash
    const milestoneCont = new Container();
    milestoneCont.position.set(0, 160);
    milestoneCont.eventMode = 'static';
    milestoneCont.cursor = 'pointer';

    try {
      const ribbonTex = await Assets.load('/assets/ui/btn_ninja_action.png');
      const ribbonSp = new Sprite(ribbonTex);
      ribbonSp.width = 208;
      ribbonSp.height = 34;
      milestoneCont.addChild(ribbonSp);
    } catch {}

    const mileTitle = new Text({
      text: '⭐ Meta: Nível 10! (Clique para resgatar)',
      style: new TextStyle({
        fontFamily: 'SimSun, "Microsoft YaHei", sans-serif',
        fontSize: 9,
        fontWeight: 'bold',
        fill: '#ffd700',
        stroke: { color: '#000000', width: 2 }
      })
    });
    mileTitle.anchor.set(0.5, 0.5);
    mileTitle.position.set(104, 17);
    milestoneCont.addChild(mileTitle);

    milestoneCont.on('pointertap', () => alert('🎁 Recompensa do Nível 10 Shinobi!'));
    this.questTrackerCont.addChild(milestoneCont);
  }

  /* =========================================================================
   * 6. BOTTOM-LEFT: CHATBOX CANÔNICO EM PORTUGUÊS (00000001.swf)
   * ========================================================================= */
  private async buildChatBox(): Promise<void> {
    this.chatBoxCont.removeChildren();
    this.chatBoxCont.position.set(8, 425);

    // Mensagens de Sistema Obrigatórias da Vila da Folha
    const noticeCont = new Container();
    noticeCont.position.set(0, 0);

    const noticeLines = [
      '[Sistema] Regras da Vila da Folha:',
      '  • Jogue com moderação e equilíbrio;',
      '  • Proteja sua saúde e visão;',
      '  • Respeite outros ninjas no servidor;',
      '  • Dedique-se à Vontade do Fogo!'
    ];

    let noticeY = 0;
    for (const line of noticeLines) {
      const t = new Text({
        text: line,
        style: new TextStyle({
          fontFamily: 'SimSun, "Microsoft YaHei", sans-serif',
          fontSize: 10,
          fontWeight: 'bold',
          fill: '#f1c40f',
          stroke: { color: '#000000', width: 2.5 }
        })
      });
      t.position.set(4, noticeY);
      noticeCont.addChild(t);
      noticeY += 15;
    }
    this.chatBoxCont.addChild(noticeCont);

    // Fundo Canônico do Log de Mensagens (Flash 00000001 - 45.png)
    const chatLogY = 68;
    try {
      const chatBgTex = await Assets.load('/assets/ui/chat/45.png');
      const chatBgSp = new Sprite(chatBgTex);
      chatBgSp.position.set(0, chatLogY);
      chatBgSp.width = 285;
      chatBgSp.height = 90;
      chatBgSp.alpha = 0.55;
      this.chatBoxCont.addChild(chatBgSp);
    } catch {}

    // Feed de Mensagens
    this.chatMessagesCont = new Container();
    this.chatMessagesCont.position.set(6, chatLogY + 4);
    this.chatBoxCont.addChild(this.chatMessagesCont);

    // Barra de Abas de Canais: y = 162
    const tabsCont = new Container();
    tabsCont.position.set(0, 162);

    const channels = ['Geral', 'Servidor', 'Mundo', 'Guilda', 'Privado'];
    this.tabButtons = [];

    const tabTex = await Assets.load('/assets/ui/chat/4.png').catch(() => null);

    for (let i = 0; i < channels.length; i++) {
      const chName = channels[i];
      const tabBtn = new Container();
      tabBtn.position.set(i * 56, 0);
      tabBtn.eventMode = 'static';
      tabBtn.cursor = 'pointer';

      const isSelected = chName === this.currentChatChannel;
      if (tabTex) {
        const tabSp = new Sprite(tabTex);
        tabSp.width = 52;
        tabSp.height = 18;
        tabSp.alpha = isSelected ? 1.0 : 0.65;
        tabBtn.addChild(tabSp);
      }

      const tabTxt = new Text({
        text: chName,
        style: new TextStyle({
          fontFamily: 'SimSun, "Microsoft YaHei", sans-serif',
          fontSize: 9,
          fontWeight: 'bold',
          fill: isSelected ? '#ffd700' : '#dcdde1'
        })
      });
      tabTxt.anchor.set(0.5, 0.5);
      tabTxt.position.set(26, 9);
      tabBtn.addChild(tabTxt);

      this.tabButtons.push({ name: chName, container: tabBtn, txt: tabTxt });

      tabBtn.on('pointertap', () => {
        this.selectChatChannel(chName);
      });
      tabsCont.addChild(tabBtn);
    }
    this.chatBoxCont.addChild(tabsCont);

    // Barra de Entrada Canônica de Madeira Flash (00000001 - 57.png)
    const inputBarCont = new Container();
    inputBarCont.position.set(0, 186);

    try {
      const inputTex = await Assets.load('/assets/ui/chat/57.png');
      const inputSp = new Sprite(inputTex);
      inputSp.width = 285;
      inputSp.height = 24;
      inputBarCont.addChild(inputSp);
    } catch {}

    // Badge do canal ativo no entalhe esquerdo
    this.chatChannelBadgeText = new Text({
      text: this.currentChatChannel,
      style: new TextStyle({
        fontFamily: 'SimSun, "Microsoft YaHei", sans-serif',
        fontSize: 9,
        fontWeight: 'bold',
        fill: '#ffd700'
      })
    });
    this.chatChannelBadgeText.anchor.set(0.5, 0.5);
    this.chatChannelBadgeText.position.set(28, 12);
    inputBarCont.addChild(this.chatChannelBadgeText);

    // Ícone de Emoticon Canônico (Flash 00000001 - 74.png)
    const emoCont = new Container();
    emoCont.position.set(272, 12);
    emoCont.eventMode = 'static';
    emoCont.cursor = 'pointer';

    try {
      const emoTex = await Assets.load('/assets/ui/chat/74.png');
      const emoSp = new Sprite(emoTex);
      emoSp.anchor.set(0.5, 0.5);
      emoSp.width = 18;
      emoSp.height = 18;
      emoCont.addChild(emoSp);
    } catch {}
    emoCont.on('pointertap', () => alert('😊 Emojis e Expressões Ninja'));
    inputBarCont.addChild(emoCont);

    this.chatBoxCont.addChild(inputBarCont);

    this.addChatMessage('Sistema', '', '🍃 Bem-vindo a Naruto Online — Vila da Folha!');
    this.addChatMessage('Mundo', 'Naruto', 'Dattebayo! Eu serei o próximo Hokage!');

    this.createDomChatInput();
  }

  private selectChatChannel(channel: string): void {
    this.currentChatChannel = channel;
    if (this.chatChannelBadgeText) {
      this.chatChannelBadgeText.text = channel;
    }
    for (const btn of this.tabButtons) {
      const isSelected = btn.name === channel;
      btn.container.alpha = isSelected ? 1.0 : 0.65;
      btn.txt.style.fill = isSelected ? '#ffd700' : '#dcdde1';
    }
  }

  private createDomChatInput(): void {
    if (this.chatInputDom) {
      this.chatInputDom.remove();
    }
    const input = document.createElement('input');
    input.type = 'text';
    input.placeholder = 'Digite sua mensagem... (Enter)';
    input.style.position = 'absolute';
    // Posição top exata calculada a partir de #game-container (425 + 186 + 2 = 613px)
    input.style.top = '613px';
    input.style.left = '92px';
    input.style.width = '175px';
    input.style.height = '20px';
    input.style.padding = '0 4px';
    input.style.backgroundColor = 'transparent';
    input.style.border = 'none';
    input.style.outline = 'none';
    input.style.color = '#ffffff';
    input.style.fontFamily = 'SimSun, "Microsoft YaHei", sans-serif';
    input.style.fontSize = '11px';
    input.style.zIndex = '1000';

    input.addEventListener('keydown', (e) => {
      if (e.key === 'Enter') {
        const val = input.value.trim();
        if (val) {
          this.addChatMessage(this.currentChatChannel, this.profile.name, val);
          if (this.callbacks.onChatSend) {
            this.callbacks.onChatSend(this.currentChatChannel, val);
          }
          input.value = '';
        }
      }
    });

    const parent = document.getElementById('game-container') || document.body;
    parent.appendChild(input);
    this.chatInputDom = input;
  }

  public addChatMessage(channel: string, sender: string, text: string): void {
    const channelColors: Record<string, string> = {
      'Sistema': '#f1c40f',
      'Mundo': '#3498db',
      'Servidor': '#9b59b6',
      'Geral': '#e67e22',
      'Guilda': '#2ecc71',
      'Privado': '#1abc9c'
    };
    const col = channelColors[channel] || '#ffffff';
    const fullMsg = sender ? `[${channel}] ${sender}: ${text}` : `[${channel}] ${text}`;

    const line = new Text({
      text: fullMsg,
      style: new TextStyle({
        fontFamily: 'SimSun, "Microsoft YaHei", sans-serif',
        fontSize: 9.5,
        fontWeight: 'bold',
        fill: col,
        wordWrap: true,
        wordWrapWidth: 270,
        stroke: { color: '#000000', width: 2 }
      })
    });

    const msgHeight = 15;
    for (const child of this.chatMessagesCont.children) {
      child.y -= msgHeight;
    }

    line.position.set(0, 68);
    this.chatMessagesCont.addChild(line);

    while (this.chatMessagesCont.children.length > 5) {
      const oldest = this.chatMessagesCont.children[0];
      this.chatMessagesCont.removeChild(oldest);
      oldest.destroy();
    }
  }

  /* =========================================================================
   * 7. BOTTOM-RIGHT: BARRA DE ATALHOS (183.png) & BARRA DE EXP (192/202.png)
   * ========================================================================= */
  private async buildBottomShortcutBar(): Promise<void> {
    this.bottomBarCont.position.set(1250 - 450, 568);

    // Moldura de Madeira Curva Original Flash (183.png - 729x99)
    try {
      const bgTex = await Assets.load('/assets/ui/hud/183.png');
      const bgSp = new Sprite(bgTex);
      bgSp.scale.set(0.62);
      this.bottomBarCont.addChild(bgSp);
    } catch {
      const fb = new Graphics()
        .roundRect(0, 0, 440, 75, 8)
        .fill({ color: 0x1f1917, alpha: 0.95 })
        .stroke({ color: 0x8e44ad, width: 2 });
      this.bottomBarCont.addChild(fb);
    }

    // Botões Oficiais em Português
    const shortcuts = [
      { id: 'heros', file: '283.png', label: 'Ninjas', hotkey: 'C', action: () => this.toggleHero() },
      { id: 'bag', file: '221.png', label: 'Mochila', hotkey: 'B', action: () => this.toggleBackpack() },
      { id: 'mail', file: '261.png', label: 'Correio', hotkey: 'M', action: () => this.toggleMail() },
      { id: 'guild', file: '256.png', label: 'Guilda', hotkey: 'O', action: () => this.toggleGuild() },
      { id: 'formation', file: '226.png', label: 'Formação', hotkey: 'T', action: () => this.toggleFormation() }

    ];

    const slotSpacing = 68;
    const btnStartX = 38;

    for (let i = 0; i < shortcuts.length; i++) {
      const s = shortcuts[i];
      const btnCont = new Container();
      btnCont.position.set(btnStartX + i * slotSpacing, 28);
      btnCont.eventMode = 'static';
      btnCont.cursor = 'pointer';

      try {
        const iconTex = await Assets.load(`/assets/ui/hud/${s.file}`);
        const iconSp = new Sprite(iconTex);
        iconSp.anchor.set(0.5, 0.5);
        iconSp.scale.set(0.78);
        btnCont.addChild(iconSp);
      } catch {
        const fbIcon = new Graphics()
          .circle(0, 0, 20)
          .fill(0xd35400);
        btnCont.addChild(fbIcon);
      }

      const label = new Text({
        text: s.label,
        style: new TextStyle({
          fontFamily: 'SimSun, "Microsoft YaHei", sans-serif',
          fontSize: 9,
          fontWeight: 'bold',
          fill: '#f0e6d2',
          stroke: { color: '#1a1006', width: 2 }
        })
      });
      label.anchor.set(0.5, 0);
      label.position.set(0, 20);
      btnCont.addChild(label);

      btnCont.on('pointerenter', () => { btnCont.y = 24; });
      btnCont.on('pointerleave', () => { btnCont.y = 28; });
      btnCont.on('pointertap', () => s.action());

      this.bottomBarCont.addChild(btnCont);
    }

    // Barra de Experiência Full-Width
    const expCont = new Container();
    expCont.position.set(-270, 68);

    const expTrack = new Graphics()
      .rect(0, 0, 720, 10)
      .fill(0x161b22)
      .stroke({ color: 0x30363d, width: 1 });
    expCont.addChild(expTrack);

    const expFill = new Graphics()
      .rect(0, 0, 0, 10)
      .fill(0xf39c12);
    expCont.addChild(expFill);

    const expTxt = new Text({
      text: 'EXP: 0 / 100 (0.0%)',
      style: new TextStyle({
        fontFamily: 'Arial, sans-serif',
        fontSize: 8,
        fontWeight: 'bold',
        fill: '#ffffff',
        stroke: { color: '#000000', width: 2 }
      })
    });
    expTxt.anchor.set(0.5, 0.5);
    expTxt.position.set(360, 5);
    expCont.addChild(expTxt);

    this.bottomBarCont.addChild(expCont);
  }

  /* =========================================================================
   * 8. MODAIS DE GAMEPLAY (Mochila, Formação 3x3, Ninjas, Correio)
   * ========================================================================= */
  private async buildModals(): Promise<void> {
    await Promise.all([
      this.buildBackpackModal(),
      this.buildFormationModal(),
      this.buildHeroModal(),
      this.buildMailModal(),
      this.buildTavernModal(),
      this.buildGuildModal(),
      this.buildActivityGiftModal()
    ]);
  }


  private async buildBackpackModal(): Promise<void> {
    const w = 459;
    const h = 416;
    this.bagModal = new Container();
    this.bagModal.position.set(Math.floor((1250 - w) / 2), Math.floor((650 - h) / 2));
    this.bagModal.visible = false;

    // Fundo Canônico da Mochila (03000000/images/227.png)
    try {
      const tex = await Assets.load('/assets/ui/modal_bag_canonical.png');
      const sp = new Sprite(tex);
      sp.width = w;
      sp.height = h;
      this.bagModal.addChild(sp);
    } catch {}

    // Título Oficial na Moldura Superior
    const title = new Text({
      text: 'Mochila',
      style: new TextStyle({
        fontFamily: 'SimSun, "Microsoft YaHei", sans-serif',
        fontSize: 12,
        fontWeight: 'bold',
        fill: '#ffd700',
        stroke: { color: '#2a1604', width: 2 }
      })
    });
    title.position.set(38, 16);
    this.bagModal.addChild(title);

    // Botão de Fechar encaixado no entalhe superior direito
    const closeBtn = await this.createCloseButton(() => this.toggleBackpack());
    closeBtn.position.set(434, 20);
    this.bagModal.addChild(closeBtn);

    // Abas no degrau superior da bolsa (x = 75, y = 56)
    const bagTabs = ['Todos', 'Equipamento', 'Consumíveis', 'Missão'];
    let tabX = 66;
    this.bagTabButtons = [];

    for (let i = 0; i < bagTabs.length; i++) {
      const tabName = bagTabs[i];
      const bTab = new Container();
      bTab.position.set(tabX, 58);
      bTab.eventMode = 'static';
      bTab.cursor = 'pointer';

      const bTabTxt = new Text({
        text: tabName,
        style: new TextStyle({
          fontFamily: 'SimSun, "Microsoft YaHei", sans-serif',
          fontSize: 9.5,
          fontWeight: 'bold',
          fill: i === 0 ? '#ffd700' : '#dcdde1',
          stroke: { color: '#1a1006', width: 2 }
        })
      });
      bTab.addChild(bTabTxt);

      bTab.on('pointertap', () => {
        this.activeBagTab = tabName;
        for (const t of this.bagTabButtons) {
          const isAct = t.name === tabName;
          t.txt.style.fill = isAct ? '#ffd700' : '#dcdde1';
        }
        this.renderBackpackSlots();
      });

      this.bagTabButtons.push({ name: tabName, cont: bTab, txt: bTabTxt });
      this.bagModal.addChild(bTab);
      tabX += 78;
    }

    // Container dos Slots
    this.bagSlotsCont = new Container();
    this.bagModal.addChild(this.bagSlotsCont);

    // Painel Inferior da Mochila (Ryo, Cupons, Capacidade e Botão Organizar)
    const botY = 308;

    // Ryo
    this.bagRyoText = new Text({
      text: `Ryo: ${this.profile.silver.toLocaleString()}`,
      style: new TextStyle({
        fontFamily: 'SimSun, "Microsoft YaHei", sans-serif',
        fontSize: 10,
        fontWeight: 'bold',
        fill: '#ffd700',
        stroke: { color: '#1a1006', width: 2 }
      })
    });
    this.bagRyoText.position.set(68, botY);
    this.bagModal.addChild(this.bagRyoText);

    // Cupons
    this.bagCouponText = new Text({
      text: 'Cupons: 100',
      style: new TextStyle({
        fontFamily: 'SimSun, "Microsoft YaHei", sans-serif',
        fontSize: 10,
        fontWeight: 'bold',
        fill: '#ffd700',
        stroke: { color: '#1a1006', width: 2 }
      })
    });
    this.bagCouponText.position.set(168, botY);
    this.bagModal.addChild(this.bagCouponText);

    // Capacidade
    this.bagCapacityText = new Text({
      text: 'Capacidade: 0/24',
      style: new TextStyle({
        fontFamily: 'SimSun, "Microsoft YaHei", sans-serif',
        fontSize: 9.5,
        fontWeight: 'bold',
        fill: '#dcdde1',
        stroke: { color: '#1a1006', width: 2 }
      })
    });
    this.bagCapacityText.position.set(68, botY + 22);
    this.bagModal.addChild(this.bagCapacityText);

    // Botão Organizar (CS_Backpack_MergeBagItem_Req)
    const sortBtn = new Container();
    sortBtn.position.set(300, botY + 4);
    sortBtn.eventMode = 'static';
    sortBtn.cursor = 'pointer';

    try {
      const actBtnTex = await Assets.load('/assets/ui/btn_ninja_action.png');
      const sortSp = new Sprite(actBtnTex);
      sortSp.width = 80;
      sortSp.height = 30;
      sortBtn.addChild(sortSp);
    } catch {}

    const sortTxt = new Text({
      text: 'Organizar',
      style: new TextStyle({
        fontFamily: 'SimSun, "Microsoft YaHei", sans-serif',
        fontSize: 10,
        fontWeight: 'bold',
        fill: '#ffffff',
        stroke: { color: '#1a1006', width: 2 }
      })
    });
    sortTxt.anchor.set(0.5, 0.5);
    sortTxt.position.set(40, 15);
    sortBtn.addChild(sortTxt);

    sortBtn.on('pointertap', () => {
      if (this.callbacks.onBackpackMerge) {
        this.callbacks.onBackpackMerge();
      }
    });

    this.bagModal.addChild(sortBtn);
    this.modalLayer.addChild(this.bagModal);

    await this.renderBackpackSlots();
  }

  private async renderBackpackSlots(): Promise<void> {
    if (!this.bagSlotsCont) return;
    this.bagSlotsCont.removeChildren();

    const startX = 62;
    const startY = 88;
    const slotW = 50;
    const slotH = 50;
    const gapX = 6;
    const gapY = 5;
    const cols = 6;

    const slotTex = await Assets.load('/assets/ui/slot_frame.png').catch(() => null);

    // Filtrar itens pela aba ativa
    let filteredItems = this.bagItems;
    if (this.activeBagTab === 'Equipamento') {
      filteredItems = this.bagItems.filter(it => ITEM_CATALOG[it.templateId]?.type === 'equip');
    } else if (this.activeBagTab === 'Consumíveis') {
      filteredItems = this.bagItems.filter(it => ITEM_CATALOG[it.templateId]?.type === 'consumable');
    } else if (this.activeBagTab === 'Missão') {
      filteredItems = this.bagItems.filter(it => ITEM_CATALOG[it.templateId]?.type === 'quest');
    }

    for (let i = 0; i < 24; i++) {
      const c = i % cols;
      const r = Math.floor(i / cols);
      const sx = startX + c * (slotW + gapX);
      const sy = startY + r * (slotH + gapY);

      const slotCont = new Container();
      slotCont.position.set(sx, sy);

      if (slotTex) {
        const slotSp = new Sprite(slotTex);
        slotSp.width = slotW;
        slotSp.height = slotH;
        slotCont.addChild(slotSp);
      }

      const item = filteredItems[i];
      if (item) {
        const meta = ITEM_CATALOG[item.templateId] || {
          name: `Item #${item.templateId}`,
          icon: '/assets/items/item_kunai.png',
          desc: 'Item misterioso dos arquivos ninjas.',
          type: 'material',
          canUse: false
        };

        try {
          const itemTex = await Assets.load(meta.icon);
          const itemSp = new Sprite(itemTex);
          itemSp.anchor.set(0.5, 0.5);
          itemSp.position.set(slotW / 2, slotH / 2);
          itemSp.width = 38;
          itemSp.height = 38;
          slotCont.addChild(itemSp);

          if (item.quantity > 1) {
            const qtyTxt = new Text({
              text: `${item.quantity}`,
              style: new TextStyle({
                fontSize: 9,
                fontWeight: 'bold',
                fill: '#ffffff',
                stroke: { color: '#000000', width: 2 }
              })
            });
            qtyTxt.position.set(slotW - 14, slotH - 12);
            slotCont.addChild(qtyTxt);
          }
        } catch {}

        slotCont.eventMode = 'static';
        slotCont.cursor = 'pointer';
        slotCont.on('pointertap', () => {
          this.showItemDetail(item, meta);
        });
      }

      this.bagSlotsCont.addChild(slotCont);
    }

    if (this.bagCapacityText) {
      this.bagCapacityText.text = `Capacidade: ${this.bagItems.length}/24`;
    }
  }

  private async showItemDetail(item: InventoryItemDto, meta: ItemMeta): Promise<void> {
    if (!this.bagModal) return;
    if (this.itemDetailPopup) {
      this.itemDetailPopup.destroy({ children: true });
      this.itemDetailPopup = null;
    }

    const pop = new Container();
    const pw = 300;
    const ph = 220;
    pop.position.set(Math.floor((459 - pw) / 2), 85);

    // Moldura canônica (modal_generic_frame.png)
    try {
      const fTex = await Assets.load('/assets/ui/modal_generic_frame.png');
      const fSp = new Sprite(fTex);
      fSp.width = pw;
      fSp.height = ph;
      pop.addChild(fSp);
    } catch {}

    // Título no plaque
    const title = new Text({
      text: meta.name,
      style: new TextStyle({
        fontFamily: 'SimSun, "Microsoft YaHei", sans-serif',
        fontSize: 11,
        fontWeight: 'bold',
        fill: '#ffd700',
        stroke: { color: '#2a1604', width: 2 }
      })
    });
    title.anchor.set(0.5, 0.5);
    title.position.set(pw / 2, 16);
    pop.addChild(title);

    // Botão Fechar
    const closeBtn = await this.createCloseButton(() => {
      if (this.itemDetailPopup) {
        this.itemDetailPopup.destroy({ children: true });
        this.itemDetailPopup = null;
      }
    });
    closeBtn.position.set(pw - 24, 18);
    pop.addChild(closeBtn);

    // Ícone e moldura
    const iconCont = new Container();
    iconCont.position.set(30, 48);
    try {
      const slTex = await Assets.load('/assets/ui/slot_frame.png');
      const slSp = new Sprite(slTex);
      slSp.width = 46;
      slSp.height = 46;
      iconCont.addChild(slSp);

      const iTex = await Assets.load(meta.icon);
      const iSp = new Sprite(iTex);
      iSp.anchor.set(0.5, 0.5);
      iSp.position.set(23, 23);
      iSp.width = 36;
      iSp.height = 36;
      iconCont.addChild(iSp);
    } catch {}
    pop.addChild(iconCont);

    // Informações ao lado do ícone
    const typeLabel = meta.type === 'consumable' ? 'Consumível' : meta.type === 'equip' ? 'Equipamento' : 'Missão';
    const infoTxt = new Text({
      text: `Quantidade: ${item.quantity}\nTipo: ${typeLabel}`,
      style: new TextStyle({
        fontFamily: 'SimSun, "Microsoft YaHei", sans-serif',
        fontSize: 9.5,
        fontWeight: 'bold',
        fill: '#ffffff',
        lineHeight: 14,
        stroke: { color: '#1a1006', width: 2 }
      })
    });
    infoTxt.position.set(88, 54);
    pop.addChild(infoTxt);

    // Descrição
    const descTxt = new Text({
      text: meta.desc,
      style: new TextStyle({
        fontFamily: 'SimSun, "Microsoft YaHei", sans-serif',
        fontSize: 9.5,
        fill: '#f0e6d2',
        wordWrap: true,
        wordWrapWidth: pw - 50,
        stroke: { color: '#000000', width: 1.5 }
      })
    });
    descTxt.position.set(26, 106);
    pop.addChild(descTxt);

    // Botão de Ação ("Usar" para consumíveis)
    if (meta.canUse) {
      const useBtn = new Container();
      useBtn.position.set(pw / 2 - 40, 168);
      useBtn.eventMode = 'static';
      useBtn.cursor = 'pointer';

      try {
        const uTex = await Assets.load('/assets/ui/btn_ninja_action.png');
        const uSp = new Sprite(uTex);
        uSp.width = 80;
        uSp.height = 28;
        useBtn.addChild(uSp);
      } catch {}

      const uTxt = new Text({
        text: 'Usar',
        style: new TextStyle({
          fontFamily: 'SimSun, "Microsoft YaHei", sans-serif',
          fontSize: 10,
          fontWeight: 'bold',
          fill: '#ffffff',
          stroke: { color: '#1a1006', width: 2 }
        })
      });
      uTxt.anchor.set(0.5, 0.5);
      uTxt.position.set(40, 14);
      useBtn.addChild(uTxt);

      useBtn.on('pointertap', () => {
        if (this.callbacks.onBackpackUseItem) {
          this.callbacks.onBackpackUseItem(item.guidHigh, item.guidLow);
        }
        if (this.itemDetailPopup) {
          this.itemDetailPopup.destroy({ children: true });
          this.itemDetailPopup = null;
        }
      });
      pop.addChild(useBtn);
    }

    this.itemDetailPopup = pop;
    this.bagModal.addChild(pop);
  }

  public updateBackpackItems(items: InventoryItemDto[]): void {
    this.bagItems = items;
    this.renderBackpackSlots();
  }

  private async buildFormationModal(): Promise<void> {
    const origW = 1028;
    const origH = 632;
    const scale = 0.88;
    const w = Math.round(origW * scale);
    const h = Math.round(origH * scale);

    this.formationModal = new Container();
    this.formationModal.position.set(Math.floor((1250 - w) / 2), Math.floor((650 - h) / 2));
    this.formationModal.visible = false;

    // Fundo Canônico da Formação Tática (16000000/images/1.png)
    try {
      const tex = await Assets.load('/assets/ui/modal_formation.png');
      const sp = new Sprite(tex);
      sp.width = w;
      sp.height = h;
      this.formationModal.addChild(sp);
    } catch {}

    // Título no Plaque Verde Superior
    const title = new Text({
      text: 'Formação Tática Shinobi (3x3)',
      style: new TextStyle({
        fontFamily: 'SimSun, "Microsoft YaHei", sans-serif',
        fontSize: 12,
        fontWeight: 'bold',
        fill: '#ffd700',
        stroke: { color: '#1a1006', width: 2 }
      })
    });
    title.anchor.set(0.5, 0.5);
    title.position.set(386, 33);
    this.formationModal.addChild(title);

    // Botão de Fechar no Entalhe
    const closeBtn = await this.createCloseButton(() => this.toggleFormation());
    closeBtn.position.set(825, 53);
    this.formationModal.addChild(closeBtn);

    // Subcontainers dinâmicos
    this.formationTokensCont = new Container();
    this.benchSlotsCont = new Container();
    this.formationModal.addChild(this.formationTokensCont);
    this.formationModal.addChild(this.benchSlotsCont);

    // Painel Direito: Poder de Luta Total
    this.formationStatusText = new Text({
      text: 'Poder de Formação:\n2.920',
      style: new TextStyle({
        fontFamily: 'SimSun, "Microsoft YaHei", sans-serif',
        fontSize: 11,
        fontWeight: 'bold',
        align: 'center',
        fill: '#ffd700',
        stroke: { color: '#2a1604', width: 2.5 }
      })
    });
    this.formationStatusText.anchor.set(0.5, 0);
    this.formationStatusText.position.set(w - 148, 100);
    this.formationModal.addChild(this.formationStatusText);

    // Render inicial
    await this.renderFormation();

    this.modalLayer.addChild(this.formationModal);
  }

  private async renderFormation(): Promise<void> {
    this.formationTokensCont.removeChildren();
    this.benchSlotsCont.removeChildren();

    // 1. Áreas interativas dos 9 Tatamis
    for (let pos = 1; pos <= 9; pos++) {
      const coord = this.tatamiPositions[pos];
      if (!coord) continue;

      const tatamiArea = new Container();
      tatamiArea.position.set(coord.x, coord.y);
      tatamiArea.eventMode = 'static';
      tatamiArea.cursor = 'pointer';

      // Hit area sutil sobre o tatami
      const hitG = new Graphics()
        .ellipse(0, 0, 48, 28)
        .fill({ color: 0x000000, alpha: 0.001 });
      tatamiArea.addChild(hitG);

      const occupied = this.formationNinjas.find(n => n.pos === pos);
      if (this.selectedFormationNinja && !occupied) {
        const ring = new Graphics()
          .ellipse(0, 0, 44, 25)
          .stroke({ color: 0x2ed573, width: 2, alpha: 0.85 });
        tatamiArea.addChild(ring);
      }

      tatamiArea.on('pointertap', () => {
        if (!this.selectedFormationNinja) return;

        const sel = this.selectedFormationNinja;
        if (sel.fromBench) {
          const benchIdx = this.benchNinjas.findIndex(b => b.heroId === sel.heroId);
          if (benchIdx >= 0) {
            const movingBench = this.benchNinjas[benchIdx];
            if (occupied) {
              this.benchNinjas[benchIdx] = {
                heroId: occupied.heroId,
                name: occupied.name,
                portrait: occupied.portrait
              };
              occupied.heroId = movingBench.heroId;
              occupied.name = movingBench.name;
              occupied.portrait = movingBench.portrait;
            } else {
              this.benchNinjas.splice(benchIdx, 1);
              this.formationNinjas.push({
                heroId: movingBench.heroId,
                name: movingBench.name,
                portrait: movingBench.portrait,
                pos: pos
              });
            }
          }
        } else {
          const movingTatami = this.formationNinjas.find(n => n.heroId === sel.heroId);
          if (movingTatami) {
            if (occupied && occupied !== movingTatami) {
              const oldPos = movingTatami.pos;
              movingTatami.pos = pos;
              occupied.pos = oldPos;
            } else {
              movingTatami.pos = pos;
            }
          }
        }

        const movedHeroId = sel.heroId;
        this.selectedFormationNinja = null;
        this.renderFormation();

        if (this.callbacks.onFormationChange) {
          this.callbacks.onFormationChange(movedHeroId, pos);
        }
      });

      this.formationTokensCont.addChild(tatamiArea);
    }

    // 2. Ninjas posicionados nos tatamis
    for (const ninja of this.formationNinjas) {
      const coord = this.tatamiPositions[ninja.pos];
      if (!coord) continue;

      const tokenCont = new Container();
      tokenCont.position.set(coord.x, coord.y);
      tokenCont.eventMode = 'static';
      tokenCont.cursor = 'pointer';

      const isSelected = this.selectedFormationNinja?.heroId === ninja.heroId;

      if (isSelected) {
        const ring = new Graphics()
          .circle(0, 0, 26)
          .stroke({ color: 0xffd700, width: 3 });
        tokenCont.addChild(ring);
      }

      try {
        const pTex = await Assets.load(ninja.portrait);
        const pSp = new Sprite(pTex);
        pSp.anchor.set(0.5, 0.5);
        pSp.width = 44;
        pSp.height = 44;
        tokenCont.addChild(pSp);
      } catch {}

      const nameTxt = new Text({
        text: ninja.name,
        style: new TextStyle({
          fontFamily: 'SimSun, "Microsoft YaHei", sans-serif',
          fontSize: 9,
          fontWeight: 'bold',
          fill: isSelected ? '#ffd700' : '#ffffff',
          stroke: { color: '#1a1006', width: 2 }
        })
      });
      nameTxt.anchor.set(0.5, 0);
      nameTxt.position.set(0, 24);
      tokenCont.addChild(nameTxt);

      tokenCont.on('pointertap', (e) => {
        e.stopPropagation();
        if (this.selectedFormationNinja && this.selectedFormationNinja.heroId !== ninja.heroId) {
          const sel = this.selectedFormationNinja;
          if (sel.fromBench) {
            const benchIdx = this.benchNinjas.findIndex(b => b.heroId === sel.heroId);
            if (benchIdx >= 0) {
              const bNinja = this.benchNinjas[benchIdx];
              this.benchNinjas[benchIdx] = {
                heroId: ninja.heroId,
                name: ninja.name,
                portrait: ninja.portrait
              };
              ninja.heroId = bNinja.heroId;
              ninja.name = bNinja.name;
              ninja.portrait = bNinja.portrait;
            }
          } else {
            const other = this.formationNinjas.find(n => n.heroId === sel.heroId);
            if (other) {
              const tempPos = other.pos;
              other.pos = ninja.pos;
              ninja.pos = tempPos;
            }
          }
          const movedHeroId = sel.heroId;
          const targetPos = ninja.pos;
          this.selectedFormationNinja = null;
          this.renderFormation();
          if (this.callbacks.onFormationChange) {
            this.callbacks.onFormationChange(movedHeroId, targetPos);
          }
        } else {
          if (this.selectedFormationNinja?.heroId === ninja.heroId) {
            this.selectedFormationNinja = null;
          } else {
            this.selectedFormationNinja = { heroId: ninja.heroId, name: ninja.name, fromBench: false };
          }
          this.renderFormation();
        }
      });

      this.formationTokensCont.addChild(tokenCont);
    }

    // 3. Ninjas no banco (bottom shelf)
    let benchX = 138;
    for (let i = 0; i < 6; i++) {
      const bSlot = new Container();
      bSlot.position.set(benchX, 442);
      bSlot.eventMode = 'static';
      bSlot.cursor = 'pointer';

      const ninja = this.benchNinjas[i];
      if (ninja) {
        const isSelected = this.selectedFormationNinja?.heroId === ninja.heroId;
        if (isSelected) {
          const selBox = new Graphics()
            .rect(-2, -2, 44, 44)
            .stroke({ color: 0xffd700, width: 2.5 });
          bSlot.addChild(selBox);
        }

        try {
          const bTex = await Assets.load(ninja.portrait);
          const bSp = new Sprite(bTex);
          bSp.width = 40;
          bSp.height = 40;
          bSlot.addChild(bSp);
        } catch {}

        const bName = new Text({
          text: ninja.name,
          style: new TextStyle({
            fontFamily: 'SimSun, "Microsoft YaHei", sans-serif',
            fontSize: 8,
            fill: isSelected ? '#ffd700' : '#e0d2b4',
            stroke: { color: '#1a1006', width: 2 }
          })
        });
        bName.anchor.set(0.5, 0);
        bName.position.set(20, 42);
        bSlot.addChild(bName);

        bSlot.on('pointertap', (e) => {
          e.stopPropagation();
          if (this.selectedFormationNinja?.heroId === ninja.heroId) {
            this.selectedFormationNinja = null;
          } else {
            this.selectedFormationNinja = { heroId: ninja.heroId, name: ninja.name, fromBench: true };
          }
          this.renderFormation();
        });
      } else {
        bSlot.on('pointertap', () => {
          if (this.selectedFormationNinja && !this.selectedFormationNinja.fromBench) {
            const formIdx = this.formationNinjas.findIndex(n => n.heroId === this.selectedFormationNinja!.heroId);
            if (formIdx >= 0 && this.formationNinjas.length > 1) {
              const removed = this.formationNinjas.splice(formIdx, 1)[0];
              this.benchNinjas.push({
                heroId: removed.heroId,
                name: removed.name,
                portrait: removed.portrait
              });
              const movedHeroId = removed.heroId;
              this.selectedFormationNinja = null;
              this.renderFormation();
              if (this.callbacks.onFormationChange) {
                this.callbacks.onFormationChange(movedHeroId, 0);
              }
            }
          }
        });
      }

      this.benchSlotsCont.addChild(bSlot);
      benchX += 73;
    }

    // 4. Poder de combate total da formação
    const totalPower = this.formationNinjas.length * 730;
    if (this.formationStatusText) {
      this.formationStatusText.text = `Poder de Formação:\n${totalPower.toLocaleString()}`;
    }
  }


  private async buildHeroModal(): Promise<void> {
    const w = 688;
    const h = 408;
    this.heroModal = new Container();
    this.heroModal.position.set(Math.floor((1250 - w) / 2), Math.floor((650 - h) / 2));
    this.heroModal.visible = false;

    // Fundo Canônico dos Ninjas (21000000/images/2.png)
    try {
      const tex = await Assets.load('/assets/ui/modal_hero.png');
      const sp = new Sprite(tex);
      sp.width = w;
      sp.height = h;
      this.heroModal.addChild(sp);
    } catch {}

    // Título no Plaque Superior
    const title = new Text({
      text: 'Ninjas Recrutados',
      style: new TextStyle({
        fontFamily: 'SimSun, "Microsoft YaHei", sans-serif',
        fontSize: 12,
        fontWeight: 'bold',
        fill: '#ffd700',
        stroke: { color: '#1a1006', width: 2 }
      })
    });
    title.anchor.set(0.5, 0.5);
    title.position.set(w / 2, 16);
    this.heroModal.addChild(title);

    // Botão de Fechar
    const closeBtn = await this.createCloseButton(() => this.toggleHero());
    closeBtn.position.set(654, 14);
    this.heroModal.addChild(closeBtn);

    // Painel Esquerdo: Lista de Ninjas
    const roster = [
      { name: 'Dasi [Lâmina]', portrait: '/assets/ui/portrait_329.png', level: 1, element: 'Relâmpago' },
      { name: 'Naruto Uzumaki', portrait: '/assets/ui/portrait_325.png', level: 1, element: 'Vento' },
      { name: 'Sasuke Uchiha', portrait: '/assets/ui/portrait_327.png', level: 1, element: 'Fogo' },
      { name: 'Sakura Haruno', portrait: '/assets/ui/portrait_331.png', level: 1, element: 'Terra' }
    ];

    let rosterY = 56;
    for (const r of roster) {
      const row = new Container();
      row.position.set(48, rosterY);
      row.eventMode = 'static';
      row.cursor = 'pointer';

      try {
        const pTex = await Assets.load(r.portrait);
        const pSp = new Sprite(pTex);
        pSp.width = 38;
        pSp.height = 38;
        row.addChild(pSp);
      } catch {}

      const nameTxt = new Text({
        text: `${r.name}\nNv. ${r.level} [${r.element}]`,
        style: new TextStyle({
          fontFamily: 'SimSun, "Microsoft YaHei", sans-serif',
          fontSize: 9.5,
          fontWeight: 'bold',
          fill: '#f0e6d2',
          lineHeight: 13,
          stroke: { color: '#1a1006', width: 2 }
        })
      });
      nameTxt.position.set(46, 4);
      row.addChild(nameTxt);

      this.heroModal.addChild(row);
      rosterY += 48;
    }

    // Painel Direito: Destaque do Ninja Selecionado e Equipamentos
    const detailCont = new Container();
    detailCont.position.set(255, 54);

    const ninjaName = new Text({
      text: 'Dasi — Lâmina das Trevas [Líder]',
      style: new TextStyle({
        fontFamily: 'SimSun, "Microsoft YaHei", sans-serif',
        fontSize: 13,
        fontWeight: 'bold',
        fill: '#ffd700',
        stroke: { color: '#2a1604', width: 2 }
      })
    });
    detailCont.addChild(ninjaName);

    this.heroCombatPowerLabel = new Text({
      text: `Poder de Luta: ${this.heroCombatPower}`,
      style: new TextStyle({
        fontFamily: 'SimSun, "Microsoft YaHei", sans-serif',
        fontSize: 10.5,
        fontWeight: 'bold',
        fill: '#ffd700',
        stroke: { color: '#000000', width: 2 }
      })
    });
    this.heroCombatPowerLabel.position.set(0, 28);
    detailCont.addChild(this.heroCombatPowerLabel);

    const stats = [
      'Vida (HP): 1.370',
      'Ataque Físico: 340',
      'Defesa Física: 250',
      'Ninjutsu: 370',
      'Resistência: 245'
    ];

    let statY = 48;
    for (const st of stats) {
      const stTxt = new Text({
        text: st,
        style: new TextStyle({
          fontFamily: 'SimSun, "Microsoft YaHei", sans-serif',
          fontSize: 10,
          fontWeight: 'bold',
          fill: '#e0d8c3',
          stroke: { color: '#000000', width: 1.5 }
        })
      });
      stTxt.position.set(0, statY);
      detailCont.addChild(stTxt);
      statY += 18;
    }

    // Botão de Evolução / Avanço Shinobi Canônico
    const upgradeBtn = new Container();
    upgradeBtn.position.set(0, 150);
    upgradeBtn.eventMode = 'static';
    upgradeBtn.cursor = 'pointer';

    try {
      const uTex = await Assets.load('/assets/ui/btn_ninja_action.png');
      const uSp = new Sprite(uTex);
      uSp.width = 135;
      uSp.height = 32;
      upgradeBtn.addChild(uSp);
    } catch {}

    const uLabel = new Text({
      text: 'Avanço Shinobi (+60)',
      style: new TextStyle({
        fontFamily: 'SimSun, "Microsoft YaHei", sans-serif',
        fontSize: 9.5,
        fontWeight: 'bold',
        fill: '#ffffff',
        stroke: { color: '#1a1006', width: 2 }
      })
    });
    uLabel.anchor.set(0.5, 0.5);
    uLabel.position.set(67, 16);
    upgradeBtn.addChild(uLabel);

    upgradeBtn.on('pointertap', () => {
      if (this.callbacks.onHeroUpgrade) {
        this.callbacks.onHeroUpgrade();
      }
    });
    detailCont.addChild(upgradeBtn);

    // 6 Slots de Equipamento Canônicos
    const equipSlots = [
      { name: 'Espada', icon: '/assets/items/item_kunai.png' },
      { name: 'Faixa', icon: '/assets/items/item_headband.png' },
      { name: 'Colete', icon: '/assets/items/item_vest.png' },
      { name: 'Amuleto', icon: '/assets/items/item_ring.png' },
      { name: 'Pergaminho', icon: '/assets/items/item_chakra_scroll.png' },
      { name: 'Sandálias', icon: '/assets/items/item_sandals.png' }
    ];

    const slotTex = await Assets.load('/assets/ui/slot_frame.png').catch(() => null);

    let eqX = 220;
    let eqY = 28;
    for (let i = 0; i < equipSlots.length; i++) {
      const eq = equipSlots[i];
      const eqCont = new Container();
      eqCont.position.set(eqX, eqY);

      if (slotTex) {
        const slSp = new Sprite(slotTex);
        slSp.width = 46;
        slSp.height = 46;
        eqCont.addChild(slSp);
      }

      try {
        const itemTex = await Assets.load(eq.icon);
        const itemSp = new Sprite(itemTex);
        itemSp.anchor.set(0.5, 0.5);
        itemSp.position.set(23, 23);
        itemSp.width = 34;
        itemSp.height = 34;
        eqCont.addChild(itemSp);
      } catch {}

      const eqLabel = new Text({
        text: eq.name,
        style: new TextStyle({
          fontFamily: 'SimSun, "Microsoft YaHei", sans-serif',
          fontSize: 8.5,
          fontWeight: 'bold',
          fill: '#ffd700',
          stroke: { color: '#000000', width: 2 }
        })
      });
      eqLabel.anchor.set(0.5, 0);
      eqLabel.position.set(23, 47);
      eqCont.addChild(eqLabel);

      detailCont.addChild(eqCont);
      eqY += 66;
      if (i === 2) {
        eqX += 70;
        eqY = 28;
      }
    }

    this.heroModal.addChild(detailCont);
    this.modalLayer.addChild(this.heroModal);
  }

  private async createCloseButton(onClose: () => void): Promise<Container> {
    const btn = new Container();
    btn.eventMode = 'static';
    btn.cursor = 'pointer';

    try {
      const normTex = await Assets.load('/assets/ui/btn_close.png');
      const hoverTex = await Assets.load('/assets/ui/btn_close_hover.png');
      const sp = new Sprite(normTex);
      sp.anchor.set(0.5, 0.5);
      btn.addChild(sp);

      btn.on('pointerenter', () => { sp.texture = hoverTex; });
      btn.on('pointerleave', () => { sp.texture = normTex; });
    } catch {
      const fb = new Graphics()
        .circle(0, 0, 14)
        .fill(0xc0392b);
      btn.addChild(fb);

      const xTxt = new Text({ text: '✕', style: new TextStyle({ fontSize: 12, fill: '#ffffff', fontWeight: 'bold' }) });
      xTxt.anchor.set(0.5, 0.5);
      btn.addChild(xTxt);
    }

    btn.on('pointertap', () => onClose());
    return btn;
  }

  /* =========================================================================
   * MÉTODOS PÚBLICOS DE ATUALIZAÇÃO E CONTROLE
   * ========================================================================= */
  public updateCoordinates(x: number, y: number): void {
    if (this.coordsText) {
      this.coordsText.text = `X: ${Math.round(x)}  Y: ${Math.round(y)}`;
    }
  }

  public updateCityName(name: string): void {
    if (this.cityNameText) {
      this.cityNameText.text = name;
    }
  }

  public updateHp(cur: number, max: number): void {
    if (this.hpText) {
      this.hpText.text = `Vigor ${cur}/${max}`;
    }
    if (this.hpFill) {
      const pct = Math.max(0, Math.min(1, cur / max));
      this.hpFill.clear();
      this.hpFill.roundRect(88, 57, Math.max(2, 148 * pct), 8, 2).fill(0xd63031);
    }
  }

  public updateCurrencies(silver: number, gold: number): void {
    if (this.silverText) {
      this.silverText.text = `${silver.toLocaleString()}`;
    }
    if (this.goldText) {
      this.goldText.text = gold.toLocaleString();
    }
  }

  public updateBgmState(isPlaying: boolean): void {
    if (this.bgmLabelText) {
      this.bgmLabelText.text = isPlaying ? '🔊' : '🔇';
    }
  }

  public updateQuestTracker(title: string, targetDesc: string, targetNpc: string): void {
    if (this.questTitleText) this.questTitleText.text = title;
    if (this.questTargetText) this.questTargetText.text = targetDesc;
    this.currentQuestTargetNpc = targetNpc;
  }

  public toggleBackpack(): void {
    if (!this.bagModal) return;
    const nextState = !this.bagModal.visible;
    this.closeAllModals();
    this.bagModal.visible = nextState;
    if (nextState && this.callbacks.onBackpackOpen) {
      this.callbacks.onBackpackOpen();
    }
  }

  public toggleFormation(): void {
    if (!this.formationModal) return;
    const nextState = !this.formationModal.visible;
    this.closeAllModals();
    this.formationModal.visible = nextState;
  }

  public toggleHero(): void {
    if (!this.heroModal) return;
    const nextState = !this.heroModal.visible;
    this.closeAllModals();
    this.heroModal.visible = nextState;
  }

  private async buildMailModal(): Promise<void> {
    const w = 720;
    const h = 460;
    this.mailModal = new Container();
    this.mailModal.position.set(Math.floor((1250 - w) / 2), Math.floor((650 - h) / 2));
    this.mailModal.visible = false;

    // Moldura canônica (modal_generic_frame.png)
    try {
      const tex = await Assets.load('/assets/ui/modal_generic_frame.png');
      const sp = new Sprite(tex);
      sp.width = w;
      sp.height = h;
      this.mailModal.addChild(sp);
    } catch {}

    // Título no Plaque Superior
    const title = new Text({
      text: 'Correio Shinobi',
      style: new TextStyle({
        fontFamily: 'SimSun, "Microsoft YaHei", sans-serif',
        fontSize: 12,
        fontWeight: 'bold',
        fill: '#ffd700',
        stroke: { color: '#1a1006', width: 2 }
      })
    });
    title.anchor.set(0.5, 0.5);
    title.position.set(w / 2, 16);
    this.mailModal.addChild(title);

    // Botão de Fechar
    const closeBtn = await this.createCloseButton(() => this.toggleMail());
    closeBtn.position.set(w - 32, 16);
    this.mailModal.addChild(closeBtn);

    // Abas de Correio
    const tabs = ['Entrada', 'Sistema'];
    let tabX = 46;
    this.mailTabButtons = [];
    for (const tabName of tabs) {
      const tCont = new Container();
      tCont.position.set(tabX, 42);
      tCont.eventMode = 'static';
      tCont.cursor = 'pointer';

      const tTxt = new Text({
        text: tabName,
        style: new TextStyle({
          fontFamily: 'SimSun, "Microsoft YaHei", sans-serif',
          fontSize: 10,
          fontWeight: 'bold',
          fill: tabName === this.activeMailTab ? '#ffd700' : '#dcdde1',
          stroke: { color: '#1a1006', width: 2 }
        })
      });
      tCont.addChild(tTxt);
      tCont.on('pointertap', () => {
        this.activeMailTab = tabName;
        for (const tb of this.mailTabButtons) {
          tb.txt.style.fill = tb.name === tabName ? '#ffd700' : '#dcdde1';
        }
        this.renderMailList();
      });

      this.mailTabButtons.push({ name: tabName, cont: tCont, txt: tTxt });
      this.mailModal.addChild(tCont);
      tabX += 80;
    }

    // Painel Esquerdo: Lista de Mails
    this.mailListCont = new Container();
    this.mailListCont.position.set(40, 72);
    this.mailModal.addChild(this.mailListCont);

    // Painel Direito: Detalhe do Mail
    this.mailDetailCont = new Container();
    this.mailDetailCont.position.set(275, 52);
    this.mailModal.addChild(this.mailDetailCont);

    this.renderMailList();
    this.renderMailDetail();

    this.modalLayer.addChild(this.mailModal);
  }

  private async renderMailList(): Promise<void> {
    this.mailListCont.removeChildren();

    if (this.mailList.length === 0) {
      const emptyTxt = new Text({
        text: 'Nenhuma mensagem recebida.',
        style: new TextStyle({
          fontFamily: 'SimSun, "Microsoft YaHei", sans-serif',
          fontSize: 10,
          fill: '#a4b0be'
        })
      });
      emptyTxt.position.set(10, 20);
      this.mailListCont.addChild(emptyTxt);
      return;
    }

    let yOffset = 0;
    for (const mail of this.mailList) {
      const row = new Container();
      row.position.set(0, yOffset);
      row.eventMode = 'static';
      row.cursor = 'pointer';

      const isSel = this.selectedMail?.id === mail.id;

      // Fundo do item de correio
      const bg = new Graphics()
        .roundRect(0, 0, 220, 52, 4)
        .fill({ color: isSel ? 0x3d3121 : 0x1e272e, alpha: 0.85 })
        .stroke({ color: isSel ? 0xf39c12 : 0x57606f, width: 1.5 });
      row.addChild(bg);

      // Ícone de envelope
      try {
        const envTex = await Assets.load('/assets/ui/mail/181.png');
        const envSp = new Sprite(envTex);
        envSp.position.set(8, 8);
        envSp.width = 36;
        envSp.height = 36;
        row.addChild(envSp);
      } catch {}

      // Título da Mensagem
      const titleTxt = new Text({
        text: mail.title,
        style: new TextStyle({
          fontFamily: 'SimSun, "Microsoft YaHei", sans-serif',
          fontSize: 10,
          fontWeight: 'bold',
          fill: isSel ? '#ffd700' : '#ffffff',
          stroke: { color: '#000000', width: 2 }
        })
      });
      titleTxt.position.set(50, 8);
      row.addChild(titleTxt);

      // Remetente & Anexo
      const senderTxt = new Text({
        text: `${mail.sender}${mail.hasGift ? ' 🎁 [Anexo]' : ''}`,
        style: new TextStyle({
          fontFamily: 'SimSun, "Microsoft YaHei", sans-serif',
          fontSize: 8.5,
          fill: mail.hasGift ? '#2ecc71' : '#bdc3c7'
        })
      });
      senderTxt.position.set(50, 28);
      row.addChild(senderTxt);

      row.on('pointertap', () => {
        this.selectedMail = mail;
        mail.isRead = 1;
        this.renderMailList();
        this.renderMailDetail();
      });

      this.mailListCont.addChild(row);
      yOffset += 58;
    }
  }

  private async renderMailDetail(): Promise<void> {
    this.mailDetailCont.removeChildren();

    const dw = 405;
    const dh = 380;

    // Fundo canônico de pergaminho / carta
    try {
      const pTex = await Assets.load('/assets/ui/mail/5.jpg');
      const pSp = new Sprite(pTex);
      pSp.width = dw;
      pSp.height = dh;
      this.mailDetailCont.addChild(pSp);
    } catch {
      const fb = new Graphics()
        .roundRect(0, 0, dw, dh, 6)
        .fill({ color: 0x222f3e, alpha: 0.9 })
        .stroke({ color: 0xc8d6e5, width: 1.5 });
      this.mailDetailCont.addChild(fb);
    }

    if (!this.selectedMail) {
      const noMailTxt = new Text({
        text: 'Selecione uma mensagem para visualizar o conteúdo.',
        style: new TextStyle({
          fontFamily: 'SimSun, "Microsoft YaHei", sans-serif',
          fontSize: 11,
          fill: '#57606f',
          align: 'center'
        })
      });
      noMailTxt.anchor.set(0.5, 0.5);
      noMailTxt.position.set(dw / 2, dh / 2);
      this.mailDetailCont.addChild(noMailTxt);
      return;
    }

    const mail = this.selectedMail;

    // Título
    const titleTxt = new Text({
      text: mail.title,
      style: new TextStyle({
        fontFamily: 'SimSun, "Microsoft YaHei", sans-serif',
        fontSize: 13,
        fontWeight: 'bold',
        fill: '#3d2714',
        stroke: { color: '#ffffff', width: 2 }
      })
    });
    titleTxt.position.set(24, 24);
    this.mailDetailCont.addChild(titleTxt);

    // Remetente
    const senderTxt = new Text({
      text: `De: ${mail.sender}`,
      style: new TextStyle({
        fontFamily: 'SimSun, "Microsoft YaHei", sans-serif',
        fontSize: 10,
        fontWeight: 'bold',
        fill: '#574229'
      })
    });
    senderTxt.position.set(24, 48);
    this.mailDetailCont.addChild(senderTxt);

    // Divisor decorativo canônico
    try {
      const lineTex = await Assets.load('/assets/ui/mail/58.png');
      const lineSp = new Sprite(lineTex);
      lineSp.position.set(20, 68);
      lineSp.width = dw - 40;
      lineSp.height = 12;
      this.mailDetailCont.addChild(lineSp);
    } catch {}

    // Corpo da Mensagem
    const bodyTxt = new Text({
      text: mail.content,
      style: new TextStyle({
        fontFamily: 'SimSun, "Microsoft YaHei", sans-serif',
        fontSize: 10.5,
        fill: '#2f1f10',
        wordWrap: true,
        wordWrapWidth: dw - 48,
        lineHeight: 18
      })
    });
    bodyTxt.position.set(24, 90);
    this.mailDetailCont.addChild(bodyTxt);

    // Anexos (se houver prata/ouro ou gift)
    if (mail.hasGift && (mail.silver > 0 || mail.gold > 0)) {
      const attachBox = new Container();
      attachBox.position.set(24, 270);

      const attachLabel = new Text({
        text: 'Anexos da Mensagem:',
        style: new TextStyle({
          fontFamily: 'SimSun, "Microsoft YaHei", sans-serif',
          fontSize: 10,
          fontWeight: 'bold',
          fill: '#4a3720'
        })
      });
      attachBox.addChild(attachLabel);

      let aX = 0;
      if (mail.silver > 0) {
        const silvTxt = new Text({
          text: `🪙 Ryo: +${mail.silver.toLocaleString()}`,
          style: new TextStyle({
            fontFamily: 'SimSun, "Microsoft YaHei", sans-serif',
            fontSize: 10,
            fontWeight: 'bold',
            fill: '#d35400'
          })
        });
        silvTxt.position.set(aX, 22);
        attachBox.addChild(silvTxt);
        aX += 130;
      }

      if (mail.gold > 0) {
        const goldTxt = new Text({
          text: `💰 Ouro: +${mail.gold.toLocaleString()}`,
          style: new TextStyle({
            fontFamily: 'SimSun, "Microsoft YaHei", sans-serif',
            fontSize: 10,
            fontWeight: 'bold',
            fill: '#d4ac0d'
          })
        });
        goldTxt.position.set(aX, 22);
        attachBox.addChild(goldTxt);
      }

      // Botão "Receber"
      const claimBtn = new Container();
      claimBtn.position.set(dw - 140, 274);
      claimBtn.eventMode = 'static';
      claimBtn.cursor = 'pointer';

      try {
        const btnTex = await Assets.load('/assets/ui/btn_ninja_action.png');
        const btnSp = new Sprite(btnTex);
        btnSp.width = 100;
        claimBtn.addChild(btnSp);
      } catch {}

      const btnTxt = new Text({
        text: 'Receber',
        style: new TextStyle({
          fontFamily: 'SimSun, "Microsoft YaHei", sans-serif',
          fontSize: 10.5,
          fontWeight: 'bold',
          fill: '#ffffff',
          stroke: { color: '#1a1006', width: 2 }
        })
      });
      btnTxt.anchor.set(0.5, 0.5);
      btnTxt.position.set(50, 16);
      claimBtn.addChild(btnTxt);

      claimBtn.on('pointertap', () => {
        if (this.callbacks.onMailGetAttachment && this.selectedMail) {
          this.callbacks.onMailGetAttachment(this.selectedMail.id);
        }
      });

      this.mailDetailCont.addChild(claimBtn);
      this.mailDetailCont.addChild(attachBox);
    }
  }

  public updateMails(mails: MailDto[]): void {
    this.mailList = mails;
    if (!this.selectedMail || !this.mailList.some(m => m.id === this.selectedMail?.id)) {
      this.selectedMail = this.mailList[0] || null;
    } else {
      const updated = this.mailList.find(m => m.id === this.selectedMail?.id);
      if (updated) this.selectedMail = updated;
    }
    this.renderMailList();
    this.renderMailDetail();
  }

  public toggleMail(): void {
    if (!this.mailModal) return;
    const nextState = !this.mailModal.visible;
    this.closeAllModals();
    this.mailModal.visible = nextState;
    if (nextState && this.callbacks.onMailOpen) {
      this.callbacks.onMailOpen();
    }
  }

  private async buildTavernModal(): Promise<void> {
    const w = 780;
    const h = 480;
    this.tavernModal = new Container();
    this.tavernModal.position.set(Math.floor((1250 - w) / 2), Math.floor((650 - h) / 2));
    this.tavernModal.visible = false;

    // Moldura canônica (modal_generic_frame.png)
    try {
      const tex = await Assets.load('/assets/ui/modal_generic_frame.png');
      const sp = new Sprite(tex);
      sp.width = w;
      sp.height = h;
      this.tavernModal.addChild(sp);
    } catch {}

    // Título no Plaque Superior
    const title = new Text({
      text: 'Taverna Shinobi — Desafio de Almas Ninja',
      style: new TextStyle({
        fontFamily: 'SimSun, "Microsoft YaHei", sans-serif',
        fontSize: 12,
        fontWeight: 'bold',
        fill: '#ffd700',
        stroke: { color: '#1a1006', width: 2 }
      })
    });
    title.anchor.set(0.5, 0.5);
    title.position.set(w / 2, 16);
    this.tavernModal.addChild(title);

    // Botão Fechar
    const closeBtn = await this.createCloseButton(() => this.toggleTavern());
    closeBtn.position.set(w - 32, 16);
    this.tavernModal.addChild(closeBtn);

    // ==========================================
    // PAINEL ESQUERDO: JOKENPÔ (MORA) DA TSUNADE
    // ==========================================
    const moraCont = new Container();
    moraCont.position.set(40, 52);

    // Fundo canônico de pergaminho da taverna (1.jpg)
    try {
      const pTex = await Assets.load('/assets/ui/tavern/1.jpg');
      const pSp = new Sprite(pTex);
      pSp.width = 330;
      pSp.height = 380;
      moraCont.addChild(pSp);
    } catch {
      const fb = new Graphics()
        .roundRect(0, 0, 330, 380, 6)
        .fill({ color: 0x221a14, alpha: 0.9 })
        .stroke({ color: 0xc8d6e5, width: 1.5 });
      moraCont.addChild(fb);
    }

    // Avatar de Tsunade (Anfitriã da Taverna)
    try {
      const tsuTex = await Assets.load('/assets/ui/portrait_335.png');
      const tsuSp = new Sprite(tsuTex);
      tsuSp.position.set(20, 20);
      tsuSp.width = 54;
      tsuSp.height = 54;
      moraCont.addChild(tsuSp);
    } catch {}

    const tsuName = new Text({
      text: 'Tsunade [Lendária]',
      style: new TextStyle({
        fontFamily: 'SimSun, "Microsoft YaHei", sans-serif',
        fontSize: 11,
        fontWeight: 'bold',
        fill: '#ffd700',
        stroke: { color: '#1a1006', width: 2 }
      })
    });
    tsuName.position.set(84, 22);
    moraCont.addChild(tsuName);

    const tsuQuote = new Text({
      text: '"Quer recrutar ninjas? Vença-me no Jokenpô de Almas!"',
      style: new TextStyle({
        fontFamily: 'SimSun, "Microsoft YaHei", sans-serif',
        fontSize: 9,
        fill: '#3e2714',
        wordWrap: true,
        wordWrapWidth: 230
      })
    });
    tsuQuote.position.set(84, 40);
    moraCont.addChild(tsuQuote);

    // Divisor
    try {
      const lineTex = await Assets.load('/assets/ui/mail/58.png');
      const lineSp = new Sprite(lineTex);
      lineSp.position.set(15, 84);
      lineSp.width = 300;
      lineSp.height = 10;
      moraCont.addChild(lineSp);
    } catch {}

    // Exibição de Almas do Jogador
    this.tavernSoulsText = new Text({
      text: `Almas Azuis: ${this.tavernSouls.blue}  |  Roxas: ${this.tavernSouls.purple}  |  Douradas: ${this.tavernSouls.gold}`,
      style: new TextStyle({
        fontFamily: 'SimSun, "Microsoft YaHei", sans-serif',
        fontSize: 9.5,
        fontWeight: 'bold',
        fill: '#2c3e50',
        stroke: { color: '#ffffff', width: 1.5 }
      })
    });
    this.tavernSoulsText.position.set(20, 102);
    moraCont.addChild(this.tavernSoulsText);

    // Área do Confronto Jokenpô
    const arenaCont = new Container();
    arenaCont.position.set(20, 134);

    const arenaBg = new Graphics()
      .roundRect(0, 0, 290, 110, 6)
      .fill({ color: 0x1a120b, alpha: 0.85 })
      .stroke({ color: 0x785a3a, width: 1.5 });
    arenaCont.addChild(arenaBg);

    // Jogador vs Tsunade
    const playerLabel = new Text({
      text: 'Sua Mão:',
      style: new TextStyle({ fontSize: 9.5, fill: '#ecf0f1', fontWeight: 'bold' })
    });
    playerLabel.position.set(20, 12);
    arenaCont.addChild(playerLabel);

    this.tavernMyHandText = new Text({
      text: '❓ Aguardando',
      style: new TextStyle({ fontSize: 13, fill: '#ffd700', fontWeight: 'bold' })
    });
    this.tavernMyHandText.position.set(20, 36);
    arenaCont.addChild(this.tavernMyHandText);

    const vsText = new Text({
      text: 'VS',
      style: new TextStyle({ fontSize: 14, fill: '#e74c3c', fontWeight: 'bold' })
    });
    vsText.anchor.set(0.5, 0.5);
    vsText.position.set(145, 48);
    arenaCont.addChild(vsText);

    const npcLabel = new Text({
      text: 'Mão de Tsunade:',
      style: new TextStyle({ fontSize: 9.5, fill: '#ecf0f1', fontWeight: 'bold' })
    });
    npcLabel.position.set(180, 12);
    arenaCont.addChild(npcLabel);

    this.tavernNpcHandText = new Text({
      text: '❓ Oculta',
      style: new TextStyle({ fontSize: 13, fill: '#ffd700', fontWeight: 'bold' })
    });
    this.tavernNpcHandText.position.set(180, 36);
    arenaCont.addChild(this.tavernNpcHandText);

    // Resultado
    this.tavernResultText = new Text({
      text: 'Escolha uma mão abaixo para jogar!',
      style: new TextStyle({
        fontSize: 10,
        fontWeight: 'bold',
        fill: '#f39c12',
        align: 'center'
      })
    });
    this.tavernResultText.anchor.set(0.5, 0);
    this.tavernResultText.position.set(145, 82);
    arenaCont.addChild(this.tavernResultText);

    moraCont.addChild(arenaCont);

    // 3 Botões de Escolha: Pedra, Tesoura, Papel
    const moraHands = [
      { name: 'Pedra ✊', hand: 1 },
      { name: 'Tesoura ✌️', hand: 2 },
      { name: 'Papel 🖐️', hand: 0 }
    ];

    let btnX = 20;
    for (const mh of moraHands) {
      const btn = new Container();
      btn.position.set(btnX, 260);
      btn.eventMode = 'static';
      btn.cursor = 'pointer';

      try {
        const bTex = await Assets.load('/assets/ui/btn_ninja_action.png');
        const bSp = new Sprite(bTex);
        bSp.width = 90;
        bSp.height = 32;
        btn.addChild(bSp);
      } catch {}

      const bTxt = new Text({
        text: mh.name,
        style: new TextStyle({
          fontFamily: 'SimSun, "Microsoft YaHei", sans-serif',
          fontSize: 9.5,
          fontWeight: 'bold',
          fill: '#ffffff',
          stroke: { color: '#1a1006', width: 2 }
        })
      });
      bTxt.anchor.set(0.5, 0.5);
      bTxt.position.set(45, 16);
      btn.addChild(bTxt);

      btn.on('pointertap', () => {
        const handNames: Record<number, string> = { 1: '✊ Pedra', 2: '✌️ Tesoura', 0: '🖐️ Papel' };
        if (this.tavernMyHandText) this.tavernMyHandText.text = handNames[mh.hand];
        if (this.callbacks.onTavernMora) {
          this.callbacks.onTavernMora(mh.hand, 1);
        }
      });

      moraCont.addChild(btn);
      btnX += 100;
    }

    this.tavernModal.addChild(moraCont);

    // ==========================================
    // PAINEL DIREITO: RECRUTAMENTO DE NINJAS
    // ==========================================
    const recruitCont = new Container();
    recruitCont.position.set(385, 52);

    const recruitList = [
      { heroId: 11100006, name: 'Naruto Uzumaki', title: 'Vento / Nv.1', portrait: '/assets/ui/portrait_325.png', cost: '10 Almas Azuis', canRecruit: true },
      { heroId: 11100007, name: 'Sasuke Uchiha', title: 'Fogo / Nv.1', portrait: '/assets/ui/portrait_327.png', cost: '10 Almas Azuis', canRecruit: true },
      { heroId: 11100013, name: 'Sakura Haruno', title: 'Terra / Nv.1', portrait: '/assets/ui/portrait_331.png', cost: '10 Almas Azuis', canRecruit: true },
      { heroId: 11100005, name: 'Kakashi Hatake', title: 'Relâmpago / Nv.20', portrait: '/assets/ui/portrait_333.png', cost: '30 Almas Roxas', canRecruit: true },
      { heroId: 11100011, name: 'Jiraiya [Sannin]', title: 'Fogo / Nv.40', portrait: '/assets/ui/portrait_337.png', cost: '50 Almas Douradas', canRecruit: false }
    ];

    let rY = 0;
    for (const r of recruitList) {
      const row = new Container();
      row.position.set(0, rY);

      // Fundo do Ninja
      const bg = new Graphics()
        .roundRect(0, 0, 350, 68, 4)
        .fill({ color: 0x161b22, alpha: 0.9 })
        .stroke({ color: 0x30363d, width: 1.5 });
      row.addChild(bg);

      // Retrato
      try {
        const pTex = await Assets.load(r.portrait);
        const pSp = new Sprite(pTex);
        pSp.position.set(10, 8);
        pSp.width = 52;
        pSp.height = 52;
        row.addChild(pSp);
      } catch {}

      // Informações
      const nTxt = new Text({
        text: `${r.name}\n${r.title}\nCusto: ${r.cost}`,
        style: new TextStyle({
          fontFamily: 'SimSun, "Microsoft YaHei", sans-serif',
          fontSize: 9.5,
          fontWeight: 'bold',
          fill: '#f0e6d2',
          lineHeight: 14,
          stroke: { color: '#000000', width: 2 }
        })
      });
      nTxt.position.set(70, 10);
      row.addChild(nTxt);

      // Botão "Recrutar"
      const rBtn = new Container();
      rBtn.position.set(245, 18);
      rBtn.eventMode = 'static';
      rBtn.cursor = r.canRecruit ? 'pointer' : 'default';

      try {
        const bTex = await Assets.load('/assets/ui/btn_ninja_action.png');
        const bSp = new Sprite(bTex);
        bSp.width = 92;
        bSp.height = 32;
        if (!r.canRecruit) bSp.alpha = 0.5;
        rBtn.addChild(bSp);
      } catch {}

      const bTxt = new Text({
        text: r.canRecruit ? 'Recrutar' : 'Bloqueado',
        style: new TextStyle({
          fontFamily: 'SimSun, "Microsoft YaHei", sans-serif',
          fontSize: 10,
          fontWeight: 'bold',
          fill: r.canRecruit ? '#ffd700' : '#888888',
          stroke: { color: '#1a1006', width: 2 }
        })
      });
      bTxt.anchor.set(0.5, 0.5);
      bTxt.position.set(46, 16);
      rBtn.addChild(bTxt);

      if (r.canRecruit) {
        rBtn.on('pointertap', () => {
          if (this.callbacks.onTavernRecruit) {
            this.callbacks.onTavernRecruit(r.heroId);
          }
        });
      }

      row.addChild(rBtn);
      recruitCont.addChild(row);
      rY += 76;
    }

    this.tavernModal.addChild(recruitCont);
    this.modalLayer.addChild(this.tavernModal);
  }

  public updateTavernResult(isWin: boolean, serverHand: number, soulType: number, soulAward: number): void {
    const handNames: Record<number, string> = { 1: '✊ Pedra', 2: '✌️ Tesoura', 0: '🖐️ Papel' };
    if (this.tavernNpcHandText) {
      this.tavernNpcHandText.text = handNames[serverHand] || '✊ Pedra';
    }

    if (isWin) {
      if (soulType === 1) this.tavernSouls.blue += soulAward;
      else this.tavernSouls.purple += soulAward;

      if (this.tavernResultText) {
        this.tavernResultText.text = `🎉 Vitória! +${soulAward} Almas ${soulType === 1 ? 'Azuis' : 'Roxas'}!`;
        this.tavernResultText.style.fill = '#2ecc71';
      }
    } else {
      if (this.tavernResultText) {
        this.tavernResultText.text = `💥 Derrota... Tsunade venceu!`;
        this.tavernResultText.style.fill = '#e74c3c';
      }
    }

    if (this.tavernSoulsText) {
      this.tavernSoulsText.text = `Almas Azuis: ${this.tavernSouls.blue}  |  Roxas: ${this.tavernSouls.purple}  |  Douradas: ${this.tavernSouls.gold}`;
    }
  }

  public toggleTavern(): void {
    if (!this.tavernModal) return;
    const nextState = !this.tavernModal.visible;
    this.closeAllModals();
    this.tavernModal.visible = nextState;
  }

  private async buildGuildModal(): Promise<void> {
    const w = 780;
    const h = 421;
    this.guildModal = new Container();
    this.guildModal.position.set(Math.floor((1250 - w) / 2), Math.floor((650 - h) / 2));
    this.guildModal.visible = false;

    // Fundo Canônico da Guilda descompilado do SWF 35000000 (109.png)
    try {
      const bgTex = await Assets.load('/assets/ui/guild/109.png');
      const bgSp = new Sprite(bgTex);
      bgSp.width = w;
      bgSp.height = h;
      this.guildModal.addChild(bgSp);
    } catch {
      const fb = new Graphics()
        .roundRect(0, 0, w, h, 8)
        .fill({ color: 0x1a120b, alpha: 0.95 })
        .stroke({ color: 0x8b6508, width: 2 });
      this.guildModal.addChild(fb);
    }

    // Título Canônico da Guilda
    const title = new Text({
      text: 'Guilda Shinobi de Konoha [Vontade do Fogo]',
      style: new TextStyle({
        fontFamily: 'SimSun, "Microsoft YaHei", sans-serif',
        fontSize: 12,
        fontWeight: 'bold',
        fill: '#ffd700',
        stroke: { color: '#1a1006', width: 2 }
      })
    });
    title.anchor.set(0.5, 0.5);
    title.position.set(w / 2, 16);
    this.guildModal.addChild(title);

    // Botão Fechar
    const closeBtn = await this.createCloseButton(() => this.toggleGuild());
    closeBtn.position.set(w - 32, 16);
    this.guildModal.addChild(closeBtn);

    // ==========================================
    // PAINEL ESQUERDO: INFORMAÇÕES DA GUILDA & DOAÇÃO
    // ==========================================
    const infoCont = new Container();
    infoCont.position.set(36, 48);

    // Brasão da Guilda
    try {
      const emblemTex = await Assets.load('/assets/ui/guild/192.png');
      const emblemSp = new Sprite(emblemTex);
      emblemSp.width = 64;
      emblemSp.height = 64;
      infoCont.addChild(emblemSp);
    } catch {}

    const gName = new Text({
      text: 'Vontade do Fogo',
      style: new TextStyle({
        fontFamily: 'SimSun, "Microsoft YaHei", sans-serif',
        fontSize: 12,
        fontWeight: 'bold',
        fill: '#ffd700',
        stroke: { color: '#1a1006', width: 2 }
      })
    });
    gName.position.set(74, 6);
    infoCont.addChild(gName);

    const gStats = [
      'Nível da Guilda: 3',
      'Líder: Tsunade [Hokage]',
      'Membros: 18 / 30 Ninjas',
      'Tesouro da Guilda: 485.000 Ryo'
    ];

    let gY = 28;
    for (const gs of gStats) {
      const st = new Text({
        text: gs,
        style: new TextStyle({
          fontFamily: 'SimSun, "Microsoft YaHei", sans-serif',
          fontSize: 9.5,
          fontWeight: 'bold',
          fill: '#e0d8c3',
          stroke: { color: '#1a1006', width: 1.5 }
        })
      });
      st.position.set(74, gY);
      infoCont.addChild(st);
      gY += 16;
    }

    // Contribuição do Jogador
    this.guildContributionText = new Text({
      text: `Sua Contribuição: ${this.playerGuildContribution} pts`,
      style: new TextStyle({
        fontFamily: 'SimSun, "Microsoft YaHei", sans-serif',
        fontSize: 10,
        fontWeight: 'bold',
        fill: '#2ecc71',
        stroke: { color: '#000000', width: 2 }
      })
    });
    this.guildContributionText.position.set(12, 108);
    infoCont.addChild(this.guildContributionText);

    // Botão "Doar 1.000 Ryo"
    const donateBtn = new Container();
    donateBtn.position.set(12, 134);
    donateBtn.eventMode = 'static';
    donateBtn.cursor = 'pointer';

    try {
      const bTex = await Assets.load('/assets/ui/btn_ninja_action.png');
      const bSp = new Sprite(bTex);
      bSp.width = 110;
      bSp.height = 32;
      donateBtn.addChild(bSp);
    } catch {}

    const donLabel = new Text({
      text: 'Doar Ryo (+100)',
      style: new TextStyle({
        fontFamily: 'SimSun, "Microsoft YaHei", sans-serif',
        fontSize: 9.5,
        fontWeight: 'bold',
        fill: '#ffffff',
        stroke: { color: '#1a1006', width: 2 }
      })
    });
    donLabel.anchor.set(0.5, 0.5);
    donLabel.position.set(55, 16);
    donateBtn.addChild(donLabel);

    donateBtn.on('pointertap', () => {
      if (this.callbacks.onGuildDonate) {
        this.callbacks.onGuildDonate(1000);
      }
    });
    infoCont.addChild(donateBtn);

    // Habilidades Passivas da Guilda
    const skillHeader = new Text({
      text: 'Habilidades Passivas da Guilda:',
      style: new TextStyle({
        fontFamily: 'SimSun, "Microsoft YaHei", sans-serif',
        fontSize: 10,
        fontWeight: 'bold',
        fill: '#e67e22',
        stroke: { color: '#1a1006', width: 1.5 }
      })
    });
    skillHeader.position.set(12, 185);
    infoCont.addChild(skillHeader);

    const guildSkills = [
      '🔥 Treino Físico Nv. 3: Ataque +120',
      '💧 Controle de Chakra Nv. 3: Ninjutsu +140',
      '🛡️ Pele de Ferro Nv. 2: Defesa +80',
      '🍃 Agilidade da Folha Nv. 3: Velocidade +50'
    ];

    let skY = 208;
    for (const sk of guildSkills) {
      const skTxt = new Text({
        text: sk,
        style: new TextStyle({
          fontFamily: 'SimSun, "Microsoft YaHei", sans-serif',
          fontSize: 9,
          fill: '#f1c40f',
          stroke: { color: '#000000', width: 1.5 }
        })
      });
      skTxt.position.set(12, skY);
      infoCont.addChild(skTxt);
      skY += 18;
    }

    this.guildModal.addChild(infoCont);

    // ==========================================
    // PAINEL DIREITO: ROSTER DE MEMBROS DA GUILDA
    // ==========================================
    const rosterCont = new Container();
    rosterCont.position.set(285, 48);

    const rHeader = new Text({
      text: 'Membros da Guilda [Ativos]:',
      style: new TextStyle({
        fontFamily: 'SimSun, "Microsoft YaHei", sans-serif',
        fontSize: 11,
        fontWeight: 'bold',
        fill: '#ffd700',
        stroke: { color: '#1a1006', width: 2 }
      })
    });
    rHeader.position.set(0, 0);
    rosterCont.addChild(rHeader);

    const members = [
      { name: 'Tsunade (Líder)', role: 'Hokage', lvl: 85, pts: 14200, status: '🟢 Online' },
      { name: 'Jiraiya (Vice-Líder)', role: 'Sannin', lvl: 83, pts: 11800, status: '🟢 Online' },
      { name: 'Kakashi (Elite)', role: 'Jounin', lvl: 75, pts: 8900, status: '🟡 Missão' },
      { name: 'Guy (Elite)', role: 'Jounin', lvl: 74, pts: 8200, status: '🟢 Online' },
      { name: 'Naruto Uzumaki', role: 'Genin', lvl: 25, pts: 3500, status: '🟢 Online' },
      { name: 'Dasi (Você)', role: 'Membro', lvl: 1, pts: this.playerGuildContribution, status: '🟢 Online' }
    ];

    let mY = 26;
    for (const m of members) {
      const row = new Container();
      row.position.set(0, mY);

      const mTxt = new Text({
        text: `${m.name}  |  ${m.role}  |  Nv. ${m.lvl}  |  ${m.pts} pts  |  ${m.status}`,
        style: new TextStyle({
          fontFamily: 'SimSun, "Microsoft YaHei", sans-serif',
          fontSize: 9.5,
          fontWeight: 'bold',
          fill: '#f0e6d2',
          stroke: { color: '#1a1006', width: 1.5 }
        })
      });
      row.addChild(mTxt);
      rosterCont.addChild(row);
      mY += 28;
    }

    this.guildModal.addChild(rosterCont);
    this.modalLayer.addChild(this.guildModal);
  }

  public toggleGuild(): void {
    if (!this.guildModal) return;
    const nextState = !this.guildModal.visible;
    this.closeAllModals();
    this.guildModal.visible = nextState;
    if (nextState && this.callbacks.onGuildOpen) {
      this.callbacks.onGuildOpen();
    }
  }

  private async buildActivityGiftModal(): Promise<void> {
    const w = 560;
    const h = 380;
    this.activityGiftModal = new Container();
    this.activityGiftModal.position.set(Math.floor((1250 - w) / 2), Math.floor((650 - h) / 2));
    this.activityGiftModal.visible = false;

    // Moldura Genérica Canônica
    try {
      const fTex = await Assets.load('/assets/ui/modal_generic_frame.png');
      const fSp = new Sprite(fTex);
      fSp.width = w;
      fSp.height = h;
      this.activityGiftModal.addChild(fSp);
    } catch {}

    // Banner Oficial de Presentes descompilado do SWF 32000000 (4.png)
    try {
      const bTex = await Assets.load('/assets/ui/welcome/4.png');
      const bSp = new Sprite(bTex);
      bSp.width = 500;
      bSp.height = 70;
      bSp.position.set(30, 42);
      this.activityGiftModal.addChild(bSp);
    } catch {}

    // Título
    this.giftModalTitleText = new Text({
      text: 'Código & Atividades Ninja (CDK)',
      style: new TextStyle({
        fontFamily: 'SimSun, "Microsoft YaHei", sans-serif',
        fontSize: 12,
        fontWeight: 'bold',
        fill: '#ffd700',
        stroke: { color: '#1a1006', width: 2 }
      })
    });
    this.giftModalTitleText.anchor.set(0.5, 0.5);
    this.giftModalTitleText.position.set(w / 2, 16);
    this.activityGiftModal.addChild(this.giftModalTitleText);

    // Botão Fechar
    const closeBtn = await this.createCloseButton(() => this.toggleActivityGift());
    closeBtn.position.set(w - 32, 16);
    this.activityGiftModal.addChild(closeBtn);

    // Instrução
    const descText = new Text({
      text: 'Insira o código promocional de Konoha para resgatar recompensas exclusivas:',
      style: new TextStyle({
        fontFamily: 'SimSun, "Microsoft YaHei", sans-serif',
        fontSize: 9.5,
        fontWeight: 'bold',
        fill: '#f0e6d2',
        stroke: { color: '#1a1006', width: 1.5 }
      })
    });
    descText.position.set(36, 126);
    this.activityGiftModal.addChild(descText);

    // Campo de Código CDK
    const codeBoxCont = new Container();
    codeBoxCont.position.set(36, 150);

    const codeBg = new Graphics()
      .roundRect(0, 0, 360, 36, 4)
      .fill({ color: 0x16120e, alpha: 0.9 })
      .stroke({ color: 0xd4af37, width: 1.5 });
    codeBoxCont.addChild(codeBg);

    const codeValText = new Text({
      text: 'NARUTO-BOND-2026',
      style: new TextStyle({
        fontFamily: 'Courier New, monospace',
        fontSize: 13,
        fontWeight: 'bold',
        fill: '#ffd700'
      })
    });
    codeValText.anchor.set(0, 0.5);
    codeValText.position.set(16, 18);
    codeBoxCont.addChild(codeValText);
    this.activityGiftModal.addChild(codeBoxCont);

    // Recompensas Exibidas
    const rewardsCont = new Container();
    rewardsCont.position.set(36, 204);

    const rewHeader = new Text({
      text: 'Conteúdo do Pacote Promocional:',
      style: new TextStyle({
        fontFamily: 'SimSun, "Microsoft YaHei", sans-serif',
        fontSize: 10,
        fontWeight: 'bold',
        fill: '#e67e22',
        stroke: { color: '#1a1006', width: 1.5 }
      })
    });
    rewardsCont.addChild(rewHeader);

    const rewardItems = [
      { name: '🪙 50.000 Ryo (Prata)', color: '#ecf0f1' },
      { name: '🎟️ 200 Cupons Ninja', color: '#f39c12' },
      { name: '🍜 5x Tigela de Lámen Ichiraku', color: '#2ecc71' },
      { name: '📜 10x Pergaminho de Selamento', color: '#9b59b6' }
    ];

    let rY = 24;
    for (const ri of rewardItems) {
      const rTxt = new Text({
        text: ri.name,
        style: new TextStyle({
          fontFamily: 'SimSun, "Microsoft YaHei", sans-serif',
          fontSize: 9.5,
          fontWeight: 'bold',
          fill: ri.color,
          stroke: { color: '#000000', width: 1.5 }
        })
      });
      rTxt.position.set(12, rY);
      rewardsCont.addChild(rTxt);
      rY += 20;
    }
    this.activityGiftModal.addChild(rewardsCont);

    // Botão "Resgatar Recompensa"
    const claimBtn = new Container();
    claimBtn.position.set(410, 150);
    claimBtn.eventMode = 'static';
    claimBtn.cursor = 'pointer';

    try {
      const bTex = await Assets.load('/assets/ui/btn_ninja_action.png');
      const bSp = new Sprite(bTex);
      bSp.width = 110;
      bSp.height = 36;
      claimBtn.addChild(bSp);
    } catch {}

    const claimLabel = new Text({
      text: 'Resgatar',
      style: new TextStyle({
        fontFamily: 'SimSun, "Microsoft YaHei", sans-serif',
        fontSize: 11,
        fontWeight: 'bold',
        fill: '#ffffff',
        stroke: { color: '#1a1006', width: 2 }
      })
    });
    claimLabel.anchor.set(0.5, 0.5);
    claimLabel.anchor.set(0.5, 0.5);
    claimLabel.position.set(55, 18);
    claimBtn.addChild(claimLabel);
    this.cdkClaimLabel = claimLabel;

    claimBtn.on('pointertap', () => {
      if (this.callbacks.onRedeemCdk) {
        this.callbacks.onRedeemCdk('NARUTO-BOND-2026');
      }
    });

    this.activityGiftModal.addChild(claimBtn);
    this.modalLayer.addChild(this.activityGiftModal);
  }

  public toggleActivityGift(activityTitle?: string): void {
    if (!this.activityGiftModal) return;
    const nextState = !this.activityGiftModal.visible;
    this.closeAllModals();
    this.activityGiftModal.visible = nextState;
    if (nextState && activityTitle && this.giftModalTitleText) {
      this.giftModalTitleText.text = `Atividade: ${activityTitle}`;
    }
  }

  public updateGuildDonateResult(newContribution: number, newSilver: number): void {
    this.playerGuildContribution = newContribution;
    if (this.guildContributionText) {
      this.guildContributionText.text = `Sua Contribuição: ${newContribution} pts`;
    }
    this.updateCurrencies(newSilver, this.profile.gold || 0);
  }

  public updateCdkResult(code: string, silverAward: number, couponAward: number, errorCode: number): void {
    if (errorCode === 0) {
      if (this.cdkClaimLabel) this.cdkClaimLabel.text = '✅ Resgatado!';
      this.updateCurrencies((this.profile.silver || 10000) + silverAward, this.profile.gold || 0);
      const curCoupons = parseInt(this.couponText?.text || '200') || 200;
      if (this.couponText) this.couponText.text = `${curCoupons + couponAward}`;
      this.addChatMessage('Sistema', '', `🎁 Pacote Promocional ${code} Resgatado! +${silverAward.toLocaleString()} Ryo e +${couponAward} Cupons adicionados!`);
    } else if (errorCode === 2) {
      if (this.cdkClaimLabel) this.cdkClaimLabel.text = '⚠️ Já Resgatado';
      this.addChatMessage('Sistema', '', `⚠️ O código promocional ${code} já foi resgatado por esta conta.`);
    } else {
      if (this.cdkClaimLabel) this.cdkClaimLabel.text = '❌ Inválido';
      this.addChatMessage('Sistema', '', `❌ O código promocional ${code} é inválido ou expirou.`);
    }
  }

  public updateCombatPower(power: number): void {
    this.heroCombatPower = power;
    if (this.combatPowerText) {
      this.combatPowerText.text = `${power}`;
    }
    if (this.heroCombatPowerLabel) {
      this.heroCombatPowerLabel.text = `Poder de Luta: ${power}`;
    }
    this.addChatMessage('Sistema', '', `💪 Poder de Luta Ninja elevado para ${power}!`);
  }

  public async showBattleVictoryModal(expAward: number, silverAward: number): Promise<void> {
    if (this.battleVictoryModal) {
      this.battleVictoryModal.destroy({ children: true });
      this.battleVictoryModal = null;
    }

    const w = 520;
    const h = 330;
    this.battleVictoryModal = new Container();
    this.battleVictoryModal.position.set(Math.floor((1250 - w) / 2), Math.floor((650 - h) / 2));

    try {
      const fTex = await Assets.load('/assets/ui/modal_generic_frame.png');
      const fSp = new Sprite(fTex);
      fSp.width = w;
      fSp.height = h;
      this.battleVictoryModal.addChild(fSp);
    } catch {}

    const title = new Text({
      text: 'Relatório de Combate — Vitória Shinobi!',
      style: new TextStyle({
        fontFamily: 'SimSun, "Microsoft YaHei", sans-serif',
        fontSize: 13,
        fontWeight: 'bold',
        fill: '#ffd700',
        stroke: { color: '#1a1006', width: 2 }
      })
    });
    title.anchor.set(0.5, 0.5);
    title.position.set(w / 2, 18);
    this.battleVictoryModal.addChild(title);

    const closeBtn = await this.createCloseButton(() => {
      if (this.battleVictoryModal) this.battleVictoryModal.visible = false;
    });
    closeBtn.position.set(w - 32, 18);
    this.battleVictoryModal.addChild(closeBtn);

    const vicHeader = new Text({
      text: '⚔️ INIMIGOS DERROTADOS COM SUCESSO! ⚔️',
      style: new TextStyle({
        fontFamily: 'SimSun, "Microsoft YaHei", sans-serif',
        fontSize: 13,
        fontWeight: 'bold',
        fill: '#2ecc71',
        stroke: { color: '#052b14', width: 2.5 }
      })
    });
    vicHeader.anchor.set(0.5, 0);
    vicHeader.position.set(w / 2, 58);
    this.battleVictoryModal.addChild(vicHeader);

    const summaryBox = new Container();
    summaryBox.position.set(45, 98);

    const sBg = new Graphics()
      .roundRect(0, 0, 430, 140, 6)
      .fill({ color: 0x16120e, alpha: 0.9 })
      .stroke({ color: 0xd4af37, width: 1.5 });
    summaryBox.addChild(sBg);

    const details = [
      `🥋 Formação Aliada: Vitória em 3 Turnos Táticos!`,
      `📜 Recompensa de Experiência: +${expAward.toLocaleString()} EXP`,
      `🪙 Recompensa em Ryo: +${silverAward.toLocaleString()} Ryo de Prata`,
      `⭐ Avaliação de Batalha: Ranking S [Perfeito]`
    ];

    let dY = 16;
    for (const d of details) {
      const dt = new Text({
        text: d,
        style: new TextStyle({
          fontFamily: 'SimSun, "Microsoft YaHei", sans-serif',
          fontSize: 10.5,
          fontWeight: 'bold',
          fill: '#f0e6d2',
          stroke: { color: '#000000', width: 1.5 }
        })
      });
      dt.position.set(20, dY);
      summaryBox.addChild(dt);
      dY += 28;
    }
    this.battleVictoryModal.addChild(summaryBox);

    const okBtn = new Container();
    okBtn.position.set(w / 2, 276);
    okBtn.eventMode = 'static';
    okBtn.cursor = 'pointer';

    try {
      const bTex = await Assets.load('/assets/ui/btn_ninja_action.png');
      const bSp = new Sprite(bTex);
      bSp.anchor.set(0.5, 0.5);
      bSp.width = 120;
      bSp.height = 34;
      okBtn.addChild(bSp);
    } catch {}

    const okTxt = new Text({
      text: 'Confirmar',
      style: new TextStyle({
        fontFamily: 'SimSun, "Microsoft YaHei", sans-serif',
        fontSize: 11,
        fontWeight: 'bold',
        fill: '#ffffff',
        stroke: { color: '#1a1006', width: 2 }
      })
    });
    okTxt.anchor.set(0.5, 0.5);
    okBtn.addChild(okTxt);

    okBtn.on('pointertap', () => {
      if (this.battleVictoryModal) {
        this.battleVictoryModal.visible = false;
      }
    });

    this.battleVictoryModal.addChild(okBtn);
    this.modalLayer.addChild(this.battleVictoryModal);
  }

  public closeAllModals(): void {
    if (this.bagModal) {
      this.bagModal.visible = false;
      if (this.itemDetailPopup) {
        this.itemDetailPopup.destroy({ children: true });
        this.itemDetailPopup = null;
      }
    }
    if (this.formationModal) this.formationModal.visible = false;
    if (this.heroModal) this.heroModal.visible = false;
    if (this.mailModal) this.mailModal.visible = false;
    if (this.tavernModal) this.tavernModal.visible = false;
    if (this.guildModal) this.guildModal.visible = false;
    if (this.activityGiftModal) this.activityGiftModal.visible = false;
    if (this.battleVictoryModal) this.battleVictoryModal.visible = false;
  }

  public destroy(options?: any): void {
    window.removeEventListener('keydown', this.keyHandler);
    if (this.chatInputDom) {
      this.chatInputDom.remove();
      this.chatInputDom = null;
    }
    super.destroy(options);
  }
}
