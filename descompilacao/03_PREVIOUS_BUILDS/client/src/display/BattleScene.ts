import { Container, Graphics, Text, TextStyle, Sprite, Assets, Ticker } from 'pixi.js';
import { clientSocket, WebPacketWriter } from '../network/clientSocket.ts';
import { OPCODES } from '../../../shared/opcodes.ts';
import { gameApp, type Scene } from '../core/GameApp.ts';
import { TownScene, type LocalNinjaData } from './TownScene.ts';
import type { BattleInitReport, FighterBattleData, ActionBattleData } from '../../../shared/types.ts';

// 15 Slots oficiais extraídos de TBattleConfig.as
const FORMATION_X1 = [
  [450, 320, 190], // Linha 0 (Centro) -> Slots 1, 6, 11
  [495, 365, 235], // Linha 1 (Superior Médio) -> Slots 2, 7, 12
  [405, 275, 145], // Linha 2 (Inferior Médio) -> Slots 3, 8, 13
  [540, 410, 280], // Linha 3 (Superior Extremo) -> Slots 4, 9, 14
  [360, 230, 100], // Linha 4 (Inferior Extremo) -> Slots 5, 10, 15
];

const FORMATION_X2 = [
  [800, 930, 1060], // Linha 0 -> Slots 1, 6, 11
  [755, 885, 1015], // Linha 1 -> Slots 2, 7, 12
  [845, 975, 1105], // Linha 2 -> Slots 3, 8, 13
  [710, 840, 970],  // Linha 3 -> Slots 4, 9, 14
  [890, 1020, 1150], // Linha 4 -> Slots 5, 10, 15
];

const FORMATION_Y = [485, 435, 535, 385, 585];

export function getSlotCoords(camp: number, pos: number): { x: number; y: number } {
  const row = (pos - 1) % 5;
  const col = Math.floor((pos - 1) / 5);
  const y = FORMATION_Y[row] ?? 485;
  const x = camp === 0 
    ? (FORMATION_X1[row]?.[col] ?? 450)
    : (FORMATION_X2[row]?.[col] ?? 800);
  return { x, y };
}

/**
 * Entidade visual de um combatente na arena de batalha com sprites autênticos
 */
class BattleFighterView {
  public root: Container;
  public camp: number;
  public pos: number;
  public originX: number;
  public originY: number;
  public data: FighterBattleData;

  public curHp: number;
  public maxHp: number;

  private bodyContainer: Container;
  private sprite: Sprite | null = null;
  private hpBarFill: Graphics;
  private hpText: Text;
  private nameText: Text;
  private activeAnim: (() => void) | null = null;

