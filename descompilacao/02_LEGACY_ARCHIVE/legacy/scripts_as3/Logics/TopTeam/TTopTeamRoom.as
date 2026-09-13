package Logics.TopTeam
{
   public class TTopTeamRoom
   {
      
      protected var FRoomID:uint;
      
      protected var FRoomPlayerCount:uint;
      
      protected var FCaptainID0:uint;
      
      protected var FCaptainID1:uint;
      
      protected var FCaptainName:String;
      
      protected var FHasPassword:Boolean;
      
      protected var FRoomStatus:Boolean;
      
      public function TTopTeamRoom()
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
      
      public function get CaptainName() : String
      {
         return this.FCaptainName;
      }
      
      public function set CaptainName(param1:String) : void
      {
         this.FCaptainName = param1;
      }
      
      public function get CaptainID0() : uint
      {
         return this.FCaptainID0;
      }
      
      public function set CaptainID0(param1:uint) : void
      {
         this.FCaptainID0 = param1;
      }
      
      public function get CaptainID1() : uint
      {
         return this.FCaptainID1;
      }
      
      public function set CaptainID1(param1:uint) : void
      {
         this.FCaptainID1 = param1;
      }
   }
}

