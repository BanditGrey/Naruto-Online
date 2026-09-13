package Logics.Exercise.SeptemberActive
{
   import Foundation.Timing.STimingCore;
   import Logics.Exercise.TBaseActivity;
   import Logics.Inventories.TInventories;
   
   public class TSeptemberActive2 extends TBaseActivity
   {
      
      protected var FWaterReduceTime:int;
      
      protected var FTreeLevel:int;
      
      protected var FWaterCount:int;
      
      protected var FNextTime:int;
      
      protected var FCurGold:int;
      
      protected var FMaxGold:int;
      
      protected var FWaterPrice:int;
      
      protected var FShowItems:TInventories;
      
      protected var FWaterReward:TInventories;
      
      protected var FFruitList:TInventories;
      
      protected var FFruitStatus:Vector.<int>;
      
      public function TSeptemberActive2()
      {
         super();
         this.FFruitStatus = new Vector.<int>();
      }
      
      public function get WaterReduceTime() : int
      {
         return this.FWaterReduceTime;
      }
      
      public function set WaterReduceTime(param1:int) : void
      {
         this.FWaterReduceTime = param1;
      }
      
      public function get TreeLevel() : int
      {
         return this.FTreeLevel;
      }
      
      public function set TreeLevel(param1:int) : void
      {
         this.FTreeLevel = param1;
      }
      
      public function get WaterCount() : int
      {
         return this.FWaterCount;
      }
      
      public function set WaterCount(param1:int) : void
      {
         this.FWaterCount = param1;
      }
      
      public function get NextTime() : int
      {
         return this.FNextTime;
      }
      
      public function set NextTime(param1:int) : void
      {
         this.FNextTime = param1;
      }
      
      public function get ShowItems() : TInventories
      {
         return this.FShowItems;
      }
      
      public function set ShowItems(param1:TInventories) : void
      {
         this.FShowItems = param1;
      }
      
      public function get WaterReward() : TInventories
      {
         return this.FWaterReward;
      }
      
      public function set WaterReward(param1:TInventories) : void
      {
         this.FWaterReward = param1;
      }
      
      public function get FruitList() : TInventories
      {
         return this.FFruitList;
      }
      
      public function set FruitList(param1:TInventories) : void
      {
         this.FFruitList = param1;
      }
      
      public function get CurGold() : int
      {
         return this.FCurGold;
      }
      
      public function set CurGold(param1:int) : void
      {
         this.FCurGold = param1;
      }
      
      public function get MaxGold() : int
      {
         return this.FMaxGold;
      }
      
      public function set MaxGold(param1:int) : void
      {
         this.FMaxGold = param1;
      }
      
      public function get FruitStatus() : Vector.<int>
      {
         return this.FFruitStatus;
      }
      
      public function set FruitStatus(param1:Vector.<int>) : void
      {
         this.FFruitStatus = param1;
      }
      
      public function get WaterPrice() : int
      {
         return this.FWaterPrice;
      }
      
      public function set WaterPrice(param1:int) : void
      {
         this.FWaterPrice = param1;
      }
      
      public function ChangeStatus() : void
      {
         var _loc1_:int = 0;
         if(this.FNextTime - STimingCore.GetServerTick() <= 0)
         {
            _loc1_ = 0;
            while(_loc1_ < this.FFruitStatus.length)
            {
               if(this.FFruitStatus[_loc1_] != TBaseActivity.STATUS_GETED)
               {
                  this.FFruitStatus[_loc1_] = TBaseActivity.STATUS_CANGET;
               }
               _loc1_++;
            }
         }
      }
   }
}