  constructor(camp: number, data: FighterBattleData, localNinja?: LocalNinjaData) {
    this.camp = camp;
    this.pos = data.pos;
    this.data = data;
    this.curHp = data.curHealth;
    this.maxHp = data.totalHealth;

    const coords = getSlotCoords(camp, data.pos);
    this.originX = coords.x;
    this.originY = coords.y;

    this.root = new Container();
    this.root.position.set(this.originX, this.originY);
    this.root.zIndex = this.originY; // Z-Sorting por Y

    // 1. Sombra suave aos pés do lutador
    const shadow = new Graphics();
    shadow.ellipse(0, 0, 32, 12);
    shadow.fill({ color: 0x000000, alpha: 0.55 });
    this.root.addChild(shadow);

    // 2. Container do corpo para espelhamento e animações
    this.bodyContainer = new Container();
    this.bodyContainer.scale.x = camp === 0 ? 1 : -1; // Camp 0 virado p/ direita (+1), Camp 1 virado p/ esquerda (-1)
    this.root.addChild(this.bodyContainer);

    // 3. Resolução da textura autêntica do ninja ou inimigo
    let texturePath = '';
    if (camp === 0) {
      // Aliado / Jogador Principal
      const prof = localNinja?.profession ?? (data.roleId || 1);
      const isFemale = localNinja?.gender === 0;

      if (prof === 3) {
        texturePath = isFemale ? '/assets/create_char/hero_genjutsu_f.png' : '/assets/create_char/hero_genjutsu_m.png';
      } else if (prof === 4) {
        texturePath = isFemale ? '/assets/create_char/hero_taijutsu_f.png' : '/assets/create_char/hero_taijutsu_m.png';
      } else {
        texturePath = isFemale ? '/assets/create_char/hero_ninjutsu_f.png' : '/assets/create_char/hero_ninjutsu_m.png';
      }
    } else {
      // Inimigos / Monstros / Rebeldes
      if (data.roleId > 20001 || data.pos > 1) {
        texturePath = '/assets/battle/enemy_boss.png';
      } else {
        texturePath = '/assets/battle/enemy_rebel.png';
      }
    }

    const tex = Assets.get(texturePath) || (camp === 0 ? Assets.get('/assets/town/ninja_blade.png') : null);
    if (tex && tex.width > 0) {
      this.sprite = new Sprite(tex);
      this.sprite.anchor.set(0.5, 1);
      this.sprite.position.set(0, 0);

      const targetHeight = 135;
      const aspect = tex.width / tex.height;
      this.sprite.height = targetHeight;
      this.sprite.width = targetHeight * aspect;
      this.bodyContainer.addChild(this.sprite);
    } else {
      // Fallback estilizado caso textura esteja carregando
      const fallback = new Graphics();
      fallback.roundRect(-22, -135, 44, 135, 10);
      fallback.fill(camp === 0 ? 0x2563eb : 0xdc2626);
      fallback.stroke({ color: camp === 0 ? 0xfbbf24 : 0xf87171, width: 2 });
      this.bodyContainer.addChild(fallback);
    }

    // 4. Painel de Informações (Nome e Barra de HP acima da cabeça)
    const uiContainer = new Container();
    uiContainer.position.set(0, -145);
    this.root.addChild(uiContainer);

    const isPlayerCamp = camp === 0;
    this.nameText = new Text({
      text: `${data.name} [Nv.${data.level}]`,
      style: {
        fill: isPlayerCamp ? '#fef08a' : '#fca5a5',
        fontSize: 12,
        fontWeight: 'bold',
        stroke: { color: '#000000', width: 3 },
      },
    });
    this.nameText.anchor.set(0.5, 1);
    this.nameText.position.set(0, -12);
    uiContainer.addChild(this.nameText);

    // Fundo da Barra de HP (80 x 8 px)
    const hpBarBg = new Graphics();
    hpBarBg.roundRect(-40, 0, 80, 8, 3);
    hpBarBg.fill(0x1e293b);
    hpBarBg.stroke({ color: 0x0f172a, width: 1.5 });
    uiContainer.addChild(hpBarBg);

    // Preenchimento da Barra de HP
    this.hpBarFill = new Graphics();
    this.drawHpBar(this.curHp / this.maxHp);
    uiContainer.addChild(this.hpBarFill);

    // Texto com valores numéricos de HP
    this.hpText = new Text({
      text: `${Math.round(this.curHp)}/${this.maxHp}`,
      style: {
        fill: '#ffffff',
        fontSize: 9,
        fontWeight: 'bold',
        stroke: { color: '#000000', width: 2 },
      },
    });
    this.hpText.anchor.set(0.5, 0);
    this.hpText.position.set(0, 10);
    uiContainer.addChild(this.hpText);
  }

  private drawHpBar(percent: number): void {
    const clamped = Math.max(0, Math.min(1, percent));
    const width = 80 * clamped;
    const fillColor = this.camp === 0 ? 0x22c55e : 0xef4444;

    this.hpBarFill.clear();
    if (width > 0) {
      this.hpBarFill.roundRect(-40, 0, width, 8, 2);
      this.hpBarFill.fill(fillColor);
    }
  }

  public setHp(newHp: number): void {
    this.curHp = Math.max(0, newHp);
    this.drawHpBar(this.curHp / this.maxHp);
    this.hpText.text = `${Math.round(this.curHp)}/${this.maxHp}`;

    if (this.curHp <= 0) {
      this.root.alpha = 0.45;
      this.bodyContainer.rotation = this.camp === 0 ? -0.45 : 0.45;
      if (this.sprite) {
        this.sprite.tint = 0x64748b;
      }
    }
  }

