package Logics.NarutoHelper
{
   public class TNarutoHelperData
   {
      
      protected var FLevelRecommendNinjas:TLevelRecommendNinjas;
      
      protected var FNinjaLessons:TNinjaLessons;
      
      protected var FQuestions:TQuestions;
      
      protected var FAnswerLevel:uint;
      
      protected var FIsHasQuestion:Boolean;
      
      public function TNarutoHelperData()
      {
         super();
         this.FAnswerLevel = 0;
         this.FLevelRecommendNinjas = new TLevelRecommendNinjas();
         this.FNinjaLessons = new TNinjaLessons();
         this.FQuestions = new TQuestions();
      }
      
      public function get AnswerLevel() : uint
      {
         return this.FAnswerLevel;
      }
      
      public function set AnswerLevel(param1:uint) : void
      {
         this.FAnswerLevel = param1;
      }
      
      public function get LevelRecommendNinjas() : TLevelRecommendNinjas
      {
         return this.FLevelRecommendNinjas;
      }
      
      public function set LevelRecommendNinjas(param1:TLevelRecommendNinjas) : void
      {
         this.FLevelRecommendNinjas = param1;
      }
      
      public function get NinjaLessons() : TNinjaLessons
      {
         return this.FNinjaLessons;
      }
      
      public function set NinjaLessons(param1:TNinjaLessons) : void
      {
         this.FNinjaLessons = param1;
      }
      
      public function get Questions() : TQuestions
      {
         return this.FQuestions;
      }
      
      public function set Questions(param1:TQuestions) : void
      {
         this.FQuestions = param1;
      }
      
      public function get IsHasQuestion() : Boolean
      {
         return this.FIsHasQuestion;
      }
      
      public function set IsHasQuestion(param1:Boolean) : void
      {
         this.FIsHasQuestion = param1;
      }
   }
}

