import { DatabaseSync } from "node:sqlite";
import * as path from "node:path";
import * as fs from "node:fs";

export interface AccountRecord {
  id: number;
  user_id: string;
  token: string;
  created_at: string;
}

export interface CharacterRecord {
  id: number;
  account_id: number;
  name: string;
  profession: number;
  gender: number;
  level: number;
  created_at: string;
}

export interface ItemRecord {
  id: number;
  character_id: number;
  slot_index: number;
  item_id: number;
  name: string;
  icon: string;
  category: number; // 1: Consumable, 2: Equipment
  sub_category: number; // 1: Weapon, 2: Headgear, 3: Clothing, 4: Cloak, 5: Shoe, 6: Sash/Ring
  count: number;
  equipped: number; // 0: na mochila, 1: equipado no ninja
  stats_json: string;
}

export interface NinjaMemberRecord {
  id: number;
  character_id: number;
  hero_id: number;
  name: string;
  profession: number; // 1: Ninjutsu, 3: Genjutsu, 4: Taijutsu
  level: number;
  formation_pos: number; // 1 a 9 (0 = reserva / fora da grade)
  avatar_key: string;
  quality: number; // 2: Verde, 3: Azul, 4: Roxo, 5: Ouro
  hp: number;
  atk: number;
  def: number;
  spd: number;
}

export interface CharacterCurrencyRecord {
  character_id: number;
  ryo: number;
  gold: number;
  coupons: number;
  ninja_souls: number;
  campaign_stage: number;
}

export class GameDatabase {
  private db: DatabaseSync;

  constructor(dbPath?: string) {
    if (!dbPath) {
      const dbDir = path.resolve(process.cwd(), "database");
      if (!fs.existsSync(dbDir)) {
        fs.mkdirSync(dbDir, { recursive: true });
      }
      dbPath = path.join(dbDir, "game.sqlite");
    }

    this.db = new DatabaseSync(dbPath);
    this.initializeTables();
  }

  private initializeTables(): void {
    // 1. Tabela de contas
    this.db.exec(`
      CREATE TABLE IF NOT EXISTS accounts (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id TEXT UNIQUE NOT NULL,
        token TEXT,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP
      );
    `);

    // 2. Tabela de personagens
    this.db.exec(`
      CREATE TABLE IF NOT EXISTS characters (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        account_id INTEGER NOT NULL,
        name TEXT UNIQUE NOT NULL,
        profession INTEGER NOT NULL,
        gender INTEGER NOT NULL,
        level INTEGER DEFAULT 1,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (account_id) REFERENCES accounts(id) ON DELETE CASCADE
      );
    `);

    // 3. Tabela de Inventário (36 slots + Equipamentos)
    this.db.exec(`
      CREATE TABLE IF NOT EXISTS inventory (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        character_id INTEGER NOT NULL,
        slot_index INTEGER NOT NULL,
        item_id INTEGER NOT NULL,
        name TEXT NOT NULL,
        icon TEXT NOT NULL,
        category INTEGER NOT NULL,
        sub_category INTEGER NOT NULL,
        count INTEGER NOT NULL DEFAULT 1,
        equipped INTEGER NOT NULL DEFAULT 0,
        stats_json TEXT NOT NULL DEFAULT '{}',
        FOREIGN KEY (character_id) REFERENCES characters(id) ON DELETE CASCADE
      );
    `);

    // 4. Tabela de Ninjas Recrutados e Formação Tática
    this.db.exec(`
      CREATE TABLE IF NOT EXISTS character_team (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        character_id INTEGER NOT NULL,
        hero_id INTEGER NOT NULL,
        name TEXT NOT NULL,
        profession INTEGER NOT NULL,
        level INTEGER NOT NULL DEFAULT 1,
        formation_pos INTEGER NOT NULL DEFAULT 0,
        avatar_key TEXT NOT NULL,
        quality INTEGER NOT NULL DEFAULT 3,
        hp INTEGER NOT NULL DEFAULT 1500,
        atk INTEGER NOT NULL DEFAULT 320,
        def INTEGER NOT NULL DEFAULT 210,
        spd INTEGER NOT NULL DEFAULT 180,
        FOREIGN KEY (character_id) REFERENCES characters(id) ON DELETE CASCADE
      );
    `);

    // 5. Tabela de Moedas, Recursos e Progresso de Campanha
    this.db.exec(`
      CREATE TABLE IF NOT EXISTS character_currency (
        character_id INTEGER PRIMARY KEY,
        ryo INTEGER NOT NULL DEFAULT 15000,
        gold INTEGER NOT NULL DEFAULT 850,
        coupons INTEGER NOT NULL DEFAULT 300,
        ninja_souls INTEGER NOT NULL DEFAULT 120,
        campaign_stage INTEGER NOT NULL DEFAULT 1,
        FOREIGN KEY (character_id) REFERENCES characters(id) ON DELETE CASCADE
      );
    `);

    // Índices para busca rápida
    this.db.exec(`
      CREATE INDEX IF NOT EXISTS idx_accounts_user_id ON accounts(user_id);
      CREATE INDEX IF NOT EXISTS idx_characters_account_id ON characters(account_id);
      CREATE INDEX IF NOT EXISTS idx_characters_name ON characters(name);
      CREATE INDEX IF NOT EXISTS idx_inventory_char ON inventory(character_id);
      CREATE INDEX IF NOT EXISTS idx_team_char ON character_team(character_id);
    `);
  }

