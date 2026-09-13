import { Container, Sprite, Assets, Text, TextStyle, Graphics, Ticker } from 'pixi.js';
import { NetworkClient } from '../network/NetworkClient.js';
import { PacketWriter } from '../network/PacketWriter.js';
import { Opcodes } from '../protocol/opcodes.js';

interface ScrollSlot {
  profession: number; // 3 = Genjutsu, 4 = Taijutsu, 1 = Ninjutsu
  title: string;
  badgeLine1: string;
  badgeLine2: string;
  desc: string;
  color: string;
  x: number;
  y: number;
  w: number;
  h: number;
  badgeAsset: string;
}

export class CreateRoleScene extends Container {
  // Padrão canônico original (TProcessorCreateRole.as): FProfession = 4 (Taijutsu), FGender = 1 (Male)
  private selectedProfession: number = 4;
  private selectedGender: number = 1; // 1 = Masculino, 0 = Feminino
  private currentName: string = '';

  // Sprites dos 3 Pergaminhos Base Sépias
  private baseScrollSprites: Map<number, Sprite> = new Map();

  // Títulos no topo dos pergaminhos inativos (Genjutsu, Taijutsu, Ninjutsu)
  private unselectedTitles: Map<number, Text> = new Map();

  // Sprites dos Heróis em Cor Total (Apenas o selecionado fica visível!)
  private heroSprites: Map<string, Sprite> = new Map();

  // Insígnias circulares de tinta originais no topo-esquerdo do pergaminho ativo (80x80)
  private badgeSprites: Map<number, Sprite> = new Map();

  // Conteiner de destaque do pergaminho ativo (Badge circular + Texto de descrição)
  private activeBadgeContainer!: Container;
  private activeTitleLine1!: Text;
  private activeTitleLine2!: Text;
  private activeDescText!: Text;

  // Efeito de raios / chakra relâmpago ao redor do herói selecionado
  private lightningGraphics!: Graphics;
  private tickerCallback!: () => void;

  // Seletor de Gênero original 1:1 ("Masculino" e "Feminino" em texto puro estilizado)
  private genderContainer!: Container;
  private txtMale!: Text;
  private txtFemale!: Text;

  // Barra de Nome Oficial (name_bar) e Input Direto na Tela
  private nameBarContainer!: Container;
  private htmlNameInput: HTMLInputElement | null = null;
  private diceSprite!: Sprite;

  // Botão Confirmar ("Iniciar Jogo")
  private btnConfirmContainer!: Container;
  private btnConfirmSprite!: Sprite;

  // Letreiro de Avisos Ninja Flutuante no cenário à direita
  private announcementTicker!: Text;
  private announcementLines: string[] = [
    'Uzumaki Naruto entrou no jogo',
    'Uchiha Sasuke entrou no jogo',
    'Haruno Sakura entrou no jogo',
    'Hatake Kakashi entrou no jogo',
    'Hyuga Hinata entrou no jogo',
    'Rock Lee entrou no jogo'
  ];
  private tickerInterval: any;

  // Nomes autênticos canônicos de TRandomName.as
  private surnames: string[] = [
    'Uzumaki', 'Uchiha', 'Hatake', 'Sarutobi', 'Hyuga',
    'Nara', 'Akimichi', 'Yamanaka', 'Inuzuka', 'Aburame',
    'Senju', 'Kazekage', 'Hozuki', 'Momochi', 'Terumi'
  ];
  private maleNames: string[] = [
    'Kaito', 'Ren', 'Shin', 'Ryu', 'Kenji',
    'Hayate', 'Daiki', 'Sora', 'Yuto', 'Kenshin'
  ];
  private femaleNames: string[] = [
    'Sayuri', 'Ayumi', 'Mei', 'Karin', 'Hanabi',
    'Hinata', 'Sakura', 'Tenten', 'Ino', 'Temari'
  ];

