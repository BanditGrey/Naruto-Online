import type { Socket } from "node:net";
import type {
  BattleReportData,
  BattleTeamData,
  BattleFighterData,
  BattleTurnData,
} from "../network/packet.ts";
import {
  buildBattleStartPacket,
  buildSingleBattleResultPacket
} from "../network/packet.ts";
import { OPCODES } from "../network/opcodes.ts";

import { db } from "../database/db.ts";

export interface BattleSession {
  battleId: string;
  charId: number;
  socket: Socket;
  monsterGroupId: number;
  report: BattleReportData;
  createdAt: number;
}

/**
 * Gerenciador de Instâncias de Batalha (Logics.Battle)
 */
export class BattleManager {
  private activeBattles: Map<string, BattleSession> = new Map();
  private playerToBattle: Map<number, string> = new Map();
  private sendFrameFn?: (socket: Socket, opcode: number, payload: Buffer) => void;

  public setSendFrame(fn: (socket: Socket, opcode: number, payload: Buffer) => void) {
    this.sendFrameFn = fn;
  }

  /**
   * Inicia um combate PvE para um jogador contra um grupo de monstros
   */
  public startPveBattle(
    charId: number,
    charName: string,
    charProfession: number,
    charLevel: number,
    monsterGroupId: number,
    socket: Socket
  ): BattleSession {
    const battleId = `battle_${charId}_${Date.now()}`;

    // 1. Configura a equipe do jogador (Camp 0) consultando o banco SQLite
    const teamMembers = db.getTeam(charId);
    const inFormation = teamMembers.filter((m) => m.formation_pos > 0);

    const fighters: BattleFighterData[] = [];

    if (inFormation.length > 0) {
      for (const m of inFormation) {
        fighters.push({
          pos: m.formation_pos, // 1..15
          roleId: m.profession || 1,
          quality: m.quality || 3,
          level: m.level || charLevel || 1,
          curHealth: m.hp || 2500,
          totalHealth: m.hp || 2500,
          curAnger: 50,
          skillId: 10101,
          elementBit: 1,
          name: m.name,
        });
      }
    } else {
      fighters.push({
        pos: 2, // Vanguarda Centro
        roleId: charProfession || 1,
        quality: 4,
        level: charLevel || 1,
        curHealth: 2500,
        totalHealth: 2500,
        curAnger: 50,
        skillId: 10101,
        elementBit: 1,
        name: charName,
      });
    }

    const team1: BattleTeamData = {
      userId: `user_${charId}`,
      fighters,
    };

    // 2. Configura a equipe inimiga / Boss baseado no modo de jogo
    let enemyName = `Ninja Rebelde #${monsterGroupId}`;
    let enemyRoleId = 20001;
    let enemyQuality = 1;
    let enemyLevel = Math.max(1, charLevel);
    let enemyHp = 1800;
    let playerDmg1 = 1000;
    let enemyDmg = 400;
    let playerDmg2 = 1200;

    if (monsterGroupId === 999) {
      // Chefe de Mundo: Kyuubi (Kurama)
      enemyName = 'Kyuubi (Raposa de Nove Caudas)';
      enemyRoleId = 18100800;
      enemyQuality = 5;
      enemyLevel = 50;
      enemyHp = 100000;
      playerDmg1 = 15000;
      enemyDmg = 1200;
      playerDmg2 = 35000;
    } else if (monsterGroupId === 101) {
      // Exame Chūnin: Torre dos Desafios
      enemyName = 'Examinador Chūnin (Torre Andar 10)';
      enemyRoleId = 20002;
      enemyQuality = 4;
      enemyLevel = 25;
      enemyHp = 4500;
      playerDmg1 = 1800;
      enemyDmg = 650;
      playerDmg2 = 3000;
    } else if (monsterGroupId === 201) {
      // Arena Ranqueada PvP
      enemyName = 'Rival Shinobi (Arena Rank #15)';
      enemyRoleId = 20003;
      enemyQuality = 3;
      enemyLevel = 18;
      enemyHp = 3500;
      playerDmg1 = 1400;
      enemyDmg = 550;
      playerDmg2 = 2400;
    } else if (monsterGroupId === 1) {
      enemyName = 'Kakashi Hatake (Jōnin)';
      enemyRoleId = 104;
      enemyQuality = 4;
      enemyLevel = 10;
      enemyHp = 2500;
      playerDmg1 = 1200;
      enemyDmg = 500;
      playerDmg2 = 1800;
    } else if (monsterGroupId === 2) {
      enemyName = 'Zabuza Momochi';
      enemyRoleId = 105;
      enemyQuality = 4;
      enemyLevel = 15;
      enemyHp = 3800;
      playerDmg1 = 1500;
      enemyDmg = 600;
      playerDmg2 = 2600;
    } else if (monsterGroupId === 3) {
      enemyName = 'Orochimaru';
      enemyRoleId = 106;
      enemyQuality = 5;
      enemyLevel = 30;
      enemyHp = 6000;
      playerDmg1 = 2500;
      enemyDmg = 800;
      playerDmg2 = 4000;
    }

    const enemyFighter: BattleFighterData = {
      pos: 1, // Posição frontal do inimigo
      roleId: enemyRoleId,
      quality: enemyQuality,
      level: enemyLevel,
      curHealth: enemyHp,
      totalHealth: enemyHp,
      curAnger: 0,
      skillId: 10201,
      elementBit: 2, // Fogo
      name: enemyName
    };

    const team2: BattleTeamData = {
      userId: `npc_group_${monsterGroupId}`,
      fighters: [enemyFighter]
    };

    // 3. Turnos de combate pré-calculados pelo servidor
    const turns: BattleTurnData[] = [
      {
        curTurn: 1,
        actions: [
          {
            activeCamp: 0,
            activePos: 1,
            skillEffectId: 10101,
            activeType: 1, // NormalAttack
            targets: [
              {
                cmd: 1, // CMD_ATTACK
                targetCamp: 1,
                targetPos: 1,
                hurtHp: playerDmg1,
                hurtAnger: 25
              }
            ]
          }
        ]
      },
      {
        curTurn: 2,
        actions: [
          {
            activeCamp: 1,
            activePos: 1,
            skillEffectId: 10201,
            activeType: 1, // NormalAttack
            targets: [
              {
                cmd: 1, // CMD_ATTACK
                targetCamp: 0,
                targetPos: 1,
                hurtHp: enemyDmg,
                hurtAnger: 25
              }
            ]
          }
        ]
      },
      {
        curTurn: 3,
        actions: [
          {
            activeCamp: 0,
            activePos: 1,
            skillEffectId: 10102,
            activeType: 2, // SkillAttack
            targets: [
              {
                cmd: 1, // CMD_ATTACK
                targetCamp: 1,
                targetPos: 1,
                hurtHp: playerDmg2,
                hurtAnger: 50
              }
            ]
          }
        ]
      }
    ];

    const report: BattleReportData = {
      battleIdStr: battleId,
      team1,
      team2,
      turns
    };

    const session: BattleSession = {
      battleId,
      charId,
      socket,
      monsterGroupId,
      report,
      createdAt: Date.now()
    };

    this.activeBattles.set(battleId, session);
    this.playerToBattle.set(charId, battleId);

    // Envia o pacote de inicialização do combate para o cliente
    const packet = buildBattleStartPacket(report);
    if (this.sendFrameFn) {
      this.sendFrameFn(socket, 0x02, packet);
    }

    return session;
  }

