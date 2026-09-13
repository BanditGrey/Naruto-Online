package Logics.Quests
{
   public class TQuestInfor
   {
      
      protected var FSubject:String;
      
      protected var FInfor:String;
      
      public function TQuestInfor()
      {
         super();
      }
      
      public function get Subject() : String
      {
         return this.FSubject;
      }
      
      public function set Subject(param1:String) : void
      {
         this.FSubject = param1;
      }
      
      public function get Infor() : String
      {
         return this.FInfor;
      }
      
      public function set Infor(param1:String) : void
      {
         this.FInfor = param1;
      }
   }
}

