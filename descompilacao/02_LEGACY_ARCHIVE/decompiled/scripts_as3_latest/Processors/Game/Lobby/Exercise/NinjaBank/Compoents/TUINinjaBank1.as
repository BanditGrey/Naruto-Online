package Processors.Game.Lobby.Exercise.NinjaBank.Compoents
{
   import Components.Pages.TUIPage;
   import Components.ScrollBar.TScrollBar;
   import Components.Standard.TUITab;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.NinjaBank.TNinjaBank;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseBox;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Exercise.NinjaBank.TProcessorNinjaBank;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class TUINinjaBank1 extends TUIBaseWindow
   {
      
      protected static const MIN_SCROLL_HEIGHT:Number = 240;
      
      protected static const ITEM_STAMP:Number = 0;
      
      protected static const SINGLE_ITEM_STAMP:Number = 70;
      
      protected static const ITEM_HEIGHT:Number = 70;
      
      protected var TAB_COUNT:int = 2;
      
      protected var SHOW_BOX_COUNT:int = 3;
      
      protected var OPEN_BOX_COUNT:int = 5;
      
      protected var FNinjaBank:TNinjaBank;
      
      protected var FUITab:TUITab;
      
      protected var FChangeTabIndex:int;
      
      protected var FTabList:Vector.<MovieClip>;
      
      protected var FUIPage:TUIPage;
      
      protected var FTotalPage:int;
      
      protected var FCurPage:int;
      
      protected var FScrollBar:TScrollBar;
      
      protected var FRewardList:Vector.<TUINinjaBankItem>;
      
      protected var FShowItem:TUIBaseBox;
      
      public function TUINinjaBank1(param1:TUIComponent)
      {
         super(param1);
         this.FNinjaBank = SLogicsCore.NinjaBank;
         this.FUITab = new TUITab(this);
         this.FTabList = new Vector.<MovieClip>(this.TAB_COUNT);
         this.FRewardList = new Vector.<TUINinjaBankItem>();
      }
      
      override protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         super.Resources_UIDispatch(param1);
         FMC_Scene.MC_End.visible = false;
         this.FScrollBar = new TScrollBar(FMC_Scene.MC_Tab0.MC_List,MIN_SCROLL_HEIGHT,false,ITEM_STAMP,SINGLE_ITEM_STAMP);
         FMC_Scene.BTN_Recharge.addEventListener(MouseEvent.CLICK,ProcessorOnGotoRecharge);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Buy,true);
         FMC_Scene.BTN_Buy.addEventListener(MouseEvent.CLICK,this.ProcessorOnBuyFundUp);
         FMC_Scene.BTN_Buy.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnBuyFundOver);
         FMC_Scene.BTN_Buy.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnBuyFundOut);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Log,true);
         FMC_Scene.BTN_Log.addEventListener(MouseEvent.CLICK,this.ProcessorOnLoadLog);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Desc,true);
         FMC_Scene.BTN_Desc.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowDesc);
      }
      
      protected function UpdateBtn() : void
      {
         var _loc1_:int = 0;
         if(this.FNinjaBank.CanBuyCount > 0 && this.FNinjaBank.GameStatus == 1)
         {
            TGameUtil.setButtonMode(FMC_Scene.BTN_Buy,true);
         }
         else
         {
            TGameUtil.setButtonMode(FMC_Scene.BTN_Buy,false);
         }
         if(this.FNinjaBank.GameStatus == 1)
         {
            FMC_Scene.MC_End.visible = false;
         }
         else
         {
            FMC_Scene.MC_End.visible = true;
         }
      }
      
      protected function UpdateTab() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:TUINinjaBankItem = null;
         var _loc5_:MovieClip = null;
         var _loc6_:TBaseBox = null;
         this.FRewardList.length = 0;
         this.FScrollBar.Clear();
         _loc3_ = this.FNinjaBank.BoxList.length;
         _loc1_ = 0;
         while(_loc1_ < _loc3_)
         {
            _loc4_ = new TUINinjaBankItem(this);
            _loc4_.OnOverlay = this.SlotsOnOver;
            _loc4_.OnOut = this.SlotsOnOut;
            _loc4_.Init();
            _loc4_.y = _loc1_ * ITEM_HEIGHT;
            _loc4_.SetItemInfo(_loc1_);
            this.FRewardList[_loc1_] = _loc4_;
            this.FScrollBar.AddItem(_loc4_);
            _loc1_++;
         }
         FMC_Scene.MC_Tab0.TF_Gold.text = TUtilityString.Format(this.FNinjaBank.DescListNew[3],this.FNinjaBank.RechargeGold);
         FMC_Scene.MC_Tab0.TF_Rate.text = (this.FNinjaBank.Price - this.FNinjaBank.CurPrice).toString();
         FMC_Scene.MC_Tab0.TF_Text.text = this.FNinjaBank.DescListNew[10];
      }
      
      protected function UpdateText() : void
      {
         FMC_Scene.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_OnlyTime,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FNinjaBank.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FNinjaBank.SecondTime) - 1) * 1000)));
         FMC_Scene.TF_Date2.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_OnlyTime,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FNinjaBank.SecondTime) * 1000 + 3 * 60 * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FNinjaBank.EndTime) - 1) * 1000)));
         FMC_Scene.TF_CanBuyCount.text = this.FNinjaBank.CanBuyCount.toString();
         FMC_Scene.TF_BoughtCount.text = this.FNinjaBank.BoughtCount.toString();
         FMC_Scene.TF_Desc.text = this.FNinjaBank.DescListNew[12];
         FMC_Scene.TF_Desc1.text = this.FNinjaBank.DescListNew[1];
         FMC_Scene.TF_Desc2.text = this.FNinjaBank.DescListNew[2];
         FMC_Scene.TF_Return.text = this.FNinjaBank.DescListNew[9];
      }
      
      protected function ChangeTabOnSwitch(param1:Object) : void
      {
         var _loc2_:int = 0;
         _loc2_ = param1 as int;
         if(_loc2_ != this.FChangeTabIndex)
         {
            this.FChangeTabIndex = _loc2_;
            this.UpdateUI();
         }
      }
      
      protected function ProcessorPageOnChange(param1:Object, param2:int) : void
      {
         this.FCurPage = param2;
         this.UpdateUI();
      }
      
      protected function ProcessorOnBuyFundUp(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.buttonMode || this.FNinjaBank.CanBuyCount <= 0 || this.FNinjaBank.GameStatus == 2)
         {
            return;
         }
         if(FOnBuyBox != null)
         {
            FOnBuyBox(TProcessorNinjaBank.TYPE_BUY_FUND,this.FNinjaBank.CurPrice);
         }
      }
      
      protected function ProcessorOnOpenBoxUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TBaseBox = null;
         _loc2_ = int(String(param1.currentTarget.name).slice(10));
         _loc3_ = this.OPEN_BOX_COUNT * this.FCurPage + _loc2_;
         if(FOnGetBox != null && _loc3_ < this.FNinjaBank.OpenBoxList.length)
         {
            _loc4_ = this.FNinjaBank.OpenBoxList[_loc3_];
            if(_loc4_.Status == TBaseActivity.STATUS_CANGET)
            {
               FOnGetBox(TProcessorNinjaBank.TYPE_GET_GIFT,_loc3_);
            }
         }
      }
      
      protected function ProcessorOnBigBoxUp(param1:MouseEvent) : void
      {
         if(FOnGetBox != null && this.FNinjaBank.OpenBoxCount > 0)
         {
            FOnGetBox(TProcessorNinjaBank.TYPE_OPEN_BOX);
         }
      }
      
      protected function ProcessorOnBuyFundOver(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(this.FNinjaBank.GameStatus == 1)
         {
            if(!param1.currentTarget.buttonMode)
            {
               FMC_Scene.BTN_Buy.gotoAndStop(4);
            }
            else
            {
               FMC_Scene.BTN_Buy.gotoAndStop(2);
            }
            if(FOnShowHtmlTip != null && this.FNinjaBank.DescList.length > 5)
            {
               _loc2_ = TUtilityString.Format(this.FNinjaBank.DescListNew[5],this.FNinjaBank.CurPrice);
               FOnShowHtmlTip(_loc2_);
            }
         }
         else
         {
            FMC_Scene.BTN_Buy.gotoAndStop(4);
         }
      }
      
      protected function ProcessorOnBuyFundOut(param1:MouseEvent) : void
      {
         if(this.FNinjaBank.CanBuyCount > 0 && this.FNinjaBank.GameStatus == 1)
         {
            TGameUtil.setButtonMode(FMC_Scene.BTN_Buy,true);
         }
         else
         {
            TGameUtil.setButtonMode(FMC_Scene.BTN_Buy,false);
         }
         FOnHideHtmlTip();
      }
      
      protected function ProcessorOnBigBoxOver(param1:MouseEvent) : void
      {
         if(FOnShowHtmlTip != null && this.FNinjaBank.DescList.length > 4)
         {
            FOnShowHtmlTip(this.FNinjaBank.DescListNew[4]);
         }
      }
      
      protected function ProcessorOnBigBoxOut(param1:MouseEvent) : void
      {
         FOnHideHtmlTip();
      }
      
      protected function ProcessorOnOpenBoxOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc3_ = int(String(param1.currentTarget.name).slice(10));
         _loc2_ = this.OPEN_BOX_COUNT * this.FCurPage + _loc3_;
         if(_loc2_ < this.FNinjaBank.OpenBoxList.length && FOnNewBoxOver != null)
         {
            FOnNewBoxOver(this.FNinjaBank.OpenBoxList[_loc2_].Inventories);
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
      
      protected function ProcessorOnLoadLog(param1:MouseEvent) : void
      {
         if(FOnLoadLog != null)
         {
            FOnLoadLog(1);
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
         var _loc2_:int = 0;
         if(FInitialized && this.visible)
         {
            if(Boolean(FMC_Scene) && FMC_Scene.visible)
            {
               _loc1_ = 0;
               while(_loc1_ < this.FRewardList.length)
               {
                  this.FRewardList[_loc1_].UpdateSlot();
                  _loc1_++;
               }
               FMC_Scene.TF_Time.text = TGameUtil.fomatTime(this.FNinjaBank.SecondTime - STimingCore.GetServerTick());
            }
         }
      }
      
      override public function UpdateUI() : void
      {
         this.UpdateBtn();
         this.UpdateTab();
         this.UpdateText();
      }
      
      override public function PlayMovie(param1:int = 0, param2:Boolean = false) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:MovieClip = null;
      }
   }
}

