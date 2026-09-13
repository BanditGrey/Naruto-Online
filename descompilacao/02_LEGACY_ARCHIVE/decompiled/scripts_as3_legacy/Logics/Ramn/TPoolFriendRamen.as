package Logics.Ramn
{
   import Foundation.Pools.TPoolAutomatic;
   import Logics.Spaces.LogicsSpace;
   
   use namespace LogicsSpace;
   
   public class TPoolFriendRamen extends TPoolAutomatic
   {
      
      protected var FIndexFriendRamen:int;
      
      public function TPoolFriendRamen()
      {
         super();
      }
      
      override protected function RegisterClasses() : void
      {
         this.FIndexFriendRamen = RegisterClass(TFriendRamenData);
      }
      
      public function AcquireFriendRamen(param1:uint, param2:uint) : TFriendRamenData
      {
         var _loc3_:TFriendRamenData = null;
         _loc3_ = InstanceAcquireByIndex(this.FIndexFriendRamen) as TFriendRamenData;
         if(_loc3_ != null)
         {
            _loc3_.Coerce(param1,param2);
         }
         else
         {
            _loc3_ = new TFriendRamenData(param1,param2);
         }
         FStubsReferences.push(_loc3_.StubReferences);
         return _loc3_;
      }
   }
}

