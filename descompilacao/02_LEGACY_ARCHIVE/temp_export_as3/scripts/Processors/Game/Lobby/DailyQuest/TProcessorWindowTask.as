package Processors.Game.Lobby.DailyQuest
{
   import Components.Slots.TUISlot;
   import Foundation.Common.THint;
   import Foundation.Network.TPacket;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.Repositories.TResourceRepositoryTexture;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Resources.Textures.TTexture;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.Characters.TCharacter;
   import Logics.Dailytask.TDailytask;
   import Logics.Dailytask.TQuestDaily;
   import Logics.Dailytask.TTargetTaskList;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.DatebaseVO.VO.TDailyTask;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.DailyQuest.Component.TUITaskList;
   import Processors.Game.Lobby.TongLing.ToolS.Tools_Help;
   import Processors.Game.Lobby.TreasureMap.ConsumeFrame;
   import Processors.Game.Windows.Information.TUIWindowConfirmation;
   import Processors.Game.Windows.Information.TUIWindowRecharge;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_CONFIGVALUE;
   import Resources.Constants.CONST_DAILY_QUEST;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_POPTIPS;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_DAILYTASK;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   
   public class TProcessorWindowTask extends TProcessorLobbyWindow
   {
      
      protected static const TARGAT_SLOTS:uint = 3;
      
      protected static const TASK_SLOTS:uint = 5;
      
      protected static const DOUBLE_TYPE:uint = 18;
      
      protected var FMC_Task:Sprite;
      
      protected var FHint:THint;
      
      protected var FMC_TargetTasks:Vector.<TUISlot>;
      
      protected var FMC_RefreshTask:MovieClip;
      
      protected var FMC_RefreshTasks:Vector.<TUISlot>;
      
      protected var FTF_ExtraPoint:TextField;
      
      protected var FTF_FinisTaskNum:TextField;
      
      protected var FTF_TaskName:TextField;
      
      protected var FTF_RewardSilver:TextField;
      
      protected var FTF_RewardPoint:TextField;
      
      protected var FTF_FinishCount:TextField;
      
      protected var FTF_Description:TextField;
      
      protected var FMC_RefreshBT:MovieClip;
      
      protected var FMC_FinishNowBT:MovieClip;
      
      protected var FMC_GiveUpTaskBT:MovieClip;
      
      protected var FMC_DoTaskBT:MovieClip;
      
      protected var FMC_FinishTaskBT:MovieClip;
      
      protected var FMC_AcceptTaskBT:MovieClip;
      
      protected var FMC_OneKeyOver:MovieClip;
      
      protected var FMC_FlyPoint:MovieClip;
      
      protected var FTaskList:TUITaskList;
      
      protected var FDailytask:TDailytask;
      
      protected var FIndex:uint;
      
      protected var FIsOk:Boolean;
      
      protected var FType:uint;
      
      protected var FID:uint;
      
      protected var FUIWindowInformation:TUIWindowConfirmation;
      
      protected var FUIWindowRefreshInformation:TUIWindowConfirmation;
      
      protected var FUIWindowRecharge:TUIWindowRecharge;
      
      protected var FIsRefresh:Boolean;
      
      protected var FIsFinishUnstream:Boolean;
      
      protected var FIsGiveAndAccept:Boolean;
      
      protected var FIsRefreshSelected:Boolean;
      
      protected var FIsFinishNowSelected:Boolean;
      
      protected var FTempPoint:uint;
      
      protected var FDailyTaskBin:TBins;
      
      protected var FCharacter:TCharacter;
      
      protected var FOnRefrsh:Function;
      
      protected var FOnPointUpdate:Function;
      
      protected var FOnTaskReq:Function;
      
      protected var FOnGoto:Function;
      
      protected var FOnUpdateDouble:Function;
      
      protected var FOnEffectExtraPoint:Function;
      
      protected var FOnCloseWindow:Function;
      
      protected var FOnGotoMap:Function;
      
      protected var FHintOnTargetOver:Function;
      
      protected var FHintOnOut:Function;
      
      public function TProcessorWindowTask(param1:TUIComponent)
      {
         super(param1);
         this.FMC_TargetTasks = new Vector.<TUISlot>(TARGAT_SLOTS);
         this.FMC_RefreshTasks = new Vector.<TUISlot>(TASK_SLOTS);
         this.FHint = new THint();
         this.FDailytask = SLogicsCore.Character.DailyTask;
         this.FCharacter = SLogicsCore.Character;
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_DAILY_QUEST.RESOURCESID_DAILY_QUEST);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUISlot = null;
         var _loc4_:Sprite = null;
         this.FMC_Task = TUtilityReflection.CreateDisplayObjectInstance(CONST_DAILY_QUEST.RESOURCE_ClassName_TASK) as Sprite;
         addChild(this.FMC_Task);
         this.FMC_RefreshBT = this.FMC_Task[CONST_DAILY_QUEST.RESOURCE_Link_MC_RefreshBT];
         _loc4_ = this.FMC_Task[CONST_DAILY_QUEST.RESOURCE_Link_MC_BTS];
         this.FMC_FinishNowBT = _loc4_[CONST_DAILY_QUEST.RESOURCE_Link_MC_FinishNowBT];
         this.FMC_GiveUpTaskBT = _loc4_[CONST_DAILY_QUEST.RESOURCE_Link_MC_GiveUpTaskBT];
         this.FMC_FinishTaskBT = _loc4_[CONST_DAILY_QUEST.RESOURCE_Link_MC_FinishTaskBT];
         this.FMC_AcceptTaskBT = _loc4_[CONST_DAILY_QUEST.RESOURCE_Link_MC_AcceptTaskBT];
         this.FMC_DoTaskBT = this.FMC_Task[CONST_DAILY_QUEST.RESOURCE_Link_MC_DoTaskBT];
         this.FMC_OneKeyOver = this.FMC_Task["MC_OneKeyOver"];
         TGameUtil.setButtonMode(this.FMC_RefreshBT,true);
         TGameUtil.setButtonMode(this.FMC_FinishNowBT,true);
         TGameUtil.setButtonMode(this.FMC_GiveUpTaskBT,true);
         TGameUtil.setButtonMode(this.FMC_DoTaskBT,true);
         TGameUtil.setButtonMode(this.FMC_FinishTaskBT,true);
         TGameUtil.setButtonMode(this.FMC_AcceptTaskBT,true);
         new Tools_Help(this.Parent,this.FMC_OneKeyOver,70320001,FUICore);
         this.FMC_DoTaskBT.visible = false;
         this.FMC_FinishTaskBT.visible = false;
         this.FMC_AcceptTaskBT.visible = false;
         this.FMC_GiveUpTaskBT.visible = false;
         this.FMC_FinishNowBT.visible = false;
         this.FTF_ExtraPoint = this.FMC_Task[CONST_DAILY_QUEST.RESOURCE_Link_TF_ExtraPoint];
         this.FTF_FinisTaskNum = this.FMC_Task[CONST_DAILY_QUEST.RESOURCE_Link_TF_FinisTaskNum];
         this.FTF_RewardSilver = this.FMC_Task[CONST_DAILY_QUEST.RESOURCE_Link_TF_RewardSilver];
         this.FTF_RewardPoint = this.FMC_Task[CONST_DAILY_QUEST.RESOURCE_Link_TF_RewardPoint];
         this.FTF_FinishCount = this.FMC_Task[CONST_DAILY_QUEST.RESOURCE_Link_TF_FinishCount];
         this.FTF_Description = this.FMC_Task[CONST_DAILY_QUEST.RESOURCE_Link_TF_Description];
         this.FTF_TaskName = this.FMC_Task[CONST_DAILY_QUEST.RESOURCE_Link_TF_TaskName];
         this.FMC_FlyPoint = this.FMC_Task[CONST_DAILY_QUEST.RESOURCE_Link_MC_FlyPoint];
         this.FMC_FlyPoint.visible = false;
         _loc2_ = TARGAT_SLOTS;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = new TUISlot(this);
            _loc3_.Resource = this.FMC_Task[CONST_DAILY_QUEST.RESOURCE_Link_MC_TargetTasks + _loc1_] as Sprite;
            _loc3_.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
            _loc3_.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
            _loc3_.OnOverlay = this.TargetTaskSlotOnOverlay;
            _loc3_.OnOut = this.OnOut;
            _loc3_.Init();
            this.FMC_TargetTasks[_loc1_] = _loc3_;
            _loc1_++;
         }
         this.FMC_RefreshTask = this.FMC_Task[CONST_DAILY_QUEST.RESOURCE_Link_MC_RefreshTask] as MovieClip;
         this.FTaskList = new TUITaskList(this,this.FMC_RefreshTask);
         this.FTaskList.TaskOnClick = this.TaskListOnClick;
         this.FTaskList.TaskOnOver = this.TaskOnOver;
         this.FTaskList.TaskOnOut = this.OnOut;
         this.FTaskList.TutorialNextStep = TutorialNextStep;
         this.FUIWindowInformation = new TUIWindowConfirmation(this.Parent);
         this.FUIWindowInformation.OnOK = this.WindowInformationOnOK;
         this.FUIWindowInformation.OnCancel = this.WindowInformationOnCancel;
         this.FUIWindowInformation.OnCheckBoxSelected = this.WindowInformationOnCheckBoxSelected;
         this.FUIWindowInformation.x = (CONST_COMMON.STAGE_Width - this.FUIWindowInformation.WindowWidth) / 2;
         this.FUIWindowInformation.y = (CONST_COMMON.STAGE_Height - this.FUIWindowInformation.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowInformation);
         this.FUIWindowInformation.SetCheckBox(true);
         this.FUIWindowRefreshInformation = new TUIWindowConfirmation(this.Parent);
         this.FUIWindowRefreshInformation.OnOK = this.WindowInformationOnOK;
         this.FUIWindowRefreshInformation.OnCancel = this.WindowInformationOnCancel;
         this.FUIWindowRefreshInformation.x = (CONST_COMMON.STAGE_Width - this.FUIWindowRefreshInformation.WindowWidth) / 2;
         this.FUIWindowRefreshInformation.y = (CONST_COMMON.STAGE_Height - this.FUIWindowRefreshInformation.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowRefreshInformation);
         this.FUIWindowRecharge = new TUIWindowRecharge(this.Parent);
         this.FUIWindowRecharge.x = (CONST_COMMON.STAGE_Width - this.FUIWindowRecharge.WindowWidth) / 2;
         this.FUIWindowRecharge.y = (CONST_COMMON.STAGE_Height - this.FUIWindowRecharge.WindowHeight) / 2 - 20;
         TUtilityUIWindow.SetupWindowRecharge(this.FUIWindowRecharge);
         this.FIsOk = true;
         this.FDailyTaskBin = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_DailyTask);
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
         this.FMC_FinishNowBT.addEventListener(MouseEvent.CLICK,this.TaskOnClick);
         this.FMC_FinishTaskBT.addEventListener(MouseEvent.CLICK,this.TaskOnClick);
         this.FMC_AcceptTaskBT.addEventListener(MouseEvent.CLICK,this.TaskOnClick);
         this.FMC_GiveUpTaskBT.addEventListener(MouseEvent.CLICK,this.TaskOnClick);
         this.FMC_OneKeyOver.addEventListener(MouseEvent.CLICK,this.TaskOnClick);
         this.FMC_RefreshBT.addEventListener(MouseEvent.CLICK,this.RefreshOnClick);
         this.FMC_RefreshBT.addEventListener(MouseEvent.MOUSE_MOVE,this.RefreshOnOVER);
         this.FMC_RefreshBT.addEventListener(MouseEvent.MOUSE_OUT,this.RefreshOnOUT);
         this.FMC_DoTaskBT.addEventListener(MouseEvent.CLICK,this.DoTaskOnClick);
      }
      
      private function RefreshOnOUT(param1:MouseEvent) : void
      {
         if(this.FHintOnOut != null)
         {
            this.FHintOnOut(this);
         }
      }
      
      private function RefreshOnOVER(param1:MouseEvent) : void
      {
         var _loc2_:TConfigValue = null;
         var _loc3_:String = null;
         var _loc4_:Vector.<uint> = null;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.Dailytask_Fresh) as TConfigValue;
         _loc4_ = _loc2_.Value as Vector.<uint>;
         _loc3_ = STRING_COMMON.GetItemNameByType(_loc4_[0],1);
         if(this.FDailytask.FreshCount == 0)
         {
            this.FHint.Caption = STRING_DAILYTASK.FORMAT_FreshFree;
         }
         else
         {
            this.FHint.Caption = TUtilityString.Format(STRING_DAILYTASK.FORMAT_FreshTip,_loc4_[2],_loc3_);
         }
         if(this.FHintOnTargetOver != null)
         {
            this.FHintOnTargetOver(this,this.FHint);
         }
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         if(this.FIsOk)
         {
            this.UpdateTargetTaskSlot();
            if(this.FIsFinishUnstream)
            {
               this.FTaskList.UpdataTaskList();
            }
         }
         if(this.FMC_FlyPoint != null)
         {
            if(this.FMC_FlyPoint.currentFrame == 55)
            {
               if(this.FOnPointUpdate != null)
               {
                  this.FOnPointUpdate();
               }
            }
         }
      }
      
      protected function TargetTaskSlotOnOverlay(param1:Object, param2:TTargetTaskList) : void
      {
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:String = null;
         var _loc6_:TDailyTask = null;
         var _loc7_:uint = 0;
         _loc5_ = "";
         _loc4_ = param2.EventType;
         _loc7_ = uint(this.FDailyTaskBin.Count);
         _loc3_ = 0;
         while(_loc3_ < _loc7_)
         {
            _loc6_ = this.FDailyTaskBin.GetDatebaseByIndex(_loc3_) as TDailyTask;
            if(_loc6_.EventType == _loc4_)
            {
               break;
            }
            _loc3_++;
         }
         _loc5_ += _loc6_.Taskname;
         if(param2.IsFinish == 0)
         {
            _loc5_ += STRING_DAILYTASK.FORMAT_Progess_UnFinish;
         }
         else
         {
            _loc5_ += STRING_DAILYTASK.FORMAT_Progess_HaveFinished;
         }
         this.FHint.Caption = _loc5_;
         if(this.FHintOnTargetOver != null)
         {
            this.FHintOnTargetOver(this,this.FHint);
         }
      }
      
      protected function OnOut(param1:Object, param2:Object) : void
      {
         if(this.FHintOnOut != null)
         {
            this.FHintOnOut(this);
         }
      }
      
      protected function WindowInformationOnCheckBoxSelected(param1:Object, param2:Boolean) : void
      {
         if(this.FType == 4)
         {
            this.FIsFinishNowSelected = param2;
         }
      }
      
      protected function WindowInformationOnOK(param1:Object) : void
      {
         if(this.FIsRefresh)
         {
            if(this.FOnRefrsh != null)
            {
               this.FOnRefrsh();
            }
            this.FIsRefresh = false;
            if(this.FDailytask.CurrentID == 0)
            {
               this.FIsRefreshSelected = true;
            }
            return;
         }
         if(this.FType == 2)
         {
            if(this.FOnTaskReq != null)
            {
               this.FOnTaskReq(this.FID,this.FType);
            }
            this.FType = 0;
         }
         else if(this.FType == 4)
         {
            if(this.FOnTaskReq != null)
            {
               this.FOnTaskReq(this.FID,this.FType);
            }
            this.FType = 0;
         }
         else if(this.FType == 5)
         {
            if(this.FOnTaskReq != null)
            {
               this.FOnTaskReq(this.FID,this.FType);
            }
         }
      }
      
      protected function WindowInformationOnCancel(param1:Object) : void
      {
         this.FIsRefresh = false;
         this.FIsGiveAndAccept = false;
      }
      
      protected function SlotsOnQuerySequenceContext(param1:Object, param2:Object, param3:TQueryAnimationSequence, param4:uint = 0) : void
      {
         var _loc5_:TTargetTaskList = null;
         var _loc6_:TResourceRepositoryTexture = null;
         var _loc7_:TTexture = null;
         _loc5_ = param2 as TTargetTaskList;
         _loc6_ = SResourcesCore.TexturesDailytaskPicture;
         _loc7_ = _loc6_.GetTextureByIdentifier(_loc5_.EventType);
         if(_loc7_ != null)
         {
            param3.Value = _loc7_.GetAnimationSequenceByIdentifier(param4);
         }
         else
         {
            _loc6_.LoadSecondary(_loc5_.EventType,CONST_MODULES.MODULE_DailyQuest);
         }
      }
      
      protected function UpdateText(param1:TQuestDaily) : void
      {
         this.FTF_TaskName.text = param1.Name;
         this.FTF_TaskName.textColor = CONST_COMMON.QUALITYCOLOR_INDEX[param1.Rate];
         this.FTF_RewardSilver.text = param1.Rewards[0].Amount + STRING_COMMON.GetItemNameByType(param1.Rewards[0].Type,param1.Rewards[0].Code);
         this.FTF_RewardPoint.text = TUtilityString.Format(STRING_DAILYTASK.FORMAT_Progess_AwardPoint,param1.AwardPoint);
         if(this.FDailytask.CurrentProgress > param1.KillTime)
         {
            this.FDailytask.CurrentProgress = param1.KillTime;
         }
         this.FTF_FinishCount.text = TUtilityString.Format(STRING_DAILYTASK.FORMAT_Progess,this.FDailytask.CurrentProgress,param1.KillTime);
         this.FTF_Description.text = param1.Description;
         if(this.FDailytask.CurrentID != 0)
         {
            if(param1.IsGoto == 1)
            {
               this.FMC_DoTaskBT.visible = true;
               if(param1.Identifier != this.FDailytask.CurrentID)
               {
                  this.FMC_DoTaskBT.visible = false;
               }
            }
            this.FMC_FinishNowBT.visible = false;
            this.FMC_AcceptTaskBT.visible = true;
            if(param1.Identifier != this.FDailytask.CurrentID)
            {
               this.FTF_FinishCount.text = TUtilityString.Format(STRING_DAILYTASK.FORMAT_Progess,0,param1.KillTime);
            }
         }
         else
         {
            this.FMC_AcceptTaskBT.visible = true;
         }
      }
      
      protected function UnderDoingUpdate() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:TQuestDaily = null;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         _loc3_ = this.FDailytask.GetTaskByIdentifier(this.FDailytask.CurrentID);
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            if(_loc3_ == this.FDailytask.GetTaskByIndex(_loc1_))
            {
               _loc4_ = _loc1_;
               break;
            }
            _loc1_++;
         }
         this.UpdateText(_loc3_);
         if(this.FDailytask.CurrentProgress < _loc3_.KillTime)
         {
            this.FMC_FinishNowBT.visible = true;
            this.FMC_GiveUpTaskBT.visible = true;
            this.FMC_AcceptTaskBT.visible = false;
            _loc5_ = 1;
         }
         else
         {
            this.FMC_FinishTaskBT.visible = true;
            this.FMC_FinishNowBT.visible = false;
            this.FMC_AcceptTaskBT.visible = false;
            this.FMC_GiveUpTaskBT.visible = true;
            _loc5_ = 2;
         }
         this.FTaskList.SetTag(_loc5_,_loc4_);
      }
      
      protected function UpdateTargetTaskSlot() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:TTargetTaskList = null;
         _loc2_ = this.FDailytask.CountForTargetTask();
         if(_loc2_ != 0)
         {
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               _loc3_ = this.FDailytask.GetTargetTaskByIndex(_loc1_);
               this.FMC_TargetTasks[_loc1_].Context = _loc3_;
               this.FMC_TargetTasks[_loc1_].Resource.visible = true;
               if(_loc3_.IsFinish == 0)
               {
                  this.FMC_TargetTasks[_loc1_].SetDefaultFilters(true);
               }
               this.FMC_TargetTasks[_loc1_].Update();
               _loc1_++;
            }
            _loc1_ = _loc2_;
            while(_loc1_ < 3)
            {
               this.FMC_TargetTasks[_loc1_].Resource.visible = false;
               _loc1_++;
            }
         }
         else
         {
            _loc1_ = 0;
            while(_loc1_ < 3)
            {
               this.FMC_TargetTasks[_loc1_].Resource.visible = false;
               _loc1_++;
            }
         }
      }
      
      protected function TaskListOnClick(param1:uint) : void
      {
         var _loc2_:TQuestDaily = null;
         this.FIndex = param1;
         _loc2_ = this.FDailytask.GetTaskByIndex(this.FIndex);
         if(_loc2_.Identifier == this.FDailytask.CurrentID)
         {
            this.UpdateText(_loc2_);
            this.FMC_FinishNowBT.visible = true;
            this.FMC_GiveUpTaskBT.visible = true;
            this.FMC_AcceptTaskBT.visible = false;
         }
         else
         {
            this.UpdateText(_loc2_);
         }
      }
      
      protected function TaskOnOver(param1:Object, param2:uint) : void
      {
         var _loc3_:TQuestDaily = null;
         _loc3_ = this.FDailytask.GetTaskByIndex(param2);
         this.FHint.Caption = _loc3_.Name;
         if(this.FHintOnTargetOver != null)
         {
            this.FHintOnTargetOver(this,this.FHint);
         }
      }
      
      protected function resetText() : void
      {
         this.FTF_TaskName.text = "";
         this.FTF_RewardSilver.text = "";
         this.FTF_RewardPoint.text = "";
         this.FTF_FinishCount.text = "";
         this.FTF_Description.text = "";
         this.FTF_FinisTaskNum.text = TUtilityString.Format(STRING_DAILYTASK.FORMAT_Progess,this.FDailytask.FinishCount,10);
         this.FMC_DoTaskBT.visible = false;
         this.FMC_FinishTaskBT.visible = false;
         this.FMC_AcceptTaskBT.visible = false;
         this.FMC_GiveUpTaskBT.visible = false;
         this.FMC_FinishNowBT.visible = false;
      }
      
      protected function TargetTaskUpdate(param1:TQuestDaily) : void
      {
         var _loc2_:TTargetTaskList = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:Boolean = false;
         var _loc6_:uint = 0;
         var _loc7_:TPacket = null;
         var _loc8_:ByteArray = null;
         _loc6_ = 0;
         _loc5_ = false;
         _loc4_ = this.FDailytask.CountForTargetTask();
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc2_ = this.FDailytask.GetTargetTaskByIndex(_loc3_);
            if(_loc2_.EventType == param1.EventType)
            {
               if(_loc2_.IsFinish == 0)
               {
                  this.FMC_TargetTasks[_loc3_].SetDefaultFilters(false);
                  _loc2_.IsFinish = 1;
                  _loc5_ = true;
                  break;
               }
            }
            _loc3_++;
         }
         if(_loc5_)
         {
            _loc3_ = 0;
            while(_loc3_ < _loc4_)
            {
               _loc2_ = this.FDailytask.GetTargetTaskByIndex(_loc3_);
               if(_loc2_.IsFinish == 1)
               {
                  _loc6_++;
               }
               _loc3_++;
            }
            if(_loc6_ == _loc4_)
            {
               this.FDailytask.Point += this.FTempPoint;
               if(this.FOnEffectExtraPoint != null)
               {
                  this.FOnEffectExtraPoint(this.FTempPoint);
               }
               this.FMC_FlyPoint.visible = true;
               this.FMC_FlyPoint.play();
            }
         }
      }
      
      protected function updateTargetPoint() : void
      {
         var _loc1_:TConfigValue = null;
         var _loc2_:Vector.<Object> = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         _loc4_ = this.FDailytask.CountForTargetTask();
         if(_loc4_ != 0)
         {
            _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.Dailytask_TargetAndPoint) as TConfigValue;
            _loc2_ = _loc1_.Value as Vector.<Object>;
            _loc3_ = 0;
            while(_loc3_ < _loc4_)
            {
               if(_loc2_[_loc3_][0] == _loc4_)
               {
                  this.FTempPoint = _loc2_[_loc3_][1];
                  break;
               }
               _loc3_++;
            }
            this.FTF_ExtraPoint.visible = true;
            this.FTF_ExtraPoint.text = TUtilityString.Format(STRING_DAILYTASK.FORMAT_Progess_ExtraPoint,this.FTempPoint);
         }
         else
         {
            this.FTF_ExtraPoint.visible = false;
         }
         this.UpdateOneKeyTimes();
      }
      
      protected function updateEffectList() : void
      {
         var _loc1_:TQuestDaily = null;
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         _loc3_ = this.FDailytask.CountForTask();
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc1_ = this.FDailytask.GetTaskByIndex(_loc2_);
            if(_loc1_.EventType == DOUBLE_TYPE)
            {
               this.FTaskList.SetEffect(_loc2_,true);
               break;
            }
            this.FTaskList.SetEffect(_loc2_,false);
            _loc2_++;
         }
      }
      
      protected function UpdateOneKeyTimes() : void
      {
         if(this.FDailytask.FinishCount <= 0)
         {
            TGameUtil.setButtonMode(this.FMC_OneKeyOver,true);
         }
         else
         {
            TGameUtil.setButtonMode(this.FMC_OneKeyOver,false);
         }
      }
      
      protected function TaskOnClick(param1:MouseEvent) : void
      {
         var _loc2_:TQuestDaily = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:String = null;
         var _loc7_:TConfigValue = null;
         TutorialNextStep(2102);
         _loc3_ = 0;
         _loc4_ = 0;
         _loc5_ = 0;
         _loc6_ = "";
         switch(param1.currentTarget)
         {
            case this.FMC_AcceptTaskBT:
               if(this.FDailytask.FinishCount >= 10)
               {
                  EffectGenerateText(STRING_DAILYTASK.STRING_FinishAllTask);
                  return;
               }
               this.FID = this.FDailytask.GetTaskByIndex(this.FIndex).Identifier;
               this.FType = 1;
               if(this.FDailytask.CurrentID != 0)
               {
                  this.FType = 2;
                  this.FID = this.FDailytask.CurrentID;
                  this.FUIWindowInformation.Text = TUtilityString.Format(STRING_DAILYTASK.STRING_Accept);
                  this.FUIWindowInformation.SetCheckBox(false);
                  this.FUIWindowInformation.Visible = true;
                  this.FIsGiveAndAccept = true;
                  return;
               }
               break;
            case this.FMC_OneKeyOver:
               if(!this.FMC_OneKeyOver.buttonMode)
               {
                  return;
               }
               if(this.FDailytask.FinishCount >= 10)
               {
                  EffectGenerateText(STRING_DAILYTASK.STRING_FinishAllTask);
                  return;
               }
               this.FType = 5;
               this.FID = 707;
               _loc7_ = null;
               _loc7_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.Quest_Task) as TConfigValue;
               this.FUIWindowInformation.Text = TUtilityString.Format(new ConsumeFrame(CONST_SYSTEMLANGUAGE.HELPTIPS_OneDayTask).DescribeString,_loc7_.Value);
               this.FUIWindowInformation.SetCheckBox(false);
               this.FUIWindowInformation.Visible = true;
               return;
               break;
            case this.FMC_GiveUpTaskBT:
               this.FID = this.FDailytask.CurrentID;
               this.FType = 2;
               this.FUIWindowInformation.Text = TUtilityString.Format(STRING_DAILYTASK.STRING_Giveup);
               this.FUIWindowInformation.SetCheckBox(false);
               this.FUIWindowInformation.Visible = true;
               return;
            case this.FMC_FinishTaskBT:
               this.FID = this.FDailytask.CurrentID;
               this.FType = 3;
               break;
            case this.FMC_FinishNowBT:
               _loc2_ = this.FDailytask.GetTaskByIdentifier(this.FDailytask.CurrentID);
               _loc3_ = _loc2_.Instant[0].Type;
               _loc4_ = _loc2_.Instant[0].Code;
               _loc5_ = _loc2_.Instant[0].Amount;
               if(this.FCharacter.CreditGold + this.FCharacter.CreditGiftCertificate < _loc5_)
               {
                  this.FUIWindowRecharge.Visible = true;
                  return;
               }
               this.FID = this.FDailytask.CurrentID;
               this.FType = 4;
               _loc6_ = STRING_COMMON.GetItemNameByType(_loc3_,_loc4_);
               if(!this.FIsFinishNowSelected)
               {
                  this.FUIWindowInformation.Text = TUtilityString.Format(new ConsumeFrame(CONST_SYSTEMLANGUAGE.ConsumerConfirm_DailyTask_CompletedImmediately).DescribeString,_loc5_);
                  this.FUIWindowInformation.SetCheckBox(true);
                  this.FUIWindowInformation.SetSelectedOrNot(false);
                  this.FUIWindowInformation.Visible = true;
                  return;
               }
         }
         if(this.FType != 0 && this.FID != 0)
         {
            if(this.FOnTaskReq != null)
            {
               this.FOnTaskReq(this.FID,this.FType);
            }
            this.FType = 0;
         }
      }
      
      protected function RefreshOnClick(param1:MouseEvent) : void
      {
         var _loc2_:TConfigValue = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:String = null;
         var _loc7_:Vector.<uint> = null;
         var _loc8_:String = null;
         var _loc9_:uint = 0;
         _loc9_ = uint(SLogicsCore.Character.Appliances.GetAllCountByTempletID(CONST_DAILY_QUEST.RefreshCard));
         TutorialNextStep(2101);
         if(this.FDailytask.FreshCount > 0)
         {
            _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.Dailytask_Fresh) as TConfigValue;
            _loc7_ = _loc2_.Value as Vector.<uint>;
            _loc6_ = STRING_COMMON.GetItemNameByType(_loc7_[0],1);
            if(_loc9_ <= 0 && this.FCharacter.CreditGold + this.FCharacter.CreditGiftCertificate < _loc7_[2])
            {
               this.FUIWindowRecharge.Visible = true;
               return;
            }
            if(this.FDailytask.CurrentID != 0)
            {
               if(_loc9_ > 0)
               {
                  this.FIsRefresh = true;
                  this.FUIWindowRefreshInformation.Text = TUtilityString.Format(STRING_DAILYTASK.STRING_UseCardRefresh,_loc9_);
                  this.FUIWindowRefreshInformation.Visible = true;
               }
               else
               {
                  this.FIsRefresh = true;
                  _loc8_ = new ConsumeFrame(CONST_SYSTEMLANGUAGE.ConsumerConfirm_DailyTask_Refresh).DescribeString;
                  this.FUIWindowInformation.Text = TUtilityString.Format(_loc8_,_loc7_[2]);
                  this.FUIWindowInformation.SetCheckBox(false);
                  this.FUIWindowInformation.Visible = true;
               }
               return;
            }
            if(this.FDailytask.FinishCount >= 10)
            {
               EffectGenerateText(STRING_DAILYTASK.STRING_FinishAllTask);
               return;
            }
            if(!this.FUIWindowInformation.IsSelected || !this.FIsRefreshSelected)
            {
               if(_loc9_ > 0)
               {
                  this.FIsRefresh = true;
                  this.FUIWindowRefreshInformation.Text = TUtilityString.Format(STRING_DAILYTASK.STRING_UseCardRefreshNoTask,_loc9_);
                  this.FUIWindowRefreshInformation.Visible = true;
               }
               else
               {
                  this.FIsRefresh = true;
                  _loc8_ = new ConsumeFrame(CONST_SYSTEMLANGUAGE.ConsumerConfirm_DailyTask_Refresh).DescribeString;
                  this.FUIWindowInformation.Text = TUtilityString.Format(_loc8_,_loc7_[2]);
                  this.FUIWindowInformation.SetCheckBox(true);
                  this.FUIWindowInformation.SetSelectedOrNot(false);
                  this.FUIWindowInformation.Visible = true;
               }
               return;
            }
            if(this.FOnRefrsh != null)
            {
               this.FOnRefrsh();
            }
         }
         else
         {
            if(this.FDailytask.CurrentID != 0)
            {
               this.FIsRefresh = true;
               this.FUIWindowInformation.Text = TUtilityString.Format(STRING_DAILYTASK.FORMAT_Fresh);
               this.FUIWindowInformation.SetCheckBox(false);
               this.FUIWindowInformation.Visible = true;
               return;
            }
            if(this.FOnRefrsh != null)
            {
               this.FOnRefrsh();
            }
         }
      }
      
      protected function TaskReset() : void
      {
         this.FDailytask.CurrentID = 0;
         this.FDailytask.CurrentProgress = 0;
         this.FDailytask.Type = 0;
         this.FTaskList.SetTag(0,9);
         this.resetText();
         this.UpdateOneKeyTimes();
      }
      
      protected function DoTaskOnClick(param1:MouseEvent) : void
      {
         var _loc2_:TQuestDaily = null;
         var _loc3_:uint = 0;
         _loc2_ = this.FDailytask.GetTaskByIdentifier(this.FDailytask.CurrentID);
         _loc3_ = uint(_loc2_.EventType);
         switch(_loc3_)
         {
            case CONST_DAILY_QUEST.Battle:
               if(this.FOnCloseWindow != null)
               {
                  this.FOnCloseWindow();
               }
               if(this.FOnGotoMap != null)
               {
                  this.FOnGotoMap(this);
               }
               return;
            case CONST_DAILY_QUEST.Arena:
               if(this.FOnCloseWindow != null)
               {
                  this.FOnCloseWindow();
               }
               _loc3_ = CONST_POPTIPS.POPTIP_Goto_Arena;
               break;
            case CONST_DAILY_QUEST.Tavern:
               if(this.FOnCloseWindow != null)
               {
                  this.FOnCloseWindow();
               }
               _loc3_ = CONST_POPTIPS.POPTIP_Goto_Tavern;
               break;
            case CONST_DAILY_QUEST.Strengthen:
               _loc3_ = uint(CONST_POPTIPS.POPTIP_Goto_Strengthen);
               break;
            case CONST_DAILY_QUEST.Refined:
               _loc3_ = uint(CONST_POPTIPS.POPTIP_Goto_Strengthen);
               break;
            case CONST_DAILY_QUEST.KillHeros:
               _loc3_ = CONST_POPTIPS.POPTIP_Goto_KillHeros;
               break;
            case CONST_DAILY_QUEST.Pet:
               _loc3_ = uint(CONST_POPTIPS.POPTIP_Goto_SummonPet);
         }
         if(this.FOnGoto != null)
         {
            this.FOnGoto(this,_loc3_);
         }
      }
      
      public function get OnRefrsh() : Function
      {
         return this.FOnRefrsh;
      }
      
      public function set OnRefrsh(param1:Function) : void
      {
         this.FOnRefrsh = param1;
      }
      
      public function get OnPointUpdate() : Function
      {
         return this.FOnPointUpdate;
      }
      
      public function set OnPointUpdate(param1:Function) : void
      {
         this.FOnPointUpdate = param1;
      }
      
      public function get OnTaskReq() : Function
      {
         return this.FOnTaskReq;
      }
      
      public function set OnTaskReq(param1:Function) : void
      {
         this.FOnTaskReq = param1;
      }
      
      public function get OnGoto() : Function
      {
         return this.FOnGoto;
      }
      
      public function set OnGoto(param1:Function) : void
      {
         this.FOnGoto = param1;
      }
      
      public function get OnUpdateDouble() : Function
      {
         return this.FOnUpdateDouble;
      }
      
      public function set OnUpdateDouble(param1:Function) : void
      {
         this.FOnUpdateDouble = param1;
      }
      
      public function get OnEffectExtraPoint() : Function
      {
         return this.FOnEffectExtraPoint;
      }
      
      public function set OnEffectExtraPoint(param1:Function) : void
      {
         this.FOnEffectExtraPoint = param1;
      }
      
      public function get OnCloseWindow() : Function
      {
         return this.FOnCloseWindow;
      }
      
      public function set OnCloseWindow(param1:Function) : void
      {
         this.FOnCloseWindow = param1;
      }
      
      public function get OnGotoMap() : Function
      {
         return this.FOnGotoMap;
      }
      
      public function set OnGotoMap(param1:Function) : void
      {
         this.FOnGotoMap = param1;
      }
      
      public function get HintOnTargetOver() : Function
      {
         return this.FHintOnTargetOver;
      }
      
      public function set HintOnTargetOver(param1:Function) : void
      {
         this.FHintOnTargetOver = param1;
      }
      
      public function get HintOnOut() : Function
      {
         return this.FHintOnOut;
      }
      
      public function set HintOnOut(param1:Function) : void
      {
         this.FHintOnOut = param1;
      }
      
      public function taskInit() : void
      {
         this.FMC_RefreshTask.play();
         this.resetText();
         this.FTaskList.SetTag(0,9);
         if(this.FDailytask.CurrentID != 0)
         {
            this.UnderDoingUpdate();
         }
         this.updateTargetPoint();
         this.updateEffectList();
         this.FIsFinishUnstream = true;
      }
      
      public function updateRefresh() : void
      {
         this.FMC_RefreshTask.play();
         this.FTaskList.SetTag(0,9);
         this.TaskReset();
         this.updateEffectList();
      }
      
      public function update(param1:uint, param2:int = 0) : void
      {
         var _loc3_:TQuestDaily = null;
         switch(param1)
         {
            case 1:
               this.UnderDoingUpdate();
               break;
            case 2:
               this.TaskReset();
               this.FTaskList.SetTag(0,9);
               if(this.FIsGiveAndAccept)
               {
                  this.FID = this.FDailytask.GetTaskByIndex(this.FIndex).Identifier;
                  this.FType = 1;
                  if(this.FOnTaskReq != null)
                  {
                     this.FOnTaskReq(this.FID,this.FType);
                  }
                  this.FType = 0;
                  this.FIsGiveAndAccept = false;
               }
               break;
            case 3:
            case 4:
               if(this.FOnPointUpdate != null)
               {
                  _loc3_ = this.FDailytask.GetTaskByIdentifier(this.FDailytask.CurrentID);
                  this.FDailytask.Point += _loc3_.AwardPoint;
                  this.FOnPointUpdate();
               }
               if(_loc3_.EventType == CONST_DAILY_QUEST.Pay)
               {
                  if(this.FOnUpdateDouble != null)
                  {
                     this.FOnUpdateDouble();
                  }
               }
               this.TargetTaskUpdate(_loc3_);
               ++this.FDailytask.FinishCount;
               this.TaskReset();
               break;
            case 5:
               if(this.FOnPointUpdate != null)
               {
                  this.FDailytask.Point = param2;
                  this.FOnPointUpdate();
               }
               if(this.FOnUpdateDouble != null)
               {
                  this.FOnUpdateDouble();
               }
               this.FDailytask.FinishCount = 10;
               this.TaskReset();
         }
      }
      
      public function UpdateExtraText() : void
      {
         this.updateTargetPoint();
      }
   }
}

