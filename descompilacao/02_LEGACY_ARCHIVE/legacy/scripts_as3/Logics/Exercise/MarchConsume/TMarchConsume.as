package Logics.Exercise.MarchConsume
{
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Lottery.TLotteryNews;
   
   public class TMarchConsume extends TBaseActivity
   {
      
      public var ConsumeGold:int;
      
      public var NeedGold:Vector.<int>;
      
      public var Price:Vector.<int>;
      
      public var DailyItems:Vector.<TBaseBox>;
      
      public var TotalBox:Vector.<TMarchConsumeBox>;
      
      public var ConsumeLog:Vector.<TLotteryNews>;
      
      public function TMarchConsume()
      {
         super();
         this.NeedGold = new Vector.<int>();
         this.Price = new Vector.<int>();
         this.DailyItems = new Vector.<TBaseBox>();
         this.TotalBox = new Vector.<TMarchConsumeBox>();
         this.ConsumeLog = new Vector.<TLotteryNews>();
      }
      
      public function ChangeStatus() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc2_ = int(this.DailyItems.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(this.DailyItems[_loc1_].Status == TBaseActivity.STATUS_CANNOTGET && this.ConsumeGold >= this.DailyItems[_loc1_].Price)
            {
               this.DailyItems[_loc1_].Status = TBaseActivity.STATUS_CANGET;
            }
            _loc1_++;
         }
      }
      
      public function CheckStatus() : Boolean
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:TMarchConsumeBox = null;
         _loc3_ = int(this.DailyItems.length);
         _loc1_ = 0;
         while(_loc1_ < _loc3_)
         {
            if(this.DailyItems[_loc1_].Status == TBaseActivity.STATUS_CANGET)
            {
               return true;
            }
            _loc1_++;
         }
         _loc3_ = int(this.TotalBox.length);
         _loc1_ = 0;
         while(_loc1_ < _loc3_)
         {
            _loc5_ = this.TotalBox[_loc1_];
            _loc4_ = int(_loc5_.Boxes.length);
            _loc2_ = 0;
            while(_loc2_ < _loc4_)
            {
               if(_loc5_.Boxes[_loc2_].Status == TBaseActivity.STATUS_CANGET)
               {
                  return true;
               }
               _loc2_++;
            }
            _loc1_++;
         }
         return false;
      }
   }
}

