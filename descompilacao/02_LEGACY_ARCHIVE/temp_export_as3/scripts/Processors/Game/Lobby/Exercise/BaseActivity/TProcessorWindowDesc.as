package Processors.Game.Lobby.Exercise.BaseActivity
{
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.Exercise.TBaseActivity;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Resources.Constants.CONST_COMMON;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorWindowDesc extends TProcessorLobbyWindow
   {
      
      protected static const SIZE_Window_Width:uint = 513;
      
      protected static const SIZE_Window_Height:uint = 323;
      
      protected var FMC_Scene:Sprite;
      
      protected var FBtn_Close:SimpleButton;
      
      protected var FTF_Desc:TextField;
      
      protected var FBaseActivity:TBaseActivity;
      
      protected var FInitialized:Boolean;
      
      protected var FOnCloseUp:Function;
      
      public function TProcessorWindowDesc(param1:TUIComponent)
      {
         super(param1);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(2550137121);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.graphics.beginFill(0,0.6);
         this.graphics.drawRect(0,0,CONST_COMMON.STAGE_Width,CONST_COMMON.STAGE_Height);
         this.graphics.endFill();
         this.FMC_Scene = TUtilityReflection.CreateDisplayObjectInstance("MC_BaseActiveDesc") as MovieClip;
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
      
      public function get BaseActivity() : TBaseActivity
      {
         return this.FBaseActivity;
      }
      
      public function set BaseActivity(param1:TBaseActivity) : void
      {
         this.FBaseActivity = param1;
      }
      
      public function UpdateUI(param1:String = "") : void
      {
         var _loc2_:String = null;
         if(param1 != "" && param1 != null)
         {
            this.FTF_Desc.text = param1;
         }
         else if(this.FBaseActivity)
         {
            if(Boolean(this.FBaseActivity.ActivityDesc) && this.FBaseActivity.ActivityDesc != "")
            {
               _loc2_ = this.FBaseActivity.ActivityDesc.split("%n").join("\n");
            }
            else if(Boolean(this.FBaseActivity.DescListNew[0]) && this.FBaseActivity.DescListNew[0] != "")
            {
               _loc2_ = this.FBaseActivity.DescListNew[0].split("%n").join("\n");
            }
            this.FTF_Desc.text = _loc2_;
         }
      }
   }
}

