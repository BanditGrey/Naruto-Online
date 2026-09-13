package Logics.Magic
{
   import Logics.DatebaseVO.VO.TMewBattle;
   
   public class TMagicLevels
   {
      
      protected var FMagicLevels:Vector.<TMewBattle>;
      
      public function TMagicLevels()
      {
         super();
         this.FMagicLevels = new Vector.<TMewBattle>();
      }
      
      public function get Count() : uint
      {
         return this.FMagicLevels.length;
      }
      
      public function GetMewBattleByIndex(param1:int) : TMewBattle
      {
         return this.FMagicLevels[param1];
      }
      
      public function Add(param1:TMewBattle) : void
      {
         this.FMagicLevels.push(param1);
      }
      
      public function GetMagicLevelByIdentifier(param1:uint) : TMewBattle
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:TMewBattle = null;
         _loc3_ = this.FMagicLevels.length;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = this.FMagicLevels[_loc2_];
            if(_loc4_.Identifier == param1)
            {
               return _loc4_;
            }
            _loc2_++;
         }
         return null;
      }
      
      public function GetMagicLevelByIndex(param1:uint) : TMewBattle
      {
         return this.FMagicLevels[param1];
      }
   }
}

