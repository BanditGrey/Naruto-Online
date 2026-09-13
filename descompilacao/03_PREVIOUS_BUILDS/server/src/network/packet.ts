/**
 * Módulo de serialização binária de pacotes para o protocolo ActionScript 3 (Naruto Online)
 * 
 * Estrutura no Modo Plano (Big Endian):
 * [0..3]: PacketLength (uint32 BE) = payload.length + 8
 * [4..7]: PacketID     (uint32 BE) = Identificador do Opcode
 * [8..N]: Payload      (Bytes de dados do pacote)
 */

export const SIZE_PACKET_LENGTH = 4;
export const SIZE_PACKET_ID = 4;
export const SIZE_PACKET_HEADER = SIZE_PACKET_LENGTH + SIZE_PACKET_ID; // 8 bytes

/**
 * Classe utilitária para construção e serialização de pacotes.
 */
export class PacketWriter {
  private chunks: Buffer[] = [];
  private currentLength: number = 0;
  private defaultPacketId?: number;

  constructor(packetId?: number) {
    this.defaultPacketId = packetId;
  }

  /**
   * Escreve 1 byte (int8 / uint8)
   */
  public writeByte(value: number): this {
    const buf = Buffer.allocUnsafe(1);
    buf.writeUInt8(value & 0xff, 0);
    this.chunks.push(buf);
    this.currentLength += 1;
    return this;
  }

  public writeUnsignedByte(value: number): this {
    return this.writeByte(value);
  }

  /**
   * Escreve um inteiro de 16 bits (Short)
   */
  public writeShort(value: number, littleEndian: boolean = false): this {
    const buf = Buffer.allocUnsafe(2);
    if (littleEndian) {
      buf.writeInt16LE(value, 0);
    } else {
      buf.writeInt16BE(value, 0);
    }
    this.chunks.push(buf);
    this.currentLength += 2;
    return this;
  }

  public writeInt16(value: number, littleEndian: boolean = false): this {
    return this.writeShort(value, littleEndian);
  }

  /**
   * Escreve um inteiro de 16 bits sem sinal (Unsigned Short)
   */
  public writeUnsignedShort(value: number, littleEndian: boolean = false): this {
    const buf = Buffer.allocUnsafe(2);
    if (littleEndian) {
      buf.writeUInt16LE(value, 0);
    } else {
      buf.writeUInt16BE(value, 0);
    }
    this.chunks.push(buf);
    this.currentLength += 2;
    return this;
  }

  public writeUInt16(value: number, littleEndian: boolean = false): this {
    return this.writeUnsignedShort(value, littleEndian);
  }

  /**
   * Escreve um inteiro de 32 bits com sinal (Int)
   */
  public writeInt(value: number, littleEndian: boolean = false): this {
    const buf = Buffer.allocUnsafe(4);
    if (littleEndian) {
      buf.writeInt32LE(value, 0);
    } else {
      buf.writeInt32BE(value, 0);
    }
    this.chunks.push(buf);
    this.currentLength += 4;
    return this;
  }

  public writeInt32(value: number, littleEndian: boolean = false): this {
    return this.writeInt(value, littleEndian);
  }

  /**
   * Escreve um inteiro de 32 bits sem sinal (Unsigned Int)
   */
  public writeUnsignedInt(value: number, littleEndian: boolean = false): this {
    const buf = Buffer.allocUnsafe(4);
    if (littleEndian) {
      buf.writeUInt32LE(value >>> 0, 0);
    } else {
      buf.writeUInt32BE(value >>> 0, 0);
    }
    this.chunks.push(buf);
    this.currentLength += 4;
    return this;
  }

  /**
   * Escreve um float de 32 bits
   */
  public writeFloat(value: number, littleEndian: boolean = false): this {
    const buf = Buffer.allocUnsafe(4);
    if (littleEndian) {
      buf.writeFloatLE(value, 0);
    } else {
      buf.writeFloatBE(value, 0);
    }
    this.chunks.push(buf);
    this.currentLength += 4;
    return this;
  }

  /**
   * Escreve um double de 64 bits
   */
  public writeDouble(value: number, littleEndian: boolean = false): this {
    const buf = Buffer.allocUnsafe(8);
    if (littleEndian) {
      buf.writeDoubleLE(value, 0);
    } else {
      buf.writeDoubleBE(value, 0);
    }
    this.chunks.push(buf);
    this.currentLength += 8;
    return this;
  }

