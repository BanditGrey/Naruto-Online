package Processors.Game.Lobby.KillHeros
{
   import Foundation.Common.*;
   import Foundation.Network.*;
   import Foundation.Resources.*;
   import Foundation.Resources.Bins.*;
   import Foundation.UI.*;
   import Foundation.Utilities.TUtilityString;
   import Logics.*;
   import Logics.DatebaseVO.VO.*;
   import Logics.Inventories.*;
   import Logics.KillHero.*;
   import Logics.Streamization.KillHero.*;
   import Processors.Game.Lobby.Common.*;
   import Processors.Game.Windows.Information.TUIWindowInformation;
   import Rendering.Overlayers.HelpTips.*;
   import Rendering.Overlayers.Hints.*;
   import Rendering.Overlayers.Inventories.*;
   import Resources.Constants.*;
   import Resources.Strings.*;
   import Utilities.UI.Overlayers.*;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.utils.*;
   
   public class TProcessorKillHeros extends TProcessorLobbyWindows
   {
      
      protected static const SIZE_WIDTH_KillHeros:int = 864;
      
      protected static const SIZE_HEIGHT_KillHeros:int = 532;
      
      protected static const RESOURCESSTATE_Request:int = 0;
      
      protected static const RESOURCESSTATE_Wait:int = 1;
      
      protected static const RESOURCESSTATE_Dispatch:int = 2;
      
      protected var FProcessorWindowKillHeros:TProcessorWindowKillHeros;
      
      protected var FProcessorDaoJiShi:TProcessorDaoJiShi;
      
      protected var FBoundsKillHeros:TBounds;
      
      protected var FKillHeroInfo:TKillHero;
      
      protected var UnstreamizerKillHero:TUnstreamizerKillHero;
      
      protected var FRaidersDailyConfigBins:TBins;
      
      protected var FUIWindowNotify:TUIWindowInformation;
      
      protected var FOnShortcutHyperlinks:Function;
      
      protected var FAddPopTips:Function;
      
      protected var RewardDec:String;
      
      protected var TempVec:Vector.<uint>;
      
      public function TProcessorKillHeros(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FProcessorWindowKillHeros = new TProcessorWindowKillHeros(this);
         this.FProcessorWindowKillHeros.OnClose = this.ProcessorWindowKillHerosOnClose;
         this.FProcessorWindowKillHeros.SlotsOnMove = this.UIComponentsApplianceOnOver;
         this.FProcessorWindowKillHeros.SlotsOnOut = this.UIComponentsApplianceOnOut;
         this.FProcessorWindowKillHeros.OnShortcutHyperlinks = this.ProcessorOnShortcutHyperlinks;
         this.FProcessorWindowKillHeros.HintOnMove = this.UIComponentsHintOnOver1;
         this.FProcessorWindowKillHeros.HintOnOut = this.UIComponentsHintOnOut1;
         this.FProcessorWindowKillHeros.OnHelpTipsOver = UIHelpTipsHintOnOver;
         this.FProcessorWindowKillHeros.OnHelpTipsOut = UIHelpTipsHintOnOut;
         this.FProcessorDaoJiShi = new TProcessorDaoJiShi(this);
         this.FProcessorDaoJiShi.BackFun = this.DaoJiShiBackFunc;
         this.FBoundsKillHeros = new TBounds();
         this.FBoundsKillHeros.Width = SIZE_WIDTH_KillHeros;
         this.FBoundsKillHeros.Height = SIZE_HEIGHT_KillHeros;
         ComponentBoundsCenter(this.FProcessorWindowKillHeros,this.FBoundsKillHeros);
         FOverlayerTreasure = new TOverlayerTreasure(this,CONST_MODULES.MODULE_KillHeros);
         FOverlayerTreasure.Visible = false;
         FOverlayerHint = new TOverlayerHint(this);
         FOverlayerHint.Visible = false;
         FOverlayerHelpTips = new TOverlayerHelpTips(this);
         FOverlayerHelpTips.Visible = false;
         this.FKillHeroInfo = new TKillHero();
         this.UnstreamizerKillHero = new TUnstreamizerKillHero();
         this.FUIWindowNotify = new TUIWindowInformation(this);
         this.FUIWindowNotify.x = (CONST_COMMON.STAGE_Width - this.FUIWindowNotify.WindowWidth) / 2;
         this.FUIWindowNotify.y = (CONST_COMMON.STAGE_Height - this.FUIWindowNotify.WindowHeight) / 2;
         this.TempVec = new Vector.<uint>();
         SetUIModuleID(CONST_MODULES.MODULE_KillHeros);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_KILLHERO.RESOURCESID_KillHero);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerTreasure);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerHint);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerHelpTips);
         TUtilityUIWindow.SetupWindowInformation(this.FUIWindowNotify);
         this.FUIWindowNotify.Visible = false;
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         if(this.FProcessorWindowKillHeros != null && this.FProcessorWindowKillHeros.visible == true)
         {
            this.FProcessorWindowKillHeros.UpdataRole();
         }
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_LOBBY_KillHeros_Notify,this.PacketPerform_SC_Notify);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_LOBBY_KillHeros_ResetRet,this.PacketPerform_SC_ResetRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_LOBBY_KillHeros_BestFirstNotify,this.PacketPerform_SC_BestFirstNotify);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_LOBBY_KillHeros_AutoFire,this.PACKETID_SC_LOBBY_KillHeros_AutoFire);
      }
      
      protected function PacketPerform_SC_EnterKillHero(param1:ByteArray) : void
      {
         var _loc2_:int = 0;
         _loc2_ = param1.readInt();
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         this.UnstreamizerKillHero.Unstreamize(param1,this.FKillHeroInfo,SResourcesCore.ResourceBin);
         this.FProcessorWindowKillHeros.SetKillHeroData(this.FKillHeroInfo);
         this.FProcessorWindowKillHeros.visible = true;
      }
      
      protected function PacketPerform_SC_Notify(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = param1.Data;
         this.UnstreamizerKillHero.UnstreamizationNotify(_loc2_,this.FKillHeroInfo,SResourcesCore.ResourceBin);
         if(this.IsInit)
         {
            this.FProcessorWindowKillHeros.Updata();
         }
      }
      
      protected function PACKETID_SC_LOBBY_KillHeros_AutoFire(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:uint = 0;
         var _loc9_:TRaidersDailyConfig = null;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         this.RewardDec = "";
         _loc2_ = param1.Data;
         _loc3_ = int(_loc2_.readUnsignedInt());
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc3_ = int(_loc2_.readUnsignedInt());
         _loc3_ = _loc2_.readShort();
         var _loc10_:Vector.<uint> = new Vector.<uint>();
         _loc10_.length = 0;
         this.TempVec.length = 0;
         _loc11_ = 0;
         while(_loc11_ < _loc3_)
         {
            _loc8_ = _loc2_.readUnsignedInt();
            this.TempVec.push(_loc8_);
            _loc8_ = uint(_loc2_.readShort());
            _loc12_ = 0;
            while(_loc12_ < _loc8_)
            {
               _loc5_ = 7;
               _loc4_ = _loc2_.readShort();
               _loc6_ = int(_loc2_.readUnsignedInt());
               _loc7_ = int(_loc2_.readUnsignedInt());
               _loc13_ = 0;
               while(_loc13_ < _loc10_.length / 3)
               {
                  if(_loc10_[_loc13_ * 3] == _loc4_ && _loc10_[_loc13_ * 3 + 1] == _loc6_)
                  {
                     _loc10_[_loc13_ * 3 + 2] += _loc7_;
                     _loc5_ = 8;
                     break;
                  }
                  _loc13_++;
               }
               if(_loc5_ == 7)
               {
                  _loc10_.push(_loc4_);
                  _loc10_.push(_loc6_);
                  _loc10_.push(_loc7_);
               }
               _loc12_++;
            }
            _loc11_++;
         }
         _loc11_ = 0;
         while(_loc11_ < _loc10_.length / 3)
         {
            this.RewardDec += TUtilityString.Format(STRING_BACKPACK.STRING_CaoA,STRING_COMMON.GetItemNameByType(_loc10_[_loc11_ * 3],_loc10_[_loc11_ * 3 + 1]),_loc10_[_loc11_ * 3 + 2]);
            _loc11_++;
         }
         this.FProcessorDaoJiShi.DaoJiTime = 10;
         this.FProcessorDaoJiShi.SetBegin();
         this.FProcessorDaoJiShi.visible = true;
      }
      
      protected function DaoJiShiBackFunc() : void
      {
         this.FProcessorWindowKillHeros.NimeiDeReflash(this.TempVec);
         this.RewardDec = STRING_BACKPACK.STRING_Cao + this.RewardDec;
         this.FUIWindowNotify.Text = this.RewardDec;
         this.FUIWindowNotify.visible = true;
      }
      
      protected function PacketPerform_SC_ResetRet(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Vector.<uint> = null;
         var _loc5_:int = 0;
         var _loc6_:ByteArray = null;
         _loc6_ = param1.Data;
         _loc3_ = int(_loc6_.readUnsignedInt());
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc5_ = int(_loc6_.readUnsignedShort());
         _loc4_ = new Vector.<uint>(_loc5_);
         _loc2_ = 0;
         while(_loc2_ < _loc5_)
         {
            _loc4_.push(_loc6_.readUnsignedInt());
            _loc2_++;
         }
         this.FProcessorWindowKillHeros.ResetKillHeroData(_loc4_);
      }
      
      protected function PacketPerform_SC_BestFirstNotify(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = param1.Data;
         this.UnstreamizerKillHero.UnstreamizationBestFirstNotify(_loc2_,this.FKillHeroInfo,null);
         this.FProcessorWindowKillHeros.SetKillHeroData(this.FKillHeroInfo,true);
      }
      
      protected function get IsInit() : Boolean
      {
         return this.FKillHeroInfo.IsInit;
      }
      
      override public function set OnEffectText(param1:Function) : void
      {
         this.FProcessorWindowKillHeros.OnEffectText = param1;
         FOnEffectText = param1;
      }
      
      protected function ProcessorWindowKillHerosOnClose(param1:Object) : void
      {
         ProcessorClose();
      }
      
      protected function ProcessorOnShortcutHyperlinks(param1:Object, param2:uint, param3:uint, param4:int = 0, param5:Object = null) : void
      {
         if(this.FOnShortcutHyperlinks != null)
         {
            this.FOnShortcutHyperlinks(param1,param2,param3,param4,param5);
         }
      }
      
      protected function UIComponentsApplianceOnOver(param1:Object, param2:Object) : void
      {
         var _loc3_:TInventory = null;
         _loc3_ = param2 as TInventory;
         if(FOverlayerTreasure != null)
         {
            FOverlayerTreasure.Context = _loc3_;
            FOverlayerTreasure.Render(FUICore.MouseCoordinate);
            FOverlayerTreasure.Show();
         }
      }
      
      protected function UIComponentsApplianceOnOut(param1:Object, param2:Object) : void
      {
         var _loc3_:TInventory = null;
         _loc3_ = param1 as TInventory;
         if(FOverlayerTreasure != null)
         {
            FOverlayerTreasure.Hide();
         }
      }
      
      protected function UIComponentsHintOnOver1(param1:Object, param2:THint) : void
      {
         FOverlayerHint.Context = param2;
         FOverlayerHint.Render(FUICore.MouseCoordinate);
         FOverlayerHint.visible = true;
      }
      
      protected function UIComponentsHintOnOut1(param1:Object) : void
      {
         FOverlayerHint.visible = false;
      }
      
      public function get OnShortcutHyperlinks() : Function
      {
         return this.FOnShortcutHyperlinks;
      }
      
      public function set OnShortcutHyperlinks(param1:Function) : void
      {
         this.FOnShortcutHyperlinks = param1;
      }
      
      public function get AddPopTips() : Function
      {
         return this.FAddPopTips;
      }
      
      public function set AddPopTips(param1:Function) : void
      {
         this.FAddPopTips = param1;
         this.FProcessorWindowKillHeros.AddPopTips = param1;
      }
      
      public function get ProcessorWindowKillHeros() : TProcessorWindowKillHeros
      {
         return this.FProcessorWindowKillHeros;
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         var _loc2_:TPacket = null;
         super.Mount();
         if(!FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowKillHeros.Load();
            this.FProcessorDaoJiShi.Load();
            return;
         }
         if(param1 != null)
         {
            this.PacketPerform_SC_EnterKillHero(param1);
         }
         if(this.IsInit)
         {
            this.LevelUpUpdateKillHero();
            this.FProcessorWindowKillHeros.ReloadRole();
            this.FProcessorWindowKillHeros.Updata();
            this.FProcessorWindowKillHeros.visible = true;
            TutorialNextStep(1201);
            return;
         }
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Enter_KillHeros);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
         this.FRaidersDailyConfigBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_RaidersDailyConfig);
         this.FProcessorWindowKillHeros.IsInBattle = false;
      }
      
      override public function Unmount() : void
      {
         this.FProcessorWindowKillHeros.Releasing();
         this.FProcessorWindowKillHeros.visible = false;
         TutorialNextStep(1202);
         if(this.FProcessorWindowKillHeros.IsInBattle)
         {
            super.Unmount();
         }
      }
      
      public function LevelUpUpdateKillHero() : void
      {
         var _loc1_:TSingleKillHero = null;
         var _loc2_:uint = 0;
         var _loc3_:TRaidersDailyConfig = null;
         if(this.FKillHeroInfo != null)
         {
            _loc1_ = this.FKillHeroInfo.GetSingleKillHeroById(this.FKillHeroInfo.CurHeroId);
            if(_loc1_ == null)
            {
               return;
            }
            if(_loc1_.IsPassed)
            {
               _loc3_ = this.FRaidersDailyConfigBins.GetDatebaseByIdentifier(this.FKillHeroInfo.CurHeroId) as TRaidersDailyConfig;
               _loc2_ = _loc3_.NextHard;
               _loc3_ = this.FRaidersDailyConfigBins.GetDatebaseByIdentifier(_loc2_) as TRaidersDailyConfig;
               if(_loc3_ != null && _loc3_.Level <= SLogicsCore.Character.GetMainLevel())
               {
                  this.FKillHeroInfo.CurHeroId = _loc2_;
                  this.FProcessorWindowKillHeros.SetKillHeroData(this.FKillHeroInfo);
               }
            }
         }
      }
      
      public function UpdateKillHero(param1:uint) : void
      {
         var _loc2_:TSingleKillHero = null;
         var _loc3_:int = 0;
         var _loc4_:TRaidersDailyConfig = null;
         if(param1 > this.FKillHeroInfo.CurHeroId)
         {
            return;
         }
         _loc2_ = this.FKillHeroInfo.GetSingleKillHeroById(param1);
         if(_loc2_ != null)
         {
            _loc2_.EnterCount += 1;
            _loc4_ = this.FRaidersDailyConfigBins.GetDatebaseByIdentifier(param1) as TRaidersDailyConfig;
            _loc3_ = int(_loc4_.NextHard);
            _loc2_.IsPassed = true;
            if(_loc3_ <= 0)
            {
               this.FProcessorWindowKillHeros.Updata();
               return;
            }
            _loc4_ = this.FRaidersDailyConfigBins.GetDatebaseByIdentifier(_loc3_) as TRaidersDailyConfig;
            _loc2_ = this.FKillHeroInfo.GetSingleKillHeroById(_loc3_);
            if(!_loc2_.IsPassed)
            {
               if(_loc4_ != null && _loc4_.Level <= SLogicsCore.Character.GetMainLevel())
               {
                  this.FKillHeroInfo.CurHeroId = _loc3_;
               }
               this.FProcessorWindowKillHeros.SetKillHeroData(this.FKillHeroInfo,true,this.FKillHeroInfo.CurHeroId);
            }
            else
            {
               this.FProcessorWindowKillHeros.SetKillHeroData(this.FKillHeroInfo,true,_loc3_);
            }
         }
      }
   }
}

