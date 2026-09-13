package Logics.Warehouse
{
   import Debugging.*;
   import Foundation.Common.*;
   import Foundation.Common.Integer.*;
   import Foundation.Common.Spaces.*;
   import Foundation.Common.Stubs.*;
   import Logics.Inventories.*;
   import Logics.Quests.*;
   import Logics.Skills.*;
   import Logics.Spaces.*;
   import Resources.Constants.*;
   import adobe.utils.*;
   
   use namespace LogicsSpace;
   
   public class TWarehouse
   {
      
      public static const CAPACITY_Backpack:uint = CONST_CHARACTER.CAPACITY_Backpack;
      
      public static const CAPACITY_BackpackTemporary:uint = CONST_CHARACTER.CAPACITY_BackpackTemporary;
      
      protected static const CAPACITY_INVENTORIES:uint = CONST_CHARACTER.CAPACITY_INVENTORIES;
      
      protected static const INVENTORIESINDEX_Appliances:uint = CONST_CHARACTER.INVENTORIESINDEX_Appliances;
      
      protected static const INVENTORIESINDEX_Equipments:uint = CONST_CHARACTER.INVENTORIESINDEX_Equipments;
      
      protected static const INVENTORIESINDEX_Materials:uint = CONST_CHARACTER.INVENTORIESINDEX_Materials;
      
      protected static const INVENTORIESINDEX_Gems:uint = CONST_CHARACTER.INVENTORIESINDEX_Gems;
      
      protected static const INVENTORIESINDEX_Treasures:uint = CONST_CHARACTER.INVENTORIESINDEX_Treasures;
      
      public static const INVENTORIESINDEX_Accessories:uint = CONST_CHARACTER.INVENTORIESINDEX_Accessories;
      
      public static const INVENTORIESINDEX_Temporary:uint = CONST_CHARACTER.INVENTORIESINDEX_Temporary;
      
      public static const INVENTORIESINDEX_Medals:uint = CONST_CHARACTER.INVENTORIESINDEX_Medals;
      
      protected var FStubReferences:TStubReferences;
      
      protected var FBackpackCapacity:uint;
      
      protected var FCurrentCapacity:uint;
      
      protected var FBackpackExpandCount:uint;
      
      protected var FBackpackTemporaryCapacity:uint;
      
      protected var FInventories:TInventories;
      
      protected var FAppliances:TInventories;
      
      protected var FEquipments:TInventories;
      
      protected var FMaterials:TInventories;
      
      protected var FGems:TInventories;
      
      protected var FTreasures:TInventories;
      
      protected var FTemporaryInventories:TInventories;
      
      protected var FInventorySamples:TInventorySamples;
      
      protected var FAccessories:TInventories;
      
      protected var FMedals:TInventories;
      
      protected var FBackpack:Vector.<TInventories>;
      
      public function TWarehouse()
      {
         super();
         this.FStubReferences = new TStubReferences(this);
         this.FBackpackCapacity = CAPACITY_Backpack;
         this.FBackpackTemporaryCapacity = CAPACITY_BackpackTemporary;
         this.FInventories = new TInventories();
         this.FAppliances = new TInventories();
         this.FEquipments = new TInventories();
         this.FMaterials = new TInventories();
         this.FGems = new TInventories();
         this.FTreasures = new TInventories();
         this.FTemporaryInventories = new TInventories();
         this.FInventorySamples = new TInventorySamples();
         this.FAccessories = new TInventories();
         this.FMedals = new TInventories();
         this.FBackpack = new Vector.<TInventories>(CAPACITY_INVENTORIES);
         this.FBackpack[INVENTORIESINDEX_Appliances] = this.FAppliances;
         this.FBackpack[INVENTORIESINDEX_Equipments] = this.FEquipments;
         this.FBackpack[INVENTORIESINDEX_Materials] = this.FMaterials;
         this.FBackpack[INVENTORIESINDEX_Gems] = this.FGems;
         this.FBackpack[INVENTORIESINDEX_Treasures] = this.FTreasures;
         this.FBackpack[INVENTORIESINDEX_Accessories] = this.FAccessories;
         this.FBackpack[INVENTORIESINDEX_Medals] = this.FMedals;
         this.FBackpack[INVENTORIESINDEX_Temporary] = this.FTemporaryInventories;
      }
      
      public function get StubReferences() : TStubReferences
      {
         return this.FStubReferences;
      }
      
      public function get BackpackCapacity() : uint
      {
         return this.FBackpackCapacity;
      }
      
      public function set BackpackCapacity(param1:uint) : void
      {
         this.FBackpackCapacity = param1;
      }
      
      public function get CurrentCapacity() : uint
      {
         return this.FCurrentCapacity;
      }
      
      public function set CurrentCapacity(param1:uint) : void
      {
         this.FCurrentCapacity = param1;
      }
      
      public function get BackpackExpandCount() : uint
      {
         return this.FBackpackExpandCount;
      }
      
      public function set BackpackExpandCount(param1:uint) : void
      {
         this.FBackpackExpandCount = param1;
      }
      
      public function get BackpackTemporaryCapacity() : uint
      {
         return this.FBackpackTemporaryCapacity;
      }
      
      public function set BackpackTemporaryCapacity(param1:uint) : void
      {
         this.FBackpackTemporaryCapacity = param1;
      }
      
      public function get Inventories() : TInventories
      {
         return this.FInventories;
      }
      
      public function GetBackpackByIndex(param1:int) : TInventories
      {
         return this.FBackpack[param1];
      }
      
      public function get Appliances() : TInventories
      {
         return this.FBackpack[INVENTORIESINDEX_Appliances];
      }
      
      public function get Equipments() : TInventories
      {
         return this.FBackpack[INVENTORIESINDEX_Equipments];
      }
      
      public function get Gems() : TInventories
      {
         return this.FBackpack[INVENTORIESINDEX_Gems];
      }
      
      public function get Treasures() : TInventories
      {
         return this.FBackpack[INVENTORIESINDEX_Treasures];
      }
      
      public function get Materials() : TInventories
      {
         return this.FBackpack[INVENTORIESINDEX_Materials];
      }
      
      public function get Accessories() : TInventories
      {
         return this.FBackpack[INVENTORIESINDEX_Accessories];
      }
      
      public function get TemporaryInventories() : TInventories
      {
         return this.FBackpack[INVENTORIESINDEX_Temporary];
      }
      
      public function get Medals() : TInventories
      {
         return this.FBackpack[INVENTORIESINDEX_Medals];
      }
      
      public function Reset() : void
      {
         this.FBackpackCapacity = CAPACITY_Backpack;
         this.FBackpackExpandCount = 0;
         this.FBackpackTemporaryCapacity = CAPACITY_BackpackTemporary;
         this.FInventories.Clear();
         this.FAppliances.Clear();
         this.FEquipments.Clear();
         this.FGems.Clear();
         this.FTreasures.Clear();
         this.FMaterials.Clear();
         this.FTemporaryInventories.Clear();
         this.FInventorySamples.Clear();
         this.FAccessories.Clear();
         this.FMedals.Clear();
      }
   }
}

