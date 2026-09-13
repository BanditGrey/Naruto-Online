package Logics.Military
{
   import Foundation.Common.Integer.UInt64;
   
   public class THeroExpData
   {
      
      protected var FUpgradeNeedExp:Vector.<UInt64>;
      
      protected var FUpgradeNeedExpIndex:Vector.<int>;
      
      public function THeroExpData(param1:int)
      {
         super();
         this.FUpgradeNeedExp = new Vector.<UInt64>(300);
         this.FUpgradeNeedExpIndex = new Vector.<int>(300);
      }
      
      public function UpgradeNeedExp(param1:int) : UInt64
      {
         var _loc2_:int = this.FUpgradeNeedExpIndex.indexOf(param1);
         return this.FUpgradeNeedExp[_loc2_];
      }
      
      public function SetNeedExpByIndex(param1:int, param2:UInt64) : void
      {
         this.FUpgradeNeedExp[param1] = param2;
      }
      
      public function SetNeedExpIndexByIndex(param1:int, param2:int) : void
      {
         this.FUpgradeNeedExpIndex[param1] = param2;
      }
   }
}

