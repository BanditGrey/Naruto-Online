package Processors.Game.Lobby.Backpack
{
   import Components.Pages.*;
   import Components.Slots.*;
   import Components.Standard.*;
   import Foundation.Common.THint;
   import Foundation.Network.*;
   import Foundation.Queries.*;
   import Foundation.Queries.Textures.*;
   import Foundation.Resources.*;
   import Foundation.Resources.Bins.*;
   import Foundation.Resources.Repositories.*;
   import Foundation.Resources.Textures.*;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.*;
   import Logics.Characters.*;
   import Logics.DatebaseVO.VO.*;
   import Logics.Inventories.*;
   import Logics.Spaces.*;
   import Logics.Vip.TVip;
   import Processors.Game.Common.Effects.Display.TEffectBaseGlow;
   import Processors.Game.Common.Effects.Texts.TEffectCoordinateParameters;
   import Processors.Game.Common.Effects.Texts.TEffectTextParameters;
   import Processors.Game.Lobby.ActivityInner.Window.TProcessorWindowActivityInnerPsychicBeast;
   import Processors.Game.Lobby.Backpack.Window.*;
   import Processors.Game.Lobby.Common.*;
   import Processors.Game.Lobby.Exercise.UnlockGift.TProcessorUnlockGift;
   import Processors.Game.Lobby.TreasureMap.ConsumeFrame;
   import Processors.Game.Windows.*;
   import Processors.Game.Windows.Editors.*;
   import Processors.Game.Windows.Information.*;
   import Rendering.Overlayers.FeteBlood.TExpDecTip;
   import Resources.Constants.*;
   import Resources.Strings.*;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import Utilities.UI.Windows.*;
   import flash.display.*;
   import flash.events.*;
   import flash.filters.ColorMatrixFilter;
   import flash.text.*;
   import flash.utils.*;
   
   use namespace LogicsSpace;
   
   public class TProcessorWindowUserAssets extends TProcessorLobbyWindow
   {
      
      public static const STAGE_Width:Number = CONST_COMMON.STAGE_Width;
      
      public static const STAGE_Height:Number = CONST_COMMON.STAGE_Height;
      
      public static const CAPACITY_MC_Tabs:uint = CONST_BACKPACK.CAPACITY_MC_Tabs;
      
      public static const CAPACITY_Slots:uint = CONST_BACKPACK.CAPACITY_Slots;
      
      public static const CAPACITY_INVENTORIES:uint = CONST_COMMON.CAPACITY_INVENTORIES;
      
      public static const QUALITYCOLOR_INDEX:Vector.<uint> = CONST_COMMON.QUALITYCOLOR_INDEX;
      
      public static const INVENTORIESINDEX_Appliances:uint = CONST_COMMON.INVENTORIESINDEX_Appliances;
      
      public static const INVENTORIESINDEX_Equipments:uint = CONST_COMMON.INVENTORIESINDEX_Equipments;
      
      public static const INVENTORIESINDEX_Materials:uint = CONST_COMMON.INVENTORIESINDEX_Materials;
      
      public static const INVENTORIESINDEX_Gems:uint = CONST_COMMON.INVENTORIESINDEX_Gems;
      
      public static const INVENTORIESINDEX_Treasures:uint = CONST_COMMON.INVENTORIESINDEX_Treasures;
      
      public static const INVENTORIESINDEX_Accessories:uint = CONST_COMMON.INVENTORIESINDEX_Accessories;
      
      public static const INVENTORIESINDEX_Temporary:uint = CONST_COMMON.INVENTORIESINDEX_Temporary;
      
      public static const INVENTORIESINDEX_Medals:uint = CONST_COMMON.INVENTORIESINDEX_Medals;
      
      public static const STRING_TabsCaption:Vector.<String> = STRING_BACKPACK.STRING_TabsCaption;
      
      protected static const STRINGS_Prompt_Discard:String = STRING_BACKPACK.STRINGS_Prompt_Discard;
      
      protected static const STRINGS_Prompt_Sell:String = STRING_BACKPACK.STRINGS_Prompt_Sell;
      
      public static const FORMAT_UsePrompt:String = STRING_BACKPACK.FORMAT_UsePrompt;
      
      public static const FORMAT_ExpandInvalidPrompt:String = STRING_BACKPACK.FORMAT_ExpandInvalidPrompt;
      
      public static const CATEGORY_Normal:uint = CONST_INVENTORY.CATEGORY_Normal;
      
      public static const CATEGORY_Equipment:uint = CONST_INVENTORY.CATEGORY_Equipment;
      
      public static const CATEGORY_Gem:uint = CONST_INVENTORY.CATEGORY_Gem;
      
      public static const CATEGORY_Treasure:uint = CONST_INVENTORY.CATEGORY_Treasure;
      
      public static const CATEGORY_Material:uint = CONST_INVENTORY.CATEGORY_Material;
      
      public static const CATEGORY_Accessories:uint = CONST_INVENTORY.CATEGORY_Accessories;
      
      public static const CATEGORYSECOND_ExperienceReel:uint = CONST_INVENTORY.CATEGORYSECOND_ExperienceReel;
      
      public static const CATEGORYSECOND_MainHeroExperienceReel:uint = CONST_INVENTORY.CATEGORYSECOND_MainHeroExperienceReel;
      
      public static const CATEGORYSECOND_PsychicReel:uint = CONST_INVENTORY.CATEGORYSECOND_PsychicReel;
      
      public static const CATEGORYSECOND_RefiningSoul:uint = CONST_INVENTORY.CATEGORYSECOND_RefiningSoul;
      
      public static const CATEGORYSECOND_TreasureUpgrade:uint = CONST_INVENTORY.CATEGORYSECOND_TreasureUpgrade;
      
      public static const CATEGORYSECOND_TreasureTransform:uint = CONST_INVENTORY.CATEGORYSECOND_TreasureTransform;
      
      public static const CATEGORYSECOND_BagExtend:uint = CONST_INVENTORY.CATEGORYSECOND_BagExtend;
      
      public static const CATEGORYSECOND_Treasure:uint = CONST_INVENTORY.CATEGORYSECOND_Treasure;
      
      public static const CATEGORYSECOND_Magic:uint = CONST_INVENTORY.CATEGORYSECOND_Magic;
      
      public static const CATEGORYSECOND_MagicCopy:uint = CONST_INVENTORY.CATEGORYSECOND_MagicCopy;
      
      public static const CATEGORYSECOND_GiftReward:uint = CONST_INVENTORY.CATEGORYSECOND_GiftReward;
      
      public static const CATEGORYSECOND_ExtendHoleStone:uint = CONST_INVENTORY.CATEGORYSECOND_ExtendHoleStone;
      
      public static const CATEGORYSECOND_EnchantMaterial:uint = CONST_INVENTORY.CATEGORYSECOND_EnchantMaterial;
      
      public static const CATEGORYSECOND_EnchantStone:uint = CONST_INVENTORY.CATEGORYSECOND_EnchantStone;
      
      public static const CATEGORYSECOND_ChangeName:uint = CONST_INVENTORY.CATEGORYSECOND_ChangeName;
      
      public static const CATEGORYSECOND_ChangeFamily:uint = CONST_INVENTORY.CATEGORYSECOND_ChangeFamily;
      
      public static const POPUPMENUINDEX_Use:uint = CONST_BACKPACK.POPUPMENUINDEX_Use;
      
      public static const POPUPMENUINDEX_Reveal:uint = CONST_BACKPACK.POPUPMENUINDEX_Reveal;
      
      public static const POPUPMENUINDEX_Sell:uint = CONST_BACKPACK.POPUPMENUINDEX_Sell;
      
      public static const STRING_Capacity:String = CONST_COMMON.STRING_Capacity;
      
      protected var TConfigValues:TBins;
      
      protected var FHelpTips:THint;
      
      protected var FUIWindowInformation:TUIWindowConfirmation;
      
      protected var FUIWindowRecharge:TUIWindowRecharge;
      
      protected var FUIWindowConfirmationDiscard:TUIWindowConfirmation;
      
      protected var FUIWindowConfirmationSell:TUIWindowConfirmation;
      
      protected var FWindowBackpackSell:TWindowBackpackSell;
      
      protected var FWindowBackpackAllSell:TWindowBackpackSell;
      
      protected var FUIWindowConfirmationJadeSell:TUIWindowConfirmation;
      
      protected var FUIWindowEditor:TUIWindowEditor;
      
      protected var FTExpDecTip:TExpDecTip;
      
      protected var FTextFormatInformation:TextFormat;
      
      protected var FBtn_Close:SimpleButton;
      
      protected var FBtn_Help:SimpleButton;
      
      protected var FMC_EffectLeft:MovieClip;
      
      protected var FMC_EffectRight:MovieClip;
      
      protected var FMC_HiddenCornersTop:Sprite;
      
      protected var FMC_HiddenCornersBottom:Sprite;
      
      protected var FMC_MergeBag:MovieClip;
      
      protected var FTF_Timer:TextField = null;
      
      protected var FMergeBagTime:uint;
      
      protected var FMC_OnlineTime:MovieClip;
      
      protected var FTF_OnlineTime:TextField;
      
      protected var FTF_OnlineTime_:TextField;
      
      protected var FMC_MainRoleUpgrade:MovieClip;
      
      protected var FEffectsBaseGlow:TEffectBaseGlow;
      
      protected var FRewardStatus:Boolean;
      
      protected var FUIImage:TUIImage;
      
      protected var FUISlots:Vector.<TUISlot>;
      
      protected var FUITab:TUITab;
      
      protected var FUIPage:TUIPage;
      
      protected var FMC_Btn_Expand:MovieClip;
      
      protected var FMC_Btn_QuickPickUp:MovieClip;
      
      protected var FMC_Btn_Sell:SimpleButton;
      
      protected var FTF_Capacity:TextField;
      
      protected var FCharacter:TCharacter;
      
      protected var FInventories:TInventories;
      
      protected var FWindowPopupMenu:TWindowPopupMenu;
      
      protected var FButtonPrevious:TUIButton;
      
      protected var FButtonNext:TUIButton;
      
      protected var FTabIndex:int;
      
      protected var FPageIndex:int;
      
      protected var FCurrentCapacity:int;
      
      protected var FBackpackCapacity:int;
      
      protected var FIsExpandBackpack:Boolean;
      
      protected var FIsSellInventories:Boolean;
      
      protected var FInitialization:Boolean;
      
      protected var FExpandItemQuantity:uint;
      
      protected var FUseApplianceType:uint;
      
      protected var FExpandCapacity:uint;
      
      protected var FExpandCount:uint;
      
      protected var FCostGold:uint;
      
      protected var FIsGoldEnough:Boolean;
      
      protected var FBtnList:Vector.<MovieClip>;
      
      protected var FVipData:TVip;
      
      protected var FMC_Lock:MovieClip;
      
      protected var FHasLock:Boolean;
      
      protected var FWindowLock:TProcessorWindowLock;
      
      protected var FAccessoryIntensityLevel:int;
      
      protected var OnLineTime:Vector.<Object>;
      
      protected var OnLineLevel:Vector.<Object>;
      
      protected var FTiLiCardVector:Vector.<Object>;
      
      private var AllTime:uint;
      
      protected var ZJ:uint;
      
      private var OverTime:uint;
      
      private var OverTimeCopy:uint;
      
      private var OpenedBagCount:int;
      
      private var OpenedBagCountByLevel:int;
      
      protected var FIsRun:Boolean;
      
      protected var FIsCanClick:Boolean;
      
      protected var FBt:Bitmap;
      
      protected var FSh:Shape;
      
      protected var FBtM:BitmapData;
      
      protected var FUIWindowConfirmationCopy:TUIWindowConfirmation;
      
      protected var FWindowChangeName:TWindowChangeName;
      
      protected var FWindowChangeFamily:TWindowChangeFamily;
      
      protected var FProcessorUnlockGift:TProcessorUnlockGift;
      
      protected var FWindowGiftOption:TWindowGiftOption;
      
      protected var FChangeStr:String;
      
      protected var FOnInventoryOver:Function;
      
      protected var FOnInventoryOut:Function;
      
      protected var FOnHelpTipsOver:Function;
      
      protected var FOnHelpTipsOut:Function;
      
      protected var FOnButtonSell:Function;
      
      protected var FOnSellInventoryToList:Function;
      
      protected var FOnSellInventory:Function;
      
      protected var FOnShortcutHyperlinks:Function;
      
      protected var FOnInventoryReveal:Function;
      
      protected var FOnUseInventory:Function;
      
      protected var CurenuUseInventories:TInventory;
      
      protected var FTime:Boolean;
      
      protected var FLevel:Boolean;
      
      public function TProcessorWindowUserAssets(param1:TUIComponent)
      {
         super(param1);
         this.FHelpTips = new THint();
         this.FTextFormatInformation = new TextFormat();
         this.FUISlots = new Vector.<TUISlot>(CAPACITY_Slots);
         this.FUITab = new TUITab(this);
         this.FUIPage = new TUIPage(this);
         this.FCharacter = SLogicsCore.Character;
         this.FWindowPopupMenu = new TWindowPopupMenu(param1);
         this.FInventories = new TInventories();
         this.FBtnList = new Vector.<MovieClip>();
         this.FTabIndex = 0;
         this.FIsExpandBackpack = true;
         this.FIsSellInventories = false;
         this.FInitialization = false;
         this.FIsGoldEnough = false;
         this.FVipData = this.FCharacter.VipData;
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_BACKPACK.RESOURCESID_Swf_Backpack);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Sprite = null;
         var _loc4_:MovieClip = null;
         var _loc5_:MovieClip = null;
         var _loc6_:TextField = null;
         var _loc7_:TUISlot = null;
         var _loc8_:Sprite = null;
         var _loc9_:TConfigValue = null;
         _loc3_ = TUtilityReflection.CreateDisplayObjectInstance(CONST_BACKPACK.RESOURCE_ClassName_MC_Backpack) as Sprite;
         addChild(_loc3_);
         this.FBtn_Close = _loc3_[CONST_BACKPACK.RESOURCE_Link_Btn_Close];
         this.FBtn_Help = _loc3_[CONST_BACKPACK.RESOURCE_Link_Btn_Help];
         this.FMC_EffectLeft = _loc3_[CONST_BACKPACK.RESOURCE_Link_MC_EffectLeft];
         this.FMC_EffectRight = _loc3_[CONST_BACKPACK.RESOURCE_Link_MC_EffectRight];
         this.FMC_EffectLeft.gotoAndStop(1);
         this.FMC_EffectRight.gotoAndStop(1);
         this.FMC_HiddenCornersTop = _loc3_[CONST_BACKPACK.RESOURCE_Link_MC_HiddenCornersTop] as Sprite;
         this.FMC_HiddenCornersBottom = _loc3_[CONST_BACKPACK.RESOURCE_Link_MC_HiddenCornersBottom] as Sprite;
         this.FMC_MergeBag = _loc3_[CONST_BACKPACK.RESOURCE_Link_MC_MergeBag];
         TGameUtil.setButtonMode(this.FMC_MergeBag,true);
         this.FTF_Timer = this.FMC_MergeBag["TF_Timer"];
         this.FMC_OnlineTime = _loc3_["MC_OnlineTime"];
         this.FTF_OnlineTime = _loc3_["TF_OnlineTime"];
         this.FTF_OnlineTime_ = _loc3_["TF_OnlineTime_"];
         this.FMC_MainRoleUpgrade = _loc3_["MC_MainRoleUpgrade"];
         this.FEffectsBaseGlow = new TEffectBaseGlow();
         this.FEffectsBaseGlow.SetParameters(this.FMC_OnlineTime,15911245,1);
         this.FEffectsBaseGlow.visible = false;
         this.FBtM = new BitmapData(this.FMC_OnlineTime.width,this.FMC_OnlineTime.height,true,0);
         this.FBtM.draw(this.FMC_OnlineTime);
         this.FBt = new Bitmap(this.FBtM);
         this.FBt.filters = [new ColorMatrixFilter([1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,0,0,0,1,0])];
         this.FMC_OnlineTime.addChild(this.FBt);
         this.FSh = new Shape();
         this.FMC_OnlineTime.addChild(this.FSh);
         this.FSh.x = this.FMC_OnlineTime.width / 2;
         this.FSh.y = this.FMC_OnlineTime.height / 2 + 4;
         this.FBt.mask = this.FSh;
         _loc2_ = int(CAPACITY_MC_Tabs);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc4_ = _loc3_[CONST_BACKPACK.RESOURCE_Link_MC_Tabs + _loc1_];
            this.FUITab.SetTabByIndex(_loc4_,_loc1_);
            this.FUITab.SetTabCaptionByIndex(STRING_TabsCaption[_loc1_],_loc1_);
            _loc1_++;
         }
         this.FUITab.OnSwitch = this.TabOnSwitch;
         this.FUITab.Init();
         this.FMC_Btn_Expand = _loc3_[CONST_BACKPACK.RESOURCE_Link_MC_Btn_Expand];
         TGameUtil.setButtonMode(this.FMC_Btn_Expand,true);
         this.FBtnList.push(this.FMC_Btn_Expand);
         this.FMC_Btn_QuickPickUp = _loc3_[CONST_BACKPACK.RESOURCE_Link_MC_Btn_QuickPickUp];
         TGameUtil.setButtonMode(this.FMC_Btn_QuickPickUp,true);
         this.FBtnList.push(this.FMC_Btn_QuickPickUp);
         _loc5_ = _loc3_[CONST_BACKPACK.RESOURCE_Link_MC_PageLeft];
         this.FUIPage.ButtonPrevious.Substrate = _loc5_;
         _loc5_ = _loc3_[CONST_BACKPACK.RESOURCE_Link_MC_PageRight];
         this.FUIPage.ButtonNext.Substrate = _loc5_;
         this.FTF_Capacity = _loc3_[CONST_BACKPACK.RESOURCE_Link_TF_Capacity];
         _loc6_ = _loc3_[CONST_BACKPACK.RESOURCE_Link_TF_Page];
         this.FUIPage.LabelPage = _loc6_;
         this.FUIPage.PageSize = CAPACITY_Slots;
         this.FUIPage.Init();
         this.FButtonPrevious = this.FUIPage.ButtonPrevious;
         this.FButtonNext = this.FUIPage.ButtonNext;
         this.FMC_Btn_Sell = _loc3_[CONST_BACKPACK.RESOURCE_Link_MC_Btn_Sell];
         this.FMC_Lock = _loc3_[CONST_BACKPACK.RESOURCE_Link_MC_Btn_Lock];
         if(this.FMC_Lock != null)
         {
            this.FMC_Lock.visible = false;
         }
         _loc2_ = int(CAPACITY_Slots);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc7_ = new TUISlot(this);
            _loc7_.Resource = _loc3_[CONST_BACKPACK.RESOURCE_Link_MC_Slots + _loc1_] as Sprite;
            _loc7_.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
            _loc7_.Tag = _loc1_;
            _loc7_.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
            _loc7_.OnQueryAdvancedEquip = this.SlotsOnQueryAdvancedEquip;
            _loc7_.OnQuerySubscript = this.SlotsOnQuerySubscript;
            _loc7_.OnClick = this.SlotsOnClick;
            _loc7_.OnAdvancedEquipClick = this.SlotsAdvancedEquipOnClick;
            _loc7_.OnOverlay = this.SlotsOnMove;
            _loc7_.OnOut = this.SlotsOnOut;
            _loc7_.OnQuerySelectedContext = this.SlotsOnSelectedContext;
            _loc7_.OnQueryEuqipLevel = this.SlotsOnQueryEuqipLevel;
            _loc7_.Init();
            this.FUISlots[_loc1_] = _loc7_;
            _loc1_++;
         }
         _loc8_ = TUtilityReflection.CreateDisplayObjectInstance(CONST_BACKPACK.RESOURCE_ClassName_MC_PopupMenu) as Sprite;
         this.FWindowPopupMenu.SetSequenceButton(_loc8_);
         this.FUIWindowInformation = new TUIWindowConfirmation(this.Parent);
         this.FUIWindowInformation.OnOK = this.WindowInformationOnOK;
         this.FUIWindowInformation.x = (STAGE_Width - this.FUIWindowInformation.WindowWidth) / 2;
         this.FUIWindowInformation.y = (STAGE_Height - this.FUIWindowInformation.WindowHeight) / 2;
         this.FUIWindowRecharge = new TUIWindowRecharge(this.Parent);
         this.FUIWindowRecharge.x = (STAGE_Width - this.FUIWindowRecharge.WindowWidth) / 2;
         this.FUIWindowRecharge.y = (STAGE_Height - this.FUIWindowRecharge.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowRecharge(this.FUIWindowRecharge);
         this.FUIWindowConfirmationDiscard = new TUIWindowConfirmation(this.Parent);
         this.FUIWindowConfirmationDiscard.OnOK = this.WindowConfirmationDiscardOnOK;
         this.FUIWindowConfirmationDiscard.x = (STAGE_Width - this.FUIWindowConfirmationDiscard.WindowWidth) / 2;
         this.FUIWindowConfirmationDiscard.y = (STAGE_Height - this.FUIWindowConfirmationDiscard.WindowHeight) / 2;
         this.FUIWindowConfirmationSell = new TUIWindowConfirmation(this.Parent);
         this.FUIWindowConfirmationSell.OnOK = this.WindowConfirmationSellOnOK;
         this.FUIWindowConfirmationSell.x = (STAGE_Width - this.FUIWindowConfirmationSell.WindowWidth) / 2;
         this.FUIWindowConfirmationSell.y = (STAGE_Height - this.FUIWindowConfirmationSell.WindowHeight) / 2;
         this.FWindowBackpackSell = new TWindowBackpackSell(this.Parent);
         this.FWindowBackpackSell.OnOK = this.WindowConfirmationSellOnOK;
         this.FWindowBackpackSell.x = (STAGE_Width - this.FWindowBackpackSell.WindowWidth) / 2;
         this.FWindowBackpackSell.y = (STAGE_Height - this.FWindowBackpackSell.WindowHeight) / 2;
         this.FWindowBackpackSell.SlotsOnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
         this.FWindowBackpackSell.SlotsOnOver = this.SlotsOnMove;
         this.FWindowBackpackSell.SlotsOnOut = this.SlotsOnOut;
         this.FWindowBackpackSell.Visible = false;
         this.FWindowBackpackAllSell = new TWindowBackpackSell(this.Parent);
         this.FWindowBackpackAllSell.OnOK = this.WindowConfirmationAllSellOnOK;
         this.FWindowBackpackAllSell.x = (STAGE_Width - this.FWindowBackpackAllSell.WindowWidth) / 2;
         this.FWindowBackpackAllSell.y = (STAGE_Height - this.FWindowBackpackAllSell.WindowHeight) / 2;
         this.FWindowBackpackAllSell.SlotsOnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
         this.FWindowBackpackAllSell.SlotsOnOver = this.SlotsOnMove;
         this.FWindowBackpackAllSell.SlotsOnOut = this.SlotsOnOut;
         this.FWindowBackpackAllSell.Visible = false;
         this.FUIWindowConfirmationJadeSell = new TUIWindowConfirmation(this.Parent);
         this.FUIWindowConfirmationJadeSell.OnOK = this.WindowConfirmationJadeSellOnOK;
         this.FUIWindowConfirmationJadeSell.x = (STAGE_Width - this.FUIWindowConfirmationJadeSell.WindowWidth) / 2;
         this.FUIWindowConfirmationJadeSell.y = (STAGE_Height - this.FUIWindowConfirmationJadeSell.WindowHeight) / 2;
         this.FUIWindowEditor = new TUIWindowEditor(this.Parent,CONST_MODULES.MODULE_Backpack);
         this.FUIWindowEditor.OnOK = this.WindowEditorOnOK;
         this.FUIWindowEditor.OnCancel = this.WindowEditorOnCancel;
         this.FUIWindowEditor.OnMax = this.WindowEditorOnMax;
         this.FUIWindowEditor.x = (STAGE_Width - this.FUIWindowEditor.WindowWidth) / 2;
         this.FUIWindowEditor.y = (STAGE_Height - this.FUIWindowEditor.WindowHeight) / 2;
         this.FTExpDecTip = new TExpDecTip(this.Parent);
         this.FTExpDecTip.visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.FTExpDecTip);
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowInformation);
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowConfirmationDiscard);
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowConfirmationSell);
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowConfirmationJadeSell);
         TUtilityUIWindow.SetupWindowEditor(this.FUIWindowEditor);
         this.FUIWindowConfirmationSell.SetCheckBox(true);
         if(!this.TConfigValues)
         {
            this.TConfigValues = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_ConfigValue);
         }
         this.FUIImage = new TUIImage(this);
         this.FUIImage.mouseEnabled = false;
         this.FUIImage.alpha = 0.6;
         this.FUIImage.SetRegistrationPoint(-24,-24);
         this.FInitialization = true;
         _loc9_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.AccessoryIntensityLevel) as TConfigValue;
         this.FAccessoryIntensityLevel = _loc9_.Value as int;
         _loc9_ = this.TConfigValues.GetDatebaseByIdentifier(CONST_CONFIGVALUE.Bag_Get_OnlineTime) as TConfigValue;
         this.OnLineTime = _loc9_.Value as Vector.<Object>;
         _loc9_ = this.TConfigValues.GetDatebaseByIdentifier(CONST_CONFIGVALUE.Bag_Get_LevelUp) as TConfigValue;
         this.OnLineLevel = _loc9_.Value as Vector.<Object>;
         this.FUIWindowConfirmationCopy = new TUIWindowConfirmation(this.Parent);
         this.FUIWindowConfirmationCopy.OnOK = this.OnConfirmationOkCopy;
         this.FUIWindowConfirmationCopy.x = (FUICore.StageWidth - this.FUIWindowConfirmationCopy.WindowWidth) / 2;
         this.FUIWindowConfirmationCopy.y = (FUICore.StageHeight - this.FUIWindowConfirmationCopy.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowConfirmationCopy);
         this.FWindowChangeName = new TWindowChangeName(this.Parent);
         this.FWindowChangeName.Visible = false;
         this.FWindowChangeName.OnClickBtn = this.ProcessorOnChangeClick;
         this.FWindowChangeName.OnEffectGenerateText = this.ProcessorOnEffectGenerateText;
         this.FWindowChangeName.x = (STAGE_Width - this.FWindowChangeName.WindowWidth) / 2;
         this.FWindowChangeName.y = (STAGE_Height - this.FWindowChangeName.WindowHeight) / 2;
         this.FWindowChangeName.OnEffectGenerateText = OnEffectText;
         this.FWindowChangeFamily = new TWindowChangeFamily(this.Parent);
         this.FWindowChangeFamily.Visible = false;
         this.FWindowChangeFamily.OnClickBtn = this.ProcessorOnChangeClick;
         this.FWindowChangeFamily.OnEffectGenerateText = this.ProcessorOnEffectGenerateText;
         this.FWindowChangeFamily.x = (STAGE_Width - this.FWindowChangeFamily.WindowWidth) / 2;
         this.FWindowChangeFamily.y = (STAGE_Height - this.FWindowChangeFamily.WindowHeight) / 2;
         this.FProcessorUnlockGift = new TProcessorUnlockGift(this.Parent,null);
         this.FProcessorUnlockGift.x = (STAGE_Width - this.FProcessorUnlockGift.WindowWidth) / 2;
         this.FProcessorUnlockGift.y = (STAGE_Height - this.FProcessorUnlockGift.WindowHeight) / 2;
         this.FProcessorUnlockGift.OnClickBtn = this.ProcessorOnChangeClick;
         this.FProcessorUnlockGift.OnEffectGenerateText = OnEffectText;
         this.FWindowGiftOption = new TWindowGiftOption(this.Parent);
         this.FWindowGiftOption.OnEffectGenerateText = this.ProcessorOnEffectGenerateText;
         this.FWindowGiftOption.OnOK = this.OnUseInventory;
         this.FWindowGiftOption.SlotsOnOver = this.SlotsOnMove;
         this.FWindowGiftOption.SlotsOnOut = this.SlotsOnOut;
         this.FWindowGiftOption.Visible = false;
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         var _loc1_:TConfigValue = null;
         this.addEventListener(MouseEvent.MOUSE_DOWN,this.UserAssetsOnDown,false,0,true);
         this.FBtn_Close.addEventListener(MouseEvent.CLICK,this.ButtonCloseOnClick,false,0,true);
         this.FBtn_Help.addEventListener(MouseEvent.MOUSE_MOVE,this.ButtonHelpOnOver,false,0,true);
         this.FBtn_Help.addEventListener(MouseEvent.MOUSE_OUT,this.ButtonHelpOnOut,false,0,true);
         this.FMC_Btn_Expand.addEventListener(MouseEvent.CLICK,this.BtnExpandOnClick,false,0,true);
         this.FMC_Btn_QuickPickUp.addEventListener(MouseEvent.CLICK,this.BtnQuickPickUpOnClick,false,0,true);
         this.FMC_Btn_Sell.addEventListener(MouseEvent.CLICK,this.ButtonSellOnClick,false,0,true);
         this.FWindowPopupMenu.addEventListener(MouseEvent.ROLL_OUT,this.PopupMenuOnOut,false,0,true);
         this.addEventListener(MouseEvent.MOUSE_WHEEL,this.SlotsGroupOnWheel,false,0,true);
         if(this.FMC_Lock != null)
         {
            this.FMC_Lock.addEventListener(MouseEvent.CLICK,this.ButtonLockOnClick,false,0,true);
            this.FMC_Lock.addEventListener(MouseEvent.MOUSE_MOVE,this.ButtonLockOnOver,false,0,true);
            this.FMC_Lock.addEventListener(MouseEvent.MOUSE_OUT,this.ButtonLockOnOut,false,0,true);
         }
         this.FMC_MergeBag.addEventListener(MouseEvent.CLICK,this.ButtonMergeBagOnClick,false,0,true);
         this.FMC_OnlineTime.addEventListener(MouseEvent.CLICK,this.OnlineTimeClick);
         this.FMC_OnlineTime.addEventListener(MouseEvent.MOUSE_OVER,this.OnlineTimeOver);
         this.FMC_OnlineTime.addEventListener(MouseEvent.MOUSE_OUT,this.OnlineTimeOut);
         this.FMC_OnlineTime.addEventListener(MouseEvent.MOUSE_MOVE,this.OnlineTimemMove);
         this.FMC_MainRoleUpgrade.addEventListener(MouseEvent.MOUSE_OVER,this.OnlineTimeOver);
         this.FMC_MainRoleUpgrade.addEventListener(MouseEvent.MOUSE_OUT,this.OnlineTimeOut);
         this.FMC_MainRoleUpgrade.addEventListener(MouseEvent.MOUSE_MOVE,this.OnlineTimemMove);
         this.FWindowPopupMenu.OnPopupMenu = this.PopupMenuOnClick;
         this.FUIPage.OnChangePage = this.PageOnChange;
         this.FMC_Btn_QuickPickUp.visible = false;
         _loc1_ = this.TConfigValues.GetDatebaseByIdentifier(CONST_CONFIGVALUE.BACKPACK_EXPEND_NUM) as TConfigValue;
         this.FExpandCapacity = _loc1_.Value as int;
         super.ResourcesPerform_UILocations();
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         if(this.FInitialization)
         {
            this.ProcessorUpdateSlotsRenderingState();
            this.FUIWindowEditor.Update();
            if(Visible)
            {
               if(this.FMergeBagTime != 0 && STimingCore.GetServerTick() - this.FMergeBagTime > 60)
               {
                  TGameUtil.setButtonMode(this.FMC_MergeBag,true);
                  this.FTF_Timer.text = STRING_PSYCHICBEAST.STRING_ZHENGLI;
                  this.FMergeBagTime = 0;
               }
               if(!this.FMC_MergeBag.buttonMode)
               {
                  this.FTF_Timer.text = String(60 - (STimingCore.GetServerTick() - this.FMergeBagTime));
               }
               this.UpdateEffectsGlow();
               this.FWindowBackpackSell.UpdateSlot();
               this.FWindowBackpackAllSell.UpdateSlot();
               this.FWindowGiftOption.LogicsPerform();
            }
         }
      }
      
      protected function UpdateEffectsGlow() : void
      {
         if(this.FRewardStatus)
         {
            this.FEffectsBaseGlow.Run();
            this.FEffectsBaseGlow.visible = true;
         }
         else
         {
            this.FEffectsBaseGlow.Stop();
            this.FEffectsBaseGlow.visible = false;
         }
      }
      
      protected function ProcessorUpdateSlotsRenderingState() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TUISlot = null;
         _loc2_ = int(CAPACITY_Slots);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FUISlots[_loc1_];
            _loc3_.Update();
            _loc1_++;
         }
      }
      
      protected function InventoriesUpdate() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TInventories = null;
         this.FInventories.Clear();
         _loc1_ = this.FTabIndex;
         switch(_loc1_)
         {
            case INVENTORIESINDEX_Appliances:
               _loc2_ = this.FCharacter.Appliances;
               break;
            case INVENTORIESINDEX_Equipments:
               _loc2_ = this.FCharacter.Equipments;
               break;
            case INVENTORIESINDEX_Materials:
               _loc2_ = this.FCharacter.Materials;
               break;
            case INVENTORIESINDEX_Gems:
               _loc2_ = this.FCharacter.Gems;
               break;
            case INVENTORIESINDEX_Treasures:
               _loc2_ = this.FCharacter.Treasures;
               break;
            case INVENTORIESINDEX_Accessories:
               _loc2_ = this.FCharacter.Accessories;
               break;
            case INVENTORIESINDEX_Medals:
               _loc2_ = this.FCharacter.Medals;
               break;
            case INVENTORIESINDEX_Temporary:
               _loc2_ = this.FCharacter.TemporaryInventories;
         }
         this.ProcessorInventories(_loc2_);
      }
      
      protected function ProcessorInventories(param1:TInventories) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TInventory = null;
         _loc3_ = param1.Count;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = param1.GetInventoryByIndex(_loc2_);
            this.FInventories.Add(_loc4_);
            _loc2_++;
         }
      }
      
      protected function InventoriesUpdateSlotsByInventories(param1:Vector.<TUISlot>, param2:TInventories) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:TUISlot = null;
         var _loc9_:Sprite = null;
         var _loc10_:TInventory = null;
         _loc7_ = this.FTabIndex;
         _loc6_ = this.FPageIndex;
         _loc4_ = int(CAPACITY_Slots);
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc8_ = param1[_loc3_];
            _loc8_.Context = null;
            _loc8_.Resource.visible = false;
            _loc3_++;
         }
         _loc4_ = param2.Count;
         if(_loc4_ <= 0)
         {
            return;
         }
         _loc5_ = _loc6_ * CAPACITY_Slots;
         _loc3_ = 0;
         while(_loc3_ < CAPACITY_Slots)
         {
            if(_loc3_ + _loc5_ >= _loc4_)
            {
               break;
            }
            _loc8_ = param1[_loc3_];
            _loc10_ = param2.GetInventoryByIndex(_loc3_ + _loc5_);
            _loc8_.Context = _loc10_;
            _loc8_.SelectBox = _loc10_.IsSelling;
            _loc8_.Resource.visible = true;
            _loc3_++;
         }
      }
      
      public function GetBackpackMiddleCount() : int
      {
         var _loc1_:int = 0;
         var _loc2_:TConfigValue = null;
         if(!this.FVipData)
         {
            this.FVipData = this.FCharacter.VipData;
         }
         if(!this.FExpandCapacity)
         {
            if(!this.TConfigValues)
            {
               this.TConfigValues = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_ConfigValue);
            }
            _loc2_ = this.TConfigValues.GetDatebaseByIdentifier(CONST_CONFIGVALUE.BACKPACK_EXPEND_NUM) as TConfigValue;
            this.FExpandCapacity = _loc2_.Value as int;
         }
         _loc1_ = CONST_CHARACTER.CAPACITY_Backpack + this.FVipData.BagCount + this.FExpandCapacity * this.FCharacter.BackpackExpandCount + this.OpenedBagCount + this.OpenedBagCountByLevel;
         return _loc1_ - this.GetBackpackCapacity();
      }
      
      protected function UpdateBackpackCapacity(param1:Boolean = true) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         this.FCharacter.BackpackCapacity = CONST_CHARACTER.CAPACITY_Backpack + this.FVipData.BagCount + this.FExpandCapacity * this.FCharacter.BackpackExpandCount + this.OpenedBagCount + this.OpenedBagCountByLevel;
         this.FBackpackCapacity = this.FCharacter.BackpackCapacity;
         if(this.FTabIndex == INVENTORIESINDEX_Temporary)
         {
            _loc2_ = int(this.GetBackpackTemporaryCapacity());
            _loc3_ = int(this.FCharacter.BackpackTemporaryCapacity);
         }
         else
         {
            _loc2_ = int(this.GetBackpackCapacity());
            _loc3_ = this.FBackpackCapacity;
            this.FCharacter.CurrentCapacity = _loc2_;
         }
         if(param1)
         {
            this.FPageIndex = 0;
            this.FUIPage.TotalQuantity = this.FInventories.Count;
            this.FUIPage.PageIndex = this.FPageIndex;
            this.FUIPage.Update();
         }
         else
         {
            this.FUIPage.TotalQuantity = this.FInventories.Count;
            this.FUIPage.Update();
            if(this.FPageIndex >= this.FUIPage.TotalPage)
            {
               this.FPageIndex = this.FUIPage.TotalPage - 1;
               this.FUIPage.PageIndex = this.FPageIndex;
               this.FUIPage.Update();
            }
         }
         this.FTF_Capacity.text = TUtilityString.Format(STRING_Capacity,_loc2_,_loc3_);
      }
      
      protected function GetBackpackCapacity() : uint
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:TInventories = null;
         _loc2_ = CAPACITY_INVENTORIES - 1;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc4_ = this.FCharacter.GetBackpackByIndex(_loc1_);
            _loc3_ += _loc4_.Count;
            _loc1_++;
         }
         return _loc3_;
      }
      
      protected function GetBackpackTemporaryCapacity() : uint
      {
         var _loc1_:uint = 0;
         var _loc2_:TInventories = null;
         _loc2_ = this.FCharacter.TemporaryInventories;
         return uint(_loc2_.Count);
      }
      
      protected function OnConfirmationOkCopy(param1:Object) : void
      {
         this.ProcessorPopupMenuUseInventoriesCopy(this.CurenuUseInventories);
      }
      
      protected function ProcessorPopupMenuUseInventories(param1:TInventory) : void
      {
         this.CurenuUseInventories = param1;
         this.ProcessorPopupMenuUseInventoriesCopy(this.CurenuUseInventories);
      }
      
      protected function ProcessorPopupMenuUseInventoriesCopy(param1:TInventory) : void
      {
         var _loc2_:TAppliance = null;
         var _loc3_:TArticle = null;
         var _loc4_:uint = 0;
         var _loc5_:TSystemLanguage = null;
         var _loc6_:int = 0;
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Article,param1.IDTemplate) as TArticle;
         if(this.FCharacter.MainHero.Level < _loc3_.Level && _loc3_.MinorType != TProcessorWindowActivityInnerPsychicBeast.PsychicBeastType)
         {
            _loc4_ = CONST_SYSTEMLANGUAGE.BACKPACK_FORMAT_09;
            _loc5_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,_loc4_) as TSystemLanguage;
            EffectGenerateText(_loc5_.Desc);
            return;
         }
         if(Boolean(_loc3_.Level) && _loc3_.MinorType == TProcessorWindowActivityInnerPsychicBeast.PsychicBeastType)
         {
            if(SLogicsCore.Character.Pet.PetID < _loc3_.Level && Boolean(_loc3_.Level))
            {
               EffectGenerateText(STRING_PSYCHICBEAST.STRING_Insufficient_LEVEL);
               return;
            }
         }
         if(_loc3_.Identifier == 14120383)
         {
            this.FProcessorUnlockGift.Mount();
            this.FProcessorUnlockGift.Inventory = param1;
            return;
         }
         switch(param1.Category)
         {
            case CATEGORY_Normal:
               _loc2_ = param1 as TAppliance;
               switch(_loc2_.CategorySecond)
               {
                  case CATEGORYSECOND_ChangeName:
                     this.FWindowChangeName.Visible = true;
                     this.FWindowChangeName.Inventory = _loc2_;
                     this.FWindowChangeName.ResetName();
                     break;
                  case CATEGORYSECOND_ChangeFamily:
                     this.FWindowChangeFamily.Visible = true;
                     this.FWindowChangeFamily.Inventory = _loc2_;
                     break;
                  case CATEGORYSECOND_ExperienceReel:
                     if(this.FOnShortcutHyperlinks != null)
                     {
                        this.FOnShortcutHyperlinks(this,CONST_SHORTCUTS.POSITION_Function,CONST_SHORTCUTS.TYPE_Function_Heros,1);
                        return;
                     }
                     break;
                  case CATEGORYSECOND_MainHeroExperienceReel:
                     if(this.FOnShortcutHyperlinks != null)
                     {
                        this.FOnShortcutHyperlinks(this,CONST_SHORTCUTS.POSITION_Function,CONST_SHORTCUTS.TYPE_Function_Heros,1);
                        return;
                     }
                     break;
                  case CATEGORYSECOND_PsychicReel:
                     if(this.FOnShortcutHyperlinks != null)
                     {
                        this.FOnShortcutHyperlinks(this,CONST_SHORTCUTS.POSITION_Function,CONST_SHORTCUTS.TYPE_Function_SummonPet,0);
                        return;
                     }
                     break;
                  case CATEGORYSECOND_RefiningSoul:
                     if(this.FOnShortcutHyperlinks != null)
                     {
                        this.FOnShortcutHyperlinks(this,CONST_SHORTCUTS.POSITION_Function,CONST_SHORTCUTS.TYPE_Function_SummonPet,2);
                        return;
                     }
                     break;
                  case CATEGORYSECOND_TreasureUpgrade:
                     if(this.FOnShortcutHyperlinks != null)
                     {
                        this.FOnShortcutHyperlinks(this,CONST_SHORTCUTS.POSITION_Function,CONST_SHORTCUTS.TYPE_Function_Treasure,1);
                        return;
                     }
                     break;
                  case CATEGORYSECOND_TreasureTransform:
                     if(this.FOnShortcutHyperlinks != null)
                     {
                        this.FOnShortcutHyperlinks(this,CONST_SHORTCUTS.POSITION_Function,CONST_SHORTCUTS.TYPE_Function_Treasure,2);
                        return;
                     }
                     break;
                  case CATEGORYSECOND_BagExtend:
                     this.BtnExpandOnClick(null);
                     break;
                  case CATEGORYSECOND_Treasure:
                     this.FUIWindowEditor.Value = _loc2_.Quantity;
                     this.FOnUseInventory(this,_loc2_,1);
                     break;
                  case CATEGORYSECOND_Magic:
                  case CATEGORYSECOND_MagicCopy:
                     if(this.FOnShortcutHyperlinks != null)
                     {
                        this.FOnShortcutHyperlinks(this,CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_Magic,0);
                        return;
                     }
                     break;
                  case CATEGORYSECOND_ExtendHoleStone:
                     if(this.FOnShortcutHyperlinks != null)
                     {
                        this.FOnShortcutHyperlinks(this,CONST_SHORTCUTS.POSITION_Function,CONST_SHORTCUTS.TYPE_Function_Strengthen,3);
                        return;
                     }
                     break;
                  case CATEGORYSECOND_EnchantMaterial:
                  case CATEGORYSECOND_EnchantStone:
                     if(this.FOnShortcutHyperlinks != null)
                     {
                        this.FOnShortcutHyperlinks(this,CONST_SHORTCUTS.POSITION_Function,CONST_SHORTCUTS.TYPE_Function_Strengthen,4);
                        return;
                     }
                     break;
                  case CATEGORYSECOND_GiftReward:
                     this.FWindowGiftOption.Visible = true;
                     this.FWindowGiftOption.UpdateUI(param1);
                     break;
                  default:
                     _loc2_ = param1 as TAppliance;
                     this.FUIWindowEditor.Label = _loc2_.Name;
                     this.FUIWindowEditor.Context = _loc2_;
                     this.FUIWindowEditor.Quantity = TUtilityString.Format(FORMAT_UsePrompt,_loc2_.Quantity);
                     this.FUIWindowEditor.Value = _loc2_.Quantity;
                     this.FUIWindowEditor.Min = 1;
                     this.FUIWindowEditor.Max = _loc2_.Quantity;
                     this.FUIWindowEditor.SetFocus();
                     this.FUIWindowEditor.Visible = true;
               }
               break;
            case CATEGORY_Accessories:
               if(this.FOnShortcutHyperlinks != null)
               {
                  this.FOnShortcutHyperlinks(this,CONST_SHORTCUTS.POSITION_Function,CONST_SHORTCUTS.TYPE_Function_Heros,2);
                  return;
               }
               break;
            case CATEGORY_Equipment:
               if(this.FOnShortcutHyperlinks != null)
               {
                  this.FOnShortcutHyperlinks(this,CONST_SHORTCUTS.POSITION_Function,CONST_SHORTCUTS.TYPE_Function_Heros);
                  return;
               }
               break;
            case CATEGORY_Gem:
               if(this.FOnShortcutHyperlinks != null)
               {
                  this.FOnShortcutHyperlinks(this,CONST_SHORTCUTS.POSITION_Additional,CONST_SHORTCUTS.TYPE_Additional_Jade);
                  return;
               }
               break;
            case CATEGORY_Treasure:
               if(this.FOnShortcutHyperlinks != null)
               {
                  this.FOnShortcutHyperlinks(this,CONST_SHORTCUTS.POSITION_Function,CONST_SHORTCUTS.TYPE_Function_Treasure);
                  return;
               }
               break;
            case CATEGORY_Material:
               if(this.FOnShortcutHyperlinks != null)
               {
                  this.FOnShortcutHyperlinks(this,CONST_SHORTCUTS.POSITION_Additional,CONST_SHORTCUTS.TYPE_Additional_MakeEquip);
                  return;
               }
         }
      }
      
      protected function ProcessorsInventoryReveal(param1:TInventory) : void
      {
         if(!param1.IsCanReveal)
         {
            return;
         }
         if(this.FOnInventoryReveal != null)
         {
            this.FOnInventoryReveal(this,param1);
            ProcessorWindowClose();
         }
      }
      
      protected function ProcessorDepotToBag(param1:uint, param2:TInventory = null) : void
      {
         var _loc3_:TPacket = null;
         var _loc4_:int = 0;
         var _loc5_:uint = 0;
         var _loc6_:TInventory = null;
         var _loc7_:ByteArray = null;
         _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Backpack_DepotToBag);
         _loc7_ = _loc3_.Data;
         _loc5_ = param1;
         _loc7_.writeShort(_loc5_);
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            if(param2 == null)
            {
               _loc6_ = this.FInventories.GetInventoryByIndex(_loc4_);
            }
            else
            {
               _loc6_ = param2;
            }
            _loc7_.writeUnsignedInt(_loc6_.Identifier0);
            _loc7_.writeUnsignedInt(_loc6_.Identifier1);
            _loc4_++;
         }
         SNetworkCore.Transceiver.PacketTransmit(_loc3_);
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
            _loc6_.LoadSecondary(_loc5_.IDTexture,CONST_MODULES.MODULE_Backpack);
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
                     if(_loc4_.UpgradingLevel < SLogicsCore.Character.GetMainHeroLogicLevel(SLogicsCore.Character.GetMainLevel()))
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
      
      protected function SlotsOnClick(param1:Object, param2:Object) : void
      {
         var _loc3_:TInventory = null;
         var _loc4_:Boolean = false;
         var _loc5_:TAppliance = null;
         _loc3_ = param2 as TInventory;
         this.SlotsOnOut(param1,_loc3_);
         if(this.FTabIndex == INVENTORIESINDEX_Temporary)
         {
            this.ProcessorDepotToBag(1,_loc3_);
            return;
         }
         _loc4_ = _loc3_.IsCanSell;
         if(this.FIsSellInventories)
         {
            if(_loc4_)
            {
               this.FWindowBackpackAllSell.SetItem(_loc3_);
               if(_loc3_.IsSelling)
               {
                  this.WindowConfirmationAllSellOnOK(this);
               }
               else
               {
                  this.FWindowBackpackAllSell.Visible = true;
               }
            }
            return;
         }
         this.FWindowPopupMenu.Context = _loc3_;
         this.FWindowPopupMenu.IsCanReveal = _loc3_.IsCanReveal;
         this.FWindowPopupMenu.IsCanSell = _loc4_;
         this.FWindowPopupMenu.Usable = true;
         if(_loc3_ is TAppliance)
         {
            _loc5_ = _loc3_ as TAppliance;
            switch(_loc5_.CategorySecond)
            {
               case CATEGORYSECOND_ExperienceReel:
                  this.FWindowPopupMenu.Usable = true;
               case CATEGORYSECOND_MainHeroExperienceReel:
                  this.FWindowPopupMenu.Usable = true;
               case CATEGORYSECOND_PsychicReel:
               case CATEGORYSECOND_RefiningSoul:
               case CATEGORYSECOND_TreasureUpgrade:
                  this.FWindowPopupMenu.Usable = true;
               case CATEGORYSECOND_TreasureTransform:
                  this.FWindowPopupMenu.Usable = true;
                  break;
               case CATEGORYSECOND_BagExtend:
                  this.FWindowPopupMenu.Usable = true;
                  break;
               case CATEGORY_Treasure:
                  this.FWindowPopupMenu.Usable = true;
                  break;
               default:
                  this.FWindowPopupMenu.Usable = _loc5_.Usable;
            }
         }
         else if(_loc3_ is TEquipment)
         {
            this.FWindowPopupMenu.Usable = true;
         }
         this.FWindowPopupMenu.X = FUICore.MouseCoordinate.X - 10;
         this.FWindowPopupMenu.Y = FUICore.MouseCoordinate.Y - 10;
         this.FWindowPopupMenu.Update();
         this.FWindowPopupMenu.Visible = !this.FWindowPopupMenu.Visible;
      }
      
      protected function WindowConfirmationAllSellOnOK(param1:Object) : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:TInventory = null;
         var _loc4_:TAppliance = null;
         var _loc5_:TEquipment = null;
         var _loc6_:TInventory = null;
         var _loc7_:uint = 0;
         _loc3_ = this.FWindowBackpackAllSell.Inventory;
         _loc7_ = this.FWindowBackpackAllSell.CurCount;
         this.SlotsOnOut(param1,_loc3_);
         _loc2_ = _loc3_.IsCanSell;
         if(this.FIsSellInventories)
         {
            if(_loc2_)
            {
               if(this.FOnSellInventoryToList != null)
               {
                  if(_loc3_ is TAppliance)
                  {
                     _loc4_ = new TAppliance(_loc3_.Identifier0,_loc3_.Identifier1);
                     _loc4_.Type = _loc3_.Type;
                     _loc4_.IDTemplate = _loc3_.IDTemplate;
                     _loc4_.Quantity = _loc7_;
                     _loc4_.Name = _loc3_.Name;
                     _loc4_.IsSelling = _loc3_.IsSelling;
                     _loc4_.SellingValue = _loc3_.SellingValue;
                     _loc4_.SellValue = _loc3_.SellValue;
                     this.FOnSellInventoryToList(_loc4_,_loc3_);
                  }
                  else if(_loc3_ is TEquipment)
                  {
                     _loc5_ = new TEquipment(_loc3_.Identifier0,_loc3_.Identifier1);
                     _loc5_.Type = _loc3_.Type;
                     _loc5_.IDTemplate = _loc3_.IDTemplate;
                     _loc5_.Quantity = _loc7_;
                     _loc5_.Name = _loc3_.Name;
                     _loc5_.IsSelling = _loc3_.IsSelling;
                     _loc5_.SellingValue = _loc3_.SellingValue;
                     _loc5_.SellValue = _loc3_.SellValue;
                     this.FOnSellInventoryToList(_loc5_,_loc3_);
                  }
                  else
                  {
                     _loc6_ = new TInventory(_loc3_.Identifier0,_loc3_.Identifier1);
                     _loc6_.Type = _loc3_.Type;
                     _loc6_.IDTemplate = _loc3_.IDTemplate;
                     _loc6_.Quantity = _loc7_;
                     _loc6_.Name = _loc3_.Name;
                     _loc6_.IsSelling = _loc3_.IsSelling;
                     _loc6_.SellingValue = _loc3_.SellingValue;
                     _loc6_.SellValue = _loc3_.SellValue;
                     this.FOnSellInventoryToList(_loc6_,_loc3_);
                  }
               }
               this.UserUpdateInventories();
            }
         }
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
         }
      }
      
      protected function SlotsOnMove(param1:Object, param2:TInventory) : void
      {
         if(this.FOnInventoryOver != null)
         {
            this.FOnInventoryOver(this,param2);
         }
      }
      
      protected function SlotsOnOut(param1:Object, param2:TInventory) : void
      {
         if(this.FOnInventoryOut != null)
         {
            this.FOnInventoryOut(this,param2);
         }
      }
      
      protected function SlotsOnDragBegin(param1:Object) : void
      {
         var _loc2_:TUISlot = null;
         _loc2_ = param1 as TUISlot;
         this.FUIImage.Sequence = _loc2_.SequenceContext;
         FUICore.MouseStartDrag(this.FUIImage,true);
      }
      
      protected function SlotsOnDragQuery(param1:Object, param2:TUIComponent, param3:Object, param4:TQueryBoolean) : void
      {
         param4.Value = true;
      }
      
      protected function SlotsOnDragEnd(param1:Object) : void
      {
         FUICore.MouseStopDrag(this.FUIImage);
      }
      
      protected function SlotsOnDragReject(param1:Object, param2:TUIComponent, param3:Object) : void
      {
         this.FUIWindowConfirmationDiscard.Text = STRINGS_Prompt_Discard;
         this.FUIWindowConfirmationDiscard.Visible = true;
      }
      
      protected function SlotsOnSelectedContext(param1:Object, param2:Object, param3:TQueryBoolean) : void
      {
         var _loc4_:TInventory = null;
         _loc4_ = param2 as TInventory;
         param3.Value = _loc4_.IsSelling;
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
      
      protected function TabOnSwitch(param1:Object) : void
      {
         this.FTabIndex = param1 as int;
         if(this.FTabIndex == INVENTORIESINDEX_Temporary)
         {
            this.FMC_Btn_QuickPickUp.visible = true;
            this.FMC_MergeBag.visible = false;
         }
         else
         {
            this.FMC_Btn_QuickPickUp.visible = false;
            this.FMC_MergeBag.visible = true;
         }
         this.InventoriesUpdate();
         this.UpdateBackpackCapacity();
         this.InventoriesUpdateSlotsByInventories(this.FUISlots,this.FInventories);
      }
      
      protected function SlotsGroupOnWheel(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _loc2_ = param1.delta;
         _loc3_ = this.FPageIndex;
         _loc4_ = int(this.FUIPage.TotalPage);
         if(_loc2_ < 0)
         {
            if(this.FButtonNext.OnClick != null)
            {
               this.FButtonNext.OnClick(null);
            }
         }
         else if(this.FButtonPrevious.OnClick != null)
         {
            this.FButtonPrevious.OnClick(null);
         }
      }
      
      protected function PageOnChange(param1:Object, param2:int) : void
      {
         if(param2 == this.FPageIndex)
         {
            return;
         }
         this.FPageIndex = param2;
         this.InventoriesUpdateSlotsByInventories(this.FUISlots,this.FInventories);
      }
      
      protected function ButtonCloseOnClick(param1:MouseEvent) : void
      {
         ProcessorWindowClose();
         this.FIsSellInventories = false;
      }
      
      protected function ButtonHelpOnOver(param1:MouseEvent) : void
      {
         var _loc2_:TSystemLanguage = null;
         if(this.FOnHelpTipsOver != null)
         {
            _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.HELPTIPS_Backpack) as TSystemLanguage;
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
      
      protected function BtnExpandOnClick(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:String = null;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:Vector.<uint> = null;
         var _loc9_:String = null;
         var _loc10_:uint = 0;
         var _loc11_:TArticle = null;
         var _loc12_:TBins = null;
         var _loc13_:TConfigValue = null;
         var _loc14_:Boolean = false;
         var _loc15_:uint = 0;
         var _loc16_:TInventory = null;
         var _loc17_:uint = 0;
         _loc14_ = this.FIsExpandBackpack;
         _loc17_ = 0;
         _loc6_ = this.FCharacter.BackpackExpandCount;
         this.FExpandCount = _loc6_;
         _loc13_ = this.TConfigValues.GetDatebaseByIdentifier(CONST_CONFIGVALUE.BACKPACK_EXPEND_ITEM) as TConfigValue;
         _loc7_ = uint(_loc13_.Value as int);
         _loc13_ = this.TConfigValues.GetDatebaseByIdentifier(CONST_CONFIGVALUE.BACKPACK_ITEMEXPEND_NEED) as TConfigValue;
         _loc8_ = _loc13_.Value as Vector.<uint>;
         _loc13_ = this.TConfigValues.GetDatebaseByIdentifier(CONST_CONFIGVALUE.BACKPACK_Item_Gold) as TConfigValue;
         _loc15_ = uint(_loc13_.Value as int);
         if(_loc6_ >= _loc8_.length)
         {
            EffectGenerateText(FORMAT_ExpandInvalidPrompt);
            return;
         }
         var _loc18_:int = 0;
         while(_loc18_ < this.FInventories.Count)
         {
            _loc16_ = this.FInventories.GetInventoryByIndex(_loc18_);
            if(_loc16_.CategorySecond == CONST_INVENTORY.CATEGORYSECOND_BagExtend)
            {
               _loc17_ = _loc17_ + _loc16_.Quantity;
            }
            _loc18_++;
         }
         if(_loc17_ >= _loc8_[_loc6_])
         {
            this.FExpandItemQuantity = _loc8_[_loc6_];
            this.FIsGoldEnough = true;
         }
         else
         {
            this.FExpandItemQuantity = _loc17_;
            this.FCostGold = (_loc8_[_loc6_] - _loc17_) * _loc15_;
            if(this.FCostGold <= this.FCharacter.CreditGiftCertificate + this.FCharacter.CreditGold)
            {
               this.FIsGoldEnough = true;
            }
            else
            {
               this.FIsGoldEnough = false;
            }
         }
         if(_loc6_ >= _loc8_.length)
         {
            _loc14_ = false;
         }
         if(_loc14_)
         {
            _loc13_ = this.TConfigValues.GetDatebaseByIdentifier(CONST_CONFIGVALUE.BACKPACK_EXPEND_NUM) as TConfigValue;
            _loc10_ = uint(_loc13_.Value as int);
            this.FExpandCapacity = _loc10_;
            _loc11_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Article,_loc7_) as TArticle;
            _loc9_ = _loc11_.Name;
            _loc2_ = int(_loc6_);
            if(_loc2_ < 0)
            {
               _loc2_ = 0;
            }
            _loc5_ = TUtilityString.Format(new ConsumeFrame(CONST_SYSTEMLANGUAGE.ConsumerConfirm_Backpack_Expend).DescribeString,_loc6_,_loc8_[_loc2_] * _loc15_,_loc10_);
            _loc3_ = _loc5_.indexOf(_loc9_);
            _loc4_ = _loc3_ + _loc9_.length;
            this.FUIWindowInformation.Text = _loc5_;
         }
         else
         {
            this.FUIWindowInformation.Text = FORMAT_ExpandInvalidPrompt;
         }
         this.FIsExpandBackpack = _loc14_;
         this.FUIWindowInformation.Visible = true;
      }
      
      protected function BtnQuickPickUpOnClick(param1:MouseEvent) : void
      {
         this.ProcessorDepotToBag(this.FInventories.Count);
      }
      
      protected function ButtonSellOnClick(param1:MouseEvent) : void
      {
         if(this.FOnButtonSell != null)
         {
            this.FIsSellInventories = !this.FIsSellInventories;
            this.FOnButtonSell(this);
         }
      }
      
      protected function ButtonLockOnClick(param1:MouseEvent) : void
      {
         if(this.FHasLock)
         {
            this.FWindowLock.CancelLock();
         }
         else
         {
            this.FWindowLock.StartSetLock();
         }
         this.FWindowLock.Visible = true;
      }
      
      protected function ButtonLockOnOver(param1:MouseEvent) : void
      {
      }
      
      protected function ButtonLockOnOut(param1:MouseEvent) : void
      {
      }
      
      protected function ButtonMergeBagOnClick(param1:MouseEvent) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Backpack_MergeBagItem_Req);
         _loc3_ = _loc2_.Data;
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
         TGameUtil.setButtonMode(this.FMC_MergeBag,false);
         this.FTF_Timer = this.FMC_MergeBag["TF_Timer"];
         this.FMergeBagTime = STimingCore.GetServerTick();
      }
      
      protected function PopupMenuOnClick(param1:Object) : void
      {
         var _loc2_:int = param1 as int;
         var _loc3_:TInventory = this.FWindowPopupMenu.Context as TInventory;
         var _loc4_:uint = 0;
         switch(_loc2_)
         {
            case POPUPMENUINDEX_Use:
               this.ProcessorPopupMenuUseInventories(_loc3_);
               break;
            case POPUPMENUINDEX_Reveal:
               this.ProcessorsInventoryReveal(_loc3_);
               break;
            case POPUPMENUINDEX_Sell:
               this.FWindowBackpackSell.SetItem(_loc3_);
               this.FWindowBackpackSell.Visible = true;
         }
         this.PopupMenuOnOut(null);
      }
      
      protected function PopupMenuOnOut(param1:MouseEvent) : void
      {
         this.FWindowPopupMenu.Visible = false;
      }
      
      protected function UserAssetsOnDown(param1:MouseEvent) : void
      {
         if(this.FWindowPopupMenu.Visible)
         {
            this.FWindowPopupMenu.Visible = false;
         }
      }
      
      protected function WindowInformationOnOK(param1:Object) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         var _loc4_:uint = 0;
         _loc4_ = 1;
         if(this.FIsExpandBackpack && this.FIsGoldEnough)
         {
            _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Backpack_UseAppliance);
            _loc3_ = _loc2_.Data;
            _loc3_.writeShort(_loc4_);
            _loc3_.writeUnsignedInt(CONST_BACKPACK.BagExtendIDTemplate);
            _loc3_.writeShort(this.FExpandItemQuantity);
            _loc3_.writeUnsignedInt(0);
            SNetworkCore.Transceiver.PacketTransmit(_loc2_);
            this.FExpandCount++;
            this.SetBtnLock(false);
            return;
         }
         this.FUIWindowRecharge.Visible = true;
      }
      
      protected function WindowConfirmationDiscardOnOK(param1:Object) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
      }
      
      protected function WindowConfirmationJadeSellOnOK(param1:Object) : void
      {
         var _loc2_:TInventory = null;
         var _loc3_:uint = 0;
         _loc2_ = this.FWindowBackpackSell.Inventory;
         _loc3_ = this.FWindowBackpackSell.CurCount;
         if(this.FOnSellInventory != null)
         {
            this.FOnSellInventory(this,_loc2_,_loc3_);
         }
      }
      
      protected function WindowConfirmationSellOnOK(param1:Object) : void
      {
         var _loc2_:TInventory = null;
         _loc2_ = this.FWindowBackpackSell.Inventory;
         if(_loc2_ is TEquipment)
         {
            if((_loc2_ as TEquipment).GiftedStoneItems.Count > 0)
            {
               this.FUIWindowConfirmationJadeSell.Text = STRING_BACKPACK.STRING_SellTips;
               this.FUIWindowConfirmationJadeSell.Context = _loc2_;
               this.FUIWindowConfirmationJadeSell.Visible = true;
            }
            else
            {
               this.WindowConfirmationJadeSellOnOK(null);
            }
         }
         else
         {
            this.WindowConfirmationJadeSellOnOK(null);
         }
      }
      
      protected function WindowEditorOnOK(param1:Object) : void
      {
         var _loc2_:TAppliance = null;
         _loc2_ = this.FUIWindowEditor.Context as TAppliance;
         this.FOnUseInventory(this,_loc2_,this.FUIWindowEditor.Value);
         this.SetBtnLock(false);
      }
      
      protected function WindowEditorOnCancel(param1:Object) : void
      {
         this.FUIWindowEditor.Context = null;
      }
      
      protected function WindowEditorOnMax(param1:Object) : void
      {
         var _loc2_:TAppliance = null;
         _loc2_ = this.FWindowPopupMenu.Context as TAppliance;
         this.FUIWindowEditor.Value = _loc2_.Quantity;
         this.FUIWindowEditor.SetFocus();
      }
      
      protected function ProcessorOnChangeClick(param1:TInventory, param2:String) : void
      {
         this.FChangeStr = param2;
         this.FOnUseInventory(this,param1,1,param2);
         this.SetBtnLock(false);
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
      
      public function get OnButtonSell() : Function
      {
         return this.FOnButtonSell;
      }
      
      public function set OnButtonSell(param1:Function) : void
      {
         this.FOnButtonSell = param1;
      }
      
      public function get OnSellInventoryToList() : Function
      {
         return this.FOnSellInventoryToList;
      }
      
      public function set OnSellInventoryToList(param1:Function) : void
      {
         this.FOnSellInventoryToList = param1;
      }
      
      public function get OnSellInventory() : Function
      {
         return this.FOnSellInventory;
      }
      
      public function set OnSellInventory(param1:Function) : void
      {
         this.FOnSellInventory = param1;
      }
      
      public function get OnShortcutHyperlinks() : Function
      {
         return this.FOnShortcutHyperlinks;
      }
      
      public function set OnShortcutHyperlinks(param1:Function) : void
      {
         this.FOnShortcutHyperlinks = param1;
      }
      
      public function get OnInventoryReveal() : Function
      {
         return this.FOnInventoryReveal;
      }
      
      public function set OnInventoryReveal(param1:Function) : void
      {
         this.FOnInventoryReveal = param1;
      }
      
      public function get OnUseInventory() : Function
      {
         return this.FOnUseInventory;
      }
      
      public function set OnUseInventory(param1:Function) : void
      {
         this.FOnUseInventory = param1;
      }
      
      public function get ChangeStr() : String
      {
         return this.FChangeStr;
      }
      
      public function set ChangeStr(param1:String) : void
      {
         this.FChangeStr = param1;
      }
      
      public function Update() : void
      {
         switch(this.FUseApplianceType)
         {
            case 0:
               this.UserUpdateBackpackCapacity();
         }
      }
      
      public function Reset() : void
      {
         this.BackOnlineExtend();
         this.InventoriesUpdate();
         this.UpdateBackpackCapacity();
         this.InventoriesUpdateSlotsByInventories(this.FUISlots,this.FInventories);
      }
      
      public function UserUpdateInventories() : void
      {
         if(Visible)
         {
            this.InventoriesUpdate();
            this.UpdateBackpackCapacity(false);
            this.InventoriesUpdateSlotsByInventories(this.FUISlots,this.FInventories);
         }
      }
      
      public function UserUpdateBackpackCapacity() : void
      {
         this.FCharacter.BackpackExpandCount = this.FExpandCount;
         this.UpdateBackpackCapacity(false);
      }
      
      public function HiddenCorners(param1:Boolean) : void
      {
         this.FMC_HiddenCornersTop.visible = param1;
         this.FMC_HiddenCornersBottom.visible = param1;
      }
      
      public function PlayEffect() : void
      {
         this.FMC_EffectLeft.play();
         this.FMC_EffectRight.play();
      }
      
      public function ResetSellWindow() : void
      {
         this.FIsSellInventories = false;
      }
      
      public function UpdateSelectBox(param1:TInventories) : void
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:TInventory = null;
         var _loc6_:TInventory = null;
         var _loc7_:TUISlot = null;
         var _loc8_:int = 0;
         if(param1 == null)
         {
            return;
         }
         this.InventoriesUpdate();
         this.UpdateBackpackCapacity(false);
         _loc3_ = CAPACITY_Slots;
         _loc4_ = uint(param1.Count);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc7_ = this.FUISlots[_loc2_];
            _loc5_ = _loc7_.Context as TInventory;
            _loc8_ = 0;
            while(_loc8_ < _loc4_)
            {
               _loc6_ = param1.GetInventoryByIndex(_loc8_);
               if(_loc5_ != null && _loc5_.Identifier0 == _loc6_.Identifier0 && _loc5_.Identifier1 == _loc6_.Identifier1)
               {
                  _loc7_.SelectBox = false;
               }
               _loc8_++;
            }
            _loc2_++;
         }
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
      
      public function SetLockUI(param1:Boolean) : void
      {
         this.FHasLock = param1;
         this.FMC_Lock.gotoAndStop(param1 ? 1 : 2);
      }
      
      protected function OnlineTimeClick(param1:MouseEvent) : void
      {
         if(!this.FIsRun && this.FIsCanClick)
         {
            this.RequestOnlineExtend();
         }
      }
      
      protected function OnlineTimeOver(param1:MouseEvent) : void
      {
         var _loc2_:String = "...";
         switch(param1.currentTarget)
         {
            case this.FMC_OnlineTime:
               if(this.FTime)
               {
                  _loc2_ = STRING_BACKPACK.STRING_OnLineTime;
               }
               else
               {
                  _loc2_ = STRING_BACKPACK.STRING_Max;
               }
               break;
            case this.FMC_MainRoleUpgrade:
               if(this.FLevel)
               {
                  _loc2_ = TUtilityString.Format(STRING_BACKPACK.STRING_Upgrade,this.GetMainLevelNum());
               }
               else
               {
                  _loc2_ = STRING_BACKPACK.STRING_Max;
               }
         }
         this.FTExpDecTip.Context = _loc2_;
         this.FTExpDecTip.Render(FUICore.MouseCoordinate);
         this.FTExpDecTip.Show();
      }
      
      protected function GetMainLevelNum() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc2_ = int(this.OnLineLevel[0][1]);
         this.FLevel = false;
         _loc1_ = 0;
         while(_loc1_ < this.OnLineLevel.length)
         {
            if(SLogicsCore.Character.GetMainLevel() < this.OnLineLevel[_loc1_][1])
            {
               _loc2_ = int(this.OnLineLevel[_loc1_][1]);
               this.FLevel = true;
               break;
            }
            _loc1_++;
         }
         return _loc2_;
      }
      
      protected function OnlineTimeOut(param1:MouseEvent) : void
      {
         this.FTExpDecTip.Hide();
      }
      
      protected function OnlineTimemMove(param1:MouseEvent) : void
      {
         if(this.FTExpDecTip.visible)
         {
            this.FTExpDecTip.Render(FUICore.MouseCoordinate);
         }
      }
      
      protected function RequestOnlineExtend() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Backpack_OnlineExtend_Req);
         _loc2_ = _loc1_.Data;
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function RequestOnlineExtendInFormation() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Backpack_OnlineExtendInforMation_Req);
         _loc2_ = _loc1_.Data;
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      public function BackOnlineExtend() : void
      {
         this.RequestOnlineExtendInFormation();
      }
      
      public function SetTimeAndBegin(param1:ByteArray) : void
      {
         var _loc2_:uint = 0;
         this.OpenedBagCount = param1.readUnsignedInt();
         this.OverTime = param1.readUnsignedInt();
         this.OpenedBagCountByLevel = param1.readUnsignedInt();
         this.FCharacter.OpenedBagCount = this.OpenedBagCount;
         this.FCharacter.OpenedBagCountByLevel = this.OpenedBagCountByLevel;
         if(!this.FTF_OnlineTime)
         {
            return;
         }
         this.UpdateBackpackCapacity(false);
         this.GetMainLevelNum();
         if(this.OpenedBagCount >= this.OnLineTime.length)
         {
            this.FIsRun = false;
            this.FIsCanClick = false;
            this.FTF_OnlineTime.visible = false;
            this.FTime = false;
            this.FTF_OnlineTime_.visible = false;
         }
         else
         {
            this.AllTime = this.OnLineTime[this.OpenedBagCount][1];
            this.OverTimeCopy = STimingCore.GetServerTick();
            this.FTF_OnlineTime.visible = true;
            this.FTime = true;
            this.FIsCanClick = true;
            this.FIsRun = true;
         }
      }
      
      public function UpdateTime() : void
      {
         var _loc1_:uint = 0;
         if(!this.FIsRun || !this.visible)
         {
            return;
         }
         _loc1_ = this.OverTime + STimingCore.GetServerTick() - this.OverTimeCopy;
         if(this.AllTime - _loc1_ <= 0)
         {
            this.FIsRun = false;
            this.FMC_OnlineTime.buttonMode = true;
            TGameUtil.drawCirle(this.FSh,50,0);
            this.FTF_OnlineTime.text = STRING_COMMON.STRING_SHUOMING;
            this.FRewardStatus = true;
         }
         else
         {
            this.FMC_OnlineTime.buttonMode = false;
            TGameUtil.drawCirle(this.FSh,50,_loc1_ / this.AllTime * 360 - 360);
            this.FTF_OnlineTime.text = TGameUtil.fomatTime_Copy(this.AllTime - _loc1_ <= 0 ? 0 : int(this.AllTime - _loc1_));
            this.FRewardStatus = false;
         }
      }
      
      protected function ProcessorOnEffectGenerateText(param1:Object, param2:String, param3:TEffectTextParameters = null, param4:TEffectCoordinateParameters = null) : void
      {
         EffectGenerateText(param2);
      }
   }
}

