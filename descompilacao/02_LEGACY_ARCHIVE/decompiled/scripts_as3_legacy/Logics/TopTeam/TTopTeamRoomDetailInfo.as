package Logics.TopTeam
{
   import Logics.GroupBattle.TRoomPlayers;
   
   public class TTopTeamRoomDetailInfo
   {
      
      protected var FRoomID:uint;
      
      protected var FServerName:String;
      
      protected var FRoomPlayers:TRoomPlayers;
      
      protected var FPassword:String;
      
      protected var FCurrentSequentWins:uint;
      
      protected var FSequentScores:uint;
      
      protected var FTodayScores:uint;
      
      protected var FTodayNinjaPoint:uint;
      
      protected var FCurrentRank:uint;
      
      protected var FTotalNinjaPoint:uint;
      
      public function TTopTeamRoomDetailInfo()
      {
         super();
         this.FRoomID = 0;
         this.FServerName = "";
         this.FPassword = "";
         this.FRoomPlayers = new TRoomPlayers();
         this.FCurrentSequentWins = 0;
         this.FSequentScores = 0;
         this.FTodayNinjaPoint = 0;
         this.FCurrentRank = 0;
         this.FTotalNinjaPoint = 0;
      }
      
      public function get RoomID() : uint
      {
         return this.FRoomID;
      }
      
      public function set RoomID(param1:uint) : void
      {
         this.FRoomID = param1;
      }
      
      public function get ServerName() : String
      {
         return this.FServerName;
      }
      
      public function set ServerName(param1:String) : void
      {
         this.FServerName = param1;
      }
      
      public function get RoomPlayers() : TRoomPlayers
      {
         return this.FRoomPlayers;
      }
      
      public function set RoomPlayers(param1:TRoomPlayers) : void
      {
         this.FRoomPlayers = param1;
      }
      
      public function get Password() : String
      {
         return this.FPassword;
      }
      
      public function set Password(param1:String) : void
      {
         this.FPassword = param1;
      }
      
      public function get CurrentSequentWins() : uint
      {
         return this.FCurrentSequentWins;
      }
      
      public function set CurrentSequentWins(param1:uint) : void
      {
         this.FCurrentSequentWins = param1;
      }
      
      public function get SequentScores() : uint
      {
         return this.FSequentScores;
      }
      
      public function set SequentScores(param1:uint) : void
      {
         this.FSequentScores = param1;
      }
      
      public function get TodayNinjaPoint() : uint
      {
         return this.FTodayNinjaPoint;
      }
      
      public function set TodayNinjaPoint(param1:uint) : void
      {
         this.FTodayNinjaPoint = param1;
      }
      
      public function get CurrentRank() : uint
      {
         return this.FCurrentRank;
      }
      
      public function set CurrentRank(param1:uint) : void
      {
         this.FCurrentRank = param1;
      }
      
      public function get TotalNinjaPoint() : uint
      {
         return this.FTotalNinjaPoint;
      }
      
      public function set TotalNinjaPoint(param1:uint) : void
      {
         this.FTotalNinjaPoint = param1;
      }
      
      public function get TodayScores() : uint
      {
         return this.FTodayScores;
      }
      
      public function set TodayScores(param1:uint) : void
      {
         this.FTodayScores = param1;
      }
   }
}

