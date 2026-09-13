package Processors.Game.Lobby.Shop.data
{
   import Logics.DatebaseVO.VO.TItemMall;
   import Logics.Inventories.TInventory;
   
   public class ShopCellData
   {
      
      protected var FItemMall:TItemMall;
      
      protected var FCanBuyCount:int;
      
      protected var FTodayCanBuyCount:int;
      
      protected var FInventory:TInventory;
      
      public function ShopCellData()
      {
         super();
      }
      
      public function set ItemMall(param1:TItemMall) : void
      {
         this.FItemMall = param1;
         this.FCanBuyCount = param1.Maxbuy;
         this.FTodayCanBuyCount = param1.Daybuy;
      }
      
      public function get ItemMall() : TItemMall
      {
         return this.FItemMall;
      }
      
      public function set CanBuyCount(param1:int) : void
      {
         this.FCanBuyCount = param1;
      }
      
      public function get CanBuyCount() : int
      {
         return this.FCanBuyCount;
      }
      
      public function set TodayCanBuyCount(param1:int) : void
      {
         this.FTodayCanBuyCount = param1;
      }
      
      public function get TodayCanBuyCount() : int
      {
         return this.FTodayCanBuyCount;
      }
      
      public function set Inventory(param1:TInventory) : void
      {
         this.FInventory = param1;
      }
      
      public function get Inventory() : TInventory
      {
         return this.FInventory;
      }
   }
}

