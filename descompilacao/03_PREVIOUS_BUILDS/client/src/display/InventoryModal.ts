import { Container, Graphics, Sprite, Text, Assets, FederatedPointerEvent } from 'pixi.js';
import { BaseModal } from './BaseModal';
import { clientSocket, WebPacketWriter } from '../network/clientSocket.ts';
import { OPCODES } from '../../../shared/opcodes.ts';

export interface InventoryItemData {
  id: number;
  character_id: number;
  slot_index: number;
  item_id: number;
  name: string;
  icon: string;
  category: number; // 1: Consumable, 2: Equipment
  sub_category: number; // 1: Arma, 2: Bandana, 3: Colete, 4: Cinto, 5: Sandálias, 6: Anel
  count: number;
  equipped: number; // 0: na mochila, 1: equipado
  stats_json: string;
}

export class InventoryModal extends BaseModal {
  private items: InventoryItemData[] = [];
  private selectedItem: InventoryItemData | null = null;
  private equipSlots: Map<number, Container> = new Map();
  private bagSlots: Container[] = [];
  private tooltipContainer!: Container;
  private tooltipBg!: Graphics;
  private tooltipText!: Text;

  // Rótulos de atributos
  private lblHp!: Text;
  private lblAtk!: Text;
  private lblDef!: Text;
  private lblSpd!: Text;
  private lblPower!: Text;
  private lblRyo!: Text;
  private lblGold!: Text;

  // Botões de ação
  private btnEquip!: Container;
  private btnEquipLabel!: Text;
  private btnSell!: Container;

  constructor() {
    super({
      title: 'Mochila Shinobi & Equipamentos',
      width: 860,
      height: 540,
    });
    this.initContent();
  }

  public override open(): void {
    super.open();
    clientSocket.send(OPCODES.CS_Backpack_LoadBag, new WebPacketWriter());
  }

  protected initContent(): void {
    // 1. Painel Esquerdo: Ficha do Ninja e 6 Slots de Equipamento (W: 360, H: 470)
    this.buildNinjaSheet(20, 52);

    // 2. Painel Direito: Grade de 36 slots de mochila (6x6) (W: 440, H: 470)
    this.buildBagGrid(395, 52);

    // 3. Tooltip flutuante para detalhes dos itens
    this.buildTooltip();
  }