  /**
   * Busca uma conta pelo user_id ou insere uma nova conta
   */
  public getOrCreateAccount(userId: string, token: string = ""): AccountRecord {
    const findStmt = this.db.prepare("SELECT * FROM accounts WHERE user_id = ?");
    let account = findStmt.get(userId) as AccountRecord | undefined;

    if (!account) {
      const insertStmt = this.db.prepare(
        "INSERT INTO accounts (user_id, token) VALUES (?, ?)"
      );
      const res = insertStmt.run(userId, token);
      const newId = Number(res.lastInsertRowid);

      account = {
        id: newId,
        user_id: userId,
        token: token,
        created_at: new Date().toISOString(),
      };
    } else if (token && account.token !== token) {
      // Atualiza token se mudou
      const updateStmt = this.db.prepare("UPDATE accounts SET token = ? WHERE id = ?");
      updateStmt.run(token, account.id);
      account.token = token;
    }

    return account;
  }

  /**
   * Busca o personagem associado a uma conta
   */
  public getCharacterByAccountId(accountId: number): CharacterRecord | null {
    const stmt = this.db.prepare(
      "SELECT * FROM characters WHERE account_id = ? ORDER BY id ASC LIMIT 1"
    );
    const row = stmt.get(accountId) as CharacterRecord | undefined;
    return row ?? null;
  }

  /**
   * Busca personagem pelo nome
   */
  public getCharacterByName(name: string): CharacterRecord | null {
    const stmt = this.db.prepare("SELECT * FROM characters WHERE name = ?");
    const row = stmt.get(name) as CharacterRecord | undefined;
    return row ?? null;
  }

  /**
   * Cria um novo personagem vinculado à conta
   */
  public createCharacter(
    accountId: number,
    name: string,
    profession: number,
    gender: number
  ): CharacterRecord {
    const insertStmt = this.db.prepare(
      "INSERT INTO characters (account_id, name, profession, gender, level) VALUES (?, ?, ?, ?, 1)"
    );
    const res = insertStmt.run(accountId, name, profession, gender);
    const newId = Number(res.lastInsertRowid);

    const charRecord: CharacterRecord = {
      id: newId,
      account_id: accountId,
      name,
      profession,
      gender,
      level: 1,
      created_at: new Date().toISOString(),
    };

    // Inicializa kits canônicos padrão para o novo personagem
    this.ensureCharacterDefaults(newId, name, profession, gender);

    return charRecord;
  }

