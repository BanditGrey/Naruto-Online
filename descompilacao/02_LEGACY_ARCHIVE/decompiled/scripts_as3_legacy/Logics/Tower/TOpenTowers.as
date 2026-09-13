package Logics.Tower
{
   import Resources.Constants.CONST_TOWER;
   
   public class TOpenTowers
   {
      
      protected var FOpenTowers:Vector.<TTower>;
      
      public function TOpenTowers()
      {
         super();
         this.FOpenTowers = new Vector.<TTower>(CONST_TOWER.CAPACITY_TowerCount);
      }
      
      public function get Count() : uint
      {
         return this.FOpenTowers.length;
      }
      
      public function GetTowerByIndex(param1:int) : TTower
      {
         return this.FOpenTowers[param1];
      }
      
      public function SetTowerByIndex(param1:int, param2:TTower) : void
      {
         this.FOpenTowers[param1] = param2;
      }
      
      public function Add(param1:TTower) : void
      {
         this.FOpenTowers.push(param1);
      }
      
      public function Clear() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         _loc2_ = this.FOpenTowers.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.FOpenTowers.pop();
            _loc1_++;
         }
         this.FOpenTowers.length = 0;
      }
   }
}

