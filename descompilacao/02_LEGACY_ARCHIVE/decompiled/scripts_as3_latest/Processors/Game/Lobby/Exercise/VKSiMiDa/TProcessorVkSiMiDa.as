package Processors.Game.Lobby.Exercise.VKSiMiDa
{
   import Externals.SExternalCore;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.Agent.SParametersCore;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import Processors.Game.Lobby.TongLing.ToolS.Tools_Help;
   import Resources.Constants.CONST_BASEACTIVITY;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_NETWORK;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.system.System;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   
   public class TProcessorVkSiMiDa extends TProcessorLobbyWindows
   {
      
      protected var MainPanel:Sprite;
      
      protected var FOneTip:MovieClip;
      
      protected var FTwoTip:MovieClip;
      
      protected var FTF_Http:TextField;
      
      protected var FMC_Copy:MovieClip;
      
      protected var FMC_Effect:MovieClip;
      
      protected var FBtn_TiaoZhaun:SimpleButton;
      
      protected var FMC_Colse:MovieClip;
      
      protected var FMC_CA1:MovieClip;
      
      protected var FMC_CA2:MovieClip;
      
      protected var FMC_Nimei:MovieClip;
      
      protected var FOpenThisPanelFunction:Function;
      
      public var VeryveryLiHai:int;
      
      public function TProcessorVkSiMiDa(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_BASEACTIVITY.VK_SIMIDA);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         this.MainPanel = TUtilityReflection.CreateDisplayObjectInstance("MC_VkSiMiDa") as Sprite;
         addChild(this.MainPanel);
         this.MainPanel.x = (FUICore.StageWidth - this.MainPanel.width) / 2;
         this.MainPanel.y = (FUICore.StageHeight - this.MainPanel.height) / 2;
         this.FOneTip = this.MainPanel["MC_0"]["MC_Tip"];
         this.FTwoTip = this.MainPanel["MC_1"]["MC_Tip"];
         this.FTF_Http = this.MainPanel["MC_Area"]["TF_Http"];
         this.FMC_Copy = this.MainPanel["MC_Area"]["MC_Copy"];
         this.FBtn_TiaoZhaun = this.MainPanel["MC_Area"]["Btn_TiaoZhaun"];
         this.FMC_Effect = this.MainPanel["MC_Area"]["MC_Effect"];
         this.FMC_Colse = this.MainPanel["MC_Colse"];
         this.FMC_CA1 = this.MainPanel["MC_CA1"];
         this.FMC_CA1.mouseEnabled = false;
         this.FMC_CA2 = this.MainPanel["MC_CA2"];
         this.FMC_CA2.mouseEnabled = false;
         this.FMC_Nimei = this.MainPanel["MC_Nimei"];
         this.FMC_Nimei.mouseEnabled = false;
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            _loc2_ = this.MainPanel["MC_" + _loc1_];
            MovieClip(_loc2_["MC_cao"]).gotoAndStop(_loc1_ + 1);
            MovieClip(_loc2_["MC_Tip"]).gotoAndStop(_loc1_ + 1);
            MovieClip(_loc2_["MC_BAGROUD"]).gotoAndStop(_loc1_ + 1);
            _loc1_++;
         }
         TGameUtil.setButtonMode(this.FMC_Copy,true);
         this.FMC_Effect.mouseEnabled = false;
         this.FMC_Effect.mouseChildren = false;
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         var _loc1_:Vector.<Object> = null;
         super.ResourcesPerform_UILocations();
         this.FMC_Copy.addEventListener(MouseEvent.CLICK,this.CopyClick);
         this.FBtn_TiaoZhaun.addEventListener(MouseEvent.CLICK,this.TiaoZhaunFireBtn);
         this.FMC_Colse.addEventListener(MouseEvent.CLICK,this.CloseClick);
         new Tools_Help(this,this.FOneTip,70100097,FUICore);
         new Tools_Help(this,this.FTwoTip,70100098,FUICore);
         var _loc2_:TConfigValue = null;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,60380011) as TConfigValue;
         _loc1_ = _loc2_.Value as Vector.<Object>;
         if(!_loc1_)
         {
            return;
         }
         this.FTF_Http.text = String(_loc1_[0]);
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_S2C_VK_1,this.PACKETID_S2C_VK_1);
      }
      
      public function set OpenThisPanelFunction(param1:Function) : void
      {
         this.FOpenThisPanelFunction = param1;
      }
      
      protected function PACKETID_S2C_VK_1(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:ByteArray = null;
         _loc3_ = param1.Data;
         _loc2_ = int(_loc3_.readUnsignedInt());
         if(_loc2_ != 0)
         {
            return;
         }
         if(SParametersCore.Isvk == 0)
         {
            return;
         }
         if(this.FOpenThisPanelFunction != null)
         {
            this.FOpenThisPanelFunction();
         }
      }
      
      public function C2S() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_C2S_VK_1);
         _loc1_.Data.writeUnsignedInt(1);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      public function CopyClick(param1:MouseEvent) : void
      {
         System.setClipboard(this.FTF_Http.text);
      }
      
      public function TiaoZhaunFireBtn(param1:MouseEvent) : void
      {
         var _loc2_:TPacket = null;
         SExternalCore.VkCallJs(20152);
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_C2S_VK_1);
         _loc2_.Data.writeUnsignedInt(2);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
         SExternalCore.NavigateToUrl(this.FTF_Http.text);
      }
      
      public function CloseClick(param1:MouseEvent) : void
      {
         if(FOnClose != null)
         {
            FOnClose(this);
         }
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount();
         SExternalCore.VkCallJs(20151);
      }
      
      override public function Unmount() : void
      {
         super.Unmount();
      }
   }
}

