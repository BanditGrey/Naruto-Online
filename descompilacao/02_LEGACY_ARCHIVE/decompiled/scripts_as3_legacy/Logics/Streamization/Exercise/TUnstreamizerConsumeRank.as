package Logics.Streamization.Exercise
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Streamization.TUnstreamizer;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.ConsumeRank.TConsumeRank;
   import Logics.Exercise.ConsumeRank.TConsumeRankInfo;
   import Logics.Exercise.ConsumeRank.TConsumeRankReward;
   import Logics.Exercise.ConsumeRank.TPerReward;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Processors.Game.Lobby.Exercise.ConsumeRank.TProcessorConsumeRank;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerConsumeRank extends TUnstreamizer
   {
      
      public var TAB_TYPE_TOTAL_RANK:int = TProcessorConsumeRank.TAB_TYPE_TOTAL_RANK;
      
      public var TAB_TYPE_POINT_REWARD:int = TProcessorConsumeRank.TAB_TYPE_POINT_REWARD;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      public function TUnstreamizerConsumeRank()
      {
         super();
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:TConsumeRank = null;
         _loc4_ = SLogicsCore.ConsumeRank;
         _loc4_ = param2 as TConsumeRank;
         switch(_loc4_.ChangeTabIndex)
         {
            case this.TAB_TYPE_TOTAL_RANK:
               this.UnstreamizationPerform_TotalRank(param1,param2);
               break;
            case this.TAB_TYPE_POINT_REWARD:
               this.UnstreamizationPerform_PointReward(param1,param2);
         }
      }
      
      protected function UnstreamizationPerform_TotalRank(param1:ByteArray, param2:Object) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:TInventory = null;
         var _loc11_:TInventories = null;
         var _loc12_:Vector.<uint> = null;
         var _loc13_:Vector.<uint> = null;
         var _loc14_:Vector.<int> = null;
         var _loc15_:Vector.<int> = null;
         var _loc16_:TConsumeRank = null;
         var _loc17_:TConsumeRankInfo = null;
         var _loc18_:TConsumeRankReward = null;
         var _loc19_:TBins = null;
         _loc19_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         _loc16_ = param2 as TConsumeRank;
         _loc16_.Identify = param1.readUnsignedInt();
         _loc16_.BeginTime = param1.readUnsignedInt();
         _loc16_.EndTime = param1.readUnsignedInt();
         _loc16_.PayEndTime = param1.readUnsignedInt();
         _loc16_.ActivityDesc = TUtilityString.FetchUTF(param1);
         _loc16_.Desc2 = TUtilityString.FetchUTF(param1);
         _loc16_.Desc3 = TUtilityString.FetchUTF(param1);
         _loc16_.Desc4 = TUtilityString.FetchUTF(param1);
         _loc16_.Desc5 = TUtilityString.FetchUTF(param1);
         _loc16_.Desc6 = TUtilityString.FetchUTF(param1);
         _loc16_.Desc7 = TUtilityString.FetchUTF(param1);
         _loc16_.PerRank = param1.readUnsignedInt();
         _loc16_.PerScore = param1.readUnsignedInt();
         _loc16_.DiffScore = param1.readUnsignedInt();
         _loc16_.CurReturn = param1.readUnsignedInt();
         _loc16_.DiffGold = param1.readUnsignedInt();
         _loc16_.NextReturn = param1.readUnsignedInt();
         _loc16_.PerRank2 = param1.readUnsignedInt();
         _loc16_.PerScore2 = param1.readUnsignedInt();
         _loc16_.DiffScore2 = param1.readUnsignedInt();
         _loc16_.CurReturn2 = param1.readUnsignedInt();
         _loc16_.DiffGold2 = param1.readUnsignedInt();
         _loc16_.NextReturn2 = param1.readUnsignedInt();
         _loc16_.RankInfoList.length = 0;
         _loc5_ = param1.readShort();
         _loc3_ = 0;
         while(_loc3_ < _loc5_)
         {
            _loc17_ = new TConsumeRankInfo();
            _loc17_.Identify0 = param1.readUnsignedInt();
            _loc17_.Identify1 = param1.readUnsignedInt();
            _loc17_.ServerName = TUtilityString.FetchUTF(param1);
            _loc17_.UserName = TUtilityString.FetchUTF(param1);
            _loc17_.Score = param1.readUnsignedInt();
            _loc17_.Rank = param1.readUnsignedInt();
            _loc16_.RankInfoList.push(_loc17_);
            _loc3_++;
         }
         _loc16_.RankRewardList.length = 0;
         _loc5_ = int(param1.readUnsignedShort());
         _loc12_ = new Vector.<uint>();
         _loc13_ = new Vector.<uint>();
         _loc14_ = new Vector.<int>();
         _loc15_ = new Vector.<int>();
         _loc3_ = 0;
         while(_loc3_ < _loc5_)
         {
            _loc18_ = new TConsumeRankReward();
            _loc18_.MinLimit = param1.readUnsignedInt();
            _loc18_.MaxLimit = param1.readUnsignedInt();
            _loc18_.BackRate = param1.readUnsignedInt();
            _loc12_.length = 0;
            _loc12_.push(param1.readUnsignedInt());
            _loc13_.push(1);
            _loc11_ = new TInventories();
            this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc11_,_loc12_);
            _loc18_.Inventories = _loc11_;
            _loc18_.Inventories.GetInventoryByIndex(0).Quantity = _loc13_[0];
            _loc18_.NeedSpend = param1.readUnsignedInt();
            _loc6_ = int(param1.readUnsignedShort());
            _loc18_.ReturnRate.length = 0;
            _loc18_.NeedGold.length = 0;
            _loc4_ = 0;
            while(_loc4_ < _loc6_)
            {
               _loc18_.NeedGold[_loc4_] = param1.readUnsignedInt();
               _loc18_.ReturnRate[_loc4_] = param1.readUnsignedInt();
               _loc4_++;
            }
            _loc16_.RankRewardList.push(_loc18_);
            _loc3_++;
         }
         _loc16_.RankInfoList2.length = 0;
         _loc5_ = param1.readShort();
         _loc3_ = 0;
         while(_loc3_ < _loc5_)
         {
            _loc17_ = new TConsumeRankInfo();
            _loc17_.Identify0 = param1.readUnsignedInt();
            _loc17_.Identify1 = param1.readUnsignedInt();
            _loc17_.ServerName = TUtilityString.FetchUTF(param1);
            _loc17_.UserName = TUtilityString.FetchUTF(param1);
            _loc17_.Score = param1.readUnsignedInt();
            _loc17_.Rank = param1.readUnsignedInt();
            _loc16_.RankInfoList2.push(_loc17_);
            _loc3_++;
         }
         _loc16_.RankRewardList2.length = 0;
         _loc5_ = int(param1.readUnsignedShort());
         _loc12_.length = 0;
         _loc13_.length = 0;
         _loc3_ = 0;
         while(_loc3_ < _loc5_)
         {
            _loc18_ = new TConsumeRankReward();
            _loc18_.MinLimit = param1.readUnsignedInt();
            _loc18_.MaxLimit = param1.readUnsignedInt();
            _loc18_.BackRate = param1.readUnsignedInt();
            _loc12_.length = 0;
            _loc12_.push(param1.readUnsignedInt());
            _loc13_.push(1);
            _loc11_ = new TInventories();
            this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc11_,_loc12_);
            _loc18_.Inventories = _loc11_;
            _loc18_.Inventories.GetInventoryByIndex(0).Quantity = _loc13_[0];
            _loc18_.NeedSpend = param1.readUnsignedInt();
            _loc6_ = int(param1.readUnsignedShort());
            _loc18_.ReturnRate.length = 0;
            _loc18_.NeedGold.length = 0;
            _loc4_ = 0;
            while(_loc4_ < _loc6_)
            {
               _loc18_.NeedGold[_loc4_] = param1.readUnsignedInt();
               _loc18_.ReturnRate[_loc4_] = param1.readUnsignedInt();
               _loc4_++;
            }
            _loc16_.RankRewardList2.push(_loc18_);
            _loc3_++;
         }
         _loc12_.length = 0;
         _loc13_.length = 0;
         _loc14_.length = 0;
         _loc15_.length = 0;
         _loc11_ = new TInventories();
         _loc5_ = int(param1.readUnsignedShort());
         _loc3_ = 0;
         while(_loc3_ < _loc5_)
         {
            _loc14_.push(param1.readUnsignedInt());
            _loc15_.push(param1.readUnsignedInt());
            _loc9_ = param1.readUnsignedInt();
            _loc8_ = param1.readUnsignedInt();
            _loc7_ = CONST_COMMON.GetItemIDByType(_loc9_,_loc8_,_loc19_);
            _loc12_.push(_loc7_);
            _loc13_.push(param1.readUnsignedInt());
            _loc3_++;
         }
         this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc11_,_loc12_);
         _loc3_ = 0;
         while(_loc3_ < _loc5_)
         {
            _loc10_ = _loc11_.GetInventoryByIndex(_loc3_);
            _loc10_.Quantity = _loc13_[_loc3_];
            _loc10_.NewType = _loc14_[_loc3_];
            _loc10_.NewIdentify = _loc15_[_loc3_];
            _loc3_++;
         }
         _loc16_.GoldShowItems = _loc11_;
         _loc12_.length = 0;
         _loc13_.length = 0;
         _loc14_.length = 0;
         _loc15_.length = 0;
         _loc11_ = new TInventories();
         _loc5_ = param1.readShort();
         _loc3_ = 0;
         while(_loc3_ < _loc5_)
         {
            _loc14_.push(param1.readUnsignedInt());
            _loc15_.push(param1.readUnsignedInt());
            _loc9_ = param1.readUnsignedInt();
            _loc8_ = param1.readUnsignedInt();
            _loc7_ = CONST_COMMON.GetItemIDByType(_loc9_,_loc8_,_loc19_);
            _loc12_.push(_loc7_);
            _loc13_.push(param1.readUnsignedInt());
            _loc3_++;
         }
         this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc11_,_loc12_);
         _loc3_ = 0;
         while(_loc3_ < _loc5_)
         {
            _loc10_ = _loc11_.GetInventoryByIndex(_loc3_);
            _loc10_.Quantity = _loc13_[_loc3_];
            _loc10_.NewType = _loc14_[_loc3_];
            _loc10_.NewIdentify = _loc15_[_loc3_];
            _loc3_++;
         }
         _loc16_.GoldEquipments = _loc11_;
         _loc12_.length = 0;
         _loc13_.length = 0;
         _loc14_.length = 0;
         _loc15_.length = 0;
         _loc11_ = new TInventories();
         _loc5_ = int(param1.readUnsignedShort());
         _loc3_ = 0;
         while(_loc3_ < _loc5_)
         {
            _loc14_.push(param1.readUnsignedInt());
            _loc15_.push(param1.readUnsignedInt());
            _loc9_ = param1.readUnsignedInt();
            _loc8_ = param1.readUnsignedInt();
            _loc7_ = CONST_COMMON.GetItemIDByType(_loc9_,_loc8_,_loc19_);
            _loc12_.push(_loc7_);
            _loc13_.push(param1.readUnsignedInt());
            _loc3_++;
         }
         this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc11_,_loc12_);
         _loc3_ = 0;
         while(_loc3_ < _loc5_)
         {
            _loc10_ = _loc11_.GetInventoryByIndex(_loc3_);
            _loc10_.Quantity = _loc13_[_loc3_];
            _loc10_.NewType = _loc14_[_loc3_];
            _loc10_.NewIdentify = _loc15_[_loc3_];
            _loc3_++;
         }
         _loc16_.GiftShowItems = _loc11_;
         _loc12_.length = 0;
         _loc13_.length = 0;
         _loc14_.length = 0;
         _loc15_.length = 0;
         _loc11_ = new TInventories();
         _loc5_ = param1.readShort();
         _loc3_ = 0;
         while(_loc3_ < _loc5_)
         {
            _loc14_.push(param1.readUnsignedInt());
            _loc15_.push(param1.readUnsignedInt());
            _loc9_ = param1.readUnsignedInt();
            _loc8_ = param1.readUnsignedInt();
            _loc7_ = CONST_COMMON.GetItemIDByType(_loc9_,_loc8_,_loc19_);
            _loc12_.push(_loc7_);
            _loc13_.push(param1.readUnsignedInt());
            _loc3_++;
         }
         this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc11_,_loc12_);
         _loc3_ = 0;
         while(_loc3_ < _loc5_)
         {
            _loc10_ = _loc11_.GetInventoryByIndex(_loc3_);
            _loc10_.Quantity = _loc13_[_loc3_];
            _loc10_.NewType = _loc14_[_loc3_];
            _loc10_.NewIdentify = _loc15_[_loc3_];
            _loc3_++;
         }
         _loc16_.GiftEquipments = _loc11_;
      }
      
      protected function UnstreamizationPerform_PointReward(param1:ByteArray, param2:Object) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:TInventory = null;
         var _loc8_:TInventories = null;
         var _loc9_:Vector.<uint> = null;
         var _loc10_:Vector.<uint> = null;
         var _loc11_:TConsumeRank = null;
         var _loc12_:TPerReward = null;
         _loc11_ = param2 as TConsumeRank;
         _loc11_.PerScore = param1.readUnsignedInt();
         _loc5_ = int(param1.readUnsignedShort());
         _loc9_ = new Vector.<uint>();
         _loc10_ = new Vector.<uint>();
         if(!_loc11_.PerRewardList || _loc11_.PerRewardList.length == 0)
         {
            _loc3_ = 0;
            while(_loc3_ < _loc5_)
            {
               _loc12_ = new TPerReward();
               _loc12_.Score = param1.readUnsignedInt();
               _loc12_.Status = param1.readUnsignedInt();
               _loc12_.Identify = param1.readUnsignedInt();
               _loc6_ = int(param1.readUnsignedShort());
               _loc9_.length = 0;
               _loc10_.length = 0;
               _loc4_ = 0;
               while(_loc4_ < _loc6_)
               {
                  _loc9_.push(param1.readUnsignedInt());
                  _loc10_.push(param1.readUnsignedInt());
                  _loc4_++;
               }
               _loc8_ = new TInventories();
               this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc8_,_loc9_);
               _loc4_ = 0;
               while(_loc4_ < _loc6_)
               {
                  _loc7_ = _loc8_.GetInventoryByIndex(_loc4_);
                  _loc7_.Quantity = _loc10_[_loc4_];
                  _loc4_++;
               }
               _loc12_.Inventories = _loc8_;
               _loc11_.PerRewardList.push(_loc12_);
               _loc3_++;
            }
         }
      }
      
      override public function Unstreamize(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform(param1,param2,param3);
      }
   }
}

