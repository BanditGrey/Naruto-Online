import { WebSocket } from 'ws';
import { PacketReader } from './PacketReader.js';
import { PacketWriter } from './PacketWriter.js';
import { Opcodes } from '../protocol/opcodes.js';
import { Player } from '../game/player/Player.js';
import { PlayerManager } from '../game/player/PlayerManager.js';
import { TownManager } from '../game/world/TownManager.js';
import { BattleManager } from '../game/battle/BattleManager.js';
import { NpcManager } from '../game/world/NpcManager.js';
import { ServerConfig } from '../config/index.js';

export class Session {
  public ws: WebSocket;
  public player?: Player;
  public userId?: string;

  constructor(ws: WebSocket) {
    this.ws = ws;
    this.ws.binaryType = 'arraybuffer';

    this.ws.on('message', (data: ArrayBuffer | Buffer) => this.handleMessage(data));
    this.ws.on('close', () => this.handleClose());
    this.ws.on('error', (err) => console.error('[NET] Erro no socket:', err.message));
  }

  public send(writer: PacketWriter): void {
    if (this.ws.readyState === WebSocket.OPEN) {
      this.ws.send(writer.toBuffer());
    }
  }

  private handleMessage(data: ArrayBuffer | Buffer): void {
    try {
      const reader = new PacketReader(data);
      if (reader.remaining < 8) {
        console.warn('[NET] Pacote truncado (menor que 8 bytes)');
        return;
      }

      const packetLength = reader.readUInt32BE();
      const packetId = reader.readUInt32BE();

      this.dispatchPacket(packetId, reader);
    } catch (err: any) {
      console.error('[NET] Falha ao processar mensagem binária:', err.message);
    }
  }

  private dispatchPacket(opcode: number, reader: PacketReader): void {
    switch (opcode) {
      // 1. CS_Login_StatusServerTransmitToken
      case Opcodes.CS_Login_StatusServerTransmitToken: {
        const token = reader.readFlushUTF();
        this.userId = token || `guest_${Date.now()}`;
        console.log(`[NET] Autenticação recebida. Token/UserId: ${this.userId}`);

        // SC_Login_StatusServerTransmitTokenRet
        const tokenRetPkt = new PacketWriter(Opcodes.SC_Login_StatusServerTransmitTokenRet)
          .writeUInt8(0); // 0 = Sucesso
        this.send(tokenRetPkt);

        const pm = PlayerManager.getInstance();
        const existingPlayer = pm.getPlayerByUserId(this.userId);

        if (!existingPlayer) {
          // Solicitar criação de personagem (SC_CREATECHAR_CreateCharCmd)
          const cmdPkt = new PacketWriter(Opcodes.SC_CREATECHAR_CreateCharCmd);
          this.send(cmdPkt);
        } else {
          this.player = existingPlayer;
          this.sendCharInfo();
        }
        break;
      }

      // 2. CS_CREATECHAR_CreateChar
      case Opcodes.CS_CREATECHAR_CreateChar: {
        const charName = reader.readFlushUTF();
        const profession = reader.readUInt8();
        const gender = reader.readUInt8();

        const pm = PlayerManager.getInstance();
        this.player = pm.createCharacter(this.userId || 'default_user', charName, profession, gender);

        // SC_CREATECHAR_CreateCharRet (0 = Sucesso)
        const retPkt = new PacketWriter(Opcodes.SC_CREATECHAR_CreateCharRet)
          .writeUInt8(0);
        this.send(retPkt);

        this.sendCharInfo();
        break;
      }

      // 3. CS_LOBBY_Enter_Town
      case Opcodes.CS_LOBBY_Enter_Town: {
        const targetCityId = reader.remaining >= 4 ? reader.readUInt32BE() : ServerConfig.spawnCityId;
        TownManager.getInstance().enterTown(this, targetCityId);
        break;
      }

      // 4. CS_LOBBY_Town_Move
      case Opcodes.CS_LOBBY_Town_Move: {
        const targetX = reader.readUInt16BE();
        const targetY = reader.readUInt16BE();
        TownManager.getInstance().moveInTown(this, targetX, targetY);
        break;
      }

      // 5. CS_LOBBY_Town_TalkNpc
      case Opcodes.CS_LOBBY_Town_TalkNpc: {
        if (!this.player) return;
        const npcId = reader.readUInt32BE();
        const dialog = NpcManager.getInstance().interactWithNpc(this.player, npcId);

        if (dialog) {
          const dialogPkt = new PacketWriter(Opcodes.SC_LOBBY_Town_NpcDialog)
            .writeUInt32BE(dialog.npcId)
            .writeFlushUTF(dialog.name)
            .writeFlushUTF(dialog.npcTitle || '')
            .writeFlushUTF(dialog.talk)
            .writeFlushUTF(dialog.availableAction || 'none');
          this.send(dialogPkt);
        }
        break;
      }

      // 6. CS_BattleStart
      case Opcodes.CS_BattleStart: {
        const monsterGroupId = reader.remaining >= 4 ? reader.readUInt32BE() : 1;
        BattleManager.getInstance().startPvEBattle(this, monsterGroupId);
        break;
      }

      default:
        console.warn(`[NET] Opcode desconhecido ou não implementado: ${opcode} (0x${opcode.toString(16).toUpperCase()})`);
        break;
    }
  }

  private sendCharInfo(): void {
    if (!this.player) return;

    // SC_Account_CharInfoNtf
    // Payload: [charId: uint32] + [Name: FlushUTF] + [Profession: uint8] + [Gender: uint8] + [Level: uint16] + [CurHp: float] + [MaxHp: float] + [Silver: uint32] + [Gold: uint32]
    const infoPkt = new PacketWriter(Opcodes.SC_Account_CharInfoNtf)
      .writeUInt32BE(this.player.data.charId)
      .writeFlushUTF(this.player.data.name)
      .writeUInt8(this.player.data.profession)
      .writeUInt8(this.player.data.gender)
      .writeUInt16BE(this.player.data.level)
      .writeFloatBE(this.player.data.curHealth)
      .writeFloatBE(this.player.data.maxHealth)
      .writeUInt32BE(this.player.data.silver)
      .writeUInt32BE(this.player.data.gold);

    this.send(infoPkt);
  }

  private handleClose(): void {
    console.log(`[NET] Conexão encerrada: ${this.userId || 'anônimo'}`);
    TownManager.getInstance().leaveTown(this);
  }
}
