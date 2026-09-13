import { Container, Graphics, Sprite, Text, TextStyle, AnimatedSprite, Assets, Texture, Ticker } from 'pixi.js';
import { NetworkClient } from '../network/NetworkClient.js';
import { PacketWriter } from '../network/PacketWriter.js';
import { PacketReader } from '../network/PacketReader.js';
import { Opcodes } from '../protocol/opcodes.js';
import { NpcDialogModal } from './NpcDialogModal.js';

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

export class TownScene extends Container {
  private playerProfile: PlayerProfile;
  private worldContainer: Container;
  private hudContainer: Container;
  private npcDialogModal: NpcDialogModal;

  // Jogador local
  private localPlayer: AnimatedEntity | null = null;

  // Entidades no mapa
  private npcs: Map<number, Container> = new Map();
  private otherPlayers: Map<number, AnimatedEntity> = new Map();

  // Dimensões do mapa canônico (TLayerBackGround.as)
  private readonly MAP_WIDTH = 2500;
  private readonly MAP_HEIGHT = 650;
  private readonly ROAD_MIN_Y = 350;
  private readonly ROAD_MAX_Y = 430;

  // HUD Elements
  private hpFill!: Graphics;
  private hpText!: Text;
  private silverText!: Text;
  private goldText!: Text;

  constructor(profile: PlayerProfile) {
    super();
    this.playerProfile = profile;
    this.worldContainer = new Container();
    this.hudContainer = new Container();
    this.npcDialogModal = new NpcDialogModal();

    this.addChild(this.worldContainer);
    this.addChild(this.hudContainer);
    this.addChild(this.npcDialogModal);

    this.setupNetworkHandlers();
    this.init();
  }

  private async init(): Promise<void> {
    // 1. Construir Cenário e Fundo
    await this.buildEnvironment();

    // 2. Criar Entidade do Jogador Local
    await this.createLocalPlayer(400, 382);

    // 3. Criar HUD Superior
    this.createHUD();

    // 4. Registrar Loop de Atualização de Movimento e Câmera
    Ticker.shared.add(this.update, this);

    // 5. Requisitar Entrada na Vila Novice Suburb (#23100001)
    const enterPkt = new PacketWriter(Opcodes.CS_LOBBY_Enter_Town)
      .writeUInt32BE(23100001);
    NetworkClient.getInstance().send(enterPkt);
  }

  private async buildEnvironment(): Promise<void> {
    // Camada de Céu / Fundo Panorâmico (2500x650)
    try {
      const bgTex = await Assets.load('/assets/town/bg_konoha.png');
      const bg1 = new Sprite(bgTex);
      bg1.width = 1250;
      bg1.height = 650;
      this.worldContainer.addChild(bg1);

      const bg2 = new Sprite(bgTex);
      bg2.x = 1250;
      bg2.width = 1250;
      bg2.height = 650;
      this.worldContainer.addChild(bg2);
    } catch {
      const fallbackBg = new Graphics()
        .rect(0, 0, this.MAP_WIDTH, 360).fill(0x355e3b)
        .rect(0, 360, this.MAP_WIDTH, 290).fill(0x735738);
      this.worldContainer.addChild(fallbackBg);
    }

    // Estrada de terra onde os personagens caminham
    const road = new Graphics()
      .rect(0, 350, this.MAP_WIDTH, 110)
      .fill({ color: 0xa88756, alpha: 0.55 });
    this.worldContainer.addChild(road);

    // Adicionar Ichiraku Ramen Shop
    try {
      const ichirakuTex = await Assets.load('/assets/town/ichiraku_shop.png');
      const ichiraku = new Sprite(ichirakuTex);
      ichiraku.anchor.set(0.5, 1.0);
      ichiraku.position.set(1450, 385);
      ichiraku.scale.set(0.9);
      this.worldContainer.addChild(ichiraku);
    } catch (e) {
      console.warn('Ichiraku texture not loaded:', e);
    }

    // Lanternas e Decorações
    try {
      const lanternTex = await Assets.load('/assets/town/prop_lanterns.png');
      for (const lx of [300, 750, 1150, 1600, 2050]) {
        const lantern = new Sprite(lanternTex);
        lantern.anchor.set(0.5, 1.0);
        lantern.position.set(lx, 360);
        this.worldContainer.addChild(lantern);
      }
    } catch {}

    // Placa de Aviso / Sinalização
    try {
      const signTex = await Assets.load('/assets/town/prop_sign.png');
      const sign = new Sprite(signTex);
      sign.anchor.set(0.5, 1.0);
      sign.position.set(220, 385);
      this.worldContainer.addChild(sign);
    } catch {}

    // Interação de Clique no Chão para Movimento
    this.worldContainer.eventMode = 'static';
    this.worldContainer.hitArea = {
      contains: (x: number, y: number) => x >= 0 && x <= this.MAP_WIDTH && y >= 0 && y <= this.MAP_HEIGHT
    };

    this.worldContainer.on('pointerdown', (e) => {
      const localPos = e.getLocalPosition(this.worldContainer);
      this.moveLocalPlayerTo(localPos.x, localPos.y);
    });
  }

