package Logics.Streamization.LevelGifts
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Streamization.TUnstreamizer;
   import Logics.DatebaseVO.VO.TLeadLevelGifts;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.LevelGifts.TLeadLevelGiftsData;
   import Logics.LevelGifts.TLeadLevelGiftsVO;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerLeadLevelGifts extends TUnstreamizer
   {
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      public function TUnstreamizerLeadLevelGifts()
      {
         super();
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:TLeadLevelGiftsVO = null;
         var _loc7_:TLeadLevelGiftsData = null;
         _loc7_ = param2 as TLeadLevelGiftsData;
         _loc7_.Clear();
         _loc4_ = uint(param1.readShort());
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc6_ = new TLeadLevelGiftsVO();
            _loc6_.Identifier = param1.readUnsignedInt();
            _loc6_.Stage = param1.readUnsignedInt();
            _loc6_.Reward = param1.readInt();
            _loc6_.TopReward = param1.readInt();
            _loc7_.Add(_loc6_);
            this.UnstreamizationInventory(null,_loc6_,_loc6_.LeadLevelGifts);
            _loc5_++;
         }
      }
      
      protected function UnstreamizationInventory(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:TInventories = null;
         var _loc5_:TInventory = null;
         var _loc6_:Vector.<uint> = null;
         var _loc7_:Vector.<uint> = null;
         var _loc8_:TBins = null;
         var _loc9_:Object = null;
         var _loc10_:TLeadLevelGifts = null;
         var _loc11_:TLeadLevelGiftsVO = null;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc15_:int = 0;
         var _loc16_:int = 0;
         _loc6_ = new Vector.<uint>();
         _loc7_ = new Vector.<uint>();
         _loc4_ = new TInventories();
         _loc8_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         _loc11_ = param2 as TLeadLevelGiftsVO;
         _loc10_ = param3 as TLeadLevelGifts;
         _loc12_ = int(_loc10_.GiftArr.length);
         _loc13_ = 0;
         while(_loc13_ < _loc12_)
         {
            _loc9_ = _loc10_.GiftArr[_loc13_];
            _loc15_ = int(_loc9_.type);
            _loc16_ = int(_loc9_.code);
            _loc14_ = int(CONST_COMMON.GetItemIDByType(_loc15_,_loc16_,_loc8_));
            _loc6_.push(_loc14_);
            _loc7_.push(_loc9_.amount);
            _loc13_++;
         }
         this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc4_,_loc6_);
         _loc13_ = 0;
         while(_loc13_ < _loc12_)
         {
            _loc5_ = _loc4_.GetInventoryByIndex(_loc13_);
            _loc5_.Quantity = _loc7_[_loc13_];
            _loc13_++;
         }
         _loc11_.RewardList = _loc4_;
         _loc4_ = new TInventories();
         _loc6_.length = 0;
         _loc7_.length = 0;
         _loc12_ = int(_loc10_.TopupgiftArr.length);
         _loc13_ = 0;
         while(_loc13_ < _loc12_)
         {
            _loc9_ = _loc10_.TopupgiftArr[_loc13_];
            _loc15_ = int(_loc9_.type);
            _loc16_ = int(_loc9_.code);
            _loc14_ = int(CONST_COMMON.GetItemIDByType(_loc15_,_loc16_,_loc8_));
            _loc6_.push(_loc14_);
            _loc7_.push(_loc9_.amount);
            _loc13_++;
         }
         this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc4_,_loc6_);
         _loc13_ = 0;
         while(_loc13_ < _loc12_)
         {
            _loc5_ = _loc4_.GetInventoryByIndex(_loc13_);
            _loc5_.Quantity = _loc7_[_loc13_];
            _loc13_++;
         }
         _loc11_.TopRewardList = _loc4_;
      }
   }
}