  public flashDamage(): void {
    if (this.sprite) {
      this.sprite.tint = 0xff3b30;
      setTimeout(() => {
        if (this.sprite && this.curHp > 0) {
          this.sprite.tint = 0xffffff;
        }
      }, 200);
    }
  }

  public shake(): void {
    const originalX = this.root.x;
    let count = 0;
    if (this.activeAnim) {
      Ticker.shared.remove(this.activeAnim);
    }
    const shakeAnim = () => {
      count++;
      this.root.x = originalX + (count % 2 === 0 ? 7 : -7);
      if (count > 6) {
        this.root.x = originalX;
        Ticker.shared.remove(shakeAnim);
        this.activeAnim = null;
      }
    };
    this.activeAnim = shakeAnim;
    Ticker.shared.add(shakeAnim);
  }

  public destroy(): void {
    if (this.activeAnim) {
      Ticker.shared.remove(this.activeAnim);
      this.activeAnim = null;
    }
    this.root.destroy({ children: true });
  }
}

/**
 * Cena de Combate por Turnos (Arena de Batalha PvE/PvP)
 * Baseada estritamente em TBattleConfig.as e TUnstreamizerBattleRepot.as
 * Viewport oficial: 1250 x 650
 */
export class BattleScene extends Container implements Scene {
  public static readonly BASE_WIDTH: number = 1250;
  public static readonly BASE_HEIGHT: number = 650;

  private report: BattleInitReport;
  private localNinja: LocalNinjaData;

  private contentContainer: Container;
  private arenaLayer: Container;
  private fightersLayer: Container;
  private effectsLayer: Container;
  private hudLayer: Container;

  private team1Fighters: Map<number, BattleFighterView> = new Map();
  private team2Fighters: Map<number, BattleFighterView> = new Map();

  private txtTurnBanner!: Text;
  private isBattleActive: boolean = true;
  private resizeHandler!: () => void;

  constructor(report: BattleInitReport, localNinja: LocalNinjaData) {
    super();
    this.report = report;
    this.localNinja = localNinja;

    this.contentContainer = new Container();
    this.addChild(this.contentContainer);

    this.arenaLayer = new Container();
    this.fightersLayer = new Container();
    this.fightersLayer.sortableChildren = true;
    this.effectsLayer = new Container();
    this.hudLayer = new Container();

    this.contentContainer.addChild(this.arenaLayer);
    this.contentContainer.addChild(this.fightersLayer);
    this.contentContainer.addChild(this.effectsLayer);
    this.contentContainer.addChild(this.hudLayer);

    this.setupResizeListener();
    this.updateLayout();

    this.initBattle();
  }

  private async initBattle(): Promise<void> {
    await this.loadAssets();
    this.setupArenaBackground();
    this.spawnFighters();
    this.setupHUD();

    console.log(
      `[BattleScene] Arena inicializada! Batalha ID: ${this.report.battleIdStr}, Turnos: ${this.report.turns.length}`
    );

    setTimeout(() => {
      this.playBattleSequence().catch((err) => {
        console.error('[BattleScene] Erro na reprodução de turnos:', err);
      });
    }, 800);
  }

  private async loadAssets(): Promise<void> {
    const assets = [
      '/assets/battle/bg_arena.jpg',
      '/assets/battle/enemy_rebel.png',
      '/assets/battle/enemy_boss.png',
      '/assets/create_char/hero_genjutsu_m.png',
      '/assets/create_char/hero_genjutsu_f.png',
      '/assets/create_char/hero_taijutsu_m.png',
      '/assets/create_char/hero_taijutsu_f.png',
      '/assets/create_char/hero_ninjutsu_m.png',
      '/assets/create_char/hero_ninjutsu_f.png',
      '/assets/town/ninja_blade.png',
    ];

    await Promise.all(
      assets.map((path) =>
        Assets.load(path).catch((err) => console.warn(`[BattleScene] Falha ao carregar ${path}:`, err))
      )
    );
  }

