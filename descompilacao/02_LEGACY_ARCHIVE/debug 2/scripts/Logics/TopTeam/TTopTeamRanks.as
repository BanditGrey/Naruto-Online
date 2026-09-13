package Logics.TopTeam
{
   public class TTopTeamRanks
   {
      
      protected var FTopTeamRanks:Vector.<TTopTeamRank>;
      
      public function TTopTeamRanks()
      {
         super();
         this.FTopTeamRanks = new Vector.<TTopTeamRank>();
      }
      
      public function get Count() : uint
      {
         return this.FTopTeamRanks.length;
      }
      
      public function Add(param1:TTopTeamRank) : void
      {
         this.FTopTeamRanks.push(param1);
      }
      
      public function GetTopTeamRankByIndex(param1:int) : TTopTeamRank
      {
         if(param1 < 0 || param1 >= this.FTopTeamRanks.length)
         {
            return null;
         }
         return this.FTopTeamRanks[param1];
      }
      
      public function Clear() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc1_ = int(this.FTopTeamRanks.length);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            this.FTopTeamRanks.pop();
            _loc2_++;
         }
         this.FTopTeamRanks.length = 0;
      }
   }
}

