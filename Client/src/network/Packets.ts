import { PacketWriter } from './PacketWriter.js';
import { PacketReader } from './PacketReader.js';
import { Opcodes } from '../protocol/opcodes.js';

export interface InventoryItemDto {
  guidHigh: number;
  guidLow: number;
  templateId: number;
  quantity: number;
  level: number;
  timingCategory: number;
  timingState: number;
  timingTime: number;
  expireTick: number;
  obtainType: number;
}

export interface MailDto {
  id: number;
  sender: string;
  title: string;
  content: string;
  hasGift: number;
  silver: number;
  gold: number;
  isRead: number;
}

export interface QuestDto {
  taskId: number;
  curProgress: number;
  totalNeeded: number;
  state: number;
}

export class ClientPackets {
  // Chat
  public static buildChatInfo(
    channel: number,
    targetGuidHigh: number,
    targetGuidLow: number,
    targetName: string,
    content: string
  ): PacketWriter {
    return new PacketWriter(Opcodes.CS_Chat_ChatInfo)
      .writeUInt8(channel)
      .writeUInt32BE(targetGuidHigh)
      .writeUInt32BE(targetGuidLow)
      .writeFlushUTF(targetName)
      .writeFlushUTF(content);
  }

  public static readChatInfoRet(reader: PacketReader): {
    errorCode: number;
    channel: number;
    senderGuidHigh: number;
    senderGuidLow: number;
    senderName: string;
    vipLevel: number;
    styleFlags: number;
    content: string;
  } {
    const errorCode = reader.readUInt32BE();
    const channel = reader.readUInt8();
    const senderGuidHigh = reader.readUInt32BE();
    const senderGuidLow = reader.readUInt32BE();
    const senderName = reader.readFlushUTF();
    const vipLevel = reader.readUInt32BE();
    const styleFlags = reader.readUInt32BE();
    const content = reader.readFlushUTF();
    return { errorCode, channel, senderGuidHigh, senderGuidLow, senderName, vipLevel, styleFlags, content };
  }

  // Backpack
  public static buildLoadBag(): PacketWriter {
    return new PacketWriter(Opcodes.CS_Backpack_LoadBag);
  }

  public static readLoadBagResult(reader: PacketReader): {
    errorCode: number;
    items: InventoryItemDto[];
  } {
    const errorCode = reader.readUInt8();
    const count = reader.readUInt16BE();
    const items: InventoryItemDto[] = [];
    for (let i = 0; i < count; i++) {
      items.push({
        guidHigh: reader.readUInt32BE(),
        guidLow: reader.readUInt32BE(),
        templateId: reader.readUInt32BE(),
        quantity: reader.readUInt16BE(),
        level: reader.readUInt8(),
        timingCategory: reader.readUInt8(),
        timingState: reader.readUInt8(),
        timingTime: reader.readUInt32BE(),
        expireTick: reader.readUInt32BE(),
        obtainType: reader.readUInt8()
      });
    }
    return { errorCode, items };
  }

  public static buildUseAppliance(guidHigh: number, guidLow: number, count: number): PacketWriter {
    return new PacketWriter(Opcodes.CS_Backpack_UseAppliance)
      .writeUInt32BE(guidHigh)
      .writeUInt32BE(guidLow)
      .writeUInt16BE(count);
  }

  public static readUseApplianceRet(reader: PacketReader): {
    errorCode: number;
    guidHigh: number;
    guidLow: number;
    remainingCount: number;
  } {
    const errorCode = reader.readUInt32BE();
    const guidHigh = reader.readUInt32BE();
    const guidLow = reader.readUInt32BE();
    const remainingCount = reader.readUInt16BE();
    return { errorCode, guidHigh, guidLow, remainingCount };
  }

  public static buildMergeBagItemReq(): PacketWriter {
    return new PacketWriter(Opcodes.CS_Backpack_MergeBagItem_Req);
  }

  public static readMergeBagItemRet(reader: PacketReader): {
    errorCode: number;
  } {
    const errorCode = reader.readUInt32BE();
    return { errorCode };
  }

  public static buildSellItemReq(guidHigh: number, guidLow: number, count: number): PacketWriter {
    return new PacketWriter(Opcodes.CS_Backpack_SellItem)
      .writeUInt32BE(guidHigh)
      .writeUInt32BE(guidLow)
      .writeUInt16BE(count);
  }

  public static readSellItemRet(reader: PacketReader): {
    errorCode: number;
    earnedSilver: number;
  } {
    const errorCode = reader.readUInt32BE();
    const earnedSilver = reader.readUInt32BE();
    return { errorCode, earnedSilver };
  }

  // Tavern
  public static buildTavernMoraReq(moraHand: number, npcId: number): PacketWriter {
    return new PacketWriter(Opcodes.CS_TavernMoraReq)
      .writeUInt8(moraHand)
      .writeUInt32BE(npcId);
  }

  public static readTavernMoraRet(reader: PacketReader): {
    errorCode: number;
    isWin: boolean;
    serverHand: number;
    awardSoulType: number;
    awardSoulValue: number;
  } {
    const errorCode = reader.readUInt32BE();
    const isWin = reader.readUInt8() === 1;
    const serverHand = reader.readUInt8();
    const awardSoulType = reader.readUInt8();
    const awardSoulValue = reader.readUInt32BE();
    return { errorCode, isWin, serverHand, awardSoulType, awardSoulValue };
  }

  public static buildTavernRecruitReq(heroId: number): PacketWriter {
    return new PacketWriter(Opcodes.CS_TavernRecruitReq)
      .writeUInt32BE(heroId);
  }