  private setupArenaBackground(): void {
    const tex = Assets.get('/assets/battle/bg_arena.jpg');
    if (tex && tex.width > 0) {
      const bgSprite = new Sprite(tex);
      bgSprite.position.set(0, 0);
      bgSprite.scale.set(1, 1);
      bgSprite.width = BattleScene.BASE_WIDTH;
      bgSprite.height = BattleScene.BASE_HEIGHT;
      this.arenaLayer.addChild(bgSprite);
    } else {
      const placeholder = new Graphics();
      placeholder.rect(0, 0, BattleScene.BASE_WIDTH, BattleScene.BASE_HEIGHT);
      placeholder.fill(0x1e1b4b);
      placeholder.stroke({ color: 0x4f46e5, width: 3 });
      this.arenaLayer.addChild(placeholder);
    }

    const gridMarks = new Graphics();
    for (let r = 0; r < 5; r++) {
      for (let c = 0; c < 3; c++) {
        // Camp 0 (Aliados)
        gridMarks.ellipse(FORMATION_X1[r][c], FORMATION_Y[r], 32, 14);
        gridMarks.stroke({ color: 0x38bdf8, width: 1.5, alpha: 0.3 });
        // Camp 1 (Inimigos)
        gridMarks.ellipse(FORMATION_X2[r][c], FORMATION_Y[r], 32, 14);
        gridMarks.stroke({ color: 0xf43f5e, width: 1.5, alpha: 0.3 });
      }
    }
    this.arenaLayer.addChild(gridMarks);
  }

  private spawnFighters(): void {
    // 1. Time 1 (Aliados / Player, Camp = 0)
    for (const fighter of this.report.team1.fighters) {
      const view = new BattleFighterView(0, fighter, this.localNinja);
      this.team1Fighters.set(fighter.pos, view);
      this.fightersLayer.addChild(view.root);
      console.log(`[BattleScene] Aliado instanciado: ${fighter.name} no Slot #${fighter.pos}`);
    }

    // 2. Time 2 (Inimigos / Camp = 1)
    for (const fighter of this.report.team2.fighters) {
      const view = new BattleFighterView(1, fighter);
      this.team2Fighters.set(fighter.pos, view);
      this.fightersLayer.addChild(view.root);
      console.log(`[BattleScene] Inimigo instanciado: ${fighter.name} no Slot #${fighter.pos}`);
    }
  }

  private setupHUD(): void {
    const topBar = new Graphics();
    topBar.roundRect(BattleScene.BASE_WIDTH / 2 - 220, 16, 440, 56, 8);
    topBar.fill({ color: 0x0f172a, alpha: 0.9 });
    topBar.stroke({ color: 0xf59e0b, width: 2 });
    this.hudLayer.addChild(topBar);

    const titleStyle = new TextStyle({
      fontFamily: 'Segoe UI, sans-serif',
      fontSize: 16,
      fontWeight: 'bold',
      fill: '#fbbf24',
      stroke: { color: '#000000', width: 3 },
    });
    const txtTitle = new Text({ text: '⚔️ ARENA DE COMBATE — EXAME CHŪNIN', style: titleStyle });
    txtTitle.anchor.set(0.5);
    txtTitle.position.set(BattleScene.BASE_WIDTH / 2, 34);
    this.hudLayer.addChild(txtTitle);

    this.txtTurnBanner = new Text({
      text: 'Preparando ninjas...',
      style: {
        fill: '#38bdf8',
        fontSize: 13,
        fontWeight: 'bold',
      },
    });
    this.txtTurnBanner.anchor.set(0.5);
    this.txtTurnBanner.position.set(BattleScene.BASE_WIDTH / 2, 54);
    this.hudLayer.addChild(this.txtTurnBanner);
  }

  private async playBattleSequence(): Promise<void> {
    const turns = this.report.turns;

    for (let t = 0; t < turns.length; t++) {
      if (!this.isBattleActive) return;

      const turn = turns[t];
      this.txtTurnBanner.text = `Turno ${turn.curTurn} de ${turns.length}`;
      await this.showTurnAnnouncement(`TURNO ${turn.curTurn}`);

      for (const action of turn.actions) {
        if (!this.isBattleActive) return;
        await this.executeAction(action);
        await this.wait(650);
      }

      await this.wait(400);
    }

    await this.wait(700);
    this.showVictoryModal();
  }

