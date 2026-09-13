import { WebPacketReader } from './clientSocket.ts';
import type { BattleInitReport, TeamBattleData, FighterBattleData, TurnBattleData, ActionBattleData, TargetActionResult } from '../../../shared/types.ts';

/**
 * Desserializador oficial do pacote SC_Battle_StartReportDataReq (0x01458000 / 21331968)
 * Implementado estritamente conforme TUnstreamizerBattleRepot.as e packet.ts
 */
export function readBattleStartPacket(reader: WebPacketReader): BattleInitReport {
  // 1. Identificador / Hash da batalha
  const battleIdStr = reader.readStringUTF();

  // Helper para ler equipe
  const readTeam = (): TeamBattleData => {
    const mountsId = reader.readInt();
    const mountsLevel = reader.readInt();
    const soulFormationId = reader.readInt();
    const emblemId = reader.readInt();
    const ringId = reader.readInt();
    const userId = reader.readStringUTF();

    const fighterCount = reader.readShort();
    const fighters: FighterBattleData[] = [];

    for (let i = 0; i < fighterCount; i++) {
      const pos = reader.readByte();
      const roleId = reader.readUnsignedInt();
      const quality = reader.readByte();
      const level = reader.readShort();
      const curHealth = reader.readFloat();
      const totalHealth = reader.readFloat();
      const curAnger = reader.readInt();
      const skillId = reader.readInt();
      const elementBit = reader.readInt();
      const name = reader.readStringUTF();

      fighters.push({
        pos,
        roleId,
        quality,
        level,
        curHealth,
        totalHealth,
        curAnger,
        skillId,
        elementBit,
        name,
      });
    }

    return {
      userId,
      mountsId,
      mountsLevel,
      soulFormationId,
      emblemId,
      ringId,
      fighters,
    };
  };

  // 2. Time 1 (Aliado / Camp 0)
  const team1 = readTeam();

  // 3. Time 2 (Inimigo / Camp 1)
  const team2 = readTeam();

  // 4. Total de Turnos
  const turnCount = reader.readShort();
  const turns: TurnBattleData[] = [];

  for (let t = 0; t < turnCount; t++) {
    const curTurn = reader.readInt();
    const actionCount = reader.readShort();
    const actions: ActionBattleData[] = [];

    for (let a = 0; a < actionCount; a++) {
      const activeCamp = reader.readByte();
      const activePos = reader.readByte();
      const skillEffectId = reader.readInt();
      const activeType = reader.readInt();

      const targetCount = reader.readShort();
      const targets: TargetActionResult[] = [];

      for (let tg = 0; tg < targetCount; tg++) {
        const cmd = reader.readByte();
        const targetCamp = reader.readByte();
        const targetPos = reader.readByte();
        const targetStatus = reader.readUnsignedInt();
        const targetStatus1 = reader.readUnsignedInt();
        const targetStatus2 = reader.readUnsignedInt();

        let hurtHp = 0;
        let hurtAnger = 0;
        let buffId: number | undefined;

        if (cmd === 1 || cmd === 7 || cmd === 12) {
          hurtHp = reader.readFloat();
          hurtAnger = reader.readInt();
        } else if (cmd === 3) {
          hurtHp = reader.readFloat();
          hurtAnger = reader.readInt();
          buffId = reader.readUnsignedInt();
        } else if (cmd === 4 || cmd === 2 || cmd === 13) {
          buffId = reader.readUnsignedInt();
          reader.readUnsignedInt(); // BuffTurn
        }

        targets.push({
          cmd,
          targetCamp,
          targetPos,
          targetStatus,
          targetStatus1,
          targetStatus2,
          hurtHp,
          hurtAnger,
          buffId,
        });
      }

      actions.push({
        activeCamp,
        activePos,
        skillEffectId,
        activeType,
        targets,
      });
    }

    turns.push({
      curTurn,
      actions,
    });
  }

  return {
    battleIdStr,
    team1,
    team2,
    turns,
  };
}
