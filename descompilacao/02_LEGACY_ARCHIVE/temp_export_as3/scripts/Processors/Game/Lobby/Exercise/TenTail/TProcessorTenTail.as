package Processors.Game.Lobby.Exercise.TenTail
{
   import Components.Standard.TUITab;
   import Foundation.Common.TBounds;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.FrogWallet.TTenTail;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Exercise.TUnstreamizerTenTail;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import Rendering.Overlayers.Inventories.TOverlayerAccessory;
   import Rendering.Overlayers.Inventories.TOverlayerAppliance;
   import Rendering.Overlayers.Inventories.TOverlayerEquipment;
   import Rendering.Overlayers.Inventories.TOverlayerTreasure;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_INVENTORY;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_SHORTCUTS;
   import Resources.Constants.CONST_TENTAIL;
   import Resources.Strings.STRING_FROGWALLET;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class TProcessorTenTail extends TProcessorLobbyWindows
   {
      
      public static const TAB_TYPE_NINE:int = 0;
      
      public static const TAB_TYPE_TEN:int = 1;
      
      public static const CAPACITY_INVENTORIES:uint = CONST_COMMON.CAPACITY_INVENTORIES;
      
      public static const CATEGORY_Normal:uint = CONST_INVENTORY.CATEGORY_Normal;
      
      public static const CATEGORY_Equipment:uint = CONST_INVENTORY.CATEGORY_Equipment;
      
      public static const CATEGORY_Gem:uint = CONST_INVENTORY.CATEGORY_Gem;
      
      public static const CATEGORY_Treasure:uint = CONST_INVENTORY.CATEGORY_Treasure;
      
      public static const CATEGORY_Material:uint = CONST_INVENTORY.CATEGORY_Material;
      
      public static const CATEGORY_Accessories:uint = CONST_INVENTORY.CATEGORY_Accessories;
      
      protected var SIZE_WIDTH:int = 763;
      
      protected var SIZE_HEIGHT:int = 563;
      
      protected var FMC_Scene:Sprite;
      
      protected var FBtn_Close:SimpleButton;
      
      protected var FTF_Time:TextField;
      
      protected var FBtn_TabNine:MovieClip;
      
      protected var FBtn_TabTen:MovieClip;
      
      protected var FUITab:TUITab;
      
      protected var FTabVect:Vector.<MovieClip>;
      
      protected var FChangeTabIndex:int;
      
      protected var FBounds:TBounds;
      
      protected var FEndTime:int;
      
      protected var FEndTimeID:int;
      
      protected var FDelayTimeID:int;
      
      protected var FTenTail:TTenTail;
      
      protected var FProcessorWindowNineTail:TProcessorWindowNineTail;
      
      protected var FProcessorWindowTenTail:TProcessorWindowTenTail;
      
      protected var FUnstreamizerTenTail:TUnstreamizerTenTail;
      
      protected var FIndex:int;
      
      protected var FOnOpenActivity:Function;
      
      protected var FCheckEffect:Function;
      
      public function TProcessorTenTail(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FTenTail = SLogicsCore.TenTail;
         this.FUnstreamizerTenTail = new TUnstreamizerTenTail();
         this.FUITab = new TUITab(this);
         this.FTabVect = new Vector.<MovieClip>();
         this.FChangeTabIndex = 0;
         this.FBounds = new TBounds();
         this.FBounds.Width = this.SIZE_WIDTH;
         this.FBounds.Height = this.SIZE_HEIGHT;
         ComponentBoundsCenter(this,this.FBounds);
         SetUIModuleID(CONST_MODULES.ACTIVE_Test);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         super.ResourcesPerform_UIRequest();
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_TENTAIL.RESOURCESID_Swf_TenTail);
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         this.FMC_Scene = TUtilityReflection.CreateDisplayObjectInstance(CONST_TENTAIL.RESOURCE_ClassName_MC_TenTailMain) as Sprite;
         addChild(this.FMC_Scene);
         this.FBtn_Close = this.FMC_Scene[CONST_TENTAIL.RESOURCE_Link_BTN_Close];
         this.FTF_Time = this.FMC_Scene[CONST_TENTAIL.RESOURCE_LINK_TF_TIME];
         this.ResourcesPerform_UIDispatchWindow();
         this.ResourcesPerform_UIDispatchTab();
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
         super.ResourcesPerform_UIDispatch();
      }
      
      protected function ResourcesPerform_UIDispatchWindow() : void
      {
         this.FProcessorWindowNineTail = new TProcessorWindowNineTail(this);
         this.FProcessorWindowNineTail.Perform_UIDispatch(this.FMC_Scene[CONST_TENTAIL.RESOURCE_Link_MC_NineTail]);
         this.FProcessorWindowNineTail.Visible = false;
         this.FProcessorWindowTenTail = new TProcessorWindowTenTail(this);
         this.FProcessorWindowTenTail.Perform_UIDispatch(this.FMC_Scene[CONST_TENTAIL.RESOURCE_Link_MC_TenTail]);
         this.FProcessorWindowTenTail.Visible = false;
         this.FProcessorWindowTenTail.OnGetReward = this.PerformPacket_CS_GetRewardReq;
      }
      
      protected function ResourcesPerform_UIDispatchTab() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         this.FBtn_TabNine = this.FMC_Scene["Btn_TabNine"];
         this.FBtn_TabTen = this.FMC_Scene["Btn_TabTen"];
         addChild(this.FBtn_TabNine);
         addChild(this.FBtn_TabTen);
         this.FTabVect.push(this.FBtn_TabNine);
         this.FTabVect.push(this.FBtn_TabTen);
         _loc2_ = int(this.FTabVect.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.FUITab.SetTabByIndex(this.FTabVect[_loc1_],_loc1_);
            _loc1_++;
         }
         this.FUITab.OnSwitch = this.ChangeTabOnSwitch;
         this.FUITab.Init();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FBtn_Close.addEventListener(MouseEvent.CLICK,OnClose);
         super.ResourcesPerform_UILocations();
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         if(this.visible && Boolean(this.FMC_Scene))
         {
            this.FTF_Time.text = TGameUtil.fomatTime(this.FTenTail.EndTime - STimingCore.GetServerTick());
         }
      }
      
      protected function UpdateUI() : void
      {
         switch(this.FChangeTabIndex)
         {
            case TAB_TYPE_NINE:
               this.FProcessorWindowNineTail.UpdateUI();
               this.FProcessorWindowNineTail.Visible = true;
               this.FProcessorWindowTenTail.Visible = false;
               break;
            case TAB_TYPE_TEN:
               this.FProcessorWindowTenTail.UpdateUI();
               this.FProcessorWindowNineTail.Visible = false;
               this.FProcessorWindowTenTail.Visible = true;
         }
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         super.PacketRegisterRoutines();
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TenTail_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TenTail_OpenActivityRet,this.PerformPacket_SC_OpenActiveRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TenTail_GetRewardRet,this.PerformPacket_SC_GetRewardRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TenTail_ChangeStatusRet,this.PerformPacket_SC_ChangeStatusRet);
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
      
      protected function ProcessorCloseActivity() : void
      {
         SLogicsCore.NewActivityModes.SetActivityStatus(CONST_SHORTCUTS.TYPE_NewActiveList_TenTail,false);
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
         this.FTenTail.ChangeTabIndex = this.FChangeTabIndex;
         this.UpdateUI();
      }
      
      protected function PerformPacket_SC_OpenActiveRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:Boolean = false;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:TInventory = null;
         var _loc10_:TInventories = null;
         var _loc11_:Vector.<uint> = null;
         var _loc12_:Vector.<uint> = null;
         _loc2_ = param1.Data;
         _loc3_ = int(_loc2_.readUnsignedByte());
         _loc4_ = _loc3_ == 0 ? false : true;
         this.FTenTail.EndTime = this.FEndTime = _loc2_.readUnsignedInt();
         SLogicsCore.NewActivityModes.SetActivityStatus(CONST_SHORTCUTS.TYPE_NewActiveList_TenTail,_loc4_);
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
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TenTail_LoadInfoReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
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
         this.FUnstreamizerTenTail.Unstreamize(_loc2_,this.FTenTail,null);
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
         _loc4_ = this.FTenTail.RewardID[param1];
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TenTail_GetRewardReq);
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
            this.FProcessorWindowTenTail.BeClicked = false;
         }
         else
         {
            this.FProcessorWindowTenTail.BeClicked = false;
            this.FTenTail.RewardStatus[this.FIndex] = 1;
            _loc5_ = STRING_FROGWALLET.FORMAT_GET_SUCCESSED;
            _loc8_ = this.FTenTail.Rewards[this.FIndex];
            _loc7_ = _loc8_.Count;
            _loc6_ = 0;
            while(_loc6_ < _loc7_)
            {
               _loc5_ += _loc8_.GetInventoryByIndex(_loc6_).Name + "*" + _loc8_.GetInventoryByIndex(_loc6_).Quantity + "\n";
               _loc6_++;
            }
            this.ProcessorEffectText(_loc5_);
            this.FProcessorWindowTenTail.UpdateUI();
            this.CheckAwardStatus();
         }
      }
      
      protected function PerformPacket_SC_ChangeStatusRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = param1.Data;
         this.ProcessorCheckEffect(true);
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
         if(this.FTenTail.RewardStatus.indexOf(0) != -1)
         {
            this.ProcessorCheckEffect(true);
            return;
         }
         this.ProcessorCheckEffect(false);
      }
      
      protected function ProcessorCheckEffect(param1:Boolean) : void
      {
         if(this.FCheckEffect != null)
         {
            this.FCheckEffect(CONST_SHORTCUTS.POSITION_NewActiveList,CONST_SHORTCUTS.TYPE_NewActiveList_TenTail,param1);
         }
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
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount(param1);
         if(!FIsResourcesLoadCompleted)
         {
            return;
         }
         this.PerformPacket_CS_LoadInfoReq();
      }
      
      override public function Unmount() : void
      {
         super.Unmount();
      }
      
      public function TestInit0() : ByteArray
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc4_:Vector.<int> = null;
         var _loc5_:Vector.<int> = null;
         var _loc6_:Vector.<int> = null;
         var _loc7_:Vector.<int> = null;
         var _loc8_:Vector.<int> = null;
         var _loc9_:Vector.<int> = null;
         var _loc10_:Vector.<int> = null;
         var _loc3_:ByteArray = new ByteArray();
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeUnsignedInt(3);
         _loc3_.writeUnsignedInt(STimingCore.GetServerTick());
         _loc3_.writeUnsignedInt(STimingCore.GetServerTick() + 1000);
         _loc3_.writeUnsignedInt(STimingCore.GetServerTick() + 1000);
         TUtilityString.FlushUTF(_loc3_,"招募瞳兽");
         TUtilityString.FlushUTF(_loc3_,"招募瞳兽");
         TUtilityString.FlushUTF(_loc3_,"<font color=\"#ffffff\">九尾活动描述。</font>");
         TUtilityString.FlushUTF(_loc3_,"<font color=\"#ffffff\">十尾活动描述</font>");
         _loc3_.writeUnsignedInt(1000);
         _loc3_.writeUnsignedInt(1);
         _loc3_.writeUnsignedInt(10);
         _loc3_.writeUnsignedInt(1);
         _loc4_ = Vector.<int>([1,1,0,-1,0,0,0,0,0,0]);
         _loc10_ = Vector.<int>([1,1,1,1,2,2,2,3,3,4]);
         _loc3_.writeShort(_loc4_.length);
         _loc1_ = 0;
         while(_loc1_ < _loc4_.length)
         {
            _loc3_.writeUnsignedInt(_loc1_ + 1);
            _loc3_.writeByte(_loc4_[_loc1_]);
            _loc3_.writeUnsignedInt(_loc10_[_loc1_]);
            _loc1_++;
         }
         _loc5_ = Vector.<int>([1,10,100,200,300,500,1000,2000,3000]);
         _loc3_.writeShort(_loc5_.length);
         _loc1_ = 0;
         while(_loc1_ < _loc5_.length)
         {
            _loc3_.writeUnsignedInt(_loc5_[_loc1_]);
            _loc1_++;
         }
         _loc6_ = Vector.<int>([1,11,111,311,611,1111,2111,4111,7111]);
         _loc3_.writeShort(_loc6_.length);
         _loc1_ = 0;
         while(_loc1_ < _loc6_.length)
         {
            _loc3_.writeUnsignedInt(_loc6_[_loc1_]);
            _loc1_++;
         }
         _loc7_ = Vector.<int>([1,2,3,4,5,6,7,8,9]);
         _loc3_.writeShort(_loc7_.length);
         _loc1_ = 0;
         while(_loc1_ < _loc7_.length)
         {
            _loc3_.writeUnsignedInt(_loc7_[_loc1_]);
            _loc1_++;
         }
         _loc8_ = Vector.<int>([1,10,100,200,300,500,1000,2000,3000,5000]);
         _loc3_.writeShort(_loc8_.length);
         _loc1_ = 0;
         while(_loc1_ < _loc8_.length)
         {
            _loc3_.writeUnsignedInt(_loc8_[_loc1_]);
            _loc1_++;
         }
         _loc9_ = Vector.<int>([1,11,111,311,611,1111,3111,5111,8111,13111]);
         _loc3_.writeShort(_loc9_.length);
         _loc1_ = 0;
         while(_loc1_ < _loc9_.length)
         {
            _loc3_.writeUnsignedInt(_loc9_[_loc1_]);
            _loc1_++;
         }
         _loc3_.writeShort(10);
         _loc1_ = 0;
         while(_loc1_ < 10)
         {
            _loc3_.writeShort(2);
            _loc2_ = 0;
            while(_loc2_ < 2)
            {
               _loc3_.writeUnsignedInt(14100001 + _loc1_ + _loc2_);
               _loc3_.writeUnsignedInt(3);
               _loc2_++;
            }
            _loc1_++;
         }
         _loc3_.position = 0;
         return _loc3_;
      }
   }
}