  private async executeAction(action: ActionBattleData): Promise<void> {
    const attackerMap = action.activeCamp === 0 ? this.team1Fighters : this.team2Fighters;
    const defenderMap = action.activeCamp === 0 ? this.team2Fighters : this.team1Fighters;

    const attacker = attackerMap.get(action.activePos);
    if (!attacker) return;

    const isSkill = action.activeType === 2;

    for (const targetResult of action.targets) {
      const defender = defenderMap.get(targetResult.targetPos);
      if (!defender) continue;

      if (isSkill) {
        this.spawnChakraBurst(attacker.originX, attacker.originY - 70);
        await this.wait(200);
      }

      const targetApproachX = defender.originX + (action.activeCamp === 0 ? -70 : 70);
      const targetApproachY = defender.originY;

      await this.tweenPosition(attacker.root, attacker.originX, attacker.originY, targetApproachX, targetApproachY, 220);

      defender.flashDamage();
      defender.shake();

      if (isSkill) {
        this.spawnJutsuExplosion(defender.originX, defender.originY - 65);
      } else {
        this.spawnSlashEffect(defender.originX, defender.originY - 65);
      }

      const hurt = targetResult.hurtHp ?? 500;
      this.spawnDamagePopup(defender.originX, defender.originY - 90, hurt, isSkill);

      defender.setHp(defender.curHp - hurt);

      await this.wait(220);

      await this.tweenPosition(attacker.root, targetApproachX, targetApproachY, attacker.originX, attacker.originY, 220);
    }
  }

  private tweenPosition(
    target: Container,
    fromX: number,
    fromY: number,
    toX: number,
    toY: number,
    durationMs: number
  ): Promise<void> {
    return new Promise((resolve) => {
      const startTime = performance.now();

      const update = () => {
        const now = performance.now();
        const progress = Math.min(1, (now - startTime) / durationMs);
        const ease = 1 - (1 - progress) * (1 - progress);

        target.x = fromX + (toX - fromX) * ease;
        target.y = fromY + (toY - fromY) * ease;

        if (progress >= 1) {
          Ticker.shared.remove(update);
          target.x = toX;
          target.y = toY;
          resolve();
        }
      };

      Ticker.shared.add(update);
    });
  }

  private spawnDamagePopup(x: number, y: number, damage: number, isSkill: boolean): void {
    const textStr = isSkill ? `💥 JUTSU! -${damage}` : `-${damage} HP`;
    const dmgText = new Text({
      text: textStr,
      style: {
        fill: isSkill ? '#fbbf24' : '#ef4444',
        fontSize: isSkill ? 24 : 20,
        fontWeight: 'bold',
        stroke: { color: '#000000', width: 4 },
        dropShadow: { color: '#000000', blur: 4, distance: 2 },
      },
    });
    dmgText.anchor.set(0.5);
    dmgText.position.set(x, y);
    dmgText.scale.set(1.4);
    this.effectsLayer.addChild(dmgText);

    let progress = 0;
    const anim = () => {
      progress += 0.04;
      dmgText.y -= 1.8;
      if (dmgText.scale.x > 1.0) {
        dmgText.scale.set(Math.max(1.0, dmgText.scale.x - 0.05));
      }
      dmgText.alpha = Math.max(0, 1.2 - progress);

      if (progress >= 1.2) {
        Ticker.shared.remove(anim);
        dmgText.destroy();
      }
    };
    Ticker.shared.add(anim);
  }

  private spawnSlashEffect(x: number, y: number): void {
    const slash = new Graphics();
    slash.moveTo(-25, -20);
    slash.lineTo(25, 20);
    slash.stroke({ color: 0xfef08a, width: 4 });
    slash.position.set(x, y);
    this.effectsLayer.addChild(slash);

    let alpha = 1;
    const anim = () => {
      alpha -= 0.12;
      slash.alpha = Math.max(0, alpha);
      slash.scale.x += 0.05;
      if (alpha <= 0) {
        Ticker.shared.remove(anim);
        slash.destroy();
      }
    };
    Ticker.shared.add(anim);
  }

