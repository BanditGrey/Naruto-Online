package Logics.Streamization.Buffs
{
   import Logics.Buffs.TBuff;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerBuffGlobal extends TUnstreamizerBuffUnknown
   {
      
      public function TUnstreamizerBuffGlobal()
      {
         super();
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform_Properties(param1,param2,param3);
      }
      
      protected function UnstreamizationPerform_Properties(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:TBuff = null;
         var _loc5_:uint = 0;
         var _loc6_:int = 0;
         _loc4_ = param2 as TBuff;
      }
   }
}

