package Logics.Exercise.MayActive2015
{
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   
   public class TMayActive2_2015 extends TBaseActivity
   {
      
      public var FreeCount:int;
      
      public var MyScore:int;
      
      public var ScorePrice:int;
      
      public var AutoPrice:int;
      
      public var RechargeGold:int;
      
      public var BallList:Vector.<int>;
      
      public var GameValue:int;
      
      public var GameStatus:int;
      
      public var GameReward:Vector.<Object>;
      
      public var AutoLog:Vector.<Object>;
      
      public var RewardIndex:int;
      
      public var Hero:TBaseBox;
      
      public var BoxList:Vector.<TBaseBox>;
      
      public var ExchangeItems:Vector.<TBaseBox>;
      
      public function TMayActive2_2015()
      {
         super();
         this.BallList = new Vector.<int>();
         this.GameReward = new Vector.<Object>();
         this.AutoLog = new Vector.<Object>(10);
         this.BoxList = new Vector.<TBaseBox>();
         this.ExchangeItems = new Vector.<TBaseBox>();
      }
      
      public function ChangeStatus() : void
      {
         if(this.Hero.Status != TBaseActivity.STATUS_GETED && this.MyScore >= this.Hero.Price)
         {
            this.Hero.Status = TBaseActivity.STATUS_CANGET;
         }
      }
      
      public function Reset() : void
      {
         this.GameValue = 0;
         this.GameStatus = 0;
      }
   }
}

