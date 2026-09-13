package Logics.Streamization.Battle
{
   import Foundation.Streamization.*;
   import Foundation.Utilities.TUtilityString;
   import Logics.Battle.model.*;
   import flash.utils.*;
   
   public class TUnstreamizerBattleRepot extends TUnstreamizer
   {
      
      protected var UnstreamizerGroupRoleInfo:TUnstreamizerGroupRoleInfo;
      
      protected var UnstreamizerTurnInfo:TUnstreamizerTurnInfo;
      
      public function TUnstreamizerBattleRepot()
      {
         super();
         this.UnstreamizerGroupRoleInfo = new TUnstreamizerGroupRoleInfo();
         this.UnstreamizerTurnInfo = new TUnstreamizerTurnInfo();
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:int = 0;
         var _loc5_:TBattleInfo = null;
         var _loc6_:TTurnInfo = null;
         var _loc7_:uint = 0;
         var _loc8_:String = null;
         _loc5_ = param2 as TBattleInfo;
         _loc8_ = TUtilityString.FetchUTF(param1);
         this.UnstreamizerGroupRoleInfo.Unstreamize(param1,_loc5_.PlayerInfo_1,param3);
         this.UnstreamizerGroupRoleInfo.Unstreamize(param1,_loc5_.PlayerInfo_2,param3);
         _loc7_ = uint(param1.readShort());
         _loc5_.TotleTurn = _loc7_;
         _loc4_ = 0;
         while(_loc4_ < _loc7_)
         {
            _loc6_ = new TTurnInfo();
            this.UnstreamizerTurnInfo.Unstreamize(param1,_loc6_,param3);
            _loc5_.TurnInfos[_loc4_] = _loc6_;
            _loc4_++;
         }
      }
      
      override public function Unstreamize(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform(param1,param2,param3);
      }
   }
}

