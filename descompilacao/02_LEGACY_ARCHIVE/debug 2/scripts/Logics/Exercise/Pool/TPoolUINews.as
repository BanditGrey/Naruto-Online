package Logics.Exercise.Pool
{
   import Foundation.Pools.TPoolAutomatic;
   import Foundation.UI.TUIComponent;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseNews;
   
   public class TPoolUINews extends TPoolAutomatic
   {
      
      protected var FIndexUINews:int;
      
      public function TPoolUINews()
      {
         super();
      }
      
      override protected function RegisterClasses() : void
      {
         this.FIndexUINews = RegisterClass(TUIBaseNews,this.ReleaseUI);
      }
      
      protected function ReleaseUI(param1:TUIBaseNews) : void
      {
         param1.Release();
      }
      
      public function AcquireUITaskItem(param1:TUIComponent) : TUIBaseNews
      {
         var _loc2_:TUIBaseNews = null;
         _loc2_ = InstanceAcquireByIndex(this.FIndexUINews) as TUIBaseNews;
         if(_loc2_ == null)
         {
            _loc2_ = new TUIBaseNews(param1);
         }
         FStubsReferences.push(_loc2_.StubReferences);
         return _loc2_;
      }
   }
}

