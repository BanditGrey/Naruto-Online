package Processors.Game.Lobby.Exercise.SeventhEvening
{
   import Components.Pages.TUIPage;
   import Foundation.Common.THint;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.Exercise.SeventhEvening.TSeventhEvening;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.Lottery.TExchangeItem;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.Exercise.SeventhEvening.Compoents.TUIExchangeItem;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_SEVENTHEVENING;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorWindowSeventhEveningExchange extends TProcessorLobbyWindow
   {
      
      protected static const TOTAL_COUNT:int = 8;
      
      protected static const SIZE_Window_Width:uint = 534;
      
      protected static const SIZE_Window_Height:uint = 338;
      
      protected var FMC_Scene:Sprite;
      
      protected var FItemList:Vector.<TUIExchangeItem>;
      
      protected var FUIPage:TUIPage;
      
      protected var FMC_MC_ChangePage:MovieClip;
      
      protected var FUI_Left_Btn:MovieClip;
      
      protected var FUI_Right_Btn:MovieClip;
      
      protected var FTF_Page:TextField;
      
      protected var FTF_Point:TextField;
      
      protected var FBtn_Close:SimpleButton;
      
      protected var FTotalPage:int;
      
      protected var FCurPage:int;
      
      protected var FBtn_ShowRecruit:MovieClip;
      
      protected var FBtn_ShowChuTian:MovieClip;
      
      protected var FIndex:int;
      
      protected var FSeventhEvening:TSeventhEvening;
      
      protected var FOnExchange:Function;
      
      protected var FOnOverlay:Function;
      
      protected var FOnOut:Function;
      
      protected var FOnGetReward:Function;
      
      protected var FOnCloseUp:Function;
      
      protected var FTipOnOver:Function;
      
      protected var FTipOnOut:Function;
      
      protected var FOnShowRecruit:Function;
      
      protected var FOnShowChuTian:Function;
      
      public function TProcessorWindowSeventhEveningExchange(param1:TUIComponent)
      {
         super(param1);
         this.FItemList = new Vector.<TUIExchangeItem>(TOTAL_COUNT);
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
         this.FMC_Scene = TUtilityReflection.CreateDisplayObjectInstance(CONST_SEVENTHEVENING.RESOURCE_ClassName_MC_SeventhEveningExchange) as Sprite;
         addChild(this.FMC_Scene);
         this.FMC_Scene.x = CONST_COMMON.STAGE_Width - SIZE_Window_Width >> 1;
         this.FMC_Scene.y = CONST_COMMON.STAGE_Height - SIZE_Window_Height >> 1;
         this.FBtn_Close = this.FMC_Scene[CONST_SEVENTHEVENING.RESOURCE_Link_BTN_Close];
         this.FTF_Point = this.FMC_Scene["TF_Point"];
         TGameUtil.setButtonMode(this.FMC_Scene["BTN_Exchange"],true);
         this.FMC_Scene["BTN_Exchange"].addEventListener(MouseEvent.CLICK,this.ProcessorOnExchangeHero);
         this.FBtn_ShowRecruit = this.FMC_Scene["Btn_ShowRecruit"];
         TGameUtil.setButtonMode(this.FBtn_ShowRecruit,true);
         this.ResourcesPerform_UIDispatchChangePage();
         this.ResourcesPerform_UIDispatchItemList();
         super.ResourcesPerform_UIDispatch();
      }
      
      protected function ResourcesPerform_UIDispatchChangePage() : void
      {
         this.FUIPage = new TUIPage(this);
         this.FMC_MC_ChangePage = this.FMC_Scene[CONST_SEVENTHEVENING.RESOURCE_Link_MC_ChangePage];
         this.FUI_Left_Btn = this.FMC_MC_ChangePage["MC_PageLeft"];
         this.FUI_Right_Btn = this.FMC_MC_ChangePage["MC_PageRight"];
         this.FTF_Page = this.FMC_MC_ChangePage["TF_Page"];
         this.FUIPage.ButtonPrevious.Substrate = this.FUI_Left_Btn;
         this.FUIPage.ButtonNext.Substrate = this.FUI_Right_Btn;
         this.FUIPage.LabelPage = this.FTF_Page;
         this.FUIPage.TotalQuantity = 1;
         this.FUIPage.PageSize = TOTAL_COUNT;
         this.FUIPage.PageIndex = 0;
         this.FCurPage = 0;
         this.FUIPage.OnChangePage = this.ProcessorPageOnChange;
      }
      
      protected function ResourcesPerform_UIDispatchItemList() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TUIExchangeItem = null;
         _loc1_ = 0;
         while(_loc1_ < TOTAL_COUNT)
         {
            _loc2_ = new TUIExchangeItem(this);
            _loc2_.Resource = this.FMC_Scene["MC_Slot" + _loc1_];
            _loc2_.OnExchange = this.ProcessorOnExchange;
            _loc2_.OnOverlay = this.UIDownHintOnOver;
            _loc2_.OnOut = this.UIDownHintOnOut;
            _loc2_.TipOnOver = this.ProcessorTipOnOver;
            _loc2_.TipOnOut = this.ProcessorTipOnOut;
            _loc2_.Init();
            this.FItemList[_loc1_] = _loc2_;
            _loc1_++;
         }
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FBtn_Close.addEventListener(MouseEvent.CLICK,this.ProcessorOnCloseUp);
         this.FBtn_ShowRecruit.addEventListener(MouseEvent.MOUSE_UP,this.ProcessorOnShowRecruit);
         super.ResourcesPerform_UILocations();
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TUIExchangeItem = null;
         if(this.visible)
         {
            _loc1_ = 0;
            while(_loc1_ < TOTAL_COUNT)
            {
               _loc2_ = this.FItemList[_loc1_];
               if(_loc2_ != null)
               {
                  _loc2_.UpdateSlot();
               }
               _loc1_++;
            }
         }
         super.LogicsPerform();
      }
      
      protected function UpdateText() : void
      {
         this.FTF_Point.text = this.FSeventhEvening.Magpie.toString();
         this.FMC_Scene["TF_Price"].text = this.FSeventhEvening.ExchangeItemList[0].CostPoint;
         if(this.FSeventhEvening.ExchangeItemList[0].BuyCount > 0)
         {
            this.FMC_Scene["MC_Got"].visible = true;
            TGameUtil.setButtonMode(this.FMC_Scene["BTN_Exchange"],false);
         }
         else if(this.FSeventhEvening.Magpie >= this.FSeventhEvening.ExchangeItemList[0].CostPoint)
         {
            this.FMC_Scene["MC_Got"].visible = false;
            TGameUtil.setButtonMode(this.FMC_Scene["BTN_Exchange"],true);
         }
         else
         {
            this.FMC_Scene["MC_Got"].visible = false;
            TGameUtil.setButtonMode(this.FMC_Scene["BTN_Exchange"],false);
         }
      }
      
      protected function UpdateSlot() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TInventories = null;
         var _loc4_:TUIExchangeItem = null;
         var _loc5_:TExchangeItem = null;
         var _loc6_:TInventory = null;
         _loc3_ = this.FSeventhEvening.ExchangeInventories;
         _loc1_ = 0;
         while(_loc1_ < TOTAL_COUNT)
         {
            _loc2_ = _loc1_ + this.FCurPage * TOTAL_COUNT + 1;
            _loc4_ = this.FItemList[_loc1_];
            if(_loc2_ < _loc3_.Count)
            {
               _loc4_.Resource.visible = true;
               _loc5_ = this.FSeventhEvening.ExchangeItemList[_loc2_];
               _loc6_ = _loc3_.GetInventoryByIndex(_loc2_);
               _loc4_.Index = _loc2_;
               _loc4_.SetItemInfo(_loc6_);
            }
            else
            {
               _loc4_.Resource.visible = false;
            }
            _loc1_++;
         }
      }
      
      protected function ProcessorOnExchange(param1:int) : void
      {
         this.FIndex = param1;
         if(this.FOnExchange != null)
         {
            this.FOnExchange(param1);
         }
      }
      
      protected function ProcessorOnExchangeHero(param1:MouseEvent) : void
      {
         if(this.FOnExchange != null)
         {
            this.FOnExchange(0);
         }
      }
      
      protected function ProcessorTipOnOver(param1:Object, param2:THint) : void
      {
         if(this.FTipOnOver != null)
         {
            this.FTipOnOver(param1,param2);
         }
      }
      
      protected function ProcessorTipOnOut(param1:Object) : void
      {
         if(this.FTipOnOut != null)
         {
            this.FTipOnOut(param1);
         }
      }
      
      private function ProcessorOnCloseUp(param1:MouseEvent) : void
      {
         if(this.FOnCloseUp != null)
         {
            this.FOnCloseUp();
         }
      }
      
      protected function UIDownHintOnOver(param1:Object) : void
      {
         if(this.FOnOverlay != null)
         {
            this.FOnOverlay(this,param1);
         }
      }
      
      protected function UIDownHintOnOut(param1:Object) : void
      {
         if(this.FOnOut != null)
         {
            this.FOnOut(this,param1);
         }
      }
      
      protected function ProcessorPageOnChange(param1:Object, param2:int) : void
      {
         this.FCurPage = param2;
         this.UpdateUI();
      }
      
      protected function ProcessorOnShowRecruit(param1:MouseEvent) : void
      {
         if(this.FOnShowRecruit != null)
         {
            this.FOnShowRecruit();
         }
      }
      
      protected function ProcessorOnShowChuTian(param1:MouseEvent) : void
      {
         if(this.FOnShowChuTian != null)
         {
            this.FOnShowChuTian();
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
      
      public function get OnExchange() : Function
      {
         return this.FOnExchange;
      }
      
      public function set OnExchange(param1:Function) : void
      {
         this.FOnExchange = param1;
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
      
      public function get OnShowRecruit() : Function
      {
         return this.FOnShowRecruit;
      }
      
      public function set OnShowRecruit(param1:Function) : void
      {
         this.FOnShowRecruit = param1;
      }
      
      public function get OnShowChuTian() : Function
      {
         return this.FOnShowChuTian;
      }
      
      public function set OnShowChuTian(param1:Function) : void
      {
         this.FOnShowChuTian = param1;
      }
      
      public function UpdateUI() : void
      {
         this.FUIPage.TotalQuantity = this.FSeventhEvening.ExchangeInventories.Count;
         this.FUIPage.Update();
         this.UpdateSlot();
         this.UpdateText();
      }
   }
}

