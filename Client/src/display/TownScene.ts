import { Container, Graphics, Sprite, Text, TextStyle, AnimatedSprite, Assets, Texture, Ticker, Rectangle } from 'pixi.js';
import { NetworkClient } from '../network/NetworkClient.js';
import { PacketWriter } from '../network/PacketWriter.js';
import { PacketReader } from '../network/PacketReader.js';
import { Opcodes } from '../protocol/opcodes.js';
import { NpcDialogModal } from './NpcDialogModal.js';
import { TownHUD } from './TownHUD.js';

export interface PlayerProfile {
  charId: number;
  name: string;
  profession: number; // 4: Taijutsu, 1: Ninjutsu, 2: Genjutsu
  gender: number;     // 1: Male, 0: Female
  level: number;
  curHp: number;
  maxHp: number;
  silver: number;
  gold: number;
}

export interface NpcEntry {
  id: number;
  name: string;
  npcTitle: string;
  x: number;
  y: number;
  userType: number;
}

interface AnimatedEntity {
  container: Container;
  idleAnim: AnimatedSprite;
  runAnim?: AnimatedSprite;
  isMoving: boolean;
  targetX: number;
  targetY: number;
  speed: number;
}

interface AmbientLeaf {
  graphic: Graphics;
  x: number;
  y: number;
  vx: number;
  vy: number;
  rot: number;
  vRot: number;
  tumble: number;
  vTumble: number;
  baseScale: number;
  wobble: number;
  isForeground: boolean;
}

interface SteamPuff {
  graphic: Graphics;
  x: number;
  y: number;
  vx: number;
  vy: number;
  alpha: number;
  scale: number;
  life: number;
  maxLife: number;
}

interface LanternGlow {
  graphic: Graphics;
  x: number;
  y: number;
  offset: number;
}

interface WaterRipple {
  graphic: Graphics;
  baseX: number;
  baseY: number;
  width: number;
  offset: number;
  speed: number;
}

interface NpcDisplay {
  entry: NpcEntry;
  container: Container;
  anim: AnimatedSprite;
  questMarker: Text;
  baseY: number;
}

export class TownScene extends Container {
  private playerProfile: PlayerProfile;

  // Camadas de Parallax Canônicas (TLayerBackGround.as)
  private parallaxContainer0: Container; // Fundo Distante / Céu (Parallax 0.25x)
  private parallaxContainer2: Container; // Camada Intermediária / Telhados (Parallax 0.50x)
  private worldContainer: Container;     // Camada Principal / Chão Caminhável (Parallax 1.00x)
  private propsContainer: Container;     // Efeitos e props do mundo (vapor, água, lanternas)
  private entitiesContainer: Container;  // Personagens e NPCs com Ordenação Y (Depth Sorting)
  private fgParticlesContainer: Container; // Folhas em primeiro plano (na frente dos personagens)

  private hudContainer: Container;
  private cityBannerContainer: Container;
  private speechBubbleContainer: Container;
  private npcDialogModal: NpcDialogModal;

  // Jogador local
  private localPlayer: AnimatedEntity | null = null;
  private isPointerDown: boolean = false;

  // Entidades no mapa
  private npcs: Map<number, NpcDisplay> = new Map();
  private otherPlayers: Map<number, AnimatedEntity> = new Map();

  // Estado da Cidade Atual
  private currentCityId: number = 23100001;
  private currentMapWidth: number = 2500;
  private currentMapHeight: number = 650;
  private roadMinY: number = 375;
  private roadMaxY: number = 620;

  // Sprites de fundo ativos
  private bgSprite0: Sprite | null = null;
  private bgSprite2: Sprite | null = null;
  private bgSprite1: Sprite | null = null;

  // Marcador de clique oficial (00CFAC20.TexClient / FDartShowing)
  private clickMarkerTextures: Texture[] = [];

  // Sistema de Partículas Ambientais (MC_Leaf / Konoha Wind)
  private leaves: AmbientLeaf[] = [];

  // Efeitos do mundo
  private steamPuffs: SteamPuff[] = [];
  private lanterns: LanternGlow[] = [];
  private waterRipples: WaterRipple[] = [];

  // Balões de fala vivos dos NPCs
  private activeSpeechBubble: Container | null = null;
  private speechTimer: number = 0;

  // Trilha sonora oficial (#100001)
  private bgmAudio: HTMLAudioElement | null = null;
  private isBgmPlaying: boolean = false;
  private bgmToggleBtn!: Container;
  private bgmIconTxt!: Text;

  // HUD Elements
  private townHud!: TownHUD;
  private hpFill!: Graphics;
  private hpText!: Text;
  private silverText!: Text;
  private goldText!: Text;
  private mapTxt!: Text;

  // Loop Ticker
  private animTick: number = 0;

  constructor(profile: PlayerProfile) {
    super();
    this.playerProfile = profile;

    this.parallaxContainer0 = new Container();
    this.parallaxContainer2 = new Container();
    this.worldContainer = new Container();
    this.propsContainer = new Container();
    this.entitiesContainer = new Container();
    this.entitiesContainer.sortableChildren = true;
    this.fgParticlesContainer = new Container();

    this.worldContainer.addChild(this.propsContainer);
    this.worldContainer.addChild(this.entitiesContainer);
    this.worldContainer.addChild(this.fgParticlesContainer);

    this.speechBubbleContainer = new Container();
    this.worldContainer.addChild(this.speechBubbleContainer);

    this.cityBannerContainer = new Container();
    this.hudContainer = new Container();
    this.npcDialogModal = new NpcDialogModal();

    this.addChild(this.parallaxContainer0);
    this.addChild(this.parallaxContainer2);
    this.addChild(this.worldContainer);
    this.addChild(this.cityBannerContainer);
    this.addChild(this.hudContainer);
    this.addChild(this.npcDialogModal);

    this.setupNetworkHandlers();
    this.setupDialogActions();
    this.init();
  }

  private async init(): Promise<void> {
    // 1. Carregar texturas do marcador de clique oficial
    await this.loadClickMarkerTextures();

    // 2. Carregar o cenário canônico inicial (Subúrbios Novatos #23100001)
    await this.loadCityEnvironment(23100001);

    // 3. Criar Entidade do Jogador Local
    await this.createLocalPlayer(450, 480);

    // 4. Inicializar sistema de partículas de folhas ao vento
    this.initLeafParticles();

    // 5. Inicializar BGM oficial
    this.initBgmAudio();

    // 6. Criar HUD Superior com controle de som
    this.createHUD();

    // 7. Loop de Atualização de Movimento, Câmera e Ambiance
    Ticker.shared.add(this.update, this);

    // 8. Requisitar Entrada na Vila Novice Suburb (#23100001) ao Servidor
    const enterPkt = new PacketWriter(Opcodes.CS_LOBBY_Enter_Town)
      .writeUInt32BE(23100001);
    NetworkClient.getInstance().send(enterPkt);
  }

