package Logics.Exercise.JanActive_2016
{
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   
   public class TJanActive1_2016 extends TBaseActivity
   {
      
      public var DayList:Vector.<TBaseBox>;
      
      public var CurDay:int;
      
      public var CurStatus:int;
      
      public var BuySignDay:int;
      
      public var BoxList:Vector.<TBaseBox>;
      
      public var ItemList:Vector.<TBaseBox>;
      
      public var TotalSign:int;
      
      public var SignCost:int;
      
      public var RechargeBox:TBaseBox;
      
      public var ConsumeBox:TBaseBox;
      
      public function TJanActive1_2016()
      {
         super();
         this.DayList = new Vector.<TBaseBox>();
         this.BoxList = new Vector.<TBaseBox>();
         this.ItemList = new Vector.<TBaseBox>();
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
         if(Boolean(this.RechargeBox) && Boolean(this.RechargeBox.Status == TBaseActivity.STATUS_CANNOTGET) && TotalRechargeGold >= this.RechargeBox.Price)
         {
            this.RechargeBox.Status = TBaseActivity.STATUS_CANGET;
         }
         if(Boolean(this.ConsumeBox) && Boolean(this.ConsumeBox.Status == TBaseActivity.STATUS_CANNOTGET) && TotalConsumeGold >= this.ConsumeBox.Price)
         {
            this.ConsumeBox.Status = TBaseActivity.STATUS_CANGET;
         }
      }
   }
}

