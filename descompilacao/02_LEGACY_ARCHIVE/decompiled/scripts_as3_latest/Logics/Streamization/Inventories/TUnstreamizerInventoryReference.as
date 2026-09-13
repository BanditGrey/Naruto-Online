package Logics.Streamization.Inventories
{
   import Debugging.*;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Streamization.*;
   import Logics.DatebaseVO.VO.TArticle;
   import Logics.Inventories.*;
   import Resources.Constants.*;
   import flash.utils.*;
   
   public class TUnstreamizerInventoryReference extends TUnstreamizerInventoryUnknown
   {
      
      protected var FUnstreamizerEquipment:TUnstreamizerEquipment;
      
      protected var FUnstreamizerAppliance:TUnstreamizerAppliance;
      
      public function TUnstreamizerInventoryReference()
      {
         super();
         this.FUnstreamizerEquipment = new TUnstreamizerEquipment();
         this.FUnstreamizerAppliance = new TUnstreamizerAppliance();
      }
      
      protected function AcquireInventory(param1:uint) : TInventory
      {
         var _loc2_:uint = 0;
         var _loc3_:TInventory = null;
         _loc2_ = this.InventoryClassByCategory(param1);
         switch(_loc2_)
         {
            case CLASS_Equipment:
               _loc3_ = FPoolInventory.AcquireEquipment();
               break;
            case CLASS_Appliance:
               _loc3_ = FPoolInventory.AcquireAppliance();
               break;
            default:
               return null;
         }
         _loc3_.Category = param1;
         return _loc3_;
      }
      
      protected function InventoryClassByCategory(param1:uint) : uint
      {
         var _loc2_:int = 0;
         _loc2_ = CATEGORY_Equipments.indexOf(param1);
         if(_loc2_ >= 0)
         {
            return CLASS_Equipment;
         }
         return CLASS_Appliance;
      }
      
      protected function InventoryUnstreamizerByCategory(param1:uint) : TUnstreamizerInventory
      {
         var _loc2_:uint = 0;
         _loc2_ = this.InventoryClassByCategory(param1);
         switch(_loc2_)
         {
            case CLASS_Equipment:
               return this.FUnstreamizerEquipment;
            case CLASS_Appliance:
               return this.FUnstreamizerAppliance;
            default:
               return null;
         }
      }
      
      protected function InventoryUnstreamizerSpecialProcessing(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:int = 0;
         var _loc5_:uint = 0;
         _loc4_ = param3 as int;
         _loc5_ = this.InventoryClassByCategory(_loc4_);
         if(_loc5_ == CLASS_Appliance)
         {
            param1.readUnsignedShort();
            param1.readUnsignedInt();
            param1.readUnsignedShort();
            param1.readUnsignedInt();
            param1.readUnsignedByte();
            param1.readUnsignedInt();
         }
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform_Inventory(param1,param2,param3);
      }
      
      protected function UnstreamizationPerform_Inventory(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:TInventoryReference = null;
         var _loc5_:uint = 0;
         var _loc6_:TInventory = null;
         var _loc7_:TUnstreamizerInventory = null;
         _loc4_ = param2 as TInventoryReference;
         _loc5_ = param1.readUnsignedByte();
         _loc6_ = this.AcquireInventory(_loc5_);
         _loc7_ = this.InventoryUnstreamizerByCategory(_loc5_);
         _loc7_.Unstreamize(param1,_loc6_,param3);
         this.InventoryUnstreamizerSpecialProcessing(param1,param2,_loc5_);
         _loc4_.Inventory = _loc6_;
      }
      
      protected function UnstreamizationPerform_GenerateInventoriesByIdentifiers(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:Vector.<uint> = null;
         var _loc9_:TUnstreamizerInventory = null;
         var _loc10_:TCollectionInventory = null;
         var _loc11_:TInventories = null;
         var _loc12_:TInventory = null;
         var _loc13_:TBins = null;
         var _loc14_:TArticle = null;
         var _loc15_:uint = 0;
         _loc15_ = 0;
         if(param2 is TCollectionInventory)
         {
            _loc10_ = param2 as TCollectionInventory;
         }
         else if(param2 is TInventories)
         {
            _loc11_ = param2 as TInventories;
         }
         _loc8_ = param3 as Vector.<uint>;
         _loc13_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         _loc5_ = int(_loc8_.length);
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc6_ = _loc8_[_loc4_];
            _loc14_ = _loc13_.GetDatebaseByIdentifier(_loc6_) as TArticle;
            if(_loc14_ == null)
            {
               throw new Error("Article表未配置道具 " + _loc6_);
            }
            _loc7_ = uint(_loc14_.MajorType);
            _loc12_ = this.AcquireInventory(_loc7_);
            _loc9_ = this.InventoryUnstreamizerByCategory(_loc7_);
            _loc12_.IDTemplate = _loc6_;
            _loc12_.IsExchage = _loc14_.IsExchage;
            _loc12_.GoldNumberA = _loc14_.GoldNumberA;
            _loc9_.UnstreamizeGenerateInventory(param1,_loc12_,_loc15_);
            if(param2 is TCollectionInventory)
            {
               _loc10_.SetInventoryByIndex(_loc12_.CategorySecond,_loc12_);
            }
            else if(param2 is TInventories)
            {
               _loc11_.Add(_loc12_);
            }
            _loc4_++;
         }
      }
      
      protected function UnstreamizationPerform_QuestReward(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform_QRInventory(param1,param2,param3);
      }
      
      protected function UnstreamizationPerform_QRInventory(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:TInventoryReference = null;
         var _loc5_:uint = 0;
         var _loc6_:TInventory = null;
         var _loc7_:TUnstreamizerInventory = null;
         _loc4_ = param2 as TInventoryReference;
         _loc4_.Inventory = _loc6_;
      }
      
      public function UnstreamizeGenerateInventoriesByIdentifiers(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform_GenerateInventoriesByIdentifiers(param1,param2,param3);
      }
      
      public function UnstreamizeQuestReward(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform_QuestReward(param1,param2,param3);
      }
   }
}

