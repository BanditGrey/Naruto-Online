package Processors.Game.Lobby.GroupBattle
{
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Registries.TRegistryRoutine;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.DatebaseVO.VO.TLeagueMapPve;
   import Logics.GroupBattle.TGroupBattleData;
   import Logics.GroupBattle.TGroupBattleRoom;
   import Logics.GroupBattle.TInviteShadow;
   import Logics.GroupBattle.TRoomPlayer;
   import Logics.GroupBattle.TShadowPlayer;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.GroupBattle.TUnstreamizerGroupBattle;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import Processors.Game.Lobby.GroupBattle.Window.TProcessorWindowNijiaBattle;
   import Rendering.Overlayers.HelpTips.TOverlayerHelpTips;
   import Rendering.Overlayers.Hints.TOverlayerHint;
   import Rendering.Overlayers.Inventories.TOverlayerAccessory;
   import Rendering.Overlayers.Inventories.TOverlayerAppliance;
   import Rendering.Overlayers.Inventories.TOverlayerEquipment;
   import Rendering.Overlayers.Inventories.TOverlayerTreasure;
   import Rendering.Overlayers.TOverlayer;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_CONFIGVALUE;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_GROUPBATTLE;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_SHORTCUTS;
   import Resources.Strings.STRING_GROUPBATTLE;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.utils.ByteArray;
   
   public class TProcessorGroupBattle extends TProcessorLobbyWindows
   {
      
      protected var FProcessorWindowNijiaBattle:TProcessorWindowNijiaBattle;
      
      protected var FUnstreamizerGroupBattle:TUnstreamizerGroupBattle;
      
      protected var FGroupBattleData:TGroupBattleData;
      
      protected var FRegistryRoutine:TRegistryRoutine;
      
      protected var FIsInit:Boolean;
      
      protected var FRoomID:uint;
      
      protected var FOnEffectSign:Function;
      
      protected var FOnReturnHall:Function;
      
      protected var FOnEnterPlayerRoom:Function;
      
      protected var FOnUpdataRoom:Function;
      
      protected var FOnResetRoomAutoOnMatching:Function;
      
      protected var FOnInitBattle:Function;
      
      protected var FOnSetGroupBattleType:Function;
      
      protected var FOnSetGroupBattleInfor:Function;
      
      protected var FOnSetGroupBattleReward:Function;
      
      protected var FOnEnterReady:Function;
      
      protected var FOnUpdataWindowReady:Function;
      
      protected var FOnChangePosition:Function;
      
      protected var FOnUpdateInviteShadows:Function;
      
      protected var FOnSetGroupBattleChannel:Function;
      
      protected var FOnCloseBattleSelect:Function;
      
      protected var FOnOpenNijiaBattleWindow:Function;
      
      protected var FOnEffectNewPveTimes:Function;
      
      protected var FGoAccessory:Function;
      
      public function TProcessorGroupBattle(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FIsInit = false;
         this.InitWindow();
         this.InitParameter();
         SetUIModuleID(CONST_MODULES.MODULE_GroupBattle);
      }
      
      protected function InitWindow() : void
      {
         this.FProcessorWindowNijiaBattle = new TProcessorWindowNijiaBattle(this);
         this.FProcessorWindowNijiaBattle.OnClose = this.ProcessorOnClose;
         this.FProcessorWindowNijiaBattle.SlotOnOut = this.UISlotHintOnOut;
         this.FProcessorWindowNijiaBattle.SlotOnOver = this.UISlotHintOnOver;
         this.FProcessorWindowNijiaBattle.OnEffectText = this.ProcessorOnEffectText;
         this.FProcessorWindowNijiaBattle.CreateRoomOnClick = this.ProcessorCreateRoomOnClick;
         this.FProcessorWindowNijiaBattle.EnterRoomOnClick = this.ProcessorEnterRoomOnClick;
         this.FProcessorWindowNijiaBattle.OnHelpTipsOut = UIHelpTipsHintOnOut;
         this.FProcessorWindowNijiaBattle.OnHelpTipsOver = UIHelpTipsHintOnOver;
         this.FProcessorWindowNijiaBattle.UIHintOnOver = ProcessorTipOnOver;
         this.FProcessorWindowNijiaBattle.UIHintOnOut = ProcessorTipOnOut;
         this.FProcessorWindowNijiaBattle.UIHintOnMove = this.UIComponentsHintOnMove;
         this.FProcessorWindowNijiaBattle.GoAccessory = this.GoAccessoryPanel;
      }
      
      protected function GoAccessoryPanel() : void
      {
         if(this.FGoAccessory != null)
         {
            this.FGoAccessory();
         }
      }
      
      protected function InitParameter() : void
      {
         this.FUnstreamizerGroupBattle = new TUnstreamizerGroupBattle();
         this.FGroupBattleData = SLogicsCore.GroupBattleData;
         this.FRegistryRoutine = new TRegistryRoutine();
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_GROUPBATTLE.RESOURCESID_Swf_GroupBattle);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         FOverlayerEquipment = new TOverlayerEquipment(this,CONST_MODULES.MODULE_GroupBattle);
         FOverlayerEquipment.Visible = false;
         FOverlayerTreasure = new TOverlayerTreasure(this,CONST_MODULES.MODULE_GroupBattle);
         FOverlayerTreasure.Visible = false;
         FOverlayerAppliance = new TOverlayerAppliance(this,CONST_MODULES.MODULE_GroupBattle);
         FOverlayerAppliance.Visible = false;
         FOverlayerHelpTips = new TOverlayerHelpTips(this);
         FOverlayerHelpTips.Visible = false;
         FOverlayerHint = new TOverlayerHint(this);
         FOverlayerHint.Visible = false;
         FOverlayerAccessory = new TOverlayerAccessory(this,CONST_MODULES.MODULE_GroupBattle);
         FOverlayerAccessory.Visible = false;
         FOverlayerAccessory.IsMeOrOthers = 0;
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerEquipment);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerTreasure);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerAppliance);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerHelpTips);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerHint);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerAccessory);
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_GroupBattlt_EnterLeagueBattle_Ret,this.PerformPacket_SC_EnterLeagueBattle_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_GroupBattlt_EnterLeagueBattle_PVE_Ret,this.PerformPacket_SC_EnterLeagueBattle_PVE_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_GroupBattlt_LeaveLeagueBattle_Ret,this.PerformPacket_SC_LeaveLeagueBattle_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_GroupBattlt_RoomListNtf_Ret,this.PerformPacket_SC_RoomListNtf_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_GroupBattlt_UpdateRoom_Ret,this.PerformPacket_SC_UpdateRoom_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_GroupBattlt_FriendListNtf_Ret,this.PerformPacket_SC_FriendListNtf_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_GroupBattlt_CreatePlayerRoom_PVE_Ret,this.PerformPacket_SC_CreatePlayerRoom_PVE_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_GroupBattlt_JoinPlayerRoom_Ret,this.PerformPacket_SC_JoinPlayerRoom_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_GroupBattlt_EnterPlayerRoom_Ret,this.PerformPacket_SC_EnterPlayerRoom_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_GroupBattlt_PlayerComeInNtf_Ret,this.PerformPacket_SC_PlayerComeInNtf_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_GroupBattlt_RoomInOperating_Ret,this.PerformPacket_SC_RoomInOperating_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_GroupBattlt_PveChangeMission_Ret,this.PerformPacket_SC_PveChangeMission_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_GroupBattlt_PveChangeMissionConfirm_Ret,this.PerformPacket_SC_PveChangeMissionConfirm_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_GroupBattlt_ChangePassword_Ret,this.PerformPacket_SC_ChangePassword_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_GroupBattlt_StartGame_Ret,this.PerformPacket_SC_StartGame_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_GroupBattlt_BattleUsers_Ret,this.PerformPacket_SC_BattleUsers_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_GroupBattlt_BattleProcess_Ret,this.PerformPacket_SC_BattleProcess_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_GroupBattlt_BatttleResult_Ret,this.PerformPacket_SC_BatttleResult_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_GroupBattlt_CharInfoChangeNtf_Ret,this.PerformPacket_SC_CharInfoChangeNtf_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_GroupBattlt_EnterLeagueBattle_PVP_Ret,this.PerformPacket_SC_EnterLeagueBattle_PVP_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_GroupBattlt_PvpMatch_Ret,this.PerformPacket_SC_GroupBattlt_PvpMatch_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_GroupBattlt_PveStartChangePos_Ret,this.PerformPacket_SC_PveStartChangePos_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_GroupBattlt_StartFightPVE_Ret,this.PerformPacket_SC_StartFightPVE_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_GroupBattlt_BattlePveReturnRoom_Ret,this.PerformPacket_SC_BattlePveReturnRoom_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_GroupBattlt_LeagueInfoNtf_Ret,this.PerformPacket_SC_LeagueInfoNtf_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_GroupBattlt_PvpMatchTimeSync_Ret,this.PerformPacket_SC_PvpMatchTimeSync_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_GroupBattlt_StartPvpFight_Ret,this.PerformPacket_SC_StartPvpFight_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_GroupBattlt_OpenPvpNtf_Ret,this.PerformPacket_SC_OpenPvpNtf_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_GroupBattlt_FriendList_Ret,this.PerformPacket_SC_FriendList_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_GroupBattlt_ShadowList_Ret,this.PerformPacket_SC_ShadowList_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_GroupBattlt_AuthorizeUserInvited_Ret,this.PerformPacket_SC_AuthorizeUserInvited__Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_GroupBattlt_AuthorizeGuildInvited_Ret,this.PerformPacket_SC_AuthorizeGuildInvited_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_GroupBattlt_InvitePlayerShadow_Ret,this.PerformPacket_SC_InvitePlayerShadow_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_GroupBattlt_ReadyTimeStatus_Ret,this.PerformPacket_SC_ReadyTimeStatus_Ret);
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
         FResourcesRoutines.Register(CONST_GROUPBATTLE.RoomOperateReq_Ready,this.ProcessorOnReady);
         FResourcesRoutines.Register(CONST_GROUPBATTLE.RoomOperateReq_CancelReady,this.ProcessorOnCancelReady);
         FResourcesRoutines.Register(CONST_GROUPBATTLE.RoomOperateReq_ApplyCaptain,this.ProcessorOnApplyCaptain);
         FResourcesRoutines.Register(CONST_GROUPBATTLE.RoomOperateReq_Kick,this.ProcessorOnKick);
         FResourcesRoutines.Register(CONST_GROUPBATTLE.RoomOperateReq_Transfer,this.ProcessorOnTransfer);
         FResourcesRoutines.Register(CONST_GROUPBATTLE.RoomOperateReq_Leave,this.ProcessorOnLeave);
         FResourcesRoutines.Register(CONST_GROUPBATTLE.RoomOperateReq_Refuse,this.ProcessorOnRefuse);
         FResourcesRoutines.Register(CONST_GROUPBATTLE.RoomOperateReq_ChangePosition,this.ProcessorOnChangePosition);
         var _loc1_:TConfigValue = null;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.OhtsutsukiKaguya_NiJiBuyCounGold) as TConfigValue;
         SLogicsCore.KaguyaData.NiJiBuyCounGold = _loc1_.Value as Vector.<uint>;
      }
      
      protected function PerformPacket_CS_FriendList_Req() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_GroupBattlt_FriendList_Req);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PerformPacket_CS_ShadowList_Req() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_GroupBattlt_ShadowList_Req);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PerformPacket_CS_EnterLeagueBattle_PVE_Req() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_GroupBattlt_EnterLeagueBattle_Req);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_GroupBattlt_EnterLeagueBattle_PVE_Req);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function ProcessorOnReady(param1:uint, param2:uint) : void
      {
      }
      
      protected function ProcessorOnCancelReady(param1:uint, param2:uint) : void
      {
      }
      
      protected function ProcessorOnApplyCaptain(param1:uint, param2:uint) : void
      {
      }
      
      protected function ProcessorOnKick(param1:uint, param2:uint) : void
      {
      }
      
      protected function ProcessorOnTransfer(param1:uint, param2:uint) : void
      {
      }
      
      protected function ProcessorOnLeave(param1:uint, param2:uint) : void
      {
      }
      
      protected function ProcessorOnRefuse(param1:uint, param2:uint) : void
      {
      }
      
      protected function ProcessorOnChangePosition(param1:uint, param2:uint) : void
      {
         this.FGroupBattleData.RoomDetailInfo.RoomPlayers.ExchangeSequence(param1,param2);
         if(this.FOnChangePosition != null)
         {
            this.FOnChangePosition(this);
         }
      }
      
      protected function PerformPacket_SC_EnterLeagueBattle_Ret(param1:TPacket) : void
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
      
      protected function PerformPacket_SC_EnterLeagueBattle_PVE_Ret(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:TGroupBattleRoom = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc4_ = this.FGroupBattleData.GroupBattleRooms.GetGroupBattleRoomByRoomID(this.FRoomID);
         if(_loc4_ != null && _loc4_.HasPassword)
         {
            EffectGenerateText(STRING_GROUPBATTLE.String_HasPassword);
            return;
         }
         if(this.FRoomID != 0)
         {
            this.ProcessorEnterRoomOnClick(null,1,this.FRoomID,0);
         }
         else if(FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowNijiaBattle.Update();
            this.FProcessorWindowNijiaBattle.Visible = true;
         }
         this.FRoomID = 0;
      }
      
      protected function PerformPacket_SC_LeaveLeagueBattle_Ret(param1:TPacket) : void
      {
      }
      
      protected function PerformPacket_SC_RoomListNtf_Ret(param1:TPacket) : void
      {
      }
      
      protected function PerformPacket_SC_UpdateRoom_Ret(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         _loc2_ = param1.Data;
         this.FUnstreamizerGroupBattle.UnstreamizeUpdateRoomInfo(_loc2_,this.FGroupBattleData.GroupBattleRooms,null);
         if(FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowNijiaBattle.UpdateRoomsInfo();
         }
      }
      
      protected function PerformPacket_SC_FriendListNtf_Ret(param1:TPacket) : void
      {
      }
      
      protected function PerformPacket_SC_CreatePlayerRoom_PVE_Ret(param1:TPacket) : void
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
         if(this.FOnEnterPlayerRoom != null)
         {
            this.FOnEnterPlayerRoom(this);
         }
      }
      
      protected function PerformPacket_SC_JoinPlayerRoom_Ret(param1:TPacket) : void
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
         if(this.FOnEnterPlayerRoom != null)
         {
            this.FOnEnterPlayerRoom(this);
         }
      }
      
      protected function PerformPacket_SC_EnterPlayerRoom_Ret(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = param1.Data;
         this.FGroupBattleData.RoomDetailInfo.RoomPlayers.Clear();
         this.FUnstreamizerGroupBattle.UnstreamizeRoomDetailInfo(_loc2_,this.FGroupBattleData.RoomDetailInfo,null);
         if(this.FOnUpdataRoom != null)
         {
            this.FOnUpdataRoom(this);
         }
         if(this.FOnEnterPlayerRoom != null)
         {
            this.FOnEnterPlayerRoom(this);
         }
      }
      
      protected function PerformPacket_SC_PlayerComeInNtf_Ret(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = param1.Data;
         this.FUnstreamizerGroupBattle.UnstreamizeUpdateRoomPayerInfo(_loc2_,this.FGroupBattleData.RoomDetailInfo.RoomPlayers,null);
         if(this.FOnUpdataRoom != null)
         {
            this.FOnUpdataRoom(this);
         }
      }
      
      protected function PerformPacket_SC_RoomInOperating_Ret(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:TRoomPlayer = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc4_ = uint(_loc2_.readByte());
         _loc5_ = uint(_loc2_.readByte());
         _loc6_ = uint(_loc2_.readByte());
         switch(_loc4_)
         {
            case CONST_GROUPBATTLE.RoomOperateReq_Ready:
               _loc7_ = this.FGroupBattleData.RoomDetailInfo.RoomPlayers.GetRoomPlayerByIndex(_loc5_);
               _loc7_.IsReady = 1;
               break;
            case CONST_GROUPBATTLE.RoomOperateReq_CancelReady:
               _loc7_ = this.FGroupBattleData.RoomDetailInfo.RoomPlayers.GetRoomPlayerByIndex(_loc5_);
               _loc7_.IsReady = 0;
               this.FGroupBattleData.ReadyTimeStatus = 0;
               this.FGroupBattleData.ReadyTimeTick = 0;
               if(this.FOnResetRoomAutoOnMatching != null)
               {
                  this.FOnResetRoomAutoOnMatching(this);
               }
               break;
            case CONST_GROUPBATTLE.RoomOperateReq_ApplyCaptain:
               break;
            case CONST_GROUPBATTLE.RoomOperateReq_Kick:
               if(_loc6_ == this.FGroupBattleData.RoomDetailInfo.SelfIndex)
               {
                  if(this.FOnReturnHall != null)
                  {
                     this.FOnReturnHall(this);
                  }
                  this.FGroupBattleData.RoomDetailInfo.Reset();
               }
               else
               {
                  this.FGroupBattleData.RoomDetailInfo.RoomPlayers.Delete(_loc6_);
               }
               this.FGroupBattleData.ReadyTimeStatus = 0;
               this.FGroupBattleData.ReadyTimeTick = 0;
               break;
            case CONST_GROUPBATTLE.RoomOperateReq_Transfer:
               this.FGroupBattleData.RoomDetailInfo.HostIndex = _loc6_;
               this.FGroupBattleData.ReadyTimeStatus = 0;
               this.FGroupBattleData.ReadyTimeTick = 0;
               break;
            case CONST_GROUPBATTLE.RoomOperateReq_Leave:
               this.FGroupBattleData.RoomDetailInfo.RoomPlayers.Delete(_loc5_);
               this.FGroupBattleData.ReadyTimeStatus = 0;
               this.FGroupBattleData.ReadyTimeTick = 0;
               if(this.FOnResetRoomAutoOnMatching != null)
               {
                  this.FOnResetRoomAutoOnMatching(this);
               }
               break;
            case CONST_GROUPBATTLE.RoomOperateReq_Refuse:
               break;
            case CONST_GROUPBATTLE.RoomOperateReq_ChangePosition:
               if(this.FGroupBattleData.RoomDetailInfo.HostIndex == _loc5_)
               {
                  this.FGroupBattleData.RoomDetailInfo.HostIndex = _loc6_;
               }
               else if(this.FGroupBattleData.RoomDetailInfo.HostIndex == _loc6_)
               {
                  this.FGroupBattleData.RoomDetailInfo.HostIndex = _loc5_;
               }
               if(this.FGroupBattleData.RoomDetailInfo.SelfIndex == _loc6_)
               {
                  this.FGroupBattleData.RoomDetailInfo.SelfIndex = _loc5_;
               }
               else if(this.FGroupBattleData.RoomDetailInfo.SelfIndex == _loc5_)
               {
                  this.FGroupBattleData.RoomDetailInfo.SelfIndex = _loc6_;
               }
               this.FGroupBattleData.RoomDetailInfo.RoomPlayers.ExchangeSequence(_loc5_,_loc6_);
         }
         if(this.FOnUpdataRoom != null)
         {
            this.FOnUpdataRoom(this);
         }
      }
      
      protected function PerformPacket_SC_PveChangeMission_Ret(param1:TPacket) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:ByteArray = null;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:String = null;
         var _loc9_:TLeagueMapPve = null;
         var _loc10_:TRoomPlayer = null;
         _loc4_ = param1.Data;
         _loc5_ = _loc4_.readUnsignedInt();
         _loc3_ = uint(_loc4_.readShort());
         if(_loc5_ != 0)
         {
            if(_loc3_ <= 0)
            {
               EffectGenerateTextByErrorCode(_loc5_);
               return;
            }
            _loc8_ = "";
            _loc2_ = 0;
            while(_loc2_ < _loc3_)
            {
               _loc7_ = uint(_loc4_.readByte());
               _loc10_ = this.FGroupBattleData.RoomDetailInfo.RoomPlayers.GetRoomPlayerByIndex(_loc7_);
               if(_loc10_ != null)
               {
                  _loc8_ += _loc10_.PlayerName;
               }
               if(_loc2_ + 1 < _loc3_)
               {
                  _loc8_ += ",";
               }
               _loc2_++;
            }
            _loc6_ = _loc4_.readUnsignedInt();
            _loc9_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_LeagueMapPve,_loc6_) as TLeagueMapPve;
            EffectGenerateText(TUtilityString.Format(STRING_GROUPBATTLE.STRING_CantChangeMap,_loc8_,_loc9_.Name,STRING_GROUPBATTLE.STRING_Difficulty[_loc9_.Prev == 0 ? 0 : 1]));
            return;
         }
         _loc6_ = _loc4_.readUnsignedInt();
         this.FUnstreamizerGroupBattle.UnstreamizerChangeMissionId(_loc6_,this.FGroupBattleData.RoomDetailInfo,null);
         _loc3_ = this.FGroupBattleData.RoomDetailInfo.RoomPlayers.Count;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc10_ = this.FGroupBattleData.RoomDetailInfo.RoomPlayers.GetRoomPlayerByIndex(_loc2_);
            if(_loc10_ != null)
            {
               if(this.FGroupBattleData.RoomDetailInfo.HostIndex != _loc2_ && !Boolean(_loc10_.IsShadow))
               {
                  _loc10_.IsReady = 0;
               }
            }
            _loc2_++;
         }
         if(this.FOnResetRoomAutoOnMatching != null)
         {
            this.FOnResetRoomAutoOnMatching(this,true);
         }
         if(this.FOnUpdataRoom != null)
         {
            this.FOnUpdataRoom(this);
         }
         if(this.FOnCloseBattleSelect != null)
         {
            this.FOnCloseBattleSelect(this);
         }
      }
      
      protected function PerformPacket_SC_PveChangeMissionConfirm_Ret(param1:TPacket) : void
      {
      }
      
      protected function PerformPacket_SC_ChangePassword_Ret(param1:TPacket) : void
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
         this.FGroupBattleData.RoomDetailInfo.Password = TUtilityString.FetchUTF(_loc2_);
         if(this.FOnUpdataRoom != null)
         {
            this.FOnUpdataRoom(this);
         }
      }
      
      protected function PerformPacket_SC_StartGame_Ret(param1:TPacket) : void
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
         this.FUnstreamizerGroupBattle.UnstreamizeMonsterByDatabase(null,this.FGroupBattleData,null);
         if(this.FOnEnterReady != null)
         {
            this.FOnEnterReady(this);
         }
      }
      
      protected function PerformPacket_SC_BattleUsers_Ret(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = param1.Data;
         if(this.FOnInitBattle != null)
         {
            this.FOnInitBattle(this,true);
         }
         if(this.FOnSetGroupBattleType != null)
         {
            this.FOnSetGroupBattleType(this,_loc2_);
         }
         this.FGroupBattleData.IsInBattle = true;
      }
      
      protected function PerformPacket_SC_BattleProcess_Ret(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = param1.Data;
         if(this.FOnSetGroupBattleInfor != null)
         {
            this.FOnSetGroupBattleInfor(this,_loc2_);
         }
      }
      
      protected function PerformPacket_SC_BatttleResult_Ret(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = param1.Data;
         if(this.FOnSetGroupBattleReward != null)
         {
            this.FOnSetGroupBattleReward(this,_loc2_);
         }
      }
      
      protected function PerformPacket_SC_CharInfoChangeNtf_Ret(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = param1.Data;
         this.FUnstreamizerGroupBattle.UnstreamizeUpdateRoomPayerInfo(_loc2_,this.FGroupBattleData.RoomDetailInfo.RoomPlayers,null);
         if(this.FOnUpdataRoom != null)
         {
            this.FOnUpdataRoom(this);
         }
      }
      
      protected function PerformPacket_SC_EnterLeagueBattle_PVP_Ret(param1:TPacket) : void
      {
      }
      
      protected function PerformPacket_SC_GroupBattlt_PvpMatch_Ret(param1:TPacket) : void
      {
      }
      
      protected function PerformPacket_SC_PveStartChangePos_Ret(param1:TPacket) : void
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
         this.FGroupBattleData.BattleStartCountDownTime = _loc2_.readUnsignedInt();
      }
      
      protected function PerformPacket_SC_StartFightPVE_Ret(param1:TPacket) : void
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
      
      protected function PerformPacket_SC_BattlePveReturnRoom_Ret(param1:TPacket) : void
      {
      }
      
      protected function PerformPacket_SC_LeagueInfoNtf_Ret(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = param1.Data;
         this.FGroupBattleData.PVPTimes = _loc2_.readShort();
         this.FGroupBattleData.PVETimes = _loc2_.readShort();
         this.FGroupBattleData.HonorPoint = _loc2_.readUnsignedInt();
         this.FUnstreamizerGroupBattle.UnstreamizeBattleLevelInfo(_loc2_,this.FGroupBattleData.GroupBattleLevels,null);
         if(this.FOnEffectNewPveTimes != null)
         {
            this.FOnEffectNewPveTimes(CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_GroupBattle,this.FGroupBattleData.PVETimes > 0);
         }
         if(FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowNijiaBattle.Update();
         }
      }
      
      protected function PerformPacket_SC_PvpMatchTimeSync_Ret(param1:TPacket) : void
      {
      }
      
      protected function PerformPacket_SC_StartPvpFight_Ret(param1:TPacket) : void
      {
      }
      
      protected function PerformPacket_SC_OpenPvpNtf_Ret(param1:TPacket) : void
      {
      }
      
      protected function PerformPacket_SC_FriendList_Ret(param1:TPacket) : void
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
         this.FUnstreamizerGroupBattle.UnstreamizerFriendList(_loc2_,this.FGroupBattleData.FriendList,null);
         this.FGroupBattleData.RestShadowCount = _loc2_.readUnsignedInt();
         this.FGroupBattleData.OrgAuthorizeStatus = _loc2_.readUnsignedInt();
         if(Visible)
         {
            this.FProcessorWindowNijiaBattle.UpdateFriendList();
         }
      }
      
      protected function PerformPacket_SC_ShadowList_Ret(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = param1.Data;
         this.FUnstreamizerGroupBattle.UnstreamizerShadowList(_loc2_,this.FGroupBattleData.InviteShadows,null);
         if(this.FOnUpdateInviteShadows != null)
         {
            this.FOnUpdateInviteShadows(this);
         }
      }
      
      protected function PerformPacket_SC_AuthorizeUserInvited__Ret(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:TShadowPlayer = null;
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
         _loc6_ = _loc2_.readUnsignedInt();
         _loc4_ = this.FGroupBattleData.FriendList.GetShadowPlayerByIdentifier(_loc5_,_loc6_);
         _loc7_ = _loc2_.readUnsignedByte();
         if(_loc4_ != null)
         {
            _loc4_.AuthorizeStatus = _loc7_;
         }
         if(Visible)
         {
            this.FProcessorWindowNijiaBattle.UpdateFriendList();
         }
      }
      
      protected function PerformPacket_SC_AuthorizeGuildInvited_Ret(param1:TPacket) : void
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
         this.FGroupBattleData.OrgAuthorizeStatus = _loc2_.readUnsignedByte();
         if(FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowNijiaBattle.UpdateOrgAuthorizeStatus();
         }
      }
      
      protected function PerformPacket_SC_InvitePlayerShadow_Ret(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:TInviteShadow = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc4_ = _loc2_.readUnsignedInt();
         _loc5_ = _loc2_.readUnsignedInt();
         _loc6_ = this.FGroupBattleData.InviteShadows.GetInviteShadowByIdentifier(_loc4_,_loc5_);
         if(_loc6_ != null)
         {
            _loc6_.CDTime = _loc2_.readUnsignedInt();
         }
         if(this.FOnUpdateInviteShadows != null)
         {
            this.FOnUpdateInviteShadows(this);
         }
      }
      
      protected function PerformPacket_SC_ReadyTimeStatus_Ret(param1:TPacket) : void
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
         this.FGroupBattleData.ReadyTimeStatus = _loc2_.readUnsignedInt();
         this.FGroupBattleData.ReadyTimeTick = this.FGroupBattleData.ReadyTimeStatus != 0 ? uint(STimingCore.GetServerTick()) : 0;
         this.FGroupBattleData.SendReadyTimeStatusReq = false;
         if(this.FOnUpdataRoom != null)
         {
            this.FOnUpdataRoom(this);
         }
      }
      
      protected function ProcessorOnEffectText(param1:String) : void
      {
         EffectGenerateText(param1);
      }
      
      protected function ProcessorCreateRoomOnClick(param1:Object, param2:uint, param3:uint) : void
      {
         var _loc4_:TPacket = null;
         var _loc5_:ByteArray = null;
         _loc4_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_GroupBattlt_CreatePlayerRoom_Req);
         _loc5_ = _loc4_.Data;
         _loc5_.writeByte(param2);
         _loc5_.writeUnsignedInt(param3);
         _loc5_.writeByte(0);
         SNetworkCore.Transceiver.PacketTransmit(_loc4_);
      }
      
      protected function ProcessorEnterRoomOnClick(param1:Object, param2:uint, param3:uint, param4:uint, param5:String = "") : void
      {
         var _loc6_:TPacket = null;
         var _loc7_:ByteArray = null;
         _loc6_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_GroupBattlt_JoinPlayerRoom_Req);
         _loc7_ = _loc6_.Data;
         _loc7_.writeByte(param2);
         _loc7_.writeByte(param4);
         _loc7_.writeUnsignedInt(param3);
         TUtilityString.FlushUTF(_loc7_,param5);
         SNetworkCore.Transceiver.PacketTransmit(_loc6_);
      }
      
      protected function ProcessorOnClose(param1:Object) : void
      {
         var _loc2_:TPacket = null;
         this.FProcessorWindowNijiaBattle.Reset();
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_GroupBattlt_LeaveLeagueBattle_Req);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
         ProcessorClose();
      }
      
      protected function UISlotHintOnOver(param1:Object) : void
      {
         var _loc2_:TInventory = null;
         var _loc3_:TOverlayer = null;
         _loc2_ = param1 as TInventory;
         switch(_loc2_.Category)
         {
            case CATEGORY_Equipment:
               _loc3_ = FOverlayerEquipment;
               break;
            case CATEGORY_Treasure:
               _loc3_ = FOverlayerTreasure;
               break;
            case CATEGORY_Accessories:
               _loc3_ = FOverlayerAccessory;
               break;
            default:
               _loc3_ = FOverlayerAppliance;
         }
         if(_loc3_ != null)
         {
            _loc3_.Context = _loc2_;
            _loc3_.Render(FUICore.MouseCoordinate);
            _loc3_.Show();
         }
      }
      
      protected function UISlotHintOnOut(param1:Object) : void
      {
         var _loc2_:TInventory = null;
         var _loc3_:TOverlayer = null;
         _loc2_ = param1 as TInventory;
         switch(_loc2_.Category)
         {
            case CATEGORY_Equipment:
               _loc3_ = FOverlayerEquipment;
               break;
            case CATEGORY_Treasure:
               _loc3_ = FOverlayerTreasure;
               break;
            case CATEGORY_Accessories:
               _loc3_ = FOverlayerAccessory;
               break;
            default:
               _loc3_ = FOverlayerAppliance;
         }
         if(_loc3_ != null)
         {
            _loc3_.Hide();
         }
      }
      
      protected function UIComponentsHintOnMove(param1:Object) : void
      {
         FOverlayerHint.Render(FUICore.MouseCoordinate);
      }
      
      public function set OnEffectSign(param1:Function) : void
      {
         this.FOnEffectSign = param1;
      }
      
      public function set OnReturnHall(param1:Function) : void
      {
         this.FOnReturnHall = param1;
      }
      
      public function set OnEnterPlayerRoom(param1:Function) : void
      {
         this.FOnEnterPlayerRoom = param1;
      }
      
      public function set OnChangePosition(param1:Function) : void
      {
         this.FOnChangePosition = param1;
      }
      
      public function set OnUpdataRoom(param1:Function) : void
      {
         this.FOnUpdataRoom = param1;
      }
      
      public function set OnResetRoomAutoOnMatching(param1:Function) : void
      {
         this.FOnResetRoomAutoOnMatching = param1;
      }
      
      public function set OnInitBattle(param1:Function) : void
      {
         this.FOnInitBattle = param1;
      }
      
      public function set OnSetGroupBattleType(param1:Function) : void
      {
         this.FOnSetGroupBattleType = param1;
      }
      
      public function set OnSetGroupBattleInfor(param1:Function) : void
      {
         this.FOnSetGroupBattleInfor = param1;
      }
      
      public function set OnSetGroupBattleReward(param1:Function) : void
      {
         this.FOnSetGroupBattleReward = param1;
      }
      
      public function set OnEnterReady(param1:Function) : void
      {
         this.FOnEnterReady = param1;
      }
      
      public function set OnUpdataWindowReady(param1:Function) : void
      {
         this.FOnUpdataWindowReady = param1;
      }
      
      public function set OnUpdateInviteShadows(param1:Function) : void
      {
         this.FOnUpdateInviteShadows = param1;
      }
      
      public function set OnSetGroupBattleChannel(param1:Function) : void
      {
         this.FOnSetGroupBattleChannel = param1;
      }
      
      public function set OnCloseBattleSelect(param1:Function) : void
      {
         this.FOnCloseBattleSelect = param1;
      }
      
      public function set OnOpenNijiaBattleWindow(param1:Function) : void
      {
         this.FOnOpenNijiaBattleWindow = param1;
      }
      
      public function set OnEffectNewPveTimes(param1:Function) : void
      {
         this.FOnEffectNewPveTimes = param1;
      }
      
      public function set GoAccessory(param1:Function) : void
      {
         this.FGoAccessory = param1;
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount(param1);
         if(!FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowNijiaBattle.Load();
            return;
         }
         this.FGroupBattleData.GroupBattleRooms.Clear();
         this.PerformPacket_CS_EnterLeagueBattle_PVE_Req();
         SLogicsCore.KaguyaData.C_S_Privilege(4);
      }
      
      override public function Unmount() : void
      {
         super.Unmount();
         this.FProcessorWindowNijiaBattle.Visible = false;
      }
      
      public function EnterBattleRoomUIReq(param1:ByteArray = null) : void
      {
         this.FRoomID = param1.readUnsignedInt();
         if(SLogicsCore.Character.RoleSencePosition == CONST_COMMON.SCENEPOSITION_GroupBattle)
         {
            EffectGenerateText(STRING_GROUPBATTLE.STRING_HasInRoom);
         }
         else if(this.FRoomID == 0)
         {
            if(this.FOnOpenNijiaBattleWindow != null)
            {
               this.FOnOpenNijiaBattleWindow(this);
            }
         }
         else
         {
            this.PerformPacket_CS_EnterLeagueBattle_PVE_Req();
         }
      }
      
      public function UpdateFreeCount() : void
      {
         this.FProcessorWindowNijiaBattle.UpdateFreeCount();
      }
   }
}

