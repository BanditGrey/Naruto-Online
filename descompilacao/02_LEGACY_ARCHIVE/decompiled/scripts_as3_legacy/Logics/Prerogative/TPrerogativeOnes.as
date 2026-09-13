package Logics.Prerogative
{
   public class TPrerogativeOnes
   {
      
      protected var FPrerogativeOnes:Vector.<TPrerogativeOne>;
      
      public function TPrerogativeOnes()
      {
         super();
         this.FPrerogativeOnes = new Vector.<TPrerogativeOne>();
      }
      
      protected function SortByType(param1:TPrerogativeOne, param2:TPrerogativeOne) : int
      {
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         _loc3_ = param1.Type;
         _loc4_ = param2.Type;
         if(_loc3_ > _loc4_)
         {
            return 1;
         }
         if(_loc3_ < _loc4_)
         {
            return -1;
         }
         return 0;
      }
      
      public function get Count() : uint
      {
         return this.FPrerogativeOnes.length;
      }
      
      public function Add(param1:TPrerogativeOne) : void
      {
         this.FPrerogativeOnes.push(param1);
      }
      
      public function GetPrerogativeOneByIndex(param1:int) : TPrerogativeOne
      {
         if(param1 < 0 || param1 >= this.FPrerogativeOnes.length)
         {
            return null;
         }
         return this.FPrerogativeOnes[param1];
      }
      
      public function GetPrerogativeOneByType(param1:uint) : TPrerogativeOne
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:TPrerogativeOne = null;
         _loc3_ = this.FPrerogativeOnes.length;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = this.FPrerogativeOnes[_loc2_];
            if(_loc4_.Type == param1)
            {
               return _loc4_;
            }
            _loc2_++;
         }
         return null;
      }
      
      public function GetPrerogativesByType(param1:uint) : TPrerogativeOnes
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:TPrerogativeOne = null;
         var _loc5_:TPrerogativeOnes = null;
         _loc5_ = new TPrerogativeOnes();
         _loc3_ = this.FPrerogativeOnes.length;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = this.FPrerogativeOnes[_loc2_];
            if(_loc4_.Type == param1)
            {
               _loc5_.Add(_loc4_);
            }
            _loc2_++;
         }
         return _loc5_;
      }
      
      public function Sort() : void
      {
         this.FPrerogativeOnes.sort(this.SortByType);
      }
      
      public function Clear() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc1_ = int(this.FPrerogativeOnes.length);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            this.FPrerogativeOnes.pop();
            _loc2_++;
         }
         this.FPrerogativeOnes.length = 0;
      }
   }
}

