package Processors.Game.Lobby.Exercise.GroupBuying
{
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Windows.*;
   import Resources.Constants.*;
   import flash.display.*;
   import flash.events.*;
   import flash.text.*;
   
   public class TUIWindowConfirmationSign extends TProcessorLobbyWindow
   {
      
      protected static const SIZE_Window_Width:uint = 310;
      
      protected static const SIZE_Window_Height:uint = 190;
      
      protected var FMC_Scene:MovieClip;
      
      protected var FBtn_Ok:MovieClip;
      
      protected var FOnOK:Function;
      
      protected var FOnCancel:Function;
      
      public function TUIWindowConfirmationSign(param1:TUIComponent)
      {
         super(param1);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_BASEACTIVITY.NEW_ACTIVELIST_RESOURCESID[CONST_BASEACTIVITY.TYPE_NewActiveList_GroupBuying - 16]);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.graphics.beginFill(0,0.6);
         this.graphics.drawRect(0,0,CONST_COMMON.STAGE_Width,CONST_COMMON.STAGE_Height);
         this.graphics.endFill();
         this.FMC_Scene = TUtilityReflection.CreateDisplayObjectInstance("MC_GroupBuyingSignSuccess") as MovieClip;
         addChild(this.FMC_Scene);
         this.FBtn_Ok = this.FMC_Scene.Btn_Ok;
         TGameUtil.setButtonMode(this.FBtn_Ok,true);
         this.FMC_Scene.x = CONST_COMMON.STAGE_Width - SIZE_Window_Width >> 1;
         this.FMC_Scene.y = CONST_COMMON.STAGE_Height - SIZE_Window_Height >> 1;
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FMC_Scene.Btn_Close.addEventListener(MouseEvent.CLICK,this.ButtonCloseOnClick);
         this.FBtn_Ok.addEventListener(MouseEvent.CLICK,this.ButtonOKOnClick);
         super.ResourcesPerform_UILocations();
      }
      
      protected function ButtonOKOnClick(param1:MouseEvent) : void
      {
         if(this.FOnOK != null)
         {
            this.FOnOK(this);
         }
         Visible = false;
      }
      
      protected function ButtonCloseOnClick(param1:MouseEvent) : void
      {
         if(this.FOnCancel != null)
         {
            this.FOnCancel(this);
         }
         Visible = false;
      }
      
      public function get WindowWidth() : int
      {
         return SIZE_Window_Width;
      }
      
      public function get WindowHeight() : int
      {
         return SIZE_Window_Height;
      }
      
      public function get OnOK() : Function
      {
         return this.FOnOK;
      }
      
      public function set OnOK(param1:Function) : void
      {
         this.FOnOK = param1;
      }
      
      public function set Text(param1:String) : void
      {
         this.FMC_Scene.TF_Text.text = param1;
      }
   }
}

