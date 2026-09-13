package Processors.Game.Lobby.Exercise.MarchActive
{
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.DessertHouse.TDessertHouseTask;
   import Logics.Exercise.MarchActive.TMarchActive1;
   import Logics.Exercise.TBaseBox;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIShowItem;
   import Processors.Game.Lobby.Exercise.FebActive.TProcessorFebActiveShop;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import ghostcat.util.easing.TweenUtil;
   
   public class TUIMarchActive1 extends TUIBaseWindow
   {
      
      protected static const ICE_COUNT:int = 20;
      
      protected static const SHOW_ITEM_COUNT:int = 4;
      
      protected static const TREE_COUNT:int = 5;
      
      protected static const SCORE_COUNT:int = 4;
      
      protected static const ACTIVITY_1_ID:int = 1;
      
      public static const MOVIE_OF_WAITING:int = 0;
      
      public static const MOVIE_OF_PLAY_GAME:int = 1;
      
      public static const MOVIE_OF_SHUFFLE:int = 2;
      
      public static const MOVIE_OF_FLOW_0:int = 3;
      
      public static const MOVIE_OF_FLOW_1:int = 4;
      
      public static const MOVIE_OF_RESET:int = 5;
      
      public static const MOVIE_OF_OPEN:int = 6;
      
      public static const MOVIE_OF_AUTO:int = 7;
      
      protected var FMarchActive1:TMarchActive1;
      
      protected var FMovieType:int;
      
      protected var FFrameCount:int;
      
      protected var FBackCardVect:Vector.<MovieClip>;
      
      protected var FOpenIndex:int;
      
      protected var FShowItem:TUIShowItem;
      
      protected var FProcessorFebActiveShop:TProcessorFebActiveShop;
      
      public function TUIMarchActive1(param1:TUIComponent)
      {
         super(param1);
         this.FBackCardVect = new Vector.<MovieClip>(ICE_COUNT);
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
         while(_loc2_ < ICE_COUNT)
         {
            this.FBackCardVect[_loc2_] = FMC_Scene["MC_Card" + _loc2_];
            this.FBackCardVect[_loc2_].visible = false;
            this.FBackCardVect[_loc2_].buttonMode = true;
            this.FBackCardVect[_loc2_].addEventListener(MouseEvent.CLICK,this.ProcessorOnIceUp);
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
         FMC_Scene.MC_Movie0.visible = false;
         FMC_Scene.MC_Movie2.visible = false;
         FMC_Scene.MC_Movie3.visible = false;
         this.FProcessorFebActiveShop = new TProcessorFebActiveShop(this.Parent);
         this.FProcessorFebActiveShop.Visible = false;
         this.FProcessorFebActiveShop.OnCloseUp = this.ProcessorOnCloseShop;
         this.FProcessorFebActiveShop.OnOverlay = this.ProcessorOnItemOver;
         this.FProcessorFebActiveShop.OnOut = this.ProcessorOnItemOut;
         this.FProcessorFebActiveShop.OnExchange = this.ProcessorOnExchangeItem;
         this.FProcessorFebActiveShop.X = -21;
         this.FProcessorFebActiveShop.y = 15;
         FMC_Scene.MC_Tip0.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnTip0Over);
         FMC_Scene.MC_Tip0.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
         FMC_Scene.MC_Tip1.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnTip1Over);
         FMC_Scene.MC_Tip1.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
         FMC_Scene.MC_Tips.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnTip2Over);
         FMC_Scene.MC_Tips.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Auto,true);
         FMC_Scene.BTN_Auto.addEventListener(MouseEvent.CLICK,this.ProcessorOnAutoUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Get,true);
         FMC_Scene.BTN_Get.addEventListener(MouseEvent.CLICK,this.ProcessorOnGetSoulUp);
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
         FMC_Scene.MC_Click.mouseEnabled = false;
         FMC_Scene.MC_Click.mouseChildren = false;
      }
      
      protected function UpdateServerBox() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         var _loc3_:TBaseBox = null;
         _loc2_ = FMC_Scene.MC_Gift;
         _loc3_ = this.FMarchActive1.Gift;
         _loc2_.TF_TotalCount.text = this.FMarchActive1.ConsumeScore.toString();
         _loc2_.TF_Count.text = _loc3_.Count.toString();
         _loc2_.TF_Price.text = TUtilityString.Format(this.FMarchActive1.DescListNew[2],this.FMarchActive1.ConsumeScore % _loc3_.Price);
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
         this.FShowItem.UpdateUI(this.FMarchActive1.ShowItems);
      }
      
      protected function UpdateIce() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Boolean = false;
         var _loc3_:int = 0;
         var _loc4_:Boolean = false;
         _loc1_ = 0;
         while(_loc1_ < ICE_COUNT)
         {
            FMC_Scene.MC_Item["MC_Slot" + _loc1_].visible = true;
            _loc3_ = Math.abs(this.FMarchActive1.IceList[_loc1_]);
            FMC_Scene.MC_Item["MC_Slot" + _loc1_].gotoAndStop(_loc3_);
            if(this.FMarchActive1.IceList[_loc1_] == TMarchActive1.TYPE_NONE)
            {
               this.FBackCardVect[_loc1_].visible = true;
               this.FBackCardVect[_loc1_].MC_Donghua.gotoAndStop(1);
            }
            else
            {
               _loc2_ = true;
               this.FBackCardVect[_loc1_].visible = false;
               if(this.FMarchActive1.IceList[_loc1_] > 0)
               {
                  FMC_Scene.MC_Item["MC_Slot" + _loc1_].MC_Clear.visible = false;
               }
               else
               {
                  FMC_Scene.MC_Item["MC_Slot" + _loc1_].MC_Clear.visible = true;
               }
            }
            _loc1_++;
         }
         if(_loc2_)
         {
            FMC_Scene.BTN_Auto.visible = false;
            FMC_Scene.BTN_Get.visible = true;
         }
         else
         {
            FMC_Scene.BTN_Auto.visible = true;
            FMC_Scene.BTN_Get.visible = false;
         }
         _loc4_ = true;
         _loc1_ = 0;
         while(_loc1_ < ICE_COUNT)
         {
            if(this.FMarchActive1.IceList[_loc1_] != TMarchActive1.TYPE_NONE)
            {
               _loc4_ = false;
            }
            _loc1_++;
         }
         FMC_Scene.MC_Click.visible = _loc4_;
      }
      
      protected function UpdateText() : void
      {
         var _loc1_:int = 0;
         var _loc2_:String = null;
         var _loc3_:int = 0;
         FMC_Scene.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FMarchActive1.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FMarchActive1.EndTime) - 1) * 1000)));
         FMC_Scene.TF_Desc.text = this.FMarchActive1.DescListNew[1];
         FMC_Scene.TF_ScoreA.text = this.FMarchActive1.ScoreA.toString();
         if(this.FMarchActive1.Double > 0)
         {
            _loc3_ = this.FMarchActive1.ScoreB / this.FMarchActive1.Double / 2;
            FMC_Scene.TF_ScoreB.text = _loc3_ + "(x" + this.FMarchActive1.Double * 2 + ")";
         }
         else
         {
            FMC_Scene.TF_ScoreB.text = this.FMarchActive1.ScoreB.toString();
         }
         FMC_Scene.TF_RankPoint.text = this.FMarchActive1.RankPoint.toString();
         FMC_Scene.TF_Double.text = this.FMarchActive1.Double.toString();
         _loc1_ = 0;
         while(_loc1_ < SCORE_COUNT)
         {
            if(_loc1_ < this.FMarchActive1.ScoreList.length)
            {
               FMC_Scene["TF_Score" + _loc1_].text = this.FMarchActive1.ScoreList[_loc1_].toString();
            }
            else
            {
               FMC_Scene["TF_Score" + _loc1_].text = "";
            }
            _loc1_++;
         }
      }
      
      override protected function ProcessorOnAcceptTaskUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TDessertHouseTask = null;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(FOnGetBox != null && _loc2_ < FActTaskData.TaskList.length && !FIsPlaying)
         {
            _loc3_ = FActTaskData.TaskList[_loc2_];
            FOnGetBox(ACTIVITY_1_ID,TProcessorMarchActive.ACTIVITY_1_GET_TASK,_loc3_.Identify);
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
            FOnGetBox(ACTIVITY_1_ID,TProcessorMarchActive.ACTIVITY_1_FINISH_TASK,_loc3_.Identify);
         }
      }
      
      protected function ProcessorOnGiftUp(param1:MouseEvent) : void
      {
         if(Boolean(FOnGetBox != null && !FIsPlaying) && Boolean(this.FMarchActive1) && this.FMarchActive1.Gift.Count > 0)
         {
            FOnGetBox(ACTIVITY_1_ID,TProcessorMarchActive.ACTIVITY_1_GET_GIFT);
         }
      }
      
      protected function ProcessorOnIceUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(7));
         if(Boolean(FOnBuyBox != null && !FIsPlaying) && Boolean(this.FMarchActive1) && this.FMarchActive1.IceList[_loc2_] == TMarchActive1.TYPE_NONE)
         {
            if(this.FMarchActive1.ScoreA > 0)
            {
               FOnGetBox(ACTIVITY_1_ID,TProcessorMarchActive.ACTIVITY_1_PLAY_GAME,_loc2_ + 1);
            }
            else
            {
               FOnBuyBox(ACTIVITY_1_ID,TProcessorMarchActive.ACTIVITY_1_PLAY_GAME,this.FMarchActive1.ScorePrice,_loc2_ + 1);
            }
         }
      }
      
      protected function ProcessorOnAutoUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:int = 0;
         if(FOnBuyBox != null && !FIsPlaying && Boolean(this.FMarchActive1))
         {
            _loc4_ = this.FMarchActive1.AutoPrice;
            if(this.FMarchActive1.ScoreA >= _loc4_)
            {
               FOnGetBox(ACTIVITY_1_ID,TProcessorMarchActive.ACTIVITY_1_AUTO_GAME);
            }
            else
            {
               _loc2_ = (_loc4_ - this.FMarchActive1.ScoreA) * this.FMarchActive1.ScorePrice;
               _loc3_ = TUtilityString.Format(this.FMarchActive1.DescListNew[3],_loc4_,_loc2_,_loc4_ - this.FMarchActive1.ScoreA);
               FOnBuyBox(ACTIVITY_1_ID,TProcessorMarchActive.ACTIVITY_1_AUTO_GAME,_loc2_,0,0,_loc3_);
            }
         }
      }
      
      protected function ProcessorOnGetSoulUp(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(FOnGetBox != null && !FIsPlaying && Boolean(this.FMarchActive1))
         {
            FOnGetBox(ACTIVITY_1_ID,TProcessorMarchActive.ACTIVITY_1_GET_SOUL);
         }
      }
      
      protected function ProcessorOnExchangeItem(param1:int) : void
      {
         if(FOnGetBox != null && Boolean(this.FMarchActive1))
         {
            FOnGetBox(ACTIVITY_1_ID,TProcessorMarchActive.ACTIVITY_1_EXCHANGE_ITEM,param1 + 1);
         }
      }
      
      protected function ProcessorOnGiftOver(param1:MouseEvent) : void
      {
         if(FOnNewBoxOver != null && Boolean(this.FMarchActive1))
         {
            FOnNewBoxOver(this.FMarchActive1.Gift.Inventories);
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
      
      protected function ProcessorOnTip0Over(param1:MouseEvent) : void
      {
         if(FOnShowHtmlTip != null && Boolean(this.FMarchActive1))
         {
            FOnShowHtmlTip(this.FMarchActive1.DescListNew[4]);
         }
      }
      
      protected function ProcessorOnTip1Over(param1:MouseEvent) : void
      {
         if(FOnShowHtmlTip != null && Boolean(this.FMarchActive1))
         {
            FOnShowHtmlTip(this.FMarchActive1.DescListNew[5]);
         }
      }
      
      protected function ProcessorOnTip2Over(param1:MouseEvent) : void
      {
         if(FOnShowHtmlTip != null && Boolean(this.FMarchActive1))
         {
            FOnShowHtmlTip(this.FMarchActive1.DescListNew[9]);
         }
      }
      
      protected function ProcessorOnExchangeUp(param1:MouseEvent) : void
      {
         this.FProcessorFebActiveShop.Visible = true;
         this.FProcessorFebActiveShop.UpdateUI(this.FMarchActive1);
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
                  case MOVIE_OF_WAITING:
                     return;
                  case MOVIE_OF_RESET:
                     CurFrame = FMC_Scene.MC_Movie3.currentFrame;
                     break;
                  case MOVIE_OF_PLAY_GAME:
                     CurFrame = this.FBackCardVect[this.FOpenIndex].MC_Donghua.currentFrame;
                     break;
                  case MOVIE_OF_AUTO:
                     CurFrame = this.FBackCardVect[ICE_COUNT - 1].MC_Donghua.currentFrame;
                     break;
                  case MOVIE_OF_FLOW_0:
                     CurFrame = FMC_Scene.MC_Movie0.currentFrame;
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
         this.FMarchActive1 = SLogicsCore.MarchActiveDatas.GetActivityByIdentify(ACTIVITY_1_ID) as TMarchActive1;
         UpdateTaskView();
         this.UpdateServerBox();
         this.UpdateIce();
         this.UpdateItem();
         this.UpdateText();
         if(FIsFirstLoad)
         {
            FIsFirstLoad = false;
            this.FProcessorFebActiveShop.Load();
         }
         if(this.FProcessorFebActiveShop.Visible)
         {
            this.FProcessorFebActiveShop.UpdateUI(this.FMarchActive1);
         }
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
            _loc4_ = this.FBackCardVect[this.FOpenIndex].MC_Donghua;
            _loc4_.visible = true;
            FTotalFrame = _loc4_.totalFrames;
            _loc4_.gotoAndPlay(1);
            _loc5_ = Math.abs(this.FMarchActive1.IceList[this.FOpenIndex]);
            FMC_Scene.MC_Item["MC_Slot" + this.FOpenIndex].gotoAndStop(_loc5_);
            if(this.FMarchActive1.IceList[this.FOpenIndex] > 0)
            {
               FMC_Scene.MC_Item["MC_Slot" + this.FOpenIndex].MC_Clear.visible = false;
            }
            else
            {
               FMC_Scene.MC_Item["MC_Slot" + this.FOpenIndex].MC_Clear.visible = true;
            }
         }
         else if(this.FMovieType == MOVIE_OF_AUTO)
         {
            _loc3_ = 0;
            while(_loc3_ < ICE_COUNT)
            {
               _loc4_ = this.FBackCardVect[_loc3_].MC_Donghua;
               _loc4_.visible = true;
               FTotalFrame = _loc4_.totalFrames;
               _loc4_.gotoAndPlay(1);
               FMC_Scene.MC_Item["MC_Slot" + _loc3_].MC_Clear.visible = false;
               _loc5_ = Math.abs(this.FMarchActive1.IceList[_loc3_]);
               FMC_Scene.MC_Item["MC_Slot" + _loc3_].gotoAndStop(_loc5_);
               _loc3_++;
            }
         }
         else if(this.FMovieType == MOVIE_OF_RESET)
         {
            _loc3_ = 0;
            while(_loc3_ < ICE_COUNT)
            {
               this.FBackCardVect[_loc3_].visible = false;
               FMC_Scene.MC_Item["MC_Slot" + _loc3_].visible = false;
               _loc3_++;
            }
            _loc4_ = FMC_Scene.MC_Movie3;
            _loc4_.visible = true;
            FTotalFrame = _loc4_.totalFrames;
            _loc4_.gotoAndPlay(1);
         }
         else if(this.FMovieType == MOVIE_OF_FLOW_0)
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
            this.FBackCardVect[this.FOpenIndex].MC_Donghua.gotoAndStop(1);
            this.FBackCardVect[this.FOpenIndex].visible = false;
            this.UpdateUI();
         }
         else if(this.FMovieType == MOVIE_OF_AUTO)
         {
            _loc1_ = 0;
            while(_loc1_ < ICE_COUNT)
            {
               this.FBackCardVect[_loc1_].MC_Donghua.gotoAndStop(1);
               this.FBackCardVect[_loc1_].visible = false;
               _loc1_++;
            }
            this.UpdateUI();
         }
         else if(this.FMovieType == MOVIE_OF_RESET)
         {
            FMC_Scene.MC_Movie3.visible = false;
            _loc1_ = 0;
            while(_loc1_ < ICE_COUNT)
            {
               this.FBackCardVect[_loc1_].MC_Donghua.gotoAndStop(1);
               this.FBackCardVect[_loc1_].visible = false;
               FMC_Scene.MC_Item["MC_Slot" + _loc1_].visible = true;
               _loc1_++;
            }
            this.FMarchActive1.ScoreB = 0;
            this.UpdateUI();
         }
         else if(this.FMovieType == MOVIE_OF_FLOW_0)
         {
            FMC_Scene.MC_Movie0.visible = false;
            this.PlayMovie(MOVIE_OF_RESET);
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