  private buildNinjaSheet(startX: number, startY: number): void {
    const sheetBg = new Graphics();
    sheetBg.roundRect(startX, startY, 360, 465, 8);
    sheetBg.fill({ color: 0x111827, alpha: 0.9 });
    sheetBg.stroke({ color: 0x92400e, width: 2 });
    this.windowContainer.addChild(sheetBg);

    // Título do painel
    const sheetTitle = new Text({
      text: 'EQUIPAMENTO ATUAL',
      style: { fill: '#fbbf24', fontSize: 13, fontWeight: 'bold' },
    });
    sheetTitle.position.set(startX + 14, startY + 10);
    this.windowContainer.addChild(sheetTitle);

    // Retângulo central do Ninja / Silhueta
    const ninjaBox = new Graphics();
    ninjaBox.roundRect(startX + 100, startY + 40, 160, 200, 8);
    ninjaBox.fill({ color: 0x1f2937, alpha: 0.9 });
    ninjaBox.stroke({ color: 0x4b5563, width: 1.5 });
    this.windowContainer.addChild(ninjaBox);

    const bladeTex = Assets.get('/assets/ui/avatar_blade.png');
    if (bladeTex) {
      const avatarSpr = new Sprite(bladeTex);
      avatarSpr.anchor.set(0.5, 0.5);
      avatarSpr.position.set(startX + 180, startY + 140);
      avatarSpr.scale.set(0.85);
      this.windowContainer.addChild(avatarSpr);
    }

    // 6 Slots canônicos de equipamento posicionados em volta do ninja:
    // Esquerda: Arma (1), Bandana (2), Colete (3)
    // Direita: Cinto (4), Sandálias (5), Anel/Amuleto (6)
    const slotConfigs = [
      { subCat: 1, label: 'Arma', x: startX + 24, y: startY + 45 },
      { subCat: 2, label: 'Bandana', x: startX + 24, y: startY + 115 },
      { subCat: 3, label: 'Colete', x: startX + 24, y: startY + 185 },
      { subCat: 4, label: 'Cinto', x: startX + 280, y: startY + 45 },
      { subCat: 5, label: 'Calçado', x: startX + 280, y: startY + 115 },
      { subCat: 6, label: 'Anel', x: startX + 280, y: startY + 185 },
    ];

    for (const cfg of slotConfigs) {
      const slotContainer = this.createEquipSlotView(cfg.subCat, cfg.label, cfg.x, cfg.y);
      this.equipSlots.set(cfg.subCat, slotContainer);
      this.windowContainer.addChild(slotContainer);
    }

    // Painel inferior de atributos consolidados (Y: startY + 255)
    const statsBox = new Graphics();
    statsBox.roundRect(startX + 14, startY + 255, 332, 195, 6);
    statsBox.fill({ color: 0x0f172a, alpha: 0.95 });
    statsBox.stroke({ color: 0x334155, width: 1 });
    this.windowContainer.addChild(statsBox);

    const statHeader = new Text({
      text: 'ATRIBUTOS COMBINADOS',
      style: { fill: '#38bdf8', fontSize: 12, fontWeight: 'bold' },
    });
    statHeader.position.set(startX + 24, startY + 264);
    this.windowContainer.addChild(statHeader);

    this.lblHp = this.addStatRow('Vida (HP):', '1.800', startX + 24, startY + 288, 0xef4444);
    this.lblAtk = this.addStatRow('Ataque:', '350', startX + 24, startY + 312, 0xf97316);
    this.lblDef = this.addStatRow('Defesa:', '220', startX + 24, startY + 336, 0x3b82f6);
    this.lblSpd = this.addStatRow('Velocidade:', '200', startX + 24, startY + 360, 0x10b981);

    // Poder de Luta Total
    const powerBg = new Graphics();
    powerBg.roundRect(startX + 24, startY + 392, 312, 42, 6);
    powerBg.fill({ color: 0x451a03, alpha: 0.9 });
    powerBg.stroke({ color: 0xf59e0b, width: 1.5 });
    this.windowContainer.addChild(powerBg);

    const pwrTitle = new Text({
      text: 'PODER DE LUTA TOTAL',
      style: { fill: '#fbbf24', fontSize: 11, fontWeight: 'bold' },
    });
    pwrTitle.position.set(startX + 36, startY + 398);
    this.windowContainer.addChild(pwrTitle);

    this.lblPower = new Text({
      text: '2.450',
      style: {
        fill: '#fef08a',
        fontSize: 16,
        fontWeight: 'bold',
        stroke: { color: '#000000', width: 2 },
      },
    });
    this.lblPower.position.set(startX + 36, startY + 412);
    this.windowContainer.addChild(this.lblPower);
  }

  private addStatRow(name: string, val: string, x: number, y: number, color: number): Text {
    const lblName = new Text({
      text: name,
      style: { fill: '#94a3b8', fontSize: 12 },
    });
    lblName.position.set(x, y);
    this.windowContainer.addChild(lblName);

    const lblVal = new Text({
      text: val,
      style: { fill: color, fontSize: 12, fontWeight: 'bold' },
    });
    lblVal.anchor.set(1, 0);
    lblVal.position.set(x + 310, y);
    this.windowContainer.addChild(lblVal);
    return lblVal;
  }

