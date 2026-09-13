package Processors.Game.Lobby.Exercise.HappyTreasure
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
   import Logics.Characters.TCharacter;
   import Logics.Exercise.HappyTreasure.THappyTreasure;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.Lottery.TLotteryNews;
   import Logics.SLogicsCore;
   import Logics.Streamization.Exercise.TUnstreamizerHappyTreasure;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUINews;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorBaseActivity;
   import Processors.Game.Windows.Information.TUIWindowConfirmation;
   import Resources.Constants.CONST_BASEACTIVITY;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Strings.STRING_BASEACTIVITY;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   import ghostcat.util.easing.TweenUtil;
   
   public class TProcessorHappyTreasure extends TProcessorBaseActivity
   {
      
      protected static const BOX_TYPE:int = THappyTreasure.BOX_TYPE;
      
      protected static const MAX_BOX:int = THappyTreasure.MAX_BOX;
      
      protected static const REPORT_INIT_X:int = 0;
      
      protected static const REPORT_INIT_Y:int = 0;
      
      protected static const SPADE_INIT_X:int = 48;
      
      protected static const SPADE_INIT_Y:int = 52;
      
      protected static const STAMP_UINT_X:int = 54;
      
      protected static const STAMP_UINT_Y:int = 52;
      
      protected static const ROW_COUNT:int = 8;
      
      protected static const COL_COUNT:int = 7;
      
      protected static const BAR_COUNT:int = 5;
      
      protected static const GET_BAR_ITEM_REQ:int = 1;
      
      protected var FHappyTreasure:THappyTreasure;
      
      protected var FBTN_OpenAll:MovieClip;
      
      protected var FBTN_GetReward:MovieClip;
      
      protected var FTF_TotalScore:TextField;
      
      protected var FTF_CurScore:TextField;
      
      protected var FPointList:Vector.<MovieClip>;
      
      protected var FBoxList:Vector.<MovieClip>;
      
      protected var FMC_Spade:MovieClip;
      
      protected var FMC_Hammer:MovieClip;
      
      protected var FMC_Hot:MovieClip;
      
      protected var FBeClicked:Boolean;
      
      protected var FBoxLevel:uint;
      
      protected var FUnstreamizerHappyTreasure:TUnstreamizerHappyTreasure;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FUINews:TUINews;
      
      protected var FUIWindowConfirmationBuyAll:TUIWindowConfirmation;
      
      protected var FMC_Mask:MovieClip;
      
      protected var FBarMaxHeight:int;
      
      public function TProcessorHappyTreasure(param1:TUIComponent, param2:TLobbyParameters, param3:uint)
      {
         super(param1,param2,CONST_BASEACTIVITY.TYPE_NewActiveList_HappyTreasure);
         FActivityID = CONST_BASEACTIVITY.TYPE_NewActiveList_HappyTreasure;
         this.FHappyTreasure = SLogicsCore.HappyTreasure;
         this.FPointList = new Vector.<MovieClip>(MAX_BOX);
         this.FBoxList = new Vector.<MovieClip>(BOX_TYPE);
         this.FUnstreamizerHappyTreasure = new TUnstreamizerHappyTreasure();
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         this.FUIWindowConfirmationBuyAll = new TUIWindowConfirmation(this.Parent);
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:MovieClip = null;
         super.ResourcesPerform_UIDispatch();
         this.FBTN_OpenAll = FMC_Scene["BTN_OpenAll"];
         this.FBTN_GetReward = FMC_Scene["BTN_GetReward"];
         this.FTF_TotalScore = FMC_Scene["TF_TotalScore"];
         this.FTF_CurScore = FMC_Scene["TF_CurScore"];
         this.FMC_Spade = FMC_Scene["MC_Spade"];
         this.FMC_Spade.mouseEnabled = false;
         this.FMC_Spade.visible = false;
         this.FMC_Hammer = FMC_Scene["MC_Hammer"];
         this.FMC_Hammer.mouseEnabled = false;
         this.FMC_Hammer.visible = false;
         this.FMC_Hot = FMC_Scene["MC_Hot"];
         this.FMC_Hot.mouseEnabled = false;
         this.FMC_Hot.play();
         _loc1_ = 0;
         while(_loc1_ < MAX_BOX)
         {
            _loc4_ = FMC_Scene["MC_Point" + _loc1_];
            _loc4_.mouseEnabled = true;
            _loc4_.buttonMode = true;
            this.FPointList[_loc1_] = _loc4_;
            this.FPointList[_loc1_].MC_Smoke.visible = false;
            _loc4_.addEventListener(MouseEvent.CLICK,this.ProcessorOnBuyUp);
            _loc4_.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnPointOver);
            _loc4_.addEventListener(MouseEvent.MOUSE_OUT,this.ProcessorOnPointOut);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < BOX_TYPE)
         {
            _loc3_ = FMC_Scene["MC_Box" + _loc1_];
            _loc3_.gotoAndStop(_loc1_ + 1);
            _loc3_.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnBoxOver);
            _loc3_.addEventListener(MouseEvent.MOUSE_OUT,this.ProcessorOnBoxOut);
            this.FBoxList[_loc1_] = _loc3_;
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < BAR_COUNT)
         {
            _loc4_ = FMC_Scene["MC_BarBox" + _loc1_];
            _loc4_.MC_Box.buttonMode = true;
            _loc4_.MC_Box.gotoAndStop(_loc1_ + 1);
            _loc4_.MC_Box.addEventListener(MouseEvent.CLICK,this.ProcessorOnBarItemUp);
            _loc4_.MC_Box.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnBarItemOver);
            _loc4_.MC_Box.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnNewBoxOut);
            _loc1_++;
         }
         this.FMC_Mask = FMC_Scene.MC_Bar.MC_Mask;
         this.FBarMaxHeight = this.FMC_Mask.height;
      }
      
      override protected function ResourcesPerform_UIDispatchWindow() : void
      {
         super.ResourcesPerform_UIDispatchWindow();
         this.FUIWindowConfirmationBuyAll.OnOK = this.WindowConfirmationBuyAllOnOK;
         this.FUIWindowConfirmationBuyAll.x = (CONST_COMMON.STAGE_Width - this.FUIWindowConfirmationBuyAll.WindowWidth) / 2;
         this.FUIWindowConfirmationBuyAll.y = (CONST_COMMON.STAGE_Height - this.FUIWindowConfirmationBuyAll.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowConfirmationBuyAll);
         this.FUIWindowConfirmationBuyAll.SetCheckBox(true);
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
         this.FBTN_OpenAll.addEventListener(MouseEvent.CLICK,this.ProcessorOnBuyAllUp);
         this.FBTN_OpenAll.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnBuyOver);
         this.FBTN_OpenAll.addEventListener(MouseEvent.MOUSE_OUT,this.ProcessorOnBuyOut);
         this.FBTN_GetReward.addEventListener(MouseEvent.CLICK,this.ProcessorOnGetReward);
         TGameUtil.setButtonMode(this.FBTN_OpenAll,false);
         TGameUtil.setButtonMode(this.FBTN_GetReward,false);
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         if(FInitialized)
         {
            if(this.visible)
            {
               if(Boolean(this.FHappyTreasure) && Boolean(FTF_Time))
               {
                  FTF_Time.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_LimitTime,TGameUtil.fomatTime(this.FHappyTreasure.EndTime - STimingCore.GetServerTick()));
               }
            }
         }
      }
      
      override protected function UpdateUI() : void
      {
         super.UpdateUI();
         this.UpdateText();
         this.UpdateBtn();
         this.UpdatePoint();
         this.UpdateBar();
      }
      
      protected function UpdateText() : void
      {
         this.FTF_TotalScore.text = this.FHappyTreasure.TotalScore.toString();
         this.FTF_CurScore.text = this.FHappyTreasure.CurScore.toString();
         FTF_Desc.text = this.FHappyTreasure.ActivityName;
         FTF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FHappyTreasure.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FHappyTreasure.EndTime - 1) * 1000)));
         FMC_Scene.TF_Max.text = this.FHappyTreasure.CurScore + "/" + this.FHappyTreasure.Max;
         FMC_Scene.TF_RechargeScore.text = this.FHappyTreasure.RechargeMin + "/" + this.FHappyTreasure.RechargeMax;
         FMC_Scene.TF_ConsumeScore.text = this.FHappyTreasure.ConsumeMin + "/" + this.FHappyTreasure.ConsumeMax;
         FMC_Scene.TF_BarValue.text = this.FHappyTreasure.CurBarValue.toString();
      }
      
      protected function UpdateBtn() : void
      {
         if(Boolean(this.FHappyTreasure.Rewards) && this.FHappyTreasure.Rewards.Count > 0)
         {
            TGameUtil.setButtonMode(this.FBTN_OpenAll,false);
            TGameUtil.setButtonMode(this.FBTN_GetReward,true);
         }
         else
         {
            TGameUtil.setButtonMode(this.FBTN_OpenAll,true);
            TGameUtil.setButtonMode(this.FBTN_GetReward,false);
         }
      }
      
      protected function UpdatePoint() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < MAX_BOX)
         {
            if(this.FHappyTreasure.IsPointOpen(_loc1_))
            {
               this.FPointList[_loc1_].gotoAndStop(2);
               _loc4_ = this.FHappyTreasure.GetBoxLevel(_loc1_);
               this.FPointList[_loc1_].MC_Box.gotoAndStop(_loc4_);
               this.FPointList[_loc1_].MC_Box.buttonMode = false;
               this.FPointList[_loc1_].MC_Box.mouseEnabled = false;
            }
            else
            {
               this.FPointList[_loc1_].gotoAndStop(1);
            }
            _loc1_++;
         }
      }
      
      protected function UpdateBar() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TBaseBox = null;
         var _loc3_:MovieClip = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         _loc6_ = this.FHappyTreasure.BarItems[this.FHappyTreasure.BarItems.length - 1].Price;
         _loc4_ = Number(this.FHappyTreasure.CurBarValue / _loc6_) * this.FBarMaxHeight;
         _loc5_ = Math.min(_loc4_,this.FBarMaxHeight);
         this.FMC_Mask.height = _loc5_;
         _loc1_ = 0;
         while(_loc1_ < BAR_COUNT)
         {
            _loc3_ = FMC_Scene["MC_BarBox" + _loc1_];
            _loc2_ = this.FHappyTreasure.BarItems[_loc1_];
            _loc3_.TF_Count.text = _loc2_.Price.toString();
            if(_loc2_.Status == TBaseActivity.STATUS_CANGET)
            {
               _loc3_.MC_Click.visible = true;
               _loc3_.MC_Got.visible = false;
            }
            else if(_loc2_.Status == TBaseActivity.STATUS_CANNOTGET)
            {
               _loc3_.MC_Click.visible = false;
               _loc3_.MC_Got.visible = false;
            }
            else
            {
               _loc3_.MC_Click.visible = false;
               _loc3_.MC_Got.visible = true;
            }
            _loc1_++;
         }
      }
      
      override protected function PerformPacket_CS_LoadInfoReq() : void
      {
         if(this.FHappyTreasure)
         {
            FNeedConfig = this.FHappyTreasure.NeedConfig;
         }
         super.PerformPacket_CS_LoadInfoReq();
      }
      
      protected function ProcessorOnBuyUp(param1:MouseEvent) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(this.FBeClicked)
         {
            return;
         }
         _loc4_ = int(param1.currentTarget.name.slice(8));
         if(this.FHappyTreasure.RewardsIndex.indexOf(_loc4_) != -1)
         {
            return;
         }
         this.FBeClicked = true;
         FIndex = _loc4_;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_BaseActivity_BuyBoxReq);
         _loc2_.Data.writeUnsignedInt(ActivityID);
         _loc2_.Data.writeUnsignedInt(FIndex);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function ProcessorOnBuyAllUp(param1:MouseEvent = null) : void
      {
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(!this.FUIWindowConfirmationBuyAll.IsSelected)
         {
            this.FUIWindowConfirmationBuyAll.Text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_BUY_ALL_CONFIRMATION,this.FHappyTreasure.TotalBoxPrice);
            this.FUIWindowConfirmationBuyAll.SetCheckBox(true);
            this.FUIWindowConfirmationBuyAll.Visible = true;
         }
         else
         {
            this.PerformPacket_CS_BuyAllReq();
         }
      }
      
      protected function WindowConfirmationBuyAllOnOK(param1:Object = null) : void
      {
         this.PerformPacket_CS_BuyAllReq();
      }
      
      protected function PerformPacket_CS_BuyAllReq() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         TGameUtil.setButtonMode(this.FBTN_OpenAll,false);
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_HappyTreasure_BuyAllBoxReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function ProcessorOnBuyOver(param1:MouseEvent = null) : void
      {
         var _loc2_:String = null;
         _loc2_ = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_BTN_BUY_ALL_TIP,this.FHappyTreasure.TotalBoxPrice);
         FHtmlHint.Caption = _loc2_;
         FOverlayerHint.Context = FHtmlHint;
         FOverlayerHint.Render(FUICore.MouseCoordinate);
         FOverlayerHint.Show();
      }
      
      protected function ProcessorOnBuyOut(param1:MouseEvent = null) : void
      {
         FOverlayerHint.Hide();
      }
      
      protected function ProcessorOnGetReward(param1:MouseEvent = null) : void
      {
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(!FUIWindowConfirmation.IsSelected)
         {
            FUIWindowConfirmation.Text = STRING_BASEACTIVITY.FORMAT_GET_CONFIRMATION;
            FUIWindowConfirmation.SetCheckBox(true);
            FUIWindowConfirmation.Visible = true;
         }
         else
         {
            this.PerformPacket_CS_GetRewardReq();
         }
      }
      
      override protected function WindowConfirmationOnOK(param1:Object = null) : void
      {
         this.PerformPacket_CS_GetRewardReq();
      }
      
      override protected function PerformPacket_CS_GetRewardReq(param1:MouseEvent = null) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_BaseActivity_GetRewardReq);
         _loc2_.Data.writeUnsignedInt(FActivityID);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      override protected function PerformPacket_CS_LoadLogReq(param1:MouseEvent = null) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_HappyTreasure_LoadLogReq);
         _loc2_.Data.writeUnsignedInt(FActivityID);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function ProcessorOnBoxOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TInventory = null;
         _loc2_ = int(param1.currentTarget.name.slice(6));
         _loc3_ = this.FHappyTreasure.Inventories.GetInventoryByIndex(_loc2_);
         UIComponentsHintOnOver(this,_loc3_);
      }
      
      protected function ProcessorOnBoxOut(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TInventory = null;
         _loc2_ = int(param1.currentTarget.name.slice(6));
         _loc3_ = this.FHappyTreasure.Inventories.GetInventoryByIndex(_loc2_);
         UIComponentsHintOnOut(this,_loc3_);
      }
      
      protected function ProcessorOnPointOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TInventory = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         _loc2_ = int(param1.currentTarget.name.slice(8));
         _loc4_ = this.FHappyTreasure.RewardsIndex.indexOf(_loc2_);
         if(_loc4_ == -1)
         {
            return;
         }
         _loc5_ = int(this.FHappyTreasure.RewardsLevel[_loc4_]);
         _loc3_ = this.FHappyTreasure.Inventories.GetInventoryByIndex(_loc5_ - 1);
         UIComponentsHintOnOver(this,_loc3_);
      }
      
      protected function ProcessorOnPointOut(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TInventory = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         _loc2_ = int(param1.currentTarget.name.slice(8));
         _loc4_ = this.FHappyTreasure.RewardsIndex.indexOf(_loc2_);
         if(_loc4_ == -1)
         {
            return;
         }
         _loc5_ = int(this.FHappyTreasure.RewardsLevel[_loc4_]);
         _loc3_ = this.FHappyTreasure.Inventories.GetInventoryByIndex(_loc5_ - 1);
         UIComponentsHintOnOut(this,_loc3_);
      }
      
      override protected function ProcessorOnOpenDesc(param1:MouseEvent = null) : void
      {
         FProcessorWindowDesc.BaseActivity = this.FHappyTreasure;
         super.ProcessorOnOpenDesc();
      }
      
      protected function ProcessorOnBarItemUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Vector.<int> = null;
         if(this.FBeClicked)
         {
            return;
         }
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(9));
         if(Boolean(this.FHappyTreasure) && Boolean(_loc2_ < this.FHappyTreasure.BarItems.length) && this.FHappyTreasure.BarItems[_loc2_].Status == TBaseActivity.STATUS_CANGET)
         {
            this.FBeClicked = true;
            _loc3_ = new Vector.<int>();
            _loc3_.push(_loc2_ + 1);
            PerformPacket_CS_AllReq(GET_BAR_ITEM_REQ,_loc3_);
         }
      }
      
      protected function ProcessorOnBarItemOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(9));
         if(Boolean(this.FHappyTreasure) && _loc2_ < this.FHappyTreasure.BarItems.length)
         {
            ProcessorOnNewBoxOver(this.FHappyTreasure.BarItems[_loc2_].Inventories);
         }
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount(param1);
         if(!FIsResourcesLoadCompleted)
         {
            this.FUIWindowConfirmationBuyAll.Load();
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
         this.FUIWindowConfirmationBuyAll.Visible = false;
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
         this.FUnstreamizerHappyTreasure.Unstreamize(_loc2_,this.FHappyTreasure,null);
         if(FIsResourcesLoadCompleted && this.visible)
         {
            this.UpdateUI();
         }
      }
      
      override public function ProcessorBuyBoxRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         super.ProcessorBuyBoxRet();
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            this.FBeClicked = false;
            return;
         }
         this.PlayMovie(param1);
      }
      
      public function PlayMovie(param1:TPacket = null) : void
      {
         var _loc2_:TCharacter = null;
         var _loc3_:ByteArray = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:uint = 0;
         var _loc7_:TInventory = null;
         var _loc8_:TInventories = null;
         var _loc9_:Vector.<int> = null;
         var _loc10_:Vector.<uint> = null;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         _loc3_ = param1.Data;
         _loc5_ = int(_loc3_.readUnsignedShort());
         _loc10_ = new Vector.<uint>();
         _loc9_ = new Vector.<int>();
         this.FHappyTreasure.CurScore += this.FHappyTreasure.BoxPrice;
         this.FHappyTreasure.TotalScore -= this.FHappyTreasure.BoxPrice;
         FIndex = _loc3_.readUnsignedInt();
         this.FHappyTreasure.RewardsIndex.push(FIndex);
         _loc10_.push(_loc3_.readUnsignedInt());
         this.FBoxLevel = _loc3_.readUnsignedInt();
         this.FHappyTreasure.RewardsLevel.push(this.FBoxLevel);
         this.FHappyTreasure.CurBarValue = _loc3_.readUnsignedInt();
         _loc8_ = new TInventories();
         this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc8_,_loc10_);
         _loc4_ = 0;
         while(_loc4_ < _loc8_.Count)
         {
            _loc7_ = _loc8_.GetInventoryByIndex(_loc4_);
            this.FHappyTreasure.Rewards.Add(_loc7_);
            _loc4_++;
         }
         _loc11_ = FIndex % COL_COUNT;
         _loc12_ = FIndex / COL_COUNT;
         this.FMC_Spade.x = SPADE_INIT_X + _loc11_ * STAMP_UINT_X;
         this.FMC_Spade.y = SPADE_INIT_Y + _loc12_ * STAMP_UINT_Y;
         _loc2_ = SLogicsCore.Character;
         _loc6_ = _loc2_.Heros.GetHeroByIndex(0).Identifier - 11100000;
         this.FMC_Spade.visible = true;
         this.FMC_Spade.gotoAndStop(_loc6_);
         this.FMC_Spade.MC_Role.play();
         this.FPointList[FIndex].MC_Smoke.visible = true;
         this.FPointList[FIndex].MC_Smoke.gotoAndPlay(1);
         TweenUtil.to(this.FMC_Spade,1000,{"onComplete":this.PlayMovieEnd});
      }
      
      public function PlayMovieEnd() : void
      {
         var _loc1_:String = null;
         this.FMC_Spade.visible = false;
         this.FPointList[FIndex].MC_Smoke.visible = false;
         this.FPointList[FIndex].gotoAndStop(2);
         this.FPointList[FIndex].MC_Box.gotoAndStop(this.FBoxLevel);
         _loc1_ = STRING_BASEACTIVITY.FORMAT_GET_BOX_STRING + STRING_BASEACTIVITY.FORMAT_BOX_NAME[this.FBoxLevel];
         ProcessorEffectText(_loc1_);
         this.FBeClicked = false;
         this.UpdateUI();
      }
      
      public function ProcessorBuyAllRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            this.UpdateUI();
            return;
         }
         this.PlayAllMovie(param1);
      }
      
      public function PlayAllMovie(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:uint = 0;
         var _loc6_:TInventory = null;
         var _loc7_:TInventories = null;
         var _loc8_:Vector.<int> = null;
         var _loc9_:Vector.<uint> = null;
         _loc2_ = param1.Data;
         this.FHappyTreasure.CurScore += this.FHappyTreasure.TotalBoxPrice;
         this.FHappyTreasure.TotalScore -= this.FHappyTreasure.TotalBoxPrice;
         _loc4_ = int(_loc2_.readUnsignedShort());
         _loc9_ = new Vector.<uint>();
         _loc8_ = new Vector.<int>();
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            this.FHappyTreasure.RewardsIndex.push(_loc2_.readUnsignedInt());
            _loc9_.push(_loc2_.readUnsignedInt());
            this.FHappyTreasure.RewardsLevel.push(_loc2_.readUnsignedInt());
            _loc3_++;
         }
         this.FHappyTreasure.CurBarValue = _loc2_.readUnsignedInt();
         _loc7_ = new TInventories();
         this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc7_,_loc9_);
         this.FHappyTreasure.Rewards = _loc7_;
         this.FMC_Hammer.visible = true;
         this.FMC_Hammer.gotoAndPlay(1);
         _loc3_ = 0;
         while(_loc3_ < MAX_BOX)
         {
            this.FPointList[_loc3_].MC_Smoke.visible = true;
            this.FPointList[_loc3_].MC_Smoke.gotoAndPlay(1);
            _loc3_++;
         }
         TweenUtil.to(this.FMC_Hammer,2000,{"onComplete":this.PlayAllMovieEnd});
      }
      
      public function PlayAllMovieEnd() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < MAX_BOX)
         {
            this.FPointList[_loc1_].MC_Smoke.visible = false;
            this.FPointList[_loc1_].gotoAndStop(2);
            this.FPointList[_loc1_].MC_Box.gotoAndStop(this.FHappyTreasure.RewardsLevel[_loc1_]);
            _loc1_++;
         }
         this.FMC_Hammer.visible = false;
         this.UpdateUI();
      }
      
      override public function ProcessorGetRewardRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            this.UpdateUI();
            return;
         }
         _loc4_ = STRING_BASEACTIVITY.FORMAT_GET;
         ProcessorEffectText(_loc4_);
         this.FHappyTreasure.Rewards.Clear();
         this.FHappyTreasure.RewardsIndex.length = 0;
         this.FHappyTreasure.RewardsLevel.length = 0;
         this.UpdateUI();
         ProcessorCheckEffect(FActivityID,false);
      }
      
      override public function ProcessorLoadLogRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:TInventory = null;
         var _loc7_:TInventories = null;
         var _loc8_:Vector.<uint> = null;
         var _loc9_:TLotteryNews = null;
         super.ProcessorLoadLogRet();
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            ProcessorClose();
            return;
         }
         _loc5_ = int(_loc2_.readUnsignedShort());
         this.FHappyTreasure.LogList.length = 0;
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc9_ = new TLotteryNews();
            _loc9_.Identify = _loc2_.readUnsignedInt();
            _loc8_ = new Vector.<uint>();
            _loc8_.push(_loc9_.Identify);
            _loc9_.GetTime = _loc2_.readUnsignedInt();
            _loc7_ = new TInventories();
            this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc7_,_loc8_);
            _loc6_ = _loc7_.GetInventoryByIndex(0);
            _loc6_.Quantity = 1;
            _loc9_.Inventories = _loc7_;
            this.FHappyTreasure.LogList.push(_loc9_);
            _loc4_++;
         }
         FProcessorWindowLog.BaseActivity = this.FHappyTreasure;
         FProcessorWindowLog.UpdateUI();
         FProcessorWindowLog.Visible = true;
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
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         var _loc13_:TBaseBox = null;
         var _loc14_:uint = 0;
         var _loc15_:TBins = null;
         var _loc16_:int = 0;
         var _loc17_:int = 0;
         var _loc18_:int = 0;
         var _loc19_:int = 0;
         _loc15_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         this.FBeClicked = false;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc7_ = int(_loc2_.readUnsignedInt());
         _loc2_.readShort();
         switch(_loc7_)
         {
            case GET_BAR_ITEM_REQ:
               _loc5_ = _loc2_.readUnsignedInt() - 1;
               this.FHappyTreasure.BarItems[_loc5_].Status = TBaseActivity.STATUS_GETED;
               _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
               _loc6_ = 0;
               while(_loc6_ < this.FHappyTreasure.BarItems[_loc5_].Inventories.Count)
               {
                  _loc9_ = this.FHappyTreasure.BarItems[_loc5_].Inventories.GetInventoryByIndex(_loc6_);
                  _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                  _loc6_++;
               }
               this.FHappyTreasure.ChangeStatus();
               ProcessorEffectText(_loc4_);
               ProcessorCheckEffect(FActivityID,this.FHappyTreasure.CheckStatus());
               this.UpdateUI();
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
         _loc3_.writeUnsignedInt(1401571200);
         TUtilityString.FlushUTF(_loc3_,"欢乐寻宝");
         TUtilityString.FlushUTF(_loc3_,"欢乐寻宝描述");
         TUtilityString.FlushUTF(_loc3_,"欢乐寻宝描述");
         _loc3_.writeUnsignedInt(1);
         _loc3_.writeUnsignedInt(2);
         _loc3_.writeShort(3);
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            _loc3_.writeUnsignedInt(_loc1_);
            _loc3_.writeUnsignedInt(14100132);
            _loc3_.writeUnsignedInt(_loc1_ + 1);
            _loc1_++;
         }
         _loc3_.writeShort(3);
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            _loc3_.writeUnsignedInt(_loc1_ + 1);
            _loc3_.writeUnsignedInt(_loc1_ + 1);
            TUtilityString.FlushUTF(_loc3_,"aaa");
            _loc3_.writeUnsignedInt(14100132 + _loc1_);
            _loc1_++;
         }
         if(!this.FHappyTreasure || this.FHappyTreasure.NeedConfig)
         {
            _loc3_.writeShort(6);
            _loc1_ = 0;
            while(_loc1_ < 6)
            {
               _loc3_.writeUnsignedInt(14100132 + _loc1_);
               _loc3_.writeUnsignedInt(_loc1_ + 1);
               _loc1_++;
            }
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
         _loc3_.writeUnsignedInt(1);
         _loc3_.writeShort(5);
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            _loc3_.writeUnsignedInt(14100132 + _loc1_);
            _loc3_.writeUnsignedInt(_loc1_ + 1);
            _loc1_++;
         }
         _loc3_.position = 0;
         return _loc3_;
      }
   }
}

