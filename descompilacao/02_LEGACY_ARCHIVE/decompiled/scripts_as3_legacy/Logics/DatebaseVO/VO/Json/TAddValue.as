package Logics.DatebaseVO.VO.Json
{
   public class TAddValue
   {
      
      protected var FAddType:int;
      
      protected var FAddValue:Number;
      
      public function TAddValue(param1:Object)
      {
         super();
         this.FAddType = param1.addType;
         this.FAddValue = param1.addValue;
      }
      
      public function get AddType() : int
      {
         return this.FAddType;
      }
      
      public function set AddType(param1:int) : void
      {
         this.FAddType = param1;
      }
      
      public function get AddValue() : Number
      {
         return this.FAddValue;
      }
      
      public function set AddValue(param1:Number) : void
      {
         this.FAddValue = param1;
      }
   }
}

