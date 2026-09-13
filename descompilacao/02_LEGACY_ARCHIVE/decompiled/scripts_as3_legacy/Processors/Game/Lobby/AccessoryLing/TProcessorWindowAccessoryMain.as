package Processors.Game.Lobby.AccessoryLing
{
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Resources.Repositories.TResourceRepositoryTexture;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Resources.Textures.TTexture;
   import Foundation.UI.TUIComponent;
   import Logics.Inventories.TInventory;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import Rendering.Overlayers.Inventories.TOverlayerAccessory;
   import Rendering.Overlayers.Inventories.TOverlayerAppliance;
   import Rendering.Overlayers.Inventories.TOverlayerEquipment;
   import Rendering.Overlayers.Inventories.TOverlayerTreasure;
   import Rendering.Overlayers.TOverlayer;
   import Resources.Constants.CONST_ACCESSORY_INTENSITY;
   import Resources.Constants.CONST_INVENTORY;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Strings.STRING_HEROS;
   import Resources.Strings.STRING_TALISMAN;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.utils.ByteArray;
   
   public class TProcessorWindowAccessoryMain extends TProcessorLobbyWindows
   {
      
      public static const CATEGORY_Accessories:uint = CONST_INVENTORY.CATEGORY_Accessories;
      
      protected var FProcessorWindowAccessory:TProcessorWindowAccessory = null;
      
      protected var FOverlaterAccessory:TOverlayerAccessory;
      
      protected var FOverlayerTreasure1:TOverlayerAccessory;
      
      protected var FOverlayerEquipmentMounted:TOverlayerEquipment;
      
      public function TProcessorWindowAccessoryMain(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FProcessorWindowAccessory = new TProcessorWindowAccessory(this);
         this.FProcessorWindowAccessory.CloseMe = ProcessorClose;
         this.FProcessorWindowAccessory.OnInventoryOver = this.OnInventoryOver;
         this.FProcessorWindowAccessory.OnInventoryOut = this.OnInventoryOut;
         this.FProcessorWindowAccessory.SlotsOnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
         this.FProcessorWindowAccessory.ApplianceOnOver = this.ApplianceOnOver;
         this.FProcessorWindowAccessory.ApplianceOnOut = this.ApplianceOnOut;
         this.FProcessorWindowAccessory.IntensityAreaFunction = this.IntensityAreaClick;
         this.FProcessorWindowAccessory.LinZhuAreaFunction = this.LinZhuAreaClick;
         this.FProcessorWindowAccessory.ChangeAreaFunction = this.ChangeAreaClick;
         this.FProcessorWindowAccessory.SendTipFc = this.SendTip;
         this.FOverlayerTreasure1 = new TOverlayerAccessory(this,CONST_MODULES.MODULE_AccessoryLing);
         this.FOverlayerTreasure1.Visible = false;
         this.FOverlayerEquipmentMounted = new TOverlayerEquipment(this,CONST_MODULES.MODULE_AccessoryLing);
         this.FOverlayerEquipmentMounted.Visible = false;
         SetUIModuleID(CONST_MODULES.MODULE_AccessoryLing);
      }
      
      protected function SendTip(param1:String) : void
      {
         EffectGenerateText(param1);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_ACCESSORY_INTENSITY.INTENSITY_ResourceId);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerTreasure1);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerEquipmentMounted);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         FOverlayerAppliance = new TOverlayerAppliance(this,CONST_MODULES.MODULE_AccessoryLing);
         FOverlayerAppliance.Visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerAppliance);
         this.FOverlaterAccessory = new TOverlayerAccessory(this,CONST_MODULES.MODULE_AccessoryLing);
         this.FOverlaterAccessory.Visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlaterAccessory);
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount();
         if(!FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowAccessory.Load();
            return;
         }
         this.FProcessorWindowAccessory.visible = true;
         this.FProcessorWindowAccessory.OpenMePanel();
      }
      
      override public function Unmount() : void
      {
         super.Unmount();
         this.FProcessorWindowAccessory.CloseMePanel();
      }
      
      protected function ApplianceOnOver(param1:Object, param2:Object) : void
      {
         var _loc3_:TOverlayer = null;
         var _loc4_:TInventory = null;
         _loc4_ = param2 as TInventory;
         switch(_loc4_.Category)
         {
            case CATEGORY_Accessories:
               _loc3_ = this.FOverlaterAccessory;
               break;
            default:
               _loc3_ = FOverlayerAppliance;
         }
         if(_loc3_ != null)
         {
            _loc3_.Context = _loc4_;
            _loc3_.Render(FUICore.MouseCoordinate);
            _loc3_.Show();
         }
      }
      
      protected function ApplianceOnOut(param1:Object, param2:Object) : void
      {
         var _loc3_:TOverlayer = null;
         var _loc4_:TInventory = null;
         _loc4_ = param2 as TInventory;
         switch(_loc4_.Category)
         {
            case CATEGORY_Accessories:
               _loc3_ = this.FOverlaterAccessory;
               break;
            default:
               _loc3_ = FOverlayerAppliance;
         }
         if(_loc3_ != null)
         {
            _loc3_.Hide();
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
            _loc6_.LoadSecondary(_loc5_.IDTexture,CONST_MODULES.MODULE_AccessoryLing);
         }
      }
      
      protected function OnInventoryOver(param1:Object, param2:Object, param3:Object) : void
      {
         var _loc4_:TInventory = null;
         var _loc5_:TInventory = null;
         var _loc6_:TOverlayer = null;
         var _loc7_:TOverlayer = null;
         _loc4_ = param2 as TInventory;
         _loc5_ = param3 as TInventory;
         _loc6_ = this.FOverlayerTreasure1;
         if(_loc6_ != null)
         {
            _loc6_.Context = _loc4_;
            if(_loc5_ == null)
            {
               _loc6_.Render(FUICore.MouseCoordinate);
            }
            else
            {
               _loc6_.Render(FUICore.MouseCoordinate);
               _loc6_.CoordinateOverlay.X -= _loc6_.BoundsSubstrate.Width + 20;
            }
            _loc6_.Show();
         }
         if(_loc5_ == null)
         {
            return;
         }
         _loc7_ = this.FOverlayerEquipmentMounted;
         if(_loc7_ != null)
         {
            _loc7_.Context = _loc5_;
            (_loc7_ as TOverlayerTreasure).EquipedName = STRING_TALISMAN.STRING_AlreadyEquip;
            _loc7_.Render(_loc6_.CoordinateOverlay);
            _loc7_.CoordinateOverlay.X = _loc6_.CoordinateOverlay.X - _loc7_.BoundsSubstrate.Width;
            _loc7_.Show();
         }
      }
      
      protected function OnInventoryOut(param1:Object, param2:TInventory, param3:Object) : void
      {
         var _loc4_:TInventory = null;
         var _loc5_:TInventory = null;
         var _loc6_:TOverlayer = null;
         var _loc7_:TOverlayer = null;
         _loc4_ = param2 as TInventory;
         _loc5_ = param3 as TInventory;
         _loc6_ = this.FOverlayerTreasure1;
         if(_loc6_ != null)
         {
            _loc6_.Hide();
         }
         if(_loc5_ == null)
         {
            return;
         }
         _loc7_ = this.FOverlayerEquipmentMounted;
         if(_loc7_ != null)
         {
            _loc7_.Hide();
         }
      }
      
      protected function IntensityAreaClick(param1:Object, param2:uint) : void
      {
         var _loc4_:TPacket = null;
         var _loc5_:ByteArray = null;
         var _loc3_:TInventory = param1 as TInventory;
         _loc4_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Accessory_Intensity_Req);
         _loc5_ = _loc4_.Data;
         _loc5_.writeUnsignedInt(_loc3_.Identifier0);
         _loc5_.writeUnsignedInt(_loc3_.Identifier1);
         _loc5_.writeByte(param2);
         SNetworkCore.Transceiver.PacketTransmit(_loc4_);
      }
      
      protected function LinZhuAreaClick(param1:Object, param2:uint) : void
      {
         var _loc4_:TPacket = null;
         var _loc5_:ByteArray = null;
         var _loc3_:TInventory = param1 as TInventory;
         _loc4_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Accessory_LingZhu_Req);
         _loc5_ = _loc4_.Data;
         _loc5_.writeUnsignedInt(_loc3_.Identifier0);
         _loc5_.writeUnsignedInt(_loc3_.Identifier1);
         _loc5_.writeByte(param2);
         SNetworkCore.Transceiver.PacketTransmit(_loc4_);
      }
      
      protected function ChangeAreaClick(param1:Object) : void
      {
         var _loc3_:TPacket = null;
         var _loc4_:ByteArray = null;
         var _loc2_:TInventory = param1 as TInventory;
         _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Accessory_Change_Req);
         _loc4_ = _loc3_.Data;
         _loc4_.writeUnsignedInt(_loc2_.Identifier0);
         _loc4_.writeUnsignedInt(_loc2_.Identifier1);
         SNetworkCore.Transceiver.PacketTransmit(_loc3_);
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Accessory_Intensity_Req,this.Accessory_Intensity_Back);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Accessory_Change_Req,this.Accessory_Change_Back);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Accessory_LingZhu_Req,this.Accessory_LingZhu_Back);
      }
      
      public function Accessory_Intensity_Back(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:ByteArray = null;
         _loc3_ = param1.Data;
         _loc2_ = int(_loc3_.readUnsignedInt());
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         this.FProcessorWindowAccessory.setEffectPlay();
         this.FProcessorWindowAccessory.UpDateIntensity(param1);
      }
      
      public function Accessory_Change_Back(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:ByteArray = null;
         _loc3_ = param1.Data;
         _loc2_ = int(_loc3_.readUnsignedInt());
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         EffectGenerateText(STRING_HEROS.STRING_MoutedChangeSucceed);
         this.FProcessorWindowAccessory.UpDateChange(param1,1);
      }
      
      public function Accessory_LingZhu_Back(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:ByteArray = null;
         _loc3_ = param1.Data;
         _loc2_ = int(_loc3_.readUnsignedInt());
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         EffectGenerateText(STRING_HEROS.STRING_MoutedLingZhusucceed);
         this.FProcessorWindowAccessory.UpDateLingZhu(param1);
      }
      
      public function VipLevelUpCheckBtnStatus() : void
      {
         this.FProcessorWindowAccessory.VipLevelUpCheckBtnStatus();
      }
   }
}

