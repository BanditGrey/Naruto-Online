import { Container, Graphics, Text, TextStyle, Sprite, Assets, Texture } from 'pixi.js';
import { clientSocket, WebPacketWriter } from '../network/clientSocket.ts';
import { OPCODES } from '../../../shared/opcodes.ts';
import { gameApp, type Scene } from '../core/GameApp.ts';
import { TownScene, type LocalNinjaData } from './TownScene.ts';

export interface DisciplineDef {
  id: number; // 1 = Ninjutsu, 3 = Genjutsu, 4 = Taijutsu
  slotIndex: number;
  name: string;
  tag: string;
  role: string;
  color: number;
  colorHex: string;
  tabPath: string;
  heroMalePath: string;
  heroFemalePath: string;
  thumbMalePath: string;
  thumbFemalePath: string;
  description: string;
  stats: {
    strength: number; // 1 a 5
    agility: number;
    chakra: number;
    defense: number;
  };
}

export const DISCIPLINES: DisciplineDef[] = [
  {
    id: 3, // CONST_CHARACTER.PROFESSION_Intellect
    slotIndex: 0,
    name: 'Genjutsu',
    tag: '🔴 Chakra & Controle Mental',
    role: 'Assalto Mágico • Dano em Área • Apoio',
    color: 0xdc2626,
    colorHex: '#ef4444',
    tabPath: '/assets/create_char/tab_genjutsu.png',
    heroMalePath: '/assets/create_char/hero_genjutsu_m.png',
    heroFemalePath: '/assets/create_char/hero_genjutsu_f.png',
    thumbMalePath: '/assets/create_char/thumb_genjutsu_m.png',
    thumbFemalePath: '/assets/create_char/thumb_genjutsu_f.png',
    description:
      'Mestre supremo em ilusões e controle mental. Canaliza o chakra para desferir jutsus devastadores de longa distância e suprimir grupos inteiros de inimigos.',
    stats: { strength: 2, agility: 3, chakra: 5, defense: 3 },
  },
  {
    id: 4, // CONST_CHARACTER.PROFESSION_Strength
    slotIndex: 1,
    name: 'Taijutsu',
    tag: '🟡 Vanguarda & Vida Máxima',
    role: 'Vanguarda • Tanque Resistente • Dano Físico',
    color: 0xd97706,
    colorHex: '#f59e0b',
    tabPath: '/assets/create_char/tab_taijutsu.png',
    heroMalePath: '/assets/create_char/hero_taijutsu_m.png',
    heroFemalePath: '/assets/create_char/hero_taijutsu_f.png',
    thumbMalePath: '/assets/create_char/thumb_taijutsu_m.png',
    thumbFemalePath: '/assets/create_char/thumb_taijutsu_f.png',
    description:
      'Lutador destemido focado na força muscular, resistência corporal e combate corpo a corpo. Atua como escudo protetor inabalável na linha de frente.',
    stats: { strength: 5, agility: 3, chakra: 2, defense: 5 },
  },
  {
    id: 1, // CONST_CHARACTER.PROFESSION_Agility
    slotIndex: 2,
    name: 'Ninjutsu',
    tag: '🟢 Velocidade & Ataque Crítico',
    role: 'Assalto Ágil • Assassino • Dano Perfurante',
    color: 0x059669,
    colorHex: '#10b981',
    tabPath: '/assets/create_char/tab_ninjutsu.png',
    heroMalePath: '/assets/create_char/hero_ninjutsu_m.png',
    heroFemalePath: '/assets/create_char/hero_ninjutsu_f.png',
    thumbMalePath: '/assets/create_char/thumb_ninjutsu_m.png',
    thumbFemalePath: '/assets/create_char/thumb_ninjutsu_f.png',
    description:
      'Shinobi veloz das sombras armado com lâminas letais e foices. Desfere sequências de golpes perfurantes com alta taxa de acerto crítico e esquiva veloz.',
    stats: { strength: 4, agility: 5, chakra: 4, defense: 2 },
  },
];

