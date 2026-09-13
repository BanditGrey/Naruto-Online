package Logics.Streamization.GroupBattle
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Streamization.TUnstreamizer;
   import Foundation.Utilities.TUtilityString;
   import Logics.Campaign.TMonster;
   import Logics.Campaign.TMonsters;
   import Logics.Characters.THero;
   import Logics.DatebaseVO.VO.TEnemy;
   import Logics.DatebaseVO.VO.TEnemyArmy;
   import Logics.DatebaseVO.VO.TLeagueMapPve;
   import Logics.DatebaseVO.VO.TLeaguePointPath;
   import Logics.DatebaseVO.VO.TRoleModel;
   import Logics.GroupBattle.TGroupBattleData;
   import Logics.GroupBattle.TGroupBattleLevel;
   import Logics.GroupBattle.TGroupBattleLevels;
   import Logics.GroupBattle.TGroupBattleRoom;
   import Logics.GroupBattle.TGroupBattleRooms;
   import Logics.GroupBattle.TInviteShadow;
   import Logics.GroupBattle.TInviteShadows;
   import Logics.GroupBattle.TRoomDetailInfo;
   import Logics.GroupBattle.TRoomPlayer;
   import Logics.GroupBattle.TRoomPlayers;
   import Logics.GroupBattle.TShadowList;
   import Logics.GroupBattle.TShadowPlayer;
   import Logics.SLogicsCore;
   import Logics.Streamization.Characters.TUnstreamizerCharacter;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_GROUPBATTLE;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerGroupBattle extends TUnstreamizer
   {
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FUnstreamizerCharacter:TUnstreamizerCharacter;
      
      public function TUnstreamizerGroupBattle()
      {
         super();
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         this.FUnstreamizerCharacter = new TUnstreamizerCharacter();
      }
      
      protected function UnstreamizationPerformBattleLevelInfo(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:ByteArray = null;
         var _loc5_:TGroupBattleLevels = null;
         var _loc6_:TGroupBattleLevel = null;
         var _loc7_:int = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:TBins = null;
         var _loc11_:uint = 0;
         var _loc12_:int = 0;
         var _loc13_:TLeagueMapPve = null;
         var _loc14_:uint = 0;
         _loc4_ = param1 as ByteArray;
         _loc5_ = param2 as TGroupBattleLevels;
         _loc5_.Clear();
         _loc10_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_LeagueMapPve) as TBins;
         _loc8_ = uint(_loc4_.readShort());
         _loc7_ = 0;
         while(_loc7_ < _loc8_)
         {
            _loc9_ = _loc4_.readUnsignedInt();
            _loc6_ = this.CreateLevelInfo(_loc9_);
            _loc6_.IsServerData = true;
            _loc5_.Add(_loc6_);
            _loc7_++;
         }
         _loc5_.Sort();
         _loc5_.FilterCommon();
         _loc11_ = uint(_loc10_.Count);
         _loc12_ = 0;
         while(_loc12_ < _loc11_)
         {
            _loc13_ = _loc10_.GetDatebaseByIndex(_loc12_) as TLeagueMapPve;
            if(!this.CheckLevelID(_loc5_,_loc13_.Identifier))
            {
               _loc6_ = this.CreateLevelInfo(_loc13_.Identifier);
               _loc6_.IsServerData = false;
               _loc5_.Add(_loc6_);
            }
            _loc12_++;
         }
         _loc5_.Sort();
      }
      
      protected function CheckLevelID(param1:TGroupBattleLevels, param2:uint) : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:TGroupBattleLevel = null;
         _loc4_ = param1.Count;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc5_ = param1.GetGroupBattleLevelByIndex(_loc3_);
            if(_loc5_.LevelID == param2)
            {
               return true;
            }
            _loc3_++;
         }
         return false;
      }
      
      protected function CreateLevelInfo(param1:uint) : TGroupBattleLevel
      {
         var _loc2_:TGroupBattleLevel = null;
         var _loc3_:TLeagueMapPve = null;
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_LeagueMapPve,param1) as TLeagueMapPve;
         _loc2_ = new TGroupBattleLevel();
         _loc2_.LevelID = _loc3_.Identifier;
         _loc2_.LevelName = _loc3_.Name;
         _loc2_.SortIndex = _loc3_.Index;
         _loc2_.OpenLevel = _loc3_.Level;
         _loc2_.IsOpenLevel = SLogicsCore.Character.GetMainHeroLogicLevel(SLogicsCore.Character.GetMainLevel()) >= _loc3_.Level;
         _loc2_.RecommendLevel = _loc3_.Recommendlevel;
         _loc2_.PreLevel = _loc3_.Prev;
         _loc2_.NextOpen = _loc3_.NextHard;
         _loc2_.BigImage = _loc3_.BigImage;
         _loc2_.ExpAward = _loc3_.ExpAward;
         _loc2_.MoneyAward = _loc3_.MoneyAward;
         _loc2_.AwardInventories.Clear();
         this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc2_.AwardInventories,_loc3_.RewardsVect);
         return _loc2_;
      }
      
      protected function UnstreamizationPerformUpdateRoomInfo(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:ByteArray = null;
         var _loc5_:TGroupBattleRooms = null;
         var _loc6_:int = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         _loc4_ = param1 as ByteArray;
         _loc5_ = param2 as TGroupBattleRooms;
         _loc7_ = _loc4_.readUnsignedShort();
         _loc6_ = 0;
         while(_loc6_ < _loc7_)
         {
            _loc8_ = _loc4_.readUnsignedByte();
            switch(_loc8_)
            {
               case CONST_GROUPBATTLE.RoomType_Add:
                  this.CreatRoomInfo(_loc4_,_loc5_);
                  break;
               case CONST_GROUPBATTLE.RoomType_Update:
                  this.UpdateRoomInfo(_loc4_,_loc5_);
                  break;
               case CONST_GROUPBATTLE.RoomType_Delete:
                  this.DeleteRooInfo(_loc4_,_loc5_);
            }
            _loc6_++;
         }
      }
      
      protected function CreatRoomInfo(param1:ByteArray, param2:TGroupBattleRooms) : void
      {
         var _loc3_:TGroupBattleRoom = null;
         _loc3_ = new TGroupBattleRoom();
         _loc3_.RoomID = param1.readUnsignedInt();
         _loc3_.MissionID = param1.readUnsignedInt();
         _loc3_.RoomName = TUtilityString.FetchUTF(param1);
         _loc3_.RoomPlayerCount = param1.readUnsignedInt();
         _loc3_.HasPassword = Boolean(param1.readUnsignedByte());
         _loc3_.RoomStatus = Boolean(param1.readUnsignedByte());
         param2.Add(_loc3_);
      }
      
      protected function UpdateRoomInfo(param1:ByteArray, param2:TGroupBattleRooms) : void
      {
         var _loc3_:TGroupBattleRoom = null;
         var _loc4_:uint = 0;
         _loc4_ = param1.readUnsignedInt();
         _loc3_ = param2.GetGroupBattleRoomByRoomID(_loc4_);
         if(_loc3_ != null)
         {
            _loc3_.MissionID = param1.readUnsignedInt();
            _loc3_.RoomName = TUtilityString.FetchUTF(param1);
            _loc3_.RoomPlayerCount = param1.readUnsignedInt();
            _loc3_.HasPassword = Boolean(param1.readUnsignedByte());
            _loc3_.RoomStatus = Boolean(param1.readUnsignedByte());
         }
      }
      
      protected function DeleteRooInfo(param1:ByteArray, param2:TGroupBattleRooms) : void
      {
         var _loc3_:TGroupBattleRoom = null;
         var _loc4_:uint = 0;
         _loc4_ = param1.readUnsignedInt();
         param2.DeleteGroupBattleRoomByRoomID(_loc4_);
      }
      
      protected function UnstreamizationPerformRoomDetailInfo(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:ByteArray = null;
         var _loc5_:TRoomDetailInfo = null;
         var _loc6_:TRoomPlayers = null;
         var _loc7_:uint = 0;
         var _loc8_:TGroupBattleLevel = null;
         _loc4_ = param1 as ByteArray;
         _loc5_ = param2 as TRoomDetailInfo;
         _loc6_ = _loc5_.RoomPlayers;
         _loc5_.RoomID = _loc4_.readUnsignedInt();
         _loc5_.Password = TUtilityString.FetchUTF(_loc4_);
         _loc7_ = _loc4_.readUnsignedInt();
         _loc8_ = this.CreateLevelInfo(_loc7_);
         _loc5_.MissionID = _loc7_;
         _loc5_.GroupBattleLevel = _loc8_;
         _loc5_.HostIndex = _loc4_.readUnsignedByte();
         _loc5_.SelfIndex = _loc4_.readUnsignedByte();
         this.CreateRoomPlayerInfo(_loc4_,_loc6_);
      }
      
      protected function CreateRoomPlayerInfo(param1:ByteArray, param2:TRoomPlayers) : void
      {
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:TRoomPlayer = null;
         var _loc6_:uint = 0;
         var _loc7_:int = 0;
         var _loc8_:Vector.<uint> = null;
         var _loc9_:Vector.<uint> = null;
         var _loc10_:THero = null;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         var _loc13_:uint = 0;
         var _loc14_:uint = 0;
         var _loc15_:TRoleModel = null;
         _loc8_ = new Vector.<uint>();
         _loc9_ = new Vector.<uint>();
         _loc4_ = uint(param1.readShort());
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc11_ = param1.readUnsignedByte();
            _loc12_ = param1.readUnsignedInt();
            _loc13_ = param1.readUnsignedInt();
            _loc5_ = new TRoomPlayer(_loc12_,_loc13_);
            _loc5_.PositionIndex = _loc11_;
            _loc5_.PlayerModelID = param1.readUnsignedInt();
            _loc15_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_RoleModel,_loc5_.PlayerModelID) as TRoleModel;
            _loc5_.PlayerHeadID = _loc15_.Model;
            _loc5_.PlayerName = TUtilityString.FetchUTF(param1);
            _loc5_.PlayerLevel = param1.readShort();
            _loc5_.FightPower.High = param1.readUnsignedInt();
            _loc5_.FightPower.Low = param1.readUnsignedInt();
            _loc5_.IsReady = param1.readUnsignedByte();
            _loc5_.FriendBuff = Boolean(param1.readUnsignedByte());
            _loc5_.OrganizationBuff = Boolean(param1.readUnsignedByte());
            _loc5_.PetID = param1.readUnsignedInt();
            _loc6_ = _loc8_.length;
            _loc7_ = 0;
            while(_loc7_ < _loc6_)
            {
               _loc8_.pop();
               _loc7_++;
            }
            _loc8_.length = 0;
            _loc6_ = uint(param1.readShort());
            _loc7_ = 0;
            while(_loc7_ < _loc6_)
            {
               _loc8_.push(param1.readUnsignedInt());
               _loc9_.push(param1.readUnsignedByte());
               _loc7_++;
            }
            _loc5_.FamilyId = param1.readUnsignedByte();
            _loc5_.IsShadow = param1.readUnsignedByte();
            this.FUnstreamizerCharacter.UnstreamizeGenerateHerosByIdentifiers(null,_loc5_.Heros,_loc8_);
            _loc6_ = uint(_loc5_.Heros.Count);
            _loc7_ = 0;
            while(_loc7_ < _loc6_)
            {
               _loc10_ = _loc5_.Heros.GetHeroByIndex(_loc7_);
               _loc10_.FightPosition = CONST_GROUPBATTLE.MonsterMapPosition.indexOf(_loc9_[_loc7_]);
               _loc7_++;
            }
            param2.AddByIndex(_loc5_.PositionIndex,_loc5_);
            _loc3_++;
         }
      }
      
      protected function UnstreamizationPerformRoomPayerInfo(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:TRoomPlayers = null;
         _loc4_ = param2 as TRoomPlayers;
         this.CreateRoomPlayerInfo(param1,_loc4_);
      }
      
      protected function UnstreamizationPerformMonsterByDatabase(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:TLeaguePointPath = null;
         var _loc5_:TGroupBattleData = null;
         var _loc6_:TEnemyArmy = null;
         var _loc7_:int = 0;
         var _loc8_:uint = 0;
         var _loc9_:TMonster = null;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:int = 0;
         var _loc13_:TMonsters = null;
         var _loc14_:TRoleModel = null;
         var _loc15_:TEnemy = null;
         _loc5_ = param2 as TGroupBattleData;
         _loc5_.MonsterInfo.Clear();
         _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_LeaguePointPath,_loc5_.RoomDetailInfo.MissionID) as TLeaguePointPath;
         _loc11_ = _loc4_.AramyVect.length;
         _loc12_ = 0;
         while(_loc12_ < _loc11_)
         {
            _loc13_ = new TMonsters();
            _loc6_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_EnemyArmy,_loc4_.AramyVect[_loc12_]) as TEnemyArmy;
            _loc8_ = _loc6_.EnemyIdVect.length;
            _loc7_ = 0;
            while(_loc7_ < _loc8_)
            {
               _loc10_ = _loc6_.EnemyIdVect[_loc7_];
               _loc14_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_RoleModel,_loc10_) as TRoleModel;
               _loc15_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Enemy,_loc10_) as TEnemy;
               _loc9_ = SLogicsCore.PoolCampaign.AcquireMonster(_loc10_);
               _loc9_.IsChar = Boolean(_loc6_.IsLeader == _loc10_);
               _loc9_.MonsterPos = CONST_GROUPBATTLE.MonsterMapPosition.indexOf(_loc6_.EnemyPosVect[_loc7_]);
               _loc9_.TeamName = _loc6_.Name;
               _loc9_.MonsterHeadId = _loc14_.RoleHead;
               _loc13_.Add(_loc9_);
               _loc7_++;
            }
            _loc5_.MonsterInfo.Add(_loc13_);
            _loc12_++;
         }
      }
      
      protected function UnstreamizationPerformChangeRoomDetailInfo(param1:uint, param2:Object, param3:Object) : void
      {
         var _loc4_:TRoomDetailInfo = null;
         var _loc5_:TGroupBattleLevel = null;
         _loc4_ = param2 as TRoomDetailInfo;
         _loc5_ = this.CreateLevelInfo(param1);
         _loc4_.MissionID = param1;
         _loc4_.GroupBattleLevel = _loc5_;
      }
      
      protected function UnstreamizationPerformFriendList(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:TShadowList = null;
         var _loc7_:TShadowPlayer = null;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         _loc6_ = param2 as TShadowList;
         _loc6_.Clear();
         _loc5_ = param1.readUnsignedShort();
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc8_ = uint(param1.readByte());
            _loc9_ = param1.readUnsignedInt();
            _loc10_ = param1.readUnsignedInt();
            _loc7_ = new TShadowPlayer(_loc9_,_loc10_);
            _loc7_.PlayerName = TUtilityString.FetchUTF(param1);
            _loc7_.PlayerLevel = param1.readShort();
            _loc7_.Family = param1.readByte();
            _loc7_.AuthorizeStatus = param1.readByte();
            _loc7_.IsOnline = param1.readUnsignedByte();
            _loc6_.Add(_loc7_);
            _loc4_++;
         }
         _loc6_.Sort();
      }
      
      protected function UnstreamizationPerformShadowList(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:TInviteShadows = null;
         var _loc7_:TInviteShadow = null;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         _loc6_ = param2 as TInviteShadows;
         _loc6_.Clear();
         _loc5_ = param1.readUnsignedShort();
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc8_ = param1.readUnsignedInt();
            _loc9_ = param1.readUnsignedInt();
            _loc7_ = new TInviteShadow(_loc8_,_loc9_);
            _loc7_.PlayerName = TUtilityString.FetchUTF(param1);
            _loc7_.PlayerLevel = param1.readUnsignedInt();
            _loc7_.FightPower.High = param1.readUnsignedInt();
            _loc7_.FightPower.Low = param1.readUnsignedInt();
            _loc7_.CDTime = param1.readUnsignedInt();
            _loc7_.LeftInviteTImes = param1.readUnsignedInt();
            _loc6_.Add(_loc7_);
            _loc4_++;
         }
      }
      
      public function UnstreamizeBattleLevelInfo(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerformBattleLevelInfo(param1,param2,param3);
      }
      
      public function UnstreamizeUpdateRoomInfo(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerformUpdateRoomInfo(param1,param2,param3);
      }
      
      public function UnstreamizeRoomDetailInfo(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerformRoomDetailInfo(param1,param2,param3);
      }
      
      public function UnstreamizeUpdateRoomPayerInfo(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerformRoomPayerInfo(param1,param2,param3);
      }
      
      public function UnstreamizeMonsterByDatabase(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerformMonsterByDatabase(param1,param2,param3);
      }
      
      public function UnstreamizerFriendList(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerformFriendList(param1,param2,param3);
      }
      
      public function UnstreamizerShadowList(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerformShadowList(param1,param2,param3);
      }
      
      public function UnstreamizerChangeMissionId(param1:uint, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerformChangeRoomDetailInfo(param1,param2,param3);
      }
   }
}

