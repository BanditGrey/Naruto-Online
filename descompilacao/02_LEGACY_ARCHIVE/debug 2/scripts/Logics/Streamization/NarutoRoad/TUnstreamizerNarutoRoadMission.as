package Logics.Streamization.NarutoRoad
{
   import Foundation.Resources.*;
   import Foundation.Resources.Bins.*;
   import Foundation.Resources.Repositories.*;
   import Foundation.Streamization.*;
   import Logics.*;
   import Logics.DatebaseVO.VO.*;
   import Logics.NarutoRoad.*;
   import Resources.Constants.*;
   import flash.utils.*;
   
   public class TUnstreamizerNarutoRoadMission extends TUnstreamizer
   {
      
      protected static const SHOW_VALUE_STAMP:uint = 1000000;
      
      public function TUnstreamizerNarutoRoadMission()
      {
         super();
      }
      
      protected function UnstreamizationMission(param1:uint, param2:Object, param3:Object) : void
      {
         var _loc4_:TNarutoRoadMission = null;
         var _loc5_:TResourceRepositoryBin = null;
         var _loc6_:TNarutoRoadTask = null;
         _loc4_ = param2 as TNarutoRoadMission;
         _loc5_ = param3 as TResourceRepositoryBin;
         _loc6_ = _loc5_.GetDatebase(CONST_DATEBASEVO.RESOURCEID_NarutoRoadTask,param1) as TNarutoRoadTask;
         _loc4_.NarutoRoadTask = _loc6_;
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:TNarutoRoadGroup = null;
         var _loc7_:TNarutoRoadMission = null;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         _loc6_ = param2 as TNarutoRoadGroup;
         _loc9_ = uint(SLogicsCore.Character.VipLevel);
         _loc5_ = param1.readUnsignedShort();
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc8_ = param1.readUnsignedInt();
            _loc7_ = _loc6_.GetMissionById(_loc8_);
            if(_loc7_ == null)
            {
               _loc7_ = new TNarutoRoadMission();
               _loc6_.AddMission(_loc7_);
               this.UnstreamizationMission(_loc8_,_loc7_,param3);
            }
            _loc7_.MissionStatus = param1.readByte();
            _loc7_.MissionCount = param1.readUnsignedInt();
            _loc7_.RewardType = param1.readByte();
            _loc7_.VipRewardType = param1.readByte();
            _loc7_.TipValue = _loc7_.MissionStatus * 2 * SHOW_VALUE_STAMP;
            if(_loc7_.MissionStatus == 2)
            {
               _loc7_.TipValue += _loc7_.HasRewardCanGet(_loc9_) > 0 ? SHOW_VALUE_STAMP : 0;
            }
            if(_loc7_.IsClose(_loc9_))
            {
               _loc7_.TipValue = -SHOW_VALUE_STAMP;
            }
            _loc7_.PopTipValue = _loc7_.MissionStatus * 2 * SHOW_VALUE_STAMP;
            if(_loc7_.HasRewardCanGet(_loc9_) <= 0)
            {
               _loc7_.PopTipValue = -SHOW_VALUE_STAMP;
            }
            _loc4_++;
         }
      }
      
      override public function Unstreamize(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform(param1,param2,param3);
      }
      
      public function UnstreamizeNarutoRoadMission(param1:uint, param2:Object, param3:Object) : void
      {
         this.UnstreamizationMission(param1,param2,param3);
      }
   }
}

