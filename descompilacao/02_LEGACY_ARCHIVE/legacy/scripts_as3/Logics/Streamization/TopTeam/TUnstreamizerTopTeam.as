package Logics.Streamization.TopTeam
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TPvpMall;
   import Logics.GroupBattle.TInviteShadow;
   import Logics.GroupBattle.TInviteShadows;
   import Logics.GroupBattle.TRoomPlayer;
   import Logics.GroupBattle.TRoomPlayers;
   import Logics.Inventories.TInventorySample;
   import Logics.Inventories.TInventorySamples;
   import Logics.Streamization.Inventories.TUnstreamizerInventories;
   import Logics.Streamization.Inventories.TUnstreamizerInventorySample;
   import Logics.TopTeam.THallPlayer;
   import Logics.TopTeam.THallPlayers;
   import Logics.TopTeam.TTopTeamRank;
   import Logics.TopTeam.TTopTeamRanks;
   import Logics.TopTeam.TTopTeamRoom;
   import Logics.TopTeam.TTopTeamRoomDetailInfo;
   import Logics.TopTeam.TTopTeamRooms;
   import Resources.Constants.CONST_DATEBASEVO;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerTopTeam extends TUnstreamizerInventories
   {
      
      protected var FUnstreamizerInventorySample:TUnstreamizerInventorySample;
      
      public function TUnstreamizerTopTeam()
      {
         super();
         this.FUnstreamizerInventorySample = new TUnstreamizerInventorySample();
      }
      
      protected function UnstreamizationPerformTopTeamRooms(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:ByteArray = null;
         var _loc5_:TTopTeamRooms = null;
         var _loc6_:TTopTeamRoom = null;
         var _loc7_:int = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         _loc4_ = param1 as ByteArray;
         _loc5_ = param2 as TTopTeamRooms;
         _loc5_.Clear();
         _loc8_ = uint(_loc4_.readShort());
         _loc7_ = 0;
         while(_loc7_ < _loc8_)
         {
            _loc9_ = _loc4_.readUnsignedInt();
            _loc6_ = new TTopTeamRoom();
            _loc6_.RoomID = _loc9_;
            this.UpdateTopTeamRoomInfo(_loc4_,_loc6_);
            _loc5_.Add(_loc6_);
            _loc7_++;
         }
      }
      
      protected function UpdateTopTeamRoomInfo(param1:ByteArray, param2:TTopTeamRoom) : void
      {
         param2.RoomPlayerCount = param1.readUnsignedInt();
         param2.CaptainID0 = param1.readUnsignedInt();
         param2.CaptainID1 = param1.readUnsignedInt();
         param2.CaptainName = TUtilityString.FetchUTF(param1);
         param2.HasPassword = Boolean(param1.readUnsignedInt());
      }
      
      protected function UnstreamizationPerformRoomDetailInfo(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:ByteArray = null;
         var _loc5_:TTopTeamRoomDetailInfo = null;
         var _loc6_:int = 0;
         var _loc7_:uint = 0;
         var _loc8_:TRoomPlayers = null;
         var _loc9_:TRoomPlayer = null;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         _loc4_ = param1 as ByteArray;
         _loc5_ = param2 as TTopTeamRoomDetailInfo;
         _loc5_.RoomID = _loc4_.readUnsignedInt();
         _loc5_.ServerName = TUtilityString.FetchUTF(_loc4_);
         _loc5_.RoomPlayers.Clear();
         _loc7_ = uint(_loc4_.readShort());
         _loc6_ = 0;
         while(_loc6_ < _loc7_)
         {
            _loc10_ = _loc4_.readUnsignedInt();
            _loc11_ = _loc4_.readUnsignedInt();
            _loc9_ = new TRoomPlayer(_loc10_,_loc11_);
            _loc9_.PlayerName = TUtilityString.FetchUTF(_loc4_);
            _loc9_.PlayerModelID = _loc4_.readUnsignedInt();
            _loc9_.PlayerLevel = _loc4_.readUnsignedInt();
            _loc9_.FightPower.High = _loc4_.readUnsignedInt();
            _loc9_.FightPower.Low = _loc4_.readUnsignedInt();
            _loc9_.IsReady = _loc4_.readUnsignedInt();
            _loc9_.IsCaptaian = _loc4_.readUnsignedInt();
            _loc9_.PositionIndex = _loc4_.readUnsignedInt() - 1;
            _loc5_.RoomPlayers.AddByIndex(_loc9_.PositionIndex,_loc9_);
            _loc6_++;
         }
         _loc5_.Password = TUtilityString.FetchUTF(_loc4_);
         _loc5_.CurrentSequentWins = _loc4_.readUnsignedInt();
         _loc5_.SequentScores = _loc4_.readUnsignedInt();
         _loc5_.TodayScores = _loc4_.readUnsignedInt();
         _loc5_.TodayNinjaPoint = _loc4_.readUnsignedInt();
         _loc5_.TotalNinjaPoint = _loc4_.readUnsignedInt();
      }
      
      protected function UnstreamizationPerformTopTeamRanks(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:ByteArray = null;
         var _loc5_:TTopTeamRank = null;
         var _loc6_:TTopTeamRanks = null;
         var _loc7_:int = 0;
         var _loc8_:uint = 0;
         _loc4_ = param1 as ByteArray;
         _loc6_ = param2 as TTopTeamRanks;
         _loc6_.Clear();
         _loc8_ = uint(_loc4_.readShort());
         _loc7_ = 0;
         while(_loc7_ < _loc8_)
         {
            _loc5_ = new TTopTeamRank();
            _loc5_.Rank = _loc4_.readUnsignedInt();
            _loc5_.Name = TUtilityString.FetchUTF(_loc4_);
            _loc5_.Job = _loc4_.readUnsignedInt();
            _loc5_.Level = _loc4_.readUnsignedInt();
            _loc5_.Score = _loc4_.readUnsignedInt();
            _loc5_.PlatformName = TUtilityString.FetchUTF(_loc4_);
            _loc5_.ServerName = TUtilityString.FetchUTF(_loc4_);
            _loc6_.Add(_loc5_);
            _loc7_++;
         }
      }
      
      protected function UnstreamizationPerform_InventorySamplesByDatabase(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:int = 0;
         var _loc5_:uint = 0;
         var _loc6_:TBins = null;
         var _loc7_:TPvpMall = null;
         var _loc8_:TInventorySamples = null;
         var _loc9_:TInventorySample = null;
         _loc8_ = param2 as TInventorySamples;
         _loc6_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_PvpMall);
         _loc5_ = uint(_loc6_.Count);
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc7_ = _loc6_.GetDatebaseByIndex(_loc4_) as TPvpMall;
            _loc9_ = FPoolInventory.AcquireInventorySample();
            this.FUnstreamizerInventorySample.UnstreamizePvpMallByDatabase(null,_loc9_,_loc7_);
            _loc8_.Add(_loc9_);
            _loc4_++;
         }
      }
      
      protected function UnstreamizationPerform_Hall_Data_Notify(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:ByteArray = null;
         var _loc5_:TTopTeamRooms = null;
         var _loc6_:TTopTeamRoom = null;
         var _loc7_:int = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         _loc4_ = param1 as ByteArray;
         _loc5_ = param2 as TTopTeamRooms;
         _loc8_ = uint(_loc4_.readShort());
         _loc7_ = 0;
         while(_loc7_ < _loc8_)
         {
            _loc9_ = _loc4_.readUnsignedInt();
            _loc6_ = _loc5_.GetTopTeamRoomByRoomID(_loc9_);
            if(_loc6_ != null)
            {
               this.UpdateTopTeamRoomInfo(_loc4_,_loc6_);
            }
            else
            {
               _loc6_ = new TTopTeamRoom();
               _loc6_.RoomID = _loc9_;
               this.UpdateTopTeamRoomInfo(_loc4_,_loc6_);
               _loc5_.Add(_loc6_);
            }
            _loc7_++;
         }
      }
      
      protected function UnstreamizationPerform_Hall_Player_List(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:int = 0;
         var _loc5_:uint = 0;
         var _loc6_:THallPlayers = null;
         var _loc7_:THallPlayer = null;
         var _loc8_:ByteArray = null;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         _loc8_ = param1 as ByteArray;
         _loc6_ = param2 as THallPlayers;
         _loc6_.Clear();
         _loc5_ = uint(_loc8_.readShort());
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc9_ = _loc8_.readUnsignedInt();
            _loc10_ = _loc8_.readUnsignedInt();
            _loc7_ = new THallPlayer(_loc9_,_loc10_);
            _loc7_.Name = TUtilityString.FetchUTF(_loc8_);
            _loc7_.Level = _loc8_.readUnsignedInt();
            _loc7_.Job = _loc8_.readUnsignedInt();
            _loc7_.EnterTime = _loc8_.readUnsignedInt();
            _loc6_.Add(_loc7_);
            _loc4_++;
         }
         _loc6_.Sort();
      }
      
      protected function UnstreamizationPerformInviteList(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:int = 0;
         var _loc5_:uint = 0;
         var _loc6_:TInviteShadow = null;
         var _loc7_:TInviteShadows = null;
         var _loc8_:ByteArray = null;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         _loc8_ = param1 as ByteArray;
         _loc7_ = param2 as TInviteShadows;
         _loc7_.Clear();
         _loc5_ = uint(_loc8_.readShort());
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc9_ = _loc8_.readUnsignedInt();
            _loc10_ = _loc8_.readUnsignedInt();
            _loc6_ = new TInviteShadow(_loc9_,_loc10_);
            _loc6_.PlayerName = TUtilityString.FetchUTF(_loc8_);
            _loc6_.PlayerLevel = _loc8_.readUnsignedInt();
            _loc6_.FightPower.High = _loc8_.readUnsignedInt();
            _loc6_.FightPower.Low = _loc8_.readUnsignedInt();
            _loc7_.Add(_loc6_);
            _loc4_++;
         }
      }
      
      public function UnstreamizeTopTeamRooms(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerformTopTeamRooms(param1,param2,param3);
      }
      
      public function UnstreamizeRoomDetailInfo(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerformRoomDetailInfo(param1,param2,param3);
      }
      
      public function UnstreamizeTopTeamRanks(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerformTopTeamRanks(param1,param2,param3);
      }
      
      public function UnstreamizeInventorySamplesByDatabase(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform_InventorySamplesByDatabase(param1,param2,param3);
      }
      
      public function UnstreamizeHall_Data_Notify(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform_Hall_Data_Notify(param1,param2,param3);
      }
      
      public function UnstreamizeHall_Player_List(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform_Hall_Player_List(param1,param2,param3);
      }
      
      public function UnstreamizeInviteList(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerformInviteList(param1,param2,param3);
      }
   }
}

