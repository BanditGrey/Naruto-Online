import * as http from "node:http";
import * as crypto from "node:crypto";
import * as net from "node:net";
import { Socket } from "node:net";
import {
  PacketReader,
  PacketWriter,
  buildCharInfoPacket,
  buildCreateCharCmdPacket,
  buildCreateCharRetPacket,
} from "./network/packet.ts";
import { OPCODES, getOpcodeName } from "./network/opcodes.ts";
import { logPacketTraffic } from "./network/packetSniffer.ts";
import { db } from "./database/db.ts";
import type { AccountRecord, CharacterRecord } from "./database/db.ts";
import { townManager } from "./world/town.ts";
import { battleManager } from "./battle/battleManager.ts";
import { FlashAssetServer } from "./network/flashAssetServer.ts";
import { JoyfunCipher } from "./network/packetCipher.ts";

const PORT = 8080;
const WS_GUID = "258EAFA5-E914-47DA-95CA-C5AB0DC85B11";

const POLICY_XML =
  '<?xml version="1.0"?>\n' +
  '<!DOCTYPE cross-domain-policy SYSTEM "http://www.adobe.com/xml/dtds/cross-domain-policy.dtd">\n' +
  '<cross-domain-policy>\n' +
  '  <allow-access-from domain="*" to-ports="*"/>\n' +
  '</cross-domain-policy>\0';

interface ClientSession {
  socket: Socket;
  isRawTcp?: boolean;
  cipher?: JoyfunCipher;
  account?: AccountRecord;
  character?: CharacterRecord | null;
  inBattle?: boolean;
}

/**
 * Servidor Multiplexador MMO (WebSocket + TCP Raw Flash + Flash Policy)
 */
export class MmoWebSocketServer {
  private httpServer: http.Server;
  private netServer: net.Server;
  private policy843Server?: net.Server;
  private sessions: Map<Socket, ClientSession> = new Map();
  private flashAssetServer: FlashAssetServer;

  constructor(port: number) {
    this.flashAssetServer = new FlashAssetServer();

    // Configura o envio de frames para o gerenciador de vilas
    townManager.setSendFrame((socket, opcode, payload) => {
      this.sendFrame(socket, opcode, payload);
    });

    // Configura o envio de frames para o gerenciador de combates
    battleManager.setSendFrame((socket, opcode, payload) => {
      this.sendFrame(socket, opcode, payload);
    });

    this.httpServer = http.createServer((req, res) => {
      // 1. Prioridade absoluta: Flash Asset Server (Flash launcher, SWFs, XMLs, texturas, áudios)
      if (this.flashAssetServer.handleRequest(req, res)) {
        return;
      }

      // 2. Fallback: Página HTML de teste legada
      if (req.url === "/pixi" || req.url === "/legacy.html") {
        res.writeHead(200, { "Content-Type": "text/html; charset=utf-8" });
        res.end(this.getTestClientHtml());
        return;
      }
      console.log(`[HTTP 404] ${req.method} ${req.url}`);
      res.writeHead(404);
      res.end("Not Found");
    });

    this.httpServer.on("upgrade", (req, socket, head) => {
      this.handleUpgrade(req, socket as Socket, head);
    });

    // Servidor TCP Multiplexador (Flash Policy + WebSocket + Raw TCP Flash Socket)
    this.netServer = net.createServer((socket: Socket) => {
      socket.once("data", (firstChunk: Buffer) => {
        const chunkStr = firstChunk.toString("utf8");

        // 1. Handshake do Flash Socket Policy (<policy-file-request/>)
        if (chunkStr.includes("policy-file-request")) {
          const endpoint = `${socket.remoteAddress}:${socket.remotePort}`;
          console.log(`[Flash Policy] Resposta de cross-domain policy enviada para ${endpoint}`);
          socket.end(POLICY_XML);
          return;
        }

        // 2. Requisição HTTP ou Upgrade WebSocket (inicia com verbo HTTP)
        if (/^(GET|POST|HEAD|OPTIONS|PUT|DELETE)\s/i.test(chunkStr)) {
          socket.unshift(firstChunk);
          this.httpServer.emit("connection", socket);
          return;
        }

        // 3. Conexão TCP Raw do Executável Flash Oficial
        this.handleRawTcpClient(socket, firstChunk);
      });
    });

    this.netServer.listen(port, () => {
      console.log(`\n=============================================================`);
      console.log(`[MMO Server] Multiplexador TCP/WebSocket escutando em porta ${port}`);
      console.log(` - Protocolo 1: WebSocket (ws://127.0.0.1:${port}) para cliente Web PixiJS`);
      console.log(` - Protocolo 2: TCP Raw Socket para Executável Oficial Flash`);
      console.log(` - Protocolo 3: Flash Cross-Domain Policy Server integrado`);
      console.log(`[Página de Teste] http://127.0.0.1:${port}`);
      console.log(`[Banco de Dados] SQLite pronto.`);
      console.log(`[TownManager] Vila da Folha (Map #1) ativa.`);
      console.log(`[Sniffer] Tráfego gravando em docs/OFFICIAL_CLIENT_TRAFFIC.log`);
      console.log(`=============================================================\n`);
    });

    // Tenta iniciar servidor Flash Policy nativo na porta 843
    try {
      this.policy843Server = net.createServer((sock) => {
        sock.on("data", (d) => {
          if (d.toString().includes("policy-file-request")) {
            sock.write(POLICY_XML);
            sock.end();
          }
        });
      });
      this.policy843Server.on("error", () => {
        // Porta 843 requer privilégio de administrador; porta 8080 cobre o fallback
      });
      this.policy843Server.listen(843, () => {
        console.log(`[Flash Policy] Servidor nativo na porta padrão 843 ativo.`);
      });
    } catch (e) {}
  }

  public close(): Promise<void> {
    return new Promise((resolve) => {
      if (this.policy843Server) {
        try { this.policy843Server.close(); } catch (e) {}
      }
      this.netServer.close(() => {
        this.httpServer.close(() => resolve());
      });
    });
  }

