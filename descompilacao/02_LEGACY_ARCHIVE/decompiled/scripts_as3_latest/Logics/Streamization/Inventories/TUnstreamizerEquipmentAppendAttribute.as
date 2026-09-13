package Logics.Streamization.Inventories
{
   import Foundation.Resources.Bins.*;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Streamization.*;
   import Logics.DatebaseVO.VO.*;
   import Logics.Inventories.*;
   import Resources.Constants.*;
   import Resources.Strings.*;
   import flash.utils.*;
   
   public class TUnstreamizerEquipmentAppendAttribute extends TUnstreamizerInventoryUnknown
   {
      
      public static const BASEATTRIBUTENAMES:Vector.<uint> = CONST_COMMON.BASEATTRIBUTENAMES;
      
      public static const STRINGS_BASEATTRIBUTENAMES:Vector.<String> = STRING_COMMON.STRINGS_BASEATTRIBUTENAMES;
      
      public function TUnstreamizerEquipmentAppendAttribute()
      {
         super();
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform_Properties(param1,param2,param3);
         this.UnstreamizationPerform_AppendAttributePropertiesByDatabase(param2,param3);
      }
      
      protected function UnstreamizationPerform_Properties(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:TEquipmentAppendAttribute = null;
         _loc4_ = param2 as TEquipmentAppendAttribute;
         _loc4_.Identifier = param1.readUnsignedInt();
         _loc4_.Category = param1.readUnsignedInt();
         _loc4_.Value = param1.readUnsignedShort();
      }
      
      protected function UnstreamizationPerform_AppendAttributePropertiesByDatabase(param1:Object, param2:Object) : void
      {
         var _loc3_:int = 0;
         var _loc4_:TBins = null;
         var _loc5_:TEquipAdditional = null;
         var _loc6_:TEquipmentAppendAttribute = null;
         _loc6_ = param1 as TEquipmentAppendAttribute;
         if(_loc6_.Identifier == 0)
         {
            return;
         }
         _loc5_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_EquipAdditional,_loc6_.Identifier) as TEquipAdditional;
         _loc3_ = BASEATTRIBUTENAMES.indexOf(_loc5_.Category);
         if(_loc3_ >= 0)
         {
            _loc6_.Name = STRINGS_BASEATTRIBUTENAMES[_loc3_];
         }
         else
         {
            _loc6_.Name = "";
         }
         _loc6_.Sort = _loc5_.SortNumber;
         _loc6_.Divisor = _loc5_.Divisor;
         _loc6_.Percentage = _loc5_.Percentage;
         _loc6_.MaxValue = _loc5_.MaxValue;
         _loc6_.MinValue = _loc5_.MinValue;
      }
      
      public function UnstreamizationAppendAttributePropertiesByDatabase(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform_AppendAttributePropertiesByDatabase(param2,param3);
      }
   }
}

