package Logics.GroupBattle
{
   public class TGroupBattleData
   {
      
      protected var FPVETimes:uint;
      
      protected var FPVPTimes:uint;
      
      protected var FHonorPoint:uint;
      
      protected var FGroupBattleLevels:TGroupBattleLevels;
      
      protected var FGroupBattleRooms:TGroupBattleRooms;
      
      protected var FRoomDetailInfo:TRoomDetailInfo;
      
      protected var FBattleStartCountDownTime:uint;
      
      protected var FMonsterInfo:TMonsterInfo;
      
      protected var FRestShadowCount:uint;
      
      protected var FFriendList:TShadowList;
      
      protected var FInviteShadows:TInviteShadows;
      
      protected var FOrgAuthorizeStatus:uint;
      
      protected var FIsAutoStartSign:Boolean;
      
      protected var FIsInBattle:Boolean;
      
      protected var FReadyTimeStatus:uint;
      
      protected var FReadyTimeTick:uint;
      
      protected var FSendReadyTimeStatusReq:Boolean;
      
      public function TGroupBattleData()
      {
         super();
         this.FGroupBattleLevels = new TGroupBattleLevels();
         this.FGroupBattleRooms = new TGroupBattleRooms();
         this.FRoomDetailInfo = new TRoomDetailInfo();
         this.FMonsterInfo = new TMonsterInfo();
         this.FFriendList = new TShadowList();
         this.FInviteShadows = new TInviteShadows();
         this.FIsAutoStartSign = false;
         this.FIsInBattle = false;
         this.FReadyTimeStatus = 0;
         this.FReadyTimeTick = 0;
      }
      
      public function get PVETimes() : uint
      {
         return this.FPVETimes;
      }
      
      public function set PVETimes(param1:uint) : void
      {
         this.FPVETimes = param1;
      }
      
      public function get PVPTimes() : uint
      {
         return this.FPVPTimes;
      }
      
      public function set PVPTimes(param1:uint) : void
      {
         this.FPVPTimes = param1;
      }
      
      public function get HonorPoint() : uint
      {
         return this.FHonorPoint;
      }
      
      public function set HonorPoint(param1:uint) : void
      {
         this.FHonorPoint = param1;
      }
      
      public function get GroupBattleLevels() : TGroupBattleLevels
      {
         return this.FGroupBattleLevels;
      }
      
      public function set GroupBattleLevels(param1:TGroupBattleLevels) : void
      {
         this.FGroupBattleLevels = param1;
      }
      
      public function get GroupBattleRooms() : TGroupBattleRooms
      {
         return this.FGroupBattleRooms;
      }
      
      public function set GroupBattleRooms(param1:TGroupBattleRooms) : void
      {
         this.FGroupBattleRooms = param1;
      }
      
      public function get RoomDetailInfo() : TRoomDetailInfo
      {
         return this.FRoomDetailInfo;
      }
      
      public function set RoomDetailInfo(param1:TRoomDetailInfo) : void
      {
         this.FRoomDetailInfo = param1;
      }
      
      public function get BattleStartCountDownTime() : uint
      {
         return this.FBattleStartCountDownTime;
      }
      
      public function set BattleStartCountDownTime(param1:uint) : void
      {
         this.FBattleStartCountDownTime = param1;
      }
      
      public function get MonsterInfo() : TMonsterInfo
      {
         return this.FMonsterInfo;
      }
      
      public function set MonsterInfo(param1:TMonsterInfo) : void
      {
         this.FMonsterInfo = param1;
      }
      
      public function get RestShadowCount() : uint
      {
         return this.FRestShadowCount;
      }
      
      public function set RestShadowCount(param1:uint) : void
      {
         this.FRestShadowCount = param1;
      }
      
      public function get FriendList() : TShadowList
      {
         return this.FFriendList;
      }
      
      public function set FriendList(param1:TShadowList) : void
      {
         this.FFriendList = param1;
      }
      
      public function get InviteShadows() : TInviteShadows
      {
         return this.FInviteShadows;
      }
      
      public function set InviteShadows(param1:TInviteShadows) : void
      {
         this.FInviteShadows = param1;
      }
      
      public function get OrgAuthorizeStatus() : uint
      {
         return this.FOrgAuthorizeStatus;
      }
      
      public function set OrgAuthorizeStatus(param1:uint) : void
      {
         this.FOrgAuthorizeStatus = param1;
      }
      
      public function get IsAutoStartSign() : Boolean
      {
         return this.FIsAutoStartSign;
      }
      
      public function set IsAutoStartSign(param1:Boolean) : void
      {
         this.FIsAutoStartSign = param1;
      }
      
      public function get IsInBattle() : Boolean
      {
         return this.FIsInBattle;
      }
      
      public function set IsInBattle(param1:Boolean) : void
      {
         this.FIsInBattle = param1;
      }
      
      public function get ReadyTimeStatus() : uint
      {
         return this.FReadyTimeStatus;
      }
      
      public function set ReadyTimeStatus(param1:uint) : void
      {
         this.FReadyTimeStatus = param1;
      }
      
      public function get ReadyTimeTick() : uint
      {
         return this.FReadyTimeTick;
      }
      
      public function set ReadyTimeTick(param1:uint) : void
      {
         this.FReadyTimeTick = param1;
      }
      
      public function get SendReadyTimeStatusReq() : Boolean
      {
         return this.FSendReadyTimeStatusReq;
      }
      
      public function set SendReadyTimeStatusReq(param1:Boolean) : void
      {
         this.FSendReadyTimeStatusReq = param1;
      }
   }
}

