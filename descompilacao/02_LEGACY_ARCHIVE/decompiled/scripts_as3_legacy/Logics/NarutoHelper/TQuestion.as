package Logics.NarutoHelper
{
   public class TQuestion
   {
      
      protected var FLevel:uint;
      
      protected var FQuestion:String;
      
      protected var FAnswers:Vector.<String>;
      
      protected var FFeedbacks:Vector.<String>;
      
      public function TQuestion()
      {
         super();
         this.FLevel = 0;
         this.FQuestion = "";
         this.FAnswers = new Vector.<String>();
         this.FFeedbacks = new Vector.<String>();
      }
      
      public function get Level() : uint
      {
         return this.FLevel;
      }
      
      public function set Level(param1:uint) : void
      {
         this.FLevel = param1;
      }
      
      public function get Question() : String
      {
         return this.FQuestion;
      }
      
      public function set Question(param1:String) : void
      {
         this.FQuestion = param1;
      }
      
      public function get Answers() : Vector.<String>
      {
         return this.FAnswers;
      }
      
      public function set Answers(param1:Vector.<String>) : void
      {
         this.FAnswers = param1;
      }
      
      public function get Feedbacks() : Vector.<String>
      {
         return this.FFeedbacks;
      }
      
      public function set Feedbacks(param1:Vector.<String>) : void
      {
         this.FFeedbacks = param1;
      }
   }
}

