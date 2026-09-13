package Logics.Inventories
{
   import Foundation.Pools.TPoolAutomatic;
   import Logics.Spaces.LogicsSpace;
   
   use namespace LogicsSpace;
   
   public class TPoolInventory extends TPoolAutomatic
   {
      
      protected var FIndexInventorySample:int;
      
      protected var FIndexEquipment:int;
      
      protected var FIndexEquipmentAppendAttribute:int;
      
      protected var FIndexSuitEffect:int;
      
      protected var FIndexAppliance:int;
      
      public function TPoolInventory()
      {
         super();
      }
      
      override protected function RegisterClasses() : void
      {
         this.FIndexEquipment = RegisterClass(TEquipment,this.ReleasingPerform_Equipment);
         this.FIndexAppliance = RegisterClass(TAppliance,this.ReleasingPerform_Appliance);
         this.FIndexEquipmentAppendAttribute = RegisterClass(TEquipmentAppendAttribute);
         this.FIndexSuitEffect = RegisterClass(TSuitEffect);
      }
      
      protected function ReleasingPerform_Equipment(param1:Object) : void
      {
         var _loc2_:TEquipment = null;
         _loc2_ = param1 as TEquipment;
         _loc2_.Reset();
      }
      
      protected function ReleasingPerform_Appliance(param1:Object) : void
      {
         var _loc2_:TAppliance = null;
         _loc2_ = param1 as TAppliance;
         _loc2_.Reset();
      }
      
      public function AcquireInventorySample() : TInventorySample
      {
         var _loc1_:TInventorySample = null;
         _loc1_ = InstanceAcquireByIndex(this.FIndexInventorySample) as TInventorySample;
         if(_loc1_ == null)
         {
            _loc1_ = new TInventorySample();
         }
         FStubsReferences.push(_loc1_.StubReferences);
         return _loc1_;
      }
      
      public function AcquireEquipment(param1:uint = 0, param2:uint = 0) : TEquipment
      {
         var _loc3_:TEquipment = null;
         _loc3_ = InstanceAcquireByIndex(this.FIndexEquipment) as TEquipment;
         if(_loc3_ != null)
         {
            _loc3_.Coerce(param1,param2);
         }
         else
         {
            _loc3_ = new TEquipment(param1,param2);
         }
         FStubsReferences.push(_loc3_.StubReferences);
         return _loc3_;
      }
      
      public function AcquireEquipmentAppendAttribute() : TEquipmentAppendAttribute
      {
         var _loc1_:TEquipmentAppendAttribute = null;
         _loc1_ = InstanceAcquireByIndex(this.FIndexEquipmentAppendAttribute) as TEquipmentAppendAttribute;
         if(_loc1_ == null)
         {
            _loc1_ = new TEquipmentAppendAttribute();
         }
         FStubsReferences.push(_loc1_.StubReferences);
         return _loc1_;
      }
      
      public function AcquireAppliance(param1:uint = 0, param2:uint = 0) : TAppliance
      {
         var _loc3_:TAppliance = null;
         _loc3_ = InstanceAcquireByIndex(this.FIndexAppliance) as TAppliance;
         if(_loc3_ != null)
         {
            _loc3_.Coerce(param1,param2);
         }
         else
         {
            _loc3_ = new TAppliance(param1,param2);
         }
         FStubsReferences.push(_loc3_.StubReferences);
         return _loc3_;
      }
      
      public function AcquireSuitEffect() : TSuitEffect
      {
         var _loc1_:TSuitEffect = null;
         _loc1_ = InstanceAcquireByIndex(this.FIndexSuitEffect) as TSuitEffect;
         if(_loc1_ == null)
         {
            _loc1_ = new TSuitEffect();
         }
         FStubsReferences.push(_loc1_.StubReferences);
         return _loc1_;
      }
   }
}

