package Logics.Palace
{
   public class TPalaceData
   {
      
      protected var FEnterStatus:uint;
      
      protected var FStatusValue:uint;
      
      protected var FPalaceRoleBaseInfo:TPalaceRoleBaseInfo;
      
      protected var FTargetFighters:TTargetFighters;
      
      protected var FFightReports:TFightReports;
      
      protected var FRankingPlayers:TRankingPlayers;
      
      protected var FInquirePlayerInfo:TInquirePlayerInfo;
      
      public function TPalaceData()
      {
         super();
         this.FPalaceRoleBaseInfo = new TPalaceRoleBaseInfo();
         this.FTargetFighters = new TTargetFighters();
         this.FFightReports = new TFightReports();
         this.FRankingPlayers = new TRankingPlayers();
         this.FInquirePlayerInfo = new TInquirePlayerInfo();
         this.FStatusValue = 2;
      }
      
      public function get PalaceRoleBaseInfo() : TPalaceRoleBaseInfo
      {
         return this.FPalaceRoleBaseInfo;
      }
      
      public function set PalaceRoleBaseInfo(param1:TPalaceRoleBaseInfo) : void
      {
         this.FPalaceRoleBaseInfo = param1;
      }
      
      public function get TargetFighters() : TTargetFighters
      {
         return this.FTargetFighters;
      }
      
      public function set TargetFighters(param1:TTargetFighters) : void
      {
         this.FTargetFighters = param1;
      }
      
      public function get FightReports() : TFightReports
      {
         return this.FFightReports;
      }
      
      public function set FightReports(param1:TFightReports) : void
      {
         this.FFightReports = param1;
      }
      
      public function get RankingPlayers() : TRankingPlayers
      {
         return this.FRankingPlayers;
      }
      
      public function set RankingPlayers(param1:TRankingPlayers) : void
      {
         this.FRankingPlayers = param1;
      }
      
      public function get InquirePlayerInfo() : TInquirePlayerInfo
      {
         return this.FInquirePlayerInfo;
      }
      
      public function set InquirePlayerInfo(param1:TInquirePlayerInfo) : void
      {
         this.FInquirePlayerInfo = param1;
      }
      
      public function get EnterStatus() : uint
      {
         return this.FEnterStatus;
      }
      
      public function set EnterStatus(param1:uint) : void
      {
         this.FEnterStatus = param1;
      }
      
      public function get StatusValue() : uint
      {
         return this.FStatusValue;
      }
      
      public function set StatusValue(param1:uint) : void
      {
         this.FStatusValue = param1;
      }
   }
}

