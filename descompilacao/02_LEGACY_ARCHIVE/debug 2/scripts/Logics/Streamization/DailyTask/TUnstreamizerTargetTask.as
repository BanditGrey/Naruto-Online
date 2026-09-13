package Logics.Streamization.DailyTask
{
   import Foundation.Streamization.TUnstreamizer;
   import Logics.Dailytask.TTargetTaskList;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerTargetTask extends TUnstreamizer
   {
      
      public function TUnstreamizerTargetTask()
      {
         super();
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:TTargetTaskList = null;
         var _loc5_:uint = 0;
         _loc4_ = param2 as TTargetTaskList;
         _loc4_.EventType = param1.readByte();
         _loc4_.IsFinish = param1.readByte();
      }
      
      override public function Unstreamize(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform(param1,param2,param3);
      }
   }
}

