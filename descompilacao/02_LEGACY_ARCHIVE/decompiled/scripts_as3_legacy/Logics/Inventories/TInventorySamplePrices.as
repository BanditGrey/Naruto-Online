package Logics.Inventories
{
   public class TInventorySamplePrices
   {
      
      protected var FInventorySamplePrice:Vector.<TInventorySamplePrice>;
      
      public function TInventorySamplePrices()
      {
         super();
         this.FInventorySamplePrice = new Vector.<TInventorySamplePrice>();
      }
      
      protected function SortRoutineSequenceID(param1:TInventorySamplePrice, param2:TInventorySamplePrice) : int
      {
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         _loc3_ = param1.PriceSortID;
         _loc4_ = param2.PriceSortID;
         if(_loc3_ > _loc4_)
         {
            return 1;
         }
         if(_loc3_ <= _loc4_)
         {
            return -1;
         }
         return 0;
      }
      
      public function get Count() : int
      {
         return this.FInventorySamplePrice.length;
      }
      
      public function GetPriceInfoByIndex(param1:int) : TInventorySamplePrice
      {
         return this.FInventorySamplePrice[param1];
      }
      
      public function Clear() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TInventorySamplePrice = null;
         _loc1_ = int(this.FInventorySamplePrice.length);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this.FInventorySamplePrice[_loc2_];
            if(_loc3_ != null)
            {
               _loc3_.StubReferences.Dereference(this);
            }
            _loc2_++;
         }
         this.FInventorySamplePrice.length = 0;
      }
      
      public function Add(param1:TInventorySamplePrice) : void
      {
         param1.StubReferences.Reference(this);
         this.FInventorySamplePrice.push(param1);
      }
      
      public function SortBySequenceID() : void
      {
         this.FInventorySamplePrice.sort(this.SortRoutineSequenceID);
      }
   }
}

