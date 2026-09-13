package Processors.Game.Lobby.CrossServerWar.Components
{
   import Components.Slots.TUISlot;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.CrossServerWar.TOrangeInventorySample;
   import Logics.CrossServerWar.TTokenInventorySample;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Processors.Game.TProcessorGame;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_CROSSSERVERWAR;
   import Resources.Strings.STRING_CROSSSERVERWAR;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TUIItemExchange extends TProcessorGame
   {
      
      protected var FTF_Cost:TextField;
      
      protected var FBTN_Exchange:MovieClip;
      
      protected var FMC_Slot:TUISlot;
      
      protected var FMC_Picture:MovieClip;
      
      protected var FResource:MovieClip;
      
      protected var FOnExchangeClick:Function;
      
      protected var FSlotOnOut:Function;
      
      protected var FSlotOnOver:Function;
      
      protected var FOnQuerySequenceContext:Function;
      
      protected var FContext:Object;
      
      public function TUIItemExchange(param1:TUIComponent)
      {
         super(param1);
         this.FMC_Slot = new TUISlot(this);
      }
      
      protected function UIDispatch() : void
      {
         this.FBTN_Exchange = this.FResource[CONST_CROSSSERVERWAR.RESOURCE_Link_BTN_Exchange];
         TGameUtil.setButtonMode(this.FBTN_Exchange,true);
         this.FTF_Cost = this.FResource[CONST_CROSSSERVERWAR.RESOURCE_Link_TF_Cost];
         this.FMC_Picture = this.FResource["MC_Picture"];
         this.FMC_Slot = new TUISlot(this);
         this.FMC_Slot.Resource = this.FResource[CONST_CROSSSERVERWAR.RESOURCE_Link_MC_Slot];
         this.FMC_Slot.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
         this.FMC_Slot.OnQuerySequenceContext = this.FOnQuerySequenceContext;
         this.FMC_Slot.OnOverlay = this.FSlotOnOver;
         this.FMC_Slot.OnOut = this.FSlotOnOut;
         this.FMC_Slot.Init();
      }
      
      protected function UILocation() : void
      {
         this.FBTN_Exchange.addEventListener(MouseEvent.CLICK,this.BTNExchangeOnClick,false,0,true);
      }
      
      protected function UpdateUI() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:TOrangeInventorySample = null;
         var _loc3_:TTokenInventorySample = null;
         var _loc4_:String = null;
         var _loc5_:TInventory = null;
         if(this.FContext is TOrangeInventorySample)
         {
            _loc2_ = this.FContext as TOrangeInventorySample;
            _loc1_ = uint(_loc2_.VipLevel);
            _loc4_ = _loc2_.ExchangeCount.toString();
            _loc5_ = _loc2_.Inventory;
            this.FMC_Picture.gotoAndStop(2);
         }
         else if(this.FContext is TTokenInventorySample)
         {
            _loc3_ = this.FContext as TTokenInventorySample;
            _loc1_ = uint(_loc3_.VipLevel);
            _loc4_ = _loc3_.ExchangeCount.toString();
            _loc5_ = _loc3_.Inventory;
            this.FMC_Picture.gotoAndStop(1);
         }
         if(_loc1_ > SLogicsCore.Character.VipLevel)
         {
            this.FBTN_Exchange["TF_Exchange"].text = TUtilityString.Format(STRING_CROSSSERVERWAR.FORMAT_VipExchange,_loc1_);
            TGameUtil.setButtonMode(this.FBTN_Exchange,false);
            this.FBTN_Exchange.mouseEnabled = false;
         }
         else
         {
            this.FBTN_Exchange["TF_Exchange"].text = STRING_CROSSSERVERWAR.FORMAT_CanExchange;
            TGameUtil.setButtonMode(this.FBTN_Exchange,true);
            this.FBTN_Exchange.mouseEnabled = true;
         }
         this.FTF_Cost.text = _loc4_;
         this.FMC_Slot.Context = _loc5_;
      }
      
      override protected function LogicsPerform() : void
      {
         if(!this.Parent.Visible)
         {
            return;
         }
         if(this.FMC_Slot.Context != null)
         {
            this.FMC_Slot.Update();
         }
         super.LogicsPerform();
      }
      
      protected function BTNExchangeOnClick(param1:MouseEvent) : void
      {
         if(this.FOnExchangeClick != null)
         {
            this.FOnExchangeClick(this,this.FContext);
         }
      }
      
      public function get Resource() : MovieClip
      {
         return this.FResource;
      }
      
      public function set Resource(param1:MovieClip) : void
      {
         this.FResource = param1;
      }
      
      public function get OnExchangeClick() : Function
      {
         return this.FOnExchangeClick;
      }
      
      public function set OnExchangeClick(param1:Function) : void
      {
         this.FOnExchangeClick = param1;
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
      
      public function get Context() : Object
      {
         return this.FContext;
      }
      
      public function set Context(param1:Object) : void
      {
         this.FContext = param1;
      }
      
      public function Init() : void
      {
         this.UIDispatch();
         this.UILocation();
      }
      
      public function Update() : void
      {
         if(this.FContext == null)
         {
            return;
         }
         this.UpdateUI();
      }
   }
}

