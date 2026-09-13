package Logics.Exercise.Dice
{
   import Logics.Inventories.TInventories;
   
   public class TDiceLog
   {
      
      protected var FGetTime:int;
      
      protected var FInventories:TInventories;
      
      public function TDiceLog()
      {
         super();
      }
      
      public function get GetTime() : int
      {
         return this.FGetTime;
      }
      
      public function set GetTime(param1:int) : void
      {
         this.FGetTime = param1;
      }
      
      public function get Inventories() : TInventories
      {
         return this.FInventories;
      }
      
      public function set Inventories(param1:TInventories) : void
      {
         this.FInventories = param1;
      }
   }
}

