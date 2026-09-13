package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import flash.utils.ByteArray;
   
   use namespace ResourcesSpace;
   
   public class TNinjiaQuestions extends TDatebaseVO
   {
      
      protected var FLevel:int;
      
      protected var FQuestions:String;
      
      protected var FRightAnswer:uint;
      
      protected var FAnswerone:String;
      
      protected var FFeedbackone:String;
      
      protected var FAnswertwo:String;
      
      protected var FFeedbacktwo:String;
      
      protected var FAnswerthree:String;
      
      protected var FFeedbackthree:String;
      
      protected var FAnswers:Vector.<String>;
      
      protected var FFeedbacks:Vector.<String>;
      
      public function TNinjiaQuestions()
      {
         super();
         this.FAnswers = new Vector.<String>();
         this.FFeedbacks = new Vector.<String>();
      }
      
      override ResourcesSpace function ReadDataByXml(param1:XML) : void
      {
         var _loc2_:XML = null;
         var _loc3_:String = null;
         var _loc4_:* = undefined;
         var _loc5_:uint = 0;
         var _loc6_:int = 0;
         _loc5_ = uint(param1.elements().length());
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc2_ = param1.elements()[_loc6_];
            _loc3_ = String(_loc2_.name());
            _loc4_ = _loc2_;
            if(_loc3_ == "id")
            {
               Coerce(uint(_loc4_));
            }
            else
            {
               _loc3_ = "F" + _loc3_;
               if(hasOwnProperty(_loc3_))
               {
                  this[_loc3_] = _loc4_;
               }
               else
               {
                  if(Count_AttributeName.indexOf(_loc3_.slice(1,2)) < 0)
                  {
                     _loc3_ = "F" + _loc3_.slice(1,2).toLocaleUpperCase() + _loc3_.slice(2);
                  }
                  if(hasOwnProperty(_loc3_.slice(1)))
                  {
                     if(this[_loc3_] is Boolean)
                     {
                        this[_loc3_] = Boolean(int(_loc4_));
                     }
                     else
                     {
                        this[_loc3_] = _loc4_;
                     }
                  }
               }
            }
            _loc6_++;
         }
      }
      
      override ResourcesSpace function WriteDataToStream(param1:ByteArray) : void
      {
         param1.writeUnsignedInt(FIdentifier);
         param1.writeUnsignedInt(this.FLevel);
         TUtilityString.FlushUTF(param1,this.FQuestions);
         param1.writeUnsignedInt(this.FRightAnswer);
         TUtilityString.FlushUTF(param1,this.FAnswerone);
         TUtilityString.FlushUTF(param1,this.FFeedbackone);
         TUtilityString.FlushUTF(param1,this.FAnswertwo);
         TUtilityString.FlushUTF(param1,this.FFeedbacktwo);
         TUtilityString.FlushUTF(param1,this.FAnswerthree);
         TUtilityString.FlushUTF(param1,this.FFeedbackthree);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         this.FLevel = param1.readUnsignedInt();
         this.FQuestions = TUtilityString.FetchUTF(param1);
         this.FRightAnswer = param1.readUnsignedInt();
         this.FAnswerone = TUtilityString.FetchUTF(param1);
         this.FFeedbackone = TUtilityString.FetchUTF(param1);
         this.FAnswertwo = TUtilityString.FetchUTF(param1);
         this.FFeedbacktwo = TUtilityString.FetchUTF(param1);
         this.FAnswerthree = TUtilityString.FetchUTF(param1);
         this.FFeedbackthree = TUtilityString.FetchUTF(param1);
         this.FAnswers.push(this.FAnswerone);
         this.FAnswers.push(this.FAnswertwo);
         this.FAnswers.push(this.FAnswerthree);
         this.FFeedbacks.push(this.FFeedbackone);
         this.FFeedbacks.push(this.FFeedbacktwo);
         this.FFeedbacks.push(this.FFeedbackthree);
      }
      
      public function get Level() : int
      {
         return this.FLevel;
      }
      
      public function set Level(param1:int) : void
      {
         this.FLevel = param1;
      }
      
      public function get Questions() : String
      {
         return this.FQuestions;
      }
      
      public function set Questions(param1:String) : void
      {
         this.FQuestions = param1;
      }
      
      public function get RightAnswer() : uint
      {
         return this.FRightAnswer;
      }
      
      public function set RightAnswer(param1:uint) : void
      {
         this.FRightAnswer = param1;
      }
      
      public function get Answers() : Vector.<String>
      {
         return this.FAnswers;
      }
      
      public function get Feedbacks() : Vector.<String>
      {
         return this.FFeedbacks;
      }
      
      public function get Answerone() : String
      {
         return this.FAnswerone;
      }
      
      public function set Answerone(param1:String) : void
      {
         this.FAnswerone = param1;
      }
      
      public function get Feedbackone() : String
      {
         return this.FFeedbackone;
      }
      
      public function set Feedbackone(param1:String) : void
      {
         this.FFeedbackone = param1;
      }
      
      public function get Answertwo() : String
      {
         return this.FAnswertwo;
      }
      
      public function set Answertwo(param1:String) : void
      {
         this.FAnswertwo = param1;
      }
      
      public function get Feedbacktwo() : String
      {
         return this.FFeedbacktwo;
      }
      
      public function set Feedbacktwo(param1:String) : void
      {
         this.FFeedbacktwo = param1;
      }
      
      public function get Answerthree() : String
      {
         return this.FAnswerthree;
      }
      
      public function set Answerthree(param1:String) : void
      {
         this.FAnswerthree = param1;
      }
      
      public function get Feedbackthree() : String
      {
         return this.FFeedbackthree;
      }
      
      public function set Feedbackthree(param1:String) : void
      {
         this.FFeedbackthree = param1;
      }
   }
}

