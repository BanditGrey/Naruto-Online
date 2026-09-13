package Logics.Exercise.MayActive2015
{
   import Logics.Exercise.DessertHouse.TDessertHouseTask;
   import Logics.Exercise.TActivityTaskData;
   import Logics.Exercise.TBaseActiveDatas;
   import Logics.Exercise.TBaseActivity;
   import Logics.SLogicsCore;
   
   public class TMayActiveDatas_2015 extends TBaseActiveDatas
   {
      
      protected static const ACT_TASK_STEP:int = TActivityTaskData.STEP_COUNT;
      
      protected static const ACTIVITY_COUNT:int = 2;
      
      protected var DATE_REFERENCE:Vector.<Class>;
      
      public function TMayActiveDatas_2015()
      {
         var _loc1_:int = 0;
         var _loc2_:Class = null;
         this.DATE_REFERENCE = Vector.<Class>([TMayActive1_2015,TMayActive2_2015]);
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
         var _loc3_:TMayActive1_2015 = null;
         var _loc4_:TActivityTaskData = null;
         var _loc5_:TDessertHouseTask = null;
         var _loc6_:int = 0;
         _loc3_ = FActivities[0] as TMayActive1_2015;
         _loc4_ = SLogicsCore.ActivityTaskData;
         if(Boolean(_loc3_.Gift) && _loc3_.Gift.Count > 0)
         {
            return TBaseActivity.STATUS_CANGET;
         }
         _loc1_ = 0;
         while(_loc1_ < _loc4_.TaskList.length)
         {
            _loc5_ = _loc4_.TaskList[_loc1_];
            _loc6_ = _loc5_.Step >= ACT_TASK_STEP ? int(ACT_TASK_STEP - 1) : _loc5_.Step;
            if(_loc5_.Status == TBaseActivity.STATUS_CANGET && _loc5_.Process >= _loc5_.ClientTaskReq[_loc6_])
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
         var _loc3_:TMayActive2_2015 = null;
         _loc3_ = FActivities[1] as TMayActive2_2015;
         return TBaseActivity.STATUS_CANNOTGET;
      }
   }
}

