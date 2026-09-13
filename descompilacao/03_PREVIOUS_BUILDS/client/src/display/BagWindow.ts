import { Container, Graphics, Sprite, Text, Assets, FederatedPointerEvent } from 'pixi.js';
import { clientSocket, WebPacketWriter, WebPacketReader } from '../network/clientSocket.ts';
import { OPCODES } from '../../../shared/opcodes.ts';

export interface ItemData {
  id: number;
  character_id: number;
  slot_index: number;
  item_id: number;
  name: string;
  icon: string;
  category: number; // 1: Consumível, 2: Equipamento
  sub_category: number; // 1: Arma, 2: Cabeça, 3: Roupa, 4: Cinto, 5: Bota, 6: Anel
  count: number;
  equipped: number; // 0 ou 1
  stats_json: string;
}

export class BagWindow extends Container {
  private bgSprite: Sprite | null = null;
  private contentContainer: Container;
  private tooltipContainer: Container;
  private items: ItemData[] = [];
  private ryo: number = 0;
  private txtRyo: Text | null = null;
  private onCloseCallback?: () => void;

  public static readonly WIDTH = 385;
  public static readonly HEIGHT = 431;

  constructor(onClose?: () => void) {
    super();
    this.onCloseCallback = onClose;
    this.eventMode = 'static';
    this.zIndex = 50000;

    // Bloqueador de cliques externos (overlay transparente)
    const blocker = new Graphics();
    blocker.rect(-2000, -2000, 4000, 4000);
    blocker.fill({ color: 0x000000, alpha: 0.4 });
    blocker.eventMode = 'static';
    blocker.on('pointertap', () => this.close());
    this.addChild(blocker);

    this.contentContainer = new Container();
    this.contentContainer.eventMode = 'static';
    this.addChild(this.contentContainer);

    this.tooltipContainer = new Container();
    this.tooltipContainer.zIndex = 60000;
    this.addChild(this.tooltipContainer);

    this.setupWindow();
    this.setupNetwork();
  }

  private setupWindow(): void {
    // 1. Fundo da moldura oficial (modal_bag.png: 385x431)
    const bagTex = Assets.get('/assets/ui/modal_bag.png');
    if (bagTex) {
      this.bgSprite = new Sprite(bagTex);
      this.bgSprite.position.set(0, 0);
      this.contentContainer.addChild(this.bgSprite);
    } else {
      const fallback = new Graphics();
      fallback.roundRect(0, 0, BagWindow.WIDTH, BagWindow.HEIGHT, 10);
      fallback.fill(0x1e293b);
      fallback.stroke({ color: 0xf59e0b, width: 3 });
      this.contentContainer.addChild(fallback);
    }

    // 2. Título da Janela
    const title = new Text({
      text: 'Mochila Shinobi',
      style: {
        fill: '#fbbf24',
        fontSize: 14,
        fontWeight: 'bold',
        stroke: { color: '#000000', width: 3 },
      },
    });
    title.position.set(24, 14);
    this.contentContainer.addChild(title);

    // 3. Botão de Fechar
    const closeBtn = new Container();
    closeBtn.position.set(BagWindow.WIDTH - 36, 12);
    closeBtn.eventMode = 'static';
    closeBtn.cursor = 'pointer';

    const closeTex = Assets.get('/assets/ui/btn_close.png');
    if (closeTex) {
      const closeSprite = new Sprite(closeTex);
      closeBtn.addChild(closeSprite);
    } else {
      const closeG = new Graphics();
      closeG.circle(10, 10, 10);
      closeG.fill(0xdc2626);
      closeBtn.addChild(closeG);
    }

    closeBtn.on('pointertap', () => this.close());
    this.contentContainer.addChild(closeBtn);

    // 4. Rodapé com moedas (Ryo)
    this.txtRyo = new Text({
      text: `Ryo: 0`,
      style: {
        fill: '#ffffff',
        fontSize: 12,
        fontWeight: 'bold',
        stroke: { color: '#000000', width: 2 },
      },
    });
    this.txtRyo.position.set(24, BagWindow.HEIGHT - 28);
    this.contentContainer.addChild(this.txtRyo);
  }

  private setupNetwork(): void {
    clientSocket.on(OPCODES.SC_Backpack_InventoryNtf, (reader: WebPacketReader) => {
      try {
        const payloadStr = reader.readStringUTF();
        if (!payloadStr) return;
        const data = JSON.parse(payloadStr);
        if (data.items) {
          this.items = data.items;
        }
        if (data.currency) {
          this.ryo = data.currency.ryo || 0;
          if (this.txtRyo) this.txtRyo.text = `Ryo: ${this.ryo.toLocaleString('pt-BR')}`;
        }
        this.renderSlots();
      } catch (e) {
        console.error('[BagWindow] Erro ao processar SC_Backpack_InventoryNtf:', e);
      }
    });

    // Solicita carga inicial da mochila
    this.loadBag();
  }

