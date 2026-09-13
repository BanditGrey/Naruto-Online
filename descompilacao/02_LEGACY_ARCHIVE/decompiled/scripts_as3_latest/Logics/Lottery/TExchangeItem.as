package Logics.Lottery
{
   import Logics.Inventories.TInventories;
   
   public class TExchangeItem
   {
      
      protected var FIdentify:int;
      
      protected var FInventories:TInventories;
      
      protected var FCostPoint:int;
      
      protected var FLimitCount:int;
      
      protected var FBuyCount:int;
      
      protected var FLimitLevel:int;
      
      protected var FOriginalCost:int;
      
      protected var FIsHot:int;
      
      protected var FIsNone:int;
      
      protected var FIsOwn:int;
      
      public function TExchangeItem()
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
      
      public function get Inventories() : TInventories
      {
         return this.FInventories;
      }
      
      public function set Inventories(param1:TInventories) : void
      {
         this.FInventories = param1;
      }
      
      public function get CostPoint() : int
      {
         return this.FCostPoint;
      }
      
      public function set CostPoint(param1:int) : void
      {
         this.FCostPoint = param1;
      }
      
      public function get LimitCount() : int
      {
         return this.FLimitCount;
      }
      
      public function set LimitCount(param1:int) : void
      {
         this.FLimitCount = param1;
      }
      
      public function get BuyCount() : int
      {
         return this.FBuyCount;
      }
      
      public function set BuyCount(param1:int) : void
      {
         this.FBuyCount = param1;
      }
      
      public function get LimitLevel() : int
      {
         return this.FLimitLevel;
      }
      
      public function set LimitLevel(param1:int) : void
      {
         this.FLimitLevel = param1;
      }
      
      public function get OriginalCost() : int
      {
         return this.FOriginalCost;
      }
      
      public function set OriginalCost(param1:int) : void
      {
         this.FOriginalCost = param1;
      }
      
      public function get IsHot() : int
      {
         return this.FIsHot;
      }
      
      public function set IsHot(param1:int) : void
      {
         this.FIsHot = param1;
      }
      
      public function get IsNone() : int
      {
         return this.FIsNone;
      }
      
      public function set IsNone(param1:int) : void
      {
         this.FIsNone = param1;
      }
      
      public function get IsOwn() : int
      {
         return this.FIsOwn;
      }
      
      public function set IsOwn(param1:int) : void
      {
         this.FIsOwn = param1;
      }
   }
}

