package Processors.Game.Lobby.Exercise.FrogWallet
{
   import Components.Pages.TUIPage;
   import Components.Slots.TUISlot;
   import Components.Standard.TUIButton;
   import Components.Standard.TUITab;
   import Foundation.Queries.TQueryString;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Resources.Repositories.TResourceRepositoryTexture;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Resources.Textures.TTexture;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.Characters.TCharacter;
   import Logics.DatebaseVO.VO.TArticle;
   import Logics.Exercise.FrogWallet.TShadow;
   import Logics.Exercise.FrogWallet.TShadowConfig;
   import Logics.Inventories.TAppliance;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Windows.Editors.TUIWindowEditor;
   import Resources.Constants.CONST_BACKPACK;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_FROGWALLET;
   import Resources.Constants.CONST_INVENTORY;
   import Resources.Constants.CONST_MODULES;
   import Resources.Strings.STRING_BACKPACK;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorWindowPackage extends TProcessorLobbyWindow
   {
      
      public static const ACTIVITY_4_ID:int = CONST_FROGWALLET.ACTIVITY_4_ID;
      
      public static const SIZE_Window_Width:uint = 500;
      
      public static const SIZE_Window_Height:uint = 300;
      
      public static const CAPACITY_MC_Tabs:uint = CONST_BACKPACK.CAPACITY_MC_Tabs;
      
      public static const STRING_TabsCaption:Vector.<String> = STRING_BACKPACK.STRING_TabsCaption;
      
      public static const CAPACITY_Slots:uint = 24;
      
      public static const INVENTORIESINDEX_Appliances:uint = CONST_COMMON.INVENTORIESINDEX_Appliances;
      
      public static const INVENTORIESINDEX_Equipments:uint = CONST_COMMON.INVENTORIESINDEX_Equipments;
      
      public static const INVENTORIESINDEX_Materials:uint = CONST_COMMON.INVENTORIESINDEX_Materials;
      
      public static const INVENTORIESINDEX_Gems:uint = CONST_COMMON.INVENTORIESINDEX_Gems;
      
      public static const INVENTORIESINDEX_Treasures:uint = CONST_COMMON.INVENTORIESINDEX_Treasures;
      
      public static const INVENTORIESINDEX_Accessories:uint = CONST_COMMON.INVENTORIESINDEX_Accessories;
      
      public static const INVENTORIESINDEX_Medals:uint = CONST_COMMON.INVENTORIESINDEX_Medals;
      
      public static const INVENTORIESINDEX_Temporary:uint = CONST_COMMON.INVENTORIESINDEX_Temporary;
      
      public static const CATEGORY_Normal:uint = CONST_INVENTORY.CATEGORY_Normal;
      
      public static const CATEGORY_Equipment:uint = CONST_INVENTORY.CATEGORY_Equipment;
      
      public static const CATEGORY_Gem:uint = CONST_INVENTORY.CATEGORY_Gem;
      
      public static const CATEGORY_Treasure:uint = CONST_INVENTORY.CATEGORY_Treasure;
      
      public static const CATEGORY_Material:uint = CONST_INVENTORY.CATEGORY_Material;
      
      public static const CATEGORYSECOND_ExperienceReel:uint = CONST_INVENTORY.CATEGORYSECOND_ExperienceReel;
      
      public static const CATEGORYSECOND_MainHeroExperienceReel:uint = CONST_INVENTORY.CATEGORYSECOND_MainHeroExperienceReel;
      
      public static const CATEGORYSECOND_PsychicReel:uint = CONST_INVENTORY.CATEGORYSECOND_PsychicReel;
      
      public static const CATEGORYSECOND_RefiningSoul:uint = CONST_INVENTORY.CATEGORYSECOND_RefiningSoul;
      
      public static const CATEGORYSECOND_TreasureUpgrade:uint = CONST_INVENTORY.CATEGORYSECOND_TreasureUpgrade;
      
      public static const CATEGORYSECOND_TreasureTransform:uint = CONST_INVENTORY.CATEGORYSECOND_TreasureTransform;
      
      public static const CATEGORYSECOND_BagExtend:uint = CONST_INVENTORY.CATEGORYSECOND_BagExtend;
      
      public static const CATEGORYSECOND_Treasure:uint = CONST_INVENTORY.CATEGORYSECOND_Treasure;
      
      protected var FInitialization:Boolean;
      
      protected var FMC_Scene:MovieClip;
      
      protected var FBTN_Close:SimpleButton;
      
      protected var FButtonPrevious:TUIButton;
      
      protected var FButtonNext:TUIButton;
      
      protected var FSlotList:Vector.<TUISlot>;
      
      protected var FUITab:TUITab;
      
      protected var FUIPage:TUIPage;
      
      protected var FTabIndex:int;
      
      protected var FPageIndex:int;
      
      protected var FTF_Page:TextField;
      
      protected var FCharacter:TCharacter;
      
      protected var FInventories:TInventories;
      
      protected var FSelectedInventory:TInventory;
      
      protected var FUIWindowEditor:TUIWindowEditor;
      
      protected var FShadow:TShadow;
      
      protected var FOnCloseUp:Function;
      
      protected var FOnOverlay:Function;
      
      protected var FOnOut:Function;
      
      protected var FOnItemSelected:Function;
      
      public function TProcessorWindowPackage(param1:TUIComponent)
      {
         super(param1);
         this.FSlotList = new Vector.<TUISlot>(CAPACITY_Slots);
         this.FUITab = new TUITab(this);
         this.FUIPage = new TUIPage(this);
         this.FInventories = new TInventories();
         this.FTabIndex = 0;
         this.FCharacter = SLogicsCore.Character;
         this.FInitialization = false;
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_FROGWALLET.RESOURCESID_Swf_Activity);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.graphics.beginFill(0,0.6);
         this.graphics.drawRect(0 - (CONST_COMMON.STAGE_Width - SIZE_Window_Width) / 2,0 - (CONST_COMMON.STAGE_Height - SIZE_Window_Height) / 2,CONST_COMMON.STAGE_Width,CONST_COMMON.STAGE_Height);
         this.graphics.endFill();
         this.FMC_Scene = TUtilityReflection.CreateDisplayObjectInstance(CONST_FROGWALLET.RESOURCE_ClassName_MC_ShadowPackage) as MovieClip;
         addChild(this.FMC_Scene);
         this.FMC_Scene.x = CONST_COMMON.STAGE_Width - SIZE_Window_Width >> 1;
         this.FMC_Scene.y = CONST_COMMON.STAGE_Height - SIZE_Window_Height >> 1;
         this.FBTN_Close = this.FMC_Scene[CONST_FROGWALLET.RESOURCE_Link_BTN_Close];
         this.FUIWindowEditor = new TUIWindowEditor(this,CONST_MODULES.ACTIVE_Test);
         this.FUIWindowEditor.OnOK = this.WindowEditorOnOK;
         this.FUIWindowEditor.OnCancel = this.WindowEditorOnCancel;
         this.FUIWindowEditor.OnMax = this.WindowEditorOnMax;
         this.FUIWindowEditor.x = (CONST_COMMON.STAGE_Width - this.FUIWindowEditor.WindowWidth) / 2;
         this.FUIWindowEditor.y = (CONST_COMMON.STAGE_Height - this.FUIWindowEditor.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowEditor(this.FUIWindowEditor);
         this.ResourcesPerform_UIDispatchTab();
         this.ResourcesPerform_UIDispatchSlotList();
         super.ResourcesPerform_UIDispatch();
      }
      
      protected function ResourcesPerform_UIDispatchTab() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:MovieClip = null;
         _loc2_ = 7;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FMC_Scene[CONST_FROGWALLET.RESOURCE_Link_MC_Tab + _loc1_];
            this.FUITab.SetTabByIndex(_loc3_,_loc1_);
            this.FUITab.SetTabCaptionByIndex(STRING_TabsCaption[_loc1_],_loc1_);
            _loc1_++;
         }
         this.FUITab.OnSwitch = this.TabOnSwitch;
         this.FUITab.Init();
         _loc4_ = this.FMC_Scene[CONST_FROGWALLET.RESOURCE_Link_MC_PageLeft];
         this.FUIPage.ButtonPrevious.Substrate = _loc4_;
         _loc4_ = this.FMC_Scene[CONST_FROGWALLET.RESOURCE_Link_MC_PageRight];
         this.FUIPage.ButtonNext.Substrate = _loc4_;
         this.FTF_Page = this.FMC_Scene[CONST_FROGWALLET.RESOURCE_Link_TF_Page];
         this.FUIPage.LabelPage = this.FTF_Page;
         this.FUIPage.PageSize = CAPACITY_Slots;
         this.FUIPage.Init();
         this.FUIPage.OnChangePage = this.PageOnChange;
         this.FButtonPrevious = this.FUIPage.ButtonPrevious;
         this.FButtonNext = this.FUIPage.ButtonNext;
      }
      
      protected function ResourcesPerform_UIDispatchSlotList() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TUISlot = null;
         _loc2_ = int(CAPACITY_Slots);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = new TUISlot(this);
            _loc3_.Resource = this.FMC_Scene[CONST_FROGWALLET.RESOURCE_LINK_MC_Slot + _loc1_] as Sprite;
            _loc3_.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
            _loc3_.Tag = _loc1_;
            _loc3_.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
            _loc3_.OnQuerySubscript = this.SlotsOnQuerySubscript;
            _loc3_.OnClick = this.SlotsOnClick;
            _loc3_.OnOverlay = this.SlotsOnMove;
            _loc3_.OnOut = this.SlotsOnOut;
            _loc3_.Init();
            this.FSlotList[_loc1_] = _loc3_;
            _loc1_++;
         }
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FBTN_Close.addEventListener(MouseEvent.CLICK,this.ProcessorOnClose);
         super.ResourcesPerform_UILocations();
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TUISlot = null;
         super.LogicsPerform();
         if(this.visible)
         {
            _loc2_ = int(CAPACITY_Slots);
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               _loc3_ = this.FSlotList[_loc1_];
               _loc3_.Update();
               _loc1_++;
            }
            this.FUIWindowEditor.Update();
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
         var _loc5_:TShadowConfig = null;
         _loc3_ = param1.Count;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = param1.GetInventoryByIndex(_loc2_);
            _loc5_ = this.FShadow.GetConfigByItemID(_loc4_.IDTemplate);
            if(_loc5_)
            {
               this.FInventories.Add(_loc4_);
            }
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
            _loc8_.Resource.visible = true;
            _loc3_++;
         }
      }
      
      protected function UpdateBackpackCapacity() : void
      {
         this.FPageIndex = 0;
         this.FUIPage.TotalQuantity = this.FInventories.Count;
         this.FUIPage.PageIndex = this.FPageIndex;
         this.FUIPage.Update();
      }
      
      protected function ProcessorOnClose(param1:MouseEvent = null) : void
      {
         if(this.FOnCloseUp != null)
         {
            this.FOnCloseUp();
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
            _loc6_.LoadSecondary(_loc5_.IDTexture,CONST_MODULES.ACTIVE_Test);
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
         var _loc4_:TAppliance = null;
         var _loc5_:TArticle = null;
         var _loc6_:TShadowConfig = null;
         _loc3_ = param2 as TInventory;
         this.FSelectedInventory = _loc3_;
         this.FUIWindowEditor.Label = this.FSelectedInventory.Name;
         this.FUIWindowEditor.Context = this.FSelectedInventory;
         this.FUIWindowEditor.Quantity = TUtilityString.Format(STRING_BACKPACK.FORMAT_UsePrompt,this.FSelectedInventory.Quantity);
         _loc6_ = this.FShadow.GetConfigByItemID(this.FSelectedInventory.IDTemplate);
         if(!_loc6_)
         {
            return;
         }
         this.FUIWindowEditor.Value = 1;
         this.FUIWindowEditor.Min = 1;
         this.FUIWindowEditor.Max = _loc6_.MaxCnt;
         this.FUIWindowEditor.SetFocus();
         this.FUIWindowEditor.Visible = true;
      }
      
      protected function SlotsOnMove(param1:Object, param2:TInventory) : void
      {
         if(this.FOnOverlay != null)
         {
            this.FOnOverlay(this,param2);
         }
      }
      
      protected function SlotsOnOut(param1:Object, param2:TInventory) : void
      {
         if(this.FOnOut != null)
         {
            this.FOnOut(this,param2);
         }
      }
      
      protected function TabOnSwitch(param1:Object) : void
      {
         this.FTabIndex = param1 as int;
         this.InventoriesUpdate();
         this.UpdateBackpackCapacity();
         this.InventoriesUpdateSlotsByInventories(this.FSlotList,this.FInventories);
      }
      
      protected function PageOnChange(param1:Object, param2:int) : void
      {
         if(param2 == this.FPageIndex)
         {
            return;
         }
         this.FPageIndex = param2;
         this.InventoriesUpdateSlotsByInventories(this.FSlotList,this.FInventories);
      }
      
      protected function WindowEditorOnOK(param1:Object) : void
      {
         this.ProcessorOnClose();
         this.FShadow.PutCount = this.FUIWindowEditor.Value;
         if(this.FOnItemSelected != null)
         {
            this.FOnItemSelected(this.FSelectedInventory);
         }
      }
      
      protected function WindowEditorOnCancel(param1:Object) : void
      {
         this.FUIWindowEditor.Context = null;
      }
      
      protected function WindowEditorOnMax(param1:Object) : void
      {
         var _loc2_:TShadowConfig = null;
         var _loc3_:int = 0;
         _loc2_ = this.FShadow.GetConfigByItemID(this.FSelectedInventory.IDTemplate);
         _loc3_ = Math.min(_loc2_.MaxCnt,this.FSelectedInventory.Quantity);
         this.FUIWindowEditor.Value = _loc3_;
         this.FUIWindowEditor.SetFocus();
      }
      
      public function get OnCloseUp() : Function
      {
         return this.FOnCloseUp;
      }
      
      public function set OnCloseUp(param1:Function) : void
      {
         this.FOnCloseUp = param1;
      }
      
      public function get OnOverlay() : Function
      {
         return this.FOnOverlay;
      }
      
      public function set OnOverlay(param1:Function) : void
      {
         this.FOnOverlay = param1;
      }
      
      public function get OnOut() : Function
      {
         return this.FOnOut;
      }
      
      public function set OnOut(param1:Function) : void
      {
         this.FOnOut = param1;
      }
      
      public function get OnItemSelected() : Function
      {
         return this.FOnItemSelected;
      }
      
      public function set OnItemSelected(param1:Function) : void
      {
         this.FOnItemSelected = param1;
      }
      
      public function get SelectedInventory() : TInventory
      {
         return this.FSelectedInventory;
      }
      
      public function set SelectedInventory(param1:TInventory) : void
      {
         this.FSelectedInventory = param1;
      }
      
      public function Reset() : void
      {
         this.FShadow = SLogicsCore.ActivitiesData.GetActivityByIdentify(ACTIVITY_4_ID) as TShadow;
         this.FShadow.Inventories.Clear();
         this.FSelectedInventory = null;
         this.FShadow.PutCount = 0;
         this.InventoriesUpdate();
         this.UpdateBackpackCapacity();
         this.InventoriesUpdateSlotsByInventories(this.FSlotList,this.FInventories);
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
         this.UpdateBackpackCapacity();
         _loc3_ = CAPACITY_Slots;
         _loc4_ = uint(param1.Count);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc7_ = this.FSlotList[_loc2_];
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
   }
}

