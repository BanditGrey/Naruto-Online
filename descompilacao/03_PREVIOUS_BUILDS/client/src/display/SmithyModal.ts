import { Container, Graphics, Text, Sprite, Assets } from 'pixi.js';
import { BaseModal } from './BaseModal.ts';
import { clientSocket, WebPacketWriter } from '../network/clientSocket.ts';
import { OPCODES } from '../../../shared/opcodes.ts';

export interface SmithyEquipItem {
  slotIndex: number;
  name: string;
  type: string;
  iconPath: string;
  level: number;
  baseStatName: string;
  baseStatValue: number;
  upgradeCost: number;
}

export class SmithyModal extends BaseModal {
  private itemsListContainer!: Container;
  private detailContainer!: Container;
  private txtRyoBalance!: Text;
  private txtFeedback!: Text;
  private currentRyo: number = 25000;

  private equipItems: SmithyEquipItem[] = [
    { slotIndex: 0, name: 'Espada Kusanagi', type: 'Arma', iconPath: '/assets/items/item_kunai.png', level: 1, baseStatName: 'Ataque Físico', baseStatValue: 120, upgradeCost: 1500 },
    { slotIndex: 1, name: 'Protetor da Folha', type: 'Chapéu', iconPath: '/assets/items/item_headband.png', level: 1, baseStatName: 'Defesa Ninjutsu', baseStatValue: 80, upgradeCost: 1200 },
    { slotIndex: 2, name: 'Colete Chūnin', type: 'Armadura', iconPath: '/assets/items/item_vest.png', level: 1, baseStatName: 'Defesa Física', baseStatValue: 95, upgradeCost: 1300 },
    { slotIndex: 3, name: 'Manto do Fogo', type: 'Capa', iconPath: '/assets/items/item_belt.png', level: 1, baseStatName: 'Vida Máxima', baseStatValue: 350, upgradeCost: 1800 },
    { slotIndex: 4, name: 'Pergaminho de Selos', type: 'Livro', iconPath: '/assets/items/item_chakra_scroll.png', level: 1, baseStatName: 'Ninjutsu', baseStatValue: 140, upgradeCost: 2000 },
    { slotIndex: 5, name: 'Sandálias Ninja', type: 'Botas', iconPath: '/assets/items/item_sandals.png', level: 1, baseStatName: 'Agilidade / Speed', baseStatValue: 45, upgradeCost: 1100 },
  ];

  private selectedSlot: number = 0;

  constructor() {
    super({
      title: 'Forja de Konohagakure - Deus dos Artesãos (Smithy)',
      width: 820,
      height: 520,
    });
    this.initContent();
  }

  protected initContent(): void {
    // 1. Fundo do painel interior
    const innerBg = new Graphics();
    innerBg.roundRect(16, 50, 788, 452, 8);
    innerBg.fill({ color: 0x121016, alpha: 0.95 });
    innerBg.stroke({ color: 0xb45309, width: 1.5 });
    this.windowContainer.addChild(innerBg);

    // 2. Barra de saldo de Ryo no cabeçalho
    const ryoBox = new Graphics();
    ryoBox.roundRect(580, 10, 180, 28, 6);
    ryoBox.fill({ color: 0x1c1917, alpha: 0.9 });
    ryoBox.stroke({ color: 0xf59e0b, width: 1 });
    this.windowContainer.addChild(ryoBox);

    this.txtRyoBalance = new Text({
      text: `🪙 Ryo: ${this.currentRyo.toLocaleString()}`,
      style: { fontFamily: 'Arial', fontSize: 12, fontWeight: 'bold', fill: 0xfef08a },
    });
    this.txtRyoBalance.position.set(592, 16);
    this.windowContainer.addChild(this.txtRyoBalance);

    // 3. Container esquerdo: lista dos 6 equipamentos
    this.itemsListContainer = new Container();
    this.itemsListContainer.position.set(24, 60);
    this.windowContainer.addChild(this.itemsListContainer);

    // 4. Container direito: detalhes de forja e fortalecimento
    this.detailContainer = new Container();
    this.detailContainer.position.set(384, 60);
    this.windowContainer.addChild(this.detailContainer);

    // 5. Texto de feedback/sucesso inferior
    this.txtFeedback = new Text({
      text: 'Selecione um equipamento e clique em Fortalecer para aumentar seus atributos.',
      style: { fontFamily: 'Arial', fontSize: 12, fill: 0x9ca3af, align: 'center' },
    });
    this.txtFeedback.anchor.set(0.5, 0);
    this.txtFeedback.position.set(410, 474);
    this.windowContainer.addChild(this.txtFeedback);

    this.renderEquipList();
    this.renderDetail();
  }

