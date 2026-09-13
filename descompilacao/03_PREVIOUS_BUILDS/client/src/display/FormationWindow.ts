import { Container, Graphics, Sprite, Text, Assets } from 'pixi.js';
import { clientSocket, WebPacketWriter, WebPacketReader } from '../network/clientSocket.ts';
import { OPCODES } from '../../../shared/opcodes.ts';

export interface FormationNinja {
  id: number;
  character_id: number;
  hero_id: number;
  name: string;
  profession: number;
  level: number;
  formation_pos: number; // 1 a 9 (0 = reserva)
  avatar_key: string;
  quality: number;
  hp: number;
  atk: number;
  def: number;
  spd: number;
}

export class FormationWindow extends Container {
  private contentContainer: Container;
  private teamMembers: FormationNinja[] = [];
  private selectedHeroId: number | null = null;
  private txtTotalBP: Text | null = null;
  private gridSlotsContainer: Container;
  private rosterContainer: Container;
  private onCloseCallback?: () => void;

  public static readonly WIDTH = 860;
  public static readonly HEIGHT = 540;

  constructor(onClose?: () => void) {
    super();
    this.onCloseCallback = onClose;
    this.eventMode = 'static';
    this.zIndex = 50000;

    // Overlay escuro
    const blocker = new Graphics();
    blocker.rect(-2000, -2000, 4000, 4000);
    blocker.fill({ color: 0x000000, alpha: 0.5 });
    blocker.eventMode = 'static';
    blocker.on('pointertap', () => this.close());
    this.addChild(blocker);

    this.contentContainer = new Container();
    this.contentContainer.eventMode = 'static';
    this.addChild(this.contentContainer);

    this.gridSlotsContainer = new Container();
    this.contentContainer.addChild(this.gridSlotsContainer);

    this.rosterContainer = new Container();
    this.contentContainer.addChild(this.rosterContainer);

    this.setupWindow();
    this.setupNetwork();
  }

  private setupWindow(): void {
    // 1. Moldura de Fundo
    const formTex = Assets.get('/assets/ui/modal_formation.png');
    if (formTex) {
      const bg = new Sprite(formTex);
      bg.width = FormationWindow.WIDTH;
      bg.height = FormationWindow.HEIGHT;
      this.contentContainer.addChild(bg);
    } else {
      const fallback = new Graphics();
      fallback.roundRect(0, 0, FormationWindow.WIDTH, FormationWindow.HEIGHT, 12);
      fallback.fill(0x0f172a);
      this.contentContainer.addChild(fallback);
    }

    const overlay = new Graphics();
    overlay.roundRect(10, 10, FormationWindow.WIDTH - 20, FormationWindow.HEIGHT - 20, 10);
    overlay.fill({ color: 0x090d16, alpha: 0.85 });
    overlay.stroke({ color: 0x38bdf8, width: 2 });
    this.contentContainer.addChild(overlay);

    // 2. Título
    const title = new Text({
      text: '⚔️ Formação Tática Shinobi (Grade 3x3)',
      style: {
        fill: '#fbbf24',
        fontSize: 16,
        fontWeight: 'bold',
        stroke: { color: '#000000', width: 3 },
      },
    });
    title.position.set(28, 22);
    this.contentContainer.addChild(title);

    // 3. Poder de Luta Total (BP)
    this.txtTotalBP = new Text({
      text: 'Poder de Luta (BP): 0',
      style: {
        fill: '#ef4444',
        fontSize: 14,
        fontWeight: 'bold',
        stroke: { color: '#000000', width: 2 },
      },
    });
    this.txtTotalBP.position.set(FormationWindow.WIDTH - 260, 24);
    this.contentContainer.addChild(this.txtTotalBP);

    // 4. Botão Fechar
    const closeBtn = new Container();
    closeBtn.position.set(FormationWindow.WIDTH - 42, 20);
    closeBtn.eventMode = 'static';
    closeBtn.cursor = 'pointer';

    const closeTex = Assets.get('/assets/ui/btn_close.png');
    if (closeTex) {
      const spr = new Sprite(closeTex);
      closeBtn.addChild(spr);
    } else {
      const c = new Graphics();
      c.circle(10, 10, 10);
      c.fill(0xdc2626);
      closeBtn.addChild(c);
    }
    closeBtn.on('pointertap', () => this.close());
    this.contentContainer.addChild(closeBtn);
  }