const REQUIRED_ASSETS = [
  '/assets/create_char/bg_create.jpg',
  '/assets/create_char/name_bar.png',
  '/assets/create_char/btn_create.png',
  '/assets/create_char/btn_dice.png',
  '/assets/create_char/tab_genjutsu.png',
  '/assets/create_char/tab_taijutsu.png',
  '/assets/create_char/tab_ninjutsu.png',
  '/assets/create_char/hero_genjutsu_m.png',
  '/assets/create_char/hero_genjutsu_f.png',
  '/assets/create_char/hero_taijutsu_m.png',
  '/assets/create_char/hero_taijutsu_f.png',
  '/assets/create_char/hero_ninjutsu_m.png',
  '/assets/create_char/hero_ninjutsu_f.png',
  '/assets/create_char/thumb_genjutsu_m.png',
  '/assets/create_char/thumb_genjutsu_f.png',
  '/assets/create_char/thumb_taijutsu_m.png',
  '/assets/create_char/thumb_taijutsu_f.png',
  '/assets/create_char/thumb_ninjutsu_m.png',
  '/assets/create_char/thumb_ninjutsu_f.png',
];

const RANDOM_NAMES = [
  'Ryu_Hatake', 'Kaito_Hyuga', 'Shin_Uchiha', 'Ren_Sarutobi', 'Hayate_Nara',
  'Kenji_Aburame', 'Daiki_Akimichi', 'Sora_Inuzuka', 'Yuto_Senju', 'Kazuki_Kazekage',
  'Minato_Namikaze', 'Kenshin_Uzumaki', 'Riku_Momochi', 'Tatsuya_Hozuki', 'Kotaro_Fuma',
  'Sayuri_Yamanaka', 'Ayumi_Haruno', 'Mei_Terumi', 'Karin_Uzumaki', 'Hanabi_Hyuga'
];

function getUniqueRandomName(): string {
  const base = RANDOM_NAMES[Math.floor(Math.random() * RANDOM_NAMES.length)];
  const num = Math.floor(Math.random() * 899 + 100);
  return `${base}_${num}`;
}

/**
 * Tela Oficial de Criação de Personagens (CreateRoleScene)
 * 3 Disciplinas Ninjas (Genjutsu, Taijutsu, Ninjutsu) x 2 Gêneros = 6 Protagonistas Canônicos
 * Resolução Canônica: 1250 x 650
 */
export class CreateRoleScene extends Container implements Scene {
  private selectedProfessionId: number = 3; // Padrão: Genjutsu (Slot 0)
  private selectedGender: number = 1; // 1 = Masculino, 0 = Feminino
  private currentNinjaName: string = '';

  // Elementos Visuais
  private bgSprite!: Sprite;
  private classCards: Container[] = [];
  private tabSprites: Sprite[] = [];
  private heroPreviewContainer!: Container;
  private heroSprite!: Sprite;
  private btnMale!: Container;
  private btnFemale!: Container;
  private nameBarSprite!: Sprite;
  private diceIconSprite!: Sprite;
  private txtNameInput!: Text;
  private txtStatusMessage!: Text;
  private btnConfirm!: Container;
  private infoPanelContainer!: Container;

  private localNinja: LocalNinjaData | null = null;
  private assetsLoaded: boolean = false;
  private unsubs: (() => void)[] = [];

  constructor() {
    super();
    this.currentNinjaName = getUniqueRandomName();
    this.setupVisuals();
    this.registerNetworkEvents();

    // Inicia carregamento assíncrono proativo
    this.loadAllAssets().then(() => {
      this.refreshAllTextures();
    });
  }

  public async init(): Promise<void> {
    await this.loadAllAssets();
    this.refreshAllTextures();
  }

  private async loadAllAssets(): Promise<void> {
    if (this.assetsLoaded) return;
    try {
      console.log('[CreateRoleScene] Carregando texturas de criação de personagem...');
      await Promise.all(
        REQUIRED_ASSETS.map((url) =>
          Assets.load(url).catch((err) =>
            console.warn(`[CreateRoleScene] Falha ao carregar textura: ${url}`, err)
          )
        )
      );
      this.assetsLoaded = true;
      console.log('[CreateRoleScene] Todas as texturas foram carregadas com sucesso!');
    } catch (e) {
      console.error('[CreateRoleScene] Erro ao carregar pacote de assets:', e);
    }
  }

