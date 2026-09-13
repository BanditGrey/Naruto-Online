package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.*;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.*;
   import flash.utils.*;
   
   use namespace ResourcesSpace;
   
   public class TBaseHero extends TDatebaseVO
   {
      
      protected var FTransId:int;
      
      protected var FTransState:int;
      
      protected var FIsMain:Boolean;
      
      protected var FOrigionId:int;
      
      protected var FSkPreview:int;
      
      protected var FDesc:String;
      
      protected var FName:String;
      
      protected var FSex:int;
      
      protected var FLevel:int;
      
      protected var FNeedLevel:int;
      
      protected var FProfession:int;
      
      protected var FSource:int;
      
      protected var FQuality:int;
      
      protected var FAwakequality:int;
      
      protected var FPower:int;
      
      protected var FAgile:int;
      
      protected var FIntelligence:int;
      
      protected var FLife:int;
      
      protected var FSpeed:int;
      
      protected var FPowerGrow:Number;
      
      protected var FAgileGrow:Number;
      
      protected var FIntelligenceGrow:Number;
      
      protected var FLifeGrow:Number;
      
      protected var FSpeedGrow:Number;
      
      protected var FNearAttack:int;
      
      protected var FNearDefense:int;
      
      protected var FFarAttack:int;
      
      protected var FFarDefense:int;
      
      protected var FStrategyAttack:int;
      
      protected var FStrategyDefense:int;
      
      protected var FHitRate:Number;
      
      protected var FDodgeRate:Number;
      
      protected var FCritRate:Number;
      
      protected var FBlockRate:Number;
      
      protected var FPunchRate:Number;
      
      protected var FHelpRate:Number;
      
      protected var FHurtRate:Number;
      
      protected var FAvoidHurtRate:Number;
      
      protected var FWreckRate:Number;
      
      protected var FAntiknockRate:Number;
      
      protected var FAttachRate:Number;
      
      protected var FDeFenceRate:Number;
      
      protected var FRecoverRate:Number;
      
      protected var FActive:int;
      
      protected var FNormalAttack:int;
      
      protected var FTalent:int;
      
      protected var FWeakness:int;
      
      protected var FHeadStyle:String;
      
      protected var FCountry:int;
      
      protected var FHeroSoul:String;
      
      protected var FAttackEffect:String;
      
      protected var FAssess:String;
      
      protected var FSoundid:uint;
      
      protected var FSkillsound:uint;
      
      protected var FIsReversion:uint;
      
      protected var FOffsetY:int;
      
      protected var FMaxpoint:int;
      
      protected var FInitialpoint:int;
      
      public function TBaseHero()
      {
         super();
      }
      
      override ResourcesSpace function ReadDataByXml(param1:XML) : void
      {
         var _loc2_:XML = null;
         var _loc3_:String = null;
         var _loc4_:* = undefined;
         var _loc5_:uint = 0;
         var _loc6_:int = 0;
         _loc5_ = uint(param1.elements().length());
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc2_ = param1.elements()[_loc6_];
            _loc3_ = String(_loc2_.name());
            _loc4_ = _loc2_;
            if(_loc3_ == "id")
            {
               Coerce(uint(_loc4_));
            }
            else
            {
               _loc3_ = "F" + _loc3_;
               if(hasOwnProperty(_loc3_))
               {
                  this[_loc3_] = _loc4_;
               }
               else
               {
                  if(Count_AttributeName.indexOf(_loc3_.slice(1,2)) < 0)
                  {
                     _loc3_ = "F" + _loc3_.slice(1,2).toLocaleUpperCase() + _loc3_.slice(2);
                  }
                  if(hasOwnProperty(_loc3_.slice(1)))
                  {
                     if(this[_loc3_] is Boolean)
                     {
                        this[_loc3_] = Boolean(int(_loc4_));
                     }
                     else
                     {
                        this[_loc3_] = _loc4_;
                     }
                  }
               }
            }
            _loc6_++;
         }
      }
      
      override ResourcesSpace function WriteDataToStream(param1:ByteArray) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         param1.writeUnsignedInt(FIdentifier);
         param1.writeUnsignedInt(this.FTransId);
         param1.writeUnsignedInt(this.FTransState);
         param1.writeBoolean(this.FIsMain);
         param1.writeUnsignedInt(this.FOrigionId);
         param1.writeUnsignedInt(this.FSkPreview);
         TUtilityString.FlushUTF(param1,this.FDesc);
         TUtilityString.FlushUTF(param1,this.FName);
         TUtilityString.FlushUTF(param1,this.FAssess);
         param1.writeUnsignedInt(this.FSex);
         param1.writeUnsignedInt(this.FLevel);
         param1.writeUnsignedInt(this.FNeedLevel);
         param1.writeUnsignedInt(this.FProfession);
         param1.writeUnsignedInt(this.FSource);
         param1.writeUnsignedInt(this.FQuality);
         param1.writeUnsignedInt(this.FAwakequality);
         param1.writeUnsignedInt(this.FPower);
         param1.writeUnsignedInt(this.FAgile);
         param1.writeUnsignedInt(this.FIntelligence);
         param1.writeUnsignedInt(this.FLife);
         param1.writeUnsignedInt(this.FSpeed);
         param1.writeFloat(this.FPowerGrow);
         param1.writeFloat(this.FAgileGrow);
         param1.writeFloat(this.FIntelligenceGrow);
         param1.writeFloat(this.FLifeGrow);
         param1.writeFloat(this.FSpeedGrow);
         param1.writeUnsignedInt(this.FNearAttack);
         param1.writeUnsignedInt(this.FNearDefense);
         param1.writeUnsignedInt(this.FFarAttack);
         param1.writeUnsignedInt(this.FFarDefense);
         param1.writeUnsignedInt(this.FStrategyAttack);
         param1.writeUnsignedInt(this.FStrategyDefense);
         param1.writeFloat(this.FHitRate);
         param1.writeFloat(this.FDodgeRate);
         param1.writeFloat(this.FCritRate);
         param1.writeFloat(this.FBlockRate);
         param1.writeFloat(this.FPunchRate);
         param1.writeFloat(this.FHelpRate);
         param1.writeFloat(this.FHurtRate);
         param1.writeFloat(this.FAvoidHurtRate);
         param1.writeFloat(this.FWreckRate);
         param1.writeFloat(this.FAntiknockRate);
         param1.writeFloat(this.FAttachRate);
         param1.writeFloat(this.FDeFenceRate);
         param1.writeFloat(this.FRecoverRate);
         param1.writeUnsignedInt(this.FActive);
         TUtilityString.FlushUTF(param1,this.FAttackEffect);
         param1.writeUnsignedInt(this.FNormalAttack);
         param1.writeUnsignedInt(this.FTalent);
         param1.writeUnsignedInt(this.FWeakness);
         TUtilityString.FlushUTF(param1,this.FHeadStyle);
         param1.writeUnsignedInt(this.FCountry);
         TUtilityString.FlushUTF(param1,this.FHeroSoul);
         param1.writeUnsignedInt(this.FSoundid);
         param1.writeUnsignedInt(this.FSkillsound);
         param1.writeUnsignedInt(this.FIsReversion);
         param1.writeUnsignedInt(this.FOffsetY);
         param1.writeUnsignedInt(this.FMaxpoint);
         param1.writeUnsignedInt(this.FInitialpoint);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         this.FTransId = param1.readUnsignedInt();
         this.FTransState = param1.readUnsignedInt();
         this.FIsMain = param1.readBoolean();
         this.FOrigionId = param1.readUnsignedInt();
         this.FSkPreview = param1.readUnsignedInt();
         this.FDesc = TUtilityString.FetchUTF(param1);
         this.FName = TUtilityString.FetchUTF(param1);
         this.FAssess = TUtilityString.FetchUTF(param1);
         this.FSex = param1.readUnsignedInt();
         this.FLevel = param1.readUnsignedInt();
         this.FNeedLevel = param1.readUnsignedInt();
         this.FProfession = param1.readUnsignedInt();
         this.FSource = param1.readUnsignedInt();
         this.FQuality = param1.readUnsignedInt();
         this.FAwakequality = param1.readUnsignedInt();
         this.FPower = param1.readUnsignedInt();
         this.FAgile = param1.readUnsignedInt();
         this.FIntelligence = param1.readUnsignedInt();
         this.FLife = param1.readUnsignedInt();
         this.FSpeed = param1.readUnsignedInt();
         this.FPowerGrow = this.SetValueByFloat(param1.readFloat());
         this.FAgileGrow = this.SetValueByFloat(param1.readFloat());
         this.FIntelligenceGrow = this.SetValueByFloat(param1.readFloat());
         this.FLifeGrow = this.SetValueByFloat(param1.readFloat());
         this.FSpeedGrow = this.SetValueByFloat(param1.readFloat());
         this.FNearAttack = param1.readUnsignedInt();
         this.FNearDefense = param1.readUnsignedInt();
         this.FFarAttack = param1.readUnsignedInt();
         this.FFarDefense = param1.readUnsignedInt();
         this.FStrategyAttack = param1.readUnsignedInt();
         this.FStrategyDefense = param1.readUnsignedInt();
         this.FHitRate = this.SetValueByFloat(param1.readFloat());
         this.FDodgeRate = this.SetValueByFloat(param1.readFloat());
         this.FCritRate = this.SetValueByFloat(param1.readFloat());
         this.FBlockRate = this.SetValueByFloat(param1.readFloat());
         this.FPunchRate = this.SetValueByFloat(param1.readFloat());
         this.FHelpRate = this.SetValueByFloat(param1.readFloat());
         this.FHurtRate = this.SetValueByFloat(param1.readFloat());
         this.FAvoidHurtRate = this.SetValueByFloat(param1.readFloat());
         this.FWreckRate = this.SetValueByFloat(param1.readFloat());
         this.FAntiknockRate = this.SetValueByFloat(param1.readFloat());
         this.FAttachRate = this.SetValueByFloat(param1.readFloat());
         this.FDeFenceRate = this.SetValueByFloat(param1.readFloat());
         this.FRecoverRate = this.SetValueByFloat(param1.readFloat());
         this.FActive = param1.readUnsignedInt();
         this.FAttackEffect = TUtilityString.FetchUTF(param1);
         this.FNormalAttack = param1.readUnsignedInt();
         this.FTalent = param1.readUnsignedInt();
         this.FWeakness = param1.readUnsignedInt();
         this.FHeadStyle = TUtilityString.FetchUTF(param1);
         this.FCountry = param1.readUnsignedInt();
         this.FHeroSoul = TUtilityString.FetchUTF(param1);
         this.FSoundid = param1.readUnsignedInt();
         this.FSkillsound = param1.readUnsignedInt();
         this.FIsReversion = param1.readUnsignedInt();
         this.FOffsetY = param1.readUnsignedInt();
         this.FMaxpoint = param1.readUnsignedInt();
         this.FInitialpoint = param1.readUnsignedInt();
      }
      
      protected function SetValueByFloat(param1:Number) : Number
      {
         var _loc2_:String = null;
         var _loc3_:Number = NaN;
         _loc2_ = param1.toFixed(2);
         return parseFloat(_loc2_);
      }
      
      public function get IsMain() : Boolean
      {
         return this.FIsMain;
      }
      
      public function get OrigionId() : int
      {
         return this.FOrigionId;
      }
      
      public function get SkPreview() : int
      {
         return this.FSkPreview;
      }
      
      public function get TransId() : int
      {
         return this.FTransId;
      }
      
      public function get TransState() : int
      {
         return this.FTransState;
      }
      
      public function get Desc() : String
      {
         return this.FDesc;
      }
      
      public function get Name() : String
      {
         return this.FName;
      }
      
      public function get Sex() : int
      {
         return this.FSex;
      }
      
      public function get Level() : int
      {
         return this.FLevel;
      }
      
      public function get NeedLevel() : int
      {
         return this.FNeedLevel;
      }
      
      public function get Profession() : int
      {
         return this.FProfession;
      }
      
      public function get Source() : int
      {
         return this.FSource;
      }
      
      public function get Quality() : int
      {
         return this.FQuality;
      }
      
      public function get Awakequality() : int
      {
         return this.FAwakequality;
      }
      
      public function get Power() : int
      {
         return this.FPower;
      }
      
      public function get Agile() : int
      {
         return this.FAgile;
      }
      
      public function get Intelligence() : int
      {
         return this.FIntelligence;
      }
      
      public function get Life() : int
      {
         return this.FLife;
      }
      
      public function get Speed() : int
      {
         return this.FSpeed;
      }
      
      public function get PowerGrow() : Number
      {
         return this.FPowerGrow;
      }
      
      public function get AgileGrow() : Number
      {
         return this.FAgileGrow;
      }
      
      public function get IntelligenceGrow() : Number
      {
         return this.FIntelligenceGrow;
      }
      
      public function get LifeGrow() : Number
      {
         return this.FLifeGrow;
      }
      
      public function get SpeedGrow() : Number
      {
         return this.FSpeedGrow;
      }
      
      public function get NearAttack() : int
      {
         return this.FNearAttack;
      }
      
      public function get NearDefense() : int
      {
         return this.FNearDefense;
      }
      
      public function get FarAttack() : int
      {
         return this.FFarAttack;
      }
      
      public function get FarDefense() : int
      {
         return this.FFarDefense;
      }
      
      public function get StrategyAttack() : int
      {
         return this.FStrategyAttack;
      }
      
      public function get StrategyDefense() : int
      {
         return this.FStrategyDefense;
      }
      
      public function get HitRate() : Number
      {
         return this.FHitRate;
      }
      
      public function get DodgeRate() : Number
      {
         return this.FDodgeRate;
      }
      
      public function get CritRate() : Number
      {
         return this.FCritRate;
      }
      
      public function get BlockRate() : Number
      {
         return this.FBlockRate;
      }
      
      public function get PunchRate() : Number
      {
         return this.FPunchRate;
      }
      
      public function get HelpRate() : Number
      {
         return this.FHelpRate;
      }
      
      public function get HurtRate() : Number
      {
         return this.FHurtRate;
      }
      
      public function get AvoidHurtRate() : Number
      {
         return this.FAvoidHurtRate;
      }
      
      public function get WreckRate() : Number
      {
         return this.FWreckRate;
      }
      
      public function get AntiknockRate() : Number
      {
         return this.FAntiknockRate;
      }
      
      public function get AttachRate() : Number
      {
         return this.FAttachRate;
      }
      
      public function get DeFenceRate() : Number
      {
         return this.FDeFenceRate;
      }
      
      public function get RecoverRate() : Number
      {
         return this.FRecoverRate;
      }
      
      public function get Active() : int
      {
         return this.FActive;
      }
      
      public function get NormalAttack() : int
      {
         return this.FNormalAttack;
      }
      
      public function get Talent() : int
      {
         return this.FTalent;
      }
      
      public function get Weakness() : int
      {
         return this.FWeakness;
      }
      
      public function get HeadStyle() : String
      {
         return this.FHeadStyle;
      }
      
      public function get Country() : int
      {
         return this.FCountry;
      }
      
      public function get HeroSoul() : String
      {
         return this.FHeroSoul;
      }
      
      public function get AttackEffect() : String
      {
         return this.FAttackEffect;
      }
      
      public function get Assess() : String
      {
         return this.FAssess;
      }
      
      public function get Soundid() : uint
      {
         return this.FSoundid;
      }
      
      public function get Skillsound() : uint
      {
         return this.FSkillsound;
      }
      
      public function get IsReversion() : int
      {
         return this.FIsReversion;
      }
      
      public function get OffsetY() : int
      {
         return this.FOffsetY;
      }
      
      public function get Maxpoint() : int
      {
         return this.FMaxpoint;
      }
      
      public function get Initialpoint() : int
      {
         return this.FInitialpoint;
      }
      
      public function set AttackEffect(param1:String) : void
      {
      }
   }
}

