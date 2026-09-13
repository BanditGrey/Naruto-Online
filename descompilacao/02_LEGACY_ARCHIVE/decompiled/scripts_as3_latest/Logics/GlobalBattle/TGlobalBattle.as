package Logics.GlobalBattle
{
   public class TGlobalBattle
   {
      
      public var GlobalBattleRanks:Vector.<TGlobalBattleRank>;
      
      public var GlobalBattleRanksCopy:Vector.<TGlobalBattleRank>;
      
      public var GlobalBattleReports:Vector.<TGlobalBattleReport>;
      
      public var GlobalBattleUsers:TGlobalBattleUsers;
      
      public var SelfRank:uint;
      
      public var SelfScore:uint;
      
      public var IsReward:uint;
      
      public var RestPlayCount:uint;
      
      public function TGlobalBattle()
      {
         super();
         this.GlobalBattleRanks = new Vector.<TGlobalBattleRank>();
         this.GlobalBattleRanksCopy = new Vector.<TGlobalBattleRank>();
         this.GlobalBattleReports = new Vector.<TGlobalBattleReport>();
         this.GlobalBattleUsers = new TGlobalBattleUsers();
      }
   }
}

