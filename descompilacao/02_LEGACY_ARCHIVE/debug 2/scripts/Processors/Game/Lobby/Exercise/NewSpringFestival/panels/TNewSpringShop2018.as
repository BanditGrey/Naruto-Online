package Processors.Game.Lobby.Exercise.NewSpringFestival.panels
{
   import Components.Pages.TUIPage;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.TBaseBox;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseBox;
   import Processors.Game.Lobby.Exercise.NewSpringFestival.data.NewSpring2018Data;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   
   public class TNewSpringShop2018 extends TProcessorLobbyWindow
   {
      
      public static const ACTIVITY_1_ID:int = 1;
      
      public static const SIZE_Window_Width:uint = 463;
      
      public static const SIZE_Window_Height:uint = 407;
      
      public static const EXCHANGE_COUNT:int = 10;
      
      protected var _newSpring2018Data:NewSpring2018Data;
      
      protected var FBeClicked:Boolean;
      
      protected var FMC_Scene:MovieClip;
      
      protected var FBtn_Close:SimpleButton;
      
      protected var FExchangeList:Vector.<TUIBaseBox>;
      
      protected var FBuyBoxDate:Object;
      
      protected var FUIPage0:TUIPage;
      
      protected var FTotalPage0:int;
      
      protected var FCurPage0:int;
      
      private var tabConfig:TBins;
      
      protected var FOnCloseUp:Function;
      
      protected var FOnOverlay:Function;
      
      protected var FOnOut:Function;
      
      protected var FOnGetBox:Function;
      
      protected var FOnExchange:Function;
      
      public function TNewSpringShop2018(param1:TUIComponent)
      {
         super(param1);
         this.FExchangeList = new Vector.<TUIBaseBox>(EXCHANGE_COUNT);
         this.FUIPage0 = new TUIPage(this);
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
         this.FMC_Scene = TUtilityReflection.CreateDisplayObjectInstance("MC_NewSpringShop2018") as MovieClip;
         addChild(this.FMC_Scene);
         this.FBtn_Close = this.FMC_Scene["Btn_Close"];
         this.FMC_Scene.x = CONST_COMMON.STAGE_Width - SIZE_Window_Width >> 1;
         this.FMC_Scene.y = CONST_COMMON.STAGE_Height - SIZE_Window_Height >> 1;
         _loc1_ = 0;
         while(_loc1_ < EXCHANGE_COUNT)
         {
            _loc5_ = new TUIBaseBox(this,1);
            _loc5_.Perform_UIDispatch(this.FMC_Scene["mc_Slot" + _loc1_]);
            _loc5_.OnOverlay = this.SlotsOnOver;
            _loc5_.OnOut = this.SlotsOnOut;
            _loc5_.OnGetBox = this.ProcessorOnExchangeUp;
            this.FExchangeList[_loc1_] = _loc5_;
            _loc1_++;
         }
         this.FUIPage0.ButtonPrevious.Substrate = this.FMC_Scene.MC_ChangePage.MC_PageLeft;
         this.FUIPage0.ButtonNext.Substrate = this.FMC_Scene.MC_ChangePage.MC_PageRight;
         this.FUIPage0.LabelPage = this.FMC_Scene.MC_ChangePage.TF_Page;
         this.FUIPage0.TotalQuantity = this.FTotalPage0;
         this.FUIPage0.PageSize = EXCHANGE_COUNT;
         this.FUIPage0.PageIndex = 0;
         this.FUIPage0.OnChangePage = this.ProcessorPageOnChange0;
         this.FCurPage0 = 0;
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
         var _loc1_:int = 0;
         super.LogicsPerform();
         if(Boolean(this.FMC_Scene) && Boolean(this.FMC_Scene.visible) && this.Visible)
         {
            _loc1_ = 0;
            while(_loc1_ < EXCHANGE_COUNT)
            {
               if(this.FExchangeList[_loc1_])
               {
                  this.FExchangeList[_loc1_].LogicsPerform();
               }
               _loc1_++;
            }
         }
      }
      
      protected function UpdateExchange() : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:String = null;
         var _loc6_:TBaseBox = null;
         var _loc1_:TBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_NewSpring2018Config1);
         var _loc2_:int = _loc1_.Count;
         this.FMC_Scene.TF_Point.text = this._newSpring2018Data.shopPoint.toString();
         this.FUIPage0.TotalQuantity = _loc2_;
         this.FUIPage0.Update();
         _loc3_ = 0;
         while(_loc3_ < EXCHANGE_COUNT)
         {
            _loc4_ = _loc3_ + this.FCurPage0 * EXCHANGE_COUNT;
            if(_loc4_ < _loc2_)
            {
               this.FExchangeList[_loc3_].SetVisible(true);
               _loc6_ = this._newSpring2018Data.ShopExchangeItems[_loc4_];
               this.FExchangeList[_loc3_].UpdateUI(_loc6_.Inventories);
               this.FExchangeList[_loc3_].Identify = _loc4_;
               _loc5_ = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_LIMIT_COUNT,_loc6_.LimitCount.toString());
               this.FExchangeList[_loc3_].SetLimitText(_loc5_);
               _loc5_ = _loc6_.Price.toString();
               this.FExchangeList[_loc3_].SetPriceText(_loc5_);
               if(this._newSpring2018Data.shopPoint < _loc6_.Price || _loc6_.LimitCount <= 0 || this._newSpring2018Data.shopBuyTimes[_loc4_] >= _loc6_.LimitCount)
               {
                  this.FExchangeList[_loc3_].SetBtnMode(false);
               }
               else
               {
                  this.FExchangeList[_loc3_].SetBtnMode(true);
               }
            }
            else
            {
               this.FExchangeList[_loc3_].SetVisible(false);
            }
            _loc3_++;
         }
      }
      
      protected function ProcessorPageOnChange0(param1:Object, param2:int) : void
      {
         this.FCurPage0 = param2;
         this.UpdateExchange();
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
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(this.FOnExchange != null)
         {
            _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
            _loc3_ = _loc2_ + this.FCurPage0 * EXCHANGE_COUNT;
            this.FOnExchange(_loc3_ + 1);
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
      
      public function UpdateUI(param1:NewSpring2018Data) : void
      {
         this._newSpring2018Data = param1;
         this.UpdateExchange();
      }
   }
}

