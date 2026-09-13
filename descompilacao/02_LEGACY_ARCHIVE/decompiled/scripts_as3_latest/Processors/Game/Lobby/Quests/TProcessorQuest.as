package Processors.Game.Lobby.Quests
{
   import Components.Controls.*;
   import Externals.SExternalCore;
   import Foundation.Common.*;
   import Foundation.Network.*;
   import Foundation.Registries.*;
   import Foundation.Resources.*;
   import Foundation.Resources.Bins.*;
   import Foundation.UI.*;
   import Logics.*;
   import Logics.DatebaseVO.VO.*;
   import Logics.Quests.*;
   import Logics.Streamization.Quest.*;
   import Processors.Game.Lobby.Common.*;
   import Processors.Game.Lobby.Shortcuts.Window.*;
   import Processors.Game.Lobby.WorldMap.*;
   import Processors.Game.Plot.*;
   import Resources.Constants.*;
   import Utilities.Move.SlowMovingAnyResource;
   import flash.events.*;
   import flash.text.*;
   import flash.utils.*;
   
   public class TProcessorQuest extends TProcessorLobbyWindows
   {
      
      protected var SIZE_WIDTH_QUESTWINDOW:int = 834;
      
      protected var SIZE_HEIGHT_QUESTWINDOW:int = 537;
      
      protected var FUnstreamizerQuests:TUnstreamizerQuests;
      
      protected var FUnstreamizerFinishedQuests:TUnstreamizerFinishedQuests;
      
      protected var FUnstreamizerQuestAction:TUnstreamizerQuestAction;
      
      protected var FBaseSubQuest:TQuests;
      
      protected var FBaseMainQuest:TQuests;
      
      protected var FQuestMainComplete:TQuests;
      
      protected var FQuestSubComplete:TQuests;
      
      protected var FMainQuestsAlreadyAccept:TQuests;
      
      protected var FSubQuestsAlreadyAccept:TQuests;
      
      protected var FMainQuestsCanAccept:TQuests;
      
      protected var FSubQuestsCanAccept:TQuests;
      
      protected var FTaskAction:TTaskAction;
      
      protected var FQuestActionRoutines:TRegistryRoutine;
      
      protected var FWindowQuest:TProcessorWindowQuest;
      
      protected var FBoundsQuest:TBounds;
      
      protected var FWorldMapEnteringCity:Boolean;
      
      protected var FCurrentSearchingQuest:TQuest;
      
      protected var FTasks:TBins;
      
      protected var FQuestID_Main_Max:int;
      
      protected var FQuestID_Main_Min:int;
      
      protected var FQuestID_Sub_Max:int;
      
      protected var FQuestID_Sub_Min:int;
      
      protected var FLoadQuestComplete:Boolean;
      
      protected var FQuestGuide:TWindowQuestGuide;
      
      protected var FOnAutoSearchWay:Function;
      
      protected var FOnSearchWayInWorldMap:Function;
      
      protected var FOnSearchWayOnKillMonster:Function;
      
      protected var FOnProcessorCheckPlot:Function;
      
      protected var FOnSearchNewQuest:Function;
      
      protected var FOnUpdateQuestState:Function;
      
      protected var FDoAfterComplteQuest:Function;
      
      protected var FDoAfterInitQuest:Function;
      
      protected var FOnAcceptTaskEffect:Function;
      
      protected var FOnCompleteTaskEffect:Function;
      
      protected var FOnUpdateNpc:Function;
      
      protected var FFreshGuideCompleteQuest:Function;
      
      protected var TFA:TextField;
      
      protected var TFB:TextField;
      
      protected var FStatisticsVect:Vector.<uint>;
      
      protected var Counter:int = 0;
      
      protected var TagLook:Boolean;
      
      public function TProcessorQuest(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FUnstreamizerFinishedQuests = new TUnstreamizerFinishedQuests();
         this.FUnstreamizerQuests = new TUnstreamizerQuests();
         this.FUnstreamizerQuestAction = new TUnstreamizerQuestAction();
         this.FBaseSubQuest = new TQuests();
         this.FBaseMainQuest = new TQuests();
         this.FQuestMainComplete = SLogicsCore.Character.MainQuestComplete;
         this.FQuestSubComplete = SLogicsCore.Character.SubQuestComplete;
         this.FMainQuestsAlreadyAccept = SLogicsCore.Character.MainQuestsAlreadyAccept;
         this.FSubQuestsAlreadyAccept = SLogicsCore.Character.SubQuestsAlreadyAccept;
         this.FMainQuestsCanAccept = SLogicsCore.Character.MainQuestsCanAccept;
         this.FSubQuestsCanAccept = SLogicsCore.Character.SubQuestsCanAccept;
         this.FTaskAction = new TTaskAction();
         this.FQuestActionRoutines = new TRegistryRoutine();
         this.ConstructQuestActionRoutine(this.FQuestActionRoutines);
         this.FWindowQuest = new TProcessorWindowQuest(this);
         this.FWindowQuest.OnTextClick = this.HandleTextClick;
         this.FBoundsQuest = new TBounds();
         this.FBoundsQuest.Width = this.SIZE_WIDTH_QUESTWINDOW;
         this.FBoundsQuest.Height = this.SIZE_HEIGHT_QUESTWINDOW;
         ComponentBoundsCenter(this.FWindowQuest,this.FBoundsQuest);
         SetUIModuleID(CONST_MODULES.MODULE_Quest);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_QUEST.RESOURCESID_Swf_Quest);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Task_QuestActionRet,this.PerformPacket_SC_QuestActionRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Task_AlreadyAcceptTaskRet,this.PerformPacket_SC_AlreadyAcceptTask);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Task_AlreadyFinishTaskRet,this.PerformPacket_SC_AlreadyFinishTask);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Task_CompleteSendInfor,this.PerformPacket_SC_SendInforFinish);
      }
      
      protected function PerformPacket_SC_QuestActionRet(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Vector.<int> = null;
         this.FUnstreamizerQuestAction.Unstreamize(param1.Data,this.FTaskAction,null);
         if(this.FTaskAction.ResultCode == 0)
         {
            TutorialNextStep(201);
            this.HandleQuestAction(this.FTaskAction);
         }
         else
         {
            EffectGenerateTextByErrorCode(this.FTaskAction.ResultCode);
         }
      }
      
      protected function PerformPacket_SC_AlreadyAcceptTask(param1:TPacket) : void
      {
         this.FUnstreamizerQuests.Unstreamize(param1.Data,this.FBaseMainQuest,this.FBaseSubQuest);
      }
      
      protected function PerformPacket_SC_AlreadyFinishTask(param1:TPacket) : void
      {
         this.FUnstreamizerFinishedQuests.Unstreamize(param1.Data,this.FBaseMainQuest,this.FBaseSubQuest);
      }
      
      protected function PerformPacket_SC_SendInforFinish(param1:TPacket) : void
      {
         this.SelectQuestsByState(this.FBaseMainQuest,this.FQuestMainComplete,CONST_QUEST.STATE_ALREADYBACK);
         this.SelectQuestsByState(this.FBaseSubQuest,this.FQuestSubComplete,CONST_QUEST.STATE_ALREADYBACK);
         this.SelectQuestsByState(this.FBaseMainQuest,this.FMainQuestsAlreadyAccept,CONST_QUEST.STATE_TASKING);
         this.SelectQuestsByState(this.FBaseSubQuest,this.FSubQuestsAlreadyAccept,CONST_QUEST.STATE_TASKING);
         this.SendNpcNewQuestes(this.FMainQuestsAlreadyAccept);
         this.SendNpcNewQuestes(this.FSubQuestsAlreadyAccept);
         this.ShowQuests(this.FMainQuestsAlreadyAccept,TWindowQuestGuide.TAG_ALREADYACCEPT);
         this.ShowQuests(this.FSubQuestsAlreadyAccept,TWindowQuestGuide.TAG_ALREADYACCEPT);
         this.CheckAndDoAlreadyAcceptQuests(this.FMainQuestsAlreadyAccept);
         this.CheckAndDoAlreadyAcceptQuests(this.FSubQuestsAlreadyAccept);
         this.SelectAndShowCanAcceptTask();
         if(this.FDoAfterInitQuest != null)
         {
            this.FDoAfterInitQuest();
         }
         this.FLoadQuestComplete = true;
      }
      
      protected function SendNpcNewQuestes(param1:TQuests) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TQuest = null;
         _loc3_ = param1.Count;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = param1.GetQuestByIndex(_loc2_);
            this.FOnSearchNewQuest(_loc4_);
            _loc2_++;
         }
      }
      
      protected function PerformPacket_CS_UserTaskReq(param1:int, param2:int) : void
      {
         var _loc3_:TPacket = null;
         var _loc4_:TConfigValue = null;
         _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Task_QuestActionReq);
         _loc3_.Data.writeInt(param2);
         _loc3_.Data.writeByte(param1);
         SNetworkCore.Transceiver.PacketTransmit(_loc3_);
         if(this.FStatisticsVect == null)
         {
            this.FStatisticsVect = TConfigValue(SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.GUIDE_STATISTICS)).Value as Vector.<uint>;
         }
         if(this.FStatisticsVect != null && this.FStatisticsVect.indexOf(param2) >= 0)
         {
            SExternalCore.BrazilLogQuestLog(param2,param1 + 1);
         }
      }
      
      protected function PerformPacket_CS_QuestInforReq() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_SC_Task_QuestInforReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function SelectAndShowCanAcceptTask() : void
      {
         this.SeleteMainQuestCanAccept();
         this.SelectSubQuestCanAccept();
      }
      
      protected function SeleteMainQuestCanAccept() : void
      {
         var _loc1_:* = 0;
         var _loc2_:int = 0;
         var _loc3_:TQuest = null;
         var _loc4_:TQuest = null;
         var _loc5_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < this.FBaseMainQuest.Count)
         {
            _loc3_ = this.FBaseMainQuest.GetQuestByIndex(_loc1_);
            _loc4_ = this.FQuestMainComplete.GetQuestByIdentifier(_loc3_.PreQuestId);
            if(_loc3_.PreQuestId != 0 && _loc4_ == null)
            {
               return;
            }
            _loc5_ = int(SLogicsCore.Character.GetMainLevel());
            if(_loc3_.RequirementLevelMin > SLogicsCore.Character.GetMainLevel())
            {
               if(!(this.FMainQuestsAlreadyAccept.Count == 0 && this.FMainQuestsCanAccept.Count == 0))
               {
                  return;
               }
            }
            _loc3_.TaskState = CONST_QUEST.STATE_ACCEPT;
            this.FMainQuestsCanAccept.Add(_loc3_);
            this.FBaseMainQuest.DeleteQuestByIdentifier(_loc3_.Identifier);
            _loc1_--;
            this.AddShowOneQuest(_loc3_,TWindowQuestGuide.TAG_CANACCEPT);
            this.FOnSearchNewQuest(_loc3_);
            _loc1_++;
         }
      }
      
      protected function SelectSubQuestCanAccept() : void
      {
         var _loc1_:* = 0;
         var _loc2_:int = 0;
         var _loc3_:TQuest = null;
         var _loc4_:TQuest = null;
         _loc1_ = 0;
         while(_loc1_ < this.FBaseSubQuest.Count)
         {
            _loc3_ = this.FBaseSubQuest.GetQuestByIndex(_loc1_);
            _loc4_ = this.FQuestMainComplete.GetQuestByIdentifier(_loc3_.PreQuestId);
            if(_loc4_ == null)
            {
               return;
            }
            _loc3_.TaskState = CONST_QUEST.STATE_ACCEPT;
            this.FSubQuestsCanAccept.Add(_loc3_);
            this.FBaseSubQuest.DeleteQuestByIdentifier(_loc3_.Identifier);
            _loc1_--;
            this.AddShowOneQuest(_loc3_,TWindowQuestGuide.TAG_CANACCEPT);
            this.FOnSearchNewQuest(_loc3_);
            _loc1_++;
         }
      }
      
      protected function ProcessorInitQuests() : void
      {
         var _loc1_:int = 0;
         this.FUnstreamizerQuests.UnstreamizeQuestsByDatabases(null,this.FBaseMainQuest,this.FBaseSubQuest);
         _loc1_ = this.FBaseMainQuest.Count;
         this.FQuestID_Main_Max = this.FBaseMainQuest.GetQuestByIndex(_loc1_ - 1).Identifier;
         this.FQuestID_Main_Min = this.FBaseMainQuest.GetQuestByIndex(0).Identifier;
         _loc1_ = this.FBaseSubQuest.Count;
         this.FQuestID_Sub_Max = this.FBaseSubQuest.GetQuestByIndex(_loc1_ - 1).Identifier;
         this.FQuestID_Sub_Min = this.FBaseSubQuest.GetQuestByIndex(0).Identifier;
      }
      
      protected function SelectQuestsByState(param1:TQuests, param2:TQuests, param3:int) : void
      {
         var _loc4_:TQuest = null;
         var _loc5_:* = 0;
         _loc5_ = 0;
         while(_loc5_ < param1.Count)
         {
            _loc4_ = param1.GetQuestByIndex(_loc5_);
            if(_loc4_.TaskState == param3)
            {
               param2.Add(_loc4_);
               param1.DeleteQuestByIdentifier(_loc4_.Identifier);
               _loc5_--;
            }
            _loc5_++;
         }
      }
      
      protected function AddShowOneQuestList(param1:Array, param2:int) : void
      {
         this.FQuestGuide.AddTaskList(param1,param2);
      }
      
      protected function AddShowOneQuest(param1:TQuest, param2:int) : void
      {
         this.FQuestGuide.AddTask(param1,param2);
      }
      
      protected function UpdateShowOneQuest(param1:TQuest, param2:Boolean = true) : void
      {
         this.FQuestGuide.UpdateTaskInfor(param1,param2);
      }
      
      protected function DeleteShowOneQuest(param1:TQuest) : void
      {
         this.FQuestGuide.DeleteTask(param1);
      }
      
      protected function ShowQuests(param1:TQuests, param2:int) : void
      {
         var _loc3_:TQuest = null;
         var _loc4_:int = 0;
         var _loc6_:Array = null;
         var _loc5_:int = param1.Count;
         if(_loc5_ > 1)
         {
            _loc6_ = [];
            _loc4_ = 0;
            while(_loc4_ < param1.Count)
            {
               _loc3_ = param1.GetQuestByIndex(_loc4_);
               _loc6_.push(_loc3_);
               _loc4_++;
            }
            this.AddShowOneQuestList(_loc6_,param2);
         }
         else
         {
            _loc4_ = 0;
            while(_loc4_ < param1.Count)
            {
               _loc3_ = param1.GetQuestByIndex(_loc4_);
               this.AddShowOneQuest(_loc3_,param2);
               _loc4_++;
            }
         }
      }
      
      protected function QuestGoAhead(param1:TQuest, param2:int) : void
      {
         switch(param1.TaskState)
         {
            case CONST_QUEST.STATE_ACCEPT:
               this.HandleCanAccpetTaskClick(param1,param2);
               break;
            case CONST_QUEST.STATE_TASKING:
               this.HandleAlreadyAcceptTaskClick(param1,param2);
               break;
            case CONST_QUEST.STATE_TASKBACK:
               this.HandleAlreadyCompleteTaskClick(param1,param2);
         }
      }
      
      protected function HandleCanAccpetTaskClick(param1:TQuest, param2:int) : void
      {
         if(param1.AcceptTaskNpc != param2)
         {
            this.HandleSearchWay(param1);
         }
         else
         {
            this.PerformPacket_CS_UserTaskReq(CONST_QUEST.ACTIONID_ACCEPT,param1.Identifier);
         }
      }
      
      protected function HandleAlreadyCompleteTaskClick(param1:TQuest, param2:int) : void
      {
         if(param2 != param1.BackTaskNpc)
         {
            this.HandleAlreadyAcceptTaskClick(param1,param2);
         }
         else
         {
            this.PerformPacket_CS_UserTaskReq(CONST_QUEST.ACTIONID_COMPLETE,param1.Identifier);
         }
      }
      
      protected function HandleAlreadyAcceptTaskClick(param1:TQuest, param2:int) : void
      {
         this.HandleSearchWay(param1);
      }
      
      protected function ConstructQuestActionRoutine(param1:TRegistryRoutine) : void
      {
         param1.Register(CONST_QUEST.ACTIONID_ACCEPT,this.HandleQuestActionAccept);
         param1.Register(CONST_QUEST.ACTIONID_COMPLETE,this.HandleQuestActionComplete);
         param1.Register(CONST_QUEST.ACTIONID_CANCLE,this.HandleQuestActionCancle);
      }
      
      protected function HandleQuestAction(param1:TTaskAction) : void
      {
         var _loc2_:Function = null;
         _loc2_ = this.FQuestActionRoutines.GetRoutineByIndentifier(param1.ActionID);
         if(_loc2_ != null)
         {
            _loc2_(param1);
         }
      }
      
      protected function ProcessorCheckPlot(param1:uint, param2:uint) : void
      {
         if(this.FOnProcessorCheckPlot != null)
         {
            this.FOnProcessorCheckPlot(this,TProcessorPlot.PLOT_TYPE_Task,param1,param2);
         }
      }
      
      protected function HandleQuestActionAccept(param1:TTaskAction) : void
      {
         var _loc2_:TQuest = null;
         var _loc3_:int = 0;
         _loc3_ = this.CheckQuestType(param1.QuestID);
         switch(_loc3_)
         {
            case CONST_QUEST.QuestCategory_Main:
               _loc2_ = this.FMainQuestsCanAccept.GetQuestByIdentifier(param1.QuestID);
               if(_loc2_ != null)
               {
                  this.FMainQuestsCanAccept.DeleteQuestByIdentifier(param1.QuestID);
                  this.DeleteShowOneQuest(_loc2_);
                  this.FMainQuestsAlreadyAccept.Add(_loc2_);
               }
               this.ProcessorCheckPlot(TProcessorPlot.PLOT_POS_Befor,param1.QuestID);
               break;
            case CONST_QUEST.QuestCategory_Branch:
               _loc2_ = this.FSubQuestsCanAccept.GetQuestByIdentifier(param1.QuestID);
               if(_loc2_ != null)
               {
                  this.FSubQuestsCanAccept.DeleteQuestByIdentifier(param1.QuestID);
                  this.DeleteShowOneQuest(_loc2_);
                  this.FSubQuestsAlreadyAccept.Add(_loc2_);
               }
         }
         if(_loc2_ != null)
         {
            _loc2_.TaskState = CONST_QUEST.STATE_TASKING;
            if(_loc2_.EventType != CONST_QUEST.QuestEventTypeJustRun)
            {
               this.AddShowOneQuest(_loc2_,TWindowQuestGuide.TAG_ALREADYACCEPT);
            }
            else
            {
               _loc2_.TaskState = CONST_QUEST.STATE_TASKBACK;
               this.AddShowOneQuest(_loc2_,TWindowQuestGuide.TAG_ALREADYACCEPT);
            }
            this.FOnUpdateQuestState(_loc2_);
            if(this.FOnAcceptTaskEffect != null)
            {
               this.FOnAcceptTaskEffect(this);
            }
         }
      }
      
      protected function HandleQuestActionComplete(param1:TTaskAction) : void
      {
         var _loc2_:TQuest = null;
         var _loc3_:int = 0;
         var _loc4_:TQuests = null;
         var _loc5_:TQuest = null;
         _loc3_ = this.CheckQuestType(param1.QuestID);
         SlowMovingAnyResource.getInstance().HandleQuest(param1.QuestID);
         switch(_loc3_)
         {
            case CONST_QUEST.QuestCategory_Main:
               _loc4_ = this.FMainQuestsAlreadyAccept;
               break;
            case CONST_QUEST.QuestCategory_Branch:
               _loc4_ = this.FSubQuestsAlreadyAccept;
         }
         if(_loc4_ == null)
         {
            return;
         }
         _loc2_ = _loc4_.GetQuestByIdentifier(param1.QuestID);
         if(_loc2_ == null)
         {
            return;
         }
         this.ProcessorCheckPlot(TProcessorPlot.PLOT_POS_End,param1.QuestID);
         _loc4_.DeleteQuestByIdentifier(param1.QuestID);
         _loc2_.TaskState = CONST_QUEST.STATE_ALREADYBACK;
         this.DeleteShowOneQuest(_loc2_);
         switch(_loc3_)
         {
            case CONST_QUEST.QuestCategory_Main:
               this.FQuestMainComplete.Add(_loc2_);
               break;
            case CONST_QUEST.QuestCategory_Branch:
               this.FQuestSubComplete.Add(_loc2_);
         }
         this.FOnUpdateQuestState(_loc2_);
         this.SelectAndShowCanAcceptTask();
         if(this.FOnCompleteTaskEffect != null)
         {
            this.FOnCompleteTaskEffect(this);
         }
         if(this.FOnUpdateNpc != null)
         {
            this.FOnUpdateNpc();
         }
         if(this.FFreshGuideCompleteQuest != null)
         {
            this.FFreshGuideCompleteQuest(_loc2_);
         }
      }
      
      protected function HandleQuestActionCancle(param1:TTaskAction) : void
      {
         var _loc2_:TQuest = null;
         var _loc3_:int = 0;
         _loc3_ = this.CheckQuestType(param1.QuestID);
         switch(_loc3_)
         {
            case CONST_QUEST.QuestCategory_Main:
               _loc2_ = this.FMainQuestsAlreadyAccept.GetQuestByIdentifier(param1.QuestID);
               break;
            case CONST_QUEST.QuestCategory_Branch:
               _loc2_ = this.FSubQuestsAlreadyAccept.GetQuestByIdentifier(param1.QuestID);
         }
         if(_loc2_ != null)
         {
            this.DeleteShowOneQuest(_loc2_);
         }
      }
      
      protected function CheckAndDoAlreadyAcceptQuests(param1:TQuests) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TQuest = null;
         _loc3_ = param1.Count;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = param1.GetQuestByIndex(_loc2_);
            this.CheckAndDoCompleteObject(_loc4_,_loc2_ + 1 == _loc3_ ? true : false);
            _loc2_++;
         }
      }
      
      protected function CheckAndDoCompleteObject(param1:TQuest, param2:Boolean = true) : void
      {
         if(param1.EventType == CONST_QUEST.QuestEventTypeJustRun)
         {
            param1.TaskState = CONST_QUEST.STATE_TASKBACK;
            this.FOnUpdateQuestState(param1);
            this.UpdateShowOneQuest(param1,param2);
         }
         else if(param1.EventType == CONST_QUEST.QuestEventTypeKillMonster)
         {
            if(param1.CurrentfKillTime >= param1.KillTime)
            {
               param1.TaskState = CONST_QUEST.STATE_TASKBACK;
               this.FOnUpdateQuestState(param1);
               this.UpdateShowOneQuest(param1,param2);
            }
            else
            {
               this.UpdateShowOneQuest(param1,param2);
            }
         }
      }
      
      protected function KillMonsterIFCompleteTask(param1:int, param2:int, param3:TQuests) : void
      {
         var _loc4_:TQuest = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         _loc6_ = param3.Count;
         _loc5_ = 0;
         while(_loc5_ < _loc6_)
         {
            _loc4_ = param3.GetQuestByIndex(_loc5_);
            if(_loc4_.EventType == CONST_QUEST.QuestEventTypeKillMonster)
            {
               if(param1 == _loc4_.CampId)
               {
                  _loc4_.CurrentfKillTime += param2;
                  this.CheckAndDoCompleteObject(_loc4_);
               }
            }
            _loc5_++;
         }
      }
      
      protected function CheckQuestType(param1:int) : int
      {
         if(param1 <= this.FQuestID_Main_Max && param1 >= this.FQuestID_Main_Min)
         {
            return CONST_QUEST.QuestCategory_Main;
         }
         if(param1 <= this.FQuestID_Sub_Max && param1 >= this.FQuestID_Sub_Min)
         {
            return CONST_QUEST.QuestCategory_Branch;
         }
         return CONST_QUEST.QuestCategory_Daily;
      }
      
      public function NotifyKillMonster(param1:int, param2:int) : void
      {
         this.KillMonsterIFCompleteTask(param1,param2,this.FMainQuestsAlreadyAccept);
         this.KillMonsterIFCompleteTask(param1,param2,this.FSubQuestsAlreadyAccept);
      }
      
      public function HandleTextClick(param1:String) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TQuest = null;
         _loc2_ = int(param1);
         _loc3_ = this.CheckQuestType(_loc2_);
         switch(_loc3_)
         {
            case CONST_QUEST.QuestCategory_Main:
               _loc4_ = this.FMainQuestsAlreadyAccept.GetQuestByIdentifier(_loc2_);
               if(_loc4_ != null)
               {
                  break;
               }
               _loc4_ = this.FMainQuestsCanAccept.GetQuestByIdentifier(_loc2_);
               break;
            case CONST_QUEST.QuestCategory_Branch:
               _loc4_ = this.FSubQuestsAlreadyAccept.GetQuestByIdentifier(_loc2_);
               if(_loc4_ != null)
               {
                  break;
               }
               _loc4_ = this.FSubQuestsCanAccept.GetQuestByIdentifier(_loc2_);
         }
         if(_loc4_ != null)
         {
            this.HandleSearchWay(_loc4_);
         }
      }
      
      public function OnTaskBtnClick(param1:Object) : void
      {
         if(this.FWindowQuest.visible)
         {
            this.FWindowQuest.Close();
         }
      }
      
      public function HandleSearchWay(param1:TQuest) : void
      {
         switch(SLogicsCore.Character.RoleSencePosition)
         {
            case CONST_COMMON.SCENEPOSITION_MAINCITY:
               this.SearchWayInTown(param1);
               break;
            case CONST_COMMON.SCENEPOSITION_WORLDMAP:
               this.SearchWayInWorldMap(param1);
               break;
            case CONST_COMMON.SCENEPOSITION_BATTLESENCE:
               this.SearchWayInBattleScene();
         }
      }
      
      protected function SearchWayInTown(param1:TQuest) : void
      {
         if(this.FOnAutoSearchWay != null)
         {
            SLogicsCore.AutoSearching = true;
            SLogicsCore.AutoSearchQuest = param1;
            this.FOnAutoSearchWay(param1);
         }
      }
      
      protected function SearchWayInWorldMap(param1:TQuest) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         _loc2_ = 0;
         _loc3_ = 0;
         _loc4_ = 0;
         switch(param1.TaskState)
         {
            case CONST_QUEST.STATE_ACCEPT:
               _loc2_ = 1;
               _loc3_ = uint(param1.AcceptTaskNpcCityID);
               this.FWorldMapEnteringCity = true;
               this.FCurrentSearchingQuest = param1;
               break;
            case CONST_QUEST.STATE_TASKING:
               _loc2_ = 2;
               _loc3_ = uint(param1.CityID);
               _loc4_ = uint(param1.CampId);
               break;
            case CONST_QUEST.STATE_TASKBACK:
               _loc2_ = 1;
               _loc3_ = uint(param1.BackTaskNpcCityID);
               this.FWorldMapEnteringCity = true;
               this.FCurrentSearchingQuest = param1;
         }
         if(this.FOnSearchWayInWorldMap != null)
         {
            this.FOnSearchWayInWorldMap(_loc2_,_loc3_,_loc4_,true);
            SLogicsCore.AutoSearching = true;
            SLogicsCore.AutoSearchQuest = param1;
         }
      }
      
      protected function SearchWayInBattleScene() : void
      {
         if(this.FOnSearchWayOnKillMonster != null)
         {
            this.FOnSearchWayOnKillMonster();
         }
      }
      
      public function NotifyNpcTaskClick(param1:TQuest, param2:int) : void
      {
         this.QuestGoAhead(param1,param2);
      }
      
      public function OnSearchWayComplete(param1:TQuest) : void
      {
         switch(param1.TaskState)
         {
            case CONST_QUEST.STATE_ACCEPT:
               this.PerformPacket_CS_UserTaskReq(0,param1.Identifier);
               break;
            case CONST_QUEST.STATE_TASKING:
               break;
            case CONST_QUEST.STATE_TASKBACK:
               this.PerformPacket_CS_UserTaskReq(2,param1.Identifier);
         }
      }
      
      public function get QuestGuide() : TWindowQuestGuide
      {
         return this.FQuestGuide;
      }
      
      public function set QuestGuide(param1:TWindowQuestGuide) : void
      {
         this.FQuestGuide = param1;
         this.FQuestGuide.OnTextClick = this.HandleTextClick;
      }
      
      override public function set OnClose(param1:Function) : void
      {
         FOnClose = param1;
         this.FWindowQuest.OnClose = param1;
      }
      
      public function set OnAutoSearchWay(param1:Function) : void
      {
         this.FOnAutoSearchWay = param1;
      }
      
      public function set OnSearchWayOnKillMonster(param1:Function) : void
      {
         this.FOnSearchWayOnKillMonster = param1;
      }
      
      public function set OnSearchWayInWorldMap(param1:Function) : void
      {
         this.FOnSearchWayInWorldMap = param1;
      }
      
      public function get OnProcessorCheckPlot() : Function
      {
         return this.FOnProcessorCheckPlot;
      }
      
      public function set OnProcessorCheckPlot(param1:Function) : void
      {
         this.FOnProcessorCheckPlot = param1;
      }
      
      public function set OnSearchNewQuest(param1:Function) : void
      {
         this.FOnSearchNewQuest = param1;
      }
      
      public function set OnUpdateQuestState(param1:Function) : void
      {
         this.FOnUpdateQuestState = param1;
      }
      
      public function set DoAfterInitQuest(param1:Function) : void
      {
         this.FDoAfterInitQuest = param1;
      }
      
      public function set DoAfterCompleteQuest(param1:Function) : void
      {
         this.FDoAfterComplteQuest = param1;
      }
      
      public function set OnAcceptTaskEffect(param1:Function) : void
      {
         this.FOnAcceptTaskEffect = param1;
      }
      
      public function set OnCompleteTaskEffect(param1:Function) : void
      {
         this.FOnCompleteTaskEffect = param1;
      }
      
      public function set OnUpdateNpc(param1:Function) : void
      {
         this.FOnUpdateNpc = param1;
      }
      
      public function set FreshGuideCompleteQuest(param1:Function) : void
      {
         this.FFreshGuideCompleteQuest = param1;
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount();
         if(!FIsResourcesLoadCompleted)
         {
            this.FWindowQuest.Load();
            return;
         }
         this.FWindowQuest.visible = true;
         this.FWindowQuest.AlreadyAcceptMainQuestes = this.FMainQuestsAlreadyAccept;
         this.FWindowQuest.AlreadyAcceptSubQuestes = this.FSubQuestsAlreadyAccept;
         this.FWindowQuest.CanAcceptMainQuestes = this.FMainQuestsCanAccept;
         this.FWindowQuest.CanAcceptSubQuestes = this.FSubQuestsCanAccept;
         this.FWindowQuest.Update();
      }
      
      public function InitQuests() : void
      {
         this.ProcessorInitQuests();
      }
      
      public function HandleRoleEnterCity() : void
      {
         if(this.FWorldMapEnteringCity)
         {
            this.HandleSearchWay(this.FCurrentSearchingQuest);
            this.FWorldMapEnteringCity = false;
            this.FCurrentSearchingQuest = null;
         }
      }
      
      public function RoleLevelUp() : void
      {
         var _loc1_:TQuest = null;
         if(!this.FLoadQuestComplete)
         {
            return;
         }
         if(this.FMainQuestsCanAccept.Count > 0)
         {
            _loc1_ = this.FMainQuestsCanAccept.GetQuestByIndex(0);
            if(_loc1_.RequirementLevelMin >= SLogicsCore.Character.GetMainLevel())
            {
               this.UpdateShowOneQuest(_loc1_);
            }
         }
         this.SelectAndShowCanAcceptTask();
      }
      
      public function ManticSearchWay() : void
      {
         this.HandleTextClick("16100001");
      }
   }
}

