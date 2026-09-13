package Logics.Inventories
{
   import Resources.Constants.*;
   
   public class TEquipment extends TInventory
   {
      
      protected var CAPACITY_SuitEffects:uint = 3;
      
      protected var FRequirementCareer:Vector.<uint>;
      
      protected var FBasisPropertyCategory:uint;
      
      protected var FBasisProperty:uint;
      
      protected var FUpgradingBasisProperty:uint;
      
      protected var FMainAdditionalCategory:uint;
      
      protected var FMainAdditionalValue:Number;
      
      protected var FMaxAdditionalCount:uint;
      
      protected var FAppendAttributes:TEquipmentAppendAttributes;
      
      protected var FWeaponSkillID:uint;
      
      protected var FWeaponSkillName:String;
      
      protected var FWeaponSkillDesc:String;
      
      protected var FHoleCount:uint;
      
      protected var FExpandHoleCount:int;
      
      protected var FDigHoleNum:uint;
      
      protected var FGiftedStoneItems:TGiftedStoneItems;
      
      protected var FEnchantCoefficient:Number;
      
      protected var FEnchantLevel:uint;
      
      protected var FEnchantValue:uint;
      
      protected var FSuitID:int;
      
      protected var FSuitData:TSuitData;
      
      protected var FSuitCount:int;
      
      protected var FSuitMemberId:Vector.<uint>;
      
      protected var FSuitObject:Object;
      
      protected var FEightSuitObject:Object;
      
      protected var FIsAdvancedEquip:Boolean;
      
      protected var FIsCastEquip:Boolean;
      
      protected var FDisplay:int = 7;
      
      public function TEquipment(param1:uint, param2:uint)
      {
         super(param1,param2);
         this.FRequirementCareer = new Vector.<uint>();
         this.FAppendAttributes = new TEquipmentAppendAttributes();
         this.FGiftedStoneItems = new TGiftedStoneItems();
         this.FSuitMemberId = new Vector.<uint>();
         this.FWeaponSkillName = "";
         this.FWeaponSkillDesc = "";
         this.FSuitData = new TSuitData();
         this.FIsAdvancedEquip = false;
         this.FIsCastEquip = false;
      }
      
      public function get RequirementCareer() : Vector.<uint>
      {
         return this.FRequirementCareer;
      }
      
      public function set RequirementCareer(param1:Vector.<uint>) : void
      {
         this.FRequirementCareer = param1;
      }
      
      public function get BasisPropertyCategory() : uint
      {
         return this.FBasisPropertyCategory;
      }
      
      public function set BasisPropertyCategory(param1:uint) : void
      {
         this.FBasisPropertyCategory = param1;
      }
      
      public function get BasisProperty() : uint
      {
         return this.FBasisProperty;
      }
      
      public function set BasisProperty(param1:uint) : void
      {
         this.FBasisProperty = param1;
      }
      
      public function get UpgradingBasisProperty() : uint
      {
         return this.FUpgradingBasisProperty;
      }
      
      public function set UpgradingBasisProperty(param1:uint) : void
      {
         this.FUpgradingBasisProperty = param1;
      }
      
      public function get MainAdditionalCategory() : uint
      {
         return this.FMainAdditionalCategory;
      }
      
      public function set MainAdditionalCategory(param1:uint) : void
      {
         this.FMainAdditionalCategory = param1;
      }
      
      public function get MainAdditionalValue() : Number
      {
         return this.FMainAdditionalValue;
      }
      
      public function set MainAdditionalValue(param1:Number) : void
      {
         this.FMainAdditionalValue = param1;
      }
      
      public function get MaxAdditionalCount() : uint
      {
         return this.FMaxAdditionalCount;
      }
      
      public function set MaxAdditionalCount(param1:uint) : void
      {
         this.FMaxAdditionalCount = param1;
      }
      
      public function get AppendAttributes() : TEquipmentAppendAttributes
      {
         return this.FAppendAttributes;
      }
      
      public function get WeaponSkillID() : uint
      {
         return this.FWeaponSkillID;
      }
      
      public function set WeaponSkillID(param1:uint) : void
      {
         this.FWeaponSkillID = param1;
      }
      
      public function get WeaponSkillName() : String
      {
         return this.FWeaponSkillName;
      }
      
      public function set WeaponSkillName(param1:String) : void
      {
         this.FWeaponSkillName = param1;
      }
      
      public function get WeaponSkillDesc() : String
      {
         return this.FWeaponSkillDesc;
      }
      
      public function set WeaponSkillDesc(param1:String) : void
      {
         this.FWeaponSkillDesc = param1;
      }
      
      public function get HoleCount() : uint
      {
         return this.FHoleCount;
      }
      
      public function set HoleCount(param1:uint) : void
      {
         this.FHoleCount = param1;
      }
      
      public function get ExpandHoleCount() : int
      {
         return this.FExpandHoleCount;
      }
      
      public function set ExpandHoleCount(param1:int) : void
      {
         this.FExpandHoleCount = param1;
      }
      
      public function get DigHoleNum() : uint
      {
         return this.FDigHoleNum;
      }
      
      public function set DigHoleNum(param1:uint) : void
      {
         this.FDigHoleNum = param1;
      }
      
      public function get GiftedStoneItems() : TGiftedStoneItems
      {
         return this.FGiftedStoneItems;
      }
      
      public function get EnchantCoefficient() : Number
      {
         return this.FEnchantCoefficient;
      }
      
      public function set EnchantCoefficient(param1:Number) : void
      {
         this.FEnchantCoefficient = param1;
      }
      
      public function get EnchantLevel() : int
      {
         return this.FEnchantLevel;
      }
      
      public function set EnchantLevel(param1:int) : void
      {
         this.FEnchantLevel = param1;
      }
      
      public function get EnchantValue() : int
      {
         return this.FEnchantValue;
      }
      
      public function set EnchantValue(param1:int) : void
      {
         this.FEnchantValue = param1;
      }
      
      public function get SuitID() : int
      {
         return this.FSuitID;
      }
      
      public function set SuitID(param1:int) : void
      {
         this.FSuitID = param1;
      }
      
      public function get SuitData() : TSuitData
      {
         return this.FSuitData;
      }
      
      public function get SuitCount() : int
      {
         return this.FSuitCount;
      }
      
      public function set SuitCount(param1:int) : void
      {
         this.FSuitCount = param1;
      }
      
      public function get SuitObject() : Object
      {
         return this.FSuitObject;
      }
      
      public function set SuitObject(param1:Object) : void
      {
         this.FSuitObject = param1;
      }
      
      public function get EightSuitObject() : Object
      {
         return this.FEightSuitObject;
      }
      
      public function set EightSuitObject(param1:Object) : void
      {
         this.FEightSuitObject = param1;
      }
      
      public function get SuitMemberId() : Vector.<uint>
      {
         return this.FSuitMemberId;
      }
      
      public function get IsAdvancedEquip() : Boolean
      {
         return this.FIsAdvancedEquip;
      }
      
      public function set IsAdvancedEquip(param1:Boolean) : void
      {
         this.FIsAdvancedEquip = param1;
      }
      
      public function get IsCastEquip() : Boolean
      {
         return this.FIsCastEquip;
      }
      
      public function set IsCastEquip(param1:Boolean) : void
      {
         this.FIsCastEquip = param1;
      }
      
      public function get Display() : int
      {
         return this.FDisplay;
      }
      
      public function set Display(param1:int) : void
      {
         this.FDisplay = param1;
      }
      
      public function get IsEpic() : Boolean
      {
         return FRequirementLevel > CONST_COMMON.Ninja_One_Reincarnation_Footstone;
      }
      
      override public function Reset() : void
      {
         super.Reset();
         this.FRequirementCareer.length = 0;
         this.FBasisPropertyCategory = 0;
         this.FBasisProperty = 0;
         this.FUpgradingBasisProperty = 0;
         this.FMaxAdditionalCount = 0;
         this.FAppendAttributes.Clear();
         this.FWeaponSkillID = 0;
         this.FWeaponSkillName = "";
         this.FWeaponSkillDesc = "";
         this.FHoleCount = 0;
         this.FExpandHoleCount = 0;
         this.FGiftedStoneItems.Clear();
         this.FSuitID = 0;
         this.FSuitCount = 0;
         this.FSuitData.Reset();
         this.FIsAdvancedEquip = false;
         this.FIsCastEquip = false;
         this.FDisplay = 7;
         this.FEnchantCoefficient = 0;
         this.FEnchantLevel = 0;
         this.FEnchantValue = 0;
         this.FMainAdditionalCategory = 0;
         this.FMainAdditionalValue = 0;
      }
   }
}

