package Processors.Game.Lobby.AccessoryLing
{
   import Components.Pages.TUIPage;
   import Components.ScrollBar.TScrollBar;
   import Components.Slots.TUISlot;
   import Components.Standard.TUITab;
   import Foundation.Network.TPacket;
   import Foundation.Queries.TQueryString;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Resources.Repositories.TResourceRepositoryTexture;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Resources.Textures.TTexture;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.Characters.TCharacter;
   import Logics.Characters.THero;
   import Logics.Characters.THeros;
   import Logics.DatebaseVO.VO.TBaseEquip;
   import Logics.Inventories.TCollectionInventory;
   import Logics.Inventories.TEquipment;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.Talisman.TSingleEquip;
   import Processors.Game.Windows.Information.TUIWindowConfirmation;
   import Resources.Constants.CONST_ACCESSORY_INTENSITY;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_HEROS;
   import Resources.Constants.CONST_MODULES;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_HEROS;
   import Resources.Strings.STRING_SMITHY;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorWindowAccessory extends TProcessorLobbyWindow
   {
      
      public static const CAPACITY_TF_HerosName:uint = CONST_HEROS.CAPACITY_TF_HerosName;
      
      protected static const QUALITYCOLOR_INDEX:Vector.<uint> = CONST_COMMON.QUALITYCOLOR_INDEX;
      
      protected var FMcPanel:Sprite;
      
      protected var FUITabHeros:TUITab;
      
      protected var FHeroPage:TUIPage;
      
      protected var FUITab:TUITab;
      
      protected var FCharacter:TCharacter;
      
      protected var FPageIndex:int;
      
      protected var FHeroPageIndex:int;
      
      protected var FTabHeroIndex:int;
      
      protected var FCurTabIndex:int = 0;
      
      protected var FMC_SingleEquipList:Vector.<TSingleEquip>;
      
      protected var FScrollBar:TScrollBar;
      
      protected var FInitialized:Boolean;
      
      protected var FIntenSityArea:TProcessorIntensityArea = null;
      
      protected var FLingZhuArea:TProcessorLingZhuArea = null;
      
      protected var FChangeArea:TProcessorChangeArea = null;
      
      protected var initilizationTab:Array = null;
      
      protected var FCurrentInventory:TInventory = null;
      
      protected var FCurrentShowEquipmentBag:TInventories;
      
      protected var FLevelUpConfirmation:TUIWindowConfirmation;
      
      protected var FUpgradeConfirmation:TUIWindowConfirmation;
      
      protected var FCloseMe:Function;
      
      protected var FOnInventoryOver:Function;
      
      protected var FOnInventoryOut:Function;
      
      protected var FSlotsOnQuerySequenceContext:Function = null;
      
      protected var FApplianceOnOver:Function = null;
      
      protected var FApplianceOnOut:Function = null;
      
      protected var FIntensityAreaFunction:Function = null;
      
      protected var FLinZhuAreaFunction:Function = null;
      
      protected var FChangeAreaFunction:Function = null;
      
      protected var FSendTipFc:Function = null;
      
      protected var FCur_SingleEquip:TInventory = null;
      
      public function TProcessorWindowAccessory(param1:TUIComponent)
      {
         super(param1);
         this.FIntenSityArea = new TProcessorIntensityArea(this);
         this.FIntenSityArea.SlotsOnQuerySequenceContext = this.OnQuerySequenceContext;
         this.FIntenSityArea.ApplianceOnOver = this.ApplianceOver;
         this.FIntenSityArea.ApplianceOnOut = this.ApplianceOut;
         this.FIntenSityArea.IntenSityBtn = this.IntensityArea;
         this.FIntenSityArea.ExChangeTip = this.ExChangeTip;
         this.FIntenSityArea.SlotsOnOver = this.SlotsOnOver;
         this.FIntenSityArea.SlotsOnOut = this.SlotsOnOut;
         this.FIntenSityArea.ShowFilledWindow = this.ShowIntenSityFilledWindow;
         this.FLingZhuArea = new TProcessorLingZhuArea(this);
         this.FLingZhuArea.SlotsOnQuerySequenceContext = this.OnQuerySequenceContext;
         this.FLingZhuArea.ApplianceOnOver = this.ApplianceOver;
         this.FLingZhuArea.ApplianceOnOut = this.ApplianceOut;
         this.FLingZhuArea.LingzhuBtnFunction = this.LinZhuArea;
         this.FLingZhuArea.ExChangeTip = this.ExChangeTip;
         this.FLingZhuArea.SlotsOnOver = this.SlotsOnOver;
         this.FLingZhuArea.SlotsOnOut = this.SlotsOnOut;
         this.FLingZhuArea.ShowFilledWindow = this.ShowLingZhuFilledWindow;
         this.FChangeArea = new TProcessorChangeArea(this);
         this.FChangeArea.SlotsOnQuerySequenceContext = this.OnQuerySequenceContext;
         this.FChangeArea.ApplianceOnOver = this.ApplianceOver;
         this.FChangeArea.ApplianceOnOut = this.ApplianceOut;
         this.FChangeArea.ChangeBtnFunction = this.ChangeArea;
         this.FChangeArea.ExChangeTip = this.ExChangeTip;
         this.initilizationTab = new Array();
         this.FInitialized = false;
         this.FUITabHeros = new TUITab(this);
         this.FHeroPage = new TUIPage(this);
         this.FUITab = new TUITab(this);
         this.FPageIndex = 0;
         this.FHeroPageIndex = 0;
         this.FTabHeroIndex = 0;
         this.FCharacter = SLogicsCore.Character;
         this.FMC_SingleEquipList = new Vector.<TSingleEquip>();
         this.FCurrentShowEquipmentBag = new TInventories();
      }
      
      public function setEffectPlay() : void
      {
         this.FIntenSityArea.setEffectPaly();
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_ACCESSORY_INTENSITY.INTENSITY_ResourceId);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:TextField = null;
         var _loc5_:MovieClip = null;
         this.FMcPanel = TUtilityReflection.CreateDisplayObjectInstance(CONST_ACCESSORY_INTENSITY.INTENSITY_ResourceRootId) as Sprite;
         addChild(this.FMcPanel);
         this.FMcPanel.x = (FUICore.StageWidth - this.FMcPanel.width) / 2;
         this.FMcPanel.y = (FUICore.StageHeight - this.FMcPanel.height) / 2;
         this.FIntenSityArea.UIPerformFill(this.FMcPanel[CONST_ACCESSORY_INTENSITY.INTENSITY_PagingIntensify]);
         this.FLingZhuArea.UIPerformFill(this.FMcPanel[CONST_ACCESSORY_INTENSITY.INTENSITY_PagingLingZu]);
         this.FChangeArea.UIPerformFill(this.FMcPanel[CONST_ACCESSORY_INTENSITY.INTENSITY_PagingChange]);
         this.initilizationTab.push(this.FIntenSityArea);
         this.initilizationTab.push(this.FLingZhuArea);
         this.initilizationTab.push(this.FChangeArea);
         _loc2_ = int(CAPACITY_TF_HerosName);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FMcPanel[CONST_ACCESSORY_INTENSITY.INTENSITY_GeneralNameGroup][CONST_ACCESSORY_INTENSITY.INTENSITY_General + _loc1_];
            this.FUITabHeros.SetTabByIndex(_loc3_,_loc1_);
            this.FUITabHeros.SetTabCaptionByIndex("",_loc1_);
            _loc1_++;
         }
         this.FUITabHeros.OnSwitch = this.TabHerosOnSwitch;
         this.FUITabHeros.Init();
         this.FUITab.SetTabByIndex(this.FMcPanel[CONST_ACCESSORY_INTENSITY.INTENSITY_TabIntensify],0);
         this.FUITab.SetTabByIndex(this.FMcPanel[CONST_ACCESSORY_INTENSITY.INTENSITY_TabLingZu],1);
         this.FUITab.SetTabByIndex(this.FMcPanel[CONST_ACCESSORY_INTENSITY.INTENSITY_TabChange],2);
         this.FUITab.OnSwitch = this.TabOnSwitch;
         this.FUITab.Init();
         this.FHeroPage.ButtonPrevious.Substrate = this.FMcPanel[CONST_ACCESSORY_INTENSITY.INTENSITY_HeroPage][CONST_ACCESSORY_INTENSITY.INTENSITY_PageLeft];
         this.FHeroPage.ButtonNext.Substrate = this.FMcPanel[CONST_ACCESSORY_INTENSITY.INTENSITY_HeroPage][CONST_ACCESSORY_INTENSITY.INTENSITY_PageRight];
         _loc4_ = this.FMcPanel[CONST_ACCESSORY_INTENSITY.INTENSITY_HeroPage][CONST_ACCESSORY_INTENSITY.INTENSITY_Page];
         this.FHeroPage.LabelPage = _loc4_;
         _loc4_.text = "0/0";
         this.FHeroPage.PageSize = CAPACITY_TF_HerosName;
         this.FHeroPage.Init();
         TGameUtil.setButtonMode(this.FMcPanel[CONST_ACCESSORY_INTENSITY.INTENSITY_HeroPage][CONST_ACCESSORY_INTENSITY.INTENSITY_PageLeft],true);
         TGameUtil.setButtonMode(this.FMcPanel[CONST_ACCESSORY_INTENSITY.INTENSITY_HeroPage][CONST_ACCESSORY_INTENSITY.INTENSITY_PageRight],true);
         _loc5_ = this.FMcPanel[CONST_ACCESSORY_INTENSITY.INTENSITY_list];
         this.FScrollBar = new TScrollBar(_loc5_,348,false,0);
         this.FScrollBar.Clear();
         this.FLevelUpConfirmation = new TUIWindowConfirmation(this.Parent.Parent);
         TUtilityUIWindow.SetupWindowConfirmation(this.FLevelUpConfirmation);
         this.FLevelUpConfirmation.x = (FUICore.StageWidth - this.FLevelUpConfirmation.WindowWidth) / 2;
         this.FLevelUpConfirmation.y = (FUICore.StageHeight - this.FLevelUpConfirmation.WindowHeight) / 2;
         this.FLevelUpConfirmation.SetCheckBox(true);
         this.FLevelUpConfirmation.OnOK = this.OnUseFilledIntenSity;
         this.FLevelUpConfirmation.OnCheckBoxSelected = this.GetIntenSityNeedCost;
         this.FLevelUpConfirmation.SetCheckBoxInfo = STRING_HEROS.STRING_Accessory_SureUseUniversalItem;
         this.FUpgradeConfirmation = new TUIWindowConfirmation(this.Parent.Parent);
         TUtilityUIWindow.SetupWindowConfirmation(this.FUpgradeConfirmation);
         this.FUpgradeConfirmation.x = (FUICore.StageWidth - this.FUpgradeConfirmation.WindowWidth) / 2;
         this.FUpgradeConfirmation.y = (FUICore.StageHeight - this.FUpgradeConfirmation.WindowHeight) / 2;
         this.FUpgradeConfirmation.SetCheckBox(true);
         this.FUpgradeConfirmation.OnOK = this.OnUseFilledLingZhu;
         this.FUpgradeConfirmation.OnCheckBoxSelected = this.GetLingZhuNeedCost;
         this.FUpgradeConfirmation.SetCheckBoxInfo = STRING_HEROS.STRING_Accessory_SureUseUniversalItem;
         super.ResourcesPerform_UIDispatch();
         this.FInitialized = true;
      }
      
      protected function SetTabVisble(param1:int) : void
      {
         this.FIntenSityArea.IsVisible = false;
         this.FLingZhuArea.IsVisible = false;
         this.FChangeArea.IsVisible = false;
         switch(param1)
         {
            case 0:
               this.FIntenSityArea.IsVisible = true;
               this.SelectPageIntensity();
               break;
            case 1:
               this.FLingZhuArea.IsVisible = true;
               this.SelectPageLingZhu();
               break;
            case 2:
               this.FChangeArea.IsVisible = true;
               this.SelectPageChange();
         }
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FMcPanel.addEventListener(MouseEvent.CLICK,this.PanelClick);
         this.FHeroPage.OnChangePage = this.HeroPageOnChange;
         super.ResourcesPerform_UILocations();
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         super.LogicsPerform();
         if(this.FInitialized)
         {
            _loc1_ = int(this.FMC_SingleEquipList.length);
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               this.FMC_SingleEquipList[_loc2_].UpdateSingleEquip();
               _loc2_++;
            }
            this.FIntenSityArea.LogicsPerform();
            this.FLingZhuArea.LogicsPerform();
            this.FChangeArea.LogicsPerform();
         }
      }
      
      protected function GetIntenSityNeedCost(param1:Object, param2:Boolean) : void
      {
         this.FLevelUpConfirmation.Text = this.FIntenSityArea.GetNeedCost(param1,param2);
      }
      
      protected function GetLingZhuNeedCost(param1:Object, param2:Boolean) : void
      {
         this.FUpgradeConfirmation.Text = this.FLingZhuArea.GetNeedCost(param1,param2);
      }
      
      protected function ShowIntenSityFilledWindow(param1:Object) : void
      {
         this.FLevelUpConfirmation.Text = this.FIntenSityArea.GetNeedCost(this,this.FLevelUpConfirmation.IsSelected);
         this.FLevelUpConfirmation.Visible = true;
      }
      
      protected function ShowLingZhuFilledWindow(param1:Object) : void
      {
         this.FUpgradeConfirmation.Text = this.FLingZhuArea.GetNeedCost(this,this.FUpgradeConfirmation.IsSelected);
         this.FUpgradeConfirmation.Visible = true;
      }
      
      protected function OnUseFilledIntenSity(param1:Object) : void
      {
         this.FIntenSityArea.OnUseFilled(param1,this.FLevelUpConfirmation.IsSelected);
      }
      
      protected function OnUseFilledLingZhu(param1:Object) : void
      {
         this.FLingZhuArea.OnUseFilled(param1,this.FUpgradeConfirmation.IsSelected);
      }
      
      public function PanelClick(param1:MouseEvent) : void
      {
         switch(param1.target)
         {
            case this.FMcPanel[CONST_ACCESSORY_INTENSITY.INTENSITY_Close]:
               this.FCloseMe();
               break;
            case this.FMcPanel[CONST_ACCESSORY_INTENSITY.INTENSITY_TabIntensify]:
            case this.FMcPanel[CONST_ACCESSORY_INTENSITY.INTENSITY_TabLingZu]:
            case this.FMcPanel[CONST_ACCESSORY_INTENSITY.INTENSITY_TabChange]:
            case this.FMcPanel[CONST_ACCESSORY_INTENSITY.INTENSITY_PageLeft]:
            case this.FMcPanel[CONST_ACCESSORY_INTENSITY.INTENSITY_PageRight]:
         }
      }
      
      protected function TabHerosOnSwitch(param1:Object) : void
      {
         this.FTabHeroIndex = param1 as int;
         this.UpdateEquip();
         this.UpdateBackpack(this.FTabHeroIndex,this.FCurrentShowEquipmentBag);
      }
      
      protected function UpdateEquip() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:* = 0;
         var _loc3_:TSingleEquip = null;
         var _loc4_:MovieClip = null;
         var _loc5_:TUISlot = null;
         this.FScrollBar.Clear();
         _loc1_ = this.FMC_SingleEquipList.length;
         _loc2_ = int(_loc1_ - 1);
         while(_loc2_ > -1)
         {
            _loc3_ = this.FMC_SingleEquipList[_loc2_];
            this.FMC_SingleEquipList.pop();
            _loc3_.StubReferences.Dereference(this);
            _loc2_--;
         }
         this.FMC_SingleEquipList.length = 0;
      }
      
      protected function TabOnSwitch(param1:Object) : void
      {
         this.FCurTabIndex = param1 as int;
         this.SetTabVisble(this.FCurTabIndex);
      }
      
      protected function UpdateTabs() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:THeros = null;
         var _loc4_:THero = null;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         _loc3_ = this.FCharacter.Heros;
         _loc3_.Sort();
         _loc2_ = _loc3_.Count;
         _loc1_ = 0;
         while(_loc1_ < CAPACITY_TF_HerosName)
         {
            _loc6_ = _loc1_ + this.FHeroPageIndex * CAPACITY_TF_HerosName;
            if(_loc6_ > _loc2_)
            {
               this.FUITabHeros.SetTabHideByIndex(_loc1_);
            }
            else if(_loc6_ == _loc2_)
            {
               this.FUITabHeros.SetTabCaptionByIndex(STRING_COMMON.STRING_Backage,_loc1_,16775109);
               this.FUITabHeros.SetTabShowByIndex(_loc1_);
            }
            else
            {
               _loc4_ = _loc3_.GetHeroByIndex(_loc6_);
               _loc5_ = QUALITYCOLOR_INDEX[_loc4_.Quality];
               this.FUITabHeros.SetTabCaptionByIndex(_loc4_.Name,_loc1_,_loc5_);
               this.FUITabHeros.SetTabShowByIndex(_loc1_);
            }
            _loc1_++;
         }
      }
      
      protected function UpdateHeroUIPage() : void
      {
         this.FHeroPageIndex = 0;
         this.FHeroPage.TotalQuantity = this.FCharacter.Heros.Count + 1;
         this.FHeroPage.PageIndex = this.FHeroPageIndex;
         this.FHeroPage.Update();
      }
      
      protected function HeroPageOnChange(param1:Object, param2:int) : void
      {
         this.FHeroPageIndex = param2;
         this.UpdateTabs();
         this.TabHerosOnSwitch(this);
         this.FUITabHeros.SwithTagManual(0);
      }
      
      protected function UpdateBackpack(param1:int, param2:TInventories) : void
      {
         var _loc3_:uint = 0;
         var _loc4_:int = 0;
         var _loc5_:TSingleEquip = null;
         var _loc6_:TInventory = null;
         var _loc7_:TInventories = null;
         var _loc8_:String = null;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         var _loc13_:THero = null;
         var _loc14_:uint = 0;
         var _loc15_:TCollectionInventory = null;
         _loc11_ = uint(this.FCharacter.Heros.Count);
         _loc14_ = param1 + this.FHeroPageIndex * CAPACITY_TF_HerosName;
         if(_loc14_ < _loc11_)
         {
            _loc13_ = this.FCharacter.Heros.GetHeroByIndex(_loc14_);
            _loc15_ = _loc13_.AccessoryMounted;
            param2.Clear();
            _loc4_ = 0;
            while(_loc4_ < _loc15_.Capacity)
            {
               _loc6_ = _loc15_.GetInventoryByIndex(_loc4_);
               if(_loc6_ != null)
               {
                  if(!this.GetBoolearn(_loc6_))
                  {
                     this.FCurrentShowEquipmentBag.Add(_loc6_);
                  }
               }
               _loc4_++;
            }
         }
         else
         {
            _loc7_ = SLogicsCore.Character.Accessories;
            _loc3_ = uint(_loc7_.Count);
            param2.Clear();
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               _loc6_ = _loc7_.GetInventoryByIndex(_loc4_);
               if(!this.GetBoolearn(_loc6_))
               {
                  param2.Add(_loc6_);
               }
               _loc4_++;
            }
         }
         this.ConstructScroolBar();
      }
      
      protected function GetBoolearn(param1:TInventory) : Boolean
      {
         var _loc2_:TBaseEquip = null;
         if(param1.RequirementLevel > CONST_COMMON.Ninja_One_Reincarnation_Footstone)
         {
            return true;
         }
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BaseEquip,param1.IDTemplate) as TBaseEquip;
         return Boolean(_loc2_.Display);
      }
      
      public function ConstructScroolBar() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TInventory = null;
         var _loc4_:TSingleEquip = null;
         this.UpdateEquip();
         _loc1_ = this.FCurrentShowEquipmentBag.Count;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this.FCurrentShowEquipmentBag.GetInventoryByIndex(_loc2_);
            _loc4_ = SLogicsCore.PoolUISingleEquipment.AcquireUISingleEquipment(this);
            _loc4_.StubReferences.Reference(this);
            _loc4_.OnClick = this.SingleEquipOnClick;
            _loc4_.OnQuerySequenceContext = this.lotsOnQuerySequenceContext;
            _loc4_.OnQueryEuqipLevel = this.SlotsOnQueryEuqipLevel;
            _loc4_.OnOut = this.SlotsOnOut;
            _loc4_.OnOver = this.SlotsOnOver;
            _loc4_.SetEquip(_loc3_,_loc3_.Name,STRING_SMITHY.STRENGTHEPRIFIX_NAME + _loc3_.UpgradingLevel,_loc3_.Quality);
            this.FMC_SingleEquipList.push(_loc4_);
            this.FScrollBar.AddItem(_loc4_);
            _loc2_++;
         }
      }
      
      protected function SingleEquipOnClick(param1:Object, param2:Object) : void
      {
         var _loc3_:TInventory = null;
         var _loc4_:TSingleEquip = null;
         _loc4_ = param1 as TSingleEquip;
         _loc3_ = param2 as TInventory;
         switch(this.FCurTabIndex)
         {
            case 0:
               this.FIntenSityArea.CurrentIntensity = _loc3_;
               this.FIntenSityArea.UpdateIntensity(null);
               break;
            case 1:
               this.FLingZhuArea.CurrentIntensity = _loc3_;
               this.FLingZhuArea.UpdateIntensity(null);
               break;
            case 2:
         }
         this.FCur_SingleEquip = _loc3_;
         this.setStateClick(_loc4_);
      }
      
      public function setStateClick(param1:TSingleEquip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TSingleEquip = null;
         if(!param1)
         {
            return;
         }
         _loc3_ = int(this.FMC_SingleEquipList.length);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = this.FMC_SingleEquipList[_loc2_];
            if(param1 != _loc4_ && _loc4_.BClick)
            {
               _loc4_.BClick = false;
               break;
            }
            _loc2_++;
         }
         param1.BSelect = true;
      }
      
      public function setStateClickCopy(param1:TInventory) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TInventory = null;
         if(!param1)
         {
            return;
         }
         _loc3_ = int(this.FMC_SingleEquipList.length);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = this.FMC_SingleEquipList[_loc2_].Context as TInventory;
            if(param1.Identifier0 == _loc4_.Identifier0 && param1.Identifier1 == _loc4_.Identifier1)
            {
               this.FMC_SingleEquipList[_loc2_].BClick = true;
            }
            else
            {
               this.FMC_SingleEquipList[_loc2_].BClick = false;
            }
            _loc2_++;
         }
      }
      
      public function UpDateIntensity(param1:TPacket) : void
      {
         this.ConstructScroolBar();
         this.FIntenSityArea.UpdateIntensity(param1);
         this.setStateClickCopy(this.FCur_SingleEquip);
      }
      
      public function UpDateLingZhu(param1:TPacket) : void
      {
         this.ConstructScroolBar();
         this.FLingZhuArea.CurrentIntensity = null;
         this.FLingZhuArea.UpdateIntensity(param1);
      }
      
      public function UpDateChange(param1:TPacket, param2:int) : void
      {
         this.FChangeArea.UpdateIntensity(param1,param2);
      }
      
      public function SelectPageIntensity() : void
      {
         this.ConstructScroolBar();
         this.FIntenSityArea.CurrentIntensity = null;
         this.FIntenSityArea.UpdateIntensity(null);
      }
      
      public function SelectPageLingZhu() : void
      {
         this.ConstructScroolBar();
         this.FLingZhuArea.CurrentIntensity = null;
         this.FLingZhuArea.UpdateIntensity(null);
      }
      
      public function SelectPageChange() : void
      {
         this.FChangeArea.FilterMaterial();
         this.FChangeArea.LoaderMaterial();
         this.FChangeArea.SetNullThis();
      }
      
      protected function SlotsOnOver(param1:Object, param2:TInventory) : void
      {
         if(this.FOnInventoryOver != null)
         {
            this.FOnInventoryOver(this,param2,null);
         }
      }
      
      protected function SlotsOnOut(param1:Object, param2:TInventory) : void
      {
         if(this.FOnInventoryOut != null)
         {
            this.FOnInventoryOut(this,param2,null);
         }
      }
      
      protected function lotsOnQuerySequenceContext(param1:Object, param2:Object, param3:TQueryAnimationSequence, param4:uint = 0) : void
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
            _loc6_.LoadSecondary(_loc5_.IDTexture,CONST_MODULES.MODULE_AccessoryLing);
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
      
      protected function OnQuerySequenceContext(param1:Object, param2:Object, param3:TQueryAnimationSequence, param4:uint = 0) : void
      {
         this.FSlotsOnQuerySequenceContext(param1,param2,param3,param4);
      }
      
      protected function ApplianceOver(param1:Object, param2:Object) : void
      {
         this.FApplianceOnOver(param1,param2);
      }
      
      protected function ApplianceOut(param1:Object, param2:Object) : void
      {
         this.FApplianceOnOut(param1,param2);
      }
      
      protected function IntensityArea(param1:Object, param2:uint) : void
      {
         this.FIntensityAreaFunction(param1,param2);
      }
      
      protected function LinZhuArea(param1:Object, param2:uint) : void
      {
         this.FLinZhuAreaFunction(param1,param2);
      }
      
      protected function ChangeArea(param1:Object) : void
      {
         this.FChangeAreaFunction(param1);
      }
      
      public function set SendTipFc(param1:Function) : void
      {
         this.FSendTipFc = param1;
      }
      
      public function set SlotsOnQuerySequenceContext(param1:Function) : void
      {
         this.FSlotsOnQuerySequenceContext = param1;
      }
      
      public function set ApplianceOnOver(param1:Function) : void
      {
         this.FApplianceOnOver = param1;
      }
      
      public function set ApplianceOnOut(param1:Function) : void
      {
         this.FApplianceOnOut = param1;
      }
      
      public function set CloseMe(param1:Function) : void
      {
         this.FCloseMe = param1;
      }
      
      public function set OnInventoryOver(param1:Function) : void
      {
         this.FOnInventoryOver = param1;
      }
      
      public function set OnInventoryOut(param1:Function) : void
      {
         this.FOnInventoryOut = param1;
      }
      
      protected function ExChangeTip(param1:String) : void
      {
         this.FSendTipFc(param1);
      }
      
      public function set IntensityAreaFunction(param1:Function) : void
      {
         this.FIntensityAreaFunction = param1;
      }
      
      public function set LinZhuAreaFunction(param1:Function) : void
      {
         this.FLinZhuAreaFunction = param1;
      }
      
      public function set ChangeAreaFunction(param1:Function) : void
      {
         this.FChangeAreaFunction = param1;
      }
      
      public function OpenMePanel() : void
      {
         this.FTabHeroIndex = 0;
         this.FHeroPageIndex = 0;
         this.FUITabHeros.TabIndex = this.FTabHeroIndex;
         this.UpdateTabs();
         this.UpdateHeroUIPage();
         this.UpdateEquip();
         this.UpdateBackpack(this.FTabHeroIndex,this.FCurrentShowEquipmentBag);
         this.SetTabVisble(this.FCurTabIndex);
         this.SetNullIntensity();
         this.SetNullLingzhu();
         this.SetNullChange();
         this.FChangeArea.IsNeedExecute = true;
         this.FLingZhuArea.setEffectPlay(1);
      }
      
      public function CloseMePanel() : void
      {
         this.FChangeArea.IsNeedExecute = false;
         this.FLingZhuArea.setEffectPlay(0);
      }
      
      public function SetNullIntensity() : void
      {
         this.FIntenSityArea.CurrentIntensity = null;
         this.FIntenSityArea.UpdateIntensity(null);
      }
      
      public function SetNullLingzhu() : void
      {
         this.FLingZhuArea.CurrentIntensity = null;
         this.FLingZhuArea.UpdateIntensity(null);
      }
      
      public function SetNullChange() : void
      {
         this.FChangeArea.FilterMaterial();
         this.FChangeArea.LoaderMaterial();
         this.FChangeArea.SetNullThis();
      }
      
      protected function UpdateEquipmentInfor() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TInventory = null;
         var _loc4_:int = 0;
         var _loc5_:TSingleEquip = null;
         _loc4_ = this.FCurrentShowEquipmentBag.Count;
      }
      
      public function VipLevelUpCheckBtnStatus() : void
      {
         this.FIntenSityArea.VipLevelUpCheckBtnStatus();
         this.FLingZhuArea.VipLevelUpCheckBtnStatus();
      }
   }
}

