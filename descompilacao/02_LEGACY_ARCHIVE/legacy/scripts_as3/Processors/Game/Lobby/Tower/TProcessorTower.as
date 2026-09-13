package Processors.Game.Lobby.Tower
{
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.Json.TFixedAward;
   import Logics.DatebaseVO.VO.TEnchantBattle;
   import Logics.Streamization.Tower.TUnstreamizerTower;
   import Logics.Streamization.Tower.TUnstreamizerTowers;
   import Logics.Tower.TTower;
   import Logics.Tower.TTowerData;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import Rendering.Overlayers.HelpTips.TOverlayerHelpTips;
   import Rendering.Overlayers.Hints.TOverlayerHint;
   import Resources.Constants.CONST_BATTLE;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_TOWER;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_TOWER;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.utils.ByteArray;
   import flash.utils.setTimeout;
   
   public class TProcessorTower extends TProcessorLobbyWindows
   {
      
      protected var FProcessorWindowTower:TProcessorWindowTower;
      
      protected var FProcessorWindowTowerLevel:TProcessorWindowTowerLevel;
      
      protected var FUnstreamizerTowers:TUnstreamizerTowers;
      
      protected var FUnstreamizerTower:TUnstreamizerTower;
      
      protected var FTowerData:TTowerData;
      
      protected var FTower:TTower;
      
      protected var FIsFirstOpen:Boolean;
      
      protected var FIsWin:Boolean;
      
      protected var FBins:TBins;
      
      protected var FIsShowTowerLevel:Boolean;
      
      protected var FIndex:int;
      
      protected var FTowerIndex:uint;
      
      protected var FTowerID:uint;
      
      protected var FOnInitBattle:Function;
      
      protected var FSetStatusType:Function;
      
      public function TProcessorTower(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FProcessorWindowTower = new TProcessorWindowTower(this);
         this.FProcessorWindowTower.OnClose = this.ProcessorOnClose;
         this.FProcessorWindowTower.EnterLevelOnClick = this.ProcessorEnterLevelOnClick;
         this.FProcessorWindowTower.OnHelpTipsOut = UIHelpTipsHintOnOut;
         this.FProcessorWindowTower.OnHelpTipsOver = UIHelpTipsHintOnOver;
         this.FProcessorWindowTowerLevel = new TProcessorWindowTowerLevel(this);
         this.FProcessorWindowTowerLevel.OnClose = this.ProcessorEnterTowerOnClick;
         this.FProcessorWindowTowerLevel.ChallengeOnClick = this.ProcessorChallengeOnClick;
         this.FProcessorWindowTowerLevel.AutoChallengeOnClick = this.ProcessorAutoChallengeOnClick;
         this.FProcessorWindowTowerLevel.BuyHPTimesOnClick = this.ProcessorBuyHPTimesOnClick;
         this.FProcessorWindowTowerLevel.UIHintOnOver = ProcessorTipOnOver;
         this.FProcessorWindowTowerLevel.UIHintOnOut = ProcessorTipOnOut;
         this.FProcessorWindowTowerLevel.OnHelpTipsOut = UIHelpTipsHintOnOut;
         this.FProcessorWindowTowerLevel.OnHelpTipsOver = UIHelpTipsHintOnOver;
         FOverlayerHelpTips = new TOverlayerHelpTips(this);
         FOverlayerHelpTips.Visible = false;
         FOverlayerHint = new TOverlayerHint(this);
         FOverlayerHint.Visible = false;
         this.FUnstreamizerTowers = new TUnstreamizerTowers();
         this.FUnstreamizerTower = new TUnstreamizerTower();
         this.FTowerData = new TTowerData();
         this.FIsFirstOpen = false;
         this.FIsWin = false;
         this.FIsShowTowerLevel = false;
         SetUIModuleID(CONST_MODULES.MODULE_Tower);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_TOWER.RESOURCESID_Swf_Tower);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerHelpTips);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerHint);
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_EnchantBattle) as TBins;
         super.ResourcesPerform_UILocations();
      }
      
      override protected function ResourcesPerform_UIFinalize() : void
      {
         this.FUnstreamizerTowers.UnstreamizeByDatabase(null,this.FTowerData.Towers,null);
         super.ResourcesPerform_UIFinalize();
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Tower_LoadInfo_Ret,this.PacketPerform_SC_LoadInfo_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Tower_Challenge_Ret,this.PacketPerform_SC_Challenge_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Tower_BuyPlayerHP_Ret,this.PacketPerform_SC_BuyPlayerHP_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Tower_AutoBattle_Ret,this.PacketPerform_SC_AutoBattle_Ret);
      }
      
      protected function PacketPerform_SC_LoadInfo_Ret(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:TTower = null;
         _loc2_ = param1.Data;
         this.FUnstreamizerTowers.Unstreamize(_loc2_,this.FTowerData,null);
         if(FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowTower.Update(this.FTowerData);
         }
      }
      
      protected function PacketPerform_SC_Challenge_Ret(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:int = 0;
         var _loc6_:uint = 0;
         var _loc7_:TTower = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         if(this.FSetStatusType != null)
         {
            this.FSetStatusType(this,CONST_BATTLE.BattleType_Tower,0);
         }
         if(this.FOnInitBattle != null)
         {
            this.FOnInitBattle(this);
         }
         this.FIsWin = Boolean(_loc2_.readUnsignedInt());
         this.FTowerIndex = _loc2_.readUnsignedInt();
         this.FTowerID = _loc2_.readUnsignedInt();
         this.FTowerData.PlayerHP = _loc2_.readUnsignedInt();
         this.FTowerData.FreeExploreTimes = _loc2_.readUnsignedInt();
         this.FIsShowTowerLevel = true;
      }
      
      protected function PacketPerform_SC_BuyPlayerHP_Ret(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc4_ = _loc2_.readUnsignedInt();
         _loc5_ = _loc2_.readUnsignedInt();
         this.FTowerData.PlayerHP = _loc4_;
         this.FTowerData.BuyHPTimes = _loc5_;
         this.FProcessorWindowTowerLevel.UpdateHP(this.FTowerData);
         UIComponentsHintOnOut(this,null);
      }
      
      protected function PacketPerform_SC_AutoBattle_Ret(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:TTower = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc5_ = _loc2_.readUnsignedInt();
         this.FTowerID = _loc2_.readUnsignedInt();
         _loc6_ = this.FTowerData.OpenTowers.GetTowerByIndex(_loc5_ - 1);
         _loc6_.TowerID = this.FTowerID;
         this.FUnstreamizerTower.Unstreamize(null,_loc6_,null);
         this.FTowerData.FreeExploreTimes = _loc2_.readUnsignedInt();
         this.FProcessorWindowTowerLevel.Update(this.FTowerData,_loc5_ - 1);
         this.FProcessorWindowTowerLevel.PlayAutoTime();
      }
      
      protected function PacketPerform_CS_LoadInfo_Req() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Tower_LoadInfo_Req);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PacketPerform_CS_Challenge_Req() : void
      {
         var _loc1_:ByteArray = null;
         var _loc2_:TPacket = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Tower_Challenge_Req);
         _loc1_ = _loc2_.Data;
         _loc1_.writeUnsignedInt(this.FIndex);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function PacketPerform_CS_BuyPlayerHP_Req() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Tower_BuyPlayerHP_Req);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PacketPerform_CS_AutoBattle_Req() : void
      {
         var _loc1_:ByteArray = null;
         var _loc2_:TPacket = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Tower_AutoBattle_Req);
         _loc1_ = _loc2_.Data;
         _loc1_.writeUnsignedInt(this.FIndex);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function GetFloatText(param1:TEnchantBattle) : String
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:TFixedAward = null;
         var _loc5_:uint = 0;
         var _loc6_:String = null;
         _loc6_ = "";
         _loc5_ = 0;
         _loc3_ = param1.Awards.length;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = param1.Awards[_loc2_];
            _loc5_ += _loc4_.Amount;
            _loc2_++;
         }
         _loc3_ = param1.Awardexs.length;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = param1.Awardexs[_loc2_];
            _loc5_ += _loc4_.Amount;
            _loc2_++;
         }
         return _loc6_ + (TUtilityString.Format(STRING_TOWER.FORMAT_WinAndGetItem,STRING_COMMON.GetItemNameByType(_loc4_.Type,_loc4_.Code),_loc5_) + "\n");
      }
      
      protected function PlayeEffect() : void
      {
         this.FProcessorWindowTowerLevel.PlayeEffectRoleDisappear();
      }
      
      protected function ProcessorEnterLevelOnClick(param1:Object, param2:int) : void
      {
         this.FTower = this.FTowerData.OpenTowers.GetTowerByIndex(param2);
         this.FIndex = param2 + 1;
         this.FProcessorWindowTower.Visible = false;
         this.FProcessorWindowTowerLevel.Visible = true;
         this.FProcessorWindowTowerLevel.Update(this.FTowerData,param2);
      }
      
      protected function ProcessorEnterTowerOnClick(param1:Object) : void
      {
         this.FProcessorWindowTower.Visible = true;
         this.FProcessorWindowTowerLevel.Visible = false;
         this.FProcessorWindowTower.Update(this.FTowerData);
      }
      
      protected function ProcessorOnClose(param1:Object) : void
      {
         ProcessorClose();
      }
      
      protected function ProcessorChallengeOnClick(param1:Object) : void
      {
         this.PacketPerform_CS_Challenge_Req();
      }
      
      protected function ProcessorAutoChallengeOnClick(param1:Object) : void
      {
         this.PacketPerform_CS_AutoBattle_Req();
      }
      
      protected function ProcessorBuyHPTimesOnClick(param1:Object) : void
      {
         this.PacketPerform_CS_BuyPlayerHP_Req();
      }
      
      public function get OnInitBattle() : Function
      {
         return this.FOnInitBattle;
      }
      
      public function set OnInitBattle(param1:Function) : void
      {
         this.FOnInitBattle = param1;
      }
      
      public function get SetStatusType() : Function
      {
         return this.FSetStatusType;
      }
      
      public function set SetStatusType(param1:Function) : void
      {
         this.FSetStatusType = param1;
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount(param1);
         if(!FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowTower.Load();
            this.FProcessorWindowTowerLevel.Load();
            return;
         }
         if(this.FIsShowTowerLevel)
         {
            this.FProcessorWindowTower.Visible = false;
            this.FProcessorWindowTowerLevel.Visible = true;
            this.FIsShowTowerLevel = false;
         }
         else
         {
            if(!this.FIsFirstOpen)
            {
               this.PacketPerform_CS_LoadInfo_Req();
            }
            else
            {
               this.FProcessorWindowTower.Update(this.FTowerData);
            }
            this.FProcessorWindowTower.Visible = true;
         }
      }
      
      public function PlayTextEffect() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TTower = null;
         var _loc4_:TEnchantBattle = null;
         if(this.FIsWin)
         {
            setTimeout(this.PlayeEffect,300);
         }
         _loc3_ = this.FTowerData.OpenTowers.GetTowerByIndex(this.FTowerIndex - 1);
         _loc3_.TowerID = this.FTowerID;
         this.FUnstreamizerTower.Unstreamize(null,_loc3_,null);
         this.FProcessorWindowTowerLevel.Update(this.FTowerData,this.FTowerIndex - 1,this.FIsWin);
         if(this.FIsWin)
         {
            _loc2_ = uint(this.FBins.Count);
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               _loc4_ = this.FBins.GetDatebaseByIndex(_loc1_) as TEnchantBattle;
               if(this.FTowerID == _loc4_.Identifier)
               {
                  EffectGenerateText(this.GetFloatText(_loc4_));
                  break;
               }
               _loc1_++;
            }
         }
      }
   }
}

