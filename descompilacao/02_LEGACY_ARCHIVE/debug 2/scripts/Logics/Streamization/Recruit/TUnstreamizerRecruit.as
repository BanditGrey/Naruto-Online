package Logics.Streamization.Recruit
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Streamization.TUnstreamizer;
   import Logics.DatebaseVO.VO.TDrawNinjaArchive;
   import Logics.DatebaseVO.VO.TDrawNinjaConfig;
   import Logics.DatebaseVO.VO.TDrawNinjaMall;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.Inventories.TInventorySample;
   import Logics.Inventories.TInventorySamples;
   import Logics.Recruit.TRecruit;
   import Logics.Recruit.TRecruitData;
   import Logics.Recruit.TRecruitLevelGifts;
   import Logics.Recruit.TRecruitLevelGiftsData;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Logics.Streamization.Inventories.TUnstreamizerInventorySample;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerRecruit extends TUnstreamizer
   {
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FUnstreamizerInventorySample:TUnstreamizerInventorySample;
      
      public function TUnstreamizerRecruit()
      {
         super();
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         this.FUnstreamizerInventorySample = new TUnstreamizerInventorySample();
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:int = 0;
         var _loc5_:uint = 0;
         var _loc6_:int = 0;
         var _loc7_:TRecruitData = null;
         var _loc8_:TRecruit = null;
         var _loc9_:Vector.<TDrawNinjaArchive> = null;
         _loc7_ = param2 as TRecruitData;
         _loc9_ = param3 as Vector.<TDrawNinjaArchive>;
         _loc5_ = uint(param1.readShort());
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc6_ = int(param1.readUnsignedInt());
            _loc8_ = _loc7_.GetTRecruitByIdentifier(_loc6_);
            _loc8_.activate = param1.readUnsignedInt();
            _loc8_.starNum = param1.readUnsignedInt();
            _loc8_.count = param1.readUnsignedInt();
            _loc8_.isDrawed = true;
            if(_loc9_)
            {
               _loc9_.push(_loc8_.DrawNinjaArchive);
            }
            _loc4_++;
         }
      }
      
      protected function UnstreamizationPerformByDatabase(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:int = 0;
         var _loc5_:uint = 0;
         var _loc6_:TBins = null;
         var _loc7_:TRecruitData = null;
         var _loc8_:TDrawNinjaArchive = null;
         var _loc9_:TRecruit = null;
         _loc6_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_DrawNinjaArchive) as TBins;
         _loc7_ = param2 as TRecruitData;
         _loc5_ = uint(_loc6_.Count);
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc9_ = new TRecruit();
            _loc8_ = _loc6_.GetDatebaseByIndex(_loc4_) as TDrawNinjaArchive;
            _loc9_.heroId = _loc8_.Identifier;
            _loc9_.name = _loc8_.Name;
            _loc9_.DrawNinjaArchive = _loc8_;
            _loc7_.Add(_loc9_);
            _loc4_++;
         }
      }
      
      public function UnstreamizationByDatabase(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerformByDatabase(param1,param2,param3);
      }
      
      public function UnstreamizationRecruitWarOrder(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:TRecruitLevelGifts = null;
         var _loc7_:TRecruitLevelGiftsData = null;
         _loc7_ = param2 as TRecruitLevelGiftsData;
         _loc7_.Clear();
         _loc4_ = uint(param1.readShort());
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc6_ = new TRecruitLevelGifts();
            _loc6_.Identifier = param1.readUnsignedInt();
            _loc6_.Reward = param1.readInt();
            _loc6_.TopReward = param1.readInt();
            _loc7_.Add(_loc6_);
            this.UnstreamizationInventory(null,_loc6_,_loc6_.DrawNinjaConfig);
            _loc5_++;
         }
         _loc7_.Score = param1.readInt();
      }
      
      protected function UnstreamizationInventory(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:TInventories = null;
         var _loc5_:TInventory = null;
         var _loc6_:Vector.<uint> = null;
         var _loc7_:Vector.<uint> = null;
         var _loc8_:TBins = null;
         var _loc9_:Object = null;
         var _loc10_:TDrawNinjaConfig = null;
         var _loc11_:TRecruitLevelGifts = null;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc15_:int = 0;
         var _loc16_:int = 0;
         _loc6_ = new Vector.<uint>();
         _loc7_ = new Vector.<uint>();
         _loc4_ = new TInventories();
         _loc8_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         _loc11_ = param2 as TRecruitLevelGifts;
         _loc10_ = param3 as TDrawNinjaConfig;
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
      
      protected function UnstreamizationPerform_InventorySamplesByDatabase(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:uint = 0;
         var _loc5_:TBins = null;
         var _loc6_:TDrawNinjaMall = null;
         var _loc7_:TInventorySamples = null;
         var _loc8_:TInventorySample = null;
         _loc7_ = param2 as TInventorySamples;
         _loc5_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_DrawNinjaMall);
         _loc4_ = 0;
         while(_loc4_ < _loc5_.Count)
         {
            _loc6_ = _loc5_.GetDatebaseByIndex(_loc4_) as TDrawNinjaMall;
            _loc8_ = new TInventorySample();
            this.FUnstreamizerInventorySample.UnstreamizerDrawNinjaMallByDatabase(null,_loc8_,_loc6_);
            _loc7_.Add(_loc8_);
            _loc4_++;
         }
      }
      
      public function UnstreamizeInventorySamplesByDatabase(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform_InventorySamplesByDatabase(param1,param2,param3);
      }
   }
}

