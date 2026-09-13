package Processors.Game.Lobby.ActivityInner.Window
{
   import Components.ScrollBar.TScrollBar;
   import Components.Slots.TUISlot;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Queries.TQueryString;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Resources.Repositories.TResourceRepositoryTexture;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Resources.Textures.TTexture;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityStandardBTN;
   import Foundation.Utilities.TUtilityString;
   import Logics.ActivityMode.TActivityAtom;
   import Logics.ActivityMode.TActivityAtoms;
   import Logics.Inventories.TAppliance;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Processors.Game.Lobby.ActivityInner.Components.TActivityReward;
   import Processors.Game.Lobby.ActivityInner.TProcessorWindowWonderfulActivity;
   import Processors.Game.Lobby.Jade.TJadeCommon;
   import Resources.Constants.CONST_ACTIVITY_MODE;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_WONDERFULACTIVITY;
   import Resources.Strings.STRING_ACTIVITYINNER;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorWindowActivityInnerFightingPower extends TProcessorWindowWonderfulActivity
   {
      
      protected static const SlotNum:int = 6;
      
      protected static const ScrollHeight:int = 356;
      
      protected static const UpdateTimeSpace:int = 30 * 1000;
      
      protected static const AutoRewardNum:int = 5;
      
      protected var FTF_Title:TextField;
      
      protected var FTF_ActivityTime:TextField;
      
      protected var FTF_ActivityColdTime:TextField;
      
      protected var FTF_ActivityDescription:TextField;
      
      protected var FTF_MyPower:TextField;
      
      protected var FTF_GoalPower:TextField;
      
      protected var FRewardsSlot:Vector.<TUISlot>;
      
      protected var FBtn_Receive:MovieClip;
      
      protected var FBtn_CantRecive:MovieClip;
      
      protected var FTF_CantRecive:TextField;
      
      protected var FTF_Rank:TextField;
      
      protected var FMC_Detail:MovieClip;
      
      protected var FMC_Power:MovieClip;
      
      protected var FMC_RewardTop:MovieClip;
      
      protected var FMC_RewardBottom:MovieClip;
      
      protected var FScrollBar:TScrollBar;
      
      protected var FRewardItems:Vector.<TActivityReward>;
      
      protected var FDate:Date;
      
      protected var FActivityData:TActivityAtoms;
      
      protected var FActivityDataAutoReceive:TActivityAtoms;
      
      protected var FActivityDataManualReceive:TActivityAtom;
      
      protected var FTickStore:int;
      
      protected var FIfUpdateRank:Boolean;
      
      protected var FCurrentPower:uint;
      
      protected var FInit:Boolean;
      
      protected var FInforArray:Array;
      
      public function TProcessorWindowActivityInnerFightingPower(param1:TUIComponent)
      {
         super(param1);
         this.FActivityDataAutoReceive = new TActivityAtoms(0);
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:int = 0;
         super.LogicsPerform();
         if(this.FRewardItems != null)
         {
            _loc1_ = 0;
            while(_loc1_ < this.FRewardItems.length)
            {
               this.FRewardItems[_loc1_].UpdateSlot();
               _loc1_++;
            }
            _loc1_ = 0;
            while(_loc1_ < this.FRewardsSlot.length)
            {
               this.FRewardsSlot[_loc1_].Update();
               _loc1_++;
            }
         }
         if(this.FActivityData != null && this.FTF_ActivityColdTime != null)
         {
            _loc2_ = this.FActivityData.EndTime - STimingCore.GetServerTick();
            this.FTF_ActivityColdTime.text = FormatTime(_loc2_);
         }
         if(this.FIfUpdateRank)
         {
            if(STimingCore.TickCount - this.FTickStore >= UpdateTimeSpace)
            {
               this.RequestPowerRank();
            }
         }
      }
      
      override public function UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:int = 0;
         var _loc4_:TUISlot = null;
         super.UIDispatch(param1);
         this.FTF_Title = param1["TF_Title"];
         this.FMC_Detail = param1["MC_Others"]["MC_Detail"];
         _loc2_ = param1["MC_Others"]["MC_Detail"];
         this.FTF_ActivityTime = _loc2_["TF_Date"];
         this.FTF_ActivityColdTime = _loc2_["TF_Time"];
         this.FTF_ActivityDescription = _loc2_["TF_Desc"];
         this.FMC_Power = param1["MC_Others"]["MyPower"];
         _loc2_ = param1["MC_Others"]["MyPower"];
         this.FTF_MyPower = _loc2_["TF_MyPower"];
         this.FTF_GoalPower = _loc2_["TF_GoalPower"];
         this.FBtn_CantRecive = _loc2_["MC_Get"];
         this.FTF_CantRecive = this.FBtn_CantRecive["TF_CantRecevie"];
         this.FBtn_Receive = _loc2_["BTN_GetReward"];
         this.FBtn_Receive.stop();
         this.FRewardsSlot = new Vector.<TUISlot>();
         _loc3_ = 0;
         while(_loc3_ < SlotNum)
         {
            _loc4_ = new TUISlot(this);
            _loc4_.Resource = _loc2_["MC_Slot_" + _loc3_];
            _loc4_.OnOut = SlotOnOut;
            _loc4_.OnOverlay = SlotOnOver;
            TJadeCommon.InitSlot(_loc4_,CONST_MODULES.MODULE_ActivityInner);
            _loc4_.Init();
            this.FRewardsSlot.push(_loc4_);
            _loc3_++;
         }
         _loc2_ = param1["MC_Others"]["MC_Reward"];
         this.FMC_RewardTop = _loc2_["MC_Top"];
         this.FMC_RewardBottom = _loc2_["MC_Bottom"];
         this.FTF_Rank = this.FMC_RewardTop["Rank"]["CurrentRank"];
         this.FDate = new Date();
         this.FInforArray = new Array();
         this.ConstructRewardUI();
      }
      
      override public function UILocation() : void
      {
         super.UILocation();
         TUtilityStandardBTN.SetBtnEventListener(this.FBtn_Receive,this.ReceiveBtnClick);
         this.FBtn_Receive.buttonMode = true;
      }
      
      protected function ConstructRewardUI() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TActivityReward = null;
         this.FScrollBar = new TScrollBar(FMainScene["MC_Others"]["mc_list"],ScrollHeight);
         this.FRewardItems = new Vector.<TActivityReward>();
         this.FScrollBar.AddItem(this.FMC_Detail);
         this.FScrollBar.AddItem(this.FMC_Power);
         this.FScrollBar.AddItem(this.FMC_RewardTop);
         _loc1_ = 0;
         while(_loc1_ < AutoRewardNum)
         {
            _loc3_ = new TActivityReward(this);
            _loc3_.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
            _loc3_.OnOverlay = SlotOnOver;
            _loc3_.OnOut = SlotOnOut;
            _loc3_.OnQuerySubscript = this.SlotsOnQuerySubscript;
            _loc3_.Init();
            _loc3_.HideBtn();
            this.FScrollBar.AddItem(_loc3_);
            this.FRewardItems.push(_loc3_);
            _loc1_++;
         }
         this.FScrollBar.AddItem(this.FMC_RewardBottom);
         this.FScrollBar.ScrollToUp();
      }
      
      protected function SlotsOnQuerySubscript(param1:Object, param2:Object, param3:TQueryString) : void
      {
         var _loc4_:TAppliance = null;
         if(param2 is TAppliance)
         {
            _loc4_ = param2 as TAppliance;
            param3.Value = _loc4_.Quantity.toString();
         }
      }
      
      protected function SlotsOnQuerySequenceContext(param1:Object, param2:Object, param3:TQueryAnimationSequence, param4:uint = 0) : void
      {
         var _loc5_:TInventory = null;
         var _loc6_:TResourceRepositoryTexture = null;
         var _loc7_:TTexture = null;
         _loc5_ = param2 as TInventory;
         _loc6_ = SResourcesCore.TexturesInventory;
         _loc7_ = _loc6_.GetTextureByIdentifier(_loc5_.IDTexture);
         if(_loc7_ != null)
         {
            param3.Value = _loc7_.GetAnimationSequenceByIdentifier(param4);
         }
         else
         {
            _loc6_.LoadSecondary(_loc5_.IDTexture,CONST_MODULES.MODULE_ActivityInner);
         }
      }
      
      protected function FlushManualRecevieData() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TInventories = null;
         _loc3_ = this.FActivityDataManualReceive.InventoriesVect[0];
         _loc2_ = _loc3_.Count;
         _loc1_ = 0;
         while(_loc1_ < this.FRewardsSlot.length)
         {
            if(_loc1_ < _loc2_)
            {
               this.FRewardsSlot[_loc1_].Context = _loc3_.GetInventoryByIndex(_loc1_);
               this.FRewardsSlot[_loc1_].Resource.visible = true;
            }
            else
            {
               this.FRewardsSlot[_loc1_].Resource.visible = false;
            }
            _loc1_++;
         }
      }
      
      protected function FlushAutoRecevieData() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TActivityAtom = null;
         var _loc4_:TActivityAtom = null;
         var _loc5_:TActivityReward = null;
         var _loc6_:String = null;
         var _loc7_:TInventories = null;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:String = null;
         var _loc11_:String = null;
         if(this.FInforArray.length == 0)
         {
            return;
         }
         _loc2_ = this.FActivityDataAutoReceive.Count;
         _loc9_ = this.FInforArray.length / 2;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FActivityDataAutoReceive.GetActivityAtomByIndex(_loc1_);
            _loc5_ = this.FRewardItems[_loc1_];
            _loc6_ = TUtilityString.Format(STRING_ACTIVITYINNER.FormatString_ArenaRank,_loc1_ + 1 + "");
            if(_loc1_ < _loc9_)
            {
               _loc10_ = this.FInforArray[_loc1_ << 1];
               _loc11_ = STRING_ACTIVITYINNER.STREING_HighRank + this.FInforArray[(_loc1_ << 1) + 1];
            }
            else
            {
               _loc10_ = STRING_ACTIVITYINNER.STREING_NoRank;
               _loc11_ = STRING_ACTIVITYINNER.STREING_NoRank;
            }
            _loc5_.SetText(_loc6_,_loc10_,_loc11_);
            _loc7_ = _loc3_.InventoriesVect[0];
            _loc8_ = 0;
            while(_loc8_ < _loc7_.Count)
            {
               _loc5_.SetItemInfo(_loc8_,_loc7_.GetInventoryByIndex(_loc8_));
               _loc8_++;
            }
            _loc1_++;
         }
      }
      
      protected function InitUI() : void
      {
         var _loc1_:String = null;
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:uint = 0;
         this.FTF_Title.text = this.FActivityData.RightCaption;
         this.FTF_ActivityDescription.text = this.FActivityData.Desc;
         this.FDate.setTime(STimingCore.GetClientShowTime(this.FActivityData.StartTime) * 1000);
         _loc2_ = TUtilityDate.FormatDateChineseNew(this.FDate);
         this.FDate.setTime(STimingCore.GetClientShowTime(this.FActivityData.EndTime - 1) * 1000);
         _loc3_ = TUtilityDate.FormatDateChineseNew(this.FDate);
         _loc1_ = TUtilityString.Format(STRING_ACTIVITYINNER.FormatString_TimeStartToEnd,_loc2_,_loc3_);
         this.FTF_ActivityTime.text = _loc1_;
         this.UpdateBtn();
      }
      
      protected function UpdateBtn() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:String = null;
         if(this.FActivityDataManualReceive == null)
         {
            return;
         }
         _loc2_ = TUtilityString.Format(STRING_ACTIVITYINNER.FormatString_MyPower,this.FCurrentPower.toString());
         this.FTF_MyPower.text = _loc2_;
         _loc1_ = uint(this.FActivityDataManualReceive.ConditionValue[0]);
         _loc2_ = TUtilityString.Format(STRING_ACTIVITYINNER.FormatString_GoalPower,_loc1_.toString());
         this.FTF_GoalPower.text = _loc2_;
         if(this.FActivityDataManualReceive.ActiveStatus == CONST_ACTIVITY_MODE.Activity_AlreadyReceive)
         {
            this.FTF_CantRecive.text = STRING_ACTIVITYINNER.STREING_AlreadyReward;
            this.FBtn_CantRecive.visible = true;
         }
         else if(this.FCurrentPower < _loc1_)
         {
            this.FTF_CantRecive.text = STRING_ACTIVITYINNER.STREING_CannotReward;
            this.FBtn_CantRecive.visible = true;
         }
         else
         {
            this.FBtn_CantRecive.visible = false;
         }
      }
      
      protected function FiliterAutoReceiveAtom() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TActivityAtom = null;
         this.FActivityDataAutoReceive.Clear();
         _loc1_ = 0;
         while(_loc1_ < this.FActivityData.Count)
         {
            _loc2_ = this.FActivityData.GetActivityAtomByIndex(_loc1_);
            if(_loc2_.GetType == CONST_ACTIVITY_MODE.GetType_Auto)
            {
               this.FActivityDataAutoReceive.Add(_loc2_);
            }
            else
            {
               this.FActivityDataManualReceive = _loc2_;
            }
            _loc1_++;
         }
      }
      
      protected function RequestPowerRank() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Activity_PowerRankReq);
         if(this.FActivityData.Identifier == 11)
         {
            _loc1_.Data.writeByte(CONST_WONDERFULACTIVITY.RequestRankType_Power);
         }
         else
         {
            _loc1_.Data.writeByte(CONST_WONDERFULACTIVITY.RequestRankType_HFPower);
         }
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
         this.FTickStore = STimingCore.TickCount;
      }
      
      protected function RequestPower() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Activity_PowerReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function ReceiveBtnClick(param1:MouseEvent) : void
      {
         ReceiveAward(this.FActivityDataManualReceive.Identifier);
      }
      
      public function IsInit() : Boolean
      {
         return this.FInit;
      }
      
      override public function NotifyActivityAtoms(param1:TActivityAtoms) : void
      {
         this.FActivityData = param1;
         this.FiliterAutoReceiveAtom();
         this.FlushManualRecevieData();
         this.FlushAutoRecevieData();
         this.InitUI();
         this.RequestPowerRank();
      }
      
      override public function NotifyPacketArrive(param1:TPacket) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:uint = 0;
         _loc5_ = param1.Data.readUnsignedInt();
         if(_loc5_ == 0)
         {
            this.FTF_Rank.text = ">100";
         }
         else
         {
            this.FTF_Rank.text = _loc5_.toString();
         }
         _loc2_ = param1.Data.readUnsignedShort();
         this.FInforArray.length = 0;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = TUtilityString.FetchUTF(param1.Data);
            this.FInforArray.push(_loc4_);
            _loc5_ = param1.Data.readUnsignedInt();
            this.FInforArray.push(_loc5_);
            _loc3_++;
         }
         this.FlushAutoRecevieData();
      }
      
      override public function Show() : void
      {
         super.Show();
         this.FIfUpdateRank = true;
         if(!this.FInit)
         {
            this.RequestPower();
            this.FInit = true;
         }
      }
      
      override public function Hide() : void
      {
         super.Hide();
         this.FIfUpdateRank = false;
      }
      
      public function SendPower(param1:TPacket) : void
      {
         this.FCurrentPower = param1.Data.readUnsignedInt();
         this.UpdateBtn();
      }
   }
}

