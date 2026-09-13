import { PacketWriter } from './PacketWriter.js';
import { PacketReader } from './PacketReader.js';
import { Opcodes } from '../protocol/opcodes.js';
import { InventoryItemData, QuestProgressData, MailEntryData } from '../game/player/Player.js';

/**
 * ============================================================================
 * 1. PACOTES DE CHAT CANÔNICOS (MODULARID_Chat: 1024 / 0x0400)
 * ============================================================================
 */
export class ChatPackets {
  public static readChatInfo(reader: PacketReader): {
    channel: number;
    targetGuidHigh: number;
    targetGuidLow: number;
    targetName: string;
    content: string;
  } {
    const channel = reader.readUInt8();
    const targetGuidHigh = reader.readUInt32BE();
    const targetGuidLow = reader.readUInt32BE();
    const targetName = reader.readFlushUTF();
    const content = reader.readFlushUTF();
    return { channel, targetGuidHigh, targetGuidLow, targetName, content };
  }

  public static buildChatInfoRet(
    channel: number,
    senderGuidHigh: number,
    senderGuidLow: number,
    senderName: string,
    vipLevel: number,
    styleFlags: number,
    content: string,
    errorCode: number = 0
  ): PacketWriter {
    return new PacketWriter(Opcodes.SC_Chat_ChatInfoRet)
      .writeUInt32BE(errorCode)
      .writeUInt8(channel)
      .writeUInt32BE(senderGuidHigh)
      .writeUInt32BE(senderGuidLow)
      .writeFlushUTF(senderName)
      .writeUInt32BE(vipLevel)
      .writeUInt32BE(styleFlags)
      .writeFlushUTF(content);
  }

  public static buildChatNotReach(targetName: string, errorCode: number = 1): PacketWriter {
    return new PacketWriter(Opcodes.SC_Chat_ChatNotReach)
      .writeUInt32BE(errorCode)
      .writeFlushUTF(targetName);
  }

  public static buildWhisperEchoplex(
    targetGuidHigh: number,
    targetGuidLow: number,
    targetName: string,
    content: string
  ): PacketWriter {
    return new PacketWriter(Opcodes.SC_Chat_WhisperEchoplex)
      .writeUInt32BE(targetGuidHigh)
      .writeUInt32BE(targetGuidLow)
      .writeFlushUTF(targetName)
      .writeFlushUTF(content);
  }
}

/**
 * ============================================================================
 * 2. PACOTES DE MOCHILA & INVENTÁRIO (MODULARID_Backpack: 3840 / 0x0F00)
 * ============================================================================
 */
export class BackpackPackets {
  public static buildLoadBagResult(items: InventoryItemData[], errorCode: number = 0): PacketWriter {
    const writer = new PacketWriter(Opcodes.SC_Backpack_LoadBagResult);
    writer.writeUInt8(errorCode);
    writer.writeUInt16BE(items.length);

    for (const it of items) {
      writer.writeUInt32BE(it.guidHigh);
      writer.writeUInt32BE(it.guidLow);
      writer.writeUInt32BE(it.templateId);
      writer.writeUInt16BE(it.quantity);
      writer.writeUInt8(it.level);
      writer.writeUInt8(it.timingCategory);
      writer.writeUInt8(it.timingState);
      writer.writeUInt32BE(it.timingTime);
      writer.writeUInt32BE(it.expireTick);
      writer.writeUInt8(it.obtainType);
    }
    return writer;
  }

  public static readUseAppliance(reader: PacketReader): { guidHigh: number; guidLow: number; count: number } {
    const guidHigh = reader.readUInt32BE();
    const guidLow = reader.readUInt32BE();
    const count = reader.readUInt16BE();
    return { guidHigh, guidLow, count };
  }

  public static buildUseApplianceRet(
    guidHigh: number,
    guidLow: number,
    remainingCount: number,
    errorCode: number = 0
  ): PacketWriter {
    return new PacketWriter(Opcodes.SC_Backpack_UseAppliance)
      .writeUInt32BE(errorCode)
      .writeUInt32BE(guidHigh)
      .writeUInt32BE(guidLow)
      .writeUInt16BE(remainingCount);
  }

