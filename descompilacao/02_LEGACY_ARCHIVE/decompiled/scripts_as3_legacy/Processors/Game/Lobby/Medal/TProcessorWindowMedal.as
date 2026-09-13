package Processors.Game.Lobby.Medal
{
   import Components.Pages.TUIPage;
   import Components.Slots.TUISlot;
   import Components.Standard.TUITab;
   import Foundation.Common.THint;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.Characters.TCharacter;
   import Logics.Characters.THero;
   import Logics.Characters.THeros;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.Medal.TMedalRefinedPakcetUnstreamizerData;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MEDAL;
   import Resources.Strings.STRING_COMMON;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorWindowMedal extends TProcessorLobbyWindow
   {
      
      public static const INDEX_MC_Tab_Use:uint = 0;
      
      public static const INDEX_MC_Tab_LevelUp:uint = 1;
      
      public static const INDEX_MC_Tab_Transition:uint = 2;
      
      public static const INDEX_MC_Tab_Upgrage:uint = 3;
      
      public static const INDEX_MC_Tab_Resolve:uint = 4;
      
      protected static const TAB_NUM:int = CONST_MEDAL.CAPACITY_MC_Tabs;
      
      protected var FHelpTips:THint;
      
      protected var FBtn_Close:SimpleButton;
      
      protected var FBtn_Help:SimpleButton;
      
      protected var FUITab:TUITab;
      
      protected var FMCTab:TUITab;
      
      protected var FUIPageHeroList:TUIPage;
      
      protected var FPageIndexHeroList:int;
      
      protected var FItemIndex:uint;
      
      protected var FRoleIndex:uint;
      
      protected var FMC_UIList:Array;
      
      protected var FMedalEquip:TProcessorMedalEquip;
      
      protected var FMedalUpgrade:TProcessorMedalUpgrade;
      
      protected var FMedalRefined:TProcessorMedalRefined;
      
      protected var FRoleTabs:uint;
      
      protected var FCharacter:TCharacter;
      
      protected var FUpgradeBin:TBins;
      
      protected var FUIComponentsHintOnOver:Function;
      
      protected var FUIComponentsHintOnOut:Function;
      
      protected var FEquipOnOffOnClick:Function;
      
      protected var FUpgradeOnClick:Function;
      
      protected var FRefinedOnClick:Function;
      
      protected var FOnHelpTipsOver:Function;
      
      protected var FOnHelpTipsOut:Function;
      
      protected var FOnTipsOver:Function;
      
      protected var FOnTipsOut:Function;
      
      protected var FResolveLevel:uint;
      
      protected var FHint:THint;
      
      protected var FOnUpdateHerosBaseAttributeReq:Function;
      
      private var FOnGoToKillHeros:Function;
      
      public function TProcessorWindowMedal(param1:TUIComponent)
      {
         super(param1);
         this.FHelpTips = new THint();
         this.FUITab = new TUITab(this);
         this.FMCTab = new TUITab(this);
         this.FMC_UIList = [];
         this.FMedalEquip = new TProcessorMedalEquip(this);
         this.FMC_UIList.push(this.FMedalEquip);
         this.FMedalUpgrade = new TProcessorMedalUpgrade(this);
         this.FMC_UIList.push(this.FMedalUpgrade);
         this.FMedalRefined = new TProcessorMedalRefined(this);
         this.FMC_UIList.push(this.FMedalRefined);
         this.FCharacter = SLogicsCore.Character;
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
         var _loc4_:MovieClip = null;
         var _loc5_:MovieClip = null;
         var _loc6_:TextField = null;
         var _loc7_:TUISlot = null;
         var _loc8_:MovieClip = null;
         _loc3_ = TUtilityReflection.CreateDisplayObjectInstance(CONST_MEDAL.RESOURCE_ClassName_MC_Medal) as MovieClip;
         addChild(_loc3_);
         this.FBtn_Close = _loc3_[CONST_MEDAL.RESOURCE_Link_Btn_Close];
         this.FBtn_Help = _loc3_[CONST_MEDAL.RESOURCE_Link_Btn_Help];
         _loc2_ = int(this.FMC_UIList.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            addChild(this.FMC_UIList[_loc1_]);
            _loc1_++;
         }
         _loc2_ = int(CONST_MEDAL.CAPACITY_MC_Tabs);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc4_ = _loc3_[CONST_MEDAL.RESOURCE_Link_MC_Tabs + _loc1_];
            this.FUITab.SetTabByIndex(_loc4_,_loc1_);
            _loc1_++;
         }
         this.FUITab.OnSwitch = this.RoleTabOnSwitch;
         this.FUITab.Init();
         this.FUIPageHeroList = new TUIPage(this);
         this.FUIPageHeroList.ButtonPrevious.Substrate = _loc3_["MC_HeroPage"]["MC_PageLeft"];
         this.FUIPageHeroList.ButtonNext.Substrate = _loc3_["MC_HeroPage"]["MC_PageRight"];
         this.FUIPageHeroList.LabelPage = _loc3_["MC_HeroPage"]["TF_Page"];
         this.FUIPageHeroList.PageSize = TAB_NUM;
         this.FUIPageHeroList.OnChangePage = this.HeroListPageOnChange;
         this.FUIPageHeroList.Init();
         _loc2_ = int(CONST_MEDAL.RESOURCE_Link_MC_Tab_Vector.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc4_ = _loc3_[CONST_MEDAL.RESOURCE_Link_MC_Tab_Vector[_loc1_]];
            this.FMCTab.SetTabByIndex(_loc4_,_loc1_);
            _loc1_++;
         }
         this.FMCTab.OnSwitch = this.ItemTabOnSwitch;
         this.FMCTab.Init();
         this.FMCTab.OnOver = this.UITabOnOver;
         this.FMCTab.OnOut = this.UITabOnOut;
         this.FUpgradeBin = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_RuneEnchantValue);
         this.FMedalEquip.SlotOnClick = this.FEquipOnOffOnClick;
         this.FMedalEquip.OnInventoryOver = this.FUIComponentsHintOnOver;
         this.FMedalEquip.OnInventoryOut = this.FUIComponentsHintOnOut;
         this.FMedalEquip.OnEffectText = OnEffectText;
         this.FMedalUpgrade.Bin = this.FUpgradeBin;
         this.FMedalUpgrade.UpgradeOnclick = this.FUpgradeOnClick;
         this.FMedalUpgrade.OnInventoryOver = this.FUIComponentsHintOnOver;
         this.FMedalUpgrade.OnInventoryOut = this.FUIComponentsHintOnOut;
         this.FMedalUpgrade.OnEffectText = OnEffectText;
         this.FMedalUpgrade.OnTipsOver = this.FOnTipsOver;
         this.FMedalUpgrade.OnTipsOut = this.FOnTipsOut;
         this.FMedalRefined.RefinedOnClick = this.FRefinedOnClick;
         this.FMedalRefined.OnInventoryOver = this.FUIComponentsHintOnOver;
         this.FMedalRefined.OnInventoryOut = this.FUIComponentsHintOnOut;
         super.ResourcesPerform_UIDispatch();
      }
      
      protected function UITabOnOver(param1:Object, param2:uint, param3:Boolean) : void
      {
         var _loc4_:TUITab = null;
         var _loc5_:MovieClip = null;
         if(!param3 && param2 == INDEX_MC_Tab_Resolve)
         {
            _loc4_ = param1 as TUITab;
            _loc5_ = _loc4_.GetTabByIndex(param2);
            if(_loc5_.currentFrame != TUITab.RENDERINGSTATE_Disabled)
            {
               return;
            }
            this.FHint.Content = "";
            if(this.FOnHelpTipsOver != null)
            {
               this.FOnHelpTipsOver(this,this.FHint);
            }
         }
      }
      
      protected function UITabOnOut(param1:Object, param2:uint, param3:Boolean) : void
      {
         if(!param3 && param2 == INDEX_MC_Tab_Resolve)
         {
            if(this.FOnHelpTipsOut != null)
            {
               this.FOnHelpTipsOut(this);
            }
         }
      }
      
      protected function SetupHeroListPage(param1:int, param2:int) : void
      {
         this.FUIPageHeroList.TotalQuantity = param1;
         this.FUIPageHeroList.Update();
         this.FUIPageHeroList.PageIndex = param2;
      }
      
      protected function RoleTabOnSwitch(param1:Object) : void
      {
         if(param1 is int)
         {
            this.FRoleIndex = param1 as int;
         }
         this.FRoleIndex += this.FPageIndexHeroList * TAB_NUM;
         this.UpdateRole(this.FRoleIndex,this.FItemIndex);
      }
      
      protected function ItemTabOnSwitch(param1:Object) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         if(param1 is int)
         {
            this.FItemIndex = param1 as int;
            _loc5_ = this.FCharacter.Heros.Count % TAB_NUM;
            if(this.FItemIndex == INDEX_MC_Tab_Resolve)
            {
               _loc5_ = 1;
               _loc4_ = 1;
            }
            else if(this.FItemIndex > 0)
            {
               if(this.FUIPageHeroList.TotalPage == this.FPageIndexHeroList + 1 && _loc5_ != 0)
               {
                  _loc5_ += 1;
               }
               _loc4_ = this.FCharacter.Heros.Count + 1;
            }
            else
            {
               _loc4_ = uint(this.FCharacter.Heros.Count);
            }
         }
         this.HeroListPageOnChange(this,0);
         this.FUIPageHeroList.TotalQuantity = _loc4_;
         this.FUIPageHeroList.Update();
         this.FUIPageHeroList.PageIndex = this.FPageIndexHeroList;
         this.FMedalUpgrade.ResetCopy();
         this.UpdateUI(this.FItemIndex);
         this.FMedalEquip.SetZearo();
         this.UpdateRole(this.FRoleIndex,this.FItemIndex);
      }
      
      protected function UpdateUI(param1:uint) : void
      {
         var _loc2_:int = 0;
         var _loc3_:uint = this.FMC_UIList.length;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            if(_loc2_ == param1)
            {
               this.FMC_UIList[_loc2_].visible = true;
            }
            else
            {
               this.FMC_UIList[_loc2_].visible = false;
            }
            _loc2_++;
         }
      }
      
      protected function UpdateRole(param1:uint, param2:uint) : void
      {
         this.FMC_UIList[param2].Update(param1,param2);
         if(param2 == 0)
         {
            if(this.FOnUpdateHerosBaseAttributeReq != null)
            {
               this.FOnUpdateHerosBaseAttributeReq(this);
            }
         }
      }
      
      override public function set Visible(param1:Boolean) : void
      {
         super.Visible = param1;
         if(Boolean(param1) && Boolean(this.FCharacter) && this.FCharacter.MainHero.Level >= this.FResolveLevel)
         {
         }
      }
      
      protected function UpdateRoleTab() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:THero = null;
         var _loc4_:uint = 0;
         var _loc5_:THeros = null;
         _loc5_ = this.FCharacter.Heros;
         this.FRoleTabs = this.FUIPageHeroList.TotalPage == this.FPageIndexHeroList + 1 ? uint(_loc5_.Count - this.FPageIndexHeroList * TAB_NUM) : uint(TAB_NUM);
         _loc5_.Sort();
         _loc2_ = int(CONST_MEDAL.CAPACITY_MC_Tabs);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(_loc1_ < this.FRoleTabs)
            {
               _loc3_ = _loc5_.GetHeroByIndex(_loc1_ + this.FPageIndexHeroList * TAB_NUM);
               _loc4_ = CONST_COMMON.QUALITYCOLOR_INDEX[_loc3_.Quality];
               this.FUITab.SetTabShowByIndex(_loc1_);
               this.FUITab.SetTabCaptionByIndex(_loc3_.Name,_loc1_,_loc4_);
            }
            else if(_loc1_ == this.FRoleTabs)
            {
               if(this.FItemIndex > 0)
               {
                  this.FUITab.SetTabShowByIndex(_loc1_);
                  this.FUITab.SetTabCaptionByIndex(STRING_COMMON.STRING_Backage,this.FRoleTabs,16775109);
               }
               else
               {
                  this.FUITab.SetTabHideByIndex(this.FRoleTabs);
               }
            }
            else if(_loc1_ > this.FRoleTabs)
            {
               this.FUITab.SetTabHideByIndex(_loc1_);
            }
            _loc1_++;
         }
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         if(!this.FBtn_Close.hasEventListener(MouseEvent.CLICK))
         {
            this.FBtn_Close.addEventListener(MouseEvent.CLICK,this.BtnCloseHandler,false,0,true);
         }
         this.FBtn_Help.addEventListener(MouseEvent.MOUSE_MOVE,this.ButtonHelpOnOver,false,0,true);
         this.FBtn_Help.addEventListener(MouseEvent.MOUSE_OUT,this.ButtonHelpOnOut,false,0,true);
         super.ResourcesPerform_UILocations();
      }
      
      private function HeroListPageOnChange(param1:Object, param2:int) : void
      {
         this.FPageIndexHeroList = param2;
         this.UpdateRoleTab();
         this.FUITab.SwithTagManual(0);
         this.RoleTabOnSwitch(0);
      }
      
      protected function BtnCloseHandler(param1:MouseEvent) : void
      {
         ProcessorWindowClose();
      }
      
      protected function ButtonHelpOnOver(param1:MouseEvent) : void
      {
         var _loc2_:TSystemLanguage = null;
         if(this.FOnHelpTipsOver != null)
         {
            _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,70170116) as TSystemLanguage;
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
      
      public function set CurrentRefinedAttributeData(param1:TMedalRefinedPakcetUnstreamizerData) : void
      {
         this.FMedalRefined.CurrentRefinedAttributeData = param1;
      }
      
      public function get EquipOnOffOnClick() : Function
      {
         return this.FEquipOnOffOnClick;
      }
      
      public function set EquipOnOffOnClick(param1:Function) : void
      {
         this.FEquipOnOffOnClick = param1;
      }
      
      public function get UpgradeOnClick() : Function
      {
         return this.FUpgradeOnClick;
      }
      
      public function set UpgradeOnClick(param1:Function) : void
      {
         this.FUpgradeOnClick = param1;
      }
      
      public function get RefinedOnClick() : Function
      {
         return this.FRefinedOnClick;
      }
      
      public function set RefinedOnClick(param1:Function) : void
      {
         this.FRefinedOnClick = param1;
      }
      
      public function get UIComponentsHintOnOver() : Function
      {
         return this.FUIComponentsHintOnOver;
      }
      
      public function set UIComponentsHintOnOver(param1:Function) : void
      {
         this.FUIComponentsHintOnOver = param1;
      }
      
      public function get UIComponentsHintOnOut() : Function
      {
         return this.FUIComponentsHintOnOut;
      }
      
      public function set UIComponentsHintOnOut(param1:Function) : void
      {
         this.FUIComponentsHintOnOut = param1;
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
      
      public function get OnTipsOver() : Function
      {
         return this.FOnTipsOver;
      }
      
      public function set OnTipsOver(param1:Function) : void
      {
         this.FOnTipsOver = param1;
      }
      
      public function get OnTipsOut() : Function
      {
         return this.FOnTipsOut;
      }
      
      public function set OnTipsOut(param1:Function) : void
      {
         this.FOnTipsOut = param1;
      }
      
      public function get OnUpdateHerosBaseAttributeReq() : Function
      {
         return this.FOnUpdateHerosBaseAttributeReq;
      }
      
      public function set OnUpdateHerosBaseAttributeReq(param1:Function) : void
      {
         this.FOnUpdateHerosBaseAttributeReq = param1;
      }
      
      override public function Load() : void
      {
         super.Load();
         this.FMedalEquip.Load();
         this.FMedalUpgrade.Load();
         this.FMedalRefined.Load();
      }
      
      public function Init() : void
      {
      }
      
      public function Update(param1:int = -1, param2:int = -1) : void
      {
         if(param1 > -1)
         {
            if(param1 > INDEX_MC_Tab_Use)
            {
               this.SetupHeroListPage(this.FCharacter.Heros.Count + 1,0);
            }
            else if(param1 == INDEX_MC_Tab_Resolve)
            {
               this.SetupHeroListPage(1,0);
            }
            else
            {
               this.SetupHeroListPage(this.FCharacter.Heros.Count,this.FPageIndexHeroList);
            }
         }
         if(param1 > -1)
         {
            this.FItemIndex = param1;
            this.FMCTab.SwithTagManual(this.FItemIndex);
         }
         if(param2 > -1)
         {
            this.FRoleIndex = this.FCharacter.HeroIndex;
            this.FUITab.SwithTagManual(this.FRoleIndex);
            if(this.FRoleIndex <= 0)
            {
               this.RoleTabOnSwitch(this.FRoleIndex);
            }
         }
         this.FMedalEquip.SetZearo();
         this.UpdateRoleTab();
         this.UpdateUI(this.FItemIndex);
         this.UpdateRole(this.FRoleIndex,this.FItemIndex);
      }
      
      public function UpdateEquip() : void
      {
         this.FMedalEquip.UpdateEquipSlots();
      }
      
      public function UpdateCharacterBaseAttribute() : void
      {
         this.FMedalEquip.UpdateCharacterBaseAttributes();
      }
      
      public function UpdateUpgradeEquip() : void
      {
         this.FMedalUpgrade.UpdateUpgradeEquip();
      }
      
      public function UpdateMedalRefined() : void
      {
         this.FMedalRefined.Update1();
      }
      
      public function Reset() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         _loc2_ = this.FMC_UIList.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.FMC_UIList[_loc1_].Reset();
            _loc1_++;
         }
         this.FPageIndexHeroList = 0;
         this.FCharacter.HeroIndex = 0;
         this.FCharacter.PageIndex = 0;
      }
      
      public function SetBtnLock() : void
      {
         this.FMC_UIList[this.FItemIndex].SetBtnLock(true);
      }
   }
}

