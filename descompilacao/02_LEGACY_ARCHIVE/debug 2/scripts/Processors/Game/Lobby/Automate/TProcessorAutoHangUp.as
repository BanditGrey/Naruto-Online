package Processors.Game.Lobby.Automate
{
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.UI.TUIComponent;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import Resources.Constants.CONST_AUTOHANGUP;
   import Resources.Constants.CONST_NETWORK;
   import flash.utils.ByteArray;
   
   public class TProcessorAutoHangUp extends TProcessorLobbyWindows
   {
      
      protected var FStatusList:Vector.<uint>;
      
      protected var FOnAutoHangUpStatusRet:Function;
      
      public function TProcessorAutoHangUp(param1:TUIComponent, param2:TLobbyParameters = null)
      {
         super(param1,param2);
         this.FStatusList = new Vector.<uint>();
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Automate_StatusRet,this.PerformPacket_SC_StatusRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Automate_OperateRet,this.PerformPacket_SC_OperateRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Automate_StatusUpdate,this.PerformPacket_SC_StatusUpdate);
         super.PacketRegisterRoutines();
      }
      
      protected function PerformPacket_SC_StatusRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:String = null;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:int = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         _loc4_ = _loc3_.toString(2);
         while(this.FStatusList.length > 0)
         {
            this.FStatusList.pop();
         }
         _loc6_ = CONST_AUTOHANGUP.AutoHangUpVec.length;
         _loc5_ = uint(_loc4_.length);
         _loc7_ = 0;
         while(_loc7_ < _loc5_)
         {
            this.FStatusList[_loc7_] = parseInt(_loc4_.slice(_loc7_,_loc7_ + 1));
            _loc7_++;
         }
         while(_loc6_ > _loc5_)
         {
            this.FStatusList.unshift(0);
            _loc6_--;
         }
         this.FStatusList.reverse();
         if(this.FOnAutoHangUpStatusRet != null)
         {
            this.FOnAutoHangUpStatusRet(this,this.FStatusList);
         }
      }
      
      protected function PerformPacket_SC_OperateRet(param1:TPacket) : void
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
         _loc4_ = _loc2_.readUnsignedByte();
         this.FStatusList[_loc4_ - 1] = 1;
         if(this.FOnAutoHangUpStatusRet != null)
         {
            this.FOnAutoHangUpStatusRet(this,this.FStatusList);
         }
      }
      
      protected function PerformPacket_SC_StatusUpdate(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedByte();
         this.FStatusList[_loc3_ - 1] = 0;
         if(this.FOnAutoHangUpStatusRet != null)
         {
            this.FOnAutoHangUpStatusRet(this,this.FStatusList);
         }
      }
      
      protected function PerformPacket_CS_StatusReq() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Automate_StatusReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      public function get OnAutoHangUpStatusRet() : Function
      {
         return this.FOnAutoHangUpStatusRet;
      }
      
      public function set OnAutoHangUpStatusRet(param1:Function) : void
      {
         this.FOnAutoHangUpStatusRet = param1;
      }
      
      public function StatusReq() : void
      {
         this.PerformPacket_CS_StatusReq();
      }
   }
}

