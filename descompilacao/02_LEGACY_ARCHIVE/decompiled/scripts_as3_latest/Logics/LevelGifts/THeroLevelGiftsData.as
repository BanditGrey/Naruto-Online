package Logics.LevelGifts
{
   import Logics.Exercise.TBaseActivity;
   
   public class THeroLevelGiftsData extends TBaseActivity
   {
      
      protected var FLevelGifts:Vector.<THeroLevelGiftsVO>;
      
      public function THeroLevelGiftsData()
      {
         super();
         this.FLevelGifts = new Vector.<THeroLevelGiftsVO>();
      }
      
      public function GetTLevelGiftsByIdentifier(param1:uint) : THeroLevelGiftsVO
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:THeroLevelGiftsVO = null;
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
      
      public function get LevelGifts() : Vector.<THeroLevelGiftsVO>
      {
         return this.FLevelGifts;
      }
      
      public function Add(param1:THeroLevelGiftsVO) : void
      {
         this.FLevelGifts.push(param1);
      }
      
      public function Clear() : void
      {
         this.FLevelGifts.length = 0;
      }
   }
}

