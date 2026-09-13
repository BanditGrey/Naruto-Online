package Processors.Game.Lobby.Exercise.Bejeweled
{
   import Foundation.Network.TPacket;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Characters.TCharacter;
   import Logics.Exercise.Bejeweled.TBejeweled;
   import Logics.Exercise.ConsumeRank.TConsumeRankInfo;
   import Logics.Exercise.DessertHouse.TDessertHouseTask;
   import Logics.Exercise.TActivityTaskData;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Exercise.TUnstreamizerBejeweled;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIShowItem;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorBaseActivity;
   import Processors.Game.Lobby.Exercise.FebActive.TProcessorFebActiveShop;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   
   public class TProcessorBejeweled extends TProcessorBaseActivity
   {
      
      protected static const ICE_COUNT:int = 20;
      
      protected static const SHOW_ITEM_COUNT:int = 2;
      
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
      
      public static const ACTIVITY_1_PLAY_GAME:int = 1;
      
      public static const ACTIVITY_1_AUTO_GAME:int = 2;
      
      public static const ACTIVITY_1_GET_SOUL:int = 3;
      
      public static const ACTIVITY_1_EXCHANGE_ITEM:int = 4;
      
      public static const ACTIVITY_1_GET_GIFT:int = 5;
      
      public static const ACTIVITY_1_GET_TASK:int = 6;
      
      public static const ACTIVITY_1_FINISH_TASK:int = 7;
      
      protected static const ACT_TASK_COUNT:int = 5;
      
      protected static const ACT_TASK_STEP:int = TActivityTaskData.STEP_COUNT;
      
      protected var FBeClicked:Boolean;
      
      protected var FIsOpen:Boolean;
      
      protected var FBejeweled:TBejeweled;
      
      protected var FUnstreamizerBejeweled:TUnstreamizerBejeweled;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FBuyBoxDate:Object;
      
      protected var FCost:int;
      
      protected var FIsPlaying:Boolean;
      
      protected var FWindowType:int;
      
      protected var FMovieType:int;
      
      protected var FOpenIndex:int;
      
      protected var FFrameCount:int;
      
      protected var FTotalFrame:int;
      
      protected var FPlayMovie:MovieClip;
      
      protected var FBackCardVect:Vector.<MovieClip>;
      
      protected var FShowItem:TUIShowItem;
      
      protected var FProcessorFebActiveShop:TProcessorFebActiveShop;
      
      protected var FActivityTaskData:TActivityTaskData;
      
      public function TProcessorBejeweled(param1:TUIComponent, param2:TLobbyParameters, param3:uint)
      {
         super(param1,param2,param3);
         FActivityID = param3;
         this.FBejeweled = SLogicsCore.Bejeweled;
         this.FActivityTaskData = SLogicsCore.ActivityTaskData;
         this.FUnstreamizerBejeweled = new TUnstreamizerBejeweled(param3);
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         this.FBuyBoxDate = new Object();
         this.FBackCardVect = new Vector.<MovieClip>(ICE_COUNT);
         this.FProcessorFebActiveShop = new TProcessorFebActiveShop(this.Parent);
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
         while(_loc1_ < ICE_COUNT)
         {
            this.FBackCardVect[_loc1_] = FMC_Scene["MC_Card" + _loc1_];
            this.FBackCardVect[_loc1_].visible = false;
            this.FBackCardVect[_loc1_].buttonMode = true;
            this.FBackCardVect[_loc1_].addEventListener(MouseEvent.CLICK,this.ProcessorOnIceUp);
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
         FMC_Scene.MC_Movie0.visible = false;
         FMC_Scene.MC_Movie2.visible = false;
         FMC_Scene.MC_Movie3.visible = false;
         FMC_Scene.MC_Click.mouseEnabled = false;
         FMC_Scene.MC_Click.mouseChildren = false;
         this.FShowItem = new TUIShowItem(this,SHOW_ITEM_COUNT);
         this.FShowItem.Perform_UIDispatch(FMC_Scene.MC_ShowItems);
         this.FShowItem.OnOverlay = UIComponentsHintOnOver;
         this.FShowItem.OnOut = UIComponentsHintOnOut;
         this.FShowItem.OnShowRecruit = ProcessorOnShowItemDesc;
         FMC_Scene.MC_Gift.buttonMode = true;
         FMC_Scene.MC_Gift.MC_Box.addEventListener(MouseEvent.CLICK,this.ProcessorOnGiftUp);
         FMC_Scene.MC_Gift.MC_Box.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnGiftOver);
         FMC_Scene.MC_Gift.MC_Box.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnNewBoxOut);
         this.FProcessorFebActiveShop.Visible = false;
         this.FProcessorFebActiveShop.OnCloseUp = this.ProcessorOnCloseShop;
         this.FProcessorFebActiveShop.OnOverlay = UIComponentsHintOnOver;
         this.FProcessorFebActiveShop.OnOut = UIComponentsHintOnOut;
         this.FProcessorFebActiveShop.OnExchange = this.ProcessorOnExchangeItem;
         this.FProcessorFebActiveShop.X = -21;
         this.FProcessorFebActiveShop.y = 15;
         FMC_Scene.MC_Tip0.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnTip0Over);
         FMC_Scene.MC_Tip0.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlText);
         FMC_Scene.MC_Tip1.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnTip1Over);
         FMC_Scene.MC_Tip1.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlText);
         FMC_Scene.MC_Tips.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnTip2Over);
         FMC_Scene.MC_Tips.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlText);
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
         TGameUtil.setButtonMode(FMC_Scene.BTN_Auto,true);
         FMC_Scene.BTN_Auto.addEventListener(MouseEvent.CLICK,this.ProcessorOnAutoUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Get,true);
         FMC_Scene.BTN_Get.addEventListener(MouseEvent.CLICK,this.ProcessorOnGetSoulUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Exchange,true);
         FMC_Scene.BTN_Exchange.addEventListener(MouseEvent.CLICK,this.ProcessorOnExchangeUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_TitleDesc,true);
         FMC_Scene.BTN_TitleDesc.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowTitleDesc);
         TGameUtil.setButtonMode(FMC_Scene.BTN_EquipDesc,true);
         FMC_Scene.BTN_EquipDesc.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowEquipDesc);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Rank,true);
         FMC_Scene.BTN_Rank.addEventListener(MouseEvent.CLICK,this.ProcessorOnLoadRank);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Desc,true);
         FMC_Scene.BTN_Desc.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowDesc);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Log,true);
         FMC_Scene.BTN_Log.addEventListener(MouseEvent.CLICK,this.ProcessorOnLoadLog);
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
                  case MOVIE_OF_WAITING:
                     return;
                  case MOVIE_OF_RESET:
                     _loc2_ = int(FMC_Scene.MC_Movie3.currentFrame);
                     break;
                  case MOVIE_OF_PLAY_GAME:
                     _loc2_ = int(this.FBackCardVect[this.FOpenIndex].MC_Donghua.currentFrame);
                     break;
                  case MOVIE_OF_AUTO:
                     _loc2_ = int(this.FBackCardVect[ICE_COUNT - 1].MC_Donghua.currentFrame);
                     break;
                  case MOVIE_OF_FLOW_0:
                     _loc2_ = int(FMC_Scene.MC_Movie0.currentFrame);
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
         this.UpdateServerBox();
         this.UpdateIce();
         this.UpdateItem();
         this.UpdateText();
         if(this.FProcessorFebActiveShop.Visible)
         {
            this.FProcessorFebActiveShop.UpdateUI(this.FBejeweled);
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
            if(_loc1_ < this.FActivityTaskData.TaskList.length)
            {
               _loc4_.visible = true;
               _loc5_ = this.FActivityTaskData.TaskList[_loc1_];
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
      
      protected function UpdateServerBox() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         var _loc3_:TBaseBox = null;
         _loc2_ = FMC_Scene.MC_Gift;
         _loc3_ = this.FBejeweled.Gift;
         _loc2_.TF_TotalCount.text = this.FBejeweled.ConsumeScore.toString();
         _loc2_.TF_Count.text = _loc3_.Count.toString();
         _loc2_.TF_Price.text = TUtilityString.Format(this.FBejeweled.DescListNew[2],this.FBejeweled.ConsumeScore % _loc3_.Price);
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
         this.FShowItem.UpdateUI(this.FBejeweled.ShowItems);
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
            _loc3_ = Math.abs(this.FBejeweled.IceList[_loc1_]);
            FMC_Scene.MC_Item["MC_Slot" + _loc1_].gotoAndStop(_loc3_);
            if(this.FBejeweled.IceList[_loc1_] == TBejeweled.TYPE_NONE)
            {
               this.FBackCardVect[_loc1_].visible = true;
               this.FBackCardVect[_loc1_].MC_Donghua.gotoAndStop(1);
            }
            else
            {
               _loc2_ = true;
               this.FBackCardVect[_loc1_].visible = false;
               if(this.FBejeweled.IceList[_loc1_] > 0)
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
            if(this.FBejeweled.IceList[_loc1_] != TBejeweled.TYPE_NONE)
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
         FMC_Scene.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FBejeweled.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FBejeweled.EndTime) - 1) * 1000)));
         FMC_Scene.TF_Desc.text = this.FBejeweled.DescListNew[1];
         FMC_Scene.TF_ScoreA.text = this.FBejeweled.ScoreA.toString();
         if(this.FBejeweled.Double > 0)
         {
            _loc3_ = this.FBejeweled.ScoreB / this.FBejeweled.Double / 2;
            FMC_Scene.TF_ScoreB.text = _loc3_ + "(x" + this.FBejeweled.Double * 2 + ")";
         }
         else
         {
            FMC_Scene.TF_ScoreB.text = this.FBejeweled.ScoreB.toString();
         }
         FMC_Scene.TF_RankPoint.text = this.FBejeweled.RankPoint.toString();
         FMC_Scene.TF_Double.text = this.FBejeweled.Double.toString();
         _loc1_ = 0;
         while(_loc1_ < SCORE_COUNT)
         {
            if(_loc1_ < this.FBejeweled.ScoreList.length)
            {
               FMC_Scene["TF_Score" + _loc1_].text = this.FBejeweled.ScoreList[_loc1_].toString();
            }
            else
            {
               FMC_Scene["TF_Score" + _loc1_].text = "";
            }
            _loc1_++;
         }
      }
      
      protected function ProcessorOnIceUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(7));
         if(Boolean(this.FBejeweled) && this.FBejeweled.IceList[_loc2_] == TBejeweled.TYPE_NONE)
         {
            if(this.FBejeweled.ScoreA > 0)
            {
               this.ProcessorOnGetBoxUp(ACTIVITY_1_PLAY_GAME,_loc2_ + 1);
            }
            else
            {
               this.ProcessorOnBuyBoxUp(ACTIVITY_1_PLAY_GAME,this.FBejeweled.ScorePrice,_loc2_ + 1);
            }
         }
      }
      
      protected function ProcessorOnAutoUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:int = 0;
         if(this.FBejeweled)
         {
            _loc4_ = this.FBejeweled.AutoPrice;
            if(this.FBejeweled.ScoreA >= _loc4_)
            {
               this.ProcessorOnGetBoxUp(ACTIVITY_1_AUTO_GAME);
            }
            else
            {
               _loc2_ = (_loc4_ - this.FBejeweled.ScoreA) * this.FBejeweled.ScorePrice;
               _loc3_ = TUtilityString.Format(this.FBejeweled.DescListNew[3],_loc4_,_loc2_,_loc4_ - this.FBejeweled.ScoreA);
               this.ProcessorOnBuyBoxUp(ACTIVITY_1_AUTO_GAME,_loc2_,0,0,_loc3_);
            }
         }
      }
      
      protected function ProcessorOnGetSoulUp(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(this.FBejeweled)
         {
            this.ProcessorOnGetBoxUp(ACTIVITY_1_GET_SOUL);
         }
      }
      
      protected function ProcessorOnGiftUp(param1:MouseEvent) : void
      {
         if(Boolean(this.FBejeweled) && Boolean(this.FBejeweled.Gift) && this.FBejeweled.Gift.Count > 0)
         {
            this.ProcessorOnGetBoxUp(ACTIVITY_1_GET_GIFT);
         }
      }
      
      protected function ProcessorOnGiftOver(param1:MouseEvent) : void
      {
         var _loc2_:TInventories = null;
         if(Boolean(this.FBejeweled) && Boolean(this.FBejeweled.Gift))
         {
            _loc2_ = this.FBejeweled.Gift.Inventories;
            ProcessorOnNewBoxOver(_loc2_);
         }
      }
      
      protected function ProcessorOnExchangeItem(param1:int) : void
      {
         if(this.FBejeweled)
         {
            this.ProcessorOnGetBoxUp(ACTIVITY_1_EXCHANGE_ITEM,param1 + 1);
         }
      }
      
      protected function ProcessorOnTip0Over(param1:MouseEvent) : void
      {
         if(this.FBejeweled)
         {
            ProcessorOnShowHtmlText(this.FBejeweled.DescListNew[4]);
         }
      }
      
      protected function ProcessorOnTip1Over(param1:MouseEvent) : void
      {
         if(this.FBejeweled)
         {
            ProcessorOnShowHtmlText(this.FBejeweled.DescListNew[5]);
         }
      }
      
      protected function ProcessorOnTip2Over(param1:MouseEvent) : void
      {
         if(this.FBejeweled)
         {
            ProcessorOnShowHtmlText(this.FBejeweled.DescListNew[9]);
         }
      }
      
      protected function ProcessorOnGoTaskUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TDessertHouseTask = null;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(FOnGoto != null && _loc2_ < this.FActivityTaskData.TaskList.length)
         {
            this.ProcessorOnCloseWindow();
            _loc3_ = this.FActivityTaskData.TaskList[_loc2_];
            ProcessorOnGoto(_loc3_.Go);
         }
      }
      
      protected function ProcessorOnAcceptTaskUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TDessertHouseTask = null;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(!this.FIsPlaying && _loc2_ < this.FActivityTaskData.TaskList.length)
         {
            _loc3_ = this.FActivityTaskData.TaskList[_loc2_];
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
         if(_loc2_ < this.FActivityTaskData.TaskList.length)
         {
            _loc3_ = this.FActivityTaskData.TaskList[_loc2_];
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
         if(_loc2_ < this.FActivityTaskData.TaskList.length)
         {
            _loc4_ = this.FActivityTaskData.TaskList[_loc2_];
            _loc6_ = Math.min(_loc4_.Step,ACT_TASK_STEP - 1);
            _loc5_ = _loc4_.TaskAward[_loc6_];
            ProcessorOnNewBoxOver(_loc5_);
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
         this.FProcessorFebActiveShop.UpdateUI(this.FBejeweled);
      }
      
      protected function ProcessorOnCloseShop() : void
      {
         this.FProcessorFebActiveShop.Visible = false;
      }
      
      protected function ProcessorOnShowTitleDesc(param1:MouseEvent) : void
      {
         ProcessorOnShowOtherWindow(TProcessorBaseActivity.WINDOW_TITLE_DESC,this.FBejeweled);
      }
      
      protected function ProcessorOnShowEquipDesc(param1:MouseEvent) : void
      {
         ProcessorOnShowOtherWindow(TProcessorBaseActivity.WINDOW_EQUIPMENT_DESC,this.FBejeweled);
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
         FProcessorWindowDesc.BaseActivity = this.FBejeweled;
         super.ProcessorOnOpenDesc();
      }
      
      protected function ProcessorOnLoadLog(param1:MouseEvent) : void
      {
         PerformPacket_CS_AcitivityThird_LoadLogReq(1,null);
      }
      
      protected function ProcessorOnLoadRank(param1:MouseEvent) : void
      {
         ProcessorOnLoadRank_New(this.FBejeweled);
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount(param1);
         if(!FIsResourcesLoadCompleted)
         {
            this.FProcessorFebActiveShop.Load();
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
         PerformPacket_CS_LoadInfoReq();
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
         this.FUnstreamizerBejeweled.Unstreamize(_loc2_,this.FBejeweled,ActivityID);
         if(FIsResourcesLoadCompleted && this.visible)
         {
            this.UpdateUI();
         }
      }
      
      override public function ProcessorLoadRankRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:TConsumeRankInfo = null;
         var _loc7_:TBaseBox = null;
         var _loc8_:TInventories = null;
         var _loc9_:TInventory = null;
         var _loc10_:Vector.<uint> = null;
         var _loc11_:int = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc11_ = int(_loc2_.readUnsignedInt());
         _loc2_.readUnsignedShort();
         if(this.FBejeweled)
         {
            this.FBejeweled.RankGiftList.length = 0;
            _loc5_ = int(_loc2_.readUnsignedShort());
            _loc10_ = new Vector.<uint>();
            _loc4_ = 0;
            while(_loc4_ < _loc5_)
            {
               _loc7_ = new TBaseBox();
               _loc7_.Min = _loc2_.readUnsignedInt();
               _loc7_.Max = _loc2_.readUnsignedInt();
               _loc7_.TitleID = _loc2_.readUnsignedInt();
               _loc10_.length = 0;
               _loc8_ = new TInventories();
               _loc10_.push(_loc2_.readUnsignedInt());
               this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc8_,_loc10_);
               _loc9_ = _loc8_.GetInventoryByIndex(0);
               _loc9_.Quantity = 1;
               _loc7_.Inventories = _loc8_;
               this.FBejeweled.RankGiftList.push(_loc7_);
               _loc4_++;
            }
            this.FBejeweled.RankPlayerList.length = 0;
            _loc5_ = int(_loc2_.readUnsignedShort());
            _loc4_ = 0;
            while(_loc4_ < _loc5_)
            {
               _loc6_ = new TConsumeRankInfo();
               _loc6_.UserName = TUtilityString.FetchUTF(_loc2_);
               _loc6_.ServerName = TUtilityString.FetchUTF(_loc2_);
               _loc6_.Rank = _loc2_.readUnsignedInt();
               _loc6_.Score = _loc2_.readUnsignedInt();
               this.FBejeweled.RankPlayerList.push(_loc6_);
               _loc4_++;
            }
         }
         if(FIsResourcesLoadCompleted && this.visible)
         {
            FProcessorActiveRankOld.Visible = true;
            FProcessorActiveRankOld.UpdateUI(this.FBejeweled);
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
         if(this.FBejeweled)
         {
            this.FActivityTaskData.NeedShine = _loc2_.readUnsignedInt();
            this.FBejeweled.ChangeStatus();
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
         ProcessorUnstreamActivityLog(this.FBejeweled,_loc2_);
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
         var _loc12_:uint = 0;
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
            case ACTIVITY_1_PLAY_GAME:
               _loc5_ = _loc2_.readUnsignedInt() - 1;
               _loc6_ = 0;
               while(_loc6_ < this.FBejeweled.IceList.length)
               {
                  this.FBejeweled.IceList[_loc6_] = _loc2_.readInt();
                  _loc6_++;
               }
               this.FBejeweled.Double = _loc2_.readUnsignedInt();
               this.FBejeweled.ScoreA = _loc2_.readUnsignedInt();
               this.FBejeweled.ScoreB = _loc2_.readUnsignedInt();
               this.FBejeweled.ConsumeScore = _loc2_.readUnsignedInt();
               this.FBejeweled.Gift.Count = _loc2_.readUnsignedInt();
               _loc12_ = _loc2_.readUnsignedInt();
               if(this.FBejeweled.IceList[_loc5_] == TBejeweled.TYPE_DOUBLE)
               {
                  _loc4_ = this.FBejeweled.DescListNew[8];
                  ProcessorEffectText(_loc4_);
               }
               else if(_loc12_ > 0)
               {
                  _loc4_ = TUtilityString.Format(this.FBejeweled.DescListNew[6],_loc12_);
                  ProcessorEffectText(_loc4_);
               }
               this.FOpenIndex = _loc5_;
               this.PlayMovie(MOVIE_OF_PLAY_GAME);
               ProcessorCheckEffect(FActivityID,this.FBejeweled.CheckStatus());
               break;
            case ACTIVITY_1_AUTO_GAME:
               _loc5_ = 0;
               while(_loc5_ < this.FBejeweled.IceList.length)
               {
                  this.FBejeweled.IceList[_loc5_] = _loc2_.readInt();
                  _loc5_++;
               }
               this.FBejeweled.Double = _loc2_.readUnsignedInt();
               this.FBejeweled.ScoreA = _loc2_.readUnsignedInt();
               this.FBejeweled.ScoreB = _loc2_.readUnsignedInt();
               this.FBejeweled.ConsumeScore = _loc2_.readUnsignedInt();
               this.FBejeweled.Gift.Count = _loc2_.readUnsignedInt();
               _loc12_ = _loc2_.readUnsignedInt();
               _loc4_ = TUtilityString.Format(this.FBejeweled.DescListNew[6],_loc12_);
               ProcessorEffectText(_loc4_);
               this.PlayMovie(MOVIE_OF_AUTO);
               ProcessorCheckEffect(FActivityID,this.FBejeweled.CheckStatus());
               break;
            case ACTIVITY_1_GET_SOUL:
               _loc12_ = uint(this.FBejeweled.ScoreB);
               this.FBejeweled.RankPoint += _loc12_;
               this.FBejeweled.ShopExchangePoint += _loc12_;
               _loc4_ = this.FBejeweled.DescListNew[7];
               ProcessorEffectText(_loc4_);
               if(_loc12_ > 0)
               {
                  this.PlayMovie(MOVIE_OF_FLOW_0);
               }
               else
               {
                  this.PlayMovie(MOVIE_OF_RESET);
               }
               this.FBejeweled.ScoreB = 0;
               this.FBejeweled.Double = 0;
               _loc5_ = 0;
               while(_loc5_ < this.FBejeweled.IceList.length)
               {
                  this.FBejeweled.IceList[_loc5_] = TBejeweled.TYPE_NONE;
                  _loc5_++;
               }
               ProcessorCheckEffect(FActivityID,this.FBejeweled.CheckStatus());
               break;
            case ACTIVITY_1_GET_GIFT:
               --this.FBejeweled.Gift.Count;
               _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
               _loc5_ = 0;
               while(_loc5_ < this.FBejeweled.Gift.Inventories.Count)
               {
                  _loc9_ = this.FBejeweled.Gift.Inventories.GetInventoryByIndex(_loc5_);
                  _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                  _loc5_++;
               }
               this.FBejeweled.ScoreA = _loc2_.readUnsignedInt();
               this.FBejeweled.RankPoint = _loc2_.readUnsignedInt();
               this.FBejeweled.ShopExchangePoint = _loc2_.readUnsignedInt();
               ProcessorEffectText(_loc4_);
               this.FBejeweled.ChangeStatus();
               ProcessorCheckEffect(FActivityID,this.FBejeweled.CheckStatus());
               this.UpdateUI();
               break;
            case ACTIVITY_1_EXCHANGE_ITEM:
               _loc5_ = _loc2_.readUnsignedInt() - 1;
               this.FBejeweled.ShopExchangePoint = _loc2_.readUnsignedInt();
               --this.FBejeweled.ShopExchangeItems[_loc5_].LimitCount;
               _loc4_ = STRING_BASEACTIVITY.FORMAT_EXCHANGE;
               this.FBejeweled.ChangeStatus();
               ProcessorEffectText(_loc4_);
               ProcessorCheckEffect(FActivityID,this.FBejeweled.CheckStatus());
               this.UpdateUI();
               break;
            case ACTIVITY_1_GET_TASK:
               _loc20_ = _loc2_.readUnsignedInt();
               _loc24_ = this.FActivityTaskData.GetTaskByIdentify(_loc20_);
               if(_loc24_ != null)
               {
                  _loc24_.Status = TBaseActivity.STATUS_CANGET;
                  _loc24_.Process = 0;
               }
               ProcessorEffectText(STRING_BASEACTIVITY.FORMAT_GET_TASK_SUCCESS);
               ProcessorCheckEffect(FActivityID,this.FBejeweled.CheckStatus());
               this.UpdateUI();
               break;
            case ACTIVITY_1_FINISH_TASK:
               _loc20_ = _loc2_.readUnsignedInt();
               _loc24_ = this.FActivityTaskData.GetTaskByIdentify(_loc20_);
               this.FActivityTaskData.NeedShine = _loc2_.readUnsignedInt();
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
               this.FBejeweled.ScoreA = _loc2_.readUnsignedInt();
               this.FBejeweled.RankPoint = _loc2_.readUnsignedInt();
               this.FBejeweled.ShopExchangePoint = _loc2_.readUnsignedInt();
               ProcessorEffectText(_loc4_);
               this.FBejeweled.ChangeStatus();
               ProcessorCheckEffect(FActivityID,this.FBejeweled.CheckStatus());
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
            _loc4_ = this.FBackCardVect[this.FOpenIndex].MC_Donghua;
            _loc4_.visible = true;
            this.FTotalFrame = _loc4_.totalFrames;
            _loc4_.gotoAndPlay(1);
            _loc5_ = Math.abs(this.FBejeweled.IceList[this.FOpenIndex]);
            FMC_Scene.MC_Item["MC_Slot" + this.FOpenIndex].gotoAndStop(_loc5_);
            if(this.FBejeweled.IceList[this.FOpenIndex] > 0)
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
               this.FTotalFrame = _loc4_.totalFrames;
               _loc4_.gotoAndPlay(1);
               FMC_Scene.MC_Item["MC_Slot" + _loc3_].MC_Clear.visible = false;
               _loc5_ = Math.abs(this.FBejeweled.IceList[_loc3_]);
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
            this.FTotalFrame = _loc4_.totalFrames;
            _loc4_.gotoAndPlay(1);
         }
         else if(this.FMovieType == MOVIE_OF_FLOW_0)
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
            this.FBejeweled.ScoreB = 0;
            this.UpdateUI();
         }
         else if(this.FMovieType == MOVIE_OF_FLOW_0)
         {
            FMC_Scene.MC_Movie0.visible = false;
            this.PlayMovie(MOVIE_OF_RESET);
         }
      }
   }
}

