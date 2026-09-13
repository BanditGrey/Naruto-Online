package Processors.Game.Lobby.SystemActivity
{
   import Components.Standard.TUITab;
   import Foundation.Common.TBounds;
   import Foundation.Common.THint;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.SLogicsCore;
   import Logics.Streamization.SystemActivity.TUnstreamizerSystemActivity;
   import Logics.SystemActivity.TSystemActivities;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import Rendering.Overlayers.Hints.TOverlayerHint;
   import Rendering.Overlayers.Inventories.TOverlayerAccessory;
   import Rendering.Overlayers.Inventories.TOverlayerAppliance;
   import Rendering.Overlayers.Inventories.TOverlayerEquipment;
   import Rendering.Overlayers.Inventories.TOverlayerTreasure;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_INVENTORY;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_SHORTCUTS;
   import Resources.Constants.CONST_SYSTEMACTIVITY;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   import flash.utils.clearInterval;
   import flash.utils.clearTimeout;
   import flash.utils.setInterval;
   import flash.utils.setTimeout;
   
   public class TProcessorSystemActivity extends TProcessorLobbyWindows
   {
      
      public static const CAPACITY_INVENTORIES:uint = CONST_COMMON.CAPACITY_INVENTORIES;
      
      public static const CATEGORY_Normal:uint = CONST_INVENTORY.CATEGORY_Normal;
      
      public static const CATEGORY_Equipment:uint = CONST_INVENTORY.CATEGORY_Equipment;
      
      public static const CATEGORY_Gem:uint = CONST_INVENTORY.CATEGORY_Gem;
      
      public static const CATEGORY_Treasure:uint = CONST_INVENTORY.CATEGORY_Treasure;
      
      public static const CATEGORY_Material:uint = CONST_INVENTORY.CATEGORY_Material;
      
      public static const CATEGORY_Accessories:uint = CONST_INVENTORY.CATEGORY_Accessories;
      
      protected var SIZE_WIDTH:int = 915;
      
      protected var SIZE_HEIGHT:int = 556;
      
      protected var FProcessorWindowSystemActivity:TProcessorWindowSystemActivity;
      
      protected var FBounds:TBounds;
      
      protected var FMC_Scene:Sprite;
      
      protected var FBtn_Close:SimpleButton;
      
      protected var FMC_EffectLeft:MovieClip;
      
      protected var FMC_EffectRight:MovieClip;
      
      protected var FUITab:TUITab;
      
      protected var FTabList:Vector.<MovieClip>;
      
      protected var FBtn_TabFreeLottery:MovieClip;
      
      protected var FBtn_TabGoldLottery:MovieClip;
      
      protected var FBtn_TabStorage:MovieClip;
      
      protected var FChangeTabIndex:int;
      
      protected var FUnstreamizerSystemActivity:TUnstreamizerSystemActivity;
      
      protected var FSystemActivities:TSystemActivities;
      
      protected var FTimeID:int;
      
      protected var FEndTime:int;
      
      protected var FEndTimeID:int;
      
      protected var FDelayTimeID:int;
      
      protected var FOnOpenActivity:Function;
      
      protected var FOnGoto:Function;
      
      public function TProcessorSystemActivity(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FUnstreamizerSystemActivity = new TUnstreamizerSystemActivity();
         this.FSystemActivities = SLogicsCore.SystemActivities;
         this.FProcessorWindowSystemActivity = new TProcessorWindowSystemActivity(this);
         this.FProcessorWindowSystemActivity.OnOverlay = UIComponentsHintOnOver;
         this.FProcessorWindowSystemActivity.OnOut = UIComponentsHintOnOut;
         this.FProcessorWindowSystemActivity.TipOnOver = this.TipOnOver;
         this.FProcessorWindowSystemActivity.TipOnOut = this.TipOnOut;
         this.FProcessorWindowSystemActivity.OnGoto = this.ProcessorOnGoto;
         this.FTabList = new Vector.<MovieClip>();
         this.FUITab = new TUITab(this);
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
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_SYSTEMACTIVITY.RESOURCESID_Swf_SystemActivity);
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         this.FMC_Scene = TUtilityReflection.CreateDisplayObjectInstance(CONST_SYSTEMACTIVITY.RESOURCE_ClassName_MC_SystemActivity) as Sprite;
         addChild(this.FMC_Scene);
         this.FMC_EffectLeft = this.FMC_Scene[CONST_SYSTEMACTIVITY.RESOURCE_Link_MC_EffectLeft];
         this.FMC_EffectRight = this.FMC_Scene[CONST_SYSTEMACTIVITY.RESOURCE_Link_MC_EffectRight];
         this.FBtn_Close = this.FMC_Scene[CONST_SYSTEMACTIVITY.RESOURCE_Link_BTN_Close];
         _loc2_ = CONST_SYSTEMACTIVITY.TOTAL_ACTIVITY_COUNT;
         this.FTabList.length = 0;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FMC_Scene[CONST_SYSTEMACTIVITY.RESOURCE_Link_MC_Tab + _loc1_];
            this.FTabList.push(_loc3_);
            this.FUITab.SetTabByIndex(_loc3_,_loc1_);
            _loc1_++;
         }
         this.FUITab.Init();
         this.FUITab.OnSwitch = this.ChangeTabOnSwitch;
         this.FProcessorWindowSystemActivity.Perform_UIDispatch(this.FMC_Scene[CONST_SYSTEMACTIVITY.RESOURCE_Link_MC_Activity]);
         addChild(this.FProcessorWindowSystemActivity);
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
         FOverlayerHint = new TOverlayerHint(this.Parent);
         FOverlayerHint.visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerHint);
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FBtn_Close.addEventListener(MouseEvent.CLICK,OnClose);
         super.ResourcesPerform_UILocations();
      }
      
      protected function UpdateTab() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         _loc2_ = int(this.FTabList.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FTabList[_loc1_];
            if(_loc1_ < this.FSystemActivities.SystemActivity.length)
            {
               _loc3_.visible = true;
               _loc3_[CONST_SYSTEMACTIVITY.RESOURCE_LINK_TF_TITLE].text = this.FSystemActivities.GetSystemActivityByIndex(_loc1_).ActivityTabName;
            }
            else
            {
               _loc3_.visible = false;
            }
            _loc1_++;
         }
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         super.PacketRegisterRoutines();
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_SystemActivity_OpenActivityRet,this.PerformPacket_SC_OpenActiveRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_SystemActivity_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
      }
      
      protected function ProcessorDelayCloseActivity() : void
      {
         if(this.FEndTimeID != 0)
         {
            clearTimeout(this.FEndTimeID);
            this.FEndTimeID = 0;
         }
         var _loc1_:Number = (this.FSystemActivities.EndTime - STimingCore.GetServerTick()) * 1000;
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
         SLogicsCore.NewActivityModes.SetActivityStatus(CONST_SHORTCUTS.TYPE_NewActiveList_SystemActivity,false);
         if(this.Visible)
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
      
      protected function PerformPacket_CS_LoadInfoReq() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_SystemActivity_LoadInfoReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PerformPacket_SC_OpenActiveRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = param1.Data;
         var _loc3_:int = int(_loc2_.readUnsignedByte());
         var _loc4_:Boolean = _loc3_ == 0 ? false : true;
         this.FSystemActivities.EndTime = _loc2_.readUnsignedInt();
         SLogicsCore.NewActivityModes.SetActivityStatus(CONST_SHORTCUTS.TYPE_NewActiveList_SystemActivity,_loc4_);
         if(!_loc4_ && this.Visible)
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
      
      protected function PerformPacket_SC_LoadInfoRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = param1.Data;
         var _loc3_:int = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            ProcessorClose();
            return;
         }
         this.FUnstreamizerSystemActivity.Unstreamize(_loc2_,this.FSystemActivities,null);
         SLogicsCore.SystemActivities = this.FSystemActivities;
         if(FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowSystemActivity.Visible = true;
            this.UpdateTab();
            this.FProcessorWindowSystemActivity.UpdateUI();
         }
      }
      
      protected function ChangeTabOnSwitch(param1:Object) : void
      {
         var _loc2_:int = param1 as int;
         this.FProcessorWindowSystemActivity.ChangeTabOnSwitch(_loc2_);
      }
      
      protected function TipOnOver(param1:Object, param2:THint) : void
      {
         FOverlayerHint.Context = param2;
         FOverlayerHint.Render(FUICore.MouseCoordinate);
         FOverlayerHint.Show();
      }
      
      protected function TipOnOut(param1:Object) : void
      {
         FOverlayerHint.Hide();
      }
      
      protected function ProcessorOnGoto(param1:Object, param2:uint) : void
      {
         if(this.FOnGoto != null)
         {
            this.FOnGoto(this,param2);
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
      
      public function get OnGoto() : Function
      {
         return this.FOnGoto;
      }
      
      public function set OnGoto(param1:Function) : void
      {
         this.FOnGoto = param1;
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount(param1);
         if(!FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowSystemActivity.Load();
            return;
         }
         this.PerformPacket_CS_LoadInfoReq();
         if(this.FTimeID == 0)
         {
            this.FTimeID = setInterval(this.PerformPacket_CS_LoadInfoReq,5 * 60 * 1000);
         }
      }
      
      override public function Unmount() : void
      {
         if(this.FTimeID != 0)
         {
            clearInterval(this.FTimeID);
            this.FTimeID = 0;
         }
         super.Unmount();
      }
      
      public function TestInit() : ByteArray
      {
         var _loc2_:int = 0;
         var _loc1_:ByteArray = new ByteArray();
         var _loc3_:Array = [{
            "Identify":1,
            "ActivityName":"围剿兽灵第一人",
            "ActivityTabName":"围剿兽灵",
            "ActivityDesc":"活动描述1",
            "BeginTime":1370251120,
            "EndTime":1370683120,
            "Inventories":[14100009,14100010,14100011,14100012,14800001,14800002],
            "Count":[1,2,3,4,5,6],
            "ActivityData":[{
               "OrganzationName":"orgname1",
               "OrganzationLevel":10,
               "OrganzationLeader":"leader1",
               "FamilyType":1,
               "ActivityDate":1,
               "HurtScore":10001,
               "FightResult":1
            }]
         },{
            "Identify":2,
            "ActivityName":"天下第一组织",
            "ActivityTabName":"天下第一",
            "ActivityDesc":"活动描述2",
            "BeginTime":1370251120,
            "EndTime":1370596720,
            "Inventories":[14100017,14100010,14100011,14100012,14800001,14800003],
            "Count":[1,2,3,4,5,7],
            "ActivityData":[{
               "OrganzationName":"orgname2",
               "OrganzationLevel":11,
               "OrganzationLeader":"leader2",
               "FamilyType":2,
               "ActivityDate":1,
               "HurtScore":10000,
               "FightResult":0
            }]
         },{
            "Identify":3,
            "ActivityName":"木叶争霸我做主",
            "ActivityTabName":"木叶争霸",
            "ActivityDesc":"活动描述3",
            "BeginTime":1370251120,
            "EndTime":1370510320,
            "Inventories":[14100028,14100010,14100011,14100012,14800001,14800004],
            "Count":[1,2,3,4,5,8],
            "ActivityData":[{
               "OrganzationName":"orgname3",
               "OrganzationLevel":12,
               "OrganzationLeader":"leader3",
               "FamilyType":3,
               "ActivityDate":1,
               "HurtScore":9999,
               "FightResult":1
            }]
         },{
            "Identify":4,
            "ActivityName":"木叶守卫攻防战",
            "ActivityTabName":"木叶守卫",
            "ActivityDesc":"活动描述4",
            "BeginTime":1370251120,
            "EndTime":1370423920,
            "Inventories":[14800005,14100010,14100011,14100012,14800001,14800005],
            "Count":[1,2,3,4,5,9],
            "ActivityData":[{
               "OrganzationName":"orgname4",
               "OrganzationLevel":13,
               "OrganzationLeader":"leader4",
               "FamilyType":2,
               "ActivityDate":1,
               "HurtScore":9998,
               "FightResult":0
            }]
         }];
         _loc1_.writeShort(_loc3_.length);
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_.length)
         {
            _loc1_.writeUnsignedInt(_loc3_[_loc4_].Identify);
            TUtilityString.FlushUTF(_loc1_,_loc3_[_loc4_].ActivityName);
            TUtilityString.FlushUTF(_loc1_,_loc3_[_loc4_].ActivityTabName);
            TUtilityString.FlushUTF(_loc1_,_loc3_[_loc4_].ActivityDesc);
            _loc1_.writeUnsignedInt(_loc3_[_loc4_].BeginTime);
            _loc1_.writeUnsignedInt(_loc3_[_loc4_].EndTime);
            _loc1_.writeShort(_loc3_[_loc4_].Inventories.length);
            _loc2_ = 0;
            while(_loc2_ < _loc3_[_loc4_].Inventories.length)
            {
               _loc1_.writeUnsignedInt(_loc3_[_loc4_].Inventories[_loc2_]);
               _loc2_++;
            }
            _loc1_.writeShort(_loc3_[_loc4_].Count.length);
            _loc2_ = 0;
            while(_loc2_ < _loc3_[_loc4_].Count.length)
            {
               _loc1_.writeUnsignedInt(_loc3_[_loc4_].Count[_loc2_]);
               _loc2_++;
            }
            _loc1_.writeShort(_loc3_[_loc4_].ActivityData.length);
            _loc2_ = 0;
            while(_loc2_ < _loc3_[_loc4_].ActivityData.length)
            {
               TUtilityString.FlushUTF(_loc1_,_loc3_[_loc4_].ActivityData[_loc2_].OrganzationName);
               _loc1_.writeUnsignedInt(_loc3_[_loc4_].ActivityData[_loc2_].OrganzationLevel);
               TUtilityString.FlushUTF(_loc1_,_loc3_[_loc4_].ActivityData[_loc2_].OrganzationLeader);
               _loc1_.writeUnsignedInt(_loc3_[_loc4_].ActivityData[_loc2_].FamilyType);
               _loc1_.writeUnsignedInt(_loc3_[_loc4_].ActivityData[_loc2_].ActivityDate);
               _loc1_.writeUnsignedInt(_loc3_[_loc4_].ActivityData[_loc2_].HurtScore);
               _loc1_.writeUnsignedInt(_loc3_[_loc4_].ActivityData[_loc2_].FightResult);
               _loc2_++;
            }
            _loc4_++;
         }
         _loc1_.position = 0;
         return _loc1_;
      }
   }
}

