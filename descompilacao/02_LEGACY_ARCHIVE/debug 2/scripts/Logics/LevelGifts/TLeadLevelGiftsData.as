package Logics.LevelGifts
{
   import Logics.Exercise.TBaseActivity;
   
   public class TLeadLevelGiftsData extends TBaseActivity
   {
      
      protected var FLevelGifts:Vector.<TLeadLevelGiftsVO>;
      
      public function TLeadLevelGiftsData()
      {
         super();
         this.FLevelGifts = new Vector.<TLeadLevelGiftsVO>();
      }
      
      public function GetTLevelGiftsByIdentifier(param1:uint) : TLeadLevelGiftsVO
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:TLeadLevelGiftsVO = null;
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
      
      public function get LevelGifts() : Vector.<TLeadLevelGiftsVO>
      {
         return this.FLevelGifts;
      }
      
      public function Add(param1:TLeadLevelGiftsVO) : void
      {
         this.FLevelGifts.push(param1);
      }
      
      public function Clear() : void
      {
         this.FLevelGifts.length = 0;
      }
   }
}

