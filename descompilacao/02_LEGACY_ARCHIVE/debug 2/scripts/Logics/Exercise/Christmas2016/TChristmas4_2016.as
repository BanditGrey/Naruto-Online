package Logics.Exercise.Christmas2016
{
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Lottery.TLotteryNews;
   
   public class TChristmas4_2016 extends TBaseActivity
   {
      
      public static const TYPE_GOLD:int = 3;
      
      public static const TYPE_GIFT:int = 1;
      
      public var LimitCount:int;
      
      public var Price:int;
      
      public var CurFund:int;
      
      public var FundList:Vector.<TBaseBox>;
      
      public var EggList:Vector.<int>;
      
      public var LuckyList:Vector.<TLotteryNews>;
      
      public var NewsList:Vector.<TLotteryNews>;
      
      public var IsEnd:int;
      
      public function TChristmas4_2016()
      {
         super();
         this.FundList = new Vector.<TBaseBox>();
         this.EggList = new Vector.<int>();
         this.LuckyList = new Vector.<TLotteryNews>();
         this.NewsList = new Vector.<TLotteryNews>();
      }
      
      public function ChangeStatus() : void
      {
      }
      
      public function ResetEgg() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < this.EggList.length)
         {
            this.EggList[_loc1_] = 0;
            _loc1_++;
         }
         this.IsEnd = 0;
      }
   }
}