  private renderEquipList(): void {
    this.itemsListContainer.removeChildren();

    this.equipItems.forEach((item, index) => {
      const isSelected = item.slotIndex === this.selectedSlot;
      const card = new Container();
      card.position.set(0, index * 66);
      card.eventMode = 'static';
      card.cursor = 'pointer';

      const cardBg = new Graphics();
      cardBg.roundRect(0, 0, 340, 58, 6);
      cardBg.fill({ color: isSelected ? 0x27272a : 0x18181b, alpha: 0.95 });
      cardBg.stroke({ color: isSelected ? 0xf59e0b : 0x3f3f46, width: isSelected ? 2 : 1 });
      card.addChild(cardBg);

      // Ícone do equipamento
      const tex = Assets.get(item.iconPath);
      if (tex) {
        const spr = new Sprite(tex);
        spr.width = 40;
        spr.height = 40;
        spr.position.set(9, 9);
        card.addChild(spr);
      }

      // Nome e Nível
      const txtName = new Text({
        text: `${item.name} (+${item.level})`,
        style: { fontFamily: 'Arial', fontSize: 13, fontWeight: 'bold', fill: isSelected ? 0xfef08a : 0xf4f4f5 },
      });
      txtName.position.set(56, 10);
      card.addChild(txtName);

      // Tipo e Bônus
      const txtBonus = new Text({
        text: `${item.type} | ${item.baseStatName}: +${item.baseStatValue}`,
        style: { fontFamily: 'Arial', fontSize: 11, fill: 0x10b981 },
      });
      txtBonus.position.set(56, 32);
      card.addChild(txtBonus);

      card.on('pointertap', () => {
        this.selectedSlot = item.slotIndex;
        this.renderEquipList();
        this.renderDetail();
      });

      this.itemsListContainer.addChild(card);
    });
  }

