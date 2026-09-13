package Processors.Game.Lobby.TopTeam
{
   import Foundation.Common.THint;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.GroupBattle.TRoomPlayer;
   import Logics.GroupBattle.TRoomPlayers;
   import Logics.SLogicsCore;
   import Logics.Streamization.TopTeam.TUnstreamizerTopTeam;
   import Logics.TopTeam.THallPlayer;
   import Logics.TopTeam.TTopTeamData;
   import Logics.TopTeam.TTopTeamRoom;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import Processors.Game.Lobby.TopTeam.Window.TProcessorWindowNinjaPointMall;
   import Processors.Game.Lobby.TopTeam.Window.TProcessorWindowNinjaRank;
   import Processors.Game.Lobby.TopTeam.Window.TProcessorWindowTopTeam;
   import Processors.Game.Lobby.TopTeam.Window.TProcessorWindowTopTeamRoonList;
   import Rendering.Overlayers.HelpTips.TOverlayerHelpTips;
   import Rendering.Overlayers.Hints.TOverlayerHint;
   import Rendering.Overlayers.Inventories.TOverlayerAccessory;
   import Rendering.Overlayers.Inventories.TOverlayerAppliance;
   import Rendering.Overlayers.Inventories.TOverlayerEquipment;
   import Rendering.Overlayers.Inventories.TOverlayerTreasure;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_CONFIGVALUE;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_SHORTCUTS;
   import Resources.Constants.CONST_TOPTEAM;
   import Resources.Strings.STRING_TOPTEAM;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.utils.ByteArray;
   
   public class TProcessorTopTeam extends TProcessorLobbyWindows
   {
      
      protected var FProcessorWindowNinjaRank:TProcessorWindowNinjaRank;
      
      protected var FProcessorWindowTopTeam:TProcessorWindowTopTeam;
      
      protected var FProcessorWindowNinjaPointMall:TProcessorWindowNinjaPointMall;
      
      protected var FProcessorWindowTopTeamRoonList:TProcessorWindowTopTeamRoonList;
      
      protected var FTopTeamData:TTopTeamData;
      
      protected var FUnstreamizerTopTeam:TUnstreamizerTopTeam;
      
      protected var FRoomID:uint;
      
      protected var FIconOpenLevel:uint;
      
      protected var FOpenSign:Boolean;
      
      protected var FOnEnterPlayerRoom:Function;
      
      protected var FOnInitBattle:Function;
      
      protected var FOnSetTopTeamBattleType:Function;
      
      protected var FOnSetTopTeamBattleInfor:Function;
      
      protected var FOnSetTopTeamBattleReward:Function;
      
      protected var FOnUpdateRoomData:Function;
      
      protected var FUpdateActivityStatus:Function;
      
      protected var FOnUpdateInviteList:Function;
      
      protected var FOnApplyCaptain:Function;
      
      protected var FOnExitRoom:Function;
      
      protected var FOnUpdateTop:Function;
      
      protected var FOnOpenTopTeamWindow:Function;
      
      protected var FOnMatchSuccess:Function;
      
      protected var FOnCloseBattleRoomUI:Function;
      
      protected var FOnEffectSign:Function;
      
      protected var FBeginSkillShow:Function;
      
      public function TProcessorTopTeam(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.Init();
         SetUIModuleID(CONST_MODULES.MODULE_TopTeam);
      }
      
      protected function Init() : void
      {
         this.FProcessorWindowTopTeam = new TProcessorWindowTopTeam(this);
         this.FProcessorWindowTopTeam.OnClose = this.ProcessorWindowOnClose;
         this.FProcessorWindowTopTeam.NinjaPointMallOnClick = this.ProcessorNinjaPointMallOnClick;
         this.FProcessorWindowTopTeam.NinjaRankOnClick = this.ProcessorNinjaRankOnClick;
         this.FProcessorWindowTopTeam.HintOnMove = this.UIHintOnOver;
         this.FProcessorWindowTopTeam.HintOnOut = this.UIHintOnOut;
         this.FProcessorWindowTopTeam.OnHelpTipsOver = this.UIHelpHintOnOver;
         this.FProcessorWindowTopTeam.OnHelpTipsOut = this.UIHelpHintOnOut;
         this.FProcessorWindowTopTeamRoonList = new TProcessorWindowTopTeamRoonList(this);
         this.FProcessorWindowTopTeamRoonList.OnClose = this.ProcessorWindowOnClose;
         this.FProcessorWindowTopTeamRoonList.CreateRoomOnClick = this.ProcessorCreateRoomOnClick;
         this.FProcessorWindowTopTeamRoonList.EnterRoomOnClick = this.ProcessorEnterRoomOnClick;
         this.FProcessorWindowTopTeamRoonList.NinjaPointMallOnClick = this.ProcessorNinjaPointMallOnClick;
         this.FProcessorWindowTopTeamRoonList.NinjaRankOnClick = this.ProcessorNinjaRankOnClick;
         this.FProcessorWindowTopTeamRoonList.OnEffectText = this.ProcessorOnEffectText;
         this.FProcessorWindowNinjaRank = new TProcessorWindowNinjaRank(this);
         this.FProcessorWindowNinjaPointMall = new TProcessorWindowNinjaPointMall(this);
         this.FProcessorWindowNinjaPointMall.SlotOnOver = UIComponentsHintOnOver;
         this.FProcessorWindowNinjaPointMall.SlotOnOut = UIComponentsHintOnOut;
         this.FProcessorWindowNinjaPointMall.OnClose = this.ProcessorWindowOnClose;
         this.FProcessorWindowNinjaPointMall.HelpHintOnOver = this.UIHelpHintOnOver;
         this.FProcessorWindowNinjaPointMall.HelpHintOnOut = this.UIHelpHintOnOut;
         this.FProcessorWindowNinjaPointMall.OnEffectText = this.ProcessorOnEffectText;
         this.FProcessorWindowNinjaPointMall.OnMallBuy = this.ProcessorOnMallBuy;
         this.FTopTeamData = SLogicsCore.TopTeamData;
         this.FUnstreamizerTopTeam = new TUnstreamizerTopTeam();
         FOverlayerEquipment = new TOverlayerEquipment(this,CONST_MODULES.MODULE_TopTeam);
         FOverlayerEquipment.Visible = false;
         FOverlayerTreasure = new TOverlayerTreasure(this,CONST_MODULES.MODULE_TopTeam);
         FOverlayerTreasure.Visible = false;
         FOverlayerAppliance = new TOverlayerAppliance(this,CONST_MODULES.MODULE_TopTeam);
         FOverlayerAppliance.Visible = false;
         FOverlayerHelpTips = new TOverlayerHelpTips(this);
         FOverlayerHelpTips.Visible = false;
         FOverlayerAccessory = new TOverlayerAccessory(this,CONST_MODULES.MODULE_TopTeam);
         FOverlayerAccessory.Visible = false;
         FOverlayerHint = new TOverlayerHint(this);
         FOverlayerHint.Visible = false;
         this.FOpenSign = false;
      }
      
      public function set BeginSkillShow(param1:Function) : void
      {
         this.FBeginSkillShow = param1;
      }
      
      protected function BeginSkillShowF(param1:uint) : void
      {
         if(this.FBeginSkillShow != null)
         {
            this.FBeginSkillShow(param1);
         }
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_TOPTEAM.RESOURCESID_Swf_TOPTEAM);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TopTeam_Sys_Open_Ret,this.PerformPacket_SC_Sys_Open_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TopTeam_Left_Btl_Cnt_Ret,this.PerformPacket_SC_Left_Btl_Cnt_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TopTeam_In_Hall_Ret,this.PerformPacket_SC_In_Hall_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TopTeam_Hall_Data_Ret,this.PerformPacket_SC_Hall_Data_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TopTeam_Room_Leave_Ret,this.PerformPacket_SC_Room_Leave_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TopTeam_Create_Room_Ret,this.PerformPacket_SC_Create_Room_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TopTeam_Join_Room_Ret,this.PerformPacket_SC_Join_Room_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TopTeam_Room_Data_Ret,this.PerformPacket_SC_Room_Data_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TopTeam_TUser_Ret,this.PerformPacket_SC_TUser_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TopTeam_Change_Ready_Ret,this.PerformPacket_SC_Change_Ready_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TopTeam_Change_Ready_Notify,this.PerformPacket_SC_Change_Ready_Notify);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TopTeam_Match_Ret,this.PerformPacket_SC_Match_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TopTeam_Embattle_Ret,this.PerformPacket_SC_Embattle_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TopTeam_Cancel_Match_Ret,this.PerformPacket_SC_Cancel_Match_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TopTeam_Leave_Room_Ret,this.PerformPacket_SC_Leave_Room_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TopTeam_Top_Ret,this.PerformPacket_SC_Top_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TopTeam_Hall_Data_Notify,this.PerformPacket_SC_Hall_Data_Notify);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TopTeam_BattleInfo_Ret,this.PerformPacket_SC_TopTeam_BattleInfo_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TopTeam_BattleReward_Ret,this.PerformPacket_SC_TopTeam_BattleReward_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TopTeam_BattleInit_Ret,this.PerformPacket_SC_TopTeam_BattleInit_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TopTeam_Charge_Ret,this.PerformPacket_SC_TopTeam_Charge_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TopTeam_LoadPointShopInfo_Ret,this.PerformPacket_SC_TopTeam_LoadPointShopInfo_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TopTeam_Set_Password_Ret,this.PerformPacket_SC_Set_Password_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TopTeam_Set_Captain_Ret,this.PerformPacket_SC_Set_Captain_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TopTeam_Apply_Captain_Ret,this.PerformPacket_SC_Apply_Captain_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TopTeam_T_Ret,this.PerformPacket_SC_T_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TopTeam_Approve_Ret,this.PerformPacket_SC_Approve_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TopTeam_Hall_Users_Ret,this.PerformPacket_SC_Hall_Users_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TopTeam_Hall_User_Change_Ret,this.PerformPacket_SC_Hall_User_Change_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TopTeam_User_Top_No_Ret,this.PerformPacket_SC_User_Top_No_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TopTeam_Get_Invite_User_List_Ret,this.PerformPacket_SC_Get_Invite_User_List_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TopTeam_Invite_Ret,this.PerformPacket_SC_TopTeam_Invite_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TopTeam_Shortcut_Invite_Ret,this.PerformPacket_SC_Shortcut_Invite_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TopTeam_World_Invite_Ret,this.PerformPacket_SC_World_Invite_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TopTeam_Icon_Ret,this.PerformPacket_SC_Icon_Ret);
         super.PacketRegisterRoutines();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerEquipment);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerTreasure);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerAppliance);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerHelpTips);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerAccessory);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerHint);
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         var _loc1_:TConfigValue = null;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.TEAMBATTLE_OPENLEVEL) as TConfigValue;
         this.FIconOpenLevel = _loc1_.Value as uint;
         super.ResourcesPerform_UILocations();
      }
      
      protected function PerformPacket_SC_Sys_Open_Ret(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:Boolean = false;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ == 0)
         {
            EffectGenerateText(STRING_TOPTEAM.STRING_FunctionNoOpen);
            return;
         }
         if(_loc3_ == 1 || _loc3_ == 4)
         {
            if(this.FOpenSign)
            {
               this.FOpenSign = false;
               return;
            }
            if(this.FOnOpenTopTeamWindow != null)
            {
               this.FOnOpenTopTeamWindow(this);
            }
         }
         else if(_loc3_ == 2 || _loc3_ == 3)
         {
            if(_loc3_ == 2)
            {
               _loc4_ = this.FTopTeamData.RestPlayCount > 0;
            }
            else
            {
               _loc4_ = false;
            }
            if(this.FOnEffectSign != null)
            {
               this.FOnEffectSign(CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_TopTeam,_loc4_);
            }
            if(this.FTopTeamData.FunctionIsOpen != _loc3_)
            {
               ProcessorClose();
               this.FProcessorWindowTopTeamRoonList.Visible = false;
               this.FProcessorWindowNinjaRank.Visible = false;
               this.FProcessorWindowTopTeam.Visible = false;
               if(SLogicsCore.Character.RoleSencePosition != CONST_COMMON.SCENEPOSITION_TopTeam)
               {
                  return;
               }
               if(this.FOnCloseBattleRoomUI != null)
               {
                  this.FOnCloseBattleRoomUI(this);
               }
            }
         }
         this.FTopTeamData.FunctionIsOpen = _loc3_;
      }
      
      protected function PerformPacket_SC_Left_Btl_Cnt_Ret(param1:TPacket) : void
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
         _loc3_ = _loc2_.readUnsignedInt();
         this.FTopTeamData.RestPlayCount = _loc3_;
         if(_loc3_ == 0)
         {
            if(this.FOnEffectSign != null)
            {
               this.FOnEffectSign(CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_TopTeam,false);
            }
         }
         if(FIsResourcesLoadCompleted)
         {
            if(this.FTopTeamData.FunctionIsOpen == 2 || this.FTopTeamData.FunctionIsOpen == 1)
            {
               this.FTopTeamData.IsStayHall = 1;
               this.PerformPacket_CS_In_Hall_Req(1);
            }
            else if(this.FTopTeamData.FunctionIsOpen == 3 || this.FTopTeamData.FunctionIsOpen == 4)
            {
               this.FProcessorWindowTopTeam.Visible = true;
               this.FProcessorWindowTopTeamRoonList.Visible = false;
               this.FProcessorWindowTopTeam.Update();
            }
         }
      }
      
      protected function PerformPacket_SC_In_Hall_Ret(param1:TPacket) : void
      {
         if(Boolean(this.FTopTeamData.IsStayHall))
         {
            this.PerformPacket_CS_Hall_Data_Req();
            this.PerformPacket_CS_Hall_Users_Req();
         }
      }
      
      protected function PerformPacket_SC_Hall_Data_Ret(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = param1.Data;
         this.FUnstreamizerTopTeam.UnstreamizeTopTeamRooms(_loc2_,this.FTopTeamData.TopTeamRooms,null);
         if(FIsResourcesLoadCompleted)
         {
            if(SLogicsCore.Character.RoleSencePosition == CONST_COMMON.SCENEPOSITION_TopTeam)
            {
               return;
            }
            this.FProcessorWindowTopTeamRoonList.Visible = true;
            this.FProcessorWindowTopTeamRoonList.Update();
         }
      }
      
      protected function PerformPacket_SC_Room_Leave_Ret(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:TTopTeamRoom = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         this.FTopTeamData.TopTeamRooms.DeleteTopTeamRoomByRoomID(_loc3_);
         if(FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowTopTeamRoonList.Update();
         }
      }
      
      protected function PerformPacket_SC_Create_Room_Ret(param1:TPacket) : void
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
         this.PerformPacket_CS_Room_Data_Req(_loc4_);
      }
      
      protected function PerformPacket_SC_Join_Room_Ret(param1:TPacket) : void
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
         EffectGenerateText(STRING_TOPTEAM.STRING_JoinExccess);
         _loc4_ = _loc2_.readUnsignedInt();
         this.PerformPacket_CS_Room_Data_Req(_loc4_);
      }
      
      protected function PerformPacket_SC_Room_Data_Ret(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = param1.Data;
         this.FUnstreamizerTopTeam.UnstreamizeRoomDetailInfo(_loc2_,this.FTopTeamData.TopTeamRoomDetailInfo,null);
         if(this.FOnEnterPlayerRoom != null)
         {
            this.FOnEnterPlayerRoom(this);
         }
         this.FRoomID = 0;
         this.PerformPacket_CS_In_Hall_Req(0);
      }
      
      protected function PerformPacket_SC_TUser_Ret(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         _loc4_ = _loc2_.readUnsignedInt();
         this.FTopTeamData.TopTeamRoomDetailInfo.RoomPlayers.DeleteRoomPlayerByIdentifier(_loc3_,_loc4_);
         if(_loc3_ == SLogicsCore.Character.Identifier0 && _loc4_ == SLogicsCore.Character.Identifier1)
         {
            this.PerformPacket_CS_Left_Btl_Cnt_Req();
            if(this.FOnExitRoom != null)
            {
               this.FOnExitRoom(this);
            }
         }
         else
         {
            this.PerformPacket_CS_Room_Data_Req(this.FTopTeamData.TopTeamRoomDetailInfo.RoomID);
         }
      }
      
      protected function PerformPacket_SC_Change_Ready_Ret(param1:TPacket) : void
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
      }
      
      protected function PerformPacket_SC_Change_Ready_Notify(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:TRoomPlayer = null;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         _loc2_ = param1.Data;
         _loc5_ = _loc2_.readUnsignedInt();
         _loc6_ = _loc2_.readUnsignedInt();
         _loc3_ = _loc2_.readUnsignedInt();
         _loc4_ = this.FTopTeamData.TopTeamRoomDetailInfo.RoomPlayers.GetRoomPlayerByIdentifier(_loc5_,_loc6_);
         if(_loc4_ != null)
         {
            _loc4_.IsReady = _loc3_;
         }
         if(this.FOnUpdateRoomData != null)
         {
            this.FOnUpdateRoomData(this);
         }
      }
      
      protected function PerformPacket_SC_Match_Ret(param1:TPacket) : void
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
         this.FTopTeamData.MatchStatus = 1;
         if(this.FOnMatchSuccess != null)
         {
            this.FOnMatchSuccess(this);
         }
      }
      
      protected function PerformPacket_SC_Embattle_Ret(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:TRoomPlayer = null;
         var _loc5_:int = 0;
         var _loc6_:uint = 0;
         var _loc7_:int = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc6_ = uint(_loc2_.readShort());
         _loc5_ = 0;
         while(_loc5_ < _loc6_)
         {
            _loc8_ = _loc2_.readUnsignedInt();
            _loc9_ = _loc2_.readUnsignedInt();
            _loc4_ = this.FTopTeamData.TopTeamRoomDetailInfo.RoomPlayers.GetRoomPlayerByIdentifier(_loc8_,_loc9_);
            if(_loc4_ != null)
            {
               _loc4_.PositionIndex = _loc2_.readUnsignedInt() - 1;
            }
            _loc5_++;
         }
         if(this.FOnUpdateRoomData != null)
         {
            this.FOnUpdateRoomData(this);
         }
      }
      
      protected function PerformPacket_SC_Cancel_Match_Ret(param1:TPacket) : void
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
         this.FTopTeamData.MatchStatus = 0;
         if(this.FOnMatchSuccess != null)
         {
            this.FOnMatchSuccess(this);
         }
      }
      
      protected function PerformPacket_SC_Leave_Room_Ret(param1:TPacket) : void
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
      }
      
      protected function PerformPacket_SC_Top_Ret(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = param1.Data;
         this.FUnstreamizerTopTeam.UnstreamizeTopTeamRanks(_loc2_,this.FTopTeamData.TopTeamRanks,null);
         this.FTopTeamData.MyRank = _loc2_.readUnsignedInt();
         if(this.FOnUpdateTop != null)
         {
            this.FOnUpdateTop(this);
         }
         if(!Visible)
         {
            return;
         }
         if(FIsResourcesLoadCompleted)
         {
            if(SLogicsCore.Character.RoleSencePosition == CONST_COMMON.SCENEPOSITION_TopTeam)
            {
               return;
            }
            this.FProcessorWindowNinjaRank.UpdateRankings();
            this.FProcessorWindowNinjaRank.Visible = true;
         }
      }
      
      protected function PerformPacket_SC_Hall_Data_Notify(param1:TPacket) : void
      {
         this.FUnstreamizerTopTeam.UnstreamizeHall_Data_Notify(param1.Data,this.FTopTeamData.TopTeamRooms,null);
         if(FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowTopTeamRoonList.Update();
         }
      }
      
      protected function PerformPacket_SC_TopTeam_BattleInfo_Ret(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = param1.Data;
         if(this.FOnSetTopTeamBattleInfor != null)
         {
            this.FOnSetTopTeamBattleInfor(this,_loc2_);
         }
      }
      
      protected function PerformPacket_SC_TopTeam_BattleReward_Ret(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = param1.Data;
         if(this.FOnSetTopTeamBattleReward != null)
         {
            this.FOnSetTopTeamBattleReward(this,_loc2_);
         }
         this.FTopTeamData.IsInBattle = true;
         --this.FTopTeamData.RestPlayCount;
      }
      
      protected function PerformPacket_SC_TopTeam_BattleInit_Ret(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = param1.Data;
         if(this.FOnInitBattle != null)
         {
            this.FOnInitBattle(this,true,1);
         }
         if(this.FOnSetTopTeamBattleType != null)
         {
            this.FOnSetTopTeamBattleType(this,_loc2_);
         }
      }
      
      protected function PerformPacket_SC_TopTeam_Charge_Ret(param1:TPacket) : void
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
         EffectGenerateText(STRING_TOPTEAM.STRING_ChargeSuccess);
         _loc4_ = _loc2_.readUnsignedInt();
         this.FTopTeamData.NinjaPoint = _loc2_.readUnsignedInt();
         this.FProcessorWindowNinjaPointMall.UpdateNinjaPointUI();
      }
      
      protected function PerformPacket_SC_TopTeam_LoadPointShopInfo_Ret(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = param1.Data;
         this.FTopTeamData.NinjaPoint = _loc2_.readUnsignedInt();
         this.FProcessorWindowNinjaPointMall.UpdateNinjaPointUI();
      }
      
      protected function PerformPacket_SC_Set_Password_Ret(param1:TPacket) : void
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
         this.FTopTeamData.TopTeamRoomDetailInfo.Password = TUtilityString.FetchUTF(_loc2_);
         if(this.FOnUpdateRoomData != null)
         {
            this.FOnUpdateRoomData(this);
         }
      }
      
      protected function PerformPacket_SC_Set_Captain_Ret(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc4_ = _loc2_.readUnsignedInt();
         _loc5_ = _loc2_.readUnsignedInt();
         this.SetCaptain(_loc4_,_loc5_);
         if(this.FOnUpdateRoomData != null)
         {
            this.FOnUpdateRoomData(this);
         }
      }
      
      protected function PerformPacket_SC_Apply_Captain_Ret(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc4_ = _loc2_.readUnsignedInt();
         _loc5_ = _loc2_.readUnsignedInt();
         if(_loc4_ == SLogicsCore.Character.Identifier0 && _loc5_ == SLogicsCore.Character.Identifier1)
         {
            return;
         }
         if(this.FOnApplyCaptain != null)
         {
            this.FOnApplyCaptain(this,_loc4_,_loc5_);
         }
      }
      
      protected function PerformPacket_SC_T_Ret(param1:TPacket) : void
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
      }
      
      protected function PerformPacket_SC_Approve_Ret(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc5_ = _loc2_.readUnsignedInt();
         _loc6_ = _loc2_.readUnsignedInt();
         _loc4_ = _loc2_.readUnsignedInt();
         if(_loc4_ == 0)
         {
            this.SetCaptain(_loc5_,_loc6_);
         }
      }
      
      protected function SetCaptain(param1:uint, param2:uint) : void
      {
         var _loc3_:TRoomPlayer = null;
         var _loc4_:TRoomPlayers = null;
         var _loc5_:int = 0;
         var _loc6_:uint = 0;
         this.FTopTeamData.IsAutoStartSign = false;
         _loc4_ = this.FTopTeamData.TopTeamRoomDetailInfo.RoomPlayers;
         _loc6_ = _loc4_.Count;
         _loc5_ = 0;
         while(_loc5_ < _loc6_)
         {
            _loc3_ = _loc4_.GetRoomPlayerByIndex(_loc5_);
            if(_loc3_ != null)
            {
               if(_loc3_.Identifier0 == param1 && _loc3_.Identifier1 == param2)
               {
                  _loc3_.IsCaptaian = 1;
                  _loc3_.IsReady = 1;
               }
               else
               {
                  _loc3_.IsCaptaian = 0;
                  _loc3_.IsReady = 0;
               }
            }
            _loc5_++;
         }
      }
      
      protected function PerformPacket_SC_Hall_Users_Ret(param1:TPacket) : void
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
         this.FUnstreamizerTopTeam.UnstreamizeHall_Player_List(_loc2_,this.FTopTeamData.HallPlayers,null);
         if(FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowTopTeamRoonList.Update();
         }
      }
      
      protected function PerformPacket_SC_Hall_User_Change_Ret(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:THallPlayer = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         _loc4_ = _loc2_.readUnsignedInt();
         _loc5_ = _loc2_.readUnsignedInt();
         _loc6_ = this.FTopTeamData.HallPlayers.GetHallPlayerByIdentifier(_loc4_,_loc5_);
         if(_loc3_ == 0)
         {
            if(_loc6_ != null)
            {
               return;
            }
            _loc6_ = new THallPlayer(_loc4_,_loc5_);
            _loc6_.Name = TUtilityString.FetchUTF(_loc2_);
            _loc6_.Level = _loc2_.readUnsignedInt();
            _loc6_.Job = _loc2_.readUnsignedInt();
            _loc6_.EnterTime = _loc2_.readUnsignedInt();
            this.FTopTeamData.HallPlayers.Add(_loc6_);
         }
         else
         {
            this.FTopTeamData.HallPlayers.Delete(_loc4_,_loc5_);
         }
         if(FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowTopTeamRoonList.Update();
         }
      }
      
      protected function PerformPacket_SC_User_Top_No_Ret(param1:TPacket) : void
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
         this.FTopTeamData.MyRank = _loc2_.readUnsignedInt();
      }
      
      protected function PerformPacket_SC_Get_Invite_User_List_Ret(param1:TPacket) : void
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
         this.FUnstreamizerTopTeam.UnstreamizeInviteList(_loc2_,this.FTopTeamData.InviteList,null);
         this.FTopTeamData.RapidInviteTime = _loc2_.readUnsignedInt();
         this.FTopTeamData.WorldInviteTime = _loc2_.readUnsignedInt();
         if(this.FOnUpdateInviteList != null)
         {
            this.FOnUpdateInviteList(this);
         }
      }
      
      protected function PerformPacket_SC_TopTeam_Invite_Ret(param1:TPacket) : void
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
      }
      
      protected function PerformPacket_SC_Shortcut_Invite_Ret(param1:TPacket) : void
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
         this.FTopTeamData.RapidInviteTime = _loc2_.readUnsignedInt();
      }
      
      protected function PerformPacket_SC_World_Invite_Ret(param1:TPacket) : void
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
         this.FTopTeamData.WorldInviteTime = _loc2_.readUnsignedInt();
      }
      
      protected function PerformPacket_SC_Icon_Ret(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:Boolean = false;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ == 2)
         {
            _loc4_ = this.FTopTeamData.RestPlayCount > 0;
         }
         else
         {
            _loc4_ = false;
         }
         if(this.FOnEffectSign != null)
         {
            this.FOnEffectSign(CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_TopTeam,_loc4_);
         }
      }
      
      protected function PerformPacket_CS_Room_Data_Req(param1:uint) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TopTeam_Room_Data_Req);
         _loc3_ = _loc2_.Data;
         _loc3_.writeUnsignedInt(param1);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function PerformPacket_CS_Top_Req() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TopTeam_Top_Req);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PerformPacket_CS_In_Hall_Req(param1:uint) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TopTeam_In_Hall_Req);
         _loc3_ = _loc2_.Data;
         _loc3_.writeUnsignedInt(param1);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function PerformPacket_CS_Hall_Data_Req() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TopTeam_Hall_Data_Req);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PerformPacket_CS_Hall_Users_Req() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TopTeam_Hall_Users_Req);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PerformPacket_CS_Left_Btl_Cnt_Req() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TopTeam_Left_Btl_Cnt_Req);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PerformPacket_CS_LoadPointShopInfo_Req() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TopTeam_LoadPointShopInfo_Req);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PacketPerform_CS_IsOpenTopTeamIcon() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TopTeam_Sys_Open_Req);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function ProcessorNinjaPointMallOnClick(param1:Object) : void
      {
         this.PerformPacket_CS_LoadPointShopInfo_Req();
         this.FProcessorWindowNinjaPointMall.Visible = true;
         this.FProcessorWindowNinjaPointMall.Update();
      }
      
      protected function ProcessorNinjaRankOnClick(param1:Object) : void
      {
         this.PerformPacket_CS_Top_Req();
      }
      
      protected function ProcessorOnEffectText(param1:String) : void
      {
         EffectGenerateText(param1);
      }
      
      protected function ProcessorWindowOnClose(param1:Object) : void
      {
         ProcessorClose();
      }
      
      protected function ProcessorOnMallBuy(param1:Object, param2:uint, param3:uint) : void
      {
         var _loc4_:TPacket = null;
         var _loc5_:ByteArray = null;
         _loc4_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TopTeam_Charge_Req);
         _loc5_ = _loc4_.Data;
         _loc5_.writeUnsignedInt(param3);
         _loc5_.writeUnsignedInt(param2);
         SNetworkCore.Transceiver.PacketTransmit(_loc4_);
      }
      
      protected function ProcessorCreateRoomOnClick(param1:Object) : void
      {
         var _loc2_:TPacket = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TopTeam_Create_Room_Req);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function ProcessorEnterRoomOnClick(param1:Object, param2:int, param3:String = "") : void
      {
         var _loc4_:TPacket = null;
         var _loc5_:ByteArray = null;
         _loc4_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TopTeam_Join_Room_Req);
         _loc5_ = _loc4_.Data;
         _loc5_.writeUnsignedInt(param2);
         TUtilityString.FlushUTF(_loc5_,param3);
         if(param1 != null)
         {
            _loc5_.writeUnsignedInt(0);
         }
         else if(SLogicsCore.PostIdentifier == 81024001)
         {
            _loc5_.writeUnsignedInt(1);
         }
         else if(SLogicsCore.PostIdentifier == 81024002)
         {
            _loc5_.writeUnsignedInt(3);
         }
         SNetworkCore.Transceiver.PacketTransmit(_loc4_);
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
      
      protected function UIHintOnOver(param1:Object, param2:THint) : void
      {
         FOverlayerHint.Context = param2;
         FOverlayerHint.Render(FUICore.MouseCoordinate);
         FOverlayerHint.Show();
      }
      
      protected function UIHintOnOut(param1:Object) : void
      {
         FOverlayerHint.Hide();
      }
      
      public function set UpdateActivityStatus(param1:Function) : void
      {
         this.FUpdateActivityStatus = param1;
      }
      
      public function set OnEnterPlayerRoom(param1:Function) : void
      {
         this.FOnEnterPlayerRoom = param1;
      }
      
      public function set OnInitBattle(param1:Function) : void
      {
         this.FOnInitBattle = param1;
      }
      
      public function set OnSetTopTeamBattleType(param1:Function) : void
      {
         this.FOnSetTopTeamBattleType = param1;
      }
      
      public function set OnSetTopTeamBattleInfor(param1:Function) : void
      {
         this.FOnSetTopTeamBattleInfor = param1;
      }
      
      public function set OnSetTopTeamBattleReward(param1:Function) : void
      {
         this.FOnSetTopTeamBattleReward = param1;
      }
      
      public function set OnUpdateRoomData(param1:Function) : void
      {
         this.FOnUpdateRoomData = param1;
      }
      
      public function set OnMatchSuccess(param1:Function) : void
      {
         this.FOnMatchSuccess = param1;
      }
      
      public function set OnUpdateInviteList(param1:Function) : void
      {
         this.FOnUpdateInviteList = param1;
      }
      
      public function set OnApplyCaptain(param1:Function) : void
      {
         this.FOnApplyCaptain = param1;
      }
      
      public function set OnExitRoom(param1:Function) : void
      {
         this.FOnExitRoom = param1;
      }
      
      public function set OnOpenTopTeamWindow(param1:Function) : void
      {
         this.FOnOpenTopTeamWindow = param1;
      }
      
      public function set OnCloseBattleRoomUI(param1:Function) : void
      {
         this.FOnCloseBattleRoomUI = param1;
      }
      
      public function set OnEffectSign(param1:Function) : void
      {
         this.FOnEffectSign = param1;
      }
      
      public function set OnUpdateTop(param1:Function) : void
      {
         this.FOnUpdateTop = param1;
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount(param1);
         if(!FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowNinjaRank.Load();
            this.FProcessorWindowTopTeam.Load();
            this.FProcessorWindowNinjaPointMall.Load();
            this.FProcessorWindowTopTeamRoonList.Load();
            return;
         }
         this.PerformPacket_CS_Left_Btl_Cnt_Req();
      }
      
      override public function Unmount() : void
      {
         super.Unmount();
         this.FTopTeamData.IsStayHall = 0;
         this.PerformPacket_CS_In_Hall_Req(0);
      }
      
      public function ShowNinjaPointMall() : void
      {
         this.FProcessorWindowTopTeamRoonList.Visible = false;
         this.ProcessorNinjaPointMallOnClick(null);
      }
      
      public function InitPvpMallInfo() : void
      {
         this.FUnstreamizerTopTeam.UnstreamizeInventorySamplesByDatabase(null,SLogicsCore.TopTeamData.InventorySamples,null);
      }
      
      public function EnterBattleRoomUIReq(param1:ByteArray) : void
      {
         this.FRoomID = param1.readUnsignedInt();
         if(SLogicsCore.Character.RoleSencePosition == CONST_COMMON.SCENEPOSITION_TopTeam)
         {
            EffectGenerateText(STRING_TOPTEAM.STRING_HasInRoom);
         }
         else if(this.FRoomID == 0)
         {
            this.PacketPerform_CS_IsOpenTopTeamIcon();
         }
         else
         {
            this.ProcessorEnterRoomOnClick(null,this.FRoomID);
         }
      }
      
      public function RequestRoomData(param1:uint) : void
      {
         if(SLogicsCore.TopTeamData.FunctionIsOpen == 3 || SLogicsCore.TopTeamData.FunctionIsOpen == 4)
         {
            ProcessorClose();
            this.FProcessorWindowTopTeamRoonList.Visible = false;
            this.FProcessorWindowNinjaRank.Visible = false;
            this.FProcessorWindowTopTeam.Visible = false;
            if(SLogicsCore.Character.RoleSencePosition != CONST_COMMON.SCENEPOSITION_TopTeam)
            {
               return;
            }
            if(this.FOnCloseBattleRoomUI != null)
            {
               this.FOnCloseBattleRoomUI(this);
            }
            return;
         }
         this.PerformPacket_CS_Top_Req();
         this.PerformPacket_CS_Room_Data_Req(param1);
      }
      
      public function LevelUpOpenIconRequest() : void
      {
         if(SLogicsCore.Character.GetMainLevel() == 40)
         {
            this.FOpenSign = true;
            this.PacketPerform_CS_IsOpenTopTeamIcon();
         }
      }
   }
}

