package Logics.Palace
{
   public class TRankingPlayer
   {
      
      protected var FPlayerName:String;
      
      protected var FServerName:String;
      
      protected var FPlayerLevel:uint;
      
      protected var FRankIndex:uint;
      
      public function TRankingPlayer()
      {
         super();
      }
      
      public function get PlayerName() : String
      {
         return this.FPlayerName;
      }
      
      public function set PlayerName(param1:String) : void
      {
         this.FPlayerName = param1;
      }
      
      public function get ServerName() : String
      {
         return this.FServerName;
      }
      
      public function set ServerName(param1:String) : void
      {
         this.FServerName = param1;
      }
      
      public function get RankIndex() : uint
      {
         return this.FRankIndex;
      }
      
      public function set RankIndex(param1:uint) : void
      {
         this.FRankIndex = param1;
      }
      
      public function get PlayerLevel() : uint
      {
         return this.FPlayerLevel;
      }
      
      public function set PlayerLevel(param1:uint) : void
      {
         this.FPlayerLevel = param1;
      }
   }
}

