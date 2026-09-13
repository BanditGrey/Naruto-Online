package Logics.Streamization.ActivityMode
{
   import Logics.ActivityMode.TActivityAtoms;
   import Logics.ActivityMode.TActivityModes;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerActivityModes extends TUnstreamizerActivityModeUnknown
   {
      
      protected var FUnstreamizerActivityAtoms:TUnstreamizerActivityAtoms;
      
      public function TUnstreamizerActivityModes()
      {
         super();
         this.FUnstreamizerActivityAtoms = new TUnstreamizerActivityAtoms();
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform_ActivityModes(param1,param2,param3);
      }
      
      protected function UnstreamizationPerform_ActivityModes(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:TActivityModes = null;
         var _loc5_:TActivityAtoms = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         _loc4_ = param2 as TActivityModes;
         _loc6_ = _loc4_.Count;
         _loc7_ = 0;
         while(_loc7_ < _loc6_)
         {
            _loc5_ = _loc4_.GetActivityAtomsByIndex(_loc7_);
            this.FUnstreamizerActivityAtoms.Unstreamize(param1,_loc5_,param3);
            _loc7_++;
         }
         _loc4_.Sort();
      }
   }
}

