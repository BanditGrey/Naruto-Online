package Logics.Exercise.MoonFestival
{
   import Logics.Exercise.TBaseActiveDatas;
   import Logics.Exercise.TBaseActivity;
   
   public class TMoonFestivalDatas extends TBaseActiveDatas
   {
      
      protected static const ACTIVITY_COUNT:int = 2;
      
      protected var DATE_REFERENCE:Vector.<Class>;
      
      public function TMoonFestivalDatas()
      {
         var _loc1_:int = 0;
         var _loc2_:Class = null;
         this.DATE_REFERENCE = Vector.<Class>([TMoonFestival1,TMoonFestival2]);
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
         var _loc3_:TMoonFestival1 = null;
         return TBaseActivity.STATUS_CANNOTGET;
      }
      
      override public function ChangeStatus2() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TMoonFestival2 = null;
         return TBaseActivity.STATUS_CANNOTGET;
      }
   }
}

