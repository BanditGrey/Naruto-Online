package Resources.Strings
{
   public class STRING_EQUIPADVANCED
   {
      
      public static const STRINGS_NeedGrade:String = "Use Level";
      
      public static const STRINGS_Level:String = "Level";
      
      public static const STRING_AdvMakeEquip_SureFilledMake:String = "Do you want to spend %0 " + STRING_COMMON.ITEMNAME_Gold + "to get the remaining material\n and S Forge %1?";
      
      public static const STRING_AdvMakeEquip_SureFilledMakeCopy:String = "Current Kaguya Power Level: %0 Can enjoy (100-%1)% Discount \nIt costs %2 to refill the remaining materials this time" + STRING_COMMON.ITEMNAME_Gold + ", Can save %3" + STRING_COMMON.ITEMNAME_Gold + "\nDo you want to spend %4" + STRING_COMMON.ITEMNAME_Gold + " to forge %5?";
      
      public static const STRING_AdvMakeEquip_SureFilledMakeCopyAgine:String = "Current Kaguya Power has expired \nActivate now to save up to %0" + STRING_COMMON.ITEMNAME_Gold + "\nDo you want to spend %1" + STRING_COMMON.ITEMNAME_Gold + "to S Forge %2?";
      
      public function STRING_EQUIPADVANCED()
      {
         super();
      }
      
      public static function GetDiscountValue(param1:uint) : String
      {
         return param1 + "";
      }
   }
}

