package Logics.Streamization.Battle
{
   import Foundation.Streamization.*;
   import Foundation.Utilities.TUtilityString;
   import Logics.Battle.model.*;
   import flash.utils.*;
   
   public class TUnstreamizerGroupRoleInfo extends TUnstreamizer
   {
      
      private var UnstreamizerRoleBattleInfo:TUnstreamizerRoleBattleInfo;
      
      public function TUnstreamizerGroupRoleInfo()
      {
         super();
         this.UnstreamizerRoleBattleInfo = new TUnstreamizerRoleBattleInfo();
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:int = 0;
         var _loc5_:TRoleBattleInfo = null;
         var _loc6_:TGroupRoleInfo = null;
         var _loc7_:uint = 0;
         _loc6_ = param2 as TGroupRoleInfo;
         _loc6_.MountsId = param1.readInt();
         _loc6_.MountsLevel = param1.readInt();
         _loc6_.SoulFormationID = param1.readInt();
         _loc6_.EmblemId = param1.readInt();
         _loc6_.RingId = param1.readInt();
         _loc6_.UserId = TUtilityString.FetchUTF(param1);
         _loc7_ = uint(param1.readShort());
         _loc4_ = 0;
         while(_loc4_ < _loc7_)
         {
            _loc5_ = new TRoleBattleInfo(_loc6_.Camp);
            this.UnstreamizerRoleBattleInfo.Unstreamize(param1,_loc5_,param3);
            _loc6_.RoleBattleInfos[_loc4_] = _loc5_;
            _loc4_++;
         }
      }
      
      override public function Unstreamize(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform(param1,param2,param3);
      }
   }
}

