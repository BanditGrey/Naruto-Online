package Logics.Characters
{
   import Debugging.*;
   import Foundation.Common.*;
   import Foundation.Common.Integer.*;
   import Foundation.Common.Spaces.*;
   import Foundation.Common.Stubs.*;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Utilities.TUtilityString;
   import Logics.Buffs.TBuffs;
   import Logics.Dailytask.TDailytask;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.DatebaseVO.VO.TRoleModel;
   import Logics.GeneralStar.TEsotericPoints;
   import Logics.Illustrated.TIllustrated;
   import Logics.Inventories.*;
   import Logics.Jade.TSpecialJade;
   import Logics.Pet.TPet;
   import Logics.Quests.*;
   import Logics.Skills.*;
   import Logics.Spaces.*;
   import Logics.TimeCoolDown.TTimeCoolDowns;
   import Logics.Vip.TVip;
   import Logics.Wing.TWing;
   import Resources.Constants.*;
   import Resources.Strings.STRING_NINJIAREINCARNATION;
   import adobe.utils.*;
   
   use namespace LogicsSpace;
   
   public class TCharacter extends TEntity64
   {
      
      protected static const INDEX_MainHero:uint = 0;
      
      public static const CAPACITY_Backpack:uint = CONST_CHARACTER.CAPACITY_Backpack;
      
      public static const CAPACITY_BackpackTemporary:uint = CONST_CHARACTER.CAPACITY_BackpackTemporary;
      
      protected static const CAPACITY_Credits:int = CONST_CHARACTER.CAPACITY_Credits;
      
      protected static const CREDITINDEX_Gold:int = CONST_CHARACTER.CREDITINDEX_Gold;
      
      protected static const CREDITINDEX_SilverCoin:int = CONST_CHARACTER.CREDITINDEX_SilverCoin;
      
      protected static const CREDITINDEX_GiftCertificate:int = CONST_CHARACTER.CREDITINDEX_GiftCertificate;
      
      protected static const CREDITINDEX_MilitaryOrders:int = CONST_CHARACTER.CREDITINDEX_MilitaryOrders;
      
      protected static const CREDITINDEX_Integral:int = CONST_CHARACTER.CREDITINDEX_Integral;
      
      protected static const CREDITINDEX_MilitaryOrdersBuff:int = CONST_CHARACTER.CREDITINDEX_MilitaryOrdersBuff;
      
      public static const CAPACITY_HeroSouls:int = CONST_CHARACTER.CAPACITY_HeroSouls;
      
      public static const HEROSOULINDEX_BlueSoul:int = CONST_CHARACTER.HEROSOULINDEX_BlueSoul;
      
      public static const HEROSOULINDEX_PurpleSoul:int = CONST_CHARACTER.HEROSOULINDEX_PurpleSoul;
      
      public static const HEROSOULINDEX_GoldSoul:int = CONST_CHARACTER.HEROSOULINDEX_GoldSoul;
      
      public static const HEROSOULINDEX_OrangeSoul:int = CONST_CHARACTER.HEROSOULINDEX_OrangeSoul;
      
      public static const CAPACITY_KingSouls:int = 8;
      
      public static const KINGSOULINDEX_Common:int = CONST_COMMON.KINGSOULINDEX_Common;
      
      public static const KINGSOULINDEX_Thunder:int = CONST_COMMON.KINGSOULINDEX_Thunder;
      
      public static const KINGSOULINDEX_Dust:int = CONST_COMMON.KINGSOULINDEX_Dust;
      
      public static const KINGSOULINDEX_Water:int = CONST_COMMON.KINGSOULINDEX_Water;
      
      public static const KINGSOULINDEX_Wind:int = CONST_COMMON.KINGSOULINDEX_Wind;
      
      public static const KINGSOULINDEX_Fire:int = CONST_COMMON.KINGSOULINDEX_Fire;
      
      public static const KINGSOULINDEX_Forth:int = CONST_COMMON.KINGSOULINDEX_Forth;
      
      public static const KINGSOULINDEX_First:int = CONST_COMMON.KINGSOULINDEX_First;
      
      public static const TIME_COOLDOWN_StrengthenCD:int = CONST_COMMON.TIME_COOLDOWN_Strengthen;
      
      public static const TIME_COOLDOWN_AreanCD:int = CONST_COMMON.TIME_COOLDOWN_Arean;
      
      protected static const CAPACITY_INVENTORIES:uint = CONST_CHARACTER.CAPACITY_INVENTORIES;
      
      protected static const INVENTORIESINDEX_Appliances:uint = CONST_CHARACTER.INVENTORIESINDEX_Appliances;
      
      protected static const INVENTORIESINDEX_Equipments:uint = CONST_CHARACTER.INVENTORIESINDEX_Equipments;
      
      protected static const INVENTORIESINDEX_Materials:uint = CONST_CHARACTER.INVENTORIESINDEX_Materials;
      
      protected static const INVENTORIESINDEX_Gems:uint = CONST_CHARACTER.INVENTORIESINDEX_Gems;
      
      protected static const INVENTORIESINDEX_Treasures:uint = CONST_CHARACTER.INVENTORIESINDEX_Treasures;
      
      public static const INVENTORIESINDEX_Accessories:uint = CONST_CHARACTER.INVENTORIESINDEX_Accessories;
      
      public static const INVENTORIESINDEX_Temporary:uint = CONST_CHARACTER.INVENTORIESINDEX_Temporary;
      
      public static const INVENTORIESINDEX_Medals:uint = CONST_CHARACTER.INVENTORIESINDEX_Medals;
      
      public static const Ninja_One_Reincarnation_Footstone:uint = CONST_COMMON.Ninja_One_Reincarnation_Footstone;
      
      public static const Ninja_Two_Reincarnation_Footstone:uint = CONST_COMMON.Ninja_Two_Reincarnation_Footstone;
      
      public static const Ninja_Three_Reincarnation_Footstone:uint = CONST_COMMON.Ninja_Three_Reincarnation_Footstone;
      
      public static const Ninja_Reincarnation_Logic_:uint = CONST_COMMON.Ninja_Reincarnation_Logic_;
      
      public static const Ninja_Reincarnation_Logic_Footstone:uint = CONST_COMMON.Ninja_Reincarnation_Logic_Footstone;
      
      protected const CAPACITY_KingSouls:uint = 8;
      
      protected var FStubReferences:TStubReferences;
      
      protected var FAgentOperatorId:uint;
      
      protected var FAgentUserId:String;
      
      protected var FServerId:uint;
      
      protected var FNickName:String;
      
      protected var FCountry:uint;
      
      protected var FPrestige:uint;
      
      protected var FMilitaryRank:uint;
      
      protected var FTownID:uint;
      
      protected var FStarMapIndex:uint;
      
      protected var FGeneralsSoul:uint;
      
      protected var FAwakenGeneralsSoul:uint;
      
      protected var FPet:TPet;
      
      protected var FDailyTask:TDailytask;
      
      protected var FBuyHeroSlot:uint;
      
      protected var FVipData:TVip;
      
      protected var FCredits:Vector.<Object>;
      
      protected var FHeroSouls:Vector.<uint>;
      
      protected var FKingSouls:Vector.<uint>;
      
      protected var FTimeCoolDowns:TTimeCoolDowns;
      
      protected var FEsotericPoints:TEsotericPoints;
      
      protected var FMaxStarLevel:uint;
      
      protected var FMainQuestComplete:TQuests;
      
      protected var FSubQuestComplete:TQuests;
      
      protected var FMainQuestsAlreadyAccept:TQuests;
      
      protected var FSubQuestsAlreadyAccept:TQuests;
      
      protected var FMainQuestsCanAccept:TQuests;
      
      protected var FSubQuestsCanAccept:TQuests;
      
      protected var FFreshGuideProgress:String;
      
      protected var FBuffsGlobalOptional:TBuffs;
      
      protected var FHeros:THeros;
      
      protected var FBackpackCapacity:uint;
      
      protected var FCurrentCapacity:uint;
      
      protected var FBackpackExpandCount:uint;
      
      protected var FBackpackTemporaryCapacity:uint;
      
      protected var FOpenedBagCount:int;
      
      protected var FOpenedBagCountByLevel:int;
      
      protected var FInventories:TInventories;
      
      protected var FAppliances:TInventories;
      
      protected var FEquipments:TInventories;
      
      protected var FMaterials:TInventories;
      
      protected var FGems:TInventories;
      
      protected var FTreasures:TInventories;
      
      protected var FTemporaryInventories:TInventories;
      
      protected var FInventorySamples:TInventorySamples;
      
      protected var FAccessories:TInventories;
      
      protected var FMedals:TInventories;
      
      protected var FBackpack:Vector.<TInventories>;
      
      protected var FRoleSencePosition:int;
      
      protected var FCurModuleID:uint;
      
      protected var FIsAntiAddiction:Boolean;
      
      protected var FChatForbidden:Boolean;
      
      protected var FChatForbiddanceExpiration:uint;
      
      protected var FMilitaryBuyCount:uint;
      
      protected var FTitleId:uint;
      
      protected var FLittlePetId:uint;
      
      protected var FTotalFightingPowerPVE:UInt64;
      
      protected var FTotalFightingPowerPVP:UInt64;
      
      protected var FLimitiExpGrow:int;
      
      protected var FReinCarnationOneNeed:int;
      
      protected var FCurVersionMastLevel:uint;
      
      protected var FPageIndex:uint;
      
      protected var FHeroIndex:uint;
      
      protected var FXingDongLiMaxValue:uint;
      
      protected var FMaxTempValue:uint;
      
      protected var FConfigAllExp:UInt64;
      
      protected var FConfigArrInformation:Vector.<Object>;
      
      protected var FConfigNpc:Vector.<uint>;
      
      protected var FIsSkillShowTime:Boolean;
      
      protected var FWing:TWing;
      
      protected var FIllustrated:TIllustrated;
      
      public var BadgeList:Vector.<int>;
      
      protected var FSpecialJade:TSpecialJade;
      
      public function TCharacter(param1:uint, param2:uint)
      {
         super(param1,param2);
         this.FStubReferences = new TStubReferences(this);
         this.FVipData = new TVip();
         this.FCredits = new Vector.<Object>(CAPACITY_Credits);
         this.FCredits[CREDITINDEX_Gold] = 0;
         this.FCredits[CREDITINDEX_SilverCoin] = new UInt64();
         this.FCredits[CREDITINDEX_GiftCertificate] = 0;
         this.FCredits[CREDITINDEX_MilitaryOrders] = 0;
         this.FCredits[CREDITINDEX_Integral] = 0;
         this.FCredits[CREDITINDEX_MilitaryOrdersBuff] = 0;
         this.FHeroSouls = new Vector.<uint>(CAPACITY_HeroSouls);
         this.FKingSouls = new Vector.<uint>(this.CAPACITY_KingSouls);
         this.FTimeCoolDowns = new TTimeCoolDowns();
         this.FEsotericPoints = new TEsotericPoints();
         this.FHeros = new THeros();
         this.FBackpackCapacity = CAPACITY_Backpack;
         this.FBackpackTemporaryCapacity = CAPACITY_BackpackTemporary;
         this.FInventories = new TInventories();
         this.FAppliances = new TInventories();
         this.FEquipments = new TInventories();
         this.FMaterials = new TInventories();
         this.FGems = new TInventories();
         this.FTreasures = new TInventories();
         this.FTemporaryInventories = new TInventories();
         this.FInventorySamples = new TInventorySamples();
         this.FAccessories = new TInventories();
         this.FMedals = new TInventories();
         this.FBackpack = new Vector.<TInventories>(CAPACITY_INVENTORIES);
         this.FBackpack[INVENTORIESINDEX_Appliances] = this.FAppliances;
         this.FBackpack[INVENTORIESINDEX_Equipments] = this.FEquipments;
         this.FBackpack[INVENTORIESINDEX_Materials] = this.FMaterials;
         this.FBackpack[INVENTORIESINDEX_Gems] = this.FGems;
         this.FBackpack[INVENTORIESINDEX_Treasures] = this.FTreasures;
         this.FBackpack[INVENTORIESINDEX_Accessories] = this.FAccessories;
         this.FBackpack[INVENTORIESINDEX_Medals] = this.FMedals;
         this.FBackpack[INVENTORIESINDEX_Temporary] = this.FTemporaryInventories;
         this.FMainQuestComplete = new TQuests();
         this.FSubQuestComplete = new TQuests();
         this.FMainQuestsAlreadyAccept = new TQuests();
         this.FSubQuestsAlreadyAccept = new TQuests();
         this.FMainQuestsCanAccept = new TQuests();
         this.FSubQuestsCanAccept = new TQuests();
         this.FPet = new TPet();
         this.FDailyTask = new TDailytask();
         this.Wing = new TWing();
         this.Illustrated = new TIllustrated();
         this.BadgeList = new Vector.<int>();
         this.FRoleSencePosition = -1;
         this.SpecialJade = new TSpecialJade();
      }
      
      LogicsSpace function Coerce(param1:uint, param2:uint) : void
      {
         FIdentifier0 = param1;
         FIdentifier1 = param2;
      }
      
      public function get StubReferences() : TStubReferences
      {
         return this.FStubReferences;
      }
      
      public function get NickName() : String
      {
         return this.FNickName ? this.FNickName : "";
      }
      
      public function set NickName(param1:String) : void
      {
         this.FNickName = param1;
      }
      
      public function get Country() : uint
      {
         return this.FCountry;
      }
      
      public function set Country(param1:uint) : void
      {
         this.FCountry = param1;
      }
      
      public function get TownID() : uint
      {
         return this.FTownID;
      }
      
      public function set TownID(param1:uint) : void
      {
         this.FTownID = param1;
      }
      
      public function get StarMapIndex() : uint
      {
         return this.FStarMapIndex;
      }
      
      public function set StarMapIndex(param1:uint) : void
      {
         this.FStarMapIndex = param1;
      }
      
      public function get Pet() : TPet
      {
         return this.FPet;
      }
      
      public function get DailyTask() : TDailytask
      {
         return this.FDailyTask;
      }
      
      public function set DailyTask(param1:TDailytask) : void
      {
         this.FDailyTask = param1;
      }
      
      public function set BuyHeroSlot(param1:uint) : void
      {
         this.FBuyHeroSlot = param1;
      }
      
      public function get BuyHeroSlot() : uint
      {
         return this.FBuyHeroSlot;
      }
      
      public function get VipData() : TVip
      {
         return this.FVipData;
      }
      
      public function GetFightingPowerPVE() : UInt64
      {
         return this.FTotalFightingPowerPVE;
      }
      
      public function GetFightingPowerPVP() : UInt64
      {
         return this.FTotalFightingPowerPVP;
      }
      
      public function SetFightingPower(param1:UInt64, param2:UInt64) : void
      {
         this.FTotalFightingPowerPVE = param1;
         this.FTotalFightingPowerPVP = param2;
      }
      
      public function set LimitiExpGrow(param1:int) : void
      {
         this.FLimitiExpGrow = param1;
      }
      
      public function get LimitiExpGrow() : int
      {
         return this.FLimitiExpGrow;
      }
      
      public function set ReinCarnationOneNeed(param1:int) : void
      {
         this.FReinCarnationOneNeed = param1;
      }
      
      public function get ReinCarnationOneNeed() : int
      {
         return this.FReinCarnationOneNeed;
      }
      
      public function get IsAntiAddiction() : Boolean
      {
         return this.FIsAntiAddiction;
      }
      
      public function set IsAntiAddiction(param1:Boolean) : void
      {
         this.FIsAntiAddiction = param1;
      }
      
      public function get ChatForbidden() : Boolean
      {
         return this.FChatForbidden;
      }
      
      public function set ChatForbidden(param1:Boolean) : void
      {
         this.FChatForbidden = param1;
      }
      
      public function GetCreditByIndex(param1:int) : Object
      {
         return this.FCredits[param1];
      }
      
      public function SetCreditByIndex(param1:int, param2:Object) : void
      {
         this.FCredits[param1] = param2;
      }
      
      public function get CreditGold() : uint
      {
         return this.FCredits[CREDITINDEX_Gold] as uint;
      }
      
      public function set CreditGold(param1:uint) : void
      {
         this.FCredits[CREDITINDEX_Gold] = param1;
      }
      
      public function get CreditSilverCoin() : UInt64
      {
         return this.FCredits[CREDITINDEX_SilverCoin] as UInt64;
      }
      
      public function CheckCreditSilverCoinEnough(param1:uint, param2:uint = 0) : Boolean
      {
         var _loc3_:Boolean = false;
         _loc3_ = false;
         if(this.CreditSilverCoin.High > param2)
         {
            _loc3_ = true;
         }
         else if(this.CreditSilverCoin.High == param2)
         {
            if(this.CreditSilverCoin.Low >= param1)
            {
               _loc3_ = true;
            }
         }
         return _loc3_;
      }
      
      public function get CreditGiftCertificate() : uint
      {
         return this.FCredits[CREDITINDEX_GiftCertificate] as uint;
      }
      
      public function set CreditGiftCertificate(param1:uint) : void
      {
         this.FCredits[CREDITINDEX_GiftCertificate] = param1;
      }
      
      public function get CreditMilitaryOrders() : uint
      {
         return this.FCredits[CREDITINDEX_MilitaryOrders] as uint;
      }
      
      public function set CreditMilitaryOrders(param1:uint) : void
      {
         this.FCredits[CREDITINDEX_MilitaryOrders] = param1;
      }
      
      public function get CreditIntegral() : uint
      {
         return this.FCredits[CREDITINDEX_Integral] as uint;
      }
      
      public function set CreditIntegral(param1:uint) : void
      {
         this.FCredits[CREDITINDEX_Integral] = param1;
      }
      
      public function get CreditMilitaryOrdersBuff() : uint
      {
         return this.FCredits[CREDITINDEX_MilitaryOrdersBuff] as uint;
      }
      
      public function set CreditMilitaryOrdersBuff(param1:uint) : void
      {
         this.FCredits[CREDITINDEX_MilitaryOrdersBuff] = param1;
      }
      
      public function GetHeroSoulByIndex(param1:int) : uint
      {
         return this.FHeroSouls[param1];
      }
      
      public function SetHeroSoulByIndex(param1:int, param2:uint) : void
      {
         this.FHeroSouls[param1] = param2;
      }
      
      public function get HeroSoulBlueSoul() : uint
      {
         return this.FHeroSouls[HEROSOULINDEX_BlueSoul] as uint;
      }
      
      public function set HeroSoulBlueSoul(param1:uint) : void
      {
         this.FHeroSouls[HEROSOULINDEX_BlueSoul] = param1;
      }
      
      public function get HeroSoulPurpleSoul() : uint
      {
         return this.FHeroSouls[HEROSOULINDEX_PurpleSoul] as uint;
      }
      
      public function set HeroSoulPurpleSoul(param1:uint) : void
      {
         this.FHeroSouls[HEROSOULINDEX_PurpleSoul] = param1;
      }
      
      public function get HeroSoulGoldSoul() : uint
      {
         return this.FHeroSouls[HEROSOULINDEX_GoldSoul] as uint;
      }
      
      public function set HeroSoulGoldSoul(param1:uint) : void
      {
         this.FHeroSouls[HEROSOULINDEX_GoldSoul] = param1;
      }
      
      public function get HeroSoulOrangeSoul() : uint
      {
         return this.FHeroSouls[HEROSOULINDEX_OrangeSoul] as uint;
      }
      
      public function set HeroSoulOrangeSoul(param1:uint) : void
      {
         this.FHeroSouls[HEROSOULINDEX_OrangeSoul] = param1;
      }
      
      public function GetKingSoulByIndex(param1:int) : uint
      {
         return this.FKingSouls[param1];
      }
      
      public function SetKingSoulByIndex(param1:int, param2:uint) : void
      {
         this.FKingSouls[param1] = param2;
      }
      
      public function get KingSoulCommon() : uint
      {
         return this.FKingSouls[KINGSOULINDEX_Common];
      }
      
      public function set KingSoulCommon(param1:uint) : void
      {
         this.FKingSouls[KINGSOULINDEX_Common] = param1;
      }
      
      public function get KingSoulThunder() : uint
      {
         return this.FKingSouls[KINGSOULINDEX_Thunder];
      }
      
      public function set KingSoulThunder(param1:uint) : void
      {
         this.FKingSouls[KINGSOULINDEX_Thunder] = param1;
      }
      
      public function get KingSoulDust() : uint
      {
         return this.FKingSouls[KINGSOULINDEX_Dust];
      }
      
      public function set KingSoulDust(param1:uint) : void
      {
         this.FKingSouls[KINGSOULINDEX_Dust] = param1;
      }
      
      public function get KingSoulWater() : uint
      {
         return this.FKingSouls[KINGSOULINDEX_Water];
      }
      
      public function set KingSoulWater(param1:uint) : void
      {
         this.FKingSouls[KINGSOULINDEX_Water] = param1;
      }
      
      public function get KingSoulWind() : uint
      {
         return this.FKingSouls[KINGSOULINDEX_Wind];
      }
      
      public function set KingSoulWind(param1:uint) : void
      {
         this.FKingSouls[KINGSOULINDEX_Wind] = param1;
      }
      
      public function get KingSoulFire() : uint
      {
         return this.FKingSouls[KINGSOULINDEX_Fire];
      }
      
      public function set KingSoulFire(param1:uint) : void
      {
         this.FKingSouls[KINGSOULINDEX_Fire] = param1;
      }
      
      public function get KingSoulForth() : uint
      {
         return this.FKingSouls[KINGSOULINDEX_Forth];
      }
      
      public function set KingSoulForth(param1:uint) : void
      {
         this.FKingSouls[KINGSOULINDEX_Forth] = param1;
      }
      
      public function get KingSoulFirst() : uint
      {
         return this.FKingSouls[KINGSOULINDEX_First];
      }
      
      public function set KingSoulFirst(param1:uint) : void
      {
         this.FKingSouls[KINGSOULINDEX_First] = param1;
      }
      
      public function get TimeCoolDowns() : TTimeCoolDowns
      {
         return this.FTimeCoolDowns;
      }
      
      public function get BuffsGlobalOptional() : TBuffs
      {
         return this.FBuffsGlobalOptional;
      }
      
      public function get Heros() : THeros
      {
         return this.FHeros;
      }
      
      public function get MainHero() : THero
      {
         return this.FHeros.GetHeroByIndex(INDEX_MainHero);
      }
      
      public function get MainHeroSelectedSkill() : TSkill
      {
         var _loc1_:TSkills = null;
         _loc1_ = this.MainHero.Skills;
         _loc1_.Sort();
         return _loc1_.GetSkillByIndex(0);
      }
      
      public function get ConfigArrInformation() : Vector.<Object>
      {
         var _loc1_:TConfigValue = null;
         if(!this.FConfigArrInformation)
         {
            _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,91100003) as TConfigValue;
            this.FConfigArrInformation = _loc1_.Value as Vector.<Object>;
         }
         return this.FConfigArrInformation;
      }
      
      public function get ConfigNpc() : Vector.<uint>
      {
         var _loc1_:TConfigValue = null;
         if(!this.FConfigNpc)
         {
            _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,91100006) as TConfigValue;
            this.FConfigNpc = _loc1_.Value as Vector.<uint>;
         }
         return this.FConfigNpc;
      }
      
      public function get ConfigArrInformationName() : String
      {
         var _loc1_:Vector.<Object> = null;
         var _loc2_:TConfigValue = null;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,91100005) as TConfigValue;
         _loc1_ = _loc2_.Value as Vector.<Object>;
         return String(_loc1_[0]);
      }
      
      public function get ConfigAllExp() : UInt64
      {
         var _loc1_:TConfigValue = null;
         if(!this.FConfigAllExp)
         {
            _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,91100004) as TConfigValue;
            this.FConfigAllExp = UInt64.ParseUInt64(String(_loc1_.Value));
         }
         return this.FConfigAllExp;
      }
      
      public function get BackpackCapacity() : uint
      {
         return this.FBackpackCapacity;
      }
      
      public function set BackpackCapacity(param1:uint) : void
      {
         this.FBackpackCapacity = param1;
      }
      
      public function get CurrentCapacity() : uint
      {
         return this.FCurrentCapacity;
      }
      
      public function set CurrentCapacity(param1:uint) : void
      {
         this.FCurrentCapacity = param1;
      }
      
      public function get BackpackExpandCount() : uint
      {
         return this.FBackpackExpandCount;
      }
      
      public function set BackpackExpandCount(param1:uint) : void
      {
         this.FBackpackExpandCount = param1;
      }
      
      public function get BackpackTemporaryCapacity() : uint
      {
         return this.FBackpackTemporaryCapacity;
      }
      
      public function set BackpackTemporaryCapacity(param1:uint) : void
      {
         this.FBackpackTemporaryCapacity = param1;
      }
      
      public function get OpenedBagCount() : uint
      {
         return this.FOpenedBagCount;
      }
      
      public function set OpenedBagCount(param1:uint) : void
      {
         this.FOpenedBagCount = param1;
      }
      
      public function get OpenedBagCountByLevel() : uint
      {
         return this.FOpenedBagCountByLevel;
      }
      
      public function set OpenedBagCountByLevel(param1:uint) : void
      {
         this.FOpenedBagCountByLevel = param1;
      }
      
      public function get Inventories() : TInventories
      {
         return this.FInventories;
      }
      
      public function GetBackpackByIndex(param1:int) : TInventories
      {
         return this.FBackpack[param1];
      }
      
      public function get Appliances() : TInventories
      {
         return this.FBackpack[INVENTORIESINDEX_Appliances];
      }
      
      public function get Equipments() : TInventories
      {
         return this.FBackpack[INVENTORIESINDEX_Equipments];
      }
      
      public function get Gems() : TInventories
      {
         return this.FBackpack[INVENTORIESINDEX_Gems];
      }
      
      public function get Treasures() : TInventories
      {
         return this.FBackpack[INVENTORIESINDEX_Treasures];
      }
      
      public function get Materials() : TInventories
      {
         return this.FBackpack[INVENTORIESINDEX_Materials];
      }
      
      public function get Accessories() : TInventories
      {
         return this.FBackpack[INVENTORIESINDEX_Accessories];
      }
      
      public function get TemporaryInventories() : TInventories
      {
         return this.FBackpack[INVENTORIESINDEX_Temporary];
      }
      
      public function get Medals() : TInventories
      {
         return this.FBackpack[INVENTORIESINDEX_Medals];
      }
      
      public function get AgentOperatorId() : uint
      {
         return this.FAgentOperatorId;
      }
      
      public function set AgentOperatorId(param1:uint) : void
      {
         this.FAgentOperatorId = param1;
      }
      
      public function get AgentUserId() : String
      {
         return this.FAgentUserId;
      }
      
      public function set AgentUserId(param1:String) : void
      {
         this.FAgentUserId = param1;
      }
      
      public function get ServerId() : uint
      {
         return this.FServerId;
      }
      
      public function set ServerId(param1:uint) : void
      {
         this.FServerId = param1;
      }
      
      public function get Prestige() : uint
      {
         return this.FPrestige;
      }
      
      public function set Prestige(param1:uint) : void
      {
         this.FPrestige = param1;
      }
      
      public function get MilitaryRank() : uint
      {
         return this.FMilitaryRank;
      }
      
      public function set MilitaryRank(param1:uint) : void
      {
         this.FMilitaryRank = param1;
      }
      
      public function get GeneralsSoul() : uint
      {
         return this.FGeneralsSoul;
      }
      
      public function set GeneralsSoul(param1:uint) : void
      {
         this.FGeneralsSoul = param1;
      }
      
      public function get VipLevel() : uint
      {
         return this.FVipData.VipLevel;
      }
      
      public function get ChatForbiddanceExpiration() : uint
      {
         return this.FChatForbiddanceExpiration;
      }
      
      public function set ChatForbiddanceExpiration(param1:uint) : void
      {
         this.FChatForbiddanceExpiration = param1;
      }
      
      public function get MaxStarLevel() : uint
      {
         return this.FMaxStarLevel;
      }
      
      public function set MaxStarLevel(param1:uint) : void
      {
         this.FMaxStarLevel = param1;
      }
      
      public function GetMainHero() : THero
      {
         return this.FHeros.GetHeroByIndex(0);
      }
      
      public function GetMainExperience() : UInt64
      {
         return this.FHeros.GetHeroByIndex(0).Experience;
      }
      
      public function GetMainLevel() : uint
      {
         return this.FHeros.GetHeroByIndex(0).Level;
      }
      
      public function GetMainLevelCopy() : uint
      {
         return this.FHeros.GetHeroByIndex(0).Level;
      }
      
      public function GetMainHeroLogicLevel(param1:int) : uint
      {
         if(param1 >= Ninja_Three_Reincarnation_Footstone)
         {
            param1 = Ninja_Reincarnation_Logic_ + Ninja_Reincarnation_Logic_Footstone * 2 + (param1 - Ninja_Three_Reincarnation_Footstone);
         }
         if(param1 >= Ninja_Two_Reincarnation_Footstone)
         {
            param1 = Ninja_Reincarnation_Logic_ + Ninja_Reincarnation_Logic_Footstone + (param1 - Ninja_Two_Reincarnation_Footstone);
         }
         else if(param1 >= Ninja_One_Reincarnation_Footstone)
         {
            param1 = Ninja_Reincarnation_Logic_ + (param1 - Ninja_One_Reincarnation_Footstone);
         }
         return param1;
      }
      
      public function GetMainLevelStr() : String
      {
         var _loc1_:String = "";
         if(this.FHeros.GetHeroByIndex(0).ReincarnationOneOrTwo > 0)
         {
            _loc1_ = TUtilityString.Format(STRING_NINJIAREINCARNATION.Reincarnation_Describe,this.FHeros.GetHeroByIndex(0).ReincarnationOneOrTwo,this.FHeros.GetHeroByIndex(0).ReincarnationLevel);
         }
         else
         {
            _loc1_ = String(this.FHeros.GetHeroByIndex(0).Level);
         }
         return _loc1_;
      }
      
      public function get Profession() : uint
      {
         return 0;
      }
      
      public function get MainQuestComplete() : TQuests
      {
         return this.FMainQuestComplete;
      }
      
      public function get SubQuestComplete() : TQuests
      {
         return this.FSubQuestComplete;
      }
      
      public function get MainQuestsAlreadyAccept() : TQuests
      {
         return this.FMainQuestsAlreadyAccept;
      }
      
      public function get SubQuestsAlreadyAccept() : TQuests
      {
         return this.FSubQuestsAlreadyAccept;
      }
      
      public function get MainQuestsCanAccept() : TQuests
      {
         return this.FMainQuestsCanAccept;
      }
      
      public function get SubQuestsCanAccept() : TQuests
      {
         return this.FSubQuestsCanAccept;
      }
      
      public function get RoleSencePosition() : int
      {
         return this.FRoleSencePosition;
      }
      
      public function set RoleSencePosition(param1:int) : void
      {
         this.FRoleSencePosition = param1;
      }
      
      public function get CurModuleID() : uint
      {
         return this.FCurModuleID;
      }
      
      public function set CurModuleID(param1:uint) : void
      {
         this.FCurModuleID = param1;
      }
      
      public function get FreshGuideProgress() : String
      {
         return this.FFreshGuideProgress;
      }
      
      public function set FreshGuideProgress(param1:String) : void
      {
         this.FFreshGuideProgress = param1;
      }
      
      public function get MilitaryBuyCount() : uint
      {
         return this.FMilitaryBuyCount;
      }
      
      public function set MilitaryBuyCount(param1:uint) : void
      {
         this.FMilitaryBuyCount = param1;
      }
      
      public function get InventorySamples() : TInventorySamples
      {
         return this.FInventorySamples;
      }
      
      public function set InventorySamples(param1:TInventorySamples) : void
      {
         this.FInventorySamples = param1;
      }
      
      public function get EsotericPoints() : TEsotericPoints
      {
         return this.FEsotericPoints;
      }
      
      public function set EsotericPoints(param1:TEsotericPoints) : void
      {
         this.FEsotericPoints = param1;
      }
      
      public function get TitleId() : uint
      {
         return this.FTitleId;
      }
      
      public function set TitleId(param1:uint) : void
      {
         this.FTitleId = param1;
      }
      
      public function get LittlePetId() : uint
      {
         return this.FLittlePetId;
      }
      
      public function set LittlePetId(param1:uint) : void
      {
         this.FLittlePetId = param1;
      }
      
      public function get CurVersionMastLevel() : uint
      {
         return this.FCurVersionMastLevel;
      }
      
      public function set CurVersionMastLevel(param1:uint) : void
      {
         this.FCurVersionMastLevel = param1;
      }
      
      public function get PageIndex() : uint
      {
         return this.FPageIndex;
      }
      
      public function set PageIndex(param1:uint) : void
      {
         this.FPageIndex = param1;
      }
      
      public function get MaxTempValue() : uint
      {
         return this.FMaxTempValue;
      }
      
      public function set MaxTempValue(param1:uint) : void
      {
         this.FMaxTempValue = param1;
      }
      
      public function get HeroIndex() : uint
      {
         return this.FHeroIndex;
      }
      
      public function set HeroIndex(param1:uint) : void
      {
         this.FHeroIndex = param1;
      }
      
      public function get XingDongLiMaxValue() : uint
      {
         return this.FXingDongLiMaxValue;
      }
      
      public function set XingDongLiMaxValue(param1:uint) : void
      {
         this.FXingDongLiMaxValue = param1;
      }
      
      public function GetConfigValueById(param1:uint) : int
      {
         var _loc2_:TConfigValue = null;
         var _loc3_:int = 0;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,param1) as TConfigValue;
         return _loc2_.Value as int;
      }
      
      public function set IsSkillShowTime(param1:Boolean) : void
      {
         this.FIsSkillShowTime = param1;
      }
      
      public function get IsSkillShowTime() : Boolean
      {
         return this.FIsSkillShowTime;
      }
      
      public function get Wing() : TWing
      {
         return this.FWing;
      }
      
      public function get Illustrated() : TIllustrated
      {
         return this.FIllustrated;
      }
      
      public function set Wing(param1:TWing) : void
      {
         this.FWing = param1;
      }
      
      public function set Illustrated(param1:TIllustrated) : void
      {
         this.FIllustrated = param1;
      }
      
      public function get SpecialJade() : TSpecialJade
      {
         return this.FSpecialJade;
      }
      
      public function set SpecialJade(param1:TSpecialJade) : void
      {
         this.FSpecialJade = param1;
      }
      
      public function get AwakenGeneralsSoul() : uint
      {
         return this.FAwakenGeneralsSoul;
      }
      
      public function set AwakenGeneralsSoul(param1:uint) : void
      {
         this.FAwakenGeneralsSoul = param1;
      }
      
      public function GetKingSoulByType(param1:int) : uint
      {
         switch(param1)
         {
            case 8:
               return this.FKingSouls[CONST_COMMON.KINGSOULINDEX_Common];
            case 9:
               return this.FKingSouls[CONST_COMMON.KINGSOULINDEX_Wind];
            case 10:
               return this.FKingSouls[CONST_COMMON.KINGSOULINDEX_Water];
            case 11:
               return this.FKingSouls[CONST_COMMON.KINGSOULINDEX_Dust];
            case 12:
               return this.FKingSouls[CONST_COMMON.KINGSOULINDEX_Thunder];
            case 13:
               return this.FKingSouls[CONST_COMMON.KINGSOULINDEX_Fire];
            case 14:
               return this.FKingSouls[CONST_COMMON.KINGSOULINDEX_Forth];
            case 15:
               return this.FKingSouls[CONST_COMMON.KINGSOULINDEX_First];
            default:
               return 0;
         }
      }
      
      public function SetKingSoulByType(param1:int, param2:int) : void
      {
         switch(param1)
         {
            case 8:
               this.FKingSouls[CONST_COMMON.KINGSOULINDEX_Common] = param2;
               break;
            case 9:
               this.FKingSouls[CONST_COMMON.KINGSOULINDEX_Wind] = param2;
               break;
            case 10:
               this.FKingSouls[CONST_COMMON.KINGSOULINDEX_Water] = param2;
               break;
            case 11:
               this.FKingSouls[CONST_COMMON.KINGSOULINDEX_Dust] = param2;
               break;
            case 12:
               this.FKingSouls[CONST_COMMON.KINGSOULINDEX_Thunder] = param2;
               break;
            case 13:
               this.FKingSouls[CONST_COMMON.KINGSOULINDEX_Fire] = param2;
               break;
            case 14:
               this.FKingSouls[CONST_COMMON.KINGSOULINDEX_Forth] = param2;
               break;
            case 15:
               this.FKingSouls[CONST_COMMON.KINGSOULINDEX_First] = param2;
         }
      }
      
      public function GetMainRoleModleID() : uint
      {
         var _loc1_:TRoleModel = null;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_RoleModel,this.FHeros.GetHeroByIndex(0).Identifier) as TRoleModel;
         return _loc1_.Model;
      }
      
      public function Reset() : void
      {
         var _loc1_:int = 0;
         this.FAgentOperatorId = 0;
         this.FAgentUserId = "";
         this.FServerId = 0;
         this.FNickName = "";
         this.FCountry = 0;
         this.FTownID = 0;
         this.FStarMapIndex = 0;
         this.FGeneralsSoul = 0;
         this.FAwakenGeneralsSoul = 0;
         _loc1_ = 0;
         while(_loc1_ < CAPACITY_Credits)
         {
            this.FCredits[_loc1_] = 0;
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < CAPACITY_HeroSouls)
         {
            this.FHeroSouls[_loc1_] = 0;
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this.FTimeCoolDowns.Count)
         {
            this.FTimeCoolDowns[_loc1_] = 0;
            _loc1_++;
         }
         this.FPrestige = 0;
         this.FMilitaryRank = 0;
         this.FVipData.Reset();
         this.FMainQuestsAlreadyAccept.Clear();
         this.FSubQuestsAlreadyAccept.Clear();
         this.FMainQuestsCanAccept.Clear();
         this.FSubQuestsCanAccept.Clear();
         this.FBuffsGlobalOptional.Clear();
         this.FBackpackCapacity = CAPACITY_Backpack;
         this.FBackpackExpandCount = 0;
         this.FBackpackTemporaryCapacity = CAPACITY_BackpackTemporary;
         this.FInventories.Clear();
         this.FAppliances.Clear();
         this.FEquipments.Clear();
         this.FGems.Clear();
         this.FTreasures.Clear();
         this.FMaterials.Clear();
         this.FTemporaryInventories.Clear();
         this.FInventorySamples.Clear();
         this.FAccessories.Clear();
         this.FMedals.Clear();
         this.FChatForbidden = false;
         this.FChatForbiddanceExpiration = 0;
         this.FMilitaryBuyCount = 0;
      }
   }
}

