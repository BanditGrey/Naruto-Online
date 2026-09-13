package Logics.Exercise.NovActive
{
   import Logics.Exercise.TActivityTaskData;
   import Logics.Exercise.TBaseActiveDatas;
   import Logics.Exercise.TBaseActivity;
   import Logics.SLogicsCore;
   
   public class TNovActiveDatas extends TBaseActiveDatas
   {
      
      protected static const ACTIVITY_COUNT:int = 2;
      
      protected var DATE_REFERENCE:Vector.<Class>;
      
      public function TNovActiveDatas()
      {
         var _loc1_:int = 0;
         var _loc2_:Class = null;
         this.DATE_REFERENCE = Vector.<Class>([TNovActive1,TNovActive2]);
         super(ACTIVITY_COUNT);
         FActivities = new Vector.<TBaseActivity>(ACTIVITY_COUNT);
         _loc1_ = 0;
         while(_loc1_ < ACTIVITY_COUNT)
         {
            _loc2_ = this.DATE_REFERENCE[_loc1_];
            FActivities[_loc1_] = new _loc2_();
            FActivities[_loc1_].Identify = _loc1_ + 1;
            _loc1_++;
         }
      }
      
      override public function ChangeStatus1() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TNovActive1 = null;
         var _loc4_:TActivityTaskData = null;
         _loc4_ = SLogicsCore.ActivityTaskData;
         _loc3_ = FActivities[0] as TNovActive1;
         if(_loc3_.ServerList.Count > 0)
         {
            return TBaseActivity.STATUS_CANGET;
         }
         _loc2_ = int(_loc4_.BoxList.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(_loc4_.BoxList[_loc1_].Status == TBaseActivity.STATUS_CANGET)
            {
               return TBaseActivity.STATUS_CANGET;
            }
            _loc1_++;
         }
         _loc2_ = int(_loc3_.ShopExchangeItems.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(_loc3_.ShopExchangeItems[_loc1_].Status == TBaseActivity.STATUS_CANGET)
            {
               return TBaseActivity.STATUS_CANGET;
            }
            _loc1_++;
         }
         return TBaseActivity.STATUS_CANNOTGET;
      }
      
      override public function ChangeStatus2() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TNovActive2 = null;
         _loc3_ = FActivities[1] as TNovActive2;
         if(_loc3_.Count > 0)
         {
            return TBaseActivity.STATUS_CANGET;
         }
         return TBaseActivity.STATUS_CANNOTGET;
      }
   }
}

