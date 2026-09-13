package Logics.Streamization.Skills
{
   import Foundation.Resources.Bins.TBins;
   import Logics.DatebaseVO.VO.TSkillConfig;
   import Logics.Skills.TSkill;
   import Logics.Spaces.LogicsSpace;
   import flash.utils.ByteArray;
   
   use namespace LogicsSpace;
   
   public class TUnstreamizerSkill extends TUnstreamizerSkillUnknown
   {
      
      public function TUnstreamizerSkill()
      {
         super();
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform_Properties(param1,param2,param3);
         this.UnstreamizationPerform_SkillByDatabase(param2,param3);
      }
      
      protected function UnstreamizationPerform_Properties(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:TSkill = null;
         var _loc5_:uint = 0;
         _loc4_ = param2 as TSkill;
         _loc5_ = param1.readUnsignedInt();
         _loc4_.Coerce(_loc5_);
         _loc4_.Mounted = param1.readBoolean();
      }
      
      protected function UnstreamizationPerform_SkillByDatabase(param1:Object, param2:Object) : void
      {
         var _loc3_:TSkill = null;
         var _loc4_:TBins = null;
         var _loc5_:TSkillConfig = null;
         _loc3_ = param1 as TSkill;
         _loc3_.SetValueForOneselfBySkillId(_loc3_.Identifier);
      }
      
      protected function UnstreamizationPerform_GenerateSkill(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform_SkillByDatabase(param2,param3);
      }
      
      public function UnstreamizeGenerateSkill(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform_GenerateSkill(param1,param2,param3);
      }
   }
}

