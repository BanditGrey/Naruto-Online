package Resources.Strings
{
   import Foundation.Resources.SResourcesCore;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Resources.Constants.CONST_CONFIGVALUE;
   import Resources.Constants.CONST_DATEBASEVO;
   
   public class STRING_WING
   {
      
      public static const WINGS_STRING_001:uint = 70440001;
      
      public static const WINGS_STRING_002:uint = 70440002;
      
      public static const WINGS_STRING_003:uint = 70440003;
      
      public static const WINGS_STRING_004:uint = 70440004;
      
      public static const WINGS_STRING_005:uint = 70440005;
      
      public static const WINGS_STRING_006:uint = 70440006;
      
      public static const WINGS_STRING_007:uint = 70440007;
      
      public static const WINGS_STRING_008:uint = 70440008;
      
      public static const WINGS_STRING_009:uint = 70440009;
      
      public static const WINGS_STRING_010:uint = 70440010;
      
      public static const WINGS_STRING_011:uint = 70440011;
      
      public static const WINGS_STRING_012:uint = 70440012;
      
      public static const WINGS_STRING_013:uint = 70440013;
      
      public static const WINGS_STRING_014:uint = 70440014;
      
      public static const WINGS_STRING_015:uint = 70440015;
      
      public static const WINGS_STRING_016:uint = 70440016;
      
      public static const WINGS_STRING_017:uint = 70440017;
      
      public static const WINGS_STRING_018:uint = 70440018;
      
      public static const WINGS_STRING_019:uint = 70440019;
      
      public static const WINGS_STRING_020:uint = 70440020;
      
      public static const WINGS_STRING_021:uint = 70440021;
      
      public static const WINGS_STRING_022:uint = 70440022;
      
      public static const WINGS_STRING_023:uint = 70440023;
      
      public static const WINGS_STRING_024:uint = 70440024;
      
      public static const WINGS_STRING_025:uint = 70440025;
      
      public static const WINGS_STRING_026:uint = 70440026;
      
      public static const WINGS_STRING_027:uint = 70440027;
      
      public static const WINGS_STRING_028:uint = 70440028;
      
      public static const WINGS_STRING_029:uint = 70440029;
      
      public function STRING_WING()
      {
         super();
      }
      
      public static function get Wings_GeneralItemName() : String
      {
         var _loc1_:TConfigValue = null;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.WINGS_GENERAL_ITEMID) as TConfigValue;
         if(_loc1_)
         {
            return STRING_COMMON.GetItemNameByType(1,_loc1_.Value as int);
         }
         return "";
      }
   }
}

