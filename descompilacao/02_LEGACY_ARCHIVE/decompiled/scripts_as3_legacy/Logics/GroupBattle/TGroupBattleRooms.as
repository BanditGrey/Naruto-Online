package Logics.GroupBattle
{
   public class TGroupBattleRooms
   {
      
      protected var FGroupBattleRooms:Vector.<TGroupBattleRoom>;
      
      public function TGroupBattleRooms()
      {
         super();
         this.FGroupBattleRooms = new Vector.<TGroupBattleRoom>();
      }
      
      protected function SortByMissionID(param1:TGroupBattleRoom, param2:TGroupBattleRoom) : int
      {
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         _loc3_ = param1.MissionID;
         _loc4_ = param2.MissionID;
         if(_loc3_ > _loc4_)
         {
            return -1;
         }
         if(_loc3_ < _loc4_)
         {
            return 1;
         }
         return 0;
      }
      
      public function get Count() : uint
      {
         return this.FGroupBattleRooms.length;
      }
      
      public function GetGroupBattleRoomByIndex(param1:int) : TGroupBattleRoom
      {
         if(param1 >= this.FGroupBattleRooms.length)
         {
            return null;
         }
         return this.FGroupBattleRooms[param1];
      }
      
      public function GetGroupBattleRoomByRoomID(param1:uint) : TGroupBattleRoom
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:TGroupBattleRoom = null;
         _loc3_ = this.FGroupBattleRooms.length;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = this.FGroupBattleRooms[_loc2_];
            if(param1 == _loc4_.RoomID)
            {
               return _loc4_;
            }
            _loc2_++;
         }
         return null;
      }
      
      public function DeleteGroupBattleRoomByRoomID(param1:uint) : void
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:TGroupBattleRoom = null;
         _loc3_ = this.FGroupBattleRooms.length;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = this.FGroupBattleRooms[_loc2_];
            if(param1 == _loc4_.RoomID)
            {
               this.FGroupBattleRooms.splice(_loc2_,1);
               break;
            }
            _loc2_++;
         }
      }
      
      public function Clear() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TGroupBattleRoom = null;
         _loc1_ = int(this.FGroupBattleRooms.length);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            this.FGroupBattleRooms.pop();
            _loc2_++;
         }
         this.FGroupBattleRooms.length = 0;
      }
      
      public function Add(param1:TGroupBattleRoom) : void
      {
         this.FGroupBattleRooms.push(param1);
      }
      
      public function Delete(param1:int) : void
      {
         var _loc2_:TGroupBattleRoom = null;
         _loc2_ = this.FGroupBattleRooms[param1];
         this.FGroupBattleRooms.splice(param1,1);
      }
      
      public function Sort() : void
      {
         this.FGroupBattleRooms.sort(this.SortByMissionID);
      }
   }
}