  private setupNetwork(): void {
    clientSocket.on(OPCODES.SC_Enter_Tavern, (reader: WebPacketReader) => {
      try {
        const payloadStr = reader.readStringUTF();
        if (!payloadStr) return;
        const data = JSON.parse(payloadStr);
        if (data.team) {
          this.teamMembers = data.team;
          this.renderBoard();
        }
      } catch (e) {
        console.error('[FormationWindow] Erro ao processar SC_Enter_Tavern:', e);
      }
    });

    clientSocket.on(OPCODES.SC_TacticalDeploymentChangePositonRet, (reader: WebPacketReader) => {
      try {
        const payloadStr = reader.readStringUTF();
        if (!payloadStr) return;
        const data = JSON.parse(payloadStr);
        if (data.team) {
          this.teamMembers = data.team;
          this.renderBoard();
        }
      } catch (e) {
        console.error('[FormationWindow] Erro ao processar SC_TacticalDeploymentChangePositonRet:', e);
      }
    });

    this.requestTeamData();
  }

  public requestTeamData(): void {
    const pw = new WebPacketWriter();
    clientSocket.send(OPCODES.CS_Enter_Tavern, pw);
  }

  public open(): void {
    this.visible = true;
    this.requestTeamData();
  }

  public close(): void {
    this.visible = false;
    this.selectedHeroId = null;
    if (this.onCloseCallback) this.onCloseCallback();
  }

