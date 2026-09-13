package Logics.Exercise.GoldTree
{
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Lottery.TLotteryNews;
   
   public class TGoldTree extends TBaseActivity
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
      
      public var ReturnType:int;
      
      public var ReturnList:Vector.<TBaseBox>;
      
      public var TreeList:Vector.<TBaseBox>;
      
      public var WaterLogList:Vector.<TLotteryNews>;
      
      public var ShowItems:TInventories;
      
      public function TGoldTree()
      {
         super();
         this.ReturnList = new Vector.<TBaseBox>();
         this.TreeList = new Vector.<TBaseBox>();
         this.WaterLogList = new Vector.<TLotteryNews>();
      }
      
      public function ChangeStatus() : void
      {
      }
      
      public function CheckStatus() : Boolean
      {
         if(this.WaterCount > 0)
         {
            return true;
         }
         return false;
      }
   }
}

