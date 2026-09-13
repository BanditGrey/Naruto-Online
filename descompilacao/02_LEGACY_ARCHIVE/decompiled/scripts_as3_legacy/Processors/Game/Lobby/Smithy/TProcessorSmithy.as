package Processors.Game.Lobby.Smithy
{
   import Foundation.Common.*;
   import Foundation.Network.*;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.*;
   import Logics.*;
   import Logics.Characters.THero;
   import Logics.Inventories.*;
   import Logics.Smithy.*;
   import Logics.Streamization.Smithy.*;
   import Processors.Game.Lobby.Common.*;
   import Rendering.Overlayers.HelpTips.TOverlayerHelpTips;
   import Rendering.Overlayers.Hints.TOverlayerHint;
   import Rendering.Overlayers.Inventories.*;
   import Rendering.Overlayers.OhtsutsukiKaguya.TOverOhtsutsukikaguyaSmithyTip;
   import Resources.Constants.*;
   import Utilities.UI.Overlayers.*;
   import flash.utils.*;
   
   public class TProcessorSmithy extends TProcessorLobbyWindows
   {
      
      protected static const UIWIDTH:int = 876;
      
      protected static const UIHEIGHT:int = 548;
      
      public static const CATEGORY_Equipment:uint = CONST_INVENTORY.CATEGORY_Equipment;
      
      public static const CATEGORY_Treasure:uint = CONST_INVENTORY.CATEGORY_Treasure;
      
      public static const CATEGORY_Accessories:uint = CONST_INVENTORY.CATEGORY_Accessories;
      
      protected var FProcessorWindowSmithy:TProcessorWindowSmithy;
      
      protected var FBoundsSmithy:TBounds;
      
      protected var FSmithyRefinedPakcetUnstreamizerData:TSmithyRefinedPakcetUnstreamizerData;
      
      protected var FUnstreamizerStrengthenAttribute:TUnstreamizerStrengthenAttribute;
      
      protected var FOverKaguyaTip:TOverOhtsutsukikaguyaSmithyTip;
      
      protected var FClearTimeWating:Boolean;
      
      protected var FTabIndex:uint;
      
      protected var FEquipIDHigh:uint;
      
      protected var FEquipIDLow:uint;
      
      protected var FOnUserTotalFightingPowerReq:Function;
      
      public function TProcessorSmithy(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FProcessorWindowSmithy = new TProcessorWindowSmithy(this);
         this.FProcessorWindowSmithy.OnClose = this.ProcessorWindowJadeOnClose;
         this.FProcessorWindowSmithy.UIComponentsHintOnOut = UIComponentsHintOnOut;
         this.FProcessorWindowSmithy.UIComponentsHintOnOver = UIComponentsHintOnOver;
         this.FProcessorWindowSmithy.ICMove = this.ICMove;
         this.FProcessorWindowSmithy.ICOut = this.ICOut;
         this.FProcessorWindowSmithy.ClearTime = this.PerformPacket_CS_ClearTime;
         this.FProcessorWindowSmithy.UIComponentsBtnOnOver = this.UIComponentsBtnOnOver;
         this.FProcessorWindowSmithy.UIComponentsBtnOnOut = this.UIComponentsBtnOnOut;
         this.FProcessorWindowSmithy.OnHelpTipsOver = UIHelpTipsHintOnOver;
         this.FProcessorWindowSmithy.OnHelpTipsOut = UIHelpTipsHintOnOut;
         this.FBoundsSmithy = new TBounds();
         this.FBoundsSmithy.Width = UIWIDTH;
         this.FBoundsSmithy.Height = UIHEIGHT;
         ComponentBoundsCenter(this.FProcessorWindowSmithy,this.FBoundsSmithy);
         this.FSmithyRefinedPakcetUnstreamizerData = new TSmithyRefinedPakcetUnstreamizerData(10);
         this.FUnstreamizerStrengthenAttribute = new TUnstreamizerStrengthenAttribute();
         FOverlayerEquipment = new TOverlayerEquipment(this,CONST_MODULES.MODULE_Smithy);
         FOverlayerEquipment.Visible = false;
         FOverlayerTreasure = new TOverlayerTreasure(this,CONST_MODULES.MODULE_Smithy);
         FOverlayerTreasure.Visible = false;
         FOverlayerAppliance = new TOverlayerAppliance(this,CONST_MODULES.MODULE_Smithy);
         FOverlayerAppliance.Visible = false;
         FOverlayerHint = new TOverlayerHint(this);
         FOverlayerHint.visible = false;
         FOverlayerHelpTips = new TOverlayerHelpTips(this);
         FOverlayerHelpTips.Visible = false;
         this.FOverKaguyaTip = new TOverOhtsutsukikaguyaSmithyTip(this);
         this.FOverKaguyaTip.Visible = false;
         FOverlayerAccessory = new TOverlayerAccessory(this,CONST_MODULES.MODULE_Smithy);
         FOverlayerAccessory.Visible = false;
         SetUIModuleID(CONST_MODULES.MODULE_Smithy);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_SMITHY.RESOURCESID_SMITHY);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerHint);
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerEquipment);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerTreasure);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerAppliance);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerAccessory);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverKaguyaTip);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerHelpTips);
         this.FProcessorWindowSmithy.MakeEquipNewwork = this.PerformPacket_CS_EquipMakeRequest;
         this.FProcessorWindowSmithy.EnchantNewwork = this.PerformPacket_CS_Enchant;
         this.FProcessorWindowSmithy.PunchNetwork = this.PerformPacket_CS_Punch;
         this.FProcessorWindowSmithy.InheritNetwork = this.PerformPacket_CS_Inherited;
         this.FProcessorWindowSmithy.RefinedNetwork = this.PerformPacket_CS_Refined;
         this.FProcessorWindowSmithy.RefinedExchange = this.PerformPacket_CS_RefinedExchange;
         this.FProcessorWindowSmithy.StrengthenNetWork = this.PerformPacket_CS_Strengthen;
         this.FProcessorWindowSmithy.UpgradeNetwork = this.PerformPacket_CS_Upgrade;
         super.ResourcesPerform_UILocations();
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_SmithyStrengthenResponse,this.PerformPacket_SC_Strengthen);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_SmithyRefinedResponse,this.PerformPacket_SC_Refined);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_SmithyInheritResponse,this.PerformPacket_SC_Inherited);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_SmithyRefinedConfirmResponse,this.PerformPacket_SC_RefinedExchange);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_SmithyStrengthClearTime,this.PerformPacket_SC_ClearTime);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_SmithyPunchHole,this.PerformPacket_SC_PunchHole);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_SmithyEnchant,this.PerformPacket_SC_Enchant);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Equip_Make,this.PerformPacket_SC_Equip_Make);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TransmigrationTrial_EquipGodCast_Ret,this.PerformPacket_SC_Upgrade);
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
      }
      
      protected function PerformPacket_SC_Strengthen(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _loc2_ = param1.Data;
         _loc3_ = int(_loc2_.readUnsignedInt());
         this.FProcessorWindowSmithy.ResultCode = _loc3_;
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         this.FProcessorWindowSmithy.StrengthenLevel = _loc2_.readUnsignedShort();
         _loc4_ = int(_loc2_.readUnsignedInt());
         this.FProcessorWindowSmithy.StrengthenCDTime = _loc4_;
         this.FProcessorWindowSmithy.Update();
         if(this.CheckEquipOnFieldHero())
         {
            if(this.FOnUserTotalFightingPowerReq != null)
            {
               this.FOnUserTotalFightingPowerReq(this);
            }
         }
      }
      
      protected function CheckEquipOnFieldHero() : Boolean
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:THero = null;
         var _loc4_:TInventory = null;
         _loc2_ = uint(SLogicsCore.Character.Heros.Count);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = SLogicsCore.Character.Heros.GetHeroByIndex(_loc1_);
            if(_loc3_.Mounted)
            {
               if(this.FindOutInventory(_loc3_.EquipmentsMounted) || this.FindOutInventory(_loc3_.TalismansMounted))
               {
                  return true;
               }
            }
            _loc1_++;
         }
         return false;
      }
      
      protected function FindOutInventory(param1:TCollectionInventory) : Boolean
      {
         var _loc2_:TInventory = null;
         _loc2_ = param1.GetInventoryByIdentifier(this.FEquipIDHigh,this.FEquipIDLow);
         if(_loc2_ != null)
         {
            return true;
         }
         return false;
      }
      
      protected function PerformPacket_CS_Strengthen(param1:uint, param2:uint, param3:Vector.<int>) : void
      {
         var _loc4_:int = 0;
         var _loc5_:TPacket = null;
         this.FEquipIDHigh = param1;
         this.FEquipIDLow = param2;
         _loc5_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_SmithyStrengthenRequest);
         _loc5_.Data.writeUnsignedInt(param1);
         _loc5_.Data.writeUnsignedInt(param2);
         _loc5_.Data.writeShort(param3.length);
         _loc4_ = 0;
         while(_loc4_ < param3.length)
         {
            _loc5_.Data.writeByte(param3[_loc4_]);
            _loc4_++;
         }
         SNetworkCore.Transceiver.PacketTransmit(_loc5_);
      }
      
      protected function PerformPacket_CS_StrengthenColdTime() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_SmithyRequestColdTime);
         _loc1_.Data.writeShort(1);
         _loc1_.Data.writeByte(6);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PerformPacket_SC_Refined(param1:TPacket) : void
      {
         this.FUnstreamizerStrengthenAttribute.UnstreamizeStrengthenAttributes(param1.Data,this.FSmithyRefinedPakcetUnstreamizerData,null);
         this.FProcessorWindowSmithy.ResultCode = this.FSmithyRefinedPakcetUnstreamizerData.ResultCode;
         this.FProcessorWindowSmithy.CurrentSmithyAttributeList = this.FSmithyRefinedPakcetUnstreamizerData;
         this.FProcessorWindowSmithy.Update();
         if(this.CheckEquipOnFieldHero())
         {
            if(this.FOnUserTotalFightingPowerReq != null)
            {
               this.FOnUserTotalFightingPowerReq(this);
            }
         }
      }
      
      protected function PerformPacket_CS_Refined(param1:uint, param2:uint, param3:int, param4:int) : void
      {
         var _loc5_:TPacket = null;
         this.FEquipIDHigh = param1;
         this.FEquipIDLow = param2;
         _loc5_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_SmithyRefinedRequest);
         _loc5_.Data.writeUnsignedInt(param1);
         _loc5_.Data.writeUnsignedInt(param2);
         _loc5_.Data.writeByte(param3);
         _loc5_.Data.writeByte(param4);
         SNetworkCore.Transceiver.PacketTransmit(_loc5_);
      }
      
      protected function PerformPacket_SC_RefinedExchange(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         _loc2_ = int(param1.Data.readUnsignedInt());
         this.FProcessorWindowSmithy.ResultCode = _loc2_;
         if(_loc2_ == 0)
         {
            _loc3_ = param1.Data.readUnsignedInt();
            _loc4_ = param1.Data.readUnsignedInt();
         }
         this.FProcessorWindowSmithy.Update();
      }
      
      protected function PerformPacket_SC_PunchHole(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(param1.Data.readUnsignedInt());
         this.FProcessorWindowSmithy.ResultCode = _loc2_;
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         this.FProcessorWindowSmithy.Update();
      }
      
      protected function PerformPacket_SC_Enchant(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(param1.Data.readUnsignedInt());
         this.FProcessorWindowSmithy.ResultCode = _loc2_;
         if(_loc2_ > 1)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         this.FProcessorWindowSmithy.Update();
         if(this.CheckEquipOnFieldHero())
         {
            if(this.FOnUserTotalFightingPowerReq != null)
            {
               this.FOnUserTotalFightingPowerReq(this);
            }
         }
      }
      
      protected function PerformPacket_SC_Equip_Make(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(param1.Data.readUnsignedInt());
         this.FProcessorWindowSmithy.ResultCode = _loc2_;
         if(_loc2_ > 1)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         this.FProcessorWindowSmithy.Update();
      }
      
      protected function PerformPacket_SC_ClearTime(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(param1.Data.readUnsignedInt());
         this.FProcessorWindowSmithy.ResultCode = _loc2_;
         if(_loc2_ == 0)
         {
            if(this.FClearTimeWating)
            {
               this.FProcessorWindowSmithy.Update();
            }
            SLogicsCore.Character.TimeCoolDowns.GetDigestByIdentifier(CONST_COMMON.TIME_COOLDOWN_Strengthen).TimingTime = 0;
         }
         this.FClearTimeWating = false;
      }
      
      protected function PerformPacket_CS_ClearTime() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_SmithyStrengthClearTime);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
         this.FClearTimeWating = true;
      }
      
      protected function PerformPacket_CS_RefinedExchange(param1:uint, param2:uint, param3:int) : void
      {
         var _loc4_:TPacket = null;
         _loc4_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_SmithyRefinedConfirmRequest);
         _loc4_.Data.writeUnsignedInt(param1);
         _loc4_.Data.writeUnsignedInt(param2);
         _loc4_.Data.writeShort(param3);
         SNetworkCore.Transceiver.PacketTransmit(_loc4_);
      }
      
      protected function PerformPacket_SC_Inherited(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(param1.Data.readUnsignedInt());
         this.FProcessorWindowSmithy.ResultCode = _loc2_;
         this.FProcessorWindowSmithy.Update();
      }
      
      protected function PerformPacket_CS_Inherited(param1:uint, param2:uint, param3:uint, param4:uint, param5:int) : void
      {
         var _loc6_:TPacket = null;
         _loc6_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_SmithyInheritRequest);
         _loc6_.Data.writeUnsignedInt(param1);
         _loc6_.Data.writeUnsignedInt(param2);
         _loc6_.Data.writeUnsignedInt(param3);
         _loc6_.Data.writeUnsignedInt(param4);
         _loc6_.Data.writeByte(param5);
         SNetworkCore.Transceiver.PacketTransmit(_loc6_);
      }
      
      protected function PerformPacket_CS_Punch(param1:uint, param2:uint) : void
      {
         var _loc3_:TPacket = null;
         _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_SmithyPunchHole);
         _loc3_.Data.writeUnsignedInt(param1);
         _loc3_.Data.writeUnsignedInt(param2);
         SNetworkCore.Transceiver.PacketTransmit(_loc3_);
      }
      
      protected function PerformPacket_CS_Enchant(param1:uint, param2:uint) : void
      {
         var _loc3_:TPacket = null;
         this.FEquipIDHigh = param1;
         this.FEquipIDLow = param2;
         _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_SmithyEnchant);
         _loc3_.Data.writeUnsignedInt(param1);
         _loc3_.Data.writeUnsignedInt(param2);
         SNetworkCore.Transceiver.PacketTransmit(_loc3_);
      }
      
      protected function PerformPacket_CS_EquipMakeRequest(param1:Object, param2:Object) : void
      {
         var _loc3_:TInventory = null;
         var _loc4_:uint = 0;
         var _loc5_:TPacket = null;
         _loc3_ = param2 as TInventory;
         if(_loc3_ == null)
         {
            return;
         }
         _loc4_ = _loc3_.IDTemplate;
         _loc5_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Equip_Make);
         _loc5_.Data.writeUnsignedInt(_loc4_);
         SNetworkCore.Transceiver.PacketTransmit(_loc5_);
      }
      
      override protected function PopTipsNotifyCheck() : void
      {
         if(FOnCheckPopTipsModes != null)
         {
            FOnCheckPopTipsModes(this,CONST_POPTIPS.POPTIP_Goto_Strengthen);
         }
      }
      
      protected function PerformPacket_SC_Upgrade(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         if(!this.Visible)
         {
            return;
         }
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         this.FProcessorWindowSmithy.Update();
      }
      
      protected function PerformPacket_CS_Upgrade(param1:uint, param2:uint) : void
      {
         var _loc3_:TPacket = null;
         _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TransmigrationTrial_EquipGodCast_Req);
         _loc3_.Data.writeUnsignedInt(param1);
         _loc3_.Data.writeUnsignedInt(param2);
         SNetworkCore.Transceiver.PacketTransmit(_loc3_);
      }
      
      protected function ProcessorWindowJadeOnClose(param1:Object) : void
      {
         ProcessorClose();
         TutorialNextStep(803);
      }
      
      protected function ICMove() : void
      {
         if(this.FProcessorWindowSmithy.KaguyState)
         {
            this.FOverKaguyaTip.Context = 7;
         }
         else
         {
            this.FOverKaguyaTip.Context = 8;
         }
         this.FOverKaguyaTip.Render(FUICore.MouseCoordinate);
         this.FOverKaguyaTip.Show();
      }
      
      protected function ICOut() : void
      {
         this.FOverKaguyaTip.Hide();
      }
      
      protected function UIComponentsBtnOnOver(param1:Object, param2:THint) : void
      {
         FOverlayerHint.Context = param2;
         FOverlayerHint.Render(FUICore.MouseCoordinate);
         FOverlayerHint.Show();
      }
      
      protected function UIComponentsBtnOnOut(param1:Object) : void
      {
         FOverlayerHint.Hide();
      }
      
      protected function ProcessorStreamData(param1:ByteArray) : void
      {
         if(param1 != null)
         {
            this.FTabIndex = param1.readUnsignedInt();
         }
      }
      
      override public function set OnEffectText(param1:Function) : void
      {
         super.OnEffectText = param1;
         this.FProcessorWindowSmithy.OnEffectText = param1;
      }
      
      public function get ProcessorWindowSmithy() : TProcessorWindowSmithy
      {
         return this.FProcessorWindowSmithy;
      }
      
      public function set UpdateHeroPower(param1:Function) : void
      {
         this.FProcessorWindowSmithy.UpdateHeroPower = param1;
      }
      
      public function set UpdateHerosPower(param1:Function) : void
      {
         this.FProcessorWindowSmithy.UpdateHerosPower = param1;
      }
      
      public function set OnShortcutHyperlinks(param1:Function) : void
      {
         this.FProcessorWindowSmithy.OnShortcutHyperlinks = param1;
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
         this.ProcessorStreamData(param1);
         if(!FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowSmithy.Load();
            return;
         }
         this.PerformPacket_CS_StrengthenColdTime();
         this.FProcessorWindowSmithy.visible = true;
         this.FProcessorWindowSmithy.Update();
         TutorialNextStep(800);
         this.FProcessorWindowSmithy.ShackPendant();
         this.FProcessorWindowSmithy.SetTabIndex(this.FTabIndex);
      }
      
      override public function Unmount() : void
      {
         this.FTabIndex = 0;
         this.FEquipIDHigh = 0;
         this.FEquipIDLow = 0;
         super.Unmount();
      }
      
      public function UpdateCDTime() : void
      {
         this.PerformPacket_CS_StrengthenColdTime();
      }
      
      public function VipLevelUpCheckBtnStatus() : void
      {
         this.FProcessorWindowSmithy.VipLevelUpCheckBtnStatus();
      }
      
      public function UpdateFreeCount() : void
      {
         this.FProcessorWindowSmithy.UpdateFreeCount();
      }
      
      public function FromNewMallMessage(param1:int) : void
      {
         this.FProcessorWindowSmithy.FromNewMallMessage(param1);
      }
   }
}