  private handleRawTcpClient(socket: Socket, initialChunk?: Buffer) {
    const session: ClientSession = { socket, isRawTcp: true, cipher: new JoyfunCipher() };
    this.sessions.set(socket, session);
    const endpoint = `${socket.remoteAddress}:${socket.remotePort}`;
    console.log(`[TCP Handshake] Cliente Flash Oficial conectado: ${endpoint}`);

    let buffer = initialChunk ? initialChunk : Buffer.alloc(0);

    const processTcpBuffer = () => {
      while (buffer.length >= 4) {
        const packetLen = buffer.readUInt32BE(0);
        if (packetLen < 4 || packetLen > 10 * 1024 * 1024) {
          console.warn(`[TCP Malformed] Tamanho de pacote inválido: ${packetLen}B. Desconectando.`);
          socket.destroy();
          return;
        }
        if (buffer.length < packetLen) {
          break; // Aguarda mais bytes
        }

        const rawPacket = buffer.subarray(0, packetLen);
        buffer = buffer.subarray(packetLen);

        // Sniffer registra pacote criptografado original recebido do cliente oficial
        logPacketTraffic("RECV", "TCP", rawPacket, endpoint);

        // Decodifica pacote usando JoyfunCipher
        const payload = rawPacket.subarray(4);
        try {
          const decrypted = session.cipher!.decryptClientPacket(payload);
          const opcodeName = getOpcodeName(decrypted.packetId);
          console.log(`[TCP Decrypt OK] Opcode: 0x${decrypted.packetId.toString(16)} (${opcodeName}) | Payload: ${decrypted.data.length}B`);

          // Monta pacote padrão [4 bytes BE length][4 bytes BE packetId][data...]
          const stdPacket = Buffer.alloc(8 + decrypted.data.length);
          stdPacket.writeUInt32BE(stdPacket.length, 0);
          stdPacket.writeUInt32BE(decrypted.packetId, 4);
          decrypted.data.copy(stdPacket, 8);

          this.onBinaryMessage(session, stdPacket);
        } catch (err: any) {
          console.error(`[TCP Cipher Decrypt Error ${endpoint}]`, err.message);
        }
      }
    };

    if (buffer.length > 0) {
      processTcpBuffer();
    }

    socket.on("data", (chunk: Buffer) => {
      buffer = Buffer.concat([buffer, chunk]);
      processTcpBuffer();
    });

    socket.on("close", () => {
      townManager.removeBySocket(socket);
      battleManager.removeBySocket(socket);
      this.sessions.delete(socket);
      console.log(`[TCP Desconexão] Cliente Flash Oficial desconectado (${endpoint}).`);
    });

    socket.on("error", (err) => {
      console.error(`[TCP Socket Error ${endpoint}]`, err.message);
    });
  }

  private handleUpgrade(req: http.IncomingMessage, socket: Socket, head: Buffer) {
    const key = req.headers["sec-websocket-key"];
    if (!key) {
      socket.destroy();
      return;
    }

    const acceptKey = crypto
      .createHash("sha1")
      .update(key + WS_GUID)
      .digest("base64");

    const responseHeaders = [
      "HTTP/1.1 101 Switching Protocols",
      "Upgrade: websocket",
      "Connection: Upgrade",
      `Sec-WebSocket-Accept: ${acceptKey}`,
      "\r\n",
    ].join("\r\n");

    socket.write(responseHeaders);

    const session: ClientSession = { socket };
    this.sessions.set(socket, session);
    console.log(`[Handshake] Cliente conectado: ${socket.remoteAddress}:${socket.remotePort}`);

    let buffer = Buffer.alloc(0);

    socket.on("data", (chunk: Buffer) => {
      buffer = Buffer.concat([buffer, chunk]);
      buffer = this.processFrames(buffer, socket, session);
    });

    socket.on("close", () => {
      townManager.removeBySocket(socket);
      battleManager.removeBySocket(socket);
      this.sessions.delete(socket);
      console.log(`[Desconexão] Cliente desconectado e removido do TownManager e BattleManager.`);
    });

    socket.on("error", (err) => {
      console.error(`[Socket Error]`, err.message);
    });
  }

  private processFrames(buffer: Buffer, socket: Socket, session: ClientSession): Buffer {
    while (buffer.length >= 2) {
      const firstByte = buffer[0];
      const secondByte = buffer[1];

      const fin = (firstByte & 0x80) !== 0;
      const opcode = firstByte & 0x0f;
      const isMasked = (secondByte & 0x80) !== 0;
      let payloadLen = secondByte & 0x7f;
      let offset = 2;

      if (payloadLen === 126) {
        if (buffer.length < 4) return buffer;
        payloadLen = buffer.readUInt16BE(offset);
        offset += 2;
      } else if (payloadLen === 127) {
        if (buffer.length < 10) return buffer;
        payloadLen = Number(buffer.readBigUInt64BE(offset));
        offset += 8;
      }

      let maskKey: Buffer | null = null;
      if (isMasked) {
        if (buffer.length < offset + 4) return buffer;
        maskKey = buffer.subarray(offset, offset + 4);
        offset += 4;
      }

      if (buffer.length < offset + payloadLen) {
        return buffer;
      }

      let payload = buffer.subarray(offset, offset + payloadLen);
      buffer = buffer.subarray(offset + payloadLen);

      if (isMasked && maskKey) {
        const unmasked = Buffer.allocUnsafe(payload.length);
        for (let i = 0; i < payload.length; i++) {
          unmasked[i] = payload[i] ^ maskKey[i % 4];
        }
        payload = unmasked;
      }

      if (opcode === 0x08) {
        socket.end();
        return buffer;
      } else if (opcode === 0x09) {
        this.sendFrame(socket, 0x0a, payload);
      } else if (opcode === 0x02 || opcode === 0x01) {
        const endpoint = `${socket.remoteAddress}:${socket.remotePort}`;
        logPacketTraffic("RECV", "WS", payload, endpoint);
        this.onBinaryMessage(session, payload);
      }
    }
    return buffer;
  }

