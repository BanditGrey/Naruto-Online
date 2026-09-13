package Logics.Streamization.Inventories
{
   import Foundation.Streamization.TUnstreamizer;
   import Logics.Inventories.TPoolInventory;
   import Logics.Spaces.LogicsSpace;
   import Resources.Constants.CONST_INVENTORY;
   
   use namespace LogicsSpace;
   
   public class TUnstreamizerInventoryUnknown extends TUnstreamizer
   {
      
      protected static var FPoolInventory:TPoolInventory;
      
      public static const CATEGORY_Equipments:Vector.<uint> = CONST_INVENTORY.CATEGORY_Equipments;
      
      public static const CATEGORY_Appliances:Vector.<uint> = CONST_INVENTORY.CATEGORY_Appliances;
      
      public static const CATEGORY_Equipment:uint = CONST_INVENTORY.CATEGORY_Equipment;
      
      public static const CATEGORY_Treasure:uint = CONST_INVENTORY.CATEGORY_Treasure;
      
      public static const CLASS_Accessories:uint = CONST_INVENTORY.CATEGORY_Accessories;
      
      public static const CATEGORY_Medals:uint = CONST_INVENTORY.CATEGORY_Medals;
      
      public static const CLASS_Equipment:uint = 0;
      
      public static const CLASS_Appliance:uint = 1;
      
      public function TUnstreamizerInventoryUnknown()
      {
         super();
      }
      
      LogicsSpace static function PoolsSetup(param1:TPoolInventory) : void
      {
         FPoolInventory = param1;
      }
   }
}

