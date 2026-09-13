import { Container, Graphics, Text, FederatedPointerEvent, Ticker, Sprite, Assets, Texture } from 'pixi.js';
import { clientSocket, WebPacketWriter } from '../network/clientSocket.ts';
import { OPCODES } from '../../../shared/opcodes.ts';
import { gameApp } from '../core/app.ts';
import { BattleScene } from './BattleScene.ts';
import { readBattleStartPacket } from '../network/battlePackets.ts';
import { InventoryModal } from './InventoryModal.ts';
import { TavernModal } from './TavernModal.ts';
import { FormationModal } from './FormationModal.ts';
import { NpcDialogModal, DialogAction } from './NpcDialogModal.ts';
import { CampaignWindow } from './CampaignWindow.ts';
import { WorldMapWindow } from './WorldMapWindow.ts';
import { PetWindow } from './PetWindow.ts';
import { GameModesWindow } from './GameModesWindow.ts';
import { SmithyModal } from './SmithyModal.ts';
import { NpcFunctionBadge, NpcFunctionType } from './NpcFunctionBadge.ts';
import {
  AUTHENTIC_NPCS,
  AUTHENTIC_HEROES,
  ALL_ANIMATED_ASSETS,
  NOVICE_SUBURB_NPCS,
  KONOHA_VILLAGE_NPCS,
  type NPCConfig,
} from './animatedAssets.ts';
import { NinjaAvatarView } from './NinjaAvatarView.ts';

export interface LocalNinjaData {
  charId: number;
  name: string;
  profession: number;
  gender?: number;
  level: number;
}

export function getProfessionTitle(prof: number): string {
  switch (prof) {
    case 1:
      return 'Ninjutsu';
    case 3:
      return 'Genjutsu';
    case 4:
      return 'Taijutsu';
    default:
      return 'Shinobi';
  }
}

interface RemotePlayerEntity {
  charId: number;
  name: string;
  profession: number;
  level: number;
  container: Container;
  currentX: number;
  currentY: number;
  targetX: number;
  targetY: number;
}

// Escala oficial para o sprite Lâmina das Trevas (398x448 -> ~110px de altura)
const NINJA_SPRITE_SCALE = 110 / 448; // ~0.2455

export class TownScene extends Container {
  // Constantes oficiais do mapa de Konoha extraídas dos scripts AS3 (CONST_COMMON.as e CONST_MainScene.as)
  public static readonly MAP_WIDTH: number = 2500;
  public static readonly MAP_HEIGHT: number = 650;
  public static readonly VIEWPORT_WIDTH: number = 1250;
  public static readonly VIEWPORT_HEIGHT: number = 650;
  public static readonly WALK_MIN_Y: number = 370;
  public static readonly WALK_MAX_Y: number = 650;
  public static readonly MOVE_SPEED: number = 7; // pixels por frame

  // Identificação e dados da Cidade Ativa
  public currentCityId: number = 23200001; // 23200001: Konoha Village | 23100001: Novice Suburb

  // Camadas principais
  private worldContainer: Container;
  private groundLayer: Container;
  private playersLayer: Container;
  private hudContainer: Container;

  // Jogador Local
  private localData: LocalNinjaData;
  private localPlayerContainer!: Container;
  public localX: number = 1200;
  public localY: number = 500;
  private localTargetX: number = 1200;
  private localTargetY: number = 500;

  // Jogadores Remotos
  private remotePlayers: Map<number, RemotePlayerEntity> = new Map();

  // Elementos da HUD
  private profileContainer!: Container;
  private bottomBarContainer!: Container;
  private btnBattle!: Container;
  private txtCoord!: Text;
  private txtPlayersCount!: Text;
  private txtCityTitle!: Text;

  // Janelas Modais dos Sistemas do Jogo
  public inventoryModal!: InventoryModal;
  public tavernModal!: TavernModal;
  public formationModal!: FormationModal;
  public smithyModal!: SmithyModal;
  public npcDialogModal!: NpcDialogModal;
  public campaignWindow!: CampaignWindow;
  public worldMapWindow!: WorldMapWindow;
  public petWindow!: PetWindow;
  public gameModesWindow!: GameModesWindow;
  private unsubs: (() => void)[] = [];
  public isReady: boolean = false;
  private initPromise: Promise<void>;

  // Texturas em cache
  private texturesLoaded: boolean = false;
  private ninjaTexture: Texture | null = null;
  private npcViews: NinjaAvatarView[] = [];
  private npcBadges: NpcFunctionBadge[] = [];
  private npcContainers: Container[] = [];
  private localAvatarView!: NinjaAvatarView;
  private remoteAvatarViews: Map<number, NinjaAvatarView> = new Map();
  private facingDir: number = 1;

  // Listener de ticker e redimensionamento
  private tickerUpdateFn!: () => void;
  private resizeHandler!: () => void;

  constructor(myCharData: LocalNinjaData, spawnX: number = 1200, spawnY: number = 500) {
    super();

    this.localData = myCharData;
    // Respeita os limites oficiais de caminhabilidade (Y: 370 a 650)
    this.localX = Math.max(50, Math.min(TownScene.MAP_WIDTH - 50, spawnX));
    this.localY = Math.max(TownScene.WALK_MIN_Y, Math.min(TownScene.WALK_MAX_Y, spawnY));
    this.localTargetX = this.localX;
    this.localTargetY = this.localY;

    // Inicializa containers da hierarquia PixiJS
    this.worldContainer = new Container();
    this.groundLayer = new Container();
    this.playersLayer = new Container();
    this.hudContainer = new Container();

    // Habilita Z-Sorting automático por profundidade Y para ninjas e NPCs
    this.playersLayer.sortableChildren = true;
    this.hudContainer.sortableChildren = true;

    this.worldContainer.addChild(this.groundLayer);
    this.worldContainer.addChild(this.playersLayer);

    this.addChild(this.worldContainer);
    this.addChild(this.hudContainer);

    this.setupModals();
    this.setupNetworkHandlers();

    this.initPromise = this.initScene();
  }

  public async init(): Promise<void> {
    await this.initPromise;
  }

  /**
   * Ciclo de inicialização assíncrono: carrega os assets e monta os componentes
   */
  private async initScene(): Promise<void> {
    await this.loadAllAssets();
    this.setupGround();
    this.setupNPCs();
    this.createLocalPlayer();
    this.setupHUD();
    this.setupTicker();
    this.setupResizeListener();
    this.updateCamera();
    this.isReady = true;

    console.log(
      `[TownScene] Konohagakure (Autêntica) inicializada para ${this.localData.name} em (${this.localX}, ${this.localY})`
    );
  }

