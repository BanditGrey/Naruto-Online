package Resources.Strings
{
   public class STRING_SMITHY
   {
      
      public static const FORMAT_AttributeValue:String = "%0(%1)";
      
      public static const FORMAT_StrengthenClodTime:String = "%0:%1:%2";
      
      public static const ZeroClodTime:String = "00:00:00";
      
      public static const STRENGTHEN_FLYTEXTS:Vector.<String> = Vector.<String>(["Equipment fortified!","Please fortify after the cooldown!","Lucky you! You get 2x Fortify!","Cooldown cleared. Enhance now!","Fail to fortify, please check Gold!","Not enough Silver, cannot fortify!","Equipment\'s fortify level cannot surpass character level. Cannot fortify!","Cooldown is cleared once!","Cooldown is 0. No need to have cooldown!","Fail to clear cooldown!","Cooldown cleared!","Already the level cap, cannot upgrade!"]);
      
      public static const TEXTID_STR101:int = 101;
      
      public static const TEXTID_STR102:int = 102;
      
      public static const TEXTID_STR103:int = 103;
      
      public static const TEXTID_STR104:int = 104;
      
      public static const TEXTID_STR105:int = 105;
      
      public static const TEXTID_STR106:int = 106;
      
      public static const TEXTID_STR107:int = 107;
      
      public static const TEXTID_STR108:int = 108;
      
      public static const TEXTID_STR109:int = 109;
      
      public static const TEXTID_STR110:int = 110;
      
      public static const TEXTID_STR111:int = 111;
      
      public static const TEXTID_STR112:int = 112;
      
      public static const TEXTID_STR113:int = 113;
      
      public static const STRENGTHEN_TEXTIDS:Vector.<int> = Vector.<int>([TEXTID_STR101,TEXTID_STR102,TEXTID_STR103,TEXTID_STR104,TEXTID_STR105,TEXTID_STR106,TEXTID_STR107,TEXTID_STR108,TEXTID_STR109,TEXTID_STR110,TEXTID_STR111,TEXTID_STR112,TEXTID_STR113]);
      
      public static const REFINED_FLYTEXTS:Vector.<String> = Vector.<String>(["Refined successfully","Successful Advanced Refine!","Successful Skill Refine!","Successful Bulk Refine!","Replaced successfully!","Fail to replace!","Not enough Silver, cannot refine!","Fail to refine!"]);
      
      public static const TEXTID_STR201:int = 201;
      
      public static const TEXTID_STR202:int = 202;
      
      public static const TEXTID_STR203:int = 203;
      
      public static const TEXTID_STR204:int = 204;
      
      public static const TEXTID_STR205:int = 205;
      
      public static const TEXTID_STR206:int = 206;
      
      public static const TEXTID_STR207:int = 207;
      
      public static const TEXTID_STR208:int = 208;
      
      public static const REFINED_TEXTIDS:Vector.<int> = Vector.<int>([TEXTID_STR201,TEXTID_STR202,TEXTID_STR203,TEXTID_STR204,TEXTID_STR205,TEXTID_STR206,TEXTID_STR207,TEXTID_STR208]);
      
      public static const INHERIT_FLYTEXTS:Vector.<String> = Vector.<String>(["Equipment inherited!","Inherited equipment cannot embed King\'s Stone, or equipment slots don\'t match.","Inheriting equipment cannot upgrade! Fail to inherit"]);
      
      public static const TEXTID_STR301:int = 301;
      
      public static const TEXTID_STR302:int = 302;
      
      public static const TEXTID_STR303:int = 303;
      
      public static const INHERIT_TEXTIDS:Vector.<int> = Vector.<int>([TEXTID_STR301,TEXTID_STR302,TEXTID_STR303]);
      
      public static const StrengthenActivitysDescribtion:Vector.<String> = Vector.<String>(["2x Fortify, to fortify 2 levels at a time!","Discounted Fortify, charges 80% Silver of the normal fortify!","Cancel cooldown, won\'t add cooldown after the fortification!"]);
      
      public static const RefinedActivitysDescribtion:Vector.<String> = Vector.<String>(["Normal Refine, generates random attribute type and value!","Advanced Refine, generates the same attribute type but random attribute value!","Skill Refine, generates random weapons skills!"]);
      
      public static const BatchRefinedActivitysDescribtion:Vector.<String> = Vector.<String>(["Normal Bulk Refine, generates 10 groups of random attribute types and values!","Advanced Bulk Refine, generates the same attribute type but 10 random groups of attribute values!"]);
      
      public static const BatchRefinedVipLow:String = "Bulk Refine, unlocks at VIP6";
      
      public static const STRING_Inherit_before:String = "Before: Lv.%count%";
      
      public static const STRING_Inherit_end:String = "After: Lv.%count%";
      
      public static const STRENGTHEPRIFIX_NAME:String = "Fortify Level: ";
      
      public static const ENCHANTHEPRIFIX_NAME:String = "Enchant Level: ";
      
      public static const String_CantRefined:String = "Unable to refine white and green equipment!";
      
      public static const String_UpgradeLevel:String = "The equipment is Lv.%level% now and can level up to Lv.%UpgradeLevel%!";
      
      public static const STRING_Cost:String = "Clearing cooldown costs %count% Gold!";
      
      public static const STRING_STRENGTHEN_COST:String = "Spend %0 Gold for enhance";
      
      public static const STRING_REFINED_COST:String = "Spend %0 Gold for directed purification";
      
      public static const STRING_BATCH_REFINED_COST:String = "Spend %0 Gold for batch directed purification";
      
      public static const STRING_MAXHOLE:String = "Equipment Slot has reached maximum";
      
      public static const STRING_NOTENOUGHSTONE:String = "Not Enough Drill Stone";
      
      public static const STRING_PUNCH_SUCCESS:String = "Drill Successful";
      
      public static const STRING_DigHoleLimit:String = "Character Lv.%level% unlock Drill";
      
      public static const STRING_MAXEnchant:String = "Already enchant to the max level";
      
      public static const STRING_EnchantLimit:String = "Enchantment unlocks at Lv.%level%";
      
      public static const STRING_EnchantEquipLimit:String = "Cannot enchant this equipment";
      
      public static const STRING_ENCHANT_SUCCESS:String = "Enchantment successful";
      
      public static const STRING_ENCHANT_LOSS:String = "Enchantment failed, Enchant Level remains the same";
      
      public static const STRING_NOTENOUGHMATERIAL:String = "Not enough %0";
      
      public static const STRING_MakeEquip_SureFilledMake:String = "Do you want to spend %0 " + STRING_COMMON.ITEMNAME_Gold + "to get the remaining material\n and craft %1?";
      
      public static const STRING_MakeEquip_SureFilledMakeCopy:String = "Current Kaguya Power Level: %0 Can enjoy (100-%1)% Discount \nIt costs %2 to refill the remaining materials this time" + STRING_COMMON.ITEMNAME_Gold + " Can save %3" + STRING_COMMON.ITEMNAME_Gold + "\nDo you want to spend %4" + STRING_COMMON.ITEMNAME_Gold + " to forge %5?";
      
      public static const STRING_MakeEquip_SureFilledMakeCopyagine:String = "Current Kaguya Power has expired\nActivate now to save up to %0" + STRING_COMMON.ITEMNAME_Gold + "\nDo you want to spend %1" + STRING_COMMON.ITEMNAME_Gold + " to forge %2?";
      
      public function STRING_SMITHY()
      {
         super();
      }
      
      public static function GetDiscountValue(param1:uint) : String
      {
         return param1 + "";
      }
   }
}