  /**
   * Escreve uma string UTF-8 no formato Flash TUtilityString.FlushUTF:
   * Prefixo de 4 bytes (uint32 BE) contendo a quantidade de bytes da string + bytes UTF-8.
   */
  public writeStringUTF(str: string): this {
    const strBuf = Buffer.from(str ?? "", "utf-8");
    this.writeUnsignedInt(strBuf.length, false); // Tamanho em Big Endian
    this.chunks.push(strBuf);
    this.currentLength += strBuf.length;
    return this;
  }

  /**
   * Escreve bytes brutos diretamente no payload
   */
  public writeBytes(bytes: Buffer | Uint8Array): this {
    const buf = Buffer.isBuffer(bytes) ? bytes : Buffer.from(bytes);
    this.chunks.push(buf);
    this.currentLength += buf.length;
    return this;
  }

  /**
   * Retorna apenas o buffer do payload acumulado
   */
  public getPayload(): Buffer {
    return Buffer.concat(this.chunks, this.currentLength);
  }

  /**
   * Finaliza o pacote gerando o cabeçalho no Modo Plano (Big Endian)
   * e concatenando com o payload:
   *
   * [PacketLength: 4 bytes BE (payload.length + 8)]
   * [PacketID:     4 bytes BE]
   * [Payload:      N bytes]
   */
  public toPacket(packetId: number): Buffer {
    const payload = this.getPayload();
    const totalLength = payload.length + SIZE_PACKET_HEADER;

    const header = Buffer.allocUnsafe(SIZE_PACKET_HEADER);
    header.writeUInt32BE(totalLength, 0);
    header.writeUInt32BE(packetId >>> 0, 4);

    return Buffer.concat([header, payload], totalLength);
  }

  /**
   * Alias de conveniência que empacota com o packetId fornecido no construtor
   * ou serializa o payload se nenhum id foi passado.
   */
  public toBuffer(packetId?: number): Buffer {
    const id = packetId ?? this.defaultPacketId;
    if (id !== undefined) {
      return this.toPacket(id);
    }
    return this.getPayload();
  }
}

/**
 * Estrutura representando um pacote completo decodificado
 */
export interface DecodedPacket {
  packetLength: number; // Comprimento total informado no cabeçalho
  packetId: number;     // Opcode da mensagem
  payload: Buffer;      // Buffer do payload desempacotado
  reader: PacketReader; // Leitor posicionado no início do payload
}

/**
 * Classe utilitária para leitura e desserialização de pacotes binários.
 */
export class PacketReader {
  private buffer: Buffer;
  private offset: number = 0;

  constructor(buffer: Buffer | Uint8Array, startOffset: number = 0) {
    this.buffer = Buffer.isBuffer(buffer) ? buffer : Buffer.from(buffer);
    this.offset = startOffset;
  }

  /**
   * Quantidade de bytes ainda disponíveis para leitura
   */
  public get bytesAvailable(): number {
    return Math.max(0, this.buffer.length - this.offset);
  }

  /**
   * Posição atual de leitura no buffer
   */
  public get position(): number {
    return this.offset;
  }

  public set position(pos: number) {
    this.offset = Math.min(this.buffer.length, Math.max(0, pos));
  }

  /**
   * Comprimento total do buffer interno
   */
  public get length(): number {
    return this.buffer.length;
  }

  /**
   * Lê 1 byte com sinal (-128 a 127)
   */
  public readByte(): number {
    this.ensureAvailable(1);
    const val = this.buffer.readInt8(this.offset);
    this.offset += 1;
    return val;
  }

  /**
   * Lê 1 byte sem sinal (0 a 255)
   */
  public readUnsignedByte(): number {
    this.ensureAvailable(1);
    const val = this.buffer.readUInt8(this.offset);
    this.offset += 1;
    return val;
  }

  /**
   * Lê um inteiro de 16 bits com sinal (Short)
   */
  public readShort(littleEndian: boolean = false): number {
    this.ensureAvailable(2);
    const val = littleEndian
      ? this.buffer.readInt16LE(this.offset)
      : this.buffer.readInt16BE(this.offset);
    this.offset += 2;
    return val;
  }

