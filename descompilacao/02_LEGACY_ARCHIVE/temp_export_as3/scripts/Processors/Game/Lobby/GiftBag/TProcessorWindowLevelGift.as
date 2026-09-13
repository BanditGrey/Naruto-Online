package Processors.Game.Lobby.GiftBag
{
   import Components.ScrollBar.TScrollBar;
   import Foundation.Common.THint;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.ActivityMode.TActivityAtom;
   import Logics.ActivityMode.TActivityAtoms;
   import Logics.Inventories.TInventories;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.GiftBag.Component.TUILevelGiftBagBox;
   import Rendering.Overlayers.Hints.TOverlayerHint;
   import Resources.Constants.CONST_ACTIVITY_MODE;
   import Resources.Constants.CONST_GIFTBAG;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class TProcessorWindowLevelGift extends TProcessorLobbyWindow
   {
      
      public static const ACTIVITY_LEVELGIFT:uint = CONST_ACTIVITY_MODE.ACTIVITY_LEVELGIFT;
      
      protected static const MIN_SCROLL_HEIGHT:Number = 288;
      
      protected static const ITEM_STAMP:Number = 0;
      
      protected static const SINGLE_ITEM_STAMP:Number = 70;
      
      protected static const ITEM_HEIGHT:Number = 70;
      
      protected var FMC_Scene:Sprite;
      
      protected var FBoxSlot:Vector.<TUILevelGiftBagBox>;
      
      protected var FBTN_Close:SimpleButton;
      
      protected var FLevelGiftAtoms:TActivityAtoms;
      
      protected var FIsOpen:Boolean;
      
      protected var FOverlayerHint:TOverlayerHint;
      
      protected var FScrollBar:TScrollBar;
      
      protected var FInventories:TInventories;
      
      protected var FCloseOnClick:Function;
      
      protected var FGetAwardOnClick:Function;
      
      protected var FBoxSlotOnOver:Function;
      
      protected var FBoxSlotOnOut:Function;
      
      public function TProcessorWindowLevelGift(param1:TUIComponent)
      {
         super(param1);
         this.FBoxSlot = new Vector.<TUILevelGiftBagBox>();
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
         this.FMC_Scene = TUtilityReflection.CreateDisplayObjectInstance("MC_LevelGift") as Sprite;
         addChild(this.FMC_Scene);
         this.FBTN_Close = this.FMC_Scene["BTN_Close"];
         this.FScrollBar = new TScrollBar(this.FMC_Scene["MC_List"],MIN_SCROLL_HEIGHT,false,ITEM_STAMP,SINGLE_ITEM_STAMP);
         this.FOverlayerHint = new TOverlayerHint(this.Parent);
         this.FOverlayerHint.visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerHint);
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FBTN_Close.addEventListener(MouseEvent.CLICK,this.OnCloseClick);
         super.ResourcesPerform_UILocations();
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TActivityAtom = null;
         super.LogicsPerform();
         if(Boolean(this.FMC_Scene) && this.visible)
         {
            if(this.FLevelGiftAtoms == null)
            {
               return;
            }
            _loc2_ = this.FLevelGiftAtoms.Count;
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               _loc3_ = this.FLevelGiftAtoms.GetActivityAtomByIndex(_loc1_);
               if(_loc3_ != null && _loc3_.InventoriesVect != null)
               {
                  this.FBoxSlot[_loc1_].UpDataSlots(this,_loc3_.InventoriesVect[0]);
               }
               _loc1_++;
            }
         }
      }
      
      protected function SetActivityAtoms() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:TActivityAtoms = null;
         if(this.FLevelGiftAtoms == null)
         {
            return;
         }
         this.FLevelGiftAtoms.SortActivityAtoms();
      }
      
      protected function UpdateUI() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TUILevelGiftBagBox = null;
         _loc2_ = int(this.FBoxSlot.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FBoxSlot.pop();
            _loc3_.parent.removeChild(_loc3_);
            _loc1_++;
         }
         this.FBoxSlot.length = 0;
         this.FScrollBar.Clear();
         this.ResourcesPerform_Reward();
      }
      
      protected function ResourcesPerform_Reward() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUILevelGiftBagBox = null;
         var _loc4_:TActivityAtom = null;
         if(this.FLevelGiftAtoms == null)
         {
            return;
         }
         _loc2_ = uint(this.FLevelGiftAtoms.Count);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = new TUILevelGiftBagBox(this);
            _loc3_.Perform_UIDispatch(null);
            _loc4_ = this.FLevelGiftAtoms.GetActivityAtomByIndex(_loc1_);
            _loc3_.BoxIndex = _loc4_.Identifier;
            _loc3_.GetAwardStatus = _loc4_.ActiveStatus;
            _loc3_.SlotOnMove = this.OnBoxSlotOnMove;
            _loc3_.SlotOnOut = this.OnBoxSlotOnOut;
            _loc3_.UpDataLevelName(_loc4_.Tips[0]);
            _loc3_.UpDataSlots(this,_loc4_.InventoriesVect[0]);
            _loc3_.GetAwardOnClick = this.OnGetAwardClick;
            this.FBoxSlot[_loc1_] = _loc3_;
            this.FScrollBar.AddItem(_loc3_);
            _loc1_++;
         }
         this.FScrollBar.ScrollToElement(this.CheckRewardIndex());
      }
      
      protected function CheckRewardIndex() : int
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUILevelGiftBagBox = null;
         var _loc4_:TActivityAtom = null;
         _loc2_ = uint(this.FLevelGiftAtoms.Count);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc4_ = this.FLevelGiftAtoms.GetActivityAtomByIndex(_loc1_);
            if(_loc4_.ActiveStatus >= 1)
            {
               return _loc1_ + 1;
            }
            _loc1_++;
         }
         return -1;
      }
      
      protected function SortOnAtom(param1:TActivityAtom, param2:TActivityAtom) : Number
      {
         if(param1.Sort < param2.Sort)
         {
            return -1;
         }
         if(param1.Sort > param2.Sort)
         {
            return 1;
         }
         return 0;
      }
      
      protected function OnCloseClick(param1:MouseEvent) : void
      {
         if(this.FCloseOnClick != null)
         {
            this.FCloseOnClick(this);
         }
      }
      
      protected function OnGetAwardClick(param1:Object, param2:uint) : void
      {
         if(this.FGetAwardOnClick != null)
         {
            this.FGetAwardOnClick(param1,param2);
         }
      }
      
      protected function OnBoxSlotOnMove(param1:Object, param2:Object) : void
      {
         if(this.FBoxSlotOnOver != null)
         {
            this.FBoxSlotOnOver(param1,param2);
         }
      }
      
      protected function OnBoxSlotOnOut(param1:Object, param2:Object) : void
      {
         if(this.FBoxSlotOnOut != null)
         {
            this.FBoxSlotOnOut(param1,param2);
         }
      }
      
      protected function TipOnOver(param1:Object, param2:THint) : void
      {
         this.FOverlayerHint.Context = param2;
         this.FOverlayerHint.Render(FUICore.MouseCoordinate);
         this.FOverlayerHint.Show();
      }
      
      protected function TipOnOut(param1:Object) : void
      {
         this.FOverlayerHint.Hide();
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
      
      public function get BoxSlotOnOver() : Function
      {
         return this.FBoxSlotOnOver;
      }
      
      public function set BoxSlotOnOver(param1:Function) : void
      {
         this.FBoxSlotOnOver = param1;
      }
      
      public function get BoxSlotOnOut() : Function
      {
         return this.FBoxSlotOnOut;
      }
      
      public function set BoxSlotOnOut(param1:Function) : void
      {
         this.FBoxSlotOnOut = param1;
      }
      
      override public function set Visible(param1:Boolean) : void
      {
         super.Visible = param1;
      }
      
      public function get LevelGiftAtoms() : TActivityAtoms
      {
         return this.FLevelGiftAtoms;
      }
      
      public function set LevelGiftAtoms(param1:TActivityAtoms) : void
      {
         this.FLevelGiftAtoms = param1;
      }
      
      public function UpDateUI() : void
      {
         this.SetActivityAtoms();
         this.UpdateUI();
      }
   }
}

