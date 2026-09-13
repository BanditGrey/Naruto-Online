package Processors.Game.Lobby.Globalboss
{
   import Foundation.Common.THint;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.Tools.DynamicWordEffect;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TDafubenAward;
   import Logics.DatebaseVO.VO.TDafubenCondition;
   import Logics.Globalboss.TGlobalboss;
   import Logics.Globalboss.TGlobalbossChapter;
   import Logics.SLogicsCore;
   import Logics.Streamization.Globalboss.TUnstreamizerGlobalboss;
   import Processors.Game.Common.Effects.Display.TEffectBaseGlow;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import Resources.Constants.CONST_BATTLE;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_SHORTCUTS;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Strings.STRING_COMMON;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   
   public class TProcessorGlobalBoss extends TProcessorLobbyWindows
   {
      
      protected static const EXP_WIDTH:uint = 560;
      
      protected static const STAGE_NUM:uint = 11;
      
      protected static const EffectMulti_DelayTicks:int = 2000;
      
      protected var FEffectsBaseGlow:Vector.<TEffectBaseGlow>;
      
      protected var FProcessorGlobalbossRank:TProcessorGlobalbossRank;
      
      protected var FProcessorGlobalbossMall:TProcessorGlobalbossMall;
      
      protected var FUIGlobalBossStageVec:Vector.<TUIGlobalBossStage>;
      
      protected var FMainPanel:MovieClip;
      
      protected var FBTN_fight:MovieClip;
      
      protected var FBTN_chapter:MovieClip;
      
      protected var FBTN_rank:MovieClip;
      
      protected var FBTN_mail:MovieClip;
      
      protected var FBTN_deploy:MovieClip;
      
      protected var FBackground:Bitmap;
      
      protected var FBTN_Close:SimpleButton;
      
      protected var FBTN_Help:SimpleButton;
      
      protected var FBtn_Return:MovieClip;
      
      protected var FUnstreamizerGlobalboss:TUnstreamizerGlobalboss;
      
      protected var FGlobalboss:TGlobalboss;
      
      protected var FGlobalbossChapter:TGlobalbossChapter;
      
      protected var FCurGlobalboss:TGlobalboss;
      
      protected var FDafubenAwardBins:TBins;
      
      protected var FConditionBins:TBins;
      
      protected var FDafubenAwards:Vector.<TDafubenAward>;
      
      protected var FStarNumber:uint;
      
      protected var FIsEndPushText:Boolean;
      
      protected var FEffectTexts:Vector.<String>;
      
      protected var FEffDelayReferenceTick:int;
      
      protected var FStringID:int;
      
      protected var FSetStatusType:Function;
      
      protected var FOnInitBattle:Function;
      
      protected var FCurChapterId:int;
      
      public var GlobalbossChapterId:uint;
      
      public var GlobalbossLevel:uint;
      
      public var OnOpenGlobalbossChapter:Function;
      
      public var OnTacticalDeployment:Function;
      
      public var SetGlobalboss:Function;
      
      public var OnOpenGlobalbossMain:Function;
      
      public function TProcessorGlobalBoss(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FProcessorGlobalbossRank = new TProcessorGlobalbossRank(param1);
         this.FProcessorGlobalbossRank.OnRankInfoReq = this.PerformPacket_CS_Rank_Req;
         this.FProcessorGlobalbossRank.OnFetchReward = this.ProcessorOnFetchReward;
         this.FProcessorGlobalbossMall = new TProcessorGlobalbossMall(param1);
         this.FProcessorGlobalbossMall.OnMallBuy = this.ProcessorOnMallBuy;
         this.FUnstreamizerGlobalboss = new TUnstreamizerGlobalboss();
         this.FUIGlobalBossStageVec = new Vector.<TUIGlobalBossStage>(STAGE_NUM);
         this.FEffectTexts = new Vector.<String>();
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(4076863489);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.FMainPanel = TUtilityReflection.CreateDisplayObjectInstance("MC_globalboss") as MovieClip;
         addChild(this.FMainPanel);
         this.ConstructGlowFilter();
         this.FBackground = new Bitmap();
         this.FMainPanel.mc_pos.addChild(this.FBackground);
         this.FBTN_fight = this.FMainPanel.Btn_fight;
         TGameUtil.setButtonMode(this.FBTN_fight,true);
         this.FBTN_chapter = this.FMainPanel.Btn_chapter;
         TGameUtil.setButtonMode(this.FBTN_chapter,true);
         this.FBTN_rank = this.FMainPanel.Btn_rank;
         TGameUtil.setButtonMode(this.FBTN_rank,true);
         this.FBTN_mail = this.FMainPanel.Btn_mail;
         TGameUtil.setButtonMode(this.FBTN_mail,true);
         this.FBTN_deploy = this.FMainPanel.Btn_deploy;
         TGameUtil.setButtonMode(this.FBTN_deploy,true);
         this.FBTN_Close = this.FMainPanel.BTN_Close;
         this.FBTN_Help = this.FMainPanel.BTN_Help;
         this.FBtn_Return = this.FMainPanel.Btn_return;
         TGameUtil.setButtonMode(this.FBtn_Return,true);
         this.FDafubenAwardBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_DafubenAward);
         this.FConditionBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_DafubenCondition);
         this.FMainPanel.x = (FUICore.StageWidth - this.FMainPanel.width) / 2;
         this.FMainPanel.y = (FUICore.StageHeight - this.FMainPanel.height) / 2;
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            this.FMainPanel["MC_Box_" + _loc1_].addEventListener(MouseEvent.CLICK,this.ProcessorOnBoxClick);
            this.FMainPanel["MC_Box_" + _loc1_].addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnTipsOver);
            this.FMainPanel["MC_Box_" + _loc1_].addEventListener(MouseEvent.MOUSE_OUT,this.ProcessorOnTipsOut);
            _loc1_++;
         }
         this.FBTN_fight.addEventListener(MouseEvent.CLICK,this.StartFight);
         this.FBTN_Close.addEventListener(MouseEvent.CLICK,this.OnWindowClose);
         this.FBTN_chapter.addEventListener(MouseEvent.CLICK,this.OnOpenChapter);
         this.FBTN_mail.addEventListener(MouseEvent.CLICK,this.OnBTNShopClick);
         this.FBTN_rank.addEventListener(MouseEvent.CLICK,this.BtnRankOnClick);
         this.FBTN_deploy.addEventListener(MouseEvent.CLICK,this.OnDeployClick);
         this.FBtn_Return.addEventListener(MouseEvent.CLICK,this.OnBtnReturn);
         this.FBTN_Help.addEventListener(MouseEvent.MOUSE_OVER,this.OnHelpOver);
         this.FBTN_Help.addEventListener(MouseEvent.MOUSE_OUT,this.OnHelpOut);
         super.ResourcesPerform_UILocations();
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_GlobalBoss_Info_Ret,this.PerformPacket_SC_Info_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_GlobalBoss_Reward_Ret,this.PerformPacket_SC_Reward_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_GlobalBoss_Fight_Ret,this.PerformPacket_SC_Fight_Ret);
      }
      
      protected function SetGlobalBossStageUI(param1:TGlobalboss) : void
      {
         var _loc2_:TUIGlobalBossStage = null;
         var _loc3_:int = 0;
         this.FStarNumber = 0;
         this.HideUIStage();
         this.onStageSelect(param1.Current);
         while(param1)
         {
            if(this.FUIGlobalBossStageVec[_loc3_] == null)
            {
               _loc2_ = new TUIGlobalBossStage();
               this.FUIGlobalBossStageVec[_loc3_] = _loc2_;
               _loc2_.DispatchRes(this.FMainPanel,param1);
               _loc2_.SetStage(param1);
               _loc2_.onStageSelectFunc = this.onStageSelect;
               _loc2_.onStartFight = this.StartFight;
            }
            else
            {
               this.FUIGlobalBossStageVec[_loc3_].SetStage(param1);
            }
            this.FStarNumber += param1.starNum;
            param1 = param1.Next;
            _loc3_++;
         }
         this.UpdateProgressBar(this.FStarNumber);
         this.AddGlobalbossGlowFilter();
      }
      
      protected function ConstructGlowFilter() : void
      {
         var _loc1_:TEffectBaseGlow = null;
         var _loc2_:int = 0;
         var _loc3_:int = 3;
         if(this.FEffectsBaseGlow == null)
         {
            this.FEffectsBaseGlow = new Vector.<TEffectBaseGlow>();
            _loc2_ = 0;
            while(_loc2_ < _loc3_)
            {
               _loc1_ = new TEffectBaseGlow();
               _loc1_.SetParameters(this.FMainPanel["MC_Box_" + _loc2_],15911245,1);
               this.FEffectsBaseGlow.push(_loc1_);
               _loc2_++;
            }
         }
      }
      
      protected function PerformPacket_SC_Info_Ret(param1:TPacket) : void
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
         this.FUnstreamizerGlobalboss.UnstreamizationPerformNew(_loc2_,null,null);
         this.FGlobalboss = this.GlobalbossLevel == 1 ? SLogicsCore.Globalboss : SLogicsCore.GlobalbossNew;
         this.SetGlobalBossStageUI(this.FGlobalboss);
      }
      
      protected function PerformPacket_CS_Info_Req(param1:int) : void
      {
         var _loc2_:TPacket = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_GlobalBoss_Info_Req);
         _loc2_.Data.writeInt(param1);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function PerformPacket_SC_Fight_Ret(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         _loc2_ = param1.Data;
         _loc3_ = int(_loc2_.readUnsignedInt());
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         this.FGlobalboss = this.GlobalbossLevel == 1 ? SLogicsCore.Globalboss : SLogicsCore.GlobalbossNew;
         this.FUnstreamizerGlobalboss.UnstreamizationPerformByIdentity(_loc2_,this.FGlobalboss,null);
         if(this.SetGlobalboss != null)
         {
            this.SetGlobalboss(this.FCurGlobalboss);
         }
         if(this.FSetStatusType != null)
         {
            this.FSetStatusType(this,CONST_BATTLE.BattleType_GlobalBoss,0);
         }
         if(this.FOnInitBattle != null)
         {
            this.FOnInitBattle(this);
         }
      }
      
      protected function PerformPacket_CS_Fight_Req(param1:int, param2:int) : void
      {
         var _loc3_:TPacket = null;
         _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_GlobalBoss_Fight_Req);
         _loc3_.Data.writeInt(param1);
         _loc3_.Data.writeInt(param2);
         SNetworkCore.Transceiver.PacketTransmit(_loc3_);
      }
      
      protected function PerformPacket_SC_Rank_Ret(param1:TPacket) : void
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
         this.FUnstreamizerGlobalboss.UnstreamizationGlobalbossRank(_loc2_,this.FProcessorGlobalbossRank.GlobalbossRanks,null);
         this.FProcessorGlobalbossRank.SingleRank = _loc2_.readInt();
         this.FProcessorGlobalbossRank.LastRank = _loc2_.readInt();
         this.FProcessorGlobalbossRank.RewardStatus = _loc2_.readInt();
         this.FProcessorGlobalbossRank.UpdateRankings();
         ProcessorOnCheckIconStatus(CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_GlobalBoss,this.FProcessorGlobalbossRank.RewardStatus == 0);
      }
      
      protected function PerformPacket_CS_Rank_Req() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_GlobalBoss_Rank_Req);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PerformPacket_SC_Rank_Reward_Ret(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:String = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         this.PerformPacket_CS_Rank_Req();
         _loc7_ = _loc2_.readShort();
         _loc9_ = "";
         _loc8_ = 0;
         while(_loc8_ < _loc7_)
         {
            _loc4_ = int(_loc2_.readUnsignedInt());
            _loc5_ = int(_loc2_.readUnsignedInt());
            _loc6_ = int(_loc2_.readUnsignedInt());
            _loc9_ = STRING_COMMON.GetItemNameByType(_loc4_,_loc5_) + "*" + _loc6_;
            this.FEffectTexts.push(_loc9_);
            _loc8_++;
         }
         this.FIsEndPushText = true;
      }
      
      protected function ProcessorOnFetchReward() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_GlobalBoss_Rank_Reward_Req);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PerformPacket_SC_Reward_Ret(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc4_ = _loc2_.readInt();
         _loc5_ = _loc2_.readInt();
         this.FGlobalbossChapter.rewardInfo[_loc5_ - 1].reward = 1;
         this.UpdateChapterReward();
      }
      
      protected function PerformPacket_CS_Reward_Req(param1:int, param2:int) : void
      {
         var _loc3_:TPacket = null;
         _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_GlobalBoss_Reward_Req);
         _loc3_.Data.writeInt(param1);
         _loc3_.Data.writeInt(param2);
         SNetworkCore.Transceiver.PacketTransmit(_loc3_);
      }
      
      protected function PerformPacket_CS_Chapter_Req() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_GlobalBoss_Chapter_Req);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function onStageSelect(param1:TGlobalboss) : void
      {
         var _loc2_:TDafubenCondition = null;
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:MovieClip = null;
         if(this.FCurGlobalboss == param1)
         {
            return;
         }
         this.AddGlobalbossGlowFilter(false);
         this.FCurGlobalboss = param1;
         _loc3_ = this.FCurGlobalboss.Dafuben.ConditionList;
         _loc5_ = 0;
         while(_loc5_ < _loc3_.length)
         {
            _loc4_ = int(_loc3_[_loc5_]);
            _loc2_ = this.FConditionBins.GetDatebaseByIdentifier(_loc4_) as TDafubenCondition;
            DynamicWordEffect.remove(this.FMainPanel["TF_Condition_" + _loc5_]);
            DynamicWordEffect.CreateWordEffect(this.FMainPanel["TF_Condition_" + _loc5_],_loc2_.Dec);
            _loc6_ = this.FMainPanel["star_" + _loc5_];
            if(this.FCurGlobalboss.PassIds.indexOf(_loc4_) >= 0)
            {
               _loc6_.gotoAndStop(1);
            }
            else
            {
               _loc6_.gotoAndStop(2);
            }
            _loc5_++;
         }
         this.FMainPanel.TF_FightPower.text = this.FCurGlobalboss.Dafuben.Bp.toString();
         this.FMainPanel.TF_stage.text = this.FCurGlobalboss.Dafuben.Name;
         this.AddGlobalbossGlowFilter();
      }
      
      protected function UpdateProgressBar(param1:uint) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:TextField = null;
         this.FDafubenAwards = this.getDafubenAwardsByChapter(this.FCurGlobalboss.Dafuben.Chapterid);
         _loc2_ = 0;
         while(_loc2_ < 3)
         {
            _loc3_ = this.FMainPanel["MC_Box_" + _loc2_].TF_Count;
            _loc3_.text = this.FDafubenAwards[_loc2_].Need.toString();
            _loc2_++;
         }
         this.FMainPanel.MC_Progress.MC_Bar.width = EXP_WIDTH * param1 / 30;
      }
      
      protected function HideUIStage() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         _loc1_ = 1;
         while(_loc1_ <= STAGE_NUM)
         {
            _loc2_ = this.FMainPanel["MC_stage_" + _loc1_];
            _loc2_.visible = false;
            _loc1_++;
         }
      }
      
      public function UpdateChapterReward() : void
      {
         var _loc1_:Object = null;
         var _loc2_:int = 0;
         if(this.FCurGlobalboss == null)
         {
            return;
         }
         this.FGlobalbossChapter = this.getGlobalbossChapterByChapter(this.FCurGlobalboss.Dafuben.Chapterid);
         if(this.FGlobalbossChapter == null)
         {
            return;
         }
         for each(_loc1_ in this.FGlobalbossChapter.rewardInfo)
         {
            _loc2_ = _loc1_.awardId - 1;
            if(_loc1_.reward == 0)
            {
               this.FEffectsBaseGlow[_loc2_].Run();
            }
            else
            {
               this.FEffectsBaseGlow[_loc2_].Stop();
            }
            if(_loc1_.reward == 1)
            {
               this.FMainPanel["MC_Box_" + _loc2_].gotoAndStop(2);
            }
            else
            {
               this.FMainPanel["MC_Box_" + _loc2_].gotoAndStop(1);
            }
         }
      }
      
      protected function AddGlobalbossGlowFilter(param1:Boolean = true) : void
      {
         if(Boolean(this.FCurGlobalboss) && Boolean(this.FCurGlobalboss.GlobalbossStage))
         {
            this.FCurGlobalboss.GlobalbossStage.AddGlowFilter(param1);
         }
      }
      
      protected function getDafubenAwardsByChapter(param1:int) : Vector.<TDafubenAward>
      {
         var _loc2_:TDafubenAward = null;
         var _loc3_:int = 0;
         var _loc4_:Vector.<TDafubenAward> = null;
         _loc4_ = new Vector.<TDafubenAward>();
         if(this.FDafubenAwardBins)
         {
            _loc3_ = 0;
            while(_loc3_ < this.FDafubenAwardBins.Count)
            {
               _loc2_ = this.FDafubenAwardBins.GetDatebaseByIndex(_loc3_) as TDafubenAward;
               if(_loc2_.Identifier == param1)
               {
                  _loc4_.push(_loc2_);
               }
               _loc3_++;
            }
         }
         return _loc4_;
      }
      
      protected function getGlobalbossChapterByChapter(param1:int) : TGlobalbossChapter
      {
         this.FGlobalbossChapter = this.GlobalbossLevel == 1 ? SLogicsCore.GlobalbossChapter : SLogicsCore.GlobalbossChapterNew;
         while(this.FGlobalbossChapter)
         {
            if(this.FGlobalbossChapter.Identity == param1)
            {
               return this.FGlobalbossChapter;
            }
            this.FGlobalbossChapter = this.FGlobalbossChapter.Next;
         }
         return null;
      }
      
      protected function StartFight(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(Boolean(this.FCurGlobalboss) && this.FCurGlobalboss.Status == 2)
         {
            EffectGenerateText(TUtilityString.GetText(CONST_SYSTEMLANGUAGE.STRING_Globalboss));
            return;
         }
         _loc2_ = this.FCurGlobalboss.Dafuben.Need > 0 ? 1 : 0;
         this.PerformPacket_CS_Fight_Req(this.FCurGlobalboss.stageId,_loc2_);
      }
      
      protected function ProcessorOnBoxClick(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:TDafubenAward = null;
         if(!this.FDafubenAwards)
         {
            return;
         }
         _loc2_ = int(param1.currentTarget.name.substr(7));
         _loc5_ = this.FDafubenAwards[_loc2_];
         _loc3_ = _loc5_.Identifier;
         _loc4_ = _loc5_.Awardid;
         this.PerformPacket_CS_Reward_Req(_loc3_,_loc4_);
      }
      
      protected function ProcessorOnTipsOver(param1:MouseEvent) : void
      {
         var _loc2_:THint = null;
         var _loc3_:int = 0;
         var _loc4_:TDafubenAward = null;
         if(!this.FDafubenAwards)
         {
            return;
         }
         _loc3_ = int(param1.currentTarget.name.substr(7));
         _loc4_ = this.FDafubenAwards[_loc3_];
         _loc2_ = new THint();
         _loc2_.Caption = TUtilityString.Format(_loc4_.Stardec,this.FStarNumber);
         if(ProcessorTipOnOver != null)
         {
            ProcessorTipOnOver(this,_loc2_);
         }
      }
      
      protected function ProcessorOnTipsOut(param1:MouseEvent) : void
      {
         if(ProcessorTipOnOut != null)
         {
            ProcessorTipOnOut(this);
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
      
      protected function OnOpenChapter(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(this.OnOpenGlobalbossChapter != null)
         {
            _loc2_ = int(this.GlobalbossLevel);
            this.OnOpenGlobalbossChapter(_loc2_);
         }
      }
      
      protected function OnDeployClick(param1:MouseEvent) : void
      {
         if(this.OnTacticalDeployment != null)
         {
            this.OnTacticalDeployment(null);
         }
      }
      
      protected function BtnRankOnClick(param1:MouseEvent) : void
      {
         this.FProcessorGlobalbossRank.Visible = true;
      }
      
      protected function OnBTNShopClick(param1:MouseEvent) : void
      {
         this.FProcessorGlobalbossMall.Visible = true;
         this.FProcessorGlobalbossMall.Update();
      }
      
      protected function OnHelpOver(param1:MouseEvent) : void
      {
         var _loc2_:THint = new THint();
         _loc2_.Content = TUtilityString.GetText(CONST_SYSTEMLANGUAGE.HELPTIPS_Globalboss);
         if(UIHelpTipsHintOnOver != null)
         {
            UIHelpTipsHintOnOver(this,_loc2_);
         }
      }
      
      protected function OnHelpOut(param1:MouseEvent) : void
      {
         if(UIHelpTipsHintOnOut != null)
         {
            UIHelpTipsHintOnOut(this);
         }
      }
      
      protected function OnWindowClose(param1:MouseEvent) : void
      {
         ProcessorClose();
         this.GlobalbossChapterId = 0;
      }
      
      protected function OnBtnReturn(param1:MouseEvent) : void
      {
         if(this.OnOpenGlobalbossMain != null)
         {
            this.OnOpenGlobalbossMain();
         }
      }
      
      protected function LogicsPerform_EffectText() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         var _loc6_:String = null;
         var _loc7_:String = null;
         _loc6_ = "";
         _loc4_ = "";
         if(this.FIsEndPushText)
         {
            if(this.FEffectTexts.length == 0)
            {
               return;
            }
            this.FStringID = CONST_SYSTEMLANGUAGE.BACKPACK_FORMAT_02;
            _loc2_ = int(this.FEffectTexts.length);
            _loc3_ = 10;
            _loc5_ = STimingCore.TickCount - this.FEffDelayReferenceTick;
            if(_loc5_ < EffectMulti_DelayTicks)
            {
               return;
            }
            _loc7_ = TUtilityString.GetText(this.FStringID);
            _loc6_ = _loc7_.split("\\n")[0] + "\n";
            _loc1_ = 0;
            while(_loc1_ < _loc3_)
            {
               if(_loc2_ <= _loc1_)
               {
                  break;
               }
               _loc4_ += this.FEffectTexts.shift();
               _loc4_ = _loc4_ + "\n";
               _loc1_++;
            }
            _loc6_ += _loc4_;
            this.FEffDelayReferenceTick = STimingCore.TickCount;
            EffectGenerateText(_loc6_);
         }
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
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:TEffectBaseGlow = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(this.FEffectsBaseGlow)
         {
            _loc3_ = int(this.FEffectsBaseGlow.length);
            _loc2_ = 0;
            while(_loc2_ < _loc3_)
            {
               _loc1_ = this.FEffectsBaseGlow[_loc2_];
               if(_loc1_.IsRunOver)
               {
                  _loc1_.Run();
               }
               _loc2_++;
            }
         }
         if(this.FCurGlobalboss)
         {
            TGameUtil.ShowImageByID(TGameUtil.Type_Dafuben,this.FBackground,CONST_MODULES.MODULE_Dafuben,this.FCurGlobalboss.Dafuben.Uiid);
         }
         this.LogicsPerform_EffectText();
         super.LogicsPerform();
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount();
         if(param1 != null)
         {
            this.FCurChapterId = param1.readUnsignedInt();
         }
         if(!FIsResourcesLoadCompleted)
         {
            this.FProcessorGlobalbossMall.Load();
            this.FProcessorGlobalbossRank.Load();
            return;
         }
         this.PerformPacket_CS_Info_Req(this.FCurChapterId);
         this.PerformPacket_CS_Chapter_Req();
         this.PerformPacket_CS_Rank_Req();
      }
   }
}