  public readInt16(littleEndian: boolean = false): number {
    return this.readShort(littleEndian);
  }

  /**
   * Lê um inteiro de 16 bits sem sinal (Unsigned Short)
   */
  public readUnsignedShort(littleEndian: boolean = false): number {
    this.ensureAvailable(2);
    const val = littleEndian
      ? this.buffer.readUInt16LE(this.offset)
      : this.buffer.readUInt16BE(this.offset);
    this.offset += 2;
    return val;
  }

  public readUInt16(littleEndian: boolean = false): number {
    return this.readUnsignedShort(littleEndian);
  }

  /**
   * Lê um inteiro de 32 bits com sinal (Int)
   */
  public readInt(littleEndian: boolean = false): number {
    this.ensureAvailable(4);
    const val = littleEndian
      ? this.buffer.readInt32LE(this.offset)
      : this.buffer.readInt32BE(this.offset);
    this.offset += 4;
    return val;
  }

  public readInt32(littleEndian: boolean = false): number {
    return this.readInt(littleEndian);
  }

  /**
   * Lê um inteiro de 32 bits sem sinal (Unsigned Int)
   */
  public readUnsignedInt(littleEndian: boolean = false): number {
    this.ensureAvailable(4);
    const val = littleEndian
      ? this.buffer.readUInt32LE(this.offset)
      : this.buffer.readUInt32BE(this.offset);
    this.offset += 4;
    return val;
  }

  public readUInt32(littleEndian: boolean = false): number {
    return this.readUnsignedInt(littleEndian);
  }

  /**
   * Lê um float de 32 bits
   */
  public readFloat(littleEndian: boolean = false): number {
    this.ensureAvailable(4);
    const val = littleEndian
      ? this.buffer.readFloatLE(this.offset)
      : this.buffer.readFloatBE(this.offset);
    this.offset += 4;
    return val;
  }

  /**
   * Lê um double de 64 bits
   */
  public readDouble(littleEndian: boolean = false): number {
    this.ensureAvailable(8);
    const val = littleEndian
      ? this.buffer.readDoubleLE(this.offset)
      : this.buffer.readDoubleBE(this.offset);
    this.offset += 8;
    return val;
  }

  /**
   * Lê uma string UTF-8 no formato Flash TUtilityString.FetchUTF:
   * Prefixo de 4 bytes (uint32 BE) com tamanho da string + bytes UTF-8.
   */
  public readStringUTF(): string {
    const len = this.readUnsignedInt(false);
    if (len === 0) return "";
    this.ensureAvailable(len);
    const str = this.buffer.toString("utf-8", this.offset, this.offset + len);
    this.offset += len;
    return str;
  }

  public readFlushUTF(): string {
    return this.readStringUTF();
  }

  /**
   * Lê N bytes brutos e retorna um novo Buffer
   */
  public readBytes(length: number): Buffer {
    this.ensureAvailable(length);
    const slice = this.buffer.subarray(this.offset, this.offset + length);
    this.offset += length;
    return Buffer.from(slice);
  }

  /**
   * Retorna os bytes restantes a partir da posição atual
   */
  public readRemaining(): Buffer {
    return this.readBytes(this.bytesAvailable);
  }

  /**
   * Decodifica um pacote bruto no Modo Plano (Big Endian)
   * 
   * Formato esperado:
   * [0..3]: PacketLength (uint32 BE)
   * [4..7]: PacketID     (uint32 BE)
   * [8..N]: Payload
   */
  public static fromBuffer(raw: Buffer | Uint8Array): DecodedPacket | null {
    const buf = Buffer.isBuffer(raw) ? raw : Buffer.from(raw);
    if (buf.length < SIZE_PACKET_HEADER) {
      return null; // Cabeçalho incompleto
    }

    const packetLength = buf.readUInt32BE(0);
    const packetId = buf.readUInt32BE(4);

    if (packetLength < SIZE_PACKET_HEADER) {
      throw new RangeError(`Packet length inválido no cabeçalho: ${packetLength} (esperado >= ${SIZE_PACKET_HEADER})`);
    }

    if (buf.length < packetLength) {
      return null; // Pacote ainda incompleto no stream
    }

    const payload = buf.subarray(SIZE_PACKET_HEADER, packetLength);
    const reader = new PacketReader(payload);

    return {
      packetLength,
      packetId,
      payload,
      reader,
    };
  }

