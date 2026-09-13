package Processors.Game.Lobby.Exercise.FateRoulette
{
   import Components.Pages.TUIPage;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseBox;
   import Resources.Constants.CONST_COMMON;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   
   public class TProcessorFateRouletteShop extends TProcessorLobbyWindow
   {
      
      public static const ACTIVITY_1_ID:int = 1;
      
      public static const SIZE_Window_Width:uint = 463;
      
      public static const SIZE_Window_Height:uint = 407;
      
      public static const EXCHANGE_COUNT:int = 10;
      
      protected var FBaseActivity:TBaseActivity;
      
      protected var FBeClicked:Boolean;
      
      protected var FMC_Scene:MovieClip;
      
      protected var FBtn_Close:SimpleButton;
      
      protected var FExchangeList:Vector.<TUIBaseBox>;
      
      protected var FBuyBoxDate:Object;
      
      protected var FUIPage0:TUIPage;
      
      protected var FTotalPage0:int;
      
      protected var FCurPage0:int;
      
      protected var FOnCloseUp:Function;
      
      protected var FOnOverlay:Function;
      
      protected var FOnOut:Function;
      
      protected var FOnGetBox:Function;
      
      protected var FOnExchange:Function;
      
      public function TProcessorFateRouletteShop(param1:TUIComponent)
      {
         super(param1);
         this.FExchangeList = new Vector.<TUIBaseBox>(EXCHANGE_COUNT);
         this.FUIPage0 = new TUIPage(this);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(2550137170);
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
         this.FMC_Scene = TUtilityReflection.CreateDisplayObjectInstance("MC_FateRouletteShop") as MovieClip;
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
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:TBaseBox = null;
         this.FMC_Scene.TF_Point.text = this.FBaseActivity.ShopExchangePoint.toString();
         this.FUIPage0.TotalQuantity = this.FBaseActivity.ShopExchangeItems.length;
         this.FUIPage0.Update();
         _loc1_ = 0;
         while(_loc1_ < EXCHANGE_COUNT)
         {
            _loc3_ = _loc1_ + this.FCurPage0 * EXCHANGE_COUNT;
            if(_loc3_ < this.FBaseActivity.ShopExchangeItems.length)
            {
               this.FExchangeList[_loc1_].SetVisible(true);
               _loc5_ = this.FBaseActivity.ShopExchangeItems[_loc3_];
               this.FExchangeList[_loc1_].UpdateUI(_loc5_.Inventories);
               this.FExchangeList[_loc1_].Identify = _loc3_;
               _loc4_ = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_LIMIT_COUNT,_loc5_.LimitCount.toString());
               this.FExchangeList[_loc1_].SetLimitText(_loc4_);
               _loc4_ = _loc5_.Price.toString();
               this.FExchangeList[_loc1_].SetPriceText(_loc4_);
               if(this.FBaseActivity.ShopExchangePoint < _loc5_.Price || _loc5_.LimitCount <= 0)
               {
                  this.FExchangeList[_loc1_].SetBtnMode(false);
               }
               else
               {
                  this.FExchangeList[_loc1_].SetBtnMode(true);
               }
            }
            else
            {
               this.FExchangeList[_loc1_].SetVisible(false);
            }
            _loc1_++;
         }
      }
      
      protected function ProcessorPageOnChange0(param1:Object, param2:int) : void
      {
         this.FCurPage0 = param2;
         this.UpdateExchange();
      }
      
      protected function ProcessorOnClose(param1:MouseEvent) : void
      {
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
            this.FOnExchange(_loc3_);
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
      
      public function UpdateUI(param1:TBaseActivity) : void
      {
         this.FBaseActivity = param1;
         this.UpdateExchange();
      }
   }
}

