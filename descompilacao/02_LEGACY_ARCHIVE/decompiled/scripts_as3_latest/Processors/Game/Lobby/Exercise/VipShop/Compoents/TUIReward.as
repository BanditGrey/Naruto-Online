package Processors.Game.Lobby.Exercise.VipShop.Compoents
{
   import Components.Pages.TUIPage;
   import Components.Slots.TUISlot;
   import Foundation.Common.THint;
   import Foundation.Queries.TQueryString;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Resources.Repositories.TResourceRepositoryTexture;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Resources.Textures.TTexture;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.Characters.TCharacter;
   import Logics.Exercise.VipShop.TVipBox;
   import Logics.Inventories.TAppliance;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Exercise.VipShop.TProcessorVipShop;
   import Rendering.Overlayers.Hints.TOverlayerHint;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_VIPSHOP;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class TUIReward extends TUIComponent
   {
      
      protected var BOX_COUNT:int = TProcessorVipShop.BOX_COUNT;
      
      protected var FMC_Scene:MovieClip;
      
      protected var FBTN_GetReward:MovieClip;
      
      protected var FUIPage:TUIPage;
      
      protected var FSlotList:Vector.<TUISlot>;
      
      protected var FIndex:int;
      
      protected var FVipBox:TVipBox;
      
      protected var FCurPage:int;
      
      protected var FOnQuerySequenceContext:Function;
      
      protected var FOnOverlay:Function;
      
      protected var FOnOut:Function;
      
      protected var FOnQuerySubscript:Function;
      
      protected var FOnGetReward:Function;
      
      protected var FOverlayerHint:TOverlayerHint;
      
      protected var FHintOnMove:Function;
      
      protected var FHintOnOut:Function;
      
      protected var FHint:THint;
      
      public function TUIReward(param1:TUIComponent)
      {
         super(param1);
         this.FSlotList = new Vector.<TUISlot>(this.BOX_COUNT);
      }
      
      protected function Initialization() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUISlot = null;
         this.FMC_Scene = TUtilityReflection.CreateDisplayObjectInstance(CONST_VIPSHOP.RESOURCE_ClassName_MC_VipShopItem) as MovieClip;
         addChild(this.FMC_Scene);
         _loc1_ = 0;
         while(_loc1_ < this.BOX_COUNT)
         {
            _loc3_ = new TUISlot(this);
            _loc3_.Resource = this.FMC_Scene[CONST_VIPSHOP.RESOURCE_Link_MC_Slot + _loc1_] as Sprite;
            _loc3_.Resource.visible = false;
            _loc3_.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
            _loc3_.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
            _loc3_.OnQuerySubscript = this.SlotsOnQuerySubscript;
            _loc3_.OnOverlay = this.SlotsOnOver;
            _loc3_.OnOut = this.SlotsOnOut;
            _loc3_.Init();
            this.FSlotList[_loc1_] = _loc3_;
            _loc1_++;
         }
         this.FUIPage = new TUIPage(this);
         this.FUIPage.ButtonPrevious.Substrate = this.FMC_Scene.Btn_Left;
         this.FUIPage.ButtonNext.Substrate = this.FMC_Scene.Btn_Right;
         this.FUIPage.TotalQuantity = 1;
         this.FUIPage.PageSize = this.BOX_COUNT;
         this.FUIPage.PageIndex = 0;
         this.FCurPage = 0;
         this.FUIPage.OnChangePage = this.ProcessorPageOnChange;
         this.UILocations();
      }
      
      protected function UILocations() : void
      {
         this.FMC_Scene.BTN_buy.addEventListener(MouseEvent.MOUSE_UP,this.ButtonBuyOnClick);
      }
      
      protected function UpdateContent() : void
      {
         this.FMC_Scene.mc_box.gotoAndStop(this.FIndex + 1);
         this.FMC_Scene.TF_VipLevel.text = "VIP" + this.FVipBox.VipLevel;
         this.FMC_Scene.TF_OriginalPrice.text = this.FVipBox.Price;
         this.FMC_Scene.TF_NowPrice.text = this.FVipBox.DiscountPrice;
         this.FMC_Scene.TF_Count.text = this.FVipBox.BoxCount - this.FVipBox.BuyCount + "/" + this.FVipBox.BoxCount;
      }
      
      protected function UpdateBtn() : void
      {
         var _loc1_:TCharacter = null;
         _loc1_ = SLogicsCore.Character;
         if(_loc1_.VipLevel >= this.FVipBox.VipLevel && this.FVipBox.BuyCount < this.FVipBox.BoxCount)
         {
            TGameUtil.setButtonMode(this.FMC_Scene.BTN_buy,true);
         }
         else
         {
            TGameUtil.setButtonMode(this.FMC_Scene.BTN_buy,false);
         }
      }
      
      protected function UpdateItem() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TInventory = null;
         _loc1_ = 0;
         while(_loc1_ < this.BOX_COUNT)
         {
            _loc2_ = _loc1_ + this.FCurPage * this.BOX_COUNT;
            if(_loc2_ < this.FVipBox.Inventories.Count)
            {
               _loc3_ = this.FVipBox.Inventories.GetInventoryByIndex(_loc2_);
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
      
      protected function ButtonBuyOnClick(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(this.FOnGetReward != null)
         {
            this.FOnGetReward(this,this.FIndex);
         }
      }
      
      protected function ProcessorPageOnChange(param1:Object, param2:int) : void
      {
         this.FCurPage = param2;
         this.UpdateItem();
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
      
      public function get OnGetReward() : Function
      {
         return this.FOnGetReward;
      }
      
      public function set OnGetReward(param1:Function) : void
      {
         this.FOnGetReward = param1;
      }
      
      public function Init() : void
      {
         this.Initialization();
      }
      
      public function SetItemInfo(param1:uint) : void
      {
         this.FIndex = param1;
         this.FVipBox = SLogicsCore.VipShop.GetBoxByIndex(param1);
         if(!this.FVipBox)
         {
            return;
         }
         this.FUIPage.TotalQuantity = this.FVipBox.Inventories.Count;
         this.FUIPage.Update();
         this.UpdateContent();
         this.UpdateBtn();
         this.UpdateItem();
      }
      
      public function UpdateSlot() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         _loc2_ = this.FSlotList.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.FSlotList[_loc1_].Update();
            _loc1_++;
         }
      }
   }
}

