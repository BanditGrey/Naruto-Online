package Logics.GroupBattle
{
   public class TGroupBattleRoom
   {
      
      protected var FRoomID:uint;
      
      protected var FMissionID:uint;
      
      protected var FRoomName:String;
      
      protected var FRoomPlayerCount:uint;
      
      protected var FHasPassword:Boolean;
      
      protected var FRoomStatus:Boolean;
      
      public function TGroupBattleRoom()
      {
         super();
      }
      
      public function get RoomID() : uint
      {
         return this.FRoomID;
      }
      
      public function set RoomID(param1:uint) : void
      {
         this.FRoomID = param1;
      }
      
      public function get MissionID() : uint
      {
         return this.FMissionID;
      }
      
      public function set MissionID(param1:uint) : void
      {
         this.FMissionID = param1;
      }
      
      public function get RoomName() : String
      {
         return this.FRoomName;
      }
      
      public function set RoomName(param1:String) : void
      {
         this.FRoomName = param1;
      }
      
      public function get RoomPlayerCount() : uint
      {
         return this.FRoomPlayerCount;
      }
      
      public function set RoomPlayerCount(param1:uint) : void
      {
         this.FRoomPlayerCount = param1;
      }
      
      public function get HasPassword() : Boolean
      {
         return this.FHasPassword;
      }
      
      public function set HasPassword(param1:Boolean) : void
      {
         this.FHasPassword = param1;
      }
      
      public function get RoomStatus() : Boolean
      {
         return this.FRoomStatus;
      }
      
      public function set RoomStatus(param1:Boolean) : void
      {
         this.FRoomStatus = param1;
      }
   }
}

