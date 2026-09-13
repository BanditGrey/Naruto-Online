package Logics.Streamization.Characters
{
   import Foundation.Resources.*;
   import Foundation.Resources.Bins.*;
   import Foundation.Streamization.*;
   import Foundation.Utilities.*;
   import Logics.Buffs.*;
   import Logics.Characters.*;
   import Logics.DatebaseVO.VO.*;
   import Logics.Inventories.*;
   import Logics.Pet.TPet;
   import Logics.SLogicsCore;
   import Logics.Spaces.*;
   import Logics.Streamization.Buffs.*;
   import Logics.Streamization.Inventories.*;
   import Logics.Streamization.Quest.*;
   import Logics.Streamization.Skills.*;
   import Logics.Vip.TVip;
   import Resources.Constants.*;
   import flash.utils.*;
   
   use namespace LogicsSpace;
   
   public class TUnstreamizerCharacter extends TUnstreamizerCharacterUnknown
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
      
      protected var FUnstreamizerBuffGlobal:TUnstreamizerBuffGlobal;
      
      protected var FInventoryReference:TInventoryReference;
      
      public function TUnstreamizerCharacter()
      {
         super();
         this.FUnstreamizerBuffGlobal = new TUnstreamizerBuffGlobal();
         FUnstreamizerSkills = new TUnstreamizerSkills();
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         this.FUnstreamizerCollectionInventory = new TUnstreamizerCollectionInventory();
         this.FUnstreamizerInventories = new TUnstreamizerInventories();
         this.FInventoryReference = new TInventoryReference();
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
      }
      
      protected function UnstreamizationPerform_BasicProperties(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:TCharacter = null;
         var _loc7_:TVip = null;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         _loc6_ = param2 as TCharacter;
         _loc7_ = _loc6_.VipData;
         _loc6_.AgentOperatorId = param1.readUnsignedInt();
         _loc6_.ServerId = param1.readUnsignedInt();
         _loc6_.AgentUserId = TUtilityString.FetchUTF(param1);
         _loc4_ = param1.readUnsignedInt();
         _loc5_ = param1.readUnsignedInt();
         _loc6_.Coerce(_loc4_,_loc5_);
         _loc6_.NickName = TUtilityString.FetchUTF(param1);
         _loc6_.Country = param1.readUnsignedInt();
         _loc6_.MilitaryRank = param1.readUnsignedInt();
         _loc6_.Prestige = param1.readUnsignedInt();
         _loc6_.CreditSilverCoin.High = param1.readUnsignedInt();
         _loc6_.CreditSilverCoin.Low = param1.readUnsignedInt();
         _loc6_.CreditGold = param1.readUnsignedInt();
         _loc6_.CreditGiftCertificate = param1.readUnsignedInt();
         _loc6_.CreditMilitaryOrders = param1.readUnsignedInt();
         _loc8_ = int(param1.readUnsignedInt());
         _loc9_ = int(param1.readUnsignedInt());
         _loc7_.CoercePropertieVipLevel(_loc8_);
         _loc7_.CoercePropertieVipExp(_loc9_);
         _loc6_.BackpackCapacity = param1.readUnsignedShort();
         _loc6_.BackpackExpandCount = param1.readUnsignedByte();
         _loc6_.TownID = param1.readUnsignedInt();
         _loc6_.StarMapIndex = param1.readUnsignedInt();
         _loc6_.GeneralsSoul = param1.readUnsignedInt();
         _loc6_.HeroSoulBlueSoul = param1.readUnsignedInt();
         _loc6_.HeroSoulPurpleSoul = param1.readUnsignedInt();
         _loc6_.HeroSoulGoldSoul = param1.readUnsignedInt();
         _loc6_.HeroSoulOrangeSoul = param1.readUnsignedInt();
         _loc6_.Wing.WingID = param1.readUnsignedInt();
         _loc6_.SpecialJade.JadeID = param1.readUnsignedInt();
         _loc6_.Wing.TransformID = param1.readUnsignedInt();
         _loc6_.Wing.HideWing = param1.readUnsignedInt();
         _loc6_.Pet.CurSoulFormationID = param1.readUnsignedInt();
         SLogicsCore.MasterRoad.IsFirst = param1.readUnsignedInt();
         _loc6_.BadgeList.length = 0;
         _loc13_ = int(param1.readUnsignedShort());
         _loc12_ = 0;
         while(_loc12_ < _loc13_)
         {
            _loc6_.BadgeList[_loc12_] = param1.readUnsignedInt();
            _loc12_++;
         }
      }
      
      protected function UnstreamizationPerform_Quests(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:TCharacter = null;
         _loc4_ = param2 as TCharacter;
      }
      
      protected function UnstreamizationPerform_BuffsGlobal(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:TCharacter = null;
         var _loc5_:TCollectionBuff = null;
         var _loc6_:TBuffs = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:TBuff = null;
         var _loc10_:int = 0;
         _loc4_ = param2 as TCharacter;
      }
      
      protected function UnstreamizationPerform_Heros(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:THeros = null;
         var _loc7_:THero = null;
         var _loc8_:TBaseHero = null;
         _loc6_ = param2 as THeros;
         _loc6_.Clear();
         _loc4_ = int(param1.readUnsignedShort());
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc7_ = FPoolCharacter.AcquireHero();
            this.UnstreamizationPerform_HeroProperties(param1,_loc7_,param3);
            this.UnstreamizationPerform_HeroByDatabase(_loc7_);
            _loc8_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BaseHero,_loc7_.Identifier) as TBaseHero;
            _loc7_.ReincarnationId = _loc8_.TransId;
            _loc7_.OrigionId = _loc8_.OrigionId;
            _loc7_.ReincarnationOneOrTwo = _loc8_.TransState;
            _loc6_.Add(_loc7_);
            _loc5_++;
         }
      }
      
      protected function UnstreamizationPerform_Hero(param1:ByteArray, param2:Object, param3:Object) : THero
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:THero = null;
         var _loc7_:TBaseHero = null;
         _loc6_ = FPoolCharacter.AcquireHero();
         this.UnstreamizationPerform_HeroProperties(param1,_loc6_,param3);
         this.UnstreamizationPerform_HeroByDatabase(_loc6_);
         _loc7_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BaseHero,_loc6_.Identifier) as TBaseHero;
         _loc6_.ReincarnationId = _loc7_.TransId;
         _loc6_.OrigionId = _loc7_.OrigionId;
         _loc6_.ReincarnationOneOrTwo = _loc7_.TransState;
         return _loc6_;
      }
      
      protected function UnstreamizationPerform_Pet(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:TPet = null;
         var _loc5_:uint = 0;
         _loc4_ = param2 as TPet;
         _loc4_.PetID = param1.readUnsignedInt();
         _loc4_.ImageID = param1.readUnsignedInt();
         _loc5_ = param1.readUnsignedByte();
         if(_loc5_ == 0)
         {
            _loc4_.RelexBoo = true;
         }
         else
         {
            _loc4_.RelexBoo = false;
         }
         this.UnstreamizationPerform_PetByDatabase(_loc4_);
      }
      
      protected function UnstreamizationPerform_HeroProperties(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:int = 0;
         var _loc5_:uint = 0;
         var _loc6_:THero = null;
         _loc6_ = param2 as THero;
         _loc5_ = param1.readUnsignedInt();
         _loc6_.Coerce(_loc5_);
         _loc6_.Level = param1.readUnsignedInt();
         _loc6_.Experience.High = param1.readUnsignedInt();
         _loc6_.Experience.Low = param1.readUnsignedInt();
         _loc6_.Profession = param1.readUnsignedByte();
         _loc6_.FightPosition = param1.readUnsignedByte();
         if(_loc6_.FightPosition == 0)
         {
            _loc6_.Mounted = false;
         }
         else
         {
            _loc6_.Mounted = true;
         }
         FUnstreamizerSkills.Unstreamize(param1,_loc6_.Skills,param3);
         this.UnstreamizationPerform_BaseAttributes(param1,_loc6_,param3);
         this.UnstreamizationPerform_EquipmentsMounted(param1,_loc6_,param3);
         _loc6_.PotentialLv = param1.readUnsignedInt();
         _loc6_.PotentialExp = param1.readUnsignedInt();
         _loc6_.ExpIsInherited = param1.readByte();
         _loc6_.AwakeLevel = param1.readUnsignedInt();
         _loc6_.AwakeSkil = param1.readUnsignedInt();
      }
      
      public function UnstreamizationPerform_SuperHeroByDatabase(param1:Object) : void
      {
         var _loc2_:TSuperHero = null;
         var _loc3_:TChangeHero = null;
         var _loc4_:TBaseHero = null;
         _loc2_ = param1 as TSuperHero;
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ChangeHero,_loc2_.Identifier) as TChangeHero;
         _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BaseHero,_loc2_.Identifier) as TBaseHero;
         _loc2_.HeroType = _loc3_.Stype;
         _loc2_.HeroSpecialTalk = _loc3_.Desc;
         _loc2_.RelationHeroID = _loc3_.UpHeroID;
         _loc2_.AdvanceNeedVipLevel = _loc3_.VipLimit;
         _loc2_.HeroDescribtion = _loc4_.Desc;
         _loc2_.EnlistLevelLimit = _loc4_.NeedLevel;
         _loc2_.AddEnlistCondition(_loc3_.EnlistCondition);
         _loc2_.AddOriginalEnlistCondition(_loc3_.OriginalEnlistCondition);
         _loc2_.ReincarnationId = _loc4_.TransId;
         _loc2_.OrigionId = _loc4_.OrigionId;
         _loc2_.ReincarnationOneOrTwo = _loc4_.TransState;
      }
      
      protected function UnstreamizationPerform_HeroByDatabase(param1:Object) : void
      {
         var _loc2_:THero = null;
         var _loc3_:TBaseHero = null;
         var _loc4_:THeroTalent = null;
         var _loc5_:TRoleModel = null;
         var _loc6_:TSkillConfig = null;
         _loc2_ = param1 as THero;
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BaseHero,_loc2_.Identifier) as TBaseHero;
         _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_HeroTalent,_loc3_.Talent) as THeroTalent;
         _loc5_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_RoleModel,_loc2_.Identifier) as TRoleModel;
         _loc6_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SkillConfig,_loc3_.NormalAttack) as TSkillConfig;
         _loc2_.Name = _loc3_.Name;
         _loc2_.IsMain = _loc3_.IsMain;
         _loc2_.Quality = _loc2_.AwakeLevel == 0 ? uint(_loc3_.Quality) : uint(_loc3_.Awakequality);
         _loc2_.InitilizationLevel = _loc3_.Level;
         _loc2_.TalentName = _loc4_.TalentName;
         _loc2_.TalentDesc = _loc4_.TalentDesc;
         _loc2_.NormalAttackName = _loc6_.Name;
         _loc2_.ModelID = _loc5_.Model;
         _loc2_.SmallID = _loc5_.RoleHead;
         _loc2_.LargeID = _loc5_.RoleStyle;
         _loc2_.Assess = _loc3_.Assess;
      }
      
      protected function UnstreamizationPerform_PetByDatabase(param1:Object) : void
      {
         var _loc2_:TPet = null;
         var _loc3_:TBasePet = null;
         var _loc4_:TPetImage = null;
         var _loc5_:TRoleModel = null;
         _loc2_ = param1 as TPet;
         if(_loc2_.ImageID < 0)
         {
            return;
         }
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BasePet,_loc2_.PetID) as TBasePet;
         _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_PetImage,_loc2_.ImageID) as TPetImage;
         _loc5_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_RoleModel,_loc2_.ImageID) as TRoleModel;
         _loc2_.Name = _loc4_.Name;
         _loc2_.Star = _loc3_.Star;
         _loc2_.PetModelID = _loc2_.ImageID;
         _loc2_.SmallIcon = _loc5_.RoleHead;
         _loc2_.ReincarnationLevel = _loc3_.NeedTransLv;
      }
      
      protected function UnstreamizationPerform_BaseAttributes(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:THero = null;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         _loc6_ = param2 as THero;
         _loc9_ = CONST_COMMON.CAPACITY_FirstAttributesRate;
         _loc10_ = CONST_COMMON.CAPACITY_FirstAttributes;
         _loc5_ = int(param1.readUnsignedShort());
         _loc5_ = _loc5_ - (_loc9_ + _loc10_);
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            if(_loc4_ >= STARTINDEX_BaseAttribute && _loc4_ < ENDINDEX_BaseAttribute)
            {
               _loc7_ = param1.readFloat();
               _loc8_ = parseFloat(Number(_loc7_ * 100).toFixed(1));
               _loc6_.SetBaseAttributeByIndex(_loc4_,_loc8_);
            }
            else
            {
               if(_loc4_ == CONST_COMMON.BASEATTRIBUTEINDEX_Health)
               {
                  _loc7_ = Math.round(param1.readFloat());
               }
               else
               {
                  _loc7_ = param1.readUnsignedInt();
               }
               _loc6_.SetBaseAttributeByIndex(_loc4_,_loc7_);
            }
            _loc4_++;
         }
         _loc4_ = 0;
         while(_loc4_ < _loc10_)
         {
            _loc7_ = param1.readUnsignedInt();
            _loc6_.SetFirstAttributeByIndex(_loc4_,_loc7_);
            _loc4_++;
         }
         _loc4_ = 0;
         while(_loc4_ < _loc9_)
         {
            _loc7_ = param1.readFloat();
            _loc8_ = parseFloat(Number(_loc7_).toFixed(1));
            _loc6_.SetFirstAttributeRateByIndex(_loc4_,_loc8_);
            _loc4_++;
         }
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
         var _loc4_:TCharacter = null;
         _loc4_ = param2 as TCharacter;
         this.FUnstreamizerInventories.Unstreamize(param1,_loc4_.Inventories,param3);
      }
      
      protected function UnstreamizationPerform_Classification_Inventories(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:TCharacter = null;
         var _loc9_:TInventory = null;
         var _loc10_:TInventories = null;
         var _loc11_:TInventories = null;
         var _loc12_:TInventories = null;
         var _loc13_:TInventories = null;
         var _loc14_:TInventories = null;
         var _loc15_:TInventories = null;
         var _loc16_:TInventories = null;
         var _loc17_:TInventories = null;
         _loc8_ = param2 as TCharacter;
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
         var _loc4_:TCharacter = null;
         _loc4_ = param2 as TCharacter;
         this.FUnstreamizerInventories.Unstreamize(param1,_loc4_.TemporaryInventories,param3);
      }
      
      protected function UnstreamizationPerform_GenerateHerosByIdentifiers(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:uint = 0;
         var _loc7_:Vector.<uint> = null;
         var _loc8_:TBins = null;
         var _loc9_:TBaseHero = null;
         var _loc10_:THeros = null;
         var _loc11_:THero = null;
         _loc10_ = param2 as THeros;
         _loc7_ = param3 as Vector.<uint>;
         _loc8_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_BaseHero);
         _loc5_ = int(_loc7_.length);
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc6_ = _loc7_[_loc4_];
            _loc9_ = _loc8_.GetDatebaseByIdentifier(_loc6_) as TBaseHero;
            _loc11_ = FPoolCharacter.AcquireHero(_loc6_);
            this.UnstreamizationPerform_GenerateHeroProperties(param1,_loc11_,_loc8_);
            this.UnstreamizationPerform_HeroByDatabase(_loc11_);
            _loc10_.Add(_loc11_);
            _loc4_++;
         }
      }
      
      protected function UnstreamizationPerform_GenerateSuperHerosByIdentifiers(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:uint = 0;
         var _loc7_:Vector.<uint> = null;
         var _loc8_:TBins = null;
         var _loc9_:TBaseHero = null;
         var _loc10_:THeros = null;
         var _loc11_:TSuperHero = null;
         _loc10_ = param2 as THeros;
         _loc7_ = param3 as Vector.<uint>;
         _loc8_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_BaseHero);
         _loc5_ = int(_loc7_.length);
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc6_ = _loc7_[_loc4_];
            _loc9_ = _loc8_.GetDatebaseByIdentifier(_loc6_) as TBaseHero;
            _loc11_ = FPoolCharacter.AcquireSuperHero(_loc6_);
            this.UnstreamizationPerform_GenerateHeroProperties(param1,_loc11_,_loc8_);
            this.UnstreamizationPerform_HeroByDatabase(_loc11_);
            _loc10_.Add(_loc11_);
            _loc4_++;
         }
      }
      
      protected function UnstreamizationPerform_GenerateHeroProperties(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:int = 0;
         var _loc5_:uint = 0;
         var _loc6_:THero = null;
         var _loc7_:TBins = null;
         var _loc8_:TBaseHero = null;
         _loc6_ = param2 as THero;
         _loc7_ = param3 as TBins;
         _loc8_ = _loc7_.GetDatebaseByIdentifier(_loc6_.Identifier) as TBaseHero;
         _loc6_.Level = _loc8_.Level;
         _loc6_.Experience.High = 0;
         _loc6_.Experience.Low = 0;
         _loc6_.Profession = _loc8_.Profession;
         _loc6_.FightPosition = 0;
         _loc6_.Mounted = false;
         FUnstreamizerSkills.UnstreamizeGenerateSkills(param1,_loc6_,param3);
         _loc6_.ReincarnationId = _loc8_.TransId;
         _loc6_.OrigionId = _loc8_.OrigionId;
         _loc6_.ReincarnationOneOrTwo = _loc8_.TransState;
      }
      
      public function UnstreamizeBasicProperties(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform_BasicProperties(param1,param2,param3);
      }
      
      public function UnstreamizeQuests(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform_Quests(param1,param2,param3);
      }
      
      public function UnstreamizeBuffsGlobal(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform_BuffsGlobal(param1,param2,param3);
      }
      
      public function UnstreamizeHeros(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform_Heros(param1,param2,param3);
      }
      
      public function UnstreamizeHero(param1:ByteArray, param2:Object, param3:Object) : THero
      {
         return this.UnstreamizationPerform_Hero(param1,param2,param3);
      }
      
      public function UnstreamizePet(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform_Pet(param1,param2,param3);
      }
      
      public function UnstreamizeFreshGuide(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:String = null;
         _loc4_ = TUtilityString.FetchUTF(param1);
         SLogicsCore.Character.FreshGuideProgress = _loc4_;
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
      
      public function UnstreamizeBaseAttributes(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform_BaseAttributes(param1,param2,param3);
      }
      
      public function UnstreamizeGenerateHerosByIdentifiers(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform_GenerateHerosByIdentifiers(param1,param2,param3);
      }
      
      public function UnstreamizeGenerateSuperHerosByIdentifiers(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform_GenerateSuperHerosByIdentifiers(param1,param2,param3);
      }
   }
}

