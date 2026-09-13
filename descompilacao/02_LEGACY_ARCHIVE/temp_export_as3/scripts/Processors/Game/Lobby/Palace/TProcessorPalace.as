package Processors.Game.Lobby.Palace
{
   import Foundation.Common.TCoordinate;
   import Foundation.Common.THint;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Registries.TRegistryRoutine;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityString;
   import Logics.CrossServerWar.TCrossServerReport;
   import Logics.CrossServerWar.TCrossServerReports;
   import Logics.Palace.TPalaceData;
   import Logics.Palace.TTargetFighter;
   import Logics.SLogicsCore;
   import Logics.Streamization.Palace.TUnstreamizerPalace;
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
   import Rendering.Overlayers.HelpTips.TOverlayerHelpTips;
   import Rendering.Overlayers.Hints.TOverlayerHint;
   import Resources.Constants.CONST_BATTLE;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_PALACE;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.utils.ByteArray;
   
   public class TProcessorPalace extends TProcessorLobbyPlate
   {
      
      protected var FProcessorWindowPalace:TProcessorWindowPalace;
      
      protected var FProcessorWindowHeroInfo:TProcessorWindowHeroInfo;
      
      protected var FOverlayerHelpTips:TOverlayerHelpTips;
      
      protected var FOverlayerHint:TOverlayerHint;
      
      protected var FUnstreamizerPalace:TUnstreamizerPalace;
      
      protected var FRegistryRoutine:TRegistryRoutine;
      
      protected var FPalaceData:TPalaceData;
      
      protected var FIsWin:uint;
      
      protected var FOnReturnMainScene:Function;
      
      protected var FOnOpenExplanation:Function;
      
      protected var FOnInitBattle:Function;
      
      protected var FSetStatusType:Function;
      
      protected var FOnOpenPalace:Function;
      
      public function TProcessorPalace(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FProcessorWindowPalace = new TProcessorWindowPalace(this);
         this.FProcessorWindowPalace.OnClose = this.ProcessorOnClose;
         this.FProcessorWindowPalace.OnHelpTipsOver = this.UIHelpTipsHintOnOver;
         this.FProcessorWindowPalace.OnHelpTipsOut = this.UIHelpTipsHintOnOut;
         this.FProcessorWindowPalace.LookHeroInfoOnClick = this.ProcessorLookHeroInfoOnClick;
         this.FProcessorWindowPalace.RoleOnClick = this.ProcessorRoleOnClick;
         this.FProcessorWindowPalace.LookRankingOnClick = this.ProcessorLookRankingOnClick;
         this.FProcessorWindowPalace.OnAddChallengeCount = this.ProcessorOnAddChallengeCount;
         this.FProcessorWindowPalace.UIHintOnOver = this.UIComponentsHintOnOver;
         this.FProcessorWindowPalace.UIHintOnOut = this.UIComponentsHintOnOut;
         this.FProcessorWindowPalace.OnClearChallengeCD = this.ProcessorOnClearChallengeCD;
         this.FProcessorWindowHeroInfo = new TProcessorWindowHeroInfo(this);
         this.FOverlayerHelpTips = new TOverlayerHelpTips(this);
         this.FOverlayerHelpTips.Visible = false;
         this.FOverlayerHint = new TOverlayerHint(this);
         this.FOverlayerHint.Visible = false;
         this.FUnstreamizerPalace = new TUnstreamizerPalace();
         this.FRegistryRoutine = new TRegistryRoutine();
         this.FPalaceData = SLogicsCore.PalaceData;
         this.FRegistryRoutine.Register(CONST_PALACE.TYPE_UnEnterPalace,this.ProcessorOpenExplanation);
         this.FRegistryRoutine.Register(CONST_PALACE.TYPE_EnterPalace,this.ProcessorOpenPalace);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_PALACE.RESOURCESID_Swf_Palace);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerHelpTips);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerHint);
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_DragonHall_EnterRet,this.PacketPerform_SC_EnterRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_DragonHall_UserRecordRet,this.PacketPerform_SC_UserRecordRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_DragonHall_AllFightersRet,this.PacketPerform_SC_AllFightersRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_DragonHall_FightRet,this.PacketPerform_SC_FightRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_DragonHall_ReportListRet,this.PacketPerform_SC_ReportListRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_DragonHall_AddFightTimesRet,this.PacketPerform_SC_AddFightTimesRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_DragonHall_ClearCDRet,this.PacketPerform_SC_ClearCDRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_DragonHall_RankChartRet,this.PacketPerform_SC_RankChartRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_DragonHall_RankSwap,this.PacketPerform_SC_RankSwap);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_DragonHall_ObserveRet,this.PacketPerform_SC_ObserveRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_DragonHall_FightReportUpdate,this.PacketPerform_SC_FightReportUpdate);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_DragonHall_StatusNotify,this.PacketPerform_SC_StatusNotify);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_DragonHall_SelfRankRet,this.PacketPerform_SC_SelfRankRet);
      }
      
      protected function PacketPerform_SC_EnterRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:Function = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc4_ = _loc2_.readUnsignedInt();
         this.FPalaceData.EnterStatus = _loc4_;
         _loc5_ = this.FRegistryRoutine.GetRoutineByIndentifier(_loc4_);
         if(_loc5_ != null)
         {
            _loc5_();
         }
      }
      
      protected function PacketPerform_SC_UserRecordRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = param1.Data;
         this.FUnstreamizerPalace.UnstreamizeUserRecord(_loc2_,this.FPalaceData.PalaceRoleBaseInfo,null);
         if(FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowPalace.UpdateBaseInfo();
         }
      }
      
      protected function PacketPerform_SC_AllFightersRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = param1.Data;
         this.FUnstreamizerPalace.UnstreamizeTargetList(_loc2_,this.FPalaceData.TargetFighters,null);
         if(FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowPalace.UpdateRoleRanking();
         }
      }
      
      protected function PacketPerform_SC_FightRet(param1:TPacket) : void
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
         if(this.FSetStatusType != null)
         {
            this.FSetStatusType(this,CONST_BATTLE.BattleType_Palace,0);
         }
         if(this.FOnInitBattle != null)
         {
            this.FOnInitBattle(this);
         }
         this.FProcessorWindowPalace.Update();
         this.FIsWin = _loc2_.readUnsignedInt();
      }
      
      protected function PacketPerform_SC_ReportListRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = param1.Data;
         this.FUnstreamizerPalace.UnstreamizeReportList(_loc2_,this.FPalaceData.FightReports,null);
         if(FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowPalace.UpdatePalaceReport();
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
         ++this.FPalaceData.PalaceRoleBaseInfo.CurrentTimes;
         ++this.FPalaceData.PalaceRoleBaseInfo.BuyTimes;
      }
      
      protected function PacketPerform_SC_ClearCDRet(param1:TPacket) : void
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
         this.FPalaceData.PalaceRoleBaseInfo.LastChallengeTime = 0;
         this.FProcessorWindowPalace.UpdateCDTime();
      }
      
      protected function PacketPerform_SC_RankChartRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = param1.Data;
         this.FUnstreamizerPalace.UnstreamizeRankingList(_loc2_,this.FPalaceData.RankingPlayers,null);
         if(this.FOnOpenExplanation != null)
         {
            this.FOnOpenExplanation(this,1);
         }
      }
      
      protected function PacketPerform_SC_RankSwap(param1:TPacket) : void
      {
      }
      
      protected function PacketPerform_SC_ObserveRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         _loc2_ = param1.Data;
         this.FProcessorWindowPalace.SetCDStartTime();
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         this.FUnstreamizerPalace.UnstreamizeInquirePlayerInfo(_loc2_,this.FPalaceData.InquirePlayerInfo,null);
         if(FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowHeroInfo.Update();
         }
         this.FProcessorWindowHeroInfo.Visible = true;
      }
      
      protected function PacketPerform_SC_FightReportUpdate(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:TCrossServerReport = null;
         var _loc4_:TCrossServerReports = null;
         _loc2_ = param1.Data;
         _loc4_ = this.FPalaceData.FightReports.PalaceCommonReports;
         _loc3_ = new TCrossServerReport();
         _loc3_.Name = TUtilityString.FetchUTF(_loc2_);
         _loc3_.Time = _loc2_.readUnsignedInt();
         _loc3_.ReportID = TUtilityString.FetchUTF(_loc2_);
         _loc3_.IsWin = Boolean(_loc2_.readUnsignedInt());
         _loc3_.IsFight = Boolean(_loc2_.readUnsignedInt());
         _loc4_.Add(_loc3_);
         _loc4_.SortByTime();
         while(_loc4_.Count > CONST_PALACE.CAPACITY_CommonReports)
         {
            _loc4_.DeleteFirst();
         }
         if(FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowPalace.UpdatePalaceReport();
         }
      }
      
      protected function PacketPerform_SC_StatusNotify(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         this.FPalaceData.StatusValue = _loc3_;
         if(_loc3_ != CONST_PALACE.STATUS_Open)
         {
            if(_loc3_ == CONST_PALACE.STATUS_Close)
            {
               this.ProcessorOnClose(null);
            }
            else if(_loc3_ == CONST_PALACE.STATUS_Reset)
            {
            }
         }
      }
      
      protected function PacketPerform_SC_SelfRankRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         this.FPalaceData.TargetFighters.RoleCurrentRank = _loc3_;
      }
      
      protected function PacketPerform_CS_UserRecordReq() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_DragonHall_UserRecordReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PacketPerform_CS_AllFightersReq() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_DragonHall_AllFightersReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PacketPerform_CS_ReportListReq() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_DragonHall_ReportListReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PacketPerform_CS_SelfRankReq() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_DragonHall_SelfRankReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PacketPerform_CS_RankChartReq() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_DragonHall_RankChartReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PacketPerform_CS_AddFightTimesReq() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_DragonHall_AddFightTimesReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PacketPerform_CS_ClearCDReq() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_DragonHall_ClearCDReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PacketPerform_CS_EnterReq() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_DragonHall_EnterReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function ProcessorOpenExplanation() : void
      {
         this.ProcessorOnClose(null);
         this.PacketPerform_CS_SelfRankReq();
         if(this.FOnOpenExplanation != null)
         {
            this.FOnOpenExplanation(this,0);
         }
      }
      
      protected function ProcessorOpenPalace() : void
      {
         if(this.FOnOpenPalace != null)
         {
            this.FOnOpenPalace(this);
         }
         this.PacketPerform_CS_UserRecordReq();
         this.PacketPerform_CS_AllFightersReq();
         this.PacketPerform_CS_ReportListReq();
      }
      
      protected function ProcessorLookHeroInfoOnClick(param1:Object, param2:Object, param3:Object) : void
      {
         var _loc4_:TCoordinate = null;
         var _loc5_:TTargetFighter = null;
         var _loc6_:TPacket = null;
         var _loc7_:ByteArray = null;
         _loc4_ = param3 as TCoordinate;
         _loc5_ = param2 as TTargetFighter;
         _loc6_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_DragonHall_ObserveReq);
         _loc7_ = _loc6_.Data;
         _loc7_.writeUnsignedInt(_loc5_.RankIndex);
         SNetworkCore.Transceiver.PacketTransmit(_loc6_);
         this.FProcessorWindowHeroInfo.SetPosition(_loc4_.X,_loc4_.Y);
      }
      
      protected function ProcessorRoleOnClick(param1:Object, param2:Object) : void
      {
         var _loc3_:TTargetFighter = null;
         var _loc4_:TPacket = null;
         var _loc5_:ByteArray = null;
         _loc3_ = param2 as TTargetFighter;
         _loc4_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_DragonHall_FightReq);
         _loc5_ = _loc4_.Data;
         _loc5_.writeUnsignedInt(_loc3_.RankIndex);
         SNetworkCore.Transceiver.PacketTransmit(_loc4_);
      }
      
      protected function ProcessorLookRankingOnClick(param1:Object) : void
      {
         this.PacketPerform_CS_RankChartReq();
      }
      
      protected function ProcessorOnAddChallengeCount(param1:Object) : void
      {
         this.PacketPerform_CS_AddFightTimesReq();
      }
      
      protected function ProcessorOnClearChallengeCD(param1:Object) : void
      {
         this.PacketPerform_CS_ClearCDReq();
      }
      
      protected function ProcessorOnClose(param1:Object) : void
      {
         if(SLogicsCore.Character.RoleSencePosition != CONST_COMMON.SCENEPOSITION_Palace)
         {
            return;
         }
         if(this.FOnReturnMainScene != null)
         {
            this.FOnReturnMainScene(this);
         }
         this.FProcessorWindowPalace.Visible = false;
      }
      
      protected function UIHelpTipsHintOnOver(param1:Object, param2:THint) : void
      {
         this.FOverlayerHelpTips.Context = param2;
         this.FOverlayerHelpTips.Render(FUICore.MouseCoordinate);
         this.FOverlayerHelpTips.Show();
      }
      
      protected function UIHelpTipsHintOnOut(param1:Object) : void
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
      
      public function get OnOpenExplanation() : Function
      {
         return this.FOnOpenExplanation;
      }
      
      public function set OnOpenExplanation(param1:Function) : void
      {
         this.FOnOpenExplanation = param1;
      }
      
      public function get OnReturnMainScene() : Function
      {
         return this.FOnReturnMainScene;
      }
      
      public function set OnReturnMainScene(param1:Function) : void
      {
         this.FOnReturnMainScene = param1;
      }
      
      public function get OnOpenPalace() : Function
      {
         return this.FOnOpenPalace;
      }
      
      public function set OnOpenPalace(param1:Function) : void
      {
         this.FOnOpenPalace = param1;
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
            this.FProcessorWindowHeroInfo.Load();
            this.FProcessorWindowPalace.Load();
            return;
         }
         SLogicsCore.Character.RoleSencePosition = CONST_COMMON.SCENEPOSITION_Palace;
         this.FProcessorWindowPalace.Visible = true;
         this.FProcessorWindowPalace.Update();
      }
      
      public function PalaceRankingsReq() : void
      {
         this.PacketPerform_CS_RankChartReq();
      }
      
      public function PalaceEnterReq() : void
      {
         this.PacketPerform_CS_EnterReq();
      }
   }
}

