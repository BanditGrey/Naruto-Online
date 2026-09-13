package Logics.Streamization.Exercise
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Streamization.TUnstreamizer;
   import Logics.Exercise.DayRechargeGift.TDayRechargeGift;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerDayRechargeGift extends TUnstreamizer
   {
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      public function TUnstreamizerDayRechargeGift()
      {
         super();
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:TDayRechargeGift = null;
         var _loc5_:TBaseBox = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:TInventories = null;
         var _loc11_:TInventory = null;
         var _loc12_:Vector.<uint> = null;
         var _loc13_:Vector.<uint> = null;
         var _loc14_:uint = 0;
         var _loc15_:int = 0;
         var _loc16_:int = 0;
         var _loc17_:TBins = null;
         _loc4_ = param2 as TDayRechargeGift;
         _loc4_.BoxList.length = 0;
         _loc6_ = param1.readShort();
         _loc12_ = new Vector.<uint>();
         _loc13_ = new Vector.<uint>();
         _loc17_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         _loc8_ = 0;
         while(_loc8_ < _loc6_)
         {
            _loc5_ = new TBaseBox();
            _loc5_.Level = param1.readUnsignedInt();
            _loc7_ = param1.readShort();
            _loc12_.length = 0;
            _loc13_.length = 0;
            _loc10_ = new TInventories();
            _loc9_ = 0;
            while(_loc9_ < _loc7_)
            {
               _loc15_ = int(param1.readUnsignedInt());
               _loc16_ = int(param1.readUnsignedInt());
               _loc14_ = CONST_COMMON.GetItemIDByType(_loc15_,_loc16_,_loc17_);
               _loc12_.push(_loc14_);
               _loc13_.push(param1.readUnsignedInt());
               _loc9_++;
            }
            this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc10_,_loc12_);
            _loc9_ = 0;
            while(_loc9_ < _loc7_)
            {
               _loc11_ = _loc10_.GetInventoryByIndex(_loc9_);
               _loc11_.Quantity = _loc13_[_loc9_];
               _loc9_++;
            }
            _loc5_.Inventories = _loc10_;
            _loc5_.Status = param1.readUnsignedInt();
            _loc4_.BoxList.unshift(_loc5_);
            _loc8_++;
         }
         _loc4_.BeginTime = param1.readUnsignedInt();
         _loc4_.EndTime = param1.readUnsignedInt();
      }
   }
}

