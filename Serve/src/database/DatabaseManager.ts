import fs from 'fs/promises';
import path from 'path';
import { ServerConfig } from '../config/index.js';

export interface HeroTemplate {
  id: number;
  name: string;
  isMain?: boolean;
  sex: number; // 1 = Male, 0 = Female
  profession: number; // 4 = Taijutsu, 1 = Ninjutsu, 2 = Genjutsu
  power: number;
  agile: number;
  intelligence: number;
  life: number;
  speed: number;
  active: number;
  normalAttack: number;
  talent: number;
}

export interface CityTemplate {
  id: number;
  name: string;
  type: number;
  start: number;
  last: number;
  icon: number;
}

export interface NpcTemplate {
  id: number;
  name: string;
  npcTitle: string;
  talk: string;
  startTime: number;
  endTime: number;
  cityid: number;
  userType: number;
  x: number;
  y: number;
}

export interface TaskTemplate {
  id: number;
  name: string;
  point: number;
  description: string;
  guideBefor: string;
  guide: string;
  guideEnd: string;
  talkBefor: string;
  talkEnd: string;
  startNpcId: number;
  finishNpcId: number;
  rewards: string;
}

export interface SkillTemplate {
  id: number;
  name: string;
  type?: number;
  desc?: string;
  needChakra?: number;
}

export class DatabaseManager {
  private static instance: DatabaseManager;

  public heroes: Map<number, HeroTemplate> = new Map();
  public cities: Map<number, CityTemplate> = new Map();
  public npcs: Map<number, NpcTemplate> = new Map();
  public npcsByCity: Map<number, NpcTemplate[]> = new Map();
  public tasks: Map<number, TaskTemplate> = new Map();
  public skills: Map<number, SkillTemplate> = new Map();
  public mainHeroes: HeroTemplate[] = [];

  private isLoaded = false;

  private constructor() {}

  public static getInstance(): DatabaseManager {
    if (!DatabaseManager.instance) {
      DatabaseManager.instance = new DatabaseManager();
    }
    return DatabaseManager.instance;
  }

  public async initialize(): Promise<void> {
    if (this.isLoaded) return;

    console.log('[DB] Carregando tabelas canônicas originais de:', ServerConfig.dataDir);

    try {
      // 1. Heróis (heroes.json)
      const heroesRaw = await fs.readFile(path.join(ServerConfig.dataDir, 'heroes.json'), 'utf-8');
      const heroesList: HeroTemplate[] = JSON.parse(heroesRaw);
      for (const h of heroesList) {
        this.heroes.set(h.id, h);
        if (h.isMain && h.id >= 11100001 && h.id <= 11100006) {
          this.mainHeroes.push(h);
        }
      }
      console.log(`[DB] ✓ Heróis carregados: ${this.heroes.size} (Protagonistas canônicos: ${this.mainHeroes.length})`);

      // 2. Cidades e mapas (cities.json)
      const citiesRaw = await fs.readFile(path.join(ServerConfig.dataDir, 'cities.json'), 'utf-8');
      const citiesList: CityTemplate[] = JSON.parse(citiesRaw);
      for (const c of citiesList) {
        this.cities.set(c.id, c);
      }
      console.log(`[DB] ✓ Cidades e mapas carregados: ${this.cities.size}`);

      // 3. NPCs (npcs.json)
      const npcsRaw = await fs.readFile(path.join(ServerConfig.dataDir, 'npcs.json'), 'utf-8');
      const npcsList: NpcTemplate[] = JSON.parse(npcsRaw);
      for (const n of npcsList) {
        this.npcs.set(n.id, n);
        let list = this.npcsByCity.get(n.cityid);
        if (!list) {
          list = [];
          this.npcsByCity.set(n.cityid, list);
        }
        list.push(n);
      }
      console.log(`[DB] ✓ NPCs indexados: ${this.npcs.size} (Total em Novice Suburb: ${this.npcsByCity.get(ServerConfig.spawnCityId)?.length || 0})`);

      // 4. Missões (tasks.json)
      try {
        const tasksRaw = await fs.readFile(path.join(ServerConfig.dataDir, 'tasks.json'), 'utf-8');
        const tasksList: TaskTemplate[] = JSON.parse(tasksRaw);
        for (const t of tasksList) {
          this.tasks.set(t.id, t);
        }
        console.log(`[DB] ✓ Missões carregadas: ${this.tasks.size}`);
      } catch (err: any) {
        console.warn(`[DB] Aviso ao ler tasks.json: ${err.message}`);
      }

      // 5. Habilidades (skills.json)
      try {
        const skillsRaw = await fs.readFile(path.join(ServerConfig.dataDir, 'skills.json'), 'utf-8');
        const skillsList: SkillTemplate[] = JSON.parse(skillsRaw);
        for (const s of skillsList) {
          this.skills.set(s.id, s);
        }
        console.log(`[DB] ✓ Habilidades/Jutsus carregados: ${this.skills.size}`);
      } catch (err: any) {
        console.warn(`[DB] Aviso ao ler skills.json: ${err.message}`);
      }

      this.isLoaded = true;
      console.log('[DB] Inicialização da base de dados original concluída com sucesso.');
    } catch (error: any) {
      console.error('[DB] Erro crítico ao carregar tabelas do banco:', error.message);
      throw error;
    }
  }

  public getHero(id: number): HeroTemplate | undefined {
    return this.heroes.get(id);
  }

  public getCity(id: number): CityTemplate | undefined {
    return this.cities.get(id);
  }

  public getNpcsByCity(cityId: number): NpcTemplate[] {
    return this.npcsByCity.get(cityId) || [];
  }

  public getNpc(id: number): NpcTemplate | undefined {
    return this.npcs.get(id);
  }

  public getTask(id: number): TaskTemplate | undefined {
    return this.tasks.get(id);
  }

  public getMainHeroes(): HeroTemplate[] {
    return this.mainHeroes;
  }
}
