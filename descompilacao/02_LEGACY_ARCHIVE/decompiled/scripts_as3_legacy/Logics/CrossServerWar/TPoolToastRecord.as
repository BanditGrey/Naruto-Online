package Logics.CrossServerWar
{
   import Foundation.Pools.TPoolAutomatic;
   
   public class TPoolToastRecord extends TPoolAutomatic
   {
      
      protected var FIndexToastRecord:int;
      
      public function TPoolToastRecord()
      {
         super();
      }
      
      override protected function RegisterClasses() : void
      {
         this.FIndexToastRecord = RegisterClass(TToastRecord);
      }
      
      public function AcquireToastRecord() : TToastRecord
      {
         var _loc1_:TToastRecord = null;
         _loc1_ = InstanceAcquireByIndex(this.FIndexToastRecord) as TToastRecord;
         if(_loc1_ == null)
         {
            _loc1_ = new TToastRecord();
         }
         FStubsReferences.push(_loc1_.StubReferences);
         return _loc1_;
      }
   }
}

