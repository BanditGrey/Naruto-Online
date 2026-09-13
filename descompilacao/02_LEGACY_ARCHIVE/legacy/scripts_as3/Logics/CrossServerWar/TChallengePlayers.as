package Logics.CrossServerWar
{
   public class TChallengePlayers
   {
      
      protected var FChallengePlayers:Vector.<TChallengePlayer>;
      
      public function TChallengePlayers()
      {
         super();
         this.FChallengePlayers = new Vector.<TChallengePlayer>();
      }
      
      public function get Count() : int
      {
         return this.FChallengePlayers.length;
      }
      
      public function GetChallengePlayerByIndex(param1:int) : TChallengePlayer
      {
         return this.FChallengePlayers[param1];
      }
      
      public function Clear() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TChallengePlayer = null;
         _loc1_ = int(this.FChallengePlayers.length);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            this.FChallengePlayers.pop();
            _loc2_++;
         }
         this.FChallengePlayers.length = 0;
      }
      
      public function Add(param1:TChallengePlayer) : void
      {
         this.FChallengePlayers.push(param1);
      }
      
      public function Delete(param1:int) : void
      {
         var _loc2_:TChallengePlayer = null;
         _loc2_ = this.FChallengePlayers[param1];
         this.FChallengePlayers.splice(param1,1);
      }
   }
}

