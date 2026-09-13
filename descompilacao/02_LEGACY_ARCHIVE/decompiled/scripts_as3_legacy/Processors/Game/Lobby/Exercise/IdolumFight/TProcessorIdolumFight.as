package Processors.Game.Lobby.Exercise.IdolumFight
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
   import Logics.Exercise.ConsumeRank.TConsumeRankInfo;
   import Logics.Exercise.DessertHouse.TDessertHouseTask;
   import Logics.Exercise.IdolumFight.TIdolumFight;
   import Logics.Exercise.TActivityTaskData;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Exercise.TUnstreamizerIdolumFight;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIShowItem;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorBaseActivity;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   
   public class TProcessorIdolumFight extends TProcessorBaseActivity
   {
      
      protected static const BOX_COUNT:int = 5;
      
      protected static const SHOW_ITEM_COUNT:int = 3;
      
      protected static const CANNON_COUNT:int = 3;
      
      protected static const REQ_GET_GIFT:int = 1;
      
      public static const ACTIVITY_1_GET_BOX:int = 1;
      
      public static const ACTIVITY_1_GET_BIG_BOX:int = 2;
      
      public static const ACTIVITY_1_PLAY_GAME:int = 3;
      
      public static const ACTIVITY_1_GET_TASK:int = 4;
      
      public static const ACTIVITY_1_FINISH_TASK:int = 5;
      
      public static const ACTIVITY_1_GET_KILL_BOX:int = 6;
      
      public static const MOVIE_OF_PLAY_GAME:int = 1;
      
      public static const MOVIE_TYPE_BOSS_DIED:int = 2;
      
      public static const MOVIE_TYPE_BOSS_RESET:int = 3;
      
      protected static const ACT_TASK_COUNT:int = 5;
      
      protected static const ACT_TASK_STEP:int = TActivityTaskData.STEP_COUNT;
      
      protected var FBeClicked:Boolean;
      
      protected var FIsOpen:Boolean;
      
      protected var FIdolumFight:TIdolumFight;
      
      protected var FUnstreamizerIdolumFight:TUnstreamizerIdolumFight;
      
      protected var FBuyBoxDate:Object;
      
      protected var FCost:int;
      
      protected var FIsPlaying:Boolean;
      
      protected var FWindowType:int;
      
      protected var FMovieType:int;
      
      protected var FOpenIndex:int;
      
      protected var FFrameCount:int;
      
      protected var FTotalFrame:int;
      
      protected var FShowItem:TUIShowItem;
      
      protected var FMC_Mask:MovieClip;
      
      protected var FBarMaxWidth:int;
      
      protected var FPlayMovie:MovieClip;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FBoxList:Vector.<MovieClip>;
      
      protected var FActivityTaskData:TActivityTaskData;
      
      public function TProcessorIdolumFight(param1:TUIComponent, param2:TLobbyParameters, param3:uint)
      {
         super(param1,param2,param3);
         FActivityID = param3;
         this.FIdolumFight = SLogicsCore.IdolumFight;
         this.FActivityTaskData = SLogicsCore.ActivityTaskData;
         this.FUnstreamizerIdolumFight = new TUnstreamizerIdolumFight(param3);
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         this.FBuyBoxDate = new Object();
         this.FBoxList = new Vector.<MovieClip>(BOX_COUNT);
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
            this.FBoxList[_loc1_].MC_BoxPic.MC_Icon.gotoAndStop(_loc1_ + 1);
            this.FBoxList[_loc1_].MC_CanGet.visible = false;
            this.FBoxList[_loc1_].addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnBoxOver);
            this.FBoxList[_loc1_].addEventListener(MouseEvent.ROLL_OUT,ProcessorOnNewBoxOut);
            this.FBoxList[_loc1_].addEventListener(MouseEvent.CLICK,this.ProcessorOnBoxUp);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < CANNON_COUNT)
         {
            FMC_Scene["MC_Cannon" + _loc1_].buttonMode = true;
            FMC_Scene["MC_Cannon" + _loc1_].MC_Icon.gotoAndStop(_loc1_ + 1);
            FMC_Scene["MC_Cannon" + _loc1_].addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnCannonOver);
            FMC_Scene["MC_Cannon" + _loc1_].addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlText);
            FMC_Scene["MC_Cannon" + _loc1_].addEventListener(MouseEvent.CLICK,this.ProcessorOnCannonUp);
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
         FMC_Scene.MC_Gift.buttonMode = true;
         FMC_Scene.MC_Gift.addEventListener(MouseEvent.CLICK,this.ProcessorOnBigBoxUp);
         FMC_Scene.MC_Gift.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnBigBoxOver);
         FMC_Scene.MC_Gift.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnNewBoxOut);
         FMC_Scene.MC_KillBox.buttonMode = true;
         FMC_Scene.MC_KillBox.addEventListener(MouseEvent.CLICK,this.ProcessorOnKillBoxUp);
         FMC_Scene.MC_KillBox.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnKillBoxOver);
         FMC_Scene.MC_KillBox.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnNewBoxOut);
         this.FShowItem = new TUIShowItem(this,SHOW_ITEM_COUNT);
         this.FShowItem.Perform_UIDispatch(FMC_Scene.MC_ShowItems);
         this.FShowItem.OnOverlay = UIComponentsHintOnOver;
         this.FShowItem.OnOut = UIComponentsHintOnOut;
         this.FShowItem.OnShowRecruit = ProcessorOnShowItemDesc;
         this.FMC_Mask = FMC_Scene.MC_Boss.MC_Bar.MC_Mask;
         this.FBarMaxWidth = this.FMC_Mask.width;
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
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
                  case MOVIE_OF_PLAY_GAME:
                  case MOVIE_TYPE_BOSS_DIED:
                  case MOVIE_TYPE_BOSS_RESET:
                     _loc2_ = this.FPlayMovie.currentFrame;
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
         this.UpdateBox();
         this.UpdateBoss();
         this.UpdateTaskView();
         this.UpdateText();
      }
      
      protected function UpdateBox() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:TBaseBox = null;
         var _loc5_:TBaseBox = null;
         this.FShowItem.UpdateUI(this.FIdolumFight.ShowItems);
         _loc5_ = this.FIdolumFight.BoxList[this.FIdolumFight.BoxList.length - 1];
         _loc1_ = 0;
         while(_loc1_ < BOX_COUNT)
         {
            _loc3_ = this.FBoxList[_loc1_];
            if(_loc1_ < this.FIdolumFight.BoxList.length)
            {
               _loc4_ = this.FIdolumFight.BoxList[_loc1_];
               _loc3_.MC_Count.TF_Count.text = "*" + (_loc4_.Price + (this.FIdolumFight.Round - 1) * _loc5_.Price);
               if(_loc4_.Status == TBaseActivity.STATUS_CANGET)
               {
                  _loc3_.MC_CanGet.visible = true;
                  _loc3_.MC_BoxPic.gotoAndPlay(1);
               }
               else if(_loc4_.Status == TBaseActivity.STATUS_CANNOTGET)
               {
                  _loc3_.MC_CanGet.visible = false;
                  _loc3_.MC_BoxPic.gotoAndStop(1);
               }
            }
            _loc1_++;
         }
         _loc3_ = FMC_Scene.MC_Gift;
         _loc4_ = this.FIdolumFight.BigBox;
         _loc3_.MC_Count.TF_Count.text = "*" + _loc4_.Price;
         if(_loc4_.Status == TBaseActivity.STATUS_CANGET)
         {
            _loc3_.MC_CanGet.visible = true;
            _loc3_.MC_Got.visible = false;
         }
         else if(_loc4_.Status == TBaseActivity.STATUS_CANNOTGET)
         {
            _loc3_.MC_CanGet.visible = false;
            _loc3_.MC_Got.visible = false;
         }
         else
         {
            _loc3_.MC_CanGet.visible = false;
            _loc3_.MC_Got.visible = true;
         }
         _loc3_ = FMC_Scene.MC_KillBox;
         _loc4_ = this.FIdolumFight.KillBox;
         _loc3_.TF_Count.text = "*" + _loc4_.Count;
         if(_loc4_.Count > 0)
         {
            _loc3_.MC_Click.visible = true;
            _loc3_.MC_Box.gotoAndPlay(1);
         }
         else
         {
            _loc3_.MC_Click.visible = false;
            _loc3_.MC_Box.gotoAndStop(1);
         }
      }
      
      protected function UpdateBoss() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         FMC_Scene.MC_Boss.MC_KillMovie.visible = true;
         FMC_Scene.MC_Boss.MC_KillMovie.gotoAndStop(1);
         FMC_Scene.MC_Boss.MC_RefreshMovie.visible = false;
         FMC_Scene.MC_Boss.MC_BeatMovie.visible = false;
         FMC_Scene.MC_Boss.MC_Bar.TF_Count.text = this.FIdolumFight.CurHp + "/" + this.FIdolumFight.MaxHp;
         _loc2_ = Number(this.FIdolumFight.CurHp / this.FIdolumFight.MaxHp) * this.FBarMaxWidth;
         _loc3_ = Math.min(_loc2_,this.FBarMaxWidth);
         this.FMC_Mask.width = _loc3_;
         _loc4_ = 0;
         while(_loc4_ < CANNON_COUNT)
         {
            FMC_Scene["MC_Cannon" + _loc4_].TF_Count.text = TUtilityString.Format(this.FIdolumFight.DescListNew[7],this.FIdolumFight.CannonList[_loc4_]);
            _loc4_++;
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
      
      protected function UpdateText() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         FMC_Scene.TF_Desc.text = this.FIdolumFight.DescListNew[1];
         FMC_Scene.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_OnlyTime,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FIdolumFight.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FIdolumFight.EndTime) - 1) * 1000)));
         FMC_Scene.TF_ScoreA.text = this.FIdolumFight.ScoreA.toString();
         FMC_Scene.TF_ScoreB.text = this.FIdolumFight.RankPoint.toString();
      }
      
      override protected function PerformPacket_CS_LoadInfoReq() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:int = 0;
         super.PerformPacket_CS_LoadInfoReq();
      }
      
      protected function ProcessorOnBoxUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(6));
         if(Boolean(this.FIdolumFight) && _loc2_ < this.FIdolumFight.BoxList.length)
         {
            if(this.FIdolumFight.BoxList[_loc2_].Status == TBaseActivity.STATUS_CANGET)
            {
               this.ProcessorOnGetBoxUp(ACTIVITY_1_GET_BOX,_loc2_ + 1);
            }
         }
      }
      
      protected function ProcessorOnBoxOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TInventories = null;
         _loc2_ = int(String(param1.currentTarget.name).slice(6));
         if(Boolean(this.FIdolumFight) && _loc2_ < this.FIdolumFight.BoxList.length)
         {
            _loc3_ = this.FIdolumFight.BoxList[_loc2_].Inventories;
            ProcessorOnNewBoxOver(_loc3_);
         }
      }
      
      protected function ProcessorOnBigBoxUp(param1:MouseEvent) : void
      {
         if(Boolean(this.FIdolumFight) && this.FIdolumFight.BigBox.Status == TBaseActivity.STATUS_CANGET)
         {
            this.ProcessorOnGetBoxUp(ACTIVITY_1_GET_BIG_BOX);
         }
      }
      
      protected function ProcessorOnBigBoxOver(param1:MouseEvent) : void
      {
         var _loc2_:TInventories = null;
         if(Boolean(this.FIdolumFight) && Boolean(this.FIdolumFight.BigBox))
         {
            _loc2_ = this.FIdolumFight.BigBox.Inventories;
            ProcessorOnNewBoxOver(_loc2_);
         }
      }
      
      protected function ProcessorOnKillBoxUp(param1:MouseEvent) : void
      {
         if(Boolean(this.FIdolumFight) && Boolean(this.FIdolumFight.KillBox) && this.FIdolumFight.KillBox.Count > 0)
         {
            this.ProcessorOnGetBoxUp(ACTIVITY_1_GET_KILL_BOX);
         }
      }
      
      protected function ProcessorOnKillBoxOver(param1:MouseEvent) : void
      {
         var _loc2_:TInventories = null;
         if(Boolean(this.FIdolumFight) && Boolean(this.FIdolumFight.KillBox))
         {
            _loc2_ = this.FIdolumFight.KillBox.Inventories;
            ProcessorOnNewBoxOver(_loc2_);
         }
      }
      
      protected function ProcessorOnCannonUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(9));
         if(this.FIdolumFight)
         {
            _loc5_ = this.FIdolumFight.CannonList[_loc2_];
            if(this.FIdolumFight.ScoreA >= _loc5_)
            {
               this.ProcessorOnGetBoxUp(ACTIVITY_1_PLAY_GAME,_loc2_ + 1);
            }
            else
            {
               _loc3_ = (_loc5_ - this.FIdolumFight.ScoreA) * this.FIdolumFight.Price;
               _loc4_ = TUtilityString.Format(this.FIdolumFight.DescListNew[5],_loc5_,_loc3_,_loc5_ - this.FIdolumFight.ScoreA);
               this.ProcessorOnBuyBoxUp(ACTIVITY_1_PLAY_GAME,_loc3_,_loc2_ + 1,0,_loc4_);
            }
         }
      }
      
      protected function ProcessorOnCannonOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(9));
         if(this.FIdolumFight)
         {
            ProcessorOnShowHtmlText(this.FIdolumFight.DescListNew[2 + _loc2_]);
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
      
      protected function ProcessorOnCloseWindow() : void
      {
         if(FOnClose != null)
         {
            FOnClose(this);
         }
      }
      
      protected function ProcessorOnShowDesc(param1:MouseEvent) : void
      {
         FProcessorWindowDesc.BaseActivity = this.FIdolumFight;
         super.ProcessorOnOpenDesc();
      }
      
      protected function ProcessorOnLoadLog(param1:MouseEvent) : void
      {
         PerformPacket_CS_AcitivityThird_LoadLogReq(1,null);
      }
      
      protected function ProcessorOnLoadRank(param1:MouseEvent) : void
      {
         ProcessorOnLoadRank_New(this.FIdolumFight);
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount(param1);
         if(!FIsResourcesLoadCompleted)
         {
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
         this.FUnstreamizerIdolumFight.Unstreamize(_loc2_,this.FIdolumFight,null);
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
         if(this.FIdolumFight)
         {
            this.FIdolumFight.RankGiftList.length = 0;
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
               this.FIdolumFight.RankGiftList.push(_loc7_);
               _loc4_++;
            }
            this.FIdolumFight.RankPlayerList.length = 0;
            _loc5_ = int(_loc2_.readUnsignedShort());
            _loc4_ = 0;
            while(_loc4_ < _loc5_)
            {
               _loc6_ = new TConsumeRankInfo();
               _loc6_.UserName = TUtilityString.FetchUTF(_loc2_);
               _loc6_.ServerName = TUtilityString.FetchUTF(_loc2_);
               _loc6_.Rank = _loc2_.readUnsignedInt();
               _loc6_.Score = _loc2_.readUnsignedInt();
               this.FIdolumFight.RankPlayerList.push(_loc6_);
               _loc4_++;
            }
         }
         if(FIsResourcesLoadCompleted && this.visible)
         {
            FProcessorActiveRankOld.Visible = true;
            FProcessorActiveRankOld.UpdateUI(this.FIdolumFight);
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
         if(this.FIdolumFight)
         {
            this.FActivityTaskData.NeedShine = _loc2_.readUnsignedInt();
            this.FIdolumFight.ChangeStatus();
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
         ProcessorUnstreamActivityLog(this.FIdolumFight,_loc2_);
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
               this.FIdolumFight.CurHp = _loc2_.readUnsignedInt();
               _loc12_ = _loc2_.readUnsignedInt();
               this.FIdolumFight.ScoreA = _loc2_.readUnsignedInt();
               this.FIdolumFight.RankPoint += _loc12_;
               _loc5_ = 0;
               while(_loc5_ < this.FIdolumFight.BoxList.length)
               {
                  this.FIdolumFight.BoxList[_loc5_].Status = _loc2_.readInt();
                  _loc5_++;
               }
               this.FIdolumFight.KillBox.Count = _loc2_.readUnsignedInt();
               _loc4_ = TUtilityString.Format(this.FIdolumFight.DescListNew[6],_loc12_);
               this.PlayMovie(MOVIE_OF_PLAY_GAME);
               ProcessorEffectText(_loc4_);
               this.FIdolumFight.ChangeStatus();
               ProcessorCheckEffect(FActivityID,this.FIdolumFight.CheckStatus());
               break;
            case ACTIVITY_1_GET_BOX:
               _loc5_ = _loc2_.readUnsignedInt() - 1;
               this.FIdolumFight.BoxList[_loc5_].Status = TBaseActivity.STATUS_CANNOTGET;
               _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
               _loc6_ = 0;
               while(_loc6_ < this.FIdolumFight.BoxList[_loc5_].Inventories.Count)
               {
                  _loc9_ = this.FIdolumFight.BoxList[_loc5_].Inventories.GetInventoryByIndex(_loc6_);
                  _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                  _loc6_++;
               }
               _loc5_ = 0;
               while(_loc5_ < this.FIdolumFight.BoxList.length)
               {
                  this.FIdolumFight.BoxList[_loc5_].Status = _loc2_.readInt();
                  _loc5_++;
               }
               this.FIdolumFight.Round = _loc2_.readUnsignedInt();
               this.FIdolumFight.RankPoint = _loc2_.readUnsignedInt();
               ProcessorEffectText(_loc4_);
               this.FIdolumFight.ChangeStatus();
               ProcessorCheckEffect(FActivityID,this.FIdolumFight.CheckStatus());
               this.UpdateUI();
               break;
            case ACTIVITY_1_GET_BIG_BOX:
               this.FIdolumFight.RankPoint = _loc2_.readUnsignedInt();
               this.FIdolumFight.BigBox.Status = TBaseActivity.STATUS_GETED;
               _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
               _loc5_ = 0;
               while(_loc5_ < this.FIdolumFight.BigBox.Inventories.Count)
               {
                  _loc9_ = this.FIdolumFight.BigBox.Inventories.GetInventoryByIndex(_loc5_);
                  _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                  _loc5_++;
               }
               ProcessorEffectText(_loc4_);
               this.FIdolumFight.ChangeStatus();
               ProcessorCheckEffect(FActivityID,this.FIdolumFight.CheckStatus());
               this.UpdateUI();
               break;
            case ACTIVITY_1_GET_KILL_BOX:
               --this.FIdolumFight.KillBox.Count;
               _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
               _loc5_ = 0;
               while(_loc5_ < this.FIdolumFight.KillBox.Inventories.Count)
               {
                  _loc9_ = this.FIdolumFight.KillBox.Inventories.GetInventoryByIndex(_loc5_);
                  _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                  _loc5_++;
               }
               this.FIdolumFight.RankPoint = _loc2_.readUnsignedInt();
               _loc5_ = 0;
               while(_loc5_ < this.FIdolumFight.BoxList.length)
               {
                  this.FIdolumFight.BoxList[_loc5_].Status = _loc2_.readInt();
                  _loc5_++;
               }
               ProcessorEffectText(_loc4_);
               this.FIdolumFight.ChangeStatus();
               ProcessorCheckEffect(FActivityID,this.FIdolumFight.CheckStatus());
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
               ProcessorCheckEffect(FActivityID,this.FIdolumFight.CheckStatus());
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
               this.FIdolumFight.ScoreA = _loc2_.readUnsignedInt();
               this.FIdolumFight.RankPoint = _loc2_.readUnsignedInt();
               _loc5_ = 0;
               while(_loc5_ < this.FIdolumFight.BoxList.length)
               {
                  this.FIdolumFight.BoxList[_loc5_].Status = _loc2_.readInt();
                  _loc5_++;
               }
               ProcessorEffectText(_loc4_);
               ProcessorCheckEffect(FActivityID,this.FIdolumFight.CheckStatus());
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
            FMC_Scene.MC_Boss.MC_KillMovie.visible = false;
            this.FPlayMovie = FMC_Scene.MC_Boss.MC_BeatMovie;
            this.FPlayMovie.visible = true;
            this.FTotalFrame = this.FPlayMovie.totalFrames;
            this.FPlayMovie.gotoAndPlay(1);
         }
         else if(this.FMovieType == MOVIE_TYPE_BOSS_DIED)
         {
            this.FPlayMovie = FMC_Scene.MC_Boss.MC_KillMovie;
            this.FTotalFrame = this.FPlayMovie.totalFrames;
            this.FPlayMovie.visible = true;
            this.FPlayMovie.gotoAndPlay(1);
         }
         else if(this.FMovieType == MOVIE_TYPE_BOSS_RESET)
         {
            this.FPlayMovie = FMC_Scene.MC_Boss.MC_RefreshMovie;
            this.FTotalFrame = this.FPlayMovie.totalFrames;
            this.FPlayMovie.visible = true;
            this.FPlayMovie.gotoAndPlay(1);
         }
      }
      
      public function MovieEnd() : void
      {
         var _loc1_:int = 0;
         var _loc2_:String = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         this.FIsPlaying = false;
         if(this.FMovieType == MOVIE_OF_PLAY_GAME)
         {
            this.FPlayMovie.visible = false;
            _loc3_ = Number(this.FIdolumFight.CurHp / this.FIdolumFight.MaxHp) * this.FBarMaxWidth;
            _loc4_ = Math.min(_loc3_,this.FBarMaxWidth);
            this.FMC_Mask.width = this.FBarMaxWidth;
            if(this.FIdolumFight.CurHp == 0)
            {
               this.PlayMovie(MOVIE_TYPE_BOSS_DIED);
            }
            else
            {
               this.UpdateUI();
            }
         }
         else if(this.FMovieType == MOVIE_TYPE_BOSS_DIED)
         {
            this.PlayMovie(MOVIE_TYPE_BOSS_RESET);
         }
         else if(this.FMovieType == MOVIE_TYPE_BOSS_RESET)
         {
            this.FPlayMovie.visible = false;
            this.FIdolumFight.Reset();
            this.UpdateUI();
         }
      }
      
      public function Test() : ByteArray
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:ByteArray = new ByteArray();
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeUnsignedInt(1371571200);
         _loc3_.writeUnsignedInt(1401571200);
         _loc3_.writeShort(11);
         TUtilityString.FlushUTF(_loc3_,"活动详情长");
         TUtilityString.FlushUTF(_loc3_,"活动详情短");
         TUtilityString.FlushUTF(_loc3_,"大炮1");
         TUtilityString.FlushUTF(_loc3_,"大炮2");
         TUtilityString.FlushUTF(_loc3_,"大炮3");
         TUtilityString.FlushUTF(_loc3_,"当前消耗%0个XX,是否花费%1金币补齐不足的%2个XX？");
         TUtilityString.FlushUTF(_loc3_,"你获得了%0个XX");
         TUtilityString.FlushUTF(_loc3_,"消耗%0XX");
         TUtilityString.FlushUTF(_loc3_,"");
         TUtilityString.FlushUTF(_loc3_,"");
         TUtilityString.FlushUTF(_loc3_,"");
         _loc3_.position = 0;
         return _loc3_;
      }
   }
}

