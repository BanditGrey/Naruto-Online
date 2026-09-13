package Utilities.Timing
{
   import Resources.Strings.STRING_COMMON;
   
   public class TUtilityTiming
   {
      
      public function TUtilityTiming()
      {
         super();
      }
      
      protected static function FormatDecimal(param1:uint, param2:int = 2) : String
      {
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         _loc3_ = param1.toString().toUpperCase();
         _loc5_ = param2 - _loc3_.length;
         if(_loc5_ > 0)
         {
            _loc4_ = "";
            _loc6_ = 0;
            while(_loc6_ < _loc5_)
            {
               _loc4_ += "0";
               _loc6_++;
            }
            _loc3_ = _loc4_ + _loc3_;
         }
         return _loc3_;
      }
      
      public static function FormatDHMBySeconds(param1:int) : String
      {
         var _loc2_:String = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         if(param1 <= 59)
         {
            return param1.toString() + STRING_COMMON.TYPE_TIME_Second;
         }
         _loc3_ = (param1 + 59) / 60;
         _loc6_ = _loc3_ % 60;
         _loc3_ /= 60;
         _loc5_ = _loc3_ % 24;
         _loc4_ = _loc3_ / 24;
         if(_loc4_ != 0)
         {
            _loc2_ = _loc4_.toString() + STRING_COMMON.TYPE_TIME_Day;
         }
         else
         {
            _loc2_ = "";
         }
         if(_loc4_ != 0 || _loc5_ != 0)
         {
            _loc2_ += _loc5_.toString() + STRING_COMMON.TYPE_TIME_Hour;
         }
         return _loc2_ + (_loc6_.toString() + STRING_COMMON.TYPE_TIME_Minute);
      }
      
      public static function FormatDHMSBySeconds(param1:int) : String
      {
         var _loc2_:String = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         _loc3_ = param1 / 60;
         _loc6_ = _loc3_ % 60;
         _loc3_ /= 60;
         _loc5_ = _loc3_ % 24;
         _loc4_ = _loc3_ / 24;
         if(_loc6_ != 0)
         {
            if(_loc5_ != 0)
            {
               _loc7_ = _loc6_ + _loc5_ * 60;
               if(_loc4_ != 0)
               {
                  _loc7_ += _loc4_ * 24 * 60 * 60;
               }
            }
            else
            {
               _loc7_ = _loc6_;
            }
         }
         else
         {
            _loc7_ = _loc5_ * 60;
         }
         _loc3_ = param1 - _loc7_ * 60;
         if(_loc4_ != 0)
         {
            return _loc4_.toString() + STRING_COMMON.TYPE_TIME_Day;
         }
         _loc2_ = "";
         _loc2_ += FormatDecimal(_loc5_) + ":";
         _loc2_ += FormatDecimal(_loc6_) + ":";
         return _loc2_ + FormatDecimal(_loc3_);
      }
      
      public static function FormatSingleDHMBySeconds(param1:int) : String
      {
         var _loc2_:String = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         if(param1 <= 59)
         {
            return param1.toString() + STRING_COMMON.TYPE_TIME_Second;
         }
         _loc3_ = (param1 + 59) / 60;
         _loc6_ = _loc3_ % 60;
         _loc3_ /= 60;
         _loc5_ = _loc3_ % 24;
         _loc4_ = _loc3_ / 24;
         if(_loc4_ != 0)
         {
            return _loc4_.toString() + STRING_COMMON.TYPE_TIME_Day;
         }
         _loc2_ = "";
         if(_loc4_ != 0 || _loc5_ != 0)
         {
            return _loc5_.toString() + STRING_COMMON.TYPE_TIME_Hour;
         }
         return _loc6_.toString() + STRING_COMMON.TYPE_TIME_Minute;
      }
   }
}

