package Logics.Palace
{
   import Foundation.Pools.TPoolAutomatic;
   
   public class TPoolPalaceReport extends TPoolAutomatic
   {
      
      protected var FIndexPalaceTop3Report:int;
      
      public function TPoolPalaceReport()
      {
         super();
      }
      
      override protected function RegisterClasses() : void
      {
         this.FIndexPalaceTop3Report = RegisterClass(TPalaceTop3Report);
      }
      
      public function AcquirePalaceTop3Report() : TPalaceTop3Report
      {
         var _loc1_:TPalaceTop3Report = null;
         _loc1_ = InstanceAcquireByIndex(this.FIndexPalaceTop3Report) as TPalaceTop3Report;
         if(_loc1_ == null)
         {
            _loc1_ = new TPalaceTop3Report();
         }
         FStubsReferences.push(_loc1_.StubReferences);
         return _loc1_;
      }
   }
}