  /**
   * Carrega o spritesheet autêntico de 11 frames da animação de clique (00CFAC20.TexClient).
   */
  private async loadClickMarkerTextures(): Promise<void> {
    try {
      const baseTex = await Assets.load('/assets/mouse_click_fx.png');
      this.clickMarkerTextures = [];
      const frameWidth = 92;
      const frameHeight = 98;
      for (let i = 0; i < 11; i++) {
        this.clickMarkerTextures.push(new Texture({
          source: baseTex.source,
          frame: new Rectangle(i * frameWidth, 0, frameWidth, frameHeight)
        }));
      }
      console.log(`[CLIENT] Texturas do marcador de clique carregadas com sucesso (${this.clickMarkerTextures.length} frames).`);
    } catch (err) {
      console.warn('[CLIENT] Falha ao carregar /assets/mouse_click_fx.png, usando fallback procedural:', err);
    }
  }

  /**
   * Spawna o marcador de clique animado oficial (shuriken/target ring).
   */
  private spawnClickMarker(x: number, y: number): void {
    if (this.clickMarkerTextures.length > 0) {
      const marker = new AnimatedSprite(this.clickMarkerTextures);
      marker.anchor.set(0.5, 0.72);
      marker.position.set(x, y);
      marker.animationSpeed = 0.38;
      marker.loop = false;
      marker.zIndex = 0; // Fica no chão, sob personagens
      this.entitiesContainer.addChild(marker);
      marker.play();
      marker.onComplete = () => {
        this.entitiesContainer.removeChild(marker);
        marker.destroy();
      };
    } else {
      // Fallback procedural canônico caso a imagem demore a carregar
      const marker = new Graphics()
        .circle(0, 0, 16).stroke({ color: 0x27ae60, width: 2 })
        .circle(0, 0, 6).fill(0x2ecc71);
      marker.position.set(x, y);
      marker.zIndex = 0;
      this.entitiesContainer.addChild(marker);

      let scale = 0.5;
      let alpha = 1;
      const t = (delta: any) => {
        scale += 0.08 * delta.deltaTime;
        alpha -= 0.05 * delta.deltaTime;
        marker.scale.set(scale);
        marker.alpha = Math.max(0, alpha);
        if (alpha <= 0) {
          Ticker.shared.remove(t);
          this.entitiesContainer.removeChild(marker);
          marker.destroy();
        }
      };
      Ticker.shared.add(t);
    }
  }

  private initBgmAudio(): void {
    try {
      this.bgmAudio = new Audio('/assets/vn/100001.mp3');
      this.bgmAudio.loop = true;
      this.bgmAudio.volume = 0.28;
    } catch (e) {
      console.warn('Erro ao inicializar áudio BGM:', e);
    }
  }

  private tryStartBgm(): void {
    if (this.bgmAudio && !this.isBgmPlaying) {
      this.bgmAudio.play().then(() => {
        this.isBgmPlaying = true;
        if (this.bgmIconTxt) this.bgmIconTxt.text = '🔊 BGM';
        if (this.townHud) this.townHud.updateBgmState(true);
      }).catch(() => {
        // Bloqueio de autoplay do navegador até interação do usuário
      });
    }
  }

  private toggleBgm(): void {
    if (!this.bgmAudio) return;
    if (this.isBgmPlaying) {
      this.bgmAudio.pause();
      this.isBgmPlaying = false;
      if (this.bgmIconTxt) this.bgmIconTxt.text = '🔇 MUDO';
      if (this.townHud) this.townHud.updateBgmState(false);
    } else {
      this.bgmAudio.play().then(() => {
        this.isBgmPlaying = true;
        if (this.bgmIconTxt) this.bgmIconTxt.text = '🔊 BGM';
        if (this.townHud) this.townHud.updateBgmState(true);
      }).catch(console.warn);
    }
  }

  private setupDialogActions(): void {
    this.npcDialogModal.onActionClick = (action: string, _npcId: number) => {
      if (action === 'gate_to_konoha') {
        console.log('[CLIENT] Atravessando o Portão para a Vila de Konoha (#23200001)...');
        const pkt = new PacketWriter(Opcodes.CS_LOBBY_Enter_Town).writeUInt32BE(23200001);
        NetworkClient.getInstance().send(pkt);
      } else if (action === 'gate_to_suburb') {
        console.log('[CLIENT] Atravessando o Portão para os Subúrbios Novatos (#23100001)...');
        const pkt = new PacketWriter(Opcodes.CS_LOBBY_Enter_Town).writeUInt32BE(23100001);
        NetworkClient.getInstance().send(pkt);
      }
    };
  }

