import { Container, Graphics, Sprite, Text, TextStyle, Assets, Texture } from 'pixi.js';
import { PlayerProfile } from './TownScene.js';

export interface HudCallbacks {
  onQuestClick?: (npcName: string) => void;
  onBgmToggle?: () => void;
  onBattleTest?: () => void;
  onChatSend?: (channel: string, message: string) => void;
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
  private chakraFill!: Graphics;
  private chakraText!: Text;
  private silverText!: Text;
  private couponText!: Text;
  private goldText!: Text;
  private coordsText!: Text;
  private cityNameText!: Text;
  private bgmLabelText!: Text;

  // Chat Feed
  private chatMessagesCont!: Container;
  private chatInputDom: HTMLInputElement | null = null;
  private currentChatChannel: string = 'Mundo';

  // Modais
  private bagModal: Container | null = null;
  private formationModal: Container | null = null;
  private heroModal: Container | null = null;

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

    this.buildTopProfileHUD();
    this.buildCurrencyBar();
    this.buildActivityBar();
    this.buildRadarCompass();
    this.buildBottomShortcutBar();
    this.buildQuestTracker();
    this.buildChatBox();
    this.buildModals();

    // Listener global de atalhos de teclado (B = Mochila, T = Formação, C = Ninja, Esc = Fechar)
    this.keyHandler = (e: KeyboardEvent) => {
      if (document.activeElement === this.chatInputDom) return; // Não dispara se estiver digitando no chat
      const key = e.key.toUpperCase();
      if (key === 'B') {
        this.toggleBackpack();
      } else if (key === 'T') {
        this.toggleFormation();
      } else if (key === 'C') {
        this.toggleHero();
      } else if (e.key === 'Escape') {
        this.closeAllModals();
      }
    };
    window.addEventListener('keydown', this.keyHandler);
  }

  /* =========================================================================
   * 1. TOP-LEFT: PERFIL DO JOGADOR (DefineSprite_615_Shortcuts_Avatar)
   * ========================================================================= */
  private async buildTopProfileHUD(): Promise<void> {
    this.topProfileCont.position.set(8, 8);

    // 1. Moldura Autêntica Flash (432.png - 305x109)
    try {
      const frameTex = await Assets.load('/assets/ui/avatar_frame.png');
      const frameSprite = new Sprite(frameTex);
      frameSprite.position.set(0, 20);
      this.topProfileCont.addChild(frameSprite);
    } catch {
      const fallback = new Graphics()
        .roundRect(0, 20, 305, 109, 8)
        .fill({ color: 0x12151d, alpha: 0.9 })
        .stroke({ color: 0xd4af37, width: 2 });
      this.topProfileCont.addChild(fallback);
    }

    // 2. Retrato Circular Autêntico do Ninja dentro do disco seigaiha
    const portraitMap: Record<number, string> = {
      4: this.profile.gender === 1 ? 'portrait_325.png' : 'portrait_327.png',
      1: this.profile.gender === 1 ? 'portrait_329.png' : 'portrait_331.png',
      2: this.profile.gender === 1 ? 'portrait_333.png' : 'portrait_335.png'
    };
    const portraitFile = portraitMap[this.profile.profession] || 'portrait_325.png';

    const avatarCircleCont = new Container();
    avatarCircleCont.position.set(46, 74);

    try {
      const pTex = await Assets.load(`/assets/ui/${portraitFile}`);
      const portraitSprite = new Sprite(pTex);
      portraitSprite.anchor.set(0.5, 0.5);
      portraitSprite.width = 64;
      portraitSprite.height = 64;

      const circleMask = new Graphics()
        .circle(0, 0, 32)
        .fill(0xffffff);

      portraitSprite.mask = circleMask;
      avatarCircleCont.addChild(circleMask);
      avatarCircleCont.addChild(portraitSprite);
    } catch {
      const fallbackCircle = new Graphics()
        .circle(0, 0, 32)
        .fill(0x334455);
      avatarCircleCont.addChild(fallbackCircle);
    }
    this.topProfileCont.addChild(avatarCircleCont);

    // 3. Emblema de Nível (à esquerda na barra verde)
    const levelTxt = new Text({
      text: `Lv.${this.profile.level}`,
      style: new TextStyle({
        fontFamily: 'SimSun, "Microsoft YaHei", sans-serif',
        fontSize: 11,
        fontWeight: 'bold',
        fill: '#ffd700',
        stroke: { color: '#2a1604', width: 2 }
      })
    });
    levelTxt.position.set(88, 33);
    this.topProfileCont.addChild(levelTxt);

    // 4. Nome do Jogador (à direita do nível na barra verde)
    const nameTxt = new Text({
      text: this.profile.name,
      style: new TextStyle({
        fontFamily: 'SimSun, "Microsoft YaHei", sans-serif',
        fontSize: 12,
        fontWeight: 'bold',
        fill: '#f0e6d2',
        stroke: { color: '#1a1006', width: 2 }
      })
    });
    nameTxt.position.set(132, 33);
    this.topProfileCont.addChild(nameTxt);

    // 5. Barra de Vigor / Ordem Militar (MC_ProgressBarMilitaryOrder)
    const hpBg = new Graphics()
      .roundRect(88, 55, 150, 8, 2)
      .fill({ color: 0x1a0f12, alpha: 0.95 });
    this.topProfileCont.addChild(hpBg);

    this.hpFill = new Graphics()
      .roundRect(88, 55, 150, 8, 2)
      .fill(0xd63031);
    this.topProfileCont.addChild(this.hpFill);

    this.hpText = new Text({
      text: `${this.profile.curHp} / ${this.profile.maxHp}`,
      style: new TextStyle({
        fontFamily: 'Arial, sans-serif',
        fontSize: 8,
        fontWeight: 'bold',
        fill: '#ffffff',
        stroke: { color: '#000000', width: 2 }
      })
    });
    this.hpText.anchor.set(0.5, 0.5);
    this.hpText.position.set(88 + 150 / 2, 59);
    this.topProfileCont.addChild(this.hpText);

    // 6. Placa de Poder de Luta Oficial (bp_plate.png - 188x59)
    try {
      const bpTex = await Assets.load('/assets/ui/bp_plate.png');
      const bpSprite = new Sprite(bpTex);
      bpSprite.position.set(84, 68);
      this.topProfileCont.addChild(bpSprite);
    } catch {
      // Fallback
    }

    const bpTxt = new Text({
      text: '3.420',
      style: new TextStyle({
        fontFamily: 'Impact, Arial Black, sans-serif',
        fontSize: 16,
        fontWeight: 'bold',
        fill: '#ffd700',
        stroke: { color: '#3e1a00', width: 3 }
      })
    });
    bpTxt.position.set(158, 82);
    this.topProfileCont.addChild(bpTxt);

    // 7. Selo VIP Oficial (vip_badge.png - 63x70)
    try {
      const vipTex = await Assets.load('/assets/ui/vip_badge.png');
      const vipSprite = new Sprite(vipTex);
      vipSprite.position.set(244, 60);
      vipSprite.scale.set(0.72);
      vipSprite.eventMode = 'static';
      vipSprite.cursor = 'pointer';
      vipSprite.on('pointertap', () => {
        alert('👑 Privilégios VIP Shinobi Ativos');
      });
      this.topProfileCont.addChild(vipSprite);
    } catch {
      // Fallback
    }
  }

  /* =========================================================================
   * 2. TOP-LEFT: BARRA DE MOEDAS (currency_bar.png 385x50)
   * ========================================================================= */
  private async buildCurrencyBar(): Promise<void> {
    this.currencyCont.position.set(78, 6);

    try {
      const curTex = await Assets.load('/assets/ui/currency_bar.png');
      const curSprite = new Sprite(curTex);
      this.currencyCont.addChild(curSprite);
    } catch {
      const bg = new Graphics()
        .roundRect(0, 0, 385, 46, 6)
        .fill({ color: 0x161b22, alpha: 0.9 })
        .stroke({ color: 0x30363d, width: 1.5 });
      this.currencyCont.addChild(bg);
    }

    // Ryo / Prata
    this.silverText = new Text({
      text: this.profile.silver.toLocaleString(),
      style: new TextStyle({
        fontFamily: 'Arial, sans-serif',
        fontSize: 11,
        fontWeight: 'bold',
        fill: '#ecf0f1',
        stroke: { color: '#000000', width: 2 }
      })
    });
    this.silverText.position.set(45, 15);
    this.currencyCont.addChild(this.silverText);

    // Cupons
    this.couponText = new Text({
      text: '350',
      style: new TextStyle({
        fontFamily: 'Arial, sans-serif',
        fontSize: 11,
        fontWeight: 'bold',
        fill: '#f39c12',
        stroke: { color: '#000000', width: 2 }
      })
    });
    this.couponText.position.set(162, 15);
    this.currencyCont.addChild(this.couponText);

    // Lingotes de Ouro
    this.goldText = new Text({
      text: this.profile.gold.toLocaleString(),
      style: new TextStyle({
        fontFamily: 'Arial, sans-serif',
        fontSize: 11,
        fontWeight: 'bold',
        fill: '#ffd700',
        stroke: { color: '#000000', width: 2 }
      })
    });
    this.goldText.position.set(280, 15);
    this.currencyCont.addChild(this.goldText);

    // Botão Recarregar Autêntico (recharge_btn.png)
    try {
      const recTex = await Assets.load('/assets/ui/recharge_btn.png');
      const recSprite = new Sprite(recTex);
      recSprite.position.set(380, 2);
      recSprite.scale.set(0.9);
      recSprite.eventMode = 'static';
      recSprite.cursor = 'pointer';
      recSprite.on('pointertap', () => {
        alert('🌟 Portal de Recarga de Lingotes de Ouro');
      });
      this.currencyCont.addChild(recSprite);
    } catch {
      // Fallback
    }

    // Baú de Presente Online (chest_gift.png)
    try {
      const chestTex = await Assets.load('/assets/ui/chest_gift.png');
      const chestSprite = new Sprite(chestTex);
      chestSprite.position.set(436, -2);
      chestSprite.scale.set(0.85);
      chestSprite.eventMode = 'static';
      chestSprite.cursor = 'pointer';
      chestSprite.on('pointertap', () => {
        alert('🎁 Pacote de Recompensa de Tempo Online Coletado!');
      });
      this.currencyCont.addChild(chestSprite);

      const chestTimer = new Text({
        text: '05:00',
        style: new TextStyle({
          fontFamily: 'Arial, sans-serif',
          fontSize: 9,
          fontWeight: 'bold',
          fill: '#ffd700',
          stroke: { color: '#000000', width: 2 }
        })
      });
      chestTimer.anchor.set(0.5, 0);
      chestTimer.position.set(470, 34);
      this.currencyCont.addChild(chestTimer);
    } catch {
      // Fallback
    }
  }

  /* =========================================================================
   * 3. TOP-RIGHT: BARRA DE ATIVIDADES OFICIAIS
   * ========================================================================= */
  private async buildActivityBar(): Promise<void> {
    // Posicionada exatamente entre o baú online (x ~ 515) e a placa da vila (x ~ 885)
    this.activityCont.position.set(515, 8);

    const activities = [
      { id: 'sign', file: 'btn_sign.png', label: 'Check-in' },
      { id: 'recharge', file: 'btn_first_recharge.png', label: '1ª Recarga', customScale: 0.19 },
      { id: '7day', file: 'btn_7day.png', label: '7 Dias' },
      { id: 'online', file: 'btn_online_pack.png', label: 'Online' },
      { id: 'level', file: 'btn_level_gift.png', label: 'Presente' },
      { id: 'arena', file: 'btn_arena.png', label: 'Arena' },
      { id: 'tower', file: 'btn_tower.png', label: 'Exame' },
      { id: 'daily', file: 'btn_daily_quest.png', label: 'Diário' },
      { id: 'mall', file: 'btn_mall.png', label: 'Loja' },
      { id: 'ramen', file: 'btn_ramen.png', label: 'Ramen' }
    ];

    let currentX = 0;
    for (const act of activities) {
      const btn = new Container();
      btn.position.set(currentX, 0);
      btn.eventMode = 'static';
      btn.cursor = 'pointer';

      try {
        const tex = await Assets.load(`/assets/ui/${act.file}`);
        const sp = new Sprite(tex);
        sp.anchor.set(0.5, 0);
        const s = act.customScale || 0.44;
        sp.scale.set(s);
        btn.addChild(sp);
      } catch {
        const fallback = new Graphics()
          .circle(0, 16, 14)
          .fill(0xd4af37);
        btn.addChild(fallback);
      }

      btn.on('pointerenter', () => {
        btn.scale.set(1.08);
      });
      btn.on('pointerleave', () => {
        btn.scale.set(1.0);
      });
      btn.on('pointertap', () => {
        alert(`🎋 Atividade Oficial: [${act.label}]`);
      });

      this.activityCont.addChild(btn);
      currentX += 36;
    }
  }

  /* =========================================================================
   * 4. TOP-RIGHT: RADAR & BÚSSOLA CANÔNICA (TWindowMap / DefineSprite_168)
   * ========================================================================= */
  private async buildRadarCompass(): Promise<void> {
    // Alinhado flush no canto superior direito
    this.radarCont.position.set(1250 - 216, 0);

    // 1. Placa de Madeira do Nome da Vila & Coordenadas (map_title_plate.png - 135x62)
    const titleCont = new Container();
    titleCont.position.set(-148, 8);

    try {
      const plateTex = await Assets.load('/assets/ui/map_title_plate.png');
      const plateSprite = new Sprite(plateTex);
      titleCont.addChild(plateSprite);
    } catch {
      const fb = new Graphics()
        .roundRect(0, 0, 135, 62, 4)
        .fill({ color: 0x11161d, alpha: 0.9 })
        .stroke({ color: 0x30363d, width: 1 });
      titleCont.addChild(fb);
    }

    this.cityNameText = new Text({
      text: 'Vila da Folha',
      style: new TextStyle({
        fontFamily: 'SimSun, "Microsoft YaHei", sans-serif',
        fontSize: 11,
        fontWeight: 'bold',
        fill: '#f0e6d2',
        stroke: { color: '#1a1006', width: 2 }
      })
    });
    this.cityNameText.anchor.set(0.5, 0);
    this.cityNameText.position.set(67, 7);
    titleCont.addChild(this.cityNameText);

    this.coordsText = new Text({
      text: 'X: 450  Y: 480',
      style: new TextStyle({
        fontFamily: 'Arial, sans-serif',
        fontSize: 10,
        fontWeight: 'bold',
        fill: '#ffd700',
        stroke: { color: '#000000', width: 2 }
      })
    });
    this.coordsText.anchor.set(0.5, 0);
    this.coordsText.position.set(67, 34);
    titleCont.addChild(this.coordsText);

    this.radarCont.addChild(titleCont);

    // 2. Bússola Completa Oficial de Nuvens e Disco (DefineSprite_168_Shortcuts_MC_EnterMap)
    const compassCont = new Container();
    compassCont.position.set(0, 0);
    compassCont.eventMode = 'static';
    compassCont.cursor = 'pointer';

    try {
      const compTex = await Assets.load('/assets/ui/map_compass_full.png');
      const compSprite = new Sprite(compTex);
      compassCont.addChild(compSprite);
    } catch {
      const fb = new Graphics()
        .circle(100, 70, 40)
        .fill(0x2c3e50)
        .stroke({ color: 0xd4af37, width: 2 });
      compassCont.addChild(fb);
    }

    compassCont.on('pointerenter', () => { compassCont.scale.set(1.02); });
    compassCont.on('pointerleave', () => { compassCont.scale.set(1.0); });
    compassCont.on('pointertap', () => {
      alert('🗺 Mapa Mundi Shinobi (#168_Shortcuts_MC_EnterMap)');
    });
    this.radarCont.addChild(compassCont);

    // Botão de Áudio BGM embutido na bússola (ícone de som oficial)
    const soundToggleArea = new Container();
    soundToggleArea.position.set(40, 115);
    soundToggleArea.eventMode = 'static';
    soundToggleArea.cursor = 'pointer';

    const soundBg = new Graphics()
      .circle(0, 0, 14)
      .fill({ color: 0x11161f, alpha: 0.85 })
      .stroke({ color: 0x388bfd, width: 1.5 });
    soundToggleArea.addChild(soundBg);

    this.bgmLabelText = new Text({
      text: '🔊',
      style: new TextStyle({ fontSize: 11 })
    });
    this.bgmLabelText.anchor.set(0.5, 0.5);
    soundToggleArea.addChild(this.bgmLabelText);

    soundToggleArea.on('pointertap', (e) => {
      e.stopPropagation();
      if (this.callbacks.onBgmToggle) this.callbacks.onBgmToggle();
    });
    this.radarCont.addChild(soundToggleArea);
  }

  /* =========================================================================
   * 5. BOTTOM-CENTER: BARRA DE ATALHOS & EXP (TWindowFunction / DefineSprite_191)
   * ========================================================================= */
  private async buildBottomShortcutBar(): Promise<void> {
    // Alinhado a partir de x = 445 para dar total folga ao chat (x = 10 a 305)
    this.bottomBarCont.position.set(445, 570);

    // 1. Moldura Curva de Madeira Autêntica Flash (bottom_bar_bg.png - 735x117)
    try {
      const bgTex = await Assets.load('/assets/ui/bottom_bar_bg.png');
      const bgSp = new Sprite(bgTex);
      this.bottomBarCont.addChild(bgSp);
    } catch {
      const fb = new Graphics()
        .roundRect(0, 0, 735, 80, 10)
        .fill({ color: 0x1f1917, alpha: 0.95 })
        .stroke({ color: 0x8e44ad, width: 2 });
      this.bottomBarCont.addChild(fb);
    }

    // 2. Barra de Experiência (exp_bar.png)
    const expCont = new Container();
    expCont.position.set(58, 63);

    try {
      const expTex = await Assets.load('/assets/ui/exp_bar.png');
      const expSp = new Sprite(expTex);
      expSp.width = 550;
      expSp.height = 9;
      expCont.addChild(expSp);
    } catch {
      const fbExp = new Graphics()
        .rect(0, 0, 550, 9)
        .fill(0xf39c12);
      expCont.addChild(fbExp);
    }

    const expTxt = new Text({
      text: 'EXP: 3.450 / 10.000 (34.5%)',
      style: new TextStyle({
        fontFamily: 'Arial, sans-serif',
        fontSize: 8,
        fontWeight: 'bold',
        fill: '#ffffff',
        stroke: { color: '#000000', width: 2 }
      })
    });
    expTxt.anchor.set(0.5, 0.5);
    expTxt.position.set(275, 4);
    expCont.addChild(expTxt);
    this.bottomBarCont.addChild(expCont);

    // 3. Os 10 Botões Oficiais de Atalho (distribuídos com folga antes do vaso Potency)
    const shortcuts = [
      { id: 'ninja', file: 'btn_ninja.png', label: 'Ninjas', hotkey: 'C', action: () => this.toggleHero() },
      { id: 'bag', file: 'btn_bag.png', label: 'Mochila', hotkey: 'B', action: () => this.toggleBackpack() },
      { id: 'formation', file: 'btn_formation.png', label: 'Formação', hotkey: 'T', action: () => this.toggleFormation() },
      { id: 'strengthen', file: 'btn_strengthen.png', label: 'Forja', hotkey: 'E', action: () => alert('🔥 Fortalecimento de Equipamento') },
      { id: 'jade', file: 'btn_jade.png', label: 'Magatama', hotkey: '', action: () => alert('💎 Sistema de Magatamas') },
      { id: 'summon', file: 'btn_summon.png', label: 'Invocação', hotkey: '', action: () => alert('🐸 Invocação / Animais de Contrato') },
      { id: 'guild', file: 'btn_guild.png', label: 'Guilda', hotkey: 'O', action: () => alert('🛡 Organização Shinobi') },
      { id: 'mail', file: 'btn_mail.png', label: 'Correio', hotkey: 'M', action: () => alert('📬 Correio Shinobi') },
      { id: 'achieve', file: 'btn_achieve.png', label: 'Metas', hotkey: '', action: () => alert('🏆 Salão de Conquistas') },
      { id: 'practice', file: 'btn_practice.png', label: 'Treino', hotkey: '', action: () => alert('⚡ Campo de Treinamento') }
    ];

    const slotSpacing = 55;
    const btnStartX = 48;

    for (let i = 0; i < shortcuts.length; i++) {
      const s = shortcuts[i];
      const btnCont = new Container();
      btnCont.position.set(btnStartX + i * slotSpacing, 30);
      btnCont.eventMode = 'static';
      btnCont.cursor = 'pointer';

      try {
        const iconTex = await Assets.load(`/assets/ui/${s.file}`);
        const iconSp = new Sprite(iconTex);
        iconSp.anchor.set(0.5, 0.5);
        iconSp.width = 44;
        iconSp.height = 44;
        btnCont.addChild(iconSp);
      } catch {
        const fbIcon = new Graphics()
          .circle(0, 0, 20)
          .fill(0xd35400);
        btnCont.addChild(fbIcon);
      }

      if (s.hotkey) {
        const hkBadge = new Graphics()
          .roundRect(6, -22, 16, 14, 3)
          .fill({ color: 0x000000, alpha: 0.85 })
          .stroke({ color: 0xf1c40f, width: 1 });
        btnCont.addChild(hkBadge);

        const hkTxt = new Text({
          text: s.hotkey,
          style: new TextStyle({ fontSize: 9, fontWeight: 'bold', fill: '#f1c40f' })
        });
        hkTxt.anchor.set(0.5, 0.5);
        hkTxt.position.set(14, -15);
        btnCont.addChild(hkTxt);
      }

      btnCont.on('pointerenter', () => {
        btnCont.y = 26;
      });
      btnCont.on('pointerleave', () => {
        btnCont.y = 30;
      });
      btnCont.on('pointertap', () => {
        s.action();
      });

      this.bottomBarCont.addChild(btnCont);
    }
  }

  /* =========================================================================
   * 6. RIGHT-SIDE: RASTREADOR DE MISSÕES (TWindowQuestGuide / DefineSprite_67)
   * ========================================================================= */
  private async buildQuestTracker(): Promise<void> {
    this.questTrackerCont.position.set(1038, 175);

    // Fundo opaco para que NPCs no mapa não apareçam por trás do painel
    const solidBg = new Graphics()
      .roundRect(4, 28, 200, 122, 4)
      .fill({ color: 0x141820, alpha: 0.96 })
      .stroke({ color: 0x2d333b, width: 1 });
    this.questTrackerCont.addChild(solidBg);

    try {
      const panelTex = await Assets.load('/assets/ui/quest_tracker_box.png');
      const panelSp = new Sprite(panelTex);
      this.questTrackerCont.addChild(panelSp);
    } catch {
      const fb = new Graphics()
        .roundRect(0, 0, 208, 155, 6)
        .fill({ color: 0x11161f, alpha: 0.92 })
        .stroke({ color: 0xd4af37, width: 1.5 });
      this.questTrackerCont.addChild(fb);
    }

    const titleTxt = new Text({
      text: '📜 [Principal] Rumo à Academia',
      style: new TextStyle({
        fontFamily: 'SimSun, "Microsoft YaHei", sans-serif',
        fontSize: 11,
        fontWeight: 'bold',
        fill: '#ffd700',
        stroke: { color: '#000000', width: 2 }
      })
    });
    titleTxt.position.set(16, 36);
    this.questTrackerCont.addChild(titleTxt);

    const targetCont = new Container();
    targetCont.position.set(16, 60);
    targetCont.eventMode = 'static';
    targetCont.cursor = 'pointer';

    const targetTxt = new Text({
      text: '👉 Fale com Iruka Umino\n    (Clique para auto-caminho)',
      style: new TextStyle({
        fontFamily: 'SimSun, "Microsoft YaHei", sans-serif',
        fontSize: 11,
        fill: '#2ecc71',
        fontWeight: 'bold',
        lineHeight: 16
      })
    });
    targetCont.addChild(targetTxt);

    targetCont.on('pointerenter', () => {
      targetTxt.style.fill = '#f1c40f';
    });
    targetCont.on('pointerleave', () => {
      targetTxt.style.fill = '#2ecc71';
    });
    targetCont.on('pointertap', () => {
      if (this.callbacks.onQuestClick) {
        this.callbacks.onQuestClick('Iruka Umino');
      }
    });
    this.questTrackerCont.addChild(targetCont);

    const rewardTxt = new Text({
      text: '🎁 Recompensa: EXP 1.200 | Ryo 500',
      style: new TextStyle({
        fontSize: 9,
        fontWeight: 'bold',
        fill: '#8b949e'
      })
    });
    rewardTxt.position.set(16, 110);
    this.questTrackerCont.addChild(rewardTxt);
  }

  /* =========================================================================
   * 7. BOTTOM-LEFT: CHATBOX AUTÊNTICO COM BARRA DE MADEIRA FLASH (00000001.swf)
   * ========================================================================= */
  private async buildChatBox(): Promise<void> {
    this.chatBoxCont.position.set(10, 475);

    const chatLogBg = new Graphics()
      .roundRect(0, 0, 295, 126, 4)
      .fill({ color: 0x090d16, alpha: 0.82 })
      .stroke({ color: 0x1f242c, width: 1 });
    this.chatBoxCont.addChild(chatLogBg);

    const channels = ['Todos', 'Mundo', 'Guilda', 'Sistema'];
    for (let i = 0; i < channels.length; i++) {
      const chName = channels[i];
      const tabCont = new Container();
      tabCont.position.set(4 + i * 58, 4);
      tabCont.eventMode = 'static';
      tabCont.cursor = 'pointer';

      const tabBg = new Graphics()
        .roundRect(0, 0, 54, 18, 3)
        .fill(chName === 'Mundo' ? 0x24292e : 0x12161c);
      tabCont.addChild(tabBg);

      const tabTxt = new Text({
        text: chName,
        style: new TextStyle({
          fontSize: 10,
          fontWeight: 'bold',
          fill: chName === 'Mundo' ? '#58a6ff' : '#8b949e'
        })
      });
      tabTxt.anchor.set(0.5, 0.5);
      tabTxt.position.set(27, 9);
      tabCont.addChild(tabTxt);

      tabCont.on('pointertap', () => {
        this.currentChatChannel = chName;
      });
      this.chatBoxCont.addChild(tabCont);
    }

    this.chatMessagesCont = new Container();
    this.chatMessagesCont.position.set(8, 26);
    this.chatBoxCont.addChild(this.chatMessagesCont);

    const inputBarCont = new Container();
    inputBarCont.position.set(0, 130);

    try {
      const barTex = await Assets.load('/assets/ui/chat/chat_input_bar.png');
      const barSprite = new Sprite(barTex);
      barSprite.width = 295;
      inputBarCont.addChild(barSprite);
    } catch {
      const fb = new Graphics()
        .roundRect(0, 0, 295, 30, 4)
        .fill(0x1a1512);
      inputBarCont.addChild(fb);
    }

    try {
      const selTex = await Assets.load('/assets/ui/chat/channel_select_btn.png');
      const selSprite = new Sprite(selTex);
      selSprite.position.set(4, 3);
      inputBarCont.addChild(selSprite);
    } catch {
      // Fallback
    }

    try {
      const emoTex = await Assets.load('/assets/ui/chat/emote_btn.png');
      const emoSprite = new Sprite(emoTex);
      emoSprite.position.set(266, 3);
      emoSprite.eventMode = 'static';
      emoSprite.cursor = 'pointer';
      emoSprite.on('pointertap', () => {
        alert('😄 Menu de Emojis Shinobi');
      });
      inputBarCont.addChild(emoSprite);
    } catch {
      // Fallback
    }

    this.chatBoxCont.addChild(inputBarCont);

    this.addChatMessage('Sistema', '', '🍃 Bem-vindo a Naruto Online! Pressione [B] para a Mochila.');
    this.addChatMessage('Sistema', '', '💡 Clique no mapa ou no NPC da missão para andar livremente.');
    this.addChatMessage('Mundo', 'Naruto', 'Dattebayo! Eu serei o próximo Hokage!');

    this.createDomChatInput();
  }

  private createDomChatInput(): void {
    const input = document.createElement('input');
    input.type = 'text';
    input.placeholder = 'Digite aqui... (Enter)';
    input.style.position = 'absolute';
    input.style.left = '64px';
    input.style.bottom = '18px';
    input.style.width = '200px';
    input.style.height = '20px';
    input.style.padding = '0 6px';
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
      Sistema: '#f1c40f',
      Mundo: '#3498db',
      Guilda: '#2ecc71',
      Todos: '#9b59b6'
    };
    const col = channelColors[channel] || '#ffffff';

    const fullMsg = sender ? `[${channel}] ${sender}: ${text}` : `[${channel}] ${text}`;

    const line = new Text({
      text: fullMsg,
      style: new TextStyle({
        fontFamily: 'SimSun, "Microsoft YaHei", sans-serif',
        fontSize: 10,
        fontWeight: 'bold',
        fill: col,
        wordWrap: true,
        wordWrapWidth: 275,
        stroke: { color: '#000000', width: 2 }
      })
    });

    const msgHeight = 16;
    for (const child of this.chatMessagesCont.children) {
      child.y -= msgHeight;
    }

    line.position.set(0, 85);
    this.chatMessagesCont.addChild(line);

    while (this.chatMessagesCont.children.length > 5) {
      const oldest = this.chatMessagesCont.children[0];
      this.chatMessagesCont.removeChild(oldest);
      oldest.destroy();
    }
  }

  /* =========================================================================
   * 8. MODAIS AUTÊNTICOS (Mochila, Formação 3x3, Personagem)
   * ========================================================================= */
  private async buildModals(): Promise<void> {
    await Promise.all([
      this.buildBackpackModal(),
      this.buildFormationModal(),
      this.buildHeroModal()
    ]);
  }

  private async buildBackpackModal(): Promise<void> {
    this.bagModal = new Container();
    this.bagModal.position.set((1250 - 385) / 2, (650 - 431) / 2);
    this.bagModal.visible = false;

    try {
      const tex = await Assets.load('/assets/ui/modal_bag.png');
      const sp = new Sprite(tex);
      this.bagModal.addChild(sp);
    } catch {
      const fb = new Graphics()
        .roundRect(0, 0, 385, 431, 10)
        .fill({ color: 0x161b22, alpha: 0.95 })
        .stroke({ color: 0xd4af37, width: 2 });
      this.bagModal.addChild(fb);
    }

    // Título
    const title = new Text({
      text: '🎒 Mochila Shinobi',
      style: new TextStyle({ fontSize: 14, fontWeight: 'bold', fill: '#ffd700' })
    });
    title.position.set(20, 14);
    this.bagModal.addChild(title);

    // Botão Fechar Autêntico
    const closeBtn = await this.createCloseButton(() => this.toggleBackpack());
    closeBtn.position.set(348, 12);
    this.bagModal.addChild(closeBtn);

    // Slots de Inventário com Itens Reais
    const items = [
      { name: 'Kunai de Ferro', icon: '/assets/items/item_kunai.png', qty: 25 },
      { name: 'Ramen Ichiraku', icon: '/assets/items/item_ramen_bowl.png', qty: 5 },
      { name: 'Pergaminho de Chakra', icon: '/assets/items/item_chakra_scroll.png', qty: 2 },
      { name: 'Bandana de Konoha', icon: '/assets/items/item_headband.png', qty: 1 },
      { name: 'Colete Chunin', icon: '/assets/items/item_vest.png', qty: 1 },
      { name: 'Sandálias Shinobi', icon: '/assets/items/item_sandals.png', qty: 1 },
      { name: 'Cinto Ninja', icon: '/assets/items/item_belt.png', qty: 1 },
      { name: 'Anel do Selo', icon: '/assets/items/item_ring.png', qty: 1 }
    ];

    const startX = 26;
    const startY = 62;
    const slotSize = 48;
    const spacing = 8;
    const cols = 5;

    for (let i = 0; i < 20; i++) {
      const c = i % cols;
      const r = Math.floor(i / cols);
      const slotX = startX + c * (slotSize + spacing);
      const slotY = startY + r * (slotSize + spacing);

      const slotBg = new Graphics()
        .roundRect(slotX, slotY, slotSize, slotSize, 4)
        .fill({ color: 0x0d1117, alpha: 0.7 })
        .stroke({ color: 0x30363d, width: 1 });
      this.bagModal.addChild(slotBg);

      if (items[i]) {
        try {
          const itemTex = await Assets.load(items[i].icon);
          const itemSp = new Sprite(itemTex);
          itemSp.anchor.set(0.5, 0.5);
          itemSp.position.set(slotX + slotSize / 2, slotY + slotSize / 2);
          itemSp.width = 38;
          itemSp.height = 38;
          itemSp.eventMode = 'static';
          itemSp.cursor = 'pointer';

          itemSp.on('pointertap', () => {
            alert(`📦 Item: ${items[i].name} (Qtd: ${items[i].qty})`);
          });

          this.bagModal.addChild(itemSp);

          const qtyTxt = new Text({
            text: `${items[i].qty}`,
            style: new TextStyle({ fontSize: 9, fontWeight: 'bold', fill: '#ffffff' })
          });
          qtyTxt.position.set(slotX + slotSize - 14, slotY + slotSize - 12);
          this.bagModal.addChild(qtyTxt);
        } catch {
          // Fallback
        }
      }
    }

    this.modalLayer.addChild(this.bagModal);
  }

  private async buildFormationModal(): Promise<void> {
    const w = 720;
    const h = 442;
    this.formationModal = new Container();
    this.formationModal.position.set((1250 - w) / 2, (650 - h) / 2);
    this.formationModal.visible = false;

    try {
      const tex = await Assets.load('/assets/ui/modal_formation.png');
      const sp = new Sprite(tex);
      sp.width = w;
      sp.height = h;
      this.formationModal.addChild(sp);
    } catch {
      const fb = new Graphics()
        .roundRect(0, 0, w, h, 10)
        .fill({ color: 0x161b22, alpha: 0.95 })
        .stroke({ color: 0x388bfd, width: 2 });
      this.formationModal.addChild(fb);
    }

    const title = new Text({
      text: '⚔ Formação & Desdobramento Tático 3x3',
      style: new TextStyle({ fontSize: 15, fontWeight: 'bold', fill: '#ffd700' })
    });
    title.position.set(24, 16);
    this.formationModal.addChild(title);

    const closeBtn = await this.createCloseButton(() => this.toggleFormation());
    closeBtn.position.set(w - 38, 14);
    this.formationModal.addChild(closeBtn);

    // Grid 3x3 Interativo de Formação Tática Oficial
    const gridX = 220;
    const gridY = 90;
    const cellW = 85;
    const cellH = 85;
    const cellSpacing = 14;

    const ninjasOnGrid: Record<number, { name: string; icon: string }> = {
      1: { name: this.profile.name, icon: 'portrait_325.png' },
      4: { name: 'Naruto Uzumaki', icon: 'portrait_329.png' },
      7: { name: 'Sasuke Uchiha', icon: 'portrait_333.png' }
    };

    for (let r = 0; r < 3; r++) {
      for (let c = 0; c < 3; c++) {
        const slotIdx = r * 3 + c + 1;
        const cx = gridX + c * (cellW + cellSpacing);
        const cy = gridY + r * (cellH + cellSpacing);

        const cell = new Graphics()
          .roundRect(cx, cy, cellW, cellH, 6)
          .fill({ color: 0x090d16, alpha: 0.85 })
          .stroke({ color: 0x484f58, width: 2 });
        this.formationModal.addChild(cell);

        const cellNum = new Text({
          text: `#${slotIdx}`,
          style: new TextStyle({ fontSize: 10, fill: '#6e7681' })
        });
        cellNum.position.set(cx + 6, cy + 6);
        this.formationModal.addChild(cellNum);

        if (ninjasOnGrid[slotIdx]) {
          const n = ninjasOnGrid[slotIdx];
          try {
            const pTex = await Assets.load(`/assets/ui/${n.icon}`);
            const pSp = new Sprite(pTex);
            pSp.anchor.set(0.5, 0.5);
            pSp.position.set(cx + cellW / 2, cy + cellH / 2 - 4);
            pSp.width = 46;
            pSp.height = 46;
            this.formationModal.addChild(pSp);

            const nLabel = new Text({
              text: n.name.split(' ')[0],
              style: new TextStyle({ fontSize: 9, fontWeight: 'bold', fill: '#ffd700' })
            });
            nLabel.anchor.set(0.5, 0.5);
            nLabel.position.set(cx + cellW / 2, cy + cellH - 12);
            this.formationModal.addChild(nLabel);
          } catch {
            // Fallback
          }
        }
      }
    }

    this.modalLayer.addChild(this.formationModal);
  }

  private async buildHeroModal(): Promise<void> {
    const w = 688;
    const h = 408;
    this.heroModal = new Container();
    this.heroModal.position.set((1250 - w) / 2, (650 - h) / 2);
    this.heroModal.visible = false;

    try {
      const tex = await Assets.load('/assets/ui/modal_hero.png');
      const sp = new Sprite(tex);
      this.heroModal.addChild(sp);
    } catch {
      const fb = new Graphics()
        .roundRect(0, 0, w, h, 10)
        .fill({ color: 0x161b22, alpha: 0.95 })
        .stroke({ color: 0x2ea44f, width: 2 });
      this.heroModal.addChild(fb);
    }

    const title = new Text({
      text: `👤 Informações Shinobi — ${this.profile.name}`,
      style: new TextStyle({ fontSize: 14, fontWeight: 'bold', fill: '#ffd700' })
    });
    title.position.set(24, 16);
    this.heroModal.addChild(title);

    const closeBtn = await this.createCloseButton(() => this.toggleHero());
    closeBtn.position.set(w - 38, 14);
    this.heroModal.addChild(closeBtn);

    // Atributos de Combate do Ninja
    const stats = [
      { label: 'Vida Máxima (HP):', val: `${this.profile.maxHp}` },
      { label: 'Ataque Físico:', val: '450' },
      { label: 'Defesa Física:', val: '380' },
      { label: 'Ataque Ninjutsu:', val: '520' },
      { label: 'Resistência Ninja:', val: '410' },
      { label: 'Poder de Combate:', val: '3.420' }
    ];

    for (let i = 0; i < stats.length; i++) {
      const s = stats[i];
      const lbl = new Text({
        text: s.label,
        style: new TextStyle({ fontSize: 11, fill: '#8b949e', fontWeight: 'bold' })
      });
      lbl.position.set(380, 80 + i * 26);
      this.heroModal.addChild(lbl);

      const valTxt = new Text({
        text: s.val,
        style: new TextStyle({ fontSize: 11, fill: '#f0f6fc', fontWeight: 'bold' })
      });
      valTxt.position.set(540, 80 + i * 26);
      this.heroModal.addChild(valTxt);
    }

    this.modalLayer.addChild(this.heroModal);
  }

  private async createCloseButton(onClose: () => void): Promise<Container> {
    const btn = new Container();
    btn.eventMode = 'static';
    btn.cursor = 'pointer';

    try {
      const tex = await Assets.load('/assets/ui/btn_close.png');
      const sp = new Sprite(tex);
      sp.width = 24;
      sp.height = 24;
      btn.addChild(sp);
    } catch {
      const fb = new Text({
        text: '✕',
        style: new TextStyle({ fontSize: 18, fill: '#ff6b6b', fontWeight: 'bold' })
      });
      btn.addChild(fb);
    }

    btn.on('pointertap', onClose);
    return btn;
  }

  /* =========================================================================
   * MÉTODOS PÚBLICOS DE CONTROLE E REATIVIDADE
   * ========================================================================= */
  public updateCoordinates(x: number, y: number): void {
    if (this.coordsText) {
      this.coordsText.text = `X: ${Math.round(x)}  Y: ${Math.round(y)}`;
    }
  }

  public updateCityName(name: string): void {
    if (this.cityNameText) {
      this.cityNameText.text = `📍 ${name}`;
    }
  }

  public updateHp(cur: number, max: number): void {
    if (this.hpText) this.hpText.text = `${cur} / ${max}`;
    if (this.hpFill) {
      const pct = Math.max(0, Math.min(1, cur / max));
      this.hpFill.width = 148 * pct;
    }
  }

  public updateCurrencies(silver: number, gold: number): void {
    if (this.silverText) this.silverText.text = silver.toLocaleString();
    if (this.goldText) this.goldText.text = gold.toLocaleString();
  }

  public updateBgmState(isPlaying: boolean): void {
    if (this.bgmLabelText) {
      this.bgmLabelText.text = isPlaying ? '🔊 BGM' : '🔇 MUDO';
    }
  }

  public toggleBackpack(): void {
    if (this.bagModal) {
      this.bagModal.visible = !this.bagModal.visible;
      if (this.bagModal.visible) {
        if (this.formationModal) this.formationModal.visible = false;
        if (this.heroModal) this.heroModal.visible = false;
      }
    }
  }

  public toggleFormation(): void {
    if (this.formationModal) {
      this.formationModal.visible = !this.formationModal.visible;
      if (this.formationModal.visible) {
        if (this.bagModal) this.bagModal.visible = false;
        if (this.heroModal) this.heroModal.visible = false;
      }
    }
  }

  public toggleHero(): void {
    if (this.heroModal) {
      this.heroModal.visible = !this.heroModal.visible;
      if (this.heroModal.visible) {
        if (this.bagModal) this.bagModal.visible = false;
        if (this.formationModal) this.formationModal.visible = false;
      }
    }
  }

  public closeAllModals(): void {
    if (this.bagModal) this.bagModal.visible = false;
    if (this.formationModal) this.formationModal.visible = false;
    if (this.heroModal) this.heroModal.visible = false;
  }

  public override destroy(options?: any): void {
    window.removeEventListener('keydown', this.keyHandler);
    if (this.chatInputDom && this.chatInputDom.parentElement) {
      this.chatInputDom.parentElement.removeChild(this.chatInputDom);
      this.chatInputDom = null;
    }
    super.destroy(options);
  }
}
