package Processors.Game.Lobby.CopyClassroom
{
   import Foundation.Common.TBounds;
   import Foundation.Common.THint;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Logics.CopyHero.TCopyHero;
   import Logics.DatebaseVO.VO.TBaseCopyHero;
   import Logics.SLogicsCore;
   import Logics.Streamization.CopyHero.TUnstreamizerCopyHero;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import Processors.Game.Lobby.CopyClassroom.Component.TUICopyHeroTip;
   import Rendering.Overlayers.HelpTips.TOverlayerHelpTips;
   import Rendering.Overlayers.Hints.TOverlayerHint;
   import Resources.Constants.CONST_COPYCLASSROOM;
   import Resources.Constants.CONST_COUNTER;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_SIGNAL;
   import Resources.Strings.STRING_COPYCLASSROOM;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.utils.ByteArray;
   
   public class TProcessorCopyClassroom extends TProcessorLobbyWindows
   {
      
      public static const SIZE_WindowClassroom_Width:uint = 977.25;
      
      public static const SIZE_WindowClassroom_Height:uint = 472;
      
      public static const SIZE_WindowCopyHero_Width:uint = 405;
      
      public static const SIZE_WindowCopyHero_Height:uint = 377;
      
      public static const SIZE_WindowCopyBuy_Width:uint = 310;
      
      public static const SIZE_WindowCopyBuy_Height:uint = 190;
      
      public static const KEYS_COUNTER_IMMEDIATE_COPYCLASSROOM:Vector.<uint> = CONST_COUNTER.KEYS_COUNTER_IMMEDIATE_COPYCLASSROOM;
      
      protected var FBoundsClassroom:TBounds;
      
      protected var FBoundsCopyHero:TBounds;
      
      protected var FBoundsCopyBuy:TBounds;
      
      protected var FProcessorWindowCopyClassroom:TProcessorWindowCopyClassroom;
      
      protected var FProcessorWindowCopyingHero:TProcessorWindowCopyingHero;
      
      protected var FProcessorWindowCopyingBuy:TProcessorWindowCopypingBuy;
      
      protected var FProcessorComponentCopyHeroTip:TUICopyHeroTip;
      
      protected var FRoleModelBin:TBins;
      
      protected var FCopyHeroBin:TBins;
      
      protected var FBaseHeroBin:TBins;
      
      protected var FBInit:Boolean;
      
      protected var FCopyHeros:Vector.<TCopyHero>;
      
      protected var FUnstreamizerCopyHero:TUnstreamizerCopyHero;
      
      protected var FCopyBuyTimes:int;
      
      protected var FBChangedCopyHeros:Boolean;
      
      protected var FCopyingHeroRetOK:Function;
      
      protected var FOnShortcutHyperlinks:Function;
      
      public function TProcessorCopyClassroom(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FProcessorWindowCopyClassroom = new TProcessorWindowCopyClassroom(this);
         this.FProcessorWindowCopyClassroom.OnClose = this.ProcessorWindowCopyClassroomOnClose;
         this.FProcessorWindowCopyClassroom.CopyingHeroOnClick = this.OnCopyingHeroClick;
         this.FProcessorWindowCopyClassroom.CopyingBuyOnClick = this.OnCopyingBuyClick;
         this.FProcessorWindowCopyClassroom.ChangeCopyHero = this.CopyingHeroChangeBody;
         this.FProcessorWindowCopyClassroom.OnEffectText = ProcessorsOnEffectText;
         this.FProcessorWindowCopyClassroom.HintOnOver = this.UIComponentsHintOnOver1;
         this.FProcessorWindowCopyClassroom.HintOnOut = this.UIComponentsHintOnOut1;
         this.FProcessorWindowCopyClassroom.OnShortcutHyperlinks = this.ProcessorOnShortcutHyperlinks;
         this.FProcessorWindowCopyClassroom.FreeTipOver = this.OnFreeTipOver;
         this.FProcessorWindowCopyClassroom.FreeTipOut = this.OnFreeTipOut;
         this.FProcessorWindowCopyClassroom.HelpHintOnOver = this.UIHelpHintOnOver;
         this.FProcessorWindowCopyClassroom.HelpHintOnOut = this.UIHelpHintOnOut;
         this.FProcessorWindowCopyingHero = new TProcessorWindowCopyingHero(this);
         this.FProcessorWindowCopyingHero.OnClose = this.ProcessorWindowCopyingHeroOnClose;
         this.FProcessorWindowCopyingHero.OnEffectText = ProcessorsOnEffectText;
         this.FProcessorWindowCopyingBuy = new TProcessorWindowCopypingBuy(this);
         this.FProcessorWindowCopyingBuy.OnClose = this.ProcessorWindowCopyingBuyOnClose;
         this.FProcessorWindowCopyingBuy.OnEffectText = ProcessorsOnEffectText;
         this.FBoundsClassroom = new TBounds();
         this.FBoundsClassroom.Width = SIZE_WindowClassroom_Width;
         this.FBoundsClassroom.Height = SIZE_WindowClassroom_Height;
         this.FBoundsCopyHero = new TBounds();
         this.FBoundsCopyHero.Width = SIZE_WindowCopyHero_Width;
         this.FBoundsCopyHero.Height = SIZE_WindowCopyHero_Height;
         ComponentBoundsCenter(this.FProcessorWindowCopyingHero,this.FBoundsCopyHero);
         this.FBoundsCopyBuy = new TBounds();
         this.FBoundsCopyBuy.Width = SIZE_WindowCopyBuy_Width;
         this.FBoundsCopyBuy.Height = SIZE_WindowCopyBuy_Height;
         ComponentBoundsCenter(this.FProcessorWindowCopyingBuy,this.FBoundsCopyBuy);
         this.FCopyHeros = new Vector.<TCopyHero>();
         this.FUnstreamizerCopyHero = new TUnstreamizerCopyHero();
         this.FBChangedCopyHeros = false;
         this.FBInit = false;
         ComponentBoundsCenter(this.FProcessorWindowCopyClassroom,this.FBoundsClassroom);
         SetUIModuleID(CONST_MODULES.MODULE_CopyClassroom);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_COPYCLASSROOM.RESOURCESID_Swf_COPYCLASSROOM);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.FProcessorComponentCopyHeroTip = new TUICopyHeroTip(this);
         this.FProcessorComponentCopyHeroTip.visible = false;
         FOverlayerHint = new TOverlayerHint(this);
         FOverlayerHint.visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerHint);
         FOverlayerHelpTips = new TOverlayerHelpTips(this);
         FOverlayerHelpTips.visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerHelpTips);
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
      }
      
      override protected function ResourcesPerform_UIFinalize() : void
      {
         this.FBaseHeroBin = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_BaseHero);
         this.FRoleModelBin = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_RoleModel);
         this.FCopyHeroBin = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_HeroReplacement);
         this.FProcessorWindowCopyClassroom.BaseHeroBin = this.FBaseHeroBin;
         this.FProcessorWindowCopyClassroom.RoleModelBin = this.FRoleModelBin;
         this.FProcessorWindowCopyClassroom.CopyHeroBin = this.FCopyHeroBin;
         super.ResourcesPerform_UIFinalize();
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_CopyHero_LoadingHeroRet,this.PerformPacket_SC_Copy_LoadingHeroListRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_CopyHero_CopyingHeroRet,this.PerformPacket_SC_Copy_CopypingRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_CopyHero_BuyCopyTimesRet,this.PerformPacket_SC_Copy_BuyCopyCountRet);
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         this.FProcessorWindowCopyClassroom.UpDateCopyingHeroCoolingTime();
         if(this.FProcessorComponentCopyHeroTip != null && this.FProcessorComponentCopyHeroTip.visible == true)
         {
            this.FProcessorComponentCopyHeroTip.CheckTipPoint();
         }
      }
      
      protected function PerformPacket_SC_Copy_LoadingHeroListRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = param1.Data;
         this.FUnstreamizerCopyHero.Unstreamize(_loc2_,this.FCopyHeros,null);
         this.FProcessorWindowCopyClassroom.UpdateBox(this.FCopyHeros);
         this.FBInit = true;
         this.FBChangedCopyHeros = false;
      }
      
      protected function PerformPacket_SC_Copy_CopypingRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:int = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         this.FProcessorWindowCopyClassroom.CopyingCDTime = _loc2_.readUnsignedInt();
         this.FProcessorWindowCopyClassroom.CopyedCardID = _loc4_ = int(_loc2_.readUnsignedInt());
         if(_loc4_ == 0)
         {
            this.CopyingHeroChangeBody(_loc4_);
            this.FProcessorWindowCopyClassroom.BChangedNormalBody = true;
         }
         else
         {
            if(this.FProcessorWindowCopyClassroom.FreeChangeCopyHeroCount > 0)
            {
               --this.FProcessorWindowCopyClassroom.FreeChangeCopyHeroCount;
               EffectGenerateText(STRING_COPYCLASSROOM.FORMAT_CopyingHeroOKWithFree);
            }
            else
            {
               --this.FProcessorWindowCopyClassroom.CanCopyingCount;
               EffectGenerateText(STRING_COPYCLASSROOM.FORMAT_CopyingHeroOK);
            }
            this.FProcessorWindowCopyClassroom.UpDateTF();
            this.FProcessorWindowCopyClassroom.UpDateBoxsFromRet();
            this.FProcessorWindowCopyClassroom.BChangedNormalBody = false;
         }
      }
      
      protected function PerformPacket_SC_Copy_BuyCopyCountRet(param1:TPacket) : void
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
         ++this.FProcessorWindowCopyClassroom.AlreadyBuyCount;
         ++this.FProcessorWindowCopyClassroom.CanCopyingCount;
         this.FProcessorWindowCopyClassroom.UpDateTF();
      }
      
      protected function PerformPacket_CS_UpdateCounterReq() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Vector.<uint> = null;
         _loc2_ = int(KEYS_COUNTER_IMMEDIATE_COPYCLASSROOM.length);
         _loc3_ = new Vector.<uint>(_loc2_);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_[_loc1_] = KEYS_COUNTER_IMMEDIATE_COPYCLASSROOM[_loc1_];
            SLogicsCore.SignalPost(CONST_SIGNAL.SIGNALDESTINATION_COUNTER_CopyClassRoom_Req,0,0,_loc3_);
            _loc1_++;
         }
      }
      
      protected function PerformPacket_CS_LoadingCopyHeroReq() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_CopyHero_LoadingHeroReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function CopyingHeroChangeBody(param1:int) : void
      {
         var _loc2_:TBaseCopyHero = null;
         if(param1 == 0)
         {
            this.FCopyingHeroRetOK(this,0);
         }
         else
         {
            this.FCopyHeroBin = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_HeroReplacement);
            _loc2_ = this.FCopyHeroBin.GetDatebaseByIdentifier(this.FProcessorWindowCopyClassroom.CopyedCardID) as TBaseCopyHero;
            this.FCopyingHeroRetOK(this,_loc2_.HeroID);
         }
      }
      
      protected function ProcessorStreamData(param1:ByteArray) : void
      {
         var _loc2_:int = 0;
         if(param1 != null)
         {
            _loc2_ = param1.readInt();
            if(this.FProcessorWindowCopyClassroom)
            {
               this.FProcessorWindowCopyClassroom.CardIDFromSuperHero = _loc2_;
               this.FProcessorWindowCopyClassroom.BChangeCopyHeroData = true;
               if(this.FBInit)
               {
                  this.FProcessorWindowCopyClassroom.UpdateBoxWithoutValue();
               }
            }
         }
      }
      
      protected function ProcessorWindowCopyClassroomOnClose(param1:Object) : void
      {
         ProcessorClose();
      }
      
      protected function ProcessorWindowCopyingHeroOnClose(param1:Object) : void
      {
         this.FProcessorWindowCopyingHero.visible = false;
      }
      
      protected function ProcessorWindowCopyingBuyOnClose(param1:Object) : void
      {
         this.FProcessorWindowCopyingBuy.visible = false;
      }
      
      protected function OnCopyingHeroClick(param1:Object) : void
      {
         var _loc2_:TCopyHero = param1 as TCopyHero;
         if(_loc2_.BRecruit != 1)
         {
            EffectGenerateText(STRING_COPYCLASSROOM.FORMAT_NoRecruit);
            return;
         }
         if(_loc2_.State == 1)
         {
            EffectGenerateText(STRING_COPYCLASSROOM.FORMAT_AlreadyCopyingHero);
            return;
         }
         if(this.FProcessorWindowCopyClassroom.CanCopyingCount <= 0 && this.FProcessorWindowCopyClassroom.FreeChangeCopyHeroCount <= 0)
         {
            EffectGenerateText(STRING_COPYCLASSROOM.FORMAT_NoCopyHeroCount);
            return;
         }
         this.FProcessorWindowCopyingHero.visible = true;
         this.FProcessorWindowCopyingHero.SingleCopyHero = _loc2_;
         this.FProcessorWindowCopyingHero.UpDateUI(this.FProcessorWindowCopyClassroom.CopyingCDTime);
      }
      
      protected function ProcessorOnShortcutHyperlinks(param1:Object, param2:uint, param3:uint) : void
      {
         this.FOnShortcutHyperlinks(param1,param2,param3);
      }
      
      protected function OnCopyingBuyClick(param1:Object, param2:int) : void
      {
         this.FProcessorWindowCopyingBuy.AlreadyBuyCount = param2;
         this.FProcessorWindowCopyingBuy.visible = true;
         this.FProcessorWindowCopyingBuy.UpDateUI();
      }
      
      protected function UIComponentsHintOnOver1(param1:Object, param2:TCopyHero) : void
      {
         this.FProcessorComponentCopyHeroTip.SetCopyHeroData(param2);
         this.FProcessorComponentCopyHeroTip.Visible = true;
      }
      
      protected function UIComponentsHintOnOut1(param1:Object) : void
      {
         this.FProcessorComponentCopyHeroTip.Visible = false;
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
      
      protected function OnFreeTipOver(param1:Object, param2:THint) : void
      {
         FOverlayerHint.Context = param2;
         FOverlayerHint.Render(FUICore.MouseCoordinate);
         FOverlayerHint.Visible = true;
      }
      
      protected function OnFreeTipOut(param1:Object) : void
      {
         FOverlayerHint.Visible = false;
      }
      
      public function get CopyingHeroRetOK() : Function
      {
         return this.FCopyingHeroRetOK;
      }
      
      public function set CopyingHeroRetOK(param1:Function) : void
      {
         this.FCopyingHeroRetOK = param1;
      }
      
      public function get OnShortcutHyperlinks() : Function
      {
         return this.FOnShortcutHyperlinks;
      }
      
      public function set OnShortcutHyperlinks(param1:Function) : void
      {
         this.FOnShortcutHyperlinks = param1;
      }
      
      public function get ProcessorWindowCopyClassroom() : TProcessorWindowCopyClassroom
      {
         return this.FProcessorWindowCopyClassroom;
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount();
         this.ProcessorStreamData(param1);
         if(!FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowCopyClassroom.Load();
            this.FProcessorWindowCopyingHero.Load();
            this.FProcessorWindowCopyingBuy.Load();
            return;
         }
         if(!this.FBInit)
         {
            this.PerformPacket_CS_LoadingCopyHeroReq();
            this.PerformPacket_CS_UpdateCounterReq();
         }
         this.PerformPacket_CS_LoadingCopyHeroReq();
         TutorialNextStep(2200);
         this.FProcessorWindowCopyClassroom.Visible = true;
         this.FProcessorWindowCopyClassroom.PlayEffect();
      }
      
      override public function Unmount() : void
      {
         super.Unmount();
         this.FProcessorWindowCopyingHero.visible = false;
         this.FProcessorWindowCopyingBuy.visible = false;
         this.FProcessorWindowCopyClassroom.Reset();
         TutorialNextStep(2202);
      }
      
      public function UpDateCopyHeros(param1:int) : void
      {
         if(param1 > 0)
         {
            this.FBChangedCopyHeros = true;
         }
      }
   }
}

