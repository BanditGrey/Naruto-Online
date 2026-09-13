package Logics.Generals
{
   import Foundation.Common.Stubs.TStubReferences;
   import Logics.Characters.THero;
   
   public class TGeneral extends THero
   {
      
      protected var FID:int;
      
      protected var FGeneralID:int;
      
      protected var FPower:int;
      
      protected var FAgile:int;
      
      protected var FIntelligence:int;
      
      protected var FSpeed:int;
      
      protected var FHealth:int;
      
      protected var FPowerRate:Number;
      
      protected var FAgileRate:Number;
      
      protected var FIntelligenceRate:Number;
      
      protected var FHealthRate:Number;
      
      protected var FProfessionName:String;
      
      protected var FSkillID:int;
      
      protected var FSkillName:String;
      
      protected var FSkillDesc:String;
      
      protected var FTalentID:int;
      
      protected var FNornalSkillID:int;
      
      protected var FNornalSkillName:String;
      
      protected var FLocation:int;
      
      protected var FNeedSoul:int;
      
      protected var FRecruited:Boolean;
      
      protected var FAwardsoulType:int;
      
      protected var FAwardsoulValue:int;
      
      protected var FDesc:String;
      
      protected var FWeakness:String;
      
      protected var FRoleHead:uint;
      
      protected var FRoleStyle:uint;
      
      protected var FModel:uint;
      
      protected var FPreView:uint;
      
      public function TGeneral()
      {
         super(Identifier);
         FStubReferences = new TStubReferences(this);
      }
      
      public function get ID() : int
      {
         return this.FID;
      }
      
      public function set ID(param1:int) : void
      {
         this.FID = param1;
      }
      
      public function get Power() : int
      {
         return this.FPower;
      }
      
      public function set Power(param1:int) : void
      {
         this.FPower = param1;
      }
      
      public function get Agile() : int
      {
         return this.FAgile;
      }
      
      public function set Agile(param1:int) : void
      {
         this.FAgile = param1;
      }
      
      public function get Intelligence() : int
      {
         return this.FIntelligence;
      }
      
      public function set Intelligence(param1:int) : void
      {
         this.FIntelligence = param1;
      }
      
      public function get Speed() : int
      {
         return this.FSpeed;
      }
      
      public function set Speed(param1:int) : void
      {
         this.FSpeed = param1;
      }
      
      public function get Health() : int
      {
         return this.FHealth;
      }
      
      public function set Health(param1:int) : void
      {
         this.FHealth = param1;
      }
      
      public function get ProfessionName() : String
      {
         return this.FProfessionName;
      }
      
      public function set ProfessionName(param1:String) : void
      {
         this.FProfessionName = param1;
      }
      
      public function get SkillID() : int
      {
         return this.FSkillID;
      }
      
      public function set SkillID(param1:int) : void
      {
         this.FSkillID = param1;
      }
      
      public function get SkillName() : String
      {
         return this.FSkillName;
      }
      
      public function set SkillName(param1:String) : void
      {
         this.FSkillName = param1;
      }
      
      public function get TalentID() : int
      {
         return this.FTalentID;
      }
      
      public function set TalentID(param1:int) : void
      {
         this.FTalentID = param1;
      }
      
      public function get NornalSkillID() : int
      {
         return this.FNornalSkillID;
      }
      
      public function set NornalSkillID(param1:int) : void
      {
         this.FNornalSkillID = param1;
      }
      
      public function get NornalSkillName() : String
      {
         return this.FNornalSkillName;
      }
      
      public function set NornalSkillName(param1:String) : void
      {
         this.FNornalSkillName = param1;
      }
      
      public function get Location() : int
      {
         return this.FLocation;
      }
      
      public function set Location(param1:int) : void
      {
         this.FLocation = param1;
      }
      
      public function get NeedSoul() : int
      {
         return this.FNeedSoul;
      }
      
      public function set NeedSoul(param1:int) : void
      {
         this.FNeedSoul = param1;
      }
      
      public function get Recruited() : Boolean
      {
         return this.FRecruited;
      }
      
      public function set Recruited(param1:Boolean) : void
      {
         this.FRecruited = param1;
      }
      
      public function get GeneralID() : int
      {
         return this.FGeneralID;
      }
      
      public function set GeneralID(param1:int) : void
      {
         this.FGeneralID = param1;
      }
      
      public function get AwardsoulType() : int
      {
         return this.FAwardsoulType;
      }
      
      public function set AwardsoulType(param1:int) : void
      {
         this.FAwardsoulType = param1;
      }
      
      public function get AwardsoulValue() : int
      {
         return this.FAwardsoulValue;
      }
      
      public function set AwardsoulValue(param1:int) : void
      {
         this.FAwardsoulValue = param1;
      }
      
      public function get SkillDesc() : String
      {
         return this.FSkillDesc;
      }
      
      public function set SkillDesc(param1:String) : void
      {
         this.FSkillDesc = param1;
      }
      
      public function get Desc() : String
      {
         return this.FDesc;
      }
      
      public function set Desc(param1:String) : void
      {
         this.FDesc = param1;
      }
      
      public function get PowerRate() : Number
      {
         return this.FPowerRate;
      }
      
      public function set PowerRate(param1:Number) : void
      {
         this.FPowerRate = param1;
      }
      
      public function get AgileRate() : Number
      {
         return this.FAgileRate;
      }
      
      public function set AgileRate(param1:Number) : void
      {
         this.FAgileRate = param1;
      }
      
      public function get IntelligenceRate() : Number
      {
         return this.FIntelligenceRate;
      }
      
      public function set IntelligenceRate(param1:Number) : void
      {
         this.FIntelligenceRate = param1;
      }
      
      public function get HealthRate() : Number
      {
         return this.FHealthRate;
      }
      
      public function set HealthRate(param1:Number) : void
      {
         this.FHealthRate = param1;
      }
      
      public function get Weakness() : String
      {
         return this.FWeakness;
      }
      
      public function set Weakness(param1:String) : void
      {
         this.FWeakness = param1;
      }
      
      public function get RoleHead() : uint
      {
         return this.FRoleHead;
      }
      
      public function set RoleHead(param1:uint) : void
      {
         this.FRoleHead = param1;
      }
      
      public function get RoleStyle() : uint
      {
         return this.FRoleStyle;
      }
      
      public function set RoleStyle(param1:uint) : void
      {
         this.FRoleStyle = param1;
      }
      
      public function get Model() : uint
      {
         return this.FModel;
      }
      
      public function set Model(param1:uint) : void
      {
         this.FModel = param1;
      }
      
      public function get PreView() : uint
      {
         return this.FPreView;
      }
      
      public function set PreView(param1:uint) : void
      {
         this.FPreView = param1;
      }
   }
}

