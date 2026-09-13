package Processors.Game.Lobby.MakeEquipAdvanced
{
   import Foundation.Common.TBounds;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Logics.Inventories.TInventory;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import Processors.Game.Windows.Information.TUIWindowConfirmation;
   import Rendering.Overlayers.Inventories.TOverlayerAccessory;
   import Rendering.Overlayers.Inventories.TOverlayerAppliance;
   import Rendering.Overlayers.Inventories.TOverlayerEquipment;
   import Resources.Constants.CONST_EQUIPADVANCED;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.utils.ByteArray;
   
   public class TProcessorEquipAdvanced extends TProcessorLobbyWindows
   {
      
      protected var FProcessorWindowEquipAdvanced:TProcessorWindowEquipAdvanced;
      
      protected var FBoundsEquip:TBounds;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FContext:Object;
      
      protected var FMakeConfirmation:TUIWindowConfirmation;
      
      public function TProcessorEquipAdvanced(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FProcessorWindowEquipAdvanced = new TProcessorWindowEquipAdvanced(this);
         this.FProcessorWindowEquipAdvanced.OnClose = this.ProcessorWindowTalismanOnClose;
         this.FProcessorWindowEquipAdvanced.OnInventoryOver = UIComponentsHintOnOver;
         this.FProcessorWindowEquipAdvanced.OnInventoryOut = UIComponentsHintOnOut;
         this.FProcessorWindowEquipAdvanced.EquipAdvanced = this.EquipAdvanced;
         this.FProcessorWindowEquipAdvanced.ShowMakeConfirmation = this.ShowMakeConfirmation;
         this.FBoundsEquip = new TBounds();
         this.FBoundsEquip.Width = 470;
         this.FBoundsEquip.Height = 480;
         ComponentBoundsCenter(this.FProcessorWindowEquipAdvanced,this.FBoundsEquip);
         FOverlayerEquipment = new TOverlayerEquipment(this,CONST_MODULES.MODULE_MakeEquipAdv);
         FOverlayerEquipment.Visible = false;
         FOverlayerAppliance = new TOverlayerAppliance(this,CONST_MODULES.MODULE_MakeEquipAdv);
         FOverlayerAppliance.Visible = false;
         FOverlayerAccessory = new TOverlayerAccessory(this,CONST_MODULES.MODULE_MakeEquipAdv);
         FOverlayerAccessory.Visible = false;
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         SetUIModuleID(CONST_MODULES.MODULE_MakeEquipAdv);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_EQUIPADVANCED.RESOURCESID_EQUIPADVANCED);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         super.ResourcesPerform_UIDispatch();
         this.FMakeConfirmation = new TUIWindowConfirmation(this.Parent.Parent);
         TUtilityUIWindow.SetupWindowConfirmation(this.FMakeConfirmation);
         this.FMakeConfirmation.x = (FUICore.StageWidth - this.FMakeConfirmation.WindowWidth) / 2;
         this.FMakeConfirmation.y = (FUICore.StageHeight - this.FMakeConfirmation.WindowHeight) / 2;
         this.FMakeConfirmation.OnOK = this.OnAdvMake;
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerEquipment);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerAppliance);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerAccessory);
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Equip_Advanced,this.PerformPacket_SC_Equip_Advanced);
      }
      
      protected function PerformPacket_SC_Equip_Advanced(param1:TPacket) : void
      {
         var _loc2_:ByteArray = param1.Data;
         var _loc3_:uint = _loc2_.readUnsignedInt();
         if(_loc3_ == 0)
         {
            this.FProcessorWindowEquipAdvanced.EquipAdvancedOk();
         }
         else
         {
            EffectGenerateTextByErrorCode(_loc3_);
         }
      }
      
      protected function PerformPacket_CS_EquipAdvancedRequest(param1:uint, param2:uint) : void
      {
         var _loc3_:TPacket = null;
         _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Equip_Advanced);
         _loc3_.Data.writeUnsignedInt(param1);
         _loc3_.Data.writeUnsignedInt(param2);
         SNetworkCore.Transceiver.PacketTransmit(_loc3_);
      }
      
      protected function ShowMakeConfirmation(param1:String) : void
      {
         this.FMakeConfirmation.Text = param1;
         this.FMakeConfirmation.Visible = true;
      }
      
      protected function OnAdvMake(param1:Object) : void
      {
         this.FProcessorWindowEquipAdvanced.AdvMakeEquip();
      }
      
      protected function EquipAdvanced(param1:Object, param2:Object) : void
      {
         var _loc3_:TInventory = param2 as TInventory;
         var _loc4_:uint = _loc3_.Identifier0;
         var _loc5_:uint = _loc3_.Identifier1;
         this.PerformPacket_CS_EquipAdvancedRequest(_loc4_,_loc5_);
      }
      
      protected function ProcessorWindowTalismanOnClose(param1:Object) : void
      {
         ProcessorClose();
      }
      
      override public function get OnEffectText() : Function
      {
         return FOnEffectText;
      }
      
      override public function set OnEffectText(param1:Function) : void
      {
         FOnEffectText = param1;
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount();
         if(!FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowEquipAdvanced.Load();
            return;
         }
         this.FProcessorWindowEquipAdvanced.visible = true;
         this.FProcessorWindowEquipAdvanced.Update(this.FContext);
      }
      
      override public function Unmount() : void
      {
         super.Unmount();
      }
      
      public function SetContext(param1:Object) : void
      {
         this.FContext = param1;
      }
   }
}

