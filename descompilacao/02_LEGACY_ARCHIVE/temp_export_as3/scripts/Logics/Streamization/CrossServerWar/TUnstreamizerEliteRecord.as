package Logics.Streamization.CrossServerWar
{
   import Foundation.Streamization.TUnstreamizer;
   import Logics.CrossServerWar.TEliteRecord;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerEliteRecord extends TUnstreamizer
   {
      
      public function TUnstreamizerEliteRecord()
      {
         super();
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:TEliteRecord = null;
         var _loc5_:ByteArray = null;
         _loc5_ = param1 as ByteArray;
         _loc4_ = param2 as TEliteRecord;
         _loc4_.RankYestoday = _loc5_.readUnsignedInt();
         _loc4_.RankToday = _loc5_.readUnsignedInt();
         _loc4_.FightingPower = _loc5_.readUnsignedInt();
         _loc4_.GroupLevel = _loc5_.readUnsignedInt();
         _loc4_.ScoreYestoday = _loc5_.readUnsignedInt();
         _loc4_.ScoreToday = _loc5_.readUnsignedInt();
         _loc4_.CurFightTimes = _loc5_.readUnsignedInt();
         _loc4_.LastFightTime = _loc5_.readUnsignedInt();
         _loc4_.ApplyStatus = Boolean(_loc5_.readUnsignedInt());
         _loc4_.ToastTimes = _loc5_.readUnsignedInt();
         _loc4_.TokenCount = _loc5_.readUnsignedInt();
         _loc4_.OrangeSoulCount = _loc5_.readUnsignedInt();
         _loc4_.IsJoinSkip = _loc5_.readUnsignedByte();
         _loc4_.LeftBuyCount = _loc5_.readUnsignedInt();
         _loc4_.YestodayIsApply = _loc5_.readUnsignedInt();
      }
      
      override public function Unstreamize(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform(param1,param2,param3);
      }
   }
}