  private setupVisuals(): void {
    const W = 1250;
    const H = 650;

    // 1. Cenário de Fundo Oficial (bg_create.jpg de 01000000/1.jpg)
    const initialBgTex = Assets.get('/assets/create_char/bg_create.jpg') || Texture.EMPTY;
    this.bgSprite = new Sprite(initialBgTex);
    if (initialBgTex.width > 0) {
      this.bgSprite.scale.set(1, 1);
      this.bgSprite.width = W;
      this.bgSprite.height = H;
    }
    this.addChild(this.bgSprite);

    // Overlay escuro com transparência suave (0.28) para valorizar a cena de fundo
    const overlay = new Graphics();
    overlay.rect(0, 0, W, H);
    overlay.fill({ color: 0x050811, alpha: 0.28 });
    this.addChild(overlay);

    // 2. Título Superior Estilizado
    const titleStyle = new TextStyle({
      fontFamily: 'Segoe UI, sans-serif',
      fontSize: 26,
      fontWeight: 'bold',
      fill: '#fbbf24',
      stroke: { color: '#000000', width: 4 },
      dropShadow: { color: '#000000', blur: 8, distance: 3 },
      letterSpacing: 2,
    });
    const headerTitle = new Text({ text: '⚔️ ESCOLHA SEU CAMINHO SHINOBI ⚔️', style: titleStyle });
    headerTitle.anchor.set(0.5, 0);
    headerTitle.position.set(W / 2, 18);
    this.addChild(headerTitle);

    const headerSub = new Text({
      text: 'Selecione sua disciplina ninja e personalize seu herói para ingressar em Konohagakure',
      style: { fill: '#cbd5e1', fontSize: 13, stroke: { color: '#000000', width: 2 } },
    });
    headerSub.anchor.set(0.5, 0);
    headerSub.position.set(W / 2, 52);
    this.addChild(headerSub);

    // 3. Coluna Esquerda: Seletor das 3 Disciplinas Ninjas
    this.setupDisciplineList();

    // 4. Centro: Destaque do Protagonista com Efeitos Visuais
    this.setupHeroDisplay();

    // 5. Coluna Direita: Seletor de Gênero, Atributos, Input do Nome e Botão Criar
    this.setupRightPanel();

    // Atualização inicial
    this.updateAll();
  }

  /**
   * Coluna Esquerda: Lista das 3 Disciplinas Ninjas (Genjutsu, Taijutsu, Ninjutsu)
   */
  private setupDisciplineList(): void {
    const listContainer = new Container();
    listContainer.position.set(40, 85);
    this.addChild(listContainer);

    DISCIPLINES.forEach((disc, idx) => {
      const card = new Container();
      card.position.set(0, idx * 175);
      card.eventMode = 'static';
      card.cursor = 'pointer';

      // Fundo estilizado do Card
      const bg = new Graphics();
      card.addChild(bg);

      // Scroll / Vórtice Elemental da Disciplina (tab_genjutsu, tab_taijutsu, tab_ninjutsu)
      const tabTex = Assets.get(disc.tabPath) || Texture.EMPTY;
      const tabSprite = new Sprite(tabTex);
      if (tabTex.width > 0) {
        tabSprite.scale.set(1, 1);
        tabSprite.width = 44;
        tabSprite.height = 140;
      }
      tabSprite.position.set(16, 17);
      card.addChild(tabSprite);
      this.tabSprites.push(tabSprite);

      // Nome da Disciplina
      const txtTitle = new Text({
        text: disc.name,
        style: {
          fill: disc.colorHex,
          fontSize: 22,
          fontWeight: 'bold',
          stroke: { color: '#000000', width: 3 },
          letterSpacing: 1,
        },
      });
      txtTitle.position.set(72, 20);
      card.addChild(txtTitle);

      // Tag e Papel Tático
      const txtTag = new Text({
        text: disc.tag,
        style: { fill: '#e2e8f0', fontSize: 12, fontWeight: 'bold' },
      });
      txtTag.position.set(72, 50);
      card.addChild(txtTag);

      const txtRole = new Text({
        text: disc.role,
        style: { fill: '#94a3b8', fontSize: 11, fontStyle: 'italic' },
      });
      txtRole.position.set(72, 72);
      card.addChild(txtRole);

      // Descrição resumida
      const txtDesc = new Text({
        text: disc.description,
        style: {
          fill: '#cbd5e1',
          fontSize: 11,
          wordWrap: true,
          wordWrapWidth: 230,
          lineHeight: 15,
        },
      });
      txtDesc.position.set(72, 94);
      card.addChild(txtDesc);

      // Eventos de clique e hover
      card.on('pointertap', () => {
        if (this.selectedProfessionId !== disc.id) {
          this.selectedProfessionId = disc.id;
          this.updateAll();
        }
      });

      card.on('pointerenter', () => {
        if (this.selectedProfessionId !== disc.id) {
          this.drawDisciplineCard(bg, disc, false, true);
        }
      });

      card.on('pointerleave', () => {
        if (this.selectedProfessionId !== disc.id) {
          this.drawDisciplineCard(bg, disc, false, false);
        }
      });

      this.classCards.push(card);
      listContainer.addChild(card);
    });
  }