  /**
   * Garante a inicialização canônica do personagem se dados estiverem ausentes
   */
  public ensureCharacterDefaults(
    charId: number,
    name: string,
    profession: number,
    gender: number
  ): void {
    // 1. Inicializar Moedas e Recursos
    const currCheck = this.db.prepare("SELECT character_id FROM character_currency WHERE character_id = ?").get(charId);
    if (!currCheck) {
      this.db.prepare(`
        INSERT INTO character_currency (character_id, ryo, gold, coupons, ninja_souls, campaign_stage)
        VALUES (?, 15000, 850, 300, 120, 1)
      `).run(charId);
    }

    // 2. Inicializar Equipe Ninja (Protagonista posicionado em Vanguarda/Centro - Slot 2)
    const teamCount = (this.db.prepare("SELECT COUNT(*) as count FROM character_team WHERE character_id = ?").get(charId) as any)?.count || 0;
    if (teamCount === 0) {
      this.db.prepare(`
        INSERT INTO character_team (character_id, hero_id, name, profession, level, formation_pos, avatar_key, quality, hp, atk, def, spd)
        VALUES (?, ?, ?, ?, 1, 2, 'protagonist', 4, 1800, 350, 220, 200)
      `).run(charId, 1000 + charId, name, profession);
    }

    // 3. Inicializar Mochila com Starter Kit de Genin (Armas, Equipamentos e Consumíveis)
    const invCount = (this.db.prepare("SELECT COUNT(*) as count FROM inventory WHERE character_id = ?").get(charId) as any)?.count || 0;
    if (invCount === 0) {
      const starterKit = [
        { slot: 0, itemId: 101, name: 'Kunai de Aço', icon: '/assets/items/item_kunai.png', cat: 2, subCat: 1, count: 1, equipped: 1, stats: { atk: 45 } },
        { slot: 1, itemId: 102, name: 'Bandana de Konoha', icon: '/assets/items/item_headband.png', cat: 2, subCat: 2, count: 1, equipped: 1, stats: { def: 30, hp: 150 } },
        { slot: 2, itemId: 103, name: 'Colete Shinobi da Folha', icon: '/assets/items/item_vest.png', cat: 2, subCat: 3, count: 1, equipped: 1, stats: { def: 55, hp: 300 } },
        { slot: 3, itemId: 104, name: 'Cinto de Couro Ninja', icon: '/assets/items/item_belt.png', cat: 2, subCat: 4, count: 1, equipped: 1, stats: { def: 25, hp: 120 } },
        { slot: 4, itemId: 105, name: 'Sandálias Ninja', icon: '/assets/items/item_sandals.png', cat: 2, subCat: 5, count: 1, equipped: 1, stats: { spd: 15 } },
        { slot: 5, itemId: 106, name: 'Anel de Chakra Concentrado', icon: '/assets/items/item_ring.png', cat: 2, subCat: 6, count: 1, equipped: 1, stats: { atk: 50, hp: 100 } },
        { slot: 6, itemId: 201, name: 'Tigela de Ichiraku Ramen', icon: '/assets/items/item_ramen_bowl.png', cat: 1, subCat: 0, count: 5, equipped: 0, stats: { heal: 500 } },
        { slot: 7, itemId: 202, name: 'Pergaminho Secreto de Chakra', icon: '/assets/items/item_chakra_scroll.png', cat: 1, subCat: 0, count: 3, equipped: 0, stats: { exp: 1000 } }
      ];

      const insertItem = this.db.prepare(`
        INSERT INTO inventory (character_id, slot_index, item_id, name, icon, category, sub_category, count, equipped, stats_json)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
      `);

      for (const it of starterKit) {
        insertItem.run(charId, it.slot, it.itemId, it.name, it.icon, it.cat, it.subCat, it.count, it.equipped, JSON.stringify(it.stats));
      }
    }
  }

  /**
   * Retorna os itens da mochila e equipamentos de um personagem
   */
  public getInventory(charId: number): ItemRecord[] {
    const stmt = this.db.prepare("SELECT * FROM inventory WHERE character_id = ? ORDER BY slot_index ASC");
    return stmt.all(charId) as unknown as ItemRecord[];
  }

  /**
   * Equipa, desequipa ou consome um item da mochila
   */
  public useOrEquipItem(charId: number, slotIndex: number): { success: boolean; message: string; items: ItemRecord[] } {
    const item = this.db.prepare("SELECT * FROM inventory WHERE character_id = ? AND slot_index = ?").get(charId, slotIndex) as ItemRecord | undefined;
    if (!item) {
      return { success: false, message: 'Item não encontrado no slot', items: this.getInventory(charId) };
    }

    if (item.category === 1) {
      // Consumível (Ramen ou Pergaminho)
      if (item.count > 1) {
        this.db.prepare("UPDATE inventory SET count = count - 1 WHERE id = ?").run(item.id);
      } else {
        this.db.prepare("DELETE FROM inventory WHERE id = ?").run(item.id);
      }
      return { success: true, message: `Você usou ${item.name}!`, items: this.getInventory(charId) };
    } else if (item.category === 2) {
      // Equipamento (Alterna entre equipado e desequipado)
      const newEquipStatus = item.equipped === 1 ? 0 : 1;
      // Se for equipar, desequipa outro equipamento da mesma sub_categoria
      if (newEquipStatus === 1) {
        this.db.prepare("UPDATE inventory SET equipped = 0 WHERE character_id = ? AND sub_category = ?").run(charId, item.sub_category);
      }
      this.db.prepare("UPDATE inventory SET equipped = ? WHERE id = ?").run(newEquipStatus, item.id);
      const actionMsg = newEquipStatus === 1 ? `${item.name} equipado com sucesso!` : `${item.name} desequipado para a mochila.`;
      return { success: true, message: actionMsg, items: this.getInventory(charId) };
    }

    return { success: true, message: 'Ação executada', items: this.getInventory(charId) };
  }

