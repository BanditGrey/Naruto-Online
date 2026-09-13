package Logics.Inventories
{
   import Foundation.Common.Stubs.TStubReferences;
   
   public class TInventorySamplePrice
   {
      
      protected var FStubReferences:TStubReferences;
      
      protected var FPriceIndex:uint;
      
      protected var FConsumeValue:uint;
      
      protected var FCurrencyType:uint;
      
      protected var FPrice:uint;
      
      protected var FPriceSortID:uint;
      
      public function TInventorySamplePrice()
      {
         super();
         this.FStubReferences = new TStubReferences(this);
      }
      
      public function get StubReferences() : TStubReferences
      {
         return this.FStubReferences;
      }
      
      public function get PriceIndex() : uint
      {
         return this.FPriceIndex;
      }
      
      public function set PriceIndex(param1:uint) : void
      {
         this.FPriceIndex = param1;
      }
      
      public function get ConsumeValue() : uint
      {
         return this.FConsumeValue;
      }
      
      public function set ConsumeValue(param1:uint) : void
      {
         this.FConsumeValue = param1;
      }
      
      public function get CurrencyType() : uint
      {
         return this.FCurrencyType;
      }
      
      public function set CurrencyType(param1:uint) : void
      {
         this.FCurrencyType = param1;
      }
      
      public function get Price() : uint
      {
         return this.FPrice;
      }
      
      public function set Price(param1:uint) : void
      {
         this.FPrice = param1;
      }
      
      public function get PriceSortID() : uint
      {
         return this.FPriceSortID;
      }
      
      public function set PriceSortID(param1:uint) : void
      {
         this.FPriceSortID = param1;
      }
      
      public function Clear() : void
      {
         this.FPriceIndex = 0;
         this.FConsumeValue = 0;
         this.FCurrencyType = 0;
         this.FPrice = 0;
         this.FPriceSortID = 0;
      }
   }
}