  /**
   * Finaliza o combate enviando o resultado (Vitória/Derrota) e recompensas
   */
  public finishBattle(charId: number, isWin: boolean = true) {
    const battleId = this.playerToBattle.get(charId);
    if (!battleId) return;

    const session = this.activeBattles.get(battleId);
    if (session && this.sendFrameFn) {
      if (isWin) {
        const curr = db.getCurrency(charId);
        const nextStage = Math.max(curr.campaign_stage, session.monsterGroupId + 1);
        db.updateCurrency(charId, { campaign_stage: nextStage, ryo: curr.ryo + 1500 });
        console.log(`[BattleManager] Vitória registrada para #${charId}. Próximo estágio de campanha: #${nextStage}`);
      }
      const resultPacket = buildSingleBattleResultPacket(isWin);
      this.sendFrameFn(session.socket, 0x02, resultPacket);
    }

    this.activeBattles.delete(battleId);
    this.playerToBattle.delete(charId);
  }

  public getBattleByCharId(charId: number): BattleSession | undefined {
    const battleId = this.playerToBattle.get(charId);
    if (!battleId) return undefined;
    return this.activeBattles.get(battleId);
  }

  public removeBySocket(socket: Socket) {
    for (const [battleId, session] of this.activeBattles.entries()) {
      if (session.socket === socket) {
        this.playerToBattle.delete(session.charId);
        this.activeBattles.delete(battleId);
        break;
      }
    }
  }
}

export const battleManager = new BattleManager();
