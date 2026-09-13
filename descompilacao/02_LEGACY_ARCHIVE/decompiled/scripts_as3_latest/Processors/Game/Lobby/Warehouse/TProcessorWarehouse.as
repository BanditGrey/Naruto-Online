package Processors.Game.Lobby.Warehouse
{
   import Debugging.*;
   import Foundation.Common.*;
   import Foundation.Network.*;
   import Foundation.Resources.*;
   import Foundation.Resources.Bins.*;
   import Foundation.Timing.*;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.*;
   import Logics.Characters.TCharacter;
   import Logics.DatebaseVO.VO.*;
   import Logics.Inventories.*;
   import Logics.Streamization.Characters.TUnstreamizerCharacter;
   import Logics.Streamization.Inventories.*;
   import Logics.Streamization.Warehouse.*;
   import Logics.Warehouse.*;
   import Processors.Game.Lobby.Common.*;
   import Processors.Game.Utilities.Inventories.*;
   import Rendering.Overlayers.*;
   import Rendering.Overlayers.HelpTips.TOverlayerHelpTips;
   import Rendering.Overlayers.Inventories.*;
   import Resources.Constants.*;
   import Resources.Strings.*;
   import Utilities.UI.Overlayers.*;
   import flash.utils.*;
   
   public class TProcessorWarehouse extends TProcessorLobbyWindows
   {
      
      public static const SIZE_WindowUserAssets_Width:uint = 608;
      
      public static const SIZE_WindowUserAssets_Height:uint = 555;
      
      public static const STAGE_Width:Number = CONST_COMMON.STAGE_Width;
      
      public static const STAGE_Height:Number = CONST_COMMON.STAGE_Height;
      
      public static const TYPE_BACKPACK:uint = 0;
      
      public static const TYPE_TEMP_BACKPACK:uint = 1;
      
      public static const CAPACITY_INVENTORIES:uint = CONST_COMMON.CAPACITY_INVENTORIES;
      
      public static const CATEGORY_Normal:uint = CONST_INVENTORY.CATEGORY_Normal;
      
      public static const CATEGORY_Equipment:uint = CONST_INVENTORY.CATEGORY_Equipment;
      
      public static const CATEGORY_Gem:uint = CONST_INVENTORY.CATEGORY_Gem;
      
      public static const CATEGORY_Treasure:uint = CONST_INVENTORY.CATEGORY_Treasure;
      
      public static const CATEGORY_Material:uint = CONST_INVENTORY.CATEGORY_Material;
      
      public static const CATEGORY_Accessories:uint = CONST_INVENTORY.CATEGORY_Accessories;
      
      public static const CATEGORY_Medals:uint = CONST_INVENTORY.CATEGORY_Medals;
      
      protected static const EffectMulti_DelayTicks:int = 2000;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FUnstreamizerWarehouse:TUnstreamizerWarehouse;
      
      protected var FUnstreamizerCharacter:TUnstreamizerCharacter;
      
      protected var FUnstreamizerInventories:TUnstreamizerInventories;
      
      protected var FUtilityInventory:TUtilityInventory;
      
      protected var FOverlayerSuperTreasureCopy:TOverlayerSuperTreasure;
      
      protected var FProcessorWarehouse:TProcessorWindowWarehouse;
      
      protected var FBoundsBackpack:TBounds;
      
      protected var FCharacter:TCharacter;
      
      protected var FWarehouse:TWarehouse;
      
      protected var FEffectTexts:Vector.<String>;
      
      protected var FInit:Boolean;
      
      protected var FStringID:uint;
      
      protected var FSystemLanguage:TSystemLanguage;
      
      protected var FEffDelayReferenceTick:int;
      
      protected var FIsEndPushText:Boolean;
      
      protected var FInventory:TInventory;
      
      protected var FQuantity:uint;
      
      protected var FCoin:Number = 0;
      
      protected var FInventories:TInventories;
      
      protected var FOnShortcutHyperlinks:Function;
      
      protected var FOnUpdateInventories:Function;
      
      public function TProcessorWarehouse(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         this.FUnstreamizerWarehouse = new TUnstreamizerWarehouse();
         this.FUnstreamizerInventories = new TUnstreamizerInventories();
         this.FUnstreamizerCharacter = new TUnstreamizerCharacter();
         this.FUtilityInventory = new TUtilityInventory();
         this.FProcessorWarehouse = new TProcessorWindowWarehouse(this);
         this.FProcessorWarehouse.OnInventoryOver = UIComponentsHintOnOver;
         this.FProcessorWarehouse.OnInventoryOut = UIComponentsHintOnOut;
         this.FProcessorWarehouse.OnHelpTipsOver = UIHelpTipsHintOnOver;
         this.FProcessorWarehouse.OnHelpTipsOut = UIHelpTipsHintOnOut;
         this.FProcessorWarehouse.OnClose = this.ProcessorUserAssetsOnClose;
         this.FProcessorWarehouse.OnSaveInventory = this.PerformPacket_CS_SaveThings;
         this.FProcessorWarehouse.OnEffectText = ProcessorsOnEffectText;
         this.FProcessorWarehouse.OnTakeInventory = this.PerformPacket_CS_TakeThings;
         this.FBoundsBackpack = new TBounds();
         this.FBoundsBackpack.X = this.FProcessorWarehouse.x;
         this.FBoundsBackpack.Y = this.FProcessorWarehouse.y;
         this.FBoundsBackpack.Width = SIZE_WindowUserAssets_Width;
         this.FBoundsBackpack.Height = SIZE_WindowUserAssets_Height;
         ComponentBoundsCenter(this.FProcessorWarehouse,this.FBoundsBackpack);
         this.FProcessorWarehouse.X -= 100;
         this.FCharacter = SLogicsCore.Character;
         this.FWarehouse = SLogicsCore.Warehouse;
         this.FEffectTexts = new Vector.<String>();
         FOverlayerEquipment = new TOverlayerEquipment(this,CONST_MODULES.MODULE_Backpack);
         FOverlayerEquipment.Visible = false;
         FOverlayerAccessory = new TOverlayerAccessory(this,CONST_MODULES.MODULE_Backpack);
         FOverlayerAccessory.Visible = false;
         FOverlayerTreasure = new TOverlayerTreasure(this,CONST_MODULES.MODULE_Backpack);
         FOverlayerTreasure.Visible = false;
         this.FOverlayerSuperTreasureCopy = new TOverlayerSuperTreasure(this,CONST_MODULES.MODULE_Backpack);
         this.FOverlayerSuperTreasureCopy.Visible = false;
         FOverlayerAppliance = new TOverlayerAppliance(this,CONST_MODULES.MODULE_Backpack);
         FOverlayerAppliance.Visible = false;
         FOverSuperJade = new TOverSuperJade(this);
         FOverSuperJade.Visible = false;
         FOverlayerMedal = new TOverlayerMedal(this,CONST_MODULES.MODULE_Backpack);
         FOverlayerMedal.Visible = false;
         FOverlayerHelpTips = new TOverlayerHelpTips(this);
         FOverlayerHelpTips.Visible = false;
         this.FIsEndPushText = false;
         SetUIModuleID(CONST_MODULES.MODULE_Backpack);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_WAREHOUSE.RESOURCESID_Swf);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerEquipment);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerAccessory);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerTreasure);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerSuperTreasureCopy);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerAppliance);
         TUtilityUIOverlayer.ResourcesDispatch(FOverSuperJade);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerMedal);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerHelpTips);
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Warehouse_List_Ret,this.PerformPacket_SC_ListRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Warehouse_Save_Ret,this.PerformPacket_SC_SaveThings);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Warehouse_Take_Ret,this.PerformPacket_SC_TakeThings);
      }
      
      protected function PerformPacket_SC_ListRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         _loc2_ = param1.Data;
         this.FWarehouse.Equipments.Clear();
         this.FWarehouse.Appliances.Clear();
         this.FWarehouse.Gems.Clear();
         this.FWarehouse.Treasures.Clear();
         this.FWarehouse.Materials.Clear();
         this.FWarehouse.Accessories.Clear();
         this.FWarehouse.Medals.Clear();
         this.FWarehouse.TemporaryInventories.Clear();
         this.FUnstreamizerWarehouse.UnstreamizeInventories(_loc2_,this.FWarehouse,null);
         this.FUnstreamizerWarehouse.UnstreamizeClassificationInventories(_loc2_,this.FWarehouse,null);
         this.FProcessorWarehouse.Reset();
      }
      
      protected function PerformPacket_SC_TakeThings(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:TInventories = null;
         var _loc6_:TInventory = null;
         var _loc7_:ByteArray = null;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:TInventories = null;
         _loc7_ = param1.Data;
         _loc2_ = _loc7_.readInt();
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         _loc3_ = _loc7_.readUnsignedInt();
         _loc4_ = _loc7_.readUnsignedInt();
         _loc8_ = int(CAPACITY_INVENTORIES);
         _loc9_ = 0;
         while(_loc9_ < _loc8_)
         {
            _loc5_ = this.FCharacter.GetBackpackByIndex(_loc9_);
            _loc10_ = this.FWarehouse.GetBackpackByIndex(_loc9_);
            _loc6_ = _loc10_.GetInventoryByIdentifier(_loc3_,_loc4_);
            if(_loc6_ != null)
            {
               _loc10_.DeleteInventoryByIdentifier(_loc3_,_loc4_);
               _loc5_.Add(_loc6_);
               break;
            }
            _loc9_++;
         }
         if(this.FOnUpdateInventories != null)
         {
            this.FOnUpdateInventories(this);
         }
         this.FProcessorWarehouse.UserUpdateInventories();
      }
      
      protected function PerformPacket_SC_SaveThings(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:TInventories = null;
         var _loc6_:TInventory = null;
         var _loc7_:ByteArray = null;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:TInventories = null;
         _loc7_ = param1.Data;
         _loc2_ = _loc7_.readInt();
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         _loc3_ = _loc7_.readUnsignedInt();
         _loc4_ = _loc7_.readUnsignedInt();
         _loc8_ = int(CAPACITY_INVENTORIES);
         _loc9_ = 0;
         while(_loc9_ < _loc8_)
         {
            _loc5_ = this.FCharacter.GetBackpackByIndex(_loc9_);
            _loc10_ = this.FWarehouse.GetBackpackByIndex(_loc9_);
            _loc6_ = _loc5_.GetInventoryByIdentifier(_loc3_,_loc4_);
            if(_loc6_ != null)
            {
               _loc5_.DeleteInventoryByIdentifier(_loc3_,_loc4_);
               _loc10_.Add(_loc6_);
               break;
            }
            _loc9_++;
         }
         if(this.FOnUpdateInventories != null)
         {
            this.FOnUpdateInventories(this);
         }
         this.FProcessorWarehouse.UserUpdateInventories();
      }
      
      protected function GetEffectText(param1:uint) : String
      {
         this.FSystemLanguage = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,param1) as TSystemLanguage;
         if(this.FSystemLanguage != null)
         {
            return this.FSystemLanguage.Desc;
         }
         return "";
      }
      
      protected function PerformPacket_CS_ListReq() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Warehouse_List_Req);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PerformPacket_CS_SaveThings(param1:uint, param2:uint) : void
      {
         var _loc3_:TPacket = null;
         _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Warehouse_Save_Req);
         _loc3_.Data.writeUnsignedInt(param1);
         _loc3_.Data.writeUnsignedInt(param2);
         SNetworkCore.Transceiver.PacketTransmit(_loc3_);
      }
      
      protected function PerformPacket_CS_TakeThings(param1:uint, param2:uint) : void
      {
         var _loc3_:TPacket = null;
         _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Warehouse_Take_Req);
         _loc3_.Data.writeUnsignedInt(param1);
         _loc3_.Data.writeUnsignedInt(param2);
         SNetworkCore.Transceiver.PacketTransmit(_loc3_);
      }
      
      protected function ProcessorInventoryUpdateByBackpack(param1:TInventory) : Boolean
      {
         var _loc2_:Boolean = false;
         var _loc3_:TInventory = null;
         var _loc4_:TInventories = null;
         var _loc5_:TEquipment = null;
         var _loc6_:TEquipment = null;
         var _loc7_:TAppliance = null;
         var _loc8_:TAppliance = null;
         var _loc9_:TInventory = null;
         var _loc10_:TInventory = null;
         _loc2_ = false;
         switch(param1.Category)
         {
            case CATEGORY_Normal:
               _loc4_ = this.FWarehouse.Appliances;
               break;
            case CATEGORY_Equipment:
               _loc4_ = this.FWarehouse.Equipments;
               break;
            case CATEGORY_Gem:
               _loc4_ = this.FWarehouse.Gems;
               break;
            case CATEGORY_Treasure:
               _loc4_ = this.FWarehouse.Treasures;
               break;
            case CATEGORY_Material:
               _loc4_ = this.FWarehouse.Materials;
               break;
            case CATEGORY_Accessories:
               _loc4_ = this.FWarehouse.Accessories;
               break;
            case CATEGORY_Medals:
               _loc4_ = this.FWarehouse.Medals;
         }
         _loc3_ = _loc4_.GetInventoryByIdentifier(param1.Identifier0,param1.Identifier1);
         if(_loc3_ != null)
         {
            switch(param1.Category)
            {
               case CATEGORY_Equipment:
               case CATEGORY_Accessories:
               case CATEGORY_Treasure:
               case CATEGORY_Medals:
                  _loc5_ = param1 as TEquipment;
                  _loc6_ = _loc3_ as TEquipment;
                  this.FUtilityInventory.EquipmentAssign(_loc5_,_loc6_);
                  break;
               case CATEGORY_Normal:
               case CATEGORY_Material:
               case CATEGORY_Gem:
                  _loc7_ = param1 as TAppliance;
                  _loc8_ = _loc3_ as TAppliance;
                  this.FUtilityInventory.ApplianceAssign(_loc7_,_loc8_);
            }
            _loc2_ = true;
         }
         return _loc2_;
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         this.FProcessorWarehouse.UpdateTime();
         this.LogicsPerform_EffectText();
      }
      
      protected function LogicsPerform_EffectText() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         var _loc6_:String = null;
         var _loc7_:String = null;
         _loc6_ = "";
         _loc4_ = "";
         if(this.FIsEndPushText)
         {
            if(this.FEffectTexts.length == 0)
            {
               return;
            }
            this.FStringID = CONST_SYSTEMLANGUAGE.BACKPACK_FORMAT_02;
            _loc2_ = int(this.FEffectTexts.length);
            _loc3_ = 8;
            _loc5_ = STimingCore.TickCount - this.FEffDelayReferenceTick;
            if(_loc5_ < EffectMulti_DelayTicks)
            {
               return;
            }
            _loc7_ = this.GetEffectText(this.FStringID);
            _loc6_ = _loc7_.split("\\n")[0] + "\n";
            _loc1_ = 0;
            while(_loc1_ < _loc3_)
            {
               if(_loc2_ <= _loc1_)
               {
                  break;
               }
               _loc4_ += this.FEffectTexts.shift();
               _loc1_++;
            }
            _loc6_ += _loc4_;
            this.FEffDelayReferenceTick = STimingCore.TickCount;
            EffectGenerateText(_loc6_);
         }
      }
      
      protected function GenerateIventories() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Vector.<uint> = null;
         var _loc4_:TBins = null;
         if(!this.FInit)
         {
            _loc4_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
            _loc2_ = _loc4_.Count;
            _loc3_ = new Vector.<uint>(_loc2_);
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               _loc3_[_loc1_] = _loc4_.GetDatebaseByIndex(_loc1_).Identifier;
               _loc1_++;
            }
            this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,this.FWarehouse.Inventories,_loc3_);
            this.FUnstreamizerWarehouse.UnstreamizeClassificationInventories(null,this.FWarehouse,null);
            this.FInit = true;
         }
      }
      
      override protected function PopTipsNotifyCheck() : void
      {
         if(FOnCheckPopTipsModes != null)
         {
            FOnCheckPopTipsModes(this,CONST_POPTIPS.POPTIP_Goto_Backpack);
         }
      }
      
      protected function ProcessorUserAssetsOnClose(param1:Object) : void
      {
         ProcessorClose();
      }
      
      protected function ProcessorInventoryClick(param1:Object, param2:TInventories) : void
      {
         this.FProcessorWarehouse.UpdateSelectBox(param2);
      }
      
      public function get OnShortcutHyperlinks() : Function
      {
         return this.FOnShortcutHyperlinks;
      }
      
      public function set OnShortcutHyperlinks(param1:Function) : void
      {
         this.FOnShortcutHyperlinks = param1;
      }
      
      public function get OnUpdateInventories() : Function
      {
         return this.FOnUpdateInventories;
      }
      
      public function set OnUpdateInventories(param1:Function) : void
      {
         this.FOnUpdateInventories = param1;
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount();
         if(!FIsResourcesLoadCompleted)
         {
            this.FProcessorWarehouse.Load();
            return;
         }
         this.PerformPacket_CS_ListReq();
         this.FProcessorWarehouse.Visible = true;
         this.FProcessorWarehouse.PlayEffect();
      }
      
      override public function Unmount() : void
      {
      }
   }
}

