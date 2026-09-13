package Processors.Game.Lobby.Exercise.SantaClaus
{
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.TBaseActivity;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import Rendering.Overlayers.Inventories.TOverlayerAccessory;
   import Rendering.Overlayers.Inventories.TOverlayerAppliance;
   import Rendering.Overlayers.Inventories.TOverlayerEquipment;
   import Rendering.Overlayers.Inventories.TOverlayerTreasure;
   import Rendering.Overlayers.TOverlayer;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_INVENTORY;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Strings.STRING_BASEACTIVITY;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   
   public class TProcessorSantaClaus extends TProcessorLobbyWindows
   {
      
      protected static const SIZE_WIDTH_Recharge:uint = 791;
      
      protected static const SIZE_HIGHT_Recharge:uint = 438;
      
      public static const CAPACITY_INVENTORIES:uint = CONST_COMMON.CAPACITY_INVENTORIES;
      
      public static const CATEGORY_Normal:uint = CONST_INVENTORY.CATEGORY_Normal;
      
      public static const CATEGORY_Equipment:uint = CONST_INVENTORY.CATEGORY_Equipment;
      
      public static const CATEGORY_Gem:uint = CONST_INVENTORY.CATEGORY_Gem;
      
      public static const CATEGORY_Treasure:uint = CONST_INVENTORY.CATEGORY_Treasure;
      
      public static const CATEGORY_Material:uint = CONST_INVENTORY.CATEGORY_Material;
      
      public static const CATEGORY_Accessories:uint = CONST_INVENTORY.CATEGORY_Accessories;
      
      protected var FMC_Scene:MovieClip;
      
      protected var FBTN_Close:SimpleButton;
      
      protected var FBTN_GetReward:MovieClip;
      
      protected var FInitialized:Boolean;
      
      protected var FStatus:int;
      
      protected var FDialog:String;
      
      protected var FNPCType:int;
      
      protected var FInventories:TInventories;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      public function TProcessorSantaClaus(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FInitialized = false;
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         this.FInventories = new TInventories();
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(2499805184);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.FMC_Scene = TUtilityReflection.CreateDisplayObjectInstance("MC_SantaClaus") as MovieClip;
         addChild(this.FMC_Scene);
         this.FMC_Scene.x = CONST_COMMON.STAGE_Width - SIZE_WIDTH_Recharge >> 1;
         this.FMC_Scene.y = CONST_COMMON.STAGE_Height - SIZE_HIGHT_Recharge >> 1;
         this.FBTN_Close = this.FMC_Scene["Btn_Close"];
         this.FBTN_GetReward = this.FMC_Scene["BTN_Reward"];
         this.FMC_Scene.MC_Tip.buttonMode = true;
         FOverlayerEquipment = new TOverlayerEquipment(this.Parent,CONST_MODULES.ACTIVE_Test);
         FOverlayerEquipment.Visible = false;
         FOverlayerTreasure = new TOverlayerTreasure(this.Parent,CONST_MODULES.ACTIVE_Test);
         FOverlayerTreasure.Visible = false;
         FOverlayerAppliance = new TOverlayerAppliance(this.Parent,CONST_MODULES.ACTIVE_Test);
         FOverlayerAppliance.Visible = false;
         FOverlayerAccessory = new TOverlayerAccessory(this.Parent,CONST_MODULES.ACTIVE_Test);
         FOverlayerAccessory.Visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerEquipment);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerTreasure);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerAppliance);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerAccessory);
         this.FInitialized = true;
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
         this.FBTN_Close.addEventListener(MouseEvent.CLICK,this.ButtonOnClose,false,0,true);
         this.FBTN_GetReward.addEventListener(MouseEvent.CLICK,this.ButtonOnGetReward,false,0,true);
         this.FMC_Scene.MC_Tip.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnBoxOver,false,0,true);
         this.FMC_Scene.MC_Tip.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnBoxOut,false,0,true);
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         if(this.FInitialized)
         {
         }
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         super.PacketRegisterRoutines();
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_SantaClaus_LoadInfo_Ret,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_SantaClaus_GetReward_Ret,this.PerformPacket_SC_GetRewardRet);
      }
      
      protected function UpdateUI() : void
      {
         if(!this.FInitialized)
         {
            return;
         }
         this.FMC_Scene.TF_Dialog.text = this.FDialog;
         if(this.FStatus == TBaseActivity.STATUS_CANGET)
         {
            TGameUtil.setButtonMode(this.FBTN_GetReward,true);
            this.FBTN_GetReward.visible = true;
            this.FMC_Scene.MC_Got.visible = false;
         }
         else if(this.FStatus == TBaseActivity.STATUS_CANNOTGET)
         {
            TGameUtil.setButtonMode(this.FBTN_GetReward,false);
            this.FBTN_GetReward.visible = false;
            this.FMC_Scene.MC_Got.visible = false;
         }
         else
         {
            this.FBTN_GetReward.visible = false;
            this.FMC_Scene.MC_Got.visible = true;
         }
      }
      
      protected function ButtonOnClose(param1:MouseEvent) : void
      {
         ProcessorClose();
      }
      
      protected function ButtonOnGetReward(param1:MouseEvent) : void
      {
         if(param1.currentTarget.buttonMode == false)
         {
            return;
         }
         this.PerformPacket_CS_GetRwardReq();
      }
      
      protected function ProcessorOnBoxOver(param1:MouseEvent) : void
      {
         var _loc2_:TInventory = null;
         var _loc3_:TOverlayer = null;
         if(this.FInventories.Count <= 0)
         {
            return;
         }
         if(this.FStatus == TBaseActivity.STATUS_CANNOTGET)
         {
            return;
         }
         _loc2_ = this.FInventories.GetInventoryByIndex(0);
         switch(_loc2_.Category)
         {
            case CATEGORY_Equipment:
               _loc3_ = FOverlayerEquipment;
               break;
            case CATEGORY_Treasure:
               _loc3_ = FOverlayerTreasure;
               break;
            case CATEGORY_Accessories:
               _loc3_ = FOverlayerAccessory;
               break;
            default:
               _loc3_ = FOverlayerAppliance;
         }
         if(_loc3_ != null)
         {
            _loc3_.Context = _loc2_;
            _loc3_.Render(FUICore.MouseCoordinate);
            _loc3_.Show();
         }
      }
      
      protected function ProcessorOnBoxOut(param1:MouseEvent) : void
      {
         var _loc2_:TInventory = null;
         var _loc3_:TOverlayer = null;
         if(this.FInventories.Count <= 0)
         {
            return;
         }
         _loc2_ = this.FInventories.GetInventoryByIndex(0);
         switch(_loc2_.Category)
         {
            case CATEGORY_Equipment:
               _loc3_ = FOverlayerEquipment;
               break;
            case CATEGORY_Treasure:
               _loc3_ = FOverlayerTreasure;
               break;
            case CATEGORY_Accessories:
               _loc3_ = FOverlayerAccessory;
               break;
            default:
               _loc3_ = FOverlayerAppliance;
         }
         if(_loc3_ != null)
         {
            _loc3_.Hide();
         }
      }
      
      protected function PerformPacket_CS_LoadInfoReq() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:int = 0;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_SantaClaus_LoadInfo_Req);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      public function PerformPacket_SC_LoadInfoRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:Vector.<uint> = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            OnClose(this);
            return;
         }
         _loc5_ = new Vector.<uint>();
         this.FNPCType = _loc2_.readInt();
         _loc4_ = uint(_loc2_.readInt());
         _loc5_.push(_loc4_);
         this.FStatus = _loc2_.readInt();
         this.FDialog = TUtilityString.FetchUTF(_loc2_);
         this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,this.FInventories,_loc5_);
         if(FIsResourcesLoadCompleted && this.visible)
         {
            this.UpdateUI();
         }
      }
      
      protected function PerformPacket_CS_GetRwardReq() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_SantaClaus_GetReward_Req);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PerformPacket_SC_GetRewardRet(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:TInventory = null;
         _loc2_ = param1.Data.readInt();
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            OnClose(this);
            return;
         }
         _loc3_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
         _loc4_ = this.FInventories.GetInventoryByIndex(0);
         _loc3_ += _loc4_.Name + "*" + _loc4_.Quantity + "\n";
         EffectGenerateText(STRING_BASEACTIVITY.FORMAT_GET);
         this.FStatus = TBaseActivity.STATUS_GETED;
         this.UpdateUI();
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount(param1);
         if(!FIsResourcesLoadCompleted)
         {
            return;
         }
         this.PerformPacket_CS_LoadInfoReq();
      }
   }
}

