package Processors.Game.Lobby.Smithy
{
   import Components.Pages.TUIPage;
   import Components.ScrollBar.*;
   import Components.Slots.*;
   import Components.Standard.*;
   import Foundation.Queries.TQueryString;
   import Foundation.Queries.Textures.*;
   import Foundation.Resources.*;
   import Foundation.Resources.Repositories.*;
   import Foundation.Resources.Textures.*;
   import Foundation.UI.*;
   import Logics.*;
   import Logics.Characters.*;
   import Logics.DatebaseVO.VO.TEquipUpgrade;
   import Logics.Inventories.*;
   import Processors.Game.Lobby.Common.*;
   import Processors.Game.Lobby.Jade.*;
   import Processors.Game.Lobby.Talisman.*;
   import Resources.Constants.*;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_SMITHY;
   import flash.display.*;
   import flash.events.*;
   import flash.text.*;
   
   public class SmithyWindowEquipShow extends TProcessorLobbyWindow
   {
      
      protected static const TAB_INDEX_STRENGTHEN:int = 0;
      
      protected static const TAB_INDEX_REFINED:int = 1;
      
      protected static const TAB_INDEX_INHERIT:int = 2;
      
      protected static const TAB_INDEX_PUNCH:int = 3;
      
      protected static const TAB_INDEX_ENCHANT:int = 4;
      
      protected static const TAB_INDEX_UPGRADE:int = 6;
      
      protected static const QUALITYCOLOR_INDEX:Vector.<uint> = CONST_COMMON.QUALITYCOLOR_INDEX;
      
      protected static const TAB_NUM:int = CONST_TALISMAN.CAPACITY_MC_Tabs;
      
      protected var FUIDispatchRoutines:Vector.<Function>;
      
      protected var FUILocationRoutines:Vector.<Function>;
      
      protected var FInitialization:Boolean;
      
      protected var FMC_SingleEquipList:Vector.<TSingleEquip>;
      
      protected var FCurrentClickSingleEquip:TSingleEquip;
      
      protected var FMC_List:MovieClip;
      
      protected var FScrollBar:TScrollBar;
      
      protected var FMC_HeroTags:Vector.<MovieClip>;
      
      protected var FHeroNameTab:TUITab;
      
      protected var FUIPageHeroList:TUIPage;
      
      protected var FPageIndexHeroList:int;
      
      protected var FCurrentShowTagIndex:int;
      
      protected var FCurrentShowEquipmentBag:TInventories;
      
      protected var FTabIndex:uint;
      
      protected var FFatherUIInner:MovieClip;
      
      protected var FOnEquipmentClick:Function;
      
      protected var FOnSlotMouseOver:Function;
      
      protected var FOnSlotMouseOut:Function;
      
      public function SmithyWindowEquipShow(param1:TUIComponent)
      {
         super(param1);
         this.ConstructDispatchRoutines();
         this.ConstructLocationRoutines();
      }
      
      protected function ConstructDispatchRoutines() : void
      {
         this.FUIDispatchRoutines = new Vector.<Function>();
         this.FUIDispatchRoutines.push(this.HeroTagUIDispath);
         this.FUIDispatchRoutines.push(this.EquipmentUIDispath);
      }
      
      public function Perform_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Function = null;
         _loc2_ = 0;
         while(_loc2_ < this.FUIDispatchRoutines.length)
         {
            _loc3_ = this.FUIDispatchRoutines[_loc2_];
            _loc3_(param1);
            _loc2_++;
         }
      }
      
      protected function ConstructLocationRoutines() : void
      {
         this.FUILocationRoutines = new Vector.<Function>();
         this.FUILocationRoutines.push(this.HeroTagLocation);
         this.FUILocationRoutines.push(this.EquipmentLocation);
      }
      
      public function Perform_UILocation() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Function = null;
         _loc1_ = 0;
         while(_loc1_ < this.FUILocationRoutines.length)
         {
            _loc2_ = this.FUILocationRoutines[_loc1_];
            _loc2_();
            _loc1_++;
         }
         this.Reset();
         this.FInitialization = true;
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TSingleEquip = null;
         super.LogicsPerform();
         if(this.FInitialization)
         {
            _loc2_ = int(this.FMC_SingleEquipList.length);
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               _loc3_ = this.FMC_SingleEquipList[_loc1_];
               _loc3_.UpdateSingleEquip();
               _loc1_++;
            }
         }
      }
      
      protected function HeroTagUIDispath(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:TextField = null;
         var _loc5_:MovieClip = null;
         this.FMC_HeroTags = new Vector.<MovieClip>();
         _loc5_ = param1["GeneralNameGroup"];
         this.FFatherUIInner = _loc5_;
         _loc2_ = 0;
         while(_loc2_ < TAB_NUM)
         {
            _loc3_ = _loc5_["General_" + _loc2_];
            this.FMC_HeroTags.push(_loc3_);
            _loc2_++;
         }
         this.FUIPageHeroList = new TUIPage(this);
         this.FUIPageHeroList.ButtonPrevious.Substrate = param1["MC_HeroPage"]["MC_PageLeft"];
         this.FUIPageHeroList.ButtonNext.Substrate = param1["MC_HeroPage"]["MC_PageRight"];
         this.FUIPageHeroList.LabelPage = param1["MC_HeroPage"]["TF_Page"];
         this.FUIPageHeroList.PageSize = TAB_NUM;
         this.FUIPageHeroList.OnChangePage = this.HeroListPageOnChange;
      }
      
      protected function HeroTagLocation() : void
      {
         var _loc1_:int = 0;
         this.FHeroNameTab = new TUITab(this);
         _loc1_ = 0;
         while(_loc1_ < TAB_NUM)
         {
            this.FHeroNameTab.SetTabByIndex(this.FMC_HeroTags[_loc1_],_loc1_);
            _loc1_++;
         }
         this.FHeroNameTab.Init();
         this.FHeroNameTab.OnSwitch = this.OnSwitchTab;
         addChild(this.FHeroNameTab);
         this.FCurrentShowEquipmentBag = new TInventories();
      }
      
      protected function UpdateHerosTag() : void
      {
         this.HideAndShowTagByHeroNum(SLogicsCore.Character.Heros.Count + 1);
         this.SetTagName();
      }
      
      protected function ResetHerosTag() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         _loc2_ = int(this.FMC_HeroTags.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FMC_HeroTags[_loc1_];
            _loc3_.visible = false;
            _loc1_++;
         }
         this.FHeroNameTab.SwithTagManual(0);
         this.FCurrentShowTagIndex = -1;
         this.SetupHeroListPage(SLogicsCore.Character.Heros.Count,0);
      }
      
      protected function SetTagName() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:THeros = null;
         var _loc4_:THero = null;
         _loc3_ = SLogicsCore.Character.Heros;
         _loc3_.Sort();
         _loc2_ = _loc3_.Count;
         _loc1_ = 0;
         while(_loc1_ < TAB_NUM)
         {
            if(_loc1_ + this.FPageIndexHeroList * TAB_NUM == _loc3_.Count)
            {
               break;
            }
            _loc4_ = _loc3_.GetHeroByIndex(_loc1_ + this.FPageIndexHeroList * TAB_NUM);
            this.FHeroNameTab.SetTabCaptionByIndex(_loc4_.Name,_loc1_,QUALITYCOLOR_INDEX[_loc4_.Quality]);
            _loc1_++;
         }
         if(_loc1_ < TAB_NUM)
         {
            this.FHeroNameTab.SetTabCaptionByIndex(STRING_COMMON.STRING_Backage,_loc1_,16775109);
         }
      }
      
      protected function HideAndShowTagByHeroNum(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         if(this.FPageIndexHeroList + 1 == this.FUIPageHeroList.TotalPage)
         {
            _loc3_ = param1 % TAB_NUM;
         }
         else
         {
            _loc3_ = uint(TAB_NUM);
         }
         if(_loc3_ == 0 && param1 != 0)
         {
            _loc3_ = uint(TAB_NUM);
         }
         _loc2_ = 0;
         while(_loc2_ < TAB_NUM)
         {
            if(_loc2_ < _loc3_)
            {
               this.FHeroNameTab.SetTabShowByIndex(_loc2_);
            }
            else
            {
               this.FHeroNameTab.SetTabHideByIndex(_loc2_);
            }
            _loc2_++;
         }
      }
      
      protected function SelectEquipmentsIntoBag(param1:int, param2:TInventories) : void
      {
         var _loc3_:THero = null;
         var _loc4_:int = 0;
         var _loc5_:TCollectionInventory = null;
         var _loc6_:TInventory = null;
         var _loc7_:TInventories = null;
         var _loc8_:int = 0;
         var _loc9_:uint = 0;
         var _loc10_:TEquipUpgrade = null;
         _loc9_ = param1 + this.FPageIndexHeroList * TAB_NUM;
         if(_loc9_ < SLogicsCore.Character.Heros.Count)
         {
            _loc3_ = SLogicsCore.Character.Heros.GetHeroByIndex(_loc9_);
            _loc5_ = _loc3_.EquipmentsMounted;
            param2.Clear();
            _loc4_ = 0;
            for(; _loc4_ < _loc5_.Capacity; _loc4_++)
            {
               _loc6_ = _loc5_.GetInventoryByIndex(_loc4_);
               if(_loc6_ != null)
               {
                  if(this.FTabIndex == TAB_INDEX_UPGRADE)
                  {
                     _loc10_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_EquipUpgrade,_loc6_.IDTemplate) as TEquipUpgrade;
                     if(_loc10_ == null)
                     {
                        continue;
                     }
                     if(_loc10_.IsEpic != 2)
                     {
                        continue;
                     }
                  }
                  this.FCurrentShowEquipmentBag.Add(_loc6_);
               }
            }
         }
         else
         {
            _loc7_ = SLogicsCore.Character.Equipments;
            _loc8_ = _loc7_.Count;
            param2.Clear();
            _loc4_ = 0;
            for(; _loc4_ < _loc8_; _loc4_++)
            {
               _loc6_ = _loc7_.GetInventoryByIndex(_loc4_);
               if(this.FTabIndex == TAB_INDEX_UPGRADE)
               {
                  _loc10_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_EquipUpgrade,_loc6_.IDTemplate) as TEquipUpgrade;
                  if(_loc10_ == null)
                  {
                     continue;
                  }
                  if(_loc10_.IsEpic != 2)
                  {
                     continue;
                  }
               }
               param2.Add(_loc6_);
            }
         }
      }
      
      protected function HeroListPageOnChange(param1:Object, param2:int) : void
      {
         this.FPageIndexHeroList = param2;
         this.OnSwitchTab(0);
         this.FHeroNameTab.SwithTagManual(0);
         this.UpdateHerosTag();
         this.SelectEquipmentsIntoBag(0,this.FCurrentShowEquipmentBag);
         this.ConstructScroolBar();
         this.UpdateEquipmentInfor();
      }
      
      protected function SetupHeroListPage(param1:int, param2:int) : void
      {
         this.FUIPageHeroList.TotalQuantity = param1;
         this.FUIPageHeroList.Update();
         this.FUIPageHeroList.PageIndex = param2;
      }
      
      protected function EquipmentUIDispath(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:TUISlot = null;
         this.FMC_List = param1["mc_list"];
         this.FScrollBar = new TScrollBar(this.FMC_List,348,false,0);
         this.FMC_SingleEquipList = new Vector.<TSingleEquip>();
      }
      
      protected function EquipmentLocation() : void
      {
         this.FCurrentShowTagIndex = -1;
      }
      
      protected function ConstructScroolBar() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TSingleEquip = null;
         var _loc4_:TInventory = null;
         var _loc5_:int = 0;
         _loc2_ = int(this.FMC_SingleEquipList.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FMC_SingleEquipList[_loc1_];
            _loc3_.StubReferences.Dereference(this);
            _loc1_++;
         }
         this.FMC_SingleEquipList.length = 0;
         this.FCurrentClickSingleEquip = null;
         this.FScrollBar.Clear();
         _loc5_ = this.FCurrentShowEquipmentBag.Count;
         if(_loc5_ < CONST_SMITHY.MinSingleEquipmentNum)
         {
            _loc2_ = CONST_SMITHY.MinSingleEquipmentNum;
         }
         else
         {
            _loc2_ = _loc5_;
         }
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = SLogicsCore.PoolUISingleEquipment.AcquireUISingleEquipment(this);
            _loc3_.StubReferences.Reference(this);
            _loc3_.OnClick = this.EquipmentClick;
            _loc3_.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
            _loc3_.OnQueryEuqipLevel = this.SlotsOnQueryEuqipLevel;
            _loc3_.OnOut = this.UIComponentsHintOnOut;
            _loc3_.OnOver = this.UIComponentsHintOnOver;
            this.FScrollBar.AddItem(_loc3_);
            this.FMC_SingleEquipList.push(_loc3_);
            _loc1_++;
         }
      }
      
      protected function UpdateEquipmentInfor() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TInventory = null;
         var _loc4_:int = 0;
         var _loc5_:TSingleEquip = null;
         _loc4_ = this.FCurrentShowEquipmentBag.Count;
         _loc1_ = 0;
         while(_loc1_ < _loc4_)
         {
            _loc3_ = this.FCurrentShowEquipmentBag.GetInventoryByIndex(_loc1_);
            _loc5_ = this.FMC_SingleEquipList[_loc1_];
            if(this.FTabIndex == TAB_INDEX_ENCHANT)
            {
               _loc5_.SetEquip(_loc3_,_loc3_.Name,STRING_SMITHY.ENCHANTHEPRIFIX_NAME + (_loc3_ as TEquipment).EnchantLevel,_loc3_.Quality);
            }
            else
            {
               _loc5_.SetEquip(_loc3_,_loc3_.Name,STRING_SMITHY.STRENGTHEPRIFIX_NAME + _loc3_.UpgradingLevel,_loc3_.Quality);
            }
            _loc1_++;
         }
      }
      
      protected function EquipmentClick(param1:Object, param2:Object) : void
      {
         var _loc3_:THeros = null;
         var _loc4_:uint = 0;
         var _loc5_:TEquipment = null;
         var _loc6_:TSingleEquip = null;
         _loc6_ = param1 as TSingleEquip;
         _loc5_ = param2 as TEquipment;
         if(this.FCurrentClickSingleEquip != null)
         {
            if(this.FCurrentClickSingleEquip == _loc6_)
            {
               return;
            }
            this.FCurrentClickSingleEquip.BClick = false;
         }
         this.FCurrentClickSingleEquip = _loc6_;
         _loc3_ = SLogicsCore.Character.Heros;
         _loc4_ = 0;
         if(_loc3_.Count > this.FCurrentShowTagIndex + this.FPageIndexHeroList * TAB_NUM)
         {
            _loc4_ = _loc3_.GetHeroByIndex(this.FCurrentShowTagIndex + this.FPageIndexHeroList * TAB_NUM).Identifier;
         }
         this.SendShowEquipment(_loc5_,_loc4_);
      }
      
      protected function SendShowEquipment(param1:TEquipment, param2:uint) : void
      {
         if(this.FOnEquipmentClick != null)
         {
            this.FOnEquipmentClick(param1,param2);
            TutorialNextStep(801);
         }
      }
      
      protected function OnSwitchTab(param1:int) : void
      {
         if(this.FCurrentShowTagIndex != param1)
         {
            this.SelectEquipmentsIntoBag(param1,this.FCurrentShowEquipmentBag);
            this.ConstructScroolBar();
         }
         this.UpdateEquipmentInfor();
         this.FCurrentShowTagIndex = param1;
      }
      
      protected function UIComponentsHintOnOver(param1:Object, param2:TInventory) : void
      {
         if(this.FOnSlotMouseOver != null)
         {
            this.FOnSlotMouseOver(param1,param2);
         }
      }
      
      protected function UIComponentsHintOnOut(param1:Object, param2:TInventory) : void
      {
         if(this.FOnSlotMouseOut != null)
         {
            this.FOnSlotMouseOut(param1,param2);
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
            _loc6_.LoadSecondary(_loc5_.IDTexture,CONST_MODULES.MODULE_Smithy);
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
      
      public function set OnEquipmentClick(param1:Function) : void
      {
         this.FOnEquipmentClick = param1;
      }
      
      public function set OnSlotMouseOver(param1:Function) : void
      {
         this.FOnSlotMouseOver = param1;
      }
      
      public function set OnSlotMouseOut(param1:Function) : void
      {
         this.FOnSlotMouseOut = param1;
      }
      
      public function Update() : void
      {
         if(this.FCurrentShowTagIndex == -1)
         {
            this.FPageIndexHeroList = 0;
            this.SetupHeroListPage(SLogicsCore.Character.Heros.Count + 1,0);
            this.UpdateHerosTag();
            this.OnSwitchTab(0);
         }
         else
         {
            this.OnSwitchTab(this.FCurrentShowTagIndex);
            if(this.FCurrentClickSingleEquip != null)
            {
               this.FCurrentClickSingleEquip.BClick = true;
            }
         }
      }
      
      override public function set Visible(param1:Boolean) : void
      {
         super.Visible = param1;
         if(this.FFatherUIInner != null)
         {
            this.FFatherUIInner.visible = param1;
         }
      }
      
      public function SetTabIndex(param1:uint) : void
      {
         this.FCurrentClickSingleEquip = null;
         this.FTabIndex = param1;
         this.SelectEquipmentsIntoBag(this.FCurrentShowTagIndex,this.FCurrentShowEquipmentBag);
         this.ConstructScroolBar();
         this.UpdateEquipmentInfor();
      }
      
      public function Reset() : void
      {
         this.ResetHerosTag();
      }
      
      public function BackReset() : void
      {
         this.FCurrentClickSingleEquip = null;
         this.SelectEquipmentsIntoBag(this.FCurrentShowTagIndex,this.FCurrentShowEquipmentBag);
         this.ConstructScroolBar();
         this.UpdateEquipmentInfor();
      }
   }
}

