package Logics.Streamization.Inventories
{
   import Debugging.*;
   import Foundation.Streamization.*;
   import Logics.Inventories.*;
   import flash.utils.*;
   
   public class TUnstreamizerMedalAppendAttributes extends TUnstreamizerInventoryUnknown
   {
      
      protected var FUnstreamizerAppendAttribute:TUnstreamizerMedalAppendAttribute;
      
      public function TUnstreamizerMedalAppendAttributes()
      {
         super();
         this.FUnstreamizerAppendAttribute = new TUnstreamizerMedalAppendAttribute();
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform_AppendAttributes(param1,param2,param3);
      }
      
      protected function UnstreamizationPerform_AppendAttributes(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:TEquipmentAppendAttribute = null;
         var _loc7_:TEquipmentAppendAttributes = null;
         _loc7_ = param2 as TEquipmentAppendAttributes;
         _loc7_.Clear();
         _loc7_.Count = 4;
         _loc4_ = int(param1.readUnsignedShort());
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc6_ = FPoolInventory.AcquireEquipmentAppendAttribute();
            _loc6_.StubReferences.Reference(_loc7_);
            this.FUnstreamizerAppendAttribute.Unstreamize(param1,_loc6_,param3);
            if(_loc6_.RefineIndex != 0)
            {
               _loc7_.Attributes[_loc6_.RefineIndex - 1] = _loc6_;
            }
            _loc5_++;
         }
      }
   }
}

