/**
 * Opcodes essenciais extraídos de CONST_NETWORK.as e TProcessorLogin.as
 */

// Bases de módulos de rede
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
} as const;

// Bases de envio (CS: Client -> Server) e recebimento (SC: Server -> Client)
export const PACKET_BASE = {
  CS_LOBBY: 25231360, // 0x01810000
  SC_LOBBY: 18350080, // 0x01180000
  CS_BATTLE: 22315008,
  SC_BATTLE: 21331968,
} as const;

export const OPCODES = {
  // Controle de Socket e Conexão Interna
  KeepAliveAck: 1,
  KickErrorCodeRet: 2,

  // --- MÓDULO LOGIN (Base CS: 25231360 / SC: 18350080) ---
  /**
   * Envio do Token de autenticação para o Login/Status Server
   * Payload:
   *   - UserID: FlushUTF (string com prefixo uint32)
   *   - AgentID: uint32
   *   - ServerID: uint32
   *   - Token: FlushUTF
   *   - Version: uint32
   *   - LoginTime: FlushUTF
   */
  CS_Login_StatusServerTransmitToken: PACKET_BASE.CS_LOBBY + MODULARID.Login + 0, // 25231360

  /**
   * Resposta do Status Server com status e redirecionamento para o Gate Server
   * Payload:
   *   - ErrorCode: uint32 (0 = sucesso)
   *   - GateIP: 4 bytes (octetos do IPv4)
   *   - GatePort: uint16
   */
  SC_Login_StatusServerTransmitTokenRet: PACKET_BASE.SC_LOBBY + MODULARID.Login + 0, // 18350080

  /**
   * Envio do Token para o Gate Server após redirecionamento
   * Payload: idêntico ao CS_Login_StatusServerTransmitToken
   */
  CS_Login_GateServerTransmitToken: PACKET_BASE.CS_LOBBY + MODULARID.Login + 1, // 25231361

  // --- MÓDULO CRIAÇÃO DE PERSONAGEM (Base CS: 25231616 / SC: 18350336) ---
  /**
   * Solicitação do cliente para criar um novo personagem
   * Payload:
   *   - Name: FlushUTF (string)
   *   - Profession: uint8 (classe/ninja base selecionado)
   *   - Gender: uint8
   */
  CS_CREATECHAR_CreateChar: PACKET_BASE.CS_LOBBY + MODULARID.Account + 0, // 25231616

  /**
   * Notificação do servidor solicitando criação de personagem (se for usuário novo)
   */
  SC_CREATECHAR_CreateCharCmd: PACKET_BASE.SC_LOBBY + MODULARID.Account + 0, // 18350336

  /**
   * Retorno do resultado da criação de personagem
   */
  SC_CREATECHAR_CreateCharRet: PACKET_BASE.SC_LOBBY + MODULARID.Account + 1, // 18350337

  // --- MÓDULO CONTA / DADOS DO PERSONAGEM (Base CS: 25231617 / SC: 18350338) ---
  CS_Account_CharBaseAttributeReq: PACKET_BASE.CS_LOBBY + MODULARID.Account + 1, // 25231617
  CS_Account_CharUpgradeReq: PACKET_BASE.CS_LOBBY + MODULARID.Account + 2,       // 25231618
  CS_Account_UserFightVauleReq: PACKET_BASE.CS_LOBBY + MODULARID.Account + 8,     // 25231624

  SC_Account_CharInfoNtf: PACKET_BASE.SC_LOBBY + MODULARID.Account + 2,          // 18350338 (Dados completos do char)
  SC_Account_CharUpgradeNtf: PACKET_BASE.SC_LOBBY + MODULARID.Account + 3,       // 18350339
  SC_Account_CharBaseAttributeRet: PACKET_BASE.SC_LOBBY + MODULARID.Account + 4, // 18350340
  SC_Account_CharBaseInfoUpdate: PACKET_BASE.SC_LOBBY + MODULARID.Account + 5,   // 18350341
  SC_Account_MainHeroSkillInfoNtf: PACKET_BASE.SC_LOBBY + MODULARID.Account + 6, // 18350342
  SC_Account_CharForbiddenNtf: PACKET_BASE.SC_LOBBY + MODULARID.Account + 7,     // 18350343
  SC_Account_UserFightVauleRet: PACKET_BASE.SC_LOBBY + MODULARID.Account + 8,    // 18350344
  SC_Account_HeroEquipInfoNtf: PACKET_BASE.SC_LOBBY + MODULARID.Account + 9,     // 18350345

  // --- MÓDULO ENTRADA NO MUNDO (TOWN) ---
  CS_LOBBY_Enter_Town: PACKET_BASE.CS_LOBBY + MODULARID.Enter + 0, // 25231872
  SC_Enter_Town: PACKET_BASE.SC_LOBBY + MODULARID.Enter + 0,       // 18350592

  // --- MÓDULO MOVIMENTAÇÃO E ENTIDADES NA VILA (TOWN INSTANCE) ---
  CS_LOBBY_Town_Move: PACKET_BASE.CS_LOBBY + MODULARID.Town + 0, // 25232128
  SC_LOBBY_Town_NewRoleNtf: PACKET_BASE.SC_LOBBY + MODULARID.Town + 0, // 18350848
  SC_LOBBY_Town_RoleMove: PACKET_BASE.SC_LOBBY + MODULARID.Town + 1, // 18350849
  SC_LOBBY_Town_RemoveRole: PACKET_BASE.SC_LOBBY + MODULARID.Town + 2, // 18350850
  SC_LOBBY_Town_UpdateRole: PACKET_BASE.SC_LOBBY + MODULARID.Town + 3, // 18350851

  // --- MÓDULO COMBATE POR TURNOS (BATTLE) ---
  CS_BattleStart: PACKET_BASE.CS_BATTLE + 0, // 22315008 (0x01548000)
  SC_Battle_StartReportDataReq: PACKET_BASE.SC_BATTLE + 0, // 21331968 (0x01458000)
  SC_SingleBattleResult: PACKET_BASE.SC_BATTLE + 1, // 21331969

  // --- MÓDULO MOCHILA / INVENTÁRIO (MODULARID.Backpack: 3840) ---
  CS_Backpack_LoadBag: PACKET_BASE.CS_LOBBY + MODULARID.Backpack + 0, // 25235200
  CS_Backpack_UseAppliance: PACKET_BASE.CS_LOBBY + MODULARID.Backpack + 1, // 25235201
  CS_Backpack_SellItem: PACKET_BASE.CS_LOBBY + MODULARID.Backpack + 3, // 25235203
  SC_Backpack_InventoryNtf: PACKET_BASE.SC_LOBBY + MODULARID.Backpack + 6, // 18353926

  // --- MÓDULO TAVERNA NINJA / MORA (MODULARID.Tavern: 3072) ---
  CS_Enter_Tavern: PACKET_BASE.CS_LOBBY + MODULARID.Enter + 5, // 25231877
  SC_Enter_Tavern: PACKET_BASE.SC_LOBBY + MODULARID.Enter + 5, // 18350597
  CS_TavernMoraReq: PACKET_BASE.CS_LOBBY + MODULARID.Tavern + 0, // 25234432
  SC_TavernMoraRet: PACKET_BASE.SC_LOBBY + MODULARID.Tavern + 0, // 18353152
  CS_TavernRecruitReq: PACKET_BASE.CS_LOBBY + MODULARID.Tavern + 2, // 25234434
  SC_TavernRecruitRet: PACKET_BASE.SC_LOBBY + MODULARID.Tavern + 2, // 18353154

  // --- MÓDULO FORMAÇÃO TÁTICA (MODULARID.TacticalDeployment: 2304) ---
  CS_TacticalDeployment_ChangePositionReq: PACKET_BASE.CS_LOBBY + MODULARID.TacticalDeployment + 0, // 25233664
  SC_TacticalDeploymentChangePositonRet: PACKET_BASE.SC_LOBBY + MODULARID.TacticalDeployment + 0, // 18352384

  // --- MÓDULO EQUIPAMENTOS E FORJA (MODULARID.Equip: 3328) ---
  CS_Equip_EnhanceReq: PACKET_BASE.CS_LOBBY + MODULARID.Equip + 0, // 25234688
  SC_Equip_EnhanceRet: PACKET_BASE.SC_LOBBY + MODULARID.Equip + 0, // 18353408

  // --- MÓDULO INSTÂNCIAS / CAMPANHA PVE (MODULARID.Hurdle: 1536) ---
  CS_Enter_Hurdle: PACKET_BASE.CS_LOBBY + MODULARID.Enter + 2, // 25231874
  SC_Enter_Hurdle: PACKET_BASE.SC_LOBBY + MODULARID.Enter + 2, // 18350594
} as const;

export type OpcodeName = keyof typeof OPCODES;

export function getOpcodeName(id: number): string {
  for (const [key, value] of Object.entries(OPCODES)) {
    if (value === id) return key;
  }
  return `UNKNOWN_OPCODE_${id} (0x${id.toString(16)})`;
}
