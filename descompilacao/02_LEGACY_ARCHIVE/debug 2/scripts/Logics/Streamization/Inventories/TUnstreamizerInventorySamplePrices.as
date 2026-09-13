package Logics.Streamization.Inventories
{
   import Logics.Inventories.TInventorySamplePrice;
   import Logics.Inventories.TInventorySamplePrices;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerInventorySamplePrices extends TUnstreamizerInventoryUnknown
   {
      
      protected var FUnstreamizerInventorySamplePrice:TUnstreamizerInventorySamplePrice;
      
      public function TUnstreamizerInventorySamplePrices()
      {
         super();
         this.FUnstreamizerInventorySamplePrice = new TUnstreamizerInventorySamplePrice();
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform_SamplePricesInfo(param1,param2,param3);
      }
      
      protected function UnstreamizationPerform_SamplePricesInfo(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:TInventorySamplePrices = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:TInventorySamplePrice = null;
         _loc4_ = param2 as TInventorySamplePrices;
         _loc4_.Clear();
         _loc5_ = int(param1.readUnsignedShort());
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            this.FUnstreamizerInventorySamplePrice.Unstreamize(param1,_loc7_,param3);
            _loc4_.Add(_loc7_);
            _loc6_++;
         }
      }
   }
}

