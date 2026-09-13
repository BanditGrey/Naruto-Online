package Processors.Game.Lobby.Exercise.HallowmasActive
{
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.DessertHouse.TDessertHouseTask;
   import Logics.Exercise.HallowmasActive.THallowmasActive3;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIShowItem;
   import Processors.Game.Lobby.Exercise.NovActive.TProcessorNovActiveShop;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.setTimeout;
   import ghostcat.util.easing.TweenUtil;
   
   public class TUIHallowmasActive3 extends TUIBaseWindow
   {
      
      protected static const ICE_COUNT:int = 16;
      
      protected static const SHOW_ITEM_COUNT:int = 3;
      
      protected static const TREE_COUNT:int = 5;
      
      protected static const ACTIVITY_3_ID:int = 3;
      
      public static const MOVIE_OF_WAITING:int = 0;
      
      public static const MOVIE_OF_SHUFFLE:int = 1;
      
      public static const MOVIE_OF_PLAY_GAME:int = 2;
      
      public static const MOVIE_OF_FLOW_0:int = 3;
      
      public static const MOVIE_OF_FLOW_1:int = 4;
      
      public static const MOVIE_OF_RESET:int = 5;
      
      public static const MOVIE_OF_OPEN:int = 6;
      
      public static const MOVIE_OF_AUTO:int = 7;
      
      protected var FHallowmasActive3:THallowmasActive3;
      
      protected var FIsFirst:Boolean;
      
      protected var FIsFirstPlay:Boolean;
      
      protected var FMovieType:int;
      
      protected var FFrameCount:int;
      
      protected var FOpenIndex:int;
      
      protected var FShowItem:TUIShowItem;
      
      protected var FProcessorNovActiveShop:TProcessorNovActiveShop;
      
      public function TUIHallowmasActive3(param1:TUIComponent)
      {
         super(param1);
         this.FIsFirst = true;
         FIsFirstLoad = true;
         this.FIsFirstPlay = true;
      }
      
      override protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TUIShowItem = null;
         var _loc5_:MovieClip = null;
         var _loc6_:MovieClip = null;
         super.Resources_UIDispatch(param1);
         if(!FMC_Scene || !FMC_Scene.MC_Ice)
         {
            return;
         }
         _loc2_ = 0;
         while(_loc2_ < ICE_COUNT)
         {
            FMC_Scene.MC_Ice["MC_Ice" + _loc2_].buttonMode = true;
            FMC_Scene.MC_Ice["MC_Ice" + _loc2_].MC_Movie.visible = false;
            FMC_Scene.MC_Ice["MC_Ice" + _loc2_].addEventListener(MouseEvent.CLICK,this.ProcessorOnIceUp);
            _loc2_++;
         }
         this.FShowItem = new TUIShowItem(this,SHOW_ITEM_COUNT);
         this.FShowItem.Perform_UIDispatch(FMC_Scene.MC_ShowItems);
         this.FShowItem.OnOverlay = this.ProcessorOnItemOver;
         this.FShowItem.OnOut = this.ProcessorOnItemOut;
         this.FShowItem.OnShowRecruit = this.ProcessorOnShowRecruit;
         FMC_Scene.MC_Gift.buttonMode = true;
         TGameUtil.setButtonMode(FMC_Scene.MC_Gift.BTN_Get,true);
         FMC_Scene.MC_Gift.MC_Box.addEventListener(MouseEvent.CLICK,this.ProcessorOnGiftUp);
         FMC_Scene.MC_Gift.MC_Box.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnGiftOver);
         FMC_Scene.MC_Gift.MC_Box.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnNewBoxOut);
         FMC_Scene.MC_Movie0.visible = false;
         FMC_Scene.MC_Movie1.visible = false;
         FMC_Scene.MC_Movie2.visible = false;
         FMC_Scene.MC_Movie3.visible = false;
         this.FProcessorNovActiveShop = new TProcessorNovActiveShop(this.Parent);
         this.FProcessorNovActiveShop.Visible = false;
         this.FProcessorNovActiveShop.OnCloseUp = this.ProcessorOnCloseShop;
         this.FProcessorNovActiveShop.OnOverlay = this.ProcessorOnItemOver;
         this.FProcessorNovActiveShop.OnOut = this.ProcessorOnItemOut;
         this.FProcessorNovActiveShop.OnGetBox = this.ProcessorOnGetReward;
         this.FProcessorNovActiveShop.OnExchange = this.ProcessorOnExchangeItem;
         this.FProcessorNovActiveShop.X = -21;
         this.FProcessorNovActiveShop.y = 15;
         FMC_Scene.MC_Tip0.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnTip0Over);
         FMC_Scene.MC_Tip0.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
         FMC_Scene.MC_Tip1.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnTip1Over);
         FMC_Scene.MC_Tip1.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
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
         TGameUtil.setButtonMode(FMC_Scene.MC_Mask.BTN_Start,true);
         FMC_Scene.MC_Mask.BTN_Start.addEventListener(MouseEvent.CLICK,this.ProcessorOnStartUp);
      }
      
      protected function UpdateServerBox() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         var _loc3_:TBaseBox = null;
         _loc2_ = FMC_Scene.MC_Gift;
         _loc3_ = this.FHallowmasActive3.Gift;
         _loc2_.TF_TotalCount.text = this.FHallowmasActive3.ConsumeScore.toString();
         _loc2_.TF_Count.text = _loc3_.Count.toString();
         _loc2_.TF_Price.text = TUtilityString.Format(this.FHallowmasActive3.DescListNew[2],this.FHallowmasActive3.ConsumeScore % _loc3_.Price);
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
         this.FShowItem.UpdateUI(this.FHallowmasActive3.ShowItems);
      }
      
      protected function UpdateIce() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < ICE_COUNT)
         {
            if(this.FHallowmasActive3.IceList[_loc1_] == 0)
            {
               FMC_Scene.MC_Ice["MC_Ice" + _loc1_].MC_Mask.visible = true;
               FMC_Scene.MC_Ice["MC_Ice" + _loc1_].TF_Num.text = 0;
            }
            else
            {
               FMC_Scene.MC_Ice["MC_Ice" + _loc1_].MC_Mask.visible = false;
               FMC_Scene.MC_Ice["MC_Ice" + _loc1_].TF_Num.text = this.FHallowmasActive3.IceList[_loc1_];
            }
            _loc1_++;
         }
      }
      
      protected function UpdateTree() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         var _loc3_:TBaseBox = null;
         var _loc4_:TInventory = null;
         _loc1_ = 0;
         while(_loc1_ < TREE_COUNT)
         {
            _loc2_ = FMC_Scene.MC_Tree["MC_Box" + _loc1_];
            if(_loc1_ < this.FHallowmasActive3.TreeList.length)
            {
               _loc2_.visible = true;
               _loc3_ = this.FHallowmasActive3.TreeList[_loc1_];
               FMC_Scene.MC_Tree["TF_Num" + _loc1_].text = _loc3_.Desc1;
               _loc4_ = _loc3_.Inventories.GetInventoryByIndex(0);
               FMC_Scene.MC_Tree["TF_Count" + _loc1_].text = "*" + _loc4_.Quantity;
               if(_loc3_.Status == TBaseActivity.STATUS_CANNOTGET)
               {
                  _loc2_.visible = false;
               }
               else
               {
                  _loc2_.visible = true;
               }
            }
            else
            {
               _loc2_.visible = false;
            }
            _loc1_++;
         }
         if(this.FHallowmasActive3.ScoreB == 0)
         {
            TGameUtil.setButtonMode(FMC_Scene.BTN_Get,false);
            if(this.FHallowmasActive3.FirstPlay == 0)
            {
               FMC_Scene.BTN_Auto.visible = false;
               FMC_Scene.BTN_Get.visible = true;
            }
            else
            {
               FMC_Scene.BTN_Auto.visible = true;
               FMC_Scene.BTN_Get.visible = false;
            }
         }
         else
         {
            FMC_Scene.BTN_Auto.visible = false;
            FMC_Scene.BTN_Get.visible = true;
            if(this.FHallowmasActive3.ScoreB >= this.FHallowmasActive3.TreeList[0].Min)
            {
               TGameUtil.setButtonMode(FMC_Scene.BTN_Get,true);
            }
            else
            {
               TGameUtil.setButtonMode(FMC_Scene.BTN_Get,false);
            }
         }
      }
      
      protected function UpdateText() : void
      {
         var _loc1_:int = 0;
         var _loc2_:String = null;
         FMC_Scene.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FHallowmasActive3.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FHallowmasActive3.EndTime) - 1) * 1000)));
         FMC_Scene.TF_Desc.text = this.FHallowmasActive3.DescListNew[1];
         FMC_Scene.TF_IceCount.text = this.FHallowmasActive3.IceIndex - 1 + "/" + this.FHallowmasActive3.MaxCount;
         FMC_Scene.TF_ScoreA.text = this.FHallowmasActive3.ScoreA.toString();
         FMC_Scene.TF_ScoreB.text = this.FHallowmasActive3.ScoreB.toString();
         FMC_Scene.TF_RankPoint.text = this.FHallowmasActive3.RankPoint.toString();
         _loc1_ = Math.min(this.FHallowmasActive3.IceIndex,this.FHallowmasActive3.MaxCount) - 1;
         FMC_Scene.TF_Price.text = TUtilityString.Format(this.FHallowmasActive3.DescListNew[3],this.FHallowmasActive3.PriceList[_loc1_]);
      }
      
      protected function ProcessorOnStartUp(param1:MouseEvent) : void
      {
         this.FIsFirst = false;
         FMC_Scene.MC_Mask.visible = false;
         this.PlayMovie(MOVIE_OF_SHUFFLE);
      }
      
      override protected function ProcessorOnAcceptTaskUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TDessertHouseTask = null;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(FOnGetBox != null && _loc2_ < FActTaskData.TaskList.length && !FIsPlaying)
         {
            _loc3_ = FActTaskData.TaskList[_loc2_];
            FOnGetBox(ACTIVITY_3_ID,TProcessorHallowmasActive.ACTIVITY_3_GET_TASK,_loc3_.Identify);
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
         if(FOnGetBox != null && _loc2_ < FActTaskData.TaskList.length)
         {
            _loc3_ = FActTaskData.TaskList[_loc2_];
            FOnGetBox(ACTIVITY_3_ID,TProcessorHallowmasActive.ACTIVITY_3_FINISH_TASK,_loc3_.Identify);
         }
      }
      
      protected function ProcessorOnGiftUp(param1:MouseEvent) : void
      {
         if(Boolean(FOnGetBox != null && !FIsPlaying) && Boolean(this.FHallowmasActive3) && this.FHallowmasActive3.Gift.Count > 0)
         {
            FOnGetBox(ACTIVITY_3_ID,TProcessorHallowmasActive.ACTIVITY_3_GET_GIFT);
         }
      }
      
      protected function ProcessorOnIceUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(6));
         if(Boolean(FOnBuyBox != null && !FIsPlaying) && Boolean(this.FHallowmasActive3) && this.FHallowmasActive3.IceList[_loc2_] == 0)
         {
            if(this.FHallowmasActive3.IceIndex - 1 < this.FHallowmasActive3.MaxCount)
            {
               _loc5_ = this.FHallowmasActive3.PriceList[this.FHallowmasActive3.IceIndex - 1];
               if(this.FHallowmasActive3.ScoreA >= _loc5_)
               {
                  FOnGetBox(ACTIVITY_3_ID,TProcessorHallowmasActive.ACTIVITY_3_BREAK_ICE,_loc2_ + 1);
               }
               else
               {
                  _loc3_ = (_loc5_ - this.FHallowmasActive3.ScoreA) * this.FHallowmasActive3.ScorePrice;
                  _loc4_ = TUtilityString.Format(this.FHallowmasActive3.DescListNew[4],_loc5_,_loc3_,_loc5_ - this.FHallowmasActive3.ScoreA);
                  FOnBuyBox(ACTIVITY_3_ID,TProcessorHallowmasActive.ACTIVITY_3_BREAK_ICE,_loc3_,_loc2_ + 1,0,_loc4_);
               }
            }
            else
            {
               FOnShowFlowText(this.FHallowmasActive3.DescListNew[8]);
            }
         }
      }
      
      protected function ProcessorOnAutoUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:int = 0;
         if(FOnBuyBox != null && !FIsPlaying && Boolean(this.FHallowmasActive3))
         {
            _loc4_ = this.FHallowmasActive3.AutoPrice;
            if(this.FHallowmasActive3.ScoreA >= _loc4_)
            {
               FOnGetBox(ACTIVITY_3_ID,TProcessorHallowmasActive.ACTIVITY_3_AUTO_GAME);
            }
            else
            {
               _loc2_ = (_loc4_ - this.FHallowmasActive3.ScoreA) * this.FHallowmasActive3.ScorePrice;
               _loc3_ = TUtilityString.Format(this.FHallowmasActive3.DescListNew[5],_loc4_,_loc2_,_loc4_ - this.FHallowmasActive3.ScoreA);
               FOnBuyBox(ACTIVITY_3_ID,TProcessorHallowmasActive.ACTIVITY_3_AUTO_GAME,_loc2_,0,0,_loc3_);
            }
         }
      }
      
      protected function ProcessorOnGetSoulUp(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(FOnGetBox != null && !FIsPlaying && Boolean(this.FHallowmasActive3))
         {
            FOnGetBox(ACTIVITY_3_ID,TProcessorHallowmasActive.ACTIVITY_3_GET_SOUL);
         }
      }
      
      protected function ProcessorOnExchangeItem(param1:int) : void
      {
         if(FOnGetBox != null && Boolean(this.FHallowmasActive3))
         {
            FOnGetBox(ACTIVITY_3_ID,TProcessorHallowmasActive.ACTIVITY_3_EXCHANGE_ITEM,param1 + 1);
         }
      }
      
      protected function ProcessorOnGetReward(param1:int) : void
      {
         if(FOnGetBox != null && Boolean(this.FHallowmasActive3))
         {
            FOnGetBox(ACTIVITY_3_ID,TProcessorHallowmasActive.ACTIVITY_3_GET_REWARD,param1 + 1);
         }
      }
      
      protected function ProcessorOnGiftOver(param1:MouseEvent) : void
      {
         if(FOnGetBox != null && Boolean(this.FHallowmasActive3))
         {
            FOnNewBoxOver(this.FHallowmasActive3.Gift.Inventories);
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
         if(FOnShowHtmlTip != null)
         {
            FOnShowHtmlTip(this.FHallowmasActive3.DescListNew[9]);
         }
      }
      
      protected function ProcessorOnTip1Over(param1:MouseEvent) : void
      {
         if(FOnShowHtmlTip != null)
         {
            FOnShowHtmlTip(this.FHallowmasActive3.DescListNew[10]);
         }
      }
      
      protected function ProcessorOnExchangeUp(param1:MouseEvent) : void
      {
         this.FProcessorNovActiveShop.Visible = true;
         this.FProcessorNovActiveShop.UpdateUI(this.FHallowmasActive3);
      }
      
      protected function ProcessorOnCloseShop() : void
      {
         this.FProcessorNovActiveShop.Visible = false;
      }
      
      protected function ProcessorOnLoadRank(param1:MouseEvent) : void
      {
         if(FOnLoadRank != null)
         {
            FOnLoadRank(ACTIVITY_3_ID);
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
                  case MOVIE_OF_FLOW_0:
                     CurFrame = FMC_Scene.MC_Movie0.currentFrame;
                     break;
                  case MOVIE_OF_FLOW_1:
                     CurFrame = FMC_Scene.MC_Movie1.currentFrame;
                     break;
                  case MOVIE_OF_SHUFFLE:
                     CurFrame = FMC_Scene.MC_Movie2.currentFrame;
                     break;
                  case MOVIE_OF_RESET:
                     CurFrame = FMC_Scene.MC_Movie3.currentFrame;
                     break;
                  case MOVIE_OF_PLAY_GAME:
                     CurFrame = FMC_Scene.MC_Ice["MC_Ice" + this.FOpenIndex].MC_Movie.currentFrame;
                     break;
                  case MOVIE_OF_OPEN:
                     CurFrame = FMC_Scene.MC_Ice["MC_Ice" + this.FOpenIndex].MC_Movie.currentFrame;
                     break;
                  case MOVIE_OF_AUTO:
                     CurFrame = FMC_Scene.MC_Ice["MC_Ice" + this.FOpenIndex].MC_Movie.currentFrame;
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
         this.FHallowmasActive3 = SLogicsCore.HallowmasActiveDatas.GetActivityByIdentify(ACTIVITY_3_ID) as THallowmasActive3;
         UpdateTaskView();
         this.UpdateServerBox();
         this.UpdateIce();
         this.UpdateTree();
         this.UpdateItem();
         this.UpdateText();
         if(this.FIsFirst)
         {
            FMC_Scene.MC_Mask.visible = true;
         }
         else
         {
            FMC_Scene.MC_Mask.visible = false;
         }
         if(FIsFirstLoad)
         {
            FIsFirstLoad = false;
            this.FProcessorNovActiveShop.Load();
         }
         if(this.FProcessorNovActiveShop.Visible)
         {
            this.FProcessorNovActiveShop.UpdateUI(this.FHallowmasActive3);
         }
      }
      
      override public function PlayMovie(param1:int = 0, param2:Boolean = false) : void
      {
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         FIsPlaying = true;
         this.FMovieType = param1;
         if(this.FMovieType == MOVIE_OF_PLAY_GAME)
         {
            _loc4_ = FMC_Scene.MC_Ice["MC_Ice" + this.FOpenIndex].MC_Movie;
            _loc4_.visible = true;
            FTotalFrame = _loc4_.totalFrames;
            _loc4_.gotoAndPlay(1);
         }
         else if(this.FMovieType == MOVIE_OF_AUTO)
         {
            _loc3_ = 0;
            while(_loc3_ < ICE_COUNT)
            {
               if(this.FHallowmasActive3.IceList[_loc3_] != 0)
               {
                  _loc4_ = FMC_Scene.MC_Ice["MC_Ice" + _loc3_].MC_Movie;
                  _loc4_.visible = true;
                  FMC_Scene.MC_Ice["MC_Ice" + _loc3_].MC_Mask.visible = false;
                  FMC_Scene.MC_Ice["MC_Ice" + _loc3_].TF_Num.text = this.FHallowmasActive3.IceList[_loc3_].toString();
                  FTotalFrame = _loc4_.totalFrames;
                  _loc4_.gotoAndPlay(1);
                  this.FOpenIndex = _loc3_;
               }
               _loc3_++;
            }
         }
         else if(this.FMovieType == MOVIE_OF_OPEN)
         {
            _loc3_ = 0;
            while(_loc3_ < ICE_COUNT)
            {
               if(this.FHallowmasActive3.IceList[_loc3_] == 0)
               {
                  _loc4_ = FMC_Scene.MC_Ice["MC_Ice" + _loc3_].MC_Movie;
                  _loc4_.visible = true;
                  FMC_Scene.MC_Ice["MC_Ice" + _loc3_].TF_Num.text = this.FHallowmasActive3.AllIceList[_loc3_].toString();
                  FTotalFrame = _loc4_.totalFrames;
                  _loc4_.gotoAndPlay(1);
                  this.FOpenIndex = _loc3_;
               }
               _loc3_++;
            }
         }
         else if(this.FMovieType == MOVIE_OF_SHUFFLE)
         {
            FMC_Scene.MC_Ice.visible = false;
            _loc4_ = FMC_Scene.MC_Movie2;
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
         else if(this.FMovieType == MOVIE_OF_FLOW_1)
         {
            _loc4_ = FMC_Scene.MC_Movie1;
            _loc4_.visible = true;
            FTotalFrame = _loc4_.totalFrames;
            _loc4_.gotoAndPlay(1);
         }
         else if(this.FMovieType == MOVIE_OF_RESET)
         {
            _loc4_ = FMC_Scene.MC_Movie3;
            _loc4_.visible = true;
            FTotalFrame = _loc4_.totalFrames;
            _loc4_.gotoAndPlay(1);
         }
         else if(this.FMovieType == MOVIE_OF_WAITING)
         {
            setTimeout(this.MovieEnd,1000);
         }
      }
      
      override public function MovieEnd() : void
      {
         var _loc1_:int = 0;
         var _loc2_:String = null;
         FIsPlaying = false;
         if(this.FMovieType == MOVIE_OF_PLAY_GAME)
         {
            FMC_Scene.MC_Ice["MC_Ice" + this.FOpenIndex].MC_Mask.visible = false;
            FMC_Scene.MC_Ice["MC_Ice" + this.FOpenIndex].TF_Num.text = this.FHallowmasActive3.IceList[this.FOpenIndex].toString();
            this.PlayMovie(MOVIE_OF_FLOW_0);
            FOnShowFlowText(FFlowStr);
         }
         else if(this.FMovieType == MOVIE_OF_AUTO)
         {
            this.PlayMovie(MOVIE_OF_FLOW_0);
            FOnShowFlowText(FFlowStr);
         }
         else if(this.FMovieType == MOVIE_OF_SHUFFLE)
         {
            FMC_Scene.MC_Ice.visible = true;
            FMC_Scene.MC_Movie2.visible = false;
            this.UpdateUI();
         }
         else if(this.FMovieType == MOVIE_OF_FLOW_0)
         {
            FMC_Scene.MC_Movie0.visible = false;
            this.UpdateUI();
         }
         else if(this.FMovieType == MOVIE_OF_FLOW_1)
         {
            FMC_Scene.MC_Movie1.visible = false;
            this.PlayMovie(MOVIE_OF_OPEN);
         }
         else if(this.FMovieType == MOVIE_OF_OPEN)
         {
            _loc1_ = 0;
            while(_loc1_ < ICE_COUNT)
            {
               FMC_Scene.MC_Ice["MC_Ice" + _loc1_].MC_Mask.visible = false;
               _loc1_++;
            }
            this.PlayMovie(MOVIE_OF_WAITING);
         }
         else if(this.FMovieType == MOVIE_OF_WAITING)
         {
            this.PlayMovie(MOVIE_OF_RESET);
         }
         else if(this.FMovieType == MOVIE_OF_RESET)
         {
            this.FHallowmasActive3.ScoreB = 0;
            this.FHallowmasActive3.IceIndex = 1;
            _loc1_ = 0;
            while(_loc1_ < this.FHallowmasActive3.IceList.length)
            {
               this.FHallowmasActive3.IceList[_loc1_] = 0;
               _loc1_++;
            }
            FMC_Scene.MC_Movie3.visible = false;
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

