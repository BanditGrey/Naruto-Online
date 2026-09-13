package Processors.Game.Lobby.Mall.Components
{
   import Components.Slots.TUISlot;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.Inventories.TInventorySample;
   import Logics.SLogicsCore;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_MALL;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TUIMallItem extends TUIComponent
   {
      
      protected static const CurrentFrame_New:uint = 1;
      
      protected static const CurrentFrame_Hot:uint = 2;
      
      protected var FMallItem:MovieClip;
      
      protected var FTF_GoodsName:TextField;
      
      protected var FMC_HotOrNew:MovieClip;
      
      protected var FMC_SelectBox:Sprite;
      
      protected var FMC_Slot:TUISlot;
      
      protected var FMC_Price:Sprite;
      
      protected var FMC_SpecialPrice:Sprite;
      
      protected var FMC_NormalPrice:Sprite;
      
      protected var FMC_Bar:Sprite;
      
      protected var FTF_DiscountPrice:TextField;
      
      protected var FTF_VIPPrice:TextField;
      
      protected var FTF_NowPrice:TextField;
      
      protected var FTF_OriginalPrice:TextField;
      
      protected var FMC_Background:MovieClip;
      
      protected var FTF_NormalPrice:TextField;
      
      protected var FIsInitialization:Boolean;
      
      protected var FInventorySample:TInventorySample;
      
      protected var FMC_LookUp:MovieClip;
      
      protected var FItemOnClick:Function;
      
      protected var FSlotOnOut:Function;
      
      protected var FSlotOnOver:Function;
      
      protected var FOnQuerySequenceContext:Function;
      
      protected var FSubstrate:MovieClip;
      
      protected var FContext:Object;
      
      protected var FLookUpOnClick:Function;
      
      public function TUIMallItem(param1:TUIComponent)
      {
         super(param1);
         this.FIsInitialization = false;
      }
      
      protected function Resources_UIDispatch() : void
      {
         this.FMallItem = this.FSubstrate;
         this.FMC_Background = this.FMallItem[CONST_MALL.RESOURCE_Link_MC_Background];
         this.FTF_GoodsName = this.FMallItem[CONST_MALL.RESOURCE_Link_TF_GoodsName];
         this.FMC_HotOrNew = this.FMallItem[CONST_MALL.RESOURCE_Link_MC_HotOrNew];
         this.FMC_SelectBox = this.FMallItem[CONST_MALL.RESOURCE_Link_MC_SelectBox];
         this.FMC_Slot = new TUISlot(this);
         this.FMC_Slot.Resource = this.FMallItem[CONST_MALL.RESOURCE_Link_MC_Slot];
         this.FMC_Slot.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
         this.FMC_Slot.OnQuerySequenceContext = this.FOnQuerySequenceContext;
         this.FMC_Slot.OnOverlay = this.FSlotOnOver;
         this.FMC_Slot.OnOut = this.FSlotOnOut;
         this.FMC_Slot.Init();
         this.FMC_Price = this.FMallItem[CONST_MALL.RESOURCE_Link_MC_Price];
         if(this.FMC_Price != null)
         {
            this.FMC_SpecialPrice = this.FMC_Price[CONST_MALL.RESOURCE_Link_MC_SpecialPrice];
            this.FMC_Bar = this.FMC_SpecialPrice[CONST_MALL.RESOURCE_Link_MC_Bar];
            this.FTF_DiscountPrice = this.FMC_SpecialPrice[CONST_MALL.RESOURCE_Link_TF_DiscountPrice];
            this.FTF_VIPPrice = this.FMC_SpecialPrice[CONST_MALL.RESOURCE_Link_TF_VIPPrice];
            this.FTF_NowPrice = this.FMC_SpecialPrice[CONST_MALL.RESOURCE_Link_TF_NowPrice];
            this.FTF_OriginalPrice = this.FMC_SpecialPrice[CONST_MALL.RESOURCE_Link_TF_OriginalPrice];
            this.FMC_NormalPrice = this.FMC_Price[CONST_MALL.RESOURCE_Link_MC_NormalPrice];
            this.FTF_NormalPrice = this.FMC_NormalPrice[CONST_MALL.RESOURCE_Link_TF_NormallPrice];
         }
         else
         {
            this.FTF_NowPrice = this.FMallItem["TF_NowPrice"];
         }
         this.FMC_LookUp = this.FMallItem["MC_LookUp"];
         if(this.FMC_LookUp != null)
         {
            TGameUtil.setButtonMode(this.FMC_LookUp,true);
         }
      }
      
      protected function Resources_UILocations() : void
      {
         this.FMallItem.addEventListener(MouseEvent.MOUSE_OVER,this.ItemOnOver,false,0,true);
         this.FMallItem.addEventListener(MouseEvent.MOUSE_OUT,this.ItemOnOut,false,0,true);
         this.FMallItem.addEventListener(MouseEvent.MOUSE_DOWN,this.ItemOnDown,false,0,true);
         this.FMallItem.addEventListener(MouseEvent.MOUSE_UP,this.ItemOnUp,false,0,true);
         if(this.FMC_LookUp != null)
         {
            this.FMC_LookUp.addEventListener(MouseEvent.MOUSE_UP,this.MCLookUpOnClick,false,0,true);
         }
      }
      
      protected function Initialization() : void
      {
         if(this.FMC_SelectBox != null)
         {
            this.FMC_SelectBox.visible = false;
         }
         if(this.FTF_GoodsName != null)
         {
            this.FTF_GoodsName.mouseEnabled = false;
         }
         if(this.FTF_DiscountPrice != null)
         {
            this.FTF_DiscountPrice.mouseEnabled = false;
         }
         if(this.FTF_VIPPrice != null)
         {
            this.FTF_VIPPrice.mouseEnabled = false;
         }
         if(this.FTF_NowPrice != null)
         {
            this.FTF_NowPrice.mouseEnabled = false;
         }
         if(this.FTF_OriginalPrice != null)
         {
            this.FTF_OriginalPrice.mouseEnabled = false;
         }
      }
      
      protected function MCLookUpOnClick(param1:MouseEvent) : void
      {
         param1.stopImmediatePropagation();
         if(this.FLookUpOnClick != null)
         {
            this.FLookUpOnClick(this,this.FContext);
         }
      }
      
      protected function ItemOnOver(param1:MouseEvent) : void
      {
         this.FMC_SelectBox.visible = true;
         this.FMC_Background.gotoAndStop("over");
      }
      
      protected function ItemOnOut(param1:MouseEvent) : void
      {
         this.FMC_SelectBox.visible = false;
         this.FMC_Background.gotoAndStop("up");
      }
      
      protected function ItemOnDown(param1:MouseEvent) : void
      {
         this.FMC_Background.gotoAndStop("up");
      }
      
      protected function ItemOnUp(param1:MouseEvent) : void
      {
         this.FMC_SelectBox.visible = false;
         this.FMC_Background.gotoAndStop("up");
         if(this.FItemOnClick != null)
         {
            this.FItemOnClick(this,this.FContext);
         }
      }
      
      protected function UpdateMallItemInfo() : void
      {
         var _loc1_:uint = 0;
         if(this.FInventorySample.IsHot > this.FInventorySample.IsNew)
         {
            _loc1_ = CurrentFrame_Hot;
         }
         else if(this.FInventorySample.IsHot == this.FInventorySample.IsNew)
         {
            _loc1_ = 0;
         }
         else
         {
            _loc1_ = CurrentFrame_New;
         }
         if(_loc1_ != 0)
         {
            this.FMC_HotOrNew.gotoAndStop(_loc1_);
            this.FMC_HotOrNew.visible = true;
         }
         else
         {
            this.FMC_HotOrNew.visible = false;
         }
         this.FTF_GoodsName.text = this.FInventorySample.Name;
         this.FMC_Slot.Context = this.FInventorySample.Inventory;
         this.FMallItem.MC_Slot.TF_Subscript.text = this.FInventorySample.Amount.toString();
         this.SetPrice();
      }
      
      protected function SetPrice() : void
      {
         if(this.FInventorySample.IsNew == 1)
         {
            this.FMC_NormalPrice.visible = true;
            this.FMC_SpecialPrice.visible = false;
            this.FTF_NormalPrice.text = this.FInventorySample.CostGold.toString();
         }
         else
         {
            this.FMC_NormalPrice.visible = false;
            this.FMC_SpecialPrice.visible = true;
            this.FTF_OriginalPrice.text = this.FInventorySample.CostGold.toString();
            if(this.FInventorySample.IsHot == 1)
            {
               this.FMC_Bar.visible = true;
               this.FTF_NowPrice.text = this.FInventorySample.HotPrice.toString();
               this.FTF_DiscountPrice.visible = true;
               this.FTF_VIPPrice.visible = false;
            }
            else
            {
               if(this.FInventorySample.VipLevel <= SLogicsCore.Character.VipLevel)
               {
                  this.FMC_Bar.visible = true;
                  this.FTF_DiscountPrice.visible = false;
                  this.FTF_VIPPrice.visible = true;
               }
               else
               {
                  this.FMC_Bar.visible = false;
                  this.FTF_DiscountPrice.visible = false;
                  this.FTF_VIPPrice.visible = true;
               }
               this.FTF_NowPrice.text = this.FInventorySample.Discount.toString();
            }
         }
      }
      
      protected function UpdataPvpMallUI() : void
      {
         this.FTF_GoodsName.text = this.FInventorySample.Name;
         this.FMC_Slot.Context = this.FInventorySample.Inventory;
         this.FTF_NowPrice.text = this.FInventorySample.Integration.toString();
         if(this.FMallItem.MC_Slot.TF_Subscript)
         {
            this.FMallItem.MC_Slot.TF_Subscript.text = this.FInventorySample.Amount.toString();
         }
         this.FMC_LookUp.visible = this.FInventorySample.Page == 3;
      }
      
      protected function UpdateKingBattleMallInfo() : void
      {
         this.FTF_GoodsName.text = this.FInventorySample.Name;
         this.FMC_Slot.Context = this.FInventorySample.Inventory;
         this.FTF_NowPrice.text = this.FInventorySample.Integration.toString();
         if(this.FMallItem.MC_Slot.TF_Subscript)
         {
            this.FMallItem.MC_Slot.TF_Subscript.text = this.FInventorySample.Amount.toString();
         }
         this.FMC_LookUp.visible = this.FInventorySample.Page == 2;
      }
      
      public function get ItemOnClick() : Function
      {
         return this.FItemOnClick;
      }
      
      public function set ItemOnClick(param1:Function) : void
      {
         this.FItemOnClick = param1;
      }
      
      public function get SlotOnOut() : Function
      {
         return this.FSlotOnOut;
      }
      
      public function set SlotOnOut(param1:Function) : void
      {
         this.FSlotOnOut = param1;
      }
      
      public function get SlotOnOver() : Function
      {
         return this.FSlotOnOver;
      }
      
      public function set SlotOnOver(param1:Function) : void
      {
         this.FSlotOnOver = param1;
      }
      
      public function get OnQuerySequenceContext() : Function
      {
         return this.FOnQuerySequenceContext;
      }
      
      public function set OnQuerySequenceContext(param1:Function) : void
      {
         this.FOnQuerySequenceContext = param1;
      }
      
      public function get Substrate() : MovieClip
      {
         return this.FSubstrate;
      }
      
      public function set Substrate(param1:MovieClip) : void
      {
         this.FSubstrate = param1;
      }
      
      public function get Context() : Object
      {
         return this.FContext;
      }
      
      public function set Context(param1:Object) : void
      {
         this.FContext = param1;
      }
      
      public function set LookUpOnClick(param1:Function) : void
      {
         this.FLookUpOnClick = param1;
      }
      
      public function Perform_UIDispatch() : void
      {
         this.Resources_UIDispatch();
         this.Resources_UILocations();
         this.FIsInitialization = true;
      }
      
      public function Init() : void
      {
         if(!this.FIsInitialization)
         {
            return;
         }
         this.Initialization();
      }
      
      public function SetMallItemInfo() : void
      {
         this.FInventorySample = this.FContext as TInventorySample;
         if(this.FInventorySample == null)
         {
            return;
         }
         this.UpdateMallItemInfo();
      }
      
      public function UpdataPvpMallInfo() : void
      {
         this.FInventorySample = this.FContext as TInventorySample;
         if(this.FInventorySample == null)
         {
            return;
         }
         this.UpdataPvpMallUI();
      }
      
      public function SetKingBattleMallInfo() : void
      {
         this.FInventorySample = this.FContext as TInventorySample;
         if(this.FInventorySample == null)
         {
            return;
         }
         this.UpdateKingBattleMallInfo();
      }
      
      public function UpdateSlot() : void
      {
         this.FMC_Slot.Update();
      }
   }
}

