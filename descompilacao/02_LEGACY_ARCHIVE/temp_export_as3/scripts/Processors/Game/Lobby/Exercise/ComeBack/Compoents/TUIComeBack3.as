package Processors.Game.Lobby.Exercise.ComeBack.Compoents
{
   import Components.Pages.TUIPage;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.ComeBack.TComeBack;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseBox;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Exercise.ComeBack.TProcessorComeBack;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class TUIComeBack3 extends TUIBaseWindow
   {
      
      protected static const SALE_BOX_COUNT:int = 4;
      
      protected static const GIFT_COUNT:int = 4;
      
      protected var FComeBack:TComeBack;
      
      protected var FSaleBoxList:Vector.<TUIBaseBox>;
      
      protected var FUIPage:TUIPage;
      
      protected var FTotalPage:int;
      
      protected var FCurPage:int;
      
      public function TUIComeBack3(param1:TUIComponent)
      {
         super(param1);
         this.FComeBack = SLogicsCore.ComeBack;
         this.FSaleBoxList = new Vector.<TUIBaseBox>(SALE_BOX_COUNT);
         this.FUIPage = new TUIPage(this);
      }
      
      override protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TUIBaseBox = null;
         super.Resources_UIDispatch(param1);
         _loc2_ = 0;
         while(_loc2_ < SALE_BOX_COUNT)
         {
            _loc4_ = new TUIBaseBox(this,1);
            _loc4_.Perform_UIDispatch(FMC_Scene["MC_Box" + _loc2_]);
            _loc4_.OnBuyBox = this.ProcessorOnBuyItem;
            _loc4_.OnOverlay = this.ProcessorOnItemOver;
            _loc4_.OnOut = this.ProcessorOnItemOut;
            this.FSaleBoxList[_loc2_] = _loc4_;
            _loc2_++;
         }
         FMC_Scene.Btn_Close.addEventListener(MouseEvent.CLICK,this.ProcessorOnCloseWindow);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Desc,true);
         FMC_Scene.BTN_Desc.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowDesc);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Recharge,true);
         FMC_Scene.BTN_Recharge.addEventListener(MouseEvent.CLICK,ProcessorOnGotoRecharge);
         TGameUtil.setButtonMode(FMC_Scene.MC_BackGift.BTN_Get,true);
         FMC_Scene.MC_BackGift.BTN_Get.addEventListener(MouseEvent.CLICK,this.ProcessorOnGetBackUp);
         TGameUtil.setButtonMode(FMC_Scene.MC_RechargeGift.BTN_Get,true);
         FMC_Scene.MC_RechargeGift.BTN_Get.addEventListener(MouseEvent.CLICK,this.ProcessorOnRechargeGiftUp);
         this.FUIPage.ButtonPrevious.Substrate = FMC_Scene.BTN_Left;
         this.FUIPage.ButtonNext.Substrate = FMC_Scene.BTN_Right;
         this.FUIPage.TotalQuantity = this.FTotalPage;
         this.FUIPage.PageSize = SALE_BOX_COUNT;
         this.FUIPage.PageIndex = 0;
         this.FCurPage = 0;
         this.FUIPage.OnChangePage = this.ProcessorPageOnChange;
      }
      
      protected function UpdateBox() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:String = null;
         _loc1_ = 0;
         while(_loc1_ < GIFT_COUNT)
         {
            _loc3_ = FMC_Scene.MC_BackGift["MC_Gift" + _loc1_];
            _loc3_.gotoAndStop(this.FComeBack.BackAwardList["Type" + _loc1_]);
            _loc3_.TF_Num.text = this.FComeBack.BackAwardList["Value" + _loc1_].toString();
            _loc1_++;
         }
         if(this.FComeBack.BackAwardStatus == TBaseActivity.STATUS_CANGET)
         {
            TGameUtil.setButtonMode(FMC_Scene.MC_BackGift.BTN_Get,true);
            FMC_Scene.MC_BackGift.MC_Got.visible = false;
            FMC_Scene.MC_BackGift.BTN_Get.visible = true;
         }
         else
         {
            TGameUtil.setButtonMode(FMC_Scene.MC_BackGift.BTN_Get,false);
            FMC_Scene.MC_BackGift.MC_Got.visible = true;
            FMC_Scene.MC_BackGift.BTN_Get.visible = false;
         }
         if(this.FComeBack.RewardGold > 0)
         {
            TGameUtil.setButtonMode(FMC_Scene.MC_RechargeGift.BTN_Get,true);
         }
         else
         {
            TGameUtil.setButtonMode(FMC_Scene.MC_RechargeGift.BTN_Get,false);
         }
      }
      
      protected function UpdateSaleBox() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:TBaseBox = null;
         this.FUIPage.TotalQuantity = this.FComeBack.SaleBox.length;
         this.FUIPage.Update();
         _loc1_ = 0;
         while(_loc1_ < SALE_BOX_COUNT)
         {
            _loc2_ = _loc1_ + this.FCurPage * SALE_BOX_COUNT;
            _loc4_ = FMC_Scene["MC_Box" + _loc1_];
            if(_loc2_ < this.FComeBack.SaleBox.length)
            {
               _loc4_.visible = true;
               _loc5_ = this.FComeBack.SaleBox[_loc2_];
               _loc4_.TF_Limit.text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_LIMIT_COUNT,_loc5_.LimitCount);
               _loc4_.TF_OriginalPrice.text = _loc5_.Price.toString();
               _loc4_.TF_NowPrice.text = _loc5_.CurPrice.toString();
               this.FSaleBoxList[_loc1_].UpdateUI(_loc5_.Inventories);
               if(_loc5_.LimitCount > 0)
               {
                  TGameUtil.setButtonMode(_loc4_.BTN_Buy,true);
               }
               else
               {
                  TGameUtil.setButtonMode(_loc4_.BTN_Buy,false);
               }
            }
            else
            {
               _loc4_.visible = false;
            }
            _loc1_++;
         }
      }
      
      protected function UpdateText() : void
      {
         FMC_Scene.TF_Data.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FComeBack.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FComeBack.EndTime) - 1) * 1000)));
         FMC_Scene.TF_Text0.text = this.FComeBack.DescListNew[1];
         FMC_Scene.TF_Text1.text = this.FComeBack.DescListNew[2];
         FMC_Scene.MC_BackGift.MC_Boom.TF_Text.text = this.FComeBack.DescListNew[3];
         FMC_Scene.MC_RechargeGift.TF_Text.text = this.FComeBack.DescListNew[4];
         FMC_Scene.MC_RechargeGift.TF_Gold0.text = this.FComeBack.RechargeGold.toString();
         FMC_Scene.MC_RechargeGift.TF_Gold1.text = this.FComeBack.RewardGold.toString();
         FMC_Scene.MC_RechargeGift.TF_Rate.text = this.FComeBack.Rate + "%";
         FMC_Scene.MC_BackGift.TF_Text.text = TUtilityString.Format(this.FComeBack.DescListNew[6],this.FComeBack.LeftDays);
      }
      
      protected function ProcessorOnGetBackUp(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(FOnGetBox != null)
         {
            if(this.FComeBack.TotalRechargeGold == 0)
            {
               FOnBuyBox(1,TProcessorComeBack.TYPE_GET_BACK_AWARD_REQ,0,1,TBaseActivity.SWEET_TYPE_GOLD,this.FComeBack.DescListNew[5]);
            }
            else if(this.FComeBack.BackAwardStatus == TBaseActivity.STATUS_CANGET)
            {
               FOnGetBox(TProcessorComeBack.TYPE_GET_BACK_AWARD_REQ);
            }
         }
      }
      
      protected function ProcessorOnRechargeGiftUp(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(FOnGetBox != null)
         {
            if(this.FComeBack.RewardGold > 0)
            {
               FOnGetBox(TProcessorComeBack.TYPE_GET_RETURN_GOLD_REQ);
            }
         }
      }
      
      protected function ProcessorOnBuyItem(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(6));
         _loc3_ = _loc2_ + this.FCurPage * SALE_BOX_COUNT;
         if(Boolean(FOnBuyBox != null) && Boolean(this.FComeBack) && _loc3_ < this.FComeBack.SaleBox.length)
         {
            FOnBuyBox(1,TProcessorComeBack.TYPE_BUY_SALE_ITEM_REQ,this.FComeBack.SaleBox[_loc3_].CurPrice,_loc3_ + 1);
         }
      }
      
      protected function ProcessorPageOnChange(param1:Object, param2:int) : void
      {
         this.FCurPage = param2;
         this.UpdateSaleBox();
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
      
      protected function ProcessorOnCloseWindow(param1:MouseEvent) : void
      {
         if(FOnCloseWindow != null)
         {
            FOnCloseWindow();
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
            if(this.FSaleBoxList)
            {
               _loc1_ = 0;
               while(_loc1_ < this.FSaleBoxList.length)
               {
                  if(this.FSaleBoxList[_loc1_])
                  {
                     this.FSaleBoxList[_loc1_].LogicsPerform();
                  }
                  _loc1_++;
               }
            }
         }
      }
      
      override public function UpdateUI() : void
      {
         this.UpdateBox();
         this.UpdateSaleBox();
         this.UpdateText();
      }
   }
}

