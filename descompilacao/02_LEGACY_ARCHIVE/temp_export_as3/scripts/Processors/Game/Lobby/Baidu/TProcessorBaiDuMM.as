package Processors.Game.Lobby.Baidu
{
   import Components.Slots.TUISlot;
   import Externals.SExternalCore;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Queries.TQueryString;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Resources.Repositories.TResourceRepositoryTexture;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Resources.Textures.TTexture;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.DatebaseVO.VO.TBaiDuMM;
   import Logics.Inventories.TAppliance;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.Prerogative.TPlatformPrerogative;
   import Logics.SLogicsCore;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import Rendering.Overlayers.Inventories.TOverlayerAccessory;
   import Rendering.Overlayers.Inventories.TOverlayerAppliance;
   import Rendering.Overlayers.Inventories.TOverlayerEquipment;
   import Rendering.Overlayers.Inventories.TOverlayerTreasure;
   import Rendering.Overlayers.TOverlayer;
   import Resources.Constants.CONST_BAIDUMMQQ;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Strings.STRING_BAIDUMM;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.system.System;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   
   public class TProcessorBaiDuMM extends TProcessorLobbyWindows
   {
      
      protected var FMcPanel:Sprite;
      
      protected var FMC_MM_QQ:MovieClip = null;
      
      protected var FMC_Get_Reward:MovieClip = null;
      
      protected var FBTN_GoMoney:MovieClip = null;
      
      protected var FMC_Reward_Icon:MovieClip = null;
      
      protected var FBtn_Record:MovieClip = null;
      
      protected var FIsCanClick:Boolean;
      
      protected var TF_Money:TextField;
      
      protected var FBTN_Close:SimpleButton;
      
      protected var FSlots:TUISlot;
      
      protected var FIsMM_QQ:Boolean;
      
      protected var UnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FSelectInventories:TInventories;
      
      protected var FTempSelectInventoriesId:Vector.<uint>;
      
      protected var FPlatformPrerogative:TPlatformPrerogative;
      
      public var FsetFBaiDuMeimeiMcState:Function;
      
      protected var AutoActivityGain:TBaiDuMM;
      
      public function TProcessorBaiDuMM(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FPlatformPrerogative = SLogicsCore.PlatformPrerogative;
         this.FTempSelectInventoriesId = new Vector.<uint>();
         this.FSelectInventories = new TInventories();
         this.UnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         FOverlayerEquipment = new TOverlayerEquipment(this.Parent,CONST_MODULES.MODULE_BaiDuMM);
         FOverlayerEquipment.Visible = false;
         FOverlayerAccessory = new TOverlayerAccessory(this.Parent,CONST_MODULES.MODULE_BaiDuMM);
         FOverlayerAccessory.Visible = false;
         FOverlayerTreasure = new TOverlayerTreasure(this.Parent,CONST_MODULES.MODULE_BaiDuMM);
         FOverlayerTreasure.Visible = false;
         FOverlayerAppliance = new TOverlayerAppliance(this.Parent,CONST_MODULES.MODULE_BaiDuMM);
         FOverlayerAppliance.Visible = false;
         SetUIModuleID(CONST_MODULES.MODULE_BaiDuMM);
      }
      
      protected function PeiZhi() : void
      {
         this.AutoActivityGain = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BaiDuMM,10000001) as TBaiDuMM;
      }
      
      public function UpdateStuff() : void
      {
         this.FTempSelectInventoriesId.length = 0;
         this.FSelectInventories.Clear();
         this.FTempSelectInventoriesId.push(this.AutoActivityGain.RewardID);
         this.UnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,this.FSelectInventories,this.FTempSelectInventoriesId);
         this.FSlots.Context = this.FSelectInventories.GetInventoryByIndex(0);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_BAIDUMMQQ.Resource_Id);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.FMcPanel = TUtilityReflection.CreateDisplayObjectInstance(CONST_BAIDUMMQQ.Main_Panel) as Sprite;
         this.FMcPanel.x = (FUICore.StageWidth - this.FMcPanel.width) / 2;
         this.FMcPanel.y = (FUICore.StageHeight - this.FMcPanel.height) / 2;
         addChild(this.FMcPanel);
         this.FSlots = new TUISlot(this);
         this.FSlots.Resource = this.FMcPanel["MC_Slot_0"];
         this.FSlots.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
         this.FSlots.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
         this.FSlots.OnOverlay = this.SlotsOnOver;
         this.FSlots.OnOut = this.SlotsOnOut;
         this.FSlots.Init();
         this.TF_Money = this.FMcPanel["TF_Money"];
         this.FMC_MM_QQ = this.FMcPanel[CONST_BAIDUMMQQ.MM_QQ];
         this.FMC_MM_QQ.mouseEnabled = false;
         this.FBtn_Record = this.FMC_MM_QQ["Btn_Record"];
         this.FMC_Get_Reward = this.FMcPanel[CONST_BAIDUMMQQ.GET_Reward];
         TGameUtil.setButtonMode(this.FMC_Get_Reward,true);
         this.FBTN_GoMoney = this.FMcPanel[CONST_BAIDUMMQQ.GO_Money];
         this.FBTN_Close = this.FMcPanel["BTN_Close"];
         TGameUtil.setButtonMode(this.FBTN_GoMoney,true);
         this.FMC_Reward_Icon = this.FMcPanel[CONST_BAIDUMMQQ.MC_eFFECT];
         this.FMC_Reward_Icon.mouseEnabled = false;
         this.FMC_Reward_Icon.buttonMode = false;
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerEquipment);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerAccessory);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerTreasure);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerAppliance);
         super.ResourcesPerform_UIDispatch();
      }
      
      protected function SlotsOnOver(param1:Object, param2:Object) : void
      {
         var _loc3_:TInventory = null;
         var _loc4_:TOverlayer = null;
         _loc3_ = param2 as TInventory;
         switch(_loc3_.Category)
         {
            case CATEGORY_Equipment:
               _loc4_ = FOverlayerEquipment;
               break;
            case CATEGORY_Treasure:
               _loc4_ = FOverlayerTreasure;
               break;
            case CATEGORY_Accessories:
               _loc4_ = FOverlayerAccessory;
               break;
            default:
               _loc4_ = FOverlayerAppliance;
         }
         if(_loc4_ != null)
         {
            _loc4_.Context = _loc3_;
            _loc4_.Render(FUICore.MouseCoordinate);
            _loc4_.Show();
         }
      }
      
      protected function SlotsOnOut(param1:Object, param2:Object) : void
      {
         var _loc3_:TInventory = null;
         var _loc4_:TOverlayer = null;
         _loc3_ = param2 as TInventory;
         switch(_loc3_.Category)
         {
            case CATEGORY_Equipment:
               _loc4_ = FOverlayerEquipment;
               break;
            case CATEGORY_Treasure:
               _loc4_ = FOverlayerTreasure;
               break;
            case CATEGORY_Accessories:
               _loc4_ = FOverlayerAccessory;
               break;
            default:
               _loc4_ = FOverlayerAppliance;
         }
         if(_loc4_ != null)
         {
            _loc4_.Hide();
         }
      }
      
      public function setMMqqState(param1:Boolean) : void
      {
         if(this.FMC_MM_QQ)
         {
            this.FMC_MM_QQ.visible = param1;
         }
      }
      
      public function setGetRewardBtn(param1:Boolean) : void
      {
         this.FIsCanClick = param1;
         TGameUtil.setButtonMode(this.FMC_Get_Reward,param1);
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         super.LogicsPerform();
         if(this.visible)
         {
            if(this.FSlots)
            {
               this.FSlots.Update();
            }
         }
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FMC_Get_Reward.addEventListener(MouseEvent.CLICK,this.GetRewardClick);
         this.FBTN_GoMoney.addEventListener(MouseEvent.CLICK,this.GoMoneyClick);
         this.FBTN_Close.addEventListener(MouseEvent.CLICK,this.CloseMe);
         this.FBtn_Record.addEventListener(MouseEvent.CLICK,this.RecordClick);
         this.PeiZhi();
         this.UpdateStuff();
         this.setMMqqState(this.FIsMM_QQ);
         super.ResourcesPerform_UILocations();
      }
      
      public function GetRewardClick(param1:MouseEvent) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         if(!this.FIsCanClick)
         {
            return;
         }
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_BaiDuMM_RealGetReward_Req);
         _loc3_ = _loc2_.Data;
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      public function GoMoneyClick(param1:MouseEvent) : void
      {
         SExternalCore.NavigateToRecharge();
      }
      
      public function RecordClick(param1:MouseEvent) : void
      {
         System.setClipboard(STRING_BAIDUMM.MM_QQ);
         EffectGenerateText(STRING_BAIDUMM.MM_TIP);
      }
      
      public function CloseMe(param1:MouseEvent) : void
      {
         if(FOnClose != null)
         {
            FOnClose(this);
         }
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount();
         this.BaiDuSuperVip();
      }
      
      override public function Unmount() : void
      {
         super.Unmount();
      }
      
      public function BaiDuSuperVip() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_BaiDuMM_JIHUO_Req);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_BaiDuMM_GetReward_Req);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_BaiDuMM_JIHUO_Ret,this.PACKETID_SC_BaiDuMM_JIHUO_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_BaiDuMM_GetReward_Ret,this.PACKETID_SC_BaiDuMM_GetReward_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_BaiDuMM_RealGetReward_Ret,this.PACKETID_SC_BaiDuMM_RealGetReward_Ret);
      }
      
      public function PACKETID_SC_BaiDuMM_JIHUO_Ret(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:ByteArray = null;
         var _loc4_:int = 0;
         _loc3_ = param1.Data;
         _loc2_ = int(_loc3_.readUnsignedInt());
         if(_loc2_ != 0)
         {
            if(this.FsetFBaiDuMeimeiMcState != null)
            {
               this.FsetFBaiDuMeimeiMcState(false);
            }
            return;
         }
         _loc4_ = int(_loc3_.readUnsignedInt());
         if(_loc4_)
         {
            this.FIsMM_QQ = true;
         }
         else
         {
            this.FIsMM_QQ = false;
         }
         this.UpdateMM_QQ();
      }
      
      protected function UpdateMM_QQ() : void
      {
         this.setMMqqState(this.FIsMM_QQ);
      }
      
      public function PACKETID_SC_BaiDuMM_GetReward_Ret(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:ByteArray = null;
         var _loc4_:int = 0;
         _loc3_ = param1.Data;
         _loc2_ = int(_loc3_.readUnsignedInt());
         if(_loc2_ != 0)
         {
            if(this.FsetFBaiDuMeimeiMcState != null)
            {
               this.FsetFBaiDuMeimeiMcState(false);
            }
            return;
         }
         _loc4_ = int(_loc3_.readUnsignedInt());
         if(_loc4_ == 1)
         {
            this.setGetRewardBtn(true);
         }
         else if(_loc4_ == 2)
         {
            this.setGetRewardBtn(false);
            if(this.FsetFBaiDuMeimeiMcState != null)
            {
               this.FsetFBaiDuMeimeiMcState(false);
            }
         }
         else
         {
            this.setGetRewardBtn(false);
         }
      }
      
      public function PACKETID_SC_BaiDuMM_RealGetReward_Ret(param1:TPacket) : void
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
         EffectGenerateText(STRING_BAIDUMM.MM_Dec);
         this.setGetRewardBtn(false);
         if(this.FsetFBaiDuMeimeiMcState != null)
         {
            this.FsetFBaiDuMeimeiMcState(false);
         }
      }
      
      public function set setFBaiDuMeimeiMcState(param1:Function) : void
      {
         this.FsetFBaiDuMeimeiMcState = param1;
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
            _loc6_.LoadSecondary(_loc5_.IDTexture,CONST_MODULES.MODULE_BaiDuMM);
         }
      }
      
      protected function SlotsOnQuerySubscript(param1:Object, param2:Object, param3:TQueryString) : void
      {
         var _loc4_:TAppliance = null;
         if(param2 is TAppliance)
         {
            _loc4_ = param2 as TAppliance;
            param3.Value = _loc4_.Quantity.toString();
         }
      }
   }
}

