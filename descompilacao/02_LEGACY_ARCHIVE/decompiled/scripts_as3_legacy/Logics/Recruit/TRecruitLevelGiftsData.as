package Logics.Recruit
{
   public class TRecruitLevelGiftsData
   {
      
      protected var FLevelGifts:Vector.<TRecruitLevelGifts>;
      
      public var Score:int;
      
      public function TRecruitLevelGiftsData()
      {
         super();
         this.FLevelGifts = new Vector.<TRecruitLevelGifts>();
      }
      
      public function GetTLevelGiftsByIdentifier(param1:uint) : TRecruitLevelGifts
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:TRecruitLevelGifts = null;
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
      
      public function get LevelGifts() : Vector.<TRecruitLevelGifts>
      {
         return this.FLevelGifts;
      }
      
      public function Add(param1:TRecruitLevelGifts) : void
      {
         this.FLevelGifts.push(param1);
      }
      
      public function Clear() : void
      {
         this.FLevelGifts.length = 0;
      }
   }
}