  private drawDisciplineCard(
    graphics: Graphics,
    disc: DisciplineDef,
    isSelected: boolean,
    isHover: boolean = false
  ): void {
    graphics.clear();

    const w = 320;
    const h = 162;
    const radius = 8;

    if (isSelected) {
      graphics.roundRect(0, 0, w, h, radius);
      graphics.fill({ color: 0x111827, alpha: 0.92 });
      graphics.stroke({ color: disc.color, width: 2.5 });

      // Brilho no topo do card selecionado
      graphics.roundRect(2, 2, w - 4, 6, radius);
      graphics.fill({ color: disc.color, alpha: 0.45 });
    } else if (isHover) {
      graphics.roundRect(0, 0, w, h, radius);
      graphics.fill({ color: 0x1f2937, alpha: 0.85 });
      graphics.stroke({ color: 0x475569, width: 1.5 });
    } else {
      graphics.roundRect(0, 0, w, h, radius);
      graphics.fill({ color: 0x0f172a, alpha: 0.75 });
      graphics.stroke({ color: 0x334155, width: 1 });
    }
  }

  /**
   * Centro: Ilustração em Destaque do Protagonista
   */
  private setupHeroDisplay(): void {
    this.heroPreviewContainer = new Container();
    this.heroPreviewContainer.position.set(575, 335);
    this.addChild(this.heroPreviewContainer);

    // Sombra elíptica aos pés do personagem
    const shadow = new Graphics();
    shadow.ellipse(0, 245, 130, 20);
    shadow.fill({ color: 0x000000, alpha: 0.65 });
    this.heroPreviewContainer.addChild(shadow);

    // Sprite do herói ativo (anchor nos pés)
    this.heroSprite = new Sprite(Texture.EMPTY);
    this.heroSprite.anchor.set(0.5, 1);
    this.heroSprite.position.set(0, 245);
    this.heroPreviewContainer.addChild(this.heroSprite);
  }

