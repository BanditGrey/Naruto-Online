package Logics.Streamization.BigDipper
{
   import Foundation.Streamization.TUnstreamizer;
   import Logics.BigDipper.TStarUpgradeInfor;
   import Logics.BigDipper.TStarsInfor;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerUpgradeInfor extends TUnstreamizer
   {
      
      public function TUnstreamizerUpgradeInfor()
      {
         super();
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:TStarUpgradeInfor = null;
         var _loc5_:int = 0;
         var _loc6_:uint = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:TStarsInfor = null;
         _loc4_ = TStarUpgradeInfor(param2);
         _loc11_ = TStarsInfor(param3);
         _loc4_.ResultID = param1.readByte();
         _loc4_.CostMoney = param1.readUnsignedInt();
         _loc4_.CostFreeTime = param1.readByte();
         _loc4_.Length = param1.readShort();
         _loc5_ = 0;
         while(_loc5_ < _loc4_.Length)
         {
            _loc6_ = param1.readUnsignedInt();
            _loc8_ = int(param1.readUnsignedInt());
            _loc9_ = param1.readUnsignedInt();
            _loc10_ = param1.readUnsignedInt();
            if(_loc4_.ResultID != 1 && _loc4_.GetExperienceByStarID(_loc6_) == _loc9_ && _loc11_.GetStarByStarNameID(_loc6_).StarLevel == _loc10_)
            {
               _loc8_ = -1;
            }
            _loc4_.SetReceiveExperienceByStarID(_loc6_,_loc8_);
            _loc4_.SetExperienceByStarID(_loc6_,_loc9_);
            _loc4_.SetLevelByStarID(_loc6_,_loc10_);
            _loc5_++;
         }
      }
   }
}

