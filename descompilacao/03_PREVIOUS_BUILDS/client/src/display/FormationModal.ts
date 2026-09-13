import { Container, Graphics, Sprite, Text, Assets, FederatedPointerEvent } from 'pixi.js';
import { BaseModal } from './BaseModal';
import { clientSocket, WebPacketWriter } from '../network/clientSocket.ts';
import { OPCODES } from '../../../shared/opcodes.ts';

export interface FormationNinjaMember {
  id: number;
  character_id: number;
  hero_id: number;
  name: string;
  profession: number; // 1: Ninjutsu, 3: Genjutsu, 4: Taijutsu
  level: number;
  formation_pos: number; // 1 a 15 (0 = fora da formação / reserva)
  avatar_key: string;
  quality: number;
  hp: number;
  atk: number;
  def: number;
  spd: number;
}

export class FormationModal extends BaseModal {
  private teamMembers: FormationNinjaMember[] = [];
  private selectedHeroId: number | null = null;
  private formationSlots: Map<number, Container> = new Map();
  private listContainer!: Container;
  private infoLabel!: Text;

  constructor() {
    super({
      title: 'Formação Tática Shinobi (15 Slots: Vanguarda, Assalto, Apoio)',
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
    // 1. Painel Esquerdo: Lista de Ninjas Recrutados (X: 20, Y: 52, W: 310, H: 485)
    this.buildNinjaListPanel(20, 52);

    // 2. Painel Direito: Tabuleiro Tático 5x3 (15 slots) (X: 345, Y: 52, W: 595, H: 485)
    this.buildTacticalBoard(345, 52);
  }

  private buildNinjaListPanel(startX: number, startY: number): void {
    const panelBg = new Graphics();
    panelBg.roundRect(startX, startY, 310, 485, 8);
    panelBg.fill({ color: 0x111827, alpha: 0.95 });
    panelBg.stroke({ color: 0x92400e, width: 2 });
    this.windowContainer.addChild(panelBg);

    const title = new Text({
      text: 'NINJAS DA EQUIPE',
      style: { fill: '#fbbf24', fontSize: 13, fontWeight: 'bold' },
    });
    title.position.set(startX + 16, startY + 12);
    this.windowContainer.addChild(title);

    const hint = new Text({
      text: 'Selecione um ninja e clique em um slot do tabuleiro para posicioná-lo.',
      style: { fill: '#94a3b8', fontSize: 10, wordWrap: true, wordWrapWidth: 280 },
    });
    hint.position.set(startX + 16, startY + 34);
    this.windowContainer.addChild(hint);

    this.listContainer = new Container();
    this.listContainer.position.set(startX + 12, startY + 68);
    this.windowContainer.addChild(this.listContainer);
  }

  private buildTacticalBoard(startX: number, startY: number): void {
    const boardBg = new Graphics();
    boardBg.roundRect(startX, startY, 595, 485, 8);
    boardBg.fill({ color: 0x18181b, alpha: 0.95 });
    boardBg.stroke({ color: 0xb45309, width: 2 });
    this.windowContainer.addChild(boardBg);

    // Cabeçalho das 3 Linhas Táticas
    const columns = [
      { name: 'APOIO (FUNDO)', color: '#38bdf8', col: 0, x: startX + 35 },
      { name: 'ASSALTO (MEIO)', color: '#fb923c', col: 1, x: startX + 225 },
      { name: 'VANGUARDA (FRENTE)', color: '#ef4444', col: 2, x: startX + 415 },
    ];

    for (const c of columns) {
      const colHeader = new Text({
        text: c.name,
        style: { fill: c.color, fontSize: 12, fontWeight: 'bold' },
      });
      colHeader.anchor.set(0.5, 0);
      colHeader.position.set(c.x + 65, startY + 14);
      this.windowContainer.addChild(colHeader);
    }

    // Grid 5 Linhas x 3 Colunas = 15 Slots
    // Linha 0 a 4 (Y), Coluna 0 a 2 (X)
    // Numeração oficial dos slots: 1 a 15
    const slotW = 130;
    const slotH = 75;
    const gapX = 60;
    const gapY = 14;
    const gridStartX = startX + 35;
    const gridStartY = startY + 45;

    let slotNumber = 1;
    for (let r = 0; r < 5; r++) {
      for (let c = 0; c < 3; c++) {
        const x = gridStartX + c * (slotW + gapX);
        const y = gridStartY + r * (slotH + gapY);
        const num = slotNumber++;

        const slotView = this.createBoardSlotView(num, x, y);
        this.formationSlots.set(num, slotView);
        this.windowContainer.addChild(slotView);
      }
    }

    // Painel informativo no rodapé
    this.infoLabel = new Text({
      text: 'Selecione um ninja à esquerda para posicionar na formação.',
      style: { fill: '#fbbf24', fontSize: 11, fontWeight: '600' },
    });
    this.infoLabel.position.set(startX + 35, startY + 452);
    this.windowContainer.addChild(this.infoLabel);
  }

  private createBoardSlotView(slotNum: number, x: number, y: number): Container {
    const slot = new Container();
    slot.position.set(x, y);
    slot.eventMode = 'static';
    slot.cursor = 'pointer';

    const bg = new Graphics();
    bg.roundRect(0, 0, 130, 75, 6);
    bg.fill({ color: 0x27272a, alpha: 0.9 });
    bg.stroke({ color: 0x52525b, width: 1.5 });
    slot.addChild(bg);

    const slotTag = new Text({
      text: `#${slotNum}`,
      style: { fill: '#71717a', fontSize: 10, fontWeight: 'bold' },
    });
    slotTag.position.set(6, 6);
    slot.addChild(slotTag);

    // Retrato do ninja posicionado
    const avatarSpr = new Sprite();
    avatarSpr.width = 44;
    avatarSpr.height = 44;
    avatarSpr.position.set(43, 6);
    avatarSpr.visible = false;
    slot.addChild(avatarSpr);

    // Nome do ninja posicionado
    const nameTxt = new Text({
      text: 'Vazio',
      style: { fill: '#a1a1aa', fontSize: 10, fontWeight: 'bold' },
    });
    nameTxt.anchor.set(0.5, 0);
    nameTxt.position.set(65, 54);
    slot.addChild(nameTxt);

    slot.on('pointertap', () => {
      this.handleSlotClick(slotNum);
    });

    slot.on('pointerenter', () => {
      bg.stroke({ color: 0xf59e0b, width: 2 });
    });
    slot.on('pointerleave', () => {
      bg.stroke({ color: 0x52525b, width: 1.5 });
    });

    return slot;
  }

  private renderTeamList(): void {
    this.listContainer.removeChildren();

    let curY = 0;
    for (const member of this.teamMembers) {
      const card = this.createMemberCard(member, curY);
      this.listContainer.addChild(card);
      curY += 66;
    }
  }

  private createMemberCard(member: FormationNinjaMember, y: number): Container {
    const card = new Container();
    card.position.set(0, y);
    card.eventMode = 'static';
    card.cursor = 'pointer';

    const isSelected = this.selectedHeroId === member.hero_id;
    const isInCombat = member.formation_pos > 0;

    const bg = new Graphics();
    bg.roundRect(0, 0, 286, 58, 6);
    bg.fill({ color: isSelected ? 0x451a03 : 0x1f2937, alpha: 0.95 });
    bg.stroke({ color: isSelected ? 0xf59e0b : (isInCombat ? 0x22c55e : 0x4b5563), width: 1.5 });
    card.addChild(bg);

    // Miniatura / Ícone
    const spr = new Sprite();
    spr.width = 42;
    spr.height = 42;
    spr.position.set(8, 8);

    const avatarPath = this.getNinjaAvatarPath(member.name);
    const tex = Assets.get(avatarPath);
    if (tex) spr.texture = tex;
    card.addChild(spr);

    // Nome
    const nameTxt = new Text({
      text: member.name,
      style: { fill: '#fef08a', fontSize: 12, fontWeight: 'bold' },
    });
    nameTxt.position.set(58, 8);
    card.addChild(nameTxt);

    // Posição na formação / Reserva
    const posTxt = new Text({
      text: isInCombat ? `Em Combate (Slot #${member.formation_pos})` : 'Reserva (Fora do Tabuleiro)',
      style: { fill: isInCombat ? '#4ade80' : '#94a3b8', fontSize: 10, fontWeight: '600' },
    });
    posTxt.position.set(58, 28);
    card.addChild(posTxt);

    card.on('pointertap', () => {
      this.selectedHeroId = member.hero_id;
      this.infoLabel.text = `Ninja selecionado: ${member.name}. Agora clique em um slot para posicioná-lo.`;
      this.renderTeamList();
    });

    return card;
  }

  private getNinjaAvatarPath(name: string): string {
    const lower = name.toLowerCase();
    if (lower.includes('naruto')) return '/assets/ninjas/ninja_naruto.png';
    if (lower.includes('sasuke')) return '/assets/ninjas/ninja_sasuke.png';
    if (lower.includes('sakura')) return '/assets/ninjas/ninja_sakura.png';
    if (lower.includes('kakashi')) return '/assets/animated/npcs/kakashi/idle_0.png';
    if (lower.includes('lee')) return '/assets/animated/npcs/rock_lee/idle_0.png';
    if (lower.includes('neji')) return '/assets/animated/npcs/neji/idle_0.png';
    return '/assets/ui/avatar_blade.png';
  }

  private handleSlotClick(slotNum: number): void {
    if (!this.selectedHeroId) {
      // Se não tem herói selecionado, verifica se há alguém no slot para desselecionar/remover
      const occupant = this.teamMembers.find((m) => m.formation_pos === slotNum);
      if (occupant) {
        this.selectedHeroId = occupant.hero_id;
        this.infoLabel.text = `${occupant.name} selecionado. Clique em outro slot para mover ou no mesmo para tirar da formação.`;
        this.renderTeamList();
      }
      return;
    }

    const currentHero = this.teamMembers.find((m) => m.hero_id === this.selectedHeroId);
    if (!currentHero) return;

    // Se clicou no mesmo slot em que o herói já está, move para a reserva (pos = 0)
    const targetPos = currentHero.formation_pos === slotNum ? 0 : slotNum;

    // Envia pacote ao servidor para atualizar posição
    const pw = new WebPacketWriter();
    pw.writeInt(this.selectedHeroId);
    pw.writeByte(targetPos);
    clientSocket.send(OPCODES.CS_TacticalDeployment_ChangePositionReq, pw);

    this.infoLabel.text = `Enviando ordem tática para ${currentHero.name}...`;
    this.selectedHeroId = null;
  }

  public updateTeam(members: FormationNinjaMember[]): void {
    this.teamMembers = members;
    this.renderTeamList();

    // Atualiza os 15 slots do tabuleiro
    for (let num = 1; num <= 15; num++) {
      const slotView = this.formationSlots.get(num);
      if (!slotView) continue;

      const avatarSpr = slotView.children[2] as Sprite;
      const nameTxt = slotView.children[3] as Text;

      const occupant = members.find((m) => m.formation_pos === num);
      if (occupant) {
        const tex = Assets.get(this.getNinjaAvatarPath(occupant.name));
        if (tex) {
          avatarSpr.texture = tex;
          avatarSpr.visible = true;
        } else {
          avatarSpr.visible = false;
        }
        nameTxt.text = occupant.name;
        nameTxt.style.fill = '#fef08a';
      } else {
        avatarSpr.visible = false;
        nameTxt.text = 'Vazio';
        nameTxt.style.fill = '#71717a';
      }
    }
  }
}

