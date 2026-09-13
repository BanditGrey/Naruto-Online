package Logics.Lottery
{
   import Logics.Inventories.TInventories;
   
   public class TLotteryItem
   {
      
      protected var FIdentify:int;
      
      protected var FSlotId:int;
      
      protected var FIsInside:int;
      
      protected var FType:int;
      
      protected var FInventories:TInventories;
      
      protected var FCount:int;
      
      protected var FIsShine:int;
      
      protected var FShineColor:int;
      
      public function TLotteryItem()
      {
         super();
      }
      
      public function get Identify() : int
      {
         return this.FIdentify;
      }
      
      public function set Identify(param1:int) : void
      {
         this.FIdentify = param1;
      }
      
      public function get SlotId() : int
      {
         return this.FSlotId;
      }
      
      public function set SlotId(param1:int) : void
      {
         this.FSlotId = param1;
      }
      
      public function get IsInside() : int
      {
         return this.FIsInside;
      }
      
      public function set IsInside(param1:int) : void
      {
         this.FIsInside = param1;
      }
      
      public function get Type() : int
      {
         return this.FType;
      }
      
      public function set Type(param1:int) : void
      {
         this.FType = param1;
      }
      
      public function get Inventories() : TInventories
      {
         return this.FInventories;
      }
      
      public function set Inventories(param1:TInventories) : void
      {
         this.FInventories = param1;
      }
      
      public function get Count() : int
      {
         return this.FCount;
      }
      
      public function set Count(param1:int) : void
      {
         this.FCount = param1;
      }
      
      public function get IsShine() : int
      {
         return this.FIsShine;
      }
      
      public function set IsShine(param1:int) : void
      {
         this.FIsShine = param1;
      }
      
      public function get ShineColor() : int
      {
         return this.FShineColor;
      }
      
      public function set ShineColor(param1:int) : void
      {
         this.FShineColor = param1;
      }
   }
}

