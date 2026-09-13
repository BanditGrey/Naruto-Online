package Processors.Game.Lobby.Exercise.FateRoulette
{
   import Components.Pages.TUIPage;
   import Foundation.Network.TPacket;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Characters.TCharacter;
   import Logics.Exercise.DessertHouse.TDessertHouseTask;
   import Logics.Exercise.FateRoulette.TFateRoulette;
   import Logics.Exercise.TActivityTaskData;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Exercise.TUnstreamizerFateRoulette;
   import Logics.Streamization.Title.TUnstreamizerTitle;
   import Logics.Title.TTitle;
   import Logics.Title.TTitles;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseBox;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIShowItem;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorBaseActivity;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorWindowTitleDesc;
   import Rendering.Overlayers.Title.TOverlayerTitle;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Strings.STRING_BASEACTIVITY;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   import ghostcat.util.easing.Expo;
   import ghostcat.util.easing.TweenUtil;
   
   public class TProcessorFateRoulette extends TProcessorBaseActivity
   {
      
      protected static const ACT_TASK_COUNT:int = 5;
      
      protected static const ACT_TASK_STEP:int = TActivityTaskData.STEP_COUNT;
      
      protected static const BOX_COUNT:int = 6;
      
      protected static const EXCHANGE_BOX_COUNT:int = 3;
      
      protected static const BALL_COUNT:int = 10;
      
      protected static const REWARD_COUNT:int = 8;
      
      protected static const SHOW_ITEM_COUNT:int = 10;
      
      protected static const ITEM_COUNT:int = 3;
      
      protected static const GIFT_COUNT:int = 3;
      
      protected static const ROTATION_COUNT:int = 2;
      
      protected static const RANDOM_COUNT:int = 2;
      
      public static const MOVIE_OF_PLAY_GAME:int = 1;
      
      public static const MOVIE_OF_AUTO_GAME:int = 2;
      
      public static const MOVIE_OF_FLOW:int = 3;
      
      public static const ACTIVITY_2_PLAY_GAME:int = 1;
      
      public static const ACTIVITY_2_GET_SCORE:int = 2;
      
      public static const ACTIVITY_2_AUTO_GAME:int = 3;
      
      public static const ACTIVITY_1_EXCHANGE_ITEM:int = 4;
      
      public static const ACTIVITY_2_GET_TITLE:int = 5;
      
      public static const ACTIVITY_2_GET_GIFT:int = 6;
      
      public static const ACTIVITY_1_GET_TASK:int = 7;
      
      public static const ACTIVITY_1_FINISH_TASK:int = 8;
      
      protected var FFateRoulette:TFateRoulette;
      
      protected var FActTaskData:TActivityTaskData;
      
      protected var FUnstreamizerFateRoulette:TUnstreamizerFateRoulette;
      
      protected var FBeClicked:Boolean;
      
      protected var FIsOpen:Boolean;
      
      protected var FBuyBoxDate:Object;
      
      protected var FCost:int;
      
      protected var FIsPlaying:Boolean;
      
      protected var FWindowType:int;
      
      protected var FMovieType:int;
      
      protected var FOpenIndex:int;
      
      protected var FFrameCount:int;
      
      protected var FTotalFrame:int;
      
      protected var FPlayMovie:MovieClip;
      
      protected var FBoxList:Vector.<MovieClip>;
      
      protected var FExchangeList:Vector.<TUIBaseBox>;
      
      protected var FShowItem:TUIShowItem;
      
      protected var FUIPage:TUIPage;
      
      protected var FTotalPage:int;
      
      protected var FCurPage:int;
      
      protected var FRewardIndex:int;
      
      protected var FFlowStr:String;
      
      protected var FProcessorFebActiveShop:TProcessorFateRouletteShop;
      
      protected var FProcessorWindowTitleDesc:TProcessorWindowTitleDesc;
      
      protected var FOverlayerTitle:TOverlayerTitle;
      
      protected var FAllTitles:TTitles;
      
      protected var FUnstreamizerTitle:TUnstreamizerTitle;
      
      public function TProcessorFateRoulette(param1:TUIComponent, param2:TLobbyParameters, param3:uint)
      {
         super(param1,param2,param3);
         FActivityID = param3;
         this.FFateRoulette = SLogicsCore.FateRoulette;
         this.FActTaskData = this.FFateRoulette.ActivityTaskData;
         this.FUnstreamizerFateRoulette = new TUnstreamizerFateRoulette(param3);
         this.FBuyBoxDate = new Object();
         this.FBoxList = new Vector.<MovieClip>(BOX_COUNT);
         this.FExchangeList = new Vector.<TUIBaseBox>(EXCHANGE_BOX_COUNT);
         this.FUIPage = new TUIPage(this);
         this.FProcessorFebActiveShop = new TProcessorFateRouletteShop(this.Parent);
         this.FProcessorWindowTitleDesc = new TProcessorWindowTitleDesc(this.Parent);
         this.FOverlayerTitle = new TOverlayerTitle(this.Parent);
         this.FOverlayerTitle.Visible = false;
         this.FUnstreamizerTitle = new TUnstreamizerTitle();
         this.FAllTitles = new TTitles();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:MovieClip = null;
         super.ResourcesPerform_UIDispatch();
         _loc1_ = 0;
         while(_loc1_ < BOX_COUNT)
         {
            this.FBoxList[_loc1_] = FMC_Scene["MC_Box" + _loc1_];
            this.FBoxList[_loc1_].buttonMode = true;
            this.FBoxList[_loc1_].addEventListener(MouseEvent.CLICK,this.ProcessorOnConsumeBoxUp);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < GIFT_COUNT)
         {
            FMC_Scene["MC_Gift" + _loc1_].buttonMode = true;
            FMC_Scene["MC_Gift" + _loc1_].addEventListener(MouseEvent.CLICK,this.ProcessorOnGiftUp);
            FMC_Scene["MC_Gift" + _loc1_].addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnGiftOver);
            FMC_Scene["MC_Gift" + _loc1_].addEventListener(MouseEvent.ROLL_OUT,ProcessorOnNewBoxOut);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < ACT_TASK_COUNT)
         {
            if(Boolean(FMC_Scene) && Boolean(FMC_Scene["MC_Task" + _loc1_]))
            {
               _loc5_ = FMC_Scene["MC_Task" + _loc1_];
               _loc5_.MC_Reward.gotoAndStop(_loc1_ + 1);
               TGameUtil.setButtonMode(_loc5_.BTN_Go,true);
               _loc5_.BTN_Go.addEventListener(MouseEvent.CLICK,this.ProcessorOnGoTaskUp);
               TGameUtil.setButtonMode(_loc5_.BTN_GetTask,true);
               _loc5_.BTN_GetTask.addEventListener(MouseEvent.CLICK,this.ProcessorOnAcceptTaskUp);
               TGameUtil.setButtonMode(_loc5_.BTN_Finish,true);
               _loc5_.BTN_Finish.addEventListener(MouseEvent.CLICK,this.ProcessorOnFinishTaskUp);
               _loc5_.MC_Reward.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnGetTaskRewardOver);
               _loc5_.MC_Reward.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnNewBoxOut);
            }
            _loc1_++;
         }
         this.FShowItem = new TUIShowItem(this,ITEM_COUNT);
         this.FShowItem.Perform_UIDispatch(FMC_Scene.MC_ShowItems);
         this.FShowItem.OnOverlay = UIComponentsHintOnOver;
         this.FShowItem.OnOut = UIComponentsHintOnOut;
         this.FShowItem.OnShowRecruit = ProcessorOnShowItemDesc;
         FMC_Scene.MC_Movie0.visible = false;
         FMC_Scene.MC_AutoLog.visible = false;
         FMC_Scene.MC_AutoLog.Btn_Close.addEventListener(MouseEvent.CLICK,this.ProcessorOnCloseLogUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Play,true);
         FMC_Scene.BTN_Play.addEventListener(MouseEvent.CLICK,this.ProcessorOnStartUp);
         FMC_Scene.BTN_Play.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnStartOver);
         FMC_Scene.BTN_Play.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlText);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Auto,true);
         FMC_Scene.BTN_Auto.addEventListener(MouseEvent.CLICK,this.ProcessorOnAutoUp);
         FMC_Scene.BTN_Auto.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnAutoOver);
         FMC_Scene.BTN_Auto.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlText);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Get,true);
         FMC_Scene.BTN_Get.addEventListener(MouseEvent.CLICK,this.ProcessorOnGetGiftUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Next,true);
         FMC_Scene.BTN_Next.addEventListener(MouseEvent.CLICK,this.ProcessorOnNextUp);
         this.FProcessorFebActiveShop.Visible = false;
         this.FProcessorFebActiveShop.OnCloseUp = this.ProcessorOnCloseShop;
         this.FProcessorFebActiveShop.OnOverlay = UIComponentsHintOnOver;
         this.FProcessorFebActiveShop.OnOut = UIComponentsHintOnOut;
         this.FProcessorFebActiveShop.OnExchange = this.ProcessorOnExchangeItem;
         this.FProcessorWindowTitleDesc.OnCloseUp = this.ProcessorOnHideWindow;
         this.FProcessorWindowTitleDesc.TitleHintOnOver = this.ProcessorOnTitleOver;
         this.FProcessorWindowTitleDesc.TitleHintOnOut = this.ProcessorOnTitleOut;
         this.FProcessorWindowTitleDesc.Visible = false;
         this.FUnstreamizerTitle.UnstreamizeTitleByDatabase(null,this.FAllTitles,null);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerTitle);
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
         TGameUtil.setButtonMode(FMC_Scene.BTN_Exchange,true);
         FMC_Scene.BTN_Exchange.addEventListener(MouseEvent.CLICK,this.ProcessorOnExchangeUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Desc,true);
         FMC_Scene.BTN_Desc.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowDesc);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Log,true);
         FMC_Scene.BTN_Log.addEventListener(MouseEvent.CLICK,this.ProcessorOnLoadLog);
         TGameUtil.setButtonMode(FMC_Scene.BTN_TitleDesc,true);
         FMC_Scene.BTN_TitleDesc.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowTitleDesc);
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         super.LogicsPerform();
         if(Boolean(FMC_Scene) && FMC_Scene.visible)
         {
            if(this.FShowItem)
            {
               this.FShowItem.LogicsPerform();
            }
            if(this.FIsPlaying)
            {
               switch(this.FMovieType)
               {
                  case MOVIE_OF_FLOW:
                     _loc2_ = int(FMC_Scene.MC_Movie0.currentFrame);
                     break;
                  case MOVIE_OF_PLAY_GAME:
                     return;
               }
               if(_loc2_ == this.FTotalFrame)
               {
                  this.FIsPlaying = false;
                  this.FFrameCount = 0;
                  this.MovieEnd();
               }
               else
               {
                  ++this.FFrameCount;
                  if(this.FFrameCount > 100)
                  {
                     this.FIsPlaying = false;
                     this.FFrameCount = 0;
                     this.UpdateUI();
                  }
               }
            }
         }
      }
      
      override protected function UpdateUI() : void
      {
         this.UpdateTaskView();
         this.UpdateBox();
         this.UpdateGame();
         this.UpdateItem();
         this.UpdateText();
         if(this.FProcessorFebActiveShop.Visible)
         {
            this.FProcessorFebActiveShop.UpdateUI(this.FFateRoulette);
         }
      }
      
      protected function UpdateTaskView() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:TDessertHouseTask = null;
         _loc1_ = 0;
         while(_loc1_ < ACT_TASK_COUNT)
         {
            _loc4_ = FMC_Scene["MC_Task" + _loc1_];
            if(_loc1_ < this.FActTaskData.TaskList.length)
            {
               _loc4_.visible = true;
               _loc5_ = this.FActTaskData.TaskList[_loc1_];
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
            if(_loc2_ < this.FFateRoulette.BoxList.length)
            {
               _loc4_.visible = true;
               _loc5_ = this.FFateRoulette.BoxList[_loc2_];
               _loc4_.TF_Price.text = TUtilityString.Format(this.FFateRoulette.DescListNew[2],_loc5_.Price);
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
         _loc1_ = 0;
         while(_loc1_ < GIFT_COUNT)
         {
            _loc4_ = FMC_Scene["MC_Gift" + _loc1_];
            _loc5_ = this.FFateRoulette.GiftList[_loc1_];
            _loc4_.TF_Price.text = TUtilityString.Format(this.FFateRoulette.DescListNew[18],_loc5_.Price);
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
            _loc1_++;
         }
      }
      
      protected function UpdateGame() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < BALL_COUNT)
         {
            FMC_Scene.MC_Game["MC_Icon" + _loc1_].TF_Num.text = this.FFateRoulette.BallList[_loc1_].toString();
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < REWARD_COUNT)
         {
            FMC_Scene["MC_Icon" + _loc1_].TF_Num.text = this.FFateRoulette.DescListNew[10 + _loc1_];
            FMC_Scene["MC_Icon" + _loc1_].TF_Count.text = this.FFateRoulette.GameReward[_loc1_].Count.toString();
            if(_loc1_ == this.FFateRoulette.RewardIndex - 1)
            {
               FMC_Scene["MC_Icon" + _loc1_].MC_Select.visible = true;
            }
            else
            {
               FMC_Scene["MC_Icon" + _loc1_].MC_Select.visible = false;
            }
            _loc1_++;
         }
         if(this.FFateRoulette.GameStatus == TBaseActivity.STATUS_CANNOTGET)
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
            _loc4_ = this.FFateRoulette.AutoLog[_loc1_];
            _loc3_ = _loc1_ + 1;
            _loc2_.TF_Num.text = _loc3_.toString();
            _loc2_.TF_Count.text = _loc4_.Score.toString();
            _loc2_.TF_Desc.text = TUtilityString.Format(this.FFateRoulette.DescListNew[9],_loc4_.Reward);
            _loc1_++;
         }
      }
      
      protected function UpdateItem() : void
      {
         this.FShowItem.UpdateUI(this.FFateRoulette.ShowItems);
      }
      
      protected function UpdateText() : void
      {
         FMC_Scene.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FFateRoulette.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FFateRoulette.EndTime) - 1) * 1000)));
         FMC_Scene.TF_Desc.text = this.FFateRoulette.DescListNew[1];
         FMC_Scene.MC_Free.TF_Count.text = this.FFateRoulette.FreeCount.toString();
         FMC_Scene.MC_Score.TF_Count.text = this.FFateRoulette.ShopExchangePoint.toString();
         FMC_Scene.TF_RechargeGold.text = TUtilityString.Format(this.FFateRoulette.DescListNew[3],this.FFateRoulette.TotalConsumeGold);
         FMC_Scene.TF_GameValue.text = this.FFateRoulette.GameValue.toString();
      }
      
      override protected function PerformPacket_CS_LoadInfoReq() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:int = 0;
         super.PerformPacket_CS_LoadInfoReq();
      }
      
      protected function ProcessorOnGoTaskUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TDessertHouseTask = null;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(FOnGoto != null && _loc2_ < this.FActTaskData.TaskList.length)
         {
            this.ProcessorOnCloseWindow();
            _loc3_ = this.FActTaskData.TaskList[_loc2_];
            ProcessorOnGoto(_loc3_.Go);
         }
      }
      
      protected function ProcessorOnAcceptTaskUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TDessertHouseTask = null;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(!this.FIsPlaying && _loc2_ < this.FActTaskData.TaskList.length)
         {
            _loc3_ = this.FActTaskData.TaskList[_loc2_];
            this.ProcessorOnGetBoxUp(ACTIVITY_1_GET_TASK,_loc3_.Identify);
         }
      }
      
      protected function ProcessorOnFinishTaskUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TDessertHouseTask = null;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(!this.FIsPlaying && _loc2_ < this.FActTaskData.TaskList.length)
         {
            _loc3_ = this.FActTaskData.TaskList[_loc2_];
            this.ProcessorOnGetBoxUp(ACTIVITY_1_FINISH_TASK,_loc3_.Identify);
         }
      }
      
      protected function ProcessorOnGetTaskRewardOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TDessertHouseTask = null;
         var _loc5_:TInventories = null;
         var _loc6_:int = 0;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(_loc2_ < this.FActTaskData.TaskList.length)
         {
            _loc4_ = this.FActTaskData.TaskList[_loc2_];
            _loc6_ = Math.min(_loc4_.Step,ACT_TASK_STEP - 1);
            _loc5_ = _loc4_.TaskAward[_loc6_];
            ProcessorOnNewBoxOver(_loc5_);
         }
      }
      
      protected function ProcessorOnStartUp(param1:MouseEvent) : void
      {
         if(!this.FIsPlaying && Boolean(this.FFateRoulette))
         {
            if(this.FFateRoulette.FreeCount > 0)
            {
               this.ProcessorOnGetBoxUp(ACTIVITY_2_PLAY_GAME);
            }
            else
            {
               this.ProcessorOnBuyBoxUp(ACTIVITY_2_PLAY_GAME,this.FFateRoulette.ScorePrice);
            }
         }
      }
      
      protected function ProcessorOnAutoUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:int = 0;
         if(!this.FIsPlaying && Boolean(this.FFateRoulette))
         {
            _loc2_ = this.FFateRoulette.AutoPrice;
            _loc3_ = TUtilityString.Format(this.FFateRoulette.DescListNew[4],_loc2_);
            this.ProcessorOnBuyBoxUp(ACTIVITY_2_AUTO_GAME,_loc2_,0,0,_loc3_);
         }
      }
      
      protected function ProcessorOnNextUp(param1:MouseEvent) : void
      {
         if(!this.FIsPlaying && Boolean(this.FFateRoulette))
         {
            if(this.FFateRoulette.FreeCount > 0)
            {
               this.ProcessorOnGetBoxUp(ACTIVITY_2_PLAY_GAME);
            }
            else
            {
               this.ProcessorOnBuyBoxUp(ACTIVITY_2_PLAY_GAME,this.FFateRoulette.ScorePrice);
            }
         }
      }
      
      protected function ProcessorOnGetGiftUp(param1:MouseEvent) : void
      {
         if(!this.FIsPlaying && Boolean(this.FFateRoulette))
         {
            this.ProcessorOnGetBoxUp(ACTIVITY_2_GET_SCORE);
         }
      }
      
      protected function ProcessorOnConsumeBoxUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(6));
         if(Boolean(!this.FIsPlaying) && Boolean(this.FFateRoulette) && this.FFateRoulette.BoxList[_loc2_].Status == TBaseActivity.STATUS_CANGET)
         {
            this.ProcessorOnGetBoxUp(ACTIVITY_2_GET_GIFT,_loc2_ + 1);
         }
      }
      
      protected function ProcessorOnGiftUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(7));
         if(Boolean(!this.FIsPlaying) && Boolean(this.FFateRoulette) && this.FFateRoulette.GiftList[_loc2_].Status == TBaseActivity.STATUS_CANGET)
         {
            this.ProcessorOnGetBoxUp(ACTIVITY_2_GET_TITLE,_loc2_ + 1);
         }
      }
      
      protected function ProcessorOnGiftOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(7));
         if(this.FFateRoulette)
         {
            ProcessorOnNewBoxOver(this.FFateRoulette.GiftList[_loc2_].Inventories);
         }
      }
      
      protected function ProcessorOnExchangeItem(param1:int) : void
      {
         if(!this.FIsPlaying && Boolean(this.FFateRoulette))
         {
            this.ProcessorOnGetBoxUp(ACTIVITY_1_EXCHANGE_ITEM,param1 + 1);
         }
      }
      
      protected function ProcessorOnTitleOver(param1:uint) : void
      {
         var _loc2_:TTitle = null;
         _loc2_ = this.FAllTitles.GetTitleByIdentifier(param1);
         if(_loc2_ != null)
         {
            this.FOverlayerTitle.Context = _loc2_;
            this.FOverlayerTitle.Render(FUICore.MouseCoordinate);
            this.FOverlayerTitle.Show();
         }
      }
      
      protected function ProcessorOnTitleOut() : void
      {
         this.FOverlayerTitle.Hide();
      }
      
      protected function ProcessorOnCloseLogUp(param1:MouseEvent) : void
      {
         FMC_Scene.MC_AutoLog.visible = false;
      }
      
      protected function ProcessorOnAutoOver(param1:MouseEvent) : void
      {
         if(this.FFateRoulette)
         {
            ProcessorOnShowHtmlText(this.FFateRoulette.DescListNew[5]);
         }
      }
      
      protected function ProcessorOnStartOver(param1:MouseEvent) : void
      {
         if(Boolean(this.FFateRoulette) && this.FFateRoulette.DescListNew.length >= 6)
         {
            ProcessorOnShowHtmlText(this.FFateRoulette.DescListNew[6]);
         }
      }
      
      protected function ProcessorOnBuyBoxUp(param1:int, param2:int, param3:int = 0, param4:int = 0, param5:String = "", param6:int = 0, param7:int = 0) : void
      {
         if(this.FBeClicked || this.FIsPlaying)
         {
            return;
         }
         this.FBuyBoxDate.ActivityType = param1;
         this.FBuyBoxDate.BoxIndex = param3;
         this.FBuyBoxDate.Cost = param2;
         this.FBuyBoxDate.CostType = param4;
         this.FBuyBoxDate.BoxIndex1 = param6;
         this.FBuyBoxDate.ConfirmType = param7;
         if(param4 != TBaseActivity.SWEET_TYPE_GOLD)
         {
            this.ProcessorOnGetBoxUp(this.FBuyBoxDate.ActivityType,this.FBuyBoxDate.BoxIndex,this.FBuyBoxDate.BoxIndex1);
            return;
         }
         if(!FUIWindowConfirmation.IsSelected)
         {
            this.FCost = param2;
            if(param5 != "")
            {
               FUIWindowConfirmation.Text = param5;
            }
            else
            {
               FUIWindowConfirmation.Text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_ConfirmGold,this.FCost);
            }
            FUIWindowConfirmation.SetCheckBox(true);
            FUIWindowConfirmation.Visible = true;
         }
         else
         {
            this.WindowConfirmationOnOK();
         }
      }
      
      override protected function WindowConfirmationOnOK(param1:Object = null) : void
      {
         var _loc2_:TCharacter = null;
         _loc2_ = SLogicsCore.Character;
         if(_loc2_.CreditGold >= this.FBuyBoxDate.Cost)
         {
            this.ProcessorOnGetBoxUp(this.FBuyBoxDate.ActivityType,this.FBuyBoxDate.BoxIndex,this.FBuyBoxDate.BoxIndex1);
         }
         else
         {
            FUIWindowRecharge.Visible = true;
         }
      }
      
      protected function ProcessorOnGetBoxUp(param1:int, param2:int = 0, param3:int = 0) : void
      {
         var _loc4_:TPacket = null;
         var _loc5_:int = 0;
         var _loc6_:Vector.<int> = null;
         if(this.FBeClicked || this.FIsPlaying)
         {
            return;
         }
         this.FBeClicked = true;
         _loc6_ = new Vector.<int>();
         if(param2 != 0)
         {
            _loc6_.push(param2);
         }
         if(param3 != 0)
         {
            _loc6_.push(param3);
         }
         PerformPacket_CS_AllReq(param1,_loc6_);
      }
      
      protected function ProcessorOnExchangeUp(param1:MouseEvent) : void
      {
         this.FProcessorFebActiveShop.Visible = true;
         this.FProcessorFebActiveShop.UpdateUI(this.FFateRoulette);
      }
      
      protected function ProcessorOnCloseShop() : void
      {
         this.FProcessorFebActiveShop.Visible = false;
      }
      
      protected function ProcessorOnCloseWindow() : void
      {
         if(FOnClose != null)
         {
            FOnClose(this);
         }
      }
      
      protected function ProcessorOnShowDesc(param1:MouseEvent) : void
      {
         FProcessorWindowDesc.BaseActivity = this.FFateRoulette;
         super.ProcessorOnOpenDesc();
      }
      
      protected function ProcessorOnShowTitleDesc(param1:MouseEvent) : void
      {
         this.FProcessorWindowTitleDesc.Visible = true;
         this.FProcessorWindowTitleDesc.UpdateUI(this.FFateRoulette.TitleList);
      }
      
      protected function ProcessorOnLoadLog(param1:MouseEvent) : void
      {
         PerformPacket_CS_AcitivityThird_LoadLogReq(1,null);
      }
      
      protected function ProcessorOnHideWindow(param1:int = 0) : void
      {
         this.FWindowType = 0;
         switch(param1)
         {
            case WINDOW_TITLE_DESC:
               this.FProcessorWindowTitleDesc.Visible = false;
         }
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount(param1);
         if(!FIsResourcesLoadCompleted)
         {
            this.FProcessorFebActiveShop.Load();
            this.FProcessorWindowTitleDesc.Load();
            return;
         }
         this.visible = true;
         this.alpha = 1;
         this.FIsOpen = true;
         if(FMC_EffectLeft)
         {
            FMC_EffectLeft.play();
         }
         if(FMC_EffectRight)
         {
            FMC_EffectRight.play();
         }
         this.PerformPacket_CS_LoadInfoReq();
         SetInterval();
      }
      
      override public function Unmount() : void
      {
         super.Unmount();
         this.visible = false;
         this.FIsOpen = false;
      }
      
      override public function ProcessorOnLoadInfoRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            OnClose(this);
            return;
         }
         this.FUnstreamizerFateRoulette.Unstreamize(_loc2_,this.FFateRoulette,null);
         if(FIsResourcesLoadCompleted && this.visible)
         {
            this.UpdateUI();
         }
      }
      
      override public function ProcessorChangeGold(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         _loc2_ = param1.Data;
         _loc2_.readShort();
         if(this.FFateRoulette)
         {
            this.FFateRoulette.TotalConsumeGold = _loc2_.readUnsignedInt();
            this.FFateRoulette.ChangeStatus();
            ProcessorCheckEffect(FActivityID,this.FFateRoulette.CheckStatus());
            if(this.FIsOpen)
            {
               this.UpdateUI();
            }
         }
      }
      
      override public function ProcessorActivityThirdLoadLogRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:TBaseActivity = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            ProcessorClose();
            return;
         }
         _loc4_ = int(_loc2_.readUnsignedInt());
         ProcessorUnstreamActivityLog(this.FFateRoulette,_loc2_);
      }
      
      override public function ProcessorAllRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:TInventories = null;
         var _loc9_:TInventory = null;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:int = 0;
         var _loc13_:TBaseBox = null;
         var _loc14_:uint = 0;
         var _loc15_:TBins = null;
         var _loc16_:int = 0;
         var _loc17_:int = 0;
         var _loc18_:int = 0;
         var _loc19_:int = 0;
         var _loc20_:uint = 0;
         var _loc21_:Vector.<uint> = null;
         var _loc22_:Vector.<uint> = null;
         var _loc23_:String = null;
         var _loc24_:TDessertHouseTask = null;
         _loc15_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         this.FBeClicked = false;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc7_ = int(_loc2_.readUnsignedInt());
         _loc2_.readShort();
         switch(_loc7_)
         {
            case ACTIVITY_2_PLAY_GAME:
               this.FFateRoulette.GameStatus = TBaseActivity.STATUS_CANGET;
               if(this.FFateRoulette.FreeCount > 0)
               {
                  --this.FFateRoulette.FreeCount;
               }
               _loc5_ = _loc2_.readUnsignedInt() - 1;
               _loc12_ = this.FFateRoulette.BallList[_loc5_];
               this.FFlowStr = TUtilityString.Format(this.FFateRoulette.DescListNew[8],_loc12_);
               this.FFateRoulette.GameValue = _loc2_.readInt();
               this.FFateRoulette.RewardIndex = _loc2_.readUnsignedInt();
               this.FFateRoulette.ChangeStatus();
               this.FRewardIndex = _loc5_;
               this.PlayMovie(MOVIE_OF_PLAY_GAME);
               ProcessorCheckEffect(FActivityID,this.FFateRoulette.CheckStatus());
               break;
            case ACTIVITY_2_AUTO_GAME:
               _loc12_ = 0;
               _loc5_ = 0;
               while(_loc5_ < this.FFateRoulette.AutoLog.length)
               {
                  this.FFateRoulette.AutoLog[_loc5_] = new Object();
                  this.FFateRoulette.AutoLog[_loc5_].Reward = _loc2_.readInt();
                  this.FFateRoulette.AutoLog[_loc5_].Score = _loc2_.readInt();
                  _loc12_ += this.FFateRoulette.AutoLog[_loc5_].Reward;
                  _loc5_++;
               }
               if(_loc12_ > 0)
               {
                  this.FFlowStr = TUtilityString.Format(this.FFateRoulette.DescListNew[8],_loc12_);
               }
               this.FFateRoulette.MyScore += _loc12_;
               this.FFateRoulette.ShopExchangePoint += _loc12_;
               this.FFateRoulette.ChangeStatus();
               this.FRewardIndex = _loc12_;
               this.PlayMovie(MOVIE_OF_AUTO_GAME);
               ProcessorCheckEffect(FActivityID,this.FFateRoulette.CheckStatus());
               break;
            case ACTIVITY_2_GET_SCORE:
               _loc12_ = int(_loc2_.readUnsignedInt());
               if(_loc12_ > 0)
               {
                  _loc4_ = TUtilityString.Format(this.FFateRoulette.DescListNew[9],_loc12_);
                  ProcessorEffectText(_loc4_);
               }
               this.FFateRoulette.MyScore += _loc12_;
               this.FFateRoulette.ShopExchangePoint += _loc12_;
               this.FFateRoulette.Reset();
               this.FFateRoulette.ChangeStatus();
               this.PlayMovie(MOVIE_OF_FLOW);
               ProcessorCheckEffect(FActivityID,this.FFateRoulette.CheckStatus());
               break;
            case ACTIVITY_2_GET_GIFT:
               _loc5_ = _loc2_.readUnsignedInt() - 1;
               _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
               _loc6_ = 0;
               while(_loc6_ < this.FFateRoulette.BoxList[_loc5_].Inventories.Count)
               {
                  _loc9_ = this.FFateRoulette.BoxList[_loc5_].Inventories.GetInventoryByIndex(_loc6_);
                  _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                  _loc6_++;
               }
               this.FFateRoulette.MyScore = _loc2_.readUnsignedInt();
               this.FFateRoulette.ShopExchangePoint = _loc2_.readUnsignedInt();
               this.FFateRoulette.BoxList[_loc5_].Status = TBaseActivity.STATUS_GETED;
               ProcessorEffectText(_loc4_);
               this.FFateRoulette.ChangeStatus();
               ProcessorCheckEffect(FActivityID,this.FFateRoulette.CheckStatus());
               this.UpdateUI();
               break;
            case ACTIVITY_2_GET_TITLE:
               _loc5_ = _loc2_.readUnsignedInt() - 1;
               _loc4_ = STRING_BASEACTIVITY.FORMAT_GET;
               this.FFateRoulette.GiftList[_loc5_].Status = TBaseActivity.STATUS_GETED;
               ProcessorEffectText(_loc4_);
               this.FFateRoulette.ChangeStatus();
               ProcessorCheckEffect(FActivityID,this.FFateRoulette.CheckStatus());
               this.UpdateUI();
               break;
            case ACTIVITY_1_EXCHANGE_ITEM:
               _loc5_ = _loc2_.readUnsignedInt() - 1;
               this.FFateRoulette.ShopExchangePoint = _loc2_.readUnsignedInt();
               --this.FFateRoulette.ShopExchangeItems[_loc5_].LimitCount;
               _loc4_ = STRING_BASEACTIVITY.FORMAT_EXCHANGE;
               this.FFateRoulette.ChangeStatus();
               ProcessorEffectText(_loc4_);
               ProcessorCheckEffect(FActivityID,this.FFateRoulette.CheckStatus());
               this.UpdateUI();
               break;
            case ACTIVITY_1_GET_TASK:
               _loc20_ = _loc2_.readUnsignedInt();
               _loc24_ = this.FActTaskData.GetTaskByIdentify(_loc20_);
               if(_loc24_ != null)
               {
                  _loc24_.Status = TBaseActivity.STATUS_CANGET;
                  _loc24_.Process = 0;
               }
               ProcessorEffectText(STRING_BASEACTIVITY.FORMAT_GET_TASK_SUCCESS);
               ProcessorCheckEffect(FActivityID,this.FFateRoulette.CheckStatus());
               this.UpdateUI();
               break;
            case ACTIVITY_1_FINISH_TASK:
               _loc20_ = _loc2_.readUnsignedInt();
               _loc24_ = this.FActTaskData.GetTaskByIdentify(_loc20_);
               this.FActTaskData.NeedShine = _loc2_.readUnsignedInt();
               if(_loc24_ != null)
               {
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                  _loc5_ = 0;
                  while(_loc5_ < _loc24_.TaskAward[_loc24_.Step].Count)
                  {
                     _loc9_ = _loc24_.TaskAward[_loc24_.Step].GetInventoryByIndex(_loc5_);
                     _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                     _loc5_++;
                  }
                  ++_loc24_.Step;
                  if(_loc24_.Step >= TActivityTaskData.STEP_COUNT)
                  {
                     _loc24_.Status = TBaseActivity.STATUS_GETED;
                  }
                  else
                  {
                     _loc24_.Process = 0;
                     _loc24_.Status = TBaseActivity.STATUS_CANNOTGET;
                  }
               }
               this.FFateRoulette.MyScore = _loc2_.readUnsignedInt();
               this.FFateRoulette.ShopExchangePoint = _loc2_.readUnsignedInt();
               ProcessorEffectText(_loc4_);
               this.FFateRoulette.ChangeStatus();
               ProcessorCheckEffect(FActivityID,this.FFateRoulette.CheckStatus());
               this.UpdateUI();
         }
      }
      
      public function PlayMovie(param1:int = 0, param2:Boolean = false) : void
      {
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:int = 0;
         this.FIsPlaying = true;
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
            this.FIsPlaying = false;
            this.UpdateLog();
            this.UpdateUI();
         }
         else if(this.FMovieType == MOVIE_OF_FLOW)
         {
            _loc4_ = FMC_Scene.MC_Movie0;
            _loc4_.visible = true;
            this.FTotalFrame = _loc4_.totalFrames;
            _loc4_.gotoAndPlay(1);
         }
      }
      
      public function MovieEnd() : void
      {
         var _loc1_:int = 0;
         var _loc2_:String = null;
         this.FIsPlaying = false;
         if(this.FMovieType == MOVIE_OF_PLAY_GAME)
         {
            ProcessorEffectText(this.FFlowStr);
            this.UpdateUI();
         }
         else if(this.FMovieType == MOVIE_OF_FLOW)
         {
            FMC_Scene.MC_Movie0.visible = false;
            this.UpdateUI();
         }
      }
      
      public function Test() : ByteArray
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         return new ByteArray();
      }
   }
}

