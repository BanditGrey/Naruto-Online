package Logics.Exercise.BlackMarket
{
   import Foundation.Timing.STimingCore;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   
   public class TBlackMarket extends TBaseActivity
   {
      
      protected var FSpecialItem:int;
      
      protected var FFreshTime:int;
      
      protected var FFreshCost:int;
      
      protected var FScore:int;
      
      protected var FHotItem:Vector.<TBaseBox>;
      
      protected var FSaleItem:Vector.<TBaseBox>;
      
      protected var FGiftList:Vector.<TBaseBox>;
      
      protected var FAllLogs:Vector.<TBaseBox>;
      
      public function TBlackMarket()
      {
         super();
         this.FHotItem = new Vector.<TBaseBox>();
         this.FSaleItem = new Vector.<TBaseBox>();
         this.FGiftList = new Vector.<TBaseBox>();
         this.FAllLogs = new Vector.<TBaseBox>();
      }
      
      public function get SpecialItem() : int
      {
         return this.FSpecialItem;
      }
      
      public function set SpecialItem(param1:int) : void
      {
         this.FSpecialItem = param1;
      }
      
      public function get FreshTime() : int
      {
         return this.FFreshTime;
      }
      
      public function set FreshTime(param1:int) : void
      {
         this.FFreshTime = param1;
      }
      
      public function get HotItem() : Vector.<TBaseBox>
      {
         return this.FHotItem;
      }
      
      public function set HotItem(param1:Vector.<TBaseBox>) : void
      {
         this.FHotItem = param1;
      }
      
      public function get SaleItem() : Vector.<TBaseBox>
      {
         return this.FSaleItem;
      }
      
      public function set SaleItem(param1:Vector.<TBaseBox>) : void
      {
         this.FSaleItem = param1;
      }
      
      public function get FreshCost() : int
      {
         return this.FFreshCost;
      }
      
      public function set FreshCost(param1:int) : void
      {
         this.FFreshCost = param1;
      }
      
      public function get Score() : int
      {
         return this.FScore;
      }
      
      public function set Score(param1:int) : void
      {
         this.FScore = param1;
      }
      
      public function get GiftList() : Vector.<TBaseBox>
      {
         return this.FGiftList;
      }
      
      public function set GiftList(param1:Vector.<TBaseBox>) : void
      {
         this.FGiftList = param1;
      }
      
      public function get AllLogs() : Vector.<TBaseBox>
      {
         return this.FAllLogs;
      }
      
      public function set AllLogs(param1:Vector.<TBaseBox>) : void
      {
         this.FAllLogs = param1;
      }
      
      public function ChangeStatus() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TBaseBox = null;
         _loc2_ = int(this.FGiftList.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FGiftList[_loc1_];
            if(_loc3_.Status == TBaseActivity.STATUS_CANNOTGET && this.FScore >= _loc3_.Price)
            {
               _loc3_.Status = TBaseActivity.STATUS_CANGET;
            }
            _loc1_++;
         }
      }
      
      public function CheckStatus() : Boolean
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TBaseBox = null;
         _loc2_ = int(this.FGiftList.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FGiftList[_loc1_];
            if(_loc3_.Status == TBaseActivity.STATUS_CANGET)
            {
               return true;
            }
            _loc1_++;
         }
         if(this.FFreshTime <= STimingCore.GetServerTick())
         {
            return true;
         }
         return false;
      }
      
      public function IsGetReward() : Boolean
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TBaseBox = null;
         _loc2_ = int(this.FGiftList.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FGiftList[_loc1_];
            if(_loc3_.Status == TBaseActivity.STATUS_CANGET)
            {
               return true;
            }
            _loc1_++;
         }
         return false;
      }
   }
}

