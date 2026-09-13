package Processors.Game.Lobby.FreshGuide
{
   import Foundation.Resources.*;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Processors.Game.Lobby.Common.*;
   import Resources.Constants.*;
   import flash.display.*;
   import flash.events.*;
   
   public class TWindowWelcome extends TProcessorLobbyWindow
   {
      
      protected var FStart_Btn:SimpleButton;
      
      protected var FOnClickBtn:Function;
      
      public function TWindowWelcome(param1:TUIComponent)
      {
         super(param1);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         var _loc1_:uint = 0;
         _loc1_ = uint(CONST_PLATE.GetWelcomeID());
         SResourcesCore.TexturesSwfLobby.LoadPrimary(_loc1_);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:Sprite = null;
         _loc1_ = TUtilityReflection.CreateDisplayObjectInstance("WelcomeView") as MovieClip;
         this.FStart_Btn = _loc1_["StartBtn"];
         this.addChild(_loc1_);
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.x = (CONST_COMMON.STAGE_Width - this.width) / 2;
         this.y = (CONST_COMMON.STAGE_Height - this.height) / 2;
         this.FStart_Btn.addEventListener(MouseEvent.CLICK,this.OnMouseClick);
         super.ResourcesPerform_UILocations();
      }
      
      private function OnMouseClick(param1:MouseEvent) : void
      {
         TutorialNextStep(1);
         this.visible = false;
         if(this.FOnClickBtn != null)
         {
            this.FOnClickBtn(this);
         }
      }
      
      public function set OnClickBtn(param1:Function) : void
      {
         this.FOnClickBtn = param1;
      }
   }
}

