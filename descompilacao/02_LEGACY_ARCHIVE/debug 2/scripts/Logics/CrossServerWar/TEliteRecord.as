package Logics.CrossServerWar
{
   public class TEliteRecord
   {
      
      protected var FRankYestoday:uint;
      
      protected var FRankToday:uint;
      
      protected var FFightingPower:uint;
      
      protected var FGroupLevel:uint;
      
      protected var FScoreYestoday:uint;
      
      protected var FScoreToday:uint;
      
      protected var FCurFightTimes:uint;
      
      protected var FLastFightTime:uint;
      
      protected var FApplyStatus:Boolean;
      
      protected var FToastTimes:uint;
      
      protected var FTokenCount:uint;
      
      protected var FOrangeSoulCount:uint;
      
      protected var FIsJoinSkip:uint;
      
      protected var FLeftBuyCount:uint;
      
      protected var FYestodayIsApply:uint;
      
      protected var FTodayIsJoin:uint;
      
      protected var FSeasonStatus:uint;
      
      protected var FSeasonStartTime:uint;
      
      protected var FSeasonEndTime:uint;
      
      protected var FNextSeasonStartTime:uint;
      
      protected var FBattleID:uint;
      
      protected var FIsAutoBattle:Boolean;
      
      public function TEliteRecord()
      {
         super();
         this.FTodayIsJoin = 2;
         this.FIsAutoBattle = false;
      }
      
      public function get RankYestoday() : uint
      {
         return this.FRankYestoday;
      }
      
      public function set RankYestoday(param1:uint) : void
      {
         this.FRankYestoday = param1;
      }
      
      public function get RankToday() : uint
      {
         return this.FRankToday;
      }
      
      public function set RankToday(param1:uint) : void
      {
         this.FRankToday = param1;
      }
      
      public function get FightingPower() : uint
      {
         return this.FFightingPower;
      }
      
      public function set FightingPower(param1:uint) : void
      {
         this.FFightingPower = param1;
      }
      
      public function get GroupLevel() : uint
      {
         return this.FGroupLevel;
      }
      
      public function set GroupLevel(param1:uint) : void
      {
         this.FGroupLevel = param1;
      }
      
      public function get ScoreYestoday() : uint
      {
         return this.FScoreYestoday;
      }
      
      public function set ScoreYestoday(param1:uint) : void
      {
         this.FScoreYestoday = param1;
      }
      
      public function get ScoreToday() : uint
      {
         return this.FScoreToday;
      }
      
      public function set ScoreToday(param1:uint) : void
      {
         this.FScoreToday = param1;
      }
      
      public function get CurFightTimes() : uint
      {
         return this.FCurFightTimes;
      }
      
      public function set CurFightTimes(param1:uint) : void
      {
         this.FCurFightTimes = param1;
      }
      
      public function get LastFightTime() : uint
      {
         return this.FLastFightTime;
      }
      
      public function set LastFightTime(param1:uint) : void
      {
         this.FLastFightTime = param1;
      }
      
      public function get ApplyStatus() : Boolean
      {
         return this.FApplyStatus;
      }
      
      public function set ApplyStatus(param1:Boolean) : void
      {
         this.FApplyStatus = param1;
      }
      
      public function get ToastTimes() : uint
      {
         return this.FToastTimes;
      }
      
      public function set ToastTimes(param1:uint) : void
      {
         this.FToastTimes = param1;
      }
      
      public function get TokenCount() : uint
      {
         return this.FTokenCount;
      }
      
      public function set TokenCount(param1:uint) : void
      {
         this.FTokenCount = param1;
      }
      
      public function get OrangeSoulCount() : uint
      {
         return this.FOrangeSoulCount;
      }
      
      public function set OrangeSoulCount(param1:uint) : void
      {
         this.FOrangeSoulCount = param1;
      }
      
      public function get TodayIsJoin() : uint
      {
         return this.FTodayIsJoin;
      }
      
      public function set TodayIsJoin(param1:uint) : void
      {
         this.FTodayIsJoin = param1;
      }
      
      public function get IsJoinSkip() : uint
      {
         return this.FIsJoinSkip;
      }
      
      public function set IsJoinSkip(param1:uint) : void
      {
         this.FIsJoinSkip = param1;
      }
      
      public function get LeftBuyCount() : uint
      {
         return this.FLeftBuyCount;
      }
      
      public function set LeftBuyCount(param1:uint) : void
      {
         this.FLeftBuyCount = param1;
      }
      
      public function get SeasonStatus() : uint
      {
         return this.FSeasonStatus;
      }
      
      public function set SeasonStatus(param1:uint) : void
      {
         this.FSeasonStatus = param1;
      }
      
      public function get SeasonStartTime() : uint
      {
         return this.FSeasonStartTime;
      }
      
      public function set SeasonStartTime(param1:uint) : void
      {
         this.FSeasonStartTime = param1;
      }
      
      public function get SeasonEndTime() : uint
      {
         return this.FSeasonEndTime;
      }
      
      public function set SeasonEndTime(param1:uint) : void
      {
         this.FSeasonEndTime = param1;
      }
      
      public function get NextSeasonStartTime() : uint
      {
         return this.FNextSeasonStartTime;
      }
      
      public function set NextSeasonStartTime(param1:uint) : void
      {
         this.FNextSeasonStartTime = param1;
      }
      
      public function get BattleID() : uint
      {
         return this.FBattleID;
      }
      
      public function set BattleID(param1:uint) : void
      {
         this.FBattleID = param1;
      }
      
      public function get YestodayIsApply() : uint
      {
         return this.FYestodayIsApply;
      }
      
      public function set YestodayIsApply(param1:uint) : void
      {
         this.FYestodayIsApply = param1;
      }
      
      public function get IsAutoBattle() : Boolean
      {
         return this.FIsAutoBattle;
      }
      
      public function set IsAutoBattle(param1:Boolean) : void
      {
         this.FIsAutoBattle = param1;
      }
   }
}

