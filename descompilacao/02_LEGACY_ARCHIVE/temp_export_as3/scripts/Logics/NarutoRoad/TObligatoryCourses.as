package Logics.NarutoRoad
{
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TNarutoRoadDayTask;
   
   public class TObligatoryCourses
   {
      
      protected var FNarutoRoadDayId:uint;
      
      protected var FNarutoRoadDayCount:uint;
      
      protected var FNarutoRoadDayTask:TNarutoRoadDayTask;
      
      protected var FMainLevel:uint;
      
      public function TObligatoryCourses()
      {
         super();
      }
      
      public function get NarutoRoadDayId() : uint
      {
         return this.FNarutoRoadDayId;
      }
      
      public function get NarutoRoadDayCount() : uint
      {
         return this.FNarutoRoadDayCount;
      }
      
      public function get NarutoRoadDayTask() : TNarutoRoadDayTask
      {
         return this.FNarutoRoadDayTask;
      }
      
      public function get IsOpen() : Boolean
      {
         if(this.FNarutoRoadDayTask == null)
         {
            return false;
         }
         return this.FMainLevel >= this.FNarutoRoadDayTask.Accept;
      }
      
      public function get OpenLevel() : uint
      {
         if(this.FNarutoRoadDayTask == null)
         {
            return 999;
         }
         return this.FNarutoRoadDayTask.Accept;
      }
      
      public function SetNarutoRoadDay(param1:uint, param2:uint, param3:TNarutoRoadDayTask, param4:uint) : void
      {
         this.FNarutoRoadDayId = param1;
         this.FNarutoRoadDayCount = param2;
         this.FNarutoRoadDayTask = param3;
         this.FMainLevel = param4;
      }
      
      public function FormatToString() : String
      {
         var _loc1_:String = null;
         if(this.FNarutoRoadDayTask.Tips == null)
         {
            _loc1_ = "";
         }
         else
         {
            _loc1_ = TUtilityString.Format(this.FNarutoRoadDayTask.Tips,this.FNarutoRoadDayCount);
         }
         return _loc1_;
      }
   }
}

