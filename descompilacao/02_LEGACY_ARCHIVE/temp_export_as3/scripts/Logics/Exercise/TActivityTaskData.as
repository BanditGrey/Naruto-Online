package Logics.Exercise
{
   import Logics.Exercise.DessertHouse.TDessertHouseTask;
   
   public class TActivityTaskData extends TBaseActivity
   {
      
      public static const STEP_COUNT:int = 1;
      
      protected var FTaskList:Vector.<TDessertHouseTask>;
      
      protected var FScore:int;
      
      protected var FMaxScore:int;
      
      protected var FBoxList:Vector.<TBaseBox>;
      
      public function TActivityTaskData()
      {
         super();
         this.FTaskList = new Vector.<TDessertHouseTask>();
         this.FBoxList = new Vector.<TBaseBox>();
      }
      
      public function get TaskList() : Vector.<TDessertHouseTask>
      {
         return this.FTaskList;
      }
      
      public function set TaskList(param1:Vector.<TDessertHouseTask>) : void
      {
         this.FTaskList = param1;
      }
      
      public function get Score() : int
      {
         return this.FScore;
      }
      
      public function set Score(param1:int) : void
      {
         this.FScore = param1;
      }
      
      public function get BoxList() : Vector.<TBaseBox>
      {
         return this.FBoxList;
      }
      
      public function set BoxList(param1:Vector.<TBaseBox>) : void
      {
         this.FBoxList = param1;
      }
      
      public function get MaxScore() : int
      {
         return this.FMaxScore;
      }
      
      public function set MaxScore(param1:int) : void
      {
         this.FMaxScore = param1;
      }
      
      public function ChangeStatus() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TBaseBox = null;
         var _loc4_:TDessertHouseTask = null;
         _loc2_ = int(this.FBoxList.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FBoxList[_loc1_];
            if(this.FScore >= _loc3_.Price && _loc3_.Status == TBaseActivity.STATUS_CANNOTGET)
            {
               _loc3_.Status = TBaseActivity.STATUS_CANGET;
            }
            _loc1_++;
         }
      }
      
      public function CheckStatus() : Boolean
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc2_ = int(this.FTaskList.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = Math.min(this.FTaskList[_loc1_].Step,STEP_COUNT - 1);
            if(this.FTaskList[_loc1_].Status == TBaseActivity.STATUS_CANGET && this.FTaskList[_loc1_].Process >= this.FTaskList[_loc1_].ClientTaskReq[_loc3_])
            {
               return true;
            }
            _loc1_++;
         }
         return false;
      }
      
      public function GetTaskByIdentify(param1:int) : TDessertHouseTask
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc3_ = int(this.FTaskList.length);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            if(this.FTaskList[_loc2_].Identify == param1)
            {
               return this.FTaskList[_loc2_];
            }
            _loc2_++;
         }
         return null;
      }
   }
}

