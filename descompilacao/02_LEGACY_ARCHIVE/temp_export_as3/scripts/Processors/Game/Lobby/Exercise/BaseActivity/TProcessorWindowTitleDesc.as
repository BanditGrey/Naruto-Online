package Processors.Game.Lobby.Exercise.BaseActivity
{
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseBox;
   import Resources.Constants.CONST_COMMON;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class TProcessorWindowTitleDesc extends TProcessorLobbyWindow
   {
      
      protected static const SIZE_Window_Width:uint = 299;
      
      protected static const SIZE_Window_Height:uint = 338;
      
      protected static const RANK_LEVEL:int = 3;
      
      protected var FMC_Scene:Sprite;
      
      protected var FBtn_Close:SimpleButton;
      
      protected var FInitialized:Boolean;
      
      protected var FTitleAnimationID:Vector.<uint>;
      
      protected var FOnCloseUp:Function;
      
      protected var FOnOverlay:Function;
      
      protected var FOnOut:Function;
      
      protected var FTipOnOver:Function;
      
      protected var FTipOnOut:Function;
      
      protected var FOnGetBox:Function;
      
      protected var FTitleHintOnOver:Function;
      
      protected var FTitleHintOnOut:Function;
      
      public function TProcessorWindowTitleDesc(param1:TUIComponent)
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
         var _loc1_:TUIBaseBox = null;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:Bitmap = null;
         this.graphics.beginFill(0,0.6);
         this.graphics.drawRect(0,0,CONST_COMMON.STAGE_Width,CONST_COMMON.STAGE_Height);
         this.graphics.endFill();
         this.FMC_Scene = TUtilityReflection.CreateDisplayObjectInstance("MC_BaseActiveTitleDesc") as MovieClip;
         addChild(this.FMC_Scene);
         this.FBtn_Close = this.FMC_Scene["Btn_Close"];
         this.FMC_Scene.x = CONST_COMMON.STAGE_Width - SIZE_Window_Width >> 1;
         this.FMC_Scene.y = CONST_COMMON.STAGE_Height - SIZE_Window_Height >> 1;
         _loc2_ = 0;
         while(_loc2_ < RANK_LEVEL)
         {
            this.FMC_Scene["MC_Title" + _loc2_].addEventListener(MouseEvent.MOUSE_MOVE,this.MCTitleEffectOnOver);
            this.FMC_Scene["MC_Title" + _loc2_].addEventListener(MouseEvent.ROLL_OUT,this.MCTitleEffectOnOut);
            _loc2_++;
         }
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:MovieClip = null;
         this.FBtn_Close.addEventListener(MouseEvent.CLICK,this.ProcessorOnClose);
         super.ResourcesPerform_UILocations();
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         super.LogicsPerform();
      }
      
      private function ProcessorOnClose(param1:MouseEvent) : void
      {
         if(this.FOnCloseUp != null)
         {
            this.FOnCloseUp(4);
         }
      }
      
      protected function MCTitleEffectOnOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(8));
         if(Boolean(this.FTitleHintOnOver != null) && Boolean(this.FTitleAnimationID) && this.FTitleAnimationID.length > 0)
         {
            this.FTitleHintOnOver(this.FTitleAnimationID[_loc2_]);
         }
      }
      
      protected function MCTitleEffectOnOut(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(8));
         if(Boolean(this.FTitleHintOnOut != null) && Boolean(this.FTitleAnimationID) && this.FTitleAnimationID.length > 0)
         {
            this.FTitleHintOnOut();
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
      
      public function get TitleHintOnOver() : Function
      {
         return this.FTitleHintOnOver;
      }
      
      public function set TitleHintOnOver(param1:Function) : void
      {
         this.FTitleHintOnOver = param1;
      }
      
      public function get TitleHintOnOut() : Function
      {
         return this.FTitleHintOnOut;
      }
      
      public function set TitleHintOnOut(param1:Function) : void
      {
         this.FTitleHintOnOut = param1;
      }
      
      public function UpdateUI(param1:Vector.<uint>) : void
      {
         this.FTitleAnimationID = param1;
      }
   }
}