  private renderDetail(): void {
    this.detailContainer.removeChildren();

    const item = this.equipItems.find((i) => i.slotIndex === this.selectedSlot) || this.equipItems[0];
    const nextBonus = Math.floor(item.baseStatValue * 1.25);

    const box = new Graphics();
    box.roundRect(0, 0, 400, 390, 8);
    box.fill({ color: 0x18181b, alpha: 0.95 });
    box.stroke({ color: 0x52525b, width: 1 });
    this.detailContainer.addChild(box);

    // Título do Item
    const title = new Text({
      text: `${item.name} [Refino Nível +${item.level}]`,
      style: { fontFamily: 'Arial', fontSize: 15, fontWeight: 'bold', fill: 0xfbbf24 },
    });
    title.position.set(16, 16);
    this.detailContainer.addChild(title);

    // Ícone de Destaque
    const previewBox = new Graphics();
    previewBox.roundRect(16, 52, 70, 70, 8);
    previewBox.fill({ color: 0x09090b, alpha: 0.9 });
    previewBox.stroke({ color: 0xd97706, width: 1.5 });
    this.detailContainer.addChild(previewBox);

    const tex = Assets.get(item.iconPath);
    if (tex) {
      const spr = new Sprite(tex);
      spr.width = 54;
      spr.height = 54;
      spr.position.set(24, 60);
      this.detailContainer.addChild(spr);
    }

    // Tipo de Slot
    const slotInfo = new Text({
      text: `Categoria: ${item.type}\nRequisito: Nível Shinobi ${item.level * 5}`,
      style: { fontFamily: 'Arial', fontSize: 12, fill: 0xd4d4d8, lineHeight: 18 },
    });
    slotInfo.position.set(100, 64);
    this.detailContainer.addChild(slotInfo);

    // Comparador de Atributos
    const compBox = new Graphics();
    compBox.roundRect(16, 140, 368, 120, 6);
    compBox.fill({ color: 0x141218, alpha: 0.95 });
    compBox.stroke({ color: 0x3f3f46, width: 1 });
    this.detailContainer.addChild(compBox);

    const txtCompHeader = new Text({
      text: '✦ PROGRESSÃO DE ATRIBUTOS',
      style: { fontFamily: 'Arial', fontSize: 12, fontWeight: 'bold', fill: 0x38bdf8 },
    });
    txtCompHeader.position.set(28, 150);
    this.detailContainer.addChild(txtCompHeader);

    const currentStat = new Text({
      text: `Atual (+${item.level}): ${item.baseStatName} +${item.baseStatValue}`,
      style: { fontFamily: 'Arial', fontSize: 12, fill: 0xf4f4f5 },
    });
    currentStat.position.set(28, 180);
    this.detailContainer.addChild(currentStat);

    const nextStat = new Text({
      text: `Próximo (+${item.level + 1}): ${item.baseStatName} +${nextBonus}  (▲ +${nextBonus - item.baseStatValue})`,
      style: { fontFamily: 'Arial', fontSize: 12, fontWeight: 'bold', fill: 0x22c55e },
    });
    nextStat.position.set(28, 208);
    this.detailContainer.addChild(nextStat);

    const txtCost = new Text({
      text: `🪙 Custo da Forja: ${item.upgradeCost.toLocaleString()} Ryo`,
      style: { fontFamily: 'Arial', fontSize: 12, fontWeight: 'bold', fill: 0xfef08a },
    });
    txtCost.position.set(28, 234);
    this.detailContainer.addChild(txtCost);

    // Botão de Fortalecimento
    const btnEnhance = new Container();
    btnEnhance.position.set(16, 280);
    btnEnhance.eventMode = 'static';
    btnEnhance.cursor = 'pointer';

    const canAfford = this.currentRyo >= item.upgradeCost;
    const btnBg = new Graphics();
    btnBg.roundRect(0, 0, 368, 44, 8);
    btnBg.fill(canAfford ? 0xb45309 : 0x52525b);
    btnBg.stroke({ color: canAfford ? 0xf59e0b : 0x71717a, width: 1.5 });
    btnEnhance.addChild(btnBg);

    const btnText = new Text({
      text: canAfford ? '🔨 Fortalecer Equipamento' : '❌ Saldo de Ryo Insuficiente',
      style: { fontFamily: 'Arial', fontSize: 14, fontWeight: 'bold', fill: 0xffffff },
    });
    btnText.anchor.set(0.5);
    btnText.position.set(184, 22);
    btnEnhance.addChild(btnText);

    if (canAfford) {
      btnEnhance.on('pointerenter', () => {
        btnBg.clear();
        btnBg.roundRect(0, 0, 368, 44, 8);
        btnBg.fill(0xd97706);
        btnBg.stroke({ color: 0xfef08a, width: 2 });
      });
      btnEnhance.on('pointerleave', () => {
        btnBg.clear();
        btnBg.roundRect(0, 0, 368, 44, 8);
        btnBg.fill(0xb45309);
        btnBg.stroke({ color: 0xf59e0b, width: 1.5 });
      });
      btnEnhance.on('pointertap', () => {
        this.performEnhance(item);
      });
    }

    this.detailContainer.addChild(btnEnhance);
  }

  private performEnhance(item: SmithyEquipItem): void {
    if (this.currentRyo < item.upgradeCost) {
      this.txtFeedback.text = '⚠️ Você não possui Ryo suficiente para esta forja!';
      this.txtFeedback.style.fill = 0xef4444;
      return;
    }

    this.currentRyo -= item.upgradeCost;
    item.level += 1;
    item.baseStatValue = Math.floor(item.baseStatValue * 1.25);
    item.upgradeCost = Math.floor(item.upgradeCost * 1.35);

    this.txtRyoBalance.text = `🪙 Ryo: ${this.currentRyo.toLocaleString()}`;
    this.txtFeedback.text = `✨ Sucesso! ${item.name} foi aprimorado para o Nível +${item.level}!`;
    this.txtFeedback.style.fill = 0x22c55e;

    // Notifica o servidor via WebSocket com opcode oficial Joyfun
    const pw = new WebPacketWriter();
    pw.writeUnsignedInt(item.slotIndex);
    clientSocket.send(OPCODES.CS_Equip_EnhanceReq, pw);

    this.renderEquipList();
    this.renderDetail();
  }

  /**
   * Atualização com dados recebidos do servidor
   */
  public handleEnhanceResult(data: any): void {
    if (data.currency && typeof data.currency.ryo === 'number') {
      this.currentRyo = data.currency.ryo;
      this.txtRyoBalance.text = `🪙 Ryo: ${this.currentRyo.toLocaleString()}`;
    }
    if (data.slotIndex !== undefined) {
      const it = this.equipItems.find((i) => i.slotIndex === data.slotIndex);
      if (it && data.level) {
        it.level = data.level;
        this.renderEquipList();
        this.renderDetail();
      }
    }
    if (data.msg) {
      this.txtFeedback.text = data.msg;
      this.txtFeedback.style.fill = data.success ? 0x22c55e : 0xef4444;
    }
  }
}
