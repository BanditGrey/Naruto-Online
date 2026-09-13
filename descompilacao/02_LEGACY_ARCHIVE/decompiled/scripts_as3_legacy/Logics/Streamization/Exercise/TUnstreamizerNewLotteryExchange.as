package Logics.Streamization.Exercise
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Streamization.TUnstreamizer;
   import Logics.Inventories.TInventories;
   import Logics.Lottery.TExchangeItem;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerNewLotteryExchange extends TUnstreamizer
   {
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      public function TUnstreamizerNewLotteryExchange()
      {
         super();
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:Vector.<uint> = null;
         var _loc10_:Vector.<uint> = null;
         var _loc11_:TExchangeItem = null;
         var _loc12_:Vector.<TExchangeItem> = null;
         var _loc13_:TInventories = null;
         var _loc14_:TBins = null;
         _loc12_ = param2 as Vector.<TExchangeItem>;
         _loc9_ = new Vector.<uint>();
         _loc10_ = new Vector.<uint>();
         _loc14_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         _loc5_ = int(param1.readUnsignedShort());
         _loc12_.length = 0;
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc11_ = new TExchangeItem();
            _loc11_.Identify = _loc4_ + 1;
            _loc11_.LimitCount = param1.readUnsignedInt();
            _loc11_.OriginalCost = param1.readUnsignedInt();
            _loc11_.CostPoint = param1.readUnsignedInt();
            _loc11_.LimitLevel = param1.readUnsignedInt();
            _loc11_.IsHot = param1.readUnsignedInt();
            _loc11_.BuyCount = param1.readUnsignedInt();
            _loc11_.IsOwn = param1.readUnsignedInt();
            _loc13_ = new TInventories();
            _loc9_.length = 0;
            _loc10_.length = 0;
            _loc7_ = param1.readUnsignedInt();
            _loc6_ = param1.readUnsignedInt();
            _loc8_ = CONST_COMMON.GetItemIDByType(_loc7_,_loc6_,_loc14_);
            _loc9_.push(_loc8_);
            this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc13_,_loc9_);
            _loc13_.GetInventoryByIndex(0).Quantity = param1.readUnsignedInt();
            _loc11_.Inventories = _loc13_;
            _loc12_.push(_loc11_);
            _loc4_++;
         }
      }
      
      override public function Unstreamize(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform(param1,param2,param3);
      }
   }
}

