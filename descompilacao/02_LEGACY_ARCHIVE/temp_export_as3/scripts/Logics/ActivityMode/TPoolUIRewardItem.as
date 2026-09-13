package Logics.ActivityMode
{
   import Foundation.Pools.TPoolAutomatic;
   import Foundation.UI.TUIComponent;
   import Processors.Game.Lobby.Recharge.Components.TUIRewardItem;
   
   public class TPoolUIRewardItem extends TPoolAutomatic
   {
      
      protected var FIndexUIRewardItem:int;
      
      public function TPoolUIRewardItem()
      {
         super();
      }
      
      override protected function RegisterClasses() : void
      {
         this.FIndexUIRewardItem = RegisterClass(TUIRewardItem,this.ReleaseUI);
      }
      
      protected function ReleaseUI(param1:TUIRewardItem) : void
      {
         param1.Release();
      }
      
      public function AcquireUIRewardItem(param1:TUIComponent) : TUIRewardItem
      {
         var _loc2_:TUIRewardItem = null;
         _loc2_ = InstanceAcquireByIndex(this.FIndexUIRewardItem) as TUIRewardItem;
         if(_loc2_ == null)
         {
            _loc2_ = new TUIRewardItem(param1);
         }
         FStubsReferences.push(_loc2_.StubReferences);
         return _loc2_;
      }
   }
}

