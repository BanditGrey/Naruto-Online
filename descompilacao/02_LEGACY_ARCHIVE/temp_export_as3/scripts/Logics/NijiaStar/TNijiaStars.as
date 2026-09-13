package Logics.NijiaStar
{
   import Resources.Constants.CONST_NIJIASTAR;
   
   public class TNijiaStars
   {
      
      protected var FNijiaStars:Vector.<TNijiaStar>;
      
      public function TNijiaStars()
      {
         super();
         this.FNijiaStars = new Vector.<TNijiaStar>(CONST_NIJIASTAR.CAPACITY_NijiaStar);
      }
      
      public function get Count() : int
      {
         return this.FNijiaStars.length;
      }
      
      public function Add(param1:TNijiaStar) : void
      {
         this.FNijiaStars.push(param1);
      }
      
      public function GetNijiaStarByIndex(param1:int) : TNijiaStar
      {
         if(param1 >= this.FNijiaStars.length)
         {
            return null;
         }
         return this.FNijiaStars[param1];
      }
      
      public function SetNijiaStarByIndex(param1:int, param2:TNijiaStar) : void
      {
         this.FNijiaStars[param1] = param2;
      }
      
      public function Clear() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TNijiaStar = null;
         _loc1_ = int(this.FNijiaStars.length);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            this.FNijiaStars.pop();
            _loc2_++;
         }
         this.FNijiaStars.length = 0;
      }
   }
}