  public loadBag(): void {
    const pw = new WebPacketWriter();
    clientSocket.send(OPCODES.CS_Backpack_LoadBag, pw);
  }

  public open(): void {
    this.visible = true;
    this.loadBag();
  }

  public close(): void {
    this.visible = false;
    this.tooltipContainer.removeChildren();
    if (this.onCloseCallback) this.onCloseCallback();
  }

  /**
   * Renderiza os 36 slots da grade e os itens equipados
   */
  private renderSlots(): void {
    // Remove slots anteriores (mantendo background, título e botão fechar)
    while (this.contentContainer.children.length > 4) {
      const child = this.contentContainer.children[4];
      child.destroy({ children: true });
      this.contentContainer.removeChild(child);
    }

    const slotsGrid = new Container();
    slotsGrid.position.set(24, 52);

    const cols = 6;
    const rows = 6;
    const slotSize = 46;
    const gap = 8;

    for (let r = 0; r < rows; r++) {
      for (let c = 0; c < cols; c++) {
        const slotIdx = r * cols + c;
        const slotContainer = new Container();
        slotContainer.position.set(c * (slotSize + gap), r * (slotSize + gap));
        slotContainer.eventMode = 'static';
        slotContainer.cursor = 'pointer';

        // Moldura do slot
        const slotBg = new Graphics();
        slotBg.roundRect(0, 0, slotSize, slotSize, 6);
        slotBg.fill({ color: 0x0f172a, alpha: 0.7 });
        slotBg.stroke({ color: 0x475569, width: 1.5 });
        slotContainer.addChild(slotBg);

        // Verifica se há item no slot
        const item = this.items.find((it) => it.slot_index === slotIdx && it.equipped === 0);
        if (item) {
          const itemTex = Assets.get(item.icon);
          if (itemTex) {
            const itemSprite = new Sprite(itemTex);
            itemSprite.width = 38;
            itemSprite.height = 38;
            itemSprite.position.set(4, 4);
            slotContainer.addChild(itemSprite);
          }

          // Quantidade (se > 1)
          if (item.count > 1) {
            const txtCount = new Text({
              text: `${item.count}`,
              style: {
                fill: '#ffffff',
                fontSize: 10,
                fontWeight: 'bold',
                stroke: { color: '#000000', width: 2 },
              },
            });
            txtCount.position.set(slotSize - txtCount.width - 4, slotSize - 14);
            slotContainer.addChild(txtCount);
          }

          // Interações de clique e hover
          slotContainer.on('pointerenter', () => {
            slotBg.stroke({ color: 0xf59e0b, width: 2 });
            this.showTooltip(item, slotContainer.getGlobalPosition());
          });

          slotContainer.on('pointerleave', () => {
            slotBg.stroke({ color: 0x475569, width: 1.5 });
            this.hideTooltip();
          });

          slotContainer.on('pointertap', () => {
            this.onItemClick(item);
          });
        }

        slotsGrid.addChild(slotContainer);
      }
    }

    this.contentContainer.addChild(slotsGrid);
  }

  /**
   * Tooltip detalhado com estatísticas e botões de ação
   */
  private showTooltip(item: ItemData, globalPos: { x: number; y: number }): void {
    this.tooltipContainer.removeChildren();

    const tip = new Container();
    const localPos = this.toLocal(globalPos);

    let tipX = localPos.x + 56;
    let tipY = localPos.y;
    if (tipX + 180 > BagWindow.WIDTH) {
      tipX = localPos.x - 190;
    }

    tip.position.set(tipX, tipY);

    const stats = JSON.parse(item.stats_json || '{}');
    let statLines = '';
    if (stats.atk) statLines += `\n⚔️ ATK: +${stats.atk}`;
    if (stats.def) statLines += `\n🛡️ DEF: +${stats.def}`;
    if (stats.hp) statLines += `\n❤️ HP: +${stats.hp}`;
    if (stats.spd) statLines += `\n⚡ SPD: +${stats.spd}`;
    if (stats.heal) statLines += `\n🍜 Cura: ${stats.heal} HP`;
    if (stats.exp) statLines += `\n📜 EXP: +${stats.exp}`;

    const txtDesc = new Text({
      text: `${item.name}\nTipo: ${item.category === 2 ? 'Equipamento' : 'Consumível'}${statLines}\n\n[Clique para Interagir]`,
      style: {
        fill: item.category === 2 ? '#38bdf8' : '#22c55e',
        fontSize: 11,
        fontWeight: 'bold',
        wordWrap: true,
        wordWrapWidth: 170,
        stroke: { color: '#000000', width: 2 },
      },
    });
    txtDesc.position.set(10, 8);

    const bg = new Graphics();
    bg.roundRect(0, 0, txtDesc.width + 20, txtDesc.height + 16, 8);
    bg.fill({ color: 0x090d16, alpha: 0.95 });
    bg.stroke({ color: 0xf59e0b, width: 1.5 });

    tip.addChild(bg);
    tip.addChild(txtDesc);
    this.tooltipContainer.addChild(tip);
  }

