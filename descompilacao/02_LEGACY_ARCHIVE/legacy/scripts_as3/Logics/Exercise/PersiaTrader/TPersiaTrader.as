package Logics.Exercise.PersiaTrader
{
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Exercise.TBaseBoxes;
   import Logics.Inventories.TInventories;
   import Logics.Lottery.TLotteryNews;
   
   public class TPersiaTrader extends TBaseActivity
   {
      
      public var Score:int;
      
      public var NextTime:int;
      
      public var FreshPrice:int;
      
      public var FreshSingleItem:Vector.<int>;
      
      public var FreshSinglePrice:Vector.<int>;
      
      public var SaleItems:Vector.<TBaseBox>;
      
      public var SaleLogs:Vector.<TBaseBox>;
      
      public var ExchangeItems:Vector.<TBaseBox>;
      
      public var ShowList:Vector.<TBaseBoxes>;
      
      public var HotList:TInventories;
      
      public var LuckyList:Vector.<TLotteryNews>;
      
      public var PetID:int;
      
      public var HeroID:int;
      
      public function TPersiaTrader()
      {
         super();
         this.FreshSingleItem = new Vector.<int>();
         this.FreshSinglePrice = new Vector.<int>();
         this.SaleItems = new Vector.<TBaseBox>();
         this.SaleLogs = new Vector.<TBaseBox>();
         this.ExchangeItems = new Vector.<TBaseBox>();
         this.ShowList = new Vector.<TBaseBoxes>();
         this.LuckyList = new Vector.<TLotteryNews>();
      }
      
      public function ChangeStatus() : void
      {
      }
      
      public function CheckStatus() : Boolean
      {
         return false;
      }
      
      public function IsHaveSpecialGood() : Boolean
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < this.SaleItems.length)
         {
            if(this.SaleItems[_loc1_].Level == 1)
            {
               return true;
            }
            _loc1_++;
         }
         return false;
      }
   }
}

