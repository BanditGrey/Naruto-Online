package Logics.Exercise.DailyFirstRecharge
{
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   
   public class TDailyFirstRecharge extends TBaseActivity
   {
      
      public var BoxList:Vector.<TBaseBox>;
      
      public var GiftList:Vector.<TBaseBox>;
      
      public function TDailyFirstRecharge()
      {
         super();
         this.BoxList = new Vector.<TBaseBox>();
         this.GiftList = new Vector.<TBaseBox>();
      }
      
      public function ChangeStatus() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
      }
      
      public function CheckStatus() : Boolean
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < this.BoxList.length)
         {
            if(this.BoxList[_loc1_].Status == TBaseActivity.STATUS_CANGET)
            {
               return true;
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this.GiftList.length)
         {
            if(this.GiftList[_loc1_].Status == TBaseActivity.STATUS_CANGET)
            {
               return true;
            }
            _loc1_++;
         }
         return false;
      }
      
      public function get IsBoxGot() : Boolean
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < this.BoxList.length)
         {
            if(this.BoxList[_loc1_].Status == TBaseActivity.STATUS_GETED)
            {
               return true;
            }
            _loc1_++;
         }
         return false;
      }
   }
}

