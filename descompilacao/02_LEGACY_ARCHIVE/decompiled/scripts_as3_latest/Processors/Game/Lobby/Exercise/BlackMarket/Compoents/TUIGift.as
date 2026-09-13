package Processors.Game.Lobby.Exercise.BlackMarket.Compoents
{
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
   import Logics.Exercise.BlackMarket.TBlackMarket;
   import Logics.Exercise.TBaseActivity;
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
   import flash.events.MouseEvent;
   
   public class TUIGift extends TUIComponent
   {
      
      protected var BOX_COUNT:int = 7;
      
      protected var FMC_Scene:MovieClip;
      
      protected var FSlotList:Vector.<TUISlot>;
      
      protected var FIndex:int;
      
      protected var FBlackMarket:TBlackMarket;
      
      protected var FOnQuerySequenceContext:Function;
      
      protected var FOnOverlay:Function;
      
      protected var FOnOut:Function;
      
      protected var FOnQuerySubscript:Function;
      
      protected var FOnGetReward:Function;
      
      protected var FOverlayerHint:TOverlayerHint;
      
      protected var FHintOnMove:Function;
      
      protected var FHintOnOut:Function;
      
      protected var FHint:THint;
      
      public function TUIGift(param1:TUIComponent)
      {
         super(param1);
         this.FSlotList = new Vector.<TUISlot>(this.BOX_COUNT);
         this.FBlackMarket = SLogicsCore.BlackMarket;
      }
      
      protected function Initialization() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUISlot = null;
         this.FMC_Scene = TUtilityReflection.CreateDisplayObjectInstance("MC_BlackMarketReward") as MovieClip;
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
         this.FMC_Scene.BTN_Get.addEventListener(MouseEvent.CLICK,this.ProcessorOnGetBox);
         this.FMC_Scene.TF_Text.mouseEnabled = false;
      }
      
      protected function UpdateItem() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TInventories = null;
         var _loc3_:TInventory = null;
         var _loc4_:TBaseBox = null;
         if(this.FIndex >= this.FBlackMarket.GiftList.length)
         {
            return;
         }
         _loc4_ = this.FBlackMarket.GiftList[this.FIndex];
         _loc2_ = _loc4_.Inventories;
         this.FMC_Scene.TF_Text.text = _loc4_.Desc1;
         _loc1_ = 0;
         while(_loc1_ < this.BOX_COUNT)
         {
            if(_loc1_ < _loc2_.Count)
            {
               _loc3_ = _loc2_.GetInventoryByIndex(_loc1_);
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
      
      protected function ProcessorOnGetBox(param1:MouseEvent) : void
      {
         if(this.FOnGetReward != null)
         {
            this.FOnGetReward(this.FIndex);
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
         this.UpdateItem();
         this.UpdateBtn();
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
      
      public function UpdateBtn() : void
      {
         var _loc1_:TBaseBox = null;
         if(this.FIndex >= this.FBlackMarket.GiftList.length)
         {
            return;
         }
         _loc1_ = this.FBlackMarket.GiftList[this.FIndex];
         if(_loc1_.Status == TBaseActivity.STATUS_CANNOTGET)
         {
            this.FMC_Scene.MC_Got.visible = false;
            this.FMC_Scene.BTN_Get.visible = true;
            TGameUtil.setButtonMode(this.FMC_Scene.BTN_Get,false);
         }
         else if(_loc1_.Status == TBaseActivity.STATUS_CANGET)
         {
            this.FMC_Scene.MC_Got.visible = false;
            this.FMC_Scene.BTN_Get.visible = true;
            TGameUtil.setButtonMode(this.FMC_Scene.BTN_Get,true);
         }
         else
         {
            this.FMC_Scene.MC_Got.visible = true;
            this.FMC_Scene.BTN_Get.visible = false;
         }
      }
   }
}

