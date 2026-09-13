package Processors.Game.Lobby.Exercise.VipShop
{
   import Components.ScrollBar.TScrollBar;
   import Foundation.Common.TBounds;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.Characters.TCharacter;
   import Logics.Exercise.VipShop.TVipBox;
   import Logics.Exercise.VipShop.TVipShop;
   import Logics.SLogicsCore;
   import Logics.Streamization.Exercise.TUnstreamizerVipShop;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import Processors.Game.Lobby.Exercise.VipShop.Compoents.TUIReward;
   import Processors.Game.Windows.Information.TUIWindowConfirmation;
   import Processors.Game.Windows.Information.TUIWindowRecharge;
   import Rendering.Overlayers.Inventories.TOverlayerAccessory;
   import Rendering.Overlayers.Inventories.TOverlayerAppliance;
   import Rendering.Overlayers.Inventories.TOverlayerEquipment;
   import Rendering.Overlayers.Inventories.TOverlayerTreasure;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_INVENTORY;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_SHORTCUTS;
   import Resources.Constants.CONST_VIPSHOP;
   import Resources.Strings.STRING_FROGWALLET;
   import Resources.Strings.STRING_Ramen;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class TProcessorVipShop extends TProcessorLobbyWindows
   {
      
      public static const BOX_COUNT:int = 4;
      
      protected static const MIN_SCROLL_HEIGHT:Number = 457;
      
      protected static const ITEM_STAMP:Number = -1;
      
      protected static const SINGLE_ITEM_STAMP:Number = 66;
      
      protected static const ITEM_HEIGHT:Number = 66;
      
      protected static const INIT_X:Number = 0;
      
      protected static const INIT_Y:Number = 2;
      
      public static const CAPACITY_INVENTORIES:uint = CONST_COMMON.CAPACITY_INVENTORIES;
      
      public static const CATEGORY_Normal:uint = CONST_INVENTORY.CATEGORY_Normal;
      
      public static const CATEGORY_Equipment:uint = CONST_INVENTORY.CATEGORY_Equipment;
      
      public static const CATEGORY_Gem:uint = CONST_INVENTORY.CATEGORY_Gem;
      
      public static const CATEGORY_Treasure:uint = CONST_INVENTORY.CATEGORY_Treasure;
      
      public static const CATEGORY_Material:uint = CONST_INVENTORY.CATEGORY_Material;
      
      public static const CATEGORY_Accessories:uint = CONST_INVENTORY.CATEGORY_Accessories;
      
      protected var SIZE_WIDTH:int = 640;
      
      protected var SIZE_HEIGHT:int = 553;
      
      protected var FMC_Scene:Sprite;
      
      protected var FBtn_Close:SimpleButton;
      
      protected var FRewardList:Vector.<TUIReward>;
      
      protected var FMC_List:MovieClip;
      
      protected var FTF_Date:TextField;
      
      protected var FScrollBar:TScrollBar;
      
      protected var FBounds:TBounds;
      
      protected var FEndTime:int;
      
      protected var FEndTimeID:int;
      
      protected var FDelayTimeID:int;
      
      protected var FUnstreamizerVipShop:TUnstreamizerVipShop;
      
      protected var FVipShop:TVipShop;
      
      protected var FIndex:int;
      
      protected var FUIWindowConfirmation:TUIWindowConfirmation;
      
      protected var FUIWindowRecharge:TUIWindowRecharge;
      
      protected var FOnOpenActivity:Function;
      
      protected var FCheckEffect:Function;
      
      public function TProcessorVipShop(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FRewardList = new Vector.<TUIReward>();
         this.FUnstreamizerVipShop = new TUnstreamizerVipShop();
         this.FVipShop = SLogicsCore.VipShop;
         this.FBounds = new TBounds();
         this.FBounds.Width = this.SIZE_WIDTH;
         this.FBounds.Height = this.SIZE_HEIGHT;
         ComponentBoundsCenter(this,this.FBounds);
         SetUIModuleID(CONST_MODULES.ACTIVE_Test);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         super.ResourcesPerform_UIRequest();
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_VIPSHOP.RESOURCESID_Swf_VipShop);
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         this.FMC_Scene = TUtilityReflection.CreateDisplayObjectInstance(CONST_VIPSHOP.RESOURCE_ClassName_MC_VipShop) as Sprite;
         addChild(this.FMC_Scene);
         this.FMC_List = this.FMC_Scene[CONST_VIPSHOP.RESOURCE_LINK_MC_List];
         this.FTF_Date = this.FMC_Scene[CONST_VIPSHOP.RESOURCE_Link_TF_Date];
         this.FScrollBar = new TScrollBar(this.FMC_List,MIN_SCROLL_HEIGHT,false,ITEM_STAMP,SINGLE_ITEM_STAMP);
         this.FBtn_Close = this.FMC_Scene[CONST_VIPSHOP.RESOURCE_Link_BTN_Close];
         this.FUIWindowConfirmation = new TUIWindowConfirmation(this.Parent);
         this.FUIWindowConfirmation.OnOK = this.ProcessorOnOK;
         this.FUIWindowConfirmation.x = (CONST_COMMON.STAGE_Width - this.FUIWindowConfirmation.WindowWidth) / 2;
         this.FUIWindowConfirmation.y = (CONST_COMMON.STAGE_Height - this.FUIWindowConfirmation.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowConfirmation);
         this.FUIWindowConfirmation.SetCheckBox(true);
         this.FUIWindowRecharge = new TUIWindowRecharge(this.Parent);
         this.FUIWindowRecharge.x = (CONST_COMMON.STAGE_Width - this.FUIWindowRecharge.WindowWidth) / 2;
         this.FUIWindowRecharge.y = (CONST_COMMON.STAGE_Height - this.FUIWindowRecharge.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowRecharge(this.FUIWindowRecharge);
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
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FBtn_Close.addEventListener(MouseEvent.CLICK,OnClose);
         super.ResourcesPerform_UILocations();
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         super.LogicsPerform();
         if(this.visible)
         {
            _loc2_ = int(this.FRewardList.length);
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               this.FRewardList[_loc1_].UpdateSlot();
               _loc1_++;
            }
         }
      }
      
      protected function UpdateUI() : void
      {
         this.UpdateText();
         this.UpdateReward();
      }
      
      protected function UpdateText() : void
      {
         this.FTF_Date.text = TUtilityString.Format(STRING_FROGWALLET.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FVipShop.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FVipShop.EndTime - 1) * 1000)));
      }
      
      protected function ResourcesPerform_Reward() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUIReward = null;
         _loc2_ = uint(this.FVipShop.VipCount);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = new TUIReward(this);
            _loc3_.OnOverlay = UIComponentsHintOnOver;
            _loc3_.OnOut = UIComponentsHintOnOut;
            _loc3_.OnGetReward = this.ProcessorOnBuyBox;
            _loc3_.Init();
            _loc3_.y = INIT_X + _loc1_ * ITEM_HEIGHT;
            _loc3_.SetItemInfo(_loc1_);
            this.FRewardList[_loc1_] = _loc3_;
            this.FScrollBar.AddItem(_loc3_);
            _loc1_++;
         }
      }
      
      protected function UpdateReward() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUIReward = null;
         _loc2_ = this.FRewardList.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FRewardList.pop();
            _loc3_.parent.removeChild(_loc3_);
            _loc1_++;
         }
         this.FRewardList.length = 0;
         this.FScrollBar.Clear();
         this.ResourcesPerform_Reward();
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         super.PacketRegisterRoutines();
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_VIPShop_OpenActivityRet,this.PerformPacket_SC_OpenActiveRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_VIPShop_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_VIPShop_BuyBoxRet,this.PerformPacket_SC_BuyBoxRet);
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
         SLogicsCore.NewActivityModes.SetActivityStatus(CONST_SHORTCUTS.TYPE_NewActiveList_VipShop,false);
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
      
      protected function PerformPacket_CS_LoadInfoReq() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_VIPShop_LoadInfoReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function ProcessorOnBuyBox(param1:Object, param2:int = 0) : void
      {
         var _loc3_:TCharacter = null;
         var _loc4_:TVipBox = null;
         this.FIndex = param2;
         _loc3_ = SLogicsCore.Character;
         _loc4_ = this.FVipShop.GetBoxByIndex(this.FIndex);
         if(!this.FUIWindowConfirmation.IsSelected)
         {
            this.FUIWindowConfirmation.Text = TUtilityString.Format(STRING_Ramen.FORMAT_MakeRamenOnce,_loc4_.DiscountPrice);
            this.FUIWindowConfirmation.SetCheckBox(true);
            this.FUIWindowConfirmation.Visible = true;
         }
         else
         {
            this.ProcessorOnOK();
         }
      }
      
      protected function PerformPacket_CS_BuyBoxReq() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_VIPShop_BuyBoxReq);
         _loc2_ = _loc1_.Data;
         _loc3_ = this.FVipShop.GetBoxByIndex(this.FIndex).Identify;
         _loc2_.writeInt(_loc3_);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PerformPacket_SC_OpenActiveRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = param1.Data;
         var _loc3_:int = int(_loc2_.readUnsignedByte());
         var _loc4_:Boolean = _loc3_ == 0 ? false : true;
         this.FEndTime = _loc2_.readUnsignedInt();
         SLogicsCore.NewActivityModes.SetActivityStatus(CONST_SHORTCUTS.TYPE_NewActiveList_VipShop,_loc4_);
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
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         this.FUnstreamizerVipShop.Unstreamize(_loc2_,this.FVipShop,null);
         if(FIsResourcesLoadCompleted)
         {
            this.visible = true;
            this.UpdateUI();
         }
      }
      
      protected function PerformPacket_SC_BuyBoxRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:TVipBox = null;
         var _loc6_:String = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
         }
         else
         {
            _loc5_ = this.FVipShop.GetBoxByIndex(this.FIndex);
            ++_loc5_.BuyCount;
            _loc6_ = STRING_FROGWALLET.FORMAT_GET_SUCCESSED;
            _loc8_ = _loc5_.Inventories.Count;
            _loc7_ = 0;
            while(_loc7_ < _loc8_)
            {
               _loc6_ += _loc5_.Inventories.GetInventoryByIndex(_loc7_).Name + "*" + _loc5_.Inventories.GetInventoryByIndex(_loc7_).Quantity + "\n";
               _loc7_++;
            }
            this.ProcessorEffectText(_loc6_);
            this.UpdateUI();
         }
      }
      
      protected function ProcessorEffectText(param1:String) : void
      {
         if(FOnEffectText != null)
         {
            FOnEffectText(this,param1);
         }
      }
      
      protected function ProcessorOnOK(param1:Object = null) : void
      {
         var _loc2_:TCharacter = null;
         var _loc3_:TVipBox = null;
         _loc2_ = SLogicsCore.Character;
         _loc3_ = this.FVipShop.GetBoxByIndex(this.FIndex);
         if(_loc2_.CreditGold + _loc2_.CreditGiftCertificate < _loc3_.DiscountPrice)
         {
            this.UpdateUI();
            this.FUIWindowRecharge.Visible = true;
            return;
         }
         this.PerformPacket_CS_BuyBoxReq();
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
         var _loc3_:ByteArray = new ByteArray();
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeUnsignedInt(1);
         _loc3_.writeUnsignedInt(1371571200);
         _loc3_.writeUnsignedInt(1371572200);
         _loc3_.writeShort(7);
         _loc1_ = 0;
         while(_loc1_ < 7)
         {
            _loc3_.writeUnsignedInt(1 + _loc1_);
            _loc3_.writeUnsignedInt(1 + _loc1_);
            _loc3_.writeUnsignedInt(1 + _loc1_);
            _loc3_.writeUnsignedInt(0);
            _loc3_.writeUnsignedInt(1000 + _loc1_);
            _loc3_.writeUnsignedInt(500 + _loc1_);
            _loc3_.writeShort(10);
            _loc2_ = 0;
            while(_loc2_ < 10)
            {
               _loc3_.writeUnsignedInt(14100001 + _loc1_ + _loc2_);
               _loc3_.writeUnsignedInt(1 + _loc2_);
               _loc2_++;
            }
            _loc1_++;
         }
         _loc3_.position = 0;
         return _loc3_;
      }
   }
}

