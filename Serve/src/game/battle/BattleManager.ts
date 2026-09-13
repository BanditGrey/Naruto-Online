import { Player } from '../player/Player.js';
import { Session } from '../../network/Session.js';
import { PacketWriter } from '../../network/PacketWriter.js';
import { Opcodes } from '../../protocol/opcodes.js';

export class BattleManager {
  private static instance: BattleManager;

  private constructor() {}

  public static getInstance(): BattleManager {
    if (!BattleManager.instance) {
      BattleManager.instance = new BattleManager();
    }
    return BattleManager.instance;
  }

  public startPvEBattle(session: Session, monsterGroupId: number): void {
    const player = session.player;
    if (!player) return;

    const battleId = `battle_${player.data.charId}_${Date.now()}`;
    console.log(`[BATTLE] Iniciando combate PvE para ${player.data.name} vs Grupo #${monsterGroupId} (ID: ${battleId})`);

    // 1. SC_Battle_StartReportDataReq (0x01458000)
    const reportPkt = new PacketWriter(Opcodes.SC_Battle_StartReportDataReq);

    // BattleId
    reportPkt.writeFlushUTF(battleId);

    // Time 1 (Aliados - Camp 0)
    // Contagem de lutadores (int16)
    reportPkt.writeInt16BE(1);
    // Lutador 1: [Slot: uint8 (1..15)] + [HeroId: uint32] + [Name: FlushUTF] + [CurHp: float] + [MaxHp: float] + [JutsuId: uint32]
    reportPkt.writeUInt8(1) // Posição 1 (Centro Linha 0)
      .writeUInt32BE(player.data.templateHeroId)
      .writeFlushUTF(player.data.name)
      .writeFloatBE(player.data.curHealth)
      .writeFloatBE(player.data.maxHealth)
      .writeUInt32BE(10101); // Jutsu Ativo

    // Time 2 (Inimigos - Camp 1)
    reportPkt.writeInt16BE(1);
    // Monstro 1
    const monsterHp = 1800;
    reportPkt.writeUInt8(1) // Posição 1 inimiga
      .writeUInt32BE(20001) // Ninja Rebelde
      .writeFlushUTF('Ninja Renegado')
      .writeFloatBE(monsterHp)
      .writeFloatBE(monsterHp)
      .writeUInt32BE(10201);

    // Turnos pré-calculados (int16)
    reportPkt.writeInt16BE(3);

    // Turno 1: Aliado ataca Inimigo (Dano Normal)
    // [TurnIndex: uint8] + [AttackerCamp: uint8] + [AttackerSlot: uint8] + [TargetCamp: uint8] + [TargetSlot: uint8] + [SkillType: uint8 (1=Normal)] + [Damage: float]
    reportPkt.writeUInt8(1)
      .writeUInt8(0).writeUInt8(1)
      .writeUInt8(1).writeUInt8(1)
      .writeUInt8(1)
      .writeFloatBE(1000);

    // Turno 2: Inimigo contra-ataca (Dano Normal)
    reportPkt.writeUInt8(2)
      .writeUInt8(1).writeUInt8(1)
      .writeUInt8(0).writeUInt8(1)
      .writeUInt8(1)
      .writeFloatBE(400);

    // Turno 3: Aliado finaliza com Jutsu Especial (Dano Crítico)
    reportPkt.writeUInt8(3)
      .writeUInt8(0).writeUInt8(1)
      .writeUInt8(1).writeUInt8(1)
      .writeUInt8(2) // 2 = Jutsu Especial
      .writeFloatBE(1200);

    session.send(reportPkt);

    // 2. SC_SingleBattleResult (0x01458001)
    // [Result: uint8 (1=Vitória, 0=Derrota)] + [RewardExp: uint32] + [RewardSilver: uint32]
    const rewardExp = 500;
    const rewardSilver = 1500;
    player.data.exp += rewardExp;
    player.data.silver += rewardSilver;

    const resultPkt = new PacketWriter(Opcodes.SC_SingleBattleResult)
      .writeUInt8(1) // Vitória
      .writeUInt32BE(rewardExp)
      .writeUInt32BE(rewardSilver);

    session.send(resultPkt);
    console.log(`[BATTLE] Relatório de combate e resultado de vitória enviados para ${player.data.name}.`);
  }
}
