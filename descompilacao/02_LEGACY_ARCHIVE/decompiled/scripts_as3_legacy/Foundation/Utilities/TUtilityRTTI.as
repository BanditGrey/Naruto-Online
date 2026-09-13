package Foundation.Utilities
{
   import flash.utils.*;
   
   public class TUtilityRTTI
   {
      
      public function TUtilityRTTI()
      {
         super();
         throw new Error("UtilityRTTI Class Is Static Container Only");
      }
      
      public static function GetClassByInstance(param1:Object) : Class
      {
         return param1.constructor;
      }
      
      public static function GetClassAscendantByClass(param1:Class) : Class
      {
         var _loc2_:String = null;
         _loc2_ = getQualifiedSuperclassName(param1);
         if(_loc2_ == null)
         {
            return null;
         }
         return getDefinitionByName(_loc2_) as Class;
      }
      
      public static function GetClassAscendantByInstance(param1:Object) : Class
      {
         var _loc2_:String = null;
         _loc2_ = getQualifiedSuperclassName(param1);
         if(_loc2_ == null)
         {
            return null;
         }
         return getDefinitionByName(_loc2_) as Class;
      }
      
      public static function GetClassNameByClass(param1:Class) : String
      {
         return getQualifiedClassName(param1);
      }
      
      public static function GetClassNameByInstance(param1:Object) : String
      {
         return getQualifiedClassName(param1);
      }
      
      public static function GetClassShortNameByClass(param1:Class) : String
      {
         var _loc2_:String = null;
         var _loc3_:int = 0;
         _loc2_ = getQualifiedClassName(param1);
         _loc3_ = _loc2_.lastIndexOf(":");
         return _loc2_.substr(_loc3_ + 1);
      }
      
      public static function GetClassShortNameByInstance(param1:Object) : String
      {
         var _loc2_:String = null;
         var _loc3_:int = 0;
         _loc2_ = getQualifiedClassName(param1);
         _loc3_ = _loc2_.lastIndexOf(":");
         return _loc2_.substr(_loc3_ + 1);
      }
   }
}

