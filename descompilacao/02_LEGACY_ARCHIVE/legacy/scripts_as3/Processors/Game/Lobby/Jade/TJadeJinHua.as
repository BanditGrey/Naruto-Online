package Processors.Game.Lobby.Jade
{
   import Components.ComboBox.TComboBox;
   import Components.Pages.TUIPage;
   import Components.ScrollBar.TScrollBar;
   import Components.Slots.TUISlot;
   import Components.Standard.TUITab;
   import Foundation.Queries.TQueryString;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.Characters.TCharacter;
   import Logics.Characters.THero;
   import Logics.Characters.THeros;
   import Logics.DatebaseVO.VO.TArticle;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.DatebaseVO.VO.TMasterStoneConfig;
   import Logics.Inventories.TAppliance;
   import Logics.Inventories.TCollectionInventory;
   import Logics.Inventories.TEquipment;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_JADE;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_TALISMAN;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_JADE;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TJadeJinHua extends TProcessorLobbyWindow
   {
      
      public static const Ten:int = 10;
      
      protected var FFatherUI:MovieClip;
      
      protected var FMC_JinHuaBtn:MovieClip;
      
      protected var FUITab:TUITab;
      
      protected var FCurrentShowEquipmentBag:TInventories;
      
      protected var FUIPageHeroList:TUIPage;
      
      protected var FRoleIndex:int;
      
      protected var FPageIndexHeroList:int;
      
      protected var FJadeLevelComboBox:TComboBox;
      
      protected var FJadeLevelComboBoxSelectIndex:int;
      
      protected var FMC_LeftSlot:TUISlot;
      
      protected var FMC_RightSlot:TUISlot;
      
      protected var FList_SingleEquipment:Vector.<TSingelJageList>;
      
      protected var FList_SingleEquipmentFeiQi:Vector.<TSingelJageList>;
      
      protected var CurInventory:TInventory;
      
      protected var OverInventory:TInventory;
      
      protected var CurSingleEquip:TSingelJageList;
      
      protected var FScrollBar:TScrollBar;
      
      protected var FCharacter:TCharacter;
      
      protected var FCurHeroId:uint;
      
      protected var FTF_CurSlor_Name:TextField;
      
      protected var FTF_CurSlor_Arrt:TextField;
      
      protected var FTF_NextSlor_Name:TextField;
      
      protected var FTF_NextSlor_Arrt:TextField;
      
      protected var FTF_Name:TextField;
      
      protected var FDec1:Vector.<TextField>;
      
      protected var FDec2:Vector.<TextField>;
      
      protected var FDec3:Vector.<MovieClip>;
      
      protected var FTF_JinHuaCost:TextField;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var TempInventories:TInventories;
      
      protected var IDTemplates:Vector.<uint>;
      
      protected var FNameConfig:Vector.<Object>;
      
      protected var FIsInilization:Boolean;
      
      protected var FOnInventoryOver:Function;
      
      protected var FOnInventoryOut:Function;
      
      protected var FJinHuaBackFunction:Function;
      
      protected var FFlyText:Function;
      
      protected var FUpdateHeroPower:Function;
      
      public function TJadeJinHua(param1:TUIComponent)
      {
         super(param1);
         this.FList_SingleEquipment = new Vector.<TSingelJageList>();
         this.FList_SingleEquipmentFeiQi = new Vector.<TSingelJageList>();
         this.FCharacter = SLogicsCore.Character;
         this.FDec1 = new Vector.<TextField>(Ten);
         this.FDec2 = new Vector.<TextField>(Ten);
         this.FDec3 = new Vector.<MovieClip>(Ten);
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         this.IDTemplates = new Vector.<uint>();
         this.TempInventories = new TInventories();
      }
      
      public function Perform_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Function = null;
         var _loc5_:MovieClip = null;
         var _loc6_:Vector.<DisplayObject> = null;
         var _loc7_:Array = null;
         var _loc8_:DisplayObject = null;
         var _loc9_:TConfigValue = null;
         this.addChild(param1);
         this.FFatherUI = param1;
         this.FUITab = new TUITab(this);
         _loc2_ = 0;
         while(_loc2_ < CONST_JADE.MAX_HeroCount)
         {
            this.FUITab.SetTabByIndex(param1["mc_hero_" + _loc2_],_loc2_);
            _loc2_++;
         }
         this.FUITab.Init();
         this.FUITab.OnSwitch = this.RoleTabOnSwitch;
         _loc5_ = param1["mc_list"];
         this.FScrollBar = new TScrollBar(_loc5_,295,false,0);
         this.FUIPageHeroList = new TUIPage(this);
         this.FUIPageHeroList.ButtonPrevious.Substrate = param1["MC_HeroPage"]["MC_PageLeft"];
         this.FUIPageHeroList.ButtonNext.Substrate = param1["MC_HeroPage"]["MC_PageRight"];
         this.FUIPageHeroList.LabelPage = param1["MC_HeroPage"]["TF_Page"];
         this.FUIPageHeroList.PageSize = CONST_JADE.MAX_HeroCount;
         this.FUIPageHeroList.OnChangePage = this.HeroListPageOnChange;
         this.FUIPageHeroList.Init();
         this.FMC_LeftSlot = new TUISlot(this);
         _loc5_ = param1["MC_CurSlor"];
         this.FMC_LeftSlot.Resource = _loc5_;
         TJadeCommon.InitSlot(this.FMC_LeftSlot,CONST_MODULES.MODULE_Jade);
         this.FMC_LeftSlot.OnClick = this.CurShengJiSlotOnClick;
         this.FMC_LeftSlot.Init();
         this.FMC_LeftSlot.OnOverlay = this.SlotsOnMove;
         this.FMC_LeftSlot.OnOut = this.SlotsOnOut;
         this.FMC_RightSlot = new TUISlot(this);
         _loc5_ = param1["MC_NextSlor"];
         this.FMC_RightSlot.Resource = _loc5_;
         TJadeCommon.InitSlot(this.FMC_RightSlot,CONST_MODULES.MODULE_Jade);
         this.FMC_RightSlot.Init();
         this.FMC_RightSlot.OnOverlay = this.SlotsOnMove;
         this.FMC_RightSlot.OnOut = this.SlotsOnOut;
         this.FMC_JinHuaBtn = param1["MC_JinHuaBtn"];
         this.FTF_CurSlor_Name = param1["TF_CurSlor_Name"];
         this.FTF_CurSlor_Arrt = param1["TF_CurSlor_Arrt"];
         this.FTF_NextSlor_Name = param1["TF_NextSlor_Name"];
         this.FTF_NextSlor_Arrt = param1["TF_NextSlor_Arrt"];
         this.FTF_Name = param1["TF_Name"];
         this.FTF_JinHuaCost = param1["TF_JinHuaCost"];
         _loc2_ = 0;
         while(_loc2_ < Ten)
         {
            this.FDec1[_loc2_] = param1["TF_Value" + _loc2_];
            this.FDec2[_loc2_] = param1["TF_Value0" + _loc2_];
            this.FDec3[_loc2_] = param1["MC_Xing" + _loc2_];
            _loc2_++;
         }
         this.FCurrentShowEquipmentBag = new TInventories();
         _loc9_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,60100050) as TConfigValue;
         this.FNameConfig = _loc9_.Value as Vector.<Object>;
         _loc6_ = new Vector.<DisplayObject>();
         _loc3_ = int(this.FNameConfig.length);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc8_ = this.MakeComboItem(this.FNameConfig[_loc2_][1]);
            _loc6_.push(_loc8_);
            _loc2_++;
         }
         this.FJadeLevelComboBox = new TComboBox(this,param1["MC_ChangeArea"],_loc6_,CONST_JADE.MAX_ComboboxHeight,this.OnLevelSelect);
         this.FIsInilization = true;
      }
      
      public function Perform_UILocation() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Function = null;
         this.FMC_JinHuaBtn.addEventListener(MouseEvent.CLICK,this.BtnClick);
      }
      
      protected function BtnClick(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case this.FMC_JinHuaBtn:
               if(!this.FMC_JinHuaBtn.buttonMode)
               {
                  return;
               }
               if(this.FJinHuaBackFunction != null)
               {
                  this.FJinHuaBackFunction(this.CurInventory,this.OverInventory,this.FCurHeroId);
               }
         }
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         if(!this.FIsInilization)
         {
            return;
         }
         this.LogicsUpdate();
      }
      
      protected function OnLevelSelect(param1:Object, param2:int) : void
      {
         this.FJadeLevelComboBoxSelectIndex = this.FNameConfig[param2][0];
         this.SelectEquipmentsByTabIndex(this.FRoleIndex,this.FCurrentShowEquipmentBag);
         this.SligeEquipSetValue();
      }
      
      protected function CurShengJiSlotOnClick(param1:Object, param2:Object) : void
      {
         this.CurSingleEquip.BSelect = false;
         this.OverInventory = null;
         this.CurInventory = null;
         this.CurSingleEquip = null;
         this.SlotsOnOut(param1,param2 as TInventory);
         this.UpdateView();
      }
      
      protected function RoleTabOnSwitch(param1:Object) : void
      {
         this.FRoleIndex = param1 as int;
         this.FRoleIndex += this.FPageIndexHeroList * Ten;
         this.SelectEquipmentsByTabIndex(this.FRoleIndex,this.FCurrentShowEquipmentBag);
         this.SligeEquipSetValue();
      }
      
      public function JicHuaS_C() : void
      {
         if(this.FFlyText != null)
         {
            this.FFlyText(STRING_JADE.STRING_Cao);
         }
         if(this.FUpdateHeroPower != null && this.FCurHeroId != 0)
         {
            this.FUpdateHeroPower(this,this.FCurHeroId);
         }
         this.SelectEquipmentsByTabIndex(this.FRoleIndex,this.FCurrentShowEquipmentBag);
         this.SligeEquipSetValue();
         if(this.CurSingleEquip)
         {
            this.CurSingleEquip.BSelect = false;
            this.CurSingleEquip = null;
         }
         this.CurInventory = null;
         this.OverInventory = null;
         this.UpdateView();
      }
      
      private function HeroListPageOnChange(param1:Object, param2:int) : void
      {
         this.FPageIndexHeroList = param2;
         this.UpdateRoleTab();
         this.FUITab.SwithTagManual(0);
         this.SelectEquipmentsByTabIndex(0,this.FCurrentShowEquipmentBag);
         this.RoleTabOnSwitch(0);
      }
      
      public function OpenThisPanel() : void
      {
         if(this.CurSingleEquip)
         {
            this.CurSingleEquip.BSelect = false;
            this.CurSingleEquip = null;
         }
         this.CurInventory = null;
         this.OverInventory = null;
         this.FPageIndexHeroList = 0;
         this.FRoleIndex = 0;
         this.SetupHeroListPage();
         this.UpdateRoleTab();
         this.FUITab.SwithTagManual(0);
         this.RoleTabOnSwitch(0);
         this.UpdateView();
      }
      
      public function UpdateView() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:Boolean = false;
         var _loc3_:uint = 0;
         var _loc4_:TInventory = null;
         var _loc5_:TMasterStoneConfig = null;
         var _loc6_:TArticle = null;
         _loc1_ = this.FList_SingleEquipment.length;
         _loc3_ = 0;
         while(_loc3_ < _loc1_)
         {
            this.FList_SingleEquipment[_loc3_].BClick = false;
            _loc3_++;
         }
         if(this.CurSingleEquip)
         {
            this.CurSingleEquip.BSelect = true;
         }
         if(this.CurInventory)
         {
            _loc2_ = true;
            this.FTF_CurSlor_Name.text = this.CurInventory.Name;
            this.FTF_CurSlor_Arrt.text = this.CurInventory.Description;
            _loc5_ = SLogicsCore.LostShenQiLogicData.MasterStoneConfigBins.GetDatebaseByIdentifier(this.CurInventory.IDTemplate) as TMasterStoneConfig;
            if(_loc5_)
            {
               this.TempInventories.Clear();
               this.IDTemplates.length = 0;
               this.IDTemplates.push(_loc5_.UpgradeId);
               this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,this.TempInventories,this.IDTemplates);
               _loc4_ = this.TempInventories.GetInventoryByIndex(0);
               this.OverInventory = _loc4_;
               this.FMC_RightSlot.Context = _loc4_;
               this.FTF_NextSlor_Name.text = _loc4_.Name;
               this.FTF_NextSlor_Arrt.text = _loc4_.Description;
               this.FTF_Name.text = _loc4_.Name;
               this.FTF_JinHuaCost.text = TUtilityString.Format(STRING_JADE.STRING_JinJieCost,_loc5_.Expend);
               _loc1_ = _loc5_.UpgradeId;
               _loc3_ = 0;
               while(_loc3_ < Ten)
               {
                  _loc1_++;
                  _loc6_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Article,_loc1_) as TArticle;
                  if(_loc6_)
                  {
                     this.FDec1[_loc3_].text = _loc6_.Name;
                     this.FDec2[_loc3_].text = _loc6_.FunctionDesc;
                     this.FDec3[_loc3_].visible = true;
                  }
                  _loc1_++;
                  _loc3_++;
               }
            }
         }
         else
         {
            this.RestView();
         }
         TGameUtil.setButtonMode(this.FMC_JinHuaBtn,_loc2_);
      }
      
      protected function RestView() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < Ten)
         {
            this.FDec1[_loc1_].text = "";
            this.FDec2[_loc1_].text = "";
            this.FDec3[_loc1_].visible = false;
            _loc1_++;
         }
         this.FTF_NextSlor_Arrt.text = "";
         this.FTF_NextSlor_Name.text = "";
         this.FTF_JinHuaCost.text = "";
         this.FTF_Name.text = "";
         this.FTF_CurSlor_Name.text = "";
         this.FTF_CurSlor_Arrt.text = "";
         this.FMC_LeftSlot.Context = null;
         this.FMC_RightSlot.Context = null;
      }
      
      protected function UpdateRoleTab() : void
      {
         var _loc1_:int = 0;
         var _loc2_:THero = null;
         var _loc3_:uint = 0;
         var _loc4_:THeros = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         _loc4_ = this.FCharacter.Heros;
         _loc4_.Sort();
         _loc6_ = _loc4_.Count;
         _loc1_ = 0;
         while(_loc1_ < Ten)
         {
            _loc5_ = this.FPageIndexHeroList * Ten + _loc1_;
            if(_loc5_ < _loc6_)
            {
               _loc2_ = _loc4_.GetHeroByIndex(_loc5_);
               _loc3_ = CONST_COMMON.QUALITYCOLOR_INDEX[_loc2_.Quality];
               this.FUITab.SetTabShowByIndex(_loc1_);
               this.FUITab.SetTabCaptionByIndex(_loc2_.Name,_loc1_,_loc3_);
            }
            else if(_loc5_ == _loc6_)
            {
               this.FUITab.SetTabShowByIndex(_loc1_);
               this.FUITab.SetTabCaptionByIndex(STRING_COMMON.STRING_Backage,_loc1_,16775109);
            }
            else if(_loc5_ > _loc6_)
            {
               this.FUITab.SetTabHideByIndex(_loc1_);
            }
            _loc1_++;
         }
      }
      
      protected function GetJageList() : TSingelJageList
      {
         var _loc1_:TSingelJageList = null;
         if(this.FList_SingleEquipmentFeiQi.length > 0)
         {
            _loc1_ = this.FList_SingleEquipmentFeiQi.shift();
            _loc1_.Release();
         }
         if(!_loc1_)
         {
            _loc1_ = new TSingelJageList(this);
         }
         return _loc1_;
      }
      
      protected function SligeEquipSetValue() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TSingelJageList = null;
         var _loc4_:TInventory = null;
         var _loc5_:int = 0;
         var _loc6_:uint = 0;
         _loc2_ = int(this.FList_SingleEquipment.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FList_SingleEquipment[_loc1_];
            this.FList_SingleEquipmentFeiQi.push(_loc3_);
            _loc1_++;
         }
         this.FList_SingleEquipment.length = 0;
         if(this.CurSingleEquip)
         {
            this.CurSingleEquip.BSelect = false;
         }
         this.CurSingleEquip = null;
         this.FScrollBar.Clear();
         _loc2_ = this.FCurrentShowEquipmentBag.Count;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.GetJageList();
            _loc3_.OnClick = this.EquipmentClick;
            _loc3_.OnQuerySequenceContext = TJadeCommon.SlotsOnQuerySequenceContext;
            _loc3_.OnQueryEuqipLevel = this.SlotsOnQueryEuqipLevel;
            _loc3_.OnOut = this.SlotsOnOut;
            _loc3_.OnOver = this.SlotsOnMove;
            _loc4_ = this.FCurrentShowEquipmentBag.GetInventoryByIndex(_loc1_);
            _loc3_.SetEquip(_loc4_,_loc4_.Name);
            this.FScrollBar.AddItem(_loc3_);
            this.FList_SingleEquipment.push(_loc3_);
            _loc6_++;
            _loc1_++;
         }
         if(_loc6_ < CONST_TALISMAN.CAPACITY_EQUIPCopy || _loc6_ == 0)
         {
            _loc2_ = int(CONST_TALISMAN.CAPACITY_EQUIPCopy);
            _loc1_ = 0;
            while(_loc1_ < _loc2_ - _loc6_)
            {
               _loc3_ = this.GetJageList();
               this.FScrollBar.AddItem(_loc3_);
               _loc1_++;
            }
         }
      }
      
      protected function EquipmentClick(param1:Object, param2:Object) : void
      {
         this.CurInventory = param2 as TInventory;
         this.CurSingleEquip = param1 as TSingelJageList;
         this.FMC_LeftSlot.Context = this.CurInventory;
         this.UpdateView();
      }
      
      protected function SelectEquipmentsByTabIndex(param1:int, param2:TInventories) : void
      {
         var _loc3_:THero = null;
         var _loc4_:int = 0;
         var _loc5_:TCollectionInventory = null;
         var _loc6_:TEquipment = null;
         var _loc7_:int = 0;
         var _loc8_:uint = 0;
         var _loc9_:TAppliance = null;
         var _loc10_:int = 0;
         _loc8_ = uint(param1);
         if(_loc8_ < SLogicsCore.Character.Heros.Count)
         {
            _loc3_ = SLogicsCore.Character.Heros.GetHeroByIndex(_loc8_);
            _loc5_ = _loc3_.EquipmentsMounted;
            this.FCurHeroId = _loc3_.Identifier;
            param2.Clear();
            _loc4_ = 0;
            while(_loc4_ < _loc5_.Capacity)
            {
               _loc6_ = _loc5_.GetInventoryByIndex(_loc4_) as TEquipment;
               if(_loc6_ != null)
               {
                  _loc7_ = _loc6_.GiftedStoneItems.Count;
                  _loc10_ = 0;
                  while(_loc10_ < _loc7_)
                  {
                     _loc9_ = _loc6_.GiftedStoneItems.GetGiftedStoneByIndex(_loc10_);
                     if(_loc9_ != null)
                     {
                        if(this.GetBoo(_loc9_))
                        {
                           _loc9_.EquipmentDeJade = _loc6_;
                           param2.Add(_loc9_);
                        }
                     }
                     _loc10_++;
                  }
               }
               _loc4_++;
            }
         }
         else
         {
            this.FCurHeroId = 0;
            _loc7_ = int(SLogicsCore.Character.Equipments.Count);
            param2.Clear();
            _loc4_ = 0;
            while(_loc4_ < _loc7_)
            {
               _loc6_ = SLogicsCore.Character.Equipments.GetInventoryByIndex(_loc4_) as TEquipment;
               _loc8_ = uint(_loc6_.GiftedStoneItems.Count);
               _loc10_ = 0;
               while(_loc10_ < _loc8_)
               {
                  _loc9_ = _loc6_.GiftedStoneItems.GetGiftedStoneByIndex(_loc10_);
                  if(_loc9_ != null)
                  {
                     if(this.GetBoo(_loc9_))
                     {
                        _loc9_.EquipmentDeJade = _loc6_;
                        param2.Add(_loc9_);
                     }
                  }
                  _loc10_++;
               }
               _loc4_++;
            }
            _loc7_ = int(SLogicsCore.Character.Gems.Count);
            _loc4_ = 0;
            while(_loc4_ < _loc7_)
            {
               _loc9_ = SLogicsCore.Character.Gems.GetInventoryByIndex(_loc4_) as TAppliance;
               if(_loc9_ != null)
               {
                  if(this.GetBoo(_loc9_))
                  {
                     _loc9_.EquipmentDeJade = null;
                     param2.Add(_loc9_);
                  }
               }
               _loc4_++;
            }
         }
      }
      
      protected function GetBoo(param1:TAppliance) : Boolean
      {
         var _loc2_:TMasterStoneConfig = SLogicsCore.LostShenQiLogicData.MasterStoneConfigBins.GetDatebaseByIdentifier(param1.IDTemplate) as TMasterStoneConfig;
         if(_loc2_)
         {
            if(this.FJadeLevelComboBoxSelectIndex == 0)
            {
               return true;
            }
            if(this.FJadeLevelComboBoxSelectIndex == param1.CategorySecond)
            {
               return true;
            }
         }
         return false;
      }
      
      protected function OnSlotClick(param1:Object = null, param2:Object = null) : void
      {
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
      
      public function set FlyText(param1:Function) : void
      {
         this.FFlyText = param1;
      }
      
      public function set UpdateHeroPower(param1:Function) : void
      {
         this.FUpdateHeroPower = param1;
      }
      
      public function set JinHuaBackFunction(param1:Function) : void
      {
         this.FJinHuaBackFunction = param1;
      }
      
      public function set OnInventoryOver(param1:Function) : void
      {
         this.FOnInventoryOver = param1;
      }
      
      public function set OnInventoryOut(param1:Function) : void
      {
         this.FOnInventoryOut = param1;
      }
      
      protected function SlotsOnQueryEuqipLevel(param1:Object, param2:Object, param3:TQueryString) : void
      {
         var _loc4_:TInventory = param2 as TInventory;
         if(_loc4_.UpgradingLevel > 0)
         {
            param3.Value = STRING_COMMON.FORMAT_Level + _loc4_.UpgradingLevel.toString();
         }
      }
      
      protected function SetupHeroListPage() : void
      {
         this.FUIPageHeroList.TotalQuantity = this.FCharacter.Heros.Count + 1;
         this.FUIPageHeroList.Update();
         this.FUIPageHeroList.PageIndex = this.FPageIndexHeroList;
      }
      
      public function LogicsUpdate() : void
      {
         var _loc1_:int = 0;
         if(this.FIsInilization)
         {
            _loc1_ = 0;
            while(_loc1_ < this.FList_SingleEquipment.length)
            {
               this.FList_SingleEquipment[_loc1_].UpdateSingleEquip();
               _loc1_++;
            }
            this.FMC_LeftSlot.Update();
            this.FMC_RightSlot.Update();
         }
      }
      
      protected function MakeComboItem(param1:String) : DisplayObject
      {
         var _loc2_:MovieClip = TUtilityReflection.CreateDisplayObjectInstance(CONST_JADE.RESOURCE_ClassName_ComboBoxItem2) as MovieClip;
         _loc2_.tf_into.text = param1;
         return _loc2_;
      }
   }
}

