package Logics.Exercise.WanSheng
{
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Lottery.TLotteryNews;
   
   public class TWanSheng extends TBaseActivity
   {
      
      public var LimitTimes:int;
      
      public var EggPrice:int;
      
      public var MaxHP:int;
      
      public var CurHP:int;
      
      public var CurBoss:int;
      
      public var TenPrice:int;
      
      public var Score:int;
      
      public var ScorePrice:int;
      
      public var GoldCost:int;
      
      public var CoinCost:int;
      
      public var GiftList:Vector.<TBaseBox>;
      
      public var RechargeBox:Vector.<TBaseBox>;
      
      public var ConsumeBox:TBaseBox;
      
      public var SweetList:Vector.<TBaseBox>;
      
      public var ShowItems:TInventories;
      
      public var BossList:Vector.<TBaseBox>;
      
      public var LuckyList:Vector.<TLotteryNews>;
      
      public var NextBoss:int;
      
      public var NextHP:int;
      
      public var StatusList:Vector.<int>;
      
      public var IndexList:Vector.<int>;
      
      public var AmountList:Vector.<int>;
      
      public var CurBossList:Vector.<int>;
      
      public var HpList:Vector.<int>;
      
      public var MaxHpList:Vector.<int>;
      
      public function TWanSheng()
      {
         super();
         this.GiftList = new Vector.<TBaseBox>();
         this.RechargeBox = new Vector.<TBaseBox>();
         this.SweetList = new Vector.<TBaseBox>();
         this.BossList = new Vector.<TBaseBox>();
         this.LuckyList = new Vector.<TLotteryNews>();
         this.StatusList = new Vector.<int>();
         this.IndexList = new Vector.<int>();
         this.AmountList = new Vector.<int>();
         this.CurBossList = new Vector.<int>();
         this.HpList = new Vector.<int>();
         this.MaxHpList = new Vector.<int>();
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

