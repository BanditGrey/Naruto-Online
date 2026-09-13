package Processors.Game.Lobby.Exercise.NewSpringFestival.panels
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.Inventories.TInventories;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseBox;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIShowItem;
   import Processors.Game.Lobby.Exercise.NewSpringFestival.data.NewSpring2018Data;
   import Resources.Constants.CONST_COMMON;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   
   public class TNewSpringRewardsPreview extends TProcessorLobbyWindow
   {
      
      public static const ACTIVITY_1_ID:int = 1;
      
      public static const SIZE_Window_Width:uint = 414;
      
      public static const SIZE_Window_Height:uint = 270;
      
      public static const EXCHANGE_COUNT:int = 6;
      
      protected var _newSpring2018Data:NewSpring2018Data;
      
      protected var FBeClicked:Boolean;
      
      protected var FMC_Scene:MovieClip;
      
      protected var FBtn_Close:SimpleButton;
      
      protected var FExchangeList:Vector.<TUIBaseBox>;
      
      protected var FBuyBoxDate:Object;
      
      private var tabConfig:TBins;
      
      protected var FOnCloseUp:Function;
      
      protected var FOnOverlay:Function;
      
      protected var FOnOut:Function;
      
      protected var FOnGetBox:Function;
      
      protected var FOnExchange:Function;
      
      private var FShowItem:TUIShowItem;
      
      public function TNewSpringRewardsPreview(param1:TUIComponent)
      {
         super(param1);
         this.FExchangeList = new Vector.<TUIBaseBox>(EXCHANGE_COUNT);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:MovieClip = null;
         var _loc5_:TUIBaseBox = null;
         this.graphics.beginFill(0,0.6);
         this.graphics.drawRect(0,0,CONST_COMMON.STAGE_Width,CONST_COMMON.STAGE_Height);
         this.graphics.endFill();
         this.FMC_Scene = TUtilityReflection.CreateDisplayObjectInstance("mc_NewSpringRewardsPreview") as MovieClip;
         addChild(this.FMC_Scene);
         this.FBtn_Close = this.FMC_Scene["Btn_Close"];
         this.FMC_Scene.x = CONST_COMMON.STAGE_Width - SIZE_Window_Width >> 1;
         this.FMC_Scene.y = CONST_COMMON.STAGE_Height - SIZE_Window_Height >> 1;
         this.FShowItem = new TUIShowItem(this,6);
         this.FShowItem.Perform_UIDispatch(this.FMC_Scene["mc_items"]);
         this.FShowItem.OnOverlay = this.SlotsOnOver;
         this.FShowItem.OnOut = this.SlotsOnOut;
         super.ResourcesPerform_UIDispatch();
      }
      
      public function initUI() : void
      {
         this.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FBtn_Close.addEventListener(MouseEvent.CLICK,this.ProcessorOnClose);
         super.ResourcesPerform_UILocations();
      }
      
      override protected function LogicsPerform() : void
      {
         this.FShowItem.LogicsPerform();
      }
      
      protected function UpdateExchange(param1:int) : void
      {
         this.FShowItem.UpdateUI(this._newSpring2018Data.bagRewardsPreviewConfig[param1].Inventories);
         this.LogicsPerform();
      }
      
      protected function ProcessorOnClose(param1:MouseEvent) : void
      {
         this.Visible = false;
         if(this.FOnCloseUp != null)
         {
            this.FOnCloseUp();
         }
      }
      
      protected function SlotsOnOver(param1:Object, param2:Object) : void
      {
         if(this.FOnOverlay != null)
         {
            this.FOnOverlay(param1,param2);
         }
      }
      
      protected function SlotsOnOut(param1:Object, param2:Object) : void
      {
         if(this.FOnOut != null)
         {
            this.FOnOut(param1,param2);
         }
      }
      
      protected function ProcessorOnExchangeUp(param1:MouseEvent) : void
      {
      }
      
      public function get OnCloseUp() : Function
      {
         return this.FOnCloseUp;
      }
      
      public function set OnCloseUp(param1:Function) : void
      {
         this.FOnCloseUp = param1;
      }
      
      public function get OnOverlay() : Function
      {
         return this.FOnOverlay;
      }
      
      public function set OnOverlay(param1:Function) : void
      {
         this.FOnOverlay = param1;
      }
      
      public function get OnOut() : Function
      {
         return this.FOnOut;
      }
      
      public function set OnOut(param1:Function) : void
      {
         this.FOnOut = param1;
      }
      
      public function get OnGetBox() : Function
      {
         return this.FOnGetBox;
      }
      
      public function set OnGetBox(param1:Function) : void
      {
         this.FOnGetBox = param1;
      }
      
      public function get OnExchange() : Function
      {
         return this.FOnExchange;
      }
      
      public function set OnExchange(param1:Function) : void
      {
         this.FOnExchange = param1;
      }
      
      public function UpdateUI(param1:TInventories) : void
      {
         this.FShowItem.UpdateUI(param1);
         this.LogicsPerform();
      }
   }
}

