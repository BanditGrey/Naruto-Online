import { HeroTemplate } from '../../database/DatabaseManager.js';
import { ServerConfig } from '../../config/index.js';

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
  currentCityId: number;
  x: number;
  y: number;
  templateHeroId: number;
}

export class Player {
  public data: PlayerData;

  constructor(data: PlayerData) {
    this.data = data;
  }

  public static createFromTemplate(userId: string, name: string, template: HeroTemplate): Player {
    const baseHp = template.life || 2500;
    return new Player({
      userId,
      charId: Math.floor(100000 + Math.random() * 900000),
      name,
      profession: template.profession,
      gender: template.sex,
      level: 1,
      exp: 0,
      curHealth: baseHp,
      maxHealth: baseHp,
      silver: 10000,
      gold: 100,
      currentCityId: ServerConfig.spawnCityId, // Novice Suburb #23100001
      x: ServerConfig.defaultSpawnPosition.x, // 400
      y: ServerConfig.defaultSpawnPosition.y, // 382
      templateHeroId: template.id
    });
  }

  public updatePosition(x: number, y: number): void {
    // Delimita movimento para a área de caminhada canônica
    this.data.x = Math.max(50, Math.min(2450, x));
    this.data.y = Math.max(ServerConfig.walkableYRange.min, Math.min(ServerConfig.walkableYRange.max, y));
  }
}
