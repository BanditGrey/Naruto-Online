package Processors.Game.Lobby.TransmigrationTrial
{
   import Components.Pages.TUIPage;
   import Components.ScrollBar.TScrollBar;
   import Components.Slots.TUISlot;
   import Components.Standard.TUITab;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Queries.TQueryString;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.Characters.TCharacter;
   import Logics.Characters.THero;
   import Logics.Characters.THeros;
   import Logics.DatebaseVO.VO.TBuildConsume;
   import Logics.DatebaseVO.VO.TBuildValue;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.DatebaseVO.VO.TEquipUpgrade;
   import Logics.Inventories.TCollectionInventory;
   import Logics.Inventories.TEquipment;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Processors.Game.Lobby.Talisman.TSingleEquip;
   import Processors.Game.TProcessorGame;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_EQUIPADVANCED;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_TRANSMIGRATIONTRIAL;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class TProcessorWindowTransmigrationMakeEquipAdvanced extends TProcessorGame
   {
      
      protected static const MAX_MATERIAL_COUNT:uint = 3;
      
      protected static const MAX_HERO_COUNT:uint = 10;
      
      protected static const QUALITYCOLOR_INDEX:Vector.<uint> = CONST_COMMON.QUALITYCOLOR_INDEX;
      
      protected var FScene:MovieClip;
      
      protected var FHeroNameTab:TUITab;
      
      protected var FUIPageHeroList:TUIPage;
      
      protected var FScrollBar:TScrollBar;
      
      protected var FMC_FreeSingleEquipList:Vector.<TSingleEquip>;
      
      protected var FMC_UseSingleEquipList:Vector.<TSingleEquip>;
      
      protected var UnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FCurrentShowTagIndex:uint;
      
      protected var FPageIndexHeroList:uint;
      
      protected var FHeros:THeros;
      
      protected var FCharacter:TCharacter;
      
      protected var FCurrentClickSingleEquip:TSingleEquip;
      
      protected var FSelectContext:TEquipment;
      
      protected var FUITargetSlot:TUISlot;
      
      protected var FUISourceSlot:TUISlot;
      
      protected var FUIMaterialSlotVect:Vector.<TUISlot>;
      
      protected var FIsCanMake:Boolean;
      
      protected var FSlotsOnQuerySequenceContext:Function;
      
      protected var FSlotsOnQuerySubscript:Function;
      
      protected var FUIComponentsHintOnOver:Function;
      
      protected var FUIComponentsHintOnOut:Function;
      
      public function TProcessorWindowTransmigrationMakeEquipAdvanced(param1:TUIComponent)
      {
         super(param1);
         this.FCharacter = SLogicsCore.Character;
         this.FHeros = SLogicsCore.Character.Heros;
         this.FUIMaterialSlotVect = new Vector.<TUISlot>();
      }
      
      protected function OnSwitchTab(param1:uint) : void
      {
         if(this.FCurrentShowTagIndex != param1)
         {
            this.FCurrentShowTagIndex = param1;
            this.Update();
         }
      }
      
      protected function HeroListPageOnChange(param1:Object, param2:int) : void
      {
         if(this.FPageIndexHeroList != param2)
         {
            this.FPageIndexHeroList = param2;
            this.OnSwitchTab(0);
            this.FHeroNameTab.SwithTagManual(0);
            this.Update();
         }
      }
      
      protected function ResetPageHeroList() : void
      {
         this.FUIPageHeroList.TotalQuantity = this.FHeros.Count + 1;
         this.FUIPageHeroList.Update();
         this.FUIPageHeroList.PageIndex = 0;
      }
      
      protected function UpdateHeroTab() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:THero = null;
         _loc2_ = this.FHeros.Count + 1 - this.FPageIndexHeroList * MAX_HERO_COUNT;
         _loc1_ = 0;
         while(_loc1_ < MAX_HERO_COUNT)
         {
            if(_loc1_ < _loc2_)
            {
               this.FHeroNameTab.SetTabShowByIndex(_loc1_);
               if(_loc1_ + this.FPageIndexHeroList * MAX_HERO_COUNT < this.FHeros.Count)
               {
                  _loc3_ = this.FHeros.GetHeroByIndex(_loc1_ + this.FPageIndexHeroList * MAX_HERO_COUNT);
                  this.FHeroNameTab.SetTabCaptionByIndex(_loc3_.Name,_loc1_,QUALITYCOLOR_INDEX[_loc3_.Quality]);
               }
               else
               {
                  this.FHeroNameTab.SetTabCaptionByIndex(STRING_COMMON.STRING_Backage,_loc1_,16775109);
               }
            }
            else
            {
               this.FHeroNameTab.SetTabHideByIndex(_loc1_);
            }
            _loc1_++;
         }
         this.FUIPageHeroList.TotalQuantity = this.FHeros.Count + 1;
         this.FUIPageHeroList.Update();
      }
      
      protected function GetSingleEquip() : TSingleEquip
      {
         var _loc1_:TSingleEquip = null;
         if(this.FMC_FreeSingleEquipList.length > 0)
         {
            _loc1_ = this.FMC_FreeSingleEquipList.pop();
         }
         else
         {
            _loc1_ = new TSingleEquip(this);
            _loc1_.OnClick = this.OnEquipmentClick;
            _loc1_.OnQuerySequenceContext = this.OnSlotsOnQuerySequenceContext;
            _loc1_.OnQueryEuqipLevel = this.OnSlotsOnQueryEuqipLevel;
            _loc1_.OnOut = this.OnUIComponentsHintOnOut;
            _loc1_.OnOver = this.OnUIComponentsHintOnOver;
         }
         _loc1_.BClick = true;
         return _loc1_;
      }
      
      protected function UpdateScroolBar() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:TSingleEquip = null;
         var _loc4_:THero = null;
         var _loc5_:TCollectionInventory = null;
         var _loc6_:TInventories = null;
         var _loc7_:TInventory = null;
         var _loc8_:TEquipUpgrade = null;
         _loc2_ = this.FMC_UseSingleEquipList.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FMC_UseSingleEquipList[_loc1_];
            this.FMC_FreeSingleEquipList.push(_loc3_);
            _loc1_++;
         }
         this.FMC_UseSingleEquipList.length = 0;
         this.FScrollBar.Clear();
         this.FCurrentClickSingleEquip = null;
         if(this.FCurrentShowTagIndex + this.FPageIndexHeroList * MAX_HERO_COUNT < this.FHeros.Count)
         {
            _loc4_ = this.FHeros.GetHeroByIndex(this.FCurrentShowTagIndex + this.FPageIndexHeroList * MAX_HERO_COUNT);
            _loc5_ = _loc4_.EquipmentsMounted;
         }
         else
         {
            _loc6_ = this.FCharacter.Equipments;
         }
         if(_loc5_ != null)
         {
            _loc2_ = uint(_loc5_.Capacity);
         }
         else
         {
            _loc2_ = uint(_loc6_.Count);
         }
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(_loc5_ != null)
            {
               _loc7_ = _loc5_.GetInventoryByIndex(_loc1_);
            }
            else
            {
               _loc7_ = _loc6_.GetInventoryByIndex(_loc1_);
            }
            if(_loc7_ != null)
            {
               _loc8_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_EquipUpgrade,_loc7_.IDTemplate) as TEquipUpgrade;
               if(_loc8_ != null)
               {
                  if(!(_loc8_.IsEpic == 0 || _loc8_.IsEpic == 2))
                  {
                     _loc3_ = this.GetSingleEquip();
                     _loc3_.SetEquip(_loc7_,_loc7_.Name,STRING_TRANSMIGRATIONTRIAL.STRENGTHEPRIFIX_NAME + (_loc7_ as TEquipment).UpgradingLevel,_loc7_.Quality);
                     this.FScrollBar.AddItem(_loc3_);
                     this.FMC_UseSingleEquipList.push(_loc3_);
                  }
               }
            }
            _loc1_++;
         }
      }
      
      protected function UpdateEquip() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:TEquipment = null;
         var _loc4_:TEquipment = null;
         var _loc5_:TEquipUpgrade = null;
         var _loc6_:TInventories = null;
         var _loc7_:TInventories = null;
         var _loc8_:TInventory = null;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:TUISlot = null;
         var _loc12_:TBins = null;
         var _loc13_:TBins = null;
         var _loc14_:TBuildValue = null;
         var _loc15_:TBuildConsume = null;
         var _loc16_:TConfigValue = null;
         var _loc17_:uint = 0;
         var _loc18_:uint = 0;
         var _loc19_:uint = 0;
         var _loc20_:uint = 0;
         if(this.FCurrentClickSingleEquip == null)
         {
            this.FUITargetSlot.Context = null;
            this.FUISourceSlot.Context = null;
            _loc2_ = this.FUIMaterialSlotVect.length;
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               _loc11_ = this.FUIMaterialSlotVect[_loc1_];
               _loc11_.Context = null;
               this.FScene["mc_Material" + _loc1_]["TF_NeedNum"].text = "";
               _loc1_++;
            }
            TGameUtil.setButtonMode(this.FScene["btn_Make"],false);
         }
         else
         {
            _loc3_ = this.FCurrentClickSingleEquip.Context as TEquipment;
            this.FIsCanMake = true;
            _loc5_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_EquipUpgrade,_loc3_.IDTemplate) as TEquipUpgrade;
            if(_loc5_ == null)
            {
               return;
            }
            this.FUITargetSlot.Context = _loc3_;
            _loc13_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_BuildConsume);
            if(_loc3_.UpgradingLevel > 0)
            {
               _loc17_ = 0;
               _loc2_ = uint(_loc13_.Count);
               _loc1_ = 0;
               while(_loc1_ < _loc2_)
               {
                  _loc15_ = _loc13_.GetDatebaseByIndex(_loc1_) as TBuildConsume;
                  if(_loc15_.Quality == _loc3_.Quality)
                  {
                     _loc17_ += _loc15_.Consume;
                     if(_loc15_.BuildLevel == _loc3_.UpgradingLevel)
                     {
                        _loc17_ -= _loc15_.Consume;
                        break;
                     }
                  }
                  _loc1_++;
               }
               _loc16_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_EQUIPADVANCED.EQUIP_CONSUME_RATE) as TConfigValue;
               _loc18_ = uint(int(_loc17_ * (_loc16_.Value as Number)));
               _loc17_ = 0;
               _loc2_ = uint(_loc13_.Count);
               if(_loc18_ >= 0)
               {
                  _loc1_ = 0;
                  while(_loc1_ < _loc2_)
                  {
                     _loc15_ = _loc13_.GetDatebaseByIndex(_loc1_) as TBuildConsume;
                     if(_loc15_.Quality == _loc3_.Quality + 1)
                     {
                        _loc17_ += _loc15_.Consume;
                        if(_loc18_ < _loc17_)
                        {
                           _loc19_ = uint(_loc15_.BuildLevel);
                           break;
                        }
                     }
                     _loc1_++;
                  }
               }
            }
            _loc7_ = new TInventories();
            this.UnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc7_,Vector.<uint>([_loc5_.GotEquipId]));
            _loc4_ = _loc7_.GetInventoryByIndex(0) as TEquipment;
            _loc12_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_BuildValue);
            _loc2_ = uint(_loc12_.Count);
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               _loc14_ = _loc12_.GetDatebaseByIndex(_loc1_) as TBuildValue;
               if(_loc4_.CategorySecond == _loc14_.EquipType && _loc4_.Quality == _loc14_.Quality && _loc19_ == _loc14_.BuildLevel)
               {
                  _loc20_ = uint(_loc14_.Value);
               }
               _loc1_++;
            }
            _loc4_.UpgradingLevel = _loc19_;
            _loc4_.UpgradingBasisProperty = _loc20_;
            this.FUISourceSlot.Context = _loc4_;
            _loc6_ = new TInventories();
            this.UnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc6_,_loc5_.Materials);
            _loc2_ = this.FUIMaterialSlotVect.length;
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               _loc11_ = this.FUIMaterialSlotVect[_loc1_];
               _loc8_ = _loc6_.GetInventoryByIndex(_loc1_);
               _loc11_.Context = _loc8_;
               _loc9_ = this.GetMaterialCountByID(_loc8_.IDTemplate);
               _loc10_ = _loc5_.Quantitys[_loc1_];
               this.FScene["mc_Material" + _loc1_]["TF_NeedNum"].text = _loc9_ + "/" + _loc10_;
               if(_loc9_ < _loc10_)
               {
                  this.FIsCanMake = false;
                  this.FScene["mc_Material" + _loc1_]["TF_NeedNum"].textColor = CONST_COMMON.TEXT_White_Color;
               }
               else
               {
                  this.FScene["mc_Material" + _loc1_]["TF_NeedNum"].textColor = CONST_COMMON.TEXT_Green_Color;
               }
               _loc1_++;
            }
            TGameUtil.setButtonMode(this.FScene["btn_Make"],this.FIsCanMake);
         }
      }
      
      protected function OnEquipmentClick(param1:Object, param2:Object) : void
      {
         var _loc3_:TSingleEquip = null;
         _loc3_ = param1 as TSingleEquip;
         if(this.FCurrentClickSingleEquip != null)
         {
            this.FCurrentClickSingleEquip.BClick = false;
         }
         this.FCurrentClickSingleEquip = _loc3_;
         this.UpdateEquip();
      }
      
      protected function OnSlotsOnQuerySequenceContext(param1:Object, param2:Object, param3:TQueryAnimationSequence) : void
      {
         if(this.FSlotsOnQuerySequenceContext != null)
         {
            this.FSlotsOnQuerySequenceContext(param1,param2,param3);
         }
      }
      
      protected function OnSlotsOnQueryEuqipLevel(param1:Object, param2:Object, param3:TQueryString) : void
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
      
      protected function OnSlotsOnQuerySubscript(param1:Object, param2:Object, param3:TQueryString) : void
      {
         if(this.FSlotsOnQuerySubscript != null)
         {
            this.FSlotsOnQuerySubscript(param1,param2,param3);
         }
      }
      
      protected function OnUIComponentsHintOnOver(param1:Object, param2:Object) : void
      {
         if(this.FUIComponentsHintOnOver != null)
         {
            this.FUIComponentsHintOnOver(param1,param2);
         }
      }
      
      protected function OnUIComponentsHintOnOut(param1:Object, param2:Object) : void
      {
         if(this.FUIComponentsHintOnOut != null)
         {
            this.FUIComponentsHintOnOut(param1,param2);
         }
      }
      
      protected function GetMaterialCountByID(param1:uint) : uint
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:TInventories = null;
         var _loc5_:TInventory = null;
         var _loc6_:uint = 0;
         _loc4_ = SLogicsCore.Character.Materials;
         _loc3_ = uint(_loc4_.Count);
         _loc6_ = 0;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc5_ = _loc4_.GetInventoryByIndex(_loc2_);
            if(_loc5_.IDTemplate == param1)
            {
               _loc6_ += _loc5_.Quantity;
            }
            _loc2_++;
         }
         return _loc6_;
      }
      
      protected function OnMakeAdvEquip(param1:MouseEvent) : void
      {
         var _loc2_:TPacket = null;
         if(Boolean(param1.currentTarget) && !param1.currentTarget.buttonMode)
         {
            return;
         }
         if(this.FCurrentClickSingleEquip == null)
         {
            return;
         }
         if(this.FCurrentClickSingleEquip.Context == null)
         {
            return;
         }
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TransmigrationTrial_EquipGodCast_Req);
         _loc2_.Data.writeUnsignedInt((this.FCurrentClickSingleEquip.Context as TInventory).Identifier0);
         _loc2_.Data.writeUnsignedInt((this.FCurrentClickSingleEquip.Context as TInventory).Identifier1);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      public function get SlotsOnQuerySequenceContext() : Function
      {
         return this.FSlotsOnQuerySequenceContext;
      }
      
      public function set SlotsOnQuerySequenceContext(param1:Function) : void
      {
         this.FSlotsOnQuerySequenceContext = param1;
      }
      
      public function get SlotsOnQuerySubscript() : Function
      {
         return this.FSlotsOnQuerySubscript;
      }
      
      public function set SlotsOnQuerySubscript(param1:Function) : void
      {
         this.FSlotsOnQuerySubscript = param1;
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
      
      public function SetScene(param1:MovieClip) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:TUISlot = null;
         this.FScene = param1;
         addChild(this.FScene);
         this.FHeroNameTab = new TUITab(this);
         _loc2_ = 0;
         while(_loc2_ < MAX_HERO_COUNT)
         {
            this.FHeroNameTab.SetTabByIndex(this.FScene["General_" + _loc2_],_loc2_);
            _loc2_++;
         }
         this.FHeroNameTab.Init();
         this.FHeroNameTab.OnSwitch = this.OnSwitchTab;
         this.FUIPageHeroList = new TUIPage(this);
         this.FUIPageHeroList.ButtonPrevious.Substrate = this.FScene["MC_HeroPage"]["MC_PageLeft"];
         this.FUIPageHeroList.ButtonNext.Substrate = this.FScene["MC_HeroPage"]["MC_PageRight"];
         this.FUIPageHeroList.LabelPage = this.FScene["MC_HeroPage"]["TF_Page"];
         this.FUIPageHeroList.PageSize = MAX_HERO_COUNT;
         this.FUIPageHeroList.OnChangePage = this.HeroListPageOnChange;
         this.ResetPageHeroList();
         this.FScrollBar = new TScrollBar(this.FScene["mc_list"],348,false);
         this.FMC_FreeSingleEquipList = new Vector.<TSingleEquip>();
         this.FMC_UseSingleEquipList = new Vector.<TSingleEquip>();
         this.UnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         TGameUtil.setButtonMode(this.FScene["btn_Make"],true);
         this.FScene["btn_Make"].addEventListener(MouseEvent.CLICK,this.OnMakeAdvEquip);
         this.FUITargetSlot = new TUISlot(this);
         this.FUITargetSlot.Resource = this.FScene["mc_TargetSlot"];
         this.FUITargetSlot.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
         this.FUITargetSlot.OnQuerySequenceContext = this.OnSlotsOnQuerySequenceContext;
         this.FUITargetSlot.OnOverlay = this.OnUIComponentsHintOnOver;
         this.FUITargetSlot.OnOut = this.OnUIComponentsHintOnOut;
         this.FUITargetSlot.Init();
         this.FUISourceSlot = new TUISlot(this);
         this.FUISourceSlot.Resource = this.FScene["mc_SourceSlot"];
         this.FUISourceSlot.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
         this.FUISourceSlot.OnQuerySequenceContext = this.OnSlotsOnQuerySequenceContext;
         this.FUISourceSlot.OnOverlay = this.OnUIComponentsHintOnOver;
         this.FUISourceSlot.OnOut = this.OnUIComponentsHintOnOut;
         this.FUISourceSlot.Init();
         _loc2_ = 0;
         while(_loc2_ < MAX_MATERIAL_COUNT)
         {
            _loc3_ = new TUISlot(this);
            _loc3_.Resource = this.FScene["mc_Material" + _loc2_];
            _loc3_.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
            _loc3_.OnQuerySequenceContext = this.OnSlotsOnQuerySequenceContext;
            _loc3_.OnOverlay = this.OnUIComponentsHintOnOver;
            _loc3_.OnOut = this.OnUIComponentsHintOnOut;
            _loc3_.Init();
            this.FUIMaterialSlotVect.push(_loc3_);
            _loc2_++;
         }
      }
      
      public function Update() : void
      {
         this.UpdateHeroTab();
         this.UpdateScroolBar();
         this.UpdateEquip();
      }
      
      public function UpdateView() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:TSingleEquip = null;
         var _loc4_:TUISlot = null;
         if(!Visible)
         {
            return;
         }
         _loc2_ = this.FMC_UseSingleEquipList.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FMC_UseSingleEquipList[_loc1_];
            _loc3_.UpdateSingleEquip();
            _loc1_++;
         }
         if(this.FUISourceSlot)
         {
            this.FUISourceSlot.Update();
         }
         if(this.FUITargetSlot)
         {
            this.FUITargetSlot.Update();
         }
         _loc2_ = this.FUIMaterialSlotVect.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc4_ = this.FUIMaterialSlotVect[_loc1_];
            _loc4_.Update();
            _loc1_++;
         }
      }
      
      public function SetSelectContext(param1:Object) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:THero = null;
         var _loc7_:TCollectionInventory = null;
         var _loc8_:TInventory = null;
         var _loc9_:Boolean = false;
         var _loc10_:TSingleEquip = null;
         var _loc11_:uint = 0;
         this.FSelectContext = param1 as TEquipment;
         if(this.FSelectContext == null)
         {
            return;
         }
         _loc9_ = false;
         _loc4_ = uint(this.FHeros.Count);
         _loc2_ = 0;
         while(_loc2_ < _loc4_)
         {
            _loc6_ = this.FHeros.GetHeroByIndex(_loc2_);
            _loc7_ = _loc6_.EquipmentsMounted;
            _loc5_ = uint(_loc7_.Capacity);
            _loc3_ = 0;
            while(_loc3_ < _loc5_)
            {
               _loc8_ = _loc7_.GetInventoryByIndex(_loc3_);
               if(_loc8_ != null)
               {
                  if(_loc8_.Identifier0 == this.FSelectContext.Identifier0 && _loc8_.Identifier1 == this.FSelectContext.Identifier1)
                  {
                     this.FPageIndexHeroList = int(_loc2_ / MAX_HERO_COUNT);
                     this.FUIPageHeroList.PageIndex = this.FPageIndexHeroList;
                     this.OnSwitchTab(_loc2_ % MAX_HERO_COUNT);
                     this.FHeroNameTab.SwithTagManual(_loc2_ % MAX_HERO_COUNT);
                     this.UpdateScroolBar();
                     this.UpdateEquip();
                     this.FMC_UseSingleEquipList[_loc11_].dispatchEvent(new MouseEvent(MouseEvent.CLICK));
                     _loc9_ = true;
                     break;
                  }
                  _loc11_++;
               }
               _loc3_++;
            }
            _loc2_++;
         }
         if(!_loc9_)
         {
            this.FPageIndexHeroList = int((_loc4_ + 1) / MAX_HERO_COUNT);
            this.FUIPageHeroList.PageIndex = this.FPageIndexHeroList;
            this.OnSwitchTab(_loc4_ % MAX_HERO_COUNT);
            this.FHeroNameTab.SwithTagManual(_loc4_ % MAX_HERO_COUNT);
            this.UpdateScroolBar();
            this.UpdateEquip();
            _loc4_ = this.FMC_UseSingleEquipList.length;
            _loc2_ = 0;
            while(_loc2_ < _loc4_)
            {
               _loc10_ = this.FMC_UseSingleEquipList[_loc2_];
               if((_loc10_.Context as TEquipment).Identifier0 == this.FSelectContext.Identifier0 && (_loc10_.Context as TEquipment).Identifier1 == this.FSelectContext.Identifier1)
               {
                  this.FMC_UseSingleEquipList[_loc2_].dispatchEvent(new MouseEvent(MouseEvent.CLICK));
               }
               _loc2_++;
            }
         }
      }
   }
}

