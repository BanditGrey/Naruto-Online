package Processors.Game.Lobby.Jade
{
   import Components.ComboBox.*;
   import Components.Pages.*;
   import Components.ScrollBar.*;
   import Components.Slots.*;
   import Components.Standard.*;
   import Foundation.Queries.*;
   import Foundation.Queries.Textures.*;
   import Foundation.Resources.*;
   import Foundation.Resources.Repositories.*;
   import Foundation.Resources.Textures.*;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.*;
   import Logics.Characters.*;
   import Logics.DatebaseVO.VO.*;
   import Logics.Inventories.*;
   import Processors.Game.*;
   import Processors.Game.Lobby.Common.*;
   import Processors.Game.Lobby.Talisman.TSingleEquip;
   import Resources.Constants.*;
   import Resources.Strings.*;
   import flash.display.*;
   import flash.events.*;
   import flash.text.*;
   
   public class TJadeMosaic extends TProcessorLobbyWindow
   {
      
      protected static const STATE_READY:int = 0;
      
      protected static const STATE_MOSAIC:int = 1;
      
      protected static const STATE_UNQUITE:int = 2;
      
      protected static const QUALITYCOLOR_INDEX:Vector.<uint> = CONST_COMMON.QUALITYCOLOR_INDEX;
      
      protected var FUIDispatchRoutines:Vector.<Function>;
      
      protected var FUILocationRoutines:Vector.<Function>;
      
      protected var FMC_HeroTags:Vector.<MovieClip>;
      
      protected var FTF_HeroName:Vector.<TextField>;
      
      protected var FHeroNameTab:TUITab;
      
      protected var FTagIndexBindingEquipment:int;
      
      protected var FCurrentShowTagIndex:int;
      
      protected var FCurrentShowEquipmentBag:TInventories;
      
      protected var FUIPageHeroList:TUIPage;
      
      protected var FPageIndexHeroList:int;
      
      protected var FCurrentShowEquipment:TEquipment;
      
      protected var FScrollBar:TScrollBar;
      
      protected var FMC_List:MovieClip;
      
      protected var FList_SingleEquipment:Vector.<TSingleEquip>;
      
      protected var FCurrentClickSingleEquip:TSingleEquip;
      
      protected var FTF_CurHeroName:TextField;
      
      protected var FTF_Recommend:TextField;
      
      protected var FMC_OneKeyXieZaiYu:MovieClip;
      
      protected var FMC_EquipmentMountPoint:MovieClip;
      
      protected var FMC_EquipmentJadesLock:Vector.<MovieClip>;
      
      protected var FSingleEquipmentSlots:TUISlot;
      
      protected var FEquipmentJadeSlots:Vector.<TUISlot>;
      
      protected var FBackpackSlots:Vector.<TUISlot>;
      
      protected var FUIPage:TUIPage;
      
      protected var FPageIndex:int;
      
      protected var FJadeLevelComboBox:TComboBox;
      
      protected var FJadeLevelComboBoxSelectIndex:int;
      
      protected var FJadeTypeComboBox:TComboBox;
      
      protected var FJadeTypeComboBoxSelectIndex:int;
      
      protected var FSelectJadeUsetoShow:TInventories;
      
      protected var FCurrentMosaicJadeHeroID:uint;
      
      protected var FInitialization:Boolean;
      
      protected var FCurrentState:int;
      
      protected var FFatherUI:MovieClip;
      
      protected var FOnInventoryOver:Function;
      
      protected var FOnInventoryOut:Function;
      
      protected var FOnMountJade:Function;
      
      protected var FOnUnmountJade:Function;
      
      protected var FOneKeyOnUnmountJade:Function;
      
      protected var FFlyText:Function;
      
      protected var FResultCode:int;
      
      protected var FUpdateHeroPower:Function;
      
      public function TJadeMosaic(param1:TUIComponent)
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
         this.FUIDispatchRoutines.push(this.JadeRecommendDispath);
         this.FUIDispatchRoutines.push(this.EquipmentJadeUIDispath);
         this.FUIDispatchRoutines.push(this.BackpackJadeUIDispath);
      }
      
      public function Perform_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Function = null;
         this.addChild(param1);
         this.FFatherUI = param1;
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
         this.FUILocationRoutines.push(this.JadeRecommendLocation);
         this.FUILocationRoutines.push(this.EquipmentJadeLocation);
         this.FUILocationRoutines.push(this.BackpackJadeLocation);
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
         this.FCurrentState = STATE_READY;
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TSingleEquip = null;
         super.LogicsPerform();
         if(this.FInitialization)
         {
            TJadeCommon.ProcessorUpdateSlotsRenderingState(this.FBackpackSlots);
            TJadeCommon.ProcessorUpdateSlotsRenderingState(this.FEquipmentJadeSlots);
            _loc2_ = int(this.FList_SingleEquipment.length);
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               _loc3_ = this.FList_SingleEquipment[_loc1_];
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
         this.FMC_HeroTags = new Vector.<MovieClip>();
         this.FTF_HeroName = new Vector.<TextField>();
         _loc2_ = 0;
         while(_loc2_ < CONST_JADE.MAX_HeroCount)
         {
            _loc3_ = param1["mc_hero_" + _loc2_];
            _loc4_ = _loc3_["tf_heroName"];
            this.FMC_HeroTags.push(_loc3_);
            this.FTF_HeroName.push(_loc4_);
            _loc2_++;
         }
         this.FUIPageHeroList = new TUIPage(this);
         this.FUIPageHeroList.ButtonPrevious.Substrate = param1["MC_HeroPage"]["MC_PageLeft"];
         this.FUIPageHeroList.ButtonNext.Substrate = param1["MC_HeroPage"]["MC_PageRight"];
         this.FUIPageHeroList.LabelPage = param1["MC_HeroPage"]["TF_Page"];
         this.FUIPageHeroList.PageSize = CONST_JADE.MAX_HeroCount;
         this.FUIPageHeroList.OnChangePage = this.HeroListPageOnChange;
         this.FUIPageHeroList.Init();
      }
      
      private function HeroListPageOnChange(param1:Object, param2:int) : void
      {
         this.FPageIndexHeroList = param2;
         this.OnSwitchTab(0);
         this.FHeroNameTab.SwithTagManual(0);
         this.UpdateHerosTag();
         this.SelectEquipmentsByTabIndex(0,this.FCurrentShowEquipmentBag);
         this.ConstructScroolBar();
         this.UpdateEquipment();
         this.UpdateJadeRecommend();
         this.ResetEquipmentJade();
      }
      
      protected function HeroTagLocation() : void
      {
         var _loc1_:int = 0;
         this.FHeroNameTab = new TUITab(this);
         _loc1_ = 0;
         while(_loc1_ < CONST_JADE.MAX_HeroCount)
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
         this.HideAndShowTagByNum(SLogicsCore.Character.Heros.Count + 1);
         this.SetTagName();
      }
      
      protected function SetTagName() : void
      {
         var _loc1_:int = 0;
         var _loc2_:THeros = null;
         var _loc3_:THero = null;
         _loc2_ = SLogicsCore.Character.Heros;
         _loc1_ = 0;
         while(_loc1_ < CONST_JADE.MAX_HeroCount)
         {
            if(_loc1_ + this.FPageIndexHeroList * CONST_JADE.MAX_HeroCount == _loc2_.Count)
            {
               break;
            }
            _loc3_ = _loc2_.GetHeroByIndex(_loc1_ + this.FPageIndexHeroList * CONST_JADE.MAX_HeroCount);
            this.FHeroNameTab.SetTabCaptionByIndex(_loc3_.Name,_loc1_,QUALITYCOLOR_INDEX[_loc3_.Quality]);
            _loc1_++;
         }
         if(_loc1_ < CONST_JADE.MAX_HeroCount)
         {
            this.FHeroNameTab.SetTabCaptionByIndex(STRING_COMMON.STRING_Backage,_loc1_,16775109);
         }
      }
      
      protected function HideAndShowTagByNum(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         if(this.FPageIndexHeroList + 1 == this.FUIPageHeroList.TotalPage)
         {
            _loc3_ = param1 % CONST_JADE.MAX_HeroCount;
         }
         else
         {
            _loc3_ = uint(CONST_JADE.MAX_HeroCount);
         }
         if(_loc3_ == 0 && param1 != 0)
         {
            _loc3_ = uint(CONST_JADE.MAX_HeroCount);
         }
         _loc2_ = 0;
         while(_loc2_ < CONST_JADE.MAX_HeroCount)
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
      
      protected function ResetHeroTag() : void
      {
         this.FHeroNameTab.SwithTagManual(0);
         this.FCurrentShowTagIndex = -1;
      }
      
      protected function EquipmentUIDispath(param1:MovieClip) : void
      {
         this.FList_SingleEquipment = new Vector.<TSingleEquip>();
         this.FMC_List = param1[CONST_TALISMAN.RESOURCE_Link_Mc_List];
         this.FScrollBar = new TScrollBar(this.FMC_List,348,false,0);
      }
      
      protected function EquipmentLocation(param1:int) : void
      {
      }
      
      protected function ConstructScroolBar() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TSingleEquip = null;
         var _loc4_:TInventory = null;
         var _loc5_:int = 0;
         _loc2_ = int(this.FList_SingleEquipment.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FList_SingleEquipment[_loc1_];
            _loc3_.StubReferences.Dereference(this);
            _loc1_++;
         }
         this.FList_SingleEquipment.length = 0;
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
            _loc3_.OnQuerySequenceContext = TJadeCommon.SlotsOnQuerySequenceContext;
            _loc3_.OnQueryEuqipLevel = this.SlotsOnQueryEuqipLevel;
            _loc3_.OnOut = this.SlotsOnOut;
            _loc3_.OnOver = this.SlotsOnMove;
            this.FScrollBar.AddItem(_loc3_);
            this.FList_SingleEquipment.push(_loc3_);
            _loc1_++;
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
      
      protected function UpdateEquipment() : void
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
            _loc5_ = this.FList_SingleEquipment[_loc1_];
            _loc5_.SetEquip(_loc3_,_loc3_.Name,STRING_JADE.STRING_Strengthen + _loc3_.UpgradingLevel,_loc3_.Quality);
            _loc1_++;
         }
      }
      
      protected function SelectEquipmentsByTabIndex(param1:int, param2:TInventories) : void
      {
         var _loc3_:THero = null;
         var _loc4_:int = 0;
         var _loc5_:TCollectionInventory = null;
         var _loc6_:TInventory = null;
         var _loc7_:int = 0;
         var _loc8_:uint = 0;
         _loc8_ = param1 + this.FPageIndexHeroList * CONST_JADE.MAX_HeroCount;
         if(_loc8_ < SLogicsCore.Character.Heros.Count)
         {
            _loc3_ = SLogicsCore.Character.Heros.GetHeroByIndex(_loc8_);
            _loc5_ = _loc3_.EquipmentsMounted;
            param2.Clear();
            _loc4_ = 0;
            while(_loc4_ < _loc5_.Capacity)
            {
               _loc6_ = _loc5_.GetInventoryByIndex(_loc4_);
               if(_loc6_ != null)
               {
                  param2.Add(_loc6_);
               }
               _loc4_++;
            }
         }
         else
         {
            _loc7_ = int(SLogicsCore.Character.Equipments.Count);
            param2.Clear();
            _loc4_ = 0;
            while(_loc4_ < _loc7_)
            {
               param2.Add(SLogicsCore.Character.Equipments.GetInventoryByIndex(_loc4_));
               _loc4_++;
            }
         }
      }
      
      protected function EquipmentClick(param1:Object, param2:Object) : void
      {
         var _loc3_:TSingleEquip = null;
         _loc3_ = param1 as TSingleEquip;
         if(this.FCurrentClickSingleEquip != null)
         {
            this.FCurrentClickSingleEquip.BClick = false;
         }
         this.FCurrentClickSingleEquip = _loc3_;
         this.FCurrentShowEquipment = param2 as TEquipment;
         this.UpdateEquipmentJadeSlot();
      }
      
      protected function ResetEquipments() : void
      {
         this.FCurrentShowEquipment = null;
         this.FCurrentShowEquipmentBag.Clear();
         this.FCurrentClickSingleEquip = null;
      }
      
      protected function ResetCurrentEquipments() : void
      {
      }
      
      protected function GetEquipmentColor(param1:TInventory) : uint
      {
         return CONST_COMMON.QUALITYCOLOR_INDEX[param1.Quality];
      }
      
      protected function JadeRecommendDispath(param1:MovieClip) : void
      {
         this.FTF_CurHeroName = param1["tf_curHeroName"];
         this.FTF_Recommend = param1["tf_recommend"];
         this.FMC_OneKeyXieZaiYu = param1["MC_OneKeyXieZaiYu"];
      }
      
      protected function JadeRecommendLocation() : void
      {
      }
      
      protected function UpdateJadeRecommend() : void
      {
         var _loc1_:THero = null;
         var _loc2_:TRecommendStone = null;
         var _loc3_:TStarPointDesc = null;
         var _loc4_:int = 0;
         var _loc5_:Vector.<int> = null;
         var _loc6_:int = 0;
         var _loc7_:String = null;
         if(this.FCurrentShowTagIndex + this.FPageIndexHeroList * CONST_JADE.MAX_HeroCount >= SLogicsCore.Character.Heros.Count)
         {
            this.ResetJadeRecommend();
            return;
         }
         _loc1_ = SLogicsCore.Character.Heros.GetHeroByIndex(this.FCurrentShowTagIndex + this.FPageIndexHeroList * CONST_JADE.MAX_HeroCount);
         this.FTF_CurHeroName.text = _loc1_.Name;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_RecommendStone,_loc1_.Identifier) as TRecommendStone;
         if(_loc2_ == null)
         {
            _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_RecommendStone,60000000 + _loc1_.StandPositionWithProfession) as TRecommendStone;
         }
         _loc5_ = _loc2_.StonesType;
         _loc7_ = "";
         _loc4_ = 0;
         while(_loc4_ < _loc5_.length)
         {
            _loc6_ = _loc5_[_loc4_];
            _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_StarPointDesc,17500000 + _loc6_) as TStarPointDesc;
            _loc7_ += _loc3_.Desc + " ";
            _loc4_++;
         }
         this.FTF_Recommend.text = _loc7_;
      }
      
      protected function ResetJadeRecommend() : void
      {
         this.FTF_Recommend.text = "";
         this.FTF_CurHeroName.text = "";
      }
      
      protected function EquipmentJadeUIDispath(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:TUISlot = null;
         _loc3_ = param1["mc_curEquipment"];
         _loc3_["mc_clock"].visible = false;
         _loc3_ = param1["mc_curEquipment"];
         this.FSingleEquipmentSlots = new TUISlot(this);
         this.FSingleEquipmentSlots.Resource = _loc3_["mc_slot"];
         _loc3_["mc_slot"]["TF_Subscript"].visible = false;
         this.FMC_EquipmentJadesLock = new Vector.<MovieClip>();
         this.FEquipmentJadeSlots = new Vector.<TUISlot>();
         _loc2_ = 0;
         while(_loc2_ < CONST_JADE.MAX_MosaicJadeCount)
         {
            _loc3_ = param1["mc_mosaicJade_" + _loc2_];
            this.FMC_EquipmentJadesLock.push(_loc3_["mc_clock"]);
            _loc4_ = new TUISlot(this);
            _loc4_.Resource = _loc3_["mc_slot"];
            _loc3_["mc_slot"]["TF_Subscript"].visible = false;
            this.FEquipmentJadeSlots.push(_loc4_);
            _loc2_++;
         }
      }
      
      protected function EquipmentJadeLocation() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         var _loc3_:TUISlot = null;
         this.FEquipmentJadeSlots.push(this.FSingleEquipmentSlots);
         _loc1_ = 0;
         while(_loc1_ < this.FEquipmentJadeSlots.length)
         {
            _loc3_ = this.FEquipmentJadeSlots[_loc1_];
            TJadeCommon.InitSlot(_loc3_,CONST_MODULES.MODULE_Jade);
            _loc3_.Tag = _loc1_;
            _loc3_.OnClick = this.EquipmentJadeSlotClick;
            _loc3_.Init();
            _loc3_.OnOverlay = this.SlotsOnMove;
            _loc3_.OnOut = this.SlotsOnOut;
            _loc1_++;
         }
         this.FMC_OneKeyXieZaiYu.addEventListener(MouseEvent.CLICK,this.OneKeyXieZaiYu);
         this.FSingleEquipmentSlots.OnClick = this.OnSlotClick;
      }
      
      protected function OneKeyXieZaiYu(param1:MouseEvent) : void
      {
         var _loc2_:THero = null;
         if(!this.FMC_OneKeyXieZaiYu.buttonMode)
         {
            return;
         }
         if(this.FCurrentShowTagIndex + this.FPageIndexHeroList * CONST_JADE.MAX_HeroCount < SLogicsCore.Character.Heros.Count)
         {
            _loc2_ = SLogicsCore.Character.Heros.GetHeroByIndex(this.FCurrentShowTagIndex + this.FPageIndexHeroList * CONST_JADE.MAX_HeroCount);
            this.FCurrentMosaicJadeHeroID = _loc2_.Identifier;
         }
         else
         {
            this.FCurrentMosaicJadeHeroID = 0;
         }
         if(this.FOneKeyOnUnmountJade != null)
         {
            this.FOneKeyOnUnmountJade(this.FCurrentMosaicJadeHeroID,this.FCurrentShowEquipment.Identifier0,this.FCurrentShowEquipment.Identifier1);
            this.FCurrentState = STATE_UNQUITE;
         }
      }
      
      protected function EquipmentJadeSlotClick(param1:Object, param2:Object) : void
      {
         var _loc3_:TAppliance = null;
         var _loc4_:TAppliance = null;
         var _loc5_:THero = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         _loc3_ = param2 as TAppliance;
         if(this.FCurrentShowTagIndex + this.FPageIndexHeroList * CONST_JADE.MAX_HeroCount < SLogicsCore.Character.Heros.Count)
         {
            _loc5_ = SLogicsCore.Character.Heros.GetHeroByIndex(this.FCurrentShowTagIndex + this.FPageIndexHeroList * CONST_JADE.MAX_HeroCount);
            this.FCurrentMosaicJadeHeroID = _loc5_.Identifier;
         }
         else
         {
            this.FCurrentMosaicJadeHeroID = 0;
         }
         if(this.FOnUnmountJade != null)
         {
            _loc7_ = this.FCurrentShowEquipment.GiftedStoneItems.Count;
            _loc6_ = 0;
            while(_loc6_ < _loc7_)
            {
               _loc4_ = this.FCurrentShowEquipment.GiftedStoneItems.GetGiftedStoneByIndex(_loc6_);
               if(_loc4_ == _loc3_)
               {
                  break;
               }
               _loc6_++;
            }
            this.FOnUnmountJade(this.FCurrentMosaicJadeHeroID,this.FCurrentShowEquipment.Identifier0,this.FCurrentShowEquipment.Identifier1,_loc6_);
            this.FCurrentState = STATE_UNQUITE;
         }
      }
      
      protected function GetEquipmentByIndex(param1:int, param2:int) : TEquipment
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:THero = null;
         if(param2 == -1)
         {
            return null;
         }
         return this.FCurrentShowEquipmentBag.GetInventoryByIndex(param2) as TEquipment;
      }
      
      protected function UpdateEquipmentJadeSlot() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TGiftedStoneItems = null;
         this.SetSlotByEquipment(this.FCurrentShowEquipment);
         this.FSingleEquipmentSlots.Context = this.FCurrentShowEquipment;
         if(this.FCurrentShowEquipment != null)
         {
            _loc3_ = this.FCurrentShowEquipment.GiftedStoneItems;
            _loc2_ = 0;
            while(_loc2_ < _loc3_.Count)
            {
               this.FEquipmentJadeSlots[_loc2_].Context = _loc3_.GetGiftedStoneByIndex(_loc2_);
               _loc2_++;
            }
         }
         if(this.FCurrentShowEquipment == null)
         {
            TGameUtil.setButtonMode(this.FMC_OneKeyXieZaiYu,false);
         }
         else if(this.FCurrentShowEquipment.GiftedStoneItems.Count <= 0)
         {
            TGameUtil.setButtonMode(this.FMC_OneKeyXieZaiYu,false);
         }
         else
         {
            TGameUtil.setButtonMode(this.FMC_OneKeyXieZaiYu,true);
         }
      }
      
      protected function SetSlotByEquipment(param1:TEquipment) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         this.FSingleEquipmentSlots.Context = param1;
         if(param1 != null)
         {
            _loc3_ = param1.HoleCount + param1.ExpandHoleCount;
         }
         else
         {
            _loc3_ = 0;
         }
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            this.FMC_EquipmentJadesLock[_loc2_].visible = false;
            this.FEquipmentJadeSlots[_loc2_].Context = null;
            _loc2_++;
         }
         _loc3_ = CONST_JADE.MAX_MosaicJadeCount;
         while(_loc2_ < _loc3_)
         {
            this.FMC_EquipmentJadesLock[_loc2_].visible = true;
            this.FEquipmentJadeSlots[_loc2_].Context = null;
            _loc2_++;
         }
      }
      
      protected function ResetEquipmentJade() : void
      {
         this.SetSlotByEquipment(null);
      }
      
      protected function BackpackJadeUIDispath(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:DisplayObject = null;
         var _loc5_:int = 0;
         var _loc6_:Vector.<DisplayObject> = null;
         var _loc7_:Vector.<DisplayObject> = null;
         var _loc8_:Array = null;
         var _loc9_:TUISlot = null;
         this.FSelectJadeUsetoShow = new TInventories();
         this.FBackpackSlots = new Vector.<TUISlot>();
         _loc2_ = 0;
         while(_loc2_ < CONST_JADE.MAX_JadeSlotCount)
         {
            _loc3_ = param1["mc_stone_" + _loc2_];
            _loc9_ = new TUISlot(this);
            _loc9_.Resource = _loc3_;
            this.FBackpackSlots.push(_loc9_);
            TJadeCommon.InitSlot(_loc9_,CONST_MODULES.MODULE_Jade);
            _loc9_.Tag = _loc2_;
            _loc9_.OnClick = this.BackpackJadeSlotsOnClick;
            _loc9_.Init();
            _loc9_.OnOverlay = this.SlotsOnMove;
            _loc9_.OnOut = this.SlotsOnOut;
            _loc2_++;
         }
         this.FUIPage = new TUIPage(this);
         this.FUIPage.ButtonPrevious.Substrate = param1["btn_left"];
         this.FUIPage.ButtonNext.Substrate = param1["btn_right"];
         this.FUIPage.LabelPage = param1["TF_Page"];
         _loc6_ = new Vector.<DisplayObject>();
         _loc8_ = STRING_JADE.STRINGS_JadeLevel;
         _loc5_ = int(_loc8_.length);
         _loc2_ = 0;
         while(_loc2_ < _loc5_)
         {
            _loc4_ = this.MakeComboItem(_loc8_[_loc2_]);
            _loc6_.push(_loc4_);
            _loc2_++;
         }
         this.FJadeLevelComboBox = new TComboBox(this,param1["mc_list_level"],_loc6_,CONST_JADE.MAX_ComboboxHeight,this.OnLevelSelect);
         _loc7_ = new Vector.<DisplayObject>();
         _loc8_ = STRING_JADE.STRINGS_JadeType;
         _loc5_ = int(_loc8_.length);
         _loc2_ = 0;
         while(_loc2_ < _loc5_)
         {
            _loc4_ = this.MakeComboItem(_loc8_[_loc2_]);
            _loc7_.push(_loc4_);
            _loc2_++;
         }
         this.FJadeTypeComboBox = new TComboBox(this,param1.mc_list_type,_loc7_,CONST_JADE.MAX_ComboboxHeight,this.OnTypeSelect);
      }
      
      protected function BackpackJadeLocation() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TUISlot = null;
         this.FUIPage.PageSize = CONST_JADE.MAX_JadeSlotCount;
         this.FUIPage.OnChangePage = this.PageOnChange;
      }
      
      protected function SetupJadePage(param1:int, param2:int) : void
      {
         this.FUIPage.TotalQuantity = param1;
         this.FUIPage.Update();
         this.FUIPage.PageIndex = param2;
      }
      
      protected function SetupHeroListPage(param1:int, param2:int) : void
      {
         this.FUIPageHeroList.TotalQuantity = param1;
         this.FUIPageHeroList.Update();
         this.FUIPageHeroList.PageIndex = param2;
      }
      
      protected function UpdateBackpackJade() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:TUISlot = null;
         var _loc6_:TAppliance = null;
         this.SelectCanShowJade(this.FJadeLevelComboBoxSelectIndex,this.FJadeTypeComboBoxSelectIndex,this.FSelectJadeUsetoShow);
         this.SetupJadePage(this.FSelectJadeUsetoShow.Count,this.FPageIndex);
         _loc4_ = int(this.FBackpackSlots.length);
         _loc2_ = this.FSelectJadeUsetoShow.Count;
         _loc3_ = this.FPageIndex * CONST_JADE.MAX_JadeSlotCount;
         _loc1_ = 0;
         while(_loc1_ < _loc4_)
         {
            _loc5_ = this.FBackpackSlots[_loc1_];
            if(_loc1_ + _loc3_ < _loc2_)
            {
               _loc6_ = this.FSelectJadeUsetoShow.GetInventoryByIndex(_loc1_ + _loc3_) as TAppliance;
               _loc5_.Context = _loc6_;
            }
            else
            {
               _loc5_.Context = null;
            }
            _loc1_++;
         }
      }
      
      protected function SelectCanShowJade(param1:int, param2:int, param3:TInventories) : void
      {
         var _loc4_:TInventories = null;
         _loc4_ = SLogicsCore.Character.GetBackpackByIndex(CONST_COMMON.INVENTORIESINDEX_Gems);
         this.FSelectJadeUsetoShow.Clear();
         TJadeCommon.GetSpecialJade(_loc4_,param3,CONST_JADE.ComboBoxJadeLevel[param1],CONST_JADE.ComboBoxJadeSecondType[param2]);
      }
      
      protected function PageOnChange(param1:Object, param2:int) : void
      {
         this.FPageIndex = param2;
         this.UpdateBackpackJade();
      }
      
      protected function VerificationMosaic(param1:TAppliance) : Boolean
      {
         var _loc2_:Boolean = false;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:TAppliance = null;
         if(this.FCurrentShowEquipment == null)
         {
            return false;
         }
         _loc4_ = this.FCurrentShowEquipment.GiftedStoneItems.Count;
         if(_loc4_ >= this.FCurrentShowEquipment.HoleCount + this.FCurrentShowEquipment.ExpandHoleCount)
         {
            this.FFlyText(STRING_JADE.TEXTID_STR104);
            return false;
         }
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc5_ = this.FCurrentShowEquipment.GiftedStoneItems.GetGiftedStoneByIndex(_loc3_);
            if(param1.CategorySecond == _loc5_.CategorySecond)
            {
               this.FFlyText(STRING_JADE.TEXTID_STR103);
               return false;
            }
            _loc3_++;
         }
         return true;
      }
      
      protected function BackpackJadeSlotsOnClick(param1:Object, param2:Object) : void
      {
         var _loc3_:TAppliance = null;
         var _loc4_:TEquipment = null;
         var _loc5_:THero = null;
         var _loc6_:Boolean = false;
         _loc3_ = param2 as TAppliance;
         _loc6_ = this.VerificationMosaic(_loc3_);
         if(!_loc6_)
         {
            return;
         }
         if(this.FCurrentShowTagIndex + this.FPageIndexHeroList * CONST_JADE.MAX_HeroCount < SLogicsCore.Character.Heros.Count)
         {
            _loc5_ = SLogicsCore.Character.Heros.GetHeroByIndex(this.FCurrentShowTagIndex + this.FPageIndexHeroList * CONST_JADE.MAX_HeroCount);
            this.FCurrentMosaicJadeHeroID = _loc5_.Identifier;
         }
         else
         {
            this.FCurrentMosaicJadeHeroID = 0;
         }
         if(this.FOnMountJade != null)
         {
            this.FOnMountJade(this.FCurrentMosaicJadeHeroID,_loc3_.Identifier0,_loc3_.Identifier1,this.FCurrentShowEquipment.Identifier0,this.FCurrentShowEquipment.Identifier1);
            this.FCurrentState = STATE_MOSAIC;
         }
      }
      
      protected function MakeComboItem(param1:String) : DisplayObject
      {
         var _loc2_:MovieClip = null;
         _loc2_ = TUtilityReflection.CreateDisplayObjectInstance(CONST_JADE.RESOURCE_ClassName_ComboBoxItem) as MovieClip;
         _loc2_.tf_into.text = param1;
         return _loc2_;
      }
      
      protected function ResetBackpackJade() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TUISlot = null;
         _loc2_ = int(this.FBackpackSlots.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FBackpackSlots[_loc1_];
            _loc3_.Context = null;
            _loc1_++;
         }
         this.FPageIndex = 0;
         this.SetupJadePage(0,0);
         this.FJadeLevelComboBoxSelectIndex = 0;
         this.FJadeTypeComboBoxSelectIndex = 0;
         this.FSelectJadeUsetoShow.Clear();
      }
      
      protected function ResetScrollBar() : void
      {
         this.FJadeLevelComboBox.SetChildSelectByIndex(0);
         this.FJadeTypeComboBox.SetChildSelectByIndex(0);
         this.FJadeLevelComboBox.SetInfo(STRING_JADE.STRINGS_JadeLevel[0]);
         this.FJadeTypeComboBox.SetInfo(STRING_JADE.STRINGS_JadeType[0]);
      }
      
      protected function OnSwitchTab(param1:int) : void
      {
         if(this.FCurrentShowTagIndex != param1)
         {
            this.FCurrentShowTagIndex = param1;
            this.SelectEquipmentsByTabIndex(param1,this.FCurrentShowEquipmentBag);
            this.ConstructScroolBar();
            this.FCurrentShowEquipment = null;
            this.UpdateJadeRecommend();
            this.UpdateEquipmentJadeSlot();
         }
         this.UpdateEquipment();
      }
      
      protected function OnLevelSelect(param1:Object, param2:int) : void
      {
         this.FJadeLevelComboBoxSelectIndex = param2;
         this.UpdateBackpackJade();
      }
      
      protected function OnTypeSelect(param1:Object, param2:int) : void
      {
         this.FJadeTypeComboBoxSelectIndex = param2;
         this.UpdateBackpackJade();
      }
      
      protected function OnSlotClick(param1:Object = null, param2:Object = null) : void
      {
         this.ResetEquipmentJade();
         this.SlotsOnOut(param1,param2 as TInventory);
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
      
      public function set OnInventoryOver(param1:Function) : void
      {
         this.FOnInventoryOver = param1;
      }
      
      public function set OnInventoryOut(param1:Function) : void
      {
         this.FOnInventoryOut = param1;
      }
      
      public function set OnMountJade(param1:Function) : void
      {
         this.FOnMountJade = param1;
      }
      
      public function set OnUnmountJade(param1:Function) : void
      {
         this.FOnUnmountJade = param1;
      }
      
      public function set OneKeyOnUnmountJade(param1:Function) : void
      {
         this.FOneKeyOnUnmountJade = param1;
      }
      
      public function set FlyText(param1:Function) : void
      {
         this.FFlyText = param1;
      }
      
      public function set ResultCode(param1:int) : void
      {
         this.FResultCode = param1;
      }
      
      public function set UpdateHeroPower(param1:Function) : void
      {
         this.FUpdateHeroPower = param1;
      }
      
      public function Update() : void
      {
         switch(this.FCurrentState)
         {
            case STATE_READY:
               break;
            case STATE_MOSAIC:
               this.FCurrentState = STATE_READY;
               if(this.FResultCode == 0)
               {
                  this.FFlyText(STRING_JADE.TEXTID_STR101);
               }
               else
               {
                  this.FFlyText(STRING_JADE.TEXTID_STR107);
               }
               if(this.FUpdateHeroPower != null && this.FCurrentMosaicJadeHeroID != 0)
               {
                  this.FUpdateHeroPower(this,this.FCurrentMosaicJadeHeroID);
               }
               break;
            case STATE_UNQUITE:
               this.FCurrentState = STATE_READY;
               if(this.FResultCode == 0)
               {
                  this.FFlyText(STRING_JADE.TEXTID_STR102);
               }
               else
               {
                  this.FFlyText(STRING_JADE.TEXTID_STR108);
               }
               if(this.FUpdateHeroPower != null && this.FCurrentMosaicJadeHeroID != 0)
               {
                  this.FUpdateHeroPower(this,this.FCurrentMosaicJadeHeroID);
               }
         }
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
         this.UpdateEquipmentJadeSlot();
         this.UpdateJadeRecommend();
         this.UpdateBackpackJade();
      }
      
      public function Reset() : void
      {
         this.FJadeLevelComboBoxSelectIndex = 0;
         this.FJadeTypeComboBoxSelectIndex = 0;
         this.ResetHeroTag();
         this.ResetEquipments();
         this.ResetEquipmentJade();
         this.ResetJadeRecommend();
         this.ResetBackpackJade();
         this.ResetScrollBar();
      }
   }
}

