package Processors.Game.Lobby.Global
{
   import Externals.SExternalCore;
   import Foundation.Common.TBounds;
   import Foundation.Common.TCoordinate;
   import Foundation.Common.THint;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Resources.Repositories.TResourceRepositoryTexture;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Resources.Textures.TTexture;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.DatebaseVO.VO.TRoleModel;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.GlobalBattle.TGlobalBattle;
   import Logics.GlobalBattle.TGlobalBattleReport;
   import Logics.SLogicsCore;
   import Logics.Spaces.LogicsSpace;
   import Logics.Streamization.GlobalBattle.TUnstreamizerGlobalBattle;
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
   import Processors.Game.Lobby.Components.TUIHero;
   import Processors.Game.Windows.Information.TUIWindowBattleSkip;
   import Rendering.Overlayers.HelpTips.TOverlayerHelpTips;
   import Resources.Constants.CONST_BATTLE;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_GLOBALBATTLE;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Strings.STRING_TOPTEAM;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   
   use namespace LogicsSpace;
   
   public class TProcessorGlobalBattle extends TProcessorLobbyPlate
   {
      
      protected static const REPORT_MAX:uint = CONST_GLOBALBATTLE.REPORT_MAX;
      
      protected var FMainUI:Sprite;
      
      protected var FMC_BasicInfo:MovieClip;
      
      protected var FMC_Hero:MovieClip;
      
      protected var FTF_RestPlayCount:TextField;
      
      protected var FTF_WinCount:TextField;
      
      protected var FTF_TotalScore:TextField;
      
      protected var FTF_CurrentRank:TextField;
      
      protected var FTF_CurrentNinjaPoint:TextField;
      
      protected var FMC_Start:MovieClip;
      
      protected var FBTN_Close:SimpleButton;
      
      protected var FBTN_Help:SimpleButton;
      
      protected var FMC_NinjaPointMall:MovieClip;
      
      protected var FBTN_Apply:MovieClip;
      
      protected var FBTN_Rank:MovieClip;
      
      protected var FBTN_Champion:MovieClip;
      
      protected var FProcessorGlobalBattleRank:TProcessorGlobalBattleRank;
      
      protected var FProcessorGlobalBattleMall:TProcessorGlobalBattleMall;
      
      protected var FProcessorGlobalBattleHeros:TProcessorGlobalBattleHeros;
      
      protected var FHelpTips:THint;
      
      protected var FGlobalBattle:TGlobalBattle;
      
      protected var FUIWindowBattleSkip:TUIWindowBattleSkip;
      
      protected var FOverlayerHelpTips:TOverlayerHelpTips;
      
      protected var FOnReturnMainScene:Function;
      
      protected var FNinjaPointMallOnClick:Function;
      
      protected var FSetStatusType:Function;
      
      protected var FOnInitBattle:Function;
      
      protected var FOnScoreChange:Function;
      
      protected var FUnstreamizerGlobalbattle:TUnstreamizerGlobalBattle;
      
      protected var FUIHero:TUIHero;
      
      public function TProcessorGlobalBattle(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.Init();
      }
      
      protected function Init() : void
      {
         this.FGlobalBattle = SLogicsCore.GlobalBattle;
         this.FHelpTips = new THint();
         this.FUnstreamizerGlobalbattle = new TUnstreamizerGlobalBattle();
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_GLOBALBATTLE.RESOURCESID_Swf_GlobalBattle);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.FMainUI = TUtilityReflection.CreateDisplayObjectInstance("MC_GlobalBattleUI") as Sprite;
         addChild(this.FMainUI);
         this.FProcessorGlobalBattleRank = new TProcessorGlobalBattleRank(this);
         this.FProcessorGlobalBattleRank.OnFetchReward = this.ProcessorOnFetchReward;
         this.FProcessorGlobalBattleRank.Load();
         this.FProcessorGlobalBattleMall = new TProcessorGlobalBattleMall(this);
         this.FProcessorGlobalBattleMall.OnMallBuy = this.ProcessorOnMallBuy;
         this.FProcessorGlobalBattleMall.Load();
         this.FProcessorGlobalBattleHeros = new TProcessorGlobalBattleHeros(this);
         this.UIDispatchHeroStatus();
         this.UIDispatchOtherInfo();
         this.UIDispatchReportInfo();
         this.FOverlayerHelpTips = new TOverlayerHelpTips(this);
         this.FOverlayerHelpTips.Visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerHelpTips);
         this.FUIWindowBattleSkip = new TUIWindowBattleSkip(this);
         this.FUIWindowBattleSkip.Perform_UIDispatch();
         this.FUIWindowBattleSkip.OnOK = this.OnConfirmationOk;
         this.FUIWindowBattleSkip.OnCancel = this.OnWindowCancel;
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:MovieClip = null;
         this.FMC_Start.addEventListener(MouseEvent.CLICK,this.MCStartOnClick,false,0,true);
         this.FBTN_Close.addEventListener(MouseEvent.CLICK,this.BTNCloseOnClick,false,0,true);
         this.FBTN_Help.addEventListener(MouseEvent.MOUSE_OVER,this.ButtonHelpOnOver,false,0,true);
         this.FBTN_Help.addEventListener(MouseEvent.MOUSE_OUT,this.ButtonHelpOnOut,false,0,true);
         this.FMC_NinjaPointMall.addEventListener(MouseEvent.CLICK,this.MCNinjaPointMallOnClick,false,0,true);
         this.FBTN_Rank.addEventListener(MouseEvent.CLICK,this.BtnRankOnClick);
         this.FBTN_Apply.addEventListener(MouseEvent.CLICK,this.OnBtnApplyClick);
         super.ResourcesPerform_UILocations();
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_GlobalBattle_Info,this.PerformPacket_SC_Info);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_GlobalBattle_Apply,this.PerformPacket_SC_Apply);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_GlobalBattle_Fight,this.PerformPacket_SC_Fight);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_GlobalBattle_Rank,this.PerformPacket_SC_Rank);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_GlobalBattle_Buy,this.PerformPacket_SC_Buy);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_GlobalBattle_Reward,this.PerformPacket_SC_Reward);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_GlobalBattle_HisUser,this.PerformPacket_SC_HisUser);
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Boolean = false;
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         super.LogicsPerform();
         if(!Visible)
         {
            return;
         }
         if(this.FUIHero)
         {
            this.FUIHero.Update();
         }
         if(!this.FProcessorGlobalBattleHeros)
         {
         }
      }
      
      protected function PerformPacket_SC_Info(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         this.FTF_RestPlayCount.text = _loc2_.readInt().toString();
         this.FTF_WinCount.text = _loc2_.readInt().toString();
         this.FUnstreamizerGlobalbattle.UnstreamizerGlobalBattleReport(_loc2_,this.FGlobalBattle.GlobalBattleReports,null);
         this.UpdateReportInfo();
      }
      
      protected function PerformPacket_SC_Apply(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:TSystemLanguage = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.STRING_GlobalBattle_02) as TSystemLanguage;
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         EffectGenerateText(_loc4_.Desc);
      }
      
      protected function PerformPacket_SC_Fight(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         _loc4_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         if(this.FOnScoreChange != null)
         {
            this.FOnScoreChange(_loc4_ - int(this.FTF_TotalScore.text));
         }
         this.FTF_TotalScore.text = String(_loc4_);
         if(this.FSetStatusType != null)
         {
            this.FSetStatusType(this,CONST_BATTLE.BattleType_GlobalBattle,0);
         }
         if(this.FOnInitBattle != null)
         {
            this.FOnInitBattle(this);
         }
      }
      
      protected function PerformPacket_SC_HisUser(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = param1.Data;
         this.FUnstreamizerGlobalbattle.UnstreamizerGlobalBattleUsers(_loc2_,this.FGlobalBattle.GlobalBattleUsers,null);
      }
      
      protected function PerformPacket_SC_Rank(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         this.FUnstreamizerGlobalbattle.Unstreamize(_loc2_,this.FGlobalBattle,null);
         this.FProcessorGlobalBattleRank.Visible = true;
         this.FProcessorGlobalBattleRank.UpdateRankings();
         this.FTF_CurrentRank.text = this.FGlobalBattle.SelfRank.toString();
         this.FTF_TotalScore.text = this.FGlobalBattle.SelfScore.toString();
      }
      
      protected function PerformPacket_SC_Reward(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:TSystemLanguage = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.STRING_GlobalBattle_01) as TSystemLanguage;
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         EffectGenerateText(_loc4_.Desc);
      }
      
      protected function PerformPacket_SC_Buy(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         this.FProcessorGlobalBattleMall.UpdateNinjaPointUI();
         EffectGenerateText(STRING_TOPTEAM.STRING_ChargeSuccess);
      }
      
      protected function UIDispatchHeroStatus() : void
      {
         this.FUIHero = new TUIHero(this);
         this.FMC_Hero = this.FMainUI["MC_Hero"];
         this.FMC_Hero.addChild(this.FUIHero);
         this.FUIHero.OnQuerySequenceContext = this.HeroOnQuerySequenceContext;
         this.FUIHero.DefaultRole = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_DefaultRoleTexture) as Sprite;
      }
      
      protected function UIDispatchReportInfo() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:SimpleButton = null;
         _loc1_ == 0;
         while(_loc1_ < REPORT_MAX)
         {
            _loc2_ = this.FMainUI["btn_Replay_" + _loc1_] as SimpleButton;
            _loc2_.addEventListener(MouseEvent.CLICK,this.OnReplayClick);
            _loc1_++;
         }
      }
      
      protected function UIDispatchOtherInfo() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:MovieClip = null;
         this.FMC_BasicInfo = this.FMainUI["MC_BasicInfo"];
         this.FMC_NinjaPointMall = this.FMC_BasicInfo["MC_NinjaPointMall"];
         TGameUtil.setButtonMode(this.FMC_NinjaPointMall,true);
         this.FBTN_Rank = this.FMC_BasicInfo["MC_NinjaRank"];
         TGameUtil.setButtonMode(this.FBTN_Rank,true);
         this.FBTN_Apply = this.FMC_BasicInfo["MC_Apply"];
         TGameUtil.setButtonMode(this.FBTN_Apply,true);
         this.FMC_Start = this.FMC_BasicInfo["MC_Start"];
         TGameUtil.setButtonMode(this.FMC_Start,true);
         this.FTF_RestPlayCount = this.FMC_BasicInfo["TF_RestPlayCount"];
         this.FBTN_Close = this.FMC_BasicInfo["BTN_Close"];
         this.FBTN_Help = this.FMC_BasicInfo["BTN_Help"];
         this.FTF_WinCount = this.FMC_BasicInfo["TF_WinCount"];
         this.FTF_TotalScore = this.FMC_BasicInfo["TF_TotalScore"];
         this.FTF_CurrentRank = this.FMC_BasicInfo["TF_CurrentRank"];
         this.FTF_CurrentNinjaPoint = this.FMC_BasicInfo["TF_CurrentNinjaPoint"];
      }
      
      protected function UpdateHeroStatus() : void
      {
         if(this.FUIHero)
         {
            this.FUIHero.Context = SLogicsCore.Character.MainHero.Identifier;
         }
      }
      
      protected function HeroOnQuerySequenceContext(param1:Object, param2:Object, param3:TQueryAnimationSequence, param4:uint = 0) : void
      {
         var _loc5_:int = 0;
         var _loc6_:TResourceRepositoryTexture = null;
         var _loc7_:TTexture = null;
         var _loc8_:TBounds = null;
         var _loc9_:TCoordinate = null;
         var _loc10_:TRoleModel = null;
         _loc5_ = param2 as int;
         _loc8_ = new TBounds();
         _loc9_ = new TCoordinate();
         _loc6_ = SResourcesCore.TexturesModel;
         _loc10_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_RoleModel,_loc5_) as TRoleModel;
         _loc7_ = _loc6_.GetTextureByIdentifier(_loc10_.Model);
         if(_loc7_ != null)
         {
            param3.Value = _loc7_.GetAnimationSequenceByIndex(0);
            param3.Value.Evaluate(_loc9_,_loc8_);
            this.FUIHero.X = _loc8_.X;
            this.FUIHero.Y = _loc8_.Y;
         }
         else
         {
            _loc6_.LoadSecondary(_loc10_.Model,CONST_MODULES.MODULE_Heros);
            this.FUIHero.X = 0;
            this.FUIHero.Y = 0;
         }
      }
      
      protected function UpdateUI() : void
      {
         this.UpdateHeroStatus();
      }
      
      protected function UpdateReportInfo() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:SimpleButton = null;
         var _loc3_:TextField = null;
         var _loc4_:TextField = null;
         var _loc5_:TGlobalBattleReport = null;
         var _loc6_:int = 0;
         _loc1_ == 0;
         while(_loc1_ < REPORT_MAX)
         {
            _loc6_ = int(this.FGlobalBattle.GlobalBattleReports.length);
            _loc3_ = this.FMainUI["TF_Time_" + _loc1_] as TextField;
            _loc4_ = this.FMainUI["TF_Result_" + _loc1_] as TextField;
            _loc2_ = this.FMainUI["btn_Replay_" + _loc1_] as SimpleButton;
            if(_loc1_ < _loc6_)
            {
               _loc5_ = this.FGlobalBattle.GlobalBattleReports[_loc1_];
               _loc2_.visible = true;
               _loc3_.text = TUtilityDate.FormatTime(new Date(_loc5_.Time * 1000));
               _loc4_.text = _loc5_.FightResult == 1 ? "Win" : "Fail";
            }
            else
            {
               _loc2_.visible = false;
               _loc3_.text = "";
               _loc4_.text = "";
            }
            _loc1_++;
         }
      }
      
      protected function PerformPacket_CS_Match_Req() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_GlobalBattle_Fight);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function MCNinjaPointMallOnClick(param1:MouseEvent) : void
      {
         this.FProcessorGlobalBattleMall.Visible = true;
         this.FProcessorGlobalBattleMall.Update();
      }
      
      protected function OnBtnOpenChampion(param1:MouseEvent) : void
      {
         this.FProcessorGlobalBattleHeros.Visible = true;
         this.FProcessorGlobalBattleHeros.UpdateComboBox(this.FGlobalBattle.GlobalBattleUsers);
      }
      
      protected function BtnRankOnClick(param1:MouseEvent) : void
      {
         this.PerformPacket_CS_Rank_Req();
         this.FProcessorGlobalBattleRank.Mount();
      }
      
      protected function OnBtnApplyClick(param1:MouseEvent) : void
      {
         var _loc2_:TPacket = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_GlobalBattle_Apply);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function ProcessorOnFetchReward() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_GlobalBattle_Reward);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function MCStartOnClick(param1:MouseEvent) : void
      {
         if(!this.FUIWindowBattleSkip.IsSelected)
         {
            this.FUIWindowBattleSkip.Visible = true;
         }
         else
         {
            this.PerformPacket_CS_Match_Req();
         }
      }
      
      protected function ButtonHelpOnOver(param1:MouseEvent) : void
      {
         var _loc2_:TSystemLanguage = null;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.HELPTIPS_GlobalBattle) as TSystemLanguage;
         this.FHelpTips.Content = _loc2_.Desc;
         this.FOverlayerHelpTips.Context = this.FHelpTips;
         this.FOverlayerHelpTips.Render(FUICore.MouseCoordinate);
         this.FOverlayerHelpTips.Show();
      }
      
      protected function ButtonHelpOnOut(param1:MouseEvent) : void
      {
         this.FOverlayerHelpTips.Hide();
      }
      
      protected function BTNCloseOnClick(param1:MouseEvent) : void
      {
         if(this.FOnReturnMainScene != null)
         {
            this.FOnReturnMainScene(this);
         }
      }
      
      protected function OnReplayClick(param1:MouseEvent) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:SimpleButton = null;
         var _loc4_:String = null;
         _loc2_ == 0;
         while(_loc2_ < REPORT_MAX)
         {
            _loc3_ = this.FMainUI["btn_Replay_" + _loc2_] as SimpleButton;
            if(_loc3_ == param1.currentTarget)
            {
               _loc4_ = this.FGlobalBattle.GlobalBattleReports[_loc2_].ReportID;
               break;
            }
            _loc2_++;
         }
         SExternalCore.NavigateToFightReport(_loc4_);
      }
      
      protected function PerformPacket_CS_Info_Req() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_GlobalBattle_Info);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PerformPacket_CS_Rank_Req() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_GlobalBattle_Rank);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function ProcessorOnMallBuy(param1:Object, param2:uint, param3:uint) : void
      {
         var _loc4_:TPacket = null;
         var _loc5_:ByteArray = null;
         _loc4_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_GlobalBattle_Buy);
         _loc5_ = _loc4_.Data;
         _loc5_.writeUnsignedInt(param3);
         _loc5_.writeUnsignedInt(param2);
         SNetworkCore.Transceiver.PacketTransmit(_loc4_);
      }
      
      protected function OnConfirmationOk(param1:Object) : void
      {
         this.FUIWindowBattleSkip.SetBattleSkipStatus(true,CONST_BATTLE.BattleType_GlobalBattle);
         this.PerformPacket_CS_Match_Req();
      }
      
      protected function OnWindowCancel(param1:Object) : void
      {
         this.FUIWindowBattleSkip.SetBattleSkipStatus(false,CONST_BATTLE.BattleType_GlobalBattle);
         this.PerformPacket_CS_Match_Req();
      }
      
      public function set OnReturnMainScene(param1:Function) : void
      {
         this.FOnReturnMainScene = param1;
      }
      
      public function set NinjaPointMallOnClick(param1:Function) : void
      {
         this.FNinjaPointMallOnClick = param1;
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
            _loc5_.ShortcutModeHero = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
            _loc5_.ShortcutModeStar = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
            _loc5_.ShortcutModeTacticalDeployment = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
            _loc5_.ShortcutModeInheritPractice = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
            _loc5_.ShortcutModeBackpack = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
            _loc5_.ShortcutModeTreasure = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
            _loc5_.ShortcutModeSummonPet = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
            _loc5_.ShortcutModeStrengthen = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
            _loc5_.ShortcutModeMail = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
            _loc5_.ShortcutModeTongLing = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
            _loc5_.ShortcutModeOrganiZation = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
            _loc5_.ShortcutModeReturn = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
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
         var _loc2_:Date = null;
         var _loc3_:Number = NaN;
         super.Mount(param1);
         if(!FIsResourcesLoadCompleted)
         {
            return;
         }
         this.UpdateUI();
         this.PerformPacket_CS_Info_Req();
      }
      
      override public function Unmount() : void
      {
         super.Unmount();
         this.Reset();
      }
      
      public function Reset() : void
      {
      }
      
      public function get OnInitBattle() : Function
      {
         return this.FOnInitBattle;
      }
      
      public function set OnInitBattle(param1:Function) : void
      {
         this.FOnInitBattle = param1;
      }
      
      public function set SetStatusType(param1:Function) : void
      {
         this.FSetStatusType = param1;
      }
      
      public function get SetStatusType() : Function
      {
         return this.FSetStatusType;
      }
      
      public function set OnScoreChange(param1:Function) : void
      {
         this.FOnScoreChange = param1;
      }
   }
}