  /**
   * Coluna Direita: Gênero, Atributos, Input de Nome e Botão Iniciar
   */
  private setupRightPanel(): void {
    this.infoPanelContainer = new Container();
    this.infoPanelContainer.position.set(800, 85);
    this.addChild(this.infoPanelContainer);

    // 1. Caixa de Fundo do Painel Direito
    const panelBg = new Graphics();
    panelBg.roundRect(0, 0, 410, 525, 10);
    panelBg.fill({ color: 0x090d16, alpha: 0.88 });
    panelBg.stroke({ color: 0x334155, width: 1.5 });
    this.infoPanelContainer.addChild(panelBg);

    // 2. Seletor de Gênero (Masculino / Feminino)
    const txtGenderLabel = new Text({
      text: 'GÊNERO DO NINJA:',
      style: { fill: '#94a3b8', fontSize: 12, fontWeight: 'bold', letterSpacing: 1 },
    });
    txtGenderLabel.position.set(24, 20);
    this.infoPanelContainer.addChild(txtGenderLabel);

    // Botão Masculino
    this.btnMale = this.createGenderButton('♂ MASCULINO (1)', 1, 24, 44, 175, 42);
    this.infoPanelContainer.addChild(this.btnMale);

    // Botão Feminino
    this.btnFemale = this.createGenderButton('♀ FEMININO (0)', 0, 211, 44, 175, 42);
    this.infoPanelContainer.addChild(this.btnFemale);

    // 3. Painel de Atributos da Disciplina
    this.setupAttributesPanel();

    // 4. Barra de Nome do Ninja com Fundo de Sumi-ê (name_bar.png)
    const txtNameLabel = new Text({
      text: 'NOME DO SHINOBI:',
      style: { fill: '#94a3b8', fontSize: 12, fontWeight: 'bold', letterSpacing: 1 },
    });
    txtNameLabel.position.set(24, 305);
    this.infoPanelContainer.addChild(txtNameLabel);

    // Moldura da barra de nome
    const nameBarContainer = new Container();
    nameBarContainer.position.set(24, 330);
    nameBarContainer.eventMode = 'static';
    nameBarContainer.cursor = 'text';

    const initialNameBarTex = Assets.get('/assets/create_char/name_bar.png') || Texture.EMPTY;
    this.nameBarSprite = new Sprite(initialNameBarTex);
    if (initialNameBarTex.width > 0) {
      this.nameBarSprite.scale.set(1, 1);
      this.nameBarSprite.width = 305;
      this.nameBarSprite.height = 44;
    }
    nameBarContainer.addChild(this.nameBarSprite);

    this.txtNameInput = new Text({
      text: this.currentNinjaName,
      style: {
        fill: '#fbbf24',
        fontSize: 15,
        fontWeight: 'bold',
        stroke: { color: '#000000', width: 2 },
      },
    });
    this.txtNameInput.anchor.set(0.5);
    this.txtNameInput.position.set(305 / 2, 22);
    nameBarContainer.addChild(this.txtNameInput);

    nameBarContainer.on('pointertap', () => {
      this.promptForName();
    });
    this.infoPanelContainer.addChild(nameBarContainer);

    // Botão de Dado 🎲 (btn_dice.png)
    const btnDice = new Container();
    btnDice.position.set(340, 330);
    btnDice.eventMode = 'static';
    btnDice.cursor = 'pointer';

    const diceBg = new Graphics();
    diceBg.roundRect(0, 0, 46, 44, 6);
    diceBg.fill(0x1e293b);
    diceBg.stroke({ color: 0xf59e0b, width: 1.5 });
    btnDice.addChild(diceBg);

    const initialDiceTex = Assets.get('/assets/create_char/btn_dice.png') || Texture.EMPTY;
    this.diceIconSprite = new Sprite(initialDiceTex);
    if (initialDiceTex.width > 0) {
      this.diceIconSprite.scale.set(1, 1);
      this.diceIconSprite.width = 24;
      this.diceIconSprite.height = 26;
    }
    this.diceIconSprite.anchor.set(0.5);
    this.diceIconSprite.position.set(23, 22);
    btnDice.addChild(this.diceIconSprite);

    btnDice.on('pointertap', () => {
      this.currentNinjaName = getUniqueRandomName();
      this.txtNameInput.text = this.currentNinjaName;
    });
    this.infoPanelContainer.addChild(btnDice);

    // Mensagem de Status
    this.txtStatusMessage = new Text({
      text: 'Clique no nome para editar ou no dado para sortear.',
      style: { fill: '#64748b', fontSize: 11 },
    });
    this.txtStatusMessage.position.set(24, 385);
    this.infoPanelContainer.addChild(this.txtStatusMessage);

    // 5. Botão "CRIAR PERSONAGEM"
    this.btnConfirm = new Container();
    this.btnConfirm.position.set(24, 425);
    this.btnConfirm.eventMode = 'static';
    this.btnConfirm.cursor = 'pointer';

    const btnBg = new Graphics();
    btnBg.roundRect(0, 0, 362, 60, 8);
    btnBg.fill(0x15803d);
    btnBg.stroke({ color: 0x4ade80, width: 2 });
    this.btnConfirm.addChild(btnBg);

    const btnText = new Text({
      text: '⚡ INICIAR JORNADA SHINOBI ⚡',
      style: {
        fill: '#ffffff',
        fontSize: 16,
        fontWeight: 'bold',
        stroke: { color: '#000000', width: 4 },
        letterSpacing: 1.5,
      },
    });
    btnText.anchor.set(0.5);
    btnText.position.set(362 / 2, 30);
    this.btnConfirm.addChild(btnText);

    this.btnConfirm.on('pointerenter', () => {
      btnBg.clear();
      btnBg.roundRect(0, 0, 362, 60, 8);
      btnBg.fill(0x16a34a);
      btnBg.stroke({ color: 0x86efac, width: 2.5 });
    });

    this.btnConfirm.on('pointerleave', () => {
      btnBg.clear();
      btnBg.roundRect(0, 0, 362, 60, 8);
      btnBg.fill(0x15803d);
      btnBg.stroke({ color: 0x4ade80, width: 2 });
    });

    this.btnConfirm.on('pointertap', () => {
      this.doCreateChar();
    });

    this.infoPanelContainer.addChild(this.btnConfirm);
  }

