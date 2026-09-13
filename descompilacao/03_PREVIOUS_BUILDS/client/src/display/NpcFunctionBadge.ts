import { Container, Graphics, Text } from 'pixi.js';

export enum NpcFunctionType {
  STORY = 1,
  MADE = 2,           // Forge / Smithy (God of Craftsman)
  EXCHANGE_SHOP = 3,  // Exchange / Shop
  PUB = 4,            // Tavern / Recruiting (Tsunade)
  STONE = 5,          // Jade / Magatama (Ibiki)
  COUNTRY = 6,        // Country / Faction
  GATE = 7,           // City Gate / World Map travel
  COPY = 8,           // Transform / Avatar (Kakashi)
  SANTACLAUS = 9,     // Event
  GODEQUIP = 10,      // God Equip / Artifact (Hayate)
  MASTERROAD = 11,    // Road to Mastery (Hashirama)
  YUELAO = 12,        // Matchmaker / Marriage (Terumi Mei)
  WAREHOUSE = 13,     // Storage / Chest (Jiraiya)
}

/**
 * Badge de função e missão flutuante acima da cabeça do NPC,
 * reproduzindo o sistema canônico QuestBadge de TUIRoleNpc.as do cliente Flash.
 */
export class NpcFunctionBadge extends Container {
  private bgGraphic: Graphics;
  private iconText: Text;
  private animTime: number = 0;
  private baseOffsetY: number;

  constructor(funcType: NpcFunctionType, baseOffsetY: number = -40) {
    super();
    this.baseOffsetY = baseOffsetY;

    this.bgGraphic = new Graphics();
    this.addChild(this.bgGraphic);

    const { symbol, bgColor, borderColor, iconColor } = this.getBadgeStyle(funcType);

    // Fundo circular elegante com borda dourada/ornada
    const radius = 14;
    this.bgGraphic.circle(0, 0, radius + 2);
    this.bgGraphic.fill({ color: borderColor, alpha: 0.95 });

    this.bgGraphic.circle(0, 0, radius);
    this.bgGraphic.fill({ color: bgColor, alpha: 0.95 });

    // Brilho superior suave
    this.bgGraphic.ellipse(0, -radius / 2, radius * 0.7, radius * 0.35);
    this.bgGraphic.fill({ color: 0xffffff, alpha: 0.25 });

    // Ícone / Símbolo textual canônico
    this.iconText = new Text({
      text: symbol,
      style: {
        fontFamily: 'Segoe UI Emoji, Arial, sans-serif',
        fontSize: 14,
        fontWeight: 'bold',
        fill: iconColor,
        align: 'center',
      },
    });
    this.iconText.anchor.set(0.5, 0.5);
    this.addChild(this.iconText);

    this.y = this.baseOffsetY;
  }

  /**
   * Define cores e símbolos canônicos de acordo com o tipo de função do NPC
   */
  private getBadgeStyle(funcType: NpcFunctionType): {
    symbol: string;
    bgColor: number;
    borderColor: number;
    iconColor: number;
  } {
    switch (funcType) {
      case NpcFunctionType.PUB: // Taverna
        return { symbol: '🍺', bgColor: 0x854d0e, borderColor: 0xfacc15, iconColor: 0xffffff };
      case NpcFunctionType.MADE: // Forja do Ferreiro
        return { symbol: '🔨', bgColor: 0x991b1b, borderColor: 0xf87171, iconColor: 0xffffff };
      case NpcFunctionType.STONE: // Magatama / Jade
        return { symbol: '💎', bgColor: 0x065f46, borderColor: 0x34d399, iconColor: 0xffffff };
      case NpcFunctionType.COPY: // Transform / Avatar
        return { symbol: '🎭', bgColor: 0x4c1d95, borderColor: 0xa78bfa, iconColor: 0xffffff };
      case NpcFunctionType.GATE: // Portão da Vila
        return { symbol: '⛩️', bgColor: 0x7c2d12, borderColor: 0xfb923c, iconColor: 0xffffff };
      case NpcFunctionType.WAREHOUSE: // Armazém
        return { symbol: '📦', bgColor: 0x713f12, borderColor: 0xfde047, iconColor: 0xffffff };
      case NpcFunctionType.MASTERROAD: // Caminho do Mestre
        return { symbol: '📜', bgColor: 0x1e3a8a, borderColor: 0x60a5fa, iconColor: 0xffffff };
      case NpcFunctionType.YUELAO: // Casamento / Laços
        return { symbol: '💖', bgColor: 0x831843, borderColor: 0xf472b6, iconColor: 0xffffff };
      case NpcFunctionType.GODEQUIP: // Arena / Duelo
        return { symbol: '⚔️', bgColor: 0x881337, borderColor: 0xf43f5e, iconColor: 0xffffff };
      case NpcFunctionType.STORY: // Missão de História
      default:
        return { symbol: '❗', bgColor: 0xb45309, borderColor: 0xfef08a, iconColor: 0xfffbeb };
    }
  }

  /**
   * Atualização contínua com animação suave de flutuação (bobbing vertical)
   */
  public update(deltaSeconds: number = 0.016): void {
    this.animTime += deltaSeconds * 3.5;
    const floatOffset = Math.sin(this.animTime) * 4;
    this.y = this.baseOffsetY + floatOffset;
  }
}
