package Logics.LevelGifts
{
   public class TLevelGiftsData
   {
      
      protected var FLevelGifts:Vector.<TLevelGifts>;
      
      public function TLevelGiftsData()
      {
         super();
         this.FLevelGifts = new Vector.<TLevelGifts>();
      }
      
      public function GetTLevelGiftsByIdentifier(param1:uint) : TLevelGifts
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:TLevelGifts = null;
         _loc3_ = this.FLevelGifts.length;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = this.FLevelGifts[_loc2_];
            if(_loc4_.Identifier == param1)
            {
               return _loc4_;
            }
            _loc2_++;
         }
         return null;
      }
      
      public function get LevelGifts() : Vector.<TLevelGifts>
      {
         return this.FLevelGifts;
      }
      
      public function Add(param1:TLevelGifts) : void
      {
         this.FLevelGifts.push(param1);
      }
      
      public function Clear() : void
      {
         this.FLevelGifts.length = 0;
      }
   }
}

