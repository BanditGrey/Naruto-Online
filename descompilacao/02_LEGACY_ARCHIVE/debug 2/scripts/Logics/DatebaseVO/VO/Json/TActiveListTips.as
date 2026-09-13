package Logics.DatebaseVO.VO.Json
{
   public class TActiveListTips
   {
      
      protected var FValue:Vector.<String>;
      
      public function TActiveListTips(param1:Object)
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Array = null;
         super();
         _loc4_ = param1 as Array;
         _loc3_ = int(_loc4_.length);
         this.FValue = new Vector.<String>(_loc3_);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            this.FValue[_loc2_] = _loc4_[_loc2_];
            _loc2_++;
         }
      }
      
      public function get Value() : Vector.<String>
      {
         return this.FValue;
      }
   }
}

