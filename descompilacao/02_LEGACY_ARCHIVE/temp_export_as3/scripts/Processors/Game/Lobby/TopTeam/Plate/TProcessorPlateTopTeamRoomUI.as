package Processors.Game.Lobby.TopTeam.Plate
{
   import Foundation.Common.THint;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.Characters.TFriendDigest;
   import Logics.Characters.TFriendDigests;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.GroupBattle.TInviteShadow;
   import Logics.GroupBattle.TRoomPlayer;
   import Logics.GroupBattle.TRoomPlayers;
   import Logics.SLogicsCore;
   import Logics.Spaces.LogicsSpace;
   import Logics.TopTeam.TTopTeamData;
   import Logics.TopTeam.TTopTeamRoomDetailInfo;
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
   import Processors.Game.Lobby.TopTeam.Component.TUIPlayerStatus;
   import Processors.Game.Lobby.TopTeam.Component.TUIRoomPlayer;
   import Processors.Game.Windows.Information.TUIWindowConfirmation;
   import Rendering.Overlayers.HelpTips.TOverlayerHelpTips;
   import Resources.Constants.CONST_CHAT;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_CONFIGVALUE;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_FRIEND;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Constants.CONST_TOPTEAM;
   import Resources.Strings.STRING_CHAT;
   import Resources.Strings.STRING_TOPTEAM;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.FocusEvent;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.utils.ByteArray;
   
   use namespace LogicsSpace;
   
   public class TProcessorPlateTopTeamRoomUI extends TProcessorLobbyPlate
   {
      
      protected var FMainUI:Sprite;
      
      protected var FTF_RoomID:TextField;
      
      protected var FMC_BasicInfo:MovieClip;
      
      protected var FTF_ActivityEndTime:TextField;
      
      protected var FTF_RestPlayCount:TextField;
      
      protected var FTF_WinCount:TextField;
      
      protected var FTF_TotalScore:TextField;
      
      protected var FTF_RewardScore:TextField;
      
      protected var FTF_TotayObtainNinjaPoint:TextField;
      
      protected var FTF_CurrentRank:TextField;
      
      protected var FTF_CurrentNinjaPoint:TextField;
      
      protected var FMC_Invite:MovieClip;
      
      protected var FTF_Population:TextField;
      
      protected var FTF_Password:TextField;
      
      protected var FMC_Option:MovieClip;
      
      protected var FMC_Start:MovieClip;
      
      protected var FTF_Start:TextField;
      
      protected var FMC_Exit:MovieClip;
      
      protected var FBTN_Close:SimpleButton;
      
      protected var FBTN_Help:SimpleButton;
      
      protected var FMC_AutoStartOption:MovieClip;
      
      protected var FTF_ServerName:TextField;
      
      protected var FTF_AutoBattle:TextField;
      
      protected var FMC_Matching:MovieClip;
      
      protected var FTF_Matching:TextField;
      
      protected var FMC_Mask:MovieClip;
      
      protected var FMC_NinjaPointMall:MovieClip;
      
      protected var FUIRoomPlayerInfos:Vector.<TUIRoomPlayer>;
      
      protected var FUIHeroStatusInfos:Vector.<TUIPlayerStatus>;
      
      protected var FMCChangePostionArrows:Vector.<MovieClip>;
      
      protected var FUIWindowConfirmation:TUIWindowConfirmation;
      
      protected var FProcessorTopTeamInviteList:TProcessorTopTeamInviteList;
      
      protected var FUIWindowCapatainConfirmation:TUIWindowConfirmation;
      
      protected var FBFocus:Boolean;
      
      protected var FPassword:String;
      
      protected var FHelpTips:THint;
      
      protected var FTopTeamData:TTopTeamData;
      
      protected var FFriends:TFriendDigests;
      
      protected var FCharacterDigest:TFriendDigest;
      
      protected var FMaskStartMatch:Sprite;
      
      protected var FStartTime:uint;
      
      protected var FMatchSign:Boolean;
      
      protected var FCheckIsAllReady:Boolean;
      
      protected var FActivityTimes:uint;
      
      protected var FActivityEndTimes:Vector.<uint>;
      
      protected var FArr:Vector.<Object>;
      
      protected var FIdentifier0:uint;
      
      protected var FIdentifier1:uint;
      
      protected var FApproveCaptain:Boolean;
      
      protected var FOverlayerHelpTips:TOverlayerHelpTips;
      
      protected var FOnReturnMainScene:Function;
      
      protected var FShowOtherHeroInfor:Function;
      
      protected var FRequestWhisper:Function;
      
      protected var FOnSetGroupBattleChannel:Function;
      
      protected var FNinjaPointMallOnClick:Function;
      
      protected var FOnInterpersonalRelationships:Function;
      
      public function TProcessorPlateTopTeamRoomUI(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.Init();
      }
      
      protected function Init() : void
      {
         this.FUIRoomPlayerInfos = new Vector.<TUIRoomPlayer>(CONST_TOPTEAM.CAPACITY_Heros);
         this.FUIHeroStatusInfos = new Vector.<TUIPlayerStatus>(CONST_TOPTEAM.CAPACITY_Heros);
         this.FTopTeamData = SLogicsCore.TopTeamData;
         this.FFriends = SLogicsCore.Friends;
         this.FMCChangePostionArrows = new Vector.<MovieClip>(2);
         this.FCharacterDigest = new TFriendDigest(0,0);
         this.FHelpTips = new THint();
         this.FActivityEndTimes = new Vector.<uint>();
         this.FMaskStartMatch = new Sprite();
         this.FMatchSign = false;
         this.FApproveCaptain = false;
         this.FPassword = "";
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_TOPTEAM.RESOURCESID_Swf_TOPTEAM);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:TextFormat = null;
         this.FMainUI = TUtilityReflection.CreateDisplayObjectInstance("MC_TopTeamRoomUI") as Sprite;
         addChild(this.FMainUI);
         addChild(this.FMaskStartMatch);
         this.FMaskStartMatch.visible = false;
         this.FProcessorTopTeamInviteList = new TProcessorTopTeamInviteList(this);
         this.FProcessorTopTeamInviteList.WorldInviteOnClick = this.ProcessorWorldInviteOnClick;
         this.FProcessorTopTeamInviteList.RapidInviteOnClick = this.ProcessorRapidInviteOnClick;
         this.FProcessorTopTeamInviteList.InviteOnClick = this.ProcessorInviteOnClick;
         this.UIDispatchHeroHeadInfo();
         this.UIDispatchHeroStatus();
         this.UIDispatchOtherInfo();
         this.FOverlayerHelpTips = new TOverlayerHelpTips(this);
         this.FOverlayerHelpTips.Visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerHelpTips);
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:MovieClip = null;
         this.FMC_Option.addEventListener(MouseEvent.CLICK,this.MCOptionOnClick,false,0,true);
         this.FMC_AutoStartOption.addEventListener(MouseEvent.CLICK,this.MCAutoStartOptionOnClick,false,0,true);
         this.FMC_Invite.addEventListener(MouseEvent.CLICK,this.MCInviteOnClick,false,0,true);
         this.FMC_Start.addEventListener(MouseEvent.CLICK,this.MCStartOnClick,false,0,true);
         this.FMC_Exit.addEventListener(MouseEvent.CLICK,this.MCExitOnClick,false,0,true);
         this.FBTN_Close.addEventListener(MouseEvent.CLICK,this.BTNCloseOnClick,false,0,true);
         this.FBTN_Help.addEventListener(MouseEvent.MOUSE_OVER,this.ButtonHelpOnOver,false,0,true);
         this.FBTN_Help.addEventListener(MouseEvent.MOUSE_OUT,this.ButtonHelpOnOut,false,0,true);
         this.FMC_NinjaPointMall.addEventListener(MouseEvent.CLICK,this.MCNinjaPointMallOnClick,false,0,true);
         _loc2_ = this.FMCChangePostionArrows.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FMCChangePostionArrows[_loc1_];
            _loc3_.addEventListener(MouseEvent.CLICK,this.MCArrowOnClick,false,0,true);
            _loc1_++;
         }
         this.FTF_Password.addEventListener(FocusEvent.FOCUS_IN,this.OnTextFocusIn);
         this.FTF_Password.addEventListener(FocusEvent.FOCUS_OUT,this.OnTextFocusOut);
         super.ResourcesPerform_UILocations();
      }
      
      override protected function ResourcesPerform_UIFinalize() : void
      {
         var _loc1_:TConfigValue = null;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.TEAMBATTLE_ACTIVITYTIMES) as TConfigValue;
         this.FArr = _loc1_.Value as Vector.<Object>;
         this.FActivityTimes = (this.FArr[1][0] * 60 + this.FArr[1][1] - (this.FArr[0][0] * 60 + this.FArr[0][1])) * 60;
         super.ResourcesPerform_UIFinalize();
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
         if(this.FTopTeamData.IsInBattle)
         {
            return;
         }
         if(this.FCheckIsAllReady)
         {
            _loc2_ = this.CheckIsAllReady();
            if(_loc2_)
            {
               this.MCStartOnClick(null);
            }
         }
         _loc4_ = this.FActivityEndTimes.length;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc1_ = this.FActivityEndTimes[_loc3_] - STimingCore.GetServerTick();
            if(_loc1_ >= 0 && _loc1_ <= this.FActivityTimes)
            {
               _loc1_ = this.FActivityEndTimes[_loc3_] - STimingCore.GetServerTick();
               break;
            }
            _loc3_++;
         }
         if(this.FTF_ActivityEndTime != null)
         {
            this.FTF_ActivityEndTime.text = TGameUtil.fomatTime(_loc1_);
         }
         if(this.FMC_Mask == null || !this.FMC_Mask.visible)
         {
            return;
         }
         _loc1_ = STimingCore.GetServerTick() - this.FStartTime;
         if(this.FTF_Matching != null)
         {
            this.FTF_Matching.text = TUtilityString.Format(STRING_TOPTEAM.FORMAT_Matching,TGameUtil.fomatSmallTime(_loc1_));
         }
      }
      
      protected function UIDispatchHeroHeadInfo() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUIRoomPlayer = null;
         _loc2_ = CONST_TOPTEAM.CAPACITY_Heros;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = new TUIRoomPlayer(this);
            _loc3_.Resource = this.FMainUI["MC_HeroHeadInfo_" + _loc1_];
            _loc3_.Tag = _loc1_;
            _loc3_.HeroInforOnClick = this.ProcessorHeroInforOnClick;
            _loc3_.Init();
            this.FUIRoomPlayerInfos[_loc1_] = _loc3_;
            _loc1_++;
         }
      }
      
      protected function UIDispatchHeroStatus() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUIPlayerStatus = null;
         _loc2_ = CONST_TOPTEAM.CAPACITY_Heros;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = new TUIPlayerStatus(this);
            _loc3_.Resource = this.FMainUI["MC_Hero_" + _loc1_];
            _loc3_.Tag = _loc1_;
            _loc3_.Init();
            this.FUIHeroStatusInfos[_loc1_] = _loc3_;
            _loc1_++;
         }
      }
      
      protected function UIDispatchOtherInfo() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:MovieClip = null;
         this.FMC_BasicInfo = this.FMainUI["MC_BasicInfo"];
         this.FTF_RoomID = this.FMainUI["MC_RoomID"]["TF_RoomID"];
         this.FTF_Population = this.FMC_BasicInfo["TF_Population"];
         this.FMC_Invite = this.FMC_BasicInfo["MC_Invite"];
         TGameUtil.setButtonMode(this.FMC_Invite,true);
         this.FTF_Password = this.FMC_BasicInfo["TF_Password"];
         this.FTF_Password.text = "";
         this.FTF_Password.restrict = "0-9";
         this.FTF_Password.maxChars = 4;
         this.FMC_Mask = this.FMC_BasicInfo["MC_Mask"];
         this.FMC_Mask.visible = false;
         this.FMC_Matching = TUtilityReflection.CreateDisplayObjectInstance("MC_Matching") as MovieClip;
         this.FTF_Matching = this.FMC_Matching["TF_Matching"];
         this.FMC_Mask.addChild(this.FMC_Matching);
         this.FMC_Matching.x = (CONST_COMMON.STAGE_Width - this.FMC_Matching.width) / 2;
         this.FMC_Matching.y = 150;
         this.FMC_NinjaPointMall = this.FMC_BasicInfo["MC_NinjaPointMall"];
         TGameUtil.setButtonMode(this.FMC_NinjaPointMall,true);
         this.FMC_Option = this.FMC_BasicInfo["MC_Option"];
         this.FMC_Option.gotoAndStop(2);
         this.FMC_Start = this.FMC_BasicInfo["MC_Start"];
         this.FTF_Start = this.FMC_Start["TF_Start"];
         TGameUtil.setButtonMode(this.FMC_Start,true);
         this.FMC_Exit = this.FMC_BasicInfo["MC_Exit"];
         TGameUtil.setButtonMode(this.FMC_Exit,true);
         this.FTF_RestPlayCount = this.FMC_BasicInfo["TF_RestPlayCount"];
         this.FBTN_Close = this.FMC_BasicInfo["BTN_Close"];
         this.FBTN_Help = this.FMC_BasicInfo["BTN_Help"];
         this.FTF_ActivityEndTime = this.FMC_BasicInfo["TF_ActivityEndTime"];
         this.FTF_WinCount = this.FMC_BasicInfo["TF_WinCount"];
         this.FTF_TotalScore = this.FMC_BasicInfo["TF_TotalScore"];
         this.FTF_RewardScore = this.FMC_BasicInfo["TF_RewardScore"];
         this.FTF_TotayObtainNinjaPoint = this.FMC_BasicInfo["TF_TotayObtainNinjaPoint"];
         this.FTF_CurrentRank = this.FMC_BasicInfo["TF_CurrentRank"];
         this.FTF_CurrentNinjaPoint = this.FMC_BasicInfo["TF_CurrentNinjaPoint"];
         this.FMC_AutoStartOption = this.FMC_BasicInfo["MC_AutoStartOption"];
         this.FMC_AutoStartOption.gotoAndStop(2);
         this.FTF_AutoBattle = this.FMC_BasicInfo["TF_AutoBattle"];
         this.FTF_ServerName = this.FMainUI["TF_ServerName"];
         _loc2_ = this.FMCChangePostionArrows.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FMainUI["MC_ChangePosition_" + _loc1_ + "_" + (_loc1_ + 1)];
            this.FMCChangePostionArrows[_loc1_] = _loc3_;
            TGameUtil.setButtonMode(_loc3_,true);
            _loc1_++;
         }
         this.FUIWindowConfirmation = new TUIWindowConfirmation(this);
         this.FUIWindowConfirmation.OnOK = this.WindowConfirmationOnOK;
         this.FUIWindowConfirmation.x = (CONST_COMMON.STAGE_Width - this.FUIWindowConfirmation.WindowWidth) / 2;
         this.FUIWindowConfirmation.y = (CONST_COMMON.STAGE_Height - this.FUIWindowConfirmation.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowConfirmation);
         this.FUIWindowConfirmation.SetSelectedOrNot(false);
         this.FUIWindowCapatainConfirmation = new TUIWindowConfirmation(this);
         this.FUIWindowCapatainConfirmation.OnOK = this.WindowCapatainConfirmationOnOK;
         this.FUIWindowCapatainConfirmation.OnCancel = this.WindowCapatainConfirmationOnCancel;
         this.FUIWindowCapatainConfirmation.x = (CONST_COMMON.STAGE_Width - this.FUIWindowCapatainConfirmation.WindowWidth) / 2;
         this.FUIWindowCapatainConfirmation.y = (CONST_COMMON.STAGE_Height - this.FUIWindowCapatainConfirmation.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowCapatainConfirmation);
         this.FUIWindowCapatainConfirmation.SetSelectedOrNot(false);
         this.FProcessorTopTeamInviteList.Load();
      }
      
      protected function UpdateOtherPlayerHeadInfo() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUIRoomPlayer = null;
         var _loc4_:TRoomPlayer = null;
         var _loc5_:int = 0;
         var _loc6_:Boolean = false;
         _loc6_ = this.CheckCaptain();
         _loc2_ = CONST_TOPTEAM.CAPACITY_Heros;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FUIRoomPlayerInfos[_loc1_];
            _loc3_.Resource.visible = false;
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FUIRoomPlayerInfos[_loc1_];
            _loc4_ = this.CheckPosition(_loc1_);
            if(_loc4_ != null)
            {
               _loc3_.Context = _loc4_;
               _loc3_.Value = _loc6_;
               _loc3_.Update();
               _loc3_.Resource.visible = true;
            }
            _loc1_++;
         }
      }
      
      protected function CheckPosition(param1:int) : TRoomPlayer
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:TRoomPlayer = null;
         var _loc5_:TRoomPlayers = null;
         var _loc6_:TTopTeamRoomDetailInfo = null;
         _loc6_ = this.FTopTeamData.TopTeamRoomDetailInfo;
         _loc5_ = _loc6_.RoomPlayers;
         _loc3_ = _loc5_.Count;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = _loc5_.GetRoomPlayerByIndex(_loc2_);
            if(_loc4_ != null && param1 == _loc4_.PositionIndex)
            {
               return _loc4_;
            }
            _loc2_++;
         }
         return null;
      }
      
      protected function UpdateHeroStatus() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUIPlayerStatus = null;
         var _loc4_:TRoomPlayer = null;
         var _loc5_:TRoomPlayers = null;
         var _loc6_:MovieClip = null;
         _loc5_ = this.FTopTeamData.TopTeamRoomDetailInfo.RoomPlayers;
         _loc2_ = CONST_TOPTEAM.CAPACITY_Heros;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FUIHeroStatusInfos[_loc1_];
            _loc3_.Resource.visible = false;
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FUIHeroStatusInfos[_loc1_];
            _loc4_ = this.CheckPosition(_loc1_);
            if(_loc4_ != null)
            {
               _loc3_.Context = _loc4_;
               _loc3_.Update();
               _loc3_.Resource.visible = true;
            }
            _loc1_++;
         }
         _loc2_ = this.FMCChangePostionArrows.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc6_ = this.FMCChangePostionArrows[_loc1_];
            _loc6_.visible = this.CheckArrowVisible(_loc1_);
            _loc1_++;
         }
      }
      
      protected function CheckArrowVisible(param1:int) : Boolean
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:TRoomPlayer = null;
         var _loc5_:TRoomPlayer = null;
         var _loc6_:TRoomPlayers = null;
         var _loc7_:TTopTeamRoomDetailInfo = null;
         var _loc8_:Boolean = false;
         _loc8_ = this.CheckCaptain();
         if(!_loc8_)
         {
            return _loc8_;
         }
         _loc7_ = this.FTopTeamData.TopTeamRoomDetailInfo;
         _loc6_ = _loc7_.RoomPlayers;
         _loc4_ = _loc6_.GetRoomPlayerByIndex(param1);
         _loc5_ = _loc6_.GetRoomPlayerByIndex(param1 + 1);
         if(_loc4_ != null && _loc5_ != null)
         {
            return true;
         }
         return false;
      }
      
      protected function UpdateBasicRoomInfo() : void
      {
         var _loc1_:TTopTeamRoomDetailInfo = null;
         var _loc2_:uint = 0;
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:TRoomPlayer = null;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:Boolean = false;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         _loc1_ = this.FTopTeamData.TopTeamRoomDetailInfo;
         this.FTF_RoomID.text = TUtilityString.Format(STRING_TOPTEAM.FORMAT_RoomID,_loc1_.RoomID);
         this.FTF_ServerName.text = _loc1_.ServerName;
         _loc4_ = _loc1_.RoomPlayers.Count;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc5_ = _loc1_.RoomPlayers.GetRoomPlayerByIndex(_loc3_);
            if(_loc5_ != null)
            {
               _loc2_++;
            }
            _loc3_++;
         }
         this.FTF_Population.text = _loc2_ + "/3";
         this.FTF_Password.text = _loc1_.Password;
         _loc7_ = uint(!TUtilityString.Empty(_loc1_.Password));
         this.FMC_Option.gotoAndStop((_loc7_ + 1) % 2 + 1);
         this.FTF_RestPlayCount.text = TUtilityString.Format(STRING_TOPTEAM.FORMAT_RestPlayCount,this.FTopTeamData.RestPlayCount);
         _loc9_ = uint(SLogicsCore.Character.Identifier0);
         _loc10_ = uint(SLogicsCore.Character.Identifier1);
         _loc8_ = this.CheckCaptain();
         if(_loc8_)
         {
            this.FTF_Start.text = STRING_TOPTEAM.STRING_StartOrCancel[uint(!_loc8_)];
         }
         else
         {
            _loc4_ = _loc1_.RoomPlayers.Count;
            _loc3_ = 0;
            while(_loc3_ < _loc4_)
            {
               _loc5_ = _loc1_.RoomPlayers.GetRoomPlayerByIndex(_loc3_);
               if(_loc5_ != null && _loc5_.Identifier0 == _loc9_ && _loc5_.Identifier1 == _loc10_)
               {
                  _loc6_ = _loc5_.IsReady;
                  break;
               }
               _loc3_++;
            }
            this.FTF_Start.text = STRING_TOPTEAM.STRING_StartOrCancel[_loc6_ + 1];
         }
         this.FTF_AutoBattle.text = STRING_TOPTEAM.STRING_AutoBattle[uint(_loc8_)];
         this.FMC_Invite.visible = _loc8_;
         this.FMC_Option.visible = _loc8_;
         this.FTF_WinCount.text = _loc1_.CurrentSequentWins.toString();
         this.FTF_TotalScore.text = _loc1_.TodayScores.toString();
         this.FTF_RewardScore.text = _loc1_.SequentScores.toString();
         this.FTF_TotayObtainNinjaPoint.text = _loc1_.TodayNinjaPoint.toString();
         this.FTF_CurrentRank.text = this.FTopTeamData.MyRank == 0 ? STRING_TOPTEAM.STRING_NotInRankings : this.FTopTeamData.MyRank.toString();
         this.FTF_CurrentNinjaPoint.text = _loc1_.TotalNinjaPoint.toString();
      }
      
      protected function CheckCaptain() : Boolean
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TRoomPlayer = null;
         var _loc4_:TRoomPlayers = null;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         _loc4_ = this.FTopTeamData.TopTeamRoomDetailInfo.RoomPlayers;
         _loc5_ = uint(SLogicsCore.Character.Identifier0);
         _loc6_ = uint(SLogicsCore.Character.Identifier1);
         _loc2_ = _loc4_.Count;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = _loc4_.GetRoomPlayerByIndex(_loc1_);
            if(_loc3_ != null)
            {
               if(_loc3_.Identifier0 == _loc5_ && _loc3_.Identifier1 == _loc6_ && _loc3_.IsCaptaian == 1)
               {
                  return true;
               }
            }
            _loc1_++;
         }
         return false;
      }
      
      protected function CheckIsAllReady() : Boolean
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TRoomPlayer = null;
         var _loc4_:TRoomPlayers = null;
         _loc4_ = this.FTopTeamData.TopTeamRoomDetailInfo.RoomPlayers;
         _loc2_ = _loc4_.Count;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = _loc4_.GetRoomPlayerByIndex(_loc1_);
            if(_loc3_ != null && !Boolean(_loc3_.IsReady))
            {
               return false;
            }
            _loc1_++;
         }
         return true;
      }
      
      protected function CheckSelfIsReady() : Boolean
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TRoomPlayer = null;
         var _loc4_:TRoomPlayers = null;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         _loc4_ = this.FTopTeamData.TopTeamRoomDetailInfo.RoomPlayers;
         _loc5_ = uint(SLogicsCore.Character.Identifier0);
         _loc6_ = uint(SLogicsCore.Character.Identifier1);
         _loc2_ = _loc4_.Count;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = _loc4_.GetRoomPlayerByIndex(_loc1_);
            if(_loc3_ != null && _loc3_.Identifier0 == _loc5_ && _loc3_.Identifier1 == _loc6_ && Boolean(_loc3_.IsReady))
            {
               return true;
            }
            _loc1_++;
         }
         return false;
      }
      
      protected function AutoStartMatch() : void
      {
         var _loc1_:Boolean = false;
         _loc1_ = this.CheckCaptain();
         if(_loc1_)
         {
            this.FCheckIsAllReady = true;
         }
         else
         {
            _loc1_ = this.CheckSelfIsReady();
            if(!_loc1_)
            {
               this.MCStartOnClick(null);
            }
         }
      }
      
      protected function UpdateUI() : void
      {
         this.UpdateBasicRoomInfo();
         this.UpdateHeroStatus();
         this.UpdateOtherPlayerHeadInfo();
      }
      
      protected function PerformPacket_CS_Leave_Room_Req() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TopTeam_Leave_Room_Req);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PerformPacket_CS_Change_Ready_Req(param1:uint) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TopTeam_Change_Ready_Req);
         _loc3_ = _loc2_.Data;
         _loc3_.writeUnsignedInt(param1);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function PerformPacket_CS_Match_Req() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TopTeam_Match_Req);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PerformPacket_CS_Cancel_Match_Req() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TopTeam_Cancel_Match_Req);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PerformPacket_CS_T_Req(param1:uint, param2:uint) : void
      {
         var _loc3_:TPacket = null;
         var _loc4_:ByteArray = null;
         _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TopTeam_T_Req);
         _loc4_ = _loc3_.Data;
         _loc4_.writeUnsignedInt(param1);
         _loc4_.writeUnsignedInt(param2);
         SNetworkCore.Transceiver.PacketTransmit(_loc3_);
      }
      
      protected function ProcessorHeroInforOnClick(param1:Object, param2:String, param3:Object) : void
      {
         var _loc4_:TFriendDigest = null;
         var _loc5_:TRoomPlayer = null;
         var _loc6_:Boolean = false;
         var _loc7_:String = null;
         _loc5_ = param3 as TRoomPlayer;
         if(this.FMatchSign)
         {
            return;
         }
         if(this.FTopTeamData.MatchStatus == 1)
         {
            EffectGenerateText(STRING_TOPTEAM.STRING_Matching);
            return;
         }
         _loc6_ = this.CheckCaptain();
         switch(param2)
         {
            case STRING_TOPTEAM.Command_LookUp:
               if(this.FShowOtherHeroInfor != null)
               {
                  this.FShowOtherHeroInfor(this,_loc5_.Identifier0,_loc5_.Identifier1);
               }
               break;
            case STRING_TOPTEAM.Command_Whisper:
               if(this.FRequestWhisper != null)
               {
                  this.FRequestWhisper(this,_loc5_.Identifier0,_loc5_.Identifier1,_loc5_.PlayerName);
               }
               break;
            case STRING_TOPTEAM.Command_KickOut:
               if(_loc6_)
               {
                  this.PerformPacket_CS_T_Req(_loc5_.Identifier0,_loc5_.Identifier1);
               }
               else
               {
                  EffectGenerateText(STRING_TOPTEAM.STRING_NoOperating);
               }
               break;
            case STRING_TOPTEAM.Command_Transfer:
               this.FIdentifier0 = _loc5_.Identifier0;
               this.FIdentifier1 = _loc5_.Identifier1;
               this.FUIWindowCapatainConfirmation.Visible = true;
               _loc7_ = TUtilityString.Format(STRING_TOPTEAM.FORMAT_Transfer[uint(!_loc6_)],_loc5_.PlayerName);
               this.FUIWindowCapatainConfirmation.Text = _loc7_;
               break;
            case STRING_TOPTEAM.Command_Friend:
               this.FCharacterDigest.Coerce(_loc5_.Identifier0,_loc5_.Identifier1);
               this.FCharacterDigest.Tag = CONST_FRIEND.TYPE_Whitelist_Add;
               _loc4_ = this.FFriends.GetDigestByIdentifier(this.FCharacterDigest.Identifier0,this.FCharacterDigest.Identifier1);
               if(_loc4_ != null && _loc4_.Type != CONST_FRIEND.TYPE_White)
               {
                  EffectGenerateText(STRING_CHAT.STRING_AddWhitelistPrompt);
               }
               else if(this.FOnInterpersonalRelationships != null)
               {
                  this.FOnInterpersonalRelationships(this,CONST_FRIEND.TYPE_Whitelist_Add,this.FCharacterDigest);
               }
         }
      }
      
      protected function OnTextFocusIn(param1:FocusEvent) : void
      {
         var _loc2_:Boolean = false;
         _loc2_ = this.CheckCaptain();
         this.FTF_Password.selectable = _loc2_;
         if(!_loc2_)
         {
            return;
         }
         _loc2_ = this.FMC_Option.currentFrame != 1;
         this.FTF_Password.selectable = _loc2_;
         if(!_loc2_)
         {
            return;
         }
         if(!this.FBFocus)
         {
            this.FTF_Password.text = "";
            this.FBFocus = true;
         }
      }
      
      protected function OnTextFocusOut(param1:FocusEvent) : void
      {
         this.FPassword = this.FTF_Password.text;
         if(this.FTF_Password.text == "")
         {
            this.FTF_Password.text = this.FPassword;
            this.FBFocus = false;
         }
      }
      
      protected function MCNinjaPointMallOnClick(param1:MouseEvent) : void
      {
         if(this.FMatchSign)
         {
            return;
         }
         if(this.FNinjaPointMallOnClick != null)
         {
            this.FNinjaPointMallOnClick(this);
         }
      }
      
      protected function MCOptionOnClick(param1:MouseEvent) : void
      {
         var _loc2_:uint = 0;
         if(this.FMatchSign)
         {
            return;
         }
         this.FPassword = this.FTF_Password.text;
         if(this.FPassword == "")
         {
            EffectGenerateText(STRING_TOPTEAM.STRING_InputPassword);
            return;
         }
         _loc2_ = uint(this.FMC_Option.currentFrame);
         this.FUIWindowConfirmation.Text = STRING_TOPTEAM.STRING_LockRoom[uint(Boolean(_loc2_ % 2))];
         this.FUIWindowConfirmation.Visible = true;
      }
      
      protected function MCAutoStartOptionOnClick(param1:MouseEvent) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:Boolean = false;
         _loc2_ = uint(this.FMC_AutoStartOption.currentFrame);
         if(this.FMatchSign)
         {
            return;
         }
         if(_loc2_ == 2)
         {
            this.FMC_AutoStartOption.gotoAndStop(1);
            this.FTopTeamData.IsAutoStartSign = true;
            this.AutoStartMatch();
         }
         else
         {
            this.FMC_AutoStartOption.gotoAndStop(2);
            this.FTopTeamData.IsAutoStartSign = false;
         }
      }
      
      protected function MCStartOnClick(param1:MouseEvent) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:Boolean = false;
         var _loc5_:TRoomPlayer = null;
         var _loc6_:TRoomPlayer = null;
         var _loc7_:TRoomPlayers = null;
         if(this.FMatchSign)
         {
            return;
         }
         this.FCheckIsAllReady = false;
         _loc4_ = this.CheckCaptain();
         if(param1 != null)
         {
            if(this.FTopTeamData.MatchStatus == 1)
            {
               this.FMC_AutoStartOption.gotoAndStop(2);
               this.FTopTeamData.IsAutoStartSign = false;
            }
            else if(this.FMC_AutoStartOption.currentFrame == 1)
            {
               EffectGenerateText(TUtilityString.Format(STRING_TOPTEAM.FORMAT_CancelMatchFirst,STRING_TOPTEAM.STRING_AutoBattle[uint(_loc4_)]));
               return;
            }
         }
         _loc7_ = this.FTopTeamData.TopTeamRoomDetailInfo.RoomPlayers;
         _loc6_ = _loc7_.GetRoomPlayerByIdentifier(SLogicsCore.Character.Identifier0,SLogicsCore.Character.Identifier1);
         if(_loc4_)
         {
            _loc3_ = _loc7_.Count;
            _loc2_ = 0;
            while(_loc2_ < _loc3_)
            {
               _loc5_ = _loc7_.GetRoomPlayerByIndex(_loc2_);
               if(!(_loc5_ != null && _loc5_.Identifier0 == SLogicsCore.Character.Identifier0 && _loc5_.Identifier1 == SLogicsCore.Character.Identifier1))
               {
                  if(_loc5_ != null && _loc5_.IsReady == 0)
                  {
                     EffectGenerateText(TUtilityString.Format(STRING_TOPTEAM.FORMAT_PleaseReady,_loc5_.PlayerName));
                     return;
                  }
               }
               _loc2_++;
            }
            if(this.FTopTeamData.MatchStatus == 0)
            {
               this.PerformPacket_CS_Match_Req();
            }
            else
            {
               this.PerformPacket_CS_Cancel_Match_Req();
            }
            this.FMatchSign = true;
         }
         else if(_loc6_ != null)
         {
            this.PerformPacket_CS_Change_Ready_Req(_loc6_.IsReady == 0 ? 1 : 0);
         }
      }
      
      protected function MCExitOnClick(param1:MouseEvent) : void
      {
         if(this.FMatchSign)
         {
            return;
         }
         this.BTNCloseOnClick(param1);
      }
      
      protected function ButtonHelpOnOver(param1:MouseEvent) : void
      {
         var _loc2_:TSystemLanguage = null;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.HELPTIPS_TopTeam) as TSystemLanguage;
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
         if(this.FMatchSign)
         {
            return;
         }
         if(this.FTopTeamData.IsAutoStartSign)
         {
            EffectGenerateText(STRING_TOPTEAM.STRING_MustCancelReady);
            return;
         }
         this.FTopTeamData.IsAutoStartSign = false;
         this.PerformPacket_CS_Leave_Room_Req();
         if(this.FOnReturnMainScene != null)
         {
            this.FOnReturnMainScene(this);
         }
      }
      
      protected function WindowConfirmationOnOK(param1:Object) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:uint = 0;
         var _loc4_:ByteArray = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TopTeam_Set_Password_Req);
         _loc4_ = _loc2_.Data;
         _loc3_ = uint(this.FMC_Option.currentFrame);
         if(Boolean(_loc3_ % 2))
         {
            this.FPassword = "";
            this.FTF_Password.text = this.FPassword;
         }
         TUtilityString.FlushUTF(_loc4_,this.FPassword);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function WindowCapatainConfirmationOnOK(param1:Object) : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:TPacket = null;
         var _loc4_:ByteArray = null;
         _loc2_ = this.CheckCaptain();
         if(this.FApproveCaptain)
         {
            _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TopTeam_Approve_Req);
            _loc4_ = _loc3_.Data;
            _loc4_.writeUnsignedInt(this.FIdentifier0);
            _loc4_.writeUnsignedInt(this.FIdentifier1);
            _loc4_.writeUnsignedInt(0);
            this.FApproveCaptain = false;
         }
         else if(_loc2_)
         {
            _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TopTeam_Set_Captain_Req);
            _loc4_ = _loc3_.Data;
            _loc4_.writeUnsignedInt(this.FIdentifier0);
            _loc4_.writeUnsignedInt(this.FIdentifier1);
         }
         else
         {
            _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TopTeam_Apply_Captain_Req);
         }
         SNetworkCore.Transceiver.PacketTransmit(_loc3_);
      }
      
      protected function WindowCapatainConfirmationOnCancel(param1:Object) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         if(this.FApproveCaptain)
         {
            _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TopTeam_Approve_Req);
            _loc3_ = _loc2_.Data;
            _loc3_.writeUnsignedInt(this.FIdentifier0);
            _loc3_.writeUnsignedInt(this.FIdentifier1);
            _loc3_.writeUnsignedInt(1);
            this.FApproveCaptain = false;
            SNetworkCore.Transceiver.PacketTransmit(_loc2_);
         }
      }
      
      protected function MCInviteOnClick(param1:MouseEvent) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         if(this.FMatchSign)
         {
            return;
         }
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TopTeam_Get_Invite_User_List_Req);
         _loc3_ = _loc2_.Data;
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function MCArrowOnClick(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:Array = null;
         var _loc4_:TPacket = null;
         var _loc5_:ByteArray = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         if(this.FMatchSign)
         {
            return;
         }
         if(this.FTopTeamData.MatchStatus == 1)
         {
            EffectGenerateText(STRING_TOPTEAM.STRING_Matching);
            return;
         }
         _loc2_ = param1.currentTarget.name;
         _loc3_ = _loc2_.split("_");
         _loc4_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TopTeam_Embattle_Requint);
         _loc5_ = _loc4_.Data;
         _loc6_ = uint(_loc3_[2]) + 1;
         _loc7_ = uint(_loc3_[3]) + 1;
         _loc5_.writeUnsignedInt(_loc6_);
         _loc5_.writeUnsignedInt(_loc7_);
         SNetworkCore.Transceiver.PacketTransmit(_loc4_);
      }
      
      protected function ProcessorWorldInviteOnClick(param1:Object) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TopTeam_World_Invite_Req);
         _loc3_ = _loc2_.Data;
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function ProcessorRapidInviteOnClick(param1:Object) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         var _loc4_:TInviteShadow = null;
         var _loc5_:uint = 0;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TopTeam_Shortcut_Invite_Req);
         _loc3_ = _loc2_.Data;
         _loc5_ = this.FTopTeamData.InviteList.Count;
         _loc4_ = this.FTopTeamData.InviteList.GetInviteShadowByIndex(Math.random() * _loc5_);
         if(_loc4_ == null)
         {
            EffectGenerateText(STRING_TOPTEAM.STRING_NoFriend);
            return;
         }
         _loc3_.writeUnsignedInt(_loc4_.Identifier0);
         _loc3_.writeUnsignedInt(_loc4_.Identifier1);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function ProcessorInviteOnClick(param1:Object, param2:uint, param3:uint) : void
      {
         var _loc4_:TPacket = null;
         var _loc5_:ByteArray = null;
         _loc4_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TopTeam_Invite_Req);
         _loc5_ = _loc4_.Data;
         _loc5_.writeUnsignedInt(param2);
         _loc5_.writeUnsignedInt(param3);
         SNetworkCore.Transceiver.PacketTransmit(_loc4_);
      }
      
      protected function PerformPacket_CS_Top_Req() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TopTeam_Top_Req);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function CheckIsAutoStart() : void
      {
         if(this.FTopTeamData.RestPlayCount == 0)
         {
            return;
         }
         if(this.FTopTeamData.IsAutoStartSign)
         {
            this.FMC_AutoStartOption.gotoAndStop(1);
            this.AutoStartMatch();
         }
         else
         {
            this.FMC_AutoStartOption.gotoAndStop(2);
         }
         this.FMC_Mask.visible = false;
      }
      
      public function set OnReturnMainScene(param1:Function) : void
      {
         this.FOnReturnMainScene = param1;
      }
      
      public function set ShowOtherHeroInfor(param1:Function) : void
      {
         this.FShowOtherHeroInfor = param1;
      }
      
      public function set RequestWhisper(param1:Function) : void
      {
         this.FRequestWhisper = param1;
      }
      
      public function set OnSetGroupBattleChannel(param1:Function) : void
      {
         this.FOnSetGroupBattleChannel = param1;
      }
      
      public function set NinjaPointMallOnClick(param1:Function) : void
      {
         this.FNinjaPointMallOnClick = param1;
      }
      
      public function set OnInterpersonalRelationships(param1:Function) : void
      {
         this.FOnInterpersonalRelationships = param1;
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
            this.Load();
            return;
         }
         SLogicsCore.Character.RoleSencePosition = CONST_COMMON.SCENEPOSITION_TopTeam;
         this.FTopTeamData.MatchStatus = 0;
         this.UpdateUI();
         this.PerformPacket_CS_Top_Req();
         _loc2_ = new Date(STimingCore.GetServerTick() * 1000);
         _loc2_.setHours(uint(this.FArr[1][0]),uint(this.FArr[1][1]),0,0);
         _loc3_ = _loc2_.valueOf() / 1000;
         this.FActivityEndTimes.push(_loc3_);
         _loc2_.setHours(uint(this.FArr[3][0]),uint(this.FArr[3][1]),0,0);
         _loc3_ = _loc2_.valueOf() / 1000;
         this.FActivityEndTimes.push(_loc3_);
         if(this.FOnSetGroupBattleChannel != null)
         {
            this.FOnSetGroupBattleChannel(this,CONST_CHAT.CHANNEL_TYPE_Team,true);
         }
      }
      
      override public function Unmount() : void
      {
         super.Unmount();
         this.Reset();
         if(this.FOnSetGroupBattleChannel != null)
         {
            this.FOnSetGroupBattleChannel(this,CONST_CHAT.CHANNEL_TYPE_Team,false);
         }
      }
      
      public function UpdateTop() : void
      {
         if(!FIsResourcesLoadCompleted)
         {
            return;
         }
         if(!Visible)
         {
            return;
         }
         this.UpdateBasicRoomInfo();
      }
      
      public function UpdateRoomData() : void
      {
         if(!FIsResourcesLoadCompleted)
         {
            return;
         }
         if(!Visible)
         {
            return;
         }
         this.UpdateUI();
         this.CheckIsAutoStart();
      }
      
      public function UpdateMatchSuccess() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Boolean = false;
         var _loc5_:String = null;
         _loc1_ = Boolean(this.FTopTeamData.MatchStatus);
         this.FStartTime = STimingCore.GetServerTick();
         _loc4_ = this.CheckCaptain();
         if(_loc1_)
         {
            _loc5_ = STRING_TOPTEAM.STRING_StartOrCancel[2];
         }
         else if(_loc4_)
         {
            _loc5_ = STRING_TOPTEAM.STRING_StartOrCancel[0];
         }
         else
         {
            _loc5_ = STRING_TOPTEAM.STRING_StartOrCancel[2];
         }
         this.FTF_Start.text = _loc5_;
         this.FMC_Mask.visible = _loc1_;
         this.FMaskStartMatch.visible = !_loc4_;
         this.FMatchSign = false;
      }
      
      public function ApplyCaptain(param1:uint, param2:uint) : void
      {
         var _loc3_:TRoomPlayer = null;
         _loc3_ = this.FTopTeamData.TopTeamRoomDetailInfo.RoomPlayers.GetRoomPlayerByIdentifier(param1,param2);
         if(_loc3_ != null)
         {
            this.FIdentifier0 = param1;
            this.FIdentifier1 = param2;
            this.FUIWindowCapatainConfirmation.Visible = true;
            this.FUIWindowCapatainConfirmation.Text = TUtilityString.Format(STRING_TOPTEAM.FORMAT_Transfer[2],_loc3_.PlayerName);
            this.FApproveCaptain = true;
         }
      }
      
      public function UpdateInviteList() : void
      {
         this.FProcessorTopTeamInviteList.Visible = true;
         this.FProcessorTopTeamInviteList.Update();
      }
      
      public function Reset() : void
      {
         this.FMaskStartMatch.visible = false;
      }
   }
}

