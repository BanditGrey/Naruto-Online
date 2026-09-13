package Logics.Exercise.DecActive
{
   import Logics.Exercise.TBaseActiveDatas;
   import Logics.Exercise.TBaseActivity;
   
   public class TDecActiveDatas extends TBaseActiveDatas
   {
      
      protected static const ACTIVITY_COUNT:int = 4;
      
      protected var DATE_REFERENCE:Vector.<Class>;
      
      public function TDecActiveDatas()
      {
         var _loc1_:int = 0;
         var _loc2_:Class = null;
         this.DATE_REFERENCE = Vector.<Class>([TDecActive1,TDecActive2,TDecActive3,TDecActive4]);
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
         var _loc3_:TDecActive1 = null;
         _loc3_ = FActivities[0] as TDecActive1;
         return TBaseActivity.STATUS_CANNOTGET;
      }
      
      override public function ChangeStatus2() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TDecActive2 = null;
         _loc3_ = FActivities[1] as TDecActive2;
         _loc2_ = int(_loc3_.TreeItems.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(_loc3_.TreeItems[_loc1_].Status == TBaseActivity.STATUS_CANGET)
            {
               return TBaseActivity.STATUS_CANGET;
            }
            _loc1_++;
         }
         if(_loc3_.LuckyBox.Count > 0)
         {
            return TBaseActivity.STATUS_CANGET;
         }
         return TBaseActivity.STATUS_CANNOTGET;
      }
   }
}

