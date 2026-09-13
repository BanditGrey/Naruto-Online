package Logics.Streamization.ConsumeVip
{
   import Foundation.Streamization.TUnstreamizer;
   import Logics.ConsumeVip.TConsumeVipData;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerConsumeVip extends TUnstreamizer
   {
      
      public function TUnstreamizerConsumeVip()
      {
         super();
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:TConsumeVipData = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         _loc4_ = param2 as TConsumeVipData;
         _loc4_.ConsumeMoney = param1.readUnsignedInt();
         _loc4_.DailyAward = param1.readUnsignedInt();
         _loc5_ = param1.readShort();
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc8_ = int(param1.readUnsignedInt());
            _loc7_ = int(param1.readUnsignedInt());
            _loc4_.VipAward[_loc7_] = _loc8_;
            _loc6_++;
         }
         _loc5_ = param1.readShort();
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc9_ = int(param1.readUnsignedInt());
            _loc7_ = int(param1.readUnsignedInt());
            _loc4_.Daybuy[_loc7_] = _loc9_;
            _loc6_++;
         }
      }
   }
}

