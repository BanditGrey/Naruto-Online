package Logics.Inventories
{
   public class TInventories
   {
      
      protected var FInventories:Vector.<TInventory>;
      
      public function TInventories()
      {
         super();
         this.FInventories = new Vector.<TInventory>();
      }
      
      public function get Count() : int
      {
         return this.FInventories.length;
      }
      
      public function GetInventoryByIndex(param1:int) : TInventory
      {
         return this.FInventories[param1];
      }
      
      protected function SortField(param1:TInventory, param2:TInventory) : int
      {
         if(param1.SortIndex > param2.SortIndex)
         {
            return 1;
         }
         if(param1.SortIndex < param2.SortIndex)
         {
            return -1;
         }
         if(param1.UpgradingLevel > param2.UpgradingLevel)
         {
            return -1;
         }
         if(param1.UpgradingLevel < param2.UpgradingLevel)
         {
            return 1;
         }
         if(param1.IDTemplate > param2.IDTemplate)
         {
            return -1;
         }
         if(param1.IDTemplate < param2.IDTemplate)
         {
            return 1;
         }
         return 0;
      }
      
      protected function SortFieldCopy(param1:TInventory, param2:TInventory) : int
      {
         if(param1.UpgradingLevel > param2.UpgradingLevel)
         {
            return -1;
         }
         if(param1.UpgradingLevel < param2.UpgradingLevel)
         {
            return 1;
         }
         if(param1.RequirementLevel > param2.RequirementLevel)
         {
            return -1;
         }
         if(param1.RequirementLevel < param2.RequirementLevel)
         {
            return 1;
         }
         if(param1.IDTemplate > param2.IDTemplate)
         {
            return -1;
         }
         if(param1.IDTemplate < param2.IDTemplate)
         {
            return 1;
         }
         return 0;
      }
      
      protected function GetBooByid64(param1:TInventory, param2:TInventory) : Boolean
      {
         if(param1.Identifier0 > param2.Identifier0)
         {
            return true;
         }
         if(param1.Identifier1 > param2.Identifier1)
         {
            return true;
         }
         return false;
      }
      
      public function Add(param1:TInventory) : void
      {
         param1.StubReferences.Reference(this);
         this.FInventories.push(param1);
      }
      
      public function GetInventoryByTempletID(param1:uint) : TInventory
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TInventory = null;
         _loc2_ = int(this.FInventories.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = this.FInventories[_loc3_];
            if(_loc4_.IDTemplate == param1)
            {
               return _loc4_;
            }
            _loc3_++;
         }
         return null;
      }
      
      public function GetInventoryByIdentifier(param1:uint, param2:uint) : TInventory
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:TInventory = null;
         _loc3_ = int(this.FInventories.length);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = this.FInventories[_loc4_];
            if(_loc5_.Identifier0 == param1 && _loc5_.Identifier1 == param2)
            {
               return _loc5_;
            }
            _loc4_++;
         }
         return null;
      }
      
      public function GetAllCountByTempletID(param1:uint) : uint
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:TInventory = null;
         var _loc2_:uint = 0;
         _loc3_ = int(this.FInventories.length);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = this.FInventories[_loc4_];
            if(_loc5_.IDTemplate == param1)
            {
               _loc2_ += _loc5_.Quantity;
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      public function DeleteInventoryByIdentifier(param1:uint, param2:uint) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:TInventory = null;
         _loc3_ = int(this.FInventories.length);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = this.FInventories[_loc4_];
            if(_loc5_.Identifier0 == param1 && _loc5_.Identifier1 == param2)
            {
               _loc5_.StubReferences.Dereference(this);
               this.FInventories.splice(_loc4_,1);
               break;
            }
            _loc4_++;
         }
      }
      
      public function DeleteInventoryByIndex(param1:uint) : void
      {
         var _loc2_:TInventory = null;
         _loc2_ = this.FInventories[param1];
         _loc2_.StubReferences.Dereference(this);
         this.FInventories.splice(param1,1);
      }
      
      public function DeleteInventoryByTempletID(param1:uint) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TInventory = null;
         _loc2_ = int(this.FInventories.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = this.FInventories[_loc3_];
            if(_loc4_.IDTemplate == param1)
            {
               _loc4_.StubReferences.Dereference(this);
               this.FInventories.splice(_loc3_,1);
               break;
            }
            _loc3_++;
         }
      }
      
      public function Clear() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TInventory = null;
         _loc1_ = int(this.FInventories.length);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this.FInventories[_loc2_];
            _loc3_.StubReferences.Dereference(this);
            _loc2_++;
         }
         this.FInventories.length = 0;
      }
      
      public function Sort() : void
      {
         this.FInventories.sort(this.SortField);
      }
      
      public function SortCopy() : void
      {
         this.FInventories.sort(this.SortFieldCopy);
      }
   }
}

