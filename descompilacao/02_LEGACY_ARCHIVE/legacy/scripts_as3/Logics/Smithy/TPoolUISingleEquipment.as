package Logics.Smithy
{
   import Foundation.Pools.TPoolAutomatic;
   import Foundation.UI.TUIComponent;
   import Processors.Game.Lobby.Talisman.TSingleEquip;
   
   public class TPoolUISingleEquipment extends TPoolAutomatic
   {
      
      protected var FIndexUISingleEquipment:int;
      
      public function TPoolUISingleEquipment()
      {
         super();
      }
      
      override protected function RegisterClasses() : void
      {
         this.FIndexUISingleEquipment = RegisterClass(TSingleEquip,this.ReleaseUI);
      }
      
      protected function ReleaseUI(param1:TSingleEquip) : void
      {
         param1.Release();
      }
      
      public function AcquireUISingleEquipment(param1:TUIComponent, param2:String = null) : TSingleEquip
      {
         var _loc3_:TSingleEquip = null;
         _loc3_ = InstanceAcquireByIndex(this.FIndexUISingleEquipment) as TSingleEquip;
         if(_loc3_ == null)
         {
            _loc3_ = new TSingleEquip(param1,param2);
         }
         FStubsReferences.push(_loc3_.StubReferences);
         return _loc3_;
      }
   }
}

