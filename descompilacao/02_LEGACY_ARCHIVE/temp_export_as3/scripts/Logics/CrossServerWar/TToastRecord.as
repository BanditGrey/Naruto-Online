package Logics.CrossServerWar
{
   import Foundation.Common.Stubs.TStubReferences;
   
   public class TToastRecord
   {
      
      protected var FName:String;
      
      protected var FQuality:uint;
      
      protected var FToastID:uint;
      
      protected var FStubReferences:TStubReferences;
      
      public function TToastRecord()
      {
         super();
         this.FStubReferences = new TStubReferences(this);
      }
      
      public function get StubReferences() : TStubReferences
      {
         return this.FStubReferences;
      }
      
      public function get Name() : String
      {
         return this.FName;
      }
      
      public function set Name(param1:String) : void
      {
         this.FName = param1;
      }
      
      public function get Quality() : uint
      {
         return this.FQuality;
      }
      
      public function set Quality(param1:uint) : void
      {
         this.FQuality = param1;
      }
      
      public function get ToastID() : uint
      {
         return this.FToastID;
      }
      
      public function set ToastID(param1:uint) : void
      {
         this.FToastID = param1;
      }
   }
}

