package Logics.Streamization.TransmigrationAccessory
{
   import Foundation.Streamization.TUnstreamizer;
   import Logics.TransmigrationAccessory.TAccessoryCampaign;
   import Logics.TransmigrationAccessory.TTransmigrationAccessoryData;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerTransmigrationAccessory extends TUnstreamizer
   {
      
      public function TUnstreamizerTransmigrationAccessory()
      {
         super();
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:int = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:TTransmigrationAccessoryData = null;
         var _loc11_:TAccessoryCampaign = null;
         var _loc12_:uint = 0;
         var _loc13_:uint = 0;
         _loc10_ = param2 as TTransmigrationAccessoryData;
         _loc5_ = param1.readUnsignedShort();
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc6_ = param1.readUnsignedInt();
            _loc7_ = param1.readUnsignedInt();
            _loc8_ = param1.readUnsignedInt();
            _loc9_ = param1.readUnsignedInt();
            _loc11_ = _loc10_.GetAccessoryCampaignByCampaignId(_loc6_);
            if(_loc11_ == null)
            {
               _loc11_ = new TAccessoryCampaign();
               _loc10_.AddAccessoryCampaign(_loc11_);
            }
            _loc11_.CampaignId = _loc6_;
            _loc11_.CurStageId = _loc7_;
            _loc11_.HistoryStageId = _loc8_;
            _loc11_.TodayResetTimes = _loc9_;
            _loc4_++;
         }
      }
   }
}

