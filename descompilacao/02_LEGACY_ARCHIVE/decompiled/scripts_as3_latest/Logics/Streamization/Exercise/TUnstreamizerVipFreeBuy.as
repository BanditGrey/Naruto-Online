package Logics.Streamization.Exercise
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Streamization.TUnstreamizer;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.VipFreeBuy.TVipFreeBuy;
   import Logics.Exercise.VipShop.TVipBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerVipFreeBuy extends TUnstreamizer
   {
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      public function TUnstreamizerVipFreeBuy()
      {
         super();
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:TInventory = null;
         var _loc9_:TInventories = null;
         var _loc10_:Vector.<uint> = null;
         var _loc11_:Vector.<uint> = null;
         var _loc12_:TVipFreeBuy = null;
         var _loc13_:TVipBox = null;
         var _loc14_:uint = 0;
         var _loc15_:uint = 0;
         var _loc16_:uint = 0;
         var _loc17_:TBins = null;
         _loc17_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         _loc12_ = param2 as TVipFreeBuy;
         _loc12_.Identify = param1.readUnsignedInt();
         _loc12_.BeginTime = param1.readUnsignedInt();
         _loc12_.EndTime = param1.readUnsignedInt();
         _loc12_.PayEndTime = param1.readUnsignedInt();
         _loc12_.ActivityName = TUtilityString.FetchUTF(param1);
         _loc12_.ActivityTabName = TUtilityString.FetchUTF(param1);
         _loc12_.ActivityDesc = TUtilityString.FetchUTF(param1);
         _loc12_.RewardStatus.length = 0;
         _loc6_ = int(param1.readUnsignedShort());
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc12_.RewardStatus.push(param1.readUnsignedInt());
            _loc4_++;
         }
         _loc12_.GetBoxDay.length = 0;
         _loc6_ = int(param1.readUnsignedShort());
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc12_.GetBoxDay[_loc4_] = param1.readUnsignedInt();
            _loc4_++;
         }
         if(_loc12_.NeedConfig)
         {
            _loc10_ = new Vector.<uint>();
            _loc11_ = new Vector.<uint>();
            _loc6_ = int(param1.readUnsignedShort());
            _loc4_ = 0;
            while(_loc4_ < _loc6_)
            {
               _loc13_ = new TVipBox();
               _loc13_.Identify = param1.readUnsignedInt();
               _loc13_.Price = param1.readUnsignedInt();
               _loc13_.VipLevel = param1.readUnsignedInt();
               _loc10_.length = 0;
               _loc11_.length = 0;
               _loc7_ = int(param1.readUnsignedShort());
               _loc5_ = 0;
               while(_loc5_ < _loc7_)
               {
                  _loc16_ = param1.readUnsignedInt();
                  _loc15_ = param1.readUnsignedInt();
                  _loc14_ = CONST_COMMON.GetItemIDByType(_loc16_,_loc15_,_loc17_);
                  _loc10_.push(_loc14_);
                  _loc11_.push(param1.readUnsignedInt());
                  _loc5_++;
               }
               _loc9_ = new TInventories();
               this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc9_,_loc10_);
               _loc5_ = 0;
               while(_loc5_ < _loc7_)
               {
                  _loc8_ = _loc9_.GetInventoryByIndex(_loc5_);
                  _loc8_.Quantity = _loc11_[_loc5_];
                  _loc5_++;
               }
               _loc13_.Inventories = _loc9_;
               _loc12_.VipBoxList[_loc4_] = _loc13_;
               _loc4_++;
            }
         }
      }
      
      override public function Unstreamize(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform(param1,param2,param3);
      }
   }
}