  private ensureAvailable(count: number): void {
    if (this.offset + count > this.buffer.length) {
      throw new RangeError(
        `Buffer underflow: tentou ler ${count} bytes no offset ${this.offset}, mas o buffer possui ${this.buffer.length} bytes (disponíveis: ${this.bytesAvailable}).`
      );
    }
  }
}

/**
 * Builders utilitários de pacotes de controle de personagem e sessão
 */

export interface AccountInfoData {
  id: number;
  user_id: string;
}

export interface CharacterInfoData {
  id: number;
  account_id: number;
  name: string;
  profession: number;
  gender: number;
  level: number;
}

/**
 * Cria pacote SC_CREATECHAR_CreateCharCmd (0x01180100)
 */
export function buildCreateCharCmdPacket(): Buffer {
  const writer = new PacketWriter();
  return writer.toPacket(18350336); // PACKETID_SC_CREATECHAR_CreateCharCmd
}

/**
 * Cria pacote SC_CREATECHAR_CreateCharRet (0x01180101)
 */
export function buildCreateCharRetPacket(errorCode: number = 0): Buffer {
  const writer = new PacketWriter();
  writer.writeUnsignedInt(errorCode); // 0 = sucesso
  return writer.toPacket(18350337); // PACKETID_SC_CREATECHAR_CreateCharRet
}

export function getBaseHeroId(profession: number, gender: number = 1): number {
  if (profession === 4) return gender === 1 ? 11100001 : 11100002; // Taijutsu
  if (profession === 1) return gender === 1 ? 11100003 : 11100004; // Ninjutsu
  if (profession === 3) return gender === 1 ? 11100005 : 11100006; // Genjutsu
  return 11100003;
}

/**
 * Cria pacote SC_Account_CharInfoNtf (0x01180102)
 * Compatível com a desserialização de TUnstreamizerCharacter.as
 */
export function buildCharInfoPacket(
  char: CharacterInfoData,
  account: AccountInfoData
): Buffer {
  const writer = new PacketWriter();
  writer.writeUnsignedInt(75);            // AgentOperatorId (75 = Brazil)
  writer.writeUnsignedInt(1);             // ServerId
  writer.writeStringUTF(account.user_id); // AgentUserId
  writer.writeUnsignedInt(0);             // GuidHigh
  writer.writeUnsignedInt(char.id);       // GuidLow
  writer.writeStringUTF(char.name);       // NickName
  writer.writeUnsignedInt(0);             // Country
  writer.writeUnsignedInt(0);             // MilitaryRank
  writer.writeUnsignedInt(0);             // Prestige
  writer.writeUnsignedInt(0);             // CreditSilverCoin.High
  writer.writeUnsignedInt(10000);         // CreditSilverCoin.Low (10k moedas)
  writer.writeUnsignedInt(500);           // CreditGold (500 cupons/ouro)
  writer.writeUnsignedInt(100);           // CreditGiftCertificate
  writer.writeUnsignedInt(50);            // CreditMilitaryOrders
  writer.writeUnsignedInt(0);             // VipLevel
  writer.writeUnsignedInt(0);             // VipExp
  writer.writeUnsignedShort(40);          // BackpackCapacity
  writer.writeUnsignedByte(0);            // BackpackExpandCount
  writer.writeUnsignedInt(23200001);      // TownID (Konohagakure)
  writer.writeUnsignedInt(0);             // StarMapIndex
  writer.writeUnsignedInt(0);             // GeneralsSoul
  writer.writeUnsignedInt(0);             // HeroSoulBlueSoul
  writer.writeUnsignedInt(0);             // HeroSoulPurpleSoul
  writer.writeUnsignedInt(0);             // HeroSoulGoldSoul
  writer.writeUnsignedInt(0);             // HeroSoulOrangeSoul
  writer.writeUnsignedInt(0);             // WingID
  writer.writeUnsignedInt(0);             // SpecialJadeID
  writer.writeUnsignedInt(0);             // TransformID
  writer.writeUnsignedInt(0);             // HideWing
  writer.writeUnsignedInt(0);             // CurSoulFormationID
  writer.writeUnsignedInt(0);             // MasterRoad.IsFirst
  writer.writeUnsignedShort(0);           // BadgeList.length = 0

  // Heros list: quantidade = 1 (herói principal ativo)
  writer.writeUnsignedShort(1);           // HeroCount = 1
  const heroIdentifier = getBaseHeroId(char.profession, char.gender);
  writer.writeUnsignedInt(heroIdentifier); // Hero Identifier (11100003)
  writer.writeUnsignedInt(char.level);    // Level (1)
  writer.writeUnsignedInt(0);             // Exp High
  writer.writeUnsignedInt(0);             // Exp Low
  writer.writeUnsignedByte(char.profession);// Profession (1)
  writer.writeUnsignedByte(1);            // FightPosition (1 = em combate / montado)
  writer.writeUnsignedShort(0);           // Skills count = 0

  // Base attributes: total count = 8 (0 base + 4 first + 4 first rate)
  writer.writeUnsignedShort(8);
  // FirstAttributes (4 x uint32):
  writer.writeUnsignedInt(100);           // Power
  writer.writeUnsignedInt(100);           // Agility
  writer.writeUnsignedInt(100);           // Intellect
  writer.writeUnsignedInt(100);           // Life
  // FirstAttributesRate (4 x float):
  writer.writeFloat(1.0);                 // PowerRate
  writer.writeFloat(1.0);                 // AgilityRate
  writer.writeFloat(1.0);                 // IntellectRate
  writer.writeFloat(1.0);                 // LifeRate

  writer.writeUnsignedShort(0);           // Equipments count = 0
  writer.writeUnsignedInt(1);             // PotentialLv
  writer.writeUnsignedInt(0);             // PotentialExp
  writer.writeByte(0);                    // ExpIsInherited
  writer.writeUnsignedInt(0);             // AwakeLevel
  writer.writeUnsignedInt(0);             // AwakeSkil

  // Pet:
  writer.writeInt(-1);                    // PetID (-1 = sem pet)
  writer.writeInt(-1);                    // ImageID (-1 = sem pet, evita erro #1009)
  writer.writeUnsignedByte(0);            // PetRelax

  // FreshGuideProgress
  writer.writeStringUTF("guide_step_1");

  return writer.toPacket(18350338); // PACKETID_SC_Account_CharInfoNtf
}

