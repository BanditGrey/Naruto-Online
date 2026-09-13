package Logics.Streamization.TransmigrationTrial
{
   import Foundation.Streamization.TUnstreamizer;
   import Logics.Spaces.LogicsSpace;
   import Logics.TransmigrationTrial.TTransmigrationTrialData;
   import Logics.TransmigrationTrial.TTrialCampaign;
   import flash.utils.ByteArray;
   
   use namespace LogicsSpace;
   
   public class TUnstreamizerTransmigrationTrial extends TUnstreamizer
   {
      
      public function TUnstreamizerTransmigrationTrial()
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
         var _loc10_:TTransmigrationTrialData = null;
         var _loc11_:TTrialCampaign = null;
         var _loc12_:uint = 0;
         var _loc13_:uint = 0;
         _loc10_ = param2 as TTransmigrationTrialData;
         _loc5_ = param1.readUnsignedShort();
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc6_ = param1.readUnsignedInt();
            _loc7_ = param1.readUnsignedInt();
            _loc8_ = param1.readUnsignedInt();
            _loc9_ = param1.readUnsignedInt();
            _loc11_ = _loc10_.GetTrialCampaignByCampaignId(_loc6_);
            if(_loc11_ == null)
            {
               _loc11_ = new TTrialCampaign();
               _loc10_.AddTrialCampaign(_loc11_);
            }
            _loc11_.CampaignId = _loc6_;
            _loc11_.CurStageId = _loc7_;
            _loc11_.HistoryStageId = _loc8_;
            _loc11_.TodayResetTimes = _loc9_;
            _loc4_++;
         }
         _loc5_ = param1.readUnsignedShort();
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc12_ = param1.readUnsignedInt();
            _loc13_ = param1.readUnsignedInt();
            _loc10_.ScoreList[_loc12_] = _loc13_;
            _loc4_++;
         }
      }
   }
}

