package Logics.Exercise.NinjaBank
{
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   
   public class TNinjaBank extends TBaseActivity
   {
      
      protected var FSecondTime:int;
      
      protected var FCanBuyCount:int;
      
      protected var FBoughtCount:int;
      
      protected var FCurBuyIndex:int;
      
      protected var FMoney:int;
      
      protected var FPrice:int;
      
      protected var FRechargeGold:int;
      
      protected var FBuyDiscount:int;
      
      protected var FOpenBoxCount:int;
      
      protected var FDayList:Vector.<int>;
      
      protected var FAwardStatus:int;
      
      protected var FNextAwardTime:int;
      
      protected var FCurDay:int;
      
      protected var FGameStatus:int;
      
      protected var FReturnGold:int;
      
      protected var FReturnItems:TBaseBox;
      
      protected var FCurPrice:int;
      
      protected var FShowInventories:TInventories;
      
      protected var FBoxList:Vector.<TBaseBox>;
      
      protected var FOpenBoxList:Vector.<TBaseBox>;
      
      public function TNinjaBank()
      {
         super();
         this.FBoxList = new Vector.<TBaseBox>();
         this.FOpenBoxList = new Vector.<TBaseBox>();
         this.FDayList = new Vector.<int>();
      }
      
      public function get BoxList() : Vector.<TBaseBox>
      {
         return this.FBoxList;
      }
      
      public function set BoxList(param1:Vector.<TBaseBox>) : void
      {
         this.FBoxList = param1;
      }
      
      public function get CanBuyCount() : int
      {
         return this.FCanBuyCount;
      }
      
      public function set CanBuyCount(param1:int) : void
      {
         this.FCanBuyCount = param1;
      }
      
      public function get BoughtCount() : int
      {
         return this.FBoughtCount;
      }
      
      public function set BoughtCount(param1:int) : void
      {
         this.FBoughtCount = param1;
      }
      
      public function get CurBuyIndex() : int
      {
         return this.FCurBuyIndex;
      }
      
      public function set CurBuyIndex(param1:int) : void
      {
         this.FCurBuyIndex = param1;
      }
      
      public function get Money() : int
      {
         return this.FMoney;
      }
      
      public function set Money(param1:int) : void
      {
         this.FMoney = param1;
      }
      
      public function get SecondTime() : int
      {
         return this.FSecondTime;
      }
      
      public function set SecondTime(param1:int) : void
      {
         this.FSecondTime = param1;
      }
      
      public function get Price() : int
      {
         return this.FPrice;
      }
      
      public function set Price(param1:int) : void
      {
         this.FPrice = param1;
      }
      
      public function get RechargeGold() : int
      {
         return this.FRechargeGold;
      }
      
      public function set RechargeGold(param1:int) : void
      {
         this.FRechargeGold = param1;
      }
      
      public function get BuyDiscount() : int
      {
         return this.FBuyDiscount;
      }
      
      public function set BuyDiscount(param1:int) : void
      {
         this.FBuyDiscount = param1;
      }
      
      public function get OpenBoxCount() : int
      {
         return this.FOpenBoxCount;
      }
      
      public function set OpenBoxCount(param1:int) : void
      {
         this.FOpenBoxCount = param1;
      }
      
      public function get ShowInventories() : TInventories
      {
         return this.FShowInventories;
      }
      
      public function set ShowInventories(param1:TInventories) : void
      {
         this.FShowInventories = param1;
      }
      
      public function get OpenBoxList() : Vector.<TBaseBox>
      {
         return this.FOpenBoxList;
      }
      
      public function set OpenBoxList(param1:Vector.<TBaseBox>) : void
      {
         this.FOpenBoxList = param1;
      }
      
      public function get DayList() : Vector.<int>
      {
         return this.FDayList;
      }
      
      public function set DayList(param1:Vector.<int>) : void
      {
         this.FDayList = param1;
      }
      
      public function get AwardStatus() : int
      {
         return this.FAwardStatus;
      }
      
      public function set AwardStatus(param1:int) : void
      {
         this.FAwardStatus = param1;
      }
      
      public function get CurDay() : int
      {
         return this.FCurDay;
      }
      
      public function set CurDay(param1:int) : void
      {
         this.FCurDay = param1;
      }
      
      public function get NextAwardTime() : int
      {
         return this.FNextAwardTime;
      }
      
      public function set NextAwardTime(param1:int) : void
      {
         this.FNextAwardTime = param1;
      }
      
      public function get GameStatus() : int
      {
         return this.FGameStatus;
      }
      
      public function set GameStatus(param1:int) : void
      {
         this.FGameStatus = param1;
      }
      
      public function get ReturnGold() : int
      {
         return this.FReturnGold;
      }
      
      public function set ReturnGold(param1:int) : void
      {
         this.FReturnGold = param1;
      }
      
      public function get ReturnItems() : TBaseBox
      {
         return this.FReturnItems;
      }
      
      public function set ReturnItems(param1:TBaseBox) : void
      {
         this.FReturnItems = param1;
      }
      
      public function get CurPrice() : int
      {
         return this.FCurPrice;
      }
      
      public function set CurPrice(param1:int) : void
      {
         this.FCurPrice = param1;
      }
      
      public function ChangeStatus() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TBaseBox = null;
         _loc2_ = int(this.FOpenBoxList.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FOpenBoxList[_loc1_];
            if(_loc3_.Status == TBaseActivity.STATUS_CANNOTGET && this.FBoughtCount - this.FOpenBoxCount >= _loc3_.Price)
            {
               _loc3_.Status = TBaseActivity.STATUS_CANGET;
            }
            _loc1_++;
         }
      }
      
      public function CheckStatus() : Boolean
      {
         return false;
      }
   }
}

