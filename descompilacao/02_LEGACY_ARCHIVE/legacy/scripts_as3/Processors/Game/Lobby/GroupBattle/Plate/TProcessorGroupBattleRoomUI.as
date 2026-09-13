package Processors.Game.Lobby.GroupBattle.Plate
{
   import Components.Slots.TUISlot;
   import Foundation.Common.THint;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Queries.TQueryString;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Resources.Repositories.TResourceRepositoryTexture;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Resources.Textures.TTexture;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.GroupBattle.TGroupBattleData;
   import Logics.GroupBattle.TGroupBattleLevel;
   import Logics.GroupBattle.TRoomDetailInfo;
   import Logics.GroupBattle.TRoomPlayer;
   import Logics.GroupBattle.TRoomPlayers;
   import Logics.Inventories.TAppliance;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
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
   import Processors.Game.Lobby.GroupBattle.Component.TUIHeroStatusInfo;
   import Processors.Game.Lobby.GroupBattle.Component.TUIRoomPlayerInfo;
   import Processors.Game.Lobby.GroupBattle.Window.TProcessorWindowBattleChoose;
   import Processors.Game.Lobby.GroupBattle.Window.TProcessorWindowInviteList;
   import Processors.Game.Windows.Information.TUIWindowConfirmation;
   import Rendering.Overlayers.HelpTips.TOverlayerHelpTips;
   import Rendering.Overlayers.Inventories.TOverlayerAccessory;
   import Rendering.Overlayers.Inventories.TOverlayerAppliance;
   import Rendering.Overlayers.Inventories.TOverlayerEquipment;
   import Rendering.Overlayers.Inventories.TOverlayerTreasure;
   import Rendering.Overlayers.TOverlayer;
   import Resources.Constants.CONST_CHAT;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_CONFIGVALUE;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_GROUPBATTLE;
   import Resources.Constants.CONST_INVENTORY;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Strings.STRING_GROUPBATTLE;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.FocusEvent;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   
   public class TProcessorGroupBattleRoomUI extends TProcessorLobbyPlate
   {
      
      public static const CATEGORY_Normal:uint = CONST_INVENTORY.CATEGORY_Normal;
      
      public static const CATEGORY_Equipment:uint = CONST_INVENTORY.CATEGORY_Equipment;
      
      public static const CATEGORY_Treasure:uint = CONST_INVENTORY.CATEGORY_Treasure;
      
      public static const CATEGORY_Accessories:uint = CONST_INVENTORY.CATEGORY_Accessories;
      
      protected const STAGE_Width:uint = CONST_COMMON.STAGE_Width;
      
      protected const STAGE_Height:uint = CONST_COMMON.STAGE_Height;
      
      protected const CAPACITY_HEROINFOS:uint = 2;
      
      protected const CAPACITY_SLOTS:uint = 4;
      
      protected const CAPACITY_HEROSTATUS:uint = 3;
      
      protected var FTF_RoomID:TextField;
      
      protected var FMC_BasicInfo:MovieClip;
      
      protected var FTF_BattleName:TextField;
      
      protected var FTF_BattleLevel:TextField;
      
      protected var FTF_Difficulty:TextField;
      
      protected var FMC_BattleChoose:MovieClip;
      
      protected var FTF_RecoomendPopulation:TextField;
      
      protected var FTF_Expricence:TextField;
      
      protected var FTF_SilverCoin:TextField;
      
      protected var FMC_Slots:Sprite;
      
      protected var FMC_SlotLeft:MovieClip;
      
      protected var FMC_SlotRight:MovieClip;
      
      protected var FTF_Population:TextField;
      
      protected var FMC_Invite:MovieClip;
      
      protected var FTF_Password:TextField;
      
      protected var FMC_Option:MovieClip;
      
      protected var FMC_Start:MovieClip;
      
      protected var FTF_Start:TextField;
      
      protected var FMC_Exit:MovieClip;
      
      protected var FTF_RestPlayCount:TextField;
      
      protected var FBTN_Close:SimpleButton;
      
      protected var FBTN_Help:SimpleButton;
      
      protected var FMainUI:Sprite;
      
      protected var FMC_AutoStartOption:MovieClip;
      
      protected var FTF_AutoBattle:TextField;
      
      protected var FMC_Matching:MovieClip;
      
      protected var FTF_Matching:TextField;
      
      protected var FCountdown:uint;
      
      protected var FCheckIsAllReady:Boolean;
      
      protected var FIsMatching:Boolean;
      
      protected var FUIRoomPlayerInfos:Vector.<TUIRoomPlayerInfo>;
      
      protected var FUISlots:Vector.<TUISlot>;
      
      protected var FUIHeroStatusInfos:Vector.<TUIHeroStatusInfo>;
      
      protected var FProcessorWindowBattleChoose:TProcessorWindowBattleChoose;
      
      protected var FProcessorWindowInviteList:TProcessorWindowInviteList;
      
      protected var FProcessorWindowBattleReady:TProcessorWindowBattleReady;
      
      protected var FUIWindowConfirmation:TUIWindowConfirmation;
      
      protected var FOverlayerEquipment:TOverlayerEquipment;
      
      protected var FOverlayerTreasure:TOverlayerTreasure;
      
      protected var FOverlayerAppliance:TOverlayerAppliance;
      
      protected var FHelpTips:THint;
      
      protected var FOverlayerHelpTips:TOverlayerHelpTips;
      
      protected var FOverlayerAccessory:TOverlayerAccessory;
      
      protected var FGroupBattleData:TGroupBattleData;
      
      protected var FFilterSelf:Vector.<TRoomPlayer>;
      
      protected var FBFocus:Boolean;
      
      protected var FPassword:String;
      
      protected var FSlotIndex:int;
      
      protected var FSlotMaxPages:uint;
      
      protected var FOnReturnMainScene:Function;
      
      protected var FShowOtherHeroInfor:Function;
      
      protected var FRequestWhisper:Function;
      
      protected var FOnSetGroupBattleChannel:Function;
      
      public function TProcessorGroupBattleRoomUI(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.InitParameter();
         this.InitWindows();
      }
      
      protected function InitParameter() : void
      {
         this.FUIRoomPlayerInfos = new Vector.<TUIRoomPlayerInfo>(this.CAPACITY_HEROINFOS);
         this.FUISlots = new Vector.<TUISlot>(this.CAPACITY_SLOTS);
         this.FUIHeroStatusInfos = new Vector.<TUIHeroStatusInfo>(this.CAPACITY_HEROSTATUS);
         this.FHelpTips = new THint();
         this.FFilterSelf = new Vector.<TRoomPlayer>();
         this.FGroupBattleData = SLogicsCore.GroupBattleData;
         this.FPassword = "";
         this.FCheckIsAllReady = false;
         this.FIsMatching = false;
      }
      
      protected function InitWindows() : void
      {
         this.FProcessorWindowBattleChoose = new TProcessorWindowBattleChoose(this);
         this.FProcessorWindowInviteList = new TProcessorWindowInviteList(this);
         this.FProcessorWindowInviteList.WorldInviteOnClick = this.ProcessorWorldInviteOnClick;
         this.FProcessorWindowBattleReady = new TProcessorWindowBattleReady(this);
         this.FProcessorWindowBattleReady.OnClose = this.ProcessorOnCloseWindowBattleReady;
         this.FProcessorWindowBattleReady.StartBattleOnClick = this.ProcessorOnStartBattle;
         this.FProcessorWindowBattleReady.ExchangePosition = this.RoomInOperatingReq;
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_GROUPBATTLE.RESOURCESID_Swf_GroupBattle);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:TConfigValue = null;
         this.FMainUI = TUtilityReflection.CreateDisplayObjectInstance(CONST_GROUPBATTLE.RESOURCE_ClassName_MC_GroupBattleRoomUI) as Sprite;
         addChildAt(this.FMainUI,0);
         this.UIDispatchHeroHeadInfo();
         this.UIDispatchHeroStatus();
         this.UIDispatchOtherInfo();
         this.UIDispatchWindows();
         this.UIDispatchControls();
         this.FUIWindowConfirmation = new TUIWindowConfirmation(this);
         this.FUIWindowConfirmation.OnOK = this.WindowConfirmationOnOK;
         this.FUIWindowConfirmation.x = (this.STAGE_Width - this.FUIWindowConfirmation.WindowWidth) / 2;
         this.FUIWindowConfirmation.y = (this.STAGE_Height - this.FUIWindowConfirmation.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowConfirmation);
         this.FUIWindowConfirmation.SetSelectedOrNot(false);
         this.FUIWindowConfirmation.visible = false;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.LEAGUE_PVE_Countdown) as TConfigValue;
         this.FCountdown = _loc1_.Value as uint;
         super.ResourcesPerform_UIDispatch();
      }
      
      protected function UIDispatchHeroHeadInfo() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUIRoomPlayerInfo = null;
         _loc2_ = this.CAPACITY_HEROINFOS;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = new TUIRoomPlayerInfo(this);
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
         var _loc3_:TUIHeroStatusInfo = null;
         _loc2_ = this.CAPACITY_HEROSTATUS;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = new TUIHeroStatusInfo(this);
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
         var _loc3_:TUISlot = null;
         this.FMC_BasicInfo = this.FMainUI["MC_BasicInfo"];
         this.FTF_RoomID = this.FMainUI["MC_RoomID"]["TF_RoomID"];
         this.FTF_BattleName = this.FMC_BasicInfo["TF_BattleName"];
         this.FTF_BattleLevel = this.FMC_BasicInfo["TF_BattleLevel"];
         this.FTF_Difficulty = this.FMC_BasicInfo["TF_Difficulty"];
         this.FMC_BattleChoose = this.FMC_BasicInfo["MC_BattleChoose"];
         TGameUtil.setButtonMode(this.FMC_BattleChoose,true);
         this.FTF_RecoomendPopulation = this.FMC_BasicInfo["TF_RecoomendPopulation"];
         this.FTF_Expricence = this.FMC_BasicInfo["TF_Expricence"];
         this.FTF_SilverCoin = this.FMC_BasicInfo["TF_SilverCoin"];
         this.FMC_SlotLeft = this.FMC_BasicInfo["MC_SlotLeft"];
         TGameUtil.setButtonMode(this.FMC_SlotLeft,true);
         this.FMC_SlotRight = this.FMC_BasicInfo["MC_SlotRight"];
         TGameUtil.setButtonMode(this.FMC_SlotRight,true);
         this.FTF_Population = this.FMC_BasicInfo["TF_Population"];
         this.FMC_Invite = this.FMC_BasicInfo["MC_Invite"];
         TGameUtil.setButtonMode(this.FMC_Invite,true);
         this.FTF_Password = this.FMC_BasicInfo["TF_Password"];
         this.FTF_Password.text = "";
         this.FTF_Password.restrict = "0-9";
         this.FTF_Password.maxChars = 4;
         this.FMC_Option = this.FMC_BasicInfo["MC_Option"];
         this.FMC_Option.gotoAndStop(2);
         this.FMC_Start = this.FMC_BasicInfo["MC_Start"];
         this.FTF_Start = this.FMC_Start["TF_Start"];
         TGameUtil.setButtonMode(this.FMC_Start,true);
         this.FMC_Exit = this.FMC_BasicInfo["MC_Exit"];
         TGameUtil.setButtonMode(this.FMC_Exit,true);
         this.FTF_RestPlayCount = this.FMC_BasicInfo["TF_RestPlayCount"];
         this.FMC_AutoStartOption = this.FMC_BasicInfo["MC_AutoStartOption"];
         this.FMC_AutoStartOption.gotoAndStop(2);
         this.FTF_AutoBattle = this.FMC_BasicInfo["TF_AutoBattle"];
         this.FMC_Matching = this.FMainUI["MC_Match"];
         this.FTF_Matching = this.FMC_Matching["TF_Matching"];
         this.FMC_Matching.visible = false;
         this.FBTN_Close = this.FMC_BasicInfo["BTN_Close"];
         this.FBTN_Help = this.FMC_BasicInfo["BTN_Help"];
         _loc2_ = this.CAPACITY_SLOTS;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = new TUISlot(this);
            _loc3_.Resource = this.FMC_BasicInfo["MC_Slot_" + _loc1_] as MovieClip;
            _loc3_.Resource.visible = false;
            _loc3_.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
            _loc3_.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
            _loc3_.OnOverlay = this.UIComponentsHintOnOver;
            _loc3_.OnOut = this.UIComponentsHintOnOut;
            _loc3_.Init();
            this.FUISlots[_loc1_] = _loc3_;
            _loc1_++;
         }
      }
      
      protected function UIDispatchWindows() : void
      {
         this.FProcessorWindowBattleChoose.OnClose = this.ProcessorOnClose;
         this.FProcessorWindowBattleChoose.SlotOnOver = this.UIComponentsHintOnOver;
         this.FProcessorWindowBattleChoose.SlotOnOut = this.UIComponentsHintOnOut;
         this.FProcessorWindowBattleChoose.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
         this.FProcessorWindowBattleChoose.OnQuerySubscript = this.SlotsOnQuerySubscript;
         this.FProcessorWindowBattleChoose.ConfirmOnClick = this.ProcessorConfirmOnClick;
         this.FProcessorWindowInviteList.InviteOnClick = this.ProcessorInviteOnClick;
      }
      
      protected function UIDispatchControls() : void
      {
         this.FOverlayerEquipment = new TOverlayerEquipment(this,CONST_MODULES.MODULE_GroupBattle);
         this.FOverlayerEquipment.Visible = false;
         this.FOverlayerTreasure = new TOverlayerTreasure(this,CONST_MODULES.MODULE_GroupBattle);
         this.FOverlayerTreasure.Visible = false;
         this.FOverlayerAppliance = new TOverlayerAppliance(this,CONST_MODULES.MODULE_GroupBattle);
         this.FOverlayerHelpTips = new TOverlayerHelpTips(this);
         this.FOverlayerHelpTips.Visible = false;
         this.FOverlayerAccessory = new TOverlayerAccessory(this,CONST_MODULES.MODULE_GroupBattle);
         this.FOverlayerAccessory.Visible = false;
         this.FOverlayerAccessory.IsMeOrOthers = 0;
         this.FOverlayerAppliance.Visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerEquipment);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerTreasure);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerAppliance);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerHelpTips);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerAccessory);
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FMC_Option.addEventListener(MouseEvent.CLICK,this.MCOptionOnClick,false,0,true);
         this.FMC_AutoStartOption.addEventListener(MouseEvent.CLICK,this.MCAutoStartOptionOnClick,false,0,true);
         this.FMC_BattleChoose.addEventListener(MouseEvent.CLICK,this.MCBattleChooseOnClick,false,0,true);
         this.FMC_Invite.addEventListener(MouseEvent.CLICK,this.MCInviteOnClick,false,0,true);
         this.FMC_Start.addEventListener(MouseEvent.CLICK,this.MCStartOnClick,false,0,true);
         this.FMC_Exit.addEventListener(MouseEvent.CLICK,this.MCExitOnClick,false,0,true);
         this.FBTN_Close.addEventListener(MouseEvent.CLICK,this.BTNCloseOnClick,false,0,true);
         this.FBTN_Help.addEventListener(MouseEvent.MOUSE_OVER,this.ButtonHelpOnOver,false,0,true);
         this.FBTN_Help.addEventListener(MouseEvent.MOUSE_OUT,this.ButtonHelpOnOut,false,0,true);
         this.FMC_SlotLeft.addEventListener(MouseEvent.CLICK,this.MCSlotLeftOnClick,false,0,true);
         this.FMC_SlotRight.addEventListener(MouseEvent.CLICK,this.MCSlotRightOnClick,false,0,true);
         this.FTF_Password.addEventListener(FocusEvent.FOCUS_IN,this.OnTextFocusIn);
         this.FTF_Password.addEventListener(FocusEvent.FOCUS_OUT,this.OnTextFocusOut);
         super.ResourcesPerform_UILocations();
      }
      
      override protected function ResourcesPerform_UIFinalize() : void
      {
         super.ResourcesPerform_UIFinalize();
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUISlot = null;
         var _loc4_:int = 0;
         if(!Visible)
         {
            return;
         }
         _loc2_ = this.CAPACITY_SLOTS;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FUISlots[_loc1_];
            if(_loc3_ != null)
            {
               _loc3_.Update();
            }
            _loc1_++;
         }
         this.FIsMatching = Boolean(this.FGroupBattleData.ReadyTimeStatus != 0);
         if(this.FMC_Matching != null)
         {
            this.FMC_Matching.visible = this.FIsMatching;
         }
         if(this.FGroupBattleData.ReadyTimeStatus != 0)
         {
            _loc4_ = this.FGroupBattleData.ReadyTimeTick + this.FCountdown - STimingCore.GetServerTick();
            this.FTF_Matching.text = TUtilityString.Format(STRING_GROUPBATTLE.FORMAT_Matching,this.FGroupBattleData.ReadyTimeTick + this.FCountdown - STimingCore.GetServerTick());
            if(_loc4_ <= 0)
            {
               this.ProcessorOnReadyBattle(this);
               this.FGroupBattleData.ReadyTimeStatus = 0;
            }
         }
         super.LogicsPerform();
      }
      
      protected function UpdateOtherPlayerHeadInfo() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUIRoomPlayerInfo = null;
         var _loc4_:TRoomPlayer = null;
         var _loc5_:TRoomPlayers = null;
         var _loc6_:TRoomDetailInfo = null;
         this.FilterSelfData();
         _loc6_ = this.FGroupBattleData.RoomDetailInfo;
         _loc5_ = _loc6_.RoomPlayers;
         _loc2_ = this.CAPACITY_HEROINFOS;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FUIRoomPlayerInfos[_loc1_];
            _loc4_ = _loc1_ < this.FFilterSelf.length ? this.FFilterSelf[_loc1_] : null;
            _loc3_.Context = _loc4_;
            _loc3_.Update();
            _loc3_.Resource.visible = _loc4_ != null;
            _loc1_++;
         }
      }
      
      protected function FilterSelfData() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TRoomPlayer = null;
         var _loc4_:TRoomPlayers = null;
         var _loc5_:TRoomDetailInfo = null;
         _loc2_ = this.FFilterSelf.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.FFilterSelf.pop();
            _loc1_++;
         }
         this.FFilterSelf.length = 0;
         _loc5_ = this.FGroupBattleData.RoomDetailInfo;
         _loc4_ = _loc5_.RoomPlayers;
         _loc2_ = _loc4_.Count;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = _loc4_.GetRoomPlayerByIndex(_loc1_);
            if(!(_loc3_ != null && _loc1_ == _loc5_.SelfIndex))
            {
               this.FFilterSelf.push(_loc3_);
            }
            _loc1_++;
         }
      }
      
      protected function UpdateHeroStatus() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUIHeroStatusInfo = null;
         var _loc4_:TRoomPlayer = null;
         var _loc5_:TRoomPlayers = null;
         _loc5_ = this.FGroupBattleData.RoomDetailInfo.RoomPlayers;
         _loc2_ = this.CAPACITY_HEROSTATUS;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FUIHeroStatusInfos[_loc1_];
            _loc4_ = _loc5_.GetRoomPlayerByIndex(_loc1_);
            _loc3_.Context = _loc4_;
            _loc3_.Update();
            _loc3_.Resource.visible = _loc4_ != null;
            _loc1_++;
         }
      }
      
      protected function UpdateBasicRoomInfo() : void
      {
         var _loc1_:TRoomDetailInfo = null;
         var _loc2_:uint = 0;
         var _loc3_:TGroupBattleLevel = null;
         var _loc4_:uint = 0;
         var _loc5_:int = 0;
         var _loc6_:uint = 0;
         var _loc7_:TRoomPlayer = null;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         _loc1_ = this.FGroupBattleData.RoomDetailInfo;
         _loc3_ = _loc1_.GroupBattleLevel;
         if(_loc3_ == null)
         {
            return;
         }
         this.FTF_RoomID.text = TUtilityString.Format(STRING_GROUPBATTLE.FORMAT_RoomID,_loc1_.RoomID);
         this.FTF_BattleName.text = _loc3_.LevelName;
         this.FTF_BattleLevel.text = SLogicsCore.Character.MainHero.GetLevelStrByLevel(_loc3_.OpenLevel);
         _loc2_ = _loc3_.PreLevel == 0 ? 0 : 1;
         this.FTF_Difficulty.text = STRING_GROUPBATTLE.STRING_Difficulty[_loc2_];
         this.FTF_RecoomendPopulation.text = "3";
         this.FTF_Expricence.text = STRING_GROUPBATTLE.STRING_ExpAward + _loc3_.ExpAward;
         this.FTF_SilverCoin.text = STRING_GROUPBATTLE.STRING_MoneyAward + _loc3_.MoneyAward;
         _loc6_ = _loc1_.RoomPlayers.Count;
         _loc5_ = 0;
         while(_loc5_ < _loc6_)
         {
            _loc7_ = _loc1_.RoomPlayers.GetRoomPlayerByIndex(_loc5_);
            if(_loc7_ != null)
            {
               _loc4_++;
            }
            _loc5_++;
         }
         this.FTF_Population.text = _loc4_ + "/3";
         this.FTF_Password.text = _loc1_.Password;
         _loc9_ = uint(!TUtilityString.Empty(_loc1_.Password));
         this.FMC_Option.gotoAndStop((_loc9_ + 1) % 2 + 1);
         this.FTF_RestPlayCount.text = TUtilityString.Format(STRING_GROUPBATTLE.FORMAT_RestPlayCount,this.FGroupBattleData.PVETimes);
         if(_loc1_.SelfIndex == _loc1_.HostIndex)
         {
            _loc8_ = 0;
         }
         else
         {
            _loc6_ = _loc1_.RoomPlayers.Count;
            _loc5_ = 0;
            while(_loc5_ < _loc6_)
            {
               _loc7_ = _loc1_.RoomPlayers.GetRoomPlayerByIndex(_loc5_);
               if((Boolean(_loc7_)) && _loc5_ == _loc1_.SelfIndex)
               {
                  break;
               }
               _loc5_++;
            }
            _loc8_ = _loc7_.IsReady;
         }
         if(_loc1_.HostIndex == _loc1_.SelfIndex)
         {
            if(this.FGroupBattleData.ReadyTimeStatus == 0)
            {
               this.FTF_Start.text = STRING_GROUPBATTLE.STRING_StartOrCancel[0];
            }
            else
            {
               this.FTF_Start.text = STRING_GROUPBATTLE.STRING_StartOrCancel[2];
            }
         }
         else
         {
            this.FTF_Start.text = STRING_GROUPBATTLE.STRING_StartOrCancel[_loc8_ + 1];
         }
         this.FMC_BattleChoose.visible = _loc1_.HostIndex == _loc1_.SelfIndex;
      }
      
      protected function CheckIsAllReady() : Boolean
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TRoomPlayer = null;
         var _loc4_:TRoomPlayers = null;
         _loc4_ = this.FGroupBattleData.RoomDetailInfo.RoomPlayers;
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
      
      protected function UpdateRewardSlots() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUISlot = null;
         var _loc4_:int = 0;
         var _loc5_:TGroupBattleLevel = null;
         var _loc6_:TInventory = null;
         _loc5_ = this.FGroupBattleData.RoomDetailInfo.GroupBattleLevel;
         this.FSlotMaxPages = _loc5_.AwardInventories.Count - 4;
         this.CheckSlotPageUI();
         _loc2_ = this.CAPACITY_SLOTS;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FUISlots[_loc1_];
            _loc4_ = _loc1_ + this.FSlotIndex;
            if(_loc4_ >= _loc5_.AwardInventories.Count)
            {
               _loc6_ = null;
            }
            else
            {
               _loc6_ = _loc5_.AwardInventories.GetInventoryByIndex(_loc4_);
            }
            _loc3_.Context = _loc6_;
            _loc3_.Resource.visible = _loc6_ != null;
            _loc1_++;
         }
      }
      
      protected function AutoStartMatch() : void
      {
         var _loc1_:TRoomDetailInfo = null;
         var _loc2_:TRoomPlayer = null;
         _loc1_ = this.FGroupBattleData.RoomDetailInfo;
         if(_loc1_.HostIndex == _loc1_.SelfIndex)
         {
            this.FCheckIsAllReady = true;
            if(this.CheckIsAllReady())
            {
               this.MCStartOnClick(null);
            }
         }
         else
         {
            _loc2_ = _loc1_.RoomPlayers.GetRoomPlayerByIndex(_loc1_.SelfIndex);
            if(!Boolean(_loc2_.IsReady))
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
         this.UpdateRewardSlots();
         this.CheckIsAutoStart();
      }
      
      protected function CheckSlotPageUI() : void
      {
         this.FMC_SlotLeft.visible = this.FSlotIndex > 0;
         this.FMC_SlotRight.visible = this.FSlotIndex != this.FSlotMaxPages;
      }
      
      protected function ProcessorWorldInviteOnClick(param1:Object) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_GroupBattlt_InviteAllPlayer_Req);
         _loc3_ = _loc2_.Data;
         _loc3_.writeByte(1);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function ProcessorInviteOnClick(param1:Object, param2:uint, param3:uint) : void
      {
         var _loc4_:TPacket = null;
         var _loc5_:ByteArray = null;
         _loc4_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_GroupBattlt_InvitePlayerShadow_Req);
         _loc5_ = _loc4_.Data;
         _loc5_.writeUnsignedInt(param2);
         _loc5_.writeUnsignedInt(param3);
         SNetworkCore.Transceiver.PacketTransmit(_loc4_);
      }
      
      protected function ProcessorOnClose(param1:Object) : void
      {
      }
      
      protected function ProcessorConfirmOnClick(param1:Object, param2:Object, param3:uint) : void
      {
         var _loc4_:TGroupBattleLevel = null;
         var _loc5_:TPacket = null;
         var _loc6_:ByteArray = null;
         var _loc7_:uint = 0;
         _loc4_ = param2 as TGroupBattleLevel;
         _loc5_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_GroupBattlt_PveChangeMission_Req);
         _loc6_ = _loc5_.Data;
         if(param3 == 1)
         {
            _loc7_ = _loc4_.PreLevel != 0 ? _loc4_.PreLevel : _loc4_.LevelID;
         }
         else
         {
            if(param3 != 2)
            {
               return;
            }
            _loc7_ = _loc4_.LevelID;
         }
         _loc6_.writeUnsignedInt(_loc7_);
         SNetworkCore.Transceiver.PacketTransmit(_loc5_);
      }
      
      protected function MCOptionOnClick(param1:MouseEvent) : void
      {
         var _loc2_:uint = 0;
         if(this.FPassword == "")
         {
            EffectGenerateText(STRING_GROUPBATTLE.STRING_InputPassword);
            return;
         }
         _loc2_ = uint(this.FMC_Option.currentFrame);
         this.FUIWindowConfirmation.Text = STRING_GROUPBATTLE.STRING_LockRoom[uint(Boolean(_loc2_ % 2))];
         this.FUIWindowConfirmation.Visible = true;
      }
      
      protected function MCAutoStartOptionOnClick(param1:MouseEvent) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:Boolean = false;
         _loc2_ = uint(this.FMC_AutoStartOption.currentFrame);
         if(_loc2_ == 2)
         {
            this.FMC_AutoStartOption.gotoAndStop(1);
            this.FGroupBattleData.IsAutoStartSign = true;
            this.AutoStartMatch();
         }
         else
         {
            this.FMC_AutoStartOption.gotoAndStop(2);
            this.FGroupBattleData.IsAutoStartSign = false;
            this.FCheckIsAllReady = false;
         }
      }
      
      protected function MCBattleChooseOnClick(param1:MouseEvent) : void
      {
         if(this.FIsMatching)
         {
            EffectGenerateText(STRING_GROUPBATTLE.STRING_Matching);
            return;
         }
         this.FProcessorWindowBattleChoose.Visible = true;
         this.FProcessorWindowBattleChoose.Update();
      }
      
      protected function MCInviteOnClick(param1:MouseEvent) : void
      {
         var _loc2_:TPacket = null;
         if(this.FIsMatching)
         {
            EffectGenerateText(STRING_GROUPBATTLE.STRING_Matching);
            return;
         }
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_GroupBattlt_ShadowList_Req);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function MCStartOnClick(param1:MouseEvent) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:TRoomPlayer = null;
         var _loc5_:TRoomPlayer = null;
         var _loc6_:uint = 0;
         _loc6_ = uint(this.FGroupBattleData.RoomDetailInfo.HostIndex);
         _loc4_ = this.FGroupBattleData.RoomDetailInfo.RoomPlayers.GetRoomPlayerByIndex(this.FGroupBattleData.RoomDetailInfo.SelfIndex);
         if(_loc6_ == this.FGroupBattleData.RoomDetailInfo.SelfIndex)
         {
            _loc3_ = this.FGroupBattleData.RoomDetailInfo.RoomPlayers.Count;
            _loc2_ = 0;
            while(_loc2_ < _loc3_)
            {
               _loc5_ = this.FGroupBattleData.RoomDetailInfo.RoomPlayers.GetRoomPlayerByIndex(_loc2_);
               if(_loc6_ != _loc2_)
               {
                  if(Boolean(_loc5_) && _loc5_.IsReady == 0)
                  {
                     EffectGenerateText(TUtilityString.Format(STRING_GROUPBATTLE.STRING_PleaseReady,_loc5_.PlayerName));
                     return;
                  }
               }
               _loc2_++;
            }
            this.ProcessorOnReadyTime(param1);
         }
         else
         {
            this.RoomInOperatingReq(_loc4_.IsReady == 0 ? CONST_GROUPBATTLE.RoomOperateReq_Ready : CONST_GROUPBATTLE.RoomOperateReq_CancelReady,_loc4_.PositionIndex,_loc4_.PositionIndex);
            if(_loc4_.IsReady != 0)
            {
               this.FMC_AutoStartOption.gotoAndStop(2);
               this.FGroupBattleData.IsAutoStartSign = false;
            }
         }
      }
      
      protected function MCExitOnClick(param1:MouseEvent) : void
      {
         this.BTNCloseOnClick(param1);
      }
      
      protected function ButtonHelpOnOver(param1:MouseEvent) : void
      {
         var _loc2_:TSystemLanguage = null;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.GroupBattleRoom) as TSystemLanguage;
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
         this.RoomInOperatingReq(CONST_GROUPBATTLE.RoomOperateReq_Leave,this.FGroupBattleData.RoomDetailInfo.SelfIndex,this.FGroupBattleData.RoomDetailInfo.SelfIndex);
         if(this.FOnReturnMainScene != null)
         {
            this.FOnReturnMainScene(this);
         }
         if(this.FGroupBattleData != null)
         {
            this.FIsMatching = false;
            this.FCheckIsAllReady = false;
            this.FGroupBattleData.ReadyTimeStatus = 0;
            this.FGroupBattleData.ReadyTimeTick = 0;
            this.FGroupBattleData.IsAutoStartSign = false;
         }
         if(this.FMC_AutoStartOption != null)
         {
            this.FMC_AutoStartOption.gotoAndStop(2);
         }
      }
      
      protected function ProcessorHeroInforOnClick(param1:Object, param2:String, param3:Object) : void
      {
         var _loc4_:TRoomPlayer = null;
         var _loc5_:TUIRoomPlayerInfo = null;
         _loc5_ = param1 as TUIRoomPlayerInfo;
         _loc4_ = param3 as TRoomPlayer;
         switch(param2)
         {
            case STRING_GROUPBATTLE.Command_LookUp:
               if(this.FShowOtherHeroInfor != null)
               {
                  this.FShowOtherHeroInfor(this,_loc4_.Identifier0,_loc4_.Identifier1);
               }
               break;
            case STRING_GROUPBATTLE.Command_Whisper:
               if(this.FRequestWhisper != null)
               {
                  this.FRequestWhisper(this,_loc4_.Identifier0,_loc4_.Identifier1,_loc4_.PlayerName);
               }
               break;
            case STRING_GROUPBATTLE.Command_KickOut:
               if(this.FGroupBattleData.RoomDetailInfo.SelfIndex == this.FGroupBattleData.RoomDetailInfo.HostIndex)
               {
                  this.RoomInOperatingReq(CONST_GROUPBATTLE.RoomOperateReq_Kick,this.FGroupBattleData.RoomDetailInfo.SelfIndex,_loc4_.PositionIndex);
               }
               else
               {
                  EffectGenerateText(STRING_GROUPBATTLE.STRING_NoOperating);
               }
               break;
            case STRING_GROUPBATTLE.Command_Transfer:
               if(this.FGroupBattleData.RoomDetailInfo.SelfIndex == this.FGroupBattleData.RoomDetailInfo.HostIndex)
               {
                  if(_loc4_.IsShadow)
                  {
                     EffectGenerateText(STRING_GROUPBATTLE.STRING_IsShadow);
                     return;
                  }
                  this.RoomInOperatingReq(CONST_GROUPBATTLE.RoomOperateReq_Transfer,this.FGroupBattleData.RoomDetailInfo.SelfIndex,_loc4_.PositionIndex);
               }
               else
               {
                  EffectGenerateText(STRING_GROUPBATTLE.STRING_NoOperating);
               }
         }
      }
      
      protected function SlotsOnQuerySequenceContext(param1:Object, param2:Object, param3:TQueryAnimationSequence, param4:uint = 0) : void
      {
         var _loc5_:TInventory = null;
         var _loc6_:TResourceRepositoryTexture = null;
         var _loc7_:TTexture = null;
         _loc5_ = param2 as TInventory;
         _loc6_ = SResourcesCore.TexturesInventory;
         _loc7_ = _loc6_.GetTextureByIdentifier(_loc5_.IDTexture);
         if(_loc7_ != null)
         {
            param3.Value = _loc7_.GetAnimationSequenceByIdentifier(param4);
         }
         else
         {
            _loc6_.LoadSecondary(_loc5_.IDTexture,CONST_MODULES.MODULE_GroupBattle);
         }
      }
      
      protected function SlotsOnQuerySubscript(param1:Object, param2:Object, param3:TQueryString) : void
      {
         var _loc4_:TAppliance = null;
         if(param2 is TAppliance)
         {
            _loc4_ = param2 as TAppliance;
            param3.Value = _loc4_.Quantity.toString();
         }
      }
      
      protected function UIComponentsHintOnOver(param1:Object, param2:Object) : void
      {
         var _loc3_:TInventory = null;
         var _loc4_:TOverlayer = null;
         _loc3_ = param2 as TInventory;
         switch(_loc3_.Category)
         {
            case CATEGORY_Equipment:
               _loc4_ = this.FOverlayerEquipment;
               break;
            case CATEGORY_Treasure:
               _loc4_ = this.FOverlayerTreasure;
               break;
            case CATEGORY_Accessories:
               _loc4_ = this.FOverlayerAccessory;
               break;
            default:
               _loc4_ = this.FOverlayerAppliance;
         }
         if(_loc4_ != null)
         {
            _loc4_.Context = _loc3_;
            _loc4_.Render(FUICore.MouseCoordinate);
            _loc4_.Show();
         }
      }
      
      protected function UIComponentsHintOnOut(param1:Object, param2:Object) : void
      {
         var _loc3_:TInventory = null;
         var _loc4_:TOverlayer = null;
         _loc3_ = param2 as TInventory;
         switch(_loc3_.Category)
         {
            case CATEGORY_Equipment:
               _loc4_ = this.FOverlayerEquipment;
               break;
            case CATEGORY_Treasure:
               _loc4_ = this.FOverlayerTreasure;
               break;
            case CATEGORY_Accessories:
               _loc4_ = this.FOverlayerAccessory;
               break;
            default:
               _loc4_ = this.FOverlayerAppliance;
         }
         if(_loc4_ != null)
         {
            _loc4_.Hide();
         }
      }
      
      protected function OnTextFocusIn(param1:FocusEvent) : void
      {
         var _loc2_:Boolean = false;
         _loc2_ = this.FGroupBattleData.RoomDetailInfo.HostIndex == this.FGroupBattleData.RoomDetailInfo.SelfIndex;
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
      
      protected function WindowConfirmationOnOK(param1:Object) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         var _loc4_:uint = 0;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_GroupBattlt_ChangePassword_Req);
         _loc3_ = _loc2_.Data;
         _loc4_ = uint(this.FMC_Option.currentFrame);
         if(Boolean(_loc4_ % 2))
         {
            this.FPassword = "";
            this.FTF_Password.text = this.FPassword;
         }
         TUtilityString.FlushUTF(_loc3_,this.FPassword);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function MCSlotLeftOnClick(param1:MouseEvent) : void
      {
         --this.FSlotIndex;
         if(this.FSlotIndex <= 0)
         {
            this.FSlotIndex = 0;
         }
         this.UpdateRewardSlots();
         this.CheckSlotPageUI();
      }
      
      protected function MCSlotRightOnClick(param1:MouseEvent) : void
      {
         ++this.FSlotIndex;
         if(this.FSlotIndex >= this.FSlotMaxPages)
         {
            this.FSlotIndex = this.FSlotMaxPages;
         }
         this.UpdateRewardSlots();
         this.CheckSlotPageUI();
      }
      
      protected function RoomInOperatingReq(param1:uint, param2:uint, param3:uint) : void
      {
         var _loc4_:TPacket = null;
         var _loc5_:ByteArray = null;
         _loc4_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_GroupBattlt_RoomInOperating_Req);
         _loc5_ = _loc4_.Data;
         _loc5_.writeByte(param1);
         _loc5_.writeByte(param2);
         _loc5_.writeByte(param3);
         SNetworkCore.Transceiver.PacketTransmit(_loc4_);
      }
      
      protected function ProcessorOnCloseWindowBattleReady(param1:Object) : void
      {
      }
      
      protected function ProcessorOnReadyTime(param1:Object) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         this.FIsMatching = Boolean(this.FGroupBattleData.ReadyTimeStatus != 0);
         if(param1 == null && this.FIsMatching)
         {
            return;
         }
         if(this.FProcessorWindowBattleReady.Visible)
         {
            return;
         }
         if(this.FGroupBattleData.SendReadyTimeStatusReq)
         {
            return;
         }
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_GroupBattlt_ReadyTimeStatus_Req);
         _loc3_ = _loc2_.Data;
         _loc3_.writeUnsignedInt((this.FGroupBattleData.ReadyTimeStatus + 1) % 2);
         if(this.FGroupBattleData.ReadyTimeStatus == 1)
         {
            this.FCheckIsAllReady = false;
            this.FMC_AutoStartOption.gotoAndStop(2);
            this.FGroupBattleData.IsAutoStartSign = false;
         }
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
         this.FGroupBattleData.SendReadyTimeStatusReq = true;
      }
      
      protected function ProcessorOnReadyBattle(param1:Object) : void
      {
         var _loc2_:TPacket = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_GroupBattlt_StartGame_Req);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function ProcessorOnStartBattle(param1:Object) : void
      {
         var _loc2_:TPacket = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_GroupBattlt_StartFightPVE_Req);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function CheckIsAutoStart() : void
      {
         if(this.FCheckIsAllReady && !this.FGroupBattleData.IsInBattle)
         {
            if(this.CheckIsAllReady())
            {
               this.MCStartOnClick(null);
            }
         }
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
         super.Mount(param1);
         if(!FIsResourcesLoadCompleted)
         {
            this.Load();
            this.FProcessorWindowBattleChoose.Load();
            this.FProcessorWindowInviteList.Load();
            this.FProcessorWindowBattleReady.Load();
            return;
         }
         SLogicsCore.Character.RoleSencePosition = CONST_COMMON.SCENEPOSITION_GroupBattle;
         this.UpdateUI();
         if(this.FOnSetGroupBattleChannel != null)
         {
            this.FOnSetGroupBattleChannel(this,CONST_CHAT.CHANNEL_TYPE_Team,true);
         }
      }
      
      override public function Unmount() : void
      {
         super.Unmount();
         if(this.FProcessorWindowBattleReady != null)
         {
            this.FProcessorWindowBattleReady.Visible = false;
         }
         this.Reset();
         if(this.FOnSetGroupBattleChannel != null)
         {
            this.FOnSetGroupBattleChannel(this,CONST_CHAT.CHANNEL_TYPE_Team,false);
         }
      }
      
      public function OnRoomUpdata() : void
      {
         if(!FIsResourcesLoadCompleted)
         {
            return;
         }
         if(!Visible)
         {
            return;
         }
         this.Reset();
         this.UpdateUI();
         if(this.FProcessorWindowBattleReady.Visible)
         {
            this.FProcessorWindowBattleReady.Update();
            this.FProcessorWindowBattleReady.UpdatePlayerPosition();
         }
      }
      
      public function OnResetRoomAutoOnMatching(param1:Boolean) : void
      {
         if(!FIsResourcesLoadCompleted)
         {
            return;
         }
         if(!Visible)
         {
            return;
         }
         if(!param1)
         {
            if(!this.FIsMatching)
            {
               return;
            }
         }
         this.FIsMatching = false;
         this.FCheckIsAllReady = false;
         this.FMC_AutoStartOption.gotoAndStop(2);
         this.FGroupBattleData.IsAutoStartSign = false;
      }
      
      public function OnShowWindowReady(param1:Object) : void
      {
         this.FProcessorWindowBattleReady.Visible = true;
         this.FProcessorWindowBattleReady.Update();
      }
      
      public function OnWindowReadyUpdata(param1:Object) : void
      {
         this.FProcessorWindowBattleReady.Update();
         this.FProcessorWindowBattleReady.UpdatePlayerPosition();
      }
      
      public function UpdateInviteShadows() : void
      {
         this.FProcessorWindowInviteList.Update();
         this.FProcessorWindowInviteList.Visible = true;
      }
      
      public function CloseBattleSelectWindow() : void
      {
         this.FProcessorWindowBattleChoose.Visible = false;
      }
      
      public function CheckAutoStart() : void
      {
         if(this.FGroupBattleData.IsAutoStartSign)
         {
            this.AutoStartMatch();
         }
      }
      
      public function Reset() : void
      {
         this.FSlotIndex = 0;
      }
   }
}

