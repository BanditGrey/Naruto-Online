package Processors.Game.Lobby.Inspector
{
   import Components.Pages.TUIPage;
   import Components.Slots.TUISlot;
   import Components.Standard.TUITab;
   import Foundation.Common.Integer.UInt64;
   import Foundation.Common.TBounds;
   import Foundation.Common.TCoordinate;
   import Foundation.Common.THint;
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
   import Logics.DatebaseVO.VO.TBaseEquip;
   import Logics.DatebaseVO.VO.TBaseHero;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.DatebaseVO.VO.THeroExp;
   import Logics.DatebaseVO.VO.TMewMagic;
   import Logics.DatebaseVO.VO.TOrnamentBuildConsume;
   import Logics.DatebaseVO.VO.TRoleModel;
   import Logics.DatebaseVO.VO.TSoulArray;
   import Logics.DatebaseVO.VO.TSuit;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.Inventories.TCollectionInventory;
   import Logics.Inventories.TEquipment;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.Skills.TSkill;
   import Logics.Skills.TSkills;
   import Logics.Wing.TWing;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.Components.TUIHero;
   import Rendering.Overlayers.NinJaPractice.TOverlayerNinJaAwake;
   import Rendering.Overlayers.Pet.TOverlayerSoulFormation;
   import Rendering.Overlayers.PurpleNinja.TOverJinJaPracticeLink;
   import Rendering.Overlayers.TongLingAnimal.TongLingOtherMsgCopy;
   import Rendering.Overlayers.Wing.TOverlayerWing;
   import Resources.Constants.CONST_CHARACTER;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_CONFIGVALUE;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_HEROS;
   import Resources.Constants.CONST_INVENTORY;
   import Resources.Constants.CONST_MODULES;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_HEROS;
   import Resources.Strings.STRING_INVENTORY;
   import Resources.Strings.STRING_SHORTCUTS;
   import Resources.Strings.STRING_TAVERN;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   
   public class TProcessorWindowHeroInfor extends TProcessorLobbyWindow
   {
      
      public static const STAGE_Widt5h:Number = CONST_COMMON.STAGE_Width;
      
      public static const STAGE_Height:Number = CONST_COMMON.STAGE_Height;
      
      public static const SIZE_SingleComboHeight:Number = CONST_HEROS.SIZE_SingleComboHeight;
      
      public static const SIZE_ComboboxHeight:Number = CONST_HEROS.SIZE_ComboboxHeight;
      
      public static const CAPACITY_TF_HerosName:uint = CONST_HEROS.CAPACITY_TF_HerosName;
      
      public static const CAPACITY_MC_SlotsEquipment:uint = CONST_HEROS.CAPACITY_MC_SlotsEquipment;
      
      public static const CAPACITY_MC_SlotsAccessory:uint = CONST_HEROS.CAPACITY_MC_SlotsAccessory;
      
      public static const CAPACITY_TF_BaseAttributes:uint = CONST_HEROS.CAPACITY_TF_BaseAttributes;
      
      public static const CAPACITY_Backpack_Slots:uint = CONST_HEROS.CAPACITY_Backpack_Slots;
      
      public static const CAPACITY_EquipmentsMounted_Slots:uint = CONST_HEROS.CAPACITY_EquipmentsMounted_Slots;
      
      public static const CATEGORY_Normal:uint = CONST_INVENTORY.CATEGORY_Normal;
      
      public static const CATEGORY_Equipment:uint = CONST_INVENTORY.CATEGORY_Equipment;
      
      public static const CATEGORYSECOND_ExperienceReel:uint = CONST_INVENTORY.CATEGORYSECOND_ExperienceReel;
      
      public static const CATEGORYSECOND_MainHeroExperienceReel:uint = CONST_INVENTORY.CATEGORYSECOND_MainHeroExperienceReel;
      
      public static const CATEGORY_TreasurePower:uint = CONST_INVENTORY.CATEGORYSECOND_TreasurePower;
      
      public static const PROFESSION_Agility:uint = CONST_CHARACTER.PROFESSION_Agility;
      
      public static const PROFESSION_Defending:uint = CONST_CHARACTER.PROFESSION_Defending;
      
      public static const PROFESSION_Intellect:uint = CONST_CHARACTER.PROFESSION_Intellect;
      
      public static const PROFESSION_Strength:uint = CONST_CHARACTER.PROFESSION_Strength;
      
      public static const TACTICALDEPLOYMENTINDEX_Before:uint = CONST_HEROS.TACTICALDEPLOYMENTINDEX_Before;
      
      public static const TACTICALDEPLOYMENTINDEX_Middle:uint = CONST_HEROS.TACTICALDEPLOYMENTINDEX_Middle;
      
      public static const TACTICALDEPLOYMENTINDEX_After:uint = CONST_HEROS.TACTICALDEPLOYMENTINDEX_After;
      
      public static const INVENTORIESINDEX_Heros_Equipments:uint = CONST_COMMON.INVENTORIESINDEX_Heros_Equipments;
      
      public static const INVENTORIESINDEX_Heros_Appliances:uint = CONST_COMMON.INVENTORIESINDEX_Heros_Appliances;
      
      public static const INVENTORIESINDEX_Heros_Accessories:uint = CONST_COMMON.INVENTORIESINDEX_Heros_Accessories;
      
      public static const STRINGS_TreasuresAttributeCaption:Vector.<String> = STRING_INVENTORY.STRINGS_TreasuresAttributeCaption;
      
      public static const STRING_TabCaption_Equipment:String = STRING_HEROS.STRING_TabCaption_Equipment;
      
      public static const STRING_TabCaption_Appliance:String = STRING_HEROS.STRING_TabCaption_Appliance;
      
      public static const STRING_TabCaption_Accessory:String = STRING_HEROS.STRING_TabCaption_Accessory;
      
      public static const STRING_FightPosition:String = STRING_HEROS.STRING_FightPosition;
      
      public static const STRING_Dismiss:String = STRING_HEROS.STRING_Dismiss;
      
      public static const FORMAT_UsePrompt:String = STRING_HEROS.FORMAT_UsePrompt;
      
      public static const FORMAT_Talisman:String = STRING_HEROS.FORMAT_Talisman;
      
      public static const FORMAT_Level:String = STRING_HEROS.FORMAT_Level;
      
      public static const FORMAT_Profession:String = STRING_HEROS.FORMAT_Profession;
      
      public static const FORMAT_Experience:String = STRING_HEROS.FORMAT_Experience;
      
      public static const FORMAT_Power:String = STRING_HEROS.FORMAT_Power;
      
      public static const FORMAT_Intelligence:String = STRING_HEROS.FORMAT_Intelligence;
      
      public static const FORMAT_Agile:String = STRING_HEROS.FORMAT_Agile;
      
      public static const FORMAT_Speed:String = STRING_HEROS.FORMAT_Speed;
      
      public static const FORMAT_Health:String = STRING_HEROS.FORMAT_Health;
      
      public static const TYPE_PROFESSIONS:Vector.<String> = STRING_COMMON.TYPE_PROFESSIONS;
      
      public static const STRING_Capacity:String = CONST_COMMON.STRING_Capacity;
      
      public static const RESOURCE_Link_MC_Item:String = CONST_HEROS.RESOURCE_Link_MC_Item;
      
      protected static const QUALITYCOLOR_INDEX:Vector.<uint> = CONST_COMMON.QUALITYCOLOR_INDEX;
      
      protected static const BASEATTRIBUTENAMES:Vector.<uint> = CONST_COMMON.BASEATTRIBUTENAMES;
      
      protected static const STRINGS_BASEATTRIBUTENAMES:Vector.<String> = STRING_COMMON.STRINGS_BASEATTRIBUTENAMES;
      
      protected var FHelpTips:THint;
      
      protected var FBtn_Close:SimpleButton;
      
      protected var FMC_Heros:Sprite;
      
      protected var FUITabHeros:TUITab;
      
      protected var FTF_CurrentNumber:TextField;
      
      protected var FTF_Level:TextField;
      
      protected var FMC_Profession:MovieClip;
      
      protected var FBtn_Treasure:SimpleButton;
      
      protected var FBtn_Magic:SimpleButton;
      
      protected var FMC_HeroPosition:Sprite;
      
      protected var FTF_Experience:TextField;
      
      protected var FMC_ProgressBarExp:Sprite;
      
      protected var FTF_BaseAttributes:Vector.<TextField>;
      
      protected var FTF_FightingCapacity:TextField;
      
      protected var FTF_SkillAttack:TextField;
      
      protected var FMC_HeroSkill:MovieClip;
      
      protected var FTF_Talent:TextField;
      
      protected var FMC_Information:MovieClip;
      
      protected var FMC_CLoseInfomation:MovieClip;
      
      protected var FMC_OpenInfomation:MovieClip;
      
      protected var FMC_OpeningState:MovieClip;
      
      protected var FMC_ClosingState:MovieClip;
      
      protected var FBtn_CloseInfomation:MovieClip;
      
      protected var FBtn_OpenInfomation:MovieClip;
      
      protected var FMC_HeroPage:MovieClip;
      
      protected var FMC_TitleEffect:Sprite;
      
      protected var FMC_LittlePetEffect:Sprite;
      
      protected var FMC_BloodFete:SimpleButton;
      
      protected var FTF_TacticalDeployment:TextField;
      
      protected var FMC_Assess:MovieClip;
      
      protected var FMC_Attack:TextField;
      
      protected var FHeros:THeros;
      
      protected var FUIHero:TUIHero;
      
      protected var FInventories:TInventories;
      
      protected var FSlotsEquipmentMounted:Vector.<TUISlot>;
      
      protected var FSlotsAccessoryMounted:Vector.<TUISlot>;
      
      protected var FFilterEquipments:Vector.<Function>;
      
      protected var FFilterAppliances:Vector.<Function>;
      
      protected var FBaseAttibutes:Vector.<Number>;
      
      protected var FHeroPage:TUIPage;
      
      protected var FHeroPageIndex:int;
      
      protected var FTabHeroIndex:int;
      
      protected var FTitleAnimationID:uint;
      
      protected var FTitleBmp:Bitmap;
      
      protected var FLittlePetAnimationID:uint;
      
      protected var FLittlePetBmp:Bitmap;
      
      protected var EarLeft:MovieClip;
      
      protected var EarRight:MovieClip;
      
      protected var FInitializationSlots:Boolean;
      
      protected var FHint:THint;
      
      protected var FClickNum:uint;
      
      protected var FExperience:uint;
      
      protected var FBtnList:Vector.<MovieClip>;
      
      protected var FHeroMagicIDs:Vector.<uint>;
      
      protected var FM_Inherit:MovieClip;
      
      protected var FMvcTongLing:SimpleButton;
      
      protected var FOverTip:TOverJinJaPracticeLink;
      
      protected var FOverTipT:TongLingOtherMsgCopy;
      
      protected var FCurHero:THero;
      
      protected var FMagicOpenLv:uint;
      
      protected var FBloodFeteOpenLv:uint;
      
      protected var FUITabInventoryNew:TUITab;
      
      protected var FTabInventoryIndexNew:int;
      
      protected var FMC_Equip_Part:MovieClip;
      
      protected var FMC_Accessor_Part:MovieClip;
      
      protected var FAccessory_Suit_Arrti:TextField;
      
      protected var ValueVec:Vector.<int>;
      
      protected var FUITabInventoryNewCopy:TUITab;
      
      protected var FCurLittleTabIndex:int;
      
      protected var FMC_SoulFormation:SimpleButton;
      
      protected var FOverlayerSoulFormation:TOverlayerSoulFormation;
      
      protected var FMC_Wing:SimpleButton;
      
      protected var FOverlayerWing:TOverlayerWing;
      
      public var SoulFormationID:int;
      
      public var Wing:TWing;
      
      protected var FMC_NinJaAwake:MovieClip;
      
      protected var FOverlayerNinJaAwake:TOverlayerNinJaAwake;
      
      protected var FOnInventoryOver:Function;
      
      protected var FOnInventoryOut:Function;
      
      protected var FOnBaseAttributeOver:Function;
      
      protected var FOnBaseAttributeOut:Function;
      
      protected var FHintOnOver:Function;
      
      protected var FHintOnOut:Function;
      
      protected var FTitleHintOnOver:Function;
      
      protected var FTitleHintOnOut:Function;
      
      protected var FLittlePetOnOver:Function;
      
      protected var FLittlePetOnOut:Function;
      
      protected var FBFOnMove:Function;
      
      protected var FBFOnOut:Function;
      
      protected var FIsShowEffectNiaja:Boolean = false;
      
      protected var FEffectFatherSpr:Sprite;
      
      protected var FEffectBitmap:Bitmap;
      
      public function TProcessorWindowHeroInfor(param1:TUIComponent)
      {
         super(param1);
         this.FHelpTips = new THint();
         this.FUITabHeros = new TUITab(this);
         this.FSlotsEquipmentMounted = new Vector.<TUISlot>(CAPACITY_MC_SlotsEquipment);
         this.FSlotsAccessoryMounted = new Vector.<TUISlot>(CAPACITY_MC_SlotsAccessory);
         this.FTF_BaseAttributes = new Vector.<TextField>(CAPACITY_TF_BaseAttributes);
         this.FBaseAttibutes = new Vector.<Number>(CONST_HEROS.CAPACITY_BaseAttribute);
         this.FInventories = new TInventories();
         this.FFilterEquipments = new Vector.<Function>();
         this.FFilterAppliances = new Vector.<Function>();
         this.FHeroPage = new TUIPage(this);
         this.FHint = new THint();
         this.FBtnList = new Vector.<MovieClip>();
         this.FTitleBmp = new Bitmap();
         this.FLittlePetBmp = new Bitmap();
         this.FTitleAnimationID = 0;
         this.FLittlePetAnimationID = 0;
         this.FHeroPageIndex = 0;
         this.FTabHeroIndex = 0;
         this.FInitializationSlots = false;
         this.FHeroMagicIDs = new Vector.<uint>(3);
         this.FOverTip = new TOverJinJaPracticeLink(param1);
         this.FOverTip.visible = false;
         this.FOverTipT = TongLingOtherMsgCopy.getTipIntence(param1);
         this.FOverTipT.visible = false;
         this.FUITabInventoryNew = new TUITab(this);
         this.FUITabInventoryNewCopy = new TUITab(this);
         this.ValueVec = new Vector.<int>(4);
         this.FEffectFatherSpr = new Sprite();
         this.FEffectBitmap = new Bitmap();
         this.FEffectFatherSpr.addChild(this.FEffectBitmap);
         this.Wing = new TWing();
         this.FOverlayerNinJaAwake = new TOverlayerNinJaAwake(param1);
      }
      
      public function UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:TUISlot = null;
         var _loc5_:BitmapData = null;
         var _loc6_:TextField = null;
         var _loc7_:MovieClip = null;
         var _loc8_:TextField = null;
         var _loc9_:int = 0;
         this.FMC_Heros = TUtilityReflection.CreateDisplayObjectInstance("HeroEquipInfor") as Sprite;
         addChild(this.FMC_Heros);
         this.FBtn_Close = this.FMC_Heros[CONST_HEROS.RESOURCE_Link_Btn_Close];
         _loc2_ = int(CAPACITY_TF_HerosName);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FMC_Heros[CONST_HEROS.RESOURCE_Link_TF_HerosName + _loc1_];
            _loc3_.mouseChildren = false;
            this.FUITabHeros.SetTabByIndex(_loc3_,_loc1_);
            this.FUITabHeros.SetTabCaptionByIndex("",_loc1_);
            _loc1_++;
         }
         this.FUITabHeros.OnSwitch = this.TabHerosOnSwitch;
         this.FUITabHeros.Init();
         this.FTF_CurrentNumber = this.FMC_Heros[CONST_HEROS.RESOURCE_Link_TF_CurrentNumber];
         this.FTF_Level = this.FMC_Heros[CONST_HEROS.RESOURCE_Link_TF_Level];
         this.FTF_Level.mouseEnabled = false;
         this.FMC_Profession = this.FMC_Heros[CONST_HEROS.RESOURCE_Link_MC_Profession];
         this.FBtn_Treasure = this.FMC_Heros[CONST_HEROS.RESOURCE_Link_Btn_Treasure];
         this.FMC_HeroPosition = this.FMC_Heros[CONST_HEROS.RESOURCE_Link_MC_HeroPosition] as Sprite;
         this.FMC_Attack = this.FMC_Heros[CONST_HEROS.CAPACITY_MC_PartEquipment][CONST_HEROS.RESOURCE_Link_MC_Attack];
         this.FMC_Equip_Part = this.FMC_Heros[CONST_HEROS.CAPACITY_MC_PartEquipment];
         this.FMC_Accessor_Part = this.FMC_Heros[CONST_HEROS.CAPACITY_MC_PartAccesspory];
         _loc3_ = this.FMC_Heros[CONST_HEROS.RESOURCE_MC_Tab_Equipment_R];
         _loc3_.mouseChildren = false;
         this.FUITabInventoryNew.SetTabByIndex(_loc3_,0);
         this.FUITabInventoryNew.SetTabCaptionByIndex(STRING_TabCaption_Equipment,0);
         _loc3_ = this.FMC_Heros[CONST_HEROS.RESOURCE_MC_Tab_Accessory_R];
         _loc3_.mouseChildren = false;
         this.FUITabInventoryNew.SetTabByIndex(_loc3_,1);
         this.FUITabInventoryNew.SetTabCaptionByIndex(STRING_TabCaption_Accessory,1);
         this.FUITabInventoryNew.OnSwitch = this.TabInventoryOnSwitchNew;
         this.FUITabInventoryNew.Init();
         _loc2_ = int(CAPACITY_MC_SlotsEquipment);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc4_ = new TUISlot(this);
            _loc4_.Resource = this.FMC_Heros[CONST_HEROS.CAPACITY_MC_PartEquipment][CONST_HEROS.RESOURCE_Link_MC_SlotsEquipment + _loc1_] as Sprite;
            _loc4_.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
            _loc4_.Tag = _loc1_;
            _loc4_.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
            _loc4_.OnQueryEuqipLevel = this.SlotsOnQueryEuqipLevel;
            _loc4_.OnOverlay = this.SlotsOnMove;
            _loc4_.OnOut = this.SlotsOnOut;
            _loc4_.Init();
            this.FSlotsEquipmentMounted[_loc1_] = _loc4_;
            _loc1_++;
         }
         this.FAccessory_Suit_Arrti = this.FMC_Heros[CONST_HEROS.CAPACITY_MC_PartAccesspory]["TF_Suit_value"];
         _loc2_ = int(CAPACITY_MC_SlotsAccessory);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc4_ = new TUISlot(this);
            _loc4_.Resource = this.FMC_Heros[CONST_HEROS.CAPACITY_MC_PartAccesspory][CONST_HEROS.RESOURCE_Link_MC_SlotsEquipment + _loc1_] as Sprite;
            _loc4_.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
            _loc4_.Tag = _loc1_;
            _loc4_.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
            _loc4_.OnQueryEuqipLevel = this.SlotsOnQueryEuqipLevel;
            _loc4_.OnOverlay = this.SlotsOnMove;
            _loc4_.OnOut = this.SlotsOnOut;
            _loc4_.Init();
            this.FSlotsAccessoryMounted[_loc1_] = _loc4_;
            _loc1_++;
         }
         this.FTF_Experience = this.FMC_Heros[CONST_HEROS.RESOURCE_Link_TF_Experience];
         this.FMC_ProgressBarExp = this.FMC_Heros[CONST_HEROS.RESOURCE_Link_MC_ProgressBarExp] as Sprite;
         _loc2_ = int(CAPACITY_TF_BaseAttributes);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc6_ = this.FMC_Heros[CONST_HEROS.CAPACITY_MC_PartEquipment][CONST_HEROS.RESOURCE_Link_TF_BaseAttributes + _loc1_];
            this.FTF_BaseAttributes[_loc1_] = _loc6_;
            _loc1_++;
         }
         this.FTF_FightingCapacity = this.FMC_Heros[CONST_HEROS.RESOURCE_Link_TF_FightingCapacity];
         this.FMC_HeroSkill = this.FMC_Heros[CONST_HEROS.CAPACITY_MC_PartEquipment][CONST_HEROS.RESOURCE_Link_MC_HeroSkill];
         this.FTF_SkillAttack = this.FMC_HeroSkill[CONST_HEROS.RESOURCE_Link_TF_SkillAttack];
         this.FTF_Talent = this.FMC_Heros[CONST_HEROS.CAPACITY_MC_PartEquipment][CONST_HEROS.RESOURCE_Link_TF_Talent];
         this.FTF_TacticalDeployment = this.FMC_Heros[CONST_HEROS.CAPACITY_MC_PartEquipment][CONST_HEROS.RESOURCE_Link_TF_TacticalDeployment];
         this.FInitializationSlots = true;
         this.FUIHero = new TUIHero(this);
         this.FMC_HeroPosition.addChild(this.FUIHero);
         this.FUIHero.OnQuerySequenceContext = this.HeroOnQuerySequenceContext;
         this.FUIHero.DefaultRole = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_DefaultRoleTexture) as Sprite;
         this.FMC_HeroPosition.addChild(this.FEffectFatherSpr);
         this.FMC_Assess = this.FMC_Heros[CONST_HEROS.RESOURCE_Link_MC_Assess];
         this.EarLeft = this.FMC_Heros["MC_Ear_0"];
         this.EarRight = this.FMC_Heros["MC_Ear_1"];
         this.FMC_Information = this.FMC_Heros[CONST_HEROS.RESOURCE_Link_MC_Information];
         this.FMC_OpenInfomation = this.FMC_Information[CONST_HEROS.RESOURCE_Link_MC_OpenInfomation];
         this.FMC_OpenInfomation.visible = false;
         this.FMC_ClosingState = this.FMC_OpenInfomation[CONST_HEROS.RESOURCE_Link_MC_ClosingState];
         this.FBtn_CloseInfomation = this.FMC_OpenInfomation[CONST_HEROS.RESOURCE_Link_Btn_CloseInfomation];
         TGameUtil.setButtonMode(this.FBtn_CloseInfomation,true);
         this.FMC_CLoseInfomation = this.FMC_Information[CONST_HEROS.RESOURCE_Link_MC_CLoseInfomation];
         this.FMC_CLoseInfomation.visible = true;
         this.FMC_OpeningState = this.FMC_CLoseInfomation[CONST_HEROS.RESOURCE_Link_MC_OpeningState];
         this.FBtn_OpenInfomation = this.FMC_CLoseInfomation[CONST_HEROS.RESOURCE_Link_Btn_OpenInfomation];
         TGameUtil.setButtonMode(this.FBtn_OpenInfomation,true);
         this.FMC_HeroPage = this.FMC_Heros[CONST_HEROS.RESOURCE_Link_MC_HeroPage];
         _loc7_ = this.FMC_HeroPage[CONST_HEROS.RESOURCE_Link_MC_PageLeft];
         this.FHeroPage.ButtonPrevious.Substrate = _loc7_;
         _loc7_ = this.FMC_HeroPage[CONST_HEROS.RESOURCE_Link_MC_PageRight];
         this.FHeroPage.ButtonNext.Substrate = _loc7_;
         _loc8_ = this.FMC_HeroPage[CONST_HEROS.RESOURCE_Link_TF_Page];
         this.FHeroPage.LabelPage = _loc8_;
         _loc8_.text = "0/0";
         this.FHeroPage.PageSize = CONST_HEROS.CAPACITY_TF_HerosName;
         this.FHeroPage.Init();
         this.FMC_HeroPage.visible = true;
         this.FMC_TitleEffect = this.FMC_Heros["MC_TitleEffect"];
         this.FMC_TitleEffect.addChild(this.FTitleBmp);
         this.FMC_LittlePetEffect = this.FMC_Heros["MC_LittlePetEffect"];
         this.FMC_LittlePetEffect.addChild(this.FLittlePetBmp);
         this.FMC_BloodFete = this.FMC_Heros["MC_BloodFete"];
         this.FMC_SoulFormation = this.FMC_Heros["MC_SoulFormation"];
         this.FMC_Wing = this.FMC_Heros["MC_Wing"];
         this.FBtn_Magic = this.FMC_Heros["Btn_Magic"];
         this.FM_Inherit = this.FMC_Heros["qianneng"] as MovieClip;
         TextField(this.FMC_Heros["qianneng"]["MVC_tem"]["TF_FightingCapacity"]).mouseEnabled = false;
         this.FMvcTongLing = this.FMC_Heros["M_TongLing"] as SimpleButton;
         this.FMC_NinJaAwake = this.FMC_Heros["MC_Awake"];
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverTip);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverTipT);
         _loc3_ = this.FMC_ClosingState["MC_Pve"];
         if(_loc3_)
         {
            this.FUITabInventoryNewCopy.SetTabByIndex(_loc3_,0);
            _loc3_ = this.FMC_ClosingState["MC_Pvp"];
            this.FUITabInventoryNewCopy.SetTabByIndex(_loc3_,1);
            this.FUITabInventoryNewCopy.OnSwitch = this.TabInventoryOnSwitchNewCopy;
            this.FUITabInventoryNewCopy.Init();
         }
         this.FOverlayerSoulFormation = new TOverlayerSoulFormation(this.Parent);
         this.FOverlayerSoulFormation.Visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerSoulFormation);
         this.FOverlayerWing = new TOverlayerWing(this.Parent);
         this.FOverlayerWing.Visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerWing);
      }
      
      protected function TabInventoryOnSwitchNew(param1:Object) : void
      {
         this.FTabInventoryIndexNew = param1 as int;
         this.UpdateEquipAccessory(this.FTabInventoryIndexNew);
      }
      
      public function UpdateEquipAccessory(param1:int) : void
      {
         this.FMC_Equip_Part.visible = param1 == 0 ? true : false;
         this.FMC_Accessor_Part.visible = param1 == 1 ? true : false;
      }
      
      public function INOver(param1:MouseEvent) : void
      {
         this.FOverTip.Context = this.FCurHero;
         this.FOverTip.Render(FUICore.MouseCoordinate);
         this.FOverTip.Show();
      }
      
      public function INOut(param1:MouseEvent) : void
      {
         this.FOverTip.Hide();
      }
      
      public function InOverT(param1:MouseEvent) : void
      {
         this.FMC_LittlePetEffect.filters = [new GlowFilter(3394560,1,5,5,20)];
         this.FOverTipT.Context = this.FHeros.GetHeroByIndex(0).Level;
         this.FOverTipT.Render(FUICore.MouseCoordinate);
         this.FOverTipT.Show();
      }
      
      public function InOutT(param1:MouseEvent) : void
      {
         this.FMC_LittlePetEffect.filters = [];
         this.FOverTipT.Hide();
      }
      
      public function set BFOnMove(param1:Function) : void
      {
         this.FBFOnMove = param1;
      }
      
      public function set BFOnOut(param1:Function) : void
      {
         this.FBFOnOut = param1;
      }
      
      protected function BloodFeteOnOver(param1:MouseEvent) : void
      {
         if(this.FBFOnMove != null)
         {
            this.FBFOnMove(this.FCurHero);
         }
      }
      
      protected function BloodFeteOnOut(param1:MouseEvent) : void
      {
         if(this.FBFOnOut != null)
         {
            this.FBFOnOut();
         }
      }
      
      protected function SoulFormationOnOver(param1:MouseEvent) : void
      {
         var _loc2_:TSystemLanguage = null;
         var _loc3_:TSoulArray = null;
         if(this.SoulFormationID != 0)
         {
            _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SoulArray,this.SoulFormationID) as TSoulArray;
            this.FOverlayerSoulFormation.Context = _loc3_;
            this.FOverlayerSoulFormation.Render(FUICore.MouseCoordinate);
            this.FOverlayerSoulFormation.Show();
         }
         else
         {
            _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,70101031) as TSystemLanguage;
            this.FHint.Caption = _loc2_.Desc;
            if(this.FHintOnOver != null)
            {
               this.FHintOnOver(this,this.FHint);
            }
         }
      }
      
      protected function SoulFormationOnOut(param1:MouseEvent) : void
      {
         this.FOverlayerSoulFormation.Hide();
      }
      
      protected function WingOnOver(param1:MouseEvent) : void
      {
         var _loc2_:TSoulArray = null;
         if(this.Wing != null && this.Wing.WingID != 0)
         {
            this.FOverlayerWing.Context = this.Wing;
            this.FOverlayerWing.Render(FUICore.MouseCoordinate);
            this.FOverlayerWing.Show();
         }
      }
      
      protected function WingOnOut(param1:MouseEvent) : void
      {
         this.FOverlayerWing.Hide();
      }
      
      protected function NinJaAwakeOver(param1:MouseEvent) : void
      {
         this.FOverlayerNinJaAwake.Render(FUICore.MouseCoordinate);
         this.FOverlayerNinJaAwake.Show();
      }
      
      protected function NinJaAwakeOut(param1:MouseEvent) : void
      {
         this.FOverlayerNinJaAwake.Hide();
      }
      
      public function UILocations() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TextField = null;
         var _loc4_:TConfigValue = null;
         var _loc5_:int = 0;
         this.FM_Inherit.addEventListener(MouseEvent.MOUSE_MOVE,this.INOver);
         this.FM_Inherit.addEventListener(MouseEvent.MOUSE_OUT,this.INOut);
         this.FMvcTongLing.addEventListener(MouseEvent.MOUSE_MOVE,this.InOverT);
         this.FMvcTongLing.addEventListener(MouseEvent.MOUSE_OUT,this.InOutT);
         this.FBtn_Close.addEventListener(MouseEvent.CLICK,this.ButtonCloseOnClick,false,0,true);
         this.FBtn_Treasure.addEventListener(MouseEvent.MOUSE_MOVE,this.BtnTreasureHintOnOver,false,0,true);
         this.FBtn_Treasure.addEventListener(MouseEvent.MOUSE_OUT,this.BtnTreasureHintOnOut,false,0,true);
         if(this.FBtn_Magic != null)
         {
            this.FBtn_Magic.addEventListener(MouseEvent.MOUSE_MOVE,this.BtnMagicHintOnOver,false,0,true);
            this.FBtn_Magic.addEventListener(MouseEvent.MOUSE_OUT,this.BtnMagicHintOnOut,false,0,true);
         }
         if(this.FMC_BloodFete != null)
         {
            this.FMC_BloodFete.addEventListener(MouseEvent.MOUSE_MOVE,this.BloodFeteOnOver,false,0,true);
            this.FMC_BloodFete.addEventListener(MouseEvent.MOUSE_OUT,this.BloodFeteOnOut,false,0,true);
         }
         if(this.FMC_SoulFormation != null)
         {
            this.FMC_SoulFormation.addEventListener(MouseEvent.MOUSE_MOVE,this.SoulFormationOnOver,false,0,true);
            this.FMC_SoulFormation.addEventListener(MouseEvent.MOUSE_OUT,this.SoulFormationOnOut,false,0,true);
         }
         if(this.FMC_Wing != null)
         {
            this.FMC_Wing.addEventListener(MouseEvent.MOUSE_MOVE,this.WingOnOver);
            this.FMC_Wing.addEventListener(MouseEvent.ROLL_OUT,this.WingOnOut);
         }
         this.FTF_FightingCapacity.addEventListener(MouseEvent.MOUSE_MOVE,this.TFFightingCapacityOnMove,false,0,true);
         this.FTF_FightingCapacity.addEventListener(MouseEvent.MOUSE_OUT,this.TFFightingCapacityOnOut,false,0,true);
         this.FBtn_OpenInfomation.addEventListener(MouseEvent.CLICK,this.BtnOpenInfomationOnClick,false,0,true);
         this.FBtn_CloseInfomation.addEventListener(MouseEvent.CLICK,this.BtnCloseInfomationOnClick,false,0,true);
         _loc2_ = int(CAPACITY_TF_BaseAttributes);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FTF_BaseAttributes[_loc1_];
            _loc3_.addEventListener(MouseEvent.MOUSE_MOVE,this.TFBaseAttributesHintOnOver,false,0,true);
            _loc3_.addEventListener(MouseEvent.MOUSE_OUT,this.TFHintOnOut,false,0,true);
            _loc1_++;
         }
         this.FTF_Talent.addEventListener(MouseEvent.MOUSE_MOVE,this.TFTalentHintOnOver,false,0,true);
         this.FTF_Talent.addEventListener(MouseEvent.MOUSE_OUT,this.TFHintOnOut,false,0,true);
         this.FMC_Assess.addEventListener(MouseEvent.MOUSE_MOVE,this.MC_AssessHintOnOver,false,0,true);
         this.FMC_Assess.addEventListener(MouseEvent.MOUSE_OUT,this.TFHintOnOut,false,0,true);
         this.FTF_SkillAttack.addEventListener(MouseEvent.MOUSE_MOVE,this.TFSkillAttackHintOnOver,false,0,true);
         this.FTF_SkillAttack.addEventListener(MouseEvent.MOUSE_OUT,this.TFHintOnOut,false,0,true);
         this.addEventListener(MouseEvent.MOUSE_DOWN,this.OnMouseDown);
         this.addEventListener(MouseEvent.MOUSE_UP,this.OnMouseUP);
         this.FMC_TitleEffect.addEventListener(MouseEvent.MOUSE_MOVE,this.MCTitleEffectOnOver,false,0,true);
         this.FMC_TitleEffect.addEventListener(MouseEvent.MOUSE_OUT,this.MCTitleEffectOnOut,false,0,true);
         this.FMC_LittlePetEffect.addEventListener(MouseEvent.MOUSE_MOVE,this.InOverT,false,0,true);
         this.FMC_LittlePetEffect.addEventListener(MouseEvent.MOUSE_OUT,this.InOutT,false,0,true);
         if(this.FMC_NinJaAwake)
         {
            this.FMC_NinJaAwake.addEventListener(MouseEvent.MOUSE_MOVE,this.NinJaAwakeOver);
            this.FMC_NinJaAwake.addEventListener(MouseEvent.MOUSE_OUT,this.NinJaAwakeOut);
            TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerNinJaAwake);
         }
         this.FHeroPage.OnChangePage = this.HeroPageOnChange;
         this.x = (STAGE_Width - this.width) / 2;
         this.y = (STAGE_Height - this.height) / 2;
         super.ResourcesPerform_UILocations();
      }
      
      override protected function ResourcesPerform_UIFinalize() : void
      {
         var _loc1_:TConfigValue = null;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.Mew_OpenLv) as TConfigValue;
         this.FMagicOpenLv = _loc1_.Value as uint;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.FollowBloodBound_Function_OpenLevel) as TConfigValue;
         this.FBloodFeteOpenLv = _loc1_.Value as uint;
         super.ResourcesPerform_UIFinalize();
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         if(!this.FInitializationSlots)
         {
            return;
         }
         if(!Visible)
         {
            return;
         }
         this.UpdateTitleEffect();
         this.UpdateLittlePetEffect();
         this.ProcessorUpdateSlotsRenderingState();
         this.FUIHero.Update();
         if(this.FMC_CLoseInfomation.visible)
         {
            if(this.FMC_CLoseInfomation.currentFrame == this.FMC_CLoseInfomation.totalFrames)
            {
               this.FMC_CLoseInfomation.visible = false;
               this.FMC_CLoseInfomation.gotoAndStop(1);
               this.FMC_OpenInfomation.visible = true;
               this.FMC_OpenInfomation.gotoAndStop(1);
            }
         }
         if(this.FMC_OpenInfomation.visible)
         {
            if(this.FMC_OpenInfomation.currentFrame == this.FMC_OpenInfomation.totalFrames)
            {
               this.FMC_OpenInfomation.visible = false;
               this.FMC_OpenInfomation.gotoAndStop(1);
               this.FMC_CLoseInfomation.visible = true;
               this.FMC_CLoseInfomation.gotoAndStop(1);
            }
         }
         this.upDateEffectImage();
      }
      
      protected function UpdateTitleEffect() : void
      {
         var _loc1_:TCoordinate = null;
         if(this.FTitleAnimationID != 0)
         {
            _loc1_ = TGameUtil.ShowAnimationByID(TGameUtil.Type_UserTitle,this.FTitleBmp,CONST_MODULES.MODULE_HeroInfo,this.FTitleAnimationID);
         }
         else
         {
            this.FTitleBmp.bitmapData = null;
         }
      }
      
      protected function UpdateLittlePetEffect() : void
      {
         var _loc1_:TCoordinate = null;
         if(this.FLittlePetAnimationID != 0)
         {
            _loc1_ = TGameUtil.ShowAnimationByID(TGameUtil.Type_LittlePet,this.FLittlePetBmp,CONST_MODULES.MODULE_HeroInfo,this.FLittlePetAnimationID);
         }
         else
         {
            this.FLittlePetBmp.bitmapData = null;
         }
      }
      
      protected function ProcessorUpdateSlotsRenderingState() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TUISlot = null;
         _loc2_ = int(CAPACITY_MC_SlotsEquipment);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FSlotsEquipmentMounted[_loc1_];
            _loc3_.Update();
            _loc1_++;
         }
         _loc2_ = int(CAPACITY_MC_SlotsAccessory);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FSlotsAccessoryMounted[_loc1_];
            _loc3_.Update();
            _loc1_++;
         }
      }
      
      protected function HeroOnQuerySequenceContext(param1:Object, param2:Object, param3:TQueryAnimationSequence, param4:uint = 0) : void
      {
         var _loc5_:THero = null;
         var _loc6_:TResourceRepositoryTexture = null;
         var _loc7_:TTexture = null;
         var _loc8_:TBounds = null;
         var _loc9_:TCoordinate = null;
         var _loc10_:TRoleModel = null;
         _loc5_ = param2 as THero;
         _loc8_ = new TBounds();
         _loc9_ = new TCoordinate();
         _loc6_ = SResourcesCore.TexturesModel;
         _loc10_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_RoleModel,_loc5_.Identifier) as TRoleModel;
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
            _loc6_.LoadSecondary(_loc10_.Model,CONST_MODULES.MODULE_HeroInfo);
            this.FUIHero.X = 0;
            this.FUIHero.Y = 0;
         }
         if(_loc5_.Identifier != this.FHeros.GetHeroByIndex(0).Identifier)
         {
            if(_loc5_.ReincarnationOneOrTwo >= 1)
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
      
      protected function SetBaseAttributeByIndex(param1:String, param2:int) : void
      {
         var _loc3_:TextField = null;
         _loc3_ = this.FTF_BaseAttributes[param2] as TextField;
         if(_loc3_.text != param1)
         {
            _loc3_.text = param1;
         }
      }
      
      protected function UpdateHeroUIPage() : void
      {
         this.FHeroPageIndex = 0;
         this.FHeroPage.TotalQuantity = this.FHeros.Count;
         this.FHeroPage.PageIndex = this.FHeroPageIndex;
         this.FHeroPage.Update();
      }
      
      protected function UpdateTabs() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:THero = null;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         this.FHeros.Sort();
         _loc2_ = this.FHeros.Count;
         _loc1_ = 0;
         while(_loc1_ < CAPACITY_TF_HerosName)
         {
            _loc5_ = _loc1_ + this.FHeroPageIndex * CAPACITY_TF_HerosName;
            if(_loc5_ >= _loc2_)
            {
               this.FUITabHeros.SetTabHideByIndex(_loc1_);
            }
            else
            {
               _loc3_ = this.FHeros.GetHeroByIndex(_loc5_);
               _loc4_ = QUALITYCOLOR_INDEX[_loc3_.Quality];
               this.FUITabHeros.SetTabCaptionByIndex(_loc3_.Name,_loc1_,_loc4_);
               this.FUITabHeros.SetTabShowByIndex(_loc1_);
            }
            _loc1_++;
         }
         this.FTF_CurrentNumber.text = _loc2_.toString();
      }
      
      protected function LoadHeroQuality() : void
      {
         var _loc1_:int = 0;
         var _loc2_:THero = null;
         var _loc3_:TBaseHero = null;
         _loc1_ = 1;
         while(_loc1_ < this.FHeros.Count)
         {
            _loc2_ = this.FHeros.GetHeroByIndex(_loc1_);
            _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BaseHero,_loc2_.Identifier) as TBaseHero;
            _loc2_.Quality = _loc3_.Quality;
            _loc1_++;
         }
      }
      
      protected function UpdateRoleModel() : void
      {
         var _loc1_:THero = null;
         var _loc2_:TBaseHero = null;
         if(this.FHeros.Count <= this.FTabHeroIndex)
         {
            this.FTabHeroIndex = 0;
         }
         _loc1_ = this.FHeros.GetHeroByIndex(this.FTabHeroIndex);
         this.FUIHero.Context = _loc1_;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BaseHero,_loc1_.Identifier) as TBaseHero;
         this.FMC_Assess.gotoAndStop(_loc2_.Assess);
      }
      
      protected function CharacterUpdateBaseInfo() : void
      {
         var _loc1_:int = 0;
         var _loc2_:THero = null;
         var _loc3_:uint = 0;
         var _loc4_:THeroExp = null;
         var _loc5_:UInt64 = null;
         var _loc6_:UInt64 = null;
         var _loc7_:Number = NaN;
         var _loc8_:int = 0;
         _loc1_ = this.FTabHeroIndex;
         _loc2_ = this.FHeros.GetHeroByIndex(_loc1_);
         _loc3_ = _loc2_.Level;
         this.FTF_Level.text = _loc2_.GetLevelStrByLevel(_loc3_);
         this.FMC_Profession.gotoAndStop(_loc2_.Profession);
         _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_HeroExp,_loc3_) as THeroExp;
         _loc5_ = _loc2_.Experience;
         _loc6_ = _loc4_.NeedExp;
         this.FTF_Experience.text = TUtilityString.Format(STRING_SHORTCUTS.FORMAT_Experience,_loc5_.ToString(),_loc6_.ToString());
         _loc7_ = _loc5_.ToNumber() / _loc6_.ToNumber();
         if(_loc7_ > 1)
         {
            _loc7_ = 1;
         }
         this.FMC_ProgressBarExp.scaleX = _loc7_;
         this.FTF_Talent.text = _loc2_.TalentName;
         this.FOverlayerNinJaAwake.Context = _loc2_;
         this.FMC_NinJaAwake.visible = _loc2_.AwakeLevel > 0;
         switch(_loc2_.Profession)
         {
            case PROFESSION_Agility:
            case PROFESSION_Strength:
               _loc8_ = int(TACTICALDEPLOYMENTINDEX_Middle);
               break;
            case PROFESSION_Defending:
               _loc8_ = int(TACTICALDEPLOYMENTINDEX_Before);
               break;
            case PROFESSION_Intellect:
               if(_loc2_.IsMain)
               {
                  _loc8_ = int(TACTICALDEPLOYMENTINDEX_Middle);
               }
               else
               {
                  _loc8_ = int(TACTICALDEPLOYMENTINDEX_After);
               }
         }
         switch(_loc8_)
         {
            case 1:
               this.FTF_TacticalDeployment.text = STRING_TAVERN.GeneralBefor;
               break;
            case 2:
               this.FTF_TacticalDeployment.text = STRING_TAVERN.GeneralMiddle;
               break;
            case 3:
               this.FTF_TacticalDeployment.text = STRING_TAVERN.GeneralAfter;
         }
      }
      
      protected function CharacterUpdateBaseAttributes() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:THero = null;
         var _loc5_:String = null;
         var _loc6_:TextField = null;
         var _loc7_:Vector.<String> = null;
         _loc3_ = this.FTabHeroIndex;
         _loc7_ = new Vector.<String>();
         _loc4_ = this.FHeros.GetHeroByIndex(_loc3_);
         _loc2_ = int(CAPACITY_TF_BaseAttributes);
         if(_loc4_.Profession == 3 || _loc4_.Profession == 5)
         {
            this.FMC_Attack.text = STRING_COMMON.STRINGS_OVERLAYERBASEATTRIBUTENAMES[7];
            _loc5_ = _loc4_.BaseAttributeMagicAttack.toString();
         }
         else
         {
            this.FMC_Attack.text = STRING_COMMON.STRINGS_OVERLAYERBASEATTRIBUTENAMES[6];
            _loc5_ = _loc4_.BaseAttributePhysicalAttack.toString();
         }
         _loc7_.push(_loc5_);
         _loc5_ = _loc4_.BaseAttributePhysicalDefends.toString();
         _loc7_.push(_loc5_);
         _loc5_ = _loc4_.BaseAttributeHurt + "%";
         _loc7_.push(_loc5_);
         _loc5_ = _loc4_.BaseAttributeMagicDefends.toString();
         _loc7_.push(_loc5_);
         _loc5_ = _loc4_.BaseAttributeHealth.toString();
         _loc7_.push(_loc5_);
         _loc5_ = _loc4_.BaseAttributeSpeed.toString();
         _loc7_.push(_loc5_);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.SetBaseAttributeByIndex(_loc7_[_loc1_],_loc1_);
            _loc1_++;
         }
         this.FTF_FightingCapacity.text = _loc4_.BaseAttributeFightingPower.toString();
      }
      
      protected function InventoriesUpdateEquipmentsMounted() : void
      {
         var _loc1_:int = 0;
         var _loc2_:THero = null;
         _loc1_ = this.FTabHeroIndex;
         _loc2_ = this.FHeros.GetHeroByIndex(_loc1_);
         this.InventoriesUpdateSlotsByCollection(this.FSlotsEquipmentMounted,_loc2_.EquipmentsMounted);
         this.InventoriesUpdateSlotsByCollection(this.FSlotsAccessoryMounted,_loc2_.AccessoryMounted);
      }
      
      protected function CharacterUpdateSkills() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:THero = null;
         var _loc5_:TSkill = null;
         var _loc6_:TSkills = null;
         var _loc7_:MovieClip = null;
         _loc3_ = this.FTabHeroIndex;
         this.FMC_HeroSkill.visible = false;
         _loc4_ = this.FHeros.GetHeroByIndex(_loc3_);
         _loc6_ = _loc4_.Skills;
         _loc6_.Sort();
         if(_loc3_ == 0)
         {
            _loc2_ = _loc6_.Count;
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               _loc5_ = _loc6_.GetSkillByIndex(_loc1_);
               if(_loc5_.Mounted)
               {
                  break;
               }
               _loc1_++;
            }
         }
         else
         {
            _loc5_ = _loc6_.GetSkillByIndex(0);
         }
         this.FTF_SkillAttack.text = _loc5_.Name;
         this.FMC_HeroSkill.visible = true;
      }
      
      protected function TabInventoryOnSwitchNewCopy(param1:Object) : void
      {
         this.FCurLittleTabIndex = param1 as int;
         this.UpdateHeroInformation();
      }
      
      public function UpdateHeroInformation() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:THero = null;
         var _loc4_:Number = NaN;
         _loc3_ = this.FHeros.GetHeroByIndex(this.FTabHeroIndex);
         _loc2_ = this.FBaseAttibutes.length;
         this.FBaseAttibutes[CONST_HEROS.BASEATTRIBUTEINDEX_Power] = _loc3_.BaseAttributePower;
         this.FBaseAttibutes[CONST_HEROS.BASEATTRIBUTEINDEX_Intelligence] = _loc3_.BaseAttributeIntelligence;
         this.FBaseAttibutes[CONST_HEROS.BASEATTRIBUTEINDEX_Life] = _loc3_.BaseAttributeLife;
         this.FBaseAttibutes[CONST_HEROS.BASEATTRIBUTEINDEX_Agile] = _loc3_.BaseAttributeAgile;
         this.FBaseAttibutes[CONST_HEROS.BASEATTRIBUTEINDEX_Speed] = _loc3_.BaseAttributeSpeed;
         this.FBaseAttibutes[CONST_HEROS.BASEATTRIBUTEINDEX_Health] = _loc3_.BaseAttributeHealth;
         if(_loc3_.Profession == 3 || _loc3_.Profession == 5)
         {
            this.FBaseAttibutes[CONST_HEROS.BASEATTRIBUTEINDEX_Attack] = _loc3_.BaseAttributeMagicAttack;
            this.FMC_OpeningState["MC_Attack"].gotoAndStop(2);
            this.FMC_ClosingState["MC_Attack"].gotoAndStop(2);
         }
         else
         {
            this.FBaseAttibutes[CONST_HEROS.BASEATTRIBUTEINDEX_Attack] = _loc3_.BaseAttributePhysicalAttack;
            this.FMC_OpeningState["MC_Attack"].gotoAndStop(1);
            this.FMC_ClosingState["MC_Attack"].gotoAndStop(1);
         }
         this.FBaseAttibutes[CONST_HEROS.BASEATTRIBUTEINDEX_BeginAnger] = _loc3_.BaseBeginAnger;
         this.FBaseAttibutes[CONST_HEROS.BASEATTRIBUTEINDEX_AvoidInjury] = _loc3_.BaseAvoidInjury;
         this.FBaseAttibutes[CONST_HEROS.BASEATTRIBUTEINDEX_Hurt] = _loc3_.BaseAttributeHurt;
         this.FBaseAttibutes[CONST_HEROS.BASEATTRIBUTEINDEX_PhysicalDefends] = _loc3_.BaseAttributePhysicalDefends;
         this.FBaseAttibutes[CONST_HEROS.BASEATTRIBUTEINDEX_MagicDefends] = _loc3_.BaseAttributeMagicDefends;
         this.FBaseAttibutes[CONST_HEROS.BASEATTRIBUTEINDEX_Hit] = _loc3_.BaseAttributeHit;
         this.FBaseAttibutes[CONST_HEROS.BASEATTRIBUTEINDEX_Dodge] = _loc3_.BaseAttributeDodge;
         this.FBaseAttibutes[CONST_HEROS.BASEATTRIBUTEINDEX_Crit] = _loc3_.BaseAttributeCrit;
         this.FBaseAttibutes[CONST_HEROS.BASEATTRIBUTEINDEX_Uprising] = _loc3_.BaseAttributeUprising;
         this.FBaseAttibutes[CONST_HEROS.BASEATTRIBUTEINDEX_Wreck] = _loc3_.BaseAttributeWreck;
         this.FBaseAttibutes[CONST_HEROS.BASEATTRIBUTEINDEX_GridFile] = _loc3_.BaseAttributeGridFile;
         this.FBaseAttibutes[CONST_HEROS.BASEATTRIBUTEINDEX_Punch] = _loc3_.BaseAttributePunch;
         this.FBaseAttibutes[CONST_HEROS.BASEATTRIBUTEINDEX_Help] = _loc3_.BaseAttributeHelp;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(_loc1_ > 9)
            {
               this.SetPercentSign(_loc1_,"%",_loc3_);
            }
            else
            {
               this.SetPercentSign(_loc1_,"",_loc3_);
            }
            _loc1_++;
         }
         this.ShowFourAttri(_loc3_.BaseAttributePower,0);
         this.ShowFourAttri(_loc3_.BaseAttributeIntelligence,1);
         this.ShowFourAttri(_loc3_.BaseAttributeLife,2);
         this.ShowFourAttri(_loc3_.BaseAttributeAgile,3);
         this.AnalysisSuitProperty(_loc3_);
         this.AnalysisAccessoryProperty(_loc3_);
      }
      
      protected function SetPercentSign(param1:int, param2:String, param3:THero) : void
      {
         var _loc4_:Vector.<Number> = null;
         if(this.FCurLittleTabIndex)
         {
            _loc4_ = param3.BaseAttributesCopy;
         }
         else
         {
            _loc4_ = this.FBaseAttibutes;
         }
         this.FMC_ClosingState["TF_Property_" + param1].text = _loc4_[param1] + param2;
         this.FMC_ClosingState["TF_Property_" + param1].mouseEnabled = false;
         this.FMC_OpeningState["TF_Property_" + param1].text = _loc4_[param1] + param2;
         this.FMC_OpeningState["TF_Property_" + param1].mouseEnabled = false;
      }
      
      protected function AnalysisAccessoryProperty(param1:THero) : void
      {
         var _loc2_:TCollectionInventory = null;
         var _loc3_:TEquipment = null;
         var _loc4_:int = 0;
         _loc2_ = param1.AccessoryMounted;
         var _loc5_:int = 0;
         while(_loc5_ < 4)
         {
            this.ValueVec[_loc5_] = 0;
            _loc5_++;
         }
         _loc4_ = 0;
         while(_loc4_ < _loc2_.Capacity)
         {
            _loc3_ = _loc2_.GetInventoryByIndex(_loc4_) as TEquipment;
            if(_loc3_)
            {
               this.GetPerPeotyOne(_loc3_);
            }
            _loc4_++;
         }
         this.ShowFourAttri(this.ValueVec[0],0);
         this.ShowFourAttri(this.ValueVec[2],1);
         this.ShowFourAttri(this.ValueVec[3],2);
         this.ShowFourAttri(this.ValueVec[1],3);
      }
      
      protected function GetPerPeotyOne(param1:TEquipment) : void
      {
         var _loc2_:TBaseEquip = null;
         var _loc3_:int = 0;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BaseEquip,param1.IDTemplate) as TBaseEquip;
         if(_loc2_)
         {
            switch(_loc2_.MainType)
            {
               case 1:
                  _loc3_ = 0;
                  break;
               case 2:
                  _loc3_ = 1;
                  break;
               case 3:
                  _loc3_ = 2;
                  break;
               case 4:
                  _loc3_ = 3;
            }
            this.ValueVec[_loc3_] = this.ValueVec[_loc3_] + _loc2_.MainValue + this.GetStrengthenValue(param1);
         }
      }
      
      protected function GetStrengthenValue(param1:TEquipment) : int
      {
         var _loc2_:int = 0;
         var _loc3_:TOrnamentBuildConsume = null;
         var _loc4_:TBins = null;
         if(param1.UpgradingLevel <= 0)
         {
            _loc2_ = 0;
         }
         else
         {
            _loc4_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_OrnamentBuildConsume) as TBins;
            _loc3_ = _loc4_.GetDatebaseByValue2("AccessoryId",param1.IDTemplate,"AccessoryLevel",param1.UpgradingLevel) as TOrnamentBuildConsume;
            if(_loc3_)
            {
               _loc2_ = _loc3_.AddValue;
            }
            else
            {
               _loc2_ = 0;
            }
         }
         return _loc2_;
      }
      
      protected function ShowFourAttri(param1:int, param2:int) : void
      {
         TextField(this.FMC_Heros[CONST_HEROS.CAPACITY_MC_PartAccesspory]["TF_Accessory_value_" + param2]).text = String(param1);
      }
      
      protected function AnalysisSuitProperty(param1:THero) : void
      {
         var _loc2_:TCollectionInventory = null;
         var _loc3_:TEquipment = null;
         var _loc4_:int = 0;
         var _loc5_:Vector.<uint> = new Vector.<uint>();
         _loc5_.length = 0;
         _loc2_ = param1.AccessoryMounted;
         _loc4_ = 0;
         while(_loc4_ < _loc2_.Capacity)
         {
            _loc3_ = _loc2_.GetInventoryByIndex(_loc4_) as TEquipment;
            if(_loc3_)
            {
               if(_loc3_.SuitCount >= 2)
               {
                  if(_loc5_.indexOf(_loc3_.SuitID) < 0)
                  {
                     _loc5_.push(_loc3_.SuitID);
                  }
               }
            }
            _loc4_++;
         }
         var _loc6_:String = "";
         if(_loc5_.length)
         {
            _loc6_ = _loc6_ + (STRING_HEROS.STRING_MoutedSuitEffect + "\r");
         }
         _loc4_ = 0;
         while(_loc4_ < _loc5_.length)
         {
            _loc6_ = _loc6_ + this.ShowSuitAttri(_loc5_[_loc4_]) + "\r";
            _loc4_++;
         }
         this.FAccessory_Suit_Arrti.text = _loc6_;
      }
      
      protected function ShowSuitAttri(param1:int) : String
      {
         var _loc2_:TSuit = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:String = null;
         var _loc6_:Number = NaN;
         var _loc7_:uint = 0;
         var _loc8_:String = null;
         var _loc9_:String = null;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         if(param1 > 0)
         {
            _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Suit,param1) as TSuit;
            _loc3_ = int(_loc2_.SuitEffects.length);
            _loc9_ = "";
            _loc10_ = 0;
            while(_loc10_ < _loc2_.SuitEffects[0].Category.length)
            {
               _loc11_ = BASEATTRIBUTENAMES.indexOf(_loc2_.SuitEffects[0].Category[_loc10_]);
               _loc5_ = STRINGS_BASEATTRIBUTENAMES[_loc11_];
               if(_loc2_.SuitEffects[0].Percentage[_loc10_])
               {
                  _loc6_ = Number(_loc2_.SuitEffects[0].Value[_loc10_]);
                  _loc6_ = _loc6_ * 100;
                  _loc12_ = int(_loc6_);
                  _loc8_ = String(_loc6_);
                  if(_loc6_ != _loc12_)
                  {
                     _loc8_ = _loc6_.toFixed(1);
                  }
                  _loc9_ = _loc9_ + (_loc5_ + "+" + _loc8_ + "%" + "  ");
               }
               else
               {
                  _loc7_ = uint(_loc2_.SuitEffects[0].Value[_loc10_]);
                  _loc9_ = _loc9_ + (_loc5_ + "+" + String(_loc7_) + "  ");
               }
               _loc10_++;
            }
            return _loc9_;
         }
         return "";
      }
      
      protected function InventoriesUpdateSlotsByCollection(param1:Vector.<TUISlot>, param2:TCollectionInventory) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:TUISlot = null;
         _loc3_ = param2.Capacity;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = param1[_loc4_];
            _loc5_.Context = null;
            _loc4_++;
         }
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = param1[_loc4_];
            _loc5_.Context = param2.GetInventoryByIndex(_loc4_);
            if(_loc5_.Context != null)
            {
            }
            _loc4_++;
         }
      }
      
      protected function GetBinExp(param1:uint) : Number
      {
         var _loc2_:THeroExp = null;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_HeroExp,param1) as THeroExp;
         if(_loc2_ != null)
         {
            return _loc2_.AllExp.ToNumber();
         }
         return 0;
      }
      
      protected function CheckEquipmentMouted(param1:Function, param2:TInventory, param3:int = 1) : void
      {
         var _loc4_:THero = null;
         var _loc5_:THeros = null;
         var _loc6_:int = 0;
         var _loc7_:uint = 0;
         var _loc8_:TInventory = null;
         _loc4_ = this.FHeros.GetHeroByIndex(this.FTabHeroIndex);
         _loc7_ = CAPACITY_MC_SlotsEquipment;
         if(param2.Category == 2)
         {
            _loc6_ = 0;
            while(_loc6_ < _loc7_)
            {
               _loc8_ = _loc4_.EquipmentsMounted.GetInventoryByIndex(_loc6_);
               if(_loc8_ != null && _loc8_ != param2 && _loc8_.CategorySecond == param2.CategorySecond)
               {
                  if(param1 != null)
                  {
                     param1(this,param2);
                  }
                  return;
               }
               _loc6_++;
            }
            if(param1 != null)
            {
               param1(this,param2);
            }
         }
         else if(param2.Category == 6)
         {
            _loc7_ = CAPACITY_MC_SlotsAccessory;
            _loc6_ = 0;
            while(_loc6_ < _loc7_)
            {
               _loc8_ = _loc4_.AccessoryMounted.GetInventoryByIndex(_loc6_);
               if(_loc8_ != null && _loc8_ != param2 && _loc8_.CategorySecond == param2.CategorySecond)
               {
                  if(param1 != null)
                  {
                     param1(this,param2);
                  }
                  return;
               }
               _loc6_++;
            }
            if(param1 != null)
            {
               param1(this,param2);
            }
         }
         else if(param1 != null)
         {
            param1(this,param2);
         }
      }
      
      protected function TabHerosOnSwitch(param1:Object) : void
      {
         this.FTabHeroIndex = param1 as int;
         this.FTabHeroIndex = this.FTabHeroIndex + this.FHeroPageIndex * CAPACITY_TF_HerosName;
         this.UpdateRoleModel();
         this.CharacterUpdateBaseInfo();
         this.CharacterUpdateBaseAttributes();
         this.CharacterUpdateSkills();
         this.InventoriesUpdateEquipmentsMounted();
         this.UpdateHeroInformation();
         this.UpdatePractice();
      }
      
      protected function UpdatePractice() : void
      {
         this.FCurHero = this.FHeros.GetHeroByIndex(this.FTabHeroIndex);
         TextField(this.FMC_Heros["qianneng"]["MVC_tem"]["TF_FightingCapacity"]).text = this.FCurHero.GetQianNengOnlyLevelStr(this.FCurHero.PotentialLevelShow);
      }
      
      protected function HeroPageOnChange(param1:Object, param2:int) : void
      {
         this.FHeroPageIndex = param2;
         this.FTabHeroIndex = 0;
         this.FTabHeroIndex = this.FTabHeroIndex + this.FHeroPageIndex * CAPACITY_TF_HerosName;
         this.UpdateTabs();
         this.TabHerosOnSwitch(this);
         this.FUITabHeros.SwithTagManual(0);
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
            _loc6_.LoadSecondary(_loc5_.IDTexture,CONST_MODULES.MODULE_HeroInfo);
         }
      }
      
      protected function SlotsOnQueryEuqipLevel(param1:Object, param2:Object, param3:TQueryString) : void
      {
         var _loc4_:TEquipment = null;
         if(param2 is TEquipment)
         {
            _loc4_ = param2 as TEquipment;
            if(_loc4_.UpgradingLevel > 0)
            {
               param3.Value = STRING_COMMON.FORMAT_Level + _loc4_.UpgradingLevel.toString();
            }
         }
      }
      
      protected function SlotsOnMove(param1:Object, param2:TInventory) : void
      {
         this.CheckEquipmentMouted(this.FOnInventoryOver,param2,0);
      }
      
      protected function SlotsOnOut(param1:Object, param2:TInventory) : void
      {
         this.CheckEquipmentMouted(this.FOnInventoryOut,param2,0);
      }
      
      protected function ButtonCloseOnClick(param1:MouseEvent) : void
      {
         this.visible = false;
         SResourcesCore.PerformAutoReleaseResources(CONST_MODULES.MODULE_HeroInfo);
      }
      
      protected function BtnTreasureHintOnOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         var _loc6_:THero = null;
         var _loc7_:TCollectionInventory = null;
         var _loc8_:TEquipment = null;
         var _loc9_:String = null;
         var _loc10_:String = null;
         _loc4_ = "";
         _loc5_ = this.FTabHeroIndex;
         _loc3_ = this.FHeros.Count;
         _loc6_ = this.FHeros.GetHeroByIndex(_loc5_);
         _loc7_ = _loc6_.TalismansMounted;
         _loc3_ = _loc7_.Capacity;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc9_ = _loc6_.GetFirstAttributeByIndex(_loc2_).toFixed();
            _loc8_ = _loc7_.GetInventoryByIndex(_loc2_) as TEquipment;
            if(_loc8_ != null && !TUtilityString.Empty(_loc9_))
            {
               _loc10_ = STRINGS_TreasuresAttributeCaption[_loc8_.CategorySecond % CATEGORY_TreasurePower];
               _loc4_ = _loc4_ + TUtilityString.Format(FORMAT_Talisman,_loc8_.Name,_loc10_,_loc9_);
            }
            _loc2_++;
         }
         if(!TUtilityString.Empty(_loc4_))
         {
            this.FHint.Caption = _loc4_;
            if(this.FHintOnOver != null)
            {
               this.FHintOnOver(this,this.FHint);
            }
         }
      }
      
      protected function BtnTreasureHintOnOut(param1:MouseEvent) : void
      {
         if(this.FHintOnOut != null)
         {
            this.FHintOnOut(this);
         }
      }
      
      protected function BtnMagicHintOnOver(param1:MouseEvent) : void
      {
         var _loc2_:THero = null;
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:TMewMagic = null;
         var _loc6_:String = null;
         var _loc7_:uint = 0;
         _loc6_ = "";
         _loc2_ = this.FHeros.GetHeroByIndex(this.FTabHeroIndex);
         _loc7_ = this.FHeroMagicIDs[_loc2_.StandPositionWithProfession - 1];
         _loc5_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_MewMagic,_loc7_) as TMewMagic;
         if(_loc2_.Level < this.FMagicOpenLv)
         {
            _loc6_ = TUtilityString.Format(STRING_HEROS.STRING_MagicLocked,this.FMagicOpenLv);
         }
         else if(!_loc2_.Mounted)
         {
            _loc6_ = STRING_HEROS.STRING_MoutedActivated;
         }
         else if(_loc5_ == null || _loc5_.Level == 0)
         {
            _loc6_ = STRING_HEROS.STRING_UnActivateMagic;
         }
         else
         {
            _loc6_ = _loc5_.Name + "\n";
            _loc4_ = _loc5_.Atrributes.length;
            _loc3_ = 0;
            while(_loc3_ < _loc4_)
            {
               _loc6_ = _loc6_ + (STRING_HEROS.STRING_Attributes[_loc3_] + " + " + _loc5_.Atrributes[_loc3_] + "\n");
               _loc3_++;
            }
         }
         this.FHint.Caption = _loc6_;
         if(this.FHintOnOver != null)
         {
            this.FHintOnOver(this,this.FHint);
         }
      }
      
      protected function BtnMagicHintOnOut(param1:MouseEvent) : void
      {
         if(this.FHintOnOut != null)
         {
            this.FHintOnOut(this);
         }
      }
      
      protected function BtnOpenInfomationOnClick(param1:MouseEvent) : void
      {
         this.UpdateHeroInformation();
         this.FMC_CLoseInfomation.gotoAndPlay(1);
      }
      
      protected function BtnCloseInfomationOnClick(param1:MouseEvent) : void
      {
         this.FMC_OpenInfomation.gotoAndPlay(1);
      }
      
      protected function CheckEquipMentsMounted() : Boolean
      {
         var _loc1_:uint = 0;
         var _loc2_:THero = null;
         var _loc3_:int = 0;
         var _loc4_:TInventory = null;
         _loc2_ = this.FHeros.GetHeroByIndex(this.FTabHeroIndex);
         _loc1_ = uint(_loc2_.EquipmentsMounted.Capacity);
         _loc3_ = 0;
         while(_loc3_ < _loc1_)
         {
            _loc4_ = _loc2_.EquipmentsMounted.GetInventoryByIndex(_loc3_);
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
         _loc2_ = this.FHeros.GetHeroByIndex(this.FTabHeroIndex);
         _loc1_ = uint(_loc2_.TalismansMounted.Capacity);
         _loc3_ = 0;
         while(_loc3_ < _loc1_)
         {
            _loc4_ = _loc2_.TalismansMounted.GetInventoryByIndex(_loc3_);
            if(_loc4_ != null)
            {
               return true;
            }
            _loc3_++;
         }
         return false;
      }
      
      protected function TFFightingCapacityOnMove(param1:MouseEvent) : void
      {
         var _loc2_:THero = null;
         _loc2_ = this.FHeros.GetHeroByIndex(this.FTabHeroIndex);
         if(this.FOnBaseAttributeOver != null)
         {
            this.FOnBaseAttributeOver(_loc2_);
         }
      }
      
      protected function TFFightingCapacityOnOut(param1:MouseEvent) : void
      {
         if(this.FOnBaseAttributeOut != null)
         {
            this.FOnBaseAttributeOut(this);
         }
      }
      
      protected function TFBaseAttributesHintOnOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TextField = null;
         var _loc5_:THero = null;
         var _loc6_:TBaseHero = null;
         var _loc7_:String = null;
         _loc4_ = param1.currentTarget as TextField;
         _loc2_ = this.FTF_BaseAttributes.indexOf(_loc4_);
         _loc3_ = this.FTabHeroIndex;
         _loc5_ = this.FHeros.GetHeroByIndex(_loc3_);
         if(_loc5_.Profession == 3 || _loc5_.Profession == 5)
         {
            _loc7_ = STRING_HEROS.STRING_MagicAttack;
         }
         else
         {
            _loc7_ = STRING_HEROS.STRING_PhysicalAttack;
         }
         switch(_loc2_)
         {
            case 0:
               this.FHint.Caption = _loc7_;
               break;
            case 1:
               this.FHint.Caption = STRING_HEROS.STRING_PhysicalDefends;
               break;
            case 2:
               this.FHint.Caption = STRING_HEROS.STRING_Hurt;
               break;
            case 3:
               this.FHint.Caption = STRING_HEROS.STRING_MagicDefends;
               break;
            case 4:
               this.FHint.Caption = STRING_HEROS.STRING_MaxHP;
               break;
            case 5:
               this.FHint.Caption = STRING_HEROS.STRING_Speed;
         }
         if(this.FHintOnOver != null)
         {
            this.FHintOnOver(this,this.FHint);
         }
      }
      
      protected function TFTalentHintOnOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:THero = null;
         _loc2_ = this.FTabHeroIndex;
         _loc3_ = this.FHeros.GetHeroByIndex(_loc2_);
         this.FHint.Caption = _loc3_.TalentDesc;
         if(this.FHintOnOver != null)
         {
            this.FHintOnOver(this,this.FHint);
         }
      }
      
      protected function MC_AssessHintOnOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TextField = null;
         var _loc5_:THero = null;
         var _loc6_:TBaseHero = null;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:String = null;
         _loc11_ = "";
         _loc3_ = this.FTabHeroIndex;
         _loc5_ = this.FHeros.GetHeroByIndex(_loc3_);
         _loc6_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BaseHero,_loc5_.Identifier) as TBaseHero;
         _loc7_ = _loc6_.PowerGrow;
         _loc9_ = _loc6_.AgileGrow;
         _loc8_ = _loc6_.IntelligenceGrow;
         _loc10_ = _loc6_.LifeGrow;
         if(_loc5_.IsMain)
         {
            _loc7_ = _loc5_.FirstAttributePowerRate;
            _loc8_ = _loc5_.FirstAttributeIntelligenceRate;
            _loc9_ = _loc5_.FirstAttributeAgileRate;
            _loc10_ = _loc5_.FirstAttributeHealthRate;
         }
         _loc11_ = _loc11_ + TUtilityString.Format(FORMAT_Power,_loc7_);
         _loc11_ = _loc11_ + TUtilityString.Format(FORMAT_Intelligence,_loc8_);
         _loc11_ = _loc11_ + TUtilityString.Format(FORMAT_Agile,_loc9_);
         _loc11_ = _loc11_ + TUtilityString.Format(FORMAT_Health,_loc10_);
         this.FHint.Caption = _loc11_;
         if(this.FHintOnOver != null)
         {
            this.FHintOnOver(this,this.FHint);
         }
      }
      
      protected function TFSkillAttackHintOnOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:THero = null;
         var _loc4_:TSkill = null;
         _loc2_ = this.FTabHeroIndex;
         _loc3_ = this.FHeros.GetHeroByIndex(_loc2_);
         _loc4_ = _loc3_.Skills.GetSkillByIndex(0);
         this.FHint.Caption = _loc4_.Description;
         if(this.FHintOnOver != null)
         {
            this.FHintOnOver(this,this.FHint);
         }
      }
      
      protected function TFComboBoxBarHintOnOver(param1:Object, param2:int) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:THero = null;
         var _loc7_:TSkill = null;
         _loc5_ = this.FTabHeroIndex;
         _loc6_ = this.FHeros.GetHeroByIndex(0);
         _loc4_ = _loc6_.Skills.Count;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc7_ = _loc6_.Skills.GetSkillByIndex(_loc3_);
            if(_loc7_.Mounted)
            {
               this.FHint.Caption = _loc7_.Description;
               break;
            }
            _loc3_++;
         }
         if(this.FHintOnOver != null)
         {
            this.FHintOnOver(this,this.FHint);
         }
      }
      
      protected function TFComboBoxListHintOnOver(param1:Object, param2:int) : void
      {
         var _loc3_:THero = null;
         var _loc4_:TSkill = null;
         _loc3_ = this.FHeros.GetHeroByIndex(0);
         _loc4_ = _loc3_.Skills.GetSkillByIndex(param2);
         this.FHint.Caption = _loc4_.Description;
         if(this.FHintOnOver != null)
         {
            this.FHintOnOver(this,this.FHint);
         }
      }
      
      protected function MCTacticalDeploymentHintOnOver(param1:Object) : void
      {
         this.FHint.Caption = STRING_FightPosition;
         if(this.FHintOnOver != null)
         {
            this.FHintOnOver(this,this.FHint);
         }
      }
      
      protected function TFHintOnOut(param1:Object) : void
      {
         if(this.FHintOnOut != null)
         {
            this.FHintOnOut(this);
         }
      }
      
      protected function OnMouseDown(param1:MouseEvent) : void
      {
         this.startDrag();
      }
      
      protected function OnMouseUP(param1:MouseEvent) : void
      {
         this.stopDrag();
      }
      
      protected function MCTitleEffectOnOver(param1:MouseEvent) : void
      {
         if(this.FTitleHintOnOver != null)
         {
            this.FTitleHintOnOver(this,this.FTitleAnimationID);
         }
      }
      
      protected function MCTitleEffectOnOut(param1:MouseEvent) : void
      {
         if(this.FTitleHintOnOut != null)
         {
            this.FTitleHintOnOut(this);
         }
      }
      
      protected function MCLittlePetEffectOnOver(param1:MouseEvent) : void
      {
         this.FMC_LittlePetEffect.filters = [new GlowFilter(3394560,1,5,5,20)];
         if(this.FLittlePetOnOver != null)
         {
            this.FLittlePetOnOver(this,this.FLittlePetAnimationID);
         }
      }
      
      protected function MCLittlePetEffectOnOut(param1:MouseEvent) : void
      {
         this.FMC_LittlePetEffect.filters = [];
         if(this.FLittlePetOnOut != null)
         {
            this.FLittlePetOnOut(this);
         }
      }
      
      public function get OnInventoryOver() : Function
      {
         return this.FOnInventoryOver;
      }
      
      public function set OnInventoryOver(param1:Function) : void
      {
         this.FOnInventoryOver = param1;
      }
      
      public function get OnInventoryOut() : Function
      {
         return this.FOnInventoryOut;
      }
      
      public function set OnInventoryOut(param1:Function) : void
      {
         this.FOnInventoryOut = param1;
      }
      
      public function get OnBaseAttributeOver() : Function
      {
         return this.FOnBaseAttributeOver;
      }
      
      public function set OnBaseAttributeOver(param1:Function) : void
      {
         this.FOnBaseAttributeOver = param1;
      }
      
      public function get OnBaseAttributeOut() : Function
      {
         return this.FOnBaseAttributeOut;
      }
      
      public function set OnBaseAttributeOut(param1:Function) : void
      {
         this.FOnBaseAttributeOut = param1;
      }
      
      public function get HintOnOver() : Function
      {
         return this.FHintOnOver;
      }
      
      public function set HintOnOver(param1:Function) : void
      {
         this.FHintOnOver = param1;
      }
      
      public function get HintOnOut() : Function
      {
         return this.FHintOnOut;
      }
      
      public function set HintOnOut(param1:Function) : void
      {
         this.FHintOnOut = param1;
      }
      
      public function set Heros(param1:THeros) : void
      {
         this.FHeros = param1;
      }
      
      public function get TitleHintOnOver() : Function
      {
         return this.FTitleHintOnOver;
      }
      
      public function set TitleHintOnOver(param1:Function) : void
      {
         this.FTitleHintOnOver = param1;
      }
      
      public function get TitleHintOnOut() : Function
      {
         return this.FTitleHintOnOut;
      }
      
      public function set TitleHintOnOut(param1:Function) : void
      {
         this.FTitleHintOnOut = param1;
      }
      
      public function get LittlePetOnOver() : Function
      {
         return this.FLittlePetOnOver;
      }
      
      public function set LittlePetOnOver(param1:Function) : void
      {
         this.FLittlePetOnOver = param1;
      }
      
      public function get LittlePetOnOut() : Function
      {
         return this.FLittlePetOnOut;
      }
      
      public function set LittlePetOnOut(param1:Function) : void
      {
         this.FLittlePetOnOut = param1;
      }
      
      public function Reset() : void
      {
         this.UpdateTabs();
         this.UpdateRoleModel();
         this.CharacterUpdateBaseInfo();
         this.CharacterUpdateBaseAttributes();
         this.CharacterUpdateSkills();
         this.InventoriesUpdateEquipmentsMounted();
      }
      
      public function Update() : void
      {
         if(!this.FInitializationSlots)
         {
            return;
         }
         this.UpdateTabs();
         this.UpdateRoleModel();
         this.CharacterUpdateBaseInfo();
         this.CharacterUpdateBaseAttributes();
         this.CharacterUpdateSkills();
         this.InventoriesUpdateEquipmentsMounted();
         this.UpdateHeroUIPage();
         this.EarLeft.play();
         this.EarRight.play();
         this.HeroPageOnChange(this,0);
         this.visible = true;
         this.UpdateEquipAccessory(0);
         this.FUITabInventoryNew.SwithTagManual(0);
         this.UpdateBtn();
      }
      
      public function UpdateCharacterInventory() : void
      {
         this.InventoriesUpdateEquipmentsMounted();
         this.UpdateHeroInformation();
      }
      
      public function UpdateCharacterBaseInfo() : void
      {
         this.CharacterUpdateBaseInfo();
      }
      
      public function UpdateCharacterBaseAttributes() : void
      {
         this.UpdateHeroInformation();
         this.CharacterUpdateBaseAttributes();
      }
      
      public function SetBtnLock(param1:Boolean) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < this.FBtnList.length)
         {
            TGameUtil.LockOrUnlockButton(this.FBtnList[_loc2_],param1);
            _loc2_++;
         }
      }
      
      public function HideWindow() : void
      {
         this.visible = false;
         SResourcesCore.PerformAutoReleaseResources(CONST_MODULES.MODULE_HeroInfo);
      }
      
      public function UpdateTitle(param1:uint) : void
      {
         this.FTitleAnimationID = param1;
      }
      
      public function UpdateLittlePet(param1:uint) : void
      {
         this.FLittlePetAnimationID = param1;
         this.true_false(param1);
      }
      
      public function true_false(param1:uint) : void
      {
         if(this.FHeros.GetHeroByIndex(0).Level >= this.FBloodFeteOpenLv)
         {
            if(this.FMC_BloodFete)
            {
               this.FMC_BloodFete.visible = true;
            }
         }
         else if(this.FMC_BloodFete)
         {
            this.FMC_BloodFete.visible = false;
         }
         if(this.FMvcTongLing == null)
         {
            return;
         }
         if(param1 == 0)
         {
            this.FMvcTongLing.visible = true;
         }
         else
         {
            this.FMvcTongLing.visible = false;
         }
      }
      
      public function UpdateMagic(param1:uint, param2:uint, param3:uint) : void
      {
         this.FHeroMagicIDs[0] = param1;
         this.FHeroMagicIDs[1] = param2;
         this.FHeroMagicIDs[2] = param3;
      }
      
      public function UpdateBtn() : void
      {
         var _loc1_:TConfigValue = null;
         var _loc2_:int = 0;
         if(this.FMC_SoulFormation)
         {
            _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,91000020) as TConfigValue;
            _loc2_ = _loc1_.Value as int;
            if(this.FHeros.GetHeroByIndex(0).Level >= _loc2_)
            {
               this.FMC_SoulFormation.visible = true;
            }
            else
            {
               this.FMC_SoulFormation.visible = false;
            }
         }
      }
   }
}

