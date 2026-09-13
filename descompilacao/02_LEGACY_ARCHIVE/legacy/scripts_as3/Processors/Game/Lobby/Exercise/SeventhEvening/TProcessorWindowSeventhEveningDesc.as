package Processors.Game.Lobby.Exercise.SeventhEvening
{
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.Exercise.SeventhEvening.TSeventhEvening;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_SEVENTHEVENING;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorWindowSeventhEveningDesc extends TProcessorLobbyWindow
   {
      
      protected static const SIZE_Window_Width:uint = 422;
      
      protected static const SIZE_Window_Height:uint = 210;
      
      protected var FMC_Scene:Sprite;
      
      protected var FBtn_Close:SimpleButton;
      
      protected var FTF_Desc:TextField;
      
      protected var FInitialized:Boolean;
      
      protected var FSeventhEvening:TSeventhEvening;
      
      protected var FOnCloseUp:Function;
      
      public function TProcessorWindowSeventhEveningDesc(param1:TUIComponent)
      {
         super(param1);
         this.FSeventhEvening = SLogicsCore.SeventhEvening;
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_SEVENTHEVENING.RESOURCESID_SWF_SEVENTHEVENING);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.graphics.beginFill(0,0.6);
         this.graphics.drawRect(0,0,CONST_COMMON.STAGE_Width,CONST_COMMON.STAGE_Height);
         this.graphics.endFill();
         this.FMC_Scene = TUtilityReflection.CreateDisplayObjectInstance(CONST_SEVENTHEVENING.RESOURCE_ClassName_MC_SeventhEveningDesc) as MovieClip;
         addChild(this.FMC_Scene);
         this.FBtn_Close = this.FMC_Scene["Btn_Close"];
         this.FMC_Scene.x = CONST_COMMON.STAGE_Width - SIZE_Window_Width >> 1;
         this.FMC_Scene.y = CONST_COMMON.STAGE_Height - SIZE_Window_Height >> 1;
         this.FTF_Desc = this.FMC_Scene["TF_Desc"];
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FBtn_Close.addEventListener(MouseEvent.CLICK,this.ProcessorOnClose);
         super.ResourcesPerform_UILocations();
      }
      
      private function ProcessorOnClose(param1:MouseEvent) : void
      {
         if(this.FOnCloseUp != null)
         {
            this.FOnCloseUp();
         }
      }
      
      public function get OnCloseUp() : Function
      {
         return this.FOnCloseUp;
      }
      
      public function set OnCloseUp(param1:Function) : void
      {
         this.FOnCloseUp = param1;
      }
      
      public function UpdateUI() : void
      {
         this.FTF_Desc.text = this.FSeventhEvening.ActivityDesc;
      }
   }
}