  private createEquipSlotView(subCat: number, label: string, x: number, y: number): Container {
    const slot = new Container();
    slot.position.set(x, y);
    slot.eventMode = 'static';
    slot.cursor = 'pointer';

    const slotBg = new Graphics();
    slotBg.roundRect(0, 0, 54, 54, 6);
    slotBg.fill({ color: 0x18181b, alpha: 0.9 });
    slotBg.stroke({ color: 0xd97706, width: 2 });
    slot.addChild(slotBg);

    const tag = new Text({
      text: label,
      style: { fill: '#71717a', fontSize: 9, fontWeight: 'bold' },
    });
    tag.anchor.set(0.5, 0.5);
    tag.position.set(27, 27);
    slot.addChild(tag);

    const itemIcon = new Sprite();
    itemIcon.width = 46;
    itemIcon.height = 46;
    itemIcon.position.set(4, 4);
    itemIcon.visible = false;
    slot.addChild(itemIcon);

    slot.on('pointertap', () => {
      const equippedItem = this.items.find((it) => it.equipped === 1 && it.sub_category === subCat);
      if (equippedItem) {
        this.selectItem(equippedItem);
      }
    });

    return slot;
  }

  private buildBagGrid(startX: number, startY: number): void {
    const bagBg = new Graphics();
    bagBg.roundRect(startX, startY, 440, 465, 8);
    bagBg.fill({ color: 0x111827, alpha: 0.9 });
    bagBg.stroke({ color: 0x92400e, width: 2 });
    this.windowContainer.addChild(bagBg);

    const bagTitle = new Text({
      text: 'MOCHILA (36 SLOTS)',
      style: { fill: '#fbbf24', fontSize: 13, fontWeight: 'bold' },
    });
    bagTitle.position.set(startX + 14, startY + 10);
    this.windowContainer.addChild(bagTitle);

    // Grade 6x6 (36 slots)
    const slotSize = 58;
    const gap = 10;
    const gridStartX = startX + 18;
    const gridStartY = startY + 38;

    this.bagSlots = [];
    for (let i = 0; i < 36; i++) {
      const row = Math.floor(i / 6);
      const col = i % 6;
      const x = gridStartX + col * (slotSize + gap);
      const y = gridStartY + row * (slotSize + gap);

      const slot = new Container();
      slot.position.set(x, y);
      slot.eventMode = 'static';
      slot.cursor = 'pointer';

      const bg = new Graphics();
      bg.roundRect(0, 0, slotSize, slotSize, 6);
      bg.fill({ color: 0x1f2937, alpha: 0.9 });
      bg.stroke({ color: 0x374151, width: 1.5 });
      slot.addChild(bg);

      const iconSpr = new Sprite();
      iconSpr.width = 50;
      iconSpr.height = 50;
      iconSpr.position.set(4, 4);
      iconSpr.visible = false;
      slot.addChild(iconSpr);

      const countBadge = new Text({
        text: '',
        style: {
          fill: '#ffffff',
          fontSize: 10,
          fontWeight: 'bold',
          stroke: { color: '#000000', width: 2 },
        },
      });
      countBadge.anchor.set(1, 1);
      countBadge.position.set(slotSize - 4, slotSize - 2);
      slot.addChild(countBadge);

      const idx = i;
      slot.on('pointerenter', (e) => {
        const item = this.items.find((it) => it.equipped === 0 && it.slot_index === idx);
        if (item) {
          this.showTooltip(item, e.global.x, e.global.y);
        }
      });
      slot.on('pointerleave', () => {
        this.hideTooltip();
      });
      slot.on('pointertap', () => {
        const item = this.items.find((it) => it.equipped === 0 && it.slot_index === idx);
        if (item) {
          this.selectItem(item);
        }
      });

      this.windowContainer.addChild(slot);
      this.bagSlots.push(slot);
    }

    // Rodapé da mochila: Moedas e Botões de Ação
    const footerY = startY + 418;

    // Ryōs e Ouro
    this.lblRyo = new Text({
      text: '🪙 Ryōs: 15.000',
      style: { fill: '#fbbf24', fontSize: 12, fontWeight: 'bold' },
    });
    this.lblRyo.position.set(startX + 18, footerY + 8);
    this.windowContainer.addChild(this.lblRyo);

    this.lblGold = new Text({
      text: '💎 Ouro: 850',
      style: { fill: '#38bdf8', fontSize: 12, fontWeight: 'bold' },
    });
    this.lblGold.position.set(startX + 150, footerY + 8);
    this.windowContainer.addChild(this.lblGold);

    // Botão Equipar / Usar
    this.btnEquip = this.createFooterButton('Equipar / Usar', 0x15803d, startX + 250, footerY, () => {
      if (this.selectedItem) {
        this.dispatchUseItem(this.selectedItem.slot_index);
      }
    });
    this.btnEquipLabel = this.btnEquip.children[1] as Text;
    this.windowContainer.addChild(this.btnEquip);

    // Botão Vender
    this.btnSell = this.createFooterButton('Vender', 0xb91c1c, startX + 355, footerY, () => {
      if (this.selectedItem && this.selectedItem.equipped === 0) {
        this.dispatchSellItem(this.selectedItem.slot_index);
      }
    });
    this.windowContainer.addChild(this.btnSell);
  }

