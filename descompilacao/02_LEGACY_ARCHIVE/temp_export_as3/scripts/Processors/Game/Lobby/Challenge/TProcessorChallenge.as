package Processors.Game.Lobby.Challenge
{
   import Components.Pages.TUIPage;
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
   import Logics.Challenge.TChallenge;
   import Logics.Characters.TCharacter;
   import Logics.Characters.THero;
   import Logics.DatebaseVO.VO.TBaseHero;
   import Logics.DatebaseVO.VO.TChallengeMonster;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.DatebaseVO.VO.TEnemyArmy;
   import Logics.DatebaseVO.VO.TRoleModel;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.Exercise.ConsumeRank.TConsumeRankInfo;
   import Logics.Exercise.TBaseActivity;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.Inventories.TInventorySample;
   import Logics.SLogicsCore;
   import Logics.Skills.TSkill;
   import Logics.Streamization.Challenge.TUnstreamizerChallenge;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyPlate;
   import Processors.Game.Lobby.Tavern.TProcessorWindowRecruit;
   import Processors.Game.Lobby.TreasureMap.ConsumeFrameCopy;
   import Processors.Game.Windows.Information.TUIWindowBattleSkip;
   import Processors.Game.Windows.Information.TUIWindowConfirmation;
   import Processors.Game.Windows.Information.TUIWindowRecharge;
   import Rendering.Overlayers.Box.TOverlayerBoxNew;
   import Rendering.Overlayers.HelpTips.TOverlayerHelpTips;
   import Rendering.Overlayers.Hints.TOverlayerHint;
   import Rendering.Overlayers.Inventories.TOverSuperJade;
   import Rendering.Overlayers.Inventories.TOverlayerAccessory;
   import Rendering.Overlayers.Inventories.TOverlayerAppliance;
   import Rendering.Overlayers.Inventories.TOverlayerEquipment;
   import Rendering.Overlayers.Inventories.TOverlayerTreasure;
   import Rendering.Overlayers.TOverlayer;
   import Resources.Constants.CONST_BATTLE;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_CONFIGVALUE;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_INVENTORY;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Strings.STRING_BASEACTIVITY;
   import Resources.Strings.STRING_CHALLENGE;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_COPYCLASSROOM;
   import Resources.Strings.STRING_NINJAHOSTEL;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   import flash.utils.setTimeout;
   
   public class TProcessorChallenge extends TProcessorLobbyPlate
   {
      
      public static const CAPACITY_INVENTORIES:uint = CONST_COMMON.CAPACITY_INVENTORIES;
      
      public static const CATEGORY_Normal:uint = CONST_INVENTORY.CATEGORY_Normal;
      
      public static const CATEGORY_Equipment:uint = CONST_INVENTORY.CATEGORY_Equipment;
      
      public static const CATEGORY_Gem:uint = CONST_INVENTORY.CATEGORY_Gem;
      
      public static const CATEGORY_Treasure:uint = CONST_INVENTORY.CATEGORY_Treasure;
      
      public static const CATEGORY_Material:uint = CONST_INVENTORY.CATEGORY_Material;
      
      public static const CATEGORY_Accessories:uint = CONST_INVENTORY.CATEGORY_Accessories;
      
      public static const FRONT_COUNT:int = 5;
      
      public static const MIDDLE_COUNT:int = 6;
      
      public static const BACK_COUNT:int = 6;
      
      public static const RANK_COUNT:int = 10;
      
      public static const REQ_TYPE_BUY_FIGHT_COUNT:int = 1;
      
      public static const REQ_TYPE_FIGHT:int = 2;
      
      public static const REQ_TYPE_EXCHANGE_ITEM:int = 3;
      
      public static const REQ_TYPE_GER_DAILY_REWARD:int = 4;
      
      protected var FBuyBoxObj:Object;
      
      protected var FCurCost:int;
      
      protected var FIsClicked:Boolean;
      
      protected var FHtmlHint:THint;
      
      protected var FOverlayerHint:TOverlayerHint;
      
      protected var FOverlayerHelpTips:TOverlayerHelpTips;
      
      protected var FOverlayerEquipment:TOverlayerEquipment;
      
      protected var FOverlayerTreasure:TOverlayerTreasure;
      
      protected var FOverlayerAppliance:TOverlayerAppliance;
      
      protected var FOverlayerAccessory:TOverlayerAccessory;
      
      protected var FOverSuperJade:TOverSuperJade;
      
      protected var FOverlayerBoxNew:TOverlayerBoxNew;
      
      protected var FUIWindowBattleSkip:TUIWindowBattleSkip;
      
      protected var FProcessorWindowRecruit:TProcessorWindowRecruit;
      
      protected var FUIGoldConfirmation:TUIWindowConfirmation;
      
      protected var FUIGoldConfirmation2:TUIWindowConfirmation;
      
      protected var FUIGotoRecharge:TUIWindowRecharge;
      
      protected var FUIDailyReward:TUIDailyReward;
      
      protected var FUIRankReward:TUIRankReward;
      
      protected var FUIChallengeMall:TUIChallengeMall;
      
      protected var FUIFormation:TUIFormation;
      
      protected var FMC_Scene:MovieClip;
      
      protected var FChallenge:TChallenge;
      
      protected var FCharacter:TCharacter;
      
      protected var FUnstreamizerChallenge:TUnstreamizerChallenge;
      
      protected var FIsIn:Boolean;
      
      protected var FIsPlaying:Boolean;
      
      protected var FTotalFrame:int;
      
      protected var FCurFrame:int;
      
      protected var FFrameCount:int;
      
      protected var FFrontBmpIn:Vector.<Bitmap>;
      
      protected var FMiddleBmpIn:Vector.<Bitmap>;
      
      protected var FBackBmpIn:Vector.<Bitmap>;
      
      protected var FFrontBmpOut:Vector.<Bitmap>;
      
      protected var FMiddleBmpOut:Vector.<Bitmap>;
      
      protected var FBackBmpOut:Vector.<Bitmap>;
      
      protected var FTF_Time:TextField;
      
      protected var FIsFightTime:Boolean;
      
      protected var FUIPage:TUIPage;
      
      protected var FTotalPage:int;
      
      protected var FCurPage:int;
      
      protected var FRoleModel:TBins;
      
      protected var FRecallCost:Vector.<Object>;
      
      protected var FReturnTeamCost:int;
      
      protected var FSelectedHeroID:uint;
      
      protected var FUIPage1:TUIPage;
      
      protected var FUIPage2:TUIPage;
      
      protected var FUIPage3:TUIPage;
      
      protected var FTotalPage1:int;
      
      protected var FCurPage1:int;
      
      protected var FTotalPage2:int;
      
      protected var FCurPage2:int;
      
      protected var FTotalPage3:int;
      
      protected var FCurPage3:int;
      
      public var OnReturnMainScene:Function;
      
      public var SetStatusType:Function;
      
      public var OnInitBattle:Function;
      
      public var OnUpdateBadge:Function;
      
      public var OnShortcutHyperlinks:Function;
      
      public var OnSetChatOptions:Function;
      
      public function TProcessorChallenge(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FChallenge = SLogicsCore.Challenge;
         this.FCharacter = SLogicsCore.Character;
         this.FUnstreamizerChallenge = new TUnstreamizerChallenge();
         this.FBuyBoxObj = new Object();
         this.FHtmlHint = new THint();
         this.FUIGoldConfirmation = new TUIWindowConfirmation(this.Parent);
         this.FUIGoldConfirmation2 = new TUIWindowConfirmation(this.Parent);
         this.FProcessorWindowRecruit = new TProcessorWindowRecruit(this.Parent);
         this.FUIGotoRecharge = new TUIWindowRecharge(this.Parent);
         SetUIModuleID(CONST_MODULES.MODULE_Challenge);
         this.FIsIn = true;
         this.FFrontBmpIn = new Vector.<Bitmap>();
         this.FMiddleBmpIn = new Vector.<Bitmap>();
         this.FBackBmpIn = new Vector.<Bitmap>();
         this.FFrontBmpOut = new Vector.<Bitmap>();
         this.FMiddleBmpOut = new Vector.<Bitmap>();
         this.FBackBmpOut = new Vector.<Bitmap>();
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(1560281088);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         var _loc3_:Bitmap = null;
         var _loc4_:Bitmap = null;
         var _loc5_:TConfigValue = null;
         this.FMC_Scene = TUtilityReflection.CreateDisplayObjectInstance("MC_Challenge") as MovieClip;
         addChild(this.FMC_Scene);
         _loc2_ = TUtilityReflection.CreateDisplayObjectInstance("MC_ChallengeDailyReward") as MovieClip;
         this.FUIDailyReward = new TUIDailyReward(this);
         this.FUIDailyReward.Perform_UIDispatch(_loc2_);
         this.FUIDailyReward.OnCloseWindow = this.ProcessorOnCloseWindow;
         this.FUIDailyReward.OnGetBox = this.ProcessorOnGetBoxClick;
         this.FUIDailyReward.OnItemOver = this.UIComponentsHintOnOver;
         this.FUIDailyReward.OnItemOut = this.UIComponentsHintOnOut;
         this.FUIDailyReward.OnHelpOver = this.UIHelpTipsHintOnOver;
         this.FUIDailyReward.OnHelpOut = this.UIHelpTipsHintOnOut;
         this.FUIDailyReward.SetVisible(false);
         _loc2_ = TUtilityReflection.CreateDisplayObjectInstance("MC_ChallengeRank") as MovieClip;
         this.FUIRankReward = new TUIRankReward(this);
         this.FUIRankReward.Perform_UIDispatch(_loc2_);
         this.FUIRankReward.OnCloseWindow = this.ProcessorOnCloseWindow;
         this.FUIRankReward.OnGetBox = this.ProcessorOnGetBoxClick;
         this.FUIRankReward.OnItemOver = this.UIComponentsHintOnOver;
         this.FUIRankReward.OnItemOut = this.UIComponentsHintOnOut;
         this.FUIRankReward.OnHelpOver = this.UIHelpTipsHintOnOver;
         this.FUIRankReward.OnHelpOut = this.UIHelpTipsHintOnOut;
         this.FUIRankReward.SetVisible(false);
         _loc2_ = TUtilityReflection.CreateDisplayObjectInstance("MC_ChallengeMall") as MovieClip;
         this.FUIChallengeMall = new TUIChallengeMall(this);
         this.FUIChallengeMall.Perform_UIDispatch(_loc2_);
         this.FUIChallengeMall.OnCloseWindow = this.ProcessorOnCloseWindow;
         this.FUIChallengeMall.OnGetBox = this.ProcessorOnGetBoxClick;
         this.FUIChallengeMall.OnItemOver = this.UIComponentsHintOnOver;
         this.FUIChallengeMall.OnItemOut = this.UIComponentsHintOnOut;
         this.FUIChallengeMall.OnHelpOver = this.UIHelpTipsHintOnOver;
         this.FUIChallengeMall.OnHelpOut = this.UIHelpTipsHintOnOut;
         this.FUIChallengeMall.OnShowRecruit = this.ProcessorOnShowRecruit;
         this.FUIChallengeMall.OnShowFlowText = EffectGenerateText;
         this.FUIChallengeMall.SetVisible(false);
         _loc2_ = TUtilityReflection.CreateDisplayObjectInstance("MC_ChallengeFormation") as MovieClip;
         this.FUIFormation = new TUIFormation(this);
         this.FUIFormation.Perform_UIDispatch(_loc2_);
         this.FUIFormation.OnCloseWindow = this.ProcessorOnCloseWindow;
         this.FUIFormation.OnGetBox = this.ProcessorOnGetBoxClick;
         this.FUIFormation.OnHelpOver = this.UIHelpTipsHintOnOver;
         this.FUIFormation.OnHelpOut = this.UIHelpTipsHintOnOut;
         this.FUIFormation.OnShowFlowText = EffectGenerateText;
         this.FUIFormation.SkillOnClick = this.ProcessorSkillOnClick;
         this.FUIFormation.OnTakeBackHero = this.ProcessorOnTakeBackHero;
         this.FUIFormation.OneKeySwap = this.ProcessorOnOneKeySwap;
         this.FUIFormation.SetVisible(false);
         this.FTF_Time = this.FMC_Scene.TF_Time;
         _loc1_ = 0;
         while(_loc1_ < FRONT_COUNT)
         {
            _loc3_ = new Bitmap();
            this.FMC_Scene.MC_In.MC_Heros["MC_FrontHead" + _loc1_].addChild(_loc3_);
            this.FFrontBmpIn[_loc1_] = _loc3_;
            this.FMC_Scene.MC_In.MC_Heros["MC_FrontHead" + _loc1_].addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnFrontHeroOver);
            this.FMC_Scene.MC_In.MC_Heros["MC_FrontHead" + _loc1_].addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnHideHtmlText);
            _loc4_ = new Bitmap();
            this.FMC_Scene.MC_Out.MC_Heros["MC_FrontHead" + _loc1_].addChild(_loc4_);
            this.FFrontBmpOut[_loc1_] = _loc4_;
            this.FMC_Scene.MC_Out.MC_Heros["MC_FrontHead" + _loc1_].addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnFrontHeroOver);
            this.FMC_Scene.MC_Out.MC_Heros["MC_FrontHead" + _loc1_].addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnHideHtmlText);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < MIDDLE_COUNT)
         {
            _loc3_ = new Bitmap();
            this.FMC_Scene.MC_In.MC_Heros["MC_MiddleHead" + _loc1_].addChild(_loc3_);
            this.FMiddleBmpIn[_loc1_] = _loc3_;
            this.FMC_Scene.MC_In.MC_Heros["MC_MiddleHead" + _loc1_].addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnMiddleHeroOver);
            this.FMC_Scene.MC_In.MC_Heros["MC_MiddleHead" + _loc1_].addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnHideHtmlText);
            _loc4_ = new Bitmap();
            this.FMC_Scene.MC_Out.MC_Heros["MC_MiddleHead" + _loc1_].addChild(_loc4_);
            this.FMiddleBmpOut[_loc1_] = _loc4_;
            this.FMC_Scene.MC_Out.MC_Heros["MC_MiddleHead" + _loc1_].addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnMiddleHeroOver);
            this.FMC_Scene.MC_Out.MC_Heros["MC_MiddleHead" + _loc1_].addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnHideHtmlText);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < BACK_COUNT)
         {
            _loc3_ = new Bitmap();
            this.FMC_Scene.MC_In.MC_Heros["MC_BackHead" + _loc1_].addChild(_loc3_);
            this.FBackBmpIn[_loc1_] = _loc3_;
            this.FMC_Scene.MC_In.MC_Heros["MC_BackHead" + _loc1_].addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnBackHeroOver);
            this.FMC_Scene.MC_In.MC_Heros["MC_BackHead" + _loc1_].addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnHideHtmlText);
            _loc4_ = new Bitmap();
            this.FMC_Scene.MC_Out.MC_Heros["MC_BackHead" + _loc1_].addChild(_loc4_);
            this.FBackBmpOut[_loc1_] = _loc4_;
            this.FMC_Scene.MC_Out.MC_Heros["MC_BackHead" + _loc1_].addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnBackHeroOver);
            this.FMC_Scene.MC_Out.MC_Heros["MC_BackHead" + _loc1_].addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnHideHtmlText);
            _loc1_++;
         }
         this.FUIPage = new TUIPage(this);
         this.FUIPage.ButtonPrevious.Substrate = this.FMC_Scene.MC_ChangePage.MC_PageLeft;
         this.FUIPage.ButtonNext.Substrate = this.FMC_Scene.MC_ChangePage.MC_PageRight;
         this.FUIPage.LabelPage = this.FMC_Scene.MC_ChangePage.TF_Page;
         this.FUIPage.TotalQuantity = this.FTotalPage;
         this.FUIPage.PageSize = RANK_COUNT;
         this.FUIPage.PageIndex = 0;
         this.FCurPage = 0;
         this.FUIPage.OnChangePage = this.ProcessorPageOnChange;
         TGameUtil.setButtonMode(this.FMC_Scene.MC_In.BTN_Out,true);
         this.FMC_Scene.MC_In.BTN_Out.addEventListener(MouseEvent.CLICK,this.PlayMovie);
         TGameUtil.setButtonMode(this.FMC_Scene.MC_Out.BTN_In,true);
         this.FMC_Scene.MC_Out.BTN_In.addEventListener(MouseEvent.CLICK,this.PlayMovie);
         TGameUtil.setButtonMode(this.FMC_Scene.BTN_DailyReward,true);
         this.FMC_Scene.BTN_DailyReward.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowWindow);
         TGameUtil.setButtonMode(this.FMC_Scene.BTN_RankReward,true);
         this.FMC_Scene.BTN_RankReward.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowWindow);
         TGameUtil.setButtonMode(this.FMC_Scene.BTN_Shop,true);
         this.FMC_Scene.BTN_Shop.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowWindow);
         TGameUtil.setButtonMode(this.FMC_Scene.BTN_Add,true);
         this.FMC_Scene.BTN_Add.addEventListener(MouseEvent.CLICK,this.ProcessorOnAddUp);
         this.FMC_Scene.BTN_Add.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnAddOver);
         this.FMC_Scene.BTN_Add.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnHideHtmlText);
         TGameUtil.setButtonMode(this.FMC_Scene.BTN_Fight,true);
         this.FMC_Scene.BTN_Fight.addEventListener(MouseEvent.CLICK,this.ProcessorOnFightUp);
         TGameUtil.setButtonMode(this.FMC_Scene.BTN_TacticalDeployment,true);
         this.FMC_Scene.BTN_TacticalDeployment.addEventListener(MouseEvent.CLICK,this.ProcessorOnTacticalDeploymentUp);
         this.FMC_Scene.BTN_Close.addEventListener(MouseEvent.CLICK,this.ProcessorOnReturnMainScene);
         this.FMC_Scene.BTN_Help.addEventListener(MouseEvent.MOUSE_MOVE,this.ButtonHelpOnOver);
         this.FMC_Scene.BTN_Help.addEventListener(MouseEvent.ROLL_OUT,this.ButtonHelpOnOut);
         _loc5_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.NinjaHostel_RecallCost) as TConfigValue;
         this.FRecallCost = _loc5_.Value as Vector.<Object>;
         this.FUIPage1 = new TUIPage(this);
         this.FUIPage1.ButtonPrevious.Substrate = this.FMC_Scene.MC_Out.MC_Heros.MC_PageLeft1;
         this.FUIPage1.ButtonNext.Substrate = this.FMC_Scene.MC_Out.MC_Heros.MC_PageRight1;
         this.FUIPage1.TotalQuantity = this.FTotalPage1;
         this.FUIPage1.PageSize = FRONT_COUNT;
         this.FUIPage1.PageIndex = 0;
         this.FCurPage1 = 0;
         this.FUIPage1.OnChangePage = this.ProcessorPageOnChange1;
         this.FUIPage2 = new TUIPage(this);
         this.FUIPage2.ButtonPrevious.Substrate = this.FMC_Scene.MC_Out.MC_Heros.MC_PageLeft2;
         this.FUIPage2.ButtonNext.Substrate = this.FMC_Scene.MC_Out.MC_Heros.MC_PageRight2;
         this.FUIPage2.TotalQuantity = this.FTotalPage2;
         this.FUIPage2.PageSize = MIDDLE_COUNT;
         this.FUIPage2.PageIndex = 0;
         this.FCurPage2 = 0;
         this.FUIPage2.OnChangePage = this.ProcessorPageOnChange2;
         this.FUIPage3 = new TUIPage(this);
         this.FUIPage3.ButtonPrevious.Substrate = this.FMC_Scene.MC_Out.MC_Heros.MC_PageLeft3;
         this.FUIPage3.ButtonNext.Substrate = this.FMC_Scene.MC_Out.MC_Heros.MC_PageRight3;
         this.FUIPage3.TotalQuantity = this.FTotalPage3;
         this.FUIPage3.PageSize = BACK_COUNT;
         this.FUIPage3.PageIndex = 0;
         this.FCurPage3 = 0;
         this.FUIPage3.OnChangePage = this.ProcessorPageOnChange3;
         this.FUIWindowBattleSkip = new TUIWindowBattleSkip(this.Parent);
         this.FUIWindowBattleSkip.Perform_UIDispatch();
         this.FUIWindowBattleSkip.OnOK = this.OnConfirmationOk;
         this.FUIWindowBattleSkip.OnCancel = this.OnWindowCancel;
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
         this.FOverlayerHint = new TOverlayerHint(this.Parent);
         this.FOverlayerHint.Visible = false;
         this.FOverlayerHelpTips = new TOverlayerHelpTips(this.Parent);
         this.FOverlayerHelpTips.Visible = false;
         this.FOverlayerEquipment = new TOverlayerEquipment(this.Parent,CONST_MODULES.MODULE_Challenge);
         this.FOverlayerEquipment.Visible = false;
         this.FOverlayerTreasure = new TOverlayerTreasure(this.Parent,CONST_MODULES.MODULE_Challenge);
         this.FOverlayerTreasure.Visible = false;
         this.FOverlayerAppliance = new TOverlayerAppliance(this.Parent,CONST_MODULES.MODULE_Challenge);
         this.FOverlayerAppliance.Visible = false;
         this.FOverlayerAccessory = new TOverlayerAccessory(this.Parent,CONST_MODULES.MODULE_Challenge);
         this.FOverlayerAccessory.Visible = false;
         this.FOverSuperJade = new TOverSuperJade(this.Parent);
         this.FOverSuperJade.Visible = false;
         this.FOverlayerBoxNew = new TOverlayerBoxNew(this.Parent);
         this.FOverlayerBoxNew.Visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerHint);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerHelpTips);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerEquipment);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerTreasure);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerAppliance);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerAccessory);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverSuperJade);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerBoxNew);
         this.FUIGoldConfirmation.OnOK = this.GoldConfirmationOnOK;
         this.FUIGoldConfirmation.x = (CONST_COMMON.STAGE_Width - this.FUIGoldConfirmation.WindowWidth) / 2;
         this.FUIGoldConfirmation.y = (CONST_COMMON.STAGE_Height - this.FUIGoldConfirmation.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIGoldConfirmation);
         this.FUIGoldConfirmation.SetCheckBox(true);
         this.FUIGoldConfirmation2.OnOK = this.GoldConfirmationOnOK;
         this.FUIGoldConfirmation2.x = (CONST_COMMON.STAGE_Width - this.FUIGoldConfirmation2.WindowWidth) / 2;
         this.FUIGoldConfirmation2.y = (CONST_COMMON.STAGE_Height - this.FUIGoldConfirmation2.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIGoldConfirmation2);
         this.FUIGoldConfirmation2.SetCheckBox(true);
         this.FProcessorWindowRecruit.Visible = false;
         this.FProcessorWindowRecruit.x = (CONST_COMMON.STAGE_Width - 390) / 2;
         this.FProcessorWindowRecruit.y = (CONST_COMMON.STAGE_Height - 358) / 2;
         this.FProcessorWindowRecruit.HintOnOver = this.ProcessorTipOnOver;
         this.FProcessorWindowRecruit.HintOnOut = this.ProcessorTipOnOut;
         this.FUIGotoRecharge.x = (CONST_COMMON.STAGE_Width - this.FUIGotoRecharge.WindowWidth) / 2;
         this.FUIGotoRecharge.y = (CONST_COMMON.STAGE_Height - this.FUIGotoRecharge.WindowHeight) / 2;
         this.FRoleModel = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_RoleModel);
         TUtilityUIWindow.SetupWindowRecharge(this.FUIGotoRecharge);
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:int = 0;
         super.LogicsPerform();
         if(!FIsResourcesLoadCompleted || !Visible)
         {
            return;
         }
         if(Boolean(this.FMC_Scene) && this.FMC_Scene.visible)
         {
            this.UpdateBitmap();
            this.UpdateText();
            _loc2_ = this.FChallenge.EndTime - STimingCore.GetServerTick();
            this.FTF_Time.text = TGameUtil.FomatDayAndTime(_loc2_);
            if(_loc2_ <= 0 && this.FIsFightTime || _loc2_ > 0 && !this.FIsFightTime)
            {
               this.FIsFightTime = _loc2_ > 0 ? true : false;
               this.UpdateBoss();
            }
            if(this.FChallenge.BeginTime >= STimingCore.GetServerTick() || STimingCore.GetServerTick() > this.FChallenge.EndTime)
            {
               this.FMC_Scene.MC_TimeEnd.visible = true;
            }
            else
            {
               this.FMC_Scene.MC_TimeEnd.visible = false;
            }
            if(this.FUIDailyReward.visible)
            {
               this.FUIDailyReward.LogicsPerform();
            }
            if(this.FUIRankReward.visible)
            {
               this.FUIRankReward.LogicsPerform();
            }
            if(this.FUIChallengeMall.visible)
            {
               this.FUIChallengeMall.LogicsPerform();
            }
            if(this.FUIFormation.visible)
            {
               this.FUIFormation.LogicsPerform();
            }
            if(this.FProcessorWindowRecruit != null && this.FProcessorWindowRecruit.Visible == true)
            {
               this.FProcessorWindowRecruit.UpdataBitmap();
            }
            if(this.FIsPlaying)
            {
               this.FCurFrame = this.FIsIn ? int(this.FMC_Scene.MC_In.currentFrame) : int(this.FMC_Scene.MC_Out.currentFrame);
               if(this.FCurFrame == this.FTotalFrame)
               {
                  this.FIsPlaying = false;
                  this.FFrameCount = 0;
                  this.MovieEnd();
               }
               else
               {
                  ++this.FFrameCount;
                  if(this.FFrameCount > 100)
                  {
                     this.FIsPlaying = false;
                     this.FFrameCount = 0;
                     this.UpdateUI();
                  }
               }
            }
         }
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Challenge_LoadInfoRet,this.ProcessorOnLoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Challenge_CommonRet,this.ProcessorOnCommonRet);
         super.PacketRegisterRoutines();
      }
      
      protected function UpdateUI() : void
      {
         this.UpdateHeros();
         this.UpdateBoss();
         this.UpdateRank();
         this.UpdateText();
         if(this.FUIDailyReward.visible)
         {
            this.FUIDailyReward.UpdateWindow();
         }
         if(this.FUIRankReward.visible)
         {
            this.FUIRankReward.UpdateWindow();
         }
         if(this.FUIChallengeMall.visible)
         {
            this.FUIChallengeMall.UpdateWindow();
         }
         if(this.FUIFormation.visible)
         {
            this.FUIFormation.UpdateWindow();
         }
      }
      
      protected function UpdateHeros() : void
      {
         if(this.FIsIn)
         {
            this.FMC_Scene.MC_In.visible = true;
            this.FMC_Scene.MC_Out.visible = false;
         }
         else
         {
            this.FMC_Scene.MC_In.visible = false;
            this.FMC_Scene.MC_Out.visible = true;
         }
         this.FMC_Scene.MC_In.gotoAndStop(1);
         this.FMC_Scene.MC_Out.gotoAndStop(1);
      }
      
      protected function UpdateBitmap() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TRoleModel = null;
         if(!this.FChallenge || this.FChallenge.FrontList.length <= 0)
         {
            return;
         }
         this.FUIPage1.TotalQuantity = this.FChallenge.FrontList.length;
         this.FUIPage1.Update();
         _loc1_ = 0;
         while(_loc1_ < FRONT_COUNT)
         {
            _loc2_ = _loc1_ + this.FCurPage1 * FRONT_COUNT;
            if(_loc2_ < this.FChallenge.FrontList.length)
            {
               _loc3_ = this.FRoleModel.GetDatebaseByIdentifier(this.FChallenge.FrontList[_loc2_]) as TRoleModel;
               if(_loc3_)
               {
                  TGameUtil.ShowImageByID(TGameUtil.Type_HeadIcon,this.FFrontBmpIn[_loc1_],CONST_MODULES.MODULE_Challenge,_loc3_.RoleHead);
                  TGameUtil.ShowImageByID(TGameUtil.Type_HeadIcon,this.FFrontBmpOut[_loc1_],CONST_MODULES.MODULE_Challenge,_loc3_.RoleHead);
               }
            }
            else
            {
               this.FFrontBmpIn[_loc1_].bitmapData = null;
               this.FFrontBmpOut[_loc1_].bitmapData = null;
            }
            _loc1_++;
         }
         this.FUIPage2.TotalQuantity = this.FChallenge.MiddleList.length;
         this.FUIPage2.Update();
         _loc1_ = 0;
         while(_loc1_ < MIDDLE_COUNT)
         {
            _loc2_ = _loc1_ + this.FCurPage2 * MIDDLE_COUNT;
            if(_loc2_ < this.FChallenge.MiddleList.length)
            {
               _loc3_ = this.FRoleModel.GetDatebaseByIdentifier(this.FChallenge.MiddleList[_loc2_]) as TRoleModel;
               if(_loc3_)
               {
                  TGameUtil.ShowImageByID(TGameUtil.Type_HeadIcon,this.FMiddleBmpIn[_loc1_],CONST_MODULES.MODULE_Challenge,_loc3_.RoleHead);
                  TGameUtil.ShowImageByID(TGameUtil.Type_HeadIcon,this.FMiddleBmpOut[_loc1_],CONST_MODULES.MODULE_Challenge,_loc3_.RoleHead);
               }
            }
            else
            {
               this.FMiddleBmpIn[_loc1_].bitmapData = null;
               this.FMiddleBmpOut[_loc1_].bitmapData = null;
            }
            _loc1_++;
         }
         this.FUIPage3.TotalQuantity = this.FChallenge.BackList.length;
         this.FUIPage3.Update();
         _loc1_ = 0;
         while(_loc1_ < BACK_COUNT)
         {
            _loc2_ = _loc1_ + this.FCurPage3 * BACK_COUNT;
            if(_loc2_ < this.FChallenge.BackList.length)
            {
               _loc3_ = this.FRoleModel.GetDatebaseByIdentifier(this.FChallenge.BackList[_loc2_]) as TRoleModel;
               if(_loc3_)
               {
                  TGameUtil.ShowImageByID(TGameUtil.Type_HeadIcon,this.FBackBmpIn[_loc1_],CONST_MODULES.MODULE_Challenge,_loc3_.RoleHead);
                  TGameUtil.ShowImageByID(TGameUtil.Type_HeadIcon,this.FBackBmpOut[_loc1_],CONST_MODULES.MODULE_Challenge,_loc3_.RoleHead);
               }
            }
            else
            {
               this.FBackBmpIn[_loc1_].bitmapData = null;
               this.FBackBmpOut[_loc1_].bitmapData = null;
            }
            _loc1_++;
         }
      }
      
      protected function UpdateBoss() : void
      {
         var _loc1_:TChallengeMonster = null;
         var _loc2_:TEnemyArmy = null;
         var _loc3_:TRoleModel = null;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ChallengeMonster,this.FChallenge.CurBoss) as TChallengeMonster;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_EnemyArmy,_loc1_.EnemyId) as TEnemyArmy;
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_RoleModel,_loc2_.IsLeader) as TRoleModel;
         this.FMC_Scene.TF_Desc.text = _loc1_.Description;
         this.FMC_Scene.TF_Name.text = _loc1_.Name;
         this.FMC_Scene.TF_Count.text = this.FChallenge.CurCount + "/" + this.FChallenge.ChallengeMax;
         if(this.FChallenge.CurCount == 0 && this.FChallenge.LimitCount > 0)
         {
            TGameUtil.setButtonMode(this.FMC_Scene.BTN_Add,true);
         }
         else
         {
            TGameUtil.setButtonMode(this.FMC_Scene.BTN_Add,false);
         }
         if(this.FChallenge.BeginTime >= STimingCore.GetServerTick() || STimingCore.GetServerTick() > this.FChallenge.EndTime)
         {
            this.FMC_Scene.MC_TimeEnd.visible = true;
            TGameUtil.setButtonMode(this.FMC_Scene.BTN_Fight,false);
         }
         else
         {
            this.FMC_Scene.MC_TimeEnd.visible = false;
            if(this.FChallenge.CurCount > 0 && this.FIsFightTime)
            {
               TGameUtil.setButtonMode(this.FMC_Scene.BTN_Fight,true);
            }
            else
            {
               TGameUtil.setButtonMode(this.FMC_Scene.BTN_Fight,false);
            }
         }
      }
      
      protected function UpdateRank() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:TConsumeRankInfo = null;
         if(this.FChallenge.CurRank <= 0)
         {
            this.FMC_Scene.TF_Rank.text = STRING_BASEACTIVITY.FORMAT_NEVER_IN_RANK;
         }
         else
         {
            this.FMC_Scene.TF_Rank.text = this.FChallenge.CurRank.toString();
         }
         this.FMC_Scene.TF_Hurt.text = this.FChallenge.CurHurt.toString();
         this.FUIPage.TotalQuantity = this.FChallenge.RankList.length;
         this.FUIPage.Update();
         _loc1_ = 0;
         while(_loc1_ < RANK_COUNT)
         {
            _loc2_ = _loc1_ + this.FCurPage * RANK_COUNT;
            _loc3_ = this.FMC_Scene["MC_Info" + _loc1_];
            if(_loc2_ < this.FChallenge.RankList.length)
            {
               _loc4_ = this.FChallenge.RankList[_loc2_];
               _loc3_.TF_Rank.text = _loc4_.Rank.toString();
               _loc3_.TF_Name.text = _loc4_.UserName.toString();
               _loc3_.TF_Server.text = _loc4_.ServerID.toString();
               _loc3_.TF_Level.text = SLogicsCore.Character.MainHero.GetLevelStrByLevel(_loc4_.Level);
               _loc3_.TF_Power.text = _loc4_.FightPower.ToString();
               _loc3_.TF_Hurt.text = _loc4_.Desc;
            }
            else
            {
               _loc3_.TF_Rank.text = "";
               _loc3_.TF_Name.text = "";
               _loc3_.TF_Server.text = "";
               _loc3_.TF_Level.text = "";
               _loc3_.TF_Power.text = "";
               _loc3_.TF_Hurt.text = "";
            }
            _loc1_++;
         }
      }
      
      protected function UpdateText() : void
      {
         this.FMC_Scene.TF_Coin.text = this.FCharacter.CreditSilverCoin.ToString();
         this.FMC_Scene.TF_Gold.text = this.FCharacter.CreditGold.toString();
         this.FMC_Scene.TF_Vouchers.text = this.FCharacter.CreditGiftCertificate.toString();
         this.FMC_Scene.TF_Point.text = this.FChallenge.Point.toString();
      }
      
      protected function PerformPacket_CS_LoadInfoReq() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:int = 0;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Challenge_LoadInfoReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PerformPacket_CS_AllReq(param1:int, param2:Vector.<int> = null, param3:String = "") : void
      {
         var _loc4_:TPacket = null;
         var _loc5_:ByteArray = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         _loc4_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Challenge_CommonReq);
         _loc4_.Data.writeUnsignedInt(param1);
         if(param2 == null)
         {
            _loc4_.Data.writeShort(0);
         }
         else
         {
            _loc7_ = int(param2.length);
            _loc4_.Data.writeShort(_loc7_);
            _loc6_ = 0;
            while(_loc6_ < _loc7_)
            {
               _loc4_.Data.writeUnsignedInt(param2[_loc6_]);
               _loc6_++;
            }
         }
         TUtilityString.FlushUTF(_loc4_.Data,param3);
         SNetworkCore.Transceiver.PacketTransmit(_loc4_);
      }
      
      protected function ProcessorPageOnChange(param1:Object, param2:int) : void
      {
         this.FCurPage = param2;
         this.UpdateRank();
      }
      
      protected function ProcessorPageOnChange1(param1:Object, param2:int) : void
      {
         this.FCurPage1 = param2;
         this.UpdateBitmap();
      }
      
      protected function ProcessorPageOnChange2(param1:Object, param2:int) : void
      {
         this.FCurPage2 = param2;
         this.UpdateBitmap();
      }
      
      protected function ProcessorPageOnChange3(param1:Object, param2:int) : void
      {
         this.FCurPage3 = param2;
         this.UpdateBitmap();
      }
      
      protected function ProcessorOnReturnMainScene(param1:MouseEvent) : void
      {
         if(this.OnReturnMainScene != null)
         {
            this.OnReturnMainScene(this);
         }
      }
      
      protected function ProcessorOnAddUp(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         this.ProcessorOnBuyBoxClick(REQ_TYPE_BUY_FIGHT_COUNT,this.FChallenge.CurPrice);
      }
      
      protected function ProcessorOnFightUp(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(!this.FUIWindowBattleSkip.IsSelected)
         {
            this.FUIWindowBattleSkip.Visible = true;
         }
         else
         {
            this.ProcessorOnGetBoxClick(REQ_TYPE_FIGHT);
         }
      }
      
      protected function OnConfirmationOk(param1:Object) : void
      {
         this.FUIWindowBattleSkip.SetBattleSkipStatus(true,CONST_BATTLE.BattleType_Challenge);
         this.ProcessorOnGetBoxClick(REQ_TYPE_FIGHT);
      }
      
      protected function OnWindowCancel(param1:Object) : void
      {
         this.FUIWindowBattleSkip.SetBattleSkipStatus(false,CONST_BATTLE.BattleType_Challenge);
         this.ProcessorOnGetBoxClick(REQ_TYPE_FIGHT);
      }
      
      protected function ProcessorOnTacticalDeploymentUp(param1:MouseEvent) : void
      {
         this.FUIFormation.SetVisible(true);
         this.FUIFormation.UpdateWindow();
      }
      
      protected function ButtonHelpOnOver(param1:MouseEvent) : void
      {
         var _loc2_:TSystemLanguage = null;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.HELPTIPS_70170101) as TSystemLanguage;
         this.FHtmlHint.Content = _loc2_.Desc;
         this.UIHelpTipsHintOnOver(this,this.FHtmlHint);
      }
      
      protected function ButtonHelpOnOut(param1:MouseEvent) : void
      {
         this.UIHelpTipsHintOnOut(this);
      }
      
      protected function ProcessorOnCloseWindow(param1:Object) : void
      {
         this.FUIChallengeMall.SetVisible(false);
         this.FUIDailyReward.SetVisible(false);
         this.FUIRankReward.SetVisible(false);
         this.FUIFormation.SetVisible(false);
      }
      
      protected function ProcessorOnShowWindow(param1:MouseEvent) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:int = 0;
         switch(param1.currentTarget.name)
         {
            case "BTN_DailyReward":
               this.FUIDailyReward.SetVisible(true);
               this.FUIDailyReward.UpdateWindow();
               break;
            case "BTN_RankReward":
               this.FUIRankReward.SetVisible(true);
               this.FUIRankReward.UpdateWindow();
               break;
            case "BTN_Shop":
               this.FUIChallengeMall.SetVisible(true);
               this.FUIChallengeMall.UpdateWindow();
         }
      }
      
      protected function ProcessorOnShowRecruit(param1:uint) : void
      {
         this.FProcessorWindowRecruit.SetHeroData(param1);
      }
      
      protected function ProcessorTipOnOver(param1:Object, param2:THint) : void
      {
         this.FOverlayerHint.Context = param2;
         this.FOverlayerHint.Render(FUICore.MouseCoordinate);
         this.FOverlayerHint.Show();
      }
      
      protected function ProcessorTipOnOut(param1:Object) : void
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
      
      protected function UIComponentsHintOnOver(param1:Object, param2:Object) : void
      {
         var _loc3_:TInventory = null;
         var _loc4_:TOverlayer = null;
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
               if(SLogicsCore.LostShenQiLogicData.GetBooJade(_loc3_.IDTemplate))
               {
                  _loc4_ = this.FOverSuperJade;
               }
               else
               {
                  _loc4_ = this.FOverlayerAppliance;
               }
         }
         if(_loc4_ != null)
         {
            _loc4_.Context = _loc3_;
            _loc4_.Render(FUICore.MouseCoordinate);
            _loc4_.Show();
         }
      }
      
      protected function UIComponentsHintOnOut(param1:Object, param2:Object) : void
      {
         var _loc3_:TInventory = null;
         var _loc4_:TOverlayer = null;
         if(param2 == null)
         {
            if(this.FOverlayerEquipment.visible)
            {
               this.FOverlayerEquipment.Hide();
            }
            if(this.FOverlayerTreasure.visible)
            {
               this.FOverlayerTreasure.Hide();
            }
            if(this.FOverlayerAccessory.visible)
            {
               this.FOverlayerAccessory.Hide();
            }
            if(this.FOverlayerAppliance.visible)
            {
               this.FOverlayerAppliance.Hide();
            }
            return;
         }
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
         if(_loc4_ != null)
         {
            _loc4_.Hide();
         }
      }
      
      protected function ProcessorOnBuyBoxClick(param1:int, param2:int, param3:int = 0, param4:int = 0, param5:String = "", param6:int = 0, param7:int = 0, param8:int = 0) : void
      {
         this.FBuyBoxObj.ActivityType = param1;
         this.FBuyBoxObj.BoxIndex = param3;
         this.FBuyBoxObj.Cost = param2;
         this.FBuyBoxObj.CostType = param4;
         this.FBuyBoxObj.BoxIndex1 = param6;
         this.FBuyBoxObj.ConfirmType = param7;
         if(param4 != TBaseActivity.SWEET_TYPE_GOLD && param4 != TBaseActivity.SWEET_TYPE_GOLD_GIFT)
         {
            this.ProcessorOnGetBoxClick(this.FBuyBoxObj.ActivityType,this.FBuyBoxObj.BoxIndex,this.FBuyBoxObj.BoxIndex1);
            return;
         }
         if(!this.FUIGoldConfirmation.IsSelected || param8 != 0)
         {
            this.FCurCost = param2;
            if(param5 != "")
            {
               this.FUIGoldConfirmation.Text = param5;
            }
            else if(param4 == TBaseActivity.SWEET_TYPE_GOLD)
            {
               this.FUIGoldConfirmation.Text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_ConfirmGold,this.FCurCost);
            }
            else
            {
               this.FUIGoldConfirmation.Text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_ConfirmGoldOrGift,this.FCurCost);
            }
            this.FUIGoldConfirmation.SetCheckBox(true);
            this.FUIGoldConfirmation.Visible = true;
         }
         else
         {
            this.GoldConfirmationOnOK();
         }
      }
      
      protected function GoldConfirmationOnOK(param1:Object = null) : void
      {
         if(this.FBuyBoxObj.CostType == TBaseActivity.SWEET_TYPE_GOLD)
         {
            if(this.FCharacter.CreditGold >= this.FBuyBoxObj.Cost)
            {
               this.ProcessorOnGetBoxClick(this.FBuyBoxObj.ActivityType,this.FBuyBoxObj.BoxIndex,this.FBuyBoxObj.BoxIndex1);
            }
            else
            {
               this.FUIGotoRecharge.Visible = true;
            }
         }
         else if(this.FBuyBoxObj.CostType == TBaseActivity.SWEET_TYPE_GOLD_GIFT)
         {
            if(this.FCharacter.CreditGold + this.FCharacter.CreditGiftCertificate >= this.FBuyBoxObj.Cost)
            {
               this.ProcessorOnGetBoxClick(this.FBuyBoxObj.ActivityType,this.FBuyBoxObj.BoxIndex,this.FBuyBoxObj.BoxIndex1);
            }
            else
            {
               this.FUIGotoRecharge.Visible = true;
            }
         }
      }
      
      protected function ProcessorOnGetBoxClick(param1:int, param2:int = 0, param3:int = 0, param4:String = "") : void
      {
         var _loc5_:TPacket = null;
         var _loc6_:int = 0;
         var _loc7_:Vector.<int> = null;
         if(this.FIsClicked)
         {
            return;
         }
         this.FIsClicked = true;
         _loc7_ = new Vector.<int>();
         if(param2 != 0)
         {
            _loc7_.push(param2);
         }
         if(param3 != 0)
         {
            _loc7_.push(param3);
         }
         this.PerformPacket_CS_AllReq(param1,_loc7_,param4);
      }
      
      protected function ProcessorOnShowHtmlText(param1:String) : void
      {
         param1 = param1;
         param1 = param1.split("&zt;").join("<");
         param1 = param1.split("&yt;").join(">");
         param1 = param1.split("%n").join("\n");
         if(param1 == "")
         {
            return;
         }
         this.FHtmlHint.Content = null;
         this.FHtmlHint.Content = param1;
         this.UIHelpTipsHintOnOver(this,this.FHtmlHint);
      }
      
      protected function ProcessorOnHideHtmlText(param1:MouseEvent = null) : void
      {
         this.UIHelpTipsHintOnOut(this);
      }
      
      protected function ProcessorOnNewBoxOver(param1:TInventories, param2:String = "") : void
      {
         if(param1 != null)
         {
            if(param2 == "")
            {
               param2 = STRING_BASEACTIVITY.FORMAT_BOX_CONTEXT;
            }
            this.FOverlayerBoxNew.Desc = param2;
            this.FOverlayerBoxNew.Context = param1;
            this.FOverlayerBoxNew.Render(FUICore.MouseCoordinate);
            this.FOverlayerBoxNew.Show();
         }
      }
      
      protected function ProcessorOnNewBoxOut(param1:MouseEvent = null) : void
      {
         this.FOverlayerBoxNew.Hide();
      }
      
      protected function ProcessorOnFrontHeroOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:TBaseHero = null;
         _loc2_ = int(String(param1.currentTarget.name).slice(12));
         _loc3_ = _loc2_ + this.FCurPage1 * FRONT_COUNT;
         if(_loc2_ < this.FChallenge.FrontList.length)
         {
            _loc5_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BaseHero,this.FChallenge.FrontList[_loc3_]) as TBaseHero;
            if(_loc5_)
            {
               _loc4_ = _loc5_.Name + "<br>" + _loc5_.Desc;
               this.ProcessorOnShowHtmlText(_loc4_);
            }
         }
      }
      
      protected function ProcessorOnMiddleHeroOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc5_:TBaseHero = null;
         _loc2_ = int(String(param1.currentTarget.name).slice(13));
         _loc4_ = _loc2_ + this.FCurPage2 * MIDDLE_COUNT;
         if(_loc2_ < this.FChallenge.MiddleList.length)
         {
            _loc5_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BaseHero,this.FChallenge.MiddleList[_loc4_]) as TBaseHero;
            if(_loc5_)
            {
               _loc3_ = _loc5_.Name + "<br>" + _loc5_.Desc;
               this.ProcessorOnShowHtmlText(_loc3_);
            }
         }
      }
      
      protected function ProcessorOnBackHeroOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:TBaseHero = null;
         _loc2_ = int(String(param1.currentTarget.name).slice(11));
         _loc3_ = _loc2_ + this.FCurPage3 * BACK_COUNT;
         if(_loc2_ < this.FChallenge.BackList.length)
         {
            _loc5_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BaseHero,this.FChallenge.BackList[_loc3_]) as TBaseHero;
            if(_loc5_)
            {
               _loc4_ = _loc5_.Name + "<br>" + _loc5_.Desc;
               this.ProcessorOnShowHtmlText(_loc4_);
            }
         }
      }
      
      protected function ProcessorOnAddOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:String = null;
         _loc3_ = TUtilityString.Format(STRING_COPYCLASSROOM.FORMAT_BuyCountWithoutMoreVip,this.FChallenge.LimitCount);
         _loc4_ = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_BAR_TEXT2,this.FChallenge.CurPrice);
         this.ProcessorOnShowHtmlText(_loc3_ + " ," + _loc4_);
      }
      
      protected function ProcessorSkillOnClick(param1:Object, param2:Object) : void
      {
         var _loc3_:TPacket = null;
         var _loc4_:ByteArray = null;
         var _loc5_:TSkill = null;
         _loc5_ = param2 as TSkill;
         _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TacticalDeployment_ChangeSkillReq);
         _loc4_ = _loc3_.Data;
         _loc4_.writeUnsignedInt(_loc5_.Identifier);
         SNetworkCore.Transceiver.PacketTransmit(_loc3_);
      }
      
      protected function ProcessorOnTakeBackHero(param1:THero) : void
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:TBaseHero = null;
         this.FSelectedHeroID = param1.Identifier;
         _loc5_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BaseHero,this.FSelectedHeroID) as TBaseHero;
         _loc3_ = this.FRecallCost.length;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            if(this.FRecallCost[_loc2_][0] == _loc5_.Quality)
            {
               this.FReturnTeamCost = this.FRecallCost[_loc2_][1];
               break;
            }
            _loc2_++;
         }
         if(_loc5_.Quality >= 5 && SLogicsCore.NinjaHostelData.CommonItem > 0)
         {
            this.FUIGoldConfirmation2.Text = TUtilityString.Format(STRING_NINJAHOSTEL.STRING_UseCommonItem,_loc5_.Name);
         }
         else
         {
            this.FUIGoldConfirmation2.Text = TUtilityString.Format(STRING_NINJAHOSTEL.STRING_SureReturnTeam,this.FReturnTeamCost,_loc5_.Name);
         }
         this.FUIGoldConfirmation2.SetCheckBox(true);
         this.FUIGoldConfirmation2.Visible = true;
         this.FUIGoldConfirmation2.OnOK = this.OnSureHeroReturnTeam;
      }
      
      protected function OnSureHeroReturnTeam(param1:Object) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         if(SLogicsCore.Character.CreditGold + SLogicsCore.Character.CreditGiftCertificate < this.FReturnTeamCost)
         {
            EffectGenerateText(STRING_COMMON.NOTENOUGH_Gold);
            return;
         }
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_NinjaHostel_HeroStatus_Req);
         _loc3_ = _loc2_.Data;
         _loc3_.writeUnsignedInt(this.FSelectedHeroID);
         _loc3_.writeUnsignedInt(2);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function ProcessorOnOneKeySwap(param1:Object, param2:Object, param3:Object) : void
      {
         var _loc4_:TPacket = null;
         var _loc5_:ByteArray = null;
         if(param2 == null || param3 == null)
         {
            return;
         }
         _loc4_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Heros_OneKeySwap);
         _loc5_ = _loc4_.Data;
         _loc5_.writeUnsignedInt((param2 as THero).Identifier);
         _loc5_.writeUnsignedInt((param3 as THero).Identifier);
         SNetworkCore.Transceiver.PacketTransmit(_loc4_);
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount(param1);
         if(!FIsResourcesLoadCompleted)
         {
            this.FUIGoldConfirmation.Load();
            this.FProcessorWindowRecruit.Load();
            return;
         }
         this.PerformPacket_CS_LoadInfoReq();
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
      
      protected function ProcessorOnLoadInfoRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            this.OnReturnMainScene(this);
            return;
         }
         this.FUnstreamizerChallenge.Unstreamize(_loc2_,this.FChallenge,null);
         if(FIsResourcesLoadCompleted && this.visible)
         {
            this.UpdateUI();
         }
      }
      
      protected function ProcessorOnCommonRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:String = null;
         var _loc11_:TInventories = null;
         var _loc12_:TInventorySample = null;
         var _loc13_:TBaseHero = null;
         var _loc14_:int = 0;
         var _loc15_:int = 0;
         var _loc16_:int = 0;
         this.FIsClicked = false;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc4_ = int(_loc2_.readUnsignedInt());
         _loc2_.readShort();
         switch(_loc4_)
         {
            case REQ_TYPE_FIGHT:
               _loc10_ = "";
               _loc16_ = int(_loc2_.readUnsignedInt());
               if(_loc16_ > 0)
               {
                  _loc14_ = 0;
                  while(_loc14_ < _loc16_)
                  {
                     _loc5_ = int(_loc2_.readUnsignedInt());
                     _loc13_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BaseHero,_loc5_) as TBaseHero;
                     _loc10_ += _loc13_.Name + ",";
                     _loc14_++;
                  }
                  _loc10_ = TUtilityString.Format(new ConsumeFrameCopy(STRING_CHALLENGE.STRING_005).DescribeString,_loc10_);
                  EffectGenerateText(_loc10_);
               }
               else
               {
                  this.PacketPerform_SC_FightRet(_loc2_);
               }
               break;
            case REQ_TYPE_BUY_FIGHT_COUNT:
               this.FChallenge.ChallengeMax = _loc2_.readUnsignedInt();
               this.FChallenge.CurCount = _loc2_.readUnsignedInt();
               this.FChallenge.LimitCount = _loc2_.readUnsignedInt();
               this.FChallenge.CurPrice = _loc2_.readUnsignedInt();
               this.UpdateUI();
               break;
            case REQ_TYPE_GER_DAILY_REWARD:
               _loc14_ = int(_loc2_.readUnsignedInt());
               _loc16_ = int(_loc2_.readUnsignedInt());
               _loc10_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
               _loc15_ = 0;
               while(_loc15_ < _loc16_)
               {
                  _loc5_ = int(_loc2_.readUnsignedInt());
                  _loc6_ = int(_loc2_.readUnsignedInt());
                  _loc7_ = int(_loc2_.readUnsignedInt());
                  _loc10_ += STRING_COMMON.GetItemNameByType(_loc5_,_loc6_) + "*" + _loc7_ + "\n";
                  _loc15_++;
               }
               this.FChallenge.Point = _loc2_.readUnsignedInt();
               this.FChallenge.ChangeRewardById(_loc14_);
               EffectGenerateText(_loc10_);
               this.UpdateUI();
               break;
            case REQ_TYPE_EXCHANGE_ITEM:
               _loc5_ = int(_loc2_.readUnsignedInt());
               this.FChallenge.Point = _loc2_.readUnsignedInt();
               EffectGenerateText(STRING_BASEACTIVITY.FORMAT_EXCHANGE);
               this.UpdateUI();
         }
      }
      
      protected function PacketPerform_SC_FightRet(param1:ByteArray) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(this.SetStatusType != null)
         {
            this.SetStatusType(this,CONST_BATTLE.BattleType_Challenge,0);
         }
         if(this.OnInitBattle != null)
         {
            this.OnInitBattle(this);
         }
         this.PerformPacket_CS_LoadInfoReq();
      }
      
      public function PlayMovie(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = null;
         this.FIsPlaying = true;
         if(this.FIsIn)
         {
            _loc2_ = this.FMC_Scene.MC_In;
            this.FTotalFrame = _loc2_.totalFrames;
            _loc2_.gotoAndPlay(1);
         }
         else
         {
            _loc2_ = this.FMC_Scene.MC_Out;
            this.FTotalFrame = _loc2_.totalFrames;
            _loc2_.gotoAndPlay(1);
         }
      }
      
      public function MovieEnd() : void
      {
         var _loc1_:int = 0;
         var _loc2_:String = null;
         this.FIsPlaying = false;
         this.FIsIn = !this.FIsIn;
         this.UpdateUI();
      }
      
      public function UserUpdateFightingPower() : void
      {
         if(this.FUIFormation)
         {
            this.FUIFormation.UserUpdateFightingPower();
         }
      }
      
      public function UpdateMainHeroSkill() : void
      {
         if(this.FUIFormation)
         {
            this.FUIFormation.ResetSkill();
         }
      }
      
      public function UpdateChallengeFormation() : void
      {
         if(Boolean(this.FUIFormation) && this.FUIFormation.visible)
         {
            this.FUIFormation.UpdateWindow();
         }
      }
   }
}

