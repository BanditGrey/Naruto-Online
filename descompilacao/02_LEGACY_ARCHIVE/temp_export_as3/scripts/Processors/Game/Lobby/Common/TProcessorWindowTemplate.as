package Processors.Game.Lobby.Common
{
   import Foundation.Common.THint;
   import Foundation.UI.TUIComponent;
   import Resources.Constants.CONST_COMMON;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class TProcessorWindowTemplate extends TProcessorLobbyWindow
   {
      
      protected var FBTN_Close:SimpleButton;
      
      protected var FBTN_Help:SimpleButton;
      
      protected var FMainUI:Sprite;
      
      protected var FHelpTips:THint;
      
      protected var FOnHelpTipsOver:Function;
      
      protected var FOnHelpTipsOut:Function;
      
      public function TProcessorWindowTemplate(param1:TUIComponent)
      {
         super(param1);
         this.FHelpTips = new THint();
      }
      
      protected function UIDispatch() : void
      {
         this.FMainUI.x = (CONST_COMMON.STAGE_Width - this.FMainUI.width) / 2;
         this.FMainUI.y = (CONST_COMMON.STAGE_Height - this.FMainUI.height) / 2;
         addChild(this.FMainUI);
         this.FBTN_Close = this.FMainUI["BTN_Close"];
         this.FBTN_Help = this.FMainUI["BTN_Help"];
         super.ResourcesPerform_UIDispatch();
      }
      
      protected function UILocations() : void
      {
         if(this.FBTN_Close != null)
         {
            this.FBTN_Close.addEventListener(MouseEvent.CLICK,this.ButtonCloseOnClick,false,0,true);
         }
         if(this.FBTN_Help != null)
         {
            this.FBTN_Help.addEventListener(MouseEvent.MOUSE_MOVE,this.ButtonHelpOnOver,false,0,true);
            this.FBTN_Help.addEventListener(MouseEvent.MOUSE_OUT,this.ButtonHelpOnOut,false,0,true);
         }
         super.ResourcesPerform_UILocations();
      }
      
      protected function ButtonCloseOnClick(param1:MouseEvent) : void
      {
         ProcessorWindowClose();
      }
      
      protected function ButtonHelpOnOver(param1:MouseEvent) : void
      {
         if(this.FOnHelpTipsOver != null)
         {
            this.FOnHelpTipsOver(this,this.FHelpTips);
         }
      }
      
      protected function ButtonHelpOnOut(param1:MouseEvent) : void
      {
         if(this.FOnHelpTipsOut != null)
         {
            this.FOnHelpTipsOut(this);
         }
      }
      
      public function get OnHelpTipsOver() : Function
      {
         return this.FOnHelpTipsOver;
      }
      
      public function set OnHelpTipsOver(param1:Function) : void
      {
         this.FOnHelpTipsOver = param1;
      }
      
      public function get OnHelpTipsOut() : Function
      {
         return this.FOnHelpTipsOut;
      }
      
      public function set OnHelpTipsOut(param1:Function) : void
      {
         this.FOnHelpTipsOut = param1;
      }
   }
}

