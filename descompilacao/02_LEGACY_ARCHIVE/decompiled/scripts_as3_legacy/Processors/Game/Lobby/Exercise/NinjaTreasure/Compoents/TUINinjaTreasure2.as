package Processors.Game.Lobby.Exercise.NinjaTreasure.Compoents
{
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.NinjaTreasure.TNinjaTreasure2;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseBox;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Exercise.NinjaTreasure.TProcessorNinjaTreasure;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class TUINinjaTreasure2 extends TUIBaseWindow
   {
      
      public static const ACTIVITY_2_ID:int = 2;
      
      public static const SINGLE_RECHARGE_GIFT:int = 3;
      
      public static const SUPER_SALE_BOX_COUNT:int = 3;
      
      protected var FNinjaTreasure2:TNinjaTreasure2;
      
      protected var FBoxList:Vector.<MovieClip>;
      
      protected var FSuperSaleBox:TUIBaseBox;
      
      public function TUINinjaTreasure2(param1:TUIComponent)
      {
         super(param1);
         this.FBoxList = new Vector.<MovieClip>(SINGLE_RECHARGE_GIFT);
      }
      
      override protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         super.Resources_UIDispatch(param1);
         this.FSuperSaleBox = new TUIBaseBox(this,SUPER_SALE_BOX_COUNT);
         this.FSuperSaleBox.Perform_UIDispatch(FMC_Scene.MC_Items);
         this.FSuperSaleBox.OnOverlay = this.SlotsOnOver;
         this.FSuperSaleBox.OnOut = this.SlotsOnOut;
         _loc2_ = 0;
         while(_loc2_ < SINGLE_RECHARGE_GIFT)
         {
            param1 = FMC_Scene["MC_Item" + _loc2_];
            param1.BTN_Buy.addEventListener(MouseEvent.CLICK,this.ProcessorOnRechargeUp);
            param1.BTN_Get.addEventListener(MouseEvent.CLICK,this.ProcessorOnGetGiftUp);
            this.FBoxList[_loc2_] = param1;
            _loc2_++;
         }
         TGameUtil.setButtonMode(FMC_Scene.BTN_Buy,true);
         FMC_Scene.BTN_Buy.addEventListener(MouseEvent.CLICK,this.ProcessorOnBuyBoxUp);
      }
      
      protected function UpdateBox() : void
      {
         var _loc1_:TBaseBox = null;
         _loc1_ = this.FNinjaTreasure2.SuperSaleBox;
         this.FSuperSaleBox.UpdateUI(_loc1_.Inventories);
         if(_loc1_.Status != TBaseActivity.STATUS_GETED)
         {
            TGameUtil.setButtonMode(FMC_Scene.BTN_Buy,true);
         }
         else
         {
            TGameUtil.setButtonMode(FMC_Scene.BTN_Buy,false);
         }
      }
      
      protected function UpdateGift() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TBaseBox = null;
         var _loc4_:MovieClip = null;
         _loc1_ = 0;
         while(_loc1_ < SINGLE_RECHARGE_GIFT)
         {
            _loc4_ = this.FBoxList[_loc1_];
            if(_loc1_ < this.FNinjaTreasure2.BoxList.length)
            {
               _loc3_ = this.FNinjaTreasure2.BoxList[_loc1_];
               _loc4_.MC_GoldPic.gotoAndStop(_loc1_ + 1);
               _loc4_.TF_Desc0.htmlText = _loc3_.Desc1;
               if(_loc3_.Status == TBaseActivity.STATUS_CANNOTGET)
               {
                  _loc4_.BTN_Get.visible = false;
                  _loc4_.BTN_Buy.visible = true;
                  _loc4_.MC_Got.visible = false;
                  TGameUtil.setButtonMode(_loc4_.BTN_Buy,true);
               }
               else if(_loc3_.Status == TBaseActivity.STATUS_CANGET)
               {
                  _loc4_.BTN_Get.visible = true;
                  _loc4_.BTN_Buy.visible = false;
                  _loc4_.MC_Got.visible = false;
                  TGameUtil.setButtonMode(_loc4_.BTN_Get,true);
               }
               else
               {
                  _loc4_.BTN_Get.visible = false;
                  _loc4_.BTN_Buy.visible = false;
                  _loc4_.MC_Got.visible = true;
               }
            }
            _loc1_++;
         }
      }
      
      protected function UpdateText() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TInventories = null;
         FMC_Scene.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FNinjaTreasure2.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FNinjaTreasure2.EndTime) - 1) * 1000)));
         FMC_Scene.TF_Desc.htmlText = this.FNinjaTreasure2.DescListNew[0];
         FMC_Scene.TF_Desc1.htmlText = this.FNinjaTreasure2.DescListNew[1];
         FMC_Scene.TF_Desc2.htmlText = this.FNinjaTreasure2.DescListNew[2];
         FMC_Scene.TF_DailyGold.text = this.FNinjaTreasure2.SuperSaleBox.Price.toString();
         FMC_Scene.TF_Gold.text = this.FNinjaTreasure2.SuperSaleBox.CurPrice.toString();
      }
      
      protected function ProcessorOnBuyBoxUp(param1:MouseEvent) : void
      {
         if(FOnBuyBox != null && this.FNinjaTreasure2.SuperSaleBox.Status != TBaseActivity.STATUS_GETED)
         {
            FOnBuyBox(ACTIVITY_2_ID,TProcessorNinjaTreasure.ACTVITTY_2_BUY_BOX,this.FNinjaTreasure2.SuperSaleBox.CurPrice,0,TBaseActivity.SWEET_TYPE_GOLD);
         }
      }
      
      protected function ProcessorOnRechargeUp(param1:MouseEvent) : void
      {
         if(FGotoRecharge != null)
         {
            FGotoRecharge();
         }
      }
      
      protected function ProcessorOnGetGiftUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(Boolean(FOnGetBox != null && this.FNinjaTreasure2) && Boolean(_loc2_ < this.FNinjaTreasure2.BoxList.length) && this.FNinjaTreasure2.BoxList[_loc2_].Status == TBaseActivity.STATUS_CANGET)
         {
            FOnGetBox(ACTIVITY_2_ID,TProcessorNinjaTreasure.ACTVITTY_2_GET_GIFT,_loc2_ + 1);
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
      
      override public function Perform_UIDispatch(param1:MovieClip) : void
      {
         super.Perform_UIDispatch(param1);
      }
      
      override public function LogicsPerform() : void
      {
         var _loc1_:uint = 0;
         if(FInitialized && this.visible)
         {
            if(this.FNinjaTreasure2)
            {
               if(this.FSuperSaleBox)
               {
                  this.FSuperSaleBox.LogicsPerform();
               }
            }
         }
      }
      
      override public function UpdateUI() : void
      {
         this.FNinjaTreasure2 = SLogicsCore.NinjaTreasureDatas.GetActivityByIdentify(ACTIVITY_2_ID) as TNinjaTreasure2;
         this.UpdateBox();
         this.UpdateGift();
         this.UpdateText();
      }
   }
}