export interface TownPlayerDto {
  charId: number;
  name: string;
  profession: number;
  gender?: number;
  level: number;
  x: number;
  y: number;
}

/**
 * Cria pacote SC_Enter_Town (0x01180200 / 18350592)
 */
export function buildEnterTownPacket(
  mapId: number,
  x: number,
  y: number,
  direction: number = 1
): Buffer {
  const writer = new PacketWriter();
  writer.writeUnsignedInt(mapId);   // MapID / TownID
  writer.writeUnsignedShort(x);     // X inicial
  writer.writeUnsignedShort(y);     // Y inicial
  writer.writeByte(direction);      // Direção (1 = direita)
  return writer.toPacket(18350592); // PACKETID_SC_Enter_Town
}

/**
 * Cria pacote SC_LOBBY_Town_NewRoleNtf (0x01180300 / 18350848)
 * Notifica a presença de um ou múltiplos personagens na vila
 */
export function buildTownNewRolePacket(players: TownPlayerDto[]): Buffer {
  const writer = new PacketWriter();
  writer.writeShort(players.length); // Quantidade de personagens

  for (const player of players) {
    writer.writeUnsignedInt(0);               // GuidHigh
    writer.writeUnsignedInt(player.charId);   // GuidLow (CharacterID)
    const templateId = getBaseHeroId(player.profession, player.gender ?? 1);
    writer.writeUnsignedInt(templateId);      // RoleTemplateID (BaseHero ID)
    writer.writeStringUTF(player.name);       // RoleName (FlushUTF)
    writer.writeUnsignedInt(0);               // MilitaryRank
    writer.writeUnsignedInt(player.level);    // Level
    writer.writeUnsignedInt(0);               // FamilyID
    writer.writeByte(0);                      // RelexBoo
    writer.writeUnsignedInt(40100001);        // TextureID / Modelo
    writer.writeUnsignedShort(player.x);      // MapX
    writer.writeUnsignedShort(player.y);      // MapY
    writer.writeByte(1);                      // Quality
    writer.writeUnsignedInt(0);               // NewShapeBaseHeroID
    writer.writeUnsignedInt(0);               // TitleID
    writer.writeUnsignedInt(0);               // LittlePetID
    writer.writeUnsignedInt(0);               // LittlePetID2
    writer.writeUnsignedInt(0);               // WingID
    writer.writeUnsignedInt(0);               // TransformID
    writer.writeInt(0);                       // HideWing
    writer.writeUnsignedInt(0);               // JadeID
    writer.writeShort(0);                     // BadgeCount = 0
  }

  return writer.toPacket(18350848); // PACKETID_SC_LOBBY_Town_NewRoleNtf
}

