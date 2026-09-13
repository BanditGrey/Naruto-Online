package Logics.Unlocks
{
   import Foundation.Common.Stubs.TStubReferences;
   import Foundation.Common.TEntity;
   import Logics.Spaces.LogicsSpace;
   
   use namespace LogicsSpace;
   
   public class TUnlock extends TEntity
   {
      
      public static const UNLOCKSTATE_Unlock:uint = 0;
      
      public static const UNLOCKSTATE_Unlocking:uint = 1;
      
      public static const UNLOCKSTATE_Unlocked:uint = 2;
      
      protected var FStubReferences:TStubReferences;
      
      protected var FPosition:uint;
      
      protected var FLocaltion:uint;
      
      protected var FUnlockCondition:uint;
      
      protected var FUnlockValue:uint;
      
      protected var FUnlockState:uint;
      
      protected var FDesc:String;
      
      public function TUnlock(param1:uint)
      {
         super(param1);
         this.FStubReferences = new TStubReferences(this);
      }
      
      LogicsSpace function Coerce(param1:uint) : void
      {
         FIdentifier = param1;
      }
      
      public function get StubReferences() : TStubReferences
      {
         return this.FStubReferences;
      }
      
      public function get Localtion() : uint
      {
         return this.FLocaltion;
      }
      
      public function set Localtion(param1:uint) : void
      {
         this.FLocaltion = param1;
      }
      
      public function get Position() : uint
      {
         return this.FPosition;
      }
      
      public function set Position(param1:uint) : void
      {
         this.FPosition = param1;
      }
      
      public function get UnlockCondition() : uint
      {
         return this.FUnlockCondition;
      }
      
      public function set UnlockCondition(param1:uint) : void
      {
         this.FUnlockCondition = param1;
      }
      
      public function get UnlockValue() : uint
      {
         return this.FUnlockValue;
      }
      
      public function set UnlockValue(param1:uint) : void
      {
         this.FUnlockValue = param1;
      }
      
      public function get Desc() : String
      {
         return this.FDesc;
      }
      
      public function set Desc(param1:String) : void
      {
         this.FDesc = param1;
      }
      
      LogicsSpace function get UnlockState() : uint
      {
         return this.FUnlockState;
      }
      
      LogicsSpace function set UnlockState(param1:uint) : void
      {
         this.FUnlockState = param1;
      }
      
      public function get State() : uint
      {
         return this.FUnlockState;
      }
      
      public function Reset() : void
      {
         FIdentifier = 0;
         this.FLocaltion = 0;
         this.FPosition = 0;
         this.FUnlockCondition = 0;
         this.FUnlockValue = 0;
         this.FDesc = "";
      }
   }
}

