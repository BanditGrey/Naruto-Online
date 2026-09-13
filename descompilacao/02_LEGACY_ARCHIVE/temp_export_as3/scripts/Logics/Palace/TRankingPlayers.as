package Logics.Palace
{
   public class TRankingPlayers
   {
      
      protected var FRankingPlayers:Vector.<TRankingPlayer>;
      
      public function TRankingPlayers()
      {
         super();
         this.FRankingPlayers = new Vector.<TRankingPlayer>();
      }
      
      public function get Count() : uint
      {
         return this.FRankingPlayers.length;
      }
      
      public function GetRankingPlayerByIndex(param1:int) : TRankingPlayer
      {
         return this.FRankingPlayers[param1];
      }
      
      public function Clear() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TRankingPlayer = null;
         _loc1_ = int(this.FRankingPlayers.length);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            this.FRankingPlayers.pop();
            _loc2_++;
         }
         this.FRankingPlayers.length = 0;
      }
      
      public function AddByIndex(param1:int, param2:TRankingPlayer) : void
      {
         this.FRankingPlayers[param1] = param2;
      }
      
      public function Delete(param1:int) : void
      {
         var _loc2_:TRankingPlayer = null;
         _loc2_ = this.FRankingPlayers[param1];
         this.FRankingPlayers.splice(param1,1);
      }
   }
}

