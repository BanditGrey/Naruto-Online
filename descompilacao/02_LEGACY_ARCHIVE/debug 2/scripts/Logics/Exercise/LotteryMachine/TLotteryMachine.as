package Logics.Exercise.LotteryMachine
{
   import Logics.Exercise.TBaseActivity;
   import Logics.Inventories.TInventories;
   import Logics.Lottery.TLotteryNews;
   
   public class TLotteryMachine extends TBaseActivity
   {
      
      public var GiftStatus:int;
      
      public var NeedGold:int;
      
      public var LotteryCount:int;
      
      public var Items:TInventories;
      
      public var RateList:Vector.<int>;
      
      public var NewsList:Vector.<TLotteryNews>;
      
      public function TLotteryMachine()
      {
         super();
         this.Items = new TInventories();
         this.RateList = new Vector.<int>();
         this.NewsList = new Vector.<TLotteryNews>();
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

