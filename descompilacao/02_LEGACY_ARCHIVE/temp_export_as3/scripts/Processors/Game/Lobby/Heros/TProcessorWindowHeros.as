package Processors.Game.Lobby.Heros
{
   import Components.ComboBox.*;
   import Components.Pages.*;
   import Components.Slots.*;
   import Components.Standard.*;
   import Foundation.Common.*;
   import Foundation.Common.Integer.*;
   import Foundation.Network.*;
   import Foundation.Queries.*;
   import Foundation.Queries.Textures.*;
   import Foundation.Resources.*;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.Repositories.*;
   import Foundation.Resources.Textures.*;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.*;
   import Logics.Characters.*;
   import Logics.DatebaseVO.VO.*;
   import Logics.Inventories.*;
   import Logics.Magic.TMagic;
   import Logics.Magic.TMagicData;
   import Logics.Skills.*;
   import Processors.Game.Common.Effects.Display.TEffectBaseGlow;
   import Processors.Game.Lobby.Common.*;
   import Processors.Game.Lobby.Components.*;
   import Processors.Game.Lobby.Heros.Panel.TUIRing;
   import Processors.Game.Lobby.Homeland.THomelandModel;
   import Processors.Game.Lobby.TreasureMap.ConsumeFrame;
   import Processors.Game.Windows.Editors.*;
   import Processors.Game.Windows.Information.*;
   import Rendering.Overlayers.Inventories.TOverlayerAccessory;
   import Rendering.Overlayers.NinJaPractice.TOverlayerNinJaAwake;
   import Rendering.Overlayers.Pet.TOverlayerSoulFormation;
   import Rendering.Overlayers.PurpleNinja.TOverJinJaPracticeLink;
   import Rendering.Overlayers.SpecialJade.TOverlayerSpecialJade;
   import Rendering.Overlayers.Sprite.TOverlayerSprite;
   import Rendering.Overlayers.TongLingAnimal.TongLingOtherMsg;
   import Rendering.Overlayers.Wing.TOverlayerWing;
   import Resources.Constants.*;
   import Resources.Strings.*;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import Utilities.UI.Windows.*;
   import flash.display.*;
   import flash.events.*;
   import flash.filters.GlowFilter;
   import flash.text.*;
   import flash.utils.*;
   
   public class TProcessorWindowHeros extends TProcessorLobbyWindow
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
      
      public static const CATEGORY_Accessories:uint = CONST_INVENTORY.CATEGORY_Accessories;
      
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
      
      public static const STRING_TabCaption_Ring:String = STRING_HEROS.STRING_TabCaption_Ring;
      
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
      
      protected var FUIWindowEditor:TUIWindowEditor;
      
      protected var FHelpTips:THint;
      
      protected var FBtn_Close:SimpleButton;
      
      protected var FBtn_Help:SimpleButton;
      
      protected var FMC_Heros:Sprite;
      
      protected var FUITabHeros:TUITab;
      
      protected var FTF_CurrentNumber:TextField;
      
      protected var FMC_Btn_ExtendHeros:MovieClip;
      
      protected var FMC_Btn_AKeySwap:MovieClip;
      
      protected var FMC_Btn_Inherit:MovieClip;
      
      protected var FTF_Level:TextField;
      
      protected var FTF_Profession:TextField;
      
      protected var FMC_Profession:MovieClip;
      
      protected var FBtn_Treasure:SimpleButton;
      
      protected var FBtn_Magic:SimpleButton;
      
      protected var FMC_HeroPosition:Sprite;
      
      protected var FMC_Btn_AllUnload:MovieClip;
      
      protected var FTF_Experience:TextField;
      
      protected var FMC_ProgressBarExp:Sprite;
      
      protected var FTF_BaseAttributes:Vector.<TextField>;
      
      protected var FTF_FightingCapacity:TextField;
      
      protected var FSkillAttackComboBox:TComboBox;
      
      protected var FItemList:Vector.<DisplayObject>;
      
      protected var FMC_ComboBox:Sprite;
      
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
      
      protected var FMC_ShowAllEquip:MovieClip;
      
      protected var FBtn_ShowAllEquip:MovieClip;
      
      protected var FMC_EarList:Vector.<MovieClip>;
      
      protected var FMC_HeroPage:MovieClip;
      
      protected var FMC_TitleManage:MovieClip;
      
      protected var FMC_TitleEffect:Sprite;
      
      protected var FMC_LittlePetEffect:Sprite;
      
      protected var FMC_BloodFete:SimpleButton;
      
      protected var FMC_SaiXuanJiNeng:MovieClip;
      
      protected var FMC_SaiXuanJiNeng_Vector:Vector.<MovieClip>;
      
      protected var FTF_Name:TextField;
      
      protected var FMC_Equip_Part:MovieClip;
      
      protected var FMC_Accessor_Part:MovieClip;
      
      protected var FMC_Ring_Part:TUIRing;
      
      protected var FMC_Ring_Tap:MovieClip;
      
      protected var FTF_TacticalDeployment:TextField;
      
      protected var FMC_Btn_Dismiss:MovieClip;
      
      protected var FMC_Assess:MovieClip;
      
      protected var FMC_Attack:TextField;
      
      protected var FUITabInventory:TUITab;
      
      protected var FUITabInventoryNew:TUITab;
      
      protected var FAccessory_Suit_Arrti:TextField;
      
      protected var FCharacter:TCharacter;
      
      protected var FUIHero:TUIHero;
      
      protected var FInventories:TInventories;
      
      protected var FSlotsUserAssets:Vector.<TUISlot>;
      
      protected var FSlotsEquipmentMounted:Vector.<TUISlot>;
      
      protected var FSlotsAccessoryMounted:Vector.<TUISlot>;
      
      protected var FFilterEquipments:Vector.<Function>;
      
      protected var FFilterAppliances:Vector.<Function>;
      
      protected var FFilterAccessory:Vector.<Function>;
      
      protected var FBaseAttibutes:Vector.<Number>;
      
      protected var FBaseAttibutesCopy:Vector.<Number>;
      
      protected var FUIPage:TUIPage;
      
      protected var FHeroPage:TUIPage;
      
      protected var FPageIndex:int;
      
      protected var FHeroPageIndex:int;
      
      protected var FTabHeroIndex:int;
      
      protected var FTabInventoryIndex:int;
      
      protected var FTabInventoryIndexNew:int;
      
      protected var FTitleAnimationID:uint;
      
      protected var FTitleBmp:Bitmap;
      
      protected var FInitializationSlots:Boolean;
      
      protected var FLittlePetAnimationID:uint;
      
      protected var FLittlePetBmp:Bitmap;
      
      protected var FHint:THint;
      
      protected var FClickNum:uint;
      
      protected var FIsShowAllEquip:Boolean;
      
      protected var FExperience:uint;
      
      protected var FUIWindowConfirmationDismiss:TUIWindowConfirmation;
      
      protected var FBtnList:Vector.<MovieClip>;
      
      protected var FUIWindowConfirmationBugHeroSlot:TUIWindowConfirmation;
      
      protected var FTeamMemberExpand:TTeamMemberExpand;
      
      protected var FOverlayerSprite:TOverlayerSprite;
      
      protected var FActivityPetConfigBins:TBins;
      
      protected var FMagicData:TMagicData;
      
      protected var FExpType:int;
      
      protected var FMvcInherit:SimpleButton;
      
      protected var FMvcTongLing:SimpleButton;
      
      protected var FOverTip:TOverJinJaPracticeLink;
      
      protected var FOverTipT:TongLingOtherMsg;
      
      protected var FCurHero:THero;
      
      protected var FMagicOpenLv:uint;
      
      protected var opLevel:uint;
      
      protected var ValueVec:Vector.<int>;
      
      protected var QianNengOpenLv:int;
      
      protected var BloodFeteOpenLv:int;
      
      protected var JadeOpenLv:int;
      
      protected var FOverJadeTip:TOverlayerSpecialJade;
      
      protected var FAccessoryIntensityLevel:int;
      
      protected var FEffectBaseGlow:TEffectBaseGlow;
      
      protected var FColorConfig:Vector.<Object>;
      
      protected var FOpenNinjaHostel:uint;
      
      protected var FRecallCost:Vector.<Object>;
      
      protected var FNiMeiA:Boolean;
      
      protected var FLimitSkillCount:int;
      
      public var IsColor:int;
      
      public var IsColorMagic:int;
      
      protected var FUITabInventoryNewCopy:TUITab;
      
      protected var FCurLittleTabIndex:int;
      
      protected var FMC_SoulFormation:SimpleButton;
      
      protected var FOverlayerSoulFormation:TOverlayerSoulFormation;
      
      protected var FMC_Wing:SimpleButton;
      
      protected var FOverlayerWing:TOverlayerWing;
      
      protected var FMC_Jade:SimpleButton;
      
      protected var FMC_NinJaAwake:MovieClip;
      
      protected var FOverlayerNinJaAwake:TOverlayerNinJaAwake;
      
      public var FOverlayerAccessory:TOverlayerAccessory;
      
      protected var FOnMountEquipment:Function;
      
      protected var FOnDismountEquipment:Function;
      
      protected var FOnMountAccessory:Function;
      
      protected var FOnInventoryOver:Function;
      
      protected var FOnInventoryOut:Function;
      
      protected var FOnHelpTipsOver:Function;
      
      protected var FOnHelpTipsOut:Function;
      
      protected var FOnBaseAttributeOver:Function;
      
      protected var FOnBaseAttributeOut:Function;
      
      protected var FHintOnOver:Function;
      
      protected var FHintOnOut:Function;
      
      protected var FOnShortcutHyperlinks:Function;
      
      protected var FBtnAKeySwapOnClick:Function;
      
      protected var FBtnInheritOnClick:Function;
      
      protected var FOnChangeSkillReq:Function;
      
      protected var FOnDismiss:Function;
      
      protected var FOnUseInventory:Function;
      
      protected var FTitleHintOnOver:Function;
      
      protected var FTitleHintOnOut:Function;
      
      protected var FOnOpenTitleManage:Function;
      
      protected var FGoAccessoryPanel:Function;
      
      public var GoSoulFormation:Function;
      
      public var GoWing:Function;
      
      public var OpenJadeFun:Function;
      
      protected var FCurSkillindex:int;
      
      public var GoToHerosFightWindow:Function;
      
      protected var FIsShowEffectNiaja:Boolean = false;
      
      protected var FEffectFatherSpr:Sprite;
      
      protected var FEffectBitmap:Bitmap;
      
      protected var FBFOnMove:Function;
      
      protected var FBFOnOut:Function;
      
      public function TProcessorWindowHeros(param1:TUIComponent)
      {
         super(param1);
         this.FHelpTips = new THint();
         this.FUITabHeros = new TUITab(this);
         this.FSlotsEquipmentMounted = new Vector.<TUISlot>(CAPACITY_MC_SlotsEquipment);
         this.FSlotsAccessoryMounted = new Vector.<TUISlot>(CAPACITY_MC_SlotsAccessory);
         this.FTF_BaseAttributes = new Vector.<TextField>(CAPACITY_TF_BaseAttributes);
         this.FUITabInventory = new TUITab(this);
         this.FUITabInventoryNew = new TUITab(this);
         this.FUITabInventoryNewCopy = new TUITab(this);
         this.FSlotsUserAssets = new Vector.<TUISlot>(CAPACITY_Backpack_Slots);
         this.FMC_EarList = new Vector.<MovieClip>();
         this.FBaseAttibutes = new Vector.<Number>(CONST_HEROS.CAPACITY_BaseAttribute);
         this.FBaseAttibutesCopy = new Vector.<Number>(CONST_HEROS.CAPACITY_BaseAttribute);
         this.FCharacter = SLogicsCore.Character;
         this.FInventories = new TInventories();
         this.FFilterEquipments = new Vector.<Function>();
         this.FFilterAppliances = new Vector.<Function>();
         this.FFilterAccessory = new Vector.<Function>();
         this.FUIPage = new TUIPage(this);
         this.FHeroPage = new TUIPage(this);
         this.FHint = new THint();
         this.FBtnList = new Vector.<MovieClip>();
         this.FTitleBmp = new Bitmap();
         this.FLittlePetBmp = new Bitmap();
         this.FOverlayerSprite = new TOverlayerSprite(this.Parent);
         this.FOverlayerSprite.Visible = false;
         this.FPageIndex = 0;
         this.FHeroPageIndex = 0;
         this.FTabHeroIndex = 0;
         this.FTabInventoryIndex = 0;
         this.FTabInventoryIndexNew = 0;
         this.FInitializationSlots = false;
         this.FIsShowAllEquip = false;
         this.FTitleAnimationID = 0;
         this.FLittlePetAnimationID = 0;
         this.FOverTip = new TOverJinJaPracticeLink(param1);
         this.FOverTip.visible = false;
         this.FOverTipT = TongLingOtherMsg.getTipIntence(param1);
         this.FOverTipT.visible = false;
         this.FMagicData = SLogicsCore.MagicData;
         this.ValueVec = new Vector.<int>(4);
         this.FEffectFatherSpr = new Sprite();
         this.FEffectBitmap = new Bitmap();
         this.FEffectFatherSpr.addChild(this.FEffectBitmap);
         this.FMC_SaiXuanJiNeng_Vector = new Vector.<MovieClip>(4);
         this.FOverJadeTip = new TOverlayerSpecialJade(param1);
         this.FOverlayerNinJaAwake = new TOverlayerNinJaAwake(param1);
      }
      
      public function sendBaoTip() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TongLing_AllMsg_Rep);
         _loc1_.Data.writeUnsignedInt(this.FCharacter.Identifier0);
         _loc1_.Data.writeUnsignedInt(this.FCharacter.Identifier1);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_HEROS.RESOURCESID_Swf_Heros);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:TUISlot = null;
         var _loc5_:BitmapData = null;
         var _loc6_:TextField = null;
         var _loc7_:MovieClip = null;
         var _loc8_:TextField = null;
         var _loc9_:TConfigValue = null;
         this.FMC_Heros = TUtilityReflection.CreateDisplayObjectInstance(CONST_HEROS.RESOURCE_ClassName_MC_Heros) as Sprite;
         this.FMC_Heros["MC_Challenge_Btn"].visible = false;
         addChild(this.FMC_Heros);
         this.FBtn_Close = this.FMC_Heros[CONST_HEROS.RESOURCE_Link_Btn_Close];
         this.FBtn_Help = this.FMC_Heros[CONST_HEROS.RESOURCE_Link_Btn_Help];
         _loc2_ = int(CAPACITY_TF_HerosName);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FMC_Heros[CONST_HEROS.RESOURCE_Link_TF_HerosName + _loc1_];
            this.FUITabHeros.SetTabByIndex(_loc3_,_loc1_);
            this.FUITabHeros.SetTabCaptionByIndex("",_loc1_);
            _loc1_++;
         }
         this.FUITabHeros.OnSwitch = this.TabHerosOnSwitch;
         this.FUITabHeros.Init();
         this.FTF_CurrentNumber = this.FMC_Heros[CONST_HEROS.RESOURCE_Link_TF_CurrentNumber];
         this.FMC_Btn_ExtendHeros = this.FMC_Heros[CONST_HEROS.RESOURCE_Link_MC_Btn_ExtendHeros];
         this.FMC_Btn_AKeySwap = this.FMC_Heros[CONST_HEROS.RESOURCE_Link_MC_Btn_AKeySwap];
         this.FMC_Btn_Inherit = this.FMC_Heros[CONST_HEROS.RESOURCE_Link_MC_Btn_Inhert];
         TGameUtil.setButtonMode(this.FMC_Btn_AKeySwap,true);
         TGameUtil.setButtonMode(this.FMC_Btn_Inherit,true);
         this.FMC_Btn_Inherit.visible = true;
         if(this.FCharacter.VipLevel >= this.FCharacter.VipData.VipOpenLevel_TeamerExpand)
         {
            this.FTeamMemberExpand = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_TeamMemberExpand,this.FCharacter.BuyHeroSlot + 1) as TTeamMemberExpand;
            if(this.FTeamMemberExpand != null)
            {
               TGameUtil.setButtonMode(this.FMC_Btn_ExtendHeros,true);
            }
            else
            {
               TGameUtil.setButtonMode(this.FMC_Btn_ExtendHeros,false);
            }
         }
         else
         {
            TGameUtil.setButtonMode(this.FMC_Btn_ExtendHeros,false);
         }
         this.FBtnList.push(this.FMC_Btn_ExtendHeros);
         this.FMC_Equip_Part = this.FMC_Heros[CONST_HEROS.CAPACITY_MC_PartEquipment];
         this.FMC_Accessor_Part = this.FMC_Heros[CONST_HEROS.CAPACITY_MC_PartAccesspory];
         this.FMC_Ring_Part = new TUIRing(this);
         this.FMC_Ring_Part.OnItemOver = this.SlotsOnMove;
         this.FMC_Ring_Part.OnItemOut = this.SlotsOnOut;
         this.FMC_Ring_Part.EffectGenerateText = EffectGenerateText;
         this.FMC_Ring_Part.Perform_UIDispatch(this.FMC_Heros[CONST_HEROS.CAPACITY_MC_PartRing]);
         this.FTF_Level = this.FMC_Heros[CONST_HEROS.RESOURCE_Link_TF_Level];
         this.FTF_Level.mouseEnabled = false;
         this.FMC_Profession = this.FMC_Heros[CONST_HEROS.RESOURCE_Link_MC_Profession];
         this.FBtn_Treasure = this.FMC_Heros[CONST_HEROS.RESOURCE_Link_Btn_Treasure];
         this.FBtn_Magic = this.FMC_Heros["Btn_Magic"];
         this.FMC_BloodFete = this.FMC_Heros["MC_BloodFete"];
         this.FMC_SoulFormation = this.FMC_Heros["MC_SoulFormation"];
         this.FMC_Wing = this.FMC_Heros["MC_Wing"];
         this.FMC_Jade = this.FMC_Heros["MC_Jade"];
         this.FMC_NinJaAwake = this.FMC_Heros["MC_Awake"];
         this.FMC_HeroPosition = this.FMC_Heros[CONST_HEROS.RESOURCE_Link_MC_HeroPosition] as Sprite;
         this.FMC_Attack = this.FMC_Heros[CONST_HEROS.CAPACITY_MC_PartEquipment][CONST_HEROS.RESOURCE_Link_MC_Attack];
         this.FAccessory_Suit_Arrti = this.FMC_Heros[CONST_HEROS.CAPACITY_MC_PartAccesspory]["TF_Suit_value"];
         _loc2_ = int(CAPACITY_MC_SlotsEquipment);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc4_ = new TUISlot(this);
            _loc4_.Resource = this.FMC_Heros[CONST_HEROS.CAPACITY_MC_PartEquipment][CONST_HEROS.RESOURCE_Link_MC_SlotsEquipment + _loc1_] as Sprite;
            _loc4_.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
            _loc4_.Tag = _loc1_;
            _loc4_.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
            _loc4_.OnQueryAdvancedEquip = this.SlotsOnQueryAdvancedEquip;
            _loc4_.OnQuerySubscript = this.SlotsOnQuerySubscript;
            _loc4_.OnQueryEuqipLevel = this.SlotsOnQueryEuqipLevel;
            _loc4_.OnClick = this.SlotsEquipmentMountedOnClick;
            _loc4_.OnAdvancedEquipClick = this.SlotsAdvancedEquipOnClick;
            _loc4_.OnOverlay = this.SlotsOnMove;
            _loc4_.OnOut = this.SlotsOnOut;
            _loc4_.Init();
            this.FSlotsEquipmentMounted[_loc1_] = _loc4_;
            _loc1_++;
         }
         _loc2_ = int(CAPACITY_MC_SlotsAccessory);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc4_ = new TUISlot(this);
            _loc4_.Resource = this.FMC_Heros[CONST_HEROS.CAPACITY_MC_PartAccesspory][CONST_HEROS.RESOURCE_Link_MC_SlotsEquipment + _loc1_] as Sprite;
            _loc4_.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
            _loc4_.Tag = _loc1_;
            _loc4_.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
            _loc4_.OnQueryAdvancedEquip = this.SlotsOnQueryAdvancedEquip;
            _loc4_.OnQuerySubscript = this.SlotsOnQuerySubscript;
            _loc4_.OnQueryEuqipLevel = this.SlotsOnQueryEuqipLevel;
            _loc4_.OnClick = this.SlotsEquipmentMountedOnClick;
            _loc4_.OnAdvancedEquipClick = this.SlotsAdvancedEquipOnClick;
            _loc4_.OnOverlay = this.SlotsOnMove;
            _loc4_.OnOut = this.SlotsOnOut;
            _loc4_.Init();
            this.FSlotsAccessoryMounted[_loc1_] = _loc4_;
            _loc1_++;
         }
         this.FMC_Btn_AllUnload = this.FMC_Heros[CONST_HEROS.RESOURCE_Link_MC_Btn_AllUnload];
         TGameUtil.setButtonMode(this.FMC_Btn_AllUnload,true);
         this.FBtnList.push(this.FMC_Btn_AllUnload);
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
         this.FMC_ComboBox = this.FMC_Heros[CONST_HEROS.CAPACITY_MC_PartEquipment][CONST_HEROS.RESOURCE_Link_MC_ComboBox] as Sprite;
         this.FMC_HeroSkill = this.FMC_Heros[CONST_HEROS.CAPACITY_MC_PartEquipment][CONST_HEROS.RESOURCE_Link_MC_HeroSkill];
         this.FTF_SkillAttack = this.FMC_HeroSkill[CONST_HEROS.RESOURCE_Link_TF_SkillAttack];
         this.FTF_Talent = this.FMC_Heros[CONST_HEROS.CAPACITY_MC_PartEquipment][CONST_HEROS.RESOURCE_Link_TF_Talent];
         this.FItemList = new Vector.<DisplayObject>();
         this.FSkillAttackComboBox = new TComboBox(this,this.FMC_ComboBox,this.FItemList,SIZE_ComboboxHeight,this.ComboBoxOnSelect);
         this.FSkillAttackComboBox.SendMouseEvent = this.CheckInBox;
         this.FTF_TacticalDeployment = this.FMC_Heros[CONST_HEROS.CAPACITY_MC_PartEquipment][CONST_HEROS.RESOURCE_Link_TF_TacticalDeployment];
         this.FMC_Btn_Dismiss = this.FMC_Heros[CONST_HEROS.CAPACITY_MC_PartEquipment][CONST_HEROS.RESOURCE_Link_MC_Btn_Dismiss];
         TGameUtil.setButtonMode(this.FMC_Btn_Dismiss,true);
         this.FBtnList.push(this.FMC_Btn_Dismiss);
         _loc3_ = this.FMC_Heros[CONST_HEROS.RESOURCE_Link_MC_Tab_Equipment];
         _loc3_.mouseChildren = false;
         this.FUITabInventory.SetTabByIndex(_loc3_,0);
         this.FUITabInventory.SetTabCaptionByIndex(STRING_TabCaption_Equipment,0);
         _loc3_ = this.FMC_Heros[CONST_HEROS.RESOURCE_Link_MC_Tab_Appliance];
         _loc3_.mouseChildren = false;
         this.FUITabInventory.SetTabByIndex(_loc3_,1);
         this.FUITabInventory.SetTabCaptionByIndex(STRING_TabCaption_Appliance,1);
         _loc3_ = this.FMC_Heros[CONST_HEROS.RESOURCE_Link_MC_Tab_Accessory];
         _loc3_.mouseChildren = false;
         this.FUITabInventory.SetTabByIndex(_loc3_,2);
         this.FUITabInventory.SetTabCaptionByIndex(STRING_TabCaption_Accessory,2);
         this.FUITabInventory.OnSwitch = this.TabInventoryOnSwitch;
         this.FUITabInventory.Init();
         _loc3_ = this.FMC_Heros[CONST_HEROS.RESOURCE_MC_Tab_Equipment_R];
         _loc3_.mouseChildren = false;
         this.FUITabInventoryNew.SetTabByIndex(_loc3_,0);
         this.FUITabInventoryNew.SetTabCaptionByIndex(STRING_TabCaption_Equipment,0);
         _loc3_ = this.FMC_Heros[CONST_HEROS.RESOURCE_MC_Tab_Accessory_R];
         _loc3_.mouseChildren = false;
         this.FUITabInventoryNew.SetTabByIndex(_loc3_,1);
         this.FUITabInventoryNew.SetTabCaptionByIndex(STRING_TabCaption_Accessory,1);
         this.FMC_Ring_Tap = this.FMC_Heros[CONST_HEROS.RESOURCE_MC_Tab_Ring_R];
         this.FMC_Ring_Tap.mouseChildren = false;
         this.FUITabInventoryNew.SetTabByIndex(this.FMC_Ring_Tap,2);
         this.FUITabInventoryNew.SetTabCaptionByIndex(STRING_TabCaption_Ring,2);
         this.FUITabInventoryNew.OnSwitch = this.TabInventoryOnSwitchNew;
         this.FUITabInventoryNew.Init();
         this.FMC_EarList[0] = this.FMC_Heros[CONST_HEROS.RESOURCE_Link_MC_Ear + 0];
         this.FMC_EarList[1] = this.FMC_Heros[CONST_HEROS.RESOURCE_Link_MC_Ear + 1];
         _loc2_ = int(CAPACITY_Backpack_Slots);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc4_ = new TUISlot(this);
            _loc4_.Resource = this.FMC_Heros[CONST_HEROS.RESOURCE_Link_MC_SlotsUserAssets + _loc1_] as Sprite;
            _loc4_.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
            _loc4_.Tag = _loc1_;
            _loc4_.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
            _loc4_.OnQueryAdvancedEquip = this.SlotsOnQueryAdvancedEquip;
            _loc4_.OnQuerySubscript = this.SlotsOnQuerySubscript;
            _loc4_.OnQueryEuqipLevel = this.SlotsOnQueryEuqipLevel;
            _loc4_.OnClick = this.SlotsUserAssetsOnClick;
            _loc4_.OnAdvancedEquipClick = this.SlotsAdvancedEquipOnClick;
            _loc4_.OnOverlay = this.SlotsOnMoveCopy;
            _loc4_.OnOut = this.SlotsOnOut;
            _loc4_.Init();
            this.FSlotsUserAssets[_loc1_] = _loc4_;
            _loc1_++;
         }
         _loc7_ = this.FMC_Heros[CONST_HEROS.RESOURCE_Link_MC_PageLeft];
         this.FUIPage.ButtonPrevious.Substrate = _loc7_;
         _loc7_ = this.FMC_Heros[CONST_HEROS.RESOURCE_Link_MC_PageRight];
         this.FUIPage.ButtonNext.Substrate = _loc7_;
         _loc8_ = this.FMC_Heros[CONST_HEROS.RESOURCE_Link_TF_Page];
         this.FUIPage.LabelPage = _loc8_;
         _loc8_.text = "0/0";
         this.FUIPage.PageSize = CAPACITY_Backpack_Slots;
         this.FUIPage.Init();
         this.FInitializationSlots = true;
         this.FUIHero = new TUIHero(this);
         this.FMC_HeroPosition.addChild(this.FUIHero);
         this.FUIHero.OnQuerySequenceContext = this.HeroOnQuerySequenceContext;
         this.FUIHero.DefaultRole = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_DefaultRoleTexture) as Sprite;
         this.FMC_HeroPosition.addChild(this.FEffectFatherSpr);
         this.FMC_Assess = this.FMC_Heros[CONST_HEROS.RESOURCE_Link_MC_Assess];
         this.FUIWindowEditor = new TUIWindowEditor(this.Parent,CONST_MODULES.MODULE_Heros);
         this.FUIWindowEditor.OnOK = this.WindowEditorOnOK;
         this.FUIWindowEditor.OnCancel = this.WindowEditorOnCancel;
         this.FUIWindowEditor.OnMax = this.WindowEditorOnMax;
         this.FUIWindowEditor.x = (CONST_COMMON.STAGE_Width - this.FUIWindowEditor.WindowWidth) / 2;
         this.FUIWindowEditor.y = (CONST_COMMON.STAGE_Height - this.FUIWindowEditor.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowEditor(this.FUIWindowEditor);
         this.FMC_Information = this.FMC_Heros[CONST_HEROS.RESOURCE_Link_MC_Information];
         this.FMC_OpenInfomation = this.FMC_Information[CONST_HEROS.RESOURCE_Link_MC_OpenInfomation];
         this.FMC_OpenInfomation.visible = false;
         this.FMC_ClosingState = this.FMC_OpenInfomation[CONST_HEROS.RESOURCE_Link_MC_ClosingState];
         _loc3_ = this.FMC_ClosingState["MC_Pve"];
         this.FUITabInventoryNewCopy.SetTabByIndex(_loc3_,0);
         _loc3_ = this.FMC_ClosingState["MC_Pvp"];
         this.FUITabInventoryNewCopy.SetTabByIndex(_loc3_,1);
         this.FUITabInventoryNewCopy.OnSwitch = this.TabInventoryOnSwitchNewCopy;
         this.FUITabInventoryNewCopy.Init();
         this.FBtn_CloseInfomation = this.FMC_OpenInfomation[CONST_HEROS.RESOURCE_Link_Btn_CloseInfomation];
         TGameUtil.setButtonMode(this.FBtn_CloseInfomation,true);
         this.FMC_CLoseInfomation = this.FMC_Information[CONST_HEROS.RESOURCE_Link_MC_CLoseInfomation];
         this.FMC_CLoseInfomation.visible = true;
         this.FMC_OpeningState = this.FMC_CLoseInfomation[CONST_HEROS.RESOURCE_Link_MC_OpeningState];
         this.FBtn_OpenInfomation = this.FMC_CLoseInfomation[CONST_HEROS.RESOURCE_Link_Btn_OpenInfomation];
         TGameUtil.setButtonMode(this.FBtn_OpenInfomation,true);
         this.FMC_ShowAllEquip = this.FMC_Heros[CONST_HEROS.RESOURCE_Link_MC_ShowAllEquip];
         this.FBtn_ShowAllEquip = this.FMC_ShowAllEquip[CONST_HEROS.RESOURCE_Link_Btn_ShowAllEquip];
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
         this.FUIWindowConfirmationDismiss = new TUIWindowConfirmation(this.Parent);
         this.FUIWindowConfirmationDismiss.OnOK = this.DismissOnOk;
         this.FUIWindowConfirmationDismiss.x = (STAGE_Width - this.FUIWindowConfirmationDismiss.WindowWidth) / 2;
         this.FUIWindowConfirmationDismiss.y = (STAGE_Height - this.FUIWindowConfirmationDismiss.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowConfirmationDismiss);
         this.FUIWindowConfirmationBugHeroSlot = new TUIWindowConfirmation(this.Parent);
         this.FUIWindowConfirmationBugHeroSlot.OnOK = this.BugHeroSlotOk;
         this.FUIWindowConfirmationBugHeroSlot.x = (STAGE_Width - this.FUIWindowConfirmationBugHeroSlot.WindowWidth) / 2;
         this.FUIWindowConfirmationBugHeroSlot.y = (STAGE_Height - this.FUIWindowConfirmationBugHeroSlot.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowConfirmationBugHeroSlot);
         this.FMC_TitleManage = this.FMC_Heros[CONST_HEROS.CAPACITY_MC_PartEquipment]["MC_TitleManage"];
         TGameUtil.setButtonMode(this.FMC_TitleManage,true);
         this.FMC_TitleEffect = this.FMC_Heros["MC_TitleEffect"];
         this.FMC_TitleEffect.addChild(this.FTitleBmp);
         this.FMC_LittlePetEffect = this.FMC_Heros["MC_LittlePetEffect"];
         if(this.FMC_LittlePetEffect != null)
         {
            this.FMC_LittlePetEffect.addChild(this.FLittlePetBmp);
         }
         this.FActivityPetConfigBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_ActivityPetConfig);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerSprite);
         this.FMvcInherit = this.FMC_Heros["qianneng"]["MVC_in"] as SimpleButton;
         TextField(this.FMC_Heros["qianneng"]["MVC_tem"]["TF_FightingCapacity"]).selectable = false;
         this.FMC_Heros["qianneng"]["MVC_tem"].mouseEnabled = false;
         this.FMC_Heros["qianneng"]["MVC_tem"].mouseChildren = false;
         this.FMvcTongLing = this.FMC_Heros["M_TongLing"] as SimpleButton;
         this.FMC_SaiXuanJiNeng = this.FMC_Heros[CONST_HEROS.CAPACITY_MC_PartEquipment]["MC_SaiXuanJiNeng"];
         if(this.FMC_SaiXuanJiNeng)
         {
            TGameUtil.setButtonMode(this.FMC_SaiXuanJiNeng["MC_SaiXuan"]["mc_0"]["btn_showlist"],true);
            this.FTF_Name = this.FMC_SaiXuanJiNeng["MC_SaiXuan"]["mc_0"]["TF_Name"];
            _loc1_ = 0;
            while(_loc1_ < 4)
            {
               this.FMC_SaiXuanJiNeng_Vector[_loc1_] = this.FMC_SaiXuanJiNeng["MC_SaiXuan"]["mc_list"]["mc_" + _loc1_];
               this.FMC_SaiXuanJiNeng_Vector[_loc1_].buttonMode = true;
               _loc1_++;
            }
            this.FMC_SaiXuanJiNeng.visible = false;
         }
         _loc9_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.AccessoryIntensityLevel) as TConfigValue;
         this.FAccessoryIntensityLevel = _loc9_.Value as int;
         _loc9_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.UNLOCK_Talisman) as TConfigValue;
         this.FColorConfig = _loc9_.Value as Vector.<Object>;
         _loc9_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.NinjaReincarnaton_OpenOrClose) as TConfigValue;
         this.FCharacter.LimitiExpGrow = _loc9_.Value as int;
         _loc9_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.NinjaReincarnaton_LevelNeedOne) as TConfigValue;
         this.FCharacter.ReinCarnationOneNeed = _loc9_.Value as int;
         _loc9_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.NinjaHostel_LevelOpenCount) as TConfigValue;
         this.FOpenNinjaHostel = _loc9_.Value as int;
         _loc9_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.NinjaHostel_RecallCost) as TConfigValue;
         this.FRecallCost = _loc9_.Value as Vector.<Object>;
         this.FLimitSkillCount = SLogicsCore.Character.GetConfigValueById(91000005);
         if(SLogicsCore.Character.GetConfigValueById(91000003))
         {
            this.FNiMeiA = true;
            if(this.FMC_SaiXuanJiNeng)
            {
               this.FMC_SaiXuanJiNeng.visible = true;
            }
         }
         else if(this.FMC_SaiXuanJiNeng)
         {
            this.FMC_SaiXuanJiNeng.visible = false;
         }
         this.FOverlayerSoulFormation = new TOverlayerSoulFormation(this.Parent);
         this.FOverlayerSoulFormation.Visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerSoulFormation);
         this.FOverlayerWing = new TOverlayerWing(this.Parent);
         this.FOverlayerWing.Visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerWing);
         super.ResourcesPerform_UIDispatch();
      }
      
      public function InClick(param1:MouseEvent) : void
      {
         if(this.FOnShortcutHyperlinks != null)
         {
            this.FOnShortcutHyperlinks(this,CONST_SHORTCUTS.POSITION_Function,CONST_SHORTCUTS.TYPE_Function_InheritPractice,0,null);
         }
      }
      
      protected function GetHeroLevel() : int
      {
         var _loc1_:THeros = this.FCharacter.Heros;
         var _loc2_:THero = _loc1_.GetHeroByIndex(0);
         return int(_loc2_.Level);
      }
      
      public function InClickT(param1:MouseEvent) : void
      {
         if(this.FOnShortcutHyperlinks != null)
         {
            this.FOnShortcutHyperlinks(this,CONST_SHORTCUTS.POSITION_Function,CONST_SHORTCUTS.TYPE_Function_TongLing,0,null);
         }
      }
      
      public function InOver(param1:MouseEvent) : void
      {
         this.FOverTip.OpenLeve = this.QianNengOpenLv;
         this.FOverTip.herolevel = this.FCharacter.GetMainLevel();
         this.FOverTip.Context = this.FCurHero;
         this.FOverTip.Render(FUICore.MouseCoordinate);
         this.FOverTip.Show();
      }
      
      public function InOut(param1:MouseEvent) : void
      {
         this.FOverTip.Hide();
      }
      
      public function InOverT(param1:MouseEvent) : void
      {
         this.FMC_LittlePetEffect.filters = [new GlowFilter(3394560,1,5,5,20)];
         this.FOverTipT.Context = this.FCharacter.GetMainLevel();
         this.FOverTipT.Render(FUICore.MouseCoordinate);
         this.FOverTipT.Show();
      }
      
      public function InMoveT(param1:MouseEvent) : void
      {
         this.FOverTipT.Render(FUICore.MouseCoordinate);
      }
      
      public function InOutT(param1:MouseEvent) : void
      {
         this.FMC_LittlePetEffect.filters = [];
         this.FOverTipT.Hide();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TextField = null;
         var _loc5_:TConfigValue = null;
         var _loc6_:int = 0;
         this.FMvcInherit.addEventListener(MouseEvent.CLICK,this.InClick);
         this.FMvcInherit.addEventListener(MouseEvent.MOUSE_MOVE,this.InOver);
         this.FMvcInherit.addEventListener(MouseEvent.ROLL_OUT,this.InOut);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverTip);
         this.FMvcTongLing.addEventListener(MouseEvent.CLICK,this.InClickT);
         this.FMvcTongLing.addEventListener(MouseEvent.MOUSE_MOVE,this.InMoveT);
         this.FMvcTongLing.addEventListener(MouseEvent.MOUSE_OVER,this.InOverT);
         this.FMvcTongLing.addEventListener(MouseEvent.MOUSE_OUT,this.InOutT);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverTipT);
         this.FBtn_Close.addEventListener(MouseEvent.CLICK,this.ButtonCloseOnClick,false,0,true);
         this.FBtn_Help.addEventListener(MouseEvent.MOUSE_MOVE,this.ButtonHelpOnOver,false,0,true);
         this.FBtn_Help.addEventListener(MouseEvent.MOUSE_OUT,this.ButtonHelpOnOut,false,0,true);
         this.FMC_Btn_ExtendHeros.addEventListener(MouseEvent.CLICK,this.BtnExtendHerosOnClick,false,0,true);
         this.FMC_Btn_ExtendHeros.addEventListener(MouseEvent.MOUSE_MOVE,this.BtnExtendHerosHintOnOver,false,0,true);
         this.FMC_Btn_ExtendHeros.addEventListener(MouseEvent.ROLL_OUT,this.BtnExtendHerosHintOnOut,false,0,true);
         this.FMC_Btn_AKeySwap.addEventListener(MouseEvent.CLICK,this.BtnAKeySwapOnClick,false,0,true);
         this.FMC_Btn_Inherit.addEventListener(MouseEvent.CLICK,this.BtnInheritOnClick,false,0,true);
         this.FBtn_Treasure.addEventListener(MouseEvent.CLICK,this.BtnTreasureOnClick,false,0,true);
         this.FBtn_Treasure.addEventListener(MouseEvent.MOUSE_MOVE,this.BtnTreasureHintOnOver,false,0,true);
         this.FBtn_Treasure.addEventListener(MouseEvent.MOUSE_OUT,this.BtnTreasureHintOnOut,false,0,true);
         if(this.FBtn_Magic != null)
         {
            this.FBtn_Magic.addEventListener(MouseEvent.CLICK,this.BtnMagicOnClick,false,0,true);
            this.FBtn_Magic.addEventListener(MouseEvent.MOUSE_MOVE,this.BtnMagicHintOnOver,false,0,true);
            this.FBtn_Magic.addEventListener(MouseEvent.MOUSE_OUT,this.BtnMagicHintOnOut,false,0,true);
         }
         if(this.FMC_BloodFete != null)
         {
            this.FMC_BloodFete.addEventListener(MouseEvent.CLICK,this.BloodFeteOnClick,false,0,true);
            this.FMC_BloodFete.addEventListener(MouseEvent.MOUSE_MOVE,this.BloodFeteOnOver,false,0,true);
            this.FMC_BloodFete.addEventListener(MouseEvent.MOUSE_OUT,this.BloodFeteOnOut,false,0,true);
         }
         if(this.FMC_SoulFormation != null)
         {
            _loc5_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,91000020) as TConfigValue;
            _loc3_ = _loc5_.Value as int;
            if(this.FCharacter.MainHero.Level >= _loc3_)
            {
               this.FMC_SoulFormation.visible = true;
            }
            else
            {
               this.FMC_SoulFormation.visible = false;
            }
            this.FMC_SoulFormation.addEventListener(MouseEvent.CLICK,this.SoulFormationOnClick);
            this.FMC_SoulFormation.addEventListener(MouseEvent.MOUSE_MOVE,this.SoulFormationOnOver);
            this.FMC_SoulFormation.addEventListener(MouseEvent.ROLL_OUT,this.SoulFormationOnOut);
         }
         if(this.FMC_Wing != null)
         {
            _loc5_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,91300007) as TConfigValue;
            _loc3_ = _loc5_.Value as int;
            if(this.FCharacter.MainHero.Level >= _loc3_)
            {
               this.FMC_Wing.visible = true;
            }
            else
            {
               this.FMC_Wing.visible = false;
            }
            this.FMC_Wing.addEventListener(MouseEvent.CLICK,this.WingOnClick);
            this.FMC_Wing.addEventListener(MouseEvent.MOUSE_MOVE,this.WingOnOver);
            this.FMC_Wing.addEventListener(MouseEvent.ROLL_OUT,this.WingOnOut);
         }
         this.FMC_Btn_AllUnload.addEventListener(MouseEvent.CLICK,this.BtnAllUnloadOnClick);
         this.FMC_Btn_Dismiss.addEventListener(MouseEvent.CLICK,this.BtnDismissOnClick,false,0,true);
         this.FTF_FightingCapacity.addEventListener(MouseEvent.MOUSE_MOVE,this.TFFightingCapacityOnMove,false,0,true);
         this.FTF_FightingCapacity.addEventListener(MouseEvent.MOUSE_OUT,this.TFFightingCapacityOnOut,false,0,true);
         this.FBtn_OpenInfomation.addEventListener(MouseEvent.CLICK,this.BtnOpenInfomationOnClick,false,0,true);
         this.FBtn_CloseInfomation.addEventListener(MouseEvent.CLICK,this.BtnCloseInfomationOnClick,false,0,true);
         this.FBtn_ShowAllEquip.addEventListener(MouseEvent.CLICK,this.BtnShowAllEquipOnClick,false,0,true);
         _loc2_ = int(CAPACITY_TF_BaseAttributes);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc4_ = this.FTF_BaseAttributes[_loc1_];
            _loc4_.addEventListener(MouseEvent.MOUSE_MOVE,this.TFBaseAttributesHintOnOver,false,0,true);
            _loc4_.addEventListener(MouseEvent.MOUSE_OUT,this.TFHintOnOut,false,0,true);
            _loc1_++;
         }
         this.FTF_Talent.addEventListener(MouseEvent.MOUSE_MOVE,this.TFTalentHintOnOver,false,0,true);
         this.FTF_Talent.addEventListener(MouseEvent.MOUSE_OUT,this.TFHintOnOut,false,0,true);
         this.FMC_Assess.addEventListener(MouseEvent.MOUSE_MOVE,this.MC_AssessHintOnOver,false,0,true);
         this.FMC_Assess.addEventListener(MouseEvent.MOUSE_OUT,this.TFHintOnOut,false,0,true);
         this.FTF_SkillAttack.addEventListener(MouseEvent.MOUSE_MOVE,this.TFSkillAttackHintOnOver,false,0,true);
         this.FTF_SkillAttack.addEventListener(MouseEvent.MOUSE_OUT,this.TFHintOnOut,false,0,true);
         this.FMC_Btn_Dismiss.addEventListener(MouseEvent.MOUSE_MOVE,this.MCBtnDismissHintOnOver,false,0,true);
         this.FMC_Btn_Dismiss.addEventListener(MouseEvent.MOUSE_OUT,this.TFHintOnOut,false,0,true);
         this.FMC_TitleEffect.addEventListener(MouseEvent.MOUSE_MOVE,this.MCTitleEffectOnOver,false,0,true);
         this.FMC_TitleEffect.addEventListener(MouseEvent.MOUSE_OUT,this.MCTitleEffectOnOut,false,0,true);
         if(this.FMC_LittlePetEffect != null)
         {
            this.FMC_LittlePetEffect.addEventListener(MouseEvent.MOUSE_MOVE,this.InMoveT,false,0,true);
            this.FMC_LittlePetEffect.addEventListener(MouseEvent.MOUSE_OUT,this.InOutT,false,0,true);
            this.FMC_LittlePetEffect.addEventListener(MouseEvent.MOUSE_OVER,this.InOverT);
            this.FMC_LittlePetEffect.addEventListener(MouseEvent.CLICK,this.InClickT);
         }
         this.FMC_TitleManage.addEventListener(MouseEvent.CLICK,this.TitleManageOnClick,false,0,true);
         this.FSkillAttackComboBox.OnDropBarMove = this.TFComboBoxBarHintOnOver;
         this.FSkillAttackComboBox.OnDropListMove = this.TFComboBoxListHintOnOver;
         this.FSkillAttackComboBox.OnDropListOut = this.TFHintOnOut;
         this.FUIPage.OnChangePage = this.PageOnChange;
         this.FHeroPage.OnChangePage = this.HeroPageOnChange;
         _loc5_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.TongLing_Open) as TConfigValue;
         this.opLevel = _loc5_.Value as uint;
         _loc5_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.NinjaUpgrade_OpenLv) as TConfigValue;
         this.QianNengOpenLv = _loc5_.Value as uint;
         _loc5_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.FollowBloodBound_Function_OpenLevel) as TConfigValue;
         this.BloodFeteOpenLv = _loc5_.Value as uint;
         _loc5_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,91600002) as TConfigValue;
         this.JadeOpenLv = _loc5_.Value as int;
         this.addChalleng_btn(this.FCharacter.GetMainLevel());
         if(this.FMC_SaiXuanJiNeng)
         {
            _loc6_ = 0;
            while(_loc6_ < 4)
            {
               this.FMC_SaiXuanJiNeng_Vector[_loc6_].addEventListener(MouseEvent.CLICK,this.SaiXuanJiNengClick);
               this.FMC_SaiXuanJiNeng_Vector[_loc6_].addEventListener(MouseEvent.MOUSE_OVER,this.SaiXuanJiNengOver);
               this.FMC_SaiXuanJiNeng_Vector[_loc6_].addEventListener(MouseEvent.MOUSE_OUT,this.SaiXuanJiNengOut);
               _loc6_++;
            }
            this.FMC_SaiXuanJiNeng["MC_SaiXuan"]["mc_0"]["btn_showlist"].addEventListener(MouseEvent.CLICK,this.SaiXuanshowlistClick);
         }
         if(this.FMC_Jade)
         {
            if(this.FCharacter.MainHero.Level >= this.JadeOpenLv)
            {
               this.FMC_Jade.addEventListener(MouseEvent.CLICK,this.JadeOnClick);
            }
            this.FMC_Jade.addEventListener(MouseEvent.MOUSE_MOVE,this.JadeOnOver,false,0,true);
            this.FMC_Jade.addEventListener(MouseEvent.MOUSE_OUT,this.JadeOnOut,false,0,true);
            TUtilityUIOverlayer.ResourcesDispatch(this.FOverJadeTip);
         }
         if(this.FMC_NinJaAwake)
         {
            this.FMC_NinJaAwake.addEventListener(MouseEvent.MOUSE_MOVE,this.NinJaAwakeOver);
            this.FMC_NinJaAwake.addEventListener(MouseEvent.MOUSE_OUT,this.NinJaAwakeOut);
            TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerNinJaAwake);
         }
         super.ResourcesPerform_UILocations();
      }
      
      protected function SaiXuanJiNengOut(param1:MouseEvent) : void
      {
         param1.currentTarget.gotoAndStop(1);
      }
      
      protected function SaiXuanJiNengOver(param1:MouseEvent) : void
      {
         param1.currentTarget.gotoAndStop(2);
      }
      
      protected function SaiXuanJiNengClick(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case this.FMC_SaiXuanJiNeng_Vector[0]:
               this.FCurSkillindex = 0;
               break;
            case this.FMC_SaiXuanJiNeng_Vector[1]:
               this.FCurSkillindex = 1;
               break;
            case this.FMC_SaiXuanJiNeng_Vector[2]:
               this.FCurSkillindex = 2;
               break;
            case this.FMC_SaiXuanJiNeng_Vector[3]:
               this.FCurSkillindex = 3;
         }
         this.UpdateForLittleSkill();
         this.SetVisibelByValue(false);
         this.CharacterUpdateSkills();
      }
      
      protected function SaiXuanshowlistClick(param1:MouseEvent) : void
      {
         if(Boolean(this.FMC_SaiXuanJiNeng) && this.FNiMeiA)
         {
            if(this.FMC_SaiXuanJiNeng["MC_SaiXuan"]["mc_list"].visible)
            {
               this.SetVisibelByValue(false);
            }
            else
            {
               this.SetVisibelByValue(true);
            }
         }
      }
      
      protected function CheckInBox(param1:Number, param2:Number) : void
      {
         if(this.FMC_SaiXuanJiNeng)
         {
            if(!this.FMC_SaiXuanJiNeng.hitTestPoint(param1,param2))
            {
               this.SetVisibelByValue(false);
            }
         }
      }
      
      public function SetVisibelByValue(param1:Boolean) : void
      {
         if(this.FMC_SaiXuanJiNeng)
         {
            this.FMC_SaiXuanJiNeng["MC_SaiXuan"]["mc_list"].visible = param1;
            this.FTF_Name.text = STRING_HEROS.STRING_NewSkillTitel[this.FCurSkillindex];
         }
      }
      
      protected function UpdateForLittleSkill() : void
      {
         var _loc1_:THero = null;
         _loc1_ = this.FCharacter.Heros.GetHeroByIndex(this.FTabHeroIndex);
         _loc1_.SetCopySkillsByIndex(this.FCurSkillindex);
      }
      
      private function addChalleng_btn(param1:int = -1) : void
      {
         if(param1 >= 40)
         {
            TGameUtil.setButtonMode(this.FMC_Heros["MC_Challenge_Btn"],true);
            this.FMC_Heros["MC_Challenge_Btn"].addEventListener(MouseEvent.CLICK,this.OnGoToHerosFightWindow);
         }
         else if(param1 < 40)
         {
            this.FMC_Heros["MC_Challenge_Btn"].visible = false;
         }
         if(param1 >= this.BloodFeteOpenLv)
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
      }
      
      override protected function ResourcesPerform_UIFinalize() : void
      {
         var _loc1_:TConfigValue = null;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.Mew_OpenLv) as TConfigValue;
         this.FMagicOpenLv = _loc1_.Value as uint;
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
         if(this.FMC_Ring_Part.visible)
         {
            this.FMC_Ring_Part.LogicsPerform();
         }
         this.FUIWindowEditor.Update();
         this.UpdateTitleEffect();
         this.UpdateLittlePetEffect();
         this.UpdateTitleManageEffect();
         this.upDateEffectImage();
         if(THomelandModel.selfHome.ringId == 0 || THomelandModel.selfHome.status == 0)
         {
            this.FMC_Ring_Tap.visible = false;
         }
         else
         {
            this.FMC_Ring_Tap.visible = true;
         }
      }
      
      protected function OnGoToHerosFightWindow(param1:MouseEvent) : void
      {
         var _loc2_:TSystemLanguage = null;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.ChatChannel_01) as TSystemLanguage;
         if(this.FCharacter.RoleSencePosition != CONST_COMMON.SCENEPOSITION_MAINCITY)
         {
            EffectGenerateText(_loc2_.Desc);
            return;
         }
         if(this.GoToHerosFightWindow != null)
         {
            this.GoToHerosFightWindow(this);
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
         _loc2_ = int(CAPACITY_Backpack_Slots);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FSlotsUserAssets[_loc1_];
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
            _loc6_.LoadSecondary(_loc10_.Model,CONST_MODULES.MODULE_Heros);
            this.FUIHero.X = 0;
            this.FUIHero.Y = 0;
         }
         if(_loc5_.Identifier != this.FCharacter.MainHero.Identifier)
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
      
      protected function InventoriesUpdate() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TInventories = null;
         this.FInventories.Clear();
         _loc1_ = this.FTabInventoryIndex;
         switch(_loc1_)
         {
            case INVENTORIESINDEX_Heros_Equipments:
               _loc2_ = this.FCharacter.Equipments;
               _loc2_.SortCopy();
               break;
            case INVENTORIESINDEX_Heros_Appliances:
               _loc2_ = this.FCharacter.Appliances;
               break;
            case INVENTORIESINDEX_Heros_Accessories:
               _loc2_ = this.FCharacter.Accessories;
               _loc2_.SortCopy();
         }
         if(_loc1_ == INVENTORIESINDEX_Heros_Equipments && this.FIsShowAllEquip)
         {
            _loc1_ = 0;
            while(_loc1_ < _loc2_.Count)
            {
               this.FInventories.Add(_loc2_.GetInventoryByIndex(_loc1_));
               _loc1_++;
            }
            return;
         }
         if(_loc1_ == INVENTORIESINDEX_Heros_Accessories && this.FIsShowAllEquip)
         {
            _loc1_ = 0;
            while(_loc1_ < _loc2_.Count)
            {
               this.FInventories.Add(_loc2_.GetInventoryByIndex(_loc1_));
               _loc1_++;
            }
            return;
         }
         this.ProcessorInventories(_loc2_);
      }
      
      protected function ProcessorInventories(param1:TInventories) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:TInventory = null;
         var _loc8_:Boolean = false;
         var _loc9_:Vector.<Function> = null;
         var _loc10_:Function = null;
         var _loc11_:THero = null;
         _loc11_ = this.FCharacter.Heros.GetHeroByIndex(this.FTabHeroIndex);
         _loc6_ = this.FTabInventoryIndex;
         switch(_loc6_)
         {
            case INVENTORIESINDEX_Heros_Equipments:
               _loc9_ = this.FFilterEquipments;
               break;
            case INVENTORIESINDEX_Heros_Appliances:
               _loc9_ = this.FFilterAppliances;
               break;
            case INVENTORIESINDEX_Heros_Accessories:
               _loc9_ = this.FFilterAccessory;
         }
         _loc3_ = param1.Count;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc8_ = false;
            _loc7_ = param1.GetInventoryByIndex(_loc2_);
            _loc5_ = int(_loc9_.length);
            _loc4_ = 0;
            while(_loc4_ < _loc5_)
            {
               _loc10_ = _loc9_[_loc4_];
               if(_loc10_ != null)
               {
                  _loc8_ = _loc10_(_loc7_,_loc11_);
               }
               if(!_loc8_)
               {
                  break;
               }
               _loc4_++;
            }
            if(_loc8_)
            {
               this.FInventories.Add(_loc7_);
            }
            _loc2_++;
         }
      }
      
      protected function UpdateBackpackUIPage() : void
      {
         var _loc1_:int = this.FPageIndex * CAPACITY_Backpack_Slots;
         if(_loc1_ >= this.FInventories.Count)
         {
            --this.FPageIndex;
            if(this.FPageIndex < 0)
            {
               this.FPageIndex = 0;
            }
         }
         this.FUIPage.TotalQuantity = this.FInventories.Count;
         this.FUIPage.PageIndex = this.FPageIndex;
         this.FUIPage.Update();
      }
      
      public function SetZearo() : void
      {
         this.FPageIndex = 0;
      }
      
      protected function UpdateHeroUIPage() : void
      {
         this.FHeroPageIndex = 0;
         this.FCharacter.PageIndex = this.FHeroPageIndex;
         this.FHeroPage.TotalQuantity = this.FCharacter.Heros.Count;
         this.FHeroPage.PageIndex = this.FHeroPageIndex;
         this.FHeroPage.Update();
      }
      
      protected function InventoriesUpdateSlotsByInventories(param1:Vector.<TUISlot>, param2:TInventories) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:TUISlot = null;
         var _loc8_:TInventory = null;
         _loc6_ = this.FPageIndex;
         _loc4_ = int(CAPACITY_Backpack_Slots);
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc7_ = param1[_loc3_];
            _loc7_.Context = null;
            _loc7_.Resource.visible = false;
            _loc3_++;
         }
         _loc4_ = param2.Count;
         if(_loc4_ <= 0)
         {
            return;
         }
         _loc5_ = _loc6_ * CAPACITY_Backpack_Slots;
         _loc3_ = 0;
         while(_loc3_ < CAPACITY_Backpack_Slots)
         {
            if(_loc3_ + _loc5_ >= _loc4_)
            {
               break;
            }
            _loc7_ = param1[_loc3_];
            _loc8_ = param2.GetInventoryByIndex(_loc3_ + _loc5_);
            _loc7_.Context = _loc8_;
            _loc7_.Resource.visible = true;
            _loc3_++;
         }
      }
      
      protected function UpdateTabs() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:THeros = null;
         var _loc4_:THero = null;
         var _loc5_:uint = 0;
         var _loc6_:TMilitary = null;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         _loc3_ = this.FCharacter.Heros;
         _loc3_.Sort();
         _loc6_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Military,this.FCharacter.MilitaryRank) as TMilitary;
         _loc7_ = _loc6_ == null ? 5 : uint(_loc6_.MaxHeroNum);
         _loc7_ = _loc7_ + this.FCharacter.BuyHeroSlot;
         _loc2_ = _loc3_.Count;
         _loc1_ = 0;
         while(_loc1_ < CAPACITY_TF_HerosName)
         {
            _loc8_ = _loc1_ + this.FHeroPageIndex * CAPACITY_TF_HerosName;
            if(_loc8_ >= _loc2_)
            {
               this.FUITabHeros.SetTabHideByIndex(_loc1_);
            }
            else
            {
               _loc4_ = _loc3_.GetHeroByIndex(_loc8_);
               _loc5_ = QUALITYCOLOR_INDEX[_loc4_.Quality];
               this.FUITabHeros.SetTabCaptionByIndex(_loc4_.Name,_loc1_,_loc5_);
               this.FUITabHeros.SetTabShowByIndex(_loc1_);
            }
            _loc1_++;
         }
         this.FTF_CurrentNumber.text = TUtilityString.Format(STRING_Capacity,_loc2_,_loc7_);
      }
      
      protected function UpdateRoleModel() : void
      {
         var _loc1_:THero = null;
         var _loc2_:TBaseHero = null;
         if(this.FCharacter.Heros.Count <= this.FTabHeroIndex)
         {
            this.FTabHeroIndex = 0;
         }
         _loc1_ = this.FCharacter.Heros.GetHeroByIndex(this.FTabHeroIndex);
         this.FUIHero.Context = _loc1_;
         this.FCurHero = _loc1_;
         TextField(this.FMC_Heros["qianneng"]["MVC_tem"]["TF_FightingCapacity"]).text = _loc1_.GetQianNengOnlyLevelStr(_loc1_.PotentialLv);
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
         _loc2_ = this.FCharacter.Heros.GetHeroByIndex(_loc1_);
         _loc3_ = _loc2_.Level;
         this.addChalleng_btn(this.FCharacter.GetMainLevel());
         this.FTF_Level.text = this.FCharacter.MainHero.GetLevelStrByLevel(_loc3_);
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
         if(_loc1_ == 0)
         {
            this.FMC_Btn_Dismiss.visible = false;
         }
         else
         {
            this.FMC_Btn_Dismiss.visible = true;
         }
         if(this.FCharacter.GetMainLevel() < this.FOpenNinjaHostel)
         {
            this.FMC_Btn_Dismiss.visible = false;
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
         _loc4_ = this.FCharacter.Heros.GetHeroByIndex(_loc3_);
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
         this.FMC_ComboBox.visible = false;
         this.FMC_HeroSkill.visible = false;
         _loc4_ = this.FCharacter.Heros.GetHeroByIndex(_loc3_);
         if(this.FNiMeiA)
         {
            this.UpdateForLittleSkill();
            _loc6_ = _loc4_.SkillsCopy;
         }
         else
         {
            _loc6_ = _loc4_.Skills;
         }
         _loc6_.Sort();
         if(_loc3_ == 0)
         {
            this.FMC_ComboBox.visible = true;
            _loc2_ = _loc6_.Count;
            this.FItemList.length = 0;
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               _loc5_ = _loc6_.GetSkillByIndex(_loc1_);
               _loc7_ = TUtilityReflection.CreateDisplayObjectInstance(RESOURCE_Link_MC_Item) as MovieClip;
               _loc7_.tf_into.text = _loc5_.Name;
               this.FItemList.push(_loc7_);
               _loc1_++;
            }
            this.FSkillAttackComboBox.ResetList(this.FItemList);
            if(Boolean(this.FMC_SaiXuanJiNeng) && Boolean(this.FNiMeiA) && _loc2_ >= this.FLimitSkillCount)
            {
               this.FMC_SaiXuanJiNeng.visible = true;
            }
         }
         else
         {
            _loc5_ = _loc6_.GetSkillByIndex(0);
            this.FTF_SkillAttack.text = _loc5_.Name;
            this.FMC_HeroSkill.visible = true;
            if(Boolean(this.FMC_SaiXuanJiNeng) && this.FNiMeiA)
            {
               this.FMC_SaiXuanJiNeng.visible = false;
            }
         }
      }
      
      protected function InventoriesUpdateEquipmentsMounted() : void
      {
         var _loc1_:int = 0;
         var _loc2_:THero = null;
         _loc1_ = this.FTabHeroIndex;
         _loc2_ = this.FCharacter.Heros.GetHeroByIndex(_loc1_);
         this.InventoriesUpdateSlotsByCollection(this.FSlotsEquipmentMounted,_loc2_.EquipmentsMounted);
         this.InventoriesUpdateSlotsByCollection(this.FSlotsAccessoryMounted,_loc2_.AccessoryMounted);
      }
      
      protected function AnalysisSuitProperty(param1:THero) : void
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
      
      protected function ShowFourAttri(param1:int, param2:int) : void
      {
         TextField(this.FMC_Heros[CONST_HEROS.CAPACITY_MC_PartAccesspory]["TF_Accessory_value_" + param2]).text = String(param1);
      }
      
      protected function AnalysisAccessoryProperty(param1:THero) : void
      {
         var _loc2_:TCollectionInventory = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:TEquipment = null;
         var _loc7_:TSuit = null;
         var _loc8_:TBaseEquip = null;
         var _loc9_:TEquipUpgrade = null;
         var _loc12_:Boolean = false;
         var _loc14_:TBaseEquip = null;
         var _loc16_:Number = NaN;
         var _loc17_:String = null;
         var _loc18_:uint = 0;
         var _loc19_:int = 0;
         var _loc20_:int = 0;
         var _loc21_:int = 0;
         var _loc10_:Vector.<uint> = new Vector.<uint>();
         _loc10_.length = 0;
         var _loc11_:String = "";
         _loc2_ = param1.AccessoryMounted;
         _loc3_ = 0;
         while(_loc3_ < _loc2_.Capacity)
         {
            _loc6_ = _loc2_.GetInventoryByIndex(_loc3_) as TEquipment;
            if(_loc6_)
            {
               _loc8_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BaseEquip,_loc6_.IDTemplate) as TBaseEquip;
               _loc9_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_EquipUpgrade,_loc6_.IDTemplate) as TEquipUpgrade;
               if(_loc6_.SuitCount >= 2)
               {
                  if(_loc10_.indexOf(_loc6_.SuitID) < 0)
                  {
                     _loc10_.push(_loc6_.SuitID);
                  }
               }
               if(Boolean(_loc8_) && Boolean(_loc8_.SuitIdArr.length == 1) && (Boolean(_loc9_) && Boolean(_loc9_.IsEpic == 2)) || Boolean(_loc8_) && Boolean(_loc8_.SuitIdArr.length > 1))
               {
                  _loc20_ = _loc8_.SuitIdArr.indexOf(_loc6_.SuitID);
                  if(Boolean(_loc6_.SuitObject) && _loc6_.SuitObject[2] == _loc20_)
                  {
                     if(_loc10_.indexOf(_loc6_.SuitID) < 0)
                     {
                        _loc10_.push(_loc6_.SuitID);
                     }
                  }
               }
            }
            _loc3_++;
         }
         if(_loc10_.length)
         {
            _loc11_ = _loc11_ + (STRING_HEROS.STRING_MoutedSuitEffect + "\r");
         }
         _loc3_ = 0;
         while(_loc3_ < _loc10_.length)
         {
            _loc11_ = _loc11_ + this.ShowSuitAttri(_loc10_[_loc3_]) + "\r";
            _loc7_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Suit,_loc10_[_loc3_]) as TSuit;
            _loc5_ = int(_loc7_.SuitEffects[0].EffectDesc.length);
            _loc4_ = 0;
            while(_loc4_ < _loc5_)
            {
               _loc11_ = _loc11_ + (_loc7_.SuitEffects[0].EffectDesc[_loc4_] + "\r");
               _loc4_++;
            }
            _loc3_++;
         }
         var _loc13_:int = -1;
         var _loc15_:Boolean = true;
         _loc3_ = 0;
         while(_loc3_ < _loc2_.Capacity)
         {
            _loc6_ = _loc2_.GetInventoryByIndex(_loc3_) as TEquipment;
            if(_loc6_ == null)
            {
               break;
            }
            _loc14_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BaseEquip,_loc6_.IDTemplate) as TBaseEquip;
            _loc9_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_EquipUpgrade,_loc6_.IDTemplate) as TEquipUpgrade;
            if(Boolean(_loc14_) && Boolean(_loc14_.EightsuitIdArr.length == 1) && (Boolean(_loc9_) && Boolean(_loc9_.IsEpic == 2)) || Boolean(_loc14_) && Boolean(_loc14_.EightsuitIdArr.length > 1))
            {
               _loc20_ = _loc14_.EightsuitIdArr.indexOf(_loc14_.EightsuitId);
               if(Boolean(_loc6_.EightSuitObject) && _loc6_.EightSuitObject[8] == _loc20_)
               {
                  _loc13_ = _loc14_.EightsuitId;
                  _loc12_ = true;
               }
            }
            _loc3_++;
         }
         if(_loc12_)
         {
            _loc7_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Suit,_loc13_) as TSuit;
            _loc3_ = 0;
            while(_loc3_ < _loc7_.SuitEffects[3].Category.length)
            {
               _loc19_ = BASEATTRIBUTENAMES.indexOf(_loc7_.SuitEffects[3].Category[_loc3_]);
               if(_loc7_.SuitEffects[3].Percentage[_loc3_])
               {
                  _loc16_ = Number(_loc7_.SuitEffects[3].Value[_loc3_]);
                  _loc16_ = _loc16_ * 100;
                  _loc21_ = int(_loc16_);
                  _loc17_ = String(_loc16_);
                  if(_loc16_ != _loc21_)
                  {
                     _loc17_ = _loc16_.toFixed(1);
                  }
                  _loc11_ = _loc11_ + (STRINGS_BASEATTRIBUTENAMES[_loc19_] + "+" + _loc17_ + "%" + "\n");
               }
               else
               {
                  _loc18_ = uint(_loc7_.SuitEffects[3].Value[_loc3_]);
                  _loc11_ = _loc11_ + (STRINGS_BASEATTRIBUTENAMES[_loc19_] + "+" + String(_loc18_) + "\n");
               }
               _loc3_++;
            }
         }
         this.FAccessory_Suit_Arrti.text = _loc11_;
         if(this.FOverlayerAccessory)
         {
            this.FOverlayerAccessory.AccessoryMounted = _loc2_;
         }
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
      
      public function PACKETID_SC_Heros_Pvp(param1:TPacket) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:ByteArray = null;
         var _loc4_:Vector.<Number> = null;
         var _loc5_:THero = null;
         var _loc6_:int = 0;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:int = 0;
         _loc3_ = param1.Data;
         _loc2_ = _loc3_.readUnsignedInt();
         _loc5_ = this.FCharacter.Heros.GetHeroByIdentifier(_loc2_);
         _loc4_ = _loc5_.BaseAttributesCopy;
         _loc9_ = _loc3_.readShort();
         _loc6_ = 0;
         while(_loc6_ < _loc9_)
         {
            if(_loc6_ > 9)
            {
               _loc7_ = _loc3_.readFloat();
               _loc8_ = parseFloat(Number(_loc7_ * 100).toFixed(1));
               _loc4_[_loc6_] = _loc8_;
            }
            else
            {
               if(_loc6_ == 4)
               {
                  _loc7_ = Math.round(_loc3_.readFloat());
               }
               else
               {
                  _loc7_ = _loc3_.readUnsignedInt();
               }
               _loc4_[_loc6_] = _loc7_;
            }
            _loc6_++;
         }
      }
      
      protected function TabInventoryOnSwitchNewCopy(param1:Object) : void
      {
         this.FCurLittleTabIndex = param1 as int;
         this.UpdateHeroInformation();
      }
      
      protected function UpdateHeroInformation() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:THero = null;
         var _loc4_:Number = NaN;
         _loc3_ = this.FCharacter.Heros.GetHeroByIndex(this.FTabHeroIndex);
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
            _loc4_++;
         }
      }
      
      protected function UpdateFilterInventor() : void
      {
         var _loc1_:int = 0;
         _loc1_ = this.FTabInventoryIndex;
         this.FFilterEquipments.length = 0;
         switch(_loc1_)
         {
            case INVENTORIESINDEX_Heros_Equipments:
               this.FFilterEquipments.push(this.FilterEquipmentRequirementLevel);
               this.FFilterEquipments.push(this.FilterEquipmentRequirementCareer);
               break;
            case INVENTORIESINDEX_Heros_Appliances:
               this.FFilterAppliances.push(this.FilterApplianceExperienceReel);
               break;
            case INVENTORIESINDEX_Heros_Accessories:
               this.FFilterAccessory.push(this.FilterAccessoryRequirementLevel);
               this.FFilterAccessory.push(this.FilterAccessoryRequirementCareer);
         }
      }
      
      protected function FilterEquipmentRequirementLevel(param1:TEquipment, param2:THero) : Boolean
      {
         if(param1.RequirementLevel > CONST_COMMON.Ninja_One_Reincarnation_Footstone)
         {
            return param2.Level >= param1.RequirementLevel;
         }
         if(this.FCharacter.GetMainHeroLogicLevel(param2.Level) >= param1.RequirementLevel)
         {
            return true;
         }
         return false;
      }
      
      protected function FilterEquipmentRequirementCareer(param1:TEquipment, param2:THero) : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:uint = 0;
         _loc4_ = int(param1.RequirementCareer.length);
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc5_ = param1.RequirementCareer[_loc3_];
            if(_loc5_ == 0 || param2.Profession == _loc5_)
            {
               return true;
            }
            _loc3_++;
         }
         return false;
      }
      
      protected function FilterApplianceExperienceReel(param1:TAppliance, param2:THero) : Boolean
      {
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         _loc3_ = param1.Category;
         _loc4_ = param1.CategorySecond;
         if(_loc3_ == CATEGORY_Normal && (_loc4_ == CATEGORYSECOND_ExperienceReel || _loc4_ == CATEGORYSECOND_MainHeroExperienceReel))
         {
            return true;
         }
         return false;
      }
      
      protected function FilterAccessoryRequirementLevel(param1:TEquipment, param2:THero) : Boolean
      {
         if(param1.RequirementLevel > CONST_COMMON.Ninja_One_Reincarnation_Footstone)
         {
            return param2.Level >= param1.RequirementLevel;
         }
         if(this.FCharacter.GetMainHeroLogicLevel(param2.Level) >= param1.RequirementLevel)
         {
            return true;
         }
         return false;
      }
      
      protected function FilterAccessoryRequirementCareer(param1:TEquipment, param2:THero) : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:uint = 0;
         _loc4_ = int(param1.RequirementCareer.length);
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc5_ = param1.RequirementCareer[_loc3_];
            if(_loc5_ == 0 || param2.Profession == _loc5_)
            {
               return true;
            }
            _loc3_++;
         }
         return false;
      }
      
      protected function ProcessorSlotEquipmentOnClick(param1:TInventory) : void
      {
         var _loc2_:int = 0;
         var _loc3_:THero = null;
         _loc2_ = this.FTabHeroIndex;
         _loc3_ = this.FCharacter.Heros.GetHeroByIndex(_loc2_);
         if(this.FOnMountEquipment != null)
         {
            this.FOnMountEquipment(this,_loc3_.Identifier,param1.Identifier0,param1.Identifier1);
         }
         this.CheckEquipmentMouted(this.FOnInventoryOut,param1);
      }
      
      protected function ProcessorSlotAccessoryOnClick(param1:TInventory) : void
      {
         var _loc2_:int = 0;
         var _loc3_:THero = null;
         _loc2_ = this.FTabHeroIndex;
         _loc3_ = this.FCharacter.Heros.GetHeroByIndex(_loc2_);
         if(this.FOnMountAccessory != null)
         {
            this.FOnMountAccessory(this,_loc3_.Identifier,param1.Identifier0,param1.Identifier1);
         }
         this.CheckEquipmentMouted(this.FOnInventoryOut,param1);
      }
      
      protected function ProcessorSlotApplianceOnClick(param1:TInventory) : void
      {
         var _loc2_:THero = null;
         var _loc3_:TArticle = null;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:uint = 0;
         var _loc9_:Number = NaN;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         this.FUIWindowEditor.Label = param1.Name;
         this.FUIWindowEditor.Quantity = TUtilityString.Format(FORMAT_UsePrompt,param1.Quantity);
         _loc2_ = this.FCharacter.Heros.GetHeroByIndex(this.FTabHeroIndex);
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Article,param1.IDTemplate) as TArticle;
         if(this.FCharacter.MainHero == _loc2_)
         {
            if(param1.CategorySecond == CONST_INVENTORY.CATEGORYSECOND_ExperienceReel)
            {
               EffectGenerateText(STRING_HEROS.STRING_MainHeroCanNotUse);
               return;
            }
            if(param1.CategorySecond == CONST_INVENTORY.CATEGORYSECOND_MainHeroExperienceReel)
            {
               if(this.FCharacter.LimitiExpGrow)
               {
                  if(_loc2_.Level >= this.FCharacter.ReinCarnationOneNeed)
                  {
                     EffectGenerateText(STRING_HEROS.STRING_ReincarnationLimite);
                     return;
                  }
               }
            }
            this.FExpType = 0;
            this.FExperience = _loc3_.FunctionValue;
            this.FUIWindowEditor.Value = param1.Quantity;
         }
         else
         {
            if(param1.CategorySecond == CONST_INVENTORY.CATEGORYSECOND_MainHeroExperienceReel)
            {
               EffectGenerateText(STRING_HEROS.STRING_OtherHeroCanNotUse);
               return;
            }
            if(_loc2_.ReincarnationOneOrTwo <= 0 && _loc2_.Level >= 150)
            {
               if(_loc2_.Level >= this.FCharacter.ReinCarnationOneNeed)
               {
                  EffectGenerateText(STRING_HEROS.STRING_ReincarnationLimite);
                  return;
               }
            }
            _loc5_ = this.GetBinExp(this.GetNextLevelByLevel(this.FCharacter.MainHero.Level));
            _loc6_ = this.GetBinExp(this.GetNextLevelByLevel(_loc2_.Level));
            _loc9_ = this.FCharacter.MainHero.Experience.ToNumber() + _loc5_ - (_loc2_.Experience.ToNumber() + _loc6_);
            _loc10_ = int(this.FCharacter.GetMainHeroLogicLevel(_loc2_.Level));
            _loc11_ = int(this.FCharacter.GetMainHeroLogicLevel(this.FCharacter.MainHero.Level));
            if(_loc10_ >= _loc11_)
            {
               EffectGenerateText(STRING_HEROS.STRING_HeroLevelPassMainHeroLevel);
               return;
            }
            _loc4_ = this.GetBinExp(this.FCharacter.MainHero.Level);
            _loc7_ = _loc4_ - 1 - (_loc2_.Experience.ToNumber() + _loc6_);
            _loc8_ = Math.ceil(_loc7_ / _loc3_.FunctionValue);
            if(_loc8_ > param1.Quantity)
            {
               this.FExpType = 0;
               this.FExperience = _loc3_.FunctionValue;
               this.FUIWindowEditor.Value = param1.Quantity;
            }
            else
            {
               this.FExpType = 1;
               this.FExperience = _loc7_;
               this.FUIWindowEditor.Value = _loc8_;
            }
         }
         this.FUIWindowEditor.Min = 1;
         this.FUIWindowEditor.Max = param1.Quantity;
         this.FUIWindowEditor.Context = param1;
         this.FUIWindowEditor.SetFocus();
         this.FUIWindowEditor.Visible = true;
         if(this.FOnInventoryOut != null)
         {
            this.FOnInventoryOut(this,param1,null);
         }
      }
      
      protected function GetNextLevelByLevel(param1:int) : int
      {
         var _loc2_:THeroExp = null;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_HeroExp,param1) as THeroExp;
         return _loc2_.Frontlv;
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
      
      protected function ProcessorUseInventory(param1:TInventory) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         var _loc4_:THero = null;
         var _loc5_:int = 0;
         var _loc6_:uint = 0;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Backpack_UseAppliance);
         _loc3_ = _loc2_.Data;
         _loc4_ = this.FCharacter.Heros.GetHeroByIndex(this.FTabHeroIndex);
         if(_loc4_ == this.FCharacter.MainHero && param1.CategorySecond != CONST_INVENTORY.CATEGORYSECOND_MainHeroExperienceReel)
         {
            EffectGenerateText(STRING_HEROS.STRING_MainHeroCanNotAddExp);
            return;
         }
         if(_loc4_ != this.FCharacter.MainHero && param1.CategorySecond != CONST_INVENTORY.CATEGORYSECOND_ExperienceReel)
         {
            EffectGenerateText(STRING_HEROS.STRING_OtherHeroCanNotUse);
            return;
         }
         _loc5_ = int(this.FUIWindowEditor.Value);
         _loc3_.writeShort(1);
         _loc3_.writeUnsignedInt(param1.IDTemplate);
         _loc3_.writeShort(_loc5_);
         _loc3_.writeUnsignedInt(_loc4_.Identifier);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
         if(this.FExpType == 0)
         {
            _loc6_ = this.FExperience * _loc5_;
         }
         else
         {
            _loc6_ = this.FExperience;
         }
         if(this.FOnUseInventory != null)
         {
            this.FOnUseInventory(this,_loc6_);
         }
      }
      
      protected function UpdateIsShowAllEquip() : void
      {
         if(this.FClickNum % 2 == 1)
         {
            this.FBtn_ShowAllEquip.gotoAndStop(2);
            this.FIsShowAllEquip = true;
         }
         else
         {
            this.FBtn_ShowAllEquip.gotoAndStop(1);
            this.FIsShowAllEquip = false;
         }
         this.InventoriesUpdate();
         this.UpdateBackpackUIPage();
         this.InventoriesUpdateSlotsByInventories(this.FSlotsUserAssets,this.FInventories);
      }
      
      protected function CheckEquipmentMouted(param1:Function, param2:TInventory, param3:int = 1) : void
      {
         var _loc4_:THero = null;
         var _loc5_:THeros = null;
         var _loc6_:int = 0;
         var _loc7_:uint = 0;
         var _loc8_:TInventory = null;
         _loc5_ = this.FCharacter.Heros;
         _loc4_ = _loc5_.GetHeroByIndex(this.FTabHeroIndex);
         if(param2.Category == 2)
         {
            _loc7_ = CAPACITY_MC_SlotsEquipment;
            _loc6_ = 0;
            while(_loc6_ < _loc7_)
            {
               _loc8_ = _loc4_.EquipmentsMounted.GetInventoryByIndex(_loc6_);
               if(_loc8_ != null && _loc8_ != param2 && _loc8_.CategorySecond == param2.CategorySecond)
               {
                  if(param1 != null)
                  {
                     param1(this,param2,_loc8_);
                  }
                  return;
               }
               _loc6_++;
            }
            if(param1 != null)
            {
               param1(this,param2,null);
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
                     param1(this,param2,_loc8_,param3);
                  }
                  return;
               }
               _loc6_++;
            }
            if(param1 != null)
            {
               param1(this,param2,null,param3);
            }
         }
         else if(param1 != null)
         {
            param1(this,param2,null);
         }
      }
      
      protected function UpdateTitleEffect() : void
      {
         var _loc1_:TCoordinate = null;
         if(this.FTitleAnimationID != 0)
         {
            _loc1_ = TGameUtil.ShowAnimationByID(TGameUtil.Type_UserTitle,this.FTitleBmp,CONST_MODULES.MODULE_Heros,this.FTitleAnimationID);
            this.FMC_TitleEffect.x = 215 + (175 - this.FMC_TitleEffect.width) / 2;
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
            _loc1_ = TGameUtil.ShowAnimationByID(TGameUtil.Type_LittlePet,this.FLittlePetBmp,CONST_MODULES.MODULE_Heros,this.FLittlePetAnimationID);
            this.true_false(this.FLittlePetAnimationID);
         }
         else
         {
            this.FLittlePetBmp.bitmapData = null;
         }
      }
      
      protected function ShowBTN() : void
      {
         if(this.FTabHeroIndex != 0)
         {
            this.FMC_Btn_Dismiss.visible = true;
            this.FMC_TitleManage.visible = false;
         }
         else
         {
            this.FMC_Btn_Dismiss.visible = false;
            this.FMC_TitleManage.visible = true;
         }
      }
      
      protected function TabHerosOnSwitch(param1:Object) : void
      {
         this.FTabHeroIndex = param1 as int;
         this.FCharacter.PageIndex = this.FHeroPageIndex;
         this.FCharacter.HeroIndex = this.FTabHeroIndex;
         this.FTabHeroIndex = this.FTabHeroIndex + this.FHeroPageIndex * CAPACITY_TF_HerosName;
         this.ShowBTN();
         this.UpdateRoleModel();
         this.CharacterUpdateBaseInfo();
         this.CharacterUpdateBaseAttributes();
         this.CharacterUpdateSkills();
         this.InventoriesUpdateEquipmentsMounted();
         this.UpdateFilterInventor();
         this.InventoriesUpdate();
         this.UpdateBackpackUIPage();
         this.InventoriesUpdateSlotsByInventories(this.FSlotsUserAssets,this.FInventories);
         this.UpdateHeroInformation();
         TutorialNextStep(503);
      }
      
      protected function TabInventoryOnSwitch(param1:Object) : void
      {
         this.FTabInventoryIndex = param1 as int;
         this.SetZearo();
         this.FMC_ShowAllEquip.visible = this.FTabInventoryIndex == 0 || this.FTabInventoryIndex == 2;
         var _loc2_:Boolean = this.FTabInventoryIndex == 2 ? true : false;
         var _loc3_:int = int(this.FCharacter.GetMainLevel());
         if(_loc3_ < 39)
         {
            _loc2_ = false;
         }
         this.FMC_Heros["MC_Challenge_Btn"].visible = _loc2_;
         this.UpdateFilterInventor();
         this.UpdateIsShowAllEquip();
         if(this.FTabInventoryIndex == 1)
         {
            TutorialNextStep(505);
         }
      }
      
      public function TabChangByMan(param1:int) : void
      {
         if(param1)
         {
            this.FUITabInventoryNew.SwithTagManual(1);
         }
         else
         {
            this.FUITabInventoryNew.SwithTagManual(0);
         }
      }
      
      public function TabChangeByIndex(param1:int) : void
      {
         switch(param1)
         {
            case 0:
               this.FUITabInventory.SwithTagManual(0);
               break;
            case 1:
               this.FUITabInventory.SwithTagManual(1);
               break;
            case 2:
               this.FUITabInventory.SwithTagManual(2);
         }
      }
      
      protected function TabInventoryOnSwitchNew(param1:Object) : void
      {
         this.FTabInventoryIndexNew = param1 as int;
         this.SetZearo();
         switch(this.FTabInventoryIndexNew)
         {
            case 0:
               this.TabChangeByIndex(0);
               break;
            case 1:
               this.TabChangeByIndex(2);
               break;
            case 2:
         }
         this.UpdateEquipAccessory(this.FTabInventoryIndexNew);
         this.FUITabInventory.SwithTagManual(this.FTabInventoryIndexNew != 0 ? 2 : 0);
      }
      
      public function UpdateEquipAccessory(param1:int) : void
      {
         this.FMC_Equip_Part.visible = param1 == 0;
         this.FMC_Accessor_Part.visible = param1 == 1;
         this.FMC_Ring_Part.SetVisible(param1 == 2);
      }
      
      protected function ComboBoxOnSelect(param1:Object, param2:uint) : void
      {
         var _loc3_:TPacket = null;
         var _loc4_:ByteArray = null;
         var _loc5_:THero = null;
         var _loc6_:TSkill = null;
         var _loc7_:TSkills = null;
         _loc5_ = this.FCharacter.GetMainHero();
         if(this.FNiMeiA)
         {
            _loc7_ = _loc5_.SkillsCopy;
         }
         else
         {
            _loc7_ = _loc5_.Skills;
         }
         _loc6_ = _loc7_.GetSkillByIndex(param2);
         if(_loc6_.Mounted)
         {
            return;
         }
         if(this.FOnChangeSkillReq != null)
         {
            this.FOnChangeSkillReq(this,_loc6_);
         }
      }
      
      protected function HeroPageOnChange(param1:Object, param2:int) : void
      {
         this.FHeroPageIndex = param2;
         this.FTabHeroIndex = 0;
         this.FCharacter.PageIndex = this.FHeroPageIndex;
         this.FCharacter.HeroIndex = this.FTabHeroIndex;
         this.FTabHeroIndex = this.FTabHeroIndex + this.FHeroPageIndex * CAPACITY_TF_HerosName;
         this.UpdateTabs();
         this.TabHerosOnSwitch(this);
         this.FUITabHeros.SwithTagManual(0);
      }
      
      protected function PageOnChange(param1:Object, param2:int) : void
      {
         this.FPageIndex = param2;
         this.InventoriesUpdateSlotsByInventories(this.FSlotsUserAssets,this.FInventories);
      }
      
      protected function SlotsUserAssetsOnClick(param1:Object, param2:Object) : void
      {
         var _loc3_:int = 0;
         var _loc4_:TUISlot = null;
         var _loc5_:TInventory = null;
         _loc4_ = param1 as TUISlot;
         _loc5_ = param2 as TInventory;
         _loc3_ = this.FTabInventoryIndex;
         switch(_loc3_)
         {
            case INVENTORIESINDEX_Heros_Equipments:
               this.ProcessorSlotEquipmentOnClick(_loc5_);
               break;
            case INVENTORIESINDEX_Heros_Appliances:
               this.ProcessorSlotApplianceOnClick(_loc5_);
               break;
            case INVENTORIESINDEX_Heros_Accessories:
               this.ProcessorSlotAccessoryOnClick(_loc5_);
         }
         TutorialNextStep(501);
      }
      
      protected function SlotsEquipmentMountedOnClick(param1:Object, param2:Object) : void
      {
         var _loc3_:int = 0;
         var _loc4_:THero = null;
         var _loc5_:TInventory = null;
         _loc5_ = param2 as TInventory;
         _loc3_ = this.FTabHeroIndex;
         _loc4_ = this.FCharacter.Heros.GetHeroByIndex(_loc3_);
         if(this.FOnDismountEquipment != null)
         {
            this.FOnDismountEquipment(this,_loc4_.Identifier,1,_loc5_.CategorySecond);
         }
         if(this.FOnInventoryOut != null)
         {
            this.FOnInventoryOut(this,_loc5_,null);
         }
         if(_loc5_.Category == CATEGORY_Equipment)
         {
            this.FUITabInventory.SwithTagManual(0);
         }
         else if(_loc5_.Category == CATEGORY_Accessories)
         {
            this.FUITabInventory.SwithTagManual(2);
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
            _loc6_.LoadSecondary(_loc5_.IDTexture,CONST_MODULES.MODULE_Heros);
         }
      }
      
      protected function SlotsOnQueryAdvancedEquip(param1:Object, param2:Object, param3:TQueryBoolean) : void
      {
         var _loc4_:TEquipment = null;
         if(param2 is TEquipment)
         {
            _loc4_ = param2 as TEquipment;
            switch(_loc4_.Category)
            {
               case CATEGORY_Equipment:
                  param3.Value = _loc4_.IsAdvancedEquip;
                  break;
               case CATEGORY_Accessories:
                  if(_loc4_.IsCastEquip || _loc4_.UpgradingLevel < this.FAccessoryIntensityLevel)
                  {
                     if(_loc4_.UpgradingLevel < this.FCharacter.GetMainHero().Level)
                     {
                        param3.Value = true;
                     }
                     else
                     {
                        param3.Value = false;
                     }
                  }
                  else
                  {
                     param3.Value = false;
                  }
                  if(_loc4_.Display)
                  {
                     param3.Value = false;
                  }
                  break;
               default:
                  param3.Value = _loc4_.IsAdvancedEquip;
            }
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
         this.CheckEquipmentMouted(this.FOnInventoryOver,param2);
      }
      
      protected function SlotsOnMoveCopy(param1:Object, param2:TInventory) : void
      {
         this.CheckEquipmentMouted(this.FOnInventoryOver,param2,0);
      }
      
      protected function SlotsOnOut(param1:Object, param2:TInventory) : void
      {
         this.CheckEquipmentMouted(this.FOnInventoryOut,param2);
      }
      
      protected function SlotsAdvancedEquipOnClick(param1:Object, param2:Object) : void
      {
         var _loc3_:TEquipment = null;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:TEquipUpgrade = null;
         if(this.FOnShortcutHyperlinks != null)
         {
            _loc3_ = param2 as TEquipment;
            _loc7_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_EquipUpgrade,_loc3_.IDTemplate) as TEquipUpgrade;
            switch(_loc3_.Category)
            {
               case CATEGORY_Equipment:
                  if(_loc7_.IsEpic == 1)
                  {
                     _loc4_ = CONST_SHORTCUTS.POSITION_Activity;
                     _loc5_ = CONST_SHORTCUTS.TYPE_Activity_EpicEquip;
                     _loc6_ = 2;
                  }
                  else if(_loc7_.IsEpic == 0)
                  {
                     _loc4_ = CONST_SHORTCUTS.POSITION_Additional;
                     _loc5_ = CONST_SHORTCUTS.TYPE_Additional_MakeEquipAdvanced;
                     _loc6_ = 0;
                  }
                  else
                  {
                     _loc4_ = CONST_SHORTCUTS.POSITION_Function;
                     _loc5_ = CONST_SHORTCUTS.TYPE_Function_Strengthen;
                     _loc6_ = 6;
                  }
                  break;
               case CATEGORY_Accessories:
                  if(_loc3_.IsEpic)
                  {
                     _loc4_ = CONST_SHORTCUTS.POSITION_Activity;
                     _loc5_ = CONST_SHORTCUTS.TYPE_Activity_TransmigrationAccessory;
                     _loc6_ = 2;
                  }
                  else
                  {
                     _loc4_ = CONST_SHORTCUTS.POSITION_Additional;
                     _loc5_ = CONST_SHORTCUTS.TYPE_Additional_Accessory;
                     _loc6_ = 0;
                  }
                  break;
               default:
                  _loc4_ = CONST_SHORTCUTS.POSITION_Additional;
                  _loc5_ = CONST_SHORTCUTS.TYPE_Additional_MakeEquipAdvanced;
                  _loc6_ = 0;
            }
            this.FOnShortcutHyperlinks(this,_loc4_,_loc5_,_loc6_,param2);
            if(this.FOnInventoryOut != null)
            {
               this.FOnInventoryOut(this,param2,param2);
            }
         }
      }
      
      protected function ButtonCloseOnClick(param1:MouseEvent) : void
      {
         ProcessorWindowClose();
      }
      
      protected function ButtonHelpOnOver(param1:MouseEvent) : void
      {
         var _loc2_:TSystemLanguage = null;
         if(this.FOnHelpTipsOver != null)
         {
            _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.HELPTIPS_Heros) as TSystemLanguage;
            this.FHelpTips.Content = _loc2_.Desc;
            this.FOnHelpTipsOver(this,this.FHelpTips);
         }
      }
      
      protected function ButtonHelpOnOut(param1:MouseEvent) : void
      {
         if(this.FOnHelpTipsOut != null)
         {
            this.FOnHelpTipsOut(this);
         }
      }
      
      protected function BtnExtendHerosOnClick(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(Boolean(param1.currentTarget) && !param1.currentTarget.buttonMode)
         {
            return;
         }
         this.FTeamMemberExpand = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_TeamMemberExpand,this.FCharacter.BuyHeroSlot + 1) as TTeamMemberExpand;
         _loc2_ = new ConsumeFrame(CONST_SYSTEMLANGUAGE.ConsumerConfirm_Heros_Expend).DescribeString;
         _loc2_ = _loc2_.split("%0").join(this.FTeamMemberExpand.Cost);
         this.FUIWindowConfirmationBugHeroSlot.Text = _loc2_;
         this.FUIWindowConfirmationBugHeroSlot.visible = true;
      }
      
      protected function BtnAKeySwapOnClick(param1:MouseEvent) : void
      {
         if(this.FBtnAKeySwapOnClick != null)
         {
            this.FBtnAKeySwapOnClick(this);
         }
      }
      
      protected function BtnInheritOnClick(param1:MouseEvent) : void
      {
         if(this.FBtnInheritOnClick != null)
         {
            this.FBtnInheritOnClick(this);
         }
      }
      
      protected function BtnTreasureOnClick(param1:MouseEvent) : void
      {
         if(this.FOnShortcutHyperlinks != null)
         {
            this.FOnShortcutHyperlinks(this,CONST_SHORTCUTS.POSITION_Function,CONST_SHORTCUTS.TYPE_Function_Treasure,this.WriteParamByByteArray(0,this.FTabHeroIndex));
         }
      }
      
      protected function WriteParamByByteArray(param1:uint, param2:uint = 0) : uint
      {
         var _loc3_:uint = 0;
         return uint(param1 << 8 | param2);
      }
      
      protected function GetOpenResult(param1:Vector.<Object>) : Boolean
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         if(this.FColorConfig == null)
         {
            return false;
         }
         _loc2_ = uint(param1[2]);
         _loc3_ = uint(param1[3]);
         if(_loc2_ == 0)
         {
            return true;
         }
         if(_loc2_ == 1)
         {
            if(this.FCharacter.MainQuestComplete.GetQuestByIdentifier(_loc3_) != null)
            {
               return true;
            }
            if(this.FCharacter.SubQuestComplete.GetQuestByIdentifier(_loc3_) != null)
            {
               return true;
            }
         }
         else if(_loc2_ == 2)
         {
            if(this.FCharacter.GetMainLevel() >= _loc3_)
            {
               return true;
            }
         }
         return false;
      }
      
      protected function BtnTreasureHintOnOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         var _loc6_:THeros = null;
         var _loc7_:THero = null;
         var _loc8_:TCollectionInventory = null;
         var _loc9_:TEquipment = null;
         var _loc10_:String = null;
         var _loc11_:String = null;
         var _loc12_:int = 0;
         _loc12_ = 1;
         this.IsColorMagic = 0;
         _loc4_ = "";
         _loc5_ = this.FTabHeroIndex;
         _loc6_ = this.FCharacter.Heros;
         _loc3_ = _loc6_.Count;
         _loc7_ = _loc6_.GetHeroByIndex(_loc5_);
         _loc8_ = _loc7_.TalismansMounted;
         _loc3_ = _loc8_.Capacity;
         if(!this.GetOpenResult(this.FColorConfig))
         {
            _loc4_ = STRING_HEROS.STRING_NewMagicTip;
            this.IsColorMagic = 1;
         }
         else
         {
            _loc4_ = STRING_HEROS.STRING_NewMagicEquipTip;
            _loc2_ = 0;
            while(_loc2_ < _loc3_)
            {
               _loc10_ = _loc7_.GetFirstAttributeByIndex(_loc2_).toFixed();
               _loc9_ = _loc8_.GetInventoryByIndex(_loc2_) as TEquipment;
               if(_loc9_ != null && !TUtilityString.Empty(_loc10_))
               {
                  _loc11_ = STRINGS_TreasuresAttributeCaption[_loc9_.CategorySecond % CATEGORY_TreasurePower];
                  _loc4_ = _loc4_ + TUtilityString.Format(FORMAT_Talisman,_loc9_.Name,_loc11_,_loc10_);
                  _loc12_ = 0;
               }
               _loc2_++;
            }
            if(_loc12_)
            {
               _loc4_ = STRING_HEROS.STRING_NewMagicNoEquipTip;
            }
         }
         if(!TUtilityString.Empty(_loc4_))
         {
            this.FHint.Caption = _loc4_;
            if(this.FHintOnOver != null)
            {
               this.FHintOnOver(this,this.FHint,2);
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
      
      protected function BloodFeteOnClick(param1:MouseEvent) : void
      {
         var _loc2_:TSystemLanguage = null;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.ChatChannel_01) as TSystemLanguage;
         if(this.FCharacter.RoleSencePosition != CONST_COMMON.SCENEPOSITION_MAINCITY)
         {
            EffectGenerateText(_loc2_.Desc);
            return;
         }
         if(this.FGoAccessoryPanel != null)
         {
            this.FGoAccessoryPanel();
         }
      }
      
      protected function SoulFormationOnClick(param1:MouseEvent) : void
      {
         if(this.GoSoulFormation != null)
         {
            this.GoSoulFormation();
            this.FOverlayerSoulFormation.Hide();
            this.FOnHelpTipsOut(this);
         }
      }
      
      protected function WingOnClick(param1:MouseEvent) : void
      {
         if(this.GoWing != null)
         {
            this.GoWing();
            this.FOverlayerWing.Hide();
            this.FOnHelpTipsOut(this);
         }
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
         if(this.FCharacter.Pet.CurSoulFormationID != 0)
         {
            _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SoulArray,this.FCharacter.Pet.CurSoulFormationID) as TSoulArray;
            this.FOverlayerSoulFormation.Context = _loc3_;
            this.FOverlayerSoulFormation.Render(FUICore.MouseCoordinate);
            this.FOverlayerSoulFormation.Show();
         }
         else
         {
            _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,70101031) as TSystemLanguage;
            this.FHelpTips.Content = _loc2_.Desc;
            this.FOnHelpTipsOver(this,this.FHelpTips);
         }
      }
      
      protected function SoulFormationOnOut(param1:MouseEvent) : void
      {
         this.FOverlayerSoulFormation.Hide();
         this.FOnHelpTipsOut(this);
      }
      
      protected function WingOnOver(param1:MouseEvent) : void
      {
         var _loc2_:TSoulArray = null;
         if(this.FCharacter.Wing != null)
         {
            this.FOverlayerWing.Context = null;
            this.FOverlayerWing.Context = this.FCharacter.Wing;
            this.FOverlayerWing.Render(FUICore.MouseCoordinate);
            this.FOverlayerWing.Show();
         }
      }
      
      protected function WingOnOut(param1:MouseEvent) : void
      {
         this.FOverlayerWing.Hide();
      }
      
      protected function BtnMagicOnClick(param1:MouseEvent) : void
      {
         if(this.FOnShortcutHyperlinks != null)
         {
            this.FOnShortcutHyperlinks(this,CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_Magic);
         }
      }
      
      protected function BtnMagicHintOnOver(param1:MouseEvent) : void
      {
         var _loc2_:THero = null;
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:TMagic = null;
         var _loc6_:String = null;
         this.IsColor = 0;
         _loc6_ = "";
         _loc2_ = this.FCharacter.Heros.GetHeroByIndex(this.FTabHeroIndex);
         _loc5_ = this.FMagicData.Magics.GetMagicByIndex(_loc2_.StandPositionWithProfession - 1);
         if(_loc2_.Level < this.FMagicOpenLv)
         {
            this.IsColor = 1;
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
            _loc6_ = _loc5_.MagicName + "\n";
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
            this.FHintOnOver(this,this.FHint,1);
         }
      }
      
      protected function BtnMagicHintOnOut(param1:MouseEvent) : void
      {
         if(this.FHintOnOut != null)
         {
            this.FHintOnOut(this);
         }
      }
      
      protected function BtnExtendHerosHintOnOver(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(Boolean(param1.currentTarget) && Boolean(param1.currentTarget.buttonMode))
         {
            return;
         }
         if(this.FCharacter.VipLevel < this.FCharacter.VipData.VipOpenLevel_TeamerExpand)
         {
            _loc2_ = STRING_COMMON.COMMON_OPENVIPTIP;
            _loc2_ = _loc2_.split("%count%").join(this.FCharacter.VipData.VipOpenLevel_TeamerExpand);
         }
         else
         {
            _loc2_ = STRING_HEROS.STRING_AddHeroMax;
         }
         this.FHint.Caption = _loc2_;
         if(this.FHintOnOver != null)
         {
            this.FHintOnOver(this,this.FHint);
         }
      }
      
      protected function BtnExtendHerosHintOnOut(param1:MouseEvent) : void
      {
         if(this.FHintOnOut != null)
         {
            this.FHintOnOut(this);
         }
      }
      
      protected function BtnAllUnloadOnClick(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:* = 0;
         var _loc4_:int = 0;
         var _loc5_:TPacket = null;
         var _loc6_:ByteArray = null;
         var _loc7_:THero = null;
         var _loc8_:TInventory = null;
         var _loc9_:TCollectionInventory = null;
         var _loc10_:* = 0;
         _loc4_ = this.FTabHeroIndex;
         _loc7_ = this.FCharacter.Heros.GetHeroByIndex(_loc4_);
         _loc3_ = 0;
         _loc9_ = _loc7_.AccessoryMounted;
         _loc2_ = 0;
         while(_loc2_ < _loc9_.Capacity)
         {
            _loc8_ = _loc9_.GetInventoryByIndex(_loc2_);
            if(_loc8_ != null)
            {
               _loc3_++;
            }
            _loc2_++;
         }
         if(_loc3_ > 0)
         {
            if(this.FOnDismountEquipment != null)
            {
               _loc10_++;
               this.FOnDismountEquipment(this,_loc7_.Identifier,_loc3_,0,_loc9_,1);
            }
         }
         _loc3_ = 0;
         _loc9_ = _loc7_.EquipmentsMounted;
         _loc2_ = 0;
         while(_loc2_ < _loc9_.Capacity)
         {
            _loc8_ = _loc9_.GetInventoryByIndex(_loc2_);
            if(_loc8_ != null)
            {
               _loc3_++;
            }
            _loc2_++;
         }
         if(_loc3_ > 0)
         {
            if(this.FOnDismountEquipment != null)
            {
               _loc10_++;
               this.FOnDismountEquipment(this,_loc7_.Identifier,_loc3_,0,_loc9_,1);
            }
         }
         _loc3_ = 0;
         _loc9_ = _loc7_.TalismansMounted;
         _loc2_ = 0;
         while(_loc2_ < _loc9_.Capacity)
         {
            _loc8_ = _loc9_.GetInventoryByIndex(_loc2_);
            if(_loc8_ != null)
            {
               _loc3_++;
            }
            _loc2_++;
         }
         if(_loc3_ > 0)
         {
            if(this.FOnDismountEquipment != null)
            {
               _loc10_++;
               this.FOnDismountEquipment(this,_loc7_.Identifier,_loc3_,0,_loc9_,1);
            }
         }
         if(_loc10_ <= 0)
         {
            if(this.FOnDismountEquipment != null)
            {
               this.FOnDismountEquipment(null,_loc7_.Identifier,0,0,null,1);
            }
         }
         if(this.FTabInventoryIndexNew)
         {
            this.FUITabInventory.SwithTagManual(2);
         }
         else
         {
            this.FUITabInventory.SwithTagManual(0);
         }
         this.SetBtnLock(false);
      }
      
      protected function JadeOnClick(param1:MouseEvent) : void
      {
         if(this.OpenJadeFun != null)
         {
            this.OpenJadeFun();
         }
      }
      
      protected function JadeOnOver(param1:MouseEvent) : void
      {
         if(this.FCharacter.MainHero.Level >= this.JadeOpenLv)
         {
            this.FOverJadeTip.Context = this.FCharacter.SpecialJade;
            this.FOverJadeTip.Render(FUICore.MouseCoordinate);
            this.FOverJadeTip.Show();
         }
         else if(this.FOnHelpTipsOver != null)
         {
            this.FHelpTips.Content = TUtilityString.GetText(CONST_SYSTEMLANGUAGE.Qiudao_STRING_004);
            this.FOnHelpTipsOver(this,this.FHelpTips);
         }
      }
      
      protected function JadeOnOut(param1:MouseEvent) : void
      {
         if(this.FOnHelpTipsOut != null)
         {
            this.FOnHelpTipsOut(this);
         }
         this.FOverJadeTip.Hide();
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
      
      protected function BtnOpenInfomationOnClick(param1:MouseEvent) : void
      {
         this.UpdateHeroInformation();
         this.FMC_CLoseInfomation.gotoAndPlay(1);
      }
      
      protected function BtnCloseInfomationOnClick(param1:MouseEvent) : void
      {
         this.FMC_OpenInfomation.gotoAndPlay(1);
      }
      
      protected function BtnShowAllEquipOnClick(param1:MouseEvent) : void
      {
         this.FClickNum++;
         this.UpdateIsShowAllEquip();
      }
      
      protected function BtnDismissOnClick(param1:MouseEvent) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:THero = null;
         var _loc5_:uint = 0;
         _loc4_ = this.FCharacter.Heros.GetHeroByIndex(this.FTabHeroIndex);
         _loc3_ = this.FRecallCost.length;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            if(this.FRecallCost[_loc2_][0] == _loc4_.Quality)
            {
               _loc5_ = uint(this.FRecallCost[_loc2_][1]);
               break;
            }
            _loc2_++;
         }
         this.FUIWindowConfirmationDismiss.Text = TUtilityString.Format(STRING_NINJAHOSTEL.STRING_SureLeaveTeam,_loc4_.Name,_loc5_);
         this.FUIWindowConfirmationDismiss.visible = true;
      }
      
      protected function DismissOnOk(param1:Object) : void
      {
         var _loc2_:THero = null;
         _loc2_ = this.FCharacter.Heros.GetHeroByIndex(this.FTabHeroIndex);
         if(this.CheckEquipMentsMounted(_loc2_))
         {
            EffectGenerateText(STRING_HEROS.STRING_StripEquipment);
            return;
         }
         if(this.CheckTalismanMounted(_loc2_))
         {
            EffectGenerateText(STRING_HEROS.STRING_StripAdder);
            return;
         }
         if(this.CheckAccessoryMounted(_loc2_))
         {
            EffectGenerateText(STRING_HEROS.STRING_StripAdderAccessory);
            return;
         }
         if(this.CheckBloodFeteMounted(_loc2_))
         {
            EffectGenerateText(STRING_HEROS.STRING_StripBloodFete);
            return;
         }
         if(this.FOnDismiss != null)
         {
            this.FOnDismiss(this,_loc2_);
         }
         this.SetBtnLock(false);
      }
      
      protected function BugHeroSlotOk(param1:Object) : void
      {
         var _loc2_:TPacket = null;
         if(this.FCharacter.CreditGold + this.FCharacter.CreditGiftCertificate < this.FTeamMemberExpand.Cost)
         {
            EffectGenerateText(STRING_COMMON.NOTENOUGH_Gold);
            return;
         }
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Common_AddHeroNum_Req);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function CheckEquipMentsMounted(param1:THero) : Boolean
      {
         var _loc2_:uint = 0;
         var _loc3_:int = 0;
         var _loc4_:TInventory = null;
         _loc2_ = uint(param1.EquipmentsMounted.Capacity);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = param1.EquipmentsMounted.GetInventoryByIndex(_loc3_);
            if(_loc4_ != null)
            {
               return true;
            }
            _loc3_++;
         }
         return false;
      }
      
      protected function CheckTalismanMounted(param1:THero) : Boolean
      {
         var _loc2_:uint = 0;
         var _loc3_:int = 0;
         var _loc4_:TInventory = null;
         _loc2_ = uint(param1.TalismansMounted.Capacity);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = param1.TalismansMounted.GetInventoryByIndex(_loc3_);
            if(_loc4_ != null)
            {
               return true;
            }
            _loc3_++;
         }
         return false;
      }
      
      protected function CheckAccessoryMounted(param1:THero) : Boolean
      {
         var _loc2_:uint = 0;
         var _loc3_:int = 0;
         var _loc4_:TInventory = null;
         _loc2_ = uint(param1.AccessoryMounted.Capacity);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = param1.AccessoryMounted.GetInventoryByIndex(_loc3_);
            if(_loc4_ != null)
            {
               return true;
            }
            _loc3_++;
         }
         return false;
      }
      
      protected function CheckBloodFeteMounted(param1:THero) : Boolean
      {
         var _loc2_:uint = 0;
         _loc2_ = param1.BloodFeteMounted.length;
         if(_loc2_ > 0)
         {
            return true;
         }
         return false;
      }
      
      protected function TFFightingCapacityOnMove(param1:MouseEvent) : void
      {
         var _loc2_:THero = null;
         _loc2_ = this.FCharacter.Heros.GetHeroByIndex(this.FTabHeroIndex);
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
         _loc5_ = this.FCharacter.Heros.GetHeroByIndex(_loc3_);
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
         _loc3_ = this.FCharacter.Heros.GetHeroByIndex(_loc2_);
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
         _loc5_ = this.FCharacter.Heros.GetHeroByIndex(_loc3_);
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
         var _loc5_:TSkills = null;
         _loc2_ = this.FTabHeroIndex;
         _loc3_ = this.FCharacter.Heros.GetHeroByIndex(_loc2_);
         if(this.FNiMeiA)
         {
            _loc5_ = _loc3_.SkillsCopy;
         }
         else
         {
            _loc5_ = _loc3_.Skills;
         }
         _loc4_ = _loc5_.GetSkillByIndex(0);
         this.FHint.Caption = _loc4_.Description;
         if(_loc3_.AwakeSkil == 1)
         {
            this.FHint.Caption = _loc4_.AwakeDesc;
         }
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
         var _loc8_:TSkills = null;
         _loc5_ = this.FTabHeroIndex;
         _loc6_ = this.FCharacter.Heros.GetHeroByIndex(0);
         if(this.FNiMeiA)
         {
            _loc8_ = _loc6_.SkillsCopy;
         }
         else
         {
            _loc8_ = _loc6_.Skills;
         }
         _loc4_ = _loc8_.Count;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc7_ = _loc8_.GetSkillByIndex(_loc3_);
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
         var _loc5_:TSkills = null;
         _loc3_ = this.FCharacter.Heros.GetHeroByIndex(0);
         if(this.FNiMeiA)
         {
            _loc5_ = _loc3_.SkillsCopy;
         }
         else
         {
            _loc5_ = _loc3_.Skills;
         }
         _loc4_ = _loc5_.GetSkillByIndex(param2);
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
      
      protected function MCBtnDismissHintOnOver(param1:Object) : void
      {
         this.FHint.Caption = STRING_Dismiss;
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
      
      protected function MCPetEffectOnOver(param1:MouseEvent) : void
      {
         var _loc2_:TActivityPetConfig = null;
         _loc2_ = this.FActivityPetConfigBins.GetDatebaseByIdentifier(this.FLittlePetAnimationID) as TActivityPetConfig;
         this.FOverlayerSprite.Context = null;
         this.FOverlayerSprite.Context = _loc2_;
         this.FOverlayerSprite.Render(FUICore.MouseCoordinate);
         this.FOverlayerSprite.Show();
      }
      
      protected function MCPetEffectOnOut(param1:MouseEvent) : void
      {
         this.FOverlayerSprite.Hide();
      }
      
      protected function WindowEditorOnOK(param1:Object) : void
      {
         var _loc2_:TInventory = null;
         _loc2_ = this.FUIWindowEditor.Context as TInventory;
         this.ProcessorUseInventory(_loc2_);
         this.FUIWindowEditor.Context = null;
         TutorialNextStep(504);
      }
      
      protected function WindowEditorOnCancel(param1:Object) : void
      {
         this.FUIWindowEditor.Context = null;
      }
      
      protected function WindowEditorOnMax(param1:Object) : void
      {
         var _loc2_:TInventory = null;
         _loc2_ = this.FUIWindowEditor.Context as TInventory;
         this.FUIWindowEditor.Value = _loc2_.Quantity;
         this.FUIWindowEditor.SetFocus();
      }
      
      protected function TitleManageOnClick(param1:MouseEvent) : void
      {
         if(this.FOnOpenTitleManage != null)
         {
            this.FOnOpenTitleManage(this);
         }
      }
      
      protected function UpdateTitleManageEffect() : void
      {
         if(SLogicsCore.Titles.HasNewTitle)
         {
            if(this.FEffectBaseGlow == null)
            {
               this.FEffectBaseGlow = new TEffectBaseGlow();
               this.FEffectBaseGlow.SetParameters(this.FMC_TitleManage,15911245,1);
            }
            this.FEffectBaseGlow.Run();
         }
         else if(this.FEffectBaseGlow != null)
         {
            this.FEffectBaseGlow.Stop();
            this.FEffectBaseGlow.Dispose();
            this.FEffectBaseGlow = null;
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
      
      public function get OnHelpTipsOver() : Function
      {
         return this.FOnHelpTipsOver;
      }
      
      public function set OnHelpTipsOver(param1:Function) : void
      {
         this.FOnHelpTipsOver = param1;
      }
      
      public function get OnHelpTipsOut() : Function
      {
         return this.FOnHelpTipsOut;
      }
      
      public function set OnHelpTipsOut(param1:Function) : void
      {
         this.FOnHelpTipsOut = param1;
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
      
      public function get OnMountEquipment() : Function
      {
         return this.FOnMountEquipment;
      }
      
      public function set OnMountEquipment(param1:Function) : void
      {
         this.FOnMountEquipment = param1;
      }
      
      public function get OnMountAccessory() : Function
      {
         return this.FOnMountAccessory;
      }
      
      public function set OnMountAccessory(param1:Function) : void
      {
         this.FOnMountAccessory = param1;
      }
      
      public function get OnDismountEquipment() : Function
      {
         return this.FOnDismountEquipment;
      }
      
      public function set OnDismountEquipment(param1:Function) : void
      {
         this.FOnDismountEquipment = param1;
      }
      
      public function get OnShortcutHyperlinks() : Function
      {
         return this.FOnShortcutHyperlinks;
      }
      
      public function set OnShortcutHyperlinks(param1:Function) : void
      {
         this.FOnShortcutHyperlinks = param1;
      }
      
      public function get OnChangeSkillReq() : Function
      {
         return this.FOnChangeSkillReq;
      }
      
      public function set OnChangeSkillReq(param1:Function) : void
      {
         this.FOnChangeSkillReq = param1;
      }
      
      public function get OnDismiss() : Function
      {
         return this.FOnDismiss;
      }
      
      public function set OnDismiss(param1:Function) : void
      {
         this.FOnDismiss = param1;
      }
      
      public function get OnUseInventory() : Function
      {
         return this.FOnUseInventory;
      }
      
      public function set OnUseInventory(param1:Function) : void
      {
         this.FOnUseInventory = param1;
      }
      
      public function get AKeySwapOnClick() : Function
      {
         return this.FBtnAKeySwapOnClick;
      }
      
      public function set AKeySwapOnClick(param1:Function) : void
      {
         this.FBtnAKeySwapOnClick = param1;
      }
      
      public function get InheritOnClick() : Function
      {
         return this.FBtnInheritOnClick;
      }
      
      public function set InheritOnClick(param1:Function) : void
      {
         this.FBtnInheritOnClick = param1;
      }
      
      public function get OnOpenTitleManage() : Function
      {
         return this.FOnOpenTitleManage;
      }
      
      public function set OnOpenTitleManage(param1:Function) : void
      {
         this.FOnOpenTitleManage = param1;
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
      
      public function set GoAccessoryPanel(param1:Function) : void
      {
         this.FGoAccessoryPanel = param1;
      }
      
      public function Reset() : void
      {
         this.UpdateTabs();
         this.UpdateRoleModel();
         this.CharacterUpdateBaseInfo();
         this.CharacterUpdateBaseAttributes();
         this.CharacterUpdateSkills();
         this.InventoriesUpdateEquipmentsMounted();
         this.FHeroPageIndex = 0;
         this.FUITabInventory.SwithTagManual(0);
         this.FUITabInventoryNew.SwithTagManual(0);
         this.SetVisibelByValue(false);
      }
      
      public function Update(param1:int = 0) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:int = 0;
         this.UpdateTabs();
         this.UpdateRoleModel();
         this.CharacterUpdateBaseInfo();
         this.CharacterUpdateBaseAttributes();
         this.CharacterUpdateSkills();
         this.InventoriesUpdateEquipmentsMounted();
         this.UpdateFilterInventor();
         this.InventoriesUpdate();
         this.UpdateBackpackUIPage();
         this.UpdateHeroUIPage();
         this.InventoriesUpdateSlotsByInventories(this.FSlotsUserAssets,this.FInventories);
         this.HeroPageOnChange(this,0);
         _loc2_ = this.FMC_EarList.length;
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            this.FMC_EarList[_loc4_].play();
            _loc4_++;
         }
         if(param1 >= 2)
         {
            this.FUITabInventoryNew.SwithTagManual(1);
         }
         else
         {
            _loc3_ = uint(this.FUITabInventoryNew.TabIndex);
            this.FUITabInventoryNew.TabIndex = _loc3_ == param1 ? int(uint(!Boolean(_loc3_))) : int(_loc3_);
            this.FUITabInventoryNew.SwithTagManual(param1);
         }
         if(param1)
         {
            this.FUITabInventory.SwithTagManual(param1);
         }
      }
      
      public function UpdateCharacterInventory() : void
      {
         if(FIsResourcesLoadCompleted)
         {
            this.InventoriesUpdateEquipmentsMounted();
            this.UpdateFilterInventor();
            this.InventoriesUpdate();
            this.UpdateBackpackUIPage();
            this.InventoriesUpdateSlotsByInventories(this.FSlotsUserAssets,this.FInventories);
            this.UpdateHeroInformation();
         }
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
      
      public function UpdateMainHeroSkill() : void
      {
         this.CharacterUpdateSkills();
      }
      
      public function UpdateTabInventory(param1:int = 0) : void
      {
         this.FUITabInventory.SwithTagManual(param1);
      }
      
      public function UpdateTabInventoryNew(param1:int = 0) : void
      {
         this.FUITabInventoryNew.SwithTagManual(param1);
      }
      
      public function SetBtnLock(param1:Boolean) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < this.FBtnList.length)
         {
            TGameUtil.LockOrUnlockButton(this.FBtnList[_loc2_],param1);
            _loc2_++;
         }
      }
      
      public function AddHeroNumOk() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:TMilitary = null;
         var _loc3_:uint = 0;
         if(this.FTF_CurrentNumber != null)
         {
            _loc1_ = uint(this.FCharacter.Heros.Count);
            _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Military,this.FCharacter.MilitaryRank) as TMilitary;
            _loc3_ = _loc2_ == null ? 5 : uint(_loc2_.MaxHeroNum);
            _loc3_ = _loc3_ + this.FCharacter.BuyHeroSlot;
            this.FTF_CurrentNumber.text = TUtilityString.Format(STRING_Capacity,_loc1_,_loc3_);
            this.CheckCanExpand();
         }
      }
      
      public function CheckCanExpand() : void
      {
         var _loc1_:TTeamMemberExpand = null;
         if(this.FMC_Btn_ExtendHeros != null)
         {
            if(this.FCharacter.VipLevel >= this.FCharacter.VipData.VipOpenLevel_TeamerExpand)
            {
               _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_TeamMemberExpand,this.FCharacter.BuyHeroSlot + 1) as TTeamMemberExpand;
               if(_loc1_ != null)
               {
                  TGameUtil.setButtonMode(this.FMC_Btn_ExtendHeros,true);
               }
               else
               {
                  TGameUtil.setButtonMode(this.FMC_Btn_ExtendHeros,false);
               }
            }
            else
            {
               TGameUtil.setButtonMode(this.FMC_Btn_ExtendHeros,false);
            }
         }
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
      
      override public function set y(param1:Number) : void
      {
         super.y = param1;
      }
      
      override public function set Y(param1:int) : void
      {
         super.Y = param1;
      }
   }
}

