package Processors.Game.Lobby.GiftBag
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
   import Logics.ActivityMode.TActivityAtom;
   import Logics.ActivityMode.TActivityAtoms;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_GIFTBAG;
   import Resources.Constants.CONST_MODULES;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorWindowFirstDayGift extends TProcessorLobbyWindow
   {
      
      protected static const MAX_SLOT_COUNT:int = 6;
      
      protected var FMC:Sprite;
      
      protected var FTF_WorthMoney:TextField;
      
      protected var FBTN_Award:MovieClip;
      
      protected var FBTN_Close:SimpleButton;
      
      protected var FUISlots:Vector.<TUISlot>;
      
      protected var FAwardTempID:Vector.<uint>;
      
      protected var FAwardItemID:Vector.<uint>;
      
      protected var FAwardItemCount:Vector.<uint>;
      
      protected var FBInitSlots:Boolean;
      
      protected var FInventories:Vector.<TInventories>;
      
      protected var FIsOpen:Boolean;
      
      protected var FType:uint;
      
      protected var FGetFirstDayAward:Function;
      
      protected var FSlotOnMove:Function;
      
      protected var FSlotOnOut:Function;
      
      protected var FCloseOnClick:Function;
      
      protected var FFirstDayAtoms:TActivityAtoms;
      
      public function TProcessorWindowFirstDayGift(param1:TUIComponent, param2:uint = 0)
      {
         super(param1);
         this.FInventories = new Vector.<TInventories>();
         this.FUISlots = new Vector.<TUISlot>(MAX_SLOT_COUNT);
         this.FType = param2;
         this.FBInitSlots = false;
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_GIFTBAG.RESOURCESID_SWF_GIFTBAG);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TUISlot = null;
         var _loc4_:Sprite = null;
         if(this.FType == 0)
         {
            this.FMC = TUtilityReflection.CreateDisplayObjectInstance(CONST_GIFTBAG.RESOURCE_ClassName_FirstDayGift) as Sprite;
         }
         else
         {
            this.FMC = TUtilityReflection.CreateDisplayObjectInstance(CONST_GIFTBAG.RESOURCE_ClassName_HFReward) as Sprite;
         }
         addChild(this.FMC);
         this.FTF_WorthMoney = this.FMC[CONST_GIFTBAG.RESOURCE_Link_TF_WorthMoney];
         this.FBTN_Award = this.FMC[CONST_GIFTBAG.RESOURCE_Link_BTN_Reward];
         TGameUtil.setButtonMode(this.FBTN_Award,false);
         this.FBTN_Close = this.FMC[CONST_GIFTBAG.RESOURCE_Link_BTN_Close];
         _loc2_ = MAX_SLOT_COUNT;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc4_ = this.FMC[CONST_GIFTBAG.RESOURCE_Link_MC_Slot + _loc1_];
            _loc3_ = new TUISlot(this);
            _loc3_.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
            _loc3_.Resource = _loc4_;
            _loc3_.OnOverlay = this.FSlotOnMove;
            _loc3_.OnOut = this.FSlotOnOut;
            _loc3_.OnQuerySubscript = this.SlotsOnQuerySubscript;
            _loc3_.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
            _loc3_.Init();
            this.FUISlots[_loc1_] = _loc3_;
            _loc1_++;
         }
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FBTN_Award.addEventListener(MouseEvent.CLICK,this.OnGetAwardClick,false,0,true);
         this.FBTN_Close.addEventListener(MouseEvent.CLICK,this.FCloseOnClick,false,0,true);
         super.ResourcesPerform_UILocations();
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         super.LogicsPerform();
         _loc2_ = int(this.FUISlots.length);
         if(this.FBInitSlots)
         {
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               if(this.FUISlots[_loc1_] != null)
               {
                  this.FUISlots[_loc1_].Update();
               }
               _loc1_++;
            }
         }
      }
      
      protected function UpdataUI() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(this.FInventories.length <= 0)
         {
            return;
         }
         _loc2_ = this.FInventories[0].Count;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(this.FUISlots[_loc1_] != null)
            {
               this.FUISlots[_loc1_].Context = null;
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(this.FUISlots[_loc1_] != null)
            {
               this.FUISlots[_loc1_].Context = this.FInventories[0].GetInventoryByIndex(_loc1_);
            }
            _loc1_++;
         }
         this.FBInitSlots = true;
      }
      
      protected function SetModes() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Vector.<TActivityAtom> = null;
         var _loc4_:int = 0;
         if(this.FFirstDayAtoms == null)
         {
            return;
         }
         this.FIsOpen = this.FFirstDayAtoms.IsOn;
         _loc1_ = this.FFirstDayAtoms.Count;
         _loc3_ = new Vector.<TActivityAtom>();
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_[_loc2_] = this.FFirstDayAtoms.GetActivityAtomByIndex(_loc2_);
            _loc4_ = 0;
            while(_loc4_ < _loc3_[_loc2_].InventoriesVect.length)
            {
               this.FInventories[_loc4_] = _loc3_[_loc2_].InventoriesVect[_loc4_];
               _loc4_++;
            }
            _loc2_++;
         }
      }
      
      protected function UpdateUI() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TActivityAtom = null;
         if(this.FFirstDayAtoms == null || this.FirstDayAtoms.Count <= 0)
         {
            return;
         }
         _loc3_ = this.FFirstDayAtoms.GetActivityAtomByIndex(0);
         _loc1_ = _loc3_.ActiveStatus;
         _loc2_ = _loc3_.Price;
         if(this.FBTN_Award != null)
         {
            if(_loc1_ == -1)
            {
               this.FBTN_Award.visible = false;
            }
            else if(_loc1_ == 0)
            {
               TGameUtil.setButtonMode(this.FBTN_Award,false);
            }
            else if(_loc1_ >= 1)
            {
               TGameUtil.setButtonMode(this.FBTN_Award,true);
            }
         }
         if(this.FTF_WorthMoney != null)
         {
            this.FTF_WorthMoney.text = String(_loc2_);
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
      
      protected function OnGetAwardClick(param1:MouseEvent) : void
      {
         var _loc2_:TActivityAtom = null;
         _loc2_ = this.FFirstDayAtoms.GetActivityAtomByIndex(0);
         if(_loc2_.ActiveStatus <= 0)
         {
            return;
         }
         if(this.FGetFirstDayAward != null)
         {
            this.FGetFirstDayAward(this,_loc2_.Identifier);
            this.FBTN_Award.visible = false;
            this.FCloseOnClick(this);
         }
      }
      
      public function get GetFirstDayAward() : Function
      {
         return this.FGetFirstDayAward;
      }
      
      public function set GetFirstDayAward(param1:Function) : void
      {
         this.FGetFirstDayAward = param1;
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
      
      public function get CloseOnClick() : Function
      {
         return this.FCloseOnClick;
      }
      
      public function set CloseOnClick(param1:Function) : void
      {
         this.FCloseOnClick = param1;
      }
      
      public function get FirstDayAtoms() : TActivityAtoms
      {
         return this.FFirstDayAtoms;
      }
      
      public function set FirstDayAtoms(param1:TActivityAtoms) : void
      {
         this.FFirstDayAtoms = param1;
      }
      
      public function UpDataUI() : void
      {
         this.SetModes();
         this.UpdataUI();
         this.UpdateUI();
      }
   }
}