  /**
   * Pré-carrega todas as texturas migradas do Flash original
   */
  private async loadAllAssets(): Promise<void> {
    try {
      const assetList = [
        '/assets/town/bg_konoha_shrine.jpg',
        '/assets/town/ichiraku_shop.png',
        '/assets/town/ichiraku_noren.png',
        '/assets/town/prop_lanterns.png',
        '/assets/town/prop_sign.png',
        '/assets/town/ninja_blade.png',
        '/assets/town/npc_teuchi.png',
        '/assets/town/npc_ayame.png',
        '/assets/ui/profile_frame.png',
        '/assets/ui/currency_bar.png',
        '/assets/ui/avatar_blade.png',
        '/assets/ui/bottom_bar.png',
        '/assets/ui/btn_team.png',
        '/assets/ui/btn_bag.png',
        '/assets/ui/btn_formation.png',
        '/assets/ui/btn_summon.png',
        '/assets/ui/btn_map.png',
        '/assets/ui/modal_bag.png',
        '/assets/ui/modal_hero.png',
        '/assets/ui/modal_formation.png',
        '/assets/ui/btn_close.png',
        '/assets/ui/btn_close_hover.png',
        '/assets/tavern/bg_tavern.jpg',
        '/assets/tavern/mora_rock.png',
        '/assets/tavern/mora_scissors.png',
        '/assets/tavern/mora_paper.png',
        '/assets/ninjas/ninja_naruto.png',
        '/assets/ninjas/ninja_sasuke.png',
        '/assets/ninjas/ninja_sakura.png',
        '/assets/ninjas/ninja_hinata.png',
        '/assets/items/item_kunai.png',
        '/assets/items/item_headband.png',
        '/assets/items/item_vest.png',
        '/assets/items/item_belt.png',
        '/assets/items/item_sandals.png',
        '/assets/items/item_ring.png',
        '/assets/items/item_ramen_bowl.png',
        '/assets/items/item_chakra_scroll.png',
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

      const fullList = [...assetList, ...ALL_ANIMATED_ASSETS];
      await Promise.all(fullList.map((path) => Assets.load(path).catch((e) => console.warn(`Falha ao carregar ${path}:`, e))));
      this.ninjaTexture = Assets.get('/assets/town/ninja_blade.png') || null;
      this.texturesLoaded = true;
      console.log(`[TownScene] Todos os ${fullList.length} assets autênticos de Konoha carregados com sucesso!`);
    } catch (err) {
      console.error('[TownScene] Erro ao carregar pacote de assets:', err);
    }
  }

  /**
   * Constrói o mundo exterior de Konoha:
   * - Fundo panorâmico 2500x650 (bg_konoha_shrine.jpg duplicado)
   * - Fachada do Ichiraku Ramen (ichiraku_shop.png) em X=900, Y=140
   * - Cortina Noren (ichiraku_noren.png)
   * - Lanternas e placas de rua (prop_lanterns.png e prop_sign.png)
   */
  /**
   * Constrói o mundo exterior adaptado à cidade ativa:
   * - 23100001 (Subúrbio dos Novatos): Ambiente florestal sereno, alvos de treino, placas rústicas
   * - 23200001 (Vila de Konoha): Centro urbano, Ichiraku Ramen, lanternas vermelhas, lojas
   */
  private setupGround(): void {
    this.groundLayer.removeChildren();

    const isNovice = this.currentCityId === 23100001;

    // 1. Fundo fallback com atmosfera adaptada
    const bgFallback = new Graphics();
    bgFallback.rect(0, 0, TownScene.MAP_WIDTH, TownScene.MAP_HEIGHT);
    bgFallback.fill(isNovice ? 0x0f291e : 0x1a2e22);
    this.groundLayer.addChild(bgFallback);

    // 2. Fundo sagrado panorâmico (1250x650 x2 = 2500x650)
    const shrineTex = Assets.get('/assets/town/bg_konoha_shrine.jpg');
    if (shrineTex) {
      const shrine1 = new Sprite(shrineTex);
      shrine1.position.set(0, 0);
      shrine1.width = TownScene.VIEWPORT_WIDTH;
      shrine1.height = TownScene.MAP_HEIGHT;
      if (isNovice) shrine1.tint = 0xa7f3d0; // Toque matutino e arborizado para os arredores/treinamento
      this.groundLayer.addChild(shrine1);

      const shrine2 = new Sprite(shrineTex);
      shrine2.position.set(TownScene.VIEWPORT_WIDTH, 0);
      shrine2.width = TownScene.VIEWPORT_WIDTH;
      shrine2.height = TownScene.MAP_HEIGHT;
      if (isNovice) shrine2.tint = 0xa7f3d0;
      this.groundLayer.addChild(shrine2);
    }

    if (isNovice) {
      // Cenário Exclusivo: Subúrbio dos Novatos / Campo de Treinamento
      // Placas rústicas de orientação da floresta
      const signTex = Assets.get('/assets/town/prop_sign.png');
      if (signTex) {
        [400, 950, 1550, 2150].forEach((sx) => {
          const s = new Sprite(signTex);
          s.position.set(sx, 440);
          this.groundLayer.addChild(s);
        });
      }

      // Lanternas de madeira entre os caminhos da floresta
      const lanternTex = Assets.get('/assets/town/prop_lanterns.png');
      if (lanternTex) {
        [720, 1420, 2050].forEach((lx) => {
          const l = new Sprite(lanternTex);
          l.position.set(lx, 260);
          this.groundLayer.addChild(l);
        });
      }

      // Área de treino: Alvos e bonecos de palha desenhados
      const trainingDecor = new Graphics();
      // Alvo de shuriken 1 (X=580)
      trainingDecor.rect(575, 410, 10, 50);
      trainingDecor.fill(0x78350f);
      trainingDecor.circle(580, 410, 22);
      trainingDecor.fill(0xfef08a);
      trainingDecor.circle(580, 410, 15);
      trainingDecor.fill(0xdc2626);
      trainingDecor.circle(580, 410, 8);
      trainingDecor.fill(0xffffff);

      // Alvo de shuriken 2 (X=1750)
      trainingDecor.rect(1745, 410, 10, 50);
      trainingDecor.fill(0x78350f);
      trainingDecor.circle(1750, 410, 22);
      trainingDecor.fill(0xfef08a);
      trainingDecor.circle(1750, 410, 15);
      trainingDecor.fill(0xdc2626);
      trainingDecor.circle(1750, 410, 8);
      trainingDecor.fill(0xffffff);

      this.groundLayer.addChild(trainingDecor);
    } else {
      // Cenário Exclusivo: Vila Central de Konoha
      // 3. Fachada oficial do Ichiraku Ramen (998x581) posicionada em X=900, Y=140
      const shopTex = Assets.get('/assets/town/ichiraku_shop.png');
      if (shopTex) {
        const shopSprite = new Sprite(shopTex);
        shopSprite.position.set(900, 140);
        this.groundLayer.addChild(shopSprite);
      }

      // 4. Cortina Tradicional Noren Ichiraku (349x129)
      const norenTex = Assets.get('/assets/town/ichiraku_noren.png');
      if (norenTex) {
        const norenSprite = new Sprite(norenTex);
        norenSprite.position.set(1225, 330);
        this.groundLayer.addChild(norenSprite);
      }

      // 5. Lanternas japonesas penduradas (prop_lanterns.png: 51x135)
      const lanternTex = Assets.get('/assets/town/prop_lanterns.png');
      if (lanternTex) {
        const lanternLeft = new Sprite(lanternTex);
        lanternLeft.position.set(930, 260);
        this.groundLayer.addChild(lanternLeft);

        const lanternRight = new Sprite(lanternTex);
        lanternRight.position.set(1840, 260);
        this.groundLayer.addChild(lanternRight);
      }

      // 6. Placas e postes de madeira da vila (prop_sign.png: 53x110)
      const signTex = Assets.get('/assets/town/prop_sign.png');
      if (signTex) {
        const signLeft = new Sprite(signTex);
        signLeft.position.set(820, 450);
        this.groundLayer.addChild(signLeft);

        const signRight = new Sprite(signTex);
        signRight.position.set(1960, 450);
        this.groundLayer.addChild(signRight);
      }
    }

    // 7. Delimitação sutil e elegante da linha de caminhada (Y = 370)
    const walkGuide = new Graphics();
    walkGuide.moveTo(0, TownScene.WALK_MIN_Y);
    walkGuide.lineTo(TownScene.MAP_WIDTH, TownScene.WALK_MIN_Y);
    walkGuide.stroke({ color: isNovice ? 0x10b981 : 0xf59e0b, width: 1.5, alpha: 0.25 });
    this.groundLayer.addChild(walkGuide);

    // 8. Evento de clique para movimentação no chão
    this.groundLayer.eventMode = 'static';
    this.groundLayer.cursor = 'crosshair';
    this.groundLayer.on('pointerdown', (e: FederatedPointerEvent) => {
      this.onGroundClick(e);
    });
  }

  /**
   * Adiciona os NPCs autênticos da cidade ativa com badges de função e interações dedicadas
   */
  private setupNPCs(): void {
    // Remove os NPCs anteriores com segurança
    for (const c of this.npcContainers) {
      this.playersLayer.removeChild(c);
      c.destroy({ children: true });
    }
    this.npcContainers = [];
    this.npcViews = [];
    this.npcBadges = [];

    const activeList = this.currentCityId === 23100001 ? NOVICE_SUBURB_NPCS : KONOHA_VILLAGE_NPCS;

    for (const cfg of activeList) {
      if (cfg.isStatic && cfg.path) {
        const staticContainer = this.createStaticNPC(
          cfg,
          cfg.name,
          cfg.role,
          cfg.path,
          cfg.x,
          cfg.y,
          cfg.talk,
          cfg.scale || 1.0
        );
        this.playersLayer.addChild(staticContainer);
        this.npcContainers.push(staticContainer);
      } else if (cfg.folder && cfg.frameCount) {
        const idleTextures: Texture[] = [];
        for (let i = 0; i < cfg.frameCount; i++) {
          const tex = Assets.get(`/assets/animated/npcs/${cfg.folder}/idle_${i}.png`);
          if (tex) idleTextures.push(tex);
        }

        const npcView = new NinjaAvatarView({
          name: cfg.name,
          roleTitle: cfg.role,
          idleTextures,
          scale: cfg.scale || 1.0,
          fps: 7,
        });
        npcView.position.set(cfg.x, cfg.y);
        npcView.zIndex = Math.floor(cfg.y);
        npcView.eventMode = 'static';
        npcView.cursor = 'pointer';

        // Anexa o badge oficial de função flutuante (Taverna, Forja, Portão, etc.)
        if (cfg.userType && cfg.userType > 0) {
          const badge = new NpcFunctionBadge(cfg.userType, -npcView.getEffectiveHeight() - 36);
          badge.eventMode = 'static';
          badge.cursor = 'pointer';
          badge.on('pointertap', (e: FederatedPointerEvent) => {
            e.stopPropagation();
            this.handleNpcFunctionAction(cfg);
          });
          npcView.addChild(badge);
          this.npcBadges.push(badge);
        }

        npcView.on('pointertap', () => {
          this.showSpeechBubble(cfg.x, cfg.y - npcView.getEffectiveHeight() - 20, cfg.talk);
          this.openNpcDialog(cfg);
        });

        this.playersLayer.addChild(npcView);
        this.npcViews.push(npcView);
        this.npcContainers.push(npcView);
      }
    }

    console.log(
      `[TownScene] ${activeList.length} NPCs canônicos carregados para a cidade #${this.currentCityId}`
    );
  }

  /**
   * Cria NPC estático para estabelecimentos especiais (Ichiraku Ramen, Portões)
   */
  private createStaticNPC(
    cfg: NPCConfig,
    name: string,
    role: string,
    texturePath: string,
    x: number,
    y: number,
    dialogue: string,
    customScale: number = 1.0
  ): Container {
    const npc = new Container();
    npc.position.set(x, y);
    npc.zIndex = Math.floor(y);
    npc.eventMode = 'static';
    npc.cursor = 'pointer';

    const shadow = new Graphics();
    shadow.ellipse(0, 0, 24 * customScale, 8 * customScale);
    shadow.fill({ color: 0x000000, alpha: 0.45 });
    npc.addChild(shadow);

    let effectiveHeight = 110;
    const tex = Assets.get(texturePath);
    if (tex && tex.width > 0) {
      const sprite = new Sprite(tex);
      sprite.anchor.set(0.5, 1);
      sprite.scale.set(customScale);
      effectiveHeight = (tex.height || 110) * customScale;
      npc.addChild(sprite);
    }

    const tagText = new Text({
      text: `${name} [${role}]`,
      style: {
        fill: '#fbbf24',
        fontSize: 12,
        fontWeight: 'bold',
        stroke: { color: '#000000', width: 3 },
      },
    });
    tagText.anchor.set(0.5, 1);
    tagText.position.set(0, -effectiveHeight - 8);
    npc.addChild(tagText);

    // Badge flutuante de função se aplicável
    if (cfg.userType && cfg.userType > 0) {
      const badge = new NpcFunctionBadge(cfg.userType, -effectiveHeight - 36);
      badge.eventMode = 'static';
      badge.cursor = 'pointer';
      badge.on('pointertap', (e: FederatedPointerEvent) => {
        e.stopPropagation();
        this.handleNpcFunctionAction(cfg);
      });
      npc.addChild(badge);
      this.npcBadges.push(badge);
    }

    npc.on('pointertap', () => {
      this.showSpeechBubble(x, y - effectiveHeight - 20, dialogue);
      this.openNpcDialog(cfg);
    });

    return npc;
  }

  /**
   * Aciona diretamente a interface canônica correspondente à função do NPC
   */
  public handleNpcFunctionAction(cfg: NPCConfig): void {
    console.log(`[TownScene] Interagindo com função de ${cfg.name} (Tipo: ${cfg.userType})`);
    switch (cfg.userType) {
      case NpcFunctionType.PUB:
        this.toggleWindow(this.tavernModal);
        break;
      case NpcFunctionType.MADE:
        this.toggleWindow(this.smithyModal);
        break;
      case NpcFunctionType.GATE:
        this.toggleWindow(this.worldMapWindow);
        break;
      case NpcFunctionType.GODEQUIP:
        this.toggleWindow(this.gameModesWindow);
        break;
      case NpcFunctionType.STONE:
      case NpcFunctionType.WAREHOUSE:
        this.toggleWindow(this.inventoryModal);
        break;
      case NpcFunctionType.MASTERROAD:
        this.toggleWindow(this.campaignWindow);
        break;
      case NpcFunctionType.STORY:
      default:
        this.openNpcDialog(cfg);
        break;
    }
  }

  /**
   * Exibe um balão de diálogo temporário animado sobre um NPC
   */
  private showSpeechBubble(x: number, y: number, text: string): void {
    const bubble = new Container();
    bubble.position.set(x, y);
    bubble.zIndex = 10000;

    const speechText = new Text({
      text,
      style: {
        fill: '#1e293b',
        fontSize: 12,
        fontWeight: '600',
        wordWrap: true,
        wordWrapWidth: 260,
      },
    });
    speechText.position.set(12, 8);

    const padW = speechText.width + 24;
    const padH = speechText.height + 16;

    const bg = new Graphics();
    bg.roundRect(0, 0, padW, padH, 8);
    bg.fill({ color: 0xffffff, alpha: 0.95 });
    bg.stroke({ color: 0xf59e0b, width: 2 });
    // Bico do balão
    bg.poly([padW / 2 - 8, padH, padW / 2 + 8, padH, padW / 2, padH + 8]);
    bg.fill(0xffffff);

    bubble.pivot.set(padW / 2, padH + 8);
    bubble.addChild(bg);
    bubble.addChild(speechText);
    this.playersLayer.addChild(bubble);

    // Fade out e destruição após 3.5 segundos
    let timer = 0;
    const fadeAnim = () => {
      timer += 1;
      if (timer > 90) {
        bubble.alpha -= 0.05;
        if (bubble.alpha <= 0) {
          Ticker.shared.remove(fadeAnim);
          bubble.destroy({ children: true });
        }
      }
    };
    Ticker.shared.add(fadeAnim);
  }

  /**
   * Abre o Modal Canônico de Diálogo (Visual Novel style) com ações interativas
   */
  public openNpcDialog(cfg: any): void {
    const name = cfg.name;
    let avatarPath = cfg.path;
    if (!avatarPath && cfg.folder) {
      avatarPath = `/assets/animated/npcs/${cfg.folder}/idle_0.png`;
    }

    let dialogue = cfg.talk;
    let actions: DialogAction[] = [];

    if (name.includes('God of Craftsman') || name.includes('Ferreiro') || cfg.userType === NpcFunctionType.MADE) {
      dialogue = 'O aço das lâminas de Konoha é temperado com o fogo da nossa determinação! Deseja aprimorar seus equipamentos ou forjar novas armas ninjas?';
      actions = [
        { label: '🔨 Forja de Equipamentos', onClick: () => this.toggleWindow(this.smithyModal), color: 0xb45309 },
        { label: '🎒 Mochila Shinobi', onClick: () => this.toggleWindow(this.inventoryModal), color: 0x15803d },
      ];
    } else if (name.includes('Hokage') || name.includes('Hiruzen')) {
      dialogue = 'A Vontade do Fogo arde no coração de cada shinobi de Konoha. Você está pronto para aceitar missões de Rank elevado e proteger os seus companheiros?';
      actions = [
        { label: '📜 Campanhas / Missões', onClick: () => this.toggleWindow(this.campaignWindow), color: 0xb45309 },
        { label: '⚔️ Modos de Combate', onClick: () => this.toggleWindow(this.gameModesWindow), color: 0xd97706 },
        { label: '🎒 Abrir Mochila', onClick: () => this.toggleWindow(this.inventoryModal), color: 0x15803d },
      ];
    } else if (name.includes('Iruka')) {
      dialogue = 'Bem-vindo de volta! A Taverna Shinobi está cheia de ninjas promissores procurando por um bom líder de equipe. Gostaria de convocar novos aliados ou treinar sua formação?';
      actions = [
        { label: '🥋 Formação Tática (15 Slots)', onClick: () => this.toggleWindow(this.formationModal), color: 0x2563eb },
        { label: '🍶 Taverna Ninja / Recrutar', onClick: () => this.toggleWindow(this.tavernModal), color: 0xb45309 },
        { label: '🎒 Mochila Shinobi', onClick: () => this.toggleWindow(this.inventoryModal), color: 0x15803d },
      ];
    } else if (name.includes('Teuchi')) {
      dialogue = 'Bem-vindo ao Ichiraku Ramen! Nosso lámen é feito com a melhor receita secreta de Konoha. Uma tigela bem quente recupera todo o seu chakra e vigor instantaneamente!';
      actions = [
        {
          label: '🍜 Comer Lámen Especial (+HP)',
          onClick: () => {
            this.showSpeechBubble(1150, 465 - 100, '🍜 Você saboreou um delicioso Lámen Ichiraku! Vigor restaurado!');
          },
          color: 0xd97706,
        },
        { label: '🎒 Mochila de Ingredientes', onClick: () => this.toggleWindow(this.inventoryModal), color: 0x15803d },
      ];
    } else if (name.includes('Ayame')) {
      dialogue = 'Oi! O papai acordou bem cedo preparando o caldo especial. Venha descansar um pouco antes de partir para a sua próxima missão!';
      actions = [
        {
          label: '🍵 Chá Verde Revigorante',
          onClick: () => {
            this.showSpeechBubble(1320, 475 - 100, '🍵 Chá verde revigorante degustado!');
          },
          color: 0x15803d,
        },
        { label: '🍜 Falar com o Chef Teuchi', onClick: () => this.triggerNpcByName('Teuchi'), color: 0xd97706 },
      ];
    } else if (name.includes('Tsunade') || cfg.userType === NpcFunctionType.PUB) {
      dialogue = 'Bem-vindo à Taverna! Se estiver com sorte, podemos disputar uma rodada de Mora (Jokenpô). Quem vencer leva os pontos de recrutamento para convocar ninjas de elite!';
      actions = [
        { label: '🍶 Taverna Shinobi', onClick: () => this.toggleWindow(this.tavernModal), color: 0xb45309 },
        { label: '✊ Jogar Mora (Jokenpô)', onClick: () => this.toggleWindow(this.tavernModal), color: 0xd97706 },
        { label: '🥋 Formação Tática', onClick: () => this.toggleWindow(this.formationModal), color: 0x2563eb },
      ];
    } else if (name.includes('Hayate') || cfg.userType === NpcFunctionType.GODEQUIP) {
      dialogue = '*Cof, cof*... Sou o examinador oficial das preliminares. Aqueles com bravura e destreza podem testar seu limite nos Modos de Combate e Arena Shinobi!';
      actions = [
        { label: '⚔️ Modos de Combate & Arena', onClick: () => this.toggleWindow(this.gameModesWindow), color: 0xd97706 },
        { label: '🏆 Desafio de Batalha (PvE)', onClick: () => this.startCampaignBattle(1), color: 0xdc2626 },
        { label: '🥋 Ajustar Formação', onClick: () => this.toggleWindow(this.formationModal), color: 0x2563eb },
      ];
    } else if (name.includes('Ibiki') || cfg.userType === NpcFunctionType.STONE) {
      dialogue = 'O futuro e a sobrevivência dependem da força mental e do poder das Magatamas e Jades equipadas nos seus pertences. Nunca subestime um inimigo.';
      actions = [
        { label: '💎 Magatamas & Jades', onClick: () => this.toggleWindow(this.inventoryModal), color: 0x059669 },
        { label: '🎒 Mochila Shinobi', onClick: () => this.toggleWindow(this.inventoryModal), color: 0x15803d },
      ];
    } else if (name.includes('Jiraiya') || cfg.userType === NpcFunctionType.WAREHOUSE) {
      dialogue = 'Hahaha! O grande Sábio dos Sapos do Monte Myōboku chegou! Guardo os segredos mais profundos e os tesouros shinobi no grande Armazém de Konoha!';
      actions = [
        { label: '📦 Armazém Shinobi', onClick: () => this.toggleWindow(this.inventoryModal), color: 0xb45309 },
        { label: '🍶 Taverna Shinobi', onClick: () => this.toggleWindow(this.tavernModal), color: 0x15803d },
      ];
    } else if (name.includes('Hashirama') || cfg.userType === NpcFunctionType.MASTERROAD) {
      dialogue = 'Eu fundei esta vila para que as próximas gerações vivessem em harmonia. O Caminho do Mestre exige perseverança indomável e espírito inquebrável!';
      actions = [
        { label: '📜 Caminho do Mestre', onClick: () => this.toggleWindow(this.campaignWindow), color: 0x1e3a8a },
        { label: '🥋 Formação Lendária', onClick: () => this.toggleWindow(this.formationModal), color: 0x2563eb },
      ];
    } else if (name.includes('Terumi Mei') || cfg.userType === NpcFunctionType.YUELAO) {
      dialogue = 'O casamento e a união entre ninjas de diferentes clãs fortalecem os laços de todo o continente. Que a chama do amor guie seus passos!';
      actions = [
        { label: '💖 Sistema de Laços & Casamento', onClick: () => this.toggleWindow(this.inventoryModal), color: 0xbe185d },
        { label: '🗺️ Explorar Vilas Vizinhas', onClick: () => this.toggleWindow(this.worldMapWindow), color: 0x2563eb },
      ];
    } else if (name.includes('Anko')) {
      dialogue = 'Atenção novato! A Floresta da Morte e o Exame Chūnin não toleram hesitações. Se você quer testar a sua coragem, enfrente as hordas inimigas na arena agora mesmo!';
      actions = [
        { label: '⚔️ Batalha PvE Imediata', onClick: () => this.startCampaignBattle(1), color: 0xdc2626 },
        { label: '🏆 Modos de Combate', onClick: () => this.toggleWindow(this.gameModesWindow), color: 0xd97706 },
        { label: '🥋 Ajustar Formação', onClick: () => this.toggleWindow(this.formationModal), color: 0x2563eb },
      ];
    } else if (name.includes('Naruto')) {
      dialogue = 'Eu nunca volto atrás na minha palavra... esse é o meu jeito ninja de ser, Dattebayo! Ei, que tal disputar uma partida de Mora (Jokenpô) na Taverna ou lutar comigo?';
      actions = [
        { label: '✊ Jogar Mora (Jokenpô)', onClick: () => this.toggleWindow(this.tavernModal), color: 0xd97706 },
        { label: '👥 Recrutar para a Equipe', onClick: () => this.toggleWindow(this.tavernModal), color: 0x15803d },
        { label: '⚔️ Duelo de Treinamento', onClick: () => this.startCampaignBattle(1), color: 0xdc2626 },
      ];
    } else if (name.includes('Sasuke')) {
      dialogue = 'Chidori... o som de mil pássaros relampejantes. Não fique no meu caminho a menos que esteja pronto para um duelo de verdade.';
      actions = [
        { label: '⚡ Duelo Shinobi (PvE)', onClick: () => this.startCampaignBattle(1), color: 0xdc2626 },
        { label: '♟️ Ajustar Formação', onClick: () => this.toggleWindow(this.formationModal), color: 0x2563eb },
        { label: '👥 Recrutar Sasuke', onClick: () => this.toggleWindow(this.tavernModal), color: 0xd97706 },
      ];
    } else if (name.includes('Kakashi')) {
      dialogue = 'Um ninja deve enxergar através da decepção... e valorizar os laços de amizade acima de tudo. Prepare sua formação antes de avançar nas missões!';
      actions = [
        { label: '📖 Campanhas PvE (Capítulos)', onClick: () => this.toggleWindow(this.campaignWindow), color: 0xb45309 },
        { label: '♟️ Formação Tática (15 Slots)', onClick: () => this.toggleWindow(this.formationModal), color: 0x2563eb },
        { label: '⚔️ Batalha Rápida PvE', onClick: () => this.startCampaignBattle(1), color: 0xdc2626 },
      ];
    } else if (name.includes('Portão') || cfg.userType === NpcFunctionType.GATE) {
      dialogue = 'Sentinela da Fronteira: Acesso supervisionado às 45 cidades e regiões do Mundo Ninja. Apresente sua autorização de viagem antes de cruzar o portão!';
      const isNovice = this.currentCityId === 23100001;
      actions = [
        {
          label: isNovice ? '🏯 Entrar em Konohagakure' : '🌲 Ir para o Subúrbio dos Novatos',
          onClick: () => this.changeCity(isNovice ? 23200001 : 23100001),
          color: 0x15803d,
        },
        { label: '🗺️ Abrir Mapa Mundi (45 Cidades)', onClick: () => this.toggleWindow(this.worldMapWindow), color: 0x2563eb },
        { label: '⚔️ Patrulha de Fronteira (PvE)', onClick: () => this.startCampaignBattle(1), color: 0xdc2626 },
      ];
    } else if (name.includes('Gaara')) {
      dialogue = 'A areia protege aqueles que encontram um propósito na existência. A aliança entre Konoha e Sunagakure permanece inabalável.';
      actions = [
        { label: '⏳ Aliança da Areia (Missões)', onClick: () => this.toggleWindow(this.campaignWindow), color: 0xb45309 },
        { label: '⚔️ Duelo da Areia (PvE)', onClick: () => this.startCampaignBattle(1), color: 0xdc2626 },
      ];
    } else if (name.includes('Konohamaru')) {
      dialogue = 'Ei, chefe! Estou treinando arduamente para dominar o Rasengan e me tornar Hokage um dia!';
      actions = [
        { label: '🔥 Treinamento de Jutsus', onClick: () => this.startCampaignBattle(1), color: 0xdc2626 },
        { label: '🎒 Mochila Shinobi', onClick: () => this.toggleWindow(this.inventoryModal), color: 0x15803d },
      ];
    } else {
      actions = [
        { label: '⚔️ Batalha PvE', onClick: () => this.startCampaignBattle(1), color: 0xdc2626 },
        { label: '🎒 Mochila Shinobi', onClick: () => this.toggleWindow(this.inventoryModal), color: 0x15803d },
      ];
    }

    if (this.npcDialogModal) {
      this.npcDialogModal.show({
        npcName: cfg.name,
        roleTitle: cfg.role,
        avatarPath,
        dialogue,
        actions,
      });
    }
  }

  /**
   * Transição canônica entre cidades e mapas do jogo (Novice Suburb <-> Konoha Village, etc.)
   */
  public changeCity(cityId: number): void {
    this.currentCityId = cityId;
    const isNovice = cityId === 23100001;
    const cityName = isNovice ? 'Subúrbio dos Novatos' : (cityId === 23200001 ? 'Vila de Konoha' : `Região #${cityId}`);
    const subtitle = isNovice ? 'Campo de Treinamento da Floresta' : 'Vila Oculta da Folha (Konohagakure)';

    // 1. Notifica o servidor da mudança de vila via opcode oficial
    const pw = new WebPacketWriter();
    pw.writeUnsignedInt(cityId);
    clientSocket.send(OPCODES.CS_LOBBY_Enter_Town, pw);

    // 2. Reposiciona o jogador na entrada da vila
    this.localX = 300;
    this.localY = 480;
    this.localTargetX = 300;
    this.localTargetY = 480;
    if (this.localPlayerContainer) {
      this.localPlayerContainer.position.set(this.localX, this.localY);
    }

    // 3. Reconstrói o chão e a população de NPCs autênticos
    this.setupGround();
    this.setupNPCs();
    this.updateCityHUD();
    this.updateCamera();

    // 4. Banner visual de entrada com animação de fade
    this.showCityEntranceBanner(cityName, subtitle);

    console.log(`[TownScene] Cidade alterada para ${cityName} (#${cityId})`);
  }

  /**
   * Banner estilizado clássico de boas-vindas à cidade
   */
  private showCityEntranceBanner(cityName: string, subtitle: string): void {
    const banner = new Container();
    const screenW = gameApp.screen.width;
    banner.position.set(screenW / 2, 100);
    banner.zIndex = 40000;

    const bg = new Graphics();
    const w = 460;
    const h = 76;
    bg.roundRect(-w / 2, -h / 2, w, h, 10);
    bg.fill({ color: 0x0f172a, alpha: 0.92 });
    bg.stroke({ color: 0xf59e0b, width: 2.5 });
    // Detalhes decorativos laterais
    bg.circle(-w / 2 + 16, 0, 6);
    bg.fill(0xf59e0b);
    bg.circle(w / 2 - 16, 0, 6);
    bg.fill(0xf59e0b);
    banner.addChild(bg);

    const txtTitle = new Text({
      text: `✦ ${cityName.toUpperCase()} ✦`,
      style: {
        fontFamily: 'Georgia, serif',
        fontSize: 18,
        fontWeight: 'bold',
        fill: '#fef08a',
        align: 'center',
        dropShadow: { alpha: 0.8, blur: 4, color: '#000000', distance: 2 },
      },
    });
    txtTitle.anchor.set(0.5);
    txtTitle.position.set(0, -12);
    banner.addChild(txtTitle);

    const txtSub = new Text({
      text: subtitle,
      style: {
        fontFamily: 'Arial, sans-serif',
        fontSize: 12,
        fill: '#94a3b8',
        align: 'center',
      },
    });
    txtSub.anchor.set(0.5);
    txtSub.position.set(0, 16);
    banner.addChild(txtSub);

    banner.alpha = 0;
    this.hudContainer.addChild(banner);

    let progress = 0;
    const animFn = () => {
      progress += 1;
      if (progress <= 15) {
        banner.alpha = progress / 15;
      } else if (progress > 120) {
        banner.alpha -= 0.05;
        if (banner.alpha <= 0) {
          Ticker.shared.remove(animFn);
          banner.destroy({ children: true });
        }
      }
    };
    Ticker.shared.add(animFn);
  }

  private updateCityHUD(): void {
    if (this.txtCityTitle) {
      const isNovice = this.currentCityId === 23100001;
      this.txtCityTitle.text = isNovice
        ? '🌲 Subúrbio dos Novatos (#23100001)'
        : '🏯 Vila de Konoha (#23200001)';
    }
  }

  public triggerNpcByName(nameQuery: string): void {
    const activeList = this.currentCityId === 23100001 ? NOVICE_SUBURB_NPCS : KONOHA_VILLAGE_NPCS;
    const found = activeList.find((n) => n.name.toLowerCase().includes(nameQuery.toLowerCase()));
    if (found) {
      this.openNpcDialog(found);
    }
  }

  /**
   * Clique no mapa: Converte coordenadas da tela para o mundo e despacha CS_LOBBY_Town_Move com clamp oficial
   */
  private onGroundClick(e: FederatedPointerEvent): void {
    const localPos = this.worldContainer.toLocal(e.global);
    const targetX = Math.round(Math.max(50, Math.min(TownScene.MAP_WIDTH - 50, localPos.x)));
    const targetY = Math.round(Math.max(TownScene.WALK_MIN_Y, Math.min(TownScene.WALK_MAX_Y, localPos.y)));

    this.localTargetX = targetX;
    this.localTargetY = targetY;

    this.spawnClickIndicator(targetX, targetY);

    const pw = new WebPacketWriter();
    pw.writeShort(targetX);
    pw.writeShort(targetY);
    clientSocket.send(OPCODES.CS_LOBBY_Town_Move, pw);

    console.log(`[TownMove] Enviado CS_LOBBY_Town_Move para (${targetX}, ${targetY})`);
  }

  /**
   * Indicador circular dinâmico onde o jogador clicou
   */
  private spawnClickIndicator(x: number, y: number): void {
    const indicator = new Graphics();
    indicator.circle(0, 0, 14);
    indicator.stroke({ color: 0x38bdf8, width: 3 });
    indicator.position.set(x, y);
    this.groundLayer.addChild(indicator);

    let alpha = 1;
    let radius = 14;
    const anim = () => {
      alpha -= 0.05;
      radius += 1.5;
      indicator.clear();
      indicator.circle(0, 0, radius);
      indicator.stroke({ color: 0x38bdf8, width: 2, alpha });
      if (alpha <= 0) {
        Ticker.shared.remove(anim);
        indicator.destroy();
      }
    };
    Ticker.shared.add(anim);
  }

  private getHeroModelKey(prof: number, gender: number = 1): string {
    const isFemale = gender === 0;
    if (prof === 1) return isFemale ? 'ninjutsu_f' : 'ninjutsu_m';
    if (prof === 3) return isFemale ? 'genjutsu_f' : 'genjutsu_m';
    if (prof === 4) return isFemale ? 'taijutsu_f' : 'taijutsu_m';
    return 'taijutsu_m';
  }

  /**
   * Cria o Avatar do jogador local com modelo animado autêntico
   */
  private createLocalPlayer(): void {
    const heroKey = this.getHeroModelKey(this.localData.profession, this.localData.gender);
    const heroCfg = AUTHENTIC_HEROES[heroKey] || AUTHENTIC_HEROES.taijutsu_m;

    const idleTextures: Texture[] = [];
    for (let i = 0; i < heroCfg.idleCount; i++) {
      const tex = Assets.get(`/assets/animated/heroes/${heroCfg.folder}/idle_${i}.png`);
      if (tex) idleTextures.push(tex);
    }

    const runTextures: Texture[] = [];
    for (let i = 0; i < heroCfg.runCount; i++) {
      const tex = Assets.get(`/assets/animated/heroes/${heroCfg.folder}/run_${i}.png`);
      if (tex) runTextures.push(tex);
    }

    this.localAvatarView = new NinjaAvatarView({
      name: this.localData.name,
      level: this.localData.level,
      isLocal: true,
      idleTextures,
      runTextures,
      scale: 1.0,
      fps: 7,
    });
    this.localAvatarView.position.set(this.localX, this.localY);
    this.localAvatarView.zIndex = Math.floor(this.localY);
    this.playersLayer.addChild(this.localAvatarView);
    this.localPlayerContainer = this.localAvatarView;
  }

  /**
   * Fábrica visual de ninjas animados com transição Idle/Run
   */
  private createNinjaVisual(
    name: string,
    profession: number,
    level: number,
    isLocal: boolean = false
  ): Container {
    const heroKey = this.getHeroModelKey(profession, 1);
    const heroCfg = AUTHENTIC_HEROES[heroKey] || AUTHENTIC_HEROES.taijutsu_m;

    const idleTextures: Texture[] = [];
    for (let i = 0; i < heroCfg.idleCount; i++) {
      const tex = Assets.get(`/assets/animated/heroes/${heroCfg.folder}/idle_${i}.png`);
      if (tex) idleTextures.push(tex);
    }

    const runTextures: Texture[] = [];
    for (let i = 0; i < heroCfg.runCount; i++) {
      const tex = Assets.get(`/assets/animated/heroes/${heroCfg.folder}/run_${i}.png`);
      if (tex) runTextures.push(tex);
    }

    return new NinjaAvatarView({
      name,
      level,
      isLocal,
      idleTextures,
      runTextures,
      scale: 1.0,
      fps: 7,
    });
  }

  /**
   * Configuração da HUD fixa na tela:
   * 1. Perfil Superior Esquerdo: Moldura de status com avatar circular recortado e moedas
   * 2. Barra Inferior de Atalhos: Base clássica curvada com os 5 botões oficiais
   * 3. Botão de Batalha PvE no topo direito
   */
  private setupHUD(): void {
    this.setupProfileHUD();
    this.setupBottomBarHUD();
    this.setupBattleButton();
    this.updateModalsPosition();
  }

  /**
   * Painel de Perfil e Recursos (Canto Superior Esquerdo)
   */
  private setupProfileHUD(): void {
    this.profileContainer = new Container();
    this.profileContainer.position.set(16, 16);

    // 1. Moldura do Status (profile_frame.png: 236x94)
    const frameTex = Assets.get('/assets/ui/profile_frame.png');
    if (frameTex) {
      const frameSprite = new Sprite(frameTex);
      frameSprite.position.set(0, 0);
      this.profileContainer.addChild(frameSprite);
    } else {
      const frameFallback = new Graphics();
      frameFallback.roundRect(0, 0, 236, 94, 10);
      frameFallback.fill({ color: 0x0f172a, alpha: 0.85 });
      this.profileContainer.addChild(frameFallback);
    }

    // 2. Retrato Circular do Protagonista com base na disciplina e gênero
    let avatarPath = '/assets/ui/avatar_blade.png';
    const isFemale = this.localData.gender === 0;
    if (this.localData.profession === 1) {
      avatarPath = isFemale ? '/assets/create_char/thumb_ninjutsu_f.png' : '/assets/create_char/thumb_ninjutsu_m.png';
    } else if (this.localData.profession === 3) {
      avatarPath = isFemale ? '/assets/create_char/thumb_genjutsu_f.png' : '/assets/create_char/thumb_genjutsu_m.png';
    } else if (this.localData.profession === 4) {
      avatarPath = isFemale ? '/assets/create_char/thumb_taijutsu_f.png' : '/assets/create_char/thumb_taijutsu_m.png';
    }

    const avatarTex = Assets.get(avatarPath) || Assets.get('/assets/ui/avatar_blade.png');
    if (avatarTex) {
      const avatarSprite = new Sprite(avatarTex);
      avatarSprite.width = 68;
      avatarSprite.height = 68;
      avatarSprite.position.set(18, 14);

      // Máscara circular para encaixe perfeito na moldura
      const mask = new Graphics();
      mask.circle(18 + 34, 14 + 34, 34);
      mask.fill(0xffffff);
      avatarSprite.mask = mask;

      this.profileContainer.addChild(mask);
      this.profileContainer.addChild(avatarSprite);
    }

    // 3. Informações de Nome e Nível do Ninja
    const txtPlayerName = new Text({
      text: this.localData.name,
      style: {
        fill: '#fbbf24',
        fontSize: 14,
        fontWeight: 'bold',
        stroke: { color: '#000000', width: 3 },
      },
    });
    txtPlayerName.position.set(96, 20);
    this.profileContainer.addChild(txtPlayerName);

    const txtPlayerLevel = new Text({
      text: `Nv. ${this.localData.level} (${getProfessionTitle(this.localData.profession)})`,
      style: {
        fill: '#e2e8f0',
        fontSize: 11,
        fontWeight: '600',
        stroke: { color: '#000000', width: 2 },
      },
    });
    txtPlayerLevel.position.set(96, 40);
    this.profileContainer.addChild(txtPlayerLevel);

    // 4. Barra de Moedas / Recursos (currency_bar.png: 385x50)
    const currTex = Assets.get('/assets/ui/currency_bar.png');
    if (currTex) {
      const currSprite = new Sprite(currTex);
      currSprite.position.set(244, 2);
      this.profileContainer.addChild(currSprite);

      // Valores das moedas renderizados sobre a barra
      const txtRyo = new Text({
        text: '15.000',
        style: { fill: '#ffffff', fontSize: 11, fontWeight: 'bold' },
      });
      txtRyo.position.set(300, 24);
      this.profileContainer.addChild(txtRyo);

      const txtGold = new Text({
        text: '850',
        style: { fill: '#fbbf24', fontSize: 11, fontWeight: 'bold' },
      });
      txtGold.position.set(430, 24);
      this.profileContainer.addChild(txtGold);

      const txtCoupons = new Text({
        text: '300',
        style: { fill: '#38bdf8', fontSize: 11, fontWeight: 'bold' },
      });
      txtCoupons.position.set(550, 24);
      this.profileContainer.addChild(txtCoupons);
    }

    // 5. Textos de status da vila e coordenadas
    this.txtCityTitle = new Text({
      text: this.currentCityId === 23100001 ? '🌲 Subúrbio dos Novatos (#23100001)' : '🏯 Vila de Konoha (#23200001)',
      style: { fill: '#fbbf24', fontSize: 12, fontWeight: 'bold', stroke: { color: '#000000', width: 2 } },
    });
    this.txtCityTitle.position.set(6, 102);
    this.profileContainer.addChild(this.txtCityTitle);

    this.txtCoord = new Text({
      text: `📍 Posição: (${Math.round(this.localX)}, ${Math.round(this.localY)})`,
      style: { fill: '#94a3b8', fontSize: 12, stroke: { color: '#000000', width: 2 } },
    });
    this.txtCoord.position.set(6, 122);
    this.profileContainer.addChild(this.txtCoord);

    this.txtPlayersCount = new Text({
      text: '👥 Ninjas na Vila: 1',
      style: { fill: '#38bdf8', fontSize: 12, fontWeight: 'bold', stroke: { color: '#000000', width: 2 } },
    });
    this.txtPlayersCount.position.set(6, 142);
    this.profileContainer.addChild(this.txtPlayersCount);

    this.hudContainer.addChild(this.profileContainer);
  }

  /**
   * Barra Inferior Clássica de Atalhos (Centro Inferior)
   */
  private setupBottomBarHUD(): void {
    this.bottomBarContainer = new Container();

    // 1. Moldura Curvada de Madeira/Dourada (bottom_bar.png: 729x99)
    const barTex = Assets.get('/assets/ui/bottom_bar.png');
    if (barTex) {
      const barSprite = new Sprite(barTex);
      this.bottomBarContainer.addChild(barSprite);
    }

    // 2. Botões de atalho dispostos sobre a barra
    const buttonsConfig = [
      { id: 'team', path: '/assets/ui/btn_team.png', x: 260, y: 22, name: 'Equipe' },
      { id: 'bag', path: '/assets/ui/btn_bag.png', x: 330, y: 22, name: 'Mochila' },
      { id: 'formation', path: '/assets/ui/btn_formation.png', x: 400, y: 22, name: 'Formação' },
      { id: 'summon', path: '/assets/ui/btn_summon.png', x: 470, y: 22, name: 'Invocação' },
      { id: 'map', path: '/assets/ui/btn_map.png', x: 642, y: 8, name: 'Mapa Mundi' }, // Encaixe circular direito
    ];

    buttonsConfig.forEach((btnConf) => {
      const btnTex = Assets.get(btnConf.path);
      if (btnTex) {
        const btnContainer = new Container();
        btnContainer.position.set(btnConf.x, btnConf.y);
        btnContainer.eventMode = 'static';
        btnContainer.cursor = 'pointer';

        const sprite = new Sprite(btnTex);
        btnContainer.addChild(sprite);

        // Feedback de interação: leve escala no hover
        btnContainer.on('pointerenter', () => {
          btnContainer.scale.set(1.08);
        });
        btnContainer.on('pointerleave', () => {
          btnContainer.scale.set(1.0);
        });
        btnContainer.on('pointertap', () => {
          console.log(`[HUD] Botão ${btnConf.name} clicado!`);
          if (btnConf.id === 'bag') {
            this.toggleWindow(this.inventoryModal);
          } else if (btnConf.id === 'team') {
            this.toggleWindow(this.tavernModal);
          } else if (btnConf.id === 'formation') {
            this.toggleWindow(this.formationModal);
          } else if (btnConf.id === 'summon') {
            this.toggleWindow(this.petWindow);
          } else if (btnConf.id === 'map') {
            this.toggleWindow(this.worldMapWindow);
          }
        });

        this.bottomBarContainer.addChild(btnContainer);
      }
    });

    this.hudContainer.addChild(this.bottomBarContainer);
    this.updateBottomBarPosition();
  }

  /**
   * Reposiciona a barra inferior centralizada na base da janela
   */
  private updateBottomBarPosition(): void {
    if (!this.bottomBarContainer) return;
    const screenW = gameApp.screen.width;
    const screenH = gameApp.screen.height;
    // Largura da moldura oficial: 729px, altura: 99px
    this.bottomBarContainer.position.set((screenW - 729) / 2, screenH - 99);
  }

  /**
   * Botão para transição para a Arena de Batalha PvE (Canto Superior Direito)
   */
  private setupBattleButton(): void {
    this.btnBattle = new Container();
    this.btnBattle.eventMode = 'static';
    this.btnBattle.cursor = 'pointer';

    const bgBattle = new Graphics();
    bgBattle.roundRect(0, 0, 190, 46, 8);
    bgBattle.fill(0xdc2626);
    bgBattle.stroke({ color: 0xef4444, width: 2 });
    this.btnBattle.addChild(bgBattle);

    const txtBattle = new Text({
      text: '⚔️ Modos de Combate',
      style: { fill: '#ffffff', fontSize: 13, fontWeight: 'bold' },
    });
    txtBattle.anchor.set(0.5);
    txtBattle.position.set(95, 23);
    this.btnBattle.addChild(txtBattle);

    this.btnBattle.position.set(window.innerWidth - 210, 20);
    this.btnBattle.on('pointertap', () => {
      this.toggleWindow(this.gameModesWindow);
    });
    this.hudContainer.addChild(this.btnBattle);
  }

  /**
   * Instanciação e gerenciamento das janelas modais do jogo
   */
  /**
   * Instanciação e gerenciamento das janelas modais do jogo
   */
  private setupModals(): void {
    // 1. Mochila Shinobi (36 slots + 6 Equipamentos + Atributos)
    this.inventoryModal = new InventoryModal();
    this.inventoryModal.visible = false;
    this.hudContainer.addChild(this.inventoryModal);

    // 2. Taverna Ninja (Mora / Jokenpô & Recrutamento)
    this.tavernModal = new TavernModal();
    this.tavernModal.visible = false;
    this.hudContainer.addChild(this.tavernModal);

    // 3. Formação Tática (15 Slots: Vanguarda, Assalto, Apoio)
    this.formationModal = new FormationModal();
    this.formationModal.visible = false;
    this.hudContainer.addChild(this.formationModal);

    // 4. Forja de Equipamentos (God of Craftsman - Refino e Fortalecimento)
    this.smithyModal = new SmithyModal();
    this.smithyModal.visible = false;
    this.hudContainer.addChild(this.smithyModal);

    // 5. Modal Visual Novel de Diálogos com NPCs
    this.npcDialogModal = new NpcDialogModal();
    this.npcDialogModal.visible = false;
    this.hudContainer.addChild(this.npcDialogModal);

    // 6. Campanhas PvE (Capítulos e Fases)
    this.campaignWindow = new CampaignWindow((groupId: number) => {
      this.startCampaignBattle(groupId);
    });
    this.campaignWindow.visible = false;
    this.hudContainer.addChild(this.campaignWindow);

    // 7. Mapa Mundi (45 Regiões Canônicas de cities.json)
    this.worldMapWindow = new WorldMapWindow(
      () => {},
      (city) => {
        console.log(`[TownScene] Viajando para a região ${city.name} (#${city.id})...`);
        this.changeCity(city.id);
        this.worldMapWindow.close();
      }
    );
    this.worldMapWindow.visible = false;
    this.hudContainer.addChild(this.worldMapWindow);

    // 8. Invocações Sagradas / Bestas com Caudas (Bijū de pet_images.json)
    this.petWindow = new PetWindow(() => {});
    this.petWindow.visible = false;
    this.hudContainer.addChild(this.petWindow);

    // 9. Seleção Geral de Modos de Jogo (Chefe de Mundo Kyuubi, Torre, Arena, Campanha)
    this.gameModesWindow = new GameModesWindow((mode) => {
      this.gameModesWindow.close();
      if (mode.id === 'campaign') {
        this.toggleWindow(this.campaignWindow);
      } else {
        this.startCampaignBattle(mode.groupId);
      }
    }, () => {});
    this.gameModesWindow.visible = false;
    this.hudContainer.addChild(this.gameModesWindow);

    this.updateModalsPosition();
  }

  private updateModalsPosition(): void {
    const screenW = gameApp.screen.width;
    const screenH = gameApp.screen.height;

    if (this.campaignWindow) {
      this.campaignWindow.position.set((screenW - CampaignWindow.WIDTH) / 2, (screenH - CampaignWindow.HEIGHT) / 2);
    }
    if (this.worldMapWindow) {
      this.worldMapWindow.position.set((screenW - WorldMapWindow.WIDTH) / 2, (screenH - WorldMapWindow.HEIGHT) / 2);
    }
    if (this.petWindow) {
      this.petWindow.position.set((screenW - PetWindow.WIDTH) / 2, (screenH - PetWindow.HEIGHT) / 2);
    }
    if (this.gameModesWindow) {
      this.gameModesWindow.position.set((screenW - GameModesWindow.WIDTH) / 2, (screenH - GameModesWindow.HEIGHT) / 2);
    }
  }

  public toggleWindow(target: any): void {
    if (!target) return;
    const isCurrentlyVisible = target.visible;
    // Fecha as demais janelas para manter layout limpo
    if (this.inventoryModal && this.inventoryModal !== target) this.inventoryModal.close();
    if (this.tavernModal && this.tavernModal !== target) this.tavernModal.close();
    if (this.formationModal && this.formationModal !== target) this.formationModal.close();
    if (this.smithyModal && this.smithyModal !== target) this.smithyModal.close();
    if (this.campaignWindow && this.campaignWindow !== target) this.campaignWindow.close();
    if (this.worldMapWindow && this.worldMapWindow !== target) this.worldMapWindow.close();
    if (this.petWindow && this.petWindow !== target) this.petWindow.close();
    if (this.gameModesWindow && this.gameModesWindow !== target) this.gameModesWindow.close();
    if (this.npcDialogModal && this.npcDialogModal !== target) this.npcDialogModal.hide();

    if (isCurrentlyVisible) {
      if (typeof target.close === 'function') target.close();
      else if (typeof target.hide === 'function') target.hide();
      else target.visible = false;
    } else {
      this.updateModalsPosition();
      if (typeof target.open === 'function') target.open();
      else if (typeof target.show === 'function') target.show();
      else target.visible = true;
    }
  }

  public startCampaignBattle(groupId: number = 1): void {
    console.log(`[TownScene] Iniciando batalha contra Grupo #${groupId}...`);
    const pw = new WebPacketWriter();
    pw.writeShort(groupId);
    clientSocket.send(OPCODES.CS_BattleStart, pw);
  }

  /**
   * Registra os ouvintes de rede de instâncias multiplayer com unsubscribers seguros
   */
  private setupNetworkHandlers(): void {
    this.unsubs.push(
      clientSocket.on(OPCODES.SC_LOBBY_Town_NewRoleNtf, (reader) => {
        const count = reader.readShort();
        console.log(`[TownScene] SC_LOBBY_Town_NewRoleNtf: ${count} jogador(es)`);

        for (let i = 0; i < count; i++) {
          reader.readUnsignedInt(); // GuidHigh
          const charId = reader.readUnsignedInt();
          const roleTemplateId = reader.readUnsignedInt();
          const roleName = reader.readStringUTF();
          reader.readUnsignedInt(); // MilitaryRank
          const level = reader.readUnsignedInt();
          reader.readUnsignedInt(); // FamilyID
          reader.readByte(); // RelexBoo
          reader.readUnsignedInt(); // TextureID
          const mapX = reader.readUnsignedShort();
          const mapY = reader.readUnsignedShort();
          reader.readByte(); // Quality
          reader.readUnsignedInt(); // NewShapeBaseHeroID
          reader.readUnsignedInt(); // TitleID
          reader.readUnsignedInt(); // LittlePetID
          reader.readUnsignedInt(); // LittlePetID2
          reader.readUnsignedInt(); // WingID
          reader.readUnsignedInt(); // TransformID
          reader.readInt(); // HideWing
          reader.readUnsignedInt(); // JadeID
          reader.readShort(); // BadgeCount

          if (charId !== this.localData.charId) {
            this.addOrUpdateRemotePlayer(charId, roleName, roleTemplateId, level, mapX, mapY);
          }
        }
        this.updatePlayerCountHUD();
      })
    );

    this.unsubs.push(
      clientSocket.on(OPCODES.SC_LOBBY_Town_RoleMove, (reader) => {
        reader.readUnsignedInt(); // GuidHigh
        const charId = reader.readUnsignedInt();
        const targetX = reader.readUnsignedShort();
        const targetY = reader.readUnsignedShort();

        const remote = this.remotePlayers.get(charId);
        if (remote) {
          remote.targetX = targetX;
          remote.targetY = targetY;

          // Espelhamento horizontal do ninja remoto (scale.x)
          const body = remote.container.getChildByLabel('avatarBody') || remote.container.getChildByName('avatarBody');
          if (body) {
            if (targetX < remote.currentX) {
              body.scale.x = -1;
            } else if (targetX > remote.currentX) {
              body.scale.x = 1;
            }
          }

          console.log(`[TownScene] Ninja Remoto #${charId} movendo para (${targetX}, ${targetY})`);
        }
      })
    );

    this.unsubs.push(
      clientSocket.on(OPCODES.SC_LOBBY_Town_RemoveRole, (reader) => {
        reader.readUnsignedInt(); // GuidHigh
        const charId = reader.readUnsignedInt();
        this.removeRemotePlayer(charId);
      })
    );

    this.unsubs.push(
      clientSocket.on(OPCODES.SC_Battle_StartReportDataReq, (reader) => {
        console.log(`[TownScene] Pacote de Batalha SC_Battle_StartReportDataReq recebido! Transicionando para a Arena...`);
        const battleReport = readBattleStartPacket(reader);
        gameApp.changeScene(new BattleScene(battleReport, this.localData));
      })
    );

    // Módulo Mochila & Equipamentos
    this.unsubs.push(
      clientSocket.on(OPCODES.SC_Backpack_InventoryNtf, (reader) => {
        try {
          const str = reader.readStringUTF();
          const data = JSON.parse(str);
          console.log(`[TownScene] SC_Backpack_InventoryNtf:`, data);
          if (this.inventoryModal && data.items) {
            this.inventoryModal.updateInventory(data.items, data.currency);
          }
        } catch (e) {
          console.error('[TownScene] Falha ao processar SC_Backpack_InventoryNtf:', e);
        }
      })
    );

    // Módulo Taverna & Almas Ninjas
    this.unsubs.push(
      clientSocket.on(OPCODES.SC_Enter_Tavern, (reader) => {
        try {
          const str = reader.readStringUTF();
          const data = JSON.parse(str);
          console.log(`[TownScene] SC_Enter_Tavern:`, data);
          if (this.tavernModal && data.team && data.currency) {
            this.tavernModal.updateTavernState(data.team, data.currency);
          }
          if (this.formationModal && data.team) {
            this.formationModal.updateTeam(data.team);
          }
        } catch (e) {
          console.error('[TownScene] Falha ao processar SC_Enter_Tavern:', e);
        }
      })
    );

    // Módulo Taverna: Resultado Minigame Mora (Jokenpô)
    this.unsubs.push(
      clientSocket.on(OPCODES.SC_TavernMoraRet, (reader) => {
        try {
          const str = reader.readStringUTF();
          const data = JSON.parse(str);
          console.log(`[TownScene] SC_TavernMoraRet:`, data);
          if (this.tavernModal) {
            this.tavernModal.handleMoraResult(data);
          }
        } catch (e) {
          console.error('[TownScene] Falha ao processar SC_TavernMoraRet:', e);
        }
      })
    );

    // Módulo Taverna: Resultado do Recrutamento Shinobi
    this.unsubs.push(
      clientSocket.on(OPCODES.SC_TavernRecruitRet, (reader) => {
        try {
          const str = reader.readStringUTF();
          const data = JSON.parse(str);
          console.log(`[TownScene] SC_TavernRecruitRet:`, data);
          if (this.tavernModal) {
            this.tavernModal.handleRecruitResult(data);
          }
          if (this.formationModal && data.team) {
            this.formationModal.updateTeam(data.team);
          }
        } catch (e) {
          console.error('[TownScene] Falha ao processar SC_TavernRecruitRet:', e);
        }
      })
    );

    // Módulo Formação Tática
    this.unsubs.push(
      clientSocket.on(OPCODES.SC_TacticalDeploymentChangePositonRet, (reader) => {
        try {
          const str = reader.readStringUTF();
          const data = JSON.parse(str);
          console.log(`[TownScene] SC_TacticalDeploymentChangePositonRet:`, data);
          if (this.formationModal && data.team) {
            this.formationModal.updateTeam(data.team);
          }
        } catch (e) {
          console.error('[TownScene] Falha ao processar SC_TacticalDeploymentChangePositonRet:', e);
        }
      })
    );

    // Módulo Campanha PvE
    this.unsubs.push(
      clientSocket.on(OPCODES.SC_Enter_Hurdle, (reader) => {
        try {
          const str = reader.readStringUTF();
          const data = JSON.parse(str);
          console.log(`[TownScene] SC_Enter_Hurdle:`, data);
        } catch (e) {
          console.error('[TownScene] Falha ao processar SC_Enter_Hurdle:', e);
        }
      })
    );

    // Módulo Forja: Resultado do Aprimoramento de Equipamento
    this.unsubs.push(
      clientSocket.on(OPCODES.SC_Equip_EnhanceRet, (reader) => {
        try {
          const str = reader.readStringUTF();
          const data = JSON.parse(str);
          console.log(`[TownScene] SC_Equip_EnhanceRet:`, data);
          if (this.smithyModal) {
            this.smithyModal.handleEnhanceResult(data);
          }
        } catch (e) {
          console.error('[TownScene] Falha ao processar SC_Equip_EnhanceRet:', e);
        }
      })
    );
  }

  private addOrUpdateRemotePlayer(
    charId: number,
    name: string,
    profession: number,
    level: number,
    x: number,
    y: number
  ): void {
    if (this.remotePlayers.has(charId)) {
      const existing = this.remotePlayers.get(charId)!;
      existing.targetX = x;
      existing.targetY = y;
      return;
    }

    const container = this.createNinjaVisual(name, profession, level, false) as NinjaAvatarView;
    container.position.set(x, y);
    container.zIndex = Math.floor(y);
    this.playersLayer.addChild(container);
    this.remoteAvatarViews.set(charId, container);

    this.remotePlayers.set(charId, {
      charId,
      name,
      profession,
      level,
      container,
      currentX: x,
      currentY: y,
      targetX: x,
      targetY: y,
    });

    console.log(`[TownScene] Ninja remoto adicionado: ${name} (#${charId}) em (${x}, ${y})`);
  }

  private removeRemotePlayer(charId: number): void {
    const remote = this.remotePlayers.get(charId);
    if (remote) {
      this.playersLayer.removeChild(remote.container);
      remote.container.destroy({ children: true });
      this.remotePlayers.delete(charId);
      this.remoteAvatarViews.delete(charId);
      this.updatePlayerCountHUD();
      console.log(`[TownScene] Ninja #${charId} removido da vila.`);
    }
  }

  private updatePlayerCountHUD(): void {
    const total = 1 + this.remotePlayers.size;
    if (this.txtPlayersCount) {
      this.txtPlayersCount.text = `👥 Ninjas na Vila: ${total}`;
    }
  }

  private setupTicker(): void {
    this.tickerUpdateFn = () => {
      this.updateMovement();
      this.updateCamera();
    };
    Ticker.shared.add(this.tickerUpdateFn);
  }

  private setupResizeListener(): void {
    this.resizeHandler = () => {
      this.updateBottomBarPosition();
      this.updateModalsPosition();
      if (this.btnBattle) {
        this.btnBattle.position.set(window.innerWidth - 200, 20);
      }
    };
    window.addEventListener('resize', this.resizeHandler);
  }

  private updateMovement(): void {
    if (!this.localPlayerContainer || !this.localAvatarView) return;

    const dt = Ticker.shared.deltaMS / 1000;
    const dx = this.localTargetX - this.localX;
    const dy = this.localTargetY - this.localY;
    const dist = Math.hypot(dx, dy);

    const isMoving = dist > TownScene.MOVE_SPEED;

    if (isMoving) {
      this.localX += (dx / dist) * TownScene.MOVE_SPEED;
      this.localY += (dy / dist) * TownScene.MOVE_SPEED;
      this.facingDir = dx < -1 ? -1 : (dx > 1 ? 1 : this.facingDir);
      this.localAvatarView.updateAnimation(dt, true, this.facingDir);
    } else {
      this.localX = this.localTargetX;
      this.localY = this.localTargetY;
      this.localAvatarView.updateAnimation(dt, false, this.facingDir);
    }

    this.localPlayerContainer.position.set(this.localX, this.localY);
    this.localPlayerContainer.zIndex = Math.floor(this.localY);

    if (this.txtCoord) {
      this.txtCoord.text = `📍 Posição: (${Math.round(this.localX)}, ${Math.round(this.localY)}) [Área Y: 370-650]`;
    }

    // Animação de repouso e respiração dos NPCs autênticos
    for (const npc of this.npcViews) {
      npc.updateAnimation(dt, false);
    }

    // Animação de flutuação dos badges canônicos de função
    for (const badge of this.npcBadges) {
      badge.update(dt);
    }

    // Atualização dos jogadores remotos
    for (const remote of this.remotePlayers.values()) {
      const rdx = remote.targetX - remote.currentX;
      const rdy = remote.targetY - remote.currentY;
      const rdist = Math.hypot(rdx, rdy);
      const isRemoteMoving = rdist > 1;

      if (isRemoteMoving) {
        remote.currentX += rdx * 0.15;
        remote.currentY += rdy * 0.15;
        remote.container.position.set(remote.currentX, remote.currentY);
        remote.container.zIndex = Math.floor(remote.currentY);
      }

      const rView = this.remoteAvatarViews.get(remote.charId);
      if (rView) {
        const rDir = rdx < -1 ? -1 : (rdx > 1 ? 1 : 0);
        rView.updateAnimation(dt, isRemoteMoving, rDir);
      }
    }
  }

  /**
   * Câmera do mundo com Clamp exato no mapa oficial de 2500x650
   */
  private updateCamera(): void {
    const screenW = gameApp.screen.width;
    const screenH = gameApp.screen.height;

    let camX = screenW / 2 - this.localX;
    let camY = screenH / 2 - this.localY;

    const minCamX = screenW - TownScene.MAP_WIDTH;
    const minCamY = screenH - TownScene.MAP_HEIGHT;

    if (TownScene.MAP_WIDTH > screenW) {
      camX = Math.min(0, Math.max(minCamX, camX));
    } else {
      camX = (screenW - TownScene.MAP_WIDTH) / 2;
    }

    if (TownScene.MAP_HEIGHT > screenH) {
      camY = Math.min(0, Math.max(minCamY, camY));
    } else {
      camY = (screenH - TownScene.MAP_HEIGHT) / 2;
    }

    this.worldContainer.position.set(camX, camY);
  }

  public override destroy(options?: any): void {
    if (this.tickerUpdateFn) {
      Ticker.shared.remove(this.tickerUpdateFn);
    }
    if (this.resizeHandler) {
      window.removeEventListener('resize', this.resizeHandler);
    }
    this.unsubs.forEach((unsub) => unsub());
    this.unsubs = [];
    super.destroy(options);
  }
}
