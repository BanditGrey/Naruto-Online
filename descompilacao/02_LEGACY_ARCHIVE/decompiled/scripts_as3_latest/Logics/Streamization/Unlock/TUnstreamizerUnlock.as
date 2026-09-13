package Logics.Streamization.Unlock
{
   import Foundation.Resources.*;
   import Foundation.Resources.Bins.*;
   import Foundation.Streamization.*;
   import Logics.DatebaseVO.VO.*;
   import Logics.Spaces.*;
   import Logics.Unlocks.*;
   import Resources.Constants.*;
   import Resources.Strings.STRING_UNLOCK;
   import flash.utils.*;
   
   use namespace LogicsSpace;
   
   public class TUnstreamizerUnlock extends TUnstreamizerUnlockUnknown
   {
      
      public function TUnstreamizerUnlock()
      {
         super();
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerformUnlockByDatabase(param1,param2,param3);
      }
      
      protected function UnstreamizationPerform_Properties(param1:ByteArray, param2:Object, param3:Object) : void
      {
      }
      
      protected function UnstreamizationPerformUnlockByDatabase(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:TUnlock = null;
         var _loc5_:Vector.<Object> = null;
         var _loc6_:TConfigValue = null;
         _loc4_ = param2 as TUnlock;
         _loc6_ = param3 as TConfigValue;
         _loc5_ = _loc6_.Value as Vector.<Object>;
         _loc4_.Position = _loc5_[0] as uint;
         _loc4_.Localtion = _loc5_[1] as uint;
         _loc4_.UnlockCondition = _loc5_[2] as uint;
         _loc4_.UnlockValue = _loc5_[3] as uint;
         _loc4_.Desc = _loc5_[4] as String;
      }
      
      protected function UnstreamizationPerform_UnlockMore(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:TUnlock = null;
         var _loc5_:uint = 0;
         _loc4_ = param2 as TUnlock;
         _loc4_.Position = CONST_SHORTCUTS.POSITION_Activity;
         _loc4_.Localtion = CONST_SHORTCUTS.TYPE_Activity_More;
         _loc4_.UnlockCondition = 2;
         _loc4_.UnlockValue = 1;
         _loc4_.Desc = STRING_UNLOCK.STRING_More;
      }
      
      protected function UnstreamizationPerform_UnlockBigDipper(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:TUnlock = null;
         var _loc5_:uint = 0;
         var _loc6_:TConfigValue = null;
         _loc4_ = param2 as TUnlock;
         _loc6_ = param3 as TConfigValue;
         _loc5_ = _loc6_.Value as uint;
         _loc4_.Position = CONST_SHORTCUTS.POSITION_Constantly;
         _loc4_.Localtion = CONST_SHORTCUTS.TYPE_Constantly_BigDipper;
         _loc4_.UnlockCondition = 2;
         _loc4_.UnlockValue = _loc5_;
         _loc4_.Desc = STRING_UNLOCK.STRING_UnLockBigDipper;
      }
      
      protected function UnstreamizationPerform_UnlockMentorship(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:TUnlock = null;
         var _loc5_:uint = 0;
         var _loc6_:TConfigValue = null;
         _loc4_ = param2 as TUnlock;
         _loc6_ = param3 as TConfigValue;
         _loc5_ = _loc6_.Value as uint;
         _loc4_.Position = CONST_SHORTCUTS.POSITION_Constantly;
         _loc4_.Localtion = CONST_SHORTCUTS.TYPE_Constantly_Slave;
         _loc4_.UnlockCondition = 2;
         _loc4_.UnlockValue = _loc5_;
         _loc4_.Desc = STRING_UNLOCK.STRING_UnLockMentorship;
      }
      
      protected function UnstreamizationPerform_UnlockTavern(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:TUnlock = null;
         var _loc5_:uint = 0;
         _loc4_ = param2 as TUnlock;
         _loc4_.Position = CONST_SHORTCUTS.POSITION_Additional;
         _loc4_.Localtion = CONST_SHORTCUTS.TYPE_Additional_Tavern;
         _loc4_.UnlockCondition = 1;
         _loc4_.UnlockValue = 16100016;
         _loc4_.Desc = STRING_UNLOCK.STRING_UnLockTavern;
      }
      
      protected function UnstreamizationPerform_UnlockJade(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:TUnlock = null;
         var _loc5_:uint = 0;
         _loc4_ = param2 as TUnlock;
         _loc4_.Position = CONST_SHORTCUTS.POSITION_Additional;
         _loc4_.Localtion = CONST_SHORTCUTS.TYPE_Additional_Jade;
         _loc4_.UnlockCondition = 1;
         _loc4_.UnlockValue = 16100035;
         _loc4_.Desc = STRING_UNLOCK.STRING_UnLockJade;
      }
      
      protected function UnstreamizationPerform_UnlockMakeEquip(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:TUnlock = null;
         var _loc5_:uint = 0;
         _loc4_ = param2 as TUnlock;
         _loc4_.Position = CONST_SHORTCUTS.POSITION_Additional;
         _loc4_.Localtion = CONST_SHORTCUTS.TYPE_Additional_MakeEquip;
         _loc4_.UnlockCondition = 1;
         _loc4_.UnlockValue = 16100035;
         _loc4_.Desc = STRING_UNLOCK.STRING_UnLockMakeEquip;
      }
      
      protected function UnstreamizationPerform_UnlockMilitary(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:TUnlock = null;
         var _loc5_:uint = 0;
         _loc4_ = param2 as TUnlock;
         _loc4_.Position = CONST_SHORTCUTS.POSITION_Avatar;
         _loc4_.Localtion = CONST_SHORTCUTS.TYPE_Avatar_Military;
         _loc4_.UnlockCondition = 0;
         _loc4_.UnlockValue = 0;
         _loc4_.Desc = STRING_UNLOCK.STRING_UnLockMilitary;
      }
      
      protected function UnstreamizationPerform_UnlockVIP(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:TUnlock = null;
         var _loc5_:uint = 0;
         _loc4_ = param2 as TUnlock;
         _loc4_.Position = CONST_SHORTCUTS.POSITION_Avatar;
         _loc4_.Localtion = CONST_SHORTCUTS.TYPE_Avatar_VIP;
         _loc4_.UnlockCondition = 0;
         _loc4_.UnlockValue = 0;
         _loc4_.Desc = STRING_UNLOCK.STRING_UnLockVIP;
      }
      
      protected function UnstreamizationPerform_UnlockCampaign(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:TUnlock = null;
         var _loc5_:uint = 0;
         _loc4_ = param2 as TUnlock;
         _loc4_.Position = CONST_SHORTCUTS.POSITION_Map;
         _loc4_.Localtion = CONST_SHORTCUTS.TYPE_Map_EnterWorldMap;
         _loc4_.UnlockCondition = 0;
         _loc4_.UnlockValue = 0;
         _loc4_.Desc = STRING_UNLOCK.STRING_UnLockWorldMap;
      }
      
      protected function UnstreamizationPerform_UnlockMakeEquipAdvanced(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:TUnlock = null;
         var _loc5_:uint = 0;
         _loc4_ = param2 as TUnlock;
         _loc4_.Position = CONST_SHORTCUTS.POSITION_Additional;
         _loc4_.Localtion = CONST_SHORTCUTS.TYPE_Additional_MakeEquipAdvanced;
         _loc4_.UnlockCondition = 3;
         _loc4_.UnlockValue = 999;
         _loc4_.UnlockCondition = 0;
         _loc4_.UnlockValue = 0;
         _loc4_.Desc = STRING_UNLOCK.STRING_UnLockMakeEquipAdvanced;
      }
      
      public function UnstreamizeUnlockMore(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform_UnlockMore(param1,param2,param3);
      }
      
      public function UnstreamizeUnlockBigDipper(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform_UnlockBigDipper(param1,param2,param3);
      }
      
      public function UnstreamizeUnlockMentorship(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform_UnlockMentorship(param1,param2,param3);
      }
      
      public function UnstreamizeUnlockTavern(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform_UnlockTavern(param1,param2,param3);
      }
      
      public function UnstreamizeUnlockJade(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform_UnlockJade(param1,param2,param3);
      }
      
      public function UnstreamizeUnlockMakeEquip(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform_UnlockMakeEquip(param1,param2,param3);
      }
      
      public function UnstreamizeUnlockMilitary(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform_UnlockMilitary(param1,param2,param3);
      }
      
      public function UnstreamizeUnlockVIP(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform_UnlockVIP(param1,param2,param3);
      }
      
      public function UnstreamizeUnlockCampaign(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform_UnlockCampaign(param1,param2,param3);
      }
      
      public function UnstreamizeUnlockMakeEquipAdvanced(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform_UnlockMakeEquipAdvanced(param1,param2,param3);
      }
   }
}

