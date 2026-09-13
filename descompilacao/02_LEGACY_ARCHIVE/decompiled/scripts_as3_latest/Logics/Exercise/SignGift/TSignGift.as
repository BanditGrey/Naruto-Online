package Logics.Exercise.SignGift
{
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   
   public class TSignGift extends TBaseActivity
   {
      
      public var DayList:Vector.<TBaseBox>;
      
      public var CurDay:int;
      
      public var CurStatus:int;
      
      public var BuySignDay:int;
      
      public var BoxList:Vector.<TBaseBox>;
      
      public var TotalSign:int;
      
      public var SignCost:int;
      
      public var RechargeGift:TBaseBox;
      
      public function TSignGift()
      {
         super();
         this.RechargeGift = new TBaseBox();
         this.DayList = new Vector.<TBaseBox>();
         this.BoxList = new Vector.<TBaseBox>();
      }
      
      public function ChangeStatus() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < this.BoxList.length)
         {
            if(this.BoxList[_loc1_].Status == TBaseActivity.STATUS_CANNOTGET && this.TotalSign >= this.BoxList[_loc1_].Price)
            {
               this.BoxList[_loc1_].Status = TBaseActivity.STATUS_CANGET;
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

