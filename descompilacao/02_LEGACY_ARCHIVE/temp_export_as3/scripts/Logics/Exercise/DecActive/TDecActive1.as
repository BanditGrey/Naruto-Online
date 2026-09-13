package Logics.Exercise.DecActive
{
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   
   public class TDecActive1 extends TBaseActivity
   {
      
      protected var FLotteryCount:int;
      
      protected var FCount:int;
      
      protected var FDailyBox:TBaseBox;
      
      protected var FLotteryItems:TInventories;
      
      protected var FBoxList:Vector.<TBaseBox>;
      
      protected var FInvestment:Vector.<TBaseBox>;
      
      protected var FInvestIndex:int;
      
      protected var FLotteryIndex:int;
      
      public function TDecActive1()
      {
         super();
         this.FBoxList = new Vector.<TBaseBox>();
         this.FInvestment = new Vector.<TBaseBox>();
      }
      
      public function get Count() : int
      {
         return this.FCount;
      }
      
      public function set Count(param1:int) : void
      {
         this.FCount = param1;
      }
      
      public function get DailyBox() : TBaseBox
      {
         return this.FDailyBox;
      }
      
      public function set DailyBox(param1:TBaseBox) : void
      {
         this.FDailyBox = param1;
      }
      
      public function get LotteryItems() : TInventories
      {
         return this.FLotteryItems;
      }
      
      public function set LotteryItems(param1:TInventories) : void
      {
         this.FLotteryItems = param1;
      }
      
      public function get BoxList() : Vector.<TBaseBox>
      {
         return this.FBoxList;
      }
      
      public function set BoxList(param1:Vector.<TBaseBox>) : void
      {
         this.FBoxList = param1;
      }
      
      public function get Investment() : Vector.<TBaseBox>
      {
         return this.FInvestment;
      }
      
      public function set Investment(param1:Vector.<TBaseBox>) : void
      {
         this.FInvestment = param1;
      }
      
      public function get LotteryCount() : int
      {
         return this.FLotteryCount;
      }
      
      public function set LotteryCount(param1:int) : void
      {
         this.FLotteryCount = param1;
      }
      
      public function get LotteryIndex() : int
      {
         return this.FLotteryIndex;
      }
      
      public function set LotteryIndex(param1:int) : void
      {
         this.FLotteryIndex = param1;
      }
      
      public function get InvestIndex() : int
      {
         return this.FInvestIndex;
      }
      
      public function set InvestIndex(param1:int) : void
      {
         this.FInvestIndex = param1;
      }
      
      public function ChangeStatus() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc2_ = int(this.FBoxList.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(this.FBoxList[_loc1_].Status == TBaseActivity.STATUS_CANNOTGET && this.FCount >= this.FBoxList[_loc1_].Price)
            {
               this.FBoxList[_loc1_].Status = TBaseActivity.STATUS_CANGET;
            }
            _loc1_++;
         }
      }
   }
}