  private onBinaryMessage(session: ClientSession, rawBytes: Buffer) {
    const socket = session.socket;
    console.log(`\n-------------------------------------------------------------`);
    console.log(`[Bytes Recebidos] Total: ${rawBytes.length}B | Hex: ${rawBytes.toString("hex").toUpperCase()}`);

    try {
      const packet = PacketReader.fromBuffer(rawBytes);
      if (!packet) {
        console.warn(`[Aviso] Dados insuficientes para o cabeçalho.`);
        return;
      }

      const { packetId, packetLength, reader } = packet;
      const opcodeName = getOpcodeName(packetId);

      console.log(`[Pacote Decodificado] Opcode: ${packetId} (${opcodeName}) | Tamanho: ${packetLength}B`);

      switch (packetId) {
        case OPCODES.CS_Login_StatusServerTransmitToken:
        case OPCODES.CS_Login_GateServerTransmitToken: {
          this.handleLogin(session, reader, packetId);
          break;
        }

        case OPCODES.CS_CREATECHAR_CreateChar: {
          this.handleCreateChar(session, reader);
          break;
        }

        case OPCODES.CS_Account_CharBaseAttributeReq: {
          this.handleCharBaseAttributeReq(session, reader);
          break;
        }

        case OPCODES.CS_LOBBY_Enter_Town: {
          this.handleEnterTown(session, reader);
          break;
        }

        case OPCODES.CS_LOBBY_Town_Move: {
          this.handleTownMove(session, reader);
          break;
        }

        case OPCODES.CS_BattleStart: {
          this.handleBattleStart(session, reader);
          break;
        }

        case OPCODES.CS_Backpack_LoadBag: {
          this.handleBackpackLoad(session, reader);
          break;
        }

        case OPCODES.CS_Backpack_UseAppliance: {
          this.handleBackpackUse(session, reader);
          break;
        }

        case OPCODES.CS_Backpack_SellItem: {
          this.handleBackpackSell(session, reader);
          break;
        }

        case OPCODES.CS_Enter_Tavern: {
          this.handleEnterTavern(session, reader);
          break;
        }

        case OPCODES.CS_TavernMoraReq: {
          this.handleTavernMora(session, reader);
          break;
        }

        case OPCODES.CS_TavernRecruitReq: {
          this.handleTavernRecruit(session, reader);
          break;
        }

        case OPCODES.CS_Equip_EnhanceReq: {
          this.handleEquipEnhance(session, reader);
          break;
        }

        case OPCODES.CS_TacticalDeployment_ChangePositionReq: {
          this.handleTacticalDeployment(session, reader);
          break;
        }

        case OPCODES.CS_Enter_Hurdle: {
          this.handleEnterHurdle(session, reader);
          break;
        }

        case OPCODES.KeepAliveAck: {
          console.log(`[Heartbeat] KeepAliveAck recebido do cliente.`);
          break;
        }

        default: {
          console.log(`[Handler Genérico] Opcode ${packetId} recebido (não tratado especificamente).`);
          break;
        }
      }
    } catch (err: any) {
      console.error(`[Erro de Processamento]: ${err.message}`);
    }
  }

  /**
   * 1. Handshake de Login
   */
  private handleLogin(session: ClientSession, reader: PacketReader, packetId?: number) {
    const userId = reader.readStringUTF();
    const agentId = reader.readUnsignedInt();
    const serverId = reader.readUnsignedInt();
    const token = reader.readStringUTF();
    const version = reader.readUnsignedInt();
    const loginTime = reader.readStringUTF();

    console.log(`[Login / Autenticação] Opcode: 0x${(packetId ?? 0).toString(16)} | User: "${userId}", ServerID: ${serverId}, Versão: ${version}`);

    const account = db.getOrCreateAccount(userId, token);
    session.account = account;
    console.log(`  -> Conta vinculada no DB: ID #${account.id} (${account.user_id})`);

    // Se for StatusServerTransmitToken, apenas envia confirmação com endereço do GateServer (127.0.0.1:8080)
    // O cliente Flash oficial fecha esta conexão após receber o despacho e abre uma nova conexão GateServer
    if (packetId === OPCODES.CS_Login_StatusServerTransmitToken) {
      console.log(`  -> [StatusServer] Despachando para GateServer 127.0.0.1:${PORT}...`);
      this.sendSessionConfirmation(session.socket);
      return;
    }

    // Se for GateServerTransmitToken (ou conexão WebSocket direta):
    const character = db.getCharacterByAccountId(account.id);
    session.character = character;

    if (character) {
      db.ensureCharacterDefaults(character.id, character.name, character.profession, character.gender);
      console.log(`  -> Personagem existente: "${character.name}" (ID #${character.id}, Nv. ${character.level})`);
      console.log(`  -> Enviando SC_Account_CharInfoNtf (0x01180102)...`);
      const charInfoPacket = buildCharInfoPacket(character, account);
      this.sendFrame(session.socket, 0x02, charInfoPacket);

      console.log(`  -> [Auto-Spawn] Enviando SC_Enter_Town (0x01180200) para "${character.name}" na Vila da Folha...`);
      townManager.addPlayer(
        character.id,
        character.name,
        character.profession,
        character.gender,
        character.level,
        session.socket,
        23200001,
        1800,
        900
      );
    } else {
      console.log(`  -> Nenhum personagem para a conta #${account.id}. Enviando SC_CREATECHAR_CreateCharCmd...`);
      const createCmdPacket = buildCreateCharCmdPacket();
      this.sendFrame(session.socket, 0x02, createCmdPacket);
    }
  }

