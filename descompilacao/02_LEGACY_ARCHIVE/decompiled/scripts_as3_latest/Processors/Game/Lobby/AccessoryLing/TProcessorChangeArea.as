package Processors.Game.Lobby.AccessoryLing
{
   import Components.Pages.TUIPage;
   import Foundation.Network.TPacket;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.DatebaseVO.VO.TOrnamentIngredientExchange;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Resources.Constants.CONST_ACCESSORY_INTENSITY;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Strings.STRING_HEROS;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorChangeArea extends Sprite
   {
      
      public static const STUFFCOUNT:int = 18;
      
      public static const BRFORE_NEXT:int = 2;
      
      protected var FChangePanel:MovieClip = null;
      
      protected var FUISlots:Vector.<TSoltCell> = null;
      
      protected var FUISlotsTwo:Vector.<TSoltCell> = null;
      
      protected var FTF_Level_Call:TextField = null;
      
      protected var FTF_RequiLevel:TextField = null;
      
      protected var FStuffPage:TUIPage;
      
      protected var FStuffPageIndex:int = 0;
      
      protected var FStuffCountIndex:int = 0;
      
      protected var parentPanel:TUIComponent;
      
      protected var FIsInitilization:Boolean = false;
      
      protected var FIsNeedExecute:Boolean = false;
      
      protected var MaterialInventorys:Vector.<TInventory>;
      
      protected var UnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FSelectInventories:TInventories;
      
      protected var FTempSelectInventoriesId:Vector.<uint>;
      
      protected var FSlotsOnQuerySequenceContext:Function = null;
      
      protected var FApplianceOnOver:Function = null;
      
      protected var FApplianceOnOut:Function = null;
      
      protected var FChangeBtnFunction:Function = null;
      
      protected var FExChangeTip:Function = null;
      
      protected var FCurrentIntensity:TInventory = null;
      
      protected var IsCanCliskChangeBtn:Boolean = false;
      
      protected var CurChangeMaterial:TInventory = null;
      
      public function TProcessorChangeArea(param1:TUIComponent)
      {
         super();
         this.FUISlots = new Vector.<TSoltCell>(STUFFCOUNT);
         this.FUISlotsTwo = new Vector.<TSoltCell>(BRFORE_NEXT);
         this.FStuffPage = new TUIPage(null);
         this.parentPanel = param1;
         this.UnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         this.FSelectInventories = new TInventories();
         this.FTempSelectInventoriesId = new Vector.<uint>();
         this.MaterialInventorys = new Vector.<TInventory>();
      }
      
      public function set ExChangeTip(param1:Function) : void
      {
         this.FExChangeTip = param1;
      }
      
      public function set IsVisible(param1:Boolean) : void
      {
         if(this.FChangePanel)
         {
            this.FChangePanel.visible = param1;
         }
      }
      
      public function UIPerformFill(param1:MovieClip) : void
      {
         var _loc4_:int = 0;
         this.FChangePanel = param1;
         var _loc2_:TextField = null;
         TGameUtil.setButtonMode(this.FChangePanel[CONST_ACCESSORY_INTENSITY.INTENSITY_PagingChange_MC_ChangeBtn],true);
         this.FTF_Level_Call = this.FChangePanel[CONST_ACCESSORY_INTENSITY.INTENSITY_PagingChange_HoleCount];
         this.FTF_RequiLevel = this.FChangePanel[CONST_ACCESSORY_INTENSITY.INTENSITY_PagingChange_Requip];
         MovieClip(this.FChangePanel[CONST_ACCESSORY_INTENSITY.INTENSITY_PagingChange_MC_ChangeBtn]).addEventListener(MouseEvent.CLICK,this.ChangeBtnClick);
         var _loc3_:TSoltCell = null;
         _loc4_ = 0;
         while(_loc4_ < STUFFCOUNT)
         {
            _loc3_ = this.GetSlotCell();
            _loc3_.Resource = this.FChangePanel[CONST_ACCESSORY_INTENSITY.INTENSITY_PagingChange_Slot_ + _loc4_];
            _loc3_.OnQuerySequenceContext = this.OnQuerySequenceContext;
            _loc3_.Init();
            _loc3_.OnOverlay = this.ApplianceOver;
            _loc3_.OnOut = this.ApplianceOut;
            _loc3_.OnClick = this.ApplianceClick;
            this.FUISlots[_loc4_] = _loc3_;
            _loc4_++;
         }
         _loc4_ = 0;
         while(_loc4_ < BRFORE_NEXT)
         {
            _loc3_ = this.GetSlotCell();
            _loc3_.Resource = this.FChangePanel[CONST_ACCESSORY_INTENSITY.INTENSITY_PagingChange_Slot_Two + _loc4_];
            _loc3_.OnQuerySequenceContext = this.OnQuerySequenceContext;
            _loc3_.Init();
            _loc3_.OnOverlay = this.ApplianceOver;
            _loc3_.OnOut = this.ApplianceOut;
            this.FUISlotsTwo[_loc4_] = _loc3_;
            _loc4_++;
         }
         this.FStuffPage.ButtonPrevious.Substrate = this.FChangePanel[CONST_ACCESSORY_INTENSITY.INTENSITY_PagingChange_ChangeListPage][CONST_ACCESSORY_INTENSITY.INTENSITY_PageLeft];
         this.FStuffPage.ButtonNext.Substrate = this.FChangePanel[CONST_ACCESSORY_INTENSITY.INTENSITY_PagingChange_ChangeListPage][CONST_ACCESSORY_INTENSITY.INTENSITY_PageRight];
         _loc2_ = this.FChangePanel[CONST_ACCESSORY_INTENSITY.INTENSITY_PagingChange_ChangeListPage][CONST_ACCESSORY_INTENSITY.INTENSITY_Page];
         this.FStuffPage.LabelPage = _loc2_;
         _loc2_.text = "0/0";
         this.FStuffPage.PageSize = STUFFCOUNT;
         this.FStuffPage.Init();
         this.FStuffPage.OnChangePage = this.StuffPageOnChange;
         this.FIsInitilization = true;
      }
      
      protected function SetStateChangeBtn(param1:Boolean) : void
      {
         TGameUtil.setButtonMode(this.FChangePanel[CONST_ACCESSORY_INTENSITY.INTENSITY_PagingChange_MC_ChangeBtn],param1);
      }
      
      protected function StuffPageOnChange(param1:Object, param2:int) : void
      {
         this.FStuffPageIndex = param2;
         this.LoaderMaterial();
      }
      
      public function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         if(this.FIsInitilization && this.FIsNeedExecute)
         {
            _loc1_ = 0;
            while(_loc1_ < STUFFCOUNT)
            {
               this.FUISlots[_loc1_].Update();
               _loc1_++;
            }
            _loc1_ = 0;
            while(_loc1_ < BRFORE_NEXT)
            {
               this.FUISlotsTwo[_loc1_].Update();
               _loc1_++;
            }
         }
      }
      
      public function ChangeBtnClick(param1:MouseEvent) : void
      {
         if(this.IsCanCliskChangeBtn)
         {
            this.FChangeBtnFunction(this.CurChangeMaterial);
         }
      }
      
      protected function GetSlotCell() : TSoltCell
      {
         var _loc1_:TSoltCell = null;
         _loc1_ = new TSoltCell(this.parentPanel);
         _loc1_.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
         return _loc1_;
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
      
      public function set CurrentIntensity(param1:TInventory) : void
      {
         this.FCurrentIntensity = param1;
      }
      
      public function UpdateIntensity(param1:TPacket, param2:int = 0) : void
      {
         var _loc4_:int = 0;
         var _loc5_:TOrnamentIngredientExchange = null;
         var _loc3_:uint = uint(SLogicsCore.Character.GetMainHero().Level);
         if(this.FCurrentIntensity == null)
         {
            this.FilterMaterial();
            this.LoaderMaterial();
            this.SetNullThis();
            return;
         }
         this.FilterMaterial();
         this.LoaderMaterial();
         _loc4_ = 0;
         while(_loc4_ < this.MaterialInventorys.length)
         {
            if(this.MaterialInventorys[_loc4_].IDTemplate == this.FCurrentIntensity.IDTemplate)
            {
               this.FCurrentIntensity = this.MaterialInventorys[_loc4_];
               break;
            }
            _loc4_++;
         }
         if(this.FCurrentIntensity.UpgradingLevel >= _loc3_)
         {
            this.FilterMaterial();
            this.LoaderMaterial();
            this.SetNullThis();
            this.FExChangeTip(STRING_HEROS.STRING_MoutedIntensity);
            return;
         }
         this.FTF_Level_Call.visible = true;
         this.FTF_RequiLevel.visible = true;
         this.SetStateChangeBtn(true);
         this.IsCanCliskChangeBtn = true;
         this.FSelectInventories.Clear();
         this.FTempSelectInventoriesId.length = 0;
         this.CurChangeMaterial = this.FCurrentIntensity;
         _loc5_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_OrnamentIngredientExchange,this.FCurrentIntensity.IDTemplate) as TOrnamentIngredientExchange;
         var _loc6_:int = this.getInventoryById(this.FCurrentIntensity);
         var _loc7_:int = _loc5_.Expend;
         if(param2)
         {
            if(_loc6_ < _loc7_)
            {
               this.FCurrentIntensity = null;
               this.FilterMaterial();
               this.LoaderMaterial();
               this.SetNullThis();
               this.IsCanCliskChangeBtn = false;
               return;
            }
         }
         this.FTF_Level_Call.text = String(_loc5_.Level);
         if(_loc3_ < _loc5_.Level)
         {
            this.FTF_Level_Call.textColor = 16724736;
            this.FTF_RequiLevel.textColor = 16724736;
         }
         else
         {
            this.FTF_Level_Call.textColor = 65280;
            this.FTF_RequiLevel.textColor = 65280;
         }
         this.FUISlotsTwo[0].Context = this.FCurrentIntensity;
         this.FUISlotsTwo[0].MaterialCount(_loc6_,_loc7_,true);
         if(!_loc6_)
         {
            this.FUISlotsTwo[0].SetDefaultFilters(true);
            this.IsCanCliskChangeBtn = false;
            this.SetStateChangeBtn(false);
         }
         else
         {
            this.FUISlotsTwo[0].SetDefaultFilters(false);
         }
         if(_loc6_ < _loc7_ || _loc3_ < _loc5_.Level)
         {
            this.FUISlotsTwo[1].SetDefaultFilters(true);
            this.IsCanCliskChangeBtn = false;
            this.SetStateChangeBtn(false);
         }
         else
         {
            this.FUISlotsTwo[1].SetDefaultFilters(false);
         }
         this.FTempSelectInventoriesId.push(_loc5_.GotIngredientId);
         this.UnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,this.FSelectInventories,this.FTempSelectInventoriesId);
         this.FUISlotsTwo[1].Context = this.FSelectInventories.GetInventoryByIndex(0);
      }
      
      protected function getInventoryById(param1:TInventory) : int
      {
         var _loc2_:TInventories = SLogicsCore.Character.Materials;
         return _loc2_.GetAllCountByTempletID(param1.IDTemplate);
      }
      
      protected function ApplianceClick(param1:Object, param2:Object) : void
      {
         var _loc3_:TInventory = param2 as TInventory;
         this.FCurrentIntensity = _loc3_;
         this.UpdateIntensity(null);
      }
      
      public function FilterMaterial() : void
      {
         var _loc3_:TInventory = null;
         var _loc5_:TOrnamentIngredientExchange = null;
         this.MaterialInventorys.length = 0;
         var _loc1_:int = 0;
         var _loc2_:TInventories = SLogicsCore.Character.Materials;
         var _loc4_:int = _loc2_.Count;
         _loc1_ = 0;
         while(_loc1_ < _loc4_)
         {
            _loc3_ = _loc2_.GetInventoryByIndex(_loc1_);
            if(_loc3_.Category == 5)
            {
               _loc5_ = null;
               _loc5_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_OrnamentIngredientExchange,_loc3_.IDTemplate) as TOrnamentIngredientExchange;
               if(_loc5_)
               {
                  this.MaterialInventorys.push(_loc3_);
               }
            }
            _loc1_++;
         }
      }
      
      public function LoaderMaterial() : void
      {
         var _loc3_:int = 0;
         var _loc1_:int = 0;
         var _loc2_:Number = Number(this.MaterialInventorys.length);
         _loc1_ = 0;
         while(_loc1_ < STUFFCOUNT)
         {
            _loc3_ = _loc1_ + this.FStuffPageIndex * STUFFCOUNT;
            if(_loc3_ > _loc2_ - 1)
            {
               this.FUISlots[_loc1_].Context = null;
               this.FUISlots[_loc1_].MaterialCount(0);
            }
            else
            {
               this.FUISlots[_loc1_].Context = this.MaterialInventorys[_loc3_];
               this.FUISlots[_loc1_].MaterialCount(this.MaterialInventorys[_loc3_].Quantity,0,false);
            }
            _loc1_++;
         }
         this.UpdateHeroUIPage();
      }
      
      protected function UpdateHeroUIPage() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Number = NaN;
         var _loc3_:int = 0;
         this.FStuffPage.TotalQuantity = this.MaterialInventorys.length;
         this.FStuffPage.PageIndex = this.FStuffPageIndex;
         this.FStuffPage.Update();
         if(this.FStuffPage.PageIndex >= this.FStuffPage.TotalPage)
         {
            this.FStuffPageIndex = this.FStuffPage.TotalPage - 1;
            if(this.FStuffPageIndex <= 0)
            {
               this.FStuffPageIndex = 0;
            }
            this.FStuffPage.PageIndex = this.FStuffPageIndex;
            this.FStuffPage.Update();
            _loc1_ = 0;
            _loc2_ = Number(this.MaterialInventorys.length);
            _loc1_ = 0;
            while(_loc1_ < STUFFCOUNT)
            {
               _loc3_ = _loc1_ + this.FStuffPageIndex * STUFFCOUNT;
               if(_loc3_ > _loc2_ - 1)
               {
                  this.FUISlots[_loc1_].Context = null;
                  this.FUISlots[_loc1_].MaterialCount(0);
               }
               else
               {
                  this.FUISlots[_loc1_].Context = this.MaterialInventorys[_loc3_];
                  this.FUISlots[_loc1_].MaterialCount(this.MaterialInventorys[_loc3_].Quantity,0,false);
               }
               _loc1_++;
            }
         }
      }
      
      public function SetNullThis() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < BRFORE_NEXT)
         {
            this.FUISlotsTwo[_loc1_].Context = null;
            this.FUISlotsTwo[_loc1_].MaterialCount(0);
            _loc1_++;
         }
         this.FTF_Level_Call.text = "";
         this.SetStateChangeBtn(false);
         this.FTF_Level_Call.visible = false;
         this.FTF_RequiLevel.visible = false;
      }
      
      public function set ChangeBtnFunction(param1:Function) : void
      {
         this.FChangeBtnFunction = param1;
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
      
      public function set IsNeedExecute(param1:Boolean) : void
      {
         this.FIsNeedExecute = param1;
      }
   }
}

