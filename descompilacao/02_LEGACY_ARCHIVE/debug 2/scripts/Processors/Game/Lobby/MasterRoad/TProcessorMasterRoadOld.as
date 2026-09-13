package Processors.Game.Lobby.MasterRoad
{
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import Resources.Constants.CONST_NETWORK;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   
   public class TProcessorMasterRoadOld extends TProcessorLobbyWindows
   {
      
      protected var FMcPanel:Sprite;
      
      protected var FMC_EnergyCount:TextField;
      
      protected var FBTN_Close:SimpleButton;
      
      public function TProcessorMasterRoadOld(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(1509949440);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.FMcPanel = TUtilityReflection.CreateDisplayObjectInstance("MC_TheMasterRoad") as Sprite;
         this.FMcPanel.x = (FUICore.StageWidth - this.FMcPanel.width) / 2;
         this.FMcPanel.y = (FUICore.StageHeight - this.FMcPanel.height) / 2;
         addChild(this.FMcPanel);
         this.FBTN_Close = this.FMcPanel["BTN_Close"];
         this.FMC_EnergyCount = this.FMcPanel["MC_EnergyCount"];
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FBTN_Close.addEventListener(MouseEvent.CLICK,this.CloseMe);
         super.ResourcesPerform_UILocations();
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount();
         if(!FIsResourcesLoadCompleted)
         {
            return;
         }
         this.C_S();
      }
      
      override public function Unmount() : void
      {
         super.Unmount();
      }
      
      public function C_S() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_C2S_DaShiDianShu);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_S2C_DaShiDianShu,this.S_c);
      }
      
      public function S_c(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         this.FMC_EnergyCount.text = _loc3_.toString();
         SLogicsCore.MasterRoad.IsFirst = _loc2_.readUnsignedInt();
      }
      
      public function CloseMe(param1:MouseEvent) : void
      {
         if(FOnClose != null)
         {
            FOnClose(this);
         }
      }
   }
}