  /**
   * Vende item da mochila por Ryo
   */
  public sellItem(charId: number, slotIndex: number): { success: boolean; ryoGained: number; items: ItemRecord[]; currency: CharacterCurrencyRecord } {
    const item = this.db.prepare("SELECT * FROM inventory WHERE character_id = ? AND slot_index = ?").get(charId, slotIndex) as ItemRecord | undefined;
    if (!item) {
      return { success: false, ryoGained: 0, items: this.getInventory(charId), currency: this.getCurrency(charId) };
    }

    const pricePerUnit = item.category === 2 ? 800 : 150;
    const ryoGained = pricePerUnit * item.count;

    this.db.prepare("DELETE FROM inventory WHERE id = ?").run(item.id);
    this.updateCurrency(charId, { ryo: this.getCurrency(charId).ryo + ryoGained });

    return {
      success: true,
      ryoGained,
      items: this.getInventory(charId),
      currency: this.getCurrency(charId)
    };
  }

  /**
   * Retorna os shinobis da equipe do jogador
   */
  public getTeam(charId: number): NinjaMemberRecord[] {
    const stmt = this.db.prepare("SELECT * FROM character_team WHERE character_id = ? ORDER BY id ASC");
    return stmt.all(charId) as unknown as NinjaMemberRecord[];
  }

  /**
   * Atualiza a posição de batalha (1 a 9) na formação tática
   */
  public updateFormationPos(charId: number, heroId: number, newPos: number): NinjaMemberRecord[] {
    // Se outro ninja já estiver nessa posição nova (e newPos > 0), troca com ele
    if (newPos > 0) {
      const currentAtPos = this.db.prepare("SELECT hero_id FROM character_team WHERE character_id = ? AND formation_pos = ?").get(charId, newPos) as any;
      if (currentAtPos && currentAtPos.hero_id !== heroId) {
        const myCurrent = this.db.prepare("SELECT formation_pos FROM character_team WHERE character_id = ? AND hero_id = ?").get(charId, heroId) as any;
        const myOldPos = myCurrent ? myCurrent.formation_pos : 0;
        this.db.prepare("UPDATE character_team SET formation_pos = ? WHERE character_id = ? AND hero_id = ?").run(myOldPos, charId, currentAtPos.hero_id);
      }
    }
    this.db.prepare("UPDATE character_team SET formation_pos = ? WHERE character_id = ? AND hero_id = ?").run(newPos, charId, heroId);
    return this.getTeam(charId);
  }

  /**
   * Recruta novo ninja na Taverna usando Almas Ninjas
   */
  public recruitNinja(charId: number, heroId: number): { success: boolean; message: string; ninja?: NinjaMemberRecord; currency: CharacterCurrencyRecord; team: NinjaMemberRecord[] } {
    const curr = this.getCurrency(charId);
    const existing = this.db.prepare("SELECT id FROM character_team WHERE character_id = ? AND hero_id = ?").get(charId, heroId);
    if (existing) {
      return { success: false, message: 'Este ninja já faz parte da sua equipe!', currency: curr, team: this.getTeam(charId) };
    }

    const TAVERN_NINJAS: Record<number, { name: string; profession: number; cost: number; avatar: string; quality: number; hp: number; atk: number; def: number; spd: number }> = {
      101: { name: 'Naruto Uzumaki', profession: 4, cost: 50, avatar: 'naruto', quality: 3, hp: 2200, atk: 380, def: 260, spd: 190 },
      102: { name: 'Sasuke Uchiha', profession: 1, cost: 80, avatar: 'sasuke', quality: 4, hp: 1850, atk: 460, def: 210, spd: 230 },
      103: { name: 'Sakura Haruno', profession: 3, cost: 40, avatar: 'sakura', quality: 3, hp: 1600, atk: 310, def: 240, spd: 200 },
      104: { name: 'Kakashi Hatake', profession: 1, cost: 150, avatar: 'kakashi', quality: 5, hp: 3200, atk: 620, def: 390, spd: 280 },
    };

    const target = TAVERN_NINJAS[heroId];
    if (!target) {
      return { success: false, message: 'Ninja inválido para recrutamento.', currency: curr, team: this.getTeam(charId) };
    }

    if (curr.ninja_souls < target.cost) {
      return { success: false, message: `Almas Ninjas insuficientes! Necessário: ${target.cost}, Atual: ${curr.ninja_souls}`, currency: curr, team: this.getTeam(charId) };
    }

    // Deduz almas
    this.updateCurrency(charId, { ninja_souls: curr.ninja_souls - target.cost });

    // Insere na equipe
    const insert = this.db.prepare(`
      INSERT INTO character_team (character_id, hero_id, name, profession, level, formation_pos, avatar_key, quality, hp, atk, def, spd)
      VALUES (?, ?, ?, ?, 1, 0, ?, ?, ?, ?, ?, ?)
    `);
    insert.run(charId, heroId, target.name, target.profession, target.avatar, target.quality, target.hp, target.atk, target.def, target.spd);

    return {
      success: true,
      message: `${target.name} foi recrutado com sucesso para sua equipe!`,
      currency: this.getCurrency(charId),
      team: this.getTeam(charId)
    };
  }

