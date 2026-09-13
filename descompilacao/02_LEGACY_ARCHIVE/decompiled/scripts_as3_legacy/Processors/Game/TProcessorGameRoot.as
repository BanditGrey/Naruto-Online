package Processors.Game
{
   import Externals.*;
   import Foundation.Common.*;
   import Foundation.Fonts.*;
   import Foundation.Network.*;
   import Foundation.Queries.*;
   import Foundation.Resources.*;
   import Foundation.Resources.Repositories.*;
   import Foundation.UI.*;
   import Logics.Affairs.*;
   import Logics.Agent.*;
   import Logics.ChatOptions.*;
   import Logics.DatebaseVO.VO.*;
   import Logics.Globalboss.TGlobalboss;
   import Logics.SLogicsCore;
   import Processors.Game.Battle.*;
   import Processors.Game.Common.*;
   import Processors.Game.Common.Effects.Texts.TEffectCoordinateParameters;
   import Processors.Game.Common.Effects.Texts.TEffectTextParameters;
   import Processors.Game.CreateCharNew.TProcessorCreateRole;
   import Processors.Game.Effects.*;
   import Processors.Game.GroupBattle.TGroupBattleStage;
   import Processors.Game.Lobby.*;
   import Processors.Game.Lobby.SocketSpeed.SSocketSpeed;
   import Processors.Game.Login.*;
   import Processors.Game.Marquee.*;
   import Processors.Game.Plot.*;
   import Processors.Game.SocketLoading.*;
   import Processors.Game.Sound.*;
   import Processors.Game.TopTeamBattle.TTopTeamStage;
   import Processors.Game.Windows.Information.*;
   import Resources.Constants.*;
   import Resources.Strings.STRING_COMMON;
   import Utilities.UI.Windows.*;
   import flash.display.*;
   import flash.events.*;
   import flash.system.Capabilities;
   import flash.utils.*;
   
   public class TProcessorGameRoot extends TProcessorGame
   {
      
      protected static const AFFAIRID_ConnectionDrop:uint = 4278190080;
      
      protected static const RESOURCESID_DATEBASE:Vector.<uint> = CONST_DATEBASEVO.RESOURCESID_DATEBASE;
      
      public static const CAPACITY_ParallelOutputRows:uint = CONST_EFFECT.CAPACITY_ParallelOutputRows;
      
      protected var FFontLibrary:TFontLibrary;
      
      protected var FUIWindowInformation:TUIWindowInformation;
      
      protected var FUIWindowAntiAddictionInformation:TUIWindowInformation;
      
      protected var FProcessorSounds:TProcessorSounds;
      
      protected var FMountPointOverview:TProcessorMountPoint;
      
      protected var FProcessorEffect:TProcessorRootEffect;
      
      protected var FProcessorCreateChar:TProcessorCreateRole;
      
      protected var FProcessorLogin:TProcessorLogin;
      
      protected var FProcessorBattle:TBattleHandle;
      
      protected var FProcessorGroupBattle:TGroupBattleStage;
      
      protected var FProcessorTopTeamBattle:TTopTeamStage;
      
      protected var FProcessorLobby:TProcessorLobby;
      
      protected var FProcessorPlot:TProcessorPlot;
      
      protected var FProcessorMarquee:TProcessorMarquee;
      
      protected var FProcessorTyphon:TProcessorTyphon;
      
      protected var FProcessorWindowSocketLoading:TProcessorWindowSocketLoading;
      
      protected var FOnGarbageCollector:Function;
      
      public function TProcessorGameRoot(param1:TUIComponent)
      {
         super(param1);
         this.FProcessorSounds = new TProcessorSounds(this);
         this.FProcessorSounds.Load();
         this.FProcessorSounds.mouseEnabled = false;
         this.FProcessorSounds.Visible = false;
         this.ConstructMountPoints();
         this.FProcessorLogin = new TProcessorLogin(this);
         this.FProcessorLogin.Load();
         this.FProcessorLogin.OnLogining = this.ProcessorLoginOnLogining;
         this.FProcessorLogin.OnLogingError = this.ProcessorLoginOnLogingError;
         this.FProcessorLogin.OnLoggedIn = this.ProcessorLoginOnLoggedIn;
         this.FProcessorLogin.OnConnectionDrop = this.ProcessorLoginOnConnectionDrop;
         this.FProcessorBattle = new TBattleHandle(this);
         this.FProcessorBattle.OnQuit = this.ProcessorBattleOnQuit;
         this.FProcessorBattle.TurnBackBattleScene = this.ProcessorTurnBackBattleScene;
         this.FProcessorBattle.TurnBackKillHero = this.ProcessorTurnBackKillHero;
         this.FProcessorBattle.TurnBackArena = this.ProcessorTurnBackArena;
         this.FProcessorBattle.TurnBackTreasureMap = this.ProcessorTurnBackTreasureMap;
         this.FProcessorBattle.TurnBackCityDefend = this.ProcessorTurnBackCityDefend;
         this.FProcessorBattle.TurnBackFightPet = this.ProcessorTurnBackFightPet;
         this.FProcessorBattle.TurnBackTraitorAttack = this.ProcessorTurnBackTraitorAttack;
         this.FProcessorBattle.TurnBackSlave = this.ProcessorTurnBackSlave;
         this.FProcessorBattle.TurnBackSevenKing = this.ProcessorTurnBackSevenKing;
         this.FProcessorBattle.TurnBackCrossServerWar = this.ProcessorTurnBackCrossServerWar;
         this.FProcessorBattle.TurnBackMagic = this.ProcessorTurnBackMagic;
         this.FProcessorBattle.TurnBackTower = this.ProcessorTurnBackTower;
         this.FProcessorBattle.TurnBackPalace = this.ProcessorTurnBackPalace;
         this.FProcessorBattle.TurnBackOrganizationBoss = this.ProcessorTurnBackOrganizationBoss;
         this.FProcessorBattle.TurnBackFriend = this.ProcessorTurnBackFriend;
         this.FProcessorBattle.TurnBackBloodSoul = this.ProcessorTurnBackBloodSoul;
         this.FProcessorBattle.TurnBackSixFairy = this.ProcessorTurnBackSixFairy;
         this.FProcessorBattle.TurnBackUndertown = this.ProcessorTurnBackUndertown;
         this.FProcessorBattle.TurnBackMiGong = this.ProcessorTurnBackMiGong;
         this.FProcessorBattle.TurnBackRebirthRealm = this.ProcessorTurnBackRebirthRealm;
         this.FProcessorBattle.TurnBackTransmigrationTrial = this.ProcessorTurnBackTransmigrationTrial;
         this.FProcessorBattle.TurnBackTaboo = this.ProcessorTurnBackTaboo;
         this.FProcessorBattle.TurnBackTransmigrationAccessory = this.ProcessorTurnBackTransmigrationAccessory;
         this.FProcessorBattle.TurnBackMasterRoad = this.ProcessorTurnBackMasterRoad;
         this.FProcessorBattle.TurnBackChallenge = this.ProcessorTurnBackChallenge;
         this.FProcessorBattle.TurnBackWing = this.ProcessorTurnBackWing;
         this.FProcessorBattle.TurnBackAlien = this.ProcessorTurnBackAlien;
         this.FProcessorBattle.TurnBackQiecuo = this.ProcessorTurnBackQiecuo;
         this.FProcessorBattle.TurnBackGlobalBattle = this.ProcessorTurnBackGlobalBattle;
         this.FProcessorBattle.TurnBackWorldMatch = this.ProcessorTurnBackWorldMatch;
         this.FProcessorBattle.TurnBackSummonBattle = this.ProcessorTurnBackSummonBattle;
         this.FProcessorBattle.TurnBackChallengeCamp = this.ProcessorTurnBackChallengeCamp;
         this.FProcessorBattle.TurnBackGlobalBoss = this.ProcessorTurnBackGlobalBoss;
         this.FProcessorBattle.TurnBackCrossSlave = this.ProcessorTurnBackCrossSlave;
         this.FProcessorBattle.ProcessorCheckPlot = this.ProcessorCheckPlot;
         this.FProcessorBattle.UseSkipCardReq = this.ProcessorUseSkipCardReq;
         this.FProcessorBattle.visible = false;
         this.FProcessorGroupBattle = new TGroupBattleStage(this);
         this.FProcessorGroupBattle.OnQuit = this.ProcessorGroupBattleOnQuit;
         this.FProcessorGroupBattle.TurnBackRoom = this.ProcessorTurnBackRoom;
         this.FProcessorGroupBattle.OnInitGroupBattle = this.ProcessorOnInitGroupBattle;
         this.FProcessorGroupBattle.Visible = false;
         this.FProcessorTopTeamBattle = new TTopTeamStage(this);
         this.FProcessorTopTeamBattle.OnQuit = this.ProcessorTopTeamOnQuit;
         this.FProcessorTopTeamBattle.TurnBackTopTeam = this.ProcessorTurnBackTopTeam;
         this.FProcessorTopTeamBattle.Visible = false;
         this.FProcessorLobby = new TProcessorLobby(this);
         this.FProcessorLobby.OnLoadFollowUp = this.ProcessorOnLoadFollowUp;
         this.FProcessorLobby.OnSetupBattle = this.ProcessorLobbyOnSetupBattle;
         this.FProcessorLobby.OnSetupGroupBattle = this.ProcessorLobbyOnSetupGroupBattle;
         this.FProcessorLobby.OnSetupTopTeamBattle = this.ProcessorLobbyOnSetupTopTeamBattle;
         this.FProcessorLobby.OnQueryBattleActive = this.ProcessorLobbyOnQueryBattleActive;
         this.FProcessorLobby.OnQueryBattleLoading = this.ProcessorLobbyOnQueryBattleLoading;
         this.FProcessorLobby.SetSceneBitmapData = this.SetBattleStageBgByBitmapData;
         this.FProcessorLobby.ProcessorCheckPlot = this.ProcessorCheckPlot;
         this.FProcessorLobby.ProcessorPlayView = this.ProcessorPlayView;
         this.FProcessorLobby.OnUnLoadResource = this.OnUnLoadResource;
         this.FProcessorLobby.SetStatusType = this.SetStatusType;
         this.FProcessorLobby.SetMonsterCount = this.SetMonsterCount;
         this.FProcessorLobby.SetBattlePacket = this.SetBattlePacket;
         this.FProcessorLobby.OnAntiAddiction = this.ProcessorOnAntiAddiction;
         this.FProcessorLobby.OnMarquee = this.ProcessorOnMarquee;
         this.FProcessorLobby.OnTyphon = this.ProcessorOnTyphon;
         this.FProcessorLobby.OnOpenSocketLoading = this.ProcessorOnOpenSocketLoading;
         this.FProcessorLobby.OnCloseSocketLoading = this.ProcessorOnCloseSocketLoading;
         this.FProcessorLobby.EndBattle = this.ProcessorEndBattle;
         this.FProcessorLobby.HideMarquee = this.ProcessorOnHideMarquee;
         this.FProcessorLobby.SetGroupBattleType = this.SetGroupBattleType;
         this.FProcessorLobby.SetGroupBattleInfor = this.SetGroupBattleInfor;
         this.FProcessorLobby.SetGroupBattleReward = this.SetGroupBattleReward;
         this.FProcessorLobby.SetTopTeamBattleType = this.SetTopTeamBattleType;
         this.FProcessorLobby.SetTopTeamBattleInfor = this.SetTopTeamBattleInfor;
         this.FProcessorLobby.SetTopTeamBattleReward = this.SetTopTeamBattleReward;
         this.FProcessorLobby.SetGlobalBattleScore = this.SetGlobalBattleScore;
         this.FProcessorLobby.SetGlobalboss = this.SetGlobalboss;
         this.FProcessorLobby.OnGarbageCollector = this.ProcessorOnGarbageCollector;
         this.FProcessorLobby.BeginSkillShow = this.BeginSkillShow;
         this.FProcessorLobby.Visible = false;
         if(SParametersCore.IsNewUser)
         {
            this.FProcessorCreateChar = new TProcessorCreateRole(this);
            this.FProcessorCreateChar.Load();
            this.FProcessorCreateChar.OnEffectText = this.ProcessorsOnEffectText;
            this.FProcessorCreateChar.Visible = false;
         }
         this.ConstructProcessorsSocketLoading();
         this.FProcessorPlot = new TProcessorPlot(this);
         this.FProcessorPlot.visible = false;
         this.FUIWindowInformation = new TUIWindowInformation(this);
         this.FUIWindowInformation.OnOK = this.WindowApprisalOnOK;
         this.FUIWindowInformation.ButtonOkCaption = STRING_COMMON.COMMON_REFRESH;
         this.FUIWindowInformation.x = (CONST_COMMON.STAGE_Width - this.FUIWindowInformation.WindowWidth) / 2;
         this.FUIWindowInformation.y = (CONST_COMMON.STAGE_Height - this.FUIWindowInformation.WindowHeight) / 2 - 20;
         this.FUIWindowAntiAddictionInformation = new TUIWindowInformation(this);
         this.FUIWindowAntiAddictionInformation.ButtonOkCaption = STRING_COMMON.COMMON_CONFIRM;
         this.FUIWindowAntiAddictionInformation.x = (CONST_COMMON.STAGE_Width - this.FUIWindowAntiAddictionInformation.WindowWidth) / 2;
         this.FUIWindowAntiAddictionInformation.y = (CONST_COMMON.STAGE_Height - this.FUIWindowAntiAddictionInformation.WindowHeight) / 2 - 20;
         this.ConstructProcessorsOverview();
         FResourcesState = RESOURCESSTATE_UIRequest;
      }
      
      protected function ConstructMountPoints() : void
      {
         this.FMountPointOverview = new TProcessorMountPoint(this);
      }
      
      protected function ConstructProcessorsSocketLoading() : void
      {
         this.FProcessorWindowSocketLoading = new TProcessorWindowSocketLoading(this);
         this.FProcessorWindowSocketLoading.Load();
         this.FProcessorWindowSocketLoading.Visible = false;
      }
      
      protected function ConstructProcessorsOverview() : void
      {
         this.FProcessorMarquee = new TProcessorMarquee(this);
         this.FProcessorMarquee.Load();
         this.FProcessorMarquee.X = (CONST_COMMON.STAGE_Width - 800) / 2;
         this.FProcessorMarquee.Y = 130;
         this.FProcessorMarquee.Visible = true;
         this.FProcessorTyphon = new TProcessorTyphon(this);
         this.FProcessorTyphon.Load();
         this.FProcessorTyphon.X = (CONST_COMMON.STAGE_Width - 800) / 2;
         this.FProcessorTyphon.Y = 180;
         this.FProcessorTyphon.Visible = true;
         this.FProcessorEffect = new TProcessorRootEffect(this);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         _loc2_ = int(CONST_FONTLIBRARY.RESOURCESID_Fonts.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = CONST_FONTLIBRARY.RESOURCESID_Fonts[_loc1_];
            SResourcesCore.TexturesSwfFont.LoadPrimary(_loc3_);
            _loc1_++;
         }
         SResourcesCore.TexturesSwfCommon.LoadPrimary(CONST_COMMON.RESOURCESID_Swf_Common);
         SResourcesCore.ResourceBin.LoadPrimary(CONST_DATEBASEVO.RESOURCEID_Base);
         SResourcesCore.TexturesLobby.LoadPrimary(CONST_LOBBY.RESOURCESID_Textures_CURSOR);
         SResourcesCore.TexturesLobby.LoadPrimary(CONST_LOBBY.RESOURCEID_Textures_DefaultRole);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.FFontLibrary = new TFontLibrary();
         TUtilityUIWindow.SetupWindowInformation(this.FUIWindowInformation);
         TUtilityUIWindow.SetupWindowInformation(this.FUIWindowAntiAddictionInformation);
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_CREATECHAR_CreateCharCmd,this.PacketPerform_SC_EnterCreateChar);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_KickErrorCodeRet,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_LOBBY_CREATECHAR_Base,CONST_NETWORK.PACKETID_SC_LOBBY_CREATECHAR_End,this.PacketPerform_ProcessorCreateChar);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SOCKET_Base,CONST_NETWORK.PACKETID_SOCKET_End,this.PacketPerform_ProcessorLogin);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Login_StatusServerTransmitTokenRet,this.PacketPerform_ProcessorLogin);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_BATTLE_Base,CONST_NETWORK.PACKETID_SC_BATTLE_End,this.PacketPerform_ProcessorBattle);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_CHAT_Base,CONST_NETWORK.PACKETID_SC_CHAT_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_LOBBY_COMMON_Base,CONST_NETWORK.PACKETID_SC_LOBBY_COMMON_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_LOBBY_ACCOUNT_Base,CONST_NETWORK.PACKETID_SC_LOBBY_ACCOUNT_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_LOBBY_TOWN_Base,CONST_NETWORK.PACKETID_SC_LOBBY_TOWN_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_LOBBY_HURDLE_Base,CONST_NETWORK.PACKETID_SC_LOBBY_HURDLE_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_LOBBY_WORLDMAP_Base,CONST_NETWORK.PACKETID_SC_LOBBY_WORLDMAP_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_Arena_Base,CONST_NETWORK.PACKETID_SC_Arena_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_TreasureMap_Base,CONST_NETWORK.PACKETID_SC_TreasureMap_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_Tavern_Base,CONST_NETWORK.PACKETID_SC_Tavern_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_GENERALSTAR_Base,CONST_NETWORK.PACKETID_SC_GENERALSTAR_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_LOBBY_BACKPACK_Base,CONST_NETWORK.PACKETID_SC_LOBBY_BACKPACK_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_LOBBY_HEROS_Base,CONST_NETWORK.PACKETID_SC_LOBBY_HEROS_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_LOBBY_MILITARYRANK_Base,CONST_NETWORK.PACKETID_SC_MILITARYRANK_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_BIGDIPPER_Base,CONST_NETWORK.PACKETID_SC_BIGDIPPER_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_Task_Base,CONST_NETWORK.PACKETID_SC_Task_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_Smithy_Base,CONST_NETWORK.PACKETID_SC_Smithy_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_LOBBY_KILLHEROS_Base,CONST_NETWORK.PACKETID_SC_LOBBY_KILLHEROS_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_HeroSLevel_Base,CONST_NETWORK.PACKETID_SC_HeroSLevel_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_TACTICALDEPLOYMENT_Base,CONST_NETWORK.PACKETID_SC_TACTICALDEPLOYMENT_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_LOBBY_FRIEND_Base,CONST_NETWORK.PACKETID_SC_LOBBY_FRIEND_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_MAIL_Base,CONST_NETWORK.PACKETID_SC_MAIL_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_JADE_Base,CONST_NETWORK.PACKETID_SC_JADE_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_Talisman_Base,CONST_NETWORK.PACKETID_SC_Talisman_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_EQUIP_Base,CONST_NETWORK.PACKETID_SC_EQUIP_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_Pet_Base,CONST_NETWORK.PACKETID_SC_Pet_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_Mall_Base,CONST_NETWORK.PACKETID_SC_Mall_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_Sign_Base,CONST_NETWORK.PACKETID_SC_Sign_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_CopyHero_Base,CONST_NETWORK.PACKETID_SC_CopyHero_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_COUNTER_Base,CONST_NETWORK.PACKETID_SC_COUNTER_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_DailyTask_Base,CONST_NETWORK.PACKETID_SC_DailyTask_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_VIP_Base,CONST_NETWORK.PACKETID_SC_VIP_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_Organization_Base,CONST_NETWORK.PACKETID_SC_Organization_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_INSPECTOR_Base,CONST_NETWORK.PACKETID_SC_INSPECTOR_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_Ramen_Base,CONST_NETWORK.PACKETID_SC_Ramen_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_ACTIVITY_Base,CONST_NETWORK.PACKETID_SC_ACTIVITY_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_Post_Base,CONST_NETWORK.PACKETID_SC_Post_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_CDK_Base,CONST_NETWORK.PACKETID_SC_CDK_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_CityDefend_Base,CONST_NETWORK.PACKETID_SC_CityDefend_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_FightPet_Base,CONST_NETWORK.PACKETID_SC_FightPet_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_OrganizationWar_Base,CONST_NETWORK.PACKETID_SC_OrganizationWar_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_FightingShow_Base,CONST_NETWORK.PACKETID_SC_FightingShow_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_NarutoRoad_Base,CONST_NETWORK.PACKETID_SC_NarutoRoad_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_Lottery_Base,CONST_NETWORK.PACKETID_SC_Lottery_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_SystemActivity_Base,CONST_NETWORK.PACKETID_SC_SystemActivity_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_DragonBoat_Base,CONST_NETWORK.PACKETID_SC_DragonBoat_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_TraitorAttack_Base,CONST_NETWORK.PACKETID_SC_TraitorAttack_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_FrogWallet_Base,CONST_NETWORK.PACKETID_SC_FrogWallet_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_Mentorship_Base,CONST_NETWORK.PACKETID_SC_Mentorship_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_NijiaStar_Base,CONST_NETWORK.PACKETID_SC_NijiaStar_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_FreshGuide_Base,CONST_NETWORK.PACKETID_SC_FreshGuide_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_VIPShop_Base,CONST_NETWORK.PACKETID_SC_VIPShop_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_SevenKing_Base,CONST_NETWORK.PACKETID_SC_SevenKing_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_Dice_Base,CONST_NETWORK.PACKETID_SC_Dice_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_Automate_Base,CONST_NETWORK.PACKETID_SC_Automate_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_Common_Base,CONST_NETWORK.PACKETID_SC_Common_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_ConsumeRank_Base,CONST_NETWORK.PACKETID_SC_ConsumeRank_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_TenTail_Base,CONST_NETWORK.PACKETID_SC_TenTail_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_VIPFreeBuy_Base,CONST_NETWORK.PACKETID_SC_VIPFreeBuy_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_SeventhEvening_Base,CONST_NETWORK.PACKETID_SC_SeventhEvening_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_BaseActivity_Base,CONST_NETWORK.PACKETID_SC_BaseActivity_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_CrossServerWar_Base,CONST_NETWORK.PACKETID_SC_CrossServerWar_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_Title_Base,CONST_NETWORK.PACKETID_SC_Title_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_RechargeRank_Base,CONST_NETWORK.PACKETID_SC_RechargeRank_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_Magic_Base,CONST_NETWORK.PACKETID_SC_Magic_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_Tower_Base,CONST_NETWORK.PACKETID_SC_Tower_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_DailyWelfare_Base,CONST_NETWORK.PACKETID_SC_DailyWelfare_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_DragonHall_Base,CONST_NETWORK.PACKETID_SC_DragonHall_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_NinJaPractice_Base,CONST_NETWORK.PACKETID_SC_JinJaPractice_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_SantaClaus_Base,CONST_NETWORK.PACKETID_SC_SantaClaus_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_UpdateList_Base,CONST_NETWORK.PACKETID_SC_UpdateList_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_BugList_Base,CONST_NETWORK.PACKETID_SC_BugList_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_TongLing_Base,CONST_NETWORK.PACKETID_SC_TongLing_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_TopOrganization_Base,CONST_NETWORK.PACKETID_SC_TopOrganization_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_AnimalSeall_Base,CONST_NETWORK.PACKETID_SC_AnimalSeall_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_GroupBattle_Base,CONST_NETWORK.PACKETID_SC_GroupBattle_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_Accessory_Base,CONST_NETWORK.PACKETID_SC_Accessory_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_BloodSoulPurgatory,CONST_NETWORK.PACKETID_SC_BloodSoulPurgatory_end,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_SixFairyMan,CONST_NETWORK.PACKETID_SC_SixFairyMan_end,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_TopTeam_Base,CONST_NETWORK.PACKETID_SC_TopTeam_end,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_RebirthRealm,CONST_NETWORK.PACKETID_SC_RebirthRealm_end,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_NijiaMystic_Base,CONST_NETWORK.PACKETID_SC_NijiaMystic_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_NarutoHelper_Base,CONST_NETWORK.PACKETID_SC_NarutoHelper_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_Prerogative_Base,CONST_NETWORK.PACKETID_SC_Prerogative_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_NinjaReincarnation,CONST_NETWORK.PACKETID_SC_NinjaReincarnation_end,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_NinjaRelation_Base,CONST_NETWORK.PACKETID_SC_NinjaRelation_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_NinjaHostel_Base,CONST_NETWORK.PACKETID_SC_NinjaHostel_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_BloodFete_Base,CONST_NETWORK.PACKETID_SC_BloodFete_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_BaiDuMM_Base,CONST_NETWORK.PACKETID_SC_BaiDuMM_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_OhtsutsukiKaguya_Base,CONST_NETWORK.PACKETID_SC_OhtsutsukiKaguya_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_NewMall_Base,CONST_NETWORK.PACKETID_SC_NewMall_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_TransmigrationTrial_Base,CONST_NETWORK.PACKETID_SC_TransmigrationTrial_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_Taboo_Base,CONST_NETWORK.PACKETID_S2C_Taboo_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_VK__Base,CONST_NETWORK.PACKETID_S2C_VK_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_Awaken_Base,CONST_NETWORK.PACKETID_S2C_Awaken_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_TransmigrationAccessory_Base,CONST_NETWORK.PACKETID_SC_TransmigrationAccessory_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_EightDoor_Base,CONST_NETWORK.PACKETID_S2C_EightDoor_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_TheWorldTree_Base,CONST_NETWORK.PACKETID_S2C_World_Tree_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_Undertown_Base,CONST_NETWORK.PACKETID_S2C_Dungeons_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_OnLineLiBao_Base,CONST_NETWORK.PACKETID_S2C_OnLineLiBao_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_ZhenAoYi_Base,CONST_NETWORK.PACKETID_S2C_ZhenAoYi_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_DaShi_Base,CONST_NETWORK.PACKETID_S2C_DaShi_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_ShenQi_Base,CONST_NETWORK.PACKETID_S2C_ShenQi_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_Wing_Base,CONST_NETWORK.PACKETID_SC_Wing_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_Illustrated_Base,CONST_NETWORK.PACKETID_SC_Illustrated_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_Married_Base,CONST_NETWORK.PACKETID_SC_Married_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_COMMON_Base,CONST_NETWORK.PACKETID_SC_COMMON_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_AddSoul_Base,CONST_NETWORK.PACKETID_SC_AddSoul_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_MasterRoad_Base,CONST_NETWORK.PACKETID_SC_MasterRoad_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_Challenge_Base,CONST_NETWORK.PACKETID_SC_Challenge_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_SpeicalJade_Base,CONST_NETWORK.PACKETID_SC_SpecialJade_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Mail_Ret,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_Plane_Base,CONST_NETWORK.PACKETID_SC_Plane_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_NinjaAwake_Ret,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_AwakeSkill_Ret,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_CrossRank_Ret,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_CrossUser_Ret,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_CrossFight_Ret,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_KingWar_Base,CONST_NETWORK.PACKETID_SC_KingWar_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_Rune_Base,CONST_NETWORK.PACKETID_SC_Rune_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_InviteCode_Base,CONST_NETWORK.PACKETID_SC_InviteCode_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_Elements_Base,CONST_NETWORK.PACKETID_SC_Elements_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_Warehouse_Base,CONST_NETWORK.PACKETID_SC_Warehouse_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_Discord_Base,CONST_NETWORK.PACKETID_SC_Discord_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_GlobalBattle_Base,CONST_NETWORK.PACKETID_SC_GlobalBattle_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_NewShop_Base,CONST_NETWORK.PACKETID_SC_NewShop_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_ConsumeVip_Base,CONST_NETWORK.PACKETID_SC_ConsumeVip_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_Emblem_Base,CONST_NETWORK.PACKETID_SC_Emblem_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_WorldMatch_Base,CONST_NETWORK.PACKETID_SC_WorldMatch_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_ChristmasDay_Base,CONST_NETWORK.PACKETID_SC_ChristmasDay_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_SummonBattle_Base,CONST_NETWORK.PACKETID_SC_SummonBattle_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_NinjaTalent_Base,CONST_NETWORK.PACKETID_SC_NinjaTalent_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_ChallengeCamp_Base,CONST_NETWORK.PACKETID_SC_ChallengeCamp_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_LevelGifts_Base,CONST_NETWORK.PACKETID_SC_LevelGifts_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_WorldMatchStreak_Base,CONST_NETWORK.PACKETID_SC_WorldMatchStreak_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_GlobalBoss_Base,CONST_NETWORK.PACKETID_SC_GlobalBoss_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_DayRechargeGift_Base,CONST_NETWORK.PACKETID_SC_DayRechargeGift_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_Recruit_Base,CONST_NETWORK.PACKETID_SC_Recruit_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_Slave_Base,CONST_NETWORK.PACKETID_SC_Slave_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_RefreshTalent_Base,CONST_NETWORK.PACKETID_SC_RefreshTalent_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.RegisterRange(CONST_NETWORK.PACKETID_SC_LeadLevelGifts_Base,CONST_NETWORK.PACKETID_SC_LeadLevelGifts_End,this.PacketPerform_ProcessorLobby);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_NewMallRefrese_Ret,this.PacketPerform_ProcessorLobby);
      }
      
      protected function PacketPerform_SC_EnterCreateChar(param1:TPacket) : void
      {
         this.FProcessorCreateChar.Visible = true;
         SExternalCore.GameStatistical(CONST_ACCOUNT.STATISTICALSETP_CreateChar);
      }
      
      protected function PacketPerform_ProcessorCreateChar(param1:TPacket) : void
      {
         this.FProcessorCreateChar.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorLogin(param1:TPacket) : void
      {
         this.FProcessorLogin.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorBattle(param1:TPacket) : void
      {
         this.FProcessorBattle.PacketProcess(param1);
      }
      
      protected function PacketPerform_ProcessorLobby(param1:TPacket) : void
      {
         this.FProcessorLobby.PacketProcess(param1);
      }
      
      override protected function AffairRegisterRoutines() : void
      {
         super.AffairRegisterRoutines();
         FAffairRoutines.Register(AFFAIRID_ConnectionDrop,this.AffairPerform_ConnectionDrop);
      }
      
      protected function AffairPerform_ConnectionDrop(param1:TAffair) : void
      {
         var DropLog:Function = null;
         var Affair:TAffair = param1;
         DropLog = function(param1:String, param2:uint, param3:uint):void
         {
            SExternalCore.GameDropLog(SParametersCore.AgentID + ";" + SParametersCore.ServerID + ";" + SParametersCore.OperatorUserID + ";" + SLogicsCore.Character.RoleSencePosition + ";" + SNetworkCore.Transceiver.ServerHost + ";" + SNetworkCore.Transceiver.ServerPort + ";" + param3 + ";" + Capabilities.version + ";");
         };
         this.ProcessorOnCloseSocketLoading(null);
         if(!SLogicsCore.IsKicked)
         {
            this.FUIWindowInformation.Text = STRING_COMMON.COMMON_DROPPED;
            this.FUIWindowInformation.Visible = true;
            SSocketSpeed.EndCallBack = DropLog;
            SSocketSpeed.Clear();
            SSocketSpeed.AddServerInfo(SNetworkCore.Transceiver.ServerHost,SNetworkCore.Transceiver.ServerPort);
            SSocketSpeed.Start();
         }
         else
         {
            DropLog("",0,0);
         }
      }
      
      protected function ProcessorOnMarquee(param1:Object, param2:Object) : void
      {
         this.FProcessorMarquee.StartMarquee(param2);
      }
      
      protected function ProcessorOnHideMarquee() : void
      {
         this.FProcessorMarquee.HideMarquee();
      }
      
      protected function ProcessorOnTyphon(param1:Object, param2:Object) : void
      {
         this.FProcessorTyphon.StartMarquee(param2);
      }
      
      protected function ProcessorOnOpenSocketLoading(param1:Object) : void
      {
         this.FProcessorWindowSocketLoading.ShowLoading();
      }
      
      protected function ProcessorOnCloseSocketLoading(param1:Object) : void
      {
         this.FProcessorWindowSocketLoading.HideLoading();
      }
      
      protected function ProcessorEndBattle(param1:Object) : void
      {
         this.FProcessorBattle.EndBattle();
      }
      
      protected function WindowAntiAddictionInformationOnOK(param1:Object) : void
      {
         SExternalCore.ReloadGame();
      }
      
      protected function WindowApprisalOnOK(param1:Object) : void
      {
         SExternalCore.ReloadGame();
      }
      
      protected function ProcessorLoginOnLogining(param1:Object) : void
      {
         if(!SParametersCore.IsNewUser && !SResourcesCore.LoadingPrimary)
         {
            this.ProcessorOnOpenSocketLoading(null);
         }
      }
      
      protected function ProcessorLoginOnLogingError(param1:Object) : void
      {
         this.ProcessorOnCloseSocketLoading(null);
      }
      
      protected function ProcessorLoginOnLoggedIn(param1:Object) : void
      {
         this.FProcessorLogin.Visible = false;
         this.FProcessorLobby.Visible = true;
         this.FProcessorBattle.Visible = false;
         this.FProcessorGroupBattle.Visible = false;
         this.FProcessorTopTeamBattle.Visible = false;
         if(!SParametersCore.IsNewUser)
         {
            this.ProcessorOnOpenSocketLoading(null);
         }
      }
      
      protected function ProcessorLoginOnConnectionDrop(param1:Object) : void
      {
         FAffairGenerator.Generate(AFFAIRID_ConnectionDrop);
      }
      
      protected function ProcessorOnAntiAddiction(param1:Object, param2:int) : void
      {
         var _loc3_:uint = 0;
         var _loc4_:String = null;
         var _loc5_:TSystemLanguage = null;
         _loc3_ = CONST_SYSTEMLANGUAGE.ANTIADDICTIONS[param2 - 1];
         _loc5_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,_loc3_) as TSystemLanguage;
         _loc4_ = _loc5_.Desc;
         this.FUIWindowAntiAddictionInformation.Text = _loc4_;
         if(param2 == CONST_INSPECTOR.TIME_AntiAddictionUpperLimit)
         {
            this.FUIWindowAntiAddictionInformation.OnOK = this.WindowAntiAddictionInformationOnOK;
         }
         else
         {
            this.FUIWindowAntiAddictionInformation.OnOK = null;
         }
         this.FUIWindowAntiAddictionInformation.visible = true;
      }
      
      protected function ProcessorsOnEffectText(param1:Object, param2:String, param3:TEffectTextParameters = null, param4:TEffectCoordinateParameters = null, param5:uint = 5) : void
      {
         this.FProcessorEffect.ImportText(param2,param3,param4,param5);
      }
      
      protected function ProcessorBattleOnQuit(param1:Object, param2:int, param3:Boolean) : void
      {
         this.FProcessorLobby.ProcessorOnSwitchLobbyFromBattle(param1,param2,param3);
         this.FProcessorBattle.Visible = false;
         this.FProcessorLobby.Visible = true;
      }
      
      protected function ProcessorGroupBattleOnQuit(param1:Object, param2:int, param3:Boolean) : void
      {
         this.FProcessorLobby.ProcessorOnSwitchLobbyFromGroupBattle(param1,param2,param3);
         this.FProcessorGroupBattle.Visible = false;
         this.FProcessorLobby.Visible = true;
         this.FProcessorGroupBattle.Release();
      }
      
      protected function ProcessorTopTeamOnQuit(param1:Object) : void
      {
         this.FProcessorLobby.ProcessorOnSwitchLobbyFromTopTeam(param1);
         this.FProcessorTopTeamBattle.Visible = false;
         this.FProcessorLobby.Visible = true;
         this.FProcessorTopTeamBattle.Release();
      }
      
      protected function ProcessorTurnBackBattleScene(param1:Object, param2:Boolean) : void
      {
         this.FProcessorLobby.TurnBackBattleScene(param1,param2);
      }
      
      protected function ProcessorTurnBackKillHero(param1:Object, param2:Boolean, param3:int) : void
      {
         this.FProcessorLobby.TurnBackKillHero(param1,param2,param3);
      }
      
      protected function ProcessorTurnBackArena(param1:Object) : void
      {
         this.FProcessorLobby.TurnBackArena(param1);
      }
      
      protected function ProcessorTurnBackTreasureMap(param1:Object, param2:Boolean) : void
      {
         this.FProcessorLobby.TurnBackTreasureMap(param1,param2);
      }
      
      protected function ProcessorTurnBackCityDefend(param1:Object) : void
      {
         this.FProcessorLobby.TurnBackCityDefend(param1);
      }
      
      protected function ProcessorTurnBackFightPet(param1:Object) : void
      {
         this.FProcessorLobby.TurnBackFightPet(param1);
      }
      
      protected function ProcessorTurnBackTraitorAttack(param1:Object) : void
      {
         this.FProcessorLobby.TurnBackTraitorAttack(param1);
      }
      
      protected function ProcessorTurnBackSlave(param1:Object) : void
      {
         this.FProcessorLobby.TurnBackSlave(param1);
      }
      
      protected function ProcessorTurnBackSevenKing(param1:Object) : void
      {
         this.FProcessorLobby.TurnBackSevenKing(param1);
      }
      
      protected function ProcessorTurnBackCrossServerWar(param1:Object, param2:Boolean) : void
      {
         this.FProcessorLobby.TurnBackCrossServerWar(param1,param2);
      }
      
      protected function ProcessorTurnBackMagic(param1:Object) : void
      {
         this.FProcessorLobby.TurnBackMagic(param1);
      }
      
      protected function ProcessorTurnBackTower(param1:Object) : void
      {
         this.FProcessorLobby.TurnBackTower(param1);
      }
      
      protected function ProcessorTurnBackPalace(param1:Object) : void
      {
         this.FProcessorLobby.TurnBackPalace(param1);
      }
      
      protected function ProcessorTurnBackOrganizationBoss(param1:Object, param2:Boolean) : void
      {
         this.FProcessorLobby.TurnBackOrganizationBoss(param1,param2);
      }
      
      protected function ProcessorTurnBackFriend(param1:Object) : void
      {
         this.FProcessorLobby.TurnBackFriend(param1);
      }
      
      protected function ProcessorTurnBackBloodSoul(param1:Object) : void
      {
         this.FProcessorLobby.TurnBackBloodSoul(param1);
      }
      
      protected function ProcessorTurnBackSixFairy(param1:Object) : void
      {
         this.FProcessorLobby.TurnBackSixFairy(param1);
      }
      
      protected function ProcessorTurnBackUndertown(param1:Object) : void
      {
         this.FProcessorLobby.TurnBackUndertown(param1);
      }
      
      protected function ProcessorTurnBackMiGong(param1:Object) : void
      {
         this.FProcessorLobby.TurnBackMiGong(param1);
      }
      
      protected function ProcessorTurnBackRebirthRealm(param1:Object) : void
      {
         this.FProcessorLobby.TurnBackRebirthRealm(param1);
      }
      
      protected function ProcessorTurnBackTransmigrationTrial(param1:Object) : void
      {
         this.FProcessorLobby.TurnBackTransmigrationTrial(param1);
      }
      
      protected function ProcessorTurnBackTaboo(param1:Object) : void
      {
         this.FProcessorLobby.TurnBackTaboo(param1);
      }
      
      protected function ProcessorTurnBackTransmigrationAccessory(param1:Object) : void
      {
         this.FProcessorLobby.TurnBackTransmigrationAccessory(param1);
      }
      
      protected function ProcessorTurnBackRoom(param1:Object) : void
      {
         this.FProcessorLobby.TurnBackRoom(param1);
      }
      
      protected function ProcessorTurnBackTopTeam(param1:Object) : void
      {
         this.FProcessorLobby.TurnBackTopTeam(param1);
      }
      
      protected function ProcessorTurnBackMasterRoad(param1:Object) : void
      {
         this.FProcessorLobby.TurnBackMasterRoad(param1);
      }
      
      protected function ProcessorTurnBackChallenge(param1:Object) : void
      {
         this.FProcessorLobby.TurnBackChallenge(param1);
      }
      
      protected function ProcessorTurnBackWing(param1:Object) : void
      {
         this.FProcessorLobby.TurnBackWing(param1);
      }
      
      protected function ProcessorTurnBackAlien(param1:Object) : void
      {
         this.FProcessorLobby.TurnBackAlien(param1);
      }
      
      protected function ProcessorTurnBackQiecuo(param1:Object) : void
      {
         this.FProcessorLobby.TurnBackQiecuo(param1);
      }
      
      protected function ProcessorTurnBackGlobalBattle(param1:Object) : void
      {
         this.FProcessorLobby.TurnBackGlobalBattle(param1);
         this.FProcessorBattle.SetGlobalBattleScore();
      }
      
      protected function ProcessorTurnBackWorldMatch(param1:Object) : void
      {
         this.FProcessorLobby.TurnBackWorldMatch(param1);
      }
      
      protected function ProcessorTurnBackSummonBattle(param1:Object) : void
      {
         this.FProcessorLobby.TurnBackSummonBattle(param1);
      }
      
      protected function ProcessorTurnBackChallengeCamp(param1:Object) : void
      {
         this.FProcessorLobby.TurnBackChallengeCamp(param1);
      }
      
      protected function ProcessorTurnBackGlobalBoss(param1:Object) : void
      {
         this.FProcessorLobby.TurnBackGlobalBoss(param1);
      }
      
      protected function ProcessorTurnBackCrossSlave(param1:Object) : void
      {
         this.FProcessorLobby.TurnBackCrossSlave(param1);
      }
      
      protected function ProcessorOnInitGroupBattle(param1:Object) : void
      {
         this.FProcessorLobby.OnInitGroupBattle(param1);
      }
      
      protected function SetBattleStageBgByBitmapData(param1:Object, param2:BitmapData) : void
      {
         this.FProcessorBattle.SetBattleStageBgByBitmapData(param1,param2);
      }
      
      protected function ProcessorCheckPlot(param1:Object, param2:uint, param3:uint, param4:uint, param5:Function = null) : void
      {
         this.FProcessorPlot.CheckPlot(param2,param3,param4,param5);
      }
      
      protected function ProcessorUseSkipCardReq(param1:Object, param2:uint, param3:uint) : void
      {
         var _loc4_:TPacket = null;
         var _loc5_:ByteArray = null;
         _loc4_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Backpack_UseAppliance);
         _loc5_ = _loc4_.Data;
         _loc5_.writeShort(1);
         _loc5_.writeUnsignedInt(param2);
         _loc5_.writeShort(param3);
         _loc5_.writeUnsignedInt(0);
         SNetworkCore.Transceiver.PacketTransmit(_loc4_);
      }
      
      protected function ProcessorPlayView(param1:Object, param2:int, param3:int) : void
      {
         this.FProcessorPlot.SetPlot(param2,param3);
      }
      
      protected function OnUnLoadResource(param1:Object) : void
      {
         this.FProcessorBattle.UnLoadResources();
      }
      
      protected function SetStatusType(param1:Object, param2:int, param3:int, param4:Boolean, param5:Boolean, param6:Boolean) : void
      {
         this.FProcessorBattle.SetStatusType(param2,param3,param4,param5,param6);
      }
      
      protected function SetMonsterCount(param1:Object, param2:uint) : void
      {
         this.FProcessorBattle.SetMonsterCount(param2);
      }
      
      protected function SetBattlePacket(param1:Object, param2:TPacket) : void
      {
         this.FProcessorBattle.SetBattlePacket(param1,param2);
      }
      
      protected function SetGroupBattleType(param1:Object, param2:ByteArray) : void
      {
         this.FProcessorGroupBattle.SetGroupBattleType(param1,param2);
      }
      
      protected function SetGroupBattleInfor(param1:Object, param2:ByteArray) : void
      {
         this.FProcessorGroupBattle.SetGroupBattleInfor(param1,param2);
      }
      
      protected function SetGroupBattleReward(param1:Object, param2:ByteArray) : void
      {
         this.FProcessorGroupBattle.SetGroupBattleReward(param1,param2);
      }
      
      protected function SetTopTeamBattleType(param1:Object, param2:ByteArray) : void
      {
         this.FProcessorTopTeamBattle.SetTopTeamBattleType(param1,param2);
      }
      
      protected function SetTopTeamBattleInfor(param1:Object, param2:ByteArray) : void
      {
         this.FProcessorTopTeamBattle.SetTopTeamBattleInfor(param1,param2);
      }
      
      protected function SetTopTeamBattleReward(param1:Object, param2:ByteArray) : void
      {
         this.FProcessorTopTeamBattle.SetTopTeamBattleReward(param1,param2);
      }
      
      protected function SetGlobalBattleScore(param1:int) : void
      {
         this.FProcessorBattle.SetGlobalBattleScore(param1);
      }
      
      protected function SetGlobalboss(param1:TGlobalboss) : void
      {
         this.FProcessorBattle.SetGlobalboss(param1);
      }
      
      protected function ProcessorOnGarbageCollector() : void
      {
         if(this.FOnGarbageCollector != null)
         {
            this.FOnGarbageCollector();
         }
      }
      
      protected function ProcessorOnLoadFollowUp(param1:Object) : void
      {
         if(SParametersCore.IsNewUser)
         {
            if(this.FProcessorCreateChar != null)
            {
               this.FProcessorCreateChar.Visible = false;
            }
         }
      }
      
      protected function ProcessorLobbyOnSetupBattle(param1:Object, param2:TChatOptions) : void
      {
         this.FProcessorBattle.ChatOptionsSetup(param2);
         this.FProcessorBattle.Visible = true;
      }
      
      protected function ProcessorLobbyOnSetupGroupBattle(param1:Object, param2:TChatOptions) : void
      {
         this.FProcessorGroupBattle.ChatOptionsSetup(param2);
         this.FProcessorGroupBattle.Visible = true;
      }
      
      protected function ProcessorLobbyOnSetupTopTeamBattle(param1:Object, param2:TChatOptions) : void
      {
         this.FProcessorTopTeamBattle.ChatOptionsSetup(param2);
         this.FProcessorTopTeamBattle.Visible = true;
      }
      
      protected function ProcessorLobbyOnQueryBattleActive(param1:Object, param2:TQueryBoolean) : void
      {
         param2.Value = this.FProcessorBattle.Active || this.FProcessorGroupBattle.Active || this.FProcessorTopTeamBattle.Active;
      }
      
      protected function ProcessorLobbyOnQueryBattleLoading(param1:Object, param2:TQueryBoolean) : void
      {
         param2.Value = this.FProcessorBattle.Loading || this.FProcessorGroupBattle.Loading || this.FProcessorTopTeamBattle.Loading;
      }
      
      public function get OnGarbageCollector() : Function
      {
         return this.FOnGarbageCollector;
      }
      
      public function set OnGarbageCollector(param1:Function) : void
      {
         this.FOnGarbageCollector = param1;
      }
      
      protected function BeginSkillShow(param1:uint) : void
      {
         this.FProcessorBattle.EnterType = 4;
         this.FProcessorBattle.SetTestId(param1,"","");
         this.FProcessorLobby.Visible = false;
      }
   }
}

