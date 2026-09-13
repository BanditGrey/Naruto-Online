package Processors.Game.Lobby.Exercise.SignGift
{
   import Foundation.Network.TPacket;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Characters.TCharacter;
   import Logics.Exercise.SignGift.TSignGift;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Exercise.TUnstreamizerSignGift;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIShowItem;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorBaseActivity;
   import Processors.Game.Lobby.Tavern.TProcessorWindowRecruit;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   import ghostcat.util.easing.TweenUtil;
   
   public class TProcessorSignGift extends TProcessorBaseActivity
   {
      
      protected static const BOX_COUNT:int = 4;
      
      protected static const SALE_COUNT:int = 6;
      
      protected static const DAYS_COUNT:int = 42;
      
      protected static const INTERVALTIME:Number = 172800000;
      
      public static const ACTIVITY_1_SIGN:int = 1;
      
      public static const ACTIVITY_1_BUY_SIGN:int = 2;
      
      public static const ACTIVITY_1_GET_BOX:int = 3;
      
      public static const ACTIVITY_1_BUY_BOX:int = 4;
      
      public static const ACTIVITY_1_GET_RECHARGE_BOX:int = 5;
      
      protected var FBeClicked:Boolean;
      
      protected var FIsOpen:Boolean;
      
      protected var FBuyBoxDate:Object;
      
      protected var FCost:int;
      
      protected var FIsPlaying:Boolean;
      
      protected var FWindowType:int;
      
      protected var FMovieType:int;
      
      protected var FOpenIndex:int;
      
      protected var FFrameCount:int;
      
      protected var FTotalFrame:int;
      
      protected var FPlayMovie:MovieClip;
      
      protected var FSignGift:TSignGift;
      
      protected var FUnstreamizerSignGift:TUnstreamizerSignGift;
      
      protected var FBoxList:Vector.<MovieClip>;
      
      protected var FTodayItem:TUIShowItem;
      
      protected var FTomorrowItem:TUIShowItem;
      
      protected var FSaleItems:Vector.<TUIShowItem>;
      
      protected var FMC_AllDays:Vector.<MovieClip>;
      
      protected var FFirstDayIndex:int;
      
      protected var FToday:int;
      
      protected var FMonthDays:int;
      
      protected var ServerStartDate:Date;
      
      protected var FBeginDay:int;
      
      protected var FEndDay:int;
      
      protected var FBeginIsCurMonth:Boolean;
      
      protected var FEndIsCurMonth:Boolean;
      
      protected var FBetweenDays:int;
      
      protected var FProcessorWindowRecruit:TProcessorWindowRecruit;
      
      protected var FFirst:Boolean;
      
      public function TProcessorSignGift(param1:TUIComponent, param2:TLobbyParameters, param3:uint)
      {
         super(param1,param2,param3);
         FActivityID = param3;
         this.FSignGift = SLogicsCore.SignGift;
         this.FUnstreamizerSignGift = new TUnstreamizerSignGift();
         this.FBuyBoxDate = new Object();
         this.FBoxList = new Vector.<MovieClip>(BOX_COUNT);
         this.FSaleItems = new Vector.<TUIShowItem>(SALE_COUNT);
         this.FMC_AllDays = new Vector.<MovieClip>(DAYS_COUNT);
         this.FProcessorWindowRecruit = new TProcessorWindowRecruit(this.Parent);
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:TUIShowItem = null;
         var _loc6_:TUIShowItem = null;
         super.ResourcesPerform_UIDispatch();
         _loc1_ = 0;
         while(_loc1_ < BOX_COUNT)
         {
            this.FBoxList[_loc1_] = FMC_Scene["MC_Box" + _loc1_];
            this.FBoxList[_loc1_].buttonMode = true;
            this.FBoxList[_loc1_].MC_BoxPic.gotoAndStop(_loc1_ + 1);
            this.FBoxList[_loc1_].MC_BoxPic.addEventListener(MouseEvent.CLICK,this.ProcessorOnGetSignBoxUp);
            this.FBoxList[_loc1_].MC_BoxPic.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnBoxOver);
            this.FBoxList[_loc1_].MC_BoxPic.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnNewBoxOut);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < SALE_COUNT)
         {
            _loc6_ = new TUIShowItem(this,1);
            _loc6_.Perform_UIDispatch(FMC_Scene.MC_Sale["MC_Box" + _loc1_]);
            _loc6_.OnOverlay = UIComponentsHintOnOver;
            _loc6_.OnOut = UIComponentsHintOnOut;
            _loc6_.OnShowRecruit = this.ProcessorOnShowRecruit;
            this.FSaleItems[_loc1_] = _loc6_;
            TGameUtil.setButtonMode(FMC_Scene.MC_Sale["MC_Box" + _loc1_].BTN_Buy,true);
            FMC_Scene.MC_Sale["MC_Box" + _loc1_].BTN_Buy.addEventListener(MouseEvent.CLICK,this.ProcessorOnBuyItemUp);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < DAYS_COUNT)
         {
            this.FMC_AllDays[_loc1_] = FMC_Scene["day_" + _loc1_];
            this.FMC_AllDays[_loc1_].addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnDayOver);
            this.FMC_AllDays[_loc1_].addEventListener(MouseEvent.ROLL_OUT,ProcessorOnNewBoxOut);
            _loc1_++;
         }
         this.FTodayItem = new TUIShowItem(this,1);
         this.FTodayItem.Perform_UIDispatch(FMC_Scene.MC_TodayItem);
         this.FTodayItem.OnOverlay = UIComponentsHintOnOver;
         this.FTodayItem.OnOut = UIComponentsHintOnOut;
         this.FTodayItem.OnShowRecruit = this.ProcessorOnShowRecruit;
         this.FTomorrowItem = new TUIShowItem(this,1);
         this.FTomorrowItem.Perform_UIDispatch(FMC_Scene.MC_TomorrowItem);
         this.FTomorrowItem.OnOverlay = UIComponentsHintOnOver;
         this.FTomorrowItem.OnOut = UIComponentsHintOnOut;
         this.FTomorrowItem.OnShowRecruit = this.ProcessorOnShowRecruit;
         TGameUtil.setButtonMode(FMC_Scene.BTN_Sign,true);
         FMC_Scene.BTN_Sign.addEventListener(MouseEvent.CLICK,this.ProcessorOnSignUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Buy,true);
         FMC_Scene.BTN_Buy.addEventListener(MouseEvent.CLICK,this.ProcessorOnBuySignUp);
         FMC_Scene.BTN_Buy.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnBuySignOver);
         FMC_Scene.BTN_Buy.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlText);
         TGameUtil.setButtonMode(FMC_Scene.MC_Box,true);
         FMC_Scene.MC_Box.addEventListener(MouseEvent.CLICK,this.ProcessorOnRechargeGiftUp);
         FMC_Scene.MC_Box.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnRechargeGiftOver);
         FMC_Scene.MC_Box.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnNewBoxOut);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Log,true);
         FMC_Scene.BTN_Log.addEventListener(MouseEvent.CLICK,this.PerformPacket_CS_LoadLogReq);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Desc,true);
         FMC_Scene.BTN_Desc.addEventListener(MouseEvent.CLICK,this.ProcessorOnOpenDesc);
         this.FProcessorWindowRecruit = new TProcessorWindowRecruit(this.Parent);
         this.FProcessorWindowRecruit.Visible = false;
         this.FProcessorWindowRecruit.OnEffectText = FOnEffectText;
         this.FProcessorWindowRecruit.HintOnOver = ProcessorTipOnOver;
         this.FProcessorWindowRecruit.HintOnOut = ProcessorTipOnOut;
         this.FProcessorWindowRecruit.x = (CONST_COMMON.STAGE_Width - 390) / 2;
         this.FProcessorWindowRecruit.y = (CONST_COMMON.STAGE_Height - 358) / 2;
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         super.LogicsPerform();
         if(Boolean(FInitialized) && Boolean(FMC_Scene) && FMC_Scene.visible)
         {
            if(this.FTodayItem)
            {
               this.FTodayItem.LogicsPerform();
            }
            if(this.FTomorrowItem)
            {
               this.FTomorrowItem.LogicsPerform();
            }
            _loc1_ = 0;
            while(_loc1_ < this.FSaleItems.length)
            {
               if(this.FSaleItems[_loc1_])
               {
                  this.FSaleItems[_loc1_].LogicsPerform();
               }
               _loc1_++;
            }
            if(this.FProcessorWindowRecruit != null && this.FProcessorWindowRecruit.Visible)
            {
               this.FProcessorWindowRecruit.UpdataBitmap();
            }
         }
      }
      
      override protected function UpdateUI() : void
      {
         this.UpdateText();
         this.UpdateSale();
         this.UpdateSignBox();
         this.UpdateDays();
         this.UpdateToday();
         this.UpdateRechargeGift();
      }
      
      protected function UpdateText() : void
      {
         var _loc1_:int = 0;
         var _loc2_:String = null;
         var _loc3_:int = 0;
         FMC_Scene.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FSignGift.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FSignGift.EndTime) - 1) * 1000)));
         FMC_Scene.TF_Desc.text = this.FSignGift.DescListNew[1];
         FMC_Scene.TF_BoxDesc.text = this.FSignGift.DescListNew[4];
         FMC_Scene.TF_RechargeGold.text = this.FSignGift.TotalRechargeGold.toString();
      }
      
      protected function UpdateRechargeGift() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:TBaseBox = null;
         _loc1_ = FMC_Scene.MC_Box;
         _loc2_ = this.FSignGift.RechargeGift;
         if(_loc2_.Status == TBaseActivity.STATUS_CANGET)
         {
            _loc1_.MC_Click.visible = true;
            _loc1_.MC_Got.visible = false;
         }
         else if(_loc2_.Status == TBaseActivity.STATUS_CANNOTGET)
         {
            _loc1_.MC_Click.visible = false;
            _loc1_.MC_Got.visible = false;
         }
         else
         {
            _loc1_.MC_Click.visible = false;
            _loc1_.MC_Got.visible = true;
         }
      }
      
      protected function UpdateSale() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TBaseBox = null;
         var _loc3_:MovieClip = null;
         _loc1_ = 0;
         while(_loc1_ < this.FSignGift.ShopExchangeItems.length)
         {
            _loc2_ = this.FSignGift.ShopExchangeItems[_loc1_];
            this.FSaleItems[_loc1_].UpdateUI(_loc2_.Inventories);
            if(_loc2_.LimitCount <= 0)
            {
               TGameUtil.setButtonMode(FMC_Scene.MC_Sale["MC_Box" + _loc1_].BTN_Buy,false);
            }
            else
            {
               TGameUtil.setButtonMode(FMC_Scene.MC_Sale["MC_Box" + _loc1_].BTN_Buy,true);
            }
            _loc1_++;
         }
      }
      
      protected function UpdateSignBox() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TBaseBox = null;
         var _loc3_:MovieClip = null;
         _loc1_ = 0;
         while(_loc1_ < this.FSignGift.BoxList.length)
         {
            _loc2_ = this.FSignGift.BoxList[_loc1_];
            _loc3_ = FMC_Scene["MC_Box" + _loc1_];
            _loc3_.TF_Desc.text = TUtilityString.Format(this.FSignGift.DescListNew[2],_loc2_.Price);
            if(_loc2_.Status == TBaseActivity.STATUS_CANGET)
            {
               _loc3_.MC_Click.visible = true;
               _loc3_.MC_Got.visible = false;
            }
            else if(_loc2_.Status == TBaseActivity.STATUS_CANNOTGET)
            {
               _loc3_.MC_Click.visible = false;
               _loc3_.MC_Got.visible = false;
            }
            else
            {
               _loc3_.MC_Click.visible = false;
               _loc3_.MC_Got.visible = true;
            }
            _loc1_++;
         }
      }
      
      public function UpdateDays() : void
      {
         var _loc1_:* = 0;
         var _loc2_:uint = 0;
         var _loc3_:Date = null;
         var _loc4_:Date = null;
         var _loc5_:Date = null;
         var _loc6_:uint = 0;
         var _loc7_:* = 0;
         var _loc8_:uint = 0;
         var _loc9_:int = 0;
         var _loc10_:MovieClip = null;
         var _loc11_:Date = null;
         var _loc12_:Date = null;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         _loc3_ = new Date(STimingCore.GetServerTime() * 1000);
         _loc4_ = new Date(STimingCore.GetServerTime() * 1000);
         _loc5_ = new Date(STimingCore.GetServerTime() * 1000);
         this.FToday = _loc4_.getDate();
         _loc11_ = new Date(STimingCore.GetClientShowTime(this.FSignGift.BeginTime) * 1000);
         _loc11_.setMinutes(0);
         this.FBeginDay = _loc11_.getDate();
         _loc12_ = new Date(STimingCore.GetClientShowTime(this.FSignGift.EndTime) * 1000);
         this.FEndDay = _loc12_.getDate();
         this.FBeginIsCurMonth = _loc11_.month == _loc3_.month ? true : false;
         this.FEndIsCurMonth = _loc12_.month == _loc3_.month ? true : false;
         _loc3_.setDate(1);
         _loc5_.setHours(0);
         _loc6_ = _loc3_.getDay();
         this.FFirstDayIndex = _loc6_ % 7;
         if(this.FFirstDayIndex == 0)
         {
            this.FFirstDayIndex = 7;
         }
         _loc7_ = uint(_loc3_.getDate());
         _loc8_ = 0;
         this.FBetweenDays = TUtilityDate.BetweenDays(_loc11_,_loc3_);
         _loc2_ = uint(TUtilityDate.GetMonthDaysByDate(_loc3_));
         this.FMonthDays = _loc2_;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc10_ = this.FMC_AllDays[this.FFirstDayIndex + _loc1_];
            _loc10_.TF_Day.text = _loc7_.toString();
            _loc9_ = ++_loc7_ - 2;
            _loc8_ = _loc9_ + 1;
            if(_loc1_ < this.FToday - 1)
            {
               _loc10_.gotoAndStop(3);
            }
            else if(_loc1_ == this.FToday - 1)
            {
               _loc10_.gotoAndStop(4);
            }
            else
            {
               _loc10_.gotoAndStop(2);
            }
            if(this.FBeginIsCurMonth && this.FEndIsCurMonth)
            {
               if(_loc1_ + 1 >= this.FBeginDay && _loc1_ + 1 <= this.FEndDay)
               {
                  _loc13_ = _loc1_ + 1 - this.FBeginDay;
                  if(this.FSignGift.DayList[_loc13_].Status == TBaseActivity.STATUS_CANGET)
                  {
                     _loc10_.MC_SelectBox.visible = true;
                     _loc10_.MC_Got.visible = false;
                  }
                  else if(this.FSignGift.DayList[_loc13_].Status == TBaseActivity.STATUS_CANNOTGET)
                  {
                     _loc10_.MC_SelectBox.visible = false;
                     _loc10_.MC_Got.visible = false;
                  }
                  else
                  {
                     _loc10_.MC_SelectBox.visible = false;
                     _loc10_.MC_Got.visible = true;
                  }
               }
               else
               {
                  _loc10_.gotoAndStop(1);
                  _loc10_.MC_SelectBox.visible = false;
                  _loc10_.MC_Got.visible = false;
               }
            }
            else if(!this.FBeginIsCurMonth && this.FEndIsCurMonth)
            {
               if(_loc1_ + 1 <= this.FEndDay)
               {
                  _loc13_ = this.FBetweenDays + _loc1_;
                  if(this.FSignGift.DayList[_loc13_].Status == TBaseActivity.STATUS_CANGET)
                  {
                     _loc10_.MC_SelectBox.visible = true;
                     _loc10_.MC_Got.visible = false;
                  }
                  else if(this.FSignGift.DayList[_loc13_].Status == TBaseActivity.STATUS_CANNOTGET)
                  {
                     _loc10_.MC_SelectBox.visible = false;
                     _loc10_.MC_Got.visible = false;
                  }
                  else
                  {
                     _loc10_.MC_SelectBox.visible = false;
                     _loc10_.MC_Got.visible = true;
                  }
               }
               else
               {
                  _loc10_.gotoAndStop(1);
                  _loc10_.MC_SelectBox.visible = false;
                  _loc10_.MC_Got.visible = false;
               }
            }
            else if(this.FBeginIsCurMonth && !this.FEndIsCurMonth)
            {
               if(_loc1_ + 1 >= this.FBeginDay)
               {
                  _loc13_ = _loc1_ + 1 - this.FBeginDay;
                  if(this.FSignGift.DayList[_loc13_].Status == TBaseActivity.STATUS_CANGET)
                  {
                     _loc10_.MC_SelectBox.visible = true;
                     _loc10_.MC_Got.visible = false;
                  }
                  else if(this.FSignGift.DayList[_loc13_].Status == TBaseActivity.STATUS_CANNOTGET)
                  {
                     _loc10_.MC_SelectBox.visible = false;
                     _loc10_.MC_Got.visible = false;
                  }
                  else
                  {
                     _loc10_.MC_SelectBox.visible = false;
                     _loc10_.MC_Got.visible = true;
                  }
               }
               else
               {
                  _loc10_.gotoAndStop(1);
                  _loc10_.MC_SelectBox.visible = false;
                  _loc10_.MC_Got.visible = false;
               }
            }
            else
            {
               _loc13_ = this.FBetweenDays + _loc1_;
               if(this.FSignGift.DayList[_loc13_].Status == TBaseActivity.STATUS_CANGET)
               {
                  _loc10_.MC_SelectBox.visible = true;
                  _loc10_.MC_Got.visible = false;
               }
               else if(this.FSignGift.DayList[_loc13_].Status == TBaseActivity.STATUS_CANNOTGET)
               {
                  _loc10_.MC_SelectBox.visible = false;
                  _loc10_.MC_Got.visible = false;
               }
               else
               {
                  _loc10_.MC_SelectBox.visible = false;
                  _loc10_.MC_Got.visible = true;
               }
            }
            _loc1_++;
         }
         _loc7_ = uint(TUtilityDate.GetMonthDaysByDate(new Date(_loc3_.getTime() - INTERVALTIME)));
         _loc1_ = int(this.FFirstDayIndex - 1);
         while(_loc1_ > -1)
         {
            _loc10_ = this.FMC_AllDays[_loc1_];
            _loc10_.TF_Day.text = _loc7_.toString();
            _loc10_.gotoAndStop(1);
            _loc10_.MC_SelectBox.visible = false;
            _loc10_.MC_Got.visible = false;
            _loc7_--;
            _loc1_--;
         }
         _loc7_ = 1;
         _loc1_ = int(_loc2_ + this.FFirstDayIndex);
         while(_loc1_ < DAYS_COUNT)
         {
            _loc10_ = this.FMC_AllDays[_loc1_];
            _loc10_.TF_Day.text = _loc7_.toString();
            _loc10_.gotoAndStop(1);
            _loc10_.MC_SelectBox.visible = false;
            _loc10_.MC_Got.visible = false;
            _loc7_++;
            _loc1_++;
         }
         this.FTodayItem.UpdateUI(this.FSignGift.DayList[this.FSignGift.CurDay - 1].Inventories);
         if(this.FSignGift.CurDay < this.FSignGift.DayList.length)
         {
            FMC_Scene.MC_TomorrowItem.visible = true;
            this.FTomorrowItem.UpdateUI(this.FSignGift.DayList[this.FSignGift.CurDay].Inventories);
         }
         else
         {
            FMC_Scene.MC_TomorrowItem.visible = false;
         }
      }
      
      protected function UpdateToday() : void
      {
         if(this.FSignGift.CurStatus == TBaseActivity.STATUS_CANGET)
         {
            TGameUtil.setButtonMode(FMC_Scene.BTN_Sign,true);
         }
         else
         {
            TGameUtil.setButtonMode(FMC_Scene.BTN_Sign,false);
         }
         if(this.FSignGift.BuySignDay == 0)
         {
            TGameUtil.setButtonMode(FMC_Scene.BTN_Buy,false);
         }
         else
         {
            TGameUtil.setButtonMode(FMC_Scene.BTN_Buy,true);
         }
      }
      
      override protected function PerformPacket_CS_LoadInfoReq() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:int = 0;
         super.PerformPacket_CS_LoadInfoReq();
      }
      
      protected function ProcessorOnBuyItemUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(6));
         if(!this.FIsPlaying && Boolean(this.FSignGift))
         {
            this.ProcessorOnBuyBoxUp(ACTIVITY_1_BUY_BOX,this.FSignGift.ShopExchangeItems[_loc2_].Min,_loc2_ + 1);
         }
      }
      
      protected function ProcessorOnSignUp(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(!this.FIsPlaying)
         {
            this.ProcessorOnGetBoxUp(ACTIVITY_1_SIGN);
         }
      }
      
      protected function ProcessorOnBuySignUp(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:Date = null;
         var _loc4_:TInventory = null;
         var _loc5_:String = null;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(!this.FIsPlaying)
         {
            _loc3_ = new Date((STimingCore.GetClientShowTime(this.FSignGift.BeginTime) + (this.FSignGift.BuySignDay - 1) * 60 * 60 * 24) * 1000);
            _loc4_ = this.FSignGift.DayList[this.FSignGift.BuySignDay - 1].Inventories.GetInventoryByIndex(0);
            _loc5_ = _loc4_.Name + "*" + _loc4_.Quantity;
            _loc2_ = TUtilityString.Format(this.FSignGift.DescListNew[3],this.FSignGift.SignCost,_loc3_.getMonth() + 1,_loc3_.getDate(),_loc5_);
            this.ProcessorOnBuyBoxUp(ACTIVITY_1_BUY_SIGN,this.FSignGift.SignCost,0,0,_loc2_);
         }
      }
      
      protected function ProcessorOnBuySignOver(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:Date = null;
         var _loc4_:TInventory = null;
         var _loc5_:String = null;
         if(Boolean(this.FSignGift) && this.FSignGift.BuySignDay > 0)
         {
            _loc3_ = new Date((STimingCore.GetClientShowTime(this.FSignGift.BeginTime) + (this.FSignGift.BuySignDay - 1) * 60 * 60 * 24) * 1000);
            _loc4_ = this.FSignGift.DayList[this.FSignGift.BuySignDay - 1].Inventories.GetInventoryByIndex(0);
            _loc5_ = _loc4_.Name + "*" + _loc4_.Quantity;
            _loc2_ = TUtilityString.Format(this.FSignGift.DescListNew[3],this.FSignGift.SignCost,_loc3_.getMonth() + 1,_loc3_.getDate(),_loc5_);
            ProcessorOnShowHtmlText(_loc2_);
         }
      }
      
      protected function ProcessorOnGetSignBoxUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(6));
         if(Boolean(!this.FIsPlaying) && Boolean(this.FSignGift) && this.FSignGift.BoxList[_loc2_].Status == TBaseActivity.STATUS_CANGET)
         {
            this.ProcessorOnGetBoxUp(ACTIVITY_1_GET_BOX,_loc2_ + 1);
         }
      }
      
      protected function ProcessorOnBoxOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(6));
         if(this.FSignGift)
         {
            ProcessorOnNewBoxOver(this.FSignGift.BoxList[_loc2_].Inventories);
         }
      }
      
      protected function ProcessorOnRechargeGiftUp(param1:MouseEvent) : void
      {
         if(Boolean(this.FSignGift) && this.FSignGift.RechargeGift.Status == TBaseActivity.STATUS_CANGET)
         {
            this.ProcessorOnGetBoxUp(ACTIVITY_1_GET_RECHARGE_BOX);
         }
      }
      
      protected function ProcessorOnRechargeGiftOver(param1:MouseEvent) : void
      {
         if(this.FSignGift)
         {
            ProcessorOnNewBoxOver(this.FSignGift.RechargeGift.Inventories);
         }
      }
      
      protected function ProcessorOnDayOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TInventories = null;
         _loc2_ = int(String(param1.currentTarget.name).slice(4));
         if(_loc2_ < this.FFirstDayIndex || _loc2_ > this.FMonthDays + this.FFirstDayIndex - 1)
         {
            return;
         }
         _loc2_ -= this.FFirstDayIndex;
         if(this.FBeginIsCurMonth && this.FEndIsCurMonth)
         {
            if(!(_loc2_ + 1 >= this.FBeginDay && _loc2_ + 1 <= this.FEndDay))
            {
               return;
            }
            _loc3_ = _loc2_ + 1 - this.FBeginDay;
         }
         else if(!this.FBeginIsCurMonth && this.FEndIsCurMonth)
         {
            if(_loc2_ + 1 > this.FEndDay)
            {
               return;
            }
            _loc3_ = this.FBetweenDays + _loc2_;
         }
         else if(this.FBeginIsCurMonth && !this.FEndIsCurMonth)
         {
            if(_loc2_ + 1 < this.FBeginDay)
            {
               return;
            }
            _loc3_ = _loc2_ + 1 - this.FBeginDay;
         }
         else
         {
            _loc3_ = this.FBetweenDays + _loc2_;
         }
         _loc4_ = this.FSignGift.DayList[_loc3_].Inventories;
         if(_loc4_ != null && _loc4_.Count > 0)
         {
            ProcessorOnNewBoxOver(_loc4_);
         }
      }
      
      protected function ProcessorOnShowRecruit(param1:uint, param2:int = 0) : void
      {
         if(param2 == TBaseBox.TYPE_IS_HERO)
         {
            this.FProcessorWindowRecruit.SetHeroData(param1);
         }
         else if(param2 == TBaseBox.TYPE_IS_PET)
         {
            FProcessorWindowPetDesc.SetPetData(param1);
         }
      }
      
      protected function ProcessorOnBuyBoxUp(param1:int, param2:int, param3:int = 0, param4:int = 0, param5:String = "", param6:int = 0, param7:int = 0) : void
      {
         if(this.FBeClicked || this.FIsPlaying)
         {
            return;
         }
         this.FBuyBoxDate.ActivityType = param1;
         this.FBuyBoxDate.BoxIndex = param3;
         this.FBuyBoxDate.Cost = param2;
         this.FBuyBoxDate.CostType = param4;
         this.FBuyBoxDate.BoxIndex1 = param6;
         this.FBuyBoxDate.ConfirmType = param7;
         if(param4 != TBaseActivity.SWEET_TYPE_GOLD)
         {
            this.ProcessorOnGetBoxUp(this.FBuyBoxDate.ActivityType,this.FBuyBoxDate.BoxIndex,this.FBuyBoxDate.BoxIndex1);
            return;
         }
         if(!FUIWindowConfirmation.IsSelected)
         {
            this.FCost = param2;
            if(param5 != "")
            {
               FUIWindowConfirmation.Text = param5;
            }
            else
            {
               FUIWindowConfirmation.Text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_ConfirmGold,this.FCost);
            }
            FUIWindowConfirmation.SetCheckBox(true);
            FUIWindowConfirmation.Visible = true;
         }
         else
         {
            this.WindowConfirmationOnOK();
         }
      }
      
      override protected function WindowConfirmationOnOK(param1:Object = null) : void
      {
         var _loc2_:TCharacter = null;
         _loc2_ = SLogicsCore.Character;
         if(_loc2_.CreditGold >= this.FBuyBoxDate.Cost)
         {
            this.ProcessorOnGetBoxUp(this.FBuyBoxDate.ActivityType,this.FBuyBoxDate.BoxIndex,this.FBuyBoxDate.BoxIndex1);
         }
         else
         {
            FUIWindowRecharge.Visible = true;
         }
      }
      
      protected function ProcessorOnGetBoxUp(param1:int, param2:int = 0, param3:int = 0) : void
      {
         var _loc4_:TPacket = null;
         var _loc5_:int = 0;
         var _loc6_:Vector.<int> = null;
         if(this.FBeClicked || this.FIsPlaying)
         {
            return;
         }
         this.FBeClicked = true;
         _loc6_ = new Vector.<int>();
         if(param2 != 0)
         {
            _loc6_.push(param2);
         }
         if(param3 != 0)
         {
            _loc6_.push(param3);
         }
         PerformPacket_CS_AllReq(param1,_loc6_);
      }
      
      override protected function ProcessorOnOpenDesc(param1:MouseEvent = null) : void
      {
         FProcessorWindowDesc.BaseActivity = this.FSignGift;
         super.ProcessorOnOpenDesc();
      }
      
      override protected function PerformPacket_CS_LoadLogReq(param1:MouseEvent = null) : void
      {
         PerformPacket_CS_AcitivityThird_LoadLogReq(1,null);
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount(param1);
         if(!FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowRecruit.Load();
            return;
         }
         this.visible = true;
         this.alpha = 1;
         this.FIsOpen = true;
         if(FMC_EffectLeft)
         {
            FMC_EffectLeft.play();
         }
         if(FMC_EffectRight)
         {
            FMC_EffectRight.play();
         }
         this.PerformPacket_CS_LoadInfoReq();
         SetInterval();
      }
      
      override public function Unmount() : void
      {
         super.Unmount();
         this.visible = false;
         this.FIsOpen = false;
         TweenUtil.removeAllTween();
      }
      
      override public function ProcessorOnLoadInfoRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            OnClose(this);
            return;
         }
         this.FUnstreamizerSignGift.Unstreamize(_loc2_,this.FSignGift,null);
         if(FIsResourcesLoadCompleted && this.visible)
         {
            this.UpdateUI();
         }
      }
      
      override public function ProcessorChangeGold(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         _loc2_ = param1.Data;
         _loc2_.readShort();
         if(Boolean(this.FSignGift) && Boolean(this.FSignGift.RechargeGift))
         {
            this.FSignGift.TotalRechargeGold = _loc2_.readUnsignedInt();
            this.FSignGift.RechargeGift.Status = _loc2_.readInt();
            if(this.FIsOpen)
            {
               this.UpdateUI();
            }
         }
      }
      
      override public function ProcessorActivityThirdLoadLogRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:TBaseActivity = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            ProcessorClose();
            return;
         }
         _loc4_ = int(_loc2_.readUnsignedInt());
         ProcessorUnstreamActivityLog(this.FSignGift,_loc2_);
      }
      
      override public function ProcessorAllRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:TInventories = null;
         var _loc9_:TInventory = null;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         var _loc13_:TBaseBox = null;
         var _loc14_:uint = 0;
         var _loc15_:TBins = null;
         var _loc16_:int = 0;
         var _loc17_:int = 0;
         var _loc18_:int = 0;
         var _loc19_:int = 0;
         var _loc20_:uint = 0;
         var _loc21_:Vector.<uint> = null;
         var _loc22_:Vector.<uint> = null;
         var _loc23_:String = null;
         var _loc24_:int = 0;
         _loc15_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         this.FBeClicked = false;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc7_ = int(_loc2_.readUnsignedInt());
         _loc2_.readShort();
         switch(_loc7_)
         {
            case ACTIVITY_1_BUY_BOX:
               _loc5_ = _loc2_.readUnsignedInt() - 1;
               --this.FSignGift.ShopExchangeItems[_loc5_].LimitCount;
               --this.FSignGift.ShopExchangeItems[_loc5_].Inventories.GetInventoryByIndex(0).LimitCount;
               _loc4_ = STRING_BASEACTIVITY.FORMAT_BUY_SUCCESSED;
               ProcessorEffectText(_loc4_);
               this.FSignGift.ChangeStatus();
               ProcessorCheckEffect(FActivityID,this.FSignGift.CheckStatus());
               this.UpdateUI();
               break;
            case ACTIVITY_1_SIGN:
               ++this.FSignGift.TotalSign;
               this.FSignGift.CurStatus = TBaseActivity.STATUS_GETED;
               _loc5_ = this.FSignGift.CurDay - 1;
               this.FSignGift.DayList[_loc5_].Status = TBaseActivity.STATUS_GETED;
               _loc8_ = this.FSignGift.DayList[_loc5_].Inventories;
               _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
               _loc5_ = 0;
               while(_loc5_ < _loc8_.Count)
               {
                  _loc9_ = _loc8_.GetInventoryByIndex(_loc5_);
                  _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                  _loc5_++;
               }
               ProcessorEffectText(_loc4_);
               this.FSignGift.ChangeStatus();
               ProcessorCheckEffect(FActivityID,this.FSignGift.CheckStatus());
               this.UpdateUI();
               break;
            case ACTIVITY_1_BUY_SIGN:
               ++this.FSignGift.TotalSign;
               _loc5_ = _loc2_.readUnsignedInt() - 1;
               this.FSignGift.BuySignDay = _loc2_.readUnsignedInt();
               this.FSignGift.DayList[_loc5_].Status = TBaseActivity.STATUS_GETED;
               _loc8_ = this.FSignGift.DayList[_loc5_].Inventories;
               _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
               _loc5_ = 0;
               while(_loc5_ < _loc8_.Count)
               {
                  _loc9_ = _loc8_.GetInventoryByIndex(_loc5_);
                  _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                  _loc5_++;
               }
               ProcessorEffectText(_loc4_);
               this.FSignGift.ChangeStatus();
               ProcessorCheckEffect(FActivityID,this.FSignGift.CheckStatus());
               this.UpdateUI();
               break;
            case ACTIVITY_1_GET_BOX:
               _loc5_ = _loc2_.readUnsignedInt() - 1;
               this.FSignGift.BoxList[_loc5_].Status = TBaseActivity.STATUS_GETED;
               _loc8_ = this.FSignGift.BoxList[_loc5_].Inventories;
               _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
               _loc5_ = 0;
               while(_loc5_ < _loc8_.Count)
               {
                  _loc9_ = _loc8_.GetInventoryByIndex(_loc5_);
                  _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                  _loc5_++;
               }
               ProcessorEffectText(_loc4_);
               this.FSignGift.ChangeStatus();
               ProcessorCheckEffect(FActivityID,this.FSignGift.CheckStatus());
               this.UpdateUI();
               break;
            case ACTIVITY_1_GET_RECHARGE_BOX:
               this.FSignGift.RechargeGift.Status = TBaseActivity.STATUS_CANNOTGET;
               ProcessorEffectText(STRING_BASEACTIVITY.FORMAT_GET);
               this.FSignGift.ChangeStatus();
               ProcessorCheckEffect(FActivityID,this.FSignGift.CheckStatus());
               this.UpdateUI();
         }
      }
      
      public function PlayMovie(param1:int = 0, param2:Boolean = false) : void
      {
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:int = 0;
         var _loc6_:TInventory = null;
         var _loc7_:String = null;
         this.FIsPlaying = true;
         this.FMovieType = param1;
      }
      
      public function MovieEnd() : void
      {
         var _loc1_:int = 0;
         var _loc2_:String = null;
         this.FIsPlaying = false;
      }
      
      public function Test() : ByteArray
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:ByteArray = new ByteArray();
         _loc3_.position = 0;
         return _loc3_;
      }
   }
}

