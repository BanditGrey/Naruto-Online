package Foundation.Utilities
{
   public class TUtilityRegExpLibrary
   {
      
      public function TUtilityRegExpLibrary()
      {
         super();
         throw new Error("UtilityRegExpLibrary Class Is Static Container Only");
      }
      
      public static function ValidateNumber(param1:String) : Boolean
      {
         var _loc2_:RegExp = null;
         var _loc3_:Object = null;
         _loc2_ = /^-?[1-9]\d*$/;
         _loc3_ = _loc2_.exec(param1);
         if(_loc3_ == null)
         {
            return false;
         }
         return true;
      }
      
      public static function ValidateEmail(param1:String) : Boolean
      {
         var _loc2_:RegExp = null;
         var _loc3_:Object = null;
         _loc2_ = /\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/;
         _loc3_ = _loc2_.exec(param1);
         if(_loc3_ == null)
         {
            return false;
         }
         return true;
      }
      
      public static function ValidateAccount(param1:String) : Boolean
      {
         var _loc2_:RegExp = null;
         var _loc3_:Object = null;
         _loc2_ = /^[a-zA-Z][a-zA-Z0-9_]{1,6}$/;
         _loc3_ = _loc2_.exec(param1);
         if(_loc3_ == null)
         {
            return false;
         }
         return true;
      }
   }
}

