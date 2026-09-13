package Processors.Game.Lobby.Exercise.Christmas.Compoents
{
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.Christmas.TChristmasSock;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Exercise.Christmas.TProcessorChristmas;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class TUIChristmasSock extends TUIChristmasBase
   {
      
      protected static const SWEET_COUNT:int = 6;
      
      protected static const SOCK_COUNT:int = 2;
      
      protected static const BOX_COUNT:int = 3;
      
      protected static const ACTIVITY_5_ID:int = TProcessorChristmas.ACTIVITY_5_ID;
      
      protected var FSweetList:Vector.<MovieClip>;
      
      protected var FSockList:Vector.<MovieClip>;
      
      protected var FBoxList:Vector.<MovieClip>;
      
      protected var FChristmasSock:TChristmasSock;
      
      public function TUIChristmasSock(param1:TUIComponent)
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
            TGameUtil.setButtonMode(this.FBoxList[_loc2_].BTN_Exchange,true);
            this.FBoxList[_loc2_].BTN_Exchange.addEventListener(MouseEvent.CLICK,this.ProcessorOnBoxUp);
            this.FBoxList[_loc2_].MC_BoxPic.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnBoxOver);
            this.FBoxList[_loc2_].MC_BoxPic.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnBoxOut);
            _loc2_++;
         }
         FMC_Scene.MC_Hero.buttonMode = true;
         FMC_Scene.MC_Hero.addEventListener(MouseEvent.CLICK,this.ProcessorOnHeroUp);
         FMC_Scene.MC_Hero.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnHeroOver);
         FMC_Scene.MC_Hero.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnHeroOut);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Log,true);
         FMC_Scene.BTN_Log.addEventListener(MouseEvent.CLICK,this.ProcessorOnLoadLog);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Exchange,true);
         FMC_Scene.BTN_Exchange.addEventListener(MouseEvent.CLICK,this.ProcessorOnGetHeroUp);
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
            if(_loc1_ < this.FChristmasSock.SweetList.length)
            {
               _loc3_.visible = true;
               _loc4_ = this.FChristmasSock.SweetList[_loc1_];
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
            if(_loc1_ < this.FChristmasSock.SockList.length)
            {
               _loc3_.visible = true;
               _loc4_ = this.FChristmasSock.SockList[_loc1_];
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
            if(_loc1_ < this.FChristmasSock.BoxList.length)
            {
               _loc3_.visible = true;
               _loc4_ = this.FChristmasSock.BoxList[_loc1_];
               _loc3_.TF_Count.text = "*" + this.FChristmasSock.BoxList[_loc1_].Price;
               _loc3_.MC_BoxPic.gotoAndStop(_loc1_ + 1);
               if(this.FChristmasSock.Score >= _loc4_.Price)
               {
                  TGameUtil.setButtonMode(_loc3_.BTN_Exchange,true);
               }
               else
               {
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
         if(this.FChristmasSock.ExchangeHero.Status == TBaseActivity.STATUS_GETED)
         {
            FMC_Scene.MC_Got.visible = true;
            FMC_Scene.BTN_Exchange.visible = false;
         }
         else
         {
            FMC_Scene.MC_Got.visible = false;
            FMC_Scene.BTN_Exchange.visible = true;
            if(this.FChristmasSock.Score >= this.FChristmasSock.ExchangeHero.Price)
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
         FMC_Scene.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FChristmasSock.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FChristmasSock.EndTime) - 1) * 1000)));
         FMC_Scene.TF_Count.text = this.FChristmasSock.Score.toString();
         FMC_Scene.TF_Price.text = this.FChristmasSock.ExchangeHero.Price.toString();
      }
      
      protected function ProcessorOnSweetUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TBaseBox = null;
         _loc2_ = int(String(param1.currentTarget.name).slice(8));
         if(_loc2_ >= this.FChristmasSock.SweetList.length)
         {
            return;
         }
         if(FOnBuyBox != null)
         {
            _loc3_ = this.FChristmasSock.SweetList[_loc2_];
            if(_loc3_.Status == TBaseActivity.STATUS_CANGET)
            {
               FOnBuyBox(ACTIVITY_5_ID,TProcessorChristmas.CHRISTMAS_SOCK_GET_SWEET,_loc3_.Price,_loc2_ + 1,_loc3_.Type);
            }
         }
      }
      
      protected function ProcessorOnSweetOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         _loc2_ = int(String(param1.currentTarget.name).slice(8));
         if(_loc2_ >= this.FChristmasSock.SweetList.length)
         {
            return;
         }
         if(FOnShowTip != null)
         {
            _loc3_ = this.FChristmasSock.SweetList[_loc2_].Desc1;
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
         if(_loc2_ >= this.FChristmasSock.SockList.length)
         {
            return;
         }
         if(FOnBuyBox != null)
         {
            _loc3_ = this.FChristmasSock.SockList[_loc2_];
            if(_loc3_.BuyCount == 0)
            {
               FOnBuyBox(ACTIVITY_5_ID,TProcessorChristmas.CHRISTMAS_SOCK_GET_SOCK,_loc3_.CurPrice,_loc2_ + 1);
            }
            else
            {
               FOnBuyBox(ACTIVITY_5_ID,TProcessorChristmas.CHRISTMAS_SOCK_GET_SOCK,_loc3_.Price,_loc2_ + 1);
            }
         }
      }
      
      protected function ProcessorOnBtnBuyOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TBaseBox = null;
         var _loc4_:String = null;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(_loc2_ >= this.FChristmasSock.SockList.length)
         {
            return;
         }
         _loc3_ = this.FChristmasSock.SockList[_loc2_];
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
         if(_loc2_ >= this.FChristmasSock.SockList.length)
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
         if(_loc2_ >= this.FChristmasSock.SockList.length)
         {
            return;
         }
         if(FOnShowThreeStr != null)
         {
            _loc3_ = this.FChristmasSock.SockList[_loc2_];
            FOnShowThreeStr(_loc3_);
         }
      }
      
      protected function ProcessorOnSockOut(param1:MouseEvent) : void
      {
         if(FOnHideThreeStr != null)
         {
            FOnHideThreeStr();
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
         if(_loc2_ >= this.FChristmasSock.BoxList.length)
         {
            return;
         }
         if(FOnGetBox != null)
         {
            FOnGetBox(ACTIVITY_5_ID,TProcessorChristmas.CHRISTMAS_SOCK_GET_BOX,_loc2_ + 1);
         }
      }
      
      override protected function ProcessorOnBoxOver(param1:MouseEvent) : void
      {
         var _loc2_:TInventory = null;
         var _loc3_:int = 0;
         _loc3_ = int(String(param1.currentTarget.parent.name).slice(6));
         if(_loc3_ >= this.FChristmasSock.BoxList.length)
         {
            return;
         }
         if(FOnItemOver != null)
         {
            _loc2_ = this.FChristmasSock.BoxList[_loc3_].Inventories.GetInventoryByIndex(0);
            FOnItemOver(this,_loc2_);
         }
      }
      
      override protected function ProcessorOnBoxOut(param1:MouseEvent) : void
      {
         var _loc2_:TInventory = null;
         var _loc3_:int = 0;
         _loc3_ = int(String(param1.currentTarget.parent.name).slice(6));
         if(_loc3_ >= this.FChristmasSock.BoxList.length)
         {
            return;
         }
         if(FOnItemOut != null)
         {
            _loc2_ = this.FChristmasSock.BoxList[_loc3_].Inventories.GetInventoryByIndex(0);
            FOnItemOut(this,_loc2_);
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
            if(this.FChristmasSock.ExchangeHero.Status != TBaseActivity.STATUS_GETED)
            {
               FOnGetBox(ACTIVITY_5_ID,TProcessorChristmas.CHRISTMAS_SOCK_GET_HERO);
            }
         }
      }
      
      protected function ProcessorOnHeroUp(param1:MouseEvent) : void
      {
         if(FOnShowRecruit != null && Boolean(this.FChristmasSock.ExchangeHero))
         {
            FOnShowRecruit(this.FChristmasSock.ExchangeHero.Identify);
         }
      }
      
      protected function ProcessorOnHeroOver(param1:MouseEvent) : void
      {
         if(FOnBoxOver != null)
         {
            if(this.FChristmasSock.ExchangeHero)
            {
               FOnShowHeroTip(this.FChristmasSock.ExchangeHero);
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
            FOnLoadLog();
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
         this.FChristmasSock = SLogicsCore.ChristmasDatas.GetActivityByIdentify(ACTIVITY_5_ID) as TChristmasSock;
         this.UpdateSweet();
         this.UpdateSock();
         this.UpdateBox();
         this.UpdateHero();
         this.UpdateText();
      }
   }
}

