package Processors.Game.Lobby
{
   import Components.Controls.*;
   import Components.Standard.*;
   import Debugging.*;
   import Externals.*;
   import Foundation.Common.*;
   import Foundation.Network.*;
   import Foundation.Queries.*;
   import Foundation.Queries.Coordinate.*;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.*;
   import Logics.Affairs.*;
   import Logics.Agent.SParametersCore;
   import Logics.Agent.SParametersNewCore;
   import Logics.ChatOptions.*;
   import Logics.CrossServerWar.TIntegralRankings;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.DatebaseVO.VO.TErrorCode;
   import Logics.DatebaseVO.VO.TPost;
   import Logics.Globalboss.TGlobalboss;
   import Logics.HyperStrings.THyperString;
   import Logics.Organization.TBaseOrganizationMember;
   import Processors.Game.*;
   import Processors.Game.Battle.*;
   import Processors.Game.Common.*;
   import Processors.Game.Common.Effects.Texts.*;
   import Processors.Game.Common.Effects.Transition.*;
   import Processors.Game.Lobby.AccessoryLing.TProcessorWindowAccessoryMain;
   import Processors.Game.Lobby.Account.*;
   import Processors.Game.Lobby.ActivityData.*;
   import Processors.Game.Lobby.ActivityInner.*;
   import Processors.Game.Lobby.Alien.TProcessorAlien;
   import Processors.Game.Lobby.Arena.*;
   import Processors.Game.Lobby.Automate.TProcessorAutoHangUp;
   import Processors.Game.Lobby.Backpack.*;
   import Processors.Game.Lobby.Baidu.TProcessorBaiDuMM;
   import Processors.Game.Lobby.BigDipper.*;
   import Processors.Game.Lobby.BindEmail.TProcessorBindEmail;
   import Processors.Game.Lobby.BloodFete.TProcessorWindowBloodFeteMainManageClass;
   import Processors.Game.Lobby.BloodSoulPurgatory.DataStructureForBloodSoul;
   import Processors.Game.Lobby.BloodSoulPurgatory.TProcessorWindowBloodSoulPurgatoryMain;
   import Processors.Game.Lobby.BugCommit.*;
   import Processors.Game.Lobby.CDK.TProcessorCDK;
   import Processors.Game.Lobby.Campaign.*;
   import Processors.Game.Lobby.Celebrate.TProcessorCelebrate;
   import Processors.Game.Lobby.Challenge.TProcessorChallenge;
   import Processors.Game.Lobby.ChallengeCamp.TProcessorChallengeCamp;
   import Processors.Game.Lobby.Chat.*;
   import Processors.Game.Lobby.CheatChecker.*;
   import Processors.Game.Lobby.CityDefend.TProcessorCityDefend;
   import Processors.Game.Lobby.Common.*;
   import Processors.Game.Lobby.Common.Shortcuts.*;
   import Processors.Game.Lobby.ConsumeVip.TProcessorConsumeVip;
   import Processors.Game.Lobby.CopyClassroom.*;
   import Processors.Game.Lobby.Counter.*;
   import Processors.Game.Lobby.CrossServerWar.TProcessorCrossServerWar;
   import Processors.Game.Lobby.CrossServerWar.TProcessorCrossServerWarWindows;
   import Processors.Game.Lobby.DailyActivity.TProcessorDailyActivity;
   import Processors.Game.Lobby.DailyQuest.*;
   import Processors.Game.Lobby.DailyWelfare.TProcessorDailyWelfare;
   import Processors.Game.Lobby.DialogMsg.*;
   import Processors.Game.Lobby.Discord.TProcessorDiscord;
   import Processors.Game.Lobby.Effects.*;
   import Processors.Game.Lobby.EightDoor.TProcessorWindowManEightDoor;
   import Processors.Game.Lobby.Emblem.TProcessorEmblem;
   import Processors.Game.Lobby.Exercise.AccountSafe.TProcessorAccountSafe;
   import Processors.Game.Lobby.Exercise.AccountTransfer.TProcessorAccountTransfer;
   import Processors.Game.Lobby.Exercise.BugList.TProcessorBugList;
   import Processors.Game.Lobby.Exercise.ChristmasDay.TProcessorChristmasDay;
   import Processors.Game.Lobby.Exercise.CommonRecharge.TProcessorCommonRecharge;
   import Processors.Game.Lobby.Exercise.ConsumeRank.TProcessorConsumeRank;
   import Processors.Game.Lobby.Exercise.DayRechargeGift.TProcessorDayRechargeGift;
   import Processors.Game.Lobby.Exercise.Dice.TProcessorDice;
   import Processors.Game.Lobby.Exercise.DragonBoat.TProcessorDragonBoat;
   import Processors.Game.Lobby.Exercise.FrogWallet.TProcessorFrogWallet;
   import Processors.Game.Lobby.Exercise.RechargeRank.TProcessorRechargeRank;
   import Processors.Game.Lobby.Exercise.SantaClaus.TProcessorSantaClaus;
   import Processors.Game.Lobby.Exercise.SeventhEvening.TProcessorSeventhEvening;
   import Processors.Game.Lobby.Exercise.TProcessorActivityManager;
   import Processors.Game.Lobby.Exercise.TenTail.TProcessorTenTail;
   import Processors.Game.Lobby.Exercise.UpdateList.TProcessorUpdateList;
   import Processors.Game.Lobby.Exercise.VKSiMiDa.TProcessorVkSiMiDa;
   import Processors.Game.Lobby.Exercise.VipFreeBuy.TProcessorVIPFreeBuy;
   import Processors.Game.Lobby.Exercise.VipShop.TProcessorVipShop;
   import Processors.Game.Lobby.Exercise.WorldCup.TProcessorActivityLevelManager;
   import Processors.Game.Lobby.FightPet.TProcessorFightPet;
   import Processors.Game.Lobby.FirstRecharge.*;
   import Processors.Game.Lobby.FreshGuide.*;
   import Processors.Game.Lobby.Friends.*;
   import Processors.Game.Lobby.GeneralStar.*;
   import Processors.Game.Lobby.GiftBag.*;
   import Processors.Game.Lobby.Global.TProcessorGlobalBattle;
   import Processors.Game.Lobby.Globalboss.TProcessorGlobalBoss;
   import Processors.Game.Lobby.Globalboss.TProcessorGlobalBossMain;
   import Processors.Game.Lobby.Globalboss.TProcessorGlobalbossChapter;
   import Processors.Game.Lobby.GodEquip.TProcessorGodEquip;
   import Processors.Game.Lobby.GoodsPurchase.*;
   import Processors.Game.Lobby.GroupBattle.Plate.TProcessorGroupBattleRoomUI;
   import Processors.Game.Lobby.GroupBattle.TProcessorGroupBattle;
   import Processors.Game.Lobby.Heros.*;
   import Processors.Game.Lobby.Homeland.THomelandModel;
   import Processors.Game.Lobby.Homeland.TProcessorHomeland;
   import Processors.Game.Lobby.Illustrated.TProcessorIllustrated;
   import Processors.Game.Lobby.Inspector.*;
   import Processors.Game.Lobby.InviteCode.TProcessorInviteCode;
   import Processors.Game.Lobby.Jade.*;
   import Processors.Game.Lobby.KillHeros.*;
   import Processors.Game.Lobby.KingWar.TProcessorKingWar;
   import Processors.Game.Lobby.Lead.TProcessorLeadLevelGifts;
   import Processors.Game.Lobby.LostShenqi.TProcessorLostShenQiMain;
   import Processors.Game.Lobby.Lottery.TProcessorLottery;
   import Processors.Game.Lobby.Magic.TProcessorMagic;
   import Processors.Game.Lobby.Mail.*;
   import Processors.Game.Lobby.MainScene.*;
   import Processors.Game.Lobby.MainScene.Role.TUIRoleCanMovePlayerRole;
   import Processors.Game.Lobby.MakeEquip.*;
   import Processors.Game.Lobby.MakeEquipAdvanced.*;
   import Processors.Game.Lobby.Mall.*;
   import Processors.Game.Lobby.Married.TMarriedModel;
   import Processors.Game.Lobby.Married.TProcessorMarried;
   import Processors.Game.Lobby.MarryRank.TMarryRankModel;
   import Processors.Game.Lobby.MarryRank.TProcessorMarryRank;
   import Processors.Game.Lobby.MasterRoad.TProcessorMasterRoad;
   import Processors.Game.Lobby.MasterRoad.TProcessorMasterRoadOld;
   import Processors.Game.Lobby.Medal.TProcessorMedal;
   import Processors.Game.Lobby.Mentorship.TProcessorMentorship;
   import Processors.Game.Lobby.ModuleLoader.*;
   import Processors.Game.Lobby.NarutoHelper.TProcessorNarutoHelper;
   import Processors.Game.Lobby.NarutoRoad.TProcessorNarutoRoad;
   import Processors.Game.Lobby.NarutoRoad.TProcessorPopNarutoRoad;
   import Processors.Game.Lobby.NijiaMystic.TProcessorNijiaMystic;
   import Processors.Game.Lobby.NijiaStar.TProcessorNijiaStar;
   import Processors.Game.Lobby.NinJaPractice.TProcessorNinJaPractice;
   import Processors.Game.Lobby.NinjaHostel.TProcessorNinjaHostel;
   import Processors.Game.Lobby.NinjaRelationship.TProcessorNinjaRelationship;
   import Processors.Game.Lobby.OhtsutsukiKaguya.TProcessorOhtsutsukiKaguya;
   import Processors.Game.Lobby.OnLineLiBao.TProcessorMicrologinLibao;
   import Processors.Game.Lobby.OnLineLiBao.TProcessorOnLineLiBao;
   import Processors.Game.Lobby.Organization.FightPetCopy.TProcessorFightPetCopy;
   import Processors.Game.Lobby.Organization.TProcessorOrganization;
   import Processors.Game.Lobby.OrganizationalWar.TProcessorOrganizationalWar;
   import Processors.Game.Lobby.Palace.TProcessorExplanation;
   import Processors.Game.Lobby.Palace.TProcessorPalace;
   import Processors.Game.Lobby.Pet.*;
   import Processors.Game.Lobby.PopTips.*;
   import Processors.Game.Lobby.Post.TProcessorPost;
   import Processors.Game.Lobby.Prerogative.TProcessorPrerogative;
   import Processors.Game.Lobby.Protagonist.*;
   import Processors.Game.Lobby.Quests.*;
   import Processors.Game.Lobby.Ramen.*;
   import Processors.Game.Lobby.Rank.TProcessorRank;
   import Processors.Game.Lobby.RebirthRealm.TProcessorWindowRebirthRealmAllManager;
   import Processors.Game.Lobby.RechageCashBack.*;
   import Processors.Game.Lobby.Recharge.*;
   import Processors.Game.Lobby.Recruit.TProcessorRecruit;
   import Processors.Game.Lobby.SevenKing.TProcessorSevenKing;
   import Processors.Game.Lobby.ShinobidoPractise.TProcessorShinobidoPractise;
   import Processors.Game.Lobby.Shop.TProcessorWindowShop;
   import Processors.Game.Lobby.Shortcuts.*;
   import Processors.Game.Lobby.Sign.*;
   import Processors.Game.Lobby.SixFairy.TProcessorWindowSixFairyMain;
   import Processors.Game.Lobby.Slave.TProcessorSlave;
   import Processors.Game.Lobby.Smithy.*;
   import Processors.Game.Lobby.Spaces.*;
   import Processors.Game.Lobby.SpecialJade.TSpecialJade;
   import Processors.Game.Lobby.Store.TPressorWindowNewMall;
   import Processors.Game.Lobby.SummonBattle.TProcessorSummonBattle;
   import Processors.Game.Lobby.SuperHero.*;
   import Processors.Game.Lobby.SystemActivity.TProcessorSystemActivity;
   import Processors.Game.Lobby.Taboo.TPressorWindowTaboo;
   import Processors.Game.Lobby.TacticalDeployment.*;
   import Processors.Game.Lobby.Talent.TProcessorHeroLevelGifts;
   import Processors.Game.Lobby.Talent.TProcessorNinjaTalent;
   import Processors.Game.Lobby.Talent.TProcessorTalentGifts;
   import Processors.Game.Lobby.Talent.TProcessorTalentLevelGifts;
   import Processors.Game.Lobby.Talisman.*;
   import Processors.Game.Lobby.Tavern.*;
   import Processors.Game.Lobby.TheWorldTree.TProcessorWindowTheWorldTree;
   import Processors.Game.Lobby.Title.TProcessorTitle;
   import Processors.Game.Lobby.TongLing.TPressorWindowTongLing;
   import Processors.Game.Lobby.TopOrganization.TProcessorTopOrganization;
   import Processors.Game.Lobby.TopTeam.Plate.TProcessorPlateTopTeamRoomUI;
   import Processors.Game.Lobby.TopTeam.TProcessorTopTeam;
   import Processors.Game.Lobby.Tower.TProcessorTower;
   import Processors.Game.Lobby.TraitorAttack.TProcessorTraitorAttack;
   import Processors.Game.Lobby.TransmigrationAccessory.TProcessorTransmigrationAccessory;
   import Processors.Game.Lobby.TransmigrationTrial.TProcessorTransmigrationTrial;
   import Processors.Game.Lobby.TreasureMap.*;
   import Processors.Game.Lobby.Undertown.TProcessorUndertown;
   import Processors.Game.Lobby.Unlock.*;
   import Processors.Game.Lobby.VIP.*;
   import Processors.Game.Lobby.VipWelfare.TProcessorVipWelfare;
   import Processors.Game.Lobby.Warehouse.TProcessorWarehouse;
   import Processors.Game.Lobby.Wing.TProcessorWing;
   import Processors.Game.Lobby.WorldMap.*;
   import Processors.Game.Lobby.WorldMatch.TProcessorWorldMatch;
   import Processors.Game.Lobby.WorldMatch.TProcessorWorldMatchStreak;
   import Processors.Game.Lobby.WuXing.TProcessorWuxing;
   import Processors.Game.Lobby.ZhenAoYi.TProcessorZhenAoYi;
   import Processors.Game.Lobby.awaken.TProcessorWindowManAwaken;
   import Resources.Constants.*;
   import Resources.Strings.*;
   import Utilities.Move.SlowMovingAnyResource;
   import flash.display.BitmapData;
   import flash.events.*;
   import flash.utils.*;
   
   use namespace LobbySpace;
   
   public class TProcessorLobby extends TProcessorGame
   {
      
      public static var SkillShowTimeFunction:Function;
      
      protected static const AFFAIRID_TimingWaitBattleActive:uint = 1;
      
      protected static const AFFAIRID_TimingWaitBattleLoading:uint = 2;
      
      protected static const AFFAIRID_ChatOptionsSetup:uint = 16777216;
      
      protected static const AFFAIRID_ChatOptionsApply:uint = 16777217;
      
      protected static const AFFAIRID_GameStateExternalize:uint = 33554432;
      
      protected static const AFFAIRID_GarbageCollector:uint = 50331648;
      
      protected static const AFFAIRID_OpenSocketLoading:uint = 67108864;
      
      protected static const AFFAIRID_CloseSocketLoading:uint = 67108865;
      
      public static const CAPACITY_ParallelOutputRows:uint = CONST_EFFECT.CAPACITY_ParallelOutputRows;
      
      public static const TYPE_EFFECTTEXT:uint = 1;
      
      public static const TYPE_DIALOGMSG:uint = 2;
      
      protected var FParameters:TLobbyParameters;
      
      protected var FShortcutAvatarModes:TLobbyShortcutAvatarModes;
      
      protected var FShortcutActivityModes:TLobbyShortcutActivityModes;
      
      protected var FShortcutActiveSpecialModes:TLobbyShortcutActiveSpecialModes;
      
      protected var FShortcutFunctionModes:TLobbyShortcutFunctionModes;
      
      protected var FShortcutMapModes:TLobbyShortcutMapModes;
      
      protected var FShortcutQuestGuideModes:TLobbyShortcutQuestGuideModes;
      
      protected var FShortcuConstantlyModes:TLobbyShortcutConstantlyModes;
      
      protected var FChatOptions:TChatOptions;
      
      protected var FQueryBoolean:TQueryBoolean;
      
      protected var FMountPointPlate:TProcessorMountPoint;
      
      protected var FMountPointFreshGuideNpc:TProcessorMountPoint;
      
      protected var FMountPointChat:TProcessorMountPoint;
      
      protected var FMountPointShortcuts:TProcessorMountPoint;
      
      protected var FMountPointShortcutsSpecial:TProcessorMountPoint;
      
      protected var FMountPointIcons:TProcessorMountPoint;
      
      protected var FMountPointFreshGuideSearchWay:TProcessorMountPoint;
      
      protected var FMountPointBarrier:TProcessorMountPoint;
      
      protected var FMountPointWindows:TProcessorMountPoint;
      
      protected var FMountPointOverview:TProcessorMountPoint;
      
      protected var FMountPointWindow:TProcessorMountPoint;
      
      protected var FMountPointLogicModule:TProcessorMountPoint;
      
      protected var FMountPointFreshGuide:TProcessorMountPoint;
      
      protected var FMountPointFreshGuideAllUp:TProcessorMountPoint;
      
      protected var FBarrier:TUIBarrier;
      
      protected var FProcessorAccount:TProcessorAccount;
      
      protected var FProcessorMainScene:TProcessorMainScene;
      
      protected var FProcessorTavern:TProcessorTavern;
      
      protected var FProcessorWorldMap:TProcessorWorldMap;
      
      protected var FProcessorBattleScene:TProcessorBattleScene;
      
      protected var FProcessorArena:TProcessorArena;
      
      protected var FProcessorTreasureMap:TProcessorTreasureMap;
      
      protected var FProcessorSuperHero:TProcessorSuperHero;
      
      protected var FOrganizationalWar:TProcessorOrganizationalWar;
      
      protected var FProcessorCityDefend:TProcessorCityDefend;
      
      protected var FProcessorFightPet:TProcessorFightPet;
      
      protected var FProcessorNijiaStar:TProcessorNijiaStar;
      
      protected var FProcessorSevenKing:TProcessorSevenKing;
      
      protected var FProcessorCrossServerWar:TProcessorCrossServerWar;
      
      protected var FProcessorPalace:TProcessorPalace;
      
      protected var FProcessorAnimalSeal:TProcessorFightPetCopy;
      
      protected var FProcessorGroupBattleRoomUI:TProcessorGroupBattleRoomUI;
      
      protected var FProcessorPlateTopTeamRoomUI:TProcessorPlateTopTeamRoomUI;
      
      protected var FProcessorWindowBloodSoulPurgatoryMain:TProcessorWindowBloodSoulPurgatoryMain;
      
      protected var FProcessorWindowSixFairyMain:TProcessorWindowSixFairyMain;
      
      protected var FProcessorWindowRebirthRealmAllManager:TProcessorWindowRebirthRealmAllManager;
      
      protected var FProcessorLobbyOneLyErrorWindows:TProcessorLobbyOneLyErrorWindows;
      
      protected var FProcessorWindowNijiaMystic:TProcessorNijiaMystic;
      
      protected var FProcessorShortcuts:TProcessorShortcuts;
      
      protected var FProcessorChat:TProcessorChat;
      
      protected var FProcessorPopTips:TProcessorPopTips;
      
      protected var FProcessorNarutoRoadTip:TProcessorPopNarutoRoad;
      
      protected var FProcessorFreshGuide:TProcessorFreshGuide;
      
      protected var FProcessorProtagonist:TProcessorProtagonist;
      
      protected var FProcessorHeros:TProcessorHeros;
      
      protected var FProcessorTacticalDeployment:TProcessorTacticalDeployment;
      
      protected var FProcessorBackpack:TProcessorBackpack;
      
      protected var FProcessorPet:TProcessorPet;
      
      protected var FProcessorSmithy:TProcessorSmithy;
      
      protected var FProcessorQuest:TProcessorQuest;
      
      protected var FProcessorMakeEquip:TProcessorMakeEquip;
      
      protected var FProcessorKillHeros:TProcessorKillHeros;
      
      protected var FProcessorBigDipper:TProcessorBigDipper;
      
      protected var FProcessorGeneralStar:TProcessorGeneralStar;
      
      protected var FProcessorJade:TProcessorJade;
      
      protected var FProcessorTalisman:TProcessorTalisman;
      
      protected var FProcessorEquipAdvanced:TProcessorEquipAdvanced;
      
      protected var FProcessorMail:TProcessorMail;
      
      protected var FProcessorRamen:TProcessorRamen;
      
      protected var FProcessorFriend:TProcessorFriend;
      
      protected var FProcessorVIP:TProcessorVIP;
      
      protected var FProcessorMall:TProcessorMall;
      
      protected var FPressorWindowNewMall:TPressorWindowNewMall;
      
      protected var FProcessorDailySign:TProcessorDailySign;
      
      protected var FProcessorBugCommit:TProcessorBugCommit;
      
      protected var FProcessorDailyQuest:TProcessorDailyQuest;
      
      protected var FProcessorGoodsPurchase:TProcessorGoodsPurchase;
      
      protected var FProcessorCopyHero:TProcessorCopyClassroom;
      
      protected var FProcessorRecharge:TProcessorRecharge;
      
      protected var FProcessorFirstRecharge:TProcessorFirstRecharge;
      
      protected var FProcessorWonderfulActivity:TProcessorWonderfulActivity;
      
      protected var FProcessorGiftBag:TProcessorGiftBag;
      
      protected var FProcessorRechargeCashback:TProcessorRechargeCashback;
      
      protected var FProcessorDailyActivity:TProcessorDailyActivity;
      
      protected var FProcessorOrganization:TProcessorOrganization;
      
      protected var FProcessorCDK:TProcessorCDK;
      
      protected var FProcessorPost:TProcessorPost;
      
      protected var FProcessorNarutoRoad:TProcessorNarutoRoad;
      
      protected var FProcessorShinobidoPractise:TProcessorShinobidoPractise;
      
      protected var FProcessorLottery:TProcessorLottery;
      
      protected var FProcessorSystemActivity:TProcessorSystemActivity;
      
      protected var FProcessorDragonBoat:TProcessorDragonBoat;
      
      protected var FProcessorMentorship:TProcessorMentorship;
      
      protected var FProcessorTraitorAttack:TProcessorTraitorAttack;
      
      protected var FProcessorCelebrate:TProcessorCelebrate;
      
      protected var FProcessorFrogWallet:TProcessorFrogWallet;
      
      protected var FProcessorVipShop:TProcessorVipShop;
      
      protected var FProcessorRechargeRank:TProcessorRechargeRank;
      
      protected var FProcessorCrossServerWarWindows:TProcessorCrossServerWarWindows;
      
      protected var FProcessorGodEquip:TProcessorGodEquip;
      
      protected var FProcessorDice:TProcessorDice;
      
      protected var FProcessorConsumeRank:TProcessorConsumeRank;
      
      protected var FProcessorCommonRecharge:TProcessorCommonRecharge;
      
      protected var FProcessorTenTail:TProcessorTenTail;
      
      protected var FProcessorVIPFreeBuy:TProcessorVIPFreeBuy;
      
      protected var FProcessorSeventhEvening:TProcessorSeventhEvening;
      
      protected var FProcessorMagic:TProcessorMagic;
      
      protected var FProcessorTower:TProcessorTower;
      
      protected var FProcessorDailyWelfare:TProcessorDailyWelfare;
      
      protected var FProcessorExplanation:TProcessorExplanation;
      
      protected var FPocessorNinJaPractice:TProcessorNinJaPractice;
      
      protected var FProcessorTopOrganization:TProcessorTopOrganization;
      
      protected var FProcessorTongLing:TPressorWindowTongLing;
      
      protected var FProcessorActivityManager:TProcessorActivityManager;
      
      protected var FProcessorSantaClaus:TProcessorSantaClaus;
      
      protected var FProcessorUpdateList:TProcessorUpdateList;
      
      protected var FProcessorBugList:TProcessorBugList;
      
      protected var FProcessorGroupBattle:TProcessorGroupBattle;
      
      protected var FProcessorTopTeam:TProcessorTopTeam;
      
      protected var FProcessorNarutoHelper:TProcessorNarutoHelper;
      
      protected var FProcessorPrerogative:TProcessorPrerogative;
      
      protected var FProcessorNinjaHostel:TProcessorNinjaHostel;
      
      protected var FProcessorWindowBloodFeteMainManageClass:TProcessorWindowBloodFeteMainManageClass;
      
      protected var FProcessorNinjaRelationship:TProcessorNinjaRelationship;
      
      protected var FProcessorWindowManAwaken:TProcessorWindowManAwaken;
      
      protected var FProcessorWindowTheWorldTree:TProcessorWindowTheWorldTree;
      
      protected var FProcessorWindowManEightDoor:TProcessorWindowManEightDoor;
      
      protected var FTProcessorBaiDuMM:TProcessorBaiDuMM;
      
      protected var FPressorWindowTaboo:TPressorWindowTaboo;
      
      protected var FProcessorOhtsutsukiKaguya:TProcessorOhtsutsukiKaguya = null;
      
      protected var FProcessorTransmigrationTrial:TProcessorTransmigrationTrial;
      
      protected var FProcessorTransmigrationAccessory:TProcessorTransmigrationAccessory;
      
      protected var FProcessorVkSiMiDa:TProcessorVkSiMiDa;
      
      protected var FProcessorAccountTransfer:TProcessorAccountTransfer;
      
      protected var FProcessorWindowUndertown:TProcessorUndertown;
      
      protected var FProcessorOnLineLiBao:TProcessorOnLineLiBao;
      
      protected var FProcessorZhenAoYi:TProcessorZhenAoYi;
      
      protected var FProcessorMasterRoadOld:TProcessorMasterRoadOld;
      
      protected var FProcessorLostShenQiMain:TProcessorLostShenQiMain;
      
      protected var FProcessorWing:TProcessorWing;
      
      protected var FProcessorWindowAddSoul:TProcessorWindowAddSoul;
      
      protected var FProcessorMasterRoad:TProcessorMasterRoad;
      
      protected var FProcessorChallenge:TProcessorChallenge;
      
      protected var FProcessorIllustrated:TProcessorIllustrated;
      
      protected var FProcessorMarried:TProcessorMarried;
      
      protected var FProcessorHomeland:TProcessorHomeland;
      
      protected var FProcessorMarryRank:TProcessorMarryRank;
      
      protected var FSpecialJade:TSpecialJade;
      
      protected var FProcessorAline:TProcessorAlien;
      
      protected var FProcessorBindEmail:TProcessorBindEmail;
      
      protected var FProcessorAccountSafe:TProcessorAccountSafe;
      
      protected var FProcessorRank:TProcessorRank;
      
      protected var FProcessorKingWar:TProcessorKingWar;
      
      protected var FProcessorVipWelfare:TProcessorVipWelfare;
      
      protected var FProcessorMicrologinLibao:TProcessorMicrologinLibao;
      
      protected var FProcessorMedal:TProcessorMedal;
      
      protected var FProcessorInviteCode:TProcessorInviteCode;
      
      protected var FProcessorWuxing:TProcessorWuxing;
      
      protected var FProcessorWarehouse:TProcessorWarehouse;
      
      protected var FProcessorDiscord:TProcessorDiscord;
      
      protected var FProcessorGlobalBattle:TProcessorGlobalBattle;
      
      protected var FProcessorWindowShop:TProcessorWindowShop;
      
      protected var FProcessorConsumeVip:TProcessorConsumeVip;
      
      protected var FProcessorEmblem:TProcessorEmblem;
      
      protected var FProcessorWorldMatch:TProcessorWorldMatch;
      
      protected var FProcessorChristmasDay:TProcessorChristmasDay;
      
      protected var FProcessorSummonBattle:TProcessorSummonBattle;
      
      protected var FProcessorNinjaTalent:TProcessorNinjaTalent;
      
      protected var FProcessorChallengeCamp:TProcessorChallengeCamp;
      
      protected var FProcessorTalentLevelGifts:TProcessorTalentLevelGifts;
      
      protected var FProcessorHeroLevelGifts:TProcessorHeroLevelGifts;
      
      protected var FProcessorWorldMatchStreak:TProcessorWorldMatchStreak;
      
      protected var FProcessorGlobalBoss:TProcessorGlobalBoss;
      
      protected var FProcessorGlobalBossMain:TProcessorGlobalBossMain;
      
      protected var FProcessorGlobalbossChapter:TProcessorGlobalbossChapter;
      
      protected var FProcessorDayRechargeGift:TProcessorDayRechargeGift;
      
      protected var FProcessorRecruit:TProcessorRecruit;
      
      protected var FProcessorSlave:TProcessorSlave;
      
      protected var FProcessorTalentGifts:TProcessorTalentGifts;
      
      protected var FProcessorLeadLevelGifts:TProcessorLeadLevelGifts;
      
      protected var FProcessorCheatChecker:TProcessorCheatChecker;
      
      protected var FProcessorCounter:TProcessorCounter;
      
      protected var FProcessorActivity:TProcessorActivityData;
      
      protected var FProcessorAutoHangUp:TProcessorAutoHangUp;
      
      protected var FProcessorTitle:TProcessorTitle;
      
      protected var FProcessorInspector:TProcessorInspector;
      
      protected var FProcessorModuleLoader:TProcessorModuleLoader;
      
      protected var FProcessorUnlock:TProcessorUnlock;
      
      protected var FProcessorEffect:TProcessorLobbyEffect;
      
      protected var FEffectTransition:TEffectTransition;
      
      protected var FProcessorDialogMsg:TProcessorDialogMsg;
      
      protected var FProcessorsPlate:Vector.<TProcessorLobbyPlate>;
      
      protected var FProcessorsWindows:Vector.<TProcessorLobbyWindows>;
      
      protected var FProcessorPlateActive:TProcessorLobbyPlate;
      
      protected var FProcessorWindowsActive:TProcessorLobbyWindows;
      
      protected var FOnLoadFollowUp:Function;
      
      protected var FOnSetupBattle:Function;
      
      protected var FOnSetupGroupBattle:Function;
      
      protected var FOnSetupTopTeamBattle:Function;
      
      protected var FOnQueryBattleActive:Function;
      
      protected var FOnQueryBattleLoading:Function;
      
      protected var FOnPurchaseQuery:Function;
      
      protected var FOnMarquee:Function;
      
      protected var FOnTyphon:Function;
      
      public var HideMarquee:Function;
      
      protected var FOnLogout:Function;
      
      protected var FOnLogin:Function;
      
      protected var FOnLoginDirSever:Function;
      
      protected var FSetSceneBitmapData:Function;
      
      protected var FProcessorCheckPlot:Function;
      
      protected var FProcessorPlayView:Function;
      
      protected var FOnUnLoadResource:Function;
      
      protected var FSetStatusType:Function;
      
      protected var FSetMonsterCount:Function;
      
      protected var FSetBattlePacket:Function;
      
      protected var FOnAntiAddiction:Function;
      
      protected var FOnCloseSocketLoading:Function;
      
      protected var FOnOpenSocketLoading:Function;
      
      protected var FEndBattle:Function;
      
      protected var FSetGroupBattleType:Function;
      
      protected var FSetGroupBattleInfor:Function;
      
      protected var FSetGroupBattleReward:Function;
      
      protected var FSetTopTeamBattleType:Function;
      
      protected var FSetTopTeamBattleInfor:Function;
      
      protected var FSetTopTeamBattleReward:Function;
      
      protected var FSetGlobalBattleScore:Function;
      
      protected var FSetGlobalboss:Function;
      
      protected var FOnGarbageCollector:Function;
      
      protected var FBeginSkillShow:Function;
      
      protected var FProcessorWindowAccessory:TProcessorWindowAccessoryMain = null;
      
      protected var Nimei:Boolean;
      
      protected var OneMyGod:Boolean;
      
      protected var OneTimes:Boolean;
      
      protected var ChatVisibel:Boolean;
      
      public function TProcessorLobby(param1:TUIComponent)
      {
         super(param1);
         SkillShowTimeFunction = this.BeginSkillShowF;
         this.FParameters = new TLobbyParameters();
         this.FShortcutAvatarModes = new TLobbyShortcutAvatarModes();
         this.FShortcutActivityModes = new TLobbyShortcutActivityModes();
         this.FShortcutActiveSpecialModes = new TLobbyShortcutActiveSpecialModes();
         this.FShortcutFunctionModes = new TLobbyShortcutFunctionModes();
         this.FShortcutMapModes = new TLobbyShortcutMapModes();
         this.FShortcutQuestGuideModes = new TLobbyShortcutQuestGuideModes();
         this.FShortcuConstantlyModes = new TLobbyShortcutConstantlyModes();
         this.FChatOptions = new TChatOptions();
         this.FQueryBoolean = new TQueryBoolean();
         this.ConstructMountPoints();
         this.FParameters.ActuatorBarrier.OnUpdate = this.ActuatorBarrierOnUpdate;
         this.FParameters.CoerceProperties(this.FMountPointIcons,this.FMountPointWindow);
         this.ConstructBarrier();
         this.ConstructProcessorsPlate();
         this.ConstructProcessorsWindows();
         this.ConstructProcessorShortcuts();
         this.ConstructProcessorChat();
         this.ConstructProcessorLogicModule();
         this.ConstructProcessorPopTips();
         this.ConstructProcessorPopNarutoRoad();
         this.ConstructProcessorFightingCapacity();
         this.ConstructProcessorFreshGuide();
         this.ConstructProcessorsOverview();
         this.FProcessorEffect = new TProcessorLobbyEffect(this);
         this.FEffectTransition = new TEffectTransition(this);
         this.FProcessorDialogMsg = new TProcessorDialogMsg(this);
         this.ProcessorPlateSwitch(null);
         this.ProcessorWindowsSwitch(null);
         FResourcesState = RESOURCESSTATE_Ready;
         SParametersNewCore.CoerceProperties(root.loaderInfo.parameters);
      }
      
      protected function ConstructMountPoints() : void
      {
         this.FMountPointPlate = new TProcessorMountPoint(this);
         this.FMountPointFreshGuideNpc = new TProcessorMountPoint(this);
         this.FMountPointShortcuts = new TProcessorMountPoint(this);
         this.FMountPointChat = new TProcessorMountPoint(this);
         this.FMountPointIcons = new TProcessorMountPoint(this);
         this.FMountPointFreshGuideSearchWay = new TProcessorMountPoint(this);
         this.FMountPointShortcutsSpecial = new TProcessorMountPoint(this);
         this.FMountPointBarrier = new TProcessorMountPoint(this);
         this.FMountPointWindows = new TProcessorMountPoint(this);
         this.FMountPointOverview = new TProcessorMountPoint(this);
         this.FMountPointWindow = new TProcessorMountPoint(this);
         this.FMountPointLogicModule = new TProcessorMountPoint(this);
         this.FMountPointFreshGuide = new TProcessorMountPoint(this);
         this.FMountPointFreshGuideAllUp = new TProcessorMountPoint(this);
      }
      
      protected function ConstructProcessorsPlate() : void
      {
         this.FProcessorAccount = new TProcessorAccount(this.FMountPointPlate,this.FParameters);
         this.FProcessorAccount.OnLoadFollowUp = this.ProcessorOnLoadFollowUp;
         this.FProcessorAccount.OnCreateRole = this.ProcessorOnCreateRole;
         this.FProcessorAccount.OnStartFreshGuide = this.ProcessorsOnStartFreshGuide;
         this.FProcessorAccount.OnUserUpdateBaseInfo = this.ProcessorAccountOnUserUpdateBaseInfo;
         this.FProcessorAccount.UpdateHeroPower = this.ProcessorOnHeroUpdateBaseAttribute;
         this.FProcessorAccount.OnUpdateVipInfo = this.ProcessorAccountOnUserUpdateVipInfo;
         this.FProcessorAccount.OnUserUpdateStrengthenCD = this.ProcessorAccountOnUserUpdateStrengthenCD;
         this.FProcessorAccount.OnUserLevelUpEffect = this.ProcessorAccountOnUserLevelUpEffect;
         this.FProcessorAccount.OnUserLevelUp = this.ProcessorAccountOnUserLevelUp;
         this.FProcessorAccount.OnCharacterBaseAttribute = this.ProcessorOnCharacterBaseAttribute;
         this.FProcessorAccount.OnUpdateHerosTotalFightingPower = this.ProcessorOnUpdateHerosTotalFightingPower;
         this.FProcessorAccount.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorAccount.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorAccount.OnInitMilitaryInfor = this.ProcessorOnLoadMilitaryInfor;
         this.FProcessorAccount.OnInitQuests = this.ProcessorOnInitQuests;
         this.FProcessorAccount.OnUpdataSeverTime = this.ProcessorInspectorUpdataSeverTime;
         this.FProcessorAccount.OnCheckAntiAddiction = this.ProcessorOnCheckAntiAddiction;
         this.FProcessorAccount.OnInitAllNpc = this.ProcessorInitAllNpc;
         this.FProcessorAccount.OnInitMallInfo = this.ProcessorOnInitMallInfo;
         this.FProcessorAccount.OnInitPvpMallInfo = this.ProcessorOnInitPvpMallInfo;
         this.FProcessorAccount.OnInitVipInfo = this.ProcessorOnInitVipInfo;
         this.FProcessorAccount.OnProcessorPlayView = this.OnProcessorPlayView;
         this.FProcessorAccount.OnEnterFamily = this.ProcessorOnEnterFamily;
         this.FProcessorAccount.OnUpdateAllHeroEquipmentMountedSuitCount = this.ProcessorAllHeroEquipmentMountedSuitCount;
         this.FProcessorAccount.OnEnabledCheckSpeedUp = this.ProcessorOnEnabledCheckSpeedUp;
         this.FProcessorAccount.OnOpenSocketLoading = this.ProcessorOnOpenSocketLoading;
         this.FProcessorAccount.OnCloseSocketLoading = this.ProcessorOnCloseSocketLoading;
         this.FProcessorAccount.OnDailyQusetInfoReq = this.ProcessorOnDailyQusetInfoReq;
         this.FProcessorAccount.OnActivityInfoReq = this.ProcessorOnActiveInfoReq;
         this.FProcessorAccount.MainHeroQualityOnChange = this.ProcessorQualityOnChange;
         this.FProcessorAccount.OnBigDipperInfoReq = this.ProceesorOnStarsInforReq;
         this.FProcessorAccount.RequestMilitaryInfor = this.ProcessorRequestMilitaryInfor;
         this.FProcessorAccount.OnInitCrossServerMallInfo = this.ProcessorOnInitCrossServerMallInfo;
         this.FProcessorAccount.OnUserTotalFightingPowerReq = this.ProcessorTotalFightingPowerReq;
         this.FProcessorAccount.Visible = false;
         this.FProcessorMainScene = new TProcessorMainScene(this.FMountPointPlate,this.FParameters);
         this.FProcessorMainScene.OnEnterWorldMap = this.ProcessorShortcutsOnEnterWorldMap;
         this.FProcessorMainScene.OnUpdatePopTipsModes = this.ProcessorsOnUpdatePopTipsModes;
         this.FProcessorMainScene.OpenNpcUserTypeWindow = this.ProcessorShortcutsOnNpcUserType;
         this.FProcessorMainScene.OnAutoSearchWayEffect = this.ProcessorAccountOnAutoSearchWayEffect;
         this.FProcessorMainScene.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorMainScene.OnQueryShortcutCoordinate = this.ProcessorOnQueryShortcutCoordinate;
         this.FProcessorMainScene.OnEffectAcquireInventory = this.ProcessorOnEffectAcquireInventory;
         this.FProcessorMainScene.OnProcessorCheckPopTips = this.ProcessorCheckPopTips;
         this.FProcessorMainScene.Visible = false;
         this.FProcessorMainScene.HideHeroContorlPanle = this.ProcessorOnHideHeroInforPanle;
         this.FProcessorMainScene.ShowHeroContorlPanle = this.ProcessorOnShowHeroInforPanle;
         this.FProcessorMainScene.AutoEnterActivity = this.ProcessorOnAutoEnterActivity;
         this.FProcessorWorldMap = new TProcessorWorldMap(this.FMountPointPlate,this.FParameters);
         this.FProcessorWorldMap.OnReturnCityScene = this.ProcessorsOnEnterTown;
         this.FProcessorWorldMap.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorWorldMap.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorMainScene.SetupWorldMapTarget = this.FProcessorWorldMap.SetGotoTarget;
         this.FProcessorWorldMap.AddPopTips = this.AddPopTips;
         this.FProcessorWorldMap.OnNotifyMainSceneIntoAutoBattle = this.ProcessorShortcutsIntoAutoBattle;
         this.FProcessorWorldMap.OnAutoBattleMainUISet = this.ProcessorOnAutoBattleMainUISet;
         this.FProcessorWorldMap.OnEnterWorldMap = this.ProcessorShortcutsOnEnterWorldMap;
         this.FProcessorWorldMap.Visible = false;
         this.FProcessorBattleScene = new TProcessorBattleScene(this.FMountPointPlate,this.FParameters);
         this.FProcessorBattleScene.OnEffectTransition = this.ProcessorOnEffectTransition;
         this.FProcessorBattleScene.OnUpdateShortcutModes = this.ProcessorsPlateOnUpdateShortcutModes;
         this.FProcessorBattleScene.OnUpdateChatOption = this.ProcessorsPlateOnUpdateChatOptions;
         this.FProcessorBattleScene.OnUpdatePopTipsModes = this.ProcessorsOnUpdatePopTipsModes;
         this.FProcessorBattleScene.OnEnterCityScene = this.ProcessorsOnEnterTown;
         this.FProcessorBattleScene.OnUpdateReturnHomePanel = this.ProcessorOnUpdateReturnHomePanel;
         this.FProcessorBattleScene.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorBattleScene.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorBattleScene.OnProcessorCheckPlot = this.OnProcessorCheckPlot;
         this.FProcessorBattleScene.UnLoadResource = this.UnLoadResource;
         this.FProcessorBattleScene.AddPopTips = this.AddPopTips;
         this.FProcessorBattleScene.SetStatusType = this.OnSetStatusType;
         this.FProcessorBattleScene.SetMonsterCount = this.OnSetMonsterCount;
         this.FProcessorBattleScene.OnProcessorCheckPopTips = this.ProcessorCheckPopTips;
         this.FProcessorBattleScene.OnInitBattle = this.ProcessorLobbyOnInitBattle;
         this.FProcessorBattleScene.IsOpenWindows = this.IsOpenWindows;
         this.FProcessorBattleScene.SetSceneBitmapData = this.OnSetSceneBitmapData;
         this.FProcessorBattleScene.Visible = false;
         this.FProcessorTavern = new TProcessorTavern(this.FMountPointPlate,this.FParameters);
         this.FProcessorTavern.visible = false;
         this.FProcessorTavern.OnReturnMainScene = this.ProcessorOnReturnMainScene;
         this.FProcessorTavern.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorTavern.OnUpdatePopTipsModes = this.ProcessorsOnUpdatePopTipsModes;
         this.FProcessorTavern.OnUpdateHerosBaseAttributeReq = this.ProcessorOnHeroUpdateBaseAttribute;
         this.FProcessorTavern.OnEffectSoul = this.ProcessorOnEffectSoul;
         this.FProcessorTavern.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorTavern.OnShortcutHyperlinks = this.ProcessorShortcutHyperlinks;
         this.FProcessorArena = new TProcessorArena(this.FMountPointPlate,this.FParameters);
         this.FProcessorArena.Visible = false;
         this.FProcessorArena.OnReturnMainScene = this.ProcessorOnReturnMainScene;
         this.FProcessorArena.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorArena.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorArena.OnUpdatePopTipsModes = this.ProcessorsOnUpdatePopTipsModes;
         this.FProcessorArena.SetStatusType = this.OnSetStatusType;
         this.FProcessorArena.SetBattlePacket = this.OnSetBattlePacket;
         this.FProcessorArena.OnInitBattle = this.ProcessorLobbyOnInitBattle;
         this.FProcessorArena.ShowOtherHeroInfor = this.ProcessorOnShowHeroInfor;
         this.FProcessorTreasureMap = new TProcessorTreasureMap(this.FMountPointPlate,this.FParameters);
         this.FProcessorTreasureMap.OnReturnMainScene = this.ProcessorOnReturnMainScene;
         this.FProcessorTreasureMap.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorTreasureMap.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorTreasureMap.SetStatusType = this.OnSetStatusType;
         this.FProcessorTreasureMap.SetBattlePacket = this.OnSetBattlePacket;
         this.FProcessorTreasureMap.OnInitBattle = this.ProcessorLobbyOnInitBattle;
         this.FProcessorTreasureMap.ProofSeeNinJa = this.ProofSeeNinJa;
         this.FProcessorTreasureMap.CheckIconEffect = this.ProcessorShortcutEffectNotification;
         this.FProcessorTreasureMap.Visible = false;
         this.FProcessorSuperHero = new TProcessorSuperHero(this.FMountPointPlate,this.FParameters);
         this.FProcessorSuperHero.OnEffectTransition = this.ProcessorOnEffectTransition;
         this.FProcessorSuperHero.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorSuperHero.OnReturnMainScene = this.ProcessorOnReturnMainScene;
         this.FProcessorSuperHero.OnBuyGoods = this.ProcessorsBuyGoods;
         this.FProcessorSuperHero.OnEnlistSuccess = this.ProcessorOnUpdateCopyHeros;
         this.FProcessorSuperHero.OnShortcutHyperlinks = this.ProcessorShortcutHyperlinks;
         this.FProcessorSuperHero.Visible = false;
         this.FOrganizationalWar = new TProcessorOrganizationalWar(this.FMountPointPlate,this.FParameters);
         this.FOrganizationalWar.OnEffectTransition = this.ProcessorOnEffectTransition;
         this.FOrganizationalWar.OnEffectText = this.ProcessorsOnEffectText;
         this.FOrganizationalWar.OnEnterTown = this.ProcessorsOnEnterTown;
         this.FOrganizationalWar.UpdateReturnHomePanel = this.ProcessorOnUpdateReturnHomePanel;
         this.FOrganizationalWar.GetOrganizationalName = this.ProcessorOnOrgGetNameFromID;
         this.FOrganizationalWar.SetDailyActivityStatus = this.SetOrgActivityEnd;
         this.FOrganizationalWar.ActivityStatusCallBack = this.SetOrgActivityEnd;
         this.FOrganizationalWar.GetOrgainizatinoLevel = this.ProcessorOnOrgGetActivityLevelByType;
         this.FProcessorCityDefend = new TProcessorCityDefend(this.FMountPointPlate,this.FParameters);
         this.FProcessorCityDefend.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorCityDefend.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorCityDefend.OnEnterCityScene = this.ProcessorsOnEnterTown;
         this.FProcessorCityDefend.SetStatusType = this.OnSetStatusType;
         this.FProcessorCityDefend.SetBattlePacket = this.OnSetBattlePacket;
         this.FProcessorCityDefend.OnInitBattle = this.ProcessorLobbyOnInitBattle;
         this.FProcessorCityDefend.OnUpdateReturnHomePanel = this.ProcessorOnUpdateReturnHomePanel;
         this.FProcessorCityDefend.OnSetDailyActivityStatus = this.SetOrgActivityEnd;
         this.FProcessorCityDefend.OnEndAutoBattle = this.ProcessorShortcutsOnEndAutoBattle;
         this.FProcessorCityDefend.ExecuteCommand = this.ProcessorShortcutsExecuteCommand;
         this.FProcessorCityDefend.OpenThisPanel = this.OpenThisPanelF;
         this.FProcessorCityDefend.Visible = false;
         this.FProcessorFightPet = new TProcessorFightPet(this.FMountPointPlate,this.FParameters);
         this.FProcessorFightPet.OnEffectTransition = this.ProcessorOnEffectTransition;
         this.FProcessorFightPet.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorFightPet.OnInitBattle = this.ProcessorLobbyOnInitBattle;
         this.FProcessorFightPet.SetStatusType = this.OnSetStatusType;
         this.FProcessorFightPet.OnEnterCityScene = this.ProcessorsOnEnterTown;
         this.FProcessorFightPet.SetSceneBitmapData = this.OnSetSceneBitmapData;
         this.FProcessorFightPet.UpdateReturnHomePanel = this.ProcessorOnUpdateReturnHomePanel;
         this.FProcessorFightPet.OnEndAutoBattle = this.ProcessorShortcutsOnEndAutoBattle;
         this.FProcessorFightPet.ExecuteCommand = this.ProcessorShortcutsExecuteCommand;
         this.FProcessorFightPet.OpenThisPanel = this.OpenThisPanelF;
         this.FProcessorAnimalSeal = new TProcessorFightPetCopy(this.FMountPointPlate,this.FParameters);
         this.FProcessorAnimalSeal.OnEffectTransition = this.ProcessorOnEffectTransition;
         this.FProcessorAnimalSeal.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorAnimalSeal.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorAnimalSeal.OnInitBattle = this.ProcessorLobbyOnInitBattle;
         this.FProcessorAnimalSeal.SetStatusType = this.OnSetStatusType;
         this.FProcessorAnimalSeal.OnEnterCityScene = this.ProcessorsOnEnterTown;
         this.FProcessorAnimalSeal.SetSceneBitmapData = this.OnSetSceneBitmapData;
         this.FProcessorAnimalSeal.UpdateReturnHomePanel = this.ProcessorOnUpdateReturnHomePanel;
         this.FProcessorAnimalSeal.PerformPacket_SC_Organization_Animal = this.PerformPacket_SC_Organization_Animal;
         this.FProcessorAnimalSeal.PerformPacket_SC_Organization_apply = this.PerformPacket_SC_Organization_apply;
         this.FProcessorAnimalSeal.PACKETID_SC_AnimalSeall_Open_Ret = this.PACKETID_SC_AnimalSeall_Open_Ret;
         this.FProcessorAnimalSeal.ReturnMainScene = this.ProcessorOnReturnMainScene;
         this.FProcessorAnimalSeal.OnEndAutoBattle = this.ProcessorShortcutsOnEndAutoBattle;
         this.FProcessorAnimalSeal.ExecuteCommand = this.ProcessorShortcutsExecuteCommand;
         this.FProcessorAnimalSeal.OpenThisPanel = this.OpenThisPanelF;
         this.FProcessorTraitorAttack = new TProcessorTraitorAttack(this.FMountPointPlate,this.FParameters);
         this.FProcessorTraitorAttack.OnEffectTransition = this.ProcessorOnEffectTransition;
         this.FProcessorTraitorAttack.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorTraitorAttack.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorTraitorAttack.OnInitBattle = this.ProcessorLobbyOnInitBattle;
         this.FProcessorTraitorAttack.SetStatusType = this.OnSetStatusType;
         this.FProcessorTraitorAttack.OnEnterCityScene = this.ProcessorsOnEnterTown;
         this.FProcessorTraitorAttack.SetSceneBitmapData = this.OnSetSceneBitmapData;
         this.FProcessorTraitorAttack.OnUpdateReturnHomePanel = this.ProcessorOnUpdateReturnHomePanel;
         this.FProcessorTraitorAttack.OnEndAutoBattle = this.ProcessorShortcutsOnEndAutoBattle;
         this.FProcessorTraitorAttack.ExecuteCommand = this.ProcessorShortcutsExecuteCommand;
         this.FProcessorTraitorAttack.OpenThisPanel = this.OpenThisPanelF;
         this.FProcessorCelebrate = new TProcessorCelebrate(this.FMountPointPlate,this.FParameters);
         this.FProcessorCelebrate.OnEffectTransition = this.ProcessorOnEffectTransition;
         this.FProcessorCelebrate.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorCelebrate.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorCelebrate.OnInitBattle = this.ProcessorLobbyOnInitBattle;
         this.FProcessorCelebrate.SetStatusType = this.OnSetStatusType;
         this.FProcessorCelebrate.OnEnterCityScene = this.ProcessorsOnEnterTown;
         this.FProcessorCelebrate.SetSceneBitmapData = this.OnSetSceneBitmapData;
         this.FProcessorCelebrate.OnUpdateReturnHomePanel = this.ProcessorOnUpdateReturnHomePanel;
         this.FProcessorCelebrate.OnEndAutoBattle = this.ProcessorShortcutsOnEndAutoBattle;
         this.FProcessorCelebrate.ExecuteCommand = this.ProcessorShortcutsExecuteCommand;
         this.FProcessorCelebrate.OpenThisPanel = this.OpenThisPanelF;
         this.FProcessorNijiaStar = new TProcessorNijiaStar(this.FMountPointPlate,this.FParameters);
         this.FProcessorNijiaStar.OnReturnMainScene = this.ProcessorOnReturnMainScene;
         this.FProcessorNijiaStar.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorNijiaStar.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorNijiaStar.OnEffectTransition = this.ProcessorOnEffectTransition;
         this.FProcessorNijiaStar.GetKingSoulOnClick = this.ProcessorGetKingSoulonClick;
         this.FProcessorSevenKing = new TProcessorSevenKing(this.FMountPointPlate,this.FParameters);
         this.FProcessorSevenKing.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorSevenKing.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorSevenKing.OnEffectTransition = this.ProcessorOnEffectTransition;
         this.FProcessorSevenKing.OnInitBattle = this.ProcessorLobbyOnInitBattle;
         this.FProcessorSevenKing.SetStatusType = this.OnSetStatusType;
         this.FProcessorSevenKing.OnReturnMainScene = this.ProcessorOnReturnMainScene;
         this.FProcessorSevenKing.OnShortcutHyperlinks = this.ProcessorShortcutHyperlinks;
         this.FProcessorSevenKing.CheckIconEffect = this.ProcessorShortcutEffectNotification;
         this.FProcessorCrossServerWar = new TProcessorCrossServerWar(this.FMountPointPlate,this.FParameters);
         this.FProcessorCrossServerWar.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorCrossServerWar.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorCrossServerWar.OnEffectTransition = this.ProcessorOnEffectTransition;
         this.FProcessorCrossServerWar.OnInitBattle = this.ProcessorLobbyOnInitBattle;
         this.FProcessorCrossServerWar.SetStatusType = this.OnSetStatusType;
         this.FProcessorCrossServerWar.OnReturnMainScene = this.ProcessorOnReturnMainScene;
         this.FProcessorCrossServerWar.OnOpenSoulExchange = this.ProcessorOnOpenSoulExchange;
         this.FProcessorCrossServerWar.OnOpenTokenExchange = this.ProcessorOnOpenTokenExchange;
         this.FProcessorCrossServerWar.OnOpenToast = this.ProcessorOnOpenToast;
         this.FProcessorCrossServerWar.OnOpenRankings = this.ProcessorOnOpenRankings;
         this.FProcessorCrossServerWar.UpdateExplanationUI = this.ProcessorUpdateExplanationUI;
         this.FProcessorCrossServerWar.UpdateToastRecord = this.ProcessorUpdateToastRecord;
         this.FProcessorCrossServerWar.OnEffectSign = this.ProcessorShortcutEffectNotification;
         this.FProcessorPalace = new TProcessorPalace(this.FMountPointPlate,this.FParameters);
         this.FProcessorPalace.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorPalace.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorPalace.OnEffectTransition = this.ProcessorOnEffectTransition;
         this.FProcessorPalace.OnInitBattle = this.ProcessorLobbyOnInitBattle;
         this.FProcessorPalace.SetStatusType = this.OnSetStatusType;
         this.FProcessorPalace.OnReturnMainScene = this.ProcessorOnReturnMainScene;
         this.FProcessorPalace.OnOpenExplanation = this.ProcessorOnOpenExplanation;
         this.FProcessorPalace.OnOpenPalace = this.ProcessorOnOpenPalace;
         this.FProcessorGroupBattleRoomUI = new TProcessorGroupBattleRoomUI(this.FMountPointPlate,this.FParameters);
         this.FProcessorGroupBattleRoomUI.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorGroupBattleRoomUI.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorGroupBattleRoomUI.OnEffectTransition = this.ProcessorOnEffectTransition;
         this.FProcessorGroupBattleRoomUI.OnReturnMainScene = this.ProcessorOnReturnNijiaBattle;
         this.FProcessorGroupBattleRoomUI.ShowOtherHeroInfor = this.ProcessorOnShowHeroInfor;
         this.FProcessorGroupBattleRoomUI.RequestWhisper = this.ProcessorsOnRequestWhisper;
         this.FProcessorGroupBattleRoomUI.OnSetGroupBattleChannel = this.ProcessorOnActivatingChannel;
         this.FProcessorPlateTopTeamRoomUI = new TProcessorPlateTopTeamRoomUI(this.FMountPointPlate,this.FParameters);
         this.FProcessorPlateTopTeamRoomUI.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorPlateTopTeamRoomUI.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorPlateTopTeamRoomUI.OnEffectTransition = this.ProcessorOnEffectTransition;
         this.FProcessorPlateTopTeamRoomUI.OnReturnMainScene = this.ProcessorOnReturnTopTeam;
         this.FProcessorPlateTopTeamRoomUI.ShowOtherHeroInfor = this.ProcessorOnShowHeroInfor;
         this.FProcessorPlateTopTeamRoomUI.RequestWhisper = this.ProcessorsOnRequestWhisper;
         this.FProcessorPlateTopTeamRoomUI.OnSetGroupBattleChannel = this.ProcessorOnActivatingChannel;
         this.FProcessorPlateTopTeamRoomUI.OnInterpersonalRelationships = this.ProcessorOnInterpersonalRelationshipsReq;
         this.FProcessorPlateTopTeamRoomUI.NinjaPointMallOnClick = this.ProcessorNinjaPointMallOnClick;
         this.FProcessorWindowBloodFeteMainManageClass = new TProcessorWindowBloodFeteMainManageClass(this.FMountPointPlate,this.FParameters);
         this.FProcessorWindowBloodFeteMainManageClass.BackMainScreen = this.ProcessorOnReturnMainScene;
         this.FProcessorWindowBloodFeteMainManageClass.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorWindowBloodFeteMainManageClass.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorWindowBloodFeteMainManageClass.OnSetChatOptions = this.ProcessorSetChatOptions;
         this.FProcessorWindowBloodFeteMainManageClass.UpdateOtheroPanel = this.UpdateOtheroPanel;
         this.FProcessorWindowBloodFeteMainManageClass.CheckIconEffect = this.ProcessorShortcutEffectNotification;
         this.FProcessorWindowManAwaken = new TProcessorWindowManAwaken(this.FMountPointPlate,this.FParameters);
         this.FProcessorWindowManAwaken.BackMainScreen = this.ProcessorOnReturnMainScene;
         this.FProcessorWindowManAwaken.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorWindowManAwaken.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorWindowManAwaken.OnSetChatOptions = this.ProcessorSetChatOptions;
         this.FProcessorWindowManAwaken.CheckIconEffect = this.ProcessorShortcutEffectNotification;
         this.FProcessorWindowManEightDoor = new TProcessorWindowManEightDoor(this.FMountPointPlate,this.FParameters);
         this.FProcessorWindowManEightDoor.BackMainScreen = this.ProcessorOnReturnMainScene;
         this.FProcessorWindowManEightDoor.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorWindowManEightDoor.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorWindowManEightDoor.OnSetChatOptions = this.ProcessorSetChatOptions;
         this.FProcessorWindowManEightDoor.CheckIconEffect = this.ProcessorShortcutEffectNotification;
         this.FProcessorWindowTheWorldTree = new TProcessorWindowTheWorldTree(this.FMountPointPlate,this.FParameters);
         this.FProcessorWindowTheWorldTree.BackMainScreen = this.ProcessorOnReturnMainScene;
         this.FProcessorWindowTheWorldTree.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorWindowTheWorldTree.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorWindowTheWorldTree.OnSetChatOptions = this.ProcessorSetChatOptions;
         this.FProcessorWindowTheWorldTree.UpdateOtheroPanel = this.UpdateOtheroPanel;
         this.FProcessorWindowTheWorldTree.OpenThisPanelFunction = this.ProcessorsShortcutsOnActivityTheWorldTree;
         this.FProcessorMasterRoad = new TProcessorMasterRoad(this.FMountPointPlate,this.FParameters);
         this.FProcessorMasterRoad.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorMasterRoad.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorMasterRoad.OnReturnMainScene = this.ProcessorOnReturnMainScene;
         this.FProcessorMasterRoad.SetStatusType = this.OnSetStatusType;
         this.FProcessorMasterRoad.OnInitBattle = this.ProcessorLobbyOnInitBattle;
         this.FProcessorMasterRoad.OnUpdateBadge = this.ProcessoOnUpdateBadge;
         this.FProcessorMasterRoad.OnUpdateCharInfo = this.UpdateHeroProperty;
         this.FProcessorChallenge = new TProcessorChallenge(this.FMountPointPlate,this.FParameters);
         this.FProcessorChallenge.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorChallenge.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorChallenge.OnReturnMainScene = this.ProcessorOnReturnMainScene;
         this.FProcessorChallenge.SetStatusType = this.OnSetStatusType;
         this.FProcessorChallenge.OnInitBattle = this.ProcessorLobbyOnInitBattle;
         this.FProcessorChallenge.OnUpdateBadge = this.ProcessoOnUpdateBadge;
         this.FProcessorChallenge.OnShortcutHyperlinks = this.ProcessorShortcutHyperlinks;
         this.FProcessorChallenge.OnSetChatOptions = this.ProcessorSetChatOptions;
         this.FProcessorGlobalBattle = new TProcessorGlobalBattle(this.FMountPointPlate,this.FParameters);
         this.FProcessorGlobalBattle.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorGlobalBattle.OnReturnMainScene = this.ProcessorOnReturnMainScene;
         this.FProcessorGlobalBattle.OnInitBattle = this.ProcessorLobbyOnInitBattle;
         this.FProcessorGlobalBattle.SetStatusType = this.OnSetStatusType;
         this.FProcessorGlobalBattle.OnScoreChange = this.OnChangeGlobalBattleScore;
         this.FProcessorWorldMatch = new TProcessorWorldMatch(this.FMountPointPlate,this.FParameters);
         this.FProcessorWorldMatch.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorWorldMatch.OnReturnMainScene = this.ProcessorOnReturnMainScene;
         this.FProcessorWorldMatch.OnInitBattle = this.ProcessorLobbyOnInitBattle;
         this.FProcessorWorldMatch.SetStatusType = this.OnSetStatusType;
         this.FProcessorWorldMatch.OnSetChatOptions = this.ProcessorSetChatOptions;
         this.FProcessorWorldMatch.OnOpenWorldMatchStreak = this.ProcessorGotoOpenWorldMatchStreak;
         this.FProcessorWorldMatch.CheckIconEffect = this.ProcessorShortcutEffectNotification;
         this.FProcessorSummonBattle = new TProcessorSummonBattle(this.FMountPointPlate,this.FParameters);
         this.FProcessorSummonBattle.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorSummonBattle.OnReturnMainScene = this.ProcessorOnReturnMainScene;
         this.FProcessorSummonBattle.OnSetChatOptions = this.ProcessorSetChatOptions;
         this.FProcessorSummonBattle.OnInitBattle = this.ProcessorLobbyOnInitBattle;
         this.FProcessorSummonBattle.SetStatusType = this.OnSetStatusType;
         this.FProcessorsPlate = Vector.<TProcessorLobbyPlate>([this.FProcessorAccount,this.FProcessorMainScene,this.FProcessorWorldMap,this.FProcessorBattleScene,this.FProcessorTavern,this.FProcessorArena,this.FProcessorTreasureMap,this.FProcessorSuperHero,this.FOrganizationalWar,this.FProcessorCityDefend,this.FProcessorFightPet,this.FProcessorTraitorAttack,this.FProcessorCelebrate,this.FProcessorNijiaStar,this.FProcessorSevenKing,this.FProcessorCrossServerWar,this.FProcessorPalace,this.FProcessorAnimalSeal,this.FProcessorGroupBattleRoomUI,this.FProcessorPlateTopTeamRoomUI,this.FProcessorWindowBloodFeteMainManageClass,this.FProcessorWindowManAwaken,this.FProcessorWindowManEightDoor,this.FProcessorWindowTheWorldTree,this.FProcessorMasterRoad,this.FProcessorChallenge,this.FProcessorGlobalBattle,this.FProcessorWorldMatch,this.FProcessorSummonBattle]);
      }
      
      protected function ConstructProcessorsWindows() : void
      {
         this.FProcessorProtagonist = new TProcessorProtagonist(this.FMountPointWindows,this.FParameters);
         this.FProcessorProtagonist.OnEffectTransition = this.ProcessorOnEffectTransition;
         this.FProcessorProtagonist.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorProtagonist.OnCheckPopTipsModes = this.ProcessorOnCheckPopTipsModes;
         this.FProcessorProtagonist.OnMilitaryRankChange = this.ProcessorWindowsOnMilitary;
         this.FProcessorProtagonist.OnUserUpdateBaseInfo = this.ProcessorAccountOnUserUpdateBaseInfo;
         this.FProcessorProtagonist.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorProtagonist.CheckCanUpgradeMilitary = this.ProcessorShortcutEffectNotification;
         this.FProcessorProtagonist.AddPopTips = this.AddPopTips;
         this.FProcessorProtagonist.UpdateHeroPower = this.ProcessorOnHeroUpdateBaseAttribute;
         this.FProcessorProtagonist.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorProtagonist.OnShortcutHyperlinks = this.ProcessorShortcutHyperlinks;
         this.FProcessorHeros = new TProcessorHeros(this.FMountPointWindows,this.FParameters);
         this.FProcessorHeros.OnEffectTransition = this.ProcessorOnEffectTransition;
         this.FProcessorHeros.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorHeros.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorHeros.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorHeros.OnCheckPopTipsModes = this.ProcessorOnCheckPopTipsModes;
         this.FProcessorHeros.OnUpdateTalismanMount = this.ProcessorOnUpdateTalismanMount;
         this.FProcessorHeros.OnShortcutHyperlinks = this.ProcessorShortcutHyperlinks;
         this.FProcessorHeros.OnChangeSkillReq = this.ProcessorOnChangeSkillReq;
         this.FProcessorHeros.OnUpdateBaseAttributeRet = this.ProcessorOnHerosUpdateBaseAttributeRet;
         this.FProcessorHeros.OnDismissHero = this.ProcessorOnDismissHero;
         this.FProcessorHeros.OnUseInventory = this.ProcessorOnUseInventory;
         this.FProcessorHeros.OnUserUpdateBaseInfo = this.ProcessorAccountOnUserUpdateBaseInfo;
         this.FProcessorHeros.GoToHerosFightWindow = this.GoToHerosFightWindow;
         this.FProcessorHeros.GoAccessoryPanel = this.ProcessorsShortcutsOnActivityBloodFeteCopy;
         this.FProcessorHeros.GoSoulFormation = this.ProcessorGotoSoulFormation;
         this.FProcessorHeros.GoWing = this.ProcessorsShortcutsOnActivityWing;
         this.FProcessorHeros.OpenJadeFun = this.ProcessorGotoOpenJade;
         this.FProcessorHeros.OnUpdateMedalMount = this.ProcessorOnUpdateMedalMount;
         this.FProcessorTacticalDeployment = new TProcessorTacticalDeployment(this.FMountPointWindows,this.FParameters);
         this.FProcessorTacticalDeployment.OnEffectTransition = this.ProcessorOnEffectTransition;
         this.FProcessorTacticalDeployment.OnCheckPopTipsModes = this.ProcessorOnCheckPopTipsModes;
         this.FProcessorTacticalDeployment.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorTacticalDeployment.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorTacticalDeployment.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorTacticalDeployment.OnChangePosition = this.ProcessorOnChangePosition;
         this.FProcessorTacticalDeployment.OnChangeSkill = this.ProcessorOnChangeSkill;
         this.FProcessorTacticalDeployment.OnEnterMilitary = this.ProcessorShortcutsOnAvaterHeadClick;
         this.FProcessorTacticalDeployment.OnShortcutHyperlinks = this.ProcessorShortcutHyperlinks;
         this.FProcessorTacticalDeployment.OnNoticeChallenge = this.ProcessorOnChangePosition;
         this.FProcessorBackpack = new TProcessorBackpack(this.FMountPointWindows,this.FParameters);
         this.FProcessorBackpack.OnEffectTransition = this.ProcessorOnEffectTransition;
         this.FProcessorBackpack.OnCheckPopTipsModes = this.ProcessorOnCheckPopTipsModes;
         this.FProcessorBackpack.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorBackpack.OnShortcutHyperlinks = this.ProcessorShortcutHyperlinks;
         this.FProcessorBackpack.OnUpdateInventories = this.ProcessorOnUpdateInventories;
         this.FProcessorBackpack.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorBackpack.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorBackpack.OnInventoryReveal = this.ProcessorsOnInventoryReveal;
         this.FProcessorBackpack.AddPopTips = this.AddPopTips;
         this.FProcessorBackpack.EndBattle = this.ProcessorEndBattle;
         this.FProcessorPet = new TProcessorPet(this.FMountPointWindows,this.FParameters);
         this.FProcessorPet.OnEffectTransition = this.ProcessorOnEffectTransition;
         this.FProcessorPet.OnCheckPopTipsModes = this.ProcessorOnCheckPopTipsModes;
         this.FProcessorPet.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorPet.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorPet.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorPet.RelaxOrNot = this.ProcessorsUpdatePet;
         this.FProcessorPet.UpStar = this.ProcessorsUpdatePet;
         this.FProcessorPet.ChangeBody = this.ProcessorsUpdatePet;
         this.FProcessorPet.UnLuck = this.ProcessorsUpdatePet;
         this.FProcessorPet.GotoAddSoul = this.ProcessorsShortcutsOnActivityAddSoul;
         this.FProcessorSmithy = new TProcessorSmithy(this.FMountPointWindows,this.FParameters);
         this.FProcessorSmithy.OnEffectTransition = this.ProcessorOnEffectTransition;
         this.FProcessorSmithy.OnCheckPopTipsModes = this.ProcessorOnCheckPopTipsModes;
         this.FProcessorSmithy.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorSmithy.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorSmithy.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorSmithy.UpdateHeroPower = this.ProcessorOnHeroUpdateBaseAttribute;
         this.FProcessorSmithy.UpdateHerosPower = this.ProcessorOnHerosUpdateBaseAttributeReq;
         this.FProcessorSmithy.OnShortcutHyperlinks = this.ProcessorShortcutHyperlinks;
         this.FProcessorQuest = new TProcessorQuest(this.FMountPointWindows,this.FParameters);
         this.FProcessorQuest.OnEffectTransition = this.ProcessorOnEffectTransition;
         this.FProcessorQuest.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorQuest.OnAutoSearchWay = this.ProcessorOnAutoSearchWay;
         this.FProcessorBattleScene.OnCheckTask = this.FProcessorQuest.NotifyKillMonster;
         this.FProcessorWorldMap.OnCheckTask = this.FProcessorQuest.NotifyKillMonster;
         this.FProcessorQuest.OnSearchWayInWorldMap = this.FProcessorWorldMap.SetGotoTarget;
         this.FProcessorQuest.OnSearchWayOnKillMonster = this.FProcessorBattleScene.SetGotoTarget;
         this.FProcessorQuest.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorQuest.OnSearchNewQuest = this.FProcessorMainScene.AddNewQuest;
         this.FProcessorQuest.OnUpdateQuestState = this.FProcessorMainScene.UpdateQuesteState;
         this.FProcessorQuest.OnUpdateNpc = this.FProcessorMainScene.UpdateNpc;
         this.FProcessorQuest.OnAcceptTaskEffect = this.ProcessorAccountOnAcceptTaskEffect;
         this.FProcessorQuest.OnCompleteTaskEffect = this.ProcessorAccountOnCompleteEffect;
         this.FProcessorQuest.DoAfterInitQuest = this.ProcessorsOnLoadingQuestOver;
         this.FProcessorQuest.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorMainScene.RequestQuestGoahead = this.FProcessorQuest.NotifyNpcTaskClick;
         this.FProcessorQuest.OnProcessorCheckPlot = this.OnProcessorCheckPlot;
         this.FProcessorMakeEquip = new TProcessorMakeEquip(this.FMountPointWindows,this.FParameters);
         this.FProcessorMakeEquip.OnEffectTransition = this.ProcessorOnEffectTransition;
         this.FProcessorMakeEquip.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorMakeEquip.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorMakeEquip.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorMakeEquip.OnQueryShortcutCoordinate = this.ProcessorOnQueryShortcutCoordinate;
         this.FProcessorMakeEquip.OnEffectAcquireInventory = this.ProcessorOnEffectAcquireInventory;
         this.FProcessorKillHeros = new TProcessorKillHeros(this.FMountPointWindows,this.FParameters);
         this.FProcessorKillHeros.OnEffectTransition = this.ProcessorOnEffectTransition;
         this.FProcessorKillHeros.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorKillHeros.OnShortcutHyperlinks = this.ProcessorShortcutHyperlinks;
         this.FProcessorKillHeros.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorKillHeros.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorKillHeros.AddPopTips = this.AddPopTips;
         this.FProcessorBigDipper = new TProcessorBigDipper(this.FMountPointWindows,this.FParameters);
         this.FProcessorBigDipper.OnEffectTransition = this.ProcessorOnEffectTransition;
         this.FProcessorBigDipper.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorBigDipper.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorBigDipper.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorBigDipper.UpdateHeroPower = this.ProcessorOnHeroUpdateBaseAttribute;
         this.FProcessorGeneralStar = new TProcessorGeneralStar(this.FMountPointWindows,this.FParameters);
         this.FProcessorGeneralStar.OnEffectTransition = this.ProcessorOnEffectTransition;
         this.FProcessorGeneralStar.OnCheckPopTipsModes = this.ProcessorOnCheckPopTipsModes;
         this.FProcessorGeneralStar.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorGeneralStar.OnActivityBigDipper = this.ProcessorShortcutsOnBigDipper;
         this.FProcessorGeneralStar.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorGeneralStar.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorGeneralStar.MainHeroQualityOnChange = this.ProcessorQualityOnChange;
         this.FProcessorGeneralStar.OnQueryShortcutCoordinate = this.ProcessorOnQueryShortcutCoordinate;
         this.FProcessorGeneralStar.OnEffectAcquireInventory = this.ProcessorOnEffectAcquireInventory;
         this.FProcessorGeneralStar.AddPopTips = this.AddPopTips;
         this.FProcessorGeneralStar.OnUpdateHerosBaseAttributeReq = this.ProcessorOnHerosUpdateBaseAttributeReq;
         this.FProcessorGeneralStar.OnTiaoZhuanClick = this.OpenPanelZhenAoYi;
         this.FProcessorGeneralStar.OnShortcutHyperlinks = this.ProcessorShortcutHyperlinks;
         this.FProcessorJade = new TProcessorJade(this.FMountPointWindows,this.FParameters);
         this.FProcessorJade.OnEffectTransition = this.ProcessorOnEffectTransition;
         this.FProcessorJade.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorJade.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorJade.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorJade.UpdateHeroPower = this.ProcessorOnHeroUpdateBaseAttribute;
         this.FProcessorTalisman = new TProcessorTalisman(this.FMountPointWindows,this.FParameters);
         this.FProcessorTalisman.OnEffectTransition = this.ProcessorOnEffectTransition;
         this.FProcessorTalisman.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorTalisman.OnMountTalisman = this.ProcessorOnMountTalisman;
         this.FProcessorTalisman.OnDismountTalisman = this.ProcessorOnDismountTalisman;
         this.FProcessorTalisman.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorTalisman.OnUpdateHerosBaseAttributeReq = this.ProcessorOnHerosUpdateBaseAttributeReq;
         this.FProcessorTalisman.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorTalisman.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorTalisman.OnGoToKillHeros = this.ProcessorShortcutsOnKillHeros;
         this.FProcessorTalisman.GoToLostPanelFunction = this.GoToLostPanelFunction;
         this.FProcessorEquipAdvanced = new TProcessorEquipAdvanced(this.FMountPointWindows,this.FParameters);
         this.FProcessorEquipAdvanced.OnEffectTransition = this.ProcessorOnEffectTransition;
         this.FProcessorEquipAdvanced.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorEquipAdvanced.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorEquipAdvanced.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorMail = new TProcessorMail(this.FMountPointWindows,this.FParameters);
         this.FProcessorMail.OnEffectTransition = this.ProcessorOnEffectTransition;
         this.FProcessorMail.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorMail.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorMail.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorMail.OnEffectNewMail = this.ProcessorShortcutEffectNotification;
         this.FProcessorRamen = new TProcessorRamen(this.FMountPointWindows,this.FParameters);
         this.FProcessorRamen.OnEffectTransition = this.ProcessorOnEffectTransition;
         this.FProcessorRamen.OnCheckPopTipsModes = this.ProcessorOnCheckPopTipsModes;
         this.FProcessorRamen.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorRamen.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorRamen.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorRamen.ShortcutHyperlinks = this.ProcessorShortcutHyperlinks;
         this.FProcessorRamen.OnEffectFree = this.ProcessorShortcutEffectNotification;
         this.FProcessorFriend = new TProcessorFriend(this.FMountPointWindows,this.FParameters);
         this.FProcessorFriend.OnEffectTransition = this.ProcessorOnEffectTransition;
         this.FProcessorFriend.OnCheckPopTipsModes = this.ProcessorOnCheckPopTipsModes;
         this.FProcessorFriend.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorFriend.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorFriend.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorFriend.OnInquiryRet = this.ProcessorOnInquiryCharacterIDRet;
         this.FProcessorFriend.OnWhisper = this.ProcessorOnChatWhisper;
         this.FProcessorFriend.OnMail = this.ProcessorOnOpenWriteMail;
         this.FProcessorFriend.SetStatusType = this.OnSetStatusType;
         this.FProcessorFriend.OnInitBattle = this.ProcessorLobbyOnInitBattle;
         this.FProcessorFriend.ShowEffectNotification = this.ProcessorShortcutEffectNotification;
         this.FProcessorMall = new TProcessorMall(this.FMountPointWindows,this.FParameters);
         this.FProcessorMall.OnEffectTransition = this.ProcessorOnEffectTransition;
         this.FProcessorMall.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorMall.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorMall.OnSignIntegral = this.ProcessorOnSignIntegral;
         this.FProcessorMall.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorMall.OnItemOnClick = this.ProcessorsOnItemOnClick;
         this.FProcessorMall.OnBuyResult = this.ProcessorOnBuyResult;
         this.FPressorWindowNewMall = new TPressorWindowNewMall(this.FMountPointWindows,this.FParameters);
         this.FPressorWindowNewMall.OnClose = this.ProcessorsWindowsOnClose;
         this.FPressorWindowNewMall.OnEffectText = this.ProcessorsOnEffectText;
         this.FPressorWindowNewMall.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FPressorWindowNewMall.OnUpdateSuperHeroUI = this.ProcessorOnUpdateSuperHeroUI;
         this.FPressorWindowNewMall.NoticeOthersPanel = this.FromNewMall;
         this.FPressorWindowNewMall.GoToOpenShop = this.ProcessorGotoOpenShop;
         this.FProcessorDailySign = new TProcessorDailySign(this.FMountPointWindows,this.FParameters);
         this.FProcessorDailySign.OnEffectTransition = this.ProcessorOnEffectTransition;
         this.FProcessorDailySign.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorDailySign.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorDailySign.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorDailySign.OnEffectSign = this.ProcessorShortcutEffectNotification;
         this.FProcessorVIP = new TProcessorVIP(this.FMountPointWindows,this.FParameters);
         this.FProcessorVIP.OnEffectTransition = this.ProcessorOnEffectTransition;
         this.FProcessorVIP.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorVIP.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorVIP.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorVIP.OnEffectBaseGlowVIP = this.ProcessorOnEffectBaseGlowVIP;
         this.FProcessorBugCommit = new TProcessorBugCommit(this.FMountPointWindows,this.FParameters);
         this.FProcessorBugCommit.OnEffectTransition = this.ProcessorOnEffectTransition;
         this.FProcessorBugCommit.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorBugCommit.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorBugCommit.OnSendMail = this.ProcessorOnSendMail;
         this.FProcessorDailyQuest = new TProcessorDailyQuest(this.FMountPointWindows,this.FParameters);
         this.FProcessorDailyQuest.OnEffectTransition = this.ProcessorOnEffectTransition;
         this.FProcessorDailyQuest.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorDailyQuest.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorDailyQuest.OnGotoTask = this.ProcessorOnOpenModel;
         this.FProcessorDailyQuest.OnGotoBigMap = this.ProcessorOnGotoCityDoor;
         this.FProcessorDailyQuest.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorDailyQuest.OnPlayEffect = this.ProcessorShortcutEffectNotification;
         this.FProcessorDailyQuest.OnEffectSign = this.ProcessorShortcutEffectNotification;
         this.FProcessorCopyHero = new TProcessorCopyClassroom(this.FMountPointWindows,this.FParameters);
         this.FProcessorCopyHero.OnEffectTransition = this.ProcessorOnEffectTransition;
         this.FProcessorCopyHero.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorCopyHero.CopyingHeroRetOK = this.ProcessorOnChangeShape;
         this.FProcessorCopyHero.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorCopyHero.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorCopyHero.OnShortcutHyperlinks = this.ProcessorShortcutHyperlinks;
         this.FProcessorGoodsPurchase = new TProcessorGoodsPurchase(this.FMountPointWindows,this.FParameters);
         this.FProcessorGoodsPurchase.OnEffectTransition = this.ProcessorOnEffectTransition;
         this.FProcessorGoodsPurchase.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorGoodsPurchase.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorGoodsPurchase.OnOpenVIP = this.ProcessorOnOpenVIP;
         this.FProcessorGoodsPurchase.MallOnBuy = this.ProcessorMallOnBuy;
         this.FProcessorRecharge = new TProcessorRecharge(this.FMountPointWindows,this.FParameters);
         this.FProcessorRecharge.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorRecharge.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorRecharge.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorRecharge.OnEffectTransition = this.ProcessorOnEffectTransition;
         this.FProcessorRecharge.OnNewRechargeGift = this.ProcessorShortcutEffectNotification;
         this.FProcessorRecharge.OnBuyActionTimes = this.ProcessorOnButActionTimes;
         this.FProcessorRecharge.OnGotoRamen = this.ProcessorOnGotoRamen;
         this.FProcessorFirstRecharge = new TProcessorFirstRecharge(this.FMountPointWindows,this.FParameters);
         this.FProcessorFirstRecharge.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorFirstRecharge.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorFirstRecharge.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorFirstRecharge.OnEffectTransition = this.ProcessorOnEffectTransition;
         this.FProcessorFirstRecharge.OnNewFirstRechargeGift = this.ProcessorShortcutEffectNotification;
         this.FProcessorFirstRecharge.OnFirstRechargeSpecial = this.ProcessorShortcutSpecialNotification;
         this.FProcessorGiftBag = new TProcessorGiftBag(this.FMountPointWindows,this.FParameters);
         this.FProcessorGiftBag.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorGiftBag.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorGiftBag.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorGiftBag.OnEffectTransition = this.ProcessorOnEffectTransition;
         this.FProcessorGiftBag.ShortcutEffectNotification = this.ProcessorShortcutEffectNotification;
         this.FProcessorGiftBag.OnShortcutHyperlinks = this.ProcessorShortcutHyperlinks;
         this.FProcessorRechargeCashback = new TProcessorRechargeCashback(this.FMountPointWindows,this.FParameters);
         this.FProcessorRechargeCashback.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorRechargeCashback.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorRechargeCashback.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorRechargeCashback.OnEffectTransition = this.ProcessorOnEffectTransition;
         this.FProcessorWonderfulActivity = new TProcessorWonderfulActivity(this.FMountPointWindows,this.FParameters);
         this.FProcessorWonderfulActivity.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorWonderfulActivity.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorWonderfulActivity.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorWonderfulActivity.OnEffectTransition = this.ProcessorOnEffectTransition;
         this.FProcessorWonderfulActivity.SwitchWindow = this.ProcessorShortcutHyperlinks;
         this.FProcessorWonderfulActivity.NotifyShortcutEffect = this.ProcessorShortcutEffectNotification;
         this.FProcessorWonderfulActivity.NotifyFNotifyPayRank = this.SendRechageRankRet;
         this.FProcessorCDK = new TProcessorCDK(this.FMountPointWindows,this.FParameters);
         this.FProcessorCDK.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorCDK.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorCDK.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorCDK.OnEffectTransition = this.ProcessorOnEffectTransition;
         this.FProcessorDailyActivity = new TProcessorDailyActivity(this.FMountPointWindows,this.FParameters);
         this.FProcessorDailyActivity.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorDailyActivity.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorDailyActivity.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorDailyActivity.OnEnterCityDefend = this.ProcessorOnEnterCityDefendReq;
         this.FProcessorDailyActivity.OnEnterFightPet = this.ProcessorOnEnterFightPetReq;
         this.FProcessorDailyActivity.OnEnterOrganizationWar = this.ProcessorOnEnterOrganizationWarReq;
         this.FProcessorDailyActivity.OnJoinOrganizationWar = this.ProcessorOnOrganizationalWarCommandRequest;
         this.FProcessorDailyActivity.OnEnterTraitorAttack = this.ProcessorOnEnterTraitorAttackReq;
         this.FProcessorDailyActivity.OnShortcutEffect = this.ProcessorShortcutEffectNotification;
         this.FProcessorDailyActivity.OnTraitorAttackEnd = this.ProcessorTraitorAttackEnd;
         this.FProcessorDailyActivity.OnAutoHangUpStatusReq = this.ProcessorOnAutoHangUpStatusReq;
         this.FProcessorOrganization = new TProcessorOrganization(this.FMountPointWindows,this.FParameters);
         this.FProcessorOrganization.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorOrganization.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorOrganization.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorOrganization.OnEffectTransition = this.ProcessorOnEffectTransition;
         this.FProcessorOrganization.OnShortcutHyperlinks = this.ProcessorShortcutHyperlinks;
         this.FProcessorOrganization.SetDailyActivityStatus = this.SetProcessorDailyActivityStatus;
         this.FProcessorOrganization.OnSetOrganizationName = this.ProcessorOnSetOrganizationalName;
         this.FProcessorOrganization.OnSetOrganizationChannel = this.ProcessorOnActivatingChannel;
         this.FProcessorOrganization.UpdateHerosPower = this.ProcessorOnHerosUpdateBaseAttributeReq;
         this.FProcessorOrganization.OnOrgActivityMuyeBattleSignUp = this.ProcessorOnOrganizationalWarCommandRequest;
         this.FProcessorOrganization.OnOrgActivityMuyeBattleStartBattle = this.ProcessorOnEnterOrganizationWarReq;
         this.FProcessorOrganization.OnOrgActivityMuyeGuardStartBattle = this.ProcessorOnEnterCityDefendReq;
         this.FProcessorOrganization.OnShowHeroInfo = this.ProcessorOnShowHeroInfor;
         this.FProcessorOrganization.OnChatWhisper = this.ProcessorOnChatWhisper;
         this.FProcessorOrganization.OnInterpersonalRelationships = this.ProcessorOnInterpersonalRelationshipsReq;
         this.FProcessorOrganization.SendGVGModule = this.ProcessorSendGVGModule;
         this.FProcessorOrganization.OnShortcutEffectNotification = this.ProcessorShortcutEffectNotification;
         this.FProcessorNarutoRoad = new TProcessorNarutoRoad(this.FMountPointWindows,this.FParameters);
         this.FProcessorNarutoRoad.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorNarutoRoad.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorNarutoRoad.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorNarutoRoad.OnEffectTransition = this.ProcessorOnEffectTransition;
         this.FProcessorNarutoRoad.OnGoto = this.ProcessorOnOpenModel;
         this.FProcessorNarutoRoad.CheckEffect = this.ProcessorShortcutEffectNotification;
         this.FProcessorNarutoRoad.ShowNarutoRoadTip = this.ProcessorShowNarutoRoadTip;
         this.FProcessorNarutoRoad.ObligatoryCoursesCount = this.ProcessorObligatoryCoursesCount;
         this.FProcessorShinobidoPractise = new TProcessorShinobidoPractise(this.FMountPointWindows,this.FParameters);
         this.FProcessorShinobidoPractise.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorShinobidoPractise.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorShinobidoPractise.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorShinobidoPractise.OnEffectTransition = this.ProcessorOnEffectTransition;
         this.FProcessorShinobidoPractise.OnFightingCapacityShow = this.ProcessorOnFightingCapacityShow;
         this.FProcessorShinobidoPractise.OnGoto = this.ProcessorOnOpenModel;
         this.FProcessorLottery = new TProcessorLottery(this.FMountPointWindows,this.FParameters);
         this.FProcessorLottery.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorLottery.OnOpenLottery = this.ProcessorOnOpenNewActivityList;
         this.FProcessorLottery.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorLottery.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorLottery.OnEffectTransition = this.ProcessorOnEffectTransition;
         this.FProcessorLottery.OnShowHeroInfo = this.ProcessorOnShowHeroInfor;
         this.FProcessorLottery.OnOpenActivity = this.ProcessorOnOpenNewActivityList;
         this.FProcessorSystemActivity = new TProcessorSystemActivity(this.FMountPointWindows,this.FParameters);
         this.FProcessorSystemActivity.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorSystemActivity.OnOpenActivity = this.ProcessorOnOpenNewActivityList;
         this.FProcessorSystemActivity.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorSystemActivity.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorSystemActivity.OnEffectTransition = this.ProcessorOnEffectTransition;
         this.FProcessorSystemActivity.OnGoto = this.ProcessorOnOpenModel;
         this.FProcessorDragonBoat = new TProcessorDragonBoat(this.FMountPointWindows,this.FParameters);
         this.FProcessorDragonBoat.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorDragonBoat.OnOpenActivity = this.ProcessorOnOpenNewActivityList;
         this.FProcessorMentorship = new TProcessorMentorship(this.FMountPointWindows,this.FParameters);
         this.FProcessorMentorship.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorMentorship.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorMentorship.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorMentorship.OnEffectTransition = this.ProcessorOnEffectTransition;
         this.FProcessorMentorship.OnShowOtherPlayerInfor = this.ProcessorOnShowHeroInfor;
         this.FProcessorMentorship.SetStatusType = this.OnSetStatusType;
         this.FProcessorMentorship.OnInitBattle = this.ProcessorLobbyOnInitBattle;
         this.FProcessorFrogWallet = new TProcessorFrogWallet(this.FMountPointWindows,this.FParameters);
         this.FProcessorFrogWallet.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorFrogWallet.OnOpenActivity = this.ProcessorOnOpenNewActivityList;
         this.FProcessorFrogWallet.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorFrogWallet.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorFrogWallet.OnEffectTransition = this.ProcessorOnEffectTransition;
         this.FProcessorFrogWallet.OnGoto = this.ProcessorOnOpenModel;
         this.FProcessorFrogWallet.CheckEffect = this.ProcessorShortcutEffectNotification;
         this.FProcessorVipShop = new TProcessorVipShop(this.FMountPointWindows,this.FParameters);
         this.FProcessorVipShop.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorVipShop.OnOpenActivity = this.ProcessorOnOpenNewActivityList;
         this.FProcessorVipShop.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorVipShop.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorVipShop.OnEffectTransition = this.ProcessorOnEffectTransition;
         this.FProcessorVipShop.CheckEffect = this.ProcessorShortcutEffectNotification;
         this.FProcessorDice = new TProcessorDice(this.FMountPointWindows,this.FParameters);
         this.FProcessorDice.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorDice.OnOpenActivity = this.ProcessorOnOpenNewActivityList;
         this.FProcessorDice.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorDice.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorDice.OnEffectTransition = this.ProcessorOnEffectTransition;
         this.FProcessorDice.CheckEffect = this.ProcessorShortcutEffectNotification;
         this.FProcessorDice.OnShowHeroInfo = this.ProcessorOnShowHeroInfor;
         this.FProcessorConsumeRank = new TProcessorConsumeRank(this.FMountPointWindows,this.FParameters);
         this.FProcessorConsumeRank.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorConsumeRank.OnOpenActivity = this.ProcessorOnOpenNewActivityList;
         this.FProcessorConsumeRank.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorConsumeRank.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorConsumeRank.OnEffectTransition = this.ProcessorOnEffectTransition;
         this.FProcessorConsumeRank.CheckEffect = this.ProcessorShortcutEffectNotification;
         this.FProcessorConsumeRank.OnShowHeroInfo = this.ProcessorOnShowHeroInfor;
         this.FProcessorCommonRecharge = new TProcessorCommonRecharge(this.FMountPointWindows,this.FParameters);
         this.FProcessorCommonRecharge.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorCommonRecharge.OnOpenActivity = this.ProcessorOnOpenNewActivityList;
         this.FProcessorCommonRecharge.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorCommonRecharge.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorCommonRecharge.OnEffectTransition = this.ProcessorOnEffectTransition;
         this.FProcessorCommonRecharge.CheckEffect = this.ProcessorShortcutEffectNotification;
         this.FProcessorTenTail = new TProcessorTenTail(this.FMountPointWindows,this.FParameters);
         this.FProcessorTenTail.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorTenTail.OnOpenActivity = this.ProcessorOnOpenNewActivityList;
         this.FProcessorTenTail.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorTenTail.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorTenTail.OnEffectTransition = this.ProcessorOnEffectTransition;
         this.FProcessorTenTail.CheckEffect = this.ProcessorShortcutEffectNotification;
         this.FProcessorVIPFreeBuy = new TProcessorVIPFreeBuy(this.FMountPointWindows,this.FParameters);
         this.FProcessorVIPFreeBuy.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorVIPFreeBuy.OnOpenActivity = this.ProcessorOnOpenNewActivityList;
         this.FProcessorVIPFreeBuy.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorVIPFreeBuy.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorVIPFreeBuy.OnEffectTransition = this.ProcessorOnEffectTransition;
         this.FProcessorVIPFreeBuy.CheckEffect = this.ProcessorShortcutEffectNotification;
         this.FProcessorSeventhEvening = new TProcessorSeventhEvening(this.FMountPointWindows,this.FParameters);
         this.FProcessorSeventhEvening.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorSeventhEvening.OnOpenActivity = this.ProcessorOnOpenNewActivityList;
         this.FProcessorSeventhEvening.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorSeventhEvening.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorSeventhEvening.OnEffectTransition = this.ProcessorOnEffectTransition;
         this.FProcessorSeventhEvening.CheckEffect = this.ProcessorShortcutEffectNotification;
         this.FProcessorSeventhEvening.OnShowHeroInfo = this.ProcessorOnShowHeroInfor;
         this.FProcessorCrossServerWarWindows = new TProcessorCrossServerWarWindows(this.FMountPointWindows,this.FParameters);
         this.FProcessorCrossServerWarWindows.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorCrossServerWarWindows.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorCrossServerWarWindows.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorCrossServerWarWindows.OnEffectTransition = this.ProcessorOnEffectTransition;
         this.FProcessorCrossServerWarWindows.OnEliteApply = this.ProcessorOnEliteApply;
         this.FProcessorCrossServerWarWindows.OnToastClick = this.ProcessorOnToastClick;
         this.FProcessorCrossServerWarWindows.OnRecruitCLick = this.ProcessorOnRecruitCLick;
         this.FProcessorCrossServerWarWindows.OnItemExchangeClick = this.ProcessorOnItemExchangeClick;
         this.FProcessorCrossServerWarWindows.OnTokenExchangeClick = this.ProcessorOnTokenExchangeClick;
         this.FProcessorCrossServerWarWindows.OnRankingsReq = this.ProcessorOnRankingsReq;
         this.FProcessorCrossServerWarWindows.OnToastReq = this.ProcessorOnToastReq;
         this.FProcessorCrossServerWarWindows.OnEliteRecordReq = this.ProcessorOnEliteRecordReq;
         this.FProcessorActivityManager = new TProcessorActivityManager(this.FMountPointWindows,this.FParameters);
         this.FProcessorActivityManager.OnClose = this.ProcessorsWindowsOnCloseActivityManager;
         this.FProcessorActivityManager.OnOpenActivity = this.ProcessorOnOpenNewActivityList;
         this.FProcessorActivityManager.OnOpenThirdActivity = this.ProcessorOnOpenActivityThirdList;
         this.FProcessorActivityManager.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorActivityManager.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorActivityManager.OnEffectTransition = this.ProcessorOnEffectTransition;
         this.FProcessorActivityManager.CheckEffect = this.ProcessorShortcutEffectNotification;
         this.FProcessorActivityManager.OnShowHeroInfo = this.ProcessorOnShowHeroInfor;
         this.FProcessorActivityManager.OnAddTitle = this.ProcessorOnAddTitle;
         this.FProcessorActivityManager.OnGoto = this.ProcessorOnOpenModel;
         this.FProcessorRechargeRank = new TProcessorRechargeRank(this.FMountPointWindows,this.FParameters);
         this.FProcessorRechargeRank.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorRechargeRank.OnOpenActivity = this.ProcessorOnOpenNewActivityList;
         this.FProcessorRechargeRank.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorRechargeRank.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorRechargeRank.OnEffectTransition = this.ProcessorOnEffectTransition;
         this.FProcessorRechargeRank.CheckEffect = this.ProcessorShortcutEffectNotification;
         this.FProcessorRechargeRank.OnShowHeroInfo = this.ProcessorOnShowHeroInfor;
         this.FProcessorMagic = new TProcessorMagic(this.FMountPointWindows,this.FParameters);
         this.FProcessorMagic.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorMagic.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorMagic.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorMagic.OnEffectTransition = this.ProcessorOnEffectTransition;
         this.FProcessorMagic.SetStatusType = this.OnSetStatusType;
         this.FProcessorMagic.OnInitBattle = this.ProcessorLobbyOnInitBattle;
         this.FProcessorMagic.OnUpdateAttribute = this.ProcessorOnUpdateAttribute;
         this.FProcessorMagic.OnEffectSign = this.ProcessorShortcutEffectNotification;
         this.FProcessorMagic.CheckIconEffect = this.ProcessorShortcutEffectNotification;
         this.FProcessorTower = new TProcessorTower(this.FMountPointWindows,this.FParameters);
         this.FProcessorTower.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorTower.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorTower.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorTower.OnEffectTransition = this.ProcessorOnEffectTransition;
         this.FProcessorTower.SetStatusType = this.OnSetStatusType;
         this.FProcessorTower.OnInitBattle = this.ProcessorLobbyOnInitBattle;
         this.FProcessorDailyWelfare = new TProcessorDailyWelfare(this.FMountPointWindow,this.FParameters);
         this.FProcessorDailyWelfare.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorDailyWelfare.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorDailyWelfare.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorDailyWelfare.OnEffectSign = this.ProcessorShortcutEffectNotification;
         this.FProcessorExplanation = new TProcessorExplanation(this.FMountPointWindow,this.FParameters);
         this.FProcessorExplanation.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorExplanation.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorExplanation.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorExplanation.OnEffectSign = this.ProcessorShortcutEffectNotification;
         this.FProcessorExplanation.PalaceRankingsReq = this.ProcessorPalaceRankingsReq;
         this.FPocessorNinJaPractice = new TProcessorNinJaPractice(this.FMountPointWindow,this.FParameters);
         this.FPocessorNinJaPractice.OnClose = this.ProcessorsWindowsOnClose;
         this.FPocessorNinJaPractice.OnEffectText = this.ProcessorsOnEffectText;
         this.FPocessorNinJaPractice.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FPocessorNinJaPractice.UpdateHeroPower = this.ProcessorOnHeroUpdateBaseAttribute;
         this.FPocessorNinJaPractice.OnShortcutHyperlinks = this.ProcessorShortcutHyperlinks;
         this.FPocessorNinJaPractice.UpdateHeroProperty = this.UpdateHeroProperty;
         this.FPocessorNinJaPractice.UpdateHeroView = this.ProcessorOnChangeShape;
         this.FPocessorNinJaPractice.OnQueryShortcutCoordinate = this.ProcessorOnQueryShortcutCoordinate;
         this.FPocessorNinJaPractice.OnEffectForSkill = this.ProcessorOnEffectAcquireInventory;
         this.FProcessorTopOrganization = new TProcessorTopOrganization(this.FMountPointWindow,this.FParameters);
         this.FProcessorTopOrganization.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorTopOrganization.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorTopOrganization.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorTopOrganization.OnEffectSign = this.ProcessorShortcutEffectNotification;
         this.FProcessorTongLing = new TPressorWindowTongLing(this.FMountPointWindow,this.FParameters);
         this.FProcessorTongLing.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorTongLing.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorTongLing.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorTongLing.UpdateLittlePetInfo = this.ProcessorOnUpdateLittlePetInfo;
         this.FProcessorTongLing.UpdateHeroPower = this.ProcessorOnHerosUpdateBaseAttributeReq;
         this.FProcessorTongLing.UpdataWindowHeroInfor = this.UpdataWindowHeroInfor;
         this.FProcessorTongLing.OpenShop = this.OpenShopByTongLing;
         this.FProcessorSantaClaus = new TProcessorSantaClaus(this.FMountPointWindow,this.FParameters);
         this.FProcessorSantaClaus.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorSantaClaus.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorSantaClaus.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorUpdateList = new TProcessorUpdateList(this.FMountPointWindow,this.FParameters);
         this.FProcessorUpdateList.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorBugList = new TProcessorBugList(this.FMountPointWindow,this.FParameters);
         this.FProcessorBugList.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorBugList.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorBugList.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorGodEquip = new TProcessorGodEquip(this.FMountPointWindow,this.FParameters);
         this.FProcessorGodEquip.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorGodEquip.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorGroupBattle = new TProcessorGroupBattle(this.FMountPointWindow,this.FParameters);
         this.FProcessorGroupBattle.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorGroupBattle.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorGroupBattle.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorGroupBattle.OnEffectSign = this.ProcessorShortcutEffectNotification;
         this.FProcessorGroupBattle.OnReturnHall = this.ProcessorReturnHall;
         this.FProcessorGroupBattle.OnEnterPlayerRoom = this.ProcessorOnEnterPlayerRoom;
         this.FProcessorGroupBattle.OnUpdataRoom = this.ProcessorUpdataRoom;
         this.FProcessorGroupBattle.OnResetRoomAutoOnMatching = this.ProcessorResetRoomAutoOnMatching;
         this.FProcessorGroupBattle.OnSetGroupBattleType = this.ProcessorSetGroupBattleType;
         this.FProcessorGroupBattle.OnSetGroupBattleInfor = this.ProcessorSetGroupBattleInfor;
         this.FProcessorGroupBattle.OnSetGroupBattleReward = this.ProcessorSetGroupBattleReward;
         this.FProcessorGroupBattle.OnEnterReady = this.ProcessorOnEnterReady;
         this.FProcessorGroupBattle.OnUpdataWindowReady = this.ProcessorOnUpdataWindowReady;
         this.FProcessorGroupBattle.OnUpdateInviteShadows = this.ProcessorOnUpdateInviteShadows;
         this.FProcessorGroupBattle.OnCloseBattleSelect = this.ProcessorOnCloseBattleSelect;
         this.FProcessorGroupBattle.OnOpenNijiaBattleWindow = this.ProcessorOnOpenNijiaBattleWindow;
         this.FProcessorGroupBattle.OnEffectNewPveTimes = this.ProcessorShortcutEffectNotification;
         this.FProcessorGroupBattle.GoAccessory = this.ProcessorShortcutsAccessoryIntensityOnClick;
         this.FProcessorWindowAccessory = new TProcessorWindowAccessoryMain(this.FMountPointWindow,this.FParameters);
         this.FProcessorWindowAccessory.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorWindowAccessory.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorWindowBloodSoulPurgatoryMain = new TProcessorWindowBloodSoulPurgatoryMain(this.FMountPointWindow,this.FParameters);
         this.FProcessorWindowBloodSoulPurgatoryMain.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorWindowBloodSoulPurgatoryMain.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorWindowBloodSoulPurgatoryMain.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorWindowBloodSoulPurgatoryMain.OnInitBattle = this.ProcessorLobbyOnInitBattle;
         this.FProcessorWindowBloodSoulPurgatoryMain.SetStatusType = this.OnSetStatusType;
         this.FProcessorWindowBloodSoulPurgatoryMain.Distant = this.Distant;
         this.FProcessorWindowBloodSoulPurgatoryMain.OnEffectSign = this.ProcessorShortcutEffectNotification;
         this.FProcessorWindowSixFairyMain = new TProcessorWindowSixFairyMain(this.FMountPointWindow,this.FParameters);
         this.FProcessorWindowSixFairyMain.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorWindowSixFairyMain.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorWindowSixFairyMain.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorWindowSixFairyMain.OnInitBattle = this.ProcessorLobbyOnInitBattle;
         this.FProcessorWindowSixFairyMain.SetStatusType = this.OnSetStatusType;
         this.FProcessorWindowSixFairyMain.OnEffectSign = this.ProcessorShortcutEffectNotification;
         this.FProcessorTopTeam = new TProcessorTopTeam(this.FMountPointWindow,this.FParameters);
         this.FProcessorTopTeam.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorTopTeam.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorTopTeam.OnEnterPlayerRoom = this.ProcessorOnEnterTopTeamRoom;
         this.FProcessorTopTeam.OnUpdateRoomData = this.ProcessorOnUpdateRoomData;
         this.FProcessorTopTeam.UpdateActivityStatus = this.ProcessorUpdateActivityStatus;
         this.FProcessorTopTeam.OnInitBattle = this.ProcessorLobbyOnInitBattle;
         this.FProcessorTopTeam.OnSetTopTeamBattleType = this.ProcessorSetTopTeamBattleType;
         this.FProcessorTopTeam.OnSetTopTeamBattleInfor = this.ProcessorSetTopTeamBattleInfor;
         this.FProcessorTopTeam.OnSetTopTeamBattleReward = this.ProcessorSetTopTeamBattleReward;
         this.FProcessorTopTeam.OnMatchSuccess = this.ProcessorOnMatchSuccess;
         this.FProcessorTopTeam.OnUpdateInviteList = this.ProcessorOnUpdateInviteList;
         this.FProcessorTopTeam.OnApplyCaptain = this.ProcessorOnApplyCaptain;
         this.FProcessorTopTeam.OnExitRoom = this.ProcessorOnExitRoom;
         this.FProcessorTopTeam.OnOpenTopTeamWindow = this.ProcessorOnOpenTopTeamWindow;
         this.FProcessorTopTeam.OnCloseBattleRoomUI = this.ProcessorOnCloseBattleRoomUI;
         this.FProcessorTopTeam.OnEffectSign = this.ProcessorShortcutEffectNotification;
         this.FProcessorTopTeam.OnUpdateTop = this.ProcessorOnUpdateTop;
         this.FProcessorWindowRebirthRealmAllManager = new TProcessorWindowRebirthRealmAllManager(this.FMountPointWindow,this.FParameters);
         this.FProcessorWindowRebirthRealmAllManager.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorWindowRebirthRealmAllManager.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorWindowRebirthRealmAllManager.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorWindowRebirthRealmAllManager.OnInitBattle = this.ProcessorLobbyOnInitBattle;
         this.FProcessorWindowRebirthRealmAllManager.SetStatusType = this.OnSetStatusType;
         this.FProcessorWindowRebirthRealmAllManager.OnEffectSign = this.ProcessorShortcutEffectNotification;
         this.FProcessorWindowNijiaMystic = new TProcessorNijiaMystic(this.FMountPointWindow,this.FParameters);
         this.FProcessorWindowNijiaMystic.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorWindowNijiaMystic.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorWindowNijiaMystic.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorWindowNijiaMystic.CheckIconEffect = this.ProcessorShortcutEffectNotification;
         this.FProcessorNarutoHelper = new TProcessorNarutoHelper(this.FMountPointWindow,this.FParameters);
         this.FProcessorNarutoHelper.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorNarutoHelper.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorNarutoHelper.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorNarutoHelper.OnShortcutHyperlinks = this.ProcessorShortcutHyperlinks;
         this.FProcessorNarutoHelper.OnEffectSign = this.ProcessorShortcutEffectNotification;
         this.FProcessorNarutoHelper.OnFirstRecharge = this.ProcessorShortcutsOnFirstRecharge;
         this.FProcessorPrerogative = new TProcessorPrerogative(this.FMountPointWindow,this.FParameters);
         this.FProcessorPrerogative.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorPrerogative.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorPrerogative.ShowFlatformIconEffect = this.ProcessorShowFlatformIconEffect;
         this.FProcessorPrerogative.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FTProcessorBaiDuMM = new TProcessorBaiDuMM(this.FMountPointWindow,this.FParameters);
         this.FTProcessorBaiDuMM.OnClose = this.ProcessorsWindowsOnClose;
         this.FTProcessorBaiDuMM.OnEffectText = this.ProcessorsOnEffectText;
         this.FTProcessorBaiDuMM.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FTProcessorBaiDuMM.setFBaiDuMeimeiMcState = this.ProcessorsetFBaiDuMeimeiMcState;
         this.FProcessorNinjaRelationship = new TProcessorNinjaRelationship(this.FMountPointWindow,this.FParameters);
         this.FProcessorNinjaRelationship.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorNinjaRelationship.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorNinjaRelationship.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorNinjaHostel = new TProcessorNinjaHostel(this.FMountPointWindow,this.FParameters);
         this.FProcessorNinjaHostel.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorNinjaHostel.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorNinjaHostel.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorNinjaHostel.OnResetHeros = this.ProcessorOnResetHeros;
         this.FProcessorNinjaHostel.OnTakeBackHero = this.ProcessorOnTakeBackHero;
         this.FProcessorOhtsutsukiKaguya = new TProcessorOhtsutsukiKaguya(this.FMountPointWindow,this.FParameters);
         this.FProcessorOhtsutsukiKaguya.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorOhtsutsukiKaguya.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorOhtsutsukiKaguya.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorOhtsutsukiKaguya.UpdateOthersPanel = this.UpdateOthersPanel;
         this.FProcessorOhtsutsukiKaguya.JumpTerm = this.JumpTerm;
         this.FProcessorTransmigrationTrial = new TProcessorTransmigrationTrial(this.FMountPointWindow,this.FParameters);
         this.FProcessorTransmigrationTrial.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorTransmigrationTrial.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorTransmigrationTrial.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorTransmigrationTrial.OnInitBattle = this.ProcessorLobbyOnInitBattle;
         this.FProcessorTransmigrationTrial.SetStatusType = this.OnSetStatusType;
         this.FProcessorTransmigrationTrial.OnEffectSign = this.ProcessorShortcutEffectNotification;
         this.FProcessorTransmigrationAccessory = new TProcessorTransmigrationAccessory(this.FMountPointWindow,this.FParameters);
         this.FProcessorTransmigrationAccessory.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorTransmigrationAccessory.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorTransmigrationAccessory.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorTransmigrationAccessory.OnInitBattle = this.ProcessorLobbyOnInitBattle;
         this.FProcessorTransmigrationAccessory.SetStatusType = this.OnSetStatusType;
         this.FProcessorTransmigrationAccessory.OnEffectSign = this.ProcessorShortcutEffectNotification;
         this.FProcessorVkSiMiDa = new TProcessorVkSiMiDa(this.FMountPointWindow,this.FParameters);
         this.FProcessorVkSiMiDa.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorVkSiMiDa.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorVkSiMiDa.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorVkSiMiDa.OpenThisPanelFunction = this.OpenVk;
         this.FProcessorAccountTransfer = new TProcessorAccountTransfer(this.FMountPointWindow,this.FParameters);
         this.FProcessorAccountTransfer.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorAccountTransfer.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorAccountTransfer.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorOnLineLiBao = new TProcessorOnLineLiBao(this.FMountPointWindow,this.FParameters);
         this.FProcessorOnLineLiBao.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorOnLineLiBao.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorOnLineLiBao.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorOnLineLiBao.IconIsShow = this.IconIsShow;
         this.FProcessorZhenAoYi = new TProcessorZhenAoYi(this.FMountPointWindow,this.FParameters);
         this.FProcessorZhenAoYi.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorZhenAoYi.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorZhenAoYi.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FPressorWindowTaboo = new TPressorWindowTaboo(this.FMountPointWindows,this.FParameters);
         this.FPressorWindowTaboo.OnClose = this.ProcessorsWindowsOnClose;
         this.FPressorWindowTaboo.OnEffectText = this.ProcessorsOnEffectText;
         this.FPressorWindowTaboo.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FPressorWindowTaboo.OnInitBattle = this.ProcessorLobbyOnInitBattle;
         this.FPressorWindowTaboo.SetStatusType = this.OnSetStatusType;
         this.FPressorWindowTaboo.CheckIconEffect = this.ProcessorShortcutEffectNotification;
         this.FProcessorWindowUndertown = new TProcessorUndertown(this.FMountPointWindow,this.FParameters);
         this.FProcessorWindowUndertown.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorWindowUndertown.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorWindowUndertown.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorWindowUndertown.OnInitBattle = this.ProcessorLobbyOnInitBattle;
         this.FProcessorWindowUndertown.SetStatusType = this.OnSetStatusType;
         this.FProcessorWindowUndertown.SetBattlePacket = this.OnSetBattlePacket;
         this.FProcessorWindowUndertown.CheckIconEffect = this.ProcessorShortcutEffectNotification;
         this.FProcessorMasterRoadOld = new TProcessorMasterRoadOld(this.FMountPointWindow,this.FParameters);
         this.FProcessorMasterRoadOld.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorMasterRoadOld.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorMasterRoadOld.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorLostShenQiMain = new TProcessorLostShenQiMain(this.FMountPointWindow,this.FParameters);
         this.FProcessorLostShenQiMain.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorLostShenQiMain.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorLostShenQiMain.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorLostShenQiMain.MC_Goto_FaQiFunction = this.MC_Goto_FaQiFunction;
         this.FProcessorLostShenQiMain.SetStatusType = this.OnSetStatusType;
         this.FProcessorLostShenQiMain.OnInitBattle = this.ProcessorLobbyOnInitBattle;
         this.FProcessorWing = new TProcessorWing(this.FMountPointWindow,this.FParameters);
         this.FProcessorWing.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorWing.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorWing.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorWing.OnUpdateWing = this.UpdateWing;
         this.FProcessorWing.SetStatusType = this.OnSetStatusType;
         this.FProcessorWing.OnInitBattle = this.ProcessorLobbyOnInitBattle;
         this.FProcessorWindowAddSoul = new TProcessorWindowAddSoul(this.FMountPointWindow,this.FParameters);
         this.FProcessorWindowAddSoul.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorWindowAddSoul.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorWindowAddSoul.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorWindowAddSoul.GoSoulFormation = this.ProcessorGotoSoulFormation;
         this.FProcessorIllustrated = new TProcessorIllustrated(this.FMountPointWindow,this.FParameters);
         this.FProcessorIllustrated.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorIllustrated.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorIllustrated.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorMarried = new TProcessorMarried(this.FMountPointWindow,this.FParameters);
         this.FProcessorMarried.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorMarried.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorMarried.OnDialogMsg = this.ProcessorOnDialogMsg;
         TMarriedModel.married = this.FProcessorMarried;
         this.FProcessorHomeland = new TProcessorHomeland(this.FMountPointWindow,this.FParameters);
         this.FProcessorHomeland.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorHomeland.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorHomeland.OnDialogMsg = this.ProcessorOnDialogMsg;
         THomelandModel.homeLand = this.FProcessorHomeland;
         THomelandModel.ProcessorWindowsSwitch = this.ProcessorWindowsSwitch;
         this.FProcessorMarryRank = new TProcessorMarryRank(this.FMountPointWindow,this.FParameters);
         this.FProcessorMarryRank.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorMarryRank.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorMarryRank.OnDialogMsg = this.ProcessorOnDialogMsg;
         TMarryRankModel.marryRank = this.FProcessorMarryRank;
         this.FSpecialJade = new TSpecialJade(this.FMountPointWindow,this.FParameters);
         this.FSpecialJade.OnClose = this.ProcessorsWindowsOnClose;
         this.FSpecialJade.OnEffectText = this.ProcessorsOnEffectText;
         this.FSpecialJade.OnUpdateJade = this.OnUpdateJade;
         this.FProcessorAline = new TProcessorAlien(this.FMountPointWindow,this.FParameters);
         this.FProcessorAline.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorAline.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorAline.OnInitBattle = this.ProcessorLobbyOnInitBattle;
         this.FProcessorAline.SetStatusType = this.OnSetStatusType;
         this.FProcessorAline.GotoNinjaFun = this.ProcessorGotoNinjaFun;
         this.FProcessorBindEmail = new TProcessorBindEmail(this.FMountPointWindow,this.FParameters);
         this.FProcessorBindEmail.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorBindEmail.OnOpenActivity = this.ProcessorOnOpenNewActivityList;
         this.FProcessorBindEmail.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorAccountSafe = new TProcessorAccountSafe(this.FMountPointWindow,this.FParameters);
         this.FProcessorAccountSafe.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorAccountSafe.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorRank = new TProcessorRank(this.FMountPointWindow,this.FParameters);
         this.FProcessorRank.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorRank.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorRank.OnInitBattle = this.ProcessorLobbyOnInitBattle;
         this.FProcessorRank.SetStatusType = this.OnSetStatusType;
         this.FProcessorKingWar = new TProcessorKingWar(this.FMountPointWindow,this.FParameters);
         this.FProcessorKingWar.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorKingWar.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorKingWar.CheckIconEffect = this.ProcessorShortcutEffectNotification;
         this.FProcessorVipWelfare = new TProcessorVipWelfare(this.FMountPointWindow,this.FParameters);
         this.FProcessorVipWelfare.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorVipWelfare.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorMicrologinLibao = new TProcessorMicrologinLibao(this.FMountPointWindow,this.FParameters);
         this.FProcessorMicrologinLibao.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorMicrologinLibao.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorMicrologinLibao.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorMicrologinLibao.IconIsShow = this.MiIconIsShow;
         this.FProcessorMedal = new TProcessorMedal(this.FMountPointWindow,this.FParameters);
         this.FProcessorMedal.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorMedal.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorMedal.OnMountTalisman = this.ProcessorOnMountTalisman;
         this.FProcessorMedal.OnDismountTalisman = this.ProcessorOnDismountTalisman;
         this.FProcessorInviteCode = new TProcessorInviteCode(this.FMountPointWindow,this.FParameters);
         this.FProcessorInviteCode.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorInviteCode.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorWuxing = new TProcessorWuxing(this.FMountPointWindow,this.FParameters);
         this.FProcessorWuxing.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorWuxing.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorWarehouse = new TProcessorWarehouse(this.FMountPointWindow,this.FParameters);
         this.FProcessorWarehouse.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorWarehouse.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorDiscord = new TProcessorDiscord(this.FMountPointWindows,this.FParameters);
         this.FProcessorDiscord.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorDiscord.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorWindowShop = new TProcessorWindowShop(this.FMountPointWindows,this.FParameters);
         this.FProcessorWindowShop.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorWindowShop.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorConsumeVip = new TProcessorConsumeVip(this.FMountPointWindows,this.FParameters);
         this.FProcessorConsumeVip.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorConsumeVip.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorConsumeVip.OnInitConsumeVip = this.ProcessorsOnInitConsumeVip;
         this.FProcessorConsumeVip.OnEffectBaseGlowVIP = this.ProcessorOnEffectBaseGlowSVIP;
         this.FProcessorEmblem = new TProcessorEmblem(this.FMountPointWindows,this.FParameters);
         this.FProcessorEmblem.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorEmblem.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorChristmasDay = new TProcessorChristmasDay(this.FMountPointWindows,this.FParameters);
         this.FProcessorChristmasDay.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorChristmasDay.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorChristmasDay.OnOpenActivity = this.ProcessorOnOpenActivityThirdList;
         this.FProcessorChristmasDay.GoToOpenShop = this.ProcessorGotoOpenShop;
         this.FProcessorNinjaTalent = new TProcessorNinjaTalent(this.FMountPointWindows,this.FParameters);
         this.FProcessorNinjaTalent.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorNinjaTalent.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorNinjaTalent.GotoOpenLevelGifts = this.ProcessorGotoOpenLevelGifts;
         this.FProcessorNinjaTalent.GotoOpenTalentGifts = this.ProcessorGotoOpenTalentGifts;
         this.FProcessorChallengeCamp = new TProcessorChallengeCamp(this.FMountPointWindows,this.FParameters);
         this.FProcessorChallengeCamp.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorChallengeCamp.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorChallengeCamp.OnInitBattle = this.ProcessorLobbyOnInitBattle;
         this.FProcessorChallengeCamp.SetStatusType = this.OnSetStatusType;
         this.FProcessorTalentLevelGifts = new TProcessorTalentLevelGifts(this.FMountPointWindows,this.FParameters);
         this.FProcessorTalentLevelGifts.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorTalentLevelGifts.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorHeroLevelGifts = new TProcessorHeroLevelGifts(this.FMountPointWindows,this.FParameters);
         this.FProcessorHeroLevelGifts.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorHeroLevelGifts.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorHeroLevelGifts.OnOpenActivity = this.ProcessorOnOpenNewActivityList;
         this.FProcessorWorldMatchStreak = new TProcessorWorldMatchStreak(this.FMountPointWindows,this.FParameters);
         this.FProcessorWorldMatchStreak.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorWorldMatchStreak.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorWorldMatchStreak.UpdateEffectGlowFilter = this.ProcessorOnEffectGlowFilter;
         this.FProcessorGlobalBoss = new TProcessorGlobalBoss(this.FMountPointWindows,this.FParameters);
         this.FProcessorGlobalBoss.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorGlobalBoss.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorGlobalBoss.OnOpenGlobalbossChapter = this.ProcessorOnOpenGlobalbossChapter;
         this.FProcessorGlobalBoss.OnTacticalDeployment = this.ProcessorShortcutsTacticalDeploymentOnClick;
         this.FProcessorGlobalBoss.OnInitBattle = this.ProcessorLobbyOnInitBattle;
         this.FProcessorGlobalBoss.SetStatusType = this.OnSetStatusType;
         this.FProcessorGlobalBoss.SetGlobalboss = this.ProcessorOnSetGlobalboss;
         this.FProcessorGlobalBoss.CheckIconEffect = this.ProcessorShortcutEffectNotification;
         this.FProcessorGlobalBoss.OnOpenGlobalbossMain = this.ProcessorsShortcutsOnActivityGlobalBossMain;
         this.FProcessorGlobalBossMain = new TProcessorGlobalBossMain(this.FMountPointWindows,this.FParameters);
         this.FProcessorGlobalBossMain.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorGlobalBossMain.OnOpenGlobalboss = this.ProcessorsShortcutsOnActivityGlobalBoss;
         this.FProcessorGlobalBossMain.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorGlobalbossChapter = new TProcessorGlobalbossChapter(this.FMountPointWindows,this.FParameters);
         this.FProcessorGlobalbossChapter.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorGlobalbossChapter.OnOpenGlobalboss = this.ProcessorsShortcutsOnActivityGlobalBoss;
         this.FProcessorGlobalbossChapter.UpdateChapterReward = this.ProcessorOnUpdateChapterReward;
         this.FProcessorDayRechargeGift = new TProcessorDayRechargeGift(this.FMountPointWindows,this.FParameters);
         this.FProcessorDayRechargeGift.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorDayRechargeGift.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorDayRechargeGift.OnOpenActivity = this.ProcessorOnOpenNewActivityList;
         this.FProcessorDayRechargeGift.CheckIconEffect = this.ProcessorShortcutEffectNotification;
         this.FProcessorRecruit = new TProcessorRecruit(this.FMountPointWindows,this.FParameters);
         this.FProcessorRecruit.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorRecruit.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorSlave = new TProcessorSlave(this.FMountPointWindows,this.FParameters);
         this.FProcessorSlave.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorSlave.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorSlave.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorSlave.OnEffectTransition = this.ProcessorOnEffectTransition;
         this.FProcessorSlave.OnShowOtherPlayerInfor = this.ProcessorOnShowHeroInfor;
         this.FProcessorSlave.SetStatusType = this.OnSetStatusType;
         this.FProcessorSlave.OnInitBattle = this.ProcessorLobbyOnInitBattle;
         this.FProcessorTalentGifts = new TProcessorTalentGifts(this.FMountPointWindow,this.FParameters);
         this.FProcessorTalentGifts.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorTalentGifts.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorLeadLevelGifts = new TProcessorLeadLevelGifts(this.FMountPointWindow,this.FParameters);
         this.FProcessorLeadLevelGifts.OnClose = this.ProcessorsWindowsOnClose;
         this.FProcessorLeadLevelGifts.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorLeadLevelGifts.OnOpenActivity = this.ProcessorOnOpenNewActivityList;
         this.FProcessorsWindows = Vector.<TProcessorLobbyWindows>([this.FProcessorProtagonist,this.FProcessorHeros,this.FProcessorTacticalDeployment,this.FProcessorBackpack,this.FProcessorPet,this.FProcessorSmithy,this.FProcessorKillHeros,this.FProcessorJade,this.FProcessorBigDipper,this.FProcessorGeneralStar,this.FProcessorMakeEquip,this.FProcessorTalisman,this.FProcessorEquipAdvanced,this.FProcessorMail,this.FProcessorRamen,this.FProcessorFriend,this.FProcessorVIP,this.FProcessorMall,this.FProcessorDailySign,this.FProcessorBugCommit,this.FProcessorCopyHero,this.FProcessorDailyQuest,this.FProcessorRecharge,this.FProcessorFirstRecharge,this.FProcessorGiftBag,this.FProcessorRechargeCashback,this.FProcessorWonderfulActivity,this.FProcessorOrganization,this.FProcessorCDK,this.FProcessorDailyActivity,this.FProcessorNarutoRoad,this.FProcessorShinobidoPractise,this.FProcessorLottery,this.FProcessorSystemActivity,this.FProcessorDragonBoat,this.FProcessorMentorship,this.FProcessorFrogWallet,this.FProcessorVipShop
         ,this.FProcessorDice,this.FProcessorConsumeRank,this.FProcessorCommonRecharge,this.FProcessorTenTail,this.FProcessorVIPFreeBuy,this.FProcessorSeventhEvening,this.FProcessorCrossServerWarWindows,this.FProcessorActivityManager,this.FProcessorRechargeRank,this.FProcessorMagic,this.FProcessorTower,this.FProcessorDailyWelfare,this.FProcessorExplanation,this.FPocessorNinJaPractice,this.FProcessorTopOrganization,this.FProcessorTongLing,this.FProcessorSantaClaus,this.FProcessorUpdateList,this.FProcessorBugList,this.FProcessorWindowAccessory,this.FProcessorGroupBattle,this.FProcessorGodEquip,this.FProcessorWindowBloodSoulPurgatoryMain,this.FProcessorWindowSixFairyMain,this.FProcessorTopTeam,this.FProcessorWindowRebirthRealmAllManager,this.FProcessorWindowNijiaMystic,this.FProcessorNarutoHelper,this.FProcessorNinjaHostel,this.FTProcessorBaiDuMM,this.FPressorWindowNewMall,this.FProcessorTransmigrationTrial,this.FProcessorTransmigrationAccessory,this.FPressorWindowTaboo,this.FProcessorVkSiMiDa,this
         .FProcessorAccountTransfer,this.FProcessorWindowUndertown,this.FProcessorOnLineLiBao,this.FProcessorZhenAoYi,this.FProcessorMasterRoadOld,this.FProcessorLostShenQiMain,this.FProcessorWing,this.FProcessorWindowAddSoul,this.FProcessorIllustrated,this.FProcessorMarried,this.FProcessorHomeland,this.FProcessorMarryRank,this.FSpecialJade,this.FProcessorAline,this.FProcessorBindEmail,this.FProcessorAccountSafe,this.FProcessorRank,this.FProcessorKingWar,this.FProcessorVipWelfare,this.FProcessorMicrologinLibao,this.FProcessorMedal,this.FProcessorInviteCode,this.FProcessorWuxing,this.FProcessorWarehouse,this.FProcessorDiscord,this.FProcessorWindowShop,this.FProcessorConsumeVip,this.FProcessorEmblem,this.FProcessorChristmasDay,this.FProcessorNinjaTalent,this.FProcessorChallengeCamp,this.FProcessorTalentLevelGifts,this.FProcessorHeroLevelGifts,this.FProcessorWorldMatchStreak,this.FProcessorGlobalBoss,this.FProcessorGlobalBossMain,this.FProcessorGlobalbossChapter,this.FProcessorDayRechargeGift,this.FProcessorRecruit
         ,this.FProcessorSlave,this.FProcessorTalentGifts,this.FProcessorLeadLevelGifts]);
      }
      
      protected function ConstructProcessorShortcuts() : void
      {
         this.FProcessorShortcuts = new TProcessorShortcuts(this.FMountPointShortcuts,this.FMountPointShortcutsSpecial,this.FParameters);
         this.FProcessorShortcuts.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorShortcuts.OnUnlockResponse = this.ProcessorOnUnlockResponse;
         this.FProcessorShortcuts.OnAvaterHead = this.ProcessorShortcutsOnAvaterHeadClick;
         this.FProcessorShortcuts.OnVip = this.ProcessorShortcutsVipOnClick;
         this.FProcessorShortcuts.OnPromote = this.ProcessorOnPromote;
         this.FProcessorShortcuts.OnEnterAutoBattle = this.ProcessorOnEnterAutoBattle;
         this.FProcessorShortcuts.WelfareOnClick = this.ProcesorWelfareOnClick;
         this.FProcessorShortcuts.ObligatoryCoursesOnClick = this.ProcesorObligatoryCoursesOnClick;
         this.FProcessorShortcuts.OpenOnLineGift = this.OpenOnLineGift;
         this.FProcessorShortcuts.RankIconClick = this.ProcessorrankIconClick;
         this.FProcessorShortcuts.OnVipWelfareClick = this.ProcessorVipWelfareClick;
         this.FProcessorShortcuts.OnMicrologin = this.ProcessorMicrologinOnClick;
         this.FProcessorShortcuts.OnConsumeVip = this.ProcessorConsumeVipOnClick;
         this.FProcessorShortcuts.BaiDuMeimeiOnClick = this.ProcesorBaiDuMeimeiOnClick;
         this.FProcessorShortcuts.OhtsutsukiKaguyaOnClick = this.ProcesorOhtsutsukiKaguyaOnClick;
         this.FProcessorShortcuts.OhtsutsuVkOnClick = this.OpenVk;
         this.FProcessorShortcuts.MC1377OnClick = this.ProcessorShortcutAccountTransfer;
         this.FProcessorShortcuts.AccountLockOnClick = this.ProcessorAccountLockOnClick;
         this.FProcessorShortcuts.OnActivityArena = this.ProcessorShortcutsOnArena;
         this.FProcessorShortcuts.OnActivityKillHeros = this.ProcessorShortcutsOnKillHeros;
         this.FProcessorShortcuts.OnActivitySign = this.ProcessorShortcutsOnSign;
         this.FProcessorShortcuts.OnActivityCopyHero = this.ProcessorShortcutsOnCopyHero;
         this.FProcessorShortcuts.OnActivityTreasureMap = this.ProcessorShortcutsOnTreasureMap;
         this.FProcessorShortcuts.OnActivitySuperHero = this.ProcessorShortcutsOnSuperHero;
         this.FProcessorShortcuts.OnActivityMall = this.ProcessorShortcutsOnMall;
         this.FProcessorShortcuts.OnActivityDailyQuest = this.ProcessorShortcutsOnDailyQuest;
         this.FProcessorShortcuts.OnActivityDailyActivity = this.ProcessorShortcutsOnDailyActivity;
         this.FProcessorShortcuts.OnActivityNarutoRoad = this.ProcessorShortcutsOnNarutoRoad;
         this.FProcessorShortcuts.OnActivitySlave = this.ProcessorShortcutsOnMentorship;
         this.FProcessorShortcuts.OnActivitySevenKing = this.ProcessorShortcutsOnSevenKing;
         this.FProcessorShortcuts.OnActivityCrossServerWar = this.ProcessorShortcutsOnCrossServerWar;
         this.FProcessorShortcuts.OnActivityMagic = this.ProcessorShortcutsOnMagic;
         this.FProcessorShortcuts.OnActivityMoutain = this.ProcessorShortcutsOnMagic;
         this.FProcessorShortcuts.OnActivityTower = this.ProcessorShortcutsOnTower;
         this.FProcessorShortcuts.OnActivityDailyWelfare = this.ProcessorShortcutsOnDailyWelfare;
         this.FProcessorShortcuts.OnActivityNijiaStar = this.ProcessorsShortcutsOnNijiaStar;
         this.FProcessorShortcuts.OnActivityPalace = this.ProcessorsShortcutsOnActivityPalace;
         this.FProcessorShortcuts.OnActivityRamen = this.ProcessorsShortcutsOnActivityRamen;
         this.FProcessorShortcuts.OnActivityTopOrganization = this.ProcessorsShortcutsOnActivityTopOrganization;
         this.FProcessorShortcuts.OnActivityGroupBattle = this.ProcessorsShortcutsOnActivityGroupBattle;
         this.FProcessorShortcuts.OnActivityLaboratory = this.ProcessorsShortcutsOnActivityLaboratory;
         this.FProcessorShortcuts.OnActivitySixFairy = this.ProcessorsShortcutsOnActivitySixFairy;
         this.FProcessorShortcuts.OnActivityTopTeam = this.ProcessorsShortcutsOnActivityTopTeam;
         this.FProcessorShortcuts.OnActivityRebirthRealm = this.ProcessorsShortcutsOnActivityRebirthRealm;
         this.FProcessorShortcuts.OnActivityNijiaMystic = this.ProcessorsShortcutsOnActivityNijiaMystic;
         this.FProcessorShortcuts.OnActivityNarutoHelper = this.ProcessorsShortcutsOnActivityNarutoHelper;
         this.FProcessorShortcuts.OnActivityChoose = this.ProcessorsShortcutsOnActivityChoose;
         this.FProcessorShortcuts.OnActivityNinjaRelation = this.ProcessorsShortcutsOnActivityNinjaRelation;
         this.FProcessorShortcuts.OnActivityNinjaHostel = this.ProcessorsShortcutsOnActivityNinjaHostel;
         this.FProcessorShortcuts.OnActivityBloodFete = this.ProcessorsShortcutsOnActivityBloodFete;
         this.FProcessorShortcuts.OnActivityEpicEquip = this.ProcessorsShortcutsOnActivityEpicEquip;
         this.FProcessorShortcuts.OnActivityTaboo = this.ProcessorsShortcutsOnActivityTaboo;
         this.FProcessorShortcuts.OnActivityAwaken = this.ProcessorsShortcutsOnActivityAwaken;
         this.FProcessorShortcuts.OnActivityEight = this.ProcessorsShortcutsOnActivityEight;
         this.FProcessorShortcuts.OnActivityTransmigrationAccessory = this.ProcessorsShortcutsOnActivityTransmigrationAccessory;
         this.FProcessorShortcuts.OnActivityTheWorldTree = this.ProcessorsShortcutsOnActivityTheWorldTree;
         this.FProcessorShortcuts.OnActivityUndertown = this.ProcessorsShortcutsOnActivityUndertown;
         this.FProcessorShortcuts.OnActivityLostShenQi = this.ProcessorsShortcutsOnActivityLostShenQi;
         this.FProcessorShortcuts.OnActivityWing = this.ProcessorsShortcutsOnActivityWing;
         this.FProcessorShortcuts.OnActivityChallenge = this.ProcessorsShortcutsOnActivityChallenge;
         this.FProcessorShortcuts.OnActivityIllustrated = this.ProcessorsShortcutsOnActivityIllustrated;
         this.FProcessorShortcuts.OnActivityAlien = this.ProcessorsShortcutsOnActivityAlien;
         this.FProcessorShortcuts.OnActivityKingwar = this.ProcessorsShortcutsOnActivityKingwar;
         this.FProcessorShortcuts.OnActivityMedal = this.ProcessorsShortcutsOnActivityMedal;
         this.FProcessorShortcuts.OnActivityinviteCode = this.ProcessorsShortcutsOnActivityInviteCode;
         this.FProcessorShortcuts.OnActivityWuxing = this.ProcessorsShortcutsOnActivityWuxing;
         this.FProcessorShortcuts.OnActivityGlobalBattle = this.ProcessorsShortcutsOnActivityGlobalBattle;
         this.FProcessorShortcuts.OnActivityEmblem = this.ProcessorsShortcutsOnActivityEmblem;
         this.FProcessorShortcuts.OnActivityWorldMatch = this.ProcessorsShortcutsOnActivityWorldMatch;
         this.FProcessorShortcuts.OnActivitySummonBattle = this.ProcessorsShortcutsOnActivitySummonBattle;
         this.FProcessorShortcuts.OnActivityNinjaTalent = this.ProcessorsShortcutsOnActivityNinjaTalent;
         this.FProcessorShortcuts.OnActivityChallengCamp = this.ProcessorsShortcutsOnActivityChallengCamp;
         this.FProcessorShortcuts.OnActivityGlobalBoss = this.ProcessorsShortcutsOnActivityGlobalBossMain;
         this.FProcessorShortcuts.OnActivityRecruit = this.ProcessorsShortcutsOnActivityRecruit;
         this.FProcessorShortcuts.OnActivityCrossSlave = this.ProcessorsShortcutsOnActivitySlave;
         this.FProcessorShortcuts.OnActiveSpecialCDK = this.ProcessorShortcutsOnCDK;
         this.FProcessorShortcuts.OnActiveSpecialDiscord = this.ProcessorShortcutsOnDiscord;
         this.FProcessorShortcuts.OnNewActiveListLottery = this.ProcessorShortcutsOnLottery;
         this.FProcessorShortcuts.OnNewActiveListSystemActivity = this.ProcessorShortcutsOnSystemActivity;
         this.FProcessorShortcuts.OnNewActiveListDragonBoat = this.ProcessorShortcutsOnCommonRecharge;
         this.FProcessorShortcuts.OnNewActiveListFrogWallet = this.ProcessorShortcutsOnFrogWallet;
         this.FProcessorShortcuts.OnNewActiveListVipShop = this.ProcessorShortcutsOnVipShop;
         this.FProcessorShortcuts.OnNewActiveListDice = this.ProcessorshortcutsOnDice;
         this.FProcessorShortcuts.OnNewActiveListConsumeRank = this.ProcessorshortcutsOnConsumeRank;
         this.FProcessorShortcuts.OnNewActiveListDragonBoat2 = this.ProcessorShortcutsOnCommonRecharge;
         this.FProcessorShortcuts.OnNewActiveListDragonBoat3 = this.ProcessorShortcutsOnCommonRecharge;
         this.FProcessorShortcuts.OnNewActiveListDragonBoat4 = this.ProcessorShortcutsOnCommonRecharge;
         this.FProcessorShortcuts.OnNewActiveListDragonBoat5 = this.ProcessorShortcutsOnCommonRecharge;
         this.FProcessorShortcuts.OnNewActiveListDragonBoat6 = this.ProcessorShortcutsOnCommonRecharge;
         this.FProcessorShortcuts.OnNewActiveListDragonBoat7 = this.ProcessorShortcutsOnCommonRecharge;
         this.FProcessorShortcuts.OnNewActiveListVIPFreeBuy = this.ProcessorShortcutsOnVIPFreeBuy;
         this.FProcessorShortcuts.OnNewActiveListTenTail = this.ProcessorShortcutsOnTenTail;
         this.FProcessorShortcuts.OnNewActiveListSeventhEvening = this.ProcessorShortcutsOnSeventhEvening;
         this.FProcessorShortcuts.OnNewActiveListHappyTreasure = this.ProcessorShortcutsOnHappyTreasure;
         this.FProcessorShortcuts.OnNewActiveListRechargeRank = this.ProcessorshortcutsOnRechargeRank;
         this.FProcessorShortcuts.OnNewActiveListGroupBuying = this.ProcessorShortcutsOnGroupBuying;
         this.FProcessorShortcuts.OnNewActiveListRechargeExchange = this.ProcessorShortcutsOnRechargeExchange;
         this.FProcessorShortcuts.OnNewActiveListOrangeEquipment = this.ProcessorShortcutsOnOrangeEquipment;
         this.FProcessorShortcuts.OnNewActiveListMidAutumn = this.ProcessorShortcutsOnMidAutumn;
         this.FProcessorShortcuts.OnNewActiveListDiscount = this.ProcessorShortcutsOnDiscount;
         this.FProcessorShortcuts.OnNewActiveListRechargeGive = this.ProcessorShortcutsOnRechargeGive;
         this.FProcessorShortcuts.OnNewActiveListNationalDay = this.ProcessorShortcutsOnNationalDay;
         this.FProcessorShortcuts.OnNewActiveListTreasureBox = this.ProcessorShortcutsOnTreasureBox;
         this.FProcessorShortcuts.OnNewActiveListHallowmas = this.ProcessorShortcutsOnHallowmas;
         this.FProcessorShortcuts.OnNewActiveListInviteFriend = this.ProcessorShortcutsOnInviteFriend;
         this.FProcessorShortcuts.OnNewActiveListGuaGuaLe = this.ProcessorShortcutsOnGuaGuaLe;
         this.FProcessorShortcuts.OnNewActiveListWishTree = this.ProcessorShortcutsOnWishTree;
         this.FProcessorShortcuts.OnNewActiveListEverydaySale = this.ProcessorShortcutsOnEverydaySale;
         this.FProcessorShortcuts.OnNewActiveListVipTreasure = this.ProcessorShortcutsOnVipTreasure;
         this.FProcessorShortcuts.OnNewActiveListCrossServerSale = this.ProcessorShortcutsOnCrossServerSale;
         this.FProcessorShortcuts.OnNewActiveListNewYear = this.ProcessorShortcutsOnNewYear;
         this.FProcessorShortcuts.OnNewActiveListShowMore = this.ProcessorShortcutsOnShowMore;
         this.FProcessorShortcuts.OnNewActiveListHideMore = this.ProcessorShortcutsOnHideMore;
         this.FProcessorShortcuts.OnNewActiveListActivityA = this.ProcessorShortcutsOnActivityA;
         this.FProcessorShortcuts.OnNewActiveListActivityB = this.ProcessorShortcutsOnActivityB;
         this.FProcessorShortcuts.OnNewActiveListBlackMarket = this.ProcessorShortcutsOnBlackMarket;
         this.FProcessorShortcuts.OnNewActiveListNinjaMeeting = this.ProcessorShortcutsOnNinjaMeeting;
         this.FProcessorShortcuts.OnNewActiveListFortuneCat = this.ProcessorShortcutsOnFortuneCat;
         this.FProcessorShortcuts.OnNewActiveListTowerLottery = this.ProcessorShortcutsOnTowerLottery;
         this.FProcessorShortcuts.OnNewActiveListSingleTopUp = this.ProcessorShortcutsOnSingleTopUp;
         this.FProcessorShortcuts.OnNewActiveListMyActive = this.ProcessorShortcutsOnMyActive;
         this.FProcessorShortcuts.OnNewActiveListOneWorthThousand = this.ProcessorShortcutsOnOneWorthThousand;
         this.FProcessorShortcuts.OnNewActiveListPaymentWall = this.ProcessorShortcutsOnPaymentWall;
         this.FProcessorShortcuts.OnNewActiveListNinjaBank = this.ProcessorShortcutsOnNinjaBank;
         this.FProcessorShortcuts.OnNewActiveListFirstRecharge_New = this.ProcessorShortcutsOnFirstRecharge_New;
         this.FProcessorShortcuts.OnNewActiveListComeBack = this.ProcessorShortcutsOnComeBack;
         this.FProcessorShortcuts.OnNewActiveListDessertHouse = this.ProcessorShortcutsOnDessertHouse;
         this.FProcessorShortcuts.OnNewActiveListNewLottery = this.ProcessorShortcutsOnNewLottery;
         this.FProcessorShortcuts.OnNewActiveListDailyRecharge = this.ProcessorShortcutsOnDailyRecharge;
         this.FProcessorShortcuts.OnNewActiveListCloudBuy = this.ProcessorShortcutsOnCloudBuy;
         this.FProcessorShortcuts.OnNewActiveListFerrisWheel = this.ProcessorShortcutsOnFerrisWheel;
         this.FProcessorShortcuts.OnNewActiveListMarchConsume = this.ProcessorShortcutsOnMarchConsume;
         this.FProcessorShortcuts.OnNewActiveListCapsuleToys = this.ProcessorShortcutsOnCapsuleToys;
         this.FProcessorShortcuts.OnNewActiveListGoldDigger = this.ProcessorShortcutsOnGoldDigger;
         this.FProcessorShortcuts.OnNewActiveListPersiaTrader = this.ProcessorShortcutsOnPersiaTrader;
         this.FProcessorShortcuts.OnNewActiveListAncientTreasure = this.ProcessorShortcutsOnAncientTreasure;
         this.FProcessorShortcuts.OnNewActiveListCornucopia = this.ProcessorShortcutsOnCornucopia;
         this.FProcessorShortcuts.OnNewActiveListGoldTree = this.ProcessorShortcutsOnGoldTree;
         this.FProcessorShortcuts.OnNewActiveListAlchemyStudio = this.ProcessorShortcutsOnAlchemyStudio;
         this.FProcessorShortcuts.OnNewActiveListGodWelfare = this.ProcessorShortcutsOnGodWelfare;
         this.FProcessorShortcuts.OnNewActiveListIdolumFight = this.ProcessorShortcutsOnIdolumFight;
         this.FProcessorShortcuts.OnNewActiveListBejeweled = this.ProcessorShortcutsOnBejeweled;
         this.FProcessorShortcuts.OnNewActiveListExorcism = this.ProcessorShortcutsOnExorcism;
         this.FProcessorShortcuts.OnNewActiveListNinjaCrystal = this.ProcessorShortcutsOnNinjaCrystal;
         this.FProcessorShortcuts.OnNewActiveListBossTreasure = this.ProcessorShortcutsOnBossTreasure;
         this.FProcessorShortcuts.OnNewActiveListLoginGift = this.ProcessorShortcutsOnLoginGift;
         this.FProcessorShortcuts.OnNewActiveListDailyFirstRecharge = this.ProcessorShortcutsOnDailyFirstRecharge;
         this.FProcessorShortcuts.OnNewActiveListMoonFestival = this.ProcessorShortcutsOnMoonFestival;
         this.FProcessorShortcuts.OnNewActiveListNationDay2015 = this.ProcessorShortcutsOnNationDay2015;
         this.FProcessorShortcuts.OnNewActiveListHallowmasActive = this.ProcessorShortcutsOnHallowmasActive;
         this.FProcessorShortcuts.OnNewActiveListWanSheng = this.ProcessorShortcutsOnWanSheng;
         this.FProcessorShortcuts.OnNewActiveListThanksgivingDay = this.ProcessorShortcutsOnThanksgivingDay;
         this.FProcessorShortcuts.OnNewActiveListNov = this.ProcessorShortcutsOnNov;
         this.FProcessorShortcuts.OnNewActiveListChristmas2015 = this.ProcessorShortcutsOnChristmas2015;
         this.FProcessorShortcuts.OnNewActiveListJanActive2016 = this.ProcessorShortcutsOnJanActive2016;
         this.FProcessorShortcuts.OnNewActiveListSignGift = this.ProcessorShortcutsOnSignGift;
         this.FProcessorShortcuts.OnNewActiveListFateRoulette = this.ProcessorShortcutsOnFateRoulette;
         this.FProcessorShortcuts.OnNewActiveListWanSheng2 = this.ProcessorShortcutsOnWanSheng2;
         this.FProcessorShortcuts.OnNewActiveListNinjaFund = this.ProcessorShortcutsOnNinjaFund;
         this.FProcessorShortcuts.OnNewActiveListCatWomen = this.ProcessorShortcutsOnCatWomen;
         this.FProcessorShortcuts.OnNewActiveListLotteryMachine = this.ProcessorShortcutsOnLotteryMachine;
         this.FProcessorShortcuts.OnNewActiveListCreationAncestor = this.ProcessorShortcutsOnCreationAncestor;
         this.FProcessorShortcuts.OnNewActiveListBindEmail = this.ProcessorShortcutsOnBindEmail;
         this.FProcessorShortcuts.OnNewActiveListDouble11Mall = this.ProcessorShortcutsOnDouble11Mall;
         this.FProcessorShortcuts.OnNewActiveListLevelGifts = this.ProcessorShortcutsOnLevelGifts;
         this.FProcessorShortcuts.OnNewActiveListDayRechargeGift = this.ProcessorShortcutsOnDayRechargeGift;
         this.FProcessorShortcuts.OnActiveListThirdNinjiaVillage = this.ProcessorShortcutsOnNinjiaVillage;
         this.FProcessorShortcuts.OnNewActiveListChristmas = this.ProcessorShortcutsOnChristmas;
         this.FProcessorShortcuts.OnNewActiveListSpringFestival = this.ProcessorShortcutsOnSpringFestival;
         this.FProcessorShortcuts.OnNewActiveListValentineDay = this.ProcessorShortcutsOnValentineDay;
         this.FProcessorShortcuts.OnNewActiveListFightBoss = this.ProcessorShortcutsOnFightBoss;
         this.FProcessorShortcuts.OnNewActiveListBrazilCarnival = this.ProcessorShortcutsOnBrazilCarnival;
         this.FProcessorShortcuts.OnNewActiveListNinjaTreasure = this.ProcessorShortcutsOnNinjaTreasure;
         this.FProcessorShortcuts.OnNewActiveListMayActive = this.ProcessorShortcutsOnMayActive;
         this.FProcessorShortcuts.OnNewActiveListJuneActive = this.ProcessorShortcutsOnJuneActive;
         this.FProcessorShortcuts.OnNewActiveListJulyActive = this.ProcessorShortcutsOnJulyActive;
         this.FProcessorShortcuts.OnNewActiveListAugustActive = this.ProcessorShortcutsOnAugustActive;
         this.FProcessorShortcuts.OnNewActiveListSeptemberActive = this.ProcessorShortcutsOnSeptemberActive;
         this.FProcessorShortcuts.OnNewActiveListOctActive = this.ProcessorShortcutsOnOctActive;
         this.FProcessorShortcuts.OnNewActiveListNovActive = this.ProcessorShortcutsOnNovActive;
         this.FProcessorShortcuts.OnNewActiveListDecActive = this.ProcessorShortcutsOnDecActive;
         this.FProcessorShortcuts.OnNewActiveListJanActive = this.ProcessorShortcutsOnJanActive;
         this.FProcessorShortcuts.OnNewActiveListFebActive = this.ProcessorShortcutsOnFebActive;
         this.FProcessorShortcuts.OnNewActiveListMarchActive = this.ProcessorShortcutsOnMarchActive;
         this.FProcessorShortcuts.OnNewActiveListAprilActive = this.ProcessorShortcutsOnAprilActive;
         this.FProcessorShortcuts.OnNewActiveListMayActive2015 = this.ProcessorShortcutsOnMayActive2015;
         this.FProcessorShortcuts.OnNewActiveListNov2016 = this.ProcessorShortcutsOnNov2016;
         this.FProcessorShortcuts.OnNewActiveListWitchProving = this.ProcessorShortcutsOnWitchProving;
         this.FProcessorShortcuts.OnNewActiveListChristmas2016 = this.ProcessorShortcutsOnChristmas2016;
         this.FProcessorShortcuts.OnNewActiveListWorldCup = this.ProcessorShortcutsOnWorldCup;
         this.FProcessorShortcuts.OnNewActiveListNewSpring2018 = this.ProcessorShortcutsOnNewSpring2018;
         this.FProcessorShortcuts.OnNewActiveListSmelt = this.ProcessorShortcutsOnSmelt;
         this.FProcessorShortcuts.OnNewActiveListChristmasDay = this.ProcessorShortcutsOnChristmasDay;
         this.FProcessorShortcuts.OnNewActiveListLeadLevelGifts = this.ProcessorShortcutsOnLeadLevelGifts;
         this.FProcessorShortcuts.OnActiveListFirstRechageCashBack = this.ProcessorShortcutsOnFirstRechageCashBack;
         this.FProcessorShortcuts.OnActiveListFirstRecharge = this.ProcessorShortcutsOnFirstRecharge;
         this.FProcessorShortcuts.OnActiveListRecharge = this.ProcessorShortcutsOnRecharge;
         this.FProcessorShortcuts.OnActiveListWonderful = this.ProcessorShortcutsOnWonderfulActivity;
         this.FProcessorShortcuts.OnActiveListSecondaryFirstDayGiftBag = this.ProcessorShortcutsOnFirstDayGiftBag;
         this.FProcessorShortcuts.OnActiveListSecondaryOnLineGiftBag = this.ProcessorShortcutsOnOnLineGiftBag;
         this.FProcessorShortcuts.OnActiveListSecondaryGoldGiftBag = this.ProcessorShortcutsOnGoldGiftBag;
         this.FProcessorShortcuts.OnActiveListSecondary7DayGiftBag = this.ProcessorShortcutsOn7DayGiftBag;
         this.FProcessorShortcuts.OnActiveListSecondaryHFReward = this.ProcessorShortcutsOnHFRewardg;
         this.FProcessorShortcuts.OnActiveListSecondaryLevelGift = this.ProcessorShortcutsOnLevelGift;
         this.FProcessorShortcuts.OnActiveListSecondaryCollectGame = this.ProcessorShortcutsOnCollectGame;
         this.FProcessorShortcuts.OnEnterWorldMap = this.ProcessorShortcutsOnEnterWorldMap;
         this.FProcessorShortcuts.OnEnterCity = this.ProcessorsTurnBackBattleSceneNtf;
         this.FProcessorShortcuts.OnFriend = this.ProcessorShortcutsOnFriend;
         this.FProcessorShortcuts.OnMail = this.ProcessorShortcutsOnMail;
         this.FProcessorShortcuts.OnSwitchDisplay = this.ProcessorOnShowAndHideMainSceneRoles;
         this.FProcessorShortcuts.OnAutoBattle = this.ProcessorShortcutsOnAutoBattle;
         this.FProcessorShortcuts.OnZeroReq = this.ProcessorShortcutsOnZeroReq;
         this.FProcessorShortcuts.OnHeros = this.ProcessorShortcutsHerosOnClick;
         this.FProcessorShortcuts.OnGeneralStar = this.ProcessorShortcutsGeneralStarOnClick;
         this.FProcessorShortcuts.OnTacticalDeployment = this.ProcessorShortcutsTacticalDeploymentOnClick;
         this.FProcessorShortcuts.OnInheritPractice = this.ProcessorShortcutsInheritPracticeOnClick;
         this.FProcessorShortcuts.OnBackpack = this.ProcessorShortcutsBackpackOnClick;
         this.FProcessorShortcuts.OnTreasure = this.ProcessorShortcutsTreasureOnClick;
         this.FProcessorShortcuts.OnSummonPet = this.ProcessorShortcutsSummonPetOnClick;
         this.FProcessorShortcuts.OnStrengthen = this.ProcessorShortcutsStrengthenOnClick;
         this.FProcessorShortcuts.OnTongLing = this.ProcessorShortcutsTongLingOnClick;
         this.FProcessorShortcuts.OnOrganiZation = this.ProcessorShortcutsOrganiZationOnClick;
         this.FProcessorShortcuts.OnReturn = this.ProcessorsOnEnterTown;
         this.FProcessorShortcuts.OnHomeland = this.ProcessorShortcutsHomelandOnClick;
         this.FProcessorShortcuts.OnAdditionalTavern = this.ProcessorShortcutsTavernOnClick;
         this.FProcessorShortcuts.OnAdditionalJade = this.ProcessorShortcutsJadeOnClick;
         this.FProcessorShortcuts.OnAdditionalMakeEquip = this.ProcessorShortcutsMakeEquipOnClick;
         this.FProcessorShortcuts.OnAdditionalMakeEquipAdvanced = this.ProcessorShortcutsMakeEquipAdvancedOnClick;
         this.FProcessorShortcuts.OnAdditionalAccessoryIntensity = this.ProcessorShortcutsAccessoryIntensityOnClick;
         this.FProcessorShortcuts.OnQuest = this.ProcessorShortcutsOnQuestBtnClick;
         this.FProcessorQuest.QuestGuide = this.FProcessorShortcuts.WindowQuest;
         this.FProcessorShortcuts.OnConstantlyBigDipper = this.ProcessorShortcutsOnBigDipper;
         this.FProcessorShortcuts.OnConstantlyMentorship = this.ProcessorShortcutsOnMentorship;
         this.FProcessorShortcuts.ShowOtherHeroInfor = this.ProcessorOnShowHeroInfor;
         this.FProcessorShortcuts.RequestWhisper = this.ProcessorsOnRequestWhisper;
         this.FProcessorShortcuts.RequestAddFriend = this.ProcessorOnInterpersonalRelationshipsReq;
         this.FProcessorShortcuts.RequestSendMail = this.ProcessorOnOpenWriteMail;
      }
      
      protected function ConstructProcessorChat() : void
      {
         this.FProcessorLobbyOneLyErrorWindows = new TProcessorLobbyOneLyErrorWindows(this.FMountPointWindow,this.FParameters);
         this.FProcessorLobbyOneLyErrorWindows.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorLobbyOneLyErrorWindows.OnDialogMsg = this.ProcessorsOnEffectText;
         this.FProcessorChat = new TProcessorChat(this.FMountPointChat);
         this.FProcessorChat.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorChat.OnInquiryReq = this.ProcessorOnInquiryCharacterIDReq;
         this.FProcessorChat.OnMarquee = this.ProcessorOnMarquee;
         this.FProcessorChat.OnTyphon = this.ProcessorOnTyphon;
         this.FProcessorChat.OnInterpersonalRelationships = this.ProcessorOnInterpersonalRelationshipsReq;
         this.FProcessorChat.OnHackWarningResponse = this.ProcessorOnHackWarningResponse;
         this.FProcessorChat.OnShortcutHyperlinks = this.ProcessorShortcutHyperlinks;
         this.FProcessorChat.OnShowHeroInfor = this.ProcessorOnShowHeroInfor;
         this.FProcessorChat.OnShowInventoryInfor = this.ProcessorOnShowInventoryInfor;
         this.FProcessorChat.visible = false;
         this.FProcessorChat.OnShowHeroDescription = this.ProcessorOnShowHeroDescription;
         this.FProcessorChat.OnGmUp = this.ProcessorOnGmUp;
         this.FProcessorChat.ProcessorLobbyOneLyErrorWindows = this.FProcessorLobbyOneLyErrorWindows;
      }
      
      protected function ConstructProcessorLogicModule() : void
      {
         this.FProcessorCounter = new TProcessorCounter(this.FMountPointLogicModule);
         this.FProcessorCounter.Visible = false;
         this.FProcessorActivity = new TProcessorActivityData(this.FMountPointLogicModule,this.FParameters);
         this.FProcessorActivity.OnOpenActivityListStatusNotification = this.ProcessorOnOpenActivityListStatusNotification;
         this.FProcessorActivity.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorActivity.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorActivity.Visible = false;
         this.FProcessorPost = new TProcessorPost(this.FMountPointLogicModule,this.FParameters);
         this.FProcessorPost.OnPost = this.ProcessorOnPost;
         this.FProcessorPost.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorPost.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorPost.OnMarquee = this.ProcessorOnMarquee;
         this.FProcessorPost.Visible = false;
         this.FProcessorAutoHangUp = new TProcessorAutoHangUp(this.FMountPointLogicModule,this.FParameters);
         this.FProcessorAutoHangUp.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorAutoHangUp.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorAutoHangUp.OnAutoHangUpStatusRet = this.ProcessorOnAutoHangUpStatusRet;
         this.FProcessorAutoHangUp.Visible = false;
         this.FProcessorTitle = new TProcessorTitle(this.FMountPointLogicModule,this.FParameters);
         this.FProcessorTitle.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorTitle.OnDialogMsg = this.ProcessorOnDialogMsg;
         this.FProcessorTitle.OnUpdateTitleInfo = this.ProcessorOnUpdateTitleInfo;
         this.FProcessorTitle.OnEffectNewMail = this.ProcessorShortcutEffectNotification;
         this.FProcessorTitle.OnUpdateLittlePetInfo = this.ProcessorOnUpdateLittlePetInfo;
         this.FProcessorTitle.Visible = false;
      }
      
      protected function ConstructProcessorPopTips() : void
      {
         this.FProcessorPopTips = new TProcessorPopTips(this.FMountPointChat);
         this.FProcessorPopTips.OpenPlantWindowByIndex = this.ProcessorOnOpenModel;
      }
      
      protected function ConstructProcessorPopNarutoRoad() : void
      {
         this.FProcessorNarutoRoadTip = new TProcessorPopNarutoRoad(this.FMountPointChat);
         this.FProcessorNarutoRoadTip.OnOpenView = this.ProcessorShortcutsOnNarutoRoad;
      }
      
      protected function ConstructProcessorFightingCapacity() : void
      {
      }
      
      protected function ConstructProcessorFreshGuide() : void
      {
         this.FProcessorFreshGuide = new TProcessorFreshGuide(this.FMountPointFreshGuideNpc,this.FMountPointFreshGuideSearchWay,this.FMountPointFreshGuide,this.FMountPointFreshGuideAllUp,this.FParameters);
         this.FProcessorFreshGuide.visible = true;
         this.FProcessorFreshGuide.OnEffectText = this.ProcessorsOnEffectText;
         this.FProcessorFreshGuide.OnQueryShortcutCoordinate = this.ProcessorOnQueryShortcutCoordinate;
         this.FProcessorMainScene.SendFreshGuideNpc = this.FProcessorFreshGuide.SetRelationModule;
         this.FProcessorFreshGuide.SetRelationModule(this.FProcessorMainScene.LayerNpcDialog);
         this.FProcessorFreshGuide.SetRelationModule(this.FProcessorShortcuts.WindowQuest);
         this.FProcessorFreshGuide.SetRelationModule(this.FProcessorHeros.ProcessorWindowHeros);
         this.FProcessorFreshGuide.SetRelationModule(this.FProcessorTacticalDeployment.ProcessorWindowTacticalDeployment);
         this.FProcessorFreshGuide.SetRelationModule(this.FProcessorSmithy.ProcessorWindowSmithy);
         this.FProcessorFreshGuide.SetRelationModule(this.FProcessorPet.ProcessorWindowPetLevel);
         this.FProcessorFreshGuide.SetRelationModule(this.FProcessorGeneralStar.ProcessorWindowEsoteric);
         this.FProcessorFreshGuide.SetRelationModule(this.FProcessorShortcuts);
         this.FProcessorFreshGuide.SetRelationModule(this.FMountPointFreshGuideAllUp);
         this.FProcessorFreshGuide.SetRelationModule(this.FProcessorTalisman.ProcessorWindowTalisman);
         this.FProcessorFreshGuide.SetRelationModule(this.FProcessorKillHeros.ProcessorWindowKillHeros);
         this.FProcessorFreshGuide.SetRelationModule(this.FProcessorDailySign.ProcessorWindowDailySign);
         this.FProcessorFreshGuide.SetRelationModule(this.FProcessorTavern);
         this.FProcessorFreshGuide.SetRelationModule(this.FProcessorArena);
         this.FProcessorFreshGuide.SetRelationModule(this.FProcessorBigDipper.ProcessorWindowBigDipper);
         this.FProcessorFreshGuide.SetRelationModule(this.FProcessorTreasureMap);
         this.FProcessorFreshGuide.SetRelationModule(this.FProcessorSuperHero.WindowSuperHero);
         this.FProcessorFreshGuide.SetRelationModule(this.FProcessorDailyQuest.ProcessorWindowTask);
         this.FProcessorFreshGuide.SetRelationModule(this.FProcessorCopyHero.ProcessorWindowCopyClassroom);
         this.FProcessorFreshGuide.SetRelationModule(this.FProcessorRamen.ProcessorWindowRamen);
         this.FProcessorFreshGuide.AutoSetDeployment = this.FProcessorTacticalDeployment.AutoSetDeployment;
         this.FProcessorFreshGuide.AutoSearchWay = this.FProcessorQuest.ManticSearchWay;
         this.FProcessorQuest.FreshGuideCompleteQuest = this.FProcessorFreshGuide.FreshGuideCompleteQuest;
         SLogicsCore.ProcessorFreshGuide = this.FProcessorFreshGuide;
         this.FProcessorFreshGuide.OnActivatingChannel = this.ProcessorOnActivatingChannel;
      }
      
      protected function ConstructProcessorsOverview() : void
      {
         this.FProcessorInspector = new TProcessorInspector(this.FMountPointOverview,this.FParameters);
         this.FProcessorInspector.OnEffectTransition = this.ProcessorOnEffectTransition;
         this.FProcessorInspector.OnChatAnnouncement = this.ProcessorOnChatAnnouncement;
         this.FProcessorInspector.OnAntiAddiction = this.ProcessorOnAntiAddiction;
         this.FProcessorInspector.OnCheckKingwarIconEffect = this.ProcessorOnCheckKingwarIconEffect;
         this.FProcessorInspector.Visible = true;
         this.FProcessorUnlock = new TProcessorUnlock(this.FMountPointOverview,this.FParameters);
         this.FProcessorUnlock.OnUpdateShortcutsState = this.ProcessorOnUpdateShortcutsState;
         this.FProcessorUnlock.OnUnlockNotification = this.ProcessorOnUnlockNotification;
         this.FProcessorUnlock.OnUnlockedNotification = this.ProcessorOnUnlockedNotification;
         this.FProcessorUnlock.Visible = false;
         this.FProcessorModuleLoader = new TProcessorModuleLoader(this.FMountPointOverview,this.FParameters);
         this.FProcessorModuleLoader.Visible = false;
      }
      
      protected function ConstructBarrier() : void
      {
         this.FBarrier = new TUIBarrier(this.FMountPointBarrier);
         this.FBarrier.Width = CONST_COMMON.STAGE_Width;
         this.FBarrier.Height = CONST_COMMON.STAGE_Height;
         this.FBarrier.Color = 2147483648;
         this.FBarrier.Visible = false;
         this.FBarrier.Init();
      }
      
      protected function ProcessorPlateSwitch(param1:TProcessorLobbyPlate, param2:ByteArray = null) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:TProcessorLobbyPlate = null;
         if(this.FProcessorPlateActive != null)
         {
            this.FProcessorPlateActive.Unmount();
         }
         _loc3_ = int(this.FProcessorsPlate.length);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = this.FProcessorsPlate[_loc4_];
            if(param1 == _loc5_)
            {
               _loc5_.visible = true;
            }
            else
            {
               _loc5_.visible = false;
            }
            _loc4_++;
         }
         if(param1 == null)
         {
            this.FShortcutAvatarModes.ShortcutModesReset(TLobbyShortcutMode.SHORTCUTMODE_Hidden);
            this.FShortcutActivityModes.ShortcutModesReset(TLobbyShortcutMode.SHORTCUTMODE_Hidden);
            this.FShortcutActiveSpecialModes.ShortcutModesReset(TLobbyShortcutMode.SHORTCUTMODE_Hidden);
            this.FShortcutFunctionModes.ShortcutModesReset(TLobbyShortcutMode.SHORTCUTMODE_Hidden);
            this.FShortcutMapModes.ShortcutModesReset(TLobbyShortcutMode.SHORTCUTMODE_Hidden);
            this.FShortcutQuestGuideModes.ShortcutModesReset(TLobbyShortcutMode.SHORTCUTMODE_Hidden);
            this.FShortcuConstantlyModes.ShortcutModesReset(TLobbyShortcutMode.SHORTCUTMODE_Hidden);
         }
         else
         {
            param1.ShortcutModesSetup(this.FShortcutAvatarModes);
            param1.ShortcutModesSetup(this.FShortcutActivityModes);
            param1.ShortcutModesSetup(this.FShortcutActiveSpecialModes);
            param1.ShortcutModesSetup(this.FShortcutFunctionModes);
            param1.ShortcutModesSetup(this.FShortcutMapModes);
            param1.ShortcutModesSetup(this.FShortcutQuestGuideModes);
            param1.ShortcutModesSetup(this.FShortcuConstantlyModes);
         }
         this.FProcessorShortcuts.ShortcutsSetup(this.FShortcutAvatarModes);
         this.FProcessorShortcuts.ShortcutsSetup(this.FShortcutActivityModes);
         this.FProcessorShortcuts.ShortcutsSetup(this.FShortcutActiveSpecialModes);
         this.FProcessorShortcuts.ShortcutsSetup(this.FShortcutFunctionModes);
         this.FProcessorShortcuts.ShortcutsSetup(this.FShortcutMapModes);
         this.FProcessorShortcuts.ShortcutsSetup(this.FShortcutQuestGuideModes);
         this.FProcessorShortcuts.ShortcutsSetup(this.FShortcuConstantlyModes);
         this.FProcessorPlateActive = param1;
         if(param1 != null)
         {
            param1.Mount(param2);
            SLogicsCore.Character.CurModuleID = param1.ModuleID;
            FAffairGenerator.Generate(AFFAIRID_TimingWaitBattleActive);
            FAffairGenerator.Generate(AFFAIRID_ChatOptionsSetup);
            FAffairGenerator.Generate(AFFAIRID_ChatOptionsApply);
            FAffairGenerator.Generate(AFFAIRID_GameStateExternalize);
         }
      }
      
      protected function ProcessorWindowsSwitch(param1:TProcessorLobbyWindows, param2:ByteArray = null) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:TProcessorLobbyWindows = null;
         if(this.FProcessorWindowsActive != null)
         {
            this.FProcessorWindowsActive.Unmount();
         }
         _loc3_ = int(this.FProcessorsWindows.length);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = this.FProcessorsWindows[_loc4_];
            if(param1 == _loc5_)
            {
               _loc5_.visible = true;
            }
            else
            {
               _loc5_.visible = false;
            }
            _loc4_++;
         }
         if(param1 != null)
         {
            this.FProcessorMainScene.CloseNpcDialog();
            param1.Mount(param2);
            this.FParameters.ActuatorBarrier.Actuate(param1);
            SLogicsCore.Character.CurModuleID = param1.ModuleID;
         }
         if(this.FProcessorWindowsActive != null)
         {
            this.FParameters.ActuatorBarrier.Deactuate(this.FProcessorWindowsActive);
         }
         this.FProcessorWindowsActive = param1;
      }
      
      protected function BattleQueryActive() : Boolean
      {
         this.FQueryBoolean.Value = false;
         if(this.FOnQueryBattleActive != null)
         {
            this.FOnQueryBattleActive(this,this.FQueryBoolean);
         }
         return this.FQueryBoolean.Value;
      }
      
      protected function BattleQueryLoading() : Boolean
      {
         this.FQueryBoolean.Value = false;
         if(this.FOnQueryBattleLoading != null)
         {
            this.FOnQueryBattleLoading(this,this.FQueryBoolean);
         }
         return this.FQueryBoolean.Value;
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_KickErrorCodeRet,this.PacketPerform_SC_KickErrorCode);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Enter_Town,this.PacketPerform_SC_Enter_Town);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Enter_WorldMap,this.PacketPerform_SC_Enter_WorldMap);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Enter_Hurdle,this.PacketPerform_SC_Enter_Hurdle);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Enter_KillHeros,this.PacketPerform_SC_Enter_KillHeros);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Enter_Tavern,this.PacketPerform_SC_Enter_Tavern);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Enter_Arena,this.PacketPerform_SC_Enter_Arena);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Enter_TreasureMap,this.PacketPerform_SC_Enter_TreasureMap);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Enter_CityDefend,this.PacketPerform_SC_Enter_CityDefend);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Enter_OrganizationWar,this.PacketPerform_SC_Enter_OrganizationalWar);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Enter_FightPet,this.PacketPerform_SC_Enter_FightPet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Enter_TraitorAttack,this.PacketPerform_SC_Enter_TraitorAttack);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Enter_SevenKing,this.PacketPerform_SC_Enter_SevenKing);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Enter_OrganizeBossStage,this.PacketPerform_SC_Enter_FightPetCopy);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_BATTLE_Base,CONST_NETWORK.PACKETID_SC_BATTLE_End,this.PacketPerform_ProcessorBattle);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_CHAT_Base,CONST_NETWORK.PACKETID_SC_CHAT_End,this.PacketPerform_ProcessorChat);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_LOBBY_ACCOUNT_Base,CONST_NETWORK.PACKETID_SC_LOBBY_ACCOUNT_End,this.PacketPerform_ProcessorAccount);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_LOBBY_TOWN_Base,CONST_NETWORK.PACKETID_SC_LOBBY_TOWN_End,this.PacketPerform_SC_SceneRoleContorl);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_LOBBY_WORLDMAP_Base,CONST_NETWORK.PACKETID_SC_LOBBY_WORLDMAP_End,this.PacketPerform_ProcessorWorldMap);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_LOBBY_HURDLE_Base,CONST_NETWORK.PACKETID_SC_LOBBY_HURDLE_End,this.PacketPerform_ProcessorHurdle);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_Arena_Base,CONST_NETWORK.PACKETID_SC_Arena_End,this.PacketPerform_ProcessorArena);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_TreasureMap_Base,CONST_NETWORK.PACKETID_SC_TreasureMap_End,this.PacketPerform_ProcessorTreasureMap);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_TACTICALDEPLOYMENT_Base,CONST_NETWORK.PACKETID_SC_TACTICALDEPLOYMENT_End,this.PacketPerform_ProcessorTacticalDeployment);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_JADE_Base,CONST_NETWORK.PACKETID_SC_JADE_End,this.PacketPerform_ProcessorJade);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_GENERALSTAR_Base,CONST_NETWORK.PACKETID_SC_GENERALSTAR_End,this.PacketPerform_ProcessorGeneralStar);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_Task_Base,CONST_NETWORK.PACKETID_SC_Task_End,this.PacketPerform_ProcessorTask);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_Smithy_Base,CONST_NETWORK.PACKETID_SC_Smithy_End,this.PacketPerform_ProcessorSmithy);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_LOBBY_MILITARYRANK_Base,CONST_NETWORK.PACKETID_SC_MILITARYRANK_End,this.PacketPerform_ProcessorMilitary);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_BIGDIPPER_Base,CONST_NETWORK.PACKETID_SC_BIGDIPPER_End,this.PacketPerform_ProcessorBigDipper);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_HeroSLevel_Base,CONST_NETWORK.PACKETID_SC_HeroSLevel_End,this.PacketPerform_ProcessorHeroSLevel);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_LOBBY_KILLHEROS_Base,CONST_NETWORK.PACKETID_SC_LOBBY_KILLHEROS_End,this.PacketPerform_ProcessorKillHeros);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_LOBBY_BACKPACK_Base,CONST_NETWORK.PACKETID_SC_LOBBY_BACKPACK_End,this.PacketPerform_ProcessorBackpack);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_LOBBY_HEROS_Base,CONST_NETWORK.PACKETID_SC_LOBBY_HEROS_End,this.PacketPerform_ProcessorHeros);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_Tavern_Base,CONST_NETWORK.PACKETID_SC_Tavern_End,this.PacketPerform_ProcessorTavern);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_Talisman_Base,CONST_NETWORK.PACKETID_SC_Talisman_End,this.PacketPerform_ProcessorTalisman);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_MAIL_Base,CONST_NETWORK.PACKETID_SC_MAIL_End,this.PacketPerform_ProcessorMail);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Equip_Make,this.PacketPerform_ProcessorEquipMake);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Equip_Advanced,this.PacketPerform_ProcessorEquipAdvanced);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_Pet_Base,CONST_NETWORK.PACKETID_SC_Pet_End,this.PacketPerform_ProcessorPet);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_LOBBY_FRIEND_Base,CONST_NETWORK.PACKETID_SC_LOBBY_FRIEND_End,this.PacketPerform_ProcessorFriend);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_Mall_Base,CONST_NETWORK.PACKETID_SC_Mall_End,this.PacketPerform_ProcessorMall);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_Sign_Base,CONST_NETWORK.PACKETID_SC_Sign_End,this.PacketPerform_ProcessorSign);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_DailyTask_Base,CONST_NETWORK.PACKETID_SC_DailyTask_End,this.PacketPerform_ProcessorDailyTask);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_Ramen_Base,CONST_NETWORK.PACKETID_SC_Ramen_End,this.PacketPerform_ProcessorRamen);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_INSPECTOR_Base,CONST_NETWORK.PACKETID_SC_INSPECTOR_End,this.PacketPerform_ProcessorInspector);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_VIP_Base,CONST_NETWORK.PACKETID_SC_VIP_End,this.PacketPerform_ProcessorVIP);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_Organization_Base,CONST_NETWORK.PACKETID_SC_Organization_End,this.PacketPerform_ProcessorOrganization);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_CopyHero_Base,CONST_NETWORK.PACKETID_SC_CopyHero_End,this.PacketPerform_ProcessorCopyHero);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_COUNTER_Base,CONST_NETWORK.PACKETID_SC_COUNTER_End,this.PacketPerform_ProcessorLimit);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Activity_ReceiveAwardsRet,this.PacketPerform_Activity);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Activity_PowerRankRet,this.PacketPerform_ActivityInner);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Activity_GlobelDataRet,this.PacketPerform_ActivityInner);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Activity_ArenaRet,this.PacketPerform_ActivityInner);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Activity_PowerRet,this.PacketPerform_ActivityInner);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Activity_RechageRankRet,this.PacketPerform_ActivityInner);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_Activity_LoadActivityInfoRet,CONST_NETWORK.PACKETID_SC_ACTIVITY_End,this.PacketPerform_Activity);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_Post_Base,CONST_NETWORK.PACKETID_SC_Post_End,this.PacketPerform_ProcessorPost);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_CDK_Base,CONST_NETWORK.PACKETID_SC_CDK_End,this.PacketPerform_ProcessorCDK);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_OrganizationWar_Base,CONST_NETWORK.PACKETID_SC_OrganizationWar_End,this.PacketPerform_ProcessorOrganizationalWar);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_CityDefend_Base,CONST_NETWORK.PACKETID_SC_CityDefend_End,this.PacketPerform_ProcessorCityDefend);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_FightPet_Base,CONST_NETWORK.PACKETID_SC_FightPet_End,this.PacketPerform_ProcessorFightPet);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_FightingShow_Base,CONST_NETWORK.PACKETID_SC_FightingShow_SingleFightRankRet,this.PacketPerform_ProcessorFightingShow);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_FightingShow_SinglePetRankRet,CONST_NETWORK.PACKETID_SC_FightingShow_End,this.PacketPerform_ActivityInner);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_NarutoRoad_Base,CONST_NETWORK.PACKETID_SC_NarutoRoad_End,this.PacketPerform_ProcessorNarutoRoad);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_Lottery_Base,CONST_NETWORK.PACKETID_SC_Lottery_End,this.PacketPerform_ProcessorLottery);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_SystemActivity_Base,CONST_NETWORK.PACKETID_SC_SystemActivity_End,this.PacketPerform_ProcessorSystemActivity);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_DragonBoat_Base,CONST_NETWORK.PACKETID_SC_DragonBoat_End,this.PacketPerform_ProcessorCommonRecharge);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_TraitorAttack_Base,CONST_NETWORK.PACKETID_SC_TraitorAttack_End,this.PacketPerform_ProcessorTraitorAttack);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_Mentorship_Base,CONST_NETWORK.PACKETID_SC_Mentorship_End,this.PacketPerform_ProcessorMentorship);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_FrogWallet_Base,CONST_NETWORK.PACKETID_SC_FrogWallet_End,this.PacketPerform_ProcessorFrogWallet);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_FreshGuide_Base,CONST_NETWORK.PACKETID_SC_FreshGuide_End,this.PacketPerform_ProcessorFreshGuide);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_NijiaStar_Base,CONST_NETWORK.PACKETID_SC_NijiaStar_End,this.PacketPerform_ProcessorNijiastar);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_VIPShop_Base,CONST_NETWORK.PACKETID_SC_VIPShop_End,this.PacketPerform_ProcessorVipShop);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_SevenKing_Base,CONST_NETWORK.PACKETID_SC_SevenKing_End,this.PacketPerform_ProcessorSevenKing);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_Dice_Base,CONST_NETWORK.PACKETID_SC_Dice_End,this.PacketPerform_ProcessorDice);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_Automate_Base,CONST_NETWORK.PACKETID_SC_Automate_End,this.PacketPerform_ProcessorAutoHangUp);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Common_AddHeroNum_Ret,this.PacketPerform_ProcessorHeros);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Common_TavernChangeSoul_Ret,this.PacketPerform_ProcessorTavern);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Common_BuyGodEquip_Ret,this.PacketPerform_ProcessorGodEquip);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_ConsumeRank_Base,CONST_NETWORK.PACKETID_SC_ConsumeRank_End,this.PacketPerform_ProcessorConsumeRank);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_TenTail_Base,CONST_NETWORK.PACKETID_SC_TenTail_End,this.PacketPerform_ProcessorTenTail);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_VIPFreeBuy_Base,CONST_NETWORK.PACKETID_SC_VIPFreeBuy_End,this.PacketPerform_ProcessorVIPFreeBuy);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_SeventhEvening_Base,CONST_NETWORK.PACKETID_SC_SeventhEvening_End,this.PacketPerform_ProcessorSeventhEvening);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_BaseActivity_Base,CONST_NETWORK.PACKETID_SC_BaseActivity_End,this.PacketPerform_ProcessorActivityManager);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_RechargeRank_Base,CONST_NETWORK.PACKETID_SC_RechargeRank_End,this.PacketPerform_ProcessorRechargeRank);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_CrossServerWar_Base,CONST_NETWORK.PACKETID_SC_CrossServerWar_End,this.PacketPerform_ProcessorCrossServerWar);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_Title_Base,CONST_NETWORK.PACKETID_SC_Title_End,this.PacketPerform_ProcessorTitle);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_Magic_Base,CONST_NETWORK.PACKETID_SC_Magic_End,this.PacketPerform_ProcessorMagic);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_Tower_Base,CONST_NETWORK.PACKETID_SC_Tower_End,this.PacketPerform_ProcessorTower);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_DailyWelfare_Base,CONST_NETWORK.PACKETID_SC_DailyWelfare_End,this.PacketPerform_ProcessorDailyWelfare);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_DragonHall_Base,CONST_NETWORK.PACKETID_SC_DragonHall_End,this.PacketPerform_ProcessorPalace);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_NinJaPractice_Base,CONST_NETWORK.PACKETID_SC_JinJaPractice_End,this.PacketPerform_ProcessorJinJaPractice);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_NinjaReincarnation,CONST_NETWORK.PACKETID_SC_NinjaReincarnation_end,this.PacketPerform_ProcessorJinJaPractice);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_TongLing_Base,CONST_NETWORK.PACKETID_SC_TongLing_End,this.PacketPerform_ProcessorTongLing);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_SantaClaus_Base,CONST_NETWORK.PACKETID_SC_SantaClaus_End,this.PacketPerform_ProcessorSantaClaus);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_UpdateList_Base,CONST_NETWORK.PACKETID_SC_UpdateList_End,this.PacketPerform_ProcessorUpdateList);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_BugList_Base,CONST_NETWORK.PACKETID_SC_BugList_End,this.PacketPerform_ProcessorBugList);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_AnimalSeall_Base,CONST_NETWORK.PACKETID_SC_AnimalSeall_End,this.PackPerform_ProcessorAnimal);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_TopOrganization_Base,CONST_NETWORK.PACKETID_SC_TopOrganization_End,this.PacketPerform_ProcessorTopOrganization);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_GroupBattle_Base,CONST_NETWORK.PACKETID_SC_GroupBattle_End,this.PacketPerform_ProcessorGroupBattle);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_Accessory_Base,CONST_NETWORK.PACKETID_SC_Accessory_End,this.PacketPerform_ProcessorWindowAccessory);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_BloodSoulPurgatory,CONST_NETWORK.PACKETID_SC_BloodSoulPurgatory_end,this.PacketPerform_ProcessorWindowBloodSoulPurgatoryMain);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_SixFairyMan,CONST_NETWORK.PACKETID_SC_SixFairyMan_end,this.PacketPerform_TProcessorWindowSixFairyMain);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_TopTeam_Base,CONST_NETWORK.PACKETID_SC_TopTeam_end,this.PacketPerform_ProcessorTopTeam);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_RebirthRealm,CONST_NETWORK.PACKETID_SC_RebirthRealm_end,this.PacketPerform_TProcessorWindowRebirthRealmAllManager);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_NijiaMystic_Base,CONST_NETWORK.PACKETID_SC_NijiaMystic_End,this.PacketPerform_ProcessorWindowNijiaMystic);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_NarutoHelper_Base,CONST_NETWORK.PACKETID_SC_NarutoHelper_End,this.PacketPerform_ProcessorNarutoHelper);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_Prerogative_Base,CONST_NETWORK.PACKETID_SC_Prerogative_End,this.PacketPerform_ProcessorPrerogative);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_NinjaRelation_Base,CONST_NETWORK.PACKETID_SC_NinjaRelation_End,this.PacketPerform_ProcessorNinjaRelation);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_NinjaHostel_Base,CONST_NETWORK.PACKETID_SC_NinjaHostel_End,this.PacketPerform_ProcessorNinjaHostel);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_BaiDuMM_Base,CONST_NETWORK.PACKETID_SC_BaiDuMM_End,this.PacketPerform_ProcessorBaiDuMM);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_BloodFete_Base,CONST_NETWORK.PACKETID_SC_BloodFete_End,this.PacketPerform_ProcessorWindowBloodFeteMainManageClass);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_OhtsutsukiKaguya_Base,CONST_NETWORK.PACKETID_SC_OhtsutsukiKaguya_End,this.PacketPerform_OhtsutsukiKaguya);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_NewMall_Base,CONST_NETWORK.PACKETID_SC_NewMall_End,this.PacketPerform_NewMall);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_TransmigrationTrial_Base,CONST_NETWORK.PACKETID_SC_TransmigrationTrial_End,this.PacketPerform_TransmigrationTrial);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_Taboo_Base,CONST_NETWORK.PACKETID_S2C_Taboo_End,this.PacketPerform_Taboo);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_VK__Base,CONST_NETWORK.PACKETID_S2C_VK_End,this.PacketPerform_ProcessorVK);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_Awaken_Base,CONST_NETWORK.PACKETID_S2C_Awaken_End,this.PacketPerform_WindowManAwaken);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_EightDoor_Base,CONST_NETWORK.PACKETID_S2C_EightDoor_End,this.PacketPerform_EightDoor);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_TransmigrationAccessory_Base,CONST_NETWORK.PACKETID_SC_TransmigrationAccessory_End,this.PacketPerform_TransmigrationAccessory);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_TheWorldTree_Base,CONST_NETWORK.PACKETID_S2C_World_Tree_End,this.PacketPerform_ProcessorWindowTheWorldTree);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_Undertown_Base,CONST_NETWORK.PACKETID_S2C_Dungeons_End,this.PacketPerform_ProcessorWindowUndertown);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_OnLineLiBao_Base,CONST_NETWORK.PACKETID_S2C_OnLineLiBao_End,this.PacketPerform_ProcessorOnLineLiBao);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_ZhenAoYi_Base,CONST_NETWORK.PACKETID_S2C_ZhenAoYi_End,this.PacketPerform_ProcessorZhenAoYi);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_DaShi_Base,CONST_NETWORK.PACKETID_S2C_DaShi_End,this.PacketPerform_ProcessorMasterRoadOld);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_ShenQi_Base,CONST_NETWORK.PACKETID_S2C_ShenQi_End,this.PacketPerform_ProcessorLostShenQi);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_Wing_Base,CONST_NETWORK.PACKETID_SC_Wing_End,this.PacketPerform_ProcessorWing);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_Illustrated_Base,CONST_NETWORK.PACKETID_SC_Illustrated_End,this.PacketPerform_ProcessorIllustrated);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_Married_Base,CONST_NETWORK.PACKETID_SC_Married_End,this.PacketPerform_ProcessorMarried);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_COMMON_Base,CONST_NETWORK.PACKETID_SC_COMMON_End,this.PacketPerform_ProcessorCommon);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_AddSoul_Base,CONST_NETWORK.PACKETID_SC_AddSoul_End,this.PacketPerform_ProcessorAddSoul);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_MasterRoad_Base,CONST_NETWORK.PACKETID_SC_MasterRoad_End,this.PacketPerform_ProcessorMasterRoad);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_Challenge_Base,CONST_NETWORK.PACKETID_SC_Challenge_End,this.PacketPerform_ProcessorChallenge);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_SpeicalJade_Base,CONST_NETWORK.PACKETID_SC_SpecialJade_End,this.PacketPerform_ProcessorSpeicalJade);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Mail_Ret,this.PacketPerform_ProcessorBindEmail);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_Plane_Base,CONST_NETWORK.PACKETID_SC_Plane_End,this.PacketPerform_ProcessorAlien);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_NinjaAwake_Ret,this.PacketPerform_ProcessorNinjaAwake);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_AwakeSkill_Ret,this.PacketPerform_ProcessorAwakeSkill);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_CrossRank_Ret,this.PacketPerform_ProcessorCrossRank);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_CrossUser_Ret,this.PacketPerform_ProcessorCrossUser);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_CrossFight_Ret,this.PacketPerform_ProcessorCrossFight);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_KingWar_Base,CONST_NETWORK.PACKETID_SC_KingWar_End,this.Packetperform_ProcessorKingwar);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_Rune_Base,CONST_NETWORK.PACKETID_SC_Rune_End,this.PacketPerform_ProcessorMedal);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_InviteCode_Base,CONST_NETWORK.PACKETID_SC_InviteCode_End,this.PacketPerform_ProcessorInviteCode);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_Elements_Base,CONST_NETWORK.PACKETID_SC_Elements_End,this.PacketPerform_ProcessorWuxing);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_Warehouse_Base,CONST_NETWORK.PACKETID_SC_Warehouse_End,this.PacketPerform_ProcessorWarehouse);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_Discord_Base,CONST_NETWORK.PACKETID_SC_Discord_End,this.PacketPerform_ProcessorDiscord);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_GlobalBattle_Base,CONST_NETWORK.PACKETID_SC_GlobalBattle_End,this.PacketPerform_ProcessorGlobalBattle);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_NewShop_Base,CONST_NETWORK.PACKETID_SC_NewShop_End,this.PacketPerform_ProcessorShop);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_ConsumeVip_Base,CONST_NETWORK.PACKETID_SC_ConsumeVip_End,this.PacketPerform_ProcessorConsumeVip);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_Emblem_Base,CONST_NETWORK.PACKETID_SC_Emblem_End,this.PacketPerform_ProcessorEmblem);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_WorldMatch_Base,CONST_NETWORK.PACKETID_SC_WorldMatch_End,this.PacketPerform_ProcessorWorldMatch);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_ChristmasDay_Base,CONST_NETWORK.PACKETID_SC_ChristmasDay_End,this.PacketPerform_ProcessorChristmasDay);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_SummonBattle_Base,CONST_NETWORK.PACKETID_SC_SummonBattle_End,this.PacketPerform_ProcessorSummonBattle);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_NinjaTalent_Base,CONST_NETWORK.PACKETID_SC_NinjaTalent_End,this.PacketPerform_ProcessorNinjaTalent);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_ChallengeCamp_Base,CONST_NETWORK.PACKETID_SC_ChallengeCamp_End,this.PacketPerform_ProcessorChallengeCamp);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_LevelGifts_Base,CONST_NETWORK.PACKETID_SC_LevelGifts_End,this.PacketPerform_ProcessorLevelGifts);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_WorldMatchStreak_Base,CONST_NETWORK.PACKETID_SC_WorldMatchStreak_End,this.PacketPerform_ProcessorWorldMatchStreak);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_GlobalBoss_Base,CONST_NETWORK.PACKETID_SC_GlobalBoss_End,this.PacketPerform_ProcessorGlobalBoss);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_DayRechargeGift_Base,CONST_NETWORK.PACKETID_SC_DayRechargeGift_End,this.PacketPerform_ProcessorDayRechargeGift);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_Recruit_Base,CONST_NETWORK.PACKETID_SC_Recruit_End,this.PacketPerform_ProcessorRecruit);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_Slave_Base,CONST_NETWORK.PACKETID_SC_Slave_End,this.PacketPerform_ProcessorSalve);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_RefreshTalent_Base,CONST_NETWORK.PACKETID_SC_RefreshTalent_End,this.PacketPerform_ProcessorRefreshTalent);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_LeadLevelGifts_Base,CONST_NETWORK.PACKETID_SC_LeadLevelGifts_End,this.PacketPerform_ProcessorLeadLevelGifts);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_NewMallRefrese_Ret,this.PacketPerform_NewMall);
      }
      
      protected function PacketPerform_SC_KickErrorCode(param1:TPacket) : void
      {
         var RetCode:uint = 0;
         var Data:ByteArray = null;
         var Strings:TBins = null;
         var StrErrorCode:TErrorCode = null;
         var Text:String = null;
         var WindowApprisalOnOK:Function = null;
         var Packet:TPacket = param1;
         WindowApprisalOnOK = function(param1:Object):void
         {
            SExternalCore.ReloadGame();
         };
         Data = Packet.Data;
         RetCode = Data.readUnsignedInt();
         Strings = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_ErrorCode);
         if(Strings != null)
         {
            StrErrorCode = Strings.GetDatebaseByIdentifier(RetCode) as TErrorCode;
            if(StrErrorCode != null)
            {
               Text = StrErrorCode.Desc;
            }
         }
         Text = "/n" + STRING_COMMON.COMMON_DROPPED;
         this.FProcessorDialogMsg.ClickFun = WindowApprisalOnOK;
         this.ProcessorOnDialogMsg(this,Text);
         SLogicsCore.IsKicked = true;
      }
      
      protected function PacketPerform_ProcessorAccount(param1:TPacket) : void
      {
         this.FProcessorAccount.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorTown(param1:TPacket) : void
      {
         this.FProcessorMainScene.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorWorldMap(param1:TPacket) : void
      {
         this.FProcessorWorldMap.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorHurdle(param1:TPacket) : void
      {
         this.FProcessorBattleScene.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorKillHeros(param1:TPacket) : void
      {
         this.FProcessorKillHeros.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorArena(param1:TPacket) : void
      {
         this.FProcessorArena.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorTreasureMap(param1:TPacket) : void
      {
         this.FProcessorTreasureMap.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorHeroSLevel(param1:TPacket) : void
      {
         this.FProcessorSuperHero.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorGeneralStar(param1:TPacket) : void
      {
         this.FProcessorGeneralStar.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorTask(param1:TPacket) : void
      {
         this.FProcessorQuest.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorSmithy(param1:TPacket) : void
      {
         this.FProcessorSmithy.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorMilitary(param1:TPacket) : void
      {
         this.FProcessorProtagonist.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorBigDipper(param1:TPacket) : void
      {
         this.FProcessorBigDipper.PacketProcess(param1);
      }
      
      protected function PacketPerform_ActivityInner(param1:TPacket) : void
      {
         this.FProcessorWonderfulActivity.PacketProcess(param1);
      }
      
      protected function PacketPerform_Activity(param1:TPacket) : void
      {
         this.FProcessorActivity.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorPost(param1:TPacket) : void
      {
         this.FProcessorPost.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorCDK(param1:TPacket) : void
      {
         this.FProcessorCDK.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorFightPet(param1:TPacket) : void
      {
         this.FProcessorFightPet.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorFightingShow(param1:TPacket) : void
      {
         this.FProcessorShinobidoPractise.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorNarutoRoad(param1:TPacket) : void
      {
         this.FProcessorNarutoRoad.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorLottery(param1:TPacket) : void
      {
         this.FProcessorLottery.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorSystemActivity(param1:TPacket) : void
      {
         this.FProcessorSystemActivity.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorOrganizationalWar(param1:TPacket) : void
      {
         this.FOrganizationalWar.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorCityDefend(param1:TPacket) : void
      {
         this.FProcessorCityDefend.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorDragonBoat(param1:TPacket) : void
      {
         this.FProcessorDragonBoat.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorTraitorAttack(param1:TPacket) : void
      {
         this.FProcessorTraitorAttack.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorMentorship(param1:TPacket) : void
      {
         this.FProcessorMentorship.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorFrogWallet(param1:TPacket) : void
      {
         this.FProcessorFrogWallet.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorFreshGuide(param1:TPacket) : void
      {
         this.FProcessorFreshGuide.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorNijiastar(param1:TPacket) : void
      {
         this.FProcessorNijiaStar.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorVipShop(param1:TPacket) : void
      {
         this.FProcessorVipShop.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorSevenKing(param1:TPacket) : void
      {
         this.FProcessorSevenKing.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorDice(param1:TPacket) : void
      {
         this.FProcessorDice.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorAutoHangUp(param1:TPacket) : void
      {
         this.FProcessorAutoHangUp.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorConsumeRank(param1:TPacket) : void
      {
         this.FProcessorConsumeRank.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorRechargeRank(param1:TPacket) : void
      {
         this.FProcessorRechargeRank.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorCommonRecharge(param1:TPacket) : void
      {
         this.FProcessorCommonRecharge.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorTenTail(param1:TPacket) : void
      {
         this.FProcessorTenTail.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorVIPFreeBuy(param1:TPacket) : void
      {
         this.FProcessorVIPFreeBuy.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorSeventhEvening(param1:TPacket) : void
      {
         this.FProcessorSeventhEvening.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorCrossServerWar(param1:TPacket) : void
      {
         this.FProcessorCrossServerWar.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorTitle(param1:TPacket) : void
      {
         this.FProcessorTitle.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorMagic(param1:TPacket) : void
      {
         this.FProcessorMagic.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorTower(param1:TPacket) : void
      {
         this.FProcessorTower.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorDailyWelfare(param1:TPacket) : void
      {
         this.FProcessorDailyWelfare.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorJinJaPractice(param1:TPacket) : void
      {
         this.FPocessorNinJaPractice.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorTongLing(param1:TPacket) : void
      {
         this.FProcessorTongLing.PacketProcess(param1);
      }
      
      protected function PackPerform_ProcessorAnimal(param1:TPacket) : void
      {
         this.FProcessorAnimalSeal.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorPalace(param1:TPacket) : void
      {
         this.FProcessorPalace.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorActivityManager(param1:TPacket) : void
      {
         this.FProcessorActivityManager.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorSantaClaus(param1:TPacket) : void
      {
         this.FProcessorSantaClaus.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorUpdateList(param1:TPacket) : void
      {
         this.FProcessorUpdateList.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorBugList(param1:TPacket) : void
      {
         this.FProcessorBugList.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorTopOrganization(param1:TPacket) : void
      {
         this.FProcessorTopOrganization.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorGroupBattle(param1:TPacket) : void
      {
         this.FProcessorGroupBattle.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorWindowAccessory(param1:TPacket) : void
      {
         this.FProcessorWindowAccessory.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorWindowBloodSoulPurgatoryMain(param1:TPacket) : void
      {
         this.FProcessorWindowBloodSoulPurgatoryMain.PacketProcess(param1);
      }
      
      protected function PacketPerform_TProcessorWindowSixFairyMain(param1:TPacket) : void
      {
         this.FProcessorWindowSixFairyMain.PacketProcess(param1);
      }
      
      protected function PacketPerform_TProcessorWindowRebirthRealmAllManager(param1:TPacket) : void
      {
         this.FProcessorWindowRebirthRealmAllManager.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorTopTeam(param1:TPacket) : void
      {
         this.FProcessorTopTeam.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorNarutoHelper(param1:TPacket) : void
      {
         this.FProcessorNarutoHelper.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorPrerogative(param1:TPacket) : void
      {
         this.FProcessorPrerogative.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorNinjaRelation(param1:TPacket) : void
      {
         this.FProcessorNinjaRelationship.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorNinjaHostel(param1:TPacket) : void
      {
         this.FProcessorNinjaHostel.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorWindowBloodFeteMainManageClass(param1:TPacket) : void
      {
         this.FProcessorWindowBloodFeteMainManageClass.PacketProcess(param1);
      }
      
      protected function PacketPerform_WindowManAwaken(param1:TPacket) : void
      {
         this.FProcessorWindowManAwaken.PacketProcess(param1);
      }
      
      protected function PacketPerform_EightDoor(param1:TPacket) : void
      {
         this.FProcessorWindowManEightDoor.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorWindowTheWorldTree(param1:TPacket) : void
      {
         this.FProcessorWindowTheWorldTree.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorWindowUndertown(param1:TPacket) : void
      {
         this.FProcessorWindowUndertown.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorVK(param1:TPacket) : void
      {
         this.FProcessorVkSiMiDa.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorOnLineLiBao(param1:TPacket) : void
      {
         this.FProcessorOnLineLiBao.PacketProcess(param1);
         this.FProcessorMicrologinLibao.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorZhenAoYi(param1:TPacket) : void
      {
         this.FProcessorZhenAoYi.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorMasterRoadOld(param1:TPacket) : void
      {
         this.FProcessorMasterRoadOld.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorLostShenQi(param1:TPacket) : void
      {
         this.FProcessorLostShenQiMain.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorWing(param1:TPacket) : void
      {
         this.FProcessorWing.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorIllustrated(param1:TPacket) : void
      {
         this.FProcessorIllustrated.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorMarried(param1:TPacket) : void
      {
         this.FProcessorMarried.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorHomeland(param1:TPacket) : void
      {
         this.FProcessorHomeland.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorMarryRank(param1:TPacket) : void
      {
         this.FProcessorMarryRank.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorCommon(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:Boolean = false;
         var _loc8_:ByteArray = null;
         _loc8_ = param1.Data;
         _loc3_ = _loc8_.readShort();
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = int(_loc8_.readUnsignedInt());
            _loc5_ = int(_loc8_.readUnsignedInt());
            _loc6_ = _loc8_.readInt();
            _loc7_ = _loc6_ == 1 ? true : false;
            this.ProcessorShortcutEffectNotification(_loc4_,_loc5_,_loc7_);
            _loc2_++;
         }
      }
      
      protected function PacketPerform_ProcessorAddSoul(param1:TPacket) : void
      {
         this.FProcessorWindowAddSoul.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorMasterRoad(param1:TPacket) : void
      {
         this.FProcessorMasterRoad.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorChallenge(param1:TPacket) : void
      {
         this.FProcessorChallenge.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorSpeicalJade(param1:TPacket) : void
      {
         this.FSpecialJade.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorBindEmail(param1:TPacket) : void
      {
         this.FProcessorBindEmail.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorAlien(param1:TPacket) : void
      {
         this.FProcessorAline.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorNinjaAwake(param1:TPacket) : void
      {
         this.FPocessorNinJaPractice.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorAwakeSkill(param1:TPacket) : void
      {
         this.FPocessorNinJaPractice.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorCrossRank(param1:TPacket) : void
      {
         this.FProcessorRank.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorCrossUser(param1:TPacket) : void
      {
         this.FProcessorInspector.PacketProcess(param1);
         this.ProcessorWindowsSwitch(null);
      }
      
      protected function PacketPerform_ProcessorCrossFight(param1:TPacket) : void
      {
         this.FProcessorRank.PacketProcess(param1);
      }
      
      protected function Packetperform_ProcessorKingwar(param1:TPacket) : void
      {
         this.FProcessorKingWar.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorMedal(param1:TPacket) : void
      {
         this.FProcessorMedal.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorMicrologinLibao(param1:TPacket) : void
      {
         this.FProcessorMicrologinLibao.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorInviteCode(param1:TPacket) : void
      {
         this.FProcessorInviteCode.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorWuxing(param1:TPacket) : void
      {
         this.FProcessorWuxing.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorWarehouse(param1:TPacket) : void
      {
         this.FProcessorWarehouse.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorDiscord(param1:TPacket) : void
      {
         this.FProcessorDiscord.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorGlobalBattle(param1:TPacket) : void
      {
         this.FProcessorGlobalBattle.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorShop(param1:TPacket) : void
      {
         this.FProcessorWindowShop.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorConsumeVip(param1:TPacket) : void
      {
         this.FProcessorConsumeVip.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorEmblem(param1:TPacket) : void
      {
         this.FProcessorEmblem.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorWorldMatch(param1:TPacket) : void
      {
         this.FProcessorWorldMatch.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorChristmasDay(param1:TPacket) : void
      {
         this.FProcessorChristmasDay.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorSummonBattle(param1:TPacket) : void
      {
         this.FProcessorSummonBattle.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorNinjaTalent(param1:TPacket) : void
      {
         this.FProcessorNinjaTalent.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorChallengeCamp(param1:TPacket) : void
      {
         this.FProcessorChallengeCamp.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorLevelGifts(param1:TPacket) : void
      {
         this.FProcessorTalentLevelGifts.PacketProcess(param1);
         this.FProcessorHeroLevelGifts.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorWorldMatchStreak(param1:TPacket) : void
      {
         this.FProcessorWorldMatchStreak.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorGlobalBoss(param1:TPacket) : void
      {
         this.FProcessorGlobalBoss.PacketProcess(param1);
         this.FProcessorGlobalbossChapter.PacketProcess(param1);
         this.FProcessorGlobalBossMain.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorDayRechargeGift(param1:TPacket) : void
      {
         this.FProcessorDayRechargeGift.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorRecruit(param1:TPacket) : void
      {
         this.FProcessorRecruit.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorSalve(param1:TPacket) : void
      {
         this.FProcessorSlave.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorRefreshTalent(param1:TPacket) : void
      {
         this.FProcessorTalentGifts.PacketProcess(param1);
         this.FProcessorNinjaTalent.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorLeadLevelGifts(param1:TPacket) : void
      {
         this.FProcessorLeadLevelGifts.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorBaiDuMM(param1:TPacket) : void
      {
         this.FTProcessorBaiDuMM.PacketProcess(param1);
      }
      
      protected function PacketPerform_OhtsutsukiKaguya(param1:TPacket) : void
      {
         this.FProcessorOhtsutsukiKaguya.PacketProcess(param1);
      }
      
      protected function PacketPerform_NewMall(param1:TPacket) : void
      {
         this.FPressorWindowNewMall.PacketProcess(param1);
      }
      
      protected function PacketPerform_TransmigrationTrial(param1:TPacket) : void
      {
         this.FProcessorTransmigrationTrial.PacketProcess(param1);
         this.FProcessorSmithy.PacketProcess(param1);
      }
      
      protected function PacketPerform_TransmigrationAccessory(param1:TPacket) : void
      {
         this.FProcessorTransmigrationAccessory.PacketProcess(param1);
      }
      
      protected function PacketPerform_Taboo(param1:TPacket) : void
      {
         this.FPressorWindowTaboo.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorWindowNijiaMystic(param1:TPacket) : void
      {
         this.FProcessorWindowNijiaMystic.PacketProcess(param1);
      }
      
      protected function PacketPerform_SC_Enter_Town(param1:TPacket) : void
      {
         this.ProcessorPlateSwitch(this.FProcessorMainScene,param1.Data);
         SlowMovingAnyResource.getInstance(this).Lobby = this;
         this.FProcessorOrganization.OrganizationIconEffectDataReq();
         SExternalCore.LoadFinish();
         this.FProcessorShortcuts.IsShowOhtsutsukiKaguya();
         if(!this.OneMyGod)
         {
            this.ProcessorOnOpenNewActivityList();
            this.ProcessorOnOpenActivityThirdList();
            this.OneMyGod = true;
         }
         if(!this.Nimei)
         {
            this.ProcesorVkOnClick();
            this.Nimei = true;
         }
         if(this.FProcessorVkSiMiDa.VeryveryLiHai == 7)
         {
            this.FProcessorVkSiMiDa.VeryveryLiHai = 0;
            this.OpenVk();
         }
         this.FProcessorShortcuts.IsShowOhtsutsukiKaguya();
         if(Boolean(SParametersCore.Is1377Display) || Boolean(SParametersCore.IsBound))
         {
            if(!SParametersCore.PassWord || SParametersCore.PassWord == "")
            {
            }
         }
         if(Boolean(SParametersNewCore.IsMicroLogin) && SLogicsCore.Character.MainHero.Level >= 30)
         {
            this.MiIconIsShow(true);
         }
      }
      
      protected function ProcessorInspectorUpdataSeverTime(param1:Object) : void
      {
         this.FProcessorInspector.UpdataServerTime();
      }
      
      protected function ProcessorOnCheckAntiAddiction(param1:Object) : void
      {
         this.FProcessorInspector.UpdateCharacterCheckAntiAddiction();
         this.FProcessorShortcuts.InitSystemSetup();
      }
      
      protected function ProcessorInitAllNpc(param1:Object) : void
      {
         this.FProcessorMainScene.InitAllNpc();
      }
      
      protected function ProcessorOnInitMallInfo(param1:Object) : void
      {
         this.FProcessorMall.InitMallInfo();
      }
      
      protected function ProcessorOnInitPvpMallInfo(param1:Object) : void
      {
         this.FProcessorTopTeam.InitPvpMallInfo();
      }
      
      protected function ProcessorOnInitCrossServerMallInfo(param1:Object) : void
      {
         this.FProcessorCrossServerWarWindows.InitCrossServerMallInfo();
      }
      
      protected function ProcessorOnInitVipInfo(param1:Object) : void
      {
         this.FProcessorVIP.InitVipInfo();
      }
      
      protected function ProcessorOnEnterFamily(param1:Object) : void
      {
         this.FProcessorFreshGuide.UpdateFamily();
         this.ProcessorOnUserUpdateCharacterCountry(param1);
      }
      
      protected function ProcessorCitySceneOnEnter(param1:Object) : void
      {
         this.FProcessorQuest.HandleRoleEnterCity();
      }
      
      private function ProcessorQualityOnChange(param1:Object) : void
      {
         this.FProcessorMainScene.ChangeMainHeroQuality();
         this.FProcessorShortcuts.UserUpdateCharBaseInfo();
         this.FProcessorBattleScene.MainHeroQualityOnChange(param1);
         if(SLogicsCore.Character.RoleSencePosition == CONST_COMMON.SCENEPOSITION_FightPet)
         {
            this.FProcessorFightPet.ChangeMainHeroQuality();
         }
         else if(SLogicsCore.Character.RoleSencePosition == CONST_COMMON.SCENEPOSITION_TraitorAttack)
         {
            this.FProcessorTraitorAttack.ChangeMainHeroQuality();
         }
         else if(SLogicsCore.Character.RoleSencePosition == CONST_COMMON.SCENEPOSITION_FightAnimal)
         {
            this.FProcessorAnimalSeal.ChangeMainHeroQuality();
         }
      }
      
      private function ProcessorRequestMilitaryInfor(param1:Object) : void
      {
         this.FProcessorProtagonist.RequestMilitaryBaseInfor();
      }
      
      protected function ProcessorAccountOnUserLevelUpEffect(param1:Object) : void
      {
         this.FProcessorEffect.ImportUserLevelUp(this.FProcessorMainScene.MainPlayerCoordinate);
      }
      
      protected function ProcessorAccountOnAutoSearchWayEffect(param1:Object, param2:Boolean) : void
      {
         this.FProcessorEffect.ImportUserAutomaticallyFind(param2);
      }
      
      protected function ProcessorAccountOnAcceptTaskEffect(param1:Object) : void
      {
         this.FProcessorEffect.ImportUserAcceptTask();
      }
      
      protected function ProcessorAccountOnCompleteEffect(param1:Object) : void
      {
         this.FProcessorEffect.ImportUserCompleteTask();
      }
      
      protected function ProcessorAccountOnUserLevelUp(param1:Object) : void
      {
         var _loc2_:uint = 0;
         _loc2_ = uint(SLogicsCore.Character.MainHero.Level);
         this.FProcessorQuest.RoleLevelUp();
         this.FProcessorPopTips.OnCheckLevelUp();
         this.FProcessorShortcuts.CheckUnlockSeverStar();
         this.FProcessorShortcuts.MainHeroUpLevel();
         this.FProcessorMentorship.UpdateUI();
         if(_loc2_ == SLogicsCore.Character.ConfigNpc[1])
         {
            this.FProcessorMainScene.UpdateNpc();
         }
         this.FProcessorDailyWelfare.LevelUpCheckRewardType();
         this.FProcessorMagic.LevelUpRequestData();
         SlowMovingAnyResource.getInstance().LevelUp();
         this.FProcessorTopTeam.LevelUpOpenIconRequest();
         this.FProcessorNarutoHelper.LevelUpOpenIconEffect();
         this.PacketPerform_CS_ObligatoryCourses_Req();
         if(_loc2_ >= 32 && !this.OneTimes)
         {
            this.OneTimes = true;
            this.FProcessorTongLing.PacketPerform_CS_TongLingReq();
         }
         TProcessorActivityLevelManager.levelChange();
      }
      
      protected function PacketPerform_CS_ObligatoryCourses_Req() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_NarutoRoad_ObligatoryCoursesReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PacketPerform_SC_SceneRoleContorl(param1:TPacket) : void
      {
         switch(SLogicsCore.Character.RoleSencePosition)
         {
            case CONST_COMMON.SCENEPOSITION_MAINCITY:
               this.FProcessorMainScene.PacketProcess(param1);
               break;
            case CONST_COMMON.SCENEPOSITION_FightPet:
               this.FProcessorFightPet.PacketProcess(param1);
               break;
            case CONST_COMMON.SCENEPOSITION_TraitorAttack:
               this.FProcessorTraitorAttack.PacketProcess(param1);
               break;
            case CONST_COMMON.SCENEPOSITION_FightAnimal:
               this.FProcessorAnimalSeal.PacketProcess(param1);
         }
      }
      
      protected function PacketPerform_SC_Enter_WorldMap(param1:TPacket) : void
      {
         this.ProcessorPlateSwitch(this.FProcessorWorldMap,param1.Data);
      }
      
      protected function PacketPerform_SC_Enter_OrganizationalWar(param1:TPacket) : void
      {
         var _loc2_:uint = 0;
         _loc2_ = param1.Data.readUnsignedInt();
         if(_loc2_ != 0)
         {
            this.EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         this.ProcessorPlateSwitch(this.FOrganizationalWar,param1.Data);
         this.FProcessorFreshGuide.EnterOtherScene();
      }
      
      protected function PacketPerform_SC_Enter_Hurdle(param1:TPacket) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:ByteArray = null;
         _loc3_ = param1.Data;
         _loc2_ = _loc3_.readUnsignedInt();
         if(_loc2_ != 0)
         {
            this.EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         this.ProcessorPlateSwitch(this.FProcessorBattleScene,param1.Data);
      }
      
      protected function PacketPerform_SC_Enter_KillHeros(param1:TPacket) : void
      {
         this.ProcessorWindowsSwitch(this.FProcessorKillHeros,param1.Data);
      }
      
      protected function PacketPerform_SC_Enter_Tavern(param1:TPacket) : void
      {
         this.ProcessorPlateSwitch(this.FProcessorTavern,param1.Data);
      }
      
      protected function PacketPerform_SC_Enter_Arena(param1:TPacket) : void
      {
         this.ProcessorPlateSwitch(this.FProcessorArena,param1.Data);
      }
      
      protected function PacketPerform_SC_Enter_TreasureMap(param1:TPacket) : void
      {
         this.ProcessorPlateSwitch(this.FProcessorTreasureMap,param1.Data);
      }
      
      protected function PacketPerform_SC_Enter_CityDefend(param1:TPacket) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:ByteArray = null;
         _loc3_ = param1.Data;
         _loc2_ = _loc3_.readUnsignedInt();
         if(_loc2_ != 0)
         {
            this.EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         this.ProcessorPlateSwitch(this.FProcessorCityDefend,param1.Data);
         this.FProcessorFreshGuide.EnterOtherScene();
      }
      
      protected function PacketPerform_SC_Enter_FightPet(param1:TPacket) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:ByteArray = null;
         _loc3_ = param1.Data;
         _loc2_ = _loc3_.readUnsignedInt();
         if(_loc2_ != 0)
         {
            this.EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         this.ProcessorPlateSwitch(this.FProcessorFightPet,param1.Data);
         this.FProcessorFreshGuide.EnterOtherScene();
      }
      
      protected function PacketPerform_SC_Enter_FightPetCopy(param1:TPacket) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:ByteArray = null;
         _loc3_ = param1.Data;
         _loc2_ = _loc3_.readUnsignedInt();
         if(_loc2_ != 0)
         {
            this.EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         this.ProcessorPlateSwitch(this.FProcessorAnimalSeal,param1.Data);
         this.FProcessorOrganization.FCloseThiseByOthers();
         this.FProcessorFreshGuide.EnterOtherScene();
         this.FProcessorOrganization.OnCloseMePanel();
      }
      
      protected function PacketPerform_SC_Enter_TraitorAttack(param1:TPacket) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:ByteArray = null;
         _loc3_ = param1.Data;
         _loc2_ = _loc3_.readUnsignedInt();
         if(_loc2_ != 0)
         {
            this.EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         this.ProcessorPlateSwitch(this.FProcessorTraitorAttack,param1.Data);
         this.FProcessorFreshGuide.EnterOtherScene();
      }
      
      protected function PacketPerform_SC_Enter_SevenKing(param1:TPacket) : void
      {
         this.FProcessorSevenKing.SetInitInfo(param1.Data);
      }
      
      protected function PacketPerform_ProcessorBattle(param1:TPacket) : void
      {
      }
      
      protected function PacketPerform_ProcessorTacticalDeployment(param1:TPacket) : void
      {
         this.FProcessorTacticalDeployment.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorJade(param1:TPacket) : void
      {
         this.FProcessorJade.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorChat(param1:TPacket) : void
      {
         this.FProcessorChat.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorBackpack(param1:TPacket) : void
      {
         this.FProcessorBackpack.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorHeros(param1:TPacket) : void
      {
         this.FProcessorHeros.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorTavern(param1:TPacket) : void
      {
         this.FProcessorTavern.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorGodEquip(param1:TPacket) : void
      {
         this.FProcessorGodEquip.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorQuest(param1:TPacket) : void
      {
         this.FProcessorQuest.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorTalisman(param1:TPacket) : void
      {
         this.FProcessorTalisman.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorMail(param1:TPacket) : void
      {
         this.FProcessorMail.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorEquipMake(param1:TPacket) : void
      {
         this.FProcessorSmithy.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorEquipAdvanced(param1:TPacket) : void
      {
         this.FProcessorEquipAdvanced.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorPet(param1:TPacket) : void
      {
         this.FProcessorPet.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorFriend(param1:TPacket) : void
      {
         this.FProcessorFriend.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorInspector(param1:TPacket) : void
      {
         this.FProcessorInspector.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorVIP(param1:TPacket) : void
      {
         this.FProcessorVIP.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorOrganization(param1:TPacket) : void
      {
         this.FProcessorOrganization.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorMall(param1:TPacket) : void
      {
         this.FProcessorMall.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorSign(param1:TPacket) : void
      {
         this.FProcessorDailySign.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorCopyHero(param1:TPacket) : void
      {
         this.FProcessorCopyHero.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorDailyTask(param1:TPacket) : void
      {
         this.FProcessorDailyQuest.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorRamen(param1:TPacket) : void
      {
         this.FProcessorRamen.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorLimit(param1:TPacket) : void
      {
         this.FProcessorCounter.PacketProcess(param1);
      }
      
      public function PerformPacket_SC_Organization_Animal(param1:TPacket) : void
      {
         this.FProcessorOrganization.PerformPacket_SC_Organization_Animal(param1);
      }
      
      public function PerformPacket_SC_Organization_apply(param1:TPacket) : void
      {
         this.FProcessorOrganization.PerformPacket_SC_Organization_apply(param1);
      }
      
      public function PACKETID_SC_AnimalSeall_Open_Ret(param1:TPacket) : void
      {
         this.FProcessorOrganization.PACKETID_SC_AnimalSeall_Open_Ret(param1);
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         this.LogicsPerform_MountPoints();
      }
      
      protected function LogicsPerform_MountPoints() : void
      {
         var _loc1_:Boolean = false;
         _loc1_ = !this.BattleQueryActive();
         this.FMountPointPlate.visible = _loc1_;
         this.FMountPointShortcuts.visible = _loc1_;
         this.FMountPointBarrier.visible = _loc1_;
         this.FMountPointWindows.visible = _loc1_;
         this.FMountPointOverview.visible = _loc1_;
         this.FMountPointWindow.visible = _loc1_;
      }
      
      override protected function AffairRegisterRoutines() : void
      {
         super.AffairRegisterRoutines();
         FAffairRoutines.Register(AFFAIRID_TimingWaitBattleActive,this.AffairPerform_TimingWaitBattleActive);
         FAffairRoutines.Register(AFFAIRID_TimingWaitBattleLoading,this.AffairPerform_TimingWaitBattleLoading);
         FAffairRoutines.Register(AFFAIRID_ChatOptionsSetup,this.AffairPerform_ChatOptionsSetup);
         FAffairRoutines.Register(AFFAIRID_ChatOptionsApply,this.AffairPerform_ChatOptionsApply);
         FAffairRoutines.Register(AFFAIRID_GameStateExternalize,this.AffairPerform_GameStateExternalize);
         FAffairRoutines.Register(AFFAIRID_GarbageCollector,this.AffairPerform_GarbageCollector);
         FAffairRoutines.Register(AFFAIRID_OpenSocketLoading,this.AffairPerform_OpenSocketLoading);
         FAffairRoutines.Register(AFFAIRID_CloseSocketLoading,this.AffairPerform_CloseSocketLoading);
      }
      
      protected function AffairPerform_TimingWaitBattleActive(param1:TAffair) : void
      {
         var _loc2_:Boolean = false;
         _loc2_ = this.BattleQueryActive();
         if(_loc2_)
         {
            param1.PostProcess = TAffair.POSTPROCESS_Pend;
         }
         else
         {
            param1.PostProcess = TAffair.POSTPROCESS_Remove;
         }
      }
      
      protected function AffairPerform_TimingWaitBattleLoading(param1:TAffair) : void
      {
         var _loc2_:Boolean = false;
         _loc2_ = this.BattleQueryLoading();
         if(_loc2_)
         {
            param1.PostProcess = TAffair.POSTPROCESS_Pend;
         }
         else
         {
            param1.PostProcess = TAffair.POSTPROCESS_Remove;
         }
      }
      
      protected function AffairPerform_ChatOptionsSetup(param1:TAffair) : void
      {
         if(this.FProcessorPlateActive != null)
         {
            this.FProcessorPlateActive.ChatOptionsSetup(this.FChatOptions);
         }
      }
      
      protected function AffairPerform_ChatOptionsApply(param1:TAffair) : void
      {
         this.FProcessorChat.SetChatOptions(this.FChatOptions);
         if(SLogicsCore.Character.RoleSencePosition == CONST_COMMON.SCENEPOSITION_BATTLESENCE_AUTO)
         {
            this.ProcessorOnAutoBattleMainUISet(this,true);
         }
      }
      
      protected function AffairPerform_GameStateExternalize(param1:TAffair) : void
      {
         if(this.FProcessorPlateActive == this.FProcessorAccount)
         {
            return;
         }
         switch(this.FProcessorPlateActive)
         {
            case this.FProcessorMainScene:
               this.FProcessorNarutoRoadTip.ViewVisible = true;
               break;
            case this.FProcessorBattleScene:
               break;
            default:
               this.FProcessorPopTips.Hide();
               this.FProcessorNarutoRoadTip.ViewVisible = false;
         }
      }
      
      protected function AffairPerform_GarbageCollector(param1:TAffair) : void
      {
         if(this.FOnGarbageCollector != null)
         {
            this.FOnGarbageCollector();
         }
      }
      
      protected function AffairPerform_OpenSocketLoading(param1:TAffair) : void
      {
         if(this.FOnOpenSocketLoading != null)
         {
            this.FOnOpenSocketLoading(this);
         }
      }
      
      protected function AffairPerform_CloseSocketLoading(param1:TAffair) : void
      {
         if(this.FOnCloseSocketLoading != null)
         {
            this.FOnCloseSocketLoading(this);
         }
      }
      
      protected function ActuatorBarrierOnUpdate(param1:Object) : void
      {
         var _loc2_:int = 0;
         _loc2_ = this.FParameters.ActuatorBarrier.Count;
         if(_loc2_ > 0)
         {
            this.FBarrier.Visible = true;
         }
         else
         {
            this.FBarrier.Visible = false;
         }
      }
      
      protected function ProcessorsOnQueryBattleActive(param1:Object, param2:TQueryBoolean) : void
      {
         param2.Value = this.BattleQueryActive();
      }
      
      protected function ProcessorsOnEffectText(param1:Object, param2:String, param3:TEffectTextParameters = null, param4:TEffectCoordinateParameters = null, param5:uint = 5) : void
      {
         this.FProcessorEffect.ImportText(param2,param3,param4,param5);
      }
      
      protected function ProcessorOnEffectSoul(param1:Object, param2:uint, param3:uint, param4:TEffectCoordinateParameters = null) : void
      {
         this.FProcessorEffect.ImportSoul(param2,param3,param4);
      }
      
      protected function ProcessorOnDialogMsg(param1:Object, param2:String) : void
      {
         this.FProcessorDialogMsg.ImportText(param2);
      }
      
      protected function ProcessorOnUpdateSuperHeroUI(param1:Object) : void
      {
         this.FProcessorSuperHero.UpdateSuperHeroUI();
      }
      
      protected function ProcessorOnSendMail(param1:Object, param2:Object) : void
      {
         this.FProcessorMail.SendGMMail(param2);
      }
      
      protected function ProcessorOnSignIntegral(param1:Object) : void
      {
         this.FProcessorDailySign.UpdateIntegralInfo();
      }
      
      protected function ProcessorOnOpenVIP(param1:Object) : void
      {
         this.ProcessorWindowsSwitch(this.FProcessorVIP);
      }
      
      protected function ProcessorMallOnBuy(param1:Object, param2:uint, param3:Object, param4:Function) : void
      {
         this.FProcessorMall.ProcessorMallOnBuy(param2,param3,param4);
      }
      
      protected function ProcessorsOnItemOnClick(param1:Object, param2:Object) : void
      {
         this.FProcessorGoodsPurchase.UpdateData(param2);
      }
      
      protected function ProcessorOnBuyResult(param1:Object, param2:uint) : void
      {
         this.FProcessorGoodsPurchase.ShowEffectText(param2);
         if(param2 == 0)
         {
            this.FProcessorShortcuts.UpdateMilitaryOrdersLimit();
         }
      }
      
      protected function ProcessorsPlateOnUpdateShortcutModes(param1:Object) : void
      {
         var _loc2_:TProcessorLobbyPlate = null;
         _loc2_ = param1 as TProcessorLobbyPlate;
         if(_loc2_ != this.FProcessorPlateActive)
         {
            return;
         }
         _loc2_.ShortcutModesSetup(this.FShortcutAvatarModes);
         _loc2_.ShortcutModesSetup(this.FShortcutActivityModes);
         _loc2_.ShortcutModesSetup(this.FShortcutActiveSpecialModes);
         _loc2_.ShortcutModesSetup(this.FShortcutFunctionModes);
         _loc2_.ShortcutModesSetup(this.FShortcutMapModes);
         _loc2_.ShortcutModesSetup(this.FShortcutQuestGuideModes);
         _loc2_.ShortcutModesSetup(this.FShortcuConstantlyModes);
         this.FProcessorShortcuts.ShortcutsSetup(this.FShortcutAvatarModes);
         this.FProcessorShortcuts.ShortcutsSetup(this.FShortcutActivityModes);
         this.FProcessorShortcuts.ShortcutsSetup(this.FShortcutActiveSpecialModes);
         this.FProcessorShortcuts.ShortcutsSetup(this.FShortcutFunctionModes);
         this.FProcessorShortcuts.ShortcutsSetup(this.FShortcutMapModes);
         this.FProcessorShortcuts.ShortcutsSetup(this.FShortcutQuestGuideModes);
         this.FProcessorShortcuts.ShortcutsSetup(this.FShortcuConstantlyModes);
      }
      
      protected function ProcessorOnAutoBattleMainUISet(param1:Object, param2:Boolean) : void
      {
         if(this.FProcessorShortcuts != null)
         {
            if(param2)
            {
               this.FChatOptions.ChatStatus = CONST_CHAT.MODE_None;
               this.FProcessorChat.SetChatOptions(this.FChatOptions);
               this.FShortcutAvatarModes.ShortcutModesReset(TLobbyShortcutMode.SHORTCUTMODE_Show);
               this.FShortcutActivityModes.ShortcutModesReset(TLobbyShortcutMode.SHORTCUTMODE_Hidden);
               this.FShortcutActiveSpecialModes.ShortcutModesReset(TLobbyShortcutMode.SHORTCUTMODE_Hidden);
               this.FShortcutFunctionModes.ShortcutModesReset(TLobbyShortcutMode.SHORTCUTMODE_Hidden);
               this.FShortcutMapModes.ShortcutModesReset(TLobbyShortcutMode.SHORTCUTMODE_Hidden);
               this.FShortcutQuestGuideModes.ShortcutModesReset(TLobbyShortcutMode.SHORTCUTMODE_Hidden);
               this.FShortcuConstantlyModes.ShortcutModesReset(TLobbyShortcutMode.SHORTCUTMODE_Hidden);
            }
            else
            {
               this.FChatOptions.ChatStatus = CONST_CHAT.MODE_Hidden;
               this.FProcessorChat.SetChatOptions(this.FChatOptions);
               this.FShortcutAvatarModes.ShortcutModesReset(TLobbyShortcutMode.SHORTCUTMODE_Hidden);
               this.FShortcutQuestGuideModes.ShortcutModesReset(TLobbyShortcutMode.SHORTCUTMODE_Show);
            }
         }
         else
         {
            this.FChatOptions.ChatStatus = CONST_CHAT.MODE_Hidden;
            this.FProcessorChat.SetChatOptions(this.FChatOptions);
            this.FShortcutAvatarModes.ShortcutModesReset(TLobbyShortcutMode.SHORTCUTMODE_Hidden);
            this.FShortcutActivityModes.ShortcutModesReset(TLobbyShortcutMode.SHORTCUTMODE_Hidden);
            this.FShortcutActiveSpecialModes.ShortcutModesReset(TLobbyShortcutMode.SHORTCUTMODE_Hidden);
            this.FShortcutFunctionModes.ShortcutModesReset(TLobbyShortcutMode.SHORTCUTMODE_Hidden);
            this.FShortcutMapModes.ShortcutModesReset(TLobbyShortcutMode.SHORTCUTMODE_Hidden);
            this.FShortcutQuestGuideModes.ShortcutModesReset(TLobbyShortcutMode.SHORTCUTMODE_Hidden);
            this.FShortcuConstantlyModes.ShortcutModesReset(TLobbyShortcutMode.SHORTCUTMODE_Hidden);
         }
         this.FProcessorShortcuts.ShortcutsSetup(this.FShortcutAvatarModes);
         this.FProcessorShortcuts.ShortcutsSetup(this.FShortcutActivityModes);
         this.FProcessorPlateActive.ShortcutModesSetup(this.FShortcutActiveSpecialModes);
         this.FProcessorShortcuts.ShortcutsSetup(this.FShortcutFunctionModes);
         this.FProcessorShortcuts.ShortcutsSetup(this.FShortcutMapModes);
         this.FProcessorShortcuts.ShortcutsSetup(this.FShortcutQuestGuideModes);
         this.FProcessorShortcuts.ShortcutsSetup(this.FShortcuConstantlyModes);
      }
      
      protected function ProcessorsPlateOnUpdateChatOptions(param1:Object) : void
      {
         var _loc2_:TProcessorLobbyPlate = null;
         _loc2_ = param1 as TProcessorLobbyPlate;
         if(_loc2_ != this.FProcessorPlateActive)
         {
            return;
         }
         FAffairGenerator.Generate(AFFAIRID_ChatOptionsSetup);
         FAffairGenerator.Generate(AFFAIRID_ChatOptionsApply);
      }
      
      protected function ProcessorsOnUpdatePopTipsModes(param1:Object) : void
      {
         this.FProcessorPopTips.Hide();
      }
      
      protected function ProcessorOnCheckPopTipsModes(param1:Object, param2:int) : void
      {
         this.FProcessorPopTips.CheckPopTipsByPanelId(param2);
      }
      
      protected function ProcessorsWindowsOnClose(param1:Object) : void
      {
         this.ProcessorWindowsSwitch(null);
      }
      
      protected function ProcessorsWindowsOnCloseActivityManager(param1:Object) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TProcessorLobbyWindows = null;
         if(this.FProcessorActivityManager != null)
         {
            this.FProcessorActivityManager.Unmount();
            this.FParameters.ActuatorBarrier.Deactuate(this.FProcessorActivityManager);
         }
         if(this.FProcessorWindowsActive == this.FProcessorActivityManager)
         {
            this.FProcessorWindowsActive = null;
         }
      }
      
      protected function ChangeBtnFunction() : void
      {
         this.ProcessorShortcutsOnTreasureMap(null);
      }
      
      protected function ProcessorOnReturnMainScene(param1:Object) : void
      {
         this.ProcessorPlateSwitch(this.FProcessorMainScene);
      }
      
      protected function ProcessorOnReturnNijiaBattle(param1:Object) : void
      {
         this.ProcessorPlateSwitch(this.FProcessorMainScene);
         this.ProcessorWindowsSwitch(this.FProcessorGroupBattle);
      }
      
      protected function ProcessorOnReturnTopTeam(param1:Object) : void
      {
         this.ProcessorPlateSwitch(this.FProcessorMainScene);
         this.ProcessorWindowsSwitch(this.FProcessorTopTeam);
      }
      
      protected function ProcessorsTurnBackBattleSceneNtf(param1:Object) : void
      {
         if(SLogicsCore.Character.RoleSencePosition == CONST_COMMON.SCENEPOSITION_BATTLESENCE)
         {
            this.FProcessorBattleScene.SetTurnBackDialog();
         }
         else if(SLogicsCore.Character.RoleSencePosition == CONST_COMMON.SCENEPOSITION_FightPet)
         {
            this.FProcessorFightPet.BackTownBox();
         }
         else if(SLogicsCore.Character.RoleSencePosition == CONST_COMMON.SCENEPOSITION_CityDefend)
         {
            this.FProcessorCityDefend.BackTownDialog();
         }
         else if(SLogicsCore.Character.RoleSencePosition == CONST_COMMON.SCENEPOSITION_OrganizationWar)
         {
            this.FOrganizationalWar.BackToMainSceneConfir();
         }
         else if(SLogicsCore.Character.RoleSencePosition == CONST_COMMON.SCENEPOSITION_TraitorAttack)
         {
            this.FProcessorTraitorAttack.BackTownDialog();
         }
         else if(SLogicsCore.Character.RoleSencePosition == CONST_COMMON.SCENEPOSITION_FightAnimal)
         {
            this.FProcessorAnimalSeal.BackTownBox();
         }
      }
      
      protected function ProcessorsBuyGoods(param1:uint, param2:uint, param3:Function) : void
      {
         this.FProcessorGoodsPurchase.UseMallBuy(param1,param2,param3);
      }
      
      protected function ProcessorShortcutsOnMail(param1:Object, param2:ByteArray = null) : void
      {
         this.ProcessorWindowsSwitch(this.FProcessorMail,param2);
      }
      
      protected function ProcessorShortcutsOnAutoBattle(param1:Object, param2:Boolean, param3:Boolean, param4:Boolean) : void
      {
         this.FProcessorCityDefend.SetAutoBattle(param2,param3,param4);
         this.FProcessorFightPet.SetAutoBattle(param2,param3,param4);
         this.FProcessorAnimalSeal.SetAutoBattle(param2,param3,param4);
         this.FProcessorTraitorAttack.SetAutoBattle(param2,param3,param4);
      }
      
      protected function ProcessorShortcutsOnZeroReq(param1:Object) : void
      {
         var _loc2_:TPacket = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_NarutoRoad_ObligatoryCoursesReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function ProcessorShortcutsOnEndAutoBattle(param1:Object) : void
      {
         this.FProcessorShortcuts.EndAutoBattle(param1);
      }
      
      protected function ProcessorShortcutsExecuteCommand(param1:Object) : void
      {
         this.FProcessorShortcuts.ExecuteCommand(param1);
      }
      
      protected function ProcessorsOnEnterTown(param1:Object) : void
      {
         this.FProcessorAccount.UserEnterTownRequest();
      }
      
      protected function ProcessorsOnStartFreshGuide(param1:Object) : void
      {
      }
      
      protected function ProcessorShortcutsOnKillHeros(param1:Object) : void
      {
         this.ProcessorWindowsSwitch(this.FProcessorKillHeros);
      }
      
      protected function ProcessorShortcutsOnArena(param1:Object) : void
      {
         this.ProcessorPlateSwitch(this.FProcessorArena);
      }
      
      protected function ProcessorShortcutsOnCDK(param1:Object) : void
      {
         this.ProcessorWindowsSwitch(this.FProcessorCDK);
      }
      
      protected function ProcessorShortcutsOnDiscord(param1:Object) : void
      {
         this.ProcessorWindowsSwitch(this.FProcessorDiscord);
      }
      
      protected function ProcessorShortcutsOnCopyHero(param1:Object, param2:ByteArray) : void
      {
         this.ProcessorWindowsSwitch(this.FProcessorCopyHero,param2);
      }
      
      protected function ProcessorShortcutsOnBigDipper(param1:Object) : void
      {
         this.ProcessorWindowsSwitch(this.FProcessorBigDipper);
      }
      
      protected function ProcessorShortcutsOnMentorship(param1:Object) : void
      {
         this.ProcessorWindowsSwitch(this.FProcessorMentorship);
      }
      
      protected function ProcessorShortcutsOnSevenKing(param1:Object) : void
      {
         this.ProcessorPlateSwitch(this.FProcessorSevenKing);
      }
      
      protected function ProcessorShortcutsOnCrossServerWar(param1:Object) : void
      {
         this.ProcessorOnOpenCrossServerWar(param1);
      }
      
      protected function ProcessorShortcutsOnMagic(param1:Object, param2:ByteArray) : void
      {
         if(!SLogicsCore.MagicData.IsCanDown)
         {
            return;
         }
         this.ProcessorWindowsSwitch(this.FProcessorMagic,param2);
      }
      
      protected function ProcessorShortcutsOnTower(param1:Object) : void
      {
         this.ProcessorWindowsSwitch(this.FProcessorTower);
      }
      
      protected function ProcessorShortcutsOnDailyWelfare(param1:Object) : void
      {
         this.ProcessorWindowsSwitch(this.FProcessorDailyWelfare);
      }
      
      protected function ProcessorShortcutsOnSign(param1:Object) : void
      {
         this.ProcessorWindowsSwitch(this.FProcessorDailySign);
      }
      
      protected function ProcessorShortcutsOnTreasureMap(param1:Object) : void
      {
         this.ProcessorPlateSwitch(this.FProcessorTreasureMap);
      }
      
      protected function ProcessorShortcutsOnSuperHero(param1:Object, param2:ByteArray) : void
      {
         this.ProcessorPlateSwitch(this.FProcessorSuperHero,param2);
      }
      
      protected function ProcessorShortcutsOnMall(param1:Object, param2:ByteArray = null) : void
      {
         this.ProcessorWindowsSwitch(this.FPressorWindowNewMall,param2);
      }
      
      protected function ProcessorShortcutsOnDailyQuest(param1:Object) : void
      {
         this.ProcessorWindowsSwitch(this.FProcessorDailyQuest);
      }
      
      protected function ProcessorShortcutsOnDailyActivity(param1:Object) : void
      {
         this.ProcessorWindowsSwitch(this.FProcessorDailyActivity);
      }
      
      protected function ProcessorShortcutsOnNarutoRoad(param1:Object, param2:ByteArray = null) : void
      {
         this.ProcessorWindowsSwitch(this.FProcessorNarutoRoad,param2);
      }
      
      protected function ProcessorShortcutsOnFirstRechageCashBack(param1:Object) : void
      {
         this.ProcessorWindowsSwitch(this.FProcessorRechargeCashback);
      }
      
      protected function ProcessorShortcutsOnFirstRecharge(param1:Object) : void
      {
         this.ProcessorWindowsSwitch(this.FProcessorFirstRecharge);
      }
      
      protected function ProcessorShowFlatformIconEffect(param1:Object, param2:Boolean) : void
      {
         this.FProcessorShortcuts.IsPlayEffect(param2);
      }
      
      protected function ProcessorObligatoryCoursesCount(param1:Object, param2:uint) : void
      {
         this.FProcessorShortcuts.SetObligatoryCoursesCount(param1,param2);
      }
      
      protected function ProcessorsetFBaiDuMeimeiMcState(param1:Boolean) : void
      {
         this.FProcessorShortcuts.setFBaiDuMeimeiMcState(param1);
      }
      
      protected function ProcessorShortcutsOnRecharge(param1:Object) : void
      {
         this.ProcessorWindowsSwitch(this.FProcessorRecharge);
      }
      
      protected function ProcessorShortcutsOnWonderfulActivity(param1:Object) : void
      {
         this.ProcessorWindowsSwitch(this.FProcessorWonderfulActivity);
      }
      
      protected function ProcessorShortcutsOnLottery(param1:Object) : void
      {
         this.ProcessorWindowsSwitch(this.FProcessorLottery);
      }
      
      protected function ProcessorShortcutsOnSystemActivity(param1:Object) : void
      {
         this.ProcessorWindowsSwitch(this.FProcessorSystemActivity);
      }
      
      protected function ProcessorShortcutsOnDragonBoat(param1:Object) : void
      {
         this.ProcessorWindowsSwitch(this.FProcessorDragonBoat);
      }
      
      protected function ProcessorShortcutsOnFrogWallet(param1:Object) : void
      {
         this.ProcessorWindowsSwitch(this.FProcessorFrogWallet);
      }
      
      protected function ProcessorShortcutsOnVipShop(param1:Object) : void
      {
         this.ProcessorWindowsSwitch(this.FProcessorVipShop);
      }
      
      protected function ProcessorshortcutsOnDice(param1:Object) : void
      {
         this.ProcessorWindowsSwitch(this.FProcessorDice);
      }
      
      protected function ProcessorshortcutsOnConsumeRank(param1:Object) : void
      {
         this.ProcessorWindowsSwitch(this.FProcessorConsumeRank);
      }
      
      protected function ProcessorshortcutsOnRechargeRank(param1:Object) : void
      {
         this.ProcessorWindowsSwitch(this.FProcessorRechargeRank);
      }
      
      protected function ProcessorShortcutsOnCommonRecharge(param1:Object) : void
      {
         this.ProcessorWindowsSwitch(this.FProcessorCommonRecharge);
      }
      
      protected function ProcessorShortcutsOnVIPFreeBuy(param1:Object) : void
      {
         this.ProcessorWindowsSwitch(this.FProcessorVIPFreeBuy);
      }
      
      protected function ProcessorShortcutsOnSeventhEvening(param1:Object) : void
      {
         this.ProcessorWindowsSwitch(this.FProcessorSeventhEvening);
      }
      
      protected function ProcessorShortcutsOnHappyTreasure(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(CONST_BASEACTIVITY.TYPE_NewActiveList_HappyTreasure);
         _loc2_.position = 0;
         this.ProcessorWindowsSwitch(this.FProcessorActivityManager,_loc2_);
      }
      
      protected function ProcessorShortcutsOnGroupBuying(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(CONST_BASEACTIVITY.TYPE_NewActiveList_GroupBuying);
         _loc2_.position = 0;
         this.ProcessorWindowsSwitch(this.FProcessorActivityManager,_loc2_);
      }
      
      protected function ProcessorShortcutsOnRechargeExchange(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(CONST_BASEACTIVITY.TYPE_NewActiveList_RechargeExchange);
         _loc2_.position = 0;
         this.ProcessorWindowsSwitch(this.FProcessorActivityManager,_loc2_);
      }
      
      protected function ProcessorShortcutsOnOrangeEquipment(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(CONST_BASEACTIVITY.TYPE_NewActiveList_OrangeEquipment);
         _loc2_.position = 0;
         this.ProcessorWindowsSwitch(this.FProcessorActivityManager,_loc2_);
      }
      
      protected function ProcessorShortcutsOnMidAutumn(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(CONST_BASEACTIVITY.TYPE_NewActiveList_MidAutumn);
         _loc2_.position = 0;
         this.ProcessorWindowsSwitch(this.FProcessorActivityManager,_loc2_);
      }
      
      protected function ProcessorShortcutsOnDiscount(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(CONST_BASEACTIVITY.TYPE_NewActiveList_Discount);
         _loc2_.position = 0;
         this.ProcessorWindowsSwitch(this.FProcessorActivityManager,_loc2_);
      }
      
      protected function ProcessorShortcutsOnRechargeGive(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(CONST_BASEACTIVITY.TYPE_NewActiveList_RechargeGive);
         _loc2_.position = 0;
         this.ProcessorWindowsSwitch(this.FProcessorActivityManager,_loc2_);
      }
      
      protected function ProcessorShortcutsOnNationalDay(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(CONST_BASEACTIVITY.TYPE_NewActiveList_NationalDay);
         _loc2_.position = 0;
         this.ProcessorWindowsSwitch(this.FProcessorActivityManager,_loc2_);
      }
      
      protected function ProcessorShortcutsOnTreasureBox(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(CONST_BASEACTIVITY.TYPE_NewActiveList_TreasureBox);
         _loc2_.position = 0;
         this.ProcessorWindowsSwitch(this.FProcessorActivityManager,_loc2_);
      }
      
      protected function ProcessorShortcutsOnHallowmas(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(CONST_BASEACTIVITY.TYPE_NewActiveList_Hallowmas);
         _loc2_.position = 0;
         this.ProcessorWindowsSwitch(this.FProcessorActivityManager,_loc2_);
      }
      
      protected function ProcessorShortcutsOnInviteFriend(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(CONST_BASEACTIVITY.TYPE_NewActiveList_InviteFriend);
         _loc2_.position = 0;
         this.ProcessorWindowsSwitch(this.FProcessorActivityManager,_loc2_);
      }
      
      protected function ProcessorShortcutsOnGuaGuaLe(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(CONST_BASEACTIVITY.TYPE_NewActiveList_GuaGuaLe);
         _loc2_.position = 0;
         this.ProcessorWindowsSwitch(this.FProcessorActivityManager,_loc2_);
      }
      
      protected function ProcessorShortcutsOnWishTree(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(CONST_BASEACTIVITY.TYPE_NewActiveList_WishTree);
         _loc2_.position = 0;
         this.ProcessorWindowsSwitch(this.FProcessorActivityManager,_loc2_);
      }
      
      protected function ProcessorShortcutsOnEverydaySale(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(CONST_BASEACTIVITY.TYPE_NewActiveList_EverydaySale);
         _loc2_.position = 0;
         this.ProcessorWindowsSwitch(this.FProcessorActivityManager,_loc2_);
      }
      
      protected function ProcessorShortcutsOnVipTreasure(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(CONST_BASEACTIVITY.TYPE_NewActiveList_VipTreasure);
         _loc2_.position = 0;
         this.ProcessorWindowsSwitch(this.FProcessorActivityManager,_loc2_);
      }
      
      protected function ProcessorShortcutsOnCrossServerSale(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(CONST_BASEACTIVITY.TYPE_NewActiveList_CrossServerSale);
         _loc2_.position = 0;
         this.ProcessorWindowsSwitch(this.FProcessorActivityManager,_loc2_);
      }
      
      protected function ProcessorShortcutsOnNewYear(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(CONST_BASEACTIVITY.TYPE_NewActiveList_NewYear);
         _loc2_.position = 0;
         this.ProcessorWindowsSwitch(this.FProcessorActivityManager,_loc2_);
      }
      
      protected function ProcessorShortcutsOnShowMore(param1:Object) : void
      {
         SLogicsCore.ShowMoreActivities = !SLogicsCore.ShowMoreActivities;
         SLogicsCore.NewActivityModes.SetActivityStatus(CONST_SHORTCUTS.TYPE_NewActiveList_ShowMore,false);
         SLogicsCore.NewActivityModes.SetActivityStatus(CONST_SHORTCUTS.TYPE_NewActiveList_HideMore,true);
         this.ProcessorOnOpenNewActivityList();
      }
      
      protected function ProcessorShortcutsOnHideMore(param1:Object) : void
      {
         SLogicsCore.ShowMoreActivities = !SLogicsCore.ShowMoreActivities;
         SLogicsCore.NewActivityModes.SetActivityStatus(CONST_SHORTCUTS.TYPE_NewActiveList_ShowMore,true);
         SLogicsCore.NewActivityModes.SetActivityStatus(CONST_SHORTCUTS.TYPE_NewActiveList_HideMore,false);
         this.ProcessorOnOpenNewActivityList();
      }
      
      protected function ProcessorShortcutsOnActivityA(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(CONST_BASEACTIVITY.TYPE_NewActiveList_ActivityA);
         _loc2_.position = 0;
         this.ProcessorWindowsSwitch(this.FProcessorActivityManager,_loc2_);
      }
      
      protected function ProcessorShortcutsOnActivityB(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(CONST_BASEACTIVITY.TYPE_NewActiveList_ActivityB);
         _loc2_.position = 0;
         this.ProcessorWindowsSwitch(this.FProcessorActivityManager,_loc2_);
      }
      
      protected function ProcessorShortcutsOnBlackMarket(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(CONST_BASEACTIVITY.TYPE_NewActiveList_BlackMarket);
         _loc2_.position = 0;
         this.ProcessorWindowsSwitch(this.FProcessorActivityManager,_loc2_);
      }
      
      protected function ProcessorShortcutsOnNinjaMeeting(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(CONST_BASEACTIVITY.TYPE_NewActiveList_NinjaMeeting);
         _loc2_.position = 0;
         this.ProcessorWindowsSwitch(this.FProcessorActivityManager,_loc2_);
      }
      
      protected function ProcessorShortcutsOnFortuneCat(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(CONST_BASEACTIVITY.TYPE_NewActiveList_FortuneCat);
         _loc2_.position = 0;
         this.ProcessorWindowsSwitch(this.FProcessorActivityManager,_loc2_);
      }
      
      protected function ProcessorShortcutsOnTowerLottery(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(CONST_BASEACTIVITY.TYPE_NewActiveList_TowerLottery);
         _loc2_.position = 0;
         this.ProcessorWindowsSwitch(this.FProcessorActivityManager,_loc2_);
      }
      
      protected function ProcessorShortcutsOnSingleTopUp(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(CONST_BASEACTIVITY.TYPE_NewActiveList_SingleTopUp);
         _loc2_.position = 0;
         this.ProcessorWindowsSwitch(this.FProcessorActivityManager,_loc2_);
      }
      
      protected function ProcessorShortcutsOnMyActive(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(CONST_BASEACTIVITY.TYPE_NewActiveList_MuYeJuJiuWu);
         _loc2_.position = 0;
         this.ProcessorWindowsSwitch(this.FProcessorActivityManager,_loc2_);
      }
      
      protected function ProcessorShortcutsOnSuperEquip(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(CONST_BASEACTIVITY.TYPE_NewActiveList_SuperEquip);
         _loc2_.position = 0;
         this.ProcessorWindowsSwitch(this.FProcessorActivityManager,_loc2_);
      }
      
      protected function ProcessorShortcutsOnCreationAncestor(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(CONST_BASEACTIVITY.TYPE_NewActiveList_CreationAncestor);
         _loc2_.position = 0;
         this.ProcessorWindowsSwitch(this.FProcessorActivityManager,_loc2_);
      }
      
      protected function ProcessorShortcutsOnBindEmail(param1:Object) : void
      {
         this.ProcessorWindowsSwitch(this.FProcessorBindEmail);
      }
      
      protected function ProcessorShortcutsOnDouble11Mall(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(CONST_BASEACTIVITY.TYPE_NewActiveList_Double11Mall);
         _loc2_.position = 0;
         this.ProcessorWindowsSwitch(this.FProcessorActivityManager,_loc2_);
      }
      
      protected function ProcessorShortcutsOnLevelGifts(param1:Object) : void
      {
         this.ProcessorWindowsSwitch(this.FProcessorHeroLevelGifts);
      }
      
      protected function ProcessorShortcutsOnDayRechargeGift(param1:Object) : void
      {
         this.ProcessorWindowsSwitch(this.FProcessorDayRechargeGift);
      }
      
      protected function ProcessorShortcutsOnOneWorthThousand(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(CONST_BASEACTIVITY.TYPE_NewActiveList_OneWorthThousand);
         _loc2_.position = 0;
         this.ProcessorWindowsSwitch(this.FProcessorActivityManager,_loc2_);
      }
      
      protected function ProcessorShortcutsOnPaymentWall(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(CONST_BASEACTIVITY.TYPE_NewActiveList_PaymentWall);
         _loc2_.position = 0;
         this.ProcessorWindowsSwitch(this.FProcessorActivityManager,_loc2_);
      }
      
      protected function ProcessorShortcutsOnNinjaBank(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(CONST_BASEACTIVITY.TYPE_NewActiveList_NinjaBank);
         _loc2_.position = 0;
         this.ProcessorWindowsSwitch(this.FProcessorActivityManager,_loc2_);
      }
      
      protected function ProcessorShortcutsOnFirstRecharge_New(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(CONST_BASEACTIVITY.TYPE_NewActiveList_FirstRecharge_new);
         _loc2_.position = 0;
         this.ProcessorWindowsSwitch(this.FProcessorActivityManager,_loc2_);
      }
      
      protected function ProcessorShortcutsOnComeBack(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(CONST_BASEACTIVITY.TYPE_NewActiveList_ComeBack);
         _loc2_.position = 0;
         this.ProcessorWindowsSwitch(this.FProcessorActivityManager,_loc2_);
      }
      
      protected function ProcessorShortcutsOnDessertHouse(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(CONST_BASEACTIVITY.TYPE_NewActiveList_DessertHouse);
         _loc2_.position = 0;
         this.ProcessorWindowsSwitch(this.FProcessorActivityManager,_loc2_);
      }
      
      protected function ProcessorShortcutsOnNewLottery(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(CONST_BASEACTIVITY.TYPE_NewActiveList_NewLottery);
         _loc2_.position = 0;
         this.ProcessorWindowsSwitch(this.FProcessorActivityManager,_loc2_);
      }
      
      protected function ProcessorShortcutsOnDailyRecharge(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(CONST_BASEACTIVITY.TYPE_NewActiveList_DailyRecharge);
         _loc2_.position = 0;
         this.ProcessorWindowsSwitch(this.FProcessorActivityManager,_loc2_);
      }
      
      protected function ProcessorShortcutsOnCloudBuy(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(CONST_BASEACTIVITY.TYPE_NewActiveList_CloudBuy);
         _loc2_.position = 0;
         this.ProcessorWindowsSwitch(this.FProcessorActivityManager,_loc2_);
      }
      
      protected function ProcessorShortcutsOnFerrisWheel(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(CONST_BASEACTIVITY.TYPE_NewActiveList_FerrisWheel);
         _loc2_.position = 0;
         this.ProcessorWindowsSwitch(this.FProcessorActivityManager,_loc2_);
      }
      
      protected function ProcessorShortcutsOnMarchConsume(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(CONST_BASEACTIVITY.TYPE_NewActiveList_MarchConsume);
         _loc2_.position = 0;
         this.ProcessorWindowsSwitch(this.FProcessorActivityManager,_loc2_);
      }
      
      protected function ProcessorShortcutsOnCapsuleToys(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(CONST_BASEACTIVITY.TYPE_NewActiveList_CapsuleToys);
         _loc2_.position = 0;
         this.ProcessorWindowsSwitch(this.FProcessorActivityManager,_loc2_);
      }
      
      protected function ProcessorShortcutsOnGoldDigger(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(CONST_BASEACTIVITY.TYPE_NewActiveList_GoldDigger);
         _loc2_.position = 0;
         this.ProcessorWindowsSwitch(this.FProcessorActivityManager,_loc2_);
      }
      
      protected function ProcessorShortcutsOnPersiaTrader(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(CONST_BASEACTIVITY.TYPE_NewActiveList_PersiaTrader);
         _loc2_.position = 0;
         this.ProcessorWindowsSwitch(this.FProcessorActivityManager,_loc2_);
      }
      
      protected function ProcessorShortcutsOnAncientTreasure(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(CONST_BASEACTIVITY.TYPE_NewActiveList_AncientTreasure);
         _loc2_.position = 0;
         this.ProcessorWindowsSwitch(this.FProcessorActivityManager,_loc2_);
      }
      
      protected function ProcessorShortcutsOnCornucopia(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(CONST_BASEACTIVITY.TYPE_NewActiveList_Cornucopia);
         _loc2_.position = 0;
         this.ProcessorWindowsSwitch(this.FProcessorActivityManager,_loc2_);
      }
      
      protected function ProcessorShortcutsOnGoldTree(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(CONST_BASEACTIVITY.TYPE_NewActiveList_GoldTree);
         _loc2_.position = 0;
         this.ProcessorWindowsSwitch(this.FProcessorActivityManager,_loc2_);
      }
      
      protected function ProcessorShortcutsOnAlchemyStudio(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(CONST_BASEACTIVITY.TYPE_NewActiveList_AlchemyStudio);
         _loc2_.position = 0;
         this.ProcessorWindowsSwitch(this.FProcessorActivityManager,_loc2_);
      }
      
      protected function ProcessorShortcutsOnGodWelfare(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(CONST_BASEACTIVITY.TYPE_NewActiveList_GodWelfare);
         _loc2_.position = 0;
         this.ProcessorWindowsSwitch(this.FProcessorActivityManager,_loc2_);
      }
      
      protected function ProcessorShortcutsOnIdolumFight(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(CONST_BASEACTIVITY.TYPE_NewActiveList_IdolumFight);
         _loc2_.position = 0;
         this.ProcessorWindowsSwitch(this.FProcessorActivityManager,_loc2_);
      }
      
      protected function ProcessorShortcutsOnBejeweled(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(CONST_BASEACTIVITY.TYPE_NewActiveList_Bejeweled);
         _loc2_.position = 0;
         this.ProcessorWindowsSwitch(this.FProcessorActivityManager,_loc2_);
      }
      
      protected function ProcessorShortcutsOnExorcism(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(CONST_BASEACTIVITY.TYPE_NewActiveList_Exorcism);
         _loc2_.position = 0;
         this.ProcessorWindowsSwitch(this.FProcessorActivityManager,_loc2_);
      }
      
      protected function ProcessorShortcutsOnNinjaCrystal(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(CONST_BASEACTIVITY.TYPE_NewActiveList_NinjaCrystal);
         _loc2_.position = 0;
         this.ProcessorWindowsSwitch(this.FProcessorActivityManager,_loc2_);
      }
      
      protected function ProcessorShortcutsOnBossTreasure(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(CONST_BASEACTIVITY.TYPE_NewActiveList_BossTreasure);
         _loc2_.position = 0;
         this.ProcessorWindowsSwitch(this.FProcessorActivityManager,_loc2_);
      }
      
      protected function ProcessorShortcutsOnLoginGift(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(CONST_BASEACTIVITY.TYPE_NewActiveList_LoginGift);
         _loc2_.position = 0;
         this.ProcessorWindowsSwitch(this.FProcessorActivityManager,_loc2_);
      }
      
      protected function ProcessorShortcutsOnDailyFirstRecharge(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(CONST_BASEACTIVITY.TYPE_NewActiveList_DailyFirstRecharge);
         _loc2_.position = 0;
         this.ProcessorWindowsSwitch(this.FProcessorActivityManager,_loc2_);
      }
      
      protected function ProcessorShortcutsOnWanSheng(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(CONST_BASEACTIVITY.TYPE_NewActiveList_WanSheng);
         _loc2_.position = 0;
         this.ProcessorWindowsSwitch(this.FProcessorActivityManager,_loc2_);
      }
      
      protected function ProcessorShortcutsOnThanksgivingDay(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(CONST_BASEACTIVITY.TYPE_NewActiveList_ThanksgivingDay);
         _loc2_.position = 0;
         this.ProcessorWindowsSwitch(this.FProcessorActivityManager,_loc2_);
      }
      
      protected function ProcessorShortcutsOnNov(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(CONST_BASEACTIVITY.TYPE_NewActiveList_Nov);
         _loc2_.position = 0;
         this.ProcessorWindowsSwitch(this.FProcessorActivityManager,_loc2_);
      }
      
      protected function ProcessorShortcutsOnChristmas2015(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(CONST_BASEACTIVITY.TYPE_NewActiveList_Christmas2015);
         _loc2_.position = 0;
         this.ProcessorWindowsSwitch(this.FProcessorActivityManager,_loc2_);
      }
      
      protected function ProcessorShortcutsOnJanActive2016(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(CONST_BASEACTIVITY.TYPE_NewActiveList_JanActive2016);
         _loc2_.position = 0;
         this.ProcessorWindowsSwitch(this.FProcessorActivityManager,_loc2_);
      }
      
      protected function ProcessorShortcutsOnSignGift(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(CONST_BASEACTIVITY.TYPE_NewActiveList_SignGift);
         _loc2_.position = 0;
         this.ProcessorWindowsSwitch(this.FProcessorActivityManager,_loc2_);
      }
      
      protected function ProcessorShortcutsOnFateRoulette(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(CONST_BASEACTIVITY.TYPE_NewActiveList_FateRoulette);
         _loc2_.position = 0;
         this.ProcessorWindowsSwitch(this.FProcessorActivityManager,_loc2_);
      }
      
      protected function ProcessorShortcutsOnWanSheng2(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(CONST_BASEACTIVITY.TYPE_NewActiveList_WanSheng2);
         _loc2_.position = 0;
         this.ProcessorWindowsSwitch(this.FProcessorActivityManager,_loc2_);
      }
      
      protected function ProcessorShortcutsOnNinjaFund(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(CONST_BASEACTIVITY.TYPE_NewActiveList_NinjaFund);
         _loc2_.position = 0;
         this.ProcessorWindowsSwitch(this.FProcessorActivityManager,_loc2_);
      }
      
      protected function ProcessorShortcutsOnCatWomen(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(CONST_BASEACTIVITY.TYPE_NewActiveList_CatWomen);
         _loc2_.position = 0;
         this.ProcessorWindowsSwitch(this.FProcessorActivityManager,_loc2_);
      }
      
      protected function ProcessorShortcutsOnLotteryMachine(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(CONST_BASEACTIVITY.TYPE_NewActiveList_LotteryMachine);
         _loc2_.position = 0;
         this.ProcessorWindowsSwitch(this.FProcessorActivityManager,_loc2_);
      }
      
      protected function ProcessorShortcutsOnMoonFestival(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(CONST_BASEACTIVITY.TYPE_ActiveListThird_MoonFestival);
         _loc2_.position = 0;
         this.ProcessorWindowsSwitch(this.FProcessorActivityManager,_loc2_);
      }
      
      protected function ProcessorShortcutsOnNationDay2015(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(CONST_BASEACTIVITY.TYPE_ActiveListThird_NationDay_2015);
         _loc2_.position = 0;
         this.ProcessorWindowsSwitch(this.FProcessorActivityManager,_loc2_);
      }
      
      protected function ProcessorShortcutsOnHallowmasActive(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(CONST_BASEACTIVITY.TYPE_ActiveListThird_HallowmasActive);
         _loc2_.position = 0;
         this.ProcessorWindowsSwitch(this.FProcessorActivityManager,_loc2_);
      }
      
      protected function ProcessorShortcutsOnSuperChristmas(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(CONST_BASEACTIVITY.TYPE_NewActiveList_SuperChristmas);
         _loc2_.position = 0;
         this.ProcessorWindowsSwitch(this.FProcessorActivityManager,_loc2_);
      }
      
      protected function ProcessorOnGmUp() : void
      {
         this.ProcessorWindowsSwitch(this.FProcessorBugList);
      }
      
      protected function ProcessorShortcutsOnChristmas(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(CONST_BASEACTIVITY.TYPE_ActiveListThird_Christmas);
         _loc2_.position = 0;
         this.ProcessorWindowsSwitch(this.FProcessorActivityManager,_loc2_);
      }
      
      protected function ProcessorShortcutsOnSpringFestival(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(CONST_BASEACTIVITY.TYPE_ActiveListThird_SpringFestival);
         _loc2_.position = 0;
         this.ProcessorWindowsSwitch(this.FProcessorActivityManager,_loc2_);
      }
      
      protected function ProcessorShortcutsOnValentineDay(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(CONST_BASEACTIVITY.TYPE_ActiveListThird_ValentineDay);
         _loc2_.position = 0;
         this.ProcessorWindowsSwitch(this.FProcessorActivityManager,_loc2_);
      }
      
      protected function ProcessorShortcutsOnFightBoss(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(CONST_BASEACTIVITY.TYPE_ActiveListThird_FightBoss);
         _loc2_.position = 0;
         this.ProcessorWindowsSwitch(this.FProcessorActivityManager,_loc2_);
      }
      
      protected function ProcessorShortcutsOnBrazilCarnival(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(CONST_BASEACTIVITY.TYPE_ActiveListThird_BrazilCarnival);
         _loc2_.position = 0;
         this.ProcessorWindowsSwitch(this.FProcessorActivityManager,_loc2_);
      }
      
      protected function ProcessorShortcutsOnNinjaTreasure(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(CONST_BASEACTIVITY.TYPE_ActiveListThird_NinjaTreasure);
         _loc2_.position = 0;
         this.ProcessorWindowsSwitch(this.FProcessorActivityManager,_loc2_);
      }
      
      protected function ProcessorShortcutsOnMayActive(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(CONST_BASEACTIVITY.TYPE_ActiveListThird_MayActive);
         _loc2_.position = 0;
         this.ProcessorWindowsSwitch(this.FProcessorActivityManager,_loc2_);
      }
      
      protected function ProcessorShortcutsOnJuneActive(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(CONST_BASEACTIVITY.TYPE_ActiveListThird_JuneActive);
         _loc2_.position = 0;
         this.ProcessorWindowsSwitch(this.FProcessorActivityManager,_loc2_);
      }
      
      protected function ProcessorShortcutsOnJulyActive(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(CONST_BASEACTIVITY.TYPE_ActiveListThird_JulyActive);
         _loc2_.position = 0;
         this.ProcessorWindowsSwitch(this.FProcessorActivityManager,_loc2_);
      }
      
      protected function ProcessorShortcutsOnAugustActive(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(CONST_BASEACTIVITY.TYPE_ActiveListThird_AugustActive);
         _loc2_.position = 0;
         this.ProcessorWindowsSwitch(this.FProcessorActivityManager,_loc2_);
      }
      
      protected function ProcessorShortcutsOnSeptemberActive(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(CONST_BASEACTIVITY.TYPE_ActiveListThird_SeptemberActive);
         _loc2_.position = 0;
         this.ProcessorWindowsSwitch(this.FProcessorActivityManager,_loc2_);
      }
      
      protected function ProcessorShortcutsOnOctActive(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(CONST_BASEACTIVITY.TYPE_ActiveListThird_OctActive);
         _loc2_.position = 0;
         this.ProcessorWindowsSwitch(this.FProcessorActivityManager,_loc2_);
      }
      
      protected function ProcessorShortcutsOnNovActive(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(CONST_BASEACTIVITY.TYPE_ActiveListThird_NovActive);
         _loc2_.position = 0;
         this.ProcessorWindowsSwitch(this.FProcessorActivityManager,_loc2_);
      }
      
      protected function ProcessorShortcutsOnDecActive(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(CONST_BASEACTIVITY.TYPE_ActiveListThird_DecActive);
         _loc2_.position = 0;
         this.ProcessorWindowsSwitch(this.FProcessorActivityManager,_loc2_);
      }
      
      protected function ProcessorShortcutsOnJanActive(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(CONST_BASEACTIVITY.TYPE_ActiveListThird_JanActive);
         _loc2_.position = 0;
         this.ProcessorWindowsSwitch(this.FProcessorActivityManager,_loc2_);
      }
      
      protected function ProcessorShortcutsOnFebActive(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(CONST_BASEACTIVITY.TYPE_ActiveListThird_FebActive);
         _loc2_.position = 0;
         this.ProcessorWindowsSwitch(this.FProcessorActivityManager,_loc2_);
      }
      
      protected function ProcessorShortcutsOnMarchActive(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(CONST_BASEACTIVITY.TYPE_ActiveListThird_MarchActive);
         _loc2_.position = 0;
         this.ProcessorWindowsSwitch(this.FProcessorActivityManager,_loc2_);
      }
      
      protected function ProcessorShortcutsOnAprilActive(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(CONST_BASEACTIVITY.TYPE_ActiveListThird_AprilActive);
         _loc2_.position = 0;
         this.ProcessorWindowsSwitch(this.FProcessorActivityManager,_loc2_);
      }
      
      protected function ProcessorShortcutsOnMayActive2015(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(CONST_BASEACTIVITY.TYPE_ActiveListThird_MayActive_2015);
         _loc2_.position = 0;
         this.ProcessorWindowsSwitch(this.FProcessorActivityManager,_loc2_);
      }
      
      protected function ProcessorShortcutsOnSantaClaus(param1:Object) : void
      {
         this.ProcessorWindowsSwitch(this.FProcessorSantaClaus,null);
      }
      
      protected function ProcessorShortcutsOnNinjiaVillage(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(CONST_BASEACTIVITY.TYPE_ActiveListThird_NinjiaVillage);
         _loc2_.position = 0;
         this.ProcessorWindowsSwitch(this.FProcessorActivityManager,_loc2_);
      }
      
      protected function ProcessorShortcutsOnNov2016(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(CONST_BASEACTIVITY.TYPE_ActiveListThird_Nov2016);
         _loc2_.position = 0;
         this.ProcessorWindowsSwitch(this.FProcessorActivityManager,_loc2_);
      }
      
      protected function ProcessorShortcutsOnWitchProving(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(CONST_BASEACTIVITY.TYPE_ActiveListThird_WitchProving);
         _loc2_.position = 0;
         this.ProcessorWindowsSwitch(this.FProcessorActivityManager,_loc2_);
      }
      
      protected function ProcessorShortcutsOnChristmas2016(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(CONST_BASEACTIVITY.TYPE_NewActiveList_Christmas2016);
         _loc2_.position = 0;
         this.ProcessorWindowsSwitch(this.FProcessorActivityManager,_loc2_);
      }
      
      protected function ProcessorShortcutsOnWorldCup(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(CONST_BASEACTIVITY.TYPE_NewActiveList_WorldCup);
         _loc2_.position = 0;
         this.ProcessorWindowsSwitch(this.FProcessorActivityManager,_loc2_);
      }
      
      protected function ProcessorShortcutsOnNewSpring2018(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(CONST_BASEACTIVITY.TYPE_ActiveListThird_NewSpring2018);
         _loc2_.position = 0;
         this.ProcessorWindowsSwitch(this.FProcessorActivityManager,_loc2_);
      }
      
      protected function ProcessorShortcutsOnSmelt(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(CONST_BASEACTIVITY.TYPE_ActiveListThird_Smelt);
         _loc2_.position = 0;
         this.ProcessorWindowsSwitch(this.FProcessorActivityManager,_loc2_);
      }
      
      protected function ProcessorShortcutsOnChristmasDay(param1:Object) : void
      {
         this.ProcessorWindowsSwitch(this.FProcessorChristmasDay);
      }
      
      protected function ProcessorShortcutsOnLeadLevelGifts(param1:Object) : void
      {
         this.ProcessorWindowsSwitch(this.FProcessorLeadLevelGifts);
      }
      
      protected function ProcessorShortcutsOnTenTail(param1:Object) : void
      {
         this.ProcessorWindowsSwitch(this.FProcessorTenTail);
      }
      
      protected function ProcessorShortcutsOnFirstDayGiftBag(param1:Object) : void
      {
         this.FProcessorGiftBag.MajorActiveID = 3;
         this.ProcessorWindowsSwitch(this.FProcessorGiftBag);
      }
      
      protected function ProcessorShortcutsOnOnLineGiftBag(param1:Object) : void
      {
         this.FProcessorGiftBag.OnGiftBagClick(1);
      }
      
      protected function ProcessorShortcutsOnGoldGiftBag(param1:Object) : void
      {
         this.FProcessorGiftBag.OnGiftBagClick(2);
      }
      
      protected function ProcessorShortcutsOn7DayGiftBag(param1:Object) : void
      {
         this.FProcessorGiftBag.MajorActiveID = 4;
         this.ProcessorWindowsSwitch(this.FProcessorGiftBag);
      }
      
      protected function ProcessorShortcutsOnHFRewardg(param1:Object) : void
      {
         this.FProcessorGiftBag.MajorActiveID = 5;
         this.ProcessorWindowsSwitch(this.FProcessorGiftBag);
      }
      
      protected function ProcessorShortcutsOnLevelGift(param1:Object) : void
      {
         this.FProcessorGiftBag.MajorActiveID = 6;
         this.ProcessorWindowsSwitch(this.FProcessorGiftBag);
      }
      
      protected function ProcessorShortcutsOnCollectGame(param1:Object) : void
      {
         this.FProcessorGiftBag.MajorActiveID = 7;
         this.ProcessorWindowsSwitch(this.FProcessorGiftBag);
      }
      
      protected function ProcessorShortcutsIntoAutoBattle(param1:Object, param2:Boolean, param3:uint) : void
      {
         this.FProcessorShortcuts.SetIntoAutoBattle(param1,param2,param3);
      }
      
      protected function ProcessorWindowsOnMilitary(param1:Object) : void
      {
         this.FProcessorMainScene.UpdateMilitaryRank();
      }
      
      protected function ProcessorsUpdatePet(param1:Object) : void
      {
         this.FProcessorShortcuts.UserUpdatePet();
         this.FProcessorMainScene.UpdatePet();
         if(SLogicsCore.Character.RoleSencePosition == CONST_COMMON.SCENEPOSITION_FightPet)
         {
            this.FProcessorFightPet.UpdatePet();
         }
         else if(SLogicsCore.Character.RoleSencePosition == CONST_COMMON.SCENEPOSITION_CityDefend)
         {
            this.FProcessorCityDefend.UpdatePet();
         }
         else if(SLogicsCore.Character.RoleSencePosition == CONST_COMMON.SCENEPOSITION_TraitorAttack)
         {
            this.FProcessorTraitorAttack.UpdatePet();
         }
         else if(SLogicsCore.Character.RoleSencePosition == CONST_COMMON.SCENEPOSITION_FightAnimal)
         {
            this.FProcessorAnimalSeal.UpdatePet();
         }
      }
      
      protected function ProcessorOnAutoSearchWay(param1:Object) : void
      {
         this.FProcessorMainScene.AutoSearchWay(param1);
      }
      
      protected function ProcessorOnGotoCityDoor(param1:Object) : void
      {
         this.FProcessorMainScene.GotoCityDoor();
      }
      
      protected function GoToHerosFightWindow(param1:Object) : void
      {
         this.ProcessorOnReturnNijiaBattle(param1);
      }
      
      protected function ProcessorAccountOnUserUpdateBaseInfo(param1:Object) : void
      {
         this.FProcessorShortcuts.UserUpdateCharBaseInfo();
         this.FProcessorHeros.UserUpdateCharBaseInfo();
         this.ProcessorCheckPopTips(param1);
      }
      
      protected function ProcessorTotalFightingPowerReq(param1:Object, param2:uint = 0) : void
      {
         var _loc3_:TPacket = null;
         var _loc4_:ByteArray = null;
         _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Account_UserFightVauleReq);
         _loc4_ = _loc3_.Data;
         _loc4_.writeUnsignedInt(1);
         _loc4_.writeUnsignedInt(param2);
         SNetworkCore.Transceiver.PacketTransmit(_loc3_);
      }
      
      protected function ProcessorAccountOnUserUpdateVipInfo(param1:Object) : void
      {
         this.FProcessorVIP.UserUpdateCharVipInfo();
         this.FProcessorDailyWelfare.VipLevelUpCheckRewardStatus();
         this.FProcessorWindowAccessory.VipLevelUpCheckBtnStatus();
         this.FProcessorSmithy.VipLevelUpCheckBtnStatus();
         this.UpdateHeroProperty();
      }
      
      protected function ProcessorsOnInitConsumeVip(param1:Object) : void
      {
         this.FProcessorShortcuts.UserUpdateConsumeVip();
      }
      
      protected function ProcessorOnLoadMilitaryInfor(param1:Object) : void
      {
         this.FProcessorProtagonist.LoadMilitaryInfor();
      }
      
      protected function ProcessorOnInitQuests(param1:Object) : void
      {
         this.FProcessorQuest.InitQuests();
      }
      
      protected function ProcessorOnUpdatePrestige(param1:Object) : void
      {
         this.FProcessorProtagonist.UpdatePrestige();
      }
      
      protected function SetProcessorDailyActivityStatus(param1:Object, param2:uint, param3:uint) : void
      {
         this.FProcessorDailyActivity.SetActivityStatus(param2,param3);
         this.FProcessorMainScene.SetActivityStatus(param2,param3);
      }
      
      protected function ProcessorOnAutoEnterActivity(param1:Object, param2:uint, param3:Boolean) : void
      {
         if(param2 == CONST_ORGANIZATION.TYPE_ORGACTIVITY_TRAITORATTACK)
         {
            this.OpenThisPanelF(3);
         }
         else
         {
            this.OpenThisPanelF(0);
         }
         this.FProcessorDailyActivity.EnterActivity(param2);
         if(param3)
         {
            this.FProcessorShortcuts.SetAutoStatus(param1,true,false,SLogicsCore.Character.VipData.ArenaSkip);
         }
      }
      
      protected function SetOrgActivityEnd(param1:Object, param2:uint, param3:uint) : void
      {
         this.FProcessorOrganization.OnSetOrgActivity(param2,param3);
      }
      
      protected function ProcessorAccountOnUserUpdateStrengthenCD(param1:Object) : void
      {
         this.FProcessorSmithy.UpdateCDTime();
         this.FProcessorArena.UpdateCDTime();
      }
      
      protected function ProcessorShortcutsOnEnterWorldMap(param1:Object) : void
      {
         this.ProcessorPlateSwitch(this.FProcessorWorldMap);
         this.FProcessorFreshGuide.EnterOtherScene();
      }
      
      protected function ProcessorShortcutsOnQuestBtnClick(param1:Object) : void
      {
         this.ProcessorWindowsSwitch(this.FProcessorQuest);
      }
      
      protected function ProcessorShortcutsOnAvaterHeadClick(param1:Object, param2:ByteArray = null) : void
      {
         if(SLogicsCore.Character.RoleSencePosition == CONST_COMMON.SCENEPOSITION_BATTLESENCE_AUTO)
         {
            return;
         }
         this.ProcessorWindowsSwitch(this.FProcessorProtagonist,param2);
      }
      
      protected function ProcessorShortcutsHerosOnClick(param1:Object, param2:ByteArray = null) : void
      {
         this.ProcessorWindowsSwitch(this.FProcessorHeros,param2);
      }
      
      protected function ProcessorShortcutsGeneralStarOnClick(param1:Object, param2:ByteArray = null) : void
      {
         this.ProcessorWindowsSwitch(this.FProcessorGeneralStar,param2);
      }
      
      protected function ProcessorShortcutsTacticalDeploymentOnClick(param1:Object, param2:ByteArray = null) : void
      {
         this.ProcessorWindowsSwitch(this.FProcessorTacticalDeployment,param2);
      }
      
      protected function ProcessorShortcutsInheritPracticeOnClick(param1:Object, param2:ByteArray = null) : void
      {
         this.ProcessorWindowsSwitch(this.FPocessorNinJaPractice,param2);
      }
      
      protected function ProcessorShortcutsLandlordsOnClick(param1:Object) : void
      {
         this.ProcessorWindowsSwitch(null);
      }
      
      protected function ProcessorShortcutsBackpackOnClick(param1:Object, param2:ByteArray = null) : void
      {
         this.ProcessorWindowsSwitch(this.FProcessorBackpack,param2);
      }
      
      protected function ProcessorShortcutsTreasureOnClick(param1:Object, param2:ByteArray = null) : void
      {
         this.ProcessorWindowsSwitch(this.FProcessorTalisman,param2);
      }
      
      protected function ProcessorShortcutsSummonPetOnClick(param1:Object, param2:ByteArray = null) : void
      {
         this.ProcessorWindowsSwitch(this.FProcessorPet,param2);
      }
      
      protected function ProcessorShortcutsHomelandOnClick(param1:Object, param2:ByteArray = null) : void
      {
         this.ProcessorWindowsSwitch(this.FProcessorHomeland,param2);
      }
      
      protected function ProcessorGotoSoulFormation(param1:Object, param2:ByteArray = null) : void
      {
         var _loc3_:ByteArray = null;
         _loc3_ = new ByteArray();
         _loc3_.writeUnsignedInt(3);
         _loc3_.position = 0;
         this.ProcessorWindowsSwitch(this.FProcessorPet,_loc3_);
      }
      
      protected function ProcessorShortcutsVipOnClick(param1:Object) : void
      {
         this.ProcessorWindowsSwitch(this.FProcessorVIP);
      }
      
      protected function ProcessorOnPromote(param1:Object) : void
      {
         this.ProcessorWindowsSwitch(this.FProcessorShinobidoPractise);
      }
      
      protected function ProcessorOnEnterAutoBattle(param1:Object) : void
      {
         if(SLogicsCore.Character.RoleSencePosition == CONST_COMMON.SCENEPOSITION_BATTLESENCE_AUTO)
         {
            this.FProcessorWorldMap.OnEnterAutoBattle(param1);
         }
         else
         {
            this.ProcessorShortcutsOnEnterWorldMap(param1);
         }
      }
      
      protected function ProcesorWelfareOnClick(param1:Object) : void
      {
         this.ProcessorWindowsSwitch(this.FProcessorPrerogative);
         SExternalCore.TotalClicks(0);
      }
      
      protected function ProcessorrankIconClick(param1:Object) : void
      {
         this.ProcessorWindowsSwitch(this.FProcessorRank);
      }
      
      protected function ProcessorVipWelfareClick() : void
      {
         this.ProcessorWindowsSwitch(this.FProcessorVipWelfare);
      }
      
      protected function ProcessorMicrologinOnClick() : void
      {
         this.ProcessorWindowsSwitch(this.FProcessorMicrologinLibao);
      }
      
      protected function ProcessorConsumeVipOnClick() : void
      {
         this.ProcessorWindowsSwitch(this.FProcessorConsumeVip);
      }
      
      protected function MiIconIsShow(param1:Boolean) : void
      {
         this.FProcessorShortcuts.MiIconIsShow(param1);
      }
      
      protected function ProcesorBaiDuMeimeiOnClick(param1:Object) : void
      {
         this.ProcessorWindowsSwitch(this.FTProcessorBaiDuMM);
      }
      
      protected function ProcesorOhtsutsukiKaguyaOnClick(param1:Object) : void
      {
         this.ProcessorWindowsSwitch(this.FProcessorOhtsutsukiKaguya);
      }
      
      protected function OpenVk() : void
      {
         if(SLogicsCore.Character.RoleSencePosition != CONST_COMMON.SCENEPOSITION_MAINCITY)
         {
            this.FProcessorVkSiMiDa.VeryveryLiHai = 7;
            return;
         }
         this.ProcessorWindowsSwitch(this.FProcessorVkSiMiDa);
         this.FProcessorVkSiMiDa.VeryveryLiHai = 0;
      }
      
      protected function ProcessorShortcutAccountTransfer(param1:Object = null) : void
      {
         this.ProcessorWindowsSwitch(this.FProcessorAccountTransfer);
      }
      
      protected function OpenProcessorAccountSafe() : void
      {
         SParametersNewCore.CoerceProperties(root.loaderInfo.parameters);
         if(Boolean(SParametersNewCore.IsCollect) && SLogicsCore.Character.MainHero.Level >= 25)
         {
            this.ProcessorWindowsSwitch(this.FProcessorAccountSafe);
         }
      }
      
      protected function ProcesorVkOnClick() : void
      {
         this.FProcessorVkSiMiDa.C2S();
      }
      
      protected function ProcessorAccountLockOnClick() : void
      {
         var _loc1_:ByteArray = null;
         _loc1_ = new ByteArray();
         _loc1_.writeUnsignedInt(CONST_BASEACTIVITY.TYPE_NewActiveList_AccountLock);
         _loc1_.position = 0;
         this.ProcessorWindowsSwitch(this.FProcessorActivityManager,_loc1_);
      }
      
      protected function ProcesorObligatoryCoursesOnClick(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(1);
         _loc2_.position = 0;
         this.ProcessorWindowsSwitch(this.FProcessorNarutoRoad,_loc2_);
      }
      
      protected function ProcessorReturnHall(param1:Object) : void
      {
         this.ProcessorWindowsSwitch(this.FProcessorGroupBattle);
         this.ProcessorPlateSwitch(this.FProcessorMainScene);
      }
      
      protected function ProcessorOnEnterPlayerRoom(param1:Object) : void
      {
         this.ProcessorWindowsSwitch(null);
         this.ProcessorPlateSwitch(this.FProcessorGroupBattleRoomUI);
      }
      
      protected function ProcessorOnEnterReady(param1:Object) : void
      {
         this.FProcessorGroupBattleRoomUI.OnShowWindowReady(param1);
      }
      
      protected function ProcessorOnUpdataWindowReady(param1:Object) : void
      {
         this.FProcessorGroupBattleRoomUI.OnWindowReadyUpdata(param1);
      }
      
      protected function ProcessorOnUpdateInviteShadows(param1:Object) : void
      {
         this.FProcessorGroupBattleRoomUI.UpdateInviteShadows();
      }
      
      protected function ProcessorOnCloseBattleSelect(param1:Object) : void
      {
         this.FProcessorGroupBattleRoomUI.CloseBattleSelectWindow();
      }
      
      protected function ProcessorOnOpenNijiaBattleWindow(param1:Object) : void
      {
         this.ProcessorWindowsSwitch(this.FProcessorGroupBattle);
      }
      
      protected function ProcessorOnEnterTopTeamRoom(param1:Object) : void
      {
         if(this.FProcessorPlateTopTeamRoomUI.Visible)
         {
            this.ProcessorOnUpdateRoomData(null);
         }
         else
         {
            this.ProcessorWindowsSwitch(this.FProcessorTopTeam);
            this.ProcessorWindowsSwitch(null);
            this.ProcessorPlateSwitch(this.FProcessorPlateTopTeamRoomUI);
         }
      }
      
      protected function ProcessorOnUpdateRoomData(param1:Object) : void
      {
         this.FProcessorPlateTopTeamRoomUI.UpdateRoomData();
      }
      
      protected function ProcessorOnUpdateTop(param1:Object) : void
      {
         this.FProcessorPlateTopTeamRoomUI.UpdateTop();
      }
      
      protected function ProcessorOnMatchSuccess(param1:Object) : void
      {
         this.FProcessorPlateTopTeamRoomUI.UpdateMatchSuccess();
      }
      
      protected function ProcessorOnUpdateInviteList(param1:Object) : void
      {
         this.FProcessorPlateTopTeamRoomUI.UpdateInviteList();
      }
      
      protected function ProcessorOnApplyCaptain(param1:Object, param2:uint, param3:uint) : void
      {
         this.FProcessorPlateTopTeamRoomUI.ApplyCaptain(param2,param3);
      }
      
      protected function ProcessorOnCloseBattleRoomUI(param1:Object) : void
      {
         this.ProcessorOnReturnMainScene(param1);
      }
      
      protected function ProcessorOnOpenTopTeamWindow(param1:Object) : void
      {
         this.ProcessorWindowsSwitch(this.FProcessorTopTeam);
      }
      
      protected function ProcessorOnExitRoom(param1:Object) : void
      {
         this.ProcessorOnReturnMainScene(param1);
         this.ProcessorWindowsSwitch(this.FProcessorTopTeam);
      }
      
      protected function ProcessorShortcutsStrengthenOnClick(param1:Object, param2:ByteArray = null) : void
      {
         this.ProcessorWindowsSwitch(this.FProcessorSmithy,param2);
      }
      
      protected function ProcessorShortcutsTongLingOnClick(param1:Object, param2:ByteArray = null) : void
      {
         this.ProcessorWindowsSwitch(this.FProcessorTongLing,param2);
      }
      
      protected function ProcessorShortcutsOrganiZationOnClick(param1:Object, param2:ByteArray = null) : void
      {
         this.ProcessorWindowsSwitch(this.FProcessorOrganization,param2);
      }
      
      protected function ProcessorsShortcutsOnNijiaStar(param1:Object, param2:ByteArray = null) : void
      {
         this.ProcessorPlateSwitch(this.FProcessorNijiaStar,param2);
      }
      
      protected function ProcessorsShortcutsOnActivityPalace(param1:Object, param2:ByteArray = null) : void
      {
         this.FProcessorPalace.PalaceEnterReq();
      }
      
      protected function ProcessorsShortcutsOnActivityRamen(param1:Object, param2:ByteArray = null) : void
      {
         this.ProcessorWindowsSwitch(this.FProcessorRamen,param2);
      }
      
      protected function ProcessorsShortcutsOnActivityTopOrganization(param1:Object, param2:ByteArray = null) : void
      {
         if(SLogicsCore.Organization.OrgId == 0)
         {
            this.ProcessorsOnEffectText(this,STRING_TOPORGANIZATION.STRING_NoOrganization);
         }
         else
         {
            this.ProcessorWindowsSwitch(this.FProcessorTopOrganization,param2);
         }
      }
      
      protected function ProcessorsShortcutsOnActivityGroupBattle(param1:Object, param2:ByteArray = null) : void
      {
         this.FProcessorGroupBattle.EnterBattleRoomUIReq(param2);
      }
      
      protected function ProcessorsShortcutsOnActivityLaboratory(param1:Object, param2:ByteArray = null) : void
      {
         this.ProcessorWindowsSwitch(this.FProcessorWindowBloodSoulPurgatoryMain,param2);
      }
      
      protected function ProcessorsShortcutsOnActivitySixFairy(param1:Object, param2:ByteArray = null) : void
      {
         this.ProcessorWindowsSwitch(this.FProcessorWindowSixFairyMain,param2);
      }
      
      protected function ProcessorsShortcutsOnActivityTopTeam(param1:Object, param2:ByteArray = null) : void
      {
         this.FProcessorTopTeam.EnterBattleRoomUIReq(param2);
      }
      
      protected function ProcessorsShortcutsOnActivityRebirthRealm(param1:Object, param2:ByteArray = null) : void
      {
         this.ProcessorWindowsSwitch(this.FProcessorWindowRebirthRealmAllManager,param2);
      }
      
      protected function ProcessorsShortcutsOnActivityNijiaMystic(param1:Object, param2:ByteArray = null) : void
      {
         this.ProcessorWindowsSwitch(this.FProcessorWindowNijiaMystic,param2);
      }
      
      protected function ProcessorsShortcutsOnActivityChoose(param1:Object, param2:ByteArray = null) : void
      {
         this.FProcessorWorldMap.SetGotoTarget(TProcessorWorldMap.SELECT_CAMPAIGN,CONST_CAMPAIGN.Start_CAMPId);
         this.ProcessorPlateSwitch(this.FProcessorWorldMap);
      }
      
      protected function ProcessorsShortcutsOnActivityNarutoHelper(param1:Object, param2:ByteArray = null) : void
      {
         this.ProcessorWindowsSwitch(this.FProcessorNarutoHelper,param2);
      }
      
      protected function ProcessorsShortcutsOnActivityNinjaRelation(param1:Object, param2:ByteArray = null) : void
      {
         this.ProcessorWindowsSwitch(this.FProcessorNinjaRelationship,param2);
      }
      
      protected function ProcessorsShortcutsOnActivityNinjaHostel(param1:Object, param2:ByteArray = null) : void
      {
         this.ProcessorWindowsSwitch(this.FProcessorNinjaHostel,param2);
      }
      
      protected function ProcessorsShortcutsOnActivityBloodFete(param1:Object = null, param2:ByteArray = null) : void
      {
         this.ProcessorPlateSwitch(this.FProcessorWindowBloodFeteMainManageClass,param2);
      }
      
      protected function ProcessorsShortcutsOnActivityEpicEquip(param1:Object = null, param2:ByteArray = null, param3:Object = null) : void
      {
         this.FProcessorTransmigrationTrial.SelectContext = param3;
         this.ProcessorWindowsSwitch(this.FProcessorTransmigrationTrial,param2);
      }
      
      protected function ProcessorsShortcutsOnActivityTaboo(param1:Object = null, param2:ByteArray = null) : void
      {
         this.ProcessorWindowsSwitch(this.FPressorWindowTaboo,param2);
      }
      
      protected function ProcessorsShortcutsOnActivityAwaken(param1:Object = null, param2:ByteArray = null) : void
      {
         this.ProcessorPlateSwitch(this.FProcessorWindowManAwaken,param2);
      }
      
      protected function ProcessorsShortcutsOnActivityEight(param1:Object = null, param2:ByteArray = null) : void
      {
         this.ProcessorPlateSwitch(this.FProcessorWindowManEightDoor,param2);
      }
      
      protected function ProcessorsShortcutsOnActivityTransmigrationAccessory(param1:Object = null, param2:ByteArray = null) : void
      {
         this.ProcessorWindowsSwitch(this.FProcessorTransmigrationAccessory,param2);
      }
      
      protected function ProcessorsShortcutsOnActivityTheWorldTree(param1:Object = null, param2:ByteArray = null) : void
      {
         this.ProcessorPlateSwitch(this.FProcessorWindowTheWorldTree,param2);
      }
      
      protected function ProcessorsShortcutsOnActivityUndertown(param1:Object = null, param2:ByteArray = null) : void
      {
         this.ProcessorWindowsSwitch(this.FProcessorWindowUndertown,param2);
      }
      
      protected function ProcessorsShortcutsOnActivityLostShenQi(param1:Object = null, param2:ByteArray = null) : void
      {
         this.ProcessorWindowsSwitch(this.FProcessorLostShenQiMain,param2);
      }
      
      protected function ProcessorsShortcutsOnActivityWing(param1:Object = null, param2:ByteArray = null) : void
      {
         this.ProcessorWindowsSwitch(this.FProcessorWing,param2);
      }
      
      protected function ProcessorsShortcutsOnActivityIllustrated(param1:Object = null, param2:ByteArray = null) : void
      {
         this.ProcessorWindowsSwitch(this.FProcessorIllustrated,param2);
      }
      
      protected function ProcessorsShortcutsOnActivityAlien(param1:Object = null, param2:ByteArray = null) : void
      {
         this.ProcessorWindowsSwitch(this.FProcessorAline,param2);
      }
      
      protected function ProcessorsShortcutsOnActivityKingwar(param1:Object = null, param2:ByteArray = null) : void
      {
         this.ProcessorWindowsSwitch(this.FProcessorKingWar,param2);
      }
      
      protected function ProcessorsShortcutsOnActivityMedal(param1:Object = null, param2:ByteArray = null) : void
      {
         this.ProcessorWindowsSwitch(this.FProcessorMedal,param2);
      }
      
      protected function ProcessorsShortcutsOnActivityInviteCode(param1:Object = null, param2:ByteArray = null) : void
      {
         this.ProcessorWindowsSwitch(this.FProcessorInviteCode,param2);
      }
      
      protected function ProcessorsShortcutsOnActivityWuxing(param1:Object = null, param2:ByteArray = null) : void
      {
         this.ProcessorWindowsSwitch(this.FProcessorWuxing,param2);
      }
      
      protected function ProcessorsShortcutsOnActivityGlobalBattle(param1:Object = null, param2:ByteArray = null) : void
      {
         this.ProcessorPlateSwitch(this.FProcessorGlobalBattle);
      }
      
      protected function ProcessorsShortcutsOnActivityEmblem(param1:Object = null, param2:ByteArray = null) : void
      {
         this.ProcessorWindowsSwitch(this.FProcessorEmblem,param2);
      }
      
      protected function ProcessorsShortcutsOnActivityWorldMatch(param1:Object = null, param2:ByteArray = null) : void
      {
         if(this.FProcessorWorldMatch.IfEnterWorldMatch())
         {
            this.ProcessorPlateSwitch(this.FProcessorWorldMatch);
         }
      }
      
      protected function ProcessorsShortcutsOnActivitySummonBattle(param1:Object = null, param2:ByteArray = null) : void
      {
         this.ProcessorPlateSwitch(this.FProcessorSummonBattle);
      }
      
      protected function ProcessorsShortcutsOnActivityNinjaTalent(param1:Object = null, param2:ByteArray = null) : void
      {
         this.ProcessorWindowsSwitch(this.FProcessorNinjaTalent);
      }
      
      protected function ProcessorsShortcutsOnActivityChallengCamp(param1:Object = null, param2:ByteArray = null) : void
      {
         this.ProcessorWindowsSwitch(this.FProcessorChallengeCamp);
      }
      
      protected function ProcessorsShortcutsOnActivityGlobalBoss(param1:Object = null, param2:ByteArray = null) : void
      {
         var _loc3_:ByteArray = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(param1 != null)
         {
            _loc4_ = int(param1.identity);
            _loc5_ = int(param1.level);
            _loc3_ = new ByteArray();
            _loc3_.writeUnsignedInt(_loc4_);
            _loc3_.position = 0;
            this.FProcessorGlobalBoss.GlobalbossChapterId = _loc4_;
            this.FProcessorGlobalBoss.GlobalbossLevel = _loc5_;
         }
         this.ProcessorWindowsSwitch(this.FProcessorGlobalBoss,_loc3_);
      }
      
      protected function ProcessorsShortcutsOnActivityGlobalBossMain(param1:Object = null, param2:ByteArray = null) : void
      {
         this.ProcessorWindowsSwitch(this.FProcessorGlobalBossMain);
      }
      
      protected function ProcessorsShortcutsOnActivityRecruit(param1:Object = null, param2:ByteArray = null) : void
      {
         this.ProcessorWindowsSwitch(this.FProcessorRecruit);
      }
      
      protected function ProcessorsShortcutsOnActivitySlave(param1:Object = null, param2:ByteArray = null) : void
      {
         this.ProcessorWindowsSwitch(this.FProcessorSlave);
      }
      
      protected function ProcessorsShortcutsOnActivityAddSoul(param1:Object = null, param2:ByteArray = null) : void
      {
         this.ProcessorWindowsSwitch(this.FProcessorWindowAddSoul,param2);
      }
      
      protected function ProcessorsShortcutsOnActivityChallenge(param1:Object = null, param2:ByteArray = null) : void
      {
         this.ProcessorPlateSwitch(this.FProcessorChallenge,param2);
      }
      
      protected function ProcessorGotoOpenJade(param1:Object = null, param2:ByteArray = null) : void
      {
         this.ProcessorWindowsSwitch(this.FSpecialJade,param2);
      }
      
      protected function ProcessorGotoOpenShop(param1:Object = null, param2:ByteArray = null) : void
      {
         this.ProcessorWindowsSwitch(this.FProcessorWindowShop,param2);
      }
      
      protected function ProcessorGotoOpenLevelGifts(param1:Object = null, param2:ByteArray = null) : void
      {
         this.ProcessorWindowsSwitch(this.FProcessorTalentLevelGifts);
      }
      
      protected function ProcessorGotoOpenWorldMatchStreak(param1:Object = null, param2:ByteArray = null) : void
      {
         this.ProcessorWindowsSwitch(this.FProcessorWorldMatchStreak);
      }
      
      protected function ProcessorOnOpenGlobalbossChapter(param1:Object = null, param2:ByteArray = null) : void
      {
         var _loc3_:ByteArray = null;
         var _loc4_:int = 0;
         _loc4_ = param1 as int;
         _loc3_ = new ByteArray();
         _loc3_.writeUnsignedInt(_loc4_);
         _loc3_.position = 0;
         this.ProcessorWindowsSwitch(this.FProcessorGlobalbossChapter,_loc3_);
      }
      
      protected function ProcessorGotoOpenTalentGifts(param1:Object = null, param2:ByteArray = null) : void
      {
         this.ProcessorWindowsSwitch(this.FProcessorTalentGifts);
      }
      
      protected function ProcessorsShortcutsOnActivityBloodFeteCopy(param1:Object = null, param2:ByteArray = null) : void
      {
         this.ProcessorWindowsSwitch(null);
         this.ProcessorPlateSwitch(this.FProcessorWindowBloodFeteMainManageClass,param2);
      }
      
      protected function ProcessorShortcutsJadeOnClick(param1:Object, param2:ByteArray = null) : void
      {
         this.ProcessorWindowsSwitch(this.FProcessorJade,param2);
      }
      
      protected function ProcessorShortcutsOnFriend(param1:Object, param2:ByteArray = null) : void
      {
         this.ProcessorWindowsSwitch(this.FProcessorFriend,param2);
      }
      
      protected function ProcessorShortcutsTavernOnClick(param1:Object, param2:ByteArray = null) : void
      {
         var _loc3_:TProcessorShortcuts = null;
         _loc3_ = TProcessorShortcuts(param1);
         this.FProcessorTavern.FParameter = _loc3_.FParameter;
         this.ProcessorPlateSwitch(this.FProcessorTavern,param2);
      }
      
      protected function ProcessorShortcutsMakeEquipOnClick(param1:Object, param2:ByteArray = null) : void
      {
         this.ProcessorWindowsSwitch(this.FProcessorMakeEquip,param2);
      }
      
      protected function ProcessorShortcutsOnNpcUserType(param1:int, param2:int = 0) : void
      {
         var _loc3_:ByteArray = null;
         if(param1 == CONST_NPC.NPC_FUNCTION_PUB)
         {
            this.ProcessorPlateSwitch(this.FProcessorTavern);
         }
         else if(param1 == CONST_NPC.NPC_FUNCTION_MADE)
         {
            _loc3_ = new ByteArray();
            _loc3_.writeUnsignedInt(5);
            _loc3_.position = 0;
            this.ProcessorWindowsSwitch(this.FProcessorSmithy,_loc3_);
         }
         else if(param1 == CONST_NPC.NPC_FUNCTION_STONE)
         {
            this.ProcessorWindowsSwitch(this.FProcessorJade);
         }
         else if(param1 == CONST_NPC.NPC_FUNCTION_COPY)
         {
            this.ProcessorWindowsSwitch(this.FProcessorCopyHero);
         }
         else if(param1 == CONST_NPC.NPC_FUNCTION_SANTACLAUS)
         {
            this.ProcessorShortcutsOnSuperChristmas(null);
         }
         else if(param1 == CONST_NPC.NPC_FUNCTION_GODEQUIP)
         {
            this.ProcessorShortcutsOnSuperEquip(null);
         }
         else if(param1 == CONST_NPC.NPC_FUNCTION_MASTERROAD)
         {
            if(SLogicsCore.MasterRoad.IsFirst == 0)
            {
               this.ProcessorWindowsSwitch(this.FProcessorMasterRoadOld);
            }
            else
            {
               this.ProcessorPlateSwitch(this.FProcessorMasterRoad);
            }
         }
         else if(param1 == CONST_NPC.NPC_FUNCTION_YUELAO)
         {
            _loc3_ = new ByteArray();
            _loc3_.writeUnsignedInt(param2);
            _loc3_.position = 0;
            this.ProcessorWindowsSwitch(this.FProcessorMarried,_loc3_);
         }
         else if(param1 == CONST_NPC.NPC_FUNCTION_WAREHOUSE)
         {
            this.ProcessorWindowsSwitch(this.FProcessorWarehouse);
         }
      }
      
      protected function ProcessorShortcutEffectNotification(param1:uint, param2:uint, param3:Boolean) : void
      {
         this.FProcessorShortcuts.ShowEffectNotification(param1,param2,param3);
      }
      
      protected function ProcessorShortcutSpecialNotification(param1:uint, param2:uint, param3:Boolean) : void
      {
         this.FProcessorShortcuts.ShowSpecialNotification(param1,param2,param3);
      }
      
      protected function ProcessorOnButActionTimes(param1:Object) : void
      {
         this.ProcessorWindowsSwitch(null);
         this.FProcessorShortcuts.BuyActionTimes();
      }
      
      protected function ProcessorOnGotoRamen(param1:Object) : void
      {
         this.ProcessorWindowsSwitch(this.FProcessorRamen);
      }
      
      protected function ProcessorOnFightingCapacityShow(param1:Object, param2:uint) : void
      {
      }
      
      protected function ProcessorOnOrgGetNameFromID(param1:Object, param2:uint) : String
      {
         return this.FProcessorOrganization.GetOrgNameFromOrgID(param2);
      }
      
      protected function ProcessorOnOrgGetActivityLevelByType(param1:uint) : uint
      {
         return this.FProcessorOrganization.GetActivityLevelByType(param1);
      }
      
      protected function ProcessorShortcutHyperlinks(param1:Object, param2:uint, param3:uint, param4:int = 0, param5:Object = null) : void
      {
         this.FProcessorShortcuts.PerformShortcutHyperlinks(param1,param2,param3,param4,param5,this.ProcessorShortcutCloseWindows);
      }
      
      protected function ProcessorShortcutCloseWindows(param1:Object) : void
      {
         if(param1 is TProcessorLobbyWindows || param1 is TProcessorLobbyWindow)
         {
            this.ProcessorWindowsSwitch(null);
         }
      }
      
      protected function ProcessorUpdataRoom(param1:Object) : void
      {
         this.FProcessorGroupBattleRoomUI.OnRoomUpdata();
      }
      
      protected function ProcessorResetRoomAutoOnMatching(param1:Object, param2:Boolean = false) : void
      {
         this.FProcessorGroupBattleRoomUI.OnResetRoomAutoOnMatching(param2);
      }
      
      protected function OpenShopByTongLing() : void
      {
         this.ProcessorOnOpenModel(null,CONST_POPTIPS.POPTIP_Goto_Mall);
      }
      
      protected function ProofSeeNinJa() : void
      {
         this.ProcessorOnOpenModel(null,CONST_POPTIPS.POPTIP_Goto_SuperNijia);
      }
      
      protected function ProcessorOnUpdateAttribute(param1:Object) : void
      {
         this.FProcessorHeros.UpdateMagic();
      }
      
      protected function ProcessorPalaceRankingsReq(param1:Object) : void
      {
         this.FProcessorPalace.PalaceRankingsReq();
      }
      
      protected function ProcessorOnOpenNewActivityList() : void
      {
         this.FProcessorShortcuts.OpenNewActivityListStatusNotification();
         this.FProcessorShortcuts.UpdateNewActiveListStatus();
      }
      
      protected function ProcessorOnOpenActivityThirdList() : void
      {
         this.FProcessorShortcuts.OpenActivityListThirdStatusNotification();
      }
      
      protected function ProcessorOnUpdateInventories(param1:Object) : void
      {
         this.FProcessorTalisman.UserUpdateInventories();
         this.FProcessorHeros.UpdateCharacterInventory();
         this.FProcessorMedal.UserUpdateInventories();
      }
      
      protected function ProcessorShortcutsMakeEquipAdvancedOnClick(param1:Object = null, param2:Object = null) : void
      {
         this.FProcessorEquipAdvanced.SetContext(param2);
         this.ProcessorWindowsSwitch(this.FProcessorEquipAdvanced);
      }
      
      protected function ProcessorShortcutsAccessoryIntensityOnClick(param1:Object = null, param2:Object = null) : void
      {
         this.ProcessorWindowsSwitch(this.FProcessorWindowAccessory);
      }
      
      protected function ProcessorsOnInventoryReveal(param1:Object, param2:Object) : void
      {
         this.FProcessorChat.ProcessorInventoryReveal(param2);
      }
      
      protected function ProcessorsOnRequestWhisper(param1:Object, param2:uint, param3:uint, param4:String) : void
      {
         this.FProcessorChat.RequestWhisper(param2,param3,param4);
      }
      
      protected function ProcessorOnChangeSkillReq(param1:Object, param2:Object) : void
      {
         this.FProcessorTacticalDeployment.ProcessorChangeSkillReq(param1,param2);
      }
      
      protected function ProcessorOnChangePosition(param1:Object) : void
      {
         this.FProcessorBattleScene.ProcessorsOnChangePosition(param1);
         this.ProcessorOnHerosUpdateBaseAttributeRet(param1);
         this.FProcessorChallenge.UpdateChallengeFormation();
      }
      
      protected function ProcessorOnChangeSkill(param1:Object) : void
      {
         this.FProcessorHeros.UpdateMainHeroSkill();
         this.FProcessorChallenge.UpdateMainHeroSkill();
      }
      
      protected function ProcessorOnUpdateReturnHomePanel(param1:Object, param2:String, param3:String) : void
      {
         this.FProcessorShortcuts.UpdateReturnHomePanel(param2,param3);
      }
      
      protected function ProcessorGetKingSoulonClick(param1:Object) : void
      {
         this.ProcessorPlateSwitch(this.FProcessorSevenKing);
      }
      
      protected function ProcessorOnOpenCrossServerWar(param1:Object) : void
      {
         var _loc2_:uint = 0;
         _loc2_ = uint(SLogicsCore.EliteRecord.TodayIsJoin);
         if(_loc2_ == 2)
         {
            return;
         }
         if(_loc2_ == 1)
         {
            this.ProcessorPlateSwitch(this.FProcessorCrossServerWar);
         }
         else if(_loc2_ == 0)
         {
            this.ProcessorWindowsSwitch(this.FProcessorCrossServerWarWindows);
            this.FProcessorCrossServerWarWindows.ShowWindow(0);
         }
      }
      
      protected function ProcessorOnOpenSoulExchange(param1:Object, param2:uint) : void
      {
         this.FProcessorCrossServerWarWindows.ShowWindow(param2);
         this.ProcessorWindowsSwitch(this.FProcessorCrossServerWarWindows);
      }
      
      protected function ProcessorOnOpenTokenExchange(param1:Object, param2:uint) : void
      {
         this.FProcessorCrossServerWarWindows.ShowWindow(param2);
         this.ProcessorWindowsSwitch(this.FProcessorCrossServerWarWindows);
      }
      
      protected function ProcessorOnOpenToast(param1:Object, param2:uint) : void
      {
         this.FProcessorCrossServerWarWindows.ShowWindow(param2);
         this.ProcessorWindowsSwitch(this.FProcessorCrossServerWarWindows);
      }
      
      protected function ProcessorOnOpenRankings(param1:Object, param2:uint, param3:TIntegralRankings, param4:uint) : void
      {
         this.FProcessorCrossServerWarWindows.ShowWindow(param2);
         this.FProcessorCrossServerWarWindows.UpdateRankings(param3,param4);
         this.ProcessorWindowsSwitch(this.FProcessorCrossServerWarWindows);
      }
      
      protected function ProcessorUpdateExplanationUI(param1:Object) : void
      {
         this.FProcessorCrossServerWarWindows.UpdateExplanationUI();
      }
      
      protected function ProcessorUpdateToastRecord(param1:Object, param2:Object) : void
      {
         this.FProcessorCrossServerWarWindows.UpdateToastRecord(param2);
      }
      
      protected function ProcessorOnOpenExplanation(param1:Object, param2:uint) : void
      {
         this.ProcessorWindowsSwitch(this.FProcessorExplanation);
         this.FProcessorExplanation.UpdateRankings(param1,param2);
      }
      
      protected function ProcessorOnOpenPalace(param1:Object) : void
      {
         this.ProcessorPlateSwitch(this.FProcessorPalace);
      }
      
      protected function ProcessorUpdateActivityStatus(param1:Object, param2:uint, param3:uint) : void
      {
         this.FProcessorShortcuts.UpdateActivityStatus(param2,param3);
      }
      
      protected function ProcessorOnUpdateKillHero(param1:Object, param2:uint) : void
      {
         this.FProcessorKillHeros.UpdateKillHero(param2);
      }
      
      protected function ProcessorOnLoadFollowUp(param1:Object) : void
      {
         if(this.FOnLoadFollowUp != null)
         {
            this.FOnLoadFollowUp(this);
         }
         this.FProcessorInspector.Load();
         this.FProcessorEffect.Load();
         this.FProcessorModuleLoader.Start();
      }
      
      protected function ProcessorOnCreateRole(param1:Object) : void
      {
         this.FProcessorMainScene.CreateMainRole();
      }
      
      protected function ProcessorOnChangeShape(param1:Object, param2:uint) : void
      {
         this.FProcessorMainScene.ChangeShape(param2);
      }
      
      protected function ProcessorOnUpdateCopyHeros(param1:Object, param2:int) : void
      {
         this.FProcessorCopyHero.UpDateCopyHeros(param2);
      }
      
      protected function ProcessorOnOrganizationalWarCommandRequest(param1:Object, param2:uint, param3:uint, param4:Function) : void
      {
         this.FOrganizationalWar.CommandRequest(param2,param3,param4);
      }
      
      protected function ProcessorTraitorAttackEnd(param1:Object) : void
      {
         this.FProcessorTraitorAttack.TraitorAttackEnd();
      }
      
      protected function ProcessorOnAutoHangUpStatusReq(param1:Object) : void
      {
         this.FProcessorAutoHangUp.StatusReq();
      }
      
      protected function ProcessorOnCharacterBaseAttribute(param1:Object) : void
      {
         this.FProcessorHeros.UpdateCharacterBaseAttribute();
         this.FProcessorTalisman.UpdateCharacterBaseAttribute();
         this.FProcessorMedal.UpdateCharacterBaseAttribute();
      }
      
      protected function ProcessorOnUpdateHerosTotalFightingPower(param1:Object, param2:uint) : void
      {
         this.FProcessorShortcuts.UserUpdateFightingPower(param2);
         this.FProcessorTacticalDeployment.UserUpdateFightingPower();
         this.FProcessorChallenge.UserUpdateFightingPower();
      }
      
      protected function ProcessorOnMountTalisman(param1:Object, param2:uint, param3:uint, param4:uint) : void
      {
         this.FProcessorHeros.ProcessorOnMountTalisman(param1,param2,param3,param4);
      }
      
      protected function ProcessorOnDismountTalisman(param1:Object, param2:uint, param3:uint, param4:uint) : void
      {
         this.FProcessorHeros.ProcessorOnDismountTalisman(param1,param2,param3,param4);
      }
      
      protected function ProcessorOnUpdateTalismanMount(param1:Object) : void
      {
         this.FProcessorTalisman.UpdateEquip();
      }
      
      protected function ProcessorOnUpdateMedalMount(param1:Object) : void
      {
         this.FProcessorMedal.UpdateEquip();
      }
      
      protected function ProcessorOnHerosUpdateBaseAttributeReq(param1:Object) : void
      {
         this.FProcessorHeros.UpdateHerosBaseAttributeReq();
      }
      
      protected function UpdataWindowHeroInfor(param1:Object) : void
      {
         this.FProcessorInspector.UpdataWindowHeroInfor(param1);
      }
      
      protected function ProcessorOnHerosUpdateBaseAttributeRet(param1:Object) : void
      {
         this.FProcessorTacticalDeployment.UserUpdateFightingPower();
      }
      
      protected function ProcessorOnUserUpdateCharacterCountry(param1:Object) : void
      {
         this.FProcessorShortcuts.UserUpdateCharacterCountry();
      }
      
      protected function ProcessorOnSetOrganizationalName(param1:Object, param2:String) : void
      {
         this.FProcessorProtagonist.SetPlayerOrganizationalName(param2);
      }
      
      protected function ProcessorOnDismissHero(param1:Object, param2:uint) : void
      {
      }
      
      protected function ProcessorOnResetHeros(param1:Object) : void
      {
         this.FProcessorHeros.ResetHeros(param1);
      }
      
      protected function ProcessorOnTakeBackHero(param1:Object) : void
      {
         this.FProcessorChallenge.UpdateChallengeFormation();
      }
      
      protected function ProcessorOnUseInventory(param1:Object, param2:uint) : void
      {
         this.FProcessorBackpack.SetExperience(param2);
      }
      
      protected function ProcessorCheckPopTips(param1:Object) : void
      {
         this.FProcessorGeneralStar.CheckPopTip();
         this.FProcessorProtagonist.UpdatePrestige();
      }
      
      protected function ProcessorOnShowHeroInforPanle(param1:Object, param2:TUIRoleCanMovePlayerRole) : void
      {
         this.FProcessorShortcuts.ShowHeroContorlPanle(param2);
      }
      
      protected function ProcessorOnHideHeroInforPanle(param1:Object) : void
      {
         this.FProcessorShortcuts.HideHeroContorlPanle();
      }
      
      protected function ProcessorOnHeroUpdateBaseAttribute(param1:Object, param2:uint) : void
      {
         this.FProcessorHeros.UpdateHeroBaseAttributeReq(param2);
      }
      
      public function ProcessorOnInquiryCharacterIDReq(param1:Object, param2:String) : void
      {
         this.FProcessorFriend.ProcessorInquiryCharacterIDByNickname(param2);
      }
      
      public function ProcessorOnInterpersonalRelationshipsReq(param1:Object, param2:uint, param3:Object) : void
      {
         this.FProcessorFriend.ProcessorInterpersonalRelationshipsReq(param2,param3);
      }
      
      public function ProcessorNinjaPointMallOnClick(param1:Object) : void
      {
         this.FProcessorTopTeam.Visible = true;
         this.FProcessorTopTeam.ShowNinjaPointMall();
      }
      
      public function ProcessorSendGVGModule(param1:Object, param2:Vector.<TBaseOrganizationMember>) : void
      {
         this.FProcessorTopOrganization.SetOrgMemberListData(param2);
      }
      
      public function ProcessorOnHackWarningResponse(param1:Object) : void
      {
         this.FProcessorCheatChecker.HackWarningResponse();
      }
      
      public function ProcessorOnActivatingChannel(param1:Object, param2:uint, param3:Boolean) : void
      {
         this.FProcessorChat.ProcessorActivatingChannel(param2,param3);
      }
      
      public function ProcessorOnInquiryCharacterIDRet(param1:Object, param2:uint, param3:uint) : void
      {
         this.FProcessorChat.ProcessorInquiryCharacterIDRet(param2,param3);
      }
      
      public function ProcessorOnChatWhisper(param1:Object, param2:Object) : void
      {
         this.FProcessorChat.ChatWhisperByDigest(param2);
      }
      
      public function ProcessorOnOpenWriteMail(param1:Object, param2:Object) : void
      {
         this.FProcessorMail.SetWriteMail(param2);
         this.ProcessorWindowsSwitch(this.FProcessorMail);
      }
      
      public function ProcessorOnChatAnnouncement(param1:Object, param2:Object) : void
      {
         this.FProcessorChat.ProcessorAntiAddiction(param2);
      }
      
      public function ProcessorOnAntiAddiction(param1:Object, param2:int) : void
      {
         if(this.FOnAntiAddiction != null)
         {
            this.FOnAntiAddiction(param1,param2);
         }
      }
      
      public function ProcessorsOnHackWarning(param1:Object, param2:int) : void
      {
         this.FProcessorChat.HackWarning(param2);
      }
      
      public function ProcessorOnOpenActivityListStatusNotification(param1:Object) : void
      {
         this.FProcessorShortcuts.OpenActivityListStatusNotification();
      }
      
      protected function ProcessorOnPost(param1:Object, param2:THyperString, param3:TPost) : void
      {
         this.FProcessorChat.PostSystemMsg(param2,param3);
      }
      
      protected function ProcessorOnAutoHangUpStatusRet(param1:Object, param2:Vector.<uint>) : void
      {
         this.FProcessorDailyActivity.UpdateAutoHangUpStatus(param2);
      }
      
      protected function ProcessorOnUpdateTitleInfo(param1:Object, param2:uint) : void
      {
         this.FProcessorMainScene.UpdateTitle(param2);
         this.FProcessorHeros.UpdateTitle(param2);
      }
      
      protected function ProcessorOnUpdateLittlePetInfo(param1:uint) : void
      {
         this.FProcessorMainScene.UpdateLittlePet(param1);
         this.FProcessorHeros.UpdateLittlePet(param1);
      }
      
      protected function UpdateWing(param1:uint, param2:int = 2) : void
      {
         this.FProcessorMainScene.UpdateWing(param1,param2);
      }
      
      protected function ProcessoOnUpdateBadge(param1:Vector.<int>) : void
      {
         this.FProcessorMainScene.UpdateBadge(param1);
      }
      
      protected function OnUpdateJade(param1:uint) : void
      {
         this.FProcessorMainScene.UpdateJade(param1);
      }
      
      protected function ProcessorGotoNinjaFun() : void
      {
         this.FProcessorNinjaRelationship.OnClickTabFun = function():void
         {
            FProcessorNinjaRelationship.TabChangeByIndex(6);
         };
         this.ProcessorWindowsSwitch(this.FProcessorNinjaRelationship);
      }
      
      protected function OnProcessorCheckPlot(param1:Object, param2:int, param3:int, param4:uint, param5:Function = null) : void
      {
         if(this.FProcessorCheckPlot != null)
         {
            this.FProcessorCheckPlot(param1,param2,param3,param4,param5);
         }
      }
      
      protected function AddPopTips(param1:Object, param2:uint) : void
      {
         this.FProcessorPopTips.AddPopTips(param2);
      }
      
      protected function ProcessorEndBattle(param1:Object) : void
      {
         if(this.FEndBattle != null)
         {
            this.FEndBattle(this);
         }
      }
      
      protected function ProcessorSetGroupBattleType(param1:Object, param2:ByteArray) : void
      {
         if(this.FSetGroupBattleType != null)
         {
            this.FSetGroupBattleType(this,param2);
         }
      }
      
      protected function ProcessorSetGroupBattleInfor(param1:Object, param2:ByteArray) : void
      {
         if(this.FSetGroupBattleInfor != null)
         {
            this.FSetGroupBattleInfor(this,param2);
         }
      }
      
      protected function ProcessorSetGroupBattleReward(param1:Object, param2:ByteArray) : void
      {
         if(this.FSetGroupBattleReward != null)
         {
            this.FSetGroupBattleReward(this,param2);
         }
      }
      
      protected function ProcessorSetTopTeamBattleType(param1:Object, param2:ByteArray) : void
      {
         if(this.FSetTopTeamBattleType != null)
         {
            this.FSetTopTeamBattleType(this,param2);
         }
      }
      
      protected function ProcessorSetTopTeamBattleInfor(param1:Object, param2:ByteArray) : void
      {
         if(this.FSetTopTeamBattleInfor != null)
         {
            this.FSetTopTeamBattleInfor(this,param2);
         }
      }
      
      protected function ProcessorSetTopTeamBattleReward(param1:Object, param2:ByteArray) : void
      {
         if(this.FSetTopTeamBattleReward != null)
         {
            this.FSetTopTeamBattleReward(this,param2);
         }
      }
      
      protected function UnLoadResource(param1:Object) : void
      {
         if(this.FOnUnLoadResource != null)
         {
            this.FOnUnLoadResource(param1);
         }
      }
      
      protected function OnSetStatusType(param1:Object, param2:uint, param3:uint, param4:Boolean = false, param5:Boolean = false, param6:Boolean = false) : void
      {
         if(this.FSetStatusType != null)
         {
            this.FSetStatusType(param1,param2,param3,param4,param5,param6);
         }
      }
      
      protected function OnSetMonsterCount(param1:Object, param2:uint) : void
      {
         if(this.FSetMonsterCount != null)
         {
            this.FSetMonsterCount(param1,param2);
         }
      }
      
      protected function ProcessorOnDailyQusetInfoReq(param1:Object) : void
      {
         this.FProcessorDailyQuest.InfoReq();
      }
      
      protected function ProcessorOnActiveInfoReq(param1:Object) : void
      {
         this.FProcessorActivity.ProcessorOnActiveInfoReq();
      }
      
      protected function ProceesorOnStarsInforReq() : void
      {
         this.FProcessorBigDipper.PerformPacket_CS_BigDipperStartsInfoReq();
      }
      
      protected function ProcessorOnEnterCityDefendReq(param1:Object) : void
      {
         if(this.FProcessorOrganization.Visible == true)
         {
            this.FProcessorOrganization.Visible = false;
         }
         this.FProcessorCityDefend.EnterCityDefendReq();
      }
      
      protected function ProcessorOnEnterFightPetReq(param1:Object, param2:uint) : void
      {
         this.FProcessorFightPet.EnterFightPetReq(param2);
      }
      
      protected function ProcessorOnEnterOrganizationWarReq(param1:Object) : void
      {
         var _loc2_:TPacket = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Enter_OrganizationWar);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function ProcessorOnEnterTraitorAttackReq(param1:Object) : void
      {
         this.FProcessorTraitorAttack.EnterTraitorAttackReq();
      }
      
      protected function OnSetBattlePacket(param1:Object, param2:TPacket) : void
      {
         if(this.FSetBattlePacket != null)
         {
            this.FSetBattlePacket(param1,param2);
         }
      }
      
      protected function ProcessorsOnLoadingQuestOver() : void
      {
         this.FProcessorMainScene.InitNpcQuest();
         this.FProcessorFreshGuide.StartFreshGuide();
         this.FProcessorUnlock.CheckUnlockShortcutsState();
         this.ProcessorPlateSwitch(this.FProcessorMainScene);
      }
      
      protected function ProcessorOnEffectTransition(param1:Object) : void
      {
         this.FEffectTransition.SetEffectByDisplayObject(param1);
      }
      
      protected function ProcessorShowNarutoRoadTip(param1:Object) : void
      {
         this.FProcessorNarutoRoadTip.Show();
      }
      
      protected function ProcessorOnOpenModel(param1:Object, param2:uint) : void
      {
         switch(param2)
         {
            case CONST_POPTIPS.POPTIP_Goto_Strengthen:
               this.ProcessorShortcutHyperlinks(this,CONST_SHORTCUTS.POSITION_Function,CONST_SHORTCUTS.TYPE_Function_Strengthen);
               break;
            case CONST_POPTIPS.POPTIP_Goto_AvaterHead:
               this.ProcessorShortcutHyperlinks(this,CONST_SHORTCUTS.POSITION_Avatar,CONST_SHORTCUTS.TYPE_Avatar_Military,CONST_SHORTCUTS.TYPE_Avatar_Military);
               break;
            case CONST_POPTIPS.POPTIP_Goto_TacticalDeployment:
               this.ProcessorShortcutHyperlinks(this,CONST_SHORTCUTS.POSITION_Function,CONST_SHORTCUTS.TYPE_Function_TacticalDeployment);
               break;
            case CONST_POPTIPS.POPTIP_Goto_GeneralStar:
               this.ProcessorShortcutHyperlinks(this,CONST_SHORTCUTS.POSITION_Function,CONST_SHORTCUTS.TYPE_Function_Star);
               break;
            case CONST_POPTIPS.POPTIP_Goto_Backpack:
               this.ProcessorShortcutHyperlinks(this,CONST_SHORTCUTS.POSITION_Function,CONST_SHORTCUTS.TYPE_Function_Backpack);
               break;
            case CONST_POPTIPS.POPTIP_Goto_Ramen:
               this.ProcessorShortcutHyperlinks(this,CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_Ramen);
               break;
            case CONST_POPTIPS.POPTIP_Goto_OrganiZation:
               this.ProcessorShortcutHyperlinks(this,CONST_SHORTCUTS.POSITION_Function,CONST_SHORTCUTS.TYPE_Function_OrganiZation);
               break;
            case CONST_POPTIPS.POPTIP_Goto_SummonPet:
               this.ProcessorShortcutHyperlinks(this,CONST_SHORTCUTS.POSITION_Function,CONST_SHORTCUTS.TYPE_Function_SummonPet);
               break;
            case CONST_POPTIPS.POPTIP_Goto_Friend:
               this.ProcessorShortcutHyperlinks(this,CONST_SHORTCUTS.POSITION_Map,CONST_SHORTCUTS.TYPE_Map_Friend);
               break;
            case CONST_POPTIPS.POPTIP_Goto_Heros:
               this.ProcessorShortcutHyperlinks(this,CONST_SHORTCUTS.POSITION_Function,CONST_SHORTCUTS.TYPE_Function_Heros);
               break;
            case CONST_POPTIPS.POPTIP_Goto_Arena:
               this.ProcessorShortcutHyperlinks(this,CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_Arena);
               break;
            case CONST_POPTIPS.POPTIP_Goto_Tavern:
               this.ProcessorShortcutHyperlinks(this,CONST_SHORTCUTS.POSITION_Additional,CONST_SHORTCUTS.TYPE_Additional_Tavern);
               break;
            case CONST_POPTIPS.POPTIP_Goto_KillHeros:
               this.ProcessorShortcutHyperlinks(this,CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_KillHeros);
               break;
            case CONST_POPTIPS.POPTIP_Goto_BigMap:
               this.ProcessorShortcutHyperlinks(this,CONST_SHORTCUTS.POSITION_Map,CONST_SHORTCUTS.TYPE_Map_EnterWorldMap);
               break;
            case CONST_POPTIPS.POPTIP_Goto_SuperNijia:
               this.ProcessorShortcutHyperlinks(this,CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_SuperHero);
               break;
            case CONST_POPTIPS.POPTIP_Goto_Talisman:
               this.ProcessorShortcutHyperlinks(this,CONST_SHORTCUTS.POSITION_Function,CONST_SHORTCUTS.TYPE_Function_Treasure);
               break;
            case CONST_POPTIPS.POPTIP_Goto_Jade:
               this.ProcessorShortcutHyperlinks(this,CONST_SHORTCUTS.POSITION_Additional,CONST_SHORTCUTS.TYPE_Additional_Jade);
               break;
            case CONST_POPTIPS.POPTIP_Goto_TreasureMap:
               this.ProcessorShortcutHyperlinks(this,CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_TreasureMap);
               break;
            case CONST_POPTIPS.POPTIP_Goto_Sign:
               this.ProcessorShortcutHyperlinks(this,CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_Sign);
               break;
            case CONST_POPTIPS.POPTIP_Goto_DailyQuest:
               this.ProcessorShortcutHyperlinks(this,CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_DailyQuest);
               break;
            case CONST_POPTIPS.POPTIP_Goto_Mall:
               this.ProcessorShortcutHyperlinks(this,CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_Mall);
               break;
            case CONST_POPTIPS.POPTIP_Goto_CopyHero:
               this.ProcessorShortcutHyperlinks(this,CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_CopyHero);
               break;
            case CONST_POPTIPS.POPTIP_Goto_BigDipper:
               this.ProcessorShortcutBigDipper();
               break;
            case CONST_POPTIPS.POPTIP_Goto_MakeEquip:
               this.ProcessorShortcutHyperlinks(this,CONST_SHORTCUTS.POSITION_Additional,CONST_SHORTCUTS.TYPE_Additional_MakeEquip);
               break;
            case CONST_POPTIPS.POPTIP_Goto_DailyActivity:
               this.ProcessorShortcutHyperlinks(this,CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_DailyActivity);
               break;
            case CONST_POPTIPS.POPTIP_Goto_Mentorship:
               this.ProcessorShortcutHyperlinks(this,CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_Slave);
               break;
            case CONST_POPTIPS.POPTIP_Goto_DailyWelfare:
               this.ProcessorShortcutHyperlinks(this,CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_DailyWelfare);
               break;
            case CONST_POPTIPS.POPTIP_Goto_Tower:
               this.ProcessorShortcutHyperlinks(this,CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_Tower);
               break;
            case CONST_POPTIPS.POPTIP_Goto_Magic_Moutain:
               this.ProcessorShortcutHyperlinks(this,CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_Moutain,1);
               break;
            case CONST_POPTIPS.POPTIP_Goto_Magic:
               this.ProcessorShortcutHyperlinks(this,CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_Magic);
               break;
            case CONST_POPTIPS.POPTIP_Goto_Title:
               this.ProcessorShortcutHyperlinks(this,CONST_SHORTCUTS.POSITION_Function,CONST_SHORTCUTS.TYPE_Function_Heros);
               break;
            case CONST_POPTIPS.POPTIP_Goto_NijiaStar:
               this.ProcessorShortcutHyperlinks(this,CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_NijiaStar);
               break;
            case CONST_POPTIPS.POPTIP_Goto_SevenKing:
               this.ProcessorShortcutHyperlinks(this,CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_SevenKing);
               break;
            case CONST_POPTIPS.POPTIP_Goto_CrossServerWar:
               this.ProcessorShortcutHyperlinks(this,CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_CrossServerWar);
               break;
            case CONST_POPTIPS.POPTIP_Goto_InheritPractice:
               this.ProcessorShortcutHyperlinks(this,CONST_SHORTCUTS.POSITION_Function,CONST_SHORTCUTS.TYPE_Function_InheritPractice);
               break;
            case CONST_POPTIPS.POPTIP_Goto_Campaign:
               this.ProcessorShortcutHyperlinks(this,CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_Choose);
               break;
            case CONST_POPTIPS.POPTIP_Goto_NijiaMystic:
               this.ProcessorShortcutHyperlinks(this,CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_NijiaMystic);
               break;
            case CONST_POPTIPS.POPTIP_Goto_SixFairy:
               this.ProcessorShortcutHyperlinks(this,CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_SixFairy);
               break;
            case CONST_POPTIPS.POPTIP_Goto_BloodSoulPurgatory:
               this.ProcessorShortcutHyperlinks(this,CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_Laboratory);
               break;
            case CONST_POPTIPS.POPTIP_Goto_Vip:
               this.ProcessorShortcutHyperlinks(this,CONST_SHORTCUTS.POSITION_Avatar,CONST_SHORTCUTS.TYPE_Avatar_VIP);
               break;
            case CONST_POPTIPS.POPTIP_Goto_GodTree:
               this.ProcessorShortcutHyperlinks(this,CONST_SHORTCUTS.POSITION_Function,CONST_SHORTCUTS.TYPE_Function_OrganiZation,3);
               break;
            case CONST_POPTIPS.POPTIP_Goto_GroupBattle:
               this.ProcessorShortcutHyperlinks(this,CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_GroupBattle);
               break;
            case CONST_POPTIPS.POPTIP_Goto_TopOrganization:
               this.ProcessorShortcutHyperlinks(this,CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_TopOrganization);
               break;
            case CONST_POPTIPS.POPTIP_Goto_TopTeam:
               this.ProcessorShortcutHyperlinks(this,CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_TopTeam);
               break;
            case CONST_POPTIPS.POPTIP_Goto_BloodFete:
               this.ProcessorShortcutHyperlinks(this,CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_BloodFete);
               break;
            case CONST_POPTIPS.POPTIP_Goto_Taboo:
               this.ProcessorShortcutHyperlinks(this,CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_Taboo);
               break;
            case CONST_POPTIPS.POPTIP_Goto_Wing:
               this.ProcessorShortcutHyperlinks(this,CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_Wing);
               break;
            case CONST_POPTIPS.POPTIP_Goto_Challenge:
               this.ProcessorShortcutHyperlinks(this,CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_Challenge);
         }
      }
      
      protected function ProcessorOnOpenShinobidoPractise(param1:Object) : void
      {
         this.ProcessorWindowsSwitch(this.FProcessorShinobidoPractise);
      }
      
      protected function ProcessorOnUpdateShortcutsState(param1:Object, param2:Object) : void
      {
         this.FProcessorShortcuts.UpdateShortcutsState(param1,param2);
         if(SLogicsCore.Character.RoleSencePosition == CONST_COMMON.SCENEPOSITION_BATTLESENCE_AUTO)
         {
            this.ProcessorOnAutoBattleMainUISet(this,true);
         }
      }
      
      protected function ProcessorOnUpdateSecondaryStatus() : void
      {
         this.FProcessorShortcuts.UpdateNewActiveListStatus();
      }
      
      protected function ProcessorOnUnlockNotification(param1:Object, param2:Object) : void
      {
         this.FProcessorShortcuts.UnlockNotification(param1,param2);
      }
      
      protected function ProcessorOnUnlockedNotification(param1:Object, param2:int, param3:int) : void
      {
         this.FProcessorFreshGuide.UnlockNewFunction(param2,param3);
      }
      
      protected function ProcessorOnUnlockResponse(param1:Object, param2:TBounds, param3:Object) : void
      {
         this.FProcessorUnlock.UnlockResponse(param1,param2,param3);
      }
      
      protected function OnProcessorPlayView(param1:Object, param2:int, param3:int) : void
      {
         if(this.FProcessorPlayView != null)
         {
            this.FProcessorPlayView(param1,param2,param3);
         }
      }
      
      protected function OnSetSceneBitmapData(param1:Object, param2:BitmapData) : void
      {
         if(this.FSetSceneBitmapData != null)
         {
            this.FSetSceneBitmapData(param1,param2);
         }
      }
      
      protected function ProcessorAllHeroEquipmentMountedSuitCount(param1:Object) : void
      {
         this.FProcessorHeros.UpdateAllHeroEquipmentMountedSuitCount();
      }
      
      protected function ProcessorOnEnabledCheckSpeedUp(param1:Object) : void
      {
      }
      
      protected function ProcessorOnCheckKingwarIconEffect(param1:Object) : void
      {
         this.FProcessorKingWar.ProcessorCheckEffect();
      }
      
      protected function ProcessorOnAddTitle(param1:uint) : void
      {
      }
      
      protected function ProcessorOnShowHeroInfor(param1:Object, param2:uint, param3:uint) : void
      {
         this.FProcessorInspector.RequestShowHero(param2,param3);
      }
      
      protected function ProcessorOnShowInventoryInfor(param1:Object, param2:uint, param3:uint, param4:uint, param5:uint, param6:uint) : void
      {
         this.FProcessorInspector.RequestInventoryInfor(param2,param3,param4,param5,param6);
      }
      
      protected function ProcessorOnShowHeroDescription(param1:Object, param2:uint) : void
      {
         this.FProcessorInspector.RequestShowHeroDescription(param2);
      }
      
      protected function ProcessorOnOpenSocketLoading(param1:Object) : void
      {
         FAffairGenerator.Generate(AFFAIRID_OpenSocketLoading);
      }
      
      protected function ProcessorOnCloseSocketLoading(param1:Object) : void
      {
         FAffairGenerator.Generate(AFFAIRID_CloseSocketLoading);
      }
      
      protected function ProcessorOnMarquee(param1:Object, param2:Object) : void
      {
         if(this.FOnMarquee != null)
         {
            this.FOnMarquee(param1,param2);
         }
      }
      
      protected function ProcessorOnTyphon(param1:Object, param2:Object) : void
      {
         if(this.FOnTyphon != null)
         {
            this.FOnTyphon(param1,param2);
         }
      }
      
      protected function ProcessorOnEliteApply(param1:Object) : void
      {
         this.FProcessorCrossServerWar.EliteApply();
      }
      
      protected function ProcessorOnToastClick(param1:Object, param2:Object) : void
      {
         this.FProcessorCrossServerWar.Toast(param2);
      }
      
      protected function ProcessorOnRecruitCLick(param1:Object, param2:Object) : void
      {
         this.FProcessorCrossServerWar.Recruit(param2);
      }
      
      protected function ProcessorOnItemExchangeClick(param1:Object, param2:Object, param3:int) : void
      {
         this.FProcessorCrossServerWar.ItemExchange(param2,param3);
      }
      
      protected function ProcessorOnTokenExchangeClick(param1:Object, param2:Object, param3:int) : void
      {
         this.FProcessorCrossServerWar.TokenExchange(param2,param3);
      }
      
      protected function ProcessorOnRankingsReq(param1:Object) : void
      {
         this.FProcessorCrossServerWar.RankingsReq();
      }
      
      protected function ProcessorOnToastReq(param1:Object) : void
      {
         this.FProcessorCrossServerWar.ToastReq();
      }
      
      protected function ProcessorOnEliteRecordReq(param1:Object) : void
      {
         this.FProcessorCrossServerWar.EliteRecordReq();
      }
      
      protected function ProcessorOnShowAndHideMainSceneRoles(param1:Object, param2:Boolean) : void
      {
         this.FProcessorMainScene.ShowAndHideMainSceneRoles(param2);
         SLogicsCore.IsShowAllUser = param2;
         if(SLogicsCore.Character.RoleSencePosition == CONST_COMMON.SCENEPOSITION_CityDefend)
         {
            this.FProcessorCityDefend.ShowAndHide(param2);
         }
         else if(SLogicsCore.Character.RoleSencePosition == CONST_COMMON.SCENEPOSITION_FightPet)
         {
            this.FProcessorFightPet.ShowAndHide(param2);
         }
         else if(SLogicsCore.Character.RoleSencePosition == CONST_COMMON.SCENEPOSITION_TraitorAttack)
         {
            this.FProcessorTraitorAttack.ShowAndHide(param2);
         }
         else if(SLogicsCore.Character.RoleSencePosition == CONST_COMMON.SCENEPOSITION_FightAnimal)
         {
            this.FProcessorAnimalSeal.ShowAndHide(param2);
         }
      }
      
      protected function ProcessorOnQueryShortcutCoordinate(param1:Object, param2:uint, param3:uint, param4:TQueryCoordinate) : void
      {
         this.FProcessorShortcuts.QueryShortcutCoordinate(param1,param2,param3,param4);
      }
      
      protected function ProcessorOnEffectAcquireInventory(param1:Object, param2:Object, param3:TEffectCoordinateParameters) : void
      {
         this.FProcessorEffect.ImportAcquireInventory(param2,param3);
      }
      
      protected function ProcessorOnEffectBaseGlowVIP(param1:Object, param2:Boolean) : void
      {
         this.FProcessorShortcuts.EffectBaseGlowVIP(param1,param2);
      }
      
      protected function ProcessorOnEffectBaseGlowSVIP(param1:Object, param2:Boolean) : void
      {
         this.FProcessorShortcuts.EffectBaseGlowSVIP(param1,param2);
      }
      
      protected function ProcessorOnEffectGlowFilter(param1:Boolean) : void
      {
         this.FProcessorWorldMatch.UpdateEffectGlowFilter(param1);
      }
      
      protected function ProcessorOnUpdateChapterReward() : void
      {
         this.FProcessorGlobalBoss.UpdateChapterReward();
      }
      
      protected function EffectGenerateTextByErrorCode(param1:uint) : void
      {
         var _loc2_:TBins = null;
         var _loc3_:TErrorCode = null;
         var _loc4_:String = null;
         _loc4_ = null;
         _loc2_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_ErrorCode);
         if(_loc2_ != null)
         {
            _loc3_ = _loc2_.GetDatebaseByIdentifier(param1) as TErrorCode;
            if(_loc3_ != null)
            {
               _loc4_ = _loc3_.Desc;
            }
         }
         if(_loc4_ == null)
         {
            _loc4_ = "Error Code: " + param1.toString();
            this.ProcessorOnDialogMsg(this,_loc4_);
         }
         if(_loc3_ != null)
         {
            switch(_loc3_.Type)
            {
               case TYPE_EFFECTTEXT:
                  this.ProcessorsOnEffectText(this,_loc4_);
                  break;
               case TYPE_DIALOGMSG:
                  this.ProcessorOnDialogMsg(this,_loc4_);
            }
         }
      }
      
      protected function ProcessorLobbyOnInitBattle(param1:Object, param2:Boolean = false, param3:uint = 0) : void
      {
         this.ProcessorPlateSwitch(null);
         this.ProcessorWindowsSwitch(null);
         this.FChatOptions.ChatStatus = CONST_CHAT.MODE_Hidden;
         this.FProcessorChat.SetChatOptions(this.FChatOptions);
         if(param2)
         {
            if(param3 == 0)
            {
               this.FOnSetupGroupBattle(this,this.FChatOptions);
            }
            else
            {
               this.FOnSetupTopTeamBattle(this,this.FChatOptions);
            }
         }
         else
         {
            this.FOnSetupBattle(this,this.FChatOptions);
         }
         FAffairGenerator.Generate(AFFAIRID_GameStateExternalize);
         FAffairGenerator.Generate(AFFAIRID_TimingWaitBattleLoading);
         FAffairGenerator.Generate(AFFAIRID_ChatOptionsApply);
         this.FProcessorModuleLoader.Stop();
      }
      
      protected function OnChangeGlobalBattleScore(param1:int) : void
      {
         if(this.FSetGlobalBattleScore != null)
         {
            this.FSetGlobalBattleScore(param1);
         }
      }
      
      protected function ProcessorOnSetGlobalboss(param1:TGlobalboss) : void
      {
         if(this.FSetGlobalboss != null)
         {
            this.FSetGlobalboss(param1);
         }
      }
      
      public function ProcessorOnSwitchLobbyFromBattle(param1:Object, param2:int, param3:Boolean) : void
      {
         this.FProcessorModuleLoader.Start();
         if(SLogicsCore.Character.IsSkillShowTime)
         {
            if(this.ChatVisibel)
            {
               this.FChatOptions.ChatStatus = CONST_CHAT.MODE_None;
            }
            else
            {
               this.FChatOptions.ChatStatus = CONST_CHAT.MODE_Hidden;
            }
            this.FProcessorChat.SetChatOptions(this.FChatOptions);
            return;
         }
         switch(param2)
         {
            case CONST_BATTLE.BattleType_KillHero:
               if(param3)
               {
                  this.ProcessorPlateSwitch(this.FProcessorMainScene);
                  this.ProcessorWindowsSwitch(this.FProcessorKillHeros);
                  this.FProcessorMainScene.Visible = true;
                  this.FProcessorKillHeros.Visible = true;
               }
               else
               {
                  this.ProcessorPlateSwitch(this.FProcessorBattleScene);
                  this.FProcessorBattleScene.Visible = true;
               }
               break;
            case CONST_BATTLE.BattleType_Arena:
               this.ProcessorPlateSwitch(this.FProcessorArena);
               this.FProcessorArena.Visible = true;
               break;
            case CONST_BATTLE.BattleType_TreasureMap:
               this.ProcessorPlateSwitch(this.FProcessorTreasureMap);
               this.FProcessorTreasureMap.Visible = true;
               break;
            case CONST_BATTLE.BattleType_SevenKing:
               this.ProcessorPlateSwitch(this.FProcessorSevenKing);
               this.FProcessorSevenKing.Visible = true;
               break;
            case CONST_BATTLE.BattleType_CrossServerWar:
               this.FProcessorCrossServerWar.IsWin = param3;
               this.ProcessorPlateSwitch(this.FProcessorCrossServerWar);
               this.FProcessorCrossServerWar.Visible = true;
               break;
            case CONST_BATTLE.BattleType_Magic:
            case CONST_BATTLE.BattleType_FightPet:
            case CONST_BATTLE.BattleType_CityDefend:
            case CONST_BATTLE.BattleType_OrganizationWar:
            case CONST_BATTLE.BattleType_TraitorAttack:
            case CONST_BATTLE.BattleType_Slave:
            case CONST_BATTLE.BattleType_Tower:
            case CONST_BATTLE.BattleType_Palace:
            case CONST_BATTLE.BattleType_OrganizationBoss:
               break;
            default:
               this.ProcessorPlateSwitch(this.FProcessorBattleScene);
               this.FProcessorBattleScene.Visible = true;
         }
      }
      
      public function ProcessorOnSwitchLobbyFromGroupBattle(param1:Object, param2:int, param3:Boolean) : void
      {
         this.FProcessorModuleLoader.Start();
         switch(param2)
         {
            case CONST_GROUPBATTLE.BattleType_PVE:
            case CONST_GROUPBATTLE.BattleType_PVP:
         }
      }
      
      public function ProcessorOnSwitchLobbyFromTopTeam(param1:Object) : void
      {
         this.FProcessorModuleLoader.Start();
         this.ProcessorPlateSwitch(this.FProcessorPlateTopTeamRoomUI);
      }
      
      public function get OnLoadFollowUp() : Function
      {
         return this.FOnLoadFollowUp;
      }
      
      public function set OnLoadFollowUp(param1:Function) : void
      {
         this.FOnLoadFollowUp = param1;
      }
      
      public function get OnSetupBattle() : Function
      {
         return this.FOnSetupBattle;
      }
      
      public function set OnSetupBattle(param1:Function) : void
      {
         this.FOnSetupBattle = param1;
      }
      
      public function get OnSetupGroupBattle() : Function
      {
         return this.FOnSetupGroupBattle;
      }
      
      public function set OnSetupGroupBattle(param1:Function) : void
      {
         this.FOnSetupGroupBattle = param1;
      }
      
      public function get OnSetupTopTeamBattle() : Function
      {
         return this.FOnSetupTopTeamBattle;
      }
      
      public function set OnSetupTopTeamBattle(param1:Function) : void
      {
         this.FOnSetupTopTeamBattle = param1;
      }
      
      public function get OnQueryBattleActive() : Function
      {
         return this.FOnQueryBattleActive;
      }
      
      public function set OnQueryBattleActive(param1:Function) : void
      {
         this.FOnQueryBattleActive = param1;
      }
      
      public function get OnQueryBattleLoading() : Function
      {
         return this.FOnQueryBattleLoading;
      }
      
      public function set OnQueryBattleLoading(param1:Function) : void
      {
         this.FOnQueryBattleLoading = param1;
      }
      
      public function get OnLogout() : Function
      {
         return this.FOnLogout;
      }
      
      public function set OnLogout(param1:Function) : void
      {
         this.FOnLogout = param1;
      }
      
      public function get OnLoginDirSever() : Function
      {
         return this.FOnLoginDirSever;
      }
      
      public function set OnLoginDirSever(param1:Function) : void
      {
         this.FOnLoginDirSever = param1;
      }
      
      public function get OnPurchaseQuery() : Function
      {
         return this.FOnPurchaseQuery;
      }
      
      public function set OnPurchaseQuery(param1:Function) : void
      {
         this.FOnPurchaseQuery = param1;
      }
      
      public function get OnMarquee() : Function
      {
         return this.FOnMarquee;
      }
      
      public function set OnMarquee(param1:Function) : void
      {
         this.FOnMarquee = param1;
      }
      
      public function get OnTyphon() : Function
      {
         return this.FOnTyphon;
      }
      
      public function set OnTyphon(param1:Function) : void
      {
         this.FOnTyphon = param1;
      }
      
      public function get TurnBackBattleScene() : Function
      {
         return this.FProcessorBattleScene.TurnBackBattleScene;
      }
      
      public function set SetSceneBitmapData(param1:Function) : void
      {
         this.FSetSceneBitmapData = param1;
      }
      
      public function get SetSceneBitmapData() : Function
      {
         return this.FSetSceneBitmapData;
      }
      
      public function set ProcessorCheckPlot(param1:Function) : void
      {
         this.FProcessorCheckPlot = param1;
      }
      
      public function get ProcessorCheckPlot() : Function
      {
         return this.FProcessorCheckPlot;
      }
      
      public function set ProcessorPlayView(param1:Function) : void
      {
         this.FProcessorPlayView = param1;
      }
      
      public function get ProcessorPlayView() : Function
      {
         return this.FProcessorPlayView;
      }
      
      public function set OnUnLoadResource(param1:Function) : void
      {
         this.FOnUnLoadResource = param1;
      }
      
      public function get OnUnLoadResource() : Function
      {
         return this.FOnUnLoadResource;
      }
      
      public function get SetMonsterCount() : Function
      {
         return this.FSetMonsterCount;
      }
      
      public function set SetMonsterCount(param1:Function) : void
      {
         this.FSetMonsterCount = param1;
      }
      
      public function get SetStatusType() : Function
      {
         return this.FSetStatusType;
      }
      
      public function set SetStatusType(param1:Function) : void
      {
         this.FSetStatusType = param1;
      }
      
      public function get SetBattlePacket() : Function
      {
         return this.FSetBattlePacket;
      }
      
      public function set SetBattlePacket(param1:Function) : void
      {
         this.FSetBattlePacket = param1;
      }
      
      public function get OnAntiAddiction() : Function
      {
         return this.FOnAntiAddiction;
      }
      
      public function set OnAntiAddiction(param1:Function) : void
      {
         this.FOnAntiAddiction = param1;
      }
      
      public function get OnOpenSocketLoading() : Function
      {
         return this.FOnOpenSocketLoading;
      }
      
      public function set OnOpenSocketLoading(param1:Function) : void
      {
         this.FOnOpenSocketLoading = param1;
      }
      
      public function get OnCloseSocketLoading() : Function
      {
         return this.FOnCloseSocketLoading;
      }
      
      public function set OnCloseSocketLoading(param1:Function) : void
      {
         this.FOnCloseSocketLoading = param1;
      }
      
      public function set EndBattle(param1:Function) : void
      {
         this.FEndBattle = param1;
      }
      
      public function get SetGroupBattleType() : Function
      {
         return this.FSetGroupBattleType;
      }
      
      public function set SetGroupBattleType(param1:Function) : void
      {
         this.FSetGroupBattleType = param1;
      }
      
      public function get SetGroupBattleInfor() : Function
      {
         return this.FSetGroupBattleInfor;
      }
      
      public function set SetGroupBattleInfor(param1:Function) : void
      {
         this.FSetGroupBattleInfor = param1;
      }
      
      public function get SetGroupBattleReward() : Function
      {
         return this.FSetGroupBattleReward;
      }
      
      public function set SetGroupBattleReward(param1:Function) : void
      {
         this.FSetGroupBattleReward = param1;
      }
      
      public function get SetTopTeamBattleType() : Function
      {
         return this.FSetTopTeamBattleType;
      }
      
      public function set SetTopTeamBattleType(param1:Function) : void
      {
         this.FSetTopTeamBattleType = param1;
      }
      
      public function get SetTopTeamBattleInfor() : Function
      {
         return this.FSetTopTeamBattleInfor;
      }
      
      public function set SetTopTeamBattleInfor(param1:Function) : void
      {
         this.FSetTopTeamBattleInfor = param1;
      }
      
      public function get SetTopTeamBattleReward() : Function
      {
         return this.FSetTopTeamBattleReward;
      }
      
      public function set SetTopTeamBattleReward(param1:Function) : void
      {
         this.FSetTopTeamBattleReward = param1;
      }
      
      public function get SetGlobalBattleScore() : Function
      {
         return this.FSetGlobalBattleScore;
      }
      
      public function set SetGlobalBattleScore(param1:Function) : void
      {
         this.FSetGlobalBattleScore = param1;
      }
      
      public function get SetGlobalboss() : Function
      {
         return this.FSetGlobalboss;
      }
      
      public function set SetGlobalboss(param1:Function) : void
      {
         this.FSetGlobalboss = param1;
      }
      
      public function get OnGarbageCollector() : Function
      {
         return this.FOnGarbageCollector;
      }
      
      public function set OnGarbageCollector(param1:Function) : void
      {
         this.FOnGarbageCollector = param1;
      }
      
      public function IsOpenWindows(param1:Object) : Boolean
      {
         return this.FProcessorWindowsActive != null;
      }
      
      public function TurnBackKillHero(param1:Object, param2:Boolean, param3:int) : void
      {
         SResourcesCore.PerformAutoReleaseResources(CONST_MODULES.MODULE_Campaign);
         this.ProcessorOnReturnMainScene(param1);
         if(param2)
         {
            this.FProcessorKillHeros.UpdateKillHero(param3);
         }
         this.ProcessorWindowsSwitch(this.FProcessorKillHeros);
      }
      
      public function TurnBackArena(param1:Object) : void
      {
         this.ProcessorOnUpdatePrestige(param1);
         this.ProcessorPlateSwitch(this.FProcessorArena);
      }
      
      public function TurnBackTreasureMap(param1:Object, param2:Boolean = true) : void
      {
         if(!param2)
         {
            this.ProcessorsOnEffectText(this,STRING_TREASUREMAP.STRING_FightLost);
         }
         this.FProcessorTreasureMap.RobberyResult(param2);
         this.ProcessorPlateSwitch(this.FProcessorTreasureMap);
      }
      
      public function TurnBackCityDefend(param1:Object) : void
      {
         if(SLogicsCore.Character.RoleSencePosition == CONST_COMMON.SCENEPOSITION_CityDefend)
         {
            this.FProcessorCityDefend.BattleBack = true;
            this.ProcessorPlateSwitch(this.FProcessorCityDefend);
         }
         else
         {
            this.ProcessorPlateSwitch(this.FProcessorMainScene);
            SResourcesCore.PerformAutoReleaseResources(CONST_MODULES.MODULE_CityDefend);
         }
      }
      
      public function TurnBackFightPet(param1:Object) : void
      {
         if(SLogicsCore.Character.RoleSencePosition == CONST_COMMON.SCENEPOSITION_FightPet)
         {
            this.ProcessorPlateSwitch(this.FProcessorFightPet);
            this.FProcessorFightPet.BattleEnd();
         }
         else
         {
            this.ProcessorPlateSwitch(this.FProcessorMainScene);
            SResourcesCore.PerformAutoReleaseResources(CONST_MODULES.MODULE_FightPet);
         }
      }
      
      public function ProcessorShortcutBigDipper() : void
      {
         var _loc1_:String = null;
         var _loc2_:TConfigValue = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.SERVENSTAR_OPEN_LEVEL) as TConfigValue;
         _loc3_ = _loc2_.Value as uint;
         _loc4_ = uint(SLogicsCore.Character.GetMainLevel());
         if(_loc4_ >= _loc3_)
         {
            this.ProcessorShortcutsOnBigDipper(this);
         }
         else
         {
            _loc1_ = TUtilityString.Format(STRING_LOBBY.FORMAT_OPEN_BIGDIPPER_LEVEL,_loc3_);
            this.ProcessorsOnEffectText(this,_loc1_);
         }
      }
      
      public function TurnBackTraitorAttack(param1:Object) : void
      {
         if(SLogicsCore.Character.RoleSencePosition == CONST_COMMON.SCENEPOSITION_TraitorAttack)
         {
            this.FProcessorTraitorAttack.BattleBack = true;
            this.ProcessorPlateSwitch(this.FProcessorTraitorAttack);
            this.FProcessorTraitorAttack.BattleEnd();
         }
         else
         {
            this.ProcessorPlateSwitch(this.FProcessorMainScene);
            SResourcesCore.PerformAutoReleaseResources(CONST_MODULES.MODULE_TraitorAttack);
         }
      }
      
      public function TurnBackSlave(param1:Object) : void
      {
         this.ProcessorOnReturnMainScene(param1);
         this.ProcessorWindowsSwitch(this.FProcessorMentorship);
      }
      
      public function TurnBackSevenKing(param1:Object) : void
      {
         this.FProcessorSevenKing.BattleBack = true;
         this.ProcessorPlateSwitch(this.FProcessorSevenKing);
      }
      
      public function TurnBackCrossServerWar(param1:Object, param2:Boolean) : void
      {
         this.FProcessorCrossServerWar.BattleBack = true;
         this.FProcessorCrossServerWar.IsWin = param2;
         this.ProcessorPlateSwitch(this.FProcessorCrossServerWar);
         this.FProcessorCrossServerWar.PlayTextEffect();
      }
      
      public function TurnBackMagic(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         this.ProcessorOnReturnMainScene(param1);
         this.ProcessorWindowsSwitch(this.FProcessorMagic);
         this.FProcessorMagic.PlayTextEffect();
      }
      
      public function TurnBackTower(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         this.ProcessorOnReturnMainScene(param1);
         this.ProcessorWindowsSwitch(this.FProcessorTower);
         this.FProcessorTower.PlayTextEffect();
      }
      
      public function TurnBackPalace(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         this.ProcessorOnReturnMainScene(param1);
         this.FProcessorPalace.PalaceEnterReq();
      }
      
      public function TurnBackOrganizationBoss(param1:Object, param2:Boolean) : void
      {
         if(SLogicsCore.Character.RoleSencePosition == CONST_COMMON.SCENEPOSITION_FightAnimal)
         {
            this.FProcessorAnimalSeal.BattleResult(param2);
            this.ProcessorPlateSwitch(this.FProcessorAnimalSeal);
            this.FProcessorAnimalSeal.BattleEnd();
         }
         else
         {
            this.ProcessorPlateSwitch(this.FProcessorMainScene);
            SResourcesCore.PerformAutoReleaseResources(CONST_MODULES.MODULE_FightPetCopy);
         }
      }
      
      public function TurnBackFriend(param1:Object) : void
      {
         this.ProcessorPlateSwitch(this.FProcessorMainScene);
         this.ProcessorWindowsSwitch(this.FProcessorFriend);
      }
      
      public function TurnBackBloodSoul(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(2);
         this.FProcessorWindowBloodSoulPurgatoryMain.FilghtReadOver();
         this.ProcessorPlateSwitch(this.FProcessorMainScene);
         this.ProcessorWindowsSwitch(this.FProcessorWindowBloodSoulPurgatoryMain,_loc2_);
      }
      
      public function TurnBackSixFairy(param1:Object) : void
      {
         this.ProcessorPlateSwitch(this.FProcessorMainScene);
         this.ProcessorWindowsSwitch(this.FProcessorWindowSixFairyMain);
         this.FProcessorWindowSixFairyMain.FilghtReadOver();
      }
      
      public function TurnBackUndertown(param1:Object) : void
      {
         this.ProcessorPlateSwitch(this.FProcessorMainScene);
         this.ProcessorWindowsSwitch(this.FProcessorWindowUndertown);
      }
      
      public function TurnBackRebirthRealm(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(2);
         this.ProcessorPlateSwitch(this.FProcessorMainScene);
         this.ProcessorWindowsSwitch(this.FProcessorWindowRebirthRealmAllManager,_loc2_);
         this.FProcessorWindowRebirthRealmAllManager.FilghtReadOver();
      }
      
      public function TurnBackTransmigrationTrial(param1:Object) : void
      {
         this.ProcessorPlateSwitch(this.FProcessorMainScene);
         this.ProcessorWindowsSwitch(this.FProcessorTransmigrationTrial);
      }
      
      public function TurnBackTaboo(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(2);
         this.ProcessorPlateSwitch(this.FProcessorMainScene);
         this.ProcessorWindowsSwitch(this.FPressorWindowTaboo,_loc2_);
         this.FPressorWindowTaboo.FilghtReadOver();
      }
      
      public function TurnBackTransmigrationAccessory(param1:Object) : void
      {
         this.ProcessorPlateSwitch(this.FProcessorMainScene);
         this.ProcessorWindowsSwitch(this.FProcessorTransmigrationAccessory);
      }
      
      public function TurnBackRoom(param1:Object) : void
      {
         this.ProcessorOnReturnMainScene(param1);
         SLogicsCore.GroupBattleData.IsInBattle = false;
         if(SLogicsCore.GroupBattleData.PVETimes <= 0)
         {
            this.ProcessorWindowsSwitch(this.FProcessorGroupBattle);
         }
         else if(SLogicsCore.GroupBattleData.RoomDetailInfo.RoomID == 0)
         {
            this.ProcessorWindowsSwitch(this.FProcessorGroupBattle);
         }
         else
         {
            this.ProcessorPlateSwitch(this.FProcessorGroupBattleRoomUI);
            this.FProcessorGroupBattleRoomUI.CheckAutoStart();
         }
      }
      
      public function TurnBackTopTeam(param1:Object) : void
      {
         SLogicsCore.TopTeamData.IsInBattle = false;
         if(SLogicsCore.TopTeamData.RestPlayCount <= 0)
         {
            this.ProcessorPlateSwitch(this.FProcessorMainScene);
            this.ProcessorWindowsSwitch(this.FProcessorTopTeam);
         }
         else if(SLogicsCore.TopTeamData.TopTeamRoomDetailInfo.RoomID == 0)
         {
            this.ProcessorWindowsSwitch(this.FProcessorTopTeam);
         }
         else
         {
            this.FProcessorTopTeam.RequestRoomData(SLogicsCore.TopTeamData.TopTeamRoomDetailInfo.RoomID);
         }
      }
      
      public function TurnBackAlien(param1:Object) : void
      {
         this.ProcessorPlateSwitch(this.FProcessorMainScene);
         this.ProcessorWindowsSwitch(this.FProcessorAline);
      }
      
      public function TurnBackQiecuo(param1:Object) : void
      {
         this.ProcessorPlateSwitch(this.FProcessorMainScene);
         this.ProcessorWindowsSwitch(this.FProcessorRank);
      }
      
      public function TurnBackGlobalBattle(param1:Object) : void
      {
         this.ProcessorPlateSwitch(this.FProcessorMainScene);
         this.ProcessorPlateSwitch(this.FProcessorGlobalBattle);
      }
      
      public function TurnBackWorldMatch(param1:Object) : void
      {
         this.ProcessorPlateSwitch(this.FProcessorMainScene);
         this.ProcessorPlateSwitch(this.FProcessorWorldMatch);
      }
      
      public function TurnBackSummonBattle(param1:Object) : void
      {
         this.ProcessorPlateSwitch(this.FProcessorMainScene);
         this.ProcessorPlateSwitch(this.FProcessorSummonBattle);
      }
      
      public function TurnBackChallengeCamp(param1:Object) : void
      {
         this.ProcessorPlateSwitch(this.FProcessorMainScene);
         this.ProcessorWindowsSwitch(this.FProcessorChallengeCamp);
      }
      
      public function TurnBackGlobalBoss(param1:Object) : void
      {
         var _loc2_:ByteArray = null;
         this.ProcessorPlateSwitch(this.FProcessorMainScene);
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(this.FProcessorGlobalBoss.GlobalbossChapterId);
         _loc2_.position = 0;
         this.ProcessorWindowsSwitch(this.FProcessorGlobalBoss,_loc2_);
      }
      
      public function TurnBackCrossSlave(param1:Object) : void
      {
         this.ProcessorOnReturnMainScene(param1);
         this.ProcessorWindowsSwitch(this.FProcessorSlave);
      }
      
      public function OnInitGroupBattle(param1:Object, param2:Boolean = true) : void
      {
         this.ProcessorLobbyOnInitBattle(param1,param2);
      }
      
      public function Distant(param1:Vector.<DataStructureForBloodSoul>) : void
      {
         this.FProcessorTacticalDeployment.FMC_Aboratory_Btn(param1);
      }
      
      protected function OpenThisPanelF(param1:int) : void
      {
         this.FProcessorShortcuts.UpdateSkipResurgenceBtnfilter(param1);
      }
      
      protected function UpdateHeroProperty() : void
      {
         this.FProcessorShortcuts.UserUpdateCharBaseInfo();
      }
      
      protected function SetChatPositionByType(param1:int) : void
      {
         this.FChatOptions.ChatStatus = CONST_CHAT.MODE_None;
         this.FProcessorChat.SetChatOptions(this.FChatOptions);
         this.FProcessorChat.ChangeChatPosition(param1);
      }
      
      protected function ProcessorSetChatOptions(param1:Object, param2:Boolean) : void
      {
         this.FChatOptions.ChatStatus = param2 ? CONST_CHAT.MODE_None : CONST_CHAT.MODE_Hidden;
         this.FProcessorChat.SetChatOptions(this.FChatOptions);
      }
      
      public function SendRechageRankRet(param1:Object, param2:TPacket) : void
      {
         this.FProcessorRecharge.SendRankData(param2);
      }
      
      protected function UpdateOthersPanel(param1:int) : void
      {
         switch(param1)
         {
            case 1:
               this.FProcessorSmithy.UpdateFreeCount();
               break;
            case 2:
               this.FProcessorArena.UpdateFreeCount();
               break;
            case 3:
               break;
            case 4:
               this.FProcessorGroupBattle.UpdateFreeCount();
               break;
            case 5:
            case 6:
            case 7:
            case 8:
            case 9:
               break;
            case 10:
               this.FPressorWindowTaboo.FTProcessorTa.UpdateRestCount();
         }
      }
      
      protected function JumpTerm(param1:int) : void
      {
         this.ProcessorWindowsSwitch(null);
         switch(param1)
         {
            case 0:
               break;
            case 1:
               this.ProcessorWindowsSwitch(this.FPressorWindowNewMall);
               break;
            case 2:
            case 3:
            case 4:
               break;
            case 5:
         }
      }
      
      protected function UpdateOtheroPanel(param1:TPacket) : void
      {
         this.FProcessorInspector.PacketPerform_SC_UpdateOtheroPanel(param1);
      }
      
      protected function FromNewMall(param1:int) : void
      {
         this.FProcessorSmithy.FromNewMallMessage(param1);
      }
      
      protected function OpenPanelZhenAoYi(param1:int) : void
      {
         var _loc2_:ByteArray = null;
         if(param1 > 0)
         {
            _loc2_ = new ByteArray();
            _loc2_.writeUnsignedInt(param1 - 1);
            _loc2_.position = 0;
         }
         this.ProcessorWindowsSwitch(this.FProcessorZhenAoYi,_loc2_);
      }
      
      protected function IconIsShow(param1:Boolean) : void
      {
         this.FProcessorShortcuts.IconIsShow(param1);
      }
      
      protected function OpenOnLineGift() : void
      {
         this.ProcessorWindowsSwitch(this.FProcessorOnLineLiBao);
      }
      
      public function set BeginSkillShow(param1:Function) : void
      {
         this.FBeginSkillShow = param1;
      }
      
      protected function BeginSkillShowF(param1:uint) : void
      {
         SLogicsCore.Character.IsSkillShowTime = true;
         if(this.FBeginSkillShow != null)
         {
            this.FBeginSkillShow(param1);
         }
         this.ChatVisibel = this.FProcessorChat.Visible;
         this.FChatOptions.ChatStatus = CONST_CHAT.MODE_Hidden;
         this.FProcessorChat.SetChatOptions(this.FChatOptions);
         this.FOnSetupBattle(this,this.FChatOptions);
         FAffairGenerator.Generate(AFFAIRID_GameStateExternalize);
         FAffairGenerator.Generate(AFFAIRID_TimingWaitBattleLoading);
         FAffairGenerator.Generate(AFFAIRID_ChatOptionsApply);
         this.FProcessorModuleLoader.Stop();
      }
      
      protected function GoToLostPanelFunction() : void
      {
         this.ProcessorWindowsSwitch(this.FProcessorLostShenQiMain);
      }
      
      protected function MC_Goto_FaQiFunction() : void
      {
         this.ProcessorWindowsSwitch(this.FProcessorTalisman);
      }
      
      public function TurnBackMiGong(param1:Object) : void
      {
         this.ProcessorPlateSwitch(this.FProcessorMainScene);
         this.FProcessorLostShenQiMain.FCurTabIndex = 1;
         this.ProcessorWindowsSwitch(this.FProcessorLostShenQiMain);
      }
      
      public function TurnBackMasterRoad(param1:Object) : void
      {
         this.ProcessorPlateSwitch(this.FProcessorMasterRoad);
      }
      
      public function TurnBackChallenge(param1:Object) : void
      {
         this.ProcessorPlateSwitch(this.FProcessorChallenge);
      }
      
      public function TurnBackWing(param1:Object) : void
      {
         this.ProcessorOnReturnMainScene(param1);
         this.ProcessorWindowsSwitch(this.FProcessorWing);
      }
   }
}

