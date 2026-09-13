package Logics.Exercise.CloudBuy
{
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   
   public class TCloudBuy extends TBaseActivity
   {
      
      public static const GAME_STATUS_1:int = 1;
      
      public static const GAME_STATUS_2:int = 2;
      
      public static const GAME_STATUS_3:int = 3;
      
      protected var FRemainCount:int;
      
      protected var FBoughtCount:int;
      
      protected var FMyCount:int;
      
      protected var FPrice:int;
      
      protected var FNextTime:int;
      
      protected var FGameStatus:int;
      
      protected var FBuySuccess:int;
      
      protected var FLuckyGuy:String;
      
      protected var FItemCost:int;
      
      protected var FItems:TInventories;
      
      protected var FLastItems:Vector.<TBaseBox>;
      
      protected var FNewsList:Vector.<String>;
      
      public function TCloudBuy()
      {
         super();
         this.FLastItems = new Vector.<TBaseBox>();
         this.FNewsList = new Vector.<String>();
      }
      
      public function get RemainCount() : int
      {
         return this.FRemainCount;
      }
      
      public function set RemainCount(param1:int) : void
      {
         this.FRemainCount = param1;
      }
      
      public function get BoughtCount() : int
      {
         return this.FBoughtCount;
      }
      
      public function set BoughtCount(param1:int) : void
      {
         this.FBoughtCount = param1;
      }
      
      public function get Price() : int
      {
         return this.FPrice;
      }
      
      public function set Price(param1:int) : void
      {
         this.FPrice = param1;
      }
      
      public function get Items() : TInventories
      {
         return this.FItems;
      }
      
      public function set Items(param1:TInventories) : void
      {
         this.FItems = param1;
      }
      
      public function get MyCount() : int
      {
         return this.FMyCount;
      }
      
      public function set MyCount(param1:int) : void
      {
         this.FMyCount = param1;
      }
      
      public function get NextTime() : int
      {
         return this.FNextTime;
      }
      
      public function set NextTime(param1:int) : void
      {
         this.FNextTime = param1;
      }
      
      public function get GameStatus() : int
      {
         return this.FGameStatus;
      }
      
      public function set GameStatus(param1:int) : void
      {
         this.FGameStatus = param1;
      }
      
      public function get BuySuccess() : int
      {
         return this.FBuySuccess;
      }
      
      public function set BuySuccess(param1:int) : void
      {
         this.FBuySuccess = param1;
      }
      
      public function get LuckyGuy() : String
      {
         return this.FLuckyGuy;
      }
      
      public function set LuckyGuy(param1:String) : void
      {
         this.FLuckyGuy = param1;
      }
      
      public function get LastItems() : Vector.<TBaseBox>
      {
         return this.FLastItems;
      }
      
      public function set LastItems(param1:Vector.<TBaseBox>) : void
      {
         this.FLastItems = param1;
      }
      
      public function get NewsList() : Vector.<String>
      {
         return this.FNewsList;
      }
      
      public function set NewsList(param1:Vector.<String>) : void
      {
         this.FNewsList = param1;
      }
      
      public function get ItemCost() : int
      {
         return this.FItemCost;
      }
      
      public function set ItemCost(param1:int) : void
      {
         this.FItemCost = param1;
      }
      
      public function ChangeStatus() : void
      {
      }
      
      public function CheckStatus() : Boolean
      {
         return false;
      }
   }
}

