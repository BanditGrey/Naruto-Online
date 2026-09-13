package Logics.Exercise.MoonFestival
{
   import Foundation.Timing.STimingCore;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   
   public class TMoonFestival1 extends TBaseActivity
   {
      
      public var WaterReduceTime:int;
      
      public var TreeLevel:int;
      
      public var WaterCount:int;
      
      public var NextTime:int;
      
      public var CurGold:int;
      
      public var MaxGold:int;
      
      public var WaterPrice:int;
      
      public var ShowItems:TInventories;
      
      public var FruitList:TInventories;
      
      public var FruitStatus:Vector.<int>;
      
      public var GiftList:Vector.<TBaseBox>;
      
      public function TMoonFestival1()
      {
         super();
         this.FruitStatus = new Vector.<int>();
         this.GiftList = new Vector.<TBaseBox>();
      }
      
      public function ChangeStatus() : void
      {
         var _loc1_:int = 0;
         if(this.NextTime - STimingCore.GetServerTick() <= 0)
         {
            _loc1_ = 0;
            while(_loc1_ < this.FruitStatus.length)
            {
               if(this.FruitStatus[_loc1_] != TBaseActivity.STATUS_GETED)
               {
                  this.FruitStatus[_loc1_] = TBaseActivity.STATUS_CANGET;
               }
               _loc1_++;
            }
         }
      }
   }
}

