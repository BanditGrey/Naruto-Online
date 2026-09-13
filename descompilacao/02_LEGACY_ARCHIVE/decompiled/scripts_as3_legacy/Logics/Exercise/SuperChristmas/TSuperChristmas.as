package Logics.Exercise.SuperChristmas
{
   import Logics.Exercise.DessertHouse.TDessertHouseTask;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   
   public class TSuperChristmas extends TBaseActivity
   {
      
      protected var FGameStatus:int;
      
      protected var FNextTime:int;
      
      protected var FActivityTask:TDessertHouseTask;
      
      protected var FGift:TBaseBox;
      
      public function TSuperChristmas()
      {
         super();
      }
      
      public function get GameStatus() : int
      {
         return this.FGameStatus;
      }
      
      public function set GameStatus(param1:int) : void
      {
         this.FGameStatus = param1;
      }
      
      public function get NextTime() : int
      {
         return this.FNextTime;
      }
      
      public function set NextTime(param1:int) : void
      {
         this.FNextTime = param1;
      }
      
      public function get ActivityTask() : TDessertHouseTask
      {
         return this.FActivityTask;
      }
      
      public function set ActivityTask(param1:TDessertHouseTask) : void
      {
         this.FActivityTask = param1;
      }
      
      public function get Gift() : TBaseBox
      {
         return this.FGift;
      }
      
      public function set Gift(param1:TBaseBox) : void
      {
         this.FGift = param1;
      }
      
      public function ChangeStatus() : void
      {
      }
      
      public function CheckStatus() : Boolean
      {
         return false;
      }
   }
}