  private createGenderButton(
    label: string,
    genderVal: number,
    x: number,
    y: number,
    w: number,
    h: number
  ): Container {
    const btn = new Container();
    btn.position.set(x, y);
    btn.eventMode = 'static';
    btn.cursor = 'pointer';

    const bg = new Graphics();
    btn.addChild(bg);

    const txt = new Text({
      text: label,
      style: { fill: '#ffffff', fontSize: 13, fontWeight: 'bold' },
    });
    txt.anchor.set(0.5);
    txt.position.set(w / 2, h / 2);
    btn.addChild(txt);

    btn.on('pointertap', () => {
      if (this.selectedGender !== genderVal) {
        this.selectedGender = genderVal;
        this.updateAll();
      }
    });

    return btn;
  }

  private updateGenderButtons(): void {
    const drawBtn = (btn: Container, isSelected: boolean, activeColor: number) => {
      const bg = btn.getChildAt(0) as Graphics;
      bg.clear();
      if (isSelected) {
        bg.roundRect(0, 0, 175, 42, 6);
        bg.fill({ color: activeColor, alpha: 0.9 });
        bg.stroke({ color: '#fbbf24', width: 2 });
      } else {
        bg.roundRect(0, 0, 175, 42, 6);
        bg.fill({ color: 0x1e293b, alpha: 0.7 });
        bg.stroke({ color: 0x475569, width: 1 });
      }
    };

    drawBtn(this.btnMale, this.selectedGender === 1, 0x1d4ed8);
    drawBtn(this.btnFemale, this.selectedGender === 0, 0xbe185d);
  }

  private setupAttributesPanel(): void {
    const attrContainer = new Container();
    attrContainer.label = 'attrContainer';
    attrContainer.position.set(24, 105);
    this.infoPanelContainer.addChild(attrContainer);
  }