  public static readSellItem(reader: PacketReader): { guidHigh: number; guidLow: number; count: number } {
    const guidHigh = reader.readUInt32BE();
    const guidLow = reader.readUInt32BE();
    const count = reader.readUInt16BE();
    return { guidHigh, guidLow, count };
  }

  public static buildSellItemRet(earnedSilver: number, errorCode: number = 0): PacketWriter {
    return new PacketWriter(Opcodes.SC_Backpack_SellItem)
      .writeUInt32BE(errorCode)
      .writeUInt32BE(earnedSilver);
  }

  public static buildInventoryNtf(actionType: number, item: InventoryItemData): PacketWriter {
    return new PacketWriter(Opcodes.SC_Backpack_InventoryNtf)
      .writeUInt8(actionType) // 1=Add, 2=Update, 3=Remove
      .writeUInt32BE(item.guidHigh)
      .writeUInt32BE(item.guidLow)
      .writeUInt32BE(item.templateId)
      .writeUInt16BE(item.quantity)
      .writeUInt8(item.level)
      .writeUInt8(item.timingCategory)
      .writeUInt8(item.timingState)
      .writeUInt32BE(item.timingTime)
      .writeUInt32BE(item.expireTick)
      .writeUInt8(item.obtainType);
  }

  public static buildMergeBagItemRet(errorCode: number = 0): PacketWriter {
    return new PacketWriter(Opcodes.SC_Backpack_MergeBagItem_Ret)
      .writeUInt32BE(errorCode);
  }
}

/**
 * ============================================================================
 * 3. PACOTES DE FORMAÇÃO TÁTICA (MODULARID_TacticalDeployment: 2304 / 0x0900)
 * ============================================================================
 */
export class TacticalDeploymentPackets {
  public static readChangePositionReq(reader: PacketReader): { heroId: number; pos: number } {
    const heroId = reader.readUInt32BE();
    const pos = reader.readUInt8();
    return { heroId, pos };
  }

  public static buildChangePositionRet(heroId: number, newPos: number, errorCode: number = 0): PacketWriter {
    return new PacketWriter(Opcodes.SC_TacticalDeploymentChangePositonRet)
      .writeUInt8(errorCode)
      .writeUInt32BE(heroId)
      .writeUInt8(newPos);
  }

  public static readChangeSkillReq(reader: PacketReader): { heroId: number; skillId: number } {
    const heroId = reader.readUInt32BE();
    const skillId = reader.readUInt32BE();
    return { heroId, skillId };
  }

  public static buildChangeSkillRet(heroId: number, skillId: number, errorCode: number = 0): PacketWriter {
    return new PacketWriter(Opcodes.SC_TacticalDeploymentChangeSkillRet)
      .writeUInt8(errorCode)
      .writeUInt32BE(heroId)
      .writeUInt32BE(skillId);
  }
}

/**
 * ============================================================================
 * 4. PACOTES DE TAVERNA & RECRUTAMENTO (MODULARID_Tavern: 3072 / 0x0C00)
 * ============================================================================
 */
export class TavernPackets {
  public static buildEnterTavern(souls: { blue: number; purple: number; gold: number; orange: number }): PacketWriter {
    return new PacketWriter(Opcodes.SC_Enter_Tavern)
      .writeUInt32BE(0) // ErrorCode
      .writeUInt32BE(souls.blue)
      .writeUInt32BE(souls.purple)
      .writeUInt32BE(souls.gold)
      .writeUInt32BE(souls.orange);
  }

  public static readTavernMoraReq(reader: PacketReader): { moraHand: number; npcId: number } {
    const moraHand = reader.readUInt8();
    const npcId = reader.readUInt32BE();
    return { moraHand, npcId };
  }

