package Logics.Inventories
{
   import Foundation.Collections.*;
   
   public class TCollectionInventory extends TCollectionInstance
   {
      
      public function TCollectionInventory(param1:int)
      {
         super(param1);
      }
      
      override protected function InstanceReplace(param1:int, param2:Object) : void
      {
         var _loc3_:Object = null;
         var _loc4_:TInventory = null;
         _loc3_ = FInstances[param1];
         if(_loc3_ != null)
         {
            _loc4_ = _loc3_ as TInventory;
            _loc4_.StubReferences.Dereference(this);
         }
         if(param2 != null)
         {
            _loc4_ = param2 as TInventory;
            _loc4_.StubReferences.Reference(this);
         }
         FInstances[param1] = param2;
      }
      
      public function GetInventoryByIndex(param1:int) : TInventory
      {
         return FInstances[param1] as TInventory;
      }
      
      public function GetInventoryByIdentifier(param1:uint, param2:uint) : TInventory
      {
         var _loc3_:int = 0;
         var _loc4_:TInventory = null;
         _loc3_ = 0;
         while(_loc3_ < Capacity)
         {
            _loc4_ = FInstances[_loc3_] as TInventory;
            if(_loc4_ != null)
            {
               if(_loc4_.Identifier0 == param1 && _loc4_.Identifier1 == param2)
               {
                  return _loc4_;
               }
            }
            _loc3_++;
         }
         return null;
      }
      
      public function SetInventoryByIndex(param1:int, param2:TInventory) : void
      {
         this.InstanceReplace(param1,param2);
      }
   }
}

