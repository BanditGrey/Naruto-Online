package Logics.Streamization.Exercise
{
   import Foundation.Streamization.TUnstreamizer;
   import Logics.Exercise.TActivityTaskData;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerActivityTask extends TUnstreamizer
   {
      
      public static const GIFT_ID:int = 0;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FUnstreamizerBaseActivityTask:TUnstreamizerBaseActivityTask;
      
      public function TUnstreamizerActivityTask(param1:int)
      {
         super();
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         this.FUnstreamizerBaseActivityTask = new TUnstreamizerBaseActivityTask();
         this.FUnstreamizerBaseActivityTask.activityId = param1;
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:TActivityTaskData = null;
         _loc4_ = param2 as TActivityTaskData;
         _loc4_.BeginTime = param1.readUnsignedInt();
         _loc4_.EndTime = param1.readUnsignedInt();
         param1.readUnsignedInt();
         this.FUnstreamizerBaseActivityTask.Unstreamize(param1,_loc4_,null);
      }
      
      override public function Unstreamize(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform(param1,param2,param3);
      }
   }
}

