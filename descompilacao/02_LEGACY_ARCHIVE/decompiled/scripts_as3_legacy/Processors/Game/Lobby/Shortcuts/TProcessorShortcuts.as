package Processors.Game.Lobby.Shortcuts
{
   import Foundation.Common.*;
   import Foundation.Queries.Coordinate.*;
   import Foundation.Resources.*;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.*;
   import Logics.Characters.*;
   import Logics.Unlocks.*;
   import Processors.Game.Common.Effects.Texts.TEffectTextParameters;
   import Processors.Game.Lobby.Common.*;
   import Processors.Game.Lobby.Common.Shortcuts.*;
   import Processors.Game.Lobby.MainScene.Role.TUIRoleCanMovePlayerRole;
   import Processors.Game.Lobby.Shortcuts.Window.*;
   import Rendering.Overlayers.HelpTips.TOverlayerHelpTips;
   import Rendering.Overlayers.Hints.*;
   import Rendering.Overlayers.OhtsutsukiKaguya.TOverOhtsutsukiKaguyaIcon;
   import Resources.Constants.*;
   import Resources.Strings.*;
   import Utilities.UI.Overlayers.*;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.*;
   import ghostcat.operation.RepeatOper;
   import ghostcat.operation.TweenOper;
   
   public class TProcessorShortcuts extends TProcessorLobbyModule
   {
      
      protected static const POSITION_Function:uint = CONST_SHORTCUTS.POSITION_Function;
      
      protected static const POSITION_Activity:uint = CONST_SHORTCUTS.POSITION_Activity;
      
      protected static const POSITION_ActiveList:uint = CONST_SHORTCUTS.POSITION_ActiveList;
      
      protected static const POSITION_ActiveListSecondary:uint = CONST_SHORTCUTS.POSITION_ActiveListSecondary;
      
      protected static const POSITION_Avatar:uint = CONST_SHORTCUTS.POSITION_Avatar;
      
      protected static const POSITION_Constantly:uint = CONST_SHORTCUTS.POSITION_Constantly;
      
      protected static const POSITION_Map:uint = CONST_SHORTCUTS.POSITION_Map;
      
      protected static const POSITION_Additional:uint = CONST_SHORTCUTS.POSITION_Additional;
      
      public static const POSITION_Active_Special:uint = CONST_SHORTCUTS.POSITION_Active_Special;
      
      protected static const POSITION_NewActiveList:uint = CONST_SHORTCUTS.POSITION_NewActiveList;
      
      protected static const POSITION_ActiveListThird:uint = CONST_SHORTCUTS.POSITION_ActiveListThird;
      
      protected static const POSITION_Others:uint = CONST_SHORTCUTS.POSITION_Others;
      
      protected static const TYPE_Avatar_Hero:uint = CONST_SHORTCUTS.TYPE_Avatar_Hero;
      
      protected static const TYPE_Avatar_Military:uint = CONST_SHORTCUTS.TYPE_Avatar_Military;
      
      protected static const TYPE_Avatar_VIP:uint = CONST_SHORTCUTS.TYPE_Avatar_VIP;
      
      public static const TYPE_Avatar_Pet:uint = CONST_SHORTCUTS.TYPE_Avatar_Pet;
      
      protected static const TYPE_Activity_SubmitBug:uint = CONST_SHORTCUTS.TYPE_Activity_SubmitBug;
      
      protected static const TYPE_Activity_Arena:uint = CONST_SHORTCUTS.TYPE_Activity_Arena;
      
      protected static const TYPE_Activity_KillHeros:uint = CONST_SHORTCUTS.TYPE_Activity_KillHeros;
      
      protected static const TYPE_Activity_Sign:uint = CONST_SHORTCUTS.TYPE_Activity_Sign;
      
      protected static const TYPE_Activity_CopyHero:uint = CONST_SHORTCUTS.TYPE_Activity_CopyHero;
      
      protected static const TYPE_Activity_TreasureMap:uint = CONST_SHORTCUTS.TYPE_Activity_TreasureMap;
      
      protected static const TYPE_Activity_SuperHero:uint = CONST_SHORTCUTS.TYPE_Activity_SuperHero;
      
      protected static const TYPE_Activity_Mall:uint = CONST_SHORTCUTS.TYPE_Activity_Mall;
      
      protected static const TYPE_Activity_DailyQuest:uint = CONST_SHORTCUTS.TYPE_Activity_DailyQuest;
      
      protected static const TYPE_Activity_DailyActivity:uint = CONST_SHORTCUTS.TYPE_Activity_DailyActivity;
      
      protected static const TYPE_Activity_NarutoRoad:uint = CONST_SHORTCUTS.TYPE_Activity_NarutoRoad;
      
      protected static const TYPE_Activity_Slave:uint = CONST_SHORTCUTS.TYPE_Activity_Slave;
      
      protected static const TYPE_Activity_SevenKing:uint = CONST_SHORTCUTS.TYPE_Activity_SevenKing;
      
      protected static const TYPE_Activity_CrossServerWar:uint = CONST_SHORTCUTS.TYPE_Activity_CrossServerWar;
      
      protected static const TYPE_Activity_Magic:uint = CONST_SHORTCUTS.TYPE_Activity_Magic;
      
      protected static const TYPE_Activity_Moutain:uint = CONST_SHORTCUTS.TYPE_Activity_Moutain;
      
      protected static const TYPE_Activity_Tower:uint = CONST_SHORTCUTS.TYPE_Activity_Tower;
      
      protected static const TYPE_Activity_DailyWelfare:uint = CONST_SHORTCUTS.TYPE_Activity_DailyWelfare;
      
      protected static const TYPE_Activity_Palace:uint = CONST_SHORTCUTS.TYPE_Activity_Palace;
      
      protected static const TYPE_Activity_NijiaStar:uint = CONST_SHORTCUTS.TYPE_Activity_NijiaStar;
      
      protected static const TYPE_Activity_Ramen:uint = CONST_SHORTCUTS.TYPE_Activity_Ramen;
      
      protected static const TYPE_Activity_TopOrganization:uint = CONST_SHORTCUTS.TYPE_Activity_TopOrganization;
      
      protected static const TYPE_Activity_GroupBattle:uint = CONST_SHORTCUTS.TYPE_Activity_GroupBattle;
      
      protected static const TYPE_Activity_Laboratory:uint = CONST_SHORTCUTS.TYPE_Activity_Laboratory;
      
      protected static const TYPE_Activity_SixFairy:uint = CONST_SHORTCUTS.TYPE_Activity_SixFairy;
      
      protected static const TYPE_Activity_RebirthRealm:uint = CONST_SHORTCUTS.TYPE_Activity_RebirthRealm;
      
      protected static const TYPE_Activity_NijiaMystic:uint = CONST_SHORTCUTS.TYPE_Activity_NijiaMystic;
      
      protected static const TYPE_Activity_TopTeam:uint = CONST_SHORTCUTS.TYPE_Activity_TopTeam;
      
      protected static const TYPE_Activity_NarutoHelper:uint = CONST_SHORTCUTS.TYPE_Activity_NarutoHelper;
      
      protected static const TYPE_Activity_Choose:uint = CONST_SHORTCUTS.TYPE_Activity_Choose;
      
      protected static const TYPE_Activity_NinjaRelation:uint = CONST_SHORTCUTS.TYPE_Activity_NinjaRelation;
      
      protected static const TYPE_Activity_NinjaHostel:uint = CONST_SHORTCUTS.TYPE_Activity_NinjaHostel;
      
      protected static const TYPE_Activity_BloodFete:uint = CONST_SHORTCUTS.TYPE_Activity_BloodFete;
      
      protected static const TYPE_Activity_EpicEquip:uint = CONST_SHORTCUTS.TYPE_Activity_EpicEquip;
      
      protected static const TYPE_Activity_Taboo:uint = CONST_SHORTCUTS.TYPE_Activity_Taboo;
      
      protected static const TYPE_Activity_Awaken:uint = CONST_SHORTCUTS.TYPE_Activity_Awaken;
      
      protected static const TYPE_Activity_EightDoor:uint = CONST_SHORTCUTS.TYPE_Activity_EightDoor;
      
      protected static const TYPE_Activity_TransmigrationAccessory:uint = CONST_SHORTCUTS.TYPE_Activity_TransmigrationAccessory;
      
      protected static const TYPE_Activity_TheWorldTree:uint = CONST_SHORTCUTS.TYPE_Activity_TheWorldTree;
      
      protected static const TYPE_Activity_Undertown:uint = CONST_SHORTCUTS.TYPE_Activity_Undertown;
      
      protected static const TYPE_Activity_LostShenQi:uint = CONST_SHORTCUTS.TYPE_Activity_LostShenQi;
      
      protected static const TYPE_Activity_Wing:uint = CONST_SHORTCUTS.TYPE_Activity_Wing;
      
      protected static const TYPE_Activity_Challenge:uint = CONST_SHORTCUTS.TYPE_Activity_Challenge;
      
      protected static const TYPE_Activity_Illustrated:uint = CONST_SHORTCUTS.TYPE_Activity_Illustrated;
      
      protected static const TYPE_Activity_Aline:uint = CONST_SHORTCUTS.TYPE_Activity_Aline;
      
      protected static const TYPE_Activity_KingWar:uint = CONST_SHORTCUTS.TYPE_Activity_KingWar;
      
      protected static const TYPE_Activity_Medal:uint = CONST_SHORTCUTS.TYPE_Activity_Medal;
      
      protected static const TYPE_Activity_InviteCode:uint = CONST_SHORTCUTS.TYPE_Activity_InviteCode;
      
      protected static const TYPE_Activity_WuXing:uint = CONST_SHORTCUTS.TYPE_Activity_WuXing;
      
      protected static const TYPE_Activity_GlobalBattle:uint = CONST_SHORTCUTS.TYPE_Activity_GlobalBattle;
      
      protected static const TYPE_Activity_Emblem:uint = CONST_SHORTCUTS.TYPE_Activity_Emblem;
      
      protected static const TYPE_Activity_WorldMatch:uint = CONST_SHORTCUTS.TYPE_Activity_WorldMatch;
      
      protected static const TYPE_Activity_SummonBattle:uint = CONST_SHORTCUTS.TYPE_Activity_SummonBattle;
      
      protected static const TYPE_Activity_NinjaTalent:uint = CONST_SHORTCUTS.TYPE_Activity_NinjaTalent;
      
      protected static const TYPE_Activity_ChallengCamp:uint = CONST_SHORTCUTS.TYPE_Activity_ChallengCamp;
      
      protected static const TYPE_Activity_GlobalBoss:uint = CONST_SHORTCUTS.TYPE_Activity_GlobalBoss;
      
      protected static const TYPE_Activity_Recruit:uint = CONST_SHORTCUTS.TYPE_Activity_Recruit;
      
      protected static const TYPE_Activity_CrossSlave:uint = CONST_SHORTCUTS.TYPE_Activity_CrossSlave;
      
      public static const TYPE_Active_Special_CDK:uint = CONST_SHORTCUTS.TYPE_Active_Special_CDK;
      
      public static const TYPE_NewActiveList_Lottery:uint = CONST_SHORTCUTS.TYPE_NewActiveList_Lottery;
      
      public static const TYPE_NewActiveList_SystemActivity:uint = CONST_SHORTCUTS.TYPE_NewActiveList_SystemActivity;
      
      public static const TYPE_NewActiveList_DragonBoat:uint = CONST_SHORTCUTS.TYPE_NewActiveList_DragonBoat;
      
      public static const TYPE_NewActiveList_FrogWallet:uint = CONST_SHORTCUTS.TYPE_NewActiveList_FrogWallet;
      
      public static const TYPE_NewActiveList_VipShop:uint = CONST_SHORTCUTS.TYPE_NewActiveList_VipShop;
      
      public static const TYPE_NewActiveList_Dice:uint = CONST_SHORTCUTS.TYPE_NewActiveList_Dice;
      
      public static const TYPE_NewActiveList_TenTail:uint = CONST_SHORTCUTS.TYPE_NewActiveList_TenTail;
      
      public static const TYPE_NewActiveList_DragonBoat2:uint = CONST_SHORTCUTS.TYPE_NewActiveList_DragonBoat2;
      
      public static const TYPE_NewActiveList_DragonBoat3:uint = CONST_SHORTCUTS.TYPE_NewActiveList_DragonBoat3;
      
      public static const TYPE_NewActiveList_DragonBoat4:uint = CONST_SHORTCUTS.TYPE_NewActiveList_DragonBoat4;
      
      public static const TYPE_NewActiveList_DragonBoat5:uint = CONST_SHORTCUTS.TYPE_NewActiveList_DragonBoat5;
      
      public static const TYPE_NewActiveList_DragonBoat6:uint = CONST_SHORTCUTS.TYPE_NewActiveList_DragonBoat6;
      
      public static const TYPE_NewActiveList_DragonBoat7:uint = CONST_SHORTCUTS.TYPE_NewActiveList_DragonBoat7;
      
      public static const TYPE_NewActiveList_VIPFreeBuy:uint = CONST_SHORTCUTS.TYPE_NewActiveList_VIPFreeBuy;
      
      public static const TYPE_NewActiveList_ConsumeRank:uint = CONST_SHORTCUTS.TYPE_NewActiveList_ConsumeRank;
      
      public static const TYPE_NewActiveList_SeventhEvening:uint = CONST_SHORTCUTS.TYPE_NewActiveList_SeventhEvening;
      
      public static const TYPE_NewActiveList_HappyTreasure:uint = CONST_SHORTCUTS.TYPE_NewActiveList_HappyTreasure;
      
      public static const TYPE_NewActiveList_RechargeRank:uint = CONST_SHORTCUTS.TYPE_NewActiveList_RechargeRank;
      
      public static const TYPE_NewActiveList_GroupBuying:uint = CONST_SHORTCUTS.TYPE_NewActiveList_GroupBuying;
      
      public static const TYPE_NewActiveList_RechargeExchange:uint = CONST_SHORTCUTS.TYPE_NewActiveList_RechargeExchange;
      
      public static const TYPE_NewActiveList_OrangeEquipment:uint = CONST_SHORTCUTS.TYPE_NewActiveList_OrangeEquipment;
      
      public static const TYPE_NewActiveList_MidAutumn:uint = CONST_SHORTCUTS.TYPE_NewActiveList_MidAutumn;
      
      public static const TYPE_NewActiveList_Discount:uint = CONST_SHORTCUTS.TYPE_NewActiveList_Discount;
      
      public static const TYPE_NewActiveList_RechargeGive:uint = CONST_SHORTCUTS.TYPE_NewActiveList_RechargeGive;
      
      public static const TYPE_NewActiveList_NationalDay:uint = CONST_SHORTCUTS.TYPE_NewActiveList_NationalDay;
      
      public static const TYPE_NewActiveList_TreasureBox:uint = CONST_SHORTCUTS.TYPE_NewActiveList_TreasureBox;
      
      public static const TYPE_NewActiveList_Hallowmas:uint = CONST_SHORTCUTS.TYPE_NewActiveList_Hallowmas;
      
      public static const TYPE_NewActiveList_InviteFriend:uint = CONST_SHORTCUTS.TYPE_NewActiveList_InviteFriend;
      
      public static const TYPE_NewActiveList_GuaGuaLe:uint = CONST_SHORTCUTS.TYPE_NewActiveList_GuaGuaLe;
      
      public static const TYPE_NewActiveList_WishTree:uint = CONST_SHORTCUTS.TYPE_NewActiveList_WishTree;
      
      public static const TYPE_NewActiveList_EverydaySale:uint = CONST_SHORTCUTS.TYPE_NewActiveList_EverydaySale;
      
      public static const TYPE_NewActiveList_VipTreasure:uint = CONST_SHORTCUTS.TYPE_NewActiveList_VipTreasure;
      
      public static const TYPE_NewActiveList_CrossServerSale:uint = CONST_SHORTCUTS.TYPE_NewActiveList_CrossServerSale;
      
      public static const TYPE_NewActiveList_NewYear:uint = CONST_SHORTCUTS.TYPE_NewActiveList_NewYear;
      
      public static const TYPE_NewActiveList_ShowMore:uint = CONST_SHORTCUTS.TYPE_NewActiveList_ShowMore;
      
      public static const TYPE_NewActiveList_HideMore:uint = CONST_SHORTCUTS.TYPE_NewActiveList_HideMore;
      
      public static const TYPE_NewActiveList_ActivityA:uint = CONST_SHORTCUTS.TYPE_NewActiveList_ActivityA;
      
      public static const TYPE_NewActiveList_ActivityB:uint = CONST_SHORTCUTS.TYPE_NewActiveList_ActivityB;
      
      public static const TYPE_NewActiveList_BlackMarket:uint = CONST_SHORTCUTS.TYPE_NewActiveList_BlackMarket;
      
      public static const TYPE_NewActiveList_NinjaMeeting:uint = CONST_SHORTCUTS.TYPE_NewActiveList_NinjaMeeting;
      
      public static const TYPE_NewActiveList_FortuneCat:uint = CONST_SHORTCUTS.TYPE_NewActiveList_FortuneCat;
      
      public static const TYPE_NewActiveList_TowerLottery:uint = CONST_SHORTCUTS.TYPE_NewActiveList_TowerLottery;
      
      public static const TYPE_NewActiveList_SingleTopUp:uint = CONST_SHORTCUTS.TYPE_NewActiveList_SingleTopUp;
      
      public static const TYPE_NewActiveList_MuYeJuJiuWu:uint = CONST_SHORTCUTS.TYPE_NewActiveList_MuYeJuJiuWu;
      
      public static const TYPE_NewActiveList_SuperEquip:uint = CONST_SHORTCUTS.TYPE_NewActiveList_SuperEquip;
      
      public static const TYPE_NewActiveList_OneWorthThousand:uint = CONST_SHORTCUTS.TYPE_NewActiveList_OneWorthThousand;
      
      public static const TYPE_NewActiveList_PaymentWall:uint = CONST_SHORTCUTS.TYPE_NewActiveList_PaymentWall;
      
      public static const TYPE_NewActiveList_NinjaBank:uint = CONST_SHORTCUTS.TYPE_NewActiveList_NinjaBank;
      
      public static const TYPE_NewActiveList_FirstRecharge_new:uint = CONST_SHORTCUTS.TYPE_NewActiveList_FirstRecharge_new;
      
      public static const TYPE_NewActiveList_ComeBack:uint = CONST_SHORTCUTS.TYPE_NewActiveList_ComeBack;
      
      public static const TYPE_NewActiveList_DessertHouse:uint = CONST_SHORTCUTS.TYPE_NewActiveList_DessertHouse;
      
      public static const TYPE_NewActiveList_NewLottery:uint = CONST_SHORTCUTS.TYPE_NewActiveList_NewLottery;
      
      public static const TYPE_NewActiveList_DailyRecharge:uint = CONST_SHORTCUTS.TYPE_NewActiveList_DailyRecharge;
      
      public static const TYPE_NewActiveList_CloudBuy:uint = CONST_SHORTCUTS.TYPE_NewActiveList_CloudBuy;
      
      public static const TYPE_NewActiveList_FerrisWheel:uint = CONST_SHORTCUTS.TYPE_NewActiveList_FerrisWheel;
      
      public static const TYPE_NewActiveList_MarchConsume:uint = CONST_SHORTCUTS.TYPE_NewActiveList_MarchConsume;
      
      public static const TYPE_NewActiveList_CapsuleToys:uint = CONST_SHORTCUTS.TYPE_NewActiveList_CapsuleToys;
      
      public static const TYPE_NewActiveList_GoldDigger:uint = CONST_SHORTCUTS.TYPE_NewActiveList_GoldDigger;
      
      public static const TYPE_NewActiveList_PersiaTrader:uint = CONST_SHORTCUTS.TYPE_NewActiveList_PersiaTrader;
      
      public static const TYPE_NewActiveList_AncientTreasure:uint = CONST_SHORTCUTS.TYPE_NewActiveList_AncientTreasure;
      
      public static const TYPE_NewActiveList_Cornucopia:uint = CONST_SHORTCUTS.TYPE_NewActiveList_Cornucopia;
      
      public static const TYPE_NewActiveList_GoldTree:uint = CONST_SHORTCUTS.TYPE_NewActiveList_GoldTree;
      
      public static const TYPE_NewActiveList_AlchemyStudio:uint = CONST_SHORTCUTS.TYPE_NewActiveList_AlchemyStudio;
      
      public static const TYPE_NewActiveList_GodWelfare:uint = CONST_SHORTCUTS.TYPE_NewActiveList_GodWelfare;
      
      public static const TYPE_NewActiveList_IdolumFight:uint = CONST_SHORTCUTS.TYPE_NewActiveList_IdolumFight;
      
      public static const TYPE_NewActiveList_Bejeweled:uint = CONST_SHORTCUTS.TYPE_NewActiveList_Bejeweled;
      
      public static const TYPE_NewActiveList_Exorcism:uint = CONST_SHORTCUTS.TYPE_NewActiveList_Exorcism;
      
      public static const TYPE_NewActiveList_NinjaCrystal:uint = CONST_SHORTCUTS.TYPE_NewActiveList_NinjaCrystal;
      
      public static const TYPE_NewActiveList_BossTreasure:uint = CONST_SHORTCUTS.TYPE_NewActiveList_BossTreasure;
      
      public static const TYPE_NewActiveList_LoginGift:uint = CONST_SHORTCUTS.TYPE_NewActiveList_LoginGift;
      
      public static const TYPE_NewActiveList_DailyFirstRecharge:uint = CONST_SHORTCUTS.TYPE_NewActiveList_DailyFirstRecharge;
      
      public static const TYPE_NewActiveList_SignGift:uint = CONST_SHORTCUTS.TYPE_NewActiveList_SignGift;
      
      public static const TYPE_NewActiveList_FateRoulette:uint = CONST_SHORTCUTS.TYPE_NewActiveList_FateRoulette;
      
      public static const TYPE_NewActiveList_WanSheng2:uint = CONST_SHORTCUTS.TYPE_NewActiveList_WanSheng2;
      
      public static const TYPE_NewActiveList_NinjaFund:uint = CONST_SHORTCUTS.TYPE_NewActiveList_NinjaFund;
      
      public static const TYPE_NewActiveList_CatWomen:uint = CONST_SHORTCUTS.TYPE_NewActiveList_CatWomen;
      
      public static const TYPE_NewActiveList_LotteryMachine:uint = CONST_SHORTCUTS.TYPE_NewActiveList_LotteryMachine;
      
      public static const TYPE_NewActiveList_CreationAncestor:uint = CONST_SHORTCUTS.TYPE_NewActiveList_CreationAncestor;
      
      public static const TYPE_NewActiveList_BindEmail:uint = CONST_SHORTCUTS.TYPE_NewActiveList_BindEmail;
      
      public static const TYPE_NewActiveList_Double11Mall:uint = CONST_SHORTCUTS.TYPE_NewActiveList_Double11Mall;
      
      public static const TYPE_NewActiveList_LevelGifts:uint = CONST_SHORTCUTS.TYPE_NewActiveList_LevelGifts;
      
      public static const TYPE_NewActiveList_DayRechargeGift:uint = CONST_SHORTCUTS.TYPE_NewActiveList_DayRechargeGift;
      
      public static const TYPE_ActiveListThird_NinjiaVillage:uint = CONST_SHORTCUTS.TYPE_ActiveListThird_NinjiaVillage;
      
      public static const TYPE_ActiveListThird_Christmas:uint = CONST_SHORTCUTS.TYPE_ActiveListThird_Christmas;
      
      public static const TYPE_ActiveListThird_SpringFestival:uint = CONST_SHORTCUTS.TYPE_ActiveListThird_SpringFestival;
      
      public static const TYPE_ActiveListThird_ValentineDay:uint = CONST_SHORTCUTS.TYPE_ActiveListThird_ValentineDay;
      
      public static const TYPE_ActiveListThird_FightBoss:uint = CONST_SHORTCUTS.TYPE_ActiveListThird_FightBoss;
      
      public static const TYPE_ActiveListThird_BrazilCarnival:uint = CONST_SHORTCUTS.TYPE_ActiveListThird_BrazilCarnival;
      
      public static const TYPE_ActiveListThird_NinjaTreasure:uint = CONST_SHORTCUTS.TYPE_ActiveListThird_NinjaTreasure;
      
      public static const TYPE_ActiveListThird_MayActive:uint = CONST_SHORTCUTS.TYPE_ActiveListThird_MayActive;
      
      public static const TYPE_ActiveListThird_JuneActive:uint = CONST_SHORTCUTS.TYPE_ActiveListThird_JuneActive;
      
      public static const TYPE_ActiveListThird_JulyActive:uint = CONST_SHORTCUTS.TYPE_ActiveListThird_JulyActive;
      
      public static const TYPE_ActiveListThird_AugustActive:uint = CONST_SHORTCUTS.TYPE_ActiveListThird_AugustActive;
      
      public static const TYPE_ActiveListThird_SeptemberActive:uint = CONST_SHORTCUTS.TYPE_ActiveListThird_SeptemberActive;
      
      public static const TYPE_ActiveListThird_OctActive:uint = CONST_SHORTCUTS.TYPE_ActiveListThird_OctActive;
      
      public static const TYPE_ActiveListThird_NovActive:uint = CONST_SHORTCUTS.TYPE_ActiveListThird_NovActive;
      
      public static const TYPE_ActiveListThird_DecActive:uint = CONST_SHORTCUTS.TYPE_ActiveListThird_DecActive;
      
      public static const TYPE_ActiveListThird_JanActive:uint = CONST_SHORTCUTS.TYPE_ActiveListThird_JanActive;
      
      public static const TYPE_ActiveListThird_FebActive:uint = CONST_SHORTCUTS.TYPE_ActiveListThird_FebActive;
      
      public static const TYPE_ActiveListThird_MarchActive:uint = CONST_SHORTCUTS.TYPE_ActiveListThird_MarchActive;
      
      public static const TYPE_ActiveListThird_AprilActive:uint = CONST_SHORTCUTS.TYPE_ActiveListThird_AprilActive;
      
      public static const TYPE_ActiveListThird_MayActive_2015:uint = CONST_SHORTCUTS.TYPE_ActiveListThird_MayActive_2015;
      
      public static const TYPE_ActiveListThird_MoonFestival:uint = CONST_SHORTCUTS.TYPE_ActiveListThird_MoonFestival;
      
      public static const TYPE_ActiveListThird_NationDay_2015:uint = CONST_SHORTCUTS.TYPE_ActiveListThird_NationDay_2015;
      
      public static const TYPE_ActiveListThird_HallowmasActive:uint = CONST_SHORTCUTS.TYPE_ActiveListThird_HallowmasActive;
      
      public static const TYPE_NewActiveList_WanSheng:uint = CONST_SHORTCUTS.TYPE_NewActiveList_WanSheng;
      
      public static const TYPE_NewActiveList_ThanksgivingDay:uint = CONST_SHORTCUTS.TYPE_NewActiveList_ThanksgivingDay;
      
      public static const TYPE_NewActiveList_Nov:uint = CONST_SHORTCUTS.TYPE_NewActiveList_Nov;
      
      public static const TYPE_NewActiveList_Christmas2015:uint = CONST_SHORTCUTS.TYPE_NewActiveList_Christmas2015;
      
      public static const TYPE_NewActiveList_JanActive2016:uint = CONST_SHORTCUTS.TYPE_NewActiveList_JanActive2016;
      
      public static const TYPE_ActiveListThird_Nov2016:uint = CONST_SHORTCUTS.TYPE_ActiveListThird_Nov2016;
      
      public static const TYPE_ActiveListThird_WitchProving:uint = CONST_SHORTCUTS.TYPE_ActiveListThird_WitchProving;
      
      public static const TYPE_NewActiveList_Christmas2016:uint = CONST_SHORTCUTS.TYPE_NewActiveList_Christmas2016;
      
      public static const TYPE_NewActiveList_WorldCup:uint = CONST_SHORTCUTS.TYPE_NewActiveList_WorldCup;
      
      public static const TYPE_ActiveListThird_NewSpring2018:uint = CONST_SHORTCUTS.TYPE_ActiveListThird_NewSpring2018;
      
      public static const TYPE_ActiveListThird_Smelt:uint = CONST_SHORTCUTS.TYPE_ActiveListThird_Smelt;
      
      public static const TYPE_ActiveListThird_ChristmasDay:uint = CONST_SHORTCUTS.TYPE_ActiveListThird_ChristmasDay;
      
      public static const TYPE_ActiveListThird_LeadLevelGifts:uint = CONST_SHORTCUTS.TYPE_ActiveListThird_LeadLevelGifts;
      
      protected static const TYPE_ActiveList_RechageCashBack:uint = CONST_SHORTCUTS.TYPE_ActiveList_RechageCashBack;
      
      protected static const TYPE_ActiveList_FirstRecharge:uint = CONST_SHORTCUTS.TYPE_ActiveList_FirstRecharge;
      
      protected static const TYPE_ActiveList_Recharge:uint = CONST_SHORTCUTS.TYPE_ActiveList_Recharge;
      
      protected static const TYPE_ActiveList_Wonderful:uint = CONST_SHORTCUTS.TYPE_ActiveList_Wonderful;
      
      protected static const TYPE_ActiveList_ReceivePacks:uint = CONST_SHORTCUTS.TYPE_ActiveList_ReceivePacks;
      
      protected static const TYPE_ActiveListSecondary_FirstDayGiftBag:uint = CONST_SHORTCUTS.TYPE_ActiveListSecondary_FirstDayGiftBag;
      
      protected static const TYPE_ActiveListSecondary_OnLineGiftBag:uint = CONST_SHORTCUTS.TYPE_ActiveListSecondary_OnLineGiftBag;
      
      protected static const TYPE_ActiveListSecondary_GoldGiftBag:uint = CONST_SHORTCUTS.TYPE_ActiveListSecondary_GoldGiftBag;
      
      protected static const TYPE_ActiveListSecondary_7DayGiftBag:uint = CONST_SHORTCUTS.TYPE_ActiveListSecondary_7DayGiftBag;
      
      protected static const TYPE_ActiveListSecondary_HFReward:uint = CONST_SHORTCUTS.TYPE_ActiveListSecondary_HFReward;
      
      protected static const TYPE_ActiveListSecondary_LevelGift:uint = CONST_SHORTCUTS.TYPE_ActiveListSecondary_LevelGift;
      
      protected static const TYPE_ActiveListSecondary_CollectGame:uint = CONST_SHORTCUTS.TYPE_ActiveListSecondary_CollectGame;
      
      protected static const TYPE_Function_Heros:uint = CONST_SHORTCUTS.TYPE_Function_Heros;
      
      protected static const TYPE_Function_Star:uint = CONST_SHORTCUTS.TYPE_Function_Star;
      
      protected static const TYPE_Function_TacticalDeployment:uint = CONST_SHORTCUTS.TYPE_Function_TacticalDeployment;
      
      protected static const TYPE_Function_Backpack:uint = CONST_SHORTCUTS.TYPE_Function_Backpack;
      
      protected static const TYPE_Function_Treasure:uint = CONST_SHORTCUTS.TYPE_Function_Treasure;
      
      protected static const TYPE_Function_SummonPet:uint = CONST_SHORTCUTS.TYPE_Function_SummonPet;
      
      protected static const TYPE_Function_Strengthen:uint = CONST_SHORTCUTS.TYPE_Function_Strengthen;
      
      protected static const TYPE_Function_Mail:uint = CONST_SHORTCUTS.TYPE_Function_Mail;
      
      protected static const TYPE_Function_TongLing:uint = CONST_SHORTCUTS.TYPE_Function_TongLing;
      
      protected static const TYPE_Function_OrganiZation:uint = CONST_SHORTCUTS.TYPE_Function_OrganiZation;
      
      protected static const TYPE_Function_InheritPractice:uint = CONST_SHORTCUTS.TYPE_Function_InheritPractice;
      
      protected static const TYPE_Function_Return:uint = CONST_SHORTCUTS.TYPE_Function_Return;
      
      protected static const TYPE_Constantly_BigDipper:uint = CONST_SHORTCUTS.TYPE_Constantly_BigDipper;
      
      protected static const TYPE_Whitelist_Add:uint = CONST_FRIEND.TYPE_Whitelist_Add;
      
      public static const TYPE_Map_EnterWorldMap:uint = CONST_SHORTCUTS.TYPE_Map_EnterWorldMap;
      
      public static const TYPE_Map_Mail:uint = CONST_SHORTCUTS.TYPE_Map_Mail;
      
      public static const TYPE_Map_Friend:uint = CONST_SHORTCUTS.TYPE_Map_Friend;
      
      protected static const TYPE_Additional_Tavern:uint = CONST_SHORTCUTS.TYPE_Additional_Tavern;
      
      protected static const TYPE_Additional_Jade:uint = CONST_SHORTCUTS.TYPE_Additional_Jade;
      
      public static const TYPE_Additional_MakeEquip:uint = CONST_SHORTCUTS.TYPE_Additional_MakeEquip;
      
      public static const TYPE_Additional_MakeEquipAdvanced:uint = CONST_SHORTCUTS.TYPE_Additional_MakeEquipAdvanced;
      
      public static const TYPE_Additional_MuyeGuard:uint = CONST_SHORTCUTS.TYPE_Additional_MuyeGuard;
      
      public static const TYPE_Additional_PetBattle:uint = CONST_SHORTCUTS.TYPE_Additional_PetBattle;
      
      public static const TYPE_Additional_MuyeBattle:uint = CONST_SHORTCUTS.TYPE_Additional_MuyeBattle;
      
      public static const TYPE_Additional_TraitorAttack:uint = CONST_SHORTCUTS.TYPE_Additional_TraitorAttack;
      
      public static const TYPE_Additional_Accessory:uint = CONST_SHORTCUTS.TYPE_Additional_Accessory;
      
      public static const STRING_UnOperatingWarning:String = STRING_SHORTCUTS.STRING_UnOperatingWarning;
      
      public static const STRING_OperatingWarning:String = STRING_SHORTCUTS.STRING_OperatingWarning;
      
      public static const FORMAT_QuestWarning:String = STRING_SHORTCUTS.FORMAT_QuestWarning;
      
      public static const FORMAT_LevelWarning:String = STRING_SHORTCUTS.FORMAT_LevelWarning;
      
      public static const STRING_FUNCTION_NAMES:Vector.<String> = STRING_SHORTCUTS.STRING_FUNCTION_NAMES;
      
      public static const STRING_ACTIVITY_NAMES:Vector.<String> = STRING_SHORTCUTS.STRING_ACTIVITY_NAMES;
      
      public static const STRING_ACTIVESPECIAL_NAMES:Vector.<String> = STRING_SHORTCUTS.STRING_ACTIVESPECIAL_NAMES;
      
      public static const STRING_CONSTANTLY_NAMES:Vector.<String> = STRING_SHORTCUTS.STRING_CONSTANTLY_NAMES;
      
      public static const STRING_ADDITIONAL_NAMES:Vector.<String> = STRING_SHORTCUTS.STRING_ADDITIONAL_NAMES;
      
      protected static const COORDINATE_Activity_X:int = 1022;
      
      protected static const COORDINATE_Activity_Y:int = 0;
      
      protected static const COORDINATE_ActiveSpecial_X:int = 1022;
      
      protected static const COORDINATE_ActiveSpecial_Y:int = 80;
      
      protected static const COORDINATE_ActiveList_X:int = 1022;
      
      protected static const COORDINATE_ActiveList_Y:int = 80;
      
      protected static const COORDINATE_NewActiveList_X:int = 1022;
      
      protected static const COORDINATE_NewActiveList_Y:int = 80;
      
      protected static const COORDINATE_ActiveListThird_X:int = 1022;
      
      protected static const COORDINATE_ActiveListThird_Y:int = 158;
      
      protected static const COORDINATE_Function_X:int = 574;
      
      protected static const COORDINATE_Function_Y:int = 585;
      
      protected static const COORDINATE_System_X:int = 1087;
      
      protected static const COORDINATE_System_Y:int = 608;
      
      protected static const COORDINATE_Quest_X:int = 1050;
      
      protected static const COORDINATE_Quest_Y:int = 160;
      
      protected static const COORDINATE_Map_X:int = 1164;
      
      protected static const COORDINATE_Map_Y:int = 0;
      
      protected static const CONSTANTLY_MAP_X:int = 0;
      
      protected static const CONSTANTLY_Constantly_Y:int = 250;
      
      protected var FOverlayerHint:TOverlayerHint;
      
      protected var FOverlayerHelpTips:TOverlayerHelpTips;
      
      protected var FOverKaguyaTip:TOverOhtsutsukiKaguyaIcon;
      
      protected var FCharacter:TCharacter;
      
      protected var FUnlocks:TUnlocks;
      
      protected var FWindowAvatar:TWindowAvatar;
      
      protected var FWindowActivity:TWindowActivity;
      
      protected var FWindowActiveSpecial:TWindowActiveSpecial;
      
      protected var FWindowActiveList:TWindowActiveList;
      
      protected var FWindowMap:TWindowMap;
      
      protected var FWindowQuest:TWindowQuestGuide;
      
      protected var FWindowFunction:TWindowFunction;
      
      protected var FWindowConstantly:TWindowConstantly;
      
      protected var FWindowHeroInfor:TWindowHeroInfor;
      
      protected var FWindowNewActiveList:TWindowNewActiveList;
      
      protected var FWindowActiveListThird:TWindowActiveListThird;
      
      protected var FStreamParameter:ByteArray;
      
      protected var FOnAvaterHead:Function;
      
      protected var FOnVip:Function;
      
      protected var FOnEnterAutoBattle:Function;
      
      protected var FWelfareOnClick:Function;
      
      protected var FObligatoryCoursesOnClick:Function;
      
      protected var FBaiDuMeimeiOnClick:Function;
      
      protected var FOhtsutsukiKaguyaOnClick:Function;
      
      protected var FOhtsutsuVkOnClick:Function;
      
      protected var FMC1377OnClick:Function;
      
      public var AccountLockOnClick:Function;
      
      public var RankIconClick:Function;
      
      public var OnVipWelfareClick:Function;
      
      public var OnMicrologin:Function;
      
      public var OnConsumeVip:Function;
      
      protected var FOnActivitySubmitBug:Function;
      
      protected var FOnActivityArena:Function;
      
      protected var FOnActivityKillHeros:Function;
      
      protected var FOnActivitySign:Function;
      
      protected var FOnActivityCopyHero:Function;
      
      protected var FOnActivityTreasureMap:Function;
      
      protected var FOnActivitySuperHero:Function;
      
      protected var FOnActivityMall:Function;
      
      protected var FOnActivityDailyQuest:Function;
      
      protected var FOnActivityDailyActivity:Function;
      
      protected var FOnActivityNarutoRoad:Function;
      
      protected var FOnActivitySlave:Function;
      
      protected var FOnActivitySevenKing:Function;
      
      protected var FOnActivityCrossServerWar:Function;
      
      protected var FOnActivityMagic:Function;
      
      protected var FOnActivityMoutain:Function;
      
      protected var FOnActivityTower:Function;
      
      protected var FOnActivityDailyWelfare:Function;
      
      protected var FOnActivityPalace:Function;
      
      protected var FOnActivityNijiaStar:Function;
      
      protected var FOnActivityRamen:Function;
      
      protected var FOnActivityTopOrganization:Function;
      
      protected var FOnActivityGroupBattle:Function;
      
      protected var FOnActivityLaboratory:Function;
      
      protected var FOnActivitySixFairy:Function;
      
      protected var FOnActivityRebirthRealm:Function;
      
      protected var FOnActivityTopTeam:Function;
      
      protected var FOnActivityNijiaMystic:Function;
      
      protected var FOnActivityNarutoHelper:Function;
      
      protected var FOnActivityChoose:Function;
      
      protected var FOnActivityNinjaRelation:Function;
      
      protected var FOnActivityNinjaHostel:Function;
      
      protected var FOnActivityBloodFete:Function;
      
      protected var FOnActivityEpicEquip:Function;
      
      protected var FOnActivityTaboo:Function;
      
      protected var FOnActivityAwaken:Function;
      
      protected var FOnActivityEight:Function;
      
      protected var FOnActivityTransmigrationAccessory:Function;
      
      protected var FOnActivityTheWorldTree:Function;
      
      protected var FOnActivityUndertown:Function;
      
      protected var FOnActivityLostShenQi:Function;
      
      protected var FOnActivityWing:Function;
      
      protected var FOnActivityChallenge:Function;
      
      protected var FOnActivityIllustrated:Function;
      
      protected var FOnActivityAlien:Function;
      
      protected var FOnActivityKingwar:Function;
      
      protected var FOnActivityMedal:Function;
      
      protected var FOnActivityinviteCode:Function;
      
      protected var FOnActivityWuxing:Function;
      
      protected var FOnActivityGlobalBattle:Function;
      
      protected var FOnActivityEmblem:Function;
      
      protected var FOnActivityWorldMatch:Function;
      
      protected var FOnActivitySummonBattle:Function;
      
      protected var FOnActivityNinjaTalent:Function;
      
      protected var FOnActivityChallengCamp:Function;
      
      protected var FOnActivityGlobalBoss:Function;
      
      protected var FOnActivityRecruit:Function;
      
      protected var FOnActivityCrossSlave:Function;
      
      protected var FOnActiveSpecialCDK:Function;
      
      protected var FOnActiveSpecialDiscord:Function;
      
      protected var FOnNewActiveListLottery:Function;
      
      protected var FOnNewActiveListSystemActivity:Function;
      
      protected var FOnNewActiveListDragonBoat:Function;
      
      protected var FOnNewActiveListFrogWallet:Function;
      
      protected var FOnNewActiveListVipShop:Function;
      
      protected var FOnNewActiveListDice:Function;
      
      protected var FOnNewActiveListTenTail:Function;
      
      protected var FOnNewActiveListDragonBoat2:Function;
      
      protected var FOnNewActiveListDragonBoat3:Function;
      
      protected var FOnNewActiveListDragonBoat4:Function;
      
      protected var FOnNewActiveListDragonBoat5:Function;
      
      protected var FOnNewActiveListDragonBoat6:Function;
      
      protected var FOnNewActiveListDragonBoat7:Function;
      
      protected var FOnNewActiveListVIPFreeBuy:Function;
      
      protected var FOnNewActiveListConsumeRank:Function;
      
      protected var FOnNewActiveListSeventhEvening:Function;
      
      protected var FOnNewActiveListHappyTreasure:Function;
      
      protected var FOnNewActiveListRechargeRank:Function;
      
      protected var FOnNewActiveListGroupBuying:Function;
      
      protected var FOnNewActiveListRechargeExchange:Function;
      
      protected var FOnNewActiveListOrangeEquipment:Function;
      
      protected var FOnNewActiveListMidAutumn:Function;
      
      protected var FOnNewActiveListDiscount:Function;
      
      protected var FOnNewActiveListRechargeGive:Function;
      
      protected var FOnNewActiveListNationalDay:Function;
      
      protected var FOnNewActiveListTreasureBox:Function;
      
      protected var FOnNewActiveListHallowmas:Function;
      
      protected var FOnNewActiveListInviteFriend:Function;
      
      protected var FOnNewActiveListGuaGuaLe:Function;
      
      protected var FOnNewActiveListWishTree:Function;
      
      protected var FOnNewActiveListEverydaySale:Function;
      
      protected var FOnNewActiveListVipTreasure:Function;
      
      protected var FOnNewActiveListCrossServerSale:Function;
      
      protected var FOnNewActiveListNewYear:Function;
      
      protected var FOnNewActiveListShowMore:Function;
      
      protected var FOnNewActiveListHideMore:Function;
      
      protected var FOnNewActiveListActivityA:Function;
      
      protected var FOnNewActiveListActivityB:Function;
      
      protected var FOnNewActiveListBlackMarket:Function;
      
      protected var FOnNewActiveListNinjaMeeting:Function;
      
      protected var FOnNewActiveListFortuneCat:Function;
      
      protected var FOnNewActiveListTowerLottery:Function;
      
      protected var FOnNewActiveListSingleTopUp:Function;
      
      protected var FOnNewActiveListMyActive:Function;
      
      protected var FOnNewActiveListSuperEquip:Function;
      
      protected var FOnNewActiveListOneWorthThousand:Function;
      
      protected var FOnNewActiveListPaymentWall:Function;
      
      protected var FOnNewActiveListNinjaBank:Function;
      
      protected var FOnNewActiveListFirstRecharge_New:Function;
      
      protected var FOnNewActiveListComeBack:Function;
      
      protected var FOnNewActiveListDessertHouse:Function;
      
      protected var FOnNewActiveListNewLottery:Function;
      
      protected var FOnNewActiveListDailyRecharge:Function;
      
      protected var FOnNewActiveListCloudBuy:Function;
      
      protected var FOnNewActiveListFerrisWheel:Function;
      
      protected var FOnNewActiveListMarchConsume:Function;
      
      protected var FOnNewActiveListCapsuleToys:Function;
      
      protected var FOnNewActiveListGoldDigger:Function;
      
      protected var FOnNewActiveListPersiaTrader:Function;
      
      protected var FOnNewActiveListAncientTreasure:Function;
      
      protected var FOnNewActiveListCornucopia:Function;
      
      protected var FOnNewActiveListGoldTree:Function;
      
      protected var FOnNewActiveListAlchemyStudio:Function;
      
      protected var FOnNewActiveListGodWelfare:Function;
      
      protected var FOnNewActiveListIdolumFight:Function;
      
      public var OnNewActiveListBejeweled:Function;
      
      public var OnNewActiveListExorcism:Function;
      
      public var OnNewActiveListNinjaCrystal:Function;
      
      public var OnNewActiveListBossTreasure:Function;
      
      public var OnNewActiveListLoginGift:Function;
      
      public var OnNewActiveListDailyFirstRecharge:Function;
      
      public var OnNewActiveListSignGift:Function;
      
      public var OnNewActiveListFateRoulette:Function;
      
      public var OnNewActiveListWanSheng2:Function;
      
      public var OnNewActiveListNinjaFund:Function;
      
      public var OnNewActiveListCatWomen:Function;
      
      public var OnNewActiveListLotteryMachine:Function;
      
      public var OnNewActiveListCreationAncestor:Function;
      
      public var OnNewActiveListBindEmail:Function;
      
      public var OnNewActiveListDouble11Mall:Function;
      
      public var OnNewActiveListLevelGifts:Function;
      
      public var OnNewActiveListDayRechargeGift:Function;
      
      protected var FOnActiveListThirdNinjiaVillage:Function;
      
      protected var FOnNewActiveListChristmas:Function;
      
      protected var FOnNewActiveListSpringFestival:Function;
      
      protected var FOnNewActiveListValentineDay:Function;
      
      protected var FOnNewActiveListFightBoss:Function;
      
      protected var FOnNewActiveListBrazilCarnival:Function;
      
      protected var FOnNewActiveListNinjaTreasure:Function;
      
      protected var FOnNewActiveListMayActive:Function;
      
      protected var FOnNewActiveListJuneActive:Function;
      
      protected var FOnNewActiveListJulyActive:Function;
      
      protected var FOnNewActiveListAugustActive:Function;
      
      protected var FOnNewActiveListSeptemberActive:Function;
      
      protected var FOnNewActiveListOctActive:Function;
      
      protected var FOnNewActiveListNovActive:Function;
      
      protected var FOnNewActiveListDecActive:Function;
      
      protected var FOnNewActiveListJanActive:Function;
      
      protected var FOnNewActiveListFebActive:Function;
      
      protected var FOnNewActiveListMarchActive:Function;
      
      protected var FOnNewActiveListAprilActive:Function;
      
      protected var FOnNewActiveListMayActive2015:Function;
      
      public var OnNewActiveListMoonFestival:Function;
      
      public var OnNewActiveListNationDay2015:Function;
      
      public var OnNewActiveListHallowmasActive:Function;
      
      public var OnNewActiveListWanSheng:Function;
      
      public var OnNewActiveListThanksgivingDay:Function;
      
      public var OnNewActiveListNov:Function;
      
      public var OnNewActiveListChristmas2015:Function;
      
      public var OnNewActiveListJanActive2016:Function;
      
      public var OnNewActiveListNov2016:Function;
      
      public var OnNewActiveListWitchProving:Function;
      
      public var OnNewActiveListChristmas2016:Function;
      
      public var OnNewActiveListWorldCup:Function;
      
      public var OnNewActiveListNewSpring2018:Function;
      
      public var OnNewActiveListSmelt:Function;
      
      public var OnNewActiveListChristmasDay:Function;
      
      public var OnNewActiveListLeadLevelGifts:Function;
      
      protected var FOnActiveListFirstRechageCashBack:Function;
      
      protected var FOnActiveListFirstRecharge:Function;
      
      protected var FOnActiveListRecharge:Function;
      
      protected var FOnActiveListWonderful:Function;
      
      protected var FOnActiveListReceivePacks:Function;
      
      protected var FOnActiveListSecondaryFirstDayGiftBag:Function;
      
      protected var FOnActiveListSecondaryOnLineGiftBag:Function;
      
      protected var FOnActiveListSecondaryGoldGiftBag:Function;
      
      protected var FOnActiveListSecondary7DayGiftBag:Function;
      
      protected var FOnActiveListSecondaryHFReward:Function;
      
      protected var FOnActiveListSecondaryLevelGift:Function;
      
      protected var FOnActiveListSecondaryCollectGame:Function;
      
      protected var FOnEnterWorldMap:Function;
      
      protected var FOnEnterCity:Function;
      
      protected var FOnViewRaiders:Function;
      
      protected var FOnMail:Function;
      
      protected var FOnQuest:Function;
      
      protected var FOnFriend:Function;
      
      protected var FOnSwitchDisplay:Function;
      
      protected var FOnAutoBattle:Function;
      
      protected var FOnZeroReq:Function;
      
      protected var FOnHeros:Function;
      
      protected var FOnGeneralStar:Function;
      
      protected var FOnTacticalDeployment:Function;
      
      protected var FOnInheritPractice:Function;
      
      protected var FOnBackpack:Function;
      
      protected var FOnTreasure:Function;
      
      protected var FOnSummonPet:Function;
      
      protected var FOnStrengthen:Function;
      
      protected var FOnTongLing:Function;
      
      protected var FOnOrganiZation:Function;
      
      protected var FOnReturn:Function;
      
      protected var FHomeland:Function;
      
      protected var FOnConstantlyBigDipper:Function;
      
      protected var FOnConstantlyMentorship:Function;
      
      protected var FShowOtherHeroInfor:Function;
      
      protected var FRequestWhisper:Function;
      
      protected var FRequestAddFriend:Function;
      
      protected var FRequestSendMail:Function;
      
      protected var FOnAdditionalTavern:Function;
      
      protected var FOnAdditionalJade:Function;
      
      protected var FOnAdditionalMakeEquip:Function;
      
      protected var FOnAdditionalMakeEquipAdvanced:Function;
      
      protected var FOnAdditionalMuyeGuard:Function;
      
      protected var FOnAdditionalPetBattle:Function;
      
      protected var FOnAdditionalMuyeBattle:Function;
      
      protected var FOnAdditionalTraitorAttack:Function;
      
      protected var FOnAdditionalAccessoryIntensity:Function;
      
      protected var FOnUnlockResponse:Function;
      
      protected var FOnPromote:Function;
      
      private var FButton:MovieClip;
      
      private var _isboL:Boolean;
      
      private var oldArray:Array;
      
      protected var FTweenFadeIn1:TweenOper;
      
      protected var FTweenFadeIn2:TweenOper;
      
      protected var FTweenFadeIn3:TweenOper;
      
      protected var FTweenFadeIn4:TweenOper;
      
      protected var FTweenFadeIn5:TweenOper;
      
      protected var FRepeatOper:RepeatOper;
      
      public var FParameter:int;
      
      protected var FOpenOnLineGift:Function;
      
      public function TProcessorShortcuts(param1:TUIComponent, param2:TUIComponent, param3:TLobbyParameters)
      {
         super(param1,param3);
         param2.mouseEnabled = false;
         this.FCharacter = SLogicsCore.Character;
         this.FUnlocks = SLogicsCore.Unlocks;
         this.FWindowAvatar = new TWindowAvatar(this);
         this.FWindowAvatar.HintOnMove = this.UIComponentsHintOnOver;
         this.FWindowAvatar.HintOnOut = this.UIComponentsHintOnOut;
         this.FWindowAvatar.KaguyaOnOver = this.KaguyaOnOver;
         this.FWindowAvatar.KaguyaOnOut = this.KaguyaOnOut;
         this.FWindowAvatar.OnHead = this.ProcessorAvaterHeadOnClick;
         this.FWindowAvatar.OnSummonPet = this.ProcessorAvaterSummonPetOnClick;
         this.FWindowAvatar.OnVIP = this.ProcessorAvaterVIPOnClick;
         this.FWindowAvatar.OnConsumeVip = this.ProcessorConsumeVIPOnClick;
         this.FWindowAvatar.OnEffectGenerateText = this.ProcessorEffectGenerateTextOnClick;
         this.FWindowAvatar.OnPromote = this.ProcessorOnPromote;
         this.FWindowAvatar.HelpHintOnMove = this.UIHelpTipsHintOnOver;
         this.FWindowAvatar.HelpHintOnOut = this.UIHelpTipsHintOnOut;
         this.FWindowAvatar.OnEnterAutoBattle = this.ProcessorEnterAutoBattle;
         this.FWindowAvatar.WelfareOnClick = this.ProcessorWelfareOnClick;
         this.FWindowAvatar.ObligatoryCoursesOnClick = this.ProcessorObligatoryCoursesOnClick;
         this.FWindowAvatar.BaiDuMeimei = this.ProcessorBaiDuMeimeiOnClick;
         this.FWindowAvatar.OhtsutsukiKaguya = this.ProcessorOhtsutsukiKaguyaOnClick;
         this.FWindowAvatar.OpenOnLineGift = this.FOpenOnLineGiftFunction;
         this.FWindowAvatar.VkClickFunction = this.ProcessorVkClickOnClick;
         this.FWindowAvatar.MC_1377ClickFun = this.ProcessorMC1377OnClick;
         this.FWindowAvatar.AccountLockOnClick = this.ProcessorAccountLockOnClick;
         this.FWindowAvatar.RankIconClick = this.ProcessorRankIconClick;
         this.FWindowAvatar.OnVipClickFun = this.ProcessorVipWelfareOnClick;
         this.FWindowAvatar.OnMicrologin = this.ProcessorMicrologinClick;
         this.FWindowAvatar.Visible = false;
         this.FWindowMap = new TWindowMap(this);
         this.FWindowMap.HintOnMove = this.UIComponentsHintOnOver;
         this.FWindowMap.HintOnOut = this.UIComponentsHintOnOut;
         this.FWindowMap.HelpHintOnMove = this.UIHelpTipsHintOnOver;
         this.FWindowMap.HelpHintOnOut = this.UIHelpTipsHintOnOut;
         this.FWindowMap.OnWorldMap = this.ProcessorWorldMapOnClick;
         this.FWindowMap.OnReturnHome = this.ProcessorReturnHomeOnClick;
         this.FWindowMap.OnViewRaiders = this.ProcessorViewRaidersOnClick;
         this.FWindowMap.OnMail = this.ProcessorMapOnMail;
         this.FWindowMap.OnQuest = this.ProcessorMapOnQuest;
         this.FWindowMap.OnFriend = this.ProcessorMapOnFriend;
         this.FWindowMap.OnSwitchDisplay = this.ProcessorMapOnSwitchDisplay;
         this.FWindowMap.AutoBattle = this.ProcessorMapOnAutoBattle;
         this.FWindowMap.ZeroReq = this.ProcessorMapOnZeroReq;
         this.FWindowMap.Visible = false;
         this.FWindowMap.x = COORDINATE_Map_X;
         this.FWindowMap.y = COORDINATE_Map_Y;
         this.FWindowQuest = new TWindowQuestGuide(this);
         this.FWindowQuest.HintOnOver = this.UIComponentsHintOnOver;
         this.FWindowQuest.HintOnOut = this.UIComponentsHintOnOut;
         this.FWindowQuest.Visible = false;
         this.FWindowQuest.x = COORDINATE_Quest_X;
         this.FWindowQuest.y = COORDINATE_Quest_Y;
         this.FWindowActivity = new TWindowActivity(this,param2);
         this.FWindowActivity.OnActivity = this.ProcessorActivityOnClick;
         this.FWindowActivity.OnUnlockActivityResponse = this.ProcessorOnUnlockResponse;
         this.FWindowActivity.Visible = false;
         this.FWindowActivity.x = COORDINATE_Activity_X;
         this.FWindowActivity.y = COORDINATE_Activity_Y;
         this.FWindowActiveSpecial = new TWindowActiveSpecial(this);
         this.FWindowActiveSpecial.OnActiveSpecial = this.ProcessorActiveSpecialOnClick;
         this.FWindowActiveSpecial.OnUnlockActiveSpecialResponse = this.ProcessorOnUnlockResponse;
         this.FWindowActiveSpecial.Visible = false;
         this.FWindowActiveSpecial.x = COORDINATE_ActiveSpecial_X;
         this.FWindowActiveSpecial.y = COORDINATE_ActiveSpecial_Y;
         this.FWindowActiveList = new TWindowActiveList(this,param2);
         this.FWindowActiveList.OnActiveList = this.ProcessorActiveListOnClick;
         this.FWindowActiveList.OnActiveListSecondary = this.ProcessorActiveListSecondaryOnClick;
         this.FWindowActiveList.HintOnOver = this.UIComponentsHintOnOver;
         this.FWindowActiveList.HintOnOut = this.UIComponentsHintOnOut;
         this.FWindowActiveList.Visible = false;
         this.FWindowActiveList.x = COORDINATE_ActiveList_X;
         this.FWindowActiveList.y = COORDINATE_ActiveList_Y;
         this.FWindowFunction = new TWindowFunction(this);
         this.FWindowFunction.OnMainFunction = this.ProcessorMainFunctionOnClick;
         this.FWindowFunction.OnUnlockFunctionResponse = this.ProcessorOnUnlockResponse;
         this.FWindowFunction.HintOnOver = this.UIComponentsHintOnOver;
         this.FWindowFunction.HintOnOut = this.UIComponentsHintOnOut;
         this.FWindowFunction.Visible = false;
         this.FWindowFunction.x = COORDINATE_Function_X;
         this.FWindowFunction.y = COORDINATE_Function_Y;
         this.FWindowConstantly = new TWindowConstantly(this);
         this.FWindowConstantly.OnOpenFunctionWindow = this.ProcessorConstantlyOnClick;
         this.FWindowConstantly.OnOpenActivityWindow = this.ProcessorConstantlyOnClick;
         this.FWindowConstantly.OnOpenBigDipperWindow = this.ProcessorBigDipperOnClick;
         this.FWindowConstantly.HintOnOver = this.UIComponentsHintOnOver;
         this.FWindowConstantly.HintOnOut = this.UIComponentsHintOnOut;
         this.FWindowConstantly.Visible = false;
         this.FWindowConstantly.Y = CONSTANTLY_Constantly_Y;
         this.FWindowNewActiveList = new TWindowNewActiveList(this,param2);
         this.FWindowNewActiveList.OnActiveList = this.ProcessorNewActiveListOnClick;
         this.FWindowNewActiveList.OnSecondaryActiveList = this.ProcessorNewActiveListSecondaryOnClick;
         this.FWindowNewActiveList.Visible = false;
         this.FWindowNewActiveList.x = COORDINATE_NewActiveList_X;
         this.FWindowNewActiveList.y = COORDINATE_NewActiveList_Y;
         this.FWindowActiveListThird = new TWindowActiveListThird(this);
         this.FWindowActiveListThird.OnActiveList = this.ProcessorActiveListThirdOnClick;
         this.FWindowActiveListThird.Visible = false;
         this.FWindowActiveListThird.x = COORDINATE_ActiveListThird_X;
         this.FWindowActiveListThird.y = COORDINATE_ActiveListThird_Y;
         this.FWindowHeroInfor = new TWindowHeroInfor(this);
         this.FWindowHeroInfor.HeroInforOnClick = this.ProcessorHeroInforOnClick;
         this.FWindowHeroInfor.Visible = false;
         this.FOverlayerHint = new TOverlayerHint(param2);
         this.FOverlayerHint.visible = false;
         this.FOverlayerHelpTips = new TOverlayerHelpTips(param2);
         this.FOverlayerHelpTips.visible = false;
         this.FOverKaguyaTip = new TOverOhtsutsukiKaguyaIcon(param2);
         this.FOverKaguyaTip.visible = false;
         this.FStreamParameter = new ByteArray();
         FResourcesState = RESOURCESSTATE_UIRequest;
         if(this.oldArray == null)
         {
            this.oldArray = [];
            this.oldArray[0] = this.FWindowActivity.y;
            this.oldArray[1] = this.FWindowActiveSpecial.y;
            this.oldArray[2] = this.FWindowActiveList.y;
            this.oldArray[3] = this.FWindowNewActiveList.y;
            this.oldArray[4] = this.FWindowActiveListThird.y;
         }
         this.FTweenFadeIn1 = new TweenOper();
         this.FTweenFadeIn2 = new TweenOper();
         this.FTweenFadeIn3 = new TweenOper();
         this.FTweenFadeIn4 = new TweenOper();
         this.FTweenFadeIn5 = new TweenOper();
         this.FTweenFadeIn1.duration = 1200;
         this.FTweenFadeIn2.duration = 1200;
         this.FTweenFadeIn3.duration = 1200;
         this.FTweenFadeIn4.duration = 1200;
         this.FTweenFadeIn5.duration = 1200;
         this.FRepeatOper = new RepeatOper();
         this.FRepeatOper.loop = 1;
         this.FRepeatOper.children = [this.FTweenFadeIn1,this.FTweenFadeIn2,this.FTweenFadeIn3,this.FTweenFadeIn4,this.FTweenFadeIn5];
         this.FTweenFadeIn1.target = this.FWindowActivity;
         this.FTweenFadeIn2.target = this.FWindowActiveSpecial;
         this.FTweenFadeIn3.target = this.FWindowActiveList;
         this.FTweenFadeIn4.target = this.FWindowNewActiveList;
         this.FTweenFadeIn5.target = this.FWindowActiveListThird;
      }
      
      protected function OnClickHandler(param1:MouseEvent) : void
      {
         this._isboL = !this._isboL;
         if(this._isboL)
         {
            this.in_him();
            this.FButton.gotoAndStop(1);
         }
         else
         {
            this.out_show();
            this.FButton.gotoAndStop(2);
         }
      }
      
      public function out_show() : void
      {
         this.FTweenFadeIn1.params = {"y":this.oldArray[0]};
         this.FTweenFadeIn2.params = {"y":this.oldArray[1]};
         this.FTweenFadeIn3.params = {"y":this.oldArray[2]};
         this.FTweenFadeIn4.params = {"y":this.oldArray[3]};
         this.FTweenFadeIn5.params = {"y":this.oldArray[4]};
         this.FTweenFadeIn1.execute();
         this.FTweenFadeIn2.execute();
         this.FTweenFadeIn3.execute();
         this.FTweenFadeIn4.execute();
         this.FTweenFadeIn5.execute();
      }
      
      public function in_him() : void
      {
         this.FTweenFadeIn1.params = {"y":Number(this.FWindowActivity.y - 250)};
         this.FTweenFadeIn2.params = {"y":Number(this.FWindowActiveSpecial.y - 250)};
         this.FTweenFadeIn3.params = {"y":Number(this.FWindowActiveList.y - 250)};
         this.FTweenFadeIn4.params = {"y":Number(this.FWindowNewActiveList.y - 250)};
         this.FTweenFadeIn5.params = {"y":Number(this.FWindowActiveListThird.y - 250)};
         this.FTweenFadeIn1.execute();
         this.FTweenFadeIn2.execute();
         this.FTweenFadeIn3.execute();
         this.FTweenFadeIn4.execute();
         this.FTweenFadeIn5.execute();
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_SHORTCUTS.RESOURCESID_Shortcut);
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_SHORTCUTS.RESOURCESID_Activity_Shortcut);
         SResourcesCore.TexturesLobby.LoadPrimary(CONST_LOBBY.RESOURCESID_Textures_ShortcutEffect);
         SResourcesCore.TexturesLobby.LoadPrimary(CONST_LOBBY.RESOURCESID_Textures_SpecialShortcutEffect);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.FWindowAvatar.Perform_UIDispatch();
         this.FWindowActivity.Perform_UIDispatch();
         this.FWindowActiveSpecial.Perform_UIDispatch();
         this.FWindowActiveList.Perform_UIDispatch();
         this.FWindowMap.Perform_UIDispatch();
         this.FWindowQuest.Perform_UIDispatch();
         this.FWindowFunction.Perform_UIDispatch();
         this.FWindowConstantly.Perform_UIDispatch();
         this.FWindowHeroInfor.Perform_UIDispatch();
         this.FWindowNewActiveList.Perform_UIDispatch();
         this.FWindowActiveListThird.Perform_UIDispatch();
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerHint);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerHelpTips);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverKaguyaTip);
         this.FButton = TUtilityReflection.CreateInstance("HideButtons") as MovieClip;
         if(this.FButton)
         {
            this.FButton.visible = false;
            this.FButton.x = 1145;
            this.FButton.y = 110;
            this.FButton.buttonMode = true;
            this.FButton.gotoAndStop(2);
            this.FButton.addEventListener(MouseEvent.CLICK,this.OnClickHandler);
            this.addChild(this.FButton);
         }
         super.ResourcesPerform_UIDispatch();
      }
      
      public function IsShowOhtsutsukiKaguya() : void
      {
         this.FWindowAvatar.IsShowOhtsutsukiKaguya();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         this.ProcessorResize();
         this.FWindowAvatar.Update();
         this.FWindowActivity.Update();
         this.FWindowActiveSpecial.Update();
         this.FWindowActiveList.Update();
         this.FWindowMap.Update();
         this.FWindowFunction.Update();
         this.FWindowConstantly.Update();
         this.FWindowNewActiveList.Update();
         this.FWindowActiveListThird.Update();
      }
      
      override protected function ProcessorResize() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         _loc1_ = FUICore.StageWidth;
         _loc2_ = FUICore.StageHeight;
         if(this.FWindowActivity.ShortcutWidth > 0)
         {
            this.FWindowActivity.X = _loc1_ - this.FWindowMap.ShortcutWidth - this.FWindowActivity.ShortcutWidth + this.FWindowMap.OffestWidth;
            if(!this.FWindowActivity.Visible)
            {
               this.FWindowActivity.Visible = true;
               if(this.FButton)
               {
                  this.FButton.visible = true;
               }
            }
         }
         else if(this.FWindowActivity.Visible)
         {
            this.FWindowActivity.Visible = false;
            if(this.FButton)
            {
               this.FButton.visible = false;
            }
         }
         if(this.FWindowMap.ShortcutWidth > 0)
         {
            this.FWindowMap.X = _loc1_ - this.FWindowMap.ShortcutWidth;
            if(this.FWindowMap.Visible == false)
            {
               this.FWindowMap.Visible = true;
            }
         }
         else if(this.FWindowMap.Visible)
         {
            this.FWindowMap.Visible = false;
         }
         if(this.FWindowMap.IsMainScene && this.FWindowActiveSpecial.ShortcutWidth > 0)
         {
            this.FWindowActiveSpecial.X = _loc1_ - this.FWindowMap.ShortcutWidth - this.FWindowActiveSpecial.ShortcutWidth + this.FWindowMap.OffestWidth + 30;
            if(!this.FWindowActiveSpecial.Visible)
            {
               this.FWindowActiveSpecial.Visible = true;
            }
         }
         else if(this.FWindowActiveSpecial.Visible)
         {
            this.FWindowActiveSpecial.Visible = false;
         }
         if(this.FWindowMap.IsMainScene && this.FWindowActiveList.ShortcutWidth > 0)
         {
            this.FWindowActiveList.X = this.FWindowActiveSpecial.X - this.FWindowActiveList.Width + 30;
            if(!this.FWindowActiveList.Visible)
            {
               this.FWindowActiveList.Visible = true;
            }
         }
         else if(this.FWindowActiveList.Visible)
         {
            this.FWindowActiveList.Visible = false;
         }
         if(this.FWindowMap.IsMainScene && this.FWindowNewActiveList.ShortcutWidth > 0)
         {
            if(this.FWindowActiveList.ShortcutWidth > 0)
            {
               this.FWindowNewActiveList.X = this.FWindowActiveSpecial.X - this.FWindowActiveList.Width - this.FWindowNewActiveList.Width + 55;
            }
            else
            {
               this.FWindowNewActiveList.X = this.FWindowActiveSpecial.X - this.FWindowNewActiveList.Width + 35;
            }
            if(!this.FWindowNewActiveList.Visible)
            {
               this.FWindowNewActiveList.Visible = true;
            }
         }
         else if(this.FWindowNewActiveList.Visible)
         {
            this.FWindowNewActiveList.Visible = false;
         }
         if(this.FWindowMap.IsMainScene && this.FWindowActiveListThird.ShortcutWidth > 0)
         {
            this.FWindowActiveListThird.X = _loc1_ - this.FWindowActiveListThird.ShortcutWidth - 230;
            if(!this.FWindowActiveListThird.Visible)
            {
               this.FWindowActiveListThird.Visible = true;
            }
         }
         else if(this.FWindowActiveListThird.Visible)
         {
            this.FWindowActiveListThird.Visible = false;
         }
         if(this.FWindowQuest.ShortcutWidth > 0)
         {
            this.FWindowQuest.X = _loc1_ - this.FWindowQuest.ShortcutWidth;
            if(!this.FWindowQuest.Visible)
            {
               this.FWindowQuest.Visible = true;
            }
         }
         else if(this.FWindowQuest.Visible)
         {
            this.FWindowQuest.Visible = false;
         }
         if(this.FWindowFunction.ShortcutWidth > 0)
         {
            this.FWindowFunction.X = _loc1_ - this.FWindowFunction.ShortcutWidth;
            if(!this.FWindowFunction.Visible)
            {
               this.FWindowFunction.Visible = true;
            }
         }
         else if(this.FWindowFunction.Visible)
         {
            this.FWindowFunction.Visible = false;
         }
         if(this.FWindowMap.IsMainScene && this.FWindowHeroInfor.Visible && this.FWindowHeroInfor.ShortcutWidth > 0)
         {
            this.FWindowHeroInfor.X = this.FWindowAvatar.X + this.FWindowAvatar.ShortcutWidth;
         }
         else
         {
            this.HideHeroContorlPanle();
         }
         if(this.FWindowConstantly.ShortcutWidth > 0)
         {
            this.FWindowConstantly.Y = this.FWindowAvatar.Y + this.FWindowAvatar.ShortcutHeight + 10;
            if(!this.FWindowConstantly.Visible)
            {
               this.FWindowConstantly.Visible = true;
            }
         }
         else if(this.FWindowConstantly.Visible)
         {
            this.FWindowConstantly.Visible = false;
         }
      }
      
      protected function ShortcutHeroInforOperating(param1:String) : void
      {
      }
      
      protected function ShortcutAvaterHeadOperating(param1:uint, param2:int, param3:Object) : void
      {
         switch(param1)
         {
            case TYPE_Avatar_Hero:
            case TYPE_Avatar_Military:
               this.FStreamParameter.length = 0;
               this.FStreamParameter.writeByte(param2);
               this.FStreamParameter.position = 0;
               this.ProcessorAvaterHeadOnClick(this,this.FStreamParameter);
               break;
            case TYPE_Avatar_VIP:
               this.ProcessorAvaterVIPOnClick(this);
               break;
            case TYPE_Avatar_Pet:
         }
      }
      
      protected function ShortcutActivityOperating(param1:uint, param2:int, param3:Object) : void
      {
         this.FStreamParameter.length = 0;
         this.FStreamParameter.writeInt(param2);
         this.FStreamParameter.position = 0;
         this.ProcessorActivityOnClick(this,param1,this.FStreamParameter,param3);
      }
      
      protected function ShortcutActiveSpecialOperating(param1:uint, param2:int, param3:Object) : void
      {
         this.FStreamParameter.length = 0;
         this.FStreamParameter.writeInt(param2);
         this.FStreamParameter.position = 0;
         this.ProcessorActiveSpecialOnClick(this,param1,this.FStreamParameter);
      }
      
      protected function ShortcutFunctionOperating(param1:uint, param2:int, param3:Object) : void
      {
         this.ProcessorMainFunctionOnClick(this,param1,param2,param3);
      }
      
      protected function ShortcutConstantlyOperating(param1:uint, param2:int, param3:Object) : void
      {
         this.ProcessorConstantlyOnClick(this,param1,0);
      }
      
      protected function ShortcutMapOperating(param1:uint, param2:int, param3:Object) : void
      {
         switch(param1)
         {
            case TYPE_Map_EnterWorldMap:
               this.ProcessorWorldMapOnClick(this);
               break;
            case TYPE_Map_Friend:
               this.ProcessorMapOnFriend(this);
         }
      }
      
      protected function ShortcutAdditionalOperating(param1:uint, param2:int, param3:Object) : void
      {
         this.ProcessornAdditionalOnClick(this,param1,param3);
      }
      
      protected function VerificationLocaltionOperatingByPosition(param1:uint, param2:uint) : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:TUnlock = null;
         var _loc6_:Boolean = false;
         _loc6_ = false;
         _loc4_ = this.FUnlocks.Count;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc5_ = this.FUnlocks.GetUnlockByIndex(_loc3_);
            if(param1 == _loc5_.Position && param2 == _loc5_.Localtion)
            {
               if(_loc5_.State == TUnlock.UNLOCKSTATE_Unlocked)
               {
                  _loc6_ = true;
                  break;
               }
            }
            _loc3_++;
         }
         return _loc6_;
      }
      
      protected function InquiryConditionLocaltionOperatingByPosition(param1:uint, param2:uint) : String
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:TUnlock = null;
         var _loc6_:uint = 0;
         var _loc7_:Vector.<String> = null;
         var _loc8_:String = null;
         _loc6_ = 0;
         _loc4_ = this.FUnlocks.Count;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc5_ = this.FUnlocks.GetUnlockByIndex(_loc3_);
            if(param1 == _loc5_.Position && param2 == _loc5_.Localtion)
            {
               _loc6_ = _loc5_.UnlockValue;
               break;
            }
            _loc3_++;
         }
         if(_loc6_ > 1000)
         {
            _loc8_ = FORMAT_QuestWarning;
         }
         else
         {
            _loc8_ = TUtilityString.Format(FORMAT_LevelWarning,_loc6_);
         }
         switch(param1)
         {
            case POSITION_Function:
               _loc7_ = STRING_FUNCTION_NAMES;
               break;
            case POSITION_Activity:
               _loc7_ = STRING_ACTIVITY_NAMES;
               break;
            case POSITION_Constantly:
               _loc7_ = STRING_CONSTANTLY_NAMES;
               break;
            case POSITION_Additional:
               _loc7_ = STRING_ADDITIONAL_NAMES;
               break;
            case POSITION_Active_Special:
               _loc7_ = STRING_ACTIVESPECIAL_NAMES;
         }
         if(_loc5_.UnlockCondition == 3)
         {
            _loc8_ = TUtilityString.Format(STRING_UnOperatingWarning,_loc7_[param2]);
         }
         else
         {
            _loc8_ = _loc8_ + TUtilityString.Format(STRING_OperatingWarning,_loc7_[param2]);
         }
         return _loc8_;
      }
      
      protected function Unopened() : void
      {
         EffectGenerateText(STRING_SHORTCUTS.STRING_FunctionLock);
      }
      
      protected function UIHelpTipsHintOnOver(param1:Object, param2:THint) : void
      {
         this.FOverlayerHelpTips.Context = param2;
         this.FOverlayerHelpTips.Render(FUICore.MouseCoordinate);
         this.FOverlayerHelpTips.Show();
      }
      
      protected function UIHelpTipsHintOnOut(param1:Object) : void
      {
         this.FOverlayerHelpTips.Hide();
      }
      
      protected function KaguyaOnOver() : void
      {
         this.FOverKaguyaTip.Context = 1;
         this.FOverKaguyaTip.Render(FUICore.MouseCoordinate);
         this.FOverKaguyaTip.Show();
      }
      
      protected function KaguyaOnOut() : void
      {
         this.FOverKaguyaTip.Hide();
      }
      
      protected function UIComponentsHintOnOver(param1:Object, param2:THint) : void
      {
         this.FOverlayerHint.Context = param2;
         this.FOverlayerHint.Render(FUICore.MouseCoordinate);
         this.FOverlayerHint.Show();
      }
      
      protected function UIComponentsHintOnOut(param1:Object) : void
      {
         this.FOverlayerHint.Hide();
      }
      
      protected function ProcessorAvaterHeadOnClick(param1:Object, param2:ByteArray) : void
      {
         if(this.FOnAvaterHead != null)
         {
            this.FOnAvaterHead(param1,param2);
         }
      }
      
      protected function ProcessorAvaterSummonPetOnClick(param1:Object) : void
      {
         if(this.FOnSummonPet != null)
         {
            this.FOnSummonPet(param1);
         }
      }
      
      protected function ProcessorAvaterVIPOnClick(param1:Object) : void
      {
         if(this.FOnVip != null)
         {
            this.FOnVip(param1);
         }
      }
      
      protected function ProcessorActivityOnClick(param1:Object, param2:int, param3:ByteArray = null, param4:Object = null) : void
      {
         switch(param2)
         {
            case TYPE_Activity_SubmitBug:
               if(this.FOnActivitySubmitBug != null)
               {
                  this.FOnActivitySubmitBug(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_Activity_Arena:
               if(this.FOnActivityArena != null)
               {
                  this.FOnActivityArena(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_Activity_KillHeros:
               if(this.FOnActivityKillHeros != null)
               {
                  this.FOnActivityKillHeros(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_Activity_Sign:
               if(this.FOnActivitySign != null)
               {
                  this.FOnActivitySign(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_Activity_CopyHero:
               if(this.FOnActivityCopyHero != null)
               {
                  this.FOnActivityCopyHero(this,param3);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_Activity_TreasureMap:
               if(this.FOnActivityTreasureMap != null)
               {
                  this.FOnActivityTreasureMap(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_Activity_SuperHero:
               if(this.FOnActivitySuperHero != null)
               {
                  this.FOnActivitySuperHero(this,param3);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_Activity_Mall:
               if(this.FOnActivityMall != null)
               {
                  this.FOnActivityMall(this,param3);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_Activity_DailyQuest:
               if(this.FOnActivityDailyQuest != null)
               {
                  this.FOnActivityDailyQuest(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_Activity_DailyActivity:
               if(this.FOnActivityDailyActivity != null)
               {
                  this.FOnActivityDailyActivity(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_Activity_NarutoRoad:
               if(this.FOnActivityNarutoRoad != null)
               {
                  this.FOnActivityNarutoRoad(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_Activity_Slave:
               if(this.FOnActivitySlave != null)
               {
                  this.FOnActivitySlave(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_Activity_SevenKing:
               if(this.FOnActivitySevenKing != null)
               {
                  this.FOnActivitySevenKing(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_Activity_CrossServerWar:
               if(this.FOnActivityCrossServerWar != null)
               {
                  this.FOnActivityCrossServerWar(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_Activity_Magic:
               if(this.FOnActivityMagic != null)
               {
                  this.FOnActivityMagic(this,param3);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_Activity_Moutain:
               if(this.FOnActivityMoutain != null)
               {
                  this.FOnActivityMoutain(this,param3);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_Activity_Tower:
               if(this.FOnActivityTower != null)
               {
                  this.FOnActivityTower(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_Activity_DailyWelfare:
               if(this.FOnActivityDailyWelfare != null)
               {
                  this.FOnActivityDailyWelfare(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_Activity_Palace:
               if(this.FOnActivityPalace != null)
               {
                  this.FOnActivityPalace(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_Activity_NijiaStar:
               if(this.FOnActivityNijiaStar != null)
               {
                  this.FOnActivityNijiaStar(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_Activity_Ramen:
               if(this.FOnActivityRamen != null)
               {
                  this.FOnActivityRamen(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_Activity_TopOrganization:
               if(this.FOnActivityTopOrganization != null)
               {
                  this.FOnActivityTopOrganization(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_Activity_GroupBattle:
               if(this.FOnActivityGroupBattle != null)
               {
                  this.FOnActivityGroupBattle(this,param3);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_Activity_Laboratory:
               if(this.FOnActivityLaboratory != null)
               {
                  this.FOnActivityLaboratory(this,param3);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_Activity_SixFairy:
               if(this.FOnActivitySixFairy != null)
               {
                  this.FOnActivitySixFairy(this,param3);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_Activity_RebirthRealm:
               if(this.FOnActivityRebirthRealm != null)
               {
                  this.FOnActivityRebirthRealm(this,param3);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_Activity_TopTeam:
               if(this.FOnActivityTopTeam != null)
               {
                  this.FOnActivityTopTeam(this,param3);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_Activity_NijiaMystic:
               if(this.FOnActivityNijiaMystic != null)
               {
                  this.FOnActivityNijiaMystic(this,param3);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_Activity_NarutoHelper:
               if(this.FOnActivityNarutoHelper != null)
               {
                  this.FOnActivityNarutoHelper(this,param3);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_Activity_Choose:
               if(this.FOnActivityChoose != null)
               {
                  this.FOnActivityChoose(this,param3);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_Activity_NinjaRelation:
               if(this.FOnActivityNinjaRelation != null)
               {
                  this.FOnActivityNinjaRelation(this,param3);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_Activity_NinjaHostel:
               if(this.FOnActivityNinjaHostel != null)
               {
                  this.FOnActivityNinjaHostel(this,param3);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_Activity_BloodFete:
               if(this.FOnActivityBloodFete != null)
               {
                  this.FOnActivityBloodFete(this,param3);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_Activity_EpicEquip:
               if(this.FOnActivityEpicEquip != null)
               {
                  this.FOnActivityEpicEquip(this,param3,param4);
               }
               break;
            case TYPE_Activity_Taboo:
               if(this.FOnActivityTaboo != null)
               {
                  this.FOnActivityTaboo(this,param3);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_Activity_Awaken:
               if(this.FOnActivityAwaken != null)
               {
                  this.FOnActivityAwaken(this,param3);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_Activity_EightDoor:
               if(this.FOnActivityEight != null)
               {
                  this.FOnActivityEight(this,param3);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_Activity_TransmigrationAccessory:
               if(this.FOnActivityTransmigrationAccessory != null)
               {
                  this.FOnActivityTransmigrationAccessory(this,param3);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_Activity_TheWorldTree:
               if(this.FOnActivityTheWorldTree != null)
               {
                  this.FOnActivityTheWorldTree(this,param3);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_Activity_Undertown:
               if(this.FOnActivityUndertown != null)
               {
                  this.FOnActivityUndertown(this,param3);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_Activity_LostShenQi:
               if(this.FOnActivityLostShenQi != null)
               {
                  this.FOnActivityLostShenQi(this,param3);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_Activity_Wing:
               if(this.FOnActivityWing != null)
               {
                  this.FOnActivityWing(this,param3);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_Activity_Challenge:
               if(this.FOnActivityChallenge != null)
               {
                  this.FOnActivityChallenge(this,param3);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_Activity_Illustrated:
               if(this.FOnActivityIllustrated != null)
               {
                  this.FOnActivityIllustrated(this,param3);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_Activity_Aline:
               if(this.FOnActivityAlien != null)
               {
                  this.FOnActivityAlien(this,param3);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_Activity_KingWar:
               if(this.FOnActivityKingwar != null)
               {
                  this.FOnActivityKingwar(this,param3);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_Activity_Medal:
               if(this.FOnActivityMedal != null)
               {
                  this.FOnActivityMedal(this,param3);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_Activity_InviteCode:
               if(this.FOnActivityinviteCode != null)
               {
                  this.FOnActivityinviteCode(this,param3);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_Activity_WuXing:
               if(this.FOnActivityWuxing != null)
               {
                  this.FOnActivityWuxing(this,param3);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_Activity_GlobalBattle:
               if(this.FOnActivityGlobalBattle != null)
               {
                  this.FOnActivityGlobalBattle(this,param3);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_Activity_Emblem:
               if(this.FOnActivityEmblem != null)
               {
                  this.FOnActivityEmblem(this,param3);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_Activity_WorldMatch:
               if(this.FOnActivityWorldMatch != null)
               {
                  this.FOnActivityWorldMatch(this,param3);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_Activity_SummonBattle:
               if(this.FOnActivitySummonBattle != null)
               {
                  this.FOnActivitySummonBattle(this,param3);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_Activity_NinjaTalent:
               if(this.FOnActivityNinjaTalent != null)
               {
                  this.FOnActivityNinjaTalent(this,param3);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_Activity_ChallengCamp:
               if(this.FOnActivityChallengCamp != null)
               {
                  this.FOnActivityChallengCamp(this,param3);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_Activity_GlobalBoss:
               if(this.FOnActivityGlobalBoss != null)
               {
                  this.FOnActivityGlobalBoss(this,param3);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_Activity_Recruit:
               if(this.FOnActivityRecruit != null)
               {
                  this.FOnActivityRecruit(this,param3);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_Activity_CrossSlave:
               if(this.FOnActivityCrossSlave != null)
               {
                  this.FOnActivityCrossSlave(this,param3);
               }
               else
               {
                  this.Unopened();
               }
         }
         TutorialNextStep(1850 + param2);
      }
      
      protected function ProcessorActiveSpecialOnClick(param1:Object, param2:int, param3:ByteArray = null) : void
      {
         switch(param2)
         {
            case TYPE_Active_Special_CDK:
               if(this.FOnActiveSpecialCDK != null)
               {
                  this.FOnActiveSpecialCDK(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case 1:
               if(this.FOnActiveSpecialDiscord != null)
               {
                  this.FOnActiveSpecialDiscord(this);
               }
               else
               {
                  this.Unopened();
               }
         }
      }
      
      protected function ProcessorNewActiveListOnClick(param1:Object, param2:int) : void
      {
         var _loc3_:int = int(CONST_SHORTCUTS.NEW_ACTIVELIST_TYPE[param2]);
         switch(_loc3_)
         {
            case TYPE_NewActiveList_DragonBoat:
               if(this.FOnNewActiveListDragonBoat != null)
               {
                  this.FOnNewActiveListDragonBoat(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_NewActiveList_DragonBoat2:
               if(this.FOnNewActiveListDragonBoat2 != null)
               {
                  this.FOnNewActiveListDragonBoat2(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_NewActiveList_DragonBoat3:
               if(this.FOnNewActiveListDragonBoat3 != null)
               {
                  this.FOnNewActiveListDragonBoat3(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_NewActiveList_DragonBoat4:
               if(this.FOnNewActiveListDragonBoat4 != null)
               {
                  this.FOnNewActiveListDragonBoat4(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_NewActiveList_DragonBoat5:
               if(this.FOnNewActiveListDragonBoat5 != null)
               {
                  this.FOnNewActiveListDragonBoat5(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_NewActiveList_DragonBoat6:
               if(this.FOnNewActiveListDragonBoat6 != null)
               {
                  this.FOnNewActiveListDragonBoat6(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_NewActiveList_DragonBoat7:
               if(this.FOnNewActiveListDragonBoat7 != null)
               {
                  this.FOnNewActiveListDragonBoat7(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_NewActiveList_ConsumeRank:
               if(this.FOnNewActiveListConsumeRank != null)
               {
                  this.FOnNewActiveListConsumeRank(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_NewActiveList_SeventhEvening:
               if(this.FOnNewActiveListSeventhEvening != null)
               {
                  this.FOnNewActiveListSeventhEvening(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_NewActiveList_RechargeRank:
               if(this.FOnNewActiveListRechargeRank != null)
               {
                  this.FOnNewActiveListRechargeRank(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_NewActiveList_MidAutumn:
               if(this.FOnNewActiveListMidAutumn != null)
               {
                  this.FOnNewActiveListMidAutumn(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_NewActiveList_NationalDay:
               if(this.FOnNewActiveListNationalDay != null)
               {
                  this.FOnNewActiveListNationalDay(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_NewActiveList_Hallowmas:
               if(this.FOnNewActiveListHallowmas != null)
               {
                  this.FOnNewActiveListHallowmas(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_NewActiveList_InviteFriend:
               if(this.FOnNewActiveListInviteFriend != null)
               {
                  this.FOnNewActiveListInviteFriend(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_NewActiveList_WishTree:
               if(this.FOnNewActiveListWishTree != null)
               {
                  this.FOnNewActiveListWishTree(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_NewActiveList_NewYear:
               if(this.FOnNewActiveListNewYear != null)
               {
                  this.FOnNewActiveListNewYear(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_NewActiveList_BlackMarket:
               if(this.FOnNewActiveListBlackMarket != null)
               {
                  this.FOnNewActiveListBlackMarket(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_NewActiveList_NinjaMeeting:
               if(this.FOnNewActiveListNinjaMeeting != null)
               {
                  this.FOnNewActiveListNinjaMeeting(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_NewActiveList_SingleTopUp:
               if(this.FOnNewActiveListSingleTopUp != null)
               {
                  this.FOnNewActiveListSingleTopUp(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_NewActiveList_SuperEquip:
               if(this.FOnNewActiveListSuperEquip != null)
               {
                  this.FOnNewActiveListSuperEquip(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_NewActiveList_PaymentWall:
               if(this.FOnNewActiveListPaymentWall != null)
               {
                  this.FOnNewActiveListPaymentWall(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_NewActiveList_FirstRecharge_new:
               if(this.FOnNewActiveListFirstRecharge_New != null)
               {
                  this.FOnNewActiveListFirstRecharge_New(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_NewActiveList_ComeBack:
               if(this.FOnNewActiveListComeBack != null)
               {
                  this.FOnNewActiveListComeBack(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_NewActiveList_DessertHouse:
               if(this.FOnNewActiveListDessertHouse != null)
               {
                  this.FOnNewActiveListDessertHouse(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_NewActiveList_NewLottery:
               if(this.FOnNewActiveListNewLottery != null)
               {
                  this.FOnNewActiveListNewLottery(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_NewActiveList_FortuneCat:
               if(this.FOnNewActiveListFortuneCat != null)
               {
                  this.FOnNewActiveListFortuneCat(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_NewActiveList_MarchConsume:
               if(this.FOnNewActiveListMarchConsume != null)
               {
                  this.FOnNewActiveListMarchConsume(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_NewActiveList_GoldDigger:
               if(this.FOnNewActiveListGoldDigger != null)
               {
                  this.FOnNewActiveListGoldDigger(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_NewActiveList_PersiaTrader:
               if(this.FOnNewActiveListPersiaTrader != null)
               {
                  this.FOnNewActiveListPersiaTrader(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_NewActiveList_Cornucopia:
               if(this.FOnNewActiveListCornucopia != null)
               {
                  this.FOnNewActiveListCornucopia(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_NewActiveList_AlchemyStudio:
               if(this.FOnNewActiveListAlchemyStudio != null)
               {
                  this.FOnNewActiveListAlchemyStudio(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_NewActiveList_GodWelfare:
               if(this.FOnNewActiveListGodWelfare != null)
               {
                  this.FOnNewActiveListGodWelfare(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_NewActiveList_IdolumFight:
               if(this.FOnNewActiveListIdolumFight != null)
               {
                  this.FOnNewActiveListIdolumFight(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_NewActiveList_Bejeweled:
               if(this.OnNewActiveListBejeweled != null)
               {
                  this.OnNewActiveListBejeweled(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_NewActiveList_Exorcism:
               if(this.OnNewActiveListExorcism != null)
               {
                  this.OnNewActiveListExorcism(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_NewActiveList_NinjaCrystal:
               if(this.OnNewActiveListNinjaCrystal != null)
               {
                  this.OnNewActiveListNinjaCrystal(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_NewActiveList_BossTreasure:
               if(this.OnNewActiveListBossTreasure != null)
               {
                  this.OnNewActiveListBossTreasure(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_NewActiveList_DailyFirstRecharge:
               if(this.OnNewActiveListDailyFirstRecharge != null)
               {
                  this.OnNewActiveListDailyFirstRecharge(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_NewActiveList_SignGift:
               if(this.OnNewActiveListSignGift != null)
               {
                  this.OnNewActiveListSignGift(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_NewActiveList_WanSheng2:
               if(this.OnNewActiveListWanSheng2 != null)
               {
                  this.OnNewActiveListWanSheng2(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_NewActiveList_NinjaFund:
               if(this.OnNewActiveListNinjaFund != null)
               {
                  this.OnNewActiveListNinjaFund(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_NewActiveList_CatWomen:
               if(this.OnNewActiveListCatWomen != null)
               {
                  this.OnNewActiveListCatWomen(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_NewActiveList_LotteryMachine:
               if(this.OnNewActiveListLotteryMachine != null)
               {
                  this.OnNewActiveListLotteryMachine(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_NewActiveList_Double11Mall:
               if(this.OnNewActiveListDouble11Mall != null)
               {
                  this.OnNewActiveListDouble11Mall(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_NewActiveList_LevelGifts:
               if(this.OnNewActiveListLevelGifts != null)
               {
                  this.OnNewActiveListLevelGifts(this);
               }
               else
               {
                  this.Unopened();
               }
         }
      }
      
      protected function ProcessorNewActiveListSecondaryOnClick(param1:Object, param2:int) : void
      {
         var _loc3_:int = int(CONST_SHORTCUTS.NEW_ACTIVELIST_SECONDARY_TYPE[param2]);
         switch(_loc3_)
         {
            case TYPE_NewActiveList_Lottery:
               if(this.FOnNewActiveListLottery != null)
               {
                  this.FOnNewActiveListLottery(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_NewActiveList_SystemActivity:
               if(this.FOnNewActiveListSystemActivity != null)
               {
                  this.FOnNewActiveListSystemActivity(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_NewActiveList_FrogWallet:
               if(this.FOnNewActiveListFrogWallet != null)
               {
                  this.FOnNewActiveListFrogWallet(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_NewActiveList_VipShop:
               if(this.FOnNewActiveListVipShop != null)
               {
                  this.FOnNewActiveListVipShop(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_NewActiveList_Dice:
               if(this.FOnNewActiveListDice != null)
               {
                  this.FOnNewActiveListDice(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_NewActiveList_TenTail:
               if(this.FOnNewActiveListTenTail != null)
               {
                  this.FOnNewActiveListTenTail(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_NewActiveList_VIPFreeBuy:
               if(this.FOnNewActiveListVIPFreeBuy != null)
               {
                  this.FOnNewActiveListVIPFreeBuy(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_NewActiveList_HappyTreasure:
               if(this.FOnNewActiveListHappyTreasure != null)
               {
                  this.FOnNewActiveListHappyTreasure(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_NewActiveList_GroupBuying:
               if(this.FOnNewActiveListGroupBuying != null)
               {
                  this.FOnNewActiveListGroupBuying(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_NewActiveList_RechargeExchange:
               if(this.FOnNewActiveListRechargeExchange != null)
               {
                  this.FOnNewActiveListRechargeExchange(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_NewActiveList_Discount:
               if(this.FOnNewActiveListDiscount != null)
               {
                  this.FOnNewActiveListDiscount(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_NewActiveList_RechargeGive:
               if(this.FOnNewActiveListRechargeGive != null)
               {
                  this.FOnNewActiveListRechargeGive(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_NewActiveList_TreasureBox:
               if(this.FOnNewActiveListTreasureBox != null)
               {
                  this.FOnNewActiveListTreasureBox(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_NewActiveList_GuaGuaLe:
               if(this.FOnNewActiveListGuaGuaLe != null)
               {
                  this.FOnNewActiveListGuaGuaLe(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_NewActiveList_CrossServerSale:
               if(this.FOnNewActiveListCrossServerSale != null)
               {
                  this.FOnNewActiveListCrossServerSale(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_NewActiveList_ActivityA:
               if(this.FOnNewActiveListActivityA != null)
               {
                  this.FOnNewActiveListActivityA(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_NewActiveList_ActivityB:
               if(this.FOnNewActiveListActivityB != null)
               {
                  this.FOnNewActiveListActivityB(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_NewActiveList_MuYeJuJiuWu:
               if(this.FOnNewActiveListMyActive != null)
               {
                  this.FOnNewActiveListMyActive(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_NewActiveList_OneWorthThousand:
               if(this.FOnNewActiveListOneWorthThousand != null)
               {
                  this.FOnNewActiveListOneWorthThousand(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_NewActiveList_TowerLottery:
               if(this.FOnNewActiveListTowerLottery != null)
               {
                  this.FOnNewActiveListTowerLottery(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_NewActiveList_DailyRecharge:
               if(this.FOnNewActiveListDailyRecharge != null)
               {
                  this.FOnNewActiveListDailyRecharge(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_NewActiveList_EverydaySale:
               if(this.FOnNewActiveListEverydaySale != null)
               {
                  this.FOnNewActiveListEverydaySale(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_NewActiveList_CloudBuy:
               if(this.FOnNewActiveListCloudBuy != null)
               {
                  this.FOnNewActiveListCloudBuy(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_NewActiveList_FerrisWheel:
               if(this.FOnNewActiveListFerrisWheel != null)
               {
                  this.FOnNewActiveListFerrisWheel(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_NewActiveList_OrangeEquipment:
               if(this.FOnNewActiveListOrangeEquipment != null)
               {
                  this.FOnNewActiveListOrangeEquipment(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_NewActiveList_NinjaBank:
               if(this.FOnNewActiveListNinjaBank != null)
               {
                  this.FOnNewActiveListNinjaBank(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_NewActiveList_GoldTree:
               if(this.FOnNewActiveListGoldTree != null)
               {
                  this.FOnNewActiveListGoldTree(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_NewActiveList_AncientTreasure:
               if(this.FOnNewActiveListAncientTreasure != null)
               {
                  this.FOnNewActiveListAncientTreasure(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_NewActiveList_CreationAncestor:
               if(this.OnNewActiveListCreationAncestor != null)
               {
                  this.OnNewActiveListCreationAncestor(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_NewActiveList_FateRoulette:
               if(this.OnNewActiveListFateRoulette != null)
               {
                  this.OnNewActiveListFateRoulette(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_NewActiveList_VipTreasure:
               if(this.FOnNewActiveListVipTreasure != null)
               {
                  this.FOnNewActiveListVipTreasure(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_NewActiveList_CapsuleToys:
               if(this.FOnNewActiveListCapsuleToys != null)
               {
                  this.FOnNewActiveListCapsuleToys(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_NewActiveList_LoginGift:
               if(this.OnNewActiveListLoginGift != null)
               {
                  this.OnNewActiveListLoginGift(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_NewActiveList_BindEmail:
               if(this.OnNewActiveListBindEmail != null)
               {
                  this.OnNewActiveListBindEmail(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_NewActiveList_DayRechargeGift:
               if(this.OnNewActiveListDayRechargeGift != null)
               {
                  this.OnNewActiveListDayRechargeGift(this);
               }
               else
               {
                  this.Unopened();
               }
         }
      }
      
      protected function ProcessorActiveListThirdOnClick(param1:Object, param2:int) : void
      {
         var _loc3_:int = int(CONST_SHORTCUTS.ACTIVELIST_THIRD_TYPE[param2]);
         switch(_loc3_)
         {
            case TYPE_ActiveListThird_NinjiaVillage:
               if(this.FOnActiveListThirdNinjiaVillage != null)
               {
                  this.FOnActiveListThirdNinjiaVillage(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_ActiveListThird_Christmas:
               if(this.FOnNewActiveListChristmas != null)
               {
                  this.FOnNewActiveListChristmas(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_ActiveListThird_SpringFestival:
               if(this.FOnNewActiveListSpringFestival != null)
               {
                  this.FOnNewActiveListSpringFestival(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_ActiveListThird_ValentineDay:
               if(this.FOnNewActiveListValentineDay != null)
               {
                  this.FOnNewActiveListValentineDay(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_ActiveListThird_FightBoss:
               if(this.FOnNewActiveListFightBoss != null)
               {
                  this.FOnNewActiveListFightBoss(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_ActiveListThird_BrazilCarnival:
               if(this.FOnNewActiveListBrazilCarnival != null)
               {
                  this.FOnNewActiveListBrazilCarnival(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_ActiveListThird_NinjaTreasure:
               if(this.FOnNewActiveListNinjaTreasure != null)
               {
                  this.FOnNewActiveListNinjaTreasure(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_ActiveListThird_MayActive:
               if(this.FOnNewActiveListMayActive != null)
               {
                  this.FOnNewActiveListMayActive(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_ActiveListThird_JuneActive:
               if(this.FOnNewActiveListJuneActive != null)
               {
                  this.FOnNewActiveListJuneActive(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_ActiveListThird_JulyActive:
               if(this.FOnNewActiveListJulyActive != null)
               {
                  this.FOnNewActiveListJulyActive(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_ActiveListThird_AugustActive:
               if(this.FOnNewActiveListAugustActive != null)
               {
                  this.FOnNewActiveListAugustActive(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_ActiveListThird_SeptemberActive:
               if(this.FOnNewActiveListSeptemberActive != null)
               {
                  this.FOnNewActiveListSeptemberActive(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_ActiveListThird_OctActive:
               if(this.FOnNewActiveListOctActive != null)
               {
                  this.FOnNewActiveListOctActive(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_ActiveListThird_NovActive:
               if(this.FOnNewActiveListNovActive != null)
               {
                  this.FOnNewActiveListNovActive(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_ActiveListThird_DecActive:
               if(this.FOnNewActiveListDecActive != null)
               {
                  this.FOnNewActiveListDecActive(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_ActiveListThird_JanActive:
               if(this.FOnNewActiveListJanActive != null)
               {
                  this.FOnNewActiveListJanActive(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_ActiveListThird_FebActive:
               if(this.FOnNewActiveListFebActive != null)
               {
                  this.FOnNewActiveListFebActive(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_ActiveListThird_MarchActive:
               if(this.FOnNewActiveListMarchActive != null)
               {
                  this.FOnNewActiveListMarchActive(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_ActiveListThird_AprilActive:
               if(this.FOnNewActiveListAprilActive != null)
               {
                  this.FOnNewActiveListAprilActive(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_ActiveListThird_MayActive_2015:
               if(this.FOnNewActiveListMayActive2015 != null)
               {
                  this.FOnNewActiveListMayActive2015(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_ActiveListThird_MoonFestival:
               if(this.OnNewActiveListMoonFestival != null)
               {
                  this.OnNewActiveListMoonFestival(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_ActiveListThird_NationDay_2015:
               if(this.OnNewActiveListNationDay2015 != null)
               {
                  this.OnNewActiveListNationDay2015(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_ActiveListThird_HallowmasActive:
               if(this.OnNewActiveListHallowmasActive != null)
               {
                  this.OnNewActiveListHallowmasActive(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_NewActiveList_WanSheng:
               if(this.OnNewActiveListWanSheng != null)
               {
                  this.OnNewActiveListWanSheng(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_NewActiveList_ThanksgivingDay:
               if(this.OnNewActiveListThanksgivingDay != null)
               {
                  this.OnNewActiveListThanksgivingDay(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_NewActiveList_Nov:
               if(this.OnNewActiveListNov != null)
               {
                  this.OnNewActiveListNov(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_NewActiveList_Christmas2015:
               if(this.OnNewActiveListChristmas2015 != null)
               {
                  this.OnNewActiveListChristmas2015(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_NewActiveList_JanActive2016:
               if(this.OnNewActiveListJanActive2016 != null)
               {
                  this.OnNewActiveListJanActive2016(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_ActiveListThird_Nov2016:
               if(this.OnNewActiveListNov2016 != null)
               {
                  this.OnNewActiveListNov2016(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_ActiveListThird_WitchProving:
               if(this.OnNewActiveListWitchProving != null)
               {
                  this.OnNewActiveListWitchProving(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_NewActiveList_Christmas2016:
               if(this.OnNewActiveListChristmas2016 != null)
               {
                  this.OnNewActiveListChristmas2016(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_NewActiveList_WorldCup:
               if(this.OnNewActiveListWorldCup != null)
               {
                  this.OnNewActiveListWorldCup(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_ActiveListThird_NewSpring2018:
               if(this.OnNewActiveListNewSpring2018 != null)
               {
                  this.OnNewActiveListNewSpring2018(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_ActiveListThird_Smelt:
               if(this.OnNewActiveListSmelt != null)
               {
                  this.OnNewActiveListSmelt(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_ActiveListThird_ChristmasDay:
               if(this.OnNewActiveListChristmasDay != null)
               {
                  this.OnNewActiveListChristmasDay(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_ActiveListThird_LeadLevelGifts:
               if(this.OnNewActiveListLeadLevelGifts != null)
               {
                  this.OnNewActiveListLeadLevelGifts(this);
               }
               else
               {
                  this.Unopened();
               }
         }
      }
      
      protected function ProcessorActiveListOnClick(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case TYPE_ActiveList_RechageCashBack:
               if(this.FOnActiveListFirstRechageCashBack != null)
               {
                  this.FOnActiveListFirstRechageCashBack(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_ActiveList_FirstRecharge:
               if(this.FOnActiveListFirstRecharge != null)
               {
                  this.FOnActiveListFirstRecharge(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_ActiveList_Recharge:
               if(this.FOnActiveListRecharge != null)
               {
                  this.FOnActiveListRecharge(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_ActiveList_Wonderful:
               if(this.FOnActiveListWonderful != null)
               {
                  this.FOnActiveListWonderful(this);
               }
               else
               {
                  this.Unopened();
               }
         }
      }
      
      protected function ProcessorActiveListSecondaryOnClick(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case TYPE_ActiveListSecondary_FirstDayGiftBag:
               if(this.FOnActiveListSecondaryFirstDayGiftBag != null)
               {
                  this.FOnActiveListSecondaryFirstDayGiftBag(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_ActiveListSecondary_OnLineGiftBag:
               if(this.FOnActiveListSecondaryOnLineGiftBag != null)
               {
                  this.FOnActiveListSecondaryOnLineGiftBag(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_ActiveListSecondary_GoldGiftBag:
               if(this.FOnActiveListSecondaryGoldGiftBag != null)
               {
                  this.FOnActiveListSecondaryGoldGiftBag(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_ActiveListSecondary_7DayGiftBag:
               if(this.FOnActiveListSecondary7DayGiftBag != null)
               {
                  this.FOnActiveListSecondary7DayGiftBag(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_ActiveListSecondary_HFReward:
               if(this.FOnActiveListSecondaryHFReward != null)
               {
                  this.FOnActiveListSecondaryHFReward(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_ActiveListSecondary_LevelGift:
               if(this.FOnActiveListSecondaryLevelGift != null)
               {
                  this.FOnActiveListSecondaryLevelGift(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_ActiveListSecondary_CollectGame:
               if(this.FOnActiveListSecondaryCollectGame != null)
               {
                  this.FOnActiveListSecondaryCollectGame(this);
               }
               else
               {
                  this.Unopened();
               }
         }
      }
      
      protected function ProcessorMainFunctionOnClick(param1:Object, param2:int, param3:int = 0, param4:Object = null) : void
      {
         this.FStreamParameter.length = 0;
         this.FStreamParameter.writeUnsignedInt(param3);
         this.FStreamParameter.position = 0;
         switch(param2)
         {
            case TYPE_Function_Heros:
               if(this.FOnHeros != null)
               {
                  this.FOnHeros(this,this.FStreamParameter);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_Function_Star:
               if(this.FOnGeneralStar != null)
               {
                  this.FOnGeneralStar(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_Function_TacticalDeployment:
               if(this.FOnTacticalDeployment != null)
               {
                  this.FOnTacticalDeployment(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_Function_Backpack:
               if(this.FOnBackpack != null)
               {
                  this.FOnBackpack(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_Function_Treasure:
               if(this.FOnTreasure != null)
               {
                  this.FOnTreasure(this,this.FStreamParameter);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_Function_SummonPet:
               if(this.FOnSummonPet != null)
               {
                  this.FOnSummonPet(this,this.FStreamParameter);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_Function_Strengthen:
               if(this.FOnStrengthen != null)
               {
                  this.FOnStrengthen(this,this.FStreamParameter);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_Function_Mail:
               if(this.FOnMail != null)
               {
                  this.FOnMail(this,this.FStreamParameter);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_Function_TongLing:
               if(this.FOnTongLing != null)
               {
                  this.FOnTongLing(this,this.FStreamParameter);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_Function_OrganiZation:
               if(this.FOnOrganiZation != null)
               {
                  this.FOnOrganiZation(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_Function_InheritPractice:
               if(this.FOnInheritPractice != null)
               {
                  this.FOnInheritPractice(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case TYPE_Function_Return:
               if(this.FOnReturn != null)
               {
                  this.FOnReturn(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            case 99:
               if(this.OnHomeland != null)
               {
                  this.OnHomeland(this);
               }
               else
               {
                  this.Unopened();
               }
               break;
            default:
               this.Unopened();
         }
         TutorialNextStep(1800 + param2);
      }
      
      protected function ProcessorWorldMapOnClick(param1:Object) : void
      {
         if(this.FOnEnterWorldMap != null)
         {
            this.FOnEnterWorldMap(param1);
         }
      }
      
      protected function ProcessorReturnHomeOnClick(param1:Object) : void
      {
         if(this.FOnEnterCity != null)
         {
            this.FOnEnterCity(param1);
         }
      }
      
      protected function ProcessorViewRaidersOnClick(param1:Object) : void
      {
         this.Unopened();
         if(this.FOnViewRaiders != null)
         {
            this.FOnViewRaiders(param1);
         }
      }
      
      protected function ProcessorMapOnMail(param1:Object) : void
      {
         if(this.FOnMail != null)
         {
            this.FOnMail(param1);
         }
      }
      
      protected function ProcessorMapOnQuest(param1:Object) : void
      {
         if(this.FOnQuest != null)
         {
            this.FOnQuest(param1);
         }
      }
      
      protected function ProcessorMapOnFriend(param1:Object) : void
      {
         if(this.FOnFriend != null)
         {
            this.FOnFriend(param1);
         }
      }
      
      protected function ProcessorMapOnSwitchDisplay(param1:Object, param2:Boolean) : void
      {
         if(this.FOnSwitchDisplay != null)
         {
            this.FOnSwitchDisplay(param1,param2);
         }
      }
      
      protected function ProcessorMapOnAutoBattle(param1:Object, param2:Boolean, param3:Boolean, param4:Boolean) : void
      {
         if(this.FOnAutoBattle != null)
         {
            this.FOnAutoBattle(param1,param2,param3,param4);
         }
      }
      
      protected function ProcessorMapOnZeroReq(param1:Object) : void
      {
         if(this.FOnZeroReq != null)
         {
            this.FOnZeroReq(param1);
         }
      }
      
      protected function ProcessornAdditionalOnClick(param1:Object, param2:uint, param3:Object) : void
      {
         switch(param2)
         {
            case TYPE_Additional_Tavern:
               if(this.FOnAdditionalTavern != null)
               {
                  this.FOnAdditionalTavern(this);
               }
               break;
            case TYPE_Additional_Jade:
               if(this.FOnAdditionalJade != null)
               {
                  this.FOnAdditionalJade(this);
               }
               break;
            case TYPE_Additional_MakeEquip:
               if(this.FOnAdditionalMakeEquip != null)
               {
                  this.FOnAdditionalMakeEquip(this);
               }
               break;
            case TYPE_Additional_MakeEquipAdvanced:
               if(this.FOnAdditionalMakeEquipAdvanced != null)
               {
                  this.FOnAdditionalMakeEquipAdvanced(this,param3);
               }
               break;
            case TYPE_Additional_MuyeGuard:
               if(this.FOnAdditionalMuyeGuard != null)
               {
                  this.FOnAdditionalMuyeGuard(this);
               }
               break;
            case TYPE_Additional_PetBattle:
               if(this.FOnAdditionalPetBattle != null)
               {
                  this.FOnAdditionalPetBattle(this,uint(param3));
               }
               break;
            case TYPE_Additional_MuyeBattle:
               if(this.FOnAdditionalMuyeBattle != null)
               {
                  this.FOnAdditionalMuyeBattle(this);
               }
               break;
            case TYPE_Additional_TraitorAttack:
               if(this.FOnAdditionalTraitorAttack != null)
               {
                  this.FOnAdditionalTraitorAttack(this);
               }
               break;
            case TYPE_Additional_Accessory:
               if(this.FOnAdditionalAccessoryIntensity != null)
               {
                  this.FOnAdditionalAccessoryIntensity(this,param3);
               }
         }
      }
      
      protected function ProcessorOnUnlockResponse(param1:Object, param2:TBounds, param3:Object) : void
      {
         if(this.FOnUnlockResponse != null)
         {
            this.FOnUnlockResponse(param1,param2,param3);
         }
      }
      
      protected function ProcessorBigDipperOnClick(param1:Object, param2:int) : void
      {
         if(this.FOnConstantlyBigDipper != null)
         {
            this.FOnConstantlyBigDipper(this);
         }
      }
      
      protected function ProcessorConstantlyOnClick(param1:Object, param2:int, param3:uint) : void
      {
         switch(param2)
         {
            case TYPE_Function_Strengthen:
               this.ProcessorMainFunctionOnClick(param1,param2,param3);
               break;
            case TYPE_Activity_Arena:
               this.ProcessorActivityOnClick(param1,param2);
               break;
            case TYPE_Activity_Slave:
               this.ProcessorActivityOnClick(param1,param2);
               break;
            case TYPE_Function_TongLing:
               this.ProcessorMainFunctionOnClick(param1,param2,param3);
         }
      }
      
      protected function ProcessorHeroInforOnClick(param1:Object, param2:String, param3:TDigest, param4:TFriendDigest) : void
      {
         switch(param2)
         {
            case STRING_SHORTCUTS.Command_LookInfor:
               if(this.FShowOtherHeroInfor != null)
               {
                  this.FShowOtherHeroInfor(this,param3.Identifier0,param3.Identifier1);
               }
               break;
            case STRING_SHORTCUTS.Command_StartChat:
               if(this.FRequestWhisper != null)
               {
                  this.FRequestWhisper(this,param3.Identifier0,param3.Identifier1,param3.Name);
               }
               break;
            case STRING_SHORTCUTS.Command_SendEmail:
               if(this.FRequestSendMail != null)
               {
                  this.FRequestSendMail(this,param3);
               }
               break;
            case STRING_SHORTCUTS.Command_JoinFriend:
               if(this.FRequestAddFriend != null)
               {
                  this.FRequestAddFriend(this,TYPE_Whitelist_Add,param4);
               }
         }
      }
      
      protected function ProcessorEffectGenerateTextOnClick(param1:Object, param2:TEffectTextParameters = null) : void
      {
         EffectGenerateText(param1 as String,param2);
      }
      
      protected function ProcessorOnPromote(param1:Object, param2:uint = 20) : void
      {
         var _loc3_:String = null;
         if(SLogicsCore.Character.GetMainLevel() >= param2)
         {
            if(this.FOnPromote != null)
            {
               this.FOnPromote(this);
            }
         }
         else
         {
            _loc3_ = STRING_SHORTCUTS.STRING_UnLockLevel;
            _loc3_ = _loc3_.split("%count%").join(param2);
            EffectGenerateText(_loc3_);
         }
      }
      
      protected function ProcessorEnterAutoBattle(param1:Object) : void
      {
         if(this.FOnEnterAutoBattle != null)
         {
            this.FOnEnterAutoBattle(this);
         }
      }
      
      protected function ProcessorWelfareOnClick(param1:Object, param2:uint) : void
      {
         if(this.FWelfareOnClick != null)
         {
            this.FWelfareOnClick(this);
         }
      }
      
      protected function ProcessorObligatoryCoursesOnClick(param1:Object) : void
      {
         if(this.FObligatoryCoursesOnClick != null)
         {
            this.FObligatoryCoursesOnClick(this);
         }
      }
      
      protected function ProcessorBaiDuMeimeiOnClick(param1:Object) : void
      {
         if(this.FBaiDuMeimeiOnClick != null)
         {
            this.FBaiDuMeimeiOnClick(this);
         }
      }
      
      protected function ProcessorOhtsutsukiKaguyaOnClick(param1:Object) : void
      {
         if(this.FOhtsutsukiKaguyaOnClick != null)
         {
            this.FOhtsutsukiKaguyaOnClick(this);
         }
      }
      
      protected function ProcessorVkClickOnClick() : void
      {
         if(this.FOhtsutsuVkOnClick != null)
         {
            this.FOhtsutsuVkOnClick();
         }
      }
      
      protected function ProcessorMC1377OnClick() : void
      {
         if(this.FMC1377OnClick != null)
         {
            this.FMC1377OnClick();
         }
      }
      
      protected function ProcessorAccountLockOnClick() : void
      {
         if(this.AccountLockOnClick != null)
         {
            this.AccountLockOnClick();
         }
      }
      
      protected function ProcessorRankIconClick() : void
      {
         if(this.RankIconClick != null)
         {
            this.RankIconClick(this);
         }
      }
      
      protected function ProcessorVipWelfareOnClick() : void
      {
         if(this.OnVipWelfareClick != null)
         {
            this.OnVipWelfareClick();
         }
      }
      
      protected function ProcessorMicrologinClick() : void
      {
         if(this.OnMicrologin != null)
         {
            this.OnMicrologin();
         }
      }
      
      protected function ProcessorConsumeVIPOnClick() : void
      {
         if(this.OnConsumeVip != null)
         {
            this.OnConsumeVip();
         }
      }
      
      public function set OnAvaterHead(param1:Function) : void
      {
         this.FOnAvaterHead = param1;
      }
      
      public function get OnAvaterHead() : Function
      {
         return this.FOnAvaterHead;
      }
      
      public function get OnVip() : Function
      {
         return this.FOnVip;
      }
      
      public function set OnVip(param1:Function) : void
      {
         this.FOnVip = param1;
      }
      
      public function get OnEnterAutoBattle() : Function
      {
         return this.FOnEnterAutoBattle;
      }
      
      public function set OnEnterAutoBattle(param1:Function) : void
      {
         this.FOnEnterAutoBattle = param1;
      }
      
      public function get OnActivitySubmitBug() : Function
      {
         return this.FOnActivitySubmitBug;
      }
      
      public function set OnActivitySubmitBug(param1:Function) : void
      {
         this.FOnActivitySubmitBug = param1;
      }
      
      public function get OnActivityArena() : Function
      {
         return this.FOnActivityArena;
      }
      
      public function set OnActivityArena(param1:Function) : void
      {
         this.FOnActivityArena = param1;
      }
      
      public function get OnActivityKillHeros() : Function
      {
         return this.FOnActivityKillHeros;
      }
      
      public function set OnActivityKillHeros(param1:Function) : void
      {
         this.FOnActivityKillHeros = param1;
      }
      
      public function get OnActivitySign() : Function
      {
         return this.FOnActivitySign;
      }
      
      public function set OnActivitySign(param1:Function) : void
      {
         this.FOnActivitySign = param1;
      }
      
      public function get OnActivityCopyHero() : Function
      {
         return this.FOnActivityCopyHero;
      }
      
      public function set OnActivityCopyHero(param1:Function) : void
      {
         this.FOnActivityCopyHero = param1;
      }
      
      public function get OnActivityTreasureMap() : Function
      {
         return this.FOnActivityTreasureMap;
      }
      
      public function set OnActivityTreasureMap(param1:Function) : void
      {
         this.FOnActivityTreasureMap = param1;
      }
      
      public function get OnActivitySuperHero() : Function
      {
         return this.FOnActivitySuperHero;
      }
      
      public function set OnActivitySuperHero(param1:Function) : void
      {
         this.FOnActivitySuperHero = param1;
      }
      
      public function get OnActivityMall() : Function
      {
         return this.FOnActivityMall;
      }
      
      public function set OnActivityMall(param1:Function) : void
      {
         this.FOnActivityMall = param1;
      }
      
      public function get OnActivityDailyQuest() : Function
      {
         return this.FOnActivityDailyQuest;
      }
      
      public function set OnActivityDailyQuest(param1:Function) : void
      {
         this.FOnActivityDailyQuest = param1;
      }
      
      public function get OnActivityDailyActivity() : Function
      {
         return this.FOnActivityDailyActivity;
      }
      
      public function set OnActivityDailyActivity(param1:Function) : void
      {
         this.FOnActivityDailyActivity = param1;
      }
      
      public function get OnActivityNarutoRoad() : Function
      {
         return this.FOnActivityNarutoRoad;
      }
      
      public function set OnActivityNarutoRoad(param1:Function) : void
      {
         this.FOnActivityNarutoRoad = param1;
      }
      
      public function get OnActivitySlave() : Function
      {
         return this.FOnActivitySlave;
      }
      
      public function set OnActivitySlave(param1:Function) : void
      {
         this.FOnActivitySlave = param1;
      }
      
      public function get OnActivitySevenKing() : Function
      {
         return this.FOnActivitySevenKing;
      }
      
      public function set OnActivitySevenKing(param1:Function) : void
      {
         this.FOnActivitySevenKing = param1;
      }
      
      public function get OnActivityCrossServerWar() : Function
      {
         return this.FOnActivityCrossServerWar;
      }
      
      public function set OnActivityCrossServerWar(param1:Function) : void
      {
         this.FOnActivityCrossServerWar = param1;
      }
      
      public function get OnActivityMagic() : Function
      {
         return this.FOnActivityMagic;
      }
      
      public function set OnActivityMagic(param1:Function) : void
      {
         this.FOnActivityMagic = param1;
      }
      
      public function get OnActivityMoutain() : Function
      {
         return this.FOnActivityMoutain;
      }
      
      public function set OnActivityMoutain(param1:Function) : void
      {
         this.FOnActivityMoutain = param1;
      }
      
      public function get OnActivityTower() : Function
      {
         return this.FOnActivityTower;
      }
      
      public function set OnActivityTower(param1:Function) : void
      {
         this.FOnActivityTower = param1;
      }
      
      public function get OnActivityDailyWelfare() : Function
      {
         return this.FOnActivityDailyWelfare;
      }
      
      public function set OnActivityDailyWelfare(param1:Function) : void
      {
         this.FOnActivityDailyWelfare = param1;
      }
      
      public function get OnActivityChoose() : Function
      {
         return this.FOnActivityChoose;
      }
      
      public function set OnActivityChoose(param1:Function) : void
      {
         this.FOnActivityChoose = param1;
      }
      
      public function get OnActivityPalace() : Function
      {
         return this.FOnActivityPalace;
      }
      
      public function set OnActivityPalace(param1:Function) : void
      {
         this.FOnActivityPalace = param1;
      }
      
      public function get OnActivityNijiaStar() : Function
      {
         return this.FOnActivityNijiaStar;
      }
      
      public function set OnActivityNijiaStar(param1:Function) : void
      {
         this.FOnActivityNijiaStar = param1;
      }
      
      public function get OnActivityRamen() : Function
      {
         return this.FOnActivityRamen;
      }
      
      public function set OnActivityRamen(param1:Function) : void
      {
         this.FOnActivityRamen = param1;
      }
      
      public function get OnActivityTopOrganization() : Function
      {
         return this.FOnActivityTopOrganization;
      }
      
      public function set OnActivityTopOrganization(param1:Function) : void
      {
         this.FOnActivityTopOrganization = param1;
      }
      
      public function get OnActivityGroupBattle() : Function
      {
         return this.FOnActivityGroupBattle;
      }
      
      public function set OnActivityGroupBattle(param1:Function) : void
      {
         this.FOnActivityGroupBattle = param1;
      }
      
      public function get OnActivityLaboratory() : Function
      {
         return this.FOnActivityLaboratory;
      }
      
      public function set OnActivityLaboratory(param1:Function) : void
      {
         this.FOnActivityLaboratory = param1;
      }
      
      public function get OnActivitySixFairy() : Function
      {
         return this.FOnActivitySixFairy;
      }
      
      public function set OnActivitySixFairy(param1:Function) : void
      {
         this.FOnActivitySixFairy = param1;
      }
      
      public function get OnActivityRebirthRealm() : Function
      {
         return this.FOnActivityRebirthRealm;
      }
      
      public function set OnActivityRebirthRealm(param1:Function) : void
      {
         this.FOnActivityRebirthRealm = param1;
      }
      
      public function get OnActivityTopTeam() : Function
      {
         return this.FOnActivityTopTeam;
      }
      
      public function set OnActivityTopTeam(param1:Function) : void
      {
         this.FOnActivityTopTeam = param1;
      }
      
      public function get OnActivityNijiaMystic() : Function
      {
         return this.FOnActivityNijiaMystic;
      }
      
      public function set OnActivityNijiaMystic(param1:Function) : void
      {
         this.FOnActivityNijiaMystic = param1;
      }
      
      public function get OnActiveSpecialCDK() : Function
      {
         return this.FOnActiveSpecialCDK;
      }
      
      public function set OnActiveSpecialCDK(param1:Function) : void
      {
         this.FOnActiveSpecialCDK = param1;
      }
      
      public function get OnActiveSpecialDiscord() : Function
      {
         return this.FOnActiveSpecialDiscord;
      }
      
      public function set OnActiveSpecialDiscord(param1:Function) : void
      {
         this.FOnActiveSpecialDiscord = param1;
      }
      
      public function get OnActiveListFirstRechageCashBack() : Function
      {
         return this.FOnActiveListFirstRechageCashBack;
      }
      
      public function set OnActiveListFirstRechageCashBack(param1:Function) : void
      {
         this.FOnActiveListFirstRechageCashBack = param1;
      }
      
      public function get OnActiveListFirstRecharge() : Function
      {
         return this.FOnActiveListFirstRecharge;
      }
      
      public function set OnActiveListFirstRecharge(param1:Function) : void
      {
         this.FOnActiveListFirstRecharge = param1;
      }
      
      public function get OnActiveListRecharge() : Function
      {
         return this.FOnActiveListRecharge;
      }
      
      public function set OnActiveListRecharge(param1:Function) : void
      {
         this.FOnActiveListRecharge = param1;
      }
      
      public function get OnActiveListWonderful() : Function
      {
         return this.FOnActiveListWonderful;
      }
      
      public function set OnActiveListWonderful(param1:Function) : void
      {
         this.FOnActiveListWonderful = param1;
      }
      
      public function get OnActiveListReceivePacks() : Function
      {
         return this.FOnActiveListReceivePacks;
      }
      
      public function set OnActiveListReceivePacks(param1:Function) : void
      {
         this.FOnActiveListReceivePacks = param1;
      }
      
      public function get OnActiveListSecondaryFirstDayGiftBag() : Function
      {
         return this.FOnActiveListSecondaryFirstDayGiftBag;
      }
      
      public function set OnActiveListSecondaryFirstDayGiftBag(param1:Function) : void
      {
         this.FOnActiveListSecondaryFirstDayGiftBag = param1;
      }
      
      public function get OnActiveListSecondaryOnLineGiftBag() : Function
      {
         return this.FOnActiveListSecondaryOnLineGiftBag;
      }
      
      public function set OnActiveListSecondaryOnLineGiftBag(param1:Function) : void
      {
         this.FOnActiveListSecondaryOnLineGiftBag = param1;
      }
      
      public function get OnActiveListSecondaryGoldGiftBag() : Function
      {
         return this.FOnActiveListSecondaryGoldGiftBag;
      }
      
      public function set OnActiveListSecondaryGoldGiftBag(param1:Function) : void
      {
         this.FOnActiveListSecondaryGoldGiftBag = param1;
      }
      
      public function get OnActiveListSecondary7DayGiftBag() : Function
      {
         return this.FOnActiveListSecondary7DayGiftBag;
      }
      
      public function set OnActiveListSecondary7DayGiftBag(param1:Function) : void
      {
         this.FOnActiveListSecondary7DayGiftBag = param1;
      }
      
      public function get OnActiveListSecondaryHFReward() : Function
      {
         return this.FOnActiveListSecondaryHFReward;
      }
      
      public function set OnActiveListSecondaryHFReward(param1:Function) : void
      {
         this.FOnActiveListSecondaryHFReward = param1;
      }
      
      public function get OnActiveListSecondaryLevelGift() : Function
      {
         return this.FOnActiveListSecondaryLevelGift;
      }
      
      public function set OnActiveListSecondaryLevelGift(param1:Function) : void
      {
         this.FOnActiveListSecondaryLevelGift = param1;
      }
      
      public function get OnActiveListSecondaryCollectGame() : Function
      {
         return this.FOnActiveListSecondaryCollectGame;
      }
      
      public function set OnActiveListSecondaryCollectGame(param1:Function) : void
      {
         this.FOnActiveListSecondaryCollectGame = param1;
      }
      
      public function get OnHeros() : Function
      {
         return this.FOnHeros;
      }
      
      public function set OnHeros(param1:Function) : void
      {
         this.FOnHeros = param1;
      }
      
      public function get OnGeneralStar() : Function
      {
         return this.FOnGeneralStar;
      }
      
      public function set OnGeneralStar(param1:Function) : void
      {
         this.FOnGeneralStar = param1;
      }
      
      public function get OnTacticalDeployment() : Function
      {
         return this.FOnTacticalDeployment;
      }
      
      public function set OnTacticalDeployment(param1:Function) : void
      {
         this.FOnTacticalDeployment = param1;
      }
      
      public function get OnInheritPractice() : Function
      {
         return this.FOnInheritPractice;
      }
      
      public function set OnInheritPractice(param1:Function) : void
      {
         this.FOnInheritPractice = param1;
      }
      
      public function get OnBackpack() : Function
      {
         return this.FOnBackpack;
      }
      
      public function set OnBackpack(param1:Function) : void
      {
         this.FOnBackpack = param1;
      }
      
      public function get OnTreasure() : Function
      {
         return this.FOnTreasure;
      }
      
      public function set OnTreasure(param1:Function) : void
      {
         this.FOnTreasure = param1;
      }
      
      public function get OnSummonPet() : Function
      {
         return this.FOnSummonPet;
      }
      
      public function set OnSummonPet(param1:Function) : void
      {
         this.FOnSummonPet = param1;
      }
      
      public function get OnStrengthen() : Function
      {
         return this.FOnStrengthen;
      }
      
      public function set OnStrengthen(param1:Function) : void
      {
         this.FOnStrengthen = param1;
      }
      
      public function get OnTongLing() : Function
      {
         return this.FOnTongLing;
      }
      
      public function set OnTongLing(param1:Function) : void
      {
         this.FOnTongLing = param1;
      }
      
      public function get OnOrganiZation() : Function
      {
         return this.FOnOrganiZation;
      }
      
      public function set OnOrganiZation(param1:Function) : void
      {
         this.FOnOrganiZation = param1;
      }
      
      public function get OnReturn() : Function
      {
         return this.FOnReturn;
      }
      
      public function set OnReturn(param1:Function) : void
      {
         this.FOnReturn = param1;
      }
      
      public function get OnHomeland() : Function
      {
         return this.FHomeland;
      }
      
      public function set OnHomeland(param1:Function) : void
      {
         this.FHomeland = param1;
      }
      
      public function get OnConstantlyBigDipper() : Function
      {
         return this.FOnConstantlyBigDipper;
      }
      
      public function set OnConstantlyBigDipper(param1:Function) : void
      {
         this.FOnConstantlyBigDipper = param1;
      }
      
      public function get WindowQuest() : TWindowQuestGuide
      {
         return this.FWindowQuest;
      }
      
      public function get OnEnterWorldMap() : Function
      {
         return this.FOnEnterWorldMap;
      }
      
      public function set OnEnterWorldMap(param1:Function) : void
      {
         this.FOnEnterWorldMap = param1;
      }
      
      public function get OnEnterCity() : Function
      {
         return this.FOnEnterCity;
      }
      
      public function set OnEnterCity(param1:Function) : void
      {
         this.FOnEnterCity = param1;
      }
      
      public function get OnViewRaiders() : Function
      {
         return this.FOnViewRaiders;
      }
      
      public function set OnViewRaiders(param1:Function) : void
      {
         this.FOnViewRaiders = param1;
      }
      
      public function get OnMail() : Function
      {
         return this.FOnMail;
      }
      
      public function set OnMail(param1:Function) : void
      {
         this.FOnMail = param1;
      }
      
      public function get OnQuest() : Function
      {
         return this.FOnQuest;
      }
      
      public function set OnQuest(param1:Function) : void
      {
         this.FOnQuest = param1;
      }
      
      public function get OnFriend() : Function
      {
         return this.FOnFriend;
      }
      
      public function set OnFriend(param1:Function) : void
      {
         this.FOnFriend = param1;
      }
      
      public function get OnSwitchDisplay() : Function
      {
         return this.FOnSwitchDisplay;
      }
      
      public function set OnSwitchDisplay(param1:Function) : void
      {
         this.FOnSwitchDisplay = param1;
      }
      
      public function get OnAutoBattle() : Function
      {
         return this.FOnAutoBattle;
      }
      
      public function set OnAutoBattle(param1:Function) : void
      {
         this.FOnAutoBattle = param1;
      }
      
      public function get OnZeroReq() : Function
      {
         return this.FOnZeroReq;
      }
      
      public function set OnZeroReq(param1:Function) : void
      {
         this.FOnZeroReq = param1;
      }
      
      public function get WindowFunction() : TWindowFunction
      {
         return this.FWindowFunction;
      }
      
      public function get OnAdditionalTavern() : Function
      {
         return this.FOnAdditionalTavern;
      }
      
      public function set OnAdditionalTavern(param1:Function) : void
      {
         this.FOnAdditionalTavern = param1;
      }
      
      public function get OnAdditionalJade() : Function
      {
         return this.FOnAdditionalJade;
      }
      
      public function set OnAdditionalJade(param1:Function) : void
      {
         this.FOnAdditionalJade = param1;
      }
      
      public function get OnAdditionalMakeEquip() : Function
      {
         return this.FOnAdditionalMakeEquip;
      }
      
      public function set OnAdditionalMakeEquip(param1:Function) : void
      {
         this.FOnAdditionalMakeEquip = param1;
      }
      
      public function get OnAdditionalAccessoryIntensity() : Function
      {
         return this.FOnAdditionalAccessoryIntensity;
      }
      
      public function set OnAdditionalAccessoryIntensity(param1:Function) : void
      {
         this.FOnAdditionalAccessoryIntensity = param1;
      }
      
      public function get OnAdditionalMakeEquipAdvanced() : Function
      {
         return this.FOnAdditionalMakeEquipAdvanced;
      }
      
      public function set OnAdditionalMakeEquipAdvanced(param1:Function) : void
      {
         this.FOnAdditionalMakeEquipAdvanced = param1;
      }
      
      public function get OnUnlockResponse() : Function
      {
         return this.FOnUnlockResponse;
      }
      
      public function set OnUnlockResponse(param1:Function) : void
      {
         this.FOnUnlockResponse = param1;
      }
      
      public function get OnPromote() : Function
      {
         return this.FOnPromote;
      }
      
      public function set OnPromote(param1:Function) : void
      {
         this.FOnPromote = param1;
      }
      
      public function get OnAdditionalMuyeGuard() : Function
      {
         return this.FOnAdditionalMuyeGuard;
      }
      
      public function set OnAdditionalMuyeGuard(param1:Function) : void
      {
         this.FOnAdditionalMuyeGuard = param1;
      }
      
      public function get OnAdditionalPetBattle() : Function
      {
         return this.FOnAdditionalPetBattle;
      }
      
      public function set OnAdditionalPetBattle(param1:Function) : void
      {
         this.FOnAdditionalPetBattle = param1;
      }
      
      public function get OnAdditionalMuyeBattle() : Function
      {
         return this.FOnAdditionalMuyeBattle;
      }
      
      public function set OnAdditionalMuyeBattle(param1:Function) : void
      {
         this.FOnAdditionalMuyeBattle = param1;
      }
      
      public function get OnAdditionalTraitorAttack() : Function
      {
         return this.FOnAdditionalTraitorAttack;
      }
      
      public function set OnAdditionalTraitorAttack(param1:Function) : void
      {
         this.FOnAdditionalTraitorAttack = param1;
      }
      
      public function set ShowOtherHeroInfor(param1:Function) : void
      {
         this.FShowOtherHeroInfor = param1;
      }
      
      public function set RequestWhisper(param1:Function) : void
      {
         this.FRequestWhisper = param1;
      }
      
      public function set RequestAddFriend(param1:Function) : void
      {
         this.FRequestAddFriend = param1;
      }
      
      public function set RequestSendMail(param1:Function) : void
      {
         this.FRequestSendMail = param1;
      }
      
      public function get OnNewActiveListLottery() : Function
      {
         return this.FOnNewActiveListLottery;
      }
      
      public function set OnNewActiveListLottery(param1:Function) : void
      {
         this.FOnNewActiveListLottery = param1;
      }
      
      public function get OnNewActiveListSystemActivity() : Function
      {
         return this.FOnNewActiveListSystemActivity;
      }
      
      public function set OnNewActiveListSystemActivity(param1:Function) : void
      {
         this.FOnNewActiveListSystemActivity = param1;
      }
      
      public function get OnNewActiveListDragonBoat() : Function
      {
         return this.FOnNewActiveListDragonBoat;
      }
      
      public function set OnNewActiveListDragonBoat(param1:Function) : void
      {
         this.FOnNewActiveListDragonBoat = param1;
      }
      
      public function get OnNewActiveListDragonBoat2() : Function
      {
         return this.FOnNewActiveListDragonBoat2;
      }
      
      public function set OnNewActiveListDragonBoat2(param1:Function) : void
      {
         this.FOnNewActiveListDragonBoat2 = param1;
      }
      
      public function get OnNewActiveListDragonBoat3() : Function
      {
         return this.FOnNewActiveListDragonBoat3;
      }
      
      public function set OnNewActiveListDragonBoat3(param1:Function) : void
      {
         this.FOnNewActiveListDragonBoat3 = param1;
      }
      
      public function get OnNewActiveListDragonBoat4() : Function
      {
         return this.FOnNewActiveListDragonBoat4;
      }
      
      public function set OnNewActiveListDragonBoat4(param1:Function) : void
      {
         this.FOnNewActiveListDragonBoat4 = param1;
      }
      
      public function get OnNewActiveListDragonBoat5() : Function
      {
         return this.FOnNewActiveListDragonBoat5;
      }
      
      public function set OnNewActiveListDragonBoat5(param1:Function) : void
      {
         this.FOnNewActiveListDragonBoat5 = param1;
      }
      
      public function get OnNewActiveListDragonBoat6() : Function
      {
         return this.FOnNewActiveListDragonBoat6;
      }
      
      public function set OnNewActiveListDragonBoat6(param1:Function) : void
      {
         this.FOnNewActiveListDragonBoat6 = param1;
      }
      
      public function get OnNewActiveListDragonBoat7() : Function
      {
         return this.FOnNewActiveListDragonBoat7;
      }
      
      public function set OnNewActiveListDragonBoat7(param1:Function) : void
      {
         this.FOnNewActiveListDragonBoat7 = param1;
      }
      
      public function set OnNewActiveListTenTail(param1:Function) : void
      {
         this.FOnNewActiveListTenTail = param1;
      }
      
      public function get OnNewActiveListTenTail() : Function
      {
         return this.FOnNewActiveListTenTail;
      }
      
      public function get OnConstantlyMentorship() : Function
      {
         return this.FOnConstantlyMentorship;
      }
      
      public function set OnConstantlyMentorship(param1:Function) : void
      {
         this.FOnConstantlyMentorship = param1;
      }
      
      public function get OnNewActiveListFrogWallet() : Function
      {
         return this.FOnNewActiveListFrogWallet;
      }
      
      public function set OnNewActiveListFrogWallet(param1:Function) : void
      {
         this.FOnNewActiveListFrogWallet = param1;
      }
      
      public function get OnNewActiveListVipShop() : Function
      {
         return this.FOnNewActiveListVipShop;
      }
      
      public function set OnNewActiveListVipShop(param1:Function) : void
      {
         this.FOnNewActiveListVipShop = param1;
      }
      
      public function get OnNewActiveListDice() : Function
      {
         return this.FOnNewActiveListDice;
      }
      
      public function set OnNewActiveListDice(param1:Function) : void
      {
         this.FOnNewActiveListDice = param1;
      }
      
      public function get OnNewActiveListConsumeRank() : Function
      {
         return this.FOnNewActiveListConsumeRank;
      }
      
      public function set OnNewActiveListConsumeRank(param1:Function) : void
      {
         this.FOnNewActiveListConsumeRank = param1;
      }
      
      public function get OnNewActiveListVIPFreeBuy() : Function
      {
         return this.FOnNewActiveListVIPFreeBuy;
      }
      
      public function set OnNewActiveListVIPFreeBuy(param1:Function) : void
      {
         this.FOnNewActiveListVIPFreeBuy = param1;
      }
      
      public function get OnNewActiveListSeventhEvening() : Function
      {
         return this.FOnNewActiveListSeventhEvening;
      }
      
      public function set OnNewActiveListSeventhEvening(param1:Function) : void
      {
         this.FOnNewActiveListSeventhEvening = param1;
      }
      
      public function get OnNewActiveListHappyTreasure() : Function
      {
         return this.FOnNewActiveListHappyTreasure;
      }
      
      public function set OnNewActiveListHappyTreasure(param1:Function) : void
      {
         this.FOnNewActiveListHappyTreasure = param1;
      }
      
      public function get OnNewActiveListRechargeRank() : Function
      {
         return this.FOnNewActiveListRechargeRank;
      }
      
      public function set OnNewActiveListRechargeRank(param1:Function) : void
      {
         this.FOnNewActiveListRechargeRank = param1;
      }
      
      public function get OnNewActiveListGroupBuying() : Function
      {
         return this.FOnNewActiveListGroupBuying;
      }
      
      public function set OnNewActiveListGroupBuying(param1:Function) : void
      {
         this.FOnNewActiveListGroupBuying = param1;
      }
      
      public function get OnNewActiveListRechargeExchange() : Function
      {
         return this.FOnNewActiveListRechargeExchange;
      }
      
      public function set OnNewActiveListRechargeExchange(param1:Function) : void
      {
         this.FOnNewActiveListRechargeExchange = param1;
      }
      
      public function get OnNewActiveListOrangeEquipment() : Function
      {
         return this.FOnNewActiveListOrangeEquipment;
      }
      
      public function set OnNewActiveListOrangeEquipment(param1:Function) : void
      {
         this.FOnNewActiveListOrangeEquipment = param1;
      }
      
      public function get OnNewActiveListMidAutumn() : Function
      {
         return this.FOnNewActiveListMidAutumn;
      }
      
      public function set OnNewActiveListMidAutumn(param1:Function) : void
      {
         this.FOnNewActiveListMidAutumn = param1;
      }
      
      public function get OnNewActiveListDiscount() : Function
      {
         return this.FOnNewActiveListDiscount;
      }
      
      public function set OnNewActiveListDiscount(param1:Function) : void
      {
         this.FOnNewActiveListDiscount = param1;
      }
      
      public function get OnNewActiveListRechargeGive() : Function
      {
         return this.FOnNewActiveListRechargeGive;
      }
      
      public function set OnNewActiveListRechargeGive(param1:Function) : void
      {
         this.FOnNewActiveListRechargeGive = param1;
      }
      
      public function get OnNewActiveListNationalDay() : Function
      {
         return this.FOnNewActiveListNationalDay;
      }
      
      public function set OnNewActiveListNationalDay(param1:Function) : void
      {
         this.FOnNewActiveListNationalDay = param1;
      }
      
      public function get OnNewActiveListTreasureBox() : Function
      {
         return this.FOnNewActiveListTreasureBox;
      }
      
      public function set OnNewActiveListTreasureBox(param1:Function) : void
      {
         this.FOnNewActiveListTreasureBox = param1;
      }
      
      public function get OnActiveListThirdNinjiaVillage() : Function
      {
         return this.FOnActiveListThirdNinjiaVillage;
      }
      
      public function set OnActiveListThirdNinjiaVillage(param1:Function) : void
      {
         this.FOnActiveListThirdNinjiaVillage = param1;
      }
      
      public function get OnNewActiveListHallowmas() : Function
      {
         return this.FOnNewActiveListHallowmas;
      }
      
      public function set OnNewActiveListHallowmas(param1:Function) : void
      {
         this.FOnNewActiveListHallowmas = param1;
      }
      
      public function get OnNewActiveListInviteFriend() : Function
      {
         return this.FOnNewActiveListInviteFriend;
      }
      
      public function set OnNewActiveListInviteFriend(param1:Function) : void
      {
         this.FOnNewActiveListInviteFriend = param1;
      }
      
      public function get OnNewActiveListGuaGuaLe() : Function
      {
         return this.FOnNewActiveListGuaGuaLe;
      }
      
      public function set OnNewActiveListGuaGuaLe(param1:Function) : void
      {
         this.FOnNewActiveListGuaGuaLe = param1;
      }
      
      public function get OnNewActiveListWishTree() : Function
      {
         return this.FOnNewActiveListWishTree;
      }
      
      public function set OnNewActiveListWishTree(param1:Function) : void
      {
         this.FOnNewActiveListWishTree = param1;
      }
      
      public function get OnNewActiveListEverydaySale() : Function
      {
         return this.FOnNewActiveListEverydaySale;
      }
      
      public function set OnNewActiveListEverydaySale(param1:Function) : void
      {
         this.FOnNewActiveListEverydaySale = param1;
      }
      
      public function get OnNewActiveListVipTreasure() : Function
      {
         return this.FOnNewActiveListVipTreasure;
      }
      
      public function set OnNewActiveListVipTreasure(param1:Function) : void
      {
         this.FOnNewActiveListVipTreasure = param1;
      }
      
      public function get OnNewActiveListCrossServerSale() : Function
      {
         return this.FOnNewActiveListCrossServerSale;
      }
      
      public function set OnNewActiveListCrossServerSale(param1:Function) : void
      {
         this.FOnNewActiveListCrossServerSale = param1;
      }
      
      public function get OnNewActiveListChristmas() : Function
      {
         return this.FOnNewActiveListChristmas;
      }
      
      public function set OnNewActiveListChristmas(param1:Function) : void
      {
         this.FOnNewActiveListChristmas = param1;
      }
      
      public function get OnNewActiveListNewYear() : Function
      {
         return this.FOnNewActiveListNewYear;
      }
      
      public function set OnNewActiveListNewYear(param1:Function) : void
      {
         this.FOnNewActiveListNewYear = param1;
      }
      
      public function get OnNewActiveListShowMore() : Function
      {
         return this.FOnNewActiveListShowMore;
      }
      
      public function set OnNewActiveListShowMore(param1:Function) : void
      {
         this.FOnNewActiveListShowMore = param1;
      }
      
      public function get OnNewActiveListHideMore() : Function
      {
         return this.FOnNewActiveListHideMore;
      }
      
      public function set OnNewActiveListHideMore(param1:Function) : void
      {
         this.FOnNewActiveListHideMore = param1;
      }
      
      public function get OnNewActiveListActivityA() : Function
      {
         return this.FOnNewActiveListActivityA;
      }
      
      public function set OnNewActiveListActivityA(param1:Function) : void
      {
         this.FOnNewActiveListActivityA = param1;
      }
      
      public function get OnNewActiveListActivityB() : Function
      {
         return this.FOnNewActiveListActivityB;
      }
      
      public function set OnNewActiveListActivityB(param1:Function) : void
      {
         this.FOnNewActiveListActivityB = param1;
      }
      
      public function get OnNewActiveListSpringFestival() : Function
      {
         return this.FOnNewActiveListSpringFestival;
      }
      
      public function set OnNewActiveListSpringFestival(param1:Function) : void
      {
         this.FOnNewActiveListSpringFestival = param1;
      }
      
      public function get OnNewActiveListValentineDay() : Function
      {
         return this.FOnNewActiveListValentineDay;
      }
      
      public function set OnNewActiveListValentineDay(param1:Function) : void
      {
         this.FOnNewActiveListValentineDay = param1;
      }
      
      public function get OnNewActiveListBlackMarket() : Function
      {
         return this.FOnNewActiveListBlackMarket;
      }
      
      public function set OnNewActiveListBlackMarket(param1:Function) : void
      {
         this.FOnNewActiveListBlackMarket = param1;
      }
      
      public function get OnNewActiveListNinjaMeeting() : Function
      {
         return this.FOnNewActiveListNinjaMeeting;
      }
      
      public function set OnNewActiveListNinjaMeeting(param1:Function) : void
      {
         this.FOnNewActiveListNinjaMeeting = param1;
      }
      
      public function get OnNewActiveListFightBoss() : Function
      {
         return this.FOnNewActiveListFightBoss;
      }
      
      public function set OnNewActiveListFightBoss(param1:Function) : void
      {
         this.FOnNewActiveListFightBoss = param1;
      }
      
      public function get OnNewActiveListBrazilCarnival() : Function
      {
         return this.FOnNewActiveListBrazilCarnival;
      }
      
      public function set OnNewActiveListBrazilCarnival(param1:Function) : void
      {
         this.FOnNewActiveListBrazilCarnival = param1;
      }
      
      public function get OnNewActiveListFortuneCat() : Function
      {
         return this.FOnNewActiveListFortuneCat;
      }
      
      public function set OnNewActiveListFortuneCat(param1:Function) : void
      {
         this.FOnNewActiveListFortuneCat = param1;
      }
      
      public function get OnNewActiveListTowerLottery() : Function
      {
         return this.FOnNewActiveListTowerLottery;
      }
      
      public function set OnNewActiveListTowerLottery(param1:Function) : void
      {
         this.FOnNewActiveListTowerLottery = param1;
      }
      
      public function get OnNewActiveListMyActive() : Function
      {
         return this.FOnNewActiveListMyActive;
      }
      
      public function set OnNewActiveListMyActive(param1:Function) : void
      {
         this.FOnNewActiveListMyActive = param1;
      }
      
      public function get OnNewActiveListNinjaTreasure() : Function
      {
         return this.FOnNewActiveListNinjaTreasure;
      }
      
      public function set OnNewActiveListNinjaTreasure(param1:Function) : void
      {
         this.FOnNewActiveListNinjaTreasure = param1;
      }
      
      public function get OnNewActiveListSingleTopUp() : Function
      {
         return this.FOnNewActiveListSingleTopUp;
      }
      
      public function set OnNewActiveListSingleTopUp(param1:Function) : void
      {
         this.FOnNewActiveListSingleTopUp = param1;
      }
      
      public function get OnNewActiveListMayActive() : Function
      {
         return this.FOnNewActiveListMayActive;
      }
      
      public function set OnNewActiveListMayActive(param1:Function) : void
      {
         this.FOnNewActiveListMayActive = param1;
      }
      
      public function set OnActivityNarutoHelper(param1:Function) : void
      {
         this.FOnActivityNarutoHelper = param1;
      }
      
      public function set WelfareOnClick(param1:Function) : void
      {
         this.FWelfareOnClick = param1;
      }
      
      public function set ObligatoryCoursesOnClick(param1:Function) : void
      {
         this.FObligatoryCoursesOnClick = param1;
      }
      
      public function set BaiDuMeimeiOnClick(param1:Function) : void
      {
         this.FBaiDuMeimeiOnClick = param1;
      }
      
      public function set OhtsutsukiKaguyaOnClick(param1:Function) : void
      {
         this.FOhtsutsukiKaguyaOnClick = param1;
      }
      
      public function set OhtsutsuVkOnClick(param1:Function) : void
      {
         this.FOhtsutsuVkOnClick = param1;
      }
      
      public function set MC1377OnClick(param1:Function) : void
      {
         this.FMC1377OnClick = param1;
      }
      
      public function get OnNewActiveListSuperEquip() : Function
      {
         return this.FOnNewActiveListSuperEquip;
      }
      
      public function set OnNewActiveListSuperEquip(param1:Function) : void
      {
         this.FOnNewActiveListSuperEquip = param1;
      }
      
      public function set OnActivityNinjaRelation(param1:Function) : void
      {
         this.FOnActivityNinjaRelation = param1;
      }
      
      public function set OnActivityNinjaHostel(param1:Function) : void
      {
         this.FOnActivityNinjaHostel = param1;
      }
      
      public function set OnActivityBloodFete(param1:Function) : void
      {
         this.FOnActivityBloodFete = param1;
      }
      
      public function set OnActivityEpicEquip(param1:Function) : void
      {
         this.FOnActivityEpicEquip = param1;
      }
      
      public function set OnActivityTaboo(param1:Function) : void
      {
         this.FOnActivityTaboo = param1;
      }
      
      public function set OnActivityAwaken(param1:Function) : void
      {
         this.FOnActivityAwaken = param1;
      }
      
      public function set OnActivityEight(param1:Function) : void
      {
         this.FOnActivityEight = param1;
      }
      
      public function set OnActivityTransmigrationAccessory(param1:Function) : void
      {
         this.FOnActivityTransmigrationAccessory = param1;
      }
      
      public function set OnActivityTheWorldTree(param1:Function) : void
      {
         this.FOnActivityTheWorldTree = param1;
      }
      
      public function set OnActivityUndertown(param1:Function) : void
      {
         this.FOnActivityUndertown = param1;
      }
      
      public function set OnActivityLostShenQi(param1:Function) : void
      {
         this.FOnActivityLostShenQi = param1;
      }
      
      public function get OnNewActiveListOneWorthThousand() : Function
      {
         return this.FOnNewActiveListOneWorthThousand;
      }
      
      public function set OnNewActiveListOneWorthThousand(param1:Function) : void
      {
         this.FOnNewActiveListOneWorthThousand = param1;
      }
      
      public function get OnNewActiveListJuneActive() : Function
      {
         return this.FOnNewActiveListJuneActive;
      }
      
      public function set OnNewActiveListJuneActive(param1:Function) : void
      {
         this.FOnNewActiveListJuneActive = param1;
      }
      
      public function get OnNewActiveListPaymentWall() : Function
      {
         return this.FOnNewActiveListPaymentWall;
      }
      
      public function set OnNewActiveListPaymentWall(param1:Function) : void
      {
         this.FOnNewActiveListPaymentWall = param1;
      }
      
      public function get OnNewActiveListNinjaBank() : Function
      {
         return this.FOnNewActiveListNinjaBank;
      }
      
      public function set OnNewActiveListNinjaBank(param1:Function) : void
      {
         this.FOnNewActiveListNinjaBank = param1;
      }
      
      public function get OnNewActiveListJulyActive() : Function
      {
         return this.FOnNewActiveListJulyActive;
      }
      
      public function set OnNewActiveListJulyActive(param1:Function) : void
      {
         this.FOnNewActiveListJulyActive = param1;
      }
      
      public function get OnNewActiveListFirstRecharge_New() : Function
      {
         return this.FOnNewActiveListFirstRecharge_New;
      }
      
      public function set OnNewActiveListFirstRecharge_New(param1:Function) : void
      {
         this.FOnNewActiveListFirstRecharge_New = param1;
      }
      
      public function get OnNewActiveListComeBack() : Function
      {
         return this.FOnNewActiveListComeBack;
      }
      
      public function set OnNewActiveListComeBack(param1:Function) : void
      {
         this.FOnNewActiveListComeBack = param1;
      }
      
      public function get OnNewActiveListDessertHouse() : Function
      {
         return this.FOnNewActiveListDessertHouse;
      }
      
      public function set OnNewActiveListDessertHouse(param1:Function) : void
      {
         this.FOnNewActiveListDessertHouse = param1;
      }
      
      public function get OnNewActiveListAugustActive() : Function
      {
         return this.FOnNewActiveListAugustActive;
      }
      
      public function set OnNewActiveListAugustActive(param1:Function) : void
      {
         this.FOnNewActiveListAugustActive = param1;
      }
      
      public function get OnNewActiveListNewLottery() : Function
      {
         return this.FOnNewActiveListNewLottery;
      }
      
      public function set OnNewActiveListNewLottery(param1:Function) : void
      {
         this.FOnNewActiveListNewLottery = param1;
      }
      
      public function get OnNewActiveListSeptemberActive() : Function
      {
         return this.FOnNewActiveListSeptemberActive;
      }
      
      public function set OnNewActiveListSeptemberActive(param1:Function) : void
      {
         this.FOnNewActiveListSeptemberActive = param1;
      }
      
      public function get OnNewActiveListOctActive() : Function
      {
         return this.FOnNewActiveListOctActive;
      }
      
      public function set OnNewActiveListOctActive(param1:Function) : void
      {
         this.FOnNewActiveListOctActive = param1;
      }
      
      public function get OnNewActiveListDailyRecharge() : Function
      {
         return this.FOnNewActiveListDailyRecharge;
      }
      
      public function set OnNewActiveListDailyRecharge(param1:Function) : void
      {
         this.FOnNewActiveListDailyRecharge = param1;
      }
      
      public function get OnNewActiveListCloudBuy() : Function
      {
         return this.FOnNewActiveListCloudBuy;
      }
      
      public function set OnNewActiveListCloudBuy(param1:Function) : void
      {
         this.FOnNewActiveListCloudBuy = param1;
      }
      
      public function get OnNewActiveListFerrisWheel() : Function
      {
         return this.FOnNewActiveListFerrisWheel;
      }
      
      public function set OnNewActiveListFerrisWheel(param1:Function) : void
      {
         this.FOnNewActiveListFerrisWheel = param1;
      }
      
      public function get OnNewActiveListNovActive() : Function
      {
         return this.FOnNewActiveListNovActive;
      }
      
      public function set OnNewActiveListNovActive(param1:Function) : void
      {
         this.FOnNewActiveListNovActive = param1;
      }
      
      public function get OnNewActiveListDecActive() : Function
      {
         return this.FOnNewActiveListDecActive;
      }
      
      public function set OnNewActiveListDecActive(param1:Function) : void
      {
         this.FOnNewActiveListDecActive = param1;
      }
      
      public function get OnNewActiveListJanActive() : Function
      {
         return this.FOnNewActiveListJanActive;
      }
      
      public function set OnNewActiveListJanActive(param1:Function) : void
      {
         this.FOnNewActiveListJanActive = param1;
      }
      
      public function get OnNewActiveListFebActive() : Function
      {
         return this.FOnNewActiveListFebActive;
      }
      
      public function set OnNewActiveListFebActive(param1:Function) : void
      {
         this.FOnNewActiveListFebActive = param1;
      }
      
      public function set OnNewActiveListMarchActive(param1:Function) : void
      {
         this.FOnNewActiveListMarchActive = param1;
      }
      
      public function get OnNewActiveListMarchConsume() : Function
      {
         return this.FOnNewActiveListMarchConsume;
      }
      
      public function set OnNewActiveListMarchConsume(param1:Function) : void
      {
         this.FOnNewActiveListMarchConsume = param1;
      }
      
      public function set OnNewActiveListAprilActive(param1:Function) : void
      {
         this.FOnNewActiveListAprilActive = param1;
      }
      
      public function get OnNewActiveListCapsuleToys() : Function
      {
         return this.FOnNewActiveListCapsuleToys;
      }
      
      public function set OnNewActiveListCapsuleToys(param1:Function) : void
      {
         this.FOnNewActiveListCapsuleToys = param1;
      }
      
      public function get OnNewActiveListGoldDigger() : Function
      {
         return this.FOnNewActiveListGoldDigger;
      }
      
      public function set OnNewActiveListGoldDigger(param1:Function) : void
      {
         this.FOnNewActiveListGoldDigger = param1;
      }
      
      public function get OnNewActiveListMayActive2015() : Function
      {
         return this.FOnNewActiveListMayActive2015;
      }
      
      public function set OnNewActiveListMayActive2015(param1:Function) : void
      {
         this.FOnNewActiveListMayActive2015 = param1;
      }
      
      public function set OnActivityWing(param1:Function) : void
      {
         this.FOnActivityWing = param1;
      }
      
      public function get OnActivityWing() : Function
      {
         return this.FOnActivityWing;
      }
      
      public function set OnActivityChallenge(param1:Function) : void
      {
         this.FOnActivityChallenge = param1;
      }
      
      public function get OnActivityChallenge() : Function
      {
         return this.FOnActivityChallenge;
      }
      
      public function set OnActivityIllustrated(param1:Function) : void
      {
         this.FOnActivityIllustrated = param1;
      }
      
      public function get OnActivityIllustrated() : Function
      {
         return this.FOnActivityIllustrated;
      }
      
      public function set OnActivityAlien(param1:Function) : void
      {
         this.FOnActivityAlien = param1;
      }
      
      public function get OnActivityAlien() : Function
      {
         return this.FOnActivityAlien;
      }
      
      public function set OnActivityKingwar(param1:Function) : void
      {
         this.FOnActivityKingwar = param1;
      }
      
      public function get OnActivityKingwar() : Function
      {
         return this.FOnActivityKingwar;
      }
      
      public function set OnActivityMedal(param1:Function) : void
      {
         this.FOnActivityMedal = param1;
      }
      
      public function get OnActvityMedal() : Function
      {
         return this.FOnActivityMedal;
      }
      
      public function set OnActivityinviteCode(param1:Function) : void
      {
         this.FOnActivityinviteCode = param1;
      }
      
      public function get OnActivityinviteCode() : Function
      {
         return this.FOnActivityinviteCode;
      }
      
      public function set OnActivityWuxing(param1:Function) : void
      {
         this.FOnActivityWuxing = param1;
      }
      
      public function get OnActivityWuxing() : Function
      {
         return this.FOnActivityWuxing;
      }
      
      public function set OnActivityGlobalBattle(param1:Function) : void
      {
         this.FOnActivityGlobalBattle = param1;
      }
      
      public function get OnActivityGlobalBattle() : Function
      {
         return this.FOnActivityGlobalBattle;
      }
      
      public function set OnActivityEmblem(param1:Function) : void
      {
         this.FOnActivityEmblem = param1;
      }
      
      public function get OnActivityEmblem() : Function
      {
         return this.FOnActivityEmblem;
      }
      
      public function set OnActivityWorldMatch(param1:Function) : void
      {
         this.FOnActivityWorldMatch = param1;
      }
      
      public function get OnActivityWorldMatch() : Function
      {
         return this.FOnActivityWorldMatch;
      }
      
      public function set OnActivitySummonBattle(param1:Function) : void
      {
         this.FOnActivitySummonBattle = param1;
      }
      
      public function get OnActivitySummonBattle() : Function
      {
         return this.FOnActivitySummonBattle;
      }
      
      public function set OnActivityNinjaTalent(param1:Function) : void
      {
         this.FOnActivityNinjaTalent = param1;
      }
      
      public function get OnActivityNinjaTalent() : Function
      {
         return this.FOnActivityNinjaTalent;
      }
      
      public function set OnActivityChallengCamp(param1:Function) : void
      {
         this.FOnActivityChallengCamp = param1;
      }
      
      public function get OnActivityChallengCamp() : Function
      {
         return this.FOnActivityChallengCamp;
      }
      
      public function set OnActivityGlobalBoss(param1:Function) : void
      {
         this.FOnActivityGlobalBoss = param1;
      }
      
      public function get OnActivityGlobalBoss() : Function
      {
         return this.FOnActivityGlobalBoss;
      }
      
      public function set OnActivityRecruit(param1:Function) : void
      {
         this.FOnActivityRecruit = param1;
      }
      
      public function get OnActivityRecruit() : Function
      {
         return this.FOnActivityRecruit;
      }
      
      public function set OnActivityCrossSlave(param1:Function) : void
      {
         this.FOnActivityCrossSlave = param1;
      }
      
      public function get OnActivityCrossSlave() : Function
      {
         return this.FOnActivityCrossSlave;
      }
      
      public function ShortcutsSetup(param1:TLobbyShortcutModes) : void
      {
         var _loc2_:TLobbyShortcutAvatarModes = null;
         var _loc3_:TLobbyShortcutActivityModes = null;
         var _loc4_:TLobbyShortcutMapModes = null;
         var _loc5_:TLobbyShortcutQuestGuideModes = null;
         var _loc6_:TLobbyShortcutFunctionModes = null;
         var _loc7_:TLobbyShortcutConstantlyModes = null;
         if(param1 is TLobbyShortcutAvatarModes)
         {
            _loc2_ = param1 as TLobbyShortcutAvatarModes;
            this.FWindowAvatar.ShortcutsSetup(_loc2_);
         }
         if(param1 is TLobbyShortcutActivityModes)
         {
            _loc3_ = param1 as TLobbyShortcutActivityModes;
            this.FWindowActivity.ShortcutsSetup(_loc3_);
         }
         if(param1 is TLobbyShortcutMapModes)
         {
            _loc4_ = param1 as TLobbyShortcutMapModes;
            this.FWindowMap.ShortcutsSetup(_loc4_);
         }
         if(param1 is TLobbyShortcutQuestGuideModes)
         {
            _loc5_ = param1 as TLobbyShortcutQuestGuideModes;
            this.FWindowQuest.ShortcutsSetup(_loc5_);
         }
         if(param1 is TLobbyShortcutFunctionModes)
         {
            _loc6_ = param1 as TLobbyShortcutFunctionModes;
            this.FWindowFunction.ShortcutsSetup(_loc6_);
         }
         if(param1 is TLobbyShortcutConstantlyModes)
         {
            _loc7_ = param1 as TLobbyShortcutConstantlyModes;
            this.FWindowConstantly.ShortcutsSetup(_loc7_);
         }
      }
      
      public function InitSystemSetup() : void
      {
         this.FWindowMap.InitSystemSetup();
      }
      
      public function UpdateShortcutsState(param1:Object, param2:Object) : void
      {
         this.FWindowActivity.UpdateShortcutsState(param2);
         this.FWindowActiveSpecial.UpdateShortcutsState(param2);
         this.FWindowFunction.UpdateShortcutsState(param2);
         this.FWindowConstantly.UpdateShortcutsState(param2);
         this.FWindowNewActiveList.UpdateShortcutsState(param2);
      }
      
      public function UpdateNewActiveListStatus() : void
      {
         this.FWindowNewActiveList.UpdateShortcutsState(null);
      }
      
      public function CheckUnlockSeverStar() : void
      {
         this.FWindowConstantly.CheckUnlockSeverStar();
      }
      
      public function UnlockNotification(param1:Object, param2:Object) : void
      {
         var _loc3_:TUnlock = null;
         _loc3_ = param2 as TUnlock;
         switch(_loc3_.Position)
         {
            case POSITION_Activity:
               this.FWindowActivity.UnlockNotification(_loc3_);
               this.FWindowConstantly.UnlockNotification(_loc3_);
               break;
            case POSITION_Active_Special:
               this.FWindowActiveSpecial.UnlockNotification(_loc3_);
               this.FWindowConstantly.UnlockNotification(_loc3_);
               break;
            case POSITION_Function:
               this.FWindowFunction.UnlockNotification(_loc3_);
               this.FWindowConstantly.UnlockNotification(_loc3_);
         }
      }
      
      public function OpenActivityListStatusNotification() : void
      {
         this.FWindowActiveList.OpenStatusNotification();
      }
      
      public function OpenNewActivityListStatusNotification() : void
      {
         this.FWindowNewActiveList.OpenStatusNotification();
      }
      
      public function OpenActivityListThirdStatusNotification() : void
      {
         this.FWindowActiveListThird.OpenStatusNotification();
      }
      
      public function UserUpdateCharBaseInfo() : void
      {
         this.FWindowAvatar.UserUpdateCharBaseInfo();
         this.FWindowFunction.UserUpdateCharBaseInfo();
         this.FWindowAvatar.SetPrerogativeButton();
      }
      
      public function UserUpdateCharacterCountry() : void
      {
         this.FWindowAvatar.UserUpdateCharacterCountry();
      }
      
      public function UserUpdateFightingPower(param1:uint = 0) : void
      {
         this.FWindowAvatar.UpdateTextEffect(param1);
      }
      
      public function UpdateTextEffect() : void
      {
         this.FWindowAvatar.UpdateTextEffect();
      }
      
      public function UpdateReturnHomePanel(param1:String, param2:String) : void
      {
         this.FWindowMap.UpdateReturnHomePanel(param1,param2);
      }
      
      public function UserUpdatePet() : void
      {
         this.FWindowAvatar.UserUpdatePet();
      }
      
      public function UserUpdateConsumeVip() : void
      {
         this.FWindowAvatar.UserUpdateConsumeVip();
      }
      
      public function ShowSpecialNotification(param1:uint, param2:uint, param3:Boolean) : void
      {
         switch(param1)
         {
            case POSITION_ActiveList:
               this.FWindowActiveList.ShowSpecialNotification(param1,param2,param3);
         }
      }
      
      public function ShowEffectNotification(param1:uint, param2:uint, param3:Boolean) : void
      {
         switch(param1)
         {
            case POSITION_Function:
               this.FWindowFunction.ShowEffectNotification(param2,param3);
               if(param2 == TYPE_Function_Mail)
               {
                  this.FWindowMap.ShowEffectNotification(TYPE_Map_Mail,param3);
               }
               break;
            case POSITION_Activity:
               this.FWindowActivity.ShowEffectNotification(param2,param3);
               break;
            case POSITION_Active_Special:
               this.FWindowActiveSpecial.ShowEffectNotification(param2,param3);
               break;
            case POSITION_ActiveList:
            case POSITION_ActiveListSecondary:
               this.FWindowActiveList.ShowEffectNotification(param1,param2,param3);
               break;
            case POSITION_Avatar:
               this.FWindowAvatar.ShowEffectNotification(param2,param3);
               break;
            case POSITION_NewActiveList:
               this.FWindowNewActiveList.ShowEffectNotification(param1,param2,param3);
               break;
            case POSITION_ActiveListThird:
               this.FWindowActiveListThird.ShowEffectNotification(param1,param2,param3);
               break;
            case POSITION_Others:
               this.FWindowMap.ShowEffectNotificationCopy(TYPE_Map_Friend,param3);
         }
      }
      
      public function PerformShortcutHyperlinks(param1:Object, param2:uint, param3:uint, param4:int, param5:Object, param6:Function) : void
      {
         var _loc7_:Boolean = false;
         var _loc8_:String = null;
         this.FParameter = param4;
         _loc7_ = this.VerificationLocaltionOperatingByPosition(param2,param3);
         if(param2 == CONST_SHORTCUTS.POSITION_Activity && param3 == CONST_SHORTCUTS.TYPE_Activity_CopyHero)
         {
            _loc7_ = true;
         }
         if(param2 == CONST_SHORTCUTS.POSITION_Additional && param3 == CONST_SHORTCUTS.TYPE_Additional_Accessory)
         {
            _loc7_ = true;
         }
         if(!_loc7_)
         {
            _loc8_ = this.InquiryConditionLocaltionOperatingByPosition(param2,param3);
            EffectGenerateText(_loc8_);
            return;
         }
         param6(param1);
         switch(param2)
         {
            case POSITION_Function:
               this.ShortcutFunctionOperating(param3,param4,param5);
               break;
            case POSITION_Activity:
               this.ShortcutActivityOperating(param3,param4,param5);
               break;
            case POSITION_Active_Special:
               this.ShortcutActiveSpecialOperating(param3,param4,param5);
               break;
            case POSITION_Avatar:
               this.ShortcutAvaterHeadOperating(param3,param4,param5);
               break;
            case POSITION_Constantly:
               this.ShortcutConstantlyOperating(param3,param4,param5);
               break;
            case POSITION_Map:
               this.ShortcutMapOperating(param3,param4,param5);
               break;
            case POSITION_Additional:
               this.ShortcutAdditionalOperating(param3,param4,param5);
         }
      }
      
      public function UpdateMilitaryOrdersLimit() : void
      {
         this.FWindowAvatar.UpdateMilitaryOrdersLimit();
      }
      
      public function EffectBaseGlowVIP(param1:Object, param2:Boolean) : void
      {
         if(this.FWindowAvatar != null)
         {
            this.FWindowAvatar.TerminationButtonEffect(param2);
         }
      }
      
      public function EffectBaseGlowSVIP(param1:Object, param2:Boolean) : void
      {
         if(this.FWindowAvatar != null)
         {
            this.FWindowAvatar.TerminationButtonEffectCopy(param2);
         }
      }
      
      public function QueryShortcutCoordinate(param1:Object, param2:uint, param3:uint, param4:TQueryCoordinate) : void
      {
         switch(param2)
         {
            case CONST_SHORTCUTS.POSITION_Activity:
               this.FWindowActivity.QueryShortcutCoordinate(param1,param3,param4);
               break;
            case CONST_SHORTCUTS.POSITION_Function:
               this.FWindowFunction.QueryShortcutCoordinate(param1,param3,param4);
         }
      }
      
      public function BuyActionTimes() : void
      {
         this.FWindowAvatar.BuyActionTimes();
      }
      
      public function ShowHeroContorlPanle(param1:TUIRoleCanMovePlayerRole) : void
      {
         this.FWindowHeroInfor.ShowHeroInforPanle(param1);
      }
      
      public function HideHeroContorlPanle() : void
      {
         this.FWindowHeroInfor.HideHeroInforPanle();
      }
      
      public function UpdateActivityStatus(param1:uint, param2:uint) : void
      {
      }
      
      public function SetIntoAutoBattle(param1:Object, param2:Boolean, param3:uint) : void
      {
         this.FWindowAvatar.SetIntoAutoBattle(param1,param2,param3);
      }
      
      public function EndAutoBattle(param1:Object) : void
      {
         this.FWindowMap.EndAutoBattle(param1);
      }
      
      public function ExecuteCommand(param1:Object) : void
      {
         this.FWindowMap.ExecuteCommand(param1);
      }
      
      public function UpdateSkipResurgenceBtnfilter(param1:int) : void
      {
         this.FWindowMap.UpdateSkipResurgenceBtnfilter(param1);
      }
      
      public function IsPlayEffect(param1:Boolean) : void
      {
         this.FWindowAvatar.IsPlayEffect(param1);
      }
      
      public function SetObligatoryCoursesCount(param1:Object, param2:uint) : void
      {
         this.FWindowAvatar.SetObligatoryCoursesCount(param1,param2);
      }
      
      public function setFBaiDuMeimeiMcState(param1:Boolean) : void
      {
         this.FWindowAvatar.setFBaiDuMeimeiMcState(param1);
      }
      
      public function MainHeroUpLevel() : void
      {
         this.FWindowAvatar.MainHeroUpLevel();
      }
      
      public function SetAutoStatus(param1:Object, param2:Boolean, param3:Boolean, param4:Boolean) : void
      {
         this.FWindowMap.SetAutoStatus(param1,param2,param3,param4);
      }
      
      public function IconIsShow(param1:Boolean) : void
      {
         this.FWindowAvatar.IconIsShow(param1);
      }
      
      public function MiIconIsShow(param1:Boolean) : void
      {
         this.FWindowAvatar.MiIconIsShow(param1);
      }
      
      public function set OpenOnLineGift(param1:Function) : void
      {
         this.FOpenOnLineGift = param1;
      }
      
      public function get OnNewActiveListPersiaTrader() : Function
      {
         return this.FOnNewActiveListPersiaTrader;
      }
      
      public function set OnNewActiveListPersiaTrader(param1:Function) : void
      {
         this.FOnNewActiveListPersiaTrader = param1;
      }
      
      public function get OnNewActiveListAncientTreasure() : Function
      {
         return this.FOnNewActiveListAncientTreasure;
      }
      
      public function set OnNewActiveListAncientTreasure(param1:Function) : void
      {
         this.FOnNewActiveListAncientTreasure = param1;
      }
      
      public function get OnNewActiveListCornucopia() : Function
      {
         return this.FOnNewActiveListCornucopia;
      }
      
      public function set OnNewActiveListCornucopia(param1:Function) : void
      {
         this.FOnNewActiveListCornucopia = param1;
      }
      
      public function get OnNewActiveListGoldTree() : Function
      {
         return this.FOnNewActiveListGoldTree;
      }
      
      public function set OnNewActiveListGoldTree(param1:Function) : void
      {
         this.FOnNewActiveListGoldTree = param1;
      }
      
      public function get OnNewActiveListAlchemyStudio() : Function
      {
         return this.FOnNewActiveListAlchemyStudio;
      }
      
      public function set OnNewActiveListAlchemyStudio(param1:Function) : void
      {
         this.FOnNewActiveListAlchemyStudio = param1;
      }
      
      public function get OnNewActiveListGodWelfare() : Function
      {
         return this.FOnNewActiveListGodWelfare;
      }
      
      public function set OnNewActiveListGodWelfare(param1:Function) : void
      {
         this.FOnNewActiveListGodWelfare = param1;
      }
      
      public function get OnNewActiveListIdolumFight() : Function
      {
         return this.FOnNewActiveListIdolumFight;
      }
      
      public function set OnNewActiveListIdolumFight(param1:Function) : void
      {
         this.FOnNewActiveListIdolumFight = param1;
      }
      
      protected function FOpenOnLineGiftFunction() : void
      {
         if(this.FOpenOnLineGift != null)
         {
            this.FOpenOnLineGift();
         }
      }
   }
}

