package Logics.Exercise.FishGame
{
   import Foundation.Pools.TPoolAutomatic;
   import Foundation.UI.TUIComponent;
   import Processors.Game.Lobby.Exercise.FishGame.TFishGameFish;
   
   public class TPoolUIFish extends TPoolAutomatic
   {
      
      protected var FIndexUINews:int;
      
      public function TPoolUIFish()
      {
         super();
      }
      
      override protected function RegisterClasses() : void
      {
         this.FIndexUINews = RegisterClass(TFishGameFish,this.ReleaseUI);
      }
      
      protected function ReleaseUI(param1:TFishGameFish) : void
      {
         param1.Release();
      }
      
      public function AcquireUITaskItem(param1:TUIComponent, param2:TFish) : TFishGameFish
      {
         var _loc3_:TFishGameFish = null;
         _loc3_ = InstanceAcquireByIndex(this.FIndexUINews) as TFishGameFish;
         if(_loc3_ == null)
         {
            _loc3_ = new TFishGameFish(param1,param2);
         }
         FStubsReferences.push(_loc3_.StubReferences);
         return _loc3_;
      }
   }
}

