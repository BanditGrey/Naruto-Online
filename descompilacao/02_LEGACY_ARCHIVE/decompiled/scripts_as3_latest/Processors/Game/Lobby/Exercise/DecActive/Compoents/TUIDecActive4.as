package Processors.Game.Lobby.Exercise.DecActive.Compoents
{
   import Components.Pages.TUIPage;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.DecActive.TDecActive4;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseBox;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Exercise.DecActive.TProcessorDecActive;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.ui.Mouse;
   
   public class TUIDecActive4 extends TUIBaseWindow
   {
      
      protected static const BOX_COUNT:int = 3;
      
      protected static const EXCHANGE_BOX_COUNT:int = 6;
      
      protected static const EGG_COUNT:int = 5;
      
      protected static const ACTIVITY_4_ID:int = 4;
      
      protected static const MOVIE_OPEN_EGG:int = 0;
      
      protected static const MOVIE_REFRESH_EGG:int = 1;
      
      protected static const MOVIE_AUTO:int = 2;
      
      protected var FDecActive4:TDecActive4;
      
      protected var FBoxList:Vector.<MovieClip>;
      
      protected var FExchangeList:Vector.<TUIBaseBox>;
      
      protected var FEggList:Vector.<MovieClip>;
      
      protected var FUIPage:TUIPage;
      
      protected var FTotalPage:int;
      
      protected var FCurPage:int;
      
      protected var FUIPage1:TUIPage;
      
      protected var FTotalPage1:int;
      
      protected var FCurPage1:int;
      
      protected var FMovieType:int;
      
      protected var FEggIndex:int;
      
      protected var FFrameCount:int;
      
      protected var FIsEnd:Boolean;
      
      public function TUIDecActive4(param1:TUIComponent)
      {
         super(param1);
         this.FEggList = new Vector.<MovieClip>(EGG_COUNT);
         this.FBoxList = new Vector.<MovieClip>(BOX_COUNT);
         this.FExchangeList = new Vector.<TUIBaseBox>(EXCHANGE_BOX_COUNT);
         this.FUIPage = new TUIPage(this);
         this.FUIPage1 = new TUIPage(this);
      }
      
      override protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TUIBaseBox = null;
         super.Resources_UIDispatch(param1);
         _loc2_ = 0;
         while(_loc2_ < EGG_COUNT)
         {
            this.FEggList[_loc2_] = FMC_Scene["MC_Egg" + _loc2_];
            this.FEggList[_loc2_].buttonMode = true;
            this.FEggList[_loc2_].addEventListener(MouseEvent.CLICK,this.ProcessorOnEggUp);
            this.FEggList[_loc2_].addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnEggOver);
            this.FEggList[_loc2_].addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnEggOut);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < BOX_COUNT)
         {
            this.FBoxList[_loc2_] = FMC_Scene["MC_Box" + _loc2_];
            this.FBoxList[_loc2_].buttonMode = true;
            this.FBoxList[_loc2_].addEventListener(MouseEvent.CLICK,this.ProcessorOnGetBoxUp);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < EXCHANGE_BOX_COUNT)
         {
            _loc4_ = new TUIBaseBox(this,1);
            _loc4_.Perform_UIDispatch(FMC_Scene["MC_Item" + _loc2_]);
            _loc4_.OnOverlay = this.SlotsOnOver;
            _loc4_.OnOut = this.SlotsOnOut;
            this.FExchangeList[_loc2_] = _loc4_;
            FMC_Scene["MC_Item" + _loc2_].BTN_Exchange.addEventListener(MouseEvent.CLICK,this.ProcessorOnExchangeUp);
            _loc2_++;
         }
         this.FUIPage.ButtonPrevious.Substrate = FMC_Scene.Btn_Left;
         this.FUIPage.ButtonNext.Substrate = FMC_Scene.Btn_Right;
         this.FUIPage.TotalQuantity = this.FTotalPage;
         this.FUIPage.PageSize = BOX_COUNT;
         this.FUIPage.PageIndex = 0;
         this.FCurPage = 0;
         this.FUIPage.OnChangePage = this.ProcessorPageOnChange;
         FMC_Scene.MC_Hero.buttonMode = true;
         TGameUtil.setButtonMode(FMC_Scene.BTN_Exchange,true);
         FMC_Scene.BTN_Exchange.addEventListener(MouseEvent.CLICK,this.ProcessorOnExchangeHeroUp);
         FMC_Scene.MC_Hero.addEventListener(MouseEvent.CLICK,this.ProcessorOnHeroDescUp);
         FMC_Scene.MC_Hero.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnHeroOver);
         FMC_Scene.MC_Hero.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Reset,true);
         FMC_Scene.BTN_Reset.addEventListener(MouseEvent.CLICK,this.ProcessorOnResetUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Auto,true);
         FMC_Scene.BTN_Auto.addEventListener(MouseEvent.CLICK,this.ProcessorOnAutoUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Book,true);
         FMC_Scene.BTN_Book.addEventListener(MouseEvent.CLICK,this.ProcessorOnBookUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Log,true);
         FMC_Scene.BTN_Log.addEventListener(MouseEvent.CLICK,this.ProcessorOnLoadLog);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Desc,true);
         FMC_Scene.BTN_Desc.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowDesc);
         FMC_Scene.MC_Hammer.visible = false;
         FMC_Scene.MC_Hammer.mouseEnabled = false;
         FMC_Scene.MC_Hammer.mouseChildren = false;
         FMC_Scene.MC_AutoMovie.visible = false;
      }
      
      protected function UpdateEgg() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < EGG_COUNT)
         {
            _loc1_ = this.FEggList[_loc2_];
            _loc4_ = this.FDecActive4.EggIndex[_loc2_];
            _loc5_ = this.FDecActive4.EggStatus[_loc2_];
            if(_loc5_ == TBaseActivity.STATUS_GETED)
            {
               _loc1_.MC_OpenBox.visible = true;
               _loc1_.MC_Movie.visible = false;
               _loc1_.MC_OpenBox.gotoAndStop(_loc4_);
            }
            else
            {
               _loc1_.MC_OpenBox.visible = false;
               _loc1_.MC_Movie.visible = true;
               _loc1_.MC_Movie.MC_Box.gotoAndStop(_loc4_);
            }
            _loc2_++;
         }
         FMC_Scene.MC_Half.visible = this.FDecActive4.HalfCount > 0 ? true : false;
         FMC_Scene.TF_Half.text = TUtilityString.Format(this.FDecActive4.DescListNew[8],this.FDecActive4.AutoPrice,this.FDecActive4.HalfCount);
      }
      
      protected function UpdateBox() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:TBaseBox = null;
         var _loc6_:int = 0;
         this.FUIPage.TotalQuantity = this.FDecActive4.BoxList.length;
         this.FUIPage.Update();
         _loc1_ = 0;
         while(_loc1_ < BOX_COUNT)
         {
            _loc4_ = this.FBoxList[_loc1_];
            _loc2_ = _loc1_ + this.FCurPage * BOX_COUNT;
            if(_loc2_ < this.FDecActive4.BoxList.length)
            {
               _loc4_.visible = true;
               _loc4_.MC_BoxPic.gotoAndStop(_loc2_ + 1);
               _loc5_ = this.FDecActive4.BoxList[_loc2_];
               _loc4_.TF_Price.text = TUtilityString.Format(this.FDecActive4.DescListNew[7],_loc5_.Price);
               _loc4_.TF_Count.text = "*" + _loc5_.Inventories.GetInventoryByIndex(0).Quantity;
               if(_loc5_.Status == TBaseActivity.STATUS_GETED)
               {
                  _loc4_.MC_Got.visible = true;
                  _loc4_.MC_Click.visible = false;
               }
               else if(_loc5_.Status == TBaseActivity.STATUS_CANGET)
               {
                  _loc4_.MC_Got.visible = false;
                  _loc4_.MC_Click.visible = true;
               }
               else
               {
                  _loc4_.MC_Got.visible = false;
                  _loc4_.MC_Click.visible = false;
               }
            }
            else
            {
               _loc4_.visible = false;
            }
            _loc1_++;
         }
      }
      
      protected function UpdateHero() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:TBaseBox = null;
         _loc1_ = FMC_Scene.MC_Hero;
         _loc2_ = this.FDecActive4.Hero;
         FMC_Scene.TF_Price.text = _loc2_.Price.toString();
         if(_loc2_.Status == TBaseActivity.STATUS_GETED)
         {
            FMC_Scene.MC_Got.visible = true;
            TGameUtil.setButtonMode(FMC_Scene.BTN_Exchange,false);
         }
         else if(this.FDecActive4.ScoreB >= _loc2_.Price)
         {
            FMC_Scene.MC_Got.visible = false;
            TGameUtil.setButtonMode(FMC_Scene.BTN_Exchange,true);
         }
         else
         {
            FMC_Scene.MC_Got.visible = false;
            TGameUtil.setButtonMode(FMC_Scene.BTN_Exchange,false);
         }
      }
      
      protected function UpdateExchange() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:TBaseBox = null;
         _loc1_ = 0;
         while(_loc1_ < EXCHANGE_BOX_COUNT)
         {
            _loc3_ = _loc1_ + this.FCurPage1 * EXCHANGE_BOX_COUNT;
            if(_loc3_ < this.FDecActive4.ExchangeItems.length)
            {
               this.FExchangeList[_loc1_].SetVisible(true);
               _loc5_ = this.FDecActive4.ExchangeItems[_loc3_];
               this.FExchangeList[_loc1_].UpdateUI(_loc5_.Inventories);
               this.FExchangeList[_loc1_].Identify = _loc3_;
               _loc4_ = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_LIMIT_COUNT,_loc5_.LimitCount.toString());
               this.FExchangeList[_loc1_].SetLimitText(_loc4_);
               _loc4_ = _loc5_.Price.toString();
               this.FExchangeList[_loc1_].SetPriceText(_loc4_);
               if(this.FDecActive4.ScoreB < _loc5_.Price || _loc5_.LimitCount <= 0)
               {
                  this.FExchangeList[_loc1_].SetExchangeBtnMode(false);
               }
               else
               {
                  this.FExchangeList[_loc1_].SetExchangeBtnMode(true);
               }
            }
            else
            {
               this.FExchangeList[_loc1_].SetVisible(false);
            }
            _loc1_++;
         }
      }
      
      protected function UpdateText() : void
      {
         FMC_Scene.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FDecActive4.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FDecActive4.EndTime) - 1) * 1000)));
         FMC_Scene.TF_Desc.text = this.FDecActive4.DescListNew[1];
         FMC_Scene.TF_CountB.text = this.FDecActive4.ScoreB.toString();
         FMC_Scene.TF_RechargeGold.text = TUtilityString.Format(this.FDecActive4.DescListNew[6],this.FDecActive4.RechargeGold);
      }
      
      protected function ProcessorPageOnChange(param1:Object, param2:int) : void
      {
         this.FCurPage = param2;
         this.UpdateBox();
      }
      
      protected function ProcessorPageOnChange1(param1:Object, param2:int) : void
      {
         this.FCurPage1 = param2;
         this.UpdateExchange();
      }
      
      protected function ProcessorOnEggUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         _loc2_ = int(String(param1.currentTarget.name).slice(6));
         if(Boolean(!FIsPlaying && FOnBuyBox != null) && Boolean(this.FDecActive4) && this.FDecActive4.EggStatus[_loc2_] != TBaseActivity.STATUS_GETED)
         {
            this.FEggIndex = _loc2_;
            _loc3_ = (this.FDecActive4.Count - this.FDecActive4.ScoreA) * this.FDecActive4.Price;
            FOnBuyBox(ACTIVITY_4_ID,TProcessorDecActive.ACTIVITY_4_PLAY_GAME,_loc3_,_loc2_ + 1);
         }
      }
      
      protected function ProcessorOnResetUp(param1:MouseEvent) : void
      {
         if(!FIsPlaying && FOnBuyBox != null && Boolean(this.FDecActive4))
         {
            FOnBuyBox(ACTIVITY_4_ID,TProcessorDecActive.ACTIVITY_4_RESET_GAME,this.FDecActive4.ResetPrice);
         }
      }
      
      protected function ProcessorOnAutoUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(!FIsPlaying && FOnBuyBox != null && Boolean(this.FDecActive4))
         {
            if(this.FDecActive4.HalfCount > 0)
            {
               _loc2_ = this.FDecActive4.AutoPrice / 2;
            }
            else
            {
               _loc2_ = this.FDecActive4.AutoPrice;
            }
            FOnBuyBox(ACTIVITY_4_ID,TProcessorDecActive.ACTIVITY_4_AUTO_PLAY,_loc2_);
         }
      }
      
      override protected function ProcessorOnGetBoxUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(6));
         if(!FIsPlaying && FOnGetBox != null && Boolean(this.FDecActive4))
         {
            _loc3_ = _loc2_ + this.FCurPage * BOX_COUNT;
            if(this.FDecActive4.BoxList[_loc3_].Status == TBaseActivity.STATUS_CANGET)
            {
               FOnGetBox(ACTIVITY_4_ID,TProcessorDecActive.ACTIVITY_4_GET_GIFT,_loc3_ + 1);
            }
         }
      }
      
      protected function ProcessorOnBookUp(param1:MouseEvent) : void
      {
         if(FOnShowWindow != null)
         {
            FOnShowWindow(TProcessorDecActive.WINDOW_EGG_BOOK);
         }
      }
      
      protected function ProcessorOnExchangeHeroUp(param1:MouseEvent) : void
      {
         var _loc2_:TBaseBox = null;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(!FIsPlaying && FOnGetBox != null && Boolean(this.FDecActive4))
         {
            _loc2_ = this.FDecActive4.Hero;
            if(_loc2_.Status != TBaseActivity.STATUS_GETED && this.FDecActive4.ScoreB >= _loc2_.Price)
            {
               FOnGetBox(ACTIVITY_4_ID,TProcessorDecActive.ACTIVITY_4_EXCHANGE_HERO);
            }
         }
      }
      
      protected function ProcessorOnExchangeUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         _loc3_ = _loc2_ + this.FCurPage1 * EXCHANGE_BOX_COUNT;
         if(Boolean(!FIsPlaying && FOnGetBox != null && this.FDecActive4 && _loc3_ < this.FDecActive4.ExchangeItems.length) && Boolean(this.FDecActive4.ExchangeItems[_loc3_].LimitCount > 0) && this.FDecActive4.ScoreB >= this.FDecActive4.ExchangeItems[_loc3_].Price)
         {
            FOnGetBox(ACTIVITY_4_ID,TProcessorDecActive.ACTIVITY_4_EXCHANGE_ITEM,_loc3_ + 1);
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
      
      protected function ProcessorOnEggOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         Mouse.hide();
         _loc2_ = int(String(param1.currentTarget.name).slice(6));
         FMC_Scene.MC_Hammer.visible = true;
         FMC_Scene.MC_Hammer.x = param1.localX + 77 + _loc2_ * 95;
         FMC_Scene.MC_Hammer.y = param1.localY + 118;
         _loc3_ = this.FDecActive4.EggIndex[_loc2_] - 1;
         if(FOnShowHtmlTip != null && Boolean(this.FDecActive4))
         {
            FOnShowHtmlTip(this.FDecActive4.DescListNew[9 + _loc3_]);
         }
      }
      
      protected function ProcessorOnEggOut(param1:MouseEvent) : void
      {
         Mouse.show();
         FMC_Scene.MC_Hammer.visible = false;
         if(FOnHideHtmlTip != null)
         {
            FOnHideHtmlTip();
         }
      }
      
      protected function ProcessorOnSocksOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(6));
         _loc3_ = _loc2_ + this.FCurPage * BOX_COUNT;
         if(Boolean(FOnNewBoxOver != null) && Boolean(this.FDecActive4) && _loc3_ < this.FDecActive4.BoxList.length)
         {
            FOnNewBoxOver(this.FDecActive4.BoxList[_loc3_].Inventories,this.FDecActive4.DescListNew[9]);
         }
      }
      
      protected function ProcessorOnHeroDescUp(param1:MouseEvent) : void
      {
         var _loc2_:TBaseBox = null;
         if(Boolean(FOnShowRecruit != null) && Boolean(this.FDecActive4) && Boolean(this.FDecActive4.Hero))
         {
            _loc2_ = this.FDecActive4.Hero;
            FOnShowRecruit(_loc2_.Identify,_loc2_.Type);
         }
      }
      
      protected function ProcessorOnHeroOver(param1:MouseEvent) : void
      {
         if(Boolean(FOnShowHtmlTip != null) && Boolean(this.FDecActive4) && this.FDecActive4.DescList.length > 5)
         {
            FOnShowHtmlTip(this.FDecActive4.DescListNew[2]);
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
         var _loc1_:int = 0;
         if(FInitialized && this.visible)
         {
            _loc1_ = 0;
            while(_loc1_ < EXCHANGE_BOX_COUNT)
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
                  case MOVIE_OPEN_EGG:
                     CurFrame = this.FEggList[this.FEggIndex].MC_Movie.currentFrame;
                     break;
                  case MOVIE_REFRESH_EGG:
                     CurFrame = FMC_Scene.MC_RefreshMovie.currentFrame;
                     break;
                  case MOVIE_AUTO:
                     CurFrame = FMC_Scene.MC_AutoMovie.currentFrame;
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
      
      override public function PlayMovie(param1:int = 0, param2:Boolean = false) : void
      {
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         FIsPlaying = true;
         this.FMovieType = param1;
         if(this.FMovieType == MOVIE_OPEN_EGG)
         {
            _loc4_ = this.FEggList[this.FEggIndex].MC_Movie;
            FTotalFrame = _loc4_.totalFrames;
            _loc4_.gotoAndPlay(1);
            this.FIsEnd = param2;
         }
         else if(this.FMovieType == MOVIE_REFRESH_EGG)
         {
            _loc4_ = FMC_Scene.MC_RefreshMovie;
            FTotalFrame = _loc4_.totalFrames;
            _loc4_.gotoAndPlay(1);
         }
         else if(this.FMovieType == MOVIE_AUTO)
         {
            _loc4_ = FMC_Scene.MC_AutoMovie;
            _loc4_.visible = true;
            FTotalFrame = _loc4_.totalFrames;
            _loc4_.gotoAndPlay(1);
         }
      }
      
      override public function MovieEnd() : void
      {
         var _loc1_:String = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         FIsPlaying = false;
         if(this.FMovieType == MOVIE_OPEN_EGG)
         {
            if(!this.FIsEnd)
            {
               this.UpdateUI();
            }
            else
            {
               this.PlayMovie(MOVIE_REFRESH_EGG);
            }
         }
         else if(this.FMovieType == MOVIE_REFRESH_EGG)
         {
            this.UpdateUI();
         }
         else if(this.FMovieType == MOVIE_AUTO)
         {
            FMC_Scene.MC_AutoMovie.visible = false;
            _loc2_ = 0;
            while(_loc2_ < EGG_COUNT)
            {
               _loc4_ = this.FEggList[_loc2_];
               _loc3_ = this.FDecActive4.EggIndex[_loc2_];
               _loc4_.MC_OpenBox.visible = true;
               _loc4_.MC_Movie.visible = false;
               _loc4_.MC_OpenBox.gotoAndStop(_loc3_);
               _loc2_++;
            }
            this.UpdateUI();
         }
      }
      
      override public function UpdateUI() : void
      {
         this.FDecActive4 = SLogicsCore.DecActiveDatas.GetActivityByIdentify(ACTIVITY_4_ID) as TDecActive4;
         this.UpdateEgg();
         this.UpdateBox();
         this.UpdateExchange();
         this.UpdateHero();
         this.UpdateText();
      }
   }
}

