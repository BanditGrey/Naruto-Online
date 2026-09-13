package Logics.Streamization.Dailysign
{
   import Foundation.Resources.SResourcesCore;
   import Foundation.Streamization.TUnstreamizer;
   import Foundation.Timing.STimingCore;
   import Logics.DailySign.TDailySign;
   import Logics.DatebaseVO.TSignReward_Circle;
   import Logics.DatebaseVO.VO.TSignReward;
   import Logics.Inventories.TInventorySample;
   import Logics.Inventories.TInventorySamples;
   import Logics.SLogicsCore;
   import Logics.Streamization.Inventories.TUnstreamizerInventorySamples;
   import Resources.Constants.CONST_DATEBASEVO;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerDailySign extends TUnstreamizer
   {
      
      protected var FUnstreamizerInventorySamples:TUnstreamizerInventorySamples;
      
      public function TUnstreamizerDailySign()
      {
         super();
         this.FUnstreamizerInventorySamples = new TUnstreamizerInventorySamples();
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform_DailySignByDatabase(param1,param2);
      }
      
      protected function UnstreamizationPerform_DailySignByDatabase(param1:ByteArray, param2:Object) : void
      {
         var _loc3_:TDailySign = null;
         var _loc4_:uint = 0;
         var _loc5_:String = null;
         var _loc6_:int = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:TSignReward = null;
         var _loc10_:TSignReward_Circle = null;
         var _loc11_:uint = 0;
         var _loc12_:Date = null;
         _loc3_ = param2 as TDailySign;
         _loc3_.CurrentMonth = param1.readUnsignedInt();
         _loc4_ = param1.readUnsignedInt();
         _loc5_ = _loc4_.toString(2);
         _loc7_ = uint(_loc5_.length);
         _loc6_ = 0;
         while(_loc6_ < _loc7_)
         {
            _loc3_.DayList[_loc6_] = _loc5_.slice(_loc6_,_loc6_ + 1);
            _loc6_++;
         }
         _loc12_ = new Date(STimingCore.GetServerTime() * 1000);
         _loc3_.DayList.reverse();
         _loc6_ = int(_loc7_);
         while(_loc6_ < _loc12_.date)
         {
            _loc3_.DayList[_loc6_] = "0";
            _loc6_++;
         }
         _loc11_ = param1.readUnsignedInt();
         SLogicsCore.Character.SetCreditByIndex(4,_loc11_);
         _loc8_ = param1.readUnsignedInt();
         _loc3_.RewardID = _loc8_;
         _loc3_.SignTotalDays = param1.readUnsignedInt();
         _loc3_.ServerStartDate = param1.readUnsignedInt();
         _loc9_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SignReward,_loc8_) as TSignReward;
         _loc3_.SignReward = _loc9_;
         this.UnstreamizationPerform_InventorySamplesByDatabase(null,_loc3_,null);
      }
      
      protected function UnstreamizationPerform_InventorySamplesByDatabase(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:TDailySign = null;
         var _loc5_:TInventorySamples = null;
         var _loc6_:TInventorySamples = null;
         var _loc7_:TInventorySample = null;
         var _loc8_:int = 0;
         var _loc9_:uint = 0;
         _loc4_ = param2 as TDailySign;
         _loc5_ = new TInventorySamples();
         _loc6_ = new TInventorySamples();
         this.FUnstreamizerInventorySamples.UnstreamizeInventorySamplesByDatabase(null,_loc5_,null);
         _loc9_ = uint(_loc5_.Count);
         _loc8_ = 0;
         while(_loc8_ < _loc9_)
         {
            _loc7_ = _loc5_.GetInventorySampleByIndex(_loc8_);
            if(_loc7_.Model == 1)
            {
               _loc6_.Add(_loc7_);
            }
            _loc8_++;
         }
         _loc4_.ExchangeReward = _loc6_;
      }
      
      override public function Unstreamize(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform(param1,param2,param3);
      }
   }
}

