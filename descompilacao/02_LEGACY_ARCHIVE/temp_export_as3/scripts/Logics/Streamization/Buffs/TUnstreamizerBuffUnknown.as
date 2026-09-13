package Logics.Streamization.Buffs
{
   import Foundation.Streamization.TUnstreamizer;
   import Logics.Buffs.TPoolBuff;
   import Logics.Spaces.LogicsSpace;
   
   use namespace LogicsSpace;
   
   public class TUnstreamizerBuffUnknown extends TUnstreamizer
   {
      
      protected static var FPoolBuff:TPoolBuff;
      
      public function TUnstreamizerBuffUnknown()
      {
         super();
      }
      
      LogicsSpace static function PoolsSetup(param1:TPoolBuff) : void
      {
         FPoolBuff = param1;
      }
   }
}

