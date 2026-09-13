package Processors.Game.Lobby.Medal
{
   import Components.Pages.TUIPage;
   import Components.Slots.TUISlot;
   import Components.Standard.TUIButton;
   import Components.Standard.TUITab;
   import Foundation.Common.TBounds;
   import Foundation.Common.TCoordinate;
   import Foundation.Queries.TQueryString;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.Repositories.TResourceRepositoryTexture;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Resources.Textures.TTexture;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.Characters.TCharacter;
   import Logics.Characters.THero;
   import Logics.Characters.THeros;
   import Logics.DatebaseVO.VO.TRoleModel;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.Inventories.TEquipment;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.Components.TUIHero;
   import Processors.Game.Lobby.Medal.Component.TUIMedalSlot;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_INVENTORY;
   import Resources.Constants.CONST_MEDAL;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Strings.STRING_COMMON;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   
   public class TProcessorMedalEquip extends TProcessorLobbyWindow
   {
      
      protected static const CAPACITY_Equip:uint = 6;
      
      protected static const TALISMAN_StartIndex:uint = 7;
      
      protected static const TALISMAN_TextWidth:uint = 96;
      
      protected static const TALISMAN_TextPosX:uint = 32;
      
      protected static const TAB_THREE:Number = 3;
      
      protected static const INDEXMEDALS:Vector.<uint> = CONST_INVENTORY.INDEXMEDALS;
      
      protected static const BASEATTRIBUTENAMES:Vector.<uint> = CONST_COMMON.BASEATTRIBUTENAMES;
      
      protected static const STRINGS_BASEATTRIBUTENAMES:Vector.<String> = STRING_COMMON.STRINGS_BASEATTRIBUTENAMES;
      
      protected var FScene:MovieClip;
      
      protected var FUISlots:Vector.<TUISlot>;
      
      protected var FEquipSlots:Vector.<TUIMedalSlot>;
      
      protected var FUIPage:TUIPage;
      
      protected var FMC_HeroPosition:MovieClip;
      
      protected var FTF_Property:TextField;
      
      protected var FTF_Page:TextField;
      
      protected var FRoleIndex:uint;
      
      protected var FMC_Role:MovieClip;
      
      protected var FPage_Index:int;
      
      protected var FInitialized:Boolean;
      
      protected var FCharacter:TCharacter;
      
      protected var FTargetSlot:TUISlot;
      
      protected var FInventory:TInventory;
      
      protected var FUIHero:TUIHero;
      
      protected var FButtonPrevious:TUIButton;
      
      protected var FButtonNext:TUIButton;
      
      protected var FSystemLanguage:TSystemLanguage;
      
      protected var FSystemLanguageBin:TBins;
      
      protected var FMC_BmpList:Vector.<MovieClip>;
      
      protected var FRoleModel:TRoleModel = null;
      
      protected var FCurInventories:TInventories;
      
      protected var FUIHeroTab:TUITab;
      
      protected var FUITabIndex:int;
      
      protected var FSlotOnClick:Function;
      
      protected var FOnInventoryOver:Function;
      
      protected var FOnInventoryOut:Function;
      
      public var OnGoToKillHeros:Function;
      
      protected var Fcurhero:THero;
      
      public function TProcessorMedalEquip(param1:TUIComponent)
      {
         super(param1);
         this.FCharacter = SLogicsCore.Character;
         this.FUIPage = new TUIPage(this);
         this.FUISlots = new Vector.<TUISlot>(CONST_MEDAL.CAPACITY_MC_Slots);
         this.FEquipSlots = new Vector.<TUIMedalSlot>(CONST_MEDAL.CAPACITY_MC_Medal);
         this.FMC_BmpList = new Vector.<MovieClip>();
         this.FUIHeroTab = new TUITab(this);
         this.FInitialized = false;
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_MEDAL.RESOURCES_ID_Swf);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:TextField = null;
         var _loc5_:TUISlot = null;
         var _loc6_:TUIMedalSlot = null;
         super.ResourcesPerform_UIDispatch();
         this.FScene = TUtilityReflection.CreateDisplayObjectInstance(CONST_MEDAL.RESOURCE_ClassName_MC_Medal_Equip) as MovieClip;
         this.x = CONST_MEDAL.POSX_MC_SCENE;
         this.y = CONST_MEDAL.POSY_MC_SCENE;
         addChild(this.FScene);
         _loc3_ = this.FScene[CONST_MEDAL.RESOURCE_Link_MC_PageLeft];
         this.FUIPage.ButtonPrevious.Substrate = _loc3_;
         _loc3_ = this.FScene[CONST_MEDAL.RESOURCE_Link_MC_PageRight];
         this.FUIPage.ButtonNext.Substrate = _loc3_;
         this.FUIPage.OnChangePage = this.ChangePage;
         this.FTF_Page = this.FScene[CONST_MEDAL.RESOURCE_Link_TF_Page];
         this.FUIPage.LabelPage = this.FTF_Page;
         this.FUIPage.PageSize = CONST_MEDAL.CAPACITY_MC_Slots;
         this.FUIPage.Init();
         this.FButtonPrevious = this.FUIPage.ButtonPrevious;
         this.FButtonNext = this.FUIPage.ButtonNext;
         this.FTF_Page = this.FScene[CONST_MEDAL.RESOURCE_Link_TF_Page];
         this.FMC_Role = this.FScene[CONST_MEDAL.RESOURCE_Link_MC_Role];
         this.FMC_HeroPosition = this.FScene[CONST_MEDAL.RESOURCE_Link_MC_HeroPosition];
         this.FPage_Index = 0;
         this.FTF_Property = this.FScene[CONST_MEDAL.RESOURCE_Link_TF_Property];
         _loc2_ = int(CONST_MEDAL.CAPACITY_MC_Slots);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc5_ = new TUISlot(this);
            _loc5_.Resource = this.FScene[CONST_MEDAL.RESOURCE_Link_MC_Slots + _loc1_] as Sprite;
            _loc5_.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
            _loc5_.Tag = _loc1_;
            _loc5_.OnClick = this.EquipOnOnClick;
            _loc5_.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
            _loc5_.OnQueryEuqipLevel = this.SlotsOnQueryEuqipLevel;
            _loc5_.OnOverlay = this.SlotsOnMove;
            _loc5_.OnOut = this.SlotsOnOut;
            _loc5_.Init();
            this.FUISlots[_loc1_] = _loc5_;
            _loc1_++;
         }
         _loc2_ = int(this.FEquipSlots.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc6_ = new TUIMedalSlot(this.FScene[CONST_MEDAL.RESOURCE_Link_MC_Bmp + _loc1_]);
            _loc6_.OnClick = this.EquipOffOnClick;
            this.FEquipSlots[_loc1_] = _loc6_;
            _loc1_++;
         }
         _loc2_ = 4;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.FMC_BmpList[_loc1_] = this.FScene[CONST_MEDAL.RESOURCE_Link_MC_Bmp + _loc1_];
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < TAB_THREE)
         {
            this.FUIHeroTab.SetTabByIndex(this.FScene["BTN_Tab" + _loc1_],_loc1_);
            _loc1_++;
         }
         this.FUIHeroTab.OnSwitch = this.OnTabSwitch;
         this.FUIHeroTab.Init();
         this.FUIHero = new TUIHero(this);
         this.FMC_HeroPosition.addChild(this.FUIHero);
         this.FUIHero.OnQuerySequenceContext = this.HeroOnQuerySequenceContext;
         this.FUIHero.DefaultRole = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_DefaultRoleTexture) as Sprite;
         this.FInitialized = true;
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
      }
      
      override protected function ResourcesPerform_UIFinalize() : void
      {
         this.FSystemLanguageBin = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_SystemLanguage);
         super.ResourcesPerform_UIFinalize();
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TUISlot = null;
         var _loc4_:TUIMedalSlot = null;
         if(this.FInitialized == true)
         {
            _loc2_ = int(CONST_MEDAL.CAPACITY_MC_Slots);
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               _loc3_ = this.FUISlots[_loc1_];
               _loc3_.Update();
               _loc1_++;
            }
            _loc2_ = int(this.FEquipSlots.length);
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               _loc4_ = this.FEquipSlots[_loc1_];
               _loc4_.Update();
               _loc1_++;
            }
            this.FUIHero.Update();
         }
         super.LogicsPerform();
      }
      
      protected function UpdatePageInfo() : void
      {
         var _loc1_:int = 0;
         _loc1_ = this.FPage_Index * CONST_MEDAL.CAPACITY_MC_Slots;
         if(_loc1_ >= this.FCurInventories.Count)
         {
            --this.FPage_Index;
            if(this.FPage_Index < 0)
            {
               this.FPage_Index = 0;
            }
         }
         this.FUIPage.TotalQuantity = this.FCurInventories.Count;
         this.FUIPage.PageIndex = this.FPage_Index;
         this.FUIPage.Update();
      }
      
      protected function UpdateSlotsInfo() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:TUISlot = null;
         _loc3_ = CONST_MEDAL.CAPACITY_MC_Slots;
         _loc1_ = 0;
         while(_loc1_ < _loc3_)
         {
            _loc4_ = this.FUISlots[_loc1_];
            _loc4_.Context = null;
            _loc4_.Resource.visible = false;
            _loc1_++;
         }
         _loc2_ = this.FPage_Index * CONST_MEDAL.CAPACITY_MC_Slots;
         _loc3_ = uint(this.FCurInventories.Count);
         this.FCurInventories.SortCopy();
         _loc1_ = 0;
         while(_loc1_ < CONST_MEDAL.CAPACITY_MC_Slots)
         {
            if(_loc3_ <= _loc2_ + _loc1_)
            {
               break;
            }
            _loc4_ = this.FUISlots[_loc1_];
            _loc4_.Context = this.FCurInventories.GetInventoryByIndex(_loc2_ + _loc1_);
            _loc4_.Resource.visible = true;
            _loc1_++;
         }
      }
      
      protected function UpdateBackpack() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TInventory = null;
         var _loc4_:TInventories = null;
         _loc4_ = new TInventories();
         _loc4_ = this.FCharacter.Medals;
         this.SortInventoriesByCategoryIndex(_loc4_,this.FUITabIndex);
      }
      
      protected function SortInventoriesByCategoryIndex(param1:TInventories, param2:uint) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:TInventory = null;
         var _loc6_:int = 0;
         this.FCurInventories = new TInventories();
         _loc4_ = param1.Count;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc5_ = param1.GetInventoryByIndex(_loc3_);
            _loc6_ = INDEXMEDALS.indexOf(_loc5_.CategorySecond);
            if(_loc6_ == param2)
            {
               this.FCurInventories.Add(_loc5_);
            }
            _loc3_++;
         }
      }
      
      protected function UpdateRole() : void
      {
         var _loc1_:THero = null;
         _loc1_ = this.FCharacter.Heros.GetHeroByIndex(this.FRoleIndex);
         this.Fcurhero = _loc1_;
         this.FUIHero.Context = _loc1_;
      }
      
      protected function UpdateEquip() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUIMedalSlot = null;
         var _loc4_:TInventory = null;
         var _loc5_:THero = null;
         _loc5_ = this.FCharacter.Heros.GetHeroByIndex(this.FRoleIndex);
         _loc2_ = uint(_loc5_.MedalsMounted.Capacity);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FEquipSlots[_loc1_];
            _loc3_.Context = null;
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FEquipSlots[_loc1_];
            _loc4_ = _loc5_.MedalsMounted.GetInventoryByIndex(_loc1_);
            _loc3_.Context = _loc4_;
            if(_loc4_ != null)
            {
               if(_loc4_.UpgradingLevel > 0)
               {
               }
            }
            _loc1_++;
         }
      }
      
      protected function UpdatePropertyText() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:THero = null;
         var _loc4_:TEquipment = null;
         var _loc5_:int = 0;
         var _loc6_:String = "";
         if(this.FRoleIndex >= this.FCharacter.Heros.Count)
         {
            return;
         }
         _loc3_ = this.FCharacter.Heros.GetHeroByIndex(this.FRoleIndex);
         _loc2_ = uint(_loc3_.MedalsMounted.Capacity);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc4_ = _loc3_.MedalsMounted.GetInventoryByIndex(_loc1_) as TEquipment;
            if(_loc4_)
            {
               _loc5_ = BASEATTRIBUTENAMES.indexOf(_loc4_.BasisPropertyCategory);
               _loc6_ += STRINGS_BASEATTRIBUTENAMES[_loc5_];
               _loc6_ = _loc6_ + ("+" + _loc4_.BasisProperty.toString());
               _loc5_ = BASEATTRIBUTENAMES.indexOf(_loc4_.MainAdditionalCategory);
               _loc6_ += "  " + STRINGS_BASEATTRIBUTENAMES[_loc5_];
               _loc6_ = _loc6_ + ("+" + (_loc4_.MainAdditionalValue * 100).toString() + "%\n");
            }
            _loc1_++;
         }
         this.FTF_Property.text = _loc6_;
      }
      
      protected function ChangePage(param1:Object, param2:uint) : void
      {
         this.FPage_Index = param2;
         this.UpdateBackpack();
         this.UpdateSlotsInfo();
      }
      
      protected function OnTabSwitch(param1:Object) : void
      {
         var _loc2_:int = param1 as int;
         if(_loc2_ == this.FUITabIndex)
         {
            return;
         }
         this.FUITabIndex = _loc2_;
         this.SetZearo();
         this.UpdateBackpack();
         this.UpdatePageInfo();
         this.UpdateSlotsInfo();
      }
      
      protected function CharacterUpdateBaseAttributes() : void
      {
         if(this.FInitialized)
         {
            this.UpdatePropertyText();
         }
      }
      
      protected function CheckEquipmentMouted(param1:Function, param2:TInventory) : void
      {
         var _loc3_:THero = null;
         var _loc4_:THeros = null;
         var _loc5_:int = 0;
         var _loc6_:uint = 0;
         var _loc7_:TInventory = null;
         _loc4_ = this.FCharacter.Heros;
         _loc3_ = _loc4_.GetHeroByIndex(this.FRoleIndex);
         _loc6_ = CONST_MEDAL.CAPACITY_MedalNum;
         if(param2.Category == 7)
         {
            _loc5_ = 0;
            while(_loc5_ < _loc6_)
            {
               _loc7_ = _loc3_.MedalsMounted.GetInventoryByIndex(_loc5_);
               if(_loc7_ != null && _loc7_ != param2 && _loc7_.CategorySecond == param2.CategorySecond)
               {
                  if(param1 != null)
                  {
                     param1(this,param2,_loc7_);
                  }
                  return;
               }
               _loc5_++;
            }
            if(param1 != null)
            {
               param1(this,param2,null);
            }
         }
         else if(param1 != null)
         {
            param1(this,param2,null);
         }
      }
      
      protected function EquipOnOnClick(param1:Object, param2:Object) : void
      {
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:TBins = null;
         var _loc6_:THero = null;
         this.FTargetSlot = param1 as TUISlot;
         this.FInventory = param2 as TInventory;
         _loc4_ = this.FCharacter.StarMapIndex;
         if(this.FInventory == null)
         {
            return;
         }
         this.FSystemLanguage = this.FSystemLanguageBin.GetDatebaseByIdentifier(CONST_SYSTEMLANGUAGE.TALISMAN_STRING_07) as TSystemLanguage;
         _loc6_ = this.FCharacter.Heros.GetHeroByIndex(this.FRoleIndex);
         _loc3_ = _loc6_.Quality;
         if(this.FTargetSlot.Context == null)
         {
            return;
         }
         this.FSlotOnClick(this,this.FInventory,CONST_MEDAL.MedalOn_Type,_loc6_.Identifier);
         this.CheckEquipmentMouted(this.FOnInventoryOut,this.FInventory);
      }
      
      protected function EquipOffOnClick(param1:Object, param2:Object) : void
      {
         var _loc3_:THero = null;
         var _loc4_:TEquipment = null;
         _loc3_ = this.FCharacter.Heros.GetHeroByIndex(this.FRoleIndex);
         this.FInventory = param2 as TInventory;
         if(this.FInventory == null)
         {
            return;
         }
         this.FSlotOnClick(this,this.FInventory,CONST_MEDAL.MedalOff_Type,_loc3_.Identifier);
         this.CheckEquipmentMouted(this.FOnInventoryOut,this.FInventory);
      }
      
      protected function SlotsOnBigQuerySequenceContext(param1:Object, param2:Object, param3:TQueryAnimationSequence, param4:uint = 1) : void
      {
         this.SlotsOnQuerySequenceContext(param1,param2,param3,param4);
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
            _loc6_.LoadSecondary(_loc5_.IDTexture,CONST_MODULES.MODULE_Talisman);
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
      
      protected function SlotsOnOut(param1:Object, param2:TInventory) : void
      {
         this.CheckEquipmentMouted(this.FOnInventoryOut,param2);
      }
      
      protected function HeroOnQuerySequenceContext(param1:Object, param2:Object, param3:TQueryAnimationSequence, param4:uint = 0) : void
      {
         var _loc5_:THero = null;
         var _loc6_:TResourceRepositoryTexture = null;
         var _loc7_:TTexture = null;
         var _loc8_:TBounds = null;
         var _loc9_:TCoordinate = null;
         _loc5_ = param2 as THero;
         _loc8_ = new TBounds();
         _loc9_ = new TCoordinate();
         _loc6_ = SResourcesCore.TexturesModel;
         this.FRoleModel = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_RoleModel,_loc5_.Identifier) as TRoleModel;
         _loc7_ = _loc6_.GetTextureByIdentifier(this.FRoleModel.Model);
         if(_loc7_ != null)
         {
            param3.Value = _loc7_.GetAnimationSequenceByIndex(0);
            param3.Value.Evaluate(_loc9_,_loc8_);
            this.FUIHero.X = _loc8_.X;
            this.FUIHero.Y = _loc8_.Y;
         }
         else
         {
            _loc6_.LoadSecondary(this.FRoleModel.Model,CONST_MODULES.MODULE_Talisman);
            this.FUIHero.X = 0;
            this.FUIHero.Y = 0;
         }
      }
      
      public function get SlotOnClick() : Function
      {
         return this.FSlotOnClick;
      }
      
      public function set SlotOnClick(param1:Function) : void
      {
         this.FSlotOnClick = param1;
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
      
      public function Update(param1:uint, param2:uint = 0) : void
      {
         this.FRoleIndex = param1;
         this.UpdateBackpack();
         this.UpdatePageInfo();
         this.UpdateSlotsInfo();
         this.UpdateRole();
         this.UpdateEquip();
         this.UpdatePropertyText();
      }
      
      public function UpdateCharacterBaseAttributes() : void
      {
         this.CharacterUpdateBaseAttributes();
      }
      
      public function SetZearo() : void
      {
         this.FPage_Index = 0;
      }
      
      public function UpdateEquipSlots() : void
      {
         this.UpdateEquip();
         this.UpdateBackpack();
         this.UpdatePageInfo();
         this.UpdateSlotsInfo();
         this.UpdatePropertyText();
      }
      
      public function Reset() : void
      {
         this.FInventory = null;
         this.FTargetSlot = null;
         this.FSystemLanguage = null;
      }
   }
}

