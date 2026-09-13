package Resources.Strings
{
   import Foundation.Resources.SResourcesCore;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Resources.Constants.CONST_DATEBASEVO;
   
   public class STRING_SOULFORMATION
   {
      
      public static const STRING_001:uint = 70101013;
      
      public static const STRING_002:uint = 70101014;
      
      public static const STRING_003:uint = 70101015;
      
      public static const STRING_004:uint = 70101016;
      
      public static const STRING_005:uint = 70101017;
      
      public static const STRING_006:uint = 70101018;
      
      public static const STRING_007:uint = 70101019;
      
      public static const STRING_008:uint = 70101020;
      
      public static const STRING_009:uint = 70101021;
      
      public static const STRING_010:uint = 70101022;
      
      public static const STRING_0010:uint = 70101026;
      
      public static const STRING_0011:uint = 70101027;
      
      public static const STRING_0012:uint = 70101028;
      
      public static const STRING_0013:uint = 70101029;
      
      public static const STRING_0014:uint = 70101030;
      
      public static const STRING_0015:uint = 70101032;
      
      public static const STRING_0016:uint = 70101033;
      
      public static const STRING_0017:uint = 70101034;
      
      public function STRING_SOULFORMATION()
      {
         super();
      }
      
      public static function get Wings_GeneralItemName() : String
      {
         var _loc1_:TConfigValue = null;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,1) as TConfigValue;
         if(_loc1_)
         {
            return STRING_COMMON.GetItemNameByType(1,_loc1_.Value as int);
         }
         return "";
      }
   }
}

