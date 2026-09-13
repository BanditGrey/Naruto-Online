package Logics.Lottery
{
   import Foundation.Pools.TPoolAutomatic;
   import Foundation.UI.TUIComponent;
   import Processors.Game.Lobby.Lottery.Components.TUILotteryNews;
   
   public class TPoolUILotteryNews extends TPoolAutomatic
   {
      
      protected var FIndexUILotteryNews:int;
      
      public function TPoolUILotteryNews()
      {
         super();
      }
      
      override protected function RegisterClasses() : void
      {
         this.FIndexUILotteryNews = RegisterClass(TUILotteryNews,this.ReleaseUI);
      }
      
      protected function ReleaseUI(param1:TUILotteryNews) : void
      {
         param1.Release();
      }
      
      public function AcquireUITaskItem(param1:TUIComponent) : TUILotteryNews
      {
         var _loc2_:TUILotteryNews = null;
         _loc2_ = InstanceAcquireByIndex(this.FIndexUILotteryNews) as TUILotteryNews;
         if(_loc2_ == null)
         {
            _loc2_ = new TUILotteryNews(param1);
         }
         FStubsReferences.push(_loc2_.StubReferences);
         return _loc2_;
      }
   }
}

