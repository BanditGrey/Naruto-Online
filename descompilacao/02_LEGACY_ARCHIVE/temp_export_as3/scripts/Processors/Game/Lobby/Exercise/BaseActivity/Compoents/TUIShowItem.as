package Processors.Game.Lobby.Exercise.BaseActivity.Compoents
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
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TAppliance;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_MODULES;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class TUIShowItem extends TUIComponent
   {
      
      public static const NONE_FILTERS:int = 0;
      
      public static const GARY_COLOR_FILTERS:int = 1;
      
      public static const HIGH_LIGHT_FILTERS:int = 2;
      
      public var FMC_Scene:MovieClip;
      
      protected var FBoxCount:int;
      
      public var BoxIndex:int;
      
      protected var FSlotList:Vector.<TUISlot>;
      
      protected var FUIPage:TUIPage;
      
      protected var FInventories:TInventories;
      
      protected var FInitialized:Boolean;
      
      protected var FCurPage:int;
      
      protected var FTotalPage:int;
      
      public var QuantityStr:String;
      
      protected var FOnQuerySequenceContext:Function;
      
      protected var FOnOverlay:Function;
      
      protected var FOnOut:Function;
      
      protected var FOnClick:Function;
      
      protected var FOnQuerySubscript:Function;
      
      protected var FOnShowRecruit:Function;
      
      protected var FOnPageChange:Function;
      
      public function TUIShowItem(param1:TUIComponent, param2:int)
      {
         super(param1);
         this.FBoxCount = param2;
         this.FSlotList = new Vector.<TUISlot>(this.FBoxCount);
         this.FUIPage = new TUIPage(this);
         this.QuantityStr = "";
      }
      
      protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         this.FMC_Scene = param1;
         if(Boolean(this.FMC_Scene.Btn_Right) && Boolean(this.FMC_Scene.Btn_Left))
         {
            this.FUIPage.ButtonPrevious.Substrate = this.FMC_Scene.Btn_Left;
            this.FUIPage.ButtonNext.Substrate = this.FMC_Scene.Btn_Right;
            if(this.FMC_Scene.TF_Page)
            {
               this.FUIPage.LabelPage = this.FMC_Scene.TF_Page;
            }
            this.FUIPage.TotalQuantity = this.FTotalPage;
            this.FUIPage.PageSize = this.FBoxCount;
            this.FUIPage.PageIndex = 0;
            this.FCurPage = 0;
            this.FUIPage.OnChangePage = this.ProcessorPageOnChange;
         }
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
            _loc3_.Resource = this.FMC_Scene["MC_Slot" + _loc1_] as Sprite;
            _loc3_.Resource.visible = true;
            _loc3_.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
            _loc3_.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
            _loc3_.OnQuerySubscript = this.SlotsOnQuerySubscript;
            _loc3_.OnOverlay = this.SlotsOnOver;
            _loc3_.OnOut = this.SlotsOnOut;
            _loc3_.OnClick = this.SlotsOnClick;
            _loc3_.BoxIndex = _loc1_;
            _loc3_.Init();
            this.FSlotList[_loc1_] = _loc3_;
            if(this.FMC_Scene.MC_Got)
            {
               this.FMC_Scene.MC_Got.mouseEnabled = false;
            }
            if(this.FMC_Scene["MC_Slot" + _loc1_].BTN_ShowRecruit)
            {
               TGameUtil.setButtonMode(this.FMC_Scene["MC_Slot" + _loc1_].BTN_ShowRecruit,true);
               this.FMC_Scene["MC_Slot" + _loc1_].BTN_ShowRecruit.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowRecruit);
            }
            this.FMC_Scene.buttonMode = true;
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
            _loc2_ = _loc1_ + this.FCurPage * this.FBoxCount;
            if(Boolean(this.FInventories) && _loc2_ < this.FInventories.Count)
            {
               _loc3_ = this.FInventories.GetInventoryByIndex(_loc2_);
               this.FSlotList[_loc1_].Context = null;
               this.FSlotList[_loc1_].Context = _loc3_;
               this.FSlotList[_loc1_].Resource.visible = true;
               if(this.FMC_Scene["MC_Slot" + _loc1_].BTN_ShowRecruit)
               {
                  if(_loc3_.NewType == TBaseBox.TYPE_IS_HERO || _loc3_.NewType == TBaseBox.TYPE_IS_PET || _loc3_.NewType == TBaseBox.TYPE_IS_TITLE)
                  {
                     this.FMC_Scene["MC_Slot" + _loc1_].BTN_ShowRecruit.visible = true;
                  }
                  else
                  {
                     this.FMC_Scene["MC_Slot" + _loc1_].BTN_ShowRecruit.visible = false;
                  }
               }
               if(this.FMC_Scene["MC_Slot" + _loc1_].MC_GoldFire)
               {
                  if(_loc2_ == 0)
                  {
                     this.FMC_Scene["MC_Slot" + _loc1_].MC_GoldFire.visible = true;
                  }
                  else
                  {
                     this.FMC_Scene["MC_Slot" + _loc1_].MC_GoldFire.visible = false;
                  }
               }
               if(this.FMC_Scene["MC_Slot" + _loc1_].MC_Fire)
               {
                  if(_loc3_.ShowFire != 0)
                  {
                     this.FMC_Scene["MC_Slot" + _loc1_].MC_Fire.visible = true;
                  }
                  else
                  {
                     this.FMC_Scene["MC_Slot" + _loc1_].MC_Fire.visible = false;
                  }
               }
               if(this.FMC_Scene["MC_Slot" + _loc1_].TF_Price)
               {
                  this.FMC_Scene["MC_Slot" + _loc1_].TF_Price.text = _loc3_.MaxPrice;
               }
               if(this.FMC_Scene["MC_Slot" + _loc1_].TF_CurPrice)
               {
                  this.FMC_Scene["MC_Slot" + _loc1_].TF_CurPrice.text = _loc3_.MinPrice;
               }
               if(this.FMC_Scene["MC_Slot" + _loc1_].TF_LimitCount)
               {
                  if(_loc3_.LimitCount == -1)
                  {
                     this.FMC_Scene["MC_Slot" + _loc1_].TF_LimitCount.text = "";
                  }
                  else
                  {
                     this.FMC_Scene["MC_Slot" + _loc1_].TF_LimitCount.text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_LIMIT_COUNT,_loc3_.LimitCount);
                  }
               }
               if(this.FMC_Scene["MC_Slot" + _loc1_].TF_Sub)
               {
                  if(_loc3_.Quantity > 0)
                  {
                     this.FMC_Scene["MC_Slot" + _loc1_].TF_Sub.text = _loc3_.Quantity.toString();
                  }
                  else
                  {
                     this.FMC_Scene["MC_Slot" + _loc1_].TF_Sub.text = _loc3_.MinPrice + "—" + _loc3_.MaxPrice;
                  }
               }
            }
            else
            {
               this.FSlotList[_loc1_].Context = null;
               this.FSlotList[_loc1_].Resource.visible = true;
            }
            _loc1_++;
         }
      }
      
      protected function ProcessorPageOnChange(param1:Object, param2:int) : void
      {
         this.FCurPage = param2;
         this.UpdateBox();
         if(this.FOnPageChange != null)
         {
            this.FOnPageChange();
         }
      }
      
      protected function ProcessorOnShowRecruit(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TInventory = null;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         _loc3_ = _loc2_ + this.FCurPage * this.FBoxCount;
         if(this.FOnShowRecruit != null && _loc3_ < this.FInventories.Count)
         {
            _loc4_ = this.FInventories.GetInventoryByIndex(_loc3_);
            this.FOnShowRecruit(_loc4_.NewIdentify,_loc4_.NewType);
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
            if(this.QuantityStr == "")
            {
               param3.Value = _loc4_.Quantity.toString();
            }
            else
            {
               param3.Value = this.QuantityStr + "/" + _loc4_.Quantity;
            }
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
      
      protected function SlotsOnClick(param1:Object, param2:Object) : void
      {
         if(this.FOnClick != null)
         {
            this.FOnClick(this,param2);
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
      
      public function get OnClick() : Function
      {
         return this.FOnClick;
      }
      
      public function set OnClick(param1:Function) : void
      {
         this.FOnClick = param1;
      }
      
      public function get OnShowRecruit() : Function
      {
         return this.FOnShowRecruit;
      }
      
      public function set OnShowRecruit(param1:Function) : void
      {
         this.FOnShowRecruit = param1;
      }
      
      public function get OnPageChange() : Function
      {
         return this.FOnPageChange;
      }
      
      public function set OnPageChange(param1:Function) : void
      {
         this.FOnPageChange = param1;
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
         if(Boolean(this.FMC_Scene.Btn_Right) && Boolean(this.FMC_Scene.Btn_Left))
         {
            this.FUIPage.TotalQuantity = this.FInventories.Count;
            this.FUIPage.Update();
         }
         this.UpdateBox();
      }
      
      public function SetMCIsVisible(param1:String, param2:Boolean) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:TInventory = null;
         _loc3_ = 0;
         while(_loc3_ < this.FBoxCount)
         {
            if(this.FMC_Scene["MC_Slot" + _loc3_][param1])
            {
               this.FMC_Scene["MC_Slot" + _loc3_][param1].visible = param2;
            }
            _loc3_++;
         }
      }
      
      public function SetMCVisible(param1:String, param2:Boolean) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:TInventory = null;
         _loc3_ = 0;
         while(_loc3_ < this.FBoxCount)
         {
            if(this.FMC_Scene[param1])
            {
               this.FMC_Scene[param1].visible = param2;
            }
            _loc3_++;
         }
      }
      
      public function SetItemFilters(param1:int) : void
      {
         switch(param1)
         {
            case NONE_FILTERS:
               this.FMC_Scene.filters = [];
               break;
            case GARY_COLOR_FILTERS:
               this.FMC_Scene.filters = [TGameUtil.GaryColorFilters];
               break;
            case HIGH_LIGHT_FILTERS:
               this.FMC_Scene.filters = [TGameUtil.highLightFilters];
         }
      }
      
      public function ResetSlot() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         _loc2_ = this.FSlotList.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.FSlotList[_loc1_].Context = null;
            _loc1_++;
         }
      }
      
      public function SetDescText(param1:int, param2:String) : void
      {
         if(this.FMC_Scene["TF_Desc" + param1])
         {
            this.FMC_Scene["TF_Desc" + param1].text = param2;
         }
      }
      
      public function SetGetCount(param1:Boolean = false, param2:int = 0, param3:int = 0) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:MovieClip = null;
         if(Boolean(this.FMC_Scene["MC_Slot" + param2]) && Boolean(this.FMC_Scene["MC_Slot" + param2].MC_Get))
         {
            this.FMC_Scene["MC_Slot" + param2].MC_Get.visible = param1;
         }
         if(param3 != 0)
         {
            this.FMC_Scene["MC_Slot" + param2].MC_Get.visible = true;
            this.FMC_Scene["MC_Slot" + param2].MC_Get.TF_Count.text = param3.toString();
         }
      }
      
      public function SetSelected(param1:Boolean = false, param2:int = -1) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:MovieClip = null;
         _loc3_ = 0;
         while(_loc3_ < this.FBoxCount)
         {
            _loc5_ = this.FMC_Scene["MC_Slot" + _loc3_].MC_Selected;
            if(_loc5_)
            {
               _loc5_.visible = param1;
            }
            _loc3_++;
         }
         if(param2 != -1)
         {
            this.FMC_Scene["MC_Slot" + param2].MC_Selected.visible = true;
         }
      }
      
      public function SetSlotFilter() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TInventory = null;
         _loc1_ = 0;
         while(_loc1_ < this.FBoxCount)
         {
            _loc2_ = _loc1_ + this.FCurPage * this.FBoxCount;
            if(Boolean(this.FInventories) && _loc2_ < this.FInventories.Count)
            {
               this.FSlotList[_loc1_].Context;
               if(this.FSlotList[_loc1_].Context.Quantity <= 0)
               {
                  this.FSlotList[_loc1_].SetDefaultFilters(true);
               }
               else
               {
                  this.FSlotList[_loc1_].SetDefaultFilters(false);
               }
            }
            else
            {
               this.FSlotList[_loc1_].SetDefaultFilters(false);
            }
            _loc1_++;
         }
      }
   }
}

