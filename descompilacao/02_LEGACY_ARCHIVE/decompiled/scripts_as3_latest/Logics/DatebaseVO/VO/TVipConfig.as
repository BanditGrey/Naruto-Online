package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import Logics.DatebaseVO.VO.Json.TSignForReward;
   import flash.utils.ByteArray;
   
   use namespace ResourcesSpace;
   
   public class TVipConfig extends TDatebaseVO
   {
      
      protected var FChargeCount:int;
      
      protected var FHigherDrink:int;
      
      protected var FDailyChicket:int;
      
      protected var FFreeLook:int;
      
      protected var FBlockTime:int;
      
      protected var FStonePecent:int;
      
      protected var FSkipBlock:int;
      
      protected var FBagCount:int;
      
      protected var FActionLimit:int;
      
      protected var FBuyActionLimit:int;
      
      protected var FDailySingleReset:int;
      
      protected var FDailyChaReset:int;
      
      protected var FSkipChargeFight:int;
      
      protected var FOneWine:int;
      
      protected var FOneWinWine:int;
      
      protected var FMoreChange:int;
      
      protected var FDailyChangeNum:int;
      
      protected var FArenaSkip:int;
      
      protected var FOneTimePet:int;
      
      protected var FOneTimeTrain:int;
      
      protected var FOneWater:int;
      
      protected var FAutoBuyAct:int;
      
      protected var FBossFightUp:int;
      
      protected var FOneTimeWash:int;
      
      protected var FMonsterOneTime:int;
      
      protected var FStoneOneTime:int;
      
      protected var FDigging:int;
      
      protected var FChangeBuyNum:int;
      
      protected var FSevenHeroCount:int;
      
      protected var FSevenHeroOneKey:int;
      
      protected var FSkipSevenHeroFight:int;
      
      protected var FAutoJoinActivity:int;
      
      protected var FTeamerExpand:int;
      
      protected var FAutoSingle:int;
      
      protected var FTowerLife:int;
      
      protected var FTowerDiscover:int;
      
      protected var FDailyReward:TSignForReward;
      
      protected var FAutoSignOrgBattle:int;
      
      protected var FBuyEquipMaterial:int;
      
      protected var FBuyOrnamentMaterial:int;
      
      protected var FAddNinjaHostel:int;
      
      protected var FAddFollowBloodBoundAutoSell:int;
      
      protected var FAddFollowBloodBoundAutoSynthesis:int;
      
      protected var FDungeonsRefresh:int;
      
      protected var FLostsacredRefresh:int;
      
      protected var FDailyAward:String;
      
      protected var FAddEightInnerGatesTimes:int;
      
      protected var FAddGodTreeProduced:int;
      
      protected var FContinuousChallenge:int;
      
      protected var FWingBattleRefresh:int;
      
      public function TVipConfig()
      {
         super();
      }
      
      override ResourcesSpace function ReadDataByXml(param1:XML) : void
      {
         var _loc2_:XML = null;
         var _loc3_:String = null;
         var _loc4_:* = undefined;
         var _loc5_:uint = 0;
         var _loc6_:int = 0;
         _loc5_ = uint(param1.elements().length());
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc2_ = param1.elements()[_loc6_];
            _loc3_ = String(_loc2_.name());
            _loc4_ = _loc2_;
            if(_loc3_ == "id")
            {
               Coerce(uint(_loc4_));
            }
            else
            {
               _loc3_ = "F" + _loc3_;
               if(hasOwnProperty(_loc3_))
               {
                  this[_loc3_] = _loc4_;
               }
               else
               {
                  if(Count_AttributeName.indexOf(_loc3_.slice(1,2)) < 0)
                  {
                     _loc3_ = "F" + _loc3_.slice(1,2).toLocaleUpperCase() + _loc3_.slice(2);
                  }
                  if(hasOwnProperty(_loc3_.slice(1)))
                  {
                     if(this[_loc3_] is Boolean)
                     {
                        this[_loc3_] = Boolean(int(_loc4_));
                     }
                     else
                     {
                        this[_loc3_] = _loc4_;
                     }
                  }
               }
            }
            _loc6_++;
         }
      }
      
      override ResourcesSpace function WriteDataToStream(param1:ByteArray) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         param1.writeUnsignedInt(FIdentifier);
         param1.writeUnsignedInt(this.FChargeCount);
         param1.writeUnsignedInt(this.FHigherDrink);
         param1.writeUnsignedInt(this.FDailyChicket);
         param1.writeUnsignedInt(this.FFreeLook);
         param1.writeUnsignedInt(this.FBlockTime);
         param1.writeUnsignedInt(this.FStonePecent);
         param1.writeUnsignedInt(this.FSkipBlock);
         param1.writeUnsignedInt(this.FBagCount);
         param1.writeUnsignedInt(this.FActionLimit);
         param1.writeUnsignedInt(this.FBuyActionLimit);
         param1.writeUnsignedInt(this.FDailySingleReset);
         param1.writeUnsignedInt(this.FDailyChaReset);
         param1.writeUnsignedInt(this.FSkipChargeFight);
         param1.writeUnsignedInt(this.FOneWine);
         param1.writeUnsignedInt(this.FOneWinWine);
         param1.writeUnsignedInt(this.FMoreChange);
         param1.writeUnsignedInt(this.FDailyChangeNum);
         param1.writeUnsignedInt(this.FArenaSkip);
         param1.writeUnsignedInt(this.FOneTimePet);
         param1.writeUnsignedInt(this.FOneTimeTrain);
         param1.writeUnsignedInt(this.FOneWater);
         param1.writeUnsignedInt(this.FAutoBuyAct);
         param1.writeUnsignedInt(this.FBossFightUp);
         param1.writeUnsignedInt(this.FOneTimeWash);
         param1.writeUnsignedInt(this.FMonsterOneTime);
         param1.writeUnsignedInt(this.FStoneOneTime);
         param1.writeUnsignedInt(this.FDigging);
         param1.writeUnsignedInt(this.FChangeBuyNum);
         param1.writeUnsignedInt(this.FSevenHeroCount);
         param1.writeUnsignedInt(this.FSevenHeroOneKey);
         param1.writeUnsignedInt(this.FSkipSevenHeroFight);
         param1.writeUnsignedInt(this.FAutoJoinActivity);
         param1.writeUnsignedInt(this.FTeamerExpand);
         param1.writeUnsignedInt(this.FAutoSingle);
         param1.writeUnsignedInt(this.FTowerLife);
         param1.writeUnsignedInt(this.FTowerDiscover);
         TUtilityString.FlushUTF(param1,this.FDailyAward);
         param1.writeUnsignedInt(this.FAutoSignOrgBattle);
         param1.writeUnsignedInt(this.FBuyEquipMaterial);
         param1.writeUnsignedInt(this.FBuyOrnamentMaterial);
         param1.writeUnsignedInt(this.FAddNinjaHostel);
         param1.writeUnsignedInt(this.FAddFollowBloodBoundAutoSell);
         param1.writeUnsignedInt(this.FAddFollowBloodBoundAutoSynthesis);
         param1.writeUnsignedInt(this.FAddEightInnerGatesTimes);
         param1.writeUnsignedInt(this.FContinuousChallenge);
         param1.writeUnsignedInt(this.FDungeonsRefresh);
         param1.writeUnsignedInt(this.FLostsacredRefresh);
         param1.writeUnsignedInt(this.FWingBattleRefresh);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         this.FChargeCount = param1.readUnsignedInt();
         this.FHigherDrink = param1.readUnsignedInt();
         this.FDailyChicket = param1.readUnsignedInt();
         this.FFreeLook = param1.readUnsignedInt();
         this.FBlockTime = param1.readUnsignedInt();
         this.FStonePecent = param1.readUnsignedInt();
         this.FSkipBlock = param1.readUnsignedInt();
         this.FBagCount = param1.readUnsignedInt();
         this.FActionLimit = param1.readUnsignedInt();
         this.FBuyActionLimit = param1.readUnsignedInt();
         this.FDailySingleReset = param1.readUnsignedInt();
         this.FDailyChaReset = param1.readUnsignedInt();
         this.FSkipChargeFight = param1.readUnsignedInt();
         this.FOneWine = param1.readUnsignedInt();
         this.FOneWinWine = param1.readUnsignedInt();
         this.FMoreChange = param1.readUnsignedInt();
         this.FDailyChangeNum = param1.readUnsignedInt();
         this.FArenaSkip = param1.readUnsignedInt();
         this.FOneTimePet = param1.readUnsignedInt();
         this.FOneTimeTrain = param1.readUnsignedInt();
         this.FOneWater = param1.readUnsignedInt();
         this.FAutoBuyAct = param1.readUnsignedInt();
         this.FBossFightUp = param1.readUnsignedInt();
         this.FOneTimeWash = param1.readUnsignedInt();
         this.FMonsterOneTime = param1.readUnsignedInt();
         this.FStoneOneTime = param1.readUnsignedInt();
         this.FDigging = param1.readUnsignedInt();
         this.FChangeBuyNum = param1.readUnsignedInt();
         this.FSevenHeroCount = param1.readUnsignedInt();
         this.FSevenHeroOneKey = param1.readUnsignedInt();
         this.FSkipSevenHeroFight = param1.readUnsignedInt();
         this.FAutoJoinActivity = param1.readUnsignedInt();
         this.FTeamerExpand = param1.readUnsignedInt();
         this.FAutoSingle = param1.readUnsignedInt();
         this.FTowerLife = param1.readUnsignedInt();
         this.FTowerDiscover = param1.readUnsignedInt();
         this.FDailyAward = TUtilityString.FetchUTF(param1);
         this.FDailyReward = new TSignForReward(this.FDailyAward);
         this.FAutoSignOrgBattle = param1.readUnsignedInt();
         this.FBuyEquipMaterial = param1.readUnsignedInt();
         this.FBuyOrnamentMaterial = param1.readUnsignedInt();
         this.FAddNinjaHostel = param1.readUnsignedInt();
         this.FAddFollowBloodBoundAutoSell = param1.readUnsignedInt();
         this.FAddFollowBloodBoundAutoSynthesis = param1.readUnsignedInt();
         this.FAddEightInnerGatesTimes = param1.readUnsignedInt();
         this.FContinuousChallenge = param1.readUnsignedInt();
         this.FDungeonsRefresh = param1.readUnsignedInt();
         this.FLostsacredRefresh = param1.readUnsignedInt();
         this.FWingBattleRefresh = param1.readUnsignedInt();
      }
      
      public function get ChargeCount() : int
      {
         return this.FChargeCount;
      }
      
      public function get HigherDrink() : int
      {
         return this.FHigherDrink;
      }
      
      public function get DailyChicket() : int
      {
         return this.FDailyChicket;
      }
      
      public function get FreeLook() : int
      {
         return this.FFreeLook;
      }
      
      public function get BlockTime() : int
      {
         return this.FBlockTime;
      }
      
      public function get StonePecent() : int
      {
         return this.FStonePecent;
      }
      
      public function get SkipBlock() : int
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
      
      public function get SkipChargeFight() : int
      {
         return this.FSkipChargeFight;
      }
      
      public function get OneWine() : int
      {
         return this.FOneWine;
      }
      
      public function get OneWinWine() : int
      {
         return this.FOneWinWine;
      }
      
      public function get MoreChange() : int
      {
         return this.FMoreChange;
      }
      
      public function get DailyChangeNum() : int
      {
         return this.FDailyChangeNum;
      }
      
      public function get ArenaSkip() : int
      {
         return this.FArenaSkip;
      }
      
      public function get OneTimePet() : int
      {
         return this.FOneTimePet;
      }
      
      public function get OneTimeTrain() : int
      {
         return this.FOneTimeTrain;
      }
      
      public function get OneWater() : int
      {
         return this.FOneWater;
      }
      
      public function get AutoBuyAct() : int
      {
         return this.FAutoBuyAct;
      }
      
      public function get BossFightUp() : int
      {
         return this.FBossFightUp;
      }
      
      public function get OneTimeWash() : int
      {
         return this.FOneTimeWash;
      }
      
      public function get MonsterOneTime() : int
      {
         return this.FMonsterOneTime;
      }
      
      public function get StoneOneTime() : int
      {
         return this.FStoneOneTime;
      }
      
      public function get Digging() : int
      {
         return this.FDigging;
      }
      
      public function get ChangeBuyNum() : int
      {
         return this.FChangeBuyNum;
      }
      
      public function get SevenHeroCount() : int
      {
         return this.FSevenHeroCount;
      }
      
      public function get SevenHeroOneKey() : int
      {
         return this.FSevenHeroOneKey;
      }
      
      public function get SkipSevenHeroFight() : int
      {
         return this.FSkipSevenHeroFight;
      }
      
      public function get AutoJoinActivity() : int
      {
         return this.FAutoJoinActivity;
      }
      
      public function get TeamerExpand() : int
      {
         return this.FTeamerExpand;
      }
      
      public function get AutoSingle() : int
      {
         return this.FAutoSingle;
      }
      
      public function get TowerLife() : int
      {
         return this.FTowerLife;
      }
      
      public function get TowerDiscover() : int
      {
         return this.FTowerDiscover;
      }
      
      public function get DailyAward() : String
      {
         return this.FDailyAward;
      }
      
      public function get DailyReward() : TSignForReward
      {
         return this.FDailyReward;
      }
      
      public function get AutoSignOrgBattle() : int
      {
         return this.FAutoSignOrgBattle;
      }
      
      public function get BuyEquipMaterial() : int
      {
         return this.FBuyEquipMaterial;
      }
      
      public function get BuyOrnamentMaterial() : int
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
      
      public function get AddEightInnerGatesTimes() : int
      {
         return this.FAddEightInnerGatesTimes;
      }
      
      public function get DungeonsRefresh() : uint
      {
         return this.FDungeonsRefresh;
      }
      
      public function get LostsacredRefresh() : uint
      {
         return this.FLostsacredRefresh;
      }
      
      public function get ContinuousChallenge() : int
      {
         return this.FContinuousChallenge;
      }
      
      public function get AddGodTreeProduced() : int
      {
         return this.FAddGodTreeProduced;
      }
      
      public function get WingBattleRefresh() : int
      {
         return this.FWingBattleRefresh;
      }
   }
}

