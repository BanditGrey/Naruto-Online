package Logics.Exercise.DecActive
{
   public class TLotteryLog
   {
      
      protected var FTime:int;
      
      protected var FFirstNumbers:Vector.<int>;
      
      protected var FSecondNumbers:Vector.<int>;
      
      protected var FThirdNumbers:Vector.<int>;
      
      public function TLotteryLog()
      {
         super();
         this.FFirstNumbers = new Vector.<int>();
         this.FSecondNumbers = new Vector.<int>();
         this.FThirdNumbers = new Vector.<int>();
      }
      
      public function get Time() : int
      {
         return this.FTime;
      }
      
      public function set Time(param1:int) : void
      {
         this.FTime = param1;
      }
      
      public function get FirstNumbers() : Vector.<int>
      {
         return this.FFirstNumbers;
      }
      
      public function set FirstNumbers(param1:Vector.<int>) : void
      {
         this.FFirstNumbers = param1;
      }
      
      public function get SecondNumbers() : Vector.<int>
      {
         return this.FSecondNumbers;
      }
      
      public function set SecondNumbers(param1:Vector.<int>) : void
      {
         this.FSecondNumbers = param1;
      }
      
      public function get ThirdNumbers() : Vector.<int>
      {
         return this.FThirdNumbers;
      }
      
      public function set ThirdNumbers(param1:Vector.<int>) : void
      {
         this.FThirdNumbers = param1;
      }
   }
}

