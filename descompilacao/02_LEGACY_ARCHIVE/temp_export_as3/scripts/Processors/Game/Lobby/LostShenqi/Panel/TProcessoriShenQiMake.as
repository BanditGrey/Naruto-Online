package Processors.Game.Lobby.LostShenqi.Panel
{
   import Components.Pages.TUIPage;
   import Components.ScrollBar.TScrollBar;
   import Components.Slots.TUISlot;
   import Components.Standard.TUITab;
   import Foundation.Queries.TQueryString;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.Repositories.TResourceRepositoryTexture;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Resources.Textures.TTexture;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Logics.Characters.TCharacter;
   import Logics.Characters.THero;
   import Logics.Characters.THeros;
   import Logics.DatebaseVO.VO.TLostsacredGenerate;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.LostShenQi.TLostShenQiLogicData;
   import Logics.SLogicsCore;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.Jade.TJadeCommon;
   import Processors.Game.Lobby.Talisman.TSingleEquip;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_TALISMAN;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_TALISMAN;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessoriShenQiMake extends TProcessorLobbyWindow
   {
      
      public static const SIX:int = 10;
      
      protected var FThisPanel:MovieClip;
      
      protected var FMC_MakeBtn:MovieClip;
      
      protected var FIsInilization:Boolean;
      
      protected var FScrollBar:TScrollBar;
      
      protected var FMC_Effect:MovieClip;
      
      protected var FTF_Name:TextField;
      
      protected var FTF_Dec:TextField;
      
      protected var CurInventory:TInventory;
      
      protected var CurSingleEquip:TSingleEquip;
      
      protected var FMC_SingleEquipList:Vector.<TSingleEquip>;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var TempInventories:TInventories;
      
      protected var TempInventoriesCopy:TInventories;
      
      protected var IDTemplates:Vector.<uint>;
      
      protected var FInventoryVector:Vector.<TInventory>;
      
      protected var FMC_LeftSlot:TUISlot;
      
      protected var FMC_RightSlot:TUISlot;
      
      protected var FMC_Slot_0:TUISlot;
      
      protected var FMC_Slot_1:TUISlot;
      
      protected var FUITab:TUITab;
      
      protected var FRoleIndex:int;
      
      protected var FPageIndexHeroList:int;
      
      protected var FUIPageHeroList:TUIPage;
      
      protected var FLostShenQiLogicData:TLostShenQiLogicData;
      
      protected var FCharacter:TCharacter;
      
      protected var FOnInventoryOver:Function;
      
      protected var FOnInventoryOut:Function;
      
      protected var FMakeBtnFunction:Function;
      
      protected var FCurHeroid:uint;
      
      public function TProcessoriShenQiMake(param1:TUIComponent)
      {
         super(param1);
         this.FUITab = new TUITab(this);
         this.FUIPageHeroList = new TUIPage(this);
         this.FInventoryVector = new Vector.<TInventory>();
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         this.IDTemplates = new Vector.<uint>();
         this.TempInventories = new TInventories();
         this.TempInventoriesCopy = new TInventories();
         this.FMC_SingleEquipList = new Vector.<TSingleEquip>();
         this.FLostShenQiLogicData = SLogicsCore.LostShenQiLogicData;
         this.FCharacter = SLogicsCore.Character;
      }
      
      public function get ThisPanel() : MovieClip
      {
         return this.FThisPanel;
      }
      
      public function set SetPanel(param1:MovieClip) : void
      {
         this.FThisPanel = param1;
         this.IniLization();
      }
      
      protected function IniLization() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:int = 0;
         this.FMC_MakeBtn = this.FThisPanel["MC_MakeBtn"];
         _loc2_ = 0;
         while(_loc2_ < SIX)
         {
            _loc1_ = this.FThisPanel["MC_HeroLabel_" + _loc2_];
            this.FUITab.SetTabByIndex(_loc1_,_loc2_);
            _loc2_++;
         }
         this.FUITab.OnSwitch = this.RoleTabOnSwitch;
         this.FUITab.Init();
         _loc1_ = this.FThisPanel["MC_ChangeBtn"]["MC_PageLeft"];
         this.FUIPageHeroList.ButtonPrevious.Substrate = _loc1_;
         _loc1_ = this.FThisPanel["MC_ChangeBtn"]["MC_PageRight"];
         this.FUIPageHeroList.ButtonNext.Substrate = _loc1_;
         this.FUIPageHeroList.LabelPage = this.FThisPanel["MC_ChangeBtn"]["TF_Page"];
         this.FUIPageHeroList.PageSize = SIX;
         this.FUIPageHeroList.OnChangePage = this.HeroListPageOnChange;
         this.FUIPageHeroList.Init();
         _loc1_ = this.FThisPanel["mc_list"];
         this.FScrollBar = new TScrollBar(_loc1_,348,false,0);
         this.FMC_LeftSlot = new TUISlot(this);
         _loc1_ = this.FThisPanel["MC_LeftSlot"];
         this.FMC_LeftSlot.Resource = _loc1_;
         TJadeCommon.InitSlot(this.FMC_LeftSlot,CONST_MODULES.MODULE_LostShenQi);
         this.FMC_LeftSlot.OnClick = this.CurShengJiSlotOnClick;
         this.FMC_LeftSlot.Init();
         this.FMC_LeftSlot.OnOverlay = this.SlotsOnMove;
         this.FMC_LeftSlot.OnOut = this.SlotsOnOut;
         this.FMC_RightSlot = new TUISlot(this);
         _loc1_ = this.FThisPanel["MC_RightSlot"];
         this.FMC_RightSlot.Resource = _loc1_;
         TJadeCommon.InitSlot(this.FMC_RightSlot,CONST_MODULES.MODULE_LostShenQi);
         this.FMC_RightSlot.Init();
         this.FMC_RightSlot.OnOverlay = this.SlotsOnMove;
         this.FMC_RightSlot.OnOut = this.SlotsOnOut;
         this.FMC_Slot_0 = new TUISlot(this);
         _loc1_ = this.FThisPanel["MC_Slot_0"];
         this.FMC_Slot_0.Resource = _loc1_;
         TJadeCommon.InitSlot(this.FMC_Slot_0,CONST_MODULES.MODULE_LostShenQi);
         this.FMC_Slot_0.Init();
         this.FMC_Slot_0.OnOverlay = this.SlotsOnMove;
         this.FMC_Slot_0.OnOut = this.SlotsOnOut;
         this.FMC_Slot_1 = new TUISlot(this);
         _loc1_ = this.FThisPanel["MC_Slot_1"];
         this.FMC_Slot_1.Resource = _loc1_;
         TJadeCommon.InitSlot(this.FMC_Slot_1,CONST_MODULES.MODULE_LostShenQi);
         this.FMC_Slot_1.Init();
         this.FMC_Slot_1.OnOverlay = this.SlotsOnMove;
         this.FMC_Slot_1.OnOut = this.SlotsOnOut;
         this.FIsInilization = true;
      }
      
      public function OpenThisPanel() : void
      {
         if(this.CurSingleEquip)
         {
            this.CurSingleEquip.BSelect = false;
            this.CurSingleEquip = null;
         }
         this.CurInventory = null;
         this.FMC_LeftSlot.Context = null;
         this.FMC_RightSlot.Context = null;
         this.FPageIndexHeroList = 0;
         this.FRoleIndex = 0;
         this.SetupHeroListPage();
         this.UpdateRoleTab();
         this.FUITab.SwithTagManual(0);
         this.RoleTabOnSwitch(0);
         this.UpdateView();
      }
      
      protected function RoleTabOnSwitch(param1:Object) : void
      {
         this.FRoleIndex = param1 as int;
         this.FRoleIndex += this.FPageIndexHeroList * SIX;
         this.SligeEquipSetValue();
      }
      
      private function HeroListPageOnChange(param1:Object, param2:int) : void
      {
         this.FPageIndexHeroList = param2;
         this.UpdateRoleTab();
         this.FUITab.SwithTagManual(0);
         this.RoleTabOnSwitch(0);
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
         while(_loc1_ < SIX)
         {
            _loc5_ = this.FPageIndexHeroList * SIX + _loc1_;
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
      
      protected function SligeEquipSetValue() : void
      {
         var _loc1_:* = 0;
         var _loc2_:uint = 0;
         var _loc3_:TSingleEquip = null;
         var _loc4_:TInventory = null;
         var _loc5_:THero = null;
         var _loc6_:uint = 0;
         _loc2_ = this.FMC_SingleEquipList.length;
         _loc1_ = int(_loc2_ - 1);
         while(_loc1_ > -1)
         {
            _loc3_ = this.FMC_SingleEquipList[_loc1_];
            _loc3_.StubReferences.Dereference(this);
            _loc1_--;
         }
         this.FMC_SingleEquipList.length = 0;
         if(this.FRoleIndex >= this.FCharacter.Heros.Count)
         {
            _loc2_ = uint(this.FCharacter.Treasures.Count);
            this.FCurHeroid = 0;
         }
         else
         {
            _loc5_ = this.FCharacter.Heros.GetHeroByIndex(this.FRoleIndex);
            _loc2_ = uint(_loc5_.TalismansMounted.Capacity);
            this.FCurHeroid = _loc5_.Identifier;
         }
         this.FScrollBar.Clear();
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(this.FRoleIndex >= this.FCharacter.Heros.Count)
            {
               _loc4_ = this.FCharacter.Treasures.GetInventoryByIndex(_loc1_);
            }
            else
            {
               _loc4_ = _loc5_.TalismansMounted.GetInventoryByIndex(_loc1_);
            }
            if(_loc4_ != null && this.GetBoo(_loc4_))
            {
               _loc3_ = SLogicsCore.PoolUISingleEquipment.AcquireUISingleEquipment(this);
               _loc3_.StubReferences.Reference(this);
               _loc3_.OnClick = this.SingleEquipOnClick;
               _loc3_.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
               _loc3_.OnQueryEuqipLevel = this.SlotsOnQueryEuqipLevel;
               _loc3_.OnOut = this.SlotsOnOut;
               _loc3_.OnOver = this.SlotsOnMove;
               this.FMC_SingleEquipList.push(_loc3_);
               _loc3_.BSelect = false;
               _loc3_.SetEquip(_loc4_,_loc4_.Name,STRING_TALISMAN.STRINGS_TalismanUpgrade + _loc4_.UpgradingLevel,_loc4_.Quality);
               this.FScrollBar.AddItem(_loc3_);
               _loc6_++;
            }
            _loc1_++;
         }
         if(_loc6_ < CONST_TALISMAN.CAPACITY_EQUIP || _loc6_ == 0)
         {
            _loc2_ = CONST_TALISMAN.CAPACITY_EQUIP;
            _loc1_ = 0;
            while(_loc1_ < _loc2_ - _loc6_)
            {
               _loc3_ = SLogicsCore.PoolUISingleEquipment.AcquireUISingleEquipment(this);
               this.FScrollBar.AddItem(_loc3_);
               _loc1_++;
            }
         }
         this.FScrollBar.ScrollToUp();
      }
      
      protected function GetBoo(param1:TInventory) : Boolean
      {
         var _loc2_:TLostsacredGenerate = null;
         _loc2_ = SLogicsCore.LostShenQiLogicData.LostsacredGenerateBins.GetDatebaseByIdentifier(param1.IDTemplate) as TLostsacredGenerate;
         if(_loc2_)
         {
            if(param1.UpgradingLevel >= _loc2_.NeedTreasurelevel)
            {
               return true;
            }
         }
         return false;
      }
      
      protected function SetupHeroListPage() : void
      {
         this.FUIPageHeroList.TotalQuantity = this.FCharacter.Heros.Count;
         this.FUIPageHeroList.Update();
         this.FUIPageHeroList.PageIndex = this.FPageIndexHeroList;
      }
      
      public function UpdateView() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:TLostsacredGenerate = null;
         var _loc5_:TInventory = null;
         var _loc6_:TBins = null;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         _loc2_ = this.FMC_SingleEquipList.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            this.FMC_SingleEquipList[_loc3_].BClick = false;
            _loc3_++;
         }
         if(this.CurSingleEquip)
         {
            this.CurSingleEquip.BSelect = true;
         }
         if(this.CurInventory)
         {
            _loc6_ = this.FLostShenQiLogicData.LostsacredGenerateBins;
            _loc4_ = _loc6_.GetDatebaseByIdentifier(this.CurInventory.IDTemplate) as TLostsacredGenerate;
            this.TempInventories.Clear();
            this.IDTemplates.length = 0;
            this.IDTemplates.push(_loc4_.ArtifactId);
            this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,this.TempInventories,this.IDTemplates);
            this.FMC_RightSlot.Context = this.TempInventories.GetInventoryByIndex(0);
            this.TempInventoriesCopy.Clear();
            this.IDTemplates.length = 0;
            this.IDTemplates.push(this.FLostShenQiLogicData.LostJadeId);
            this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,this.TempInventoriesCopy,this.IDTemplates);
            this.FMC_Slot_0.Context = this.CurInventory;
            this.FMC_Slot_0.SetNum(1,1,6750003);
            _loc5_ = this.TempInventoriesCopy.GetInventoryByIndex(0);
            this.FMC_Slot_1.Context = _loc5_;
            _loc8_ = this.FLostShenQiLogicData.LostJadeNum;
            _loc1_ = _loc8_ >= _loc4_.CostlostItemCount ? true : false;
            _loc7_ = _loc1_ ? 6750003 : 16711680;
            this.FMC_Slot_1.SetNum(_loc8_,_loc4_.CostlostItemCount,_loc7_);
         }
         else
         {
            this.FMC_Slot_0.Context = null;
            this.FMC_Slot_1.Context = null;
            this.FMC_Slot_0.SetNum(0,0,16777215,true);
            this.FMC_Slot_1.SetNum(0,0,16777215,true);
            this.FMC_LeftSlot.Context = null;
            this.FMC_RightSlot.Context = null;
         }
         TGameUtil.setButtonMode(this.FMC_MakeBtn,_loc1_);
      }
      
      public function UiLocations() : void
      {
         this.FMC_MakeBtn.addEventListener(MouseEvent.CLICK,this.BtnClick);
      }
      
      public function LogicsUpdate() : void
      {
         var _loc1_:int = 0;
         if(this.FIsInilization)
         {
            _loc1_ = 0;
            while(_loc1_ < this.FMC_SingleEquipList.length)
            {
               this.FMC_SingleEquipList[_loc1_].UpdateSingleEquip();
               _loc1_++;
            }
            this.FMC_LeftSlot.Update();
            this.FMC_RightSlot.Update();
            this.FMC_Slot_0.Update();
            this.FMC_Slot_1.Update();
         }
      }
      
      protected function CurShengJiSlotOnClick(param1:Object, param2:Object) : void
      {
         this.CurSingleEquip.BSelect = false;
         this.CurInventory = null;
         this.CurSingleEquip = null;
         this.SlotsOnOut(param1,param2 as TInventory);
         this.UpdateView();
      }
      
      public function RestDate() : void
      {
         if(this.CurSingleEquip)
         {
            this.CurSingleEquip.BSelect = false;
            this.CurSingleEquip = null;
         }
         this.CurInventory = null;
         this.SligeEquipSetValue();
      }
      
      protected function SingleEquipOnClick(param1:Object, param2:Object) : void
      {
         this.CurInventory = param2 as TInventory;
         this.CurSingleEquip = param1 as TSingleEquip;
         this.FMC_LeftSlot.Context = this.CurInventory;
         this.UpdateView();
      }
      
      protected function BtnClick(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case this.FMC_MakeBtn:
               if(!this.FMC_MakeBtn.buttonMode)
               {
                  return;
               }
               if(this.FMakeBtnFunction != null)
               {
                  this.FMakeBtnFunction(this.CurInventory,this.FCurHeroid);
               }
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
            _loc6_.LoadSecondary(_loc5_.IDTexture,CONST_MODULES.MODULE_LostShenQi);
         }
      }
      
      protected function SlotsOnQueryEuqipLevel(param1:Object, param2:Object, param3:TQueryString) : void
      {
         var _loc4_:TInventory = null;
         _loc4_ = param2 as TInventory;
         if(_loc4_.UpgradingLevel > 0)
         {
            param3.Value = STRING_COMMON.FORMAT_Level + _loc4_.UpgradingLevel.toString();
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
      
      public function set OnInventoryOver(param1:Function) : void
      {
         this.FOnInventoryOver = param1;
      }
      
      public function set OnInventoryOut(param1:Function) : void
      {
         this.FOnInventoryOut = param1;
      }
      
      public function set MakeBtnFunction(param1:Function) : void
      {
         this.FMakeBtnFunction = param1;
      }
      
      protected function GetBooble() : Boolean
      {
         var _loc1_:TInventory = null;
         var _loc2_:uint = 0;
         if(!this.CurInventory)
         {
            return false;
         }
         _loc2_ = uint(SLogicsCore.Character.Appliances.GetAllCountByTempletID(this.FLostShenQiLogicData.LostJadeId));
         _loc1_ = this.FMC_Slot_1.Context as TInventory;
         if(_loc2_ < _loc1_.Quality)
         {
            return false;
         }
         return true;
      }
   }
}

