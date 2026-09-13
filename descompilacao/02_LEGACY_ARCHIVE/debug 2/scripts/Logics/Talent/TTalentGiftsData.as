package Logics.Talent
{
   public class TTalentGiftsData
   {
      
      protected var FTalentGifts:Vector.<TTalentGifts>;
      
      public function TTalentGiftsData()
      {
         super();
         this.FTalentGifts = new Vector.<TTalentGifts>();
      }
      
      public function GetTLevelGiftsByIdentifier(param1:uint) : TTalentGifts
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:TTalentGifts = null;
         _loc3_ = this.FTalentGifts.length;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = this.FTalentGifts[_loc2_];
            if(_loc4_.Identifier == param1)
            {
               return _loc4_;
            }
            _loc2_++;
         }
         return null;
      }
      
      public function get TalentGifts() : Vector.<TTalentGifts>
      {
         return this.FTalentGifts;
      }
      
      public function Add(param1:TTalentGifts) : void
      {
         this.FTalentGifts.push(param1);
      }
      
      public function Clear() : void
      {
         this.FTalentGifts.length = 0;
      }
   }
}

