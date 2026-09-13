package Processors.Game.Lobby.Warehouse
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
   import Logics.Warehouse.TWarehouse;
   import Processors.Game.Common.Effects.Display.TEffectBaseGlow;
   import Processors.Game.Common.Effects.Texts.TEffectCoordinateParameters;
   import Processors.Game.Common.Effects.Texts.TEffectTextParameters;
   import Processors.Game.Lobby.Backpack.Window.*;
   import Processors.Game.Lobby.Common.*;
   import Processors.Game.Windows.*;
   import Processors.Game.Windows.Editors.*;
   import Processors.Game.Windows.Information.*;
   import Resources.Constants.*;
   import Resources.Strings.*;
   import Utilities.UI.Windows.*;
   import flash.display.*;
   import flash.events.*;
   import flash.text.*;
   import flash.utils.*;
   
   use namespace LogicsSpace;
   
   public class TProcessorWindowWarehouse extends TProcessorLobbyWindow
   {
      
      public static const STAGE_Width:Number = CONST_COMMON.STAGE_Width;
      
      public static const STAGE_Height:Number = CONST_COMMON.STAGE_Height;
      
      public static const CAPACITY_MC_Tabs:uint = CONST_WAREHOUSE.CAPACITY_MC_Tabs;
      
      public static const CAPACITY_Slots:uint = CONST_WAREHOUSE.CAPACITY_Slots;
      
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
      
      public static const STRING_Capacity:String = CONST_COMMON.STRING_Capacity;
      
      protected var TConfigValues:TBins;
      
      protected var FHelpTips:THint;
      
      protected var FUIWindowInformation:TUIWindowConfirmation;
      
      protected var FUIWindowRecharge:TUIWindowRecharge;
      
      protected var FUIWindowConfirmationSell:TUIWindowConfirmation;
      
      protected var FUIWindowConfirmationJadeSell:TUIWindowConfirmation;
      
      protected var FBtn_Close:SimpleButton;
      
      protected var FBtn_Help:SimpleButton;
      
      protected var FMC_EffectLeft:MovieClip;
      
      protected var FMC_EffectRight:MovieClip;
      
      protected var FEffectsBaseGlow:TEffectBaseGlow;
      
      protected var FRewardStatus:Boolean;
      
      protected var FUIImage:TUIImage;
      
      protected var FUISlots:Vector.<TUISlot>;
      
      protected var FUISlotsCopy:Vector.<TUISlot>;
      
      protected var FUITab:TUITab;
      
      protected var FUIPage:TUIPage;
      
      protected var FUIpageCopy:TUIPage;
      
      protected var FTF_Capacity:TextField;
      
      protected var FTF_CapacityCopy:TextField;
      
      protected var FCharacter:TCharacter;
      
      protected var FWarehouse:TWarehouse;
      
      protected var FInventories:TInventories;
      
      protected var FCopyInventories:TInventories;
      
      protected var FButtonPrevious:TUIButton;
      
      protected var FButtonNext:TUIButton;
      
      protected var FTabIndex:int;
      
      protected var FPageIndex:int;
      
      protected var FCurrentCapacity:int;
      
      protected var FBackpackCapacity:int;
      
      protected var FMaxCapacity:int;
      
      protected var FPageIndexCopy:int;
      
      protected var FIsExpandBackpack:Boolean;
      
      protected var FInitialization:Boolean;
      
      protected var FExpandItemQuantity:uint;
      
      protected var FUseApplianceType:uint;
      
      protected var FExpandCapacity:uint;
      
      protected var FExpandCount:uint;
      
      protected var FCostGold:uint;
      
      protected var FIsGoldEnough:Boolean;
      
      protected var FVipData:TVip;
      
      protected var FAccessoryIntensityLevel:int;
      
      protected var OnLineTime:Vector.<Object>;
      
      protected var OnLineLevel:Vector.<Object>;
      
      protected var FTiLiCardVector:Vector.<Object>;
      
      private var AllTime:uint;
      
      private var OverTime:uint;
      
      private var OverTimeCopy:uint;
      
      private var OpenedBagCount:int;
      
      private var OpenedBagCountByLevel:int;
      
      protected var FIsRun:Boolean;
      
      protected var FSh:Shape;
      
      protected var FUIWindowConfirmationCopy:TUIWindowConfirmation;
      
      protected var FOnInventoryOver:Function;
      
      protected var FOnInventoryOut:Function;
      
      protected var FOnHelpTipsOver:Function;
      
      protected var FOnHelpTipsOut:Function;
      
      protected var FOnButtonSell:Function;
      
      protected var FOnSaveInventory:Function;
      
      protected var FOnInventoryReveal:Function;
      
      protected var FOnTakeInventory:Function;
      
      protected var FTime:Boolean;
      
      protected var FLevel:Boolean;
      
      public function TProcessorWindowWarehouse(param1:TUIComponent)
      {
         super(param1);
         this.FHelpTips = new THint();
         this.FUISlots = new Vector.<TUISlot>(CAPACITY_Slots);
         this.FUISlotsCopy = new Vector.<TUISlot>(CAPACITY_Slots);
         this.FUITab = new TUITab(this);
         this.FUIPage = new TUIPage(this);
         this.FUIpageCopy = new TUIPage(this);
         this.FCharacter = SLogicsCore.Character;
         this.FInventories = new TInventories();
         this.FCopyInventories = new TInventories();
         this.FTabIndex = 1;
         this.FIsExpandBackpack = true;
         this.FInitialization = false;
         this.FIsGoldEnough = false;
         this.FVipData = this.FCharacter.VipData;
         this.FWarehouse = SLogicsCore.Warehouse;
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_WAREHOUSE.RESOURCESID_Swf);
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
         _loc3_ = TUtilityReflection.CreateDisplayObjectInstance(CONST_WAREHOUSE.RESOURCE_ClassName_MC_Warehouse) as Sprite;
         addChild(_loc3_);
         this.FBtn_Close = _loc3_[CONST_WAREHOUSE.RESOURCE_Link_Btn_Close];
         this.FBtn_Help = _loc3_[CONST_WAREHOUSE.RESOURCE_Link_Btn_Help];
         this.FMC_EffectLeft = _loc3_[CONST_WAREHOUSE.RESOURCE_Link_MC_EffectLeft];
         this.FMC_EffectRight = _loc3_[CONST_WAREHOUSE.RESOURCE_Link_MC_EffectRight];
         this.FMC_EffectLeft.gotoAndStop(1);
         this.FMC_EffectRight.gotoAndStop(1);
         _loc2_ = int(CAPACITY_MC_Tabs);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc4_ = _loc3_[CONST_WAREHOUSE.RESOURCE_Link_MC_Tabs + _loc1_];
            this.FUITab.SetTabByIndex(_loc4_,_loc1_);
            this.FUITab.SetTabCaptionByIndex(STRING_TabsCaption[_loc1_],_loc1_);
            _loc1_++;
         }
         this.FUITab.OnSwitch = this.TabOnSwitch;
         this.FUITab.Init();
         _loc5_ = _loc3_[CONST_WAREHOUSE.RESOURCE_Link_MC_PageLeft];
         this.FUIPage.ButtonPrevious.Substrate = _loc5_;
         _loc5_ = _loc3_[CONST_WAREHOUSE.RESOURCE_Link_MC_PageRight];
         this.FUIPage.ButtonNext.Substrate = _loc5_;
         this.FTF_Capacity = _loc3_[CONST_WAREHOUSE.RESOURCE_Link_TF_Capacity];
         _loc6_ = _loc3_[CONST_WAREHOUSE.RESOURCE_Link_TF_Page];
         this.FUIPage.LabelPage = _loc6_;
         this.FUIPage.PageSize = CAPACITY_Slots;
         this.FUIPage.Init();
         this.FButtonPrevious = this.FUIPage.ButtonPrevious;
         this.FButtonNext = this.FUIPage.ButtonNext;
         _loc2_ = int(CAPACITY_Slots);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc7_ = new TUISlot(this);
            _loc7_.Resource = _loc3_[CONST_WAREHOUSE.RESOURCE_Link_MC_Slots + _loc1_] as Sprite;
            _loc7_.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
            _loc7_.Tag = _loc1_;
            _loc7_.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
            _loc7_.OnQueryAdvancedEquip = this.SlotsOnQueryAdvancedEquip;
            _loc7_.OnQuerySubscript = this.SlotsOnQuerySubscript;
            _loc7_.OnClick = this.SlotsOnClick;
            _loc7_.OnOverlay = this.SlotsOnMove;
            _loc7_.OnOut = this.SlotsOnOut;
            _loc7_.OnQuerySelectedContext = this.SlotsOnSelectedContext;
            _loc7_.OnQueryEuqipLevel = this.SlotsOnQueryEuqipLevel;
            _loc7_.Init();
            this.FUISlots[_loc1_] = _loc7_;
            _loc1_++;
         }
         _loc8_ = _loc3_[CONST_WAREHOUSE.RESOURCE_Link_MC_WarehouseCopy];
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc7_ = new TUISlot(this);
            _loc7_.Resource = _loc8_[CONST_WAREHOUSE.RESOURCE_Link_MC_Slots + _loc1_] as Sprite;
            _loc7_.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
            _loc7_.Tag = _loc1_;
            _loc7_.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
            _loc7_.OnQueryAdvancedEquip = this.SlotsOnQueryAdvancedEquip;
            _loc7_.OnQuerySubscript = this.SlotsOnQuerySubscript;
            _loc7_.OnClick = this.SlotsOnClickCopy;
            _loc7_.OnOverlay = this.SlotsOnMove;
            _loc7_.OnOut = this.SlotsOnOut;
            _loc7_.OnQuerySelectedContext = this.SlotsOnSelectedContext;
            _loc7_.OnQueryEuqipLevel = this.SlotsOnQueryEuqipLevel;
            _loc7_.Init();
            this.FUISlotsCopy[_loc1_] = _loc7_;
            _loc1_++;
         }
         _loc5_ = _loc8_[CONST_WAREHOUSE.RESOURCE_Link_MC_PageLeft];
         this.FUIpageCopy.ButtonPrevious.Substrate = _loc5_;
         _loc5_ = _loc8_[CONST_WAREHOUSE.RESOURCE_Link_MC_PageRight];
         this.FUIpageCopy.ButtonNext.Substrate = _loc5_;
         this.FTF_CapacityCopy = _loc8_[CONST_WAREHOUSE.RESOURCE_Link_TF_Capacity];
         _loc6_ = _loc8_[CONST_WAREHOUSE.RESOURCE_Link_TF_Page];
         this.FUIpageCopy.LabelPage = _loc6_;
         this.FUIpageCopy.PageSize = CAPACITY_Slots;
         this.FUIpageCopy.Init();
         this.FUIWindowInformation = new TUIWindowConfirmation(this.Parent);
         this.FUIWindowInformation.OnOK = this.WindowInformationOnOK;
         this.FUIWindowInformation.x = (STAGE_Width - this.FUIWindowInformation.WindowWidth) / 2;
         this.FUIWindowInformation.y = (STAGE_Height - this.FUIWindowInformation.WindowHeight) / 2;
         this.FUIWindowRecharge = new TUIWindowRecharge(this.Parent);
         this.FUIWindowRecharge.x = (STAGE_Width - this.FUIWindowRecharge.WindowWidth) / 2;
         this.FUIWindowRecharge.y = (STAGE_Height - this.FUIWindowRecharge.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowRecharge(this.FUIWindowRecharge);
         this.FUIWindowConfirmationJadeSell = new TUIWindowConfirmation(this.Parent);
         this.FUIWindowConfirmationJadeSell.x = (STAGE_Width - this.FUIWindowConfirmationJadeSell.WindowWidth) / 2;
         this.FUIWindowConfirmationJadeSell.y = (STAGE_Height - this.FUIWindowConfirmationJadeSell.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowInformation);
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowConfirmationJadeSell);
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
         this.FUIWindowConfirmationCopy.x = (FUICore.StageWidth - this.FUIWindowConfirmationCopy.WindowWidth) / 2;
         this.FUIWindowConfirmationCopy.y = (FUICore.StageHeight - this.FUIWindowConfirmationCopy.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowConfirmationCopy);
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         var _loc1_:TConfigValue = null;
         this.FBtn_Close.addEventListener(MouseEvent.CLICK,this.ButtonCloseOnClick,false,0,true);
         this.FBtn_Help.addEventListener(MouseEvent.MOUSE_MOVE,this.ButtonHelpOnOver,false,0,true);
         this.FBtn_Help.addEventListener(MouseEvent.MOUSE_OUT,this.ButtonHelpOnOut,false,0,true);
         this.addEventListener(MouseEvent.MOUSE_WHEEL,this.SlotsGroupOnWheel,false,0,true);
         this.FUIPage.OnChangePage = this.PageOnChange;
         this.FUIpageCopy.OnChangePage = this.PageOnChangeCopy;
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
            if(Visible)
            {
            }
         }
      }
      
      protected function ProcessorUpdateSlotsRenderingState() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TUISlot = null;
         var _loc4_:TUISlot = null;
         _loc2_ = int(CAPACITY_Slots);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FUISlots[_loc1_];
            _loc4_ = this.FUISlotsCopy[_loc1_];
            _loc3_.Update();
            _loc4_.Update();
            _loc1_++;
         }
      }
      
      protected function InventoriesUpdate() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TInventories = null;
         var _loc3_:TInventories = null;
         this.FInventories.Clear();
         this.FCopyInventories.Clear();
         _loc1_ = this.FTabIndex;
         switch(_loc1_)
         {
            case INVENTORIESINDEX_Appliances:
               _loc2_ = this.FCharacter.Appliances;
               _loc3_ = this.FWarehouse.Appliances;
               break;
            case INVENTORIESINDEX_Equipments:
               _loc2_ = this.FCharacter.Equipments;
               _loc3_ = this.FWarehouse.Equipments;
               break;
            case INVENTORIESINDEX_Materials:
               _loc2_ = this.FCharacter.Materials;
               _loc3_ = this.FWarehouse.Materials;
               break;
            case INVENTORIESINDEX_Gems:
               _loc2_ = this.FCharacter.Gems;
               _loc3_ = this.FWarehouse.Gems;
               break;
            case INVENTORIESINDEX_Treasures:
               _loc2_ = this.FCharacter.Treasures;
               _loc3_ = this.FWarehouse.Treasures;
               break;
            case INVENTORIESINDEX_Accessories:
               _loc2_ = this.FCharacter.Accessories;
               _loc3_ = this.FWarehouse.Accessories;
               break;
            case INVENTORIESINDEX_Medals:
               _loc2_ = this.FCharacter.Medals;
               _loc3_ = this.FWarehouse.Medals;
               break;
            case INVENTORIESINDEX_Temporary:
               _loc2_ = this.FCharacter.TemporaryInventories;
               _loc3_ = this.FWarehouse.TemporaryInventories;
         }
         this.ProcessorInventories(_loc2_,_loc3_);
      }
      
      protected function ProcessorInventories(param1:TInventories, param2:TInventories) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:TInventory = null;
         _loc4_ = param1.Count;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc5_ = param1.GetInventoryByIndex(_loc3_);
            this.FInventories.Add(_loc5_);
            _loc3_++;
         }
         _loc4_ = param2.Count;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc5_ = param2.GetInventoryByIndex(_loc3_);
            this.FCopyInventories.Add(_loc5_);
            _loc3_++;
         }
      }
      
      protected function InventoriesUpdateSlotsByInventories(param1:Vector.<TUISlot>, param2:TInventories, param3:int) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:TUISlot = null;
         var _loc10_:Sprite = null;
         var _loc11_:TInventory = null;
         _loc8_ = this.FTabIndex;
         _loc7_ = param3;
         _loc5_ = int(CAPACITY_Slots);
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc9_ = param1[_loc4_];
            _loc9_.Context = null;
            _loc9_.Resource.visible = false;
            _loc4_++;
         }
         _loc5_ = param2.Count;
         if(_loc5_ <= 0)
         {
            return;
         }
         _loc6_ = _loc7_ * CAPACITY_Slots;
         _loc4_ = 0;
         while(_loc4_ < CAPACITY_Slots)
         {
            if(_loc4_ + _loc6_ >= _loc5_)
            {
               break;
            }
            _loc9_ = param1[_loc4_];
            _loc11_ = param2.GetInventoryByIndex(_loc4_ + _loc6_);
            _loc9_.Context = _loc11_;
            _loc9_.SelectBox = _loc11_.IsSelling;
            _loc9_.Resource.visible = true;
            _loc4_++;
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
         _loc1_ = CONST_CHARACTER.CAPACITY_Backpack + this.FVipData.BagCount + this.FExpandCapacity * this.FCharacter.BackpackExpandCount + this.FCharacter.OpenedBagCount + this.FCharacter.OpenedBagCountByLevel;
         return _loc1_ - this.GetBackpackCapacity();
      }
      
      protected function UpdateBackpackCapacity(param1:Boolean = true) : void
      {
         this.FCharacter.BackpackCapacity = CONST_CHARACTER.CAPACITY_Backpack + this.FVipData.BagCount + this.FExpandCapacity * this.FCharacter.BackpackExpandCount + this.FCharacter.OpenedBagCount + this.FCharacter.OpenedBagCountByLevel;
         this.FBackpackCapacity = this.FCharacter.BackpackCapacity;
         if(this.FTabIndex == INVENTORIESINDEX_Temporary)
         {
            this.FCurrentCapacity = this.GetBackpackTemporaryCapacity();
            this.FMaxCapacity = this.FCharacter.BackpackTemporaryCapacity;
         }
         else
         {
            this.FCurrentCapacity = this.GetBackpackCapacity();
            this.FMaxCapacity = this.FBackpackCapacity;
            this.FCharacter.CurrentCapacity = this.FCurrentCapacity;
         }
         if(this.FPageIndex < 0)
         {
            param1 = true;
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
         this.FTF_Capacity.text = TUtilityString.Format(STRING_Capacity,this.FCurrentCapacity,this.FMaxCapacity);
      }
      
      protected function UpdateWarehouseCapacity(param1:Boolean = true) : void
      {
         this.FCurrentCapacity = this.GetBackpackCapacity();
         this.FMaxCapacity = this.FBackpackCapacity;
         if(this.FPageIndexCopy < 0)
         {
            param1 = true;
         }
         if(param1)
         {
            this.FPageIndexCopy = 0;
            this.FUIpageCopy.TotalQuantity = this.FCopyInventories.Count;
            this.FUIpageCopy.PageIndex = this.FPageIndexCopy;
            this.FUIpageCopy.Update();
         }
         else
         {
            this.FUIpageCopy.TotalQuantity = this.FCopyInventories.Count;
            this.FUIpageCopy.Update();
            if(this.FPageIndexCopy >= this.FUIpageCopy.TotalPage)
            {
               this.FPageIndexCopy = this.FUIpageCopy.TotalPage - 1;
               this.FUIpageCopy.PageIndex = this.FPageIndexCopy;
               this.FUIpageCopy.Update();
            }
         }
         this.FTF_CapacityCopy.text = TUtilityString.Format(STRING_Capacity,this.FCurrentCapacity,this.FMaxCapacity);
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
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         _loc3_ = param2 as TInventory;
         _loc4_ = _loc3_.Identifier0;
         _loc5_ = _loc3_.Identifier1;
         this.SlotsOnOut(param1,_loc3_);
         this.FOnSaveInventory(_loc4_,_loc5_);
      }
      
      protected function SlotsOnClickCopy(param1:Object, param2:Object) : void
      {
         var _loc3_:TInventory = null;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:TSystemLanguage = null;
         _loc3_ = param2 as TInventory;
         _loc6_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.STRING_BackpadFull) as TSystemLanguage;
         if(this.FCurrentCapacity >= this.FMaxCapacity)
         {
            EffectGenerateText(_loc6_.Desc);
            return;
         }
         _loc4_ = _loc3_.Identifier0;
         _loc5_ = _loc3_.Identifier1;
         this.SlotsOnOut(param1,_loc3_);
         this.FOnTakeInventory(_loc4_,_loc5_);
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
         this.InventoriesUpdate();
         this.UpdateBackpackCapacity();
         this.UpdateWarehouseCapacity();
         this.InventoriesUpdateSlotsByInventories(this.FUISlots,this.FInventories,this.FPageIndex);
         this.InventoriesUpdateSlotsByInventories(this.FUISlotsCopy,this.FCopyInventories,this.FPageIndexCopy);
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
         this.InventoriesUpdateSlotsByInventories(this.FUISlots,this.FInventories,this.FPageIndex);
      }
      
      protected function PageOnChangeCopy(param1:Object, param2:int) : void
      {
         if(param2 == this.FPageIndexCopy)
         {
            return;
         }
         this.FPageIndexCopy = param2;
         this.InventoriesUpdateSlotsByInventories(this.FUISlotsCopy,this.FCopyInventories,this.FPageIndexCopy);
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
            _loc3_.writeUnsignedInt(CONST_WAREHOUSE.BagExtendIDTemplate);
            _loc3_.writeShort(this.FExpandItemQuantity);
            _loc3_.writeUnsignedInt(0);
            SNetworkCore.Transceiver.PacketTransmit(_loc2_);
            ++this.FExpandCount;
            return;
         }
         this.FUIWindowRecharge.Visible = true;
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
      
      public function get OnSaveInventory() : Function
      {
         return this.FOnSaveInventory;
      }
      
      public function set OnSaveInventory(param1:Function) : void
      {
         this.FOnSaveInventory = param1;
      }
      
      public function get OnTakeInventory() : Function
      {
         return this.FOnTakeInventory;
      }
      
      public function set OnTakeInventory(param1:Function) : void
      {
         this.FOnTakeInventory = param1;
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
         this.InventoriesUpdateSlotsByInventories(this.FUISlots,this.FInventories,this.FPageIndex);
         this.InventoriesUpdateSlotsByInventories(this.FUISlotsCopy,this.FCopyInventories,this.FPageIndexCopy);
      }
      
      public function UserUpdateInventories() : void
      {
         if(Visible)
         {
            this.InventoriesUpdate();
            this.UpdateBackpackCapacity(false);
            this.UpdateWarehouseCapacity(false);
            this.InventoriesUpdateSlotsByInventories(this.FUISlots,this.FInventories,this.FPageIndex);
            this.InventoriesUpdateSlotsByInventories(this.FUISlotsCopy,this.FCopyInventories,this.FPageIndexCopy);
         }
      }
      
      public function UserUpdateBackpackCapacity() : void
      {
         this.FCharacter.BackpackExpandCount = this.FExpandCount;
         this.UpdateBackpackCapacity(false);
      }
      
      public function PlayEffect() : void
      {
         this.FMC_EffectLeft.play();
         this.FMC_EffectRight.play();
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
            TGameUtil.drawCirle(this.FSh,50,0);
            this.FRewardStatus = true;
         }
         else
         {
            TGameUtil.drawCirle(this.FSh,50,_loc1_ / this.AllTime * 360 - 360);
            this.FRewardStatus = false;
         }
      }
      
      protected function ProcessorOnEffectGenerateText(param1:Object, param2:String, param3:TEffectTextParameters = null, param4:TEffectCoordinateParameters = null) : void
      {
         EffectGenerateText(param2);
      }
   }
}