  /**
   * Posições matemáticas exatas extraídas de 01000000.swf (tx + 48, ty + 27)
   * Encaixam milimetricamente nas molduras de madeira de bg_create.jpg:
   * - Genjutsu: X = 283, Y = 72
   * - Taijutsu: X = 523, Y = 72
   * - Ninjutsu: X = 781, Y = 72
   */
  private readonly scrollSlots: ScrollSlot[] = [
    {
      profession: 3, // Genjutsu
      title: 'Genjutsu',
      badgeLine1: 'Gen',
      badgeLine2: 'jutsu',
      desc: 'Ninja especialista em ilusões e paralisia. Controle tático e debuffs.',
      color: '#ff3388',
      x: 283,
      y: 72,
      w: 197,
      h: 368,
      badgeAsset: '/assets/create_char/badge_vortex_genjutsu.png'
    },
    {
      profession: 4, // Taijutsu
      title: 'Taijutsu',
      badgeLine1: 'Tai',
      badgeLine2: 'jutsu',
      desc: 'Ninja de combate físico direto. Mestre em Taijutsu e golpes velozes.',
      color: '#ffd700',
      x: 523,
      y: 72,
      w: 197,
      h: 368,
      badgeAsset: '/assets/create_char/badge_vortex_taijutsu.png'
    },
    {
      profession: 1, // Ninjutsu
      title: 'Ninjutsu',
      badgeLine1: 'Nin',
      badgeLine2: 'jutsu',
      desc: 'Ninja mestre na manipulação de Chakra. Ataques elementais de área.',
      color: '#00e676',
      x: 781,
      y: 72,
      w: 197,
      h: 368,
      badgeAsset: '/assets/create_char/badge_vortex_ninjutsu.png'
    }
  ];

  constructor() {
    super();
    this.currentName = this.generateRandomName();
    this.init();
  }

  private async init(): Promise<void> {
    // 1. Cenário de Fundo Oficial (bg_create.jpg de 01000000.swf)
    const bgTex = await Assets.load('/assets/create_char/bg_create.jpg');
    const bg = new Sprite(bgTex);
    bg.width = 1250;
    bg.height = 650;
    this.addChild(bg);

    // 2. Os 3 Pergaminhos Base Sépias (Encaixados perfeitamente nas molduras do fundo)
    await this.createBaseScrolls();

    // 3. Os Heróis Coloridos (Renderizados na camada frontal dos pergaminhos)
    await this.createFullColorHeroes();

    // 4. Efeito de Raios / Chakra Relâmpago animado ao redor do herói selecionado
    this.createLightningEffect();

    // 5. Insígnia Circular de Vórtice no topo-esquerdo do pergaminho ativo e Descrição
    await this.createActiveProfessionBadge();

    // 6. Seletor de Gênero autêntico em Português ("Masculino" e "Feminino")
    this.createGenderControls();

    // 7. Barra de Nome Oficial ("Nome:") e Input Direto na Tela (dentro do entalhe preto!)
    await this.createNameBar();

    // 8. Botão Confirmar ("Iniciar Jogo")
    await this.createConfirmButton();

    // 9. Letreiro de Avisos Flutuante no lado direito
    this.createAnnouncementTicker();

    // Atualizar estado inicial
    this.updateSelection();
  }

  /**
   * Renderiza os 3 pergaminhos de fundo com arte sépia original perfeitamente alinhada
   */
  private async createBaseScrolls(): Promise<void> {
    for (const slot of this.scrollSlots) {
      const scrollContainer = new Container();
      scrollContainer.position.set(slot.x, slot.y);
      scrollContainer.eventMode = 'static';
      scrollContainer.cursor = 'pointer';

      // Sprite sépia do pergaminho
      const sprite = new Sprite();
      sprite.width = slot.w;
      sprite.height = slot.h;
      scrollContainer.addChild(sprite);
      this.baseScrollSprites.set(slot.profession, sprite);

      // Título de linha única no topo quando inativo (ex: "Genjutsu", "Taijutsu", "Ninjutsu")
      const title = new Text({
        text: slot.title,
        style: new TextStyle({
          fontFamily: 'Acme, Arial Black, sans-serif',
          fontSize: 22,
          fontWeight: 'bold',
          align: 'center',
          fill: slot.color,
          stroke: { color: '#000000', width: 3.5 },
          dropShadow: {
            color: '#000000',
            blur: 4,
            distance: 2
          }
        })
      });
      title.anchor.set(0.5, 0);
      title.position.set(slot.w / 2, 16);
      scrollContainer.addChild(title);
      this.unselectedTitles.set(slot.profession, title);

      // Clicar no pergaminho seleciona a disciplina
      scrollContainer.on('pointerdown', () => {
        this.selectedProfession = slot.profession;
        this.updateSelection();
      });

      this.addChild(scrollContainer);
    }
  }

