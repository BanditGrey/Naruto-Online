package Logics.CrossServerWar
{
   import Logics.Inventories.TInventoryReference;
   
   public class TTokenInventorySample extends TInventoryReference
   {
      
      protected var FIndentifier:uint;
      
      protected var FMajorType:uint;
      
      protected var FTemplateID:uint;
      
      protected var FAmount:int;
      
      protected var FExchangeItem:int;
      
      protected var FExchangeCount:int;
      
      protected var FVipLevel:int;
      
      public function TTokenInventorySample()
      {
         super();
      }
      
      public function get Indentifier() : uint
      {
         return this.FIndentifier;
      }
      
      public function set Indentifier(param1:uint) : void
      {
         this.FIndentifier = param1;
      }
      
      public function get MajorType() : uint
      {
         return this.FMajorType;
      }
      
      public function set MajorType(param1:uint) : void
      {
         this.FMajorType = param1;
      }
      
      public function get TemplateID() : uint
      {
         return this.FTemplateID;
      }
      
      public function set TemplateID(param1:uint) : void
      {
         this.FTemplateID = param1;
      }
      
      public function get Amount() : int
      {
         return this.FAmount;
      }
      
      public function set Amount(param1:int) : void
      {
         this.FAmount = param1;
      }
      
      public function get ExchangeItem() : int
      {
         return this.FExchangeItem;
      }
      
      public function set ExchangeItem(param1:int) : void
      {
         this.FExchangeItem = param1;
      }
      
      public function get ExchangeCount() : int
      {
         return this.FExchangeCount;
      }
      
      public function set ExchangeCount(param1:int) : void
      {
         this.FExchangeCount = param1;
      }
      
      public function get VipLevel() : int
      {
         return this.FVipLevel;
      }
      
      public function set VipLevel(param1:int) : void
      {
         this.FVipLevel = param1;
      }
   }
}

