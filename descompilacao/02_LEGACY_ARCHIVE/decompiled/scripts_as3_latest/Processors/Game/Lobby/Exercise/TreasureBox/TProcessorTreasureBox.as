package Processors.Game.Lobby.Exercise.TreasureBox
{
   import Components.Pages.TUIPage;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Characters.TCharacter;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Exercise.TreasureBox.TTreasureBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Exercise.TUnstreamizerBaseInventories;
   import Logics.Streamization.Exercise.TUnstreamizerTreasureBox;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorBaseActivity;
   import Rendering.Overlayers.Box.TOverlayerBox;
   import Rendering.Overlayers.Box.TOverlayerOneOfBox;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Strings.STRING_BASEACTIVITY;
   import Resources.Strings.STRING_COMMON;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   
   public class TProcessorTreasureBox extends TProcessorBaseActivity
   {
      
      public static const BOX_COUNT:int = 4;
      
      public static const BAR_BOX_COUNT:int = 6;
      
      public static const REQ_TEN_TIMES:int = 1;
      
      protected var FTreasureBox:TTreasureBox;
      
      protected var FBeClicked:Boolean;
      
      protected var FUnstreamizerTreasureBox:TUnstreamizerTreasureBox;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FUnstreamizerBaseInventories:TUnstreamizerBaseInventories;
      
      protected var FChangeTabIndex:int;
      
      protected var FUIPage:TUIPage;
      
      protected var FCurPage:int;
      
      protected var FBoxVect:Vector.<MovieClip>;
      
      protected var FOverlayerBox:TOverlayerBox;
      
      protected var FOverlayerOneOfBox:TOverlayerOneOfBox;
      
      protected var FArticleBins:TBins;
      
      protected var FSmallBoxIndex:int;
      
      protected var FMC_AccumBar:MovieClip;
      
      protected var FMC_Bar:MovieClip;
      
      protected var FMC_Mask:Sprite;
      
      protected var FBarMaxWidth:int;
      
      protected var FCost:int;
      
      public function TProcessorTreasureBox(param1:TUIComponent, param2:TLobbyParameters, param3:uint)
      {
         super(param1,param2,param3);
         FActivityID = param3;
         this.FTreasureBox = SLogicsCore.TreasureBox;
         this.FBoxVect = new Vector.<MovieClip>(BOX_COUNT);
         this.FUIPage = new TUIPage(this);
         this.FUnstreamizerTreasureBox = new TUnstreamizerTreasureBox();
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         this.FUnstreamizerBaseInventories = new TUnstreamizerBaseInventories();
         this.FOverlayerBox = new TOverlayerBox(this.Parent);
         this.FOverlayerBox.Visible = false;
         this.FOverlayerOneOfBox = new TOverlayerOneOfBox(this.Parent);
         this.FOverlayerOneOfBox.Visible = false;
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:MovieClip = null;
         super.ResourcesPerform_UIDispatch();
         this.FMC_AccumBar = FMC_Scene["MC_AccumBar"];
         this.FMC_Bar = this.FMC_AccumBar["MC_Bar"];
         _loc1_ = 0;
         while(_loc1_ < BOX_COUNT)
         {
            this.FBoxVect[_loc1_] = FMC_Scene["MC_Box" + _loc1_];
            this.FBoxVect[_loc1_].gotoAndStop(1);
            this.FBoxVect[_loc1_].addEventListener(MouseEvent.CLICK,this.ProcessorOnGetUp);
            this.FBoxVect[_loc1_].addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnSmallBoxOver);
            this.FBoxVect[_loc1_].addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnSmallBoxOut);
            this.FBoxVect[_loc1_].buttonMode = true;
            this.FBoxVect[_loc1_].MC_Got.visible = false;
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < BAR_BOX_COUNT)
         {
            _loc4_ = this.FMC_AccumBar["MC_Box" + _loc1_];
            _loc4_.addEventListener(MouseEvent.CLICK,this.ProcessorOnGetBarBox);
            _loc4_.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnBarBoxOver);
            _loc4_.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnBarBoxOut);
            _loc4_.buttonMode = true;
            _loc1_++;
         }
         FMC_Scene.MC_BigBox.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnBigBoxOver);
         FMC_Scene.MC_BigBox.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnBigBoxOut);
         this.FUIPage.ButtonPrevious.Substrate = FMC_Scene.MC_ChangePage.MC_PageLeft;
         this.FUIPage.ButtonNext.Substrate = FMC_Scene.MC_ChangePage.MC_PageRight;
         this.FUIPage.PageSize = 1;
         this.FUIPage.PageIndex = 0;
         this.FCurPage = 0;
         this.FUIPage.OnChangePage = this.ProcessorPageOnChange;
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerBox);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerOneOfBox);
         this.FArticleBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
         FMC_Scene.BTN_Buy.addEventListener(MouseEvent.CLICK,this.ProcessorOnBuyUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Buy,true);
         FMC_Scene.BTN_TenTimes.addEventListener(MouseEvent.CLICK,this.ProcessorOnTenTimesUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_TenTimes,true);
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
      }
      
      override protected function UpdateUI() : void
      {
         super.UpdateUI();
         this.UpdateText();
         this.UpdateBar();
         this.UpdateBox();
      }
      
      protected function UpdateText() : void
      {
         FMC_Scene.TF_AllCount.text = this.FTreasureBox.TotalCount.toString();
         FTF_Time.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FTreasureBox.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FTreasureBox.EndTime - 1) * 1000)));
         FTF_Desc.text = this.FTreasureBox.ActivityDesc;
         FMC_Scene.TF_Gold.text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_OPEN_BOX_GOLD,this.FTreasureBox.BigBoxVect[this.FCurPage].Price);
         FMC_Scene.TF_TenGold.text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_OPEN_BOX_GOLD,this.FTreasureBox.BigBoxVect[this.FCurPage].Discount);
         FMC_Scene.TF_Discount.text = this.FTreasureBox.BigBoxVect[this.FCurPage].Desc1;
      }
      
      protected function UpdateBar() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         var _loc3_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < BAR_BOX_COUNT)
         {
            _loc2_ = this.FMC_AccumBar["MC_Box" + _loc1_];
            if(_loc1_ < this.FTreasureBox.BarBoxVect.length)
            {
               _loc2_.visible = true;
               _loc2_.TF_Count.text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_ITEM_COUNT,this.FTreasureBox.BarBoxVect[_loc1_].Price);
               switch(this.FTreasureBox.BarBoxVect[_loc1_].Status)
               {
                  case TBaseActivity.STATUS_CANNOTGET:
                     _loc2_.MC_Box.gotoAndStop(1);
                     _loc2_.MC_Box.notOpen.gotoAndStop(_loc1_ + 1);
                     _loc2_.MC_Box.notOpen.filters = [TGameUtil.GaryColorFilters];
                     break;
                  case TBaseActivity.STATUS_CANGET:
                     _loc2_.MC_Box.gotoAndStop(2);
                     _loc2_.MC_Box.canGet.MC_OpenBox.gotoAndStop(_loc1_ + 1);
                     break;
                  case TBaseActivity.STATUS_GETED:
                     _loc2_.MC_Box.gotoAndStop(3);
                     _loc2_.MC_Box.Got.gotoAndStop(_loc1_ + 1);
               }
            }
            else
            {
               _loc2_.visible = false;
            }
            _loc1_++;
         }
      }
      
      protected function UpdateBox() : void
      {
         var _loc1_:TBaseBox = null;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:int = 0;
         this.FUIPage.TotalQuantity = this.FTreasureBox.BigBoxVect.length;
         this.FUIPage.Update();
         _loc1_ = this.FTreasureBox.BigBoxVect[this.FCurPage];
         FMC_Scene.MC_BigBox.gotoAndStop(this.FCurPage + 1);
         FMC_Scene.MC_BigBox.TF_Name.text = _loc1_.Title;
         FMC_Scene.TF_CurCount.text = _loc1_.BuyCount;
         FMC_Scene.TF_BoxDesc.text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_TODAY_OPEN_TIMES,_loc1_.Title);
         _loc2_ = 0;
         while(_loc2_ < BOX_COUNT)
         {
            _loc4_ = this.FCurPage * BOX_COUNT + _loc2_;
            _loc1_ = this.FTreasureBox.SmallBoxVect[_loc4_];
            _loc3_ = FMC_Scene["MC_Box" + _loc2_];
            _loc3_.TF_Text.text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_NEED_OPEN_TIMES,_loc1_.Price);
            _loc3_.gotoAndStop(_loc4_ + 1);
            if(_loc1_.Status == TBaseActivity.STATUS_GETED)
            {
               _loc3_.MC_Got.visible = true;
               _loc3_.filters = [];
            }
            else if(_loc1_.Status == TBaseActivity.STATUS_CANGET)
            {
               _loc3_.MC_Got.visible = false;
               _loc3_.filters = [];
            }
            else
            {
               _loc3_.MC_Got.visible = false;
               _loc3_.filters = [TGameUtil.GaryColorFilters];
            }
            _loc2_++;
         }
      }
      
      protected function ProcessorPageOnChange(param1:Object, param2:int) : void
      {
         this.FCurPage = param2;
         this.UpdateUI();
      }
      
      override protected function PerformPacket_CS_LoadInfoReq() : void
      {
         super.PerformPacket_CS_LoadInfoReq();
      }
      
      protected function ProcessorOnBuyUp(param1:int) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:int = 0;
         if(this.FBeClicked)
         {
            return;
         }
         if(this.FCurPage >= this.FTreasureBox.BigBoxVect.length)
         {
            return;
         }
         FIndex = this.FCurPage;
         FReqType = 0;
         if(!FUIWindowConfirmation.IsSelected)
         {
            this.FCost = this.FTreasureBox.BigBoxVect[FIndex].Price;
            FUIWindowConfirmation.Text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_ConfirmGold,this.FCost);
            FUIWindowConfirmation.SetCheckBox(true);
            FUIWindowConfirmation.Visible = true;
         }
         else
         {
            this.WindowConfirmationOnOK();
         }
      }
      
      protected function ProcessorOnTenTimesUp(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.buttonMode || this.FBeClicked)
         {
            return;
         }
         if(this.FCurPage >= this.FTreasureBox.BigBoxVect.length)
         {
            return;
         }
         FIndex = this.FCurPage;
         FReqType = 1;
         if(!FUIWindowConfirmation.IsSelected)
         {
            this.FCost = this.FTreasureBox.BigBoxVect[FIndex].Discount;
            FUIWindowConfirmation.Text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_ConfirmGold,this.FCost);
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
         var _loc2_:Vector.<int> = null;
         var _loc3_:TCharacter = null;
         _loc3_ = SLogicsCore.Character;
         if(_loc3_.CreditGold >= this.FCost)
         {
            this.FBeClicked = true;
            if(FReqType == 0)
            {
               this.PerformPacket_CS_BuyBoxReq();
            }
            else
            {
               _loc2_ = new Vector.<int>();
               _loc2_.push(FIndex + 1);
               PerformPacket_CS_AllReq(REQ_TEN_TIMES,_loc2_);
            }
         }
         else
         {
            FUIWindowRecharge.Visible = true;
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
      
      protected function ProcessorOnGetUp(param1:MouseEvent) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(this.FBeClicked)
         {
            return;
         }
         _loc3_ = int(String(param1.currentTarget.name).slice(6));
         this.FSmallBoxIndex = this.FCurPage * BOX_COUNT + _loc3_;
         if(this.FTreasureBox.SmallBoxVect[this.FSmallBoxIndex].Status != TBaseActivity.STATUS_CANGET)
         {
            return;
         }
         this.FBeClicked = true;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TreasureBox_GetSmallBoxReq);
         _loc2_.Data.writeUnsignedInt(this.FSmallBoxIndex + 1);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function ProcessorOnGetBarBox(param1:MouseEvent) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(this.FBeClicked)
         {
            return;
         }
         _loc3_ = int(String(param1.currentTarget.name).slice(6));
         FIndex = _loc3_;
         if(this.FTreasureBox.BarBoxVect[FIndex].Status != TBaseActivity.STATUS_CANGET)
         {
            return;
         }
         this.FBeClicked = true;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_BaseActivity_GetRewardReq);
         _loc2_.Data.writeUnsignedInt(FActivityID);
         _loc2_.Data.writeUnsignedInt(FIndex + 1);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function ProcessorOnBigBoxOver(param1:MouseEvent) : void
      {
         if(this.FCurPage < this.FTreasureBox.BigBoxVect.length)
         {
            this.FOverlayerOneOfBox.Context = this.FTreasureBox.BigBoxVect[this.FCurPage];
            this.FOverlayerOneOfBox.Render(FUICore.MouseCoordinate);
            this.FOverlayerOneOfBox.Show();
         }
      }
      
      protected function ProcessorOnBigBoxOut(param1:MouseEvent) : void
      {
         this.FOverlayerOneOfBox.Hide();
      }
      
      protected function ProcessorOnSmallBoxOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(6));
         _loc3_ = this.FCurPage * BOX_COUNT + _loc2_;
         if(this.FTreasureBox.SmallBoxVect.length > 0)
         {
            this.FOverlayerBox.Context = this.FTreasureBox.SmallBoxVect[_loc3_].Inventories;
            this.FOverlayerBox.Render(FUICore.MouseCoordinate);
            this.FOverlayerBox.Show();
         }
      }
      
      protected function ProcessorOnSmallBoxOut(param1:MouseEvent) : void
      {
         this.FOverlayerBox.Hide();
      }
      
      protected function ProcessorOnBarBoxOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TInventory = null;
         _loc2_ = int(String(param1.currentTarget.name).slice(6));
         if(this.FTreasureBox.BarBoxVect.length > 0 && this.FTreasureBox.BarBoxVect[_loc2_].Inventories.Count > 0)
         {
            _loc3_ = this.FTreasureBox.BarBoxVect[_loc2_].Inventories.GetInventoryByIndex(0);
            UIComponentsHintOnOver(this,_loc3_);
         }
      }
      
      protected function ProcessorOnBarBoxOut(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TInventory = null;
         _loc2_ = int(String(param1.currentTarget.name).slice(6));
         if(this.FTreasureBox.BarBoxVect.length > 0 && this.FTreasureBox.BarBoxVect[_loc2_].Inventories.Count > 0)
         {
            _loc3_ = this.FTreasureBox.BarBoxVect[_loc2_].Inventories.GetInventoryByIndex(0);
            UIComponentsHintOnOut(this,_loc3_);
         }
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
         this.FUnstreamizerTreasureBox.Unstreamize(_loc2_,this.FTreasureBox,null);
         if(FIsResourcesLoadCompleted && this.visible)
         {
            this.UpdateUI();
         }
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
         ++this.FTreasureBox.TotalCount;
         ++this.FTreasureBox.BigBoxVect[FIndex].BuyCount;
         _loc6_ = new TInventories();
         this.FUnstreamizerBaseInventories.Unstreamize(_loc2_,_loc6_,null);
         _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
         _loc7_ = 0;
         while(_loc7_ < _loc6_.Count)
         {
            _loc4_ += _loc6_.GetInventoryByIndex(_loc7_).Name + "*" + _loc6_.GetInventoryByIndex(_loc7_).Quantity + "\n";
            _loc7_++;
         }
         ProcessorEffectText(_loc4_);
         this.FTreasureBox.ChangeBoxStatus();
         ProcessorCheckEffect(FActivityID,this.FTreasureBox.CheckBoxStatus());
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
         var _loc11_:int = 0;
         var _loc12_:uint = 0;
         var _loc13_:Vector.<uint> = null;
         var _loc14_:Vector.<uint> = null;
         this.FBeClicked = false;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         this.FTreasureBox.BarBoxVect[FIndex].Status = TBaseActivity.STATUS_GETED;
         _loc6_ = this.FTreasureBox.BarBoxVect[FIndex].Inventories;
         _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
         _loc7_ = 0;
         while(_loc7_ < _loc6_.Count)
         {
            _loc4_ += _loc6_.GetInventoryByIndex(_loc7_).Name + "*" + _loc6_.GetInventoryByIndex(_loc7_).Quantity + "\n";
            _loc7_++;
         }
         ProcessorEffectText(_loc4_);
         ProcessorCheckEffect(FActivityID,this.FTreasureBox.CheckBoxStatus());
         this.UpdateUI();
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
         var _loc12_:uint = 0;
         var _loc13_:Vector.<uint> = null;
         var _loc14_:Vector.<uint> = null;
         this.FBeClicked = false;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         this.FTreasureBox.SmallBoxVect[this.FSmallBoxIndex].Status = TBaseActivity.STATUS_GETED;
         _loc6_ = this.FTreasureBox.SmallBoxVect[this.FSmallBoxIndex].Inventories;
         _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
         _loc7_ = 0;
         while(_loc7_ < _loc6_.Count)
         {
            _loc4_ += _loc6_.GetInventoryByIndex(_loc7_).Name + "*" + _loc6_.GetInventoryByIndex(_loc7_).Quantity + "\n";
            _loc7_++;
         }
         ProcessorEffectText(_loc4_);
         ProcessorCheckEffect(FActivityID,this.FTreasureBox.CheckBoxStatus());
         this.UpdateUI();
      }
      
      override public function ProcessorAllRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:TInventories = null;
         var _loc9_:TInventory = null;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         this.FBeClicked = false;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc7_ = int(_loc2_.readUnsignedInt());
         _loc10_ = _loc2_.readShort();
         switch(_loc7_)
         {
            case REQ_TEN_TIMES:
               FIndex = _loc2_.readUnsignedInt() - 1;
               this.FTreasureBox.TotalCount += 10;
               this.FTreasureBox.BigBoxVect[FIndex].BuyCount += 10;
               _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
               _loc5_ = 0;
               while(_loc5_ < 10)
               {
                  _loc12_ = int(_loc2_.readUnsignedInt());
                  _loc13_ = int(_loc2_.readUnsignedInt());
                  _loc14_ = int(_loc2_.readUnsignedInt());
                  _loc4_ += STRING_COMMON.GetItemNameByType(_loc12_,_loc13_) + "*" + _loc14_ + "\n";
                  _loc5_++;
               }
               ProcessorEffectText(_loc4_);
               this.FTreasureBox.ChangeBoxStatus();
               ProcessorCheckEffect(FActivityID,this.FTreasureBox.CheckBoxStatus());
               this.UpdateUI();
         }
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
         _loc3_.writeInt(0);
         _loc3_.writeShort(5);
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            TUtilityString.FlushUTF(_loc3_,"XXX" + _loc1_);
            _loc3_.writeInt(1);
            _loc3_.writeInt(0);
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
         _loc3_.writeShort(20);
         _loc1_ = 0;
         while(_loc1_ < 20)
         {
            _loc3_.writeInt(1 + _loc1_);
            _loc3_.writeInt(0);
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
            _loc3_.writeInt(1 + _loc1_);
            _loc3_.writeInt(0);
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
   }
}

