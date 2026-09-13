package Logics.Exercise.Christmas2015
{
   import Logics.Exercise.TActivityTaskData;
   import Logics.Exercise.TBaseActiveDatas;
   import Logics.Exercise.TBaseActivity;
   
   public class TChristmasDatas_2015 extends TBaseActiveDatas
   {
      
      protected static const ACT_TASK_STEP:int = TActivityTaskData.STEP_COUNT;
      
      protected static const ACTIVITY_COUNT:int = 4;
      
      protected var DATE_REFERENCE:Vector.<Class>;
      
      public function TChristmasDatas_2015()
      {
         var _loc1_:int = 0;
         var _loc2_:Class = null;
         this.DATE_REFERENCE = Vector.<Class>([TChristmas1_2015,TChristmas2_2015,TChristmas3_2015,TChristmas4_2015]);
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
         var _loc3_:TChristmas1_2015 = null;
         _loc3_ = FActivities[0] as TChristmas1_2015;
         return TBaseActivity.STATUS_CANNOTGET;
      }
      
      override public function ChangeStatus2() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TChristmas2_2015 = null;
         _loc3_ = FActivities[1] as TChristmas2_2015;
         if(Boolean(_loc3_ && _loc3_.WaterList.length > 0) && Boolean(_loc3_.WaterList[1]) && _loc3_.WaterList[1].Time > 0)
         {
            return TBaseActivity.STATUS_CANGET;
         }
         return TBaseActivity.STATUS_CANNOTGET;
      }
      
      override public function ChangeStatus3() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TChristmas3_2015 = null;
         _loc3_ = FActivities[2] as TChristmas3_2015;
         return TBaseActivity.STATUS_CANNOTGET;
      }
      
      override public function ChangeStatus4() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TChristmas4_2015 = null;
         _loc3_ = FActivities[3] as TChristmas4_2015;
         return TBaseActivity.STATUS_CANNOTGET;
      }
   }
}