  private async loadFrames(folder: string, prefix: string, count: number): Promise<Texture[]> {
    const textures: Texture[] = [];
    for (let i = 0; i < count; i++) {
      try {
        const tex = await Assets.load(`/assets/animated/${folder}/${prefix}_${i}.png`);
        textures.push(tex);
      } catch (err) {
        break;
      }
    }
    return textures;
  }

  private getHeroFolderName(profession: number, gender: number): string {
    const pStr = profession === 4 ? 'taijutsu' : profession === 1 ? 'ninjutsu' : 'genjutsu';
    const gStr = gender === 1 ? 'm' : 'f';
    return `hero_${pStr}_${gStr}`;
  }

  private async createLocalPlayer(x: number, y: number): Promise<void> {
    const folder = this.getHeroFolderName(this.playerProfile.profession, this.playerProfile.gender);
    const idleCount = (folder === 'hero_ninjutsu_m') ? 10 : 6;
    const runCount = (folder === 'hero_ninjutsu_m') ? 10 : 8;

    const idleFrames = await this.loadFrames(folder, 'idle', idleCount);
    const runFrames = await this.loadFrames(folder, 'run', runCount);

    const playerContainer = new Container();
    playerContainer.position.set(x, y);

    // Sombra circular aos pés
    const shadow = new Graphics()
      .ellipse(0, 0, 24, 7)
      .fill({ color: 0x000000, alpha: 0.38 });
    playerContainer.addChild(shadow);

    // Sprite de Idle
    const idleAnim = new AnimatedSprite(idleFrames);
    idleAnim.anchor.set(0.5, 1.0);
    idleAnim.animationSpeed = 0.14;
    idleAnim.play();
    playerContainer.addChild(idleAnim);

    // Sprite de Run
    const runAnim = new AnimatedSprite(runFrames);
    runAnim.anchor.set(0.5, 1.0);
    runAnim.animationSpeed = 0.18;
    runAnim.visible = false;
    playerContainer.addChild(runAnim);

    // Etiqueta de Nome e Título
    const profName = this.playerProfile.profession === 4 ? 'Taijutsu' : this.playerProfile.profession === 1 ? 'Ninjutsu' : 'Genjutsu';
    const nameLabel = new Text({
      text: `${this.playerProfile.name} (Nv.${this.playerProfile.level})`,
      style: new TextStyle({
        fontSize: 12,
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

    this.worldContainer.addChild(playerContainer);

    this.localPlayer = {
      container: playerContainer,
      idleAnim,
      runAnim,
      isMoving: false,
      targetX: x,
      targetY: y,
      speed: 3.8
    };
  }

  private moveLocalPlayerTo(targetX: number, targetY: number): void {
    if (!this.localPlayer) return;

    const clampedX = Math.max(60, Math.min(this.MAP_WIDTH - 60, targetX));
    const clampedY = Math.max(this.ROAD_MIN_Y, Math.min(this.ROAD_MAX_Y, targetY));

    this.localPlayer.targetX = clampedX;
    this.localPlayer.targetY = clampedY;
    this.localPlayer.isMoving = true;

    const isLeft = clampedX < this.localPlayer.container.x;
    this.localPlayer.idleAnim.visible = false;
    if (this.localPlayer.runAnim) {
      this.localPlayer.runAnim.visible = true;
      this.localPlayer.runAnim.scale.x = isLeft ? -1 : 1;
      this.localPlayer.runAnim.play();
    }
    this.localPlayer.idleAnim.scale.x = isLeft ? -1 : 1;

    const movePkt = new PacketWriter(Opcodes.CS_LOBBY_Town_Move)
      .writeUInt16BE(Math.round(clampedX))
      .writeUInt16BE(Math.round(clampedY));
    NetworkClient.getInstance().send(movePkt);
  }

  private update(): void {
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

    // 3. Atualizar Câmera Suave seguindo o Jogador
    if (this.localPlayer) {
      const targetCamX = 625 - this.localPlayer.container.x;
      const clampedCamX = Math.max(-(this.MAP_WIDTH - 1250), Math.min(0, targetCamX));
      this.worldContainer.x = clampedCamX;
    }
  }

  private getNpcVisualConfig(npcId: number): { folder: string; frames: number; scale?: number } {
    switch (npcId) {
      case 22100003: return { folder: 'hokage3', frames: 11 };      // 3º Hokage
      case 22100014: return { folder: 'naruto_base', frames: 6 };    // Konohamaru
      case 22100013: return { folder: 'sakura', frames: 6 };         // Tsunade (Taverna)
      case 22100002: return { folder: 'iruka', frames: 8 };          // Iruka
      case 22100006: return { folder: 'hero_genjutsu_f', frames: 6 };// Anko
      case 22100008: return { folder: 'rock_lee', frames: 5 };       // Jiraiya
      case 22100005: return { folder: 'naruto', frames: 10 };        // Naruto
      case 22100004: return { folder: 'sasuke', frames: 5 };         // Sasuke
      case 22100007: return { folder: 'kakashi', frames: 6 };        // Kakashi
      case 22100001: return { folder: 'city_gate', frames: 10 };     // Portão de Konoha
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

    // Marcador de Missão / Diálogo (!)
    const questMarker = new Text({
      text: '!',
      style: new TextStyle({
        fontSize: 20,
        fontWeight: 'bold',
        fill: '#ffd700',
        stroke: { color: '#000000', width: 3 }
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

    // Clique no NPC -> Enviar requisição de diálogo
    npcContainer.on('pointerdown', (e) => {
      e.stopPropagation();
      console.log(`[CLIENT] Interagindo com NPC: ${npc.name} (#${npc.id})`);
      
      this.moveLocalPlayerTo(npc.x - 50, npc.y);

      const talkPkt = new PacketWriter(Opcodes.CS_LOBBY_Town_TalkNpc)
        .writeUInt32BE(npc.id);
      NetworkClient.getInstance().send(talkPkt);
    });

    this.worldContainer.addChild(npcContainer);
    this.npcs.set(npc.id, npcContainer);
  }

  private setupNetworkHandlers(): void {
    const net = NetworkClient.getInstance();

    // SC_LOBBY_Town_NpcList (0x01180303)
    net.on(Opcodes.SC_LOBBY_Town_NpcList, async (reader: PacketReader) => {
      const count = reader.readInt16BE();
      console.log(`[CLIENT] Recebida lista com ${count} NPCs da vila.`);

      for (let i = 0; i < count; i++) {
        const id = reader.readUInt32BE();
        const name = reader.readFlushUTF();
        const npcTitle = reader.readFlushUTF();
        const x = reader.readUInt16BE();
        const y = reader.readUInt16BE();
        const userType = reader.readUInt8();

        await this.spawnNpc({ id, name, npcTitle, x, y, userType });
      }
    });

    // SC_LOBBY_Town_NpcDialog (0x01180304)
    net.on(Opcodes.SC_LOBBY_Town_NpcDialog, (reader: PacketReader) => {
      const npcId = reader.readUInt32BE();
      const name = reader.readFlushUTF();
      const npcTitle = reader.readFlushUTF();
      const talk = reader.readFlushUTF();
      const action = reader.readFlushUTF();

      this.npcDialogModal.showDialog({ npcId, name, npcTitle, talk, action });
    });

    // SC_LOBBY_Town_NewRoleNtf (0x01180300)
    net.on(Opcodes.SC_LOBBY_Town_NewRoleNtf, async (reader: PacketReader) => {
      const charId = reader.readUInt32BE();
      const name = reader.readFlushUTF();
      const profession = reader.readUInt8();
      const gender = reader.readUInt8();
      const x = reader.readUInt16BE();
      const y = reader.readUInt16BE();
      const level = reader.readUInt16BE();
      const heroId = reader.readUInt32BE();

      if (charId === this.playerProfile.charId) return;
      if (this.otherPlayers.has(charId)) return;

      const folder = this.getHeroFolderName(profession, gender);
      const idleFrames = await this.loadFrames(folder, 'idle', 6);
      const runFrames = await this.loadFrames(folder, 'run', 8);

      const container = new Container();
      container.position.set(x, y);

      const shadow = new Graphics().ellipse(0, 0, 24, 7).fill({ color: 0x000000, alpha: 0.35 });
      container.addChild(shadow);

      const idleAnim = new AnimatedSprite(idleFrames);
      idleAnim.anchor.set(0.5, 1.0);
      idleAnim.animationSpeed = 0.14;
      idleAnim.play();
      container.addChild(idleAnim);

      const runAnim = new AnimatedSprite(runFrames);
      runAnim.anchor.set(0.5, 1.0);
      runAnim.animationSpeed = 0.18;
      runAnim.visible = false;
      container.addChild(runAnim);

      const label = new Text({
        text: `${name} (Nv.${level})`,
        style: new TextStyle({ fontSize: 11, fill: '#3fb950', stroke: { color: '#000', width: 2 } })
      });
      label.anchor.set(0.5, 1.0);
      label.position.set(0, -90);
      container.addChild(label);

      this.worldContainer.addChild(container);
      this.otherPlayers.set(charId, {
        container,
        idleAnim,
        runAnim,
        isMoving: false,
        targetX: x,
        targetY: y,
        speed: 3.8
      });
    });

    // SC_LOBBY_Town_RoleMove (0x01180301)
    net.on(Opcodes.SC_LOBBY_Town_RoleMove, (reader: PacketReader) => {
      const charId = reader.readUInt32BE();
      const newX = reader.readUInt16BE();
      const newY = reader.readUInt16BE();

      if (charId === this.playerProfile.charId) return;

      const remote = this.otherPlayers.get(charId);
      if (remote) {
        remote.targetX = newX;
        remote.targetY = newY;
        remote.isMoving = true;
        const isLeft = newX < remote.container.x;
        remote.idleAnim.visible = false;
        if (remote.runAnim) {
          remote.runAnim.visible = true;
          remote.runAnim.scale.x = isLeft ? -1 : 1;
          remote.runAnim.play();
        }
      }
    });

    // SC_LOBBY_Town_RemoveRole (0x01180302)
    net.on(Opcodes.SC_LOBBY_Town_RemoveRole, (reader: PacketReader) => {
      const charId = reader.readUInt32BE();
      const remote = this.otherPlayers.get(charId);
      if (remote) {
        this.worldContainer.removeChild(remote.container);
        remote.container.destroy();
        this.otherPlayers.delete(charId);
      }
    });
  }

  private createHUD(): void {
    const topBar = new Graphics()
      .roundRect(15, 12, 420, 75, 10)
      .fill({ color: 0x0d1117, alpha: 0.88 })
      .stroke({ color: 0x30363d, width: 2 });
    this.hudContainer.addChild(topBar);

    const profName = this.playerProfile.profession === 4 ? 'Taijutsu' : this.playerProfile.profession === 1 ? 'Ninjutsu' : 'Genjutsu';
    const nameTxt = new Text({
      text: `${this.playerProfile.name}  [${profName}]`,
      style: new TextStyle({ fontSize: 15, fontWeight: 'bold', fill: '#f0f6fc' })
    });
    nameTxt.position.set(30, 20);
    this.hudContainer.addChild(nameTxt);

    const levelBadge = new Graphics()
      .roundRect(30, 44, 45, 20, 4)
      .fill(0xd29922);
    this.hudContainer.addChild(levelBadge);

    const levelTxt = new Text({
      text: `Lv.${this.playerProfile.level}`,
      style: new TextStyle({ fontSize: 11, fontWeight: 'bold', fill: '#000' })
    });
    levelTxt.position.set(37, 47);
    this.hudContainer.addChild(levelTxt);

    const hpBg = new Graphics()
      .roundRect(85, 45, 150, 18, 4)
      .fill(0x21262d);
    this.hudContainer.addChild(hpBg);

    this.hpFill = new Graphics()
      .roundRect(85, 45, 150, 18, 4)
      .fill(0x238636);
    this.hudContainer.addChild(this.hpFill);

    this.hpText = new Text({
      text: `${this.playerProfile.curHp} / ${this.playerProfile.maxHp}`,
      style: new TextStyle({ fontSize: 10, fill: '#ffffff', fontWeight: 'bold' })
    });
    this.hpText.position.set(125, 48);
    this.hudContainer.addChild(this.hpText);

    const curBg = new Graphics()
      .roundRect(250, 43, 170, 22, 4)
      .fill(0x161b22);
    this.hudContainer.addChild(curBg);

    this.silverText = new Text({
      text: `🪙 ${this.playerProfile.silver.toLocaleString()}`,
      style: new TextStyle({ fontSize: 11, fill: '#8b949e', fontWeight: 'bold' })
    });
    this.silverText.position.set(256, 47);
    this.hudContainer.addChild(this.silverText);

    this.goldText = new Text({
      text: `💎 ${this.playerProfile.gold.toLocaleString()}`,
      style: new TextStyle({ fontSize: 11, fill: '#e3b341', fontWeight: 'bold' })
    });
    this.goldText.position.set(350, 47);
    this.hudContainer.addChild(this.goldText);

    const mapBox = new Graphics()
      .roundRect(960, 12, 275, 40, 8)
      .fill({ color: 0x0d1117, alpha: 0.88 })
      .stroke({ color: 0x30363d, width: 2 });
    this.hudContainer.addChild(mapBox);

    const mapTxt = new Text({
      text: '📍 Subúrbio Novato (#23100001)',
      style: new TextStyle({ fontSize: 13, fontWeight: 'bold', fill: '#ffd700' })
    });
    mapTxt.position.set(978, 22);
    this.hudContainer.addChild(mapTxt);

    const battleBtn = new Container();
    battleBtn.position.set(1060, 60);
    battleBtn.eventMode = 'static';
    battleBtn.cursor = 'pointer';

    const bBg = new Graphics()
      .roundRect(0, 0, 175, 34, 6)
      .fill(0xda3633)
      .stroke({ color: 0xf85149, width: 1.5 });
    battleBtn.addChild(bBg);

    const bTxt = new Text({
      text: '⚔ TESTAR BATALHA',
      style: new TextStyle({ fontSize: 12, fontWeight: 'bold', fill: '#ffffff' })
    });
    bTxt.anchor.set(0.5, 0.5);
    bTxt.position.set(87, 17);
    battleBtn.addChild(bTxt);

    battleBtn.on('pointertap', () => {
      console.log('[CLIENT] Solicitando Batalha PvE via CS_BattleStart...');
      const battlePkt = new PacketWriter(Opcodes.CS_BattleStart)
        .writeUInt32BE(1);
      NetworkClient.getInstance().send(battlePkt);
    });

    this.hudContainer.addChild(battleBtn);
  }
}
