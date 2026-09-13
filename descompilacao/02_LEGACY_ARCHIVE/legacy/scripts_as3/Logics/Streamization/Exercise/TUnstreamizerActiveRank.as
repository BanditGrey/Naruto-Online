package Logics.Streamization.Exercise
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Streamization.TUnstreamizer;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.BaseRank.TActiveRankDatas;
   import Logics.Exercise.BaseRank.TBaseRank;
   import Logics.Exercise.BaseRank.TMyRank;
   import Logics.Exercise.BaseRank.TRankInfo;
   import Logics.Exercise.BaseRank.TTodayRank;
   import Logics.Exercise.BaseRank.TTotalRank;
   import Logics.Exercise.BaseRank.TYesterdayRank;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerActiveRank extends TUnstreamizer
   {
      
      public static const ACTIVITY_1_ID:int = 1;
      
      public static const ACTIVITY_2_ID:int = 2;
      
      public static const ACTIVITY_3_ID:int = 3;
      
      public static const ACTIVITY_4_ID:int = 4;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      public function TUnstreamizerActiveRank()
      {
         super();
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:TActiveRankDatas = null;
         var _loc7_:TBaseRank = null;
         var _loc8_:int = 0;
         var _loc9_:TBins = null;
         _loc6_ = param2 as TActiveRankDatas;
         _loc9_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         _loc6_.DescListNew.length = 0;
         _loc5_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc6_.DescListNew[_loc4_] = TUtilityString.FetchUTF(param1);
            _loc4_++;
         }
         _loc6_.InitDescListNew();
         _loc6_.ActivityID = param1.readUnsignedInt();
         _loc6_.ActivityIndex = param1.readUnsignedInt();
         _loc6_.TotalScore = param1.readUnsignedInt();
         _loc6_.TodayScore = param1.readUnsignedInt();
         _loc6_.TotalRank = param1.readUnsignedInt();
         _loc6_.TodayRank = param1.readUnsignedInt();
         _loc6_.IsEnd = param1.readUnsignedInt();
         _loc8_ = param1.readInt();
         switch(_loc8_)
         {
            case ACTIVITY_1_ID:
               this.UnstreamizationPerform_1(param1,_loc6_,_loc9_);
               break;
            case ACTIVITY_2_ID:
               this.UnstreamizationPerform_2(param1,_loc6_,_loc9_);
               break;
            case ACTIVITY_3_ID:
               this.UnstreamizationPerform_3(param1,_loc6_,_loc9_);
               break;
            case ACTIVITY_4_ID:
               this.UnstreamizationPerform_4(param1,_loc6_,_loc9_);
         }
      }
      
      protected function UnstreamizationPerform_1(param1:ByteArray, param2:Object, param3:TBins) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:TInventory = null;
         var _loc11_:TInventories = null;
         var _loc12_:uint = 0;
         var _loc13_:uint = 0;
         var _loc14_:uint = 0;
         var _loc15_:Vector.<uint> = null;
         var _loc16_:Vector.<uint> = null;
         var _loc17_:TBaseBox = null;
         var _loc18_:TTodayRank = null;
         var _loc19_:TRankInfo = null;
         var _loc20_:TActiveRankDatas = null;
         var _loc21_:Vector.<int> = null;
         var _loc22_:Vector.<int> = null;
         _loc15_ = new Vector.<uint>();
         _loc16_ = new Vector.<uint>();
         _loc21_ = new Vector.<int>();
         _loc22_ = new Vector.<int>();
         _loc20_ = param2 as TActiveRankDatas;
         _loc18_ = _loc20_.GetRankByIdentify(ACTIVITY_1_ID) as TTodayRank;
         _loc20_.TodayCommand.length = 0;
         _loc7_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc7_)
         {
            _loc20_.TodayCommand[_loc4_] = param1.readUnsignedInt();
            _loc4_++;
         }
         _loc20_.TodayRewards.length = 0;
         _loc7_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc7_)
         {
            _loc8_ = param1.readShort();
            _loc11_ = new TInventories();
            _loc21_.length = 0;
            _loc22_.length = 0;
            _loc15_.length = 0;
            _loc16_.length = 0;
            _loc5_ = 0;
            while(_loc5_ < _loc8_)
            {
               _loc21_.push(param1.readUnsignedInt());
               _loc22_.push(param1.readUnsignedInt());
               _loc14_ = param1.readUnsignedInt();
               _loc13_ = param1.readUnsignedInt();
               _loc12_ = CONST_COMMON.GetItemIDByType(_loc14_,_loc13_,param3);
               _loc15_.push(_loc12_);
               _loc16_.push(param1.readUnsignedInt());
               _loc5_++;
            }
            this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc11_,_loc15_);
            _loc5_ = 0;
            while(_loc5_ < _loc8_)
            {
               _loc10_ = _loc11_.GetInventoryByIndex(_loc5_);
               _loc10_.Quantity = _loc16_[_loc5_];
               _loc10_.NewType = _loc21_[_loc5_];
               _loc10_.NewIdentify = _loc22_[_loc5_];
               _loc5_++;
            }
            _loc20_.TodayRewards[_loc4_] = _loc11_;
            _loc4_++;
         }
         _loc20_.TodaySpecials.length = 0;
         _loc7_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc7_)
         {
            _loc8_ = param1.readShort();
            _loc11_ = new TInventories();
            _loc21_.length = 0;
            _loc22_.length = 0;
            _loc15_.length = 0;
            _loc16_.length = 0;
            _loc5_ = 0;
            while(_loc5_ < _loc8_)
            {
               _loc21_.push(param1.readUnsignedInt());
               _loc22_.push(param1.readUnsignedInt());
               _loc14_ = param1.readUnsignedInt();
               _loc13_ = param1.readUnsignedInt();
               _loc12_ = CONST_COMMON.GetItemIDByType(_loc14_,_loc13_,param3);
               _loc15_.push(_loc12_);
               _loc16_.push(param1.readUnsignedInt());
               _loc5_++;
            }
            this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc11_,_loc15_);
            _loc5_ = 0;
            while(_loc5_ < _loc8_)
            {
               _loc10_ = _loc11_.GetInventoryByIndex(_loc5_);
               _loc10_.Quantity = _loc16_[_loc5_];
               _loc10_.NewType = _loc21_[_loc5_];
               _loc10_.NewIdentify = _loc22_[_loc5_];
               _loc5_++;
            }
            _loc20_.TodaySpecials[_loc4_] = _loc11_;
            _loc4_++;
         }
         _loc18_.RankList.length = 0;
         _loc7_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc7_)
         {
            _loc19_ = new TRankInfo();
            _loc19_.Name = TUtilityString.FetchUTF(param1);
            _loc19_.Rank = param1.readUnsignedInt();
            _loc19_.Score = param1.readUnsignedInt();
            _loc19_.RewardIndex = param1.readUnsignedInt();
            _loc19_.SpecialStatus = param1.readInt();
            _loc18_.RankList[_loc4_] = _loc19_;
            _loc4_++;
         }
      }
      
      protected function UnstreamizationPerform_2(param1:ByteArray, param2:Object, param3:TBins) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:TInventory = null;
         var _loc9_:TInventories = null;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         var _loc13_:Vector.<uint> = null;
         var _loc14_:Vector.<uint> = null;
         var _loc15_:TBaseBox = null;
         var _loc16_:TYesterdayRank = null;
         var _loc17_:TRankInfo = null;
         var _loc18_:TActiveRankDatas = null;
         var _loc19_:Vector.<int> = null;
         var _loc20_:Vector.<int> = null;
         _loc13_ = new Vector.<uint>();
         _loc14_ = new Vector.<uint>();
         _loc19_ = new Vector.<int>();
         _loc20_ = new Vector.<int>();
         _loc18_ = param2 as TActiveRankDatas;
         _loc16_ = _loc18_.GetRankByIdentify(ACTIVITY_2_ID) as TYesterdayRank;
         _loc6_ = param1.readShort();
         _loc6_ = param1.readShort();
         _loc6_ = param1.readShort();
         _loc16_.RankList.length = 0;
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc17_ = new TRankInfo();
            _loc17_.Name = TUtilityString.FetchUTF(param1);
            _loc17_.Rank = param1.readUnsignedInt();
            _loc17_.Score = param1.readUnsignedInt();
            _loc17_.RewardIndex = param1.readUnsignedInt();
            _loc17_.SpecialStatus = param1.readInt();
            _loc16_.RankList[_loc4_] = _loc17_;
            _loc4_++;
         }
      }
      
      protected function UnstreamizationPerform_3(param1:ByteArray, param2:Object, param3:TBins) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:TInventory = null;
         var _loc9_:TInventories = null;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         var _loc13_:Vector.<uint> = null;
         var _loc14_:Vector.<uint> = null;
         var _loc15_:TBaseBox = null;
         var _loc16_:TTotalRank = null;
         var _loc17_:TRankInfo = null;
         var _loc18_:TActiveRankDatas = null;
         var _loc19_:Vector.<int> = null;
         var _loc20_:Vector.<int> = null;
         _loc13_ = new Vector.<uint>();
         _loc14_ = new Vector.<uint>();
         _loc19_ = new Vector.<int>();
         _loc20_ = new Vector.<int>();
         _loc18_ = param2 as TActiveRankDatas;
         _loc16_ = _loc18_.GetRankByIdentify(ACTIVITY_3_ID) as TTotalRank;
         _loc18_.TotalCommand.length = 0;
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc18_.TotalCommand[_loc4_] = param1.readUnsignedInt();
            _loc4_++;
         }
         _loc18_.TotalRewards.length = 0;
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc7_ = param1.readShort();
            _loc9_ = new TInventories();
            _loc19_.length = 0;
            _loc20_.length = 0;
            _loc13_.length = 0;
            _loc14_.length = 0;
            _loc5_ = 0;
            while(_loc5_ < _loc7_)
            {
               _loc19_.push(param1.readUnsignedInt());
               _loc20_.push(param1.readUnsignedInt());
               _loc12_ = param1.readUnsignedInt();
               _loc11_ = param1.readUnsignedInt();
               _loc10_ = CONST_COMMON.GetItemIDByType(_loc12_,_loc11_,param3);
               _loc13_.push(_loc10_);
               _loc14_.push(param1.readUnsignedInt());
               _loc5_++;
            }
            this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc9_,_loc13_);
            _loc5_ = 0;
            while(_loc5_ < _loc7_)
            {
               _loc8_ = _loc9_.GetInventoryByIndex(_loc5_);
               _loc8_.Quantity = _loc14_[_loc5_];
               _loc8_.NewType = _loc19_[_loc5_];
               _loc8_.NewIdentify = _loc20_[_loc5_];
               _loc5_++;
            }
            _loc18_.TotalRewards[_loc4_] = _loc9_;
            _loc4_++;
         }
         _loc18_.TotalSpecials.length = 0;
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc7_ = param1.readShort();
            _loc9_ = new TInventories();
            _loc19_.length = 0;
            _loc20_.length = 0;
            _loc13_.length = 0;
            _loc14_.length = 0;
            _loc5_ = 0;
            while(_loc5_ < _loc7_)
            {
               _loc19_.push(param1.readUnsignedInt());
               _loc20_.push(param1.readUnsignedInt());
               _loc12_ = param1.readUnsignedInt();
               _loc11_ = param1.readUnsignedInt();
               _loc10_ = CONST_COMMON.GetItemIDByType(_loc12_,_loc11_,param3);
               _loc13_.push(_loc10_);
               _loc14_.push(param1.readUnsignedInt());
               _loc5_++;
            }
            this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc9_,_loc13_);
            _loc5_ = 0;
            while(_loc5_ < _loc7_)
            {
               _loc8_ = _loc9_.GetInventoryByIndex(_loc5_);
               _loc8_.Quantity = _loc14_[_loc5_];
               _loc8_.NewType = _loc19_[_loc5_];
               _loc8_.NewIdentify = _loc20_[_loc5_];
               _loc5_++;
            }
            _loc18_.TotalSpecials[_loc4_] = _loc9_;
            _loc4_++;
         }
         _loc16_.RankList.length = 0;
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc17_ = new TRankInfo();
            _loc17_.Name = TUtilityString.FetchUTF(param1);
            _loc17_.Rank = param1.readUnsignedInt();
            _loc17_.Score = param1.readUnsignedInt();
            _loc17_.RewardIndex = param1.readUnsignedInt();
            _loc17_.SpecialStatus = param1.readInt();
            _loc16_.RankList[_loc4_] = _loc17_;
            _loc4_++;
         }
      }
      
      protected function UnstreamizationPerform_4(param1:ByteArray, param2:Object, param3:TBins) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:TInventory = null;
         var _loc9_:TInventories = null;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         var _loc13_:Vector.<uint> = null;
         var _loc14_:Vector.<uint> = null;
         var _loc15_:TBaseBox = null;
         var _loc16_:TMyRank = null;
         var _loc17_:TRankInfo = null;
         var _loc18_:TActiveRankDatas = null;
         var _loc19_:Vector.<int> = null;
         var _loc20_:Vector.<int> = null;
         _loc13_ = new Vector.<uint>();
         _loc14_ = new Vector.<uint>();
         _loc19_ = new Vector.<int>();
         _loc20_ = new Vector.<int>();
         _loc18_ = param2 as TActiveRankDatas;
         _loc16_ = _loc18_.GetRankByIdentify(ACTIVITY_4_ID) as TMyRank;
         _loc16_.RankList.length = 0;
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc17_ = new TRankInfo();
            _loc17_.Rank = param1.readUnsignedInt();
            _loc17_.Score = param1.readUnsignedInt();
            _loc17_.RewardIndex = param1.readUnsignedInt();
            _loc17_.SpecialStatus = param1.readInt();
            _loc17_.RankDate = param1.readUnsignedInt();
            _loc16_.RankList[_loc4_] = _loc17_;
            _loc4_++;
         }
      }
      
      override public function Unstreamize(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform(param1,param2,param3);
      }
   }
}

