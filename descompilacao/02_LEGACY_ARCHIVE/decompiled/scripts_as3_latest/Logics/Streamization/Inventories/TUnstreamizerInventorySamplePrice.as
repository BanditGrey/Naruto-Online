package Logics.Streamization.Inventories
{
   import Logics.Inventories.TInventorySamplePrice;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerInventorySamplePrice extends TUnstreamizerInventoryUnknown
   {
      
      public function TUnstreamizerInventorySamplePrice()
      {
         super();
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform_Properties(param1,param2,param3);
      }
      
      protected function UnstreamizationPerform_Properties(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:TInventorySamplePrice = null;
         _loc4_ = param2 as TInventorySamplePrice;
         _loc4_.PriceIndex = param1.readUnsignedByte();
         _loc4_.ConsumeValue = param1.readUnsignedInt();
         _loc4_.CurrencyType = param1.readUnsignedByte();
         _loc4_.Price = param1.readUnsignedInt();
         _loc4_.PriceSortID = param1.readUnsignedInt();
      }
   }
}

