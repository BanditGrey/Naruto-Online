package Processors.Game.Lobby.Exercise.DecActive
{
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.Exercise.DecActive.TDecActive4;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Resources.Constants.CONST_COMMON;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class TProcessorDecActiveBook extends TProcessorLobbyWindow
   {
      
      protected static const SIZE_Window_Width:uint = 463;
      
      protected static const SIZE_Window_Height:uint = 374;
      
      protected static const EGG_COUNT:int = 10;
      
      protected static const BOX_COUNT:int = 5;
      
      protected var FMC_Scene:Sprite;
      
      protected var FBtn_Close:SimpleButton;
      
      protected var FInitialized:Boolean;
      
      protected var FDecActive4:TDecActive4;
      
      protected var FOnCloseUp:Function;
      
      protected var FOnOverlay:Function;
      
      protected var FOnOut:Function;
      
      protected var FTipOnOver:Function;
      
      protected var FTipOnOut:Function;
      
      public function TProcessorDecActiveBook(param1:TUIComponent)
      {
         super(param1);
         this.FDecActive4 = SLogicsCore.DecActiveDatas.GetActivityByIdentify(4) as TDecActive4;
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(2550137110);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         this.graphics.beginFill(0,0.6);
         this.graphics.drawRect(0,0,CONST_COMMON.STAGE_Width,CONST_COMMON.STAGE_Height);
         this.graphics.endFill();
         this.FMC_Scene = TUtilityReflection.CreateDisplayObjectInstance("MC_DecActiveBook") as MovieClip;
         addChild(this.FMC_Scene);
         this.FBtn_Close = this.FMC_Scene["Btn_Close"];
         this.FMC_Scene.x = CONST_COMMON.STAGE_Width - SIZE_Window_Width >> 1;
         this.FMC_Scene.y = CONST_COMMON.STAGE_Height - SIZE_Window_Height >> 1;
         _loc1_ = 0;
         while(_loc1_ < EGG_COUNT)
         {
            this.FMC_Scene["MC_Egg" + _loc1_].gotoAndStop(_loc1_ + 1);
            this.FMC_Scene["MC_Egg" + _loc1_].addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnEggOver);
            this.FMC_Scene["MC_Egg" + _loc1_].addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnEggOut);
            _loc1_++;
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
            this.FOnCloseUp(6);
         }
      }
      
      protected function ProcessorOnEggOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(6));
         if(this.FTipOnOver != null && Boolean(this.FDecActive4))
         {
            this.FTipOnOver(this.FDecActive4.DescListNew[9 + _loc2_]);
         }
      }
      
      protected function ProcessorOnEggOut(param1:MouseEvent) : void
      {
         if(this.FTipOnOut != null)
         {
            this.FTipOnOut();
         }
      }
      
      protected function ProcessorOnBoxOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(6));
         if(this.FTipOnOver != null && Boolean(this.FDecActive4))
         {
            this.FTipOnOver(this.FDecActive4.BoxList[_loc2_].Inventories);
         }
      }
      
      protected function ProcessorOnBoxOut(param1:MouseEvent) : void
      {
         if(this.FTipOnOut != null)
         {
            this.FTipOnOut();
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
      
      public function get TipOnOver() : Function
      {
         return this.FTipOnOver;
      }
      
      public function set TipOnOver(param1:Function) : void
      {
         this.FTipOnOver = param1;
      }
      
      public function get TipOnOut() : Function
      {
         return this.FTipOnOut;
      }
      
      public function set TipOnOut(param1:Function) : void
      {
         this.FTipOnOut = param1;
      }
      
      public function UpdateUI() : void
      {
      }
   }
}

