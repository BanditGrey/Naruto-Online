/**
 * Tipagens e Modelos Compartilhados entre Servidor e Cliente (Naruto Online)
 */

export interface AccountData {
  id: number;
  userId: string;
  token?: string;
  createdAt?: string;
}

export interface CharacterData {
  id: number;
  accountId: number;
  name: string;
  profession: number;
  gender: number;
  level: number;
  createdAt?: string;
}

export interface TownPlayerInfo {
  charId: number;
  name: string;
  profession: number;
  level: number;
  x: number;
  y: number;
  direction?: number;
}

/**
 * Estrutura de Combatente na Arena de Batalha (Logics.Battle)
 */
export interface FighterBattleData {
  pos: number;         // Posição no grid (1..15 conforme TBattleConfig)
  roleId: number;      // ID da classe ou NPC/Monstro
  quality: number;     // Qualidade (1..5)
  level: number;       // Nível
  curHealth: number;   // Vida atual
  totalHealth: number; // Vida máxima
  curAnger: number;    // Fúria/Chakra atual (0..100)
  skillId: number;     // ID da habilidade ativa
  elementBit: number;  // Elemento (1=Vento, 2=Fogo, 3=Relâmpago, 4=Terra, 5=Água)
  name: string;        // Nome do combatente
}

export interface TeamBattleData {
  userId: string;
  mountsId?: number;
  mountsLevel?: number;
  soulFormationId?: number;
  emblemId?: number;
  ringId?: number;
  fighters: FighterBattleData[];
}

export interface TargetActionResult {
  cmd: number;            // 1 = CMD_ATTACK, 3 = CMD_HURTBUFF, 4 = CMD_CONTROLBUFF
  targetCamp: number;     // 0 = Aliado, 1 = Inimigo
  targetPos: number;      // Slot 1..15
  targetStatus?: number;
  targetStatus1?: number;
  targetStatus2?: number;
  hurtHp?: number;        // Dano
  hurtAnger?: number;     // Fúria
  buffId?: number;
}

export interface ActionBattleData {
  activeCamp: number;     // 0 ou 1
  activePos: number;      // 1..15
  skillEffectId: number;
  activeType: number;     // 1 = NormalAttack, 2 = SkillAttack
  targets: TargetActionResult[];
}

export interface TurnBattleData {
  curTurn: number;
  actions: ActionBattleData[];
}

export interface BattleInitReport {
  battleIdStr: string;
  team1: TeamBattleData;
  team2: TeamBattleData;
  turns: TurnBattleData[];
}
