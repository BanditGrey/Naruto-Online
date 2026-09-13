package Logics.TopTeam
{
   import Logics.GroupBattle.TInviteShadows;
   import Logics.Inventories.TInventorySamples;
   
   public class TTopTeamData
   {
      
      protected var FFunctionIsOpen:uint;
      
      protected var FIsStayHall:uint;
      
      protected var FRestPlayCount:uint;
      
      protected var FMatchStatus:uint;
      
      protected var FInviteList:TInviteShadows;
      
      protected var FNinjaPoint:uint;
      
      protected var FMyRank:uint;
      
      protected var FTopTeamRanks:TTopTeamRanks;
      
      protected var FTopTeamRooms:TTopTeamRooms;
      
      protected var FHallPlayers:THallPlayers;
      
      protected var FTopTeamRoomDetailInfo:TTopTeamRoomDetailInfo;
      
      protected var FInventorySamples:TInventorySamples;
      
      protected var FRapidInviteTime:uint;
      
      protected var FWorldInviteTime:uint;
      
      protected var FIsAutoStartSign:Boolean;
      
      protected var FIsInBattle:Boolean;
      
      public function TTopTeamData()
      {
         super();
         this.FTopTeamRanks = new TTopTeamRanks();
         this.FInventorySamples = new TInventorySamples();
         this.FTopTeamRooms = new TTopTeamRooms();
         this.FTopTeamRoomDetailInfo = new TTopTeamRoomDetailInfo();
         this.FHallPlayers = new THallPlayers();
         this.FInviteList = new TInviteShadows();
         this.FIsAutoStartSign = false;
         this.FIsInBattle = false;
      }
      
      public function get FunctionIsOpen() : uint
      {
         return this.FFunctionIsOpen;
      }
      
      public function set FunctionIsOpen(param1:uint) : void
      {
         this.FFunctionIsOpen = param1;
      }
      
      public function get RestPlayCount() : uint
      {
         return this.FRestPlayCount;
      }
      
      public function set RestPlayCount(param1:uint) : void
      {
         this.FRestPlayCount = param1;
      }
      
      public function get IsStayHall() : uint
      {
         return this.FIsStayHall;
      }
      
      public function set IsStayHall(param1:uint) : void
      {
         this.FIsStayHall = param1;
      }
      
      public function get TopTeamRooms() : TTopTeamRooms
      {
         return this.FTopTeamRooms;
      }
      
      public function set TopTeamRooms(param1:TTopTeamRooms) : void
      {
         this.FTopTeamRooms = param1;
      }
      
      public function get TopTeamRoomDetailInfo() : TTopTeamRoomDetailInfo
      {
         return this.FTopTeamRoomDetailInfo;
      }
      
      public function set TopTeamRoomDetailInfo(param1:TTopTeamRoomDetailInfo) : void
      {
         this.FTopTeamRoomDetailInfo = param1;
      }
      
      public function get TopTeamRanks() : TTopTeamRanks
      {
         return this.FTopTeamRanks;
      }
      
      public function set TopTeamRanks(param1:TTopTeamRanks) : void
      {
         this.FTopTeamRanks = param1;
      }
      
      public function get MyRank() : uint
      {
         return this.FMyRank;
      }
      
      public function set MyRank(param1:uint) : void
      {
         this.FMyRank = param1;
      }
      
      public function get InventorySamples() : TInventorySamples
      {
         return this.FInventorySamples;
      }
      
      public function set InventorySamples(param1:TInventorySamples) : void
      {
         this.FInventorySamples = param1;
      }
      
      public function get MatchStatus() : uint
      {
         return this.FMatchStatus;
      }
      
      public function set MatchStatus(param1:uint) : void
      {
         this.FMatchStatus = param1;
      }
      
      public function get InviteList() : TInviteShadows
      {
         return this.FInviteList;
      }
      
      public function set InviteList(param1:TInviteShadows) : void
      {
         this.FInviteList = param1;
      }
      
      public function get NinjaPoint() : uint
      {
         return this.FNinjaPoint;
      }
      
      public function set NinjaPoint(param1:uint) : void
      {
         this.FNinjaPoint = param1;
      }
      
      public function get IsAutoStartSign() : Boolean
      {
         return this.FIsAutoStartSign;
      }
      
      public function set IsAutoStartSign(param1:Boolean) : void
      {
         this.FIsAutoStartSign = param1;
      }
      
      public function get HallPlayers() : THallPlayers
      {
         return this.FHallPlayers;
      }
      
      public function set HallPlayers(param1:THallPlayers) : void
      {
         this.FHallPlayers = param1;
      }
      
      public function get RapidInviteTime() : uint
      {
         return this.FRapidInviteTime;
      }
      
      public function set RapidInviteTime(param1:uint) : void
      {
         this.FRapidInviteTime = param1;
      }
      
      public function get WorldInviteTime() : uint
      {
         return this.FWorldInviteTime;
      }
      
      public function set WorldInviteTime(param1:uint) : void
      {
         this.FWorldInviteTime = param1;
      }
      
      public function get IsInBattle() : Boolean
      {
         return this.FIsInBattle;
      }
      
      public function set IsInBattle(param1:Boolean) : void
      {
         this.FIsInBattle = param1;
      }
   }
}

