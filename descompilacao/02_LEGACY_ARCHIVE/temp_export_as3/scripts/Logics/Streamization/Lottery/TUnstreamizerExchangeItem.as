package Logics.Streamization.Lottery
{
   import Foundation.Streamization.TUnstreamizer;
   import Logics.Inventories.TInventories;
   import Logics.Lottery.TExchangeItem;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerExchangeItem extends TUnstreamizer
   {
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      public function TUnstreamizerExchangeItem()
      {
         super();
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:uint = 0;
         var _loc7_:Vector.<uint> = null;
         var _loc8_:TExchangeItem = null;
         var _loc9_:Vector.<TExchangeItem> = null;
         var _loc10_:TInventories = null;
         _loc9_ = param2 as Vector.<TExchangeItem>;
         _loc7_ = new Vector.<uint>();
         _loc10_ = new TInventories();
         _loc5_ = int(param1.readUnsignedShort());
         _loc9_.length = 0;
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc8_ = new TExchangeItem();
            _loc8_.Identify = param1.readUnsignedInt();
            _loc6_ = param1.readUnsignedInt();
            _loc8_.LimitLevel = param1.readUnsignedInt();
            _loc7_.length = 0;
            _loc7_.push(_loc6_);
            _loc10_ = new TInventories();
            this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc10_,_loc7_);
            _loc8_.Inventories = _loc10_;
            _loc8_.Inventories.GetInventoryByIndex(0).Quantity = 1;
            _loc8_.CostPoint = param1.readUnsignedInt();
            _loc8_.LimitCount = param1.readUnsignedInt();
            _loc8_.BuyCount = param1.readUnsignedInt();
            _loc9_.push(_loc8_);
            _loc4_++;
         }
      }
      
      override public function Unstreamize(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform(param1,param2,param3);
      }
   }
}

