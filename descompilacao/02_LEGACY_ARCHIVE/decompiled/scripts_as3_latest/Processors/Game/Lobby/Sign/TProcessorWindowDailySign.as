package Processors.Game.Lobby.Sign
{
   import Components.Pages.TUIPage;
   import Components.Standard.TUITab;
   import Foundation.Common.THint;
   import Foundation.Network.TPacket;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.Characters.TCharacter;
   import Logics.DailySign.TDailySign;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.DatebaseVO.VO.TSignContinuous;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.Inventories.TInventorySample;
   import Logics.SLogicsCore;
   import Processors.Game.Common.Effects.Display.TEffectBaseGlow;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.Sign.Components.Slot_Sine;
   import Processors.Game.Lobby.Sign.Components.TUIDay;
   import Processors.Game.Lobby.Sign.Components.TUIIntegralItem;
   import Processors.Game.Lobby.TreasureMap.ConsumeFrame;
   import Processors.Game.Windows.Information.TUIWindowConfirmation;
   import Processors.Game.Windows.Information.TUIWindowRecharge;
   import Resources.Constants.CONST_CONFIGVALUE;
   import Resources.Constants.CONST_DAILYSIGN;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Strings.STRING_DAILYSIGN;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   
   public class TProcessorWindowDailySign extends TProcessorLobbyWindow
   {
      
      public static const AwardBase:uint = CONST_DAILYSIGN.AwardBase;
      
      public static const Multiple:uint = CONST_DAILYSIGN.Multiple;
      
      public static const IndicesLog:Number = CONST_DAILYSIGN.IndicesLog;
      
      protected static const INTERVALTIME:Number = 172800000;
      
      protected static const FRAME_UnSign:uint = 1;
      
      protected static const FRAME_TemporarilyUnsign:uint = 2;
      
      protected static const FRAME_PastSign:uint = 3;
      
      protected static const FRAME_DaySign:uint = 4;
      
      protected static const CAPACITY_DAYS:uint = 42;
      
      protected static const CAPACITY_IntegralItems:uint = 12;
      
      public static const SYSTEMLANGUAGE_SIGN_NINJA_TIP:int = CONST_SYSTEMLANGUAGE.SYSTEMLANGUAGE_SIGN_NINJA_TIP;
      
      protected var SIZE_Window_Width:uint = 918;
      
      protected var SIZE_Window_Height:uint = 554;
      
      protected var FMC_DailySign:MovieClip;
      
      protected var FMC_Sign:MovieClip;
      
      protected var FMC_IntegralExchange:MovieClip;
      
      protected var FMC_EffectLeft:MovieClip;
      
      protected var FMC_EffectRight:MovieClip;
      
      protected var FBTN_Close:SimpleButton;
      
      protected var FBTN_Help:SimpleButton;
      
      protected var FUITab:TUITab;
      
      protected var FMC_LeiJiQianDao:MovieClip = null;
      
      protected var FTF_SignDec:TextField = null;
      
      protected var FSlotVec:Vector.<Slot_Sine> = null;
      
      protected var FTF_Today:TextField;
      
      protected var FMC_Alldays:MovieClip;
      
      protected var FBTN_DailySign:MovieClip;
      
      protected var FBTN_GetReward:MovieClip;
      
      protected var FTF_SignIntegral:TextField;
      
      protected var FTF_IntegralCost:TextField;
      
      protected var FMC_Reward:MovieClip;
      
      protected var FMC_RewardHero:MovieClip;
      
      protected var FMC_RewardItem:MovieClip;
      
      protected var FTFTodaySignRewardList:Vector.<TextField>;
      
      protected var FTFDailySignList:Vector.<TextField>;
      
      protected var FMCDayList:Vector.<TUIDay>;
      
      protected var FMC_Page:MovieClip;
      
      protected var FMC_IntegralItemList:Vector.<TUIIntegralItem>;
      
      protected var FUIPage:TUIPage;
      
      protected var FTabIndex:int;
      
      protected var FPageIndex:int;
      
      protected var FDailySign:TDailySign;
      
      protected var FUIWindowInformation:TUIWindowConfirmation;
      
      protected var FUIWindowRecharge:TUIWindowRecharge;
      
      protected var FDay:uint;
      
      protected var FToday:uint;
      
      protected var FHelpTips:THint;
      
      protected var EffectBaseGlow:TEffectBaseGlow = null;
      
      protected var FSignScoreLimit:uint;
      
      protected var FLastGetRewardId:uint;
      
      protected var FCurMonth:uint;
      
      protected var FIsGetReward:Boolean;
      
      protected var FCurConfigBin:TBins;
      
      protected var FHintOnMove:Function;
      
      protected var FHintOnOut:Function;
      
      protected var FOnCompensate:Function;
      
      protected var FOnExchange:Function;
      
      protected var FDownHintOnOver:Function;
      
      protected var FDownHintOnOut:Function;
      
      protected var FOnHelpTipsOver:Function;
      
      protected var FOnHelpTipsOut:Function;
      
      protected var FOnGetReward:Function;
      
      protected var FBackFun:Function;
      
      protected var FPlayEffectNewSign:Function;
      
      public function TProcessorWindowDailySign(param1:TUIComponent)
      {
         super(param1);
         this.FUITab = new TUITab(this);
         this.FUIPage = new TUIPage(this);
         this.FHelpTips = new THint();
         this.FTFTodaySignRewardList = new Vector.<TextField>(2);
         this.FTFDailySignList = new Vector.<TextField>(3);
         this.FMCDayList = new Vector.<TUIDay>(CAPACITY_DAYS);
         this.FMC_IntegralItemList = new Vector.<TUIIntegralItem>(CAPACITY_IntegralItems);
         this.FSlotVec = new Vector.<Slot_Sine>(28);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_DAILYSIGN.RESOURCESID_Swf_DailySign);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUIDay = null;
         var _loc4_:TUIIntegralItem = null;
         var _loc5_:MovieClip = null;
         var _loc6_:TextField = null;
         var _loc7_:TConfigValue = null;
         this.FMC_DailySign = TUtilityReflection.CreateDisplayObjectInstance(CONST_DAILYSIGN.RESOURCE_ClassName_MC_DailySign) as MovieClip;
         addChild(this.FMC_DailySign);
         this.FMC_Sign = this.FMC_DailySign[CONST_DAILYSIGN.RESOURCE_Link_MC_Sign];
         this.FMC_IntegralExchange = this.FMC_DailySign[CONST_DAILYSIGN.RESOURCE_Link_MC_IntegralExchange];
         this.FMC_IntegralExchange.visible = false;
         this.FMC_EffectLeft = this.FMC_DailySign[CONST_DAILYSIGN.RESOURCE_Link_MC_EffectLeft];
         this.FMC_EffectRight = this.FMC_DailySign[CONST_DAILYSIGN.RESOURCE_Link_MC_EffectRight];
         this.FBTN_Close = this.FMC_DailySign[CONST_DAILYSIGN.RESOURCE_Link_BTN_Close];
         this.FBTN_Help = this.FMC_DailySign[CONST_DAILYSIGN.RESOURCE_Link_BTN_Help];
         _loc2_ = 3;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.FUITab.SetTabByIndex(this.FMC_DailySign[CONST_DAILYSIGN.RESOURCE_Link_MC_Tab + _loc1_],_loc1_);
            _loc1_++;
         }
         this.FUITab.OnSwitch = this.TabOnSwitch;
         this.FUITab.Init();
         this.FTF_Today = this.FMC_Sign[CONST_DAILYSIGN.RESOURCE_Link_TF_Today];
         this.FMC_Alldays = this.FMC_Sign[CONST_DAILYSIGN.RESOURCE_Link_MC_Alldays];
         this.FBTN_DailySign = this.FMC_Sign[CONST_DAILYSIGN.RESOURCE_Link_BTN_DailySign];
         this.FBTN_GetReward = this.FMC_Sign[CONST_DAILYSIGN.RESOURCE_Link_BTN_GetReward];
         this.FTF_SignIntegral = this.FMC_Sign[CONST_DAILYSIGN.RESOURCE_Link_TF_SignIntegral];
         this.FTF_IntegralCost = this.FMC_Sign[CONST_DAILYSIGN.RESOURCE_Link_TF_IntegralCost];
         this.FMC_Reward = this.FMC_Sign[CONST_DAILYSIGN.RESOURCE_Link_MC_Reward];
         this.FMC_RewardHero = this.FMC_Reward[CONST_DAILYSIGN.RESOURCE_Link_MC_RewardHero];
         this.FMC_RewardItem = this.FMC_Reward[CONST_DAILYSIGN.RESOURCE_Link_MC_RewardItem];
         if(this.FMC_RewardHero)
         {
            this.FMC_RewardHero.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnNinjaOver);
            this.FMC_RewardHero.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnNinjaOut);
         }
         _loc2_ = this.FTFTodaySignRewardList.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.FTFTodaySignRewardList[_loc1_] = this.FMC_Sign[CONST_DAILYSIGN.RESOURCE_Link_TF_TodaySignReward + _loc1_];
            _loc1_++;
         }
         _loc2_ = this.FTFDailySignList.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.FTFDailySignList[_loc1_] = this.FMC_Sign[CONST_DAILYSIGN.RESOURCE_Link_TF_DailySign + _loc1_];
            _loc1_++;
         }
         this.FTFDailySignList[0].autoSize = "left";
         this.FTFDailySignList[2].autoSize = "left";
         _loc2_ = this.FMCDayList.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = new TUIDay(this);
            _loc3_.Resource = this.FMC_Alldays[CONST_DAILYSIGN.RESOURCE_Link_MC_Day + _loc1_];
            _loc3_.HintOnMove = this.HintOnMouseMove;
            _loc3_.HintOnOut = this.HintOnMouseOut;
            _loc3_.OnCompensate = this.ProcessorOnCompensate;
            _loc3_.Init();
            this.FMCDayList[_loc1_] = _loc3_;
            _loc1_++;
         }
         this.FMC_Page = this.FMC_IntegralExchange[CONST_DAILYSIGN.RESOURCE_Link_MC_Page];
         _loc5_ = this.FMC_Page[CONST_DAILYSIGN.RESOURCE_Link_MC_PageLeft];
         this.FUIPage.ButtonPrevious.Substrate = _loc5_;
         _loc5_ = this.FMC_Page[CONST_DAILYSIGN.RESOURCE_Link_MC_PageRight];
         this.FUIPage.ButtonNext.Substrate = _loc5_;
         _loc6_ = this.FMC_Page[CONST_DAILYSIGN.RESOURCE_Link_TF_Page];
         this.FUIPage.LabelPage = _loc6_;
         _loc6_.text = "0/0";
         this.FUIPage.PageSize = CAPACITY_IntegralItems;
         this.FUIPage.Init();
         this.FUIPage.OnChangePage = this.PageOnChange;
         _loc2_ = this.FMC_IntegralItemList.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc4_ = new TUIIntegralItem(this);
            _loc4_.Resource = this.FMC_IntegralExchange[CONST_DAILYSIGN.RESOURCE_Link_MC_Equip + _loc1_];
            _loc4_.OnExchange = this.ProcessorOnExchange;
            _loc4_.DownHintOnOver = this.UIDownHintOnOver;
            _loc4_.DownHintOnOut = this.UIDownHintOnOut;
            _loc4_.Init();
            this.FMC_IntegralItemList[_loc1_] = _loc4_;
            _loc1_++;
         }
         this.FUIWindowInformation = new TUIWindowConfirmation(this);
         this.FUIWindowInformation.OnOK = this.WindowInformationOnOK;
         this.FUIWindowInformation.x = (this.SIZE_Window_Width - this.FUIWindowInformation.WindowWidth) / 2;
         this.FUIWindowInformation.y = (this.SIZE_Window_Height - this.FUIWindowInformation.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowInformation);
         this.FUIWindowRecharge = new TUIWindowRecharge(this.Parent);
         this.FUIWindowRecharge.x = (STAGE_Width - this.FUIWindowRecharge.WindowWidth) / 2;
         this.FUIWindowRecharge.y = (STAGE_Height - this.FUIWindowRecharge.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowRecharge(this.FUIWindowRecharge);
         _loc7_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.SIGN_Sign_Limit) as TConfigValue;
         this.FSignScoreLimit = _loc7_.Value as uint;
         this.FMC_LeiJiQianDao = this.FMC_DailySign["MC_LeiJiQianDao"];
         this.FTF_SignDec = this.FMC_LeiJiQianDao["TF_SignDec"];
         this.EffectBaseGlow = new TEffectBaseGlow();
         this.EffectBaseGlow.SetParameters(this.FMC_DailySign[CONST_DAILYSIGN.RESOURCE_Link_MC_Tab + 2],15911245,1);
         this.FCurConfigBin = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_SignContinuous);
         _loc1_ = 0;
         while(_loc1_ < 28)
         {
            this.FSlotVec[_loc1_] = new Slot_Sine(this.FMC_LeiJiQianDao["MC_Slot_All"]["MC_Slot_" + _loc1_]);
            this.FSlotVec[_loc1_].BackFun = this.FBackFun;
            this.FSlotVec[_loc1_].FBackmoveFun = this.UIDownHintOnOver;
            this.FSlotVec[_loc1_].FBackoutFun = this.UIDownHintOnOut;
            _loc1_++;
         }
         if(!SLogicsCore.Character.GetConfigValueById(91000007))
         {
            this.FUITab.SetTabHideByIndex(2);
         }
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FBTN_Close.addEventListener(MouseEvent.CLICK,this.CloseOnClick,false,0,true);
         this.FBTN_Help.addEventListener(MouseEvent.MOUSE_MOVE,this.ButtonHelpOnOver,false,0,true);
         this.FBTN_Help.addEventListener(MouseEvent.MOUSE_OUT,this.ButtonHelpOnOut,false,0,true);
         this.FBTN_DailySign.addEventListener(MouseEvent.CLICK,this.BTNDailySignOnClick,false,0,true);
         this.FBTN_GetReward.addEventListener(MouseEvent.CLICK,this.BTNGetRewardOnClick,false,0,true);
         super.ResourcesPerform_UILocations();
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUIIntegralItem = null;
         if(!this.FMC_LeiJiQianDao)
         {
            return;
         }
         if(!this.visible)
         {
            return;
         }
         _loc2_ = this.FMC_IntegralItemList.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FMC_IntegralItemList[_loc1_];
            if(_loc3_ != null)
            {
               _loc3_.UpdateSlot();
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < 28)
         {
            this.FSlotVec[_loc1_].UpdateImage();
            _loc1_++;
         }
         if(this.EffectBaseGlow.visible)
         {
            this.EffectBaseGlow.Run();
         }
         super.LogicsPerform();
      }
      
      protected function UpdateUITab() : void
      {
         this.FTabIndex = 0;
         this.FUITab.SwithTagManual(0);
         this.TabOnSwitch(0);
      }
      
      protected function UpdateUISign() : void
      {
         this.UpdateTextAndButtonState();
         this.UpdateUIDay();
      }
      
      protected function UpdateUIIntegralExchange() : void
      {
         this.UpdateExchangeText();
         this.UpdatePageInfo();
         this.UpdateUIIntegralItem();
      }
      
      protected function UpdateExchangeText() : void
      {
         this.FMC_IntegralExchange["TF_SignIntegral"].text = SLogicsCore.Character.CreditIntegral.toString() + "/" + this.FSignScoreLimit;
         this.FMC_IntegralExchange["TF_IntegralCost"].text = this.FTF_IntegralCost.text;
      }
      
      protected function UpdatePageInfo() : void
      {
         this.FPageIndex = 0;
         this.FUIPage.TotalQuantity = this.FDailySign.ExchangeReward.Count;
         this.FUIPage.PageIndex = this.FPageIndex;
         this.FUIPage.Update();
      }
      
      protected function UpdateTextAndButtonState() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:TConfigValue = null;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc4_:RegExp = /\\n/g;
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.SIGN_Sign_mark) as TConfigValue;
         this.FTF_Today.text = TUtilityDate.FormatDate(new Date(STimingCore.GetServerTime() * 1000));
         _loc1_ = uint(SLogicsCore.Character.GetMainLevel() * IndicesLog * AwardBase) * Multiple;
         _loc2_ = CONST_DAILYSIGN.GetGiftCertificateByDay(new Date(STimingCore.GetServerTime() * 1000).date);
         this.FTFTodaySignRewardList[0].text = STRING_DAILYSIGN.STRING_Coin + _loc1_;
         this.FTFTodaySignRewardList[1].text = STRING_DAILYSIGN.STRING_GIFTCERTIFICATE + _loc2_;
         this.FTF_SignIntegral.text = SLogicsCore.Character.CreditIntegral.toString() + "/" + this.FSignScoreLimit;
         this.FTF_IntegralCost.text = TUtilityString.Format(STRING_DAILYSIGN.STRING_IntegralCost,_loc3_.Value,this.FSignScoreLimit);
         if((this.FDailySign.SignTotalDays > 10 || this.FDailySign.SignTotalDays == 10 && this.FDailySign.CircleRewardID != 0) && this.FDailySign.SignReward == null)
         {
            _loc5_ = uint(this.FDailySign.SignReward_Circle.Day);
            _loc6_ = this.FDailySign.CircleSignTotalDays % 15;
            if(_loc5_ == 15 && this.FDailySign.CircleSignTotalDays % _loc5_ == 0)
            {
               _loc6_ = 15;
            }
            this.FMC_RewardItem.gotoAndPlay(1);
            this.FMC_RewardHero.visible = false;
            this.FMC_RewardItem.visible = true;
            this.FMC_RewardItem["MC_Icon"]["TF_Text"].htmlText = this.FDailySign.SignReward_Circle.Desc.replace(_loc4_,"<br>");
         }
         else
         {
            if(!this.FDailySign.SignReward)
            {
               return;
            }
            _loc5_ = uint(this.FDailySign.SignReward.Day);
            _loc6_ = uint(this.FDailySign.SignTotalDays);
            if(this.FDailySign.RewardID == 1)
            {
               this.FMC_RewardHero.gotoAndPlay(1);
               this.FMC_RewardHero.visible = true;
               this.FMC_RewardItem.visible = false;
            }
            else
            {
               this.FMC_RewardItem.gotoAndPlay(1);
               this.FMC_RewardHero.visible = false;
               this.FMC_RewardItem.visible = true;
               this.FMC_RewardItem["MC_Icon"]["TF_Text"].htmlText = this.FDailySign.SignReward.Desc.replace(_loc4_,"<br>");
            }
            this.FBTN_GetReward.visible = true;
         }
         if(Boolean(this.FDailySign.IsCanGetReward) || _loc6_ >= _loc5_)
         {
            this.FTFDailySignList[0].text = STRING_DAILYSIGN.STRING_CanGet;
            this.FTFDailySignList[1].text = "";
            this.FTFDailySignList[2].text = "";
            TGameUtil.setButtonMode(this.FBTN_GetReward,true);
            this.FBTN_GetReward.mouseEnabled = true;
         }
         else if(_loc6_ < _loc5_)
         {
            this.FTFDailySignList[0].text = STRING_DAILYSIGN.STRING_SignA;
            this.FTFDailySignList[1].text = TUtilityString.Format(STRING_DAILYSIGN.STRING_SignB,_loc5_ - _loc6_);
            this.FTFDailySignList[2].text = STRING_DAILYSIGN.STRING_SignC;
            TGameUtil.setButtonMode(this.FBTN_GetReward,false);
            this.FBTN_GetReward.mouseEnabled = false;
         }
      }
      
      protected function UpdateUIDay() : void
      {
         var _loc1_:* = 0;
         var _loc2_:uint = 0;
         var _loc3_:Date = null;
         var _loc4_:Date = null;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:int = 0;
         var _loc10_:TUIDay = null;
         var _loc11_:Date = null;
         _loc3_ = new Date(STimingCore.GetServerTime() * 1000);
         _loc4_ = new Date(STimingCore.GetServerTime() * 1000);
         _loc11_ = new Date(this.FDailySign.ServerStartDate * 1000);
         this.FToday = _loc4_.date;
         if(_loc4_.month > this.FDailySign.CurrentMonth)
         {
            _loc2_ = this.FDailySign.DayList.length;
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               this.FDailySign.DayList.pop();
               _loc1_++;
            }
            this.FDailySign.DayList.length = 0;
            _loc2_ = uint(TUtilityDate.GetMonthDaysByDate(_loc3_));
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               this.FDailySign.DayList.push("0");
               _loc1_++;
            }
         }
         else
         {
            _loc2_ = TUtilityDate.GetMonthDaysByDate(_loc3_) - this.FDailySign.DayList.length;
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               this.FDailySign.DayList.push("0");
               _loc1_++;
            }
         }
         if(this.FDailySign.DayList[_loc4_.date - 1] == "0")
         {
            TGameUtil.setButtonMode(this.FBTN_DailySign,true);
            this.FBTN_DailySign.mouseEnabled = true;
         }
         else
         {
            TGameUtil.setButtonMode(this.FBTN_DailySign,false);
            this.FBTN_DailySign.mouseEnabled = false;
         }
         _loc3_.setDate(1);
         _loc5_ = _loc3_.getDay();
         _loc6_ = _loc5_ % 7;
         _loc7_ = _loc3_.getDate();
         _loc8_ = 0;
         _loc2_ = uint(TUtilityDate.GetMonthDaysByDate(_loc3_));
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc10_ = this.FMCDayList[_loc6_ + _loc1_];
            _loc10_.Day = _loc7_;
            _loc10_.SetTextInfo(_loc7_++);
            _loc9_ = _loc7_ - 2;
            _loc8_ = _loc9_ + 1;
            if(this.FDailySign.DayList[_loc9_] == "0")
            {
               _loc10_.IsSign = false;
               if(_loc8_ < _loc4_.date)
               {
                  if(_loc11_.fullYearUTC == _loc4_.fullYearUTC)
                  {
                     if(_loc11_.month < _loc4_.month)
                     {
                        _loc10_.SetUIInfo(FRAME_PastSign);
                     }
                     else if(_loc11_.month == _loc4_.month)
                     {
                        if(_loc11_.date <= _loc8_)
                        {
                           _loc10_.SetUIInfo(FRAME_PastSign);
                        }
                        else
                        {
                           _loc10_.SetUIInfo(FRAME_UnSign);
                        }
                     }
                  }
                  else
                  {
                     _loc10_.SetUIInfo(FRAME_PastSign);
                  }
               }
               else if(_loc8_ > _loc4_.date)
               {
                  _loc10_.SetUIInfo(FRAME_TemporarilyUnsign);
               }
               else
               {
                  _loc10_.SetUIInfo(FRAME_DaySign);
               }
            }
            else
            {
               _loc10_.IsSign = true;
               if(_loc8_ < _loc4_.date)
               {
                  _loc10_.SetUIInfo(FRAME_PastSign);
               }
               else if(_loc8_ == _loc4_.date)
               {
                  _loc10_.SetUIInfo(FRAME_DaySign);
               }
            }
            _loc1_++;
         }
         _loc7_ = uint(TUtilityDate.GetMonthDaysByDate(new Date(_loc3_.getTime() - INTERVALTIME)));
         _loc1_ = int(_loc6_ - 1);
         while(_loc1_ > -1)
         {
            _loc10_ = this.FMCDayList[_loc1_];
            _loc10_.SetTextInfo(_loc7_--);
            _loc10_.SetUIInfo(FRAME_UnSign);
            _loc1_--;
         }
         _loc7_ = 1;
         _loc1_ = int(_loc2_ + _loc6_);
         while(_loc1_ < CAPACITY_DAYS)
         {
            _loc10_ = this.FMCDayList[_loc1_];
            _loc10_.SetTextInfo(_loc7_++);
            _loc10_.SetUIInfo(FRAME_UnSign);
            _loc1_++;
         }
      }
      
      protected function UpdateUIIntegralItem() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:TUIIntegralItem = null;
         _loc3_ = CAPACITY_IntegralItems;
         _loc1_ = 0;
         while(_loc1_ < _loc3_)
         {
            _loc2_ = _loc1_ + this.FPageIndex * _loc3_;
            _loc4_ = this.FMC_IntegralItemList[_loc1_];
            if(_loc2_ >= this.FDailySign.ExchangeReward.Count)
            {
               _loc4_.Resource.visible = false;
            }
            else
            {
               _loc4_.Resource.visible = true;
            }
            _loc1_++;
         }
         this.UpdateIntegralItemInfo();
      }
      
      protected function UpdateIntegralItemInfo() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUIIntegralItem = null;
         _loc2_ = CAPACITY_IntegralItems;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FMC_IntegralItemList[_loc1_];
            if(_loc1_ + this.FPageIndex * _loc2_ >= this.FDailySign.ExchangeReward.Count)
            {
               return;
            }
            _loc3_.SetItemInfo(this.FDailySign.ExchangeReward.GetInventorySampleByIndex(_loc1_ + this.FPageIndex * _loc2_));
            _loc1_++;
         }
      }
      
      protected function ButtonHelpOnOver(param1:MouseEvent) : void
      {
         var _loc2_:TSystemLanguage = null;
         if(this.FOnHelpTipsOver != null)
         {
            _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.HELPTIPS_Sign) as TSystemLanguage;
            this.FHelpTips.Content = _loc2_.Desc;
            this.FOnHelpTipsOver(this,this.FHelpTips);
         }
      }
      
      protected function ButtonHelpOnOut(param1:MouseEvent) : void
      {
         if(this.FOnHelpTipsOut != null)
         {
            this.FOnHelpTipsOut(this);
         }
      }
      
      protected function CloseOnClick(param1:MouseEvent) : void
      {
         ProcessorWindowClose();
      }
      
      protected function TabOnSwitch(param1:Object) : void
      {
         this.FTabIndex = param1 as int;
         this.FMC_Sign.visible = false;
         this.FMC_IntegralExchange.visible = false;
         this.FMC_LeiJiQianDao.visible = false;
         switch(this.FTabIndex)
         {
            case 0:
               this.FMC_Sign.visible = true;
               this.UpdateUISign();
               this.UpdateTabEffect();
               break;
            case 1:
               this.FMC_IntegralExchange.visible = true;
               this.UpdateUIIntegralExchange();
               this.UpdateTabEffect();
               break;
            case 2:
               this.FMC_LeiJiQianDao.visible = true;
         }
      }
      
      protected function PageOnChange(param1:Object, param2:int) : void
      {
         this.FPageIndex = param2;
         this.UpdateUIIntegralItem();
      }
      
      protected function BTNDailySignOnClick(param1:MouseEvent) : void
      {
         if(SLogicsCore.Character.CreditIntegral >= this.FSignScoreLimit)
         {
            EffectGenerateText(STRING_DAILYSIGN.STRING_IntegralFull);
            return;
         }
         if(this.FOnCompensate != null)
         {
            this.FOnCompensate(this,this.FToday);
         }
      }
      
      protected function BTNGetRewardOnClick(param1:MouseEvent) : void
      {
         if(this.FOnGetReward != null)
         {
            this.FOnGetReward(this);
         }
      }
      
      protected function WindowInformationOnOK(param1:Object) : void
      {
         if(SLogicsCore.Character.CreditIntegral >= this.FSignScoreLimit)
         {
            EffectGenerateText(STRING_DAILYSIGN.STRING_IntegralFull);
            return;
         }
         if(this.FOnCompensate != null)
         {
            this.FOnCompensate(this,this.FDay);
         }
      }
      
      protected function ProcessorOnCompensate(param1:Object, param2:uint) : void
      {
         var _loc3_:TConfigValue = null;
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.SIGN_Sign_gold) as TConfigValue;
         var _loc4_:TCharacter = SLogicsCore.Character;
         if(_loc3_.Value > _loc4_.CreditGold + _loc4_.CreditGiftCertificate)
         {
            this.FUIWindowRecharge.visible = true;
            return;
         }
         this.FUIWindowInformation.Text = TUtilityString.Format(new ConsumeFrame(CONST_SYSTEMLANGUAGE.ConsumerConfirm_Sign_Retroactive).DescribeString,_loc3_.Value);
         this.FUIWindowInformation.Visible = true;
         this.FDay = param2 as uint;
      }
      
      protected function ProcessorOnExchange(param1:Object, param2:TInventorySample) : void
      {
         if(this.FOnExchange != null)
         {
            this.FOnExchange(this,param2);
         }
      }
      
      protected function HintOnMouseMove(param1:Object, param2:THint) : void
      {
         if(this.FHintOnMove != null)
         {
            this.FHintOnMove(this,param2);
         }
      }
      
      protected function HintOnMouseOut(param1:Object) : void
      {
         if(this.FHintOnOut != null)
         {
            this.FHintOnOut(this);
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
      
      protected function ProcessorOnNinjaOver(param1:MouseEvent) : void
      {
         var _loc2_:TSystemLanguage = null;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,SYSTEMLANGUAGE_SIGN_NINJA_TIP) as TSystemLanguage;
         if(_loc2_)
         {
            this.FHelpTips.Content = _loc2_.Desc;
            this.FOnHelpTipsOver(this,this.FHelpTips);
         }
      }
      
      public function PACKETID_SC_Reward_NewInfo(param1:TPacket) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:ByteArray = param1.Data;
         var _loc5_:TSignContinuous = null;
         this.FLastGetRewardId = _loc2_.readUnsignedInt();
         this.FCurMonth = _loc2_.readUnsignedInt();
         this.FIsGetReward = Boolean(_loc2_.readUnsignedInt());
         this.FDailySign.SignTotalDaysCopy = _loc2_.readUnsignedInt();
         if(!this.FTF_SignDec)
         {
            return;
         }
         this.FTF_SignDec.text = TUtilityString.Format(STRING_DAILYSIGN.STRING_LeiJiDec,this.FDailySign.SignTotalDaysCopy);
         _loc3_ = 0;
         while(_loc3_ < this.FCurConfigBin.Count)
         {
            _loc5_ = this.FCurConfigBin.GetDatebaseByIndex(_loc3_) as TSignContinuous;
            if(this.FCurMonth == _loc5_.Round)
            {
               _loc4_ = _loc5_.Identifier - CONST_DAILYSIGN.RESOURCESID_ID_MILLDLE;
               break;
            }
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < 28)
         {
            _loc5_ = this.FCurConfigBin.GetDatebaseByIndex(_loc4_ + _loc3_ - 1) as TSignContinuous;
            this.FSlotVec[_loc3_].DateSine = this.FDailySign;
            if(this.FCurMonth == _loc5_.Round)
            {
               this.FSlotVec[_loc3_].SetDate(_loc5_,_loc3_ + 1,this.FCurConfigBin);
               this.FSlotVec[_loc3_].UpdateStateById(this.FLastGetRewardId,this.FIsGetReward);
            }
            else
            {
               this.FSlotVec[_loc3_].SetDate(null,_loc3_,this.FCurConfigBin);
            }
            _loc3_++;
         }
         this.UpdateTabEffect();
      }
      
      protected function ProcessorOnNinjaOut(param1:MouseEvent) : void
      {
         if(this.FOnHelpTipsOut != null)
         {
            this.FOnHelpTipsOut(this);
         }
      }
      
      public function get HintOnMove() : Function
      {
         return this.FHintOnMove;
      }
      
      public function set HintOnMove(param1:Function) : void
      {
         this.FHintOnMove = param1;
      }
      
      public function get HintOnOut() : Function
      {
         return this.FHintOnOut;
      }
      
      public function set HintOnOut(param1:Function) : void
      {
         this.FHintOnOut = param1;
      }
      
      public function get OnCompensate() : Function
      {
         return this.FOnCompensate;
      }
      
      public function set OnCompensate(param1:Function) : void
      {
         this.FOnCompensate = param1;
      }
      
      public function get OnExchange() : Function
      {
         return this.FOnExchange;
      }
      
      public function set OnExchange(param1:Function) : void
      {
         this.FOnExchange = param1;
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
      
      public function get OnHelpTipsOver() : Function
      {
         return this.FOnHelpTipsOver;
      }
      
      public function set OnHelpTipsOver(param1:Function) : void
      {
         this.FOnHelpTipsOver = param1;
      }
      
      public function get OnHelpTipsOut() : Function
      {
         return this.FOnHelpTipsOut;
      }
      
      public function set OnHelpTipsOut(param1:Function) : void
      {
         this.FOnHelpTipsOut = param1;
      }
      
      public function get OnGetReward() : Function
      {
         return this.FOnGetReward;
      }
      
      public function set OnGetReward(param1:Function) : void
      {
         this.FOnGetReward = param1;
      }
      
      public function set BackFun(param1:Function) : void
      {
         this.FBackFun = param1;
      }
      
      public function set PlayEffectNewSign(param1:Function) : void
      {
         this.FPlayEffectNewSign = param1;
      }
      
      public function set DailySign(param1:TDailySign) : void
      {
         this.FDailySign = param1;
      }
      
      public function Init() : void
      {
         this.UpdateUITab();
         this.UpdateUISign();
      }
      
      public function UpdateUI() : void
      {
         this.UpdateUISign();
      }
      
      public function PlayEffect() : void
      {
         this.FMC_EffectLeft.play();
         this.FMC_EffectRight.play();
      }
      
      public function UpdateIntegralInfo() : void
      {
         this.UpdateExchangeText();
         this.UpdateUIIntegralItem();
      }
      
      public function UpdateReward() : void
      {
         this.UpdateTextAndButtonState();
      }
      
      protected function UpdateTabEffect(param1:Boolean = false) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Boolean = false;
         _loc2_ = 0;
         while(_loc2_ < 28)
         {
            if(this.FSlotVec[_loc2_].IsCanClick)
            {
               _loc3_ = true;
               break;
            }
            _loc2_++;
         }
         if(param1)
         {
            _loc3_ = false;
         }
         if(_loc3_)
         {
            this.EffectBaseGlow.Run();
            this.EffectBaseGlow.visible = true;
         }
         else
         {
            this.EffectBaseGlow.Stop();
            this.EffectBaseGlow.visible = false;
         }
         if(!this.FDailySign.TempValue)
         {
            if(this.FPlayEffectNewSign != null)
            {
               this.FPlayEffectNewSign(_loc3_);
            }
         }
      }
   }
}

