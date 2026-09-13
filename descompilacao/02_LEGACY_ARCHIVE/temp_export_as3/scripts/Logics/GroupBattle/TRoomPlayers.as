package Logics.GroupBattle
{
   import Logics.SLogicsCore;
   
   public class TRoomPlayers
   {
      
      protected const CAPACITY_PLAYERS:uint = 3;
      
      protected var FRoomPlayers:Vector.<TRoomPlayer>;
      
      public function TRoomPlayers()
      {
         super();
         this.FRoomPlayers = new Vector.<TRoomPlayer>(this.CAPACITY_PLAYERS);
      }
      
      public function get Count() : uint
      {
         return this.FRoomPlayers.length;
      }
      
      public function GetRoomPlayerByIndex(param1:int) : TRoomPlayer
      {
         if(param1 >= this.FRoomPlayers.length)
         {
            return null;
         }
         return this.FRoomPlayers[param1];
      }
      
      public function Clear() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc1_ = int(this.FRoomPlayers.length);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            this.FRoomPlayers[_loc2_] = null;
            _loc2_++;
         }
      }
      
      public function AddByIndex(param1:int, param2:TRoomPlayer) : void
      {
         this.FRoomPlayers[param1] = param2;
      }
      
      public function Add(param1:TRoomPlayer) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc2_ = int(this.FRoomPlayers.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            if(this.FRoomPlayers[_loc3_] != null)
            {
               this.FRoomPlayers[_loc3_] = param1;
            }
            _loc3_++;
         }
      }
      
      public function DeleteRoomPlayerByIdentifier(param1:uint, param2:uint) : void
      {
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:TRoomPlayer = null;
         _loc4_ = this.FRoomPlayers.length;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc5_ = this.FRoomPlayers[_loc3_];
            if(_loc5_ != null && param1 == _loc5_.Identifier0 && param2 == _loc5_.Identifier1)
            {
               this.FRoomPlayers[_loc3_] = null;
               break;
            }
            _loc3_++;
         }
      }
      
      public function GetRoomPlayerByIdentifier(param1:uint, param2:uint) : TRoomPlayer
      {
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:TRoomPlayer = null;
         _loc4_ = this.FRoomPlayers.length;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc5_ = this.FRoomPlayers[_loc3_];
            if(_loc5_ != null && param1 == _loc5_.Identifier0 && param2 == _loc5_.Identifier1)
            {
               return _loc5_;
            }
            _loc3_++;
         }
         return null;
      }
      
      public function Delete(param1:int) : void
      {
         this.FRoomPlayers[param1] = null;
      }
      
      public function ExchangeSequence(param1:int, param2:int) : void
      {
         var _loc3_:TRoomPlayer = null;
         _loc3_ = this.FRoomPlayers[param1];
         this.FRoomPlayers[param1] = this.FRoomPlayers[param2];
         this.FRoomPlayers[param2] = _loc3_;
      }
      
      public function ResetReadyStatus() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TRoomPlayer = null;
         _loc2_ = this.FRoomPlayers.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FRoomPlayers[_loc1_];
            if(_loc3_ != null && _loc1_ != SLogicsCore.GroupBattleData.RoomDetailInfo.HostIndex)
            {
               _loc3_.IsReady = 0;
            }
            _loc1_++;
         }
      }
   }
}

