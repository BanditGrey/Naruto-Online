package Logics.NarutoRoad
{
   public class TNarutoRoadData
   {
      
      protected var FNarutoRoadGroups:Vector.<TNarutoRoadGroup>;
      
      protected var FObligatoryCourses:Vector.<TObligatoryCourses>;
      
      protected var FCurrShowTaskId:uint;
      
      public function TNarutoRoadData()
      {
         super();
         this.FNarutoRoadGroups = new Vector.<TNarutoRoadGroup>();
         this.FObligatoryCourses = new Vector.<TObligatoryCourses>();
      }
      
      protected function IdSort(param1:TNarutoRoadGroup, param2:TNarutoRoadGroup) : int
      {
         return param1.Identifier - param2.Identifier;
      }
      
      protected function ObligatoryCoursesSort(param1:TObligatoryCourses, param2:TObligatoryCourses) : int
      {
         if(param1.IsOpen && !param2.IsOpen)
         {
            return -1;
         }
         if(param2.IsOpen && !param1.IsOpen)
         {
            return 1;
         }
         if(param1.NarutoRoadDayCount > 0 && param2.NarutoRoadDayCount <= 0)
         {
            return -1;
         }
         if(param2.NarutoRoadDayCount > 0 && param1.NarutoRoadDayCount <= 0)
         {
            return 1;
         }
         return param1.OpenLevel - param2.OpenLevel;
      }
      
      public function get Count() : uint
      {
         return this.FNarutoRoadGroups.length;
      }
      
      public function get ObligatoryCoursesCount() : uint
      {
         return this.FObligatoryCourses.length;
      }
      
      public function get CurrShowTaskId() : uint
      {
         return this.FCurrShowTaskId;
      }
      
      public function set CurrShowTaskId(param1:uint) : void
      {
         this.FCurrShowTaskId = param1;
      }
      
      public function SortById() : void
      {
         this.FNarutoRoadGroups.sort(this.IdSort);
      }
      
      public function GetGroupByIndex(param1:uint) : TNarutoRoadGroup
      {
         if(param1 < this.FNarutoRoadGroups.length)
         {
            return this.FNarutoRoadGroups[param1];
         }
         return null;
      }
      
      public function GetGroupByID(param1:uint) : TNarutoRoadGroup
      {
         var _loc2_:uint = 0;
         var _loc3_:TNarutoRoadGroup = null;
         _loc2_ = 0;
         while(_loc2_ < this.FNarutoRoadGroups.length)
         {
            _loc3_ = this.FNarutoRoadGroups[_loc2_];
            if(_loc3_.Identifier == param1)
            {
               return _loc3_;
            }
            _loc2_++;
         }
         return null;
      }
      
      public function AddGroup(param1:TNarutoRoadGroup) : void
      {
         this.FNarutoRoadGroups.push(param1);
      }
      
      public function GetMissionById(param1:uint) : TNarutoRoadMission
      {
         var _loc2_:uint = 0;
         var _loc3_:TNarutoRoadGroup = null;
         var _loc4_:TNarutoRoadMission = null;
         _loc2_ = 0;
         while(_loc2_ < this.FNarutoRoadGroups.length)
         {
            _loc3_ = this.FNarutoRoadGroups[_loc2_];
            _loc4_ = _loc3_.GetMissionById(param1);
            if(_loc4_ != null)
            {
               return _loc4_;
            }
            _loc2_++;
         }
         return null;
      }
      
      public function GetPopMission(param1:uint) : TNarutoRoadMission
      {
         var _loc2_:uint = 0;
         var _loc3_:TNarutoRoadGroup = null;
         var _loc4_:TNarutoRoadMission = null;
         var _loc5_:TNarutoRoadMission = null;
         _loc2_ = 0;
         while(_loc2_ < this.FNarutoRoadGroups.length)
         {
            _loc3_ = this.FNarutoRoadGroups[_loc2_];
            _loc4_ = _loc3_.GetPopMission(param1);
            if(_loc5_ == null)
            {
               _loc5_ = _loc4_;
            }
            else if(_loc4_ != null)
            {
               if(_loc5_.ShowTipValue() < _loc4_.ShowTipValue())
               {
                  _loc5_ = _loc4_;
               }
            }
            _loc2_++;
         }
         return _loc5_;
      }
      
      public function CheckEffect(param1:uint) : Boolean
      {
         var _loc2_:uint = 0;
         var _loc3_:TNarutoRoadGroup = null;
         var _loc4_:Boolean = false;
         _loc2_ = 0;
         while(_loc2_ < this.FNarutoRoadGroups.length)
         {
            _loc3_ = this.FNarutoRoadGroups[_loc2_];
            _loc4_ = _loc3_.CheckEffect(param1);
            if(_loc4_)
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      public function GetObligatoryCoursesById(param1:uint) : TObligatoryCourses
      {
         var _loc2_:uint = 0;
         var _loc3_:TObligatoryCourses = null;
         _loc2_ = 0;
         while(_loc2_ < this.FObligatoryCourses.length)
         {
            _loc3_ = this.FObligatoryCourses[_loc2_];
            if(_loc3_.NarutoRoadDayId == param1)
            {
               return _loc3_;
            }
            _loc2_++;
         }
         return null;
      }
      
      public function AddObligatoryCourses(param1:TObligatoryCourses) : void
      {
         this.FObligatoryCourses.push(param1);
      }
      
      public function GetObligatoryCoursesByIndex(param1:uint) : TObligatoryCourses
      {
         var _loc2_:TObligatoryCourses = null;
         if(param1 < this.FObligatoryCourses.length)
         {
            _loc2_ = this.FObligatoryCourses[param1];
         }
         return _loc2_;
      }
      
      public function SortObligatoryCourses() : void
      {
         this.FObligatoryCourses.sort(this.ObligatoryCoursesSort);
      }
      
      public function GetCurrShowTaskById() : TNarutoRoadMission
      {
         return this.GetMissionById(this.FCurrShowTaskId);
      }
      
      public function ObligatoryCoursesFormatToString() : String
      {
         var _loc1_:uint = 0;
         var _loc2_:String = null;
         var _loc3_:uint = 0;
         _loc3_ = 1;
         _loc2_ = "";
         _loc1_ = 0;
         while(_loc1_ < this.FObligatoryCourses.length)
         {
            if(Boolean(this.FObligatoryCourses[_loc1_].NarutoRoadDayTask.According) && this.FObligatoryCourses[_loc1_].NarutoRoadDayCount != 0)
            {
               _loc2_ += _loc3_ + ". " + this.FObligatoryCourses[_loc1_].FormatToString() + "\r\n";
               _loc3_++;
            }
            _loc1_++;
         }
         return _loc2_;
      }
      
      public function GetObligatoryCoursesCount() : uint
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         _loc2_ = 0;
         _loc1_ = 0;
         while(_loc1_ < this.FObligatoryCourses.length)
         {
            if(this.FObligatoryCourses[_loc1_].NarutoRoadDayCount != 0)
            {
               _loc2_++;
            }
            _loc1_++;
         }
         return _loc2_;
      }
   }
}

