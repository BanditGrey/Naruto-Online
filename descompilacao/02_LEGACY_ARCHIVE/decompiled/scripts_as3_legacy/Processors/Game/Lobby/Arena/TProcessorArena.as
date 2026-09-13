package Processors.Game.Lobby.Arena
{
   import Foundation.Common.*;
   import Foundation.Network.*;
   import Foundation.Resources.*;
   import Foundation.Timing.*;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.*;
   import Logics.Arena.*;
   import Logics.DatebaseVO.VO.*;
   import Logics.Streamization.Arena.*;
   import Logics.TimeCoolDown.*;
   import Processors.Game.Lobby.Common.*;
   import Processors.Game.Lobby.Common.Shortcuts.*;
   import Rendering.Overlayers.HelpTips.*;
   import Rendering.Overlayers.Hints.*;
   import Resources.Constants.*;
   import Resources.Strings.STRING_ACTIVITYINNER;
   import Utilities.UI.Overlayers.*;
   import flash.display.*;
   import flash.events.*;
   import flash.utils.*;
   
   public class TProcessorArena extends TProcessorLobbyPlate
   {
      
      protected static const CONST_RING:uint = 4;
      
      protected static const Movie_Show:String = "come";
      
      protected static const Movie_Hide:String = "out";
      
      protected var FHelpTips:THint;
      
      protected var FScene:MovieClip;
      
      protected var FTimeCoolDown:TTimeCoolDown;
      
      protected var FArenaData:TArenaData;
      
      protected var UnstreamizerArena:TUnstreamizerArena;
      
      protected var FProcessorWindowArena:TProcessorWindowArena;
      
      protected var FProcessorWindowArenaHero:TProcessorWindowArenaHero;
      
      protected var FProcessorWindowArenaList:TProcessorWindowArenaList;
      
      protected var FProcessorWindowArenaReport:TProcessorWindowArenaReport;
      
      protected var FIsShowHeroList:Boolean;
      
      protected var FIsInit:Boolean;
      
      protected var FAutoFight:Boolean;
      
      protected var FOverlayerHint:TOverlayerHint;
      
      protected var FOverlayerHelpTips:TOverlayerHelpTips;
      
      protected var FInitialization:Boolean;
      
      protected var FOnReturnMainScene:Function;
      
      protected var FSetStatusType:Function;
      
      protected var FSetBattlePacket:Function;
      
      protected var FOnInitBattle:Function;
      
      protected var FShowOtherHeroInfor:Function;
      
      protected var NimeiA:uint;
      
      public function TProcessorArena(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FHelpTips = new THint();
         this.FArenaData = new TArenaData();
         this.UnstreamizerArena = new TUnstreamizerArena();
         this.FIsInit = false;
         this.FIsShowHeroList = false;
         this.FAutoFight = false;
         this.FTimeCoolDown = new TTimeCoolDown(CONST_COMMON.TIME_COOLDOWN_Arean);
         SLogicsCore.Character.TimeCoolDowns.Add(this.FTimeCoolDown);
         SetUIModuleID(CONST_MODULES.MODULE_Arena);
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         if(Visible == false)
         {
            return;
         }
         if(this.FProcessorWindowArena != null)
         {
            this.FProcessorWindowArena.UpdataColdDown();
            this.FProcessorWindowArena.UpdataBigBitmap();
         }
         if(this.FProcessorWindowArenaHero != null)
         {
            this.FProcessorWindowArenaHero.UpdataBitmap();
         }
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_ARENA.RESOURCE_ARENA);
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
         this.InitArena();
         this.FOverlayerHint = new TOverlayerHint(this);
         this.FOverlayerHint.visible = false;
         this.FOverlayerHelpTips = new TOverlayerHelpTips(this);
         this.FOverlayerHelpTips.Visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerHint);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerHelpTips);
         this.FInitialization = false;
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Arena_BigFish_Ret,this.PacketPerform_SC_BigFish_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Arena_GetReward_Ret,this.PacketPerform_SC_GetReward_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Arena_AddOrder_Ret,this.PacketPerform_SC_AddOrder_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Arena_Faster_Ret,this.PacketPerform_SC_Faster_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Arena_Fight_Ret,this.PacketPerform_SC_Fight_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Arena_Look_Ret,this.PacketPerform_SC_Look_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Arena_Update,this.PacketPerform_SC_Update);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Arena_FightOk,this.PacketPerform_SC_FightOk);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Arena_ColdTime_Ret,this.PacketPerform_SC_ColdTime);
      }
      
      protected function PacketPerform_SC_Enter_Arena(param1:ByteArray) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         _loc3_ = param1.readUnsignedInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         this.UnstreamizerArena.Unstreamize(param1,this.FArenaData,SResourcesCore.ResourceBin);
         this.FTimeCoolDown.TimingTime = this.FArenaData.ColdDown - STimingCore.GetServerTick();
         this.FIsInit = true;
      }
      
      protected function PacketPerform_SC_BigFish_Ret(param1:TPacket) : void
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
         this.UnstreamizerArena.UnstreamizeArenaHeroPanel(_loc2_,this.FArenaData.HeroPanelList,SResourcesCore.ResourceBin);
         this.FProcessorWindowArenaList.SetArenaHeroPanel(this.FArenaData.HeroPanelList);
         if(this.FIsShowHeroList == false)
         {
            this.FScene.mc_heroPanel.gotoAndPlay(Movie_Show);
            this.FIsShowHeroList = true;
         }
      }
      
      protected function PacketPerform_SC_GetReward_Ret(param1:TPacket) : void
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
         this.FProcessorWindowArena.GetRewardOk();
         EffectGenerateText(STRING_ACTIVITYINNER.STREING_REWARD_SUCCEED);
      }
      
      protected function PacketPerform_SC_AddOrder_Ret(param1:TPacket) : void
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
         this.FProcessorWindowArena.AddOrderOk();
         if(this.FAutoFight && this.CheckCanFight())
         {
            this.FProcessorWindowArenaHero.StartFight();
            this.FAutoFight = false;
         }
      }
      
      protected function PacketPerform_SC_Faster_Ret(param1:TPacket) : void
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
         if(this.FProcessorWindowArena != null)
         {
            this.FProcessorWindowArena.FasterOk();
         }
         this.FTimeCoolDown.TimingTime = 0;
         if(this.FAutoFight && this.CheckCanFight())
         {
            this.FProcessorWindowArenaHero.StartFight();
            this.FAutoFight = false;
         }
      }
      
      protected function PacketPerform_SC_Fight_Ret(param1:TPacket) : void
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
      
      protected function PacketPerform_SC_Look_Ret(param1:TPacket) : void
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
      }
      
      protected function PacketPerform_SC_Update(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:Boolean = false;
         if(this.FIsInit == false)
         {
            return;
         }
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc4_ = Boolean(this.FArenaData.BoxType != 1);
         this.UnstreamizerArena.Unstreamize(_loc2_,this.FArenaData,SResourcesCore.ResourceBin);
         if(_loc4_ && this.FArenaData.BoxType == 1)
         {
            this.FArenaData.ColdDownBox += CONST_ARENA.ColdDown_BoxMax;
         }
         if(Visible)
         {
            this.FProcessorWindowArena.SetArenaData(this.FArenaData);
            this.FProcessorWindowArenaHero.SetArenaHeros(this.FArenaData.FightHeroList);
            this.FProcessorWindowArenaReport.SetArenaReports(this.FArenaData.ReportList);
         }
         this.FTimeCoolDown.TimingTime = this.FArenaData.ColdDown - STimingCore.GetServerTick();
      }
      
      protected function PacketPerform_SC_FightOk(param1:TPacket) : void
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
         this.OnSetStatusType(this,CONST_BATTLE.BattleType_Arena,CONST_MUSIC.ID_SCENE_Arena);
         if(this.FOnInitBattle != null)
         {
            this.FOnInitBattle(this);
         }
      }
      
      protected function PacketPerform_SC_ColdTime(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = param1.Data;
         this.FArenaData.ColdDown = _loc2_.readUnsignedInt();
         this.FTimeCoolDown.TimingTime = this.FArenaData.ColdDown - STimingCore.GetServerTick();
      }
      
      protected function InitArena() : void
      {
         this.FScene = TUtilityReflection.CreateDisplayObjectInstance(CONST_ARENA.RESOURCE_ClassName_MC_Arena) as MovieClip;
         addChild(this.FScene);
         TGameUtil.setButtonMode(this.FScene.btn_back,true);
         this.FScene.btn_back.addEventListener(MouseEvent.CLICK,this.OnClose);
         this.FScene.mc_highFish.btn_showPanel.addEventListener(MouseEvent.CLICK,this.OnShowHeroPanel);
         this.FScene.mc_highFish.btn_hidePanel.addEventListener(MouseEvent.CLICK,this.OnhideHeroPanel);
         this.FScene.mc_highFish.btn_showPanel.buttonMode = true;
         this.FScene.mc_highFish.btn_hidePanel.buttonMode = true;
         this.FScene.mc_highFish.btn_hidePanel.visible = false;
         this.NimeiA = this.FScene.mc_highFish.x;
         this.FScene.mc_autoPoint.btn_close.addEventListener(MouseEvent.CLICK,this.OnClose);
         this.FScene.mc_autoPoint.btn_help.addEventListener(MouseEvent.MOUSE_MOVE,this.ButtonHelpOnOver);
         this.FScene.mc_autoPoint.btn_help.addEventListener(MouseEvent.MOUSE_OUT,this.ButtonHelpOnOut);
         this.FProcessorWindowArena = new TProcessorWindowArena(this,this.FScene);
         this.FProcessorWindowArena.HintOnMove = this.UIComponentsHintOnOver;
         this.FProcessorWindowArena.HintOnOut = this.UIComponentsHintOnOut;
         this.FProcessorWindowArena.EffectGenerateText = EffectGenerateText;
         this.FProcessorWindowArenaHero = new TProcessorWindowArenaHero(this,this.FScene.fightHero_movie.mc_fightHero);
         this.FProcessorWindowArenaHero.OnCheckCanFight = this.CheckCanFight;
         this.FProcessorWindowArenaHero.TutorialNextStep = TutorialNextStep;
         this.FProcessorWindowArenaList = new TProcessorWindowArenaList(this,this.FScene.mc_heroPanel.heroPanel_movie);
         this.FProcessorWindowArenaList.ShowOtherHeroInfor = this.OnShowOtherHeroInfor;
         this.FProcessorWindowArenaReport = new TProcessorWindowArenaReport(this,this.FScene.mc_report);
         this.FScene.visible = false;
      }
      
      override protected function ProcessorResize() : void
      {
         var _loc1_:uint = 0;
         if(this.FScene != null)
         {
            _loc1_ = uint(stage.stageWidth);
            if(_loc1_ > this.NimeiA + this.FScene.mc_highFish.width)
            {
               _loc1_ = this.NimeiA + this.FScene.mc_highFish.width;
            }
            this.FScene.mc_autoPoint.x = _loc1_;
            this.FScene.mc_highFish.x = _loc1_ - this.FScene.mc_highFish.width;
            this.FScene.mc_heroPanel.x = _loc1_;
         }
      }
      
      protected function EnterArenaMovie() : void
      {
         var _loc1_:uint = 0;
         if(this.FScene == null)
         {
            return;
         }
         this.FScene.gotoAndPlay(1);
         this.FScene.mc_title.gotoAndPlay(1);
         this.FScene.mc_report.gotoAndPlay(1);
         _loc1_ = 0;
         while(_loc1_ < CONST_RING)
         {
            this.FScene.fightHero_movie["mc_ring_" + _loc1_].gotoAndPlay(1);
            _loc1_++;
         }
         this.FScene.fightHero_movie.mc_man_left.play();
         this.FScene.fightHero_movie.mc_man_right.play();
         this.FProcessorWindowArena.SetArenaData(this.FArenaData);
         this.FProcessorWindowArenaHero.SetArenaHeros(this.FArenaData.FightHeroList);
         this.FProcessorWindowArenaReport.SetArenaReports(this.FArenaData.ReportList);
         this.FScene.visible = true;
         SLogicsCore.Character.RoleSencePosition = CONST_COMMON.SCENEPOSITION_ARENA;
         SLogicsCore.SignalPost(CONST_SIGNAL.SIGNALDESTINATION_SOUND,CONST_MUSIC.PLAY_SCENE_Arena,CONST_MUSIC.ID_SCENE_Arena,false);
      }
      
      protected function CheckCanFight() : Boolean
      {
         var _loc1_:Boolean = false;
         _loc1_ = this.FProcessorWindowArena.CheckCanFight();
         this.FAutoFight = !_loc1_;
         return _loc1_;
      }
      
      protected function PerformPacket_CS_ArenaColdTime() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Arena_ColdTime_Req);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function OnShowHeroPanel(param1:MouseEvent = null) : void
      {
         var _loc2_:TPacket = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Arena_BigFish_Req);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
         this.FScene.mc_highFish.btn_showPanel.visible = false;
         this.FScene.mc_highFish.btn_hidePanel.visible = true;
      }
      
      protected function OnhideHeroPanel(param1:MouseEvent = null) : void
      {
         if(this.FIsShowHeroList == true)
         {
            this.FScene.mc_heroPanel.gotoAndPlay(Movie_Hide);
            this.FIsShowHeroList = false;
         }
         this.FScene.mc_highFish.btn_showPanel.visible = true;
         this.FScene.mc_highFish.btn_hidePanel.visible = false;
      }
      
      protected function OnClose(param1:MouseEvent) : void
      {
         if(this.FOnReturnMainScene != null)
         {
            this.FOnReturnMainScene(this);
         }
      }
      
      protected function ButtonHelpOnOver(param1:MouseEvent) : void
      {
         var _loc2_:TSystemLanguage = null;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.HELPTIPS_Arena) as TSystemLanguage;
         this.FHelpTips.Content = _loc2_.Desc;
         this.UIHelpTipsHintOnOver(this,this.FHelpTips);
      }
      
      protected function ButtonHelpOnOut(param1:MouseEvent) : void
      {
         this.UIHelpTipsHintOnOut(this);
      }
      
      protected function UIComponentsHintOnOver(param1:Object, param2:THint) : void
      {
         this.FOverlayerHint.Context = param2;
         this.FOverlayerHint.Render(FUICore.MouseCoordinate);
         this.FOverlayerHint.Show();
      }
      
      protected function UIComponentsHintOnOut(param1:Object) : void
      {
         this.FOverlayerHint.Hide();
      }
      
      protected function UIHelpTipsHintOnOver(param1:Object, param2:THint) : void
      {
         this.FOverlayerHelpTips.Context = param2;
         this.FOverlayerHelpTips.Render(FUICore.MouseCoordinate);
         this.FOverlayerHelpTips.Show();
      }
      
      protected function UIHelpTipsHintOnOut(param1:Object) : void
      {
         this.FOverlayerHelpTips.Hide();
      }
      
      protected function OnSetStatusType(param1:Object, param2:int, param3:int) : void
      {
         if(this.FSetStatusType != null)
         {
            this.FSetStatusType(param1,param2,param3);
         }
      }
      
      protected function OnShowOtherHeroInfor(param1:Object, param2:uint, param3:uint) : void
      {
         if(this.FShowOtherHeroInfor != null)
         {
            this.FShowOtherHeroInfor(param1,param2,param3);
         }
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
      
      public function set ShowOtherHeroInfor(param1:Function) : void
      {
         this.FShowOtherHeroInfor = param1;
      }
      
      public function get ShowOtherHeroInfor() : Function
      {
         return this.FShowOtherHeroInfor;
      }
      
      override public function ShortcutModesSetup(param1:TLobbyShortcutModes) : void
      {
         var _loc2_:TLobbyShortcutAvatarModes = null;
         var _loc3_:TLobbyShortcutActivityModes = null;
         var _loc4_:TLobbyShortcutActiveSpecialModes = null;
         var _loc5_:TLobbyShortcutFunctionModes = null;
         var _loc6_:TLobbyShortcutMapModes = null;
         var _loc7_:TLobbyShortcutQuestGuideModes = null;
         var _loc8_:TLobbyShortcutConstantlyModes = null;
         if(param1 is TLobbyShortcutAvatarModes)
         {
            _loc2_ = param1 as TLobbyShortcutAvatarModes;
            _loc2_.ShortcutModeAvatar = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
         }
         if(param1 is TLobbyShortcutActivityModes)
         {
            _loc3_ = param1 as TLobbyShortcutActivityModes;
            _loc3_.SetAllShortcutHide();
         }
         if(param1 is TLobbyShortcutActiveSpecialModes)
         {
            _loc4_ = param1 as TLobbyShortcutActiveSpecialModes;
            _loc4_.ShortcutModeCDK = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
         }
         if(param1 is TLobbyShortcutFunctionModes)
         {
            _loc5_ = param1 as TLobbyShortcutFunctionModes;
            _loc5_.ShortcutModeHero = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
            _loc5_.ShortcutModeStar = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
            _loc5_.ShortcutModeTacticalDeployment = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
            _loc5_.ShortcutModeInheritPractice = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
            _loc5_.ShortcutModeBackpack = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
            _loc5_.ShortcutModeTreasure = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
            _loc5_.ShortcutModeSummonPet = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
            _loc5_.ShortcutModeStrengthen = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
            _loc5_.ShortcutModeMail = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
            _loc5_.ShortcutModeTongLing = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
            _loc5_.ShortcutModeOrganiZation = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
            _loc5_.ShortcutModeReturn = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
         }
         if(param1 is TLobbyShortcutMapModes)
         {
            _loc6_ = param1 as TLobbyShortcutMapModes;
            _loc6_.ShortcutModeMap = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
            _loc6_.ShortcutModeReturnHome = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
         }
         if(param1 is TLobbyShortcutQuestGuideModes)
         {
            _loc7_ = param1 as TLobbyShortcutQuestGuideModes;
            _loc7_.ShortcutMode = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
         }
         if(param1 is TLobbyShortcutConstantlyModes)
         {
            _loc8_ = param1 as TLobbyShortcutConstantlyModes;
            _loc8_.ShortcutModeStrengthen = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
            _loc8_.ShortcutModeArena = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
            _loc8_.ShortcutModeBigDipper = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
            _loc8_.ShortcutModeMentorship = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
            _loc8_.ShortcutModeTongLing = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
         }
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         var _loc2_:TPacket = null;
         super.Mount();
         if(!FIsResourcesLoadCompleted)
         {
            return;
         }
         if(param1 != null)
         {
            this.PacketPerform_SC_Enter_Arena(param1);
         }
         if(this.FIsInit == false)
         {
            _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Enter_Arena);
            SNetworkCore.Transceiver.PacketTransmit(_loc2_);
         }
         else
         {
            this.EnterArenaMovie();
         }
         SLogicsCore.KaguyaData.C_S_Privilege(2);
         TutorialNextStep(1501);
      }
      
      override public function Unmount() : void
      {
         this.OnhideHeroPanel();
         this.FScene.fightHero_movie.mc_man_left.stop();
         this.FScene.fightHero_movie.mc_man_right.stop();
         if(this.FIsInit)
         {
            TutorialNextStep(1502);
         }
         if(this.FProcessorWindowArena)
         {
            this.FProcessorWindowArena.ImageReset();
         }
         super.Unmount();
      }
      
      public function UpdateCDTime() : void
      {
         this.PerformPacket_CS_ArenaColdTime();
      }
      
      public function UpdateFreeCount() : void
      {
         if(this.FProcessorWindowArena)
         {
            this.FProcessorWindowArena.UpdateFreeCount();
         }
      }
   }
}

