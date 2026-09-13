package Processors.Game.Lobby.Exercise.FrogWallet
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
   import Logics.Exercise.FrogWallet.TActivitiesData;
   import Logics.Exercise.FrogWallet.TCornucopia;
   import Logics.Exercise.FrogWallet.TRechargeAccum;
   import Logics.Exercise.FrogWallet.TShadow;
   import Logics.Exercise.FrogWallet.TTenTail;
   import Logics.Exercise.TBaseActivity;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Exercise.TUnstreamizerExercise;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import Rendering.Overlayers.Hints.TOverlayerHint;
   import Rendering.Overlayers.Inventories.TOverlayerAccessory;
   import Rendering.Overlayers.Inventories.TOverlayerAppliance;
   import Rendering.Overlayers.Inventories.TOverlayerEquipment;
   import Rendering.Overlayers.Inventories.TOverlayerTreasure;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_FROGWALLET;
   import Resources.Constants.CONST_INVENTORY;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_SHORTCUTS;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class TProcessorFrogWallet extends TProcessorLobbyWindows
   {
      
      public static const RESULT_LOSE:int = TShadow.RESULT_LOSE;
      
      public static const RESULT_NOCHANGE:int = TShadow.RESULT_NOCHANGE;
      
      public static const RESULT_WIN:int = TShadow.RESULT_WIN;
      
      public static const ACTIVITY_1_ID:int = CONST_FROGWALLET.ACTIVITY_1_ID;
      
      public static const ACTIVITY_2_ID:int = CONST_FROGWALLET.ACTIVITY_2_ID;
      
      public static const ACTIVITY_3_ID:int = CONST_FROGWALLET.ACTIVITY_3_ID;
      
      public static const ACTIVITY_4_ID:int = CONST_FROGWALLET.ACTIVITY_4_ID;
      
      public static const CAPACITY_INVENTORIES:uint = CONST_COMMON.CAPACITY_INVENTORIES;
      
      public static const CATEGORY_Normal:uint = CONST_INVENTORY.CATEGORY_Normal;
      
      public static const CATEGORY_Equipment:uint = CONST_INVENTORY.CATEGORY_Equipment;
      
      public static const CATEGORY_Gem:uint = CONST_INVENTORY.CATEGORY_Gem;
      
      public static const CATEGORY_Treasure:uint = CONST_INVENTORY.CATEGORY_Treasure;
      
      public static const CATEGORY_Material:uint = CONST_INVENTORY.CATEGORY_Material;
      
      public static const CATEGORY_Accessories:uint = CONST_INVENTORY.CATEGORY_Accessories;
      
      protected var SIZE_WIDTH:int = 915;
      
      protected var SIZE_HEIGHT:int = 556;
      
      protected var TAB_COUNT:int = 4;
      
      protected var MAX_TAB_COUNT:int = 8;
      
      protected var FProcessorWindowFrogWallet:TProcessorWindowFrogWallet;
      
      protected var FProcessorWindowPackage:TProcessorWindowPackage;
      
      protected var FMC_Scene:Sprite;
      
      protected var FBtn_Close:SimpleButton;
      
      protected var FBtn_Help:SimpleButton;
      
      protected var FMC_BtnBottom:Sprite;
      
      protected var FUITab:TUITab;
      
      protected var FTabList:Vector.<MovieClip>;
      
      protected var FChangeTabIndex:int;
      
      protected var FBounds:TBounds;
      
      protected var FActivitiesData:TActivitiesData;
      
      protected var FUnstreamizerExercise:TUnstreamizerExercise;
      
      protected var FEndTimeID:int;
      
      protected var FDelayTimeID:int;
      
      protected var FActivityID:int;
      
      protected var FTimeID:int;
      
      protected var FTemp:int;
      
      protected var FOnOpenActivity:Function;
      
      protected var FOnGoto:Function;
      
      protected var FCheckEffect:Function;
      
      public function TProcessorFrogWallet(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FActivitiesData = SLogicsCore.ActivitiesData;
         this.FUnstreamizerExercise = new TUnstreamizerExercise();
         this.FProcessorWindowFrogWallet = new TProcessorWindowFrogWallet(this);
         this.FProcessorWindowFrogWallet.OnOverlay = UIComponentsHintOnOver;
         this.FProcessorWindowFrogWallet.OnOut = UIComponentsHintOnOut;
         this.FProcessorWindowFrogWallet.TipOnOver = this.TipOnOver;
         this.FProcessorWindowFrogWallet.TipOnOut = this.TipOnOut;
         this.FProcessorWindowFrogWallet.OnGoto = this.ProcessorOnGoto;
         this.FProcessorWindowFrogWallet.OnGetReward = this.PerformPacket_CS_GetAwardReq;
         this.FProcessorWindowFrogWallet.EffectText = this.ProcessorEffectText;
         this.FProcessorWindowFrogWallet.OnShowPackage = this.ProcessorOnShowPackage;
         this.FProcessorWindowFrogWallet.OnStartPractice = this.PerformPacket_CS_StartPracticeReq;
         this.FProcessorWindowFrogWallet.OnShadowGetReward = this.PerformPacket_CS_ShadowGetAwardReq;
         this.FProcessorWindowPackage = new TProcessorWindowPackage(this.Parent);
         this.FProcessorWindowPackage.OnCloseUp = this.ProcessorOnClosePackage;
         this.FProcessorWindowPackage.OnOverlay = UIComponentsHintOnOver;
         this.FProcessorWindowPackage.OnOut = UIComponentsHintOnOut;
         this.FProcessorWindowPackage.OnItemSelected = this.ProcessorOnItemSelected;
         this.FProcessorWindowPackage.Visible = false;
         this.FUITab = new TUITab(this);
         this.FTabList = new Vector.<MovieClip>();
         this.FChangeTabIndex = 0;
         this.FBounds = new TBounds();
         this.FBounds.Width = this.SIZE_WIDTH;
         this.FBounds.Height = this.SIZE_HEIGHT;
         ComponentBoundsCenter(this,this.FBounds);
         this.FTemp = 0;
         SetUIModuleID(CONST_MODULES.ACTIVE_Test);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         super.ResourcesPerform_UIRequest();
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_FROGWALLET.RESOURCESID_Swf_Activity);
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         this.FMC_Scene = TUtilityReflection.CreateDisplayObjectInstance(CONST_FROGWALLET.RESOURCE_ClassName_MC_Activity) as Sprite;
         addChild(this.FMC_Scene);
         this.FBtn_Close = this.FMC_Scene[CONST_FROGWALLET.RESOURCE_Link_BTN_Close];
         this.FBtn_Help = this.FMC_Scene[CONST_FROGWALLET.RESOURCE_Link_BTN_Help];
         this.FMC_BtnBottom = this.FMC_Scene[CONST_FROGWALLET.RESOURCE_LINK_MC_BtnBottom];
         _loc2_ = this.TAB_COUNT;
         this.FTabList.length = 0;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FMC_Scene[CONST_FROGWALLET.RESOURCE_Link_MC_Tab + _loc1_];
            this.FTabList.push(_loc3_);
            this.FUITab.SetTabByIndex(_loc3_,_loc1_);
            _loc1_++;
         }
         this.FUITab.Init();
         this.FUITab.OnSwitch = this.ChangeTabOnSwitch;
         this.FProcessorWindowFrogWallet.Perform_UIDispatch(this.FMC_Scene[CONST_FROGWALLET.RESOURCE_Link_MC_Activity]);
         addChild(this.FProcessorWindowFrogWallet);
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
         addChild(this.FMC_BtnBottom);
         addChild(this.FBtn_Close);
         addChild(this.FBtn_Help);
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FBtn_Close.addEventListener(MouseEvent.CLICK,OnClose);
         super.ResourcesPerform_UILocations();
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         super.PacketRegisterRoutines();
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_FrogWallet_OpenActivityRet,this.PerformPacket_SC_OpenActiveRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_FrogWallet_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_FrogWallet_LoadRechargeAccumRet,this.PerformPacket_SC_LoadRechargeAccumRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_FrogWallet_StatusChangeRet,this.PerformPacket_SC_StatusChangeRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_FrogWallet_GetAwardRet,this.PerformPacket_SC_GetAwardRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_FrogWallet_LoadTenTailRet,this.PerformPacket_SC_LoadTenTailRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_FrogWallet_LoadShadowRet,this.PerformPacket_SC_LoadShadowRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_FrogWallet_StartPracticeRet,this.PerformPacket_SC_StartPracticeRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_FrogWallet_ShadowGetAwardRet,this.PerformPacket_SC_ShadowGetAwardRet);
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
      }
      
      protected function UpdateTab() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         _loc1_ = 0;
         while(_loc1_ < this.TAB_COUNT)
         {
            _loc2_ = this.FTabList[_loc1_];
            if(_loc1_ < this.FActivitiesData.ActivitiesCount)
            {
               _loc2_.visible = true;
               _loc2_[CONST_FROGWALLET.RESOURCE_LINK_TF_TITLE].text = this.FActivitiesData.GetActivityByIndex(_loc1_).ActivityTabName;
            }
            else
            {
               _loc2_.visible = false;
            }
            _loc1_++;
         }
         if(this.FActivitiesData.ActivitiesCount < this.MAX_TAB_COUNT)
         {
            this.FMC_Scene["Btn_Left"].visible = false;
            this.FMC_Scene["Btn_Right"].visible = false;
         }
      }
      
      protected function PerformPacket_CS_LoadInfoReq() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_FrogWallet_LoadInfoReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PerformPacket_CS_LoadRechargeAccumReq() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_FrogWallet_LoadRechargeAccumReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PerformPacket_CS_LoadTenTailReq() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_FrogWallet_LoadTenTailReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PerformPacket_CS_LoadShadowReq() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:TShadow = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_FrogWallet_LoadShadowReq);
         _loc2_ = this.FActivitiesData.GetActivityByIdentify(ACTIVITY_4_ID) as TShadow;
         if(_loc2_)
         {
            _loc1_.Data.writeUnsignedInt(0);
         }
         else
         {
            _loc1_.Data.writeUnsignedInt(1);
         }
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PerformPacket_CS_GetAwardReq(param1:int, param2:int = 0) : void
      {
         var _loc3_:TPacket = null;
         var _loc4_:ByteArray = null;
         _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_FrogWallet_GetAwardReq);
         this.FActivityID = param1;
         _loc4_ = _loc3_.Data;
         _loc4_.writeInt(param1);
         _loc4_.writeInt(param2);
         SNetworkCore.Transceiver.PacketTransmit(_loc3_);
      }
      
      protected function PerformPacket_CS_StartPracticeReq() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         var _loc3_:TInventory = null;
         var _loc4_:TShadow = this.FActivitiesData.GetActivityByIdentify(ACTIVITY_4_ID) as TShadow;
         if(!_loc4_.Inventories || _loc4_.Inventories.Count <= 0)
         {
            return;
         }
         _loc3_ = _loc4_.Inventories.GetInventoryByIndex(0);
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_FrogWallet_StartPracticeReq);
         _loc2_ = _loc1_.Data;
         _loc2_.writeInt(_loc3_.Identifier0);
         _loc2_.writeInt(_loc3_.Identifier1);
         _loc2_.writeInt(_loc3_.IDTemplate);
         _loc2_.writeInt(_loc4_.PutCount);
         _loc2_.writeInt(_loc4_.PutGold);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PerformPacket_CS_ShadowGetAwardReq() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_FrogWallet_ShadowGetAwardReq);
         _loc2_ = _loc1_.Data;
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PerformPacket_SC_OpenActiveRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = param1.Data;
         var _loc3_:int = int(_loc2_.readUnsignedByte());
         var _loc4_:Boolean = _loc3_ == 0 ? false : true;
         this.FActivitiesData.EndTime = _loc2_.readUnsignedInt();
         SLogicsCore.NewActivityModes.SetActivityStatus(CONST_SHORTCUTS.TYPE_NewActiveList_FrogWallet,_loc4_);
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
      
      protected function PerformPacket_SC_LoadInfoRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = param1.Data;
         var _loc3_:int = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            this.FActivitiesData.RemoveActivityByIdentify(ACTIVITY_1_ID);
         }
         else
         {
            this.FUnstreamizerExercise.Unstreamize(_loc2_,this.FActivitiesData,null);
         }
         this.CheckAwardStatus();
         if(FIsResourcesLoadCompleted && this.FActivitiesData.ActivitiesCount > 0)
         {
            this.UpdateTab();
            this.FProcessorWindowFrogWallet.Visible = true;
            this.FProcessorWindowFrogWallet.UpdateUI();
         }
      }
      
      protected function PerformPacket_SC_LoadRechargeAccumRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = param1.Data;
         var _loc3_:int = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            this.FActivitiesData.RemoveActivityByIdentify(ACTIVITY_2_ID);
         }
         else
         {
            this.FUnstreamizerExercise.Unstreamize(_loc2_,this.FActivitiesData,null);
         }
         this.CheckAwardStatus();
         if(FIsResourcesLoadCompleted && this.FActivitiesData.ActivitiesCount > 0)
         {
            this.UpdateTab();
            this.FProcessorWindowFrogWallet.Visible = true;
            this.FProcessorWindowFrogWallet.UpdateUI();
         }
      }
      
      protected function PerformPacket_SC_LoadTenTailRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = param1.Data;
         var _loc3_:int = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            this.FActivitiesData.RemoveActivityByIdentify(ACTIVITY_3_ID);
         }
         else
         {
            this.FUnstreamizerExercise.Unstreamize(_loc2_,this.FActivitiesData,null);
         }
         this.CheckAwardStatus();
         if(FIsResourcesLoadCompleted && this.FActivitiesData.ActivitiesCount > 0)
         {
            this.UpdateTab();
            this.FProcessorWindowFrogWallet.Visible = true;
            this.FProcessorWindowFrogWallet.UpdateUI();
         }
      }
      
      protected function PerformPacket_SC_LoadShadowRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = param1.Data;
         var _loc3_:int = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            this.FActivitiesData.RemoveActivityByIdentify(ACTIVITY_4_ID);
         }
         else
         {
            this.FUnstreamizerExercise.Unstreamize(_loc2_,this.FActivitiesData,null);
         }
         this.CheckAwardStatus();
         if(FIsResourcesLoadCompleted && this.FActivitiesData.ActivitiesCount > 0)
         {
            this.UpdateTab();
            this.FProcessorWindowFrogWallet.Visible = true;
            this.FProcessorWindowFrogWallet.UpdateUI();
         }
      }
      
      protected function PerformPacket_SC_StatusChangeRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:TCornucopia = null;
         var _loc8_:TBaseActivity = null;
         this.ProcessorCheckEffect(true);
         _loc2_ = param1.Data;
         _loc3_ = int(_loc2_.readUnsignedInt());
         _loc4_ = int(_loc2_.readUnsignedInt());
         _loc5_ = _loc2_.readByte();
         _loc6_ = int(_loc2_.readUnsignedInt());
         _loc8_ = this.FActivitiesData.GetActivityByIdentify(_loc3_);
         if(!_loc8_)
         {
            return;
         }
         switch(_loc3_)
         {
            case ACTIVITY_1_ID:
               (_loc8_ as TCornucopia).ChangeBoxStatus(_loc4_,_loc5_,_loc6_);
               break;
            case ACTIVITY_2_ID:
               (_loc8_ as TRechargeAccum).ChangeBoxStatus(_loc4_,_loc5_,_loc6_);
               break;
            case ACTIVITY_3_ID:
               (_loc8_ as TTenTail).ChangeBoxStatus(_loc4_,_loc5_,_loc6_);
               break;
            case ACTIVITY_4_ID:
               (_loc8_ as TShadow).ChangeBoxStatus(_loc4_,_loc5_,_loc6_);
         }
         this.CheckAwardStatus();
         if(this.visible)
         {
            this.FProcessorWindowFrogWallet.UpdateUI();
         }
      }
      
      protected function PerformPacket_SC_GetAwardRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            this.FProcessorWindowFrogWallet.GetRewardError(this.FActivityID);
         }
         else
         {
            _loc4_ = int(_loc2_.readUnsignedInt());
            this.FProcessorWindowFrogWallet.GetRewardRet(_loc4_);
         }
         this.CheckAwardStatus();
      }
      
      protected function PerformPacket_SC_StartPracticeRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:TShadow = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
         }
         else
         {
            _loc4_ = SLogicsCore.ActivitiesData.GetActivityByIdentify(ACTIVITY_4_ID) as TShadow;
            if(_loc4_)
            {
               _loc4_.Result = _loc2_.readUnsignedInt();
               _loc4_.GetInventoryByResult();
               this.FProcessorWindowFrogWallet.ProcessorOnPracticeEnd();
               if(_loc4_.Result == RESULT_NOCHANGE)
               {
                  _loc4_.IsContinue = true;
                  this.PerformPacket_CS_ShadowGetAwardReq();
               }
               else
               {
                  _loc4_.IsContinue = false;
               }
            }
         }
      }
      
      protected function PerformPacket_SC_ShadowGetAwardRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:TShadow = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            this.FProcessorWindowFrogWallet.GetRewardError(ACTIVITY_4_ID);
         }
         else
         {
            _loc4_ = SLogicsCore.ActivitiesData.GetActivityByIdentify(ACTIVITY_4_ID) as TShadow;
            if(_loc4_)
            {
               _loc4_.GetReward();
               this.FProcessorWindowFrogWallet.GetRewardRet(ACTIVITY_4_ID);
            }
         }
      }
      
      protected function ProcessorOnItemSelected(param1:Object = null) : void
      {
         this.FProcessorWindowFrogWallet.ProcessorOnItemSelect(param1);
      }
      
      protected function ChangeTabOnSwitch(param1:Object) : void
      {
         var _loc2_:int = param1 as int;
         this.FProcessorWindowFrogWallet.ChangeTabOnSwitch(_loc2_);
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
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:TBaseActivity = null;
         _loc3_ = this.FActivitiesData.ActivitiesCount;
         _loc1_ = 0;
         while(_loc1_ < _loc3_)
         {
            _loc5_ = this.FActivitiesData.GetActivityByIndex(_loc1_);
            _loc4_ = int(_loc5_.RewardStatus.length);
            _loc2_ = 0;
            while(_loc2_ < _loc4_)
            {
               if(_loc5_.RewardStatus.indexOf(0) != -1)
               {
                  this.ProcessorCheckEffect(true);
                  return;
               }
               _loc2_++;
            }
            _loc1_++;
         }
         this.ProcessorCheckEffect(false);
      }
      
      protected function ProcessorCheckEffect(param1:Boolean) : void
      {
         if(this.FCheckEffect != null)
         {
            this.FCheckEffect(CONST_SHORTCUTS.POSITION_NewActiveList,CONST_SHORTCUTS.TYPE_NewActiveList_FrogWallet,param1);
         }
      }
      
      protected function ProcessorDelayCloseActivity() : void
      {
         if(this.FEndTimeID != 0)
         {
            clearTimeout(this.FEndTimeID);
            this.FEndTimeID = 0;
         }
         var _loc1_:Number = (this.FActivitiesData.EndTime - STimingCore.GetServerTick()) * 1000;
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
         SLogicsCore.NewActivityModes.SetActivityStatus(CONST_SHORTCUTS.TYPE_NewActiveList_FrogWallet,false);
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
      
      protected function PerformPacket_CS_LoadInfo() : void
      {
         this.PerformPacket_CS_LoadInfoReq();
         this.PerformPacket_CS_LoadRechargeAccumReq();
         this.PerformPacket_CS_LoadTenTailReq();
         this.PerformPacket_CS_LoadShadowReq();
      }
      
      protected function SetInterval() : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         if(this.FTimeID != 0)
         {
            clearTimeout(this.FTimeID);
            this.FTimeID = 0;
         }
         var _loc1_:Date = new Date(STimingCore.GetServerTime() * 1000);
         _loc1_.hours = 0;
         _loc1_.minutes = 0;
         _loc1_.seconds = 0;
         _loc3_ = _loc1_.getTime() + 24 * 60 * 60 * 1000 + 5000;
         _loc2_ = _loc3_ - STimingCore.GetServerTime() * 1000;
         if(_loc2_ >= 0)
         {
            this.FTimeID = setTimeout(this.PerformPacket_CS_LoadInfo,_loc2_);
         }
      }
      
      protected function ProcessorOnShowPackage() : void
      {
         if(FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowPackage.Reset();
            this.FProcessorWindowPackage.Visible = true;
         }
      }
      
      protected function ProcessorOnClosePackage() : void
      {
         this.FProcessorWindowPackage.Visible = false;
         this.ProcessorOnItemSelected(null);
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
            this.FProcessorWindowFrogWallet.Load();
            this.FProcessorWindowPackage.Load();
            return;
         }
         this.FUITab.SwithTagManual(0);
         this.PerformPacket_CS_LoadInfo();
         this.SetInterval();
      }
      
      override public function Unmount() : void
      {
         this.FProcessorWindowFrogWallet.Unmount();
         super.Unmount();
      }
      
      public function TestInit0() : ByteArray
      {
         var _loc1_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeUnsignedInt(0);
         _loc2_.writeUnsignedInt(1);
         _loc2_.writeUnsignedInt(1371571200);
         _loc2_.writeUnsignedInt(1);
         _loc2_.writeUnsignedInt(STimingCore.GetServerTick() + 100);
         TUtilityString.FlushUTF(_loc2_,"招财猫");
         TUtilityString.FlushUTF(_loc2_,"招财猫");
         TUtilityString.FlushUTF(_loc2_,"<font color=\"#ffffff\">每日木叶争霸战中守卫胜利的组织将获得活动奖励，活动奖励将于当日24点发放至玩家邮件</font><font color=\"#fe0000\">注：攻方组织攻城胜利并无奖励；组织成员将以每日木叶争霸战结束时间点组织内成员为准。</font>");
         _loc2_.writeShort(3);
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            _loc2_.writeUnsignedInt(_loc1_ + 1);
            TUtilityString.FlushUTF(_loc2_,"礼包1");
            _loc2_.writeUnsignedInt(1);
            _loc2_.writeUnsignedInt(100);
            _loc2_.writeUnsignedInt(10);
            _loc2_.writeByte(0);
            _loc2_.writeUnsignedInt(0);
            _loc2_.writeUnsignedInt(10 + _loc1_);
            _loc2_.writeUnsignedInt(3);
            _loc2_.writeShort(2);
            _loc3_ = 0;
            while(_loc3_ < 2)
            {
               _loc2_.writeUnsignedInt(14100001 + _loc4_);
               _loc2_.writeUnsignedInt(3);
               _loc4_++;
               _loc3_++;
            }
            _loc1_++;
         }
         _loc2_.position = 0;
         return _loc2_;
      }
      
      public function TestInit1() : ByteArray
      {
         var _loc1_:int = 0;
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeUnsignedInt(0);
         _loc2_.writeUnsignedInt(2);
         _loc2_.writeUnsignedInt(STimingCore.GetServerTick());
         _loc2_.writeUnsignedInt(STimingCore.GetServerTick() + 10000);
         _loc2_.writeUnsignedInt(STimingCore.GetServerTick() + 1000);
         TUtilityString.FlushUTF(_loc2_,"日进斗金");
         TUtilityString.FlushUTF(_loc2_,"日进斗金");
         TUtilityString.FlushUTF(_loc2_,"<font color=\"#ffffff\">每日木叶争霸战中守卫胜利的组织将获得活动奖励，活动奖励将于当日24点发放至玩家邮件</font><font color=\"#fe0000\">注：攻方组织攻城胜利并无奖励；组织成员将以每日木叶争霸战结束时间点组织内成员为准。</font>");
         _loc2_.writeUnsignedInt(3);
         _loc2_.writeByte(1);
         _loc2_.writeUnsignedInt(100);
         _loc2_.writeShort(5);
         var _loc3_:Vector.<int> = Vector.<int>([10,20,30,40,50]);
         var _loc4_:Vector.<int> = Vector.<int>([10,100,200,500,1000]);
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            _loc2_.writeUnsignedInt(_loc3_[_loc1_]);
            _loc2_.writeUnsignedInt(_loc4_[_loc1_]);
            _loc1_++;
         }
         _loc2_.writeShort(5);
         var _loc5_:Vector.<int> = Vector.<int>([10,1,30,999,0]);
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            _loc2_.writeUnsignedInt(_loc5_[_loc1_]);
            _loc1_++;
         }
         _loc2_.position = 0;
         return _loc2_;
      }
      
      public function TestInit2() : ByteArray
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
         TUtilityString.FlushUTF(_loc3_,"招募瞳兽");
         TUtilityString.FlushUTF(_loc3_,"招募瞳兽");
         TUtilityString.FlushUTF(_loc3_,"<font color=\"#ffffff\">每日木叶争霸战中守卫胜利。</font>");
         ++this.FTemp;
         _loc3_.writeUnsignedInt(this.FTemp);
         _loc3_.writeUnsignedInt(this.FTemp);
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
      
      public function TestInit3() : ByteArray
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc5_:Vector.<int> = null;
         var _loc6_:Vector.<int> = null;
         var _loc7_:Vector.<int> = null;
         var _loc8_:Vector.<int> = null;
         var _loc9_:Vector.<int> = null;
         var _loc10_:Vector.<int> = null;
         var _loc11_:Vector.<int> = null;
         var _loc4_:ByteArray = new ByteArray();
         _loc4_.writeUnsignedInt(0);
         _loc4_.writeUnsignedInt(10);
         _loc4_.writeUnsignedInt(STimingCore.GetServerTick());
         _loc4_.writeUnsignedInt(STimingCore.GetServerTick() + 1000);
         TUtilityString.FlushUTF(_loc4_,"影分身");
         TUtilityString.FlushUTF(_loc4_,"影分身");
         TUtilityString.FlushUTF(_loc4_,"<font color=\"#ffffff\">影分身。</font>");
         _loc4_.writeUnsignedInt(0);
         _loc4_.writeUnsignedInt(0);
         _loc4_.writeUnsignedInt(14100001);
         _loc4_.writeUnsignedInt(2);
         _loc4_.writeShort(5);
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            _loc4_.writeUnsignedInt(14100001);
            _loc4_.writeUnsignedInt(5);
            _loc4_.writeShort(5);
            _loc2_ = 0;
            while(_loc2_ < 5)
            {
               _loc4_.writeUnsignedInt(50 - _loc1_ * 5);
               _loc2_++;
            }
            _loc4_.writeShort(5);
            _loc2_ = 0;
            while(_loc2_ < 5)
            {
               _loc4_.writeUnsignedInt(50 - _loc1_ * 5);
               _loc4_.writeUnsignedInt(50 - _loc1_ * 5);
               _loc2_++;
            }
            _loc4_.writeShort(2);
            _loc2_ = 0;
            while(_loc2_ < 2)
            {
               _loc4_.writeUnsignedInt((_loc1_ + 1) * 10);
               _loc2_++;
            }
            _loc1_++;
         }
         _loc4_.position = 0;
         return _loc4_;
      }
   }
}

