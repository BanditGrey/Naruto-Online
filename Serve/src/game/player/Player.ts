import { HeroTemplate } from '../../database/DatabaseManager.js';
import { ServerConfig } from '../../config/index.js';

export interface InventoryItemData {
  guidHigh: number;
  guidLow: number;
  templateId: number;
  quantity: number;
  level: number;
  timingCategory: number;
  timingState: number;
  timingTime: number;
  expireTick: number;
  obtainType: number;
}

export interface FormationPositionData {
  heroId: number;
  pos: number; // 1..15
}

export interface MailEntryData {
  id: number;
  sender: string;
  title: string;
  content: string;
  hasGift: number;
  silver: number;
  gold: number;
  isRead: number;
}

export interface QuestProgressData {
  taskId: number;
  curProgress: number;
  totalNeeded: number;
  state: number; // 0=Não iniciada, 1=Em andamento, 2=Concluída
}

export interface PlayerData {
  userId: string;
  charId: number;
  name: string;
  profession: number; // 4: Taijutsu, 1: Ninjutsu, 2: Genjutsu
  gender: number;     // 1: Male, 0: Female
  level: number;
  exp: number;
  curHealth: number;
  maxHealth: number;
  silver: number;
  gold: number;
  coupons: number;
  militaryOrders: number; // Vigor / Stamina
  currentCityId: number;
  x: number;
  y: number;
  templateHeroId: number;
  combatPower: number;
  vipLevel: number;

  // Almas de ninja para recrutamento
  heroSouls: {
    blue: number;
    purple: number;
    gold: number;
    orange: number;
  };

  // Guilda e Atividades
  guildId: number;
  guildContribution: number;
  redeemedCodes: string[];

  // Coleções em memória
  items: InventoryItemData[];
  formation: FormationPositionData[];
  recruitedNinjas: number[];
  mails: MailEntryData[];
  quests: QuestProgressData[];
}

export class Player {
  public data: PlayerData;

  constructor(data: PlayerData) {
    this.data = data;
  }

  public static createFromTemplate(userId: string, name: string, template: HeroTemplate): Player {
    const baseHp = template.life || 2500;
    const initialCharId = Math.floor(100000 + Math.random() * 900000);

    return new Player({
      userId,
      charId: initialCharId,
      name,
      profession: template.profession,
      gender: template.sex,
      level: 1,
      exp: 0,
      curHealth: baseHp,
      maxHealth: baseHp,
      silver: 10000,
      gold: 100,
      coupons: 350,
      militaryOrders: 50,
      currentCityId: ServerConfig.spawnCityId, // Novice Suburb #23100001
      x: ServerConfig.defaultSpawnPosition.x, // 400
      y: ServerConfig.defaultSpawnPosition.y, // 382
      templateHeroId: template.id,
      combatPower: 3420,
      vipLevel: 1,

      heroSouls: {
        blue: 15,
        purple: 5,
        gold: 0,
        orange: 0
      },

      guildId: 1,
      guildContribution: 1500,
      redeemedCodes: [],

      items: [
        {
          guidHigh: 0,
          guidLow: 1,
          templateId: 1001, // Kunai de Ferro
          quantity: 25,
          level: 1,
          timingCategory: 0,
          timingState: 0,
          timingTime: 0,
          expireTick: 0,
          obtainType: 1
        },
        {
          guidHigh: 0,
          guidLow: 2,
          templateId: 2001, // Ramen Ichiraku (Recupera 20 Vigor)
          quantity: 5,
          level: 1,
          timingCategory: 0,
          timingState: 0,
          timingTime: 0,
          expireTick: 0,
          obtainType: 1
        },
        {
          guidHigh: 0,
          guidLow: 3,
          templateId: 3001, // Pergaminho de Chakra
          quantity: 2,
          level: 1,
          timingCategory: 0,
          timingState: 0,
          timingTime: 0,
          expireTick: 0,
          obtainType: 1
        },
        {
          guidHigh: 0,
          guidLow: 4,
          templateId: 4001, // Bandana de Konoha
          quantity: 1,
          level: 1,
          timingCategory: 0,
          timingState: 0,
          timingTime: 0,
          expireTick: 0,
          obtainType: 1
        },
        {
          guidHigh: 0,
          guidLow: 5,
          templateId: 4002, // Colete Shinobi
          quantity: 1,
          level: 1,
          timingCategory: 0,
          timingState: 0,
          timingTime: 0,
          expireTick: 0,
          obtainType: 1
        },
        {
          guidHigh: 0,
          guidLow: 6,
          templateId: 4003, // Sandálias Ninja
          quantity: 1,
          level: 1,
          timingCategory: 0,
          timingState: 0,
          timingTime: 0,
          expireTick: 0,
          obtainType: 1
        },
        {
          guidHigh: 0,
          guidLow: 7,
          templateId: 4004, // Anel Ninja
          quantity: 1,
          level: 1,
          timingCategory: 0,
          timingState: 0,
          timingTime: 0,
          expireTick: 0,
          obtainType: 1
        },
        {
          guidHigh: 0,
          guidLow: 8,
          templateId: 4005, // Faixa de Batalha
          quantity: 1,
          level: 1,
          timingCategory: 0,
          timingState: 0,
          timingTime: 0,
          expireTick: 0,
          obtainType: 1
        }
      ],

      formation: [
        { heroId: template.id, pos: 5 }, // Herói principal no centro do grid
        { heroId: 11100006, pos: 2 },    // Naruto no topo central
        { heroId: 11100007, pos: 3 },    // Sasuke no topo direito
        { heroId: 11100013, pos: 8 }     // Sakura na frente
      ],

      recruitedNinjas: [template.id, 11100006, 11100007, 11100013, 11100005, 11100014, 11100011],


      mails: [
        {
          id: 1,
          sender: 'Hokage Sarutobi',
          title: 'Boas-vindas a Konoha!',
          content: 'Jovem shinobi, receba esta provisão para iniciar seu treinamento na academia.',
          hasGift: 1,
          silver: 2000,
          gold: 50,
          isRead: 0
        }
      ],

      quests: [
        {
          taskId: 10001, // [Principal] Rumo à Academia Ninja
          curProgress: 0,
          totalNeeded: 1,
          state: 1
        }
      ]
    });
  }

  public updatePosition(x: number, y: number): void {
    // Delimita movimento para a área de caminhada canônica
    this.data.x = Math.max(50, Math.min(2450, x));
    this.data.y = Math.max(ServerConfig.walkableYRange.min, Math.min(ServerConfig.walkableYRange.max, y));
  }
}
