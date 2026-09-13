package Processors.Game.Lobby.Exercise.FebActive
{
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.DessertHouse.TDessertHouseTask;
   import Logics.Exercise.FebActive.TFebActive3;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIShowItem;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.setTimeout;
   import ghostcat.util.easing.TweenUtil;
   
   public class TUIFebActive3 extends TUIBaseWindow
   {
      
      protected static const ACTIVITY_3_ID:int = 3;
      
      protected static const BOSS_COUNT:int = 3;
      
      protected static const SHOW_ITEM_COUNT:int = 3;
      
      public static const MOVIE_OF_WAITING:int = 0;
      
      public static const MOVIE_TYPE_BEAT_BOSS:int = 1;
      
      public static const MOVIE_TYPE_BOSS_DIED:int = 2;
      
      public static const MOVIE_TYPE_REFRESH_BOSS:int = 3;
      
      public static const MOVIE_TYPE_USE_BOMB0:int = 4;
      
      public static const MOVIE_TYPE_USE_BOMB1:int = 5;
      
      protected var FFebActive3:TFebActive3;
      
      protected var FIsFirst:Boolean;
      
      protected var FMovieType:int;
      
      protected var FFrameCount:int;
      
      protected var FIsCD:Boolean;
      
      protected var FTF_Time:TextField;
      
      protected var FTF_ResetTime:TextField;
      
      protected var FMC_Mask:MovieClip;
      
      protected var FBarMaxWidth:int;
      
      protected var FShowItem:TUIShowItem;
      
      protected var FBossIndex:int;
      
      protected var FUI_Task:MovieClip;
      
      protected var FBTN_CloseTask:SimpleButton;
      
      protected var FIsTaskVisible:Boolean;
      
      protected var FProcessorFebActiveShop:TProcessorFebActiveShop;
      
      public function TUIFebActive3(param1:TUIComponent)
      {
         super(param1);
         this.FIsFirst = true;
      }
      
      override protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TUIShowItem = null;
         var _loc5_:MovieClip = null;
         var _loc6_:MovieClip = null;
         var _loc7_:MovieClip = null;
         super.Resources_UIDispatch(param1);
         this.FTF_Time = FMC_Scene.TF_Time;
         this.FTF_ResetTime = FMC_Scene.TF_ResetTime;
         _loc2_ = 0;
         while(_loc2_ < BOSS_COUNT)
         {
            FMC_Scene["MC_Icon" + _loc2_].buttonMode = true;
            FMC_Scene["MC_Icon" + _loc2_].gotoAndStop(_loc2_ + 1);
            FMC_Scene["MC_Icon" + _loc2_].addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnIconOver);
            FMC_Scene["MC_Icon" + _loc2_].addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < BOSS_COUNT)
         {
            FMC_Scene["MC_KillGift" + _loc2_].buttonMode = true;
            FMC_Scene["MC_KillGift" + _loc2_].MC_Box.MC_Icon.gotoAndStop(_loc2_ + 1);
            FMC_Scene["MC_KillGift" + _loc2_].addEventListener(MouseEvent.CLICK,this.ProcessorOnGetKillGiftUp);
            FMC_Scene["MC_KillGift" + _loc2_].addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnKillGiftOver);
            FMC_Scene["MC_KillGift" + _loc2_].addEventListener(MouseEvent.ROLL_OUT,ProcessorOnNewBoxOut);
            _loc2_++;
         }
         this.FUI_Task = FMC_Scene["MC_TaskUI"];
         this.FUI_Task.visible = false;
         this.FBTN_CloseTask = FMC_Scene["MC_TaskUI"]["BTN_Close"];
         this.FBTN_CloseTask.addEventListener(MouseEvent.CLICK,this.ProcessorOnCloseTask);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Task,true);
         FMC_Scene.BTN_Task.addEventListener(MouseEvent.CLICK,this.ProcessorOnOpenTask);
         _loc2_ = 0;
         while(_loc2_ < ACT_TASK_COUNT)
         {
            if(Boolean(this.FUI_Task) && Boolean(this.FUI_Task["MC_Task" + _loc2_]))
            {
               _loc7_ = this.FUI_Task["MC_Task" + _loc2_];
               _loc7_.MC_Reward.gotoAndStop(_loc2_ + 1);
               TGameUtil.setButtonMode(_loc7_.BTN_Go,true);
               _loc7_.BTN_Go.addEventListener(MouseEvent.CLICK,this.ProcessorOnGoTaskUp);
               TGameUtil.setButtonMode(_loc7_.BTN_GetTask,true);
               _loc7_.BTN_GetTask.addEventListener(MouseEvent.CLICK,this.ProcessorOnAcceptTaskUp);
               TGameUtil.setButtonMode(_loc7_.BTN_Finish,true);
               _loc7_.BTN_Finish.addEventListener(MouseEvent.CLICK,this.ProcessorOnFinishTaskUp);
               _loc7_.MC_Reward.addEventListener(MouseEvent.MOUSE_MOVE,ProcessorOnGetTaskRewardOver);
               _loc7_.MC_Reward.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnNewBoxOut);
            }
            _loc2_++;
         }
         this.FShowItem = new TUIShowItem(this,SHOW_ITEM_COUNT);
         this.FShowItem.Perform_UIDispatch(FMC_Scene.MC_ShowItems);
         this.FShowItem.OnOverlay = this.ProcessorOnItemOver;
         this.FShowItem.OnOut = this.ProcessorOnItemOut;
         this.FShowItem.OnShowRecruit = this.ProcessorOnShowRecruit;
         FMC_Scene.MC_Boss.MC_RefreshMovie.visible = false;
         FMC_Scene.MC_Boss.MC_BeatMovie.visible = false;
         FMC_Scene.MC_Boss.MC_Bomb0.visible = false;
         FMC_Scene.MC_Boss.MC_Bomb1.visible = false;
         this.FMC_Mask = FMC_Scene.MC_Boss.MC_Bar.MC_Mask;
         this.FBarMaxWidth = this.FMC_Mask.width;
         FMC_Scene.MC_Tip0.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnTip0Over);
         FMC_Scene.MC_Tip0.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
         FMC_Scene.MC_Tip1.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnTip1Over);
         FMC_Scene.MC_Tip1.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
         FMC_Scene.MC_Boss.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnBossTipOver);
         FMC_Scene.MC_Boss.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Attack0,true);
         FMC_Scene.BTN_Attack0.addEventListener(MouseEvent.CLICK,this.ProcessorOnAttack0Up);
         FMC_Scene.BTN_AttackTip0.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnAttack0Over);
         FMC_Scene.BTN_AttackTip0.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Attack1,true);
         FMC_Scene.BTN_Attack1.addEventListener(MouseEvent.CLICK,this.ProcessorOnAttack1Up);
         FMC_Scene.BTN_AttackTip1.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnAttack1Over);
         FMC_Scene.BTN_AttackTip1.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
         FMC_Scene.MC_BombTip.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnBombTipver);
         FMC_Scene.MC_BombTip.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Exchange,true);
         FMC_Scene.BTN_Exchange.addEventListener(MouseEvent.CLICK,this.ProcessorOnExchangeUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Get,true);
         FMC_Scene.BTN_Get.addEventListener(MouseEvent.CLICK,this.ProcessorOnGetGiftUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Back,true);
         FMC_Scene.BTN_Back.addEventListener(MouseEvent.CLICK,this.ProcessorOnBackUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Desc,true);
         FMC_Scene.BTN_Desc.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowDesc);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Log,true);
         FMC_Scene.BTN_Log.addEventListener(MouseEvent.CLICK,this.ProcessorOnLoadLog);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Rank,true);
         FMC_Scene.BTN_Rank.addEventListener(MouseEvent.CLICK,this.ProcessorOnLoadRank);
         this.FProcessorFebActiveShop = new TProcessorFebActiveShop(this.Parent);
         this.FProcessorFebActiveShop.Visible = false;
         this.FProcessorFebActiveShop.OnCloseUp = this.ProcessorOnCloseShop;
         this.FProcessorFebActiveShop.OnOverlay = this.ProcessorOnItemOver;
         this.FProcessorFebActiveShop.OnOut = this.ProcessorOnItemOut;
         this.FProcessorFebActiveShop.OnExchange = this.ProcessorOnExchangeItem;
         this.FProcessorFebActiveShop.X = -61;
         this.FProcessorFebActiveShop.y = 0;
      }
      
      protected function UpdateBoss() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < BOSS_COUNT)
         {
            if(_loc1_ == this.FFebActive3.BossIndex - 1)
            {
               FMC_Scene["MC_Icon" + _loc1_].MC_Select.visible = true;
               FMC_Scene["MC_Icon" + _loc1_].MC_Icon.gotoAndStop(_loc1_ + 1);
            }
            else
            {
               FMC_Scene["MC_Icon" + _loc1_].MC_Select.visible = false;
               FMC_Scene["MC_Icon" + _loc1_].MC_Icon.gotoAndStop(_loc1_ + 1 + BOSS_COUNT);
            }
            _loc1_++;
         }
         FMC_Scene.MC_Boss.MC_KillMovie.gotoAndStop(this.FFebActive3.BossIndex);
         FMC_Scene.MC_Boss.MC_KillMovie.visible = true;
         FMC_Scene.MC_Boss.MC_RefreshMovie.visible = false;
         FMC_Scene.MC_Boss.MC_BeatMovie.visible = false;
         _loc4_ = this.FFebActive3.BossList[this.FFebActive3.BossIndex - 1];
         FMC_Scene.MC_Boss.MC_Bar.TF_Count.text = this.FFebActive3.BossHp + "/" + _loc4_;
         _loc2_ = Number(this.FFebActive3.BossHp / _loc4_) * this.FBarMaxWidth;
         _loc3_ = Math.min(_loc2_,this.FBarMaxWidth);
         this.FMC_Mask.width = _loc3_;
      }
      
      protected function UpdateBox() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         var _loc3_:TBaseBox = null;
         _loc1_ = 0;
         while(_loc1_ < BOSS_COUNT)
         {
            _loc2_ = FMC_Scene["MC_KillGift" + _loc1_];
            _loc3_ = this.FFebActive3.KillGift[_loc1_];
            _loc2_.TF_Count.text = _loc3_.Count.toString();
            if(_loc3_.Count > 0)
            {
               _loc2_.MC_Box.gotoAndPlay(1);
               _loc2_.MC_Click.visible = true;
            }
            else
            {
               _loc2_.MC_Box.gotoAndStop(1);
               _loc2_.MC_Click.visible = false;
            }
            _loc1_++;
         }
      }
      
      protected function UpdateTaskUI() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:TDessertHouseTask = null;
         _loc1_ = 0;
         while(_loc1_ < ACT_TASK_COUNT)
         {
            _loc4_ = this.FUI_Task["MC_Task" + _loc1_];
            if(_loc1_ < FActTaskData.TaskList.length)
            {
               _loc4_.visible = true;
               _loc5_ = FActTaskData.TaskList[_loc1_];
               _loc3_ = _loc5_.Step >= ACT_TASK_STEP ? int(ACT_TASK_STEP - 1) : _loc5_.Step;
               _loc4_.TF_Desc.text = TUtilityString.Format(_loc5_.TaskDesc,_loc5_.TaskReq[_loc3_]);
               _loc4_.TF_Process.text = _loc5_.Process + "/" + _loc5_.ClientTaskReq[_loc3_];
               if(_loc5_.Status == TBaseActivity.STATUS_CANNOTGET)
               {
                  _loc4_.BTN_Finish.visible = false;
                  _loc4_.BTN_GetTask.visible = true;
                  _loc4_.MC_Finish.visible = false;
               }
               else if(_loc5_.Status == TBaseActivity.STATUS_CANGET)
               {
                  _loc4_.BTN_Finish.visible = true;
                  _loc4_.BTN_GetTask.visible = false;
                  _loc4_.MC_Finish.visible = false;
                  if(_loc5_.Process >= _loc5_.ClientTaskReq[_loc3_])
                  {
                     TGameUtil.setButtonMode(_loc4_.BTN_Finish,true);
                  }
                  else
                  {
                     TGameUtil.setButtonMode(_loc4_.BTN_Finish,false);
                  }
               }
               else if(_loc5_.Status == TBaseActivity.STATUS_GETED)
               {
                  _loc4_.BTN_Finish.visible = false;
                  _loc4_.BTN_GetTask.visible = false;
                  _loc4_.MC_Finish.visible = true;
               }
            }
            else
            {
               _loc4_.visible = false;
            }
            _loc1_++;
         }
      }
      
      protected function UpdateBtns() : void
      {
         TGameUtil.setButtonMode(FMC_Scene.BTN_Get,!this.FIsCD);
      }
      
      protected function UpdateShowItems() : void
      {
         this.FShowItem.UpdateUI(this.FFebActive3.ShowItems);
      }
      
      protected function UpdateText() : void
      {
         FMC_Scene.TF_Desc.text = this.FFebActive3.DescListNew[1];
         FMC_Scene.TF_ScoreB.text = this.FFebActive3.RankPoint.toString();
         FMC_Scene.TF_ScoreA.text = this.FFebActive3.ScoreA.toString();
      }
      
      override protected function ProcessorOnGoTaskUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TDessertHouseTask = null;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(FOnGoto != null && _loc2_ < FActTaskData.TaskList.length)
         {
            FOnCloseWindow();
            _loc3_ = FActTaskData.TaskList[_loc2_];
            FOnGoto(_loc3_.Go);
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
            FOnGetBox(ACTIVITY_3_ID,TProcessorFebActive.ACTIVITY_3_GET_TASK,_loc3_.Identify);
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
            FOnGetBox(ACTIVITY_3_ID,TProcessorFebActive.ACTIVITY_3_FINISH_TASK,_loc3_.Identify);
         }
      }
      
      protected function ProcessorOnGetGiftUp(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(!FIsPlaying && FOnGetBox != null)
         {
            FOnGetBox(ACTIVITY_3_ID,TProcessorFebActive.ACTIVITY_3_GET_GIFT);
         }
      }
      
      protected function ProcessorOnGetKillGiftUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(11));
         if(Boolean(!FIsPlaying && FOnGetBox != null && this.FFebActive3) && Boolean(_loc2_ < this.FFebActive3.KillGift.length) && this.FFebActive3.KillGift[_loc2_].Count > 0)
         {
            FOnGetBox(ACTIVITY_3_ID,TProcessorFebActive.ACTIVITY_3_GET_BOX,_loc2_ + 1);
         }
      }
      
      protected function ProcessorOnAttack0Up(param1:MouseEvent) : void
      {
         if(!FIsPlaying && FOnGetBox != null && Boolean(this.FFebActive3))
         {
            if(this.FFebActive3.ScoreA > 0)
            {
               FOnGetBox(ACTIVITY_3_ID,TProcessorFebActive.ACTIVITY_3_USE_ITEM);
            }
            else
            {
               FOnBuyBox(ACTIVITY_3_ID,TProcessorFebActive.ACTIVITY_3_USE_ITEM,this.FFebActive3.ScorePrice);
            }
         }
      }
      
      protected function ProcessorOnAttack1Up(param1:MouseEvent) : void
      {
         if(!FIsPlaying && FOnBuyBox != null && Boolean(this.FFebActive3))
         {
            FOnBuyBox(ACTIVITY_3_ID,TProcessorFebActive.ACTIVITY_3_USE_GOLD,this.FFebActive3.BombCost);
         }
      }
      
      protected function ProcessorOnExchangeItem(param1:int) : void
      {
         if(!FIsPlaying && FOnGetBox != null && Boolean(this.FFebActive3))
         {
            FOnGetBox(ACTIVITY_3_ID,TProcessorFebActive.ACTIVITY_3_EXCHANGE_ITEM,param1 + 1);
         }
      }
      
      protected function ProcessorOnExchangeUp(param1:MouseEvent) : void
      {
         this.FProcessorFebActiveShop.Visible = true;
         this.FProcessorFebActiveShop.UpdateUI(this.FFebActive3);
      }
      
      protected function ProcessorOnCloseShop() : void
      {
         this.FProcessorFebActiveShop.Visible = false;
      }
      
      protected function ProcessorOnOpenTask(param1:MouseEvent) : void
      {
         this.FUI_Task.visible = true;
         this.FIsTaskVisible = true;
         this.UpdateTaskUI();
      }
      
      protected function ProcessorOnCloseTask(param1:MouseEvent) : void
      {
         this.FUI_Task.visible = false;
         this.FIsTaskVisible = false;
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
      
      protected function ProcessorOnKillGiftOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(11));
         if(FOnNewBoxOver != null && Boolean(this.FFebActive3))
         {
            FOnNewBoxOver(this.FFebActive3.KillGift[_loc2_].Inventories);
         }
      }
      
      protected function ProcessorOnAttack0Over(param1:MouseEvent) : void
      {
         if(FOnShowHtmlTip != null)
         {
            FOnShowHtmlTip(this.FFebActive3.DescListNew[5]);
         }
      }
      
      protected function ProcessorOnAttack1Over(param1:MouseEvent) : void
      {
         if(FOnShowHtmlTip != null)
         {
            FOnShowHtmlTip(this.FFebActive3.DescListNew[6]);
         }
      }
      
      protected function ProcessorOnBombTipver(param1:MouseEvent) : void
      {
         if(FOnShowHtmlTip != null)
         {
            FOnShowHtmlTip(this.FFebActive3.DescListNew[10]);
         }
      }
      
      protected function ProcessorOnIconOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(7));
         if(FOnShowHtmlTip != null)
         {
            FOnShowHtmlTip(this.FFebActive3.DescListNew[2 + _loc2_]);
         }
      }
      
      protected function ProcessorOnBossTipOver(param1:MouseEvent) : void
      {
         if(FOnShowHtmlTip != null)
         {
            FOnShowHtmlTip(this.FFebActive3.DescListNew[2 + this.FFebActive3.BossIndex - 1]);
         }
      }
      
      protected function ProcessorOnTip0Over(param1:MouseEvent) : void
      {
         if(FOnShowHtmlTip != null)
         {
            FOnShowHtmlTip(this.FFebActive3.DescListNew[7]);
         }
      }
      
      protected function ProcessorOnTip1Over(param1:MouseEvent) : void
      {
         if(FOnShowHtmlTip != null)
         {
            FOnShowHtmlTip(this.FFebActive3.DescListNew[8]);
         }
      }
      
      protected function ProcessorOnBackUp(param1:MouseEvent) : void
      {
         if(FOnShowWindow != null)
         {
            FOnShowWindow(TProcessorFebActive.WINDOW_HOME);
         }
      }
      
      protected function ProcessorOnLoadLog(param1:MouseEvent) : void
      {
         if(FOnLoadLog != null)
         {
            FOnLoadLog(ACTIVITY_3_ID);
         }
      }
      
      protected function ProcessorOnLoadRank(param1:MouseEvent) : void
      {
         if(FOnLoadRank != null)
         {
            FOnLoadRank();
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
         var _loc2_:int = 0;
         if(FInitialized && this.visible && FMC_Scene.visible)
         {
            _loc2_ = this.FFebActive3.FirecrackerTime - STimingCore.GetServerTick();
            this.FTF_Time.text = TGameUtil.fomatTime(_loc2_);
            if(_loc2_ <= 0 && this.FIsCD || _loc2_ > 0 && !this.FIsCD)
            {
               this.FIsCD = _loc2_ <= 0 ? false : true;
               this.UpdateBtns();
            }
            _loc2_ = this.FFebActive3.ResetTime - STimingCore.GetServerTick();
            this.FTF_ResetTime.text = TGameUtil.fomatTime(_loc2_);
            if(this.FShowItem)
            {
               this.FShowItem.LogicsPerform();
            }
            if(FIsPlaying)
            {
               switch(this.FMovieType)
               {
                  case MOVIE_TYPE_BEAT_BOSS:
                     CurFrame = FMC_Scene.MC_Boss.MC_BeatMovie.currentFrame;
                     break;
                  case MOVIE_TYPE_BOSS_DIED:
                     return;
                  case MOVIE_TYPE_REFRESH_BOSS:
                     CurFrame = FMC_Scene.MC_Boss.MC_RefreshMovie.currentFrame;
                     break;
                  case MOVIE_TYPE_USE_BOMB0:
                     CurFrame = FMC_Scene.MC_Boss.MC_Bomb0.currentFrame;
                     break;
                  case MOVIE_TYPE_USE_BOMB1:
                     CurFrame = FMC_Scene.MC_Boss.MC_Bomb1.currentFrame;
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
         this.FFebActive3 = SLogicsCore.FebActiveDatas.GetActivityByIdentify(ACTIVITY_3_ID) as TFebActive3;
         FActTaskData = this.FFebActive3.ActivityTaskData;
         this.UpdateBoss();
         this.UpdateBtns();
         this.UpdateShowItems();
         this.UpdateBox();
         this.UpdateText();
         if(this.FIsFirst)
         {
            this.FIsFirst = false;
            this.FProcessorFebActiveShop.Load();
         }
         if(this.FProcessorFebActiveShop.Visible)
         {
            this.FProcessorFebActiveShop.UpdateUI(this.FFebActive3);
         }
         if(this.FIsTaskVisible)
         {
            this.UpdateTaskUI();
         }
      }
      
      override public function PlayMovie(param1:int = 0, param2:Boolean = false) : void
      {
         var _loc3_:MovieClip = null;
         this.FMovieType = param1;
         FIsPlaying = true;
         if(this.FMovieType == MOVIE_TYPE_BEAT_BOSS)
         {
            _loc3_ = FMC_Scene.MC_Boss.MC_BeatMovie;
            _loc3_.visible = true;
            FTotalFrame = _loc3_.totalFrames;
            _loc3_.gotoAndPlay(1);
         }
         else if(this.FMovieType == MOVIE_TYPE_USE_BOMB0)
         {
            _loc3_ = FMC_Scene.MC_Boss.MC_Bomb0;
            _loc3_.visible = true;
            FTotalFrame = _loc3_.totalFrames;
            _loc3_.gotoAndPlay(1);
         }
         else if(this.FMovieType == MOVIE_TYPE_USE_BOMB1)
         {
            _loc3_ = FMC_Scene.MC_Boss.MC_Bomb1;
            _loc3_.visible = true;
            FTotalFrame = _loc3_.totalFrames;
            _loc3_.gotoAndPlay(1);
         }
         else if(this.FMovieType == MOVIE_TYPE_BOSS_DIED)
         {
            _loc3_ = FMC_Scene.MC_Boss.MC_KillMovie;
            _loc3_.visible = true;
            _loc3_.gotoAndStop(this.FFebActive3.BossIndex + BOSS_COUNT);
            setTimeout(this.MovieEnd,500);
         }
         else if(this.FMovieType == MOVIE_TYPE_REFRESH_BOSS)
         {
            _loc3_ = FMC_Scene.MC_Boss.MC_RefreshMovie;
            FTotalFrame = _loc3_.totalFrames;
            _loc3_.visible = true;
            _loc3_.gotoAndPlay(1);
         }
      }
      
      override public function MovieEnd() : void
      {
         FIsPlaying = false;
         if(this.FMovieType == MOVIE_TYPE_BEAT_BOSS)
         {
            FMC_Scene.MC_Boss.MC_BeatMovie.visible = false;
            if(this.FFebActive3.BossHp <= 0)
            {
               this.PlayMovie(MOVIE_TYPE_BOSS_DIED);
            }
            else
            {
               this.UpdateUI();
            }
         }
         else if(this.FMovieType == MOVIE_TYPE_USE_BOMB0)
         {
            FMC_Scene.MC_Boss.MC_Bomb0.visible = false;
            this.PlayMovie(MOVIE_TYPE_BEAT_BOSS);
         }
         else if(this.FMovieType == MOVIE_TYPE_USE_BOMB1)
         {
            FMC_Scene.MC_Boss.MC_Bomb1.visible = false;
            this.PlayMovie(MOVIE_TYPE_BEAT_BOSS);
         }
         else if(this.FMovieType == MOVIE_TYPE_REFRESH_BOSS)
         {
            this.FFebActive3.BossIndex = this.FBossIndex;
            this.FFebActive3.BossHp = this.FFebActive3.BossList[this.FBossIndex - 1];
            this.UpdateUI();
         }
         else if(this.FMovieType == MOVIE_TYPE_BOSS_DIED)
         {
            this.PlayMovie(MOVIE_TYPE_REFRESH_BOSS);
         }
      }
      
      override public function Unmount() : void
      {
         var _loc1_:int = 0;
         TweenUtil.removeAllTween();
         this.FUI_Task.visible = false;
         this.FIsTaskVisible = false;
      }
      
      override public function SetMovieParam(param1:int = 0, param2:int = 0, param3:int = 0) : void
      {
         this.FBossIndex = param1;
      }
   }
}

