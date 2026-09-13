package Logics.DatebaseVO
{
   import Foundation.Common.Stubs.TStubReferences;
   import Foundation.Resources.Spaces.ResourcesSpace;
   import flash.utils.ByteArray;
   
   use namespace ResourcesSpace;
   
   public class TDatebaseVO
   {
      
      protected var Count_AttributeName:String = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
      
      protected var FStubReferences:TStubReferences;
      
      protected var FIdentifier:int;
      
      protected var FResourceID:uint;
      
      public function TDatebaseVO()
      {
         super();
         this.FStubReferences = new TStubReferences(this);
      }
      
      ResourcesSpace function Coerce(param1:uint) : void
      {
         this.FIdentifier = param1;
      }
      
      ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
      }
      
      ResourcesSpace function WriteDataToStream(param1:ByteArray) : void
      {
      }
      
      ResourcesSpace function ReadDataByXml(param1:XML) : void
      {
      }
      
      public function get StubReferences() : TStubReferences
      {
         return this.FStubReferences;
      }
      
      public function get Identifier() : int
      {
         return this.FIdentifier;
      }
      
      public function get ResourceID() : uint
      {
         return this.FResourceID;
      }
      
      public function set ResourceID(param1:uint) : void
      {
         this.FResourceID = param1;
      }
   }
}

