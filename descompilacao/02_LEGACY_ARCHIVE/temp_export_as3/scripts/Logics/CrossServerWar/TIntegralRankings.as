package Logics.CrossServerWar
{
   public class TIntegralRankings
   {
      
      protected var FIntegralRankings:Vector.<TIntegralRanking>;
      
      public function TIntegralRankings()
      {
         super();
         this.FIntegralRankings = new Vector.<TIntegralRanking>();
      }
      
      protected function SortByRank(param1:TIntegralRanking, param2:TIntegralRanking) : int
      {
         if(param1.CurRanking > param2.CurRanking)
         {
            return 1;
         }
         if(param1.CurRanking < param2.CurRanking)
         {
            return -1;
         }
         return 0;
      }
      
      public function get Count() : int
      {
         return this.FIntegralRankings.length;
      }
      
      public function GetIntegralRankingByIndex(param1:int) : TIntegralRanking
      {
         return this.FIntegralRankings[param1];
      }
      
      public function Add(param1:TIntegralRanking) : void
      {
         this.FIntegralRankings.push(param1);
      }
      
      public function Clear() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TIntegralRanking = null;
         _loc1_ = int(this.FIntegralRankings.length);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            this.FIntegralRankings.pop();
            _loc2_++;
         }
         this.FIntegralRankings.length = 0;
      }
      
      public function Sort() : void
      {
         this.FIntegralRankings.sort(this.SortByRank);
      }
   }
}

