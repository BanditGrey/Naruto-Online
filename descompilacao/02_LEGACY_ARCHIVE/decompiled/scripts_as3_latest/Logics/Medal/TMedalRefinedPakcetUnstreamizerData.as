package Logics.Medal
{
   import Logics.Inventories.TEquipment;
   import Logics.Inventories.TEquipmentAppendAttribute;
   
   public class TMedalRefinedPakcetUnstreamizerData
   {
      
      protected var FResultCode:uint;
      
      protected var FRefinedID:uint;
      
      protected var FRefinedType:uint;
      
      protected var FRefinedIndex:uint;
      
      public var EquipmentAppendAttribute:TEquipmentAppendAttribute;
      
      public function TMedalRefinedPakcetUnstreamizerData()
      {
         super();
         this.EquipmentAppendAttribute = new TEquipmentAppendAttribute();
      }
      
      public function get RefinedID() : uint
      {
         return this.FRefinedID;
      }
      
      public function set RefinedID(param1:uint) : void
      {
         this.FRefinedID = param1;
      }
      
      public function get ResultCode() : uint
      {
         return this.FResultCode;
      }
      
      public function set ResultCode(param1:uint) : void
      {
         this.FResultCode = param1;
      }
      
      public function get RefinedType() : uint
      {
         return this.FRefinedType;
      }
      
      public function set RefinedType(param1:uint) : void
      {
         this.FRefinedType = param1;
      }
      
      public function get RefinedIndex() : uint
      {
         return this.FRefinedIndex;
      }
      
      public function set RefinedIndex(param1:uint) : void
      {
         this.FRefinedIndex = param1;
      }
      
      public function UpdataRefinedAttributeDataByIndex(param1:TEquipment, param2:int) : void
      {
         var _loc3_:TEquipmentAppendAttribute = null;
         var _loc4_:Vector.<TEquipmentAppendAttribute> = null;
         var _loc5_:int = 0;
         _loc5_ = param1.AppendAttributes.Count;
         if(param2 > _loc5_)
         {
            param1.AppendAttributes.Count = param2;
         }
         _loc4_ = param1.AppendAttributes.Attributes;
         if(_loc4_[param2 - 1] == null)
         {
            _loc3_ = new TEquipmentAppendAttribute();
            _loc3_.StubReferences.Reference(this);
            param1.AppendAttributes.Attributes[param2 - 1] = _loc3_;
         }
         else
         {
            _loc3_ = _loc4_[param2 - 1];
         }
         if(this.ResultCode == 0)
         {
            if(this.RefinedType == 1)
            {
               _loc3_.NewCategory = this.EquipmentAppendAttribute.Name;
               _loc3_.NewValue = this.EquipmentAppendAttribute.OldValue;
            }
            else
            {
               _loc3_.Name = this.EquipmentAppendAttribute.Name;
               _loc3_.OldValue = this.EquipmentAppendAttribute.OldValue;
               _loc3_.NewCategory = null;
               _loc3_.NewValue = 0;
            }
         }
      }
   }
}

