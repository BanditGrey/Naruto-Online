package Logics.Exercise.FateRoulette
{
   import Logics.Exercise.TActivityTaskData;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   
   public class TFateRoulette extends TBaseActivity
   {
      
      public var MyScore:int;
      
      public var FreeCount:int;
      
      public var ScorePrice:int;
      
      public var AutoPrice:int;
      
      public var BallList:Vector.<int>;
      
      public var GameValue:int;
      
      public var GameStatus:int;
      
      public var GameReward:Vector.<Object>;
      
      public var AutoLog:Vector.<Object>;
      
      public var RewardIndex:int;
      
      public var Hero:TBaseBox;
      
      public var BoxList:Vector.<TBaseBox>;
      
      public var ExchangeItems:Vector.<TBaseBox>;
      
      public var ShowItems:TInventories;
      
      public var TitleList:Vector.<uint>;
      
      public var GiftList:Vector.<TBaseBox>;
      
      public var ActivityTaskData:TActivityTaskData;
      
      public function TFateRoulette()
      {
         super();
         this.ActivityTaskData = new TActivityTaskData();
         this.BallList = new Vector.<int>();
         this.GameReward = new Vector.<Object>();
         this.AutoLog = new Vector.<Object>(10);
         this.BoxList = new Vector.<TBaseBox>();
         this.ExchangeItems = new Vector.<TBaseBox>();
         this.TitleList = new Vector.<uint>();
         this.GiftList = new Vector.<TBaseBox>();
      }
      
      public function ChangeStatus() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < this.BoxList.length)
         {
            if(this.BoxList[_loc1_].Status == TBaseActivity.STATUS_CANNOTGET && TotalConsumeGold >= this.BoxList[_loc1_].Price)
            {
               this.BoxList[_loc1_].Status = TBaseActivity.STATUS_CANGET;
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this.GiftList.length)
         {
            if(this.GiftList[_loc1_].Status == TBaseActivity.STATUS_CANNOTGET && this.MyScore >= this.GiftList[_loc1_].Price)
            {
               this.GiftList[_loc1_].Status = TBaseActivity.STATUS_CANGET;
            }
            _loc1_++;
         }
      }
      
      public function CheckStatus() : Boolean
      {
         return false;
      }
      
      public function Reset() : void
      {
         this.GameValue = 0;
         this.GameStatus = 0;
      }
   }
}

