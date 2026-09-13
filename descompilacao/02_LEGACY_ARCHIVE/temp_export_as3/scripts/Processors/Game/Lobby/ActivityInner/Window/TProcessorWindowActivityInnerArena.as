package Processors.Game.Lobby.ActivityInner.Window
{
   import Components.ScrollBar.*;
   import Foundation.Common.THint;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.*;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.ActivityMode.*;
   import Logics.Inventories.TInventories;
   import Processors.Game.Lobby.ActivityInner.Components.TActivityRewardNoButton;
   import Processors.Game.Lobby.ActivityInner.TProcessorWindowWonderfulActivity;
   import Processors.Game.Lobby.Common.*;
   import Processors.Game.Lobby.Recharge.Components.*;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Strings.STRING_ACTIVITYINNER;
   import flash.display.*;
   import flash.events.*;
   import flash.text.*;
   import flash.utils.ByteArray;
   
   public class TProcessorWindowActivityInnerArena extends TProcessorWindowWonderfulActivity
   {
      
      protected static const RankGroupNum:int = 3;
      
      protected static const ScrollHeight:int = 359;
      
      protected static const OneDaySecond:int = 24 * 60 * 60;
      
      protected static const UpdateTimeSpace:int = 30 * 1000;
      
      protected static const ArenaDispatchReward:int = 19 * 60 * 60 + 30 * 60;
      
      protected static const AutoRewardNum:int = 3;
      
      protected var FTF_Title:TextField;
      
      protected var FTF_ActivityTime:TextField;
      
      protected var FTF_ActivityColdTime:TextField;
      
      protected var FTF_ActivityDescription:TextField;
      
      protected var FBTN_GoArean:SimpleButton;
      
      protected var FTF_RanksInfor:Vector.<TextField>;
      
      protected var FTF_LuckNum:TextField;
      
      protected var FMC_Detail:MovieClip;
      
      protected var FTF_Detail:TextField;
      
      protected var FMC_GroupRank:MovieClip;
      
      protected var FMC_RewardTop:MovieClip;
      
      protected var FMC_RewardBottom:MovieClip;
      
      protected var FTF_Rank:TextField;
      
      protected var FActivityData:TActivityAtoms;
      
      protected var FDate:Date;
      
      protected var FDateB:Date;
      
      protected var FInventories:TInventories;
      
      protected var FMC_Tip:MovieClip;
      
      protected var FScrollBar:TScrollBar;
      
      protected var FRewardItems:Vector.<TActivityRewardNoButton>;
      
      protected var FTickStore:int;
      
      protected var FIfUpdateRank:Boolean;
      
      protected var FHintReward:THint;
      
      public function TProcessorWindowActivityInnerArena(param1:TUIComponent)
      {
         super(param1);
      }
      
      override public function UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:MovieClip = null;
         var _loc4_:int = 0;
         super.UIDispatch(param1);
         this.FTF_Title = param1["TF_Title"];
         _loc2_ = param1["MC_Others"]["MC_Detail"];
         this.FMC_Detail = _loc2_;
         this.FTF_ActivityTime = _loc2_["TF_Date"];
         this.FTF_ActivityColdTime = _loc2_["TF_Time"];
         this.FTF_ActivityDescription = _loc2_["TF_Desc"];
         this.FBTN_GoArean = param1["MC_Others"]["Btn_Goto"];
         this.FMC_Detail.addChild(this.FBTN_GoArean);
         _loc2_ = param1["MC_Others"]["MC_Rank"];
         this.FMC_GroupRank = _loc2_;
         this.FTF_RanksInfor = new Vector.<TextField>();
         _loc4_ = 0;
         while(_loc4_ < RankGroupNum)
         {
            _loc3_ = _loc2_["Group" + (_loc4_ + 1)];
            this.FTF_RanksInfor.push(_loc3_["TF_Time"]);
            this.FTF_RanksInfor.push(_loc3_["TF_First"]);
            this.FTF_RanksInfor.push(_loc3_["TF_Second"]);
            this.FTF_RanksInfor.push(_loc3_["TF_Third"]);
            _loc4_++;
         }
         this.FTF_LuckNum = _loc2_["TF_LuckNum"];
         this.FMC_Tip = _loc2_["Task"];
         _loc2_ = param1["MC_Others"]["MC_Reward"];
         this.FMC_RewardTop = _loc2_["MC_Top"];
         this.FMC_RewardBottom = _loc2_["MC_Bottom"];
         this.FTF_Rank = this.FMC_RewardTop["Rank"]["CurrentRank"];
         this.FDate = new Date();
         this.FDateB = new Date();
         this.FInventories = new TInventories();
         this.FHintReward = new THint();
         this.ConstructRewardUI();
      }
      
      override public function UILocation() : void
      {
         super.UILocation();
         this.FBTN_GoArean.addEventListener(MouseEvent.CLICK,this.GoAreanBtnClick);
         this.FMC_Tip.addEventListener(MouseEvent.MOUSE_MOVE,this.OnMouseOver);
         this.FMC_Tip.addEventListener(MouseEvent.MOUSE_OUT,this.OnMouseOut);
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         super.LogicsPerform();
         if(this.FRewardItems != null)
         {
            _loc1_ = 0;
            while(_loc1_ < this.FRewardItems.length)
            {
               this.FRewardItems[_loc1_].Update();
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
               this.RequestArena();
            }
         }
      }
      
      protected function ConstructRewardUI() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TActivityRewardNoButton = null;
         this.FScrollBar = new TScrollBar(FMainScene["MC_Others"]["mc_list"],ScrollHeight);
         this.FRewardItems = new Vector.<TActivityRewardNoButton>();
         this.FScrollBar.AddItem(this.FMC_Detail);
         this.FScrollBar.AddItem(this.FMC_GroupRank);
         this.FScrollBar.AddItem(this.FMC_RewardTop);
         _loc1_ = 0;
         while(_loc1_ < AutoRewardNum)
         {
            _loc3_ = new TActivityRewardNoButton(this);
            _loc3_.OnSlotOver = SlotOnOver;
            _loc3_.OnSlotOut = SlotOnOut;
            this.FScrollBar.AddItem(_loc3_);
            this.FRewardItems.push(_loc3_);
            _loc1_++;
         }
         this.FScrollBar.AddItem(this.FMC_RewardBottom);
         this.FScrollBar.ScrollToUp();
      }
      
      protected function FlushData() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TActivityAtom = null;
         var _loc4_:TActivityRewardNoButton = null;
         var _loc5_:String = null;
         var _loc6_:TInventories = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         _loc3_ = this.FActivityData.GetActivityAtomByIndex(1);
         _loc7_ = this.FActivityData.StartTime / OneDaySecond;
         _loc8_ = STimingCore.GetServerTick() / OneDaySecond;
         _loc9_ = _loc8_ - _loc7_;
         if(STimingCore.GetServerTick() % OneDaySecond >= ArenaDispatchReward)
         {
            _loc9_++;
         }
         _loc2_ = this.FActivityData.Count - 1;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FActivityData.GetActivityAtomByIndex(_loc1_ + 1);
            _loc10_ = _loc3_.ConditionValue[0] as int;
            if(_loc10_ > _loc9_)
            {
               break;
            }
            _loc1_++;
         }
         _loc2_ = int(_loc3_.InventoriesVect.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc6_ = _loc3_.InventoriesVect[_loc1_];
            _loc4_ = this.FRewardItems[_loc1_];
            _loc5_ = TUtilityString.Format(STRING_ACTIVITYINNER.FormatString_ArenaRank,_loc1_ + 1 + "");
            _loc4_.FlushData(_loc5_,_loc6_);
            _loc1_++;
         }
      }
      
      protected function InitUI() : void
      {
         var _loc1_:String = null;
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc5_:TActivityAtom = null;
         var _loc6_:int = 0;
         var _loc7_:Vector.<int> = null;
         var _loc8_:int = 0;
         var _loc9_:Object = null;
         var _loc10_:int = 0;
         this.FTF_Title.text = this.FActivityData.RightCaption;
         this.FTF_ActivityDescription.text = this.FActivityData.Desc;
         this.FDate.setTime(STimingCore.GetClientShowTime(this.FActivityData.StartTime) * 1000);
         _loc2_ = TUtilityDate.FormatDateChineseNew(this.FDate);
         this.FDate.setTime(STimingCore.GetClientShowTime(this.FActivityData.EndTime - 1) * 1000);
         _loc3_ = TUtilityDate.FormatDateChineseNew(this.FDate);
         _loc1_ = TUtilityString.Format(STRING_ACTIVITYINNER.FormatString_TimeStartToEnd,_loc2_,_loc3_);
         this.FTF_ActivityTime.text = _loc1_;
         _loc8_ = (STimingCore.GetServerTick() - this.FActivityData.StartTime) / OneDaySecond;
         _loc5_ = this.FActivityData.GetActivityAtomByIndex(0);
         _loc4_ = int(_loc5_.ConditionValue.length);
         _loc4_ = _loc8_ % _loc4_;
         _loc1_ = _loc5_.ConditionValue[_loc4_].toString();
         this.FTF_LuckNum.text = _loc1_;
         _loc8_ = STimingCore.GetServerTick() - this.FActivityData.StartTime;
         _loc4_ = this.FActivityData.Count;
         _loc6_ = 1;
         while(_loc6_ < _loc4_)
         {
            _loc5_ = this.FActivityData.GetActivityAtomByIndex(_loc6_);
            _loc10_ = _loc5_.ConditionValue[0] as int;
            _loc8_ = this.FActivityData.StartTime + (_loc10_ - 1) * OneDaySecond;
            this.FDate.setTime(_loc8_ * 1000);
            this.FTF_RanksInfor[(_loc6_ - 1) * 4 + 0].text = TUtilityDate.FormatDate(this.FDate);
            _loc6_++;
         }
      }
      
      protected function RequestArena() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Activity_ArenaDataReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
         this.FTickStore = STimingCore.TickCount;
      }
      
      protected function GoAreanBtnClick(param1:MouseEvent) : void
      {
         JmpToWindow();
      }
      
      protected function OnMouseOver(param1:MouseEvent) : void
      {
         MouseOnHitOver(this,this.FHintReward);
      }
      
      protected function OnMouseOut(param1:MouseEvent) : void
      {
         MouseOnHitOut(this);
      }
      
      override public function NotifyActivityAtoms(param1:TActivityAtoms) : void
      {
         this.FActivityData = param1;
         this.FlushData();
         this.InitUI();
         this.RequestArena();
         this.FHintReward.Caption = this.FActivityData.GetActivityAtomByIndex(0).Tips[0];
      }
      
      override public function NotifyPacketArrive(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:TextField = null;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:String = null;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         _loc8_ = 0;
         while(_loc8_ < this.FTF_RanksInfor.length)
         {
            if(_loc8_ % 4 != 0)
            {
               this.FTF_RanksInfor[_loc8_].text = STRING_ACTIVITYINNER.STREING_NoRank;
            }
            _loc8_++;
         }
         _loc2_ = param1.Data;
         _loc2_.readInt();
         _loc6_ = int(_loc2_.readUnsignedShort());
         if(_loc6_ == 1000)
         {
            this.FTF_Rank.text = ">1000";
         }
         else
         {
            this.FTF_Rank.text = _loc6_.toString();
         }
         _loc9_ = _loc2_.readShort();
         _loc8_ = 0;
         while(_loc8_ < _loc9_)
         {
            _loc11_ = _loc2_.readShort();
            _loc10_ = 0;
            while(_loc10_ < _loc11_)
            {
               _loc4_ = TUtilityString.FetchUTF(_loc2_);
               _loc7_ = STRING_ACTIVITYINNER.FormatString_Ranks[_loc10_];
               _loc4_ = TUtilityString.Format(_loc7_,_loc4_);
               this.FTF_RanksInfor[_loc8_ * 4 + _loc10_ + 1].text = _loc4_;
               _loc10_++;
            }
            _loc8_++;
         }
      }
      
      override public function Show() : void
      {
         super.Show();
         this.FIfUpdateRank = true;
      }
      
      override public function Hide() : void
      {
         super.Hide();
         this.FIfUpdateRank = false;
      }
   }
}

