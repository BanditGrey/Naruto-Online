package Foundation.Utilities
{
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   
   public class TUtilityTransmitEmptyInfor
   {
      
      public function TUtilityTransmitEmptyInfor()
      {
         super();
      }
      
      public static function TransmitEmptyPacket(param1:uint) : void
      {
         var _loc2_:TPacket = null;
         _loc2_ = SNetworkCore.PacketAcquire(param1);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
   }
}

