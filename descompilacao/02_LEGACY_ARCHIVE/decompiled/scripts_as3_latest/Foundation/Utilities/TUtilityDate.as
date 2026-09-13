package Foundation.Utilities
{
   public class TUtilityDate
   {
      
      public function TUtilityDate()
      {
         super();
         throw new Error("UtilityDate Class Is Static Container Only");
      }
      
      public static function FormatDateString(param1:Date) : String
      {
         var _loc2_:String = param1.fullYear.toString();
         return param1.month + 1 + "/" + param1.date + "/" + _loc2_ + " " + (param1.hours < 10 ? "0" + param1.hours : param1.hours) + ":" + (param1.minutes < 10 ? "0" + param1.minutes : param1.minutes);
      }
      
      public static function FormatDate(param1:Date) : String
      {
         var _loc2_:String = param1.fullYear.toString();
         return param1.month + 1 + "/" + param1.date + "/" + _loc2_;
      }
      
      public static function FormatTime(param1:Date) : String
      {
         return (param1.hours > 9 ? param1.hours.toString() : "0" + param1.hours) + ":" + (param1.minutes > 9 ? param1.minutes.toString() : "0" + param1.minutes);
      }
      
      public static function FormatDateChineseNew(param1:Date) : String
      {
         var _loc2_:String = param1.fullYear.toString();
         return param1.month + 1 + "/" + param1.date + "/" + _loc2_ + " " + (param1.hours > 9 ? param1.hours.toString() : "0" + param1.hours) + ":" + (param1.minutes > 9 ? param1.minutes.toString() : "0" + param1.minutes);
      }
      
      public static function FormatDateChineseNewCopy(param1:Date) : String
      {
         var _loc2_:String = param1.fullYear.toString();
         return _loc2_ + "/" + (param1.month + 1) + "/" + param1.date + " " + (param1.hours > 9 ? param1.hours.toString() : "0" + param1.hours) + ":" + (param1.minutes > 9 ? param1.minutes.toString() : "0" + param1.minutes);
      }
      
      public static function FormatMMDDChineseNew(param1:Date) : String
      {
         return param1.month + 1 + " / " + param1.date;
      }
      
      public static function GetMonthDaysByDate(param1:Date) : int
      {
         var _loc2_:int = 0;
         switch(param1.month)
         {
            case 0:
               _loc2_ = 31;
               break;
            case 1:
               _loc2_ = param1.fullYear % 4 == 0 ? (param1.fullYear % 100 == 0 && param1.fullYear % 400 != 0 ? 28 : 29) : 28;
               break;
            case 2:
               _loc2_ = 31;
               break;
            case 3:
               _loc2_ = 30;
               break;
            case 4:
               _loc2_ = 31;
               break;
            case 5:
               _loc2_ = 30;
               break;
            case 6:
               _loc2_ = 31;
               break;
            case 7:
               _loc2_ = 31;
               break;
            case 8:
               _loc2_ = 30;
               break;
            case 9:
               _loc2_ = 31;
               break;
            case 10:
               _loc2_ = 30;
               break;
            case 11:
               _loc2_ = 31;
         }
         return _loc2_;
      }
      
      public static function ToDateCustomFormat(param1:Date, param2:String = "YYYY-MM-DD JJ:NN:SS") : String
      {
         return "";
      }
      
      public static function CompareTwoDate(param1:Date, param2:Date) : Boolean
      {
         if(param1 == null || param2 == null)
         {
            throw new Error("Date is Null!");
         }
         var _loc3_:Number = param1.getTime();
         var _loc4_:Number = param2.getTime();
         if(_loc3_ > _loc4_)
         {
            return true;
         }
         return false;
      }
      
      public static function ValidateDates(param1:Date, param2:Date) : Boolean
      {
         if(param1 == null && param2 == null)
         {
            return true;
         }
         if(param1 != null && param2 == null || param2 != null && param1 == null)
         {
            return true;
         }
         if(CompareTwoDate(param1,param2))
         {
            return false;
         }
         return true;
      }
      
      public static function ParseDateString(param1:String) : Date
      {
         if(param1 == null)
         {
            return new Date();
         }
         return new Date();
      }
      
      public static function ValidateTwoYear(param1:Date, param2:Date = null, param3:int = 18) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         if(param2 == null)
         {
            param2 = new Date();
         }
         var _loc4_:int = param2.getFullYear() - param1.getFullYear();
         if(_loc4_ >= param3)
         {
            return true;
         }
         return false;
      }
      
      public static function ToDateMaxFormat(param1:Date) : Date
      {
         if(param1 == null)
         {
            return param1;
         }
         return new Date(param1.getFullYear(),param1.getMonth(),param1.getDate(),23,59,59);
      }
      
      public static function ToDateMinFormat(param1:Date) : Date
      {
         if(param1 == null)
         {
            return param1;
         }
         return new Date(param1.getFullYear(),param1.getMonth(),param1.getDate(),0,0,0);
      }
      
      public static function TransDateToGMTNegativeFour(param1:Date) : Date
      {
         if(param1 == null)
         {
            return null;
         }
         return new Date(param1.setMilliseconds((param1.getTimezoneOffset() - 240) * 60000));
      }
      
      public static function TransDateToNegativeFourHoursLater(param1:Date) : Date
      {
         if(param1 == null)
         {
            return null;
         }
         return new Date(param1.setMilliseconds((240 - param1.getTimezoneOffset()) * 60000));
      }
      
      public static function ValidateBetweenTwoDate(param1:Date, param2:Date, param3:int) : Boolean
      {
         var _loc4_:Number = NaN;
         if(param1 == null || param2 == null)
         {
            return false;
         }
         _loc4_ = param1.getTime() - param2.getTime();
         if(_loc4_ >= param3 * 1000)
         {
            return true;
         }
         return false;
      }
      
      public static function FormatDateLongTime(param1:Date) : String
      {
         var _loc2_:Number = NaN;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:String = null;
         var _loc6_:String = null;
         _loc2_ = param1.fullYear % 100;
         _loc3_ = _loc2_ / 10;
         _loc4_ = _loc2_ % 10;
         _loc5_ = _loc3_.toString() + _loc4_.toString();
         return _loc5_ + "-" + (param1.month + 1) + "-" + param1.date + " " + (param1.hours < 10 ? "0" + param1.hours : param1.hours) + ":" + (param1.minutes < 10 ? "0" + param1.minutes : param1.minutes) + ":" + (param1.seconds < 10 ? "0" + param1.seconds : param1.seconds);
      }
      
      public static function BetweenDays(param1:Date, param2:Date) : Number
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         _loc3_ = param1.getTime();
         _loc4_ = param2.getTime();
         if(_loc4_ - _loc3_ > 0)
         {
            return (_loc4_ - _loc3_) / (1000 * 60 * 60 * 24);
         }
         return 0;
      }
   }
}

