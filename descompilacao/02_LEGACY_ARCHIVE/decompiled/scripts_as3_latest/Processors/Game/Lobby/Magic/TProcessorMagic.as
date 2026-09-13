package Processors.Game.Lobby.Magic
{
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.Json.TFixedAward;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.DatebaseVO.VO.TMewBattle;
   import Logics.Magic.TMagic;
   import Logics.Magic.TMagicData;
   import Logics.SLogicsCore;
   import Logics.Streamization.Magic.TUnstreamizerMagic;
   import Logics.Streamization.Magic.TUnstreamizerMagics;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import Processors.Game.Lobby.Magic.Window.TProcessorWindowLevels;
   import Processors.Game.Lobby.Magic.Window.TProcessorWindowMagic;
   import Processors.Game.Lobby.Magic.Window.TProcessorWindowMoutainMap;
   import Rendering.Overlayers.HelpTips.TOverlayerHelpTips;
   import Rendering.Overlayers.Hints.TOverlayerHint;
   import Resources.Constants.CONST_BATTLE;
   import Resources.Constants.CONST_CONFIGVALUE;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MAGIC;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_SHORTCUTS;
   import Resources.Strings.STRING_MAGIC;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.utils.ByteArray;
   
   public class TProcessorMagic extends TProcessorLobbyWindows
   {
      
      protected var FProcessorWindowMoutainMap:TProcessorWindowMoutainMap;
      
      protected var FProcessorWindowLevels:TProcessorWindowLevels;
      
      protected var FProcessorWindowMagic:TProcessorWindowMagic;
      
      protected var FIsFirstOpen:Boolean;
      
      protected var FUnstreamizerMagics:TUnstreamizerMagics;
      
      protected var FUnstreamizerMagic:TUnstreamizerMagic;
      
      protected var FMagicData:TMagicData;
      
      protected var FPracticeCount:uint;
      
      protected var FIsOpenMoutainMap:Boolean;
      
      protected var FStream:uint;
      
      protected var FMewBattle:TMewBattle;
      
      protected var FIsWin:Boolean;
      
      protected var FLevelIndex:int;
      
      protected var FMew_OpenLv:uint;
      
      protected var FOnUpdateAttribute:Function;
      
      protected var FOnInitBattle:Function;
      
      protected var FSetStatusType:Function;
      
      protected var FOnEffectSign:Function;
      
      protected var FOnUserTotalFightingPowerReq:Function;
      
      public function TProcessorMagic(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FProcessorWindowMoutainMap = new TProcessorWindowMoutainMap(this);
         this.FProcessorWindowMoutainMap.OnHelpTipsOut = UIHelpTipsHintOnOut;
         this.FProcessorWindowMoutainMap.OnHelpTipsOver = UIHelpTipsHintOnOver;
         this.FProcessorWindowMoutainMap.OnClose = this.ProcessorOnClose;
         this.FProcessorWindowMoutainMap.OnEnterMagicClick = this.ProcessorOnEnterMagicClick;
         this.FProcessorWindowMoutainMap.EnterLevelOnClick = this.ProcessorEnterLevelOnClick;
         this.FProcessorWindowMoutainMap.UIHintOnOver = ProcessorTipOnOver;
         this.FProcessorWindowMoutainMap.UIHintOnOut = ProcessorTipOnOut;
         this.FProcessorWindowLevels = new TProcessorWindowLevels(this);
         this.FProcessorWindowLevels.OnHelpTipsOut = UIHelpTipsHintOnOut;
         this.FProcessorWindowLevels.OnHelpTipsOver = UIHelpTipsHintOnOver;
         this.FProcessorWindowLevels.ChallengeOnClick = this.ProcessorChallengeOnClick;
         this.FProcessorWindowLevels.UIHintOnOver = ProcessorTipOnOver;
         this.FProcessorWindowLevels.UIHintOnOut = ProcessorTipOnOut;
         this.FProcessorWindowMagic = new TProcessorWindowMagic(this);
         this.FProcessorWindowMagic.OnHelpTipsOut = UIHelpTipsHintOnOut;
         this.FProcessorWindowMagic.OnHelpTipsOver = UIHelpTipsHintOnOver;
         this.FProcessorWindowMagic.OnPracticeClick = this.ProcessorOnPracticeClick;
         this.FProcessorWindowMagic.OnClose = this.ProcessorOnClose;
         this.FProcessorWindowMagic.OnEnterMoutain = this.ProcessorOnEnterMoutain;
         this.FProcessorWindowMagic.UIHintOnOver = ProcessorTipOnOver;
         this.FProcessorWindowMagic.UIHintOnOut = ProcessorTipOnOut;
         this.FProcessorWindowMagic.OnEffectText = this.ProcessorEffectGenerateText;
         FOverlayerHelpTips = new TOverlayerHelpTips(this);
         FOverlayerHelpTips.Visible = false;
         FOverlayerHint = new TOverlayerHint(this);
         FOverlayerHint.Visible = false;
         this.FIsFirstOpen = false;
         this.FUnstreamizerMagics = new TUnstreamizerMagics();
         this.FUnstreamizerMagic = new TUnstreamizerMagic();
         this.FMagicData = SLogicsCore.MagicData;
         this.FIsOpenMoutainMap = false;
         this.FStream = 0;
         SetUIModuleID(CONST_MODULES.MODULE_Magic);
      }
      
      protected function ProcessorEffectGenerateText(param1:Object, param2:String) : void
      {
         EffectGenerateText(param2);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_MAGIC.RESOURCESID_Swf_Magic);
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
         var _loc1_:TConfigValue = null;
         this.FUnstreamizerMagics.UnstreamizeByDatabase(null,this.FMagicData.MagicLevels,null);
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.Mew_OpenLv) as TConfigValue;
         this.FMew_OpenLv = _loc1_.Value as uint;
         super.ResourcesPerform_UILocations();
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Magic_InitEnergyRet,this.PacketPerform_SC_InitEnergyRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Magic_LevelupRet,this.PacketPerform_SC_LevelupRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Magic_EnergyUpdate,this.PacketPerform_SC_EnergyUpdate);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Magic_InitStageRet,this.PacketPerform_SC_InitStageRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Magic_StageFightRet,this.PacketPerform_SC_StageFightRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Magic_StageUpdate,this.PacketPerform_SC_StageUpdate);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Magic_EnergyResetNotify,this.PacketPerform_SC_EnergyResetNotify);
      }
      
      protected function PacketPerform_SC_InitEnergyRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = param1.Data;
         this.FUnstreamizerMagics.Unstreamize(_loc2_,this.FMagicData.Magics,null);
         this.FMagicData.SilverPracticeCount = _loc2_.readUnsignedInt();
         this.FMagicData.IsCanDown = true;
         if(FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowMagic.Update(this.FMagicData);
         }
         this.PacketPerform_CS_InitStageReq();
      }
      
      protected function PacketPerform_SC_LevelupRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:TMagic = null;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:String = null;
         var _loc12_:uint = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc6_ = _loc2_.readUnsignedInt();
         _loc4_ = _loc2_.readUnsignedInt();
         _loc5_ = _loc2_.readUnsignedInt();
         _loc9_ = _loc2_.readUnsignedInt();
         _loc8_ = this.FMagicData.Magics.GetMagicByIndex(_loc9_);
         _loc10_ = _loc2_.readUnsignedInt();
         _loc7_ = _loc2_.readUnsignedInt();
         _loc12_ = _loc2_.readUnsignedInt();
         this.FPracticeCount = _loc2_.readUnsignedInt();
         _loc8_.CurExp = _loc12_;
         if(_loc10_ > _loc8_.MagicID)
         {
            this.FUnstreamizerMagic.UnstreamizeByDatabase(null,_loc8_,_loc10_);
         }
         if(_loc6_ == CONST_MAGIC.TYPE_SilverPractice)
         {
            ++this.FMagicData.SilverPracticeCount;
            this.PlayEffectNewSign(false);
         }
         else if(_loc6_ == CONST_MAGIC.TYPE_GoldPractice || _loc6_ == CONST_MAGIC.TYPE_AdvancedPractice)
         {
            _loc8_.GoldPracticeCount += this.FPracticeCount;
         }
         this.FProcessorWindowMagic.OnLevelUpUpdate();
         if(_loc4_ > 0 && _loc5_ > 0)
         {
            _loc11_ = TUtilityString.Format(STRING_MAGIC.FORMAT_Batch,this.FPracticeCount,_loc4_,_loc5_,_loc7_,_loc8_.Level);
         }
         else if(_loc4_ > 0)
         {
            _loc11_ = TUtilityString.Format(STRING_MAGIC.FORMAT_LittleCritical,this.FPracticeCount,_loc4_,_loc7_);
         }
         else if(_loc5_ > 0)
         {
            _loc11_ = TUtilityString.Format(STRING_MAGIC.FORMAT_BigCritical,this.FPracticeCount,_loc5_,_loc7_);
         }
         else
         {
            _loc11_ = TUtilityString.Format(STRING_MAGIC.FORMAT_AddExp,_loc7_);
         }
         EffectGenerateText(_loc11_);
         UIComponentsHintOnOut(this,null);
         if(this.FOnUpdateAttribute != null)
         {
            this.FOnUpdateAttribute(this);
         }
         if(this.FOnUserTotalFightingPowerReq != null)
         {
            this.FOnUserTotalFightingPowerReq(this);
         }
         ProcessorOnCheckIconStatus(CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_Moutain,this.FMagicData.CheckStatus());
      }
      
      protected function PacketPerform_SC_EnergyUpdate(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:TMagic = null;
         var _loc5_:uint = 0;
         _loc2_ = param1.Data;
         _loc5_ = _loc2_.readUnsignedInt();
         _loc3_ = _loc2_.readUnsignedInt();
         _loc4_ = this.FMagicData.Magics.GetMagicByIndex(_loc5_);
         this.FUnstreamizerMagic.UnstreamizeByDatabase(null,_loc4_,_loc3_);
      }
      
      protected function PacketPerform_CS_InitEnergyReq() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Magic_InitEnergyReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PacketPerform_CS_InitStageReq() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Magic_InitStageReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PacketPerform_SC_InitStageRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = param1.Data;
         this.FMagicData.StageID = _loc2_.readUnsignedInt();
         if(this.FMagicData.StageID > 0)
         {
            this.PlayEffectNewSign(this.FMagicData.SilverPracticeCount == 0);
         }
         if(FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowMagic.Update(this.FMagicData);
            this.FProcessorWindowMoutainMap.Update(this.FMagicData);
         }
         this.FIsFirstOpen = true;
      }
      
      protected function PacketPerform_SC_StageFightRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         if(this.FSetStatusType != null)
         {
            this.FSetStatusType(this,CONST_BATTLE.BattleType_Magic,0);
         }
         if(this.FOnInitBattle != null)
         {
            this.FOnInitBattle(this);
         }
         this.FMagicData.StageID = _loc2_.readUnsignedInt();
         this.FIsWin = Boolean(_loc2_.readUnsignedByte());
         this.FIsOpenMoutainMap = true;
      }
      
      protected function PacketPerform_SC_StageUpdate(param1:TPacket) : void
      {
      }
      
      protected function PacketPerform_SC_EnergyResetNotify(param1:TPacket) : void
      {
         this.FMagicData.SilverPracticeCount = 0;
         if(Boolean(this.FMagicData) && this.FMagicData.StageID != 0)
         {
            this.PlayEffectNewSign(true);
         }
         ProcessorOnCheckIconStatus(CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_Moutain,this.FMagicData.CheckStatus());
      }
      
      protected function PlayEffectNewSign(param1:Boolean) : void
      {
         if(this.FOnEffectSign != null)
         {
            this.FOnEffectSign(CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_Magic,param1);
         }
      }
      
      protected function ProcessorOnClose(param1:Object) : void
      {
         ProcessorClose();
      }
      
      protected function ProcessorChallengeOnClick(param1:Object, param2:Object = null) : void
      {
         var _loc3_:TPacket = null;
         this.FMewBattle = param2 as TMewBattle;
         _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Magic_StageFightReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc3_);
      }
      
      protected function ProcessorOnPracticeClick(param1:Object, param2:int, param3:uint, param4:uint = 1) : void
      {
         var _loc5_:TPacket = null;
         var _loc6_:ByteArray = null;
         _loc5_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Magic_LevelupReq);
         _loc6_ = _loc5_.Data;
         _loc6_.writeUnsignedInt(param2);
         _loc6_.writeUnsignedInt(param3);
         _loc6_.writeUnsignedInt(param4);
         SNetworkCore.Transceiver.PacketTransmit(_loc5_);
      }
      
      protected function ProcessorOnEnterMoutain(param1:Object) : void
      {
         this.FProcessorWindowLevels.Visible = this.FProcessorWindowMagic.Visible = false;
         this.FProcessorWindowMoutainMap.Visible = true;
         this.FProcessorWindowMoutainMap.UpdateCopy(this.FMagicData);
         this.FProcessorWindowMoutainMap.UpdateThisPanel();
         this.FProcessorWindowMoutainMap.Update(this.FMagicData);
         this.FProcessorWindowMoutainMap.setVisible();
      }
      
      protected function ProcessorEnterLevelOnClick(param1:Object, param2:int) : void
      {
         this.FLevelIndex = param2;
         this.FProcessorWindowMagic.Visible = false;
         this.FProcessorWindowMoutainMap.Visible = this.FProcessorWindowLevels.Visible = true;
         this.FProcessorWindowLevels.Update(this.FMagicData,param2);
      }
      
      protected function ProcessorOnEnterMagicClick(param1:Object) : void
      {
         this.FProcessorWindowLevels.Visible = this.FProcessorWindowMoutainMap.Visible = false;
         this.FProcessorWindowMagic.Visible = true;
         this.FProcessorWindowMagic.Update(this.FMagicData);
      }
      
      public function get OnUpdateAttribute() : Function
      {
         return this.FOnUpdateAttribute;
      }
      
      public function set OnUpdateAttribute(param1:Function) : void
      {
         this.FOnUpdateAttribute = param1;
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
      
      public function get OnEffectSign() : Function
      {
         return this.FOnEffectSign;
      }
      
      public function set OnEffectSign(param1:Function) : void
      {
         this.FOnEffectSign = param1;
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
         super.Mount(param1);
         if(param1 != null)
         {
            this.FStream = param1.readUnsignedInt();
         }
         if(!FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowLevels.Load();
            this.FProcessorWindowMagic.Load();
            this.FProcessorWindowMoutainMap.Load();
            return;
         }
         if(this.FStream == 1 || this.FIsOpenMoutainMap)
         {
            this.FProcessorWindowMoutainMap.UpdateCopy(this.FMagicData);
            this.FProcessorWindowMoutainMap.UpdateThisPanel();
            this.FProcessorWindowMoutainMap.Update(this.FMagicData);
            this.FProcessorWindowMagic.Visible = false;
            this.FProcessorWindowMoutainMap.Visible = true;
            this.FProcessorWindowLevels.Visible = false;
            if(this.FIsOpenMoutainMap)
            {
               this.FProcessorWindowLevels.Visible = true;
               this.FProcessorWindowLevels.Update(this.FMagicData,this.FLevelIndex);
               this.FIsOpenMoutainMap = false;
            }
            this.FProcessorWindowMoutainMap.setVisible();
         }
         else if(this.FStream == 0)
         {
            this.FProcessorWindowMagic.Visible = true;
            this.FProcessorWindowMoutainMap.Visible = false;
            this.FProcessorWindowLevels.Visible = false;
            if(this.FIsFirstOpen)
            {
               this.FProcessorWindowMagic.Update(this.FMagicData);
            }
         }
      }
      
      override public function Unmount() : void
      {
         super.Unmount();
         this.FStream = 0;
      }
      
      public function PlayTextEffect() : void
      {
         var _loc1_:String = null;
         var _loc2_:uint = 0;
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:TFixedAward = null;
         _loc5_ = 0;
         _loc4_ = this.FMewBattle.Awards.length;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc6_ = this.FMewBattle.Awards[_loc3_];
            _loc5_ += _loc6_.Amount;
            _loc3_++;
         }
         _loc2_ = _loc5_;
         if(this.FMewBattle.Identifier == 100001 || this.FMewBattle.Identifier == 100004 || this.FMewBattle.Identifier == 100007)
         {
            return;
         }
         if(this.FIsWin)
         {
            _loc1_ = TUtilityString.Format(this.FMewBattle.NeedLevel > 1000 ? STRING_MAGIC.FORMAT_GetNatruePointsCopy : STRING_MAGIC.FORMAT_GetNatruePoints,_loc2_);
            EffectGenerateText(_loc1_);
            if(this.FMewBattle.Identifier % 100 % 3 == 0)
            {
               _loc4_ = this.FMewBattle.Awardexs.length;
               _loc3_ = 0;
               while(_loc3_ < _loc4_)
               {
                  _loc6_ = this.FMewBattle.Awardexs[_loc3_];
                  _loc5_ = _loc6_.Amount;
                  _loc3_++;
               }
               _loc2_ = _loc5_;
               _loc1_ = TUtilityString.Format(this.FMewBattle.NeedLevel > 1000 ? STRING_MAGIC.FORMAT_GetNatruePointsCopy : STRING_MAGIC.FORMAT_GetNatruePoints,_loc2_);
               EffectGenerateText(_loc1_);
            }
            this.FIsWin = false;
         }
      }
      
      public function LevelUpRequestData() : void
      {
         if(SLogicsCore.Character.GetMainLevel() == this.FMew_OpenLv)
         {
            this.PacketPerform_CS_InitEnergyReq();
         }
      }
   }
}

