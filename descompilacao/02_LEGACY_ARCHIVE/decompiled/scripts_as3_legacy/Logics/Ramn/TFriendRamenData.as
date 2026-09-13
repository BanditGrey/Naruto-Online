package Logics.Ramn
{
   import Foundation.Common.Stubs.TStubReferences;
   import Foundation.Common.TEntity64;
   import Logics.Spaces.LogicsSpace;
   
   use namespace LogicsSpace;
   
   public class TFriendRamenData extends TEntity64
   {
      
      protected var FStubReferences:TStubReferences;
      
      protected var FFriendRamenLevel:uint;
      
      protected var FFriendRamenCurrentExp:uint;
      
      protected var FFriendRamenSendGoodsCount:uint;
      
      public function TFriendRamenData(param1:uint, param2:uint)
      {
         super(param1,param2);
         this.FStubReferences = new TStubReferences(this);
         this.FFriendRamenLevel = 1;
      }
      
      LogicsSpace function Coerce(param1:uint, param2:uint) : void
      {
         FIdentifier0 = param1;
         FIdentifier1 = param2;
      }
      
      public function get StubReferences() : TStubReferences
      {
         return this.FStubReferences;
      }
      
      public function get FriendRamenLevel() : uint
      {
         return this.FFriendRamenLevel;
      }
      
      public function set FriendRamenLevel(param1:uint) : void
      {
         this.FFriendRamenLevel = param1;
      }
      
      public function get FriendRamenCurrentExp() : uint
      {
         return this.FFriendRamenCurrentExp;
      }
      
      public function set FriendRamenCurrentExp(param1:uint) : void
      {
         this.FFriendRamenCurrentExp = param1;
      }
      
      public function get FriendRamenSendGoodsCount() : uint
      {
         return this.FFriendRamenSendGoodsCount;
      }
      
      public function set FriendRamenSendGoodsCount(param1:uint) : void
      {
         this.FFriendRamenSendGoodsCount = param1;
      }
   }
}

