package Processors.Game.Lobby.GiftBag
{
   import Components.Slots.TUISlot;
   import Externals.SExternalCore;
   import Foundation.Queries.TQueryString;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Resources.Repositories.TResourceRepositoryTexture;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Resources.Textures.TTexture;
   import Foundation.UI.TUIComponent;
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
   
   public class TProcessorWindowCollectGame extends TProcessorLobbyWindow
   {
      
      protected static const MAX_SLOT_COUNT:int = 3;
      
      protected var FMC:Sprite;
      
      protected var FTF_WorthMoney:TextField;
      
      protected var FBTN_Award:MovieClip;
      
      protected var FBTN_Get:SimpleButton;
      
      protected var FBTN_CollectGame:SimpleButton;
      
      protected var FBTN_Close:SimpleButton;
      
      protected var FUISlots:Vector.<TUISlot>;
      
      protected var FAwardTempID:Vector.<uint>;
      
      protected var FAwardItemID:Vector.<uint>;
      
      protected var FAwardItemCount:Vector.<uint>;
      
      protected var FBInitSlots:Boolean;
      
      protected var FInventories:Vector.<TInventories>;
      
      protected var FIsOpen:Boolean;
      
      protected var FType:uint;
      
      protected var FSlotOnMove:Function;
      
      protected var FSlotOnOut:Function;
      
      protected var FCloseOnClick:Function;
      
      protected var FGetAwardOnClick:Function;
      
      protected var FCollectGame:TActivityAtoms;
      
      public function TProcessorWindowCollectGame(param1:TUIComponent, param2:uint = 0)
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
         this.FMC = TUtilityReflection.CreateDisplayObjectInstance(CONST_GIFTBAG.RESOURCE_ClassName_CollectGame) as Sprite;
         addChild(this.FMC);
         this.FBTN_Get = this.FMC["BTN_Get"];
         this.FBTN_CollectGame = this.FMC["BTN_Collect"];
         this.FBTN_Close = this.FMC[CONST_GIFTBAG.RESOURCE_Link_BTN_Close];
         this.FBTN_Get.visible = false;
         this.FBTN_CollectGame.visible = true;
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
         this.FBTN_Get.addEventListener(MouseEvent.CLICK,this.OnGetRewardClick);
         this.FBTN_CollectGame.addEventListener(MouseEvent.CLICK,this.OnCollectGameClick);
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
         if(this.FCollectGame == null)
         {
            return;
         }
         this.FIsOpen = this.FCollectGame.IsOn;
         _loc1_ = this.FCollectGame.Count;
         _loc3_ = new Vector.<TActivityAtom>();
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_[_loc2_] = this.FCollectGame.GetActivityAtomByIndex(_loc2_);
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
         if(this.FCollectGame == null || this.FCollectGame.Count <= 0)
         {
            return;
         }
         _loc3_ = this.FCollectGame.GetActivityAtomByIndex(0);
         _loc1_ = _loc3_.ActiveStatus;
         _loc2_ = _loc3_.Price;
         if(_loc1_ == -1)
         {
            this.FBTN_Get.visible = false;
            this.FBTN_CollectGame.visible = true;
         }
         else if(_loc1_ == 0)
         {
            this.FBTN_Get.visible = true;
            this.FBTN_CollectGame.visible = false;
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
      
      protected function OnCollectGameClick(param1:MouseEvent) : void
      {
         SExternalCore.AddCollect();
         this.FBTN_Get.visible = true;
         this.FBTN_CollectGame.visible = false;
      }
      
      protected function OnGetRewardClick(param1:MouseEvent) : void
      {
         var _loc2_:TActivityAtom = null;
         _loc2_ = this.FCollectGame.GetActivityAtomByIndex(0);
         if(this.FGetAwardOnClick != null)
         {
            this.FGetAwardOnClick(this,_loc2_.Identifier);
            this.FCloseOnClick(this);
         }
      }
      
      public function get CloseOnClick() : Function
      {
         return this.FCloseOnClick;
      }
      
      public function set CloseOnClick(param1:Function) : void
      {
         this.FCloseOnClick = param1;
      }
      
      public function get GetAwardOnClick() : Function
      {
         return this.FGetAwardOnClick;
      }
      
      public function set GetAwardOnClick(param1:Function) : void
      {
         this.FGetAwardOnClick = param1;
      }
      
      override public function set Visible(param1:Boolean) : void
      {
         super.Visible = param1;
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
      
      public function get CollectGame() : TActivityAtoms
      {
         return this.FCollectGame;
      }
      
      public function set CollectGame(param1:TActivityAtoms) : void
      {
         this.FCollectGame = param1;
      }
      
      public function UpDataUI() : void
      {
         this.SetModes();
         this.UpdataUI();
      }
   }
}

