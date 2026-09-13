package Logics.Exercise.Double11Mall
{
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   
   public class TDouble11Mall extends TBaseActivity
   {
      
      protected var FKeys:int;
      
      public var NumList:Vector.<int>;
      
      public var SaleItems:Vector.<TBaseBox>;
      
      public function TDouble11Mall()
      {
         super();
         this.NumList = new Vector.<int>();
         this.SaleItems = new Vector.<TBaseBox>();
      }
      
      public function get Keys() : int
      {
         return this.FKeys;
      }
      
      public function set Keys(param1:int) : void
      {
         this.FKeys = param1;
      }
   }
}

