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
import {
  ChatPackets,
  BackpackPackets,
  TacticalDeploymentPackets,
  TavernPackets,
  AccountPackets,
  TaskPackets,
  MailPackets,
  GuildPackets,
  GiftPackets,
} from './Packets.js';

export class Session {
  public ws: WebSocket;
  public player?: Player;
  public userId?: string;

  constructor(ws: WebSocket) {
    this.ws = ws;
    this.ws.binaryType = 'arraybuffer';

    TownManager.getInstance().registerSession(this);

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

      // 7. CS_Chat_ChatInfo
      case Opcodes.CS_Chat_ChatInfo: {
        if (!this.player) return;
        const chatReq = ChatPackets.readChatInfo(reader);
        console.log(`[CHAT] [Canal ${chatReq.channel}] ${this.player.data.name}: ${chatReq.content}`);

        if (chatReq.channel === 0) {
          // Sussurro Privado
          const targetPlayer = PlayerManager.getInstance().getPlayerByName(chatReq.targetName);
          if (targetPlayer) {
            const targetSession = TownManager.getInstance().getSessionByPlayerId(targetPlayer.data.charId);
            if (targetSession) {
              const whisperToTarget = ChatPackets.buildChatInfoRet(
                0,
                this.player.data.charId,
                0,
                this.player.data.name,
                this.player.data.vipLevel,
                0,
                chatReq.content
              );
              targetSession.send(whisperToTarget);

              const whisperEcho = ChatPackets.buildWhisperEchoplex(
                targetPlayer.data.charId,
                0,
                targetPlayer.data.name,
                chatReq.content
              );
              this.send(whisperEcho);
              break;
            }
          }
          this.send(ChatPackets.buildChatNotReach(chatReq.targetName, 1));
        } else {
          // Broadcast Geral / Vila / Guilda
          const broadcastPkt = ChatPackets.buildChatInfoRet(
            chatReq.channel,
            this.player.data.charId,
            0,
            this.player.data.name,
            this.player.data.vipLevel,
            0,
            chatReq.content
          );
          TownManager.getInstance().broadcastGlobal(broadcastPkt);
        }
        break;
      }

      // 8. CS_Backpack_LoadBag
      case Opcodes.CS_Backpack_LoadBag: {
        if (!this.player) return;
        this.send(BackpackPackets.buildLoadBagResult(this.player.data.items));
        break;
      }

      // 9. CS_Backpack_UseAppliance
      case Opcodes.CS_Backpack_UseAppliance: {
        if (!this.player) return;
        const useReq = BackpackPackets.readUseAppliance(reader);
        const itemIdx = this.player.data.items.findIndex(
          (it) => it.guidHigh === useReq.guidHigh && it.guidLow === useReq.guidLow
        );

        if (itemIdx >= 0) {
          const item = this.player.data.items[itemIdx];
          const consumeCount = Math.min(item.quantity, useReq.count);
          item.quantity -= consumeCount;

          let remainingCount = item.quantity;
          if (item.quantity <= 0) {
            this.player.data.items.splice(itemIdx, 1);
            remainingCount = 0;
          }

          this.send(BackpackPackets.buildUseApplianceRet(useReq.guidHigh, useReq.guidLow, remainingCount, 0));

          // Efeitos de Consumo Canônico
          if (item.templateId === 2001 || item.templateId === 1010001 || item.templateId === 10001) {
            // Ramen Ichiraku / Pílula: restaura 20 Vigor e 250 HP
            this.player.data.curHealth = Math.min(this.player.data.maxHealth, this.player.data.curHealth + 250);
            this.player.data.militaryOrders = Math.min(100, (this.player.data.militaryOrders || 50) + 20);
            this.send(AccountPackets.buildCharBaseInfoUpdate({ curHp: this.player.data.curHealth }));
            console.log(`[BACKPACK] ${this.player.data.name} consumiu Ramen! Vigor: ${this.player.data.militaryOrders}, HP: ${this.player.data.curHealth}`);
          } else if (item.templateId === 3001 || item.templateId === 10002) {
            // Pergaminho de Chakra: +150 EXP
            this.player.data.exp += 150;
            this.send(AccountPackets.buildCharBaseInfoUpdate({ exp: this.player.data.exp }));
            console.log(`[BACKPACK] ${this.player.data.name} usou Pergaminho! EXP: ${this.player.data.exp}`);
          }

          // Enviar inventário sincronizado
          this.send(BackpackPackets.buildLoadBagResult(this.player.data.items));
        } else {
          this.send(BackpackPackets.buildUseApplianceRet(useReq.guidHigh, useReq.guidLow, 0, 1));
        }
        break;
      }

      // 10. CS_Backpack_SellItem
      case Opcodes.CS_Backpack_SellItem: {
        if (!this.player) return;
        const sellReq = BackpackPackets.readSellItem(reader);
        const itemIdx = this.player.data.items.findIndex(
          (it) => it.guidHigh === sellReq.guidHigh && it.guidLow === sellReq.guidLow
        );

        if (itemIdx >= 0) {
          const item = this.player.data.items[itemIdx];
          const soldCount = Math.min(item.quantity, sellReq.count);
          const earnedSilver = soldCount * 120;

          item.quantity -= soldCount;
          if (item.quantity <= 0) {
            this.player.data.items.splice(itemIdx, 1);
          }

          this.player.data.silver += earnedSilver;
          this.send(BackpackPackets.buildSellItemRet(earnedSilver, 0));
          this.send(AccountPackets.buildCharBaseInfoUpdate({ silver: this.player.data.silver }));
        } else {
          this.send(BackpackPackets.buildSellItemRet(0, 1));
        }
        break;
      }

      // 11. CS_Backpack_MergeBagItem_Req
      case Opcodes.CS_Backpack_MergeBagItem_Req: {
        if (!this.player) return;
        this.player.data.items.sort((a, b) => a.templateId - b.templateId);
        this.send(BackpackPackets.buildMergeBagItemRet(0));
        this.send(BackpackPackets.buildLoadBagResult(this.player.data.items));
        break;
      }

      // 12. CS_TacticalDeployment_ChangePositionReq
      case Opcodes.CS_TacticalDeployment_ChangePositionReq: {
        if (!this.player) return;
        const posReq = TacticalDeploymentPackets.readChangePositionReq(reader);
        const formationIdx = this.player.data.formation.findIndex((f) => f.heroId === posReq.heroId);

        if (formationIdx >= 0) {
          this.player.data.formation[formationIdx].pos = posReq.pos;
        } else {
          this.player.data.formation.push({ heroId: posReq.heroId, pos: posReq.pos });
        }

        this.send(TacticalDeploymentPackets.buildChangePositionRet(posReq.heroId, posReq.pos, 0));
        break;
      }

      // 13. CS_TacticalDeployment_ChangeSkillReq
      case Opcodes.CS_TacticalDeployment_ChangeSkillReq: {
        if (!this.player) return;
        const skillReq = TacticalDeploymentPackets.readChangeSkillReq(reader);
        this.send(TacticalDeploymentPackets.buildChangeSkillRet(skillReq.heroId, skillReq.skillId, 0));
        break;
      }

      // 14. CS_Enter_Tavern
      case Opcodes.CS_Enter_Tavern: {
        if (!this.player) return;
        this.send(TavernPackets.buildEnterTavern(this.player.data.heroSouls));
        break;
      }

      // 15. CS_TavernMoraReq
      case Opcodes.CS_TavernMoraReq: {
        if (!this.player) return;
        const moraReq = TavernPackets.readTavernMoraReq(reader);
        const isWin = Math.random() >= 0.4;
        const serverHand = isWin
          ? (moraReq.moraHand + 1) % 3
          : (moraReq.moraHand + 2) % 3;

        let soulAward = 0;
        const soulType = moraReq.npcId >= 2 ? 2 : 1;

        if (isWin) {
          soulAward = 5;
          if (soulType === 1) this.player.data.heroSouls.blue += soulAward;
          else this.player.data.heroSouls.purple += soulAward;
        }

        this.send(TavernPackets.buildTavernMoraRet(isWin, serverHand, soulType, soulAward, 0));
        break;
      }

      // 16. CS_TavernRecruitReq
      case Opcodes.CS_TavernRecruitReq: {
        if (!this.player) return;
        const recruitReq = TavernPackets.readTavernRecruitReq(reader);
        if (!this.player.data.recruitedNinjas.includes(recruitReq.heroId)) {
          this.player.data.recruitedNinjas.push(recruitReq.heroId);
        }
        this.send(TavernPackets.buildTavernRecruitRet(recruitReq.heroId, 0));
        break;
      }

      // 17. CS_Account_CharBaseAttributeReq
      case Opcodes.CS_Account_CharBaseAttributeReq: {
        if (!this.player) return;
        this.send(AccountPackets.buildCharBaseAttributeRet(120, 145, 115, 2100));
        break;
      }

      // 18. CS_Account_UserFightVauleReq
      case Opcodes.CS_Account_UserFightVauleReq: {
        if (!this.player) return;
        this.send(AccountPackets.buildUserFightValueRet(this.player.data.combatPower));
        break;
      }

      // 19. CS_Task_AlreadyAcceptTaskReq
      case Opcodes.CS_Task_AlreadyAcceptTaskReq: {
        if (!this.player) return;
        this.send(TaskPackets.buildAlreadyAcceptTaskRet(this.player.data.quests));
        break;
      }

      // 20. CS_Task_QuestActionReq
      case Opcodes.CS_Task_QuestActionReq: {
        if (!this.player) return;
        const questReq = TaskPackets.readQuestActionReq(reader);
        const questIdx = this.player.data.quests.findIndex((q) => q.taskId === questReq.taskId);

        if (questReq.actionType === 1) {
          if (questIdx < 0) {
            this.player.data.quests.push({
              taskId: questReq.taskId,
              curProgress: 0,
              totalNeeded: 1,
              state: 1,
            });
          }
          this.send(TaskPackets.buildQuestActionRet(questReq.taskId, 1, 0));
        } else if (questReq.actionType === 2) {
          if (questIdx >= 0) {
            this.player.data.quests[questIdx].state = 2;
            this.player.data.silver += 500;
            this.player.data.exp += 250;
            this.send(AccountPackets.buildCharBaseInfoUpdate({
              silver: this.player.data.silver,
              exp: this.player.data.exp,
            }));
          }
          this.send(TaskPackets.buildQuestActionRet(questReq.taskId, 2, 0));
        }
        break;
      }

      // 21. CS_Mail_InitDataReq
      case Opcodes.CS_Mail_InitDataReq: {
        if (!this.player) return;
        this.send(MailPackets.buildMailInitDataRep(this.player.data.mails));
        break;
      }

      // 22. CS_Mail_GetAttachmentReq
      case Opcodes.CS_Mail_GetAttachmentReq: {
        if (!this.player) return;
        const mailReq = MailPackets.readGetAttachmentReq(reader);
        const mail = this.player.data.mails.find((m) => m.id === mailReq.mailId);

        if (mail && mail.hasGift) {
          const earnedSilver = mail.silver;
          const earnedGold = mail.gold;
          mail.hasGift = 0;
          mail.silver = 0;
          mail.gold = 0;
          mail.isRead = 1;

          this.player.data.silver += earnedSilver;
          this.player.data.gold += earnedGold;

          this.send(MailPackets.buildGetAttachmentRep(mail.id, earnedSilver, earnedGold, 0));
          this.send(AccountPackets.buildCharBaseInfoUpdate({
            silver: this.player.data.silver,
            gold: this.player.data.gold,
          }));
        } else {
          this.send(MailPackets.buildGetAttachmentRep(mailReq.mailId, 0, 0, 1));
        }
        break;
      }

      // 23. CS_Guild_InitReq
      case Opcodes.CS_Guild_InitReq: {
        if (!this.player) return;
        this.send(GuildPackets.buildGuildInitRet(
          'Vontade do Fogo',
          3,
          'Tsunade [Hokage]',
          485000,
          this.player.data.guildContribution || 1500,
          18,
          30
        ));
        break;
      }

      // 24. CS_Guild_DonateReq
      case Opcodes.CS_Guild_DonateReq: {
        if (!this.player) return;
        const donateReq = GuildPackets.readGuildDonateReq(reader);
        const amount = donateReq.donateAmount || 1000;

        if (this.player.data.silver >= amount) {
          this.player.data.silver -= amount;
          this.player.data.guildContribution = (this.player.data.guildContribution || 1500) + 100;

          this.send(GuildPackets.buildGuildDonateRet(this.player.data.guildContribution, this.player.data.silver, 0));
          this.send(AccountPackets.buildCharBaseInfoUpdate({ silver: this.player.data.silver }));

          // Broadcast na guilda
          TownManager.getInstance().broadcastGlobal(
            ChatPackets.buildChatInfoRet(
              3,
              this.player.data.charId,
              0,
              this.player.data.name,
              this.player.data.vipLevel,
              0,
              `✨ Doou ${amount.toLocaleString()} Ryo para a Guilda e recebeu +100 Pontos de Contribuição!`
            )
          );
        } else {
          this.send(GuildPackets.buildGuildDonateRet(this.player.data.guildContribution || 1500, this.player.data.silver, 1));
        }
        break;
      }

      // 25. CS_Gift_RedeemCodeReq
      case Opcodes.CS_Gift_RedeemCodeReq: {
        if (!this.player) return;
        const giftReq = GiftPackets.readRedeemCodeReq(reader);
        const code = (giftReq.code || '').trim().toUpperCase();

        if (code === 'NARUTO-BOND-2026' || code === 'KONOHA-CANONICAL-2026' || code === 'KONOHA-2026') {
          if (!this.player.data.redeemedCodes) {
            this.player.data.redeemedCodes = [];
          }

          if (this.player.data.redeemedCodes.includes(code)) {
            // Código já resgatado
            this.send(GiftPackets.buildRedeemCodeRet(code, 0, 0, 2));
            break;
          }

          this.player.data.redeemedCodes.push(code);
          const ryoAward = 50000;
          const couponAward = 200;

          this.player.data.silver += ryoAward;
          this.player.data.coupons = (this.player.data.coupons || 200) + couponAward;

          // Adicionar Itens Reais ao inventário
          // 5x Lámen Ichiraku (templateId: 2001)
          const ramen = this.player.data.items.find((it) => it.templateId === 2001);
          if (ramen) {
            ramen.quantity += 5;
          } else {
            this.player.data.items.push({
              guidHigh: 0,
              guidLow: Date.now() % 1000000,
              templateId: 2001,
              quantity: 5,
              level: 1,
              timingCategory: 0,
              timingState: 0,
              timingTime: 0,
              expireTick: 0,
              obtainType: 1,
            });
          }

          // 10x Pergaminho de Selamento (templateId: 3001)
          const scroll = this.player.data.items.find((it) => it.templateId === 3001);
          if (scroll) {
            scroll.quantity += 10;
          } else {
            this.player.data.items.push({
              guidHigh: 0,
              guidLow: (Date.now() + 1) % 1000000,
              templateId: 3001,
              quantity: 10,
              level: 1,
              timingCategory: 0,
              timingState: 0,
              timingTime: 0,
              expireTick: 0,
              obtainType: 1,
            });
          }

          this.send(GiftPackets.buildRedeemCodeRet(code, ryoAward, couponAward, 0));
          this.send(AccountPackets.buildCharBaseInfoUpdate({ silver: this.player.data.silver }));
          this.send(BackpackPackets.buildLoadBagResult(this.player.data.items));

          TownManager.getInstance().broadcastGlobal(
            ChatPackets.buildChatInfoRet(
              1,
              this.player.data.charId,
              0,
              'Sistema',
              0,
              0,
              `🎁 [Atividade] O ninja ${this.player.data.name} resgatou com sucesso o Pacote Comemorativo ${code}!`
            )
          );
        } else {
          // Código inválido
          this.send(GiftPackets.buildRedeemCodeRet(code, 0, 0, 1));
        }
        break;
      }

      // 26. CS_Account_CharUpgradeReq
      case Opcodes.CS_Account_CharUpgradeReq: {
        if (!this.player) return;
        const upgradeCost = 500;

        if (this.player.data.silver >= upgradeCost) {
          this.player.data.silver -= upgradeCost;
          this.player.data.combatPower += 60;
          this.player.data.maxHealth += 120;
          this.player.data.curHealth = this.player.data.maxHealth;

          const upgradePkt = new PacketWriter(Opcodes.SC_Account_CharUpgradeNtf)
            .writeUInt32BE(this.player.data.templateHeroId)
            .writeUInt16BE(this.player.data.level)
            .writeUInt32BE(this.player.data.combatPower);
          this.send(upgradePkt);

          this.send(AccountPackets.buildUserFightValueRet(this.player.data.combatPower));
          this.send(AccountPackets.buildCharBaseInfoUpdate({
            silver: this.player.data.silver,
            maxHp: this.player.data.maxHealth,
            curHp: this.player.data.curHealth,
          }));

          console.log(`[HERO] ${this.player.data.name} realizou Avanço Ninja! Novo Poder de Luta: ${this.player.data.combatPower}`);
        }
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

    // Sincroniza dados iniciais adicionais conforme o cliente canônico Flash
    this.send(AccountPackets.buildUserFightValueRet(this.player.data.combatPower));
    this.send(AccountPackets.buildCharBaseAttributeRet(120, 145, 115, 2100));
    this.send(BackpackPackets.buildLoadBagResult(this.player.data.items));
    this.send(TaskPackets.buildAlreadyAcceptTaskRet(this.player.data.quests));
    this.send(MailPackets.buildMailInitDataRep(this.player.data.mails));
  }

  private handleClose(): void {
    console.log(`[NET] Conexão encerrada: ${this.userId || 'anônimo'}`);
    TownManager.getInstance().leaveTown(this);
    TownManager.getInstance().unregisterSession(this);
  }
}
