package Processors.Game.Lobby.Exercise.CommonRecharge
{
   import Components.Standard.TUITab;
   import Foundation.Common.TBounds;
   import Foundation.Network.TPacket;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.CommonRecharge.TCommonRecharge;
   import Logics.Exercise.ConsumeRank.TPerReward;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import Rendering.Overlayers.Inventories.TOverlayerAccessory;
   import Rendering.Overlayers.Inventories.TOverlayerAppliance;
   import Rendering.Overlayers.Inventories.TOverlayerEquipment;
   import Rendering.Overlayers.Inventories.TOverlayerTreasure;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_COMMONRECHARGE;
   import Resources.Constants.CONST_INVENTORY;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_SHORTCUTS;
   import Resources.Strings.STRING_BASEACTIVITY;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class TProcessorCommonRecharge extends TProcessorLobbyWindows
   {
      
      public static const TAB_TYPE_INTRODUCE:int = 0;
      
      public static const TAB_TYPE_SINGLE:int = 1;
      
      public static const TAB_TYPE_ACCUMULATE:int = 2;
      
      public static const ACTIVITY_ID_1:int = CONST_COMMONRECHARGE.ACTIVITY_ID_1;
      
      public static const ACTIVITY_ID_2:int = CONST_COMMONRECHARGE.ACTIVITY_ID_2;
      
      public static const ACTIVITY_ID_3:int = CONST_COMMONRECHARGE.ACTIVITY_ID_3;
      
      public static const ACTIVITY_ID_4:int = CONST_COMMONRECHARGE.ACTIVITY_ID_4;
      
      public static const ACTIVITY_ID_5:int = CONST_COMMONRECHARGE.ACTIVITY_ID_5;
      
      public static const ACTIVITY_ID_6:int = CONST_COMMONRECHARGE.ACTIVITY_ID_6;
      
      public static const ACTIVITY_ID_7:int = CONST_COMMONRECHARGE.ACTIVITY_ID_7;
      
      public static const CAPACITY_INVENTORIES:uint = CONST_COMMON.CAPACITY_INVENTORIES;
      
      public static const CATEGORY_Normal:uint = CONST_INVENTORY.CATEGORY_Normal;
      
      public static const CATEGORY_Equipment:uint = CONST_INVENTORY.CATEGORY_Equipment;
      
      public static const CATEGORY_Gem:uint = CONST_INVENTORY.CATEGORY_Gem;
      
      public static const CATEGORY_Treasure:uint = CONST_INVENTORY.CATEGORY_Treasure;
      
      public static const CATEGORY_Material:uint = CONST_INVENTORY.CATEGORY_Material;
      
      public static const CATEGORY_Accessories:uint = CONST_INVENTORY.CATEGORY_Accessories;
      
      public static const BTN_X:Vector.<int> = Vector.<int>([531,427,324]);
      
      protected var SIZE_WIDTH:int = 724;
      
      protected var SIZE_HEIGHT:int = 460;
      
      protected var FMC_Scene:Sprite;
      
      protected var FBtn_Close:SimpleButton;
      
      protected var FTF_Time:TextField;
      
      protected var FTF_Date:TextField;
      
      protected var FTF_Rate:TextField;
      
      protected var FMC_Time:MovieClip;
      
      protected var FMC_Date:MovieClip;
      
      protected var FBtn_TabIntroduce:MovieClip;
      
      protected var FBtn_TabSingle:MovieClip;
      
      protected var FBtn_TabAccumulate:MovieClip;
      
      protected var FUITab:TUITab;
      
      protected var FTabVect:Vector.<MovieClip>;
      
      protected var FChangeTabIndex:int;
      
      protected var FTF_Tittle:TextField;
      
      protected var FBounds:TBounds;
      
      protected var FEndTime:int;
      
      protected var FEndTimeID:int;
      
      protected var FDelayTimeID:int;
      
      protected var FCommonRecharge:TCommonRecharge;
      
      protected var FProcessorWindowIntroduce:TProcessorWindowIntroduce;
      
      protected var FProcessorWindowSingle:TProcessorWindowSingle;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FBtnCount:int;
      
      protected var FOnOpenActivity:Function;
      
      protected var FCheckEffect:Function;
      
      public function TProcessorCommonRecharge(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FCommonRecharge = SLogicsCore.CommonRecharge;
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
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
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_COMMONRECHARGE.RESOURCESID_SWF_CommonRecharge);
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         this.FMC_Scene = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMONRECHARGE.RESOURCE_ClassName_CommonRecharge) as Sprite;
         addChild(this.FMC_Scene);
         this.FBtn_Close = this.FMC_Scene[CONST_COMMONRECHARGE.RESOURCE_Link_BTN_Close];
         this.ResourcesPerform_UIDispatchWindow();
         this.ResourcesPerform_UIDispatchTab();
         this.FMC_Time = this.FMC_Scene["MC_Time"] as MovieClip;
         this.FTF_Time = this.FMC_Time[CONST_COMMONRECHARGE.RESOURCE_LINK_TF_TIME];
         this.FMC_Date = this.FMC_Scene["MC_Date"];
         this.FTF_Date = this.FMC_Date["TF_Date"];
         this.FTF_Rate = this.FMC_Scene["TF_Rate"];
         addChild(this.FMC_Time);
         addChild(this.FMC_Date);
         addChild(this.FTF_Rate);
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
      
      protected function ResourcesPerform_UIDispatchTab() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         this.FBtn_TabIntroduce = this.FMC_Scene[CONST_COMMONRECHARGE.RESOURCE_Link_Btn_TabIntroduce];
         this.FBtn_TabSingle = this.FMC_Scene[CONST_COMMONRECHARGE.RESOURCE_Link_Btn_TabSingle];
         this.FBtn_TabAccumulate = this.FMC_Scene[CONST_COMMONRECHARGE.RESOURCE_Link_Btn_TabAccumulate];
         addChild(this.FBtn_TabIntroduce);
         addChild(this.FBtn_TabSingle);
         addChild(this.FBtn_TabAccumulate);
         this.FTabVect.push(this.FBtn_TabIntroduce);
         this.FTabVect.push(this.FBtn_TabSingle);
         this.FTabVect.push(this.FBtn_TabAccumulate);
         _loc2_ = int(this.FTabVect.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.FUITab.SetTabByIndex(this.FTabVect[_loc1_],_loc1_);
            _loc1_++;
         }
         this.FUITab.OnSwitch = this.ChangeTabOnSwitch;
         this.FUITab.Init();
         this.FTF_Tittle = this.FMC_Scene["MC_Tittle"]["TF_Title"];
      }
      
      protected function ResourcesPerform_UIDispatchWindow() : void
      {
         this.FProcessorWindowIntroduce = new TProcessorWindowIntroduce(this);
         this.FProcessorWindowIntroduce.Perform_UIDispatch(this.FMC_Scene[CONST_COMMONRECHARGE.RESOURCE_LINK_MC_Introduce]);
         this.FProcessorWindowIntroduce.Visible = false;
         this.FProcessorWindowSingle = new TProcessorWindowSingle(this);
         this.FProcessorWindowSingle.OnOverlay = UIComponentsHintOnOver;
         this.FProcessorWindowSingle.OnOut = UIComponentsHintOnOut;
         this.FProcessorWindowSingle.Perform_UIDispatch(this.FMC_Scene[CONST_COMMONRECHARGE.RESOURCE_LINK_MC_SingleRecharge]);
         this.FProcessorWindowSingle.Visible = false;
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
            this.FTF_Time.text = TGameUtil.fomatTime(this.FCommonRecharge.EndTime - STimingCore.GetServerTick());
         }
      }
      
      protected function UpdateUI() : void
      {
         this.FTF_Tittle.text = this.FCommonRecharge.Title;
         switch(this.FChangeTabIndex)
         {
            case TAB_TYPE_INTRODUCE:
               this.FProcessorWindowIntroduce.UpdateUI();
               this.FProcessorWindowIntroduce.Visible = true;
               this.FProcessorWindowSingle.Visible = false;
               break;
            case TAB_TYPE_SINGLE:
               this.FProcessorWindowSingle.UpdateUI();
               this.FProcessorWindowIntroduce.Visible = false;
               this.FProcessorWindowSingle.Visible = true;
               break;
            case TAB_TYPE_ACCUMULATE:
               this.FProcessorWindowSingle.UpdateUI();
               this.FProcessorWindowIntroduce.Visible = false;
               this.FProcessorWindowSingle.Visible = true;
         }
         this.UpdateText();
         this.UpdateBtn();
      }
      
      protected function UpdateText() : void
      {
         switch(this.FChangeTabIndex)
         {
            case TAB_TYPE_INTRODUCE:
               this.FMC_Date.visible = true;
               this.FTF_Rate.visible = true;
               this.FTF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_OnlyTime,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FCommonRecharge.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FCommonRecharge.EndTime) - 1) * 1000)));
               this.FTF_Rate.text = this.FCommonRecharge.Rate;
               break;
            case TAB_TYPE_SINGLE:
               this.FProcessorWindowSingle.UpdateUI();
               this.FProcessorWindowIntroduce.Visible = false;
               this.FProcessorWindowSingle.Visible = true;
               this.FMC_Date.visible = false;
               this.FTF_Rate.visible = false;
               break;
            case TAB_TYPE_ACCUMULATE:
               this.FProcessorWindowSingle.UpdateUI();
               this.FProcessorWindowIntroduce.Visible = false;
               this.FProcessorWindowSingle.Visible = true;
               this.FMC_Date.visible = false;
               this.FTF_Rate.visible = false;
         }
      }
      
      protected function UpdateBtn() : void
      {
         this.FBtnCount = 1;
         if(this.FCommonRecharge.SingleInventories.length > 0)
         {
            ++this.FBtnCount;
            this.FBtn_TabSingle.visible = true;
         }
         else
         {
            this.FBtn_TabSingle.visible = false;
         }
         if(this.FCommonRecharge.AccumulateInventories.length > 0)
         {
            if(this.FBtnCount == 2)
            {
               this.FBtn_TabAccumulate.x = 324;
            }
            else
            {
               this.FBtn_TabAccumulate.x = 427;
            }
            ++this.FBtnCount;
            this.FBtn_TabAccumulate.visible = true;
         }
         else
         {
            this.FBtn_TabAccumulate.visible = false;
         }
         if(this.FBtnCount == 1)
         {
            this.FBtn_TabIntroduce.x = 531;
         }
         else if(this.FBtnCount == 2)
         {
            this.FBtn_TabIntroduce.x = 427;
            if(this.FCommonRecharge.SingleInventories.length > 0)
            {
               this.FBtn_TabSingle.x = 531;
            }
            else
            {
               this.FBtn_TabAccumulate.x = 531;
            }
         }
         else
         {
            this.FBtn_TabIntroduce.x = 324;
            this.FBtn_TabSingle.x = 427;
            this.FBtn_TabAccumulate.x = 531;
         }
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         super.PacketRegisterRoutines();
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_DragonBoat_OpenActivityRet,this.PerformPacket_SC_OpenActiveRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_DragonBoat_ChangeStatusRet,this.PerformPacket_SC_ChangeStatusRet);
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
         var _loc1_:uint = 0;
         switch(this.FCommonRecharge.Identify)
         {
            case ACTIVITY_ID_1:
               _loc1_ = CONST_SHORTCUTS.TYPE_NewActiveList_DragonBoat;
               break;
            case ACTIVITY_ID_2:
               _loc1_ = CONST_SHORTCUTS.TYPE_NewActiveList_DragonBoat2;
               break;
            case ACTIVITY_ID_3:
               _loc1_ = CONST_SHORTCUTS.TYPE_NewActiveList_DragonBoat3;
               break;
            case ACTIVITY_ID_4:
               _loc1_ = CONST_SHORTCUTS.TYPE_NewActiveList_DragonBoat4;
               break;
            case ACTIVITY_ID_5:
               _loc1_ = CONST_SHORTCUTS.TYPE_NewActiveList_DragonBoat5;
               break;
            case ACTIVITY_ID_6:
               _loc1_ = CONST_SHORTCUTS.TYPE_NewActiveList_DragonBoat6;
               break;
            case ACTIVITY_ID_7:
               _loc1_ = CONST_SHORTCUTS.TYPE_NewActiveList_DragonBoat7;
         }
         SLogicsCore.NewActivityModes.SetActivityStatus(_loc1_,false);
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
         this.FCommonRecharge.ChangeTabIndex = this.FChangeTabIndex;
         switch(this.FChangeTabIndex)
         {
            case TAB_TYPE_INTRODUCE:
               this.FProcessorWindowIntroduce.UpdateUI();
               this.FProcessorWindowIntroduce.Visible = true;
               this.FProcessorWindowSingle.Visible = false;
               break;
            case TAB_TYPE_SINGLE:
               this.FProcessorWindowSingle.UpdateUI();
               this.FProcessorWindowIntroduce.Visible = false;
               this.FProcessorWindowSingle.Visible = true;
               break;
            case TAB_TYPE_ACCUMULATE:
               this.FProcessorWindowSingle.UpdateUI();
               this.FProcessorWindowIntroduce.Visible = false;
               this.FProcessorWindowSingle.Visible = true;
         }
         this.UpdateText();
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
         var _loc13_:TPerReward = null;
         var _loc14_:int = 0;
         _loc2_ = param1.Data;
         _loc3_ = int(_loc2_.readUnsignedByte());
         _loc4_ = _loc3_ == 0 ? false : true;
         this.FCommonRecharge.BeginTime = _loc2_.readUnsignedInt();
         this.FCommonRecharge.EndTime = this.FEndTime = _loc2_.readUnsignedInt();
         this.FCommonRecharge.Rate = TUtilityString.FetchUTF(_loc2_);
         this.FCommonRecharge.GotoURL = TUtilityString.FetchUTF(_loc2_);
         this.FCommonRecharge.Title = TUtilityString.FetchUTF(_loc2_);
         this.FCommonRecharge.PicID = _loc2_.readUnsignedInt();
         this.FCommonRecharge.Identify = _loc2_.readUnsignedInt();
         this.FCommonRecharge.Gold = _loc2_.readUnsignedInt();
         this.FCommonRecharge.TabID.length = 0;
         _loc7_ = int(_loc2_.readUnsignedShort());
         _loc5_ = 0;
         while(_loc5_ < _loc7_)
         {
            this.FCommonRecharge.TabID.push(_loc2_.readUnsignedInt());
            _loc5_++;
         }
         _loc11_ = new Vector.<uint>();
         _loc12_ = new Vector.<uint>();
         this.FCommonRecharge.SingleInventories.length = 0;
         _loc7_ = int(_loc2_.readUnsignedShort());
         _loc5_ = 0;
         while(_loc5_ < _loc7_)
         {
            _loc13_ = new TPerReward();
            _loc13_.MinValue = _loc2_.readUnsignedInt();
            _loc13_.MaxValue = _loc2_.readUnsignedInt();
            _loc8_ = int(_loc2_.readUnsignedShort());
            _loc11_.length = 0;
            _loc12_.length = 0;
            _loc6_ = 0;
            while(_loc6_ < _loc8_)
            {
               _loc11_.push(_loc2_.readUnsignedInt());
               _loc12_.push(_loc2_.readUnsignedInt());
               _loc6_++;
            }
            _loc10_ = new TInventories();
            this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc10_,_loc11_);
            _loc6_ = 0;
            while(_loc6_ < _loc8_)
            {
               _loc9_ = _loc10_.GetInventoryByIndex(_loc6_);
               _loc9_.Quantity = _loc12_[_loc6_];
               _loc6_++;
            }
            _loc13_.Inventories = _loc10_;
            this.FCommonRecharge.SingleInventories.push(_loc13_);
            _loc5_++;
         }
         this.FCommonRecharge.AccumulateInventories.length = 0;
         _loc7_ = int(_loc2_.readUnsignedShort());
         _loc5_ = 0;
         while(_loc5_ < _loc7_)
         {
            _loc13_ = new TPerReward();
            _loc13_.Score = _loc2_.readUnsignedInt();
            _loc8_ = int(_loc2_.readUnsignedShort());
            _loc11_.length = 0;
            _loc12_.length = 0;
            _loc6_ = 0;
            while(_loc6_ < _loc8_)
            {
               _loc11_.push(_loc2_.readUnsignedInt());
               _loc12_.push(_loc2_.readUnsignedInt());
               _loc6_++;
            }
            _loc10_ = new TInventories();
            this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc10_,_loc11_);
            _loc6_ = 0;
            while(_loc6_ < _loc8_)
            {
               _loc9_ = _loc10_.GetInventoryByIndex(_loc6_);
               _loc9_.Quantity = _loc12_[_loc6_];
               _loc6_++;
            }
            _loc13_.Inventories = _loc10_;
            this.FCommonRecharge.AccumulateInventories.push(_loc13_);
            _loc5_++;
         }
         switch(this.FCommonRecharge.Identify)
         {
            case ACTIVITY_ID_1:
               _loc14_ = int(CONST_SHORTCUTS.TYPE_NewActiveList_DragonBoat);
               break;
            case ACTIVITY_ID_2:
               _loc14_ = int(CONST_SHORTCUTS.TYPE_NewActiveList_DragonBoat2);
               break;
            case ACTIVITY_ID_3:
               _loc14_ = int(CONST_SHORTCUTS.TYPE_NewActiveList_DragonBoat3);
               break;
            case ACTIVITY_ID_4:
               _loc14_ = int(CONST_SHORTCUTS.TYPE_NewActiveList_DragonBoat4);
               break;
            case ACTIVITY_ID_5:
               _loc14_ = int(CONST_SHORTCUTS.TYPE_NewActiveList_DragonBoat5);
               break;
            case ACTIVITY_ID_6:
               _loc14_ = int(CONST_SHORTCUTS.TYPE_NewActiveList_DragonBoat6);
               break;
            case ACTIVITY_ID_7:
               _loc14_ = int(CONST_SHORTCUTS.TYPE_NewActiveList_DragonBoat7);
         }
         SLogicsCore.NewActivityModes.SetActivityStatus(_loc14_,_loc4_);
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
      
      protected function PerformPacket_SC_ChangeStatusRet(param1:TPacket = null) : void
      {
         this.FCommonRecharge.Gold = param1.Data.readUnsignedInt();
         if(this.visible == true)
         {
            this.UpdateUI();
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
         this.UpdateUI();
      }
      
      override public function Unmount() : void
      {
         super.Unmount();
         this.FProcessorWindowSingle.Unmount();
      }
      
      public function TestInit0() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:TInventory = null;
         var _loc6_:TInventories = null;
         var _loc7_:Vector.<uint> = null;
         var _loc8_:Vector.<uint> = null;
         var _loc9_:TPerReward = null;
         this.FCommonRecharge.Title = "活动标题";
         this.FCommonRecharge.Identify = 2;
         this.FCommonRecharge.Gold = 100;
         if(this.FCommonRecharge.TabID.length == 0)
         {
            _loc3_ = 10;
            _loc1_ = 0;
            while(_loc1_ < _loc3_)
            {
               this.FCommonRecharge.TabID.push(_loc1_ + 1);
               _loc1_++;
            }
         }
         if(this.FCommonRecharge.SingleInventories.length == 0)
         {
            _loc7_ = new Vector.<uint>();
            _loc8_ = new Vector.<uint>();
            _loc1_ = 0;
            while(_loc1_ < _loc3_)
            {
               _loc9_ = new TPerReward();
               _loc9_.MinValue = _loc1_ * 10 + 1;
               _loc9_.MaxValue = _loc1_ * 11 + 1;
               _loc4_ = 7;
               _loc7_.length = 0;
               _loc8_.length = 0;
               _loc2_ = 0;
               while(_loc2_ < _loc4_)
               {
                  _loc7_.push(14100001 + _loc1_);
                  _loc8_.push(_loc1_ + 1);
                  _loc2_++;
               }
               _loc6_ = new TInventories();
               this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc6_,_loc7_);
               _loc2_ = 0;
               while(_loc2_ < _loc4_)
               {
                  _loc5_ = _loc6_.GetInventoryByIndex(_loc2_);
                  _loc5_.Quantity = _loc8_[_loc2_];
                  _loc2_++;
               }
               _loc9_.Inventories = _loc6_;
               this.FCommonRecharge.SingleInventories.push(_loc9_);
               _loc1_++;
            }
         }
         if(this.FCommonRecharge.AccumulateInventories.length == 0)
         {
            _loc7_ = new Vector.<uint>();
            _loc8_ = new Vector.<uint>();
            _loc1_ = 0;
            while(_loc1_ < _loc3_)
            {
               _loc9_ = new TPerReward();
               _loc9_.Score = _loc1_ * 10 + 1;
               _loc4_ = 7;
               _loc7_.length = 0;
               _loc8_.length = 0;
               _loc2_ = 0;
               while(_loc2_ < _loc4_)
               {
                  _loc7_.push(14100002);
                  _loc8_.push(_loc1_ + 1);
                  _loc2_++;
               }
               _loc6_ = new TInventories();
               this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc6_,_loc7_);
               _loc2_ = 0;
               while(_loc2_ < _loc4_)
               {
                  _loc5_ = _loc6_.GetInventoryByIndex(_loc2_);
                  _loc5_.Quantity = _loc8_[_loc2_];
                  _loc2_++;
               }
               _loc9_.Inventories = _loc6_;
               this.FCommonRecharge.AccumulateInventories.push(_loc9_);
               _loc1_++;
            }
         }
      }
   }
}