  /**
   * Obtém moedas e progresso de um personagem
   */
  public getCurrency(charId: number): CharacterCurrencyRecord {
    let curr = this.db.prepare("SELECT * FROM character_currency WHERE character_id = ?").get(charId) as CharacterCurrencyRecord | undefined;
    if (!curr) {
      this.db.prepare("INSERT INTO character_currency (character_id) VALUES (?)").run(charId);
      curr = this.db.prepare("SELECT * FROM character_currency WHERE character_id = ?").get(charId) as CharacterCurrencyRecord;
    }
    return curr;
  }

  /**
   * Atualiza moedas do personagem
   */
  public updateCurrency(charId: number, delta: Partial<CharacterCurrencyRecord>): CharacterCurrencyRecord {
    const curr = this.getCurrency(charId);
    const newRyo = delta.ryo !== undefined ? delta.ryo : curr.ryo;
    const newGold = delta.gold !== undefined ? delta.gold : curr.gold;
    const newCoupons = delta.coupons !== undefined ? delta.coupons : curr.coupons;
    const newSouls = delta.ninja_souls !== undefined ? delta.ninja_souls : curr.ninja_souls;
    const newStage = delta.campaign_stage !== undefined ? delta.campaign_stage : curr.campaign_stage;

    this.db.prepare(`
      UPDATE character_currency
      SET ryo = ?, gold = ?, coupons = ?, ninja_souls = ?, campaign_stage = ?
      WHERE character_id = ?
    `).run(newRyo, newGold, newCoupons, newSouls, newStage, charId);

    return this.getCurrency(charId);
  }

  /**
   * Mini-game Mora (Jokenpô): 0 = Pedra, 1 = Tesoura, 2 = Papel
   */
  public playMora(charId: number, clientChoice: number): { clientChoice: number; serverChoice: number; result: 'win' | 'draw' | 'lose'; soulsAwarded: number; currency: CharacterCurrencyRecord } {
    const serverChoice = Math.floor(Math.random() * 3);
    let result: 'win' | 'draw' | 'lose' = 'draw';

    if (clientChoice === serverChoice) {
      result = 'draw';
    } else if (
      (clientChoice === 0 && serverChoice === 1) || // Pedra vence Tesoura
      (clientChoice === 1 && serverChoice === 2) || // Tesoura vence Papel
      (clientChoice === 2 && serverChoice === 0)    // Papel vence Pedra
    ) {
      result = 'win';
    } else {
      result = 'lose';
    }

    let soulsAwarded = 0;
    if (result === 'win') {
      soulsAwarded = 25;
    } else if (result === 'draw') {
      soulsAwarded = 5;
    } else {
      soulsAwarded = 2;
    }

    const curr = this.getCurrency(charId);
    this.updateCurrency(charId, { ninja_souls: curr.ninja_souls + soulsAwarded });

    return {
      clientChoice,
      serverChoice,
      result,
      soulsAwarded,
      currency: this.getCurrency(charId)
    };
  }

  /**
   * Remove conta e personagens (usado em testes para reset limpo)
   */
  public clearTestData(userId: string): void {
    const acc = this.db.prepare("SELECT id FROM accounts WHERE user_id = ?").get(userId) as any;
    if (acc) {
      this.db.prepare("DELETE FROM characters WHERE account_id = ?").run(acc.id);
      this.db.prepare("DELETE FROM accounts WHERE id = ?").run(acc.id);
    }
  }

  public close(): void {
    this.db.close();
  }
}

// Instância singleton global do banco de dados
export const db = new GameDatabase();
