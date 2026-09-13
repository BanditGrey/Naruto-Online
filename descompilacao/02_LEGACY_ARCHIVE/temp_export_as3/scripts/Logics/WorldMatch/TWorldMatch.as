package Logics.WorldMatch
{
   public class TWorldMatch
   {
      
      public var WorldMatchReports:Vector.<TWorldMatchReport>;
      
      public var WorldMatchRanks:Vector.<TWorldMatchRank>;
      
      public var WorldMatchRanksCopy:Vector.<TWorldMatchRank>;
      
      public var WorldMatchPlayerInfos:Vector.<TWorldMatchPlayerInfo>;
      
      public var SelfRank:uint;
      
      public var RewardConditon:int;
      
      public function TWorldMatch()
      {
         super();
         this.WorldMatchReports = new Vector.<TWorldMatchReport>();
         this.WorldMatchRanks = new Vector.<TWorldMatchRank>();
         this.WorldMatchRanksCopy = new Vector.<TWorldMatchRank>();
         this.WorldMatchPlayerInfos = new Vector.<TWorldMatchPlayerInfo>();
      }
   }
}