  public static buildTavernMoraRet(
    isWin: boolean,
    serverHand: number,
    awardSoulType: number,
    awardSoulValue: number,
    errorCode: number = 0
  ): PacketWriter {
    return new PacketWriter(Opcodes.SC_TavernMoraRet)
      .writeUInt32BE(errorCode)
      .writeUInt8(isWin ? 1 : 0)
      .writeUInt8(serverHand)
      .writeUInt8(awardSoulType)
      .writeUInt32BE(awardSoulValue);
  }

  public static readTavernRecruitReq(reader: PacketReader): { heroId: number } {
    const heroId = reader.readUInt32BE();
    return { heroId };
  }

  public static buildTavernRecruitRet(recruitedHeroId: number, errorCode: number = 0): PacketWriter {
    return new PacketWriter(Opcodes.SC_TavernRecruitRet)
      .writeUInt32BE(errorCode)
      .writeUInt32BE(recruitedHeroId);
  }
}

/**
 * ============================================================================
 * 5. PACOTES DE ATRIBUTOS E CONTA (MODULARID_Account: 256 / 0x0100)
 * ============================================================================
 */
export class AccountPackets {
  public static buildCharBaseAttributeRet(
    power: number,
    agility: number,
    intellect: number,
    life: number,
    powerRate: number = 1.0,
    agilityRate: number = 1.0,
    intellectRate: number = 1.0,
    lifeRate: number = 1.0
  ): PacketWriter {
    return new PacketWriter(Opcodes.SC_Account_CharBaseAttributeRet)
      .writeUInt32BE(power)
      .writeUInt32BE(agility)
      .writeUInt32BE(intellect)
      .writeUInt32BE(life)
      .writeFloatBE(powerRate)
      .writeFloatBE(agilityRate)
      .writeFloatBE(intellectRate)
      .writeFloatBE(lifeRate);
  }

  public static buildUserFightValueRet(combatPower: number): PacketWriter {
    return new PacketWriter(Opcodes.SC_Account_UserFightVauleRet)
      .writeUInt32BE(combatPower);
  }

  public static buildCharBaseInfoUpdate(updates: {
    curHp?: number;
    maxHp?: number;
    silver?: number;
    gold?: number;
    level?: number;
    exp?: number;
  }): PacketWriter {
    let mask = 0;
    if (updates.curHp !== undefined) mask |= 1 << 0;
    if (updates.maxHp !== undefined) mask |= 1 << 1;
    if (updates.silver !== undefined) mask |= 1 << 2;
    if (updates.gold !== undefined) mask |= 1 << 3;
    if (updates.level !== undefined) mask |= 1 << 4;
    if (updates.exp !== undefined) mask |= 1 << 5;

    const writer = new PacketWriter(Opcodes.SC_Account_CharBaseInfoUpdate)
      .writeUInt32BE(mask);

    if (updates.curHp !== undefined) writer.writeFloatBE(updates.curHp);
    if (updates.maxHp !== undefined) writer.writeFloatBE(updates.maxHp);
    if (updates.silver !== undefined) writer.writeUInt32BE(updates.silver);
    if (updates.gold !== undefined) writer.writeUInt32BE(updates.gold);
    if (updates.level !== undefined) writer.writeUInt16BE(updates.level);
    if (updates.exp !== undefined) writer.writeUInt32BE(updates.exp);

    return writer;
  }
}

/**
 * ============================================================================
 * 6. PACOTES DE MISSÕES E TAREFAS (MODULARID_Task: 4608 / 0x1200)
 * ============================================================================
 */
export class TaskPackets {
  public static readQuestActionReq(reader: PacketReader): { actionType: number; taskId: number } {
    const actionType = reader.readUInt8(); // 1=Aceitar, 2=Concluir/Entregar
    const taskId = reader.readUInt32BE();
    return { actionType, taskId };
  }

  public static buildQuestActionRet(taskId: number, status: number, errorCode: number = 0): PacketWriter {
    return new PacketWriter(Opcodes.SC_Task_QuestActionRet)
      .writeUInt32BE(errorCode)
      .writeUInt32BE(taskId)
      .writeUInt8(status);
  }

