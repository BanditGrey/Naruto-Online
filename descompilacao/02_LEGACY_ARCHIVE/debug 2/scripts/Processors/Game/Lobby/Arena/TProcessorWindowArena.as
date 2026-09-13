package Processors.Game.Lobby.Arena
{
   import Foundation.Common.*;
   import Foundation.Network.*;
   import Foundation.Resources.*;
   import Foundation.Resources.Bins.*;
   import Foundation.Timing.*;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.*;
   import Logics.Arena.*;
   import Logics.Characters.*;
   import Logics.DatebaseVO.VO.*;
   import Processors.Game.Lobby.TreasureMap.ConsumeFrame;
   import Processors.Game.Windows.Information.*;
   import Resources.Constants.*;
   import Resources.Strings.*;
   import Utilities.UI.Windows.*;
   import flash.display.*;
   import flash.events.*;
   import ghostcat.util.easing.*;
   
   public class TProcessorWindowArena extends TUIComponent
   {
      
      protected static const CONST_RankingBoxCount:uint = 4;
      
      protected static const QUALITY_MAX:uint = 7;
      
      protected static const RANK_Id_MAX:uint = 8;
      
      protected var FScene:MovieClip;
      
      protected var FArenaData:TArenaData;
      
      protected var FCharacter:TCharacter;
      
      protected var FMilitaryBins:TBins;
      
      protected var FRankComposeQuality:TBins;
      
      protected var FMyBoxQuality:uint;
      
      protected var FBigBitmap:Bitmap;
      
      protected var FBigPicId:uint;
      
      protected var FLoadComplete:Boolean;
      
      protected var FStartBoxId:int;
      
      protected var FHintBtnAdd:THint;
      
      protected var FHintBoxTip:THint;
      
      protected var FRankExpendCostBins:TBins;
      
      protected var FRankRewardBins:TBins;
      
      protected var FRankMoneyBins:TBins;
      
      protected var FUIWindowConfirmation:TUIWindowConfirmation;
      
      protected var FUIWindowRecharge:TUIWindowRecharge;
      
      protected var FIsFightTimesCanFight:Boolean;
      
      protected var FIsColdDownCanFight:Boolean;
      
      protected var FCheckCost:uint;
      
      protected var FHintOnMove:Function;
      
      protected var FHintOnOut:Function;
      
      protected var FEffectGenerateText:Function;
      
      public function TProcessorWindowArena(param1:TUIComponent, param2:MovieClip)
      {
         var _loc3_:uint = 0;
         super(param1);
         this.FScene = param2;
         this.FLoadComplete = false;
         this.FBigBitmap = new Bitmap();
         this.FScene.mc_image.addChild(this.FBigBitmap);
         this.FScene.mc_image.mouseEnabled = false;
         TGameUtil.setButtonMode(this.FScene.mc_baseInfo.btn_addCurTimes,true);
         this.FScene.mc_baseInfo.btn_addCurTimes.addEventListener(MouseEvent.CLICK,this.OnShowWindowConfirmationAddTimes);
         this.FScene.mc_baseInfo.btn_addCurTimes.addEventListener(MouseEvent.MOUSE_MOVE,this.Btn_AddOnMove,false,0,true);
         this.FScene.mc_baseInfo.btn_addCurTimes.addEventListener(MouseEvent.MOUSE_OUT,this.Btn_AddOnOut,false,0,true);
         this.FScene.mc_baseInfo.btn_fast.addEventListener(MouseEvent.CLICK,this.OnShowWindowConfirmationAddTimes);
         this.FHintBtnAdd = new THint();
         this.FHintBoxTip = new THint();
         _loc3_ = 0;
         while(_loc3_ < CONST_RankingBoxCount)
         {
            TGameUtil.setButtonMode(this.FScene.mc_boxList["mc_box_" + _loc3_],true);
            this.FScene.mc_boxList["mc_box_" + _loc3_].addEventListener(MouseEvent.MOUSE_MOVE,this.OnMouseMove);
            this.FScene.mc_boxList["mc_box_" + _loc3_].addEventListener(MouseEvent.MOUSE_OUT,this.OnMouseOut);
            _loc3_++;
         }
         this.FScene.mc_title.btn_getReward.addEventListener(MouseEvent.CLICK,this.OnGetReward);
         this.FScene.mc_title.btn_getReward.addEventListener(MouseEvent.MOUSE_MOVE,this.OnRewardMouseMove);
         this.FScene.mc_title.btn_getReward.addEventListener(MouseEvent.ROLL_OUT,this.OnMouseOut);
         this.FRankComposeQuality = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_RankComposeQuality);
         this.FRankExpendCostBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_RankExpendCost);
         this.FRankRewardBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_RankReward);
         this.FRankMoneyBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_RankMoney);
         this.FUIWindowConfirmation = new TUIWindowConfirmation(this);
         this.FUIWindowConfirmation.x = (CONST_COMMON.STAGE_Width - this.FUIWindowConfirmation.WindowWidth) / 2;
         this.FUIWindowConfirmation.y = (CONST_COMMON.STAGE_Height - this.FUIWindowConfirmation.WindowHeight) / 2 - 20;
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowConfirmation);
         this.FUIWindowRecharge = new TUIWindowRecharge(this.Parent);
         this.FUIWindowRecharge.x = (CONST_COMMON.STAGE_Width - this.FUIWindowRecharge.WindowWidth) / 2;
         this.FUIWindowRecharge.y = (CONST_COMMON.STAGE_Height - this.FUIWindowRecharge.WindowHeight) / 2 - 20;
         TUtilityUIWindow.SetupWindowRecharge(this.FUIWindowRecharge);
      }
      
      protected function GetQualityByRanking(param1:uint) : int
      {
         var _loc2_:uint = 0;
         var _loc3_:TRankComposeQuality = null;
         var _loc4_:uint = 0;
         _loc4_ = 1;
         _loc2_ = 0;
         while(_loc2_ < this.FRankComposeQuality.Count)
         {
            _loc3_ = this.FRankComposeQuality.GetDatebaseByIndex(_loc2_) as TRankComposeQuality;
            if(param1 >= _loc3_.From && param1 <= _loc3_.To)
            {
               _loc4_ = uint(_loc3_.Quality);
               break;
            }
            _loc2_++;
         }
         return _loc4_;
      }
      
      protected function GetArenaIdByRanking(param1:int) : int
      {
         var _loc2_:uint = 0;
         var _loc3_:TRankComposeQuality = null;
         var _loc4_:uint = 0;
         _loc4_ = 0;
         _loc2_ = 0;
         while(_loc2_ < this.FRankComposeQuality.Count)
         {
            _loc3_ = this.FRankComposeQuality.GetDatebaseByIndex(_loc2_) as TRankComposeQuality;
            if(param1 >= _loc3_.From && param1 <= _loc3_.To)
            {
               _loc4_ = uint(_loc3_.Identifier);
               break;
            }
            _loc2_++;
         }
         return _loc4_;
      }
      
      protected function UpdataUI() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:String = null;
         var _loc3_:TMilitary = null;
         var _loc4_:int = 0;
         var _loc5_:String = null;
         var _loc6_:TRankExpendCost = null;
         var _loc7_:TRankComposeQuality = null;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:String = null;
         var _loc11_:uint = 0;
         this.FBigPicId = this.FCharacter.MainHero.LargeID;
         _loc6_ = this.FRankExpendCostBins.GetDatebaseByIdentifier(this.FArenaData.AddTimes + 1) as TRankExpendCost;
         _loc5_ = STRING_ARENA.ARENA_AddTimesCostTip;
         _loc5_ = _loc5_.split("%count%").join(_loc6_ ? _loc6_.Cost : 0);
         this.FHintBtnAdd.Caption = _loc5_;
         this.FScene.mc_baseInfo.tf_playerName.text = this.FCharacter.NickName;
         this.FScene.mc_baseInfo.tf_strength.text = this.FCharacter.GetFightingPowerPVE().ToString();
         this.FScene.mc_baseInfo.tf_SilverCoin.text = this.FCharacter.CreditSilverCoin.ToString();
         this.FScene.mc_baseInfo.tf_gold.text = this.FCharacter.CreditGold.toString();
         this.FScene.mc_baseInfo.tf_giftCertificate.text = this.FCharacter.CreditGiftCertificate.toString();
         _loc3_ = this.FMilitaryBins.GetDatebaseByIdentifier(this.FCharacter.MilitaryRank) as TMilitary;
         this.FScene.mc_baseInfo.tf_militaryRank.text = _loc3_.Name;
         this.FScene.mc_baseInfo.tf_curRanking.text = this.FArenaData.CurRanking.toString();
         this.FScene.mc_baseInfo.tf_highRank.text = Math.min(this.FArenaData.HighRanking,this.FArenaData.CurRanking).toString();
         this.FScene.mc_baseInfo.tf_streakWin.text = this.FArenaData.StreakWin.toString();
         this.FScene.mc_baseInfo.tf_curTimes.text = this.FArenaData.FightTimes.toString();
         this.FIsFightTimesCanFight = Boolean(this.FArenaData.FightTimes > 0);
         this.FScene.mc_baseInfo.btn_addCurTimes.visible = Boolean(this.FArenaData.AddTimes < 20);
         this.FMyBoxQuality = this.GetQualityByRanking(this.FArenaData.CurRanking);
         _loc9_ = this.GetArenaIdByRanking(this.FArenaData.CurRanking);
         _loc1_ = 0;
         while(_loc1_ < CONST_RankingBoxCount)
         {
            if(_loc9_ < CONST_RankingBoxCount)
            {
               _loc8_ = int(_loc1_);
            }
            else
            {
               _loc8_ = _loc9_ - CONST_RankingBoxCount + 1 + _loc1_;
            }
            if(_loc1_ == 0)
            {
               this.FStartBoxId = _loc8_;
            }
            _loc7_ = this.FRankComposeQuality.GetDatebaseByIdentifier(_loc8_) as TRankComposeQuality;
            _loc4_ = _loc7_.Quality;
            _loc2_ = STRING_ARENA.RANKINT_BoxTip;
            _loc10_ = _loc7_.From + "~" + _loc7_.To;
            _loc2_ = _loc2_.split("%count%").join(_loc10_);
            this.FScene.mc_boxList["mc_box_" + _loc1_].mc_ranking.tf_ranking.text = _loc2_;
            this.FScene.mc_boxList["mc_box_" + _loc1_].mc_box.mc_box.gotoAndStop(_loc4_);
            _loc1_++;
         }
         this.FScene.mc_title.mc_title.tf_curRanking.text = this.FArenaData.CurRanking.toString();
         TGameUtil.setButtonMode(this.FScene.mc_title.btn_getReward,this.FArenaData.BoxType != 2);
         this.FScene.mc_title.btn_getReward.tf_getReward.visible = Boolean(this.FArenaData.BoxType == 1);
         this.FScene.mc_title.mc_title.mc_timer.visible = Boolean(this.FArenaData.BoxType != 1);
         if(this.FArenaData.BoxType == 0)
         {
            this.FScene.mc_title.btn_getReward.mc_box.gotoAndStop(this.FMyBoxQuality);
            this.FScene.mc_title.btn_getReward.mc_box.visible = true;
            this.FScene.mc_title.btn_getReward.mc_boxget.visible = false;
         }
         else if(this.FArenaData.BoxType == 1)
         {
            _loc11_ = uint(this.GetQualityByRanking(this.FArenaData.BoxRanking));
            this.FScene.mc_title.btn_getReward.mc_box.gotoAndStop(_loc11_);
            this.FScene.mc_title.btn_getReward.mc_box.visible = true;
            this.FScene.mc_title.btn_getReward.mc_boxget.visible = false;
         }
         else if(this.FArenaData.BoxType == 2)
         {
            if(this.FArenaData.BoxRanking < 1000)
            {
               _loc11_ = uint(this.GetQualityByRanking(this.FArenaData.BoxRanking));
               this.FScene.mc_title.btn_getReward.mc_boxget.gotoAndStop(_loc11_);
               this.FScene.mc_title.btn_getReward.mc_box.visible = false;
               this.FScene.mc_title.btn_getReward.mc_boxget.visible = true;
            }
            else
            {
               this.FScene.mc_title.btn_getReward.mc_box.gotoAndStop(this.FMyBoxQuality);
               this.FScene.mc_title.btn_getReward.mc_box.visible = true;
               this.FScene.mc_title.btn_getReward.mc_boxget.visible = false;
            }
         }
      }
      
      protected function GetRewardMoney(param1:int, param2:int) : int
      {
         param1 = int(SLogicsCore.Character.GetMainHeroLogicLevel(SLogicsCore.Character.MainHero.Level));
         return Math.floor(2000 * Math.pow(2,param1 / 20) * Math.log(6561 / (param2 + 8)) / Math.log(3) * (1 + Math.max(0,(param1 - 100) / (340 + param1)) * 4));
      }
      
      protected function MakeHtmlText(param1:uint, param2:uint, param3:uint) : String
      {
         var _loc4_:TRankComposeQuality = null;
         var _loc5_:TRankReward = null;
         var _loc6_:TRankMoney = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:String = null;
         var _loc10_:Array = null;
         _loc4_ = this.FRankComposeQuality.GetDatebaseByIdentifier(param1) as TRankComposeQuality;
         _loc8_ = (param3 - 1) * QUALITY_MAX + _loc4_.Quality;
         _loc5_ = this.FRankRewardBins.GetDatebaseByIdentifier(_loc8_) as TRankReward;
         _loc6_ = this.FRankMoneyBins.GetDatebaseByIdentifier(param2) as TRankMoney;
         _loc7_ = this.GetRewardMoney(param3,param2);
         _loc10_ = _loc5_.Tips.split("\\n");
         _loc9_ = _loc10_[0] + "\n" + _loc10_[1] + "\n";
         _loc9_ = _loc9_ + (STRING_COMMON.ITEMNAME_Coin + " +" + _loc7_ + "\n");
         return _loc9_ + (STRING_COMMON.ITEMNAME_Prestige + " +" + _loc6_.Prestige);
      }
      
      protected function MakeListHtmlText(param1:uint, param2:uint, param3:uint, param4:uint) : String
      {
         var _loc5_:TRankComposeQuality = null;
         var _loc6_:TRankReward = null;
         var _loc7_:TRankMoney = null;
         var _loc8_:TRankMoney = null;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:String = null;
         var _loc13_:Array = null;
         _loc5_ = this.FRankComposeQuality.GetDatebaseByIdentifier(param1) as TRankComposeQuality;
         _loc11_ = (param4 - 1) * QUALITY_MAX + _loc5_.Quality;
         _loc6_ = this.FRankRewardBins.GetDatebaseByIdentifier(_loc11_) as TRankReward;
         _loc7_ = this.FRankMoneyBins.GetDatebaseByIdentifier(param2) as TRankMoney;
         _loc8_ = this.FRankMoneyBins.GetDatebaseByIdentifier(param3) as TRankMoney;
         _loc9_ = this.GetRewardMoney(param4,param2);
         _loc10_ = this.GetRewardMoney(param4,param3);
         _loc13_ = _loc6_.Tips.split("\\n");
         _loc12_ = _loc13_[0] + "\n" + _loc13_[1] + "\n";
         _loc12_ = _loc12_ + (STRING_COMMON.ITEMNAME_Coin + " +" + _loc10_ + "~" + _loc9_ + "\n");
         _loc12_ = _loc12_ + (STRING_COMMON.ITEMNAME_Prestige + " +" + _loc8_.Prestige + "~" + _loc7_.Prestige + "\n");
         _loc12_ = _loc12_ + STRING_ARENA.ARENA_Ranking_ListReward;
         _loc12_ = _loc12_.split("%to%").join(_loc5_.To);
         return _loc12_.split("%from%").join(_loc5_.From);
      }
      
      protected function OnShowWindowConfirmationAddTimes(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:TRankExpendCost = null;
         if(param1.currentTarget == this.FScene.mc_baseInfo.btn_addCurTimes)
         {
            if(this.FArenaData.AddTimes + 1 > this.FRankExpendCostBins.Count)
            {
               return;
            }
            _loc5_ = this.FRankExpendCostBins.GetDatebaseByIdentifier(this.FArenaData.AddTimes + 1) as TRankExpendCost;
            _loc2_ = new ConsumeFrame(CONST_SYSTEMLANGUAGE.ConsumerConfirm_Area_AddTimes).DescribeString;
            _loc2_ = _loc2_.split("%0").join(_loc5_.Cost);
            this.FCheckCost = _loc5_.Cost;
            this.FUIWindowConfirmation.Text = _loc2_;
            this.FUIWindowConfirmation.OnOK = this.OnAddTimes;
         }
         else if(param1.currentTarget == this.FScene.mc_baseInfo.btn_fast)
         {
            _loc3_ = this.FArenaData.ColdDown - STimingCore.GetServerTick();
            if(_loc3_ < 0)
            {
               this.FScene.mc_baseInfo.btn_fast.visible = false;
               return;
            }
            _loc4_ = Math.max(int(_loc3_ - 1) / 60 + 1,1);
            this.FCheckCost = _loc4_;
            _loc2_ = new ConsumeFrame(CONST_SYSTEMLANGUAGE.ConsumerConfirm_Area_ClearCD).DescribeString;
            _loc2_ = _loc2_.split("%0").join(_loc4_);
            this.FUIWindowConfirmation.Text = _loc2_;
            this.FUIWindowConfirmation.OnOK = this.OnFast;
         }
         if(this.FCheckCost > this.FCharacter.CreditGiftCertificate + this.FCharacter.CreditGold)
         {
            this.FUIWindowRecharge.visible = true;
            return;
         }
         this.FUIWindowConfirmation.visible = true;
      }
      
      protected function OnAddTimes(param1:Object) : void
      {
         var _loc2_:TPacket = null;
         if(this.FCheckCost > this.FCharacter.CreditGiftCertificate + this.FCharacter.CreditGold)
         {
            if(this.FEffectGenerateText != null)
            {
               this.FEffectGenerateText(STRING_COMMON.NOTENOUGH_Gold);
            }
            return;
         }
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Arena_AddOrder_Req);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function OnFast(param1:Object) : void
      {
         var _loc2_:TPacket = null;
         if(this.FCheckCost > this.FCharacter.CreditGiftCertificate + this.FCharacter.CreditGold)
         {
            if(this.FEffectGenerateText != null)
            {
               this.FEffectGenerateText(STRING_COMMON.NOTENOUGH_Gold);
            }
            return;
         }
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Arena_Faster_Req);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function OnMouseMove(param1:MouseEvent) : void
      {
         var _loc2_:TRankComposeQuality = null;
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:int = 0;
         var _loc7_:String = null;
         _loc3_ = int(String(param1.currentTarget.name).slice(7));
         _loc5_ = this.FStartBoxId + _loc3_;
         _loc4_ = this.FCharacter.GetMainLevel();
         _loc2_ = this.FRankComposeQuality.GetDatebaseByIdentifier(_loc5_) as TRankComposeQuality;
         _loc7_ = this.MakeListHtmlText(_loc5_,_loc2_.To,_loc2_.From,_loc4_);
         this.FHintBoxTip.Caption = _loc7_;
         if(this.FHintOnMove != null)
         {
            this.FHintOnMove(param1,this.FHintBoxTip);
         }
      }
      
      protected function OnMouseOut(param1:MouseEvent) : void
      {
         if(this.FHintOnOut != null)
         {
            this.FHintOnOut(param1);
         }
         param1.currentTarget.gotoAndStop(1);
      }
      
      protected function OnRewardMouseMove(param1:MouseEvent) : void
      {
         var _loc2_:TRankComposeQuality = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:uint = 0;
         var _loc7_:String = null;
         if(this.FArenaData.BoxType == 0)
         {
            _loc3_ = this.GetQualityByRanking(this.FArenaData.CurRanking);
            _loc4_ = (_loc3_ - 1) * QUALITY_MAX + _loc3_;
            _loc6_ = this.FCharacter.GetMainLevel();
            _loc5_ = this.GetArenaIdByRanking(this.FArenaData.CurRanking);
            _loc2_ = this.FRankComposeQuality.GetDatebaseByIdentifier(_loc5_) as TRankComposeQuality;
            _loc7_ = this.MakeHtmlText(_loc5_,this.FArenaData.CurRanking,_loc6_);
         }
         else if(this.FArenaData.BoxType == 1)
         {
            _loc3_ = this.GetQualityByRanking(this.FArenaData.BoxRanking);
            _loc4_ = (_loc3_ - 1) * QUALITY_MAX + _loc3_;
            _loc5_ = this.GetArenaIdByRanking(this.FArenaData.BoxRanking);
            _loc2_ = this.FRankComposeQuality.GetDatebaseByIdentifier(_loc5_) as TRankComposeQuality;
            _loc7_ = this.MakeHtmlText(_loc5_,this.FArenaData.BoxRanking,this.FArenaData.BoxLevel);
         }
         else if(this.FArenaData.BoxType == 2)
         {
            if(this.FArenaData.BoxRanking < 1000)
            {
               _loc3_ = this.GetQualityByRanking(this.FArenaData.BoxRanking);
               _loc4_ = (_loc3_ - 1) * QUALITY_MAX + _loc3_;
               _loc5_ = this.GetArenaIdByRanking(this.FArenaData.BoxRanking);
               _loc2_ = this.FRankComposeQuality.GetDatebaseByIdentifier(_loc5_) as TRankComposeQuality;
               _loc7_ = this.MakeHtmlText(_loc5_,this.FArenaData.BoxRanking,this.FArenaData.BoxLevel);
            }
            else
            {
               _loc3_ = this.GetQualityByRanking(this.FArenaData.CurRanking);
               _loc4_ = (_loc3_ - 1) * QUALITY_MAX + _loc3_;
               _loc6_ = this.FCharacter.GetMainLevel();
               _loc5_ = this.GetArenaIdByRanking(this.FArenaData.CurRanking);
               _loc2_ = this.FRankComposeQuality.GetDatebaseByIdentifier(_loc5_) as TRankComposeQuality;
               _loc7_ = this.MakeHtmlText(_loc5_,this.FArenaData.CurRanking,_loc6_);
            }
         }
         this.FHintBoxTip.Caption = _loc7_;
         if(this.FHintOnMove != null)
         {
            this.FHintOnMove(param1,this.FHintBoxTip);
         }
      }
      
      protected function OnGetReward(param1:MouseEvent) : void
      {
         var _loc2_:TPacket = null;
         if(this.FArenaData.BoxType != 1)
         {
            return;
         }
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Arena_GetReward_Req);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function Btn_AddOnMove(param1:MouseEvent) : void
      {
         if(this.FHintOnMove != null)
         {
            this.FHintOnMove(param1,this.FHintBtnAdd);
         }
      }
      
      protected function Btn_AddOnOut(param1:MouseEvent) : void
      {
         if(this.FHintOnOut != null)
         {
            this.FHintOnOut(param1);
         }
      }
      
      public function get HintOnMove() : Function
      {
         return this.FHintOnMove;
      }
      
      public function set HintOnMove(param1:Function) : void
      {
         this.FHintOnMove = param1;
      }
      
      public function get HintOnOut() : Function
      {
         return this.FHintOnOut;
      }
      
      public function set HintOnOut(param1:Function) : void
      {
         this.FHintOnOut = param1;
      }
      
      public function get EffectGenerateText() : Function
      {
         return this.FEffectGenerateText;
      }
      
      public function set EffectGenerateText(param1:Function) : void
      {
         this.FEffectGenerateText = param1;
      }
      
      public function UpdataColdDown() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:String = null;
         if(this.FArenaData == null)
         {
            return;
         }
         _loc1_ = this.FArenaData.ColdDown - STimingCore.GetServerTick();
         if(_loc1_ <= 0)
         {
            this.FIsColdDownCanFight = true;
            this.FScene.mc_baseInfo.tf_fighttip.visible = true;
            this.FScene.mc_baseInfo.tf_coldtip.visible = false;
            this.FScene.mc_baseInfo.btn_fast.visible = false;
         }
         else
         {
            this.FIsColdDownCanFight = false;
            this.FScene.mc_baseInfo.tf_fighttip.visible = false;
            this.FScene.mc_baseInfo.tf_coldtip.visible = true;
            this.FScene.mc_baseInfo.btn_fast.visible = true;
            _loc3_ = TGameUtil.fomatTime(_loc1_);
            _loc3_ = _loc3_.slice(3);
            this.FScene.mc_baseInfo.tf_coldtip.tf_timer.text = _loc3_;
         }
         if(this.FArenaData.BoxType != 1)
         {
            _loc2_ = this.FArenaData.ColdDownBox - STimingCore.GetServerTime();
            if(_loc2_ <= 0)
            {
               this.FArenaData.ColdDownBox += CONST_ARENA.ColdDown_BoxMax;
               this.UpdataUI();
            }
            _loc3_ = TGameUtil.fomatTime(_loc2_);
            this.FScene.mc_title.mc_title.mc_timer.tf_timer.text = _loc3_;
            this.FScene.mc_title.mc_title.mc_timer.visible = true;
         }
         else
         {
            this.FScene.mc_title.mc_title.mc_timer.visible = false;
         }
      }
      
      public function UpdateFreeCount() : void
      {
         if(SLogicsCore.KaguyaData.Type_Count_Vector[2] == -1)
         {
            this.FScene.mc_baseInfo.tf_timer_Copy.text = STRING_OhtsutsukiKaguya.Smithy_Dec_4;
            this.FArenaData.ColdDown = 0;
         }
         else
         {
            this.FScene.mc_baseInfo.tf_timer_Copy.text = TUtilityString.Format(STRING_OhtsutsukiKaguya.Smithy_Dec_3,SLogicsCore.KaguyaData.Type_Count_Vector[2]);
            if(SLogicsCore.KaguyaData.Type_Count_Vector[2] > 0)
            {
               this.FArenaData.ColdDown = 0;
            }
         }
      }
      
      public function UpdataBigBitmap() : void
      {
         var _loc1_:TCoordinate = null;
         if(this.FBigPicId != 0 && !this.FLoadComplete)
         {
            _loc1_ = TGameUtil.ShowImageByID(TGameUtil.Type_LargeIcon,this.FBigBitmap,CONST_MODULES.MODULE_Arena,this.FBigPicId);
            if(_loc1_ != null)
            {
               this.FLoadComplete = true;
               this.FBigBitmap.alpha = 0;
               TweenUtil.to(this.FBigBitmap,1000,{"alpha":1});
            }
         }
      }
      
      public function SetArenaData(param1:TArenaData) : void
      {
         this.FArenaData = param1;
         this.FCharacter = SLogicsCore.Character;
         if(this.FMilitaryBins == null)
         {
            this.FMilitaryBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Military);
         }
         this.UpdataUI();
      }
      
      public function GetRewardOk() : void
      {
         var _loc1_:Date = null;
         var _loc2_:Date = null;
         var _loc3_:TConfigValue = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         this.FArenaData.BoxType = 2;
         _loc1_ = new Date(this.FArenaData.ColdDownBox * 1000);
         _loc2_ = new Date(STimingCore.GetServerTime() * 1000);
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.ARENA_RANK_REWARD_BOX_GET_HOUR) as TConfigValue;
         _loc4_ = _loc3_.Value as int;
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.ARENA_RANK_REWARD_BOX_GET_SECOND) as TConfigValue;
         _loc5_ = _loc3_.Value as int;
         if(_loc2_.hours > _loc4_ || _loc2_.hours == _loc4_ && _loc2_.minutes > _loc5_)
         {
            if(_loc1_.date == _loc2_.date)
            {
               this.FArenaData.ColdDownBox += CONST_ARENA.ColdDown_BoxMax;
            }
         }
         this.UpdataUI();
      }
      
      public function AddOrderOk() : void
      {
         this.FArenaData.AddTimes += 1;
         this.FArenaData.FightTimes += 1;
         this.UpdataUI();
      }
      
      public function FasterOk() : void
      {
         this.FArenaData.ColdDown = 0;
         this.FIsColdDownCanFight = true;
         this.UpdataUI();
      }
      
      public function CheckCanFight() : Boolean
      {
         if(SLogicsCore.KaguyaData.Type_Count_Vector[2] == -1 || SLogicsCore.KaguyaData.Type_Count_Vector[2] > 0)
         {
            if(this.FArenaData.FightTimes > 0)
            {
               return true;
            }
         }
         if(!this.FIsFightTimesCanFight)
         {
            this.FScene.mc_baseInfo.btn_addCurTimes.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
            return false;
         }
         if(!this.FIsColdDownCanFight)
         {
            this.FScene.mc_baseInfo.btn_fast.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
            return false;
         }
         return true;
      }
      
      public function ImageReset() : void
      {
         this.FLoadComplete = false;
      }
   }
}

