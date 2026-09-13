package Components.Controls.Conversion
{
   public class ColorConversion
   {
      
      public function ColorConversion()
      {
         super();
      }
      
      public static function transformWebColor(param1:String) : uint
      {
         if(param1 == "" || param1 == null)
         {
            return 0;
         }
         return uint(parseInt(param1.slice(1),16));
      }
      
      public static function transUintToWeb(param1:uint) : String
      {
         return "#" + param1.toString(16);
      }
      
      public static function getAlphaFromeARGB(param1:uint) : uint
      {
         var _loc2_:uint = param1;
         var _loc3_:uint = uint(_loc2_ >> 24 & 0xFF);
         var _loc4_:uint = uint(_loc2_ >> 16 & 0xFF);
         var _loc5_:uint = uint(_loc2_ >> 8 & 0xFF);
         var _loc6_:uint = uint(_loc2_ & 0xFF);
         return _loc3_;
      }
   }
}

