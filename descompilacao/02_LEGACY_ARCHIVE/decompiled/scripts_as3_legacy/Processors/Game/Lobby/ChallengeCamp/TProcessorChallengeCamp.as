package Processors.Game.Lobby.ChallengeCamp
{
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Logics.ChallengeCamp.TChallengeCamp;
   import Logics.Streamization.ChallengeCamp.TUnstreamizerChallengeCamp;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import Resources.Constants.CONST_BATTLE;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.utils.ByteArray;
   
   public class TProcessorChallengeCamp extends TProcessorLobbyWindows
   {
      
      protected var FProcessorWindow:TProcessorWindowChallengeCamp;
      
      protected var FUnstreamizerChallengeCamp:TUnstreamizerChallengeCamp;
      
      protected var FChallengeCamp:TChallengeCamp;
      
      protected var FSetStatusType:Function;
      
      protected var FOnInitBattle:Function;
      
      public function TProcessorChallengeCamp(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FUnstreamizerChallengeCamp = new TUnstreamizerChallengeCamp();
         this.FChallengeCamp = new TChallengeCamp();
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(4026531844);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.FProcessorWindow = new TProcessorWindowChallengeCamp(this);
         this.FProcessorWindow.Load();
         this.FProcessorWindow.Visible = true;
         this.FProcessorWindow.OnClose = this.ProcessorWindowClose;
         this.FProcessorWindow.OnStartFight = this.PerformPacket_CS_ChallengeCamp_Fight_Req;
         this.FProcessorWindow.OnGetReward = this.PerformPacket_CS_ChallengeCamp_Reward_Req;
         this.FProcessorWindow.OnBuyRequest = this.PerformPacket_CS_ChallengeCamp_Buy_Req;
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_ChallengeCamp_Info_Ret,this.PerformPacket_SC_ChallengeCamp_Info_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_ChallengeCamp_Fight_Ret,this.PerformPacket_SC_ChallengeCamp_Fight_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_ChallengeCamp_Reward_Ret,this.PerformPacket_SC_ChallengeCamp_Reward_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_ChallengeCamp_Buy_Ret,this.PerformPacket_SC_ChallengeCamp_Buy_Ret);
      }
      
      protected function PerformPacket_SC_ChallengeCamp_Fight_Ret(param1:TPacket) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:ByteArray = param1.Data;
         _loc3_ = int(_loc2_.readUnsignedInt());
         _loc4_ = _loc2_.readInt();
         this.FChallengeCamp.GetBattleByID(_loc3_).Status = _loc4_;
         this.FProcessorWindow.UpdateUI(this.FChallengeCamp);
         if(this.FSetStatusType != null)
         {
            this.FSetStatusType(this,CONST_BATTLE.BattleType_ChallengeCamp,0);
         }
         if(this.FOnInitBattle != null)
         {
            this.FOnInitBattle(this);
         }
      }
      
      protected function PerformPacket_SC_ChallengeCamp_Reward_Ret(param1:TPacket) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:ByteArray = param1.Data;
         _loc4_ = _loc2_.readInt();
         if(_loc4_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc4_);
            return;
         }
         _loc3_ = int(_loc2_.readUnsignedInt());
         this.PerformPacket_CS_ChallengeCamp_Info_Req();
         EffectGenerateText(STRING_BASEACTIVITY.FORMAT_GET);
      }
      
      protected function PerformPacket_SC_ChallengeCamp_Info_Ret(param1:TPacket) : void
      {
         var _loc2_:ByteArray = param1.Data;
         var _loc3_:int = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         this.FUnstreamizerChallengeCamp.Unstreamize(_loc2_,this.FChallengeCamp,null);
         this.FProcessorWindow.UpdateUI(this.FChallengeCamp);
      }
      
      protected function PerformPacket_SC_ChallengeCamp_Buy_Ret(param1:TPacket) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:ByteArray = param1.Data;
         var _loc5_:int = _loc2_.readInt();
         if(_loc5_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc5_);
            return;
         }
         _loc3_ = int(_loc2_.readUnsignedInt());
         _loc4_ = int(_loc2_.readUnsignedInt());
         this.FChallengeCamp.GetBattleByID(_loc3_).LimitCount = _loc4_;
         this.FProcessorWindow.UpdateUI(this.FChallengeCamp);
      }
      
      protected function PerformPacket_CS_ChallengeCamp_Reward_Req(param1:int) : void
      {
         var _loc2_:TPacket = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_ChallengeCamp_Reward_Req);
         _loc2_.Data.writeUnsignedInt(param1);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function PerformPacket_CS_ChallengeCamp_Info_Req() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_ChallengeCamp_Info_Req);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PerformPacket_CS_ChallengeCamp_Fight_Req(param1:int) : void
      {
         var _loc2_:TPacket = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_ChallengeCamp_Fight_Req);
         _loc2_.Data.writeUnsignedInt(param1);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function PerformPacket_CS_ChallengeCamp_Buy_Req(param1:int, param2:int) : void
      {
         var _loc3_:TPacket = null;
         _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_ChallengeCamp_Buy_Req);
         _loc3_.Data.writeUnsignedInt(param1);
         _loc3_.Data.writeUnsignedInt(param2);
         SNetworkCore.Transceiver.PacketTransmit(_loc3_);
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount();
         if(!FIsResourcesLoadCompleted)
         {
            return;
         }
         this.PerformPacket_CS_ChallengeCamp_Info_Req();
      }
      
      protected function ProcessorWindowClose(param1:Object) : void
      {
         ProcessorClose();
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
   }
}

