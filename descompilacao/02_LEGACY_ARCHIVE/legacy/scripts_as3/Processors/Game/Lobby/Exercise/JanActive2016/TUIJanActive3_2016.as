package Processors.Game.Lobby.Exercise.JanActive2016
{
   import Components.Pages.TUIPage;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.Exercise.JanActive_2016.TJanActive3_2016;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Lottery.TLotteryNews;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseBox;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIShowItem;
   import Rendering.Overlayers.ExerciseTip.TOverlayerJanActive3_2016;
   import Resources.Strings.STRING_BASEACTIVITY;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class TUIJanActive3_2016 extends TUIBaseWindow
   {
      
      protected static const GIFT_COUNT:int = 3;
      
      protected static const BOX_COUNT:int = 12;
      
      protected static const EXCHANGE_COUNT:int = 4;
      
      protected static const LOG_COUNT:int = 10;
      
      protected static const ACTIVITY_3_ID:int = 3;
      
      public static const MOVIE_OF_OPEN_BOX:int = 1;
      
      public static const MOVIE_OF_OPEN_ALL_BOX:int = 2;
      
      public static const MOVIE_OF_RESET:int = 3;
      
      protected var FJanActive3_2016:TJanActive3_2016;
      
      protected var FMovieType:int;
      
      protected var FFrameCount:int;
      
      protected var FUIPage:TUIPage;
      
      protected var FTotalPage:int;
      
      protected var FCurPage:int;
      
      protected var FUIPage_Lucky:TUIPage;
      
      protected var FTotalPage_Lucky:int;
      
      protected var FCurPage_Lucky:int;
      
      protected var FOpenIndex:int;
      
      protected var FShowItem:TUIShowItem;
      
      protected var FOverlayerJanActive3_2016:TOverlayerJanActive3_2016;
      
      protected var FTipObj:Object;
      
      protected var FExchangeList:Vector.<TUIBaseBox>;
      
      public function TUIJanActive3_2016(param1:TUIComponent)
      {
         super(param1);
         this.FUIPage = new TUIPage(this);
         this.FUIPage_Lucky = new TUIPage(this);
         this.FTipObj = new Object();
         this.FExchangeList = new Vector.<TUIBaseBox>(EXCHANGE_COUNT);
      }
      
      override protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TUIShowItem = null;
         var _loc5_:MovieClip = null;
         var _loc6_:TUIBaseBox = null;
         super.Resources_UIDispatch(param1);
         _loc2_ = 0;
         while(_loc2_ < BOX_COUNT)
         {
            FMC_Scene.MC_Ice["MC_Ice" + _loc2_].buttonMode = true;
            FMC_Scene.MC_Ice["MC_Ice" + _loc2_].addEventListener(MouseEvent.CLICK,this.ProcessorOnGiftUp);
            FMC_Scene.MC_Ice["MC_Ice" + _loc2_].addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnGiftOver);
            FMC_Scene.MC_Ice["MC_Ice" + _loc2_].addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < EXCHANGE_COUNT)
         {
            _loc6_ = new TUIBaseBox(this,1);
            _loc6_.Perform_UIDispatch(FMC_Scene.MC_ExchangeItem["MC_Item" + _loc2_]);
            _loc6_.OnOverlay = this.ProcessorOnItemOver;
            _loc6_.OnOut = this.ProcessorOnItemOut;
            _loc6_.OnGetBox = this.ProcessorOnExchangeUp;
            this.FExchangeList[_loc2_] = _loc6_;
            _loc2_++;
         }
         this.FShowItem = new TUIShowItem(this,GIFT_COUNT);
         this.FShowItem.Perform_UIDispatch(FMC_Scene.MC_ShowItems);
         this.FShowItem.OnOverlay = this.ProcessorOnItemOver;
         this.FShowItem.OnOut = this.ProcessorOnItemOut;
         this.FShowItem.OnShowRecruit = this.ProcessorOnShowRecruit;
         this.FUIPage.ButtonPrevious.Substrate = FMC_Scene.MC_ChangePage.MC_PageLeft;
         this.FUIPage.ButtonNext.Substrate = FMC_Scene.MC_ChangePage.MC_PageRight;
         this.FUIPage.LabelPage = FMC_Scene.MC_ChangePage.TF_Page;
         this.FUIPage.PageSize = EXCHANGE_COUNT;
         this.FUIPage.PageIndex = 0;
         this.FCurPage = 0;
         this.FUIPage.OnChangePage = this.ProcessorPageOnChange;
         this.FUIPage_Lucky.ButtonPrevious.Substrate = FMC_Scene.MC_Lucky.MC_ChangePage.MC_PageLeft;
         this.FUIPage_Lucky.ButtonNext.Substrate = FMC_Scene.MC_Lucky.MC_ChangePage.MC_PageRight;
         this.FUIPage_Lucky.LabelPage = FMC_Scene.MC_Lucky.MC_ChangePage.TF_Page;
         this.FUIPage_Lucky.TotalQuantity = this.FTotalPage_Lucky;
         this.FUIPage_Lucky.PageSize = LOG_COUNT;
         this.FUIPage_Lucky.PageIndex = 0;
         this.FCurPage_Lucky = 0;
         this.FUIPage_Lucky.OnChangePage = this.ProcessorPageOnChange_Lucky;
         this.FOverlayerJanActive3_2016 = new TOverlayerJanActive3_2016(this.Parent);
         this.FOverlayerJanActive3_2016.Visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerJanActive3_2016);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Get,true);
         FMC_Scene.BTN_Get.addEventListener(MouseEvent.CLICK,this.ProcessorOnExchangeHeroBoxUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Exchange,true);
         FMC_Scene.BTN_Exchange.addEventListener(MouseEvent.CLICK,this.ProcessorOnExchangeHeroUp);
         FMC_Scene.MC_Hero.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnHeroOver);
         FMC_Scene.MC_Hero.addEventListener(MouseEvent.MOUSE_OUT,ProcessorOnHideHtmlTip);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Reset,true);
         FMC_Scene.BTN_Reset.addEventListener(MouseEvent.CLICK,this.ProcessorOnResetUp);
         FMC_Scene.BTN_Reset.addEventListener(MouseEvent.MOUSE_OVER,this.ProcessorOnResetOver);
         FMC_Scene.BTN_Reset.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Auto,true);
         FMC_Scene.BTN_Auto.addEventListener(MouseEvent.CLICK,this.ProcessorOnAutoUp);
         FMC_Scene.BTN_Auto.addEventListener(MouseEvent.MOUSE_OVER,this.ProcessorOnAutoOver);
         FMC_Scene.BTN_Auto.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
         TGameUtil.setButtonMode(FMC_Scene.BTN_LuckyLog,true);
         FMC_Scene.BTN_LuckyLog.addEventListener(MouseEvent.CLICK,this.ProcessorOnLuckyLog);
         FMC_Scene.MC_Lucky.Btn_Close.addEventListener(MouseEvent.CLICK,this.ProcessorOnCloseLogUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Log,true);
         FMC_Scene.BTN_Log.addEventListener(MouseEvent.CLICK,this.ProcessorOnLoadLog);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Desc,true);
         FMC_Scene.BTN_Desc.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowDesc);
         FMC_Scene.MC_Tip.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnBoxTipOver);
         FMC_Scene.MC_Tip.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
         TGameUtil.setButtonMode(FMC_Scene.BTN_HeroDesc,true);
         FMC_Scene.BTN_HeroDesc.addEventListener(MouseEvent.CLICK,this.ProcessorOnHeroUp);
         FMC_Scene.MC_Lucky.visible = false;
         FMC_Scene.MC_Movie0.visible = false;
         FMC_Scene.MC_Movie1.visible = false;
      }
      
      protected function UpdateHero() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:TBaseBox = null;
         this.FShowItem.UpdateUI(this.FJanActive3_2016.HeroBox.Inventories);
         _loc2_ = this.FJanActive3_2016.Hero;
         FMC_Scene.TF_Price.text = _loc2_.Price.toString();
         if(_loc2_.Status == TBaseActivity.STATUS_GETED)
         {
            FMC_Scene.MC_Got.visible = true;
            FMC_Scene.BTN_Exchange.visible = false;
            TGameUtil.setButtonMode(FMC_Scene.BTN_Exchange,false);
         }
         else if(this.FJanActive3_2016.Score >= _loc2_.Price)
         {
            FMC_Scene.MC_Got.visible = false;
            FMC_Scene.BTN_Exchange.visible = true;
            TGameUtil.setButtonMode(FMC_Scene.BTN_Exchange,true);
         }
         else
         {
            FMC_Scene.MC_Got.visible = false;
            FMC_Scene.BTN_Exchange.visible = true;
            TGameUtil.setButtonMode(FMC_Scene.BTN_Exchange,false);
         }
         _loc2_ = this.FJanActive3_2016.HeroBox;
         if(_loc2_.Status == TBaseActivity.STATUS_GETED)
         {
            FMC_Scene.MC_Got1.visible = true;
            FMC_Scene.BTN_Get.visible = false;
            TGameUtil.setButtonMode(FMC_Scene.BTN_Get,false);
         }
         else if(_loc2_.Status == TBaseActivity.STATUS_CANGET)
         {
            FMC_Scene.MC_Got1.visible = false;
            FMC_Scene.BTN_Get.visible = true;
            TGameUtil.setButtonMode(FMC_Scene.BTN_Get,true);
         }
         else
         {
            FMC_Scene.MC_Got1.visible = false;
            FMC_Scene.BTN_Get.visible = true;
            TGameUtil.setButtonMode(FMC_Scene.BTN_Get,false);
         }
      }
      
      protected function UpdateGame() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         _loc1_ = 0;
         while(_loc1_ < BOX_COUNT)
         {
            _loc2_ = FMC_Scene.MC_Ice["MC_Ice" + _loc1_];
            if(this.FJanActive3_2016.GiftStatus[_loc1_] == TBaseActivity.STATUS_GETED)
            {
               _loc2_.MC_Movie.gotoAndStop(41);
            }
            else
            {
               _loc2_.MC_Movie.gotoAndStop(1);
            }
            _loc1_++;
         }
         if(this.FJanActive3_2016.GiftStatus.indexOf(TBaseActivity.STATUS_GETED) == -1)
         {
            TGameUtil.setButtonMode(FMC_Scene.BTN_Auto,true);
            TGameUtil.setButtonMode(FMC_Scene.BTN_Reset,false);
         }
         else
         {
            TGameUtil.setButtonMode(FMC_Scene.BTN_Auto,false);
            TGameUtil.setButtonMode(FMC_Scene.BTN_Reset,true);
         }
         FMC_Scene.MC_Movie0.visible = false;
         FMC_Scene.MC_Movie1.visible = false;
      }
      
      protected function UpdateItem() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TBaseBox = null;
         var _loc4_:MovieClip = null;
         var _loc5_:String = null;
         this.FUIPage.TotalQuantity = this.FJanActive3_2016.ExchangeItems.length;
         this.FUIPage.Update();
         _loc1_ = 0;
         while(_loc1_ < EXCHANGE_COUNT)
         {
            _loc2_ = _loc1_ + this.FCurPage * EXCHANGE_COUNT;
            if(_loc2_ < this.FJanActive3_2016.ExchangeItems.length)
            {
               this.FExchangeList[_loc1_].SetVisible(true);
               _loc3_ = this.FJanActive3_2016.ExchangeItems[_loc2_];
               this.FExchangeList[_loc1_].UpdateUI(_loc3_.Inventories);
               this.FExchangeList[_loc1_].Identify = _loc2_;
               _loc5_ = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_LIMIT_COUNT,_loc3_.LimitCount.toString());
               this.FExchangeList[_loc1_].SetLimitText(_loc5_);
               _loc5_ = _loc3_.Price.toString();
               this.FExchangeList[_loc1_].SetPriceText(_loc5_);
               if(this.FJanActive3_2016.Score < _loc3_.Price || _loc3_.LimitCount <= 0)
               {
                  this.FExchangeList[_loc1_].SetBtnMode(false);
               }
               else
               {
                  this.FExchangeList[_loc1_].SetBtnMode(true);
               }
            }
            else
            {
               this.FExchangeList[_loc1_].SetVisible(false);
            }
            _loc1_++;
         }
      }
      
      protected function UpdateLucky() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:TLotteryNews = null;
         var _loc8_:TSystemLanguage = null;
         this.FUIPage_Lucky.TotalQuantity = this.FJanActive3_2016.LuckyList.length;
         this.FUIPage_Lucky.Update();
         _loc1_ = 0;
         while(_loc1_ < LOG_COUNT)
         {
            _loc3_ = _loc1_ + this.FCurPage_Lucky * LOG_COUNT;
            if(_loc3_ < this.FJanActive3_2016.LuckyList.length)
            {
               _loc7_ = this.FJanActive3_2016.LuckyList[_loc3_];
               _loc4_ = this.FJanActive3_2016.DescListNew[11];
               if(_loc7_.GetTime > 0)
               {
                  _loc6_ = TUtilityDate.FormatDate(new Date(STimingCore.GetClientShowTime(_loc7_.GetTime) * 1000));
                  _loc4_ = _loc4_.split("%when%").join(_loc6_);
               }
               if(Boolean(_loc7_.PlayerNick) && _loc7_.PlayerNick != "")
               {
                  _loc4_ = _loc4_.split("%who%").join(_loc7_.PlayerNick);
               }
               if(Boolean(_loc7_.Inventories) && _loc7_.Inventories.Count > 0)
               {
                  _loc5_ = _loc7_.Inventories.GetInventoryByIndex(0).Name + "*" + _loc7_.Inventories.GetInventoryByIndex(0).Quantity;
                  _loc4_ = _loc4_.split("%what%").join(_loc5_);
               }
               FMC_Scene.MC_Lucky["TF_Desc" + _loc1_].text = _loc4_;
            }
            else
            {
               FMC_Scene.MC_Lucky["TF_Desc" + _loc1_].text = "";
            }
            _loc1_++;
         }
      }
      
      protected function UpdateText() : void
      {
         var _loc1_:int = 0;
         var _loc2_:String = null;
         var _loc3_:int = 0;
         FMC_Scene.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FJanActive3_2016.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FJanActive3_2016.EndTime) - 1) * 1000)));
         FMC_Scene.TF_Desc.text = this.FJanActive3_2016.DescListNew[1];
         FMC_Scene.TF_ScoreA.text = this.FJanActive3_2016.Score.toString();
         if(this.FJanActive3_2016.Price > 0)
         {
            FMC_Scene.TF_CurPrice.text = TUtilityString.Format(this.FJanActive3_2016.DescListNew[8],this.FJanActive3_2016.Price);
         }
         else
         {
            FMC_Scene.TF_CurPrice.text = this.FJanActive3_2016.DescListNew[13];
         }
      }
      
      protected function ProcessorPageOnChange(param1:Object, param2:int) : void
      {
         this.FCurPage = param2;
         this.UpdateItem();
      }
      
      protected function ProcessorPageOnChange_Lucky(param1:Object, param2:int) : void
      {
         this.FCurPage_Lucky = param2;
         this.UpdateLucky();
      }
      
      protected function ProcessorOnGiftUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(6));
         if(Boolean(FOnBuyBox != null && !FIsPlaying) && Boolean(this.FJanActive3_2016) && this.FJanActive3_2016.GiftStatus[_loc2_] != TBaseActivity.STATUS_GETED)
         {
            FOnBuyBox(ACTIVITY_3_ID,TProcessorJanActive2016.ACTIVITY_3_OPEN_BOX,this.FJanActive3_2016.Price,_loc2_ + 1);
         }
      }
      
      protected function ProcessorOnAutoUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(6));
         if(Boolean(FOnBuyBox != null && !FIsPlaying) && Boolean(this.FJanActive3_2016) && this.FJanActive3_2016.GiftStatus[_loc2_] != TBaseActivity.STATUS_GETED)
         {
            FOnBuyBox(ACTIVITY_3_ID,TProcessorJanActive2016.ACTIVITY_3_OPEN_ALL_BOX,this.FJanActive3_2016.AutoPrice,_loc2_ + 1);
         }
      }
      
      protected function ProcessorOnResetUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(FOnBuyBox != null && !FIsPlaying && Boolean(this.FJanActive3_2016))
         {
            FOnBuyBox(ACTIVITY_3_ID,TProcessorJanActive2016.ACTIVITY_3_RESET,this.FJanActive3_2016.ResetPrice);
         }
      }
      
      protected function ProcessorOnExchangeHeroUp(param1:MouseEvent) : void
      {
         var _loc2_:TBaseBox = null;
         var _loc3_:String = null;
         var _loc4_:int = 0;
         if(!param1.currentTarget.buttonMode || FIsPlaying)
         {
            return;
         }
         if(Boolean(FOnGetBox != null) && Boolean(this.FJanActive3_2016) && Boolean(this.FJanActive3_2016.Hero))
         {
            _loc2_ = this.FJanActive3_2016.Hero;
            if(_loc2_.Status != TBaseActivity.STATUS_GETED && this.FJanActive3_2016.Score >= _loc2_.Price)
            {
               FOnGetBox(ACTIVITY_3_ID,TProcessorJanActive2016.ACTIVITY_3_EXCHANGE_HERO);
            }
         }
      }
      
      protected function ProcessorOnExchangeHeroBoxUp(param1:MouseEvent) : void
      {
         var _loc2_:TBaseBox = null;
         var _loc3_:String = null;
         var _loc4_:int = 0;
         if(!param1.currentTarget.buttonMode || FIsPlaying)
         {
            return;
         }
         if(Boolean(FOnGetBox != null && this.FJanActive3_2016) && Boolean(this.FJanActive3_2016.HeroBox) && this.FJanActive3_2016.HeroBox.Status == TBaseActivity.STATUS_CANGET)
         {
            FOnGetBox(ACTIVITY_3_ID,TProcessorJanActive2016.ACTIVITY_3_GET_GIFT);
         }
      }
      
      protected function ProcessorOnExchangeUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         _loc3_ = _loc2_ + this.FCurPage * EXCHANGE_COUNT;
         if(Boolean(FOnGetBox != null && this.FJanActive3_2016 && _loc2_ < this.FJanActive3_2016.ExchangeItems.length) && Boolean(this.FJanActive3_2016.ExchangeItems[_loc3_].LimitCount > 0) && this.FJanActive3_2016.Score >= this.FJanActive3_2016.ExchangeItems[_loc3_].Price)
         {
            FOnGetBox(ACTIVITY_3_ID,TProcessorJanActive2016.ACTIVITY_3_EXCHANGE_ITEM,_loc3_ + 1);
         }
      }
      
      protected function ProcessorOnLuckyLog(param1:MouseEvent) : void
      {
         FMC_Scene.MC_Lucky.visible = true;
      }
      
      protected function ProcessorOnCloseLogUp(param1:MouseEvent) : void
      {
         FMC_Scene.MC_Lucky.visible = false;
      }
      
      protected function ProcessorOnBoxTipOver(param1:MouseEvent) : void
      {
         if(FOnShowHtmlTip != null && Boolean(this.FJanActive3_2016))
         {
            FOnShowHtmlTip(this.FJanActive3_2016.DescListNew[10]);
         }
      }
      
      protected function ProcessorOnGiftOver(param1:MouseEvent) : void
      {
         if(FOnShowHtmlTip != null && Boolean(this.FJanActive3_2016))
         {
            FOnShowHtmlTip(this.FJanActive3_2016.DescListNew[4 + this.FJanActive3_2016.TipIndex - 1]);
         }
      }
      
      protected function ProcessorOnGiftOut(param1:MouseEvent) : void
      {
         this.FOverlayerJanActive3_2016.Hide();
      }
      
      protected function ProcessorOnAutoOver(param1:MouseEvent) : void
      {
         if(FOnShowHtmlTip != null && Boolean(this.FJanActive3_2016))
         {
            FOnShowHtmlTip(this.FJanActive3_2016.DescListNew[12]);
         }
      }
      
      protected function ProcessorOnResetOver(param1:MouseEvent) : void
      {
         if(Boolean(FOnShowHtmlTip != null) && Boolean(this.FJanActive3_2016) && this.FJanActive3_2016.DescListNew.length > 14)
         {
            FOnShowHtmlTip(this.FJanActive3_2016.DescListNew[14]);
         }
      }
      
      protected function ProcessorOnHeroOver(param1:MouseEvent) : void
      {
         if(FOnShowHtmlTip != null && Boolean(this.FJanActive3_2016))
         {
            FOnShowHtmlTip(this.FJanActive3_2016.DescListNew[9]);
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
            FOnLoadLog(ACTIVITY_3_ID);
         }
      }
      
      protected function ProcessorOnShowDesc(param1:MouseEvent) : void
      {
         if(FOnShowDesc != null)
         {
            FOnShowDesc();
         }
      }
      
      protected function ProcessorOnLoadRank(param1:MouseEvent) : void
      {
         if(FOnLoadRank != null)
         {
            FOnLoadRank(ACTIVITY_3_ID);
         }
      }
      
      protected function ProcessorOnHeroUp(param1:MouseEvent) : void
      {
         if(FOnShowRecruit != null && Boolean(this.FJanActive3_2016.Hero))
         {
            FOnShowRecruit(this.FJanActive3_2016.Hero.Identify);
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
            if(this.FShowItem)
            {
               this.FShowItem.LogicsPerform();
            }
            _loc1_ = 0;
            while(_loc1_ < EXCHANGE_COUNT)
            {
               if(this.FExchangeList[_loc1_])
               {
                  this.FExchangeList[_loc1_].LogicsPerform();
               }
               _loc1_++;
            }
            if(FIsPlaying)
            {
               switch(this.FMovieType)
               {
                  case MOVIE_OF_OPEN_BOX:
                     CurFrame = FMC_Scene.MC_Ice["MC_Ice" + this.FOpenIndex].MC_Movie.currentFrame;
                     break;
                  case MOVIE_OF_OPEN_ALL_BOX:
                     CurFrame = FMC_Scene.MC_Ice["MC_Ice" + this.FOpenIndex].MC_Movie.currentFrame;
                     break;
                  case MOVIE_OF_RESET:
                     CurFrame = FMC_Scene.MC_Movie1.currentFrame;
               }
               if(CurFrame == FTotalFrame)
               {
                  FIsPlaying = false;
                  this.FFrameCount = 0;
                  this.MovieEnd();
               }
               else
               {
                  ++this.FFrameCount;
                  if(this.FFrameCount > 100)
                  {
                     FIsPlaying = false;
                     this.FFrameCount = 0;
                     this.UpdateUI();
                  }
               }
            }
         }
      }
      
      override public function UpdateUI() : void
      {
         FIsPlaying = false;
         this.FJanActive3_2016 = SLogicsCore.JanActiveDatas_2016.GetActivityByIdentify(ACTIVITY_3_ID) as TJanActive3_2016;
         this.UpdateHero();
         this.UpdateGame();
         this.UpdateItem();
         this.UpdateLucky();
         this.UpdateText();
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
         if(this.FMovieType == MOVIE_OF_OPEN_BOX)
         {
            _loc5_ = FMC_Scene.MC_Ice["MC_Ice" + this.FOpenIndex].MC_Movie;
            FTotalFrame = _loc5_.totalFrames;
            _loc5_.gotoAndPlay(1);
         }
         else if(this.FMovieType == MOVIE_OF_OPEN_ALL_BOX)
         {
            _loc3_ = 0;
            while(_loc3_ < BOX_COUNT)
            {
               _loc5_ = FMC_Scene.MC_Ice["MC_Ice" + _loc3_].MC_Movie;
               FTotalFrame = _loc5_.totalFrames;
               _loc5_.gotoAndPlay(1);
               _loc3_++;
            }
            this.FOpenIndex = BOX_COUNT - 1;
         }
         else if(this.FMovieType == MOVIE_OF_RESET)
         {
            _loc5_ = FMC_Scene.MC_Movie1;
            _loc5_.visible = true;
            FTotalFrame = _loc5_.totalFrames;
            _loc5_.gotoAndPlay(1);
         }
      }
      
      override public function MovieEnd() : void
      {
         var _loc1_:int = 0;
         var _loc2_:String = null;
         FIsPlaying = false;
         if(this.FMovieType == MOVIE_OF_OPEN_BOX)
         {
            this.UpdateUI();
         }
         else if(this.FMovieType == MOVIE_OF_OPEN_ALL_BOX)
         {
            this.UpdateUI();
         }
         else if(this.FMovieType == MOVIE_OF_RESET)
         {
            FMC_Scene.MC_Movie1.stop();
            FMC_Scene.MC_Movie1.visible = false;
            this.UpdateUI();
         }
      }
      
      override public function SetMovieParam(param1:int = 0, param2:int = 0, param3:int = 0) : void
      {
         this.FOpenIndex = param1;
      }
   }
}

