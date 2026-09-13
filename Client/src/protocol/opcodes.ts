export const Opcodes = {
  // Autenticação e Login
  CS_Login_StatusServerTransmitToken: 25231360,    // 0x01810000
  SC_Login_StatusServerTransmitTokenRet: 18350080, // 0x01180000

  // Criação e Gestão de Personagem
  SC_CREATECHAR_CreateCharCmd: 18350336,          // 0x01180100
  CS_CREATECHAR_CreateChar: 25231616,             // 0x01810100
  SC_CREATECHAR_CreateCharRet: 18350337,          // 0x01180101
  SC_Account_CharInfoNtf: 18350338,               // 0x01180102

  // Navegação no Mundo e Vilas (Town)
  CS_LOBBY_Enter_Town: 25231872,                  // 0x01810200
  SC_Enter_Town: 18350592,                        // 0x01180200
  CS_LOBBY_Town_Move: 25232128,                   // 0x01810300
  SC_LOBBY_Town_NewRoleNtf: 18350848,             // 0x01180300
  SC_LOBBY_Town_RoleMove: 18350849,               // 0x01180301
  SC_LOBBY_Town_RemoveRole: 18350850,             // 0x01180302

  // Interação com NPCs e Diálogos
  SC_LOBBY_Town_NpcList: 18350851,                // 0x01180303
  CS_LOBBY_Town_TalkNpc: 25232384,                // 0x01810400
  SC_LOBBY_Town_NpcDialog: 18350852,              // 0x01180304

  // Batalha PvE
  CS_BattleStart: 22315008,                       // 0x01548000
  SC_Battle_StartReportDataReq: 21331968,         // 0x01458000
  SC_SingleBattleResult: 21331969                 // 0x01458001
} as const;

export type OpcodeName = keyof typeof Opcodes;
