package Processors.Game.Lobby.Exercise.JuneActive.Compoents
{
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.JuneActive.TJuneActive4;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Exercise.JuneActive.TProcessorJuneActive;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class TUIJuneActive4 extends TUIBaseWindow
   {
      
      protected static const SWEET_COUNT:int = 6;
      
      protected static const SOCK_COUNT:int = 8;
      
      protected static const BOX_COUNT:int = 6;
      
      protected static const ACTIVITY_4_ID:int = 4;
      
      protected var FSweetList:Vector.<MovieClip>;
      
      protected var FSockList:Vector.<MovieClip>;
      
      protected var FBoxList:Vector.<MovieClip>;
      
      protected var FJuneActive4:TJuneActive4;
      
      public function TUIJuneActive4(param1:TUIComponent)
      {
         super(param1);
         this.FSweetList = new Vector.<MovieClip>(SWEET_COUNT);
         this.FSockList = new Vector.<MovieClip>(SOCK_COUNT);
         this.FBoxList = new Vector.<MovieClip>(BOX_COUNT);
      }
      
      override protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         super.Resources_UIDispatch(param1);
         _loc2_ = 0;
         while(_loc2_ < SWEET_COUNT)
         {
            this.FSweetList[_loc2_] = FMC_Scene["MC_Sweet" + _loc2_];
            this.FSweetList[_loc2_].buttonMode = true;
            this.FSweetList[_loc2_].addEventListener(MouseEvent.CLICK,this.ProcessorOnSweetUp);
            this.FSweetList[_loc2_].addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnSweetOver);
            this.FSweetList[_loc2_].addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnSweetOut);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < SOCK_COUNT)
         {
            this.FSockList[_loc2_] = FMC_Scene["MC_Sock" + _loc2_];
            this.FSockList[_loc2_].MC_Tip.buttonMode = true;
            this.FSockList[_loc2_].MC_Tip.gotoAndStop(_loc2_ + 1);
            TGameUtil.setButtonMode(this.FSockList[_loc2_].BTN_Buy,true);
            this.FSockList[_loc2_].BTN_Buy.addEventListener(MouseEvent.CLICK,this.ProcessorOnSockUp);
            this.FSockList[_loc2_].BTN_Buy.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnBtnBuyOver);
            this.FSockList[_loc2_].BTN_Buy.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnBtnBuyOut);
            this.FSockList[_loc2_].MC_Tip.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnSockOver);
            this.FSockList[_loc2_].MC_Tip.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnSockOut);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < BOX_COUNT)
         {
            this.FBoxList[_loc2_] = FMC_Scene["MC_Box" + _loc2_];
            this.FBoxList[_loc2_].MC_BoxPic.buttonMode = true;
            this.FBoxList[_loc2_].MC_BoxPic.gotoAndStop(_loc2_ + 1);
            TGameUtil.setButtonMode(this.FBoxList[_loc2_].BTN_Exchange,true);
            this.FBoxList[_loc2_].BTN_Exchange.addEventListener(MouseEvent.CLICK,this.ProcessorOnBoxUp);
            this.FBoxList[_loc2_].MC_Tip.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnBoxOver);
            this.FBoxList[_loc2_].MC_Tip.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnBoxOut);
            _loc2_++;
         }
         FMC_Scene.MC_Hero.buttonMode = true;
         FMC_Scene.MC_Hero.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnHeroOver);
         FMC_Scene.MC_Hero.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnHeroOut);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Log,true);
         FMC_Scene.BTN_Log.addEventListener(MouseEvent.CLICK,this.ProcessorOnLoadLog);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Desc,true);
         FMC_Scene.BTN_Desc.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowDesc);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Exchange,true);
         FMC_Scene.BTN_Exchange.addEventListener(MouseEvent.CLICK,this.ProcessorOnGetHeroUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_HeroDesc,true);
         FMC_Scene.BTN_HeroDesc.addEventListener(MouseEvent.CLICK,this.ProcessorOnHeroUp);
      }
      
      protected function UpdateSweet() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:TBaseBox = null;
         _loc1_ = 0;
         while(_loc1_ < SWEET_COUNT)
         {
            _loc3_ = this.FSweetList[_loc1_];
            _loc3_.gotoAndStop(_loc1_ + 1);
            if(_loc1_ < this.FJuneActive4.SweetList.length)
            {
               _loc3_.visible = true;
               _loc4_ = this.FJuneActive4.SweetList[_loc1_];
               if(_loc4_.Status == TBaseActivity.STATUS_GETED)
               {
                  _loc3_.filters = [];
                  _loc3_.MC_Got.visible = true;
               }
               else if(_loc4_.Status == TBaseActivity.STATUS_CANGET)
               {
                  _loc3_.filters = [];
                  _loc3_.MC_Got.visible = false;
               }
               else
               {
                  _loc3_.filters = [TGameUtil.GaryColorFilters];
                  _loc3_.MC_Got.visible = false;
               }
            }
            else
            {
               _loc3_.visible = false;
            }
            _loc1_++;
         }
      }
      
      protected function UpdateSock() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:TBaseBox = null;
         _loc1_ = 0;
         while(_loc1_ < SOCK_COUNT)
         {
            _loc3_ = this.FSockList[_loc1_];
            if(_loc1_ < this.FJuneActive4.SockList.length)
            {
               _loc3_.visible = true;
               _loc4_ = this.FJuneActive4.SockList[_loc1_];
               if(_loc4_.IsHot == 1)
               {
                  _loc3_.MC_Buff2.visible = true;
                  _loc3_.MC_Buff2.TF_Buff.text = _loc4_.Desc1;
               }
               else
               {
                  _loc3_.MC_Buff2.visible = false;
               }
               if(_loc4_.BuyCount == 0)
               {
                  _loc3_.MC_Buff.visible = true;
                  _loc3_.MC_Buff.TF_Buff.text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_SOCK_FIRST_TIME_BUY,_loc4_.CurPrice);
               }
               else
               {
                  _loc3_.MC_Buff.visible = false;
               }
            }
            else
            {
               _loc3_.visible = false;
            }
            _loc1_++;
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
            _loc3_ = this.FBoxList[_loc1_];
            if(_loc1_ < this.FJuneActive4.BoxList.length)
            {
               _loc3_.visible = true;
               _loc4_ = this.FJuneActive4.BoxList[_loc1_];
               _loc3_.TF_Count.text = "*" + _loc4_.Price;
               _loc3_.MC_BoxPic.gotoAndStop(_loc1_ + 1);
               if(_loc4_.Status == TBaseActivity.STATUS_GETED)
               {
                  _loc3_.MC_Got.visible = true;
                  _loc3_.BTN_Exchange.visible = false;
               }
               else if(_loc4_.Status == TBaseActivity.STATUS_CANGET)
               {
                  _loc3_.MC_Got.visible = false;
                  _loc3_.BTN_Exchange.visible = true;
                  TGameUtil.setButtonMode(_loc3_.BTN_Exchange,true);
               }
               else
               {
                  _loc3_.MC_Got.visible = false;
                  _loc3_.BTN_Exchange.visible = true;
                  TGameUtil.setButtonMode(_loc3_.BTN_Exchange,false);
               }
            }
            else
            {
               _loc3_.visible = false;
            }
            _loc1_++;
         }
      }
      
      protected function UpdateHero() : void
      {
         if(this.FJuneActive4.ExchangeHero.Status == TBaseActivity.STATUS_GETED)
         {
            FMC_Scene.MC_Got.visible = true;
            FMC_Scene.BTN_Exchange.visible = false;
         }
         else
         {
            FMC_Scene.MC_Got.visible = false;
            FMC_Scene.BTN_Exchange.visible = true;
            if(this.FJuneActive4.Score >= this.FJuneActive4.ExchangeHero.Price)
            {
               TGameUtil.setButtonMode(FMC_Scene.BTN_Exchange,true);
            }
            else
            {
               TGameUtil.setButtonMode(FMC_Scene.BTN_Exchange,false);
            }
         }
      }
      
      protected function UpdateText() : void
      {
         FMC_Scene.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FJuneActive4.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FJuneActive4.EndTime) - 1) * 1000)));
         FMC_Scene.TF_Count.text = this.FJuneActive4.Score.toString();
         FMC_Scene.TF_Price.text = this.FJuneActive4.ExchangeHero.Price.toString();
         FMC_Scene.TF_TotalCount.text = this.FJuneActive4.TotalCount.toString();
         FMC_Scene.TF_Desc.text = this.FJuneActive4.ActivityDesc2;
      }
      
      protected function ProcessorOnSweetUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TBaseBox = null;
         _loc2_ = int(String(param1.currentTarget.name).slice(8));
         if(_loc2_ >= this.FJuneActive4.SweetList.length)
         {
            return;
         }
         if(FOnBuyBox != null)
         {
            _loc3_ = this.FJuneActive4.SweetList[_loc2_];
            if(_loc3_.Status == TBaseActivity.STATUS_CANGET)
            {
               FOnBuyBox(ACTIVITY_4_ID,TProcessorJuneActive.ACTIVITY_4_GET_SWEET,_loc3_.Price,_loc2_ + 1,_loc3_.Type);
            }
         }
      }
      
      protected function ProcessorOnSweetOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         _loc2_ = int(String(param1.currentTarget.name).slice(8));
         if(_loc2_ >= this.FJuneActive4.SweetList.length)
         {
            return;
         }
         if(FOnShowTip != null)
         {
            _loc3_ = this.FJuneActive4.SweetList[_loc2_].Desc1;
            FOnShowTip(_loc3_);
         }
      }
      
      protected function ProcessorOnSweetOut(param1:MouseEvent) : void
      {
         if(FOnHideTip != null)
         {
            FOnHideTip();
         }
      }
      
      protected function ProcessorOnSockUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TBaseBox = null;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(_loc2_ >= this.FJuneActive4.SockList.length)
         {
            return;
         }
         if(FOnBuyBox != null)
         {
            _loc3_ = this.FJuneActive4.SockList[_loc2_];
            if(_loc3_.BuyCount == 0)
            {
               FOnBuyBox(ACTIVITY_4_ID,TProcessorJuneActive.ACTIVITY_4_GET_SOCK,_loc3_.CurPrice,_loc2_ + 1);
            }
            else
            {
               FOnBuyBox(ACTIVITY_4_ID,TProcessorJuneActive.ACTIVITY_4_GET_SOCK,_loc3_.Price,_loc2_ + 1);
            }
         }
      }
      
      protected function ProcessorOnBtnBuyOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TBaseBox = null;
         var _loc4_:String = null;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(_loc2_ >= this.FJuneActive4.SockList.length)
         {
            return;
         }
         _loc3_ = this.FJuneActive4.SockList[_loc2_];
         if(FOnShowTip != null)
         {
            if(_loc3_.BuyCount == 0)
            {
               _loc4_ = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_BUY_PRICE,_loc3_.CurPrice);
            }
            else
            {
               _loc4_ = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_BUY_PRICE,_loc3_.Price);
            }
            FOnShowTip(_loc4_);
         }
      }
      
      protected function ProcessorOnBtnBuyOut(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TBaseBox = null;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(_loc2_ >= this.FJuneActive4.SockList.length)
         {
            return;
         }
         if(FOnHideTip != null)
         {
            FOnHideTip();
         }
      }
      
      protected function ProcessorOnSockOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TBaseBox = null;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(_loc2_ >= this.FJuneActive4.SockList.length)
         {
            return;
         }
         if(FOnShowHtmlTip != null)
         {
            _loc3_ = this.FJuneActive4.SockList[_loc2_];
            FOnShowHtmlTip(_loc3_.Desc1);
         }
      }
      
      protected function ProcessorOnSockOut(param1:MouseEvent) : void
      {
         if(FOnHideHtmlTip != null)
         {
            FOnHideHtmlTip();
         }
      }
      
      protected function ProcessorOnBoxUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(6));
         if(_loc2_ >= this.FJuneActive4.BoxList.length)
         {
            return;
         }
         if(FOnGetBox != null && this.FJuneActive4.BoxList[_loc2_].Status == TBaseActivity.STATUS_CANGET)
         {
            FOnGetBox(ACTIVITY_4_ID,TProcessorJuneActive.ACTIVITY_4_GET_BOX,_loc2_ + 1);
         }
      }
      
      override protected function ProcessorOnBoxOver(param1:MouseEvent) : void
      {
         var _loc2_:TInventory = null;
         var _loc3_:int = 0;
         _loc3_ = int(String(param1.currentTarget.parent.name).slice(6));
         if(_loc3_ >= this.FJuneActive4.BoxList.length)
         {
            return;
         }
         if(FOnSpecialOver != null)
         {
            FOnSpecialOver(0,this.FJuneActive4.BoxList[_loc3_]);
         }
      }
      
      override protected function ProcessorOnBoxOut(param1:MouseEvent) : void
      {
         var _loc2_:TInventory = null;
         var _loc3_:int = 0;
         _loc3_ = int(String(param1.currentTarget.parent.name).slice(6));
         if(_loc3_ >= this.FJuneActive4.BoxList.length)
         {
            return;
         }
         if(FOnSpecialOut != null)
         {
            FOnSpecialOut(0);
         }
      }
      
      protected function ProcessorOnGetHeroUp(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(FOnGetBox != null)
         {
            if(this.FJuneActive4.ExchangeHero.Status != TBaseActivity.STATUS_GETED)
            {
               FOnGetBox(ACTIVITY_4_ID,TProcessorJuneActive.ACTIVITY_4_GET_HERO);
            }
         }
      }
      
      protected function ProcessorOnHeroUp(param1:MouseEvent) : void
      {
         if(FOnShowRecruit != null && Boolean(this.FJuneActive4.ExchangeHero))
         {
            FOnShowRecruit(this.FJuneActive4.ExchangeHero.Identify);
         }
      }
      
      protected function ProcessorOnHeroOver(param1:MouseEvent) : void
      {
         if(FOnBoxOver != null)
         {
            if(this.FJuneActive4.ExchangeHero)
            {
               FOnShowHeroTip(this.FJuneActive4.ExchangeHero);
            }
         }
      }
      
      protected function ProcessorOnHeroOut(param1:MouseEvent) : void
      {
         if(FOnHideHeroTip != null)
         {
            FOnHideHeroTip();
         }
      }
      
      protected function ProcessorOnLoadLog(param1:MouseEvent) : void
      {
         if(FOnLoadLog != null)
         {
            FOnLoadLog(ACTIVITY_4_ID);
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
         }
      }
      
      override public function UpdateUI() : void
      {
         this.FJuneActive4 = SLogicsCore.JuneActiveDatas.GetActivityByIdentify(ACTIVITY_4_ID) as TJuneActive4;
         this.UpdateSweet();
         this.UpdateSock();
         this.UpdateBox();
         this.UpdateHero();
         this.UpdateText();
      }
   }
}

