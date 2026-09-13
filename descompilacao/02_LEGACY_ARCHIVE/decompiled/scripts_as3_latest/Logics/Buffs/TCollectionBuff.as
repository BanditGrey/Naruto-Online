package Logics.Buffs
{
   import Foundation.Collections.*;
   import Resources.Constants.*;
   
   public class TCollectionBuff extends TCollectionInstance
   {
      
      public function TCollectionBuff(param1:int)
      {
         super(param1);
      }
      
      override protected function InstanceReplace(param1:int, param2:Object) : void
      {
         var _loc3_:Object = null;
         var _loc4_:TBuff = null;
         _loc3_ = FInstances[param1];
         if(_loc3_ != null)
         {
            _loc4_ = _loc3_ as TBuff;
            _loc4_.StubReferences.Dereference(this);
         }
         if(param2 != null)
         {
            _loc4_ = param2 as TBuff;
            _loc4_.StubReferences.Reference(this);
         }
         FInstances[param1] = param2;
      }
      
      public function GetBuffByIndex(param1:int) : TBuff
      {
         return FInstances[param1] as TBuff;
      }
      
      public function SetBuffByByIndex(param1:int, param2:TBuff) : void
      {
         this.InstanceReplace(param1,param2);
      }
      
      public function GetIndexByIDTemplate(param1:int) : int
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:TBuff = null;
         return -1;
      }
   }
}

