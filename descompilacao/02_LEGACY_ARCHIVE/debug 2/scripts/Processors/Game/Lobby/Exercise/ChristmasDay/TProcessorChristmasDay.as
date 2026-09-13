package Processors.Game.Lobby.Exercise.ChristmasDay
{
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.ChristmasDay.TChristmasDay;
   import Logics.SLogicsCore;
   import Logics.Streamization.Exercise.TUnstreamizerChristmasDay;
   import Processors.Game.Common.Effects.Display.TEffectBaseGlow;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorWindowDesc;
   import Processors.Game.Lobby.Exercise.ChristmasDay.Components.TUIChristmasDayRank;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_SHORTCUTS;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   
   public class TProcessorChristmasDay extends TProcessorLobbyWindows
   {
      
      protected var FMainClip:MovieClip;
      
      protected var FBTN_Close:SimpleButton;
      
      protected var FBTN_Rank:MovieClip;
      
      protected var FBTN_Desc:MovieClip;
      
      protected var FBTN_Mail:MovieClip;
      
      protected var FMC_Box:MovieClip;
      
      protected var FMC_Sock:MovieClip;
      
      protected var FTF_Date:TextField;
      
      protected var FTF_Point:TextField;
      
      protected var FTF_BoxCount:TextField;
      
      protected var FTF_socks:TextField;
      
      protected var FTF_Chongzhi:TextField;
      
      protected var FTF_consume:TextField;
      
      protected var FTF_desc:TextField;
      
      protected var FUIChristmasDayRank:TUIChristmasDayRank;
      
      protected var FProcessorWindowDesc:TProcessorWindowDesc;
      
      protected var FUnstreamizerChristmasDay:TUnstreamizerChristmasDay;
      
      protected var FChristamsDay:TChristmasDay;
      
      protected var FSockFilterGlow:TEffectBaseGlow;
      
      protected var FBoxFilterGlow:TEffectBaseGlow;
      
      protected var FEndTime:int;
      
      protected var FOnOpenActivity:Function;
      
      protected var FGoToOpenShop:Function;
      
      public function TProcessorChristmasDay(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FUIChristmasDayRank = new TUIChristmasDayRank(param1);
         this.FUIChristmasDayRank.OnCloseUp = this.ProcessorOnCloseChristmasRank;
         this.FUIChristmasDayRank.OnOverlay = UIComponentsHintOnOver;
         this.FUIChristmasDayRank.OnOut = UIComponentsHintOnOut;
         this.FProcessorWindowDesc = new TProcessorWindowDesc(param1);
         this.FProcessorWindowDesc.OnCloseUp = this.ProcessorOnCloseDesc;
         this.FUnstreamizerChristmasDay = new TUnstreamizerChristmasDay();
         this.FChristamsDay = SLogicsCore.ChristmasDay;
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(4110417920);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.FMainClip = TUtilityReflection.CreateDisplayObjectInstance("MC_ChristmasDay") as MovieClip;
         addChild(this.FMainClip);
         with(this.FMainClip)
         {
            FMC_Sock = MC_Sock;
            FMC_Box = MC_Box;
            FBTN_Close = BTN_Close;
            FBTN_Rank = Btn_rank;
            FTF_Date = TF_Date;
            FTF_Point = TF_Point;
            FTF_BoxCount = TF_BoxCount;
            FTF_socks = TF_socks;
            FTF_Chongzhi = TF_chongzhi;
            FTF_consume = TF_consume;
            FBTN_Desc = BTN_Desc;
            FTF_desc = TF_desc;
            FBTN_Mail = BTN_Mail;
         }
         this.FSockFilterGlow = new TEffectBaseGlow();
         this.FSockFilterGlow.SetParameters(this.FMC_Sock,15911245,1);
         this.FBoxFilterGlow = new TEffectBaseGlow();
         this.FBoxFilterGlow.SetParameters(this.FMC_Box,15911245,1);
         x = FUICore.StageWidth - width >> 1;
         y = FUICore.StageHeight - height >> 1;
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FBTN_Close.addEventListener(MouseEvent.CLICK,OnClose);
         this.FMC_Box.addEventListener(MouseEvent.CLICK,this.OnBoxClick);
         TGameUtil.setButtonMode(this.FMC_Box,true);
         this.FBTN_Rank.addEventListener(MouseEvent.CLICK,this.OnOpenRank);
         TGameUtil.setButtonMode(this.FBTN_Rank,true);
         this.FMC_Sock.addEventListener(MouseEvent.CLICK,this.OnSockClick);
         TGameUtil.setButtonMode(this.FMC_Sock,true);
         this.FBTN_Desc.addEventListener(MouseEvent.CLICK,this.ProcessorOnOpenDesc);
         TGameUtil.setButtonMode(this.FBTN_Desc,true);
         this.FBTN_Mail.addEventListener(MouseEvent.CLICK,this.ProcessorOnOpenShop);
         TGameUtil.setButtonMode(this.FBTN_Mail,true);
         super.ResourcesPerform_UILocations();
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_ChristmasDay_OpenActiveRet,this.PerformPacket_SC_OpenActiveRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_ChristmasDay_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_ChristmasDay_LoadRankInfoRet,this.PerformPacket_SC_LoadRankInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_ChristmasDay_BuyBoxRet,this.PerformPacket_SC_BuyBoxRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_ChristmasDay_BuySockRet,this.PerformPacket_SC_BuySockRet);
      }
      
      override protected function LogicsPerform() : void
      {
         if(!FIsResourcesLoadCompleted)
         {
            return;
         }
         if(this.FChristamsDay.SocksNum > 0)
         {
            this.FSockFilterGlow.Run();
         }
         else
         {
            this.FSockFilterGlow.Stop();
         }
         if(this.FChristamsDay.BoxNum > 0)
         {
            this.FBoxFilterGlow.Run();
         }
         else
         {
            this.FBoxFilterGlow.Stop();
         }
         super.LogicsPerform();
      }
      
      protected function PerformPacket_SC_OpenActiveRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = param1.Data;
         var _loc3_:int = int(_loc2_.readUnsignedInt());
         var _loc4_:Boolean = _loc3_ == 0 ? false : true;
         this.FEndTime = _loc2_.readUnsignedInt();
         SLogicsCore.ActivityThirdModes.SetActivityStatus(CONST_SHORTCUTS.TYPE_ActiveListThird_ChristmasDay,_loc4_);
         if(!_loc4_ && this.visible)
         {
            ProcessorClose();
         }
         if(this.FOnOpenActivity != null)
         {
            this.FOnOpenActivity();
         }
      }
      
      protected function PerformPacket_SC_LoadInfoRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = param1.Data;
         this.FUnstreamizerChristmasDay.Unstreamize(_loc2_,this.FChristamsDay,null);
         this.UpdateUI();
      }
      
      protected function PerformPacket_SC_LoadRankInfoRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = param1.Data;
         this.FUnstreamizerChristmasDay.UnstreamizationPerformChristmasRank(_loc2_,this.FChristamsDay,null);
         this.FUIChristmasDayRank.UpdateUI();
         this.FUIChristmasDayRank.Visible = true;
      }
      
      protected function PerformPacket_SC_BuyBoxRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         _loc2_ = param1.Data;
         _loc3_ = int(_loc2_.readUnsignedInt());
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         this.FChristamsDay.BoxNum = _loc2_.readUnsignedInt();
         this.FTF_BoxCount.text = this.FChristamsDay.BoxNum.toString();
         EffectGenerateText(STRING_BASEACTIVITY.FORMAT_GET);
      }
      
      protected function PerformPacket_SC_BuySockRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         _loc2_ = param1.Data;
         _loc3_ = int(_loc2_.readUnsignedInt());
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         this.FChristamsDay.SocksNum = _loc2_.readUnsignedInt();
         this.FTF_socks.text = this.FChristamsDay.SocksNum.toString();
         EffectGenerateText(STRING_BASEACTIVITY.FORMAT_GET);
      }
      
      protected function PerformPacket_CS_BuySockReq() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_ChristmasDay_BuySockReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PerformPacket_CS_BuyBoxReq() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_ChristmasDay_BuyBoxReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PerformPacket_CS_LoadInfoReq() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_ChristmasDay_LoadInfoReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PerformPacket_CS_LoadRankInfoReq() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_ChristmasDay_LoadRankInfoReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function UpdateUI() : void
      {
         this.FTF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_OnlyTime,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FChristamsDay.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FChristamsDay.EndTime) - 1) * 1000)));
         this.FTF_Chongzhi.text = TUtilityString.Format(this.FChristamsDay.DescListNew[1],this.FChristamsDay.Recharge);
         this.FTF_consume.text = TUtilityString.Format(this.FChristamsDay.DescListNew[2],this.FChristamsDay.Consume);
         this.FTF_desc.text = TUtilityString.Format(this.FChristamsDay.DescListNew[3],this.FChristamsDay.UseSocks);
         this.FTF_Point.text = this.FChristamsDay.Score.toString();
         this.FTF_BoxCount.text = this.FChristamsDay.BoxNum.toString();
         this.FTF_socks.text = this.FChristamsDay.SocksNum.toString();
      }
      
      protected function ProcessorOnCloseChristmasRank() : void
      {
         this.FUIChristmasDayRank.Visible = false;
      }
      
      protected function ProcessorOnCloseDesc() : void
      {
         this.FProcessorWindowDesc.Visible = false;
      }
      
      protected function ProcessorOnOpenDesc(param1:MouseEvent = null) : void
      {
         this.FProcessorWindowDesc.Visible = true;
         this.FProcessorWindowDesc.UpdateUI(this.FChristamsDay.DescListNew[0]);
      }
      
      protected function ProcessorOnOpenShop(param1:MouseEvent) : void
      {
         if(this.FGoToOpenShop != null)
         {
            this.FGoToOpenShop();
         }
      }
      
      public function set GoToOpenShop(param1:Function) : void
      {
         this.FGoToOpenShop = param1;
      }
      
      public function get GoToOpenShop() : Function
      {
         return this.FGoToOpenShop;
      }
      
      protected function OnBoxClick(param1:MouseEvent) : void
      {
         this.PerformPacket_CS_BuyBoxReq();
      }
      
      protected function OnOpenRank(param1:MouseEvent) : void
      {
         this.PerformPacket_CS_LoadRankInfoReq();
      }
      
      protected function OnSockClick(param1:MouseEvent) : void
      {
         this.PerformPacket_CS_BuySockReq();
      }
      
      public function get OnOpenActivity() : Function
      {
         return this.FOnOpenActivity;
      }
      
      public function set OnOpenActivity(param1:Function) : void
      {
         this.FOnOpenActivity = param1;
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount();
         if(!FIsResourcesLoadCompleted)
         {
            this.FUIChristmasDayRank.Load();
            this.FProcessorWindowDesc.Load();
            return;
         }
         this.PerformPacket_CS_LoadInfoReq();
      }
   }
}

