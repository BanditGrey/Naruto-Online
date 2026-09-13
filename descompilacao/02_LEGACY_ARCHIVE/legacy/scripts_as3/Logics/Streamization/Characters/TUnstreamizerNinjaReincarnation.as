package Logics.Streamization.Characters
{
   import Foundation.Resources.SResourcesCore;
   import Foundation.Streamization.TUnstreamizer;
   import Logics.Characters.THero;
   import Logics.Characters.THeros;
   import Logics.DatebaseVO.VO.TBaseHero;
   import Logics.DatebaseVO.VO.THeroTalent;
   import Logics.DatebaseVO.VO.TRoleModel;
   import Logics.DatebaseVO.VO.TSkillConfig;
   import Logics.SLogicsCore;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerNinjaReincarnation extends TUnstreamizer
   {
      
      protected var CharacterHeros:THeros;
      
      public function TUnstreamizerNinjaReincarnation()
      {
         super();
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:THero = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         this.CharacterHeros = SLogicsCore.Character.Heros;
         _loc4_ = param1.readShort();
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc7_ = int(param1.readUnsignedInt());
            _loc8_ = int(param1.readUnsignedInt());
            _loc6_ = this.CharacterHeros.GetHeroByIdentifier(_loc7_);
            if(_loc6_ != null)
            {
               _loc6_.MachampId = _loc8_;
            }
            _loc5_++;
         }
      }
      
      public function UnstreamizationPerform_BaseAttributes(param1:ByteArray, param2:Object, param3:Object) : void
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
         _loc6_.MachampId = param1.readUnsignedInt();
         _loc6_.Level = param1.readUnsignedInt();
         _loc6_.Experience.High = param1.readUnsignedInt();
         _loc6_.Experience.Low = param1.readUnsignedInt();
         _loc5_ = int(param1.readUnsignedShort());
         _loc5_ = _loc5_ - (_loc9_ + _loc10_);
         var _loc11_:uint = TUnstreamizerCharacter.STARTINDEX_BaseAttribute;
         var _loc12_:uint = TUnstreamizerCharacter.ENDINDEX_BaseAttribute;
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            if(_loc4_ >= _loc11_ && _loc4_ < _loc12_)
            {
               _loc7_ = param1.readFloat();
               _loc8_ = parseFloat(Number(_loc7_ * 100).toFixed(1));
               _loc6_.SetBaseAttributeByIndex(_loc4_,_loc8_);
            }
            else
            {
               if(_loc4_ == CONST_COMMON.BASEATTRIBUTEINDEX_Health)
               {
                  _loc7_ = param1.readFloat();
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
         this.UnstreamizationPerform_HeroByDatabase(_loc6_);
      }
      
      protected function UnstreamizationPerform_HeroByDatabase(param1:THero) : void
      {
         var _loc2_:TBaseHero = null;
         var _loc3_:THeroTalent = null;
         var _loc4_:TRoleModel = null;
         var _loc5_:TSkillConfig = null;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BaseHero,param1.Identifier) as TBaseHero;
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_HeroTalent,_loc2_.Talent) as THeroTalent;
         _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_RoleModel,param1.Identifier) as TRoleModel;
         _loc5_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SkillConfig,_loc2_.NormalAttack) as TSkillConfig;
         param1.IsMain = _loc2_.IsMain;
         param1.InitilizationLevel = _loc2_.Level;
         param1.ReincarnationId = _loc2_.TransId;
         param1.OrigionId = _loc2_.OrigionId;
         param1.ReincarnationOneOrTwo = _loc2_.TransState;
         param1.TalentName = _loc3_.TalentName;
         param1.TalentDesc = _loc3_.TalentDesc;
         param1.NormalAttackName = _loc5_.Name;
         param1.ModelID = _loc4_.Model;
         param1.SmallID = _loc4_.RoleHead;
         param1.LargeID = _loc4_.RoleStyle;
         param1.Assess = _loc2_.Assess;
      }
   }
}