  private createFooterButton(label: string, color: number, x: number, y: number, onClick: () => void): Container {
    const btn = new Container();
    btn.position.set(x, y);
    btn.eventMode = 'static';
    btn.cursor = 'pointer';

    const bg = new Graphics();
    bg.roundRect(0, 0, 95, 32, 6);
    bg.fill({ color, alpha: 0.9 });
    bg.stroke({ color: 0xfef08a, width: 1.5 });
    btn.addChild(bg);

    const txt = new Text({
      text: label,
      style: { fill: '#ffffff', fontSize: 11, fontWeight: 'bold' },
    });
    txt.anchor.set(0.5, 0.5);
    txt.position.set(47, 16);
    btn.addChild(txt);

    btn.on('pointertap', onClick);
    return btn;
  }

  private buildTooltip(): void {
    this.tooltipContainer = new Container();
    this.tooltipContainer.visible = false;
    this.tooltipContainer.zIndex = 100000;

    this.tooltipBg = new Graphics();
    this.tooltipContainer.addChild(this.tooltipBg);

    this.tooltipText = new Text({
      text: '',
      style: {
        fill: '#f8fafc',
        fontSize: 11,
        lineHeight: 18,
        wordWrap: true,
        wordWrapWidth: 180,
      },
    });
    this.tooltipText.position.set(10, 8);
    this.tooltipContainer.addChild(this.tooltipText);

    this.addChild(this.tooltipContainer);
  }

  private showTooltip(item: InventoryItemData, gx: number, gy: number): void {
    let statsDesc = '';
    try {
      const stats = JSON.parse(item.stats_json || '{}');
      if (stats.atk) statsDesc += `\n⚔️ Ataque: +${stats.atk}`;
      if (stats.def) statsDesc += `\n🛡️ Defesa: +${stats.def}`;
      if (stats.hp) statsDesc += `\n❤️ Vida: +${stats.hp}`;
      if (stats.spd) statsDesc += `\n⚡ Velocidade: +${stats.spd}`;
      if (stats.heal) statsDesc += `\n🍜 Cura: +${stats.heal} HP`;
      if (stats.exp) statsDesc += `\n📜 EXP: +${stats.exp} pts`;
    } catch (e) {}

    const typeStr = item.category === 2 ? 'Equipamento' : 'Consumível';
    this.tooltipText.text = `${item.name}\n[${typeStr}]${statsDesc}`;

    const w = this.tooltipText.width + 20;
    const h = this.tooltipText.height + 16;

    this.tooltipBg.clear();
    this.tooltipBg.roundRect(0, 0, w, h, 6);
    this.tooltipBg.fill({ color: 0x0f172a, alpha: 0.95 });
    this.tooltipBg.stroke({ color: 0xf59e0b, width: 1.5 });

    const localPos = this.toLocal({ x: gx, y: gy });
    this.tooltipContainer.position.set(localPos.x + 12, localPos.y - h / 2);
    this.tooltipContainer.visible = true;
  }

  private hideTooltip(): void {
    this.tooltipContainer.visible = false;
  }

  private selectItem(item: InventoryItemData): void {
    this.selectedItem = item;
    if (this.btnEquipLabel) {
      if (item.category === 1) {
        this.btnEquipLabel.text = 'Usar';
      } else if (item.equipped === 1) {
        this.btnEquipLabel.text = 'Desequipar';
      } else {
        this.btnEquipLabel.text = 'Equipar';
      }
    }
  }

