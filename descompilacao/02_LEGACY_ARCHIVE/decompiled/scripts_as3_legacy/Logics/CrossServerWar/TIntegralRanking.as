package Logics.CrossServerWar
{
   public class TIntegralRanking
   {
      
      protected var FCurRanking:uint;
      
      protected var FPlayerName:String;
      
      protected var FServerName:String;
      
      protected var FPlayerLevel:uint;
      
      protected var FPlayerScore:uint;
      
      protected var FGroup:uint;
      
      public function TIntegralRanking()
      {
         super();
      }
      
      public function get CurRanking() : uint
      {
         return this.FCurRanking;
      }
      
      public function set CurRanking(param1:uint) : void
      {
         this.FCurRanking = param1;
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
      
      public function get PlayerLevel() : uint
      {
         return this.FPlayerLevel;
      }
      
      public function set PlayerLevel(param1:uint) : void
      {
         this.FPlayerLevel = param1;
      }
      
      public function get PlayerScore() : uint
      {
         return this.FPlayerScore;
      }
      
      public function set PlayerScore(param1:uint) : void
      {
         this.FPlayerScore = param1;
      }
      
      public function get Group() : uint
      {
         return this.FGroup;
      }
      
      public function set Group(param1:uint) : void
      {
         this.FGroup = param1;
      }
   }
}

