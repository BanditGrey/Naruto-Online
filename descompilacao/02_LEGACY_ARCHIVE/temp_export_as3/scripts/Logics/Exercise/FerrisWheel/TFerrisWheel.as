package Logics.Exercise.FerrisWheel
{
   import Logics.Exercise.TBaseActivity;
   import Logics.Inventories.TInventories;
   import Logics.Lottery.TLotteryNews;
   
   public class TFerrisWheel extends TBaseActivity
   {
      
      protected var FGoldCounts:int;
      
      protected var FFreeCounts:int;
      
      protected var FTodayCounts:int;
      
      protected var FMaxCounts:int;
      
      protected var FGoldAddCounts:int;
      
      protected var FRechargeGold:int;
      
      protected var FGoldItems:TInventories;
      
      protected var FFreeItems:TInventories;
      
      protected var FNewsList:Vector.<TLotteryNews>;
      
      public var FreeOtherCounts:int;
      
      public function TFerrisWheel()
      {
         super();
         this.FNewsList = new Vector.<TLotteryNews>();
      }
      
      public function get GoldCounts() : int
      {
         return this.FGoldCounts;
      }
      
      public function set GoldCounts(param1:int) : void
      {
         this.FGoldCounts = param1;
      }
      
      public function get FreeCounts() : int
      {
         return this.FFreeCounts;
      }
      
      public function set FreeCounts(param1:int) : void
      {
         this.FFreeCounts = param1;
      }
      
      public function get TodayCounts() : int
      {
         return this.FTodayCounts;
      }
      
      public function set TodayCounts(param1:int) : void
      {
         this.FTodayCounts = param1;
      }
      
      public function get MaxCounts() : int
      {
         return this.FMaxCounts;
      }
      
      public function set MaxCounts(param1:int) : void
      {
         this.FMaxCounts = param1;
      }
      
      public function get GoldAddCounts() : int
      {
         return this.FGoldAddCounts;
      }
      
      public function set GoldAddCounts(param1:int) : void
      {
         this.FGoldAddCounts = param1;
      }
      
      public function get GoldItems() : TInventories
      {
         return this.FGoldItems;
      }
      
      public function set GoldItems(param1:TInventories) : void
      {
         this.FGoldItems = param1;
      }
      
      public function get FreeItems() : TInventories
      {
         return this.FFreeItems;
      }
      
      public function set FreeItems(param1:TInventories) : void
      {
         this.FFreeItems = param1;
      }
      
      public function get NewsList() : Vector.<TLotteryNews>
      {
         return this.FNewsList;
      }
      
      public function set NewsList(param1:Vector.<TLotteryNews>) : void
      {
         this.FNewsList = param1;
      }
      
      public function get RechargeGold() : int
      {
         return this.FRechargeGold;
      }
      
      public function set RechargeGold(param1:int) : void
      {
         this.FRechargeGold = param1;
      }
      
      public function ChangeStatus() : void
      {
      }
      
      public function CheckStatus() : Boolean
      {
         if(this.FGoldCounts > 0 && this.FTodayCounts < this.FMaxCounts)
         {
            return true;
         }
         if(this.FFreeCounts > 0 && this.FTodayCounts < this.FMaxCounts)
         {
            return true;
         }
         if(this.FreeOtherCounts > 0 && this.FTodayCounts < this.FMaxCounts)
         {
            return true;
         }
         return false;
      }
   }
}

