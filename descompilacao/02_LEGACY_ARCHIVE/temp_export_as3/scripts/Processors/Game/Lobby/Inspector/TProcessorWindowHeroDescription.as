package Processors.Game.Lobby.Inspector
{
   import Foundation.UI.TUIComponent;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.Tavern.TProcessorWindowRecruit;
   import Resources.Constants.CONST_COMMON;
   
   public class TProcessorWindowHeroDescription extends TProcessorLobbyWindow
   {
      
      protected static const Window_Width:int = 409;
      
      protected static const Window_Height:int = 379;
      
      protected var FWindowRecruit:TProcessorWindowRecruit;
      
      public function TProcessorWindowHeroDescription(param1:TUIComponent)
      {
         super(param1);
         this.FWindowRecruit = new TProcessorWindowRecruit(this);
      }
      
      override protected function LogicsPerform() : void
      {
         if(this.FWindowRecruit.visible)
         {
            this.FWindowRecruit.UpdataBitmap();
         }
         super.LogicsPerform();
      }
      
      public function UIDispatch() : void
      {
         this.FWindowRecruit.Load();
      }
      
      public function UILocation() : void
      {
         this.FWindowRecruit.x = (CONST_COMMON.STAGE_Width - Window_Width) / 2;
         this.FWindowRecruit.y = (CONST_COMMON.STAGE_Height - Window_Height) / 2;
         this.FWindowRecruit.visible = false;
      }
      
      public function set HeroID(param1:uint) : void
      {
         this.FWindowRecruit.SetHeroData(param1);
         this.visible = true;
      }
      
      public function set HintOnOver(param1:Function) : void
      {
         this.FWindowRecruit.HintOnOver = param1;
      }
      
      public function set HintOnOut(param1:Function) : void
      {
         this.FWindowRecruit.HintOnOut = param1;
      }
      
      public function Hide() : void
      {
         this.visible = false;
      }
   }
}