  public static readTavernRecruitRet(reader: PacketReader): {
    errorCode: number;
    recruitedHeroId: number;
  } {
    const errorCode = reader.readUInt32BE();
    const recruitedHeroId = reader.readUInt32BE();
    return { errorCode, recruitedHeroId };
  }

  // Task / Quest
  public static buildQuestActionReq(actionType: number, taskId: number): PacketWriter {
    return new PacketWriter(Opcodes.CS_Task_QuestActionReq)
      .writeUInt8(actionType)
      .writeUInt32BE(taskId);
  }

  public static readQuestActionRet(reader: PacketReader): {
    errorCode: number;
    taskId: number;
    status: number;
  } {
    const errorCode = reader.readUInt32BE();
    const taskId = reader.readUInt32BE();
    const status = reader.readUInt8();
    return { errorCode, taskId, status };
  }

  // Mail
  public static buildMailInitDataReq(): PacketWriter {
    return new PacketWriter(Opcodes.CS_Mail_InitDataReq);
  }

  public static readMailInitDataRep(reader: PacketReader): { mails: MailDto[] } {
    const count = reader.readUInt16BE();
    const mails: MailDto[] = [];
    for (let i = 0; i < count; i++) {
      const id = reader.readUInt32BE();
      const sender = reader.readFlushUTF();
      const title = reader.readFlushUTF();
      const content = reader.readFlushUTF();
      const hasGift = reader.readUInt8();
      const silver = reader.readUInt32BE();
      const gold = reader.readUInt32BE();
      const isRead = reader.readUInt8();
      mails.push({ id, sender, title, content, hasGift, silver, gold, isRead });
    }
    return { mails };
  }

  public static buildMailGetAttachmentReq(mailId: number): PacketWriter {
    return new PacketWriter(Opcodes.CS_Mail_GetAttachmentReq)
      .writeUInt32BE(mailId);
  }

  public static readMailGetAttachmentRep(reader: PacketReader): {
    errorCode: number;
    mailId: number;
    silver: number;
    gold: number;
  } {
    const errorCode = reader.readUInt32BE();
    const mailId = reader.readUInt32BE();
    const silver = reader.readUInt32BE();
    const gold = reader.readUInt32BE();
    return { errorCode, mailId, silver, gold };
  }


  // Tactical Deployment
  public static buildChangePositionReq(heroId: number, pos: number): PacketWriter {
    return new PacketWriter(Opcodes.CS_TacticalDeployment_ChangePositionReq)
      .writeUInt32BE(heroId)
      .writeUInt8(pos);
  }

  public static readChangePositionRet(reader: PacketReader): {
    resultCode: number;
    heroId: number;
    newPos: number;
  } {
    const resultCode = reader.readUInt8();
    const heroId = reader.readUInt32BE();
    const newPos = reader.readUInt8();
    return { resultCode, heroId, newPos };
  }

  // Guild
  public static buildGuildInitReq(): PacketWriter {
    return new PacketWriter(Opcodes.CS_Guild_InitReq);
  }

  public static readGuildInitRet(reader: PacketReader): {
    guildName: string;
    level: number;
    leaderName: string;
    treasury: number;
    playerContribution: number;
    membersCount: number;
    maxMembers: number;
  } {
    const guildName = reader.readFlushUTF();
    const level = reader.readUInt16BE();
    const leaderName = reader.readFlushUTF();
    const treasury = reader.readUInt32BE();
    const playerContribution = reader.readUInt32BE();
    const membersCount = reader.readUInt16BE();
    const maxMembers = reader.readUInt16BE();
    return { guildName, level, leaderName, treasury, playerContribution, membersCount, maxMembers };
  }

  public static buildGuildDonateReq(amount: number = 1000): PacketWriter {
    return new PacketWriter(Opcodes.CS_Guild_DonateReq).writeUInt32BE(amount);
  }

  public static readGuildDonateRet(reader: PacketReader): {
    errorCode: number;
    newContribution: number;
    newSilver: number;
  } {
    const errorCode = reader.readUInt32BE();
    const newContribution = reader.readUInt32BE();
    const newSilver = reader.readUInt32BE();
    return { errorCode, newContribution, newSilver };
  }

  // Gift / CDK
  public static buildRedeemCodeReq(code: string): PacketWriter {
    return new PacketWriter(Opcodes.CS_Gift_RedeemCodeReq).writeFlushUTF(code);
  }

  public static readRedeemCodeRet(reader: PacketReader): {
    errorCode: number;
    code: string;
    silverAward: number;
    couponsAward: number;
  } {
    const errorCode = reader.readUInt32BE();
    const code = reader.readFlushUTF();
    const silverAward = reader.readUInt32BE();
    const couponsAward = reader.readUInt32BE();
    return { errorCode, code, silverAward, couponsAward };
  }

  // Char / Hero Upgrade
  public static buildCharUpgradeReq(): PacketWriter {
    return new PacketWriter(Opcodes.CS_Account_CharUpgradeReq);
  }

  public static readCharUpgradeNtf(reader: PacketReader): {
    heroId: number;
    level: number;
    combatPower: number;
  } {
    const heroId = reader.readUInt32BE();
    const level = reader.readUInt16BE();
    const combatPower = reader.readUInt32BE();
    return { heroId, level, combatPower };
  }

  // Battle
  public static readBattleStartReport(reader: PacketReader): {
    battleId: string;
  } {
    const battleId = reader.readFlushUTF();
    return { battleId };
  }

  public static readSingleBattleResult(reader: PacketReader): {
    result: number;
    rewardExp: number;
    rewardSilver: number;
  } {
    const result = reader.readUInt8();
    const rewardExp = reader.readUInt32BE();
    const rewardSilver = reader.readUInt32BE();
    return { result, rewardExp, rewardSilver };
  }
}

