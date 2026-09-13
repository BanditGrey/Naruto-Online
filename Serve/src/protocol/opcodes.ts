/**
 * Mapeamento Canônico de Opcodes extraídos diretamente do cliente Flash original (CONST_NETWORK.as / TTransceiver.as).
 */

// Bases de Módulos Oficiais Flash
export const MODULARID = {
  Login: 0,
  Account: 256,
  Enter: 512,
  Town: 768,
  Chat: 1024,
  WorldMap: 1280,
  Hurdle: 1536,
  KillHeros: 1792,
  MilitaryRank: 2048,
  TacticalDeployment: 2304,
  BigDipper: 2560,
  GeneralStar: 2816,
  Tavern: 3072,
  Equip: 3328,
  Smithy: 3584,
  Backpack: 3840,
  Heros: 4096,
  Jade: 4352,
  Task: 4608,
  Friend: 5376,
  Mail: 5632
} as const;

export const PACKET_BASE = {
  CS_LOBBY: 25231360, // 0x01810000
  SC_LOBBY: 18350080, // 0x01180000
  CS_BATTLE: 22315008, // 0x01548000
  SC_BATTLE: 21331968  // 0x01458000
} as const;

export const Opcodes = {
  // Controle de Socket
  KeepAliveAck: 1,
  KickErrorCodeRet: 2,

  // 1. Autenticação e Login (MODULARID.Login: 0)
  CS_Login_StatusServerTransmitToken: 25231360,    // 0x01810000 - Envio de token de sessão
  SC_Login_StatusServerTransmitTokenRet: 18350080, // 0x01180000 - Retorno de validação da sessão
  CS_Login_GateServerTransmitToken: 25231361,      // 0x01810001 - Envio de token para o Gate Server

  // 2. Criação e Gestão de Personagem (MODULARID.Account: 256)
  SC_CREATECHAR_CreateCharCmd: 18350336,          // 0x01180100 - Notifica que conta precisa criar char
  CS_CREATECHAR_CreateChar: 25231616,             // 0x01810100 - Criação de personagem (Name, Profession, Gender)
  SC_CREATECHAR_CreateCharRet: 18350337,          // 0x01180101 - Retorno de status da criação
  SC_Account_CharInfoNtf: 18350338,               // 0x01180102 - Notificação completa dos dados do char
  CS_Account_CharBaseAttributeReq: 25231617,      // 0x01810101 - Requisita atributos base do personagem
  CS_Account_CharUpgradeReq: 25231618,            // 0x01810102 - Requisita upgrade/evolução
  CS_Account_UserFightVauleReq: 25231624,         // 0x01810108 - Requisita poder de combate (Battle Points)
  SC_Account_CharUpgradeNtf: 18350339,            // 0x01180103 - Notifica upgrade
  SC_Account_CharBaseAttributeRet: 18350340,      // 0x01180104 - Retorno dos atributos base (Power, Agility, Intellect, Life)
  SC_Account_CharBaseInfoUpdate: 18350341,        // 0x01180105 - Atualização de dados parciais (Silver, Gold, HP, etc.)
  SC_Account_MainHeroSkillInfoNtf: 18350342,      // 0x01180106 - Notifica skills desbloqueadas
  SC_Account_CharForbiddenNtf: 18350343,          // 0x01180107 - Notifica silenciamento/bloqueio
  SC_Account_UserFightVauleRet: 18350344,         // 0x01180108 - Retorno de poder de combate
  SC_Account_HeroEquipInfoNtf: 18350345,          // 0x01180109 - Equipamentos do herói

  // 3. Navegação no Mundo e Vilas (MODULARID.Enter: 512 & MODULARID.Town: 768)
  CS_LOBBY_Enter_Town: 25231872,                  // 0x01810200 - Solicita entrada em mapa/vila
  SC_Enter_Town: 18350592,                        // 0x01180200 - Confirma spawn no mapa com (X, Y)
  CS_Enter_WorldMap: 25231873,                    // 0x01810201 - Requisita mapa mundi
  SC_Enter_WorldMap: 18350593,                    // 0x01180201 - Retorno do mapa mundi
  CS_Enter_Hurdle: 25231874,                      // 0x01810202 - Entra em instância/fase
  SC_Enter_Hurdle: 18350594,                      // 0x01180202 - Retorno da instância
  CS_Enter_Tavern: 25231877,                      // 0x01810205 - Entra na Taverna
  SC_Enter_Tavern: 18350597,                      // 0x01180205 - Dados da Taverna
  CS_LOBBY_Town_Move: 25232128,                   // 0x01810300 - Deslocamento do ninja no mapa (X, Y)
  SC_LOBBY_Town_NewRoleNtf: 18350848,             // 0x01180300 - Presença de outros avatares na vila
  SC_LOBBY_Town_RoleMove: 18350849,               // 0x01180301 - Broadcast de movimentação em tempo real
  SC_LOBBY_Town_RemoveRole: 18350850,             // 0x01180302 - Notifica saída/desconexão de um jogador
  SC_LOBBY_Town_UpdateRole: 18350851,             // 0x01180303 - Atualização visual de role

  // 4. Interação com NPCs e Diálogos
  SC_LOBBY_Town_NpcList: 18350851,                // 0x01180303 - Lista de NPCs presentes na vila
  CS_LOBBY_Town_TalkNpc: 25232129,                // 0x01810301 - Solicita diálogo com um NPC
  SC_LOBBY_Town_NpcDialog: 18350852,              // 0x01180304 - Resposta de diálogo e ações do NPC

  // 5. Sistema de Chat (MODULARID.Chat: 1024 / 0x0400)
  CS_Chat_ChatInfo: 25232384,                     // 0x01810400 - Envia mensagem no chat
  SC_Chat_ChatInfoRet: 18351104,                  // 0x01180400 - Broadcast de mensagem recebida
  SC_Chat_ChatNotReach: 18351105,                 // 0x01180401 - Destinatário não encontrado/offline
  SC_Chat_WhisperEchoplex: 18351106,              // 0x01180402 - Eco de sussurro para o remetente

  // 6. Sistema de Formação Tática (MODULARID.TacticalDeployment: 2304 / 0x0900)
  CS_TacticalDeployment_ChangePositionReq: 25233664, // 0x01810900 - Altera posição do ninja no grid (1..15)
  SC_TacticalDeploymentChangePositonRet: 18352384,   // 0x01180900 - Confirma nova posição no grid
  CS_TacticalDeployment_ChangeSkillReq: 25233665,    // 0x01810901 - Altera habilidade equipada
  SC_TacticalDeploymentChangeSkillRet: 18352385,      // 0x01180901 - Confirma habilidade alterada
  CS_TacticalDeployment_AutoChangeForm: 25233666,    // 0x01810902 - Troca automática de formação
  SC_TacticalDeployment_AutoChangeForm: 18352386,    // 0x01180902 - Retorno de troca automática
  SC_TacticalDeployment_AutoChangeFormInfo: 18352387,// 0x01180903 - Info da formação automática

  // 7. Sistema de Taverna & Recrutamento (MODULARID.Tavern: 3072 / 0x0C00)
  CS_TavernMoraReq: 25234432,                     // 0x01810C00 - Aposta Jokenpô (Mora)
  SC_TavernMoraRet: 18353152,                     // 0x01180C00 - Resultado do Jokenpô
  CS_TavernNormalMoraReq: 25234433,               // 0x01810C01 - Jokenpô simples
  SC_TavernNormalMoraRet: 18353153,               // 0x01180C01 - Retorno Jokenpô simples
  CS_TavernRecruitReq: 25234434,                  // 0x01810C02 - Recruta ninja com almas
  SC_TavernRecruitRet: 18353154,                  // 0x01180C02 - Confirmação do ninja recrutado

  // 8. Sistema de Mochila & Inventário (MODULARID.Backpack: 3840 / 0x0F00)
  CS_Backpack_LoadBag: 25235200,                  // 0x01810F00 - Requisita carregamento do inventário
  SC_Backpack_LoadBagResult: 18353920,            // 0x01180F00 - Lista completa de itens do inventário
  CS_Backpack_UseAppliance: 25235201,             // 0x01810F01 - Usar item consumível
  SC_Backpack_SendThings: 18353921,               // 0x01180F01 - Recebimento de novos itens
  SC_Backpack_ReduceThings: 18353922,             // 0x01180F02 - Redução de itens do inventário
  SC_Backpack_InventoryExpire: 18353923,          // 0x01180F03 - Item expirado por tempo
  CS_Backpack_SellItem: 25235203,                 // 0x01810F03 - Venda de item
  SC_Backpack_UseAppliance: 18353924,             // 0x01180F04 - Retorno de uso de item
  SC_Backpack_SellItem: 18353925,                 // 0x01180F05 - Retorno de venda de item
  SC_Backpack_InventoryNtf: 18353926,             // 0x01180F06 - Notificação atômica de item (Add/Upd/Del)
  CS_Backpack_DepotToBag: 25235207,               // 0x01810F07 - Mover item do armazém para mochila
  SC_Backpack_DepotToBag: 18353927,               // 0x01180F07 - Retorno da movimentação armazém->mochila
  CS_Backpack_MergeBagItem_Req: 25235209,         // 0x01810F09 - Organizar e empilhar mochila
  SC_Backpack_MergeBagItem_Ret: 18353928,         // 0x01180F08 - Confirmação de ordenação da mochila

  // 9. Sistema de Missões e Tarefas (MODULARID.Task: 4608 / 0x1200)
  CS_Task_AlreadyAcceptTaskReq: 25235968,         // 0x01811200 - Requisita missões em andamento
  CS_Task_QuestActionReq: 25235969,               // 0x01811201 - Ação de missão (Aceitar / Concluir)
  SC_Task_CompleteSendInfor: 18354688,            // 0x01181200 - Notifica missão cumprida
  SC_Task_QuestActionRet: 18354689,               // 0x01181201 - Status da ação de missão
  SC_Task_AlreadyAcceptTaskRet: 18354690,         // 0x01181202 - Lista de missões em andamento
  SC_Task_AlreadyFinishTaskRet: 18354691,         // 0x01181203 - Lista de missões já concluídas

  // 10. Sistema de Correio (MODULARID.Mail: 5632 / 0x1600)
  CS_Mail_InitDataReq: 25236992,                  // 0x01811600 - Requisita carregamento de cartas
  SC_Mail_InitDataRep: 18355712,                  // 0x01181600 - Lista de cartas recebidas
  CS_Mail_SendMailReq: 25236993,                  // 0x01811601 - Enviar carta
  SC_Mail_SendMailRep: 18355713,                  // 0x01181601 - Retorno de envio de carta
  CS_Mail_DelMailReq: 25236994,                   // 0x01811602 - Excluir carta
  SC_Mail_DelMailRep: 18355714,                   // 0x01181602 - Retorno de exclusão de carta
  CS_Mail_GetAttachmentReq: 25236995,             // 0x01811603 - Resgatar anexo da carta
  SC_Mail_GetAttachmentRep: 18355715,             // 0x01181603 - Retorno do resgate de anexo
  SC_Mail_MailRecNtf: 18355717,                   // 0x01181605 - Notificação de nova carta recebida

  // 11. Sistema de Guilda / Família (MODULARID.Guild: 4864 / 0x1300)
  CS_Guild_InitReq: 25236224,                     // 0x01811300 - Requisita dados da guilda
  SC_Guild_InitRet: 18354944,                     // 0x01181300 - Retorno de dados da guilda
  CS_Guild_DonateReq: 25236225,                   // 0x01811301 - Doação de moedas para guilda
  SC_Guild_DonateRet: 18354945,                   // 0x01181301 - Confirmação de doação para guilda

  // 12. Sistema de Central de Presentes & Códigos CDK (MODULARID.Welcome: 5120 / 0x1400)
  CS_Gift_RedeemCodeReq: 25236480,                // 0x01811400 - Resgate de código promocional (CDK)
  SC_Gift_RedeemCodeRet: 18355200,                // 0x01181400 - Resultado do resgate do código

  // 13. Sistema de Combate Tático por Turnos (15 Slots)
  CS_BattleStart: 22315008,                       // 0x01548000 - Inicia combate contra monstro/grupo
  SC_Battle_StartReportDataReq: 21331968,         // 0x01458000 - Relatório sincronizado de turnos pré-calculados
  SC_SingleBattleResult: 21331969                 // 0x01458001 - Resultado da batalha (Vitória/Derrota)
} as const;

export type OpcodeName = keyof typeof Opcodes;

export function getOpcodeName(id: number): string {
  for (const [key, value] of Object.entries(Opcodes)) {
    if (value === id) return key;
  }
  return `UNKNOWN_OPCODE_${id} (0x${id.toString(16).toUpperCase()})`;
}
