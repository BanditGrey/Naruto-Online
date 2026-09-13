package Processors.Game.Lobby.Exercise.BrazilCarnival.Compoents
{
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.BrazilCarnival.TBrazilCarnivalSign;
   import Logics.Exercise.TBaseActivity;
   import Logics.Inventories.TInventories;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Exercise.BrazilCarnival.TProcessorBrazilCarnival;
   import Processors.Game.Lobby.Exercise.Christmas.Compoents.TUIChristmasBase;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class TUIBrazilCarnivalSign extends TUIChristmasBase
   {
      
      protected static const DAYS_COUNT:int = 42;
      
      protected static const INTERVALTIME:Number = 172800000;
      
      protected static const ACTIVITY_1_ID:int = 1;
      
      protected var FMC_AllDays:Vector.<MovieClip>;
      
      protected var FBrazilCarnivalSign:TBrazilCarnivalSign;
      
      protected var FFirstDayIndex:int;
      
      protected var FToday:int;
      
      protected var FMonthDays:int;
      
      protected var ServerStartDate:Date;
      
      public function TUIBrazilCarnivalSign(param1:TUIComponent)
      {
         super(param1);
         this.FMC_AllDays = new Vector.<MovieClip>(DAYS_COUNT);
      }
      
      override protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         super.Resources_UIDispatch(param1);
         _loc2_ = 0;
         while(_loc2_ < DAYS_COUNT)
         {
            this.FMC_AllDays[_loc2_] = FMC_Scene["day_" + _loc2_];
            this.FMC_AllDays[_loc2_].addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnDayOver);
            this.FMC_AllDays[_loc2_].addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnDayOut);
            _loc2_++;
         }
         TGameUtil.setButtonMode(FMC_Scene.BTN_Get,true);
         FMC_Scene.BTN_Get.addEventListener(MouseEvent.CLICK,this.ProcessorOnGetBoxUp);
         FMC_Scene.MC_Box.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnBoxOver);
         FMC_Scene.MC_Box.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnBoxOut);
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
         _loc3_ = new Date(STimingCore.GetServerTime() * 1000);
         _loc4_ = new Date(STimingCore.GetServerTime() * 1000);
         _loc5_ = new Date(STimingCore.GetServerTime() * 1000);
         this.FToday = _loc4_.getDate();
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
         _loc2_ = uint(TUtilityDate.GetMonthDaysByDate(_loc3_));
         this.FMonthDays = _loc2_;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc10_ = this.FMC_AllDays[this.FFirstDayIndex + _loc1_];
            _loc10_.TF_Day.text = _loc7_.toString();
            _loc9_ = ++_loc7_ - 2;
            _loc8_ = _loc9_ + 1;
            if(this.FBrazilCarnivalSign.DayList[_loc1_].Status == TBaseActivity.STATUS_CANGET)
            {
               _loc10_.MC_SelectBox.visible = true;
               _loc10_.MC_Got.visible = false;
            }
            else if(this.FBrazilCarnivalSign.DayList[_loc1_].Status == TBaseActivity.STATUS_CANNOTGET)
            {
               _loc10_.MC_SelectBox.visible = false;
               _loc10_.MC_Got.visible = false;
            }
            else
            {
               _loc10_.MC_SelectBox.visible = false;
               _loc10_.MC_Got.visible = true;
            }
            if(_loc1_ < this.FToday - 1)
            {
               if(this.FBrazilCarnivalSign.DayList[_loc1_].Status == TBaseActivity.STATUS_GETED)
               {
                  _loc10_.gotoAndStop(3);
               }
               else
               {
                  _loc10_.gotoAndStop(5);
               }
            }
            else if(_loc1_ == this.FToday - 1)
            {
               _loc10_.gotoAndStop(4);
            }
            else
            {
               _loc5_.setDate(_loc1_ + 1);
               if(_loc5_.getTime() > STimingCore.GetClientShowTime(this.FBrazilCarnivalSign.EndTime) * 1000)
               {
                  _loc10_.gotoAndStop(5);
               }
               else
               {
                  _loc10_.gotoAndStop(2);
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
      }
      
      protected function UpdateToday() : void
      {
         if(this.FBrazilCarnivalSign.DayList[this.FToday - 1].Status == TBaseActivity.STATUS_CANGET)
         {
            FMC_Scene.BTN_Get.visible = true;
            FMC_Scene.TF_Get.text = STRING_BASEACTIVITY.FORMAT_TODAY_CAN_GET;
         }
         else
         {
            FMC_Scene.BTN_Get.visible = false;
            if(this.FToday >= new Date(STimingCore.GetClientShowTime(this.FBrazilCarnivalSign.EndTime) * 1000).getDate())
            {
               FMC_Scene.TF_Get.text = STRING_BASEACTIVITY.FORMAT_TODAY_GOT;
            }
            else
            {
               FMC_Scene.TF_Get.text = STRING_BASEACTIVITY.FORMAT_TOMORROW_CAN_GET;
            }
         }
      }
      
      protected function UpdateText() : void
      {
         FMC_Scene.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FBrazilCarnivalSign.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FBrazilCarnivalSign.EndTime) - 1) * 1000)));
         FMC_Scene.TF_Desc.text = this.FBrazilCarnivalSign.ActivityDesc;
      }
      
      override protected function ProcessorOnGetBoxUp(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(FOnGetBox != null)
         {
            FOnGetBox(ACTIVITY_1_ID,TProcessorBrazilCarnival.BrazilCarnival_SIGN_BOX);
         }
      }
      
      override protected function ProcessorOnBoxOver(param1:MouseEvent) : void
      {
         var _loc2_:TInventories = null;
         if(FOnBoxOver != null && Boolean(this.FBrazilCarnivalSign))
         {
            if(this.FToday >= new Date(STimingCore.GetClientShowTime(this.FBrazilCarnivalSign.EndTime) * 1000).getDate())
            {
               _loc2_ = this.FBrazilCarnivalSign.DayList[this.FToday - 1].Inventories;
            }
            else if(this.FBrazilCarnivalSign.DayList[this.FToday - 1].Status == TBaseActivity.STATUS_CANGET)
            {
               _loc2_ = this.FBrazilCarnivalSign.DayList[this.FToday - 1].Inventories;
            }
            else
            {
               _loc2_ = this.FBrazilCarnivalSign.DayList[this.FToday].Inventories;
            }
            if(_loc2_ != null && _loc2_.Count > 0)
            {
               FOnBoxOver(_loc2_);
            }
         }
      }
      
      override protected function ProcessorOnBoxOut(param1:MouseEvent) : void
      {
         if(FOnBoxOut != null)
         {
            FOnBoxOut();
         }
      }
      
      protected function ProcessorOnDayOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TInventories = null;
         if(FOnBoxOver != null)
         {
            _loc2_ = int(String(param1.currentTarget.name).slice(4));
            if(_loc2_ < this.FFirstDayIndex || _loc2_ > this.FMonthDays + this.FFirstDayIndex - 1)
            {
               return;
            }
            _loc3_ = this.FBrazilCarnivalSign.DayList[_loc2_ - this.FFirstDayIndex].Inventories;
            if(_loc3_ != null && _loc3_.Count > 0)
            {
               FOnBoxOver(_loc3_);
            }
         }
      }
      
      protected function ProcessorOnDayOut(param1:MouseEvent) : void
      {
         if(FOnBoxOut != null)
         {
            FOnBoxOut();
         }
      }
      
      override public function Perform_UIDispatch(param1:MovieClip) : void
      {
         super.Perform_UIDispatch(param1);
      }
      
      override public function LogicsPerform() : void
      {
         if(FInitialized && this.visible)
         {
         }
      }
      
      override public function UpdateUI() : void
      {
         this.FBrazilCarnivalSign = SLogicsCore.BrazilCarnivalDatas.GetActivityByIdentify(ACTIVITY_1_ID) as TBrazilCarnivalSign;
         this.UpdateDays();
         this.UpdateToday();
         this.UpdateText();
      }
   }
}

