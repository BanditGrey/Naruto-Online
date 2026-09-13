package Processors.Game.Lobby.Exercise.NovActive.Compoents
{
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.Exercise.NovActive.TNovActive1;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseBox;
   import Resources.Constants.CONST_COMMON;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class TUINovActiveAutoLog extends TProcessorLobbyWindow
   {
      
      public static const SIZE_Window_Width:uint = 555;
      
      public static const SIZE_Window_Height:uint = 434;
      
      protected static const MAX_COUNT:int = 10;
      
      protected static const ITEM_COUNT:int = 3;
      
      protected static const ACTIVITY_1_ID:int = 1;
      
      protected var FMC_Scene:Sprite;
      
      protected var FBtn_Close:SimpleButton;
      
      protected var FInitialized:Boolean;
      
      protected var FNovActive1:TNovActive1;
      
      protected var FIndex:int;
      
      protected var FOnCloseUp:Function;
      
      protected var FOnOverlay:Function;
      
      protected var FOnOut:Function;
      
      protected var FTipOnOver:Function;
      
      protected var FTipOnOut:Function;
      
      protected var FOnGetBox:Function;
      
      protected var FTitleHintOnOver:Function;
      
      protected var FTitleHintOnOut:Function;
      
      public function TUINovActiveAutoLog(param1:TUIComponent)
      {
         super(param1);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(2550137109);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:TUIBaseBox = null;
         var _loc2_:int = 0;
         this.graphics.beginFill(0,0.6);
         this.graphics.drawRect(0,0,CONST_COMMON.STAGE_Width,CONST_COMMON.STAGE_Height);
         this.graphics.endFill();
         this.FMC_Scene = TUtilityReflection.CreateDisplayObjectInstance("MC_NovActiveLog") as MovieClip;
         addChild(this.FMC_Scene);
         this.FBtn_Close = this.FMC_Scene["Btn_Close"];
         this.FMC_Scene.x = CONST_COMMON.STAGE_Width - SIZE_Window_Width >> 1;
         this.FMC_Scene.y = CONST_COMMON.STAGE_Height - SIZE_Window_Height >> 1;
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
      
      protected function UpdateText() : void
      {
         this.FMC_Scene["TF_Score"].text = this.FNovActive1.ResultScore.toString();
      }
      
      protected function UpdateResult() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         _loc1_ = 0;
         while(_loc1_ < MAX_COUNT)
         {
            _loc3_ = this.FMC_Scene["MC_Result" + _loc1_];
            _loc3_.TF_Text.text = _loc1_ + 1;
            _loc2_ = 0;
            while(_loc2_ < ITEM_COUNT)
            {
               _loc3_["MC_Item" + _loc2_].MC_Icon.gotoAndStop(this.FNovActive1.Result[_loc1_ * ITEM_COUNT + _loc2_] + 1);
               _loc2_++;
            }
            _loc1_++;
         }
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
         this.FNovActive1 = SLogicsCore.NovActiveDatas.GetActivityByIdentify(ACTIVITY_1_ID) as TNovActive1;
         this.UpdateText();
         this.UpdateResult();
      }
   }
}

