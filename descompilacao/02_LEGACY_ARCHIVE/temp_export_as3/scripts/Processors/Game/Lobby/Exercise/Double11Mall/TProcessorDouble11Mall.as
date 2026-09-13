package Processors.Game.Lobby.Exercise.Double11Mall
{
   import Components.Pages.TUIPage;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.Exercise.Double11Mall.TDouble11Mall;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.SLogicsCore;
   import Logics.Streamization.Exercise.TUnstreamizerDouble11Mall;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIShowItem;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorBaseActivity;
   import Processors.Game.Windows.Information.TUIWindowConfirmation;
   import Resources.Constants.CONST_BASEACTIVITY;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_CONFIGVALUE;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_DOUBLE11MALL;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Strings.STRING_BASEACTIVITY;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   
   public class TProcessorDouble11Mall extends TProcessorBaseActivity
   {
      
      private var FTabGroup:Array = new Array();
      
      private const TAB_COUNT:int = 7;
      
      private var FMCActivity:MovieClip;
      
      private var FChangeTabIndex:int = -1;
      
      private var FUIPage:TUIPage;
      
      private const PAGE_MAX_SIZE:int = 10;
      
      private var FCurPage:int;
      
      private var FShowItemList:Vector.<TUIShowItem>;
      
      private var FUnstreamizerDouble11Mall:TUnstreamizerDouble11Mall;
      
      private var FDouble11Mall:TDouble11Mall;
      
      private var FTF_Keys:TextField;
      
      private var FBTN_Exchange:MovieClip;
      
      private var FTF_Count:TextField;
      
      private var FSaleItems:Vector.<TBaseBox>;
      
      private var FBeClicked:Boolean;
      
      private var FUIWindowConfirmation1:TUIWindowConfirmation;
      
      private var FTF_Recharge:TextField;
      
      public function TProcessorDouble11Mall(param1:TUIComponent, param2:TLobbyParameters, param3:int)
      {
         super(param1,param2,param3);
         this.FUnstreamizerDouble11Mall = new TUnstreamizerDouble11Mall();
         this.FDouble11Mall = SLogicsCore.Double11Mall;
         this.FUIWindowConfirmation1 = new TUIWindowConfirmation(this.Parent);
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         var _loc3_:TUIShowItem = null;
         super.ResourcesPerform_UIDispatch();
         this.FMCActivity = FMC_Scene[CONST_DOUBLE11MALL.RESOURCE_Link_MC_Activity];
         this.FTF_Keys = this.FMCActivity[CONST_DOUBLE11MALL.RESOURCE_Link_TF_Keys];
         FTF_Date = this.FMCActivity[CONST_BASEACTIVITY.RESOURCE_Link_TF_Date];
         this.FTF_Count = this.FMCActivity[CONST_DOUBLE11MALL.RESOURCE_Link_TF_Count];
         this.FTF_Recharge = this.FMCActivity[CONST_DOUBLE11MALL.RESOURCE_Link_TF_Recharge];
         this.FBTN_Exchange = this.FMCActivity[CONST_DOUBLE11MALL.RESOURCE_Link_Btn_Exchange];
         TGameUtil.setButtonMode(this.FBTN_Exchange,true);
         _loc1_ = 0;
         while(_loc1_ < this.TAB_COUNT)
         {
            _loc2_ = FMC_Scene[CONST_DOUBLE11MALL.RESOURCE_Link_MC_Tab + _loc1_];
            _loc2_.buttonMode = true;
            _loc2_.MC_Name.gotoAndStop(_loc1_ + 1);
            _loc2_.addEventListener(MouseEvent.CLICK,this.ProcessorOnTabChange);
            this.FTabGroup.push(_loc2_);
            _loc1_++;
         }
         this.FShowItemList = new Vector.<TUIShowItem>();
         _loc1_ = 0;
         while(_loc1_ < this.PAGE_MAX_SIZE)
         {
            _loc3_ = new TUIShowItem(this,1);
            _loc3_.Perform_UIDispatch(this.FMCActivity["MC_Item" + _loc1_]);
            _loc3_.OnOverlay = UIComponentsHintOnOver;
            _loc3_.OnOut = UIComponentsHintOnOut;
            _loc3_.OnShowRecruit = this.ProcessorOnShowRecruit;
            this.FShowItemList.push(_loc3_);
            this.FMCActivity["MC_Item" + _loc1_].BTN_Exchange.addEventListener(MouseEvent.CLICK,this.ProcessorOnBuyUp);
            _loc1_++;
         }
         this.FUIPage = new TUIPage(this);
         this.FUIPage.ButtonPrevious.Substrate = this.FMCActivity.MC_ChangePage.MC_PageLeft;
         this.FUIPage.ButtonNext.Substrate = this.FMCActivity.MC_ChangePage.MC_PageRight;
         this.FUIPage.LabelPage = this.FMCActivity.MC_ChangePage.TF_Page;
         this.FUIPage.OnChangePage = this.ProcessorOnChangePage;
         this.FUIPage.PageSize = this.PAGE_MAX_SIZE;
         this.FUIWindowConfirmation1.OnOK = this.WindowConfirmationOnOK1;
         this.FUIWindowConfirmation1.x = (CONST_COMMON.STAGE_Width - this.FUIWindowConfirmation1.WindowWidth) / 2;
         this.FUIWindowConfirmation1.y = (CONST_COMMON.STAGE_Height - this.FUIWindowConfirmation1.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowConfirmation1);
         this.FUIWindowConfirmation1.SetCheckBox(true);
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
         this.FBTN_Exchange.addEventListener(MouseEvent.CLICK,this.ProcessorOnGetReward);
      }
      
      override protected function UpdateUI() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TBaseBox = null;
         var _loc4_:String = null;
         this.FTF_Keys.text = this.FDouble11Mall.Keys.toString();
         this.FTF_Count.text = this.FDouble11Mall.NumList[this.FChangeTabIndex].toString();
         FTF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FDouble11Mall.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FDouble11Mall.EndTime) - 1) * 1000)));
         this.FTF_Recharge.text = this.FDouble11Mall.TotalRechargeGold.toString();
         this.FSaleItems = this.getSaleItemsListByTabType(this.FChangeTabIndex + 1);
         this.FUIPage.TotalQuantity = this.FSaleItems.length;
         this.FUIPage.Update();
         _loc1_ = 0;
         while(_loc1_ < this.PAGE_MAX_SIZE)
         {
            _loc2_ = _loc1_ + this.FCurPage * this.PAGE_MAX_SIZE;
            if(_loc2_ < this.FSaleItems.length)
            {
               this.FMCActivity["MC_Item" + _loc1_].visible = true;
               _loc3_ = this.FSaleItems[_loc2_];
               this.FShowItemList[_loc1_].UpdateUI(_loc3_.Inventories);
               _loc4_ = _loc3_.Price.toString();
               this.FShowItemList[_loc1_].SetDescText(0,_loc4_);
               TGameUtil.setButtonMode(this.FMCActivity["MC_Item" + _loc1_].BTN_Exchange,true);
               if(_loc3_.Count <= _loc3_.BuyCount)
               {
                  this.FShowItemList[_loc1_].SetMCVisible("MC_Got",true);
                  this.FShowItemList[_loc1_].SetMCVisible("BTN_Exchange",false);
               }
               else
               {
                  this.FShowItemList[_loc1_].SetMCVisible("MC_Got",false);
                  this.FShowItemList[_loc1_].SetMCVisible("BTN_Exchange",true);
               }
            }
            else
            {
               this.FMCActivity["MC_Item" + _loc1_].visible = false;
            }
            _loc1_++;
         }
      }
      
      override protected function PerformPacket_CS_LoadInfoReq() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:int = 0;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_HappyTreasure_LoadInfoReq);
         _loc1_.Data.writeUnsignedInt(FActivityID);
         _loc1_.Data.writeUnsignedInt(this.FChangeTabIndex == 0 ? 1 : uint(this.FChangeTabIndex));
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         if(FIsResourcesLoadCompleted)
         {
            _loc1_ = 0;
            while(_loc1_ < this.PAGE_MAX_SIZE)
            {
               if(this.FShowItemList[_loc1_])
               {
                  this.FShowItemList[_loc1_].LogicsPerform();
               }
               _loc1_++;
            }
         }
         super.LogicsPerform();
      }
      
      override public function ProcessorOnLoadInfoRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            OnClose(this);
            return;
         }
         this.FUnstreamizerDouble11Mall.Unstreamize(_loc2_,this.FDouble11Mall,null);
         this.ProcessorOnTabChange();
      }
      
      override public function ProcessorBuyBoxRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:TInventories = null;
         var _loc6_:int = 0;
         this.FBeClicked = false;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
         _loc5_ = this.FSaleItems[FIndex].Inventories;
         _loc6_ = 0;
         while(_loc6_ < _loc5_.Count)
         {
            _loc4_ += _loc5_.GetInventoryByIndex(_loc6_).Name + "*" + _loc5_.GetInventoryByIndex(_loc6_).Quantity + "\n";
            _loc6_++;
         }
         ProcessorEffectText(_loc4_);
         ++this.FSaleItems[FIndex].BuyCount;
         --this.FDouble11Mall.NumList[this.FChangeTabIndex];
         this.UpdateUI();
      }
      
      override public function ProcessorGetRewardRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:TConfigValue = null;
         var _loc6_:Array = null;
         _loc5_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.Duihuan) as TConfigValue;
         _loc6_ = _loc5_.Value[this.FChangeTabIndex];
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc4_ = STRING_BASEACTIVITY.FORMAT_GET;
         ProcessorEffectText(_loc4_);
         this.FDouble11Mall.NumList[this.FChangeTabIndex] += _loc6_[1];
         --this.FDouble11Mall.Keys;
         this.UpdateUI();
      }
      
      protected function ProcessorOnBuyUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(this.FBeClicked)
         {
            return;
         }
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         FIndex = _loc2_ + this.FCurPage * this.PAGE_MAX_SIZE;
         if(!FUIWindowConfirmation.IsSelected)
         {
            FUIWindowConfirmation.Text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_ConfirmGold,this.FSaleItems[FIndex].Price);
            FUIWindowConfirmation.SetCheckBox(true);
            FUIWindowConfirmation.Visible = true;
         }
         else
         {
            this.WindowConfirmationOnOK();
         }
      }
      
      override protected function WindowConfirmationOnOK(param1:Object = null) : void
      {
         if(this.FDouble11Mall.IsGoldEnough(this.FSaleItems[FIndex].Price))
         {
            this.PerformPacket_CS_BuyBoxReq();
         }
         else
         {
            ProcessorOnShowGotoRecharge();
         }
      }
      
      override protected function PerformPacket_CS_BuyBoxReq(param1:MouseEvent = null) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:int = 0;
         var _loc4_:TBaseBox = null;
         this.FBeClicked = true;
         _loc4_ = this.FSaleItems[FIndex];
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_BaseActivity_BuyBoxReq);
         _loc2_.Data.writeUnsignedInt(ActivityID);
         _loc2_.Data.writeUnsignedInt(_loc4_.Identify);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      override protected function PerformPacket_CS_GetRewardReq(param1:MouseEvent = null) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_BaseActivity_GetRewardReq);
         _loc2_.Data.writeUnsignedInt(FActivityID);
         _loc2_.Data.writeUnsignedInt(this.FChangeTabIndex + 1);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function ProcessorOnGetReward(param1:MouseEvent) : void
      {
         var _loc2_:TConfigValue = null;
         var _loc3_:Array = null;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.Duihuan) as TConfigValue;
         _loc3_ = _loc2_.Value[this.FChangeTabIndex];
         if(!this.FUIWindowConfirmation1.IsSelected)
         {
            this.FUIWindowConfirmation1.Text = TUtilityString.Format(this.FDouble11Mall.DescListNew[1],_loc3_[1]);
            this.FUIWindowConfirmation1.SetCheckBox(true);
            this.FUIWindowConfirmation1.Visible = true;
         }
         else
         {
            this.WindowConfirmationOnOK1();
         }
      }
      
      protected function WindowConfirmationOnOK1(param1:Object = null) : void
      {
         this.PerformPacket_CS_GetRewardReq();
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount(param1);
         if(!FIsResourcesLoadCompleted)
         {
            this.FUIWindowConfirmation1.Load();
            return;
         }
         this.visible = true;
         this.PerformPacket_CS_LoadInfoReq();
      }
      
      override public function Unmount() : void
      {
         super.Unmount();
         this.FUIWindowConfirmation1.Visible = false;
      }
      
      private function ProcessorOnTabChange(param1:MouseEvent = null) : void
      {
         var _loc2_:int = 0;
         if(param1)
         {
            _loc2_ = int(String(param1.currentTarget.name).slice(6));
         }
         if(this.FTabGroup[this.FChangeTabIndex])
         {
            this.FTabGroup[this.FChangeTabIndex].gotoAndStop(1);
         }
         this.FChangeTabIndex = _loc2_;
         this.FTabGroup[_loc2_].gotoAndStop(2);
         this.FCurPage = 0;
         this.FUIPage.PageIndex = 0;
         this.UpdateUI();
      }
      
      private function ProcessorOnChangePage(param1:Object, param2:int) : void
      {
         var _loc3_:int = 0;
         var _loc4_:TBaseBox = null;
         var _loc5_:String = null;
         this.FCurPage = param2;
         var _loc6_:int = 0;
         while(_loc6_ < this.PAGE_MAX_SIZE)
         {
            _loc3_ = _loc6_ + this.FCurPage * this.PAGE_MAX_SIZE;
            if(_loc3_ < this.FSaleItems.length)
            {
               this.FMCActivity["MC_Item" + _loc6_].visible = true;
               _loc4_ = this.FSaleItems[_loc3_];
               this.FShowItemList[_loc6_].UpdateUI(_loc4_.Inventories);
               _loc5_ = _loc4_.Price.toString();
               this.FShowItemList[_loc6_].SetDescText(0,_loc5_);
               TGameUtil.setButtonMode(this.FMCActivity["MC_Item" + _loc6_].BTN_Exchange,true);
               if(_loc4_.Count <= _loc4_.BuyCount)
               {
                  this.FShowItemList[_loc6_].SetMCVisible("MC_Got",true);
                  this.FShowItemList[_loc6_].SetMCVisible("BTN_Exchange",false);
               }
               else
               {
                  this.FShowItemList[_loc6_].SetMCVisible("MC_Got",false);
                  this.FShowItemList[_loc6_].SetMCVisible("BTN_Exchange",true);
               }
            }
            else
            {
               this.FMCActivity["MC_Item" + _loc6_].visible = false;
            }
            _loc6_++;
         }
      }
      
      private function getSaleItemsListByTabType(param1:int) : Vector.<TBaseBox>
      {
         var _loc4_:TBaseBox = null;
         var _loc2_:Vector.<TBaseBox> = this.FDouble11Mall.SaleItems;
         var _loc3_:Vector.<TBaseBox> = new Vector.<TBaseBox>();
         if(_loc2_)
         {
            for each(_loc4_ in _loc2_)
            {
               if(Boolean(_loc4_) && _loc4_.Type == param1)
               {
                  _loc3_.push(_loc4_);
               }
            }
         }
         return _loc3_;
      }
      
      protected function ProcessorOnShowRecruit(param1:uint, param2:int = 0) : void
      {
         ProcessorOnShowItemDesc(param1,param2);
      }
      
      override protected function ProcessorOnOpenDesc(param1:MouseEvent = null) : void
      {
         ProcessorOnOpenDescNew(this.FDouble11Mall.DescListNew[0]);
      }
   }
}

