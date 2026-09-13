package Processors.Game.Lobby.Exercise.VipFreeBuy
{
   import Foundation.Common.TBounds;
   import Foundation.Common.THint;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.Characters.TCharacter;
   import Logics.Exercise.VipFreeBuy.TVipFreeBuy;
   import Logics.Exercise.VipShop.TVipBox;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Exercise.TUnstreamizerVipFreeBuy;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import Processors.Game.Lobby.Exercise.VipFreeBuy.Compoents.TUIVipBox;
   import Processors.Game.Windows.Information.TUIWindowConfirmation;
   import Processors.Game.Windows.Information.TUIWindowRecharge;
   import Rendering.Overlayers.Hints.TOverlayerHint;
   import Rendering.Overlayers.Inventories.TOverlayerAccessory;
   import Rendering.Overlayers.Inventories.TOverlayerAppliance;
   import Rendering.Overlayers.Inventories.TOverlayerEquipment;
   import Rendering.Overlayers.Inventories.TOverlayerTreasure;
   import Rendering.Overlayers.VipFreeBuy.TOverlayerVipFreeBuy;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_INVENTORY;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_SHORTCUTS;
   import Resources.Constants.CONST_VIPFREEBUY;
   import Resources.Strings.STRING_Ramen;
   import Resources.Strings.STRING_VIPFREEBUY;
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
   
   public class TProcessorVIPFreeBuy extends TProcessorLobbyWindows
   {
      
      public static const BOX_COUNT:int = 10;
      
      public static const DAY_COUNT:int = 5;
      
      public static const CAPACITY_INVENTORIES:uint = CONST_COMMON.CAPACITY_INVENTORIES;
      
      public static const CATEGORY_Normal:uint = CONST_INVENTORY.CATEGORY_Normal;
      
      public static const CATEGORY_Equipment:uint = CONST_INVENTORY.CATEGORY_Equipment;
      
      public static const CATEGORY_Gem:uint = CONST_INVENTORY.CATEGORY_Gem;
      
      public static const CATEGORY_Treasure:uint = CONST_INVENTORY.CATEGORY_Treasure;
      
      public static const CATEGORY_Material:uint = CONST_INVENTORY.CATEGORY_Material;
      
      public static const CATEGORY_Accessories:uint = CONST_INVENTORY.CATEGORY_Accessories;
      
      protected var SIZE_WIDTH:int = 854;
      
      protected var SIZE_HEIGHT:int = 452;
      
      protected var FMC_Scene:Sprite;
      
      protected var FBtn_Close:SimpleButton;
      
      protected var FUIVipBoxList:Vector.<TUIVipBox>;
      
      protected var FTF_Date:TextField;
      
      protected var FTF_Desc:TextField;
      
      protected var FTF_Time:TextField;
      
      protected var FBounds:TBounds;
      
      protected var FEndTime:int;
      
      protected var FEndTimeID:int;
      
      protected var FDelayTimeID:int;
      
      protected var FTimeID:int;
      
      protected var FVipFreeBuy:TVipFreeBuy;
      
      protected var FIndex:int;
      
      protected var FUIWindowConfirmation:TUIWindowConfirmation;
      
      protected var FUIWindowRecharge:TUIWindowRecharge;
      
      protected var FUnstreamizerVipFreeBuy:TUnstreamizerVipFreeBuy;
      
      protected var FOverlayerVipFreeBuy:TOverlayerVipFreeBuy;
      
      protected var FOnOpenActivity:Function;
      
      protected var FCheckEffect:Function;
      
      public function TProcessorVIPFreeBuy(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FVipFreeBuy = SLogicsCore.VipFreeBuy;
         this.FUnstreamizerVipFreeBuy = new TUnstreamizerVipFreeBuy();
         this.FUIVipBoxList = new Vector.<TUIVipBox>();
         this.FBounds = new TBounds();
         this.FBounds.Width = this.SIZE_WIDTH;
         this.FBounds.Height = this.SIZE_HEIGHT;
         ComponentBoundsCenter(this,this.FBounds);
         this.FOverlayerVipFreeBuy = new TOverlayerVipFreeBuy(this.Parent);
         this.FOverlayerVipFreeBuy.Visible = false;
         FOverlayerHint = new TOverlayerHint(this.Parent);
         FOverlayerHint.Visible = false;
         SetUIModuleID(CONST_MODULES.ACTIVE_Test);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_VIPFREEBUY.RESOURCESID_Swf_VIPFreeBuy);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         this.FMC_Scene = TUtilityReflection.CreateDisplayObjectInstance(CONST_VIPFREEBUY.RESOURCE_ClassName_MC_VIPFreeBuy) as Sprite;
         addChild(this.FMC_Scene);
         this.FBtn_Close = this.FMC_Scene[CONST_VIPFREEBUY.RESOURCE_Link_BTN_Close];
         this.FTF_Date = this.FMC_Scene[CONST_VIPFREEBUY.RESOURCE_LINK_TF_DATE];
         this.FTF_Desc = this.FMC_Scene[CONST_VIPFREEBUY.RESOURCE_LINK_TF_DESC];
         this.FTF_Time = this.FMC_Scene["TF_Time"];
         this.FUIWindowConfirmation = new TUIWindowConfirmation(this.Parent);
         this.FUIWindowConfirmation.OnOK = this.ProcessorOnOK;
         this.FUIWindowConfirmation.OnCancel = this.ProcessorOnCancel;
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
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerVipFreeBuy);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerHint);
         this.ResourcesPerform_Box();
         super.ResourcesPerform_UIDispatch();
      }
      
      protected function ResourcesPerform_Box() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUIVipBox = null;
         var _loc4_:MovieClip = null;
         _loc1_ = 0;
         while(_loc1_ < BOX_COUNT)
         {
            _loc4_ = this.FMC_Scene[CONST_VIPFREEBUY.RESOURCE_LINK_MC_Box + _loc1_];
            _loc3_ = new TUIVipBox(this);
            _loc3_.Perform_UIDispatch(_loc4_);
            _loc3_.Index = _loc1_;
            _loc3_.OnBuyBox = this.ProcessorOnBuyBox;
            _loc3_.OnGetReward = this.PerformPacket_CS_GetRewardReq;
            _loc3_.OnBtnOver = this.ProcessorOnBtnOver;
            _loc3_.OnBtnOut = this.ProcessorOnBtnOut;
            _loc4_ = this.FMC_Scene["MC_BoxTip" + _loc1_];
            _loc4_.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnTipOver);
            _loc4_.addEventListener(MouseEvent.MOUSE_OUT,this.ProcessorOnTipOut);
            this.FUIVipBoxList.push(_loc3_);
            _loc1_++;
         }
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FBtn_Close.addEventListener(MouseEvent.CLICK,OnClose);
         super.ResourcesPerform_UILocations();
      }
      
      protected function UpdateUI() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUIVipBox = null;
         _loc1_ = 0;
         while(_loc1_ < BOX_COUNT)
         {
            _loc3_ = this.FUIVipBoxList[_loc1_];
            _loc3_.UpdateUI();
            _loc1_++;
         }
         this.UpdateText();
      }
      
      protected function UpdateText() : void
      {
         this.FTF_Date.text = TUtilityString.Format(STRING_VIPFREEBUY.FormatString_TimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FVipFreeBuy.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FVipFreeBuy.PayEndTime - 1) * 1000)));
         this.FTF_Desc.htmlText = this.FVipFreeBuy.ActivityDesc;
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         super.PacketRegisterRoutines();
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_VIPFreeBuy_OpenActivityRet,this.PerformPacket_SC_OpenActiveRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_VIPFreeBuy_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_VIPFreeBuy_GetRewardRet,this.PerformPacket_SC_GetRewardRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_VIPFreeBuy_BuyBoxRet,this.PerformPacket_SC_BuyBoxRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_VIPFreeBuy_ChangeStatusRet,this.PerformPacket_SC_ChangeStatusRet);
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
         SLogicsCore.NewActivityModes.SetActivityStatus(CONST_SHORTCUTS.TYPE_NewActiveList_VIPFreeBuy,false);
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
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         if(this.visible && Boolean(this.FMC_Scene))
         {
            this.FTF_Time.text = TGameUtil.fomatTime(this.FVipFreeBuy.PayEndTime - STimingCore.GetServerTick());
         }
      }
      
      protected function PerformPacket_SC_OpenActiveRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = param1.Data;
         var _loc3_:int = int(_loc2_.readUnsignedByte());
         var _loc4_:Boolean = _loc3_ == 0 ? false : true;
         this.FEndTime = _loc2_.readUnsignedInt();
         SLogicsCore.NewActivityModes.SetActivityStatus(CONST_SHORTCUTS.TYPE_NewActiveList_VIPFreeBuy,_loc4_);
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
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_VIPFreeBuy_LoadInfoReq);
         if(this.FVipFreeBuy.NeedConfig)
         {
            _loc1_.Data.writeInt(1);
         }
         else
         {
            _loc1_.Data.writeInt(0);
         }
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
            ProcessorClose();
            return;
         }
         this.FUnstreamizerVipFreeBuy.Unstreamize(_loc2_,this.FVipFreeBuy,null);
         if(FIsResourcesLoadCompleted && this.visible)
         {
            this.UpdateUI();
         }
      }
      
      protected function ProcessorOnBuyBox(param1:int = 0) : void
      {
         var _loc2_:TCharacter = null;
         var _loc3_:TVipBox = null;
         this.FIndex = param1;
         _loc2_ = SLogicsCore.Character;
         _loc3_ = this.FVipFreeBuy.GetDateByIndex(this.FIndex);
         if(!this.FUIWindowConfirmation.IsSelected)
         {
            this.FUIWindowConfirmation.Text = TUtilityString.Format(STRING_Ramen.FORMAT_MakeRamenOnce,_loc3_.Price);
            this.FUIWindowConfirmation.SetCheckBox(true);
            this.FUIWindowConfirmation.Visible = true;
         }
         else
         {
            this.ProcessorOnOK();
         }
      }
      
      protected function ProcessorOnOK(param1:Object = null) : void
      {
         var _loc2_:TCharacter = null;
         var _loc3_:TVipBox = null;
         _loc2_ = SLogicsCore.Character;
         _loc3_ = this.FVipFreeBuy.GetDateByIndex(this.FIndex);
         if(_loc2_.CreditGold + _loc2_.CreditGiftCertificate < _loc3_.Price)
         {
            this.UpdateUI();
            this.FUIWindowRecharge.Visible = true;
            return;
         }
         this.PerformPacket_CS_BuyBoxReq();
      }
      
      protected function ProcessorOnCancel(param1:Object = null) : void
      {
         this.UpdateUI();
      }
      
      protected function PerformPacket_CS_BuyBoxReq() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_VIPFreeBuy_BuyBoxReq);
         _loc2_ = _loc1_.Data;
         _loc3_ = this.FVipFreeBuy.VipBoxList[this.FIndex].Identify;
         _loc2_.writeInt(_loc3_);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PerformPacket_SC_BuyBoxRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:TVipBox = null;
         var _loc5_:String = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            this.UpdateUI();
         }
         else
         {
            this.FVipFreeBuy.RewardStatus[this.FIndex] = 0;
            _loc5_ = STRING_VIPFREEBUY.STRINGS_BUY_SUCCESS;
            this.ProcessorEffectText(_loc5_);
            this.CheckAwardStatus();
            this.UpdateUI();
         }
      }
      
      protected function PerformPacket_CS_GetRewardReq(param1:int = 0) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         var _loc4_:int = 0;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_VIPFreeBuy_GetRewardReq);
         this.FIndex = param1;
         _loc3_ = _loc2_.Data;
         _loc4_ = this.FVipFreeBuy.VipBoxList[this.FIndex].Identify;
         _loc3_.writeInt(_loc4_);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function PerformPacket_SC_GetRewardRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:TVipBox = null;
         var _loc5_:TInventory = null;
         var _loc6_:String = null;
         var _loc7_:int = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            this.UpdateUI();
         }
         else
         {
            _loc7_ = this.FVipFreeBuy.GetBoxDay[this.FIndex];
            _loc4_ = this.FVipFreeBuy.VipBoxList[this.FIndex];
            if(_loc7_ < _loc4_.Inventories.Count)
            {
               this.FVipFreeBuy.RewardStatus[this.FIndex] = 1;
               _loc6_ = STRING_VIPFREEBUY.STRINGS_GET_SUCCESS;
               _loc5_ = _loc4_.Inventories.GetInventoryByIndex(_loc7_);
               _loc6_ += _loc5_.Name + "*" + _loc5_.Quantity;
               ++this.FVipFreeBuy.GetBoxDay[this.FIndex];
               this.ProcessorEffectText(_loc6_);
            }
            this.CheckAwardStatus();
            this.UpdateUI();
         }
      }
      
      protected function PerformPacket_SC_ChangeStatusRet(param1:TPacket = null) : void
      {
         this.ProcessorCheckEffect(true);
      }
      
      protected function ProcessorCheckEffect(param1:Boolean) : void
      {
         if(this.FCheckEffect != null)
         {
            this.FCheckEffect(CONST_SHORTCUTS.POSITION_NewActiveList,CONST_SHORTCUTS.TYPE_NewActiveList_VIPFreeBuy,param1);
         }
      }
      
      protected function CheckAwardStatus() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc2_ = int(this.FVipFreeBuy.RewardStatus.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(this.FVipFreeBuy.RewardStatus[_loc1_] == 0)
            {
               this.ProcessorCheckEffect(true);
               return;
            }
            _loc1_++;
         }
         this.ProcessorCheckEffect(false);
      }
      
      protected function ProcessorOnTipOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(9));
         this.FOverlayerVipFreeBuy.Context = this.FVipFreeBuy.VipBoxList[_loc2_];
         this.FOverlayerVipFreeBuy.Render(FUICore.MouseCoordinate);
         this.FOverlayerVipFreeBuy.Show();
      }
      
      protected function ProcessorOnTipOut(param1:MouseEvent) : void
      {
         this.FOverlayerVipFreeBuy.Hide();
      }
      
      protected function ProcessorOnBtnOver(param1:Object, param2:THint) : void
      {
         FOverlayerHint.Context = param2;
         FOverlayerHint.Render(FUICore.MouseCoordinate);
         FOverlayerHint.Show();
      }
      
      protected function ProcessorOnBtnOut(param1:Object) : void
      {
         FOverlayerHint.Hide();
      }
      
      protected function ProcessorEffectText(param1:String) : void
      {
         if(FOnEffectText != null)
         {
            FOnEffectText(this,param1);
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
         this.SetInterval();
      }
      
      override public function Unmount() : void
      {
         super.Unmount();
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
            this.FTimeID = setTimeout(this.PerformPacket_CS_LoadInfoReq,_loc2_);
         }
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
         _loc3_.writeUnsignedInt(STimingCore.GetServerTick() + 1000);
         TUtilityString.FlushUTF(_loc3_,"VIP回馈");
         TUtilityString.FlushUTF(_loc3_,"VIP回馈");
         TUtilityString.FlushUTF(_loc3_,"VIP回馈");
         _loc3_.writeShort(10);
         _loc1_ = 0;
         while(_loc1_ < 10)
         {
            _loc3_.writeInt(-1);
            _loc1_++;
         }
         _loc3_.writeShort(10);
         _loc1_ = 0;
         while(_loc1_ < 10)
         {
            _loc3_.writeUnsignedInt(_loc1_ % 5 + 1);
            _loc1_++;
         }
         _loc3_.writeShort(10);
         _loc1_ = 0;
         while(_loc1_ < 10)
         {
            _loc3_.writeUnsignedInt(_loc1_);
            _loc3_.writeUnsignedInt(1000 + _loc1_);
            _loc3_.writeUnsignedInt(1 + _loc1_);
            _loc3_.writeShort(5);
            _loc2_ = 0;
            while(_loc2_ < 5)
            {
               _loc3_.writeUnsignedInt(14100001 + _loc2_);
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