/**
 * Cria pacote SC_LOBBY_Town_RoleMove (0x01180301 / 18350849)
 * Transmite a movimentação de um personagem para as outras sessões
 */
export function buildTownRoleMovePacket(
  charId: number,
  targetX: number,
  targetY: number
): Buffer {
  const writer = new PacketWriter();
  writer.writeUnsignedInt(0);         // GuidHigh
  writer.writeUnsignedInt(charId);    // GuidLow
  writer.writeUnsignedShort(targetX); // TargetX
  writer.writeUnsignedShort(targetY); // TargetY
  return writer.toPacket(18350849);   // PACKETID_SC_LOBBY_Town_RoleMove
}

/**
 * Cria pacote SC_LOBBY_Town_RemoveRole (0x01180302 / 18350850)
 * Notifica a saída/desconexão de um personagem da vila
 */
export function buildTownRemoveRolePacket(charId: number): Buffer {
  const writer = new PacketWriter();
  writer.writeUnsignedInt(0);       // GuidHigh
  writer.writeUnsignedInt(charId);  // GuidLow
  return writer.toPacket(18350850); // PACKETID_SC_LOBBY_Town_RemoveRole
}

/**
 * Estruturas para Combate por Turnos (Logics.Battle)
 */
export interface BattleFighterData {
  pos: number;         // Posição no grid (1..15 conforme TBattleConfig)
  roleId: number;      // ID do personagem ou NPC/Monstro
  quality: number;     // Qualidade (1..5)
  level: number;       // Nível
  curHealth: number;   // Vida atual
  totalHealth: number; // Vida máxima
  curAnger: number;    // Fúria/Chakra atual (0..100)
  skillId: number;     // ID da habilidade ativa
  elementBit: number;  // Elemento (Fogo, Vento, Relâmpago, Terra, Água)
  name: string;        // Nome do combatente
}

export interface BattleTeamData {
  userId: string;
  mountsId?: number;
  mountsLevel?: number;
  soulFormationId?: number;
  emblemId?: number;
  ringId?: number;
  fighters: BattleFighterData[];
}

export interface BattleTargetResult {
  cmd: number;            // Tipo de resultado (CMD_ATTACK = 1, etc.)
  targetCamp: number;     // Camp do alvo (0 = Aliado, 1 = Inimigo)
  targetPos: number;      // Posição (1..15)
  targetStatus?: number;  // Status de efeitos (ex: atordoado)
  targetStatus1?: number;
  targetStatus2?: number;
  hurtHp?: number;        // Dano causado
  hurtAnger?: number;     // Fúria alterada
  buffId?: number;        // Buff aplicado
}

export interface BattleActionData {
  activeCamp: number;     // Camp atacante (0 ou 1)
  activePos: number;      // Posição atacante
  skillEffectId: number;  // Efeito visual do golpe
  activeType: number;     // Tipo de ataque (1 = NormalAttack, 2 = SkillAttack)
  targets: BattleTargetResult[];
}

export interface BattleTurnData {
  curTurn: number;
  actions: BattleActionData[];
}

export interface BattleReportData {
  battleIdStr?: string;
  team1: BattleTeamData;
  team2: BattleTeamData;
  turns: BattleTurnData[];
}

/**
 * Cria pacote SC_Battle_StartReportDataReq (0x01458000 / 21331968)
 * Conforme especificação de desserialização em TUnstreamizerBattleRepot.as
 */