  /**
   * 2. Criação de Personagem
   */
  private handleCreateChar(session: ClientSession, reader: PacketReader) {
    const charName = reader.readStringUTF();
    const profession = reader.readUnsignedByte();
    const gender = reader.readUnsignedByte();

    console.log(`[Criação de Personagem] Nome: "${charName}", Profissão: ${profession}, Gênero: ${gender}`);

    if (!session.account) {
      console.error(`[Erro] Sem conta autenticada.`);
      this.sendFrame(session.socket, 0x02, buildCreateCharRetPacket(1));
      return;
    }

    const existing = db.getCharacterByName(charName);
    if (existing) {
      console.warn(`[Aviso] Nome "${charName}" já em uso.`);
      this.sendFrame(session.socket, 0x02, buildCreateCharRetPacket(2));
      return;
    }

    const newChar = db.createCharacter(session.account.id, charName, profession, gender);
    session.character = newChar;
    console.log(`  -> Salvo no DB: ID #${newChar.id}`);

    this.sendFrame(session.socket, 0x02, buildCreateCharRetPacket(0));
    this.sendFrame(session.socket, 0x02, buildCharInfoPacket(newChar, session.account));
  }

  /**
   * 3. Consulta de Atributos
   */
  private handleCharBaseAttributeReq(session: ClientSession, reader: PacketReader) {
    if (!session.account) return;
    const character = session.character ?? db.getCharacterByAccountId(session.account.id);
    if (!character) return;

    console.log(`[Atributos] Enviando SC_Account_CharInfoNtf para "${character.name}"`);
    const packet = buildCharInfoPacket(character, session.account);
    this.sendFrame(session.socket, 0x02, packet);
  }

  /**
   * 4. Entrada na Vila (CS_LOBBY_Enter_Town - 0x01810200)
   */
   private handleEnterTown(session: ClientSession, reader: PacketReader) {
    let mapId = 23200001; // 23200001 = Vila da Folha (Canônico)
    if (reader.bytesAvailable >= 4) {
      const requestedId = reader.readUnsignedInt();
      if (requestedId === 23100001 || requestedId === 23200001 || requestedId > 10000) {
        mapId = requestedId;
      }
    }

    if (!session.account) {
      console.error(`[Erro] Tentativa de entrar na vila sem autenticação.`);
      return;
    }

    const character = session.character ?? db.getCharacterByAccountId(session.account.id);
    if (!character) {
      console.error(`[Erro] Conta sem personagem para entrar na vila.`);
      return;
    }
    session.character = character;
    session.inBattle = false;

    const townName = mapId === 23100001 ? "Subúrbio dos Principiantes" : "Aldeia da Folha (Konohagakure)";
    console.log(`[Entrada na Vila - CS_LOBBY_Enter_Town]`);
    console.log(`  -> Personagem: "${character.name}" (ID #${character.id})`);
    console.log(`  -> Mapa solicitado: #${mapId} (${townName})`);

    const initialX = 1200;
    const initialY = 500;

    const player = townManager.addPlayer(
      character.id,
      character.name,
      character.profession,
      character.gender,
      character.level,
      session.socket,
      mapId,
      initialX,
      initialY
    );

    console.log(`  -> Spawn em (X: ${player.x}, Y: ${player.y})`);
    console.log(`  -> Jogadores agora na vila: ${townManager.getAllPlayersInMap(mapId).length}`);
  }

  /**
   * Fortalecimento de Equipamento na Forja (CS_Equip_EnhanceReq)
   */
  private handleEquipEnhance(session: ClientSession, reader: PacketReader) {
    let slotIndex = 0;
    if (reader.bytesAvailable >= 4) {
      slotIndex = reader.readUnsignedInt();
    }
    const character = session.character;
    if (!character) return;

    console.log(`[Forja / Smithy - CS_Equip_EnhanceReq]`);
    console.log(`  -> Personagem "${character.name}" fortificou equipamento no slot #${slotIndex}`);

    const writer = new PacketWriter(OPCODES.SC_Equip_EnhanceRet);
    writer.writeUnsignedInt(0); // ErrorCode 0 = Sucesso
    writer.writeUnsignedInt(slotIndex);
    this.sendFrame(session.socket, 0x02, writer.toBuffer());
  }

  /**
   * 5. Movimentação na Vila (CS_LOBBY_Town_Move - 0x01810300)
   */
  private handleTownMove(session: ClientSession, reader: PacketReader) {
    if (reader.bytesAvailable < 4) {
      console.warn(`[Aviso] Pacote de movimento incompleto.`);
      return;
    }

    const targetX = reader.readShort();
    const targetY = reader.readShort();
    const character = session.character;

    if (!character) {
      console.warn(`[Aviso] Movimento de sessão sem personagem ativo.`);
      return;
    }

    console.log(`[Movimento na Vila - CS_LOBBY_Town_Move]`);
    console.log(`  -> Ninja: "${character.name}" (#${character.id}) -> Nova posição: (${targetX}, ${targetY})`);

    const ok = townManager.movePlayer(character.id, targetX, targetY);
    if (ok) {
      console.log(`  -> Broadcast SC_LOBBY_Town_RoleMove propagado aos outros ninjas na vila.`);
    }
  }

  /**
   * 6. Início de Combate por Turnos (CS_BattleStart - 0x01548000)
   */
  private handleBattleStart(session: ClientSession, reader: PacketReader) {
    const character = session.character;
    if (!character) {
      console.warn(`[Aviso] Requisição de batalha sem personagem ativo.`);
      return;
    }

    let monsterGroupId = 1;
    if (reader.bytesAvailable >= 2) {
      monsterGroupId = reader.readShort();
    }

    console.log(`[Início de Batalha - CS_BattleStart]`);
    console.log(`  -> Combatente: "${character.name}" (#${character.id}, Nv. ${character.level})`);
    console.log(`  -> Desafiando Grupo de Monstros: #${monsterGroupId}`);

    // Marca que a sessão está em combate
    session.inBattle = true;

    // Remove temporariamente o ninja da visão do mapa (ele entrou na arena de batalha)
    townManager.removePlayer(character.id);

    // Inicia a sessão de batalha e envia o pacote de relatório completo (SC_Battle_StartReportDataReq)
    const battle = battleManager.startPveBattle(
      character.id,
      character.name,
      character.profession,
      character.level,
      monsterGroupId,
      session.socket
    );

    console.log(`  -> Sessão de batalha criada: ${battle.battleId}`);
    console.log(`  -> SC_Battle_StartReportDataReq transmitido com sucesso (3 turnos simulados).`);
  }

