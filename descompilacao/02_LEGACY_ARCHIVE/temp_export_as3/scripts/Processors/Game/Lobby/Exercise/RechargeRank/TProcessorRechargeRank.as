package Processors.Game.Lobby.Exercise.RechargeRank
{
   import Components.Standard.TUITab;
   import Foundation.Common.TBounds;
   import Foundation.Common.THint;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.ConsumeRank.TPerReward;
   import Logics.Exercise.RechargeRank.TRechargeRank;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.SLogicsCore;
   import Logics.Streamization.Exercise.TUnstreamizerRechargeRank;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorWindowDesc;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorWindowEquipDesc;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorWindowPetDesc;
   import Processors.Game.Lobby.Tavern.TProcessorWindowRecruit;
   import Rendering.Overlayers.HelpTips.TOverlayerHelpTips;
   import Rendering.Overlayers.Inventories.TOverlayerAccessory;
   import Rendering.Overlayers.Inventories.TOverlayerAppliance;
   import Rendering.Overlayers.Inventories.TOverlayerEquipment;
   import Rendering.Overlayers.Inventories.TOverlayerTreasure;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_INVENTORY;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_RECHARGERANK;
   import Resources.Constants.CONST_SHORTCUTS;
   import Resources.Strings.STRING_RECHARGERANK;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   import flash.utils.clearInterval;
   import flash.utils.clearTimeout;
   import flash.utils.setInterval;
   import flash.utils.setTimeout;
   
   public class TProcessorRechargeRank extends TProcessorLobbyWindows
   {
      
      public static const TAB_TYPE_TOTAL_RANK:int = 0;
      
      public static const TAB_TYPE_POINT_REWARD:int = 1;
      
      public static const BOX_COUNT:int = 4;
      
      protected static const MIN_SCROLL_HEIGHT:Number = 457;
      
      protected static const ITEM_STAMP:Number = -1;
      
      protected static const SINGLE_ITEM_STAMP:Number = 66;
      
      protected static const ITEM_HEIGHT:Number = 66;
      
      public static const WINDOW_TITLE_DESC_NEW:int = 10;
      
      public static const WINDOW_HERO_DESC_NEW:int = 11;
      
      public static const WINDOW_PET_DESC_NEW:int = 12;
      
      protected static const INIT_X:Number = 0;
      
      protected static const INIT_Y:Number = 2;
      
      public static const CAPACITY_INVENTORIES:uint = CONST_COMMON.CAPACITY_INVENTORIES;
      
      public static const CATEGORY_Normal:uint = CONST_INVENTORY.CATEGORY_Normal;
      
      public static const CATEGORY_Equipment:uint = CONST_INVENTORY.CATEGORY_Equipment;
      
      public static const CATEGORY_Gem:uint = CONST_INVENTORY.CATEGORY_Gem;
      
      public static const CATEGORY_Treasure:uint = CONST_INVENTORY.CATEGORY_Treasure;
      
      public static const CATEGORY_Material:uint = CONST_INVENTORY.CATEGORY_Material;
      
      public static const CATEGORY_Accessories:uint = CONST_INVENTORY.CATEGORY_Accessories;
      
      protected var SIZE_WIDTH:int = 918;
      
      protected var SIZE_HEIGHT:int = 556;
      
      protected var FMC_Scene:Sprite;
      
      protected var FBtn_Close:SimpleButton;
      
      protected var FTF_Time:TextField;
      
      protected var FBtn_TabTotalRank:MovieClip;
      
      protected var FBtn_TabPointReward:MovieClip;
      
      protected var FTab_RechargeRank:TUITab;
      
      protected var FTabVect:Vector.<MovieClip>;
      
      protected var FBounds:TBounds;
      
      protected var FEndTime:int;
      
      protected var FTimeID:int;
      
      protected var FEndTimeID:int;
      
      protected var FDelayTimeID:int;
      
      protected var FProcessorWindowTotalRank:TProcessorWindowTotalRank;
      
      protected var FProcessorWindowPointReward:TProcessorWindowPointReward;
      
      protected var FUnstreamizerRechargeRank:TUnstreamizerRechargeRank;
      
      protected var FChangeTabIndex:int;
      
      protected var FRechargeRank:TRechargeRank;
      
      protected var FIndex:int;
      
      protected var FProcessorWindowDesc:TProcessorWindowDesc;
      
      protected var FProcessorWindowEquip:TProcessorWindowEquipDesc;
      
      protected var FProcessorWindowHeroDesc:TProcessorWindowRecruit;
      
      protected var FProcessorWindowPetDesc:TProcessorWindowPetDesc;
      
      protected var FRefreshTime:int;
      
      protected var FOnOpenActivity:Function;
      
      protected var FCheckEffect:Function;
      
      protected var FOnShowHeroInfo:Function;
      
      public function TProcessorRechargeRank(param1:TUIComponent, param2:TLobbyParameters, param3:uint = 0)
      {
         super(param1,param2);
         this.FUnstreamizerRechargeRank = new TUnstreamizerRechargeRank();
         this.FRechargeRank = SLogicsCore.RechargeRank;
         this.FTab_RechargeRank = new TUITab(this);
         this.FTabVect = new Vector.<MovieClip>();
         this.FChangeTabIndex = 0;
         this.FRechargeRank.ChangeTabIndex = this.FChangeTabIndex;
         this.FBounds = new TBounds();
         this.FBounds.Width = this.SIZE_WIDTH;
         this.FBounds.Height = this.SIZE_HEIGHT;
         ComponentBoundsCenter(this,this.FBounds);
         FHtmlHint = new THint();
         SetUIModuleID(CONST_MODULES.ACTIVE_Test);
         this.FProcessorWindowDesc = new TProcessorWindowDesc(this.Parent);
         this.FProcessorWindowEquip = new TProcessorWindowEquipDesc(this.Parent);
         this.FProcessorWindowHeroDesc = new TProcessorWindowRecruit(this.Parent);
         this.FProcessorWindowPetDesc = new TProcessorWindowPetDesc(this.Parent);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         super.ResourcesPerform_UIRequest();
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_RECHARGERANK.RESOURCESID_Swf_RechargeRank);
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         this.FMC_Scene = TUtilityReflection.CreateDisplayObjectInstance(CONST_RECHARGERANK.RESOURCE_ClassName_MC_RechargeRank) as Sprite;
         this.addChild(this.FMC_Scene);
         this.FBtn_Close = this.FMC_Scene[CONST_RECHARGERANK.RESOURCE_Link_BTN_Close];
         this.FTF_Time = this.FMC_Scene[CONST_RECHARGERANK.RESOURCE_LINK_TF_TIME];
         this.ResourcesPerform_UIDispatchTab();
         this.ResourcesPerform_UIDispatchWindow();
         FOverlayerEquipment = new TOverlayerEquipment(this.Parent,CONST_MODULES.ACTIVE_Test);
         FOverlayerEquipment.Visible = false;
         FOverlayerTreasure = new TOverlayerTreasure(this.Parent,CONST_MODULES.ACTIVE_Test);
         FOverlayerTreasure.Visible = false;
         FOverlayerAppliance = new TOverlayerAppliance(this.Parent,CONST_MODULES.ACTIVE_Test);
         FOverlayerAppliance.Visible = false;
         FOverlayerAccessory = new TOverlayerAccessory(this.Parent,CONST_MODULES.ACTIVE_Test);
         FOverlayerAccessory.Visible = false;
         FOverlayerHelpTips = new TOverlayerHelpTips(this.Parent);
         FOverlayerHelpTips.Visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerEquipment);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerTreasure);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerAppliance);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerAccessory);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerHelpTips);
         if(this.FMC_Scene["MC_Pop0"])
         {
            this.FMC_Scene["MC_Pop0"].addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnPopOver);
            this.FMC_Scene["MC_Pop0"].addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnPopOut);
         }
         if(this.FMC_Scene["MC_Pop1"])
         {
            this.FMC_Scene["MC_Pop1"].addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnPopOver);
            this.FMC_Scene["MC_Pop1"].addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnPopOut);
         }
         this.FProcessorWindowDesc.OnCloseUp = this.ProcessorOnCloseDesc;
         this.FProcessorWindowDesc.Visible = false;
         this.FProcessorWindowEquip.OnCloseUp = this.ProcessorOnHideOtherWindow;
         this.FProcessorWindowEquip.OnOverlay = UIComponentsHintOnOver;
         this.FProcessorWindowEquip.OnOut = UIComponentsHintOnOut;
         this.FProcessorWindowEquip.Visible = false;
         this.FProcessorWindowHeroDesc.Visible = false;
         this.FProcessorWindowHeroDesc.OnEffectText = FOnEffectText;
         this.FProcessorWindowHeroDesc.HintOnOver = ProcessorTipOnOver;
         this.FProcessorWindowHeroDesc.HintOnOut = ProcessorTipOnOut;
         this.FProcessorWindowHeroDesc.x = (CONST_COMMON.STAGE_Width - 390) / 2;
         this.FProcessorWindowHeroDesc.y = (CONST_COMMON.STAGE_Height - 358) / 2;
         this.FProcessorWindowPetDesc.Visible = false;
         this.FProcessorWindowPetDesc.x = (CONST_COMMON.STAGE_Width - 699) / 2;
         this.FProcessorWindowPetDesc.y = (CONST_COMMON.STAGE_Height - 379) / 2;
         super.ResourcesPerform_UIDispatch();
      }
      
      protected function ResourcesPerform_UIDispatchTab() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         this.FBtn_TabTotalRank = this.FMC_Scene[CONST_RECHARGERANK.RESOURCE_Link_Btn_TabTotalRank];
         this.FBtn_TabPointReward = this.FMC_Scene[CONST_RECHARGERANK.RESOURCE_Link_Btn_TabPointReward];
         this.FTabVect.push(this.FBtn_TabTotalRank);
         this.FTabVect.push(this.FBtn_TabPointReward);
         _loc2_ = int(this.FTabVect.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.FTab_RechargeRank.SetTabByIndex(this.FTabVect[_loc1_],_loc1_);
            _loc1_++;
         }
         this.FTab_RechargeRank.OnSwitch = this.ChangeTabOnSwitch;
         this.FTab_RechargeRank.Init();
      }
      
      protected function ResourcesPerform_UIDispatchWindow() : void
      {
         this.FProcessorWindowTotalRank = new TProcessorWindowTotalRank(this);
         this.FProcessorWindowTotalRank.OnShowRecruit = this.ProcessorOnShowItemDesc;
         this.FProcessorWindowTotalRank.OnShowEquip = this.ProcessorOnShowOtherWindow;
         this.FProcessorWindowTotalRank.OnOverlay = UIComponentsHintOnOver;
         this.FProcessorWindowTotalRank.OnOut = UIComponentsHintOnOut;
         this.FProcessorWindowTotalRank.Perform_UIDispatch(this.FMC_Scene[CONST_RECHARGERANK.RESOURCE_ClassName_MC_TotalRank]);
         this.FProcessorWindowTotalRank.Visible = false;
         this.FProcessorWindowPointReward = new TProcessorWindowPointReward(this);
         this.FProcessorWindowPointReward.OnOverlay = UIComponentsHintOnOver;
         this.FProcessorWindowPointReward.OnOut = UIComponentsHintOnOut;
         this.FProcessorWindowPointReward.OnGetReward = this.PerformPacket_CS_GetRewardReq;
         this.FProcessorWindowPointReward.Perform_UIDispatch(this.FMC_Scene[CONST_RECHARGERANK.RESOURCE_ClassName_MC_PointReward]);
         this.FProcessorWindowPointReward.Visible = false;
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FBtn_Close.addEventListener(MouseEvent.CLICK,OnClose);
         if(this.FMC_Scene["BTN_Help"] != null)
         {
            this.FMC_Scene["BTN_Help"].addEventListener(MouseEvent.MOUSE_MOVE,this.ButtonHelpOnOver,false,0,true);
            this.FMC_Scene["BTN_Help"].addEventListener(MouseEvent.MOUSE_OUT,this.ProcessorOnPopOut,false,0,true);
         }
         TGameUtil.setButtonMode(this.FMC_Scene["BTN_Desc"],true);
         this.FMC_Scene["BTN_Desc"].addEventListener(MouseEvent.CLICK,this.ProcessorOnShowDesc,false,0,true);
         super.ResourcesPerform_UILocations();
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         if(this.visible && Boolean(this.FMC_Scene))
         {
            this.FTF_Time.text = TGameUtil.fomatTime(this.FRechargeRank.PayEndTime - STimingCore.GetServerTick());
            if(this.FProcessorWindowPetDesc != null && this.FProcessorWindowPetDesc.Visible == true)
            {
               this.FProcessorWindowPetDesc.UpdataBitmap();
            }
            if(this.FProcessorWindowHeroDesc != null && this.FProcessorWindowHeroDesc.Visible == true)
            {
               this.FProcessorWindowHeroDesc.UpdataBitmap();
            }
         }
      }
      
      protected function UpdateUI() : void
      {
         switch(this.FChangeTabIndex)
         {
            case TAB_TYPE_TOTAL_RANK:
               this.FProcessorWindowTotalRank.UpdateUI();
               this.FProcessorWindowTotalRank.Visible = true;
               this.FProcessorWindowPointReward.Visible = false;
               break;
            case TAB_TYPE_POINT_REWARD:
               this.FProcessorWindowPointReward.UpdateUI();
               this.FProcessorWindowTotalRank.Visible = false;
               this.FProcessorWindowPointReward.Visible = true;
         }
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         super.PacketRegisterRoutines();
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_RechargeRank_OpenActivityRet,this.PerformPacket_SC_OpenActiveRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_RechargeRank_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_RechargeRank_LoadRewardRet,this.PerformPacket_SC_LoadRewardRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_RechargeRank_GetRewardRet,this.PerformPacket_SC_GetRewardRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_RechargeRank_ChangeStatusRet,this.PerformPacket_SC_ChangeStatusRet);
      }
      
      protected function ProcessorDelayCloseActivity() : void
      {
         if(this.FEndTimeID != 0)
         {
            clearTimeout(this.FEndTimeID);
            this.FEndTimeID = 0;
         }
         var _loc1_:Number = (this.FEndTime - STimingCore.GetServerTick()) * 1000;
         if(_loc1_ < 0)
         {
            _loc1_ = 0;
         }
         if(_loc1_ > int.MAX_VALUE)
         {
            _loc1_ = int.MAX_VALUE;
         }
         this.FEndTimeID = setTimeout(this.ProcessorCloseActivity,_loc1_);
         clearTimeout(this.FDelayTimeID);
      }
      
      protected function ProcessorOnShowDesc(param1:MouseEvent) : void
      {
         this.FProcessorWindowDesc.BaseActivity = this.FRechargeRank;
         this.FProcessorWindowDesc.Visible = true;
         this.FProcessorWindowDesc.UpdateUI(this.FRechargeRank.ActivityDesc);
      }
      
      protected function ProcessorOnCloseDesc() : void
      {
         this.FProcessorWindowDesc.Visible = false;
      }
      
      public function ProcessorOnShowItemDesc(param1:uint, param2:int = 0) : void
      {
         if(param2 == TBaseBox.TYPE_IS_HERO)
         {
            this.FProcessorWindowHeroDesc.SetHeroData(param1);
         }
         else if(param2 == TBaseBox.TYPE_IS_PET)
         {
            this.FProcessorWindowPetDesc.SetPetData(param1);
         }
      }
      
      public function ProcessorOnHideItemDesc(param1:int) : void
      {
         if(param1 == WINDOW_HERO_DESC_NEW)
         {
            this.FProcessorWindowHeroDesc.visible = false;
         }
         else if(param1 == WINDOW_PET_DESC_NEW)
         {
            this.FProcessorWindowPetDesc.visible = false;
         }
      }
      
      public function ProcessorOnShowOtherWindow(param1:TInventories) : void
      {
         this.FProcessorWindowEquip.Visible = true;
         this.FProcessorWindowEquip.UpdateUI(param1);
      }
      
      protected function ProcessorOnHideOtherWindow(param1:int = 0) : void
      {
         this.FProcessorWindowEquip.Visible = false;
      }
      
      protected function ProcessorCloseActivity() : void
      {
         SLogicsCore.NewActivityModes.SetActivityStatus(CONST_SHORTCUTS.TYPE_NewActiveList_RechargeRank,false);
         if(this.visible)
         {
            ProcessorClose();
         }
         if(this.FOnOpenActivity != null)
         {
            this.FOnOpenActivity();
         }
         clearTimeout(this.FEndTimeID);
         this.FEndTimeID = 0;
      }
      
      protected function ChangeTabOnSwitch(param1:Object) : void
      {
         var _loc2_:int = param1 as int;
         if(_loc2_ == this.FChangeTabIndex)
         {
            return;
         }
         this.FChangeTabIndex = _loc2_;
         this.FRechargeRank.ChangeTabIndex = this.FChangeTabIndex;
         switch(this.FChangeTabIndex)
         {
            case TAB_TYPE_TOTAL_RANK:
               this.PerformPacket_CS_LoadInfoReq();
               break;
            case TAB_TYPE_POINT_REWARD:
               this.PerformPacket_CS_LoadRewardReq();
         }
      }
      
      protected function PerformPacket_SC_OpenActiveRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = param1.Data;
         var _loc3_:int = int(_loc2_.readUnsignedByte());
         var _loc4_:Boolean = _loc3_ == 0 ? false : true;
         this.FEndTime = _loc2_.readUnsignedInt();
         SLogicsCore.NewActivityModes.SetActivityStatus(CONST_SHORTCUTS.TYPE_NewActiveList_RechargeRank,_loc4_);
         if(!_loc4_ && this.visible)
         {
            ProcessorClose();
         }
         if(this.FOnOpenActivity != null)
         {
            this.FOnOpenActivity();
         }
         if(this.FDelayTimeID != 0)
         {
            clearTimeout(this.FDelayTimeID);
            this.FDelayTimeID = 0;
         }
         this.FDelayTimeID = setTimeout(this.ProcessorDelayCloseActivity,10 * 1000);
      }
      
      protected function PerformPacket_CS_LoadInfoReq() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         if(this.FChangeTabIndex != TAB_TYPE_TOTAL_RANK)
         {
            return;
         }
         if(this.FRefreshTime <= STimingCore.GetServerTick())
         {
            _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_RechargeRank_LoadInfoReq);
            _loc2_ = _loc1_.Data;
            _loc2_.writeInt(1);
            SNetworkCore.Transceiver.PacketTransmit(_loc1_);
            this.FRefreshTime = 0;
         }
         else if(FIsResourcesLoadCompleted)
         {
            this.visible = true;
            this.UpdateUI();
         }
      }
      
      protected function PerformPacket_SC_LoadInfoRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = param1.Data;
         var _loc3_:int = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         this.FUnstreamizerRechargeRank.Unstreamize(_loc2_,this.FRechargeRank,null);
         if(FIsResourcesLoadCompleted)
         {
            this.visible = true;
            this.UpdateUI();
         }
      }
      
      protected function PerformPacket_CS_LoadRewardReq() : void
      {
         var _loc1_:TPacket = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_RechargeRank_LoadRewardReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PerformPacket_SC_LoadRewardRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = param1.Data;
         var _loc3_:int = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         this.FUnstreamizerRechargeRank.Unstreamize(_loc2_,this.FRechargeRank,null);
         if(FIsResourcesLoadCompleted)
         {
            this.visible = true;
            this.UpdateUI();
         }
      }
      
      protected function PerformPacket_CS_GetRewardReq(param1:int) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         var _loc4_:int = 0;
         this.FIndex = param1;
         _loc4_ = this.FRechargeRank.PerRewardList[param1].Identify;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_RechargeRank_GetRewardReq);
         _loc3_ = _loc2_.Data;
         _loc3_.writeInt(_loc4_);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function PerformPacket_SC_GetRewardRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:String = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:TInventories = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
         }
         else
         {
            this.FRechargeRank.PerRewardList[this.FIndex].Status = 1;
            this.FRechargeRank.CheckAwardStatus();
            this.CheckAwardStatus();
            _loc5_ = STRING_RECHARGERANK.FORMAT_GET_SUCCESSED;
            _loc8_ = this.FRechargeRank.PerRewardList[this.FIndex].Inventories;
            _loc7_ = _loc8_.Count;
            _loc6_ = 0;
            while(_loc6_ < _loc7_)
            {
               _loc5_ += _loc8_.GetInventoryByIndex(_loc6_).Name + "*" + _loc8_.GetInventoryByIndex(_loc6_).Quantity + "\n";
               _loc6_++;
            }
            this.ProcessorEffectText(_loc5_);
            this.UpdateUI();
         }
      }
      
      protected function PerformPacket_SC_ChangeStatusRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:String = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:TInventories = null;
         _loc2_ = param1.Data;
         this.FRechargeRank.PerScore = _loc2_.readInt();
         if(this.FRechargeRank.PerRewardList.length == 0)
         {
            this.ProcessorCheckEffect(true);
         }
         else
         {
            this.FRechargeRank.CheckAwardStatus();
            this.CheckAwardStatus();
         }
      }
      
      protected function ProcessorEffectText(param1:String) : void
      {
         if(FOnEffectText != null)
         {
            FOnEffectText(this,param1);
         }
      }
      
      protected function CheckAwardStatus() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TPerReward = null;
         _loc2_ = int(this.FRechargeRank.PerRewardList.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FRechargeRank.PerRewardList[_loc1_];
            if(_loc3_.Status == 0)
            {
               this.ProcessorCheckEffect(true);
               return;
            }
            _loc1_++;
         }
         this.ProcessorCheckEffect(false);
         if(this.visible && this.FChangeTabIndex == TAB_TYPE_POINT_REWARD)
         {
            this.UpdateUI();
         }
      }
      
      protected function ProcessorCheckEffect(param1:Boolean) : void
      {
         if(this.FCheckEffect != null)
         {
            this.FCheckEffect(CONST_SHORTCUTS.POSITION_NewActiveList,CONST_SHORTCUTS.TYPE_NewActiveList_RechargeRank,param1);
         }
      }
      
      protected function ProcessorOnPopOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(6));
         FHtmlHint.Content = null;
         if(_loc2_ == 0)
         {
            FHtmlHint.Content = this.FRechargeRank.Desc5.split("%n%").join("\n");
         }
         else
         {
            FHtmlHint.Content = this.FRechargeRank.Desc6.split("%n%").join("\n");
         }
         FOverlayerHelpTips.Context = FHtmlHint;
         FOverlayerHelpTips.Render(FUICore.MouseCoordinate);
         FOverlayerHelpTips.Show();
      }
      
      protected function ProcessorOnPopOut(param1:MouseEvent) : void
      {
         FOverlayerHelpTips.Hide();
      }
      
      protected function ButtonHelpOnOver(param1:MouseEvent) : void
      {
         FHtmlHint = new THint();
         FHtmlHint.Content = this.FRechargeRank.Desc7;
         FOverlayerHelpTips.Context = FHtmlHint;
         FOverlayerHelpTips.Render(FUICore.MouseCoordinate);
         FOverlayerHelpTips.Show();
      }
      
      public function get OnOpenActivity() : Function
      {
         return this.FOnOpenActivity;
      }
      
      public function set OnOpenActivity(param1:Function) : void
      {
         this.FOnOpenActivity = param1;
      }
      
      public function get CheckEffect() : Function
      {
         return this.FCheckEffect;
      }
      
      public function set CheckEffect(param1:Function) : void
      {
         this.FCheckEffect = param1;
      }
      
      public function get OnShowHeroInfo() : Function
      {
         return this.FOnShowHeroInfo;
      }
      
      public function set OnShowHeroInfo(param1:Function) : void
      {
         this.FOnShowHeroInfo = param1;
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount(param1);
         if(!FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowDesc.Load();
            this.FProcessorWindowEquip.Load();
            this.FProcessorWindowHeroDesc.Load();
            return;
         }
         if(this.FChangeTabIndex == TAB_TYPE_TOTAL_RANK)
         {
            this.PerformPacket_CS_LoadInfoReq();
         }
         else
         {
            this.PerformPacket_CS_LoadRewardReq();
         }
         if(this.FTimeID == 0)
         {
            this.FTimeID = setInterval(this.PerformPacket_CS_LoadInfoReq,5 * 60 * 1000);
         }
      }
      
      override public function Unmount() : void
      {
         super.Unmount();
         if(this.FTimeID != 0)
         {
            clearInterval(this.FTimeID);
            this.FTimeID = 0;
         }
      }
      
      public function TestInit0() : ByteArray
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:ByteArray = new ByteArray();
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeUnsignedInt(5);
         _loc3_.writeUnsignedInt(1371571200);
         _loc3_.writeUnsignedInt(1371572200);
         _loc3_.writeUnsignedInt(STimingCore.GetServerTick() + 1000);
         TUtilityString.FlushUTF(_loc3_,"跨服消费排行");
         TUtilityString.FlushUTF(_loc3_,"跨服消费排行2");
         _loc3_.writeUnsignedInt(51);
         _loc3_.writeUnsignedInt(1000);
         _loc3_.writeUnsignedInt(200);
         _loc3_.writeShort(50);
         _loc1_ = 0;
         while(_loc1_ < 50)
         {
            _loc3_.writeUnsignedInt(0);
            _loc3_.writeUnsignedInt(0);
            _loc3_.writeUnsignedInt(_loc1_ + 1);
            TUtilityString.FlushUTF(_loc3_,"aaa" + _loc1_);
            _loc3_.writeUnsignedInt(_loc1_ + 100);
            _loc3_.writeUnsignedInt(_loc1_ + 1);
            _loc1_++;
         }
         if(this.FRechargeRank.NeedConfig)
         {
            _loc3_.writeShort(7);
            _loc1_ = 0;
            while(_loc1_ < 7)
            {
               _loc3_.writeUnsignedInt(_loc1_ + 1);
               _loc3_.writeUnsignedInt(_loc1_ + 2);
               _loc3_.writeUnsignedInt(_loc1_ + 1);
               _loc3_.writeUnsignedInt(14100046);
               _loc1_++;
            }
         }
         _loc3_.position = 0;
         return _loc3_;
      }
      
      public function TestInit1() : ByteArray
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:ByteArray = new ByteArray();
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeUnsignedInt(100);
         _loc3_.writeShort(7);
         _loc1_ = 0;
         while(_loc1_ < 7)
         {
            _loc3_.writeUnsignedInt(_loc1_ + 100);
            _loc3_.writeUnsignedInt(0);
            _loc3_.writeUnsignedInt(_loc1_ + 1);
            _loc3_.writeShort(4);
            _loc2_ = 0;
            while(_loc2_ < 4)
            {
               _loc3_.writeUnsignedInt(14100001 + _loc1_);
               _loc3_.writeUnsignedInt(1);
               _loc2_++;
            }
            _loc1_++;
         }
         _loc3_.position = 0;
         return _loc3_;
      }
   }
}

