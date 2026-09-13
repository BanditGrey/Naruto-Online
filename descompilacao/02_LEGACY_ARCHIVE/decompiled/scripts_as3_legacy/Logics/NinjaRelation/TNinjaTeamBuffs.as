package Logics.NinjaRelation
{
   public class TNinjaTeamBuffs
   {
      
      protected var FNinjaTeamBuffs:Vector.<TNinjaTeamBuff>;
      
      public function TNinjaTeamBuffs()
      {
         super();
         this.FNinjaTeamBuffs = new Vector.<TNinjaTeamBuff>();
      }
      
      public function get Count() : int
      {
         return this.FNinjaTeamBuffs.length;
      }
      
      public function Add(param1:TNinjaTeamBuff) : void
      {
         this.FNinjaTeamBuffs.push(param1);
      }
      
      public function GetNinjaTeamBuffByIdentifier(param1:uint) : TNinjaTeamBuff
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TNinjaTeamBuff = null;
         _loc2_ = int(this.FNinjaTeamBuffs.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = this.FNinjaTeamBuffs[_loc3_];
            if(_loc4_.GourpID == param1)
            {
               return _loc4_;
            }
            _loc3_++;
         }
         return null;
      }
      
      public function GetNinjaTeamBuffByIndex(param1:int) : TNinjaTeamBuff
      {
         if(param1 >= this.FNinjaTeamBuffs.length)
         {
            return null;
         }
         return this.FNinjaTeamBuffs[param1];
      }
      
      public function Clear() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc1_ = int(this.FNinjaTeamBuffs.length);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            this.FNinjaTeamBuffs.pop();
            _loc2_++;
         }
         this.FNinjaTeamBuffs.length = 0;
      }
   }
}

