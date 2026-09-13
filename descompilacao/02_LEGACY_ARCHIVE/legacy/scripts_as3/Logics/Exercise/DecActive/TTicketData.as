package Logics.Exercise.DecActive
{
   public class TTicketData
   {
      
      public static const STATUS_NOT_OPEN:int = 0;
      
      public static const STATUS_NOT_WON:int = -1;
      
      protected var FTime:int;
      
      protected var FNum:int;
      
      protected var FCount:int;
      
      protected var FStatus:int;
      
      protected var FGold:int;
      
      public function TTicketData()
      {
         super();
      }
      
      public function get Num() : int
      {
         return this.FNum;
      }
      
      public function set Num(param1:int) : void
      {
         this.FNum = param1;
      }
      
      public function get Count() : int
      {
         return this.FCount;
      }
      
      public function set Count(param1:int) : void
      {
         this.FCount = param1;
      }
      
      public function get Time() : int
      {
         return this.FTime;
      }
      
      public function set Time(param1:int) : void
      {
         this.FTime = param1;
      }
      
      public function get Status() : int
      {
         return this.FStatus;
      }
      
      public function set Status(param1:int) : void
      {
         this.FStatus = param1;
      }
      
      public function get Gold() : int
      {
         return this.FGold;
      }
      
      public function set Gold(param1:int) : void
      {
         this.FGold = param1;
      }
   }
}

