package Logics.TopOrganization
{
   import Foundation.Pools.TPoolAutomatic;
   import Foundation.UI.TUIComponent;
   import Processors.Game.Lobby.TopOrganization.Componets.TUISingleMember;
   
   public class TPoolUIOrgMember extends TPoolAutomatic
   {
      
      protected var FIndexUIOrgMember:int;
      
      public function TPoolUIOrgMember()
      {
         super();
      }
      
      override protected function RegisterClasses() : void
      {
         this.FIndexUIOrgMember = RegisterClass(TUISingleMember,this.ReleaseUI);
      }
      
      protected function ReleaseUI(param1:TUISingleMember) : void
      {
         param1.Reset();
      }
      
      public function AcquireUISingleMember(param1:TUIComponent) : TUISingleMember
      {
         var _loc2_:TUISingleMember = null;
         _loc2_ = InstanceAcquireByIndex(this.FIndexUIOrgMember) as TUISingleMember;
         if(_loc2_ == null)
         {
            _loc2_ = new TUISingleMember(param1);
         }
         FStubsReferences.push(_loc2_.StubReferences);
         return _loc2_;
      }
   }
}

