package Logics
{
   import Foundation.Container.THashMap;
   import Logics.ActivityMode.TActivityModes;
   import Logics.ActivityMode.TPoolUIRewardItem;
   import Logics.AntiAddiction.TAntiAddiction;
   import Logics.Arena.TPoolArena;
   import Logics.BloodFete.TBloodFeteData;
   import Logics.Buffs.*;
   import Logics.Campaign.*;
   import Logics.Challenge.TChallenge;
   import Logics.Characters.*;
   import Logics.CityDefend.TPoolCityDefend;
   import Logics.ConsumeVip.TConsumeVipData;
   import Logics.CrossServerWar.TChallengePlayers;
   import Logics.CrossServerWar.TEliteRecord;
   import Logics.CrossServerWar.TPoolCrossServerReport;
   import Logics.CrossServerWar.TPoolToastRecord;
   import Logics.EightDoor.TEightDoorLogicData;
   import Logics.Exercise.ActivityA.TActivityA;
   import Logics.Exercise.ActivityB.TActivityB;
   import Logics.Exercise.AlchemyStudio.TAlchemyStudio;
   import Logics.Exercise.AncientTreasure.TAncientTreasure;
   import Logics.Exercise.AprilActive.TAprilActiveDatas;
   import Logics.Exercise.AugustActive.TAugustActiveDatas;
   import Logics.Exercise.BaseRank.TActiveRankDataNew;
   import Logics.Exercise.BaseRank.TActiveRankDatas;
   import Logics.Exercise.Bejeweled.TBejeweled;
   import Logics.Exercise.BlackMarket.TBlackMarket;
   import Logics.Exercise.BossTreasure.TBossTreasure;
   import Logics.Exercise.BrazilCarnival.TBrazilCarnivalDatas;
   import Logics.Exercise.CapsuleToys.TCapsuleToys;
   import Logics.Exercise.CatWomen.TCatWomen;
   import Logics.Exercise.Christmas.TChristmasDatas;
   import Logics.Exercise.Christmas2015.TChristmasDatas_2015;
   import Logics.Exercise.Christmas2016.TChristmasDatas_2016;
   import Logics.Exercise.ChristmasDay.TChristmasDay;
   import Logics.Exercise.CloudBuy.TCloudBuy;
   import Logics.Exercise.ComeBack.TComeBack;
   import Logics.Exercise.CommonRecharge.TCommonRecharge;
   import Logics.Exercise.ConsumeRank.TConsumeRank;
   import Logics.Exercise.Cornucopia.TCornucopia;
   import Logics.Exercise.CreationAncestor.TCreationAncestor;
   import Logics.Exercise.CrossServerSale.TCrossServerSale;
   import Logics.Exercise.DailyFirstRecharge.TDailyFirstRecharge;
   import Logics.Exercise.DailyRecharge.TDailyRecharge;
   import Logics.Exercise.DayRechargeGift.TDayRechargeGift;
   import Logics.Exercise.DecActive.TDecActiveDatas;
   import Logics.Exercise.DessertHouse.TDessertHouse;
   import Logics.Exercise.Dice.TDice;
   import Logics.Exercise.Discount.TDiscount;
   import Logics.Exercise.Double11Mall.TDouble11Mall;
   import Logics.Exercise.EverydaySale.TEverydaySale;
   import Logics.Exercise.Exorcism.TExorcism;
   import Logics.Exercise.FateRoulette.TFateRoulette;
   import Logics.Exercise.FebActive.TFebActiveDatas;
   import Logics.Exercise.FerrisWheel.TFerrisWheel;
   import Logics.Exercise.FightBoss.TFightBossDatas;
   import Logics.Exercise.FirstRechange_new.TFirstRechange_new_Model;
   import Logics.Exercise.FishGame.TPoolUIFish;
   import Logics.Exercise.FortuneCat.TFortuneCat;
   import Logics.Exercise.FrogWallet.TActivitiesData;
   import Logics.Exercise.FrogWallet.TTenTail;
   import Logics.Exercise.GodWelfare.TGodWelfare;
   import Logics.Exercise.GoldDigger.TGoldDigger;
   import Logics.Exercise.GoldTree.TGoldTree;
   import Logics.Exercise.GroupBuying.TGroupBuying;
   import Logics.Exercise.GuaGuaLe.TGuaGuaLe;
   import Logics.Exercise.Hallowmas.THallowmas;
   import Logics.Exercise.HallowmasActive.THallowmasActiveDatas;
   import Logics.Exercise.HappyTreasure.THappyTreasure;
   import Logics.Exercise.IdolumFight.TIdolumFight;
   import Logics.Exercise.InviteFriend.TInviteFriend;
   import Logics.Exercise.JanActive.TJanActiveDatas;
   import Logics.Exercise.JanActive_2016.TJanActiveDatas_2016;
   import Logics.Exercise.JulyActive.TJulyActiveDatas;
   import Logics.Exercise.JuneActive.TJuneActiveDatas;
   import Logics.Exercise.LoginGift.TLoginGift;
   import Logics.Exercise.LotteryMachine.TLotteryMachine;
   import Logics.Exercise.MarchActive.TMarchActiveDatas;
   import Logics.Exercise.MarchConsume.TMarchConsume;
   import Logics.Exercise.MayActive.TMayActiveDatas;
   import Logics.Exercise.MayActive2015.TMayActiveDatas_2015;
   import Logics.Exercise.MidAutumn.TMidAutumn;
   import Logics.Exercise.MoonFestival.TMoonFestivalDatas;
   import Logics.Exercise.NationalDay.TNationalDay;
   import Logics.Exercise.NationalDay_2015.TNationalDayDatas_2015;
   import Logics.Exercise.NewLottery.TNewLottery;
   import Logics.Exercise.NewYear.TNewYear;
   import Logics.Exercise.NinjaBank.TNinjaBank;
   import Logics.Exercise.NinjaCrystal.TNinjaCrystal;
   import Logics.Exercise.NinjaFund.TNinjaFund;
   import Logics.Exercise.NinjaMeet.TNinjaMeeting;
   import Logics.Exercise.NinjaTreasure.TNinjaTreasureDatas;
   import Logics.Exercise.NinjiaVillage.TNinjiaVillageData;
   import Logics.Exercise.Nov.TNov;
   import Logics.Exercise.Nov2016.TNov2016;
   import Logics.Exercise.NovActive.TNovActiveDatas;
   import Logics.Exercise.OctActive.TOctActiveDatas;
   import Logics.Exercise.OneWorthThousand.TOneWorthThousand;
   import Logics.Exercise.OrangeEquipment.TOrangeEquipment;
   import Logics.Exercise.PersiaTrader.TPersiaTrader;
   import Logics.Exercise.Pool.TPoolUIDiceLog;
   import Logics.Exercise.Pool.TPoolUINews;
   import Logics.Exercise.RechargeExchange.TRechargeExchange;
   import Logics.Exercise.RechargeGive.TRechargeGive;
   import Logics.Exercise.RechargeRank.TRechargeRank;
   import Logics.Exercise.SeptemberActive.TSeptemberActiveDatas;
   import Logics.Exercise.SeventhEvening.TSeventhEvening;
   import Logics.Exercise.SignGift.TSignGift;
   import Logics.Exercise.SingleTopUp.TSingleTopUp;
   import Logics.Exercise.Smelt.TSmelt;
   import Logics.Exercise.SpringFestival.TSpringFestivalDatas;
   import Logics.Exercise.SuperChristmas.TSuperChristmas;
   import Logics.Exercise.TActivityTaskData;
   import Logics.Exercise.ThanksgivingDay.TThanksgivingDayDatas;
   import Logics.Exercise.TowerLottery.TTowerLottery;
   import Logics.Exercise.TreasureBox.TTreasureBox;
   import Logics.Exercise.ValentineDay.TValentineDayDatas;
   import Logics.Exercise.VipFreeBuy.TVipFreeBuy;
   import Logics.Exercise.VipShop.TVipShop;
   import Logics.Exercise.VipTreasure.TVipTreasure;
   import Logics.Exercise.WanSheng.TWanSheng;
   import Logics.Exercise.WanSheng2.TWanSheng2;
   import Logics.Exercise.WishTree.TWishTree;
   import Logics.Exercise.WitchProving.TWitchProving;
   import Logics.Exercise.WorldCup.TWorldCupDatas;
   import Logics.Generals.*;
   import Logics.GlobalBattle.TGlobalBattle;
   import Logics.Globalboss.TGlobalboss;
   import Logics.Globalboss.TGlobalbossChapter;
   import Logics.GroupBattle.TGroupBattleData;
   import Logics.HyperStrings.*;
   import Logics.Inventories.*;
   import Logics.Items.TPoolItem;
   import Logics.LostShenQi.TLostShenQiLogicData;
   import Logics.Lottery.TLottery;
   import Logics.Lottery.TPoolUILotteryNews;
   import Logics.Magic.TMagicData;
   import Logics.Mail.*;
   import Logics.MainScene.*;
   import Logics.MasterRoad.TMasterRoad;
   import Logics.Mentorship.TMentorship;
   import Logics.NarutoHelper.TNarutoHelperData;
   import Logics.NarutoRoad.TNarutoRoadData;
   import Logics.NewActivity.TActivityThirdModes;
   import Logics.NewActivity.TNewActivityModes;
   import Logics.NijiaMystic.TNijiaMysticData;
   import Logics.NinjaHostel.TNinjaHostelData;
   import Logics.NinjaRelation.TNinjaRelationData;
   import Logics.Organization.TBaseOrganization;
   import Logics.Palace.TPalaceData;
   import Logics.Palace.TPoolPalaceReport;
   import Logics.Prerogative.TPlatformPrerogative;
   import Logics.Quests.*;
   import Logics.Ramn.TPoolFriendRamen;
   import Logics.Ramn.TRamenData;
   import Logics.Signals.*;
   import Logics.Skills.*;
   import Logics.Smithy.TPoolUISingleEquipment;
   import Logics.Spaces.*;
   import Logics.Streamization.Arena.TUnstreamizerArena;
   import Logics.Streamization.Buffs.*;
   import Logics.Streamization.Campaign.TUnstreamizerCampaignUnknown;
   import Logics.Streamization.Characters.*;
   import Logics.Streamization.CityDefend.TUnstreamizerCityDefend;
   import Logics.Streamization.CrossServerWar.TUnstreamizerCrossServerReport;
   import Logics.Streamization.CrossServerWar.TUnstreamizerToastRecord;
   import Logics.Streamization.HyperStrings.Common.*;
   import Logics.Streamization.Inventories.*;
   import Logics.Streamization.Items.TUnstreamizerItemUnknown;
   import Logics.Streamization.Mail.TUnstreamizerMailUnknown;
   import Logics.Streamization.Palace.TUnstreamizerPalace;
   import Logics.Streamization.Quest.TUnstreamizerQuestUnknown;
   import Logics.Streamization.Ramen.TUnstreamizerRamen;
   import Logics.Streamization.Skills.*;
   import Logics.Streamization.Tavern.TUnstreamizerTavern;
   import Logics.Streamization.TraitorAttack.TUnstreamizerTraitorAttack;
   import Logics.Streamization.TreasureMap.TUnstreamizerTreasureMap;
   import Logics.SystemActivity.TSystemActivities;
   import Logics.Talent.TNinjaTalentData;
   import Logics.Tavern.*;
   import Logics.TheWorldTree.TTheWorldTreeLogicData;
   import Logics.TimeCoolDown.TTimeCoolDown;
   import Logics.TimeCoolDown.TTimeCoolDowns;
   import Logics.Title.TTitles;
   import Logics.TongLing.TTongLingDatas;
   import Logics.TopOrganization.TPoolUIOrgMember;
   import Logics.TopOrganization.TTopOrganizationData;
   import Logics.TopTeam.TTopTeamData;
   import Logics.TraitorAttack.TPoolTraitorAttack;
   import Logics.TransmigrationAccessory.TTransmigrationAccessoryData;
   import Logics.TransmigrationTrial.TTransmigrationTrialData;
   import Logics.TreasureMap.TPoolTreasureMap;
   import Logics.Undertown.TUndertownLogicData;
   import Logics.Unlocks.TUnlocks;
   import Logics.Warehouse.TWarehouse;
   import Logics.WorldMatch.TWorldMatch;
   import Logics.ZhenAoYi.TZhenAoYiLogicData;
   import Processors.Game.Lobby.FreshGuide.*;
   import Processors.Game.Lobby.OhtsutsukiKaguya.Data.OhtsutsukiKaguyaData;
   import Processors.Game.Lobby.RebirthRealm.TRebirthRealmBaseData;
   import Processors.Game.Lobby.Shop.data.ShopData;
   import Processors.Game.Lobby.Store.data.NewMallData;
   import Processors.Game.Lobby.Taboo.Data.TabooData;
   import Processors.Game.Lobby.TacticalDeployment.TAutoChangeFormInfo;
   import Processors.Game.Lobby.awaken.date.AwakenLogicDate;
   import Rendering.HyperStrings.*;
   import Resources.Constants.CONST_ACTIVITY_MODE;
   
   use namespace LogicsSpace;
   
   public class TLogicsCore
   {
      
      protected static const ACTIVITY_COUNT:uint = CONST_ACTIVITY_MODE.ACTIVITY_COUNT;
      
      protected var FPoolSignal:TPoolSignal;
      
      protected var FCharacter:TCharacter;
      
      protected var FNPCs:TNPCs;
      
      protected var FRoleDigests:TRoleDigests;
      
      protected var FFriends:TFriendDigests;
      
      protected var FMails:TMails;
      
      protected var FQuests:TQuests;
      
      protected var FRamenData:TRamenData;
      
      protected var FNodal:TNodal;
      
      protected var FGeneral:TGenerals;
      
      protected var FUnlocks:TUnlocks;
      
      protected var FProcessorFreshGuide:TProcessorFreshGuide;
      
      protected var FScreenMapX:Number;
      
      protected var FScreenMapY:Number;
      
      protected var FAutoSearching:Boolean;
      
      protected var FAutoSearchQuest:TQuest;
      
      protected var FPlayPlotState:int;
      
      protected var FAntiAddiction:TAntiAddiction;
      
      protected var FActivityModes:TActivityModes;
      
      protected var FCounterLimit:THashMap;
      
      protected var FSignals:Vector.<TSignal>;
      
      protected var FPoolCharacter:TPoolCharacter;
      
      protected var FPoolInventory:TPoolInventory;
      
      protected var FPoolQuest:TPoolQuest;
      
      protected var FPoolSkill:TPoolSkill;
      
      protected var FPoolBuff:TPoolBuff;
      
      protected var FPoolArena:TPoolArena;
      
      protected var FPoolMail:TPoolMail;
      
      protected var FPoolTavern:TPoolTavern;
      
      protected var FPoolCampaign:TPoolCampaign;
      
      protected var FPoolItem:TPoolItem;
      
      protected var FPoolTreasureMap:TPoolTreasureMap;
      
      protected var FPoolCityDefend:TPoolCityDefend;
      
      protected var FPoolTraitorAttack:TPoolTraitorAttack;
      
      protected var FPoolFriendRamen:TPoolFriendRamen;
      
      protected var FPoolToastRecord:TPoolToastRecord;
      
      protected var FPoolCrossServerReport:TPoolCrossServerReport;
      
      protected var FPoolPalaceReport:TPoolPalaceReport;
      
      protected var FPoolHyperString:TPoolHyperString;
      
      protected var FPoolUIRoleCanMove:TPoolUIRoleCanMove;
      
      protected var FPoolUISingleEquipment:TPoolUISingleEquipment;
      
      protected var FPoolUIRewardItem:TPoolUIRewardItem;
      
      protected var FPoolUILotteryNews:TPoolUILotteryNews;
      
      protected var FPoolUINews:TPoolUINews;
      
      protected var FPoolUIDiceLog:TPoolUIDiceLog;
      
      protected var FPoolUIFish:TPoolUIFish;
      
      protected var FPoolUIOrgMember:TPoolUIOrgMember;
      
      protected var FStepChallengePlayers:TChallengePlayers;
      
      protected var FSkipChallengePlayers:TChallengePlayers;
      
      protected var FEliteRecord:TEliteRecord;
      
      protected var FTitles:TTitles;
      
      protected var FStatisticalStep:uint;
      
      protected var FOrganization:TBaseOrganization;
      
      protected var FLottery:TLottery;
      
      protected var FNewActivityModes:TNewActivityModes;
      
      protected var FSystemActivities:TSystemActivities;
      
      protected var FNarutoRoadData:TNarutoRoadData;
      
      protected var FBigDipperFreeTime:int;
      
      protected var FMentorship:TMentorship;
      
      protected var FActivitiesData:TActivitiesData;
      
      protected var FVipShop:TVipShop;
      
      protected var FDice:TDice;
      
      protected var FConsumeRank:TConsumeRank;
      
      protected var FRechargeRank:TRechargeRank;
      
      protected var FCommonRecharge:TCommonRecharge;
      
      protected var FTenTail:TTenTail;
      
      protected var FVipFreeBuy:TVipFreeBuy;
      
      protected var FSeventhEvening:TSeventhEvening;
      
      protected var FHappyTreasure:THappyTreasure;
      
      protected var FGroupBuying:TGroupBuying;
      
      protected var FRechargeExchange:TRechargeExchange;
      
      protected var FOrangeEquipment:TOrangeEquipment;
      
      protected var FMidAutumn:TMidAutumn;
      
      protected var FDiscount:TDiscount;
      
      protected var FRechargeGive:TRechargeGive;
      
      protected var FMagicData:TMagicData;
      
      protected var FPalaceData:TPalaceData;
      
      protected var FTopOrganizationData:TTopOrganizationData;
      
      protected var FGroupBattleData:TGroupBattleData;
      
      protected var FTopTeamData:TTopTeamData;
      
      protected var FNarutoHelperData:TNarutoHelperData;
      
      protected var FPlatformPrerogative:TPlatformPrerogative;
      
      protected var FNinjaRelationData:TNinjaRelationData;
      
      protected var FButtonStatus:Vector.<Boolean>;
      
      protected var FNationalDay:TNationalDay;
      
      protected var FTreasureBox:TTreasureBox;
      
      protected var FActivityThirdModes:TActivityThirdModes;
      
      protected var FNinjiaVillageData:TNinjiaVillageData;
      
      protected var FHallowmas:THallowmas;
      
      protected var FGuaGuaLe:TGuaGuaLe;
      
      protected var FWishTree:TWishTree;
      
      protected var FInviteFriend:TInviteFriend;
      
      protected var FEverydaySale:TEverydaySale;
      
      protected var FVipTreasure:TVipTreasure;
      
      protected var FCrossServerSale:TCrossServerSale;
      
      protected var FChristmasDatas:TChristmasDatas;
      
      protected var FBrazilCarnivalDatas:TBrazilCarnivalDatas;
      
      protected var FNewYear:TNewYear;
      
      protected var FActivityA:TActivityA;
      
      protected var FActivityB:TActivityB;
      
      protected var FSpringFestivalDatas:TSpringFestivalDatas;
      
      protected var FValentineDayDatas:TValentineDayDatas;
      
      protected var FBlackMarket:TBlackMarket;
      
      protected var FNinjaMeeting:TNinjaMeeting;
      
      protected var FFightBossDatas:TFightBossDatas;
      
      protected var FFortuneCat:TFortuneCat;
      
      protected var FTowerLottery:TTowerLottery;
      
      protected var FNinjaTreasureDatas:TNinjaTreasureDatas;
      
      protected var FSingleTopUp:TSingleTopUp;
      
      protected var FMayActiveDatas:TMayActiveDatas;
      
      protected var FOneWorthThousand:TOneWorthThousand;
      
      protected var FJuneActiveDatas:TJuneActiveDatas;
      
      protected var FNinjaBank:TNinjaBank;
      
      protected var FJulyActiveDatas:TJulyActiveDatas;
      
      protected var FFirstRechangeNew_Model:TFirstRechange_new_Model;
      
      protected var FBloodFeteDatas:TBloodFeteData;
      
      protected var FComeBack:TComeBack;
      
      protected var FDessertHouse:TDessertHouse;
      
      protected var FActivityTaskData:TActivityTaskData;
      
      protected var FAugustActiveDatas:TAugustActiveDatas;
      
      protected var FNewLottery:TNewLottery;
      
      protected var FSeptemberActiveDatas:TSeptemberActiveDatas;
      
      protected var FOctActiveDatas:TOctActiveDatas;
      
      protected var FDailyRecharge:TDailyRecharge;
      
      protected var FCloudBuy:TCloudBuy;
      
      protected var FFerrisWheel:TFerrisWheel;
      
      protected var FNovActiveDatas:TNovActiveDatas;
      
      protected var FActiveRankDatas:TActiveRankDatas;
      
      protected var FDecActiveDatas:TDecActiveDatas;
      
      protected var FSuperChristmas:TSuperChristmas;
      
      protected var FJanActiveDatas:TJanActiveDatas;
      
      protected var FFebActiveDatas:TFebActiveDatas;
      
      protected var FActiveRankDataNew:TActiveRankDataNew;
      
      protected var FMarchActiveDatas:TMarchActiveDatas;
      
      protected var FMarchConsume:TMarchConsume;
      
      protected var FAprilActiveDatas:TAprilActiveDatas;
      
      protected var FCapsuleToys:TCapsuleToys;
      
      protected var FGoldDigger:TGoldDigger;
      
      protected var FMayActiveDatas2015:TMayActiveDatas_2015;
      
      protected var FPersiaTrader:TPersiaTrader;
      
      protected var FAncientTreasure:TAncientTreasure;
      
      protected var FCornucopia:TCornucopia;
      
      protected var FGoldTree:TGoldTree;
      
      protected var FAlchemyStudio:TAlchemyStudio;
      
      protected var FGodWelfare:TGodWelfare;
      
      protected var FIdolumFight:TIdolumFight;
      
      protected var FBejeweled:TBejeweled;
      
      protected var FExorcism:TExorcism;
      
      public var NinjaCrystal:TNinjaCrystal;
      
      public var BossTreasure:TBossTreasure;
      
      public var LoginGift:TLoginGift;
      
      public var DailyFirstRecharge:TDailyFirstRecharge;
      
      public var MoonFestivalDatas:TMoonFestivalDatas;
      
      public var NationalDayDatas_2015:TNationalDayDatas_2015;
      
      public var HallowmasActiveDatas:THallowmasActiveDatas;
      
      public var WanSheng:TWanSheng;
      
      public var ThanksgivingDayDatas:TThanksgivingDayDatas;
      
      public var Nov:TNov;
      
      public var ChristmasDatas_2015:TChristmasDatas_2015;
      
      public var JanActiveDatas_2016:TJanActiveDatas_2016;
      
      public var SignGift:TSignGift;
      
      public var WanSheng2:TWanSheng2;
      
      public var FateRoulette:TFateRoulette;
      
      public var Nov2016:TNov2016;
      
      public var NinjaFund:TNinjaFund;
      
      public var CatWomen:TCatWomen;
      
      public var WitchProving:TWitchProving;
      
      public var ChristmasDatas_2016:TChristmasDatas_2016;
      
      public var LotteryMachine:TLotteryMachine;
      
      public var CreationAncestor:TCreationAncestor;
      
      public var WorldCupDatas:TWorldCupDatas;
      
      public var Double11Mall:TDouble11Mall;
      
      public var AutoChangeFormData:Vector.<TAutoChangeFormInfo>;
      
      protected var FTongLingData:Array;
      
      protected var FTongLingOpened:Array;
      
      protected var FRebirthRealmBaseData:TRebirthRealmBaseData;
      
      protected var FNijiaMysticData:TNijiaMysticData;
      
      protected var FNinjaHostelData:TNinjaHostelData;
      
      protected var FOhtsutsukiKaguyaData:OhtsutsukiKaguyaData;
      
      protected var FNewMallData:NewMallData;
      
      protected var FTransmigrationTrialData:TTransmigrationTrialData;
      
      protected var FTransmigrationAccessoryData:TTransmigrationAccessoryData;
      
      protected var FTBooData:TabooData;
      
      protected var FTongLingDatas:TTongLingDatas;
      
      protected var FAwakenDate:AwakenLogicDate;
      
      protected var FTheWorldTreeLogicData:TTheWorldTreeLogicData;
      
      protected var FEightDoorLogicData:TEightDoorLogicData;
      
      protected var FUndertownLogicData:TUndertownLogicData;
      
      protected var FZhenAoYiLogicData:TZhenAoYiLogicData;
      
      protected var FLostShenQiLogicData:TLostShenQiLogicData;
      
      public var MasterRoad:TMasterRoad;
      
      public var Challenge:TChallenge;
      
      public var Smelt:TSmelt;
      
      public var Warehouse:TWarehouse;
      
      public var GlobalBattle:TGlobalBattle;
      
      public var ShopLogicData:ShopData;
      
      public var ConsumeVipData:TConsumeVipData;
      
      public var WorldMatch:TWorldMatch;
      
      public var ChristmasDay:TChristmasDay;
      
      public var NinjaTalentData:TNinjaTalentData;
      
      public var Globalboss:TGlobalboss;
      
      public var GlobalbossNew:TGlobalboss;
      
      public var GlobalbossChapter:TGlobalbossChapter;
      
      public var GlobalbossChapterNew:TGlobalbossChapter;
      
      public var DayRechargeGift:TDayRechargeGift;
      
      protected var FShowMoreActivities:Boolean;
      
      protected var FCrossServerWarStatus:int;
      
      protected var FIsKicked:Boolean;
      
      protected var FIsShowAllUser:Boolean;
      
      protected var FAutoFightString:String = "";
      
      protected var FPostIdentifier:uint;
      
      public function TLogicsCore()
      {
         super();
         this.ConstructPools();
         this.StreamizationSetup();
         this.FCharacter = new TCharacter(0,0);
         this.FNPCs = new TNPCs();
         this.FRoleDigests = new TRoleDigests();
         this.FFriends = new TFriendDigests();
         this.FMails = new TMails();
         this.FQuests = new TQuests();
         this.FRamenData = new TRamenData();
         this.FNodal = new TNodal();
         this.FGeneral = new TGenerals();
         this.FActivityModes = new TActivityModes();
         this.FAntiAddiction = new TAntiAddiction();
         this.FUnlocks = new TUnlocks();
         this.FSignals = new Vector.<TSignal>();
         this.FCounterLimit = new THashMap();
         this.FStepChallengePlayers = new TChallengePlayers();
         this.FSkipChallengePlayers = new TChallengePlayers();
         this.FEliteRecord = new TEliteRecord();
         this.FTitles = new TTitles();
         this.FStatisticalStep = 1;
         this.FOrganization = new TBaseOrganization();
         this.FLottery = new TLottery();
         this.FNewActivityModes = new TNewActivityModes();
         this.FSystemActivities = new TSystemActivities();
         this.FNarutoRoadData = new TNarutoRoadData();
         this.FMentorship = new TMentorship();
         this.FActivitiesData = new TActivitiesData();
         this.FVipShop = new TVipShop();
         this.FDice = new TDice();
         this.FConsumeRank = new TConsumeRank();
         this.FRechargeRank = new TRechargeRank();
         this.FCommonRecharge = new TCommonRecharge();
         this.FTenTail = new TTenTail();
         this.FVipFreeBuy = new TVipFreeBuy();
         this.FSeventhEvening = new TSeventhEvening();
         this.FHappyTreasure = new THappyTreasure();
         this.FGroupBuying = new TGroupBuying();
         this.FRechargeExchange = new TRechargeExchange();
         this.FOrangeEquipment = new TOrangeEquipment();
         this.FMidAutumn = new TMidAutumn();
         this.FDiscount = new TDiscount();
         this.FRechargeGive = new TRechargeGive();
         this.FMagicData = new TMagicData();
         this.FPalaceData = new TPalaceData();
         this.FTopOrganizationData = new TTopOrganizationData();
         this.FGroupBattleData = new TGroupBattleData();
         this.FTopTeamData = new TTopTeamData();
         this.FNarutoHelperData = new TNarutoHelperData();
         this.FPlatformPrerogative = new TPlatformPrerogative();
         this.FNinjaRelationData = new TNinjaRelationData();
         this.FButtonStatus = new Vector.<Boolean>();
         this.FNationalDay = new TNationalDay();
         this.FTreasureBox = new TTreasureBox();
         this.FActivityThirdModes = new TActivityThirdModes();
         this.FNinjiaVillageData = new TNinjiaVillageData();
         this.FHallowmas = new THallowmas();
         this.FGuaGuaLe = new TGuaGuaLe();
         this.FWishTree = new TWishTree();
         this.FInviteFriend = new TInviteFriend();
         this.FEverydaySale = new TEverydaySale();
         this.FVipTreasure = new TVipTreasure();
         this.FCrossServerSale = new TCrossServerSale();
         this.FChristmasDatas = new TChristmasDatas();
         this.FBrazilCarnivalDatas = new TBrazilCarnivalDatas();
         this.FNewYear = new TNewYear();
         this.FActivityA = new TActivityA();
         this.FActivityB = new TActivityB();
         this.FSpringFestivalDatas = new TSpringFestivalDatas();
         this.FValentineDayDatas = new TValentineDayDatas();
         this.FBlackMarket = new TBlackMarket();
         this.FNinjaMeeting = new TNinjaMeeting();
         this.FFightBossDatas = new TFightBossDatas();
         this.FTongLingData = new Array();
         this.FTongLingOpened = new Array();
         this.FRebirthRealmBaseData = new TRebirthRealmBaseData();
         this.FNijiaMysticData = new TNijiaMysticData();
         this.FNinjaHostelData = new TNinjaHostelData();
         this.FFortuneCat = new TFortuneCat();
         this.FTowerLottery = new TTowerLottery();
         this.FNinjaTreasureDatas = new TNinjaTreasureDatas();
         this.FSingleTopUp = new TSingleTopUp();
         this.FMayActiveDatas = new TMayActiveDatas();
         this.FOneWorthThousand = new TOneWorthThousand();
         this.FJuneActiveDatas = new TJuneActiveDatas();
         this.FNinjaBank = new TNinjaBank();
         this.FJulyActiveDatas = new TJulyActiveDatas();
         this.FFirstRechangeNew_Model = new TFirstRechange_new_Model();
         this.FBloodFeteDatas = new TBloodFeteData();
         this.FComeBack = new TComeBack();
         this.FDessertHouse = new TDessertHouse();
         this.FActivityTaskData = new TActivityTaskData();
         this.FAugustActiveDatas = new TAugustActiveDatas();
         this.FNewLottery = new TNewLottery();
         this.FSeptemberActiveDatas = new TSeptemberActiveDatas();
         this.FOctActiveDatas = new TOctActiveDatas();
         this.FDailyRecharge = new TDailyRecharge();
         this.FCloudBuy = new TCloudBuy();
         this.FFerrisWheel = new TFerrisWheel();
         this.FNovActiveDatas = new TNovActiveDatas();
         this.ChristmasDatas_2015 = new TChristmasDatas_2015();
         this.JanActiveDatas_2016 = new TJanActiveDatas_2016();
         this.SignGift = new TSignGift();
         this.FActiveRankDatas = new TActiveRankDatas();
         this.FDecActiveDatas = new TDecActiveDatas();
         this.FSuperChristmas = new TSuperChristmas();
         this.FJanActiveDatas = new TJanActiveDatas();
         this.FFebActiveDatas = new TFebActiveDatas();
         this.FMarchActiveDatas = new TMarchActiveDatas();
         this.FActiveRankDataNew = new TActiveRankDataNew();
         this.FMarchConsume = new TMarchConsume();
         this.FAprilActiveDatas = new TAprilActiveDatas();
         this.FCapsuleToys = new TCapsuleToys();
         this.FGoldDigger = new TGoldDigger();
         this.FMayActiveDatas2015 = new TMayActiveDatas_2015();
         this.FPersiaTrader = new TPersiaTrader();
         this.FAncientTreasure = new TAncientTreasure();
         this.FCornucopia = new TCornucopia();
         this.FGoldTree = new TGoldTree();
         this.FAlchemyStudio = new TAlchemyStudio();
         this.FGodWelfare = new TGodWelfare();
         this.FIdolumFight = new TIdolumFight();
         this.FBejeweled = new TBejeweled();
         this.FExorcism = new TExorcism();
         this.NinjaCrystal = new TNinjaCrystal();
         this.BossTreasure = new TBossTreasure();
         this.LoginGift = new TLoginGift();
         this.DailyFirstRecharge = new TDailyFirstRecharge();
         this.MoonFestivalDatas = new TMoonFestivalDatas();
         this.NationalDayDatas_2015 = new TNationalDayDatas_2015();
         this.HallowmasActiveDatas = new THallowmasActiveDatas();
         this.WanSheng = new TWanSheng();
         this.WanSheng2 = new TWanSheng2();
         this.FateRoulette = new TFateRoulette();
         this.Nov2016 = new TNov2016();
         this.NinjaFund = new TNinjaFund();
         this.CatWomen = new TCatWomen();
         this.WitchProving = new TWitchProving();
         this.ChristmasDatas_2016 = new TChristmasDatas_2016();
         this.LotteryMachine = new TLotteryMachine();
         this.ThanksgivingDayDatas = new TThanksgivingDayDatas();
         this.Nov = new TNov();
         this.FOhtsutsukiKaguyaData = new OhtsutsukiKaguyaData();
         this.FNewMallData = new NewMallData();
         this.FTransmigrationTrialData = new TTransmigrationTrialData();
         this.FTransmigrationAccessoryData = new TTransmigrationAccessoryData();
         this.FTBooData = new TabooData();
         this.FTongLingDatas = new TTongLingDatas();
         this.FAwakenDate = new AwakenLogicDate();
         this.FTheWorldTreeLogicData = new TTheWorldTreeLogicData();
         this.FEightDoorLogicData = new TEightDoorLogicData();
         this.FUndertownLogicData = new TUndertownLogicData();
         this.FZhenAoYiLogicData = new TZhenAoYiLogicData();
         this.FLostShenQiLogicData = new TLostShenQiLogicData();
         this.MasterRoad = new TMasterRoad();
         this.Challenge = new TChallenge();
         this.FCrossServerWarStatus = 1;
         this.FIsKicked = false;
         this.FIsShowAllUser = true;
         this.FShowMoreActivities = false;
         this.CreationAncestor = new TCreationAncestor();
         this.WorldCupDatas = new TWorldCupDatas();
         this.Double11Mall = new TDouble11Mall();
         this.AutoChangeFormData = new Vector.<TAutoChangeFormInfo>();
         this.Smelt = new TSmelt();
         this.Warehouse = new TWarehouse();
         this.GlobalBattle = new TGlobalBattle();
         this.ShopLogicData = new ShopData();
         this.ConsumeVipData = new TConsumeVipData();
         this.WorldMatch = new TWorldMatch();
         this.ChristmasDay = new TChristmasDay();
         this.NinjaTalentData = new TNinjaTalentData();
         this.DayRechargeGift = new TDayRechargeGift();
      }
      
      protected function ConstructPools() : void
      {
         this.FPoolCharacter = new TPoolCharacter();
         this.FPoolInventory = new TPoolInventory();
         this.FPoolQuest = new TPoolQuest();
         this.FPoolSkill = new TPoolSkill();
         this.FPoolBuff = new TPoolBuff();
         this.FPoolArena = new TPoolArena();
         this.FPoolMail = new TPoolMail();
         this.FPoolTavern = new TPoolTavern();
         this.FPoolCampaign = new TPoolCampaign();
         this.FPoolItem = new TPoolItem();
         this.FPoolTreasureMap = new TPoolTreasureMap();
         this.FPoolCityDefend = new TPoolCityDefend();
         this.FPoolTraitorAttack = new TPoolTraitorAttack();
         this.FPoolFriendRamen = new TPoolFriendRamen();
         this.FPoolHyperString = new TPoolHyperString();
         this.FPoolSignal = new TPoolSignal();
         this.FPoolUIRoleCanMove = new TPoolUIRoleCanMove();
         this.FPoolUISingleEquipment = new TPoolUISingleEquipment();
         this.FPoolUIRewardItem = new TPoolUIRewardItem();
         this.FPoolUILotteryNews = new TPoolUILotteryNews();
         this.FPoolUINews = new TPoolUINews();
         this.FPoolToastRecord = new TPoolToastRecord();
         this.FPoolCrossServerReport = new TPoolCrossServerReport();
         this.FPoolPalaceReport = new TPoolPalaceReport();
         this.FPoolUIOrgMember = new TPoolUIOrgMember();
         this.FPoolUIDiceLog = new TPoolUIDiceLog();
         this.FPoolUIFish = new TPoolUIFish();
      }
      
      protected function StreamizationSetup() : void
      {
         this.StreamizationSetup_Streamizers();
         this.StreamizationSetup_Unstreamizers();
      }
      
      protected function StreamizationSetup_Streamizers() : void
      {
         TStreamizerHyperStringUnknown.PoolsSetup(this.FPoolHyperString);
      }
      
      protected function StreamizationSetup_Unstreamizers() : void
      {
         TUnstreamizerHyperStringUnknown.PoolsSetup(this.FPoolHyperString);
         TUnstreamizerCharacterUnknown.PoolsSetup(this.FPoolCharacter);
         TUnstreamizerSkillUnknown.PoolsSetup(this.FPoolSkill);
         TUnstreamizerInventoryUnknown.PoolsSetup(this.FPoolInventory);
         TUnstreamizerQuestUnknown.PoolsSetup(this.FPoolQuest);
         TUnstreamizerBuffUnknown.PoolsSetup(this.FPoolBuff);
         TUnstreamizerMailUnknown.PoolsSetup(this.FPoolMail);
         TUnstreamizerArena.PoolsSetup(this.FPoolArena);
         TUnstreamizerTavern.PoolsSetup(this.FPoolTavern);
         TUnstreamizerCampaignUnknown.PoolsSetup(this.FPoolCampaign);
         TUnstreamizerCampaignUnknown.PoolsSetupItem(this.FPoolItem);
         TUnstreamizerItemUnknown.PoolsSetup(this.FPoolItem);
         TUnstreamizerTreasureMap.PoolsSetup(this.FPoolTreasureMap);
         TUnstreamizerCityDefend.PoolsSetup(this.FPoolCityDefend);
         TUnstreamizerTraitorAttack.PoolsSetup(this.FPoolTraitorAttack);
         TUnstreamizerToastRecord.PoolsSetup(this.FPoolToastRecord);
         TUnstreamizerCrossServerReport.PoolsSetup(this.FPoolCrossServerReport);
         TUnstreamizerPalace.PoolsSetup(this.FPoolPalaceReport,this.FPoolCrossServerReport);
         TUnstreamizerRamen.PoolsSetup(this.FPoolFriendRamen);
      }
      
      protected function TimingUpdate() : void
      {
         this.TimingUpdateModuleTiming(this.FCharacter.TimeCoolDowns);
         this.TimingUpdateCollection(this.FCharacter.TemporaryInventories);
      }
      
      protected function TimingUpdateModuleTiming(param1:TTimeCoolDowns) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TTimeCoolDown = null;
         _loc3_ = param1.Count;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = param1.GetDigestByIndex(_loc2_);
            if(_loc4_ != null)
            {
               _loc4_.TimingUpdate();
            }
            _loc2_++;
         }
      }
      
      protected function TimingUpdateCollection(param1:TInventories) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TInventory = null;
         _loc2_ = param1.Count;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = param1.GetInventoryByIndex(_loc3_);
            if(_loc4_ != null)
            {
               _loc4_.TimingUpdate();
            }
            _loc3_++;
         }
      }
      
      public function get SignalCount() : int
      {
         return this.FSignals.length;
      }
      
      public function get Character() : TCharacter
      {
         return this.FCharacter;
      }
      
      public function get NPCs() : TNPCs
      {
         return this.FNPCs;
      }
      
      public function get RoleDigests() : TRoleDigests
      {
         return this.FRoleDigests;
      }
      
      public function get Friends() : TFriendDigests
      {
         return this.FFriends;
      }
      
      public function get Quests() : TQuests
      {
         return this.FQuests;
      }
      
      public function get Nodal() : TNodal
      {
         return this.FNodal;
      }
      
      public function get General() : TGenerals
      {
         return this.FGeneral;
      }
      
      public function get Mails() : TMails
      {
         return this.FMails;
      }
      
      public function get RamenData() : TRamenData
      {
         return this.FRamenData;
      }
      
      public function get ActivityModes() : TActivityModes
      {
         return this.FActivityModes;
      }
      
      public function get PoolCharacter() : TPoolCharacter
      {
         return this.FPoolCharacter;
      }
      
      public function get PoolMail() : TPoolMail
      {
         return this.FPoolMail;
      }
      
      public function get PoolInventory() : TPoolInventory
      {
         return this.FPoolInventory;
      }
      
      public function get PoolQuest() : TPoolQuest
      {
         return this.FPoolQuest;
      }
      
      public function get PoolSkill() : TPoolSkill
      {
         return this.FPoolSkill;
      }
      
      public function get PoolBuff() : TPoolBuff
      {
         return this.FPoolBuff;
      }
      
      public function get PoolArena() : TPoolArena
      {
         return this.FPoolArena;
      }
      
      public function get PoolTavern() : TPoolTavern
      {
         return this.FPoolTavern;
      }
      
      public function get PoolCampaign() : TPoolCampaign
      {
         return this.FPoolCampaign;
      }
      
      public function get PoolItem() : TPoolItem
      {
         return this.FPoolItem;
      }
      
      public function get PoolTreasureMap() : TPoolTreasureMap
      {
         return this.FPoolTreasureMap;
      }
      
      public function get PoolCityDefend() : TPoolCityDefend
      {
         return this.FPoolCityDefend;
      }
      
      public function get PoolTraitorAttack() : TPoolTraitorAttack
      {
         return this.FPoolTraitorAttack;
      }
      
      public function get PoolFriendRamen() : TPoolFriendRamen
      {
         return this.FPoolFriendRamen;
      }
      
      public function get PoolHyperString() : TPoolHyperString
      {
         return this.FPoolHyperString;
      }
      
      public function get ScreenMapX() : Number
      {
         return this.FScreenMapX;
      }
      
      public function set ScreenMapX(param1:Number) : void
      {
         this.FScreenMapX = param1;
      }
      
      public function get ScreenMapY() : Number
      {
         return this.FScreenMapY;
      }
      
      public function set ScreenMapY(param1:Number) : void
      {
         this.FScreenMapY = param1;
      }
      
      public function get PoolUIRoleCanMove() : TPoolUIRoleCanMove
      {
         return this.FPoolUIRoleCanMove;
      }
      
      public function set ProcessorFreshGuide(param1:TProcessorFreshGuide) : void
      {
         this.FProcessorFreshGuide = param1;
      }
      
      public function get AutoSearching() : Boolean
      {
         return this.FAutoSearching;
      }
      
      public function set AutoSearching(param1:Boolean) : void
      {
         this.FAutoSearching = param1;
      }
      
      public function get AutoSearchQuest() : TQuest
      {
         return this.FAutoSearchQuest;
      }
      
      public function set AutoSearchQuest(param1:TQuest) : void
      {
         this.FAutoSearchQuest = param1;
      }
      
      public function get AntiAddiction() : TAntiAddiction
      {
         return this.FAntiAddiction;
      }
      
      public function get PlayPlotState() : int
      {
         return this.FPlayPlotState;
      }
      
      public function set PlayPlotState(param1:int) : void
      {
         this.FPlayPlotState = param1;
      }
      
      public function get Unlocks() : TUnlocks
      {
         return this.FUnlocks;
      }
      
      public function get PoolUISingleEquipment() : TPoolUISingleEquipment
      {
         return this.FPoolUISingleEquipment;
      }
      
      public function set PoolUISingleEquipment(param1:TPoolUISingleEquipment) : void
      {
         this.FPoolUISingleEquipment = param1;
      }
      
      public function get PoolUIRewardItem() : TPoolUIRewardItem
      {
         return this.FPoolUIRewardItem;
      }
      
      public function set PoolUIRewardItem(param1:TPoolUIRewardItem) : void
      {
         this.FPoolUIRewardItem = param1;
      }
      
      public function get CounterLimit() : THashMap
      {
         return this.FCounterLimit;
      }
      
      public function set CounterLimit(param1:THashMap) : void
      {
         this.FCounterLimit = param1;
      }
      
      public function get Organization() : TBaseOrganization
      {
         return this.FOrganization;
      }
      
      public function set Organization(param1:TBaseOrganization) : void
      {
         this.FOrganization = param1;
      }
      
      public function get Lottery() : TLottery
      {
         return this.FLottery;
      }
      
      public function set Lottery(param1:TLottery) : void
      {
         this.FLottery = param1;
      }
      
      public function get PoolUILotteryNews() : TPoolUILotteryNews
      {
         return this.FPoolUILotteryNews;
      }
      
      public function set PoolUILotteryNews(param1:TPoolUILotteryNews) : void
      {
         this.FPoolUILotteryNews = param1;
      }
      
      public function get NewActivityModes() : TNewActivityModes
      {
         return this.FNewActivityModes;
      }
      
      public function get SystemActivities() : TSystemActivities
      {
         return this.FSystemActivities;
      }
      
      public function set SystemActivities(param1:TSystemActivities) : void
      {
         this.FSystemActivities = param1;
      }
      
      public function get NarutoRoadData() : TNarutoRoadData
      {
         return this.FNarutoRoadData;
      }
      
      public function set NarutoRoadData(param1:TNarutoRoadData) : void
      {
         this.FNarutoRoadData = param1;
      }
      
      public function get BigDipperFreeTime() : int
      {
         return this.FBigDipperFreeTime;
      }
      
      public function set BigDipperFreeTime(param1:int) : void
      {
         this.FBigDipperFreeTime = param1;
      }
      
      public function get Mentorship() : TMentorship
      {
         return this.FMentorship;
      }
      
      public function set Mentorship(param1:TMentorship) : void
      {
         this.FMentorship = param1;
      }
      
      public function get ActivitiesData() : TActivitiesData
      {
         return this.FActivitiesData;
      }
      
      public function set ActivitiesData(param1:TActivitiesData) : void
      {
         this.FActivitiesData = param1;
      }
      
      public function get VipShop() : TVipShop
      {
         return this.FVipShop;
      }
      
      public function set VipShop(param1:TVipShop) : void
      {
         this.FVipShop = param1;
      }
      
      public function get Dice() : TDice
      {
         return this.FDice;
      }
      
      public function set Dice(param1:TDice) : void
      {
         this.FDice = param1;
      }
      
      public function get StepChallengePlayers() : TChallengePlayers
      {
         return this.FStepChallengePlayers;
      }
      
      public function set StepChallengePlayers(param1:TChallengePlayers) : void
      {
         this.FStepChallengePlayers = param1;
      }
      
      public function get SkipChallengePlayers() : TChallengePlayers
      {
         return this.FSkipChallengePlayers;
      }
      
      public function set SkipChallengePlayers(param1:TChallengePlayers) : void
      {
         this.FSkipChallengePlayers = param1;
      }
      
      public function get ConsumeRank() : TConsumeRank
      {
         return this.FConsumeRank;
      }
      
      public function set ConsumeRank(param1:TConsumeRank) : void
      {
         this.FConsumeRank = param1;
      }
      
      public function get RechargeRank() : TRechargeRank
      {
         return this.FRechargeRank;
      }
      
      public function set RechargeRank(param1:TRechargeRank) : void
      {
         this.FRechargeRank = param1;
      }
      
      public function get CommonRecharge() : TCommonRecharge
      {
         return this.FCommonRecharge;
      }
      
      public function set CommonRecharge(param1:TCommonRecharge) : void
      {
         this.FCommonRecharge = param1;
      }
      
      public function get TenTail() : TTenTail
      {
         return this.FTenTail;
      }
      
      public function set TenTail(param1:TTenTail) : void
      {
         this.FTenTail = param1;
      }
      
      public function get VipFreeBuy() : TVipFreeBuy
      {
         return this.FVipFreeBuy;
      }
      
      public function set VipFreeBuy(param1:TVipFreeBuy) : void
      {
         this.FVipFreeBuy = param1;
      }
      
      public function get SeventhEvening() : TSeventhEvening
      {
         return this.FSeventhEvening;
      }
      
      public function set SeventhEvening(param1:TSeventhEvening) : void
      {
         this.FSeventhEvening = param1;
      }
      
      public function get HappyTreasure() : THappyTreasure
      {
         return this.FHappyTreasure;
      }
      
      public function set HappyTreasure(param1:THappyTreasure) : void
      {
         this.FHappyTreasure = param1;
      }
      
      public function get EliteRecord() : TEliteRecord
      {
         return this.FEliteRecord;
      }
      
      public function set EliteRecord(param1:TEliteRecord) : void
      {
         this.FEliteRecord = param1;
      }
      
      public function get PoolUINews() : TPoolUINews
      {
         return this.FPoolUINews;
      }
      
      public function set PoolUINews(param1:TPoolUINews) : void
      {
         this.FPoolUINews = param1;
      }
      
      public function get PoolToastRecord() : TPoolToastRecord
      {
         return this.FPoolToastRecord;
      }
      
      public function set PoolToastRecord(param1:TPoolToastRecord) : void
      {
         this.FPoolToastRecord = param1;
      }
      
      public function get PoolCrossServerReport() : TPoolCrossServerReport
      {
         return this.FPoolCrossServerReport;
      }
      
      public function set PoolCrossServerReport(param1:TPoolCrossServerReport) : void
      {
         this.FPoolCrossServerReport = param1;
      }
      
      public function get Titles() : TTitles
      {
         return this.FTitles;
      }
      
      public function set Titles(param1:TTitles) : void
      {
         this.FTitles = param1;
      }
      
      public function get GroupBuying() : TGroupBuying
      {
         return this.FGroupBuying;
      }
      
      public function set GroupBuying(param1:TGroupBuying) : void
      {
         this.FGroupBuying = param1;
      }
      
      public function get RechargeExchange() : TRechargeExchange
      {
         return this.FRechargeExchange;
      }
      
      public function set RechargeExchange(param1:TRechargeExchange) : void
      {
         this.FRechargeExchange = param1;
      }
      
      public function get OrangeEquipment() : TOrangeEquipment
      {
         return this.FOrangeEquipment;
      }
      
      public function set OrangeEquipment(param1:TOrangeEquipment) : void
      {
         this.FOrangeEquipment = param1;
      }
      
      public function get CrossServerWarStatus() : int
      {
         return this.FCrossServerWarStatus;
      }
      
      public function set CrossServerWarStatus(param1:int) : void
      {
         this.FCrossServerWarStatus = param1;
      }
      
      public function get MidAutumn() : TMidAutumn
      {
         return this.FMidAutumn;
      }
      
      public function set MidAutumn(param1:TMidAutumn) : void
      {
         this.FMidAutumn = param1;
      }
      
      public function get IsKicked() : Boolean
      {
         return this.FIsKicked;
      }
      
      public function set IsKicked(param1:Boolean) : void
      {
         this.FIsKicked = param1;
      }
      
      public function get Discount() : TDiscount
      {
         return this.FDiscount;
      }
      
      public function set Discount(param1:TDiscount) : void
      {
         this.FDiscount = param1;
      }
      
      public function get RechargeGive() : TRechargeGive
      {
         return this.FRechargeGive;
      }
      
      public function set RechargeGive(param1:TRechargeGive) : void
      {
         this.FRechargeGive = param1;
      }
      
      public function get IsShowAllUser() : Boolean
      {
         return this.FIsShowAllUser;
      }
      
      public function set IsShowAllUser(param1:Boolean) : void
      {
         this.FIsShowAllUser = param1;
      }
      
      public function set AutoFightString(param1:String) : void
      {
         this.FAutoFightString = param1;
      }
      
      public function get AutoFightString() : String
      {
         return this.FAutoFightString;
      }
      
      public function get MagicData() : TMagicData
      {
         return this.FMagicData;
      }
      
      public function set MagicData(param1:TMagicData) : void
      {
         this.FMagicData = param1;
      }
      
      public function get NationalDay() : TNationalDay
      {
         return this.FNationalDay;
      }
      
      public function set NationalDay(param1:TNationalDay) : void
      {
         this.FNationalDay = param1;
      }
      
      public function get TreasureBox() : TTreasureBox
      {
         return this.FTreasureBox;
      }
      
      public function set TreasureBox(param1:TTreasureBox) : void
      {
         this.FTreasureBox = param1;
      }
      
      public function get ActivityThirdModes() : TActivityThirdModes
      {
         return this.FActivityThirdModes;
      }
      
      public function set ActivityThirdModes(param1:TActivityThirdModes) : void
      {
         this.FActivityThirdModes = param1;
      }
      
      public function get NinjiaVillageData() : TNinjiaVillageData
      {
         return this.FNinjiaVillageData;
      }
      
      public function set NinjiaVillageData(param1:TNinjiaVillageData) : void
      {
         this.FNinjiaVillageData = param1;
      }
      
      public function get Hallowmas() : THallowmas
      {
         return this.FHallowmas;
      }
      
      public function set Hallowmas(param1:THallowmas) : void
      {
         this.FHallowmas = param1;
      }
      
      public function get InviteFriend() : TInviteFriend
      {
         return this.FInviteFriend;
      }
      
      public function set InviteFriend(param1:TInviteFriend) : void
      {
         this.FInviteFriend = param1;
      }
      
      public function get GuaGuaLe() : TGuaGuaLe
      {
         return this.FGuaGuaLe;
      }
      
      public function set GuaGuaLe(param1:TGuaGuaLe) : void
      {
         this.FGuaGuaLe = param1;
      }
      
      public function get PalaceData() : TPalaceData
      {
         return this.FPalaceData;
      }
      
      public function set PalaceData(param1:TPalaceData) : void
      {
         this.FPalaceData = param1;
      }
      
      public function get TopOrganizationData() : TTopOrganizationData
      {
         return this.FTopOrganizationData;
      }
      
      public function set TopOrganizationData(param1:TTopOrganizationData) : void
      {
         this.FTopOrganizationData = param1;
      }
      
      public function get GroupBattleData() : TGroupBattleData
      {
         return this.FGroupBattleData;
      }
      
      public function set GroupBattleData(param1:TGroupBattleData) : void
      {
         this.FGroupBattleData = param1;
      }
      
      public function get TopTeamData() : TTopTeamData
      {
         return this.FTopTeamData;
      }
      
      public function set TopTeamData(param1:TTopTeamData) : void
      {
         this.FTopTeamData = param1;
      }
      
      public function get ButtonStatus() : Vector.<Boolean>
      {
         return this.FButtonStatus;
      }
      
      public function set ButtonStatus(param1:Vector.<Boolean>) : void
      {
         this.FButtonStatus = param1;
      }
      
      public function get WishTree() : TWishTree
      {
         return this.FWishTree;
      }
      
      public function set WishTree(param1:TWishTree) : void
      {
         this.FWishTree = param1;
      }
      
      public function get EverydaySale() : TEverydaySale
      {
         return this.FEverydaySale;
      }
      
      public function set EverydaySale(param1:TEverydaySale) : void
      {
         this.FEverydaySale = param1;
      }
      
      public function get VipTreasure() : TVipTreasure
      {
         return this.FVipTreasure;
      }
      
      public function set VipTreasure(param1:TVipTreasure) : void
      {
         this.FVipTreasure = param1;
      }
      
      public function get CrossServerSale() : TCrossServerSale
      {
         return this.FCrossServerSale;
      }
      
      public function set CrossServerSale(param1:TCrossServerSale) : void
      {
         this.FCrossServerSale = param1;
      }
      
      public function get ChristmasDatas() : TChristmasDatas
      {
         return this.FChristmasDatas;
      }
      
      public function set ChristmasDatas(param1:TChristmasDatas) : void
      {
         this.FChristmasDatas = param1;
      }
      
      public function get NewYear() : TNewYear
      {
         return this.FNewYear;
      }
      
      public function set NewYear(param1:TNewYear) : void
      {
         this.FNewYear = param1;
      }
      
      public function get ShowMoreActivities() : Boolean
      {
         return this.FShowMoreActivities;
      }
      
      public function set ShowMoreActivities(param1:Boolean) : void
      {
         this.FShowMoreActivities = param1;
      }
      
      public function get ActivityA() : TActivityA
      {
         return this.FActivityA;
      }
      
      public function set ActivityA(param1:TActivityA) : void
      {
         this.FActivityA = param1;
      }
      
      public function get ActivityB() : TActivityB
      {
         return this.FActivityB;
      }
      
      public function set ActivityB(param1:TActivityB) : void
      {
         this.FActivityB = param1;
      }
      
      public function get SpringFestivalDatas() : TSpringFestivalDatas
      {
         return this.FSpringFestivalDatas;
      }
      
      public function set SpringFestivalDatas(param1:TSpringFestivalDatas) : void
      {
         this.FSpringFestivalDatas = param1;
      }
      
      public function get ValentineDayDatas() : TValentineDayDatas
      {
         return this.FValentineDayDatas;
      }
      
      public function set ValentineDayDatas(param1:TValentineDayDatas) : void
      {
         this.FValentineDayDatas = param1;
      }
      
      public function get BlackMarket() : TBlackMarket
      {
         return this.FBlackMarket;
      }
      
      public function set BlackMarket(param1:TBlackMarket) : void
      {
         this.FBlackMarket = param1;
      }
      
      public function get PoolUIOrgMember() : TPoolUIOrgMember
      {
         return this.FPoolUIOrgMember;
      }
      
      public function set PoolUIOrgMember(param1:TPoolUIOrgMember) : void
      {
         this.FPoolUIOrgMember = param1;
      }
      
      public function get NinjaMeeting() : TNinjaMeeting
      {
         return this.FNinjaMeeting;
      }
      
      public function set NinjaMeeting(param1:TNinjaMeeting) : void
      {
         this.FNinjaMeeting = param1;
      }
      
      public function get FightBossDatas() : TFightBossDatas
      {
         return this.FFightBossDatas;
      }
      
      public function set FightBossDatas(param1:TFightBossDatas) : void
      {
         this.FFightBossDatas = param1;
      }
      
      public function get TongLingData() : Array
      {
         return this.FTongLingData;
      }
      
      public function set TongLingData(param1:Array) : void
      {
         this.FTongLingData = param1;
      }
      
      public function get TongLingOpened() : Array
      {
         return this.FTongLingOpened;
      }
      
      public function set TongLingOpened(param1:Array) : void
      {
         this.FTongLingOpened = param1;
      }
      
      public function get RebirthRealmBaseData() : TRebirthRealmBaseData
      {
         return this.FRebirthRealmBaseData;
      }
      
      public function get NijiaMysticData() : TNijiaMysticData
      {
         return this.FNijiaMysticData;
      }
      
      public function set NijiaMysticData(param1:TNijiaMysticData) : void
      {
         this.FNijiaMysticData = param1;
      }
      
      public function get NinjaHostelData() : TNinjaHostelData
      {
         return this.FNinjaHostelData;
      }
      
      public function set NinjaHostelData(param1:TNinjaHostelData) : void
      {
         this.FNinjaHostelData = param1;
      }
      
      public function get BrazilCarnivalDatas() : TBrazilCarnivalDatas
      {
         return this.FBrazilCarnivalDatas;
      }
      
      public function set BrazilCarnivalDatas(param1:TBrazilCarnivalDatas) : void
      {
         this.FBrazilCarnivalDatas = param1;
      }
      
      public function get FortuneCat() : TFortuneCat
      {
         return this.FFortuneCat;
      }
      
      public function set FortuneCat(param1:TFortuneCat) : void
      {
         this.FFortuneCat = param1;
      }
      
      public function get TowerLottery() : TTowerLottery
      {
         return this.FTowerLottery;
      }
      
      public function set TowerLottery(param1:TTowerLottery) : void
      {
         this.FTowerLottery = param1;
      }
      
      public function get NinjaTreasureDatas() : TNinjaTreasureDatas
      {
         return this.FNinjaTreasureDatas;
      }
      
      public function set NinjaTreasureDatas(param1:TNinjaTreasureDatas) : void
      {
         this.FNinjaTreasureDatas = param1;
      }
      
      public function get PostIdentifier() : uint
      {
         return this.FPostIdentifier;
      }
      
      public function set PostIdentifier(param1:uint) : void
      {
         this.FPostIdentifier = param1;
      }
      
      public function get SingleTopUp() : TSingleTopUp
      {
         return this.FSingleTopUp;
      }
      
      public function set SingleTopUp(param1:TSingleTopUp) : void
      {
         this.FSingleTopUp = param1;
      }
      
      public function get MayActiveDatas() : TMayActiveDatas
      {
         return this.FMayActiveDatas;
      }
      
      public function set MayActiveDatas(param1:TMayActiveDatas) : void
      {
         this.FMayActiveDatas = param1;
      }
      
      public function get NarutoHelperData() : TNarutoHelperData
      {
         return this.FNarutoHelperData;
      }
      
      public function set NarutoHelperData(param1:TNarutoHelperData) : void
      {
         this.FNarutoHelperData = param1;
      }
      
      public function get PlatformPrerogative() : TPlatformPrerogative
      {
         return this.FPlatformPrerogative;
      }
      
      public function set PlatformPrerogative(param1:TPlatformPrerogative) : void
      {
         this.FPlatformPrerogative = param1;
      }
      
      public function get NinjaRelationData() : TNinjaRelationData
      {
         return this.FNinjaRelationData;
      }
      
      public function set NinjaRelationData(param1:TNinjaRelationData) : void
      {
         this.FNinjaRelationData = param1;
      }
      
      public function get OneWorthThousand() : TOneWorthThousand
      {
         return this.FOneWorthThousand;
      }
      
      public function set OneWorthThousand(param1:TOneWorthThousand) : void
      {
         this.FOneWorthThousand = param1;
      }
      
      public function get JuneActiveDatas() : TJuneActiveDatas
      {
         return this.FJuneActiveDatas;
      }
      
      public function set JuneActiveDatas(param1:TJuneActiveDatas) : void
      {
         this.FJuneActiveDatas = param1;
      }
      
      public function get NinjaBank() : TNinjaBank
      {
         return this.FNinjaBank;
      }
      
      public function set NinjaBank(param1:TNinjaBank) : void
      {
         this.FNinjaBank = param1;
      }
      
      public function get JulyActiveDatas() : TJulyActiveDatas
      {
         return this.FJulyActiveDatas;
      }
      
      public function set JulyActiveDatas(param1:TJulyActiveDatas) : void
      {
         this.FJulyActiveDatas = param1;
      }
      
      public function get FirstRechangeNewModel() : TFirstRechange_new_Model
      {
         return this.FFirstRechangeNew_Model;
      }
      
      public function set FirstRechangeNewModel(param1:TFirstRechange_new_Model) : void
      {
         this.FFirstRechangeNew_Model = param1;
      }
      
      public function set BloodFeteDatas(param1:TBloodFeteData) : void
      {
         this.FBloodFeteDatas = param1;
      }
      
      public function get BloodFeteDatas() : TBloodFeteData
      {
         return this.FBloodFeteDatas;
      }
      
      public function get ComeBack() : TComeBack
      {
         return this.FComeBack;
      }
      
      public function set ComeBack(param1:TComeBack) : void
      {
         this.FComeBack = param1;
      }
      
      public function get DessertHouse() : TDessertHouse
      {
         return this.FDessertHouse;
      }
      
      public function set DessertHouse(param1:TDessertHouse) : void
      {
         this.FDessertHouse = param1;
      }
      
      public function get ActivityTaskData() : TActivityTaskData
      {
         return this.FActivityTaskData;
      }
      
      public function set ActivityTaskData(param1:TActivityTaskData) : void
      {
         this.FActivityTaskData = param1;
      }
      
      public function get AugustActiveDatas() : TAugustActiveDatas
      {
         return this.FAugustActiveDatas;
      }
      
      public function set AugustActiveDatas(param1:TAugustActiveDatas) : void
      {
         this.FAugustActiveDatas = param1;
      }
      
      public function get KaguyaData() : OhtsutsukiKaguyaData
      {
         return this.FOhtsutsukiKaguyaData;
      }
      
      public function get NewMallLogicData() : NewMallData
      {
         return this.FNewMallData;
      }
      
      public function get TransmigrationTrialData() : TTransmigrationTrialData
      {
         return this.FTransmigrationTrialData;
      }
      
      public function get TransmigrationAccessoryData() : TTransmigrationAccessoryData
      {
         return this.FTransmigrationAccessoryData;
      }
      
      public function get TBooData() : TabooData
      {
         return this.FTBooData;
      }
      
      public function get TongLingDatas() : TTongLingDatas
      {
         return this.FTongLingDatas;
      }
      
      public function get AwakenDate() : AwakenLogicDate
      {
         return this.FAwakenDate;
      }
      
      public function get TheWorldTreeLogicData() : TTheWorldTreeLogicData
      {
         return this.FTheWorldTreeLogicData;
      }
      
      public function get EightDoorLogicData() : TEightDoorLogicData
      {
         return this.FEightDoorLogicData;
      }
      
      public function get UndertownLogicData() : TUndertownLogicData
      {
         return this.FUndertownLogicData;
      }
      
      public function get ZhenAoYiLogicData() : TZhenAoYiLogicData
      {
         return this.FZhenAoYiLogicData;
      }
      
      public function get LostShenQiLogicData() : TLostShenQiLogicData
      {
         return this.FLostShenQiLogicData;
      }
      
      public function get NewLottery() : TNewLottery
      {
         return this.FNewLottery;
      }
      
      public function set NewLottery(param1:TNewLottery) : void
      {
         this.FNewLottery = param1;
      }
      
      public function get SeptemberActiveDatas() : TSeptemberActiveDatas
      {
         return this.FSeptemberActiveDatas;
      }
      
      public function set SeptemberActiveDatas(param1:TSeptemberActiveDatas) : void
      {
         this.FSeptemberActiveDatas = param1;
      }
      
      public function get OctActiveDatas() : TOctActiveDatas
      {
         return this.FOctActiveDatas;
      }
      
      public function set OctActiveDatas(param1:TOctActiveDatas) : void
      {
         this.FOctActiveDatas = param1;
      }
      
      public function get DailyRecharge() : TDailyRecharge
      {
         return this.FDailyRecharge;
      }
      
      public function set DailyRecharge(param1:TDailyRecharge) : void
      {
         this.FDailyRecharge = param1;
      }
      
      public function get PoolUIDiceLog() : TPoolUIDiceLog
      {
         return this.FPoolUIDiceLog;
      }
      
      public function set PoolUIDiceLog(param1:TPoolUIDiceLog) : void
      {
         this.FPoolUIDiceLog = param1;
      }
      
      public function get CloudBuy() : TCloudBuy
      {
         return this.FCloudBuy;
      }
      
      public function set CloudBuy(param1:TCloudBuy) : void
      {
         this.FCloudBuy = param1;
      }
      
      public function get PoolUIFish() : TPoolUIFish
      {
         return this.FPoolUIFish;
      }
      
      public function set PoolUIFish(param1:TPoolUIFish) : void
      {
         this.FPoolUIFish = param1;
      }
      
      public function get FerrisWheel() : TFerrisWheel
      {
         return this.FFerrisWheel;
      }
      
      public function set FerrisWheel(param1:TFerrisWheel) : void
      {
         this.FFerrisWheel = param1;
      }
      
      public function get NovActiveDatas() : TNovActiveDatas
      {
         return this.FNovActiveDatas;
      }
      
      public function set NovActiveDatas(param1:TNovActiveDatas) : void
      {
         this.FNovActiveDatas = param1;
      }
      
      public function get ActiveRankDatas() : TActiveRankDatas
      {
         return this.FActiveRankDatas;
      }
      
      public function set ActiveRankDatas(param1:TActiveRankDatas) : void
      {
         this.FActiveRankDatas = param1;
      }
      
      public function get DecActiveDatas() : TDecActiveDatas
      {
         return this.FDecActiveDatas;
      }
      
      public function set DecActiveDatas(param1:TDecActiveDatas) : void
      {
         this.FDecActiveDatas = param1;
      }
      
      public function get SuperChristmas() : TSuperChristmas
      {
         return this.FSuperChristmas;
      }
      
      public function set SuperChristmas(param1:TSuperChristmas) : void
      {
         this.FSuperChristmas = param1;
      }
      
      public function get JanActiveDatas() : TJanActiveDatas
      {
         return this.FJanActiveDatas;
      }
      
      public function set JanActiveDatas(param1:TJanActiveDatas) : void
      {
         this.FJanActiveDatas = param1;
      }
      
      public function get FebActiveDatas() : TFebActiveDatas
      {
         return this.FFebActiveDatas;
      }
      
      public function set FebActiveDatas(param1:TFebActiveDatas) : void
      {
         this.FFebActiveDatas = param1;
      }
      
      public function get ActiveRankDataNew() : TActiveRankDataNew
      {
         return this.FActiveRankDataNew;
      }
      
      public function set ActiveRankDataNew(param1:TActiveRankDataNew) : void
      {
         this.FActiveRankDataNew = param1;
      }
      
      public function get MarchActiveDatas() : TMarchActiveDatas
      {
         return this.FMarchActiveDatas;
      }
      
      public function set MarchActiveDatas(param1:TMarchActiveDatas) : void
      {
         this.FMarchActiveDatas = param1;
      }
      
      public function get MarchConsume() : TMarchConsume
      {
         return this.FMarchConsume;
      }
      
      public function set MarchConsume(param1:TMarchConsume) : void
      {
         this.FMarchConsume = param1;
      }
      
      public function get AprilActiveDatas() : TAprilActiveDatas
      {
         return this.FAprilActiveDatas;
      }
      
      public function set AprilActiveDatas(param1:TAprilActiveDatas) : void
      {
         this.FAprilActiveDatas = param1;
      }
      
      public function get CapsuleToys() : TCapsuleToys
      {
         return this.FCapsuleToys;
      }
      
      public function set CapsuleToys(param1:TCapsuleToys) : void
      {
         this.FCapsuleToys = param1;
      }
      
      public function get GoldDigger() : TGoldDigger
      {
         return this.FGoldDigger;
      }
      
      public function set GoldDigger(param1:TGoldDigger) : void
      {
         this.FGoldDigger = param1;
      }
      
      public function get MayActiveDatas2015() : TMayActiveDatas_2015
      {
         return this.FMayActiveDatas2015;
      }
      
      public function set MayActiveDatas2015(param1:TMayActiveDatas_2015) : void
      {
         this.FMayActiveDatas2015 = param1;
      }
      
      public function get PersiaTrader() : TPersiaTrader
      {
         return this.FPersiaTrader;
      }
      
      public function set PersiaTrader(param1:TPersiaTrader) : void
      {
         this.FPersiaTrader = param1;
      }
      
      public function get AncientTreasure() : TAncientTreasure
      {
         return this.FAncientTreasure;
      }
      
      public function set AncientTreasure(param1:TAncientTreasure) : void
      {
         this.FAncientTreasure = param1;
      }
      
      public function get Cornucopia() : TCornucopia
      {
         return this.FCornucopia;
      }
      
      public function set Cornucopia(param1:TCornucopia) : void
      {
         this.FCornucopia = param1;
      }
      
      public function get GoldTree() : TGoldTree
      {
         return this.FGoldTree;
      }
      
      public function set GoldTree(param1:TGoldTree) : void
      {
         this.FGoldTree = param1;
      }
      
      public function get AlchemyStudio() : TAlchemyStudio
      {
         return this.FAlchemyStudio;
      }
      
      public function set AlchemyStudio(param1:TAlchemyStudio) : void
      {
         this.FAlchemyStudio = param1;
      }
      
      public function get GodWelfare() : TGodWelfare
      {
         return this.FGodWelfare;
      }
      
      public function set GodWelfare(param1:TGodWelfare) : void
      {
         this.FGodWelfare = param1;
      }
      
      public function get IdolumFight() : TIdolumFight
      {
         return this.FIdolumFight;
      }
      
      public function set IdolumFight(param1:TIdolumFight) : void
      {
         this.FIdolumFight = param1;
      }
      
      public function get Bejeweled() : TBejeweled
      {
         return this.FBejeweled;
      }
      
      public function set Bejeweled(param1:TBejeweled) : void
      {
         this.FBejeweled = param1;
      }
      
      public function get Exorcism() : TExorcism
      {
         return this.FExorcism;
      }
      
      public function set Exorcism(param1:TExorcism) : void
      {
         this.FExorcism = param1;
      }
      
      public function Update() : void
      {
         this.FPoolCharacter.Update();
         this.FPoolInventory.Update();
         this.FPoolQuest.Update();
         this.FPoolSkill.Update();
         this.FPoolBuff.Update();
         this.FPoolArena.Update();
         this.FPoolTavern.Update();
         this.FPoolMail.Update();
         this.FPoolCampaign.Update();
         this.FPoolItem.Update();
         this.FPoolTreasureMap.Update();
         this.FPoolCityDefend.Update();
         this.FPoolHyperString.Update();
         this.FPoolTraitorAttack.Update();
         this.FPoolFriendRamen.Update();
         this.FPoolCrossServerReport.Update();
         this.FPoolPalaceReport.Update();
         this.FPoolSignal.Update();
         this.FPoolUIRoleCanMove.Update();
         this.FPoolUISingleEquipment.Update();
         this.FPoolUIRewardItem.Update();
         this.FPoolUILotteryNews.Update();
         this.FPoolUINews.Update();
         this.FPoolToastRecord.Update();
         this.FPoolUIOrgMember.Update();
         this.FPoolUIDiceLog.Update();
         this.TimingUpdate();
      }
      
      public function SignalPost(param1:uint, param2:uint, param3:int = 0, param4:Object = null) : void
      {
         var _loc5_:TSignal = null;
         _loc5_ = this.FPoolSignal.Acquire(param1,param2,param3,param4);
         _loc5_.StubReferences.Reference(this);
         this.FSignals.push(_loc5_);
      }
      
      public function SignalRetrieve(param1:uint) : TSignal
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TSignal = null;
         _loc2_ = int(this.FSignals.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = this.FSignals[_loc3_];
            if(_loc4_.Destination == param1)
            {
               this.FSignals.splice(_loc3_,1);
               _loc4_.StubReferences.Dereference(this);
               return _loc4_;
            }
            _loc3_++;
         }
         return null;
      }
   }
}

