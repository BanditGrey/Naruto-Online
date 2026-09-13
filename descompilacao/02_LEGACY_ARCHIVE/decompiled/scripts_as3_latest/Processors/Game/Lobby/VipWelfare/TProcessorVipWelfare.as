package Processors.Game.Lobby.VipWelfare
{
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   
   public class TProcessorVipWelfare extends TProcessorLobbyWindows
   {
      
      protected var FBTN_Close:SimpleButton;
      
      public function TProcessorVipWelfare(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(2550137203);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:MovieClip = null;
         _loc1_ = TUtilityReflection.CreateDisplayObjectInstance("MC_vipWelfare") as MovieClip;
         addChild(_loc1_);
         this.x = FUICore.stage.stageWidth - this.width >> 1;
         this.y = FUICore.stage.stageHeight - this.height >> 1;
         this.FBTN_Close = _loc1_["BTN_Close"];
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
         this.FBTN_Close.addEventListener(MouseEvent.CLICK,this.onBtnClose);
      }
      
      protected function onBtnClose(param1:MouseEvent) : void
      {
         ProcessorClose();
      }
   }
}

