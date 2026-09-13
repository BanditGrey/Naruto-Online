package Processors.Game.Battle
{
   import Foundation.Common.*;
   import Foundation.Network.*;
   import Foundation.Resources.*;
   import Foundation.Resources.Bins.*;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.*;
   import Logics.Battle.*;
   import Logics.Battle.model.*;
   import Logics.ChatOptions.*;
   import Logics.DatebaseVO.VO.*;
   import Logics.Globalboss.TGlobalboss;
   import Logics.Inventories.*;
   import Logics.Items.*;
   import Logics.Streamization.Battle.*;
   import Logics.Streamization.Items.*;
   import Logics.Vip.*;
   import Processors.Game.*;
   import Processors.Game.Battle.Character.*;
   import Processors.Game.Battle.Effect.*;
   import Processors.Game.Lobby.Common.*;
   import Processors.Game.Lobby.Taboo.Data.TabooDataCell;
   import Processors.Game.Lobby.TongLing.ToolS.Tools_Help;
   import Processors.Game.Plot.*;
   import Processors.Game.Windows.Information.TUIWindowBattleSkip;
   import Processors.Game.Windows.Information.TUIWindowConfirmation;
   import Rendering.Overlayers.*;
   import Rendering.Overlayers.Hints.*;
   import Rendering.Overlayers.Inventories.*;
   import Rendering.Overlayers.Pet.TOverlayerPetSoulFormation;
   import Rendering.Overlayers.Taboo.TTabooTip;
   import Resources.Constants.*;
   import Resources.Strings.*;
   import Utilities.UI.Overlayers.*;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.*;
   import flash.events.*;
   import flash.net.*;
   import flash.system.*;
   import flash.utils.*;
   import ghostcat.util.data.*;
   import ghostcat.util.easing.TweenUtil;
   
   public class TBattleHandle extends TProcessorGame
   {
      
      protected static const SIZE_WIDTH_Win:int = 371;
      
      protected static const SIZE_HEIGHT_Win:int = 273;
      
      protected static const SIZE_WIDTH_Lost:int = 355;
      
      protected static const SIZE_HEIGHT_Lost:int = 206;
      
      protected static const SIZE_WIDTH_Result:int = 355;
      
      protected static const SIZE_HEIGHT_Result:int = 206;
      
      protected static const BATTLEBG_UpName:String = "bitmap_up";
      
      protected static const BATTLEBG_DownName:String = "bitmap_down";
      
      public static const CATEGORY_Normal:uint = CONST_INVENTORY.CATEGORY_Normal;
      
      public static const CATEGORY_Equipment:uint = CONST_INVENTORY.CATEGORY_Equipment;
      
      public static const CATEGORY_Gem:uint = CONST_INVENTORY.CATEGORY_Gem;
      
      public static const CATEGORY_Treasure:uint = CONST_INVENTORY.CATEGORY_Treasure;
      
      public static const CATEGORY_Material:uint = CONST_INVENTORY.CATEGORY_Material;
      
      public static const CATEGORY_Accessories:uint = CONST_INVENTORY.CATEGORY_Accessories;
      
      public static const ENTER_TYPE_NODAL:int = CONST_BATTLE.BattleType_Nodal;
      
      public static const ENTER_TYPE_CAMP:int = CONST_BATTLE.BattleType_Camp;
      
      public static const ENTER_TYPE_TRIALS:int = CONST_BATTLE.BattleType_KillHero;
      
      public static const ENTER_TYPE_ARENA:int = CONST_BATTLE.BattleType_Arena;
      
      public static const ENTER_TYPE_TREASUREMAP:int = CONST_BATTLE.BattleType_TreasureMap;
      
      public static const ENTER_TYPE_FightPet:int = CONST_BATTLE.BattleType_FightPet;
      
      public static const ENTER_TYPE_CityDefend:int = CONST_BATTLE.BattleType_CityDefend;
      
      public static const ENTER_TYPE_OrganizationWar:int = CONST_BATTLE.BattleType_OrganizationWar;
      
      public static const ENTER_TYPE_TraitorAttack:int = CONST_BATTLE.BattleType_TraitorAttack;
      
      public static const ENTER_TYPE_Slave:int = CONST_BATTLE.BattleType_Slave;
      
      public static const Enter_TYPE_SevenKing:int = CONST_BATTLE.BattleType_SevenKing;
      
      public static const Enter_TYPE_CrossServerWar:int = CONST_BATTLE.BattleType_CrossServerWar;
      
      public static const Enter_TYPE_Magic:int = CONST_BATTLE.BattleType_Magic;
      
      public static const Enter_TYPE_Tower:int = CONST_BATTLE.BattleType_Tower;
      
      public static const Enter_TYPE_Palace:int = CONST_BATTLE.BattleType_Palace;
      
      public static const Enter_TYPE_OrganizationBoss:int = CONST_BATTLE.BattleType_OrganizationBoss;
      
      public static const Enter_TYPE_Friend:int = CONST_BATTLE.BattleType_Friend;
      
      public static const Enter_TYPE_BloodSoul:int = CONST_BATTLE.BattleType_BloodSoul;
      
      public static const Enter_TYPE_SixFairy:int = CONST_BATTLE.BattleType_SixFairy;
      
      public static const BattleType_RebirthRealm:int = CONST_BATTLE.BattleType_RebirthRealm;
      
      public static const BattleType_TransmigrationTrial:int = CONST_BATTLE.BattleType_TransmigrationTrial;
      
      public static const BattleType_Taboo:int = CONST_BATTLE.BattleType_Taboo;
      
      public static const BattleType_TransmigrationAccessory:int = CONST_BATTLE.BattleType_TransmigrationAccessory;
      
      public static const BattleType_UnderTown:int = CONST_BATTLE.BattleType_UnderTown;
      
      public static const BattleType_MiGong:int = CONST_BATTLE.BattleType_MiGong;
      
      public static const BattleType_MasterRoad:int = CONST_BATTLE.BattleType_MasterRoad;
      
      public static const BattleType_Challenge:int = CONST_BATTLE.BattleType_Challenge;
      
      public static const BattleType_Wing:int = CONST_BATTLE.BattleType_Wing;
      
      public static const BattleType_Alien:int = CONST_BATTLE.BattleType_Alien;
      
      public static const BattleType_Qiecuo:int = CONST_BATTLE.BattleType_Qiecuo;
      
      public static const BattleType_GlobalBattle:int = CONST_BATTLE.BattleType_GlobalBattle;
      
      public static const BattleType_WorldMatch:uint = CONST_BATTLE.BattleType_WorldMatch;
      
      public static const BattleType_SummonBattle:int = CONST_BATTLE.BattleType_SummonBattle;
      
      public static const BattleType_ChallengeCamp:int = CONST_BATTLE.BattleType_ChallengeCamp;
      
      public static const BattleType_GlobalBoss:int = CONST_BATTLE.BattleType_GlobalBoss;
      
      public static const BattleType_CrossSlave:int = CONST_BATTLE.BattleType_CrossSlave;
      
      public static const ENTER_TYPE_REPLAY:int = CONST_BATTLE.BattleType_Replay;
      
      public static const PLAY_SCENE_Nodal:uint = CONST_MUSIC.PLAY_SCENE_Nodal;
      
      public static const PLAY_SCENE_Campaign:uint = CONST_MUSIC.PLAY_SCENE_Campaign;
      
      public static const PLAY_SCENE_KillHeros:uint = CONST_MUSIC.PLAY_SCENE_KillHeros;
      
      public static const PLAY_SCENE_Arena:uint = CONST_MUSIC.PLAY_SCENE_Arena;
      
      public static var IsInBattle:Boolean = false;
      
      protected var FPoolBattleStages:TPoolBattleStages;
      
      protected var FBattleStages:Vector.<TBattleStage>;
      
      protected var FProcessorBattleLoading:TProcessorBattleLoading;
      
      protected var FBattleInfo:TBattleInfo;
      
      protected var UnstreamizerBattleRepot:TUnstreamizerBattleRepot;
      
      protected var FBattleBg:Bitmap;
      
      protected var FBgSprite:TUIComponent;
      
      protected var FBgSpriteInit:Boolean;
      
      protected var FNewBgId:uint;
      
      protected var FChgBattleBg:Bitmap;
      
      protected var FIsNewBg:Boolean;
      
      protected var FEnterType:int;
      
      protected var FEnterId:int;
      
      protected var FIsAutoBattle:Boolean;
      
      protected var FIsAutoGoldResurgence:Boolean;
      
      protected var FIsAutoSkipResurgence:Boolean;
      
      protected var FMonsterCount:int;
      
      protected var FIsWin:Boolean;
      
      protected var FVipData:TVip;
      
      protected var FWinWindow:TBattleWinWindow;
      
      protected var FLostWindow:TBattleLostWindow;
      
      protected var FResultWindow:TBattleResultWindow;
      
      protected var UnstreamizerRewards:TUnstreamizerRewards;
      
      protected var FReward:TItems;
      
      protected var FBoundsWinWindow:TBounds;
      
      protected var FBoundsLostWindow:TBounds;
      
      protected var FBoundsResultWindow:TBounds;
      
      protected var FRoleModelBins:TBins;
      
      protected var FEnemyBins:TBins;
      
      protected var FBaseHeroBins:TBins;
      
      protected var FOverlayerEquipment:TOverlayerEquipment;
      
      protected var FOverlayerTreasure:TOverlayerTreasure;
      
      protected var FOverlayerAppliance:TOverlayerAppliance;
      
      protected var FOverlayerHint:TOverlayerHint;
      
      protected var FOverlayerAccessory:TOverlayerAccessory;
      
      protected var FOverlayerPetSoulFormation:TOverlayerPetSoulFormation;
      
      protected var FTabooTip:TTabooTip = null;
      
      protected var FReportData:ByteArray;
      
      protected var FIsReplay:Boolean;
      
      protected var FModelVect:Vector.<int>;
      
      protected var FLargeVect:Vector.<int>;
      
      protected var FSkillVect:Vector.<int>;
      
      protected var FBackgroundVect:Vector.<int>;
      
      protected var FSoulFormationVect:Vector.<int>;
      
      protected var FUseSkillList:Vector.<uint>;
      
      protected var FInit:Boolean;
      
      protected var FButtonSkip:MovieClip;
      
      protected var FButtonSkipCopy:MovieClip;
      
      protected var FIsCanSkip:Boolean;
      
      protected var FSkipHint:THint;
      
      protected var FBattleRound:MovieClip;
      
      protected var FBattleRoundClass:BattleRoundClass = null;
      
      protected var FMCEmblemLeft:MovieClip;
      
      protected var FMCEmblemRight:MovieClip;
      
      protected var FEmblemIconL:Bitmap;
      
      protected var FEmblemIconR:Bitmap;
      
      protected var FRingEffectL:Bitmap;
      
      protected var FRingEffectR:Bitmap;
      
      protected var FRingResIdL:int;
      
      protected var FRingResIdR:int;
      
      protected var FUIWindowConfirmation:TUIWindowConfirmation;
      
      protected var FBattleSkip:TUIWindowBattleSkip;
      
      protected var FknowRezult:Boolean;
      
      protected var FSystemDeffeat_PVE:Vector.<Object>;
      
      protected var FSystemDeffeat_PVP:Vector.<Object>;
      
      protected var FIsBattleEnd:Boolean;
      
      protected var FMosterRoadResult:String;
      
      protected var FGlobalBattleScore:int;
      
      protected var FTurnBackBattleScene:Function;
      
      protected var FTurnBackKillHero:Function;
      
      protected var FTurnBackArena:Function;
      
      protected var FTurnBackTreasureMap:Function;
      
      protected var FTurnBackCityDefend:Function;
      
      protected var FTurnBackFightPet:Function;
      
      protected var FTurnBackOrganizationWar:Function;
      
      protected var FTurnBackTraitorAttack:Function;
      
      protected var FTurnBackSlave:Function;
      
      protected var FTurnBackSevenKing:Function;
      
      protected var FTurnBackCrossServerWar:Function;
      
      protected var FTurnBackMagic:Function;
      
      protected var FTurnBackTower:Function;
      
      protected var FTurnBackPalace:Function;
      
      protected var FTurnBackOrganizationBoss:Function;
      
      protected var FTurnBackFriend:Function;
      
      protected var FTurnBackBloodSoul:Function;
      
      protected var FTurnBackSixFairy:Function;
      
      protected var FTurnBackUndertown:Function;
      
      protected var FTurnBackMiGong:Function;
      
      protected var FTurnBackRebirthRealm:Function;
      
      protected var FTurnBackTransmigrationTrial:Function;
      
      protected var FTurnBackTaboo:Function;
      
      protected var FTurnBackTransmigrationAccessory:Function;
      
      public var TurnBackMasterRoad:Function;
      
      public var TurnBackChallenge:Function;
      
      public var TurnBackWing:Function;
      
      public var TurnBackAlien:Function;
      
      public var TurnBackQiecuo:Function;
      
      public var TurnBackGlobalBattle:Function;
      
      public var TurnBackWorldMatch:Function;
      
      public var TurnBackSummonBattle:Function;
      
      public var TurnBackChallengeCamp:Function;
      
      public var TurnBackGlobalBoss:Function;
      
      public var TurnBackCrossSlave:Function;
      
      protected var FProcessorCheckPlot:Function;
      
      protected var FOnErrorText:Function;
      
      protected var FOnQuit:Function;
      
      protected var FUseSkipCardReq:Function;
      
      protected var FLoader:Loader;
      
      protected var ImageUrl:String;
      
      protected var _cacheList:Object = {};
      
      protected var FLoaderQueue:Array = [];
      
      protected var AttackIdFuck:uint;
      
      protected var SkillIdFuck:uint;
      
      public function TBattleHandle(param1:TUIComponent)
      {
         super(param1);
         this.InitBattleHandle();
         this.FReward = new TItems();
         this.UnstreamizerRewards = new TUnstreamizerRewards();
         this.FModelVect = new Vector.<int>();
         this.FLargeVect = new Vector.<int>();
         this.FSkillVect = new Vector.<int>();
         this.FBackgroundVect = new Vector.<int>();
         this.FSoulFormationVect = new Vector.<int>();
         this.FUseSkillList = new Vector.<uint>();
         this.FSkipHint = new THint();
         this.FBattleSkip = new TUIWindowBattleSkip();
         this.FIsBattleEnd = true;
         this.FInit = false;
         this.FMosterRoadResult = "";
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfBattle.LoadPrimary(CONST_BATTLE.RESOURCE_Battle);
         SResourcesCore.TexturesSwfSkill.LoadPrimary(CONST_BATTLE.BATTLE_BIGBLACK_ID);
         SResourcesCore.TexturesSwfSkill.LoadPrimary(CONST_BATTLE.BattlePetEffectId);
         SResourcesCore.TexturesSwfSkill.LoadPrimary(CONST_COMMON.Nija_Reincarnation_Effect_NotMain);
         SResourcesCore.TexturesSwfSkill.LoadPrimary(13610301);
         SResourcesCore.TexturesSwfSkill.LoadPrimary(13610302);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:TConfigValue = null;
         if(this.FButtonSkip == null)
         {
            this.FButtonSkip = TUtilityReflection.CreateDisplayObjectInstance(CONST_TREASUREMAP.RESOURCE_ClassName_BTN_Skip) as MovieClip;
            this.FButtonSkip.addEventListener(MouseEvent.CLICK,this.ButtonSkipOnClick,false,0,true);
            this.FButtonSkip.addEventListener(MouseEvent.MOUSE_MOVE,this.ButtonSkipOnRoll);
            this.FButtonSkip.addEventListener(MouseEvent.MOUSE_OUT,this.ButtonSkipOnRoll);
            addChild(this.FButtonSkip);
            this.FButtonSkip.x = CONST_COMMON.STAGE_Width / 2 - this.FButtonSkip.width / 2;
            this.FButtonSkip.y = CONST_COMMON.STAGE_Height - 100;
            TGameUtil.setButtonMode(this.FButtonSkip,false);
            this.Skip = false;
         }
         if(this.FButtonSkipCopy == null)
         {
            this.FButtonSkipCopy = TUtilityReflection.CreateDisplayObjectInstance(CONST_TREASUREMAP.RESOURCE_ClassName_BTN_SkipCopy) as MovieClip;
            this.FButtonSkipCopy.addEventListener(MouseEvent.CLICK,this.ButtonSkipCopyOnClick,false,0,true);
            addChild(this.FButtonSkipCopy);
            this.FButtonSkipCopy.x = CONST_COMMON.STAGE_Width / 2 - this.FButtonSkipCopy.width / 2;
            this.FButtonSkipCopy.y = CONST_COMMON.STAGE_Height - 100;
            TGameUtil.setButtonMode(this.FButtonSkipCopy,true);
         }
         if(this.FBattleRound == null)
         {
            this.FBattleRound = TUtilityReflection.CreateDisplayObjectInstance("Mc_battle_Round") as MovieClip;
            addChild(this.FBattleRound);
            this.FBattleRoundClass = new BattleRoundClass(this.FBattleRound);
            if(this.FEnterType == BattleType_Challenge)
            {
               this.FBattleRoundClass.initilization(CONST_BATTLE.TURN_OF_CHALLENGE);
            }
            else
            {
               this.FBattleRoundClass.initilization();
            }
            this.FBattleRound.x = CONST_COMMON.STAGE_Width / 2 - this.FBattleRound.width / 2;
            this.FBattleRound.y = 100;
            new Tools_Help(this,this.FBattleRoundClass.QuestionMark,CONST_SYSTEMLANGUAGE.HELPTIPS_BattleRound_help,FUICore);
         }
         if(this.FResultWindow == null)
         {
            this.FResultWindow = new TBattleResultWindow(this);
            this.FResultWindow.ClickCallBack = this.TurnBack;
            this.FResultWindow.ReplayCallBack = this.OnReplayByByteArray;
            this.FResultWindow.HintOnMove = this.UIComponentsHintOnOver;
            this.FResultWindow.HintOnOut = this.UIComponentsHintOnOut;
            this.FResultWindow.x = (CONST_COMMON.STAGE_Width - this.FBoundsResultWindow.Width) / 2;
            this.FResultWindow.y = (CONST_COMMON.STAGE_Height - this.FBoundsResultWindow.Height) / 2;
         }
         if(this.FWinWindow == null)
         {
            this.FWinWindow = new TBattleWinWindow(this);
            this.FWinWindow.ClickCallBack = this.TurnBack;
            this.FWinWindow.SlotsOnMove = this.UIComponentsApplianceOnOver;
            this.FWinWindow.SlotsOnOut = this.UIComponentsApplianceOnOut;
            this.FWinWindow.ReplayCallBack = this.OnReplayByByteArray;
            this.FWinWindow.HintOnMove = this.UIComponentsHintOnOver;
            this.FWinWindow.HintOnOut = this.UIComponentsHintOnOut;
            this.FWinWindow.Setup();
            this.FWinWindow.x = (CONST_COMMON.STAGE_Width - this.FBoundsWinWindow.Width) / 2;
            this.FWinWindow.y = (CONST_COMMON.STAGE_Height - this.FBoundsWinWindow.Height) / 2;
         }
         if(this.FLostWindow == null)
         {
            this.FLostWindow = new TBattleLostWindow(this);
            this.FLostWindow.ClickCallBack = this.TurnBack;
            this.FLostWindow.ReplayCallBack = this.OnReplayByByteArray;
            this.FLostWindow.HintOnMove = this.UIComponentsHintOnOver;
            this.FLostWindow.HintOnOut = this.UIComponentsHintOnOut;
            this.FLostWindow.x = (CONST_COMMON.STAGE_Width - this.FBoundsLostWindow.Width) / 2;
            this.FLostWindow.y = (CONST_COMMON.STAGE_Height - this.FBoundsLostWindow.Height) / 2;
         }
         if(this.FOverlayerHint == null)
         {
            this.FOverlayerEquipment = new TOverlayerEquipment(this,CONST_MODULES.MODULE_Battle);
            this.FOverlayerEquipment.Visible = false;
            this.FOverlayerTreasure = new TOverlayerTreasure(this,CONST_MODULES.MODULE_Battle);
            this.FOverlayerTreasure.Visible = false;
            this.FOverlayerAppliance = new TOverlayerAppliance(this,CONST_MODULES.MODULE_Battle);
            this.FOverlayerAppliance.Visible = false;
            this.FOverlayerHint = new TOverlayerHint(this);
            this.FOverlayerHint.visible = false;
            this.FTabooTip = new TTabooTip(this);
            this.FTabooTip.visible = false;
            this.FOverlayerAccessory = new TOverlayerAccessory(this,CONST_MODULES.MODULE_Battle);
            this.FOverlayerAccessory.Visible = false;
            this.FOverlayerAccessory.IsMeOrOthers = 0;
            this.FOverlayerPetSoulFormation = new TOverlayerPetSoulFormation(this);
            this.FOverlayerPetSoulFormation.Visible = false;
            TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerPetSoulFormation);
            TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerEquipment);
            TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerTreasure);
            TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerAppliance);
            TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerHint);
            TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerAccessory);
            TUtilityUIOverlayer.ResourcesDispatch(this.FTabooTip);
         }
         if(this.FMCEmblemLeft == null)
         {
            this.FMCEmblemLeft = TUtilityReflection.CreateDisplayObjectInstance("mc_Emblem") as MovieClip;
            addChild(this.FMCEmblemLeft);
            this.FMCEmblemLeft.x = CONST_COMMON.STAGE_Width / 2 - 150;
            this.FMCEmblemLeft.y = 140;
            this.FEmblemIconL = new Bitmap();
            this.FMCEmblemLeft["pos"].addChild(this.FEmblemIconL);
            this.FRingEffectL = new Bitmap();
            this.FMCEmblemLeft["effSpr"].addChild(this.FRingEffectL);
         }
         if(this.FMCEmblemRight == null)
         {
            this.FMCEmblemRight = TUtilityReflection.CreateDisplayObjectInstance("mc_Emblem") as MovieClip;
            addChild(this.FMCEmblemRight);
            this.FMCEmblemRight.x = CONST_COMMON.STAGE_Width / 2 + 200;
            this.FMCEmblemRight.y = 140;
            this.FEmblemIconR = new Bitmap();
            this.FMCEmblemRight["pos"].addChild(this.FEmblemIconR);
            this.FRingEffectR = new Bitmap();
            this.FMCEmblemRight["effSpr"].addChild(this.FRingEffectR);
         }
         this.FUIWindowConfirmation = new TUIWindowConfirmation(this.Parent);
         this.FUIWindowConfirmation.OnOK = this.ConfirmationOnOk;
         this.FUIWindowConfirmation.x = (CONST_COMMON.STAGE_Width - this.FUIWindowConfirmation.WindowWidth) / 2;
         this.FUIWindowConfirmation.y = (CONST_COMMON.STAGE_Height - this.FUIWindowConfirmation.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowConfirmation);
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.SYSTEM_DEFFEAT_PVE) as TConfigValue;
         this.FSystemDeffeat_PVE = _loc1_.Value as Vector.<Object>;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.SYSTEM_DEFFEAT_PVP) as TConfigValue;
         this.FSystemDeffeat_PVP = _loc1_.Value as Vector.<Object>;
         this.FInit = true;
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         if(this.FWinWindow != null)
         {
            this.FWinWindow.UpdataSlot();
         }
         if(Visible == false)
         {
            return;
         }
         if(!this.FIsBattleEnd)
         {
            TEffectControl.UpdataRoleEffect();
            TEffectControl.UpdataPublicEffect();
         }
         if(this.FRingEffectL)
         {
            TGameUtil.ShowAnimationByID(TGameUtil.Type_Emblem,this.FRingEffectL,CONST_MODULES.MODULE_Battle,this.FRingResIdL);
            this.FRingEffectL.x = -this.FRingEffectL.width >> 1;
            this.FRingEffectL.y = -this.FRingEffectL.height >> 1;
         }
         if(this.FRingEffectR)
         {
            TGameUtil.ShowAnimationByID(TGameUtil.Type_Emblem,this.FRingEffectR,CONST_MODULES.MODULE_Battle,this.FRingResIdR);
            this.FRingEffectR.x = -this.FRingEffectR.width >> 1;
            this.FRingEffectR.y = -this.FRingEffectR.height >> 1;
         }
         if(this.FInit)
         {
            this.ShowBgSprite();
         }
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Battle_StartReportDataReq,this.PacketPerform_SC_BattleStartReportData);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_SingleBattleResult,this.PacketPerform_SC_SingleBattleResult);
      }
      
      protected function PacketPerform_SC_BattleStartReportData(param1:TPacket) : void
      {
         if(TBattleHandle.IsInBattle)
         {
            return;
         }
         this.FReportData = param1.Data;
         this.FBattleInfo = new TBattleInfo();
         this.UnstreamizerBattleRepot.Unstreamize(this.FReportData,this.FBattleInfo,null);
         this.FIsReplay = false;
         if(this.FResultWindow != null)
         {
            this.FResultWindow.visible = false;
         }
         if(this.FWinWindow != null)
         {
            this.FWinWindow.visible = false;
         }
         if(this.FLostWindow != null)
         {
            this.FLostWindow.visible = false;
         }
      }
      
      protected function PacketPerform_SC_SingleBattleResult(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:String = null;
         var _loc8_:TMasterRoadBattle = null;
         var _loc9_:int = 0;
         if(TBattleHandle.IsInBattle)
         {
            return;
         }
         _loc2_ = param1.Data;
         _loc3_ = uint(_loc2_.readInt());
         if(_loc3_ != 0)
         {
            return;
         }
         this.FIsWin = Boolean(_loc2_.readByte() > 0);
         this.FReward.Clear();
         this.UnstreamizerRewards.Unstreamize(_loc2_,this.FReward,null);
         if(this.FEnterType == BattleType_MasterRoad)
         {
            _loc4_ = int(_loc2_.readUnsignedInt());
            _loc8_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_MasterRoadBattle,_loc4_) as TMasterRoadBattle;
            if(_loc8_)
            {
               _loc5_ = _loc2_.readShort();
               _loc7_ = "";
               _loc6_ = 0;
               while(_loc6_ < _loc5_)
               {
                  _loc9_ = int(_loc2_.readUnsignedInt());
                  _loc7_ += _loc8_.Command(_loc9_) + "\n";
                  _loc6_++;
               }
               this.FMosterRoadResult = _loc7_;
            }
         }
         this.FknowRezult = true;
         this.DispatchUIRes();
         if(this.CheckBattleSkip())
         {
            this.ResetBattle();
            this.OnEndBattle();
            this.HideReplay();
            return;
         }
         if(this.FBattleInfo == null)
         {
            return;
         }
         this.CheckUseSkill();
         this.CheckResources();
      }
      
      protected function InitBattleHandle() : void
      {
         var _loc1_:Bitmap = null;
         this.FPoolBattleStages = new TPoolBattleStages();
         this.FBattleStages = new Vector.<TBattleStage>();
         this.FBattleBg = new Bitmap();
         this.FBattleBg.cacheAsBitmap = true;
         addChild(this.FBattleBg);
         this.FChgBattleBg = new Bitmap();
         addChild(this.FChgBattleBg);
         this.FChgBattleBg.alpha = 0;
         this.FBgSprite = new TUIComponent(this);
         this.FBgSpriteInit = false;
         _loc1_ = new Bitmap();
         _loc1_.name = BATTLEBG_UpName;
         this.FBgSprite.addChild(_loc1_);
         _loc1_ = new Bitmap();
         _loc1_.name = BATTLEBG_DownName;
         this.FBgSprite.addChild(_loc1_);
         _loc1_.scaleY = -1;
         this.FProcessorBattleLoading = new TProcessorBattleLoading(this);
         this.FProcessorBattleLoading.OnLoadingCompleted = this.LoadResourcesEnd;
         this.FProcessorBattleLoading.OnUnLoadingCompleted = this.UnLoadResourcesEnd;
         this.UnstreamizerBattleRepot = new TUnstreamizerBattleRepot();
         this.FIsWin = true;
         this.FBoundsWinWindow = new TBounds();
         this.FBoundsWinWindow.Width = SIZE_WIDTH_Win;
         this.FBoundsWinWindow.Height = SIZE_HEIGHT_Win;
         this.FBoundsLostWindow = new TBounds();
         this.FBoundsLostWindow.Width = SIZE_WIDTH_Lost;
         this.FBoundsLostWindow.Height = SIZE_HEIGHT_Lost;
         this.FBoundsResultWindow = new TBounds();
         this.FBoundsResultWindow.Width = SIZE_WIDTH_Result;
         this.FBoundsResultWindow.Height = SIZE_HEIGHT_Result;
      }
      
      protected function ShowBgSprite() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Bitmap = null;
         var _loc3_:Class = null;
         var _loc4_:BitmapData = null;
         if(this.FBgSprite != null && !this.FBgSpriteInit)
         {
            _loc3_ = TUtilityReflection.GetClass(STRING_COMMON.COMMON_ResKey + CONST_BATTLE.BATTLE_BIGBLACK_ID + "_0") as Class;
            if(_loc3_ != null)
            {
               _loc4_ = new _loc3_();
               _loc2_ = this.FBgSprite.getChildByName(BATTLEBG_UpName) as Bitmap;
               _loc2_.bitmapData = _loc4_;
               _loc2_ = this.FBgSprite.getChildByName(BATTLEBG_DownName) as Bitmap;
               _loc2_.bitmapData = _loc4_;
               _loc2_.y = CONST_COMMON.STAGE_Height;
               this.FBgSpriteInit = true;
            }
            _loc1_ = this.FSkillVect.indexOf(CONST_BATTLE.BATTLE_BIGBLACK_ID);
            if(_loc1_ < 0)
            {
               this.FSkillVect.push(CONST_BATTLE.BATTLE_BIGBLACK_ID);
            }
         }
         if(this.FIsNewBg)
         {
            TGameUtil.ShowImageByID(TGameUtil.Type_BackgroundIcon,this.FChgBattleBg,CONST_MODULES.MODULE_Battle,this.FNewBgId);
         }
         if(this.FEnterType == ENTER_TYPE_ARENA)
         {
            TGameUtil.ShowImageByID(TGameUtil.Type_BackgroundIcon,this.FBattleBg,CONST_MODULES.MODULE_Battle,CONST_BATTLE.BATTLE_ARENA_BackGround_ID);
         }
         else if(this.FEnterType == ENTER_TYPE_TREASUREMAP)
         {
            TGameUtil.ShowImageByID(TGameUtil.Type_BackgroundIcon,this.FBattleBg,CONST_MODULES.MODULE_Battle,CONST_BATTLE.BATTLE_ARENA_BackGround_ID);
         }
         else if(this.FEnterType == ENTER_TYPE_CityDefend)
         {
            TGameUtil.ShowImageByID(TGameUtil.Type_BackgroundIcon,this.FBattleBg,CONST_MODULES.MODULE_Battle,CONST_BATTLE.BATTLE_ARENA_BackGround_ID);
         }
         else if(this.FEnterType == ENTER_TYPE_REPLAY)
         {
            TGameUtil.ShowImageByID(TGameUtil.Type_BackgroundIcon,this.FBattleBg,CONST_MODULES.MODULE_Battle,CONST_BATTLE.BATTLE_ARENA_BackGround_ID);
         }
         else if(this.FEnterType == ENTER_TYPE_Slave)
         {
            TGameUtil.ShowImageByID(TGameUtil.Type_BackgroundIcon,this.FBattleBg,CONST_MODULES.MODULE_Battle,CONST_BATTLE.BATTLE_ARENA_BackGround_ID);
         }
         else if(this.FEnterType == Enter_TYPE_SevenKing)
         {
            TGameUtil.ShowImageByID(TGameUtil.Type_BackgroundIcon,this.FBattleBg,CONST_MODULES.MODULE_Battle,CONST_BATTLE.BATTLE_ARENA_BackGround_ID);
         }
         else if(this.FEnterType == Enter_TYPE_CrossServerWar)
         {
            TGameUtil.ShowImageByID(TGameUtil.Type_BackgroundIcon,this.FBattleBg,CONST_MODULES.MODULE_Battle,CONST_BATTLE.BATTLE_ARENA_BackGround_ID);
         }
         else if(this.FEnterType == Enter_TYPE_Magic)
         {
            TGameUtil.ShowImageByID(TGameUtil.Type_BackgroundIcon,this.FBattleBg,CONST_MODULES.MODULE_Battle,CONST_BATTLE.BATTLE_ARENA_BackGround_ID);
         }
         else if(this.FEnterType == Enter_TYPE_Tower)
         {
            TGameUtil.ShowImageByID(TGameUtil.Type_BackgroundIcon,this.FBattleBg,CONST_MODULES.MODULE_Battle,CONST_BATTLE.BATTLE_ARENA_BackGround_ID);
         }
         else if(this.FEnterType == Enter_TYPE_Palace)
         {
            TGameUtil.ShowImageByID(TGameUtil.Type_BackgroundIcon,this.FBattleBg,CONST_MODULES.MODULE_Battle,CONST_BATTLE.BATTLE_ARENA_BackGround_ID);
         }
         else if(this.FEnterType == Enter_TYPE_OrganizationBoss)
         {
            TGameUtil.ShowImageByID(TGameUtil.Type_BackgroundIcon,this.FBattleBg,CONST_MODULES.MODULE_Battle,CONST_BATTLE.BATTLE_ARENA_BackGround_ID);
         }
         else if(this.FEnterType == Enter_TYPE_Friend)
         {
            TGameUtil.ShowImageByID(TGameUtil.Type_BackgroundIcon,this.FBattleBg,CONST_MODULES.MODULE_Battle,CONST_BATTLE.BATTLE_ARENA_BackGround_ID);
         }
         else if(this.FEnterType == Enter_TYPE_BloodSoul)
         {
            TGameUtil.ShowImageByID(TGameUtil.Type_BackgroundIcon,this.FBattleBg,CONST_MODULES.MODULE_Battle,CONST_BATTLE.BATTLE_ARENA_BackGround_ID);
         }
         else if(this.FEnterType == Enter_TYPE_SixFairy)
         {
            TGameUtil.ShowImageByID(TGameUtil.Type_BackgroundIcon,this.FBattleBg,CONST_MODULES.MODULE_Battle,CONST_BATTLE.BATTLE_ARENA_BackGround_ID);
         }
         else if(this.FEnterType == BattleType_RebirthRealm)
         {
            TGameUtil.ShowImageByID(TGameUtil.Type_BackgroundIcon,this.FBattleBg,CONST_MODULES.MODULE_Battle,CONST_BATTLE.BATTLE_ARENA_BackGround_ID);
         }
         else if(this.FEnterType == BattleType_TransmigrationTrial)
         {
            TGameUtil.ShowImageByID(TGameUtil.Type_BackgroundIcon,this.FBattleBg,CONST_MODULES.MODULE_Battle,CONST_BATTLE.BATTLE_ARENA_BackGround_ID);
         }
         else if(this.FEnterType == BattleType_Taboo)
         {
            TGameUtil.ShowImageByID(TGameUtil.Type_BackgroundIcon,this.FBattleBg,CONST_MODULES.MODULE_Battle,CONST_BATTLE.BATTLE_ARENA_BackGround_ID);
         }
         else if(this.FEnterType == BattleType_TransmigrationAccessory)
         {
            TGameUtil.ShowImageByID(TGameUtil.Type_BackgroundIcon,this.FBattleBg,CONST_MODULES.MODULE_Battle,CONST_BATTLE.BATTLE_ARENA_BackGround_ID);
         }
         else if(this.FEnterType == BattleType_UnderTown)
         {
            TGameUtil.ShowImageByID(TGameUtil.Type_BackgroundIcon,this.FBattleBg,CONST_MODULES.MODULE_Battle,CONST_BATTLE.BATTLE_ARENA_BackGround_ID);
         }
         else if(this.FEnterType == BattleType_MiGong)
         {
            TGameUtil.ShowImageByID(TGameUtil.Type_BackgroundIcon,this.FBattleBg,CONST_MODULES.MODULE_Battle,CONST_BATTLE.BATTLE_ARENA_BackGround_ID);
         }
         else if(this.FEnterType == BattleType_MasterRoad)
         {
            TGameUtil.ShowImageByID(TGameUtil.Type_BackgroundIcon,this.FBattleBg,CONST_MODULES.MODULE_Battle,CONST_BATTLE.BATTLE_ARENA_BackGround_ID);
         }
         else if(this.FEnterType == BattleType_Challenge)
         {
            TGameUtil.ShowImageByID(TGameUtil.Type_BackgroundIcon,this.FBattleBg,CONST_MODULES.MODULE_Battle,CONST_BATTLE.BATTLE_ARENA_BackGround_ID);
         }
         else if(this.FEnterType == BattleType_Wing)
         {
            TGameUtil.ShowImageByID(TGameUtil.Type_BackgroundIcon,this.FBattleBg,CONST_MODULES.MODULE_Battle,CONST_BATTLE.BATTLE_ARENA_BackGround_ID);
         }
         else if(this.FEnterType == BattleType_Alien)
         {
            TGameUtil.ShowImageByID(TGameUtil.Type_BackgroundIcon,this.FBattleBg,CONST_MODULES.MODULE_Battle,CONST_BATTLE.BATTLE_ARENA_BackGround_ID);
         }
         else if(this.FEnterType == BattleType_Qiecuo)
         {
            TGameUtil.ShowImageByID(TGameUtil.Type_BackgroundIcon,this.FBattleBg,CONST_MODULES.MODULE_Battle,CONST_BATTLE.BATTLE_ARENA_BackGround_ID);
         }
         else if(this.FEnterType == BattleType_GlobalBattle)
         {
            TGameUtil.ShowImageByID(TGameUtil.Type_BackgroundIcon,this.FBattleBg,CONST_MODULES.MODULE_Battle,CONST_BATTLE.BATTLE_ARENA_BackGround_ID);
         }
         else if(this.FEnterType == BattleType_WorldMatch)
         {
            TGameUtil.ShowImageByID(TGameUtil.Type_BackgroundIcon,this.FBattleBg,CONST_MODULES.MODULE_Battle,CONST_BATTLE.BATTLE_ARENA_BackGround_ID);
         }
         else if(this.FEnterType == BattleType_SummonBattle)
         {
            TGameUtil.ShowImageByID(TGameUtil.Type_BackgroundIcon,this.FBattleBg,CONST_MODULES.MODULE_Battle,CONST_BATTLE.BATTLE_ARENA_BackGround_ID);
         }
         else if(this.FEnterType == BattleType_ChallengeCamp)
         {
            TGameUtil.ShowImageByID(TGameUtil.Type_BackgroundIcon,this.FBattleBg,CONST_MODULES.MODULE_Battle,CONST_BATTLE.BATTLE_ARENA_BackGround_ID);
         }
         else if(this.FEnterType == BattleType_GlobalBoss)
         {
            TGameUtil.ShowImageByID(TGameUtil.Type_BackgroundIcon,this.FBattleBg,CONST_MODULES.MODULE_Battle,CONST_BATTLE.BATTLE_ARENA_BackGround_ID);
         }
         else if(this.FEnterType == BattleType_CrossSlave)
         {
            TGameUtil.ShowImageByID(TGameUtil.Type_BackgroundIcon,this.FBattleBg,CONST_MODULES.MODULE_Battle,CONST_BATTLE.BATTLE_ARENA_BackGround_ID);
         }
         _loc1_ = this.FBackgroundVect.indexOf(CONST_BATTLE.BATTLE_ARENA_BackGround_ID);
         if(_loc1_ < 0)
         {
            this.FBackgroundVect.push(CONST_BATTLE.BATTLE_ARENA_BackGround_ID);
         }
      }
      
      protected function CriticalUI() : void
      {
         TEffectControl.MakeCritical(this);
      }
      
      protected function GetBattleStage() : TBattleStage
      {
         var _loc1_:TBattleStage = this.FPoolBattleStages.GetBattleStage(this);
         _loc1_.CriticalUI = this.CriticalUI;
         _loc1_.OnChangeBg = this.ProcessorOnChangeBg;
         _loc1_.OnAntiColorBlackWhiteBg = this.OnAntiColorBlackWhiteBg;
         _loc1_.OnRedAntiColorBg = this.OnRedAntiColor;
         _loc1_.OnEndBattle = this.CheckPlot;
         _loc1_.HintOnMove = this.UIComponentsHintOnOver;
         _loc1_.HintOnOut = this.UIComponentsHintOnOut;
         _loc1_.SoulOnOver = this.ProcessorSoulOnOver;
         _loc1_.SoulOnOut = this.ProcessorSoulOnOut;
         _loc1_.SetTrunNumber = this.SetTrunNumber;
         _loc1_.NegotiateBrforeBattle = this.NegotiateBrforeBattleF;
         return _loc1_;
      }
      
      protected function CheckEffect(param1:uint, param2:Object, param3:Vector.<int>, param4:Vector.<int>) : void
      {
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc8_:Object = null;
         var _loc9_:Object = null;
         var _loc10_:uint = 0;
         if(param1 != 0 && this.FUseSkillList.indexOf(param1) < 0)
         {
            return;
         }
         _loc9_ = param2.ChgBg;
         for(_loc7_ in _loc9_)
         {
            _loc10_ = uint(_loc9_[_loc7_]);
            if(_loc10_ != 0)
            {
               if(param4.indexOf(_loc10_) < 0)
               {
                  param4.push(_loc10_);
               }
            }
         }
         _loc8_ = param2.appendEffect;
         if(_loc8_ != null)
         {
            for(_loc6_ in _loc8_)
            {
               _loc10_ = uint(_loc8_[_loc6_].effectId);
               if(_loc10_)
               {
                  if(param3.indexOf(_loc10_) < 0)
                  {
                     param3.push(_loc10_);
                  }
               }
               _loc9_ = _loc8_[_loc6_].ChgBg;
               for(_loc7_ in _loc9_)
               {
                  _loc10_ = uint(_loc9_[_loc7_]);
                  if(_loc10_ != 0)
                  {
                     if(param4.indexOf(_loc10_) < 0)
                     {
                        param4.push(_loc10_);
                     }
                  }
               }
               this.CheckEffect(0,_loc8_[_loc6_],param3,param4);
            }
         }
      }
      
      protected function TestResources(param1:String) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Vector.<TRoleBattleInfo> = null;
         var _loc4_:TRoleBattleInfo = null;
         var _loc5_:TBaseHero = null;
         var _loc6_:TEnemy = null;
         var _loc7_:Object = null;
         var _loc8_:String = null;
         var _loc9_:TRoleModel = null;
         this.FModelVect = new Vector.<int>();
         this.FLargeVect = new Vector.<int>();
         this.FSkillVect = new Vector.<int>();
         if(this.FRoleModelBins == null)
         {
            this.FRoleModelBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_RoleModel);
         }
         if(this.FEnemyBins == null)
         {
            this.FEnemyBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Enemy);
         }
         if(this.FBaseHeroBins == null)
         {
            this.FBaseHeroBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_BaseHero);
         }
         _loc3_ = this.FBattleInfo.PlayerInfo_1.RoleBattleInfos;
         _loc2_ = 0;
         while(_loc2_ < _loc3_.length)
         {
            _loc4_ = _loc3_[_loc2_];
            _loc9_ = this.FRoleModelBins.GetDatebaseByIdentifier(_loc4_.RoleId) as TRoleModel;
            this.FModelVect.push(_loc9_.Model);
            if(_loc4_.RoleId > 12101000)
            {
               _loc6_ = this.FEnemyBins.GetDatebaseByIdentifier(_loc4_.RoleId) as TEnemy;
               _loc6_.Effects = param1;
               _loc7_ = Json.decode(_loc6_.Effects);
            }
            else
            {
               _loc5_ = this.FBaseHeroBins.GetDatebaseByIdentifier(_loc4_.RoleId) as TBaseHero;
               _loc5_.AttackEffect = param1;
               _loc7_ = Json.decode(_loc5_.AttackEffect);
            }
            if(_loc7_ != 0)
            {
               for(_loc8_ in _loc7_)
               {
                  this.CheckEffect(int(_loc8_),_loc7_[_loc8_],this.FSkillVect,this.FBackgroundVect);
               }
            }
            _loc2_++;
         }
         _loc3_ = this.FBattleInfo.PlayerInfo_2.RoleBattleInfos;
         _loc2_ = 0;
         while(_loc2_ < _loc3_.length)
         {
            _loc4_ = _loc3_[_loc2_];
            _loc9_ = this.FRoleModelBins.GetDatebaseByIdentifier(_loc4_.RoleId) as TRoleModel;
            this.FModelVect.push(_loc9_.Model);
            this.FLargeVect.push(_loc9_.RoleStyle);
            if(_loc4_.RoleId > 12101000)
            {
               _loc6_ = this.FEnemyBins.GetDatebaseByIdentifier(_loc4_.RoleId) as TEnemy;
               _loc6_.Effects = param1;
               _loc7_ = Json.decode(_loc6_.Effects);
            }
            else
            {
               _loc5_ = this.FBaseHeroBins.GetDatebaseByIdentifier(_loc4_.RoleId) as TBaseHero;
               _loc5_.AttackEffect = param1;
               _loc7_ = Json.decode(_loc5_.AttackEffect);
            }
            if(_loc7_ != 0)
            {
               for(_loc8_ in _loc7_)
               {
                  this.CheckEffect(int(_loc8_),_loc7_[_loc8_],this.FSkillVect,this.FBackgroundVect);
               }
            }
            _loc2_++;
         }
         this.LoadResources();
      }
      
      protected function CheckSkillGuangHuan() : void
      {
         var _loc1_:TGroupRoleInfo = null;
         var _loc2_:TGroupRoleInfo = null;
         var _loc3_:int = 0;
         var _loc4_:THeroTalent = null;
         var _loc5_:TSkillConfig = null;
         var _loc6_:Object = null;
         var _loc7_:TSkillAura = null;
         var _loc8_:uint = 0;
         var _loc9_:TBaseHero = null;
         var _loc10_:int = 0;
         var _loc11_:Array = null;
         _loc1_ = this.FBattleInfo.PlayerInfo_1;
         _loc2_ = this.FBattleInfo.PlayerInfo_2;
         if(_loc1_ == null || _loc2_ == null || _loc1_.RoleCount <= 0 || _loc2_.RoleCount <= 0)
         {
            return;
         }
         _loc3_ = 0;
         while(_loc3_ < _loc1_.RoleCount)
         {
            if(_loc1_.RoleBattleInfos[_loc3_].CurHealth > 0)
            {
               _loc9_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BaseHero,_loc1_.RoleBattleInfos[_loc3_].RoleId) as TBaseHero;
               if(!_loc9_)
               {
                  return;
               }
               _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_HeroTalent,_loc9_.Talent) as THeroTalent;
               if(_loc4_)
               {
                  _loc6_ = _loc4_.TalentEffectObject;
                  if(_loc6_)
                  {
                     _loc11_ = null;
                     _loc11_ = _loc6_["talentEffect"];
                     _loc10_ = 0;
                     while(_loc10_ < _loc11_.length)
                     {
                        _loc6_ = _loc11_[_loc10_];
                        if(_loc6_["tType"] == 203)
                        {
                           _loc5_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SkillConfig,_loc6_["tValue"]) as TSkillConfig;
                           _loc6_ = _loc5_.EffectsObject;
                           if(_loc6_)
                           {
                              _loc6_ = _loc6_["effects"];
                              _loc7_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SkillAura,_loc6_[0]) as TSkillAura;
                              if(_loc7_)
                              {
                                 if(this.FSkillVect.indexOf(_loc7_.ResourceId) < 0)
                                 {
                                    this.FSkillVect.push(_loc7_.ResourceId);
                                 }
                              }
                           }
                           break;
                        }
                        _loc10_++;
                     }
                  }
               }
            }
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < _loc2_.RoleCount)
         {
            if(_loc2_.RoleBattleInfos[_loc3_].CurHealth > 0)
            {
               _loc2_.RoleBattleInfos[_loc3_];
               _loc9_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BaseHero,_loc2_.RoleBattleInfos[_loc3_].RoleId) as TBaseHero;
               if(!_loc9_)
               {
                  return;
               }
               _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_HeroTalent,_loc9_.Talent) as THeroTalent;
               if(_loc4_)
               {
                  _loc6_ = _loc4_.TalentEffectObject;
                  if(_loc6_)
                  {
                     _loc11_ = null;
                     _loc11_ = _loc6_["talentEffect"];
                     _loc10_ = 0;
                     while(_loc10_ < _loc11_.length)
                     {
                        _loc6_ = _loc11_[_loc10_];
                        if(_loc6_["tType"] == 203)
                        {
                           _loc5_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SkillConfig,_loc6_["tValue"]) as TSkillConfig;
                           _loc6_ = _loc5_.EffectsObject;
                           if(_loc6_)
                           {
                              _loc6_ = _loc6_["effects"];
                              _loc7_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SkillAura,_loc6_[0]) as TSkillAura;
                              if(_loc7_)
                              {
                                 if(this.FSkillVect.indexOf(_loc7_.ResourceId) < 0)
                                 {
                                    this.FSkillVect.push(_loc7_.ResourceId);
                                 }
                              }
                           }
                           break;
                        }
                        _loc10_++;
                     }
                  }
               }
            }
            _loc3_++;
         }
      }
      
      protected function CheckSoulFormation() : void
      {
         var _loc1_:TSoulArray = null;
         var _loc2_:Object = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Object = null;
         var _loc6_:String = null;
         var _loc7_:int = 0;
         var _loc8_:Object = null;
         var _loc9_:Array = null;
         var _loc10_:String = null;
         var _loc11_:Object = null;
         var _loc12_:TBaseHero = null;
         var _loc13_:String = null;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SoulArray,this.FBattleInfo.PlayerInfo_1.SoulFormationID) as TSoulArray;
         _loc12_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BaseHero,this.FBattleInfo.PlayerInfo_1.RoleBattleInfos[0].RoleId) as TBaseHero;
         if(_loc1_ != null)
         {
            _loc13_ = _loc12_.Profession == 3 ? _loc1_.attackEffect1 : _loc1_.attackEffect;
            _loc9_ = Json.decode(_loc13_);
            _loc3_ = 0;
            while(_loc3_ < _loc9_.length)
            {
               _loc5_ = _loc9_[_loc3_];
               for each(_loc2_ in _loc5_)
               {
                  _loc11_ = _loc2_.appendEffect;
                  if(_loc11_ != null)
                  {
                     for(_loc10_ in _loc11_)
                     {
                        _loc4_ = int(_loc11_[_loc10_].effectId);
                        if(_loc4_)
                        {
                           if(this.FSoulFormationVect.indexOf(_loc4_) < 0)
                           {
                              this.FSoulFormationVect.push(_loc4_);
                           }
                        }
                     }
                  }
               }
               _loc3_++;
            }
         }
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SoulArray,this.FBattleInfo.PlayerInfo_2.SoulFormationID) as TSoulArray;
         _loc12_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BaseHero,this.FBattleInfo.PlayerInfo_2.RoleBattleInfos[0].RoleId) as TBaseHero;
         if(_loc1_ != null)
         {
            _loc13_ = _loc12_.Profession == 3 ? _loc1_.attackEffect1 : _loc1_.attackEffect;
            _loc9_ = Json.decode(_loc13_);
            _loc3_ = 0;
            while(_loc3_ < _loc9_.length)
            {
               _loc5_ = _loc9_[_loc3_];
               for each(_loc2_ in _loc5_)
               {
                  _loc11_ = _loc2_.appendEffect;
                  if(_loc11_ != null)
                  {
                     for(_loc10_ in _loc11_)
                     {
                        _loc4_ = int(_loc11_[_loc10_].effectId);
                        if(_loc4_)
                        {
                           if(this.FSoulFormationVect.indexOf(_loc4_) < 0)
                           {
                              this.FSoulFormationVect.push(_loc4_);
                           }
                        }
                     }
                  }
               }
               _loc3_++;
            }
         }
      }
      
      protected function CheckUseSkill() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:Vector.<TTurnInfo> = null;
         var _loc4_:Vector.<TActiveInfo> = null;
         var _loc5_:uint = 0;
         _loc3_ = this.FBattleInfo.TurnInfos;
         _loc1_ = 0;
         while(_loc1_ < _loc3_.length)
         {
            _loc4_ = _loc3_[_loc1_].ActiveInfos;
            _loc2_ = 0;
            while(_loc2_ < _loc4_.length)
            {
               _loc5_ = uint(_loc4_[_loc2_].SkillEffectId);
               if(this.FUseSkillList.indexOf(_loc5_) < 0)
               {
                  this.FUseSkillList.push(_loc5_);
               }
               _loc2_++;
            }
            _loc1_++;
         }
      }
      
      protected function CheckResources() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Vector.<TRoleBattleInfo> = null;
         var _loc3_:TRoleBattleInfo = null;
         var _loc4_:TBaseHero = null;
         var _loc5_:TEnemy = null;
         var _loc6_:Object = null;
         var _loc7_:TRoleModel = null;
         var _loc8_:Boolean = false;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:TSoulArray = null;
         this.FIsNewBg = false;
         this.FBattleBg.alpha = 1;
         this.FChgBattleBg.alpha = 0;
         if(this.FRoleModelBins == null)
         {
            this.FRoleModelBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_RoleModel);
         }
         if(this.FEnemyBins == null)
         {
            this.FEnemyBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Enemy);
         }
         if(this.FBaseHeroBins == null)
         {
            this.FBaseHeroBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_BaseHero);
         }
         _loc2_ = this.FBattleInfo.PlayerInfo_1.RoleBattleInfos;
         _loc1_ = 0;
         while(_loc1_ < _loc2_.length)
         {
            _loc8_ = true;
            _loc3_ = _loc2_[_loc1_];
            _loc7_ = this.FRoleModelBins.GetDatebaseByIdentifier(_loc3_.RoleId) as TRoleModel;
            if(this.FModelVect.indexOf(_loc7_.Model) < 0)
            {
               this.FModelVect.push(_loc7_.Model);
            }
            if(_loc3_.RoleId > 12101000)
            {
               _loc5_ = this.FEnemyBins.GetDatebaseByIdentifier(_loc3_.RoleId) as TEnemy;
               _loc6_ = Json.decode(_loc5_.Effects);
               _loc9_ = uint(_loc5_.Normal);
               _loc10_ = uint(_loc5_.Skill);
               if(!_loc5_.IsBoss)
               {
                  _loc8_ = false;
               }
            }
            else
            {
               _loc4_ = this.FBaseHeroBins.GetDatebaseByIdentifier(_loc3_.RoleId) as TBaseHero;
               _loc6_ = Json.decode(_loc4_.AttackEffect);
               _loc9_ = uint(_loc4_.NormalAttack);
               _loc10_ = uint((SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SkillConfig,_loc3_.SkillId) as TSkillConfig).SkillId);
            }
            if(_loc8_)
            {
               if(this.FLargeVect.indexOf(_loc7_.RoleStyle) < 0)
               {
                  this.FLargeVect.push(_loc7_.RoleStyle);
               }
            }
            if(SLogicsCore.Character.IsSkillShowTime)
            {
               this.CheckEffect(0,_loc6_[this.AttackIdFuck],this.FSkillVect,this.FBackgroundVect);
               this.CheckEffect(this.SkillIdFuck,_loc6_[this.SkillIdFuck],this.FSkillVect,this.FBackgroundVect);
            }
            else
            {
               this.CheckEffect(0,_loc6_[_loc9_],this.FSkillVect,this.FBackgroundVect);
               this.CheckEffect(_loc10_,_loc6_[_loc10_],this.FSkillVect,this.FBackgroundVect);
            }
            _loc1_++;
         }
         _loc2_ = this.FBattleInfo.PlayerInfo_2.RoleBattleInfos;
         _loc1_ = 0;
         while(_loc1_ < _loc2_.length)
         {
            _loc8_ = true;
            _loc3_ = _loc2_[_loc1_];
            _loc7_ = this.FRoleModelBins.GetDatebaseByIdentifier(_loc3_.RoleId) as TRoleModel;
            if(this.FModelVect.indexOf(_loc7_.Model) < 0)
            {
               this.FModelVect.push(_loc7_.Model);
            }
            if(_loc3_.RoleId > 12101000)
            {
               _loc5_ = this.FEnemyBins.GetDatebaseByIdentifier(_loc3_.RoleId) as TEnemy;
               _loc6_ = Json.decode(_loc5_.Effects);
               _loc9_ = uint(_loc5_.Normal);
               _loc10_ = uint(_loc5_.Skill);
               if(!_loc5_.IsBoss)
               {
                  _loc8_ = false;
               }
            }
            else
            {
               _loc4_ = this.FBaseHeroBins.GetDatebaseByIdentifier(_loc3_.RoleId) as TBaseHero;
               _loc6_ = Json.decode(_loc4_.AttackEffect);
               _loc9_ = uint(_loc4_.NormalAttack);
               _loc10_ = uint((SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SkillConfig,_loc3_.SkillId) as TSkillConfig).SkillId);
            }
            if(_loc8_)
            {
               if(this.FLargeVect.indexOf(_loc7_.RoleStyle) < 0)
               {
                  this.FLargeVect.push(_loc7_.RoleStyle);
               }
            }
            this.CheckEffect(0,_loc6_[_loc9_],this.FSkillVect,this.FBackgroundVect);
            this.CheckEffect(_loc10_,_loc6_[_loc10_],this.FSkillVect,this.FBackgroundVect);
            _loc1_++;
         }
         this.CheckSkillGuangHuan();
         this.CheckSoulFormation();
         this.LoadResources();
         this.FUseSkillList.length = 0;
      }
      
      protected function CheckEmblemInfo() : void
      {
         var _loc2_:TEmblem = null;
         var _loc1_:String = "https://upload.plaync100.net/image/";
         this.FMCEmblemLeft.visible = false;
         this.FMCEmblemRight.visible = false;
         if(this.FBattleInfo.PlayerInfo_1.EmblemId > 0)
         {
            _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Emblem,this.FBattleInfo.PlayerInfo_1.EmblemId) as TEmblem;
            this.FMCEmblemLeft.visible = true;
            this.ImageUrl = _loc1_ + this.FBattleInfo.PlayerInfo_1.UserId + "_" + _loc2_.Identifier + ".png";
            if(_loc2_.Type == 2)
            {
               this.loadEmblemIcon(true);
            }
            else if(_loc2_.Type == 1)
            {
               this.FEmblemIconL.bitmapData = TUtilityReflection.CreateInstance("Icon_emblem_" + _loc2_.Imageid);
               this.FMCEmblemLeft["pos"].addChild(this.FEmblemIconL);
               this.FEmblemIconL.x = -this.FEmblemIconL.width >> 1;
               this.FEmblemIconL.y = -this.FEmblemIconL.height >> 1;
            }
         }
         if(this.FBattleInfo.PlayerInfo_2.EmblemId > 0)
         {
            _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Emblem,this.FBattleInfo.PlayerInfo_2.EmblemId) as TEmblem;
            this.FMCEmblemRight.visible = true;
            this.ImageUrl = _loc1_ + this.FBattleInfo.PlayerInfo_2.UserId + "_" + _loc2_.Identifier + ".png";
            if(_loc2_.Type == 2)
            {
               this.loadEmblemIcon();
            }
            else if(_loc2_.Type == 1)
            {
               this.FEmblemIconR.bitmapData = TUtilityReflection.CreateInstance("Icon_emblem_" + _loc2_.Imageid);
               this.FMCEmblemRight["pos"].addChild(this.FEmblemIconR);
               this.FEmblemIconR.x = -this.FEmblemIconR.width >> 1;
               this.FEmblemIconR.y = -this.FEmblemIconR.height >> 1;
            }
         }
         if(this.FBattleInfo.PlayerInfo_1.RingId > 0)
         {
            _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Emblem,this.FBattleInfo.PlayerInfo_1.RingId) as TEmblem;
            this.FRingResIdL = _loc2_.Unlockcondition;
         }
         if(this.FBattleInfo.PlayerInfo_2.RingId > 0)
         {
            _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Emblem,this.FBattleInfo.PlayerInfo_2.RingId) as TEmblem;
            this.FRingResIdR = _loc2_.Unlockcondition;
         }
         if(this.FLoaderQueue.length > 0)
         {
            this.FLoader.load(this.FLoaderQueue.pop(),new LoaderContext(true));
         }
      }
      
      protected function loadEmblemIcon(param1:Boolean = false) : void
      {
         var _loc2_:Bitmap = null;
         var _loc3_:URLRequest = null;
         if(this._cacheList[this.ImageUrl] is BitmapData)
         {
            _loc2_ = new Bitmap(this._cacheList[this.ImageUrl],"auto",true);
            if(param1)
            {
               this.FMCEmblemLeft["pos"].addChild(_loc2_);
            }
            else
            {
               this.FMCEmblemRight["pos"].addChild(_loc2_);
            }
            _loc2_.x = -_loc2_.width >> 1;
            _loc2_.y = -_loc2_.height >> 1;
         }
         else
         {
            if(this.FLoader == null)
            {
               this.FLoader = new Loader();
               this.FLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onComplete);
               this.FLoader.contentLoaderInfo.addEventListener(ErrorEvent.ERROR,this.onError);
               this.FLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onIOError);
            }
            _loc3_ = new URLRequest(this.ImageUrl);
            _loc3_.data = param1;
            this.FLoaderQueue.push(_loc3_);
         }
      }
      
      protected function onComplete(param1:Event) : void
      {
         var _loc2_:DisplayObject = null;
         var _loc3_:String = null;
         if(this.FLoader)
         {
            _loc2_ = this.FLoader.content;
            _loc3_ = _loc2_.loaderInfo.url.split("?")[1];
            if(_loc2_ is Bitmap)
            {
               if(!this._cacheList[this.ImageUrl])
               {
                  this._cacheList[this.ImageUrl] = Bitmap(_loc2_).bitmapData.clone();
               }
               if(_loc3_ == "true")
               {
                  this.FMCEmblemLeft["pos"].addChild(_loc2_);
               }
               else
               {
                  this.FMCEmblemRight["pos"].addChild(_loc2_);
               }
               _loc2_.x = -_loc2_.width >> 1;
               _loc2_.y = -_loc2_.height >> 1;
            }
         }
         if(this.FLoaderQueue.length > 0)
         {
            this.FLoader.load(this.FLoaderQueue.pop(),new LoaderContext(true));
         }
      }
      
      protected function onError(param1:ErrorEvent) : void
      {
      }
      
      protected function onIOError(param1:IOErrorEvent) : void
      {
      }
      
      protected function dispose() : void
      {
         if(Boolean(this.FMCEmblemLeft) && Boolean(this.FMCEmblemLeft["pos"]))
         {
            this.FMCEmblemLeft["pos"].removeChildren();
         }
         if(Boolean(this.FMCEmblemRight) && Boolean(this.FMCEmblemRight["pos"]))
         {
            this.FMCEmblemRight["pos"].removeChildren();
         }
      }
      
      protected function LoadResources() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Vector.<uint> = null;
         this.FProcessorBattleLoading.StartLoading();
         _loc2_ = CONST_BATTLE.COMMON_EffectVect;
         SResourcesCore.TexturesSwfSkill.LoadPrimary(CONST_BATTLE.EFFECT_BIGBLACK_ID);
         _loc1_ = 0;
         while(_loc1_ < _loc2_.length)
         {
            SResourcesCore.TexturesSwfSkill.LoadPrimary(_loc2_[_loc1_]);
            _loc1_++;
         }
         if(this.FEnterType == ENTER_TYPE_CityDefend || this.FEnterType == ENTER_TYPE_REPLAY)
         {
            SResourcesCore.TexturesSwfSkill.LoadPrimary(CONST_BATTLE.Effect_CITYDEFEND_BOOM);
         }
         _loc1_ = 0;
         while(_loc1_ < this.FModelVect.length)
         {
            SResourcesCore.TexturesModel.LoadPrimary(this.FModelVect[_loc1_],CONST_MODULES.MODULE_Battle);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this.FLargeVect.length)
         {
            SResourcesCore.TexturesLargeIcon.LoadPrimary(this.FLargeVect[_loc1_],CONST_MODULES.MODULE_Battle);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this.FSkillVect.length)
         {
            SResourcesCore.TexturesSwfSkill.LoadPrimary(this.FSkillVect[_loc1_]);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this.FSoulFormationVect.length)
         {
            SResourcesCore.TexturesSwfSkill.LoadPrimary(this.FSoulFormationVect[_loc1_]);
            _loc1_++;
         }
         FResourcesState = RESOURCESSTATE_UIRequest;
      }
      
      protected function LoadResourcesEnd(param1:Object = null) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Boolean = false;
         var _loc4_:uint = 0;
         this.FIsBattleEnd = false;
         this.StartBattle();
         this.CheckEmblemInfo();
         if(SLogicsCore.Character.IsSkillShowTime)
         {
            this.FButtonSkip.visible = false;
            if(this.FBattleRound)
            {
               this.FBattleRound.visible = false;
            }
            this.FButtonSkipCopy.visible = true;
         }
         else
         {
            this.FButtonSkip.visible = true;
            if(this.FBattleRound)
            {
               this.FBattleRound.visible = true;
            }
            this.FButtonSkipCopy.visible = false;
         }
         if(this.FVipData == null)
         {
            this.FVipData = SLogicsCore.Character.VipData;
         }
         _loc4_ = this.GetSkipCardNum();
         switch(this.FEnterType)
         {
            case ENTER_TYPE_NODAL:
               _loc2_ = int(PLAY_SCENE_Nodal);
               _loc3_ = this.FVipData.SkipBlock;
               break;
            case ENTER_TYPE_CAMP:
               _loc2_ = int(PLAY_SCENE_Campaign);
               _loc3_ = this.FVipData.SkipBlock;
               break;
            case ENTER_TYPE_TRIALS:
               _loc2_ = int(PLAY_SCENE_KillHeros);
               _loc3_ = this.FVipData.SkipChargeFight;
               break;
            case ENTER_TYPE_ARENA:
               _loc2_ = int(PLAY_SCENE_Arena);
               _loc3_ = this.FVipData.ArenaSkip;
               break;
            case ENTER_TYPE_TREASUREMAP:
               _loc2_ = int(PLAY_SCENE_Arena);
               _loc3_ = this.FVipData.ArenaSkip;
               break;
            case ENTER_TYPE_CityDefend:
               _loc2_ = int(PLAY_SCENE_Arena);
               _loc3_ = this.FVipData.ArenaSkip;
               break;
            case ENTER_TYPE_FightPet:
               _loc2_ = int(PLAY_SCENE_Arena);
               _loc3_ = this.FVipData.ArenaSkip;
               break;
            case ENTER_TYPE_TraitorAttack:
               _loc2_ = int(PLAY_SCENE_Arena);
               _loc3_ = this.FVipData.ArenaSkip;
               break;
            case ENTER_TYPE_Slave:
               _loc2_ = int(PLAY_SCENE_Arena);
               _loc3_ = this.FVipData.ArenaSkip;
               break;
            case Enter_TYPE_SevenKing:
               _loc2_ = int(PLAY_SCENE_Arena);
               _loc3_ = this.FVipData.SevenKingSkip;
               break;
            case Enter_TYPE_CrossServerWar:
               _loc2_ = int(PLAY_SCENE_Arena);
               _loc3_ = this.FVipData.SevenKingSkip;
               break;
            case Enter_TYPE_Magic:
               _loc2_ = int(PLAY_SCENE_Arena);
               _loc3_ = this.FVipData.SevenKingSkip;
               break;
            case Enter_TYPE_Tower:
               _loc2_ = int(PLAY_SCENE_Arena);
               _loc3_ = this.FVipData.SkipBlock;
               break;
            case Enter_TYPE_Palace:
               _loc2_ = int(PLAY_SCENE_Arena);
               _loc3_ = this.FVipData.SkipBlock;
               break;
            case Enter_TYPE_OrganizationBoss:
               _loc2_ = int(PLAY_SCENE_Arena);
               _loc3_ = this.FVipData.ArenaSkip;
               break;
            case Enter_TYPE_Friend:
               _loc2_ = int(PLAY_SCENE_Arena);
               _loc3_ = this.FVipData.ArenaSkip;
               break;
            case Enter_TYPE_BloodSoul:
               _loc2_ = int(PLAY_SCENE_Arena);
               _loc3_ = this.FVipData.ArenaSkip;
               break;
            case Enter_TYPE_SixFairy:
               _loc2_ = int(PLAY_SCENE_Arena);
               _loc3_ = this.FVipData.ArenaSkip;
               break;
            case BattleType_RebirthRealm:
               _loc2_ = int(PLAY_SCENE_Arena);
               _loc3_ = this.FVipData.ArenaSkip;
               break;
            case BattleType_TransmigrationTrial:
               _loc2_ = int(PLAY_SCENE_Arena);
               _loc3_ = this.FVipData.ArenaSkip;
               break;
            case ENTER_TYPE_REPLAY:
               _loc3_ = true;
               break;
            case BattleType_Taboo:
               _loc2_ = int(PLAY_SCENE_Arena);
               _loc3_ = this.FVipData.ArenaSkip;
               break;
            case BattleType_TransmigrationAccessory:
               _loc2_ = int(PLAY_SCENE_Arena);
               _loc3_ = this.FVipData.ArenaSkip;
               break;
            case BattleType_UnderTown:
               _loc2_ = int(PLAY_SCENE_Arena);
               _loc3_ = this.FVipData.ArenaSkip;
               break;
            case BattleType_MiGong:
               _loc2_ = int(PLAY_SCENE_Arena);
               _loc3_ = this.FVipData.ArenaSkip;
               break;
            case BattleType_Challenge:
               _loc2_ = int(PLAY_SCENE_Arena);
               _loc3_ = this.FVipData.ArenaSkip;
               break;
            case BattleType_Wing:
               _loc2_ = int(PLAY_SCENE_Arena);
               _loc3_ = this.FVipData.ArenaSkip;
               break;
            case BattleType_MasterRoad:
               _loc2_ = int(PLAY_SCENE_Arena);
               _loc3_ = this.FVipData.ArenaSkip;
               break;
            case BattleType_Alien:
               _loc2_ = int(PLAY_SCENE_Arena);
               _loc3_ = this.FVipData.ArenaSkip;
               break;
            case BattleType_Qiecuo:
               _loc2_ = int(PLAY_SCENE_Arena);
               _loc3_ = this.FVipData.ArenaSkip;
               break;
            case BattleType_GlobalBattle:
               _loc2_ = int(PLAY_SCENE_Arena);
               _loc3_ = this.FVipData.ArenaSkip;
               this.SetGlobalBattleScore(this.FGlobalBattleScore);
               break;
            case BattleType_WorldMatch:
               _loc2_ = int(PLAY_SCENE_Arena);
               _loc3_ = this.FVipData.ArenaSkip;
               break;
            case BattleType_SummonBattle:
               _loc2_ = int(PLAY_SCENE_Arena);
               _loc3_ = this.FVipData.ArenaSkip;
               break;
            case BattleType_ChallengeCamp:
               _loc2_ = int(PLAY_SCENE_Arena);
               _loc3_ = this.FVipData.ArenaSkip;
               break;
            case BattleType_GlobalBoss:
               _loc2_ = int(PLAY_SCENE_Arena);
               _loc3_ = this.FVipData.ArenaSkip;
               break;
            case BattleType_CrossSlave:
               _loc2_ = int(PLAY_SCENE_Arena);
               _loc3_ = this.FVipData.ArenaSkip;
         }
         this.Skip = _loc3_ || _loc4_ > 0;
         SLogicsCore.SignalPost(CONST_SIGNAL.SIGNALDESTINATION_SOUND,_loc2_,this.FEnterId,true);
         this.FProcessorBattleLoading.EndLoading();
      }
      
      protected function NegotiateBrforeBattleF() : void
      {
         var _loc1_:int = 0;
         if(!this.FIsAutoSkipResurgence)
         {
            return;
         }
         this.ButtonSkipOnClick(null);
      }
      
      protected function UnLoadResourcesEnd(param1:Object = null) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Bitmap = null;
         this.FProcessorBattleLoading.EndLoading();
         if(this.FSkillVect != null)
         {
            this.FSkillVect.length = 0;
         }
         if(this.FSoulFormationVect != null)
         {
            this.FSoulFormationVect.length = 0;
         }
         if(this.FBackgroundVect != null)
         {
            if(this.FBattleBg.bitmapData != null)
            {
               this.FBattleBg.bitmapData = null;
            }
            if(this.FChgBattleBg.bitmapData != null)
            {
               this.FChgBattleBg.bitmapData = null;
            }
            this.FBackgroundVect.length = 0;
         }
         _loc2_ = 0;
         while(_loc2_ < this.FBgSprite.numChildren)
         {
            _loc3_ = this.FBgSprite.getChildAt(_loc2_) as Bitmap;
            if(_loc3_.bitmapData != null)
            {
               _loc3_.bitmapData = null;
            }
            _loc2_++;
         }
         this.FBgSpriteInit = false;
         this.TurnBack();
      }
      
      protected function StartBattle() : void
      {
         var _loc1_:TBattleStage = null;
         _loc1_ = this.GetBattleStage();
         this.FBattleStages.push(_loc1_);
         _loc1_.CreditCommandList(this.FBattleInfo);
         if(!this.FOverlayerHint)
         {
         }
         if(!this.FOverlayerPetSoulFormation)
         {
         }
         addChild(this.FProcessorBattleLoading);
      }
      
      protected function OnReplayByByteArrayCopy(param1:Object) : void
      {
         if(this.FBattleInfo == null)
         {
            return;
         }
         this.FIsReplay = true;
         TEffectControl.RemoveAllEffect();
         TEffectControl.RemoveAllSpecialChainEffect();
         this.FBattleInfo.FillData();
         this.LoadResourcesEnd();
      }
      
      protected function OnReplayByByteArray(param1:Object) : void
      {
         if(this.FBattleInfo == null)
         {
            return;
         }
         this.FIsReplay = true;
         TEffectControl.RemoveAllEffect();
         TEffectControl.RemoveAllSpecialChainEffect();
         this.FBattleInfo.ResetTotalHp();
         this.FBattleInfo.FillData();
         this.LoadResourcesEnd();
      }
      
      protected function ProcessorOnChangeBg(param1:Object, param2:uint) : void
      {
         if(param2 == 0)
         {
            TweenUtil.to(this.FChgBattleBg,300,{"alpha":0});
            TweenUtil.to(this.FBattleBg,300,{"alpha":1});
         }
         else
         {
            TweenUtil.to(this.FChgBattleBg,300,{"alpha":1});
            TweenUtil.to(this.FBattleBg,300,{"alpha":0});
         }
         this.FNewBgId = param2;
         this.FIsNewBg = Boolean(param2 != 0);
      }
      
      protected function OnAntiColorBlackWhiteBg(param1:Object, param2:Boolean) : void
      {
         if(param2)
         {
            this.FBattleBg.filters = [TGameUtil.AntiColorFilters,TGameUtil.rBlackFilters];
            this.FBgSprite.filters = [TGameUtil.AntiColorFilters,TGameUtil.rBlackFilters];
         }
         else
         {
            this.FBattleBg.filters = [];
            this.FBgSprite.filters = [];
         }
      }
      
      protected function OnRedAntiColor(param1:Object, param2:Boolean) : void
      {
         if(param2)
         {
            this.FBattleBg.filters = [TGameUtil.rBlackFilters,TGameUtil.RedAntiColorFilters];
            this.FBgSprite.filters = [TGameUtil.rBlackFilters,TGameUtil.RedAntiColorFilters];
         }
         else
         {
            this.FBattleBg.filters = [];
            this.FBgSprite.filters = [];
         }
      }
      
      protected function CheckPlot(param1:Object) : void
      {
         if(SLogicsCore.Character.IsSkillShowTime)
         {
            this.OnEndBattle();
            return;
         }
         if(this.FEnterType == CONST_BATTLE.BattleType_Nodal)
         {
            if(this.FIsWin && this.FMonsterCount <= 1)
            {
               if(this.FProcessorCheckPlot != null)
               {
                  this.FProcessorCheckPlot(this,TProcessorPlot.PLOT_TYPE_Nodal,TProcessorPlot.PLOT_POS_FightEnd,this.FEnterId,this.OnEndBattle);
                  return;
               }
            }
         }
         this.OnEndBattle();
      }
      
      protected function GetShowData() : Vector.<uint>
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:Vector.<uint> = null;
         _loc4_ = new Vector.<uint>();
         _loc3_ = uint(SLogicsCore.Character.GetMainLevelCopy());
         switch(this.FEnterType)
         {
            case ENTER_TYPE_NODAL:
            case ENTER_TYPE_CAMP:
            case ENTER_TYPE_TRIALS:
            case ENTER_TYPE_FightPet:
            case ENTER_TYPE_TraitorAttack:
            case Enter_TYPE_SevenKing:
            case Enter_TYPE_Magic:
            case Enter_TYPE_Tower:
            case Enter_TYPE_OrganizationBoss:
            case Enter_TYPE_BloodSoul:
            case Enter_TYPE_SixFairy:
            case BattleType_RebirthRealm:
            case BattleType_TransmigrationTrial:
            case BattleType_Taboo:
            case BattleType_TransmigrationAccessory:
            case BattleType_UnderTown:
            case BattleType_MiGong:
            case BattleType_Wing:
            case BattleType_MasterRoad:
            case BattleType_Alien:
            case BattleType_ChallengeCamp:
            case BattleType_GlobalBoss:
               _loc2_ = this.FSystemDeffeat_PVE.length;
               _loc1_ = 0;
               while(_loc1_ < _loc2_)
               {
                  if(_loc3_ >= this.FSystemDeffeat_PVE[_loc1_][1])
                  {
                     _loc4_.push(this.FSystemDeffeat_PVE[_loc1_][0]);
                  }
                  _loc1_++;
               }
               break;
            case ENTER_TYPE_ARENA:
            case ENTER_TYPE_TREASUREMAP:
            case ENTER_TYPE_CityDefend:
            case ENTER_TYPE_Slave:
            case Enter_TYPE_CrossServerWar:
            case Enter_TYPE_Palace:
            case Enter_TYPE_Friend:
            case ENTER_TYPE_REPLAY:
            case BattleType_Challenge:
            case BattleType_Qiecuo:
            case BattleType_GlobalBattle:
            case BattleType_WorldMatch:
            case BattleType_SummonBattle:
            case BattleType_CrossSlave:
               _loc2_ = this.FSystemDeffeat_PVP.length;
               _loc1_ = 0;
               while(_loc1_ < _loc2_)
               {
                  if(_loc3_ >= this.FSystemDeffeat_PVP[_loc1_][1])
                  {
                     _loc4_.push(this.FSystemDeffeat_PVP[_loc1_][0]);
                  }
                  _loc1_++;
               }
         }
         return _loc4_;
      }
      
      protected function OnEndBattle(param1:Object = null) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TBattleStage = null;
         var _loc4_:Vector.<uint> = null;
         this.FIsBattleEnd = true;
         _loc2_ = 0;
         while(_loc2_ < this.FBattleStages.length)
         {
            _loc3_ = this.FBattleStages[_loc2_];
            if(_loc3_ != null && _loc3_.EndStatues == false)
            {
               this.FIsBattleEnd = false;
               break;
            }
            _loc2_++;
         }
         if(SLogicsCore.Character.IsSkillShowTime)
         {
            while(this.FBattleStages.length)
            {
               _loc3_ = this.FBattleStages.pop();
               this.FPoolBattleStages.SaveBattleStage(_loc3_);
            }
            this.FBattleBg.filters = [];
            this.FBgSprite.filters = [];
            return;
         }
         if(this.FReward == null)
         {
            return;
         }
         if(this.FIsBattleEnd)
         {
            if(this.FIsWin)
            {
               if(this.FReward.ItemIDs.length <= 0 && this.FEnterType != BattleType_GlobalBoss)
               {
                  this.FResultWindow.visible = true;
                  this.FResultWindow.SetWindow(this.FReward,true,this.FEnterType != 0,this.FEnterType != 0,this.FIsAutoBattle);
               }
               else
               {
                  this.FWinWindow.visible = true;
                  this.FWinWindow.SetWindow(this.FReward,this.FEnterType,this.FEnterType != 0,this.FEnterType != 0,this.FIsAutoBattle);
               }
            }
            else
            {
               _loc4_ = this.GetShowData();
               if(this.FReward.Items.length > 0)
               {
                  this.FResultWindow.visible = true;
                  this.FResultWindow.SetWindow(this.FReward,false,this.FEnterType != 0,this.FEnterType != 0,this.FIsAutoBattle);
                  this.FResultWindow.SetLostShowData(_loc4_);
               }
               else
               {
                  this.FLostWindow.visible = true;
                  if(this.FEnterType == BattleType_MasterRoad)
                  {
                     this.FLostWindow.SetWindow(this.FMosterRoadResult,this.FEnterType != 0,this.FEnterType != 0,this.FIsAutoBattle);
                     this.FLostWindow.SetLostShowData(_loc4_);
                  }
                  else
                  {
                     this.FLostWindow.SetWindow(STRING_BATTLE.STRINGS_BattleLost,this.FEnterType != 0,this.FEnterType != 0,this.FIsAutoBattle);
                     this.FLostWindow.SetLostShowData(_loc4_);
                  }
               }
            }
            while(this.FBattleStages.length)
            {
               _loc3_ = this.FBattleStages.pop();
               this.FPoolBattleStages.SaveBattleStage(_loc3_);
            }
            this.FOverlayerPetSoulFormation && this.FOverlayerPetSoulFormation.Hide();
         }
         this.FBattleBg.filters = [];
         this.FBgSprite.filters = [];
      }
      
      protected function ButtonSkipCopyOnClick(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(SLogicsCore.Character.IsSkillShowTime)
         {
            if(this.FBattleRoundClass != null)
            {
               this.FBattleRoundClass.Reset();
            }
            _loc2_ = 0;
            while(_loc2_ < this.FBattleStages.length)
            {
               this.FBattleStages[_loc2_].ButtonSkipOnClick();
               _loc2_++;
            }
            if(this.FOnQuit != null)
            {
               this.FOnQuit(this,this.FEnterType,this.FIsWin);
            }
            this.UnLoadResources();
            SResourcesCore.PerformAutoReleaseResources(CONST_MODULES.MODULE_Battle);
            TBattleHandle.IsInBattle = false;
            SLogicsCore.Character.IsSkillShowTime = false;
            return;
         }
      }
      
      protected function TurnBack(param1:Object = null) : void
      {
         if(this.FBattleRoundClass != null)
         {
            this.FBattleRoundClass.Reset();
         }
         if(this.FOnQuit != null)
         {
            this.FOnQuit(this,this.FEnterType,this.FIsWin);
         }
         if(this.FEnterType == ENTER_TYPE_TRIALS)
         {
            if(this.FIsWin)
            {
               if(this.FTurnBackKillHero != null)
               {
                  this.FTurnBackKillHero(this,this.FIsWin,this.FEnterId);
                  this.UnLoadResources();
               }
            }
            else if(this.FTurnBackBattleScene != null)
            {
               this.FTurnBackBattleScene(this,this.FIsWin);
            }
         }
         else if(this.FEnterType == ENTER_TYPE_ARENA)
         {
            if(this.FTurnBackArena != null)
            {
               this.FTurnBackArena(this);
               this.UnLoadResources();
            }
         }
         else if(this.FEnterType == ENTER_TYPE_TREASUREMAP)
         {
            if(this.FTurnBackTreasureMap != null)
            {
               this.FTurnBackTreasureMap(this,this.FIsWin);
               this.UnLoadResources();
            }
         }
         else if(this.FEnterType == ENTER_TYPE_FightPet)
         {
            if(this.FTurnBackFightPet != null)
            {
               this.FTurnBackFightPet(this);
               this.UnLoadResources();
            }
         }
         else if(this.FEnterType == ENTER_TYPE_CityDefend)
         {
            if(this.FTurnBackCityDefend != null)
            {
               this.FTurnBackCityDefend(this);
               this.UnLoadResources();
            }
         }
         else if(this.FEnterType == ENTER_TYPE_OrganizationWar)
         {
            if(this.FTurnBackOrganizationWar != null)
            {
               this.FTurnBackOrganizationWar(this);
               this.UnLoadResources();
            }
         }
         else if(this.FEnterType == ENTER_TYPE_TraitorAttack)
         {
            if(this.FTurnBackTraitorAttack != null)
            {
               this.FTurnBackTraitorAttack(this);
               this.UnLoadResources();
            }
         }
         else if(this.FEnterType == ENTER_TYPE_Slave)
         {
            if(this.FTurnBackSlave != null)
            {
               this.FTurnBackSlave(this);
               this.UnLoadResources();
            }
         }
         else if(this.FEnterType == Enter_TYPE_SevenKing)
         {
            if(this.FTurnBackSevenKing != null)
            {
               this.FTurnBackSevenKing(this);
               this.UnLoadResources();
            }
         }
         else if(this.FEnterType == Enter_TYPE_CrossServerWar)
         {
            if(this.FTurnBackCrossServerWar != null)
            {
               this.FTurnBackCrossServerWar(this,this.FIsWin);
               this.UnLoadResources();
            }
         }
         else if(this.FEnterType == Enter_TYPE_Magic)
         {
            if(this.FTurnBackMagic != null)
            {
               this.FTurnBackMagic(this);
               this.UnLoadResources();
            }
         }
         else if(this.FEnterType == Enter_TYPE_Tower)
         {
            if(this.FTurnBackTower != null)
            {
               this.FTurnBackTower(this);
               this.UnLoadResources();
            }
         }
         else if(this.FEnterType == Enter_TYPE_Palace)
         {
            if(this.FTurnBackPalace != null)
            {
               this.FTurnBackPalace(this);
               this.UnLoadResources();
            }
         }
         else if(this.FEnterType == Enter_TYPE_OrganizationBoss)
         {
            if(this.FTurnBackOrganizationBoss != null)
            {
               this.FTurnBackOrganizationBoss(this,this.FIsWin);
               this.UnLoadResources();
            }
         }
         else if(this.FEnterType == Enter_TYPE_Friend)
         {
            if(this.FTurnBackFriend != null)
            {
               this.FTurnBackFriend(this);
               this.UnLoadResources();
            }
         }
         else if(this.FEnterType == Enter_TYPE_BloodSoul)
         {
            if(this.FTurnBackBloodSoul != null)
            {
               this.UnLoadResources();
               this.FTurnBackBloodSoul(this);
            }
         }
         else if(this.FEnterType == Enter_TYPE_SixFairy)
         {
            if(this.FTurnBackSixFairy != null)
            {
               this.FTurnBackSixFairy(this);
               this.UnLoadResources();
            }
         }
         else if(this.FEnterType == BattleType_RebirthRealm)
         {
            if(this.FTurnBackRebirthRealm != null)
            {
               this.FTurnBackRebirthRealm(this);
               this.UnLoadResources();
            }
         }
         else if(this.FEnterType == BattleType_TransmigrationTrial)
         {
            if(this.FTurnBackTransmigrationTrial != null)
            {
               this.FTurnBackTransmigrationTrial(this);
               this.UnLoadResources();
            }
         }
         else if(this.FEnterType == BattleType_Taboo)
         {
            if(this.FTurnBackTaboo != null)
            {
               this.FTurnBackTaboo(this);
               this.UnLoadResources();
            }
         }
         else if(this.FEnterType == BattleType_TransmigrationAccessory)
         {
            if(this.FTurnBackTransmigrationAccessory != null)
            {
               this.FTurnBackTransmigrationAccessory(this);
               this.UnLoadResources();
            }
         }
         else if(this.FEnterType == BattleType_UnderTown)
         {
            if(this.FTurnBackUndertown != null)
            {
               this.FTurnBackUndertown(this);
               this.UnLoadResources();
            }
         }
         else if(this.FEnterType == BattleType_MiGong)
         {
            if(this.FTurnBackMiGong != null)
            {
               this.FTurnBackMiGong(this);
               this.UnLoadResources();
            }
         }
         else if(this.FEnterType == BattleType_MasterRoad)
         {
            if(this.TurnBackMasterRoad != null)
            {
               this.TurnBackMasterRoad(this);
               this.UnLoadResources();
            }
         }
         else if(this.FEnterType == BattleType_Challenge)
         {
            if(this.TurnBackChallenge != null)
            {
               this.TurnBackChallenge(this);
               this.UnLoadResources();
            }
         }
         else if(this.FEnterType == BattleType_Wing)
         {
            if(this.TurnBackWing != null)
            {
               this.TurnBackWing(this);
               this.UnLoadResources();
            }
         }
         else if(this.FEnterType == BattleType_Alien)
         {
            if(this.TurnBackAlien != null)
            {
               this.TurnBackAlien(this);
               this.UnLoadResources();
            }
         }
         else if(this.FEnterType == BattleType_Qiecuo)
         {
            if(this.TurnBackQiecuo != null)
            {
               this.TurnBackQiecuo(this);
               this.UnLoadResources();
            }
         }
         else if(this.FEnterType == BattleType_GlobalBattle)
         {
            if(this.TurnBackGlobalBattle != null)
            {
               this.TurnBackGlobalBattle(this);
               this.UnLoadResources();
            }
         }
         else if(this.FEnterType == BattleType_WorldMatch)
         {
            if(this.TurnBackWorldMatch != null)
            {
               this.TurnBackWorldMatch(this);
               this.UnLoadResources();
            }
         }
         else if(this.FEnterType == BattleType_SummonBattle)
         {
            if(this.TurnBackSummonBattle != null)
            {
               this.TurnBackSummonBattle(this);
               this.UnLoadResources();
            }
         }
         else if(this.FEnterType == BattleType_ChallengeCamp)
         {
            if(this.TurnBackChallengeCamp != null)
            {
               this.TurnBackChallengeCamp(this);
               this.UnLoadResources();
            }
         }
         else if(this.FEnterType == BattleType_GlobalBoss)
         {
            if(this.TurnBackGlobalBoss != null)
            {
               this.TurnBackGlobalBoss(this);
               this.UnLoadResources();
            }
         }
         else if(this.FEnterType == BattleType_CrossSlave)
         {
            if(this.TurnBackCrossSlave != null)
            {
               this.TurnBackCrossSlave(this);
               this.UnLoadResources();
            }
         }
         else if(this.FTurnBackBattleScene != null)
         {
            this.FTurnBackBattleScene(this,this.FIsWin);
         }
         SResourcesCore.PerformAutoReleaseResources(CONST_MODULES.MODULE_Battle);
         TBattleHandle.IsInBattle = false;
         this.FknowRezult = false;
      }
      
      protected function GetSkipCardNum() : uint
      {
         var _loc1_:TInventories = null;
         var _loc2_:TInventory = null;
         var _loc3_:uint = 0;
         var _loc4_:int = 0;
         var _loc5_:uint = 0;
         _loc3_ = 0;
         _loc1_ = SLogicsCore.Character.Appliances;
         _loc5_ = uint(_loc1_.Count);
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc2_ = _loc1_.GetInventoryByIndex(_loc4_);
            if(_loc2_.IDTemplate == CONST_BATTLE.BattleSkipCard)
            {
               _loc3_ += _loc2_.Quantity;
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      protected function CheckBattleSkip() : Boolean
      {
         var _loc1_:Boolean = false;
         if(this.FEnterType == 0)
         {
            return false;
         }
         return this.FBattleSkip.GetBattleSkipStatus(this.FEnterType);
      }
      
      protected function DispatchUIRes() : void
      {
         var _loc1_:TConfigValue = null;
         if(this.FOverlayerHint == null)
         {
            this.FOverlayerEquipment = new TOverlayerEquipment(this,CONST_MODULES.MODULE_Battle);
            Parent.addChildAt(this.FOverlayerEquipment,Parent.getChildIndex(this) + 1);
            this.FOverlayerEquipment.Visible = false;
            this.FOverlayerTreasure = new TOverlayerTreasure(this,CONST_MODULES.MODULE_Battle);
            Parent.addChildAt(this.FOverlayerTreasure,Parent.getChildIndex(this) + 1);
            this.FOverlayerTreasure.Visible = false;
            this.FOverlayerAppliance = new TOverlayerAppliance(this,CONST_MODULES.MODULE_Battle);
            Parent.addChildAt(this.FOverlayerAppliance,Parent.getChildIndex(this) + 1);
            this.FOverlayerAppliance.Visible = false;
            this.FOverlayerHint = new TOverlayerHint(this);
            Parent.addChildAt(this.FOverlayerHint,Parent.getChildIndex(this) + 1);
            this.FOverlayerHint.visible = false;
            this.FTabooTip = new TTabooTip(this);
            Parent.addChildAt(this.FTabooTip,Parent.getChildIndex(this) + 1);
            this.FTabooTip.visible = false;
            this.FOverlayerAccessory = new TOverlayerAccessory(this,CONST_MODULES.MODULE_Battle);
            Parent.addChildAt(this.FOverlayerAccessory,Parent.getChildIndex(this) + 1);
            this.FOverlayerAccessory.Visible = false;
            this.FOverlayerAccessory.IsMeOrOthers = 0;
            this.FOverlayerPetSoulFormation = new TOverlayerPetSoulFormation(this);
            Parent.addChildAt(this.FOverlayerPetSoulFormation,Parent.getChildIndex(this) + 1);
            this.FOverlayerPetSoulFormation.Visible = false;
            TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerPetSoulFormation);
            TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerEquipment);
            TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerTreasure);
            TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerAppliance);
            TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerHint);
            TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerAccessory);
            TUtilityUIOverlayer.ResourcesDispatch(this.FTabooTip);
         }
         if(this.FResultWindow == null)
         {
            this.FResultWindow = new TBattleResultWindow(this);
            Parent.addChildAt(this.FResultWindow,Parent.getChildIndex(this) + 1);
            this.FResultWindow.ClickCallBack = this.TurnBack;
            this.FResultWindow.ReplayCallBack = this.OnReplayByByteArray;
            this.FResultWindow.HintOnMove = this.UIComponentsHintOnOver;
            this.FResultWindow.HintOnOut = this.UIComponentsHintOnOut;
            this.FResultWindow.x = (CONST_COMMON.STAGE_Width - this.FBoundsResultWindow.Width) / 2;
            this.FResultWindow.y = (CONST_COMMON.STAGE_Height - this.FBoundsResultWindow.Height) / 2;
         }
         if(this.FWinWindow == null)
         {
            this.FWinWindow = new TBattleWinWindow(this);
            Parent.addChildAt(this.FWinWindow,Parent.getChildIndex(this) + 1);
            this.FWinWindow.ClickCallBack = this.TurnBack;
            this.FWinWindow.SlotsOnMove = this.UIComponentsApplianceOnOver;
            this.FWinWindow.SlotsOnOut = this.UIComponentsApplianceOnOut;
            this.FWinWindow.ReplayCallBack = this.OnReplayByByteArray;
            this.FWinWindow.HintOnMove = this.UIComponentsHintOnOver;
            this.FWinWindow.HintOnOut = this.UIComponentsHintOnOut;
            this.FWinWindow.Setup();
            this.FWinWindow.x = (CONST_COMMON.STAGE_Width - this.FBoundsWinWindow.Width) / 2;
            this.FWinWindow.y = (CONST_COMMON.STAGE_Height - this.FBoundsWinWindow.Height) / 2;
         }
         if(this.FLostWindow == null)
         {
            this.FLostWindow = new TBattleLostWindow(this);
            Parent.addChildAt(this.FLostWindow,Parent.getChildIndex(this) + 1);
            this.FLostWindow.ClickCallBack = this.TurnBack;
            this.FLostWindow.ReplayCallBack = this.OnReplayByByteArray;
            this.FLostWindow.HintOnMove = this.UIComponentsHintOnOver;
            this.FLostWindow.HintOnOut = this.UIComponentsHintOnOut;
            this.FLostWindow.x = (CONST_COMMON.STAGE_Width - this.FBoundsLostWindow.Width) / 2;
            this.FLostWindow.y = (CONST_COMMON.STAGE_Height - this.FBoundsLostWindow.Height) / 2;
         }
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.SYSTEM_DEFFEAT_PVE) as TConfigValue;
         this.FSystemDeffeat_PVE = _loc1_.Value as Vector.<Object>;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.SYSTEM_DEFFEAT_PVP) as TConfigValue;
         this.FSystemDeffeat_PVP = _loc1_.Value as Vector.<Object>;
      }
      
      protected function HideReplay() : void
      {
         this.FResultWindow.SetShowReplay(false);
         this.FWinWindow.SetShowReplay(false);
         this.FLostWindow.SetShowReplay(false);
      }
      
      protected function ButtonSkipOnClick(param1:MouseEvent) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         if(param1)
         {
            if(Boolean(param1.currentTarget) && !param1.currentTarget.buttonMode)
            {
               return;
            }
         }
         if(this.FVipData == null)
         {
            this.FVipData = SLogicsCore.Character.VipData;
         }
         _loc4_ = uint(SLogicsCore.Character.VipLevel);
         _loc5_ = this.GetSkipCardNum();
         switch(this.FEnterType)
         {
            case ENTER_TYPE_NODAL:
               _loc3_ = uint(this.FVipData.VipOpenLevel_SkipBlock);
               break;
            case ENTER_TYPE_CAMP:
               _loc3_ = uint(this.FVipData.VipOpenLevel_SkipBlock);
               break;
            case ENTER_TYPE_TRIALS:
               _loc3_ = uint(this.FVipData.VipOpenLevel_SkipChargeFight);
               break;
            case ENTER_TYPE_ARENA:
               _loc3_ = uint(this.FVipData.VipOpenLevel_ArenaSkip);
               break;
            case ENTER_TYPE_TREASUREMAP:
               _loc3_ = uint(this.FVipData.VipOpenLevel_ArenaSkip);
               break;
            case ENTER_TYPE_CityDefend:
               _loc3_ = uint(this.FVipData.VipOpenLevel_ArenaSkip);
               break;
            case ENTER_TYPE_FightPet:
               _loc3_ = uint(this.FVipData.VipOpenLevel_ArenaSkip);
               break;
            case ENTER_TYPE_TraitorAttack:
               _loc3_ = uint(this.FVipData.VipOpenLevel_ArenaSkip);
               break;
            case ENTER_TYPE_Slave:
               _loc3_ = uint(this.FVipData.VipOpenLevel_ArenaSkip);
               break;
            case Enter_TYPE_SevenKing:
               _loc3_ = uint(this.FVipData.VipOpenLevel_SevenKingSkip);
               break;
            case Enter_TYPE_CrossServerWar:
               _loc3_ = uint(this.FVipData.VipOpenLevel_SevenKingSkip);
               break;
            case Enter_TYPE_Magic:
               _loc3_ = uint(this.FVipData.VipOpenLevel_SevenKingSkip);
               break;
            case Enter_TYPE_Tower:
               _loc3_ = uint(this.FVipData.VipOpenLevel_SkipBlock);
               break;
            case Enter_TYPE_Palace:
               _loc3_ = uint(this.FVipData.VipOpenLevel_SkipBlock);
               break;
            case Enter_TYPE_OrganizationBoss:
               _loc3_ = uint(this.FVipData.VipOpenLevel_ArenaSkip);
               break;
            case Enter_TYPE_Friend:
               _loc3_ = uint(this.FVipData.VipOpenLevel_ArenaSkip);
               break;
            case Enter_TYPE_BloodSoul:
               _loc3_ = uint(this.FVipData.VipOpenLevel_ArenaSkip);
               break;
            case Enter_TYPE_SixFairy:
               _loc3_ = uint(this.FVipData.VipOpenLevel_ArenaSkip);
               break;
            case BattleType_RebirthRealm:
               _loc3_ = uint(this.FVipData.VipOpenLevel_ArenaSkip);
               break;
            case BattleType_TransmigrationTrial:
               _loc3_ = uint(this.FVipData.VipOpenLevel_ArenaSkip);
               break;
            case ENTER_TYPE_REPLAY:
               break;
            case BattleType_Taboo:
               _loc3_ = uint(this.FVipData.VipOpenLevel_ArenaSkip);
               break;
            case BattleType_TransmigrationAccessory:
               _loc3_ = uint(this.FVipData.VipOpenLevel_ArenaSkip);
               break;
            case BattleType_UnderTown:
               _loc3_ = uint(this.FVipData.VipOpenLevel_ArenaSkip);
         }
         if(_loc4_ >= _loc3_)
         {
            _loc2_ = 0;
            while(_loc2_ < this.FBattleStages.length)
            {
               this.FBattleStages[_loc2_].ButtonSkipOnClick();
               _loc2_++;
            }
         }
         else if(_loc5_ > 0)
         {
            if(this.FIsAutoSkipResurgence)
            {
               this.ConfirmationOnOk(null);
            }
            else
            {
               this.FUIWindowConfirmation.Text = TUtilityString.Format(STRING_BATTLE.STRINGS_UseSkipCardReq,_loc5_,_loc3_);
               this.FUIWindowConfirmation.visible = true;
            }
         }
      }
      
      protected function ButtonSkipOnRoll(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         if(this.FVipData == null)
         {
            this.FVipData = SLogicsCore.Character.VipData;
         }
         _loc4_ = this.GetSkipCardNum();
         _loc5_ = uint(SLogicsCore.Character.VipLevel);
         if(param1.type == MouseEvent.MOUSE_MOVE)
         {
            _loc2_ = STRING_BATTLE.STRINGS_CanNotSkip + STRING_COMMON.COMMON_OPENVIPTIP;
            switch(this.FEnterType)
            {
               case ENTER_TYPE_NODAL:
                  _loc3_ = uint(this.FVipData.VipOpenLevel_SkipBlock);
                  break;
               case ENTER_TYPE_CAMP:
                  _loc3_ = uint(this.FVipData.VipOpenLevel_SkipBlock);
                  break;
               case ENTER_TYPE_TRIALS:
                  _loc3_ = uint(this.FVipData.VipOpenLevel_SkipChargeFight);
                  break;
               case ENTER_TYPE_ARENA:
                  _loc3_ = uint(this.FVipData.VipOpenLevel_ArenaSkip);
                  break;
               case ENTER_TYPE_TREASUREMAP:
                  _loc3_ = uint(this.FVipData.VipOpenLevel_ArenaSkip);
                  break;
               case ENTER_TYPE_CityDefend:
                  _loc3_ = uint(this.FVipData.VipOpenLevel_ArenaSkip);
                  break;
               case ENTER_TYPE_FightPet:
                  _loc3_ = uint(this.FVipData.VipOpenLevel_ArenaSkip);
                  break;
               case ENTER_TYPE_TraitorAttack:
                  _loc3_ = uint(this.FVipData.VipOpenLevel_ArenaSkip);
                  break;
               case ENTER_TYPE_Slave:
                  _loc3_ = uint(this.FVipData.VipOpenLevel_ArenaSkip);
                  break;
               case Enter_TYPE_SevenKing:
                  _loc3_ = uint(this.FVipData.VipOpenLevel_SevenKingSkip);
                  break;
               case Enter_TYPE_CrossServerWar:
                  _loc3_ = uint(this.FVipData.VipOpenLevel_SevenKingSkip);
                  break;
               case Enter_TYPE_Magic:
                  _loc3_ = uint(this.FVipData.VipOpenLevel_SevenKingSkip);
                  break;
               case Enter_TYPE_Tower:
                  _loc3_ = uint(this.FVipData.VipOpenLevel_SkipBlock);
                  break;
               case Enter_TYPE_Palace:
                  _loc3_ = uint(this.FVipData.VipOpenLevel_SkipBlock);
                  break;
               case Enter_TYPE_OrganizationBoss:
                  _loc3_ = uint(this.FVipData.VipOpenLevel_SkipBlock);
                  break;
               case Enter_TYPE_Friend:
                  _loc3_ = uint(this.FVipData.VipOpenLevel_ArenaSkip);
                  break;
               case Enter_TYPE_BloodSoul:
                  _loc3_ = uint(this.FVipData.VipOpenLevel_ArenaSkip);
                  break;
               case Enter_TYPE_SixFairy:
                  _loc3_ = uint(this.FVipData.VipOpenLevel_ArenaSkip);
                  break;
               case BattleType_RebirthRealm:
                  _loc3_ = uint(this.FVipData.VipOpenLevel_ArenaSkip);
                  break;
               case BattleType_TransmigrationTrial:
                  _loc3_ = uint(this.FVipData.VipOpenLevel_ArenaSkip);
                  break;
               case ENTER_TYPE_REPLAY:
                  break;
               case BattleType_Taboo:
                  _loc3_ = uint(this.FVipData.VipOpenLevel_ArenaSkip);
                  break;
               case BattleType_TransmigrationAccessory:
                  _loc3_ = uint(this.FVipData.VipOpenLevel_ArenaSkip);
                  break;
               case BattleType_UnderTown:
                  _loc3_ = uint(this.FVipData.VipOpenLevel_ArenaSkip);
            }
            if(_loc5_ >= _loc3_ || _loc4_ > 0)
            {
               return;
            }
            _loc2_ = _loc2_.split("%count%").join(_loc3_);
            this.FSkipHint.Caption = _loc2_;
            this.UIComponentsHintOnOver(this,this.FSkipHint);
         }
         else if(param1.type == MouseEvent.MOUSE_OUT)
         {
            this.UIComponentsHintOnOut(this);
         }
      }
      
      protected function UIComponentsApplianceOnOver(param1:Object, param2:Object) : void
      {
         var _loc3_:TInventory = null;
         var _loc4_:TOverlayer = null;
         var _loc5_:TabooDataCell = null;
         if(param2 is TabooDataCell)
         {
            _loc5_ = param2 as TabooDataCell;
            _loc4_ = this.FTabooTip;
         }
         else
         {
            _loc3_ = param2 as TInventory;
            switch(_loc3_.Category)
            {
               case CATEGORY_Equipment:
                  _loc4_ = this.FOverlayerEquipment;
                  break;
               case CATEGORY_Treasure:
                  _loc4_ = this.FOverlayerTreasure;
                  break;
               case CATEGORY_Accessories:
                  _loc4_ = this.FOverlayerAccessory;
                  break;
               default:
                  _loc4_ = this.FOverlayerAppliance;
            }
         }
         if(_loc4_ != null)
         {
            if(_loc5_)
            {
               _loc4_.Context = _loc5_;
            }
            else
            {
               _loc4_.Context = _loc3_;
            }
            _loc4_.Render(FUICore.MouseCoordinate);
            _loc4_.Show();
         }
      }
      
      protected function UIComponentsApplianceOnOut(param1:Object, param2:Object) : void
      {
         var _loc3_:TInventory = null;
         var _loc4_:TOverlayer = null;
         if(param2 is TabooDataCell)
         {
            _loc4_ = this.FTabooTip;
         }
         else
         {
            _loc3_ = param2 as TInventory;
            switch(_loc3_.Category)
            {
               case CATEGORY_Equipment:
                  _loc4_ = this.FOverlayerEquipment;
                  break;
               case CATEGORY_Treasure:
                  _loc4_ = this.FOverlayerTreasure;
                  break;
               case CATEGORY_Accessories:
                  _loc4_ = this.FOverlayerAccessory;
                  break;
               default:
                  _loc4_ = this.FOverlayerAppliance;
            }
         }
         if(_loc4_ != null)
         {
            _loc4_.Hide();
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
      
      protected function ProcessorSoulOnOver(param1:TSoulArray, param2:String) : void
      {
         this.FOverlayerPetSoulFormation.Context = param1;
         this.FOverlayerPetSoulFormation.PetName = param2;
         this.FOverlayerPetSoulFormation.Render(FUICore.MouseCoordinate);
         this.FOverlayerPetSoulFormation.Show();
      }
      
      protected function ProcessorSoulOnOut() : void
      {
         this.FOverlayerPetSoulFormation.Hide();
      }
      
      protected function SetTrunNumber(param1:int) : void
      {
         if(this.FEnterType == BattleType_Challenge)
         {
            this.FBattleRoundClass.SetNumber(param1,CONST_BATTLE.TURN_OF_CHALLENGE);
         }
         else
         {
            this.FBattleRoundClass.SetNumber(param1);
         }
      }
      
      protected function ConfirmationOnOk(param1:Object) : void
      {
         if(this.FUseSkipCardReq != null)
         {
            this.FUseSkipCardReq(this,CONST_BATTLE.BattleSkipCard,1);
         }
      }
      
      public function get Active() : Boolean
      {
         return this.Visible;
      }
      
      public function get Loading() : Boolean
      {
         return this.FProcessorBattleLoading.Visible;
      }
      
      public function get OnQuit() : Function
      {
         return this.FOnQuit;
      }
      
      public function set OnQuit(param1:Function) : void
      {
         this.FOnQuit = param1;
      }
      
      public function get TurnBackBattleScene() : Function
      {
         return this.FTurnBackBattleScene;
      }
      
      public function set TurnBackBattleScene(param1:Function) : void
      {
         this.FTurnBackBattleScene = param1;
      }
      
      public function get TurnBackKillHero() : Function
      {
         return this.FTurnBackKillHero;
      }
      
      public function set TurnBackKillHero(param1:Function) : void
      {
         this.FTurnBackKillHero = param1;
      }
      
      public function get TurnBackArena() : Function
      {
         return this.FTurnBackArena;
      }
      
      public function set TurnBackArena(param1:Function) : void
      {
         this.FTurnBackArena = param1;
      }
      
      public function get TurnBackTreasureMap() : Function
      {
         return this.FTurnBackTreasureMap;
      }
      
      public function set TurnBackTreasureMap(param1:Function) : void
      {
         this.FTurnBackTreasureMap = param1;
      }
      
      public function get TurnBackCityDefend() : Function
      {
         return this.FTurnBackCityDefend;
      }
      
      public function set TurnBackCityDefend(param1:Function) : void
      {
         this.FTurnBackCityDefend = param1;
      }
      
      public function get TurnBackFightPet() : Function
      {
         return this.FTurnBackFightPet;
      }
      
      public function set TurnBackFightPet(param1:Function) : void
      {
         this.FTurnBackFightPet = param1;
      }
      
      public function get TurnBackOrganizationWar() : Function
      {
         return this.FTurnBackOrganizationWar;
      }
      
      public function set TurnBackOrganizationWar(param1:Function) : void
      {
         this.FTurnBackOrganizationWar = param1;
      }
      
      public function get TurnBackTraitorAttack() : Function
      {
         return this.FTurnBackTraitorAttack;
      }
      
      public function set TurnBackTraitorAttack(param1:Function) : void
      {
         this.FTurnBackTraitorAttack = param1;
      }
      
      public function get TurnBackSlave() : Function
      {
         return this.FTurnBackSlave;
      }
      
      public function set TurnBackSlave(param1:Function) : void
      {
         this.FTurnBackSlave = param1;
      }
      
      public function get TurnBackSevenKing() : Function
      {
         return this.FTurnBackSevenKing;
      }
      
      public function set TurnBackSevenKing(param1:Function) : void
      {
         this.FTurnBackSevenKing = param1;
      }
      
      public function get TurnBackCrossServerWar() : Function
      {
         return this.FTurnBackCrossServerWar;
      }
      
      public function set TurnBackCrossServerWar(param1:Function) : void
      {
         this.FTurnBackCrossServerWar = param1;
      }
      
      public function get TurnBackMagic() : Function
      {
         return this.FTurnBackMagic;
      }
      
      public function set TurnBackMagic(param1:Function) : void
      {
         this.FTurnBackMagic = param1;
      }
      
      public function get TurnBackTower() : Function
      {
         return this.FTurnBackTower;
      }
      
      public function set TurnBackTower(param1:Function) : void
      {
         this.FTurnBackTower = param1;
      }
      
      public function get TurnBackPalace() : Function
      {
         return this.FTurnBackPalace;
      }
      
      public function set TurnBackPalace(param1:Function) : void
      {
         this.FTurnBackPalace = param1;
      }
      
      public function get TurnBackOrganizationBoss() : Function
      {
         return this.FTurnBackOrganizationBoss;
      }
      
      public function set TurnBackOrganizationBoss(param1:Function) : void
      {
         this.FTurnBackOrganizationBoss = param1;
      }
      
      public function get TurnBackFriend() : Function
      {
         return this.FTurnBackFriend;
      }
      
      public function set TurnBackFriend(param1:Function) : void
      {
         this.FTurnBackFriend = param1;
      }
      
      public function get TurnBackBloodSoul() : Function
      {
         return this.FTurnBackBloodSoul;
      }
      
      public function set TurnBackBloodSoul(param1:Function) : void
      {
         this.FTurnBackBloodSoul = param1;
      }
      
      public function get TurnBackSixFairy() : Function
      {
         return this.FTurnBackSixFairy;
      }
      
      public function set TurnBackSixFairy(param1:Function) : void
      {
         this.FTurnBackSixFairy = param1;
      }
      
      public function get TurnBackUndertown() : Function
      {
         return this.FTurnBackUndertown;
      }
      
      public function set TurnBackUndertown(param1:Function) : void
      {
         this.FTurnBackUndertown = param1;
      }
      
      public function get TurnBackMiGong() : Function
      {
         return this.FTurnBackMiGong;
      }
      
      public function set TurnBackMiGong(param1:Function) : void
      {
         this.FTurnBackMiGong = param1;
      }
      
      public function get TurnBackRebirthRealm() : Function
      {
         return this.FTurnBackRebirthRealm;
      }
      
      public function set TurnBackRebirthRealm(param1:Function) : void
      {
         this.FTurnBackRebirthRealm = param1;
      }
      
      public function get TurnBackTransmigrationTrial() : Function
      {
         return this.FTurnBackTransmigrationTrial;
      }
      
      public function set TurnBackTransmigrationTrial(param1:Function) : void
      {
         this.FTurnBackTransmigrationTrial = param1;
      }
      
      public function get TurnBackTaboo() : Function
      {
         return this.FTurnBackTaboo;
      }
      
      public function set TurnBackTaboo(param1:Function) : void
      {
         this.FTurnBackTaboo = param1;
      }
      
      public function get TurnBackTransmigrationAccessory() : Function
      {
         return this.FTurnBackTransmigrationAccessory;
      }
      
      public function set TurnBackTransmigrationAccessory(param1:Function) : void
      {
         this.FTurnBackTransmigrationAccessory = param1;
      }
      
      public function get ProcessorCheckPlot() : Function
      {
         return this.FProcessorCheckPlot;
      }
      
      public function set ProcessorCheckPlot(param1:Function) : void
      {
         this.FProcessorCheckPlot = param1;
      }
      
      public function get OnErrorText() : Function
      {
         return this.FOnErrorText;
      }
      
      public function set OnErrorText(param1:Function) : void
      {
         this.FOnErrorText = param1;
      }
      
      public function get IsReplay() : Boolean
      {
         return this.FIsReplay;
      }
      
      public function get Skip() : Boolean
      {
         return this.FIsCanSkip;
      }
      
      public function set Skip(param1:Boolean) : void
      {
         if(this.FIsCanSkip != param1)
         {
            this.FIsCanSkip = param1;
         }
         TGameUtil.setButtonMode(this.FButtonSkip,param1);
      }
      
      public function set UseSkipCardReq(param1:Function) : void
      {
         this.FUseSkipCardReq = param1;
      }
      
      override public function set Visible(param1:Boolean) : void
      {
         super.Visible = param1;
         if(this.CheckBattleSkip())
         {
            super.Visible = false;
            return;
         }
         if(this.FProcessorBattleLoading)
         {
            this.FProcessorBattleLoading.Visible = param1;
         }
      }
      
      public function ChatOptionsSetup(param1:TChatOptions) : void
      {
         param1.ChatStatus = CONST_CHAT.MODE_None;
      }
      
      public function SetStatusType(param1:int, param2:int, param3:Boolean = false, param4:Boolean = false, param5:Boolean = false) : void
      {
         this.FEnterType = param1;
         this.FEnterId = param2;
         this.FIsAutoBattle = param3;
         this.FIsAutoGoldResurgence = param4;
         this.FIsAutoSkipResurgence = param5;
         SLogicsCore.KaguyaData.RoleCurAtPosition = this.FEnterType;
         this.DispatchUIRes();
         if(this.CheckBattleSkip() && this.FknowRezult)
         {
            this.ResetBattle();
            this.OnEndBattle();
            this.HideReplay();
            return;
         }
         if(this.FBattleInfo == null || this.CheckBattleSkip() || this.FEnterType == ENTER_TYPE_TRIALS)
         {
            return;
         }
         this.CheckUseSkill();
         this.CheckResources();
      }
      
      public function set EnterType(param1:int) : void
      {
         this.FEnterType = param1;
      }
      
      public function SetMonsterCount(param1:uint) : void
      {
         this.FMonsterCount = param1;
      }
      
      public function SetBattlePacket(param1:Object, param2:TPacket) : void
      {
         var _loc3_:ByteArray = null;
         var _loc4_:ByteArray = null;
         this.PacketPerform_SC_SingleBattleResult(param2);
         _loc3_ = param2.Data;
         _loc4_ = new ByteArray();
         _loc3_.readBytes(_loc4_,0,_loc3_.length - _loc3_.position);
         this.FReportData = _loc4_;
         this.FBattleInfo = new TBattleInfo();
         this.UnstreamizerBattleRepot.Unstreamize(this.FReportData,this.FBattleInfo,null);
         this.FIsReplay = false;
         this.CheckUseSkill();
         this.CheckResources();
      }
      
      public function SetBattleStageBgById(param1:uint, param2:uint = 0) : void
      {
         this.OnAntiColorBlackWhiteBg(this,false);
         TGameUtil.ShowImageByID(TGameUtil.Type_BackgroundIcon,this.FBattleBg,CONST_MODULES.MODULE_Battle,param1,param2);
      }
      
      public function SetBattleStageBgByBitmapData(param1:Object, param2:BitmapData) : void
      {
         this.OnAntiColorBlackWhiteBg(this,false);
         if(param2 != null)
         {
            this.FBattleBg.bitmapData = param2;
         }
      }
      
      public function ResetBattle() : void
      {
         var _loc1_:TBattleStage = null;
         while(this.FBattleStages.length)
         {
            _loc1_ = this.FBattleStages.pop();
            this.FPoolBattleStages.SaveBattleStage(_loc1_);
         }
      }
      
      public function UnLoadResources() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Bitmap = null;
         TEffectControl.RemoveAllEffect();
         if(this.FModelVect != null)
         {
            this.FModelVect.length = 0;
         }
         if(this.FLargeVect != null)
         {
            this.FLargeVect.length = 0;
         }
         if(this.FSkillVect != null)
         {
            this.FSkillVect.length = 0;
         }
         if(this.FBackgroundVect != null)
         {
            if(this.FBattleBg.bitmapData != null)
            {
               this.FBattleBg.bitmapData = null;
            }
            if(this.FChgBattleBg.bitmapData != null)
            {
               this.FChgBattleBg.bitmapData = null;
            }
            this.FBackgroundVect.length = 0;
         }
         _loc1_ = 0;
         while(_loc1_ < this.FBgSprite.numChildren)
         {
            _loc2_ = this.FBgSprite.getChildAt(_loc1_) as Bitmap;
            if(_loc2_.bitmapData != null)
            {
               _loc2_.bitmapData = null;
            }
            _loc1_++;
         }
         this.FBgSpriteInit = false;
         this.dispose();
         this.FEnterType = 0;
         this.FBattleInfo = null;
      }
      
      public function SetTestId(param1:uint, param2:String, param3:String) : void
      {
         var _loc4_:TRoleBattleInfo = null;
         var _loc5_:TBaseHero = null;
         var _loc6_:TTurnInfo = null;
         var _loc7_:TActiveInfo = null;
         var _loc8_:TTargetInfo = null;
         var _loc9_:TResultInfo = null;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:TBaseHero = null;
         var _loc13_:TEnemy = null;
         var _loc14_:int = 0;
         var _loc15_:Object = null;
         var _loc16_:String = null;
         var _loc17_:uint = 0;
         var _loc18_:int = 0;
         if(param3 != "" && param3 != "{}")
         {
            this.FBattleInfo = new TBattleInfo();
            this.FBattleInfo.SetDataByStr(param3);
            this.CheckUseSkill();
            this.CheckResources();
            return;
         }
         if(param2 == "" || param2 == "{}")
         {
            _loc14_ = param1 > 12101000 ? TActive.TYPE_ENEMY : TActive.TYPE_HERO;
            if(_loc14_ == TActive.TYPE_HERO)
            {
               _loc12_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BaseHero,param1) as TBaseHero;
               if(_loc12_ == null)
               {
                  if(this.FOnErrorText != null)
                  {
                     this.FOnErrorText("Id 异常");
                  }
                  return;
               }
               _loc15_ = Json.decode(_loc12_.AttackEffect);
               if(_loc12_.IsReversion)
               {
                  _loc18_ = -100;
               }
            }
            if(_loc14_ == TActive.TYPE_ENEMY)
            {
               _loc13_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Enemy,param1) as TEnemy;
               if(_loc13_ == null)
               {
                  if(this.FOnErrorText != null)
                  {
                     this.FOnErrorText("Id 异常");
                  }
                  return;
               }
               _loc15_ = Json.decode(_loc13_.Effects);
            }
         }
         else
         {
            _loc15_ = Json.decode(param2);
         }
         _loc17_ = 0;
         for(_loc16_ in _loc15_)
         {
            if(_loc17_ == 0)
            {
               this.AttackIdFuck = int(_loc16_);
            }
            else if(_loc17_ == 1)
            {
               this.SkillIdFuck = int(_loc16_);
            }
            _loc17_++;
         }
         this.FBattleInfo = new TBattleInfo();
         this.FBattleInfo.TotleTurn = 1;
         this.FBattleInfo.PlayerInfo_1.Camp = 0;
         _loc4_ = new TRoleBattleInfo(0);
         _loc4_.CurAnger = 50;
         _loc4_.CurHealth = 5000;
         _loc4_.TotleHealth = 5000;
         _loc4_.Pos = 6;
         _loc4_.RoleId = param1;
         _loc4_.RoleLevel = 5;
         _loc4_.SkillId = this.SkillIdFuck;
         this.FBattleInfo.PlayerInfo_1.RoleBattleInfos.push(_loc4_);
         this.FBattleInfo.PlayerInfo_2.Camp = 1;
         _loc4_ = new TRoleBattleInfo(1);
         _loc4_.CurAnger = 50;
         _loc4_.CurHealth = 5000;
         _loc4_.TotleHealth = 5000;
         _loc4_.Pos = 6;
         _loc4_.RoleId = 11100102;
         _loc4_.RoleLevel = 5;
         _loc4_.SkillId = 13100115;
         this.FBattleInfo.PlayerInfo_2.RoleBattleInfos.push(_loc4_);
         _loc6_ = new TTurnInfo();
         _loc6_.ActiveCount = 2;
         _loc6_.CurTurn = 1;
         _loc7_ = new TActiveInfo(1);
         _loc7_.ActiveCamp = 0;
         _loc7_.ActivePos = 6;
         _loc7_.SkillEffectId = this.AttackIdFuck;
         _loc7_.TargetCount = 2;
         _loc8_ = new TTargetInfo(1);
         _loc8_.CMD = TTargetInfo.CMD_ATTACK;
         _loc8_.TargetCamp = 1;
         _loc8_.TargetPos = 6;
         _loc8_.TargetStatus = CONST_BATTLE.ActiveType_Hit + CONST_BATTLE.ActiveType_Crit;
         _loc8_.ResultInfo.CMD = _loc8_.CMD;
         _loc8_.ResultInfo.HurtHp = -100;
         _loc8_.ResultInfo.HurtAnger = 0;
         _loc8_.ResultInfo.BuffId = 0;
         _loc8_.ResultInfo.BuffTurn = 0;
         _loc7_.TargetInfos.push(_loc8_);
         _loc8_ = new TTargetInfo(2);
         _loc8_.CMD = TTargetInfo.CMD_ATTACK;
         _loc8_.TargetCamp = 0;
         _loc8_.TargetPos = 6;
         _loc8_.TargetStatus = CONST_BATTLE.ActiveType_Hit;
         _loc8_.ResultInfo.CMD = _loc8_.CMD;
         _loc8_.ResultInfo.HurtHp = _loc18_;
         _loc8_.ResultInfo.HurtAnger = -50;
         _loc8_.ResultInfo.BuffId = 0;
         _loc8_.ResultInfo.BuffTurn = 0;
         _loc7_.TargetInfos.push(_loc8_);
         _loc6_.ActiveInfos.push(_loc7_);
         _loc7_ = new TActiveInfo(2);
         _loc7_.ActiveCamp = 0;
         _loc7_.ActivePos = 6;
         _loc7_.SkillEffectId = this.SkillIdFuck;
         _loc7_.TargetCount = 1;
         _loc8_ = new TTargetInfo(1);
         _loc8_.CMD = TTargetInfo.CMD_ATTACK;
         _loc8_.TargetCamp = 1;
         _loc8_.TargetPos = 6;
         _loc8_.TargetStatus = CONST_BATTLE.ActiveType_Hit + CONST_BATTLE.ActiveType_Crit;
         _loc8_.ResultInfo.CMD = _loc8_.CMD;
         _loc8_.ResultInfo.HurtHp = -100;
         _loc8_.ResultInfo.HurtAnger = 0;
         _loc8_.ResultInfo.BuffId = 0;
         _loc8_.ResultInfo.BuffTurn = 0;
         _loc7_.TargetInfos.push(_loc8_);
         _loc6_.ActiveInfos.push(_loc7_);
         this.FBattleInfo.TurnInfos.push(_loc6_);
         if(param2 == "" || param2 == "{}")
         {
            this.CheckUseSkill();
            this.CheckResources();
         }
         else
         {
            this.TestResources(param2);
         }
      }
      
      public function SetBattleView(param1:ByteArray) : void
      {
         this.FBattleInfo = new TBattleInfo();
         this.UnstreamizerBattleRepot.Unstreamize(param1,this.FBattleInfo,null);
         this.FIsReplay = true;
         this.CheckUseSkill();
         this.CheckResources();
      }
      
      public function EndBattle() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         _loc1_ = 0;
         while(_loc1_ < this.FBattleStages.length)
         {
            this.FBattleStages[_loc1_].ButtonSkipOnClick();
            _loc1_++;
         }
      }
      
      public function SetGlobalBattleScore(param1:int = 0) : void
      {
         this.FGlobalBattleScore = param1;
         if(this.FResultWindow)
         {
            this.FResultWindow.Score = param1;
         }
         if(this.FWinWindow)
         {
            this.FWinWindow.Score = param1;
         }
      }
      
      public function SetGlobalboss(param1:TGlobalboss) : void
      {
         if(this.FWinWindow)
         {
            this.FWinWindow.Globalboss = param1;
         }
      }
   }
}

