package Logics.TopTeam
{
   public class TTopTeamRooms
   {
      
      protected var FTopTeamRooms:Vector.<TTopTeamRoom>;
      
      public function TTopTeamRooms()
      {
         super();
         this.FTopTeamRooms = new Vector.<TTopTeamRoom>();
      }
      
      protected function SortByID(param1:TTopTeamRoom, param2:TTopTeamRoom) : int
      {
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         _loc3_ = param1.RoomID;
         _loc4_ = param2.RoomID;
         if(_loc3_ > _loc4_)
         {
            return 1;
         }
         if(_loc3_ < _loc4_)
         {
            return -1;
         }
         return 0;
      }
      
      public function get Count() : uint
      {
         return this.FTopTeamRooms.length;
      }
      
      public function GetTopTeamRoomByIndex(param1:int) : TTopTeamRoom
      {
         if(param1 >= this.FTopTeamRooms.length)
         {
            return null;
         }
         return this.FTopTeamRooms[param1];
      }
      
      public function GetTopTeamRoomByRoomID(param1:uint) : TTopTeamRoom
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:TTopTeamRoom = null;
         _loc3_ = this.FTopTeamRooms.length;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = this.FTopTeamRooms[_loc2_];
            if(param1 == _loc4_.RoomID)
            {
               return _loc4_;
            }
            _loc2_++;
         }
         return null;
      }
      
      public function DeleteTopTeamRoomByRoomID(param1:uint) : void
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:TTopTeamRoom = null;
         _loc3_ = this.FTopTeamRooms.length;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = this.FTopTeamRooms[_loc2_];
            if(param1 == _loc4_.RoomID)
            {
               this.FTopTeamRooms.splice(_loc2_,1);
               break;
            }
            _loc2_++;
         }
      }
      
      public function Clear() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TTopTeamRoom = null;
         _loc1_ = int(this.FTopTeamRooms.length);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            this.FTopTeamRooms.pop();
            _loc2_++;
         }
         this.FTopTeamRooms.length = 0;
      }
      
      public function Add(param1:TTopTeamRoom) : void
      {
         this.FTopTeamRooms.push(param1);
      }
      
      public function Delete(param1:int) : void
      {
         var _loc2_:TTopTeamRoom = null;
         _loc2_ = this.FTopTeamRooms[param1];
         this.FTopTeamRooms.splice(param1,1);
      }
      
      public function Sort() : void
      {
         this.FTopTeamRooms.sort(this.SortByID);
      }
   }
}

