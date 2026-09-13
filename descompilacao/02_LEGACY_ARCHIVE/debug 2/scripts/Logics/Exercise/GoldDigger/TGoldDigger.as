package Logics.Exercise.GoldDigger
{
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Lottery.TLotteryNews;
   
   public class TGoldDigger extends TBaseActivity
   {
      
      public var ReturnType:int;
      
      public var CurIndex:int;
      
      public var PoolGold:int;
      
      public var BoxList:Vector.<TBaseBox>;
      
      public var Gift:TBaseBox;
      
      public var NewsList:Vector.<TLotteryNews>;
      
      public function TGoldDigger()
      {
         super();
         this.BoxList = new Vector.<TBaseBox>();
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

