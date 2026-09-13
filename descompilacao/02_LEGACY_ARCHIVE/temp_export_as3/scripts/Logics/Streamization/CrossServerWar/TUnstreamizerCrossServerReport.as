package Logics.Streamization.CrossServerWar
{
   import Foundation.Streamization.TUnstreamizer;
   import Foundation.Utilities.TUtilityString;
   import Logics.CrossServerWar.TCrossServerReport;
   import Logics.CrossServerWar.TCrossServerReports;
   import Logics.CrossServerWar.TPoolCrossServerReport;
   import Logics.Spaces.LogicsSpace;
   import flash.utils.ByteArray;
   
   use namespace LogicsSpace;
   
   public class TUnstreamizerCrossServerReport extends TUnstreamizer
   {
      
      protected static var FPoolCrossServerReport:TPoolCrossServerReport;
      
      public function TUnstreamizerCrossServerReport()
      {
         super();
      }
      
      LogicsSpace static function PoolsSetup(param1:TPoolCrossServerReport) : void
      {
         FPoolCrossServerReport = param1;
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:int = 0;
         var _loc5_:uint = 0;
         var _loc6_:TCrossServerReport = null;
         var _loc7_:ByteArray = null;
         var _loc8_:TCrossServerReports = null;
         _loc8_ = param2 as TCrossServerReports;
         _loc7_ = param1 as ByteArray;
         _loc8_.Clear();
         _loc5_ = uint(_loc7_.readShort());
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc6_ = FPoolCrossServerReport.AcquireCrossServerReport();
            _loc6_.Name = TUtilityString.FetchUTF(_loc7_);
            _loc6_.Time = _loc7_.readUnsignedInt();
            _loc6_.ReportID = TUtilityString.FetchUTF(_loc7_);
            _loc6_.IsWin = Boolean(_loc7_.readUnsignedInt());
            _loc8_.Add(_loc6_);
            _loc4_++;
         }
         while(_loc8_.Count > 5)
         {
            _loc8_.DeleteFirst();
         }
         _loc8_.SortByTime();
      }
      
      override public function Unstreamize(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform(param1,param2,param3);
      }
   }
}