  private hideTooltip(): void {
    this.tooltipContainer.removeChildren();
  }

  /**
   * Clique no item: abre menu de ação (Equipar / Usar / Vender)
   */
  private onItemClick(item: ItemData): void {
    this.hideTooltip();

    const actionMenu = new Container();
    actionMenu.position.set(100, 160);

    const bg = new Graphics();
    bg.roundRect(0, 0, 185, 110, 8);
    bg.fill({ color: 0x0f172a, alpha: 0.95 });
    bg.stroke({ color: 0x38bdf8, width: 2 });
    actionMenu.addChild(bg);

    const title = new Text({
      text: item.name,
      style: { fill: '#fbbf24', fontSize: 12, fontWeight: 'bold' },
    });
    title.position.set(12, 10);
    actionMenu.addChild(title);

    // Botão 1: Equipar ou Usar
    const btnAction = new Container();
    btnAction.position.set(12, 36);
    btnAction.eventMode = 'static';
    btnAction.cursor = 'pointer';

    const bgBtnAction = new Graphics();
    bgBtnAction.roundRect(0, 0, 160, 28, 6);
    bgBtnAction.fill(item.category === 2 ? 0x2563eb : 0x16a34a);
    btnAction.addChild(bgBtnAction);

    const txtBtnAction = new Text({
      text: item.category === 2 ? '⚔️ Equipar' : '✨ Usar Item',
      style: { fill: '#ffffff', fontSize: 11, fontWeight: 'bold' },
    });
    txtBtnAction.position.set(10, 6);
    btnAction.addChild(txtBtnAction);

    btnAction.on('pointertap', () => {
      this.sendUseItem(item.slot_index);
      actionMenu.destroy({ children: true });
    });
    actionMenu.addChild(btnAction);

    // Botão 2: Vender por Ryo
    const btnSell = new Container();
    btnSell.position.set(12, 70);
    btnSell.eventMode = 'static';
    btnSell.cursor = 'pointer';

    const bgBtnSell = new Graphics();
    bgBtnSell.roundRect(0, 0, 160, 28, 6);
    bgBtnSell.fill(0xb91c1c);
    btnSell.addChild(bgBtnSell);

    const txtBtnSell = new Text({
      text: `💰 Vender (${item.category === 2 ? 800 : 150} Ryo)`,
      style: { fill: '#ffffff', fontSize: 11, fontWeight: 'bold' },
    });
    txtBtnSell.position.set(10, 6);
    btnSell.addChild(txtBtnSell);

    btnSell.on('pointertap', () => {
      this.sendSellItem(item.slot_index);
      actionMenu.destroy({ children: true });
    });
    actionMenu.addChild(btnSell);

    // Fecha ao clicar fora
    const dismisser = new Graphics();
    dismisser.rect(-2000, -2000, 4000, 4000);
    dismisser.fill({ color: 0x000000, alpha: 0.01 });
    dismisser.eventMode = 'static';
    dismisser.on('pointertap', () => actionMenu.destroy({ children: true }));

    this.tooltipContainer.addChild(dismisser);
    this.tooltipContainer.addChild(actionMenu);
  }

  private sendUseItem(slotIndex: number): void {
    const pw = new WebPacketWriter();
    pw.writeShort(slotIndex);
    clientSocket.send(OPCODES.CS_Backpack_UseAppliance, pw);
  }

  private sendSellItem(slotIndex: number): void {
    const pw = new WebPacketWriter();
    pw.writeShort(slotIndex);
    clientSocket.send(OPCODES.CS_Backpack_SellItem, pw);
  }

  public destroy(options?: any): void {
    clientSocket.off(OPCODES.SC_Backpack_InventoryNtf);
    super.destroy(options);
  }
}
