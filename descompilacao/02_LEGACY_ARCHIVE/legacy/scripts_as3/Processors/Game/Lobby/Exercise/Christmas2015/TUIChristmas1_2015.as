package Processors.Game.Lobby.Exercise.Christmas2015
{
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.Christmas2015.TChristmas1_2015;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIShowItem;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import ghostcat.util.easing.TweenUtil;
   
   public class TUIChristmas1_2015 extends TUIBaseWindow
   {
      
      protected static const BOX_COUNT:int = 4;
      
      protected static const SALE_COUNT:int = 6;
      
      protected static const DAYS_COUNT:int = 42;
      
      protected static const INTERVALTIME:Number = 172800000;
      
      protected static const ACTIVITY_1_ID:int = 1;
      
      protected var FChristmas1_2015:TChristmas1_2015;
      
      protected var FMovieType:int;
      
      protected var FFrameCount:int;
      
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
      
      public function TUIChristmas1_2015(param1:TUIComponent)
      {
         super(param1);
         this.FBoxList = new Vector.<MovieClip>(BOX_COUNT);
         this.FSaleItems = new Vector.<TUIShowItem>(SALE_COUNT);
         this.FMC_AllDays = new Vector.<MovieClip>(DAYS_COUNT);
      }
      
      override protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TUIShowItem = null;
         var _loc5_:MovieClip = null;
         var _loc6_:MovieClip = null;
         super.Resources_UIDispatch(param1);
         _loc2_ = 0;
         while(_loc2_ < BOX_COUNT)
         {
            this.FBoxList[_loc2_] = FMC_Scene["MC_Box" + _loc2_];
            this.FBoxList[_loc2_].buttonMode = true;
            this.FBoxList[_loc2_].MC_BoxPic.gotoAndStop(_loc2_ + 1);
            this.FBoxList[_loc2_].MC_BoxPic.addEventListener(MouseEvent.CLICK,this.ProcessorOnGetBoxUp);
            this.FBoxList[_loc2_].MC_BoxPic.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnBoxOver);
            this.FBoxList[_loc2_].MC_BoxPic.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnNewBoxOut);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < SALE_COUNT)
         {
            _loc4_ = new TUIShowItem(this,1);
            _loc4_.Perform_UIDispatch(FMC_Scene.MC_Sale["MC_Box" + _loc2_]);
            _loc4_.OnOverlay = this.ProcessorOnItemOver;
            _loc4_.OnOut = this.ProcessorOnItemOut;
            _loc4_.OnShowRecruit = this.ProcessorOnShowRecruit;
            this.FSaleItems[_loc2_] = _loc4_;
            TGameUtil.setButtonMode(FMC_Scene.MC_Sale["MC_Box" + _loc2_].BTN_Buy,true);
            FMC_Scene.MC_Sale["MC_Box" + _loc2_].BTN_Buy.addEventListener(MouseEvent.CLICK,this.ProcessorOnBuyBoxUp);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < DAYS_COUNT)
         {
            this.FMC_AllDays[_loc2_] = FMC_Scene["day_" + _loc2_];
            this.FMC_AllDays[_loc2_].addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnDayOver);
            this.FMC_AllDays[_loc2_].addEventListener(MouseEvent.ROLL_OUT,ProcessorOnNewBoxOut);
            _loc2_++;
         }
         this.FTodayItem = new TUIShowItem(this,1);
         this.FTodayItem.Perform_UIDispatch(FMC_Scene.MC_TodayItem);
         this.FTodayItem.OnOverlay = this.ProcessorOnItemOver;
         this.FTodayItem.OnOut = this.ProcessorOnItemOut;
         this.FTodayItem.OnShowRecruit = this.ProcessorOnShowRecruit;
         this.FTomorrowItem = new TUIShowItem(this,1);
         this.FTomorrowItem.Perform_UIDispatch(FMC_Scene.MC_TomorrowItem);
         this.FTomorrowItem.OnOverlay = this.ProcessorOnItemOver;
         this.FTomorrowItem.OnOut = this.ProcessorOnItemOut;
         this.FTomorrowItem.OnShowRecruit = this.ProcessorOnShowRecruit;
         TGameUtil.setButtonMode(FMC_Scene.BTN_Sign,true);
         FMC_Scene.BTN_Sign.addEventListener(MouseEvent.CLICK,this.ProcessorOnSignUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_BuySign,true);
         FMC_Scene.BTN_BuySign.addEventListener(MouseEvent.CLICK,this.ProcessorOnBuySignUp);
         FMC_Scene.BTN_BuySign.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnBuySignOver);
         FMC_Scene.BTN_BuySign.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Log,true);
         FMC_Scene.BTN_Log.addEventListener(MouseEvent.CLICK,this.ProcessorOnLoadLog);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Desc,true);
         FMC_Scene.BTN_Desc.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowDesc);
      }
      
      protected function UpdateText() : void
      {
         var _loc1_:int = 0;
         var _loc2_:String = null;
         var _loc3_:int = 0;
         FMC_Scene.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FChristmas1_2015.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FChristmas1_2015.EndTime) - 1) * 1000)));
         FMC_Scene.TF_Desc.text = this.FChristmas1_2015.DescListNew[1];
      }
      
      protected function UpdateSale() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TBaseBox = null;
         var _loc3_:MovieClip = null;
         _loc1_ = 0;
         while(_loc1_ < this.FChristmas1_2015.ShopExchangeItems.length)
         {
            _loc2_ = this.FChristmas1_2015.ShopExchangeItems[_loc1_];
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
         while(_loc1_ < this.FChristmas1_2015.BoxList.length)
         {
            _loc2_ = this.FChristmas1_2015.BoxList[_loc1_];
            _loc3_ = FMC_Scene["MC_Box" + _loc1_];
            _loc3_.TF_Desc.text = TUtilityString.Format(this.FChristmas1_2015.DescListNew[2],_loc2_.Price);
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
         _loc11_ = new Date(STimingCore.GetClientShowTime(this.FChristmas1_2015.BeginTime) * 1000);
         _loc11_.setMinutes(0);
         this.FBeginDay = _loc11_.getDate();
         _loc12_ = new Date(STimingCore.GetClientShowTime(this.FChristmas1_2015.EndTime) * 1000);
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
                  if(this.FChristmas1_2015.DayList[_loc13_].Status == TBaseActivity.STATUS_CANGET)
                  {
                     _loc10_.MC_SelectBox.visible = true;
                     _loc10_.MC_Got.visible = false;
                  }
                  else if(this.FChristmas1_2015.DayList[_loc13_].Status == TBaseActivity.STATUS_CANNOTGET)
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
                  if(this.FChristmas1_2015.DayList[_loc13_].Status == TBaseActivity.STATUS_CANGET)
                  {
                     _loc10_.MC_SelectBox.visible = true;
                     _loc10_.MC_Got.visible = false;
                  }
                  else if(this.FChristmas1_2015.DayList[_loc13_].Status == TBaseActivity.STATUS_CANNOTGET)
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
                  if(this.FChristmas1_2015.DayList[_loc13_].Status == TBaseActivity.STATUS_CANGET)
                  {
                     _loc10_.MC_SelectBox.visible = true;
                     _loc10_.MC_Got.visible = false;
                  }
                  else if(this.FChristmas1_2015.DayList[_loc13_].Status == TBaseActivity.STATUS_CANNOTGET)
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
               if(this.FChristmas1_2015.DayList[_loc13_].Status == TBaseActivity.STATUS_CANGET)
               {
                  _loc10_.MC_SelectBox.visible = true;
                  _loc10_.MC_Got.visible = false;
               }
               else if(this.FChristmas1_2015.DayList[_loc13_].Status == TBaseActivity.STATUS_CANNOTGET)
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
         this.FTodayItem.UpdateUI(this.FChristmas1_2015.DayList[this.FChristmas1_2015.CurDay - 1].Inventories);
         if(this.FChristmas1_2015.CurDay < this.FChristmas1_2015.DayList.length)
         {
            FMC_Scene.MC_TomorrowItem.visible = true;
            this.FTomorrowItem.UpdateUI(this.FChristmas1_2015.DayList[this.FChristmas1_2015.CurDay].Inventories);
         }
         else
         {
            FMC_Scene.MC_TomorrowItem.visible = false;
         }
      }
      
      protected function UpdateToday() : void
      {
         if(this.FChristmas1_2015.CurStatus == TBaseActivity.STATUS_CANGET)
         {
            TGameUtil.setButtonMode(FMC_Scene.BTN_Sign,true);
         }
         else
         {
            TGameUtil.setButtonMode(FMC_Scene.BTN_Sign,false);
         }
         if(this.FChristmas1_2015.BuySignDay == 0)
         {
            TGameUtil.setButtonMode(FMC_Scene.BTN_BuySign,false);
         }
         else
         {
            TGameUtil.setButtonMode(FMC_Scene.BTN_BuySign,true);
         }
      }
      
      protected function ProcessorOnBuyBoxUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(6));
         if(!FIsPlaying && FOnBuyBox != null && Boolean(this.FChristmas1_2015))
         {
            FOnBuyBox(ACTIVITY_1_ID,TProcessorChristmas2015.ACTIVITY_1_BUY_BOX,this.FChristmas1_2015.ShopExchangeItems[_loc2_].Min,_loc2_ + 1);
         }
      }
      
      protected function ProcessorOnSignUp(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(!FIsPlaying && FOnGetBox != null)
         {
            FOnGetBox(ACTIVITY_1_ID,TProcessorChristmas2015.ACTIVITY_1_SIGN);
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
         if(!FIsPlaying && FOnGetBox != null)
         {
            _loc3_ = new Date((STimingCore.GetClientShowTime(this.FChristmas1_2015.BeginTime) + (this.FChristmas1_2015.BuySignDay - 1) * 60 * 60 * 24) * 1000);
            _loc4_ = this.FChristmas1_2015.DayList[this.FChristmas1_2015.BuySignDay - 1].Inventories.GetInventoryByIndex(0);
            _loc5_ = _loc4_.Name + "*" + _loc4_.Quantity;
            _loc2_ = TUtilityString.Format(this.FChristmas1_2015.DescListNew[3],this.FChristmas1_2015.SignCost,_loc3_.getMonth() + 1,_loc3_.getDate(),_loc5_);
            FOnBuyBox(ACTIVITY_1_ID,TProcessorChristmas2015.ACTIVITY_1_BUY_SIGN,this.FChristmas1_2015.SignCost,0,0,_loc2_);
         }
      }
      
      protected function ProcessorOnBuySignOver(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:Date = null;
         var _loc4_:TInventory = null;
         var _loc5_:String = null;
         if(Boolean(this.FChristmas1_2015) && this.FChristmas1_2015.BuySignDay > 0)
         {
            _loc3_ = new Date((STimingCore.GetClientShowTime(this.FChristmas1_2015.BeginTime) + (this.FChristmas1_2015.BuySignDay - 1) * 60 * 60 * 24) * 1000);
            _loc4_ = this.FChristmas1_2015.DayList[this.FChristmas1_2015.BuySignDay - 1].Inventories.GetInventoryByIndex(0);
            _loc5_ = _loc4_.Name + "*" + _loc4_.Quantity;
            _loc2_ = TUtilityString.Format(this.FChristmas1_2015.DescListNew[3],this.FChristmas1_2015.SignCost,_loc3_.getMonth() + 1,_loc3_.getDate(),_loc5_);
            FOnShowHtmlTip(_loc2_);
         }
      }
      
      override protected function ProcessorOnGetBoxUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(6));
         if(Boolean(!FIsPlaying && FOnGetBox != null) && Boolean(this.FChristmas1_2015) && this.FChristmas1_2015.BoxList[_loc2_].Status == TBaseActivity.STATUS_CANGET)
         {
            FOnGetBox(ACTIVITY_1_ID,TProcessorChristmas2015.ACTIVITY_1_GET_BOX,_loc2_ + 1);
         }
      }
      
      override protected function ProcessorOnBoxOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(6));
         if(this.FChristmas1_2015)
         {
            FOnNewBoxOver(this.FChristmas1_2015.BoxList[_loc2_].Inventories);
         }
      }
      
      protected function ProcessorOnDayOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TInventories = null;
         if(FOnNewBoxOver != null)
         {
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
            _loc4_ = this.FChristmas1_2015.DayList[_loc3_].Inventories;
            if(_loc4_ != null && _loc4_.Count > 0)
            {
               FOnNewBoxOver(_loc4_);
            }
         }
      }
      
      protected function ProcessorOnItemOver(param1:Object, param2:Object) : void
      {
         if(FOnItemOver != null)
         {
            FOnItemOver(param1,param2);
         }
      }
      
      protected function ProcessorOnItemOut(param1:Object, param2:Object) : void
      {
         if(FOnItemOut != null)
         {
            FOnItemOut(param1,param2);
         }
      }
      
      protected function ProcessorOnShowRecruit(param1:uint, param2:int) : void
      {
         if(FOnShowRecruit != null)
         {
            FOnShowRecruit(param1,param2);
         }
      }
      
      protected function ProcessorOnLoadLog(param1:MouseEvent) : void
      {
         if(FOnLoadLog != null)
         {
            FOnLoadLog(ACTIVITY_1_ID);
         }
      }
      
      protected function ProcessorOnShowDesc(param1:MouseEvent) : void
      {
         if(FOnShowDesc != null)
         {
            FOnShowDesc();
         }
      }
      
      override public function Perform_UIDispatch(param1:MovieClip) : void
      {
         super.Perform_UIDispatch(param1);
      }
      
      override public function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         if(FInitialized && this.visible && FMC_Scene.visible)
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
         }
      }
      
      override public function UpdateUI() : void
      {
         this.FChristmas1_2015 = SLogicsCore.ChristmasDatas_2015.GetActivityByIdentify(ACTIVITY_1_ID) as TChristmas1_2015;
         this.UpdateText();
         this.UpdateSale();
         this.UpdateSignBox();
         this.UpdateDays();
         this.UpdateToday();
      }
      
      override public function PlayMovie(param1:int = 0, param2:Boolean = false) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:MovieClip = null;
         var _loc6_:int = 0;
         var _loc7_:String = null;
         this.FMovieType = param1;
         FIsPlaying = true;
      }
      
      override public function MovieEnd() : void
      {
         var _loc1_:int = 0;
         var _loc2_:String = null;
         FIsPlaying = false;
      }
      
      override public function Unmount() : void
      {
         var _loc1_:int = 0;
         TweenUtil.removeAllTween();
      }
   }
}

