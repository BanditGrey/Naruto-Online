package Logics.Exercise
{
   public class TBaseActiveDatas
   {
      
      protected static const ACTIVITY_1_ID:int = 1;
      
      protected static const ACTIVITY_2_ID:int = 2;
      
      protected static const ACTIVITY_3_ID:int = 3;
      
      protected static const ACTIVITY_4_ID:int = 4;
      
      protected var FActivities:Vector.<TBaseActivity>;
      
      protected var FActiviteCount:int;
      
      public function TBaseActiveDatas(param1:int)
      {
         super();
         this.FActiviteCount = param1;
      }
      
      public function get Activities() : Vector.<TBaseActivity>
      {
         return this.FActivities;
      }
      
      public function set Activities(param1:Vector.<TBaseActivity>) : void
      {
         this.FActivities = param1;
      }
      
      public function get ActiviteCount() : int
      {
         return this.FActiviteCount;
      }
      
      public function set ActiviteCount(param1:int) : void
      {
         this.FActiviteCount = param1;
      }
      
      public function GetActivityByIdentify(param1:int) : TBaseActivity
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc3_ = int(this.FActivities.length);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            if(this.FActivities[_loc2_].Identify == param1)
            {
               return this.FActivities[_loc2_];
            }
            _loc2_++;
         }
         return null;
      }
      
      public function GetActivityByIndex(param1:int) : TBaseActivity
      {
         var _loc2_:int = 0;
         if(param1 < this.FActivities.length)
         {
            return this.FActivities[param1];
         }
         return null;
      }
      
      public function GetActivityIndexByIdentify(param1:int) : int
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc3_ = int(this.FActivities.length);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            if(this.FActivities[_loc2_].Identify == param1)
            {
               return _loc2_;
            }
            _loc2_++;
         }
         return -1;
      }
      
      public function RemoveActivityByIdentify(param1:int) : void
      {
         var _loc2_:int = this.GetActivityIndexByIdentify(param1);
         if(_loc2_ == -1)
         {
            return;
         }
         this.FActivities.splice(_loc2_,1);
      }
      
      public function CheckStatus() : Boolean
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < this.FActivities.length)
         {
            if(this.FActivities[_loc1_].NeedShine == TBaseActivity.STATUS_CANGET)
            {
               return true;
            }
            _loc1_++;
         }
         return false;
      }
      
      public function ChangeSingleActivityStatus(param1:int) : Boolean
      {
         var _loc2_:int = 0;
         switch(param1)
         {
            case ACTIVITY_1_ID:
               _loc2_ = this.ChangeStatus1();
               break;
            case ACTIVITY_2_ID:
               _loc2_ = this.ChangeStatus2();
               break;
            case ACTIVITY_3_ID:
               _loc2_ = this.ChangeStatus3();
               break;
            case ACTIVITY_4_ID:
               _loc2_ = this.ChangeStatus4();
         }
         if(_loc2_ == TBaseActivity.STATUS_CANGET)
         {
            this.FActivities[param1 - 1].NeedShine = TBaseActivity.STATUS_CANGET;
            return true;
         }
         this.FActivities[param1 - 1].NeedShine = TBaseActivity.STATUS_CANNOTGET;
         return false;
      }
      
      public function ChangeStatus1() : int
      {
         return 0;
      }
      
      public function ChangeStatus2() : int
      {
         return 0;
      }
      
      public function ChangeStatus3() : int
      {
         return 0;
      }
      
      public function ChangeStatus4() : int
      {
         return 0;
      }
   }
}

