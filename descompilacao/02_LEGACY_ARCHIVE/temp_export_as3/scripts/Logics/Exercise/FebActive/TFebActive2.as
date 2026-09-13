package Logics.Exercise.FebActive
{
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Lottery.TLotteryNews;
   
   public class TFebActive2 extends TBaseActivity
   {
      
      public static const STATUS_OF_PLANT:int = 1;
      
      public static const STATUS_OF_RETURN:int = 2;
      
      public var GameStatus:int;
      
      public var RechargeGold:int;
      
      public var ConsumeGold:int;
      
      public var CurTreeLevel:int;
      
      public var CurTreeValue:int;
      
      public var WaterCount:int;
      
      public var ConsumeAddTimes:int;
      
      public var RechargeAddTimes:int;
      
      public var TotalRecharge:int;
      
      public var GetTime:int;
      
      public var CurReturn:TBaseBox;
      
      public var TreeList:Vector.<TBaseBox>;
      
      public var WaterLogList:Vector.<TLotteryNews>;
      
      public function TFebActive2()
      {
         super();
         this.TreeList = new Vector.<TBaseBox>();
         this.WaterLogList = new Vector.<TLotteryNews>();
      }
      
      public function ChangeStatus() : void
      {
      }
   }
}