  /**
   * Modelos coloridos dos heróis oficiais VN exibidos no pergaminho ativo com alinhamento 1:1 exato do SWF
   */
  private async createFullColorHeroes(): Promise<void> {
    const models = [
      { profession: 3, gender: 1, path: '/assets/create_char/hero_genjutsu_m.png', x: 235.45, y: 45.95, w: 238, h: 395 },
      { profession: 4, gender: 1, path: '/assets/create_char/hero_taijutsu_m.png', x: 511.45, y: 54.95, w: 236, h: 392 },
      { profession: 1, gender: 1, path: '/assets/create_char/hero_ninjutsu_m.png', x: 749.45, y: -1.55, w: 398, h: 448 },
      { profession: 3, gender: 0, path: '/assets/create_char/hero_genjutsu_f.png', x: 191.00, y: 20.95, w: 283, h: 408 },
      { profession: 4, gender: 0, path: '/assets/create_char/hero_taijutsu_f.png', x: 497.05, y: -0.60, w: 216, h: 465 },
      { profession: 1, gender: 0, path: '/assets/create_char/hero_ninjutsu_f.png', x: 758.45, y: -0.60, w: 294, h: 439 }
    ];

    for (const m of models) {
      try {
        const tex = await Assets.load(m.path);
        const sp = new Sprite(tex);
        sp.position.set(m.x, m.y);
        sp.width = m.w;
        sp.height = m.h;
        sp.visible = false;
        sp.eventMode = 'static';
        sp.cursor = 'pointer';

        sp.on('pointerdown', () => {
          this.selectedProfession = m.profession;
          this.updateSelection();
        });

        this.heroSprites.set(`${m.profession}_${m.gender}`, sp);
        this.addChild(sp);
      } catch (err) {
        console.warn('Erro ao carregar modelo colorido:', m.path, err);
      }
    }
  }

  /**
   * Faíscas e raios elétricos de Chakra dinâmicos ao redor da silhueta do herói selecionado
   */
  private createLightningEffect(): void {
    this.lightningGraphics = new Graphics();
    this.addChild(this.lightningGraphics);

    let tick = 0;
    this.tickerCallback = () => {
      tick++;
      this.lightningGraphics.clear();
      if (tick % 2 !== 0) return;

      const activeSlot = this.scrollSlots.find(s => s.profession === this.selectedProfession);
      if (!activeSlot) return;

      const cx = activeSlot.x + activeSlot.w / 2;
      const cy = activeSlot.y + activeSlot.h / 2 + 10;

      for (let i = 0; i < 5; i++) {
        const angle = (Math.PI * 2 / 5) * i + (tick * 0.12);
        const r1 = 65 + Math.random() * 25;
        const r2 = 130 + Math.random() * 35;

        const x1 = cx + Math.cos(angle) * r1;
        const y1 = cy + Math.sin(angle) * r1;
        const x2 = cx + Math.cos(angle) * r2;
        const y2 = cy + Math.sin(angle) * r2;
        const mx = (x1 + x2) / 2 + (Math.random() - 0.5) * 25;
        const my = (y1 + y2) / 2 + (Math.random() - 0.5) * 25;

        const color = activeSlot.profession === 3 ? 0xff44aa : activeSlot.profession === 4 ? 0xffea55 : 0x33ff99;
        this.lightningGraphics
          .moveTo(x1, y1)
          .lineTo(mx, my)
          .lineTo(x2, y2)
          .stroke({ color, width: 2.2, alpha: 0.85 });
      }
    };

    Ticker.shared.add(this.tickerCallback);
  }

