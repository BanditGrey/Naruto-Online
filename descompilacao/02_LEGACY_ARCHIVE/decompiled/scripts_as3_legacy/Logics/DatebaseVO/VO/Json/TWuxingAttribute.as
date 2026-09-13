package Logics.DatebaseVO.VO.Json
{
   import Resources.Constants.CONST_COMMON;
   import Resources.Strings.STRING_COMMON;
   
   public class TWuxingAttribute
   {
      
      public static const BASEATTRIBUTENAMES:Vector.<uint> = CONST_COMMON.BASEATTRIBUTENAMES;
      
      public static const STRINGS_BASEATTRIBUTENAMES:Vector.<String> = STRING_COMMON.STRINGS_BASEATTRIBUTENAMES;
      
      protected var FCategory:uint;
      
      protected var FValue:Number;
      
      protected var FName:String;
      
      public function TWuxingAttribute(param1:Array)
      {
         var _loc2_:int = 0;
         super();
         this.FCategory = param1[0];
         this.FValue = param1[1];
         _loc2_ = BASEATTRIBUTENAMES.indexOf(this.FCategory);
         this.FName = STRINGS_BASEATTRIBUTENAMES[_loc2_];
      }
      
      public function get Category() : uint
      {
         return this.FCategory;
      }
      
      public function get Value() : Number
      {
         return this.FValue;
      }
      
      public function get Name() : String
      {
         return this.FName;
      }
   }
}

