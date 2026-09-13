package Processors.Game.Lobby.OnLineLiBao
{
   import Components.Pages.TUIPage;
   import Components.Slots.TUISlot;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Queries.TQueryString;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.Repositories.TResourceRepositoryTexture;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Resources.Textures.TTexture;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.Json.TFixedAward;
   import Logics.DatebaseVO.VO.TDailyOnlineReward;
   import Logics.Inventories.TAppliance;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import Processors.Game.Lobby.TreasureMap.ConsumeFrameCopy;
   import Rendering.Overlayers.Inventories.TOverlayerAccessory;
   import Rendering.Overlayers.Inventories.TOverlayerAppliance;
   import Rendering.Overlayers.Inventories.TOverlayerEquipment;
   import Rendering.Overlayers.Inventories.TOverlayerTreasure;
   import Rendering.Overlayers.TOverlayer;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_INVENTORY;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Strings.STRING_UNDERTOWN;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   
   public class TProcessorOnLineLiBao extends TProcessorLobbyWindows
   {
      
      public static const Four:int = 4;
      
      public static const CATEGORY_Normal:uint = CONST_INVENTORY.CATEGORY_Normal;
      
      public static const CATEGORY_Equipment:uint = CONST_INVENTORY.CATEGORY_Equipment;
      
      public static const CATEGORY_Gem:uint = CONST_INVENTORY.CATEGORY_Gem;
      
      public static const CATEGORY_Treasure:uint = CONST_INVENTORY.CATEGORY_Treasure;
      
      public static const CATEGORY_Material:uint = CONST_INVENTORY.CATEGORY_Material;
      
      public static const CATEGORY_Accessories:uint = CONST_INVENTORY.CATEGORY_Accessories;
      
      protected var FMcPanel:MovieClip = null;
      
      protected var FBtn_Close:SimpleButton;
      
      protected var UnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FSelectInventories:TInventories;
      
      protected var FTempSelectInventoriesId:Vector.<uint>;
      
      protected var FTempSelectInventoriesCount:Vector.<uint>;
      
      protected var FSlotsVector:Vector.<TUISlot>;
      
      protected var FUIPage:TUIPage;
      
      protected var FPageIndex:uint;
      
      protected var FMC_Reward:MovieClip;
      
      protected var FMC_GetReward:MovieClip;
      
      protected var FMC_Over:MovieClip;
      
      protected var FMC_Time:MovieClip;
      
      protected var FTF_Time:TextField;
      
      protected var FIsInilization:Boolean;
      
      protected var FCurOnLinedTime:uint;
      
      protected var FRewardIsGet:Boolean;
      
      protected var FLimitTime:uint;
      
      protected var FIconIsShow:Function;
      
      public function TProcessorOnLineLiBao(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FTempSelectInventoriesCount = new Vector.<uint>();
         this.FTempSelectInventoriesId = new Vector.<uint>();
         this.FSelectInventories = new TInventories();
         this.UnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         this.FSlotsVector = new Vector.<TUISlot>(Four);
         this.FUIPage = new TUIPage(this);
         FOverlayerEquipment = new TOverlayerEquipment(this.Parent,CONST_MODULES.MODULE_OnLineLiBao);
         FOverlayerEquipment.Visible = false;
         FOverlayerAccessory = new TOverlayerAccessory(this.Parent,CONST_MODULES.MODULE_OnLineLiBao);
         FOverlayerAccessory.Visible = false;
         FOverlayerTreasure = new TOverlayerTreasure(this.Parent,CONST_MODULES.MODULE_OnLineLiBao);
         FOverlayerTreasure.Visible = false;
         FOverlayerAppliance = new TOverlayerAppliance(this.Parent,CONST_MODULES.MODULE_OnLineLiBao);
         FOverlayerAppliance.Visible = false;
         SetUIModuleID(CONST_MODULES.MODULE_OnLineLiBao);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(1308622848);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:uint = 0;
         super.LogicsPerform();
         if(!this.FIsInilization)
         {
            return;
         }
         if(this.visible)
         {
            _loc1_ = 0;
            while(_loc1_ < Four)
            {
               this.FSlotsVector[_loc1_].Update();
               _loc1_++;
            }
         }
         _loc1_ = STimingCore.GetServerTick() + this.FCurOnLinedTime;
         if(_loc1_ >= this.FLimitTime)
         {
            if(_loc1_ == this.FLimitTime)
            {
               this.UpdateView();
               this.FTF_Time.text = new ConsumeFrameCopy(STRING_UNDERTOWN.STRING_UNDERTOWN_26).DescribeString;
            }
            return;
         }
         this.FTF_Time.text = TUtilityString.Format(new ConsumeFrameCopy(STRING_UNDERTOWN.STRING_UNDERTOWN_27).DescribeString,TGameUtil.fomatTime(this.FLimitTime - _loc1_));
      }
      
      protected function UpdateView() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < Four)
         {
            _loc2_ = this.FPageIndex * Four + _loc1_;
            if(_loc2_ >= this.FSelectInventories.Count)
            {
               this.FSlotsVector[_loc1_].Context = null;
            }
            else
            {
               this.FSlotsVector[_loc1_].Context = this.FSelectInventories.GetInventoryByIndex(_loc2_);
            }
            _loc1_++;
         }
         this.FMC_Over.visible = false;
         this.FMC_Reward.visible = false;
         this.FMC_Time.visible = false;
         TGameUtil.setButtonMode(this.FMC_GetReward,false);
         if(!this.FLimitTime)
         {
            this.FMC_Over.visible = true;
            this.FMC_GetReward.visible = false;
         }
         else
         {
            this.FMC_GetReward.visible = true;
            _loc1_ = STimingCore.GetServerTick() + this.FCurOnLinedTime;
            if(_loc1_ >= this.FLimitTime)
            {
               TGameUtil.setButtonMode(this.FMC_GetReward,true);
            }
            else
            {
               this.FMC_Time.visible = true;
            }
            this.FMC_Reward.visible = true;
         }
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FMC_GetReward.addEventListener(MouseEvent.CLICK,this.BtnClick);
         this.FBtn_Close.addEventListener(MouseEvent.CLICK,this.BtnClick);
         super.ResourcesPerform_UILocations();
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_S2C_OnLineLiBao_InforMation,this.PACKETID_S2C_OnLineLiBao_InforMation);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_S2C_OnLineLiBao_Get_Award,this.PACKETID_S2C_OnLineLiBao_Get_Award);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_S2C_OnLineLiBao_IsOpen,this.PACKETID_S2C_OnLineLiBao_IsOpen);
      }
      
      public function PACKETID_S2C_OnLineLiBao_InforMation(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:ByteArray = null;
         var _loc4_:uint = 0;
         var _loc5_:Boolean = false;
         var _loc6_:TBins = null;
         var _loc7_:TDailyOnlineReward = null;
         var _loc8_:TFixedAward = null;
         var _loc9_:TBins = null;
         _loc3_ = param1.Data;
         _loc4_ = _loc3_.readUnsignedInt();
         this.FRewardIsGet = Boolean(_loc4_);
         if(this.FIconIsShow != null)
         {
            this.FIconIsShow(this.FRewardIsGet);
         }
         _loc4_ = _loc3_.readUnsignedInt();
         _loc6_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_DailyOnlineReward);
         _loc7_ = _loc6_.GetDatebaseByIdentifier(_loc4_) as TDailyOnlineReward;
         this.FCurOnLinedTime = _loc3_.readUnsignedInt();
         SLogicsCore.ZhenAoYiLogicData.OnLineGiftCurTime = this.FCurOnLinedTime;
         if(!_loc7_)
         {
            this.FLimitTime = 0;
            this.FIconIsShow(false);
            if(this.FMC_GetReward)
            {
               this.FMC_GetReward.visible = false;
               this.FMC_Reward.visible = false;
               this.FMC_Time.visible = false;
            }
            return;
         }
         this.FLimitTime = _loc7_.NeedTime;
         this.FLimitTime = STimingCore.GetServerTick() + this.FLimitTime;
         SLogicsCore.ZhenAoYiLogicData.OnLineGiftTime = this.FLimitTime;
         if(!this.FIsInilization)
         {
            return;
         }
         _loc9_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         this.FTempSelectInventoriesId.length = 0;
         this.FTempSelectInventoriesCount.length = 0;
         this.FSelectInventories.Clear();
         _loc4_ = 0;
         while(_loc4_ < _loc7_.RewardVector.length)
         {
            _loc8_ = _loc7_.RewardVector[_loc4_];
            this.FTempSelectInventoriesId.push(CONST_COMMON.GetItemIDByType(_loc8_.Type,_loc8_.Code,_loc9_));
            this.FTempSelectInventoriesCount.push(_loc8_.Amount);
            _loc4_++;
         }
         this.UnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,this.FSelectInventories,this.FTempSelectInventoriesId);
         _loc4_ = 0;
         while(_loc4_ < this.FSelectInventories.Count)
         {
            this.FSelectInventories.GetInventoryByIndex(_loc4_).Quantity = this.FTempSelectInventoriesCount[_loc4_];
            _loc4_++;
         }
         this.UpdateView();
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount();
         if(!FIsResourcesLoadCompleted)
         {
            return;
         }
         this.OnLine_Req();
      }
      
      override public function Unmount() : void
      {
         super.Unmount();
      }
      
      public function set IconIsShow(param1:Function) : void
      {
         this.FIconIsShow = param1;
      }
      
      protected function UpdatePage() : void
      {
         this.FPageIndex = 0;
         this.FUIPage.TotalQuantity = this.FSelectInventories.Count;
         this.FUIPage.PageIndex = this.FPageIndex;
         this.FUIPage.Update();
      }
      
      public function PACKETID_S2C_OnLineLiBao_Get_Award(param1:TPacket) : void
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
         this.OnLine_Req();
      }
      
      public function PACKETID_S2C_OnLineLiBao_IsOpen(param1:TPacket) : void
      {
         if(this.FIconIsShow != null)
         {
            this.FIconIsShow(true);
         }
      }
      
      protected function BtnClick(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case this.FMC_GetReward:
               if(this.FMC_GetReward.buttonMode)
               {
                  this.GetReward_Req();
               }
               break;
            case this.FBtn_Close:
               if(FOnClose != null)
               {
                  FOnClose(this);
               }
         }
      }
      
      protected function GetReward_Req() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_C2S_OnLineLiBao_Get_Award);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function OnLine_Req() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_C2S_OnLineLiBao_InforMation);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PageOnChange(param1:Object, param2:int) : void
      {
         if(param2 == this.FPageIndex)
         {
            return;
         }
         this.FPageIndex = param2;
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:TUISlot = null;
         var _loc2_:int = 0;
         this.FMcPanel = TUtilityReflection.CreateDisplayObjectInstance("MC_YouYiSiMang") as MovieClip;
         this.FMcPanel.x = (FUICore.StageWidth - this.FMcPanel.width) / 2;
         this.FMcPanel.y = (FUICore.StageHeight - this.FMcPanel.height) / 2;
         addChild(this.FMcPanel);
         _loc1_ = new TUISlot(this);
         this.FMC_Reward = this.FMcPanel["MC_Reward"];
         _loc2_ = 0;
         while(_loc2_ < Four)
         {
            _loc1_ = new TUISlot(this);
            _loc1_.Resource = this.FMC_Reward["MC_Slot_" + _loc2_];
            _loc1_.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
            _loc1_.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
            _loc1_.OnQuerySubscript = this.SlotsOnQuerySubscript;
            _loc1_.OnOverlay = this.SlotsOnOver;
            _loc1_.OnOut = this.SlotsOnOut;
            _loc1_.Init();
            this.FSlotsVector[_loc2_] = _loc1_;
            _loc2_++;
         }
         this.FMC_GetReward = this.FMcPanel["MC_GetReward"];
         this.FMC_Over = this.FMcPanel["MC_Over"];
         this.FMC_Over.mouseEnabled = false;
         this.FMC_Time = this.FMcPanel["MC_Time"];
         this.FMC_Time.mouseEnabled = false;
         this.FMC_Time.mouseChildren = false;
         this.FTF_Time = this.FMC_Time["TF_Time"];
         this.FBtn_Close = this.FMcPanel["Btn_Close"];
         this.FUIPage.ButtonPrevious.Substrate = this.FMC_Reward["BTN_Left"];
         this.FUIPage.ButtonNext.Substrate = this.FMC_Reward["BTN_Right"];
         this.FUIPage.PageSize = Four;
         this.FUIPage.Init();
         this.FUIPage.OnChangePage = this.PageOnChange;
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerEquipment);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerEquipment);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerAccessory);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerTreasure);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerAppliance);
         this.FIsInilization = true;
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
            _loc6_.LoadSecondary(_loc5_.IDTexture,CONST_MODULES.MODULE_OnLineLiBao);
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

