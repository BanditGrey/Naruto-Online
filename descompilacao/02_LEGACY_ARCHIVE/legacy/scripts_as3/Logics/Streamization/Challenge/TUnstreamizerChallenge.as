package Logics.Streamization.Challenge
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Utilities.TUtilityString;
   import Logics.Challenge.TChallenge;
   import Logics.DatebaseVO.VO.Json.TChallengeReward;
   import Logics.DatebaseVO.VO.Json.TTaskReward;
   import Logics.DatebaseVO.VO.TChallengeDailyReward;
   import Logics.DatebaseVO.VO.TChallengeMall;
   import Logics.Exercise.ConsumeRank.TConsumeRankInfo;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.Inventories.TInventorySample;
   import Logics.Streamization.Inventories.TUnstreamizerInventory;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Logics.Streamization.Inventories.TUnstreamizerInventorySample;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerChallenge extends TUnstreamizerInventory
   {
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FUnstreamizerInventorySample:TUnstreamizerInventorySample;
      
      protected var FArticleBins:TBins;
      
      protected var FChallengeDailyRewardBins:TBins;
      
      protected var FChallengeMallBins:TBins;
      
      protected var FChallengeMonsterBins:TBins;
      
      protected var FChallengeWeekRewardBins:TBins;
      
      public function TUnstreamizerChallenge()
      {
         super();
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         this.FUnstreamizerInventorySample = new TUnstreamizerInventorySample();
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:TInventory = null;
         var _loc11_:TInventories = null;
         var _loc12_:TInventories = null;
         var _loc13_:uint = 0;
         var _loc14_:uint = 0;
         var _loc15_:uint = 0;
         var _loc16_:uint = 0;
         var _loc17_:int = 0;
         var _loc18_:int = 0;
         var _loc19_:int = 0;
         var _loc20_:int = 0;
         var _loc21_:Vector.<uint> = null;
         var _loc22_:Vector.<uint> = null;
         var _loc23_:TBaseBox = null;
         var _loc24_:Vector.<int> = null;
         var _loc25_:Vector.<int> = null;
         var _loc26_:Vector.<int> = null;
         var _loc27_:Vector.<int> = null;
         var _loc28_:TChallenge = null;
         var _loc29_:TConsumeRankInfo = null;
         var _loc30_:TChallengeMall = null;
         var _loc31_:TChallengeDailyReward = null;
         var _loc32_:TInventorySample = null;
         var _loc33_:TTaskReward = null;
         var _loc34_:TChallengeReward = null;
         _loc21_ = new Vector.<uint>();
         _loc22_ = new Vector.<uint>();
         _loc24_ = new Vector.<int>();
         _loc25_ = new Vector.<int>();
         _loc26_ = new Vector.<int>();
         _loc27_ = new Vector.<int>();
         _loc28_ = param2 as TChallenge;
         if(!this.FArticleBins)
         {
            this.FArticleBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         }
         if(!this.FChallengeDailyRewardBins)
         {
            this.FChallengeDailyRewardBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_ChallengeDailyReward);
         }
         if(!this.FChallengeMallBins)
         {
            this.FChallengeMallBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_ChallengeMall);
         }
         if(!this.FChallengeMonsterBins)
         {
            this.FChallengeMonsterBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_ChallengeMonster);
         }
         if(!this.FChallengeWeekRewardBins)
         {
            this.FChallengeWeekRewardBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_ChallengeWeekReward);
         }
         _loc28_.TotalList.length = 0;
         _loc28_.FrontList.length = 0;
         _loc7_ = int(param1.readUnsignedShort());
         _loc4_ = 0;
         while(_loc4_ < _loc7_)
         {
            _loc28_.FrontList[_loc4_] = param1.readUnsignedInt();
            _loc28_.TotalList.push(_loc28_.FrontList[_loc4_]);
            _loc4_++;
         }
         _loc28_.MiddleList.length = 0;
         _loc7_ = int(param1.readUnsignedShort());
         _loc4_ = 0;
         while(_loc4_ < _loc7_)
         {
            _loc28_.MiddleList[_loc4_] = param1.readUnsignedInt();
            _loc28_.TotalList.push(_loc28_.MiddleList[_loc4_]);
            _loc4_++;
         }
         _loc28_.BackList.length = 0;
         _loc7_ = int(param1.readUnsignedShort());
         _loc4_ = 0;
         while(_loc4_ < _loc7_)
         {
            _loc28_.BackList[_loc4_] = param1.readUnsignedInt();
            _loc28_.TotalList.push(_loc28_.BackList[_loc4_]);
            _loc4_++;
         }
         _loc28_.CurBoss = param1.readUnsignedInt();
         _loc28_.CurPrice = param1.readUnsignedInt();
         _loc28_.LimitCount = param1.readUnsignedInt();
         _loc28_.CurCount = param1.readUnsignedInt();
         _loc28_.ChallengeMax = param1.readUnsignedInt();
         _loc28_.TotalCount = param1.readUnsignedInt();
         _loc28_.BeginTime = param1.readUnsignedInt();
         _loc28_.EndTime = param1.readUnsignedInt();
         _loc28_.CurRank = param1.readUnsignedInt();
         _loc28_.Point = param1.readUnsignedInt();
         _loc28_.CurHurt = TUtilityString.FetchUTF(param1);
         _loc28_.RankList.length = 0;
         _loc7_ = int(param1.readUnsignedShort());
         _loc4_ = 0;
         while(_loc4_ < _loc7_)
         {
            _loc29_ = new TConsumeRankInfo();
            _loc29_.UserName = TUtilityString.FetchUTF(param1);
            _loc29_.FightPower.High = param1.readUnsignedInt();
            _loc29_.FightPower.Low = param1.readUnsignedInt();
            _loc29_.Level = param1.readUnsignedInt();
            _loc29_.Rank = param1.readUnsignedInt();
            _loc29_.Desc = TUtilityString.FetchUTF(param1);
            _loc29_.ServerID = TUtilityString.FetchUTF(param1);
            _loc28_.RankList[_loc4_] = _loc29_;
            _loc4_++;
         }
         _loc28_.InventorySamples.Clear();
         _loc7_ = int(param1.readUnsignedShort());
         _loc4_ = 0;
         while(_loc4_ < _loc7_)
         {
            _loc13_ = param1.readUnsignedInt();
            _loc30_ = this.FChallengeMallBins.GetDatebaseByIdentifier(_loc13_) as TChallengeMall;
            _loc32_ = FPoolInventory.AcquireInventorySample();
            this.FUnstreamizerInventorySample.UnstreamizeChallengeMallByDatabase(null,_loc32_,_loc30_);
            _loc32_.BuyTimes = param1.readInt();
            _loc32_.Amount = _loc30_.Amount;
            _loc28_.InventorySamples.Add(_loc32_);
            _loc4_++;
         }
         _loc28_.DailyReward.length = 0;
         _loc7_ = int(param1.readUnsignedShort());
         _loc4_ = 0;
         while(_loc4_ < _loc7_)
         {
            _loc13_ = param1.readUnsignedInt();
            _loc31_ = this.FChallengeDailyRewardBins.GetDatebaseByIdentifier(_loc13_) as TChallengeDailyReward;
            _loc23_ = new TBaseBox();
            _loc23_.Status = param1.readInt();
            _loc23_.Count = _loc31_.Times;
            _loc23_.Identify = _loc13_;
            _loc21_.length = 0;
            _loc22_.length = 0;
            _loc26_.length = 0;
            _loc27_.length = 0;
            _loc11_ = new TInventories();
            _loc8_ = int(_loc31_.Rewards.length);
            _loc5_ = 0;
            while(_loc5_ < _loc8_)
            {
               _loc33_ = _loc31_.Rewards[_loc5_];
               _loc15_ = _loc33_.Type;
               _loc14_ = _loc33_.Code;
               _loc13_ = CONST_COMMON.GetItemIDByType(_loc15_,_loc14_,this.FArticleBins);
               _loc21_.push(_loc13_);
               _loc22_.push(_loc33_.Amount);
               _loc26_.push(0);
               _loc27_.push(0);
               _loc5_++;
            }
            _loc8_ = int(_loc31_.Rewards1.length);
            _loc5_ = 0;
            while(_loc5_ < _loc8_)
            {
               _loc34_ = _loc31_.Rewards1[_loc5_];
               _loc15_ = _loc34_.Type;
               _loc14_ = _loc34_.Code;
               _loc13_ = CONST_COMMON.GetItemIDByType(_loc15_,_loc14_,this.FArticleBins);
               _loc21_.push(_loc13_);
               _loc22_.push(0);
               _loc26_.push(_loc34_.Min);
               _loc27_.push(_loc34_.Max);
               _loc5_++;
            }
            this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc11_,_loc21_);
            _loc5_ = 0;
            while(_loc5_ < _loc21_.length)
            {
               _loc10_ = _loc11_.GetInventoryByIndex(_loc5_);
               _loc10_.Quantity = _loc22_[_loc5_];
               _loc10_.MinPrice = _loc26_[_loc5_];
               _loc10_.MaxPrice = _loc27_[_loc5_];
               _loc5_++;
            }
            _loc23_.Inventories = _loc11_;
            _loc28_.DailyReward[_loc4_] = _loc23_;
            _loc4_++;
         }
      }
      
      override public function Unstreamize(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform(param1,param2,param3);
      }
   }
}

