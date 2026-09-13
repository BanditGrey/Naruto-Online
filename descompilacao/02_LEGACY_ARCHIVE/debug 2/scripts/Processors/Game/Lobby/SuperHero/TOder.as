package Processors.Game.Lobby.SuperHero
{
   import Logics.Inventories.TInventory;
   
   public class TOder
   {
      
      protected var FInventory:TInventory;
      
      protected var FMallId:uint;
      
      protected var FCount:int;
      
      public function TOder()
      {
         super();
      }
      
      public function get Count() : int
      {
         return this.FCount;
      }
      
      public function set Count(param1:int) : void
      {
         this.FCount = param1;
      }
      
      public function get MallId() : int
      {
         return this.FMallId;
      }
      
      public function set MallId(param1:int) : void
      {
         this.FMallId = param1;
      }
      
      public function get Inventory() : TInventory
      {
         return this.FInventory;
      }
      
      public function set Inventory(param1:TInventory) : void
      {
         this.FInventory = param1;
      }
      
      public function get TotalCost() : uint
      {
         return this.FCount * this.FInventory.SellValue;
      }
      
      public function get Name() : String
      {
         return this.FInventory.Name;
      }
      
      public function get IDTemplate() : uint
      {
         return this.FInventory.IDTemplate;
      }
   }
}