  /**
   * 7. Carga da Mochila e Equipamentos (CS_Backpack_LoadBag)
   */
  private handleBackpackLoad(session: ClientSession, _reader: PacketReader) {
    const character = session.character;
    if (!character) return;

    db.ensureCharacterDefaults(character.id, character.name, character.profession, character.gender);
    const items = db.getInventory(character.id);
    const currency = db.getCurrency(character.id);

    const writer = new PacketWriter();
    writer.writeStringUTF(JSON.stringify({ items, currency }));
    const packet = writer.toPacket(OPCODES.SC_Backpack_InventoryNtf);
    this.sendFrame(session.socket, 0x02, packet);
    console.log(`[Backpack] SC_Backpack_InventoryNtf enviado para "${character.name}" (${items.length} itens).`);
  }

  /**
   * 8. Uso / Equipar de Item (CS_Backpack_UseAppliance)
   */
  private handleBackpackUse(session: ClientSession, reader: PacketReader) {
    const character = session.character;
    if (!character) return;

    const slotIndex = reader.readShort();
    console.log(`[BackpackUse] Slot ${slotIndex} acionado por "${character.name}"`);
    const res = db.useOrEquipItem(character.id, slotIndex);
    const currency = db.getCurrency(character.id);

    const writer = new PacketWriter();
    writer.writeStringUTF(JSON.stringify({ items: res.items, currency, message: res.message }));
    const packet = writer.toPacket(OPCODES.SC_Backpack_InventoryNtf);
    this.sendFrame(session.socket, 0x02, packet);
  }

  /**
   * 9. Venda de Item por Ryo (CS_Backpack_SellItem)
   */
  private handleBackpackSell(session: ClientSession, reader: PacketReader) {
    const character = session.character;
    if (!character) return;

    const slotIndex = reader.readShort();
    console.log(`[BackpackSell] Slot ${slotIndex} vendido por "${character.name}"`);
    const res = db.sellItem(character.id, slotIndex);

    const writer = new PacketWriter();
    writer.writeStringUTF(JSON.stringify({ items: res.items, currency: res.currency, message: `Vendido com sucesso por +${res.ryoGained} Ryo!` }));
    const packet = writer.toPacket(OPCODES.SC_Backpack_InventoryNtf);
    this.sendFrame(session.socket, 0x02, packet);
  }

  /**
   * 10. Entrada na Taverna Ninja (CS_Enter_Tavern)
   */
  private handleEnterTavern(session: ClientSession, _reader: PacketReader) {
    const character = session.character;
    if (!character) return;

    db.ensureCharacterDefaults(character.id, character.name, character.profession, character.gender);
    const team = db.getTeam(character.id);
    const currency = db.getCurrency(character.id);

    const writer = new PacketWriter();
    writer.writeStringUTF(JSON.stringify({ team, currency }));
    const packet = writer.toPacket(OPCODES.SC_Enter_Tavern);
    this.sendFrame(session.socket, 0x02, packet);
    console.log(`[Tavern] SC_Enter_Tavern enviado para "${character.name}" (${team.length} ninjas recrutados).`);
  }

  /**
   * 11. Mini-game Mora / Jokenpô na Taverna (CS_TavernMoraReq)
   */
  private handleTavernMora(session: ClientSession, reader: PacketReader) {
    const character = session.character;
    if (!character) return;

    const clientChoice = reader.readUnsignedByte();
    const moraRes = db.playMora(character.id, clientChoice);
    console.log(`[TavernMora] "${character.name}" jogou ${clientChoice} -> Servidor: ${moraRes.serverChoice} (${moraRes.result}) +${moraRes.soulsAwarded} Almas`);

    const writer = new PacketWriter();
    writer.writeStringUTF(JSON.stringify(moraRes));
    const packet = writer.toPacket(OPCODES.SC_TavernMoraRet);
    this.sendFrame(session.socket, 0x02, packet);
  }

  /**
   * 12. Recrutamento de Shinobi na Taverna (CS_TavernRecruitReq)
   */
  private handleTavernRecruit(session: ClientSession, reader: PacketReader) {
    const character = session.character;
    if (!character) return;

    const heroId = reader.readInt();
    console.log(`[TavernRecruit] "${character.name}" tentando recrutar Ninja #${heroId}`);
    const res = db.recruitNinja(character.id, heroId);

    const writer = new PacketWriter();
    writer.writeStringUTF(JSON.stringify(res));
    const packet = writer.toPacket(OPCODES.SC_TavernRecruitRet);
    this.sendFrame(session.socket, 0x02, packet);
  }

  /**
   * 13. Formação Tática 3x3 (CS_TacticalDeployment_ChangePositionReq)
   */
  private handleTacticalDeployment(session: ClientSession, reader: PacketReader) {
    const character = session.character;
    if (!character) return;

    const heroId = reader.readInt();
    const newPos = reader.readUnsignedByte();
    console.log(`[Formation] "${character.name}" alterou Ninja #${heroId} para posição ${newPos}`);
    const team = db.updateFormationPos(character.id, heroId, newPos);

    const writer = new PacketWriter();
    writer.writeStringUTF(JSON.stringify({ team }));
    const packet = writer.toPacket(OPCODES.SC_TacticalDeploymentChangePositonRet);
    this.sendFrame(session.socket, 0x02, packet);
  }

