package Processors.Game.Lobby.Exercise.MayActive2015
{
   import Components.Pages.TUIPage;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.MayActive2015.TMayActive2_2015;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseBox;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import ghostcat.util.easing.Expo;
   import ghostcat.util.easing.TweenUtil;
   
   public class TUIMayActive2_2015 extends TUIBaseWindow
   {
      
      protected static const ACTIVITY_2_ID:int = 2;
      
      protected static const BOX_COUNT:int = 6;
      
      protected static const EXCHANGE_BOX_COUNT:int = 3;
      
      protected static const BALL_COUNT:int = 10;
      
      protected static const REWARD_COUNT:int = 8;
      
      protected static const SHOW_ITEM_COUNT:int = 10;
      
      protected static const ROTATION_COUNT:int = 2;
      
      protected static const RANDOM_COUNT:int = 2;
      
      public static const MOVIE_OF_PLAY_GAME:int = 1;
      
      public static const MOVIE_OF_AUTO_GAME:int = 2;
      
      public static const MOVIE_OF_FLOW:int = 3;
      
      protected var FMayActive2_2015:TMayActive2_2015;
      
      protected var FMovieType:int;
      
      protected var FFrameCount:int;
      
      protected var FBoxList:Vector.<MovieClip>;
      
      protected var FExchangeList:Vector.<TUIBaseBox>;
      
      protected var FUIPage:TUIPage;
      
      protected var FTotalPage:int;
      
      protected var FCurPage:int;
      
      protected var FRewardIndex:int;
      
      public function TUIMayActive2_2015(param1:TUIComponent)
      {
         super(param1);
         this.FBoxList = new Vector.<MovieClip>(BOX_COUNT);
         this.FExchangeList = new Vector.<TUIBaseBox>(EXCHANGE_BOX_COUNT);
         this.FUIPage = new TUIPage(this);
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
         FMC_Scene.MC_Movie0.visible = false;
         FMC_Scene.MC_AutoLog.visible = false;
         FMC_Scene.MC_AutoLog.Btn_Close.addEventListener(MouseEvent.CLICK,this.ProcessorOnCloseLogUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Play,true);
         FMC_Scene.BTN_Play.addEventListener(MouseEvent.CLICK,this.ProcessorOnStartUp);
         FMC_Scene.BTN_Play.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnStartOver);
         FMC_Scene.BTN_Play.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Auto,true);
         FMC_Scene.BTN_Auto.addEventListener(MouseEvent.CLICK,this.ProcessorOnAutoUp);
         FMC_Scene.BTN_Auto.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnAutoOver);
         FMC_Scene.BTN_Auto.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Get,true);
         FMC_Scene.BTN_Get.addEventListener(MouseEvent.CLICK,this.ProcessorOnGetGiftUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Next,true);
         FMC_Scene.BTN_Next.addEventListener(MouseEvent.CLICK,this.ProcessorOnNextUp);
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
         this.FUIPage.PageSize = EXCHANGE_BOX_COUNT;
         this.FUIPage.PageIndex = 0;
         this.FCurPage = 0;
         this.FUIPage.OnChangePage = this.ProcessorPageOnChange;
      }
      
      protected function UpdateBox() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:TBaseBox = null;
         var _loc6_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < BOX_COUNT)
         {
            _loc4_ = this.FBoxList[_loc1_];
            _loc2_ = _loc1_;
            if(_loc2_ < this.FMayActive2_2015.BoxList.length)
            {
               _loc4_.visible = true;
               _loc5_ = this.FMayActive2_2015.BoxList[_loc2_];
               _loc4_.TF_Price.text = TUtilityString.Format(this.FMayActive2_2015.DescListNew[2],_loc5_.Price);
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
         _loc1_ = this.FMayActive2_2015.Hero;
         FMC_Scene.TF_Price.text = _loc1_.Price.toString();
         if(_loc1_.Status == TBaseActivity.STATUS_GETED)
         {
            FMC_Scene.MC_Got.visible = true;
            FMC_Scene.BTN_Exchange.visible = false;
         }
         else if(this.FMayActive2_2015.MyScore >= _loc1_.Price)
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
         this.FUIPage.TotalQuantity = this.FMayActive2_2015.ExchangeItems.length;
         this.FUIPage.Update();
         _loc1_ = 0;
         while(_loc1_ < EXCHANGE_BOX_COUNT)
         {
            _loc3_ = _loc1_ + this.FCurPage * EXCHANGE_BOX_COUNT;
            if(_loc3_ < this.FMayActive2_2015.ExchangeItems.length)
            {
               this.FExchangeList[_loc1_].SetVisible(true);
               _loc5_ = this.FMayActive2_2015.ExchangeItems[_loc3_];
               this.FExchangeList[_loc1_].UpdateUI(_loc5_.Inventories);
               this.FExchangeList[_loc1_].Identify = _loc3_;
               _loc4_ = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_LIMIT_COUNT,_loc5_.LimitCount.toString());
               this.FExchangeList[_loc1_].SetLimitText(_loc4_);
               _loc4_ = _loc5_.Price.toString();
               this.FExchangeList[_loc1_].SetPriceText(_loc4_);
               if(_loc5_.IsHot == 0)
               {
                  if(this.FMayActive2_2015.MyScore < _loc5_.Price || _loc5_.LimitCount <= 0)
                  {
                     this.FExchangeList[_loc1_].SetExchangeBtnMode(false);
                  }
                  else
                  {
                     this.FExchangeList[_loc1_].SetExchangeBtnMode(true);
                  }
                  this.FExchangeList[_loc1_].MC_Tag.visible = false;
               }
               else
               {
                  if(this.FMayActive2_2015.MyScore < _loc5_.Price || _loc5_.LimitCount <= 0)
                  {
                     this.FExchangeList[_loc1_].SetExchangeBtnMode(false);
                  }
                  else
                  {
                     this.FExchangeList[_loc1_].SetExchangeBtnMode(true);
                  }
                  if(this.FMayActive2_2015.Hero.Status == TBaseActivity.STATUS_GETED)
                  {
                     this.FExchangeList[_loc1_].MC_Tag.visible = false;
                  }
                  else
                  {
                     this.FExchangeList[_loc1_].MC_Tag.visible = true;
                  }
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
      
      protected function UpdateText() : void
      {
         FMC_Scene.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FMayActive2_2015.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FMayActive2_2015.EndTime) - 1) * 1000)));
         FMC_Scene.TF_Desc.text = this.FMayActive2_2015.DescListNew[1];
         FMC_Scene.MC_Free.TF_Count.text = this.FMayActive2_2015.FreeCount.toString();
         FMC_Scene.MC_Score.TF_Count.text = this.FMayActive2_2015.MyScore.toString();
         FMC_Scene.TF_RechargeGold.text = TUtilityString.Format(this.FMayActive2_2015.DescListNew[3],this.FMayActive2_2015.RechargeGold);
         FMC_Scene.TF_GameValue.text = this.FMayActive2_2015.GameValue.toString();
      }
      
      protected function UpdateGame() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < BALL_COUNT)
         {
            FMC_Scene.MC_Game["MC_Icon" + _loc1_].TF_Num.text = this.FMayActive2_2015.BallList[_loc1_].toString();
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < REWARD_COUNT)
         {
            FMC_Scene["MC_Icon" + _loc1_].TF_Num.text = this.FMayActive2_2015.DescListNew[10 + _loc1_];
            FMC_Scene["MC_Icon" + _loc1_].TF_Count.text = this.FMayActive2_2015.GameReward[_loc1_].Count.toString();
            if(_loc1_ == this.FMayActive2_2015.RewardIndex - 1)
            {
               FMC_Scene["MC_Icon" + _loc1_].MC_Select.visible = true;
            }
            else
            {
               FMC_Scene["MC_Icon" + _loc1_].MC_Select.visible = false;
            }
            _loc1_++;
         }
         if(this.FMayActive2_2015.GameStatus == TBaseActivity.STATUS_CANNOTGET)
         {
            FMC_Scene.BTN_Play.visible = true;
            FMC_Scene.BTN_Auto.visible = true;
            FMC_Scene.BTN_Get.visible = false;
            FMC_Scene.BTN_Next.visible = false;
         }
         else
         {
            FMC_Scene.BTN_Play.visible = false;
            FMC_Scene.BTN_Auto.visible = false;
            FMC_Scene.BTN_Get.visible = true;
            FMC_Scene.BTN_Next.visible = true;
         }
      }
      
      protected function UpdateLog() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         var _loc3_:int = 0;
         var _loc4_:Object = null;
         FMC_Scene.MC_AutoLog.visible = true;
         FMC_Scene.MC_AutoLog.TF_Count.text = this.FRewardIndex.toString();
         _loc1_ = 0;
         while(_loc1_ < BALL_COUNT)
         {
            _loc2_ = FMC_Scene.MC_AutoLog["MC_Log" + _loc1_];
            _loc4_ = this.FMayActive2_2015.AutoLog[_loc1_];
            _loc3_ = _loc1_ + 1;
            _loc2_.TF_Num.text = _loc3_.toString();
            _loc2_.TF_Count.text = _loc4_.Score.toString();
            _loc2_.TF_Desc.text = TUtilityString.Format(this.FMayActive2_2015.DescListNew[9],_loc4_.Reward);
            _loc1_++;
         }
      }
      
      protected function ProcessorPageOnChange(param1:Object, param2:int) : void
      {
         this.FCurPage = param2;
         this.UpdateExchange();
      }
      
      protected function ProcessorOnStartUp(param1:MouseEvent) : void
      {
         if(FOnBuyBox != null && !FIsPlaying && Boolean(this.FMayActive2_2015))
         {
            if(this.FMayActive2_2015.FreeCount > 0)
            {
               FOnGetBox(ACTIVITY_2_ID,TProcessorMayActive_2015.ACTIVITY_2_PLAY_GAME);
            }
            else
            {
               FOnBuyBox(ACTIVITY_2_ID,TProcessorMayActive_2015.ACTIVITY_2_PLAY_GAME,this.FMayActive2_2015.ScorePrice);
            }
         }
      }
      
      protected function ProcessorOnAutoUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:int = 0;
         if(FOnBuyBox != null && !FIsPlaying && Boolean(this.FMayActive2_2015))
         {
            _loc2_ = this.FMayActive2_2015.AutoPrice;
            _loc3_ = TUtilityString.Format(this.FMayActive2_2015.DescListNew[4],_loc2_);
            FOnBuyBox(ACTIVITY_2_ID,TProcessorMayActive_2015.ACTIVITY_2_AUTO_GAME,_loc2_,0,0,_loc3_);
         }
      }
      
      protected function ProcessorOnNextUp(param1:MouseEvent) : void
      {
         if(FOnBuyBox != null && !FIsPlaying && Boolean(this.FMayActive2_2015))
         {
            if(this.FMayActive2_2015.FreeCount > 0)
            {
               FOnGetBox(ACTIVITY_2_ID,TProcessorMayActive_2015.ACTIVITY_2_PLAY_GAME);
            }
            else
            {
               FOnBuyBox(ACTIVITY_2_ID,TProcessorMayActive_2015.ACTIVITY_2_PLAY_GAME,this.FMayActive2_2015.ScorePrice);
            }
         }
      }
      
      protected function ProcessorOnGetGiftUp(param1:MouseEvent) : void
      {
         if(FOnGetBox != null && !FIsPlaying && Boolean(this.FMayActive2_2015))
         {
            FOnGetBox(ACTIVITY_2_ID,TProcessorMayActive_2015.ACTIVITY_2_GET_SCORE);
         }
      }
      
      override protected function ProcessorOnGetBoxUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(6));
         if(!FIsPlaying && FOnGetBox != null && Boolean(this.FMayActive2_2015))
         {
            _loc3_ = _loc2_;
            if(this.FMayActive2_2015.BoxList[_loc3_].Status == TBaseActivity.STATUS_CANGET)
            {
               FOnGetBox(ACTIVITY_2_ID,TProcessorMayActive_2015.ACTIVITY_2_GET_GIFT,_loc3_ + 1);
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
         if(!FIsPlaying && FOnGetBox != null && Boolean(this.FMayActive2_2015))
         {
            _loc2_ = this.FMayActive2_2015.Hero;
            if(_loc2_.Status != TBaseActivity.STATUS_GETED && this.FMayActive2_2015.MyScore >= _loc2_.Price)
            {
               FOnGetBox(ACTIVITY_2_ID,TProcessorMayActive_2015.ACTIVITY_2_EXCHANGE_HERO);
            }
         }
      }
      
      protected function ProcessorOnExchangeUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         _loc3_ = _loc2_ + this.FCurPage * EXCHANGE_BOX_COUNT;
         if(Boolean(!FIsPlaying && FOnGetBox != null && this.FMayActive2_2015 && _loc3_ < this.FMayActive2_2015.ExchangeItems.length) && Boolean(this.FMayActive2_2015.ExchangeItems[_loc3_].LimitCount > 0) && this.FMayActive2_2015.MyScore >= this.FMayActive2_2015.ExchangeItems[_loc3_].Price)
         {
            FOnGetBox(ACTIVITY_2_ID,TProcessorMayActive_2015.ACTIVITY_2_EXCHANGE_ITEM,_loc3_ + 1);
         }
      }
      
      protected function ProcessorOnCloseLogUp(param1:MouseEvent) : void
      {
         FMC_Scene.MC_AutoLog.visible = false;
      }
      
      protected function ProcessorOnHeroDescUp(param1:MouseEvent) : void
      {
         var _loc2_:TBaseBox = null;
         if(Boolean(FOnShowRecruit != null) && Boolean(this.FMayActive2_2015) && Boolean(this.FMayActive2_2015.Hero))
         {
            _loc2_ = this.FMayActive2_2015.Hero;
            FOnShowRecruit(_loc2_.Identify,_loc2_.Type);
         }
      }
      
      protected function ProcessorOnAutoOver(param1:MouseEvent) : void
      {
         if(FOnShowHtmlTip != null && Boolean(this.FMayActive2_2015))
         {
            FOnShowHtmlTip(this.FMayActive2_2015.DescListNew[5]);
         }
      }
      
      protected function ProcessorOnStartOver(param1:MouseEvent) : void
      {
         if(FOnShowHtmlTip != null && Boolean(this.FMayActive2_2015))
         {
            FOnShowHtmlTip(this.FMayActive2_2015.DescListNew[6]);
         }
      }
      
      protected function ProcessorOnHeroOver(param1:MouseEvent) : void
      {
         if(FOnShowHtmlTip != null && Boolean(this.FMayActive2_2015))
         {
            FOnShowHtmlTip(this.FMayActive2_2015.DescListNew[7]);
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
                  case MOVIE_OF_FLOW:
                     CurFrame = FMC_Scene.MC_Movie0.currentFrame;
                     break;
                  case MOVIE_OF_PLAY_GAME:
                     return;
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
         this.FMayActive2_2015 = SLogicsCore.MayActiveDatas2015.GetActivityByIdentify(ACTIVITY_2_ID) as TMayActive2_2015;
         this.UpdateBox();
         this.UpdateExchange();
         this.UpdateHero();
         this.UpdateText();
         this.UpdateGame();
      }
      
      public function PlayGameMovie() : void
      {
      }
      
      override public function PlayMovie(param1:int = 0, param2:Boolean = false) : void
      {
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:int = 0;
         FIsPlaying = true;
         this.FMovieType = param1;
         if(this.FMovieType == MOVIE_OF_PLAY_GAME)
         {
            TweenUtil.removeAllTween();
            FMC_Scene.MC_Game.MC_Hand.rotation = 0;
            _loc5_ = 360 / SHOW_ITEM_COUNT * this.FRewardIndex + (ROTATION_COUNT + int(Math.random() * RANDOM_COUNT)) * 360;
            TweenUtil.to(FMC_Scene.MC_Game.MC_Hand,3000,{
               "rotation":_loc5_,
               "ease":Expo.easeOut,
               "onComplete":this.MovieEnd
            });
         }
         else if(this.FMovieType == MOVIE_OF_AUTO_GAME)
         {
            FIsPlaying = false;
            this.UpdateLog();
            this.UpdateUI();
         }
         else if(this.FMovieType == MOVIE_OF_FLOW)
         {
            _loc4_ = FMC_Scene.MC_Movie0;
            _loc4_.visible = true;
            FTotalFrame = _loc4_.totalFrames;
            _loc4_.gotoAndPlay(1);
         }
      }
      
      override public function MovieEnd() : void
      {
         var _loc1_:int = 0;
         var _loc2_:String = null;
         FIsPlaying = false;
         if(this.FMovieType == MOVIE_OF_PLAY_GAME)
         {
            FOnShowFlowText(FFlowStr);
            this.UpdateUI();
         }
         else if(this.FMovieType == MOVIE_OF_FLOW)
         {
            FMC_Scene.MC_Movie0.visible = false;
            this.UpdateUI();
         }
      }
      
      override public function Unmount() : void
      {
         var _loc1_:int = 0;
         TweenUtil.removeAllTween();
      }
      
      override public function SetMovieParam(param1:int = 0, param2:int = 0, param3:int = 0) : void
      {
         this.FRewardIndex = param1;
      }
   }
}