  private renderAttributes(): void {
    const disc = DISCIPLINES.find((d) => d.id === this.selectedProfessionId)!;
    const container = this.infoPanelContainer.getChildByLabel('attrContainer') as Container;
    if (!container) return;
    container.removeChildren();

    const title = new Text({
      text: `ATRIBUTOS DE COMBATE — ${disc.name.toUpperCase()}`,
      style: { fill: disc.colorHex, fontSize: 12, fontWeight: 'bold', letterSpacing: 1 },
    });
    title.position.set(0, 0);
    container.addChild(title);

    const statsList = [
      { label: 'Força Física (Taijutsu)', val: disc.stats.strength, color: 0xf59e0b },
      { label: 'Agilidade / Crítico (Ninjutsu)', val: disc.stats.agility, color: 0x10b981 },
      { label: 'Chakra & Dano Mágico (Genjutsu)', val: disc.stats.chakra, color: 0x38bdf8 },
      { label: 'Resistência & Defesa', val: disc.stats.defense, color: 0xa855f7 },
    ];

    statsList.forEach((stat, idx) => {
      const y = 26 + idx * 40;

      const txtLabel = new Text({
        text: stat.label,
        style: { fill: '#cbd5e1', fontSize: 11, fontWeight: '600' },
      });
      txtLabel.position.set(0, y);
      container.addChild(txtLabel);

      // Fundo da Barra
      const barBg = new Graphics();
      barBg.roundRect(0, y + 16, 362, 10, 5);
      barBg.fill(0x1e293b);
      container.addChild(barBg);

      // Barra Preenchida
      const barFill = new Graphics();
      const fillW = (362 * stat.val) / 5;
      barFill.roundRect(0, y + 16, fillW, 10, 5);
      barFill.fill(stat.color);
      container.addChild(barFill);

      // Indicador Numérico
      const txtVal = new Text({
        text: `${stat.val} / 5`,
        style: { fill: '#94a3b8', fontSize: 10, fontWeight: 'bold' },
      });
      txtVal.anchor.set(1, 0);
      txtVal.position.set(362, y);
      container.addChild(txtVal);
    });
  }

  /**
   * Atualiza as texturas reais de todos os sprites assim que o download terminar
   */
  public refreshAllTextures(): void {
    // 1. Fundo Oficial
    const bgTex = Assets.get('/assets/create_char/bg_create.jpg');
    if (bgTex && bgTex.width > 0 && this.bgSprite) {
      this.bgSprite.texture = bgTex;
      this.bgSprite.scale.set(1, 1);
      this.bgSprite.width = 1250;
      this.bgSprite.height = 650;
    }

    // 2. Vórtices das Disciplinas
    DISCIPLINES.forEach((disc, idx) => {
      const tabTex = Assets.get(disc.tabPath);
      if (tabTex && tabTex.width > 0 && this.tabSprites[idx]) {
        this.tabSprites[idx].texture = tabTex;
        this.tabSprites[idx].scale.set(1, 1);
        this.tabSprites[idx].width = 44;
        this.tabSprites[idx].height = 140;
      }
    });

    // 3. Barra de Nome e Dado
    const nameBarTex = Assets.get('/assets/create_char/name_bar.png');
    if (nameBarTex && nameBarTex.width > 0 && this.nameBarSprite) {
      this.nameBarSprite.texture = nameBarTex;
      this.nameBarSprite.scale.set(1, 1);
      this.nameBarSprite.width = 305;
      this.nameBarSprite.height = 44;
    }

    const diceTex = Assets.get('/assets/create_char/btn_dice.png');
    if (diceTex && diceTex.width > 0 && this.diceIconSprite) {
      this.diceIconSprite.texture = diceTex;
      this.diceIconSprite.scale.set(1, 1);
      this.diceIconSprite.width = 24;
      this.diceIconSprite.height = 26;
    }

    // 4. Ilustração do Herói Ativo
    this.updateHeroDisplay();
  }

  /**
   * Atualiza a ilustração central com base na combinação (profissão, gênero)
   */
  private updateHeroDisplay(): void {
    const disc = DISCIPLINES.find((d) => d.id === this.selectedProfessionId)!;
    const heroPath = this.selectedGender === 1 ? disc.heroMalePath : disc.heroFemalePath;

    const tex = Assets.get(heroPath);
    if (tex && tex.width > 0 && this.heroSprite) {
      this.heroSprite.texture = tex;
      this.heroSprite.scale.set(1, 1);
      const targetHeight = 440;
      const aspect = tex.width / tex.height;
      this.heroSprite.height = targetHeight;
      this.heroSprite.width = targetHeight * aspect;
      this.heroSprite.visible = true;
    }
  }

  private updateAll(): void {
    // 1. Atualiza Cards das 3 Disciplinas
    DISCIPLINES.forEach((disc, idx) => {
      const card = this.classCards[idx];
      const bg = card.getChildAt(0) as Graphics;
      const isSelected = disc.id === this.selectedProfessionId;
      this.drawDisciplineCard(bg, disc, isSelected, false);
    });

    // 2. Atualiza Botões de Gênero
    this.updateGenderButtons();

    // 3. Atualiza Ilustração Central
    this.updateHeroDisplay();

    // 4. Atualiza Atributos
    this.renderAttributes();
  }

