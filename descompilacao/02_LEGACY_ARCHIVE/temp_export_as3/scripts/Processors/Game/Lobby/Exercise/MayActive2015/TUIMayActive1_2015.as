package Processors.Game.Lobby.Exercise.MayActive2015
{
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.DessertHouse.TDessertHouseTask;
   import Logics.Exercise.MayActive2015.TMayActive1_2015;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIShowItem;
   import Processors.Game.Lobby.Exercise.FebActive.TProcessorFebActiveShop;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import ghostcat.util.easing.TweenUtil;
   
   public class TUIMayActive1_2015 extends TUIBaseWindow
   {
      
      protected static const SHOW_ITEM_COUNT:int = 4;
      
      protected static const SHOW_LOG_COUNT:int = 4;
      
      protected static const CARD_COUNT:int = 12;
      
      protected static const ACTIVITY_1_ID:int = 1;
      
      public static const MOVIE_OF_OPEN_CARD:int = 1;
      
      public static const MOVIE_OF_AUTO_GAME:int = 2;
      
      public static const MOVIE_OF_FLOW:int = 3;
      
      protected var FMayActive1_2015:TMayActive1_2015;
      
      protected var FMovieType:int;
      
      protected var FFrameCount:int;
      
      protected var FCardList:Vector.<MovieClip>;
      
      protected var FCardBackList:Vector.<MovieClip>;
      
      protected var FShowItem:TUIShowItem;
      
      protected var FProcessorFebActiveShop:TProcessorFebActiveShop;
      
      protected var FOpenIndex:int;
      
      public function TUIMayActive1_2015(param1:TUIComponent)
      {
         super(param1);
         this.FCardList = new Vector.<MovieClip>(CARD_COUNT);
         this.FCardBackList = new Vector.<MovieClip>(CARD_COUNT);
      }
      
      override protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TUIShowItem = null;
         var _loc5_:MovieClip = null;
         var _loc6_:MovieClip = null;
         super.Resources_UIDispatch(param1);
         _loc2_ = 0;
         while(_loc2_ < CARD_COUNT)
         {
            _loc5_ = FMC_Scene.MC_CardBack["MC_Card" + _loc2_];
            _loc5_.buttonMode = true;
            _loc5_.addEventListener(MouseEvent.CLICK,this.ProcessorOnCardUp);
            this.FCardBackList[_loc2_] = _loc5_;
            _loc5_ = FMC_Scene.MC_Card["MC_Card" + _loc2_];
            this.FCardList[_loc2_] = _loc5_;
            _loc2_++;
         }
         this.FShowItem = new TUIShowItem(this,SHOW_ITEM_COUNT);
         this.FShowItem.Perform_UIDispatch(FMC_Scene.MC_ShowItems);
         this.FShowItem.OnOverlay = this.ProcessorOnItemOver;
         this.FShowItem.OnOut = this.ProcessorOnItemOut;
         this.FShowItem.OnShowRecruit = this.ProcessorOnShowRecruit;
         FMC_Scene.MC_Gift.buttonMode = true;
         FMC_Scene.MC_Gift.MC_Box.addEventListener(MouseEvent.CLICK,this.ProcessorOnGiftUp);
         FMC_Scene.MC_Gift.MC_Box.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnGiftOver);
         FMC_Scene.MC_Gift.MC_Box.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnNewBoxOut);
         FMC_Scene.MC_FloatEffect.mouseEnabled = false;
         FMC_Scene.MC_Movie0.visible = false;
         FMC_Scene.MC_Movie1.visible = false;
         FMC_Scene.MC_Click.visible = false;
         FMC_Scene.MC_Click.mouseEnabled = false;
         this.FProcessorFebActiveShop = new TProcessorFebActiveShop(this.Parent);
         this.FProcessorFebActiveShop.Visible = false;
         this.FProcessorFebActiveShop.OnCloseUp = this.ProcessorOnCloseShop;
         this.FProcessorFebActiveShop.OnOverlay = this.ProcessorOnItemOver;
         this.FProcessorFebActiveShop.OnOut = this.ProcessorOnItemOut;
         this.FProcessorFebActiveShop.OnExchange = this.ProcessorOnExchangeItem;
         this.FProcessorFebActiveShop.X = -72;
         this.FProcessorFebActiveShop.y = -7;
         FMC_Scene.MC_ScoreA.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnTip0Over);
         FMC_Scene.MC_ScoreA.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
         FMC_Scene.MC_ScoreB.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnTip1Over);
         FMC_Scene.MC_ScoreB.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
         TGameUtil.setButtonMode(FMC_Scene.MC_Auto.BTN_Auto,true);
         FMC_Scene.MC_Auto.BTN_Auto.addEventListener(MouseEvent.CLICK,this.ProcessorOnAutoUp);
         FMC_Scene.MC_Auto.BTN_Auto.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnAutoOver);
         FMC_Scene.MC_Auto.BTN_Auto.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
         TGameUtil.setButtonMode(FMC_Scene.MC_Play.BTN_Play,true);
         FMC_Scene.MC_Play.BTN_Get.addEventListener(MouseEvent.CLICK,this.ProcessorOnGetScoreUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Exchange,true);
         FMC_Scene.BTN_Exchange.addEventListener(MouseEvent.CLICK,this.ProcessorOnExchangeUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Log,true);
         FMC_Scene.BTN_Log.addEventListener(MouseEvent.CLICK,this.ProcessorOnLoadLog);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Rank,true);
         FMC_Scene.BTN_Rank.addEventListener(MouseEvent.CLICK,this.ProcessorOnLoadRank);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Desc,true);
         FMC_Scene.BTN_Desc.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowDesc);
         TGameUtil.setButtonMode(FMC_Scene.BTN_TitleDesc,true);
         FMC_Scene.BTN_TitleDesc.addEventListener(MouseEvent.CLICK,ProcessorOnShowTitleDesc);
         TGameUtil.setButtonMode(FMC_Scene.BTN_EquipDesc,true);
         FMC_Scene.BTN_EquipDesc.addEventListener(MouseEvent.CLICK,ProcessorOnShowEquipDesc);
      }
      
      protected function UpdateGift() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         var _loc3_:TBaseBox = null;
         _loc2_ = FMC_Scene.MC_Gift;
         _loc3_ = this.FMayActive1_2015.Gift;
         _loc2_.TF_Count.text = _loc3_.Count.toString();
         _loc2_.TF_Price.text = TUtilityString.Format(this.FMayActive1_2015.DescListNew[2],this.FMayActive1_2015.ConsumeScore % _loc3_.Price);
         if(_loc3_.Count > 0)
         {
            _loc2_.MC_Click.visible = true;
            _loc2_.MC_Box.gotoAndPlay(1);
         }
         else
         {
            _loc2_.MC_Click.visible = false;
            _loc2_.MC_Box.gotoAndStop(1);
         }
      }
      
      protected function UpdateItem() : void
      {
         this.FShowItem.UpdateUI(this.FMayActive1_2015.ShowItems);
      }
      
      protected function UpdateCard() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:MovieClip = null;
         var _loc5_:MovieClip = null;
         var _loc6_:Object = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         FMC_Scene.MC_LuckyIcon.gotoAndStop(this.FMayActive1_2015.LuckyIndex);
         FMC_Scene.TF_Value.text = this.FMayActive1_2015.CurValue.toString();
         FMC_Scene.MC_Double.visible = this.FMayActive1_2015.IsDouble == -1 ? false : true;
         if(this.FMayActive1_2015.IsFirstPlay == TBaseActivity.STATUS_CANNOTGET)
         {
            FMC_Scene.MC_Click.visible = true;
            FMC_Scene.MC_Auto.visible = false;
            FMC_Scene.MC_Play.visible = true;
            TGameUtil.setButtonMode(FMC_Scene.MC_Play.BTN_Get,false);
         }
         else
         {
            FMC_Scene.MC_Click.visible = false;
            if(this.FMayActive1_2015.OpenCard == 0)
            {
               FMC_Scene.MC_Auto.visible = true;
               FMC_Scene.MC_Auto.TF_Desc.text = this.FMayActive1_2015.DescListNew[13];
               FMC_Scene.MC_Play.visible = false;
            }
            else
            {
               FMC_Scene.MC_Auto.visible = false;
               FMC_Scene.MC_Play.visible = true;
               TGameUtil.setButtonMode(FMC_Scene.MC_Play.BTN_Get,true);
            }
         }
         _loc1_ = 0;
         while(_loc1_ < CARD_COUNT)
         {
            _loc3_ = this.FCardList[_loc1_];
            _loc4_ = this.FCardBackList[_loc1_];
            if(this.FMayActive1_2015.CardList[_loc1_] == TBaseActivity.STATUS_CANNOTGET)
            {
               _loc3_.visible = false;
               _loc4_.visible = true;
               _loc4_.MC_Donghua.gotoAndStop(1);
            }
            else
            {
               _loc3_.visible = true;
               _loc8_ = this.FMayActive1_2015.CardList[_loc1_];
               _loc3_.gotoAndStop(_loc8_);
               _loc3_.TF_Value.text = this.FMayActive1_2015.CardScore[_loc8_ - 1];
               _loc4_.visible = false;
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < SHOW_LOG_COUNT)
         {
            _loc5_ = FMC_Scene["MC_Item" + _loc1_];
            _loc6_ = this.FMayActive1_2015.ShowList[_loc1_];
            _loc5_.gotoAndStop(_loc1_ + 1);
            _loc5_.MC_Icon0.gotoAndStop(_loc6_.Icon0);
            _loc5_.MC_Icon1.gotoAndStop(_loc6_.Icon1);
            _loc5_.MC_Icon2.gotoAndStop(_loc6_.Icon2);
            _loc5_.TF_Desc.text = this.FMayActive1_2015.DescListNew[8 + _loc1_];
            if(this.FMayActive1_2015.MatchIndex.indexOf(1) != -1)
            {
               if(this.FMayActive1_2015.MatchIndex[_loc1_] == 1)
               {
                  _loc5_.MC_Select.visible = true;
                  _loc5_.MC_Select.play();
                  TGameUtil.SetColorTransform(_loc5_,0);
               }
               else
               {
                  _loc5_.MC_Select.visible = false;
                  TGameUtil.SetColorTransform(_loc5_,-100);
               }
            }
            else
            {
               _loc5_.MC_Select.visible = false;
               TGameUtil.SetColorTransform(_loc5_,0);
            }
            _loc1_++;
         }
      }
      
      protected function UpdateText() : void
      {
         var _loc1_:int = 0;
         var _loc2_:String = null;
         var _loc3_:int = 0;
         FMC_Scene.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FMayActive1_2015.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FMayActive1_2015.EndTime) - 1) * 1000)));
         FMC_Scene.TF_Desc.text = this.FMayActive1_2015.DescListNew[1];
         FMC_Scene.MC_ScoreA.TF_Count.text = this.FMayActive1_2015.ScoreA.toString();
         FMC_Scene.MC_ScoreB.TF_Count.text = this.FMayActive1_2015.RankPoint.toString();
         FMC_Scene.TF_MaxCard.text = TUtilityString.Format(this.FMayActive1_2015.DescListNew[7],this.FMayActive1_2015.OpenCard,this.FMayActive1_2015.MaxCard);
         FMC_Scene.TF_Cost.text = TUtilityString.Format(this.FMayActive1_2015.DescListNew[14],this.FMayActive1_2015.Price);
      }
      
      override protected function ProcessorOnAcceptTaskUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TDessertHouseTask = null;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(FOnGetBox != null && _loc2_ < FActTaskData.TaskList.length && !FIsPlaying)
         {
            _loc3_ = FActTaskData.TaskList[_loc2_];
            FOnGetBox(ACTIVITY_1_ID,TProcessorMayActive_2015.ACTIVITY_1_GET_TASK,_loc3_.Identify);
         }
      }
      
      override protected function ProcessorOnFinishTaskUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TDessertHouseTask = null;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(FOnGetBox != null && _loc2_ < FActTaskData.TaskList.length && !FIsPlaying)
         {
            _loc3_ = FActTaskData.TaskList[_loc2_];
            FOnGetBox(ACTIVITY_1_ID,TProcessorMayActive_2015.ACTIVITY_1_FINISH_TASK,_loc3_.Identify);
         }
      }
      
      protected function ProcessorOnGiftUp(param1:MouseEvent) : void
      {
         if(Boolean(FOnGetBox != null && !FIsPlaying) && Boolean(this.FMayActive1_2015) && this.FMayActive1_2015.Gift.Count > 0)
         {
            FOnGetBox(ACTIVITY_1_ID,TProcessorMayActive_2015.ACTIVITY_1_GET_GIFT);
         }
      }
      
      protected function ProcessorOnCardUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         if(this.FMayActive1_2015.OpenCard >= this.FMayActive1_2015.MaxCard)
         {
            FOnShowFlowText(this.FMayActive1_2015.DescListNew[12]);
            return;
         }
         _loc2_ = int(String(param1.currentTarget.name).slice(7));
         if(Boolean(FOnBuyBox != null && !FIsPlaying) && Boolean(this.FMayActive1_2015) && this.FMayActive1_2015.CardList[_loc2_] == TBaseActivity.STATUS_CANNOTGET)
         {
            this.FOpenIndex = _loc2_;
            if(this.FMayActive1_2015.ScoreA >= this.FMayActive1_2015.Price)
            {
               FOnGetBox(ACTIVITY_1_ID,TProcessorMayActive_2015.ACTIVITY_1_PLAY_GAME,_loc2_ + 1);
            }
            else
            {
               _loc3_ = (this.FMayActive1_2015.Price - this.FMayActive1_2015.ScoreA) * this.FMayActive1_2015.ScorePrice;
               _loc4_ = TUtilityString.Format(this.FMayActive1_2015.DescListNew[3],this.FMayActive1_2015.Price,_loc3_,this.FMayActive1_2015.Price - this.FMayActive1_2015.ScoreA);
               FOnBuyBox(ACTIVITY_1_ID,TProcessorMayActive_2015.ACTIVITY_1_PLAY_GAME,_loc3_,_loc2_ + 1,0,_loc4_);
            }
         }
      }
      
      protected function ProcessorOnAutoUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:int = 0;
         if(FOnBuyBox != null && !FIsPlaying && Boolean(this.FMayActive1_2015))
         {
            _loc4_ = this.FMayActive1_2015.AutoPrice;
            if(this.FMayActive1_2015.ScoreA >= _loc4_)
            {
               FOnGetBox(ACTIVITY_1_ID,TProcessorMayActive_2015.ACTIVITY_1_AUTO_GAME);
            }
            else
            {
               _loc2_ = (_loc4_ - this.FMayActive1_2015.ScoreA) * this.FMayActive1_2015.ScorePrice;
               _loc3_ = TUtilityString.Format(this.FMayActive1_2015.DescListNew[3],_loc4_,_loc2_,_loc4_ - this.FMayActive1_2015.ScoreA);
               FOnBuyBox(ACTIVITY_1_ID,TProcessorMayActive_2015.ACTIVITY_1_AUTO_GAME,_loc2_,0,0,_loc3_);
            }
         }
      }
      
      protected function ProcessorOnGetScoreUp(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(FOnGetBox != null && !FIsPlaying && Boolean(this.FMayActive1_2015))
         {
            FOnGetBox(ACTIVITY_1_ID,TProcessorMayActive_2015.ACTIVITY_1_GET_SCORE);
         }
      }
      
      protected function ProcessorOnExchangeItem(param1:int) : void
      {
         if(FOnGetBox != null && Boolean(this.FMayActive1_2015))
         {
            FOnGetBox(ACTIVITY_1_ID,TProcessorMayActive_2015.ACTIVITY_1_EXCHANGE_ITEM,param1 + 1);
         }
      }
      
      protected function ProcessorOnGiftOver(param1:MouseEvent) : void
      {
         if(FOnNewBoxOver != null && Boolean(this.FMayActive1_2015))
         {
            FOnNewBoxOver(this.FMayActive1_2015.Gift.Inventories);
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
      
      protected function ProcessorOnAutoOver(param1:MouseEvent) : void
      {
         if(Boolean(FOnShowHtmlTip != null) && Boolean(this.FMayActive1_2015) && this.FMayActive1_2015.DescList.length > 20)
         {
            FOnShowHtmlTip(this.FMayActive1_2015.DescListNew[20]);
         }
      }
      
      protected function ProcessorOnTip0Over(param1:MouseEvent) : void
      {
         if(FOnShowHtmlTip != null && Boolean(this.FMayActive1_2015))
         {
            FOnShowHtmlTip(this.FMayActive1_2015.DescListNew[4]);
         }
      }
      
      protected function ProcessorOnTip1Over(param1:MouseEvent) : void
      {
         if(FOnShowHtmlTip != null && Boolean(this.FMayActive1_2015))
         {
            FOnShowHtmlTip(this.FMayActive1_2015.DescListNew[5]);
         }
      }
      
      protected function ProcessorOnTip2Over(param1:MouseEvent) : void
      {
         if(FOnShowHtmlTip != null && Boolean(this.FMayActive1_2015))
         {
            FOnShowHtmlTip(this.FMayActive1_2015.DescListNew[9]);
         }
      }
      
      protected function ProcessorOnExchangeUp(param1:MouseEvent) : void
      {
         this.FProcessorFebActiveShop.Visible = true;
         this.FProcessorFebActiveShop.UpdateUI(this.FMayActive1_2015);
      }
      
      protected function ProcessorOnCloseShop() : void
      {
         this.FProcessorFebActiveShop.Visible = false;
      }
      
      protected function ProcessorOnLoadRank(param1:MouseEvent) : void
      {
         if(FOnLoadRank != null)
         {
            FOnLoadRank(ACTIVITY_1_ID);
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
         var _loc1_:int = 0;
         if(FInitialized && this.visible && FMC_Scene.visible)
         {
            if(this.FShowItem)
            {
               this.FShowItem.LogicsPerform();
            }
            if(FIsPlaying)
            {
               switch(this.FMovieType)
               {
                  case MOVIE_OF_OPEN_CARD:
                     CurFrame = this.FCardBackList[this.FOpenIndex].MC_Donghua.currentFrame;
                     break;
                  case MOVIE_OF_FLOW:
                     CurFrame = FMC_Scene.MC_Movie0.currentFrame;
                     break;
                  case MOVIE_OF_AUTO_GAME:
                     CurFrame = this.FCardBackList[this.FOpenIndex].MC_Donghua.currentFrame;
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
         this.FMayActive1_2015 = SLogicsCore.MayActiveDatas2015.GetActivityByIdentify(ACTIVITY_1_ID) as TMayActive1_2015;
         UpdateTaskView();
         this.UpdateGift();
         this.UpdateCard();
         this.UpdateItem();
         this.UpdateText();
         if(FIsFirstLoad)
         {
            FIsFirstLoad = false;
            this.FProcessorFebActiveShop.Load();
         }
         if(this.FProcessorFebActiveShop.Visible)
         {
            this.FProcessorFebActiveShop.UpdateUI(this.FMayActive1_2015);
         }
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
         if(this.FMovieType == MOVIE_OF_OPEN_CARD)
         {
            this.FCardList[this.FOpenIndex].visible = true;
            _loc6_ = this.FMayActive1_2015.CardList[this.FOpenIndex];
            this.FCardList[this.FOpenIndex].gotoAndStop(this.FMayActive1_2015.CardList[this.FOpenIndex]);
            this.FCardList[this.FOpenIndex].TF_Value.text = this.FMayActive1_2015.CardScore[_loc6_ - 1];
            _loc5_ = this.FCardBackList[this.FOpenIndex].MC_Donghua;
            _loc5_.gotoAndPlay(1);
            FTotalFrame = _loc5_.totalFrames;
         }
         else if(this.FMovieType == MOVIE_OF_AUTO_GAME)
         {
            _loc3_ = 0;
            while(_loc3_ < this.FMayActive1_2015.CardList.length)
            {
               if(this.FMayActive1_2015.CardList[_loc3_] != TBaseActivity.STATUS_CANNOTGET)
               {
                  this.FOpenIndex = _loc3_;
                  this.FCardList[this.FOpenIndex].visible = true;
                  _loc6_ = this.FMayActive1_2015.CardList[this.FOpenIndex];
                  this.FCardList[this.FOpenIndex].gotoAndStop(_loc6_);
                  this.FCardList[this.FOpenIndex].TF_Value.text = this.FMayActive1_2015.CardScore[_loc6_ - 1];
                  _loc5_ = this.FCardBackList[this.FOpenIndex].MC_Donghua;
                  _loc5_.gotoAndPlay(1);
                  FTotalFrame = _loc5_.totalFrames;
               }
               _loc3_++;
            }
         }
         else if(this.FMovieType == MOVIE_OF_FLOW)
         {
            _loc5_ = FMC_Scene.MC_Movie0;
            _loc5_.visible = true;
            _loc5_.gotoAndPlay(1);
            FTotalFrame = _loc5_.totalFrames;
            FMC_Scene.MC_Movie1.visible = true;
            FMC_Scene.MC_Movie1.gotoAndPlay(1);
            _loc3_ = 0;
            while(_loc3_ < CARD_COUNT)
            {
               this.FCardBackList[_loc3_].visible = false;
               this.FCardList[_loc3_].visible = false;
               _loc3_++;
            }
         }
      }
      
      override public function MovieEnd() : void
      {
         var _loc1_:int = 0;
         var _loc2_:String = null;
         FIsPlaying = false;
         if(this.FMovieType == MOVIE_OF_OPEN_CARD)
         {
            this.UpdateUI();
         }
         if(this.FMovieType == MOVIE_OF_AUTO_GAME)
         {
            this.UpdateUI();
         }
         else if(this.FMovieType == MOVIE_OF_FLOW)
         {
            FMC_Scene.MC_Movie0.visible = false;
            FMC_Scene.MC_Movie1.visible = false;
            this.UpdateUI();
         }
      }
      
      override public function Unmount() : void
      {
         var _loc1_:int = 0;
         TweenUtil.removeAllTween();
         if(this.FShowItem)
         {
            this.FShowItem.ResetSlot();
         }
      }
      
      override public function SetMovieParam(param1:int = 0, param2:int = 0, param3:int = 0) : void
      {
         this.FOpenIndex = param1;
      }
   }
}

