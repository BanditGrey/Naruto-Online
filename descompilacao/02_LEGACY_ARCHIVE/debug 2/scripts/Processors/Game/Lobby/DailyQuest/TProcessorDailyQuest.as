package Processors.Game.Lobby.DailyQuest
{
   import Foundation.Common.TBounds;
   import Foundation.Common.THint;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.Characters.TCharacter;
   import Logics.Dailytask.TDailytask;
   import Logics.Dailytask.TQuestDaily;
   import Logics.DatebaseVO.VO.TArticle;
   import Logics.DatebaseVO.VO.TDailyAward;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.Inventories.TAppliance;
   import Logics.SLogicsCore;
   import Logics.Streamization.DailyTask.TUnstreamizerDailyTasks;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import Rendering.Overlayers.HelpTips.TOverlayerHelpTips;
   import Rendering.Overlayers.Hints.TOverlayerHint;
   import Rendering.Overlayers.Inventories.TOverlayerAppliance;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DAILY_QUEST;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_INVENTORY;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_SHORTCUTS;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_DAILYTASK;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   
   public class TProcessorDailyQuest extends TProcessorLobbyWindows
   {
      
      protected static const SIZE_WIDTH_DAILY_QUEST:uint = 870;
      
      protected static const SIZE_HIGHT_DAILY_QUEST:uint = 550;
      
      protected static const TASK_X:uint = 216;
      
      protected static const TASK_Y:uint = 96;
      
      protected static const POINT_X:uint = 720;
      
      protected static const POINT_Y:uint = 103;
      
      public static const CATEGORY_Equipment:uint = CONST_INVENTORY.CATEGORY_Equipment;
      
      public static const CATEGORY_Treasure:uint = CONST_INVENTORY.CATEGORY_Treasure;
      
      protected var FProcessorWindowTask:TProcessorWindowTask;
      
      protected var FProcessorWindowPoint:TProcessorWindowPoint;
      
      protected var FSP:Sprite;
      
      protected var FBackGround:Sprite;
      
      protected var FBT_Close:SimpleButton;
      
      protected var FBT_Help:SimpleButton;
      
      protected var FMC_Left:MovieClip;
      
      protected var FMC_Right:MovieClip;
      
      protected var FDailyTaskInfo:TDailytask;
      
      protected var FUnstreamizerDailyTasks:TUnstreamizerDailyTasks;
      
      protected var FDailytask:TDailytask;
      
      protected var FCharacter:TCharacter;
      
      protected var FIsInfo:Boolean;
      
      protected var FBoo:Boolean;
      
      protected var FBounds:TBounds;
      
      protected var FDailyAwardBin:TBins;
      
      protected var FHelpHint:THint;
      
      protected var FOnGoto:Function;
      
      protected var FOnGotoMap:Function;
      
      protected var FOnPlayEffect:Function;
      
      protected var FOnEffectSign:Function;
      
      public function TProcessorDailyQuest(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FSP = new Sprite();
         addChild(this.FSP);
         this.FProcessorWindowPoint = new TProcessorWindowPoint(this);
         this.FProcessorWindowPoint.X = POINT_X;
         this.FProcessorWindowPoint.Y = POINT_Y;
         this.FProcessorWindowPoint.ListRewardOnOver = this.ListRewardOnOver;
         this.FProcessorWindowPoint.ListRewardOnOut = this.ListRewardOnOut;
         this.FProcessorWindowTask = new TProcessorWindowTask(this);
         this.FProcessorWindowTask.X = TASK_X;
         this.FProcessorWindowTask.Y = TASK_Y;
         this.FProcessorWindowTask.OnRefrsh = this.TaskRefresh;
         this.FProcessorWindowTask.OnPointUpdate = this.PointUpdate;
         this.FProcessorWindowTask.OnTaskReq = this.OnTaskReq;
         this.FProcessorWindowTask.OnGoto = this.OnGoto;
         this.FProcessorWindowTask.OnUpdateDouble = this.OnUpdateDouble;
         this.FProcessorWindowTask.OnEffectExtraPoint = this.OnEffectExtraPoint;
         this.FProcessorWindowTask.OnCloseWindow = this.OnCloseWindow;
         this.FProcessorWindowTask.OnGotoMap = this.OnGotoMap;
         this.FProcessorWindowTask.HintOnTargetOver = ProcessorTipOnOver;
         this.FProcessorWindowTask.HintOnOut = ProcessorTipOnOut;
         this.FProcessorWindowTask.OnEffectText = ProcessorsOnEffectText;
         this.FBounds = new TBounds();
         this.FBounds.Width = SIZE_WIDTH_DAILY_QUEST;
         this.FBounds.Height = SIZE_HIGHT_DAILY_QUEST;
         this.FDailyTaskInfo = new TDailytask();
         this.FUnstreamizerDailyTasks = new TUnstreamizerDailyTasks();
         this.FDailytask = SLogicsCore.Character.DailyTask;
         this.FCharacter = SLogicsCore.Character;
         SetUIModuleID(CONST_MODULES.MODULE_DailyQuest);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_DAILY_QUEST.RESOURCESID_DAILY_QUEST);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:TSystemLanguage = null;
         this.FBackGround = TUtilityReflection.CreateDisplayObjectInstance(CONST_DAILY_QUEST.RESOURCE_ClassName_DAILY_QUEST) as Sprite;
         this.FSP.addChild(this.FBackGround);
         this.FBT_Help = this.FBackGround[CONST_DAILY_QUEST.RESOURCE_Link_BT_Help];
         this.FBT_Close = this.FBackGround[CONST_DAILY_QUEST.RESOURCE_Link_BT_Close];
         this.FMC_Left = this.FBackGround[CONST_DAILY_QUEST.RESOURCE_Link_MC_Left];
         this.FMC_Right = this.FBackGround[CONST_DAILY_QUEST.RESOURCE_Link_MC_Right];
         FOverlayerHint = new TOverlayerHint(this);
         FOverlayerHint.Visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerHint);
         FOverlayerAppliance = new TOverlayerAppliance(this,CONST_MODULES.MODULE_DailyQuest);
         FOverlayerAppliance.Visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerAppliance);
         FOverlayerHelpTips = new TOverlayerHelpTips(this);
         FOverlayerHelpTips.Visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerHelpTips);
         this.FSP.x = (CONST_COMMON.STAGE_Width - this.FBounds.Width) / 2;
         this.FSP.y = (CONST_COMMON.STAGE_Height - this.FBounds.Height) / 2;
         this.FDailyAwardBin = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_DailyAward);
         this.FHelpHint = new THint();
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.HELPTIPS_DAILYMISSION) as TSystemLanguage;
         this.FHelpHint.Content = _loc1_.Desc;
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
         this.FBT_Close.addEventListener(MouseEvent.CLICK,this.CloseOnCloseWindow);
         this.FBT_Help.addEventListener(MouseEvent.MOUSE_MOVE,this.OnHintHelpMove);
         this.FBT_Help.addEventListener(MouseEvent.ROLL_OUT,this.OnHintHelpOut);
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_DailyTask_InfoRet,this.PerformPacket_SC_DailyTask_InfoResponse);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_DailyTask_TaskRet,this.PerformPacket_SC_DailyTask_TaskResponse);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_DailyTask_FreshRet,this.PerformPacket_SC_DailyTask_FreshRetResponse);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_DailyTask_RewardRet,this.PerformPacket_SC_DailyTask_RewardRetResponse);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_DailyTask_TargetTaskFreshRet,this.PerformPacket_SC_DailyTask_TargetTaskFreshRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_DailyTask_FinishCountRet,this.PerformPacket_SC_DailyTask_FinishCountRet);
      }
      
      protected function DailyQusetInfoReq() : void
      {
         var _loc1_:TPacket = null;
         if(this.FCharacter.GetMainLevel() >= 2 && !this.FIsInfo)
         {
            _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_DailyTask_InfoReq);
            SNetworkCore.Transceiver.PacketTransmit(_loc1_);
         }
      }
      
      protected function PerformPacket_SC_DailyTask_InfoResponse(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:TQuestDaily = null;
         this.FIsInfo = true;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         this.FUnstreamizerDailyTasks.Unstreamize(_loc2_,this.FDailytask,null);
         if(FIsResourcesLoadCompleted)
         {
            this.PlayAnimation();
            this.FProcessorWindowTask.taskInit();
            this.FProcessorWindowTask.Visible = true;
            this.FProcessorWindowPoint.update(true);
            this.FProcessorWindowPoint.Visible = true;
         }
         if(this.FDailytask.CurrentID != 0)
         {
            _loc4_ = this.FDailytask.GetTaskByIdentifier(this.FDailytask.CurrentID) as TQuestDaily;
            if(this.FDailytask.CurrentProgress == _loc4_.KillTime)
            {
               if(this.FOnPlayEffect != null)
               {
                  this.FOnPlayEffect(CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_DailyQuest,true);
               }
               return;
            }
         }
         if(this.FOnPlayEffect != null)
         {
            this.FOnPlayEffect(CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_DailyQuest,false);
         }
         if(this.FOnPlayEffect != null)
         {
            this.FOnPlayEffect(CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_DailyQuest,this.FDailytask.IconIsLight);
         }
      }
      
      protected function PerformPacket_SC_DailyTask_TaskResponse(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:TQuestDaily = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         _loc2_ = param1.Data;
         _loc3_ = int(_loc2_.readUnsignedInt());
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         this.FDailytask.CurrentID = _loc2_.readUnsignedInt();
         _loc4_ = uint(_loc2_.readByte());
         switch(_loc4_)
         {
            case 1:
               EffectGenerateText(STRING_DAILYTASK.STRING_AcceptTask);
               break;
            case 3:
            case 4:
               _loc5_ = this.FDailytask.GetTaskByIdentifier(this.FDailytask.CurrentID);
               _loc6_ = STRING_COMMON.GetItemNameByType(_loc5_.Rewards[0].Type,_loc5_.Rewards[0].Code) + "+" + _loc5_.Rewards[0].Amount.toString();
               _loc7_ = TUtilityString.Format(STRING_DAILYTASK.FORMAT_Progess_AddPoint,_loc5_.AwardPoint);
               EffectGenerateText(STRING_DAILYTASK.STRING_FinishOneTask);
               EffectGenerateText(_loc6_);
               EffectGenerateText(_loc7_);
         }
         if(_loc4_ == 5)
         {
            this.FProcessorWindowTask.update(_loc4_,_loc2_.readUnsignedInt());
         }
         else
         {
            this.FProcessorWindowTask.update(_loc4_);
         }
         if(this.FOnPlayEffect != null)
         {
            this.FOnPlayEffect(CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_DailyQuest,false);
         }
      }
      
      protected function PerformPacket_SC_DailyTask_FreshRetResponse(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         _loc2_ = param1.Data;
         _loc3_ = int(_loc2_.readUnsignedInt());
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         this.FDailytask.FreshCount = _loc2_.readUnsignedShort();
         this.FUnstreamizerDailyTasks.UnstreamizationTask(_loc2_,this.FDailytask,null);
         this.FProcessorWindowTask.updateRefresh();
         EffectGenerateText(STRING_DAILYTASK.STRING_RefreshTask);
      }
      
      protected function PerformPacket_SC_DailyTask_TargetTaskFreshRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         _loc2_ = param1.Data;
         this.FUnstreamizerDailyTasks.UnstreamizationTargetTask(_loc2_,this.FDailytask,null);
         this.FProcessorWindowTask.UpdateExtraText();
      }
      
      protected function PerformPacket_SC_DailyTask_RewardRetResponse(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:TDailyAward = null;
         var _loc6_:TArticle = null;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         _loc2_ = param1.Data;
         _loc3_ = int(_loc2_.readUnsignedInt());
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         this.FDailytask.IsAward = _loc2_.readUnsignedShort();
         this.FProcessorWindowPoint.awardListUpdate();
         _loc4_ = "";
         _loc5_ = this.FDailyAwardBin.GetDatebaseByIndex(this.FProcessorWindowPoint.AwardIndex) as TDailyAward;
         _loc7_ = _loc5_.RewardsVect[0].Type;
         _loc8_ = _loc5_.RewardsVect[0].Code;
         _loc9_ = _loc5_.RewardsVect[0].Amount;
         if(_loc7_ == 1)
         {
            _loc6_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Article,_loc8_) as TArticle;
            _loc4_ = _loc6_.Name + "*" + _loc9_.toString();
         }
         else
         {
            _loc4_ = STRING_COMMON.GetItemNameByType(_loc7_,_loc8_) + "*" + _loc9_.toString();
         }
         if(this.FDailytask.IsDouble == 1)
         {
            _loc4_ += "*2";
         }
         EffectGenerateText(_loc4_);
      }
      
      protected function PerformPacket_SC_DailyTask_FinishCountRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:TQuestDaily = null;
         _loc2_ = param1.Data;
         this.FDailytask.CurrentProgress = _loc2_.readByte();
         if(this.FDailytask.CurrentID != 0)
         {
            _loc4_ = this.FDailytask.GetTaskByIdentifier(this.FDailytask.CurrentID) as TQuestDaily;
            if(this.FDailytask.CurrentProgress == _loc4_.KillTime)
            {
               if(this.FOnPlayEffect != null)
               {
                  this.FOnPlayEffect(CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_DailyQuest,true);
               }
               return;
            }
         }
         if(this.FOnPlayEffect != null)
         {
            this.FOnPlayEffect(CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_DailyQuest,false);
         }
      }
      
      protected function TaskRefresh() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_DailyTaskp_FreshReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function OnTaskReq(param1:uint, param2:uint) : void
      {
         var _loc3_:TPacket = null;
         var _loc4_:ByteArray = null;
         _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_DailyTask_TaskReq);
         _loc4_ = _loc3_.Data;
         _loc4_.writeUnsignedInt(param1);
         _loc4_.writeByte(param2);
         SNetworkCore.Transceiver.PacketTransmit(_loc3_);
      }
      
      protected function ListRewardOnOver(param1:Object) : void
      {
         var _loc2_:TAppliance = null;
         _loc2_ = param1 as TAppliance;
         FOverlayerAppliance.Context = _loc2_;
         FOverlayerAppliance.Render(FUICore.MouseCoordinate);
         FOverlayerAppliance.Show();
      }
      
      protected function ListRewardOnOut(param1:Object) : void
      {
         FOverlayerAppliance.Hide();
      }
      
      protected function PointUpdate() : void
      {
         this.FProcessorWindowPoint.update(false);
      }
      
      protected function OnUpdateDouble() : void
      {
         this.FProcessorWindowPoint.UpdateDouble();
      }
      
      protected function CloseOnCloseWindow(param1:MouseEvent) : void
      {
         ProcessorClose();
      }
      
      protected function OnHintHelpMove(param1:MouseEvent) : void
      {
         FOverlayerHelpTips.Context = this.FHelpHint;
         FOverlayerHelpTips.Render(FUICore.MouseCoordinate);
         FOverlayerHelpTips.Show();
      }
      
      protected function OnHintHelpOut(param1:MouseEvent) : void
      {
         FOverlayerHelpTips.Hide();
      }
      
      protected function OnGotoMap(param1:Object) : void
      {
         if(this.FOnGotoMap != null)
         {
            this.FOnGotoMap(param1);
         }
      }
      
      protected function OnCloseWindow() : void
      {
         ProcessorClose();
      }
      
      protected function PlayAnimation() : void
      {
         this.FMC_Left.gotoAndPlay(1);
         this.FMC_Right.gotoAndPlay(1);
      }
      
      protected function OnGoto(param1:Object, param2:uint) : void
      {
         if(this.FOnGoto != null)
         {
            this.FOnGoto(this,param2);
         }
      }
      
      protected function OnEffectExtraPoint(param1:uint) : void
      {
         var _loc2_:String = null;
         _loc2_ = TUtilityString.Format(STRING_DAILYTASK.FORMAT_Progess_AddPoint,param1);
         EffectGenerateText(_loc2_);
      }
      
      public function get OnGotoTask() : Function
      {
         return this.FOnGoto;
      }
      
      public function set OnGotoTask(param1:Function) : void
      {
         this.FOnGoto = param1;
      }
      
      public function get OnGotoBigMap() : Function
      {
         return this.FOnGotoMap;
      }
      
      public function set OnGotoBigMap(param1:Function) : void
      {
         this.FOnGotoMap = param1;
      }
      
      public function get ProcessorWindowTask() : TProcessorWindowTask
      {
         return this.FProcessorWindowTask;
      }
      
      public function get OnPlayEffect() : Function
      {
         return this.FOnPlayEffect;
      }
      
      public function set OnPlayEffect(param1:Function) : void
      {
         this.FOnPlayEffect = param1;
      }
      
      public function set OnEffectSign(param1:Function) : void
      {
         this.FOnEffectSign = param1;
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         var _loc2_:TPacket = null;
         super.Mount();
         if(!FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowTask.Load();
            this.FProcessorWindowPoint.Load();
            return;
         }
         if(!this.FIsInfo)
         {
            _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_DailyTask_InfoReq);
            SNetworkCore.Transceiver.PacketTransmit(_loc2_);
         }
         if(this.FIsInfo)
         {
            this.PlayAnimation();
            this.FProcessorWindowTask.taskInit();
            this.FProcessorWindowTask.Visible = true;
            this.FProcessorWindowPoint.update(true);
            this.FProcessorWindowPoint.Visible = true;
         }
         TutorialNextStep(2100);
      }
      
      public function InfoReq() : void
      {
         this.DailyQusetInfoReq();
      }
      
      override public function Unmount() : void
      {
         super.Unmount();
         TutorialNextStep(2104);
      }
   }
}

