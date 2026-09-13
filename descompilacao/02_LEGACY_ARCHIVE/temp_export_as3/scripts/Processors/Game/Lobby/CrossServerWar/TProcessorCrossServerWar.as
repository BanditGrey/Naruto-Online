package Processors.Game.Lobby.CrossServerWar
{
   import Foundation.Common.TBounds;
   import Foundation.Common.THint;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityString;
   import Logics.CrossServerWar.TChallengePlayer;
   import Logics.CrossServerWar.TChallengePlayers;
   import Logics.CrossServerWar.TCrossServerReport;
   import Logics.CrossServerWar.TCrossServerReports;
   import Logics.CrossServerWar.TEliteRecord;
   import Logics.CrossServerWar.TIntegralRankings;
   import Logics.CrossServerWar.TOrangeInventorySample;
   import Logics.CrossServerWar.TToastRecords;
   import Logics.CrossServerWar.TTokenInventorySample;
   import Logics.DatebaseVO.VO.TGSPVP_DailyAward;
   import Logics.DatebaseVO.VO.TGSPVP_Reward;
   import Logics.SLogicsCore;
   import Logics.Streamization.CrossServerWar.TUnstreamizerCrossServerPlayer;
   import Logics.Streamization.CrossServerWar.TUnstreamizerCrossServerReport;
   import Logics.Streamization.CrossServerWar.TUnstreamizerEliteRecord;
   import Logics.Streamization.CrossServerWar.TUnstreamizerIntegralRanking;
   import Logics.Streamization.CrossServerWar.TUnstreamizerToastRecord;
   import Processors.Game.Common.Effects.Texts.TEffectCoordinateParameters;
   import Processors.Game.Common.Effects.Texts.TEffectTextParameters;
   import Processors.Game.Lobby.Common.Shortcuts.TLobbyShortcutActiveSpecialModes;
   import Processors.Game.Lobby.Common.Shortcuts.TLobbyShortcutActivityModes;
   import Processors.Game.Lobby.Common.Shortcuts.TLobbyShortcutAvatarModes;
   import Processors.Game.Lobby.Common.Shortcuts.TLobbyShortcutConstantlyModes;
   import Processors.Game.Lobby.Common.Shortcuts.TLobbyShortcutFunctionModes;
   import Processors.Game.Lobby.Common.Shortcuts.TLobbyShortcutMapModes;
   import Processors.Game.Lobby.Common.Shortcuts.TLobbyShortcutMode;
   import Processors.Game.Lobby.Common.Shortcuts.TLobbyShortcutModes;
   import Processors.Game.Lobby.Common.Shortcuts.TLobbyShortcutQuestGuideModes;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyPlate;
   import Processors.Game.Windows.Information.TUIWindowBattleSkip;
   import Rendering.Overlayers.CrossServerWar.TOverLayerCrossServerPlayerInfo;
   import Rendering.Overlayers.CrossServerWar.TOverlayerChallengeTreasure;
   import Rendering.Overlayers.HelpTips.TOverlayerHelpTips;
   import Rendering.Overlayers.Hints.TOverlayerHint;
   import Rendering.Overlayers.TOverlayer;
   import Resources.Constants.CONST_BATTLE;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_CROSSSERVERWAR;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_SHORTCUTS;
   import Resources.Strings.STRING_CROSSSERVERWAR;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.utils.ByteArray;
   import ghostcat.util.easing.TweenUtil;
   
   public class TProcessorCrossServerWar extends TProcessorLobbyPlate
   {
      
      protected var FProcessorWindowCrossServerWar:TProcessorWindowCrossServerWar;
      
      protected var FProcessorWindowChallengeLadder:TProcessorWindowChallengeLadder;
      
      protected var FSoulExchangeBounds:TBounds;
      
      protected var FCheersBounds:TBounds;
      
      protected var FChallengeRankingsBounds:TBounds;
      
      protected var FChallengeLadderBounds:TBounds;
      
      protected var FUnstreamizerCrossServerPlayer:TUnstreamizerCrossServerPlayer;
      
      protected var FUnstreamizerEliteRecord:TUnstreamizerEliteRecord;
      
      protected var FUnstreamizerIntegralRanking:TUnstreamizerIntegralRanking;
      
      protected var FUnstreamizerToastRecord:TUnstreamizerToastRecord;
      
      protected var FStepChallengePlayers:TChallengePlayers;
      
      protected var FSkipChallengePlayers:TChallengePlayers;
      
      protected var FEliteRecord:TEliteRecord;
      
      protected var FIntegralRankings:TIntegralRankings;
      
      protected var FCrossServerReports:TCrossServerReports;
      
      protected var FUnstreamizerCrossServerReport:TUnstreamizerCrossServerReport;
      
      protected var FChallengePlayer:TChallengePlayer;
      
      protected var FOverLayerCrossServerPlayerInfo:TOverLayerCrossServerPlayerInfo;
      
      protected var FOverlayerChallengeTreasure:TOverlayerChallengeTreasure;
      
      protected var FOverlayerHelpTips:TOverlayerHelpTips;
      
      protected var FOverlayerHint:TOverlayerHint;
      
      protected var FUIWindowBattleSkip:TUIWindowBattleSkip;
      
      protected var FToastRecords:TToastRecords;
      
      protected var FIsInit:Boolean;
      
      protected var FGetScore:uint;
      
      protected var FGetTokenCount:uint;
      
      protected var FOnReturnMainScene:Function;
      
      protected var FOnInitBattle:Function;
      
      protected var FSetStatusType:Function;
      
      protected var FBattleBack:Boolean;
      
      protected var FIsWin:Boolean;
      
      protected var FOnOpenSoulExchange:Function;
      
      protected var FOnOpenTokenExchange:Function;
      
      protected var FOnOpenToast:Function;
      
      protected var FOnOpenRankings:Function;
      
      protected var FUpdateExplanationUI:Function;
      
      protected var FUpdateToastRecord:Function;
      
      protected var FUpdateActivityStatus:Function;
      
      protected var FOnEffectSign:Function;
      
      public function TProcessorCrossServerWar(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FProcessorWindowCrossServerWar = new TProcessorWindowCrossServerWar(this);
         this.FProcessorWindowCrossServerWar.OnClose = this.ProcessorOnClose;
         this.FProcessorWindowCrossServerWar.OnEffectText = this.ProcessorOnEffectGenerateText;
         this.FProcessorWindowCrossServerWar.OnOpenScoreRanking = this.ProcessorOnOpenScoreRanking;
         this.FProcessorWindowCrossServerWar.OnOpenStepChallenge = this.ProcessorOnOpenStepChallenge;
         this.FProcessorWindowCrossServerWar.UIComponentsOnOver = this.UIComponentsOverlayerOnOver;
         this.FProcessorWindowCrossServerWar.UIComponentsOnOut = this.UIComponentsOverlayerOnOut;
         this.FProcessorWindowCrossServerWar.OnEliteApply = this.ProcessorOnEliteApply;
         this.FProcessorWindowCrossServerWar.OnChallengePlayer = this.ProcessorOnChallengePlayer;
         this.FProcessorWindowCrossServerWar.OnOpenSoulExchange = this.ProcessorOnOpenSoulExchange;
         this.FProcessorWindowCrossServerWar.OnOpenTokenExchange = this.ProcessorOnOpenTokenExchange;
         this.FProcessorWindowCrossServerWar.OnOpenToast = this.ProcessorOnOpenToast;
         this.FProcessorWindowCrossServerWar.OnAddChallengeCount = this.ProcessorOnAddChallengeCount;
         this.FProcessorWindowCrossServerWar.HelpOnOver = this.UIHelpHintOnOver;
         this.FProcessorWindowCrossServerWar.HelpOnOut = this.UIHelpHintOnOut;
         this.FProcessorWindowCrossServerWar.UIHintOnOver = this.UIComponentsHintOnOver;
         this.FProcessorWindowCrossServerWar.UIHintOnOut = this.UIComponentsHintOnOut;
         this.FProcessorWindowChallengeLadder = new TProcessorWindowChallengeLadder(this);
         this.FProcessorWindowChallengeLadder.UIComponentsOnOver = this.UIComponentsOverlayerOnOver;
         this.FProcessorWindowChallengeLadder.UIComponentsOnOut = this.UIComponentsOverlayerOnOut;
         this.FProcessorWindowChallengeLadder.BoxOnMove = this.ProcessorBoxOnMove;
         this.FProcessorWindowChallengeLadder.BoxOnOut = this.ProcessorBoxOnOut;
         this.FProcessorWindowChallengeLadder.X = 1127;
         this.FStepChallengePlayers = SLogicsCore.StepChallengePlayers;
         this.FSkipChallengePlayers = SLogicsCore.SkipChallengePlayers;
         this.FEliteRecord = SLogicsCore.EliteRecord;
         this.FIntegralRankings = new TIntegralRankings();
         this.FUnstreamizerCrossServerPlayer = new TUnstreamizerCrossServerPlayer();
         this.FUnstreamizerEliteRecord = new TUnstreamizerEliteRecord();
         this.FUnstreamizerIntegralRanking = new TUnstreamizerIntegralRanking();
         this.FUnstreamizerToastRecord = new TUnstreamizerToastRecord();
         this.FUnstreamizerCrossServerReport = new TUnstreamizerCrossServerReport();
         this.FOverLayerCrossServerPlayerInfo = new TOverLayerCrossServerPlayerInfo(this,CONST_MODULES.MODULE_CrossServerWar);
         this.FOverLayerCrossServerPlayerInfo.Visible = false;
         this.FOverlayerChallengeTreasure = new TOverlayerChallengeTreasure(this);
         this.FOverlayerChallengeTreasure.Visible = false;
         this.FOverlayerHelpTips = new TOverlayerHelpTips(FParent);
         this.FOverlayerHelpTips.Visible = false;
         this.FOverlayerHint = new TOverlayerHint(FParent);
         this.FOverlayerHint.Visible = false;
         this.FToastRecords = new TToastRecords();
         this.FCrossServerReports = new TCrossServerReports();
         this.FIsInit = false;
         SetUIModuleID(CONST_MODULES.MODULE_CrossServerWar);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_CROSSSERVERWAR.RESOURCESID_Swf_CrossServerWar);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverLayerCrossServerPlayerInfo);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerChallengeTreasure);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerHelpTips);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerHint);
         this.FUIWindowBattleSkip = new TUIWindowBattleSkip(this.Parent);
         this.FUIWindowBattleSkip.Perform_UIDispatch();
         this.FUIWindowBattleSkip.OnOK = this.OnConfirmationOk;
         this.FUIWindowBattleSkip.OnCancel = this.OnWindowCancel;
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_CrossServerWar_EliteApplyRet,this.PacketPerform_SC_EliteApplyRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_CrossServerWar_EliteFightRet,this.PacketPerform_SC_EliteFightRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_CrossServerWar_EliteToastRet,this.PacketPerform_SC_EliteToastRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_CrossServerWar_EliteScoreChartRet,this.PacketPerform_SC_EliteScoreChartRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_CrossServerWar_EliteTargetChartRet,this.PacketPerform_SC_EliteTargetChartRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_CS_CrossServerWar_EliteExchangeRet,this.PacketPerform_SC_EliteExchangeRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_CrossServerWar_EliteRecRet,this.PacketPerform_SC_EliteRecRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_CrossServerWar_DailyResetNotify,this.PacketPerform_SC_DailyResetNotify);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_CrossServerWar_EntrantStatus,this.PacketPerform_SC_EntrantStatus);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_CrossServerWar_SpanFightOpenRet,this.PacketPerform_SC_SpanFightOpenRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_CrossServerWar_ToastRecordRet,this.PacketPerform_SC_ToastRecordRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_CrossServerWar_AddFightTimesRet,this.PacketPerform_SC_AddFightTimesRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_CrossServerWar_SeasonStatusRet,this.PacketPerform_SC_SeasonStatusRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_CrossServerWar_FightReportListRet,this.PacketPerform_SC_FightReportListRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_CrossServerWar_FightReportUpdate,this.PacketPerform_SC_FightReportUpdate);
         super.PacketRegisterRoutines();
      }
      
      protected function PacketPerform_SC_EliteApplyRet(param1:TPacket) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:ByteArray = null;
         _loc3_ = param1.Data;
         _loc2_ = _loc3_.readUnsignedInt();
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         EffectGenerateText(STRING_CROSSSERVERWAR.STRING_ApplySucceed);
         SLogicsCore.EliteRecord.ApplyStatus = !Boolean(_loc2_);
         if(this.FProcessorWindowCrossServerWar.Visible)
         {
            this.FProcessorWindowCrossServerWar.UpdateApply();
         }
         else if(this.FUpdateExplanationUI != null)
         {
            this.FUpdateExplanationUI(this);
         }
      }
      
      protected function PacketPerform_SC_EliteFightRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:Boolean = false;
         var _loc5_:String = null;
         var _loc6_:TChallengePlayer = null;
         var _loc7_:uint = 0;
         var _loc8_:int = 0;
         _loc2_ = param1.Data;
         this.FProcessorWindowCrossServerWar.UpdateBTNChallenge();
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         if(this.FSetStatusType != null)
         {
            this.FSetStatusType(this,CONST_BATTLE.BattleType_CrossServerWar,0,this.FEliteRecord.IsAutoBattle);
         }
         if(this.FOnInitBattle != null)
         {
            this.FOnInitBattle(this);
         }
         _loc7_ = _loc2_.readUnsignedByte();
         _loc8_ = int(_loc2_.readUnsignedInt());
         _loc4_ = Boolean(_loc2_.readUnsignedByte());
         if(_loc7_ == CONST_CROSSSERVERWAR.TYPE_CommonChallenge)
         {
            _loc6_ = this.FStepChallengePlayers.GetChallengePlayerByIndex(_loc8_);
         }
         else if(_loc7_ == CONST_CROSSSERVERWAR.TYPE_SuperChallenge)
         {
            _loc6_ = this.FSkipChallengePlayers.GetChallengePlayerByIndex(_loc8_);
            this.FProcessorWindowCrossServerWar.UpdateSkipChallenge();
         }
         _loc6_.IsDefeated = Boolean(_loc4_);
         this.FGetScore = _loc2_.readUnsignedInt();
         this.FGetTokenCount = _loc2_.readUnsignedInt();
      }
      
      protected function PacketPerform_SC_EliteToastRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         EffectGenerateText(STRING_CROSSSERVERWAR.STRING_ToastSucceed);
         if(this.FEliteRecord != null)
         {
            this.FEliteRecord.ToastTimes = 1;
         }
         if(this.FOnOpenToast != null)
         {
            this.FOnOpenToast(this,CONST_CROSSSERVERWAR.TYPE_Cheers);
         }
         this.PlayEffectNewSign(false);
         this.PacketPerform_CS_ToastRecordReq();
      }
      
      protected function PacketPerform_SC_EliteScoreChartRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         _loc2_ = param1.Data;
         if(this.FEliteRecord != null)
         {
            _loc3_ = this.FEliteRecord.RankToday;
         }
         this.FUnstreamizerIntegralRanking.Unstreamize(_loc2_,this.FIntegralRankings,null);
         if(this.FOnOpenRankings != null)
         {
            this.FOnOpenRankings(this,CONST_CROSSSERVERWAR.TYPE_Rankings,this.FIntegralRankings,_loc3_);
         }
      }
      
      protected function PacketPerform_SC_EliteTargetChartRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:TChallengePlayer = null;
         _loc2_ = param1.Data;
         this.FStepChallengePlayers.Clear();
         this.FSkipChallengePlayers.Clear();
         this.FUnstreamizerCrossServerPlayer.Unstreamize(_loc2_,this.FStepChallengePlayers,null);
         _loc4_ = uint(this.FStepChallengePlayers.Count);
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc5_ = this.FStepChallengePlayers.GetChallengePlayerByIndex(_loc3_);
            _loc5_.Type = 0;
            _loc3_++;
         }
         this.FUnstreamizerCrossServerPlayer.Unstreamize(_loc2_,this.FSkipChallengePlayers,null);
         _loc4_ = uint(this.FSkipChallengePlayers.Count);
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc5_ = this.FSkipChallengePlayers.GetChallengePlayerByIndex(_loc3_);
            _loc5_.Type = 1;
            _loc3_++;
         }
         if(FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowCrossServerWar.UpdateStepChallenge();
         }
         this.FIsInit = true;
      }
      
      protected function PacketPerform_SC_EliteExchangeRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc4_ = _loc2_.readUnsignedByte();
         EffectGenerateText(STRING_CROSSSERVERWAR.STRING_ExchangeSucceed);
         if(_loc4_ == 1)
         {
            this.FOnOpenTokenExchange(this,CONST_CROSSSERVERWAR.TYPE_TokenExchange);
         }
         else if(_loc4_ == 2)
         {
            this.FOnOpenSoulExchange(this,CONST_CROSSSERVERWAR.TYPE_SoulExchange);
         }
      }
      
      protected function PacketPerform_SC_EliteRecRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = param1.Data;
         this.FUnstreamizerEliteRecord.Unstreamize(_loc2_,this.FEliteRecord,null);
         if(FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowCrossServerWar.UpdateEliteRecord();
         }
         if(this.FEliteRecord.ToastTimes == 0)
         {
            this.PlayEffectNewSign(true);
         }
      }
      
      protected function PacketPerform_SC_DailyResetNotify(param1:TPacket) : void
      {
      }
      
      protected function PacketPerform_SC_EntrantStatus(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         _loc2_ = param1.Data;
         if(this.FEliteRecord != null)
         {
            _loc3_ = _loc2_.readUnsignedByte();
            this.FEliteRecord.TodayIsJoin = _loc3_;
         }
         if(!_loc3_ && this.FProcessorWindowCrossServerWar.Visible)
         {
            this.ProcessorOnClose(null);
         }
         this.PacketPerform_CS_EliteRecReq();
      }
      
      protected function PacketPerform_SC_SpanFightOpenRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         if(this.FEliteRecord != null)
         {
            this.FEliteRecord.IsJoinSkip = 1;
         }
         this.FProcessorWindowCrossServerWar.UnlockedSkipChallenge();
      }
      
      protected function PacketPerform_SC_ToastRecordRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         _loc2_ = param1.Data;
         this.FToastRecords.Clear();
         this.FUnstreamizerToastRecord.Unstreamize(_loc2_,this.FToastRecords,null);
         if(this.FUpdateToastRecord != null)
         {
            this.FUpdateToastRecord(this,this.FToastRecords);
         }
      }
      
      protected function PacketPerform_SC_AddFightTimesRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         this.UIComponentsHintOnOut(null);
      }
      
      protected function PacketPerform_SC_SeasonStatusRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = param1.Data;
         this.FEliteRecord.SeasonStatus = _loc2_.readUnsignedInt();
         this.FEliteRecord.SeasonStartTime = _loc2_.readUnsignedInt();
         this.FEliteRecord.SeasonEndTime = _loc2_.readUnsignedInt();
         this.FEliteRecord.NextSeasonStartTime = _loc2_.readUnsignedInt();
         this.FEliteRecord.BattleID = _loc2_.readUnsignedInt();
         if(this.FUpdateExplanationUI != null)
         {
            this.FUpdateExplanationUI(this);
         }
      }
      
      protected function PacketPerform_SC_FightReportListRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = param1.Data;
         this.FUnstreamizerCrossServerReport.Unstreamize(_loc2_,this.FCrossServerReports,null);
         this.FProcessorWindowCrossServerWar.UpdateReport(this.FCrossServerReports);
      }
      
      protected function PacketPerform_SC_FightReportUpdate(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:TCrossServerReport = null;
         _loc2_ = param1.Data;
         _loc3_ = new TCrossServerReport();
         _loc3_.Name = TUtilityString.FetchUTF(_loc2_);
         _loc3_.Time = _loc2_.readUnsignedInt();
         _loc3_.ReportID = TUtilityString.FetchUTF(_loc2_);
         _loc3_.IsWin = Boolean(_loc2_.readUnsignedInt());
         this.FCrossServerReports.Add(_loc3_);
         this.FCrossServerReports.SortByTime();
         this.FProcessorWindowCrossServerWar.UpdateReport(this.FCrossServerReports);
      }
      
      protected function PacketPerform_CS_EliteRecReq() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_CrossServerWar_EliteRecReq);
         _loc2_ = _loc1_.Data;
         _loc2_.writeUnsignedInt(0);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PacketPerform_CS_FightReportListReq() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_CrossServerWar_FightReportListReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PacketPerform_CS_EliteTargetChartReq() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_CrossServerWar_EliteTargetChartReq);
         _loc2_ = _loc1_.Data;
         _loc2_.writeUnsignedInt(0);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PacketPerform_CS_EliteScoreChartReq() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_CrossServerWar_EliteScoreChartReq);
         _loc2_ = _loc1_.Data;
         _loc2_.writeUnsignedInt(0);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PacketPerform_CS_ToastRecordReq() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_CrossServerWar_ToastRecordReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PacketPerform_CS_AddFightTimesReq() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_CrossServerWar_AddFightTimesReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PlayEffectNewSign(param1:Boolean) : void
      {
         if(this.FOnEffectSign != null)
         {
            this.FOnEffectSign(CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_CrossServerWar,param1);
         }
      }
      
      protected function ProcessorOnClose(param1:Object) : void
      {
         if(SLogicsCore.Character.RoleSencePosition != CONST_COMMON.SCENEPOSITION_CrossServerWar)
         {
            return;
         }
         if(this.FOnReturnMainScene != null)
         {
            this.FOnReturnMainScene(this);
         }
         this.FProcessorWindowCrossServerWar.Visible = false;
      }
      
      protected function ProcessorOnEffectGenerateText(param1:Object, param2:String, param3:TEffectTextParameters = null, param4:TEffectCoordinateParameters = null) : void
      {
         EffectGenerateText(param2);
      }
      
      protected function ProcessorOnOpenSoulExchange(param1:Object) : void
      {
         if(this.FOnOpenSoulExchange != null)
         {
            this.FOnOpenSoulExchange(this,CONST_CROSSSERVERWAR.TYPE_SoulExchange);
         }
      }
      
      protected function ProcessorOnOpenTokenExchange(param1:Object) : void
      {
         if(this.FOnOpenTokenExchange != null)
         {
            this.FOnOpenTokenExchange(this,CONST_CROSSSERVERWAR.TYPE_TokenExchange);
         }
      }
      
      protected function ProcessorOnOpenToast(param1:Object) : void
      {
         this.PacketPerform_CS_ToastRecordReq();
         if(this.FOnOpenToast != null)
         {
            this.FOnOpenToast(this,CONST_CROSSSERVERWAR.TYPE_Cheers);
         }
      }
      
      protected function ProcessorOnAddChallengeCount(param1:Object) : void
      {
         this.PacketPerform_CS_AddFightTimesReq();
      }
      
      protected function ProcessorOnOpenScoreRanking(param1:Object) : void
      {
         var _loc2_:Date = null;
         var _loc3_:uint = 0;
         var _loc4_:Date = null;
         var _loc5_:uint = 0;
         var _loc6_:Date = null;
         var _loc7_:uint = 0;
         _loc2_ = new Date(STimingCore.GetClientShowTime(this.FEliteRecord.SeasonEndTime) * 1000);
         _loc4_ = new Date(STimingCore.GetServerTime() * 1000);
         _loc6_ = new Date(STimingCore.GetClientShowTime(this.FEliteRecord.NextSeasonStartTime) * 1000);
         _loc3_ = _loc2_.getDate();
         _loc5_ = _loc4_.getDate();
         _loc7_ = _loc6_.getDate();
         if(_loc3_ == _loc5_)
         {
            this.ClearRankings();
         }
         else if(_loc7_ == _loc5_ && (_loc6_.getHours() >= 0 && _loc6_.getHours() <= 3))
         {
            this.ClearRankings();
         }
         else
         {
            this.PacketPerform_CS_EliteScoreChartReq();
         }
      }
      
      protected function ClearRankings() : void
      {
         this.FIntegralRankings.Clear();
         if(this.FOnOpenRankings != null)
         {
            this.FOnOpenRankings(this,CONST_CROSSSERVERWAR.TYPE_Rankings,this.FIntegralRankings,0);
         }
      }
      
      protected function ProcessorOnOpenStepChallenge(param1:Object) : void
      {
         this.FProcessorWindowChallengeLadder.Visible = true;
         this.FProcessorWindowChallengeLadder.y = 53;
         TweenUtil.to(this.FProcessorWindowChallengeLadder,300,{
            "x":110,
            "y":53,
            "onComplete":this.CallBackFuc
         });
         this.FProcessorWindowChallengeLadder.UpdateUI();
      }
      
      protected function CallBackFuc() : void
      {
         TweenUtil.to(this.FProcessorWindowChallengeLadder,100,{
            "x":123,
            "y":53
         });
      }
      
      protected function UIComponentsOverlayerOnOver(param1:Object, param2:Object) : void
      {
         var _loc3_:TChallengePlayer = null;
         var _loc4_:TOverlayer = null;
         _loc3_ = param2 as TChallengePlayer;
         if(_loc3_ == null)
         {
            return;
         }
         _loc4_ = this.FOverLayerCrossServerPlayerInfo;
         _loc4_.Context = _loc3_;
         if(_loc4_ != null)
         {
            _loc4_.Render(FUICore.MouseCoordinate);
            _loc4_.CoordinateOverlay.X -= _loc4_.BoundsSubstrate.Width + 20;
            _loc4_.Show();
         }
      }
      
      protected function UIComponentsOverlayerOnOut(param1:Object, param2:Object) : void
      {
         var _loc3_:TOverlayer = null;
         _loc3_ = this.FOverLayerCrossServerPlayerInfo;
         if(_loc3_ != null)
         {
            _loc3_.Hide();
         }
      }
      
      protected function ProcessorBoxOnMove(param1:Object, param2:Object) : void
      {
         var _loc3_:TGSPVP_Reward = null;
         var _loc4_:TOverlayer = null;
         _loc3_ = param2 as TGSPVP_Reward;
         if(_loc3_ == null)
         {
            return;
         }
         _loc4_ = this.FOverlayerChallengeTreasure;
         _loc4_.Context = _loc3_;
         if(_loc4_ != null)
         {
            _loc4_.Render(FUICore.MouseCoordinate);
            _loc4_.CoordinateOverlay.X -= _loc4_.BoundsSubstrate.Width + 20;
            _loc4_.Show();
         }
      }
      
      protected function ProcessorBoxOnOut(param1:Object) : void
      {
         var _loc2_:TOverlayer = null;
         _loc2_ = this.FOverlayerChallengeTreasure;
         if(_loc2_ != null)
         {
            _loc2_.Hide();
         }
      }
      
      protected function UIHelpHintOnOver(param1:Object, param2:Object) : void
      {
         var _loc3_:THint = null;
         _loc3_ = param2 as THint;
         this.FOverlayerHelpTips.Context = _loc3_;
         this.FOverlayerHelpTips.Render(FUICore.MouseCoordinate);
         this.FOverlayerHelpTips.Show();
      }
      
      protected function UIHelpHintOnOut(param1:Object) : void
      {
         this.FOverlayerHelpTips.Hide();
      }
      
      protected function UIComponentsHintOnOver(param1:Object, param2:THint) : void
      {
         this.FOverlayerHint.Context = param2;
         this.FOverlayerHint.Render(FUICore.MouseCoordinate);
         this.FOverlayerHint.Visible = true;
      }
      
      protected function UIComponentsHintOnOut(param1:Object) : void
      {
         this.FOverlayerHint.Visible = false;
      }
      
      protected function OnConfirmationOk(param1:Object) : void
      {
         this.FUIWindowBattleSkip.SetBattleSkipStatus(true,CONST_BATTLE.BattleType_CrossServerWar);
         this.PerformPacket_CS_Fight();
      }
      
      protected function OnWindowCancel(param1:Object) : void
      {
         this.FUIWindowBattleSkip.SetBattleSkipStatus(false,CONST_BATTLE.BattleType_CrossServerWar);
         this.PerformPacket_CS_Fight();
      }
      
      protected function ProcessorOnEliteApply(param1:Object) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_CrossServerWar_EliteApplyReq);
         _loc3_ = _loc2_.Data;
         _loc3_.writeUnsignedInt(0);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function ProcessorOnChallengePlayer(param1:Object, param2:TChallengePlayer) : void
      {
         this.FChallengePlayer = param2;
         if(!this.FUIWindowBattleSkip.IsSelected)
         {
            this.FUIWindowBattleSkip.Visible = true;
         }
         else
         {
            this.PerformPacket_CS_Fight();
         }
      }
      
      protected function PerformPacket_CS_Fight() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         if(this.FChallengePlayer == null)
         {
            return;
         }
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_CrossServerWar_EliteFightReq);
         _loc2_ = _loc1_.Data;
         _loc2_.writeByte(this.FChallengePlayer.Type);
         _loc2_.writeUnsignedInt(this.FChallengePlayer.TargetIndex);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function ProcessorOnToast(param1:Object, param2:TGSPVP_DailyAward) : void
      {
         var _loc3_:TPacket = null;
         var _loc4_:ByteArray = null;
         _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_CrossServerWar_EliteToastReq);
         _loc4_ = _loc3_.Data;
         _loc4_.writeUnsignedInt(param2.Identifier);
         SNetworkCore.Transceiver.PacketTransmit(_loc3_);
      }
      
      protected function ProcessorOnExchange(param1:Object, param2:Object, param3:int, param4:uint = 0) : void
      {
         var _loc5_:TPacket = null;
         var _loc6_:ByteArray = null;
         var _loc7_:TOrangeInventorySample = null;
         var _loc8_:TTokenInventorySample = null;
         var _loc9_:uint = 0;
         if(param2 is TOrangeInventorySample)
         {
            _loc7_ = param2 as TOrangeInventorySample;
            _loc9_ = _loc7_.Indentifier;
         }
         else if(param2 is TTokenInventorySample)
         {
            _loc8_ = param2 as TTokenInventorySample;
            _loc9_ = _loc8_.Indentifier;
         }
         _loc5_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_CrossServerWar_EliteExchangeReq);
         _loc6_ = _loc5_.Data;
         _loc6_.writeByte(param4);
         _loc6_.writeUnsignedInt(_loc9_);
         _loc6_.writeUnsignedInt(param3);
         SNetworkCore.Transceiver.PacketTransmit(_loc5_);
      }
      
      public function get OnReturnMainScene() : Function
      {
         return this.FOnReturnMainScene;
      }
      
      public function set OnReturnMainScene(param1:Function) : void
      {
         this.FOnReturnMainScene = param1;
      }
      
      public function get OnInitBattle() : Function
      {
         return this.FOnInitBattle;
      }
      
      public function set OnInitBattle(param1:Function) : void
      {
         this.FOnInitBattle = param1;
      }
      
      public function get SetStatusType() : Function
      {
         return this.FSetStatusType;
      }
      
      public function set SetStatusType(param1:Function) : void
      {
         this.FSetStatusType = param1;
      }
      
      public function set BattleBack(param1:Boolean) : void
      {
         this.FBattleBack = param1;
      }
      
      public function get BattleBack() : Boolean
      {
         return this.FBattleBack;
      }
      
      public function set IsWin(param1:Boolean) : void
      {
         this.FIsWin = param1;
      }
      
      public function get IsWin() : Boolean
      {
         return this.FIsWin;
      }
      
      public function get OnOpenSoulExchange() : Function
      {
         return this.FOnOpenSoulExchange;
      }
      
      public function set OnOpenSoulExchange(param1:Function) : void
      {
         this.FOnOpenSoulExchange = param1;
      }
      
      public function get OnOpenTokenExchange() : Function
      {
         return this.FOnOpenTokenExchange;
      }
      
      public function set OnOpenTokenExchange(param1:Function) : void
      {
         this.FOnOpenTokenExchange = param1;
      }
      
      public function get OnOpenToast() : Function
      {
         return this.FOnOpenToast;
      }
      
      public function set OnOpenToast(param1:Function) : void
      {
         this.FOnOpenToast = param1;
      }
      
      public function get OnOpenRankings() : Function
      {
         return this.FOnOpenRankings;
      }
      
      public function set OnOpenRankings(param1:Function) : void
      {
         this.FOnOpenRankings = param1;
      }
      
      public function get UpdateExplanationUI() : Function
      {
         return this.FUpdateExplanationUI;
      }
      
      public function set UpdateExplanationUI(param1:Function) : void
      {
         this.FUpdateExplanationUI = param1;
      }
      
      public function get UpdateToastRecord() : Function
      {
         return this.FUpdateToastRecord;
      }
      
      public function set UpdateToastRecord(param1:Function) : void
      {
         this.FUpdateToastRecord = param1;
      }
      
      public function get UpdateActivityStatus() : Function
      {
         return this.FUpdateActivityStatus;
      }
      
      public function set UpdateActivityStatus(param1:Function) : void
      {
         this.FUpdateActivityStatus = param1;
      }
      
      public function get OnEffectSign() : Function
      {
         return this.FOnEffectSign;
      }
      
      public function set OnEffectSign(param1:Function) : void
      {
         this.FOnEffectSign = param1;
      }
      
      override public function ShortcutModesSetup(param1:TLobbyShortcutModes) : void
      {
         var _loc2_:TLobbyShortcutAvatarModes = null;
         var _loc3_:TLobbyShortcutActivityModes = null;
         var _loc4_:TLobbyShortcutActiveSpecialModes = null;
         var _loc5_:TLobbyShortcutFunctionModes = null;
         var _loc6_:TLobbyShortcutMapModes = null;
         var _loc7_:TLobbyShortcutQuestGuideModes = null;
         var _loc8_:TLobbyShortcutConstantlyModes = null;
         if(param1 is TLobbyShortcutAvatarModes)
         {
            _loc2_ = param1 as TLobbyShortcutAvatarModes;
            _loc2_.ShortcutModeAvatar = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
         }
         if(param1 is TLobbyShortcutActivityModes)
         {
            _loc3_ = param1 as TLobbyShortcutActivityModes;
            _loc3_.SetAllShortcutHide();
         }
         if(param1 is TLobbyShortcutActiveSpecialModes)
         {
            _loc4_ = param1 as TLobbyShortcutActiveSpecialModes;
            _loc4_.ShortcutModeCDK = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
         }
         if(param1 is TLobbyShortcutFunctionModes)
         {
            _loc5_ = param1 as TLobbyShortcutFunctionModes;
            _loc5_.ShortcutModeHero = TLobbyShortcutMode.SHORTCUTMODE_Show;
            _loc5_.ShortcutModeStar = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
            _loc5_.ShortcutModeTacticalDeployment = TLobbyShortcutMode.SHORTCUTMODE_Show;
            _loc5_.ShortcutModeInheritPractice = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
            _loc5_.ShortcutModeBackpack = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
            _loc5_.ShortcutModeTreasure = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
            _loc5_.ShortcutModeSummonPet = TLobbyShortcutMode.SHORTCUTMODE_Show;
            _loc5_.ShortcutModeStrengthen = TLobbyShortcutMode.SHORTCUTMODE_Show;
            _loc5_.ShortcutModeMail = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
            _loc5_.ShortcutModeTongLing = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
            _loc5_.ShortcutModeOrganiZation = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
            _loc5_.ShortcutModeReturn = TLobbyShortcutMode.SHORTCUTMODE_Show;
         }
         if(param1 is TLobbyShortcutMapModes)
         {
            _loc6_ = param1 as TLobbyShortcutMapModes;
            _loc6_.ShortcutModeMap = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
            _loc6_.ShortcutModeReturnHome = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
         }
         if(param1 is TLobbyShortcutQuestGuideModes)
         {
            _loc7_ = param1 as TLobbyShortcutQuestGuideModes;
            _loc7_.ShortcutMode = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
         }
         if(param1 is TLobbyShortcutConstantlyModes)
         {
            _loc8_ = param1 as TLobbyShortcutConstantlyModes;
            _loc8_.ShortcutModeStrengthen = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
            _loc8_.ShortcutModeArena = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
            _loc8_.ShortcutModeBigDipper = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
            _loc8_.ShortcutModeMentorship = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
            _loc8_.ShortcutModeTongLing = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
         }
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount(param1);
         if(!FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowCrossServerWar.Load();
            this.FProcessorWindowChallengeLadder.Load();
            return;
         }
         this.PacketPerform_CS_EliteRecReq();
         this.PacketPerform_CS_FightReportListReq();
         if(!this.FIsInit)
         {
            this.PacketPerform_CS_EliteTargetChartReq();
         }
         this.FProcessorWindowCrossServerWar.Visible = true;
         SLogicsCore.Character.RoleSencePosition = CONST_COMMON.SCENEPOSITION_CrossServerWar;
         this.FProcessorWindowCrossServerWar.UpdateStepChallenge();
         this.FProcessorWindowCrossServerWar.ResetAutoBattleTime(this.FIsWin);
      }
      
      override public function Unmount() : void
      {
         super.Unmount();
      }
      
      public function EliteApply() : void
      {
         this.ProcessorOnEliteApply(null);
      }
      
      public function Toast(param1:Object) : void
      {
         var _loc2_:TGSPVP_DailyAward = null;
         _loc2_ = param1 as TGSPVP_DailyAward;
         this.ProcessorOnToast(null,_loc2_);
      }
      
      public function Recruit(param1:Object) : void
      {
         this.ProcessorOnExchange(null,param1,1,2);
      }
      
      public function ItemExchange(param1:Object, param2:int) : void
      {
         this.ProcessorOnExchange(null,param1,param2,2);
      }
      
      public function TokenExchange(param1:Object, param2:int) : void
      {
         this.ProcessorOnExchange(null,param1,param2,1);
      }
      
      public function RankingsReq() : void
      {
         this.PacketPerform_CS_EliteScoreChartReq();
      }
      
      public function ToastReq() : void
      {
         this.PacketPerform_CS_ToastRecordReq();
      }
      
      public function EliteRecordReq() : void
      {
         this.PacketPerform_CS_EliteRecReq();
      }
      
      public function PlayTextEffect() : void
      {
         var _loc1_:String = null;
         if(this.FGetScore == 0 && this.FGetTokenCount == 0)
         {
            return;
         }
         if(this.FGetScore != 0)
         {
            _loc1_ = TUtilityString.Format(STRING_CROSSSERVERWAR.FORMAT_GetScore,this.FGetScore);
            EffectGenerateText(_loc1_);
         }
         if(this.FGetTokenCount != 0)
         {
            _loc1_ = TUtilityString.Format(STRING_CROSSSERVERWAR.FORMAT_GetTokenCount,this.FGetTokenCount);
            EffectGenerateText(_loc1_);
         }
         this.FGetScore = 0;
         this.FGetTokenCount = 0;
      }
   }
}

