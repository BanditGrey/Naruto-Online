package Logics.CrossServerWar
{
   import Foundation.Pools.TPoolAutomatic;
   
   public class TPoolCrossServerReport extends TPoolAutomatic
   {
      
      protected var FIndexCrossServerReport:int;
      
      public function TPoolCrossServerReport()
      {
         super();
      }
      
      override protected function RegisterClasses() : void
      {
         this.FIndexCrossServerReport = RegisterClass(TCrossServerReport);
      }
      
      public function AcquireCrossServerReport() : TCrossServerReport
      {
         var _loc1_:TCrossServerReport = null;
         _loc1_ = InstanceAcquireByIndex(this.FIndexCrossServerReport) as TCrossServerReport;
         if(_loc1_ == null)
         {
            _loc1_ = new TCrossServerReport();
         }
         FStubsReferences.push(_loc1_.StubReferences);
         return _loc1_;
      }
   }
}

