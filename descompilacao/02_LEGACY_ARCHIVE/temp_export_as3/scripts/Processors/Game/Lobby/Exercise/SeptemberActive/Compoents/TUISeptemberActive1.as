package Processors.Game.Lobby.Exercise.SeptemberActive.Compoents
{
   import Components.Pages.TUIPage;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.SeptemberActive.TSeptemberActive1;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseBox;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Exercise.SeptemberActive.TProcessorSeptemberActive;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class TUISeptemberActive1 extends TUIBaseWindow
   {
      
      protected static const ACTIVITY_1_ID:int = 1;
      
      protected static const GIFT_COUNT:int = 2;
      
      protected static const BOX_COUNT:int = 5;
      
      protected static const TYPE_FREE_GIFT:int = 0;
      
      protected static const TYPE_GOLD_GIFT:int = 1;
      
      protected var FSeptemberActive1:TSeptemberActive1;
      
      protected var FSaleItem:TUIBaseBox;
      
      protected var FGiftList:Vector.<MovieClip>;
      
      protected var FBoxList:Vector.<MovieClip>;
      
      protected var FUIPage:TUIPage;
      
      protected var FTotalPage:int;
      
      protected var FCurPage:int;
      
      public function TUISeptemberActive1(param1:TUIComponent)
      {
         super(param1);
         this.FGiftList = new Vector.<MovieClip>();
         this.FBoxList = new Vector.<MovieClip>();
         this.FUIPage = new TUIPage(this);
      }
      
      override protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         super.Resources_UIDispatch(param1);
         _loc2_ = 0;
         while(_loc2_ < GIFT_COUNT)
         {
            this.FGiftList[_loc2_] = FMC_Scene["MC_Gift" + _loc2_];
            this.FGiftList[_loc2_].MC_BoxPic.buttonMode = true;
            this.FGiftList[_loc2_].MC_BoxPic.gotoAndStop(_loc2_ + 1);
            this.FGiftList[_loc2_].addEventListener(MouseEvent.CLICK,this.ProcessorOnGetGiftUp);
            this.FGiftList[_loc2_].addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnGiftOver);
            this.FGiftList[_loc2_].addEventListener(MouseEvent.ROLL_OUT,ProcessorOnNewBoxOut);
            _loc2_++;
         }
         this.FSaleItem = new TUIBaseBox(this,1);
         this.FSaleItem.Perform_UIDispatch(FMC_Scene.MC_Sale);
         this.FSaleItem.OnOverlay = this.ProcessorOnItemOver;
         this.FSaleItem.OnOut = this.ProcessorOnItemOut;
         this.FSaleItem.OnBuyBox = this.ProcessorOnBuyItemUp;
         TGameUtil.setButtonMode(FMC_Scene.MC_Server.BTN_Get,true);
         TGameUtil.setButtonMode(FMC_Scene.MC_Server.BTN_Buy,true);
         FMC_Scene.MC_Server.BTN_Get.addEventListener(MouseEvent.CLICK,this.ProcessorOnServerListUp);
         FMC_Scene.MC_Server.BTN_Buy.addEventListener(MouseEvent.CLICK,this.ProcessorOnServerListUp);
         FMC_Scene.MC_Server.BTN_Buy.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnShowPriceTip);
         FMC_Scene.MC_Server.BTN_Buy.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
         FMC_Scene.MC_Server.MC_GoldPic.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnServerListOver);
         FMC_Scene.MC_Server.MC_GoldPic.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnNewBoxOut);
         _loc2_ = 0;
         while(_loc2_ < BOX_COUNT)
         {
            this.FBoxList[_loc2_] = FMC_Scene["MC_Box" + _loc2_];
            this.FBoxList[_loc2_].buttonMode = true;
            this.FBoxList[_loc2_].MC_BoxPic.gotoAndStop(_loc2_ + 1);
            this.FBoxList[_loc2_].addEventListener(MouseEvent.CLICK,this.ProcessorOnGetBoxUp);
            this.FBoxList[_loc2_].addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnBoxOver);
            this.FBoxList[_loc2_].addEventListener(MouseEvent.ROLL_OUT,ProcessorOnNewBoxOut);
            _loc2_++;
         }
         this.FUIPage.ButtonPrevious.Substrate = FMC_Scene.MC_Server.BTN_Left;
         this.FUIPage.ButtonNext.Substrate = FMC_Scene.MC_Server.BTN_Right;
         this.FUIPage.PageSize = 1;
         this.FUIPage.PageIndex = 0;
         this.FCurPage = 0;
         this.FUIPage.OnChangePage = this.ProcessorPageOnChange;
         this.ResourcesPerform_UILocations();
      }
      
      protected function ResourcesPerform_UILocations() : void
      {
         TGameUtil.setButtonMode(FMC_Scene.BTN_Log,true);
         FMC_Scene.BTN_Log.addEventListener(MouseEvent.CLICK,this.ProcessorOnLoadLog);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Desc,true);
         FMC_Scene.BTN_Desc.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowDesc);
         TGameUtil.setButtonMode(FMC_Scene.MC_Sale.BTN_Desc,true);
         FMC_Scene.MC_Sale.BTN_Desc.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowRecruit);
      }
      
      protected function UpdateGift() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         var _loc3_:TBaseBox = null;
         _loc1_ = 0;
         while(_loc1_ < GIFT_COUNT)
         {
            _loc3_ = this.FSeptemberActive1.GiftList[_loc1_];
            _loc2_ = this.FGiftList[_loc1_];
            if(_loc3_.Status == TBaseActivity.STATUS_CANNOTGET)
            {
               _loc2_.MC_CanGet.visible = false;
               _loc2_.MC_Got.visible = false;
            }
            else if(_loc3_.Status == TBaseActivity.STATUS_CANGET)
            {
               _loc2_.MC_CanGet.visible = true;
               _loc2_.MC_Got.visible = false;
            }
            else
            {
               _loc2_.MC_CanGet.visible = false;
               _loc2_.MC_Got.visible = true;
            }
            _loc1_++;
         }
      }
      
      protected function UpdateSaleItem() : void
      {
         var _loc1_:String = null;
         var _loc2_:TBaseBox = null;
         _loc2_ = this.FSeptemberActive1.SaleItem;
         this.FSaleItem.UpdateUI(_loc2_.Inventories);
         _loc1_ = TUtilityString.Format(this.FSeptemberActive1.DescListNew[2],_loc2_.Discount);
         this.FSaleItem.SetDescText(0,_loc1_);
         _loc1_ = TUtilityString.Format(this.FSeptemberActive1.DescListNew[3],_loc2_.LimitCount);
         this.FSaleItem.SetDescText(1,_loc1_);
         this.FSaleItem.SetPriceText(_loc2_.Price.toString());
         this.FSaleItem.SetCurPriceText(_loc2_.CurPrice.toString());
         if(_loc2_.Type == TBaseBox.TYPE_IS_ITEM)
         {
            FMC_Scene.MC_Sale.BTN_Desc.visible = false;
         }
         else
         {
            FMC_Scene.MC_Sale.BTN_Desc.visible = true;
         }
         if(_loc2_.LimitCount > 0)
         {
            FMC_Scene.MC_Sale.BTN_Buy.visible = true;
            FMC_Scene.MC_Sale.MC_None.visible = false;
         }
         else
         {
            FMC_Scene.MC_Sale.BTN_Buy.visible = false;
            FMC_Scene.MC_Sale.MC_None.visible = true;
         }
      }
      
      protected function UpdateServerList() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         var _loc3_:TBaseBox = null;
         var _loc4_:TBaseBox = null;
         _loc2_ = FMC_Scene.MC_Server;
         this.FUIPage.TotalQuantity = this.FSeptemberActive1.ServerList.length;
         this.FUIPage.Update();
         _loc1_ = this.FCurPage;
         _loc3_ = this.FSeptemberActive1.ServerList[_loc1_];
         if(this.FSeptemberActive1.MyCount < 1)
         {
            _loc2_.MC_Tip.visible = true;
            _loc2_.MC_End.visible = false;
            _loc2_.BTN_Get.visible = false;
            _loc2_.BTN_Buy.visible = false;
            _loc2_.MC_None.visible = false;
            _loc2_.MC_Got.visible = false;
            _loc2_.TF_Price.text = TUtilityString.Format(this.FSeptemberActive1.DescListNew[6],_loc3_.BuyCount);
            _loc2_.TF_LimitCount.text = "";
            _loc2_.MC_GoldPic.gotoAndStop(_loc1_ + 1);
         }
         else
         {
            _loc2_.MC_GoldPic.gotoAndStop(_loc1_ + 1);
            _loc2_.MC_Tip.visible = false;
            _loc2_.MC_End.visible = false;
            _loc2_.TF_Price.text = TUtilityString.Format(this.FSeptemberActive1.DescListNew[6],_loc3_.BuyCount);
            if(_loc3_.Status == TBaseActivity.STATUS_CANNOTGET)
            {
               _loc2_.BTN_Get.visible = false;
               _loc2_.BTN_Buy.visible = false;
               _loc2_.MC_Got.visible = false;
            }
            else if(_loc3_.Status == TBaseActivity.STATUS_CANGET)
            {
               _loc2_.MC_Got.visible = false;
               if(_loc3_.Price > 0)
               {
                  _loc2_.BTN_Get.visible = false;
                  _loc2_.BTN_Buy.visible = true;
               }
               else
               {
                  _loc2_.BTN_Get.visible = true;
                  _loc2_.BTN_Buy.visible = false;
               }
            }
            else
            {
               _loc2_.BTN_Get.visible = false;
               _loc2_.BTN_Buy.visible = false;
               _loc2_.MC_Got.visible = true;
            }
            if(_loc3_.LimitCount > 0)
            {
               _loc2_.TF_LimitCount.text = TUtilityString.Format(this.FSeptemberActive1.DescListNew[9],_loc3_.LimitCount);
               _loc2_.MC_None.visible = false;
            }
            else
            {
               _loc2_.TF_LimitCount.text = "";
               _loc2_.MC_None.visible = true;
               _loc2_.BTN_Get.visible = false;
               _loc2_.BTN_Buy.visible = false;
            }
         }
      }
      
      protected function UpdateBox() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:TBaseBox = null;
         _loc1_ = 0;
         while(_loc1_ < BOX_COUNT)
         {
            _loc4_ = this.FSeptemberActive1.BoxList[_loc1_];
            _loc3_ = this.FBoxList[_loc1_];
            _loc3_.TF_Desc.text = TUtilityString.Format(this.FSeptemberActive1.DescListNew[10],_loc4_.Price);
            if(_loc4_.Status == TBaseActivity.STATUS_CANNOTGET)
            {
               _loc3_.MC_CanGet.visible = false;
               _loc3_.MC_Got.visible = false;
            }
            else if(_loc4_.Status == TBaseActivity.STATUS_CANGET)
            {
               _loc3_.MC_CanGet.visible = true;
               _loc3_.MC_Got.visible = false;
            }
            else
            {
               _loc3_.MC_CanGet.visible = false;
               _loc3_.MC_Got.visible = true;
            }
            _loc1_++;
         }
      }
      
      protected function UpdateText() : void
      {
         FMC_Scene.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FSeptemberActive1.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FSeptemberActive1.EndTime) - 1) * 1000)));
         FMC_Scene.TF_MyCount.text = TUtilityString.Format(this.FSeptemberActive1.DescListNew[4],this.FSeptemberActive1.MyCount);
         FMC_Scene.MC_Server.TF_ServerNum.text = TUtilityString.Format(this.FSeptemberActive1.DescListNew[5],this.FSeptemberActive1.TotalCount);
         FMC_Scene.TF_Desc.text = this.FSeptemberActive1.DescListNew[1];
      }
      
      protected function ProcessorPageOnChange(param1:Object, param2:int) : void
      {
         this.FCurPage = param2;
         this.UpdateServerList();
      }
      
      protected function ProcessorOnGetGiftUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(7));
         if(Boolean(FOnGetBox != null && this.FSeptemberActive1) && Boolean(_loc2_ < this.FSeptemberActive1.GiftList.length) && this.FSeptemberActive1.GiftList[_loc2_].Status == TBaseActivity.STATUS_CANGET)
         {
            FOnGetBox(ACTIVITY_1_ID,TProcessorSeptemberActive.ACTIVITY_1_GET_DAILY_GIFT,_loc2_ + 1);
         }
      }
      
      protected function ProcessorOnBuyItemUp(param1:MouseEvent) : void
      {
         if(Boolean(FOnBuyBox != null) && Boolean(this.FSeptemberActive1) && Boolean(this.FSeptemberActive1.SaleItem))
         {
            FOnBuyBox(ACTIVITY_1_ID,TProcessorSeptemberActive.ACTIVITY_1_BUY_ITEM,this.FSeptemberActive1.SaleItem.CurPrice);
         }
      }
      
      protected function ProcessorOnServerListUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc2_ = this.FCurPage;
         if(Boolean(FOnGetBox != null) && Boolean(this.FSeptemberActive1) && _loc2_ < this.FSeptemberActive1.ServerList.length)
         {
            _loc3_ = this.FSeptemberActive1.ServerList[_loc2_].Price;
            if(_loc3_ > 0)
            {
               FOnBuyBox(ACTIVITY_1_ID,TProcessorSeptemberActive.ACTIVITY_1_GET_SERVER_BOX,_loc3_,_loc2_ + 1);
            }
            else
            {
               FOnGetBox(ACTIVITY_1_ID,TProcessorSeptemberActive.ACTIVITY_1_GET_SERVER_BOX,_loc2_ + 1);
            }
         }
      }
      
      override protected function ProcessorOnGetBoxUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(6));
         if(Boolean(FOnGetBox != null && this.FSeptemberActive1) && Boolean(_loc2_ < this.FSeptemberActive1.BoxList.length) && this.FSeptemberActive1.BoxList[_loc2_].Status == TBaseActivity.STATUS_CANGET)
         {
            FOnGetBox(ACTIVITY_1_ID,TProcessorSeptemberActive.ACTIVITY_1_GET_BOX,_loc2_ + 1);
         }
      }
      
      protected function ProcessorOnShowPriceTip(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         _loc2_ = this.FCurPage;
         if(Boolean(FOnShowHtmlTip != null) && Boolean(this.FSeptemberActive1) && _loc2_ < this.FSeptemberActive1.ServerList.length)
         {
            _loc3_ = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_COST_GOLD,this.FSeptemberActive1.ServerList[_loc2_].Price);
            FOnShowHtmlTip(_loc3_);
         }
      }
      
      override protected function ProcessorOnBoxOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(6));
         if(Boolean(FOnNewBoxOver != null) && Boolean(this.FSeptemberActive1) && _loc2_ < this.FSeptemberActive1.BoxList.length)
         {
            FOnNewBoxOver(this.FSeptemberActive1.BoxList[_loc2_].Inventories);
         }
      }
      
      protected function ProcessorOnGiftOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(7));
         if(Boolean(FOnItemOver != null) && Boolean(this.FSeptemberActive1) && _loc2_ < this.FSeptemberActive1.GiftList.length)
         {
            if(_loc2_ == TYPE_FREE_GIFT)
            {
               FOnNewBoxOver(this.FSeptemberActive1.GiftList[_loc2_].Inventories,this.FSeptemberActive1.DescListNew[8]);
            }
            else
            {
               FOnNewBoxOver(this.FSeptemberActive1.GiftList[_loc2_].Inventories,this.FSeptemberActive1.DescListNew[12]);
            }
         }
      }
      
      protected function ProcessorOnServerListOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = this.FCurPage;
         if(Boolean(FOnItemOver != null) && Boolean(this.FSeptemberActive1) && _loc2_ < this.FSeptemberActive1.ServerList.length)
         {
            FOnNewBoxOver(this.FSeptemberActive1.ServerList[_loc2_].Inventories);
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
      
      protected function ProcessorOnShowRecruit(param1:MouseEvent) : void
      {
         var _loc2_:TBaseBox = null;
         if(Boolean(FOnShowRecruit != null) && Boolean(this.FSeptemberActive1) && Boolean(this.FSeptemberActive1.SaleItem))
         {
            _loc2_ = this.FSeptemberActive1.SaleItem;
            FOnShowRecruit(_loc2_.Identify,_loc2_.Type);
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
         if(FInitialized && this.visible)
         {
            if(this.FSaleItem)
            {
               this.FSaleItem.LogicsPerform();
            }
         }
      }
      
      override public function UpdateUI() : void
      {
         this.FSeptemberActive1 = SLogicsCore.SeptemberActiveDatas.GetActivityByIdentify(ACTIVITY_1_ID) as TSeptemberActive1;
         this.UpdateGift();
         this.UpdateSaleItem();
         this.UpdateServerList();
         this.UpdateBox();
         this.UpdateText();
      }
   }
}

