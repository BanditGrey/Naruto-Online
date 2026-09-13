package Logics.Streamization.Unlock
{
   import Foundation.Resources.*;
   import Foundation.Resources.Bins.TBins;
   import Logics.Characters.*;
   import Logics.DatebaseVO.VO.*;
   import Logics.Skills.*;
   import Logics.Spaces.LogicsSpace;
   import Logics.Unlocks.*;
   import Resources.Constants.*;
   import flash.utils.*;
   
   use namespace LogicsSpace;
   
   public class TUnstreamizerUnlocks extends TUnstreamizerUnlockUnknown
   {
      
      protected var FUnstreamizerUnlock:TUnstreamizerUnlock;
      
      public function TUnstreamizerUnlocks()
      {
         super();
         this.FUnstreamizerUnlock = new TUnstreamizerUnlock();
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform_Unlocks(param1,param2,param3);
      }
      
      protected function UnstreamizationPerform_Unlocks(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:uint = 0;
         var _loc7_:TUnlock = null;
         var _loc8_:TUnlocks = null;
         var _loc9_:TBins = null;
         var _loc10_:TConfigValue = null;
         _loc8_ = param2 as TUnlocks;
         _loc9_ = param3 as TBins;
         _loc8_.Clear();
         _loc7_ = new TUnlock(0);
         this.FUnstreamizerUnlock.UnstreamizeUnlockMore(param1,_loc7_,null);
         _loc8_.Add(_loc7_);
         _loc5_ = int(CONST_CONFIGVALUE.CAPACITY_UNLOCKS);
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc6_ = CONST_CONFIGVALUE.UNLOCKS[_loc4_];
            _loc7_ = new TUnlock(_loc6_);
            _loc10_ = _loc9_.GetDatebaseByIdentifier(_loc6_) as TConfigValue;
            this.FUnstreamizerUnlock.Unstreamize(param1,_loc7_,_loc10_);
            _loc8_.Add(_loc7_);
            _loc4_++;
         }
         _loc7_ = new TUnlock(CONST_CONFIGVALUE.SERVENSTAR_OPEN_LEVEL);
         _loc10_ = _loc9_.GetDatebaseByIdentifier(CONST_CONFIGVALUE.SERVENSTAR_OPEN_LEVEL) as TConfigValue;
         this.FUnstreamizerUnlock.UnstreamizeUnlockBigDipper(param1,_loc7_,_loc10_);
         _loc8_.Add(_loc7_);
         _loc7_ = new TUnlock(CONST_CONFIGVALUE.Slave_OpenLevel);
         _loc10_ = _loc9_.GetDatebaseByIdentifier(CONST_CONFIGVALUE.Slave_OpenLevel) as TConfigValue;
         this.FUnstreamizerUnlock.UnstreamizeUnlockMentorship(param1,_loc7_,_loc10_);
         _loc8_.Add(_loc7_);
         _loc7_ = new TUnlock(1);
         this.FUnstreamizerUnlock.UnstreamizeUnlockTavern(param1,_loc7_,null);
         _loc8_.Add(_loc7_);
         _loc7_ = new TUnlock(2);
         this.FUnstreamizerUnlock.UnstreamizeUnlockJade(param1,_loc7_,null);
         _loc8_.Add(_loc7_);
         _loc7_ = new TUnlock(3);
         this.FUnstreamizerUnlock.UnstreamizeUnlockMakeEquip(param1,_loc7_,null);
         _loc8_.Add(_loc7_);
         _loc7_ = new TUnlock(4);
         this.FUnstreamizerUnlock.UnstreamizeUnlockMilitary(param1,_loc7_,null);
         _loc8_.Add(_loc7_);
         _loc7_ = new TUnlock(5);
         this.FUnstreamizerUnlock.UnstreamizeUnlockVIP(param1,_loc7_,null);
         _loc8_.Add(_loc7_);
         _loc7_ = new TUnlock(6);
         this.FUnstreamizerUnlock.UnstreamizeUnlockCampaign(param1,_loc7_,null);
         _loc8_.Add(_loc7_);
         _loc7_ = new TUnlock(7);
         this.FUnstreamizerUnlock.UnstreamizeUnlockMakeEquipAdvanced(param1,_loc7_,null);
         _loc8_.Add(_loc7_);
      }
   }
}

