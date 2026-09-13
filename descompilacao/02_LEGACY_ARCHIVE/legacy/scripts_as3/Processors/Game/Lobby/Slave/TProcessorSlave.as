package Processors.Game.Lobby.Slave
{
   import Foundation.Common.TBounds;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TSlaveGainExp;
   import Logics.Mentorship.Elements.TSOSPlayer;
   import Logics.Mentorship.TArrest;
   import Logics.Mentorship.TInteractionLog;
   import Logics.Mentorship.TRescue;
   import Logics.Mentorship.TSOS;
   import Logics.Slave.TSlave;
   import Logics.Slave.TSlaveDisciple;
   import Logics.Slave.TSlaveRank;
   import Logics.Streamization.Mentorship.TUnstreamizerArrest;
   import Logics.Streamization.Mentorship.TUnstreamizerInteractionLog;
   import Logics.Streamization.Mentorship.TUnstreamizerRescue;
   import Logics.Streamization.Mentorship.TUnstreamizerSOS;
   import Logics.Streamization.Slave.TUnstreamizerSlave;
   import Logics.Streamization.Slave.TUnstreamizerSlaveDisciple;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import Rendering.Overlayers.HelpTips.TOverlayerHelpTips;
   import Resources.Constants.CONST_BATTLE;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_SLAVE;
   import Resources.Strings.STRING_BASEACTIVITY;
   import Resources.Strings.STRING_Mentorship;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.utils.ByteArray;
   
   public class TProcessorSlave extends TProcessorLobbyWindows
   {
      
      protected static const SIZE_WindowMentorship_Width:uint = 842;
      
      protected static const SIZE_WindowMentorship_Height:uint = 498;
      
      protected static const SIZE_WindowArrest_Width:uint = 618;
      
      protected static const SIZE_WindowArrest_Height:uint = 488;
      
      protected static const SIZE_WindowInteraction_Width:uint = 502;
      
      protected static const SIZE_WindowInteraction_Height:uint = 286;
      
      protected static const SIZE_WindowRescue_Width:uint = 618;
      
      protected static const SIZE_WindowRescue_Height:uint = 488;
      
      protected static const SIZE_WindowRank_Width:uint = 357;
      
      protected static const SIZE_WindowRank_Height:uint = 353;
      
      protected static const SIZE_WindowReward_Width:uint = 459;
      
      protected static const SIZE_WindowReward_Height:uint = 410;
      
      protected var FProcessorWindowSlave:TProcessorWindowSlave;
      
      protected var FProcessorWindowArrest:TProcessorWindowSlaveArrest;
      
      protected var FProcessorWindowInteraction:TProcessorWindowSlaveInteraction;
      
      protected var FProcessorWindowRescue:TProcessorWindowSlaveRescue;
      
      protected var FProcessorWindowSlaveRank:TProcessorWindowSlaveRank;
      
      protected var FProcessorWindowSlaveReward:TProcessorWindowSlaveReward;
      
      protected var FMentorshipBounds:TBounds;
      
      protected var FArrestBounds:TBounds;
      
      protected var FInteractionBounds:TBounds;
      
      protected var FRescueBounds:TBounds;
      
      protected var FRankBounds:TBounds;
      
      protected var FRewardBounds:TBounds;
      
      protected var FMentorship:TSlave;
      
      protected var FArrest:TArrest;
      
      protected var FRescue:TRescue;
      
      protected var FSOS:TSOS;
      
      protected var FInteractionLog:TInteractionLog;
      
      protected var FDisciple:TSlaveDisciple;
      
      protected var FUnstreamizerSlave:TUnstreamizerSlave;
      
      protected var FUnstreamizerArrest:TUnstreamizerArrest;
      
      protected var FUnstreamizerRescue:TUnstreamizerRescue;
      
      protected var FUnstreamizerSOS:TUnstreamizerSOS;
      
      protected var FUnstreamizerInteractionLog:TUnstreamizerInteractionLog;
      
      protected var FUnstreamizerDisciple:TUnstreamizerSlaveDisciple;
      
      protected var FOnShowOtherPlayerInfor:Function;
      
      protected var FSetStatusType:Function;
      
      protected var FOnInitBattle:Function;
      
      public function TProcessorSlave(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FProcessorWindowSlave = new TProcessorWindowSlave(this);
         this.FProcessorWindowSlave.OnClose = this.ProcessorWindowOnClose;
         this.FProcessorWindowSlave.OnArrest = this.ProcessorWindowOnArrest;
         this.FProcessorWindowSlave.OnRescueMembers = this.ProcessorWindowOnRescueMembers;
         this.FProcessorWindowSlave.OnInteraction = this.ProcessorWindowOnInteraction;
         this.FProcessorWindowSlave.OnWatchOhterPlayerInfo = this.ProcessorOnShowOtherPlayerInfor;
         this.FProcessorWindowSlave.OnDrawExp = this.ProcessorOnCMDReq;
         this.FProcessorWindowSlave.OnResist = this.ProcessorOnCMDReq;
         this.FProcessorWindowSlave.OnRedeem = this.ProcessorOnCMDReq;
         this.FProcessorWindowSlave.OnRank = this.ProcessorWindowOnRank;
         this.FProcessorWindowSlave.OnReward = this.ProcessorWindowOnReward;
         this.FProcessorWindowSlave.OnBuyCount = this.PacketPerform_CS_BuyReq;
         this.FProcessorWindowSlave.OnHelpTipsOver = UIHelpTipsHintOnOver;
         this.FProcessorWindowSlave.OnHelpTipsOut = UIHelpTipsHintOnOut;
         this.FProcessorWindowArrest = new TProcessorWindowSlaveArrest(this);
         this.FProcessorWindowArrest.OnClose = this.ProcessorWindowOnClose;
         this.FProcessorWindowArrest.OnArrestPlayer = this.ProcessorOnCMDReq;
         this.FProcessorWindowInteraction = new TProcessorWindowSlaveInteraction(this);
         this.FProcessorWindowInteraction.OnClose = this.ProcessorWindowOnClose;
         this.FProcessorWindowInteraction.OnInteraction = this.ProcessorOnCMDReq;
         this.FProcessorWindowRescue = new TProcessorWindowSlaveRescue(this);
         this.FProcessorWindowRescue.OnClose = this.ProcessorWindowOnClose;
         this.FProcessorWindowRescue.OnRescuePlayer = this.ProcessorOnCMDReq;
         this.FProcessorWindowSlaveRank = new TProcessorWindowSlaveRank(this);
         this.FProcessorWindowSlaveRank.OnRankListReq = this.PacketPerform_CS_RankReq;
         this.FProcessorWindowSlaveRank.OnClose = this.ProcessorWindowOnClose;
         this.FProcessorWindowSlaveReward = new TProcessorWindowSlaveReward(this);
         this.FProcessorWindowSlaveReward.OnClose = this.ProcessorWindowOnClose;
         this.FProcessorWindowSlaveReward.OnOverlay = UIComponentsHintOnOver;
         this.FProcessorWindowSlaveReward.OnOut = UIComponentsHintOnOut;
         this.FMentorshipBounds = new TBounds();
         this.FMentorshipBounds.X = this.FProcessorWindowSlave.x;
         this.FMentorshipBounds.Y = this.FProcessorWindowSlave.y;
         this.FMentorshipBounds.Width = SIZE_WindowMentorship_Width;
         this.FMentorshipBounds.Height = SIZE_WindowMentorship_Height;
         ComponentBoundsCenter(this.FProcessorWindowSlave,this.FMentorshipBounds);
         this.FArrestBounds = new TBounds();
         this.FArrestBounds.X = this.FProcessorWindowArrest.x;
         this.FArrestBounds.Y = this.FProcessorWindowArrest.y;
         this.FArrestBounds.Width = SIZE_WindowArrest_Width;
         this.FArrestBounds.Height = SIZE_WindowArrest_Height;
         ComponentBoundsCenter(this.FProcessorWindowArrest,this.FArrestBounds);
         this.FInteractionBounds = new TBounds();
         this.FInteractionBounds.X = this.FProcessorWindowInteraction.x;
         this.FInteractionBounds.Y = this.FProcessorWindowInteraction.y;
         this.FInteractionBounds.Width = SIZE_WindowInteraction_Width;
         this.FInteractionBounds.Height = SIZE_WindowInteraction_Height;
         ComponentBoundsCenter(this.FProcessorWindowInteraction,this.FInteractionBounds);
         this.FRescueBounds = new TBounds();
         this.FRescueBounds.X = this.FProcessorWindowRescue.x;
         this.FRescueBounds.Y = this.FProcessorWindowRescue.y;
         this.FRescueBounds.Width = SIZE_WindowRescue_Width;
         this.FRescueBounds.Height = SIZE_WindowRescue_Height;
         ComponentBoundsCenter(this.FProcessorWindowRescue,this.FRescueBounds);
         this.FRankBounds = new TBounds();
         this.FRankBounds.X = this.FProcessorWindowSlaveRank.x;
         this.FRankBounds.Y = this.FProcessorWindowSlaveRank.y;
         this.FRankBounds.Width = SIZE_WindowRank_Width;
         this.FRankBounds.Height = SIZE_WindowRank_Height;
         ComponentBoundsCenter(this.FProcessorWindowSlaveRank,this.FRankBounds);
         this.FRewardBounds = new TBounds();
         this.FRewardBounds.X = this.FProcessorWindowSlaveReward.x;
         this.FRewardBounds.Y = this.FProcessorWindowSlaveReward.y;
         this.FRewardBounds.Width = SIZE_WindowReward_Width;
         this.FRewardBounds.Height = SIZE_WindowReward_Height;
         ComponentBoundsCenter(this.FProcessorWindowSlaveReward,this.FRewardBounds);
         this.FUnstreamizerSlave = new TUnstreamizerSlave();
         this.FUnstreamizerArrest = new TUnstreamizerArrest();
         this.FUnstreamizerRescue = new TUnstreamizerRescue();
         this.FUnstreamizerSOS = new TUnstreamizerSOS();
         this.FUnstreamizerInteractionLog = new TUnstreamizerInteractionLog();
         this.FUnstreamizerDisciple = new TUnstreamizerSlaveDisciple();
         this.FMentorship = new TSlave();
         this.FArrest = new TArrest();
         this.FRescue = new TRescue();
         this.FSOS = new TSOS();
         this.FInteractionLog = new TInteractionLog();
         this.FDisciple = new TSlaveDisciple();
         FOverlayerHelpTips = new TOverlayerHelpTips(this);
         FOverlayerHelpTips.Visible = false;
         SetUIModuleID(CONST_MODULES.MODULE_Slave);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_SLAVE.RESOURCESID_Swf_Slave);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerHelpTips);
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Slave_LoadBaseDataRet,this.PacketPerform_SC_LoadBaseDataRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Slave_CatchListRet,this.PacketPerform_SC_CatchListRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Slave_RescueMembersListRet,this.PacketPerform_SC_RescueMembersListRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Slave_SOSListRet,this.PacketPerform_SC_SOSListRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Slave_InteractionLogRet,this.PacketPerform_SC_InteractionLogRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Slave_ArrestDiscipleRet,this.PacketPerform_SC_ArrestDiscipleRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Slave_IntercationRet,this.PacketPerform_SC_IntercationRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Slave_RescueRet,this.PacketPerform_SC_RescueRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Slave_GetExpRet,this.PacketPerform_SC_GetExpRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Slave_ReleaseRet,this.PacketPerform_SC_ReleaseRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Slave_RedeemRet,this.PacketPerform_SC_RedeemRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Slave_CommandRet,this.PacketPerform_SC_CommandRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Slave_ResistRet,this.PacketPerform_SC_ResistRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Slave_SOSRet,this.PacketPerform_SC_SOSRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Slave_RankRet,this.PacketPerform_SC_RankRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Slave_BuyRet,this.PacketPerform_SC_BuyRet);
      }
      
      protected function PacketPerform_SC_LoadBaseDataRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = param1.Data;
         this.FUnstreamizerSlave.Unstreamize(_loc2_,this.FMentorship,null);
         if(this.Visible)
         {
            this.FProcessorWindowSlave.UpdateUI(this.FMentorship);
         }
      }
      
      protected function PacketPerform_SC_CatchListRet(param1:TPacket) : void
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
         this.FUnstreamizerArrest.Unstreamize(_loc2_,this.FArrest,null);
         this.FProcessorWindowArrest.UpdateUI(this.FArrest);
      }
      
      protected function PacketPerform_SC_RescueMembersListRet(param1:TPacket) : void
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
         this.FUnstreamizerRescue.Unstreamize(_loc2_,this.FRescue,null);
         this.FProcessorWindowRescue.UpdateUI(this.FRescue);
      }
      
      protected function PacketPerform_SC_SOSListRet(param1:TPacket) : void
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
         this.FUnstreamizerSOS.Unstreamize(_loc2_,this.FSOS,null);
         this.FProcessorWindowRescue.UpdateUI(this.FSOS);
      }
      
      protected function PacketPerform_SC_InteractionLogRet(param1:TPacket) : void
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
         this.FUnstreamizerInteractionLog.Unstreamize(_loc2_,this.FInteractionLog,null);
         if(this.Visible)
         {
            this.FProcessorWindowSlave.UpdateLog(this.FInteractionLog);
         }
      }
      
      protected function PacketPerform_SC_ArrestDiscipleRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:Boolean = false;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         this.EnterBattle();
         _loc4_ = Boolean(_loc2_.readUnsignedByte());
         this.FMentorship.TodayArrestCount = _loc2_.readUnsignedInt();
         if(_loc4_)
         {
            this.FUnstreamizerDisciple.Unstreamize(_loc2_,this.FDisciple,null);
            this.FMentorship.DiscipleList.push(this.FDisciple);
         }
         this.FProcessorWindowSlave.UpdateUI(this.FMentorship);
      }
      
      protected function PacketPerform_SC_IntercationRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:TSlaveDisciple = null;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:TSlaveGainExp = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc5_ = _loc2_.readUnsignedInt();
         _loc6_ = _loc2_.readUnsignedInt();
         _loc7_ = _loc2_.readUnsignedInt();
         switch(this.FMentorship.Identity)
         {
            case CONST_SLAVE.IDENTITY_Master:
               _loc4_ = this.FMentorship.GetDiscipleByID(_loc5_,_loc6_);
               if(_loc4_ != null)
               {
                  _loc4_.InteractionCDTime = _loc7_;
                  _loc8_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SlaveGainExp,_loc4_.DiscipleLevel) as TSlaveGainExp;
                  EffectGenerateText(TUtilityString.Format(STRING_Mentorship.FORMAT_GetInteractionExp,_loc4_.DiscipleName,_loc8_.Operation));
               }
               break;
            case CONST_SLAVE.IDENTITY_Disciple:
               this.FMentorship.InteractionCDTime = _loc7_;
         }
         this.FMentorship.TodayInteractionCount = _loc2_.readUnsignedInt();
         this.FProcessorWindowSlave.UpdateUI(this.FMentorship);
      }
      
      protected function PacketPerform_SC_RescueRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:TSlaveDisciple = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         this.EnterBattle();
         _loc4_ = this.FMentorship.GetDiscipleByID(_loc2_.readUnsignedInt(),_loc2_.readUnsignedInt());
         if(_loc4_ != null)
         {
            _loc4_.InteractionCDTime = _loc2_.readUnsignedInt();
         }
         this.FMentorship.TodayRescueCount = _loc2_.readUnsignedInt();
      }
      
      protected function PacketPerform_SC_GetExpRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:TSlaveDisciple = null;
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
         _loc4_ = _loc2_.readUnsignedInt();
         _loc5_ = this.FMentorship.GetDiscipleByID(_loc2_.readUnsignedInt(),_loc2_.readUnsignedInt());
         if(_loc5_ != null)
         {
            _loc5_.StartWorkTime = _loc2_.readUnsignedInt();
            _loc5_.DrawTime = _loc2_.readUnsignedInt();
         }
         _loc6_ = this.FMentorship.TodayGetExp;
         this.FMentorship.TodayGetExp = _loc2_.readUnsignedInt();
         _loc7_ = this.FMentorship.TodayGetExp - _loc6_;
         _loc8_ = _loc2_.readUnsignedInt();
         if(_loc5_ != null)
         {
            _loc5_.AddUpExp = _loc2_.readUnsignedInt();
         }
         switch(_loc4_)
         {
            case CONST_SLAVE.COMMAND_Draw:
               break;
            case CONST_SLAVE.COMMAND_Squeeze:
            case CONST_SLAVE.COMMAND_DrawAll:
            case CONST_SLAVE.COMMAND_Release:
               EffectGenerateText(TUtilityString.Format(STRING_Mentorship.FORMAT_GetExp,_loc5_.DiscipleName,_loc7_));
         }
         this.FProcessorWindowSlave.UpdateUI(this.FMentorship);
      }
      
      protected function PacketPerform_SC_ReleaseRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:TSlaveDisciple = null;
         var _loc5_:uint = 0;
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
         _loc5_ = _loc2_.readUnsignedInt();
         _loc6_ = _loc2_.readUnsignedInt();
         this.FMentorship.Identity = _loc2_.readUnsignedInt();
         _loc7_ = this.FMentorship.TodayGetExp;
         this.FMentorship.TodayGetExp = _loc2_.readUnsignedInt();
         _loc8_ = this.FMentorship.TodayGetExp - _loc7_;
         _loc4_ = this.FMentorship.GetDiscipleByID(_loc5_,_loc6_);
         EffectGenerateText(TUtilityString.Format(STRING_Mentorship.FORMAT_Release,_loc4_.DiscipleName,_loc8_));
         this.FMentorship.DeleteDiscipleByID(_loc5_,_loc6_);
         this.FProcessorWindowSlave.UpdateUI(this.FMentorship);
      }
      
      protected function PacketPerform_SC_RedeemRet(param1:TPacket) : void
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
         this.FMentorship.DeleteDiscipleByID(_loc2_.readUnsignedInt(),_loc2_.readUnsignedInt());
         this.FMentorship.Identity = CONST_SLAVE.IDENTITY_Freedom;
         this.FProcessorWindowSlave.UpdateUI(this.FMentorship);
      }
      
      protected function PacketPerform_SC_CommandRet(param1:TPacket) : void
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
      
      protected function PacketPerform_SC_ResistRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:Boolean = false;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         this.EnterBattle();
         _loc5_ = Boolean(_loc2_.readUnsignedByte());
         this.FMentorship.TodayResistCount = _loc2_.readUnsignedInt();
         if(_loc5_)
         {
            this.FMentorship.Identity = CONST_SLAVE.IDENTITY_Freedom;
         }
         this.FProcessorWindowSlave.UpdateUI(this.FMentorship);
      }
      
      protected function PacketPerform_SC_SOSRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:TSOSPlayer = null;
         var _loc5_:Boolean = false;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         this.EnterBattle();
         _loc5_ = Boolean(_loc2_.readUnsignedByte());
         _loc6_ = _loc2_.readUnsignedInt();
         _loc7_ = _loc2_.readUnsignedInt();
         _loc4_ = this.FSOS.GetSOSPlayerByID(_loc6_,_loc7_);
         this.FMentorship.TodaySOSCount = _loc2_.readUnsignedInt();
         if(_loc5_)
         {
            this.FMentorship.Identity = CONST_SLAVE.IDENTITY_Freedom;
         }
         this.FProcessorWindowSlave.UpdateUI(this.FMentorship);
      }
      
      protected function PacketPerform_SC_RankRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc5_:int = 0;
         var _loc6_:TSlaveRank = null;
         var _loc7_:Vector.<TSlaveRank> = null;
         _loc2_ = param1.Data;
         var _loc3_:int = _loc2_.readInt();
         var _loc4_:int = _loc2_.readShort();
         _loc7_ = Vector.<TSlaveRank>([]);
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc6_ = new TSlaveRank();
            _loc6_.Rank = _loc2_.readInt();
            _loc6_.UserName = TUtilityString.FetchUTF(_loc2_);
            _loc6_.Server = TUtilityString.FetchUTF(_loc2_);
            _loc6_.Count = _loc2_.readInt();
            _loc7_.push(_loc6_);
            _loc5_++;
         }
         this.FProcessorWindowSlaveRank.Init(_loc7_,_loc3_);
      }
      
      protected function PacketPerform_SC_BuyRet(param1:TPacket) : void
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
         EffectGenerateText(STRING_BASEACTIVITY.FORMAT_BUY_SUCCESSED);
      }
      
      protected function PacketPerform_CS_BuyReq() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Slave_BuyReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PacketPerform_CS_RankReq(param1:int) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Slave_RankReq);
         _loc2_.Data.writeInt(param1);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function ProcessorOnCMDReq(param1:Object, param2:uint, param3:uint, param4:uint, param5:uint) : void
      {
         var _loc6_:TPacket = null;
         var _loc7_:ByteArray = null;
         _loc6_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Slave_CommandReq);
         _loc7_ = _loc6_.Data;
         _loc7_.writeByte(param2);
         _loc7_.writeByte(param3);
         _loc7_.writeUnsignedInt(param4);
         _loc7_.writeUnsignedInt(param5);
         SNetworkCore.Transceiver.PacketTransmit(_loc6_);
      }
      
      protected function PacketPerform_CS_CatchListReq() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Slave_CatchListReq);
         _loc2_ = _loc1_.Data;
         _loc2_.writeUnsignedInt(0);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PacketPerform_CS_RescueMembersListReq() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Slave_RescueMembersListReq);
         _loc2_ = _loc1_.Data;
         _loc2_.writeUnsignedInt(0);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PACKETID_CS_SOSListReq() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Slave_SOSListReq);
         _loc2_ = _loc1_.Data;
         _loc2_.writeUnsignedInt(0);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function EnterBattle() : void
      {
         if(this.FSetStatusType != null)
         {
            this.FSetStatusType(this,CONST_BATTLE.BattleType_CrossSlave,0);
         }
         if(this.FOnInitBattle != null)
         {
            this.FOnInitBattle(this);
         }
      }
      
      protected function PacketPerform_CS_LoadBaseDataReq() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Slave_LoadBaseDataReq);
         _loc2_ = _loc1_.Data;
         _loc2_.writeUnsignedInt(0);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function ProcessorWindowOnClose(param1:Object) : void
      {
         if(param1 is TProcessorWindowSlave)
         {
            ProcessorClose();
         }
         else
         {
            this.FProcessorWindowSlave.Visible = true;
            param1.Visible = false;
            this.FProcessorWindowSlave.UpdateUI(this.FMentorship);
         }
      }
      
      protected function ProcessorWindowOnArrest(param1:Object) : void
      {
         this.PacketPerform_CS_CatchListReq();
         param1.Visible = false;
         this.FProcessorWindowArrest.Visible = true;
      }
      
      protected function ProcessorWindowOnRescueMembers(param1:Object, param2:uint) : void
      {
         param1.Visible = false;
         this.FProcessorWindowRescue.Visible = true;
         if(param2 == CONST_SLAVE.TYPE_Rescue)
         {
            this.PacketPerform_CS_RescueMembersListReq();
         }
         else if(param2 == CONST_SLAVE.TYPE_SOS)
         {
            this.PACKETID_CS_SOSListReq();
         }
      }
      
      protected function ProcessorWindowOnInteraction(param1:Object, param2:Object) : void
      {
         param1.Visible = false;
         this.FProcessorWindowInteraction.Visible = true;
         this.FProcessorWindowInteraction.UpdateUI(param2);
      }
      
      protected function ProcessorOnShowOtherPlayerInfor(param1:Object, param2:uint, param3:uint) : void
      {
         if(this.FOnShowOtherPlayerInfor != null)
         {
            this.FOnShowOtherPlayerInfor(this,param2,param3);
         }
      }
      
      protected function ProcessorWindowOnRank() : void
      {
         this.FProcessorWindowSlaveRank.Visible = true;
      }
      
      protected function ProcessorWindowOnReward(param1:TSlaveDisciple) : void
      {
         this.FProcessorWindowSlaveReward.Visible = true;
         this.FProcessorWindowSlaveReward.Update(param1);
      }
      
      public function get OnShowOtherPlayerInfor() : Function
      {
         return this.FOnShowOtherPlayerInfor;
      }
      
      public function set OnShowOtherPlayerInfor(param1:Function) : void
      {
         this.FOnShowOtherPlayerInfor = param1;
      }
      
      public function set SetStatusType(param1:Function) : void
      {
         this.FSetStatusType = param1;
      }
      
      public function get SetStatusType() : Function
      {
         return this.FSetStatusType;
      }
      
      public function set OnInitBattle(param1:Function) : void
      {
         this.FOnInitBattle = param1;
      }
      
      public function get OnInitBattle() : Function
      {
         return this.FOnInitBattle;
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount(param1);
         if(!FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowSlave.Load();
            this.FProcessorWindowArrest.Load();
            this.FProcessorWindowRescue.Load();
            this.FProcessorWindowInteraction.Load();
            this.FProcessorWindowSlaveRank.Load();
            this.FProcessorWindowSlaveReward.Load();
            return;
         }
         this.FProcessorWindowSlave.Visible = true;
         this.FProcessorWindowArrest.Visible = false;
         this.FProcessorWindowInteraction.Visible = false;
         this.FProcessorWindowRescue.Visible = false;
         this.PacketPerform_CS_LoadBaseDataReq();
         this.FProcessorWindowSlave.UpdateLog(this.FInteractionLog);
      }
      
      public function UpdateUI() : void
      {
         this.FProcessorWindowSlave.UpdateUI(this.FMentorship);
      }
   }
}

