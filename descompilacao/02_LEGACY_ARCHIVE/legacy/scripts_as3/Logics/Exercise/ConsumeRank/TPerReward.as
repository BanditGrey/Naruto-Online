package Logics.Exercise.ConsumeRank
{
   import Logics.Inventories.TInventories;
   
   public class TPerReward
   {
      
      protected var FIdentify:int;
      
      protected var FScore:int;
      
      protected var FStatus:int;
      
      protected var FMinValue:int;
      
      protected var FMaxValue:int;
      
      protected var FInventories:TInventories;
      
      public function TPerReward()
      {
         super();
      }
      
      public function get Identify() : int
      {
         return this.FIdentify;
      }
      
      public function set Identify(param1:int) : void
      {
         this.FIdentify = param1;
      }
      
      public function get Score() : int
      {
         return this.FScore;
      }
      
      public function set Score(param1:int) : void
      {
         this.FScore = param1;
      }
      
      public function get Status() : int
      {
         return this.FStatus;
      }
      
      public function set Status(param1:int) : void
      {
         this.FStatus = param1;
      }
      
      public function get Inventories() : TInventories
      {
         return this.FInventories;
      }
      
      public function set Inventories(param1:TInventories) : void
      {
         this.FInventories = param1;
      }
      
      public function get MinValue() : int
      {
         return this.FMinValue;
      }
      
      public function set MinValue(param1:int) : void
      {
         this.FMinValue = param1;
      }
      
      public function get MaxValue() : int
      {
         return this.FMaxValue;
      }
      
      public function set MaxValue(param1:int) : void
      {
         this.FMaxValue = param1;
      }
   }
}

