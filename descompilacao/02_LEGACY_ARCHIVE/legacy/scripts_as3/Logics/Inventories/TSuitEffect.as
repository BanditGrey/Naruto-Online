package Logics.Inventories
{
   import Foundation.Common.Stubs.*;
   
   public class TSuitEffect
   {
      
      protected var FStubReferences:TStubReferences;
      
      protected var FSuitQuantity:uint;
      
      protected var FCategory:Vector.<uint>;
      
      protected var FValue:Vector.<String>;
      
      protected var FPercentage:Vector.<uint>;
      
      protected var FEffectDesc:Vector.<String>;
      
      public function TSuitEffect()
      {
         super();
         this.FStubReferences = new TStubReferences(this);
         this.FCategory = new Vector.<uint>();
         this.FValue = new Vector.<String>();
         this.FPercentage = new Vector.<uint>();
         this.FEffectDesc = new Vector.<String>();
      }
      
      public function get StubReferences() : TStubReferences
      {
         return this.FStubReferences;
      }
      
      public function get SuitQuantity() : uint
      {
         return this.FSuitQuantity;
      }
      
      public function set SuitQuantity(param1:uint) : void
      {
         this.FSuitQuantity = param1;
      }
      
      public function get Category() : Vector.<uint>
      {
         return this.FCategory;
      }
      
      public function set Category(param1:Vector.<uint>) : void
      {
         this.FCategory = param1;
      }
      
      public function get Value() : Vector.<String>
      {
         return this.FValue;
      }
      
      public function set Value(param1:Vector.<String>) : void
      {
         this.FValue = param1;
      }
      
      public function get Percentage() : Vector.<uint>
      {
         return this.FPercentage;
      }
      
      public function set Percentage(param1:Vector.<uint>) : void
      {
         this.FPercentage = param1;
      }
      
      public function get EffectDesc() : Vector.<String>
      {
         return this.FEffectDesc;
      }
      
      public function set EffectDesc(param1:Vector.<String>) : void
      {
         this.FEffectDesc = param1;
      }
   }
}

