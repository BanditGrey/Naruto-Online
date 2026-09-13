package Logics.TongLing
{
   public class TAttribute
   {
      
      protected var FType:uint;
      
      protected var FValue:uint;
      
      public function TAttribute()
      {
         super();
      }
      
      public function get Type() : uint
      {
         return this.FType;
      }
      
      public function set Type(param1:uint) : void
      {
         this.FType = param1;
      }
      
      public function get Value() : uint
      {
         return this.FValue;
      }
      
      public function set Value(param1:uint) : void
      {
         this.FValue = param1;
      }
   }
}

