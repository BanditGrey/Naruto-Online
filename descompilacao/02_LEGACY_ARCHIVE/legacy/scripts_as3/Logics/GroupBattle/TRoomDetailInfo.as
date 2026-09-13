package Logics.GroupBattle
{
   public class TRoomDetailInfo
   {
      
      protected var FRoomID:uint;
      
      protected var FPassword:String;
      
      protected var FMissionID:uint;
      
      protected var FGroupBattleLevel:TGroupBattleLevel;
      
      protected var FHostIndex:int;
      
      protected var FSelfIndex:int;
      
      protected var FRoomPlayers:TRoomPlayers;
      
      public function TRoomDetailInfo()
      {
         super();
         this.FRoomPlayers = new TRoomPlayers();
      }
      
      public function get RoomID() : uint
      {
         return this.FRoomID;
      }
      
      public function set RoomID(param1:uint) : void
      {
         this.FRoomID = param1;
      }
      
      public function get Password() : String
      {
         return this.FPassword;
      }
      
      public function set Password(param1:String) : void
      {
         this.FPassword = param1;
      }
      
      public function get MissionID() : uint
      {
         return this.FMissionID;
      }
      
      public function set MissionID(param1:uint) : void
      {
         this.FMissionID = param1;
      }
      
      public function get HostIndex() : int
      {
         return this.FHostIndex;
      }
      
      public function set HostIndex(param1:int) : void
      {
         this.FHostIndex = param1;
      }
      
      public function get SelfIndex() : int
      {
         return this.FSelfIndex;
      }
      
      public function set SelfIndex(param1:int) : void
      {
         this.FSelfIndex = param1;
      }
      
      public function get RoomPlayers() : TRoomPlayers
      {
         return this.FRoomPlayers;
      }
      
      public function set RoomPlayers(param1:TRoomPlayers) : void
      {
         this.FRoomPlayers = param1;
      }
      
      public function get GroupBattleLevel() : TGroupBattleLevel
      {
         return this.FGroupBattleLevel;
      }
      
      public function set GroupBattleLevel(param1:TGroupBattleLevel) : void
      {
         this.FGroupBattleLevel = param1;
      }
      
      public function Reset() : void
      {
         this.FRoomID = 0;
         this.FPassword = "";
         this.FMissionID = 0;
         this.FGroupBattleLevel = null;
         this.FHostIndex = 0;
         this.FSelfIndex = 0;
         this.FRoomPlayers.Clear();
      }
   }
}

