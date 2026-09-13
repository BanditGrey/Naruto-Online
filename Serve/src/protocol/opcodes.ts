/**
 * Mapeamento Canônico de Opcodes extraídos diretamente do cliente Flash original (CONST_NETWORK.as / TTransceiver.as).
 */
export const Opcodes = {
  // Autenticação e Login
  CS_Login_StatusServerTransmitToken: 25231360,    // 0x01810000 - Envio de token de sessão
  SC_Login_StatusServerTransmitTokenRet: 18350080, // 0x01180000 - Retorno de validação da sessão

  // Criação e Gestão de Personagem
  SC_CREATECHAR_CreateCharCmd: 18350336,          // 0x01180100 - Notifica que conta precisa criar char
  CS_CREATECHAR_CreateChar: 25231616,             // 0x01810100 - Criação de personagem (Name, Profession, Gender)
  SC_CREATECHAR_CreateCharRet: 18350337,          // 0x01180101 - Retorno de status da criação
  SC_Account_CharInfoNtf: 18350338,               // 0x01180102 - Notificação completa dos dados do char

  // Navegação no Mundo e Vilas (Town)
  CS_LOBBY_Enter_Town: 25231872,                  // 0x01810200 - Solicita entrada em mapa/vila
  SC_Enter_Town: 18350592,                        // 0x01180200 - Confirma spawn no mapa com (X, Y)
  CS_LOBBY_Town_Move: 25232128,                   // 0x01810300 - Deslocamento do ninja no mapa (X, Y)
  SC_LOBBY_Town_NewRoleNtf: 18350848,             // 0x01180300 - Presença de outros avatares na vila
  SC_LOBBY_Town_RoleMove: 18350849,               // 0x01180301 - Broadcast de movimentação em tempo real
  SC_LOBBY_Town_RemoveRole: 18350850,             // 0x01180302 - Notifica saída/desconexão de um jogador

  // Interação com NPCs e Diálogos
  SC_LOBBY_Town_NpcList: 18350851,                // 0x01180303 - Lista de NPCs presentes na vila
  CS_LOBBY_Town_TalkNpc: 25232384,                // 0x01810400 - Solicita diálogo com um NPC
  SC_LOBBY_Town_NpcDialog: 18350852,              // 0x01180304 - Resposta de diálogo e ações do NPC

  // Sistema de Combate Tático por Turnos (15 Slots)
  CS_BattleStart: 22315008,                       // 0x01548000 - Inicia combate contra monstro/grupo
  SC_Battle_StartReportDataReq: 21331968,         // 0x01458000 - Relatório sincronizado de turnos pré-calculados
  SC_SingleBattleResult: 21331969                 // 0x01458001 - Resultado da batalha (Vitória/Derrota)
} as const;

export type OpcodeName = keyof typeof Opcodes;