  /**
   * Insígnia Circular de Vórtice no topo-esquerdo do pergaminho ativo e Descrição da Classe
   */
  private async createActiveProfessionBadge(): Promise<void> {
    for (const slot of this.scrollSlots) {
      try {
        const tex = await Assets.load(slot.badgeAsset);
        const sp = new Sprite(tex);
        // Posicionado no topo-esquerdo do pergaminho ativo sem cobrir o personagem
        sp.position.set(slot.x - 8, slot.y - 12);
        sp.width = 82;
        sp.height = 80;
        sp.visible = false;
        this.addChild(sp);
        this.badgeSprites.set(slot.profession, sp);
      } catch (err) {
        console.warn('Erro ao carregar insígnia circular:', slot.badgeAsset, err);
      }
    }

    this.activeBadgeContainer = new Container();
    this.addChild(this.activeBadgeContainer);

    // Linha 1 no círculo do vórtice (ex: "Tai")
    this.activeTitleLine1 = new Text({
      text: '',
      style: new TextStyle({
        fontFamily: 'Acme, Arial Black, sans-serif',
        fontSize: 18,
        fontWeight: 'bold',
        fill: '#ffea79',
        align: 'center',
        stroke: { color: '#000000', width: 4 },
        dropShadow: { color: '#ffcc00', blur: 6, distance: 0 }
      })
    });
    this.activeTitleLine1.anchor.set(0.5, 0.5);
    this.activeBadgeContainer.addChild(this.activeTitleLine1);

    // Linha 2 no círculo do vórtice (ex: "jutsu")
    this.activeTitleLine2 = new Text({
      text: '',
      style: new TextStyle({
        fontFamily: 'Acme, Arial Black, sans-serif',
        fontSize: 18,
        fontWeight: 'bold',
        fill: '#ffea79',
        align: 'center',
        stroke: { color: '#000000', width: 4 },
        dropShadow: { color: '#ffcc00', blur: 6, distance: 0 }
      })
    });
    this.activeTitleLine2.anchor.set(0.5, 0.5);
    this.activeBadgeContainer.addChild(this.activeTitleLine2);

    // Texto descritivo da classe centralizado sobre o pergaminho ativo
    this.activeDescText = new Text({
      text: '',
      style: new TextStyle({
        fontFamily: 'Acme, Segoe UI, sans-serif',
        fontSize: 13,
        fontWeight: 'bold',
        fill: '#ffea79',
        align: 'center',
        wordWrap: true,
        wordWrapWidth: 165,
        lineHeight: 18,
        stroke: { color: '#000000', width: 3 },
        dropShadow: { color: '#000000', blur: 3, distance: 1 }
      })
    });
    this.activeDescText.anchor.set(0.5, 0);
    this.activeBadgeContainer.addChild(this.activeDescText);
  }

  /**
   * Seletor de Gênero original 1:1: "Masculino" e "Feminino" em texto puro estilizado
   * Centralizado com precisão em relação ao pergaminho do meio (X=621.5, Y=445)
   */
  private createGenderControls(): void {
    this.genderContainer = new Container();
    this.genderContainer.position.set(621.5, 445);
    this.addChild(this.genderContainer);

    // Masculino
    this.txtMale = new Text({
      text: 'Masculino',
      style: new TextStyle({
        fontFamily: 'Acme, Arial Black, sans-serif',
        fontSize: 26,
        fontWeight: 'bold',
        fill: '#ffffff',
        stroke: { color: '#000000', width: 4 },
        dropShadow: { color: '#000000', blur: 4, distance: 2 }
      })
    });
    this.txtMale.anchor.set(1, 0.5);
    this.txtMale.position.set(-14, 0);
    this.txtMale.eventMode = 'static';
    this.txtMale.cursor = 'pointer';

    this.txtMale.on('pointerdown', () => {
      this.selectedGender = 1;
      this.updateSelection();
    });
    this.genderContainer.addChild(this.txtMale);

    // Feminino
    this.txtFemale = new Text({
      text: 'Feminino',
      style: new TextStyle({
        fontFamily: 'Acme, Arial Black, sans-serif',
        fontSize: 20,
        fontWeight: 'bold',
        fill: '#8b1010',
        stroke: { color: '#000000', width: 2 }
      })
    });
    this.txtFemale.anchor.set(0, 0.5);
    this.txtFemale.position.set(14, 0);
    this.txtFemale.eventMode = 'static';
    this.txtFemale.cursor = 'pointer';

    this.txtFemale.on('pointerdown', () => {
      this.selectedGender = 0;
      this.updateSelection();
    });
    this.genderContainer.addChild(this.txtFemale);
  }

