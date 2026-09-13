package Processors.Game.Lobby.GiftBag.Component
{
   import Components.Slots.TUISlot;
   import Foundation.Queries.TQueryString;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Resources.Repositories.TResourceRepositoryTexture;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Resources.Textures.TTexture;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_GIFTBAG;
   import Resources.Constants.CONST_MODULES;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TUILevelGiftBagBox extends TUIComponent
   {
      
      protected static const MAX_SLOTSCOUNT:uint = 6;
      
      protected var FMC:MovieClip;
      
      protected var FMC_Slot:TUISlot;
      
      protected var FBTN_GetAward:MovieClip;
      
      protected var FMC_AlreadyGetAward:MovieClip;
      
      protected var FTF_Level:TextField;
      
      protected var FAwardSlot:Vector.<TUISlot>;
      
      protected var FBoxIndex:uint;
      
      protected var FGetAwardStatus:int;
      
      protected var FSlotOnMove:Function;
      
      protected var FSlotOnOut:Function;
      
      protected var FGetAwardOnClick:Function;
      
      protected var FInventories:TInventories;
      
      public function TUILevelGiftBagBox(param1:TUIComponent)
      {
         super(param1);
         this.FAwardSlot = new Vector.<TUISlot>(MAX_SLOTSCOUNT);
         this.FInventories = new TInventories();
      }
      
      protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TUISlot = null;
         var _loc5_:Sprite = null;
         this.FMC = TUtilityReflection.CreateDisplayObjectInstance("MC_LevelGiftBox") as MovieClip;
         addChild(this.FMC);
         this.FBTN_GetAward = this.FMC[CONST_GIFTBAG.RESOURCE_Link_BTN_Reward];
         this.FTF_Level = this.FMC["TF_Level"];
         TGameUtil.setButtonMode(this.FBTN_GetAward,false);
         this.FBTN_GetAward.addEventListener(MouseEvent.CLICK,this.OnGetAwardClick);
         this.FMC_AlreadyGetAward = this.FMC[CONST_GIFTBAG.RESOURCE_Link_MC_AlreadyGetAward];
         this.FMC_AlreadyGetAward.visible = false;
         _loc3_ = int(MAX_SLOTSCOUNT);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc5_ = this.FMC[CONST_GIFTBAG.RESOURCE_Link_MC_Slot + _loc2_];
            _loc5_.visible = true;
            _loc4_ = new TUISlot(this);
            _loc4_.Resource = _loc5_;
            _loc4_.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
            _loc4_.OnOverlay = this.OnSlotMove;
            _loc4_.OnOut = this.OnSlotOut;
            _loc4_.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
            _loc4_.OnQuerySubscript = this.SlotsOnQuerySubscript;
            _loc4_.Init();
            this.FAwardSlot[_loc2_] = _loc4_;
            _loc2_++;
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
            param3.Value = _loc7_.GetAnimationSequenceByIdentifier(0);
         }
         else
         {
            _loc6_.LoadSecondary(_loc5_.IDTexture,CONST_MODULES.MODULE_GiftBag);
         }
      }
      
      protected function SlotsOnQuerySubscript(param1:Object, param2:Object, param3:TQueryString) : void
      {
         var _loc4_:TInventory = null;
         var _loc5_:int = 0;
         var _loc6_:uint = 0;
         if(param2 is TInventory)
         {
            _loc4_ = param2 as TInventory;
            _loc6_ = _loc4_.Quantity;
            param3.Value = String(_loc6_);
         }
      }
      
      protected function UpdateUI() : void
      {
         if(this.FInventories == null)
         {
            return;
         }
         if(this.FBTN_GetAward != null && this.FMC_AlreadyGetAward != null)
         {
            this.FMC_AlreadyGetAward.gotoAndStop(this.FMC_AlreadyGetAward.totalFrames);
            if(this.FGetAwardStatus == -1)
            {
               this.FMC_AlreadyGetAward.visible = true;
               this.FBTN_GetAward.visible = false;
            }
            else if(this.FGetAwardStatus == 0)
            {
               this.FMC_AlreadyGetAward.visible = false;
               TGameUtil.setButtonMode(this.FBTN_GetAward,false);
            }
            else if(this.FGetAwardStatus >= 1)
            {
               this.FMC_AlreadyGetAward.visible = false;
               TGameUtil.setButtonMode(this.FBTN_GetAward,true);
            }
         }
      }
      
      protected function OnGetAwardClick(param1:MouseEvent) : void
      {
         if(this.FGetAwardStatus <= 0)
         {
            return;
         }
         if(this.FGetAwardOnClick != null)
         {
            this.FGetAwardOnClick(this,this.BoxIndex);
         }
         TGameUtil.setButtonMode(this.FBTN_GetAward,false);
         this.FBTN_GetAward.visible = false;
         this.FMC_AlreadyGetAward.visible = true;
         this.FGetAwardStatus = -1;
      }
      
      protected function OnSlotMove(param1:Object, param2:Object) : void
      {
         if(this.FSlotOnMove != null)
         {
            this.FSlotOnMove(param1,param2);
         }
      }
      
      protected function OnSlotOut(param1:Object, param2:Object) : void
      {
         if(this.FSlotOnOut != null)
         {
            this.FSlotOnOut(param1,param2);
         }
      }
      
      public function get BoxIndex() : uint
      {
         return this.FBoxIndex;
      }
      
      public function set BoxIndex(param1:uint) : void
      {
         this.FBoxIndex = param1;
      }
      
      public function get SlotOnMove() : Function
      {
         return this.FSlotOnMove;
      }
      
      public function set SlotOnMove(param1:Function) : void
      {
         this.FSlotOnMove = param1;
      }
      
      public function get SlotOnOut() : Function
      {
         return this.FSlotOnOut;
      }
      
      public function set SlotOnOut(param1:Function) : void
      {
         this.FSlotOnOut = param1;
      }
      
      public function get GetAwardOnClick() : Function
      {
         return this.FGetAwardOnClick;
      }
      
      public function set GetAwardOnClick(param1:Function) : void
      {
         this.FGetAwardOnClick = param1;
      }
      
      public function get Inventories() : TInventories
      {
         return this.FInventories;
      }
      
      public function set Inventories(param1:TInventories) : void
      {
         this.FInventories = param1;
      }
      
      public function get GetAwardStatus() : int
      {
         return this.FGetAwardStatus;
      }
      
      public function set GetAwardStatus(param1:int) : void
      {
         this.FGetAwardStatus = param1;
      }
      
      public function Perform_UIDispatch(param1:MovieClip) : void
      {
         this.Resources_UIDispatch(param1);
      }
      
      public function UpDataSlots(param1:Object, param2:TInventories) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         this.FInventories = param2;
         _loc4_ = this.FInventories.Count;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            if(this.FAwardSlot[_loc3_] != null)
            {
               this.FAwardSlot[_loc3_].Context = this.FInventories.GetInventoryByIndex(_loc3_);
               this.FAwardSlot[_loc3_].Update();
            }
            _loc3_++;
         }
         this.UpdateUI();
      }
      
      public function UpDataLevelName(param1:String) : void
      {
         this.FTF_Level.text = param1;
      }
   }
}

