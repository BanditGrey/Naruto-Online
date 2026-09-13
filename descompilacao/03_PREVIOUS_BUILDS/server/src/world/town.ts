import { Socket } from "node:net";
import type { TownPlayerDto } from "../network/packet.ts";
import {
  buildTownNewRolePacket,
  buildTownRoleMovePacket,
  buildTownRemoveRolePacket,
  buildEnterTownPacket,
} from "../network/packet.ts";

export interface TownPlayer {
  charId: number;
  name: string;
  profession: number;
  gender: number;
  level: number;
  mapId: number;
  x: number;
  y: number;
  socket: Socket;
}

/**
 * Gerenciador de instâncias do mapa / vila (TownManager)
 * Responsável por controlar posicionamento, presença e movimentação multiplayer
 */
export class TownManager {
  private players: Map<number, TownPlayer> = new Map();
  private socketToCharId: Map<Socket, number> = new Map();
  private sendFrameFn?: (socket: Socket, opcode: number, payload: Buffer) => void;

  constructor(sendFrameFn?: (socket: Socket, opcode: number, payload: Buffer) => void) {
    this.sendFrameFn = sendFrameFn;
  }

  public setSendFrame(fn: (socket: Socket, opcode: number, payload: Buffer) => void): void {
    this.sendFrameFn = fn;
  }

  public getPlayerByCharId(charId: number): TownPlayer | undefined {
    return this.players.get(charId);
  }

  public getPlayerBySocket(socket: Socket): TownPlayer | undefined {
    const charId = this.socketToCharId.get(socket);
    return charId !== undefined ? this.players.get(charId) : undefined;
  }

  public getAllPlayersInMap(mapId: number): TownPlayer[] {
    const list: TownPlayer[] = [];
    for (const p of this.players.values()) {
      if (p.mapId === mapId) {
        list.push(p);
      }
    }
    return list;
  }

  /**
   * Adiciona o jogador na vila (ex: MapID = 1 / Konoha)
   * 1. Confirma entrada com SC_Enter_Town para o próprio jogador.
   * 2. Envia para o novo jogador a lista de jogadores já presentes (SC_LOBBY_Town_NewRoleNtf).
   * 3. Faz broadcast do novo jogador (Spawn) para todos os outros na mesma vila.
   */
  public addPlayer(
    charId: number,
    name: string,
    profession: number,
    gender: number,
    level: number,
    socket: Socket,
    mapId: number = 1,
    initialX: number = 1200,
    initialY: number = 800
  ): TownPlayer {
    if (this.players.has(charId)) {
      this.removePlayer(charId);
    }

    const player: TownPlayer = {
      charId,
      name,
      profession,
      gender,
      level,
      mapId,
      x: initialX,
      y: initialY,
      socket,
    };

    // Jogadores já presentes no mapa
    const existingPlayers = this.getAllPlayersInMap(mapId);

    // Registra na vila
    this.players.set(charId, player);
    this.socketToCharId.set(socket, charId);

    // 1. Envia SC_Enter_Town para o jogador entrante
    const enterTownPacket = buildEnterTownPacket(mapId, initialX, initialY, 1);
    this.send(socket, enterTownPacket);

    // 2. Notifica o jogador entrante sobre os jogadores já presentes
    if (existingPlayers.length > 0) {
      const existingDto: TownPlayerDto[] = existingPlayers.map((p) => ({
        charId: p.charId,
        name: p.name,
        profession: p.profession,
        gender: p.gender,
        level: p.level,
        x: p.x,
        y: p.y,
      }));
      const existingRolesPacket = buildTownNewRolePacket(existingDto);
      this.send(socket, existingRolesPacket);
    }

    // 3. Broadcast do novo jogador para todos os outros na mesma vila
    const newDto: TownPlayerDto = {
      charId: player.charId,
      name: player.name,
      profession: player.profession,
      gender: player.gender,
      level: player.level,
      x: player.x,
      y: player.y,
    };
    const newRolePacket = buildTownNewRolePacket([newDto]);
    this.broadcastInMap(mapId, newRolePacket, charId);

    return player;
  }

  /**
   * Atualiza a posição do jogador e propaga movimentação para os outros clientes (SC_LOBBY_Town_RoleMove)
   */
  public movePlayer(charId: number, targetX: number, targetY: number): boolean {
    const player = this.players.get(charId);
    if (!player) return false;

    player.x = targetX;
    player.y = targetY;

    const movePacket = buildTownRoleMovePacket(charId, targetX, targetY);
    this.broadcastInMap(player.mapId, movePacket, charId);
    return true;
  }

  /**
   * Remove o jogador da vila e notifica os outros (SC_LOBBY_Town_RemoveRole)
   */
  public removePlayer(charId: number): void {
    const player = this.players.get(charId);
    if (!player) return;

    this.players.delete(charId);
    this.socketToCharId.delete(player.socket);

    const removePacket = buildTownRemoveRolePacket(charId);
    this.broadcastInMap(player.mapId, removePacket, charId);
  }

  public removeBySocket(socket: Socket): void {
    const charId = this.socketToCharId.get(socket);
    if (charId !== undefined) {
      this.removePlayer(charId);
    }
  }

  public broadcastInMap(mapId: number, packet: Buffer, excludedCharId?: number): void {
    for (const player of this.players.values()) {
      if (player.mapId === mapId && player.charId !== excludedCharId) {
        this.send(player.socket, packet);
      }
    }
  }

  private send(socket: Socket, packet: Buffer): void {
    if (this.sendFrameFn) {
      this.sendFrameFn(socket, 0x02, packet);
    }
  }
}

export const townManager = new TownManager();