  /**
   * Barra de Nome Oficial (name_bar) perfeitamente centralizada em X = 412, Y = 497
   * Com o entalhe preto medido exatamente de X = 163 a X = 313 dentro da imagem!
   */
  private async createNameBar(): Promise<void> {
    // name_bar.png tem 419px. Centro do pergaminho do meio é 621.5.
    // 621.5 - (419 / 2) = 412!
    const barX = 412;
    const barY = 497;

    this.nameBarContainer = new Container();
    this.nameBarContainer.position.set(barX, barY);

    // Fundo da barra
    const barTex = await Assets.load('/assets/create_char/name_bar.png');
    const barSprite = new Sprite(barTex);
    this.nameBarContainer.addChild(barSprite);

    // Rótulo vermelho "Nome:" posicionado antes do entalhe preto (em X = 100)
    const lblName = new Text({
      text: 'Nome:',
      style: new TextStyle({
        fontFamily: 'Acme, Segoe UI, sans-serif',
        fontSize: 14,
        fontWeight: 'bold',
        fill: '#ff3333',
        stroke: { color: '#000000', width: 3 },
        dropShadow: { color: '#000000', blur: 3, distance: 2 }
      })
    });
    lblName.anchor.set(0.5, 0.5);
    lblName.position.set(105, 29);
    this.nameBarContainer.addChild(lblName);

    // Dado 3D Oficial alinhado após o entalhe preto (em X = 338)
    const diceTex = await Assets.load('/assets/create_char/btn_dice_clean.png').catch(() => Assets.load('/assets/create_char/btn_dice.png'));
    this.diceSprite = new Sprite(diceTex);
    this.diceSprite.anchor.set(0.5, 0.5);
    this.diceSprite.position.set(338, 29);
    this.diceSprite.eventMode = 'static';
    this.diceSprite.cursor = 'pointer';

    this.diceSprite.on('pointerdown', () => {
      this.currentName = this.generateRandomName();
      if (this.htmlNameInput) {
        this.htmlNameInput.value = this.currentName;
      }
      this.diceSprite.rotation += Math.PI / 2;
    });
    this.nameBarContainer.addChild(this.diceSprite);

    this.addChild(this.nameBarContainer);

    // INPUT HTML DIRETO NA TELA (Encaixado com precisão militar no entalhe preto de 163 a 313!)
    this.createDirectHtmlInput(barX + 165, barY + 15, 142);
  }

  /**
   * Cria o input HTML exatamente dentro do slot preto da barra
   */
  private createDirectHtmlInput(x: number, y: number, width: number): void {
    const existing = document.getElementById('shinobi-direct-input');
    if (existing) {
      existing.remove();
    }

    const container = document.getElementById('game-container') || document.body;
    const input = document.createElement('input');
    input.id = 'shinobi-direct-input';
    input.type = 'text';
    input.maxLength = 14;
    input.value = this.currentName;
    input.autocomplete = 'off';
    input.spellcheck = false;

    Object.assign(input.style, {
      position: 'absolute',
      left: `${x}px`,
      top: `${y}px`,
      width: `${width}px`,
      height: '28px',
      background: 'transparent',
      border: 'none',
      outline: 'none',
      color: '#ffffff',
      fontFamily: 'Acme, Segoe UI, sans-serif',
      fontSize: '14px',
      fontWeight: 'bold',
      textAlign: 'center',
      textShadow: '0 0 3px #000, 1px 1px 2px #000',
      letterSpacing: '0.5px',
      padding: '0 2px',
      boxSizing: 'border-box',
      zIndex: '20'
    });

    input.addEventListener('input', () => {
      this.currentName = input.value.trim().slice(0, 14);
    });

    container.appendChild(input);
    this.htmlNameInput = input;
  }

