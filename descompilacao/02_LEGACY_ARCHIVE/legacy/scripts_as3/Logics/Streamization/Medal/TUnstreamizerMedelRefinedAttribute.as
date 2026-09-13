package Logics.Streamization.Medal
{
   import Logics.Inventories.TEquipmentAppendAttribute;
   import Logics.Medal.TMedalRefinedPakcetUnstreamizerData;
   import Logics.Streamization.Inventories.TUnstreamizerMedalAppendAttribute;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerMedelRefinedAttribute
   {
      
      protected var UnstreamizerMedalAppendAttribute:TUnstreamizerMedalAppendAttribute;
      
      protected var AppendAttribute:TEquipmentAppendAttribute;
      
      public function TUnstreamizerMedelRefinedAttribute()
      {
         super();
         this.UnstreamizerMedalAppendAttribute = new TUnstreamizerMedalAppendAttribute();
      }
      
      protected function UnstreamizationPerform_StrengthenAttributes(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:TMedalRefinedPakcetUnstreamizerData = null;
         var _loc5_:TEquipmentAppendAttribute = null;
         _loc4_ = param2 as TMedalRefinedPakcetUnstreamizerData;
         _loc4_.RefinedType = param1.readUnsignedInt();
         _loc4_.RefinedIndex = param1.readUnsignedInt();
         _loc4_.EquipmentAppendAttribute.Identifier = param1.readUnsignedInt();
         this.UnstreamizerMedalAppendAttribute.UnstreamizationPerform_AppendAttributePropertiesByDatabase(_loc4_.EquipmentAppendAttribute,null);
      }
      
      public function UnstreamizeStrengthenAttributes(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform_StrengthenAttributes(param1,param2,param3);
      }
   }
}

