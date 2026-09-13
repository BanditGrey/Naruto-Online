package Logics.Streamization.Inventories
{
   import Foundation.Resources.Bins.*;
   import Foundation.Resources.SResourcesCore;
   import Logics.DatebaseVO.VO.*;
   import Logics.Inventories.*;
   import Logics.Spaces.*;
   import Resources.Constants.*;
   import flash.utils.*;
   
   use namespace LogicsSpace;
   
   public class TUnstreamizerEquipment extends TUnstreamizerInventory
   {
      
      protected var FUnstreamizerAppendAttributes:TUnstreamizerEquipmentAppendAttributes;
      
      protected var FUnstreamizerMedalAppendAttributes:TUnstreamizerMedalAppendAttributes;
      
      protected var FUnstreamizerAppliance:TUnstreamizerAppliance;
      
      protected var FEnchantValueBins:TBins;
      
      protected var FSmithyEnchantCoefficient:Number;
      
      protected var FRuneEnchantValueBins:TBins;
      
      public function TUnstreamizerEquipment()
      {
         super();
         this.FUnstreamizerAppendAttributes = new TUnstreamizerEquipmentAppendAttributes();
         this.FUnstreamizerMedalAppendAttributes = new TUnstreamizerMedalAppendAttributes();
         this.FUnstreamizerAppliance = new TUnstreamizerAppliance();
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         super.UnstreamizationPerform(param1,param2,param3);
         this.UnstreamizationPerform_EquipmentProperties(param1,param2,param3);
         this.UnstreamizationPerform_EquipmentByDatabase(param2,param3);
      }
      
      protected function UnstreamizationPerform_EquipmentProperties(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:TEquipment = null;
         var _loc9_:TEquipmentAppendAttributes = null;
         var _loc10_:TGiftedStoneItems = null;
         var _loc11_:TAppliance = null;
         var _loc12_:int = 0;
         _loc8_ = param2 as TEquipment;
         _loc9_ = _loc8_.AppendAttributes;
         if(_loc8_.Category == CATEGORY_Medals)
         {
            this.FUnstreamizerMedalAppendAttributes.Unstreamize(param1,_loc9_,param3);
         }
         else
         {
            this.FUnstreamizerAppendAttributes.Unstreamize(param1,_loc9_,param3);
         }
         _loc8_.WeaponSkillID = param1.readUnsignedInt();
         _loc10_ = _loc8_.GiftedStoneItems;
         _loc10_.Clear();
         _loc5_ = int(param1.readUnsignedShort());
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc11_ = FPoolInventory.AcquireAppliance();
            _loc11_.Category = param1.readUnsignedByte();
            _loc11_.IDTemplate = param1.readUnsignedInt();
            this.FUnstreamizerAppliance.UnstreamizeAdditionalDataAppliance(param1,_loc11_,param3);
            _loc10_.Add(_loc11_);
            _loc4_++;
         }
         _loc8_.SuitID = param1.readInt();
         _loc8_.ExpandHoleCount = param1.readUnsignedByte();
         _loc8_.EnchantLevel = param1.readInt();
      }
      
      protected function GetEnchantValue(param1:TEquipment) : TEnchantValue
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:TEnchantValue = null;
         var _loc5_:TConfigValue = null;
         if(this.FEnchantValueBins == null)
         {
            this.FEnchantValueBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_EnchantValue);
            _loc5_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.Smithy_Enchant_Coefficient) as TConfigValue;
            this.FSmithyEnchantCoefficient = _loc5_.Value as Number;
         }
         _loc3_ = uint(this.FEnchantValueBins.Count);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = this.FEnchantValueBins.GetDatebaseByIndex(_loc2_) as TEnchantValue;
            if(_loc4_.Type == param1.CategorySecond && param1.RequirementLevel >= _loc4_.MinEquipLevel && param1.RequirementLevel <= _loc4_.MaxEquipLevel && param1.EnchantLevel == _loc4_.Level)
            {
               return _loc4_;
            }
            _loc2_++;
         }
         return null;
      }
      
      protected function GetRuneEnchantValue(param1:TEquipment) : TRuneEnchantValue
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:TRuneEnchantValue = null;
         if(this.FRuneEnchantValueBins == null)
         {
            this.FRuneEnchantValueBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_RuneEnchantValue);
         }
         _loc3_ = uint(this.FRuneEnchantValueBins.Count);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = this.FRuneEnchantValueBins.GetDatebaseByIndex(_loc2_) as TRuneEnchantValue;
            if(_loc4_.Level == param1.UpgradingLevel)
            {
               return _loc4_;
            }
            _loc2_++;
         }
         return null;
      }
      
      protected function UnstreamizationPerform_EquipmentByDatabase(param1:Object, param2:Object) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:TBins = null;
         var _loc6_:TSkillConfig = null;
         var _loc7_:TSuit = null;
         var _loc8_:TBaseEquip = null;
         var _loc9_:uint = 0;
         var _loc10_:TBuildValue = null;
         var _loc11_:uint = 0;
         var _loc12_:TTreasureUpgrade = null;
         var _loc13_:TBins = null;
         var _loc14_:TBuildConsume = null;
         var _loc15_:int = 0;
         var _loc18_:int = 0;
         var _loc19_:int = 0;
         var _loc20_:TEquipment = null;
         var _loc21_:TSuitData = null;
         var _loc22_:TSuitEffect = null;
         var _loc23_:TEquipUpgrade = null;
         var _loc24_:TEquipUpgrade = null;
         var _loc25_:TRune = null;
         var _loc26_:TRuneEnchantValue = null;
         var _loc27_:TEnchantValue = null;
         var _loc28_:String = null;
         var _loc29_:TLostsacredUpgrade = null;
         var _loc16_:Number = 0;
         var _loc17_:Number = 0;
         _loc20_ = param1 as TEquipment;
         _loc8_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BaseEquip,_loc20_.IDTemplate) as TBaseEquip;
         if(_loc20_.Category == CATEGORY_Equipment)
         {
            _loc23_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_EquipUpgrade,_loc20_.IDTemplate) as TEquipUpgrade;
         }
         else if(_loc20_.Category == CLASS_Accessories)
         {
            _loc24_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_EquipUpgrade,_loc20_.IDTemplate) as TEquipUpgrade;
         }
         else if(_loc20_.Category == CATEGORY_Medals)
         {
            _loc25_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Rune,_loc20_.IDTemplate) as TRune;
         }
         switch(_loc20_.Category)
         {
            case CATEGORY_Equipment:
               if(_loc20_.UpgradingLevel > 0)
               {
                  _loc9_ = CONST_SMITHY.GetBuildValueID(_loc20_.UpgradingLevel,_loc20_.Quality,_loc20_.CategorySecond);
                  _loc10_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BuildValue,_loc9_) as TBuildValue;
                  _loc20_.UpgradingBasisProperty = _loc10_.Value;
                  _loc13_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_BuildConsume);
                  _loc4_ = int(_loc20_.UpgradingLevel);
                  _loc3_ = 0;
                  while(_loc3_ < _loc4_)
                  {
                     _loc15_ = int(CONST_SMITHY.GetBuildConsumeID(_loc20_.Quality,_loc3_));
                     _loc14_ = _loc13_.GetDatebaseByIdentifier(_loc15_) as TBuildConsume;
                     _loc17_ += Number(_loc14_.Consume);
                     _loc3_++;
                  }
                  _loc20_.SellingValue = _loc17_ * 0.8;
               }
               else
               {
                  _loc20_.SellingValue = 0;
               }
               break;
            case CLASS_Accessories:
               _loc20_.SellingValue = 0;
               break;
            case CATEGORY_Treasure:
               if(_loc20_.UpgradingLevel > 0)
               {
                  _loc11_ = CONST_TALISMAN.GetUpgradingValue(_loc20_.IDTemplate,_loc20_.UpgradingLevel);
                  _loc12_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_TreasureUpgrade,_loc11_) as TTreasureUpgrade;
                  if(!_loc12_)
                  {
                     _loc28_ = _loc20_.IDTemplate.toString() + _loc20_.UpgradingLevel.toString();
                     _loc29_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_LostsacredUpgrade,uint(_loc28_)) as TLostsacredUpgrade;
                     _loc20_.UpgradingBasisProperty = _loc29_.AddValue;
                  }
                  else
                  {
                     _loc20_.UpgradingBasisProperty = _loc12_.AddValue;
                  }
               }
               _loc16_ = _loc20_.SellValue;
               _loc18_ = int(_loc20_.UpgradingLevel);
               _loc19_ = int(_loc20_.Quality);
               _loc20_.SellingValue = _loc16_ * _loc18_ * _loc19_ * 0.1;
               break;
            case CATEGORY_Medals:
               _loc20_.BasisPropertyCategory = _loc25_.MainType;
               _loc20_.BasisProperty = _loc25_.MainValue;
               _loc20_.MainAdditionalCategory = _loc25_.MainAdditionalType;
               _loc20_.MainAdditionalValue = parseFloat(_loc25_.MainAdditionalValue.toFixed(2));
               _loc26_ = this.GetRuneEnchantValue(_loc20_);
               if(_loc26_)
               {
                  _loc20_.HoleCount = _loc26_.HoleNum;
               }
               else
               {
                  _loc20_.HoleCount = 0;
               }
               return;
         }
         _loc4_ = int(_loc8_.DressProfessions.length);
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc20_.RequirementCareer[_loc3_] = _loc8_.DressProfessions[_loc3_];
            _loc3_++;
         }
         _loc20_.BasisPropertyCategory = _loc8_.MainType;
         _loc20_.BasisProperty = _loc8_.MainValue;
         _loc20_.MaxAdditionalCount = _loc8_.MaxAdditionalCount;
         if(_loc20_.WeaponSkillID > 0)
         {
            _loc6_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SkillConfig,_loc20_.WeaponSkillID) as TSkillConfig;
            _loc20_.WeaponSkillName = _loc6_.Name;
            _loc20_.WeaponSkillDesc = _loc6_.Desc;
         }
         _loc20_.HoleCount = _loc8_.HoleCount;
         _loc20_.DigHoleNum = _loc8_.DigHoleNum;
         _loc20_.EnchantCoefficient = _loc8_.EnchantCoefficient;
         _loc27_ = this.GetEnchantValue(_loc20_);
         if(_loc27_ != null)
         {
            _loc20_.EnchantValue = int(_loc27_.LevelCoefficient * _loc20_.EnchantCoefficient * _loc27_.TypeCoefficient * (_loc20_.UpgradingLevel + this.FSmithyEnchantCoefficient));
         }
         else
         {
            _loc20_.EnchantValue = 0;
         }
         _loc20_.ExpandHoleCount = Math.max(0,_loc20_.ExpandHoleCount - _loc20_.HoleCount);
         _loc21_ = _loc20_.SuitData;
         if(_loc20_.SuitID > 0)
         {
            _loc7_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Suit,_loc20_.SuitID) as TSuit;
            _loc21_.Name = _loc7_.Name;
            _loc21_.MaxCount = _loc7_.MaxCount;
            _loc4_ = int(_loc7_.SuitEffects.length);
            _loc3_ = 0;
            while(_loc3_ < _loc4_)
            {
               _loc22_ = FPoolInventory.AcquireSuitEffect();
               _loc22_.SuitQuantity = _loc7_.SuitEffects[_loc3_].SuitQuantity;
               _loc22_.Category = _loc7_.SuitEffects[_loc3_].Category;
               _loc22_.Value = _loc7_.SuitEffects[_loc3_].Value;
               _loc22_.Percentage = _loc7_.SuitEffects[_loc3_].Percentage;
               _loc22_.EffectDesc = _loc7_.SuitEffects[_loc3_].EffectDesc;
               _loc21_.SuitEffects.Add(_loc22_);
               _loc3_++;
            }
         }
         if(_loc23_ != null)
         {
            _loc20_.IsAdvancedEquip = true;
         }
         else
         {
            _loc20_.IsAdvancedEquip = false;
         }
         if(_loc24_ != null)
         {
            _loc20_.IsCastEquip = true;
         }
         else
         {
            _loc20_.IsCastEquip = false;
         }
         _loc20_.Display = _loc8_.Display;
      }
      
      override protected function UnstreamizationPerform_QuestReward(param1:ByteArray, param2:Object, param3:Object) : void
      {
         super.UnstreamizationPerform_QuestReward(param1,param2,param3);
         this.UnstreamizationPerform_QREquipmentProperties(param1,param2,param3);
      }
      
      protected function UnstreamizationPerform_QREquipmentProperties(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:TEquipment = param2 as TEquipment;
      }
      
      protected function UnstreamizationPerform_GenerateEquipmentProperties(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:TEquipment = null;
         var _loc7_:TBaseEquip = null;
         _loc6_ = param2 as TEquipment;
         _loc7_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BaseEquip,_loc6_.IDTemplate) as TBaseEquip;
         if(_loc7_)
         {
            _loc6_.SuitID = _loc7_.SuitId;
         }
      }
      
      override public function UnstreamizeGenerateInventory(param1:ByteArray, param2:Object, param3:Object) : void
      {
         super.UnstreamizeGenerateInventory(param1,param2,param3);
         this.UnstreamizationPerform_GenerateEquipmentProperties(param1,param2,param3);
         this.UnstreamizationPerform_EquipmentByDatabase(param2,param3);
      }
   }
}