  /**
   * Carrega os cenários autênticos de 3 camadas da cidade especificada.
   * Novice Suburb: 23100001
   * Konoha Village: 23200001
   */
  private async loadCityEnvironment(cityId: number): Promise<void> {
    this.currentCityId = cityId;

    // Remover sprites anteriores
    if (this.bgSprite0) {
      this.parallaxContainer0.removeChild(this.bgSprite0);
      this.bgSprite0.destroy();
      this.bgSprite0 = null;
    }
    if (this.bgSprite2) {
      this.parallaxContainer2.removeChild(this.bgSprite2);
      this.bgSprite2.destroy();
      this.bgSprite2 = null;
    }
    if (this.bgSprite1) {
      this.worldContainer.removeChild(this.bgSprite1);
      this.bgSprite1.destroy();
      this.bgSprite1 = null;
    }

    const folder = cityId === 23200001 ? '23200001_konoha_village' : '23100001_novice_suburb';

    if (cityId === 23200001) {
      // Vila de Konoha: dimensões autênticas completas
      this.currentMapWidth = 2516;
      this.currentMapHeight = 650;
      this.roadMinY = 380; // Entrada de lojas / início da rua transitável
      this.roadMaxY = 635; // Extensão total até o limite inferior da tela
      if (this.mapTxt) this.mapTxt.text = '📍 Vila da Folha — Konoha (#23200001)';
      if (this.townHud) this.townHud.updateCityName('Vila da Folha');
    } else {
      // Subúrbios Novatos: dimensões autênticas completas
      this.currentMapWidth = 2500;
      this.currentMapHeight = 650;
      this.roadMinY = 375;
      this.roadMaxY = 620;
      if (this.mapTxt) this.mapTxt.text = '📍 Subúrbios de Konoha (#23100001)';
      if (this.townHud) this.townHud.updateCityName('Subúrbios');
    }

    try {
      // 1. Camada 0: Fundo distante (Céu / Monumento dos Hokages)
      const tex0 = await Assets.load(`/assets/towns/${folder}/layer_0.png`);
      this.bgSprite0 = new Sprite(tex0);
      this.bgSprite0.y = 0;
      this.parallaxContainer0.addChild(this.bgSprite0);

      // 2. Camada 2: Camada intermediária (Árvores / Telhados)
      const tex2 = await Assets.load(`/assets/towns/${folder}/layer_2.png`);
      this.bgSprite2 = new Sprite(tex2);
      this.bgSprite2.y = 0;
      this.parallaxContainer2.addChild(this.bgSprite2);

      // 3. Camada 1: Cenário principal e chão caminhável de 2500px
      const tex1 = await Assets.load(`/assets/towns/${folder}/layer_1.png`);
      this.bgSprite1 = new Sprite(tex1);
      this.bgSprite1.y = 0;
      this.worldContainer.addChildAt(this.bgSprite1, 0);
    } catch (err) {
      console.warn('Erro ao carregar texturas autênticas de cidade, usando fallback:', err);
      const fallback = new Graphics()
        .rect(0, 0, this.currentMapWidth, 380).fill(0x2d4f30)
        .rect(0, 380, this.currentMapWidth, 270).fill(0x6b5335);
      this.worldContainer.addChildAt(fallback, 0);
    }

    // Configurar props vivos e atmosféricos específicos de cada vila
    this.setupWorldProps(cityId);

    // Configurar clique e arraste no chão para movimentação livre
    this.worldContainer.eventMode = 'static';
    this.worldContainer.hitArea = {
      contains: (x: number, y: number) => x >= 0 && x <= this.currentMapWidth && y >= 0 && y <= this.currentMapHeight
    };

    this.worldContainer.removeAllListeners();

    // Iniciar clique / clique contínuo
    this.worldContainer.on('pointerdown', (e) => {
      this.isPointerDown = true;
      const localPos = e.getLocalPosition(this.worldContainer);
      this.handlePointerTarget(localPos.x, localPos.y, true);
    });

    // Mover segurando o botão do mouse (FLongClickMove em TLayerLittleScript.as)
    this.worldContainer.on('pointermove', (e) => {
      if (this.isPointerDown) {
        const localPos = e.getLocalPosition(this.worldContainer);
        this.handlePointerTarget(localPos.x, localPos.y, false);
      }
    });

    this.worldContainer.on('pointerup', () => {
      this.isPointerDown = false;
    });

    this.worldContainer.on('pointerupoutside', () => {
      this.isPointerDown = false;
    });
  }

  /**
   * Calcula a posição alvo com projeção de raios canônica (TLayerLittleScript.as lines 117-130).
   * Se o clique for acima da rua (telhados/céu), projeta a reta do ninja até o asfalto.
   */
  private handlePointerTarget(targetX: number, targetY: number, isClick: boolean): void {
    if (!this.localPlayer) return;

    let finalX = targetX;
    let finalY = targetY;

    if (targetY < this.roadMinY) {
      const dx = targetX - this.localPlayer.container.x;
      const dy = targetY - this.localPlayer.container.y;
      if (Math.abs(dy) > 0.001) {
        const slope = dy / (dx === 0 ? 0.0001 : dx);
        finalX = this.localPlayer.container.x + (this.roadMinY - this.localPlayer.container.y) / slope;
      }
      finalY = this.roadMinY;
    }

    const clampedX = Math.max(40, Math.min(this.currentMapWidth - 40, finalX));
    const clampedY = Math.max(this.roadMinY, Math.min(this.roadMaxY, finalY));

    this.moveLocalPlayerTo(clampedX, clampedY);

    if (isClick) {
      this.spawnClickMarker(clampedX, clampedY);
      this.tryStartBgm();
    }
  }

  /**
   * Configura adereços e efeitos animados específicos de cada cidade.
   */
  private setupWorldProps(cityId: number): void {
    this.propsContainer.removeChildren();
    this.lanterns = [];
    this.waterRipples = [];
    this.steamPuffs = [];

    if (cityId === 23200001) {
      // Konoha Village:
      // 1. Lanternas da rua e lojas (Ichiraku, Portão, Casas)
      const lanternCoords = [
        { x: 380, y: 350 },
        { x: 840, y: 340 },
        { x: 1040, y: 335 }, // Ichiraku
        { x: 1210, y: 345 },
        { x: 1650, y: 340 },
        { x: 2180, y: 350 }
      ];

      for (const pt of lanternCoords) {
        const glow = new Graphics()
          .circle(0, 0, 24)
          .fill({ color: 0xffaa33, alpha: 0.28 });
        glow.position.set(pt.x, pt.y);
        this.propsContainer.addChild(glow);
        this.lanterns.push({ graphic: glow, x: pt.x, y: pt.y, offset: Math.random() * 10 });
      }
    } else {
      // Subúrbios Novatos:
      // 1. Reflexos e ondulações do riacho / ponte de madeira
      for (let i = 0; i < 5; i++) {
        const ripple = new Graphics()
          .roundRect(-40, 0, 80, 4, 2)
          .fill({ color: 0xa8e6cf, alpha: 0.35 });
        const bx = 520 + i * 45;
        const by = 480 + (i % 3) * 20;
        ripple.position.set(bx, by);
        this.propsContainer.addChild(ripple);
        this.waterRipples.push({
          graphic: ripple,
          baseX: bx,
          baseY: by,
          width: 80,
          offset: Math.random() * 5,
          speed: 0.8 + Math.random() * 0.4
        });
      }

      // 2. Lanternas do portão dos subúrbios
      const gateGlow = new Graphics()
        .circle(0, 0, 28)
        .fill({ color: 0xffbb44, alpha: 0.32 });
      gateGlow.position.set(2070, 370);
      this.propsContainer.addChild(gateGlow);
      this.lanterns.push({ graphic: gateGlow, x: 2070, y: 370, offset: 0 });
    }
  }