  public updateInventory(items: InventoryItemData[], currency?: { ryo: number; gold: number }): void {
    this.items = items;

    // 1. Atualiza 6 Slots de Equipamento
    for (let subCat = 1; subCat <= 6; subCat++) {
      const slotView = this.equipSlots.get(subCat);
      if (!slotView) continue;
      const iconSpr = slotView.children[2] as Sprite;
      const equippedItem = items.find((it) => it.equipped === 1 && it.sub_category === subCat);

      if (equippedItem && equippedItem.icon) {
        const tex = Assets.get(equippedItem.icon);
        if (tex) {
          iconSpr.texture = tex;
          iconSpr.visible = true;
        } else {
          iconSpr.visible = false;
        }
      } else {
        iconSpr.visible = false;
      }
    }

    // 2. Atualiza 36 slots de mochila
    for (let i = 0; i < 36; i++) {
      const slotView = this.bagSlots[i];
      if (!slotView) continue;
      const iconSpr = slotView.children[1] as Sprite;
      const badge = slotView.children[2] as Text;

      const itemInSlot = items.find((it) => it.equipped === 0 && it.slot_index === i);
      if (itemInSlot && itemInSlot.icon) {
        const tex = Assets.get(itemInSlot.icon);
        if (tex) {
          iconSpr.texture = tex;
          iconSpr.visible = true;
        } else {
          iconSpr.visible = false;
        }
        badge.text = itemInSlot.count > 1 ? `${itemInSlot.count}` : '';
      } else {
        iconSpr.visible = false;
        badge.text = '';
      }
    }

    // 3. Atualiza Moedas
    if (currency) {
      if (this.lblRyo) this.lblRyo.text = `🪙 Ryōs: ${currency.ryo.toLocaleString()}`;
      if (this.lblGold) this.lblGold.text = `💎 Ouro: ${currency.gold.toLocaleString()}`;
    }

    // 4. Recalcula Atributos Totais
    this.recalculateStats();
  }

  private recalculateStats(): void {
    let bonusHp = 0;
    let bonusAtk = 0;
    let bonusDef = 0;
    let bonusSpd = 0;

    for (const it of this.items) {
      if (it.equipped === 1) {
        try {
          const stats = JSON.parse(it.stats_json || '{}');
          if (stats.hp) bonusHp += stats.hp;
          if (stats.atk) bonusAtk += stats.atk;
          if (stats.def) bonusDef += stats.def;
          if (stats.spd) bonusSpd += stats.spd;
        } catch (e) {}
      }
    }

    const totalHp = 1800 + bonusHp;
    const totalAtk = 350 + bonusAtk;
    const totalDef = 220 + bonusDef;
    const totalSpd = 200 + bonusSpd;
    const totalPower = Math.round(totalHp * 0.2 + totalAtk * 2.0 + totalDef * 1.5 + totalSpd * 3.0);

    if (this.lblHp) this.lblHp.text = `${totalHp.toLocaleString()} (+${bonusHp})`;
    if (this.lblAtk) this.lblAtk.text = `${totalAtk.toLocaleString()} (+${bonusAtk})`;
    if (this.lblDef) this.lblDef.text = `${totalDef.toLocaleString()} (+${bonusDef})`;
    if (this.lblSpd) this.lblSpd.text = `${totalSpd.toLocaleString()} (+${bonusSpd})`;
    if (this.lblPower) this.lblPower.text = `${totalPower.toLocaleString()}`;
  }

  private dispatchUseItem(slotIndex: number): void {
    const pw = new WebPacketWriter();
    pw.writeShort(slotIndex);
    clientSocket.send(OPCODES.CS_Backpack_UseAppliance, pw);
  }

  private dispatchSellItem(slotIndex: number): void {
    const pw = new WebPacketWriter();
    pw.writeShort(slotIndex);
    clientSocket.send(OPCODES.CS_Backpack_SellItem, pw);
  }
}

