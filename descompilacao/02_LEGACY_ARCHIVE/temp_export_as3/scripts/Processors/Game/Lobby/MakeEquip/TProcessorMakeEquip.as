package Processors.Game.Lobby.MakeEquip
{
   import Foundation.Common.TBounds;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Queries.Coordinate.TQueryCoordinate;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Logics.Inventories.TInventory;
   import Processors.Game.Common.Effects.Texts.TEffectCoordinateParameters;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import Rendering.Overlayers.HelpTips.TOverlayerHelpTips;
   import Rendering.Overlayers.Inventories.TOverlayerAccessory;
   import Rendering.Overlayers.Inventories.TOverlayerAppliance;
   import Rendering.Overlayers.Inventories.TOverlayerEquipment;
   import Resources.Constants.CONST_EQUIPMAKE;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_SHORTCUTS;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.utils.ByteArray;
   
   public class TProcessorMakeEquip extends TProcessorLobbyWindows
   {
      
      protected var FProcessorWindowMakeEquip:TProcessorWindowMakeEquip;
      
      protected var FBoundsEquip:TBounds;
      
      protected var FOnEffectAcquireInventory:Function;
      
      protected var FOnQueryShortcutCoordinate:Function;
      
      public function TProcessorMakeEquip(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FProcessorWindowMakeEquip = new TProcessorWindowMakeEquip(this);
         this.FProcessorWindowMakeEquip.OnClose = this.ProcessorWindowTalismanOnClose;
         this.FProcessorWindowMakeEquip.OnInventoryOver = UIComponentsHintOnOver;
         this.FProcessorWindowMakeEquip.OnInventoryOut = UIComponentsHintOnOut;
         this.FProcessorWindowMakeEquip.OnHelpTipsOver = UIHelpTipsHintOnOver;
         this.FProcessorWindowMakeEquip.OnHelpTipsOut = UIHelpTipsHintOnOut;
         this.FProcessorWindowMakeEquip.EquipMake = this.EquipMake;
         this.FProcessorWindowMakeEquip.OnEffectAcquireInventory = this.ProcessorOnEffectAcquireInventory;
         this.FProcessorWindowMakeEquip.OnQueryShortcutCoordinate = this.ProcessorOnQueryShortcutCoordinate;
         this.FBoundsEquip = new TBounds();
         this.FBoundsEquip.Width = 873;
         this.FBoundsEquip.Height = 559;
         ComponentBoundsCenter(this.FProcessorWindowMakeEquip,this.FBoundsEquip);
         FOverlayerEquipment = new TOverlayerEquipment(this,CONST_MODULES.MODULE_MakeEquip);
         FOverlayerEquipment.Visible = false;
         FOverlayerAppliance = new TOverlayerAppliance(this,CONST_MODULES.MODULE_MakeEquip);
         FOverlayerAppliance.Visible = false;
         FOverlayerHelpTips = new TOverlayerHelpTips(this);
         FOverlayerHelpTips.Visible = false;
         FOverlayerAccessory = new TOverlayerAccessory(this,CONST_MODULES.MODULE_MakeEquip);
         FOverlayerAccessory.Visible = false;
         SetUIModuleID(CONST_MODULES.MODULE_MakeEquip);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_EQUIPMAKE.RESOURCESID_EQUIP);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerEquipment);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerAppliance);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerHelpTips);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerAccessory);
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Equip_Make,this.PerformPacket_SC_Equip_Make);
      }
      
      protected function PerformPacket_SC_Equip_Make(param1:TPacket) : void
      {
         var _loc2_:ByteArray = param1.Data;
         var _loc3_:uint = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
         }
         this.FProcessorWindowMakeEquip.Update();
      }
      
      protected function PerformPacket_CS_EquipMakeRequest(param1:uint) : void
      {
         var _loc2_:TPacket = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Equip_Make);
         _loc2_.Data.writeUnsignedInt(param1);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function EquipMake(param1:Object, param2:Object) : void
      {
         var _loc3_:TInventory = null;
         var _loc4_:uint = 0;
         _loc3_ = param2 as TInventory;
         _loc4_ = _loc3_.IDTemplate;
         this.PerformPacket_CS_EquipMakeRequest(_loc4_);
      }
      
      protected function ProcessorWindowTalismanOnClose(param1:Object) : void
      {
         ProcessorClose();
      }
      
      protected function ProcessorOnEffectAcquireInventory(param1:Object, param2:Object, param3:TEffectCoordinateParameters) : void
      {
         if(this.FOnEffectAcquireInventory != null)
         {
            this.FOnEffectAcquireInventory(param1,param2,param3);
         }
      }
      
      protected function ProcessorOnQueryShortcutCoordinate(param1:Object, param2:uint, param3:TQueryCoordinate) : void
      {
         if(this.FOnQueryShortcutCoordinate != null)
         {
            this.FOnQueryShortcutCoordinate(param1,CONST_SHORTCUTS.POSITION_Function,param2,param3);
         }
      }
      
      override public function get OnEffectText() : Function
      {
         return FOnEffectText;
      }
      
      override public function set OnEffectText(param1:Function) : void
      {
         FOnEffectText = param1;
         this.FProcessorWindowMakeEquip.OnEffectText = FOnEffectText;
      }
      
      public function get OnEffectAcquireInventory() : Function
      {
         return this.FOnEffectAcquireInventory;
      }
      
      public function set OnEffectAcquireInventory(param1:Function) : void
      {
         this.FOnEffectAcquireInventory = param1;
      }
      
      public function get OnQueryShortcutCoordinate() : Function
      {
         return this.FOnQueryShortcutCoordinate;
      }
      
      public function set OnQueryShortcutCoordinate(param1:Function) : void
      {
         this.FOnQueryShortcutCoordinate = param1;
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount();
         if(!FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowMakeEquip.Load();
            return;
         }
         this.FProcessorWindowMakeEquip.visible = true;
         this.FProcessorWindowMakeEquip.Update();
         this.FProcessorWindowMakeEquip.PlayEffect();
      }
   }
}

