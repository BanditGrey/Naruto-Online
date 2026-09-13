package Logics.Exercise.JanActive_2016
{
   import Logics.Exercise.TActivityTaskData;
   import Logics.Exercise.TBaseActiveDatas;
   import Logics.Exercise.TBaseActivity;
   
   public class TJanActiveDatas_2016 extends TBaseActiveDatas
   {
      
      protected static const ACT_TASK_STEP:int = TActivityTaskData.STEP_COUNT;
      
      protected static const ACTIVITY_COUNT:int = 3;
      
      protected var DATE_REFERENCE:Vector.<Class>;
      
      public function TJanActiveDatas_2016()
      {
         var _loc1_:int = 0;
         var _loc2_:Class = null;
         this.DATE_REFERENCE = Vector.<Class>([TJanActive1_2016,TJanActive2_2016,TJanActive3_2016]);
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
         var _loc3_:TJanActive1_2016 = null;
         _loc3_ = FActivities[0] as TJanActive1_2016;
         return TBaseActivity.STATUS_CANNOTGET;
      }
      
      override public function ChangeStatus2() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TJanActive2_2016 = null;
         _loc3_ = FActivities[1] as TJanActive2_2016;
         return TBaseActivity.STATUS_CANNOTGET;
      }
      
      override public function ChangeStatus3() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TJanActive3_2016 = null;
         _loc3_ = FActivities[2] as TJanActive3_2016;
         return TBaseActivity.STATUS_CANNOTGET;
      }
   }
}

