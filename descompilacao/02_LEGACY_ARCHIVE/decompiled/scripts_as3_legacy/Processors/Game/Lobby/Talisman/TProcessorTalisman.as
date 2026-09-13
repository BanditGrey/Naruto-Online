package Processors.Game.Lobby.Talisman
{
   import Foundation.Common.TBounds;
   import Foundation.Common.THint;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Characters.TUnstreamizerCharacter;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import Rendering.Overlayers.HelpTips.TOverlayerHelpTips;
   import Rendering.Overlayers.Hints.TOverlayerHint;
   import Rendering.Overlayers.Inventories.TOverlayerAppliance;
   import Rendering.Overlayers.Inventories.TOverlayerSuperTreasure;
   import Rendering.Overlayers.Inventories.TOverlayerTreasure;
   import Rendering.Overlayers.TOverlayer;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_INVENTORY;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Constants.CONST_TALISMAN;
   import Resources.Strings.STRING_TALISMAN;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.utils.ByteArray;
   
   public class TProcessorTalisman extends TProcessorLobbyWindows
   {
      
      protected static const SIZE_WindowTalisman_Width:uint = 800;
      
      protected static const SIZE_WindowTalisman_Height:uint = 536;
      
      protected var FUnstreamizerCharacter:TUnstreamizerCharacter;
      
      protected var FProcessorWindowTalisman:TProcessorWindowTalisman;
      
      protected var FBoundsBackpack:TBounds;
      
      protected var FOverlayerEquipmentMounted:TOverlayerTreasure;
      
      protected var FOverlayerSuperTreasure:TOverlayerSuperTreasure;
      
      protected var FOverlayerSuperTreasureCopy:TOverlayerSuperTreasure;
      
      protected var FSystemLanguage:TSystemLanguage;
      
      protected var FSystemLanguageBin:TBins;
      
      protected var FStringID:uint;
      
      protected var FTabIndex:int;
      
      protected var FHeroTabIndex:int;
      
      protected var FOnMountTalisman:Function;
      
      protected var FOnDismountTalisman:Function;
      
      protected var FOnUpdateHerosBaseAttributeReq:Function;
      
      protected var FOnUserTotalFightingPowerReq:Function;
      
      protected var FOnGoToKillHeros:Function;
      
      protected var FGoToLostPanelFunction:Function;
      
      public function TProcessorTalisman(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FProcessorWindowTalisman = new TProcessorWindowTalisman(this);
         this.FProcessorWindowTalisman.OnEffectText = ProcessorsOnEffectText;
         this.FProcessorWindowTalisman.OnClose = this.ProcessorWindowTalismanOnClose;
         this.FProcessorWindowTalisman.EquipOnOffOnClick = this.EquipOnOff;
         this.FProcessorWindowTalisman.UpgradeOnClick = this.Upgrade;
         this.FProcessorWindowTalisman.TransitionOnClick = this.Transition;
         this.FProcessorWindowTalisman.LevelUpOnClick = this.Levelup;
         this.FProcessorWindowTalisman.UIComponentsHintOnOver = this.UIComponentsHintOnOver1;
         this.FProcessorWindowTalisman.UIComponentsHintOnOut = this.UIComponentsHintOnOut1;
         this.FProcessorWindowTalisman.OnUpdateHerosBaseAttributeReq = this.ProcessorOnUpdateHerosBaseAttributeReq;
         this.FProcessorWindowTalisman.OnHelpTipsOver = UIHelpTipsHintOnOver;
         this.FProcessorWindowTalisman.OnHelpTipsOut = UIHelpTipsHintOnOut;
         this.FProcessorWindowTalisman.OnTipsOver = this.UITipsHintOnOver;
         this.FProcessorWindowTalisman.OnTipsOut = this.UITipsHintOnOut;
         this.FProcessorWindowTalisman.GoToLostPanelFunction = this.GoToLostPanelClick;
         if(this.FOnGoToKillHeros != null)
         {
            this.FProcessorWindowTalisman.OnGoToKillHeros = this.FOnGoToKillHeros;
         }
         this.FBoundsBackpack = new TBounds();
         this.FBoundsBackpack.X = this.FProcessorWindowTalisman.x;
         this.FBoundsBackpack.Y = this.FProcessorWindowTalisman.y;
         this.FBoundsBackpack.Width = SIZE_WindowTalisman_Width;
         this.FBoundsBackpack.Height = SIZE_WindowTalisman_Height;
         ComponentBoundsCenter(this.FProcessorWindowTalisman,this.FBoundsBackpack);
         FOverlayerTreasure = new TOverlayerTreasure(this,CONST_MODULES.MODULE_Talisman);
         FOverlayerTreasure.Visible = false;
         this.FOverlayerSuperTreasure = new TOverlayerSuperTreasure(this,CONST_MODULES.MODULE_Talisman);
         this.FOverlayerSuperTreasure.Visible = false;
         this.FOverlayerSuperTreasureCopy = new TOverlayerSuperTreasure(this,CONST_MODULES.MODULE_Talisman);
         this.FOverlayerSuperTreasureCopy.Visible = false;
         FOverlayerAppliance = new TOverlayerAppliance(this,CONST_MODULES.MODULE_Talisman);
         FOverlayerAppliance.Visible = false;
         this.FOverlayerEquipmentMounted = new TOverlayerTreasure(this,CONST_MODULES.MODULE_Talisman);
         this.FOverlayerEquipmentMounted.Visible = false;
         FOverlayerHelpTips = new TOverlayerHelpTips(this);
         FOverlayerHelpTips.Visible = false;
         FOverlayerHint = new TOverlayerHint(this);
         FOverlayerHint.Visible = false;
         this.FTabIndex = -1;
         this.FHeroTabIndex = -1;
         this.FUnstreamizerCharacter = new TUnstreamizerCharacter();
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_TALISMAN.RESOURCESID_Swf_Talisman);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerTreasure);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerSuperTreasure);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerSuperTreasureCopy);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerAppliance);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerEquipmentMounted);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerHelpTips);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerHint);
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UIFinalize() : void
      {
         this.FSystemLanguageBin = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_SystemLanguage);
         super.ResourcesPerform_UIFinalize();
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TalismanEquipResponse,this.PacketPerform_SC_TalismanEquipResponse);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TalismanUpgradeResponse,this.PacketPerform_SC_TalismanUpgradeResponse);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TalismanTransitionResponse,this.PacketPerform_SC_TalismanTransitionResponse);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TalismanLevelUpResponse,this.PacketPerform_SC_TalismanLevelUpResponse);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TalismanResolveResponse,this.PacketPerform_SC_TalismanResolveResponse);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TalismanCombinResponse,this.PacketPerform_SC_TalismanCombinResponse);
      }
      
      protected function PacketPerform_SC_TalismanEquipResponse(param1:TPacket) : void
      {
         var _loc2_:ByteArray = param1.Data;
         var _loc3_:uint = uint(_loc2_.readByte());
         var _loc4_:uint = uint(_loc2_.readByte());
         if(_loc3_ == 0)
         {
         }
      }
      
      protected function PacketPerform_SC_TalismanUpgradeResponse(param1:TPacket) : void
      {
         var _loc2_:ByteArray = param1.Data;
         var _loc3_:uint = uint(_loc2_.readByte());
         if(_loc3_ == 0)
         {
            this.FStringID = CONST_SYSTEMLANGUAGE.TALISMAN_STRING_01;
            this.FSystemLanguage = this.FSystemLanguageBin.GetDatebaseByIdentifier(this.FStringID) as TSystemLanguage;
            EffectGenerateText(this.FSystemLanguage.Desc);
         }
         else
         {
            EffectGenerateTextByErrorCode(_loc3_);
         }
         this.FProcessorWindowTalisman.SetBtnLock();
         this.ProcessorOnUpdateHerosBaseAttributeReq(this);
         if(this.FOnUserTotalFightingPowerReq != null)
         {
            this.FOnUserTotalFightingPowerReq(this);
         }
      }
      
      protected function PacketPerform_SC_TalismanTransitionResponse(param1:TPacket) : void
      {
         var _loc2_:ByteArray = param1.Data;
         var _loc3_:uint = uint(_loc2_.readByte());
         if(_loc3_ == 0)
         {
            this.FStringID = CONST_SYSTEMLANGUAGE.TALISMAN_STRING_02;
            this.FSystemLanguage = this.FSystemLanguageBin.GetDatebaseByIdentifier(this.FStringID) as TSystemLanguage;
            EffectGenerateText(this.FSystemLanguage.Desc);
            this.FProcessorWindowTalisman.Update();
         }
         else
         {
            EffectGenerateTextByErrorCode(_loc3_);
         }
         this.FProcessorWindowTalisman.SetBtnLock();
      }
      
      protected function PacketPerform_SC_TalismanLevelUpResponse(param1:TPacket) : void
      {
         var _loc2_:ByteArray = param1.Data;
         var _loc3_:uint = uint(_loc2_.readByte());
         if(_loc3_ == 0)
         {
            this.FStringID = CONST_SYSTEMLANGUAGE.TALISMAN_STRING_03;
            this.FSystemLanguage = this.FSystemLanguageBin.GetDatebaseByIdentifier(this.FStringID) as TSystemLanguage;
            EffectGenerateText(this.FSystemLanguage.Desc);
            this.FProcessorWindowTalisman.Update(3);
         }
         else
         {
            EffectGenerateTextByErrorCode(_loc3_);
         }
         this.FProcessorWindowTalisman.SetBtnLock();
      }
      
      protected function PacketPerform_SC_TalismanResolveResponse(param1:TPacket) : void
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
         _loc4_ = _loc2_.readUnsignedInt();
         EffectGenerateText(STRING_TALISMAN.STRING_RESOLVEOK);
         this.FProcessorWindowTalisman.Update(4);
      }
      
      protected function PacketPerform_SC_TalismanCombinResponse(param1:TPacket) : void
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
         _loc4_ = _loc2_.readUnsignedInt();
         EffectGenerateText(STRING_TALISMAN.STRING_COMBINOK);
         this.FProcessorWindowTalisman.Update(4);
      }
      
      protected function PerformPacket_CS_TalismanEquipRequest(param1:uint, param2:uint, param3:uint, param4:uint) : void
      {
         var _loc5_:TPacket = null;
         _loc5_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TalismanEquipRequest);
         _loc5_.Data.writeUnsignedInt(param1);
         _loc5_.Data.writeUnsignedInt(param2);
         _loc5_.Data.writeByte(param3);
         _loc5_.Data.writeUnsignedInt(param4);
         SNetworkCore.Transceiver.PacketTransmit(_loc5_);
      }
      
      protected function PerformPacket_CS_TalismanUpgradeRequest(param1:uint, param2:uint, param3:uint) : void
      {
         var _loc4_:TPacket = null;
         _loc4_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TalismanUpgradeRequest);
         _loc4_.Data.writeUnsignedInt(param1);
         _loc4_.Data.writeUnsignedInt(param2);
         _loc4_.Data.writeUnsignedInt(param3);
         SNetworkCore.Transceiver.PacketTransmit(_loc4_);
      }
      
      protected function PerformPacket_CS_TalismanTransitionRequest(param1:uint, param2:uint, param3:uint) : void
      {
         var _loc4_:TPacket = null;
         _loc4_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TalismanTransitionRequest);
         _loc4_.Data.writeUnsignedInt(param1);
         _loc4_.Data.writeUnsignedInt(param2);
         _loc4_.Data.writeUnsignedInt(param3);
         SNetworkCore.Transceiver.PacketTransmit(_loc4_);
      }
      
      protected function PerformPacket_CS_TalismanLevelUpRequest(param1:uint, param2:uint) : void
      {
         var _loc3_:TPacket = null;
         _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TalismanLevelUpRequest);
         _loc3_.Data.writeUnsignedInt(param1);
         _loc3_.Data.writeUnsignedInt(param2);
         SNetworkCore.Transceiver.PacketTransmit(_loc3_);
      }
      
      protected function ProcessorStreamData(param1:ByteArray) : void
      {
         var _loc2_:Vector.<uint> = null;
         if(param1 != null)
         {
            _loc2_ = this.ReadParamByByteArray(param1.readUnsignedInt());
            if(_loc2_ != null)
            {
               this.FTabIndex = _loc2_[0];
               this.FHeroTabIndex = _loc2_[1];
            }
         }
      }
      
      protected function ReadParamByByteArray(param1:uint) : Vector.<uint>
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         _loc2_ = uint(param1 >> 8);
         _loc3_ = uint(param1 & 0xFF);
         return Vector.<uint>([_loc2_,_loc3_]);
      }
      
      protected function EquipOnOff(param1:Object, param2:Object, param3:uint, param4:uint) : void
      {
         var _loc5_:TInventory = null;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:int = 0;
         _loc5_ = param2 as TInventory;
         switch(param3)
         {
            case 0:
               _loc6_ = _loc5_.Identifier0;
               _loc7_ = _loc5_.Identifier1;
               if(this.FOnMountTalisman != null)
               {
                  this.FOnMountTalisman(this,param4,_loc6_,_loc7_);
               }
               break;
            case 1:
               _loc8_ = int(_loc5_.CategorySecond);
               if(this.FOnDismountTalisman != null)
               {
                  this.FOnDismountTalisman(this,param4,1,_loc8_);
               }
         }
      }
      
      protected function Upgrade(param1:Object, param2:Object, param3:uint) : void
      {
         var _loc4_:TInventory = param2 as TInventory;
         var _loc5_:uint = _loc4_.Identifier0;
         var _loc6_:uint = _loc4_.Identifier1;
         this.PerformPacket_CS_TalismanUpgradeRequest(_loc5_,_loc6_,param3);
      }
      
      protected function Transition(param1:Object, param2:Object, param3:Object) : void
      {
         var _loc4_:TInventory = param2 as TInventory;
         var _loc5_:TInventory = param3 as TInventory;
         var _loc6_:uint = _loc4_.Identifier0;
         var _loc7_:uint = _loc4_.Identifier1;
         var _loc8_:uint = uint(param3.IDTemplate);
         this.PerformPacket_CS_TalismanTransitionRequest(_loc6_,_loc7_,_loc8_);
      }
      
      protected function Levelup(param1:Object, param2:Object) : void
      {
         var _loc3_:TInventory = param2 as TInventory;
         var _loc4_:uint = _loc3_.Identifier0;
         var _loc5_:uint = _loc3_.Identifier1;
         this.PerformPacket_CS_TalismanLevelUpRequest(_loc4_,_loc5_);
      }
      
      protected function ProcessorWindowTalismanOnClose(param1:Object) : void
      {
         ProcessorClose();
      }
      
      protected function ProcessorOnUpdateHerosBaseAttributeReq(param1:Object) : void
      {
         if(this.FOnUpdateHerosBaseAttributeReq != null)
         {
            this.FOnUpdateHerosBaseAttributeReq(this);
         }
      }
      
      protected function UIComponentsHintOnOver1(param1:Object, param2:Object, param3:Object) : void
      {
         var _loc4_:TInventory = null;
         var _loc5_:TInventory = null;
         var _loc6_:TOverlayer = null;
         var _loc7_:TOverlayer = null;
         _loc4_ = param2 as TInventory;
         _loc5_ = param3 as TInventory;
         var _loc8_:Boolean = Boolean(SLogicsCore.LostShenQiLogicData.GetIsSuperFaQiById(_loc4_.IDTemplate));
         if(_loc8_)
         {
            _loc6_ = this.FOverlayerSuperTreasure;
         }
         else
         {
            switch(_loc4_.Category)
            {
               case CONST_INVENTORY.CATEGORY_Treasure:
                  _loc6_ = FOverlayerTreasure;
                  break;
               default:
                  _loc6_ = FOverlayerAppliance;
            }
         }
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
         _loc8_ = Boolean(SLogicsCore.LostShenQiLogicData.GetIsSuperFaQiById(_loc5_.IDTemplate));
         if(_loc8_)
         {
            _loc7_ = this.FOverlayerSuperTreasureCopy;
         }
         else
         {
            _loc7_ = this.FOverlayerEquipmentMounted;
         }
         if(_loc7_ != null)
         {
            _loc7_.Context = _loc5_;
            if(_loc8_)
            {
               (_loc7_ as TOverlayerSuperTreasure).EquipedName = STRING_TALISMAN.STRING_AlreadyEquip;
            }
            else
            {
               (_loc7_ as TOverlayerTreasure).EquipedName = STRING_TALISMAN.STRING_AlreadyEquip;
            }
            _loc7_.Render(_loc6_.CoordinateOverlay);
            _loc7_.CoordinateOverlay.X = _loc6_.CoordinateOverlay.X - _loc7_.BoundsSubstrate.Width;
            _loc7_.Show();
         }
      }
      
      protected function UIComponentsHintOnOut1(param1:Object, param2:TInventory, param3:Object) : void
      {
         var _loc4_:TInventory = null;
         var _loc5_:TInventory = null;
         var _loc6_:TOverlayer = null;
         var _loc7_:TOverlayer = null;
         _loc4_ = param2 as TInventory;
         _loc5_ = param3 as TInventory;
         var _loc8_:Boolean = Boolean(SLogicsCore.LostShenQiLogicData.GetIsSuperFaQiById(_loc4_.IDTemplate));
         if(_loc8_)
         {
            _loc6_ = this.FOverlayerSuperTreasure;
         }
         else
         {
            switch(_loc4_.Category)
            {
               case CONST_INVENTORY.CATEGORY_Treasure:
                  _loc6_ = FOverlayerTreasure;
                  break;
               default:
                  _loc6_ = FOverlayerAppliance;
            }
         }
         if(_loc6_ != null)
         {
            _loc6_.Hide();
         }
         if(_loc5_ == null)
         {
            return;
         }
         _loc8_ = Boolean(SLogicsCore.LostShenQiLogicData.GetIsSuperFaQiById(_loc5_.IDTemplate));
         if(_loc8_)
         {
            _loc7_ = this.FOverlayerSuperTreasureCopy;
         }
         else
         {
            _loc7_ = this.FOverlayerEquipmentMounted;
         }
         if(_loc7_ != null)
         {
            _loc7_.Hide();
         }
      }
      
      protected function UITipsHintOnOver(param1:Object, param2:THint) : void
      {
         FOverlayerHint.Context = param2;
         FOverlayerHint.Render(FUICore.MouseCoordinate);
         FOverlayerHint.Show();
      }
      
      protected function UITipsHintOnOut(param1:Object) : void
      {
         FOverlayerHint.Hide();
      }
      
      public function get OnMountTalisman() : Function
      {
         return this.FOnMountTalisman;
      }
      
      public function set OnMountTalisman(param1:Function) : void
      {
         this.FOnMountTalisman = param1;
      }
      
      public function get OnDismountTalisman() : Function
      {
         return this.FOnDismountTalisman;
      }
      
      public function set OnDismountTalisman(param1:Function) : void
      {
         this.FOnDismountTalisman = param1;
      }
      
      public function get OnUpdateHerosBaseAttributeReq() : Function
      {
         return this.FOnUpdateHerosBaseAttributeReq;
      }
      
      public function set OnUpdateHerosBaseAttributeReq(param1:Function) : void
      {
         this.FOnUpdateHerosBaseAttributeReq = param1;
      }
      
      public function get TabIndex() : int
      {
         return this.FTabIndex;
      }
      
      public function set TabIndex(param1:int) : void
      {
         this.FTabIndex = param1;
      }
      
      public function get ProcessorWindowTalisman() : TProcessorWindowTalisman
      {
         return this.FProcessorWindowTalisman;
      }
      
      public function get OnUserTotalFightingPowerReq() : Function
      {
         return this.FOnUserTotalFightingPowerReq;
      }
      
      public function set OnUserTotalFightingPowerReq(param1:Function) : void
      {
         this.FOnUserTotalFightingPowerReq = param1;
      }
      
      public function get OnGoToKillHeros() : Function
      {
         return this.FOnGoToKillHeros;
      }
      
      public function set OnGoToKillHeros(param1:Function) : void
      {
         this.FOnGoToKillHeros = param1;
         if(this.FProcessorWindowTalisman != null)
         {
            this.FProcessorWindowTalisman.OnGoToKillHeros = this.FOnGoToKillHeros;
         }
      }
      
      protected function GoToLostPanelClick() : void
      {
         if(this.FGoToLostPanelFunction != null)
         {
            this.FGoToLostPanelFunction();
         }
      }
      
      public function set GoToLostPanelFunction(param1:Function) : void
      {
         this.FGoToLostPanelFunction = param1;
      }
      
      public function UpdateEquip() : void
      {
         if(FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowTalisman.UpdateEquip();
         }
      }
      
      public function UpdateCharacterBaseAttribute() : void
      {
         this.FProcessorWindowTalisman.UpdateCharacterBaseAttribute();
      }
      
      public function UserUpdateInventories() : void
      {
         if(this.FProcessorWindowTalisman.Visible)
         {
            this.FProcessorWindowTalisman.Update();
         }
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount();
         this.ProcessorStreamData(param1);
         if(!FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowTalisman.Load();
            return;
         }
         this.ProcessorOnUpdateHerosBaseAttributeReq(null);
         this.FProcessorWindowTalisman.Visible = true;
         this.FProcessorWindowTalisman.NiMeiA();
         this.FProcessorWindowTalisman.Update(0,0);
         TutorialNextStep(1101);
      }
      
      override public function Unmount() : void
      {
         this.FTabIndex = -1;
         this.FStringID = 0;
         this.FProcessorWindowTalisman.Reset();
         TutorialNextStep(1102);
      }
   }
}

