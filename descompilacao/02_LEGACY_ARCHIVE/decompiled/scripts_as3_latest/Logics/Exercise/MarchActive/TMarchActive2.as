package Logics.Exercise.MarchActive
{
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Lottery.TLotteryNews;
   
   public class TMarchActive2 extends TBaseActivity
   {
      
      public var FreeCount:int;
      
      public var MyScore:int;
      
      public var ScorePrice:int;
      
      public var AutoPrice:int;
      
      public var RechargeGold:int;
      
      public var Hero:TBaseBox;
      
      public var BoxList:Vector.<TBaseBox>;
      
      public var ExchangeItems:Vector.<TBaseBox>;
      
      public var NewsList:Vector.<TLotteryNews>;
      
      public var HoleList:Vector.<int>;
      
      public function TMarchActive2()
      {
         super();
         this.BoxList = new Vector.<TBaseBox>();
         this.ExchangeItems = new Vector.<TBaseBox>();
         this.NewsList = new Vector.<TLotteryNews>();
         this.HoleList = new Vector.<int>(10);
      }
      
      public function ChangeStatus() : void
      {
         if(this.Hero.Status != TBaseActivity.STATUS_GETED && this.MyScore >= this.Hero.Price)
         {
            this.Hero.Status = TBaseActivity.STATUS_CANGET;
         }
      }
   }
}

