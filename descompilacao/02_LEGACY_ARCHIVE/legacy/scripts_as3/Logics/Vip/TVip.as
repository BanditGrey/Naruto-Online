package Logics.Vip
{
   import Logics.DatebaseVO.VO.Json.TSignForReward;
   import Logics.Spaces.LogicsSpace;
   
   use namespace LogicsSpace;
   
   public class TVip
   {
      
      protected var FVipLevel:uint;
      
      protected var FVipExp:uint;
      
      protected var FRequirementNextExp:uint;
      
      protected var FVipLevelUpperLimit:uint;
      
      protected var FChargeCount:int;
      
      protected var FHigherDrink:Boolean;
      
      protected var FDailyChicket:int;
      
      protected var FFreeLook:Boolean;
      
      protected var FBlockTime:Boolean;
      
      protected var FStonePecent:Boolean;
      
      protected var FSkipBlock:Boolean;
      
      protected var FBagCount:int;
      
      protected var FActionLimit:int;
      
      protected var FBuyActionLimit:int;
      
      protected var FDailySingleReset:int;
      
      protected var FDailyChaReset:int;
      
      protected var FSkipChargeFight:Boolean;
      
      protected var FOneWine:Boolean;
      
      protected var FOneWinWine:Boolean;
      
      protected var FMoreChange:Boolean;
      
      protected var FDailyChangeNum:int;
      
      protected var FArenaSkip:Boolean;
      
      protected var FSevenKingSkip:Boolean;
      
      protected var FOneTimePet:Boolean;
      
      protected var FOneTimeTrain:Boolean;
      
      protected var FOneWater:Boolean;
      
      protected var FAutoBuyAct:Boolean;
      
      protected var FBossFightUp:Boolean;
      
      protected var FOneTimeWash:Boolean;
      
      protected var FMonsterOneTime:Boolean;
      
      protected var FStoneOneTime:Boolean;
      
      protected var FDigging:Boolean;
      
      protected var FChangeBuyNum:int;
      
      protected var FDailyReward:TSignForReward;
      
      protected var FBuyEquipMaterial:Boolean;
      
      protected var FBuyOrnamentMaterial:Boolean;
      
      protected var FAddNinjaHostel:uint;
      
      protected var FAddFollowBloodBoundAutoSell:uint;
      
      protected var FAddFollowBloodBoundAutoSynthesis:uint;
      
      protected var FVipOpenLevel_HigherDrink:uint;
      
      protected var FVipOpenLevel_FreeLook:uint;
      
      protected var FVipOpenLevel_BlockTime:uint;
      
      protected var FVipOpenLevel_StonePecent:uint;
      
      protected var FVipOpenLevel_SkipBlock:uint;
      
      protected var FVipOpenLevel_DailySingleReset:uint;
      
      protected var FVipOpenLevel_DailyChaReset:uint;
      
      protected var FVipOpenLevel_SkipChargeFight:uint;
      
      protected var FVipOpenLevel_OneWine:uint;
      
      protected var FVipOpenLevel_OneWinWine:uint;
      
      protected var FVipOpenLevel_MoreChange:uint;
      
      protected var FVipOpenLevel_ArenaSkip:uint;
      
      protected var FVipOpenLevel_SevenKingSkip:uint;
      
      protected var FVipOpenLevel_OneTimePet:uint;
      
      protected var FVipOpenLevel_OneTimeTrain:uint;
      
      protected var FVipOpenLevel_OneWater:uint;
      
      protected var FVipOpenLevel_AutoBuyAct:uint;
      
      protected var FVipOpenLevel_BossFightUp:uint;
      
      protected var FVipOpenLevel_OneTimeWash:uint;
      
      protected var FVipOpenLevel_MonsterOneTime:uint;
      
      protected var FVipOpenLevel_StoneOneTime:uint;
      
      protected var FVipOpenLevel_Digging:uint;
      
      protected var FVipOpenLevel_TeamerExpand:uint;
      
      protected var FVipOpenLevel_AutoSingle:uint;
      
      protected var FVipOpenLevel_TowerLife:uint;
      
      protected var FVipOpenLevel_TowerDiscover:uint;
      
      protected var FVipOpenLevel_BuyEquipMaterial:uint;
      
      protected var FVipOpenLevel_BuyOrnamentMaterial:uint;
      
      protected var FVipOpenLevel_FollowBloodBoundAutoSell:uint;
      
      protected var FVipOpenLevel_FollowBloodBoundAutoSynthesis:uint;
      
      public function TVip()
      {
         super();
      }
      
      LogicsSpace function CoerceProperties(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int, param8:int, param9:int, param10:int, param11:int, param12:int, param13:int, param14:int, param15:int, param16:int, param17:int, param18:int, param19:int, param20:int, param21:int, param22:int, param23:int, param24:int, param25:int, param26:int, param27:int, param28:int, param29:int, param30:TSignForReward, param31:int, param32:int, param33:int, param34:int, param35:int) : void
      {
         this.FChargeCount = param1;
         this.FHigherDrink = Boolean(param2);
         this.FDailyChicket = param3;
         this.FFreeLook = Boolean(param4);
         this.FBlockTime = Boolean(param5);
         this.FStonePecent = Boolean(param6);
         this.FSkipBlock = Boolean(param7);
         this.FBagCount = param8;
         this.FActionLimit = param9;
         this.FBuyActionLimit = param10;
         this.FDailySingleReset = param11;
         this.FDailyChaReset = param12;
         this.FSkipChargeFight = Boolean(param13);
         this.FOneWine = Boolean(param14);
         this.FOneWinWine = Boolean(param15);
         this.FMoreChange = Boolean(param16);
         this.FDailyChangeNum = param17;
         this.FArenaSkip = Boolean(param18);
         this.FSevenKingSkip = Boolean(param19);
         this.FOneTimePet = Boolean(param20);
         this.FOneTimeTrain = Boolean(param21);
         this.FOneWater = Boolean(param22);
         this.FAutoBuyAct = Boolean(param23);
         this.FBossFightUp = Boolean(param24);
         this.FOneTimeWash = Boolean(param25);
         this.FMonsterOneTime = Boolean(param26);
         this.FStoneOneTime = Boolean(param27);
         this.FDigging = Boolean(param28);
         this.FChangeBuyNum = param29;
         this.FDailyReward = param30;
         this.FBuyEquipMaterial = Boolean(param31);
         this.FBuyOrnamentMaterial = Boolean(param32);
         this.FAddNinjaHostel = param33;
         this.FAddFollowBloodBoundAutoSell = param34;
         this.FAddFollowBloodBoundAutoSynthesis = param35;
      }
      
      LogicsSpace function CoercePropertieVipLevel(param1:int) : void
      {
         this.FVipLevel = param1;
      }
      
      LogicsSpace function CoercePropertieVipExp(param1:int) : void
      {
         this.FVipExp = param1;
      }
      
      LogicsSpace function CoercePropertieVipNexpLevelExp(param1:int) : void
      {
         this.FRequirementNextExp = param1;
      }
      
      LogicsSpace function CoercePropertieVipLevelUpperLimit(param1:int) : void
      {
         this.FVipLevelUpperLimit = param1;
      }
      
      LogicsSpace function CoercePropertieBagCount(param1:int) : void
      {
         this.FBagCount = param1;
      }
      
      LogicsSpace function CoercePropertieActionLimit(param1:int) : void
      {
         this.FActionLimit = param1;
      }
      
      LogicsSpace function CoercePropertieVipOpenLevel(param1:uint, param2:uint, param3:uint, param4:uint, param5:uint, param6:uint, param7:uint, param8:uint, param9:uint, param10:uint, param11:uint, param12:uint, param13:uint, param14:uint, param15:uint, param16:uint, param17:uint, param18:uint, param19:uint, param20:uint, param21:uint, param22:uint, param23:uint, param24:uint, param25:uint, param26:uint, param27:int, param28:int, param29:int, param30:int) : void
      {
         this.FVipOpenLevel_HigherDrink = param1;
         this.FVipOpenLevel_FreeLook = param2;
         this.FVipOpenLevel_BlockTime = param3;
         this.FVipOpenLevel_StonePecent = param4;
         this.FVipOpenLevel_SkipBlock = param5;
         this.FVipOpenLevel_DailySingleReset = param6;
         this.FVipOpenLevel_DailyChaReset = param7;
         this.FVipOpenLevel_SkipChargeFight = param8;
         this.FVipOpenLevel_OneWine = param9;
         this.FVipOpenLevel_OneWinWine = param10;
         this.FVipOpenLevel_MoreChange = param11;
         this.FVipOpenLevel_ArenaSkip = param12;
         this.FVipOpenLevel_SevenKingSkip = param13;
         this.FVipOpenLevel_OneTimePet = param14;
         this.FVipOpenLevel_OneTimeTrain = param15;
         this.FVipOpenLevel_OneWater = param16;
         this.FVipOpenLevel_AutoBuyAct = param17;
         this.FVipOpenLevel_BossFightUp = param18;
         this.FVipOpenLevel_OneTimeWash = param19;
         this.FVipOpenLevel_MonsterOneTime = param20;
         this.FVipOpenLevel_StoneOneTime = param21;
         this.FVipOpenLevel_Digging = param22;
         this.FVipOpenLevel_TeamerExpand = param23;
         this.FVipOpenLevel_AutoSingle = param24;
         this.FVipOpenLevel_TowerLife = param25;
         this.FVipOpenLevel_TowerDiscover = param26;
         this.FVipOpenLevel_BuyEquipMaterial = param27;
         this.FVipOpenLevel_BuyOrnamentMaterial = param28;
         this.FVipOpenLevel_FollowBloodBoundAutoSell = param29;
         this.FVipOpenLevel_FollowBloodBoundAutoSynthesis = param30;
      }
      
      public function get VipLevel() : uint
      {
         return this.FVipLevel;
      }
      
      public function get VipExp() : uint
      {
         return this.FVipExp;
      }
      
      public function get RequirementNextExp() : uint
      {
         return this.FRequirementNextExp;
      }
      
      public function get VipLevelUpperLimit() : uint
      {
         return this.FVipLevelUpperLimit;
      }
      
      public function get ChargeCount() : int
      {
         return this.FChargeCount;
      }
      
      public function get HigherDrink() : Boolean
      {
         return this.FHigherDrink;
      }
      
      public function get DailyChicket() : int
      {
         return this.FDailyChicket;
      }
      
      public function get FreeLook() : Boolean
      {
         return this.FFreeLook;
      }
      
      public function get BlockTime() : Boolean
      {
         return this.FBlockTime;
      }
      
      public function get StonePecent() : Boolean
      {
         return this.FStonePecent;
      }
      
      public function get SkipBlock() : Boolean
      {
         return this.FSkipBlock;
      }
      
      public function get BagCount() : int
      {
         return this.FBagCount;
      }
      
      public function get ActionLimit() : int
      {
         return this.FActionLimit;
      }
      
      public function get BuyActionLimit() : int
      {
         return this.FBuyActionLimit;
      }
      
      public function get DailySingleReset() : int
      {
         return this.FDailySingleReset;
      }
      
      public function get DailyChaReset() : int
      {
         return this.FDailyChaReset;
      }
      
      public function get SkipChargeFight() : Boolean
      {
         return this.FSkipChargeFight;
      }
      
      public function get OneWine() : Boolean
      {
         return this.FOneWine;
      }
      
      public function get OneWinWine() : Boolean
      {
         return this.FOneWinWine;
      }
      
      public function get MoreChange() : Boolean
      {
         return this.FMoreChange;
      }
      
      public function get DailyChangeNum() : int
      {
         return this.FDailyChangeNum;
      }
      
      public function get ArenaSkip() : Boolean
      {
         return this.FArenaSkip;
      }
      
      public function get SevenKingSkip() : Boolean
      {
         return this.FSevenKingSkip;
      }
      
      public function get OneTimePet() : Boolean
      {
         return this.FOneTimePet;
      }
      
      public function get OneTimeTrain() : Boolean
      {
         return this.FOneTimeTrain;
      }
      
      public function get OneWater() : Boolean
      {
         return this.FOneWater;
      }
      
      public function get AutoBuyAct() : Boolean
      {
         return this.FAutoBuyAct;
      }
      
      public function get BossFightUp() : Boolean
      {
         return this.FBossFightUp;
      }
      
      public function get OneTimeWash() : Boolean
      {
         return this.FOneTimeWash;
      }
      
      public function get MonsterOneTime() : Boolean
      {
         return this.FMonsterOneTime;
      }
      
      public function get StoneOneTime() : Boolean
      {
         return this.FStoneOneTime;
      }
      
      public function get Digging() : Boolean
      {
         return this.FDigging;
      }
      
      public function get ChangeBuyNum() : int
      {
         return this.FChangeBuyNum;
      }
      
      public function get BuyEquipMaterial() : Boolean
      {
         return this.FBuyEquipMaterial;
      }
      
      public function get BuyOrnamentMaterial() : Boolean
      {
         return this.FBuyOrnamentMaterial;
      }
      
      public function get AddNinjaHostel() : int
      {
         return this.FAddNinjaHostel;
      }
      
      public function get AddFollowBloodBoundAutoSell() : int
      {
         return this.FAddFollowBloodBoundAutoSell;
      }
      
      public function get AddFollowBloodBoundAutoSynthesis() : int
      {
         return this.FAddFollowBloodBoundAutoSynthesis;
      }
      
      public function get VipOpenLevel_HigherDrink() : int
      {
         return this.FVipOpenLevel_HigherDrink;
      }
      
      public function get VipOpenLevel_FreeLook() : int
      {
         return this.FVipOpenLevel_FreeLook;
      }
      
      public function get VipOpenLevel_BlockTime() : int
      {
         return this.FVipOpenLevel_BlockTime;
      }
      
      public function get VipOpenLevel_StonePecent() : int
      {
         return this.FVipOpenLevel_StonePecent;
      }
      
      public function get VipOpenLevel_SkipBlock() : int
      {
         return this.FVipOpenLevel_SkipBlock;
      }
      
      public function get VipOpenLevel_DailySingleReset() : int
      {
         return this.FVipOpenLevel_DailySingleReset;
      }
      
      public function get VipOpenLevel_DailyChaReset() : int
      {
         return this.FVipOpenLevel_DailyChaReset;
      }
      
      public function get VipOpenLevel_SkipChargeFight() : int
      {
         return this.FVipOpenLevel_SkipChargeFight;
      }
      
      public function get VipOpenLevel_OneWine() : int
      {
         return this.FVipOpenLevel_OneWine;
      }
      
      public function get VipOpenLevel_OneWinWine() : int
      {
         return this.FVipOpenLevel_OneWinWine;
      }
      
      public function get VipOpenLevel_MoreChange() : int
      {
         return this.FVipOpenLevel_MoreChange;
      }
      
      public function get VipOpenLevel_ArenaSkip() : int
      {
         return this.FVipOpenLevel_ArenaSkip;
      }
      
      public function get VipOpenLevel_SevenKingSkip() : int
      {
         return this.FVipOpenLevel_SevenKingSkip;
      }
      
      public function get VipOpenLevel_OneTimePet() : int
      {
         return this.FVipOpenLevel_OneTimePet;
      }
      
      public function get VipOpenLevel_OneTimeTrain() : int
      {
         return this.FVipOpenLevel_OneTimeTrain;
      }
      
      public function get VipOpenLevel_OneWater() : int
      {
         return this.FVipOpenLevel_OneWater;
      }
      
      public function get VipOpenLevel_AutoBuyAct() : int
      {
         return this.FVipOpenLevel_AutoBuyAct;
      }
      
      public function get VipOpenLevel_BossFightUp() : int
      {
         return this.FVipOpenLevel_BossFightUp;
      }
      
      public function get VipOpenLevel_OneTimeWash() : int
      {
         return this.FVipOpenLevel_OneTimeWash;
      }
      
      public function get VipOpenLevel_MonsterOneTime() : int
      {
         return this.FVipOpenLevel_MonsterOneTime;
      }
      
      public function get VipOpenLevel_StoneOneTime() : int
      {
         return this.FVipOpenLevel_StoneOneTime;
      }
      
      public function get VipOpenLevel_Digging() : int
      {
         return this.FVipOpenLevel_Digging;
      }
      
      public function get VipOpenLevel_TeamerExpand() : int
      {
         return this.FVipOpenLevel_TeamerExpand;
      }
      
      public function get VipOpenLevel_AutoSingle() : int
      {
         return this.FVipOpenLevel_AutoSingle;
      }
      
      public function get VipOpenLevel_TowerLife() : int
      {
         return this.FVipOpenLevel_TowerLife;
      }
      
      public function get VipOpenLevel_TowerDiscover() : int
      {
         return this.FVipOpenLevel_TowerDiscover;
      }
      
      public function get DailyReward() : TSignForReward
      {
         return this.FDailyReward;
      }
      
      public function get VipOpenLevel_BuyEquipMaterial() : int
      {
         return this.FVipOpenLevel_BuyEquipMaterial;
      }
      
      public function get VipOpenLevel_BuyOrnamentMaterial() : int
      {
         return this.FVipOpenLevel_BuyOrnamentMaterial;
      }
      
      public function get VipOpenLevel_FollowBloodBoundAutoSell() : int
      {
         return this.FVipOpenLevel_FollowBloodBoundAutoSell;
      }
      
      public function get VipOpenLevel_FollowBloodBoundAutoSynthesis() : int
      {
         return this.FVipOpenLevel_FollowBloodBoundAutoSynthesis;
      }
      
      public function Reset() : void
      {
         this.FChargeCount = 0;
         this.FHigherDrink = false;
         this.FDailyChicket = 0;
         this.FFreeLook = false;
         this.FBlockTime = false;
         this.FStonePecent = false;
         this.FSkipBlock = false;
         this.FBagCount = 0;
         this.FActionLimit = 0;
         this.FBuyActionLimit = 0;
         this.FDailySingleReset = 0;
         this.FDailyChaReset = 0;
         this.FSkipChargeFight = false;
         this.FOneWine = false;
         this.FOneWinWine = false;
         this.FMoreChange = false;
         this.FDailyChangeNum = 0;
         this.FArenaSkip = false;
         this.FSevenKingSkip = false;
         this.FOneTimePet = false;
         this.FOneTimeTrain = false;
         this.FOneWater = false;
         this.FAutoBuyAct = false;
         this.FBossFightUp = false;
         this.FOneTimeWash = false;
         this.FMonsterOneTime = false;
         this.FStoneOneTime = false;
         this.FDigging = false;
         this.FChangeBuyNum = 0;
         this.FBuyEquipMaterial = false;
         this.FBuyOrnamentMaterial = false;
         this.FAddNinjaHostel = 0;
      }
   }
}

