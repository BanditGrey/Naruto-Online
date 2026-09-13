package Logics.Streamization.Tavern
{
   import Foundation.Streamization.TUnstreamizer;
   import Logics.Spaces.LogicsSpace;
   import Logics.Tavern.*;
   import flash.utils.ByteArray;
   
   use namespace LogicsSpace;
   
   public class TUnstreamizerTavern extends TUnstreamizer
   {
      
      protected static var FPoolTavern:TPoolTavern;
      
      public function TUnstreamizerTavern()
      {
         super();
      }
      
      LogicsSpace static function PoolsSetup(param1:TPoolTavern) : void
      {
         FPoolTavern = param1;
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:uint = 0;
         var _loc5_:int = 0;
         var _loc6_:TMoras = null;
         var _loc7_:TMora = null;
         _loc6_ = param2 as TMoras;
         _loc6_.Clear();
         _loc6_.MoraType = param1.readUnsignedByte();
         _loc5_ = int(param1.readUnsignedShort());
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc7_ = FPoolTavern.AcquireMora();
            _loc7_.TavernHeroId = param1.readUnsignedInt();
            _loc7_.IsMoraWin = Boolean(param1.readUnsignedByte());
            _loc7_.ReturnMoney = param1.readUnsignedInt();
            _loc6_.Add(_loc7_);
            _loc4_++;
         }
      }
      
      protected function Unstreamize_ReportList(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:Vector.<TReportList> = null;
         var _loc8_:TReportList = null;
         var _loc9_:uint = 0;
         _loc7_ = param2 as Vector.<TReportList>;
         _loc6_ = param1.readUnsignedShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc8_ = new TReportList();
            _loc8_.Time = param1.readUnsignedInt();
            _loc8_.MoraType = param1.readUnsignedInt();
            _loc9_ = param1.readUnsignedShort();
            _loc5_ = 0;
            while(_loc5_ < _loc9_)
            {
               _loc8_.SoulType = param1.readUnsignedInt();
               _loc8_.SoulCount = param1.readUnsignedInt();
               _loc5_++;
            }
            _loc7_[_loc4_] = _loc8_;
            _loc4_++;
         }
      }
      
      public function UnstreamizeReportList(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.Unstreamize_ReportList(param1,param2,param3);
      }
   }
}

