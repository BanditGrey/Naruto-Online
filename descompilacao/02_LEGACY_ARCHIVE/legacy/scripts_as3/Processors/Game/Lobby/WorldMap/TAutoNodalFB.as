package Processors.Game.Lobby.WorldMap
{
   import Components.ScrollBar.*;
   import Foundation.Common.*;
   import Foundation.Network.*;
   import Foundation.Resources.*;
   import Foundation.Resources.Bins.*;
   import Foundation.Resources.Strings.*;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.*;
   import Logics.Campaign.*;
   import Logics.Campaign.AutoBattle.*;
   import Logics.Characters.TCharacter;
   import Logics.DatebaseVO.VO.*;
   import Logics.Items.*;
   import Logics.Streamization.Campaign.*;
   import Processors.Game.Lobby.Common.*;
   import Processors.Game.Windows.Information.*;
   import Rendering.Texts.*;
   import Resources.Constants.*;
   import Resources.Strings.*;
   import Utilities.UI.Windows.*;
   import flash.display.*;
   import flash.events.*;
   import flash.utils.*;
   
   public class TAutoNodalFB extends TProcessorLobbyWindow
   {
      
      public static const AutoNodal_FastInfo:String = STRING_WORLDMAP.STRINGS_SureFastAutoNodal;
      
      public static const SIZE_Window_Width:uint = 495;
      
      public static const SIZE_Window_Height:uint = 435;
      
      protected static const AutoStatus_Begin:int = 2;
      
      protected static const AutoStatus_End:int = 3;
      
      protected static const AUTO_TIME_GOLD_ID:int = 60101016;
      
      protected static const UPDATA_TIMESTAMP:int = 500;
      
      protected var FStatus:int;
      
      protected var FScene:MovieClip;
      
      protected var FAutoBattleResultCount:int;
      
      protected var FCurCampID:int;
      
      protected var FTotleTimer:int;
      
      protected var FAutoScrollBar:TScrollBar;
      
      protected var FAutoCount:int;
      
      protected var FNodalAutoBattleFBInfo:TNodalAutoBattleFBInfo;
      
      protected var UnstreamizerAutoBattleFBInfo:TUnstreamizerAutoBattleFBInfo;
      
      protected var FAutoUpdataUIStatus:Boolean;
      
      protected var FAutoUpdataUITimerID:uint;
      
      protected var FStartRunTimerID:uint;
      
      protected var FWindowConfirmationStop:TUIWindowConfirmation;
      
      protected var FWindowConfirmationFast:TUIWindowConfirmation;
      
      protected var FBackground:Sprite;
      
      protected var FSingleBins:TBins;
      
      protected var FAutoTimeGold:uint;
      
      protected var FFreeAutoTurnUIVect:Vector.<TAutoTurnUI>;
      
      protected var FNodalModel:TNodal;
      
      protected var FCharacter:TCharacter;
      
      protected var FShowResult:Boolean;
      
      protected var FCampaignModel:TCampaign;
      
      protected var FOnEndAutoCamp:Function;
      
      protected var FBackFunction:Function;
      
      public function TAutoNodalFB(param1:TUIComponent, param2:TNodal)
      {
         super(param1);
         this.FNodalModel = param2;
         this.FCharacter = SLogicsCore.Character;
         this.FBackground = new Sprite();
         this.FBackground.alpha = 0.1;
         this.FBackground.graphics.beginFill(0);
         this.FBackground.graphics.drawRect(0,0,CONST_COMMON.STAGE_Width,CONST_COMMON.STAGE_Height);
         this.FBackground.graphics.endFill();
         addChild(this.FBackground);
         this.FBackground.x = 0;
         this.FBackground.y = 0;
         this.FBackground.x = 0 - (CONST_COMMON.STAGE_Width - SIZE_Window_Width) / 2;
         this.FBackground.y = 0 - (CONST_COMMON.STAGE_Height - SIZE_Window_Height) / 2;
         this.FStartRunTimerID = 0;
         this.FFreeAutoTurnUIVect = new Vector.<TAutoTurnUI>();
         this.InitAutoNodalFB();
      }
      
      protected function UpdataAutoUI() : void
      {
         var _loc1_:TItems = null;
         var _loc2_:TAutoTurnUI = null;
         if(this.FStatus == AutoStatus_Begin)
         {
            if(this.FNodalAutoBattleFBInfo.BattleResult.length > 0)
            {
               _loc1_ = this.FNodalAutoBattleFBInfo.BattleResult.shift();
               this.FScene.tf_turn.text = this.FAutoBattleResultCount + "/" + this.FAutoCount;
               if(this.FFreeAutoTurnUIVect.length > 0)
               {
                  _loc2_ = this.FFreeAutoTurnUIVect.pop();
               }
               else
               {
                  _loc2_ = new TAutoTurnUI(null);
               }
               _loc2_.SetResult(_loc1_,this.FAutoBattleResultCount++);
               this.FAutoScrollBar.AddItem(_loc2_);
               this.FNodalModel.AutoAddCampaignIndex(this.FCampaignModel.Identifier);
            }
            else if(!this.FShowResult)
            {
               this.FShowResult = true;
               if(this.FFreeAutoTurnUIVect.length > 0)
               {
                  _loc2_ = this.FFreeAutoTurnUIVect.pop();
               }
               else
               {
                  _loc2_ = new TAutoTurnUI(null);
               }
               _loc2_.SetPassResult(this.FNodalAutoBattleFBInfo.PassResult);
               this.FAutoScrollBar.AddItem(_loc2_);
            }
            if(this.FNodalAutoBattleFBInfo.BattleResult.length > 0 || !this.FShowResult)
            {
               this.FAutoUpdataUIStatus = true;
               clearTimeout(this.FAutoUpdataUITimerID);
               this.FAutoUpdataUITimerID = setTimeout(this.UpdataAutoUI,UPDATA_TIMESTAMP);
            }
            else
            {
               clearTimeout(this.FAutoUpdataUITimerID);
               this.FAutoUpdataUIStatus = false;
               if(this.FNodalAutoBattleFBInfo.CostTimer <= 0 && this.FAutoBattleResultCount >= this.FAutoCount)
               {
                  this.FStatus = AutoStatus_End;
                  this.Updata();
                  if(this.FOnEndAutoCamp != null)
                  {
                     this.FOnEndAutoCamp(this);
                  }
               }
            }
         }
      }
      
      protected function InitAutoNodalFB() : void
      {
         var _loc1_:TConfigValue = null;
         this.FSingleBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Single);
         this.FAutoBattleResultCount = 1;
         this.FNodalAutoBattleFBInfo = new TNodalAutoBattleFBInfo();
         this.UnstreamizerAutoBattleFBInfo = new TUnstreamizerAutoBattleFBInfo();
         this.FScene = TUtilityReflection.CreateDisplayObjectInstance(CONST_CAMPAIGN.RESOURCE_ClassName_AutoBattleFB) as MovieClip;
         addChild(this.FScene);
         TGameUtil.setButtonMode(this.FScene.btn_stop,true);
         this.FScene.btn_stop.addEventListener(MouseEvent.CLICK,this.OnStopFight);
         TGameUtil.setButtonMode(this.FScene.btn_fast,true);
         this.FScene.btn_fast.addEventListener(MouseEvent.CLICK,this.OnFastFight);
         TGameUtil.setButtonMode(this.FScene.btn_back,true);
         this.FScene.btn_back.addEventListener(MouseEvent.CLICK,this.OnReset);
         this.FScene.btn_close.addEventListener(MouseEvent.CLICK,this.OnCancel);
         this.FAutoScrollBar = new TScrollBar(this.FScene.ta_autoInfo,200);
         this.FWindowConfirmationStop = new TUIWindowConfirmation(Parent);
         TUtilityUIWindow.SetupWindowConfirmation(this.FWindowConfirmationStop);
         this.FWindowConfirmationStop.OnOK = this.OnSureStop;
         this.FWindowConfirmationStop.Text = STRING_WORLDMAP.STRINGS_SureCancelAutoNodal;
         this.FWindowConfirmationStop.x = (CONST_COMMON.STAGE_Width - this.FWindowConfirmationStop.Scene.width) / 2;
         this.FWindowConfirmationStop.y = (CONST_COMMON.STAGE_Height - this.FWindowConfirmationStop.Scene.height) / 2;
         this.FWindowConfirmationFast = new TUIWindowConfirmation(Parent);
         TUtilityUIWindow.SetupWindowConfirmation(this.FWindowConfirmationFast);
         this.FWindowConfirmationFast.OnOK = this.OnSureFastFight;
         this.FWindowConfirmationFast.x = (CONST_COMMON.STAGE_Width - this.FWindowConfirmationFast.Scene.width) / 2;
         this.FWindowConfirmationFast.y = (CONST_COMMON.STAGE_Height - this.FWindowConfirmationFast.Scene.height) / 2;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,AUTO_TIME_GOLD_ID) as TConfigValue;
         this.FAutoTimeGold = _loc1_.Value as uint;
      }
      
      protected function Updata() : void
      {
         this.FScene.tf_vipConfig.visible = false;
         this.FScene.btn_stop.visible = false;
         this.FScene.btn_fast.visible = false;
         this.FScene.btn_back.visible = false;
         if(this.FStatus == AutoStatus_Begin)
         {
            this.FScene.tf_vipConfig.visible = true;
            this.FScene.btn_stop.visible = true;
            this.FScene.btn_fast.visible = true;
         }
         else if(this.FStatus == AutoStatus_End)
         {
            this.FScene.btn_back.visible = true;
         }
         this.FScene.btn_fast.visible = false;
         this.FScene.btn_stop.visible = false;
      }
      
      protected function Reset() : void
      {
         var _loc1_:TSingle = null;
         var _loc2_:String = null;
         _loc1_ = this.FSingleBins.GetDatebaseByIdentifier(this.FCurCampID) as TSingle;
         _loc2_ = _loc1_.Name;
         if(this.FScene.tf_title)
         {
            this.FScene.tf_title.text = _loc2_;
         }
         this.visible = true;
         this.FStatus = AutoStatus_Begin;
         this.Updata();
      }
      
      protected function set TotleTimer(param1:int) : void
      {
         this.FTotleTimer = param1;
         if(this.FScene.tf_timer)
         {
            this.FScene.tf_timer.text = TGameUtil.fomatTime(this.FTotleTimer);
         }
      }
      
      protected function get TotleTimer() : int
      {
         return this.FTotleTimer;
      }
      
      protected function UpdataRunTimer() : void
      {
         --this.TotleTimer;
         if(this.TotleTimer <= 0)
         {
            clearInterval(this.FStartRunTimerID);
            this.FStartRunTimerID = 0;
         }
      }
      
      protected function OnSureFastFight(param1:Object) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_LOBBY_WorldMap_GoldFastAutoBattle);
         _loc3_ = _loc2_.Data;
         _loc3_.writeByte(CONST_BATTLE.BattleType_Camp);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function OnSureStop(param1:Object) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_LOBBY_WorldMap_StopAutoBattle);
         _loc3_ = _loc2_.Data;
         _loc3_.writeByte(CONST_BATTLE.BattleType_Camp);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
         clearTimeout(this.FAutoUpdataUITimerID);
         this.FAutoUpdataUIStatus = false;
         this.FStatus = AutoStatus_End;
         this.Updata();
         this.TotleTimer = 0;
         clearInterval(this.FStartRunTimerID);
         this.FStartRunTimerID = 0;
      }
      
      protected function OnStopFight(param1:MouseEvent) : void
      {
         if(this.FStatus == AutoStatus_Begin)
         {
            return;
         }
         this.FWindowConfirmationStop.Visible = true;
      }
      
      protected function OnFastFight(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(this.FNodalAutoBattleFBInfo.BattleResult.length > 0)
         {
            return;
         }
         _loc2_ = int((this.FTotleTimer - 1) / 60 + 1) * this.FAutoTimeGold;
         if(_loc2_ > this.FCharacter.CreditGold + this.FCharacter.CreditGiftCertificate)
         {
            EffectGenerateText(STRING_WORLDMAP.STRINGS_GoldNotEnough);
            return;
         }
         this.FWindowConfirmationFast.Text = AutoNodal_FastInfo.split("%count%").join(_loc2_);
         this.FWindowConfirmationFast.Visible = true;
      }
      
      public function set BackFunction(param1:Function) : void
      {
         this.FBackFunction = param1;
      }
      
      protected function OnCancel(param1:MouseEvent) : void
      {
         if(this.FStatus != AutoStatus_Begin)
         {
            this.visible = false;
         }
         this.FCharacter.RoleSencePosition = CONST_COMMON.SCENEPOSITION_WORLDMAP;
         if(this.FBackFunction != null)
         {
            this.FBackFunction();
         }
      }
      
      protected function OnReset(param1:MouseEvent) : void
      {
         this.visible = false;
         if(this.FBackFunction != null)
         {
            this.FBackFunction();
         }
      }
      
      public function get StatusEnd() : Boolean
      {
         return this.FStatus == AutoStatus_End;
      }
      
      public function get OnEndAutoCamp() : Function
      {
         return this.FOnEndAutoCamp;
      }
      
      public function set OnEndAutoCamp(param1:Function) : void
      {
         this.FOnEndAutoCamp = param1;
      }
      
      public function OpenWindow() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         this.FCurCampID = this.FNodalAutoBattleFBInfo.BattleID;
         this.Reset();
         _loc2_ = uint(this.FAutoScrollBar.Count);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.FFreeAutoTurnUIVect.push(this.FAutoScrollBar.Items[_loc1_]);
            _loc1_++;
         }
         this.FAutoScrollBar.Clear();
         this.FScene.mc_left_falling.gotoAndPlay(1);
         this.FScene.mc_right_falling.gotoAndPlay(1);
         this.FCharacter.RoleSencePosition = CONST_COMMON.SCENEPOSITION_BATTLESENCE_AUTO;
      }
      
      public function PacketPerform_SC_AutoBattleInfo(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:TSingle = null;
         this.FAutoScrollBar.Clear();
         _loc2_ = param1.Data;
         this.FStatus = AutoStatus_Begin;
         this.FShowResult = false;
         this.UnstreamizerAutoBattleFBInfo.Unstreamize(_loc2_,this.FNodalAutoBattleFBInfo,null);
         this.FAutoCount = this.FNodalAutoBattleFBInfo.BattleResult.length;
         this.Updata();
         this.TotleTimer = this.FNodalAutoBattleFBInfo.CostTimer = 0;
         if(!this.FAutoUpdataUIStatus)
         {
            this.FAutoUpdataUITimerID = setTimeout(this.UpdataAutoUI,UPDATA_TIMESTAMP);
         }
         _loc3_ = this.FSingleBins.GetDatebaseByIdentifier(this.FNodalAutoBattleFBInfo.BattleID) as TSingle;
         if(this.FStartRunTimerID <= 0)
         {
            this.FStartRunTimerID = setInterval(this.UpdataRunTimer,1000);
            this.FScene.tf_turn.text = 0 + "/" + this.FNodalAutoBattleFBInfo.TotleCount;
            this.FScene.tf_status.text = _loc3_.Hard;
            this.FAutoBattleResultCount = 1;
         }
         this.FCampaignModel = SLogicsCore.Nodal.GetCampaignById(_loc3_.Campaign);
         if(this.FCampaignModel.Diffculty < 0)
         {
            ++this.FCampaignModel.EnterCount;
         }
         if(this.FCampaignModel.HardCampId == this.FNodalAutoBattleFBInfo.BattleID)
         {
            this.FCampaignModel.Diffculty = TCampaign.Type_Hard;
         }
         else if(this.FCampaignModel.NormalCampId == this.FNodalAutoBattleFBInfo.BattleID)
         {
            this.FCampaignModel.Diffculty = TCampaign.Type_Noraml;
         }
      }
   }
}

