package Processors.Game.Utilities.Inventories
{
   import Logics.*;
   import Logics.Inventories.*;
   import Logics.Spaces.*;
   
   use namespace LogicsSpace;
   
   public class TUtilityInventory
   {
      
      public function TUtilityInventory()
      {
         super();
      }
      
      protected function InventoryPropertiesAssign(param1:TInventory, param2:TInventory) : void
      {
         param2.Category = param1.Category;
         param2.CategorySecond = param1.CategorySecond;
         param2.IDTemplate = param1.IDTemplate;
         param2.Name = param1.Name;
         param2.Description = param1.Description;
         param2.IDTexture = param1.IDTexture;
         param2.Quantity = param1.Quantity;
         param2.Quality = param1.Quality;
         param2.IsCanSell = param1.IsCanSell;
         param2.SellValue = param1.SellValue;
         param2.SellingValue = param1.SellingValue;
         param2.IsCanDiscard = param1.IsCanDiscard;
         param2.IsCanReveal = param1.IsCanReveal;
         param2.SortIndex = param1.SortIndex;
         param2.RequirementLevel = param1.RequirementLevel;
         param2.UpgradingLevel = param1.UpgradingLevel;
         param2.TimingCategory = param1.TimingCategory;
         param2.TimingState = param1.TimingState;
         param2.TempTimingTime = param1.TempTimingTime;
         param2.TimingTime = param1.TimingTime;
         param2.ObtainType = param1.ObtainType;
      }
      
      protected function EquipmentAttributesAssign(param1:TEquipment, param2:TEquipment) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:uint = 0;
         var _loc6_:TEquipmentAppendAttribute = null;
         var _loc7_:TAppliance = null;
         var _loc8_:TAppliance = null;
         var _loc9_:TSuitData = null;
         var _loc10_:TSuitData = null;
         var _loc11_:TSuitEffects = null;
         var _loc12_:TSuitEffects = null;
         var _loc13_:TSuitEffect = null;
         _loc4_ = int(param1.RequirementCareer.length);
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc5_ = param1.RequirementCareer[_loc3_];
            param2.RequirementCareer.push(_loc5_);
            _loc3_++;
         }
         param2.BasisPropertyCategory = param1.BasisPropertyCategory;
         param2.BasisProperty = param1.BasisProperty;
         param2.UpgradingBasisProperty = param1.UpgradingBasisProperty;
         param2.MaxAdditionalCount = param1.MaxAdditionalCount;
         param2.AppendAttributes.Clear();
         _loc4_ = param1.AppendAttributes.Count;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc6_ = param1.AppendAttributes.GetAttributeByIndex(_loc3_);
            param2.AppendAttributes.Add(_loc6_);
            _loc3_++;
         }
         param2.WeaponSkillID = param1.WeaponSkillID;
         param2.WeaponSkillName = param1.WeaponSkillName;
         param2.WeaponSkillDesc = param1.WeaponSkillDesc;
         param2.HoleCount = param1.HoleCount;
         param2.GiftedStoneItems.Clear();
         _loc4_ = param1.GiftedStoneItems.Count;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc7_ = param1.GiftedStoneItems.GetGiftedStoneByIndex(_loc3_);
            _loc8_ = this.ApplianceClone(_loc7_);
            param2.GiftedStoneItems.Add(_loc8_);
            _loc3_++;
         }
         param2.SuitID = param1.SuitID;
         _loc9_ = param1.SuitData;
         _loc10_ = param2.SuitData;
         _loc10_.Name = _loc9_.Name;
         _loc10_.MaxCount = _loc9_.MaxCount;
         _loc11_ = _loc9_.SuitEffects;
         _loc12_ = _loc10_.SuitEffects;
         _loc12_.Clear();
         _loc4_ = _loc11_.Count;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc13_ = _loc11_.GetSuitEffectByIndex(_loc3_);
            _loc12_.Add(_loc13_);
            _loc3_++;
         }
         param2.SuitCount = param1.SuitCount;
         param2.IsAdvancedEquip = param1.IsAdvancedEquip;
         param2.IsCastEquip = param1.IsCastEquip;
         param2.Display = param1.Display;
      }
      
      public function ApplianceClone(param1:TAppliance) : TAppliance
      {
         var _loc2_:TAppliance = null;
         _loc2_ = SLogicsCore.PoolInventory.AcquireAppliance(param1.Identifier0,param1.Identifier1);
         this.InventoryPropertiesAssign(param1,_loc2_);
         _loc2_.Usable = param1.Usable;
         _loc2_.Stackable = param1.Stackable;
         _loc2_.StackableQuantityMax = param1.StackableQuantityMax;
         return _loc2_;
      }
      
      public function ApplianceAssign(param1:TAppliance, param2:TAppliance) : void
      {
         param2.Coerce(param1.Identifier0,param1.Identifier1);
         this.InventoryPropertiesAssign(param1,param2);
         param2.Usable = param1.Usable;
         param2.Stackable = param1.Stackable;
         param2.StackableQuantityMax = param1.StackableQuantityMax;
      }
      
      public function EquipmentClone(param1:TEquipment) : TEquipment
      {
         var _loc2_:TEquipment = null;
         _loc2_ = SLogicsCore.PoolInventory.AcquireEquipment(param1.Identifier0,param1.Identifier1);
         this.InventoryPropertiesAssign(param1,_loc2_);
         this.EquipmentAttributesAssign(param1,_loc2_);
         return _loc2_;
      }
      
      public function EquipmentAssign(param1:TEquipment, param2:TEquipment) : void
      {
         param2.Coerce(param1.Identifier0,param1.Identifier1);
         this.InventoryPropertiesAssign(param1,param2);
         this.EquipmentAttributesAssign(param1,param2);
      }
   }
}

