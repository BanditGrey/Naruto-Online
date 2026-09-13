package Processors.Game.Lobby.BigDipper
{
   import Foundation.Common.*;
   import Foundation.Network.*;
   import Foundation.Resources.*;
   import Foundation.Resources.Bins.TBins;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.BigDipper.*;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.GeneralStar.TEsotericPoint;
   import Logics.SLogicsCore;
   import Logics.Streamization.BigDipper.*;
   import Processors.Game.Lobby.Common.*;
   import Rendering.Overlayers.BigDipper.*;
   import Rendering.Overlayers.HelpTips.TOverlayerHelpTips;
   import Rendering.Overlayers.Hints.TOverlayerHint;
   import Resources.Constants.*;
   import Resources.Strings.STRING_BIGDIPPER;
   import Utilities.UI.Overlayers.*;
   import flash.utils.ByteArray;
   
   public class TProcessorBigDipper extends TProcessorLobbyWindows
   {
      
      protected static const SIZE_WIDTH_BigDipper:int = 754;
      
      protected static const SIZE_HEIGHT_BigDipper:int = 496;
      
      protected static const UPGRADE_REQ_ONE_TIME:int = 1;
      
      protected static const UPGRADE_REQ_FIFTY_TIME:int = 50;
      
      protected var FOverlayerBigDipper:TOverlayerBigDipper;
      
      protected var FProcessorWindowBigDipper:TProcessorWindowBigDipper;
      
      protected var FBoundsBigDipper:TBounds;
      
      protected var FStarsInfor:TStarsInfor;
      
      protected var FStarUpgradeInfor:TStarUpgradeInfor;
      
      protected var FUnstreamizerStarsInfor:TUnstreamizerStarsInfor;
      
      protected var FUnstreamizerUpgradeInfor:TUnstreamizerUpgradeInfor;
      
      protected var FFreeTimeOneDay:int;
      
      protected var FCurrentUpgradeType:int;
      
      protected var FOnUserTotalFightingPowerReq:Function;
      
      public function TProcessorBigDipper(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FProcessorWindowBigDipper = new TProcessorWindowBigDipper(this);
         this.FProcessorWindowBigDipper.OnEffectText = ProcessorsOnEffectText;
         this.FProcessorWindowBigDipper.OnOneTimeUpgrade = this.UpgradeOneTime;
         this.FProcessorWindowBigDipper.OnAnyTimeUpgrade = this.UpgradeAnyTime;
         this.FProcessorWindowBigDipper.OnMouseMove = this.UIComponentsHintOnOver1;
         this.FProcessorWindowBigDipper.OnMouseOut = this.UIComponentsHintOnOut1;
         this.FProcessorWindowBigDipper.HintOnOver = this.UIComponentsBtnOnOver;
         this.FProcessorWindowBigDipper.HintOnOut = this.UIComponentsBtnOnOut;
         this.FProcessorWindowBigDipper.OnHelpTipsOver = UIHelpTipsHintOnOver;
         this.FProcessorWindowBigDipper.OnHelpTipsOut = UIHelpTipsHintOnOut;
         this.FProcessorWindowBigDipper.OnUpdateFreeTime = this.PerformPacket_CS_EDL_DipperTimesReq;
         this.FBoundsBigDipper = new TBounds();
         this.FBoundsBigDipper.Width = SIZE_WIDTH_BigDipper;
         this.FBoundsBigDipper.Height = SIZE_HEIGHT_BigDipper;
         ComponentBoundsCenter(this.FProcessorWindowBigDipper,this.FBoundsBigDipper);
         this.FOverlayerBigDipper = new TOverlayerBigDipper(this);
         this.FOverlayerBigDipper.Visible = false;
         FOverlayerHint = new TOverlayerHint(this);
         FOverlayerHint.visible = false;
         FOverlayerHelpTips = new TOverlayerHelpTips(this);
         FOverlayerHelpTips.Visible = false;
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_BIGDIPPER.RESOURCESID_Swf_BIGDIPPER);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerBigDipper);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerHint);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerHelpTips);
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         var _loc1_:TBins = null;
         var _loc2_:TBins = null;
         var _loc3_:TBins = null;
         var _loc4_:TConfigValue = null;
         _loc1_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_StarPointDesc);
         _loc2_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_ServenStar);
         _loc3_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_ServenStarExp);
         this.FUnstreamizerStarsInfor = new TUnstreamizerStarsInfor(_loc1_,_loc2_,_loc3_);
         this.FUnstreamizerUpgradeInfor = new TUnstreamizerUpgradeInfor();
         this.FStarsInfor = new TStarsInfor();
         this.InitStarInfor();
         this.FStarUpgradeInfor = new TStarUpgradeInfor(CONST_BIGDIPPER.STAR_NUM);
         _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,60103002) as TConfigValue;
         this.FFreeTimeOneDay = int(_loc4_.Value);
         super.ResourcesPerform_UILocations();
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
      }
      
      protected function InitStarInfor() : void
      {
         var _loc1_:TStarInfor = null;
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < CONST_BIGDIPPER.STAR_NUM)
         {
            _loc1_ = new TStarInfor();
            _loc1_.StarNameID = CONST_BIGDIPPER.STARID[_loc2_];
            _loc1_.StarLevel = 0;
            this.FUnstreamizerStarsInfor.UnstreamizationPerform_BigDipperByDatabaseCommon(_loc1_);
            this.FStarsInfor.AddStar(_loc1_);
            _loc2_++;
         }
      }
      
      protected function UpdateLocalDataBy(param1:TStarUpgradeInfor) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:TStarInfor = null;
         this.FStarsInfor.FreeTime -= this.FStarUpgradeInfor.CostFreeTime;
         _loc2_ = 0;
         while(_loc2_ < CONST_BIGDIPPER.STAR_NUM)
         {
            _loc4_ = this.FStarUpgradeInfor.GetStarIDByIndex(_loc2_);
            if(this.FStarUpgradeInfor.GetReceiveExperienceByIndex(_loc2_) != 0)
            {
               _loc3_ = this.FStarUpgradeInfor.IndexByID(_loc4_);
               if(_loc3_ != -1)
               {
                  _loc6_ = this.FStarsInfor.GetStarByStarNameID(_loc4_);
                  _loc5_ = this.FStarUpgradeInfor.GetExperienceByIndex(_loc3_);
                  _loc6_.CurrentExp = _loc5_;
                  _loc5_ = this.FStarUpgradeInfor.GetLevelByIndex(_loc3_);
                  _loc6_.StarLevel = _loc5_;
                  this.FUnstreamizerStarsInfor.UnstreamizationPerform_BigDipperByDatabase(_loc6_);
               }
            }
            _loc2_++;
         }
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_BigDipper_StartsInfoRet,this.PerformPacket_SC_BigDipperStartsInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_BigDipper_UpgradeStartsInfoRet,this.PerformPacket_SC_BigDipperUpgradeInfoRet);
      }
      
      protected function PerformPacket_SC_BigDipperStartsInfoRet(param1:TPacket) : void
      {
         var _loc7_:TConfigValue = null;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         if(!FIsResourcesLoadCompleted)
         {
            _loc7_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,60103002) as TConfigValue;
            SLogicsCore.BigDipperFreeTime = int(_loc7_.Value) - param1.Data.readByte();
            return;
         }
         this.FUnstreamizerStarsInfor.Unstreamize(param1.Data,this.FStarsInfor,null);
         var _loc2_:int = this.FStarsInfor.FreeTime;
         this.FProcessorWindowBigDipper.StarsInfor = this.FStarsInfor;
         this.FProcessorWindowBigDipper.UpdateStarsInfor();
         this.FProcessorWindowBigDipper.visible = true;
         var _loc3_:int = this.FStarsInfor.FplayTimes;
         var _loc4_:int = this.FStarsInfor.FplayTimes;
         var _loc5_:TConfigValue = TConfigValue(SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,60103013));
         var _loc6_:Vector.<uint> = _loc5_ ? _loc5_.Value as Vector.<uint> : null;
         if(_loc6_ != null)
         {
            _loc3_ = _loc4_ >= _loc6_.length ? int(_loc6_.length - 1) : _loc3_;
            _loc4_ = int(_loc4_ - 1) >= _loc6_.length ? int(_loc6_.length - 1) : int(_loc4_ - 1);
            _loc4_ = _loc4_ < 0 ? 0 : _loc4_;
            _loc8_ = _loc6_ != null ? int(_loc6_[_loc3_]) : 0;
            _loc9_ = _loc6_ != null ? int(_loc6_[_loc4_]) : 0;
            this.FProcessorWindowBigDipper.updataViewData(_loc2_,_loc8_,_loc9_);
         }
      }
      
      protected function PerformPacket_SC_BigDipperUpgradeInfoRet(param1:TPacket) : void
      {
         this.PerformPacket_CS_EDL_DipperTimesReq();
         this.FStarUpgradeInfor.Reset();
         this.FUnstreamizerUpgradeInfor.Unstreamize(param1.Data,this.FStarUpgradeInfor,this.FStarsInfor);
         if(this.FStarUpgradeInfor.Length < 0 || this.FStarUpgradeInfor.Length > CONST_BIGDIPPER.STAR_NUM)
         {
            return;
         }
         this.UpdateLocalDataBy(this.FStarUpgradeInfor);
         this.FProcessorWindowBigDipper.StarUpgradeInfor = this.FStarUpgradeInfor;
         this.FProcessorWindowBigDipper.UpdateStarsUpgradeInfor(this.FCurrentUpgradeType);
         SLogicsCore.BigDipperFreeTime = this.FStarsInfor.FreeTime;
         if(this.FOnUserTotalFightingPowerReq != null)
         {
            this.FOnUserTotalFightingPowerReq(this);
         }
      }
      
      public function PerformPacket_CS_BigDipperStartsInfoReq() : void
      {
         TUtilityTransmitEmptyInfor.TransmitEmptyPacket(CONST_NETWORK.PACKETID_CS_BigDipper_StartsInfoReq);
      }
      
      protected function PerformPacket_CS_BigDipperUpgradeReq(param1:int) : void
      {
         var _loc2_:TPacket = null;
         if(this.FStarsInfor.IsFull())
         {
            EffectGenerateText(STRING_BIGDIPPER.STRING_ArrivalMaxLevel);
            return;
         }
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_BigDipper_UpgradeStartInfoReq);
         _loc2_.Data.writeByte(param1);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function PerformPacket_CS_EDL_DipperTimesReq() : void
      {
         this.PerformPacket_CS_BigDipperStartsInfoReq();
      }
      
      protected function UpgradeOneTime() : void
      {
         this.FCurrentUpgradeType = TProcessorWindowBigDipper.TYPE_ONETIMEUPGRADE;
         this.PerformPacket_CS_BigDipperUpgradeReq(UPGRADE_REQ_ONE_TIME);
      }
      
      protected function UpgradeAnyTime() : void
      {
         this.FCurrentUpgradeType = TProcessorWindowBigDipper.TYPE_ANYTIMEUPGRADE;
         this.PerformPacket_CS_BigDipperUpgradeReq(UPGRADE_REQ_FIFTY_TIME);
      }
      
      protected function ProcessorOnEffectString(param1:Object, param2:String) : void
      {
         if(FOnEffectText != null)
         {
            FOnEffectText(param1,param2);
         }
      }
      
      protected function UIComponentsHintOnOver1(param1:Object, param2:TBigDipperTipData) : void
      {
         this.FOverlayerBigDipper.Context = param2;
         this.FOverlayerBigDipper.Render(FUICore.MouseCoordinate);
         this.FOverlayerBigDipper.Show();
      }
      
      protected function UIComponentsHintOnOut1(param1:Object) : void
      {
         this.FOverlayerBigDipper.Hide();
      }
      
      protected function UIComponentsBtnOnOver(param1:Object, param2:THint) : void
      {
         FOverlayerHint.Context = param2;
         FOverlayerHint.Render(FUICore.MouseCoordinate);
         FOverlayerHint.Show();
      }
      
      protected function UIComponentsBtnOnOut(param1:Object) : void
      {
         FOverlayerHint.Hide();
      }
      
      protected function UpdateStarCeilLevel() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TStarInfor = null;
         var _loc4_:TEsotericPoint = null;
         var _loc5_:TConfigValue = null;
         _loc4_ = SLogicsCore.Character.EsotericPoints.GetEsotericPointByIdentifier(SLogicsCore.Character.StarMapIndex);
         if(_loc4_ != null)
         {
            _loc2_ = uint(_loc4_.LevelLimit);
         }
         _loc1_ = 0;
         while(_loc1_ < CONST_BIGDIPPER.STAR_NUM)
         {
            _loc3_ = this.FStarsInfor.GetStarByIndex(_loc1_);
            _loc3_.CurrentLevelCeiling = _loc2_;
            _loc1_++;
         }
      }
      
      override public function set OnClose(param1:Function) : void
      {
         super.OnClose = param1;
         this.FProcessorWindowBigDipper.OnClose = param1;
      }
      
      public function set UpdateHeroPower(param1:Function) : void
      {
         this.FProcessorWindowBigDipper.UpdateHeroPower = param1;
      }
      
      public function get ProcessorWindowBigDipper() : TProcessorWindowBigDipper
      {
         return this.FProcessorWindowBigDipper;
      }
      
      public function get OnUserTotalFightingPowerReq() : Function
      {
         return this.FOnUserTotalFightingPowerReq;
      }
      
      public function set OnUserTotalFightingPowerReq(param1:Function) : void
      {
         this.FOnUserTotalFightingPowerReq = param1;
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount();
         if(!FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowBigDipper.Load();
            return;
         }
         this.UpdateStarCeilLevel();
         this.PerformPacket_CS_BigDipperStartsInfoReq();
         this.FProcessorWindowBigDipper.ShackPendant();
         TutorialNextStep(1701);
      }
      
      override public function Unmount() : void
      {
         this.FProcessorWindowBigDipper.visible = false;
         TutorialNextStep(1702);
      }
   }
}

