package Processors.Game.Lobby.Exercise.FishGame
{
   import Foundation.Common.Stubs.TStubReferences;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Logics.Exercise.FishGame.TFish;
   import Resources.Constants.CONST_MODULES;
   import flash.display.Bitmap;
   
   public class TFishGameFish extends TUIComponent
   {
      
      protected var FFishBitmap:Bitmap;
      
      protected var FFishInfo:TFish;
      
      protected var FCurX:int;
      
      protected var FCurY:int;
      
      protected var FStubReferences:TStubReferences;
      
      public function TFishGameFish(param1:TUIComponent, param2:TFish)
      {
         super(param1);
         this.FStubReferences = new TStubReferences(this);
         this.FFishBitmap = new Bitmap();
         addChild(this.FFishBitmap);
         this.FFishInfo = param2;
      }
      
      protected function UpdateFishEffect() : void
      {
         TGameUtil.ShowAnimationByID(TGameUtil.Type_FollowBloodBound,this.FFishBitmap,CONST_MODULES.ACTIVE_FishGameFish,65521 + this.FFishInfo.Identify);
         this.FFishBitmap.x = this.FFishInfo.CurX;
         this.FFishBitmap.y = this.FFishInfo.CurY;
      }
      
      public function get StubReferences() : TStubReferences
      {
         return this.FStubReferences;
      }
      
      public function LogicsPerform() : void
      {
         this.FFishInfo.Move();
         if(this.FFishInfo.IsOutOfScree())
         {
            this.Release();
         }
         else
         {
            this.UpdateFishEffect();
         }
      }
      
      public function Release() : void
      {
         if(parent)
         {
            parent.removeChild(this);
         }
         SResourcesCore.PerformAutoReleaseResources(CONST_MODULES.ACTIVE_FishGameFish);
      }
   }
}