  private promptForName(): void {
    const input = window.prompt(
      'Digite o nome do seu ninja Shinobi (1 a 16 caracteres):',
      this.currentNinjaName
    );
    if (input && input.trim().length > 0) {
      this.currentNinjaName = input.trim().slice(0, 16);
      this.txtNameInput.text = this.currentNinjaName;
    }
  }

  public doCreateChar(): void {
    const name = this.currentNinjaName.trim();
    if (!name) {
      this.txtStatusMessage.text = '⚠️ Digite um nome válido para seu ninja!';
      this.txtStatusMessage.style.fill = '#ef4444';
      return;
    }

    const disc = DISCIPLINES.find((d) => d.id === this.selectedProfessionId)!;
    const genderStr = this.selectedGender === 1 ? 'Masculino' : 'Feminino';

    this.txtStatusMessage.text = `Criando '${name}' (${disc.name} ${genderStr})...`;
    this.txtStatusMessage.style.fill = '#38bdf8';

    console.log(
      `[CreateRoleScene] Despachando CS_CREATECHAR_CreateChar: Nome="${name}", Profissão=${this.selectedProfessionId}, Gênero=${this.selectedGender}`
    );

    const pw = new WebPacketWriter();
    pw.writeStringUTF(name);
    pw.writeByte(this.selectedProfessionId);
    pw.writeByte(this.selectedGender);
    clientSocket.send(OPCODES.CS_CREATECHAR_CreateChar, pw);
  }

  private registerNetworkEvents(): void {
    this.unsubs.push(
      clientSocket.on(OPCODES.SC_CREATECHAR_CreateCharRet, (reader) => {
        const code = reader.readUnsignedInt();
        if (code === 0) {
          this.txtStatusMessage.text = '✅ Personagem criado com sucesso! Ingressando na Vila da Folha...';
          this.txtStatusMessage.style.fill = '#4ade80';
        } else {
          this.txtStatusMessage.text = `❌ Erro ao criar personagem (Código de erro: ${code})`;
          this.txtStatusMessage.style.fill = '#ef4444';
        }
      })
    );

    this.unsubs.push(
      clientSocket.on(OPCODES.SC_Account_CharInfoNtf, (reader) => {
        reader.readUnsignedInt(); // operator
        reader.readUnsignedInt(); // serverId
        reader.readStringUTF(); // userId
        reader.readUnsignedInt(); // guidHigh
        const charId = reader.readUnsignedInt();
        const nickName = reader.readStringUTF();
        reader.readUnsignedInt(); // Country
        reader.readUnsignedInt(); // MilitaryRank
        reader.readUnsignedInt(); // Prestige
        reader.readUnsignedInt(); // Silver High
        reader.readUnsignedInt(); // Silver Low
        reader.readUnsignedInt(); // Gold

        this.localNinja = {
          charId,
          name: nickName,
          profession: this.selectedProfessionId,
          gender: this.selectedGender,
          level: 1,
        };

        console.log(
          `[CreateRoleScene] Novo ninja salvo com sucesso: ${nickName} (#${charId}). Enviando CS_LOBBY_Enter_Town...`
        );
        const pw = new WebPacketWriter();
        clientSocket.send(OPCODES.CS_LOBBY_Enter_Town, pw);
      })
    );

    this.unsubs.push(
      clientSocket.on(OPCODES.SC_Enter_Town, (reader) => {
        const mapId = reader.readUInt32();
        const x = reader.readUInt16();
        const y = reader.readUInt16();
        console.log(`[CreateRoleScene] Entrando em Konohagakure (Mapa #${mapId}, Spawn: ${x}, ${y})`);

        if (this.localNinja) {
          gameApp.changeScene(new TownScene(this.localNinja, x, y));
        }
      })
    );
  }

  public override destroy(options?: any): void {
    this.unsubs.forEach((u) => u());
    this.unsubs = [];
    super.destroy(options);
  }
}