  /**
   * Botão Confirmar ("Iniciar Jogo") perfeitamente centralizado em X = 560, Y = 558
   */
  private async createConfirmButton(): Promise<void> {
    // Largura 123px. Centro é 621.5. 621.5 - (123 / 2) = 560!
    this.btnConfirmContainer = new Container();
    this.btnConfirmContainer.position.set(560, 558);
    this.btnConfirmContainer.eventMode = 'static';
    this.btnConfirmContainer.cursor = 'pointer';

    const btnTex = await Assets.load('/assets/create_char/btn_confirm_clean.png').catch(() => Assets.load('/assets/create_char/btn_create.png'));
    this.btnConfirmSprite = new Sprite(btnTex);
    this.btnConfirmContainer.addChild(this.btnConfirmSprite);

    // Texto oficial dourado "Iniciar Jogo"
    const btnLabel = new Text({
      text: 'Iniciar Jogo',
      style: new TextStyle({
        fontFamily: 'Acme, Segoe UI, sans-serif',
        fontSize: 16,
        fontWeight: 'bold',
        fill: '#ffea79',
        stroke: { color: '#2a0e05', width: 3 },
        dropShadow: { color: '#000000', blur: 3, distance: 2 }
      })
    });
    btnLabel.anchor.set(0.5, 0.5);
    btnLabel.position.set(61.5, 22);
    this.btnConfirmContainer.addChild(btnLabel);

    this.btnConfirmContainer.on('pointerover', () => {
      this.btnConfirmSprite.tint = 0xffeeaa;
    });
    this.btnConfirmContainer.on('pointerout', () => {
      this.btnConfirmSprite.tint = 0xffffff;
    });
    this.btnConfirmContainer.on('pointerdown', () => {
      this.btnConfirmSprite.tint = 0xcccccc;
    });
    this.btnConfirmContainer.on('pointerup', () => {
      this.btnConfirmSprite.tint = 0xffffff;
      this.confirmRoleCreation();
    });

    this.addChild(this.btnConfirmContainer);
  }

  /**
   * Letreiro de Avisos Ninja Flutuante à direita (X=995, Y=280)
   */
  private createAnnouncementTicker(): void {
    const tickerContainer = new Container();
    tickerContainer.position.set(995, 280);

    this.announcementTicker = new Text({
      text: this.announcementLines.slice(0, 6).join('\n'),
      style: new TextStyle({
        fontFamily: 'Acme, Calibri, sans-serif',
        fontSize: 12,
        fontWeight: 'bold',
        fill: '#ffcc33',
        lineHeight: 22,
        stroke: { color: '#000000', width: 2.5 },
        dropShadow: { color: '#000000', blur: 3, distance: 1 }
      })
    });
    tickerContainer.addChild(this.announcementTicker);
    this.addChild(tickerContainer);

    this.tickerInterval = setInterval(() => {
      const s = this.surnames[Math.floor(Math.random() * this.surnames.length)];
      const n = this.maleNames[Math.floor(Math.random() * this.maleNames.length)];
      this.announcementLines.shift();
      this.announcementLines.push(`${s} ${n} entrou no jogo`);
      this.announcementTicker.text = this.announcementLines.slice(0, 6).join('\n');
    }, 3500);
  }

