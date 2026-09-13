export interface HeroDefinition {
  id: number;
  name: string;
}

export interface ItemDefinition {
  id: number;
  name: string;
  description: string;
}

export interface PlayerHero {
  instanceId: string;
  heroId: number;
  level: number;
  position: number; // 0 a 8 no grid 3x3
  hp: number;
  maxHp: number;
}

export interface PlayerItem {
  slot: number;
  itemId: number;
  count: number;
}

export interface PlayerState {
  uid: string;
  username: string;
  silver: number;
  gold: number;
  team: PlayerHero[];
  inventory: PlayerItem[];
}

export enum PacketType {
  // Handshake & Auth
  CS_LOGIN = 0x1001,
  SC_LOGIN_SUCCESS = 0x2001,
  SC_PLAYER_STATE = 0x2002,

  // Gameplay
  CS_CHANGE_FORMATION = 0x1010,
  SC_FORMATION_UPDATED = 0x2010,
  CS_USE_ITEM = 0x1020,
  SC_INVENTORY_UPDATED = 0x2020,

  // Batalha
  CS_START_BATTLE = 0x1030,
  SC_BATTLE_RESULT = 0x2030
}

export interface BasePacket<T = any> {
  type: PacketType;
  payload: T;
}
