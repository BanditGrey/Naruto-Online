package Processors.Game.Lobby.Lottery
{
   import Components.Pages.TUIPage;
   import Foundation.Common.THint;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.Lottery.TExchangeItem;
   import Logics.Lottery.TLottery;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.Lottery.Components.TUIExchangeItem;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_LOTTERY;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorWindowExchange extends TProcessorLobbyWindow
   {
      
      protected static const TOTAL_COUNT:int = 12;
      
      protected static const ROW_COUNT:int = 2;
      
      protected static const COL_COUNT:int = 6;
      
      protected static const HERO_COUNT:int = 8;
      
      public static const SIZE_Window_Width:int = 720;
      
      public static const SIZE_Window_Height:int = 379;
      
      protected var FMC_Scene:Sprite;
      
      protected var FItemList:Vector.<TUIExchangeItem>;
      
      protected var FUIPage:TUIPage;
      
      protected var FMC_MC_ChangePage:MovieClip;
      
      protected var FUI_Left_Btn:MovieClip;
      
      protected var FUI_Right_Btn:MovieClip;
      
      protected var FTF_Page:TextField;
      
      protected var FLottery:TLottery;
      
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
      
      protected var FExchangeItems:Vector.<TExchangeItem>;
      
      protected var FExchangeIdentify:int;
      
      protected var FOnExchange:Function;
      
      protected var FDownHintOnOver:Function;
      
      protected var FDownHintOnOut:Function;
      
      protected var FOnGetReward:Function;
      
      protected var FOnCloseUp:Function;
      
      protected var FTipOnOver:Function;
      
      protected var FTipOnOut:Function;
      
      protected var FOnShowRecruit1:Function;
      
      protected var FOnShowRecruit2:Function;
      
      protected var FOnShowRecruit3:Function;
      
      protected var FOnShowRecruit4:Function;
      
      protected var FOnShowRecruit5:Function;
      
      protected var FOnShowRecruit6:Function;
      
      protected var FOnShowRecruit7:Function;
      
      protected var FOnShowRecruit8:Function;
      
      public function TProcessorWindowExchange(param1:TUIComponent)
      {
         super(param1);
         this.FItemList = new Vector.<TUIExchangeItem>(TOTAL_COUNT);
         this.FExchangeItems = new Vector.<TExchangeItem>();
         this.FLottery = SLogicsCore.Lottery;
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_LOTTERY.RESOURCESID_Swf_Lottery);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         this.graphics.beginFill(0,0.6);
         this.graphics.drawRect(0 - 217,0 - 44,CONST_COMMON.STAGE_Width,CONST_COMMON.STAGE_Height);
         this.graphics.endFill();
         this.FMC_Scene = TUtilityReflection.CreateDisplayObjectInstance(CONST_LOTTERY.RESOURCE_ClassName_MC_LotteryExcharge) as Sprite;
         addChild(this.FMC_Scene);
         this.FMC_Scene.x += (778 - 720) / 2;
         this.FMC_Scene.y += (556 - 359) / 2;
         this.FBtn_Close = this.FMC_Scene[CONST_LOTTERY.RESOURCE_Link_Btn_Close];
         this.FTF_Point = this.FMC_Scene[CONST_LOTTERY.RESOURCE_Link_TF_Point];
         this.FBtn_ShowRecruit1 = this.FMC_Scene["Btn_ShowRecruit1"];
         this.FBtn_ShowRecruit2 = this.FMC_Scene["Btn_ShowRecruit2"];
         this.FBtn_ShowRecruit3 = this.FMC_Scene["Btn_ShowRecruit3"];
         this.FBtn_ShowRecruit4 = this.FMC_Scene["Btn_ShowRecruit4"];
         this.FBtn_ShowRecruit5 = this.FMC_Scene["Btn_ShowRecruit5"];
         this.FBtn_ShowRecruit6 = this.FMC_Scene["Btn_ShowRecruit6"];
         this.FBtn_ShowRecruit7 = this.FMC_Scene["Btn_ShowRecruit7"];
         this.FBtn_ShowRecruit8 = this.FMC_Scene["Btn_ShowRecruit8"];
         _loc1_ = 1;
         while(_loc1_ < 9)
         {
            if(Boolean(this.FMC_Scene["Btn_ShowRecruit" + _loc1_]) && Boolean(this.FMC_Scene["Btn_ShowRecruit" + _loc1_].MC_Icon))
            {
               this.FMC_Scene["Btn_ShowRecruit" + _loc1_].MC_Icon.gotoAndStop(_loc1_);
            }
            if(this.FMC_Scene["Btn_ShowRecruit" + _loc1_])
            {
               TGameUtil.setButtonMode(this.FMC_Scene["Btn_ShowRecruit" + _loc1_],true);
            }
            _loc1_++;
         }
         this.ResourcesPerform_UIDispatchChangePage();
         this.ResourcesPerform_UIDispatchItemList();
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
         var _loc2_:TUIExchangeItem = null;
         _loc1_ = 0;
         while(_loc1_ < TOTAL_COUNT)
         {
            _loc2_ = new TUIExchangeItem(this);
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
         if(this.FBtn_ShowRecruit1)
         {
            this.FBtn_ShowRecruit1.addEventListener(MouseEvent.MOUSE_UP,this.ProcessorOnShowRecruit1);
         }
         if(this.FBtn_ShowRecruit2)
         {
            this.FBtn_ShowRecruit2.addEventListener(MouseEvent.MOUSE_UP,this.ProcessorOnShowRecruit2);
         }
         if(this.FBtn_ShowRecruit3)
         {
            this.FBtn_ShowRecruit3.addEventListener(MouseEvent.MOUSE_UP,this.ProcessorOnShowRecruit3);
         }
         if(this.FBtn_ShowRecruit4)
         {
            this.FBtn_ShowRecruit4.addEventListener(MouseEvent.MOUSE_UP,this.ProcessorOnShowRecruit4);
         }
         if(this.FBtn_ShowRecruit5)
         {
            this.FBtn_ShowRecruit5.addEventListener(MouseEvent.MOUSE_UP,this.ProcessorOnShowRecruit5);
         }
         if(this.FBtn_ShowRecruit6)
         {
            this.FBtn_ShowRecruit6.addEventListener(MouseEvent.MOUSE_UP,this.ProcessorOnShowRecruit6);
         }
         if(this.FBtn_ShowRecruit7)
         {
            this.FBtn_ShowRecruit7.addEventListener(MouseEvent.MOUSE_UP,this.ProcessorOnShowRecruit7);
         }
         if(this.FBtn_ShowRecruit8)
         {
            this.FBtn_ShowRecruit8.addEventListener(MouseEvent.MOUSE_UP,this.ProcessorOnShowRecruit8);
         }
         super.ResourcesPerform_UILocations();
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TUIExchangeItem = null;
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
            this.FTF_Point.text = SLogicsCore.Lottery.Point.toString();
         }
         super.LogicsPerform();
      }
      
      protected function UpdateSlot() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TUIExchangeItem = null;
         _loc1_ = 0;
         while(_loc1_ < TOTAL_COUNT)
         {
            _loc2_ = _loc1_ + this.FCurPage * TOTAL_COUNT;
            _loc3_ = this.FItemList[_loc1_];
            if(_loc2_ < this.FExchangeItems.length)
            {
               _loc3_.Resource.visible = true;
               _loc3_.SetItemInfo(this.FExchangeItems[_loc2_]);
               this.FMC_Scene[CONST_LOTTERY.RESOURCE_Link_MC_Equip + _loc1_].TF_Limit.text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_LIMIT_COUNT,this.FExchangeItems[_loc2_].LimitCount - this.FExchangeItems[_loc2_].BuyCount);
            }
            else
            {
               _loc3_.Resource.visible = false;
               this.FMC_Scene[CONST_LOTTERY.RESOURCE_Link_MC_Equip + _loc1_].TF_Limit.text = "";
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
            _loc2_ = this.FMC_Scene["Btn_ShowRecruit" + (_loc1_ + 1)];
            if(_loc2_)
            {
               if(_loc1_ < this.FLottery.HeroList.length)
               {
                  _loc2_.MC_Icon.gotoAndStop("ID" + this.FLottery.HeroList[_loc1_]);
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
         this.FExchangeIdentify = param1;
         if(this.FOnExchange != null)
         {
            this.FOnExchange(param1);
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
            this.FOnCloseUp(false);
         }
      }
      
      protected function UIDownHintOnOver(param1:Object, param2:Object) : void
      {
         if(this.FDownHintOnOver != null)
         {
            this.FDownHintOnOver(this,param2);
         }
      }
      
      protected function UIDownHintOnOut(param1:Object, param2:Object) : void
      {
         if(this.FDownHintOnOut != null)
         {
            this.FDownHintOnOut(this,param2);
         }
      }
      
      protected function ProcessorPageOnChange(param1:Object, param2:int) : void
      {
         this.FCurPage = param2;
         this.UpdateUI();
      }
      
      protected function ProcessorOnShowRecruit1(param1:MouseEvent) : void
      {
         if(this.FOnShowRecruit1 != null)
         {
            this.FOnShowRecruit1(0);
         }
      }
      
      protected function ProcessorOnShowRecruit2(param1:MouseEvent) : void
      {
         if(this.FOnShowRecruit2 != null)
         {
            this.FOnShowRecruit2(1);
         }
      }
      
      protected function ProcessorOnShowRecruit3(param1:MouseEvent) : void
      {
         if(this.FOnShowRecruit3 != null)
         {
            this.FOnShowRecruit3(2);
         }
      }
      
      protected function ProcessorOnShowRecruit4(param1:MouseEvent) : void
      {
         if(this.FOnShowRecruit4 != null)
         {
            this.FOnShowRecruit4(3);
         }
      }
      
      protected function ProcessorOnShowRecruit5(param1:MouseEvent) : void
      {
         if(this.FOnShowRecruit5 != null)
         {
            this.FOnShowRecruit5(4);
         }
      }
      
      protected function ProcessorOnShowRecruit6(param1:MouseEvent) : void
      {
         if(this.FOnShowRecruit6 != null)
         {
            this.FOnShowRecruit6(5);
         }
      }
      
      protected function ProcessorOnShowRecruit7(param1:MouseEvent) : void
      {
         if(this.FOnShowRecruit7 != null)
         {
            this.FOnShowRecruit7(6);
         }
      }
      
      protected function ProcessorOnShowRecruit8(param1:MouseEvent) : void
      {
         if(this.FOnShowRecruit8 != null)
         {
            this.FOnShowRecruit8(7);
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
      
      public function get OnShowRecruit1() : Function
      {
         return this.FOnShowRecruit1;
      }
      
      public function set OnShowRecruit1(param1:Function) : void
      {
         this.FOnShowRecruit1 = param1;
      }
      
      public function get OnShowRecruit2() : Function
      {
         return this.FOnShowRecruit2;
      }
      
      public function set OnShowRecruit2(param1:Function) : void
      {
         this.FOnShowRecruit2 = param1;
      }
      
      public function get OnShowRecruit3() : Function
      {
         return this.FOnShowRecruit3;
      }
      
      public function set OnShowRecruit3(param1:Function) : void
      {
         this.FOnShowRecruit3 = param1;
      }
      
      public function get OnShowRecruit4() : Function
      {
         return this.FOnShowRecruit4;
      }
      
      public function set OnShowRecruit4(param1:Function) : void
      {
         this.FOnShowRecruit4 = param1;
      }
      
      public function get OnShowRecruit5() : Function
      {
         return this.FOnShowRecruit5;
      }
      
      public function set OnShowRecruit5(param1:Function) : void
      {
         this.FOnShowRecruit5 = param1;
      }
      
      public function get OnShowRecruit6() : Function
      {
         return this.FOnShowRecruit6;
      }
      
      public function set OnShowRecruit6(param1:Function) : void
      {
         this.FOnShowRecruit6 = param1;
      }
      
      public function get OnShowRecruit7() : Function
      {
         return this.FOnShowRecruit7;
      }
      
      public function set OnShowRecruit7(param1:Function) : void
      {
         this.FOnShowRecruit7 = param1;
      }
      
      public function get OnShowRecruit8() : Function
      {
         return this.FOnShowRecruit8;
      }
      
      public function set OnShowRecruit8(param1:Function) : void
      {
         this.FOnShowRecruit8 = param1;
      }
      
      public function UpdateUI() : void
      {
         this.FExchangeItems = SLogicsCore.Lottery.ExchangeItems;
         this.FTF_Point.text = SLogicsCore.Lottery.Point.toString();
         this.FUIPage.TotalQuantity = this.FExchangeItems.length;
         this.FUIPage.Update();
         this.UpdateSlot();
         this.UpdateHeroList();
      }
      
      public function PerformPacket_SC_ExchangeRet(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc3_ = int(this.FExchangeItems.length);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            if(this.FExchangeItems[_loc2_].Identify == param1)
            {
               ++this.FExchangeItems[_loc2_].BuyCount;
            }
            _loc2_++;
         }
         this.UpdateUI();
      }
   }
}