  private spawnJutsuExplosion(x: number, y: number): void {
    const aura = new Graphics();
    aura.circle(0, 0, 36);
    aura.fill({ color: 0x38bdf8, alpha: 0.75 });
    aura.stroke({ color: 0xfbbf24, width: 4 });
    aura.position.set(x, y);
    this.effectsLayer.addChild(aura);

    let progress = 0;
    const anim = () => {
      progress += 0.08;
      aura.scale.set(1 + progress * 1.5);
      aura.alpha = Math.max(0, 1 - progress);
      if (progress >= 1) {
        Ticker.shared.remove(anim);
        aura.destroy();
      }
    };
    Ticker.shared.add(anim);
  }

  private spawnChakraBurst(x: number, y: number): void {
    const burst = new Graphics();
    burst.circle(0, 0, 22);
    burst.fill({ color: 0x06b6d4, alpha: 0.65 });
    burst.stroke({ color: 0x38bdf8, width: 3 });
    burst.position.set(x, y);
    this.effectsLayer.addChild(burst);

    let step = 0;
    const anim = () => {
      step += 0.1;
      burst.scale.set(1 + step * 0.9);
      burst.alpha = Math.max(0, 1 - step);
      if (step >= 1) {
        Ticker.shared.remove(anim);
        burst.destroy();
      }
    };
    Ticker.shared.add(anim);
  }

  private showTurnAnnouncement(text: string): Promise<void> {
    return new Promise((resolve) => {
      const banner = new Text({
        text,
        style: {
          fill: '#fef08a',
          fontSize: 28,
          fontWeight: 'bold',
          stroke: { color: '#000000', width: 5 },
          letterSpacing: 4,
        },
      });
      banner.anchor.set(0.5);
      banner.position.set(BattleScene.BASE_WIDTH / 2, BattleScene.BASE_HEIGHT / 2 - 60);
      banner.scale.set(0.5);
      banner.alpha = 0;
      this.effectsLayer.addChild(banner);

      let step = 0;
      const anim = () => {
        step += 0.06;
        if (step < 0.5) {
          banner.alpha = step * 2;
          banner.scale.set(0.5 + step);
        } else if (step > 1.0) {
          banner.alpha = Math.max(0, 2 - step);
        }

        if (step >= 2.0) {
          Ticker.shared.remove(anim);
          banner.destroy();
          resolve();
        }
      };
      Ticker.shared.add(anim);
    });
  }

