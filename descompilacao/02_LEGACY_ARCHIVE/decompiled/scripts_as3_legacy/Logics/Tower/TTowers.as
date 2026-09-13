package Logics.Tower
{
   import Logics.DatebaseVO.VO.TEnchantBattle;
   
   public class TTowers
   {
      
      protected var FTowers:Vector.<TEnchantBattle>;
      
      public function TTowers()
      {
         super();
         this.FTowers = new Vector.<TEnchantBattle>();
      }
      
      public function get Count() : uint
      {
         return this.FTowers.length;
      }
      
      public function GetEnchantBattleByIndex(param1:int) : TEnchantBattle
      {
         return this.FTowers[param1];
      }
      
      public function Add(param1:TEnchantBattle) : void
      {
         this.FTowers.push(param1);
      }
      
      public function Clear() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         _loc2_ = this.FTowers.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.FTowers.pop();
            _loc1_++;
         }
         this.FTowers.length = 0;
      }
   }
}

