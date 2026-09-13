package Processors.Game.Lobby.Common
{
   import Foundation.UI.TUIComponent;
   import Logics.SLogicsCore;
   import Processors.Game.Common.Effects.Texts.TEffectCoordinateParameters;
   import Processors.Game.Common.Effects.Texts.TEffectTextParameters;
   import Processors.Game.TProcessorGame;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_SIGNAL;
   
   public class TProcessorLobbyWindow extends TProcessorGame
   {
      
      protected static const STAGE_Width:int = CONST_COMMON.STAGE_Width;
      
      protected static const STAGE_Height:int = CONST_COMMON.STAGE_Height;
      
      protected var FNCMoving:Boolean;
      
      protected var FMovable:Boolean;
      
      protected var FOnClose:Function;
      
      protected var FOnEffectText:Function;
      
      public function TProcessorLobbyWindow(param1:TUIComponent)
      {
         super(param1);
         Visible = false;
      }
      
      override protected function RevokeInteraction() : void
      {
         super.RevokeInteraction();
         this.FNCMoving = false;
      }
      
      protected function ProcessorWindowClose() : void
      {
         if(this.FOnClose != null)
         {
            this.FOnClose(this);
         }
         Visible = false;
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         super.ResourcesPerform_UIDispatch();
      }
      
      protected function ResourcesPerform_RequestDefault() : void
      {
      }
      
      protected function ResourcesPerform_DispatchDefault() : void
      {
      }
      
      protected function InteractionEnable() : void
      {
      }
      
      protected function InteractionDisable() : void
      {
      }
      
      protected function EffectGenerateText(param1:String, param2:TEffectTextParameters = null, param3:TEffectCoordinateParameters = null) : void
      {
         if(this.FOnEffectText != null)
         {
            this.FOnEffectText(this,param1,param2,param3);
         }
      }
      
      protected function TutorialNextStep(param1:uint) : void
      {
         SLogicsCore.SignalPost(CONST_SIGNAL.SIGNALDESTINATION_LobbyTutorial,param1);
      }
      
      protected function NCButtonCloseOnClick(param1:Object) : void
      {
         this.ProcessorWindowClose();
      }
      
      public function get Movable() : Boolean
      {
         return this.FMovable;
      }
      
      public function set Movable(param1:Boolean) : void
      {
         this.FMovable = param1;
      }
      
      public function get OnClose() : Function
      {
         return this.FOnClose;
      }
      
      public function set OnClose(param1:Function) : void
      {
         this.FOnClose = param1;
      }
      
      public function get OnEffectText() : Function
      {
         return this.FOnEffectText;
      }
      
      public function set OnEffectText(param1:Function) : void
      {
         this.FOnEffectText = param1;
      }
      
      public function Close() : void
      {
         if(Visible)
         {
            this.ProcessorWindowClose();
         }
      }
      
      public function Suspend() : void
      {
         this.InteractionDisable();
      }
      
      public function Resume() : void
      {
         this.InteractionEnable();
      }
   }
}

