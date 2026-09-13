package Logics.Exercise.Dice
{
   public class TDiceRank
   {
      
      protected var FIdentifier0:uint;
      
      protected var FIdentifier1:uint;
      
      protected var FName:String;
      
      protected var FWinCount:int;
      
      public function TDiceRank()
      {
         super();
      }
      
      public function get Name() : String
      {
         return this.FName;
      }
      
      public function set Name(param1:String) : void
      {
         this.FName = param1;
      }
      
      public function get WinCount() : int
      {
         return this.FWinCount;
      }
      
      public function set WinCount(param1:int) : void
      {
         this.FWinCount = param1;
      }
      
      public function get Identifier0() : uint
      {
         return this.FIdentifier0;
      }
      
      public function set Identifier0(param1:uint) : void
      {
         this.FIdentifier0 = param1;
      }
      
      public function get Identifier1() : uint
      {
         return this.FIdentifier1;
      }
      
      public function set Identifier1(param1:uint) : void
      {
         this.FIdentifier1 = param1;
      }
   }
}