  /**
   * Renderiza a grade 3x3 e os ninjas disponíveis
   */
  private renderBoard(): void {
    this.gridSlotsContainer.removeChildren();
    this.rosterContainer.removeChildren();

    // 1. Calcula BP Total
    let totalBP = 0;
    this.teamMembers
      .filter((m) => m.formation_pos > 0)
      .forEach((m) => {
        totalBP += Math.round(m.hp * 0.25 + m.atk * 2.2 + m.def * 1.5 + m.spd * 1.8);
      });
    if (this.txtTotalBP) {
      this.txtTotalBP.text = `Poder de Luta (BP): ${totalBP.toLocaleString('pt-BR')}`;
    }

    // 2. Colunas da Grade 3x3
    // Coluna 0: Vanguarda (Slots 1, 2, 3)
    // Coluna 1: Assalto (Slots 4, 5, 6)
    // Coluna 2: Apoio (Slots 7, 8, 9)
    const colLabels = ['🛡️ Vanguarda (Frente)', '⚔️ Assalto (Centro)', '✨ Apoio (Fundo)'];
    const slotW = 140;
    const slotH = 92;
    const gapX = 30;
    const gapY = 16;
    const startX = 180;
    const startY = 80;

    colLabels.forEach((label, c) => {
      const txtCol = new Text({
        text: label,
        style: { fill: '#38bdf8', fontSize: 12, fontWeight: 'bold' },
      });
      txtCol.anchor.set(0.5, 1);
      txtCol.position.set(startX + c * (slotW + gapX) + slotW / 2, startY - 8);
      this.gridSlotsContainer.addChild(txtCol);

      for (let r = 0; r < 3; r++) {
        const slotPos = c * 3 + r + 1; // 1 a 9
        const slotBox = new Container();
        slotBox.position.set(startX + c * (slotW + gapX), startY + r * (slotH + gapY));
        slotBox.eventMode = 'static';
        slotBox.cursor = 'pointer';

        const ninjaAtSlot = this.teamMembers.find((m) => m.formation_pos === slotPos);

        const bg = new Graphics();
        bg.roundRect(0, 0, slotW, slotH, 8);
        bg.fill({ color: ninjaAtSlot ? 0x1e293b : 0x0b1329, alpha: 0.9 });
        bg.stroke({ color: ninjaAtSlot ? 0xf59e0b : 0x334155, width: 2 });
        slotBox.addChild(bg);

        if (ninjaAtSlot) {
          // Exibe avatar e detalhes do ninja
          const avatarTex = this.resolveAvatarTexture(ninjaAtSlot);
          if (avatarTex) {
            const spr = new Sprite(avatarTex);
            spr.width = 46;
            spr.height = 46;
            spr.position.set(8, 10);
            slotBox.addChild(spr);
          }

          const txtNinja = new Text({
            text: `${ninjaAtSlot.name}\nNv. ${ninjaAtSlot.level}`,
            style: { fill: '#ffffff', fontSize: 11, fontWeight: 'bold' },
          });
          txtNinja.position.set(60, 10);
          slotBox.addChild(txtNinja);

          const txtStats = new Text({
            text: `ATK: ${ninjaAtSlot.atk} | HP: ${ninjaAtSlot.hp}`,
            style: { fill: '#94a3b8', fontSize: 9 },
          });
          txtStats.position.set(10, 68);
          slotBox.addChild(txtStats);
        } else {
          const emptyTxt = new Text({
            text: `Slot #${slotPos}\n(Vazio)`,
            style: { fill: '#475569', fontSize: 11, align: 'center' },
          });
          emptyTxt.anchor.set(0.5);
          emptyTxt.position.set(slotW / 2, slotH / 2);
          slotBox.addChild(emptyTxt);
        }

        // Clique no slot do tabuleiro
        slotBox.on('pointertap', () => {
          if (this.selectedHeroId !== null) {
            this.changePosition(this.selectedHeroId, slotPos);
            this.selectedHeroId = null;
          } else if (ninjaAtSlot) {
            // Se nenhum ninja selecionado e clicou no slot preenchido, envia para reserva (0)
            this.changePosition(ninjaAtSlot.hero_id, 0);
          }
        });

        this.gridSlotsContainer.addChild(slotBox);
      }
    });

    // 3. Roster de Ninjas Recrutados (Parte Inferior)
    const rosterY = FormationWindow.HEIGHT - 130;
    const txtRoster = new Text({
      text: '👥 Seus Ninjas (Clique para Selecionar e Posicionar na Grade):',
      style: { fill: '#fcd34d', fontSize: 12, fontWeight: 'bold' },
    });
    txtRoster.position.set(30, rosterY - 8);
    this.rosterContainer.addChild(txtRoster);

    const cardW = 145;
    const cardH = 80;
    const cardGap = 16;

    this.teamMembers.forEach((member, i) => {
      const card = new Container();
      card.position.set(30 + i * (cardW + cardGap), rosterY + 16);
      card.eventMode = 'static';
      card.cursor = 'pointer';

      const isSelected = this.selectedHeroId === member.hero_id;
      const isDeployed = member.formation_pos > 0;

      const cardBg = new Graphics();
      cardBg.roundRect(0, 0, cardW, cardH, 8);
      cardBg.fill({ color: isSelected ? 0x2563eb : 0x1e293b, alpha: 0.95 });
      cardBg.stroke({ color: isSelected ? 0x60a5fa : isDeployed ? 0x22c55e : 0x64748b, width: 2 });
      card.addChild(cardBg);

      const avatarTex = this.resolveAvatarTexture(member);
      if (avatarTex) {
        const spr = new Sprite(avatarTex);
        spr.width = 42;
        spr.height = 42;
        spr.position.set(8, 8);
        card.addChild(spr);
      }

      const txtName = new Text({
        text: member.name,
        style: { fill: '#ffffff', fontSize: 11, fontWeight: 'bold' },
      });
      txtName.position.set(56, 8);
      card.addChild(txtName);

      const txtStatus = new Text({
        text: isDeployed ? `Slot #${member.formation_pos}` : 'Em Reserva',
        style: { fill: isDeployed ? '#4ade80' : '#94a3b8', fontSize: 10, fontWeight: 'bold' },
      });
      txtStatus.position.set(56, 26);
      card.addChild(txtStatus);

      card.on('pointertap', () => {
        if (this.selectedHeroId === member.hero_id) {
          this.selectedHeroId = null;
        } else {
          this.selectedHeroId = member.hero_id;
        }
        this.renderBoard();
      });

      this.rosterContainer.addChild(card);
    });
  }

  private resolveAvatarTexture(ninja: FormationNinja): any {
    if (ninja.avatar_key === 'naruto') return Assets.get('/assets/ninjas/ninja_naruto.png');
    if (ninja.avatar_key === 'sasuke') return Assets.get('/assets/ninjas/ninja_sasuke.png');
    if (ninja.avatar_key === 'sakura') return Assets.get('/assets/ninjas/ninja_sakura.png');
    return Assets.get('/assets/town/ninja_blade.png') || Assets.get('/assets/ui/avatar_blade.png');
  }

  private changePosition(heroId: number, newPos: number): void {
    const pw = new WebPacketWriter();
    pw.writeInt(heroId);
    pw.writeByte(newPos);
    clientSocket.send(OPCODES.CS_TacticalDeployment_ChangePositionReq, pw);
  }

  public destroy(options?: any): void {
    clientSocket.off(OPCODES.SC_Enter_Tavern);
    clientSocket.off(OPCODES.SC_TacticalDeploymentChangePositonRet);
    super.destroy(options);
  }
}