  /**
   * Inicializa o sistema de partículas ambientais de folhas voando (MC_Leaf).
   */
  private initLeafParticles(): void {
    this.leaves = [];
    const count = 36;

    for (let i = 0; i < count; i++) {
      const isForeground = i % 3 === 0;
      const isAutumn = this.currentCityId === 23200001 ? (Math.random() > 0.4) : (Math.random() > 0.85);

      const leafGraphic = new Graphics()
        .poly([0, -8, 5, -2, 4, 6, 0, 9, -4, 6, -5, -2])
        .fill({ color: isAutumn ? 0xd35400 : 0x27ae60 })
        .stroke({ color: isAutumn ? 0x962d00 : 0x196f3d, width: 1 });

      const scale = 0.6 + Math.random() * 0.7;
      leafGraphic.scale.set(scale);

      const targetCont = isForeground ? this.fgParticlesContainer : this.propsContainer;
      targetCont.addChild(leafGraphic);

      this.leaves.push({
        graphic: leafGraphic,
        x: Math.random() * 1400,
        y: Math.random() * 650,
        vx: 1.8 + Math.random() * 2.2,
        vy: 0.8 + Math.random() * 1.5,
        rot: Math.random() * Math.PI * 2,
        vRot: (Math.random() - 0.5) * 0.08,
        tumble: Math.random() * Math.PI * 2,
        vTumble: 0.03 + Math.random() * 0.05,
        baseScale: scale,
        wobble: Math.random() * 10,
        isForeground
      });
    }
  }

  /**
   * Spawna puffs de vapor subindo do Ichiraku Ramen na Vila de Konoha.
   */
  private emitRamenSteam(): void {
    if (this.currentCityId !== 23200001) return;
    if (this.steamPuffs.length >= 14) return;

    // Panelas do Ichiraku Ramen ficam em X=1025, Y=330
    const puff = new Graphics()
      .circle(0, 0, 6)
      .fill({ color: 0xf5f6fa, alpha: 0.45 });

    puff.position.set(1020 + (Math.random() - 0.5) * 16, 325);
    this.propsContainer.addChild(puff);

    this.steamPuffs.push({
      graphic: puff,
      x: puff.x,
      y: puff.y,
      vx: 0.3 + Math.random() * 0.5,
      vy: -(0.9 + Math.random() * 0.7),
      alpha: 0.45,
      scale: 0.7,
      life: 0,
      maxLife: 60 + Math.random() * 30
    });
  }

  /**
   * Transição suave entre cidades quando o servidor envia confirmação SC_Enter_Town.
   */
  private async switchCity(cityId: number, spawnX: number, spawnY: number): Promise<void> {
    console.log(`[CLIENT] Trocando para cidade #${cityId} com spawn em (${spawnX}, ${spawnY})`);

    // 1. Limpar NPCs e jogadores da vila anterior
    for (const npc of this.npcs.values()) {
      this.entitiesContainer.removeChild(npc.container);
      npc.container.destroy();
    }
    this.npcs.clear();

    for (const remote of this.otherPlayers.values()) {
      this.entitiesContainer.removeChild(remote.container);
      remote.container.destroy();
    }
    this.otherPlayers.clear();

    if (this.activeSpeechBubble) {
      this.speechBubbleContainer.removeChild(this.activeSpeechBubble);
      this.activeSpeechBubble.destroy();
      this.activeSpeechBubble = null;
    }

    // 2. Carregar o novo cenário em 3 camadas de parallax
    await this.loadCityEnvironment(cityId);

    // 3. Reposicionar jogador local
    if (this.localPlayer) {
      this.localPlayer.container.position.set(spawnX, spawnY);
      this.localPlayer.targetX = spawnX;
      this.localPlayer.targetY = spawnY;
      this.localPlayer.isMoving = false;
      if (this.localPlayer.runAnim) {
        this.localPlayer.runAnim.stop();
        this.localPlayer.runAnim.visible = false;
      }
      this.localPlayer.idleAnim.visible = true;
      this.localPlayer.idleAnim.play();
    }

    // 4. Disparar banner de entrada canônico
    const cityName = cityId === 23200001 ? 'VILA DA FOLHA — KONOHA' : 'SUBÚRBIOS DE KONOHA';
    this.showCityNotification(cityName);
  }

  /**
   * Efeito oficial de notificação de entrada de cidade (PlayEnterCityEffect).
   */
  private showCityNotification(cityName: string): void {
    this.cityBannerContainer.removeChildren();

    const banner = new Container();
    banner.position.set(625, 80);
    banner.alpha = 0;

    const frame = new Graphics()
      .roundRect(-220, -22, 440, 44, 8)
      .fill({ color: 0x160808, alpha: 0.92 })
      .stroke({ color: 0xd4af37, width: 2.5 });
    banner.addChild(frame);

    const innerGold = new Graphics()
      .roundRect(-215, -17, 430, 34, 5)
      .stroke({ color: 0x8b6508, width: 1 });
    banner.addChild(innerGold);

    const title = new Text({
      text: `🍃  ${cityName}  🍃`,
      style: new TextStyle({
        fontSize: 16,
        fontWeight: 'bold',
        fill: '#ffd700',
        stroke: { color: '#000000', width: 3 },
        letterSpacing: 2
      })
    });
    title.anchor.set(0.5, 0.5);
    banner.addChild(title);

    this.cityBannerContainer.addChild(banner);

    let elapsed = 0;
    const ticker = (delta: any) => {
      elapsed += delta.deltaTime;
      if (elapsed < 20) {
        banner.alpha = Math.min(1, banner.alpha + 0.08);
      } else if (elapsed > 90) {
        banner.alpha = Math.max(0, banner.alpha - 0.04);
        if (banner.alpha <= 0) {
          Ticker.shared.remove(ticker);
          this.cityBannerContainer.removeChild(banner);
          banner.destroy();
        }
      }
    };
    Ticker.shared.add(ticker);
  }

  private async loadFrames(folder: string, prefix: string, count: number): Promise<Texture[]> {
    const textures: Texture[] = [];
    for (let i = 0; i < count; i++) {
      try {
        const tex = await Assets.load(`/assets/animated/${folder}/${prefix}_${i}.png`);
        textures.push(tex);
      } catch (e) {
        console.warn(`Frame não encontrado: ${folder}/${prefix}_${i}.png`);
      }
    }
    if (textures.length === 0) {
      textures.push(Texture.WHITE);
    }
    return textures;
  }