  public static buildAlreadyAcceptTaskRet(quests: QuestProgressData[]): PacketWriter {
    const writer = new PacketWriter(Opcodes.SC_Task_AlreadyAcceptTaskRet);
    writer.writeUInt16BE(quests.length);

    for (const q of quests) {
      writer.writeUInt32BE(q.taskId);
      writer.writeUInt16BE(q.curProgress);
      writer.writeUInt16BE(q.totalNeeded);
      writer.writeUInt8(q.state);
    }
    return writer;
  }
}

/**
 * ============================================================================
 * 7. PACOTES DE CORREIO / CARTAS (MODULARID_Mail: 5632 / 0x1600)
 * ============================================================================
 */
export class MailPackets {
  public static buildMailInitDataRep(mails: MailEntryData[]): PacketWriter {
    const writer = new PacketWriter(Opcodes.SC_Mail_InitDataRep);
    writer.writeUInt16BE(mails.length);

    for (const m of mails) {
      writer.writeUInt32BE(m.id);
      writer.writeFlushUTF(m.sender);
      writer.writeFlushUTF(m.title);
      writer.writeFlushUTF(m.content);
      writer.writeUInt8(m.hasGift);
      writer.writeUInt32BE(m.silver);
      writer.writeUInt32BE(m.gold);
      writer.writeUInt8(m.isRead);
    }
    return writer;
  }

  public static readGetAttachmentReq(reader: PacketReader): { mailId: number } {
    const mailId = reader.readUInt32BE();
    return { mailId };
  }

  public static buildGetAttachmentRep(
    mailId: number,
    silver: number,
    gold: number,
    errorCode: number = 0
  ): PacketWriter {
    return new PacketWriter(Opcodes.SC_Mail_GetAttachmentRep)
      .writeUInt32BE(errorCode)
      .writeUInt32BE(mailId)
      .writeUInt32BE(silver)
      .writeUInt32BE(gold);
  }
}

/**
 * ============================================================================
 * 8. PACOTES DE GUILDA / FAMÍLIA (MODULARID_Guild: 4864 / 0x1300)
 * ============================================================================
 */
export class GuildPackets {
  public static buildGuildInitRet(
    guildName: string,
    level: number,
    leaderName: string,
    treasury: number,
    playerContribution: number,
    membersCount: number,
    maxMembers: number
  ): PacketWriter {
    return new PacketWriter(Opcodes.SC_Guild_InitRet)
      .writeFlushUTF(guildName)
      .writeUInt16BE(level)
      .writeFlushUTF(leaderName)
      .writeUInt32BE(treasury)
      .writeUInt32BE(playerContribution)
      .writeUInt16BE(membersCount)
      .writeUInt16BE(maxMembers);
  }

  public static readGuildDonateReq(reader: PacketReader): { donateAmount: number } {
    const donateAmount = reader.remaining >= 4 ? reader.readUInt32BE() : 1000;
    return { donateAmount };
  }

  public static buildGuildDonateRet(
    newContribution: number,
    newSilver: number,
    errorCode: number = 0
  ): PacketWriter {
    return new PacketWriter(Opcodes.SC_Guild_DonateRet)
      .writeUInt32BE(errorCode)
      .writeUInt32BE(newContribution)
      .writeUInt32BE(newSilver);
  }
}

/**
 * ============================================================================
 * 9. PACOTES DE PRESENTES E CÓDIGOS CDK (MODULARID_Welcome: 5120 / 0x1400)
 * ============================================================================
 */
export class GiftPackets {
  public static readRedeemCodeReq(reader: PacketReader): { code: string } {
    const code = reader.readFlushUTF();
    return { code };
  }

  public static buildRedeemCodeRet(
    code: string,
    silverAward: number,
    couponsAward: number,
    errorCode: number = 0
  ): PacketWriter {
    return new PacketWriter(Opcodes.SC_Gift_RedeemCodeRet)
      .writeUInt32BE(errorCode)
      .writeFlushUTF(code)
      .writeUInt32BE(silverAward)
      .writeUInt32BE(couponsAward);
  }
}



