package Processors.Game.Lobby.NinjaRelationship
{
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityString;
   import Logics.NinjaRelation.TNinjaGroupBuff;
   import Logics.NinjaRelation.TNinjaRelationData;
   import Logics.SLogicsCore;
   import Logics.Streamization.NinjaRelation.TUnstreamizerNinjaRelation;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import Processors.Game.Lobby.NinjaRelationship.Component.TProcessorNewExchangeFream;
   import Rendering.Overlayers.HelpTips.TOverlayerHelpTips;
   import Rendering.Overlayers.Hints.TOverlayerHint;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_NinjaRelationship;
   import Resources.Strings.STRING_NINJARELATION;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.utils.ByteArray;
   
   public class TProcessorNinjaRelationship extends TProcessorLobbyWindows
   {
      
      protected var FProcessorWindowRelationship:TProcessorWindowRelationship;
      
      protected var FProcessorNewExchangeFream:TProcessorNewExchangeFream;
      
      protected var FUnstreamizerNinjaRelation:TUnstreamizerNinjaRelation;
      
      protected var FNinjaRelationData:TNinjaRelationData;
      
      protected var FAddExpCount:uint;
      
      protected var FOnClickTabFun:Function;
      
      public function TProcessorNinjaRelationship(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FProcessorWindowRelationship = new TProcessorWindowRelationship(this);
         this.FProcessorWindowRelationship.OnClose = this.ProcessorWindowOnClose;
         this.FProcessorWindowRelationship.AddExpOnClick = this.ProcessorAddExpOnClick;
         this.FProcessorWindowRelationship.HintOnOver = ProcessorTipOnOver;
         this.FProcessorWindowRelationship.HintOnOut = ProcessorTipOnOut;
         this.FProcessorWindowRelationship.OnHelpTipsOver = UIHelpTipsHintOnOver;
         this.FProcessorWindowRelationship.OnHelpTipsOut = UIHelpTipsHintOnOut;
         this.FProcessorWindowRelationship.ToShowExchange = this.ToShowExchange;
         this.FProcessorNewExchangeFream = new TProcessorNewExchangeFream(param1);
         this.FProcessorNewExchangeFream.BackFun = this.ExchangeBackFun;
         this.FUnstreamizerNinjaRelation = new TUnstreamizerNinjaRelation();
         FOverlayerHint = new TOverlayerHint(this);
         FOverlayerHint.visible = false;
         FOverlayerHelpTips = new TOverlayerHelpTips(this);
         FOverlayerHelpTips.visible = false;
         this.FNinjaRelationData = SLogicsCore.NinjaRelationData;
         SetUIModuleID(CONST_MODULES.MODULE_NinjaRelation);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_NinjaRelationship.RESOURCE_NINJARELATIONSHIP);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerHint);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerHelpTips);
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_NinjaRelation_Get_Hero_Ret,this.PacketPerform_SC_Get_Hero_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_NinjaRelation_Add_Exp_Ret,this.PacketPerform_SC_Add_Exp_Ret);
         super.PacketRegisterRoutines();
      }
      
      override protected function ResourcesPerform_UIFinalize() : void
      {
         this.FUnstreamizerNinjaRelation.UnstreamizeNinjaTeamBuffsByDatabase(null,this.FNinjaRelationData.NinjaTeamBuffs,null);
         super.ResourcesPerform_UIFinalize();
      }
      
      protected function PacketPerform_SC_Get_Hero_Ret(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = param1.Data;
         this.FUnstreamizerNinjaRelation.UnstreamizeNinjaGroupBuffsByDatabase(_loc2_,this.FNinjaRelationData.NinjaGroupBuffs,null);
         this.FProcessorWindowRelationship.Update();
         this.FProcessorWindowRelationship.Visible = true;
         this.Visible = true;
      }
      
      protected function PacketPerform_SC_Add_Exp_Ret(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         this.FUnstreamizerNinjaRelation.UnstreamizeUpdateNinjaGroupBuff(_loc2_,this.FNinjaRelationData.NinjaGroupBuffs,null);
         EffectGenerateText(TUtilityString.Format(STRING_NINJARELATION.FORMAT_GetExpricence,this.FAddExpCount));
         if(FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowRelationship.UpdateUIDetail();
         }
      }
      
      protected function PacketPerform_CS_Get_Hero_Req() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_NinjaRelation_Get_Hero_Req);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function ProcessorWindowOnClose(param1:Object) : void
      {
         ProcessorClose();
      }
      
      protected function ProcessorAddExpOnClick(param1:Object, param2:Object, param3:uint, param4:uint, param5:uint) : void
      {
         var _loc6_:TPacket = null;
         var _loc7_:ByteArray = null;
         var _loc8_:TNinjaGroupBuff = null;
         _loc8_ = param2 as TNinjaGroupBuff;
         _loc6_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_NinjaRelation_Add_Exp_Req);
         _loc7_ = _loc6_.Data;
         _loc7_.writeUnsignedInt(_loc8_.TeamID);
         _loc7_.writeUnsignedInt(param3);
         _loc7_.writeUnsignedInt(param4);
         this.FAddExpCount = param5;
         SNetworkCore.Transceiver.PacketTransmit(_loc6_);
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount(param1);
         if(!FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowRelationship.Load();
            this.FProcessorNewExchangeFream.Load();
            return;
         }
         this.PacketPerform_CS_Get_Hero_Req();
         if(this.FOnClickTabFun != null)
         {
            this.FOnClickTabFun();
            this.FOnClickTabFun = null;
         }
      }
      
      protected function ExchangeBackFun(param1:int, param2:uint, param3:uint) : void
      {
         this.FProcessorWindowRelationship.ExchangeBackFun(param1,param2,param3);
      }
      
      protected function ToShowExchange(param1:int, param2:Vector.<uint>, param3:TNinjaGroupBuff) : void
      {
         this.FProcessorNewExchangeFream.visible = true;
         this.FProcessorNewExchangeFream.StartShow(param1,param2,param3);
      }
      
      public function TabChangeByIndex(param1:int) : void
      {
         this.FProcessorWindowRelationship.TabChangeByIndex(param1);
      }
      
      public function set OnClickTabFun(param1:Function) : void
      {
         this.FOnClickTabFun = param1;
      }
   }
}

