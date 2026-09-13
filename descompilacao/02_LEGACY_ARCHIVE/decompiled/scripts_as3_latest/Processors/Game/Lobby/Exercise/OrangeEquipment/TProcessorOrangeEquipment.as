package Processors.Game.Lobby.Exercise.OrangeEquipment
{
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.OrangeEquipment.TOrangeEquipment;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.Lottery.TLotteryNews;
   import Logics.SLogicsCore;
   import Logics.Streamization.Exercise.TUnstreamizerOrangeEquipment;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorBaseActivity;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   
   public class TProcessorOrangeEquipment extends TProcessorBaseActivity
   {
      
      protected static const BOX_COUNT:int = 6;
      
      protected var FOrangeEquipment:TOrangeEquipment;
      
      protected var FBeClicked:Boolean;
      
      protected var FUnstreamizerOrangeEquipment:TUnstreamizerOrangeEquipment;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FBTN_GotoBuy:MovieClip;
      
      protected var FBTN_GotoExchange:MovieClip;
      
      protected var FIndex2:int;
      
      protected var FProcessorWindowOrangeEquipmentBuy:TProcessorWindowOrangeEquipmentBuy;
      
      protected var FProcessorWindowOrangeEquipmentExchange:TProcessorWindowOrangeEquipmentExchange;
      
      public function TProcessorOrangeEquipment(param1:TUIComponent, param2:TLobbyParameters, param3:uint)
      {
         super(param1,param2,param3);
         FActivityID = param3;
         this.FOrangeEquipment = SLogicsCore.OrangeEquipment;
         this.FUnstreamizerOrangeEquipment = new TUnstreamizerOrangeEquipment();
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         this.FProcessorWindowOrangeEquipmentBuy = new TProcessorWindowOrangeEquipmentBuy(this.Parent);
         this.FProcessorWindowOrangeEquipmentExchange = new TProcessorWindowOrangeEquipmentExchange(this.Parent);
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:MovieClip = null;
         super.ResourcesPerform_UIDispatch();
         this.FBTN_GotoBuy = FMC_Scene["BTN_GotoBuy"];
         this.FBTN_GotoExchange = FMC_Scene["BTN_GotoExchange"];
         this.FBTN_GotoBuy.MC_Select.visible = false;
         this.FBTN_GotoExchange.MC_Select.visible = false;
         this.FProcessorWindowOrangeEquipmentBuy.OnCloseUp = this.ProcessorOnCloseBuy;
         this.FProcessorWindowOrangeEquipmentBuy.OnOverlay = UIComponentsHintOnOver;
         this.FProcessorWindowOrangeEquipmentBuy.OnOut = UIComponentsHintOnOut;
         this.FProcessorWindowOrangeEquipmentBuy.TipOnOver = ProcessorOnShowTip;
         this.FProcessorWindowOrangeEquipmentBuy.TipOnOut = ProcessorOnHideTip;
         this.FProcessorWindowOrangeEquipmentBuy.OnGetBox = this.ProcessorOnBuyUp;
         this.FProcessorWindowOrangeEquipmentBuy.Visible = false;
         this.FProcessorWindowOrangeEquipmentExchange.OnCloseUp = this.ProcessorOnCloseExchange;
         this.FProcessorWindowOrangeEquipmentExchange.OnOverlay = UIComponentsHintOnOver;
         this.FProcessorWindowOrangeEquipmentExchange.OnOut = UIComponentsHintOnOut;
         this.FProcessorWindowOrangeEquipmentExchange.TipOnOver = ProcessorOnShowTip;
         this.FProcessorWindowOrangeEquipmentExchange.TipOnOut = ProcessorOnHideTip;
         this.FProcessorWindowOrangeEquipmentExchange.OnGetBox = this.ProcessorOnGetUp;
         this.FProcessorWindowOrangeEquipmentExchange.Visible = false;
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
         this.FBTN_GotoBuy.addEventListener(MouseEvent.CLICK,this.ProcessorOnGotoBuy);
         this.FBTN_GotoBuy.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnBuyOver);
         this.FBTN_GotoBuy.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnBuyOut);
         this.FBTN_GotoExchange.addEventListener(MouseEvent.CLICK,this.ProcessorOnGotoExchange);
         this.FBTN_GotoExchange.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnExchangeOver);
         this.FBTN_GotoExchange.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnExchangeOut);
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         if(FInitialized)
         {
            if(this.visible)
            {
            }
         }
      }
      
      override protected function UpdateUI() : void
      {
         super.UpdateUI();
         FTF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FOrangeEquipment.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FOrangeEquipment.EndTime - 1) * 1000)));
         FTF_Desc.text = this.FOrangeEquipment.ActivityDesc;
         if(this.FProcessorWindowOrangeEquipmentBuy.Visible)
         {
            this.FProcessorWindowOrangeEquipmentBuy.UpdateUI();
         }
         if(this.FProcessorWindowOrangeEquipmentExchange.Visible)
         {
            this.FProcessorWindowOrangeEquipmentExchange.UpdateUI();
         }
      }
      
      protected function ProcessorOnGotoBuy(param1:MouseEvent) : void
      {
         this.FProcessorWindowOrangeEquipmentBuy.Visible = true;
         this.FProcessorWindowOrangeEquipmentBuy.UpdateUI();
      }
      
      protected function ProcessorOnBuyOver(param1:MouseEvent) : void
      {
         this.FBTN_GotoBuy.MC_Select.visible = true;
         this.FBTN_GotoBuy.filters = [TGameUtil.highLightFilters];
      }
      
      protected function ProcessorOnBuyOut(param1:MouseEvent) : void
      {
         this.FBTN_GotoBuy.MC_Select.visible = false;
         this.FBTN_GotoBuy.filters = [];
      }
      
      protected function ProcessorOnCloseBuy() : void
      {
         this.FProcessorWindowOrangeEquipmentBuy.Visible = false;
      }
      
      protected function ProcessorOnGotoExchange(param1:MouseEvent) : void
      {
         this.FProcessorWindowOrangeEquipmentExchange.Visible = true;
         this.FProcessorWindowOrangeEquipmentExchange.UpdateUI();
      }
      
      protected function ProcessorOnExchangeOver(param1:MouseEvent) : void
      {
         this.FBTN_GotoExchange.MC_Select.visible = true;
         this.FBTN_GotoExchange.filters = [TGameUtil.highLightFilters];
      }
      
      protected function ProcessorOnExchangeOut(param1:MouseEvent) : void
      {
         this.FBTN_GotoExchange.MC_Select.visible = false;
         this.FBTN_GotoExchange.filters = [];
      }
      
      protected function ProcessorOnCloseExchange() : void
      {
         this.FProcessorWindowOrangeEquipmentExchange.Visible = false;
      }
      
      override protected function PerformPacket_CS_LoadInfoReq() : void
      {
         super.PerformPacket_CS_LoadInfoReq();
      }
      
      override protected function PerformPacket_CS_LoadLogReq(param1:MouseEvent = null) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_OrangeEquipment_LoadLogReq);
         _loc2_.Data.writeUnsignedInt(FActivityID);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function ProcessorOnGetUp(param1:int, param2:int) : void
      {
         var _loc3_:TPacket = null;
         var _loc4_:int = 0;
         if(this.FBeClicked)
         {
            return;
         }
         FIndex = param1;
         this.FIndex2 = param2;
         this.FBeClicked = true;
         _loc4_ = int(this.FOrangeEquipment.GetEquipmentIDByIndex(param1,param2));
         _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_BaseActivity_GetRewardReq);
         _loc3_.Data.writeUnsignedInt(FActivityID);
         _loc3_.Data.writeUnsignedInt(_loc4_);
         SNetworkCore.Transceiver.PacketTransmit(_loc3_);
      }
      
      protected function ProcessorOnBuyUp(param1:int, param2:int) : void
      {
         var _loc3_:TPacket = null;
         var _loc4_:int = 0;
         if(this.FBeClicked)
         {
            return;
         }
         FIndex = param1;
         this.FIndex2 = param2;
         this.FBeClicked = true;
         _loc4_ = int(this.FOrangeEquipment.GetBoxIDByIndex(param1,param2));
         FIdentify = _loc4_;
         _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_BaseActivity_BuyBoxReq);
         _loc3_.Data.writeUnsignedInt(FActivityID);
         _loc3_.Data.writeUnsignedInt(_loc4_);
         SNetworkCore.Transceiver.PacketTransmit(_loc3_);
      }
      
      override protected function PerformPacket_CS_BuyBoxReq(param1:MouseEvent = null) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(this.FBeClicked)
         {
            return;
         }
         this.FBeClicked = true;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_BaseActivity_BuyBoxReq);
         _loc2_.Data.writeUnsignedInt(ActivityID);
         _loc2_.Data.writeUnsignedInt(FIdentify);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount(param1);
         if(!FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowOrangeEquipmentBuy.Load();
            this.FProcessorWindowOrangeEquipmentExchange.Load();
            return;
         }
         this.visible = true;
         this.alpha = 1;
         if(FMC_EffectLeft)
         {
            FMC_EffectLeft.play();
         }
         if(FMC_EffectRight)
         {
            FMC_EffectRight.play();
         }
         this.PerformPacket_CS_LoadInfoReq();
         SetInterval();
      }
      
      override public function Unmount() : void
      {
         super.Unmount();
         this.FProcessorWindowOrangeEquipmentBuy.Visible = false;
         this.FProcessorWindowOrangeEquipmentExchange.Visible = false;
      }
      
      override public function ProcessorOnLoadInfoRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         super.ProcessorOnLoadInfoRet();
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            OnClose(this);
            return;
         }
         this.FUnstreamizerOrangeEquipment.Unstreamize(_loc2_,this.FOrangeEquipment,null);
         if(FIsResourcesLoadCompleted && this.visible)
         {
            this.UpdateUI();
         }
      }
      
      override public function ProcessorLoadLogRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:TInventory = null;
         var _loc9_:TInventories = null;
         var _loc10_:TLotteryNews = null;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         var _loc13_:uint = 0;
         var _loc14_:Vector.<uint> = null;
         var _loc15_:Vector.<uint> = null;
         var _loc16_:TBins = null;
         _loc16_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         this.FOrangeEquipment.LogList.length = 0;
         _loc5_ = int(_loc2_.readUnsignedShort());
         _loc14_ = new Vector.<uint>();
         _loc15_ = new Vector.<uint>();
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc10_ = new TLotteryNews();
            _loc14_.length = 0;
            _loc15_.length = 0;
            _loc7_ = int(_loc2_.readUnsignedShort());
            _loc6_ = 0;
            while(_loc6_ < _loc7_ / 4)
            {
               _loc12_ = _loc2_.readUnsignedInt();
               _loc11_ = _loc2_.readUnsignedInt();
               _loc13_ = CONST_COMMON.GetItemIDByType(_loc12_,_loc11_,_loc16_);
               _loc14_.push(_loc13_);
               _loc15_.push(_loc2_.readUnsignedInt());
               _loc10_.GetTime = _loc2_.readUnsignedInt();
               _loc6_++;
            }
            _loc9_ = new TInventories();
            this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc9_,_loc14_);
            _loc8_ = _loc9_.GetInventoryByIndex(0);
            _loc8_.Quantity = _loc15_[0];
            _loc10_.Inventory = _loc8_;
            _loc10_.Inventories = _loc9_;
            this.FOrangeEquipment.LogList.push(_loc10_);
            _loc4_++;
         }
         FProcessorWindowLog.BaseActivity = this.FOrangeEquipment;
         FProcessorWindowLog.UpdateUI();
         FProcessorWindowLog.Visible = true;
      }
      
      override public function ProcessorBuyBoxRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:TInventory = null;
         var _loc6_:TInventories = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:Vector.<uint> = null;
         var _loc13_:Vector.<uint> = null;
         var _loc14_:TBins = null;
         _loc14_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         this.FBeClicked = false;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc8_ = int(_loc2_.readUnsignedShort());
         _loc12_ = new Vector.<uint>();
         _loc13_ = new Vector.<uint>();
         _loc6_ = new TInventories();
         _loc7_ = 0;
         while(_loc7_ < _loc8_ / 3)
         {
            _loc10_ = _loc2_.readUnsignedInt();
            _loc9_ = _loc2_.readUnsignedInt();
            _loc11_ = CONST_COMMON.GetItemIDByType(_loc10_,_loc9_,_loc14_);
            _loc12_.push(_loc11_);
            _loc13_.push(_loc2_.readUnsignedInt());
            _loc7_++;
         }
         this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc6_,_loc12_);
         _loc7_ = 0;
         while(_loc7_ < _loc8_ / 3)
         {
            _loc5_ = _loc6_.GetInventoryByIndex(_loc7_);
            _loc5_.Quantity = _loc13_[_loc7_];
            _loc7_++;
         }
         _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
         _loc7_ = 0;
         while(_loc7_ < _loc6_.Count)
         {
            _loc4_ += _loc6_.GetInventoryByIndex(_loc7_).Name + "*" + _loc6_.GetInventoryByIndex(_loc7_).Quantity + "\n";
            _loc7_++;
         }
         ProcessorEffectText(_loc4_);
         if(FIndex == -1)
         {
            --this.FOrangeEquipment.FreeTimes;
         }
         if(this.FOrangeEquipment.FreeTimes > 0)
         {
            ProcessorCheckEffect(FActivityID,true);
         }
         else
         {
            ProcessorCheckEffect(FActivityID,false);
         }
         this.UpdateUI();
      }
      
      override public function ProcessorGetRewardRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:TInventories = null;
         var _loc6_:int = 0;
         var _loc7_:TBaseBox = null;
         this.FBeClicked = false;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            this.UpdateUI();
            return;
         }
         _loc7_ = this.FOrangeEquipment.SuitBoxes[FIndex].SuitVect[this.FIndex2];
         ++_loc7_.BuyCount;
         _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED + _loc7_.Inventories.GetInventoryByIndex(0).Name;
         ProcessorEffectText(_loc4_);
         this.UpdateUI();
      }
      
      override public function ProcessorChangeGold(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         _loc2_ = param1.Data;
         if(this.FOrangeEquipment)
         {
            _loc3_ = int(_loc2_.readUnsignedShort());
            _loc4_ = 0;
            while(_loc4_ < _loc3_ / 2)
            {
               _loc6_ = this.FOrangeEquipment.ChipID.indexOf(_loc2_.readUnsignedInt());
               if(_loc6_ == -1)
               {
                  return;
               }
               _loc5_ = int(_loc2_.readUnsignedInt());
               this.FOrangeEquipment.ChipVect[_loc6_] = _loc5_;
               _loc4_++;
            }
            this.UpdateUI();
         }
      }
      
      public function TestInit0() : ByteArray
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:ByteArray = new ByteArray();
         var _loc4_:Vector.<int> = Vector.<int>([14210091,14210081,14200001,14200001,14200041]);
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeUnsignedInt(1371571200);
         _loc3_.writeUnsignedInt(1401571200);
         TUtilityString.FlushUTF(_loc3_,"描述1");
         TUtilityString.FlushUTF(_loc3_,"描述2");
         _loc3_.writeShort(3);
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            _loc3_.writeUnsignedInt(_loc1_ + 14100001);
            _loc3_.writeUnsignedInt(_loc1_ * 10);
            _loc1_++;
         }
         _loc3_.writeUnsignedInt(5);
         _loc3_.writeUnsignedInt(14100001);
         _loc3_.writeShort(5);
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            _loc3_.writeUnsignedInt(_loc1_ + 14101054);
            TUtilityString.FlushUTF(_loc3_,"外道·水镜" + _loc1_);
            _loc3_.writeShort(8);
            _loc2_ = 0;
            while(_loc2_ < 8)
            {
               _loc3_.writeUnsignedInt(_loc4_[_loc1_] + _loc2_);
               _loc3_.writeUnsignedInt(_loc1_ + 1 + _loc2_);
               _loc3_.writeUnsignedInt(5);
               _loc3_.writeUnsignedInt(0);
               _loc2_++;
            }
            _loc1_++;
         }
         _loc3_.writeShort(4);
         _loc1_ = 0;
         while(_loc1_ < 4)
         {
            TUtilityString.FlushUTF(_loc3_,"外道·水镜" + _loc1_);
            _loc3_.writeShort(3);
            _loc2_ = 0;
            while(_loc2_ < 3)
            {
               _loc3_.writeUnsignedInt(14101059 + _loc2_ + _loc1_);
               _loc3_.writeUnsignedInt(_loc2_ * 100 + 100 + _loc1_);
               _loc2_++;
            }
            _loc1_++;
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
         _loc3_.position = 0;
         return _loc3_;
      }
   }
}

