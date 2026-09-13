package Logics.Streamization.CrossServerWar
{
   import Foundation.Streamization.TUnstreamizer;
   import Foundation.Utilities.TUtilityString;
   import Logics.CrossServerWar.TIntegralRanking;
   import Logics.CrossServerWar.TIntegralRankings;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerIntegralRanking extends TUnstreamizer
   {
      
      public function TUnstreamizerIntegralRanking()
      {
         super();
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:int = 0;
         var _loc5_:uint = 0;
         var _loc6_:TIntegralRankings = null;
         var _loc7_:TIntegralRanking = null;
         _loc6_ = param2 as TIntegralRankings;
         _loc6_.Clear();
         _loc5_ = param1.readUnsignedShort();
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc7_ = new TIntegralRanking();
            _loc7_.CurRanking = param1.readUnsignedInt();
            _loc7_.PlayerName = TUtilityString.FetchUTF(param1);
            _loc7_.ServerName = TUtilityString.FetchUTF(param1);
            _loc7_.PlayerLevel = param1.readUnsignedInt();
            _loc7_.PlayerScore = param1.readUnsignedInt();
            _loc7_.Group = param1.readUnsignedInt();
            _loc6_.Add(_loc7_);
            _loc4_++;
         }
      }
      
      override public function Unstreamize(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform(param1,param2,param3);
      }
   }
}

