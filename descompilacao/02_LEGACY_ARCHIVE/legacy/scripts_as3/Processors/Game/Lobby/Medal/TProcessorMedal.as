package Processors.Game.Lobby.Medal
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
   import Logics.Medal.TMedalRefinedPakcetUnstreamizerData;
   import Logics.Streamization.Medal.TUnstreamizerMedelRefinedAttribute;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import Rendering.Overlayers.HelpTips.TOverlayerHelpTips;
   import Rendering.Overlayers.Hints.TOverlayerHint;
   import Rendering.Overlayers.Inventories.TOverlayerMedal;
   import Rendering.Overlayers.TOverlayer;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MEDAL;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.utils.ByteArray;
   
   public class TProcessorMedal extends TProcessorLobbyWindows
   {
      
      protected static const SIZE_WindowTalisman_Width:uint = 800;
      
      protected static const SIZE_WindowTalisman_Height:uint = 536;
      
      protected var FProcessorWindowMedal:TProcessorWindowMedal;
      
      protected var FBoundsBackpack:TBounds;
      
      protected var FSystemLanguage:TSystemLanguage;
      
      protected var FSystemLanguageBin:TBins;
      
      protected var FStringID:uint;
      
      protected var FTabIndex:int;
      
      protected var FHeroTabIndex:int;
      
      protected var FOnMountTalisman:Function;
      
      protected var FOnDismountTalisman:Function;
      
      protected var FOnUpdateHerosBaseAttributeReq:Function;
      
      protected var FOnUserTotalFightingPowerReq:Function;
      
      protected var FGoToLostPanelFunction:Function;
      
      protected var FMedalRefinedPakcetUnstreamizerData:TMedalRefinedPakcetUnstreamizerData;
      
      protected var FUnstreamizerMedalRefinedAttribute:TUnstreamizerMedelRefinedAttribute;
      
      public function TProcessorMedal(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FProcessorWindowMedal = new TProcessorWindowMedal(this);
         this.FProcessorWindowMedal.OnEffectText = ProcessorsOnEffectText;
         this.FProcessorWindowMedal.OnClose = this.ProcessorWindowTalismanOnClose;
         this.FProcessorWindowMedal.EquipOnOffOnClick = this.EquipOnOff;
         this.FProcessorWindowMedal.UpgradeOnClick = this.Upgrade;
         this.FProcessorWindowMedal.RefinedOnClick = this.PerformPacket_CS_Refined;
         this.FProcessorWindowMedal.UIComponentsHintOnOver = this.UIComponentsHintOnOver1;
         this.FProcessorWindowMedal.UIComponentsHintOnOut = this.UIComponentsHintOnOut1;
         this.FProcessorWindowMedal.OnUpdateHerosBaseAttributeReq = this.ProcessorOnUpdateHerosBaseAttributeReq;
         this.FProcessorWindowMedal.OnHelpTipsOver = UIHelpTipsHintOnOver;
         this.FProcessorWindowMedal.OnHelpTipsOut = UIHelpTipsHintOnOut;
         this.FProcessorWindowMedal.OnTipsOver = this.UITipsHintOnOver;
         this.FProcessorWindowMedal.OnTipsOut = this.UITipsHintOnOut;
         this.FBoundsBackpack = new TBounds();
         this.FBoundsBackpack.X = this.FProcessorWindowMedal.x;
         this.FBoundsBackpack.Y = this.FProcessorWindowMedal.y;
         this.FBoundsBackpack.Width = SIZE_WindowTalisman_Width;
         this.FBoundsBackpack.Height = SIZE_WindowTalisman_Height;
         ComponentBoundsCenter(this.FProcessorWindowMedal,this.FBoundsBackpack);
         this.FMedalRefinedPakcetUnstreamizerData = new TMedalRefinedPakcetUnstreamizerData();
         this.FUnstreamizerMedalRefinedAttribute = new TUnstreamizerMedelRefinedAttribute();
         FOverlayerMedal = new TOverlayerMedal(this,CONST_MODULES.MODULE_Medal);
         FOverlayerMedal.Visible = false;
         FOverlayerHelpTips = new TOverlayerHelpTips(this);
         FOverlayerHelpTips.Visible = false;
         FOverlayerHint = new TOverlayerHint(this);
         FOverlayerHint.Visible = false;
         this.FTabIndex = -1;
         this.FHeroTabIndex = -1;
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_MEDAL.RESOURCES_ID_Swf);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerMedal);
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
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TalismanEquipResponse,this.PacketPerform_SC_MedalEquipResponse);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Rune_UpgradeRet,this.PacketPerform_SC_MedalUpgradeResponse);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Rune_RefinedRet,this.PerformPacket_SC_Refined);
      }
      
      protected function PacketPerform_SC_MedalEquipResponse(param1:TPacket) : void
      {
         var _loc2_:ByteArray = param1.Data;
         var _loc3_:uint = uint(_loc2_.readByte());
         var _loc4_:uint = uint(_loc2_.readByte());
         if(_loc3_ == 0)
         {
         }
      }
      
      protected function PacketPerform_SC_MedalUpgradeResponse(param1:TPacket) : void
      {
         var _loc2_:ByteArray = param1.Data;
         var _loc3_:uint = uint(_loc2_.readInt());
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
         this.FProcessorWindowMedal.SetBtnLock();
         this.FProcessorWindowMedal.UpdateUpgradeEquip();
         this.ProcessorOnUpdateHerosBaseAttributeReq(this);
         if(this.FOnUserTotalFightingPowerReq != null)
         {
            this.FOnUserTotalFightingPowerReq(this);
         }
      }
      
      protected function PerformPacket_SC_Refined(param1:TPacket) : void
      {
         var _loc2_:ByteArray = param1.Data;
         var _loc3_:uint = uint(_loc2_.readInt());
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         this.FUnstreamizerMedalRefinedAttribute.UnstreamizeStrengthenAttributes(param1.Data,this.FMedalRefinedPakcetUnstreamizerData,null);
         this.FProcessorWindowMedal.CurrentRefinedAttributeData = this.FMedalRefinedPakcetUnstreamizerData;
         this.FProcessorWindowMedal.UpdateMedalRefined();
      }
      
      protected function PerformPacket_CS_MedalUpgradeRequest(param1:uint, param2:uint) : void
      {
         var _loc3_:TPacket = null;
         _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Rune_UpgradeReq);
         _loc3_.Data.writeUnsignedInt(param1);
         _loc3_.Data.writeUnsignedInt(param2);
         SNetworkCore.Transceiver.PacketTransmit(_loc3_);
      }
      
      protected function PerformPacket_CS_Refined(param1:uint, param2:uint, param3:int, param4:int) : void
      {
         var _loc5_:TPacket = null;
         _loc5_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Rune_RefinedReq);
         _loc5_.Data.writeUnsignedInt(param1);
         _loc5_.Data.writeUnsignedInt(param2);
         _loc5_.Data.writeUnsignedInt(param3);
         _loc5_.Data.writeUnsignedInt(param4);
         SNetworkCore.Transceiver.PacketTransmit(_loc5_);
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
      
      protected function Upgrade(param1:Object, param2:Object) : void
      {
         var _loc3_:TInventory = param2 as TInventory;
         var _loc4_:uint = _loc3_.Identifier0;
         var _loc5_:uint = _loc3_.Identifier1;
         this.PerformPacket_CS_MedalUpgradeRequest(_loc4_,_loc5_);
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
         _loc6_ = FOverlayerMedal;
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
         if(_loc7_ != null)
         {
            _loc7_.Context = _loc5_;
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
         _loc6_ = FOverlayerMedal;
         if(_loc6_ != null)
         {
            _loc6_.Hide();
         }
         if(_loc5_ == null)
         {
            return;
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
      
      public function get OnUserTotalFightingPowerReq() : Function
      {
         return this.FOnUserTotalFightingPowerReq;
      }
      
      public function set OnUserTotalFightingPowerReq(param1:Function) : void
      {
         this.FOnUserTotalFightingPowerReq = param1;
      }
      
      public function UpdateEquip() : void
      {
         if(FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowMedal.UpdateEquip();
         }
      }
      
      public function UpdateCharacterBaseAttribute() : void
      {
         this.FProcessorWindowMedal.UpdateCharacterBaseAttribute();
      }
      
      public function UserUpdateInventories() : void
      {
         if(this.FProcessorWindowMedal.Visible)
         {
            this.FProcessorWindowMedal.Update();
         }
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount();
         this.ProcessorStreamData(param1);
         if(!FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowMedal.Load();
            return;
         }
         this.ProcessorOnUpdateHerosBaseAttributeReq(null);
         this.FProcessorWindowMedal.Visible = true;
         this.FProcessorWindowMedal.Update(this.FTabIndex,this.FHeroTabIndex);
         this.FProcessorWindowMedal.Update(0,0);
      }
      
      override public function Unmount() : void
      {
         this.FTabIndex = -1;
         this.FStringID = 0;
         this.FProcessorWindowMedal.Reset();
      }
   }
}

