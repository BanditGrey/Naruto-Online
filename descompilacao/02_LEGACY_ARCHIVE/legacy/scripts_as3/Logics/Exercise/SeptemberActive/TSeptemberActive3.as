package Logics.Exercise.SeptemberActive
{
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Lottery.TLotteryNews;
   
   public class TSeptemberActive3 extends TBaseActivity
   {
      
      protected var FTotalCount:int;
      
      protected var FMyScore:int;
      
      protected var FPoolGold:int;
      
      protected var FScorePrice:int;
      
      protected var FWishIndex:int;
      
      protected var FItemAID:uint;
      
      protected var FItemBID:uint;
      
      protected var FShowItems:TInventories;
      
      protected var FServerBoxList:Vector.<TBaseBox>;
      
      protected var FLuckyList:Vector.<Object>;
      
      protected var FBoxList:Vector.<TBaseBox>;
      
      protected var FServerNews:Vector.<TLotteryNews>;
      
      protected var FEquipments:TInventories;
      
      public function TSeptemberActive3()
      {
         super();
         this.FLuckyList = new Vector.<Object>();
         this.FServerBoxList = new Vector.<TBaseBox>();
         this.FBoxList = new Vector.<TBaseBox>();
         this.FServerNews = new Vector.<TLotteryNews>();
      }
      
      public function get TotalCount() : int
      {
         return this.FTotalCount;
      }
      
      public function set TotalCount(param1:int) : void
      {
         this.FTotalCount = param1;
      }
      
      public function get MyScore() : int
      {
         return this.FMyScore;
      }
      
      public function set MyScore(param1:int) : void
      {
         this.FMyScore = param1;
      }
      
      public function get PoolGold() : int
      {
         return this.FPoolGold;
      }
      
      public function set PoolGold(param1:int) : void
      {
         this.FPoolGold = param1;
      }
      
      public function get ScorePrice() : int
      {
         return this.FScorePrice;
      }
      
      public function set ScorePrice(param1:int) : void
      {
         this.FScorePrice = param1;
      }
      
      public function get ShowItems() : TInventories
      {
         return this.FShowItems;
      }
      
      public function set ShowItems(param1:TInventories) : void
      {
         this.FShowItems = param1;
      }
      
      public function get ServerBoxList() : Vector.<TBaseBox>
      {
         return this.FServerBoxList;
      }
      
      public function set ServerBoxList(param1:Vector.<TBaseBox>) : void
      {
         this.FServerBoxList = param1;
      }
      
      public function get LuckyList() : Vector.<Object>
      {
         return this.FLuckyList;
      }
      
      public function set LuckyList(param1:Vector.<Object>) : void
      {
         this.FLuckyList = param1;
      }
      
      public function get BoxList() : Vector.<TBaseBox>
      {
         return this.FBoxList;
      }
      
      public function set BoxList(param1:Vector.<TBaseBox>) : void
      {
         this.FBoxList = param1;
      }
      
      public function get WishIndex() : int
      {
         return this.FWishIndex;
      }
      
      public function set WishIndex(param1:int) : void
      {
         this.FWishIndex = param1;
      }
      
      public function get ItemAID() : uint
      {
         return this.FItemAID;
      }
      
      public function set ItemAID(param1:uint) : void
      {
         this.FItemAID = param1;
      }
      
      public function get ItemBID() : uint
      {
         return this.FItemBID;
      }
      
      public function set ItemBID(param1:uint) : void
      {
         this.FItemBID = param1;
      }
      
      public function get ServerNews() : Vector.<TLotteryNews>
      {
         return this.FServerNews;
      }
      
      public function set ServerNews(param1:Vector.<TLotteryNews>) : void
      {
         this.FServerNews = param1;
      }
      
      public function ChangeStatus() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
      }
   }
}

