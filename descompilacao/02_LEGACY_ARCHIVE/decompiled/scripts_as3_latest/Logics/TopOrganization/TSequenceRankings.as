package Logics.TopOrganization
{
   public class TSequenceRankings
   {
      
      protected var FSequenceRankings:Vector.<TSequenceRanking>;
      
      public function TSequenceRankings()
      {
         super();
         this.FSequenceRankings = new Vector.<TSequenceRanking>();
      }
      
      public function get Count() : uint
      {
         return this.FSequenceRankings.length;
      }
      
      public function Add(param1:TSequenceRanking) : void
      {
         this.FSequenceRankings.push(param1);
      }
      
      public function GetTopOrganizationReportByIndex(param1:int) : TSequenceRanking
      {
         if(param1 < 0 || param1 >= this.FSequenceRankings.length)
         {
            return null;
         }
         return this.FSequenceRankings[param1];
      }
      
      public function Clear() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc1_ = int(this.FSequenceRankings.length);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            this.FSequenceRankings.pop();
            _loc2_++;
         }
         this.FSequenceRankings.length = 0;
      }
   }
}

