package Logics.Exercise.RechargeRank
{
   import Logics.Inventories.TInventories;
   
   public class TRechargeRankReward
   {
      
      protected var FIdentify:int;
      
      protected var FMinLimit:int;
      
      protected var FMaxLimit:int;
      
      protected var FBackRate:int;
      
      protected var FInventories:TInventories;
      
      public var NeedSpend:int;
      
      public var ReturnRate:Vector.<int>;
      
      public var NeedGold:Vector.<int>;
      
      public function TRechargeRankReward()
      {
         super();
         this.ReturnRate = new Vector.<int>();
         this.NeedGold = new Vector.<int>();
      }
      
      public function get MinLimit() : int
      {
         return this.FMinLimit;
      }
      
      public function set MinLimit(param1:int) : void
      {
         this.FMinLimit = param1;
      }
      
      public function get MaxLimit() : int
      {
         return this.FMaxLimit;
      }
      
      public function set MaxLimit(param1:int) : void
      {
         this.FMaxLimit = param1;
      }
      
      public function get BackRate() : int
      {
         return this.FBackRate;
      }
      
      public function set BackRate(param1:int) : void
      {
         this.FBackRate = param1;
      }
      
      public function get Inventories() : TInventories
      {
         return this.FInventories;
      }
      
      public function set Inventories(param1:TInventories) : void
      {
         this.FInventories = param1;
      }
      
      public function get Identify() : int
      {
         return this.FIdentify;
      }
      
      public function set Identify(param1:int) : void
      {
         this.FIdentify = param1;
      }
   }
}

