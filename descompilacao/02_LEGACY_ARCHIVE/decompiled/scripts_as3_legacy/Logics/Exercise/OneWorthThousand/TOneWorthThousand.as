package Logics.Exercise.OneWorthThousand
{
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Lottery.TLotteryNews;
   
   public class TOneWorthThousand extends TBaseActivity
   {
      
      protected var FBoxList:Vector.<TBaseBox>;
      
      protected var FTotalMoney:int;
      
      protected var FGift:TBaseBox;
      
      protected var FSaleList:Vector.<TBaseBox>;
      
      public var NextTime:int;
      
      public var RefreshGold:int;
      
      public var ShowItems:Vector.<TBaseBox>;
      
      public var LuckyList:Vector.<TLotteryNews>;
      
      public function TOneWorthThousand()
      {
         super();
         this.FBoxList = new Vector.<TBaseBox>();
         this.FSaleList = new Vector.<TBaseBox>();
         this.ShowItems = new Vector.<TBaseBox>();
         this.LuckyList = new Vector.<TLotteryNews>();
      }
      
      public function get BoxList() : Vector.<TBaseBox>
      {
         return this.FBoxList;
      }
      
      public function set BoxList(param1:Vector.<TBaseBox>) : void
      {
         this.FBoxList = param1;
      }
      
      public function get TotalMoney() : int
      {
         return this.FTotalMoney;
      }
      
      public function set TotalMoney(param1:int) : void
      {
         this.FTotalMoney = param1;
      }
      
      public function get Gift() : TBaseBox
      {
         return this.FGift;
      }
      
      public function set Gift(param1:TBaseBox) : void
      {
         this.FGift = param1;
      }
      
      public function get SaleList() : Vector.<TBaseBox>
      {
         return this.FSaleList;
      }
      
      public function set SaleList(param1:Vector.<TBaseBox>) : void
      {
         this.FSaleList = param1;
      }
      
      public function ChangeStatus() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc2_ = int(this.FBoxList.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(this.FBoxList[_loc1_].Status == TBaseActivity.STATUS_CANNOTGET && this.FTotalMoney >= this.FBoxList[_loc1_].Price)
            {
               this.FBoxList[_loc1_].Status = TBaseActivity.STATUS_CANGET;
            }
            _loc1_++;
         }
      }
      
      public function CheckStatus() : Boolean
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         this.ChangeStatus();
         _loc2_ = int(this.FBoxList.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(this.FBoxList[_loc1_].Status == TBaseActivity.STATUS_CANGET && this.FBoxList[_loc1_].BuyCount > 0)
            {
               return true;
            }
            _loc1_++;
         }
         if(this.FGift.Status == TBaseActivity.STATUS_CANGET)
         {
            return true;
         }
         return false;
      }
   }
}

