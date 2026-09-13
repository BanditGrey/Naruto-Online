package Processors.Game.Lobby.WorldMap
{
   import Components.ScrollBar.*;
   import Foundation.Common.*;
   import Foundation.Network.*;
   import Foundation.Resources.*;
   import Foundation.Resources.Bins.*;
   import Foundation.Resources.Strings.*;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.*;
   import Logics.Campaign.*;
   import Logics.Campaign.AutoBattle.*;
   import Logics.Characters.TCharacter;
   import Logics.DatebaseVO.VO.*;
   import Logics.Streamization.Campaign.*;
   import Logics.Vip.TVip;
   import Processors.Game.Lobby.Common.*;
   import Processors.Game.Windows.Information.*;
   import Rendering.Texts.*;
   import Resources.Constants.*;
   import Resources.Strings.*;
   import Utilities.UI.Windows.*;
   import flash.display.*;
   import flash.events.*;
   import flash.filters.*;
   import flash.text.*;
   import flash.utils.*;
   
   public class TAutoNodal extends TProcessorLobbyWindow
   {
      
      public static const STRINGS_SureFastAutoNodalCopy:String = STRING_WORLDMAP.STRINGS_SureFastAutoNodalCopy;
      
      public static const SIZE_Window_Width:uint = 687;
      
      public static const SIZE_Window_Height:uint = 532;
      
      protected static const AutoStatus_Open:int = 1;
      
      protected static const AutoStatus_Begin:int = 2;
      
      protected static const AutoStatus_End:int = 3;
      
      protected static const AutoInitCount:int = 10;
      
      protected static const AUTO_TIME_GOLD_ID:int = 60101016;
      
      protected static const UPDATA_TIMESTAMP:int = 500;
      
      protected static const MonstorTextFilter:GlowFilter = new GlowFilter(4397068,1,2,2,5);
      
      protected var FNodalAutoInfo:TNodalAutoMonsterInfo;
      
      protected var FStatus:int;
      
      protected var FAutoCount:int;
      
      protected var FMaxCount:int;
      
      protected var FCurCityID:int;
      
      protected var FCurMissionID:int;
      
      protected var FScene:MovieClip;
      
      protected var FAutoBattleResultCount:int;
      
      protected var FTotleTurn:int;
      
      protected var FCurTurn:int;
      
      protected var FTotleExp:int;
      
      protected var FTotleMoney:int;
      
      protected var FTotleTimer:int;
      
      protected var FMonsterScrollBar:TScrollBar;
      
      protected var FAutoScrollBar:TScrollBar;
      
      protected var FNodalAutoBattleInfo:TNodalAutoBattleInfo;
      
      protected var UnstreamizerAutoBattleInfo:TUnstreamizerAutoBattleInfo;
      
      protected var FAutoInitTimer:int;
      
      protected var FAutoUpdataUIStatus:Boolean;
      
      protected var FAutoUpdataUITimerID:uint;
      
      protected var FStartRunTimerID:uint;
      
      protected var FWindowConfirmationStop:TUIWindowConfirmation;
      
      protected var FWindowConfirmationFast:TUIWindowConfirmation;
      
      protected var FUIWindowRecharge:TUIWindowRecharge;
      
      protected var FBackground:Sprite;
      
      protected var FBlockPointBins:TBins;
      
      protected var FEnemyBins:TBins;
      
      protected var FTextEffect_Title:TextField;
      
      protected var FAutoTimeGold:uint;
      
      protected var FFreeMonsterTextFieldVect:Vector.<TextField>;
      
      protected var FFreeAutoTurnUIVect:Vector.<TAutoTurnUI>;
      
      protected var FIsInit:Boolean;
      
      protected var FCharacter:TCharacter;
      
      protected var FIsFast:Boolean;
      
      protected var FVipData:TVip;
      
      protected var FContinueAutoCount:int;
      
      protected var FContinueStartTime:uint;
      
      protected var FIsContinue:Boolean;
      
      protected var FAutoFightTip:MovieClip;
      
      protected var FAccelerationCardId:uint = 14107120;
      
      protected var FOnCheckTask:Function;
      
      protected var FOnTurnBackWorldMap:Function;
      
      protected var FOnNotifyMainSceneIntoAutoBattle:Function;
      
      protected var FOnSmallAutoBattle:Function;
      
      protected var initilization:Boolean = false;
      
      public function TAutoNodal(param1:TUIComponent)
      {
         var _loc2_:TConfigValue = null;
         super(param1);
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
         this.FFreeMonsterTextFieldVect = new Vector.<TextField>();
         this.FFreeAutoTurnUIVect = new Vector.<TAutoTurnUI>();
         this.FCharacter = SLogicsCore.Character;
         this.FVipData = this.FCharacter.VipData;
         this.FBlockPointBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_BlockPoint);
         this.FEnemyBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Enemy);
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,AUTO_TIME_GOLD_ID) as TConfigValue;
         this.FAutoTimeGold = _loc2_.Value as uint;
         this.FNodalAutoBattleInfo = new TNodalAutoBattleInfo();
         this.UnstreamizerAutoBattleInfo = new TUnstreamizerAutoBattleInfo();
         this.FIsContinue = false;
         this.FIsInit = false;
         Load();
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_CAMPAIGN.RESOURCESID_Mission);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIWait() : void
      {
         if(SResourcesCore.LoadingPrimary)
         {
            return;
         }
         this.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.InitAutoNodal();
         this.OpenWindow(this.FNodalAutoInfo);
         if(this.FIsContinue)
         {
            this.CurTurn = 0;
            this.TotleTurn = this.FContinueAutoCount;
            this.AutoCount = this.FContinueAutoCount;
            this.TotleTimer -= STimingCore.GetServerTick() - this.FContinueStartTime;
            this.FStatus = AutoStatus_Begin;
         }
         this.Updata();
         this.initilization = true;
         super.ResourcesPerform_UIDispatch();
      }
      
      protected function UpdataAutoUI() : void
      {
         var _loc1_:TTurnResult = null;
         var _loc2_:TAutoTurnUI = null;
         if(this.FScene == null)
         {
            return;
         }
         if(this.FStatus == AutoStatus_Begin)
         {
            if(this.FNodalAutoBattleInfo.BattleResult.length > 0)
            {
               _loc1_ = this.FNodalAutoBattleInfo.BattleResult.shift();
               this.FScene.tf_turn.text = this.FAutoBattleResultCount + "/" + this.FAutoCount;
               if(this.FFreeAutoTurnUIVect.length > 0)
               {
                  _loc2_ = this.FFreeAutoTurnUIVect.pop();
               }
               else
               {
                  _loc2_ = new TAutoTurnUI(null);
               }
               _loc2_.SetTurnResult(_loc1_,this.FAutoBattleResultCount++);
               this.FAutoScrollBar.AddItem(_loc2_);
               this.TotleExp += _loc2_.TotleExp;
               this.TotleMoney += _loc2_.TotleMoney;
               if(this.FOnCheckTask != null)
               {
                  this.FOnCheckTask(this.FCurMissionID,1);
               }
            }
            if(this.FNodalAutoBattleInfo.BattleResult.length > 0)
            {
               this.FAutoUpdataUIStatus = true;
               clearTimeout(this.FAutoUpdataUITimerID);
               this.FAutoUpdataUITimerID = setTimeout(this.UpdataAutoUI,UPDATA_TIMESTAMP);
            }
            else
            {
               clearTimeout(this.FAutoUpdataUITimerID);
               this.FAutoUpdataUIStatus = false;
               if(this.FNodalAutoBattleInfo.CostTimer <= 0 && this.FAutoBattleResultCount >= this.FAutoCount)
               {
                  this.FStatus = AutoStatus_End;
                  this.Updata();
                  if(this.FOnNotifyMainSceneIntoAutoBattle != null)
                  {
                     this.FOnNotifyMainSceneIntoAutoBattle(this,false,0);
                  }
               }
            }
         }
      }
      
      protected function InitAutoNodal() : void
      {
         this.FIsInit = true;
         this.FAutoBattleResultCount = 1;
         this.FAutoUpdataUIStatus = false;
         this.FAutoInitTimer = 180;
         this.FScene = TUtilityReflection.CreateDisplayObjectInstance(CONST_CAMPAIGN.RESOURCE_ClassName_AutoBattle) as MovieClip;
         addChildAt(this.FScene,1);
         this.FAutoFightTip = this.FScene["MC_AutoFight"];
         this.FAutoFightTip.visible = false;
         TGameUtil.setButtonMode(this.FScene.btn_fight,true);
         this.FScene.btn_fight.addEventListener(MouseEvent.CLICK,this.OnStartFight);
         TGameUtil.setButtonMode(this.FScene.btn_stop,true);
         this.FScene.btn_stop.addEventListener(MouseEvent.CLICK,this.OnStopFight);
         TGameUtil.setButtonMode(this.FScene.btn_fast,true);
         this.FScene.btn_fast.addEventListener(MouseEvent.CLICK,this.OnFastFight);
         TGameUtil.setButtonMode(this.FScene.btn_back,true);
         this.FScene.btn_back.addEventListener(MouseEvent.CLICK,this.OnReset);
         this.FScene.btn_close.addEventListener(MouseEvent.CLICK,this.OnCancel);
         TGameUtil.setButtonMode(this.FScene.btn_max,true);
         this.FScene.btn_max.addEventListener(MouseEvent.CLICK,this.OnMax);
         (this.FScene.tf_countInput as TextField).restrict = "0-9";
         this.FScene.tf_countInput.addEventListener(Event.CHANGE,this.OnInput);
         this.FMonsterScrollBar = new TScrollBar(this.FScene.ta_monsterInfo,100);
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
         this.FUIWindowRecharge = new TUIWindowRecharge(this.Parent);
         this.FUIWindowRecharge.x = (CONST_COMMON.STAGE_Width - this.FUIWindowRecharge.WindowWidth) / 2;
         this.FUIWindowRecharge.y = (CONST_COMMON.STAGE_Height - this.FUIWindowRecharge.WindowHeight) / 2 - 20;
         TUtilityUIWindow.SetupWindowRecharge(this.FUIWindowRecharge);
         if(this.FScene.btn_small != null)
         {
            TGameUtil.setButtonMode(this.FScene.btn_small,true);
            this.FScene.btn_small.addEventListener(MouseEvent.CLICK,this.OnSmall);
         }
         this.FTextEffect_Title = this.FScene.tf_title;
      }
      
      protected function Updata() : void
      {
         if(!this.FIsInit)
         {
            return;
         }
         this.FScene.tf_vipConfig.visible = false;
         this.FScene.btn_fight.visible = false;
         this.FScene.btn_stop.visible = false;
         this.FScene.btn_fast.visible = false;
         this.FScene.btn_back.visible = false;
         this.FScene.tf_bg.visible = false;
         this.FScene.btn_small.visible = false;
         this.FAutoFightTip.visible = false;
         this.FScene.btn_max.visible = false;
         this.FScene.tf_countInput.mouseEnabled = false;
         if(this.FStatus == AutoStatus_Open)
         {
            this.FScene.tf_vipConfig.visible = true;
            this.FScene.btn_fight.visible = true;
            this.FScene.tf_bg.visible = true;
            this.FScene.btn_max.visible = true;
            this.FScene.tf_countInput.mouseEnabled = true;
         }
         else if(this.FStatus == AutoStatus_Begin)
         {
            this.FScene.tf_vipConfig.visible = true;
            this.FScene.btn_stop.visible = true;
            this.FScene.btn_fast.visible = true;
            this.FScene.btn_small.visible = true;
            this.AutoFightTipIsShow();
         }
         else if(this.FStatus == AutoStatus_End)
         {
            this.FScene.btn_back.visible = true;
         }
         this.UpdataCampaignName();
      }
      
      protected function Reset() : void
      {
         this.visible = true;
         if(this.FAutoScrollBar != null)
         {
            this.FAutoScrollBar.Clear();
         }
         this.FMaxCount = this.FCharacter.CreditMilitaryOrders + this.FCharacter.CreditMilitaryOrdersBuff;
         this.FStatus = AutoStatus_Open;
         this.AutoCount = Math.min(AutoInitCount,this.FMaxCount);
         this.TotleTurn = 0;
         this.CurTurn = 0;
         this.TotleExp = 0;
         this.TotleMoney = 0;
         this.FIsFast = false;
         this.Updata();
      }
      
      protected function UpdataCampaignName() : void
      {
         var _loc1_:String = null;
         var _loc2_:TBlockPoint = null;
         _loc2_ = this.FBlockPointBins.GetDatebaseByIdentifier(this.FCurMissionID) as TBlockPoint;
         _loc1_ = _loc2_.Name;
         if(this.FTextEffect_Title)
         {
            this.FTextEffect_Title.text = _loc1_;
         }
      }
      
      protected function set AutoCount(param1:int) : void
      {
         this.FAutoCount = param1;
         if(Boolean(this.FScene) && Boolean(this.FScene.tf_countInput))
         {
            this.FScene.tf_countInput.text = String(param1);
         }
         this.TotleTimer = this.FAutoInitTimer * this.FAutoCount;
      }
      
      public function set TotleTimer(param1:int) : void
      {
         this.FTotleTimer = param1;
         if(Boolean(this.FScene) && Boolean(this.FScene.tf_timer))
         {
            this.FScene.tf_timer.text = TGameUtil.fomatTime(this.FTotleTimer);
         }
      }
      
      public function get TotleTimer() : int
      {
         return this.FTotleTimer;
      }
      
      protected function set TotleTurn(param1:int) : void
      {
         this.FTotleTurn = param1;
         if(Boolean(this.FScene) && Boolean(this.FScene.tf_turn))
         {
            this.FScene.tf_turn.text = String(this.FCurTurn) + "/" + String(this.FTotleTurn);
         }
      }
      
      protected function set CurTurn(param1:int) : void
      {
         this.FCurTurn = param1;
         if(Boolean(this.FScene) && Boolean(this.FScene.tf_turn))
         {
            this.FScene.tf_turn.text = String(this.FCurTurn) + "/" + String(this.FTotleTurn);
         }
      }
      
      protected function set TotleExp(param1:int) : void
      {
         this.FTotleExp = param1;
         if(Boolean(this.FScene) && Boolean(this.FScene.tf_totleExp))
         {
            if(this.FTotleExp == 0)
            {
               this.FScene.tf_totleExp.text = String(this.FTotleExp);
            }
            else
            {
               this.FScene.tf_totleExp.text = String("+" + this.FTotleExp);
            }
         }
      }
      
      protected function get TotleExp() : int
      {
         return this.FTotleExp;
      }
      
      protected function set TotleMoney(param1:int) : void
      {
         this.FTotleMoney = param1;
         if(Boolean(this.FScene) && Boolean(this.FScene.tf_totleMoney))
         {
            if(this.FTotleMoney == 0)
            {
               this.FScene.tf_totleMoney.text = String(this.FTotleMoney);
            }
            else
            {
               this.FScene.tf_totleMoney.text = String("+" + this.FTotleMoney);
            }
         }
      }
      
      protected function get TotleMoney() : int
      {
         return this.FTotleMoney;
      }
      
      protected function UpdataRunTimer() : void
      {
         --this.TotleTimer;
         if(this.TotleTimer <= 0)
         {
            clearInterval(this.FStartRunTimerID);
         }
      }
      
      protected function OnSureFastFight(param1:Object) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_LOBBY_WorldMap_GoldFastAutoBattle);
         _loc3_ = _loc2_.Data;
         _loc3_.writeByte(CONST_BATTLE.BattleType_Nodal);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
         this.FIsFast = true;
         if(this.FOnNotifyMainSceneIntoAutoBattle != null)
         {
            this.FOnNotifyMainSceneIntoAutoBattle(this,false,0);
         }
      }
      
      protected function OnSureStop(param1:Object) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_LOBBY_WorldMap_StopAutoBattle);
         _loc3_ = _loc2_.Data;
         _loc3_.writeByte(CONST_BATTLE.BattleType_Nodal);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
         clearTimeout(this.FAutoUpdataUITimerID);
         this.FAutoUpdataUIStatus = false;
         this.FStatus = AutoStatus_End;
         this.Updata();
         this.TotleTimer = 0;
         clearInterval(this.FStartRunTimerID);
         this.FCharacter.RoleSencePosition = CONST_COMMON.SCENEPOSITION_WORLDMAP;
         if(this.FOnNotifyMainSceneIntoAutoBattle != null)
         {
            this.FOnNotifyMainSceneIntoAutoBattle(this,false,0);
         }
      }
      
      protected function OnStartFight(param1:MouseEvent) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         if(this.FStatus == AutoStatus_Begin)
         {
            return;
         }
         if(this.FAutoCount <= 0)
         {
            return;
         }
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_LOBBY_WorldMap_AutoBattle);
         _loc3_ = _loc2_.Data;
         _loc3_.writeInt(this.FCurCityID);
         _loc3_.writeInt(this.FCurMissionID);
         _loc3_.writeShort(this.FAutoCount);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
         this.FAutoBattleResultCount = 1;
         this.FStartRunTimerID = setInterval(this.UpdataRunTimer,1000);
         this.FScene.tf_turn.text = "0/" + this.FAutoCount;
         this.FStatus = AutoStatus_Begin;
         this.Updata();
         if(this.FOnNotifyMainSceneIntoAutoBattle != null)
         {
            this.FOnNotifyMainSceneIntoAutoBattle(this,true,this.TotleTimer + STimingCore.GetServerTick());
         }
         if(this.FAutoFightTip)
         {
            this.AutoFightTipIsShow();
         }
      }
      
      protected function OnStopFight(param1:MouseEvent) : void
      {
         if(this.FStatus != AutoStatus_Begin)
         {
            return;
         }
         if(this.FIsFast || this.FVipData.BlockTime)
         {
            EffectGenerateText(STRING_WORLDMAP.STRINGS_Fasting);
            return;
         }
         this.FWindowConfirmationStop.Visible = true;
      }
      
      protected function OnFastFight(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:TPacket = null;
         if(SLogicsCore.AutoFightString != STRING_COMMON.STRING_AutoFight_String)
         {
            _loc8_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_FreshGuide_Step2WriteReq);
            TUtilityString.FlushUTF(_loc8_.Data,STRING_COMMON.STRING_AutoFight_String);
            SNetworkCore.Transceiver.PacketTransmit(_loc8_);
            this.PacketC_S_AutoFight();
         }
         this.FAutoFightTip.visible = false;
         if(this.FIsFast || this.FVipData.BlockTime)
         {
            EffectGenerateText(STRING_WORLDMAP.STRINGS_Fasting);
            return;
         }
         if(this.FNodalAutoBattleInfo.BattleResult.length > 0)
         {
            return;
         }
         var _loc3_:int = (this.FTotleTimer - 1) / 60 + 1;
         var _loc4_:int = this.GetStuffNum();
         _loc2_ = _loc3_ * this.FAutoTimeGold;
         if(_loc2_ > this.FCharacter.CreditGold + this.FCharacter.CreditGiftCertificate + _loc4_ * 3)
         {
            this.FUIWindowRecharge.visible = true;
            return;
         }
         var _loc5_:String = "";
         if(_loc4_ >= this.FAutoCount)
         {
            _loc6_ = this.GetGoldTimes(_loc3_);
            _loc7_ = 0;
         }
         else
         {
            _loc6_ = _loc4_;
            _loc7_ = _loc2_ - _loc4_ * 3;
         }
         _loc5_ = TUtilityString.Format(STRINGS_SureFastAutoNodalCopy,_loc6_,_loc7_,this.GetStuffNum());
         this.FWindowConfirmationFast.Text = _loc5_;
         this.FWindowConfirmationFast.Visible = true;
      }
      
      public function PacketC_S_AutoFight() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_FreshGuide_Step2ReadReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      public function GetGoldTimes(param1:int) : int
      {
         var _loc3_:int = 0;
         var _loc2_:int = param1 % 3;
         if(_loc2_ == 0)
         {
            _loc3_ = param1 / 3;
         }
         else
         {
            _loc3_ = param1 / 3 + 1;
         }
         return _loc3_;
      }
      
      public function GetStuffNum() : int
      {
         return SLogicsCore.Character.Appliances.GetAllCountByTempletID(this.FAccelerationCardId);
      }
      
      protected function OnCancel(param1:MouseEvent) : void
      {
         if(this.FStatus == AutoStatus_Begin)
         {
            if(this.FIsFast || this.FVipData.BlockTime)
            {
               EffectGenerateText(STRING_WORLDMAP.STRINGS_Fasting);
               return;
            }
            this.FWindowConfirmationStop.Visible = true;
         }
         else
         {
            this.visible = false;
            if(this.FOnTurnBackWorldMap != null)
            {
               this.FOnTurnBackWorldMap(this,false);
            }
            this.FCharacter.RoleSencePosition = CONST_COMMON.SCENEPOSITION_WORLDMAP;
         }
      }
      
      protected function OnReset(param1:MouseEvent) : void
      {
         this.Reset();
      }
      
      protected function OnMax(param1:MouseEvent) : void
      {
         this.AutoCount = this.FMaxCount;
      }
      
      protected function OnInput(param1:Event) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(this.FScene.tf_countInput.text);
         if(_loc2_ > this.FMaxCount)
         {
            this.AutoCount = this.FMaxCount;
         }
         else
         {
            this.AutoCount = Math.max(_loc2_,0);
         }
      }
      
      protected function OnSmall(param1:MouseEvent) : void
      {
         if(this.FOnSmallAutoBattle != null)
         {
            this.FOnSmallAutoBattle(this);
         }
      }
      
      public function get OnCheckTask() : Function
      {
         return this.FOnCheckTask;
      }
      
      public function set OnCheckTask(param1:Function) : void
      {
         this.FOnCheckTask = param1;
      }
      
      public function get OnTurnBackWorldMap() : Function
      {
         return this.FOnTurnBackWorldMap;
      }
      
      public function set OnTurnBackWorldMap(param1:Function) : void
      {
         this.FOnTurnBackWorldMap = param1;
      }
      
      public function get OnNotifyMainSceneIntoAutoBattle() : Function
      {
         return this.FOnNotifyMainSceneIntoAutoBattle;
      }
      
      public function set OnNotifyMainSceneIntoAutoBattle(param1:Function) : void
      {
         this.FOnNotifyMainSceneIntoAutoBattle = param1;
      }
      
      public function get OnSmallAutoBattle() : Function
      {
         return this.FOnSmallAutoBattle;
      }
      
      public function set OnSmallAutoBattle(param1:Function) : void
      {
         this.FOnSmallAutoBattle = param1;
      }
      
      public function get IsAutoBattle() : Boolean
      {
         return this.FStatus == AutoStatus_Begin;
      }
      
      public function set AccelerationCardId(param1:uint) : void
      {
         this.FAccelerationCardId = param1;
      }
      
      public function get AccelerationCardId() : uint
      {
         return this.FAccelerationCardId;
      }
      
      public function OpenWindow(param1:TNodalAutoMonsterInfo) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TextField = null;
         var _loc5_:TMonster = null;
         var _loc6_:TEnemy = null;
         var _loc7_:uint = 0;
         var _loc4_:String = "";
         if(param1 == null)
         {
            return;
         }
         this.FNodalAutoInfo = param1;
         this.FCurCityID = param1.CurAutoCityId;
         this.FCurMissionID = param1.CurAutoMissionId;
         this.FMaxCount = this.FCharacter.CreditMilitaryOrders + this.FCharacter.CreditMilitaryOrdersBuff;
         this.FAutoInitTimer = this.FNodalAutoInfo.CostTime;
         this.FIsFast = false;
         this.Reset();
         if(this.FAutoScrollBar != null)
         {
            _loc7_ = uint(this.FAutoScrollBar.Count);
            _loc2_ = 0;
            while(_loc2_ < _loc7_)
            {
               this.FFreeAutoTurnUIVect.push(this.FAutoScrollBar.Items[_loc2_]);
               _loc2_++;
            }
            this.FAutoScrollBar.Clear();
         }
         if(this.FMonsterScrollBar != null)
         {
            _loc7_ = uint(this.FMonsterScrollBar.Count);
            _loc2_ = 0;
            while(_loc2_ < _loc7_)
            {
               this.FFreeMonsterTextFieldVect.push(this.FMonsterScrollBar.Items[_loc2_]);
               _loc2_++;
            }
            this.FMonsterScrollBar.Clear();
            _loc2_ = 0;
            while(_loc2_ < this.FNodalAutoInfo.HootMonster.length)
            {
               _loc5_ = this.FNodalAutoInfo.HootMonster[_loc2_];
               if(this.FFreeMonsterTextFieldVect.length > 0)
               {
                  _loc3_ = this.FFreeMonsterTextFieldVect.pop();
               }
               else
               {
                  _loc3_ = new TextField();
                  _loc3_.mouseEnabled = false;
               }
               _loc6_ = this.FEnemyBins.GetDatebaseByIdentifier(_loc5_.Identifier) as TEnemy;
               _loc4_ = _loc6_.Name;
               _loc3_.textColor = 16180909;
               _loc3_.filters = [MonstorTextFilter];
               _loc4_ += "    \tLv." + _loc5_.MonsterLevel;
               _loc4_ = _loc4_ + ("    \t*" + _loc5_.MonsterCount);
               _loc3_.text = _loc4_;
               _loc3_.width = _loc3_.textWidth + 10;
               _loc3_.height = _loc3_.textHeight + 3;
               this.FMonsterScrollBar.AddItem(_loc3_);
               _loc2_++;
            }
         }
         if(this.FScene)
         {
            this.FScene.mc_left_falling.gotoAndPlay(1);
            this.FScene.mc_right_falling.gotoAndPlay(1);
         }
         this.FCharacter.RoleSencePosition = CONST_COMMON.SCENEPOSITION_BATTLESENCE_AUTO;
         Visible = true;
      }
      
      public function PacketPerform_SC_AutoBattleInfo(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = param1.Data;
         this.FStatus = AutoStatus_Begin;
         this.UnstreamizerAutoBattleInfo.Unstreamize(_loc2_,this.FNodalAutoBattleInfo,null);
         this.Updata();
         this.TotleTimer = this.FNodalAutoBattleInfo.CostTimer;
         if(!this.FAutoUpdataUIStatus)
         {
            this.FAutoUpdataUITimerID = setTimeout(this.UpdataAutoUI,UPDATA_TIMESTAMP);
         }
      }
      
      public function ContinueAutoBattleCount(param1:int, param2:uint, param3:Boolean) : void
      {
         this.FIsContinue = true;
         this.FContinueAutoCount = param1;
         this.FContinueStartTime = param2;
         this.FIsFast = param3;
         this.FStatus = AutoStatus_Begin;
         this.Updata();
         this.FStartRunTimerID = setInterval(this.UpdataRunTimer,1000);
      }
      
      public function ContinueAutoBattle(param1:ByteArray) : void
      {
         this.UnstreamizerAutoBattleInfo.Unstreamize(param1,this.FNodalAutoBattleInfo,null);
         if(!this.FAutoUpdataUIStatus)
         {
            this.FAutoUpdataUITimerID = setTimeout(this.UpdataAutoUI,UPDATA_TIMESTAMP);
         }
      }
      
      public function AutoFightTipIsShow() : void
      {
         if(this.FVipData.BlockTime)
         {
            this.FAutoFightTip.visible = false;
         }
         else if(SLogicsCore.AutoFightString == STRING_COMMON.STRING_AutoFight_String)
         {
            this.FAutoFightTip.visible = false;
         }
         else
         {
            this.FAutoFightTip.visible = true;
         }
      }
   }
}

