package Logics.NarutoHelper
{
   public class TNinjaLesson
   {
      
      protected var FName:String;
      
      protected var FLevel:uint;
      
      protected var FDesc:String;
      
      public function TNinjaLesson()
      {
         super();
         this.FName = "";
         this.FLevel = 0;
         this.FDesc = "";
      }
      
      public function get Name() : String
      {
         return this.FName;
      }
      
      public function set Name(param1:String) : void
      {
         this.FName = param1;
      }
      
      public function get Level() : uint
      {
         return this.FLevel;
      }
      
      public function set Level(param1:uint) : void
      {
         this.FLevel = param1;
      }
      
      public function get Desc() : String
      {
         return this.FDesc;
      }
      
      public function set Desc(param1:String) : void
      {
         this.FDesc = param1;
      }
   }
}

