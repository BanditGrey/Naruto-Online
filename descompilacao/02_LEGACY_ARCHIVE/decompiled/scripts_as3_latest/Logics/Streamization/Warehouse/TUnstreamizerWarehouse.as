package Logics.Streamization.Warehouse
{
   import Logics.Characters.THero;
   import Logics.Inventories.TCollectionInventory;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.Inventories.TInventoryReference;
   import Logics.Streamization.Characters.TUnstreamizerCharacterUnknown;
   import Logics.Streamization.Inventories.TUnstreamizerCollectionInventory;
   import Logics.Streamization.Inventories.TUnstreamizerInventories;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Logics.Streamization.Quest.TUnstreamizerQuests;
   import Logics.Warehouse.TWarehouse;
   import Resources.Constants.CONST_INVENTORY;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerWarehouse extends TUnstreamizerCharacterUnknown
   {
      
      public static const STARTINDEX_BaseAttribute:uint = 11;
      
      public static const ENDINDEX_BaseAttribute:uint = 21;
      
      public static const INDEXEQUIPMENTMOUNTED:Vector.<uint> = CONST_INVENTORY.INDEXEQUIPMENTMOUNTED;
      
      public static const INDEXTREASUREMOUNTED:Vector.<uint> = CONST_INVENTORY.INDEXTREASUREMOUNTED;
      
      public static const INDEXACCESSORIES:Vector.<uint> = CONST_INVENTORY.INDEXACCESSORIES;
      
      public static const INDEXMEDALS:Vector.<uint> = CONST_INVENTORY.INDEXMEDALS;
      
      protected var FUnstreamizerQuests:TUnstreamizerQuests;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FUnstreamizerCollectionInventory:TUnstreamizerCollectionInventory;
      
      protected var FUnstreamizerInventories:TUnstreamizerInventories;
      
      protected var FInventoryReference:TInventoryReference;
      
      public function TUnstreamizerWarehouse()
      {
         super();
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         this.FUnstreamizerCollectionInventory = new TUnstreamizerCollectionInventory();
         this.FUnstreamizerInventories = new TUnstreamizerInventories();
         this.FInventoryReference = new TInventoryReference();
      }
      
      protected function UnstreamizationPerform_EquipmentsMounted(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:THero = null;
         var _loc5_:TCollectionInventory = null;
         var _loc6_:TCollectionInventory = null;
         var _loc7_:TCollectionInventory = null;
         var _loc8_:TCollectionInventory = null;
         var _loc9_:TCollectionInventory = null;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:TInventory = null;
         var _loc13_:int = 0;
         _loc4_ = param2 as THero;
         _loc5_ = _loc4_.EquipmentsMounted;
         _loc6_ = _loc4_.TalismansMounted;
         _loc8_ = _loc4_.AccessoryMounted;
         _loc9_ = _loc4_.MedalsMounted;
         _loc5_.Clear();
         _loc6_.Clear();
         _loc8_.Clear();
         _loc9_.Clear();
         _loc10_ = int(param1.readUnsignedShort());
         _loc11_ = 0;
         while(_loc11_ < _loc10_)
         {
            this.FUnstreamizerInventoryReference.Unstreamize(param1,this.FInventoryReference,param3);
            _loc12_ = this.FInventoryReference.Inventory;
            switch(_loc12_.Category)
            {
               case CATEGORY_Equipment:
                  _loc13_ = INDEXEQUIPMENTMOUNTED.indexOf(_loc12_.CategorySecond);
                  _loc7_ = _loc5_;
                  break;
               case CATEGORY_Treasure:
                  _loc13_ = INDEXTREASUREMOUNTED.indexOf(_loc12_.CategorySecond);
                  _loc7_ = _loc6_;
                  break;
               case CATEGORY_Accessories:
                  _loc13_ = INDEXACCESSORIES.indexOf(_loc12_.CategorySecond);
                  _loc7_ = _loc8_;
                  break;
               case CATEGORY_Medals:
                  _loc13_ = INDEXMEDALS.indexOf(_loc12_.CategorySecond);
                  _loc7_ = _loc9_;
            }
            _loc7_.SetInventoryByIndex(_loc13_,_loc12_);
            _loc11_++;
         }
      }
      
      protected function UnstreamizationPerform_Inventories(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:TWarehouse = null;
         _loc4_ = param2 as TWarehouse;
         this.FUnstreamizerInventories.Unstreamize(param1,_loc4_.Inventories,param3);
      }
      
      protected function UnstreamizationPerform_Classification_Inventories(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:TWarehouse = null;
         var _loc9_:TInventory = null;
         var _loc10_:TInventories = null;
         var _loc11_:TInventories = null;
         var _loc12_:TInventories = null;
         var _loc13_:TInventories = null;
         var _loc14_:TInventories = null;
         var _loc15_:TInventories = null;
         var _loc16_:TInventories = null;
         var _loc17_:TInventories = null;
         _loc8_ = param2 as TWarehouse;
         _loc10_ = _loc8_.Inventories;
         _loc11_ = _loc8_.Equipments;
         _loc12_ = _loc8_.Appliances;
         _loc13_ = _loc8_.Gems;
         _loc14_ = _loc8_.Treasures;
         _loc15_ = _loc8_.Materials;
         _loc16_ = _loc8_.Accessories;
         _loc17_ = _loc8_.Medals;
         _loc4_ = _loc10_.Count;
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc9_ = _loc10_.GetInventoryByIndex(_loc5_);
            _loc6_ = _loc9_.Category;
            _loc7_ = this.InventoryClassByCategory(_loc6_);
            switch(_loc7_)
            {
               case CLASS_Appliance:
                  _loc12_.Add(_loc9_);
                  break;
               case CLASS_Equipment:
                  _loc11_.Add(_loc9_);
                  break;
               case CLASS_Gem:
                  _loc13_.Add(_loc9_);
                  break;
               case CLASS_Treasure:
                  _loc14_.Add(_loc9_);
                  break;
               case CLASS_Material:
                  _loc15_.Add(_loc9_);
                  break;
               case CLASS_Accessory:
                  _loc16_.Add(_loc9_);
                  break;
               case CLASS_Medal:
                  _loc17_.Add(_loc9_);
            }
            _loc5_++;
         }
         _loc11_.SortCopy();
         _loc12_.Sort();
         _loc13_.Sort();
         _loc14_.SortCopy();
         _loc15_.Sort();
         _loc16_.SortCopy();
         _loc17_.SortCopy();
         _loc10_.Clear();
      }
      
      protected function InventoryClassByCategory(param1:uint) : uint
      {
         var _loc2_:uint = 0;
         switch(param1)
         {
            case CATEGORY_Normal:
               _loc2_ = CLASS_Appliance;
               break;
            case CATEGORY_Equipment:
               _loc2_ = CLASS_Equipment;
               break;
            case CATEGORY_Gem:
               _loc2_ = CLASS_Gem;
               break;
            case CATEGORY_Treasure:
               _loc2_ = CLASS_Treasure;
               break;
            case CATEGORY_Material:
               _loc2_ = CLASS_Material;
               break;
            case CATEGORY_Accessories:
               _loc2_ = CLASS_Accessory;
               break;
            case CATEGORY_Medals:
               _loc2_ = CLASS_Medal;
         }
         return _loc2_;
      }
      
      protected function UnstreamizationPerform_TemporaryInventories(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:TWarehouse = null;
         _loc4_ = param2 as TWarehouse;
         this.FUnstreamizerInventories.Unstreamize(param1,_loc4_.TemporaryInventories,param3);
      }
      
      public function UnstreamizeEquipmentsMounted(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform_EquipmentsMounted(param1,param2,param3);
      }
      
      public function UnstreamizeInventories(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform_Inventories(param1,param2,param3);
      }
      
      public function UnstreamizeClassificationInventories(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform_Classification_Inventories(param1,param2,param3);
      }
      
      public function UnstreamizeTemporaryInventories(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform_TemporaryInventories(param1,param2,param3);
      }
   }
}

