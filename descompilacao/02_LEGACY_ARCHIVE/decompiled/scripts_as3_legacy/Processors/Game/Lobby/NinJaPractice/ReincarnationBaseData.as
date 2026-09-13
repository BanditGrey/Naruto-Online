package Processors.Game.Lobby.NinJaPractice
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Utilities.TUtilityString;
   import Logics.Characters.THero;
   import Logics.DatebaseVO.VO.TBaseHero;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.DatebaseVO.VO.TSkillConfig;
   import Logics.DatebaseVO.VO.TTransmigrationTalent;
   import Logics.SLogicsCore;
   import Resources.Constants.CONST_CONFIGVALUE;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_NINJIAREINCARNATION;
   
   public class ReincarnationBaseData
   {
      
      public static const Count:int = 4;
      
      protected var FReincarnatonCount:int;
      
      protected var FLevelNeedOne:int;
      
      protected var FQianNengLevelNeedOne:int;
      
      protected var FStuffNeedOne:int;
      
      protected var FLevelNeedTwo:int;
      
      protected var FQianNengLevelNeedTwo:int;
      
      protected var FStuffNeedTwo:int;
      
      protected var FLevelNeedThree:int;
      
      protected var FQianNengLevelNeedThree:int;
      
      protected var FStuffNeedThree:int;
      
      protected var FNinjaId:int;
      
      protected var FNinjaLevel:int;
      
      protected var FNinjaReincarnationLevelOne:int;
      
      protected var FNinjaReincarnationLevelTwo:int;
      
      protected var FReinCarnationNeedStuffId:int = 14107121;
      
      protected var FReinCarnationNeedStuffIdThree:int = 14107165;
      
      protected var FNinjaVariousGrowthRate:Vector.<Number>;
      
      protected var FNinjaAfterGrowthRate:Vector.<Number>;
      
      protected var FSkillName:String = "";
      
      protected var FSkillOpenLevel:String = "";
      
      protected var FSkillDescribe:String = "";
      
      protected var FSkillDesReincarnation:String = "";
      
      protected var FAwakeDescReincarnation:String;
      
      protected var FMachampId:int;
      
      protected var FMachampName:String;
      
      protected var FMachampDescribe:String;
      
      protected var FMachampMaxLevel:int;
      
      protected var FCurMachampLevel:int;
      
      protected var FBaseHeros:TBins;
      
      protected var FSkillConfig:TBins;
      
      protected var FTransmigrationTalent:TBins;
      
      protected var FNinjaReincarnatonSkillKey:Vector.<Object>;
      
      protected var FReincarnationGetSkill:Array;
      
      public function ReincarnationBaseData()
      {
         super();
         this.FReincarnationGetSkill = new Array();
         this.FReincarnationGetSkill.length = 0;
      }
      
      public function Inilization() : void
      {
         this.FNinjaVariousGrowthRate = new Vector.<Number>();
         this.FNinjaAfterGrowthRate = new Vector.<Number>();
         this.FBaseHeros = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_BaseHero);
         this.FSkillConfig = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_SkillConfig);
         this.FTransmigrationTalent = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_TransmigrationTalent);
      }
      
      protected function GetNextSkillId(param1:THero, param2:TBaseHero) : uint
      {
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:TConfigValue = null;
         var _loc6_:Vector.<Object> = null;
         var _loc7_:Object = null;
         var _loc8_:uint = 0;
         if(this.FNinjaReincarnatonSkillKey == null)
         {
            _loc5_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.NinjaReincarnaton_SkillKey) as TConfigValue;
            this.FNinjaReincarnatonSkillKey = _loc5_.Value as Vector.<Object>;
         }
         _loc5_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE["NinjaReincarnaton_Skill_" + param2.Profession]) as TConfigValue;
         _loc6_ = _loc5_.Value as Vector.<Object>;
         _loc4_ = _loc6_.length;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc7_ = _loc6_[_loc3_];
            _loc8_ = uint(_loc7_[this.FNinjaReincarnatonSkillKey[1]]);
            if(_loc8_ > param1.Level)
            {
               break;
            }
            _loc3_++;
         }
         this.FSkillOpenLevel = TUtilityString.Format(STRING_NINJIAREINCARNATION.STRING_SkillOpenLevel,STRING_COMMON.GetLevelStrByLevelLineFeed(_loc8_));
         return _loc7_[this.FNinjaReincarnatonSkillKey[0]];
      }
      
      public function set NinjaId(param1:uint) : void
      {
         var _loc5_:THero = null;
         var _loc6_:uint = 0;
         var _loc2_:TBaseHero = null;
         var _loc3_:TBaseHero = null;
         var _loc4_:TSkillConfig = null;
         this.FNinjaVariousGrowthRate.length = 0;
         this.FNinjaAfterGrowthRate.length = 0;
         this.FSkillOpenLevel = "";
         this.FNinjaId = param1;
         _loc2_ = this.FBaseHeros.GetDatebaseByIdentifier(param1) as TBaseHero;
         _loc5_ = SLogicsCore.Character.Heros.GetHeroByIdentifier(param1);
         if(_loc2_ == null)
         {
            return;
         }
         this.FNinjaVariousGrowthRate.push(Number(_loc2_.IsMain ? _loc5_.FirstAttributePowerRate : _loc2_.PowerGrow).toFixed(1));
         this.FNinjaVariousGrowthRate.push(Number(_loc2_.IsMain ? _loc5_.FirstAttributeIntelligenceRate : _loc2_.IntelligenceGrow).toFixed(1));
         this.FNinjaVariousGrowthRate.push(Number(_loc2_.IsMain ? _loc5_.FirstAttributeAgileRate : _loc2_.AgileGrow).toFixed(1));
         this.FNinjaVariousGrowthRate.push(Number(_loc2_.IsMain ? _loc5_.FirstAttributeHealthRate : _loc2_.LifeGrow).toFixed(1));
         if(_loc2_.IsMain)
         {
            _loc6_ = this.GetNextSkillId(_loc5_,_loc2_);
         }
         else
         {
            _loc6_ = uint(_loc2_.SkPreview);
         }
         _loc4_ = this.FSkillConfig.GetDatebaseByIdentifier(_loc6_) as TSkillConfig;
         this.FSkillName = _loc4_.Name;
         this.FSkillDescribe = _loc4_.Desc;
         this.FSkillDesReincarnation = _loc4_.DescReincarnation;
         this.FAwakeDescReincarnation = _loc4_.AwakedescRe;
         if(_loc2_.TransId != 0)
         {
            _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BaseHero,_loc2_.TransId) as TBaseHero;
            if(_loc3_ == null)
            {
               return;
            }
            this.FNinjaAfterGrowthRate.push(Number(_loc3_.IsMain ? _loc5_.FirstAttributePowerRate + _loc3_.PowerGrow - _loc2_.PowerGrow : _loc3_.PowerGrow).toFixed(1));
            this.FNinjaAfterGrowthRate.push(Number(_loc3_.IsMain ? _loc5_.FirstAttributeIntelligenceRate + _loc3_.IntelligenceGrow - _loc2_.IntelligenceGrow : _loc3_.IntelligenceGrow).toFixed(1));
            this.FNinjaAfterGrowthRate.push(Number(_loc3_.IsMain ? _loc5_.FirstAttributeAgileRate + _loc3_.AgileGrow - _loc2_.AgileGrow : _loc3_.AgileGrow).toFixed(1));
            this.FNinjaAfterGrowthRate.push(Number(_loc3_.IsMain ? _loc5_.FirstAttributeHealthRate + _loc3_.LifeGrow - _loc2_.LifeGrow : _loc3_.LifeGrow).toFixed(1));
         }
      }
      
      public function get NinjaVariousGrowthRate() : Vector.<Number>
      {
         return this.FNinjaVariousGrowthRate;
      }
      
      public function get NinjaAfterGrowthRate() : Vector.<Number>
      {
         return this.FNinjaAfterGrowthRate;
      }
      
      public function get SkillName() : String
      {
         return this.FSkillName;
      }
      
      public function get SkillOpenLevel() : String
      {
         return this.FSkillOpenLevel;
      }
      
      public function get SkillDescribe() : String
      {
         return this.FSkillDescribe;
      }
      
      public function get SkillDesReincarnation() : String
      {
         return this.FSkillDesReincarnation;
      }
      
      public function set ReinCarnationNeedStuffId(param1:int) : void
      {
         this.FReinCarnationNeedStuffId = param1;
      }
      
      public function get ReinCarnationNeedStuffId() : int
      {
         return this.FReinCarnationNeedStuffId;
      }
      
      public function get AwakeDescReincarnation() : String
      {
         return this.FAwakeDescReincarnation;
      }
      
      public function set MachampId(param1:int) : void
      {
         var _loc2_:TTransmigrationTalent = null;
         this.FMachampId = param1;
         _loc2_ = this.FTransmigrationTalent.GetDatebaseByIdentifier(this.FMachampId) as TTransmigrationTalent;
         if(_loc2_ == null)
         {
            this.FMachampName = STRING_NINJIAREINCARNATION.Reincarnation_NO_MachampName;
            this.FMachampDescribe = STRING_NINJIAREINCARNATION.Reincarnation_NO_MachampDescribe;
            this.FMachampMaxLevel = 0;
            this.FCurMachampLevel = 777;
         }
         else
         {
            this.FMachampName = _loc2_.Name;
            this.FMachampDescribe = _loc2_.Desc;
            this.FMachampMaxLevel = _loc2_.MaxLevel;
            this.FCurMachampLevel = _loc2_.CurLevel;
         }
      }
      
      public function get MachampId() : int
      {
         return this.FMachampId;
      }
      
      public function set MachampName(param1:String) : void
      {
         this.FMachampName = param1;
      }
      
      public function get MachampName() : String
      {
         return this.FMachampName;
      }
      
      public function set MachampDescribe(param1:String) : void
      {
         this.FMachampDescribe = param1;
      }
      
      public function get MachampDescribe() : String
      {
         return this.FMachampDescribe;
      }
      
      public function set MachampMaxLevel(param1:int) : void
      {
         this.FMachampMaxLevel = param1;
      }
      
      public function get MachampMaxLevel() : int
      {
         return this.FMachampMaxLevel;
      }
      
      public function set CurMachampLevel(param1:int) : void
      {
         this.FCurMachampLevel = param1;
      }
      
      public function get CurMachampLevel() : int
      {
         return this.FCurMachampLevel;
      }
      
      public function set ReincarnatonCount(param1:int) : void
      {
         this.FReincarnatonCount = param1;
      }
      
      public function get ReincarnatonCount() : int
      {
         return this.FReincarnatonCount;
      }
      
      public function set LevelNeedOne(param1:int) : void
      {
         this.FLevelNeedOne = param1;
      }
      
      public function get LevelNeedOne() : int
      {
         return this.FLevelNeedOne;
      }
      
      public function set QianNengLevelNeedOne(param1:int) : void
      {
         this.FQianNengLevelNeedOne = param1;
      }
      
      public function get QianNengLevelNeedOne() : int
      {
         return this.FQianNengLevelNeedOne;
      }
      
      public function set StuffNeedOne(param1:int) : void
      {
         this.FStuffNeedOne = param1;
      }
      
      public function get StuffNeedOne() : int
      {
         return this.FStuffNeedOne;
      }
      
      public function set LevelNeedTwo(param1:int) : void
      {
         this.FLevelNeedTwo = param1;
      }
      
      public function get LevelNeedTwo() : int
      {
         return this.FLevelNeedTwo;
      }
      
      public function set QianNengLevelNeedTwo(param1:int) : void
      {
         this.FQianNengLevelNeedTwo = param1;
      }
      
      public function get QianNengLevelNeedTwo() : int
      {
         return this.FQianNengLevelNeedTwo;
      }
      
      public function set StuffNeedTwo(param1:int) : void
      {
         this.FStuffNeedTwo = param1;
      }
      
      public function get StuffNeedTwo() : int
      {
         return this.FStuffNeedTwo;
      }
      
      public function get ReincarnationGetSkill() : Array
      {
         return this.FReincarnationGetSkill;
      }
      
      public function get LevelNeedThree() : int
      {
         return this.FLevelNeedThree;
      }
      
      public function set LevelNeedThree(param1:int) : void
      {
         this.FLevelNeedThree = param1;
      }
      
      public function get QianNengLevelNeedThree() : int
      {
         return this.FQianNengLevelNeedThree;
      }
      
      public function set QianNengLevelNeedThree(param1:int) : void
      {
         this.FQianNengLevelNeedThree = param1;
      }
      
      public function get StuffNeedThree() : int
      {
         return this.FStuffNeedThree;
      }
      
      public function set StuffNeedThree(param1:int) : void
      {
         this.FStuffNeedThree = param1;
      }
      
      public function get ReinCarnationNeedStuffIdThree() : int
      {
         return this.FReinCarnationNeedStuffIdThree;
      }
      
      public function set ReinCarnationNeedStuffIdThree(param1:int) : void
      {
         this.FReinCarnationNeedStuffIdThree = param1;
      }
   }
}

