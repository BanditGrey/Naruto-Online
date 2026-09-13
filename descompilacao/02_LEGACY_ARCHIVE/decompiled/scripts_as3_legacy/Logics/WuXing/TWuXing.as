package Logics.WuXing
{
   public class TWuXing
   {
      
      protected var FheroId:int;
      
      protected var FElementBit:int;
      
      protected var FElementPoint:int;
      
      protected var FElementId:int;
      
      protected var FExp:int;
      
      public function TWuXing()
      {
         super();
      }
      
      public function get heroId() : int
      {
         return this.FheroId;
      }
      
      public function set heroId(param1:int) : void
      {
         this.FheroId = param1;
      }
      
      public function get ElementBit() : int
      {
         return this.FElementBit;
      }
      
      public function set ElementBit(param1:int) : void
      {
         this.FElementBit = param1;
      }
      
      public function get ElementPoint() : int
      {
         return this.FElementPoint;
      }
      
      public function set ElementPoint(param1:int) : void
      {
         this.FElementPoint = param1;
      }
      
      public function get ElementId() : int
      {
         return this.FElementId;
      }
      
      public function set ElementId(param1:int) : void
      {
         this.FElementId = param1;
      }
      
      public function get Exp() : int
      {
         return this.FExp;
      }
      
      public function set Exp(param1:int) : void
      {
         this.FExp = param1;
      }
   }
}

