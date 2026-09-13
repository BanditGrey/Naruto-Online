package Processors.Game.Lobby.Organization
{
   import Foundation.Common.Integer.UInt64;
   import Foundation.Common.TBounds;
   import Foundation.Common.THint;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.DatebaseVO.VO.TKamiTree;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.Organization.TBaseOrganization;
   import Logics.Organization.TBaseOrganizationMember;
   import Logics.Organization.TBaseOrganiztionList;
   import Logics.Organization.TMuyeGuardRank;
   import Logics.Organization.TreasureTree.TBasicTreasureTree;
   import Logics.Organization.TreasureTree.TOperatingShowInfo;
   import Logics.Organization.TreasureTree.TOperatingShowInfos;
   import Logics.Organization.TreasureTree.TUserFruitInfo;
   import Logics.Organization.TreasureTree.TUserFruitInfos;
   import Logics.Organization.TreasureTree.TUserWaterInfo;
   import Logics.Organization.TreasureTree.TUserWaterInfos;
   import Logics.SLogicsCore;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Logics.Streamization.Organization.TUnstreamizerOrganization;
   import Processors.Game.Common.Effects.Texts.TEffectCoordinateParameters;
   import Processors.Game.Common.Effects.Texts.TEffectTextParameters;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import Rendering.Overlayers.HelpTips.TOverlayerHelpTips;
   import Rendering.Overlayers.Hints.TOverlayerHint;
   import Resources.Constants.CONST_CHAT;
   import Resources.Constants.CONST_CONFIGVALUE;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_ORGANIZATION;
   import Resources.Constants.CONST_ORGANIZATIONALWAR;
   import Resources.Constants.CONST_SHORTCUTS;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_ORGANIZATION;
   import Resources.Strings.STRING_ORGANIZATIONALWAR;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.utils.ByteArray;
   
   public class TProcessorOrganization extends TProcessorLobbyWindows
   {
      
      public static const SIZE_WindowOrganizationMain_Width:uint = 972;
      
      public static const SIZE_WindowOrganizationMain_Height:uint = 554;
      
      public static const SIZE_WindowOrganizationCamp_Width:uint = 688;
      
      public static const SIZE_WindowOrganizationCamp_Height:uint = 408;
      
      public static const SIZE_WindowOrgCreate_Width:uint = 310;
      
      public static const SIZE_WindowOrgCreate_Height:uint = 190;
      
      public static const SIZE_WindowOrgApplyAndPower_Width:uint = 618;
      
      public static const SIZE_WindowOrgApplyAndPower_Height:uint = 488;
      
      public static const SIZE_WindowOrgDonate_Width:uint = 330;
      
      public static const SIZE_WindowOrgDonate_Height:uint = 274;
      
      public static const SIZE_WindowOrgPower_Width:uint = 405;
      
      public static const SIZE_WindowOrgPower_Height:uint = 377;
      
      protected static const TYPE_ORGACTIVITY_CAMP:uint = CONST_ORGANIZATION.TYPE_ORGACTIVITY_CAMP;
      
      protected static const TYPE_ORGACTIVITY_MUYEGUARD:uint = CONST_ORGANIZATION.TYPE_ORGACTIVITY_MUYEGUARD;
      
      protected static const TYPE_ORGACTIVITY_PETBATTLE:uint = CONST_ORGANIZATION.TYPE_ORGACTIVITY_PETBATTLE;
      
      protected static const TYPE_ORGACTIVITY_MUYEBATTLE:uint = CONST_ORGANIZATION.TYPE_ORGACTIVITY_MUYEBATTLE;
      
      protected static const TYPE_ORGACTIVITY_TRAITORATTACK:uint = CONST_ORGANIZATION.TYPE_ORGACTIVITY_TRAITORATTACK;
      
      protected static const TYPE_ORGACTIVITY_AnimalSeal:uint = CONST_ORGANIZATION.TYPE_ORGACTIVITY_AnimalSeal;
      
      protected static const STATUS_ORGACTIVITY_NotOpen:uint = CONST_ORGANIZATION.STATUS_ORGACTIVITY_NotOpen;
      
      protected static const STATUS_ORGACTIVITY_SignUp:uint = CONST_ORGANIZATION.STATUS_ORGACTIVITY_SignUp;
      
      protected static const STATUS_ORGACTIVITY_Battle:uint = CONST_ORGANIZATION.STATUS_ORGACTIVITY_Battle;
      
      protected static const STATUS_ORGACTIVITY_End:uint = CONST_ORGANIZATION.STATUS_ORGACTIVITY_End;
      
      protected static const STATUS_ORGACTIVITY_Added:uint = CONST_ORGANIZATION.STATUS_ORGACTIVITY_Added;
      
      public static var See_Or_In:int = 0;
      
      protected var FBoundsOrganizationMain:TBounds;
      
      protected var FBoundsOrganizationActivity:TBounds;
      
      protected var FBoundsOrgCreate:TBounds;
      
      protected var FBoundsOrgApplyAndPower:TBounds;
      
      protected var FBoundsOrgDonate:TBounds;
      
      protected var FBoundsOrgPower:TBounds;
      
      protected var FProcessorWindowOrganizationMain:TProcessorWindowOrganizationMain;
      
      protected var FProcessorWindowOrganizationActivity:TProcessorWindowOrganizationActivity;
      
      protected var FProcessorWindowOrgCreate:TProcessorWindowOrgCreate;
      
      protected var FProcessorWindowOrgApplyAndPower:TProcessorWindowOrgApplyAndPower;
      
      protected var FProcessorWindowOrgDonate:TProcessorWindowOrgDonate;
      
      protected var FCallPetPanel:TProcessorWindowCallPet;
      
      protected var FProcessorWindowOrgPower:TProcessorWindowOrgPower;
      
      protected var FUnstreamizerOrg:TUnstreamizerOrganization;
      
      protected var FOrgListDataVect:Vector.<TBaseOrganiztionList>;
      
      protected var FOrgApplyListDataVect:Vector.<TBaseOrganizationMember>;
      
      protected var FOrgBaseData:TBaseOrganization;
      
      protected var FOrgMemberListDataVect:Vector.<TBaseOrganizationMember>;
      
      protected var FOrgCampDataVect:Vector.<Object>;
      
      protected var FOrgActivityStatus:Vector.<Object>;
      
      protected var FOrgLogVect:Vector.<Object>;
      
      protected var FOrgApplyListCount:uint;
      
      protected var FMuyeGuardRank:TMuyeGuardRank;
      
      protected var FOrgAdditionBin:TBins;
      
      protected var FOrgBaseBin:TBins;
      
      protected var FOrgDevotionBin:TBins;
      
      protected var FOrgInitWindows:Boolean;
      
      protected var FBAlreadyLoadOrgActivityStatus:Boolean;
      
      protected var FBOnSetOrganizationChannel:Boolean;
      
      protected var FBOnBtnOrgListClick:Boolean;
      
      protected var FWindowBtnStatus:Vector.<Object>;
      
      protected var FOrgDonateStatus:Boolean;
      
      protected var FOrgTreeStatus:Boolean;
      
      protected var FMuyeBattleOrgRankData:Vector.<TBaseOrganiztionList>;
      
      protected var FMuyeBattlePlayerRankData:Vector.<TBaseOrganizationMember>;
      
      protected var FseeIsClick:int = 0;
      
      protected var FTreeExps:Vector.<uint>;
      
      protected var FOnOrgActivityMuyeBattleSignUp:Function;
      
      protected var FOnShortcutHyperlinks:Function;
      
      protected var FSetDailyActivityStatus:Function;
      
      protected var FOnSetOrganizationName:Function;
      
      protected var FUpdateHerosPower:Function;
      
      protected var FOnSetOrganizationChannel:Function;
      
      protected var FOnOrgActivityMuyeGuardStartBattle:Function;
      
      protected var FOnOrgActivityMuyeBattleStartBattle:Function;
      
      protected var FOnShowHeroInfo:Function;
      
      protected var FOnChatWhisper:Function;
      
      protected var FOnInterpersonalRelationships:Function;
      
      protected var FSendGVGModule:Function;
      
      protected var FOnShortcutEffectNotification:Function;
      
      protected var FOnUserTotalFightingPowerReq:Function;
      
      protected var BossLevel:int;
      
      protected var CalledCount:int;
      
      protected var CurApplyCount:int;
      
      protected var BtnState:int;
      
      protected var ApplyState:int;
      
      public function TProcessorOrganization(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FProcessorWindowOrganizationMain = new TProcessorWindowOrganizationMain(this);
         this.FProcessorWindowOrganizationMain.OnClose = this.OnOrgClose;
         this.FProcessorWindowOrganizationMain.ClickMainPartOrgActivityOk = this.OnOrgActivityOkClick;
         this.FProcessorWindowOrganizationMain.ClickCreateOrg = this.OnProcessorWindowOrgCreateShow;
         this.FProcessorWindowOrganizationMain.ClickBtnDonate = this.OnProcessorWindowOrgDonate;
         this.FProcessorWindowOrganizationMain.ClickBtnOrgList = this.OnProcessorWindowOrgList;
         this.FProcessorWindowOrganizationMain.ClickBtnGotoPower = this.OnProcessorWindowOrgGotoPower;
         this.FProcessorWindowOrganizationMain.ClickBtnApplyList = this.OnProcessorWindowOrgApplyList;
         this.FProcessorWindowOrganizationMain.ClickBtnSwitchPowerList = this.OnProcessorWindowOrgSwitchPower;
         this.FProcessorWindowOrganizationMain.ClickBtnQuitOrg = this.OnBtnQuitClick;
         this.FProcessorWindowOrganizationMain.OverAward = this.OnHintOver;
         this.FProcessorWindowOrganizationMain.OutAward = this.OnHintOut;
         this.FProcessorWindowOrganizationMain.OnEffectText = this.ShowEffectText;
         this.FProcessorWindowOrganizationMain.OnShowHeroInfo = this.ProcessorOnShowHeroInfo;
         this.FProcessorWindowOrganizationMain.OnChatWhisper = this.ProcessorOnChatWhisper;
         this.FProcessorWindowOrganizationMain.OnInterpersonalRelationships = this.ProcessorOnInterpersonalRelationships;
         this.FProcessorWindowOrganizationMain.OverHintUpgradeBtn = this.OnHintOver;
         this.FProcessorWindowOrganizationMain.OutHintUpgradeBtn = this.OnHintOut;
         this.FProcessorWindowOrganizationMain.HelpHintOnOver = this.UIHelpHintOnOver;
         this.FProcessorWindowOrganizationMain.HelpHintOnOut = this.UIHelpHintOnOut;
         this.FProcessorWindowOrganizationMain.UpdateBaseOrganization = this.OrganizationMain;
         this.FProcessorWindowOrganizationMain.OnUserFruitFastMature = this.ProcessorOnUserFruitFastMature;
         this.FProcessorWindowOrganizationMain.PickFruitOnClick = this.ProcessorPickFruitOnClick;
         this.FProcessorWindowOrganizationMain.WaterOrgMemberOnClick = this.ProcessorWaterOrgMemberOnClick;
         this.FProcessorWindowOrganizationMain.KeyWatersClisk = this.KeyWatersClisk;
         this.FProcessorWindowOrganizationMain.PushChakraOnClick = this.ProcessorPushChakraOnClick;
         this.FProcessorWindowOrganizationMain.AddChakraTimesOnClick = this.ProcessorAddChakraTimesOnClick;
         this.FProcessorWindowOrganizationMain.FastOnClick = this.ProcessorFastOnClick;
         this.FProcessorWindowOrganizationActivity = new TProcessorWindowOrganizationActivity(this);
         this.FProcessorWindowOrganizationActivity.OnClose = this.OnProcessorWindowOrgActivityClose;
         this.FProcessorWindowOrganizationActivity.OnBtnDonateClick = this.OnProcessorWinowOrgDonateFromOrgActivity;
         this.FProcessorWindowOrganizationActivity.OnEffectText = this.ShowEffectText;
         this.FProcessorWindowOrganizationActivity.OnHintMove = this.OnHintOver;
         this.FProcessorWindowOrganizationActivity.OnHintOut = this.OnHintOut;
         this.FProcessorWindowOrganizationActivity.EffectGenerateTextByError = EffectGenerateTextByErrorCode;
         this.FProcessorWindowOrganizationActivity.SetRoot = this.setRoot;
         this.FProcessorWindowOrganizationActivity.CloseCallPanelFatherin = this.CloseCallPanelFatherin;
         this.FProcessorWindowOrgCreate = new TProcessorWindowOrgCreate(this);
         this.FProcessorWindowOrgCreate.OnClose = this.OnProcessorWindowOrgCreateClose;
         this.FProcessorWindowOrgCreate.OnEffectText = this.ShowEffectText;
         this.FProcessorWindowOrgApplyAndPower = new TProcessorWindowOrgApplyAndPower(this);
         this.FProcessorWindowOrgApplyAndPower.OnClose = this.OnProcessorWindowOrgApplyListAndPowerClose;
         this.FProcessorWindowOrgApplyAndPower.OnApplyListCount = this.OnChangeApplyListCount;
         this.FProcessorWindowOrgDonate = new TProcessorWindowOrgDonate(this);
         this.FProcessorWindowOrgDonate.OnClose = this.OnProcessorWindowOrgDonateClose;
         this.FProcessorWindowOrgDonate.OnEffectText = this.ShowEffectText;
         this.FProcessorWindowOrgDonate.SetOrgDonateStatus = this.SetOrgDonateStatus;
         this.FCallPetPanel = new TProcessorWindowCallPet(this);
         this.FCallPetPanel.SureBtn = this.PopWindowOnOk;
         this.FProcessorWindowOrgPower = new TProcessorWindowOrgPower(this);
         this.FProcessorWindowOrgPower.OnClose = this.OnProcessorWindowOrgGotoPowerClose;
         this.FBoundsOrganizationMain = new TBounds();
         this.FBoundsOrganizationMain.Width = SIZE_WindowOrganizationMain_Width;
         this.FBoundsOrganizationMain.Height = SIZE_WindowOrganizationMain_Height;
         ComponentBoundsCenter(this.FProcessorWindowOrganizationMain,this.FBoundsOrganizationMain);
         this.FBoundsOrganizationActivity = new TBounds();
         this.FBoundsOrganizationActivity.Width = SIZE_WindowOrganizationCamp_Width;
         this.FBoundsOrganizationActivity.Height = SIZE_WindowOrganizationCamp_Height;
         ComponentBoundsCenter(this.FProcessorWindowOrganizationActivity,this.FBoundsOrganizationActivity);
         this.FBoundsOrgCreate = new TBounds();
         this.FBoundsOrgCreate.Width = SIZE_WindowOrgCreate_Width;
         this.FBoundsOrgCreate.Height = SIZE_WindowOrgCreate_Height;
         ComponentBoundsCenter(this.FProcessorWindowOrgCreate,this.FBoundsOrgCreate);
         this.FBoundsOrgApplyAndPower = new TBounds();
         this.FBoundsOrgApplyAndPower.Width = SIZE_WindowOrgApplyAndPower_Width;
         this.FBoundsOrgApplyAndPower.Height = SIZE_WindowOrgApplyAndPower_Height;
         ComponentBoundsCenter(this.FProcessorWindowOrgApplyAndPower,this.FBoundsOrgApplyAndPower);
         this.FBoundsOrgDonate = new TBounds();
         this.FBoundsOrgDonate.Width = SIZE_WindowOrgDonate_Width;
         this.FBoundsOrgDonate.Height = SIZE_WindowOrgDonate_Height;
         ComponentBoundsCenter(this.FProcessorWindowOrgDonate,this.FBoundsOrgDonate);
         this.FBoundsOrgPower = new TBounds();
         this.FBoundsOrgPower.Width = SIZE_WindowOrgPower_Width;
         this.FBoundsOrgPower.Height = SIZE_WindowOrgPower_Height;
         ComponentBoundsCenter(this.FProcessorWindowOrgPower,this.FBoundsOrgPower);
         this.FUnstreamizerOrg = new TUnstreamizerOrganization();
         this.FOrgApplyListDataVect = new Vector.<TBaseOrganizationMember>();
         this.FOrgBaseData = SLogicsCore.Organization;
         this.FOrgListDataVect = new Vector.<TBaseOrganiztionList>();
         this.FOrgMemberListDataVect = new Vector.<TBaseOrganizationMember>();
         this.FOrgCampDataVect = new Vector.<Object>();
         this.FOrgActivityStatus = new Vector.<Object>();
         this.FOrgLogVect = new Vector.<Object>();
         this.FMuyeGuardRank = new TMuyeGuardRank();
         this.FOrgInitWindows = false;
         this.FBAlreadyLoadOrgActivityStatus = false;
         this.FBOnBtnOrgListClick = false;
         this.FBOnSetOrganizationChannel = false;
         this.FWindowBtnStatus = Vector.<Object>([{"windowOrgDonate":0},{"windowOrgList":0},{"windowOrgLookPower":0},{"windowOrgApplyList":0},{"windowOrgSwitchPower":0},{"tabOrgCamp":0},{"tabOrgMemberList":0},{"tabOrgLog":0},{"tabOrgBag":0},{"activityOrgCamp":0},{"activityOrgMuyeBattleRank":0},{"activityOrgMuyeGuardRank":0}]);
         SetUIModuleID(CONST_MODULES.MODULE_Organization);
      }
      
      public function FCloseThiseByOthers() : void
      {
         this.FProcessorWindowOrganizationMain.FCloseThiseByOthers();
      }
      
      protected function setRoot(param1:TUIComponent) : void
      {
         this.FCallPetPanel.visible = true;
      }
      
      protected function CloseCallPanelFatherin() : void
      {
         this.FCallPetPanel.visible = false;
      }
      
      protected function PopWindowOnOk() : void
      {
         this.FProcessorWindowOrganizationActivity.PopWindowOnOk();
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_ORGANIZATION.RESOURCESID_Swf_OrganizationMain);
         super.ResourcesPerform_UIRequest();
      }
      
      public function PACKETID_SC_AnimalSeall_Open_Ret(param1:TPacket) : void
      {
         this.FProcessorWindowOrganizationActivity.PACKETID_SC_AnimalSeall_Open_Ret(param1);
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         FOverlayerHint = new TOverlayerHint(this);
         FOverlayerHint.visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerHint);
         FOverlayerHelpTips = new TOverlayerHelpTips(this);
         FOverlayerHelpTips.Visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerHelpTips);
         this.FMuyeBattleOrgRankData = new Vector.<TBaseOrganiztionList>();
         this.FMuyeBattlePlayerRankData = new Vector.<TBaseOrganizationMember>();
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         var _loc1_:TConfigValue = null;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.KAMITREE_EXP) as TConfigValue;
         this.FTreeExps = _loc1_.Value as Vector.<uint>;
         super.ResourcesPerform_UILocations();
      }
      
      override protected function ResourcesPerform_UIFinalize() : void
      {
         this.FOrgAdditionBin = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_OrganizationAddition);
         this.FOrgBaseBin = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_OrganizationBase);
         this.FOrgDevotionBin = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_OrganizationDevotion);
         super.ResourcesPerform_UIFinalize();
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Organization_LoadGulidListRet,this.PerformPacket_SC_Organization_LoadGulidListRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Organization_CreateGulidRet,this.PerformPacket_SC_Organization_CreateGulidRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Organization_ApplyJoinGulidRet,this.PerformPacket_SC_Organization_ApplyJoinGulidRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Organization_UpGradeRet,this.PerformPacket_SC_Organization_UpGradeRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Organization_LoadApplyListRet,this.PerformPacket_SC_Organization_LoadApplyListRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Organization_UpGradeGuildTechRet,this.PerformPacket_SC_Organization_UpGradeGuildTechRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Organization_LoadMemberListRet,this.PerformPacket_SC_Organization_LoadMemberListRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Organization_GetGulidInfoRet,this.PerformPacket_SC_Organization_GetGulidInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Organization_GetCampRet,this.PerformPacket_SC_Organization_GetCampRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Organization_SwitchPowerRet,this.PerformPacket_SC_Organization_SwitchPowerRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Organization_MuyeBattleRet,this.PerformPacket_SC_Organization_MuyeBattleRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Organization_ConfirmApplyJoinGuildRet,this.PerformPacket_SC_Organization_ConfirmApplyJoinGuildRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Organization_LoadGulidDepotRet,this.PerformPacket_SC_Organization_LoadGulidDepotRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Organization_AssignGulidDepotRet,this.PerformPacket_SC_Organization_AssignGulidDepotRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Organization_DonateRet,this.PerformPacket_SC_Organization_DonateRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Organization_QuitGuildRet,this.PerformPacket_SC_Organization_QuitGuildRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Organization_DismissGuildRet,this.PerformPacket_SC_Organization_DismissGuildRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Organization_ActivityStatusRet,this.PerformPacket_SC_Organization_ActivityStatusRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Organization_BoardModifyRet,this.PerformPacket_SC_Organization_BoardModifyRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Organization_GuildLogRet,this.PerformPacket_SC_Organization_GuildLogRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Organization_ChangeActivityRet,this.PerformPacket_SC_Organization_ChangeActivityStatusRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Organization_KickMemberRet,this.PerformPacket_SC_Organization_KickMemberRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Organization_CityDefendInfoRet,this.PerformPacket_SC_Organization_CityDefendInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Organization_PickUserFruitRet,this.PerformPacket_SC_Organization_PickUserFruitRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Organization_WateringUserFruitRet,this.PerformPacket_SC_Organization_WateringUserFruitRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Organization_RipeningUserFruitRet,this.PerformPacket_SC_Organization_RipeningUserFruitRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Organization_PickGuildFruitRet,this.PerformPacket_SC_Organization_PickGuildFruitRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Organization_WateringGuildFruitRet,this.PerformPacket_SC_Organization_WateringGuildFruitRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Organization_EvolvingUserFruitRet,this.PerformPacket_SC_Organization_EvolvingUserFruitRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Organization_ShowRet,this.PerformPacket_SC_Organization_ShowRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Organization_AddExpRet,this.PerformPacket_SC_Organization_AddExpRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Organization_NotifyUserRipeRet,this.PerformPacket_SC_Organization_NotifyUserRipeRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Organization_NotifyUserEvolvRet,this.PerformPacket_SC_Organization_NotifyUserEvolvRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Organization_BuyAddExpCntRet,this.PerformPacket_SC_Organization_BuyAddExpCntRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Organization_ReduceAddExpCDRet,this.PerformPacket_SC_Organization_ReduceAddExpCDRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Organization_IsNewRet,this.PerformPacket_SC_Organization_IsNewRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Organization_NotifyTreeInfoRet,this.PerformPacket_SC_Organization_NotifyTreeInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Organization_NotifyGuildFruit_Ret,this.PerformPacket_SC_Organization_NotifyGuildFruit_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Organization_AutoWatering_User_Fruit_Ret,this.PACKETID_SC_Organization_AutoWatering_User_Fruit_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Organization_NewApplyListRet,this.PACKETID_SC_Organization_NewApplyList_Ret);
         super.PacketRegisterRoutines();
      }
      
      override protected function LogicsPerform() : void
      {
         this.FCallPetPanel.updateUI();
         super.LogicsPerform();
      }
      
      protected function PerformPacket_SC_Organization_LoadGulidListRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         _loc2_ = param1.Data;
         this.FUnstreamizerOrg.UnstreamizeOrganizationList(_loc2_,this.FOrgListDataVect,null);
         if(this.FOrgInitWindows)
         {
            if(this.FBOnBtnOrgListClick)
            {
               this.FProcessorWindowOrganizationMain.UpDataPartData(this.FOrgBaseData,this.FOrgListDataVect,this.FOrgApplyListCount,false);
            }
            else
            {
               this.FProcessorWindowOrganizationMain.UpDataPartData(this.FOrgBaseData,this.FOrgListDataVect,this.FOrgApplyListCount);
            }
         }
      }
      
      protected function PerformPacket_SC_Organization_CreateGulidRet(param1:TPacket) : void
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
         this.FProcessorWindowOrgCreate.Visible = false;
         this.PerformPacket_CS_UpdateOrgBaseInfoReq();
         this.FProcessorWindowOrganizationMain.Visible = true;
         EffectGenerateText(STRING_ORGANIZATION.STRING_CreateOrgSucceed);
         this.FOrgDonateStatus = true;
         this.CheckOrganizationIconEffect();
      }
      
      protected function PerformPacket_SC_Organization_ApplyJoinGulidRet(param1:TPacket) : void
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
         _loc4_ = _loc2_.readUnsignedInt();
         EffectGenerateText(STRING_ORGANIZATION.STRING_ApplyOrgSucceed);
      }
      
      protected function PerformPacket_SC_Organization_UpGradeRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc5_ = _loc2_.readUnsignedInt();
         _loc4_ = _loc2_.readUnsignedInt();
         _loc7_ = _loc2_.readUnsignedInt();
         this.FOrgBaseData.SetOrgActivityLevel(_loc4_,_loc5_);
         this.FOrgBaseData.OrgMoney = _loc7_;
         if(_loc4_ == 1)
         {
            this.FOrgBaseData.OrgLevel = _loc5_;
            this.PerformPacket_CS_UpdateOrgBaseInfoReq();
         }
         this.FProcessorWindowOrganizationMain.UpDataUI_OrgPart(this.FOrgBaseData,this.FOrgApplyListCount);
         this.FProcessorWindowOrganizationMain.UpDateUI_OrgActivityUpgrade(_loc4_);
         this.FProcessorWindowOrganizationMain.UpDateUI_OrgCamp();
         EffectGenerateText(STRING_ORGANIZATION.STRING_UpgradeSucceed);
      }
      
      protected function PerformPacket_SC_Organization_LoadApplyListRet(param1:TPacket) : void
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
         this.FUnstreamizerOrg.UnstreamizeOrganizationApplyAndSwitchList(_loc2_,this.FOrgApplyListDataVect,null);
         this.FProcessorWindowOrgApplyAndPower.UpDateList(this.FOrgBaseData,this.FOrgApplyListDataVect,1);
      }
      
      protected function PACKETID_SC_Organization_NewApplyList_Ret(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         _loc2_ = param1.Data;
         this.FOrgApplyListCount = _loc2_.readInt();
         if(this.FOrgBaseData.OrgId > 0 && this.FOrgInitWindows)
         {
            this.FProcessorWindowOrganizationMain.UpDataUI_OrgPart(this.FOrgBaseData,this.FOrgApplyListCount);
         }
      }
      
      protected function PerformPacket_SC_Organization_UpGradeGuildTechRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc6_ = _loc2_.readUnsignedInt();
         _loc7_ = _loc2_.readUnsignedInt();
         _loc8_ = _loc2_.readUnsignedInt();
         this.FOrgBaseData.OrgExploit.High = _loc8_;
         _loc8_ = _loc2_.readUnsignedInt();
         this.FOrgBaseData.OrgExploit.Low = _loc8_;
         _loc5_ = int(this.FOrgBaseData.OrgAddition.length);
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            if(_loc6_ == this.FOrgBaseData.OrgAddition[_loc4_].type)
            {
               this.FOrgBaseData.OrgAddition[_loc4_].level = _loc7_;
               break;
            }
            _loc4_++;
         }
         this.FProcessorWindowOrganizationActivity.UpData_Technology(this.FOrgBaseData.OrgAddition,this.FOrgBaseData.OrgExploit.ToNumber());
         this.FProcessorWindowOrganizationActivity.UpDateUI_Technology();
         this.FProcessorWindowOrganizationActivity.ShowEffectGenerateText(STRING_ORGANIZATION.STRING_UpgradeSucceed);
         if(this.FUpdateHerosPower != null)
         {
            this.FUpdateHerosPower(this);
         }
         this.FProcessorWindowOrganizationMain.UpDataUI_OrgPart(this.FOrgBaseData,this.FOrgApplyListCount);
         if(this.FOnUserTotalFightingPowerReq != null)
         {
            this.FOnUserTotalFightingPowerReq(this);
         }
      }
      
      protected function PerformPacket_SC_Organization_LoadMemberListRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:Vector.<TBaseOrganizationMember> = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc4_ = new Vector.<TBaseOrganizationMember>();
         this.FUnstreamizerOrg.UnstreamizeOrganizationMembers(_loc2_,_loc4_,null);
         this.FOrgMemberListDataVect = _loc4_;
         if(FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowOrganizationMain.UpData_OrgMember(this.FOrgMemberListDataVect);
            if(this.FOrgMemberListDataVect.length > 0)
            {
               this.FProcessorWindowOrganizationMain.UpDateUI_OrgMember();
               this.FProcessorWindowOrganizationMain.UpDateUI_OrgMemberCount(this.FOrgMemberListDataVect.length);
            }
         }
         if(this.FSendGVGModule != null)
         {
            this.FSendGVGModule(this,this.FOrgMemberListDataVect);
         }
      }
      
      protected function PerformPacket_SC_Organization_GetGulidInfoRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         _loc2_ = param1.Data;
         this.FUnstreamizerOrg.Unstreamize(_loc2_,this.FOrgBaseData,this.FOrgBaseBin);
         if(this.FOrgBaseData.OrgId > 0)
         {
            if(this.FOrgCampDataVect.length <= 0)
            {
               this.PerformPacket_CS_GetCampReq();
            }
         }
         if(!this.FBAlreadyLoadOrgActivityStatus)
         {
            this.PerformPacket_CS_ActivityStatusReq();
         }
         if(this.FOnSetOrganizationName != null)
         {
            if(this.FOrgBaseData.OrgId > 0)
            {
               this.FOnSetOrganizationName(this,this.FOrgBaseData.OrgName);
            }
            else
            {
               this.FOnSetOrganizationName(this,STRING_ORGANIZATION.STRING_NoAddOrg);
            }
         }
         if(this.FOnSetOrganizationChannel != null)
         {
            if(this.FOrgBaseData.OrgId > 0)
            {
               this.FOnSetOrganizationChannel(this,CONST_CHAT.CHANNEL_TYPE_Organization,true);
            }
            else
            {
               this.FOnSetOrganizationChannel(this,CONST_CHAT.CHANNEL_TYPE_Organization,false);
            }
         }
         if(this.FOrgInitWindows)
         {
            if(this.FOrgBaseData.OrgId > 0)
            {
               this.FProcessorWindowOrganizationMain.UpDataPartData(this.FOrgBaseData,this.FOrgListDataVect,this.FOrgApplyListCount);
               if(this.FOrgMemberListDataVect.length <= 0)
               {
                  this.PerformPacket_CS_LoadOrgMembersReq();
               }
            }
            else
            {
               this.PerformPacket_CS_LoadOrgListReq();
            }
         }
         if(this.FOrgBaseData.OrgLevel >= 5)
         {
            if(!this.FProcessorWindowOrganizationMain.Visible)
            {
               TutorialNextStep(2400);
            }
            else
            {
               TutorialNextStep(1809);
            }
         }
      }
      
      protected function PerformPacket_SC_Organization_GetCampRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:Object = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc5_ = _loc2_.readShort();
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc4_ = {
               "type":0,
               "level":0
            };
            _loc4_.type = _loc2_.readUnsignedInt();
            _loc4_.level = _loc2_.readUnsignedInt();
            this.FOrgCampDataVect[_loc6_] = _loc4_;
            _loc6_++;
         }
         this.FOrgBaseData.OrgCampData = this.FOrgCampDataVect;
         if(this.FOrgBaseData.OrgId > 0 && this.FOrgInitWindows)
         {
            this.FProcessorWindowOrganizationMain.UpDataUI_OrgPart(this.FOrgBaseData,this.FOrgApplyListCount);
            this.FProcessorWindowOrganizationMain.UpDateUI_OrgCamp();
         }
      }
      
      protected function PerformPacket_SC_Organization_SwitchPowerRet(param1:TPacket) : void
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
         this.FProcessorWindowOrgApplyAndPower.Visible = false;
         this.FProcessorWindowOrganizationMain.Visible = true;
         this.PerformPacket_CS_UpdateOrgBaseInfoReq();
         this.PerformPacket_CS_LoadOrgMembersReq();
         EffectGenerateText(STRING_ORGANIZATION.STRING_SwatchPowerSucceed);
      }
      
      protected function PerformPacket_SC_Organization_MuyeBattleRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = param1.Data;
         this.FMuyeBattleOrgRankData.length = 0;
         this.FMuyeBattlePlayerRankData.length = 0;
         this.FUnstreamizerOrg.UnstreamizeMuyeBattleRank(_loc2_,this.FMuyeBattleOrgRankData,this.FMuyeBattlePlayerRankData);
         this.FProcessorWindowOrganizationActivity.UpdateUI_MuyeBattleRank(this.FMuyeBattleOrgRankData,this.FMuyeBattlePlayerRankData);
      }
      
      protected function PerformPacket_SC_Organization_ConfirmApplyJoinGuildRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:Vector.<TBaseOrganizationMember> = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc8_ = new Vector.<TBaseOrganizationMember>();
         _loc6_ = _loc2_.readShort();
         _loc7_ = 0;
         while(_loc7_ < _loc6_)
         {
            _loc4_ = _loc2_.readUnsignedInt();
            _loc5_ = _loc2_.readUnsignedInt();
            this.SpliceApplyListHandler(_loc4_,_loc5_);
            _loc7_++;
         }
         this.FProcessorWindowOrgApplyAndPower.UpDateList(this.FOrgBaseData,this.FOrgApplyListDataVect,1);
         this.PerformPacket_CS_UpdateOrgBaseInfoReq();
         this.PerformPacket_CS_LoadOrgMembersReq();
      }
      
      protected function SpliceApplyListHandler(param1:uint, param2:uint) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _loc4_ = int(this.FOrgApplyListDataVect.length);
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            if(param1 == this.FOrgApplyListDataVect[_loc3_].Identifier0 && param2 == this.FOrgApplyListDataVect[_loc3_].Identifier1)
            {
               this.FOrgApplyListDataVect.splice(_loc3_,1);
               break;
            }
            _loc3_++;
         }
      }
      
      protected function PerformPacket_SC_Organization_LoadGulidDepotRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:Vector.<uint> = null;
         var _loc7_:Vector.<uint> = null;
         var _loc8_:TInventory = null;
         var _loc9_:TInventories = null;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:UInt64 = null;
         var _loc13_:TUnstreamizerInventoryReference = null;
         var _loc14_:Vector.<UInt64> = null;
         var _loc15_:uint = 0;
         var _loc16_:uint = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc13_ = new TUnstreamizerInventoryReference();
         _loc5_ = _loc2_.readShort();
         _loc9_ = new TInventories();
         _loc6_ = new Vector.<uint>(_loc5_);
         _loc7_ = new Vector.<uint>(_loc5_);
         _loc14_ = new Vector.<UInt64>(_loc5_);
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc15_ = _loc2_.readUnsignedInt();
            _loc16_ = _loc2_.readUnsignedInt();
            _loc12_ = new UInt64(_loc16_,_loc15_);
            _loc14_[_loc4_] = _loc12_;
            _loc6_[_loc4_] = _loc2_.readUnsignedInt();
            _loc7_[_loc4_] = _loc2_.readUnsignedInt();
            _loc4_++;
         }
         _loc9_.Clear();
         _loc13_.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc9_,_loc6_);
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc8_ = _loc9_.GetInventoryByIndex(_loc4_);
            _loc8_.Quantity = _loc7_[_loc4_];
            _loc4_++;
         }
         this.FProcessorWindowOrganizationMain.UpData_OrgBag(_loc9_,_loc14_,this.FOrgMemberListDataVect,this.FOrgBaseData);
      }
      
      protected function PerformPacket_SC_Organization_AssignGulidDepotRet(param1:TPacket) : void
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
         this.PerformPacket_CS_LoadGulidDepotReq();
         EffectGenerateText(STRING_ORGANIZATION.STRING_GiveOrgAwardSucceed);
      }
      
      protected function PerformPacket_SC_Organization_DonateRet(param1:TPacket) : void
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
         if(this.FOrgBaseData.OrgId > 0)
         {
            this.FOrgBaseData.OrgContribution = _loc2_.readUnsignedInt();
            this.FOrgBaseData.OrgExploit.High = _loc2_.readUnsignedInt();
            this.FOrgBaseData.OrgExploit.Low = _loc2_.readUnsignedInt();
            this.FOrgBaseData.OrgMoney = _loc2_.readUnsignedInt();
         }
         this.FProcessorWindowOrgDonate.UpData(this.FOrgBaseData.OrgExploit.ToNumber(),this.FOrgBaseData.OrgMoney);
         this.FProcessorWindowOrgDonate.UpDateUI();
         EffectGenerateText(STRING_ORGANIZATION.STRING_DonateOrgSucceed);
      }
      
      protected function PerformPacket_SC_Organization_QuitGuildRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:TBaseOrganization = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc4_ = _loc2_.readUnsignedInt();
         if(this.FOrgInitWindows)
         {
            this.OnOrgClose(this);
         }
         _loc5_ = new TBaseOrganization();
         SLogicsCore.Organization = _loc5_;
         EffectGenerateText(STRING_ORGANIZATION.STRING_ExitOrgSucceed);
         this.CleanAllData();
         if(this.FOnSetOrganizationChannel != null)
         {
            this.FOnSetOrganizationChannel(this,CONST_CHAT.CHANNEL_TYPE_Organization,false);
         }
         if(this.FOnSetOrganizationName != null)
         {
            this.FOnSetOrganizationName(this,STRING_ORGANIZATION.STRING_NoAddOrg);
         }
      }
      
      protected function PerformPacket_SC_Organization_DismissGuildRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:TBaseOrganization = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         this.OnOrgClose(this);
         _loc4_ = new TBaseOrganization();
         SLogicsCore.Organization = _loc4_;
         EffectGenerateText(STRING_ORGANIZATION.STRING_DismissOrgSucceed);
         this.CleanAllData();
         if(this.FOnSetOrganizationChannel != null)
         {
            this.FOnSetOrganizationChannel(this,CONST_CHAT.CHANNEL_TYPE_Organization,false);
         }
         if(this.FOnSetOrganizationName != null)
         {
            this.FOnSetOrganizationName(this,STRING_ORGANIZATION.STRING_NoAddOrg);
         }
      }
      
      protected function PerformPacket_SC_Organization_ActivityStatusRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Object = null;
         var _loc6_:uint = 0;
         var _loc7_:Vector.<Object> = null;
         _loc2_ = param1.Data;
         _loc4_ = 7;
         _loc7_ = new Vector.<Object>();
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc6_ = uint(_loc2_.readByte());
            _loc5_ = {
               "type":0,
               "status":0
            };
            if(_loc3_ == 0)
            {
               _loc5_.type = TYPE_ORGACTIVITY_MUYEGUARD;
            }
            else if(_loc3_ == 1)
            {
               _loc5_.type = TYPE_ORGACTIVITY_MUYEBATTLE;
            }
            else if(_loc3_ == 5)
            {
               _loc5_.type = TYPE_ORGACTIVITY_TRAITORATTACK;
            }
            else if(_loc3_ == 6)
            {
               _loc5_.type = TYPE_ORGACTIVITY_AnimalSeal;
            }
            else
            {
               _loc5_.type = _loc3_ + TYPE_ORGACTIVITY_PETBATTLE;
            }
            _loc5_.status = _loc6_;
            _loc7_.push(_loc5_);
            _loc3_++;
         }
         this.FOrgActivityStatus = _loc7_;
         this.FOrgBaseData.OrgActivityStatus = _loc7_;
         SLogicsCore.Organization.OrgActivityStatus = this.FOrgActivityStatus;
         if(this.FSetDailyActivityStatus != null)
         {
            _loc3_ = 0;
            while(_loc3_ < this.FOrgActivityStatus.length)
            {
               this.FSetDailyActivityStatus(this,this.FOrgActivityStatus[_loc3_].type,this.FOrgActivityStatus[_loc3_].status);
               if(this.FOrgActivityStatus[_loc3_].type == TYPE_ORGACTIVITY_MUYEBATTLE && this.FOrgActivityStatus[_loc3_].status == STATUS_ORGACTIVITY_SignUp)
               {
                  if(this.FOnOrgActivityMuyeBattleSignUp != null)
                  {
                     this.FOnOrgActivityMuyeBattleSignUp(this,CONST_ORGANIZATIONALWAR.CommandID_SignUpInfor,0,this.SignUpCallBack);
                  }
               }
               _loc3_++;
            }
         }
         this.FBAlreadyLoadOrgActivityStatus = true;
      }
      
      protected function PerformPacket_SC_Organization_BoardModifyRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:String = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc4_ = TUtilityString.FetchUTF(_loc2_);
         this.FOrgBaseData.OrgNotice = _loc4_;
         this.FProcessorWindowOrganizationMain.UpDataUI_OrgPart(this.FOrgBaseData,this.FOrgApplyListCount);
         EffectGenerateText(STRING_ORGANIZATION.STRING_AdjustNoticeSucceed);
      }
      
      protected function PerformPacket_SC_Organization_GuildLogRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:Object = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc5_ = _loc2_.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc6_ = {
               "subject":"",
               "verbType":0,
               "object":"",
               "time":0
            };
            _loc6_.subject = TUtilityString.FetchUTF(_loc2_);
            _loc6_.verbType = _loc2_.readUnsignedInt();
            _loc6_.object = TUtilityString.FetchUTF(_loc2_);
            _loc6_.time = _loc2_.readUnsignedInt();
            this.FOrgLogVect[_loc4_] = _loc6_;
            _loc4_++;
         }
         this.FProcessorWindowOrganizationMain.UpDateUI_OrgLog(this.FOrgLogVect);
      }
      
      protected function PerformPacket_SC_Organization_ChangeActivityStatusRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:Object = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:Vector.<Object> = null;
         _loc2_ = param1.Data;
         _loc3_ = {
            "type":0,
            "status":0
         };
         _loc3_.type = _loc2_.readByte();
         _loc3_.status = _loc2_.readByte();
         _loc6_ = SLogicsCore.Organization.OrgActivityStatus;
         if(_loc6_ == null)
         {
            return;
         }
         _loc4_ = 0;
         while(_loc4_ < _loc6_.length)
         {
            if(_loc6_[_loc4_].type == _loc3_.type)
            {
               _loc6_[_loc4_].status = _loc3_.status;
               break;
            }
            _loc4_++;
         }
         SLogicsCore.Organization.OrgActivityStatus = _loc6_;
         if(this.FOrgInitWindows)
         {
            this.FProcessorWindowOrganizationMain.UpDataUI_OrgActivityBtnStatus(_loc3_.type,_loc3_.status);
         }
         if(this.FSetDailyActivityStatus != null)
         {
            this.FSetDailyActivityStatus(this,_loc3_.type,_loc3_.status);
         }
      }
      
      protected function PerformPacket_SC_Organization_KickMemberRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:TMuyeGuardRank = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         this.PerformPacket_CS_UpdateOrgBaseInfoReq();
         this.PerformPacket_CS_LoadOrgMembersReq();
      }
      
      protected function PerformPacket_SC_Organization_CityDefendInfoRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = param1.Data;
         this.FUnstreamizerOrg.UnstreamizeMuyeGuardRank(_loc2_,this.FMuyeGuardRank,null);
         this.FProcessorWindowOrganizationActivity.UpDataUI_MuyeGuardRank(this.FMuyeGuardRank);
      }
      
      protected function PerformPacket_SC_Organization_PickUserFruitRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:TUserFruitInfos = null;
         var _loc8_:TUserFruitInfo = null;
         var _loc9_:TKamiTree = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         EffectGenerateText(STRING_ORGANIZATION.STRING_PickSuccess);
         _loc7_ = this.FOrgBaseData.BasicTreasureTree.UserFruitInfos;
         _loc4_ = int(_loc2_.readUnsignedInt());
         _loc5_ = int(_loc2_.readUnsignedInt());
         _loc6_ = int(_loc2_.readUnsignedInt());
         _loc8_ = _loc7_.GetUserFruitByIndex(_loc4_);
         _loc8_.FruitID = _loc5_;
         _loc9_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_KamiTree,_loc8_.FruitID) as TKamiTree;
         if(_loc9_ != null)
         {
            _loc8_.FruitName = _loc9_.Name;
            _loc8_.FruitLevel = _loc9_.Level;
         }
         _loc8_.FruitMatureTime = _loc6_;
         _loc8_.FruitEvolveTime = 0;
         this.FOrgBaseData.OrgExploit.High = _loc2_.readUnsignedInt();
         this.FOrgBaseData.OrgExploit.Low = _loc2_.readUnsignedInt();
         if(this.FOrgBaseData.BasicTreasureTree.UserFruitPickCount > 0)
         {
            --this.FOrgBaseData.BasicTreasureTree.UserFruitPickCount;
         }
         if(FIsResourcesLoadCompleted)
         {
            if(this.FOrgBaseData.OrgId > 0)
            {
               this.FProcessorWindowOrganizationMain.UpDataUI_OrgPart(this.FOrgBaseData,this.FOrgApplyListCount);
            }
            this.FProcessorWindowOrganizationMain.UpdateTreeUI();
         }
         this.FOrgTreeStatus = this.FOrgBaseData.BasicTreasureTree.HasMatureFruit() && this.FOrgBaseData.OrgLevel >= 5;
         this.CheckOrganizationIconEffect();
      }
      
      protected function PerformPacket_SC_Organization_WateringUserFruitRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:TUserWaterInfos = null;
         var _loc5_:TUserWaterInfo = null;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         EffectGenerateText(STRING_ORGANIZATION.STRING_WaterSuccess);
         _loc6_ = _loc2_.readUnsignedInt();
         _loc7_ = _loc2_.readUnsignedInt();
         this.FOrgBaseData.OrgExploit.High = _loc2_.readUnsignedInt();
         this.FOrgBaseData.OrgExploit.Low = _loc2_.readUnsignedInt();
         _loc4_ = this.FOrgBaseData.BasicTreasureTree.UserWaterInfos;
         _loc5_ = _loc4_.GetUserWaterByIdentifier(_loc6_,_loc7_);
         if(_loc5_ != null)
         {
            _loc5_.NextWaterTime = STimingCore.GetServerTime() + 6 * 60 * 60;
         }
         if(this.FOrgBaseData.BasicTreasureTree.UserWaterCount > 0)
         {
            --this.FOrgBaseData.BasicTreasureTree.UserWaterCount;
         }
         _loc4_.Sort();
         if(FIsResourcesLoadCompleted)
         {
            if(this.FOrgBaseData.OrgId > 0)
            {
               this.FProcessorWindowOrganizationMain.UpDataUI_OrgPart(this.FOrgBaseData,this.FOrgApplyListCount);
            }
            this.FProcessorWindowOrganizationMain.UpdateTreeUI();
         }
      }
      
      protected function PACKETID_SC_Organization_AutoWatering_User_Fruit_Ret(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:TUserWaterInfos = null;
         var _loc9_:TUserWaterInfo = null;
         _loc2_ = param1.Data;
         _loc7_ = _loc2_.readUnsignedInt();
         if(_loc7_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc7_);
            return;
         }
         EffectGenerateText(STRING_ORGANIZATIONALWAR.STRING_OneKeyWARTER);
         _loc8_ = this.FOrgBaseData.BasicTreasureTree.UserWaterInfos;
         _loc3_ = _loc2_.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = _loc2_.readUnsignedInt();
            _loc6_ = _loc2_.readUnsignedInt();
            _loc9_ = _loc8_.GetUserWaterByIdentifier(_loc5_,_loc6_);
            if(_loc9_ != null)
            {
               _loc9_.NextWaterTime = STimingCore.GetServerTime() + 6 * 60 * 60;
            }
            if(this.FOrgBaseData.BasicTreasureTree.UserWaterCount > 0)
            {
               --this.FOrgBaseData.BasicTreasureTree.UserWaterCount;
            }
            _loc4_++;
         }
         this.FOrgBaseData.OrgExploit.High = _loc2_.readUnsignedInt();
         this.FOrgBaseData.OrgExploit.Low = _loc2_.readUnsignedInt();
         _loc8_.Sort();
         if(FIsResourcesLoadCompleted)
         {
            if(this.FOrgBaseData.OrgId > 0)
            {
               this.FProcessorWindowOrganizationMain.UpDataUI_OrgPart(this.FOrgBaseData,this.FOrgApplyListCount);
            }
            this.FProcessorWindowOrganizationMain.UpdateTreeUI();
         }
      }
      
      protected function PerformPacket_SC_Organization_RipeningUserFruitRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:int = 0;
         var _loc5_:TUserFruitInfos = null;
         var _loc6_:TUserFruitInfo = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc4_ = int(_loc2_.readUnsignedInt());
         _loc5_ = this.FOrgBaseData.BasicTreasureTree.UserFruitInfos;
         _loc6_ = _loc5_.GetUserFruitByIndex(_loc4_);
         if(_loc6_ != null)
         {
            _loc6_.FruitMatureTime = 0;
         }
         _loc6_.FruitEvolveTime = _loc2_.readUnsignedInt();
         if(FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowOrganizationMain.UpdateTreeUI();
         }
         this.FOrgTreeStatus = this.FOrgBaseData.BasicTreasureTree.HasMatureFruit() && this.FOrgBaseData.OrgLevel >= 5;
         this.CheckOrganizationIconEffect();
      }
      
      protected function PerformPacket_SC_Organization_PickGuildFruitRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         this.PerformPacket_CS_Organization_ShowReq();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         SLogicsCore.Organization.BasicTreasureTree.OrgFruitPickCount = _loc2_.readUnsignedInt();
         _loc4_ = _loc2_.readUnsignedInt();
         _loc5_ = _loc2_.readUnsignedInt();
         if(_loc4_ == SLogicsCore.Character.Identifier0 && _loc5_ == SLogicsCore.Character.Identifier1)
         {
            this.FOrgBaseData.OrgExploit.High = _loc2_.readUnsignedInt();
            this.FOrgBaseData.OrgExploit.Low = _loc2_.readUnsignedInt();
         }
         SLogicsCore.Organization.BasicTreasureTree.IsPickOrgFruit = 1;
         if(FIsResourcesLoadCompleted)
         {
            if(this.FOrgBaseData.OrgId > 0)
            {
               this.FProcessorWindowOrganizationMain.UpDataUI_OrgPart(this.FOrgBaseData,this.FOrgApplyListCount);
            }
            this.FProcessorWindowOrganizationMain.UpdateTreeUI();
         }
         this.FOrgTreeStatus = this.FOrgBaseData.BasicTreasureTree.HasMatureFruit() && this.FOrgBaseData.OrgLevel >= 5;
         this.CheckOrganizationIconEffect();
      }
      
      protected function PerformPacket_SC_Organization_WateringGuildFruitRet(param1:TPacket) : void
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
         this.FOrgBaseData.OrgExploit.High = _loc2_.readUnsignedInt();
         this.FOrgBaseData.OrgExploit.Low = _loc2_.readUnsignedInt();
         if(this.FOrgBaseData.OrgId > 0)
         {
            this.FProcessorWindowOrganizationMain.UpDataUI_OrgPart(this.FOrgBaseData,this.FOrgApplyListCount);
         }
         EffectGenerateText(STRING_ORGANIZATION.STRING_WaterSuccess);
         this.PerformPacket_CS_Organization_ShowReq();
      }
      
      protected function PerformPacket_SC_Organization_EvolvingUserFruitRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:TUserFruitInfos = null;
         var _loc8_:TUserFruitInfo = null;
         var _loc9_:TKamiTree = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc7_ = this.FOrgBaseData.BasicTreasureTree.UserFruitInfos;
         _loc4_ = int(_loc2_.readUnsignedInt());
         _loc5_ = int(_loc2_.readUnsignedInt());
         _loc6_ = int(_loc2_.readUnsignedInt());
         _loc8_ = _loc7_.GetUserFruitByIndex(_loc4_);
         _loc8_.FruitID = _loc5_;
         _loc9_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_KamiTree,_loc8_.FruitID) as TKamiTree;
         if(_loc9_ != null)
         {
            _loc8_.FruitName = _loc9_.Name;
            _loc8_.FruitLevel = _loc9_.Level;
         }
         _loc8_.FruitMatureTime = _loc6_;
         _loc8_.FruitEvolveTime = 0;
         if(FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowOrganizationMain.UpdateTreeUI();
         }
      }
      
      protected function PerformPacket_SC_Organization_ShowRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:TBasicTreasureTree = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         _loc4_ = SLogicsCore.Organization.BasicTreasureTree;
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         this.FUnstreamizerOrg.UnstreamizeTreasureTree(_loc2_,_loc4_,this.FOrgMemberListDataVect);
         if(FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowOrganizationMain.UpdateTreeUI();
         }
         this.FOrgTreeStatus = _loc4_.HasMatureFruit() && this.FOrgBaseData.OrgLevel >= 5;
         this.CheckOrganizationIconEffect();
      }
      
      protected function PerformPacket_SC_Organization_AddExpRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:TBasicTreasureTree = null;
         var _loc5_:uint = 0;
         var _loc6_:int = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         _loc4_ = SLogicsCore.Organization.BasicTreasureTree;
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc8_ = _loc2_.readUnsignedInt();
         _loc4_.TreeCurrentExp = _loc8_;
         _loc4_.PushChakaraCDTime = _loc2_.readUnsignedInt();
         this.FOrgBaseData.OrgExploit.High = _loc2_.readUnsignedInt();
         this.FOrgBaseData.OrgExploit.Low = _loc2_.readUnsignedInt();
         if(_loc4_.PushChakaraCount > 0)
         {
            --_loc4_.PushChakaraCount;
         }
         if(_loc8_ >= this.FTreeExps[this.FTreeExps.length - 2])
         {
            _loc4_.TreeLevel = this.FTreeExps.length;
            _loc4_.TreeLevelupExp = 0;
         }
         else
         {
            _loc5_ = this.FTreeExps.length;
            _loc6_ = 0;
            while(_loc6_ < _loc5_)
            {
               _loc7_ = this.FTreeExps[_loc6_];
               if(_loc7_ > _loc8_)
               {
                  _loc9_ = _loc6_ + 1;
                  if(_loc9_ > _loc4_.TreeLevel)
                  {
                     EffectGenerateText(TUtilityString.Format(STRING_ORGANIZATION.FORMAT_TreeLevelup,_loc9_));
                  }
                  _loc4_.TreeLevel = _loc9_;
                  _loc4_.TreeLevelupExp = _loc7_;
                  break;
               }
               _loc6_++;
            }
         }
         if(FIsResourcesLoadCompleted)
         {
            if(this.FOrgBaseData.OrgId > 0)
            {
               this.FProcessorWindowOrganizationMain.UpDataUI_OrgPart(this.FOrgBaseData,this.FOrgApplyListCount);
            }
            this.FProcessorWindowOrganizationMain.UpdateTreeUI();
         }
      }
      
      protected function PerformPacket_SC_Organization_NotifyUserRipeRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:TBasicTreasureTree = null;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:TKamiTree = null;
         var _loc8_:String = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         _loc4_ = SLogicsCore.Organization.BasicTreasureTree;
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc5_ = _loc2_.readUnsignedInt();
         _loc6_ = _loc2_.readUnsignedInt();
         _loc7_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_KamiTree,_loc5_) as TKamiTree;
         _loc8_ = TUtilityString.Format(STRING_ORGANIZATION.FORMAT_UserFruitMature,_loc7_.Name);
         EffectGenerateText(_loc8_);
         if(this.FProcessorWindowOrganizationMain.Visible)
         {
            this.PerformPacket_CS_Organization_ShowReq();
         }
         this.FOrgTreeStatus = this.FOrgBaseData.BasicTreasureTree.HasMatureFruit() && this.FOrgBaseData.OrgLevel >= 5;
         this.CheckOrganizationIconEffect();
      }
      
      protected function PerformPacket_SC_Organization_NotifyUserEvolvRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:TBasicTreasureTree = null;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:String = null;
         var _loc8_:TKamiTree = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         _loc4_ = SLogicsCore.Organization.BasicTreasureTree;
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc5_ = _loc2_.readUnsignedInt();
         _loc6_ = _loc2_.readUnsignedInt();
         _loc8_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_KamiTree,_loc5_) as TKamiTree;
         _loc7_ = TUtilityString.Format(STRING_ORGANIZATION.FORMAT_UserFruitEvolve,_loc8_.Name);
         EffectGenerateText(_loc7_);
         if(this.FProcessorWindowOrganizationMain.Visible)
         {
            this.PerformPacket_CS_Organization_ShowReq();
         }
      }
      
      protected function PerformPacket_CS_Organization_ShowReq() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Organization_ShowReq);
         _loc1_.Data.writeUnsignedInt(0);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PerformPacket_SC_Organization_BuyAddExpCntRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:TBasicTreasureTree = null;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         _loc4_ = SLogicsCore.Organization.BasicTreasureTree;
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         ++_loc4_.PushChakaraCount;
         if(_loc4_.AddPushChakaraRestCount > 0)
         {
            --_loc4_.AddPushChakaraRestCount;
         }
         if(FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowOrganizationMain.UpdateTreeUI();
         }
      }
      
      protected function PerformPacket_SC_Organization_IsNewRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = param1.Data;
         SLogicsCore.Organization.BasicTreasureTree.IsNew = _loc2_.readUnsignedInt();
      }
      
      protected function PerformPacket_SC_Organization_ReduceAddExpCDRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:TBasicTreasureTree = null;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         _loc4_ = SLogicsCore.Organization.BasicTreasureTree;
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc4_.PushChakaraCDTime = 0;
         if(FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowOrganizationMain.UpdateTreeUI();
         }
      }
      
      protected function PerformPacket_SC_Organization_NotifyTreeInfoRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:TBasicTreasureTree = null;
         var _loc4_:TOperatingShowInfos = null;
         var _loc5_:TOperatingShowInfo = null;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:TKamiTree = null;
         _loc2_ = param1.Data;
         _loc3_ = SLogicsCore.Organization.BasicTreasureTree;
         _loc4_ = _loc3_.OperatingShowInfos;
         _loc5_ = new TOperatingShowInfo();
         _loc5_.ShowIndex = _loc2_.readUnsignedInt();
         _loc5_.ShowType = _loc2_.readUnsignedInt();
         _loc5_.UserName = TUtilityString.FetchUTF(_loc2_);
         _loc5_.UserQuality = _loc2_.readUnsignedInt();
         _loc5_.AddExp = _loc2_.readUnsignedInt();
         _loc5_.CurrentTreeLevel = _loc2_.readUnsignedInt();
         _loc6_ = _loc2_.readUnsignedInt();
         _loc7_ = _loc2_.readUnsignedInt();
         _loc5_.RewardName = STRING_COMMON.GetItemNameByType(_loc6_,_loc7_);
         _loc5_.RewardCount = _loc2_.readUnsignedInt();
         _loc5_.FruitID = _loc2_.readUnsignedInt();
         _loc8_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_KamiTree,_loc5_.FruitID) as TKamiTree;
         if(_loc8_ != null)
         {
            _loc5_.FruitName = _loc8_.Name;
         }
         _loc4_.Add(_loc5_);
         _loc4_.Sort();
         if(FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowOrganizationMain.UpdateTreeUI();
         }
      }
      
      protected function PerformPacket_SC_Organization_NotifyGuildFruit_Ret(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:TUserFruitInfo = null;
         var _loc4_:TUserFruitInfos = null;
         _loc4_ = this.FOrgBaseData.BasicTreasureTree.UserFruitInfos;
         _loc3_ = _loc4_.GetUserFruitByIndex(4);
         _loc2_ = param1.Data;
         if(_loc3_ != null)
         {
            _loc3_.FruitMatureTime = _loc2_.readUnsignedInt();
            _loc3_.FruitEvolveTime = _loc2_.readUnsignedInt();
            this.FOrgBaseData.BasicTreasureTree.OrgFruitPickCount = _loc2_.readUnsignedInt();
         }
         if(FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowOrganizationMain.UpdateTreeUI();
         }
         this.FOrgTreeStatus = this.FOrgBaseData.BasicTreasureTree.HasMatureFruit() && this.FOrgBaseData.OrgLevel >= 5;
         this.CheckOrganizationIconEffect();
      }
      
      protected function PerformPacket_CS_UpdateOrgBaseInfoReq() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Organization_GetGulidInfoReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PerformPacket_CS_LoadOrgListReq() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Organization_LoadGulidListReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PerformPacket_CS_LoadOrgMembersReq() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Organization_LoadMemberListReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PerformPacket_CS_GetCampReq() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Organization_GetCampReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PerformPacket_CS_ActivityStatusReq() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Organization_ActivityStatusReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PerformPacket_CS_LoadGulidDepotReq() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Organization_LoadGulidDepotReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PerformPacket_CS_QuitGuildReq() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Organization_QuitGuildReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PerformPacket_CS_DismissGuildReq() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Organization_DismissGuildReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function CleanAllData() : void
      {
         this.FOrgListDataVect.length = 0;
         this.FOrgApplyListDataVect.length = 0;
         this.FOrgMemberListDataVect.length = 0;
         this.FOrgCampDataVect.length = 0;
         this.FOrgActivityStatus.length = 0;
         this.FOrgLogVect.length = 0;
      }
      
      protected function OnChangeApplyListCount(param1:Object, param2:uint) : void
      {
         this.FOrgApplyListCount = param2;
         this.FProcessorWindowOrganizationMain.UpDateUI_OrgApplyListCount(this.FOrgApplyListCount);
      }
      
      protected function PerformPacket_CS_Organization_IsNewReq() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Organization_IsNewReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function OnOrgActivityOkClick(param1:Object, param2:uint, param3:uint) : void
      {
         var _loc4_:uint = 0;
         if(this.FOnShortcutHyperlinks == null)
         {
            return;
         }
         this.FProcessorWindowOrganizationActivity.UpData_OrgBaseInfo(this.FOrgBaseData);
         switch(param2)
         {
            case TYPE_ORGACTIVITY_CAMP:
               this.FProcessorWindowOrganizationMain.Visible = false;
               this.FProcessorWindowOrganizationActivity.Visible = true;
               this.FProcessorWindowOrganizationActivity.OnOrgActivityClick(1);
               this.FProcessorWindowOrganizationActivity.UpData_Technology(this.FOrgBaseData.OrgAddition,this.FOrgBaseData.OrgExploit.ToNumber());
               this.FProcessorWindowOrganizationActivity.UpDateUI_Technology();
               break;
            case TYPE_ORGACTIVITY_MUYEGUARD:
               if(param3 == STATUS_ORGACTIVITY_Battle)
               {
                  ProcessorClose();
                  if(this.FOnOrgActivityMuyeGuardStartBattle != null)
                  {
                     this.FOnOrgActivityMuyeGuardStartBattle(this);
                  }
               }
               else
               {
                  this.FProcessorWindowOrganizationMain.Visible = false;
                  this.FProcessorWindowOrganizationActivity.Visible = true;
                  this.FProcessorWindowOrganizationActivity.OnOrgActivityClick(2);
               }
               break;
            case TYPE_ORGACTIVITY_AnimalSeal:
               this.SendPackBaseInfomation();
               break;
            case TYPE_ORGACTIVITY_MUYEBATTLE:
               if(param3 == STATUS_ORGACTIVITY_SignUp)
               {
                  if(this.FOnOrgActivityMuyeBattleSignUp != null)
                  {
                     this.FOnOrgActivityMuyeBattleSignUp(this,CONST_ORGANIZATIONALWAR.CommandID_SignUp,0,null);
                  }
               }
               else if(param3 == STATUS_ORGACTIVITY_Battle)
               {
                  ProcessorClose();
                  if(this.FOnOrgActivityMuyeBattleStartBattle != null)
                  {
                     this.FOnOrgActivityMuyeBattleStartBattle(this);
                  }
               }
               else
               {
                  this.FProcessorWindowOrganizationMain.Visible = false;
                  this.FProcessorWindowOrganizationActivity.Visible = true;
                  this.FProcessorWindowOrganizationActivity.OnOrgActivityClick(4);
               }
         }
      }
      
      protected function SendPackBaseInfomation() : void
      {
         var _loc1_:TPacket = null;
         if(See_Or_In == 0)
         {
            this.FseeIsClick = 1;
            _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_AnimalSeall_SealPanel_Req);
         }
         else
         {
            _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Enter_OrganizeBossStage);
         }
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      public function PerformPacket_SC_Organization_Animal(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = param1.Data;
         this.BossLevel = _loc2_.readUnsignedInt();
         this.CalledCount = _loc2_.readUnsignedInt();
         this.CurApplyCount = _loc2_.readUnsignedInt();
         this.BtnState = _loc2_.readUnsignedInt();
         this.ApplyState = _loc2_.readUnsignedInt();
         if(this.BtnState == 2)
         {
            this.FProcessorWindowOrganizationActivity.ProcessorOnCloseCopy();
         }
         else
         {
            if(this.FseeIsClick)
            {
               this.FProcessorWindowOrganizationMain.Visible = false;
               this.FProcessorWindowOrganizationActivity.Visible = true;
            }
            this.FseeIsClick = 0;
            if(this.FProcessorWindowOrganizationMain.Organization == null)
            {
               return;
            }
            this.FProcessorWindowOrganizationActivity.OnOrgActivityClick(3);
            this.FProcessorWindowOrganizationActivity.InitilaFightPet(this.BossLevel,this.CalledCount,this.CurApplyCount,this.BtnState,this.ApplyState,this.FProcessorWindowOrganizationMain.Organization);
         }
      }
      
      protected function OrganizationMain(param1:TBaseOrganization) : void
      {
         this.FProcessorWindowOrganizationActivity.updateFightPet(param1);
      }
      
      public function PerformPacket_SC_Organization_apply(param1:TPacket) : void
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
      }
      
      protected function SignUpCallBack(param1:uint) : void
      {
         if(param1 != 0)
         {
            this.OnSetOrgActivity(TYPE_ORGACTIVITY_MUYEBATTLE,STATUS_ORGACTIVITY_Added);
         }
      }
      
      protected function OnProcessorWindowOrgDonate(param1:Object) : void
      {
         this.FProcessorWindowOrganizationMain.Visible = false;
         this.FProcessorWindowOrgDonate.Visible = true;
         this.FProcessorWindowOrgDonate.UpData(this.FOrgBaseData.OrgExploit.ToNumber(),this.FOrgBaseData.OrgMoney);
         this.FProcessorWindowOrgDonate.UpDateUI();
      }
      
      protected function OnProcessorWindowOrgDonateClose(param1:Object) : void
      {
         this.FProcessorWindowOrganizationMain.Visible = true;
         this.FProcessorWindowOrganizationMain.UpDataUI_OrgPart(this.FOrgBaseData,this.FOrgApplyListCount);
         this.FProcessorWindowOrgDonate.Visible = false;
      }
      
      protected function OnProcessorWindowOrgList(param1:Object, param2:Boolean) : void
      {
         this.FBOnBtnOrgListClick = true;
         this.PerformPacket_CS_LoadOrgListReq();
      }
      
      protected function OnProcessorWindowOrgGotoPower(param1:Object) : void
      {
         this.FProcessorWindowOrgPower.Visible = true;
         this.FProcessorWindowOrganizationMain.Visible = false;
      }
      
      protected function OnProcessorWindowOrgGotoPowerClose(param1:Object) : void
      {
         this.FProcessorWindowOrgPower.Visible = false;
         this.FProcessorWindowOrganizationMain.Visible = true;
      }
      
      protected function OnProcessorWindowOrgApplyList(param1:Object, param2:int) : void
      {
         var _loc3_:TPacket = null;
         _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Organization_LoadApplyListReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc3_);
         this.FProcessorWindowOrganizationMain.Visible = false;
         this.FProcessorWindowOrgApplyAndPower.Visible = true;
      }
      
      protected function OnProcessorWindowOrgSwitchPower(param1:Object, param2:int) : void
      {
         this.FProcessorWindowOrganizationMain.Visible = false;
         this.FProcessorWindowOrgApplyAndPower.Visible = true;
         this.FProcessorWindowOrgApplyAndPower.UpDateList(this.FOrgBaseData,this.FOrgMemberListDataVect,2);
      }
      
      protected function OnProcessorWindowOrgApplyListAndPowerClose(param1:Object) : void
      {
         this.FProcessorWindowOrganizationMain.Visible = true;
         this.FProcessorWindowOrgApplyAndPower.Visible = false;
      }
      
      protected function OnProcessorWindowOrgCreateShow(param1:Object) : void
      {
         this.FProcessorWindowOrgCreate.Visible = true;
         this.FProcessorWindowOrganizationMain.Visible = false;
         this.FProcessorWindowOrgCreate.UpDateUI();
      }
      
      protected function OnProcessorWindowOrgCreateClose(param1:Object) : void
      {
         this.FProcessorWindowOrgCreate.Visible = false;
         this.FProcessorWindowOrganizationMain.Visible = true;
      }
      
      protected function OnProcessorWindowOrgActivityClose(param1:Object) : void
      {
         this.FProcessorWindowOrganizationActivity.Visible = false;
         this.FProcessorWindowOrganizationMain.Visible = true;
      }
      
      protected function OnProcessorWinowOrgDonateFromOrgActivity(param1:Object) : void
      {
         this.FProcessorWindowOrganizationActivity.Visible = false;
         this.FProcessorWindowOrgDonate.Visible = true;
         this.FProcessorWindowOrgDonate.UpData(this.FOrgBaseData.OrgExploit.ToNumber(),this.FOrgBaseData.OrgMoney);
         this.FProcessorWindowOrgDonate.UpDateUI();
      }
      
      protected function OnBtnQuitClick(param1:Object) : void
      {
         var _loc2_:uint = 0;
         _loc2_ = this.FOrgBaseData.OrgPower;
         if(_loc2_ == 2)
         {
            this.PerformPacket_CS_DismissGuildReq();
         }
         else
         {
            this.PerformPacket_CS_QuitGuildReq();
         }
      }
      
      protected function OnOrgClose(param1:Object) : void
      {
         if(this.FBOnBtnOrgListClick)
         {
            this.FProcessorWindowOrganizationMain.UpDataPartData(this.FOrgBaseData,this.FOrgListDataVect,this.FOrgApplyListCount,true);
            this.FBOnBtnOrgListClick = false;
         }
         else
         {
            ProcessorClose();
         }
      }
      
      public function OnCloseMePanel() : void
      {
         ProcessorClose();
      }
      
      protected function OnHintOver(param1:Object, param2:THint) : void
      {
         FOverlayerHint.Context = param2;
         FOverlayerHint.Render(FUICore.MouseCoordinate);
         FOverlayerHint.Visible = true;
      }
      
      protected function OnHintOut(param1:Object) : void
      {
         FOverlayerHint.Visible = false;
      }
      
      protected function ShowEffectText(param1:Object, param2:String, param3:TEffectTextParameters = null, param4:TEffectCoordinateParameters = null, param5:uint = 5) : void
      {
         FOnEffectText(param1,param2,param3,param4,param5);
      }
      
      protected function SetOrgDonateStatus(param1:Boolean) : void
      {
         this.FOrgDonateStatus = param1 && this.FOrgBaseData.OrgId != 0;
         this.CheckOrganizationIconEffect();
      }
      
      protected function CheckOrganizationIconEffect() : void
      {
         if(this.FOnShortcutEffectNotification != null)
         {
            this.FOnShortcutEffectNotification(CONST_SHORTCUTS.POSITION_Function,CONST_SHORTCUTS.TYPE_Function_OrganiZation,this.FOrgDonateStatus || this.FOrgTreeStatus);
         }
         this.FProcessorWindowOrganizationMain.SetEffectStatus(this.FOrgDonateStatus,this.FOrgTreeStatus);
      }
      
      protected function ProcessorOnShowHeroInfo(param1:Object, param2:uint, param3:uint) : void
      {
         this.FOnShowHeroInfo(param1,param2,param3);
      }
      
      protected function ProcessorOnChatWhisper(param1:Object, param2:Object) : void
      {
         this.FOnChatWhisper(param1,param2);
      }
      
      protected function ProcessorOnInterpersonalRelationships(param1:Object, param2:uint, param3:Object) : void
      {
         this.FOnInterpersonalRelationships(param1,param2,param3);
      }
      
      protected function UIHelpHintOnOver(param1:Object, param2:THint) : void
      {
         FOverlayerHelpTips.Context = param2;
         FOverlayerHelpTips.Render(FUICore.MouseCoordinate);
         FOverlayerHelpTips.Show();
      }
      
      protected function UIHelpHintOnOut(param1:Object) : void
      {
         FOverlayerHelpTips.Hide();
      }
      
      protected function ProcessorOnUserFruitFastMature(param1:Object, param2:int, param3:uint) : void
      {
         var _loc4_:ByteArray = null;
         var _loc5_:TPacket = null;
         if(param3 == 0)
         {
            _loc5_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Organization_RipeningUserFruitReq);
         }
         else
         {
            _loc5_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Organization_EvolvingUserFruitReq);
         }
         _loc4_ = _loc5_.Data;
         _loc4_.writeUnsignedInt(param2);
         SNetworkCore.Transceiver.PacketTransmit(_loc5_);
      }
      
      protected function ProcessorPickFruitOnClick(param1:Object, param2:int) : void
      {
         var _loc3_:ByteArray = null;
         var _loc4_:TPacket = null;
         var _loc5_:int = 0;
         var _loc6_:TBasicTreasureTree = null;
         _loc6_ = SLogicsCore.Organization.BasicTreasureTree;
         if(_loc6_.IsNew == 1)
         {
            TutorialNextStep(2403);
         }
         if(param2 != 4)
         {
            _loc4_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Organization_PickUserFruitReq);
            _loc3_ = _loc4_.Data;
            _loc3_.writeUnsignedInt(param2);
         }
         else
         {
            _loc5_ = _loc6_.OrgFruitMatureTimes - STimingCore.GetServerTime();
            if(_loc5_ >= 0)
            {
               _loc4_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Organization_WateringGuildFruitReq);
            }
            else
            {
               _loc4_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Organization_PickGuildFruitReq);
            }
         }
         SNetworkCore.Transceiver.PacketTransmit(_loc4_);
      }
      
      protected function ProcessorWaterOrgMemberOnClick(param1:Object, param2:uint, param3:uint) : void
      {
         var _loc4_:ByteArray = null;
         var _loc5_:TPacket = null;
         _loc5_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Organization_WateringUserFruitReq);
         _loc4_ = _loc5_.Data;
         _loc4_.writeUnsignedInt(param2);
         _loc4_.writeUnsignedInt(param3);
         SNetworkCore.Transceiver.PacketTransmit(_loc5_);
      }
      
      protected function KeyWatersClisk() : void
      {
         var _loc1_:ByteArray = null;
         var _loc2_:TPacket = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_AutoWatering_User_Fruit_Req);
         _loc1_ = _loc2_.Data;
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function ProcessorPushChakraOnClick(param1:Object) : void
      {
         var _loc2_:TPacket = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Organization_AddExpReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function ProcessorAddChakraTimesOnClick(param1:Object) : void
      {
         var _loc2_:TPacket = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Organization_BuyAddExpCntReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function ProcessorFastOnClick(param1:Object) : void
      {
         var _loc2_:TPacket = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Organization_ReduceAddExpCDReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      public function get OnShortcutHyperlinks() : Function
      {
         return this.FOnShortcutHyperlinks;
      }
      
      public function set OnShortcutHyperlinks(param1:Function) : void
      {
         this.FOnShortcutHyperlinks = param1;
      }
      
      public function get OnOrgActivityMuyeBattleSignUp() : Function
      {
         return this.FOnOrgActivityMuyeBattleSignUp;
      }
      
      public function set OnOrgActivityMuyeBattleSignUp(param1:Function) : void
      {
         this.FOnOrgActivityMuyeBattleSignUp = param1;
      }
      
      public function get SetDailyActivityStatus() : Function
      {
         return this.FSetDailyActivityStatus;
      }
      
      public function set SetDailyActivityStatus(param1:Function) : void
      {
         this.FSetDailyActivityStatus = param1;
      }
      
      public function get UpdateHerosPower() : Function
      {
         return this.FUpdateHerosPower;
      }
      
      public function set UpdateHerosPower(param1:Function) : void
      {
         this.FUpdateHerosPower = param1;
      }
      
      public function get OnSetOrganizationName() : Function
      {
         return this.FOnSetOrganizationName;
      }
      
      public function set OnSetOrganizationName(param1:Function) : void
      {
         this.FOnSetOrganizationName = param1;
      }
      
      public function get OnSetOrganizationChannel() : Function
      {
         return this.FOnSetOrganizationChannel;
      }
      
      public function set OnSetOrganizationChannel(param1:Function) : void
      {
         this.FOnSetOrganizationChannel = param1;
      }
      
      public function get OnOrgActivityMuyeGuardStartBattle() : Function
      {
         return this.FOnOrgActivityMuyeGuardStartBattle;
      }
      
      public function set OnOrgActivityMuyeGuardStartBattle(param1:Function) : void
      {
         this.FOnOrgActivityMuyeGuardStartBattle = param1;
      }
      
      public function get OnOrgActivityMuyeBattleStartBattle() : Function
      {
         return this.FOnOrgActivityMuyeBattleStartBattle;
      }
      
      public function set OnOrgActivityMuyeBattleStartBattle(param1:Function) : void
      {
         this.FOnOrgActivityMuyeBattleStartBattle = param1;
      }
      
      public function get OnShowHeroInfo() : Function
      {
         return this.FOnShowHeroInfo;
      }
      
      public function set OnShowHeroInfo(param1:Function) : void
      {
         this.FOnShowHeroInfo = param1;
      }
      
      public function get OnChatWhisper() : Function
      {
         return this.FOnChatWhisper;
      }
      
      public function set OnChatWhisper(param1:Function) : void
      {
         this.FOnChatWhisper = param1;
      }
      
      public function get OnInterpersonalRelationships() : Function
      {
         return this.FOnInterpersonalRelationships;
      }
      
      public function set OnInterpersonalRelationships(param1:Function) : void
      {
         this.FOnInterpersonalRelationships = param1;
      }
      
      public function get SendGVGModule() : Function
      {
         return this.FSendGVGModule;
      }
      
      public function set SendGVGModule(param1:Function) : void
      {
         this.FSendGVGModule = param1;
      }
      
      public function get OnShortcutEffectNotification() : Function
      {
         return this.FOnShortcutEffectNotification;
      }
      
      public function set OnShortcutEffectNotification(param1:Function) : void
      {
         this.FOnShortcutEffectNotification = param1;
      }
      
      public function get OnUserTotalFightingPowerReq() : Function
      {
         return this.FOnUserTotalFightingPowerReq;
      }
      
      public function set OnUserTotalFightingPowerReq(param1:Function) : void
      {
         this.FOnUserTotalFightingPowerReq = param1;
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount(param1);
         if(!FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowOrganizationMain.Load();
            this.FProcessorWindowOrganizationActivity.Load();
            this.FProcessorWindowOrgCreate.Load();
            this.FProcessorWindowOrgApplyAndPower.Load();
            this.FProcessorWindowOrgDonate.Load();
            this.FProcessorWindowOrgPower.Load();
            this.FCallPetPanel.Load();
            return;
         }
         this.FOrgInitWindows = true;
         this.PerformPacket_CS_UpdateOrgBaseInfoReq();
         this.PerformPacket_CS_GetCampReq();
         this.PerformPacket_CS_Organization_IsNewReq();
         this.FProcessorWindowOrganizationMain.Visible = true;
         this.FProcessorWindowOrganizationActivity.Visible = false;
         this.FProcessorWindowOrgCreate.Visible = false;
         this.FProcessorWindowOrgApplyAndPower.Visible = false;
         this.FProcessorWindowOrgDonate.Visible = false;
         this.FProcessorWindowOrgPower.Visible = false;
         this.FProcessorWindowOrganizationMain.PlayEffect();
      }
      
      override public function Unmount() : void
      {
         this.FProcessorWindowOrganizationMain.Visible = false;
         this.FProcessorWindowOrganizationActivity.Visible = false;
         this.FProcessorWindowOrgCreate.Visible = false;
         this.FProcessorWindowOrgApplyAndPower.Visible = false;
         this.FProcessorWindowOrgPower.Visible = false;
         this.FOrgInitWindows = false;
         this.FBOnBtnOrgListClick = false;
         if(!FIsResourcesLoadCompleted)
         {
            return;
         }
         this.FProcessorWindowOrganizationMain.Unmount();
         this.FOrgTreeStatus = this.FOrgBaseData.BasicTreasureTree.HasMatureFruit() && this.FOrgBaseData.OrgLevel >= 5;
         this.CheckOrganizationIconEffect();
         TutorialNextStep(2403);
         super.Unmount();
      }
      
      public function GetOrgNameFromOrgID(param1:uint) : String
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         _loc4_ = "";
         _loc3_ = int(this.FOrgListDataVect.length);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            if(this.FOrgListDataVect[_loc2_].OrgID == param1)
            {
               _loc4_ = this.FOrgListDataVect[_loc2_].OrgName;
               break;
            }
            _loc2_++;
         }
         return _loc4_;
      }
      
      public function OrganizationIconEffectDataReq() : void
      {
         this.FProcessorWindowOrgDonate.PerformPacket_CS_UpdateCounterReq();
         this.PerformPacket_CS_Organization_ShowReq();
      }
      
      public function GetActivityLevelByType(param1:uint) : uint
      {
         var _loc2_:uint = 0;
         return this.FOrgBaseData.GetOrgActivityLevelByType(param1);
      }
      
      public function OnSetOrgActivity(param1:uint, param2:uint) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:uint = 0;
         _loc4_ = int(this.FOrgActivityStatus.length);
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            if(param1 == this.FOrgActivityStatus[_loc3_].type)
            {
               _loc5_ = uint(this.FOrgActivityStatus[_loc3_].type);
               this.FOrgActivityStatus[_loc3_].status = param2;
               this.FOrgBaseData.OrgActivityStatus[_loc3_].status = param2;
               break;
            }
            _loc3_++;
         }
         if(param1 == TYPE_ORGACTIVITY_MUYEBATTLE && param2 == STATUS_ORGACTIVITY_Added)
         {
            EffectGenerateText(STRING_ORGANIZATION.STRING_SignUpSucceed);
         }
         SLogicsCore.Organization.OrgActivityStatus = this.FOrgActivityStatus;
         if(this.FSetDailyActivityStatus != null)
         {
            this.FSetDailyActivityStatus(this,param1,param2);
         }
         if(this.FOrgInitWindows)
         {
            this.FProcessorWindowOrganizationMain.UpDataUI_OrgActivityBtnStatus(_loc5_,param2);
         }
      }
   }
}

