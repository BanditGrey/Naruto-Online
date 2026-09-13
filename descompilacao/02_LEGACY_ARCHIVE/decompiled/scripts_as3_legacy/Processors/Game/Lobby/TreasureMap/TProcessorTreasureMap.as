package Processors.Game.Lobby.TreasureMap
{
   import Foundation.Common.*;
   import Foundation.Network.*;
   import Foundation.Resources.*;
   import Foundation.Resources.Bins.*;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.*;
   import Logics.Characters.*;
   import Logics.DatebaseVO.VO.*;
   import Logics.Inventories.*;
   import Logics.Streamization.TreasureMap.*;
   import Logics.TimeCoolDown.*;
   import Logics.TreasureMap.*;
   import Processors.Game.Lobby.Common.*;
   import Rendering.Overlayers.HelpTips.TOverlayerHelpTips;
   import Rendering.Overlayers.Hints.*;
   import Rendering.Overlayers.Inventories.*;
   import Resources.Constants.*;
   import Resources.Strings.*;
   import Utilities.UI.Overlayers.*;
   import flash.display.*;
   import flash.events.*;
   import flash.utils.*;
   
   public class TProcessorTreasureMap extends TProcessorLobbyPlate
   {
      
      protected static const TreasureBaseDataHeight:int = 240;
      
      public static var FIsOpenNewProof:int = 0;
      
      protected var FScene:MovieClip;
      
      protected var FIsInit:Boolean;
      
      protected var FTimeCoolDown:TTimeCoolDown;
      
      protected var FOverlayerAppliance:TOverlayerAppliance;
      
      protected var FOverlayerHint:TOverlayerHint;
      
      protected var FOverlayerHelpTips:TOverlayerHelpTips;
      
      protected var FTreasureMapData:TTreasureMapData;
      
      protected var UnstreamizerTreasureMap:TUnstreamizerTreasureMap;
      
      protected var FProcessorWindowTreasureMap:TProcessorWindowTreasureMap;
      
      protected var FProcessorWindowTreasureMapGame:TProcessorWindowTreasureMapGame;
      
      protected var FProcessorWindowMapSelect:TProcessorWindowMapSelect;
      
      protected var FProcessorWindowHeros:TProcessorWindowHeros;
      
      protected var FProcessorHeroTips:TProcessorHeroTips;
      
      protected var FProcessorOldProofChange:TProcessorOldProofChange;
      
      protected var FProcessorNewProofChange:TProcessorNewProofChange;
      
      protected var FCharacter:TCharacter;
      
      protected var FDiggingBins:TBins;
      
      protected var FHelpHint:THint;
      
      protected var FOnReturnMainScene:Function;
      
      protected var FSetStatusType:Function;
      
      protected var FSetBattlePacket:Function;
      
      protected var FOnInitBattle:Function;
      
      protected var FProofSeeNinJa:Function;
      
      public function TProcessorTreasureMap(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FIsInit = false;
         this.FTimeCoolDown = new TTimeCoolDown(CONST_COMMON.TIME_COOLDOWN_TreasureMap);
         SLogicsCore.Character.TimeCoolDowns.Add(this.FTimeCoolDown);
         this.FTreasureMapData = new TTreasureMapData();
         this.UnstreamizerTreasureMap = new TUnstreamizerTreasureMap();
         SetUIModuleID(CONST_MODULES.MODULE_TreasureMap);
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         if(this.FProcessorWindowTreasureMap != null && this.FProcessorWindowTreasureMap.Visible == true)
         {
            this.FProcessorWindowTreasureMap.UpdataColdDown();
            this.FProcessorWindowTreasureMap.UpdataEffect();
            this.FProcessorNewProofChange.update();
            this.FProcessorOldProofChange.updatecell();
         }
         if(this.FProcessorWindowMapSelect != null && this.FProcessorWindowMapSelect.Visible == true)
         {
            this.FProcessorWindowMapSelect.UpdataBitmp();
         }
         if(this.FProcessorWindowHeros != null && this.FProcessorWindowHeros.Visible == true)
         {
            this.FProcessorWindowHeros.UpdataTimeLine();
         }
         if(this.FProcessorHeroTips != null && this.FProcessorHeroTips.Visible == true)
         {
            this.FProcessorHeroTips.UpdataColdDown();
            this.FProcessorHeroTips.CheckTipPoint();
         }
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_TREASUREMAP.RESOURCE_TREASUREMAP);
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
         var _loc1_:TSystemLanguage = null;
         this.InitTreasureMap();
         this.FOverlayerAppliance = new TOverlayerAppliance(this,CONST_MODULES.MODULE_TreasureMap);
         this.FOverlayerAppliance.Visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerAppliance);
         this.FOverlayerHint = new TOverlayerHint(this);
         this.FOverlayerHint.visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerHint);
         this.FOverlayerHelpTips = new TOverlayerHelpTips(this);
         this.FOverlayerHelpTips.Visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerHelpTips);
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.HELPTIPS_TTREASURESEARCH) as TSystemLanguage;
         this.FHelpHint = new THint();
         this.FHelpHint.Content = _loc1_.Desc;
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TreasureMap_StartRet,this.PacketPerform_SC_TreasureMap_StartRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TreasureMap_RefreshRet,this.PacketPerform_SC_TreasureMap_RefreshRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TreasureMap_OpenMapRet,this.PacketPerform_SC_TreasureMap_OpenMapRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TreasureMap_FastRet,this.PacketPerform_SC_TreasureMap_FastRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TreasureMap_FightRet,this.PacketPerform_SC_TreasureMap_FightRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TreasureMap_UpdataMapHero,this.PacketPerform_SC_TreasureMap_UpdataMapHero);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TreasureMap_AddReportData,this.PacketPerform_SC_TreasureMap_AddReportData);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TreasureMap_FightOk,this.PacketPerform_SC_TreasureMap_FightOk);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TreasureMap_UpdataUserBaseInfo,this.PacketPerform_SC_TreasureMap_UpdataUserBaseInfo);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TreasureMap_NewProof,this.PacketPerform_SC_TreasureMap_New);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TreasureMap_OldProof,this.PacketPerform_SC_TreasureMap_Old);
      }
      
      protected function PacketPerform_SC_Enter_TreasureMap(param1:ByteArray) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         _loc3_ = param1.readUnsignedInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         this.UnstreamizerTreasureMap.Unstreamize(param1,this.FTreasureMapData,null);
         this.FIsInit = true;
         this.FProcessorWindowTreasureMap.SetTreasureMapData(this.FTreasureMapData);
         this.FProcessorWindowMapSelect.SetTreasureMapData(this.FTreasureMapData);
         this.FProcessorWindowHeros.SetTreasureMapData(this.FTreasureMapData);
      }
      
      protected function PacketPerform_SC_TreasureMap_StartRet(param1:TPacket) : void
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
         this.FTreasureMapData.TreasureStatus = true;
         this.FTreasureMapData.CurEnterTimes += 1;
         this.UnstreamizerTreasureMap.UnstreamizeTreasureMapHero(_loc2_,this.FTreasureMapData.FightHeroList,null);
         this.FProcessorWindowTreasureMap.SetTreasureMapData(this.FTreasureMapData);
         this.FProcessorWindowMapSelect.SetTreasureMapData(this.FTreasureMapData);
         this.FProcessorWindowHeros.SetTreasureMapData(this.FTreasureMapData);
         ProcessorOnCheckIconStatus(CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_TreasureMap,this.FTreasureMapData.CheckStatus());
      }
      
      protected function PacketPerform_SC_TreasureMap_RefreshRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:String = null;
         var _loc6_:TDigging = null;
         _loc2_ = param1.Data;
         this.FProcessorWindowMapSelect.SetBtnEnable(true);
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc4_ = _loc2_.readUnsignedInt();
         if(_loc4_ != this.FTreasureMapData.CurQuality)
         {
            _loc6_ = this.FDiggingBins.GetDatebaseByIdentifier(_loc4_) as TDigging;
            _loc5_ = STRING_TREASUREMAP.STRING_RefreshWin;
            _loc5_ = _loc5_.split("%name%").join(_loc6_.Name);
            EffectGenerateText(_loc5_);
         }
         else
         {
            _loc5_ = STRING_TREASUREMAP.STRING_RefreshLost;
            EffectGenerateText(_loc5_);
         }
         this.FTreasureMapData.CurQuality = _loc4_;
         this.FTreasureMapData.CurRefreshTimes += 1;
         this.FProcessorWindowTreasureMap.SetTreasureMapData(this.FTreasureMapData);
         this.FProcessorWindowMapSelect.SetTreasureMapData(this.FTreasureMapData);
      }
      
      protected function PacketPerform_SC_TreasureMap_OpenMapRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:String = null;
         var _loc6_:TDigging = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc4_ = _loc2_.readUnsignedInt();
         if(_loc4_ != this.FTreasureMapData.CurQuality)
         {
            _loc6_ = this.FDiggingBins.GetDatebaseByIdentifier(_loc4_) as TDigging;
            _loc5_ = STRING_TREASUREMAP.STRING_RefreshWin;
            _loc5_ = _loc5_.split("%name%").join(_loc6_.Name);
            EffectGenerateText(_loc5_);
         }
         else
         {
            _loc5_ = STRING_TREASUREMAP.STRING_RefreshLost;
            EffectGenerateText(_loc5_);
         }
         this.FTreasureMapData.CurQuality = _loc4_;
         this.FProcessorWindowMapSelect.SetTreasureMapData(this.FTreasureMapData);
      }
      
      protected function PacketPerform_SC_TreasureMap_FastRet(param1:TPacket) : void
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
         this.FTreasureMapData.CurQuality = 101;
         this.FTreasureMapData.TreasureStatus = false;
         this.FTreasureMapData.CurRefreshTimes = 0;
         this.Send_C_S_Initilization();
         this.FProcessorWindowTreasureMap.SetTreasureMapData(this.FTreasureMapData);
         this.FProcessorWindowMapSelect.SetTreasureMapData(this.FTreasureMapData);
         this.FProcessorWindowHeros.SetTreasureMapData(this.FTreasureMapData);
         ProcessorOnCheckIconStatus(CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_TreasureMap,this.FTreasureMapData.CheckStatus());
      }
      
      protected function PacketPerform_SC_TreasureMap_FightRet(param1:TPacket) : void
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
         if(this.FSetBattlePacket != null)
         {
            this.FSetBattlePacket(this,param1);
         }
      }
      
      protected function PacketPerform_SC_TreasureMap_UpdataMapHero(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:Boolean = false;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         this.UnstreamizerTreasureMap.UnstreamizeTreasureMapHero(_loc2_,this.FTreasureMapData.FightHeroList,null);
         if(this.FProcessorWindowHeros == null)
         {
            return;
         }
         _loc4_ = this.FProcessorWindowHeros.SetTreasureMapData(this.FTreasureMapData);
         if(_loc4_)
         {
            this.FProcessorWindowMapSelect.SetTreasureMapData(this.FTreasureMapData);
            this.FProcessorWindowTreasureMap.SetTreasureMapData(this.FTreasureMapData);
         }
      }
      
      protected function PacketPerform_SC_TreasureMap_AddReportData(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = param1.Data;
         this.UnstreamizerTreasureMap.UnstreamizeTreasureMapReport(_loc2_,this.FTreasureMapData.ReportList,null);
         if(this.FProcessorWindowTreasureMap == null)
         {
            return;
         }
         this.FProcessorWindowTreasureMap.SetTreasureMapData(this.FTreasureMapData);
      }
      
      protected function PacketPerform_SC_TreasureMap_FightOk(param1:TPacket) : void
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
         this.OnSetStatusType(this,CONST_BATTLE.BattleType_TreasureMap,0);
         if(this.FOnInitBattle != null)
         {
            this.FOnInitBattle(this);
         }
      }
      
      protected function PacketPerform_SC_TreasureMap_UpdataUserBaseInfo(param1:TPacket) : void
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
         this.UnstreamizerTreasureMap.Unstreamize(_loc2_,this.FTreasureMapData,null);
         if(!FIsResourcesLoadCompleted)
         {
            return;
         }
         this.FProcessorWindowTreasureMap.SetTreasureMapData(this.FTreasureMapData);
         this.FProcessorWindowMapSelect.SetTreasureMapData(this.FTreasureMapData);
         this.FProcessorWindowHeros.SetTreasureMapData(this.FTreasureMapData);
      }
      
      protected function PacketPerform_SC_TreasureMap_New(param1:TPacket) : void
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
         this.FProcessorNewProofChange.ChangeSucceed();
         this.FProcessorWindowTreasureMap.OpenMe();
      }
      
      protected function PacketPerform_SC_TreasureMap_Old(param1:TPacket) : void
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
         this.FProcessorOldProofChange.ChangeSucceed();
         this.FProcessorWindowTreasureMap.OpenMe();
      }
      
      protected function InitTreasureMap() : void
      {
         this.FDiggingBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Digging);
         this.FCharacter = SLogicsCore.Character;
         this.FScene = TUtilityReflection.CreateDisplayObjectInstance(CONST_TREASUREMAP.RESOURCE_ClassName_MC_TreasureMap) as MovieClip;
         addChild(this.FScene);
         this.FScene.mc_StartMovie.visible = false;
         this.FScene.mc_autoPoint.btn_close.addEventListener(MouseEvent.CLICK,this.OnClose);
         this.FScene.mc_autoPoint.btn_help.addEventListener(MouseEvent.MOUSE_MOVE,this.UIHelpHintOnOver);
         this.FScene.mc_autoPoint.btn_help.addEventListener(MouseEvent.ROLL_OUT,this.UIHelpHintOnOut);
         this.FScene.MC_Proof.S_Btn_ProofChange.addEventListener(MouseEvent.CLICK,this.ProofClick);
         this.FScene.MC_Proof.S_Recruit.addEventListener(MouseEvent.CLICK,this.ProofClick);
         this.FProcessorWindowTreasureMap = new TProcessorWindowTreasureMap(this,this.FScene);
         this.FProcessorWindowTreasureMap.OnEnterCity = this.FOnReturnMainScene;
         this.FProcessorWindowTreasureMap.OpenDigMap = this.OpenDigMap;
         this.FProcessorWindowTreasureMap.HintOnOver = this.UIComponentsHintOnOver;
         this.FProcessorWindowTreasureMap.HintOnOut = this.UIComponentsHintOnOut;
         this.FProcessorWindowTreasureMap.OnEffectText = EffectGenerateText;
         this.FProcessorWindowTreasureMap.OnApplianceOnOver = this.UIComponentsApplianceOnOver;
         this.FProcessorWindowTreasureMap.OnApplianceOnOut = this.UIComponentsApplianceOnOut;
         this.FProcessorWindowTreasureMap.TutorialNextStep = TutorialNextStep;
         this.FProcessorWindowTreasureMapGame = new TProcessorWindowTreasureMapGame(this,this.FScene.mc_game);
         this.FProcessorWindowTreasureMapGame.Visible = false;
         this.FProcessorWindowTreasureMapGame.OnEffectText = EffectGenerateText;
         this.FProcessorWindowTreasureMapGame.StartMovie = this.OnStartMovie;
         this.FProcessorWindowMapSelect = new TProcessorWindowMapSelect(this,this.FScene.mc_mapSelect);
         this.FProcessorWindowMapSelect.Visible = false;
         this.FProcessorWindowMapSelect.OnCanDig = this.OnCanDig;
         this.FProcessorWindowMapSelect.OpenGame = this.OpenGame;
         this.FProcessorWindowMapSelect.OnApplianceOnOver = this.UIComponentsApplianceOnOver;
         this.FProcessorWindowMapSelect.OnApplianceOnOut = this.UIComponentsApplianceOnOut;
         this.FProcessorWindowMapSelect.OnHintOnOver = this.UIComponentsHintOnOver;
         this.FProcessorWindowMapSelect.OnHintOnOut = this.UIComponentsHintOnOut;
         this.FProcessorWindowMapSelect.OnEffectText = EffectGenerateText;
         this.FProcessorWindowMapSelect.TutorialNextStep = TutorialNextStep;
         this.FProcessorWindowHeros = new TProcessorWindowHeros(this,this.FScene);
         this.FProcessorWindowHeros.OnHeroRollOver = this.OnHeroRollOver;
         this.FProcessorWindowHeros.OnHeroRollOut = this.OnHeroRollOut;
         this.FProcessorWindowHeros.OnEffectText = EffectGenerateText;
         this.FProcessorHeroTips = new TProcessorHeroTips(this);
         this.FProcessorHeroTips.Visible = false;
         this.FProcessorNewProofChange = new TProcessorNewProofChange(this);
         this.FProcessorNewProofChange.OldProofChangBtn = this.OldProofChangBtn;
         this.FProcessorOldProofChange = new TProcessorOldProofChange(this);
         this.FProcessorOldProofChange.RefleshNewProof = this.RefleshNewProof;
         this.FProcessorOldProofChange.visible = false;
         this.FProcessorNewProofChange.visible = false;
         if(!FIsResourcesLoadCompleted)
         {
            if(this.FProcessorOldProofChange != null)
            {
               this.FProcessorOldProofChange.Load();
            }
            if(this.FProcessorNewProofChange != null)
            {
               this.FProcessorNewProofChange.Load();
            }
            return;
         }
      }
      
      public function RefleshNewProof() : void
      {
         this.FProcessorNewProofChange.ChangeSucceed();
      }
      
      public function OpenNewChangPanel() : void
      {
         this.FProcessorNewProofChange.visible = true;
         this.FProcessorNewProofChange.OpenMe(this.FProcessorWindowTreasureMap.NewProofChangeVce,this.FProcessorWindowTreasureMap.ProofItems);
         this.FProcessorNewProofChange.CheckChangBtn();
      }
      
      override protected function ProcessorResize() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         _loc1_ = FUICore.StageWidth;
         _loc2_ = FUICore.StageHeight;
         if(this.FScene != null)
         {
            this.FScene.mc_autoPoint.x = _loc1_;
            this.FScene.mc_report.x = _loc1_ - this.FScene.mc_report.width;
            this.FScene.mc_treasureBaseData.x = _loc1_ - this.FScene.mc_treasureBaseData.width;
            this.FScene.mc_treasureBaseData.y = _loc2_;
         }
      }
      
      protected function EnterTreasureMap() : void
      {
         if(this.FScene == null)
         {
            return;
         }
         this.FProcessorWindowTreasureMapGame.Visible = false;
         this.FProcessorWindowMapSelect.Visible = false;
         this.FProcessorHeroTips.Visible = false;
         this.FProcessorWindowTreasureMap.SetTreasureMapData(this.FTreasureMapData);
         SLogicsCore.Character.RoleSencePosition = CONST_COMMON.SCENEPOSITION_TreasureMap;
         this.ProcessorResize();
      }
      
      protected function OpenDigMap(param1:Object) : void
      {
         this.FProcessorWindowMapSelect.Visible = true;
      }
      
      protected function OnCanDig() : Boolean
      {
         return this.FProcessorWindowTreasureMap.CheckCanDigging();
      }
      
      protected function OpenGame() : void
      {
         this.FProcessorWindowTreasureMapGame.OpenGame();
      }
      
      protected function UIComponentsApplianceOnOver(param1:Object, param2:Object) : void
      {
         var _loc3_:TInventory = null;
         _loc3_ = param2 as TInventory;
         if(this.FOverlayerAppliance != null)
         {
            this.FOverlayerAppliance.Context = _loc3_;
            this.FOverlayerAppliance.Render(FUICore.MouseCoordinate);
            this.FOverlayerAppliance.Show();
         }
      }
      
      protected function UIComponentsApplianceOnOut(param1:Object, param2:Object) : void
      {
         var _loc3_:TInventory = null;
         _loc3_ = param1 as TInventory;
         if(this.FOverlayerAppliance != null)
         {
            this.FOverlayerAppliance.Hide();
         }
      }
      
      protected function UIComponentsHintOnOver(param1:Object, param2:THint) : void
      {
         this.FOverlayerHint.Context = param2;
         this.FOverlayerHint.Render(FUICore.MouseCoordinate);
         this.FOverlayerHint.visible = true;
      }
      
      protected function UIComponentsHintOnOut(param1:Object) : void
      {
         this.FOverlayerHint.visible = false;
      }
      
      protected function UIHelpHintOnOver(param1:MouseEvent) : void
      {
         this.FOverlayerHelpTips.Context = this.FHelpHint;
         this.FOverlayerHelpTips.Render(FUICore.MouseCoordinate);
         this.FOverlayerHelpTips.Show();
      }
      
      protected function UIHelpHintOnOut(param1:MouseEvent) : void
      {
         this.FOverlayerHelpTips.Hide();
      }
      
      protected function OnClose(param1:MouseEvent) : void
      {
         if(this.FOnReturnMainScene != null)
         {
            this.FOnReturnMainScene(this);
         }
      }
      
      protected function ProofClick(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case this.FScene.MC_Proof.S_Btn_ProofChange:
               this.OpenNewChangPanel();
               break;
            case this.FScene.MC_Proof.S_Recruit:
               this.FProofSeeNinJa();
         }
      }
      
      protected function OnSetStatusType(param1:Object, param2:int, param3:int) : void
      {
         if(this.FSetStatusType != null)
         {
            this.FSetStatusType(param1,param2,param3);
         }
      }
      
      protected function OnHeroRollOver(param1:Object, param2:TTreasureMapHero) : void
      {
         this.FProcessorHeroTips.SetHeroData(param2);
         this.FProcessorHeroTips.Visible = true;
         if(param2.Identifier0 != this.FCharacter.Identifier0 || param2.Identifier1 != this.FCharacter.Identifier1)
         {
            FUICore.MouseCaptureSet(param1 as TUIComponent);
         }
      }
      
      protected function OnHeroRollOut(param1:Object) : void
      {
         this.FProcessorHeroTips.Visible = false;
         FUICore.MouseCaptureRelease(param1 as TUIComponent);
      }
      
      protected function OnStartMovie(param1:Object) : void
      {
         this.FScene.mc_StartMovie.visible = true;
         this.FScene.mc_StartMovie.gotoAndPlay(1);
      }
      
      protected function OldProofChangBtn() : void
      {
         this.FProcessorOldProofChange.visible = true;
         this.FProcessorOldProofChange.OpenMe(this.FProcessorWindowTreasureMap.OldProofChangeVce,this.FProcessorWindowTreasureMap.ProofItems);
      }
      
      public function set ProofSeeNinJa(param1:Function) : void
      {
         this.FProofSeeNinJa = param1;
      }
      
      public function set OnReturnMainScene(param1:Function) : void
      {
         this.FOnReturnMainScene = param1;
      }
      
      public function get OnReturnMainScene() : Function
      {
         return this.FOnReturnMainScene;
      }
      
      public function set SetStatusType(param1:Function) : void
      {
         this.FSetStatusType = param1;
      }
      
      public function get SetStatusType() : Function
      {
         return this.FSetStatusType;
      }
      
      public function set SetBattlePacket(param1:Function) : void
      {
         this.FSetBattlePacket = param1;
      }
      
      public function get SetBattlePacket() : Function
      {
         return this.FSetBattlePacket;
      }
      
      public function set OnInitBattle(param1:Function) : void
      {
         this.FOnInitBattle = param1;
      }
      
      public function get OnInitBattle() : Function
      {
         return this.FOnInitBattle;
      }
      
      public function Send_C_S_Initilization() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Enter_TreasureMap);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount();
         if(!FIsResourcesLoadCompleted)
         {
            if(this.FProcessorOldProofChange != null)
            {
               this.FProcessorOldProofChange.Load();
            }
            if(this.FProcessorNewProofChange != null)
            {
               this.FProcessorNewProofChange.Load();
            }
            return;
         }
         if(param1 != null)
         {
            this.PacketPerform_SC_Enter_TreasureMap(param1);
         }
         if(this.FIsInit == false)
         {
            this.Send_C_S_Initilization();
         }
         else
         {
            this.EnterTreasureMap();
         }
         TutorialNextStep(1900);
         this.FProcessorWindowTreasureMap.OpenMe();
         if(FIsOpenNewProof)
         {
            this.OpenNewChangPanel();
            FIsOpenNewProof = 0;
         }
      }
      
      override public function Unmount() : void
      {
         super.Unmount();
         if(this.FIsInit)
         {
            TutorialNextStep(1904);
         }
      }
      
      public function RobberyResult(param1:Boolean) : void
      {
         if(this.FTreasureMapData != null && param1)
         {
            this.FTreasureMapData.RobberyTimes += 1;
         }
      }
   }
}