  /**
   * 14. Campanha e Instâncias PvE (CS_Enter_Hurdle)
   */
  private handleEnterHurdle(session: ClientSession, _reader: PacketReader) {
    const character = session.character;
    if (!character) return;

    const currency = db.getCurrency(character.id);
    const writer = new PacketWriter();
    writer.writeStringUTF(JSON.stringify({ currentStage: currency.campaign_stage }));
    const packet = writer.toPacket(OPCODES.SC_Enter_Hurdle);
    this.sendFrame(session.socket, 0x02, packet);
    console.log(`[Campaign] SC_Enter_Hurdle enviado para "${character.name}" (Estágio Atual: ${currency.campaign_stage}).`);
  }

  /**
   * 15. Forja de Equipamentos - Deus dos Artesãos (CS_Equip_EnhanceReq)
   */
  private handleEquipEnhance(session: ClientSession, reader: PacketReader) {
    const character = session.character;
    if (!character) return;

    const slotIndex = reader.readUnsignedInt();
    console.log(`[SmithyEnhance] "${character.name}" aprimorando equipamento no Slot #${slotIndex}`);

    const currency = db.getCurrency(character.id);
    const upgradeCost = 1500 + slotIndex * 200;

    let success = true;
    let msg = '';
    const newLevel = 2;

    if (currency.ryo < upgradeCost) {
      success = false;
      msg = 'Ryo insuficiente para forjar este equipamento!';
    } else {
      db.updateCurrency(character.id, { ryo: currency.ryo - upgradeCost });
      msg = `Equipamento no Slot #${slotIndex} fortalecido com sucesso! (+1)`;
    }

    const updatedCurrency = db.getCurrency(character.id);
    const res = {
      success,
      slotIndex,
      level: newLevel,
      msg,
      currency: updatedCurrency,
    };

    const writer = new PacketWriter();
    writer.writeStringUTF(JSON.stringify(res));
    const packet = writer.toPacket(OPCODES.SC_Equip_EnhanceRet);
    this.sendFrame(session.socket, 0x02, packet);
  }

  private sendSessionConfirmation(socket: Socket) {
    const writer = new PacketWriter();
    writer.writeUnsignedInt(0); // ErrorCode = 0
    writer.writeByte(127);      // Gate IP 127.0.0.1
    writer.writeByte(0);
    writer.writeByte(0);
    writer.writeByte(1);
    writer.writeUnsignedShort(PORT);

    const packet = writer.toPacket(OPCODES.SC_Login_StatusServerTransmitTokenRet);
    this.sendFrame(socket, 0x02, packet);
  }

  private sendFrame(socket: Socket, opcode: number, payload: Buffer) {
    const session = this.sessions.get(socket);
    const endpoint = `${socket.remoteAddress}:${socket.remotePort}`;

    if (session?.isRawTcp) {
      if (session.cipher) {
        // Encripta pacote usando a cifra Joyfun reversa do ActionScript 3
        const packetId = payload.readUInt32BE(4);
        const data = payload.subarray(8);
        const wireBytes = session.cipher.encryptServerPacket(packetId, data);
        const opcodeName = getOpcodeName(packetId);
        console.log(`[TCP Encrypt SEND] Opcode: 0x${packetId.toString(16)} (${opcodeName}) | WireLen: ${wireBytes.length}B`);
        logPacketTraffic("SEND", "TCP", wireBytes, endpoint);
        socket.write(wireBytes);
        return;
      }
      // Fallback sem cifra (caso cliente sem encriptação conecte)
      logPacketTraffic("SEND", "TCP", payload, endpoint);
      socket.write(payload);
      return;
    }

    // Cliente Web PixiJS recebe frame encapsulado WebSocket
    logPacketTraffic("SEND", "WS", payload, endpoint);
    const payloadLen = payload.length;
    let header: Buffer;

    if (payloadLen <= 125) {
      header = Buffer.alloc(2);
      header[0] = 0x80 | (opcode & 0x0f);
      header[1] = payloadLen;
    } else if (payloadLen <= 65535) {
      header = Buffer.alloc(4);
      header[0] = 0x80 | (opcode & 0x0f);
      header[1] = 126;
      header.writeUInt16BE(payloadLen, 2);
    } else {
      header = Buffer.alloc(10);
      header[0] = 0x80 | (opcode & 0x0f);
      header[1] = 127;
      header.writeBigUInt64BE(BigInt(payloadLen), 2);
    }

    socket.write(Buffer.concat([header, payload]));
  }

