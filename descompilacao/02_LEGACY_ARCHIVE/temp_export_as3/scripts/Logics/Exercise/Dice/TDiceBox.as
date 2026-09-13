package Logics.Exercise.Dice
{
   import Logics.Inventories.TInventories;
   
   public class TDiceBox
   {
      
      protected var FIdentify:int;
      
      protected var FNeedWinCount:int;
      
      protected var FColor:int;
      
      protected var FStatus:int;
      
      protected var FInventories:TInventories;
      
      public function TDiceBox()
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
      
      public function get NeedWinCount() : int
      {
         return this.FNeedWinCount;
      }
      
      public function set NeedWinCount(param1:int) : void
      {
         this.FNeedWinCount = param1;
      }
      
      public function get Color() : int
      {
         return this.FColor;
      }
      
      public function set Color(param1:int) : void
      {
         this.FColor = param1;
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
   }
}