  private showVictoryModal(): void {
    const overlay = new Graphics();
    overlay.rect(0, 0, BattleScene.BASE_WIDTH, BattleScene.BASE_HEIGHT);
    overlay.fill({ color: 0x000000, alpha: 0.75 });
    overlay.eventMode = 'static';
    this.hudLayer.addChild(overlay);

    const modalBox = new Container();
    modalBox.position.set(BattleScene.BASE_WIDTH / 2, BattleScene.BASE_HEIGHT / 2);

    const card = new Graphics();
    card.roundRect(-220, -160, 440, 320, 16);
    card.fill(0x0f172a);
    card.stroke({ color: 0xf59e0b, width: 3 });
    modalBox.addChild(card);

    const txtVictory = new Text({
      text: '🏆 VITÓRIA!',
      style: {
        fill: '#fbbf24',
        fontSize: 34,
        fontWeight: 'bold',
        stroke: { color: '#000000', width: 4 },
        dropShadow: { color: '#f59e0b', blur: 12, distance: 0 },
      },
    });
    txtVictory.anchor.set(0.5);
    txtVictory.position.set(0, -100);
    modalBox.addChild(txtVictory);

    const txtSubtitle = new Text({
      text: 'Os Ninjas Rebeldes foram derrotados com honra!',
      style: { fill: '#94a3b8', fontSize: 14 },
    });
    txtSubtitle.anchor.set(0.5);
    txtSubtitle.position.set(0, -60);
    modalBox.addChild(txtSubtitle);

    const rewardBox = new Graphics();
    rewardBox.roundRect(-180, -35, 360, 95, 8);
    rewardBox.fill({ color: 0x1e293b, alpha: 0.9 });
    rewardBox.stroke({ color: 0x334155, width: 1.5 });
    modalBox.addChild(rewardBox);

    const txtRewardTitle = new Text({
      text: '🎁 Recompensas da Batalha:',
      style: { fill: '#4ade80', fontSize: 13, fontWeight: 'bold' },
    });
    txtRewardTitle.position.set(-160, -25);
    modalBox.addChild(txtRewardTitle);

    const txtRewards = new Text({
      text: '• ⚡ Experiência: +350 EXP\n• 🪙 Ryōs: +500 Moedas\n• 📜 Pergaminho Ninja Iniciante x1',
      style: { fill: '#f8fafc', fontSize: 13, lineHeight: 20 },
    });
    txtRewards.position.set(-150, -2);
    modalBox.addChild(txtRewards);

    const btnReturn = new Container();
    btnReturn.eventMode = 'static';
    btnReturn.cursor = 'pointer';

    const bgBtn = new Graphics();
    bgBtn.roundRect(-140, 0, 280, 48, 10);
    bgBtn.fill(0x16a34a);
    bgBtn.stroke({ color: 0x22c55e, width: 2 });
    btnReturn.addChild(bgBtn);

    const txtBtn = new Text({
      text: '🍃 Voltar para Konoha',
      style: { fill: '#ffffff', fontSize: 16, fontWeight: 'bold' },
    });
    txtBtn.anchor.set(0.5);
    txtBtn.position.set(0, 24);
    btnReturn.addChild(txtBtn);

    btnReturn.position.set(0, 80);

    btnReturn.on('pointerenter', () => {
      bgBtn.clear();
      bgBtn.roundRect(-140, 0, 280, 48, 10);
      bgBtn.fill(0x15803d);
      bgBtn.stroke({ color: 0x4ade80, width: 2 });
    });

    btnReturn.on('pointerleave', () => {
      bgBtn.clear();
      bgBtn.roundRect(-140, 0, 280, 48, 10);
      bgBtn.fill(0x16a34a);
      bgBtn.stroke({ color: 0x22c55e, width: 2 });
    });

    btnReturn.on('pointertap', () => {
      this.returnToTown();
    });

    modalBox.addChild(btnReturn);
    this.hudLayer.addChild(modalBox);
  }

  private returnToTown(): void {
    console.log('[BattleScene] Retornando para Konohagakure...');
    this.isBattleActive = false;

    const pw = new WebPacketWriter();
    pw.writeUnsignedInt(1);
    clientSocket.send(OPCODES.CS_LOBBY_Enter_Town, pw);

    gameApp.changeScene(new TownScene(this.localNinja, 1200, 500));
  }

  private wait(ms: number): Promise<void> {
    return new Promise((resolve) => setTimeout(resolve, ms));
  }

  private updateLayout(): void {
    const screenW = gameApp.screen.width;
    const screenH = gameApp.screen.height;

    const scale = Math.min(screenW / BattleScene.BASE_WIDTH, screenH / BattleScene.BASE_HEIGHT, 1.25);
    this.contentContainer.scale.set(scale);
    this.contentContainer.position.set(
      (screenW - BattleScene.BASE_WIDTH * scale) / 2,
      (screenH - BattleScene.BASE_HEIGHT * scale) / 2
    );
  }

  private setupResizeListener(): void {
    this.resizeHandler = () => {
      this.updateLayout();
    };
    window.addEventListener('resize', this.resizeHandler);
  }

  public override destroy(options?: any): void {
    this.isBattleActive = false;
    if (this.resizeHandler) {
      window.removeEventListener('resize', this.resizeHandler);
    }
    for (const fighter of this.team1Fighters.values()) {
      fighter.destroy();
    }
    for (const fighter of this.team2Fighters.values()) {
      fighter.destroy();
    }
    this.team1Fighters.clear();
    this.team2Fighters.clear();
    super.destroy(options);
  }
}
