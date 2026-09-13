package Foundation.Utilities
{
   public class TUtilityMath
   {
      
      public function TUtilityMath()
      {
         super();
         throw new Error("UtilityMath Class Is Static Container Only");
      }
      
      public static function ForceRange(param1:int, param2:int, param3:int) : int
      {
         if(param1 < param2)
         {
            return param2;
         }
         if(param1 > param3)
         {
            return param3;
         }
         return param1;
      }
      
      public static function RandomRange(param1:Number, param2:Number, param3:Boolean = true) : Number
      {
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         _loc4_ = param2 - param1;
         _loc5_ = param1 + Math.random() * _loc4_;
         if(param3)
         {
            _loc5_ = Math.round(_loc5_);
         }
         return _loc5_;
      }
      
      public static function WriteParamByByteArray(param1:uint, param2:uint = 0) : uint
      {
         var _loc3_:uint = 0;
         return uint(param1 << 8 | param2);
      }
      
      public static function ReadParamByByteArray(param1:uint) : Vector.<uint>
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         _loc2_ = uint(param1 >> 8);
         _loc3_ = uint(param1 & 0xFF);
         return Vector.<uint>([_loc2_,_loc3_]);
      }
   }
}

