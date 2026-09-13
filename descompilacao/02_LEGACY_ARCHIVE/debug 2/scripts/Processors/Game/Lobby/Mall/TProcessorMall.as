package Processors.Game.Lobby.Mall
{
   import Foundation.Common.TBounds;
   import Foundation.Common.THint;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Logics.Characters.TCharacter;
   import Logics.DatebaseVO.VO.TMall;
   import Logics.Inventories.TInventorySample;
   import Logics.Inventories.TInventorySamples;
   import Logics.SLogicsCore;
   import Logics.Streamization.Inventories.TUnstreamizerInventorySamples;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import Rendering.Overlayers.HelpTips.TOverlayerHelpTips;
   import Rendering.Overlayers.Inventories.TOverlayerAccessory;
   import Rendering.Overlayers.Inventories.TOverlayerAppliance;
   import Rendering.Overlayers.Inventories.TOverlayerEquipment;
   import Rendering.Overlayers.Inventories.TOverlayerTreasure;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MALL;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.utils.ByteArray;
   
   public class TProcessorMall extends TProcessorLobbyWindows
   {
      
      public static const SIZE_WindowMall_Width:uint = 922;
      
      public static const SIZE_WindowMall_Height:uint = 436;
      
      public static const SIZE_WindowPopupBox_Width:uint = 330;
      
      public static const SIZE_WindowPopupBox_Height:uint = 274;
      
      protected var FCharacter:TCharacter;
      
      protected var FUnstreamizerInventorySamples:TUnstreamizerInventorySamples;
      
      protected var FInventorySamples:TInventorySamples;
      
      protected var FProcessorWindowMall:TProcessorWindowMall;
      
      protected var FMallBounds:TBounds;
      
      protected var FPopupBoxBounds:TBounds;
      
      protected var FTabIndex:uint;
      
      protected var FOnMallBuy:Function;
      
      protected var FOnSignIntegral:Function;
      
      protected var FOnOpenVIP:Function;
      
      protected var FOnItemOnClick:Function;
      
      protected var FOnBuyResult:Function;
      
      public function TProcessorMall(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FCharacter = SLogicsCore.Character;
         this.FInventorySamples = new TInventorySamples();
         this.FUnstreamizerInventorySamples = new TUnstreamizerInventorySamples();
         this.FProcessorWindowMall = new TProcessorWindowMall(this);
         this.FProcessorWindowMall.SlotOnOver = UIComponentsHintOnOver;
         this.FProcessorWindowMall.SlotOnOut = UIComponentsHintOnOut;
         this.FProcessorWindowMall.OnClose = this.ProcessorWindowOnClose;
         this.FProcessorWindowMall.ItemOnClick = this.ProcessorItemOnClick;
         this.FProcessorWindowMall.HelpHintOnOver = this.UIHelpHintOnOver;
         this.FProcessorWindowMall.HelpHintOnOut = this.UIHelpHintOnOut;
         this.FMallBounds = new TBounds();
         this.FMallBounds.X = this.FProcessorWindowMall.x;
         this.FMallBounds.Y = this.FProcessorWindowMall.y;
         this.FMallBounds.Width = SIZE_WindowMall_Width;
         this.FMallBounds.Height = SIZE_WindowMall_Height;
         ComponentBoundsCenter(this.FProcessorWindowMall,this.FMallBounds);
         FOverlayerEquipment = new TOverlayerEquipment(this,CONST_MODULES.MODULE_OldMall);
         FOverlayerEquipment.Visible = false;
         FOverlayerTreasure = new TOverlayerTreasure(this,CONST_MODULES.MODULE_OldMall);
         FOverlayerTreasure.Visible = false;
         FOverlayerAppliance = new TOverlayerAppliance(this,CONST_MODULES.MODULE_OldMall);
         FOverlayerAppliance.Visible = false;
         FOverlayerHelpTips = new TOverlayerHelpTips(this);
         FOverlayerHelpTips.Visible = false;
         FOverlayerAccessory = new TOverlayerAccessory(this,CONST_MODULES.MODULE_OldMall);
         FOverlayerAccessory.Visible = false;
         SetUIModuleID(CONST_MODULES.MODULE_OldMall);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_MALL.RESOURCESID_SWF_MALL);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerEquipment);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerTreasure);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerAppliance);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerHelpTips);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerAccessory);
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Mall_Buy,this.PacketPerform_SC_MallBuy);
      }
      
      protected function PacketPerform_SC_MallBuy(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:TMall = null;
         _loc2_ = param1.Data;
         _loc3_ = int(_loc2_.readUnsignedInt());
         if(this.FOnMallBuy != null)
         {
            this.FOnMallBuy(_loc3_);
         }
         this.FOnBuyResult(this,_loc3_);
         _loc4_ = _loc2_.readUnsignedInt();
         _loc5_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Mall,_loc4_) as TMall;
         if(_loc5_ == null)
         {
            return;
         }
         switch(_loc5_.Model)
         {
            case 1:
               if(this.FOnSignIntegral != null)
               {
                  this.FOnSignIntegral(this);
               }
            case 2:
               if(this.FProcessorWindowMall.Visible)
               {
                  this.FProcessorWindowMall.UpdateMoney();
               }
         }
      }
      
      protected function ProcessorOnOpenVIP(param1:Object) : void
      {
         if(this.FOnOpenVIP != null)
         {
            this.FOnOpenVIP(this);
         }
      }
      
      protected function PacketPerform_CS_MallBuy(param1:uint, param2:uint) : void
      {
         var _loc3_:ByteArray = null;
         var _loc4_:TPacket = null;
         _loc4_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_NewMall_BuyGoods);
         _loc3_ = _loc4_.Data;
         _loc3_.writeUnsignedInt(param1);
         _loc3_.writeUnsignedInt(param2);
         SNetworkCore.Transceiver.PacketTransmit(_loc4_);
      }
      
      protected function ProcessorWindowOnClose(param1:Object) : void
      {
         ProcessorClose();
      }
      
      protected function ProcessorItemOnClick(param1:Object, param2:Object) : void
      {
         var _loc3_:TInventorySample = null;
         _loc3_ = param2 as TInventorySample;
         if(this.FOnItemOnClick != null)
         {
            this.FOnItemOnClick(this,param2);
         }
      }
      
      protected function UIHelpHintOnOver(param1:Object, param2:THint) : void
      {
         FOverlayerHelpTips.Context = param2;
         FOverlayerHelpTips.Render(FUICore.MouseCoordinate);
         FOverlayerHelpTips.Show();
      }
      
      protected function UIHelpHintOnOut(param1:Object) : void
      {
         FOverlayerHelpTips.Hide();
      }
      
      protected function ProcessorStreamData(param1:ByteArray) : void
      {
         if(param1 != null && param1.length > 0)
         {
            this.FTabIndex = param1.readUnsignedInt();
         }
      }
      
      public function get OnSigIntegraln() : Function
      {
         return this.FOnSignIntegral;
      }
      
      public function set OnSignIntegral(param1:Function) : void
      {
         this.FOnSignIntegral = param1;
      }
      
      public function get OnOpenVIP() : Function
      {
         return this.FOnOpenVIP;
      }
      
      public function set OnOpenVIP(param1:Function) : void
      {
         this.FOnOpenVIP = param1;
      }
      
      public function get OnItemOnClick() : Function
      {
         return this.FOnItemOnClick;
      }
      
      public function set OnItemOnClick(param1:Function) : void
      {
         this.FOnItemOnClick = param1;
      }
      
      public function get OnBuyResult() : Function
      {
         return this.FOnBuyResult;
      }
      
      public function set OnBuyResult(param1:Function) : void
      {
         this.FOnBuyResult = param1;
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount();
         this.ProcessorStreamData(param1);
         if(!FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowMall.Load();
            return;
         }
         this.FProcessorWindowMall.Visible = true;
         this.FProcessorWindowMall.SetTabIndex(this.FTabIndex);
         this.FProcessorWindowMall.PlayEffect();
         if(this.FInventorySamples.Count > 0)
         {
            this.FProcessorWindowMall.InitData(this.FInventorySamples);
         }
      }
      
      override public function Unmount() : void
      {
         super.Unmount();
         this.FTabIndex = 0;
      }
      
      public function InitMallInfo() : void
      {
         this.FUnstreamizerInventorySamples.UnstreamizeInventorySamplesByDatabase(null,this.FInventorySamples,null);
         if(this.FProcessorWindowMall.visible)
         {
            this.FProcessorWindowMall.InitData(this.FInventorySamples);
         }
      }
      
      public function ProcessorMallOnBuy(param1:uint, param2:Object, param3:Function = null) : void
      {
         var _loc4_:TInventorySample = null;
         this.FOnMallBuy = param3;
         _loc4_ = param2 as TInventorySample;
         this.PacketPerform_CS_MallBuy(_loc4_.Indentifier,param1);
      }
   }
}

