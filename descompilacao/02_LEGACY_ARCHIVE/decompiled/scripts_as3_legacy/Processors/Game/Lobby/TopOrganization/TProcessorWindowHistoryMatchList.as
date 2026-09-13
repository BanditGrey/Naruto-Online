package Processors.Game.Lobby.TopOrganization
{
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Processors.Game.Lobby.Common.TProcessorWindowTemplate;
   import Processors.Game.Lobby.TopOrganization.Componets.TUIFinalMatchList;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_TOPORGANIZATION;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   
   public class TProcessorWindowHistoryMatchList extends TProcessorWindowTemplate
   {
      
      protected var FUIFinalMatchList:TUIFinalMatchList;
      
      protected var FOnReturnMainUI:Function;
      
      public function TProcessorWindowHistoryMatchList(param1:TUIComponent)
      {
         super(param1);
         this.FUIFinalMatchList = new TUIFinalMatchList(this);
         this.FUIFinalMatchList.TabOnClick = this.ProcessorTabOnClick;
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_TOPORGANIZATION.RESOURCESID_Swf_TopOrganization);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         FMainUI = TUtilityReflection.CreateDisplayObjectInstance(CONST_TOPORGANIZATION.RESOURCE_ClassName_MC_HistoryMatchList) as Sprite;
         UIDispatch();
         this.FUIFinalMatchList.UIDispatch();
         this.FUIFinalMatchList.x = FMainUI.x + 125;
         this.FUIFinalMatchList.y = FMainUI.y + 168;
         addChild(this.FUIFinalMatchList);
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         UILocations();
      }
      
      protected function UpdateUI() : void
      {
         this.FUIFinalMatchList.Update();
         this.FUIFinalMatchList.HideBetButton();
      }
      
      override protected function ButtonCloseOnClick(param1:MouseEvent) : void
      {
         super.ButtonCloseOnClick(param1);
         this.FUIFinalMatchList.Reset();
      }
      
      protected function ProcessorTabOnClick(param1:Object, param2:int) : void
      {
         var _loc3_:TPacket = null;
         var _loc4_:ByteArray = null;
         _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TopOrganization_GVG3_GetLastWeek_Req);
         _loc4_ = _loc3_.Data;
         _loc4_.writeUnsignedInt(param2);
         SNetworkCore.Transceiver.PacketTransmit(_loc3_);
      }
      
      public function set OnReturnMainUI(param1:Function) : void
      {
         this.FOnReturnMainUI = param1;
      }
      
      public function Update() : void
      {
         this.UpdateUI();
      }
   }
}

