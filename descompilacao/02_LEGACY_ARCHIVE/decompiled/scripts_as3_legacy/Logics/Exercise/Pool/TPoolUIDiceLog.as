package Logics.Exercise.Pool
{
   import Foundation.Pools.TPoolAutomatic;
   import Foundation.UI.TUIComponent;
   import Processors.Game.Lobby.Exercise.Dice.Compoents.TUIAutoLog;
   
   public class TPoolUIDiceLog extends TPoolAutomatic
   {
      
      protected var FIndexUINews:int;
      
      public function TPoolUIDiceLog()
      {
         super();
      }
      
      override protected function RegisterClasses() : void
      {
         this.FIndexUINews = RegisterClass(TUIAutoLog,this.ReleaseUI);
      }
      
      protected function ReleaseUI(param1:TUIAutoLog) : void
      {
         param1.Release();
      }
      
      public function AcquireUITaskItem(param1:TUIComponent) : TUIAutoLog
      {
         var _loc2_:TUIAutoLog = null;
         _loc2_ = InstanceAcquireByIndex(this.FIndexUINews) as TUIAutoLog;
         if(_loc2_ == null)
         {
            _loc2_ = new TUIAutoLog(param1);
         }
         FStubsReferences.push(_loc2_.StubReferences);
         return _loc2_;
      }
   }
}

