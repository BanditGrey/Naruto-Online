package Processors.Game.Lobby.Exercise.NewLottery
{
   import Components.Pages.TUIPage;
   import Foundation.Common.THint;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.Exercise.NewLottery.TNewLottery;
   import Logics.Lottery.TExchangeItem;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.Exercise.NewLottery.Compoents.TUINewExchangeItem;
   import Processors.Game.Lobby.Tavern.TProcessorWindowRecruit;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_LOTTERY;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorNewLotteryExchange extends TProcessorLobbyWindow
   {
      
      protected static const TOTAL_COUNT:int = 12;
      
      protected static const ROW_COUNT:int = 2;
      
      protected static const COL_COUNT:int = 6;
      
      protected static const HERO_COUNT:int = 8;
      
      public static const SIZE_Window_Width:int = 720;
      
      public static const SIZE_Window_Height:int = 439;
      
      protected var FMC_Scene:Sprite;
      
      protected var FItemList:Vector.<TUINewExchangeItem>;
      
      protected var FProcessorWindowRecruit:TProcessorWindowRecruit;
      
      protected var FUIPage:TUIPage;
      
      protected var FMC_MC_ChangePage:MovieClip;
      
      protected var FUI_Left_Btn:MovieClip;
      
      protected var FUI_Right_Btn:MovieClip;
      
      protected var FTF_Page:TextField;
      
      protected var FNewLottery:TNewLottery;
      
      protected var FTF_Point:TextField;
      
      protected var FBtn_Close:SimpleButton;
      
      protected var FTotalPage:int;
      
      protected var FCurPage:int;
      
      protected var FBtn_ShowRecruit1:MovieClip;
      
      protected var FBtn_ShowRecruit2:MovieClip;
      
      protected var FBtn_ShowRecruit3:MovieClip;
      
      protected var FBtn_ShowRecruit4:MovieClip;
      
      protected var FBtn_ShowRecruit5:MovieClip;
      
      protected var FBtn_ShowRecruit6:MovieClip;
      
      protected var FBtn_ShowRecruit7:MovieClip;
      
      protected var FBtn_ShowRecruit8:MovieClip;
      
      protected var FIsResourcesLoad:Boolean;
      
      protected var FExchangeItems:Vector.<TExchangeItem>;
      
      protected var FExchangeIdentify:int;
      
      protected var FOnExchange:Function;
      
      protected var FDownHintOnOver:Function;
      
      protected var FDownHintOnOut:Function;
      
      protected var FOnGetReward:Function;
      
      protected var FOnCloseUp:Function;
      
      protected var FTipOnOver:Function;
      
      protected var FTipOnOut:Function;
      
      protected var FOnShowRecruit:Function;
      
      public function TProcessorNewLotteryExchange(param1:TUIComponent)
      {
         super(param1);
         this.FItemList = new Vector.<TUINewExchangeItem>(TOTAL_COUNT);
         this.FNewLottery = SLogicsCore.NewLottery;
         this.FProcessorWindowRecruit = new TProcessorWindowRecruit(this.Parent);
         this.FIsResourcesLoad = false;
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(2550137097);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         this.graphics.beginFill(0,0.6);
         this.graphics.drawRect(0,0,CONST_COMMON.STAGE_Width,CONST_COMMON.STAGE_Height);
         this.graphics.endFill();
         this.FMC_Scene = TUtilityReflection.CreateDisplayObjectInstance("MC_NewLotteryExcharge") as Sprite;
         addChild(this.FMC_Scene);
         this.FMC_Scene.x = CONST_COMMON.STAGE_Width - SIZE_Window_Width >> 1;
         this.FMC_Scene.y = CONST_COMMON.STAGE_Height - SIZE_Window_Height >> 1;
         this.FBtn_Close = this.FMC_Scene[CONST_LOTTERY.RESOURCE_Link_Btn_Close];
         this.FTF_Point = this.FMC_Scene[CONST_LOTTERY.RESOURCE_Link_TF_Point];
         _loc1_ = 0;
         while(_loc1_ < HERO_COUNT)
         {
            _loc3_ = this.FMC_Scene["Btn_ShowRecruit" + _loc1_];
            if(_loc3_)
            {
               TGameUtil.setButtonMode(this.FMC_Scene["Btn_ShowRecruit" + _loc1_],true);
               _loc3_.addEventListener(MouseEvent.MOUSE_UP,this.ProcessorOnShowRecruit);
            }
            _loc1_++;
         }
         this.ResourcesPerform_UIDispatchChangePage();
         this.ResourcesPerform_UIDispatchItemList();
         this.FProcessorWindowRecruit.Visible = false;
         this.FProcessorWindowRecruit.HintOnOver = this.ProcessorTipOnOver;
         this.FProcessorWindowRecruit.HintOnOut = this.ProcessorTipOnOut;
         this.FProcessorWindowRecruit.x = (CONST_COMMON.STAGE_Width - 390) / 2;
         this.FProcessorWindowRecruit.y = (CONST_COMMON.STAGE_Height - 358) / 2;
         super.ResourcesPerform_UIDispatch();
      }
      
      protected function ResourcesPerform_UIDispatchChangePage() : void
      {
         this.FUIPage = new TUIPage(this);
         this.FMC_MC_ChangePage = this.FMC_Scene[CONST_LOTTERY.RESOURCE_Link_MC_ChangePage];
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
         var _loc2_:TUINewExchangeItem = null;
         _loc1_ = 0;
         while(_loc1_ < TOTAL_COUNT)
         {
            _loc2_ = new TUINewExchangeItem(this);
            _loc2_.Resource = this.FMC_Scene[CONST_LOTTERY.RESOURCE_Link_MC_Equip + _loc1_];
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
         super.ResourcesPerform_UILocations();
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TUINewExchangeItem = null;
         if(this.Visible)
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
            this.FTF_Point.text = this.FNewLottery.Score.toString();
            if(Boolean(this.FProcessorWindowRecruit) && this.FProcessorWindowRecruit.Visible)
            {
               this.FProcessorWindowRecruit.UpdataBitmap();
            }
         }
         super.LogicsPerform();
      }
      
      protected function UpdateSlot() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TUINewExchangeItem = null;
         _loc1_ = 0;
         while(_loc1_ < TOTAL_COUNT)
         {
            _loc2_ = _loc1_ + this.FCurPage * TOTAL_COUNT;
            _loc3_ = this.FItemList[_loc1_];
            if(_loc2_ < this.FExchangeItems.length)
            {
               _loc3_.Resource.visible = true;
               _loc3_.SetItemInfo(this.FExchangeItems[_loc2_]);
            }
            else
            {
               _loc3_.Resource.visible = false;
            }
            if(this.FMC_Scene["MC_Boom" + _loc1_])
            {
               if(this.FCurPage > 0)
               {
                  this.FMC_Scene["MC_Boom" + _loc1_].visible = false;
               }
               else
               {
                  this.FMC_Scene["MC_Boom" + _loc1_].visible = true;
               }
            }
            _loc1_++;
         }
      }
      
      protected function UpdateHeroList() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         _loc1_ = 0;
         while(_loc1_ < HERO_COUNT)
         {
            _loc2_ = this.FMC_Scene["Btn_ShowRecruit" + _loc1_];
            if(_loc2_)
            {
               if(_loc1_ < this.FNewLottery.HeroList.length)
               {
                  _loc2_.MC_Icon.gotoAndStop("ID" + this.FNewLottery.HeroList[_loc1_]);
               }
               else
               {
                  _loc2_.MC_Icon.gotoAndStop("ID0");
               }
            }
            _loc1_++;
         }
      }
      
      protected function ProcessorOnExchange(param1:int) : void
      {
         if(this.FOnExchange != null)
         {
            this.FOnExchange(TProcessorNewLottery.EXCHANGE_REQ,param1);
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
            this.FOnCloseUp(param1);
         }
      }
      
      protected function UIDownHintOnOver(param1:Object) : void
      {
         if(this.FDownHintOnOver != null)
         {
            this.FDownHintOnOver(this,param1);
         }
      }
      
      protected function UIDownHintOnOut(param1:Object) : void
      {
         if(this.FDownHintOnOut != null)
         {
            this.FDownHintOnOut(this,param1);
         }
      }
      
      protected function ProcessorPageOnChange(param1:Object, param2:int) : void
      {
         this.FCurPage = param2;
         this.UpdateUI();
      }
      
      protected function ProcessorOnShowRecruit(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(15));
         if(this.FOnShowRecruit != null && _loc2_ < this.FNewLottery.HeroList.length)
         {
            this.FProcessorWindowRecruit.SetHeroData(this.FNewLottery.HeroList[_loc2_]);
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
      
      public function get DownHintOnOver() : Function
      {
         return this.FDownHintOnOver;
      }
      
      public function set DownHintOnOver(param1:Function) : void
      {
         this.FDownHintOnOver = param1;
      }
      
      public function get DownHintOnOut() : Function
      {
         return this.FDownHintOnOut;
      }
      
      public function set DownHintOnOut(param1:Function) : void
      {
         this.FDownHintOnOut = param1;
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
      
      public function UpdateUI() : void
      {
         if(!this.FIsResourcesLoad)
         {
            this.FProcessorWindowRecruit.Load();
            this.FIsResourcesLoad = true;
         }
         this.FExchangeItems = this.FNewLottery.ExchangeItems;
         this.FTF_Point.text = this.FNewLottery.Score.toString();
         this.FUIPage.TotalQuantity = this.FExchangeItems.length;
         this.FUIPage.Update();
         this.UpdateSlot();
         this.UpdateHeroList();
      }
   }
}

