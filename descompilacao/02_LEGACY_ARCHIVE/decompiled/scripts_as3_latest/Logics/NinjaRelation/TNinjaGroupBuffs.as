package Logics.NinjaRelation
{
   public class TNinjaGroupBuffs
   {
      
      protected var FNinjaGroupBuffs:Vector.<TNinjaGroupBuff>;
      
      public function TNinjaGroupBuffs()
      {
         super();
         this.FNinjaGroupBuffs = new Vector.<TNinjaGroupBuff>();
      }
      
      public function get Count() : int
      {
         return this.FNinjaGroupBuffs.length;
      }
      
      public function Add(param1:TNinjaGroupBuff) : void
      {
         this.FNinjaGroupBuffs.push(param1);
      }
      
      public function GetNinjaGroupBuffByIdentifier(param1:uint) : TNinjaGroupBuff
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TNinjaGroupBuff = null;
         _loc2_ = int(this.FNinjaGroupBuffs.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = this.FNinjaGroupBuffs[_loc3_];
            if(_loc4_.TeamID == param1)
            {
               return _loc4_;
            }
            _loc3_++;
         }
         return null;
      }
      
      public function GetNinjaGroupBuffByIndex(param1:int) : TNinjaGroupBuff
      {
         if(param1 >= this.FNinjaGroupBuffs.length)
         {
            return null;
         }
         return this.FNinjaGroupBuffs[param1];
      }
      
      public function Clear() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc1_ = int(this.FNinjaGroupBuffs.length);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            this.FNinjaGroupBuffs.pop();
            _loc2_++;
         }
         this.FNinjaGroupBuffs.length = 0;
      }
   }
}

