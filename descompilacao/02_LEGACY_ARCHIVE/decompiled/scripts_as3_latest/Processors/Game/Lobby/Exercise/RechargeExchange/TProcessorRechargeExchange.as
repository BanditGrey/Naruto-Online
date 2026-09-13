package Processors.Game.Lobby.Exercise.RechargeExchange
{
   import Components.Pages.TUIPage;
   import Externals.SExternalCore;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.RechargeExchange.TRechargeExchange;
   import Logics.Exercise.TBaseActivity;
   import Logics.Inventories.TInventories;
   import Logics.SLogicsCore;
   import Logics.Streamization.Exercise.TUnstreamizerRechargeExchange;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseBar;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseBox;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorBaseActivity;
   import Processors.Game.Lobby.Exercise.RechargeExchange.Compoents.TUIMonsterItem;
   import Resources.Constants.CONST_BASEACTIVITY;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   
   public class TProcessorRechargeExchange extends TProcessorBaseActivity
   {
      
      protected static const BOX_COUNT:int = 6;
      
      protected var FRechargeExchange:TRechargeExchange;
      
      protected var FBeClicked:Boolean;
      
      protected var FTF_TotalRecharge:TextField;
      
      protected var FTF_MaxValue:TextField;
      
      protected var FMC_PetPic:MovieClip;
      
      protected var FMC_SmallPet:MovieClip;
      
      protected var FMC_ChangePage:MovieClip;
      
      protected var FMC_Buff:MovieClip;
      
      protected var FUIPage:TUIPage;
      
      protected var FTotalPage:int;
      
      protected var FCurPage:int;
      
      protected var FUIGetBox:TUIBaseBox;
      
      protected var FUIBuyBox:TUIBaseBox;
      
      protected var FUIBar:TUIBaseBar;
      
      protected var FUnstreamizerRechargeExchange:TUnstreamizerRechargeExchange;
      
      private var monsterList:Array;
      
      public function TProcessorRechargeExchange(param1:TUIComponent, param2:TLobbyParameters, param3:uint)
      {
         super(param1,param2,param3);
         this.FUIPage = new TUIPage(this);
         FActivityID = param3;
         this.FRechargeExchange = SLogicsCore.RechargeExchange;
         this.FUnstreamizerRechargeExchange = new TUnstreamizerRechargeExchange();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:MovieClip = null;
         super.ResourcesPerform_UIDispatch();
         this.FMC_ChangePage = FMC_Scene[CONST_BASEACTIVITY.RESOURCE_Link_MC_ChangePage];
         this.FUIPage.ButtonPrevious.Substrate = this.FMC_ChangePage.MC_PageLeft;
         this.FUIPage.ButtonNext.Substrate = this.FMC_ChangePage.MC_PageRight;
         this.FUIPage.LabelPage = this.FMC_ChangePage.TF_Page;
         this.FUIPage.TotalQuantity = this.FTotalPage;
         this.FUIPage.PageSize = 1;
         this.FUIPage.PageIndex = 0;
         this.FCurPage = 0;
         this.FUIPage.OnChangePage = this.ProcessorPageOnChange;
         this.FTF_TotalRecharge = FMC_Scene["TF_TotalRecharge"];
         this.FTF_MaxValue = FMC_Scene["TF_MaxValue"];
         this.FMC_PetPic = FMC_Scene["MC_PetPic"];
         this.FMC_SmallPet = FMC_Scene["MC_SmallPet"];
         this.FMC_Buff = FMC_Scene["MC_Buff"];
         this.FUIGetBox = new TUIBaseBox(this,BOX_COUNT);
         this.FUIGetBox.Perform_UIDispatch(FMC_Scene.MC_GetItem);
         this.FUIGetBox.OnOverlay = UIComponentsHintOnOver;
         this.FUIGetBox.OnOut = UIComponentsHintOnOut;
         this.FUIGetBox.OnGetBox = this.ProcessorOnGetUp;
         this.FUIBuyBox = new TUIBaseBox(this,BOX_COUNT);
         this.FUIBuyBox.Perform_UIDispatch(FMC_Scene.MC_BuyItem);
         this.FUIBuyBox.OnOverlay = UIComponentsHintOnOver;
         this.FUIBuyBox.OnOut = UIComponentsHintOnOut;
         this.FUIBuyBox.OnGetBox = this.ProcessorOnBuyUp;
         this.FUIBar = new TUIBaseBar(this);
         this.FUIBar.Perform_UIDispatch(FMC_Scene.MC_AccumBar);
         this.initMonsterItems();
      }
      
      private function initMonsterItems() : void
      {
         var _loc1_:TUIMonsterItem = null;
         this.monsterList = [];
         var _loc2_:int = 0;
         while(_loc2_ < 10)
         {
            _loc1_ = new TUIMonsterItem(this);
            _loc1_.monsterIndex = _loc2_;
            _loc1_.resource = FMC_Scene["mc_monsterItem" + _loc2_.toString()];
            _loc1_.init();
            this.monsterList.push(_loc1_);
            _loc2_++;
         }
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
         FMC_Scene["BTN_Recharge"].addEventListener(MouseEvent.CLICK,this.ProcessorOnGotoRecharge);
         TGameUtil.setButtonMode(FMC_Scene["BTN_Recharge"],true);
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         if(FInitialized)
         {
            if(this.visible)
            {
               if(this.FUIGetBox)
               {
                  this.FUIGetBox.LogicsPerform();
               }
               if(this.FUIBuyBox)
               {
                  this.FUIBuyBox.LogicsPerform();
               }
            }
         }
      }
      
      override protected function UpdateUI() : void
      {
         super.UpdateUI();
         this.UpdateBox();
         this.UpdateText();
         this.UpdateBar();
         this.UpdatePet();
      }
      
      protected function UpdateBox() : void
      {
         var _loc1_:TInventories = null;
         var _loc2_:TInventories = null;
         var _loc3_:String = null;
         this.FUIPage.TotalQuantity = this.FRechargeExchange.GetBoxVect.length;
         this.FUIPage.Update();
         _loc1_ = this.FRechargeExchange.GetBoxVect[this.FCurPage].Inventories;
         this.FUIGetBox.UpdateUI(_loc1_);
         if(this.FRechargeExchange.GetBoxVect[this.FCurPage].Status == TBaseActivity.STATUS_CANGET)
         {
            this.FUIGetBox.SetBtnMode(true);
         }
         else
         {
            this.FUIGetBox.SetBtnMode(false);
         }
         _loc2_ = this.FRechargeExchange.BuyBoxVect[this.FCurPage].Inventories;
         this.FUIBuyBox.UpdateUI(_loc2_);
         if(this.FRechargeExchange.BuyBoxVect[this.FCurPage].Status == TBaseActivity.STATUS_CANGET && this.FRechargeExchange.BuyBoxVect[this.FCurPage].BuyCount < this.FRechargeExchange.BuyBoxVect[this.FCurPage].Count)
         {
            this.FUIBuyBox.SetBtnMode(true);
         }
         else
         {
            this.FUIBuyBox.SetBtnMode(false);
         }
         _loc3_ = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_BUY_COUNT,this.FRechargeExchange.BuyBoxVect[this.FCurPage].Count - this.FRechargeExchange.BuyBoxVect[this.FCurPage].BuyCount,this.FRechargeExchange.BuyBoxVect[this.FCurPage].Count);
         this.FUIBuyBox.SetCountText(_loc3_);
         _loc3_ = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_BUY_PRICE,this.FRechargeExchange.BuyBoxVect[this.FCurPage].Price);
         this.FUIBuyBox.SetPriceText(_loc3_);
         this.FMC_Buff.TF_Buff.text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_LIMIT_COUNT,this.FRechargeExchange.BuyBoxVect[this.FCurPage].Count);
      }
      
      protected function UpdateText() : void
      {
         this.FTF_MaxValue.text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_PAY_LIMIT,this.FRechargeExchange.RechargeVect[this.FCurPage + 1]);
         this.FTF_TotalRecharge.text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_TOTAL_RECHARGE,this.FRechargeExchange.TotalRecharge);
         FTF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FRechargeExchange.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FRechargeExchange.EndTime - 1) * 1000)));
         FTF_Desc.text = this.FRechargeExchange.ActivityDesc;
      }
      
      protected function UpdateBar() : void
      {
         var _loc1_:int = 0;
         var _loc2_:String = null;
         if(this.FCurPage + 1 < this.FRechargeExchange.RechargeVect.length)
         {
            _loc1_ = Math.max(0,this.FRechargeExchange.TotalRecharge - this.FRechargeExchange.RechargeVect[this.FCurPage]);
            this.FUIBar.UpdateUI(_loc1_,this.FRechargeExchange.RechargeVect[this.FCurPage],this.FRechargeExchange.RechargeVect[this.FCurPage + 1]);
            if(this.FRechargeExchange.TotalRecharge < this.FRechargeExchange.RechargeVect[this.FCurPage + 1])
            {
               _loc2_ = this.FRechargeExchange.TotalRecharge + "/" + this.FRechargeExchange.RechargeVect[this.FCurPage + 1];
            }
            else
            {
               _loc2_ = this.FRechargeExchange.RechargeVect[this.FCurPage + 1] + "/" + this.FRechargeExchange.RechargeVect[this.FCurPage + 1];
            }
            this.FUIBar.UpdateCurValue(_loc2_);
         }
      }
      
      protected function UpdatePet() : void
      {
         this.FMC_PetPic.gotoAndStop(this.FCurPage + 1);
         if(this.FRechargeExchange.CheckBoxStatus())
         {
            this.FMC_SmallPet.visible = true;
            this.FMC_SmallPet.gotoAndStop(this.FRechargeExchange.CurIndex + 1);
         }
         else
         {
            this.FMC_SmallPet.visible = false;
         }
      }
      
      protected function ProcessorPageOnChange(param1:Object, param2:int) : void
      {
         this.FCurPage = param2;
         this.UpdateUI();
      }
      
      public function setProcessorPageOnChange(param1:int) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < 10)
         {
            if(_loc2_ != param1)
            {
               (this.monsterList[_loc2_] as TUIMonsterItem).cancelSelect();
            }
            _loc2_++;
         }
         this.FCurPage = param1;
         this.UpdateUI();
      }
      
      override protected function PerformPacket_CS_LoadInfoReq() : void
      {
         super.PerformPacket_CS_LoadInfoReq();
      }
      
      protected function ProcessorOnGetUp(param1:MouseEvent = null) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:int = 0;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         FIndex = this.FCurPage;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_BaseActivity_GetRewardReq);
         _loc2_.Data.writeUnsignedInt(FActivityID);
         _loc2_.Data.writeUnsignedInt(FIndex + 1);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function ProcessorOnBuyUp(param1:MouseEvent = null) : void
      {
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(this.FBeClicked)
         {
            return;
         }
         if(!FUIWindowConfirmation.IsSelected)
         {
            FUIWindowConfirmation.Text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_ConfirmGold,this.FRechargeExchange.BuyBoxVect[this.FCurPage].Price);
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
         if(this.FRechargeExchange.IsGoldEnough(this.FRechargeExchange.BuyBoxVect[this.FCurPage].Price))
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
         var _loc4_:int = 0;
         if(this.FBeClicked)
         {
            return;
         }
         FIndex = this.FCurPage;
         this.FBeClicked = true;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_BaseActivity_BuyBoxReq);
         _loc2_.Data.writeUnsignedInt(ActivityID);
         _loc2_.Data.writeUnsignedInt(FIndex + 1);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function ProcessorOnGotoRecharge(param1:MouseEvent) : void
      {
         SExternalCore.NavigateToRecharge();
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount(param1);
         if(!FIsResourcesLoadCompleted)
         {
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
         this.FUnstreamizerRechargeExchange.Unstreamize(_loc2_,this.FRechargeExchange,null);
         if(FIsResourcesLoadCompleted && this.visible)
         {
            this.FCurPage = this.FUIPage.PageIndex = this.FRechargeExchange.CurIndex;
            this.UpdateUI();
         }
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
         _loc5_ = this.FRechargeExchange.BuyBoxVect[FIndex].Inventories;
         _loc6_ = 0;
         while(_loc6_ < _loc5_.Count)
         {
            _loc4_ += _loc5_.GetInventoryByIndex(_loc6_).Name + "*" + _loc5_.GetInventoryByIndex(_loc6_).Quantity + "\n";
            _loc6_++;
         }
         ProcessorEffectText(_loc4_);
         ++this.FRechargeExchange.BuyBoxVect[FIndex].BuyCount;
         this.UpdateUI();
      }
      
      override public function ProcessorGetRewardRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:TInventories = null;
         var _loc6_:int = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            this.UpdateUI();
            return;
         }
         _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
         _loc5_ = this.FRechargeExchange.GetBoxVect[FIndex].Inventories;
         _loc6_ = 0;
         while(_loc6_ < _loc5_.Count)
         {
            _loc4_ += _loc5_.GetInventoryByIndex(_loc6_).Name + "*" + _loc5_.GetInventoryByIndex(_loc6_).Quantity + "\n";
            _loc6_++;
         }
         ProcessorEffectText(_loc4_);
         this.FRechargeExchange.GetBoxVect[FIndex].Status = TBaseActivity.STATUS_GETED;
         this.UpdateUI();
         if(this.FRechargeExchange.CheckStatus())
         {
            ProcessorCheckEffect(FActivityID,true);
         }
         else
         {
            ProcessorCheckEffect(FActivityID,false);
         }
      }
      
      override public function ProcessorChangeStatus(param1:TPacket = null) : void
      {
         if(Boolean(FMC_Scene) && FMC_Scene.Visible == true)
         {
            this.PerformPacket_CS_LoadInfoReq();
            this.FUIBar.IsEffectPlay(true);
         }
      }
      
      override public function ProcessorChangeGold(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         _loc2_ = param1.Data;
         _loc3_ = int(_loc2_.readUnsignedShort());
         if(this.FRechargeExchange)
         {
            this.FRechargeExchange.TotalRecharge = _loc2_.readUnsignedInt();
         }
         if(Boolean(FMC_Scene) && FMC_Scene.Visible == true)
         {
            this.PerformPacket_CS_LoadInfoReq();
         }
      }
      
      public function TestInit0() : ByteArray
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:ByteArray = new ByteArray();
         var _loc4_:Vector.<int> = Vector.<int>([1,1,1]);
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeUnsignedInt(1371571200);
         _loc3_.writeUnsignedInt(1401571200);
         TUtilityString.FlushUTF(_loc3_,"欢乐寻宝描述");
         _loc3_.writeUnsignedInt(1000);
         _loc3_.writeShort(4);
         _loc1_ = 0;
         while(_loc1_ < 4)
         {
            _loc3_.writeUnsignedInt(_loc1_ * 100);
            _loc1_++;
         }
         _loc3_.writeShort(3);
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            _loc3_.writeUnsignedInt(_loc4_[_loc1_]);
            _loc3_.writeShort(8);
            _loc2_ = 0;
            while(_loc2_ < 8)
            {
               _loc3_.writeUnsignedInt(1);
               _loc3_.writeUnsignedInt(14100001 + _loc2_ + _loc1_);
               _loc3_.writeUnsignedInt(_loc2_ + _loc1_ + 1);
               _loc2_++;
            }
            _loc1_++;
         }
         _loc3_.writeShort(3);
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            _loc3_.writeUnsignedInt(_loc1_ + 1);
            _loc3_.writeUnsignedInt(0);
            _loc3_.writeUnsignedInt(_loc1_ + 1);
            _loc3_.writeShort(8);
            _loc2_ = 0;
            while(_loc2_ < 8)
            {
               _loc3_.writeUnsignedInt(1);
               _loc3_.writeUnsignedInt(14100001 + _loc2_ + _loc1_);
               _loc3_.writeUnsignedInt(_loc2_ + _loc1_ + 1);
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

