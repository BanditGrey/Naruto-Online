package Logics.Exercise.CatWomen
{
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   
   public class TCatWomen extends TBaseActivity
   {
      
      public var DailyGift:TBaseBox;
      
      public var BoxList:Vector.<TBaseBox>;
      
      public var RechargeGift:TBaseBox;
      
      public var RechargeGold:int;
      
      public var ServerRechargeGold:int;
      
      public var CurDiscount:int;
      
      public var Hero:TBaseBox;
      
      public var SaleItems:Vector.<TBaseBox>;
      
      public function TCatWomen()
      {
         super();
         this.DailyGift = new TBaseBox();
         this.BoxList = new Vector.<TBaseBox>();
         this.RechargeGift = new TBaseBox();
         this.Hero = new TBaseBox();
         this.SaleItems = new Vector.<TBaseBox>();
      }
      
      public function ChangeStatus() : void
      {
      }
      
      public function CheckStatus() : Boolean
      {
         var _loc1_:int = 0;
         if(this.DailyGift.Status == TBaseActivity.STATUS_CANGET)
         {
            return true;
         }
         if(this.RechargeGift.Status == TBaseActivity.STATUS_CANGET)
         {
            return true;
         }
         _loc1_ = 0;
         while(_loc1_ < this.BoxList.length)
         {
            if(this.BoxList[_loc1_].Status == TBaseActivity.STATUS_CANGET)
            {
               return true;
            }
            _loc1_++;
         }
         return false;
      }
   }
}