  private getPlayerAssetFolder(prof: number, gender: number): string {
    const p = prof === 4 ? 'taijutsu' : prof === 1 ? 'ninjutsu' : 'genjutsu';
    const g = gender === 1 ? 'm' : 'f';
    return `hero_${p}_${g}`;
  }

  private async createLocalPlayer(x: number, y: number): Promise<void> {
    const folder = this.getPlayerAssetFolder(this.playerProfile.profession, this.playerProfile.gender);

    const [idleFrames, runFrames] = await Promise.all([
      this.loadFrames(folder, 'idle', 6),
      this.loadFrames(folder, 'run', 8)
    ]);

    const playerContainer = new Container();
    playerContainer.position.set(x, y);

    const shadow = new Graphics()
      .ellipse(0, 0, 24, 7)
      .fill({ color: 0x000000, alpha: 0.45 });
    playerContainer.addChild(shadow);

    const idleAnim = new AnimatedSprite(idleFrames);
    idleAnim.anchor.set(0.5, 1.0);
    idleAnim.animationSpeed = 0.14;
    idleAnim.play();
    playerContainer.addChild(idleAnim);

    let runAnim: AnimatedSprite | undefined;
    if (runFrames.length > 0 && runFrames[0] !== Texture.WHITE) {
      runAnim = new AnimatedSprite(runFrames);
      runAnim.anchor.set(0.5, 1.0);
      runAnim.animationSpeed = 0.22;
      runAnim.visible = false;
      playerContainer.addChild(runAnim);
    }

    const profName = this.playerProfile.profession === 4 ? 'Taijutsu' : this.playerProfile.profession === 1 ? 'Ninjutsu' : 'Genjutsu';
    const nameLabel = new Text({
      text: this.playerProfile.name,
      style: new TextStyle({
        fontSize: 13,
        fontWeight: 'bold',
        fill: '#58a6ff',
        stroke: { color: '#000000', width: 3 }
      })
    });
    nameLabel.anchor.set(0.5, 1.0);
    nameLabel.position.set(0, -95);
    playerContainer.addChild(nameLabel);

    const titleLabel = new Text({
      text: `<${profName}>`,
      style: new TextStyle({
        fontSize: 10,
        fill: '#ffd700',
        stroke: { color: '#000000', width: 2 }
      })
    });
    titleLabel.anchor.set(0.5, 1.0);
    titleLabel.position.set(0, -82);
    playerContainer.addChild(titleLabel);

    this.entitiesContainer.addChild(playerContainer);

    this.localPlayer = {
      container: playerContainer,
      idleAnim,
      runAnim,
      isMoving: false,
      targetX: x,
      targetY: y,
      speed: 4.8
    };
  }

  private moveLocalPlayerTo(targetX: number, targetY: number): void {
    if (!this.localPlayer) return;

    this.localPlayer.targetX = targetX;
    this.localPlayer.targetY = targetY;
    this.localPlayer.isMoving = true;

    const isLeft = targetX < this.localPlayer.container.x;
    this.localPlayer.idleAnim.visible = false;
    if (this.localPlayer.runAnim) {
      this.localPlayer.runAnim.visible = true;
      this.localPlayer.runAnim.scale.x = isLeft ? -1 : 1;
      this.localPlayer.runAnim.play();
    }
    this.localPlayer.idleAnim.scale.x = isLeft ? -1 : 1;

    const movePkt = new PacketWriter(Opcodes.CS_LOBBY_Town_Move)
      .writeUInt16BE(Math.round(targetX))
      .writeUInt16BE(Math.round(targetY));
    NetworkClient.getInstance().send(movePkt);
  }

  /**
   * Spawna um balão de diálogo vivo sobre um NPC da vila.
   */
  private showRandomSpeechBubble(): void {
    if (this.npcs.size === 0) return;
    if (this.activeSpeechBubble) {
      this.speechBubbleContainer.removeChild(this.activeSpeechBubble);
      this.activeSpeechBubble.destroy();
      this.activeSpeechBubble = null;
    }

    const quotes: Record<string, string> = {
      'Naruto': 'Um dia serei o maior Hokage, Dattebayo!',
      'Iruka Umino': 'Estudem com afinco na Academia Ninja!',
      'Kakashi Hatake': 'Hmm... onde foi que deixei meu livro?',
      '3º Hokage': 'A Vontade do Fogo queima em cada um de nós.',
      'Sasuke Uchiha': 'Não tenho tempo a perder...',
      'Jiraiya': 'A verdadeira força de um ninja está em seu coração.',
      'Rock Lee': 'A chama da juventude arde intensamente hoje!',
      'Terumi Mei': 'O casamento perfeito exige paciência e fogo...',
      'City Gate': 'Portões abertos. Boa viagem, shinobi!'
    };

    const npcList = Array.from(this.npcs.values());
    const chosen = npcList[Math.floor(Math.random() * npcList.length)];
    const text = quotes[chosen.entry.name] || `${chosen.entry.name}: Aldeia da Folha em paz!`;

    const bubble = new Container();
    bubble.position.set(chosen.container.x, chosen.container.y - 125);
    bubble.zIndex = 10000;

    const speechTxt = new Text({
      text,
      style: new TextStyle({
        fontSize: 11,
        fill: '#1a1a1a',
        fontWeight: 'bold',
        wordWrap: true,
        wordWrapWidth: 160
      })
    });
    speechTxt.anchor.set(0.5, 0.5);

    const w = Math.max(120, speechTxt.width + 18);
    const h = speechTxt.height + 12;

    const bg = new Graphics()
      .roundRect(-w / 2, -h / 2, w, h, 6)
      .fill({ color: 0xffffff, alpha: 0.95 })
      .stroke({ color: 0x333333, width: 1.5 })
      .poly([-6, h / 2, 0, h / 2 + 7, 6, h / 2])
      .fill({ color: 0xffffff, alpha: 0.95 })
      .stroke({ color: 0x333333, width: 1.5 });

    bubble.addChild(bg);
    bubble.addChild(speechTxt);

    this.speechBubbleContainer.addChild(bubble);
    this.activeSpeechBubble = bubble;

    // Fading out após 4.5 segundos
    let life = 0;
    const fadeTicker = (delta: any) => {
      life += delta.deltaTime;
      if (life > 160) {
        bubble.alpha -= 0.04 * delta.deltaTime;
        if (bubble.alpha <= 0) {
          Ticker.shared.remove(fadeTicker);
          if (this.activeSpeechBubble === bubble) {
            this.speechBubbleContainer.removeChild(bubble);
            bubble.destroy();
            this.activeSpeechBubble = null;
          }
        }
      }
    };
    Ticker.shared.add(fadeTicker);
  }

