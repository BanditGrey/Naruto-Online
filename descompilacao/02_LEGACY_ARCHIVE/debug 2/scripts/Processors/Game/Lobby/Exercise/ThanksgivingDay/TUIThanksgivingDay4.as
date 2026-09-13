package Processors.Game.Lobby.Exercise.ThanksgivingDay
{
   import Components.Pages.TUIPage;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Exercise.ThanksgivingDay.TThanksgivingDay4;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorBaseActivity;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import ghostcat.util.easing.TweenUtil;
   
   public class TUIThanksgivingDay4 extends TUIBaseWindow
   {
      
      protected static const BOX_COUNT:int = 4;
      
      protected static const EXCHANGE_BOX_COUNT:int = 5;
      
      protected static const CARD_COUNT:int = 40;
      
      protected static const ACTIVITY_4_ID:int = 4;
      
      protected static const MOVIE_TYPE_OPEN_CARD:int = 1;
      
      protected static const MOVIE_TYPE_OPEN_ALL_CARD:int = 2;
      
      protected static const MOVIE_TYPE_RESET:int = 3;
      
      protected static const MOVIE_TYPE_CLEAR:int = 4;
      
      protected static const MOVIE_TYPE_CLOSE_CARD:int = 5;
      
      protected var FThanksgivingDay4:TThanksgivingDay4;
      
      protected var FBoxList:Vector.<MovieClip>;
      
      protected var FCardList:Vector.<MovieClip>;
      
      protected var FExchangeList:Vector.<MovieClip>;
      
      protected var FMC_Mask:MovieClip;
      
      protected var FBarMaxWidth:int;
      
      protected var FUIPage:TUIPage;
      
      protected var FTotalPage:int;
      
      protected var FCurPage:int;
      
      protected var FCurIndex:int;
      
      protected var FCurType:int;
      
      protected var FLastIndex:int;
      
      protected var FMovieType:int;
      
      protected var FFrameCount:int;
      
      public function TUIThanksgivingDay4(param1:TUIComponent)
      {
         super(param1);
         this.FBoxList = new Vector.<MovieClip>(BOX_COUNT);
         this.FCardList = new Vector.<MovieClip>(CARD_COUNT);
         this.FExchangeList = new Vector.<MovieClip>(EXCHANGE_BOX_COUNT);
         this.FUIPage = new TUIPage(this);
      }
      
      override protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         super.Resources_UIDispatch(param1);
         _loc2_ = 0;
         while(_loc2_ < CARD_COUNT)
         {
            this.FCardList[_loc2_] = FMC_Scene.MC_Cards["MC_Card" + _loc2_];
            this.FCardList[_loc2_].buttonMode = true;
            this.FCardList[_loc2_].addEventListener(MouseEvent.CLICK,this.ProcessorOnOpenCardUp);
            this.FCardList[_loc2_].addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnCardOver);
            this.FCardList[_loc2_].addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < BOX_COUNT)
         {
            this.FBoxList[_loc2_] = FMC_Scene["MC_Box" + _loc2_];
            this.FBoxList[_loc2_].buttonMode = true;
            this.FBoxList[_loc2_].MC_Icon.gotoAndStop(_loc2_ + 1);
            this.FBoxList[_loc2_].addEventListener(MouseEvent.CLICK,this.ProcessorOnGetBoxUp);
            this.FBoxList[_loc2_].addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnBoxRewardOver);
            this.FBoxList[_loc2_].addEventListener(MouseEvent.ROLL_OUT,ProcessorOnNewBoxOut);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < EXCHANGE_BOX_COUNT)
         {
            this.FExchangeList[_loc2_] = FMC_Scene["MC_Item" + _loc2_];
            this.FExchangeList[_loc2_].MC_Box.buttonMode = true;
            this.FExchangeList[_loc2_].MC_Box.addEventListener(MouseEvent.CLICK,this.ProcessorOnExchangeUp);
            this.FExchangeList[_loc2_].MC_Box.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnExchangeItemOver);
            this.FExchangeList[_loc2_].MC_Box.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnNewBoxOut);
            _loc2_++;
         }
         FMC_Scene.MC_Movie2.visible = false;
         FMC_Scene.MC_Effect.visible = false;
         FMC_Scene.MC_Hero.MC_Hero.buttonMode = true;
         TGameUtil.setButtonMode(FMC_Scene.MC_Hero.BTN_Get,true);
         FMC_Scene.MC_Hero.BTN_Get.addEventListener(MouseEvent.CLICK,this.ProcessorOnExchangeHeroUp);
         FMC_Scene.MC_Hero.MC_Hero.addEventListener(MouseEvent.CLICK,this.ProcessorOnHeroDescUp);
         FMC_Scene.MC_Hero.MC_Hero.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnHeroOver);
         FMC_Scene.MC_Hero.MC_Hero.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Again,true);
         FMC_Scene.BTN_Again.addEventListener(MouseEvent.CLICK,this.ProcessorOnAgainUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_AllOpen,true);
         FMC_Scene.BTN_AllOpen.addEventListener(MouseEvent.CLICK,this.ProcessorOnAllOpenUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Log,true);
         FMC_Scene.BTN_Log.addEventListener(MouseEvent.CLICK,this.ProcessorOnLoadLog);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Desc,true);
         FMC_Scene.BTN_Desc.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowDesc);
         this.FUIPage.ButtonPrevious.Substrate = FMC_Scene.Btn_Left;
         this.FUIPage.ButtonNext.Substrate = FMC_Scene.Btn_Right;
         this.FUIPage.TotalQuantity = this.FTotalPage;
         this.FUIPage.PageSize = EXCHANGE_BOX_COUNT;
         this.FUIPage.PageIndex = 0;
         this.FCurPage = 0;
         this.FUIPage.OnChangePage = this.ProcessorPageOnChange;
         this.FMC_Mask = FMC_Scene.MC_Bar.MC_Mask;
         this.FBarMaxWidth = this.FMC_Mask.width;
         TweenUtil.to(this.FMC_Mask,1000,{"width":0});
      }
      
      protected function UpdateCard() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:TBaseBox = null;
         var _loc5_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < CARD_COUNT)
         {
            _loc3_ = this.FCardList[_loc1_];
            _loc5_ = this.FThanksgivingDay4.CardList[_loc1_];
            _loc3_.MC_Card.MC_ClearMovie.visible = false;
            if(_loc5_ == -1)
            {
               _loc3_.visible = false;
            }
            else
            {
               _loc3_.visible = true;
               if(_loc5_ == 0)
               {
                  _loc3_.MC_Card.MC_Icon.visible = false;
                  _loc3_.MC_Card.gotoAndStop(1);
               }
               else
               {
                  _loc3_.MC_Card.MC_Icon.visible = true;
                  _loc3_.MC_Card.MC_Icon.gotoAndStop(_loc5_);
                  _loc3_.MC_Card.gotoAndStop(_loc3_.MC_Card.totalFrames);
               }
            }
            _loc1_++;
         }
         if(this.FThanksgivingDay4.CardList.indexOf(0) == -1)
         {
            FMC_Scene.MC_OnceMore.visible = true;
            TGameUtil.setButtonMode(FMC_Scene.BTN_AllOpen,false);
         }
         else
         {
            FMC_Scene.MC_OnceMore.visible = false;
            TGameUtil.setButtonMode(FMC_Scene.BTN_AllOpen,true);
         }
         FMC_Scene.MC_Movie2.visible = false;
      }
      
      protected function UpdateBox() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:TBaseBox = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < BOX_COUNT)
         {
            _loc3_ = this.FBoxList[_loc1_];
            _loc4_ = this.FThanksgivingDay4.BoxList[_loc1_];
            _loc3_.TF_Count.text = this.FThanksgivingDay4.BoxScore + "/" + _loc4_.Price;
            if(_loc4_.Status == TBaseActivity.STATUS_CANNOTGET)
            {
               _loc3_.MC_Got.visible = false;
               _loc3_.gotoAndStop(1);
               _loc3_.MC_CanGet.visible = false;
               _loc3_.MC_Icon.gotoAndStop(_loc1_ + 1);
            }
            else if(_loc4_.Status == TBaseActivity.STATUS_CANGET)
            {
               _loc3_.MC_Got.visible = false;
               _loc3_.gotoAndPlay(1);
               _loc3_.MC_CanGet.visible = true;
               _loc3_.MC_Icon.gotoAndStop(_loc1_ + 1);
            }
            else
            {
               _loc3_.MC_Got.visible = true;
               _loc3_.gotoAndStop(1);
               _loc3_.MC_CanGet.visible = false;
               _loc3_.MC_Icon.gotoAndStop(_loc1_ + 1 + BOX_COUNT);
            }
            _loc1_++;
         }
         _loc5_ = Number(this.FThanksgivingDay4.BoxScore / _loc4_.Price) * this.FBarMaxWidth;
         _loc6_ = Math.min(_loc5_,this.FBarMaxWidth);
         TweenUtil.to(this.FMC_Mask,1000,{"width":_loc6_});
      }
      
      protected function UpdateHero() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:TBaseBox = null;
         _loc1_ = FMC_Scene.MC_Hero;
         _loc2_ = this.FThanksgivingDay4.Hero;
         _loc1_.TF_Price.text = _loc2_.Price.toString();
         if(_loc2_.Status == TBaseActivity.STATUS_GETED)
         {
            _loc1_.MC_Got.visible = true;
            TGameUtil.setButtonMode(_loc1_.BTN_Get,false);
         }
         else if(this.FThanksgivingDay4.ShopExchangePoint >= _loc2_.Price)
         {
            _loc1_.MC_Got.visible = false;
            TGameUtil.setButtonMode(_loc1_.BTN_Get,true);
         }
         else
         {
            _loc1_.MC_Got.visible = false;
            TGameUtil.setButtonMode(_loc1_.BTN_Get,false);
         }
      }
      
      protected function UpdateExchange() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:TBaseBox = null;
         this.FUIPage.TotalQuantity = this.FThanksgivingDay4.ShopExchangeItems.length;
         this.FUIPage.Update();
         _loc1_ = 0;
         while(_loc1_ < EXCHANGE_BOX_COUNT)
         {
            _loc2_ = _loc1_ + this.FCurPage * EXCHANGE_BOX_COUNT;
            _loc4_ = FMC_Scene["MC_Item" + _loc1_];
            if(_loc2_ < this.FThanksgivingDay4.ShopExchangeItems.length)
            {
               _loc4_.visible = true;
               _loc5_ = this.FThanksgivingDay4.ShopExchangeItems[_loc2_];
               _loc4_.TF_Limit.text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_LIMIT_COUNT,_loc5_.LimitCount);
               _loc4_.TF_Price.text = _loc5_.Price.toString();
               if(_loc5_.LimitCount > 0 && this.FThanksgivingDay4.ShopExchangePoint >= _loc5_.Price)
               {
                  _loc4_.BTN_Buy.visible = true;
               }
               else
               {
                  _loc4_.BTN_Buy.visible = false;
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
         var _loc1_:int = 0;
         FMC_Scene.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FThanksgivingDay4.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FThanksgivingDay4.EndTime) - 1) * 1000)));
         FMC_Scene.TF_Desc.text = this.FThanksgivingDay4.DescListNew[1];
         FMC_Scene.MC_FreeCount.TF_FreeCount.text = this.FThanksgivingDay4.FreeCount.toString();
         FMC_Scene.TF_Score.text = this.FThanksgivingDay4.ShopExchangePoint.toString();
         _loc1_ = this.FThanksgivingDay4.NextAwardDiff;
         if(_loc1_ > 0)
         {
            FMC_Scene.TF_Desc1.text = TUtilityString.Format(this.FThanksgivingDay4.DescListNew[3],_loc1_);
         }
         else
         {
            FMC_Scene.TF_Desc1.text = this.FThanksgivingDay4.DescListNew[4];
         }
      }
      
      protected function ProcessorPageOnChange(param1:Object, param2:int) : void
      {
         this.FCurPage = param2;
         this.UpdateExchange();
      }
      
      protected function ProcessorOnOpenCardUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(FIsPlaying)
         {
            return;
         }
         _loc2_ = int(String(param1.currentTarget.name).slice(7));
         if(Boolean(FOnBuyBox != null) && Boolean(this.FThanksgivingDay4) && this.FThanksgivingDay4.CardList[_loc2_] == 0)
         {
            if(this.FThanksgivingDay4.FreeCount > 0)
            {
               FOnGetBox(ACTIVITY_4_ID,TProcessorThanksgivingDay.ACTIVITY_4_OPEN_CARD,_loc2_ + 1);
            }
            else
            {
               FOnBuyBox(ACTIVITY_4_ID,TProcessorThanksgivingDay.ACTIVITY_4_OPEN_CARD,this.FThanksgivingDay4.CardPrice,_loc2_ + 1);
            }
         }
      }
      
      protected function ProcessorOnAgainUp(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(FIsPlaying)
         {
            return;
         }
         if(FOnBuyBox != null && Boolean(this.FThanksgivingDay4))
         {
            if(this.FThanksgivingDay4.IsBoxAllGet())
            {
               _loc2_ = TUtilityString.Format(this.FThanksgivingDay4.DescListNew[7],this.FThanksgivingDay4.AgainPrice);
               FOnGetBox(ACTIVITY_4_ID,TProcessorThanksgivingDay.ACTIVITY_4_RESET);
            }
            else
            {
               FOnShowFlowText(this.FThanksgivingDay4.DescListNew[6]);
            }
         }
      }
      
      protected function ProcessorOnAllOpenUp(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(!param1.currentTarget.buttonMode || FIsPlaying)
         {
            return;
         }
         if(FOnBuyBox != null && Boolean(this.FThanksgivingDay4))
         {
            _loc2_ = TUtilityString.Format(this.FThanksgivingDay4.DescListNew[2],this.FThanksgivingDay4.OpenAllCount * this.FThanksgivingDay4.AllOpenPrice,this.FThanksgivingDay4.OpenAllCount + this.FThanksgivingDay4.FreeCount,this.FThanksgivingDay4.AllOpenPrice);
            if(this.FThanksgivingDay4.OpenAllCount > 0)
            {
               FOnBuyBox(ACTIVITY_4_ID,TProcessorThanksgivingDay.ACTIVITY_4_OPEN_ALL_CARD,this.FThanksgivingDay4.OpenAllCount * this.FThanksgivingDay4.AllOpenPrice,0,0,_loc2_);
            }
            else
            {
               FOnGetBox(ACTIVITY_4_ID,TProcessorThanksgivingDay.ACTIVITY_4_OPEN_ALL_CARD);
            }
         }
      }
      
      override protected function ProcessorOnGetBoxUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(FIsPlaying)
         {
            return;
         }
         _loc2_ = int(String(param1.currentTarget.name).slice(6));
         if(Boolean(FOnGetBox != null && this.FThanksgivingDay4) && Boolean(_loc2_ < this.FThanksgivingDay4.BoxList.length) && this.FThanksgivingDay4.BoxList[_loc2_].Status == TBaseActivity.STATUS_CANGET)
         {
            FOnGetBox(ACTIVITY_4_ID,TProcessorThanksgivingDay.ACTIVITY_4_GET_SCORE_BOX,_loc2_ + 1);
         }
      }
      
      protected function ProcessorOnExchangeHeroUp(param1:MouseEvent) : void
      {
         var _loc2_:TBaseBox = null;
         if(!param1.currentTarget.buttonMode || FIsPlaying)
         {
            return;
         }
         if(FOnGetBox != null && Boolean(this.FThanksgivingDay4))
         {
            _loc2_ = this.FThanksgivingDay4.Hero;
            if(_loc2_.Status != TBaseActivity.STATUS_GETED && this.FThanksgivingDay4.ShopExchangePoint >= _loc2_.Price)
            {
               FOnGetBox(ACTIVITY_4_ID,TProcessorThanksgivingDay.ACTIVITY_4_EXCHANGE_HERO,0);
            }
         }
      }
      
      protected function ProcessorOnExchangeUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(FIsPlaying)
         {
            return;
         }
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         _loc3_ = _loc2_ + this.FCurPage * EXCHANGE_BOX_COUNT;
         if(Boolean(FOnGetBox != null && this.FThanksgivingDay4 && _loc3_ < this.FThanksgivingDay4.ShopExchangeItems.length) && Boolean(this.FThanksgivingDay4.ShopExchangeItems[_loc3_].LimitCount > 0) && this.FThanksgivingDay4.ShopExchangePoint >= this.FThanksgivingDay4.ShopExchangeItems[_loc3_].Price)
         {
            FOnGetBox(ACTIVITY_4_ID,TProcessorThanksgivingDay.ACTIVITY_4_EXCHANGE_BOX,_loc3_ + 1);
         }
      }
      
      protected function ProcessorOnExchangeItem(param1:int) : void
      {
         if(!FIsPlaying && FOnGetBox != null && Boolean(this.FThanksgivingDay4))
         {
            FOnGetBox(ACTIVITY_4_ID,TProcessorThanksgivingDay.ACTIVITY_4_EXCHANGE_BOX,param1 + 1);
         }
      }
      
      protected function ProcessorOnCardOver(param1:MouseEvent) : void
      {
      }
      
      protected function ProcessorOnBoxRewardOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(6));
         if(Boolean(FOnNewBoxOver != null) && Boolean(this.FThanksgivingDay4) && _loc2_ < this.FThanksgivingDay4.BoxList.length)
         {
            FOnNewBoxOver(this.FThanksgivingDay4.BoxList[_loc2_].Inventories);
         }
      }
      
      protected function ProcessorOnExchangeItemOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         _loc3_ = _loc2_ + this.FCurPage * EXCHANGE_BOX_COUNT;
         if(Boolean(FOnNewBoxOver != null) && Boolean(this.FThanksgivingDay4) && _loc3_ < this.FThanksgivingDay4.ShopExchangeItems.length)
         {
            FOnNewBoxOver(this.FThanksgivingDay4.ShopExchangeItems[_loc3_].Inventories);
         }
      }
      
      protected function ProcessorOnHeroDescUp(param1:MouseEvent) : void
      {
         var _loc2_:TBaseBox = null;
         if(Boolean(FOnShowRecruit != null) && Boolean(this.FThanksgivingDay4) && Boolean(this.FThanksgivingDay4.Hero))
         {
            _loc2_ = this.FThanksgivingDay4.Hero;
            FOnShowRecruit(_loc2_.Identify,_loc2_.Type);
         }
      }
      
      protected function ProcessorOnHeroOver(param1:MouseEvent) : void
      {
         if(Boolean(FOnShowHtmlTip != null) && Boolean(this.FThanksgivingDay4) && this.FThanksgivingDay4.DescList.length > 5)
         {
            FOnShowHtmlTip(this.FThanksgivingDay4.DescListNew[5]);
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
      
      protected function ProcessorOnShowEquipDesc1(param1:MouseEvent) : void
      {
         if(FOnShowWindow != null)
         {
            FOnShowWindow(TProcessorBaseActivity.WINDOW_EQUIPMENT_DESC);
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
            if(FIsPlaying)
            {
               switch(this.FMovieType)
               {
                  case MOVIE_TYPE_OPEN_CARD:
                     CurFrame = this.FCardList[this.FCurIndex].MC_Card.currentFrame;
                     break;
                  case MOVIE_TYPE_OPEN_ALL_CARD:
                     CurFrame = FMC_Scene.MC_Movie2.currentFrame;
                     break;
                  case MOVIE_TYPE_RESET:
                     CurFrame = this.FCardList[0].MC_Card.currentFrame;
                     break;
                  case MOVIE_TYPE_CLEAR:
                     CurFrame = this.FCardList[this.FCurIndex].MC_Card.MC_ClearMovie.currentFrame;
                     break;
                  case MOVIE_TYPE_CLOSE_CARD:
                     CurFrame = this.FCardList[this.FLastIndex].MC_Card.currentFrame;
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
         this.FThanksgivingDay4 = SLogicsCore.ThanksgivingDayDatas.GetActivityByIdentify(ACTIVITY_4_ID) as TThanksgivingDay4;
         this.UpdateCard();
         this.UpdateBox();
         this.UpdateHero();
         this.UpdateExchange();
         this.UpdateText();
      }
      
      override public function SetMovieParam(param1:int = 0, param2:int = 0, param3:int = 0) : void
      {
         this.FCurIndex = param1;
         this.FCurType = param2;
         this.FLastIndex = param3;
         this.PlayMovie(MOVIE_TYPE_OPEN_CARD);
      }
      
      override public function PlayMovie(param1:int = 0, param2:Boolean = false) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:MovieClip = null;
         FIsPlaying = true;
         this.FMovieType = param1;
         switch(this.FMovieType)
         {
            case MOVIE_TYPE_OPEN_CARD:
               _loc5_ = this.FCardList[this.FCurIndex].MC_Card;
               _loc5_.gotoAndPlay(1);
               _loc5_.MC_Icon.visible = true;
               _loc5_.MC_Icon.gotoAndStop(this.FCurType);
               FTotalFrame = _loc5_.totalFrames;
               break;
            case MOVIE_TYPE_OPEN_ALL_CARD:
               _loc5_ = FMC_Scene.MC_Movie2;
               _loc5_.gotoAndPlay(1);
               _loc5_.visible = true;
               FTotalFrame = _loc5_.totalFrames;
               _loc3_ = 0;
               while(_loc3_ < this.FCardList.length)
               {
                  if(this.FThanksgivingDay4.CardList[_loc3_] == 0)
                  {
                     _loc5_ = this.FCardList[_loc3_].MC_Card;
                     _loc5_.gotoAndPlay(1);
                     _loc5_.MC_Icon.visible = true;
                     _loc5_.MC_Icon.gotoAndStop(this.FThanksgivingDay4.Card2List[_loc3_]);
                  }
                  _loc3_++;
               }
               break;
            case MOVIE_TYPE_RESET:
               FMC_Scene.MC_OnceMore.visible = false;
               _loc3_ = 0;
               while(_loc3_ < this.FCardList.length)
               {
                  this.FCardList[_loc3_].visible = true;
                  _loc5_ = this.FCardList[_loc3_].MC_Card;
                  _loc5_.gotoAndPlay(1);
                  _loc5_.MC_Icon.visible = false;
                  FTotalFrame = _loc5_.totalFrames;
                  _loc3_++;
               }
               break;
            case MOVIE_TYPE_CLEAR:
               _loc5_ = this.FCardList[this.FCurIndex].MC_Card.MC_ClearMovie;
               _loc5_.gotoAndPlay(1);
               _loc5_.visible = true;
               _loc5_ = this.FCardList[this.FLastIndex].MC_Card.MC_ClearMovie;
               _loc5_.gotoAndPlay(1);
               _loc5_.visible = true;
               FTotalFrame = _loc5_.totalFrames;
               break;
            case MOVIE_TYPE_CLOSE_CARD:
               _loc5_ = this.FCardList[this.FCurIndex].MC_Card;
               _loc5_.gotoAndPlay(1);
               _loc5_.MC_Icon.visible = false;
               _loc5_ = this.FCardList[this.FLastIndex].MC_Card;
               _loc5_.gotoAndPlay(1);
               _loc5_.MC_Icon.visible = false;
               FTotalFrame = _loc5_.totalFrames;
         }
      }
      
      override public function MovieEnd() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         switch(this.FMovieType)
         {
            case MOVIE_TYPE_OPEN_CARD:
               if(this.FLastIndex == -1)
               {
                  this.FThanksgivingDay4.CardList[this.FCurIndex] = this.FCurType;
                  _loc3_ = this.FCardList[this.FCurIndex].MC_Card.gotoAndStop(FTotalFrame);
                  this.UpdateUI();
               }
               else if(this.FCurType == this.FThanksgivingDay4.CardList[this.FLastIndex])
               {
                  this.PlayMovie(MOVIE_TYPE_CLEAR);
               }
               else
               {
                  this.PlayMovie(MOVIE_TYPE_CLOSE_CARD);
               }
               break;
            case MOVIE_TYPE_OPEN_ALL_CARD:
               _loc1_ = 0;
               while(_loc1_ < this.FThanksgivingDay4.CardList.length)
               {
                  this.FThanksgivingDay4.CardList[_loc1_] = -1;
                  _loc1_++;
               }
               this.UpdateUI();
               break;
            case MOVIE_TYPE_RESET:
               this.UpdateUI();
               break;
            case MOVIE_TYPE_CLEAR:
               this.FThanksgivingDay4.CardList[this.FCurIndex] = -1;
               this.FThanksgivingDay4.CardList[this.FLastIndex] = -1;
               FMC_Scene.MC_Effect.visible = true;
               FMC_Scene.MC_Effect.gotoAndPlay(1);
               this.UpdateUI();
               break;
            case MOVIE_TYPE_CLOSE_CARD:
               this.FThanksgivingDay4.CardList[this.FCurIndex] = 0;
               this.FThanksgivingDay4.CardList[this.FLastIndex] = 0;
               this.UpdateUI();
         }
      }
   }
}

