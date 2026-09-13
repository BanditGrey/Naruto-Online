package Processors.Game.Lobby.NinJaPractice
{
   import Components.Slots.TUISlot;
   import Components.Standard.TUITab;
   import Foundation.Common.TBounds;
   import Foundation.Common.TCoordinate;
   import Foundation.Common.THint;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Queries.Coordinate.TQueryCoordinate;
   import Foundation.Queries.TQueryString;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.Repositories.TResourceRepositoryTexture;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Resources.Textures.TTexture;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.Characters.THero;
   import Logics.Characters.THeros;
   import Logics.DatebaseVO.VO.TBaseHero;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.DatebaseVO.VO.THeroTalent;
   import Logics.DatebaseVO.VO.TNinJaPractice;
   import Logics.DatebaseVO.VO.TPropSwitch;
   import Logics.DatebaseVO.VO.TRoleModel;
   import Logics.DatebaseVO.VO.TSkillConfig;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.Inventories.TAppliance;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Skills.TSkill;
   import Logics.Streamization.Characters.TUnstreamizerCharacter;
   import Logics.Streamization.Characters.TUnstreamizerNinjaReincarnation;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Processors.Game.Common.Effects.Texts.TEffectCoordinateParameters;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import Processors.Game.Lobby.Components.TUIHero;
   import Processors.Game.Lobby.TongLing.ToolS.Tools_Help;
   import Processors.Game.Lobby.TreasureMap.ConsumeFrame;
   import Processors.Game.Windows.Editors.TUIWindowEditor;
   import Processors.Game.Windows.Information.TUIWindowConfirmation;
   import Rendering.Overlayers.HelpTips.TOverlayerHelpTips;
   import Rendering.Overlayers.Inventories.TOverlayerAppliance;
   import Rendering.Overlayers.NinJaPractice.TOverJinJaPractice;
   import Rendering.Overlayers.Pet.TOverlayerPet;
   import Rendering.Overlayers.Reincarnation.TReincarnationgHintTip;
   import Rendering.Overlayers.TOverlayer;
   import Resources.Constants.CONST_CHARACTER;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_CONFIGVALUE;
   import Resources.Constants.CONST_COUNTER;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_INVENTORY;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_NINJAPRACTICE;
   import Resources.Constants.CONST_SHORTCUTS;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_HEROS;
   import Resources.Strings.STRING_INHERITPRACTICE;
   import Resources.Strings.STRING_NINJIAREINCARNATION;
   import Resources.Strings.STRING_TONGLING;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   
   public class TProcessorNinJaPractice extends TProcessorLobbyWindows
   {
      
      public static const HERO_COUNT:Number = 10;
      
      public static const SLOT_COUNT:Number = 10;
      
      public static const SLOT_COUNT_RIGHT:Number = 6;
      
      public static const CATEGORY_Equipment:uint = CONST_INVENTORY.CATEGORY_Equipment;
      
      public static const CATEGORY_Treasure:uint = CONST_INVENTORY.CATEGORY_Treasure;
      
      public static const KEY_FirstRecharge:uint = CONST_COUNTER.KEY_FirstRecharge;
      
      public static const CATEGORY_Accessories:uint = CONST_INVENTORY.CATEGORY_Accessories;
      
      protected static const QUALITYCOLOR_INDEX:Vector.<uint> = CONST_COMMON.QUALITYCOLOR_INDEX;
      
      protected var FProcessorScene:Sprite;
      
      protected var FPocessorInherit:TProcessorNinJaInherit;
      
      protected var FUnstreamizerNinjaReincarnation:TUnstreamizerNinjaReincarnation;
      
      protected var FOverTip:TOverJinJaPractice;
      
      protected var FHelpTips:THint;
      
      protected var FTOverlayerHint:TReincarnationgHintTip;
      
      protected var FMC_ROOT:MovieClip;
      
      protected var FMC_TWO:MovieClip;
      
      protected var FMC_HELP:SimpleButton;
      
      protected var FMC_Reincarnation:MovieClip;
      
      protected var FMC_Awake:MovieClip;
      
      protected var FMC_AwakeSkill:MovieClip;
      
      protected var FMC_Tab01:MovieClip;
      
      protected var FMC_Tab02:MovieClip;
      
      protected var FMC_Tab03:MovieClip;
      
      protected var FMC_Tab04:MovieClip;
      
      protected var FMC_CLEAR:MovieClip;
      
      protected var FMC_use:MovieClip;
      
      protected var FMC_INHERIT:MovieClip;
      
      protected var FMC_PIC:MovieClip;
      
      protected var heros:THeros;
      
      protected var hero:THero;
      
      protected var heronumer:Number;
      
      protected var HERO_COUNT_Vec:Vector.<MovieClip>;
      
      protected var HERO_Vec:Vector.<THero>;
      
      protected var cur_hero_index:int;
      
      protected var cur_page_index:int = 1;
      
      protected var all_page_index:int = 1;
      
      protected var cur_god_index:int = 1;
      
      protected var all_god_index:int = 1;
      
      protected var cur_god_index_Right:int;
      
      protected var FRightGodMc_L:MovieClip;
      
      protected var FRightGodMc_R:MovieClip;
      
      protected var FRightGodTextName:TextField;
      
      protected var IsOpenThisPanel:Boolean;
      
      protected var FLeftEffect:MovieClip = null;
      
      protected var FRightEffect:MovieClip = null;
      
      protected var heroBmp:Bitmap;
      
      protected var dateBaseNin:TBins;
      
      protected var dateBaseProp:TBins;
      
      protected var dateBaseArtil:TBins;
      
      protected var Old_vec:Vector.<MovieClip>;
      
      protected var New_vec:Vector.<MovieClip>;
      
      protected var FSlotList:Vector.<TUISlot>;
      
      protected var Vec_inventory:Vector.<TInventory>;
      
      protected var Vec_inventory_temp:Vector.<TInventory>;
      
      protected var FSlotList_right:Vector.<TUISlot>;
      
      protected var MVC_Vec:Vector.<MovieClip>;
      
      protected var _cur_inherit_ID:uint = 0;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FSelectInventories:TInventories;
      
      protected var FTempSelectInventoriesId:Vector.<uint>;
      
      protected var FTempSelectInventoriesCount:Vector.<uint>;
      
      protected var FTempSelectInventoriesEquipLevel:Vector.<uint>;
      
      protected var F_0_1:Vector.<Object>;
      
      protected var FUIWindowEditor:TUIWindowEditor;
      
      protected var Exp_one:MovieClip;
      
      protected var Exp_two:MovieClip;
      
      protected var Exp_text:TextField;
      
      protected var F_Last_Hero:THero;
      
      protected var ExchangeLevel:int;
      
      protected var ExchangeLevelOne:int;
      
      protected var ExchangeLevelTwo:int;
      
      protected var ExchangeLevelThree:int;
      
      protected var DeftCost:int;
      
      protected var FUITab:TUITab;
      
      protected var FHint:THint;
      
      protected var FOverlayerPet:TOverlayerPet;
      
      protected var FProcessorNinjiaReincarnation:TProcessorNinjiaReincarnation = null;
      
      protected var FProcessorNinjiaAwake:TProcessorNinJaAwake;
      
      protected var FProcessorNinJaAwakeSkill:TProcessorNinJaAwakeSkill;
      
      protected var FUIHero:TUIHero;
      
      protected var FReincarnationBaseData:ReincarnationBaseData = null;
      
      protected var FUIWindowConfirmation:TUIWindowConfirmation = null;
      
      protected var FUIWindowConfirmationMachamp:TUIWindowConfirmation = null;
      
      protected var FHuLueWindowConfirmation:TUIWindowConfirmation = null;
      
      protected var FMC_HeroPosition:MovieClip = null;
      
      protected var FQueryCoordinate:TQueryCoordinate;
      
      protected var FEffectCoordinateParameters:TEffectCoordinateParameters;
      
      protected var FFunction:Function;
      
      protected var FUpdateHeroPower:Function;
      
      protected var FOnUserTotalFightingPowerReq:Function;
      
      protected var FOnEffectForSkill:Function;
      
      protected var FOnQueryShortcutCoordinate:Function;
      
      protected var TabIndex:int;
      
      protected var MaxLevelForQianNeng:int = 0;
      
      protected var MaxLevelForQianNengdatA:TNinJaPractice = null;
      
      protected var tempQianNengdatA:TNinJaPractice = null;
      
      protected var ErrorTypeIndex:int;
      
      protected var ErrorType:int = 0;
      
      protected var FIsShowEffectNiaja:Boolean = false;
      
      protected var FEffectFatherSpr:Sprite;
      
      protected var FEffectBitmap:Bitmap;
      
      protected var FUpdateHeroProperty:Function = null;
      
      protected var FUpdateHeroView:Function = null;
      
      public function TProcessorNinJaPractice(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FReincarnationBaseData = new ReincarnationBaseData();
         this.FUnstreamizerNinjaReincarnation = new TUnstreamizerNinjaReincarnation();
         this.FProcessorNinjiaReincarnation = new TProcessorNinjiaReincarnation(param1,this,this.FReincarnationBaseData);
         this.FProcessorNinjiaReincarnation.Reincarnation_Btn_Func = this.TReincarnation_Btn_Func;
         this.FProcessorNinjiaReincarnation.Replace_Btn_Func = this.TReplace_Btn_Func;
         this.FProcessorNinjiaReincarnation.GetReward_Btn_Func = this.TGetReward_Btn_Func;
         this.FProcessorNinjiaReincarnation.ApplianceOnOver = this.ApplianceOnOver;
         this.FProcessorNinjiaReincarnation.ApplianceOnOut = this.ApplianceOnOut;
         this.FProcessorNinjiaReincarnation.TalentMoveF = this.TalentMoveF;
         this.FProcessorNinjiaReincarnation.TalentOutF = this.TalentOutF;
         this.FProcessorNinjiaAwake = new TProcessorNinJaAwake(param1,this);
         this.FProcessorNinjiaAwake.Awake_Btn_Func = this.TAwake_Btn_Func;
         this.FProcessorNinjiaAwake.ApplianceOnOver = this.ApplianceOnOver;
         this.FProcessorNinjiaAwake.ApplianceOnOut = this.ApplianceOnOut;
         this.FProcessorNinJaAwakeSkill = new TProcessorNinJaAwakeSkill(param1,this);
         this.FProcessorNinJaAwakeSkill.Awake_Btn_Func = this.TAwakeSkil_Btn_Func;
         this.FProcessorNinJaAwakeSkill.ApplianceOnOver = this.ApplianceOnOver;
         this.FProcessorNinJaAwakeSkill.ApplianceOnOut = this.ApplianceOnOut;
         this.FUIHero = new TUIHero(param1);
         this.HERO_COUNT_Vec = new Vector.<MovieClip>();
         this.Old_vec = new Vector.<MovieClip>();
         this.New_vec = new Vector.<MovieClip>();
         this.MVC_Vec = new Vector.<MovieClip>();
         this.FSlotList = new Vector.<TUISlot>(SLOT_COUNT);
         this.FSlotList_right = new Vector.<TUISlot>(SLOT_COUNT_RIGHT);
         this.Vec_inventory = new Vector.<TInventory>();
         this.Vec_inventory_temp = new Vector.<TInventory>();
         this.Vec_inventory.length = 0;
         this.Vec_inventory_temp.length = 0;
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         this.FSelectInventories = new TInventories();
         this.FTempSelectInventoriesId = new Vector.<uint>();
         this.FTempSelectInventoriesCount = new Vector.<uint>();
         this.FTempSelectInventoriesEquipLevel = new Vector.<uint>();
         this.F_0_1 = new Vector.<Object>();
         this.FProcessorScene = new Sprite();
         addChild(this.FProcessorScene);
         this.FPocessorInherit = new TProcessorNinJaInherit(this,param2);
         this.FPocessorInherit.Visible = false;
         this.FPocessorInherit.onose = this.reshule;
         this.FPocessorInherit.OnEffectText = this.EffectText;
         this.FHint = new THint();
         this.FHelpTips = new THint();
         this.FOverlayerPet = new TOverlayerPet(this);
         this.FOverlayerPet.Visible = false;
         this.FQueryCoordinate = new TQueryCoordinate();
         this.FEffectCoordinateParameters = new TEffectCoordinateParameters();
         this.FUIWindowConfirmation = new TUIWindowConfirmation(this.Parent);
         this.FUIWindowConfirmation.OnOK = this.WindowConfirmationOnOK;
         this.FUIWindowConfirmation.x = (CONST_COMMON.STAGE_Width - this.FUIWindowConfirmation.WindowWidth) / 2;
         this.FUIWindowConfirmation.y = (CONST_COMMON.STAGE_Height - this.FUIWindowConfirmation.WindowHeight) / 2;
         this.FUIWindowConfirmationMachamp = new TUIWindowConfirmation(this.Parent);
         this.FUIWindowConfirmationMachamp.OnOK = this.WindowConfirmationMachampOnOK;
         this.FUIWindowConfirmationMachamp.x = (CONST_COMMON.STAGE_Width - this.FUIWindowConfirmationMachamp.WindowWidth) / 2;
         this.FUIWindowConfirmationMachamp.y = (CONST_COMMON.STAGE_Height - this.FUIWindowConfirmationMachamp.WindowHeight) / 2;
         this.FHuLueWindowConfirmation = new TUIWindowConfirmation(this.Parent);
         this.FHuLueWindowConfirmation.OnOK = this.HuLueWindowConfirmationMachampOnOK;
         this.FHuLueWindowConfirmation.OnCancel = this.HuLueWindowConfirmationMachampOnCancel;
         this.FHuLueWindowConfirmation.x = (CONST_COMMON.STAGE_Width - this.FHuLueWindowConfirmation.WindowWidth) / 2;
         this.FHuLueWindowConfirmation.y = (CONST_COMMON.STAGE_Height - this.FHuLueWindowConfirmation.WindowHeight) / 2;
         this.FEffectFatherSpr = new Sprite();
         this.FEffectBitmap = new Bitmap();
         this.FEffectFatherSpr.addChild(this.FEffectBitmap);
         SetUIModuleID(CONST_MODULES.MODULE_NinJaPractice);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_NINJAPRACTICE.JinNaPractice_RootId);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.FReincarnationBaseData.Inilization();
         this.FMC_ROOT = TUtilityReflection.CreateDisplayObjectInstance(CONST_NINJAPRACTICE.Practice_RootName) as MovieClip;
         this.FProcessorScene.addChild(this.FMC_ROOT);
         this.FLeftEffect = this.FMC_ROOT["MC_PendantLeft"];
         this.FRightEffect = this.FMC_ROOT["MC_PendantRight"];
         this.FMC_TWO = this.FMC_ROOT["MC_Tab_potency_Upgrade"];
         this.FMC_Reincarnation = this.FMC_ROOT["MC_Tab_potency_reincarnation"];
         this.FMC_Awake = this.FMC_ROOT["MC_Tab_potency_awake"];
         this.FMC_AwakeSkill = this.FMC_ROOT["MC_Tab_potency_awakeSkill"];
         this.FMC_HeroPosition = this.FMC_ROOT["MC_HeroPosition"];
         this.FMC_HeroPosition.addChild(this.FUIHero);
         this.FMC_HeroPosition.mouseEnabled = false;
         this.FMC_HeroPosition.mouseChildren = false;
         this.FUIHero.OnQuerySequenceContext = this.HeroOnQuerySequenceContext;
         this.FUIHero.DefaultRole = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_DefaultRoleTexture) as Sprite;
         this.FMC_HeroPosition.addChild(this.FEffectFatherSpr);
         this.FMC_ROOT.x = CONST_COMMON.STAGE_Width - this.FMC_ROOT.width >> 1;
         this.FMC_ROOT.y = CONST_COMMON.STAGE_Height - this.FMC_ROOT.height >> 1;
         this.heroBmp = new Bitmap();
         this.Exp_one = this.FMC_TWO["ExpItem"]["MC_ProgressBarExp0"] as MovieClip;
         this.Exp_two = this.FMC_TWO["ExpItem"]["MC_ProgressBarExp1"] as MovieClip;
         this.Exp_text = this.FMC_TWO["ExpItem"]["exp"] as TextField;
         this.FRightGodMc_L = this.FMC_TWO["MC_ExpPage"]["MC_PageLeft"];
         this.FRightGodMc_R = this.FMC_TWO["MC_ExpPage"]["MC_PageRight"];
         this.FRightGodTextName = this.FMC_TWO["MC_ExpPage"]["page"];
         this.FUITab = new TUITab(this);
         this.Fvaluation();
         this.FUIWindowEditor = new TUIWindowEditor(this.Parent,CONST_MODULES.MODULE_NinJaPractice);
         this.FUIWindowEditor.OnOK = this.WindowEditorOnOK;
         this.FUIWindowEditor.OnCancel = this.WindowEditorOnCancel;
         this.FUIWindowEditor.OnMax = this.WindowEditorOnMax;
         this.FUIWindowEditor.x = (FUICore.StageWidth - this.FUIWindowEditor.WindowWidth) / 2;
         this.FUIWindowEditor.y = (FUICore.StageHeight - this.FUIWindowEditor.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowEditor(this.FUIWindowEditor);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerPet);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerAppliance);
         this.FProcessorNinjiaReincarnation.Initiliztion();
         this.FProcessorNinjiaReincarnation.setBtnVisibel(1);
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowConfirmation);
         this.FUIWindowConfirmation.SetCheckBox(true);
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowConfirmationMachamp);
         this.FUIWindowConfirmationMachamp.SetCheckBox(false);
         TUtilityUIWindow.SetupWindowConfirmation(this.FHuLueWindowConfirmation);
         this.FHuLueWindowConfirmation.SetCheckBox(false);
         this.FProcessorNinjiaAwake.Initiliztion();
         this.FProcessorNinJaAwakeSkill.Initiliztion();
         this.IsOpenThisPanel = true;
         super.ResourcesPerform_UIDispatch();
      }
      
      protected function getBaseConfig() : void
      {
         var _loc1_:TConfigValue = null;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.NinjaReincarnaton_deft) as TConfigValue;
         this.DeftCost = _loc1_.Value as int;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.NinjaUpgrade_MaxLevel) as TConfigValue;
         this.ExchangeLevel = _loc1_.Value as int;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.NinjaUpgrade_MaxLevelOne) as TConfigValue;
         this.ExchangeLevelOne = _loc1_.Value as int;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.NinjaUpgrade_MaxLevelTwo) as TConfigValue;
         this.ExchangeLevelTwo = _loc1_.Value as int;
         this.ExchangeLevelThree = CONST_COMMON.Ninja_Max_QianNeng;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.NinjaReincarnatonCount) as TConfigValue;
         this.FReincarnationBaseData.ReincarnatonCount = _loc1_.Value as int;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.NinjaReincarnaton_LevelNeedOne) as TConfigValue;
         this.FReincarnationBaseData.LevelNeedOne = _loc1_.Value as int;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.NinjaReincarnaton_QianNengLevelNeedOne) as TConfigValue;
         this.FReincarnationBaseData.QianNengLevelNeedOne = _loc1_.Value as int;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.NinjaReincarnaton_StuffNeedOne) as TConfigValue;
         this.FReincarnationBaseData.StuffNeedOne = _loc1_.Value as int;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.NinjaReincarnaton_LevelNeedTwo) as TConfigValue;
         this.FReincarnationBaseData.LevelNeedTwo = _loc1_.Value as int;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.NinjaReincarnaton_QianNengLevelNeedTwo) as TConfigValue;
         this.FReincarnationBaseData.QianNengLevelNeedTwo = _loc1_.Value as int;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.NinjaReincarnaton_StuffNeedTwo) as TConfigValue;
         this.FReincarnationBaseData.StuffNeedTwo = _loc1_.Value as int;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,60500209) as TConfigValue;
         this.FReincarnationBaseData.LevelNeedThree = _loc1_.Value as int;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,60500210) as TConfigValue;
         this.FReincarnationBaseData.QianNengLevelNeedThree = _loc1_.Value as int;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,60500211) as TConfigValue;
         this.FReincarnationBaseData.StuffNeedThree = _loc1_.Value as int;
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.herorelation();
         if(this.heronumer >= 1)
         {
            this.F_Last_Hero = this.heros.GetHeroByIndex(0);
         }
         var _loc1_:int = 0;
         while(_loc1_ < this.MVC_Vec.length)
         {
            this.MVC_Vec[_loc1_].addEventListener(MouseEvent.CLICK,this.MVC_CLICK);
            this.MVC_Vec[_loc1_].addEventListener(MouseEvent.MOUSE_OVER,this.MVC_Over);
            this.MVC_Vec[_loc1_].addEventListener(MouseEvent.MOUSE_OUT,this.MVC_Out);
            this.MVC_Vec[_loc1_].addEventListener(MouseEvent.MOUSE_DOWN,this.MVC_DOWN);
            this.MVC_Vec[_loc1_].addEventListener(MouseEvent.MOUSE_UP,this.MVC_up);
            _loc1_++;
         }
         MovieClip(this.FMC_ROOT[CONST_NINJAPRACTICE.JP_HEROPAGE]["MC_PageLeft"]).addEventListener(MouseEvent.CLICK,this.MVC_CLICK);
         MovieClip(this.FMC_ROOT[CONST_NINJAPRACTICE.JP_HEROPAGE]["MC_PageRight"]).addEventListener(MouseEvent.CLICK,this.MVC_CLICK);
         MovieClip(this.FMC_TWO[CONST_NINJAPRACTICE.JP_GODPAGE]["MC_PageLeft"]).addEventListener(MouseEvent.CLICK,this.MVC_CLICK);
         MovieClip(this.FMC_TWO[CONST_NINJAPRACTICE.JP_GODPAGE]["MC_PageRight"]).addEventListener(MouseEvent.CLICK,this.MVC_CLICK);
         if(this.FRightGodMc_L)
         {
            this.FRightGodMc_L.addEventListener(MouseEvent.CLICK,this.MVC_CLICK);
         }
         if(this.FRightGodMc_R)
         {
            this.FRightGodMc_R.addEventListener(MouseEvent.CLICK,this.MVC_CLICK);
         }
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverTip);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerAppliance);
         TUtilityUIOverlayer.ResourcesDispatch(this.FTOverlayerHint);
         super.ResourcesPerform_UILocations();
         this.help();
         this.god_slot_right();
         this.getBaseConfig();
         this.FUIWindowConfirmationMachamp.Text = STRING_HEROS.STRING_ReincarnationMachampMaxLevel;
      }
      
      protected function EffectText(param1:Object, param2:Object, param3:Object, param4:Object, param5:Object) : void
      {
         OnEffectText(param1,param2);
      }
      
      protected function help() : void
      {
         var _loc1_:TSystemLanguage = null;
         this.FHelpTips = new THint();
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.NinJaPractice_Tips) as TSystemLanguage;
         this.FHelpTips.Content = _loc1_.Desc;
      }
      
      override protected function LogicsPerform() : void
      {
         if(!this.IsOpenThisPanel)
         {
            return;
         }
         super.LogicsPerform();
         var _loc1_:int = int(this.Vec_inventory.length);
         var _loc2_:int = 0;
         if(this.F_Last_Hero != null)
         {
            this.pichero(this.F_Last_Hero);
         }
         if(this.heros != null)
         {
            if(_loc1_ != 0)
            {
               _loc2_ = 0;
               while(_loc2_ < SLOT_COUNT)
               {
                  if(_loc2_ + (this.cur_god_index - 1) * SLOT_COUNT <= _loc1_ - 1)
                  {
                     this.FSlotList[_loc2_].Update();
                  }
                  _loc2_++;
               }
            }
         }
         if(this.FSelectInventories.Count != 0)
         {
            _loc2_ = 0;
            while(_loc2_ < SLOT_COUNT_RIGHT)
            {
               this.FSlotList_right[_loc2_].Update();
               _loc2_++;
            }
         }
         if(this.FUIWindowEditor != null && this.FUIWindowEditor.visible)
         {
            this.FUIWindowEditor.Update();
         }
         this.FUIHero.Update();
         this.FProcessorNinjiaReincarnation.LogicPerform();
         this.FProcessorNinjiaAwake.LogicPerform();
         this.FProcessorNinJaAwakeSkill.LogicPerform();
         this.upDateEffectImage();
      }
      
      protected function Fvaluation() : void
      {
         var _loc2_:TUISlot = null;
         var _loc3_:TUISlot = null;
         var _loc1_:int = 0;
         SimpleButton(this.FMC_ROOT[CONST_NINJAPRACTICE.JP_CLO]).addEventListener(MouseEvent.CLICK,this.close);
         new Tools_Help(this,this.FMC_ROOT[CONST_NINJAPRACTICE.JP_HE],CONST_SYSTEMLANGUAGE.NinJaPractice_Tips,FUICore);
         this.FMC_Tab01 = this.FMC_ROOT[CONST_NINJAPRACTICE.JP_TAB01] as MovieClip;
         this.FMC_Tab02 = this.FMC_ROOT[CONST_NINJAPRACTICE.JP_TAB02] as MovieClip;
         this.FMC_Tab03 = this.FMC_ROOT[CONST_NINJAPRACTICE.JP_TAB03] as MovieClip;
         this.FMC_Tab04 = this.FMC_ROOT[CONST_NINJAPRACTICE.JP_TAB04] as MovieClip;
         this.FMC_INHERIT = this.FMC_ROOT[CONST_NINJAPRACTICE.JP_INHERIT] as MovieClip;
         this.FMC_PIC = this.FMC_TWO[CONST_NINJAPRACTICE.JP_PIC] as MovieClip;
         _loc1_ = 0;
         while(_loc1_ < HERO_COUNT)
         {
            this.HERO_COUNT_Vec[_loc1_] = this.FMC_ROOT[CONST_NINJAPRACTICE.JP_NAME + _loc1_] as MovieClip;
            TextField(this.HERO_COUNT_Vec[_loc1_][CONST_NINJAPRACTICE.JP_NAME_NAME]).mouseEnabled = false;
            TextField(this.HERO_COUNT_Vec[_loc1_]["level"]).mouseEnabled = false;
            this.HERO_COUNT_Vec[_loc1_].buttonMode = true;
            this.HERO_COUNT_Vec[_loc1_].addEventListener(MouseEvent.CLICK,this.heroClick);
            this.HERO_COUNT_Vec[_loc1_].addEventListener(MouseEvent.MOUSE_OUT,this.heroout);
            this.HERO_COUNT_Vec[_loc1_].addEventListener(MouseEvent.MOUSE_OVER,this.heroOver);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            this.Old_vec[_loc1_] = MovieClip(this.FMC_TWO[CONST_NINJAPRACTICE.JP_OLD + _loc1_]);
            this.New_vec[_loc1_] = MovieClip(this.FMC_TWO[CONST_NINJAPRACTICE.JP_NEW + _loc1_]);
            _loc1_++;
         }
         this.FUITab.SetTabByIndex(this.FMC_Tab01,0);
         this.FUITab.SetTabByIndex(this.FMC_Tab02,1);
         this.FUITab.SetTabByIndex(this.FMC_Tab03,2);
         this.FUITab.SetTabByIndex(this.FMC_Tab04,3);
         this.FUITab.OnSwitch = this.TabOnSwitch;
         this.FUITab.Init();
         this.MVC_Vec.push(this.FMC_ROOT[CONST_NINJAPRACTICE.JP_INHERIT]);
         this.MVC_Vec.push(this.FMC_TWO[CONST_NINJAPRACTICE.JP_CLEAR]);
         this.MVC_Vec.push(this.FMC_TWO[CONST_NINJAPRACTICE.JP_USE]);
         MovieClip(this.FMC_PIC[CONST_NINJAPRACTICE.JP_PIC_PIC]).addChild(this.heroBmp);
         _loc1_ = 0;
         while(_loc1_ < SLOT_COUNT)
         {
            _loc2_ = new TUISlot(this);
            _loc2_.Resource = this.FMC_TWO[CONST_NINJAPRACTICE.JP_Slot + _loc1_] as MovieClip;
            _loc2_.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
            _loc2_.Tag = _loc1_;
            _loc2_.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
            _loc2_.OnQuerySubscript = this.SlotsOnQuerySubscript;
            _loc2_.OnOverlay = UIComponentsHintOnOver;
            _loc2_.OnOut = UIComponentsHintOnOut;
            _loc2_.OnClick = this.UIComponentHintClick;
            _loc2_.OnQueryEuqipLevel = this.SlotsOnQueryEuqipLevel;
            _loc2_.Init();
            this.FSlotList[_loc1_] = _loc2_;
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < SLOT_COUNT_RIGHT)
         {
            _loc3_ = new TUISlot(this);
            _loc3_.Resource = this.FMC_TWO["MC_Slot_1" + _loc1_] as MovieClip;
            _loc3_.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
            _loc3_.Tag = _loc1_;
            _loc3_.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
            _loc3_.OnQuerySubscript = this.SlotsOnQuerySubscript;
            _loc3_.OnOverlay = UIComponentsHintOnOver;
            _loc3_.OnOut = UIComponentsHintOnOut;
            _loc3_.OnClick = this.UIComponentHintClick_right;
            _loc3_.OnQueryEuqipLevel = this.SlotsOnQueryEuqipLevel;
            _loc3_.Init();
            this.FSlotList_right[_loc1_] = _loc3_;
            _loc1_++;
         }
         FOverlayerHelpTips = new TOverlayerHelpTips(this);
         this.FOverTip = new TOverJinJaPractice(this);
         this.FOverTip.visible = false;
         this.FTOverlayerHint = new TReincarnationgHintTip(this);
         this.FTOverlayerHint.visible = false;
         FOverlayerAppliance = new TOverlayerAppliance(this,CONST_MODULES.MODULE_NinJaPractice);
         FOverlayerAppliance.visible = false;
         FOverlayerHelpTips.Visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerHelpTips);
         this.TabOnSwitch(0);
      }
      
      protected function TabOnSwitch(param1:Object) : void
      {
         var _loc2_:int = param1 as int;
         this.FMC_TWO.visible = false;
         this.FMC_Reincarnation.visible = false;
         this.FMC_Awake.visible = false;
         this.FMC_AwakeSkill.visible = false;
         this.FMC_HeroPosition.visible = true;
         this.cur_page_index = 1;
         this.cur_hero_index = 0;
         if(_loc2_ == 0)
         {
            this.FMC_TWO.visible = true;
            this.TabIndex = 0;
            this.FMC_HeroPosition.visible = false;
         }
         else if(_loc2_ == 1)
         {
            this.FMC_Reincarnation.visible = true;
            this.TabIndex = 1;
         }
         else if(_loc2_ == 2)
         {
            this.FMC_Awake.visible = true;
            this.TabIndex = 2;
         }
         else
         {
            this.FMC_AwakeSkill.visible = true;
            this.TabIndex = 3;
         }
         this.herorelation();
         this.UpdateInterface();
      }
      
      protected function herorelation() : void
      {
         this.heros = SLogicsCore.Character.Heros;
         this.heros = this.selectFromHeros(this.heros);
         this.F_Last_Hero = this.heros.GetHeroByIndex(this.cur_hero_index);
         this.heronumer = Number(this.heros.Count);
         this.all_page_index = Math.ceil(this.heronumer / HERO_COUNT);
         var _loc1_:int = 0;
         while(_loc1_ < HERO_COUNT)
         {
            if(_loc1_ + (this.cur_page_index - 1) * HERO_COUNT > this.heronumer - 1)
            {
               this.HERO_COUNT_Vec[_loc1_].visible = false;
            }
            else
            {
               this.onehero(this.heros.GetHeroByIndex(_loc1_ + (this.cur_page_index - 1) * HERO_COUNT),this.HERO_COUNT_Vec[_loc1_]);
               this.HERO_COUNT_Vec[_loc1_].visible = true;
            }
            _loc1_++;
         }
         this.setBtnState1();
         TextField(this.FMC_ROOT[CONST_NINJAPRACTICE.JP_HEROPAGE]["page"]).text = this.cur_page_index + "/" + this.all_page_index;
         this.for_hero_index();
         this.UdateCurHeroProperty();
         if(SLogicsCore.Character.GetMainLevel() < 120)
         {
            this.FUITab.SetTabHideByIndex(2);
            this.FUITab.SetTabHideByIndex(3);
         }
         else
         {
            this.FUITab.SetTabShowByIndex(2);
            this.FUITab.SetTabShowByIndex(3);
         }
      }
      
      protected function selectFromHeros(param1:THeros) : THeros
      {
         var _loc3_:THero = null;
         var _loc4_:THeroTalent = null;
         var _loc5_:TBaseHero = null;
         var _loc6_:TSkillConfig = null;
         var _loc2_:THeros = new THeros();
         for each(_loc3_ in param1.Heros)
         {
            if(this.TabIndex == 2)
            {
               _loc5_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BaseHero,_loc3_.Identifier) as TBaseHero;
               _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_HeroTalent,_loc5_.Talent) as THeroTalent;
               if(_loc4_.AwakeEffect1 != "[]" || _loc3_.IsMain)
               {
                  _loc2_.Add(_loc3_);
               }
            }
            else if(this.TabIndex == 3)
            {
               _loc5_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BaseHero,_loc3_.Identifier) as TBaseHero;
               _loc6_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SkillConfig,_loc5_.Active) as TSkillConfig;
               if(Boolean(_loc6_.AwakecostObject.length) || _loc3_.IsMain)
               {
                  _loc2_.Add(_loc3_);
               }
            }
            else
            {
               _loc2_.Add(_loc3_);
            }
         }
         return _loc2_;
      }
      
      protected function setBtnState1() : void
      {
         if(this.all_page_index <= 1)
         {
            TGameUtil.setButtonMode(MovieClip(this.FMC_ROOT[CONST_NINJAPRACTICE.JP_HEROPAGE]["MC_PageLeft"]),false);
            TGameUtil.setButtonMode(MovieClip(this.FMC_ROOT[CONST_NINJAPRACTICE.JP_HEROPAGE]["MC_PageRight"]),false);
         }
         else
         {
            TGameUtil.setButtonMode(MovieClip(this.FMC_ROOT[CONST_NINJAPRACTICE.JP_HEROPAGE]["MC_PageLeft"]),this.cur_page_index == 1 ? false : true);
            TGameUtil.setButtonMode(MovieClip(this.FMC_ROOT[CONST_NINJAPRACTICE.JP_HEROPAGE]["MC_PageRight"]),this.cur_page_index >= this.all_page_index ? false : true);
         }
      }
      
      protected function setBtnState2() : void
      {
         if(this.all_god_index <= 1)
         {
            TGameUtil.setButtonMode(MovieClip(this.FMC_TWO[CONST_NINJAPRACTICE.JP_GODPAGE]["MC_PageLeft"]),false);
            TGameUtil.setButtonMode(MovieClip(this.FMC_TWO[CONST_NINJAPRACTICE.JP_GODPAGE]["MC_PageRight"]),false);
         }
         else
         {
            TGameUtil.setButtonMode(MovieClip(this.FMC_TWO[CONST_NINJAPRACTICE.JP_GODPAGE]["MC_PageLeft"]),this.cur_god_index == 1 ? false : true);
            TGameUtil.setButtonMode(MovieClip(this.FMC_TWO[CONST_NINJAPRACTICE.JP_GODPAGE]["MC_PageRight"]),this.cur_god_index >= this.all_god_index ? false : true);
         }
      }
      
      public function initilation() : void
      {
         this.cur_god_index = 1;
         this.cur_hero_index = 0;
         this.cur_page_index = 1;
         this.FTempSelectInventoriesId.length = 0;
         this.FTempSelectInventoriesCount.length = 0;
         this.FTempSelectInventoriesEquipLevel.length = 0;
         this.F_0_1.length = 0;
         this.Vec_inventory.length = 0;
         this.FSelectInventories.Clear();
         this.cur_god_index_Right = 1;
         this.god_slot_right();
         this.god_inventory();
         this.herorelation();
         if(this.heronumer >= 1)
         {
            this.F_Last_Hero = this.heros.GetHeroByIndex(this.cur_hero_index);
            if(this.TabIndex)
            {
               this.FReincarnationBaseData.NinjaId = this.F_Last_Hero.Identifier;
               this.SetPictureById();
               this.FProcessorNinjiaReincarnation.UpdateInterface(this.F_Last_Hero);
               this.UpdateMachampTip();
            }
            else
            {
               this.iniExp(this.F_Last_Hero);
               this.UdateCurHeroProperty();
            }
         }
      }
      
      protected function SetPictureById() : void
      {
         if(this.F_Last_Hero.ReincarnationId == 0 || this.F_Last_Hero.ReincarnationOneOrTwo >= this.FReincarnationBaseData.ReincarnatonCount)
         {
            this.FUIHero.Context = this.F_Last_Hero.Identifier;
         }
         else
         {
            this.FUIHero.Context = this.F_Last_Hero.ReincarnationId;
         }
      }
      
      protected function god_inventory() : void
      {
         this.godrelation();
         this.god_slot();
      }
      
      protected function godrelation() : void
      {
         var _loc3_:TInventory = null;
         this.Vec_inventory.length = 0;
         var _loc1_:int = 0;
         var _loc2_:TInventories = SLogicsCore.Character.Appliances;
         var _loc4_:int = _loc2_.Count;
         _loc1_ = 0;
         while(_loc1_ < _loc4_)
         {
            _loc3_ = _loc2_.GetInventoryByIndex(_loc1_);
            if(_loc3_.IsExchage == 1)
            {
               this.Vec_inventory.push(_loc3_);
            }
            _loc1_++;
         }
         _loc2_ = SLogicsCore.Character.Accessories;
         _loc4_ = _loc2_.Count;
         _loc1_ = 0;
         while(_loc1_ < _loc4_)
         {
            _loc3_ = _loc2_.GetInventoryByIndex(_loc1_);
            if(_loc3_.IsExchage == 1)
            {
               this.Vec_inventory.push(_loc3_);
               this.Vec_inventory_temp.push(_loc3_);
            }
            _loc1_++;
         }
         _loc2_ = SLogicsCore.Character.Materials;
         _loc4_ = _loc2_.Count;
         _loc1_ = 0;
         while(_loc1_ < _loc4_)
         {
            _loc3_ = _loc2_.GetInventoryByIndex(_loc1_);
            if(_loc3_.IsExchage == 1)
            {
               this.Vec_inventory.push(_loc3_);
               this.Vec_inventory_temp.push(_loc3_);
            }
            _loc1_++;
         }
      }
      
      protected function god_slot() : void
      {
         var _loc4_:int = 0;
         var _loc1_:int = 0;
         var _loc2_:Number = Number(this.Vec_inventory.length);
         this.all_god_index = Math.ceil(_loc2_ / SLOT_COUNT);
         _loc1_ = 0;
         while(_loc1_ < SLOT_COUNT)
         {
            _loc4_ = _loc1_ + (this.cur_god_index - 1) * SLOT_COUNT;
            if(_loc4_ > _loc2_ - 1)
            {
               this.FSlotList[_loc1_].Context = null;
            }
            else
            {
               this.FSlotList[_loc1_].Context = this.Vec_inventory[_loc4_];
            }
            _loc1_++;
         }
         this.reflshFilter();
         this.setBtnState2();
         var _loc3_:int = this.cur_god_index;
         if(_loc3_ > this.all_god_index)
         {
            _loc3_ = this.all_god_index;
         }
         TextField(this.FMC_TWO[CONST_NINJAPRACTICE.JP_GODPAGE]["page"]).text = _loc3_ + "/" + this.all_god_index;
      }
      
      protected function reflshFilter() : void
      {
         var _loc2_:Number = NaN;
         var _loc4_:TInventory = null;
         var _loc1_:Number = Number(this.Vec_inventory.length);
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < SLOT_COUNT)
         {
            _loc2_ = _loc3_ + (this.cur_god_index - 1) * SLOT_COUNT;
            if(_loc2_ <= _loc1_ - 1)
            {
               _loc4_ = this.FSlotList[_loc3_].Context as TInventory;
               if(_loc4_.Quantity <= 0)
               {
                  this.FSlotList[_loc3_].SetDefaultFilters(true);
               }
               else
               {
                  this.FSlotList[_loc3_].SetDefaultFilters(false);
               }
            }
            _loc3_++;
         }
      }
      
      protected function onehero(param1:THero, param2:MovieClip) : void
      {
         var _loc3_:uint = QUALITYCOLOR_INDEX[param1.Quality];
         TextField(param2["HeroName"]).textColor = _loc3_;
         TextField(param2["level"]).textColor = _loc3_;
         TextField(param2["HeroName"]).text = param1.Name;
         TextField(param2["level"]).text = param1.GetQianNengLevelStr(param1.PotentialLv);
      }
      
      protected function pichero(param1:THero) : void
      {
         TGameUtil.ShowImageByID(TGameUtil.Type_HeadIcon,this.heroBmp,CONST_MODULES.MODULE_NinJaPractice,param1.SmallID);
      }
      
      protected function UdateCurHeroProperty() : void
      {
         if(this.F_Last_Hero == null)
         {
            return;
         }
         var _loc1_:uint = QUALITYCOLOR_INDEX[this.F_Last_Hero.Quality];
         TextField(this.FMC_PIC[CONST_NINJAPRACTICE.JP_NAME_NAME]).textColor = _loc1_;
         TextField(this.FMC_PIC[CONST_NINJAPRACTICE.JP_NAME_LEVEL]).textColor = _loc1_;
         TextField(this.FMC_PIC[CONST_NINJAPRACTICE.JP_NAME_NAME]).text = this.F_Last_Hero.Name;
         TextField(this.FMC_PIC[CONST_NINJAPRACTICE.JP_NAME_LEVEL]).text = this.F_Last_Hero.GetLevelStrByLevel(this.F_Last_Hero.Level);
         TextField(this.FMC_TWO["level01"]).text = this.F_Last_Hero.GetQianNengLevelStr(this.F_Last_Hero.PotentialLv);
         TextField(this.FMC_TWO["level02"]).text = this.F_Last_Hero.GetQianNengLevelStr(this.F_Last_Hero.PotentialLv + 1);
         this.getDateBase(this.F_Last_Hero);
      }
      
      protected function getQNMaxLevellittle(param1:THero) : int
      {
         var _loc2_:int = 0;
         if(param1 == null)
         {
            return 0;
         }
         switch(param1.ReincarnationOneOrTwo)
         {
            case 0:
               _loc2_ = this.ExchangeLevel;
               break;
            case 1:
               _loc2_ = this.ExchangeLevelOne - this.ExchangeLevel;
               break;
            case 2:
               _loc2_ = this.ExchangeLevelTwo - this.ExchangeLevelOne;
               break;
            case 3:
               _loc2_ = this.ExchangeLevelThree - this.ExchangeLevelTwo;
         }
         return _loc2_;
      }
      
      protected function getQNMaxLevel(param1:THero) : int
      {
         var _loc2_:int = 0;
         if(param1 == null)
         {
            return 0;
         }
         switch(param1.ReincarnationOneOrTwo)
         {
            case 0:
               _loc2_ = this.ExchangeLevel;
               break;
            case 1:
               _loc2_ = this.ExchangeLevelOne;
               break;
            case 2:
               _loc2_ = this.ExchangeLevelTwo;
               break;
            case 3:
               _loc2_ = this.ExchangeLevelThree;
         }
         return _loc2_;
      }
      
      protected function getCurLevel_num(param1:THero, param2:int) : int
      {
         var _loc3_:int = 0;
         switch(param1.ReincarnationOneOrTwo)
         {
            case 0:
               _loc3_ = this.ExchangeLevel + param2;
               break;
            case 1:
               _loc3_ = this.ExchangeLevelOne + param2;
               break;
            case 2:
               _loc3_ = this.ExchangeLevelTwo + param2;
               break;
            case 3:
               _loc3_ = this.ExchangeLevelThree + param2;
         }
         return _loc3_;
      }
      
      protected function getDateBase(param1:THero) : void
      {
         var _loc2_:TNinJaPractice = null;
         var _loc3_:TNinJaPractice = null;
         this._cur_inherit_ID = param1.Identifier;
         this.dateBaseArtil = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         this.dateBaseNin = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_NinJaPractice);
         this.dateBaseProp = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_PropSwitch);
         _loc3_ = this.dateBaseNin.GetDatebaseByIndex(param1.PotentialLv) as TNinJaPractice;
         if(param1.PotentialLv < CONST_COMMON.Ninja_Max_QianNeng)
         {
            _loc2_ = this.dateBaseNin.GetDatebaseByIndex(param1.PotentialLv + 1) as TNinJaPractice;
            if(_loc2_)
            {
               this.New_vec[0]["TF_Text"].text = _loc2_.AddNearAttack;
               this.New_vec[1]["TF_Text"].text = _loc2_.AddNearDefense;
               this.New_vec[2]["TF_Text"].text = _loc2_.AddStrategyDefense;
               this.New_vec[3]["TF_Text"].text = _loc2_.AddSpeed;
               this.New_vec[4]["TF_Text"].text = _loc2_.AddMaxHp;
            }
            else
            {
               this.SetNull();
            }
         }
         else
         {
            this.SetNull();
         }
         this.Old_vec[0]["TF_Text"].text = _loc3_.AddStrategyAttack;
         this.Old_vec[1]["TF_Text"].text = _loc3_.AddStrategyDefense;
         this.Old_vec[2]["TF_Text"].text = _loc3_.AddNearDefense;
         this.Old_vec[3]["TF_Text"].text = _loc3_.AddSpeed;
         this.Old_vec[4]["TF_Text"].text = _loc3_.AddMaxHp;
         TextField(this.FMC_TWO["level03"]).text = param1.GetQianNengLevelStr(param1.PotentialLv);
         if(param1.Profession != CONST_CHARACTER.PROFESSION_Intellect)
         {
            this.wORf(1);
         }
         else
         {
            this.wORf(0);
         }
      }
      
      protected function SetNull() : void
      {
         TextField(this.FMC_TWO["level02"]).text = "";
         this.New_vec[0]["TF_Text"].text = "";
         this.New_vec[1]["TF_Text"].text = "";
         this.New_vec[2]["TF_Text"].text = "";
         this.New_vec[3]["TF_Text"].text = "";
         this.New_vec[4]["TF_Text"].text = "";
      }
      
      protected function iniExp(param1:THero) : void
      {
         var _loc2_:TNinJaPractice = null;
         var _loc4_:TInventory = null;
         var _loc3_:Number = 0;
         var _loc5_:Number = 0;
         var _loc6_:Number = 0;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_NinJaPractice,param1.PotentialLv + 1) as TNinJaPractice;
         if(_loc2_ == null)
         {
            _loc5_ = 0;
         }
         else
         {
            _loc5_ = Number(_loc2_.Cost);
         }
         _loc6_ = param1.PotentialExp;
         this.Exp_one.scaleX = this.getNumber(_loc6_,_loc5_);
         var _loc7_:int = 0;
         while(_loc7_ < this.FSelectInventories.Count)
         {
            _loc4_ = this.FSelectInventories.GetInventoryByIndex(_loc7_);
            _loc3_ += this.set_Exp_(_loc4_.IDTemplate) * Number(_loc4_.Quantity);
            _loc7_++;
         }
         var _loc8_:Number = this.getNumber(_loc6_ + _loc3_,_loc5_);
         if(_loc8_ > 1)
         {
            _loc8_ = 1;
         }
         this.Exp_two.scaleX = _loc8_;
         this.Exp_text.htmlText = "<font color=\'#ffffff\'>" + _loc6_ + "</font>" + "<font color=\'#00CC33\'>(+" + _loc3_ + ")/</font>" + "<font color=\'#ffffff\'>" + _loc5_ + "</font>";
      }
      
      protected function getNumber(param1:Number, param2:Number) : Number
      {
         if(param2 == 0)
         {
            return 0;
         }
         return param1 / param2;
      }
      
      protected function getScrByLevel(param1:int) : String
      {
         var _loc3_:TNinJaPractice = null;
         var _loc2_:String = "";
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_NinJaPractice,param1) as TNinJaPractice;
         switch(_loc3_.NeedTransLv)
         {
            case 0:
               _loc2_ = String(param1);
               break;
            case 1:
               _loc2_ = TUtilityString.Format(STRING_NINJIAREINCARNATION.Reincarnation_Describe,1,param1 - 100);
               break;
            case 2:
               _loc2_ = TUtilityString.Format(STRING_NINJIAREINCARNATION.Reincarnation_Describe,2,param1 - 150);
         }
         return _loc2_;
      }
      
      protected function getLevelNum() : void
      {
         this.MaxLevelForQianNengdatA = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_NinJaPractice,this.MaxLevelForQianNeng + 1) as TNinJaPractice;
         this.tempQianNengdatA = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_NinJaPractice,this.MaxLevelForQianNeng + 2) as TNinJaPractice;
         if(!this.MaxLevelForQianNengdatA)
         {
            return;
         }
         if(!this.tempQianNengdatA)
         {
            return;
         }
         if(this.MaxLevelForQianNengdatA.NeedLv - 1 > this.F_Last_Hero.Level || this.tempQianNengdatA.NeedTransLv > this.F_Last_Hero.ReincarnationOneOrTwo)
         {
            return;
         }
         ++this.MaxLevelForQianNeng;
         this.MaxLevelForQianNengdatA = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_NinJaPractice,this.MaxLevelForQianNeng + 1) as TNinJaPractice;
         if(!this.MaxLevelForQianNengdatA)
         {
            return;
         }
         this.getLevelNum();
      }
      
      protected function qq_(param1:THero, param2:TInventory) : uint
      {
         var _loc5_:TInventory = null;
         var _loc12_:int = 0;
         this.ErrorTypeIndex = 0;
         var _loc3_:int = this.getQNMaxLevel(param1);
         var _loc4_:Number = 0;
         var _loc6_:Number = Number(param1.PotentialExp);
         var _loc7_:int = int(param1.PotentialLv);
         if(_loc7_ >= _loc3_)
         {
            _loc7_ = _loc3_;
            this.ErrorTypeIndex = 1;
            return 0;
         }
         this.MaxLevelForQianNeng = _loc7_;
         this.MaxLevelForQianNengdatA = null;
         this.getLevelNum();
         var _loc8_:int = 0;
         while(_loc8_ < this.FSelectInventories.Count)
         {
            _loc5_ = this.FSelectInventories.GetInventoryByIndex(_loc8_);
            _loc4_ += this.set_Exp_(_loc5_.IDTemplate) * Number(_loc5_.Quantity);
            _loc8_++;
         }
         _loc4_ += _loc6_;
         var _loc9_:int = this.get_hero_exp_all(this.MaxLevelForQianNeng) - (this.MaxLevelForQianNeng == _loc3_ ? 0 : 1);
         var _loc10_:int = _loc9_ - _loc4_ - this.get_hero_exp_all(_loc7_);
         var _loc11_:int = int(this.set_Exp_(param2.IDTemplate));
         _loc12_ = int(param2.Quantity);
         var _loc13_:uint = _loc11_ * _loc12_;
         if(_loc10_ <= 0)
         {
            _loc12_ = 0;
         }
         else if(_loc10_ <= _loc13_)
         {
            _loc12_ = _loc10_ / _loc11_;
            if(_loc12_ * _loc11_ < _loc10_)
            {
               _loc12_++;
            }
         }
         return _loc12_;
      }
      
      protected function get_hero_exp_next(param1:int) : int
      {
         var _loc2_:TNinJaPractice = null;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_NinJaPractice,param1) as TNinJaPractice;
         return int(_loc2_.Cost);
      }
      
      public function set_Exp_(param1:uint) : Number
      {
         var _loc2_:TPropSwitch = null;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_PropSwitch,param1) as TPropSwitch;
         return Number(_loc2_.ExchageExp);
      }
      
      protected function get_hero_exp_all(param1:Number) : int
      {
         var _loc2_:TNinJaPractice = null;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_NinJaPractice,param1 + 1) as TNinJaPractice;
         return int(_loc2_.TotalCost);
      }
      
      protected function wORf(param1:int) : void
      {
         if(param1 == 1)
         {
            this.New_vec[0]["TF_name"].text = STRING_COMMON.STRINGS_BASEATTRIBUTENAMES[9];
            this.New_vec[1]["TF_name"].text = STRING_COMMON.STRINGS_BASEATTRIBUTENAMES[10];
            this.New_vec[2]["TF_name"].text = STRING_COMMON.STRINGS_BASEATTRIBUTENAMES[14];
            this.New_vec[3]["TF_name"].text = STRING_COMMON.STRINGS_BASEATTRIBUTENAMES[4];
            this.New_vec[4]["TF_name"].text = STRING_INHERITPRACTICE.INHERIT_LIFE;
            this.Old_vec[0]["TF_name"].text = STRING_COMMON.STRINGS_BASEATTRIBUTENAMES[9];
            this.Old_vec[1]["TF_name"].text = STRING_COMMON.STRINGS_BASEATTRIBUTENAMES[10];
            this.Old_vec[2]["TF_name"].text = STRING_COMMON.STRINGS_BASEATTRIBUTENAMES[14];
            this.Old_vec[3]["TF_name"].text = STRING_COMMON.STRINGS_BASEATTRIBUTENAMES[4];
            this.Old_vec[4]["TF_name"].text = STRING_INHERITPRACTICE.INHERIT_LIFE;
         }
         else
         {
            this.New_vec[0]["TF_name"].text = STRING_COMMON.STRINGS_BASEATTRIBUTENAMES[13];
            this.New_vec[1]["TF_name"].text = STRING_COMMON.STRINGS_BASEATTRIBUTENAMES[14];
            this.New_vec[2]["TF_name"].text = STRING_COMMON.STRINGS_BASEATTRIBUTENAMES[10];
            this.New_vec[3]["TF_name"].text = STRING_COMMON.STRINGS_BASEATTRIBUTENAMES[4];
            this.New_vec[4]["TF_name"].text = STRING_INHERITPRACTICE.INHERIT_LIFE;
            this.Old_vec[0]["TF_name"].text = STRING_COMMON.STRINGS_BASEATTRIBUTENAMES[13];
            this.Old_vec[1]["TF_name"].text = STRING_COMMON.STRINGS_BASEATTRIBUTENAMES[14];
            this.Old_vec[2]["TF_name"].text = STRING_COMMON.STRINGS_BASEATTRIBUTENAMES[10];
            this.Old_vec[3]["TF_name"].text = STRING_COMMON.STRINGS_BASEATTRIBUTENAMES[4];
            this.Old_vec[4]["TF_name"].text = STRING_INHERITPRACTICE.INHERIT_LIFE;
         }
      }
      
      protected function SlotsOnQuerySequenceContext(param1:Object, param2:Object, param3:TQueryAnimationSequence, param4:uint = 0) : void
      {
         var _loc5_:TInventory = null;
         var _loc6_:TResourceRepositoryTexture = null;
         var _loc7_:TTexture = null;
         _loc5_ = param2 as TInventory;
         _loc6_ = SResourcesCore.TexturesInventory;
         _loc7_ = _loc6_.GetTextureByIdentifier(_loc5_.IDTexture);
         if(_loc7_ != null)
         {
            param3.Value = _loc7_.GetAnimationSequenceByIdentifier(param4);
         }
         else
         {
            _loc6_.LoadSecondary(_loc5_.IDTexture,CONST_MODULES.MODULE_NinJaPractice);
         }
      }
      
      protected function SlotsOnQuerySubscript(param1:Object, param2:Object, param3:TQueryString) : void
      {
         var _loc4_:TAppliance = null;
         if(param2 is TAppliance)
         {
            _loc4_ = param2 as TAppliance;
            param3.Value = _loc4_.Quantity.toString();
         }
      }
      
      protected function SlotsOnQueryEuqipLevel(param1:Object, param2:Object, param3:TQueryString) : void
      {
         var _loc4_:TInventory = null;
         if(param2 is TInventory)
         {
            _loc4_ = param2 as TInventory;
            if(_loc4_.UpgradingLevel > 0)
            {
               param3.Value = STRING_COMMON.FORMAT_Level + _loc4_.UpgradingLevel.toString();
            }
         }
      }
      
      protected function UIComponentHintClick(param1:Object, param2:Object) : void
      {
         var _loc6_:String = null;
         this.ErrorType = 0;
         var _loc3_:TInventory = param2 as TInventory;
         var _loc4_:int = 0;
         if(_loc3_.Quantity == 0)
         {
            return;
         }
         var _loc5_:int = int(this.qq_(this.F_Last_Hero,_loc3_));
         if(_loc5_ == 0)
         {
            _loc6_ = "";
            if(this.ErrorTypeIndex)
            {
               if(this.getReincarnationLevel(this.F_Last_Hero.PotentialLv) == 0 || this.F_Last_Hero.ReincarnationOneOrTwo == 0)
               {
                  _loc6_ = STRING_TONGLING.TONGLING_57;
               }
               else if(this.getReincarnationLevel(this.F_Last_Hero.PotentialLv) == 1 || this.F_Last_Hero.ReincarnationOneOrTwo == 1)
               {
                  _loc6_ = STRING_TONGLING.TONGLING_58;
               }
               else if(this.getReincarnationLevel(this.F_Last_Hero.PotentialLv) == 2 || this.F_Last_Hero.ReincarnationOneOrTwo == 2)
               {
                  _loc6_ = STRING_TONGLING.TONGLING_57;
               }
               else
               {
                  _loc6_ = STRING_INHERITPRACTICE.INHERIT_FORTION01;
               }
            }
            else
            {
               _loc6_ = STRING_INHERITPRACTICE.INHERIT_FORTION01;
            }
            EffectGenerateText(_loc6_);
            return;
         }
         _loc4_ = _loc5_;
         if(_loc3_.Category == 2 || _loc3_.Category == 6)
         {
            this.FTempSelectInventoriesId.push(_loc3_.IDTemplate);
            this.FTempSelectInventoriesCount.push(_loc3_.Quantity);
            this.FTempSelectInventoriesEquipLevel.push(_loc3_.UpgradingLevel);
            this.F_0_1.push({
               "Identifier1":_loc3_.Identifier1,
               "Identifier0":_loc3_.Identifier0
            });
            _loc3_.Quantity = 0;
            this.toryReference();
            this.god_slot_right();
            return;
         }
         this.FUIWindowEditor.Context = _loc3_;
         this.FUIWindowEditor.Label = _loc3_.Name;
         this.FUIWindowEditor.Quantity = String(_loc4_);
         this.FUIWindowEditor.Value = _loc4_;
         this.FUIWindowEditor.Max = _loc4_;
         this.FUIWindowEditor.Min = 1;
         this.FUIWindowEditor.visible = true;
      }
      
      protected function getReincarnationLevel(param1:uint) : int
      {
         var _loc2_:TNinJaPractice = null;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_NinJaPractice,param1 + 1) as TNinJaPractice;
         return int(_loc2_.NeedTransLv);
      }
      
      protected function UIComponentHintClick_right(param1:TUISlot, param2:Object) : void
      {
         var _loc3_:int = 0;
         var _loc4_:TInventory = param2 as TInventory;
         var _loc5_:String = param1.Resource.name;
         var _loc6_:int = int(_loc5_.charAt(_loc5_.length - 1));
         _loc6_ = (this.cur_god_index_Right - 1) * SLOT_COUNT_RIGHT + _loc6_;
         _loc3_ = 0;
         while(_loc3_ < this.Vec_inventory.length)
         {
            if(this.Vec_inventory[_loc3_].Identifier1 == this.F_0_1[_loc6_].Identifier1 && this.Vec_inventory[_loc3_].Identifier0 == this.F_0_1[_loc6_].Identifier0)
            {
               this.Vec_inventory[_loc3_].Quantity += _loc4_.Quantity;
               break;
            }
            _loc3_++;
         }
         this.FTempSelectInventoriesId.splice(_loc6_,1);
         this.FTempSelectInventoriesCount.splice(_loc6_,1);
         this.FTempSelectInventoriesEquipLevel.splice(_loc6_,1);
         this.F_0_1.splice(_loc6_,1);
         this.toryReference();
         this.god_slot_right();
         if(this.FOverTip)
         {
            this.FOverTip.Hide();
         }
      }
      
      protected function clear_btn() : void
      {
         while(this.FSelectInventories.Count)
         {
            this.UIComponentHintClick_right(this.FSlotList_right[0],this.FSelectInventories.GetInventoryByIndex(0));
         }
      }
      
      protected function WindowEditorOnOK(param1:TUIWindowEditor) : void
      {
         var _loc3_:TInventory = null;
         var _loc6_:TInventory = null;
         var _loc2_:int = 0;
         var _loc4_:Boolean = true;
         var _loc5_:TInventory = param1.Context as TInventory;
         if(param1.Value <= _loc5_.Quantity)
         {
            _loc5_.Quantity -= param1.Value;
         }
         while(_loc2_ < this.FTempSelectInventoriesId.length)
         {
            if(this.F_0_1[_loc2_].Identifier1 == _loc5_.Identifier1 && this.F_0_1[_loc2_].Identifier0 == _loc5_.Identifier0)
            {
               this.FTempSelectInventoriesCount[_loc2_] += param1.Value;
               _loc4_ = false;
            }
            _loc2_++;
         }
         if(_loc4_)
         {
            this.FTempSelectInventoriesId.push(_loc5_.IDTemplate);
            this.FTempSelectInventoriesCount.push(param1.Value);
            this.FTempSelectInventoriesEquipLevel.push(_loc5_.UpgradingLevel);
            this.F_0_1.push({
               "Identifier1":_loc5_.Identifier1,
               "Identifier0":_loc5_.Identifier0
            });
         }
         this.toryReference();
         _loc2_ = 0;
         while(_loc2_ < this.FSelectInventories.Count)
         {
            _loc6_ = this.FSelectInventories.GetInventoryByIndex(_loc2_);
            _loc6_.Quantity = this.FTempSelectInventoriesCount[_loc2_];
            _loc2_++;
         }
         this.god_slot_right();
      }
      
      protected function toryReference() : void
      {
         var _loc1_:uint = 0;
         this.FSelectInventories.Clear();
         this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,this.FSelectInventories,this.FTempSelectInventoriesId);
         _loc1_ = 0;
         while(_loc1_ < this.FSelectInventories.Count)
         {
            this.FSelectInventories.GetInventoryByIndex(_loc1_).UpgradingLevel = this.FTempSelectInventoriesEquipLevel[_loc1_];
            this.FSelectInventories.GetInventoryByIndex(_loc1_).Quantity = this.FTempSelectInventoriesCount[_loc1_];
            _loc1_++;
         }
      }
      
      protected function god_slot_right() : void
      {
         var _loc2_:TInventory = null;
         var _loc3_:int = 0;
         this.UpdateIndex();
         var _loc1_:int = 0;
         while(_loc1_ < SLOT_COUNT_RIGHT)
         {
            _loc3_ = (this.cur_god_index_Right - 1) * SLOT_COUNT_RIGHT + _loc1_;
            if(_loc3_ >= this.FSelectInventories.Count)
            {
               this.FSlotList_right[_loc1_].Context = null;
            }
            else
            {
               _loc2_ = this.FSelectInventories.GetInventoryByIndex(_loc3_);
               _loc2_.Quantity = this.FTempSelectInventoriesCount[_loc3_];
               this.FSlotList_right[_loc1_].Context = _loc2_;
            }
            _loc1_++;
         }
         this.iniExp(this.F_Last_Hero);
         this.reflshFilter();
      }
      
      protected function WindowEditorOnCancel(param1:TUIWindowEditor) : void
      {
      }
      
      protected function WindowEditorOnMax(param1:TUIWindowEditor) : void
      {
         param1.Value = param1.Max;
      }
      
      protected function ApplianceOnOver(param1:Object, param2:Object) : void
      {
         var _loc3_:TOverlayer = null;
         var _loc4_:TInventory = null;
         _loc4_ = param2 as TInventory;
         _loc3_ = FOverlayerAppliance;
         if(_loc3_ != null)
         {
            _loc3_.Context = _loc4_;
            _loc3_.Render(FUICore.MouseCoordinate);
            _loc3_.Show();
         }
      }
      
      protected function ApplianceOnOut(param1:Object, param2:Object) : void
      {
         var _loc3_:TOverlayer = null;
         var _loc4_:TInventory = null;
         _loc4_ = param2 as TInventory;
         _loc3_ = FOverlayerAppliance;
         if(_loc3_ != null)
         {
            _loc3_.Hide();
         }
      }
      
      public function TalentMoveF(param1:MouseEvent) : void
      {
         if(this.FTOverlayerHint)
         {
            if(this.FHelpTips.Caption == "")
            {
               return;
            }
            this.FTOverlayerHint.Context = this.FHelpTips;
            this.FTOverlayerHint.Render(FUICore.MouseCoordinate);
            this.FTOverlayerHint.Show();
         }
      }
      
      public function TalentOutF(param1:MouseEvent) : void
      {
         if(this.FTOverlayerHint)
         {
            this.FTOverlayerHint.Hide();
         }
      }
      
      public function MVC_CLICK(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case this.FMC_ROOT[CONST_NINJAPRACTICE.JP_HEROPAGE]["MC_PageLeft"]:
               if(this.cur_page_index > 1)
               {
                  --this.cur_page_index;
                  this.herorelation();
               }
               break;
            case this.FMC_ROOT[CONST_NINJAPRACTICE.JP_HEROPAGE]["MC_PageRight"]:
               if(this.cur_page_index < this.all_page_index)
               {
                  this.cur_page_index += 1;
                  this.herorelation();
               }
               break;
            case this.FMC_TWO[CONST_NINJAPRACTICE.JP_GODPAGE]["MC_PageLeft"]:
               if(this.cur_god_index > 1)
               {
                  --this.cur_god_index;
                  this.god_slot();
               }
               break;
            case this.FMC_TWO[CONST_NINJAPRACTICE.JP_GODPAGE]["MC_PageRight"]:
               if(this.cur_god_index < this.all_god_index)
               {
                  this.cur_god_index += 1;
                  this.god_slot();
               }
               break;
            case this.FMC_ROOT[CONST_NINJAPRACTICE.JP_INHERIT]:
               this.FPocessorInherit.Visible = true;
               this.FPocessorInherit.openMe();
               break;
            case this.FMC_TWO[CONST_NINJAPRACTICE.JP_CLEAR]:
               this.clear_btn();
               break;
            case this.FMC_TWO[CONST_NINJAPRACTICE.JP_USE]:
               if(this.F_0_1.length != 0 && this._cur_inherit_ID != 0)
               {
                  this.GetReward(this._cur_inherit_ID,this.F_0_1,this.FTempSelectInventoriesCount);
               }
               break;
            case this.FRightGodMc_L:
               if(!this.FRightGodMc_L.buttonMode)
               {
                  return;
               }
               --this.cur_god_index_Right;
               this.god_slot_right();
               break;
            case this.FRightGodMc_R:
               if(!this.FRightGodMc_R.buttonMode)
               {
                  return;
               }
               ++this.cur_god_index_Right;
               this.god_slot_right();
         }
      }
      
      protected function UpdateIndex() : void
      {
         var _loc1_:uint = 0;
         TGameUtil.setButtonMode(this.FRightGodMc_L,true);
         TGameUtil.setButtonMode(this.FRightGodMc_R,true);
         if(this.cur_god_index_Right <= 1)
         {
            this.cur_god_index_Right = 1;
            TGameUtil.setButtonMode(this.FRightGodMc_L,false);
         }
         _loc1_ = Math.ceil(this.FSelectInventories.Count / SLOT_COUNT_RIGHT);
         if(this.cur_god_index_Right >= _loc1_)
         {
            this.cur_god_index_Right = _loc1_;
            TGameUtil.setButtonMode(this.FRightGodMc_R,false);
         }
         if(_loc1_ == 0)
         {
            _loc1_ = 1;
         }
         if(this.cur_god_index_Right == 0)
         {
            this.cur_god_index_Right = 1;
         }
         this.FRightGodTextName.text = this.cur_god_index_Right + "/" + _loc1_;
      }
      
      public function MVC_Over(param1:MouseEvent) : void
      {
         MovieClip(param1.target).gotoAndStop(2);
      }
      
      public function MVC_Out(param1:MouseEvent) : void
      {
         MovieClip(param1.target).gotoAndStop(1);
      }
      
      public function MVC_DOWN(param1:MouseEvent) : void
      {
         MovieClip(param1.target).gotoAndStop(3);
      }
      
      public function MVC_up(param1:MouseEvent) : void
      {
         MovieClip(param1.target).gotoAndStop(1);
      }
      
      public function close(param1:MouseEvent) : void
      {
         ProcessorClose();
      }
      
      public function heroClick(param1:MouseEvent) : void
      {
         MovieClip(param1.target).gotoAndStop(1);
         var _loc2_:String = MovieClip(param1.target).name;
         this.cur_hero_index = int(_loc2_.charAt(_loc2_.length - 1)) + (this.cur_page_index - 1) * HERO_COUNT;
         this.F_Last_Hero = this.heros.GetHeroByIndex(this.cur_hero_index);
         this.UpdateInterface();
         this.for_hero_index();
         this.clear_btn();
      }
      
      protected function UpdateInterface() : void
      {
         if(!this.F_Last_Hero)
         {
            return;
         }
         if(this.TabIndex)
         {
            this.FReincarnationBaseData.NinjaId = this.F_Last_Hero.Identifier;
            this.SetPictureById();
            this.FProcessorNinjiaReincarnation.UpdateInterface(this.F_Last_Hero);
            this.UpdateMachampTip();
            if(this.TabIndex == 2)
            {
               this.FProcessorNinjiaAwake.UpdateInterface(this.F_Last_Hero);
            }
            if(this.TabIndex == 3)
            {
               this.FProcessorNinJaAwakeSkill.UpdateInterface(this.F_Last_Hero);
            }
         }
         else
         {
            this.iniExp(this.F_Last_Hero);
            this.UdateCurHeroProperty();
         }
      }
      
      protected function for_hero_index() : void
      {
         var _loc2_:String = null;
         var _loc3_:int = 0;
         var _loc1_:int = 0;
         while(_loc1_ < HERO_COUNT)
         {
            _loc2_ = this.HERO_COUNT_Vec[_loc1_].name;
            _loc3_ = int(_loc2_.charAt(_loc2_.length - 1)) + (this.cur_page_index - 1) * HERO_COUNT;
            if(_loc3_ == this.cur_hero_index)
            {
               this.HERO_COUNT_Vec[_loc1_].gotoAndStop(1);
            }
            else
            {
               this.HERO_COUNT_Vec[_loc1_].gotoAndStop(2);
            }
            _loc1_++;
         }
      }
      
      public function heroout(param1:MouseEvent) : void
      {
         var _loc2_:String = MovieClip(param1.target).name;
         var _loc3_:int = int(_loc2_.charAt(_loc2_.length - 1)) + (this.cur_page_index - 1) * HERO_COUNT;
         if(_loc3_ == this.cur_hero_index)
         {
            MovieClip(param1.target).gotoAndStop(1);
         }
         else
         {
            MovieClip(param1.target).gotoAndStop(2);
         }
      }
      
      public function heroOver(param1:MouseEvent) : void
      {
         MovieClip(param1.target).gotoAndStop(3);
      }
      
      public function herodown(param1:MouseEvent) : void
      {
         MovieClip(param1.target).gotoAndStop(2);
      }
      
      public function heroup(param1:MouseEvent) : void
      {
         MovieClip(param1.target).gotoAndStop(1);
      }
      
      public function get funct() : Function
      {
         return this.FFunction;
      }
      
      public function set funct(param1:Function) : void
      {
         this.FFunction = param1;
      }
      
      public function get UpdateHeroPower() : Function
      {
         return this.FUpdateHeroPower;
      }
      
      public function set UpdateHeroPower(param1:Function) : void
      {
         this.FUpdateHeroPower = param1;
         this.FPocessorInherit.UpdateHeroPower = param1;
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_NinJaPractice_ExpRet_Ret,this.PerformPacket_SC_JinJaPractice_GetRewardOk);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_NinJaPractice_Inherit_Ret,this.PerformPacket_SC_JinJaPractice_GetRewardOk1);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_NinjaReincarnation_imagess_Ret,this.PerformPacket_SC_NinjaReincarnation_imagess_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_NinjaReincarnation_Emergence_Ret,this.PerformPacket_SC_NinjaReincarnation_Emergence_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_NinjaReincarnation_Sophistication_Ret,this.PerformPacket_SC_NinjaReincarnation_Sophistication_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TransmigrationWashReplace_Ret,this.PerformPacket_SC_TransmigrationWashReplace_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TransmigrationGetSkill_Ret,this.PerformPacket_SC_TransmigrationGetSkill_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_NinjaAwake_Ret,this.PerformPacket_SC_NinjaAwake_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_AwakeSkill_Ret,this.PerformPacket_SC_AwakeSkill_Ret);
      }
      
      protected function PerformPacket_SC_JinJaPractice_GetRewardOk1(param1:TPacket) : void
      {
         this.FPocessorInherit.PerformPacket_SC_JinJaPractice_GetRewardOk(param1);
      }
      
      public function reshule() : void
      {
         this.herorelation();
         this.iniExp(this.F_Last_Hero);
      }
      
      protected function PerformPacket_SC_JinJaPractice_GetRewardOk(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         _loc2_ = param1.Data;
         _loc3_ = int(_loc2_.readUnsignedInt());
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc4_ = _loc2_.readUnsignedInt();
         _loc5_ = _loc2_.readUnsignedInt();
         _loc6_ = _loc2_.readUnsignedInt();
         this.F_Last_Hero.PotentialLv = _loc5_;
         this.F_Last_Hero.PotentialExp = _loc6_;
         this.herorelation();
         this.iniExp(this.F_Last_Hero);
         this.god_inventory();
         if(this.FUpdateHeroPower != null)
         {
            this.FUpdateHeroPower(this,_loc4_);
         }
         if(this.FOnUserTotalFightingPowerReq != null)
         {
            this.FOnUserTotalFightingPowerReq(this);
         }
      }
      
      protected function GetReward(param1:uint, param2:Vector.<Object>, param3:Vector.<uint>) : void
      {
         var _loc4_:TPacket = null;
         var _loc5_:ByteArray = null;
         _loc4_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_NinJaPractice_AddExp_Rep);
         _loc5_ = _loc4_.Data;
         _loc5_.writeUnsignedInt(param1);
         _loc5_.writeShort(param2.length);
         var _loc6_:int = 0;
         while(_loc6_ < param2.length)
         {
            _loc5_.writeUnsignedInt(param2[_loc6_].Identifier0);
            _loc5_.writeUnsignedInt(param2[_loc6_].Identifier1);
            _loc5_.writeUnsignedInt(param3[_loc6_]);
            _loc6_++;
         }
         this.clear_btn();
         SNetworkCore.Transceiver.PacketTransmit(_loc4_);
      }
      
      public function get OnUserTotalFightingPowerReq() : Function
      {
         return this.FOnUserTotalFightingPowerReq;
      }
      
      public function set OnUserTotalFightingPowerReq(param1:Function) : void
      {
         this.FOnUserTotalFightingPowerReq = param1;
      }
      
      public function get MC_Reincarnation() : MovieClip
      {
         return this.FMC_Reincarnation;
      }
      
      public function get MC_Awake() : MovieClip
      {
         return this.FMC_Awake;
      }
      
      public function get MC_AwakeSkill() : MovieClip
      {
         return this.FMC_AwakeSkill;
      }
      
      public function set OnShortcutHyperlinks(param1:Function) : void
      {
         if(this.FProcessorNinjiaReincarnation == null)
         {
            return;
         }
         this.FProcessorNinjiaReincarnation.OnShortcutHyperlinks = param1;
         this.FProcessorNinjiaAwake.OnShortcutHyperlinks = param1;
      }
      
      protected function HeroOnQuerySequenceContext(param1:Object, param2:Object, param3:TQueryAnimationSequence, param4:uint = 0) : void
      {
         var _loc5_:uint = 0;
         var _loc6_:TResourceRepositoryTexture = null;
         var _loc7_:TTexture = null;
         var _loc8_:TBounds = null;
         var _loc9_:TCoordinate = null;
         var _loc10_:TRoleModel = null;
         _loc5_ = param2 as uint;
         _loc8_ = new TBounds();
         _loc9_ = new TCoordinate();
         _loc6_ = SResourcesCore.TexturesModel;
         _loc10_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_RoleModel,_loc5_) as TRoleModel;
         _loc7_ = _loc6_.GetTextureByIdentifier(_loc10_.Model);
         if(_loc7_ != null)
         {
            param3.Value = _loc7_.GetAnimationSequenceByIndex(0);
            param3.Value.Evaluate(_loc9_,_loc8_);
            this.FUIHero.X = _loc8_.X;
            this.FUIHero.Y = _loc8_.Y;
         }
         else
         {
            _loc6_.LoadSecondary(_loc10_.Model,CONST_MODULES.MODULE_NinJaPractice);
            this.FUIHero.X = 0;
            this.FUIHero.Y = 0;
         }
         if(this.F_Last_Hero.Identifier != SLogicsCore.Character.MainHero.Identifier)
         {
            this.FIsShowEffectNiaja = true;
            this.FEffectFatherSpr.visible = true;
         }
         else
         {
            this.FIsShowEffectNiaja = false;
            this.FEffectFatherSpr.visible = false;
         }
      }
      
      protected function upDateEffectImage() : void
      {
         if(this.FIsShowEffectNiaja)
         {
            TGameUtil.ShowEffectById(this.FEffectBitmap,CONST_COMMON.Nija_Reincarnation_Effect_NotMain);
            this.FEffectBitmap.visible = true;
         }
         else
         {
            if(this.FEffectBitmap.bitmapData)
            {
               this.FEffectBitmap.bitmapData.dispose();
               this.FEffectBitmap.bitmapData = null;
            }
            this.FEffectBitmap.visible = false;
         }
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount();
         if(!FIsResourcesLoadCompleted)
         {
            this.FPocessorInherit.Load();
            return;
         }
         this.initilation();
         this.FProcessorNinjiaReincarnation.OpenThisPanel();
         this.FLeftEffect.gotoAndPlay(1);
         this.FRightEffect.gotoAndPlay(1);
      }
      
      override public function Unmount() : void
      {
         super.Unmount();
         this.FPocessorInherit.visible = false;
         this.FProcessorNinjiaReincarnation.SlotReset();
         this.clear_btn();
         this.TGetReward_Btn_Func(3);
         this.ResetSlot();
         SLogicsCore.Character.HeroIndex = 0;
         SLogicsCore.Character.PageIndex = 0;
      }
      
      protected function PerformPacket_SC_NinjaReincarnation_imagess_Ret(param1:TPacket) : void
      {
         this.FUnstreamizerNinjaReincarnation.Unstreamize(param1.Data,null,null);
      }
      
      protected function PerformPacket_SC_TransmigrationGetSkill_Ret(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         this.FReincarnationBaseData.ReincarnationGetSkill.length = 0;
         _loc2_ = param1.Data.readShort();
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            this.FReincarnationBaseData.ReincarnationGetSkill.push(param1.Data.readUnsignedInt());
            _loc3_++;
         }
         this.ProcessorEffectAcquireInventory();
      }
      
      protected function TReincarnation_Btn_Func() : void
      {
         var _loc1_:String = null;
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         var _loc4_:int = 0;
         if(this.CheckReincarnationCount())
         {
            EffectGenerateText(STRING_HEROS.STRING_ReincarnationCount);
            return;
         }
         if(this.CheckProp())
         {
            EffectGenerateText(STRING_HEROS.STRING_ReincarnationProp);
            return;
         }
         if(this.CheckReincarnationLevel())
         {
            EffectGenerateText(STRING_HEROS.STRING_DReincarnation_max);
            return;
         }
         if(this.CheckRoleLevel())
         {
            _loc1_ = TUtilityString.Format(STRING_HEROS.STRING_ReincarnationLevel_min,this.F_Last_Hero.GetOnlyLevelStrByLevel(this.FReincarnationBaseData.LevelNeedOne));
            EffectGenerateText(_loc1_);
            return;
         }
         if(this.CheckQianNengLevel())
         {
            if(this.F_Last_Hero.ReincarnationOneOrTwo == 0)
            {
               _loc4_ = this.FReincarnationBaseData.QianNengLevelNeedOne;
            }
            else
            {
               _loc4_ = this.FReincarnationBaseData.QianNengLevelNeedTwo;
            }
            _loc1_ = TUtilityString.Format(STRING_HEROS.STRING_ReincarnationQianneng,this.F_Last_Hero.GetQianNengOnlyLevelStr(_loc4_));
            EffectGenerateText(_loc1_);
            return;
         }
         if(this.CheckEquipMentsMounted())
         {
            EffectGenerateText(STRING_HEROS.STRING_StripEquipment);
            return;
         }
         if(this.CheckTalismanMounted())
         {
            EffectGenerateText(STRING_HEROS.STRING_StripAdder);
            return;
         }
         if(this.CheckAccessoryMounted())
         {
            EffectGenerateText(STRING_HEROS.STRING_StripAdderAccessory);
            return;
         }
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_NinjaReincarnation_Emergence_Req);
         _loc3_ = _loc2_.Data;
         _loc3_.writeUnsignedInt(int(this.F_Last_Hero.Identifier));
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function TReplace_Btn_Func() : void
      {
         if(this.FReincarnationBaseData.CurMachampLevel >= 8)
         {
            this.FHuLueWindowConfirmation.Text = TUtilityString.Format(STRING_INHERITPRACTICE.INHERIT_FORTION11,this.FReincarnationBaseData.MachampName,this.FReincarnationBaseData.MachampDescribe);
            this.FHuLueWindowConfirmation.visible = true;
         }
         else
         {
            this.NiMei();
         }
      }
      
      protected function NiMei() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TransmigrationWashReplace_Req);
         _loc2_ = _loc1_.Data;
         _loc2_.writeUnsignedInt(int(this.F_Last_Hero.Identifier));
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function TGetReward_Btn_Func(param1:int) : void
      {
         if(param1 == 1)
         {
            if(this.F_Last_Hero.ReincarnationOneOrTwo == 0)
            {
               EffectGenerateText(STRING_HEROS.STRING_ReincarnationNoXiLian);
               return;
            }
            if(this.FUIWindowConfirmation.IsSelected)
            {
               this.IsFUIWindowConfirmationMachamp();
            }
            else
            {
               this.FUIWindowConfirmation.Text = TUtilityString.Format(new ConsumeFrame(CONST_SYSTEMLANGUAGE.ConsumerConfirm_NinJiaReincarnation_deft).DescribeString,this.DeftCost);
               this.FUIWindowConfirmation.Visible = true;
            }
         }
         else if(param1 == 2)
         {
            this.HuLueCancel();
         }
      }
      
      protected function HuLueCancel() : void
      {
         this.F_Last_Hero.TempMachampId = 0;
         this.FProcessorNinjiaReincarnation.setBtnVisibel(1);
         this.FProcessorNinjiaReincarnation.UpdateInterface_for_Machamp();
         this.UpdateMachampTip();
      }
      
      public function IsFUIWindowConfirmationMachamp() : void
      {
         if(this.FReincarnationBaseData.CurMachampLevel == this.FReincarnationBaseData.MachampMaxLevel)
         {
            this.FUIWindowConfirmationMachamp.visible = true;
         }
         else
         {
            this.C_S_Emergence_Req();
         }
      }
      
      protected function UpdateMachampTip() : void
      {
         if(this.FReincarnationBaseData.MachampMaxLevel)
         {
            this.FHelpTips.Caption = TUtilityString.Format(STRING_HEROS.STRING_ReincarnationThisMaX,this.FReincarnationBaseData.MachampMaxLevel);
         }
         else
         {
            this.FHelpTips.Caption = "";
         }
      }
      
      protected function WindowConfirmationMachampOnOK(param1:Object) : void
      {
         this.C_S_Emergence_Req();
      }
      
      protected function HuLueWindowConfirmationMachampOnOK(param1:Object) : void
      {
         this.NiMei();
      }
      
      protected function HuLueWindowConfirmationMachampOnCancel(param1:Object) : void
      {
      }
      
      protected function WindowConfirmationOnOK(param1:Object) : void
      {
         this.IsFUIWindowConfirmationMachamp();
      }
      
      protected function C_S_Emergence_Req() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_NinjaReincarnation_Sophistication_Req);
         _loc2_ = _loc1_.Data;
         _loc2_.writeUnsignedInt(int(this.F_Last_Hero.Identifier));
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function TAwake_Btn_Func() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_NinjaAwake_Req);
         _loc2_ = _loc1_.Data;
         _loc2_.writeUnsignedInt(int(this.F_Last_Hero.Identifier));
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function TAwakeSkil_Btn_Func() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_AwakeSkill_Req);
         _loc2_ = _loc1_.Data;
         _loc2_.writeUnsignedInt(int(this.F_Last_Hero.Identifier));
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      public function set UpdateHeroProperty(param1:Function) : void
      {
         this.FUpdateHeroProperty = param1;
      }
      
      public function get UpdateHeroProperty() : Function
      {
         return this.FUpdateHeroProperty;
      }
      
      public function set UpdateHeroView(param1:Function) : void
      {
         this.FUpdateHeroView = param1;
      }
      
      protected function PerformPacket_SC_NinjaReincarnation_Emergence_Ret(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:ByteArray = null;
         _loc3_ = param1.Data;
         _loc2_ = int(_loc3_.readUnsignedInt());
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         var _loc4_:uint = _loc3_.readUnsignedInt();
         var _loc5_:uint = _loc3_.readUnsignedInt();
         this.F_Last_Hero = this.heros.GetHeroByIdentifier(_loc4_);
         this.F_Last_Hero.Identifier = _loc5_;
         this.F_Last_Hero.Skills.GetSkillByIndex(0).Description = this.FReincarnationBaseData.SkillDescribe;
         this.FReincarnationBaseData.NinjaId = _loc5_;
         this.FUnstreamizerNinjaReincarnation.UnstreamizationPerform_BaseAttributes(_loc3_,this.F_Last_Hero,null);
         this.FProcessorNinjiaReincarnation.UpdateInterface(this.F_Last_Hero);
         this.UpdateMachampTip();
         this.SetPictureById();
         if(this.FUpdateHeroView != null)
         {
            this.FUpdateHeroView(null,SLogicsCore.Character.GetMainHero().Identifier);
         }
         if(this.FUpdateHeroProperty != null)
         {
            this.FUpdateHeroProperty();
         }
         this.herorelation();
      }
      
      protected function PerformPacket_SC_NinjaReincarnation_Sophistication_Ret(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:ByteArray = null;
         _loc3_ = param1.Data;
         _loc2_ = int(_loc3_.readUnsignedInt());
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         this.F_Last_Hero.Identifier = _loc3_.readUnsignedInt();
         this.F_Last_Hero.TempMachampId = _loc3_.readUnsignedInt();
         this.FProcessorNinjiaReincarnation.setBtnVisibel(2);
         this.FProcessorNinjiaReincarnation.UpdateInterface_for_Machamp();
         this.UpdateMachampTip();
         EffectGenerateText(STRING_HEROS.STRING_Deft_Successful);
      }
      
      protected function PerformPacket_SC_TransmigrationWashReplace_Ret(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:ByteArray = null;
         _loc3_ = param1.Data;
         _loc2_ = int(_loc3_.readUnsignedInt());
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         this.FProcessorNinjiaReincarnation.setBtnVisibel(1);
         this.F_Last_Hero.Identifier = _loc3_.readUnsignedInt();
         this.F_Last_Hero.MachampId = _loc3_.readUnsignedInt();
         this.F_Last_Hero.TempMachampId = 0;
         this.FProcessorNinjiaReincarnation.UpdateInterface_for_Machamp();
         this.UpdateMachampTip();
      }
      
      protected function PerformPacket_SC_NinjaAwake_Ret(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:ByteArray = null;
         var _loc6_:THero = null;
         _loc3_ = param1.Data;
         _loc2_ = int(_loc3_.readUnsignedInt());
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         var _loc4_:int = int(_loc3_.readUnsignedInt());
         var _loc5_:int = int(_loc3_.readUnsignedInt());
         _loc6_ = SLogicsCore.Character.Heros.GetHeroByIdentifier(_loc4_);
         _loc6_.AwakeLevel = _loc5_;
         this.FProcessorNinjiaAwake.UpdateInterface(this.F_Last_Hero);
         EffectGenerateText(TUtilityString.GetText(CONST_SYSTEMLANGUAGE.STRING_Awake_Succ));
         this.UnstreamizationPerform_BaseAttributes(_loc3_,_loc6_,null);
      }
      
      protected function PerformPacket_SC_AwakeSkill_Ret(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:ByteArray = null;
         var _loc6_:THero = null;
         _loc3_ = param1.Data;
         _loc2_ = int(_loc3_.readUnsignedInt());
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         var _loc4_:int = int(_loc3_.readUnsignedInt());
         var _loc5_:int = int(_loc3_.readUnsignedInt());
         _loc6_ = SLogicsCore.Character.Heros.GetHeroByIdentifier(_loc4_);
         _loc6_.AwakeSkil = 1;
         this.FProcessorNinJaAwakeSkill.UpdateInterface(this.F_Last_Hero);
         EffectGenerateText(TUtilityString.GetText(CONST_SYSTEMLANGUAGE.STRING_Awake_Succ));
      }
      
      private function UnstreamizationPerform_BaseAttributes(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:THero = null;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         _loc6_ = param2 as THero;
         _loc5_ = 30;
         var _loc9_:uint = TUnstreamizerCharacter.STARTINDEX_BaseAttribute;
         var _loc10_:uint = TUnstreamizerCharacter.ENDINDEX_BaseAttribute;
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            if(_loc4_ >= _loc9_ && _loc4_ < _loc10_)
            {
               _loc7_ = param1.readFloat();
               _loc8_ = parseFloat(Number(_loc7_ * 100).toFixed(1));
               _loc6_.SetBaseAttributeByIndex(_loc4_,_loc8_);
            }
            else
            {
               if(_loc4_ == CONST_COMMON.BASEATTRIBUTEINDEX_Health)
               {
                  _loc7_ = param1.readFloat();
               }
               else
               {
                  _loc7_ = param1.readUnsignedInt();
               }
               _loc6_.SetBaseAttributeByIndex(_loc4_,_loc7_);
            }
            _loc4_++;
         }
      }
      
      protected function CheckReincarnationLevel() : Boolean
      {
         return Boolean(this.F_Last_Hero.ReincarnationOneOrTwo >= this.FReincarnationBaseData.ReincarnatonCount);
      }
      
      protected function CheckRoleLevel() : Boolean
      {
         return Boolean(this.F_Last_Hero.Level < this.FReincarnationBaseData.LevelNeedOne);
      }
      
      protected function CheckQianNengLevel() : Boolean
      {
         if(this.F_Last_Hero.ReincarnationOneOrTwo == 0)
         {
            return Boolean(this.F_Last_Hero.PotentialLv < this.FReincarnationBaseData.QianNengLevelNeedOne);
         }
         if(this.F_Last_Hero.ReincarnationOneOrTwo == 1)
         {
            return Boolean(this.F_Last_Hero.PotentialLv < this.FReincarnationBaseData.QianNengLevelNeedTwo);
         }
         return false;
      }
      
      protected function CheckReincarnationCount() : Boolean
      {
         var _loc1_:THero = null;
         if(!this.F_Last_Hero.IsMain)
         {
            _loc1_ = SLogicsCore.Character.GetMainHero();
            if(this.F_Last_Hero.ReincarnationOneOrTwo >= _loc1_.ReincarnationOneOrTwo)
            {
               return true;
            }
         }
         return false;
      }
      
      protected function CheckEquipMentsMounted() : Boolean
      {
         var _loc1_:uint = 0;
         var _loc2_:THero = null;
         var _loc3_:int = 0;
         var _loc4_:TInventory = null;
         _loc1_ = uint(this.F_Last_Hero.EquipmentsMounted.Capacity);
         _loc3_ = 0;
         while(_loc3_ < _loc1_)
         {
            _loc4_ = this.F_Last_Hero.EquipmentsMounted.GetInventoryByIndex(_loc3_);
            if(_loc4_ != null)
            {
               return true;
            }
            _loc3_++;
         }
         return false;
      }
      
      protected function CheckTalismanMounted() : Boolean
      {
         var _loc1_:uint = 0;
         var _loc2_:THero = null;
         var _loc3_:int = 0;
         var _loc4_:TInventory = null;
         _loc1_ = uint(this.F_Last_Hero.TalismansMounted.Capacity);
         _loc3_ = 0;
         while(_loc3_ < _loc1_)
         {
            _loc4_ = this.F_Last_Hero.TalismansMounted.GetInventoryByIndex(_loc3_);
            if(_loc4_ != null)
            {
               return true;
            }
            _loc3_++;
         }
         return false;
      }
      
      protected function CheckAccessoryMounted() : Boolean
      {
         var _loc1_:uint = 0;
         var _loc2_:THero = null;
         var _loc3_:int = 0;
         var _loc4_:TInventory = null;
         _loc1_ = uint(this.F_Last_Hero.AccessoryMounted.Capacity);
         _loc3_ = 0;
         while(_loc3_ < _loc1_)
         {
            _loc4_ = this.F_Last_Hero.AccessoryMounted.GetInventoryByIndex(_loc3_);
            if(_loc4_ != null)
            {
               return true;
            }
            _loc3_++;
         }
         return false;
      }
      
      protected function CheckProp() : Boolean
      {
         var _loc1_:int = 0;
         switch(this.F_Last_Hero.ReincarnationOneOrTwo)
         {
            case 0:
               _loc1_ = this.FReincarnationBaseData.StuffNeedOne;
               break;
            case 1:
               _loc1_ = this.FReincarnationBaseData.StuffNeedTwo;
         }
         return _loc1_ > this.getInventoryById();
      }
      
      protected function getInventoryById() : int
      {
         var _loc1_:TInventories = SLogicsCore.Character.Appliances;
         if(this.F_Last_Hero.ReincarnationOneOrTwo < 2)
         {
            return _loc1_.GetAllCountByTempletID(this.FReincarnationBaseData.ReinCarnationNeedStuffId);
         }
         return _loc1_.GetAllCountByTempletID(this.FReincarnationBaseData.ReinCarnationNeedStuffIdThree);
      }
      
      protected function ProcessorEffectAcquireInventory() : void
      {
         var _loc2_:TSkillConfig = null;
         var _loc3_:TSkill = null;
         var _loc4_:TCoordinate = null;
         var _loc5_:String = null;
         if(this.FReincarnationBaseData.ReincarnationGetSkill.length == 0)
         {
            return;
         }
         if(this.FOnQueryShortcutCoordinate != null)
         {
            this.FOnQueryShortcutCoordinate(this,CONST_SHORTCUTS.POSITION_Function,CONST_SHORTCUTS.TYPE_Function_TacticalDeployment,this.FQueryCoordinate);
         }
         var _loc1_:int = 0;
         while(_loc1_ < this.FReincarnationBaseData.ReincarnationGetSkill.length)
         {
            _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SkillConfig,this.FReincarnationBaseData.ReincarnationGetSkill[_loc1_]) as TSkillConfig;
            _loc3_ = SLogicsCore.PoolSkill.Acquire(_loc2_.Identifier);
            _loc3_.IDTexture = _loc2_.Icon;
            _loc4_ = new TCoordinate();
            _loc4_.X = FUICore.StageWidth / 2;
            _loc4_.Y = FUICore.StageHeight / 2;
            this.FEffectCoordinateParameters.CoordinateSource.Assign(_loc4_);
            this.FEffectCoordinateParameters.CoordinateDestination.Assign(this.FQueryCoordinate.Value);
            if(this.FOnEffectForSkill != null)
            {
               this.FOnEffectForSkill(this,_loc3_,this.FEffectCoordinateParameters);
            }
            _loc5_ = TUtilityString.Format(STRING_NINJIAREINCARNATION.LevelLv_Get_Skill_Describe,_loc2_.Name);
            EffectGenerateText(_loc5_);
            _loc1_++;
         }
      }
      
      public function get OnEffectForSkill() : Function
      {
         return this.FOnEffectForSkill;
      }
      
      public function set OnEffectForSkill(param1:Function) : void
      {
         this.FOnEffectForSkill = param1;
      }
      
      public function get OnQueryShortcutCoordinate() : Function
      {
         return this.FOnQueryShortcutCoordinate;
      }
      
      public function set OnQueryShortcutCoordinate(param1:Function) : void
      {
         this.FOnQueryShortcutCoordinate = param1;
      }
      
      public function ResetSlot() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < SLOT_COUNT)
         {
            this.FSlotList[_loc1_].Context = null;
            _loc1_++;
         }
      }
   }
}

