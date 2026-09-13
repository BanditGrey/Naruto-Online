package Processors.Game.Lobby.Globalboss
{
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
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.DatebaseVO.VO.TDafubenAward;
   import Logics.Globalboss.TGlobalboss;
   import Logics.Globalboss.TGlobalbossChapter;
   import Logics.Streamization.Globalboss.TUnstreamizerGlobalboss;
   import Processors.Game.Common.Effects.Display.TEffectBaseGlow;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import Resources.Constants.CONST_CONFIGVALUE;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_SHORTCUTS;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_SHORTCUTS;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   
   public class TProcessorGlobalBossMain extends TProcessorLobbyWindows
   {
      
      protected static const EXP_WIDTH:uint = 560;
      
      protected static const STAGE_NUM:uint = 11;
      
      protected static const EffectMulti_DelayTicks:int = 2000;
      
      protected var FEffectsBaseGlow:Vector.<TEffectBaseGlow>;
      
      protected var FProcessorGlobalbossRank:TProcessorGlobalbossRank;
      
      protected var FMainPanel:MovieClip;
      
      protected var FBTN_chapter:MovieClip;
      
      protected var FBTN_chapterNew:MovieClip;
      
      protected var FBTN_rank:MovieClip;
      
      protected var FBackground:Bitmap;
      
      protected var FBTN_Close:SimpleButton;
      
      protected var FBTN_Help:SimpleButton;
      
      protected var FUnstreamizerGlobalboss:TUnstreamizerGlobalboss;
      
      protected var FGlobalboss:TGlobalboss;
      
      protected var FGlobalbossChapter:TGlobalbossChapter;
      
      protected var FCurGlobalboss:TGlobalboss;
      
      protected var FDafubenAwardBins:TBins;
      
      protected var FConditionBins:TBins;
      
      protected var FDafubenAwards:Vector.<TDafubenAward>;
      
      protected var FStarNumber:uint;
      
      protected var FDafubenShield:int;
      
      protected var FIsEndPushText:Boolean;
      
      protected var FEffectTexts:Vector.<String>;
      
      protected var FEffDelayReferenceTick:int;
      
      protected var FStringID:int;
      
      protected var FSetStatusType:Function;
      
      protected var FOnInitBattle:Function;
      
      public var OnOpenGlobalboss:Function;
      
      public function TProcessorGlobalBossMain(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FProcessorGlobalbossRank = new TProcessorGlobalbossRank(param1);
         this.FProcessorGlobalbossRank.OnRankInfoReq = this.PerformPacket_CS_Rank_Req;
         this.FProcessorGlobalbossRank.OnFetchReward = this.ProcessorOnFetchReward;
         this.FUnstreamizerGlobalboss = new TUnstreamizerGlobalboss();
         this.FEffectTexts = new Vector.<String>();
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(4076863489);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:TConfigValue = null;
         this.FMainPanel = TUtilityReflection.CreateDisplayObjectInstance("MC_globalbossMain") as MovieClip;
         addChild(this.FMainPanel);
         this.FBackground = new Bitmap();
         this.FMainPanel.mc_pos.addChild(this.FBackground);
         this.FBTN_chapterNew = this.FMainPanel.Btn_chapterNew;
         TGameUtil.setButtonMode(this.FBTN_chapterNew,true);
         this.FBTN_chapter = this.FMainPanel.Btn_chapter;
         TGameUtil.setButtonMode(this.FBTN_chapter,true);
         this.FBTN_rank = this.FMainPanel.Btn_rank;
         TGameUtil.setButtonMode(this.FBTN_rank,true);
         this.FBTN_Close = this.FMainPanel.BTN_Close;
         this.FBTN_Help = this.FMainPanel.BTN_Help;
         this.FDafubenAwardBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_DafubenAward);
         this.FConditionBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_DafubenCondition);
         this.FMainPanel.x = (FUICore.StageWidth - this.FMainPanel.width) / 2;
         this.FMainPanel.y = (FUICore.StageHeight - this.FMainPanel.height) / 2;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.Dafuben_Shield) as TConfigValue;
         this.FDafubenShield = _loc1_.Value as int;
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FBTN_Close.addEventListener(MouseEvent.CLICK,this.OnWindowClose);
         this.FBTN_rank.addEventListener(MouseEvent.CLICK,this.BtnRankOnClick);
         this.FBTN_chapter.addEventListener(MouseEvent.CLICK,this.BtnchapterOnClick);
         this.FBTN_chapterNew.addEventListener(MouseEvent.CLICK,this.BtnchapterNewOnClick);
         this.FBTN_Help.addEventListener(MouseEvent.MOUSE_OVER,this.OnHelpOver);
         this.FBTN_Help.addEventListener(MouseEvent.MOUSE_OUT,this.OnHelpOut);
         super.ResourcesPerform_UILocations();
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_GlobalBoss_Rank_Ret,this.PerformPacket_SC_Rank_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_GlobalBoss_Rank_Reward_Ret,this.PerformPacket_SC_Rank_Reward_Ret);
      }
      
      protected function PerformPacket_CS_Chapter_Req() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_GlobalBoss_Chapter_Req);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
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
      
      protected function BtnRankOnClick(param1:MouseEvent) : void
      {
         this.FProcessorGlobalbossRank.Visible = true;
      }
      
      protected function BtnchapterOnClick(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(this.OnOpenGlobalboss != null)
         {
            _loc2_ = TUnstreamizerGlobalboss.CurChapterId;
            this.OnOpenGlobalboss({
               "identity":_loc2_,
               "level":1
            });
         }
      }
      
      protected function BtnchapterNewOnClick(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(this.FDafubenShield != 1)
         {
            EffectGenerateText(STRING_SHORTCUTS.STRING_FunctionLock);
            return;
         }
         if(this.OnOpenGlobalboss != null)
         {
            _loc2_ = TUnstreamizerGlobalboss.CurNewChapterId;
            this.OnOpenGlobalboss({
               "identity":_loc2_,
               "level":3
            });
         }
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
      
      override protected function LogicsPerform() : void
      {
         this.LogicsPerform_EffectText();
         super.LogicsPerform();
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount();
         if(!FIsResourcesLoadCompleted)
         {
            this.FProcessorGlobalbossRank.Load();
            return;
         }
         this.PerformPacket_CS_Chapter_Req();
      }
   }
}

