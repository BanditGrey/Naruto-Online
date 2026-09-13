package Logics.SystemActivity
{
   public class TSystemActivities
   {
      
      protected var FSystemActivity:Vector.<TSystemActivity>;
      
      protected var FEndTime:int;
      
      public function TSystemActivities()
      {
         super();
         this.FSystemActivity = new Vector.<TSystemActivity>();
      }
      
      public function get SystemActivity() : Vector.<TSystemActivity>
      {
         return this.FSystemActivity;
      }
      
      public function set SystemActivity(param1:Vector.<TSystemActivity>) : void
      {
         this.FSystemActivity = param1;
      }
      
      public function get EndTime() : int
      {
         return this.FEndTime;
      }
      
      public function set EndTime(param1:int) : void
      {
         this.FEndTime = param1;
      }
      
      public function GetSystemActivityByIdentify(param1:int) : TSystemActivity
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc3_ = int(this.FSystemActivity.length);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            if(this.FSystemActivity[_loc2_].Identify == param1)
            {
               return this.FSystemActivity[_loc2_];
            }
            _loc2_++;
         }
         return null;
      }
      
      public function GetSystemActivityByIndex(param1:int) : TSystemActivity
      {
         var _loc2_:int = 0;
         if(param1 < this.FSystemActivity.length)
         {
            return this.FSystemActivity[param1];
         }
         return null;
      }
   }
}

