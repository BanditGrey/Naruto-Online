package Processors.Game.Lobby.Exercise.TowerLottery.Compoents
{
   import Components.Pages.TUIPage;
   import Components.Slots.TUISlot;
   import Foundation.Queries.TQueryString;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Resources.Repositories.TResourceRepositoryTexture;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Resources.Textures.TTexture;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.Inventories.TAppliance;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_MODULES;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   
   public class TUILotteryBox extends TUIComponent
   {
      
      public static const NONE_FILTERS:int = 0;
      
      public static const GARY_COLOR_FILTERS:int = 1;
      
      public static const HIGH_LIGHT_FILTERS:int = 2;
      
      protected var FMC_Scene:MovieClip;
      
      protected var FSlotList:Vector.<TUISlot>;
      
      protected var FShineList:Vector.<MovieClip>;
      
      protected var FCountList:Vector.<MovieClip>;
      
      protected var FUIPage:TUIPage;
      
      protected var FInventories:TInventories;
      
      protected var FInitialized:Boolean;
      
      protected var FBoxCount:int;
      
      protected var FOnQuerySequenceContext:Function;
      
      protected var FOnOverlay:Function;
      
      protected var FOnOut:Function;
      
      protected var FOnQuerySubscript:Function;
      
      protected var FOnGetBox:Function;
      
      public function TUILotteryBox(param1:TUIComponent, param2:int)
      {
         super(param1);
         this.FBoxCount = param2;
         this.FSlotList = new Vector.<TUISlot>(this.FBoxCount);
         this.FShineList = new Vector.<MovieClip>(this.FBoxCount);
         this.FCountList = new Vector.<MovieClip>(this.FBoxCount);
      }
      
      protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         this.FMC_Scene = param1;
         this.Resources_UIDispatchBox();
      }
      
      protected function Resources_UIDispatchBox() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUISlot = null;
         _loc1_ = 0;
         while(_loc1_ < this.FBoxCount)
         {
            _loc3_ = new TUISlot(this);
            _loc3_.Resource = this.FMC_Scene["MC_Slot" + _loc1_]["MC_Slot"] as Sprite;
            _loc3_.Resource.visible = false;
            _loc3_.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
            _loc3_.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
            _loc3_.OnQuerySubscript = this.SlotsOnQuerySubscript;
            _loc3_.OnOverlay = this.SlotsOnOver;
            _loc3_.OnOut = this.SlotsOnOut;
            _loc3_.Init();
            this.FSlotList[_loc1_] = _loc3_;
            this.FShineList[_loc1_] = this.FMC_Scene["MC_Slot" + _loc1_]["MC_Shine"];
            this.FShineList[_loc1_].visible = false;
            this.FCountList[_loc1_] = this.FMC_Scene["MC_Slot" + _loc1_]["MC_Count"];
            this.FCountList[_loc1_].visible = false;
            _loc1_++;
         }
      }
      
      protected function UpdateBox() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TInventory = null;
         _loc1_ = 0;
         while(_loc1_ < this.FBoxCount)
         {
            if(_loc1_ < this.FInventories.Count)
            {
               _loc3_ = this.FInventories.GetInventoryByIndex(_loc1_);
               this.FSlotList[_loc1_].Context = _loc3_;
               this.FSlotList[_loc1_].Resource.visible = true;
            }
            else
            {
               this.FSlotList[_loc1_].Resource.visible = false;
            }
            _loc1_++;
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
      
      protected function SlotsOnOver(param1:Object, param2:Object) : void
      {
         if(this.FOnOverlay != null)
         {
            this.FOnOverlay(this,param2);
         }
      }
      
      protected function SlotsOnOut(param1:Object, param2:Object) : void
      {
         if(this.FOnOut != null)
         {
            this.FOnOut(this,param2);
         }
      }
      
      public function get OnQuerySequenceContext() : Function
      {
         return this.FOnQuerySequenceContext;
      }
      
      public function set OnQuerySequenceContext(param1:Function) : void
      {
         this.FOnQuerySequenceContext = param1;
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
      
      public function get OnQuerySubscript() : Function
      {
         return this.FOnQuerySubscript;
      }
      
      public function set OnQuerySubscript(param1:Function) : void
      {
         this.FOnQuerySubscript = param1;
      }
      
      public function Perform_UIDispatch(param1:MovieClip) : void
      {
         this.Resources_UIDispatch(param1);
         this.FInitialized = true;
      }
      
      public function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         if(this.FInitialized && this.visible)
         {
            _loc2_ = this.FSlotList.length;
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               this.FSlotList[_loc1_].Update();
               _loc1_++;
            }
         }
      }
      
      public function UpdateUI(param1:TInventories) : void
      {
         this.FInventories = param1;
         this.UpdateBox();
      }
      
      public function SetVisible(param1:Boolean) : void
      {
         this.FMC_Scene.visible = param1;
      }
      
      public function SetHighLightFilters(param1:Boolean) : void
      {
         if(param1)
         {
            this.FMC_Scene.filters = [TGameUtil.highLightFilters];
         }
         else
         {
            this.FMC_Scene.filters = [];
         }
      }
      
      public function SetGaryFilters(param1:Boolean) : void
      {
         if(param1)
         {
            this.FMC_Scene.filters = [TGameUtil.GaryColorFilters];
         }
         else
         {
            this.FMC_Scene.filters = [];
         }
      }
      
      public function SetSlotFiltersByIndex(param1:int, param2:int) : void
      {
         switch(param2)
         {
            case NONE_FILTERS:
               this.FSlotList[param1].SetHighLightFilters(false);
               break;
            case HIGH_LIGHT_FILTERS:
               this.FSlotList[param1].SetHighLightFilters(true);
               break;
            case GARY_COLOR_FILTERS:
               this.FSlotList[param1].SetGaryFilters(true);
         }
      }
      
      public function SetSlotIsShine(param1:int, param2:Boolean, param3:Boolean) : void
      {
         this.FShineList[param1].visible = param2;
         if(param3)
         {
            this.FShineList[param1].gotoAndPlay(1);
         }
         else
         {
            this.FShineList[param1].gotoAndStop(1);
         }
      }
      
      public function SetCountByIndex(param1:int, param2:int = 0) : void
      {
         if(param2 > 0)
         {
            this.FCountList[param1].visible = true;
         }
         else
         {
            this.FCountList[param1].visible = false;
         }
      }
   }
}