  /**
   * Atualiza todo o estado visual de acordo com a disciplina e gênero selecionados
   */
  private async updateSelection(): Promise<void> {
    const isMale = this.selectedGender === 1;

    // 1. Atualizar as texturas sépia dos pergaminhos base
    for (const slot of this.scrollSlots) {
      const sp = this.baseScrollSprites.get(slot.profession);
      if (sp) {
        const thumbPath = slot.profession === 3
          ? (isMale ? '/assets/create_char/thumb_genjutsu_m.png' : '/assets/create_char/thumb_genjutsu_f.png')
          : slot.profession === 4
          ? (isMale ? '/assets/create_char/thumb_taijutsu_m.png' : '/assets/create_char/thumb_taijutsu_f.png')
          : (isMale ? '/assets/create_char/thumb_ninjutsu_m.png' : '/assets/create_char/thumb_ninjutsu_f.png');

        try {
          const tex = await Assets.load(thumbPath);
          sp.texture = tex;
        } catch {}

        // Pergaminhos inativos ficam visíveis; o ativo tem a arte colorida em destaque
        sp.alpha = (slot.profession === this.selectedProfession) ? 0 : 1;
      }

      // Título no topo do pergaminho só aparece se não estiver selecionado
      const unselTitle = this.unselectedTitles.get(slot.profession);
      if (unselTitle) {
        unselTitle.visible = (slot.profession !== this.selectedProfession);
      }
    }

    // 2. Exibe ESTRITAMENTE o modelo colorido do herói ativo
    for (const [key, sprite] of this.heroSprites.entries()) {
      const targetKey = `${this.selectedProfession}_${this.selectedGender}`;
      sprite.visible = (key === targetKey);
    }

    // 3. Exibe o círculo do vórtice no topo-esquerdo do pergaminho ativo
    for (const [prof, badgeSp] of this.badgeSprites.entries()) {
      badgeSp.visible = (prof === this.selectedProfession);
    }

    // 4. Atualiza a posição e textos da insígnia ativa
    const activeSlot = this.scrollSlots.find(s => s.profession === this.selectedProfession);
    if (activeSlot) {
      // Centro da insígnia circular de vórtice (badgeSp em slot.x - 8, slot.y - 12, tamanho 82x80)
      const badgeCenterX = activeSlot.x - 8 + 41;
      const badgeCenterY = activeSlot.y - 12 + 40;

      this.activeTitleLine1.text = activeSlot.badgeLine1;
      this.activeTitleLine1.position.set(badgeCenterX, badgeCenterY - 10);

      this.activeTitleLine2.text = activeSlot.badgeLine2;
      this.activeTitleLine2.position.set(badgeCenterX, badgeCenterY + 10);

      // Descrição posicionada centralizada sobre o pergaminho ativo
      const cx = activeSlot.x + activeSlot.w / 2;
      this.activeDescText.text = activeSlot.desc;
      this.activeDescText.position.set(cx, activeSlot.y + 195);
      this.activeBadgeContainer.visible = true;
    }

    // 5. Atualiza o Seletor de Gênero (Masculino / Feminino)
    if (isMale) {
      this.txtMale.style.fontSize = 26;
      this.txtMale.style.fill = '#ffffff';
      this.txtMale.style.stroke = { color: '#000000', width: 4 };
      this.txtMale.alpha = 1.0;

      this.txtFemale.style.fontSize = 20;
      this.txtFemale.style.fill = '#8b1010';
      this.txtFemale.style.stroke = { color: '#000000', width: 2 };
      this.txtFemale.alpha = 0.85;
    } else {
      this.txtFemale.style.fontSize = 26;
      this.txtFemale.style.fill = '#ffffff';
      this.txtFemale.style.stroke = { color: '#000000', width: 4 };
      this.txtFemale.alpha = 1.0;

      this.txtMale.style.fontSize = 20;
      this.txtMale.style.fill = '#8b1010';
      this.txtMale.style.stroke = { color: '#000000', width: 2 };
      this.txtMale.alpha = 0.85;
    }
  }

  private generateRandomName(): string {
    const s = this.surnames[Math.floor(Math.random() * this.surnames.length)];
    const list = this.selectedGender === 1 ? this.maleNames : this.femaleNames;
    const n = list[Math.floor(Math.random() * list.length)];
    return `${s}_${n}`;
  }

  private confirmRoleCreation(): void {
    const finalName = this.htmlNameInput ? this.htmlNameInput.value.trim() : this.currentName.trim();
    if (!finalName || finalName.length < 2) {
      this.currentName = this.generateRandomName();
      if (this.htmlNameInput) {
        this.htmlNameInput.value = this.currentName;
      }
    } else {
      this.currentName = finalName.slice(0, 14);
    }

    console.log(`[CLIENT] Confirmando criação de personagem em Português: Nome="${this.currentName}", Classe=${this.selectedProfession}, Sexo=${this.selectedGender}`);
    const createPkt = new PacketWriter(Opcodes.CS_CREATECHAR_CreateChar)
      .writeFlushUTF(this.currentName)
      .writeUInt8(this.selectedProfession)
      .writeUInt8(this.selectedGender);
    NetworkClient.getInstance().send(createPkt);
  }

  public override destroy(options?: any): void {
    if (this.tickerCallback) {
      Ticker.shared.remove(this.tickerCallback);
    }
    if (this.tickerInterval) {
      clearInterval(this.tickerInterval);
    }
    if (this.htmlNameInput) {
      this.htmlNameInput.remove();
      this.htmlNameInput = null;
    }
    super.destroy(options);
  }
}
