package Processors.Game.Lobby.ActivityInner.Window
{
   import Components.ScrollBar.TScrollBar;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.ActivityMode.TActivityAtom;
   import Logics.ActivityMode.TActivityAtoms;
   import Processors.Game.Lobby.ActivityInner.Components.TActivityRewardNoButton;
   import Processors.Game.Lobby.ActivityInner.TProcessorWindowWonderfulActivity;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_WONDERFULACTIVITY;
   import Resources.Strings.STRING_ACTIVITYINNER;
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public class TProcessorWindowActivityInnerUpgrade extends TProcessorWindowWonderfulActivity
   {
      
      protected static const ScrollHeight:int = 356;
      
      protected static const AutoRewardNum:int = 5;
      
      protected static const UpdateTimeSpace:int = 30 * 1000;
      
      protected var FTF_Title:TextField;
      
      protected var FTF_ActivityTime:TextField;
      
      protected var FTF_ActivityColdTime:TextField;
      
      protected var FTF_ActivityDescription:TextField;
      
      protected var FTF_Rank:TextField;
      
      protected var FMC_Detail:MovieClip;
      
      protected var FMC_RewardTop:MovieClip;
      
      protected var FMC_RewardBottom:MovieClip;
      
      protected var FScrollBar:TScrollBar;
      
      protected var FRewardItems:Vector.<TActivityRewardNoButton>;
      
      protected var FDate:Date;
      
      protected var FActivityData:TActivityAtoms;
      
      protected var FTickStore:int;
      
      protected var FIfUpdateRank:Boolean;
      
      public function TProcessorWindowActivityInnerUpgrade(param1:TUIComponent)
      {
         super(param1);
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
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
               this.RequestLevelRank();
            }
         }
      }
      
      override public function UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:int = 0;
         super.UIDispatch(param1);
         this.FTF_Title = param1["TF_Title"];
         this.FMC_Detail = param1["MC_Others"]["MC_Detail"];
         _loc2_ = param1["MC_Others"]["MC_Detail"];
         this.FTF_ActivityTime = _loc2_["TF_Date"];
         this.FTF_ActivityColdTime = _loc2_["TF_Time"];
         this.FTF_ActivityDescription = _loc2_["TF_Desc"];
         _loc2_ = param1["MC_Others"]["MC_Reward"];
         this.FMC_RewardTop = _loc2_["MC_Top"];
         this.FMC_RewardBottom = _loc2_["MC_Bottom"];
         this.FTF_Rank = this.FMC_RewardTop["Rank"]["CurrentRank"];
         this.FDate = new Date();
         this.ConstructRewardUI();
      }
      
      override public function UILocation() : void
      {
         super.UILocation();
      }
      
      protected function ConstructRewardUI() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TActivityRewardNoButton = null;
         this.FScrollBar = new TScrollBar(FMainScene["MC_Others"]["mc_list"],ScrollHeight);
         this.FRewardItems = new Vector.<TActivityRewardNoButton>();
         this.FScrollBar.AddItem(this.FMC_Detail);
         this.FScrollBar.AddItem(this.FMC_RewardTop);
         _loc1_ = 0;
         while(_loc1_ < AutoRewardNum)
         {
            _loc3_ = new TActivityRewardNoButton(this);
            _loc3_.OnSlotOut = SlotOnOut;
            _loc3_.OnSlotOver = SlotOnOver;
            this.FScrollBar.AddItem(_loc3_);
            this.FRewardItems.push(_loc3_);
            _loc1_++;
         }
         this.FScrollBar.AddItem(this.FMC_RewardBottom);
         this.FScrollBar.ScrollToUp();
      }
      
      protected function FlushAutoRecevieData() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TActivityAtom = null;
         var _loc4_:TActivityRewardNoButton = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc8_:Vector.<Object> = null;
         _loc2_ = this.FActivityData.Count;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FActivityData.GetActivityAtomByIndex(_loc1_);
            _loc8_ = _loc3_.ConditionValue;
            if(int(_loc8_[0]) != 0)
            {
               _loc6_ = _loc8_[0].toString() + "~";
            }
            else
            {
               _loc6_ = "";
            }
            _loc7_ = _loc8_[1].toString();
            _loc5_ = TUtilityString.Format(STRING_ACTIVITYINNER.FormatString_Upgrade,_loc6_ + _loc7_);
            _loc4_ = this.FRewardItems[_loc1_];
            _loc4_.FlushData(_loc5_,_loc3_.InventoriesVect[0]);
            _loc1_++;
         }
      }
      
      protected function InitUI() : void
      {
         var _loc1_:String = null;
         var _loc2_:String = null;
         var _loc3_:String = null;
         this.FTF_Title.text = this.FActivityData.RightCaption;
         this.FTF_ActivityDescription.text = this.FActivityData.Desc;
         this.FDate.setTime(STimingCore.GetClientShowTime(this.FActivityData.StartTime) * 1000);
         _loc2_ = TUtilityDate.FormatDateChineseNew(this.FDate);
         this.FDate.setTime(STimingCore.GetClientShowTime(this.FActivityData.EndTime - 1) * 1000);
         _loc3_ = TUtilityDate.FormatDateChineseNew(this.FDate);
         _loc1_ = TUtilityString.Format(STRING_ACTIVITYINNER.FormatString_TimeStartToEnd,_loc2_,_loc3_);
         this.FTF_ActivityTime.text = _loc1_;
      }
      
      protected function RequestLevelRank() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Activity_PowerRankReq);
         _loc1_.Data.writeByte(CONST_WONDERFULACTIVITY.RequestRankType_Level);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
         this.FTickStore = STimingCore.TickCount;
      }
      
      override public function NotifyActivityAtoms(param1:TActivityAtoms) : void
      {
         this.FActivityData = param1;
         this.FlushAutoRecevieData();
         this.InitUI();
         this.RequestLevelRank();
      }
      
      override public function NotifyPacketArrive(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(param1.Data.readUnsignedInt());
         if(_loc2_ == 0)
         {
            this.FTF_Rank.text = ">100";
         }
         else
         {
            this.FTF_Rank.text = _loc2_.toString();
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

