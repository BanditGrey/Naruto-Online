package Resources.Strings
{
   public class STRING_EQUIPADVANCED
   {
      
      public static const STRINGS_NeedGrade:String = "Nivel de uso:";
      
      public static const STRINGS_Level:String = " ";
      
      public static const STRING_AdvMakeEquip_SureFilledMake:String = "Si desea gastar%0" + STRING_COMMON.ITEMNAME_Gold + "Completar los materiales restantes\nFundar%1?";
      
      public static const STRING_AdvMakeEquip_SureFilledMakeCopy:String = "Nivel actual de Fuerza de Kaguya：%0 Se puede disfrutar %1 de descuento\n Se necesita gastar%2 para completar" + STRING_COMMON.ITEMNAME_Gold + ",puede ahorrar%3" + STRING_COMMON.ITEMNAME_Gold + "\nSi desea gastar%4" + STRING_COMMON.ITEMNAME_Gold + "Fundar%5?";
      
      public static const STRING_AdvMakeEquip_SureFilledMakeCopyAgine:String = "Ha expirado la Fuerza de Kaguya actual\nSe puede ahorrar después de activar%0" + STRING_COMMON.ITEMNAME_Gold + "\nSi desea gastar%1" + STRING_COMMON.ITEMNAME_Gold + "Fundar %2?";
      
      public function STRING_EQUIPADVANCED()
      {
         super();
      }
      
      public static function GetDiscountValue(param1:uint) : String
      {
         return Number(param1 / 10) + "";
      }
   }
}

