package Processors.Game.Lobby.Recruit
{
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Logics.DatebaseVO.VO.TDrawNinjaArchive;
   import Logics.Recruit.TRecruitData;
   import Logics.Recruit.TRecruitLevelGiftsData;
   import Logics.Streamization.Recruit.TUnstreamizerRecruit;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Strings.STRING_BASEACTIVITY;
   import Resources.Strings.STRING_TOPTEAM;
   import flash.utils.ByteArray;
   
   public class TProcessorRecruit extends TProcessorLobbyWindows
   {
      
      public static var RecruitType:int = 1;
      
      protected var FProcessorWindowRecruit:TProcessorWindowRecruit;
      
      protected var FProcessorWindowRecruitArchive:TProcessorWindowRecruitArchive;
      
      protected var FProcessorWindowRecruitPerview:TProcessorWindowRecruitPerview;
      
      protected var FProcessorWindowRecruitLevelGifts:TProcessorWindowRecruitLevelGifts;
      
      protected var FProcessorWindowRecruitMall:TProcessorWindowRecruitMall;
      
      protected var FUnstreamizerRecruit:TUnstreamizerRecruit;
      
      protected var FRecruitData:TRecruitData;
      
      protected var FLevelGiftData:TRecruitLevelGiftsData;
      
      public function TProcessorRecruit(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FProcessorWindowRecruit = new TProcessorWindowRecruit(param1);
         this.FProcessorWindowRecruit.OnDrawNinjaReq = this.PerformPacket_CS_Draw_Req;
         this.FProcessorWindowRecruit.OnOpenArchive = this.OnOpenArchive;
         this.FProcessorWindowRecruit.OnOpenPerview = this.OnOpenPerview;
         this.FProcessorWindowRecruit.OnOpenMall = this.OnOpenMall;
         this.FProcessorWindowRecruit.OnClose = this.ProcessorWindowOnClose;
         this.FProcessorWindowRecruit.OnHelpHintOver = UIHelpTipsHintOnOver;
         this.FProcessorWindowRecruit.OnHelpHintOut = UIHelpTipsHintOnOut;
         this.FProcessorWindowRecruitArchive = new TProcessorWindowRecruitArchive(param1);
         this.FProcessorWindowRecruitArchive.OnActivateReq = this.PerformPacket_CS_Activate_Req;
         this.FProcessorWindowRecruitArchive.OnUpstarReq = this.PerformPacket_CS_UpStar_Req;
         this.FProcessorWindowRecruitArchive.OnClose = this.ProcessorWindowOnClose;
         this.FProcessorWindowRecruitArchive.OnOpenLevelGifts = this.OnOpenLevelGifts;
         this.FProcessorWindowRecruitPerview = new TProcessorWindowRecruitPerview(param1);
         this.FProcessorWindowRecruitPerview.OnClose = this.ProcessorWindowOnClose;
         this.FProcessorWindowRecruitLevelGifts = new TProcessorWindowRecruitLevelGifts(param1);
         this.FProcessorWindowRecruitLevelGifts.OnClose = this.ProcessorWindowOnClose;
         this.FProcessorWindowRecruitLevelGifts.UpdateEffectGlow = this.FProcessorWindowRecruitArchive.UpdateEffectGlow;
         this.FProcessorWindowRecruitLevelGifts.OnHelpHintOver = UIHelpTipsHintOnOver;
         this.FProcessorWindowRecruitLevelGifts.OnHelpHintOut = UIHelpTipsHintOnOut;
         this.FProcessorWindowRecruitLevelGifts.OnHintOver = UIComponentsHintOnOver;
         this.FProcessorWindowRecruitLevelGifts.OnHintOut = UIComponentsHintOnOut;
         this.FProcessorWindowRecruitMall = new TProcessorWindowRecruitMall(param1);
         this.FProcessorWindowRecruitMall.OnMallBuy = this.ProcessorOnMallBuy;
         this.FProcessorWindowRecruitMall.SlotOnOver = UIComponentsHintOnOver;
         this.FProcessorWindowRecruitMall.SlotOnOut = UIComponentsHintOnOut;
         this.FUnstreamizerRecruit = new TUnstreamizerRecruit();
         this.FRecruitData = new TRecruitData();
         this.FLevelGiftData = new TRecruitLevelGiftsData();
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Recruit_Info_Ret,this.PerformPacket_SC_Info_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Recruit_UpStar_Ret,this.PerformPacket_SC_UpStar_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Recruit_Activate_Ret,this.PerformPacket_SC_Activate_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Recruit_Draw_Ret,this.PerformPacket_SC_Draw_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Recruit_WarOrder_Info_Ret,this.PerformPacket_SC_WarOrder_Info_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Recruit_WarOrder_Reward_Ret,this.PerformPacket_SC_WarOrder_Reward_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Recruit_Buy_Ret,this.PerformPacket_SC_Buy_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Recruit_Open_Ret,this.PerformPacket_SC_Open_Ret);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(4076863491);
         SResourcesCore.TexturesLobby.LoadPrimary(13610042);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.FUnstreamizerRecruit.UnstreamizationByDatabase(null,this.FRecruitData,null);
         super.ResourcesPerform_UIDispatch();
      }
      
      protected function PerformPacket_SC_Info_Ret(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:ByteArray = null;
         _loc3_ = param1.Data;
         _loc2_ = _loc3_.readInt();
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         this.FUnstreamizerRecruit.Unstreamize(_loc3_,this.FRecruitData,null);
         this.FRecruitData.Score = _loc3_.readInt();
         this.FRecruitData.Point = _loc3_.readInt();
         this.FProcessorWindowRecruitArchive.UpdateUI(this.FRecruitData);
         this.FProcessorWindowRecruitMall.UpdateNinjaPointUI(this.FRecruitData.Point);
      }
      
      protected function PerformPacket_CS_Info_Req() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Recruit_Info_Req);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PerformPacket_SC_UpStar_Ret(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:ByteArray = null;
         _loc3_ = param1.Data;
         _loc2_ = _loc3_.readInt();
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         this.FUnstreamizerRecruit.Unstreamize(_loc3_,this.FRecruitData,null);
         this.FProcessorWindowRecruitArchive.UpdateUI(this.FRecruitData);
      }
      
      protected function PerformPacket_CS_UpStar_Req(param1:int) : void
      {
         var _loc2_:TPacket = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Recruit_UpStar_Req);
         _loc2_.Data.writeInt(param1);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function PerformPacket_SC_Activate_Ret(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:ByteArray = null;
         _loc3_ = param1.Data;
         _loc2_ = _loc3_.readInt();
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         this.FUnstreamizerRecruit.Unstreamize(_loc3_,this.FRecruitData,null);
         this.FProcessorWindowRecruitArchive.UpdateUI(this.FRecruitData);
      }
      
      protected function PerformPacket_CS_Activate_Req(param1:int) : void
      {
         var _loc2_:TPacket = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Recruit_Activate_Req);
         _loc2_.Data.writeInt(param1);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function PerformPacket_SC_Draw_Ret(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:ByteArray = null;
         var _loc4_:Vector.<TDrawNinjaArchive> = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         _loc3_ = param1.Data;
         _loc2_ = _loc3_.readInt();
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         _loc5_ = _loc3_.readInt();
         _loc6_ = _loc3_.readInt();
         _loc4_ = Vector.<TDrawNinjaArchive>([]);
         this.FUnstreamizerRecruit.Unstreamize(_loc3_,this.FRecruitData,_loc4_);
         this.FProcessorWindowRecruitArchive.UpdateUI(this.FRecruitData);
         this.FProcessorWindowRecruit.UpdateUI(_loc4_,_loc5_,_loc6_);
      }
      
      protected function PerformPacket_CS_Draw_Req(param1:int, param2:int) : void
      {
         var _loc3_:TPacket = null;
         _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Recruit_Draw_Req);
         _loc3_.Data.writeInt(param1);
         _loc3_.Data.writeInt(param2);
         SNetworkCore.Transceiver.PacketTransmit(_loc3_);
      }
      
      protected function PerformPacket_SC_WarOrder_Info_Ret(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = param1.Data;
         this.FUnstreamizerRecruit.UnstreamizationRecruitWarOrder(_loc2_,this.FLevelGiftData,null);
         this.FProcessorWindowRecruitLevelGifts.UpdateUI(this.FLevelGiftData);
      }
      
      protected function PerformPacket_CS_WarOrder_Info_Req() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Recruit_WarOrder_Info_Req);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PerformPacket_SC_WarOrder_Reward_Ret(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         this.FProcessorWindowRecruitLevelGifts.ProcessorUpReward(param1);
         EffectGenerateText(STRING_BASEACTIVITY.FORMAT_GET);
      }
      
      protected function PerformPacket_SC_Buy_Ret(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         EffectGenerateText(STRING_TOPTEAM.STRING_ChargeSuccess);
      }
      
      protected function ProcessorOnMallBuy(param1:Object, param2:uint, param3:uint) : void
      {
         var _loc4_:TPacket = null;
         var _loc5_:ByteArray = null;
         _loc4_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Recruit_Buy_Req);
         _loc5_ = _loc4_.Data;
         _loc5_.writeUnsignedInt(param3);
         _loc5_.writeUnsignedInt(param2);
         SNetworkCore.Transceiver.PacketTransmit(_loc4_);
      }
      
      protected function PerformPacket_SC_Open_Ret(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = param1.Data;
         var _loc3_:int = int(_loc2_.readUnsignedInt());
         var _loc4_:Boolean = _loc3_ == 0 ? false : true;
         var _loc5_:int = int(_loc2_.readUnsignedInt());
         this.FProcessorWindowRecruit.SetTabShowOrHide(_loc4_);
      }
      
      protected function OnOpenArchive() : void
      {
         this.FProcessorWindowRecruitArchive.Visible = true;
         this.FProcessorWindowRecruit.Visible = false;
      }
      
      protected function OnOpenPerview() : void
      {
         this.FProcessorWindowRecruitPerview.Visible = true;
         this.FProcessorWindowRecruit.Visible = false;
      }
      
      protected function OnOpenLevelGifts() : void
      {
         this.FProcessorWindowRecruitLevelGifts.Visible = true;
         this.FProcessorWindowRecruitArchive.Visible = false;
      }
      
      protected function OnOpenMall() : void
      {
         this.FProcessorWindowRecruitMall.Visible = true;
         this.FProcessorWindowRecruitMall.Update();
      }
      
      protected function ProcessorWindowOnClose(param1:Object) : void
      {
         if(param1 is TProcessorWindowRecruit)
         {
            ProcessorClose();
         }
         else
         {
            this.FProcessorWindowRecruit.Visible = true;
         }
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount();
         if(!FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowRecruit.Load();
            this.FProcessorWindowRecruitArchive.Load();
            this.FProcessorWindowRecruitPerview.Load();
            this.FProcessorWindowRecruitLevelGifts.Load();
            this.FProcessorWindowRecruitMall.Load();
            return;
         }
         this.FProcessorWindowRecruit.Visible = true;
         this.PerformPacket_CS_Info_Req();
         this.PerformPacket_CS_WarOrder_Info_Req();
      }
   }
}

