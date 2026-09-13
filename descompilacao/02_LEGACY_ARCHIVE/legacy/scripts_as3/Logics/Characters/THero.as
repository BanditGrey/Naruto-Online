package Logics.Characters
{
   import Foundation.Common.*;
   import Foundation.Common.Integer.UInt64;
   import Foundation.Common.Stubs.TStubReferences;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Utilities.TUtilityString;
   import Logics.BloodFete.TBloodFeteSingle;
   import Logics.DatebaseVO.VO.TBaseEquip;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.DatebaseVO.VO.TEquipUpgrade;
   import Logics.DatebaseVO.VO.TFollowBloodBound;
   import Logics.DatebaseVO.VO.THeroExp;
   import Logics.Inventories.TCollectionInventory;
   import Logics.Inventories.TEquipment;
   import Logics.NijiaStar.TNijiaStars;
   import Logics.Skills.TSkill;
   import Logics.Skills.TSkills;
   import Logics.Spaces.LogicsSpace;
   import Processors.Game.Lobby.Taboo.Data.TabooDataCell;
   import Resources.Constants.CONST_CHARACTER;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_CONFIGVALUE;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_INVENTORY;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_NINJIAREINCARNATION;
   
   use namespace LogicsSpace;
   
   public class THero extends TEntity
   {
      
      public static const CAPACITY_BaseAttributes:uint = CONST_COMMON.CAPACITY_BaseAttributes;
      
      public static const BASEATTRIBUTEINDEX_Power:uint = CONST_COMMON.BASEATTRIBUTEINDEX_Power;
      
      public static const BASEATTRIBUTEINDEX_Intelligence:uint = CONST_COMMON.BASEATTRIBUTEINDEX_Intelligence;
      
      public static const BASEATTRIBUTEINDEX_Agile:uint = CONST_COMMON.BASEATTRIBUTEINDEX_Agile;
      
      public static const BASEATTRIBUTEINDEX_Life:uint = CONST_COMMON.BASEATTRIBUTEINDEX_Life;
      
      public static const BASEATTRIBUTEINDEX_Speed:uint = CONST_COMMON.BASEATTRIBUTEINDEX_Speed;
      
      public static const BASEATTRIBUTEINDEX_Health:uint = CONST_COMMON.BASEATTRIBUTEINDEX_Health;
      
      public static const BASEATTRIBUTEINDEX_PhysicalAttack:uint = CONST_COMMON.BASEATTRIBUTEINDEX_PhysicalAttack;
      
      public static const BASEATTRIBUTEINDEX_MagicAttack:uint = CONST_COMMON.BASEATTRIBUTEINDEX_MagicAttack;
      
      public static const BASEATTRIBUTEINDEX_PhysicalDefends:uint = CONST_COMMON.BASEATTRIBUTEINDEX_PhysicalDefends;
      
      public static const BASEATTRIBUTEINDEX_MagicDefends:uint = CONST_COMMON.BASEATTRIBUTEINDEX_MagicDefends;
      
      public static const BASEATTRIBUTEINDEX_BeginAnger:uint = CONST_COMMON.BASEATTRIBUTEINDEX_BeginAnger;
      
      public static const BASEATTRIBUTEINDEX_AvoidInjury:uint = CONST_COMMON.BASEATTRIBUTEINDEX_AvoidInjury;
      
      public static const BASEATTRIBUTEINDEX_Hit:uint = CONST_COMMON.BASEATTRIBUTEINDEX_Hit;
      
      public static const BASEATTRIBUTEINDEX_Dodge:uint = CONST_COMMON.BASEATTRIBUTEINDEX_Dodge;
      
      public static const BASEATTRIBUTEINDEX_Crit:uint = CONST_COMMON.BASEATTRIBUTEINDEX_Crit;
      
      public static const BASEATTRIBUTEINDEX_GridFile:uint = CONST_COMMON.BASEATTRIBUTEINDEX_GridFile;
      
      public static const BASEATTRIBUTEINDEX_Punch:uint = CONST_COMMON.BASEATTRIBUTEINDEX_Punch;
      
      public static const BASEATTRIBUTEINDEX_Help:uint = CONST_COMMON.BASEATTRIBUTEINDEX_Help;
      
      public static const BASEATTRIBUTEINDEX_Wreck:uint = CONST_COMMON.BASEATTRIBUTEINDEX_Wreck;
      
      public static const BASEATTRIBUTEINDEX_Uprising:uint = CONST_COMMON.BASEATTRIBUTEINDEX_Uprising;
      
      public static const BASEATTRIBUTEINDEX_Hurt:uint = CONST_COMMON.BASEATTRIBUTEINDEX_Hurt;
      
      public static const BASEATTRIBUTEINDEX_FightingPower:uint = CONST_COMMON.BASEATTRIBUTEINDEX_FightingPower;
      
      public static const CAPACITY_FirstAttributesRate:uint = CONST_COMMON.CAPACITY_FirstAttributesRate;
      
      public static const FIRSTATTRIBUTERATEINDEX_Power:uint = CONST_COMMON.FIRSTATTRIBUTERATEINDEX_Power;
      
      public static const FIRSTATTRIBUTERATEINDEX_Intelligence:uint = CONST_COMMON.FIRSTATTRIBUTERATEINDEX_Intelligence;
      
      public static const FIRSTATTRIBUTERATEINDEX_Agile:uint = CONST_COMMON.FIRSTATTRIBUTERATEINDEX_Agile;
      
      public static const FIRSTATTRIBUTERATEINDEX_Health:uint = CONST_COMMON.FIRSTATTRIBUTERATEINDEX_Health;
      
      public static const Ninja_One_Reincarnation_Footstone:int = CONST_COMMON.Ninja_One_Reincarnation_Footstone;
      
      public static const Ninja_Two_Reincarnation_Footstone:int = CONST_COMMON.Ninja_Two_Reincarnation_Footstone;
      
      public static const Ninja_Three_Reincarnation_Footstone:int = CONST_COMMON.Ninja_Three_Reincarnation_Footstone;
      
      public static const CAPACITY_EquipmentsMounted:uint = CONST_CHARACTER.CAPACITY_EquipmentsMounted;
      
      public static const CAPACITY_TalismansMounted:uint = CONST_CHARACTER.CAPACITY_TalismansMounted;
      
      public static const CAPACITY_AccessoryMounted:uint = CONST_CHARACTER.CAPACITY_AccessoryMounted;
      
      public static const CAPACITY_BloodFeteMounted:uint = CONST_CHARACTER.CAPACITY_BloodFeteMounted;
      
      public static const CAPACITY_MedalsMounted:uint = CONST_CHARACTER.CAPACITY_MedalsMounted;
      
      protected static const INDEX_Station_Front:int = 1;
      
      protected static const INDEX_Station_Middle:int = 2;
      
      protected static const INDEX_Station_After:int = 3;
      
      public static const PROFESSION_Agility:uint = CONST_CHARACTER.PROFESSION_Agility;
      
      public static const PROFESSION_Defending:uint = CONST_CHARACTER.PROFESSION_Defending;
      
      public static const PROFESSION_Intellect:uint = CONST_CHARACTER.PROFESSION_Intellect;
      
      public static const PROFESSION_Strength:uint = CONST_CHARACTER.PROFESSION_Strength;
      
      public static const POTENTIALINCREMENT_reincarnation_before:int = CONST_CHARACTER.POTENTIALINCREMENT_reincarnation_before;
      
      public static const POTENTIALINCREMENT_reincarnation_after:int = CONST_CHARACTER.POTENTIALINCREMENT_reincarnation_after;
      
      public static const CATEGORY_Equipment:uint = CONST_INVENTORY.CATEGORY_Equipment;
      
      public static const CATEGORY_Accessories:uint = CONST_INVENTORY.CATEGORY_Accessories;
      
      protected var FStubReferences:TStubReferences;
      
      protected var FName:String;
      
      protected var FProfession:uint;
      
      protected var FLevel:uint;
      
      protected var FInitilizationLevel:uint;
      
      protected var FOrigionId:uint;
      
      protected var FReincarnationOneOrTwo:int = 0;
      
      protected var FReincarnationId:int = 0;
      
      protected var FMachampId:int = 0;
      
      protected var FTempMachampId:int = 0;
      
      protected var FAssess:String;
      
      protected var FExperience:UInt64;
      
      protected var FSkills:TSkills;
      
      protected var FSkillsCopy:TSkills;
      
      protected var FBaseAttributes:Vector.<Number>;
      
      protected var FBaseAttributesCopy:Vector.<Number>;
      
      protected var FEquipmentsMounted:TCollectionInventory;
      
      protected var FTalismansMounted:TCollectionInventory;
      
      protected var FAccessoryMounted:TCollectionInventory;
      
      protected var FMedalsMounted:TCollectionInventory;
      
      protected var FBloodFeteMounted:Vector.<TBloodFeteSingle> = null;
      
      protected var FTabooMounted:Vector.<TabooDataCell> = null;
      
      protected var FIsSkillInherit:Boolean;
      
      protected var FIsSkillInherited:Boolean;
      
      protected var FNijiaStars:TNijiaStars;
      
      protected var FFightPosition:int;
      
      protected var FMounted:Boolean;
      
      protected var FIsMain:Boolean;
      
      protected var FQuality:uint;
      
      protected var FIsNewEmployment:Boolean;
      
      protected var FTalentName:String;
      
      protected var FTalentDesc:String;
      
      protected var FNormalAttackName:String;
      
      protected var FFirstAttributesRate:Vector.<Number>;
      
      protected var FFirstAttributes:Vector.<uint>;
      
      protected var FModelID:uint;
      
      protected var FLargeID:uint;
      
      protected var FSmallID:uint;
      
      protected var FPotentialLv:uint;
      
      protected var FPotentialLevelShow:uint;
      
      protected var FPotentialExp:uint;
      
      protected var FPotentialIncrement:int;
      
      protected var FReousrce:String;
      
      protected var FRecruitStatus:Boolean;
      
      protected var FExpIsInherited:uint = 0;
      
      protected var FExpRate:Number;
      
      protected var FAwakenSpecialSkillId:uint;
      
      protected var FAwakenCommonSkillId:uint;
      
      protected var FIsRecommand:Boolean;
      
      protected var FIsInHostel:Boolean;
      
      protected var FAwakeLevel:uint;
      
      protected var FAwakeSkil:uint;
      
      public var SuitObject:Object;
      
      public function THero(param1:uint)
      {
         super(param1);
         this.FStubReferences = new TStubReferences(this);
         this.FExperience = new UInt64();
         this.FSkills = new TSkills();
         this.FSkillsCopy = new TSkills();
         this.FBaseAttributes = new Vector.<Number>(CAPACITY_BaseAttributes);
         this.FBaseAttributesCopy = new Vector.<Number>(CAPACITY_BaseAttributes - 2);
         this.FEquipmentsMounted = new TCollectionInventory(CAPACITY_EquipmentsMounted);
         this.FTalismansMounted = new TCollectionInventory(CAPACITY_TalismansMounted);
         this.FAccessoryMounted = new TCollectionInventory(CAPACITY_AccessoryMounted);
         this.FMedalsMounted = new TCollectionInventory(CAPACITY_MedalsMounted);
         this.FBloodFeteMounted = new Vector.<TBloodFeteSingle>();
         this.FTabooMounted = new Vector.<TabooDataCell>();
         this.FNijiaStars = new TNijiaStars();
         this.FFirstAttributesRate = new Vector.<Number>(CAPACITY_FirstAttributesRate);
         this.FFirstAttributes = new Vector.<uint>(CAPACITY_FirstAttributesRate);
         this.FIsNewEmployment = false;
         this.FReousrce = "";
         this.FRecruitStatus = false;
         this.FExpRate = -1;
      }
      
      LogicsSpace function Coerce(param1:uint) : void
      {
         FIdentifier = param1;
      }
      
      public function get StubReferences() : TStubReferences
      {
         return this.FStubReferences;
      }
      
      public function get Name() : String
      {
         return this.FName;
      }
      
      public function set Name(param1:String) : void
      {
         this.FName = param1;
      }
      
      public function get Profession() : uint
      {
         return this.FProfession;
      }
      
      public function set Profession(param1:uint) : void
      {
         this.FProfession = param1;
      }
      
      public function get Level() : uint
      {
         return this.FLevel;
      }
      
      public function set Level(param1:uint) : void
      {
         this.FLevel = param1;
      }
      
      public function get InitilizationLevel() : uint
      {
         return this.FInitilizationLevel;
      }
      
      public function set InitilizationLevel(param1:uint) : void
      {
         this.FInitilizationLevel = param1;
      }
      
      public function set OrigionId(param1:int) : void
      {
         this.FOrigionId = param1;
      }
      
      public function get OrigionId() : int
      {
         return this.FOrigionId;
      }
      
      public function get BloodFeteMounted() : Vector.<TBloodFeteSingle>
      {
         return this.FBloodFeteMounted;
      }
      
      public function get TabooMounted() : Vector.<TabooDataCell>
      {
         return this.FTabooMounted;
      }
      
      public function GetOneTurnLevel() : uint
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:Number = NaN;
         var _loc4_:THeroExp = null;
         var _loc5_:TConfigValue = null;
         if(this.FExpRate <= 0)
         {
            _loc5_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.NinjaReincarnaton_ExpRate) as TConfigValue;
            this.FExpRate = _loc5_.Value as Number;
         }
         _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_HeroExp,this.FLevel) as THeroExp;
         _loc3_ = _loc4_.AllExp.ToNumber() - _loc4_.NeedExp.ToNumber() + this.FExperience.ToNumber();
         _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_HeroExp,CONST_COMMON.Ninja_Reincarnation_Logic_ - 1) as THeroExp;
         _loc3_ = (_loc3_ - _loc4_.AllExp.ToNumber()) * this.FExpRate + _loc4_.AllExp.ToNumber();
         _loc1_ = 1001;
         while(_loc1_ <= 1050)
         {
            _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_HeroExp,_loc1_) as THeroExp;
            if(_loc4_.AllExp.ToNumber() >= _loc3_)
            {
               return _loc1_;
            }
            _loc1_++;
         }
         return 1050;
      }
      
      public function GetTwoTurnLevel() : uint
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:Number = NaN;
         var _loc4_:THeroExp = null;
         var _loc5_:TConfigValue = null;
         if(this.FExpRate <= 0)
         {
            _loc5_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.NinjaReincarnaton_ExpRate) as TConfigValue;
            this.FExpRate = _loc5_.Value as Number;
         }
         _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_HeroExp,this.FLevel) as THeroExp;
         _loc3_ = _loc4_.AllExp.ToNumber() - _loc4_.NeedExp.ToNumber() + this.FExperience.ToNumber();
         _loc1_ = 2001;
         while(_loc1_ <= 2050)
         {
            _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_HeroExp,_loc1_) as THeroExp;
            if(_loc4_.AllExp.ToNumber() >= _loc3_)
            {
               return _loc1_;
            }
            _loc1_++;
         }
         return 2050;
      }
      
      public function GetThreeTurnLevel() : uint
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:Number = NaN;
         var _loc4_:THeroExp = null;
         var _loc5_:TConfigValue = null;
         if(this.FExpRate <= 0)
         {
            _loc5_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.NinjaReincarnaton_ExpRate) as TConfigValue;
            this.FExpRate = _loc5_.Value as Number;
         }
         _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_HeroExp,this.FLevel) as THeroExp;
         _loc3_ = _loc4_.AllExp.ToNumber() - _loc4_.NeedExp.ToNumber() + this.FExperience.ToNumber();
         _loc1_ = 3001;
         while(_loc1_ <= 3050)
         {
            _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_HeroExp,_loc1_) as THeroExp;
            if(_loc4_.AllExp.ToNumber() >= _loc3_)
            {
               return _loc1_;
            }
            _loc1_++;
         }
         return 3050;
      }
      
      public function GetLevelStrByLevel(param1:uint) : String
      {
         var _loc2_:String = "";
         if(param1 < Ninja_One_Reincarnation_Footstone)
         {
            _loc2_ = TUtilityString.Format(STRING_NINJIAREINCARNATION.LevelLv_Describe,param1);
         }
         else if(param1 < Ninja_Two_Reincarnation_Footstone)
         {
            _loc2_ = TUtilityString.Format(STRING_NINJIAREINCARNATION.Reincarnation_Describe,1,param1 - Ninja_One_Reincarnation_Footstone);
         }
         else if(param1 < Ninja_Two_Reincarnation_Footstone)
         {
            _loc2_ = TUtilityString.Format(STRING_NINJIAREINCARNATION.Reincarnation_Describe,1,param1 - Ninja_One_Reincarnation_Footstone);
         }
         else if(param1 < Ninja_Three_Reincarnation_Footstone)
         {
            _loc2_ = TUtilityString.Format(STRING_NINJIAREINCARNATION.Reincarnation_Describe,2,param1 - Ninja_Two_Reincarnation_Footstone);
         }
         else
         {
            _loc2_ = TUtilityString.Format(STRING_NINJIAREINCARNATION.Reincarnation_Describe,3,param1 - Ninja_Three_Reincarnation_Footstone);
         }
         return _loc2_;
      }
      
      public function GetLevelStrByLevelLineFeed(param1:uint) : String
      {
         var _loc2_:String = "";
         if(param1 < Ninja_One_Reincarnation_Footstone)
         {
            _loc2_ = TUtilityString.Format(STRING_NINJIAREINCARNATION.LevelLv_DescribeCopy,param1);
         }
         else if(param1 < Ninja_Two_Reincarnation_Footstone)
         {
            _loc2_ = TUtilityString.Format(STRING_NINJIAREINCARNATION.Reincarnation_DescribeCopy,1,param1 - Ninja_One_Reincarnation_Footstone);
         }
         else if(param1 < Ninja_Three_Reincarnation_Footstone)
         {
            _loc2_ = TUtilityString.Format(STRING_NINJIAREINCARNATION.Reincarnation_DescribeCopy,2,param1 - Ninja_Two_Reincarnation_Footstone);
         }
         else
         {
            _loc2_ = TUtilityString.Format(STRING_NINJIAREINCARNATION.Reincarnation_DescribeCopy,3,param1 - Ninja_Three_Reincarnation_Footstone);
         }
         return _loc2_;
      }
      
      public function GetOnlyLevelStrByLevelCopy(param1:uint) : String
      {
         var _loc2_:String = "";
         if(param1 < Ninja_One_Reincarnation_Footstone)
         {
            _loc2_ = "" + param1;
         }
         else if(param1 < Ninja_Two_Reincarnation_Footstone)
         {
            _loc2_ = TUtilityString.Format(STRING_NINJIAREINCARNATION.Reincarnation_DescribeCopyCopy,1,param1 - Ninja_One_Reincarnation_Footstone);
         }
         else if(param1 < Ninja_Three_Reincarnation_Footstone)
         {
            _loc2_ = TUtilityString.Format(STRING_NINJIAREINCARNATION.Reincarnation_DescribeCopyCopy,2,param1 - Ninja_Two_Reincarnation_Footstone);
         }
         else
         {
            _loc2_ = TUtilityString.Format(STRING_NINJIAREINCARNATION.Reincarnation_DescribeCopyCopy,3,param1 - Ninja_Three_Reincarnation_Footstone);
         }
         return _loc2_;
      }
      
      public function GetOnlyLevelStrByLevel(param1:uint) : String
      {
         var _loc2_:String = "";
         if(param1 < Ninja_One_Reincarnation_Footstone)
         {
            _loc2_ = "" + param1;
         }
         else if(param1 < Ninja_Two_Reincarnation_Footstone)
         {
            _loc2_ = TUtilityString.Format(STRING_NINJIAREINCARNATION.Reincarnation_Describe,1,param1 - Ninja_One_Reincarnation_Footstone);
         }
         else if(param1 < Ninja_Three_Reincarnation_Footstone)
         {
            _loc2_ = TUtilityString.Format(STRING_NINJIAREINCARNATION.Reincarnation_Describe,2,param1 - Ninja_Two_Reincarnation_Footstone);
         }
         else
         {
            _loc2_ = TUtilityString.Format(STRING_NINJIAREINCARNATION.Reincarnation_Describe,3,param1 - Ninja_Three_Reincarnation_Footstone);
         }
         return _loc2_;
      }
      
      public function GetQianNengLevelStr(param1:int) : String
      {
         var _loc3_:int = 0;
         var _loc2_:String = "";
         if(this.ReincarnationOneOrTwo <= 0)
         {
            _loc2_ = STRING_COMMON.FORMAT_Level + param1;
         }
         else
         {
            _loc3_ = 0;
            if(this.ReincarnationOneOrTwo == 1 && param1 == CONST_COMMON.Ninja_One_QianNeng)
            {
               param1 = CONST_COMMON.Ninja_One_QianNeng;
               _loc3_ = 1;
            }
            if(this.ReincarnationOneOrTwo == 2 && param1 == CONST_COMMON.Ninja_Two_QianNeng)
            {
               param1 = CONST_COMMON.Ninja_Two_QianNeng;
               _loc3_ = 2;
            }
            if(this.ReincarnationOneOrTwo == 3 && param1 == CONST_COMMON.Ninja_Three_QianNeng)
            {
               param1 = CONST_COMMON.Ninja_Three_QianNeng;
               _loc3_ = 3;
            }
            if(param1 >= CONST_COMMON.Ninja_Three_QianNeng + 1 || _loc3_ == 3)
            {
               _loc2_ = TUtilityString.Format(STRING_NINJIAREINCARNATION.Reincarnation_Describe,3,param1 - CONST_COMMON.Ninja_Three_QianNeng);
            }
            else if(param1 >= CONST_COMMON.Ninja_Two_QianNeng + 1 || _loc3_ == 2)
            {
               _loc2_ = TUtilityString.Format(STRING_NINJIAREINCARNATION.Reincarnation_Describe,2,param1 - CONST_COMMON.Ninja_Two_QianNeng);
            }
            else if(param1 >= CONST_COMMON.Ninja_One_QianNeng + 1 || _loc3_ == 1)
            {
               _loc2_ = TUtilityString.Format(STRING_NINJIAREINCARNATION.Reincarnation_Describe,1,param1 - CONST_COMMON.Ninja_One_QianNeng);
            }
            else
            {
               _loc2_ = STRING_COMMON.FORMAT_Level + param1;
            }
         }
         return _loc2_;
      }
      
      public function GetQianNengOnlyLevelStr(param1:int) : String
      {
         var _loc3_:int = 0;
         var _loc2_:String = "";
         if(this.ReincarnationOneOrTwo <= 0)
         {
            _loc2_ = "" + param1;
         }
         else
         {
            _loc3_ = 0;
            if(this.ReincarnationOneOrTwo == 1 && param1 == CONST_COMMON.Ninja_One_QianNeng)
            {
               param1 = CONST_COMMON.Ninja_One_QianNeng;
               _loc3_ = 1;
            }
            if(this.ReincarnationOneOrTwo == 2 && param1 == CONST_COMMON.Ninja_Two_QianNeng)
            {
               param1 = CONST_COMMON.Ninja_Two_QianNeng;
               _loc3_ = 2;
            }
            if(this.ReincarnationOneOrTwo == 3 && param1 == CONST_COMMON.Ninja_Three_QianNeng)
            {
               param1 = CONST_COMMON.Ninja_Three_QianNeng;
               _loc3_ = 3;
            }
            if(param1 >= CONST_COMMON.Ninja_Three_QianNeng + 1 || _loc3_ == 3)
            {
               _loc2_ = TUtilityString.Format(STRING_NINJIAREINCARNATION.Reincarnation_Describe,3,param1 - CONST_COMMON.Ninja_Three_QianNeng);
            }
            else if(param1 >= CONST_COMMON.Ninja_Two_QianNeng + 1 || _loc3_ == 2)
            {
               _loc2_ = TUtilityString.Format(STRING_NINJIAREINCARNATION.Reincarnation_Describe,2,param1 - CONST_COMMON.Ninja_Two_QianNeng);
            }
            else if(param1 >= CONST_COMMON.Ninja_One_QianNeng + 1 || _loc3_ == 1)
            {
               _loc2_ = TUtilityString.Format(STRING_NINJIAREINCARNATION.Reincarnation_Describe,1,param1 - CONST_COMMON.Ninja_One_QianNeng);
            }
            else
            {
               _loc2_ = "" + param1;
            }
         }
         return _loc2_;
      }
      
      public function GetQianNengOnlyLevelStrCao(param1:int) : String
      {
         var _loc2_:String = "";
         var _loc3_:int = 0;
         if(this.ReincarnationOneOrTwo == 1 && param1 == CONST_COMMON.Ninja_One_QianNeng)
         {
            param1 = CONST_COMMON.Ninja_One_QianNeng;
            _loc3_ = 1;
         }
         if(this.ReincarnationOneOrTwo == 2 && param1 == CONST_COMMON.Ninja_Two_QianNeng)
         {
            param1 = CONST_COMMON.Ninja_Two_QianNeng;
            _loc3_ = 2;
         }
         if(param1 >= CONST_COMMON.Ninja_Two_QianNeng + 1 || _loc3_ == 2)
         {
            _loc2_ = TUtilityString.Format(STRING_NINJIAREINCARNATION.Reincarnation_Describe,2,param1 - CONST_COMMON.Ninja_Two_QianNeng);
         }
         else if(param1 >= CONST_COMMON.Ninja_One_QianNeng + 1 || _loc3_ == 1)
         {
            _loc2_ = TUtilityString.Format(STRING_NINJIAREINCARNATION.Reincarnation_Describe,1,param1 - CONST_COMMON.Ninja_One_QianNeng);
         }
         else
         {
            _loc2_ = "" + param1;
         }
         return _loc2_;
      }
      
      public function get ReincarnationOneOrTwo() : uint
      {
         return this.FReincarnationOneOrTwo;
      }
      
      public function set ReincarnationOneOrTwo(param1:uint) : void
      {
         this.FReincarnationOneOrTwo = param1;
      }
      
      public function get ReincarnationId() : uint
      {
         return this.FReincarnationId;
      }
      
      public function set ReincarnationId(param1:uint) : void
      {
         this.FReincarnationId = param1;
      }
      
      public function set MachampId(param1:int) : void
      {
         this.FMachampId = param1;
      }
      
      public function get MachampId() : int
      {
         return this.FMachampId;
      }
      
      public function set TempMachampId(param1:int) : void
      {
         this.FTempMachampId = param1;
      }
      
      public function get TempMachampId() : int
      {
         return this.FTempMachampId;
      }
      
      public function get ReincarnationLevel() : uint
      {
         return this.FLevel;
      }
      
      public function get Experience() : UInt64
      {
         return this.FExperience;
      }
      
      public function set Experience(param1:UInt64) : void
      {
         this.FExperience = param1;
      }
      
      public function get Skills() : TSkills
      {
         return this.FSkills;
      }
      
      public function set Skills(param1:TSkills) : void
      {
         this.FSkills = param1;
      }
      
      public function get SkillsCopy() : TSkills
      {
         return this.FSkillsCopy;
      }
      
      public function set SkillsCopy(param1:TSkills) : void
      {
         this.FSkillsCopy = param1;
      }
      
      public function SetCopySkillsByIndex(param1:int, param2:int = 0) : void
      {
         var _loc3_:int = 0;
         var _loc4_:TSkill = null;
         var _loc5_:TSkill = null;
         var _loc6_:int = 0;
         this.FSkillsCopy.Clear();
         _loc3_ = 0;
         while(_loc3_ < this.FSkills.Count)
         {
            _loc4_ = this.FSkills.GetSkillByIndex(_loc3_);
            if(param1 == 0)
            {
               this.FSkillsCopy.Add(_loc4_);
            }
            else if(_loc4_.ScreeningVector[0] == param1 || _loc4_.Mounted)
            {
               this.FSkillsCopy.Add(_loc4_);
            }
            _loc3_++;
         }
         if(Boolean(param2) && Boolean(param1))
         {
            _loc3_ = 0;
            while(_loc3_ < this.FSkillsCopy.Count)
            {
               _loc4_ = this.FSkillsCopy.GetSkillByIndex(_loc3_);
               if(!_loc4_.Mounted)
               {
                  _loc6_ = 1;
                  while(_loc6_ < this.FSkillsCopy.Count)
                  {
                     if(_loc3_ != _loc6_)
                     {
                        _loc5_ = this.FSkillsCopy.GetSkillByIndex(_loc6_);
                        if(!_loc5_.Mounted)
                        {
                           if(_loc4_.ScreeningVector[1] == _loc5_.ScreeningVector[1])
                           {
                              if(_loc4_.ScreeningVector[2] > _loc5_.ScreeningVector[2])
                              {
                                 this.FSkillsCopy.Delelte(_loc5_);
                              }
                              else
                              {
                                 this.FSkillsCopy.Delelte(_loc4_);
                              }
                           }
                        }
                     }
                     _loc6_++;
                  }
               }
               _loc3_++;
            }
         }
      }
      
      public function get BaseAttributesCopy() : Vector.<Number>
      {
         return this.FBaseAttributesCopy;
      }
      
      public function GetBaseAttributeByIndex(param1:int) : Number
      {
         return this.FBaseAttributes[param1];
      }
      
      public function SetBaseAttributeByIndex(param1:int, param2:Number) : void
      {
         this.FBaseAttributes[param1] = param2;
      }
      
      public function get BaseAvoidInjury() : Number
      {
         return this.FBaseAttributes[BASEATTRIBUTEINDEX_AvoidInjury] as Number;
      }
      
      public function set BaseAvoidInjury(param1:Number) : void
      {
         this.FBaseAttributes[BASEATTRIBUTEINDEX_AvoidInjury] = param1;
      }
      
      public function get BaseBeginAnger() : Number
      {
         return this.FBaseAttributes[BASEATTRIBUTEINDEX_BeginAnger] as Number;
      }
      
      public function set BaseBeginAnger(param1:Number) : void
      {
         this.FBaseAttributes[BASEATTRIBUTEINDEX_BeginAnger] = param1;
      }
      
      public function get BaseAttributePower() : Number
      {
         return this.FBaseAttributes[BASEATTRIBUTEINDEX_Power] as Number;
      }
      
      public function set BaseAttributePower(param1:Number) : void
      {
         this.FBaseAttributes[BASEATTRIBUTEINDEX_Power] = param1;
      }
      
      public function get BaseAttributeAgile() : Number
      {
         return this.FBaseAttributes[BASEATTRIBUTEINDEX_Agile] as Number;
      }
      
      public function set BaseAttributeAgile(param1:Number) : void
      {
         this.FBaseAttributes[BASEATTRIBUTEINDEX_Agile] = param1;
      }
      
      public function get BaseAttributeIntelligence() : Number
      {
         return this.FBaseAttributes[BASEATTRIBUTEINDEX_Intelligence] as Number;
      }
      
      public function set BaseAttributeIntelligence(param1:Number) : void
      {
         this.FBaseAttributes[BASEATTRIBUTEINDEX_Intelligence] = param1;
      }
      
      public function get BaseAttributeLife() : Number
      {
         return this.FBaseAttributes[BASEATTRIBUTEINDEX_Life] as Number;
      }
      
      public function set BaseAttributeLife(param1:Number) : void
      {
         this.FBaseAttributes[BASEATTRIBUTEINDEX_Life] = param1;
      }
      
      public function get BaseAttributeSpeed() : Number
      {
         return this.FBaseAttributes[BASEATTRIBUTEINDEX_Speed] as Number;
      }
      
      public function set BaseAttributeSpeed(param1:Number) : void
      {
         this.FBaseAttributes[BASEATTRIBUTEINDEX_Speed] = param1;
      }
      
      public function get BaseAttributeHealth() : Number
      {
         return this.FBaseAttributes[BASEATTRIBUTEINDEX_Health] as Number;
      }
      
      public function set BaseAttributeHealth(param1:Number) : void
      {
         this.FBaseAttributes[BASEATTRIBUTEINDEX_Health] = param1;
      }
      
      public function get BaseAttributePhysicalAttack() : Number
      {
         return this.FBaseAttributes[BASEATTRIBUTEINDEX_PhysicalAttack] as Number;
      }
      
      public function set BaseAttributePhysicalAttack(param1:Number) : void
      {
         this.FBaseAttributes[BASEATTRIBUTEINDEX_PhysicalAttack] = param1;
      }
      
      public function get BaseAttributeMagicAttack() : Number
      {
         return this.FBaseAttributes[BASEATTRIBUTEINDEX_MagicAttack] as Number;
      }
      
      public function set BaseAttributeMagicAttack(param1:Number) : void
      {
         this.FBaseAttributes[BASEATTRIBUTEINDEX_MagicAttack] = param1;
      }
      
      public function get BaseAttributePhysicalDefends() : Number
      {
         return this.FBaseAttributes[BASEATTRIBUTEINDEX_PhysicalDefends] as Number;
      }
      
      public function set BaseAttributePhysicalDefends(param1:Number) : void
      {
         this.FBaseAttributes[BASEATTRIBUTEINDEX_PhysicalDefends] = param1;
      }
      
      public function get BaseAttributeMagicDefends() : Number
      {
         return this.FBaseAttributes[BASEATTRIBUTEINDEX_MagicDefends] as Number;
      }
      
      public function set BaseAttributeMagicDefends(param1:Number) : void
      {
         this.FBaseAttributes[BASEATTRIBUTEINDEX_MagicDefends] = param1;
      }
      
      public function get BaseAttributeHit() : Number
      {
         return this.FBaseAttributes[BASEATTRIBUTEINDEX_Hit] as Number;
      }
      
      public function set BaseAttributeHit(param1:Number) : void
      {
         this.FBaseAttributes[BASEATTRIBUTEINDEX_Hit] = param1;
      }
      
      public function get BaseAttributeDodge() : Number
      {
         return this.FBaseAttributes[BASEATTRIBUTEINDEX_Dodge] as Number;
      }
      
      public function set BaseAttributeDodge(param1:Number) : void
      {
         this.FBaseAttributes[BASEATTRIBUTEINDEX_Dodge] = param1;
      }
      
      public function get BaseAttributeCrit() : Number
      {
         return this.FBaseAttributes[BASEATTRIBUTEINDEX_Crit] as Number;
      }
      
      public function set BaseAttributeCrit(param1:Number) : void
      {
         this.FBaseAttributes[BASEATTRIBUTEINDEX_Crit] = param1;
      }
      
      public function get BaseAttributeGridFile() : Number
      {
         return this.FBaseAttributes[BASEATTRIBUTEINDEX_GridFile] as Number;
      }
      
      public function set BaseAttributeGridFile(param1:Number) : void
      {
         this.FBaseAttributes[BASEATTRIBUTEINDEX_GridFile] = param1;
      }
      
      public function get BaseAttributePunch() : Number
      {
         return this.FBaseAttributes[BASEATTRIBUTEINDEX_Punch] as Number;
      }
      
      public function set BaseAttributePunch(param1:Number) : void
      {
         this.FBaseAttributes[BASEATTRIBUTEINDEX_Punch] = param1;
      }
      
      public function get BaseAttributeHelp() : Number
      {
         return this.FBaseAttributes[BASEATTRIBUTEINDEX_Help] as Number;
      }
      
      public function set BaseAttributeHelp(param1:Number) : void
      {
         this.FBaseAttributes[BASEATTRIBUTEINDEX_Help] = param1;
      }
      
      public function get BaseAttributeWreck() : Number
      {
         return this.FBaseAttributes[BASEATTRIBUTEINDEX_Wreck] as Number;
      }
      
      public function set BaseAttributeWreck(param1:Number) : void
      {
         this.FBaseAttributes[BASEATTRIBUTEINDEX_Wreck] = param1;
      }
      
      public function get BaseAttributeUprising() : Number
      {
         return this.FBaseAttributes[BASEATTRIBUTEINDEX_Uprising] as Number;
      }
      
      public function set BaseAttributeUprising(param1:Number) : void
      {
         this.FBaseAttributes[BASEATTRIBUTEINDEX_Uprising] = param1;
      }
      
      public function get BaseAttributeHurt() : Number
      {
         return this.FBaseAttributes[BASEATTRIBUTEINDEX_Hurt] as Number;
      }
      
      public function set BaseAttributeHurt(param1:Number) : void
      {
         this.FBaseAttributes[BASEATTRIBUTEINDEX_Hurt] = param1;
      }
      
      public function get BaseAttributeFightingPower() : Number
      {
         return this.FBaseAttributes[BASEATTRIBUTEINDEX_FightingPower] as Number;
      }
      
      public function set BaseAttributeFightingPower(param1:Number) : void
      {
         this.FBaseAttributes[BASEATTRIBUTEINDEX_FightingPower] = param1;
      }
      
      public function get EquipmentsMounted() : TCollectionInventory
      {
         return this.FEquipmentsMounted;
      }
      
      public function get TalismansMounted() : TCollectionInventory
      {
         return this.FTalismansMounted;
      }
      
      public function get AccessoryMounted() : TCollectionInventory
      {
         return this.FAccessoryMounted;
      }
      
      public function get MedalsMounted() : TCollectionInventory
      {
         return this.FMedalsMounted;
      }
      
      public function get FightPosition() : int
      {
         return this.FFightPosition;
      }
      
      public function set FightPosition(param1:int) : void
      {
         this.FFightPosition = param1;
      }
      
      public function get Mounted() : Boolean
      {
         return this.FMounted;
      }
      
      public function set Mounted(param1:Boolean) : void
      {
         this.FMounted = param1;
      }
      
      public function get IsMain() : Boolean
      {
         return this.FIsMain;
      }
      
      public function set IsMain(param1:Boolean) : void
      {
         this.FIsMain = param1;
      }
      
      public function get Quality() : uint
      {
         if(this.FQuality >= 7)
         {
         }
         return this.FQuality;
      }
      
      public function set Quality(param1:uint) : void
      {
         this.FQuality = param1;
      }
      
      public function get IsNewEmployment() : Boolean
      {
         return this.FIsNewEmployment;
      }
      
      public function set IsNewEmployment(param1:Boolean) : void
      {
         this.FIsNewEmployment = param1;
      }
      
      public function GetFirstAttributeRateByIndex(param1:int) : Number
      {
         return this.FFirstAttributesRate[param1];
      }
      
      public function SetFirstAttributeRateByIndex(param1:int, param2:Number) : void
      {
         this.FFirstAttributesRate[param1] = param2;
      }
      
      public function get FirstAttributePowerRate() : Number
      {
         return this.FFirstAttributesRate[FIRSTATTRIBUTERATEINDEX_Power] as Number;
      }
      
      public function set FirstAttributePowerRate(param1:Number) : void
      {
         this.FFirstAttributesRate[FIRSTATTRIBUTERATEINDEX_Power] = param1;
      }
      
      public function get FirstAttributeIntelligenceRate() : Number
      {
         return this.FFirstAttributesRate[FIRSTATTRIBUTERATEINDEX_Intelligence] as Number;
      }
      
      public function set FirstAttributeIntelligenceRate(param1:Number) : void
      {
         this.FFirstAttributesRate[FIRSTATTRIBUTERATEINDEX_Intelligence] = param1;
      }
      
      public function get FirstAttributeAgileRate() : Number
      {
         return this.FFirstAttributesRate[FIRSTATTRIBUTERATEINDEX_Agile] as Number;
      }
      
      public function set FirstAttributeAgileRate(param1:Number) : void
      {
         this.FFirstAttributesRate[FIRSTATTRIBUTERATEINDEX_Agile] = param1;
      }
      
      public function get FirstAttributeHealthRate() : Number
      {
         return this.FFirstAttributesRate[FIRSTATTRIBUTERATEINDEX_Health] as Number;
      }
      
      public function set FirstAttributeHealthRate(param1:Number) : void
      {
         this.FFirstAttributesRate[FIRSTATTRIBUTERATEINDEX_Health] = param1;
      }
      
      public function GetFirstAttributeByIndex(param1:int) : Number
      {
         return this.FFirstAttributes[param1];
      }
      
      public function SetFirstAttributeByIndex(param1:int, param2:Number) : void
      {
         this.FFirstAttributes[param1] = param2;
      }
      
      public function get FirstAttributePower() : Number
      {
         return this.FFirstAttributes[FIRSTATTRIBUTERATEINDEX_Power] as Number;
      }
      
      public function set FirstAttributePower(param1:Number) : void
      {
         this.FFirstAttributes[FIRSTATTRIBUTERATEINDEX_Power] = param1;
      }
      
      public function get FirstAttributeIntelligence() : Number
      {
         return this.FFirstAttributes[FIRSTATTRIBUTERATEINDEX_Intelligence] as Number;
      }
      
      public function set FirstAttributeIntelligence(param1:Number) : void
      {
         this.FFirstAttributes[FIRSTATTRIBUTERATEINDEX_Intelligence] = param1;
      }
      
      public function get FirstAttributeAgile() : Number
      {
         return this.FFirstAttributes[FIRSTATTRIBUTERATEINDEX_Agile] as Number;
      }
      
      public function set FirstAttributeAgile(param1:Number) : void
      {
         this.FFirstAttributes[FIRSTATTRIBUTERATEINDEX_Agile] = param1;
      }
      
      public function get FirstAttributeHealth() : Number
      {
         return this.FFirstAttributes[FIRSTATTRIBUTERATEINDEX_Health] as Number;
      }
      
      public function set FirstAttributeHealth(param1:Number) : void
      {
         this.FFirstAttributes[FIRSTATTRIBUTERATEINDEX_Health] = param1;
      }
      
      public function get TalentName() : String
      {
         return this.FTalentName;
      }
      
      public function set TalentName(param1:String) : void
      {
         this.FTalentName = param1;
      }
      
      public function get TalentDesc() : String
      {
         return this.FTalentDesc;
      }
      
      public function set TalentDesc(param1:String) : void
      {
         this.FTalentDesc = param1;
      }
      
      public function get ModelID() : uint
      {
         return this.FModelID;
      }
      
      public function set ModelID(param1:uint) : void
      {
         this.FModelID = param1;
      }
      
      public function get LargeID() : uint
      {
         return this.FLargeID;
      }
      
      public function set LargeID(param1:uint) : void
      {
         this.FLargeID = param1;
      }
      
      public function get SmallID() : uint
      {
         return this.FSmallID;
      }
      
      public function set SmallID(param1:uint) : void
      {
         this.FSmallID = param1;
      }
      
      public function get NormalAttackName() : String
      {
         return this.FNormalAttackName;
      }
      
      public function set NormalAttackName(param1:String) : void
      {
         this.FNormalAttackName = param1;
      }
      
      public function get StandPositionWithProfession() : uint
      {
         var _loc1_:uint = 0;
         switch(this.FProfession)
         {
            case PROFESSION_Agility:
            case PROFESSION_Strength:
               _loc1_ = uint(INDEX_Station_Middle);
               break;
            case PROFESSION_Defending:
               _loc1_ = uint(INDEX_Station_Front);
               break;
            case PROFESSION_Intellect:
               _loc1_ = uint(INDEX_Station_After);
               if(this.FIsMain)
               {
                  _loc1_ = uint(INDEX_Station_Middle);
               }
         }
         return _loc1_;
      }
      
      public function get Assess() : String
      {
         return this.FAssess;
      }
      
      public function set Assess(param1:String) : void
      {
         this.FAssess = param1;
      }
      
      public function get NijiaStars() : TNijiaStars
      {
         return this.FNijiaStars;
      }
      
      public function set NijiaStars(param1:TNijiaStars) : void
      {
         this.FNijiaStars = param1;
      }
      
      public function get PotentialExp() : uint
      {
         return this.FPotentialExp;
      }
      
      public function set PotentialExp(param1:uint) : void
      {
         this.FPotentialExp = param1;
      }
      
      public function set PotentialIncrement(param1:int) : void
      {
         this.FPotentialIncrement = param1;
      }
      
      public function get PotentialIncrement() : int
      {
         if(this.ReincarnationOneOrTwo)
         {
            this.FPotentialIncrement = POTENTIALINCREMENT_reincarnation_after;
         }
         else
         {
            this.FPotentialIncrement = POTENTIALINCREMENT_reincarnation_before;
         }
         return this.FPotentialIncrement;
      }
      
      public function get PotentialLv() : uint
      {
         return this.FPotentialLv;
      }
      
      public function set PotentialLv(param1:uint) : void
      {
         this.FPotentialLv = param1;
         this.FPotentialLevelShow = param1;
      }
      
      public function get PotentialLevelShow() : uint
      {
         return this.FPotentialLevelShow;
      }
      
      public function get ExpIsInherited() : uint
      {
         return this.FExpIsInherited;
      }
      
      public function set ExpIsInherited(param1:uint) : void
      {
         this.FExpIsInherited = param1;
      }
      
      public function get Reousrce() : String
      {
         return this.FReousrce;
      }
      
      public function set Identifier(param1:uint) : void
      {
         FIdentifier = param1;
      }
      
      public function set Reousrce(param1:String) : void
      {
         this.FReousrce = param1;
      }
      
      public function get RecruitStatus() : Boolean
      {
         return this.FRecruitStatus;
      }
      
      public function set RecruitStatus(param1:Boolean) : void
      {
         this.FRecruitStatus = param1;
      }
      
      public function get IsSkillInherit() : Boolean
      {
         return this.FIsSkillInherit;
      }
      
      public function set IsSkillInherit(param1:Boolean) : void
      {
         this.FIsSkillInherit = param1;
      }
      
      public function get IsSkillInherited() : Boolean
      {
         return this.FIsSkillInherited;
      }
      
      public function set IsSkillInherited(param1:Boolean) : void
      {
         this.FIsSkillInherited = param1;
      }
      
      public function set AwakenSpecialSkillId(param1:uint) : void
      {
         this.FAwakenSpecialSkillId = param1;
      }
      
      public function get AwakenSpecialSkillId() : uint
      {
         return this.FAwakenSpecialSkillId;
      }
      
      public function set AwakenCommonSkillId(param1:uint) : void
      {
         this.FAwakenCommonSkillId = param1;
      }
      
      public function get AwakenCommonSkillId() : uint
      {
         return this.FAwakenCommonSkillId;
      }
      
      public function get IsRecommand() : Boolean
      {
         return this.FIsRecommand;
      }
      
      public function set IsRecommand(param1:Boolean) : void
      {
         this.FIsRecommand = param1;
      }
      
      public function get IsInHostel() : Boolean
      {
         return this.FIsInHostel;
      }
      
      public function set IsInHostel(param1:Boolean) : void
      {
         this.FIsInHostel = param1;
      }
      
      public function get AwakeLevel() : uint
      {
         return this.FAwakeLevel;
      }
      
      public function set AwakeLevel(param1:uint) : void
      {
         this.FAwakeLevel = param1;
      }
      
      public function get AwakeSkil() : uint
      {
         return this.FAwakeSkil;
      }
      
      public function set AwakeSkil(param1:uint) : void
      {
         this.FAwakeSkil = param1;
      }
      
      public function Reset() : void
      {
         var _loc1_:int = 0;
         this.FName = "";
         this.FProfession = 0;
         this.FLevel = 0;
         this.FExperience.High = 0;
         this.FExperience.Low = 0;
         this.FSkills.Clear();
         _loc1_ = 0;
         while(_loc1_ < CAPACITY_BaseAttributes)
         {
            this.FBaseAttributes[_loc1_] = 0;
            _loc1_++;
         }
         this.FEquipmentsMounted.Clear();
         this.FTalismansMounted.Clear();
         this.FMedalsMounted.Clear();
         this.FFightPosition = -1;
         this.FMounted = false;
         this.FIsMain = false;
         this.FQuality = 0;
         this.FIsNewEmployment = false;
         this.FTalentName = "";
         this.FTalentDesc = "";
         this.FNormalAttackName = "";
         this.FModelID = 0;
         this.FLargeID = 0;
         this.FSmallID = 0;
      }
      
      public function DeleteBloodFete(param1:uint, param2:uint) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         while(_loc4_ < this.FBloodFeteMounted.length)
         {
            if(this.FBloodFeteMounted[_loc4_].IdentifierUInt64.High == param1 && this.FBloodFeteMounted[_loc4_].IdentifierUInt64.Low == param2)
            {
               _loc3_ = _loc4_;
               break;
            }
            _loc4_++;
         }
         this.FBloodFeteMounted.splice(_loc3_,1);
      }
      
      public function AddBloodFete(param1:TBloodFeteSingle) : void
      {
         if(!this.GetBloodFeteById64(param1.IdentifierUInt64.High,param1.IdentifierUInt64.Low))
         {
            this.FBloodFeteMounted.push(param1);
            this.SetValue(param1);
         }
      }
      
      public function DeleteTabooById(param1:uint) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         while(_loc3_ < this.FTabooMounted.length)
         {
            if(this.FTabooMounted[_loc3_].ConfigureAddition.Identifier == param1)
            {
               _loc2_ = _loc3_;
               if(this.FTabooMounted[_loc3_].Count > 0)
               {
                  this.FTabooMounted[_loc3_].Count--;
                  return;
               }
               break;
            }
            _loc3_++;
         }
         this.FTabooMounted.splice(_loc2_,1);
      }
      
      public function AddTaboo(param1:TabooDataCell) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < this.FTabooMounted.length)
         {
            if(this.FTabooMounted[_loc2_].ConfigureAddition.Identifier == param1.ConfigureConfig.Identifier)
            {
               this.FTabooMounted[_loc2_].SkillCount++;
               return;
            }
            _loc2_++;
         }
         this.FTabooMounted.push(param1);
      }
      
      public function AddTabooCopy(param1:TabooDataCell) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < this.FTabooMounted.length)
         {
            if(this.FTabooMounted[_loc2_].ConfigureAddition.Identifier == param1.ConfigureConfig.Identifier)
            {
               if(param1.SkillCount == 0)
               {
                  this.FTabooMounted.splice(_loc2_,1);
               }
               else
               {
                  this.FTabooMounted[_loc2_].SkillCount = param1.SkillCount;
               }
               return;
            }
            _loc2_++;
         }
         this.FTabooMounted.push(param1);
      }
      
      protected function SetValue(param1:TBloodFeteSingle) : void
      {
         var _loc2_:TFollowBloodBound = null;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_FollowBloodBound,param1.Identifier) as TFollowBloodBound;
         param1.Type = _loc2_.Type;
         param1.EffectId = _loc2_.IconID;
         param1.Name = _loc2_.Name;
         param1.Quality = _loc2_.Quality;
         param1.Price = _loc2_.Price;
         param1.AddAttrArr = _loc2_.AddAttrArr;
         param1.NeedExp = _loc2_.NeedExp;
         param1.AllExp = _loc2_.ExpAll;
         param1.Levelcount = _loc2_.Levelcount;
         param1.DevourExp = _loc2_.DevourExp;
         param1.NextLevelID = _loc2_.NextLevelID;
      }
      
      public function GetBloodFeteById64(param1:uint, param2:uint) : TBloodFeteSingle
      {
         var _loc3_:TBloodFeteSingle = null;
         var _loc4_:int = 0;
         while(_loc4_ < this.FBloodFeteMounted.length)
         {
            if(this.FBloodFeteMounted[_loc4_].IdentifierUInt64.High == param1 && this.FBloodFeteMounted[_loc4_].IdentifierUInt64.Low == param2)
            {
               _loc3_ = this.FBloodFeteMounted[_loc4_];
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      public function GetSuitCountByEquipment(param1:TEquipment) : uint
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:TEquipment = null;
         var _loc6_:TCollectionInventory = null;
         if(param1.Category == CATEGORY_Accessories)
         {
            _loc3_ = int(CAPACITY_AccessoryMounted);
            _loc6_ = this.FAccessoryMounted;
         }
         else
         {
            _loc3_ = int(CAPACITY_EquipmentsMounted);
            _loc6_ = this.FEquipmentsMounted;
         }
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc5_ = _loc6_.GetInventoryByIndex(_loc2_) as TEquipment;
            if(_loc5_ != null)
            {
               if(param1.SuitID == _loc5_.SuitID)
               {
                  _loc4_++;
               }
            }
            _loc2_++;
         }
         return _loc4_;
      }
      
      public function GetSuitCountByEpicEquipment(param1:TEquipment) : Object
      {
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc2_:Object = {};
         var _loc3_:Array = [9,8,7,6,5,4,3,2,1,0];
         var _loc4_:int = 3;
         var _loc5_:Object = this.GroupEpicEquipmentCountByLevel(param1);
         _loc6_ = 0;
         while(_loc6_ < _loc4_)
         {
            _loc7_ = (_loc6_ + 1) * 2;
            _loc8_ = 0;
            for each(var _loc12_ in _loc3_)
            {
               _loc9_ = _loc12_;
               _loc12_;
               _loc8_ = _loc8_ + _loc5_[_loc9_];
               if(_loc8_ >= _loc7_)
               {
                  _loc2_[_loc7_] = _loc9_;
                  break;
               }
            }
            _loc6_++;
         }
         return _loc2_;
      }
      
      public function GetEightsuitCountByEpicAccessory(param1:TEquipment) : Object
      {
         var _loc7_:int = 0;
         var _loc2_:Object = {};
         var _loc3_:Array = [9,8,7,6,5,4,3,2,1,0];
         var _loc4_:Object = this.GroupEpicEquipmentCountByLevel(param1,true);
         var _loc5_:int = 8;
         var _loc6_:int = 0;
         for each(var _loc10_ in _loc3_)
         {
            _loc7_ = _loc10_;
            _loc10_;
            _loc6_ = _loc6_ + _loc4_[_loc7_];
            if(_loc6_ >= _loc5_)
            {
               _loc2_[_loc5_] = _loc7_;
               break;
            }
         }
         return _loc2_;
      }
      
      public function GroupEpicEquipmentCountByLevel(param1:TEquipment, param2:Boolean = false) : Object
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:uint = 0;
         var _loc7_:TEquipment = null;
         var _loc8_:TCollectionInventory = null;
         var _loc9_:TBaseEquip = null;
         var _loc10_:TBaseEquip = null;
         var _loc11_:TEquipUpgrade = null;
         var _loc12_:* = 0;
         var _loc14_:int = 0;
         var _loc3_:Object = {};
         if(param1.Category == CATEGORY_Accessories)
         {
            _loc5_ = int(CAPACITY_AccessoryMounted);
            _loc8_ = this.FAccessoryMounted;
         }
         else
         {
            _loc5_ = int(CAPACITY_EquipmentsMounted);
            _loc8_ = this.FEquipmentsMounted;
         }
         var _loc13_:Array = [9,8,7,6,5,4,3,2,1,0];
         _loc10_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BaseEquip,param1.IDTemplate) as TBaseEquip;
         for each(var _loc17_ in _loc13_)
         {
            _loc14_ = _loc17_;
            _loc17_;
            _loc4_ = 0;
            for(; _loc4_ < _loc5_; _loc4_++)
            {
               _loc7_ = _loc8_.GetInventoryByIndex(_loc4_) as TEquipment;
               if(_loc7_ != null)
               {
                  _loc9_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BaseEquip,_loc7_.IDTemplate) as TBaseEquip;
                  _loc11_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_EquipUpgrade,_loc7_.IDTemplate) as TEquipUpgrade;
                  if(param2 == false)
                  {
                     if(Boolean(_loc9_) && Boolean(_loc9_.SuitIdArr.length == 1) && (Boolean(_loc11_) && Boolean(_loc11_.IsEpic == 2)) || Boolean(_loc9_) && Boolean(_loc9_.SuitIdArr.length > 1))
                     {
                        if(_loc10_.SuitIdArr[0] != _loc9_.SuitIdArr[0])
                        {
                           continue;
                        }
                        if(_loc14_ == _loc9_.SuitIdArr.length - 1)
                        {
                           _loc12_++;
                        }
                     }
                  }
                  else if(_loc10_.EightsuitIdArr[0] == _loc9_.EightsuitIdArr[0])
                  {
                     if(_loc14_ == _loc9_.EightsuitIdArr.length - 1)
                     {
                        _loc12_++;
                     }
                  }
               }
            }
            _loc3_[_loc14_] = _loc12_;
            _loc12_ = 0;
         }
         return _loc3_;
      }
      
      public function SetSuitCount(param1:TEquipment, param2:uint) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:TEquipment = null;
         var _loc6_:TCollectionInventory = null;
         var _loc8_:TEquipment = null;
         var _loc9_:int = 0;
         var _loc7_:int = 0;
         if(param1.Category == CATEGORY_Accessories)
         {
            _loc4_ = int(CAPACITY_AccessoryMounted);
            _loc6_ = this.FAccessoryMounted;
            _loc7_ = 1;
         }
         else
         {
            _loc4_ = int(CAPACITY_EquipmentsMounted);
            _loc6_ = this.FEquipmentsMounted;
         }
         param1.SuitMemberId.length = 0;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc5_ = _loc6_.GetInventoryByIndex(_loc3_) as TEquipment;
            if(_loc5_ != null)
            {
               if(param1.SuitID == _loc5_.SuitID)
               {
                  _loc5_.SuitCount = param2;
                  if(_loc7_)
                  {
                     _loc8_ = _loc6_.GetInventoryByIdentifier(param1.Identifier0,param1.Identifier1) as TEquipment;
                     if(_loc8_)
                     {
                        if(param1.SuitMemberId.indexOf(_loc5_.IDTemplate) < 0)
                        {
                           param1.SuitMemberId.push(_loc5_.IDTemplate);
                        }
                        if(_loc5_.SuitMemberId.indexOf(param1.IDTemplate) < 0)
                        {
                           _loc5_.SuitMemberId.push(param1.IDTemplate);
                        }
                     }
                     else
                     {
                        _loc9_ = _loc5_.SuitMemberId.indexOf(param1.IDTemplate);
                        if(_loc9_ >= 0)
                        {
                           _loc5_.SuitMemberId.splice(_loc9_,1);
                        }
                     }
                  }
               }
            }
            _loc3_++;
         }
      }
      
      public function SetSuitObject(param1:TEquipment, param2:Object) : void
      {
         param1.SuitObject = param2;
      }
      
      public function SkillActivedByID(param1:int) : TSkill
      {
         var _loc2_:int = 0;
         var _loc3_:TSkill = null;
         _loc2_ = 0;
         while(_loc2_ < this.FSkills.Count)
         {
            _loc3_ = this.FSkills.GetSkillByIndex(_loc2_);
            if(_loc3_.Identifier == param1)
            {
               return _loc3_;
            }
            _loc2_++;
         }
         return null;
      }
   }
}

