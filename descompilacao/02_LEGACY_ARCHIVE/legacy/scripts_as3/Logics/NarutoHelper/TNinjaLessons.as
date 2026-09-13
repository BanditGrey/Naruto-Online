package Logics.NarutoHelper
{
   public class TNinjaLessons
   {
      
      protected var FNinjaLessons:Vector.<TNinjaLesson>;
      
      public function TNinjaLessons()
      {
         super();
         this.FNinjaLessons = new Vector.<TNinjaLesson>();
      }
      
      public function get Count() : int
      {
         return this.FNinjaLessons.length;
      }
      
      public function GetNinjaLessonByIndex(param1:int) : TNinjaLesson
      {
         return this.FNinjaLessons[param1];
      }
      
      public function Add(param1:TNinjaLesson) : void
      {
         this.FNinjaLessons.push(param1);
      }
      
      public function Clear() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         _loc2_ = this.FNinjaLessons.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.FNinjaLessons.pop();
            _loc1_++;
         }
         this.FNinjaLessons.length = 0;
      }
   }
}

