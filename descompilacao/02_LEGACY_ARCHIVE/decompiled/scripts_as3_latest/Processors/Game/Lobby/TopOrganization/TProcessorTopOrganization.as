package Processors.Game.Lobby.TopOrganization
{
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Registries.TRegistryRoutine;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.Organization.TBaseOrganizationMember;
   import Logics.SLogicsCore;
   import Logics.Streamization.TopOrganization.TUnstreamizerTopOrganization;
   import Logics.TopOrganization.TGVG2BattleReport;
   import Logics.TopOrganization.TGVG3BattleOrg;
   import Logics.TopOrganization.TGVG3BetOrg;
   import Logics.TopOrganization.TGVG3Top32Org;
   import Logics.TopOrganization.TJoinGVG2MatchOrg;
   import Logics.TopOrganization.TJoinGVG2MatchOrgs;
   import Logics.TopOrganization.TOrgMemberDigest;
   import Logics.TopOrganization.TOrganizationTop3Ranking;
   import Logics.TopOrganization.TTopOrganizationData;
   import Logics.TopOrganization.TTopOrganizationReports;
   import Logics.TopOrganization.TUserBetInfo;
   import Processors.Game.Common.Effects.Texts.TEffectCoordinateParameters;
   import Processors.Game.Common.Effects.Texts.TEffectTextParameters;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import Rendering.Overlayers.HelpTips.TOverlayerHelpTips;
   import Rendering.Overlayers.Inventories.TOverlayerAccessory;
   import Rendering.Overlayers.Inventories.TOverlayerAppliance;
   import Rendering.Overlayers.Inventories.TOverlayerEquipment;
   import Rendering.Overlayers.Inventories.TOverlayerTreasure;
   import Resources.Constants.CONST_CONFIGVALUE;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_INVENTORY;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_TOPORGANIZATION;
   import Resources.Strings.STRING_TOPORGANIZATION;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.display.DisplayObject;
   import flash.events.TimerEvent;
   import flash.utils.ByteArray;
   import flash.utils.Timer;
   
   public class TProcessorTopOrganization extends TProcessorLobbyWindows
   {
      
      public static const CATEGORY_Equipment:uint = CONST_INVENTORY.CATEGORY_Equipment;
      
      public static const CATEGORY_Treasure:uint = CONST_INVENTORY.CATEGORY_Treasure;
      
      public static const CATEGORY_Accessories:uint = CONST_INVENTORY.CATEGORY_Accessories;
      
      protected static const TYPE_JoinStart:uint = CONST_TOPORGANIZATION.TYPE_JoinStart;
      
      protected static const TYPE_EnterStart:uint = CONST_TOPORGANIZATION.TYPE_EnterStart;
      
      protected static const TYPE_BattleStart:uint = CONST_TOPORGANIZATION.TYPE_BattleStart;
      
      protected static const TYPE_BattleEnd:uint = CONST_TOPORGANIZATION.TYPE_BattleEnd;
      
      protected static const TYPE_GVG2JoinStart:uint = CONST_TOPORGANIZATION.TYPE_GVG2JoinStart;
      
      protected static const TYPE_GVG2Enter:uint = CONST_TOPORGANIZATION.TYPE_GVG2Enter;
      
      protected static const TYPE_GVG2Start:uint = CONST_TOPORGANIZATION.TYPE_GVG2Start;
      
      protected static const TYPE_GVG2BattleEnd:uint = CONST_TOPORGANIZATION.TYPE_GVG2BattleEnd;
      
      protected static const TYPE_GVG3BattleStart:uint = CONST_TOPORGANIZATION.TYPE_GVG3BattleStart;
      
      protected static const TYPE_GVG3BattleEnter:uint = CONST_TOPORGANIZATION.TYPE_GVG3BattleEnter;
      
      protected var FProcessorWindowTopOrganization:TProcessorWindowTopOrganization;
      
      protected var FProcessorWindowOrganizationRanking:TProcessorWindowOrganizationRanking;
      
      protected var FProcessorWindowJoinMember:TProcessorWindowJoinMember;
      
      protected var FProcessorWindowOrganizationJoin:TProcessorWindowOrganizationJoin;
      
      protected var FProcessorWindowSeeReport:TProcessorWindowSeeReport;
      
      protected var FProcessorWindowGVG2Report:TProcessorWindowGVG2Report;
      
      protected var FProcessorWindowFinalMatchList:TProcessorWindowFinalMatchList;
      
      protected var FProcessorWindowHistoryMatchList:TProcessorWindowHistoryMatchList;
      
      protected var FProcessorWindowBet:TProcessorWindowBet;
      
      protected var FProcessorWindowFinalBattleField:TProcessorWindowFinalBattleField;
      
      protected var FUnstreamizerTopOrganization:TUnstreamizerTopOrganization;
      
      protected var FRegistryRoutine:TRegistryRoutine;
      
      protected var FTopOrganizationData:TTopOrganizationData;
      
      protected var FSwitchSign:uint;
      
      protected var FGVGFstEndingReportClearTime:Vector.<uint>;
      
      protected var FGVGFirstEndingTime:Vector.<uint>;
      
      protected var FGVGFstReportStartTime:Vector.<uint>;
      
      protected var FGVGFstEnterTime:Vector.<uint>;
      
      protected var FGVGFstEndingReportClearTimes:Number;
      
      protected var FGVGFstEnterTimes:Number;
      
      protected var FGVGFstReportStartTimes:Number;
      
      protected var FGVGFirstEndingTimes:Number;
      
      protected var FReportType:uint;
      
      protected var FType:uint;
      
      protected var FTimer:Timer;
      
      protected var FOnceTexts:Vector.<uint>;
      
      protected var FGVG2ndEnterTime:Vector.<uint>;
      
      protected var FGVG2ndEnterTimes:Number;
      
      protected var FGVG2ndStartTime:Vector.<uint>;
      
      protected var FGVG2ndStartTimes:Number;
      
      protected var FGVG2ndReportEndTime:Vector.<uint>;
      
      protected var FGVG2ndReportEndTimes:Number;
      
      protected var FGVG3ndTimeStart:Array;
      
      protected var FGVG3ndTimeStarts:Number;
      
      protected var FGVG3ndTimeEnd:Array;
      
      protected var FGVG3ndTimeEnds:Number;
      
      protected var FCurrentRound:int;
      
      protected var FOnEffectSign:Function;
      
      public function TProcessorTopOrganization(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.Init();
         SetUIModuleID(CONST_MODULES.MODULE_TopOrganization);
      }
      
      protected function Init() : void
      {
         this.InitWindows();
         this.InitControls();
         this.InitParameters();
         this.InitWindowFunctions();
      }
      
      protected function InitWindows() : void
      {
         this.FProcessorWindowTopOrganization = new TProcessorWindowTopOrganization(this);
         this.FProcessorWindowTopOrganization.OnClose = this.ProcessorOnClose;
         this.FProcessorWindowTopOrganization.OnInventoryOver = UIComponentsHintOnOver;
         this.FProcessorWindowTopOrganization.OnInventoryOut = UIComponentsHintOnOut;
         this.FProcessorWindowTopOrganization.OnOpenWarUI = this.ProcessorOnOpenWarUI;
         this.FProcessorWindowTopOrganization.OnOpenRankingUI = this.ProcessorOnOpenRankingUI;
         this.FProcessorWindowTopOrganization.ApplyOnClick = this.ProcessorApplyOnClick;
         this.FProcessorWindowTopOrganization.JoinOnClick = this.ProcessorJoinOnClick;
         this.FProcessorWindowTopOrganization.OnHelpTipsOver = UIHelpTipsHintOnOver;
         this.FProcessorWindowTopOrganization.OnHelpTipsOut = UIHelpTipsHintOnOut;
         this.FProcessorWindowTopOrganization.OnEffectText = EffectGenerateText;
         this.FProcessorWindowJoinMember = new TProcessorWindowJoinMember(this);
         this.FProcessorWindowJoinMember.OnClose = this.ProcessorOnClose;
         this.FProcessorWindowOrganizationJoin = new TProcessorWindowOrganizationJoin(this);
         this.FProcessorWindowOrganizationJoin.OnClose = this.ProcessorOnClose;
         this.FProcessorWindowOrganizationJoin.ConfirmJoinOnClick = this.ProcessorConfirmJoinOnClick;
         this.FProcessorWindowOrganizationJoin.OnEffectText = this.ProcessorOnEffectText;
         this.FProcessorWindowOrganizationJoin.OnHelpTipsOver = UIHelpTipsHintOnOver;
         this.FProcessorWindowOrganizationJoin.OnHelpTipsOut = UIHelpTipsHintOnOut;
         this.FProcessorWindowSeeReport = new TProcessorWindowSeeReport(this);
         this.FProcessorWindowSeeReport.OnClose = this.ProcessorOnClose;
         this.FProcessorWindowSeeReport.OnHelpTipsOver = UIHelpTipsHintOnOver;
         this.FProcessorWindowSeeReport.OnHelpTipsOut = UIHelpTipsHintOnOut;
         this.FProcessorWindowSeeReport.OnOpenRankingUI = this.ProcessorOnOpenSequenceRankingUI;
         this.FProcessorWindowSeeReport.OnReportReqest = this.ProcessorOnReportReqest;
         this.FProcessorWindowSeeReport.OnReturnMainUI = this.ProcessorOnReturnMainUI;
         this.FProcessorWindowOrganizationRanking = new TProcessorWindowOrganizationRanking(this);
         this.FProcessorWindowOrganizationRanking.OnClose = this.ProcessorOnClose;
         this.FProcessorWindowGVG2Report = new TProcessorWindowGVG2Report(this);
         this.FProcessorWindowGVG2Report.OnClose = this.ProcessorOnClose;
         this.FProcessorWindowGVG2Report.OnHelpTipsOver = UIHelpTipsHintOnOver;
         this.FProcessorWindowGVG2Report.OnHelpTipsOut = UIHelpTipsHintOnOut;
         this.FProcessorWindowGVG2Report.OnReturnMainUI = this.ProcessorOnReturnMainUI;
         this.FProcessorWindowFinalMatchList = new TProcessorWindowFinalMatchList(this);
         this.FProcessorWindowFinalMatchList.OnClose = this.ProcessorOnClose;
         this.FProcessorWindowFinalMatchList.OnHelpTipsOver = UIHelpTipsHintOnOver;
         this.FProcessorWindowFinalMatchList.OnHelpTipsOut = UIHelpTipsHintOnOut;
         this.FProcessorWindowFinalMatchList.OnReturnMainUI = this.ProcessorOnReturnMainUI;
         this.FProcessorWindowFinalMatchList.BetOnClick = this.ProcessorBetOnClick;
         this.FProcessorWindowFinalMatchList.OnEffectText = this.ProcessorOnEffectText;
         this.FProcessorWindowFinalMatchList.LookOnClick = this.ProcessorLookOnClick;
         this.FProcessorWindowHistoryMatchList = new TProcessorWindowHistoryMatchList(this);
         this.FProcessorWindowHistoryMatchList.OnClose = this.ProcessorOnClose;
         this.FProcessorWindowHistoryMatchList.OnReturnMainUI = this.ProcessorOnReturnMainUI;
         this.FProcessorWindowBet = new TProcessorWindowBet(this);
         this.FProcessorWindowBet.BetOnClick = this.ProcessorBetOnClick;
         this.FProcessorWindowFinalBattleField = new TProcessorWindowFinalBattleField(this);
      }
      
      protected function InitControls() : void
      {
         FOverlayerEquipment = new TOverlayerEquipment(this,CONST_MODULES.MODULE_TopOrganization);
         FOverlayerEquipment.Visible = false;
         FOverlayerTreasure = new TOverlayerTreasure(this,CONST_MODULES.MODULE_TopOrganization);
         FOverlayerTreasure.Visible = false;
         FOverlayerAppliance = new TOverlayerAppliance(this,CONST_MODULES.MODULE_TopOrganization);
         FOverlayerAppliance.Visible = false;
         FOverlayerHelpTips = new TOverlayerHelpTips(this);
         FOverlayerHelpTips.Visible = false;
         FOverlayerAccessory = new TOverlayerAccessory(this,CONST_MODULES.MODULE_TopOrganization);
         FOverlayerAccessory.Visible = false;
      }
      
      protected function InitParameters() : void
      {
         this.FTopOrganizationData = SLogicsCore.TopOrganizationData;
         this.FUnstreamizerTopOrganization = new TUnstreamizerTopOrganization();
         this.FSwitchSign = 0;
         this.FTimer = new Timer(1000);
         this.FOnceTexts = new Vector.<uint>();
      }
      
      protected function InitWindowFunctions() : void
      {
         this.FRegistryRoutine = new TRegistryRoutine();
         this.FRegistryRoutine.Register(CONST_TOPORGANIZATION.TYPE_LocalServer,this.ProcessorOpenLocalServerWar);
         this.FRegistryRoutine.Register(CONST_TOPORGANIZATION.TYPE_CrossServerFirst,this.ProcessorOpenCrossServerFirstWar);
         this.FRegistryRoutine.Register(CONST_TOPORGANIZATION.TYPE_CrossServerFinal,this.ProcessorOpenCrossServerFinalWar);
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:int = 0;
         super.LogicsPerform();
         if(!Visible)
         {
            return;
         }
         if(!FIsResourcesLoadCompleted)
         {
            return;
         }
         _loc1_ = uint(STimingCore.GetServerTick());
         _loc2_ = this.FTopOrganizationData.BattleCDtime - _loc1_;
         if(_loc2_ < 0)
         {
            _loc2_ = 0;
         }
         this.FProcessorWindowFinalMatchList.UpdateCDTimeText(_loc2_);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_TOPORGANIZATION.RESOURCESID_Swf_TopOrganization);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerEquipment);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerTreasure);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerAppliance);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerAccessory);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerHelpTips);
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         var _loc1_:TConfigValue = null;
         var _loc2_:Vector.<Object> = null;
         this.FTimer.addEventListener(TimerEvent.TIMER,this.TimeOnTimer);
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.GVG_Fst_Ending_Report_Clear_Time) as TConfigValue;
         this.FGVGFstEndingReportClearTime = _loc1_.Value as Vector.<uint>;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.GVG_Fst_Ending_Report_Send_Time) as TConfigValue;
         this.FGVGFirstEndingTime = _loc1_.Value as Vector.<uint>;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.GVG_Fst_Enter_Time) as TConfigValue;
         this.FGVGFstEnterTime = _loc1_.Value as Vector.<uint>;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.GVG_Fst_Report_Start_Time) as TConfigValue;
         this.FGVGFstReportStartTime = _loc1_.Value as Vector.<uint>;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.GVG_2nd_Enter_Time) as TConfigValue;
         this.FGVG2ndEnterTime = _loc1_.Value as Vector.<uint>;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.GVG_2nd_Report_Start_Time) as TConfigValue;
         this.FGVG2ndStartTime = _loc1_.Value as Vector.<uint>;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.GVG_2nd_Report_End_Time) as TConfigValue;
         this.FGVG2ndReportEndTime = _loc1_.Value as Vector.<uint>;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.GVG_3nd_Time_node) as TConfigValue;
         _loc2_ = _loc1_.Value as Vector.<Object>;
         this.FGVG3ndTimeStart = _loc2_[0] as Array;
         this.FGVG3ndTimeEnd = _loc2_[_loc2_.length - 1] as Array;
         super.ResourcesPerform_UILocations();
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TopOrganization_Apply_Ret,this.PacketPerform_SC_Apply_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TopOrganization_GetCanApplyMember_Ret,this.PacketPerform_SC_GetCanApplyMember_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TopOrganization_GetGuildApply_Ret,this.PacketPerform_SC_GetGuildApply_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TopOrganization_GetGuildNo_Ret,this.PacketPerform_SC_GetGuildNo_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TopOrganization_GetApplyMember_Ret,this.PacketPerform_SC_GetApplyMember_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TopOrganization_GetBtlRet_Ret,this.PacketPerform_SC_GetBtlRet_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TopOrganization_SubmitBtlData_Ret,this.PacketPerform_SC_SubmitBtlData_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TopOrganization_IsSubmitBtlData_Ret,this.PacketPerform_SC_IsSubmitBtlData_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TopOrganization_Report_Notify_Ret,this.PacketPerform_SC_Report_Notify_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TopOrganization_GetGuildNo3_Ret,this.PacketPerform_SC_GetGuildNo3_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TopOrganization_GetGuildTop_Ret,this.PacketPerform_SC_GetGuildTop_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TopOrganization_GetUserWinTop_Ret,this.PacketPerform_SC_GetUserWinTop_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TopOrganization_GetBtlReport_Ret,this.PacketPerform_SC_GetBtlReport_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TopOrganization_IsNotifyReport_Ret,this.PacketPerform_SC_IsNotifyReport_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TopOrganization_GVG2_GetApplyGuildInfo_Ret,this.PacketPerform_SC_GVG2_GetApplyGuildInfo_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TopOrganization_GVG2_Apply_Ret,this.PacketPerform_SC_GVG2_Apply_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TopOrganization_GVG2_SubmitBtlData_Ret,this.PacketPerform_SC_GVG2_SubmitBtlData_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TopOrganization_GVG2_GetApplyMember_Ret,this.PacketPerform_SC_GVG2_GetApplyMember_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TopOrganization_GVG2_IsSubmitBtlData_Ret,this.PacketPerform_SC_GVG2_IsSubmitBtlData_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TopOrganization_GVG2_OpenReportWindows_Ret,this.PacketPerform_SC_GVG2_OpenReportWindows_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TopOrganization_GVG2_IsNotifyReport_Ret,this.PacketPerform_SC_GVG2_IsNotifyReport_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TopOrganization_GVG2_NotifyReport_Ret,this.PacketPerform_SC_GVG2_NotifyReport_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TopOrganization_GVG3_GetUserGuildInfo_Ret,this.PacketPerform_SC_GVG3_GetUserGuildInfo_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TopOrganization_GVG3_GetLastWeekCan_Ret,this.PacketPerform_SC_GVG3_GetLastWeekCan_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TopOrganization_GVG3_GetLastWeek_Ret,this.PacketPerform_SC_GVG3_GetLastWeek_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TopOrganization_GVG3_GetTop_Ret,this.PacketPerform_SC_GVG3_GetTop_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TopOrganization_GVG3_GetTopNotify_Ret,this.PacketPerform_SC_GVG3_GetTopNotify_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TopOrganization_GVG3_GetBetShow_Ret,this.PacketPerform_SC_GVG3_GetBetShow_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TopOrganization_GVG3_GetBetState_Ret,this.PacketPerform_SC_GVG3_GetBetState_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TopOrganization_GVG3_Bet_Ret,this.PacketPerform_SC_GVG3_Bet_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TopOrganization_GVG3_GetReport_Ret,this.PacketPerform_SC_GVG3_GetReport_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TopOrganization_GVG3_OpenReportWindows_Ret,this.PacketPerform_SC_GVG3_OpenReportWindows_Ret);
      }
      
      protected function PacketPerform_SC_Apply_Ret(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         _loc2_ = param1.Data;
         this.FProcessorWindowTopOrganization.SetButtonStatues(true);
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         EffectGenerateText(STRING_TOPORGANIZATION.STRING_ApplyExccess);
         this.FTopOrganizationData.ApplyStatus = 1;
         this.FProcessorWindowTopOrganization.Update();
      }
      
      protected function PacketPerform_SC_GetCanApplyMember_Ret(param1:TPacket) : void
      {
      }
      
      protected function PacketPerform_SC_GetGuildNo_Ret(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         this.FTopOrganizationData.OrgPreliminaryRanking = _loc3_;
         this.FProcessorWindowTopOrganization.UpdateOrgRank();
         this.FProcessorWindowSeeReport.UpdateOrgRank();
      }
      
      protected function PacketPerform_SC_GetApplyMember_Ret(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         _loc2_ = param1.Data;
         _loc4_ = _loc2_.readUnsignedInt();
         if(_loc4_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc4_);
            return;
         }
         this.FUnstreamizerTopOrganization.UnstreamizeStatusJoinMember(_loc2_,this.FTopOrganizationData.StatusJoinMembers,null);
         this.FTopOrganizationData.ApplyName = TUtilityString.FetchUTF(_loc2_);
         this.FProcessorWindowJoinMember.Update();
         this.FProcessorWindowJoinMember.Visible = true;
      }
      
      protected function PacketPerform_SC_GetBtlRet_Ret(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         _loc2_ = param1.Data;
         _loc4_ = _loc2_.readUnsignedInt();
         if(_loc4_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc4_);
            return;
         }
         if(this.FSwitchSign == CONST_TOPORGANIZATION.REQUEST_SeeReportUI)
         {
            this.PacketPerform_CS_GetGuildTop_Req();
            this.FProcessorWindowSeeReport.Visible = true;
            this.FProcessorWindowTopOrganization.Visible = false;
         }
      }
      
      protected function PacketPerform_SC_GetGuildApply_Ret(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         this.FTopOrganizationData.ApplyStatus = _loc3_;
         if(FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowTopOrganization.Update();
         }
      }
      
      protected function PacketPerform_SC_SubmitBtlData_Ret(param1:TPacket) : void
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
         EffectGenerateText(STRING_TOPORGANIZATION.STRING_ApplyProcessionData);
         this.FTopOrganizationData.IsSubmitData = 1;
         if(FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowTopOrganization.Update();
         }
      }
      
      protected function PacketPerform_SC_IsSubmitBtlData_Ret(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         this.FTopOrganizationData.IsSubmitData = _loc3_;
         if(FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowTopOrganization.Update();
         }
      }
      
      protected function PacketPerform_SC_Report_Notify_Ret(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         _loc2_ = param1.Data;
         _loc3_ = uint(STimingCore.GetServerTime());
         if(_loc3_ >= this.FGVGFstReportStartTimes && _loc3_ < this.FGVGFirstEndingTimes)
         {
            this.FUnstreamizerTopOrganization.UnstreamizeTopOrganizationReport(_loc2_,this.FTopOrganizationData.TopOrganizationReports,null);
            if(FIsResourcesLoadCompleted)
            {
               this.FProcessorWindowSeeReport.UpdateBattlingReport();
            }
         }
      }
      
      protected function PacketPerform_SC_GetGuildNo3_Ret(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:int = 0;
         var _loc5_:uint = 0;
         var _loc6_:TOrganizationTop3Ranking = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc5_ = uint(_loc2_.readShort());
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc6_ = new TOrganizationTop3Ranking();
            _loc6_.Rank = _loc2_.readUnsignedInt();
            _loc6_.OrganizaitonName = TUtilityString.FetchUTF(_loc2_);
            this.FTopOrganizationData.OrganizationTop3Rankings.Add(_loc6_);
            _loc4_++;
         }
         this.FTopOrganizationData.OrganizationTop3Rankings.Sort();
         if(FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowSeeReport.UpdateTop3();
         }
      }
      
      protected function PacketPerform_SC_GetGuildTop_Ret(param1:TPacket) : void
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
         this.FUnstreamizerTopOrganization.UnstreamizeOrganizationRankings(_loc2_,this.FTopOrganizationData.JoinOrganizations,null);
         if(FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowSeeReport.UpdateOrganizationRankings();
         }
      }
      
      protected function PacketPerform_SC_GetUserWinTop_Ret(param1:TPacket) : void
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
         this.FUnstreamizerTopOrganization.UnstreamizeSequenceRanking(_loc2_,this.FTopOrganizationData.SequenceRankings,null);
         this.FProcessorWindowOrganizationRanking.UpdateRankings();
         this.FProcessorWindowOrganizationRanking.Visible = true;
      }
      
      protected function PacketPerform_SC_GetBtlReport_Ret(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:int = 0;
         var _loc5_:uint = 0;
         var _loc6_:TTopOrganizationReports = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         this.FTopOrganizationData.OrganizationReports.Clear();
         this.FTopOrganizationData.PersonalReports.Clear();
         _loc6_ = this.FReportType == 0 ? this.FTopOrganizationData.OrganizationReports : this.FTopOrganizationData.PersonalReports;
         _loc5_ = uint(_loc2_.readShort());
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            this.FUnstreamizerTopOrganization.UnstreamizeTopOrganizationReport(_loc2_,_loc6_,null);
            _loc4_++;
         }
         this.FProcessorWindowSeeReport.Update(this.FReportType);
      }
      
      protected function PacketPerform_SC_IsNotifyReport_Ret(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:Boolean = false;
         var _loc4_:uint = 0;
         _loc2_ = param1.Data;
         _loc3_ = Boolean(_loc2_.readUnsignedInt());
         this.FTopOrganizationData.IsBattling = _loc3_;
         if(FIsResourcesLoadCompleted)
         {
            _loc4_ = uint(STimingCore.GetServerTime());
            if(_loc4_ >= this.FGVGFstReportStartTimes && _loc4_ < this.FGVGFstEndingReportClearTimes)
            {
               if(!_loc3_)
               {
                  this.FProcessorWindowSeeReport.BattleEnd();
                  this.PacketPerform_CS_GetGuildNo_Req();
                  this.PacketPerform_CS_GetGuildNo3_Req();
               }
            }
         }
      }
      
      protected function PacketPerform_SC_GVG2_GetApplyGuildInfo_Ret(param1:TPacket) : void
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
         this.FUnstreamizerTopOrganization.UnstreamizeJoinGVG2OrgStatus(_loc2_,this.FTopOrganizationData.JoinGVG2MatchOrgs,null);
         this.FProcessorWindowTopOrganization.UpdateGVG2UI();
      }
      
      protected function PacketPerform_SC_GVG2_Apply_Ret(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:TJoinGVG2MatchOrg = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc4_ = this.FTopOrganizationData.JoinGVG2MatchOrgs.GetMyOrgByIdentifier(SLogicsCore.Organization.OrgId);
         if(_loc4_ != null && _loc4_.GVG2Status == 1)
         {
            _loc4_.GVG2Status = 2;
         }
         this.FProcessorWindowTopOrganization.SetButtonStatues(true);
         this.FProcessorWindowTopOrganization.Update();
      }
      
      protected function PacketPerform_SC_GVG2_SubmitBtlData_Ret(param1:TPacket) : void
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
         EffectGenerateText(STRING_TOPORGANIZATION.STRING_ApplyProcessionData);
         this.FTopOrganizationData.GVG2IsSubmitData = 1;
         if(FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowTopOrganization.UpdateGVG2UI();
         }
      }
      
      protected function PacketPerform_SC_GVG2_GetApplyMember_Ret(param1:TPacket) : void
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
         this.FUnstreamizerTopOrganization.UnstreamizeStatusJoinGVG2Members(_loc2_,this.FTopOrganizationData.StatusJoinGVG2Members,null);
         this.FTopOrganizationData.ApplyGVG2Name = TUtilityString.FetchUTF(_loc2_);
         this.FProcessorWindowJoinMember.Update(CONST_TOPORGANIZATION.TYPE_GVG2_Join);
         this.FProcessorWindowJoinMember.Visible = true;
      }
      
      protected function PacketPerform_SC_GVG2_IsSubmitBtlData_Ret(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         this.FTopOrganizationData.GVG2IsSubmitData = _loc3_;
         if(FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowTopOrganization.UpdateGVG2UI();
         }
      }
      
      protected function PacketPerform_SC_GVG2_OpenReportWindows_Ret(param1:TPacket) : void
      {
         var _loc2_:uint = 0;
         _loc2_ = uint(STimingCore.GetServerTime());
         if(this.FSwitchSign == CONST_TOPORGANIZATION.REQUEST_SeeReportUI)
         {
            this.FProcessorWindowGVG2Report.Visible = true;
            this.FProcessorWindowTopOrganization.Visible = false;
            if(_loc2_ >= this.FGVG2ndStartTimes && !this.FTopOrganizationData.GVG2IsBattling)
            {
               this.PacketPerform_CS_GVG2_HistoryReport_Req();
            }
         }
      }
      
      protected function PacketPerform_SC_GVG2_IsNotifyReport_Ret(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:Boolean = false;
         var _loc4_:uint = 0;
         _loc2_ = param1.Data;
         _loc3_ = Boolean(_loc2_.readUnsignedInt());
         this.FTopOrganizationData.GVG2IsBattling = _loc3_;
         if(FIsResourcesLoadCompleted)
         {
            _loc4_ = uint(STimingCore.GetServerTime());
            if(_loc4_ >= this.FGVG2ndStartTimes && _loc4_ < this.FGVGFstEndingReportClearTimes)
            {
               if(!_loc3_)
               {
                  this.FProcessorWindowTopOrganization.UpdateGVG2TextStatus(TYPE_GVG2BattleEnd);
                  this.FProcessorWindowTopOrganization.OpenGVG2ButtonStatus(TYPE_GVG2BattleEnd);
                  this.PacketPerform_CS_GVG2_HistoryReport_Req();
                  this.PacketPerform_CS_GVG2_GetApplyGuildInfo_Req();
               }
            }
         }
      }
      
      protected function PacketPerform_SC_GVG2_NotifyReport_Ret(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:TGVG2BattleReport = null;
         _loc2_ = param1.Data;
         this.FTopOrganizationData.GVG2BattleReports.Clear();
         this.FUnstreamizerTopOrganization.UnstreamizeGVG2BattleReports(_loc2_,this.FTopOrganizationData.GVG2BattleReports,null);
         _loc5_ = this.FTopOrganizationData.GVG2BattleReports.GetGVG2BattleReportByIndex(this.FTopOrganizationData.GVG2BattleReports.Count - 1);
         if(_loc5_ != null)
         {
            if(_loc5_.IsRequest == 0 && this.FTopOrganizationData.GVG2IsBattling)
            {
               if(FIsResourcesLoadCompleted)
               {
                  this.FProcessorWindowGVG2Report.UpdateGVG2BattleReport();
               }
            }
            else if(FIsResourcesLoadCompleted)
            {
               this.FProcessorWindowGVG2Report.UpdateHistoryReport();
            }
         }
      }
      
      protected function PacketPerform_SC_GVG3_GetUserGuildInfo_Ret(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = param1.Data;
         this.FTopOrganizationData.GVG3MyOrgStatus = _loc2_.readUnsignedInt();
         this.FTopOrganizationData.GVG3MyOrgRank = _loc2_.readUnsignedInt();
      }
      
      protected function PacketPerform_SC_GVG3_GetLastWeekCan_Ret(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         this.FTopOrganizationData.GVG3IsCanLookLastWeekRanks = !Boolean(_loc3_);
         if(_loc3_ == 1)
         {
            EffectGenerateText(STRING_TOPORGANIZATION.STRING_LastWeekRankBlank);
         }
         else
         {
            this.PacketPerform_CS_GVG3_GetLastWeek_Req();
         }
      }
      
      protected function PacketPerform_SC_GVG3_GetLastWeek_Ret(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = param1.Data;
         this.FUnstreamizerTopOrganization.UnstreamizeGVG3Top32Orgs(_loc2_,this.FTopOrganizationData.GVG3Top32Orgs,null);
         this.FTopOrganizationData.CurrentRound = 5;
         if(FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowHistoryMatchList.Update();
            this.FProcessorWindowHistoryMatchList.Visible = true;
            this.FProcessorWindowTopOrganization.Visible = false;
         }
      }
      
      protected function PacketPerform_SC_GVG3_GetTop_Ret(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         _loc2_ = param1.Data;
         this.FTopOrganizationData.GroupType = _loc2_.readUnsignedInt();
         this.FCurrentRound = _loc2_.readInt();
         if(this.FCurrentRound == -1)
         {
            EffectGenerateText(STRING_TOPORGANIZATION.STRING_MatchNotStart);
            return;
         }
         if(this.FCurrentRound == -2)
         {
            this.FTopOrganizationData.CurrentRound = 5;
         }
         else
         {
            this.FTopOrganizationData.CurrentRound = this.FCurrentRound;
            this.FProcessorWindowFinalMatchList.RequestBetState();
         }
         this.FUnstreamizerTopOrganization.UnstreamizeGVG3Top32Orgs(_loc2_,this.FTopOrganizationData.GVG3Top32Orgs,null);
         _loc3_ = _loc2_.readUnsignedInt();
         this.FTopOrganizationData.BattleCDtime = this.GetCDTimes(_loc3_);
         if(FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowFinalMatchList.Update();
            this.FProcessorWindowFinalMatchList.Visible = true;
            this.FProcessorWindowTopOrganization.Visible = false;
         }
      }
      
      protected function GetCDTimes(param1:uint) : Number
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:Number = NaN;
         _loc4_ = uint(param1 / (24 * 60 * 60));
         _loc5_ = param1 % (24 * 60 * 60);
         _loc2_ = uint(_loc5_ / (60 * 60));
         _loc3_ = uint(_loc5_ % (60 * 60)) / 60;
         return this.GetRepeatCount(_loc4_ % 7,_loc2_,_loc3_);
      }
      
      protected function PacketPerform_SC_GVG3_GetTopNotify_Ret(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         _loc2_ = param1.Data;
         this.FTopOrganizationData.GroupType = _loc2_.readUnsignedInt();
         _loc4_ = _loc2_.readUnsignedInt();
         if(_loc4_ < this.FTopOrganizationData.CurrentRound)
         {
            this.FTopOrganizationData.CurrentBetCircle = 0;
         }
         this.FTopOrganizationData.CurrentRound = _loc4_;
         this.FUnstreamizerTopOrganization.UnstreamizeAddGVG3Top32Org(_loc2_,this.FTopOrganizationData.GVG3Top32Orgs,null);
         _loc3_ = _loc2_.readUnsignedInt();
         this.FTopOrganizationData.BattleCDtime = this.GetCDTimes(_loc3_);
         _loc5_ = _loc2_.readUnsignedInt();
         if(_loc5_ == 0)
         {
            this.FTopOrganizationData.CurrentBetCircle = 0;
         }
         if(FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowFinalMatchList.UpdateNotify();
         }
      }
      
      protected function PacketPerform_SC_GVG3_GetBetShow_Ret(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = param1.Data;
         this.FUnstreamizerTopOrganization.UnstreamizeGVG3BetOrgs(_loc2_,this.FTopOrganizationData.GVG3BetOrgs,null);
         if(FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowBet.Update();
            this.FProcessorWindowBet.Visible = true;
         }
      }
      
      protected function PacketPerform_SC_GVG3_GetBetState_Ret(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = param1.Data;
         this.FTopOrganizationData.GroupType = _loc2_.readUnsignedInt();
         this.FTopOrganizationData.CurrentBetCircle = _loc2_.readUnsignedInt();
         this.FTopOrganizationData.CurrentBetAttOrgID = _loc2_.readUnsignedInt();
         this.FTopOrganizationData.CurrentBetDefOrgID = _loc2_.readUnsignedInt();
         this.FTopOrganizationData.BetOrg = _loc2_.readUnsignedInt();
         this.FTopOrganizationData.BetType = _loc2_.readUnsignedInt();
         if(FIsResourcesLoadCompleted)
         {
            if(this.FCurrentRound != -1)
            {
               this.FProcessorWindowFinalMatchList.UpdateBetButtonUI();
               this.FProcessorWindowBet.Update();
            }
         }
      }
      
      protected function PacketPerform_SC_GVG3_Bet_Ret(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:TUserBetInfo = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         this.FTopOrganizationData.GroupType = _loc2_.readUnsignedInt();
         this.FUnstreamizerTopOrganization.UnstreamizeGVG3BetInfos(_loc2_,this.FTopOrganizationData.UserBetInfos,null);
         _loc4_ = this.FTopOrganizationData.UserBetInfos.GetUserBetInfoByIndex(this.FTopOrganizationData.UserBetInfos.Count - 1);
         if(_loc4_ != null)
         {
            this.FTopOrganizationData.CurrentBetCircle = _loc4_.Round;
            this.FTopOrganizationData.CurrentBetAttOrgID = _loc4_.AttackOrgID;
            this.FTopOrganizationData.CurrentBetDefOrgID = _loc4_.DefendOrgID;
            if(this.FTopOrganizationData.CurrentBetAttOrgID == _loc4_.BetOrgID)
            {
               this.FTopOrganizationData.BetOrg = 0;
            }
            if(this.FTopOrganizationData.CurrentBetDefOrgID == _loc4_.BetOrgID)
            {
               this.FTopOrganizationData.BetOrg = 1;
            }
            this.FTopOrganizationData.BetType = _loc4_.BetType;
         }
         if(FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowBet.Update();
            this.FProcessorWindowFinalMatchList.UpdateBetButtonUI();
         }
      }
      
      protected function PacketPerform_SC_GVG3_GetReport_Ret(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            EffectGenerateText(STRING_TOPORGANIZATION.STRING_NoWar);
            return;
         }
         this.FUnstreamizerTopOrganization.UnstreamizeGVG3BattleOrgs(_loc2_,this.FTopOrganizationData.GVG3BattleOrgs,null);
         this.FUnstreamizerTopOrganization.UnstreamizeGVG3BattleReports(_loc2_,this.FTopOrganizationData.GVG3BattleReports,null);
         this.FProcessorWindowFinalBattleField.Update();
         this.FProcessorWindowFinalBattleField.Visible = true;
      }
      
      protected function PacketPerform_SC_GVG3_OpenReportWindows_Ret(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = param1.Data;
         if(this.FSwitchSign == CONST_TOPORGANIZATION.REQUEST_SeeReportUI)
         {
            this.PacketPerform_CS_GVG3_GetTop_Req();
         }
      }
      
      protected function ProcessorOpenLocalServerWar() : void
      {
         this.FSwitchSign = CONST_TOPORGANIZATION.REQUEST_SeeReportUI;
         this.PacketPerform_CS_GetBtlRet_Req();
      }
      
      protected function ProcessorOpenCrossServerFirstWar() : void
      {
         this.FSwitchSign = CONST_TOPORGANIZATION.REQUEST_SeeReportUI;
         this.PacketPerform_CS_GVG2_OpenReportWindows_Req();
      }
      
      protected function ProcessorOpenCrossServerFinalWar() : void
      {
         this.FSwitchSign = CONST_TOPORGANIZATION.REQUEST_SeeReportUI;
         this.PacketPerform_CS_GVG3_OpenReportWindows_Req();
         this.PacketPerform_CS_GVG3_GetBetState_Req(this.FTopOrganizationData.GroupType);
      }
      
      protected function PacketPerform_CS_GVG3_GetTop_Req() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TopOrganization_GVG3_GetTop_Req);
         _loc2_ = _loc1_.Data;
         _loc2_.writeUnsignedInt(0);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PacketPerform_CS_GVG3_GetLastWeek_Req() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TopOrganization_GVG3_GetLastWeek_Req);
         _loc2_ = _loc1_.Data;
         _loc2_.writeUnsignedInt(0);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PacketPerform_CS_GVG3_GetBetState_Req(param1:uint = 0) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TopOrganization_GVG3_GetBetState_Req);
         _loc3_ = _loc2_.Data;
         _loc3_.writeUnsignedInt(param1);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function PacketPerform_CS_GVG3_GetUserGuildInfo_Req() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TopOrganization_GVG3_GetUserGuildInfo_Req);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PacketPerform_CS_GVG3_OpenReportWindows_Req() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TopOrganization_GVG3_OpenReportWindows_Req);
         _loc2_ = _loc1_.Data;
         _loc2_.writeUnsignedInt(this.FSwitchSign);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PacketPerform_CS_GVG2_OpenReportWindows_Req() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TopOrganization_GVG2_OpenReportWindows_Req);
         _loc2_ = _loc1_.Data;
         _loc2_.writeUnsignedInt(this.FSwitchSign);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PacketPerform_CS_GVG2_GetApplyMember_Req() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TopOrganization_GVG2_GetApplyMember_Req);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PacketPerform_CS_GVG2_HistoryReport_Req() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TopOrganization_GVG2_HistoryReport_Req);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PacketPerform_CS_GVG2_GetApplyGuildInfo_Req() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TopOrganization_GVG2_GetApplyGuildInfo_Req);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PacketPerform_CS_GVG2_IsNotifyReport_Req() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TopOrganization_GVG2_IsNotifyReport_Req);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PacketPerform_CS_GVG2_IsSubmitBtlData_Req() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TopOrganization_GVG2_IsSubmitBtlData_Req);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PacketPerform_CS_GetBtlRet_Req() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TopOrganization_GetBtlRet_Req);
         _loc2_ = _loc1_.Data;
         _loc2_.writeUnsignedInt(this.FSwitchSign);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PacketPerform_CS_IsNotifyReport_Req() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TopOrganization_IsNotifyReport_Req);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PacketPerform_CS_GetGuildApply_Req() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TopOrganization_GetGuildApply_Req);
         _loc2_ = _loc1_.Data;
         _loc2_.writeUnsignedInt(SLogicsCore.Organization.OrgId);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PacketPerform_CS_GetGuildNo_Req() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TopOrganization_GetGuildNo_Req);
         _loc2_ = _loc1_.Data;
         _loc2_.writeUnsignedInt(SLogicsCore.Organization.OrgId);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PacketPerform_CS_IsSubmitBtlData_Req() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TopOrganization_IsSubmitBtlData_Req);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function GetRepeatCount(param1:uint, param2:uint, param3:uint) : Number
      {
         var _loc4_:Date = null;
         var _loc5_:uint = 0;
         var _loc6_:Number = NaN;
         var _loc7_:int = 0;
         var _loc8_:Number = NaN;
         _loc4_ = new Date(STimingCore.GetServerTime() * 1000);
         _loc5_ = _loc4_.day;
         if(param1 != 0)
         {
            if(_loc5_ == 0)
            {
               _loc7_ = param1 - 7;
            }
            else
            {
               _loc7_ = param1 - _loc5_;
            }
         }
         else if(_loc5_ == 0)
         {
            _loc7_ = 0;
         }
         else if(_loc5_ < param1 + 7)
         {
            _loc7_ = param1 + 7 - _loc5_;
         }
         else
         {
            _loc7_ = _loc5_ - (param1 + 7);
         }
         _loc4_.setHours(0,0,0,0);
         _loc6_ = _loc4_.valueOf();
         _loc4_.setTime(_loc6_ + _loc7_ * 60 * 60 * 24 * 1000);
         _loc4_.setHours(param2,param3,0,0);
         return uint(_loc4_.valueOf() / 1000);
      }
      
      protected function TimeOnTimer(param1:TimerEvent) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:Date = null;
         _loc2_ = uint(STimingCore.GetServerTime());
         if(_loc2_ >= this.FGVGFstEnterTimes && _loc2_ < this.FGVGFstReportStartTimes)
         {
            _loc4_ = TYPE_EnterStart;
         }
         else if(_loc2_ >= this.FGVGFstReportStartTimes && _loc2_ < this.FGVGFirstEndingTimes)
         {
            _loc4_ = TYPE_BattleStart;
         }
         else if(_loc2_ >= this.FGVGFirstEndingTimes && _loc2_ < this.FGVGFstEndingReportClearTimes)
         {
            _loc4_ = TYPE_BattleEnd;
         }
         else
         {
            _loc4_ = TYPE_JoinStart;
         }
         _loc3_ = this.FOnceTexts.indexOf(_loc4_);
         switch(_loc4_)
         {
            case TYPE_JoinStart:
               if(_loc3_ == -1)
               {
                  this.FTopOrganizationData.Reset();
                  this.FProcessorWindowSeeReport.Reset();
                  this.FProcessorWindowTopOrganization.OpenButtonStatus(false);
                  this.FProcessorWindowTopOrganization.OpenGVG2ButtonStatus(TYPE_JoinStart);
                  this.FProcessorWindowTopOrganization.UpdateGVG2TextStatus(TYPE_JoinStart);
                  this.FOnceTexts.push(_loc4_);
               }
               else
               {
                  _loc6_ = this.FOnceTexts.length;
                  if(_loc6_ == 0)
                  {
                     return;
                  }
                  _loc10_ = new Date(_loc2_ * 1000);
                  _loc5_ = _loc10_.day;
                  _loc7_ = _loc10_.hours;
                  _loc8_ = _loc10_.minutes;
                  _loc9_ = _loc10_.seconds;
                  if(_loc5_ == 1 && _loc7_ == 0 && _loc8_ == 0 && _loc9_ == 0)
                  {
                     while(this.FOnceTexts.length > 0)
                     {
                        this.FOnceTexts.pop();
                     }
                     this.FOnceTexts.length = 0;
                  }
               }
               break;
            case TYPE_EnterStart:
               if(_loc3_ == -1)
               {
                  this.FProcessorWindowSeeReport.UpdateBattleStartTips();
                  this.FProcessorWindowTopOrganization.OpenButtonStatus();
                  this.FProcessorWindowTopOrganization.UpdateGVG2TextStatus(TYPE_EnterStart);
                  this.FOnceTexts.push(_loc4_);
               }
               break;
            case TYPE_BattleStart:
               if(_loc3_ == -1)
               {
                  this.FProcessorWindowTopOrganization.OpenButtonStatus();
                  this.FProcessorWindowTopOrganization.UpdateGVG2TextStatus(TYPE_BattleStart);
                  this.FOnceTexts.push(_loc4_);
               }
               break;
            case TYPE_BattleEnd:
               if(_loc3_ == -1)
               {
                  this.FProcessorWindowTopOrganization.OpenButtonStatus();
                  this.FOnceTexts.push(_loc4_);
               }
         }
         this.CheckGVG2TimeZone();
         this.CheckGVG3TimeZone();
      }
      
      protected function CheckGVG2TimeZone() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:int = 0;
         _loc1_ = uint(STimingCore.GetServerTime());
         if(_loc1_ >= this.FGVGFirstEndingTimes && _loc1_ < this.FGVG2ndEnterTimes)
         {
            _loc2_ = TYPE_GVG2JoinStart;
         }
         else if(_loc1_ >= this.FGVG2ndEnterTimes && _loc1_ < this.FGVG2ndStartTimes)
         {
            _loc2_ = TYPE_GVG2Enter;
         }
         else if(_loc1_ >= this.FGVG2ndStartTimes && _loc1_ < this.FGVG2ndReportEndTimes)
         {
            _loc2_ = TYPE_GVG2Start;
         }
         else if(_loc1_ >= this.FGVG2ndReportEndTimes && _loc1_ < this.FGVGFstEndingReportClearTimes)
         {
            _loc2_ = TYPE_GVG2BattleEnd;
         }
         _loc3_ = this.FOnceTexts.indexOf(_loc2_);
         switch(_loc2_)
         {
            case TYPE_GVG2JoinStart:
               if(_loc3_ == -1)
               {
                  this.FProcessorWindowTopOrganization.OpenGVG2ButtonStatus(TYPE_GVG2JoinStart);
                  this.FProcessorWindowTopOrganization.UpdateGVG2TextStatus(TYPE_GVG2JoinStart);
                  this.FOnceTexts.push(_loc2_);
               }
               break;
            case TYPE_GVG2Enter:
               if(_loc3_ == -1)
               {
                  this.FProcessorWindowTopOrganization.OpenGVG2ButtonStatus(TYPE_GVG2Enter);
                  this.FProcessorWindowTopOrganization.UpdateGVG2TextStatus(TYPE_GVG2Enter);
                  this.FProcessorWindowGVG2Report.UpdateBattleStartTips(true);
                  this.FOnceTexts.push(_loc2_);
               }
               break;
            case TYPE_GVG2Start:
               if(_loc3_ == -1)
               {
                  this.FProcessorWindowTopOrganization.OpenGVG2ButtonStatus(TYPE_GVG2Start);
                  this.FProcessorWindowGVG2Report.UpdateBattleStartTips(false);
                  this.FOnceTexts.push(_loc2_);
               }
               break;
            case TYPE_GVG2BattleEnd:
               if(_loc3_ == -1)
               {
                  this.FOnceTexts.push(_loc2_);
               }
         }
      }
      
      protected function CheckGVG3TimeZone() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:int = 0;
         _loc1_ = uint(STimingCore.GetServerTime());
         if(_loc1_ < this.FGVG2ndReportEndTimes)
         {
            _loc2_ = TYPE_GVG2Start;
         }
         else if(_loc1_ >= this.FGVG2ndReportEndTimes && _loc1_ < this.FGVG3ndTimeStarts)
         {
            _loc2_ = TYPE_GVG3BattleStart;
         }
         else if(_loc1_ >= this.FGVG3ndTimeStarts && _loc1_ < this.FGVGFstEndingReportClearTimes)
         {
            _loc2_ = TYPE_GVG3BattleEnter;
         }
         this.FProcessorWindowTopOrganization.UpdateGVG3UI(_loc2_);
      }
      
      protected function ProcessorOnClose(param1:Object) : void
      {
         var _loc2_:Boolean = false;
         _loc2_ = param1 is TProcessorWindowTopOrganization;
         if(!_loc2_)
         {
            this.FProcessorWindowTopOrganization.Visible = true;
            (param1 as DisplayObject).visible = false;
            if(this.FProcessorWindowSeeReport.Visible)
            {
               this.FProcessorWindowTopOrganization.Visible = !this.FProcessorWindowSeeReport.Visible;
            }
            if(param1 is TProcessorWindowFinalMatchList)
            {
               this.FSwitchSign = CONST_TOPORGANIZATION.REQUEST_CloseReportUI;
               this.PacketPerform_CS_GVG3_OpenReportWindows_Req();
            }
         }
         else
         {
            ProcessorClose();
            if(param1 is TProcessorWindowSeeReport)
            {
               this.FSwitchSign = CONST_TOPORGANIZATION.REQUEST_CloseReportUI;
               this.PacketPerform_CS_GetBtlRet_Req();
            }
            else if(param1 is TProcessorWindowGVG2Report)
            {
               this.FSwitchSign = CONST_TOPORGANIZATION.REQUEST_CloseReportUI;
               this.PacketPerform_CS_GVG2_OpenReportWindows_Req();
            }
         }
      }
      
      protected function ProcessorOnOpenWarUI(param1:Object, param2:int) : void
      {
         var _loc3_:Function = null;
         _loc3_ = this.FRegistryRoutine.GetRoutineByIndentifier(param2);
         if(_loc3_ != null)
         {
            _loc3_();
         }
      }
      
      protected function ProcessorApplyOnClick(param1:Object, param2:uint) : void
      {
         var _loc3_:TPacket = null;
         this.FType = param2;
         if(param2 == CONST_TOPORGANIZATION.TYPE_GVG1_Join)
         {
            _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TopOrganization_SubmitBtlData_Req);
         }
         else if(param2 == CONST_TOPORGANIZATION.TYPE_GVG2_Join)
         {
            _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TopOrganization_GVG2_SubmitBtlData_Req);
         }
         else if(param2 == CONST_TOPORGANIZATION.TYPE_GVG3_LastRanking)
         {
            _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TopOrganization_GVG3_GetLastWeekCan_Req);
         }
         SNetworkCore.Transceiver.PacketTransmit(_loc3_);
      }
      
      protected function ProcessorOnEffectText(param1:Object, param2:String, param3:TEffectTextParameters = null, param4:TEffectCoordinateParameters = null) : void
      {
         if(FOnEffectText != null)
         {
            FOnEffectText(this,param2,param3,param4);
         }
      }
      
      protected function ProcessorConfirmJoinOnClick(param1:Object, param2:Vector.<TBaseOrganizationMember>) : void
      {
         var _loc3_:TPacket = null;
         var _loc4_:ByteArray = null;
         var _loc5_:int = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:TBaseOrganizationMember = null;
         switch(this.FType)
         {
            case CONST_TOPORGANIZATION.TYPE_GVG1_Join:
               _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TopOrganization_Apply_Req);
               break;
            case CONST_TOPORGANIZATION.TYPE_GVG2_Join:
               _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TopOrganization_GVG2_Apply_Req);
         }
         _loc4_ = _loc3_.Data;
         _loc6_ = param2.length;
         _loc4_.writeShort(_loc6_);
         _loc5_ = 0;
         while(_loc5_ < _loc6_)
         {
            _loc9_ = param2[_loc5_];
            _loc7_ = _loc9_.Identifier0;
            _loc8_ = _loc9_.Identifier1;
            _loc4_.writeUnsignedInt(_loc7_);
            _loc4_.writeUnsignedInt(_loc8_);
            _loc5_++;
         }
         SNetworkCore.Transceiver.PacketTransmit(_loc3_);
         this.FProcessorWindowTopOrganization.SetButtonStatues(false);
      }
      
      protected function ProcessorJoinOnClick(param1:Object, param2:uint) : void
      {
         var _loc3_:TJoinGVG2MatchOrgs = null;
         var _loc4_:TJoinGVG2MatchOrg = null;
         _loc3_ = this.FTopOrganizationData.JoinGVG2MatchOrgs;
         switch(param2)
         {
            case CONST_TOPORGANIZATION.TYPE_GVG1_Join:
               switch(this.FTopOrganizationData.ApplyStatus)
               {
                  case 0:
                     this.FProcessorWindowOrganizationJoin.Visible = true;
                     this.FProcessorWindowOrganizationJoin.Update(param2);
                     break;
                  case 1:
                     this.PacketPerform_CS_GetApplyMember_Req();
               }
               break;
            case CONST_TOPORGANIZATION.TYPE_GVG2_Join:
               _loc4_ = _loc3_.GetMyOrgByIdentifier(SLogicsCore.Organization.OrgId);
               if(_loc4_.GVG2Status == 1)
               {
                  this.FProcessorWindowOrganizationJoin.Visible = true;
                  this.FProcessorWindowOrganizationJoin.Update(param2);
               }
               else if(_loc4_.GVG2Status == 2)
               {
                  this.PacketPerform_CS_GVG2_GetApplyMember_Req();
               }
         }
         this.FType = param2;
      }
      
      protected function ProcessorOnOpenSequenceRankingUI(param1:Object) : void
      {
         this.PacketPerform_CS_GetUserWinTop_Req();
      }
      
      protected function ProcessorOnReportReqest(param1:Object, param2:uint) : void
      {
         this.FReportType = param2;
         this.PacketPerform_CS_GetBtlReport_Req();
      }
      
      protected function ProcessorOnReturnMainUI(param1:Object) : void
      {
         this.FProcessorWindowSeeReport.Visible = false;
         this.FProcessorWindowGVG2Report.Visible = false;
         this.FProcessorWindowFinalMatchList.Visible = false;
         this.FProcessorWindowTopOrganization.Visible = true;
         this.FProcessorWindowGVG2Report.Reset();
      }
      
      protected function PacketPerform_CS_GetBtlReport_Req() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TopOrganization_GetBtlReport_Req);
         _loc2_ = _loc1_.Data;
         _loc2_.writeUnsignedInt(this.FReportType);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PacketPerform_CS_GetUserWinTop_Req() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TopOrganization_GetUserWinTop_Req);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PacketPerform_CS_GetApplyMember_Req() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TopOrganization_GetApplyMember_Req);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PacketPerform_CS_LoadMemberListReq() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Organization_LoadMemberListReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function ProcessorOnOpenRankingUI(param1:Object) : void
      {
      }
      
      protected function PacketPerform_CS_GetGuildTop_Req() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TopOrganization_GetGuildTop_Req);
         _loc2_ = _loc1_.Data;
         _loc2_.writeUnsignedInt(1000);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PacketPerform_CS_GetGuildNo3_Req() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TopOrganization_GetGuildNo3_Req);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PacketPerform_CS_JoinReq() : void
      {
      }
      
      protected function ProcessorBetOnClick(param1:Object, param2:uint, param3:uint, param4:uint, param5:uint, param6:uint, param7:uint, param8:int = -1, param9:int = 0) : void
      {
         var _loc10_:TPacket = null;
         var _loc11_:ByteArray = null;
         if(param9 == 0)
         {
            _loc10_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TopOrganization_GVG3_GetBetShow_Req);
            _loc11_ = _loc10_.Data;
            _loc11_.writeUnsignedInt(param2);
            _loc11_.writeUnsignedInt(param3);
            _loc11_.writeUnsignedInt(param4);
            _loc11_.writeUnsignedInt(param5);
            _loc11_.writeUnsignedInt(param6);
            _loc11_.writeUnsignedInt(param7);
         }
         else
         {
            _loc10_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TopOrganization_GVG3_Bet_Req);
            _loc11_ = _loc10_.Data;
            _loc11_.writeUnsignedInt(this.FTopOrganizationData.GroupType);
            _loc11_.writeUnsignedInt(param2);
            _loc11_.writeUnsignedInt(param3);
            _loc11_.writeUnsignedInt(param4);
            _loc11_.writeUnsignedInt(param5);
            _loc11_.writeUnsignedInt(param6);
            _loc11_.writeUnsignedInt(param7);
            if(param8 < 0)
            {
               param8 = 0;
            }
            _loc11_.writeUnsignedInt(param8);
            _loc11_.writeUnsignedInt(param9);
         }
         SNetworkCore.Transceiver.PacketTransmit(_loc10_);
         this.PacketPerform_CS_GVG3_GetBetState_Req(this.FTopOrganizationData.GroupType);
      }
      
      protected function ProcessorLookOnClick(param1:Object, param2:uint, param3:uint, param4:uint, param5:uint, param6:uint, param7:uint) : void
      {
         var _loc8_:TPacket = null;
         var _loc9_:ByteArray = null;
         _loc8_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TopOrganization_GVG3_GetReport_Req);
         _loc9_ = _loc8_.Data;
         _loc9_.writeUnsignedInt(param2);
         _loc9_.writeUnsignedInt(param3);
         _loc9_.writeUnsignedInt(param4);
         _loc9_.writeUnsignedInt(param5);
         _loc9_.writeUnsignedInt(param6);
         _loc9_.writeUnsignedInt(param7);
         SNetworkCore.Transceiver.PacketTransmit(_loc8_);
      }
      
      public function get OnEffectSign() : Function
      {
         return this.FOnEffectSign;
      }
      
      public function set OnEffectSign(param1:Function) : void
      {
         this.FOnEffectSign = param1;
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         var _loc2_:uint = 0;
         super.Mount(param1);
         if(!FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowTopOrganization.Load();
            this.FProcessorWindowJoinMember.Load();
            this.FProcessorWindowOrganizationJoin.Load();
            this.FProcessorWindowSeeReport.Load();
            this.FProcessorWindowOrganizationRanking.Load();
            this.FProcessorWindowGVG2Report.Load();
            this.FProcessorWindowFinalMatchList.Load();
            this.FProcessorWindowHistoryMatchList.Load();
            this.FProcessorWindowBet.Load();
            this.FProcessorWindowFinalBattleField.Load();
            return;
         }
         this.PacketPerform_CS_LoadMemberListReq();
         this.PacketPerform_CS_GetGuildApply_Req();
         this.PacketPerform_CS_IsSubmitBtlData_Req();
         this.PacketPerform_CS_IsNotifyReport_Req();
         this.FGVGFstEndingReportClearTimes = this.GetRepeatCount(this.FGVGFstEndingReportClearTime[0],this.FGVGFstEndingReportClearTime[1],this.FGVGFstEndingReportClearTime[2]);
         this.FGVGFstEnterTimes = this.GetRepeatCount(this.FGVGFstEnterTime[0],this.FGVGFstEnterTime[1],this.FGVGFstEnterTime[2]);
         this.FGVGFstReportStartTimes = this.GetRepeatCount(this.FGVGFstReportStartTime[0],this.FGVGFstReportStartTime[1],this.FGVGFstReportStartTime[2]);
         this.FGVGFirstEndingTimes = this.GetRepeatCount(this.FGVGFirstEndingTime[0],this.FGVGFirstEndingTime[1],this.FGVGFirstEndingTime[2]);
         this.FGVG2ndEnterTimes = this.GetRepeatCount(this.FGVG2ndEnterTime[0],this.FGVG2ndEnterTime[1],this.FGVG2ndEnterTime[2]);
         this.FGVG2ndStartTimes = this.GetRepeatCount(this.FGVG2ndStartTime[0],this.FGVG2ndStartTime[1],this.FGVG2ndStartTime[2]);
         this.FGVG2ndReportEndTimes = this.GetRepeatCount(this.FGVG2ndReportEndTime[0],this.FGVG2ndReportEndTime[1],this.FGVG2ndReportEndTime[2]);
         this.FGVG3ndTimeStarts = this.GetRepeatCount(this.FGVG3ndTimeStart[0],this.FGVG3ndTimeStart[1],this.FGVG3ndTimeStart[2]);
         this.FGVG3ndTimeEnds = this.GetRepeatCount(this.FGVG3ndTimeEnd[0],this.FGVG3ndTimeEnd[1],this.FGVG3ndTimeEnd[2]);
         this.TimeOnTimer(null);
         this.FTimer.start();
         _loc2_ = uint(STimingCore.GetServerTime());
         if(_loc2_ >= this.FGVGFirstEndingTimes)
         {
            this.PacketPerform_CS_GVG2_IsSubmitBtlData_Req();
            this.PacketPerform_CS_GVG2_GetApplyGuildInfo_Req();
         }
         if(_loc2_ >= this.FGVG2ndStartTimes)
         {
            this.PacketPerform_CS_GVG2_IsNotifyReport_Req();
         }
         if(_loc2_ >= this.FGVG2ndReportEndTimes)
         {
            this.PacketPerform_CS_GVG3_GetUserGuildInfo_Req();
         }
         this.FProcessorWindowTopOrganization.UpdateGVG3UI(0);
      }
      
      override public function Unmount() : void
      {
         this.FTimer.stop();
         this.FTimer.reset();
         super.Unmount();
      }
      
      public function SetOrgMemberListData(param1:Vector.<TBaseOrganizationMember>) : void
      {
         this.FProcessorWindowOrganizationJoin.SetOrgMemberListData(param1);
         this.FProcessorWindowTopOrganization.SetOrgMemberListData(param1);
         if(FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowTopOrganization.Update();
            this.FProcessorWindowTopOrganization.UpdateGVG2UI();
            this.FProcessorWindowTopOrganization.Visible = true;
         }
      }
      
      public function Test() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TGVG3Top32Org = null;
         var _loc4_:TGVG3BattleOrg = null;
         var _loc5_:TOrgMemberDigest = null;
         var _loc6_:TGVG3BetOrg = null;
         var _loc7_:TUserBetInfo = null;
         var _loc8_:TGVG2BattleReport = null;
         var _loc9_:int = 0;
         this.FTopOrganizationData.GVG3Top32Orgs.Clear();
         _loc2_ = 16;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = new TGVG3Top32Org();
            _loc3_.OrgID = 120 + _loc1_;
            _loc3_.OrgName = "傻逼" + _loc1_;
            _loc3_.InitPos = _loc1_;
            this.FTopOrganizationData.GVG3Top32Orgs.Add(_loc3_);
            _loc1_++;
         }
         _loc3_ = this.FTopOrganizationData.GVG3Top32Orgs.GetGVG3Top32OrgByIndex(0);
         _loc3_.LoseCircle = 4;
         _loc3_ = this.FTopOrganizationData.GVG3Top32Orgs.GetGVG3Top32OrgByIndex(1);
         _loc3_.LoseCircle = 1;
         _loc3_ = this.FTopOrganizationData.GVG3Top32Orgs.GetGVG3Top32OrgByIndex(2);
         _loc3_.LoseCircle = 1;
         _loc3_ = this.FTopOrganizationData.GVG3Top32Orgs.GetGVG3Top32OrgByIndex(3);
         _loc3_.LoseCircle = 2;
         _loc3_ = this.FTopOrganizationData.GVG3Top32Orgs.GetGVG3Top32OrgByIndex(4);
         _loc3_.LoseCircle = 2;
         _loc3_ = this.FTopOrganizationData.GVG3Top32Orgs.GetGVG3Top32OrgByIndex(5);
         _loc3_.LoseCircle = 1;
         _loc3_ = this.FTopOrganizationData.GVG3Top32Orgs.GetGVG3Top32OrgByIndex(6);
         _loc3_.LoseCircle = 3;
         _loc3_ = this.FTopOrganizationData.GVG3Top32Orgs.GetGVG3Top32OrgByIndex(7);
         _loc3_.LoseCircle = 1;
         _loc3_ = this.FTopOrganizationData.GVG3Top32Orgs.GetGVG3Top32OrgByIndex(8);
         _loc3_.LoseCircle = 1;
         _loc3_ = this.FTopOrganizationData.GVG3Top32Orgs.GetGVG3Top32OrgByIndex(9);
         _loc3_.LoseCircle = 2;
         _loc3_ = this.FTopOrganizationData.GVG3Top32Orgs.GetGVG3Top32OrgByIndex(10);
         _loc3_.LoseCircle = 1;
         _loc3_ = this.FTopOrganizationData.GVG3Top32Orgs.GetGVG3Top32OrgByIndex(11);
         _loc3_.LoseCircle = 0;
         _loc3_ = this.FTopOrganizationData.GVG3Top32Orgs.GetGVG3Top32OrgByIndex(12);
         _loc3_.LoseCircle = 3;
         _loc3_ = this.FTopOrganizationData.GVG3Top32Orgs.GetGVG3Top32OrgByIndex(13);
         _loc3_.LoseCircle = 1;
         _loc3_ = this.FTopOrganizationData.GVG3Top32Orgs.GetGVG3Top32OrgByIndex(14);
         _loc3_.LoseCircle = 2;
         _loc3_ = this.FTopOrganizationData.GVG3Top32Orgs.GetGVG3Top32OrgByIndex(15);
         _loc3_.LoseCircle = 1;
         this.FTopOrganizationData.CurrentBetAttOrgID = 130;
         this.FTopOrganizationData.CurrentBetDefOrgID = 132;
         this.FTopOrganizationData.CurrentBetCircle = 0;
         this.FTopOrganizationData.CurrentRound = 5;
         this.FProcessorWindowFinalMatchList.Update();
         this.FProcessorWindowFinalMatchList.Visible = true;
         this.FTopOrganizationData.GVG3BattleOrgs.Clear();
         _loc2_ = 2;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc4_ = new TGVG3BattleOrg();
            _loc4_.OrgID = 124 + _loc1_;
            _loc4_.OrgName = "傻逼" + _loc1_;
            _loc4_.OrgMemberCount = 30 + Math.random() * 20;
            _loc4_.ServerName = "新浪" + _loc1_;
            _loc4_.OrgMemberDigests.Clear();
            _loc9_ = 0;
            while(_loc9_ < 10)
            {
               _loc5_ = new TOrgMemberDigest(123 + _loc9_,(_loc1_ == 0 ? 456 : 789) + _loc9_);
               _loc5_.SortIndex = _loc9_;
               _loc5_.TemplateID = 11100000 + Math.random() * 6 + 1;
               _loc5_.Name = "二逼" + _loc9_;
               _loc5_.Level = 70 + Math.random() * 60;
               _loc5_.IsThreeWins = 0;
               _loc5_.IsDead = 0;
               _loc5_.LeftHP = 100;
               _loc4_.OrgMemberDigests.Add(_loc5_);
               _loc9_++;
            }
            this.FTopOrganizationData.GVG3BattleOrgs.Add(_loc4_);
            _loc1_++;
         }
         this.FTopOrganizationData.GVG3BattleReports.Clear();
         _loc2_ = 10;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc8_ = new TGVG2BattleReport();
            _loc8_.WinnerOrgID = 124;
            _loc8_.WinnerUserID0 = 123 + _loc1_;
            _loc8_.WinnerUserID1 = 456 + _loc1_;
            _loc8_.LeftHP = Math.random() * 100;
            _loc8_.LoserOrgID = 125;
            _loc8_.LoserUserID0 = 123 + _loc1_;
            _loc8_.LoserUserID1 = 789 + _loc1_;
            _loc8_.IsThreeWins = Math.random() * 2;
            this.FTopOrganizationData.GVG3BattleReports.Add(_loc8_);
            _loc1_++;
         }
         this.FTopOrganizationData.GVG3BetOrgs.Clear();
         _loc2_ = 2;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc6_ = new TGVG3BetOrg();
            _loc6_.OrgID = 123 + _loc1_;
            _loc6_.OrgLevel = 6 + _loc1_;
            _loc6_.OrgMembersCount = 30 + Math.random() * 20;
            _loc6_.TotalBetCount = 20000 + Math.random() * 50000;
            _loc6_.OrgName = "怂逼" + _loc1_;
            this.FTopOrganizationData.GVG3BetOrgs.Add(_loc6_);
            _loc1_++;
         }
         this.FTopOrganizationData.UserBetInfos.Clear();
         _loc2_ = 2;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc7_ = new TUserBetInfo();
            _loc7_.Round = 4 + _loc1_;
            _loc7_.AttackOrgID = 120 + _loc1_ * 2;
            _loc7_.DefendOrgID = 122 + _loc1_;
            _loc7_.BetOrgID = 124 + _loc1_;
            _loc7_.BetType = _loc1_ + 1;
            this.FTopOrganizationData.UserBetInfos.Add(_loc7_);
            _loc1_++;
         }
         this.FProcessorWindowTopOrganization.Visible = false;
      }
   }
}

