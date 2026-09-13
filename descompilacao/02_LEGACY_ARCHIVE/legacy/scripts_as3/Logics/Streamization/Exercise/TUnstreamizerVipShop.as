package Logics.Streamization.Exercise
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Streamization.TUnstreamizer;
   import Logics.Exercise.VipShop.TVipBox;
   import Logics.Exercise.VipShop.TVipShop;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerVipShop extends TUnstreamizer
   {
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      public function TUnstreamizerVipShop()
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
         var _loc12_:uint = 0;
         var _loc13_:TVipShop = null;
         var _loc14_:TVipBox = null;
         var _loc15_:uint = 0;
         var _loc16_:uint = 0;
         var _loc17_:TBins = null;
         _loc13_ = param2 as TVipShop;
         _loc17_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         _loc13_.Identify = param1.readUnsignedInt();
         _loc13_.BeginTime = param1.readUnsignedInt();
         _loc13_.EndTime = param1.readUnsignedInt();
         _loc13_.BoxList.length = 0;
         _loc10_ = new Vector.<uint>();
         _loc11_ = new Vector.<uint>();
         _loc6_ = int(param1.readUnsignedShort());
         _loc13_.VipCount = _loc6_;
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc14_ = new TVipBox();
            _loc14_.Identify = param1.readUnsignedInt();
            _loc14_.VipLevel = param1.readUnsignedInt();
            _loc14_.BoxCount = param1.readUnsignedInt();
            _loc14_.BuyCount = param1.readUnsignedInt();
            _loc14_.Price = param1.readUnsignedInt();
            _loc14_.DiscountPrice = param1.readUnsignedInt();
            _loc7_ = int(param1.readUnsignedShort());
            _loc10_.length = 0;
            _loc11_.length = 0;
            _loc5_ = 0;
            while(_loc5_ < _loc7_)
            {
               _loc16_ = param1.readUnsignedInt();
               _loc15_ = param1.readUnsignedInt();
               _loc12_ = CONST_COMMON.GetItemIDByType(_loc16_,_loc15_,_loc17_);
               _loc10_.push(_loc12_);
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
            _loc14_.Inventories = _loc9_;
            _loc13_.BoxList.push(_loc14_);
            _loc4_++;
         }
      }
      
      override public function Unstreamize(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform(param1,param2,param3);
      }
   }
}

