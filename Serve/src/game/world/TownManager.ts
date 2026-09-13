import { Session } from '../../network/Session.js';
import { PacketWriter } from '../../network/PacketWriter.js';
import { Opcodes } from '../../protocol/opcodes.js';
import { NpcManager } from './NpcManager.js';

export class TownManager {
  private static instance: TownManager;

  // Sessões globais ativas conectadas ao servidor
  private allSessions: Set<Session> = new Set();
  // Mapa de cidade -> Conjunto de sessões conectadas
  private townSessions: Map<number, Set<Session>> = new Map();

  private constructor() {}

  public static getInstance(): TownManager {
    if (!TownManager.instance) {
      TownManager.instance = new TownManager();
    }
    return TownManager.instance;
  }

  public registerSession(session: Session): void {
    this.allSessions.add(session);
  }

  public unregisterSession(session: Session): void {
    this.allSessions.delete(session);
  }

  public broadcastGlobal(writer: PacketWriter): void {
    for (const s of this.allSessions) {
      s.send(writer);
    }
  }

  public enterTown(session: Session, cityId: number): void {
    const player = session.player;
    if (!player) return;

    const previousCityId = player.data.currentCityId;
    if (previousCityId && previousCityId !== cityId) {
      this.leaveTown(session);
    }

    // Definir ponto de spawn adequado
    if (cityId === 23200001) {
      player.data.x = 250;
      player.data.y = 390;
    } else if (cityId === 23100001) {
      if (previousCityId === 23200001) {
        player.data.x = 2050;
        player.data.y = 390;
      } else {
        player.data.x = 400;
        player.data.y = 382;
      }
    }

    player.data.currentCityId = cityId;

    let sessionsInTown = this.townSessions.get(cityId);
    if (!sessionsInTown) {
      sessionsInTown = new Set();
      this.townSessions.set(cityId, sessionsInTown);
    }

    // 1. Enviar confirmação de entrada ao próprio jogador (SC_Enter_Town)
    // Payload: [cityId: uint32] + [spawnX: uint16] + [spawnY: uint16]
    const enterPkt = new PacketWriter(Opcodes.SC_Enter_Town)
      .writeUInt32BE(cityId)
      .writeUInt16BE(player.data.x)
      .writeUInt16BE(player.data.y);
    session.send(enterPkt);

    // 2. Enviar a lista de NPCs autênticos da vila (SC_LOBBY_Town_NpcList)
    const npcs = NpcManager.getInstance().getNpcsInCity(cityId);
    const npcListPkt = new PacketWriter(Opcodes.SC_LOBBY_Town_NpcList);
    npcListPkt.writeInt16BE(npcs.length);

    for (const npc of npcs) {
      npcListPkt.writeUInt32BE(npc.id)
        .writeFlushUTF(npc.name)
        .writeFlushUTF(npc.npcTitle || '')
        .writeUInt16BE(npc.x)
        .writeUInt16BE(npc.y)
        .writeUInt8(npc.userType);
    }
    session.send(npcListPkt);
    console.log(`[TOWN] Enviados ${npcs.length} NPCs autênticos da Vila #${cityId} para "${player.data.name}".`);

    // 3. Notificar presença para todos os outros ninjas na mesma vila (SC_LOBBY_Town_NewRoleNtf)
    const newRolePkt = new PacketWriter(Opcodes.SC_LOBBY_Town_NewRoleNtf)
      .writeUInt32BE(player.data.charId)
      .writeFlushUTF(player.data.name)
      .writeUInt8(player.data.profession)
      .writeUInt8(player.data.gender)
      .writeUInt16BE(player.data.x)
      .writeUInt16BE(player.data.y)
      .writeUInt16BE(player.data.level)
      .writeUInt32BE(player.data.templateHeroId);

    for (const otherSession of sessionsInTown) {
      if (otherSession !== session) {
        otherSession.send(newRolePkt);

        // Enviar os outros avatares existentes para o jogador que acabou de entrar
        if (otherSession.player) {
          const existingRolePkt = new PacketWriter(Opcodes.SC_LOBBY_Town_NewRoleNtf)
            .writeUInt32BE(otherSession.player.data.charId)
            .writeFlushUTF(otherSession.player.data.name)
            .writeUInt8(otherSession.player.data.profession)
            .writeUInt8(otherSession.player.data.gender)
            .writeUInt16BE(otherSession.player.data.x)
            .writeUInt16BE(otherSession.player.data.y)
            .writeUInt16BE(otherSession.player.data.level)
            .writeUInt32BE(otherSession.player.data.templateHeroId);
          session.send(existingRolePkt);
        }
      }
    }

    sessionsInTown.add(session);
    console.log(`[TOWN] Ninja ${player.data.name} (#${player.data.charId}) entrou na Vila #${cityId} em (${player.data.x}, ${player.data.y})`);
  }

  public moveInTown(session: Session, targetX: number, targetY: number): void {
    const player = session.player;
    if (!player) return;

    player.updatePosition(targetX, targetY);
    const cityId = player.data.currentCityId;
    const sessionsInTown = this.townSessions.get(cityId);
    if (!sessionsInTown) return;

    // Broadcast de movimento: SC_LOBBY_Town_RoleMove
    // Payload: [charId: uint32] + [newX: uint16] + [newY: uint16]
    const movePkt = new PacketWriter(Opcodes.SC_LOBBY_Town_RoleMove)
      .writeUInt32BE(player.data.charId)
      .writeUInt16BE(player.data.x)
      .writeUInt16BE(player.data.y);

    for (const s of sessionsInTown) {
      s.send(movePkt);
    }
  }

  public leaveTown(session: Session): void {
    const player = session.player;
    if (!player) return;

    const cityId = player.data.currentCityId;
    const sessionsInTown = this.townSessions.get(cityId);
    if (sessionsInTown) {
      sessionsInTown.delete(session);

      const removePkt = new PacketWriter(Opcodes.SC_LOBBY_Town_RemoveRole)
        .writeUInt32BE(player.data.charId);

      for (const s of sessionsInTown) {
        s.send(removePkt);
      }
    }
  }

  public broadcastPacket(writer: PacketWriter): void {
    for (const sessions of this.townSessions.values()) {
      for (const s of sessions) {
        s.send(writer);
      }
    }
  }

  public getSessionByPlayerId(charId: number): Session | undefined {
    for (const sessions of this.townSessions.values()) {
      for (const s of sessions) {
        if (s.player && s.player.data.charId === charId) {
          return s;
        }
      }
    }
    return undefined;
  }
}
