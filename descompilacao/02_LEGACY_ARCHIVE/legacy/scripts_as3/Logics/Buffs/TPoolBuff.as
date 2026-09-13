package Logics.Buffs
{
   import Foundation.Pools.TPoolAutomatic;
   import Logics.Spaces.LogicsSpace;
   
   use namespace LogicsSpace;
   
   public class TPoolBuff extends TPoolAutomatic
   {
      
      protected var FIndexBuff:int;
      
      public function TPoolBuff()
      {
         super();
      }
      
      override protected function RegisterClasses() : void
      {
         this.FIndexBuff = RegisterClass(TBuff,this.ReleasingPerform_Buff);
      }
      
      protected function ReleasingPerform_Buff(param1:Object) : void
      {
         var _loc2_:TBuff = null;
         _loc2_ = param1 as TBuff;
         _loc2_.Reset();
      }
      
      public function Acquire(param1:uint) : TBuff
      {
         var _loc2_:TBuff = null;
         _loc2_ = InstanceAcquireByIndex(this.FIndexBuff) as TBuff;
         if(_loc2_ != null)
         {
            _loc2_.Coerce(param1);
         }
         else
         {
            _loc2_ = new TBuff(param1);
         }
         FStubsReferences.push(_loc2_.StubReferences);
         return _loc2_;
      }
   }
}

