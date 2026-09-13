package Processors.Game.Lobby.WorldMatch
{
   import Foundation.Common.TCoordinate;
   import Foundation.Common.THint;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TArticle;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.DatebaseVO.VO.TGlobalArena;
   import Logics.SLogicsCore;
   import Logics.Streamization.WorldMatch.TUnstreamizerWorldMatch;
   import Logics.WorldMatch.TWorldMatch;
   import Logics.WorldMatch.TWorldMatchPlayerInfo;
   import Processors.Game.Common.Effects.Display.TEffectBaseGlow;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyPlate;
   import Processors.Game.Lobby.WorldMatch.Component.TUIWorldMatchHero;
   import Processors.Game.Windows.Information.TUIWindowBattleSkip;
   import Processors.Game.Windows.Information.TUIWindowConfirmation;
   import Rendering.Overlayers.HelpTips.TOverlayerHelpTips;
   import Rendering.Overlayers.Hints.TOverlayerHint;
   import Resources.Constants.CONST_BATTLE;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_CONFIGVALUE;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_SHORTCUTS;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Constants.CONST_WORLDMATCH;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   import flash.utils.setTimeout;
   
   public class TProcessorWorldMatch extends TProcessorLobbyPlate
   {
      
      protected var FScene:MovieClip;
      
      protected var FTF_WinCount:TextField;
      
      protected var FTF_CurRanking:TextField;
      
      protected var FTF_CurTimes:TextField;
      
      protected var FTF_PlayerName:TextField;
      
      protected var FUIWorldMatchHeros:Vector.<TUIWorldMatchHero>;
      
      protected var FWorldMatchPlayerInfo:TWorldMatchPlayerInfo;
      
      protected var FGlobalArenaBins:TBins;
      
      protected var FArticleBins:TBins;
      
      protected var FProcessorWorldMatchMall:TProcessorWorldMatchMall;
      
      protected var FProcessorWorldMatchRank:TProcessorWorldMatchRank;
      
      protected var FProcessorWorldMatchReport:TProcessorWorldMatchReport;
      
      protected var FProcessorWorldMatchHeroInfo:TProcessorWorldMatchHeroInfo;
      
      protected var FUIWindowConfirmation:TUIWindowConfirmation;
      
      protected var FUIWindowBattleSkip:TUIWindowBattleSkip;
      
      protected var FAddCountCost:Vector.<uint>;
      
      protected var FBuyCnt:int;
      
      protected var FOverlayerHint:TOverlayerHint;
      
      protected var FOverlayerHelpTips:TOverlayerHelpTips;
      
      protected var FHint:THint;
      
      protected var FUnstreamizerWorldMatch:TUnstreamizerWorldMatch;
      
      protected var FWorldMatch:TWorldMatch;
      
      protected var FEffectGlow:TEffectBaseGlow;
      
      protected var FEffectGlowBox:TEffectBaseGlow;
      
      protected var FOnReturnMainScene:Function;
      
      protected var FSetStatusType:Function;
      
      protected var FOnInitBattle:Function;
      
      protected var FOnSetChatOptions:Function;
      
      protected var FOnOpenWorldMatchStreak:Function;
      
      public function TProcessorWorldMatch(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FProcessorWorldMatchMall = new TProcessorWorldMatchMall(param1);
         this.FProcessorWorldMatchMall.OnMallBuy = this.ProcessorOnMallBuy;
         this.FProcessorWorldMatchRank = new TProcessorWorldMatchRank(param1);
         this.FProcessorWorldMatchHeroInfo = new TProcessorWorldMatchHeroInfo(param1);
         this.FUnstreamizerWorldMatch = new TUnstreamizerWorldMatch();
         this.FUIWorldMatchHeros = new Vector.<TUIWorldMatchHero>(CONST_WORLDMATCH.CAPACITY_Heros);
         this.FWorldMatch = SLogicsCore.WorldMatch;
         this.FHint = new THint();
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_WORLDMATCH.RESOURCESID_Swf_WorldMatch);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TUIWorldMatchHero = null;
         var _loc4_:TConfigValue = null;
         this.FScene = TUtilityReflection.CreateDisplayObjectInstance(CONST_WORLDMATCH.RESOURCE_ClassName_WorldMatch) as MovieClip;
         addChild(this.FScene);
         this.FProcessorWorldMatchReport = new TProcessorWorldMatchReport(this,this.FScene.MC_Report);
         _loc1_ = int(CONST_WORLDMATCH.CAPACITY_Heros);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = new TUIWorldMatchHero(this,_loc2_);
            _loc3_.Resource = this.FScene["MC_Hero_" + _loc2_] as MovieClip;
            _loc3_.LookHeroInfoOnClick = this.ProcessorLookHeroInfoOnClick;
            _loc3_.RoleOnClick = this.ProcessorRoleOnClick;
            _loc3_.Init();
            this.FUIWorldMatchHeros[_loc2_] = _loc3_;
            _loc2_++;
         }
         this.FUIWindowConfirmation = new TUIWindowConfirmation(this);
         this.FUIWindowConfirmation.OnOK = this.OnAddTimes;
         this.FUIWindowConfirmation.x = (CONST_COMMON.STAGE_Width - this.FUIWindowConfirmation.WindowWidth) / 2;
         this.FUIWindowConfirmation.y = (CONST_COMMON.STAGE_Height - this.FUIWindowConfirmation.WindowHeight) / 2 - 20;
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowConfirmation);
         this.FTF_CurRanking = this.FScene.MC_BasicInfo.TF_CurRanking;
         this.FTF_WinCount = this.FScene.MC_BasicInfo.TF_WinCount;
         this.FScene.btn_getReward.addEventListener(MouseEvent.CLICK,this.OnGetReward);
         this.FScene.btn_getReward.addEventListener(MouseEvent.MOUSE_MOVE,this.OnMouseMove);
         this.FScene.btn_getReward.addEventListener(MouseEvent.MOUSE_OUT,this.OnMouseOut);
         TGameUtil.setButtonMode(this.FScene.BTN_Shop,true);
         this.FScene.BTN_Shop.addEventListener(MouseEvent.CLICK,this.OnBTNShopClick);
         TGameUtil.setButtonMode(this.FScene.BTN_Ranking,true);
         this.FScene.BTN_Ranking.addEventListener(MouseEvent.CLICK,this.BtnRankOnClick);
         this.FTF_PlayerName = this.FScene.MC_BasicInfo.tf_playerName;
         this.FTF_PlayerName.text = SLogicsCore.Character.NickName;
         this.FTF_CurTimes = this.FScene.MC_BasicInfo.TF_CurTimes;
         this.FScene.MC_BasicInfo.btn_addCurTimes.addEventListener(MouseEvent.CLICK,this.OnClickAddTimes);
         TGameUtil.setButtonMode(this.FScene.MC_BasicInfo.btn_addCurTimes,true);
         this.FScene.BTN_Help.addEventListener(MouseEvent.MOUSE_OVER,this.OnHelpButtonOver);
         this.FScene.BTN_Help.addEventListener(MouseEvent.MOUSE_OUT,this.OnHelpButtonOut);
         this.FScene.BTN_Close.addEventListener(MouseEvent.CLICK,this.CloseOnClick);
         this.FOverlayerHint = new TOverlayerHint(this);
         this.FOverlayerHint.Visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerHint);
         this.FOverlayerHelpTips = new TOverlayerHelpTips(this);
         this.FOverlayerHelpTips.Visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerHelpTips);
         TGameUtil.setButtonMode(this.FScene.BTN_gotoward,true);
         this.FScene.BTN_gotoward.addEventListener(MouseEvent.CLICK,this.OnOpenStreak);
         if(this.FEffectGlow == null)
         {
            this.FEffectGlow = new TEffectBaseGlow();
            this.FEffectGlow.SetParameters(this.FScene.BTN_gotoward,15911245,1);
         }
         if(this.FEffectGlowBox == null)
         {
            this.FEffectGlowBox = new TEffectBaseGlow();
            this.FEffectGlowBox.SetParameters(this.FScene.btn_getReward,15911245,1);
         }
         this.FUIWindowBattleSkip = new TUIWindowBattleSkip(this);
         this.FUIWindowBattleSkip.Perform_UIDispatch();
         this.FUIWindowBattleSkip.OnOK = this.OnConfirmationOk;
         this.FUIWindowBattleSkip.OnCancel = this.OnWindowCancel;
         this.FGlobalArenaBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_GlobalArena);
         this.FArticleBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.WorldMatch_AddCost) as TConfigValue;
         this.FAddCountCost = _loc4_.Value as Vector.<uint>;
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_WorldMatch_Info,this.PerformPacket_SC_Info);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_WorldMatch_Battle,this.PerformPacket_SC_Battle);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_WorldMatch_Rank,this.PerformPacket_SC_Rank);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_WorldMatch_Buy,this.PerformPacket_SC_Buy);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_WorldMatch_Reward,this.PerformPacket_SC_Reward);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_WorldMatch_UserInfo,this.PerformPacket_SC_UserInfo);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_WorldMatch_AddCount,this.PerformPacket_SC_AddCount);
      }
      
      protected function UpdateRoleRankingUI() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TWorldMatchPlayerInfo = null;
         var _loc4_:Vector.<TWorldMatchPlayerInfo> = null;
         var _loc5_:TUIWorldMatchHero = null;
         _loc2_ = CONST_WORLDMATCH.CAPACITY_Heros;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc5_ = this.FUIWorldMatchHeros[_loc1_];
            _loc5_.Resource.visible = false;
            _loc5_.Context = null;
            _loc1_++;
         }
         _loc4_ = this.FWorldMatch.WorldMatchPlayerInfos;
         _loc2_ = _loc4_.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = _loc4_[_loc1_] as TWorldMatchPlayerInfo;
            _loc5_ = this.FUIWorldMatchHeros[_loc1_];
            _loc5_.Resource.visible = true;
            _loc5_.Context = _loc3_;
            _loc5_.Update();
            _loc1_++;
         }
      }
      
      protected function UpdateBox() : void
      {
         var _loc1_:TGlobalArena = null;
         var _loc2_:int = 1;
         _loc1_ = this.GetGlobalArenaByRanking(this.FWorldMatch.SelfRank);
         if(_loc1_)
         {
            _loc2_ = _loc1_.Quality;
         }
         this.FScene.btn_getReward.mc_box.gotoAndStop(_loc2_);
         this.FScene.btn_getReward.mc_boxget.gotoAndStop(_loc2_);
      }
      
      protected function PerformPacket_SC_Info(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         this.FTF_CurTimes.text = _loc2_.readInt().toString();
         this.FTF_WinCount.text = _loc2_.readInt().toString();
         this.FBuyCnt = _loc2_.readInt();
         if(SLogicsCore.Character.MainHero.ReincarnationOneOrTwo > 2)
         {
            this.FScene.gotoAndStop(2);
         }
         else
         {
            this.FScene.gotoAndStop(1);
         }
         this.FUnstreamizerWorldMatch.UnstreamizerWorldMatchReport(_loc2_,this.FWorldMatch.WorldMatchReports,null);
         this.FProcessorWorldMatchReport.UpdateReportInfo(this.FWorldMatch.WorldMatchReports);
      }
      
      protected function PerformPacket_CS_Info() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_WorldMatch_Info);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PerformPacket_SC_Battle(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         if(this.FSetStatusType != null)
         {
            this.FSetStatusType(this,CONST_BATTLE.BattleType_WorldMatch,0);
         }
         if(this.FOnInitBattle != null)
         {
            this.FOnInitBattle(this);
         }
      }
      
      protected function PerformPacket_CS_Battle(param1:uint, param2:uint) : void
      {
         var _loc3_:TPacket = null;
         var _loc4_:ByteArray = null;
         _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_WorldMatch_Battle);
         _loc4_ = _loc3_.Data;
         _loc4_.writeUnsignedInt(param1);
         _loc4_.writeUnsignedInt(param2);
         SNetworkCore.Transceiver.PacketTransmit(_loc3_);
      }
      
      protected function PerformPacket_SC_Reward(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         EffectGenerateText(TUtilityString.GetText(CONST_SYSTEMLANGUAGE.STRING_GlobalBattle_01));
      }
      
      protected function PerformPacket_SC_Rank(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         this.FUnstreamizerWorldMatch.Unstreamize(_loc2_,this.FWorldMatch,null);
         this.FProcessorWorldMatchRank.Visible = true;
         this.FProcessorWorldMatchRank.UpdateRankings();
         this.FTF_CurRanking.text = _loc2_.readInt().toString();
      }
      
      protected function PerformPacket_CS_Rank() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_WorldMatch_Rank);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PerformPacket_SC_Buy(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         this.FProcessorWorldMatchMall.UpdateNinjaPointUI();
      }
      
      protected function PerformPacket_SC_UserInfo(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:int = 0;
         _loc2_ = param1.Data;
         this.FUnstreamizerWorldMatch.UnstreamizeInquirePlayerInfo(_loc2_,this.FWorldMatch,null);
         if(FIsResourcesLoadCompleted)
         {
            this.UpdateRoleRankingUI();
            this.UpdateBox();
            this.FTF_CurRanking.text = this.FWorldMatch.SelfRank.toString();
         }
         _loc4_ = this.FWorldMatch.RewardConditon;
         _loc4_ = _loc4_ & int(this.IfDuringAwardPeriod());
         ProcessorOnCheckIconStatus(CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_WorldMatch,Boolean(_loc4_));
         this.UpdateEffectGlowFilter(Boolean(_loc4_),this.FEffectGlowBox);
      }
      
      protected function PerformPacket_CS_UserInfo() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_WorldMatch_UserInfo);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PerformPacket_SC_AddCount(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         _loc2_ = param1.Data;
         _loc3_ = uint(_loc2_.readInt());
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         this.FTF_CurTimes.text = _loc2_.readInt().toString();
         this.FBuyCnt = _loc2_.readInt();
      }
      
      protected function PerformPacket_CS_WorldMatchStreak_Info() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_WorldMatchStreak_Info);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function GetGlobalArenaByRanking(param1:uint) : TGlobalArena
      {
         var _loc2_:uint = 0;
         var _loc3_:TGlobalArena = null;
         _loc2_ = 0;
         while(_loc2_ < this.FGlobalArenaBins.Count)
         {
            _loc3_ = this.FGlobalArenaBins.GetDatebaseByIndex(_loc2_) as TGlobalArena;
            if(param1 >= _loc3_.From && param1 <= _loc3_.To)
            {
               if(SLogicsCore.Character.MainHero.ReincarnationOneOrTwo > 2 && _loc3_.Battletype == 1)
               {
                  return _loc3_;
               }
               if(SLogicsCore.Character.MainHero.ReincarnationOneOrTwo <= 2 && _loc3_.Battletype == 2)
               {
                  return _loc3_;
               }
            }
            _loc2_++;
         }
         return null;
      }
      
      protected function OnGetReward(param1:MouseEvent) : void
      {
         var _loc2_:TPacket = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_WorldMatch_Reward);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function OnMouseMove(param1:MouseEvent) : void
      {
         var _loc2_:TGlobalArena = null;
         var _loc4_:TArticle = null;
         var _loc5_:int = 0;
         var _loc6_:Object = null;
         var _loc3_:String = "";
         _loc2_ = this.GetGlobalArenaByRanking(this.FWorldMatch.SelfRank);
         if(!_loc2_)
         {
            return;
         }
         _loc5_ = 0;
         while(_loc5_ < _loc2_.RewardArr.length)
         {
            _loc6_ = _loc2_.RewardArr[_loc5_];
            _loc4_ = this.FArticleBins.GetDatebaseByIdentifier(_loc6_.code) as TArticle;
            _loc3_ += _loc4_.Name + "*" + _loc6_.amount + "\n";
            _loc5_++;
         }
         this.FHint.Caption = _loc3_;
         this.FOverlayerHint.Context = this.FHint;
         this.FOverlayerHint.Render(FUICore.MouseCoordinate);
         this.FOverlayerHint.Show();
      }
      
      protected function OnMouseOut(param1:MouseEvent) : void
      {
         this.FOverlayerHint.Hide();
         param1.currentTarget.gotoAndStop(1);
      }
      
      protected function OnClickAddTimes(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         try
         {
            this.FUIWindowConfirmation.Text = TUtilityString.Format(TUtilityString.GetText(CONST_SYSTEMLANGUAGE.STRING_WorldMatch_01),this.FAddCountCost[this.FBuyCnt]);
            this.FUIWindowConfirmation.Visible = true;
         }
         catch(error:Error)
         {
            EffectGenerateText(TUtilityString.GetText(CONST_SYSTEMLANGUAGE.STRING_WorldMatch_02));
         }
      }
      
      protected function BtnRankOnClick(param1:MouseEvent) : void
      {
         this.PerformPacket_CS_Rank();
         this.FProcessorWorldMatchRank.Mount();
      }
      
      protected function OnBTNShopClick(param1:MouseEvent) : void
      {
         this.FProcessorWorldMatchMall.Visible = true;
         this.FProcessorWorldMatchMall.Update();
      }
      
      protected function OnHelpButtonOver(param1:MouseEvent) : void
      {
         this.FHint.Content = TUtilityString.GetText(CONST_SYSTEMLANGUAGE.HELPTIPS_WorldMatch);
         this.FOverlayerHelpTips.Context = this.FHint;
         this.FOverlayerHelpTips.Render(FUICore.MouseCoordinate);
         this.FOverlayerHelpTips.Show();
      }
      
      protected function OnHelpButtonOut(param1:MouseEvent) : void
      {
         this.FOverlayerHelpTips.Hide();
      }
      
      protected function OnOpenStreak(param1:MouseEvent) : void
      {
         if(this.OnOpenWorldMatchStreak != null)
         {
            this.OnOpenWorldMatchStreak();
         }
      }
      
      protected function CloseOnClick(param1:MouseEvent) : void
      {
         if(this.FOnReturnMainScene != null)
         {
            this.FOnReturnMainScene(this);
         }
      }
      
      protected function ProcessorLookHeroInfoOnClick(param1:Object, param2:Object, param3:Object) : void
      {
         var _loc4_:TCoordinate = null;
         var _loc5_:TWorldMatchPlayerInfo = null;
         var _loc6_:TPacket = null;
         var _loc7_:ByteArray = null;
         _loc4_ = param3 as TCoordinate;
         _loc5_ = param2 as TWorldMatchPlayerInfo;
         this.FProcessorWorldMatchHeroInfo.Update(_loc5_);
         this.FProcessorWorldMatchHeroInfo.SetPosition(_loc4_.X,_loc4_.Y);
      }
      
      protected function ProcessorRoleOnClick(param1:Object, param2:Object) : void
      {
         var _loc3_:TWorldMatchPlayerInfo = null;
         this.FWorldMatchPlayerInfo = param2 as TWorldMatchPlayerInfo;
         if(!this.FUIWindowBattleSkip.IsSelected)
         {
            this.FUIWindowBattleSkip.Visible = true;
         }
         else
         {
            this.PerformPacket_CS_Battle(this.FWorldMatchPlayerInfo.Identifier0,this.FWorldMatchPlayerInfo.Identifier1);
         }
      }
      
      protected function ProcessorOnMallBuy(param1:Object, param2:uint, param3:uint) : void
      {
         var _loc4_:TPacket = null;
         var _loc5_:ByteArray = null;
         _loc4_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_WorldMatch_Buy);
         _loc5_ = _loc4_.Data;
         _loc5_.writeUnsignedInt(param3);
         _loc5_.writeUnsignedInt(param2);
         SNetworkCore.Transceiver.PacketTransmit(_loc4_);
      }
      
      protected function OnAddTimes(param1:Object) : void
      {
         var _loc2_:TPacket = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_WorldMatch_AddCount);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function OnConfirmationOk(param1:Object) : void
      {
         this.FUIWindowBattleSkip.SetBattleSkipStatus(true,CONST_BATTLE.BattleType_WorldMatch);
         this.PerformPacket_CS_Battle(this.FWorldMatchPlayerInfo.Identifier0,this.FWorldMatchPlayerInfo.Identifier1);
      }
      
      protected function OnWindowCancel(param1:Object) : void
      {
         this.FUIWindowBattleSkip.SetBattleSkipStatus(false,CONST_BATTLE.BattleType_WorldMatch);
         this.PerformPacket_CS_Battle(this.FWorldMatchPlayerInfo.Identifier0,this.FWorldMatchPlayerInfo.Identifier1);
      }
      
      public function UpdateEffectGlowFilter(param1:Boolean, param2:TEffectBaseGlow = null) : void
      {
         if(param2 == null)
         {
            param2 = this.FEffectGlow;
         }
         if(param1)
         {
            param2 && param2.Run();
         }
         else
         {
            param2 && param2.Stop();
         }
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         if(Boolean(this.FEffectGlow) && this.FEffectGlow.IsRunOver)
         {
            this.FEffectGlow.Run();
         }
         if(Boolean(this.FEffectGlowBox) && this.FEffectGlowBox.IsRunOver)
         {
            this.FEffectGlowBox.Run();
         }
      }
      
      public function set OnReturnMainScene(param1:Function) : void
      {
         this.FOnReturnMainScene = param1;
      }
      
      public function get OnInitBattle() : Function
      {
         return this.FOnInitBattle;
      }
      
      public function set OnInitBattle(param1:Function) : void
      {
         this.FOnInitBattle = param1;
      }
      
      public function set SetStatusType(param1:Function) : void
      {
         this.FSetStatusType = param1;
      }
      
      public function get SetStatusType() : Function
      {
         return this.FSetStatusType;
      }
      
      public function get OnSetChatOptions() : Function
      {
         return this.FOnSetChatOptions;
      }
      
      public function set OnSetChatOptions(param1:Function) : void
      {
         this.FOnSetChatOptions = param1;
      }
      
      public function set OnOpenWorldMatchStreak(param1:Function) : void
      {
         this.FOnOpenWorldMatchStreak = param1;
      }
      
      public function get OnOpenWorldMatchStreak() : Function
      {
         return this.FOnOpenWorldMatchStreak;
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount();
         if(!FIsResourcesLoadCompleted)
         {
            this.FProcessorWorldMatchRank.Load();
            this.FProcessorWorldMatchMall.Load();
            this.FProcessorWorldMatchHeroInfo.Load();
            return;
         }
         this.PerformPacket_CS_Info();
         this.PerformPacket_CS_UserInfo();
         this.PerformPacket_CS_WorldMatchStreak_Info();
         setTimeout(this.CloseChat,50);
      }
      
      override public function Unmount() : void
      {
         super.Unmount();
         if(this.OnSetChatOptions != null)
         {
            this.OnSetChatOptions(this,true);
         }
      }
      
      protected function CloseChat() : void
      {
         if(this.OnSetChatOptions != null)
         {
            this.OnSetChatOptions(this,false);
         }
      }
      
      public function IfEnterWorldMatch() : Boolean
      {
         var _loc1_:Date = new Date(STimingCore.GetServerTime() * 1000);
         var _loc2_:Number = _loc1_.getDate();
         if(_loc2_ >= 2 && _loc2_ <= 13 || _loc2_ >= 17 && _loc2_ <= 28)
         {
            return true;
         }
         EffectGenerateText(TUtilityString.GetText(CONST_SYSTEMLANGUAGE.STRING_WorldMatch_03));
         return false;
      }
      
      public function IfDuringAwardPeriod() : Boolean
      {
         var _loc1_:Date = new Date(STimingCore.GetServerTime() * 1000);
         var _loc2_:Number = _loc1_.getDate();
         if(_loc2_ >= 12 && _loc2_ <= 13 || _loc2_ >= 27 && _loc2_ <= 28)
         {
            return true;
         }
         return false;
      }
   }
}

