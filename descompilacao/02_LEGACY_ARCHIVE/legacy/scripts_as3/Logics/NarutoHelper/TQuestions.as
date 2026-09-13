package Logics.NarutoHelper
{
   public class TQuestions
   {
      
      protected var FQuestions:Vector.<TQuestion>;
      
      public function TQuestions()
      {
         super();
         this.FQuestions = new Vector.<TQuestion>();
      }
      
      public function get Count() : int
      {
         return this.FQuestions.length;
      }
      
      public function GetQuestionByIndex(param1:int) : TQuestion
      {
         return this.FQuestions[param1];
      }
      
      public function GetQuestionByLevel(param1:int) : TQuestion
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:TQuestion = null;
         _loc3_ = this.FQuestions.length;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = this.FQuestions[_loc2_];
            if(_loc4_.Level == param1)
            {
               return _loc4_;
            }
            _loc2_++;
         }
         return null;
      }
      
      public function Add(param1:TQuestion) : void
      {
         this.FQuestions.push(param1);
      }
   }
}

