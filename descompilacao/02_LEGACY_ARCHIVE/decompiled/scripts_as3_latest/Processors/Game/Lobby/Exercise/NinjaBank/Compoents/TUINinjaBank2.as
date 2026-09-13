package Processors.Game.Lobby.Exercise.NinjaBank.Compoents
{
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.NinjaBank.TNinjaBank;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseBox;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Exercise.NinjaBank.TProcessorNinjaBank;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class TUINinjaBank2 extends TUIBaseWindow
   {
      
      protected static const SHOW_BOX_COUNT:int = 5;
      
      protected static const DAYS_COUNT:int = 42;
      
      protected static const INTERVALTIME:Number = 172800000;
      
      protected var FNinjaBank:TNinjaBank;
      
      protected var FMC_AllDays:Vector.<MovieClip>;
      
      protected var FFirstDayIndex:int;
      
      protected var FToday:int;
      
      protected var FMonthDays:int;
      
      protected var ServerStartDate:Date;
      
      protected var FShowItem:TUIBaseBox;
      
      public function TUINinjaBank2(param1:TUIComponent)
      {
         super(param1);
         this.FNinjaBank = SLogicsCore.NinjaBank;
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
            _loc2_++;
         }
         this.FShowItem = new TUIBaseBox(this,SHOW_BOX_COUNT);
         this.FShowItem.Perform_UIDispatch(FMC_Scene.MC_ShowItem);
         this.FShowItem.OnOverlay = this.SlotsOnOver;
         this.FShowItem.OnOut = this.SlotsOnOut;
         TGameUtil.setButtonMode(FMC_Scene.BTN_Get,true);
         FMC_Scene.BTN_Get.addEventListener(MouseEvent.CLICK,this.ProcessorOnOpenBoxUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Log,true);
         FMC_Scene.BTN_Log.addEventListener(MouseEvent.CLICK,this.ProcessorOnLoadLog);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Desc,true);
         FMC_Scene.BTN_Desc.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowDesc);
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
            if(this.FNinjaBank.DayList.indexOf(_loc7_) != -1)
            {
               _loc10_.MC_Gold.visible = true;
            }
            else
            {
               _loc10_.MC_Gold.visible = false;
            }
            if(this.FNinjaBank.CurDay == _loc7_)
            {
               _loc10_.MC_Selected.visible = true;
            }
            else
            {
               _loc10_.MC_Selected.visible = false;
            }
            _loc9_ = ++_loc7_ - 2;
            _loc8_ = _loc9_ + 1;
            _loc1_++;
         }
         _loc7_ = uint(TUtilityDate.GetMonthDaysByDate(new Date(_loc3_.getTime() - INTERVALTIME)));
         _loc1_ = int(this.FFirstDayIndex - 1);
         while(_loc1_ > -1)
         {
            _loc10_ = this.FMC_AllDays[_loc1_];
            _loc10_.TF_Day.text = _loc7_.toString();
            _loc10_.MC_Gold.visible = false;
            _loc10_.MC_Selected.visible = false;
            _loc7_--;
            _loc1_--;
         }
         _loc7_ = 1;
         _loc1_ = int(_loc2_ + this.FFirstDayIndex);
         while(_loc1_ < DAYS_COUNT)
         {
            _loc10_ = this.FMC_AllDays[_loc1_];
            _loc10_.TF_Day.text = _loc7_.toString();
            _loc10_.MC_Gold.visible = false;
            _loc10_.MC_Selected.visible = false;
            _loc7_++;
            _loc1_++;
         }
      }
      
      protected function UpdateBox() : void
      {
         var _loc1_:TInventories = null;
         if(this.FNinjaBank.CurBuyIndex == 0)
         {
            this.FShowItem.UpdateUI(null);
            FMC_Scene.MC_Mask.visible = true;
         }
         else
         {
            FMC_Scene.MC_Mask.visible = false;
            _loc1_ = this.FNinjaBank.ReturnItems.Inventories;
            this.FShowItem.UpdateUI(_loc1_);
         }
         if(this.FNinjaBank.AwardStatus == TBaseActivity.STATUS_CANGET)
         {
            TGameUtil.setButtonMode(FMC_Scene.BTN_Get,true);
         }
         else
         {
            TGameUtil.setButtonMode(FMC_Scene.BTN_Get,false);
         }
      }
      
      protected function UpdateText() : void
      {
         var _loc1_:TBaseBox = null;
         FMC_Scene.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FNinjaBank.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FNinjaBank.EndTime) - 1) * 1000)));
         FMC_Scene.TF_Desc.text = this.FNinjaBank.DescListNew[11];
         if(this.FNinjaBank.CurBuyIndex == 0)
         {
            FMC_Scene.TF_Gold.text = "0";
         }
         else
         {
            _loc1_ = this.FNinjaBank.BoxList[this.FNinjaBank.CurBuyIndex - 1];
            FMC_Scene.TF_Gold.text = this.FNinjaBank.ReturnGold;
         }
      }
      
      protected function ProcessorOnOpenBoxUp(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(FOnGetBox != null && this.FNinjaBank.AwardStatus == TBaseActivity.STATUS_CANGET)
         {
            FOnGetBox(TProcessorNinjaBank.TYPE_GET_RETURN);
         }
      }
      
      protected function ProcessorOnLoadLog(param1:MouseEvent) : void
      {
         if(FOnLoadLog != null)
         {
            FOnLoadLog(2);
         }
      }
      
      protected function SlotsOnOver(param1:Object, param2:Object) : void
      {
         if(FOnItemOver != null)
         {
            FOnItemOver(this,param2);
         }
      }
      
      protected function SlotsOnOut(param1:Object, param2:Object) : void
      {
         if(FOnItemOut != null)
         {
            FOnItemOut(this,param2);
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
         if(FInitialized && this.visible)
         {
            if(Boolean(FMC_Scene) && FMC_Scene.visible)
            {
               FMC_Scene.TF_Time.text = TGameUtil.fomatTime(this.FNinjaBank.EndTime - STimingCore.GetServerTick());
               this.FShowItem.LogicsPerform();
               FMC_Scene.TF_Text.text = TUtilityString.Format(this.FNinjaBank.DescListNew[6],this.FNinjaBank.BoughtCount,TGameUtil.fomatTime(this.FNinjaBank.NextAwardTime - STimingCore.GetServerTick()));
            }
         }
      }
      
      override public function UpdateUI() : void
      {
         this.UpdateDays();
         this.UpdateBox();
         this.UpdateText();
      }
   }
}

