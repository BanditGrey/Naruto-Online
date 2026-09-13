package Processors.Game.Lobby.WuXing
{
   import Components.Standard.TUITab;
   import Foundation.Common.THint;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TWuxingConfig;
   import Logics.Streamization.WuXing.TUnstreamizerWuxing;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import Rendering.Overlayers.WuXing.TOverlayerWuXing;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_WUXING;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   
   public class TProcessorWuxing extends TProcessorLobbyWindows
   {
      
      protected var FMC_Scene:MovieClip;
      
      protected var FUITab:TUITab;
      
      protected var FMC_Tab01:MovieClip;
      
      protected var FMC_Tab02:MovieClip;
      
      protected var FBTN_Close:SimpleButton;
      
      protected var FBtn_Help:SimpleButton;
      
      protected var FWuxingPractice:TProcessorWuxingPractice;
      
      protected var FWuxingActivation:TProcessorWuxingActivation;
      
      protected var FUnstreamizerWuxing:TUnstreamizerWuxing;
      
      protected var FOverlayerWuXing:TOverlayerWuXing;
      
      protected var FOtherOverlayerWuXing:TOverlayerWuXing;
      
      public var MC_WuxingPractice:MovieClip;
      
      public var MC_WuxingActivation:MovieClip;
      
      public function TProcessorWuxing(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FWuxingPractice = new TProcessorWuxingPractice(this);
         this.FWuxingPractice.OnLevelupClick = this.PerformPacket_CS_Elements_Levelup;
         this.FWuxingPractice.UIComponentsHintOnOver = this.UIComponentsHintOnOver1;
         this.FWuxingPractice.UIComponentsHintOnOut = this.UIComponentsHintOnOut1;
         this.FWuxingActivation = new TProcessorWuxingActivation(this);
         this.FWuxingActivation.OnAddPointClick = this.PerformPacket_CS_Elements_AddPoint;
         this.FWuxingActivation.OnActivateClick = this.PerformPacket_CS_Elements_Active;
         this.FUnstreamizerWuxing = new TUnstreamizerWuxing();
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_WUXING.RESOURCESID);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.FMC_Scene = TUtilityReflection.CreateDisplayObjectInstance(CONST_WUXING.RESOURCE_ClassName_MainPanel) as MovieClip;
         addChild(this.FMC_Scene);
         this.FMC_Tab01 = this.FMC_Scene[CONST_WUXING.RESOURCE_MC_Tab_0];
         this.FMC_Tab02 = this.FMC_Scene[CONST_WUXING.RESOURCE_MC_Tab_1];
         this.FUITab = new TUITab(this);
         this.FUITab.SetTabByIndex(this.FMC_Tab01,0);
         this.FUITab.SetTabByIndex(this.FMC_Tab02,1);
         this.FUITab.OnSwitch = this.TabOnSwitch;
         this.FUITab.Init();
         this.MC_WuxingPractice = this.FMC_Scene[CONST_WUXING.RESOURCE_MC_WuxingPractice];
         this.FWuxingPractice.Initiliation();
         this.FWuxingPractice.SynchronWuxingLevel = this.FWuxingActivation.SynchronWuxingLevel;
         this.FBTN_Close = this.FMC_Scene[CONST_WUXING.RESOURCE_Btn_Close];
         this.FBTN_Close.addEventListener(MouseEvent.CLICK,this.BtnCloseHandler,false,0,true);
         this.FBtn_Help = this.FMC_Scene[CONST_WUXING.RESOURCE_Btn_Help];
         this.FBtn_Help.addEventListener(MouseEvent.MOUSE_MOVE,this.ButtonHelpOnOver,false,0,true);
         this.FBtn_Help.addEventListener(MouseEvent.MOUSE_OUT,this.ButtonHelpOnOut,false,0,true);
         this.MC_WuxingActivation = this.FMC_Scene[CONST_WUXING.RESOURCE_MC_WuxingActivation];
         this.FWuxingActivation.Initiliation();
         this.FWuxingActivation.OnEffectText = FOnEffectText;
         this.FOverlayerWuXing = new TOverlayerWuXing(this);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerWuXing);
         this.FOtherOverlayerWuXing = new TOverlayerWuXing(this);
         this.FOtherOverlayerWuXing.IsNextLevel = true;
         TUtilityUIOverlayer.ResourcesDispatch(this.FOtherOverlayerWuXing);
         this.FMC_Scene.y = FUICore.StageHeight - this.FMC_Scene.height >> 1;
         this.FMC_Scene.x = FUICore.StageWidth - this.FMC_Scene.width >> 1;
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Elements_Info_Ret,this.PerformPacket_SC_Elements_Info);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Elements_LevelUp_Ret,this.PerformPacket_SC_Elements_Levelup);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Elements_AddPoint_Ret,this.PerformPacket_SC_Elements_AddPoint);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Elements_Active_Ret,this.PerformPacket_SC_Elements_Active);
      }
      
      protected function PerformPacket_SC_Elements_Info(param1:TPacket) : void
      {
         var _loc2_:ByteArray = param1.Data;
         this.FUnstreamizerWuxing.Unstreamize(_loc2_,null,null);
         this.FWuxingActivation.UpdateInterface(this.FUnstreamizerWuxing.WuXingData);
         this.FWuxingPractice.UpdateInterface(this.FUnstreamizerWuxing.WuXingExpData);
      }
      
      protected function PerformPacket_SC_Elements_Levelup(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:ByteArray = null;
         _loc3_ = param1.Data;
         _loc2_ = int(_loc3_.readUnsignedInt());
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         this.FUnstreamizerWuxing.UpdateElementExpByHeroId(_loc3_,null,null);
         this.FWuxingPractice.UpdateInterface(this.FUnstreamizerWuxing.WuXingExpData);
      }
      
      protected function PerformPacket_SC_Elements_AddPoint(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:ByteArray = null;
         _loc3_ = param1.Data;
         _loc2_ = int(_loc3_.readUnsignedInt());
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         this.FUnstreamizerWuxing.UpdateElementPointByHeroId(_loc3_,null,null);
         this.FWuxingActivation.UpdateInterface(this.FUnstreamizerWuxing.WuXingData);
      }
      
      protected function PerformPacket_SC_Elements_Active(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:ByteArray = null;
         _loc3_ = param1.Data;
         _loc2_ = int(_loc3_.readUnsignedInt());
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         this.FUnstreamizerWuxing.UpdateElementBitByHeroId(_loc3_,null,null);
         this.FWuxingActivation.UpdateInterface(this.FUnstreamizerWuxing.WuXingData);
      }
      
      protected function PerformPacket_CS_Elements_Active(param1:int, param2:int = 0) : void
      {
         var _loc3_:TPacket = null;
         _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Elements_Active_Req);
         _loc3_.Data.writeUnsignedInt(param1);
         _loc3_.Data.writeUnsignedInt(param2);
         SNetworkCore.Transceiver.PacketTransmit(_loc3_);
      }
      
      protected function PerformPacket_CS_Elements_AddPoint(param1:int, param2:int = 1) : void
      {
         var _loc3_:TPacket = null;
         _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Elements_AddPoint_Req);
         _loc3_.Data.writeUnsignedInt(param1);
         _loc3_.Data.writeUnsignedInt(param2);
         SNetworkCore.Transceiver.PacketTransmit(_loc3_);
      }
      
      protected function PerformPacket_CS_Elements_Levelup(param1:int, param2:int = 1) : void
      {
         var _loc3_:TPacket = null;
         _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Elements_LevelUp_Req);
         _loc3_.Data.writeUnsignedInt(param1);
         _loc3_.Data.writeUnsignedInt(param2);
         SNetworkCore.Transceiver.PacketTransmit(_loc3_);
      }
      
      protected function UpdateInterface() : void
      {
      }
      
      protected function TabOnSwitch(param1:int) : void
      {
         var _loc2_:int = param1;
         this.MC_WuxingActivation.visible = !(this.MC_WuxingPractice.visible = _loc2_ == 1);
      }
      
      protected function ButtonHelpOnOver(param1:MouseEvent) : void
      {
         var _loc2_:THint = new THint();
         if(UIHelpTipsHintOnOver != null)
         {
            _loc2_.Content = TUtilityString.GetText(70170117);
            UIHelpTipsHintOnOver(this,_loc2_);
         }
      }
      
      protected function ButtonHelpOnOut(param1:MouseEvent) : void
      {
         if(UIHelpTipsHintOnOut != null)
         {
            UIHelpTipsHintOnOut(this);
         }
      }
      
      protected function BtnCloseHandler(param1:MouseEvent) : void
      {
         ProcessorClose();
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount();
         if(!FIsResourcesLoadCompleted)
         {
            return;
         }
         this.PerformPacket_CS_Elements_Info();
         this.FUITab.TabIndex = 1;
         this.FUITab.SwithTagManual(0);
      }
      
      protected function PerformPacket_CS_Elements_Info() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Elements_Info_Req);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function UIComponentsHintOnOver1(param1:Object, param2:Object, param3:Object) : void
      {
         var _loc4_:TWuxingConfig = null;
         var _loc5_:TWuxingConfig = null;
         var _loc6_:TOverlayerWuXing = null;
         var _loc7_:TOverlayerWuXing = null;
         _loc4_ = param2 as TWuxingConfig;
         _loc5_ = param3 as TWuxingConfig;
         _loc6_ = this.FOverlayerWuXing;
         _loc7_ = this.FOtherOverlayerWuXing;
         if(_loc6_ != null)
         {
            _loc6_.Context = _loc4_;
            _loc6_.Render(FUICore.MouseCoordinate);
            _loc6_.Show();
         }
         if(_loc5_ == null)
         {
            return;
         }
         if(_loc7_ != null)
         {
            _loc7_.Context = _loc5_;
            _loc7_.Render(FUICore.MouseCoordinate);
            _loc7_.X = _loc6_.CoordinateOverlay.X + _loc6_.BoundsSubstrate.Width;
            _loc7_.Show();
         }
      }
      
      protected function UIComponentsHintOnOut1(param1:Object) : void
      {
         var _loc2_:TOverlayerWuXing = null;
         var _loc3_:TOverlayerWuXing = null;
         _loc2_ = this.FOverlayerWuXing;
         _loc3_ = this.FOtherOverlayerWuXing;
         if(_loc2_ != null)
         {
            _loc2_.Hide();
         }
         if(_loc3_ != null)
         {
            _loc3_.Hide();
         }
      }
   }
}

