package Logics.Streamization.SuperHero
{
   import Foundation.Streamization.TUnstreamizer;
   import Logics.Inventories.TInventories;
   import Logics.Items.TItem;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerSuperHero extends TUnstreamizer
   {
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      public function TUnstreamizerSuperHero()
      {
         super();
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:Vector.<TItem> = null;
         var _loc5_:TInventories = null;
         var _loc6_:Vector.<uint> = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:TItem = null;
         _loc5_ = param2 as TInventories;
         _loc4_ = param3 as Vector.<TItem>;
         _loc6_ = new Vector.<uint>();
         _loc8_ = int(_loc4_.length);
         _loc7_ = 0;
         while(_loc7_ < _loc8_)
         {
            _loc9_ = _loc4_[_loc7_];
            if(_loc9_.Type == 1)
            {
               _loc6_.push(_loc9_.ID);
            }
            _loc7_++;
         }
         this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc5_,_loc6_);
         _loc9_ = _loc4_[0];
         _loc5_.GetInventoryByIndex(0).Quantity = _loc9_.Count;
      }
      
      override public function Unstreamize(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform(param1,param2,param3);
      }
   }
}