  private update(): void {
    this.animTick += 0.05;

    // 1. Atualizar posição do jogador local
    if (this.localPlayer && this.localPlayer.isMoving) {
      const dx = this.localPlayer.targetX - this.localPlayer.container.x;
      const dy = this.localPlayer.targetY - this.localPlayer.container.y;
      const dist = Math.hypot(dx, dy);

      if (dist < this.localPlayer.speed) {
        this.localPlayer.container.x = this.localPlayer.targetX;
        this.localPlayer.container.y = this.localPlayer.targetY;
        this.localPlayer.isMoving = false;

        if (this.localPlayer.runAnim) {
          this.localPlayer.runAnim.stop();
          this.localPlayer.runAnim.visible = false;
        }
        this.localPlayer.idleAnim.visible = true;
        this.localPlayer.idleAnim.play();
      } else {
        this.localPlayer.container.x += (dx / dist) * this.localPlayer.speed;
        this.localPlayer.container.y += (dy / dist) * this.localPlayer.speed;
      }
    }

    // 2. Atualizar outros jogadores remotos
    for (const remote of this.otherPlayers.values()) {
      if (remote.isMoving) {
        const dx = remote.targetX - remote.container.x;
        const dy = remote.targetY - remote.container.y;
        const dist = Math.hypot(dx, dy);

        if (dist < remote.speed) {
          remote.container.x = remote.targetX;
          remote.container.y = remote.targetY;
          remote.isMoving = false;
          if (remote.runAnim) {
            remote.runAnim.stop();
            remote.runAnim.visible = false;
          }
          remote.idleAnim.visible = true;
          remote.idleAnim.play();
        } else {
          remote.container.x += (dx / dist) * remote.speed;
          remote.container.y += (dy / dist) * remote.speed;
        }
      }
    }

    // 3. Ordenação de profundidade Y-Sorting (personagens mais abaixo ficam na frente)
    for (const child of this.entitiesContainer.children) {
      if (child.zIndex !== 0) { // Não altera o zIndex do marcador de chão
        child.zIndex = child.y;
      }
    }

    // 4. Animação de respiração viva e pulo do '!' nos NPCs
    let idx = 0;
    for (const npc of this.npcs.values()) {
      idx++;
      const breath = Math.sin(this.animTick + idx * 0.8) * 1.4;
      npc.container.y = npc.baseY + breath;
      npc.questMarker.y = -110 + Math.sin(this.animTick * 2 + idx) * 3.5;
    }

    // 5. Câmera Parallax Autêntica de 3 Camadas
    let currentCamX = 0;
    if (this.localPlayer) {
      if (this.townHud) {
        this.townHud.updateCoordinates(this.localPlayer.container.x, this.localPlayer.container.y);
      }
      const targetCamX = 625 - this.localPlayer.container.x;
      const clampedCamX = Math.max(-(this.currentMapWidth - 1250), Math.min(0, targetCamX));
      currentCamX = clampedCamX;

      // Camada 1 (Walkable ground): Velocidade 1.0x
      this.worldContainer.x = clampedCamX;

      // Camada 0 (Fundo distante / céu): Velocidade 0.25x (FBG1ToBG3 em TLayerBackGround.as)
      this.parallaxContainer0.x = clampedCamX * 0.25;

      // Camada 2 (Intermediária / telhados): Velocidade 0.50x (FBG2ToBG3 em TLayerBackGround.as)
      this.parallaxContainer2.x = clampedCamX * 0.50;
    }

    // 6. Atualização de partículas de folhas ao vento (MC_Leaf)
    const viewLeft = -currentCamX - 60;
    const viewRight = -currentCamX + 1310;

    for (const leaf of this.leaves) {
      leaf.x += leaf.vx + Math.sin(this.animTick * 0.8 + leaf.wobble) * 0.6;
      leaf.y += leaf.vy + Math.cos(this.animTick * 0.8 + leaf.wobble) * 0.3;
      leaf.rot += leaf.vRot;
      leaf.tumble += leaf.vTumble;

      // Rotação e Tumbling 3D (folha virando no ar)
      leaf.graphic.rotation = leaf.rot;
      leaf.graphic.scale.x = Math.cos(leaf.tumble) * leaf.baseScale;

      // Wrap-around contínuo dentro do campo de visão da câmera
      if (leaf.x > viewRight || leaf.y > 660) {
        leaf.x = viewLeft - 20 + Math.random() * 40;
        leaf.y = Math.random() * 400;
      }
      leaf.graphic.position.set(leaf.x, leaf.y);
    }

    // 7. Vapor do Ramen Ichiraku
    if (this.currentCityId === 23200001 && Math.random() < 0.25) {
      this.emitRamenSteam();
    }
    for (let i = this.steamPuffs.length - 1; i >= 0; i--) {
      const p = this.steamPuffs[i];
      p.life++;
      p.x += p.vx;
      p.y += p.vy;
      p.scale += 0.015;
      p.alpha = Math.max(0, 0.45 * (1 - p.life / p.maxLife));

      p.graphic.position.set(p.x, p.y);
      p.graphic.scale.set(p.scale);
      p.graphic.alpha = p.alpha;

      if (p.life >= p.maxLife) {
        this.propsContainer.removeChild(p.graphic);
        p.graphic.destroy();
        this.steamPuffs.splice(i, 1);
      }
    }

    // 8. Pulsação suave das lanternas da vila
    for (const l of this.lanterns) {
      l.graphic.alpha = 0.25 + 0.12 * Math.sin(this.animTick * 1.2 + l.offset);
    }

    // 9. Ondulações do riacho dos Subúrbios
    for (const wr of this.waterRipples) {
      wr.graphic.x = wr.baseX + Math.sin(this.animTick * wr.speed + wr.offset) * 12;
      wr.graphic.alpha = 0.25 + 0.18 * Math.sin(this.animTick * 2 + wr.offset);
    }

    // 10. Diálogos vivos dos NPCs a cada 12 segundos
    this.speechTimer += 0.05;
    if (this.speechTimer >= 220) {
      this.speechTimer = 0;
      this.showRandomSpeechBubble();
    }
  }

