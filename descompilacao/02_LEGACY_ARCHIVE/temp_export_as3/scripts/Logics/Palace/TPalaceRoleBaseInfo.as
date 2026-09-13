package Logics.Palace
{
   public class TPalaceRoleBaseInfo
   {
      
      protected var FYestodayRank:uint;
      
      protected var FCurrentRank:uint;
      
      protected var FFightPower:uint;
      
      protected var FCurrentTimes:uint;
      
      protected var FBuyTimes:uint;
      
      protected var FLastChallengeTime:uint;
      
      public function TPalaceRoleBaseInfo()
      {
         super();
      }
      
      public function get YestodayRank() : uint
      {
         return this.FYestodayRank;
      }
      
      public function set YestodayRank(param1:uint) : void
      {
         this.FYestodayRank = param1;
      }
      
      public function get CurrentRank() : uint
      {
         return this.FCurrentRank;
      }
      
      public function set CurrentRank(param1:uint) : void
      {
         this.FCurrentRank = param1;
      }
      
      public function get FightPower() : uint
      {
         return this.FFightPower;
      }
      
      public function set FightPower(param1:uint) : void
      {
         this.FFightPower = param1;
      }
      
      public function get CurrentTimes() : uint
      {
         return this.FCurrentTimes;
      }
      
      public function set CurrentTimes(param1:uint) : void
      {
         this.FCurrentTimes = param1;
      }
      
      public function get BuyTimes() : uint
      {
         return this.FBuyTimes;
      }
      
      public function set BuyTimes(param1:uint) : void
      {
         this.FBuyTimes = param1;
      }
      
      public function get LastChallengeTime() : uint
      {
         return this.FLastChallengeTime;
      }
      
      public function set LastChallengeTime(param1:uint) : void
      {
         this.FLastChallengeTime = param1;
      }
   }
}

