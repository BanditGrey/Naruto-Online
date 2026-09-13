import { Player } from './Player.js';
import { DatabaseManager } from '../../database/DatabaseManager.js';
import { CharacterConstants, ClassType, GenderType } from '../../protocol/constants.js';

export class PlayerManager {
  private static instance: PlayerManager;

  // Mapeamento em memória: userId -> Player
  private playersByUserId: Map<string, Player> = new Map();
  private playersByCharId: Map<number, Player> = new Map();

  private constructor() {}

  public static getInstance(): PlayerManager {
    if (!PlayerManager.instance) {
      PlayerManager.instance = new PlayerManager();
    }
    return PlayerManager.instance;
  }

  public getPlayerByUserId(userId: string): Player | undefined {
    return this.playersByUserId.get(userId);
  }

  public getPlayerByCharId(charId: number): Player | undefined {
    return this.playersByCharId.get(charId);
  }

  public getPlayerByName(name: string): Player | undefined {
    for (const player of this.playersByCharId.values()) {
      if (player.data.name.toLowerCase() === name.toLowerCase()) {
        return player;
      }
    }
    return undefined;
  }

  /**
   * Criação canônica: 3 classes (Taijutsu, Ninjutsu, Genjutsu) x 2 gêneros (Male: 1, Female: 0)
   */
  public createCharacter(userId: string, name: string, profession: number, gender: number): Player {
    const db = DatabaseManager.getInstance();

    // Validar se a classe pertence às 3 canônicas
    const validProfessions = [
      CharacterConstants.CLASS_Taijutsu,
      CharacterConstants.CLASS_Ninjutsu,
      CharacterConstants.CLASS_Genjutsu
    ];
    const finalProfession = validProfessions.includes(profession as any)
      ? (profession as ClassType)
      : CharacterConstants.CLASS_Taijutsu;

    // Validar gênero (0 = Female, 1 = Male)
    const finalGender: GenderType = (gender === 1 || gender === 0) ? gender : CharacterConstants.GENDER_Male;

    // Localizar template correspondente na base de heróis (IDs 11100001 a 11100006)
    const matchedTemplate = db.getMainHeroes().find(
      h => h.profession === finalProfession && h.sex === finalGender
    ) || {
      id: 11100001,
      name: 'Taijutsu Male',
      profession: CharacterConstants.CLASS_Taijutsu,
      sex: CharacterConstants.GENDER_Male,
      power: 46,
      agile: 54,
      intelligence: 36,
      life: 2500,
      speed: 100,
      active: 13100001,
      normalAttack: 13100114,
      talent: 13200001
    };

    const player = Player.createFromTemplate(userId, name, matchedTemplate);
    this.playersByUserId.set(userId, player);
    this.playersByCharId.set(player.data.charId, player);

    const schoolName = finalProfession === CharacterConstants.CLASS_Taijutsu
      ? 'Taijutsu'
      : finalProfession === CharacterConstants.CLASS_Ninjutsu
      ? 'Ninjutsu'
      : 'Genjutsu';
    const genderName = finalGender === CharacterConstants.GENDER_Male ? 'Masculino' : 'Feminino';

    console.log(`[PLAYER] ✓ Personagem canônico criado: "${name}" (#${player.data.charId}) — Escola: ${schoolName} (${genderName}, Template #${matchedTemplate.id})`);
    return player;
  }
}
