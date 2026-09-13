package Processors.Game.Lobby.Exercise.NinjiaVillage
{
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TNinjaVillage;
   import Logics.Exercise.NinjiaVillage.TNinjiaVillageBaseData;
   import Logics.Exercise.NinjiaVillage.TNinjiaVillageData;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Exercise.TUnstreamizerNinjiaVillage;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorBaseActivity;
   import Processors.Game.Lobby.TreasureMap.ConsumeFrameCopy;
   import Rendering.Overlayers.NationalDay.TOverlayerFund;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Strings.STRING_BASEACTIVITY;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_NINJIAVILLAGE;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   
   public class TProcessorNinjiaVillage extends TProcessorBaseActivity
   {
      
      protected static const BTN_COUNT:int = 3;
      
      protected static const FIVE_COUNTRY:int = 5;
      
      protected static const TAB_LEVEL_UP:int = 0;
      
      protected static const TAB_FUND:int = 1;
      
      protected static const TAB_FIVE_COUNTRY:int = 2;
      
      protected static const LEVEL_UP_BASE_ID:int = 50001;
      
      protected static const FUND_BASE_ID:int = 51001;
      
      protected static const FIVE_COUNTRY_BASE_ID:int = 52001;
      
      protected var FNinjiaVillageData:TNinjiaVillageData;
      
      protected var FBeClicked:Boolean;
      
      protected var FUnstreamizerNinjiaVillage:TUnstreamizerNinjiaVillage;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FBtnVect:Vector.<MovieClip>;
      
      protected var FProcessorWindowNinjiaVillageLvUp:TProcessorWindowNinjiaVillageLvUp;
      
      protected var FProcessorWindowNinjiaVillageFund:TProcessorWindowNinjiaVillageFund;
      
      protected var FProcessorWindowNinjiaVillageFiveCountry:TProcessorWindowNinjiaVillageFiveCountry;
      
      protected var FOverlayerFund:TOverlayerFund;
      
      protected var FBigType:int;
      
      protected var FCost:int;
      
      protected var FBaseBox:TBaseBox;
      
      public function TProcessorNinjiaVillage(param1:TUIComponent, param2:TLobbyParameters, param3:uint)
      {
         super(param1,param2,param3);
         FActivityID = param3;
         this.FNinjiaVillageData = SLogicsCore.NinjiaVillageData;
         this.FBtnVect = new Vector.<MovieClip>(BTN_COUNT);
         this.FUnstreamizerNinjiaVillage = new TUnstreamizerNinjiaVillage();
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         this.FProcessorWindowNinjiaVillageLvUp = new TProcessorWindowNinjiaVillageLvUp(this.Parent);
         this.FProcessorWindowNinjiaVillageFund = new TProcessorWindowNinjiaVillageFund(this.Parent);
         this.FProcessorWindowNinjiaVillageFiveCountry = new TProcessorWindowNinjiaVillageFiveCountry(this.Parent);
         this.FOverlayerFund = new TOverlayerFund(this.Parent);
         this.FOverlayerFund.Visible = false;
         this.FBaseBox = new TBaseBox();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:MovieClip = null;
         super.ResourcesPerform_UIDispatch();
         _loc1_ = 0;
         while(_loc1_ < BTN_COUNT)
         {
            this.FBtnVect[_loc1_] = FMC_Scene["Btn_Goto" + _loc1_];
            this.FBtnVect[_loc1_].addEventListener(MouseEvent.CLICK,this.ProcessorOnGotoUp);
            this.FBtnVect[_loc1_].addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnBtnOver);
            this.FBtnVect[_loc1_].addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnBtnOut);
            this.FBtnVect[_loc1_].MC_Select.visible = false;
            _loc1_++;
         }
         this.FProcessorWindowNinjiaVillageLvUp.OnCloseUp = this.ProcessorOnCloseWindow;
         this.FProcessorWindowNinjiaVillageLvUp.OnOverlay = UIComponentsHintOnOver;
         this.FProcessorWindowNinjiaVillageLvUp.OnOut = UIComponentsHintOnOut;
         this.FProcessorWindowNinjiaVillageLvUp.TipOnOver = this.ProcessorOnLvUpBoxOver;
         this.FProcessorWindowNinjiaVillageLvUp.TipOnOut = this.ProcessorOnLvUpBoxOut;
         this.FProcessorWindowNinjiaVillageLvUp.OnGetBox = this.ProcessorBuyLvUpBoxReq;
         this.FProcessorWindowNinjiaVillageLvUp.Visible = false;
         this.FProcessorWindowNinjiaVillageFund.OnCloseUp = this.ProcessorOnCloseWindow;
         this.FProcessorWindowNinjiaVillageFund.OnFundOverlay = this.ProcessorOnFundOver;
         this.FProcessorWindowNinjiaVillageFund.OnFundOut = this.ProcessorOnFundOut;
         this.FProcessorWindowNinjiaVillageFund.OnBoxOverlay = this.ProcessorOnTreeBoxOver;
         this.FProcessorWindowNinjiaVillageFund.OnBoxOut = this.ProcessorOnTreeBoxOut;
         this.FProcessorWindowNinjiaVillageFund.OnGetBox = this.ProcessorBuyFundReq;
         this.FProcessorWindowNinjiaVillageFund.Visible = false;
         this.FProcessorWindowNinjiaVillageFiveCountry.OnCloseUp = this.ProcessorOnCloseWindow;
         this.FProcessorWindowNinjiaVillageFiveCountry.OnOverlay = UIComponentsHintOnOver;
         this.FProcessorWindowNinjiaVillageFiveCountry.OnOut = UIComponentsHintOnOut;
         this.FProcessorWindowNinjiaVillageFiveCountry.OnGetBox = this.ProcessorBuyBoxReq;
         this.FProcessorWindowNinjiaVillageFiveCountry.OnBtnOver = ProcessorOnShowTip;
         this.FProcessorWindowNinjiaVillageFiveCountry.OnBtnOut = ProcessorOnHideTip;
         this.FProcessorWindowNinjiaVillageFiveCountry.Visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerFund);
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
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
         var _loc1_:String = null;
         var _loc2_:TNinjaVillage = null;
         var _loc3_:TNinjaVillage = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         super.UpdateUI();
         FTF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FNinjiaVillageData.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FNinjiaVillageData.EndTime - 1) * 1000)));
         _loc1_ = new ConsumeFrameCopy(STRING_NINJIAVILLAGE.STRING_001).DescribeString;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_NinjaVillage,51001) as TNinjaVillage;
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_NinjaVillage,52001) as TNinjaVillage;
         if(Boolean(_loc1_ != "") && Boolean(_loc2_) && Boolean(_loc3_))
         {
            _loc4_ = _loc2_.ReturnType == 1 ? STRING_COMMON.ITEMNAME_Gold : STRING_COMMON.ITEMNAME_Vouchers;
            _loc5_ = _loc2_.ReturnType == 1 ? STRING_COMMON.ITEMNAME_Gold : STRING_COMMON.ITEMNAME_Vouchers;
            FTF_Desc.text = TUtilityString.Format(_loc1_,_loc2_.MaxTime,_loc4_,_loc5_);
         }
         if(this.FProcessorWindowNinjiaVillageLvUp.Visible)
         {
            this.FProcessorWindowNinjiaVillageLvUp.UpdateUI();
         }
         else if(this.FProcessorWindowNinjiaVillageFund.Visible)
         {
            this.FProcessorWindowNinjiaVillageFund.UpdateUI();
         }
         else if(this.FProcessorWindowNinjiaVillageFiveCountry.Visible)
         {
            this.FProcessorWindowNinjiaVillageFiveCountry.UpdateUI();
         }
         if(FMC_Scene.MC_Buff0)
         {
            FMC_Scene.MC_Buff0.gotoAndStop(this.FNinjiaVillageData.FiveCountryReturnType);
         }
         if(FMC_Scene.MC_Buff1)
         {
            FMC_Scene.MC_Buff1.gotoAndStop(this.FNinjiaVillageData.FiveCountryReturnType);
         }
      }
      
      protected function ProcessorOnGotoUp(param1:MouseEvent) : void
      {
         var _loc2_:int = int(String(param1.currentTarget.name).slice(8));
         switch(_loc2_)
         {
            case TAB_LEVEL_UP:
               this.FProcessorWindowNinjiaVillageLvUp.Visible = true;
               this.FProcessorWindowNinjiaVillageLvUp.UpdateUI();
               break;
            case TAB_FUND:
               this.FProcessorWindowNinjiaVillageFund.Visible = true;
               this.FProcessorWindowNinjiaVillageFund.UpdateUI();
               break;
            case TAB_FIVE_COUNTRY:
               this.FProcessorWindowNinjiaVillageFiveCountry.Visible = true;
               this.FProcessorWindowNinjiaVillageFiveCountry.UpdateUI();
         }
      }
      
      protected function ProcessorOnBtnOver(param1:MouseEvent) : void
      {
         var _loc2_:int = int(String(param1.currentTarget.name).slice(8));
         this.FBtnVect[_loc2_].MC_Select.visible = true;
         this.FBtnVect[_loc2_].filters = [TGameUtil.highLightFilters];
      }
      
      protected function ProcessorOnBtnOut(param1:MouseEvent) : void
      {
         var _loc2_:int = int(String(param1.currentTarget.name).slice(8));
         this.FBtnVect[_loc2_].MC_Select.visible = false;
         this.FBtnVect[_loc2_].filters = [];
      }
      
      protected function ProcessorOnCloseWindow() : void
      {
         this.FProcessorWindowNinjiaVillageLvUp.Visible = false;
         this.FProcessorWindowNinjiaVillageFund.Visible = false;
         this.FProcessorWindowNinjiaVillageFiveCountry.Visible = false;
      }
      
      override protected function PerformPacket_CS_LoadInfoReq() : void
      {
         super.PerformPacket_CS_LoadInfoReq();
      }
      
      protected function ProcessorOnLvUpBoxOver(param1:uint) : void
      {
         var _loc2_:TNinjiaVillageBaseData = null;
         _loc2_ = this.FNinjiaVillageData.GetDataByIdentify(LEVEL_UP_BASE_ID + param1);
         if(_loc2_)
         {
            ProcessorOnShowTip(_loc2_.Desc2);
         }
      }
      
      protected function ProcessorOnLvUpBoxOut(param1:int) : void
      {
         ProcessorOnHideTip();
      }
      
      protected function ProcessorOnFundOver(param1:uint) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:TNinjiaVillageBaseData = null;
         _loc4_ = this.FNinjiaVillageData.GetDataByIdentify(FUND_BASE_ID + param1);
         if(_loc4_)
         {
            _loc3_ = _loc4_.ReturnType == 1 ? STRING_COMMON.ITEMNAME_Gold : STRING_COMMON.ITEMNAME_Vouchers;
            _loc2_ = TUtilityString.Format(_loc4_.Desc2,_loc4_.ReturnGold,_loc3_,_loc4_.MaxTime);
            this.FBaseBox.Title = _loc4_.Title;
            this.FBaseBox.Desc5 = _loc2_;
            this.FBaseBox.Price = _loc4_.Price;
            this.FOverlayerFund.Context = null;
            this.FOverlayerFund.Context = this.FBaseBox;
            this.FOverlayerFund.Render(FUICore.MouseCoordinate);
            this.FOverlayerFund.Show();
         }
      }
      
      protected function ProcessorOnFundOut(param1:int) : void
      {
         this.FOverlayerFund.Hide();
      }
      
      protected function ProcessorOnTreeBoxOver(param1:uint) : void
      {
         var _loc2_:TNinjiaVillageBaseData = null;
         var _loc3_:TInventory = null;
         _loc2_ = this.FNinjiaVillageData.GetDataByIdentify(FUND_BASE_ID + param1);
         if(_loc2_)
         {
            _loc3_ = _loc2_.Inventories.GetInventoryByIndex(0);
            UIComponentsHintOnOver(this,_loc3_);
         }
      }
      
      protected function ProcessorOnTreeBoxOut(param1:int) : void
      {
         var _loc2_:TNinjiaVillageBaseData = null;
         var _loc3_:TInventory = null;
         _loc2_ = this.FNinjiaVillageData.GetDataByIdentify(FUND_BASE_ID + param1);
         if(_loc2_)
         {
            _loc3_ = _loc2_.Inventories.GetInventoryByIndex(0);
            UIComponentsHintOnOut(this,_loc3_);
         }
      }
      
      protected function ProcessorBuyLvUpBoxReq(param1:int) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:int = 0;
         FIndex = param1;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_NinjiaVillage_BuyLvUpBoxReq);
         _loc2_.Data.writeUnsignedInt(FIndex + 1);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function ProcessorBuyFundReq(param1:int) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         FIndex = param1;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_BaseActivity_GetRewardReq);
         _loc2_.Data.writeUnsignedInt(FActivityID);
         _loc2_.Data.writeUnsignedInt(FIndex + 1);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function ProcessorBuyBoxReq(param1:int) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:int = 0;
         FIndex = param1;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_BaseActivity_BuyBoxReq);
         _loc2_.Data.writeUnsignedInt(FActivityID);
         _loc2_.Data.writeUnsignedInt(FIndex + 1);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount(param1);
         if(!FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowNinjiaVillageLvUp.Load();
            this.FProcessorWindowNinjiaVillageFund.Load();
            this.FProcessorWindowNinjiaVillageFiveCountry.Load();
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
         this.FProcessorWindowNinjiaVillageLvUp.Visible = false;
         this.FProcessorWindowNinjiaVillageFund.Visible = false;
         this.FProcessorWindowNinjiaVillageFiveCountry.Visible = false;
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
         this.FUnstreamizerNinjiaVillage.Unstreamize(_loc2_,this.FNinjiaVillageData,null);
         if(FIsResourcesLoadCompleted && this.visible)
         {
            this.UpdateUI();
         }
      }
      
      public function ProcessorOnBuyLvUpBoxRet(param1:TPacket = null) : void
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
         this.FProcessorWindowNinjiaVillageLvUp.BeClicked = false;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         this.FNinjiaVillageData.GetDataByIdentify(LEVEL_UP_BASE_ID + FIndex).Status = TBaseActivity.STATUS_GETED;
         _loc5_ = this.FNinjiaVillageData.GetDataByIdentify(LEVEL_UP_BASE_ID + FIndex).Inventories.GetInventoryByIndex(0);
         _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
         _loc4_ = _loc4_ + (_loc5_.Name + "*" + _loc5_.Quantity + "\n");
         ProcessorEffectText(_loc4_);
         this.UpdateUI();
      }
      
      override public function ProcessorGetRewardRet(param1:TPacket = null) : void
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
         this.FProcessorWindowNinjiaVillageFund.BeClicked = false;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         this.FNinjiaVillageData.FundID = FUND_BASE_ID + FIndex;
         _loc6_ = this.FNinjiaVillageData.GetDataByIdentify(FUND_BASE_ID + FIndex).Inventories;
         _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
         _loc7_ = 0;
         while(_loc7_ < _loc6_.Count)
         {
            _loc4_ += _loc6_.GetInventoryByIndex(_loc7_).Name + "*" + _loc6_.GetInventoryByIndex(_loc7_).Quantity + "\n";
            _loc7_++;
         }
         ProcessorEffectText(_loc4_);
         this.UpdateUI();
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
         this.FProcessorWindowNinjiaVillageFiveCountry.BeClicked = false;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         this.FNinjiaVillageData.GetDataByIdentify(FIVE_COUNTRY_BASE_ID + FIndex).Status = TBaseActivity.STATUS_GETED;
         if(FIndex < FIVE_COUNTRY - 1)
         {
            this.FNinjiaVillageData.GetDataByIdentify(FIVE_COUNTRY_BASE_ID + FIndex + 1).Status = TBaseActivity.STATUS_CANGET;
         }
         _loc8_ = _loc2_.readShort();
         _loc8_ = int(_loc2_.readUnsignedInt());
         this.FNinjiaVillageData.GetDataByIdentify(FIVE_COUNTRY_BASE_ID + FIndex).ReturnGift = _loc8_;
         _loc4_ = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_GET_GIFT,_loc8_);
         ProcessorEffectText(_loc4_);
         this.UpdateUI();
      }
      
      public function TestInit0() : ByteArray
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:ByteArray = new ByteArray();
         var _loc4_:Vector.<int> = Vector.<int>([50001,50002,50003,51001,51002,51003,51004,51005,52001,52002,52003,52004,52005]);
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeShort(13);
         _loc1_ = 0;
         while(_loc1_ < 13)
         {
            _loc3_.writeUnsignedInt(_loc4_[_loc1_]);
            _loc3_.writeInt(0);
            _loc3_.writeUnsignedInt(_loc1_ + 1);
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

