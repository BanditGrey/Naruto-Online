package Processors.Game.Lobby.Exercise.NationalDay
{
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityString;
   import Logics.Characters.TCharacter;
   import Logics.Exercise.NationalDay.TNationalDay;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Exercise.TUnstreamizerNationalDay;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorBaseActivity;
   import Processors.Game.Lobby.Tavern.TProcessorWindowRecruit;
   import Rendering.Overlayers.Box.TOverlayerBox;
   import Rendering.Overlayers.NationalDay.TOverlayerFund;
   import Rendering.Overlayers.NationalDay.TOverlayerRewards;
   import Rendering.Overlayers.NationalDay.TOverlayerSimpleNinjia;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Strings.STRING_BASEACTIVITY;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   
   public class TProcessorNationalDay extends TProcessorBaseActivity
   {
      
      public static const TAB_TYPE_GIFT:int = 0;
      
      public static const TAB_TYPE_FUND:int = 1;
      
      public static const TAB_TYPE_NINJIA:int = 2;
      
      public static const BTN_COUNT:int = 3;
      
      public static const CONFIRMATION_TYPE_BUY_FUND:int = 0;
      
      public static const CONFIRMATION_TYPE_GET_STONE:int = 1;
      
      protected var FNationalDay:TNationalDay;
      
      protected var FBeClicked:Boolean;
      
      protected var FProcessorWindowNationalDayGift:TProcessorWindowNationalDayGift;
      
      protected var FProcessorWindowNationalDayFund:TProcessorWindowNationalDayFund;
      
      protected var FProcessorWindowNationalDayNinjia:TProcessorWindowNationalDayNinjia;
      
      protected var FProcessorWindowRecruit:TProcessorWindowRecruit;
      
      protected var FUnstreamizerNationalDay:TUnstreamizerNationalDay;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FChangeTabIndex:int;
      
      protected var FBtnVect:Vector.<MovieClip>;
      
      protected var FOverlayerBox:TOverlayerBox;
      
      protected var FOverlayerFund:TOverlayerFund;
      
      protected var FOverlayerSimpleNinjia:TOverlayerSimpleNinjia;
      
      protected var FOverlayerRewards:TOverlayerRewards;
      
      protected var FArticleBins:TBins;
      
      protected var FConfirmationType:int;
      
      public function TProcessorNationalDay(param1:TUIComponent, param2:TLobbyParameters, param3:uint)
      {
         super(param1,param2,param3);
         FActivityID = param3;
         this.FNationalDay = SLogicsCore.NationalDay;
         this.FUnstreamizerNationalDay = new TUnstreamizerNationalDay();
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         this.FBtnVect = new Vector.<MovieClip>(BTN_COUNT);
         this.FOverlayerBox = new TOverlayerBox(this.Parent);
         this.FOverlayerBox.Visible = false;
         this.FOverlayerFund = new TOverlayerFund(this.Parent);
         this.FOverlayerFund.Visible = false;
         this.FOverlayerSimpleNinjia = new TOverlayerSimpleNinjia(this.Parent);
         this.FOverlayerSimpleNinjia.Visible = false;
         this.FOverlayerRewards = new TOverlayerRewards(this.Parent);
         this.FOverlayerRewards.Visible = false;
         this.FProcessorWindowRecruit = new TProcessorWindowRecruit(this.Parent);
         this.FProcessorWindowRecruit.Visible = false;
         this.FProcessorWindowRecruit.OnEffectText = FOnEffectText;
         this.FProcessorWindowRecruit.HintOnOver = ProcessorTipOnOver;
         this.FProcessorWindowRecruit.HintOnOut = ProcessorTipOnOut;
         this.FProcessorWindowRecruit.x = (CONST_COMMON.STAGE_Width - 390) / 2;
         this.FProcessorWindowRecruit.y = (CONST_COMMON.STAGE_Height - 358) / 2;
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
            this.FBtnVect[_loc1_] = FMC_Scene["BTN_Goto" + _loc1_];
            this.FBtnVect[_loc1_].gotoAndStop(_loc1_ + 1);
            this.FBtnVect[_loc1_].addEventListener(MouseEvent.CLICK,this.ProcessorOnChangePage);
            this.FBtnVect[_loc1_].buttonMode = true;
            this.FBtnVect[_loc1_].MC_Selected.visible = false;
            _loc1_++;
         }
         this.FBtnVect[0].MC_Selected.visible = true;
         this.FProcessorWindowNationalDayGift = new TProcessorWindowNationalDayGift(this.Parent);
         this.FProcessorWindowNationalDayGift.Perform_UIDispatch(FMC_Scene["MC_NationalDayGift"]);
         this.FProcessorWindowNationalDayGift.OnGetBox = this.ProcessorOnGetUp;
         this.FProcessorWindowNationalDayGift.OnOverlay = this.ProcessorOnBoxOver;
         this.FProcessorWindowNationalDayGift.OnOut = this.ProcessorOnBoxOut;
         this.FProcessorWindowNationalDayGift.Visible = false;
         this.FProcessorWindowNationalDayFund = new TProcessorWindowNationalDayFund(this.Parent);
         this.FProcessorWindowNationalDayFund.Perform_UIDispatch(FMC_Scene["MC_NationalDayFund"]);
         this.FProcessorWindowNationalDayFund.OnGetBox = this.ProcessorOnBuyUp;
         this.FProcessorWindowNationalDayFund.OnOverlay = this.ProcessorOnTreeOver;
         this.FProcessorWindowNationalDayFund.OnOut = this.ProcessorOnTreeOut;
         this.FProcessorWindowNationalDayFund.OnBoxOverlay = this.ProcessorOnTreeBoxOver;
         this.FProcessorWindowNationalDayFund.OnBoxOut = this.ProcessorOnTreeBoxOut;
         this.FProcessorWindowNationalDayFund.Visible = false;
         this.FProcessorWindowNationalDayNinjia = new TProcessorWindowNationalDayNinjia(this.Parent);
         this.FProcessorWindowNationalDayNinjia.Perform_UIDispatch(FMC_Scene["MC_NationalDayNinjia"]);
         this.FProcessorWindowNationalDayNinjia.OnGetBox = this.ProcessorOnStoneUp;
         this.FProcessorWindowNationalDayNinjia.OnOverlay = this.ProcessorOnStoneOver;
         this.FProcessorWindowNationalDayNinjia.OnOut = this.ProcessorOnStoneOut;
         this.FProcessorWindowNationalDayNinjia.OnGetHero = this.ProcessorOnGetHeroUp;
         this.FProcessorWindowNationalDayNinjia.OnShowRecruit = this.ProcessorOnShowRecruit;
         this.FProcessorWindowNationalDayNinjia.OnNinjiaOver = this.ProcessorOnNinjiaOver;
         this.FProcessorWindowNationalDayNinjia.OnNinjiaOut = this.ProcessorOnNinjiaOut;
         this.FProcessorWindowNationalDayNinjia.Visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerBox);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerFund);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerSimpleNinjia);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerRewards);
         this.FArticleBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
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
            if(Boolean(FMC_Scene) && FMC_Scene.visible)
            {
               if(this.FProcessorWindowRecruit != null && this.FProcessorWindowRecruit.Visible == true)
               {
                  this.FProcessorWindowRecruit.UpdataBitmap();
               }
            }
         }
      }
      
      override protected function UpdateUI() : void
      {
         super.UpdateUI();
         this.UpdateBtn();
         this.UpdateText();
         switch(this.FChangeTabIndex)
         {
            case TAB_TYPE_GIFT:
               this.FProcessorWindowNationalDayGift.UpdateUI();
               this.FProcessorWindowNationalDayGift.SetVisible(true);
               this.FProcessorWindowNationalDayFund.SetVisible(false);
               this.FProcessorWindowNationalDayNinjia.SetVisible(false);
               break;
            case TAB_TYPE_FUND:
               this.FProcessorWindowNationalDayFund.UpdateUI();
               this.FProcessorWindowNationalDayGift.SetVisible(false);
               this.FProcessorWindowNationalDayFund.SetVisible(true);
               this.FProcessorWindowNationalDayNinjia.SetVisible(false);
               break;
            case TAB_TYPE_NINJIA:
               this.FProcessorWindowNationalDayNinjia.UpdateUI();
               this.FProcessorWindowNationalDayGift.SetVisible(false);
               this.FProcessorWindowNationalDayFund.SetVisible(false);
               this.FProcessorWindowNationalDayNinjia.SetVisible(true);
         }
      }
      
      protected function UpdateText() : void
      {
         var _loc1_:String = null;
         switch(this.FChangeTabIndex)
         {
            case TAB_TYPE_GIFT:
               _loc1_ = this.FNationalDay.ActivityName.split("%n").join("\n");
               break;
            case TAB_TYPE_FUND:
               _loc1_ = this.FNationalDay.ActivityTabName.split("%n").join("\n");
               break;
            case TAB_TYPE_NINJIA:
               _loc1_ = this.FNationalDay.ActivityDesc.split("%n").join("\n");
         }
         FMC_Scene.TF_Desc.text = _loc1_;
      }
      
      protected function UpdateBtn() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc2_ = int(this.FNationalDay.GiftVect.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(this.FNationalDay.GiftVect[_loc1_].Status == TBaseActivity.STATUS_CANGET)
            {
               this.FBtnVect[0].filters = [TGameUtil.highLightFilters];
               break;
            }
            _loc3_++;
            _loc1_++;
         }
         if(_loc3_ == _loc2_)
         {
            this.FBtnVect[0].filters = [];
         }
         if(this.FNationalDay.FreeTimes > 0)
         {
            this.FBtnVect[2].filters = [TGameUtil.highLightFilters];
         }
         else
         {
            _loc3_ = 0;
            _loc2_ = int(this.FNationalDay.NinjiaVect.length);
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               if(this.FNationalDay.NinjiaVect[_loc1_].Status == TBaseActivity.STATUS_CANGET)
               {
                  this.FBtnVect[2].filters = [TGameUtil.highLightFilters];
                  break;
               }
               _loc3_++;
               _loc1_++;
            }
            if(_loc3_ == _loc2_)
            {
               this.FBtnVect[2].filters = [];
            }
         }
      }
      
      protected function ProcessorOnChangePage(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _loc3_ = int(String(param1.currentTarget.name).slice(8));
         if(_loc3_ == this.FChangeTabIndex)
         {
            return;
         }
         this.FChangeTabIndex = _loc3_;
         _loc4_ = int(this.FBtnVect.length);
         _loc2_ = 0;
         while(_loc2_ < _loc4_)
         {
            if(_loc2_ == _loc3_)
            {
               this.FBtnVect[_loc2_].MC_Selected.visible = true;
            }
            else
            {
               this.FBtnVect[_loc2_].MC_Selected.visible = false;
            }
            _loc2_++;
         }
         this.UpdateUI();
      }
      
      override protected function PerformPacket_CS_LoadInfoReq() : void
      {
         super.PerformPacket_CS_LoadInfoReq();
      }
      
      protected function ProcessorOnGetUp(param1:int) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:int = 0;
         if(this.FBeClicked)
         {
            return;
         }
         this.FBeClicked = true;
         FIndex = param1;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_BaseActivity_GetRewardReq);
         _loc2_.Data.writeUnsignedInt(FActivityID);
         _loc2_.Data.writeUnsignedInt(FIndex + 1);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function ProcessorOnBuyUp(param1:int) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:int = 0;
         if(this.FBeClicked)
         {
            return;
         }
         FIndex = param1;
         this.FConfirmationType = CONFIRMATION_TYPE_BUY_FUND;
         if(!FUIWindowConfirmation.IsSelected)
         {
            FUIWindowConfirmation.Text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_ConfirmGold,this.FNationalDay.FundVect[param1].Price);
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
         var _loc2_:int = 0;
         var _loc3_:TCharacter = null;
         _loc3_ = SLogicsCore.Character;
         if(this.FConfirmationType == CONFIRMATION_TYPE_BUY_FUND)
         {
            _loc2_ = this.FNationalDay.FundVect[FIndex].Price;
            if(_loc3_.CreditGold >= _loc2_)
            {
               this.PerformPacket_CS_BuyBoxReq();
               this.FBeClicked = true;
            }
            else
            {
               FUIWindowRecharge.Visible = true;
            }
         }
         else if(this.FConfirmationType == CONFIRMATION_TYPE_GET_STONE)
         {
            _loc2_ = this.FNationalDay.StoneVect[FIndex].Price;
            if(this.FNationalDay.IsGoldEnough(_loc2_))
            {
               this.FBeClicked = true;
               this.PerformPacket_CS_GetStoneReq();
            }
            else
            {
               FUIWindowRecharge.Visible = true;
            }
         }
      }
      
      override protected function PerformPacket_CS_BuyBoxReq(param1:MouseEvent = null) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:int = 0;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_BaseActivity_BuyBoxReq);
         _loc2_.Data.writeUnsignedInt(ActivityID);
         _loc2_.Data.writeUnsignedInt(FIndex + 1);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function ProcessorOnStoneUp(param1:int) : void
      {
         if(this.FBeClicked)
         {
            return;
         }
         FIndex = param1;
         if(this.FNationalDay.FreeTimes > 0)
         {
            this.PerformPacket_CS_GetStoneReq();
         }
         else
         {
            this.FConfirmationType = CONFIRMATION_TYPE_GET_STONE;
            if(!FUIWindowConfirmation.IsSelected)
            {
               FUIWindowConfirmation.Text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_ConfirmGold,this.FNationalDay.StoneVect[param1].Price);
               FUIWindowConfirmation.SetCheckBox(true);
               FUIWindowConfirmation.Visible = true;
            }
            else
            {
               this.WindowConfirmationOnOK();
            }
         }
      }
      
      protected function PerformPacket_CS_GetStoneReq(param1:MouseEvent = null) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:int = 0;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_NationalDay_GetStoneReq);
         _loc2_.Data.writeUnsignedInt(FIndex + 1);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function ProcessorOnGetHeroUp(param1:int) : void
      {
         var _loc2_:int = 0;
         if(this.FBeClicked)
         {
            return;
         }
         FIndex = param1;
         this.PerformPacket_CS_GetHeroReq();
      }
      
      protected function PerformPacket_CS_GetHeroReq(param1:MouseEvent = null) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:int = 0;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_NationalDay_GetHeroReq);
         _loc2_.Data.writeUnsignedInt(FIndex + 1);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function ProcessorOnBoxOver(param1:int) : void
      {
         if(this.FNationalDay.GiftVect[param1] != null)
         {
            this.FOverlayerBox.Context = this.FNationalDay.GiftVect[param1].Inventories;
            this.FOverlayerBox.Render(FUICore.MouseCoordinate);
            this.FOverlayerBox.Show();
         }
      }
      
      protected function ProcessorOnBoxOut(param1:int = 0) : void
      {
         this.FOverlayerBox.Hide();
      }
      
      protected function ProcessorOnTreeOver(param1:int) : void
      {
         if(this.FNationalDay.FundVect[param1])
         {
            this.FOverlayerFund.Context = this.FNationalDay.FundVect[param1];
            this.FOverlayerFund.Render(FUICore.MouseCoordinate);
            this.FOverlayerFund.Show();
         }
      }
      
      protected function ProcessorOnTreeOut(param1:int) : void
      {
         this.FOverlayerFund.Hide();
      }
      
      protected function ProcessorOnTreeBoxOver(param1:int) : void
      {
         var _loc2_:TInventory = null;
         if(this.FNationalDay.FundVect[param1])
         {
            _loc2_ = this.FNationalDay.FundVect[param1].Inventories.GetInventoryByIndex(0);
            UIComponentsHintOnOver(this,_loc2_);
         }
      }
      
      protected function ProcessorOnTreeBoxOut(param1:int) : void
      {
         var _loc2_:TInventory = null;
         if(this.FNationalDay.FundVect[param1])
         {
            _loc2_ = this.FNationalDay.FundVect[param1].Inventories.GetInventoryByIndex(0);
            UIComponentsHintOnOut(this,_loc2_);
         }
      }
      
      protected function ProcessorOnNinjiaOver(param1:int) : void
      {
         if(this.FNationalDay.NinjiaVect[param1])
         {
            this.FOverlayerSimpleNinjia.Context = this.FNationalDay.NinjiaVect[param1];
            this.FOverlayerSimpleNinjia.Render(FUICore.MouseCoordinate);
            this.FOverlayerSimpleNinjia.Show();
         }
      }
      
      protected function ProcessorOnNinjiaOut() : void
      {
         this.FOverlayerSimpleNinjia.Hide();
      }
      
      protected function ProcessorOnStoneOver(param1:int) : void
      {
         if(this.FNationalDay.FundVect[param1])
         {
            this.FOverlayerRewards.Context = this.FNationalDay.StoneVect[param1];
            this.FOverlayerRewards.Render(FUICore.MouseCoordinate);
            this.FOverlayerRewards.Show();
         }
      }
      
      protected function ProcessorOnStoneOut() : void
      {
         this.FOverlayerRewards.Hide();
      }
      
      protected function ProcessorOnShowRecruit(param1:int) : void
      {
         this.FProcessorWindowRecruit.SetHeroData(uint(this.FNationalDay.NinjiaVect[param1].Identify));
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount(param1);
         if(!FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowRecruit.Load();
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
         this.visible = false;
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
         this.FUnstreamizerNationalDay.Unstreamize(_loc2_,this.FNationalDay,null);
         if(FIsResourcesLoadCompleted && this.visible)
         {
            this.UpdateUI();
         }
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
         _loc5_ = this.FNationalDay.GiftVect[FIndex].Inventories;
         _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
         _loc6_ = 0;
         while(_loc6_ < _loc5_.Count)
         {
            _loc4_ += _loc5_.GetInventoryByIndex(_loc6_).Name + "*" + _loc5_.GetInventoryByIndex(_loc6_).Quantity + "\n";
            _loc6_++;
         }
         ProcessorEffectText(_loc4_);
         this.FNationalDay.GiftVect[FIndex].Status = TBaseActivity.STATUS_GETED;
         if(this.FNationalDay.GiftID < this.FNationalDay.GiftVect.length)
         {
            ++this.FNationalDay.GiftID;
         }
         ProcessorCheckEffect(FActivityID,this.FNationalDay.CheckBoxStatus());
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
         this.FBeClicked = false;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         this.FNationalDay.FundID = FIndex + 1;
         _loc6_ = this.FNationalDay.FundVect[FIndex].Inventories;
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
      
      override public function ProcessorChangeStatus(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         ProcessorCheckEffect(FActivityID,true);
      }
      
      override public function ProcessorGetStone(param1:TPacket = null) : void
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
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:uint = 0;
         var _loc14_:Vector.<uint> = null;
         var _loc15_:Vector.<uint> = null;
         this.FBeClicked = false;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         if(this.FNationalDay.FreeTimes > 0)
         {
            --this.FNationalDay.FreeTimes;
         }
         this.FNationalDay.Stones += this.FNationalDay.StoneVect[FIndex].Max;
         _loc8_ = int(_loc2_.readUnsignedShort());
         _loc11_ = _loc2_.readInt();
         this.FNationalDay.ChangeStoneStatus(FIndex,_loc11_);
         this.FNationalDay.ChangeHeroStatus();
         _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
         _loc4_ = _loc4_ + TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_NATIONAL_DAY_ITEM_NAME,this.FNationalDay.StoneVect[FIndex].Max);
         ProcessorEffectText(_loc4_);
         ProcessorCheckEffect(FActivityID,this.FNationalDay.CheckBoxStatus());
         this.UpdateUI();
      }
      
      override public function ProcessorExchangePet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:String = null;
         this.FBeClicked = false;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         this.FNationalDay.NinjiaVect[FIndex].Status = TBaseActivity.STATUS_GETED;
         this.FNationalDay.Stones -= this.FNationalDay.NinjiaVect[FIndex].Price;
         _loc8_ = STRING_BASEACTIVITY.FORMAT_EXCHANGE;
         ProcessorEffectText(_loc8_);
         ProcessorCheckEffect(FActivityID,this.FNationalDay.CheckBoxStatus());
         this.UpdateUI();
      }
      
      public function TestInit0() : ByteArray
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:ByteArray = new ByteArray();
         var _loc4_:Vector.<int> = Vector.<int>([1,0,1,0,1]);
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeUnsignedInt(1371571200);
         _loc3_.writeUnsignedInt(1401571200);
         TUtilityString.FlushUTF(_loc3_,"描述1");
         TUtilityString.FlushUTF(_loc3_,"描述2");
         TUtilityString.FlushUTF(_loc3_,"描述3");
         _loc3_.writeInt(1000);
         _loc3_.writeInt(0);
         _loc3_.writeInt(1);
         _loc3_.writeInt(1);
         _loc3_.writeShort(5);
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            TUtilityString.FlushUTF(_loc3_,"1月1日");
            _loc3_.writeInt(1);
            _loc3_.writeShort(5);
            _loc2_ = 0;
            while(_loc2_ < 5)
            {
               _loc3_.writeUnsignedInt(1);
               _loc3_.writeUnsignedInt(14100001 + _loc1_ + _loc2_);
               _loc3_.writeUnsignedInt(5);
               _loc2_++;
            }
            _loc1_++;
         }
         _loc3_.writeShort(5);
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            TUtilityString.FlushUTF(_loc3_,"摇钱树");
            TUtilityString.FlushUTF(_loc3_,"摇钱树描述");
            _loc3_.writeUnsignedInt((_loc1_ + 1) * 10);
            _loc3_.writeUnsignedInt(_loc1_ + 1);
            _loc3_.writeUnsignedInt(_loc1_ + 10);
            _loc3_.writeUnsignedInt((_loc1_ + 1) * 50);
            _loc3_.writeUnsignedInt(_loc1_ + 1);
            _loc3_.writeShort(1);
            _loc2_ = 0;
            while(_loc2_ < 1)
            {
               _loc3_.writeUnsignedInt(1);
               _loc3_.writeUnsignedInt(14100001 + _loc1_ + _loc2_);
               _loc3_.writeUnsignedInt(5);
               _loc2_++;
            }
            _loc1_++;
         }
         _loc3_.writeShort(2);
         _loc1_ = 0;
         while(_loc1_ < 2)
         {
            _loc3_.writeUnsignedInt(11210009 + _loc1_);
            _loc3_.writeUnsignedInt(100 + _loc1_);
            _loc3_.writeUnsignedInt(_loc4_[_loc1_]);
            _loc3_.writeUnsignedInt(50);
            TUtilityString.FlushUTF(_loc3_,"忍者描述1");
            TUtilityString.FlushUTF(_loc3_,"忍者描述2");
            TUtilityString.FlushUTF(_loc3_,"忍者描述3");
            _loc1_++;
         }
         _loc3_.writeShort(5);
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            _loc3_.writeUnsignedInt((_loc1_ + 1) * 10);
            _loc3_.writeUnsignedInt(10 + _loc1_);
            _loc3_.writeUnsignedInt(5 + _loc1_);
            _loc3_.writeUnsignedInt(_loc4_[_loc1_]);
            _loc3_.writeShort(5);
            _loc2_ = 0;
            while(_loc2_ < 5)
            {
               _loc3_.writeUnsignedInt(1);
               _loc3_.writeUnsignedInt(14100001 + _loc1_ + _loc2_);
               _loc3_.writeUnsignedInt(5);
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

