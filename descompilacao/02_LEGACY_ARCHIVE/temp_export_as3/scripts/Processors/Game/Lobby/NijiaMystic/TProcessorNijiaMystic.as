package Processors.Game.Lobby.NijiaMystic
{
   import Foundation.Common.TBounds;
   import Foundation.Common.THint;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.DatebaseVO.VO.TNijiaMystic;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.NijiaMystic.TNijiaMysticData;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import Rendering.Overlayers.HelpTips.TOverlayerHelpTips;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_NIJIAMYSTIC;
   import Resources.Constants.CONST_SHORTCUTS;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   
   public class TProcessorNijiaMystic extends TProcessorLobbyWindows
   {
      
      protected static const SIZE_NarutoNijiaMystic_Width:int = 712;
      
      protected static const SIZE_NarutoNijiaMystic_Height:int = 524;
      
      protected static const SIZE_WindowNijiaMysticCollect_Width:uint = 712;
      
      protected static const SIZE_WindowNijiaMysticCollect_Height:uint = 524;
      
      protected var FNijiaMysticData:TNijiaMysticData;
      
      protected var FProcessorWindowNijiaMystic:TProcessorWindowNijiaMystic;
      
      protected var FProcessorWindowNijiaMysticCollect:TProcessorWindowNijiaMysticCollect;
      
      protected var FHelpTips:THint;
      
      protected var FMysticUpgradeHelpDesc:String;
      
      protected var FMysticCollectHelpDesc:String;
      
      protected var FBoundsNijiaMystic:TBounds;
      
      protected var FBoundsNijiaMysticCollect:TBounds;
      
      public function TProcessorNijiaMystic(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FNijiaMysticData = SLogicsCore.NijiaMysticData;
         this.FProcessorWindowNijiaMystic = new TProcessorWindowNijiaMystic(this);
         this.FProcessorWindowNijiaMystic.GotoCollect = this.OnGotoCollect;
         this.FProcessorWindowNijiaMysticCollect = new TProcessorWindowNijiaMysticCollect(this);
         this.FProcessorWindowNijiaMysticCollect.GotoUpgrage = this.OnGotoUpgrage;
         this.FBoundsNijiaMystic = new TBounds();
         this.FBoundsNijiaMystic.Width = SIZE_NarutoNijiaMystic_Width;
         this.FBoundsNijiaMystic.Height = SIZE_NarutoNijiaMystic_Height;
         ComponentBoundsCenter(this.FProcessorWindowNijiaMystic,this.FBoundsNijiaMystic);
         this.FBoundsNijiaMysticCollect = new TBounds();
         this.FBoundsNijiaMysticCollect.Width = SIZE_WindowNijiaMysticCollect_Width;
         this.FBoundsNijiaMysticCollect.Height = SIZE_WindowNijiaMysticCollect_Height;
         ComponentBoundsCenter(this.FProcessorWindowNijiaMysticCollect,this.FBoundsNijiaMysticCollect);
         this.FProcessorWindowNijiaMysticCollect.EffectGenerateText = EffectGenerateText;
         FOverlayerHelpTips = new TOverlayerHelpTips(this);
         FOverlayerHelpTips.visible = false;
         this.FHelpTips = new THint();
         SetUIModuleID(CONST_MODULES.MODULE_NinjaHostel);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_NIJIAMYSTIC.RESOURCE_NijiaMystic);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:MovieClip = null;
         _loc1_ = TUtilityReflection.CreateDisplayObjectInstance(CONST_NIJIAMYSTIC.RESOURCE_ClassName_NijiaMystic_Upgrade) as MovieClip;
         this.FProcessorWindowNijiaMystic.SetScene(_loc1_);
         _loc1_[CONST_NIJIAMYSTIC.RESOURCE_BTN_Close].addEventListener(MouseEvent.CLICK,this.OnWindowClose);
         _loc1_[CONST_NIJIAMYSTIC.RESOURCE_BTN_Help].addEventListener(MouseEvent.MOUSE_OVER,this.ButtonHelpOnOver);
         _loc1_[CONST_NIJIAMYSTIC.RESOURCE_BTN_Help].addEventListener(MouseEvent.MOUSE_OUT,this.ButtonHelpOnOut);
         _loc1_ = TUtilityReflection.CreateDisplayObjectInstance(CONST_NIJIAMYSTIC.RESOURCE_ClassName_NijiaMystic_Make) as MovieClip;
         this.FProcessorWindowNijiaMysticCollect.SetScene(_loc1_);
         _loc1_[CONST_NIJIAMYSTIC.RESOURCE_BTN_Close].addEventListener(MouseEvent.CLICK,this.OnWindowClose);
         _loc1_[CONST_NIJIAMYSTIC.RESOURCE_BTN_Help].addEventListener(MouseEvent.MOUSE_OVER,this.ButtonHelpOnOver);
         _loc1_[CONST_NIJIAMYSTIC.RESOURCE_BTN_Help].addEventListener(MouseEvent.MOUSE_OUT,this.ButtonHelpOnOut);
         this.FProcessorWindowNijiaMystic.Visible = true;
         this.FProcessorWindowNijiaMysticCollect.Visible = false;
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         var _loc1_:TSystemLanguage = null;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.HELPTIPS_Mystic_Upgrade) as TSystemLanguage;
         this.FMysticUpgradeHelpDesc = _loc1_.Desc;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.HELPTIPS_Mystic_Collect) as TSystemLanguage;
         this.FMysticCollectHelpDesc = _loc1_.Desc;
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerHelpTips);
         super.ResourcesPerform_UILocations();
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         if(!FIsResourcesLoadCompleted)
         {
            return;
         }
         this.FProcessorWindowNijiaMystic.Update();
         this.FProcessorWindowNijiaMysticCollect.Update();
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         super.PacketRegisterRoutines();
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_NijiaMystic_InitRet,this.PerformPacket_SC_InitRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_NijiaMystic_EffectRecordRet,this.PerformPacket_SC_EffectRecordRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_NijiaMystic_UpgradeRet,this.PerformPacket_SC_UpgradeRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_NijiaMystic_InstallRet,this.PerformPacket_SC_InstallRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_NijiaMystic_CollectRecordRet,this.PerformPacket_SC_CollectRecordRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_NijiaMystic_MakeRet,this.PerformPacket_SC_MakeRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_NijiaMystic_CollectResetRet,this.PerformPacket_SC_CollectResetRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_NijiaMystic_CollectRet,this.PerformPacket_SC_CollectTask);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_NijiaMystic_FlushNotify,this.PerformPacket_SC_FlushNotify);
      }
      
      protected function PerformPacket_SC_InitRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         _loc2_ = param1.Data;
         _loc4_ = uint(_loc2_.readShort());
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            this.FNijiaMysticData.MysticPointVect[_loc3_] = _loc2_.readUnsignedInt();
            _loc3_++;
         }
         _loc4_ = uint(_loc2_.readShort());
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            this.FNijiaMysticData.MysticIdVect[_loc3_] = _loc2_.readUnsignedInt();
            _loc3_++;
         }
         this.FNijiaMysticData.CurSelectMystic = _loc2_.readUnsignedInt();
         _loc4_ = uint(_loc2_.readShort());
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            this.FNijiaMysticData.RefreshMaterialVect[_loc3_] = _loc2_.readUnsignedInt();
            _loc3_++;
         }
         this.FNijiaMysticData.FlushTimes = _loc2_.readUnsignedInt();
         this.FNijiaMysticData.CollectTimes = _loc2_.readUnsignedInt();
         if(FIsResourcesLoadCompleted)
         {
            this.UpdataUI();
         }
      }
      
      protected function PerformPacket_SC_EffectRecordRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         _loc2_ = param1.Data;
         _loc4_ = uint(_loc2_.readShort());
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            this.FNijiaMysticData.MysticPointVect[_loc3_] = _loc2_.readUnsignedInt();
            _loc3_++;
         }
         _loc4_ = uint(_loc2_.readShort());
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            this.FNijiaMysticData.MysticIdVect[_loc3_] = _loc2_.readUnsignedInt();
            _loc3_++;
         }
         this.FNijiaMysticData.CurSelectMystic = _loc2_.readUnsignedInt();
         if(FIsResourcesLoadCompleted)
         {
            this.UpdataUI();
         }
      }
      
      protected function PerformPacket_SC_CollectRecordRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         _loc2_ = param1.Data;
         _loc4_ = uint(_loc2_.readShort());
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            this.FNijiaMysticData.RefreshMaterialVect[_loc3_] = _loc2_.readUnsignedInt();
            _loc3_++;
         }
         this.FNijiaMysticData.FlushTimes = _loc2_.readUnsignedInt();
         this.FNijiaMysticData.CollectTimes = _loc2_.readUnsignedInt();
         if(FIsResourcesLoadCompleted)
         {
            this.UpdataUI();
         }
         ProcessorOnCheckIconStatus(CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_NijiaMystic,this.FNijiaMysticData.CheckStatus());
      }
      
      protected function PerformPacket_SC_UpgradeRet(param1:TPacket) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:ByteArray = null;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:TNijiaMystic = null;
         var _loc7_:TNijiaMystic = null;
         var _loc8_:uint = 0;
         _loc3_ = param1.Data;
         _loc2_ = _loc3_.readUnsignedInt();
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         _loc4_ = _loc3_.readUnsignedInt();
         _loc8_ = uint(_loc3_.readShort());
         _loc5_ = 0;
         while(_loc5_ < _loc8_)
         {
            this.FNijiaMysticData.MysticPointVect[_loc5_] = _loc3_.readUnsignedInt();
            _loc5_++;
         }
         _loc6_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_NijiaMystic,_loc4_) as TNijiaMystic;
         _loc5_ = uint(_loc6_.OccultEffectKey);
         _loc7_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_NijiaMystic,this.FNijiaMysticData.CurSelectMystic) as TNijiaMystic;
         this.FNijiaMysticData.MysticIdVect[_loc5_] = _loc4_;
         if(_loc6_ != null && _loc7_ != null && _loc6_.OccultEffectKey == _loc7_.OccultEffectKey)
         {
            this.FNijiaMysticData.CurSelectMystic = _loc4_;
         }
         this.UpdataUI();
      }
      
      protected function PerformPacket_SC_InstallRet(param1:TPacket) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:ByteArray = null;
         _loc3_ = param1.Data;
         _loc2_ = _loc3_.readUnsignedInt();
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         this.FNijiaMysticData.CurSelectMystic = _loc3_.readUnsignedInt();
         this.UpdataUI();
      }
      
      protected function PerformPacket_SC_MakeRet(param1:TPacket) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:ByteArray = null;
         var _loc6_:uint = 0;
         _loc5_ = param1.Data;
         this.FProcessorWindowNijiaMysticCollect.SetButtonStatus(true);
         _loc4_ = _loc5_.readUnsignedInt();
         if(_loc4_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc4_);
            return;
         }
         _loc6_ = _loc5_.readUnsignedInt();
         _loc3_ = uint(_loc5_.readShort());
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            this.FNijiaMysticData.RefreshMaterialVect[_loc2_] = _loc5_.readUnsignedInt();
            _loc2_++;
         }
         this.FNijiaMysticData.BoomVect.length = 0;
         _loc3_ = uint(_loc5_.readShort());
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            this.FNijiaMysticData.BoomVect.push(_loc5_.readUnsignedInt());
            _loc2_++;
         }
         this.UpdataUI();
         this.FProcessorWindowNijiaMysticCollect.ShowBoom();
      }
      
      protected function PerformPacket_SC_CollectResetRet(param1:TPacket) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:ByteArray = null;
         this.FProcessorWindowNijiaMysticCollect.SetButtonVisible(true);
         _loc5_ = param1.Data;
         _loc4_ = _loc5_.readUnsignedInt();
         if(_loc4_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc4_);
            return;
         }
         ++this.FNijiaMysticData.FlushTimes;
         _loc3_ = uint(_loc5_.readShort());
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            this.FNijiaMysticData.RefreshMaterialVect[_loc2_] = _loc5_.readUnsignedInt();
            _loc2_++;
         }
         this.UpdataUI();
         ProcessorOnCheckIconStatus(CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_NijiaMystic,this.FNijiaMysticData.CheckStatus());
      }
      
      protected function PerformPacket_SC_CollectTask(param1:TPacket) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:ByteArray = null;
         this.FProcessorWindowNijiaMysticCollect.SetButtonVisible(true);
         _loc5_ = param1.Data;
         _loc4_ = _loc5_.readUnsignedInt();
         if(_loc4_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc4_);
            return;
         }
         _loc3_ = uint(_loc5_.readShort());
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            this.FNijiaMysticData.MysticPointVect[_loc2_] = _loc5_.readUnsignedInt();
            _loc2_++;
         }
         _loc3_ = this.FNijiaMysticData.RefreshMaterialVect.length;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            this.FNijiaMysticData.RefreshMaterialVect[_loc2_] = 0;
            _loc2_++;
         }
         this.UpdataUI();
      }
      
      protected function PerformPacket_SC_FlushNotify(param1:TPacket) : void
      {
         if(!FIsResourcesLoadCompleted)
         {
            return;
         }
         param1 = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_NijiaMystic_CollectRecordReq);
         SNetworkCore.Transceiver.PacketTransmit(param1);
      }
      
      protected function UpdataUI() : void
      {
         this.FProcessorWindowNijiaMystic.UpdataUI();
         this.FProcessorWindowNijiaMysticCollect.UpdataUI();
      }
      
      protected function OnGotoCollect(param1:Object) : void
      {
         this.FProcessorWindowNijiaMystic.Visible = false;
         this.FProcessorWindowNijiaMysticCollect.Visible = true;
      }
      
      protected function OnGotoUpgrage(param1:Object) : void
      {
         this.FProcessorWindowNijiaMystic.Visible = true;
         this.FProcessorWindowNijiaMysticCollect.Visible = false;
      }
      
      protected function OnWindowClose(param1:MouseEvent) : void
      {
         ProcessorClose();
      }
      
      protected function ButtonHelpOnOver(param1:MouseEvent) : void
      {
         if(this.FProcessorWindowNijiaMystic.Visible)
         {
            this.FHelpTips.Content = this.FMysticUpgradeHelpDesc;
         }
         else if(this.FProcessorWindowNijiaMysticCollect.Visible)
         {
            this.FHelpTips.Content = this.FMysticCollectHelpDesc;
         }
         UIHelpTipsHintOnOver(this,this.FHelpTips);
      }
      
      protected function ButtonHelpOnOut(param1:MouseEvent) : void
      {
         UIHelpTipsHintOnOut(this);
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount(param1);
         if(!FIsResourcesLoadCompleted)
         {
            return;
         }
         this.UpdataUI();
      }
      
      override public function Unmount() : void
      {
         super.Unmount();
      }
   }
}