  /**
   * Mapeamento visual autêntico de todos os 28 NPCs canônicos de ambas as cidades.
   */
  private getNpcVisualConfig(npcId: number): { folder: string; frames: number; scale?: number } {
    switch (npcId) {
      // Subúrbios Novatos (23100001)
      case 22100001: return { folder: 'city_gate', frames: 10 };      // City Gate
      case 22100003: return { folder: 'hokage3', frames: 11 };        // 3º Hokage
      case 22100004: return { folder: 'iruka', frames: 8 };           // Iruka
      case 22100005: return { folder: 'kakashi', frames: 6 };         // Kakashi
      case 22100006: return { folder: 'naruto', frames: 10 };         // Naruto
      case 22100007: return { folder: 'sasuke', frames: 5 };          // Sasuke
      case 22100008: return { folder: 'ibiki', frames: 6 };           // Ibiki
      case 22100009: return { folder: 'anko', frames: 4 };            // Anko
      case 22100010: return { folder: 'hayate', frames: 7 };          // Gekkou Hayate
      case 22100011: return { folder: 'jiraiya', frames: 6 };         // Jiraiya
      case 22100012: return { folder: 'gaara', frames: 6 };           // Gaara
      case 22100013: return { folder: 'sakura', frames: 6 };          // Tsunade (Taverna)
      case 22100014: return { folder: 'konohamaru', frames: 5 };      // Sarutobi Konohamaru

      // Vila de Konoha (23200001)
      case 22200013: return { folder: 'city_gate', frames: 10 };      // City Gate
      case 22200001: return { folder: 'sasuke', frames: 5 };          // Sasuke
      case 22200002: return { folder: 'kakashi', frames: 6 };         // Kakashi (Transform)
      case 22200003: return { folder: 'naruto', frames: 10 };         // Naruto
      case 22200004: return { folder: 'sakura', frames: 6 };          // Tsunade (Taverna)
      case 22200005: return { folder: 'iruka', frames: 8 };           // Iruka
      case 22200006: return { folder: 'ibiki', frames: 6 };           // Ibiki (Jade)
      case 22200007: return { folder: 'gaara', frames: 6 };           // Gaara
      case 22200008: return { folder: 'hayate', frames: 7 };          // Gekkou Hayate
      case 22200009: return { folder: 'naruto', frames: 10 };         // Sage Naruto
      case 22200010: return { folder: 'sasuke', frames: 5 };          // White Coat Sasuke
      case 22200011: return { folder: 'jiraiya', frames: 6 };         // Jiraiya
      case 22200012: return { folder: 'rock_lee', frames: 6 };        // Deus dos Artesãos (Forja)
      case 22200030: return { folder: 'hokage3', frames: 11 };        // 1º Hokage
      case 22200031: return { folder: 'tenten', frames: 6 };          // Terumi Mei (Casamento)

      default: return { folder: 'hinata', frames: 6 };
    }
  }

  private async spawnNpc(npc: NpcEntry): Promise<void> {
    if (this.npcs.has(npc.id)) return;

    const cfg = this.getNpcVisualConfig(npc.id);
    const frames = await this.loadFrames(cfg.folder, 'idle', cfg.frames);

    const npcContainer = new Container();
    npcContainer.position.set(npc.x, npc.y);
    npcContainer.eventMode = 'static';
    npcContainer.cursor = 'pointer';

    // Sombra
    const shadow = new Graphics()
      .ellipse(0, 0, 22, 6)
      .fill({ color: 0x000000, alpha: 0.35 });
    npcContainer.addChild(shadow);

    // Sprite Animado
    const anim = new AnimatedSprite(frames);
    anim.anchor.set(0.5, 1.0);
    anim.animationSpeed = 0.12;
    anim.play();
    if (cfg.scale) anim.scale.set(cfg.scale);
    npcContainer.addChild(anim);

    // Marcador de Missão / Diálogo (!) Saltitante
    const questMarker = new Text({
      text: '!',
      style: new TextStyle({
        fontSize: 22,
        fontWeight: 'bold',
        fill: '#ffd700',
        stroke: { color: '#000000', width: 3.5 }
      })
    });
    questMarker.anchor.set(0.5, 1.0);
    questMarker.position.set(0, -110);
    npcContainer.addChild(questMarker);

    // Nome e Título do NPC
    const nameLabel = new Text({
      text: npc.name,
      style: new TextStyle({
        fontSize: 12,
        fontWeight: 'bold',
        fill: '#ffd700',
        stroke: { color: '#161b22', width: 3 }
      })
    });
    nameLabel.anchor.set(0.5, 1.0);
    nameLabel.position.set(0, -92);
    npcContainer.addChild(nameLabel);

    if (npc.npcTitle) {
      const titleLabel = new Text({
        text: `[${npc.npcTitle}]`,
        style: new TextStyle({
          fontSize: 10,
          fill: '#e6edf3',
          stroke: { color: '#161b22', width: 2 }
        })
      });
      titleLabel.anchor.set(0.5, 1.0);
      titleLabel.position.set(0, -80);
      npcContainer.addChild(titleLabel);
    }

    // Clique no NPC -> Mover até ele e solicitar diálogo
    npcContainer.on('pointerdown', (e) => {
      e.stopPropagation();
      console.log(`[CLIENT] Interagindo com NPC: ${npc.name} (#${npc.id})`);
      
      this.moveLocalPlayerTo(npc.x - 50, npc.y);

      const talkPkt = new PacketWriter(Opcodes.CS_LOBBY_Town_TalkNpc)
        .writeUInt32BE(npc.id);
      NetworkClient.getInstance().send(talkPkt);
    });

    this.entitiesContainer.addChild(npcContainer);
    this.npcs.set(npc.id, {
      entry: npc,
      container: npcContainer,
      anim,
      questMarker,
      baseY: npc.y
    });
  }

