package Processors.Game.Lobby.Exercise.NinjaBank.Compoents
{
   import Components.Slots.TUISlot;
   import Foundation.Common.THint;
   import Foundation.Queries.TQueryString;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Resources.Repositories.TResourceRepositoryTexture;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Resources.Textures.TTexture;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.Exercise.NinjaBank.TNinjaBank;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TAppliance;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Rendering.Overlayers.Hints.TOverlayerHint;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_COMMONRECHARGE;
   import Resources.Constants.CONST_MODULES;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   
   public class TUINinjaBankItem extends TUIComponent
   {
      
      protected var BOX_COUNT:int = 5;
      
      protected var FMC_Scene:MovieClip;
      
      protected var FSlotList:Vector.<TUISlot>;
      
      protected var FIndex:int;
      
      protected var FNinjaBank:TNinjaBank;
      
      protected var FOnQuerySequenceContext:Function;
      
      protected var FOnOverlay:Function;
      
      protected var FOnOut:Function;
      
      protected var FOnQuerySubscript:Function;
      
      protected var FOnGetReward:Function;
      
      protected var FOverlayerHint:TOverlayerHint;
      
      protected var FHintOnMove:Function;
      
      protected var FHintOnOut:Function;
      
      protected var FHint:THint;
      
      public function TUINinjaBankItem(param1:TUIComponent)
      {
         super(param1);
         this.FSlotList = new Vector.<TUISlot>(this.BOX_COUNT);
         this.FNinjaBank = SLogicsCore.NinjaBank;
      }
      
      protected function Initialization() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUISlot = null;
         this.FMC_Scene = TUtilityReflection.CreateDisplayObjectInstance("MC_NinjaBankItem") as MovieClip;
         addChild(this.FMC_Scene);
         _loc1_ = 0;
         while(_loc1_ < this.BOX_COUNT)
         {
            _loc3_ = new TUISlot(this);
            _loc3_.Resource = this.FMC_Scene[CONST_COMMONRECHARGE.RESOURCE_Link_MC_Slot + _loc1_] as Sprite;
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
         this.FMC_Scene.TF_Text.mouseEnabled = false;
      }
      
      protected function UpdateContent() : void
      {
         var _loc1_:TBaseBox = null;
         if(this.FIndex >= this.FNinjaBank.BoxList.length)
         {
            return;
         }
         _loc1_ = this.FNinjaBank.BoxList[this.FIndex];
         this.FMC_Scene.TF_Text.text = _loc1_.DescListNew[0];
         if(this.FNinjaBank.CurBuyIndex - 1 == this.FIndex)
         {
            this.FMC_Scene.MC_Select.visible = true;
            this.FMC_Scene.MC_Money.visible = false;
            this.FMC_Scene.MC_Select.MC_Money.TF_Money.text = Math.floor(this.FNinjaBank.Price * this.FNinjaBank.BoughtCount * (100 + _loc1_.Discount) / 100);
            this.FMC_Scene.MC_Select.MC_Money.TF_Rate.text = _loc1_.Discount;
         }
         else
         {
            this.FMC_Scene.MC_Select.visible = false;
            this.FMC_Scene.MC_Money.visible = true;
            this.FMC_Scene.MC_Money.TF_Money.text = String(_loc1_.Discount) + "%";
         }
      }
      
      protected function UpdateItem() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TInventories = null;
         var _loc4_:TInventory = null;
         if(this.FIndex >= this.FNinjaBank.BoxList.length)
         {
            return;
         }
         _loc3_ = this.FNinjaBank.BoxList[this.FIndex].Inventories;
         if(!_loc3_ || _loc3_.Count <= 0)
         {
            return;
         }
         _loc1_ = 0;
         while(_loc1_ < this.BOX_COUNT)
         {
            if(_loc1_ < _loc3_.Count)
            {
               _loc4_ = _loc3_.GetInventoryByIndex(_loc1_);
               this.FSlotList[_loc1_].Context = _loc4_;
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
            this.FOnOverlay(param1,param2);
         }
      }
      
      protected function SlotsOnOut(param1:Object, param2:Object) : void
      {
         if(this.FOnOut != null)
         {
            this.FOnOut(param1,param2);
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
      
      public function Init() : void
      {
         this.Initialization();
      }
      
      public function SetItemInfo(param1:uint) : void
      {
         this.FIndex = param1;
         this.UpdateContent();
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

