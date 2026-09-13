package Logics.Exercise.JanActive_2016
{
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Lottery.TLotteryNews;
   
   public class TJanActive3_2016 extends TBaseActivity
   {
      
      public var Score:int;
      
      public var Price:uint;
      
      public var AutoPrice:uint;
      
      public var ResetPrice:int;
      
      public var GiftStatus:Vector.<int>;
      
      public var TipIndex:int;
      
      public var GiftList:Vector.<TBaseBox>;
      
      public var Hero:TBaseBox;
      
      public var HeroBox:TBaseBox;
      
      public var ExchangeItems:Vector.<TBaseBox>;
      
      public var LuckyList:Vector.<TLotteryNews>;
      
      public function TJanActive3_2016()
      {
         super();
         this.GiftStatus = new Vector.<int>();
         this.ExchangeItems = new Vector.<TBaseBox>();
         this.LuckyList = new Vector.<TLotteryNews>();
      }
      
      public function ChangeStatus() : void
      {
         var _loc1_:int = 0;
      }
      
      public function ResetGame() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < this.GiftStatus.length)
         {
            this.GiftStatus[_loc1_] = TBaseActivity.STATUS_CANNOTGET;
            _loc1_++;
         }
      }
   }
}

