package Logics.Streamization.Characters
{
   import Foundation.Streamization.TUnstreamizer;
   import Logics.Characters.TPoolCharacter;
   import Logics.Spaces.LogicsSpace;
   import Logics.Streamization.Skills.TUnstreamizerSkills;
   import Resources.Constants.CONST_INVENTORY;
   
   use namespace LogicsSpace;
   
   public class TUnstreamizerCharacterUnknown extends TUnstreamizer
   {
      
      protected static var FPoolCharacter:TPoolCharacter;
      
      public static const CATEGORY_Normal:uint = CONST_INVENTORY.CATEGORY_Normal;
      
      public static const CATEGORY_Equipment:uint = CONST_INVENTORY.CATEGORY_Equipment;
      
      public static const CATEGORY_Gem:uint = CONST_INVENTORY.CATEGORY_Gem;
      
      public static const CATEGORY_Treasure:uint = CONST_INVENTORY.CATEGORY_Treasure;
      
      public static const CATEGORY_Material:uint = CONST_INVENTORY.CATEGORY_Material;
      
      public static const CATEGORY_Accessories:uint = CONST_INVENTORY.CATEGORY_Accessories;
      
      public static const CATEGORY_Medals:uint = CONST_INVENTORY.CATEGORY_Medals;
      
      public static const CLASS_Appliance:uint = 0;
      
      public static const CLASS_Equipment:uint = 1;
      
      public static const CLASS_Gem:uint = 2;
      
      public static const CLASS_Treasure:uint = 3;
      
      public static const CLASS_Material:uint = 4;
      
      public static const CLASS_Accessory:uint = 5;
      
      public static const CLASS_Medal:uint = 6;
      
      protected var FUnstreamizerSkills:TUnstreamizerSkills;
      
      public function TUnstreamizerCharacterUnknown()
      {
         super();
      }
      
      LogicsSpace static function PoolsSetup(param1:TPoolCharacter) : void
      {
         FPoolCharacter = param1;
      }
   }
}

