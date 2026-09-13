package Processors.Game.Lobby.Exercise.MarchActive
{
   import Components.Pages.TUIPage;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.MarchActive.TMarchActive2;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Lottery.TLotteryNews;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseBox;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import ghostcat.util.easing.TweenUtil;
   
   public class TUIMarchActive2 extends TUIBaseWindow
   {
      
      protected static const BOX_COUNT:int = 5;
      
      protected static const EXCHANGE_BOX_COUNT:int = 6;
      
      protected static const LOG_COUNT:int = 5;
      
      protected static const HOLE_COUNT:int = 6;
      
      protected static const ACTIVITY_2_ID:int = 2;
      
      public static const MOVIE_OF_PLAY_GAME:int = 1;
      
      public static const MOVIE_OF_INTO_HOLE:int = 2;
      
      public static const MOVIE_OF_HOLE_SHINE:int = 3;
      
      public static const MOVIE_OF_AUTO:int = 4;
      
      public static const MOVIE_OF_AUTO_INTO_HOLE:int = 5;
      
      protected var FMarchActive2:TMarchActive2;
      
      protected var FMovieType:int;
      
      protected var FFrameCount:int;
      
      protected var FBoxList:Vector.<MovieClip>;
      
      protected var FExchangeList:Vector.<TUIBaseBox>;
      
      protected var FUIPage:TUIPage;
      
      protected var FTotalPage:int;
      
      protected var FCurPage:int;
      
      protected var FUIPage1:TUIPage;
      
      protected var FTotalPage1:int;
      
      protected var FCurPage1:int;
      
      protected var FHoleIndex:int;
      
      public function TUIMarchActive2(param1:TUIComponent)
      {
         super(param1);
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
         var _loc5_:MovieClip = null;
         super.Resources_UIDispatch(param1);
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
         _loc2_ = 0;
         while(_loc2_ < HOLE_COUNT)
         {
            FMC_Scene["MC_Hole" + _loc2_].MC_Icon.gotoAndStop(_loc2_ + 1);
            _loc2_++;
         }
         FMC_Scene.MC_AutoMovie.visible = false;
         FMC_Scene.MC_Movie0.visible = false;
         FMC_Scene.MC_Ball0.visible = false;
         FMC_Scene.MC_Ball1.visible = false;
         FMC_Scene.MC_Ball2.visible = false;
         FMC_Scene.MC_Ball3.visible = false;
         FMC_Scene.MC_Ball4.visible = false;
         FMC_Scene.MC_Ball5.visible = false;
         TGameUtil.setButtonMode(FMC_Scene.BTN_Start,true);
         FMC_Scene.BTN_Start.addEventListener(MouseEvent.CLICK,this.ProcessorOnStartUp);
         FMC_Scene.BTN_Start.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnStartOver);
         FMC_Scene.BTN_Start.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Auto,true);
         FMC_Scene.BTN_Auto.addEventListener(MouseEvent.CLICK,this.ProcessorOnAutoUp);
         FMC_Scene.BTN_Auto.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnAutoOver);
         FMC_Scene.BTN_Auto.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Log,true);
         FMC_Scene.BTN_Log.addEventListener(MouseEvent.CLICK,this.ProcessorOnLoadLog);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Desc,true);
         FMC_Scene.BTN_Desc.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowDesc);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Exchange,true);
         FMC_Scene.BTN_Exchange.addEventListener(MouseEvent.CLICK,this.ProcessorOnExchangeHeroUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_HeroDesc,true);
         FMC_Scene.BTN_HeroDesc.addEventListener(MouseEvent.CLICK,this.ProcessorOnHeroDescUp);
         FMC_Scene.MC_Hero.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnHeroOver);
         FMC_Scene.MC_Hero.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
         this.FUIPage.ButtonPrevious.Substrate = FMC_Scene.BTN_Left;
         this.FUIPage.ButtonNext.Substrate = FMC_Scene.BTN_Right;
         this.FUIPage.TotalQuantity = this.FTotalPage;
         this.FUIPage.PageSize = BOX_COUNT;
         this.FUIPage.PageIndex = 0;
         this.FCurPage = 0;
         this.FUIPage.OnChangePage = this.ProcessorPageOnChange;
         this.FUIPage1.ButtonPrevious.Substrate = FMC_Scene.BTN_Left1;
         this.FUIPage1.ButtonNext.Substrate = FMC_Scene.BTN_Right1;
         this.FUIPage1.TotalQuantity = this.FTotalPage1;
         this.FUIPage1.PageSize = EXCHANGE_BOX_COUNT;
         this.FUIPage1.PageIndex = 0;
         this.FCurPage1 = 0;
         this.FUIPage1.OnChangePage = this.ProcessorPageOnChange1;
      }
      
      protected function UpdateBox() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:TBaseBox = null;
         var _loc6_:int = 0;
         this.FUIPage.TotalQuantity = this.FMarchActive2.BoxList.length;
         this.FUIPage.Update();
         _loc1_ = 0;
         while(_loc1_ < BOX_COUNT)
         {
            _loc4_ = this.FBoxList[_loc1_];
            _loc2_ = _loc1_ + this.FCurPage * BOX_COUNT;
            if(_loc2_ < this.FMarchActive2.BoxList.length)
            {
               _loc4_.visible = true;
               _loc4_.MC_BoxPic.gotoAndStop(_loc2_ + 1);
               _loc5_ = this.FMarchActive2.BoxList[_loc2_];
               _loc4_.TF_Price.text = TUtilityString.Format(this.FMarchActive2.DescListNew[5],_loc5_.Price);
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
         var _loc1_:TBaseBox = null;
         _loc1_ = this.FMarchActive2.Hero;
         FMC_Scene.TF_Price.text = _loc1_.Price.toString();
         if(_loc1_.Status == TBaseActivity.STATUS_GETED)
         {
            FMC_Scene.MC_Got.visible = true;
            FMC_Scene.BTN_Exchange.visible = false;
         }
         else if(this.FMarchActive2.MyScore >= _loc1_.Price)
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
      }
      
      protected function UpdateExchange() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:TBaseBox = null;
         this.FUIPage1.TotalQuantity = this.FMarchActive2.ExchangeItems.length;
         this.FUIPage1.Update();
         _loc1_ = 0;
         while(_loc1_ < EXCHANGE_BOX_COUNT)
         {
            _loc3_ = _loc1_ + this.FCurPage1 * EXCHANGE_BOX_COUNT;
            if(_loc3_ < this.FMarchActive2.ExchangeItems.length)
            {
               this.FExchangeList[_loc1_].SetVisible(true);
               _loc5_ = this.FMarchActive2.ExchangeItems[_loc3_];
               this.FExchangeList[_loc1_].UpdateUI(_loc5_.Inventories);
               this.FExchangeList[_loc1_].Identify = _loc3_;
               _loc4_ = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_LIMIT_COUNT,_loc5_.LimitCount.toString());
               this.FExchangeList[_loc1_].SetLimitText(_loc4_);
               _loc4_ = _loc5_.Price.toString();
               this.FExchangeList[_loc1_].SetPriceText(_loc4_);
               if(this.FMarchActive2.MyScore < _loc5_.Price || _loc5_.LimitCount <= 0)
               {
                  this.FExchangeList[_loc1_].SetExchangeBtnMode(false);
               }
               else
               {
                  this.FExchangeList[_loc1_].SetExchangeBtnMode(true);
               }
               if(_loc5_.LimitCount == 0)
               {
                  this.FExchangeList[_loc1_].SetMCIsVisible("MC_Got",true);
                  this.FExchangeList[_loc1_].SetMCIsVisible("BTN_Exchange",false);
               }
               else
               {
                  this.FExchangeList[_loc1_].SetMCIsVisible("MC_Got",false);
                  this.FExchangeList[_loc1_].SetMCIsVisible("BTN_Exchange",true);
               }
            }
            else
            {
               this.FExchangeList[_loc1_].SetVisible(false);
            }
            _loc1_++;
         }
      }
      
      protected function UpdateLog() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TLotteryNews = null;
         _loc1_ = 0;
         while(_loc1_ < LOG_COUNT)
         {
            if(_loc1_ < this.FMarchActive2.NewsList.length)
            {
               _loc2_ = this.FMarchActive2.NewsList[_loc1_];
               FMC_Scene["TF_Log" + _loc1_].text = TUtilityString.Format(this.FMarchActive2.DescListNew[6],_loc2_.PlayerNick,_loc2_.Count);
            }
            else
            {
               FMC_Scene["TF_Log" + _loc1_].text = "";
            }
            _loc1_++;
         }
      }
      
      protected function UpdateText() : void
      {
         FMC_Scene.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FMarchActive2.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FMarchActive2.EndTime) - 1) * 1000)));
         FMC_Scene.TF_Desc.text = this.FMarchActive2.DescListNew[1];
         FMC_Scene.TF_FreeCount.text = this.FMarchActive2.FreeCount.toString();
         FMC_Scene.TF_Score.text = this.FMarchActive2.MyScore.toString();
         FMC_Scene.TF_RechargeGold.text = TUtilityString.Format(this.FMarchActive2.DescListNew[4],this.FMarchActive2.RechargeGold);
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
      
      protected function ProcessorOnStartUp(param1:MouseEvent) : void
      {
         if(FOnBuyBox != null && !FIsPlaying && Boolean(this.FMarchActive2))
         {
            if(this.FMarchActive2.FreeCount > 0)
            {
               FOnGetBox(ACTIVITY_2_ID,TProcessorMarchActive.ACTIVITY_2_PLAY_GAME);
            }
            else
            {
               FOnBuyBox(ACTIVITY_2_ID,TProcessorMarchActive.ACTIVITY_2_PLAY_GAME,this.FMarchActive2.ScorePrice);
            }
         }
      }
      
      protected function ProcessorOnAutoUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:int = 0;
         if(FOnBuyBox != null && !FIsPlaying && Boolean(this.FMarchActive2))
         {
            _loc4_ = this.FMarchActive2.AutoPrice;
            if(this.FMarchActive2.FreeCount >= _loc4_)
            {
               FOnGetBox(ACTIVITY_2_ID,TProcessorMarchActive.ACTIVITY_2_AUTO_GAME);
            }
            else
            {
               _loc2_ = (_loc4_ - this.FMarchActive2.FreeCount) * this.FMarchActive2.ScorePrice;
               _loc3_ = TUtilityString.Format(this.FMarchActive2.DescListNew[3],_loc4_,_loc2_,_loc4_ - this.FMarchActive2.FreeCount);
               FOnBuyBox(ACTIVITY_2_ID,TProcessorMarchActive.ACTIVITY_2_AUTO_GAME,_loc2_,0,0,_loc3_);
            }
         }
      }
      
      override protected function ProcessorOnGetBoxUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(6));
         if(!FIsPlaying && FOnGetBox != null && Boolean(this.FMarchActive2))
         {
            _loc3_ = _loc2_ + this.FCurPage * BOX_COUNT;
            if(this.FMarchActive2.BoxList[_loc3_].Status == TBaseActivity.STATUS_CANGET)
            {
               FOnGetBox(ACTIVITY_2_ID,TProcessorMarchActive.ACTIVITY_2_GET_GIFT,_loc3_ + 1);
            }
         }
      }
      
      protected function ProcessorOnExchangeHeroUp(param1:MouseEvent) : void
      {
         var _loc2_:TBaseBox = null;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(!FIsPlaying && FOnGetBox != null && Boolean(this.FMarchActive2))
         {
            _loc2_ = this.FMarchActive2.Hero;
            if(_loc2_.Status != TBaseActivity.STATUS_GETED && this.FMarchActive2.MyScore >= _loc2_.Price)
            {
               FOnGetBox(ACTIVITY_2_ID,TProcessorMarchActive.ACTIVITY_2_EXCHANGE_HERO);
            }
         }
      }
      
      protected function ProcessorOnExchangeUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         _loc3_ = _loc2_ + this.FCurPage1 * EXCHANGE_BOX_COUNT;
         if(Boolean(!FIsPlaying && FOnGetBox != null && this.FMarchActive2 && _loc3_ < this.FMarchActive2.ExchangeItems.length) && Boolean(this.FMarchActive2.ExchangeItems[_loc3_].LimitCount > 0) && this.FMarchActive2.MyScore >= this.FMarchActive2.ExchangeItems[_loc3_].Price)
         {
            FOnGetBox(ACTIVITY_2_ID,TProcessorMarchActive.ACTIVITY_2_EXCHANGE_ITEM,_loc3_ + 1);
         }
      }
      
      protected function ProcessorOnHeroDescUp(param1:MouseEvent) : void
      {
         var _loc2_:TBaseBox = null;
         if(Boolean(FOnShowRecruit != null) && Boolean(this.FMarchActive2) && Boolean(this.FMarchActive2.Hero))
         {
            _loc2_ = this.FMarchActive2.Hero;
            FOnShowRecruit(_loc2_.Identify,_loc2_.Type);
         }
      }
      
      protected function ProcessorOnAutoOver(param1:MouseEvent) : void
      {
         if(FOnShowHtmlTip != null && Boolean(this.FMarchActive2))
         {
            FOnShowHtmlTip(this.FMarchActive2.DescListNew[9]);
         }
      }
      
      protected function ProcessorOnStartOver(param1:MouseEvent) : void
      {
         if(Boolean(FOnShowHtmlTip != null) && Boolean(this.FMarchActive2) && this.FMarchActive2.DescList.length > 10)
         {
            FOnShowHtmlTip(this.FMarchActive2.DescListNew[10]);
         }
      }
      
      protected function ProcessorOnHeroOver(param1:MouseEvent) : void
      {
         if(FOnShowHtmlTip != null && Boolean(this.FMarchActive2))
         {
            FOnShowHtmlTip(this.FMarchActive2.DescListNew[2]);
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
            FOnLoadLog(ACTIVITY_2_ID);
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
         if(FInitialized && this.visible && FMC_Scene.visible)
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
                  case MOVIE_OF_PLAY_GAME:
                     CurFrame = FMC_Scene.MC_Movie0.currentFrame;
                     break;
                  case MOVIE_OF_INTO_HOLE:
                     CurFrame = FMC_Scene["MC_Ball" + this.FHoleIndex].currentFrame;
                     break;
                  case MOVIE_OF_HOLE_SHINE:
                     CurFrame = FMC_Scene["MC_Hole" + this.FHoleIndex].currentFrame;
                     break;
                  case MOVIE_OF_AUTO:
                     CurFrame = FMC_Scene.MC_AutoMovie.currentFrame;
                     break;
                  case MOVIE_OF_AUTO_INTO_HOLE:
                     CurFrame = FMC_Scene["MC_Hole" + this.FHoleIndex].currentFrame;
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
         this.FMarchActive2 = SLogicsCore.MarchActiveDatas.GetActivityByIdentify(ACTIVITY_2_ID) as TMarchActive2;
         this.UpdateBox();
         this.UpdateExchange();
         this.UpdateHero();
         this.UpdateLog();
         this.UpdateText();
      }
      
      override public function PlayMovie(param1:int = 0, param2:Boolean = false) : void
      {
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         FIsPlaying = true;
         this.FMovieType = param1;
         if(this.FMovieType == MOVIE_OF_PLAY_GAME)
         {
            _loc4_ = FMC_Scene.MC_Movie0;
            _loc4_.visible = true;
            FTotalFrame = _loc4_.totalFrames;
            _loc4_.gotoAndPlay(1);
         }
         else if(this.FMovieType == MOVIE_OF_INTO_HOLE)
         {
            _loc4_ = FMC_Scene["MC_Ball" + this.FHoleIndex];
            _loc4_.visible = true;
            FTotalFrame = _loc4_.totalFrames;
            _loc4_.gotoAndPlay(1);
         }
         else if(this.FMovieType == MOVIE_OF_HOLE_SHINE)
         {
            _loc4_ = FMC_Scene["MC_Hole" + this.FHoleIndex];
            _loc4_.visible = true;
            FTotalFrame = _loc4_.totalFrames;
            _loc4_.gotoAndPlay(1);
         }
         else if(this.FMovieType == MOVIE_OF_AUTO)
         {
            _loc4_ = FMC_Scene.MC_AutoMovie;
            _loc4_.visible = true;
            FTotalFrame = _loc4_.totalFrames;
            _loc4_.gotoAndPlay(1);
         }
         else if(this.FMovieType == MOVIE_OF_AUTO_INTO_HOLE)
         {
            _loc3_ = 0;
            while(_loc3_ < HOLE_COUNT)
            {
               this.FHoleIndex = this.FMarchActive2.HoleList[_loc3_];
               _loc4_ = FMC_Scene["MC_Hole" + this.FHoleIndex];
               _loc4_.visible = true;
               FTotalFrame = _loc4_.totalFrames;
               _loc4_.gotoAndPlay(1);
               _loc3_++;
            }
         }
      }
      
      override public function MovieEnd() : void
      {
         var _loc1_:int = 0;
         var _loc2_:String = null;
         FIsPlaying = false;
         if(this.FMovieType == MOVIE_OF_PLAY_GAME)
         {
            FMC_Scene.MC_Movie0.visible = false;
            this.PlayMovie(MOVIE_OF_INTO_HOLE);
         }
         else if(this.FMovieType == MOVIE_OF_INTO_HOLE)
         {
            FMC_Scene["MC_Ball" + this.FHoleIndex].visible = false;
            this.PlayMovie(MOVIE_OF_HOLE_SHINE);
         }
         else if(this.FMovieType == MOVIE_OF_HOLE_SHINE)
         {
            FMC_Scene["MC_Hole" + this.FHoleIndex].gotoAndStop(1);
            this.UpdateUI();
            FOnShowFlowText(FFlowStr);
         }
         else if(this.FMovieType == MOVIE_OF_AUTO)
         {
            FMC_Scene.MC_AutoMovie.visible = false;
            this.PlayMovie(MOVIE_OF_AUTO_INTO_HOLE);
         }
         else if(this.FMovieType == MOVIE_OF_AUTO_INTO_HOLE)
         {
            _loc1_ = 0;
            while(_loc1_ < HOLE_COUNT)
            {
               FMC_Scene["MC_Hole" + _loc1_].gotoAndStop(1);
               _loc1_++;
            }
            this.UpdateUI();
            FOnShowFlowText(FFlowStr);
         }
      }
      
      override public function Unmount() : void
      {
         var _loc1_:int = 0;
         TweenUtil.removeAllTween();
      }
      
      override public function SetMovieParam(param1:int = 0, param2:int = 0, param3:int = 0) : void
      {
         this.FHoleIndex = param1;
      }
   }
}

