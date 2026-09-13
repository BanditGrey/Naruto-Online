package Processors.Game.Lobby.Jade
{
   import Foundation.Common.TBounds;
   import Foundation.Common.THint;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityString;
   import Logics.Characters.THero;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.Inventories.TAppliance;
   import Logics.Inventories.TEquipment;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import Processors.Game.Lobby.TreasureMap.ConsumeFrame;
   import Processors.Game.Windows.Information.TUIWindowConfirmation;
   import Rendering.Overlayers.HelpTips.TOverlayerHelpTips;
   import Rendering.Overlayers.Hints.TOverlayerHint;
   import Rendering.Overlayers.Inventories.TOverJadeTunShiLittleTip;
   import Rendering.Overlayers.Inventories.TOverSuperJade;
   import Rendering.Overlayers.Inventories.TOverlayerAccessory;
   import Rendering.Overlayers.Inventories.TOverlayerAppliance;
   import Rendering.Overlayers.Inventories.TOverlayerEquipment;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_INVENTORY;
   import Resources.Constants.CONST_JADE;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.utils.ByteArray;
   
   public class TProcessorJade extends TProcessorLobbyWindows
   {
      
      protected static const SIZE_WIDTH_Jade:int = 778;
      
      protected static const SIZE_HEIGHT_Jade:int = 519;
      
      public static const CATEGORY_Equipment:uint = CONST_INVENTORY.CATEGORY_Equipment;
      
      public static const CATEGORY_Accessories:uint = CONST_INVENTORY.CATEGORY_Accessories;
      
      protected var FOverJadeTunShiLittleTip:TOverJadeTunShiLittleTip;
      
      protected var FProcessorWindowJade:TProcessorWindowJade;
      
      protected var FUIWindowConfirmationCopy:TUIWindowConfirmation;
      
      protected var FBoundsJade:TBounds;
      
      protected var FUpdateHeroPower:Function;
      
      protected var FOnUserTotalFightingPowerReq:Function;
      
      protected var FTunShiCost:uint;
      
      protected var FCurBuyType:uint;
      
      protected var FType0:Boolean;
      
      protected var FType1:Boolean;
      
      protected var Yu:TInventory;
      
      protected var Cailiao:TInventory;
      
      protected var HeroID:uint;
      
      protected var CSType:uint;
      
      public function TProcessorJade(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FProcessorWindowJade = new TProcessorWindowJade(this);
         this.FProcessorWindowJade.OnClose = this.ProcessorWindowJadeOnClose;
         this.FProcessorWindowJade.OnInventoryOver = UIComponentsHintOnOver;
         this.FProcessorWindowJade.OnInventoryOut = UIComponentsHintOnOut;
         this.FProcessorWindowJade.OnInventoryOverCopy = this.UIComponentsHintOnOverCopy;
         this.FProcessorWindowJade.OnInventoryOutCopy = this.UIComponentsHintOnOutCopy;
         this.FProcessorWindowJade.OnHintOver = this.OnHintOver;
         this.FProcessorWindowJade.OnHintOut = this.OnHintOut;
         this.FProcessorWindowJade.OnHelpTipsOver = UIHelpTipsHintOnOver;
         this.FProcessorWindowJade.OnHelpTipsOut = UIHelpTipsHintOnOut;
         this.FProcessorWindowJade.JinHuaBackFunction = this.JinHuaBackFunction;
         this.FProcessorWindowJade.TunShiBackFucntion = this.TunShiBackFucntion;
         this.FProcessorWindowJade.EffectGenerateTextByErrorCode = EffectGenerateTextByErrorCode;
         this.FBoundsJade = new TBounds();
         this.FBoundsJade.Width = SIZE_WIDTH_Jade;
         this.FBoundsJade.Height = SIZE_HEIGHT_Jade;
         ComponentBoundsCenter(this.FProcessorWindowJade,this.FBoundsJade);
         FOverlayerEquipment = new TOverlayerEquipment(this,CONST_MODULES.MODULE_Jade);
         FOverlayerEquipment.Visible = false;
         FOverlayerAppliance = new TOverlayerAppliance(this,CONST_MODULES.MODULE_Jade);
         FOverlayerAppliance.Visible = false;
         FOverlayerHelpTips = new TOverlayerHelpTips(this);
         FOverlayerHelpTips.Visible = false;
         FOverlayerAccessory = new TOverlayerAccessory(this,CONST_MODULES.MODULE_Jade);
         FOverlayerAccessory.Visible = false;
         FOverSuperJade = new TOverSuperJade(this);
         FOverSuperJade.visible = false;
         this.FOverJadeTunShiLittleTip = new TOverJadeTunShiLittleTip(this);
         this.FOverJadeTunShiLittleTip.visible = false;
         SetUIModuleID(CONST_MODULES.MODULE_Jade);
      }
      
      protected function OnHintOver(param1:Object, param2:THint) : void
      {
         FOverlayerHint.Context = param2;
         FOverlayerHint.Render(FUICore.MouseCoordinate);
         FOverlayerHint.Visible = true;
      }
      
      protected function OnHintOut(param1:Object) : void
      {
         FOverlayerHint.Visible = false;
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_JADE.RESOURCESID_JADE);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         FOverlayerHint = new TOverlayerHint(this);
         FOverlayerHint.visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerHint);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerEquipment);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerAppliance);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerHelpTips);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerAccessory);
         TUtilityUIOverlayer.ResourcesDispatch(FOverSuperJade);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverJadeTunShiLittleTip);
         this.FUIWindowConfirmationCopy = new TUIWindowConfirmation(Parent);
         this.FUIWindowConfirmationCopy.OnOK = this.OnConfirmationOkCopy;
         this.FUIWindowConfirmationCopy.OnCheckBoxSelected = this.OnCheckBoxSelected;
         this.FUIWindowConfirmationCopy.OnCancel = this.OnCancel;
         this.FUIWindowConfirmationCopy.x = (FUICore.StageWidth - this.FUIWindowConfirmationCopy.WindowWidth) / 2;
         this.FUIWindowConfirmationCopy.y = (FUICore.StageHeight - this.FUIWindowConfirmationCopy.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowConfirmationCopy);
         this.FUIWindowConfirmationCopy.SetCheckBox(true);
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         var _loc1_:TConfigValue = null;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,60100051) as TConfigValue;
         this.FTunShiCost = _loc1_.Value as int;
         super.ResourcesPerform_UILocations();
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_JadeCombine,this.PacketPerform_SC_JadeCombine);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_JadeEquipMount,this.PacketPerform_SC_EquitJadeMount);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_JadeEquipUnMount,this.PacketPerform_SC_EquitJadeUnmount);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_OneKeyJadeEquipUnMount,this.PacketPerform_SC_OneKeyEquitJadeUnmount);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_OneKeyJadeHeCheng,this.PacketPerform_SC_JadeCombineCopy);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_S2C_MASTER_STONE_Get_Info,this.PACKETID_S2C_MASTER_STONE_Get_Info);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_S2C_MASTER_STONE_Forge_Stone,this.PACKETID_S2C_MASTER_STONE_Forge_Stone);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_S2C_MASTER_STONE_Level_Up,this.PACKETID_S2C_MASTER_STONE_Level_Up);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_S2C_MASTER_STONE_Unlock,this.PACKETID_S2C_MASTER_STONE_Level_Up);
      }
      
      protected function PACKETID_C2S_MASTER_STONE_Get_Info() : void
      {
         var _loc1_:TPacket = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_C2S_MASTER_STONE_Get_Info);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PACKETID_S2C_MASTER_STONE_Get_Info(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:THero = null;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:TEquipment = null;
         var _loc13_:TAppliance = null;
         _loc2_ = param1.Data;
         _loc11_ = uint(_loc2_.readShort());
         _loc10_ = 0;
         while(_loc10_ < _loc11_)
         {
            _loc3_ = _loc2_.readUnsignedInt();
            _loc4_ = _loc2_.readUnsignedInt();
            _loc5_ = _loc2_.readUnsignedInt();
            _loc6_ = _loc2_.readUnsignedInt();
            _loc13_ = SLogicsCore.Character.Gems.GetInventoryByIdentifier(_loc3_,_loc4_) as TAppliance;
            _loc13_.CurJadeExp = _loc5_;
            _loc13_.CurUnlock = _loc6_;
            _loc10_++;
         }
         _loc11_ = uint(_loc2_.readShort());
         _loc10_ = 0;
         while(_loc10_ < _loc11_)
         {
            _loc7_ = _loc2_.readUnsignedInt();
            _loc3_ = _loc2_.readUnsignedInt();
            _loc4_ = _loc2_.readUnsignedInt();
            _loc8_ = uint(_loc2_.readByte());
            _loc5_ = _loc2_.readUnsignedInt();
            _loc6_ = _loc2_.readUnsignedInt();
            if(_loc7_)
            {
               _loc9_ = SLogicsCore.Character.Heros.GetHeroByIdentifier(_loc7_);
               _loc12_ = _loc9_.EquipmentsMounted.GetInventoryByIdentifier(_loc3_,_loc4_) as TEquipment;
            }
            else
            {
               _loc12_ = SLogicsCore.Character.Equipments.GetInventoryByIdentifier(_loc3_,_loc4_) as TEquipment;
            }
            _loc13_ = _loc12_.GiftedStoneItems.GetGiftedStoneByIndex(_loc8_);
            _loc13_.CurJadeExp = _loc5_;
            _loc13_.CurUnlock = _loc6_;
            _loc10_++;
         }
         this.FProcessorWindowJade.Update();
      }
      
      protected function JinHuaBackFunction(param1:TInventory, param2:TInventory, param3:uint) : void
      {
         this.Yu = param1;
         this.Cailiao = param2;
         this.CSType = param3;
         this.FCurBuyType = 1;
         this.ShowPanel();
      }
      
      protected function S_C() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:TEquipment = null;
         var _loc3_:TAppliance = null;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_C2S_MASTER_STONE_Forge_Stone);
         _loc2_ = this.Yu.EquipmentDeJade as TEquipment;
         if(_loc2_)
         {
            _loc1_.Data.writeUnsignedInt(0);
            _loc1_.Data.writeUnsignedInt(0);
         }
         else
         {
            _loc1_.Data.writeUnsignedInt(this.Yu.Identifier0);
            _loc1_.Data.writeUnsignedInt(this.Yu.Identifier1);
         }
         _loc1_.Data.writeUnsignedInt(this.CSType);
         if(_loc2_)
         {
            _loc1_.Data.writeUnsignedInt(_loc2_.Identifier0);
            _loc1_.Data.writeUnsignedInt(_loc2_.Identifier1);
         }
         else
         {
            _loc1_.Data.writeUnsignedInt(0);
            _loc1_.Data.writeUnsignedInt(0);
         }
         if(_loc2_)
         {
            _loc5_ = 0;
            while(_loc5_ < _loc2_.GiftedStoneItems.Count)
            {
               _loc3_ = _loc2_.GiftedStoneItems.GetGiftedStoneByIndex(_loc5_);
               if(_loc3_.IDTemplate == this.Yu.IDTemplate)
               {
                  _loc4_ = _loc5_;
                  break;
               }
               _loc5_++;
            }
            _loc1_.Data.writeByte(_loc4_);
         }
         else
         {
            _loc1_.Data.writeByte(0);
         }
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PACKETID_S2C_MASTER_STONE_Forge_Stone(param1:TPacket) : void
      {
         var _loc2_:uint = 0;
         _loc2_ = param1.Data.readUnsignedInt();
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         this.FProcessorWindowJade.JicHuaS_C();
         this.PACKETID_C2S_MASTER_STONE_Get_Info();
      }
      
      protected function OnConfirmationOkCopy(param1:Object) : void
      {
         switch(this.FCurBuyType)
         {
            case 0:
               this.SS_CC();
               break;
            case 1:
               this.S_C();
         }
      }
      
      protected function OnCheckBoxSelected(param1:Object, param2:Boolean) : void
      {
         switch(this.FCurBuyType)
         {
            case 0:
               this.FType0 = param2;
               break;
            case 1:
               this.FType1 = param2;
         }
      }
      
      protected function OnCancel(param1:Object) : void
      {
         switch(this.FCurBuyType)
         {
            case 0:
               this.FType0 = false;
               break;
            case 1:
               this.FType1 = false;
         }
      }
      
      protected function ShowPanel() : void
      {
         var _loc1_:String = null;
         switch(this.FCurBuyType)
         {
            case 0:
               if(this.CSType == 2)
               {
                  this.Unlock_CS();
               }
               else if(this.CSType == 1)
               {
                  if(this.FType0)
                  {
                     this.SS_CC();
                  }
                  else
                  {
                     this.FUIWindowConfirmationCopy.SetCheckBox(true);
                     this.FUIWindowConfirmationCopy.SetSelectedOrNot(false);
                     _loc1_ = TUtilityString.Format(new ConsumeFrame(70107008).DescribeString,SLogicsCore.LostShenQiLogicData.GetTunShiCostById(this.Cailiao.IDTemplate));
                     this.FUIWindowConfirmationCopy.Text = _loc1_;
                     this.FUIWindowConfirmationCopy.Visible = true;
                  }
               }
               else
               {
                  this.SS_CC();
               }
               break;
            case 1:
               this.FUIWindowConfirmationCopy.SetCheckBox(false);
               this.FUIWindowConfirmationCopy.SetSelectedOrNot(false);
               _loc1_ = TUtilityString.Format(new ConsumeFrame(70107009).DescribeString,SLogicsCore.LostShenQiLogicData.GetJinJieCostById(this.Yu.IDTemplate),this.Cailiao.Name);
               this.FUIWindowConfirmationCopy.Text = _loc1_;
               this.FUIWindowConfirmationCopy.Visible = true;
               break;
            case 2:
         }
      }
      
      protected function TunShiBackFucntion(param1:TInventory, param2:TInventory, param3:uint, param4:uint) : void
      {
         this.Yu = param1;
         this.Cailiao = param2;
         this.HeroID = param3;
         this.CSType = param4;
         this.FCurBuyType = 0;
         this.ShowPanel();
      }
      
      protected function SS_CC() : void
      {
         var _loc2_:TAppliance = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc1_:TPacket = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_C2S_MASTER_STONE_Level_Up);
         if(this.HeroID == 0 && this.Yu.EquipmentDeJade == null)
         {
            _loc1_.Data.writeUnsignedInt(this.Yu.Identifier0);
            _loc1_.Data.writeUnsignedInt(this.Yu.Identifier1);
         }
         else
         {
            _loc1_.Data.writeUnsignedInt(0);
            _loc1_.Data.writeUnsignedInt(0);
         }
         _loc1_.Data.writeUnsignedInt(this.HeroID);
         if(this.Yu.EquipmentDeJade)
         {
            _loc1_.Data.writeUnsignedInt(this.Yu.EquipmentDeJade.Identifier0);
            _loc1_.Data.writeUnsignedInt(this.Yu.EquipmentDeJade.Identifier1);
            _loc4_ = 0;
            while(_loc4_ < this.Yu.EquipmentDeJade.GiftedStoneItems.Count)
            {
               _loc2_ = this.Yu.EquipmentDeJade.GiftedStoneItems.GetGiftedStoneByIndex(_loc4_);
               if(_loc2_.IDTemplate == this.Yu.IDTemplate)
               {
                  _loc3_ = _loc4_;
                  break;
               }
               _loc4_++;
            }
            _loc1_.Data.writeByte(_loc3_);
         }
         else
         {
            _loc1_.Data.writeUnsignedInt(0);
            _loc1_.Data.writeUnsignedInt(0);
            _loc1_.Data.writeByte(0);
         }
         _loc1_.Data.writeUnsignedInt(this.Cailiao.Identifier0);
         _loc1_.Data.writeUnsignedInt(this.Cailiao.Identifier1);
         _loc1_.Data.writeByte(this.CSType);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function Unlock_CS() : void
      {
         var _loc2_:TAppliance = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc1_:TPacket = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_C2S_MASTER_STONE_Unlock);
         if(this.HeroID == 0 && this.Yu.EquipmentDeJade == null)
         {
            _loc1_.Data.writeUnsignedInt(this.Yu.Identifier0);
            _loc1_.Data.writeUnsignedInt(this.Yu.Identifier1);
         }
         else
         {
            _loc1_.Data.writeUnsignedInt(0);
            _loc1_.Data.writeUnsignedInt(0);
         }
         _loc1_.Data.writeUnsignedInt(this.HeroID);
         if(this.Yu.EquipmentDeJade)
         {
            _loc1_.Data.writeUnsignedInt(this.Yu.EquipmentDeJade.Identifier0);
            _loc1_.Data.writeUnsignedInt(this.Yu.EquipmentDeJade.Identifier1);
            _loc4_ = 0;
            while(_loc4_ < this.Yu.EquipmentDeJade.GiftedStoneItems.Count)
            {
               _loc2_ = this.Yu.EquipmentDeJade.GiftedStoneItems.GetGiftedStoneByIndex(_loc4_);
               if(_loc2_.IDTemplate == this.Yu.IDTemplate)
               {
                  _loc3_ = _loc4_;
                  break;
               }
               _loc4_++;
            }
            _loc1_.Data.writeByte(_loc3_);
         }
         else
         {
            _loc1_.Data.writeUnsignedInt(0);
            _loc1_.Data.writeUnsignedInt(0);
            _loc1_.Data.writeByte(0);
         }
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PACKETID_S2C_MASTER_STONE_Level_Up(param1:TPacket) : void
      {
         var _loc2_:uint = param1.Data.readUnsignedInt();
         if(_loc2_ == 1360)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            this.FProcessorWindowJade.ShenJiS_C(param1.Data);
         }
         else if(_loc2_ == 0)
         {
            if(this.CSType != 2)
            {
               this.FProcessorWindowJade.ShenJiS_C(param1.Data);
            }
         }
         else
         {
            EffectGenerateTextByErrorCode(_loc2_);
         }
         this.PACKETID_C2S_MASTER_STONE_Get_Info();
      }
      
      protected function PacketPerform_SC_JadeCombineCopy(param1:TPacket) : void
      {
         var _loc2_:uint = 0;
         _loc2_ = param1.Data.readUnsignedByte();
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         this.FProcessorWindowJade.ResultCode = 0;
         this.FProcessorWindowJade.Update();
      }
      
      protected function PacketPerform_SC_JadeCombine(param1:TPacket) : void
      {
         var _loc2_:uint = 0;
         _loc2_ = param1.Data.readUnsignedByte();
         this.FProcessorWindowJade.ResultCode = _loc2_;
         this.FProcessorWindowJade.Update();
      }
      
      protected function PacketPerform_SC_EquitJadeMount(param1:TPacket) : void
      {
         var _loc2_:uint = 0;
         _loc2_ = param1.Data.readUnsignedByte();
         this.FProcessorWindowJade.ResultCode = _loc2_;
         this.FProcessorWindowJade.Update();
         if(this.FOnUserTotalFightingPowerReq != null)
         {
            this.FOnUserTotalFightingPowerReq(this);
         }
         this.PACKETID_C2S_MASTER_STONE_Get_Info();
      }
      
      protected function PacketPerform_SC_EquitJadeUnmount(param1:TPacket) : void
      {
         var _loc2_:uint = 0;
         _loc2_ = param1.Data.readUnsignedByte();
         this.FProcessorWindowJade.ResultCode = _loc2_;
         this.FProcessorWindowJade.Update();
         if(this.FOnUserTotalFightingPowerReq != null)
         {
            this.FOnUserTotalFightingPowerReq(this);
         }
         this.PACKETID_C2S_MASTER_STONE_Get_Info();
      }
      
      protected function PacketPerform_SC_OneKeyEquitJadeUnmount(param1:TPacket) : void
      {
      }
      
      protected function PacketPerform_CS_JadeCombine(param1:uint, param2:uint, param3:uint, param4:uint, param5:uint) : void
      {
         var _loc6_:TPacket = null;
         if(param1 == 100)
         {
            _loc6_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_OneKeyJadeHeCheng);
            _loc6_.Data.writeByte(param2);
            _loc6_.Data.writeByte(param3);
         }
         else
         {
            _loc6_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_JadeCombine);
            _loc6_.Data.writeByte(param1);
            _loc6_.Data.writeUnsignedInt(param2);
            _loc6_.Data.writeUnsignedInt(param3);
            _loc6_.Data.writeShort(param4);
            _loc6_.Data.writeByte(param5);
         }
         SNetworkCore.Transceiver.PacketTransmit(_loc6_);
      }
      
      protected function PacketPerform_C2S_EquipJadeMount(param1:uint, param2:uint, param3:uint, param4:uint, param5:uint) : void
      {
         var _loc6_:TPacket = null;
         _loc6_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_JadeEquipMount);
         _loc6_.Data.writeUnsignedInt(param1);
         _loc6_.Data.writeUnsignedInt(param2);
         _loc6_.Data.writeUnsignedInt(param3);
         _loc6_.Data.writeUnsignedInt(param4);
         _loc6_.Data.writeUnsignedInt(param5);
         SNetworkCore.Transceiver.PacketTransmit(_loc6_);
      }
      
      protected function PacketPerform_C2S_OneKeyEquipJadeUnmount(param1:uint, param2:uint, param3:uint) : void
      {
         var _loc4_:TPacket = null;
         _loc4_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_OneKeyJadeEquipUnMount);
         _loc4_.Data.writeUnsignedInt(param1);
         _loc4_.Data.writeUnsignedInt(param2);
         _loc4_.Data.writeUnsignedInt(param3);
         SNetworkCore.Transceiver.PacketTransmit(_loc4_);
      }
      
      protected function PacketPerform_C2S_EquipJadeUnmount(param1:uint, param2:uint, param3:uint, param4:int) : void
      {
         var _loc5_:TPacket = null;
         var _loc6_:THero = null;
         var _loc7_:TEquipment = null;
         var _loc8_:TAppliance = null;
         _loc5_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_JadeEquipUnMount);
         _loc5_.Data.writeUnsignedInt(param1);
         _loc5_.Data.writeUnsignedInt(param2);
         _loc5_.Data.writeUnsignedInt(param3);
         _loc5_.Data.writeByte(param4);
         SNetworkCore.Transceiver.PacketTransmit(_loc5_);
         if(param1 != 0)
         {
            _loc6_ = SLogicsCore.Character.Heros.GetHeroByIdentifier(param1);
            _loc7_ = _loc6_.EquipmentsMounted.GetInventoryByIdentifier(param2,param3) as TEquipment;
         }
         else
         {
            _loc7_ = SLogicsCore.Character.Equipments.GetInventoryByIdentifier(param2,param3) as TEquipment;
         }
         _loc8_ = _loc7_.GiftedStoneItems.GetGiftedStoneByIndex(param4) as TAppliance;
         if(_loc8_ != null)
         {
            UIComponentsHintOnOut(this,_loc8_);
         }
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
      }
      
      protected function ProcessorWindowJadeOnClose(param1:Object) : void
      {
         ProcessorClose();
      }
      
      protected function UIComponentsHintOnOverCopy(param1:Object) : void
      {
         var _loc2_:TInventory = null;
         _loc2_ = param1 as TInventory;
         if(this.FOverJadeTunShiLittleTip != null)
         {
            this.FOverJadeTunShiLittleTip.Context = _loc2_;
            this.FOverJadeTunShiLittleTip.Render(FUICore.MouseCoordinate);
            this.FOverJadeTunShiLittleTip.Show();
         }
      }
      
      protected function UIComponentsHintOnOutCopy(param1:Object) : void
      {
         if(this.FOverJadeTunShiLittleTip != null)
         {
            this.FOverJadeTunShiLittleTip.Hide();
         }
      }
      
      override public function set OnEffectText(param1:Function) : void
      {
         FOnEffectText = param1;
         this.FProcessorWindowJade.OnEffectText = param1;
      }
      
      public function set UpdateHeroPower(param1:Function) : void
      {
         this.FProcessorWindowJade.UpdateHeroPower = param1;
      }
      
      public function get OnUserTotalFightingPowerReq() : Function
      {
         return this.FOnUserTotalFightingPowerReq;
      }
      
      public function set OnUserTotalFightingPowerReq(param1:Function) : void
      {
         this.FOnUserTotalFightingPowerReq = param1;
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount();
         if(!FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowJade.Load();
            return;
         }
         this.FProcessorWindowJade.UpdateTable();
         this.FProcessorWindowJade.visible = true;
         this.FProcessorWindowJade.Update();
         this.FProcessorWindowJade.OnCombine = this.PacketPerform_CS_JadeCombine;
         this.FProcessorWindowJade.OnMountJade = this.PacketPerform_C2S_EquipJadeMount;
         this.FProcessorWindowJade.OnUnmountJade = this.PacketPerform_C2S_EquipJadeUnmount;
         this.FProcessorWindowJade.OneKeyOnUnmountJade = this.PacketPerform_C2S_OneKeyEquipJadeUnmount;
         this.PACKETID_C2S_MASTER_STONE_Get_Info();
         this.FProcessorWindowJade.ShackPendant();
      }
   }
}