export function buildBattleStartPacket(report: BattleReportData): Buffer {
  const writer = new PacketWriter();

  // 1. Identificador / Hash da batalha (FetchUTF)
  writer.writeStringUTF(report.battleIdStr ?? `battle_${Date.now()}`);

  // 2. Serializa Time 1 (Aliados / Player, Camp = 0)
  writeGroupRoleInfo(writer, report.team1);

  // 3. Serializa Time 2 (Inimigos / Monstros, Camp = 1)
  writeGroupRoleInfo(writer, report.team2);

  // 4. Total de Turnos (int16 BE)
  writer.writeShort(report.turns.length);

  // 5. Turnos e Ações executadas
  for (const turn of report.turns) {
    writer.writeInt(turn.curTurn); // CurTurn (int32 BE)
    writer.writeShort(turn.actions.length); // ActiveCount (int16 BE)

    for (const action of turn.actions) {
      writer.writeByte(action.activeCamp);      // ActiveCamp (int8)
      writer.writeByte(action.activePos);       // ActivePos (int8)
      writer.writeInt(action.skillEffectId);    // SkillEffectId (int32)
      writer.writeInt(action.activeType);        // ActiveType (int32)

      writer.writeShort(action.targets.length); // TargetCount (int16)
      for (const target of action.targets) {
        writer.writeByte(target.cmd);                // CMD (int8)
        writer.writeByte(target.targetCamp);         // TargetCamp (int8)
        writer.writeByte(target.targetPos);          // TargetPos (int8)
        writer.writeUnsignedInt(target.targetStatus ?? 0);  // ReportTargetStatus
        writer.writeUnsignedInt(target.targetStatus1 ?? 0); // ReportTargetStatus1
        writer.writeUnsignedInt(target.targetStatus2 ?? 0); // TargetStatus2

        // ResultInfo (baseado em CMD)
        const cmd = target.cmd;
        if (cmd === 1 || cmd === 7 || cmd === 12) { // CMD_ATTACK, CMD_ATTACKEX, CMD_HurtHp
          writer.writeFloat(target.hurtHp ?? 0);
          writer.writeInt(target.hurtAnger ?? 0);
        } else if (cmd === 3) { // CMD_HURTBUFF
          writer.writeFloat(target.hurtHp ?? 0);
          writer.writeInt(target.hurtAnger ?? 0);
          writer.writeUnsignedInt(target.buffId ?? 0);
        } else if (cmd === 4 || cmd === 2 || cmd === 13) { // CMD_CONTROLBUFF, etc.
          writer.writeUnsignedInt(target.buffId ?? 0);
          writer.writeUnsignedInt(1); // BuffTurn
        }
      }
    }
  }

  return writer.toPacket(21331968); // PACKETID_SC_Battle_StartReportDataReq
}

function writeGroupRoleInfo(writer: PacketWriter, team: BattleTeamData) {
  writer.writeInt(team.mountsId ?? 0);
  writer.writeInt(team.mountsLevel ?? 0);
  writer.writeInt(team.soulFormationId ?? 0);
  writer.writeInt(team.emblemId ?? 0);
  writer.writeInt(team.ringId ?? 0);
  writer.writeStringUTF(team.userId);

  writer.writeShort(team.fighters.length); // Quantidade de ninjas na equipe
  for (const f of team.fighters) {
    writer.writeByte(f.pos);             // Pos (1..15)
    writer.writeUnsignedInt(f.roleId);   // RoleId
    writer.writeByte(f.quality);         // Quality
    writer.writeShort(f.level);          // RoleLevel
    writer.writeFloat(f.curHealth);      // CurHealth
    writer.writeFloat(f.totalHealth);    // TotleHealth
    writer.writeInt(f.curAnger);         // CurAnger
    writer.writeInt(f.skillId);          // SkillId
    writer.writeInt(f.elementBit);       // ElementBit
    writer.writeStringUTF(f.name);       // RoleName (FetchUTF)
  }
}

/**
 * Cria pacote SC_SingleBattleResult (0x01458001 / 21331969)
 */
export function buildSingleBattleResultPacket(isWin: boolean, errorCode: number = 0): Buffer {
  const writer = new PacketWriter();
  writer.writeInt(errorCode); // ErrorCode (0 = sucesso)
  writer.writeByte(isWin ? 1 : 0); // IsWin (int8 > 0)
  // Recompensas vazias (Clear)
  writer.writeShort(0); // Item count = 0
  return writer.toPacket(21331969); // PACKETID_SC_SingleBattleResult
}