  private setupNetworkHandlers(): void {
    const net = NetworkClient.getInstance();

    // SC_Enter_Town (0x01180200) - Confirmação e dados de spawn ao entrar numa cidade
    net.on(Opcodes.SC_Enter_Town, async (reader: PacketReader) => {
      const cityId = reader.readUInt32BE();
      const spawnX = reader.readUInt16BE();
      const spawnY = reader.readUInt16BE();
      console.log(`[CLIENT] Recebido SC_Enter_Town: Vila #${cityId} spawn (${spawnX}, ${spawnY})`);
      await this.switchCity(cityId, spawnX, spawnY);
    });

    // SC_LOBBY_Town_NpcList (0x01180303)
    net.on(Opcodes.SC_LOBBY_Town_NpcList, async (reader: PacketReader) => {
      const count = reader.readInt16BE();
      console.log(`[CLIENT] Recebida lista com ${count} NPCs da vila.`);

      for (let i = 0; i < count; i++) {
        const id = reader.readUInt32BE();
        const name = reader.readFlushUTF();
        const npcTitle = reader.readFlushUTF();
        const x = reader.readInt16BE();
        const y = reader.readInt16BE();
        const userType = reader.readUInt8();

        await this.spawnNpc({ id, name, npcTitle, x, y, userType });
      }
    });

    // SC_LOBBY_Town_NpcDialog (0x01180305)
    net.on(Opcodes.SC_LOBBY_Town_NpcDialog, (reader: PacketReader) => {
      const npcId = reader.readUInt32BE();
      const npcName = reader.readFlushUTF();
      const dialogText = reader.readFlushUTF();
      const optionsCount = reader.readInt16BE();
      const options: Array<{ label: string; action: string }> = [];

      for (let i = 0; i < optionsCount; i++) {
        const label = reader.readFlushUTF();
        const action = reader.readFlushUTF();
        options.push({ label, action });
      }

      console.log(`[CLIENT] Abrindo diálogo com ${npcName}: "${dialogText}" (${options.length} opções)`);
      this.npcDialogModal.showDialog({
        npcId,
        name: npcName,
        npcTitle: '',
        talk: dialogText,
        action: options.length > 0 ? options[0].action : ''
      });
    });

    // SC_LOBBY_Town_NewRoleNtf (0x01180301)
    net.on(Opcodes.SC_LOBBY_Town_NewRoleNtf, async (reader: PacketReader) => {
      const count = reader.readInt16BE();
      for (let i = 0; i < count; i++) {
        const charId = reader.readUInt32BE();
        const name = reader.readFlushUTF();
        const profession = reader.readUInt32BE();
        const gender = reader.readUInt16BE();
        const level = reader.readUInt32BE();
        const x = reader.readUInt16BE();
        const y = reader.readUInt16BE();

        if (charId === this.playerProfile.charId) continue;
        if (this.otherPlayers.has(charId)) continue;

        const folder = this.getPlayerAssetFolder(profession, gender);
        const [idleFrames, runFrames] = await Promise.all([
          this.loadFrames(folder, 'idle', 6),
          this.loadFrames(folder, 'run', 8)
        ]);

        const remoteCont = new Container();
        remoteCont.position.set(x, y);

        const shadow = new Graphics()
          .ellipse(0, 0, 22, 6)
          .fill({ color: 0x000000, alpha: 0.4 });
        remoteCont.addChild(shadow);

        const idleAnim = new AnimatedSprite(idleFrames);
        idleAnim.anchor.set(0.5, 1.0);
        idleAnim.animationSpeed = 0.14;
        idleAnim.play();
        remoteCont.addChild(idleAnim);

        let runAnim: AnimatedSprite | undefined;
        if (runFrames.length > 0 && runFrames[0] !== Texture.WHITE) {
          runAnim = new AnimatedSprite(runFrames);
          runAnim.anchor.set(0.5, 1.0);
          runAnim.animationSpeed = 0.22;
          runAnim.visible = false;
          remoteCont.addChild(runAnim);
        }

        const nameLabel = new Text({
          text: `${name} (Lv.${level})`,
          style: new TextStyle({
            fontSize: 12,
            fontWeight: 'bold',
            fill: '#ffffff',
            stroke: { color: '#000000', width: 3 }
          })
        });
        nameLabel.anchor.set(0.5, 1.0);
        nameLabel.position.set(0, -90);
        remoteCont.addChild(nameLabel);

        this.entitiesContainer.addChild(remoteCont);
        this.otherPlayers.set(charId, {
          container: remoteCont,
          idleAnim,
          runAnim,
          isMoving: false,
          targetX: x,
          targetY: y,
          speed: 4.5
        });
      }
    });

    // SC_LOBBY_Town_RoleMove (0x01180302)
    net.on(Opcodes.SC_LOBBY_Town_RoleMove, (reader: PacketReader) => {
      const charId = reader.readUInt32BE();
      const targetX = reader.readUInt16BE();
      const targetY = reader.readUInt16BE();

      const remote = this.otherPlayers.get(charId);
      if (remote) {
        remote.targetX = targetX;
        remote.targetY = targetY;
        remote.isMoving = true;

        const isLeft = targetX < remote.container.x;
        remote.idleAnim.visible = false;
        if (remote.runAnim) {
          remote.runAnim.visible = true;
          remote.runAnim.scale.x = isLeft ? -1 : 1;
          remote.runAnim.play();
        }
        remote.idleAnim.scale.x = isLeft ? -1 : 1;
      }
    });

    // SC_LOBBY_Town_RemoveRole (0x01180304)
    net.on(Opcodes.SC_LOBBY_Town_RemoveRole, (reader: PacketReader) => {
      const charId = reader.readUInt32BE();
      const remote = this.otherPlayers.get(charId);
      if (remote) {
        this.entitiesContainer.removeChild(remote.container);
        remote.container.destroy();
        this.otherPlayers.delete(charId);
      }
    });
  }

  private createHUD(): void {
    this.townHud = new TownHUD(this.playerProfile, {
      onQuestClick: (npcName: string) => {
        console.log(`[CLIENT] Auto-caminho para missão: ${npcName}`);
        for (const npc of this.npcs.values()) {
          if (npc.entry.name.toLowerCase().includes(npcName.toLowerCase())) {
            this.moveLocalPlayerTo(npc.container.x - 50, npc.container.y);
            this.spawnClickMarker(npc.container.x - 50, npc.container.y);
            break;
          }
        }
      },
      onBgmToggle: () => {
        this.toggleBgm();
      },
      onBattleTest: () => {
        console.log('[CLIENT] Solicitando Batalha PvE via CS_BattleStart...');
        const battlePkt = new PacketWriter(Opcodes.CS_BattleStart)
          .writeUInt32BE(1);
        NetworkClient.getInstance().send(battlePkt);
      },
      onChatSend: (channel: string, message: string) => {
        console.log(`[CLIENT] Mensagem no chat [${channel}]: ${message}`);
      }
    });

    this.hudContainer.addChild(this.townHud);
  }

  public override destroy(options?: any): void {
    if (this.townHud) {
      this.townHud.destroy();
    }
    Ticker.shared.remove(this.update, this);
    if (this.bgmAudio) {
      this.bgmAudio.pause();
      this.bgmAudio = null;
    }
    super.destroy(options);
  }
}