  private getTestClientHtml(): string {
    return `<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8">
  <title>Painel MMO - Vila da Folha & Movimentação</title>
  <style>
    body { font-family: sans-serif; max-width: 900px; margin: 25px auto; line-height: 1.5; background: #0f172a; color: #f1f5f9; padding: 0 20px; }
    h1 { color: #38bdf8; margin-bottom: 5px; }
    .subtitle { color: #94a3b8; margin-top: 0; }
    .card { background: #1e293b; padding: 18px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.3); margin-bottom: 18px; border: 1px solid #334155; }
    button { background: #0284c7; color: white; border: none; padding: 9px 15px; border-radius: 6px; cursor: pointer; font-size: 13px; font-weight: bold; margin-right: 6px; margin-bottom: 6px; }
    button:hover:not(:disabled) { background: #0369a1; }
    button:disabled { background: #475569; cursor: not-allowed; opacity: 0.6; }
    #log { background: #020617; color: #38bdf8; padding: 12px; border-radius: 6px; height: 320px; overflow-y: auto; font-family: monospace; font-size: 12px; white-space: pre-wrap; border: 1px solid #1e293b; }
    .badge { display: inline-block; padding: 2px 8px; border-radius: 4px; font-weight: bold; font-size: 11px; }
    .badge-ok { background: #14532d; color: #86efac; }
    .badge-off { background: #7f1d1d; color: #fca5a5; }
    input, select { background: #0f172a; color: #f8fafc; padding: 7px 10px; border: 1px solid #475569; border-radius: 6px; margin-right: 6px; font-size: 13px; }
    .grid { display: grid; grid-template-columns: 1fr 1fr; gap: 15px; }
    .player-box { background: #0f172a; padding: 10px; border-radius: 6px; border: 1px solid #334155; margin-top: 5px; font-size: 13px; }
  </style>
</head>
<body>
  <h1>MMO Naruto Online — Vila da Folha</h1>
  <p class="subtitle">Instância de Vila, Sincronização e Movimentação em Tempo Real</p>

  <div class="card">
    <div>
      Status: <span id="status" class="badge badge-off">Desconectado</span>
      <span style="margin-left: 20px;">Posição Atual: <b id="lblPos" style="color: #4ade80;">(Fora do Mapa)</b></span>
    </div>
    <div style="margin-top: 12px;">
      <input type="text" id="inpUser" value="ninja_1" style="width: 110px;" />
      <button id="btnConnect" onclick="connect()">1. Conectar e Logar</button>
      <input type="text" id="inpCharName" value="Naruto" style="width: 110px;" />
      <button id="btnCreate" onclick="sendCreateChar()" disabled>2. Criar Char</button>
      <button id="btnEnterTown" onclick="sendEnterTown()" disabled>3. Entrar na Vila (CS_LOBBY_Enter_Town)</button>
      <button id="btnBattle" onclick="sendBattleStart(1)" disabled style="background:#dc2626;">⚔️ 4. Iniciar Batalha PvE (CS_BattleStart)</button>
    </div>
    <div style="margin-top: 10px; padding-top: 10px; border-top: 1px solid #334155;">
      <span>Mover para:</span>
      <button onclick="sendMove(1300, 850)" disabled class="btnMove">Destino A (1300, 850)</button>
      <button onclick="sendMove(1450, 780)" disabled class="btnMove">Destino B (1450, 780)</button>
      <button onclick="sendMove(1200, 800)" disabled class="btnMove">Portão Principal (1200, 800)</button>
    </div>
  </div>

  <div class="grid">
    <div class="card">
      <h3 style="margin-top:0; color:#cbd5e1;">Jogadores Visíveis na Vila:</h3>
      <div id="playersList" style="min-height: 100px;">Nenhum outro jogador próximo.</div>
    </div>
    <div class="card">
      <h3 style="margin-top:0; color:#cbd5e1;">Console de Pacotes:</h3>
      <div id="log"></div>
    </div>
  </div>

  <script>
    let ws = null;
    let myCharId = 0;
    let otherPlayers = new Map();
    const logEl = document.getElementById('log');
    const statusEl = document.getElementById('status');
    const lblPos = document.getElementById('lblPos');
    const btnCreate = document.getElementById('btnCreate');
    const btnEnterTown = document.getElementById('btnEnterTown');
    const moveButtons = document.querySelectorAll('.btnMove');
    const playersListEl = document.getElementById('playersList');

    function log(msg) {
      logEl.textContent += msg + "\\n";
      logEl.scrollTop = logEl.scrollHeight;
    }

    function renderPlayers() {
      if (otherPlayers.size === 0) {
        playersListEl.innerHTML = "<i>Nenhum outro jogador visível na vila.</i>";
        return;
      }
      let html = "";
      for (const [id, p] of otherPlayers) {
        html += "<div class='player-box'>🥷 <b>" + p.name + "</b> (ID #" + id + ") — Pos: (" + p.x + ", " + p.y + ")</div>";
      }
      playersListEl.innerHTML = html;
    }

    function connect() {
      const user = document.getElementById('inpUser').value.trim() || "ninja_1";
      const url = "ws://" + window.location.host;
      log("[WS] Conectando a " + url + " como '" + user + "'...");
      ws = new WebSocket(url);
      ws.binaryType = "arraybuffer";

      ws.onopen = () => {
        statusEl.textContent = "Conectado";
        statusEl.className = "badge badge-ok";
        sendLogin(user);
      };

      ws.onclose = () => {
        statusEl.textContent = "Desconectado";
        statusEl.className = "badge badge-off";
        btnCreate.disabled = true;
        btnEnterTown.disabled = true;
        moveButtons.forEach(b => b.disabled = true);
        otherPlayers.clear();
        renderPlayers();
        log("[WS] Conexão encerrada.");
      };

      ws.onmessage = (event) => {
        if (!(event.data instanceof ArrayBuffer)) return;
        const view = new DataView(event.data);
        const packetLen = view.getUint32(0, false);
        const packetId = view.getUint32(4, false);

        if (packetId === 18350080) { // SC_Login_StatusServerTransmitTokenRet
          log("[Recv] SC_Login_StatusServerTransmitTokenRet");
        } else if (packetId === 18350336) { // SC_CREATECHAR_CreateCharCmd
          log("[Recv] SC_CREATECHAR_CreateCharCmd -> Conta nova, crie um personagem!");
          btnCreate.disabled = false;
        } else if (packetId === 18350337) { // SC_CREATECHAR_CreateCharRet
          log("[Recv] SC_CREATECHAR_CreateCharRet -> Personagem criado!");
          btnCreate.disabled = true;
        } else if (packetId === 18350338) { // SC_Account_CharInfoNtf
          let offset = 8 + 4 + 4;
          const uLen = view.getUint32(offset, false); offset += 4 + uLen;
          offset += 4; // guidHigh
          myCharId = view.getUint32(offset, false); offset += 4;
          const nLen = view.getUint32(offset, false); offset += 4;
          const name = new TextDecoder().decode(new Uint8Array(event.data, offset, nLen));
          log("[Recv] SC_Account_CharInfoNtf: Char '" + name + "' (ID #" + myCharId + ")");
          btnEnterTown.disabled = false;
        } else if (packetId === 18350592) { // SC_Enter_Town
          const mapId = view.getUint32(8, false);
          const x = view.getUint16(12, false);
          const y = view.getUint16(14, false);
          lblPos.textContent = "Vila #" + mapId + " (" + x + ", " + y + ")";
          log("[Recv] SC_Enter_Town! Entrou no Mapa #" + mapId + " em (" + x + ", " + y + ")");
          moveButtons.forEach(b => b.disabled = false);
          if (document.getElementById('btnBattle')) {
            document.getElementById('btnBattle').disabled = false;
          }
        } else if (packetId === 18350848) { // SC_LOBBY_Town_NewRoleNtf
          const count = view.getInt16(8, false);
          log("[Recv] SC_LOBBY_Town_NewRoleNtf: " + count + " jogador(es) no mapa!");
          let offset = 10;
          for (let i = 0; i < count; i++) {
            offset += 4; // guidHigh
            const cId = view.getUint32(offset, false); offset += 4;
            const prof = view.getUint32(offset, false); offset += 4;
            const strLen = view.getUint32(offset, false); offset += 4;
            const pName = new TextDecoder().decode(new Uint8Array(event.data, offset, strLen)); offset += strLen;
            offset += 4 + 4 + 4 + 1 + 4; // rank, lvl, fam, relex, texture
            const pX = view.getUint16(offset, false); offset += 2;
            const pY = view.getUint16(offset, false); offset += 2;
            offset += 1 + 4 + 4 + 4 + 4 + 4 + 4 + 4 + 4 + 2; // remaining

            if (cId !== myCharId) {
              otherPlayers.set(cId, { name: pName, x: pX, y: pY });
            }
          }
          renderPlayers();
        } else if (packetId === 18350849) { // SC_LOBBY_Town_RoleMove
          const cId = view.getUint32(12, false);
          const newX = view.getUint16(16, false);
          const newY = view.getUint16(18, false);
          log("[Recv] SC_LOBBY_Town_RoleMove: Ninja #" + cId + " moveu para (" + newX + ", " + newY + ")");
          if (otherPlayers.has(cId)) {
            const p = otherPlayers.get(cId);
            p.x = newX; p.y = newY;
            renderPlayers();
          }
        } else if (packetId === 18350850) { // SC_LOBBY_Town_RemoveRole
          const cId = view.getUint32(12, false);
          log("[Recv] SC_LOBBY_Town_RemoveRole: Ninja #" + cId + " saiu da vila.");
          otherPlayers.delete(cId);
          renderPlayers();
        } else if (packetId === 21331968) { // SC_Battle_StartReportDataReq
          lblPos.textContent = "⚔️ EM COMBATE (Arena PVE)";
          log("[Recv] ⚔️ SC_Battle_StartReportDataReq! Batalha por turnos iniciada!");
          log("  -> Dados da arena e combatentes recebidos. Relatório de turnos carregado.");
        }
      };
    }

    function sendLogin(user) {
      const enc = new TextEncoder();
      const u = enc.encode(user);
      const t = enc.encode("tok");
      const l = enc.encode("now");
      const len = 8 + (4+u.length) + 4 + 4 + (4+t.length) + 4 + (4+l.length);
      const buf = new ArrayBuffer(len);
      const v = new DataView(buf);
      v.setUint32(0, len, false); v.setUint32(4, 25231360, false);
      let o = 8;
      v.setUint32(o, u.length, false); o += 4; new Uint8Array(buf, o, u.length).set(u); o += u.length;
      v.setUint32(o, 1001, false); o += 4;
      v.setUint32(o, 480, false); o += 4;
      v.setUint32(o, t.length, false); o += 4; new Uint8Array(buf, o, t.length).set(t); o += t.length;
      v.setUint32(o, 20240901, false); o += 4;
      v.setUint32(o, l.length, false); o += 4; new Uint8Array(buf, o, l.length).set(l); o += l.length;
      ws.send(buf);
    }

    function sendCreateChar() {
      const name = document.getElementById('inpCharName').value.trim() || "Ninja";
      const enc = new TextEncoder();
      const n = enc.encode(name);
      const len = 8 + (4+n.length) + 1 + 1;
      const buf = new ArrayBuffer(len);
      const v = new DataView(buf);
      v.setUint32(0, len, false); v.setUint32(4, 25231616, false);
      v.setUint32(8, n.length, false);
      new Uint8Array(buf, 12, n.length).set(n);
      v.setUint8(12 + n.length, 1);
      v.setUint8(13 + n.length, 1);
      ws.send(buf);
    }

    function sendEnterTown() {
      const buf = new ArrayBuffer(8 + 4);
      const v = new DataView(buf);
      v.setUint32(0, 12, false);
      v.setUint32(4, 25231872, false); // CS_LOBBY_Enter_Town
      v.setUint32(8, 1, false); // MapID = 1
      ws.send(buf);
      log("[Sent] CS_LOBBY_Enter_Town -> Entrando na Vila da Folha...");
    }

    function sendMove(x, y) {
      const buf = new ArrayBuffer(8 + 4);
      const v = new DataView(buf);
      v.setUint32(0, 12, false);
      v.setUint32(4, 25232128, false); // CS_LOBBY_Town_Move
      v.setInt16(8, x, false);
      v.setInt16(10, y, false);
      ws.send(buf);
      lblPos.textContent = "Vila #1 (" + x + ", " + y + ")";
      log("[Sent] CS_LOBBY_Town_Move -> Destino: (" + x + ", " + y + ")");
    }

    function sendBattleStart(monsterGroupId = 1) {
      const buf = new ArrayBuffer(8 + 2);
      const v = new DataView(buf);
      v.setUint32(0, 10, false);
      v.setUint32(4, 22315008, false); // CS_BattleStart (0x01548000)
      v.setInt16(8, monsterGroupId, false);
      ws.send(buf);
      log("[Sent] ⚔️ CS_BattleStart -> Desafiando Grupo de Monstros #" + monsterGroupId + "...");
    }
  </script>
</body>
</html>`;
  }
}

new MmoWebSocketServer(PORT);
