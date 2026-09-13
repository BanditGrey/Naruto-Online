package Logics.TopOrganization
{
   public class TTopOrganizationData
   {
      
      protected var FApplyStatus:uint;
      
      protected var FBattleStatus:uint;
      
      protected var FOrgPreliminaryRanking:uint;
      
      protected var FIsSubmitData:uint;
      
      protected var FApplyName:String;
      
      protected var FStatusJoinMembers:TStatusJoinMembers;
      
      protected var FTopOrganizationReports:TTopOrganizationReports;
      
      protected var FSequenceRankings:TSequenceRankings;
      
      protected var FJoinOrganizations:TJoinOrganizations;
      
      protected var FOrganizationTop3Rankings:TOrganizationTop3Rankings;
      
      protected var FOrganizationReports:TTopOrganizationReports;
      
      protected var FPersonalReports:TTopOrganizationReports;
      
      protected var FIsBattling:Boolean;
      
      protected var FJoinGVG2MatchOrgs:TJoinGVG2MatchOrgs;
      
      protected var FStatusJoinGVG2Members:TStatusJoinMembers;
      
      protected var FApplyGVG2Name:String;
      
      protected var FGVG2IsSubmitData:uint;
      
      protected var FGVG2IsBattling:Boolean;
      
      protected var FGVG2BattleReports:TGVG2BattleReports;
      
      protected var FGVG3MyOrgStatus:uint;
      
      protected var FGVG3MyOrgName:String;
      
      protected var FGVG3MyOrgRank:uint;
      
      protected var FGVG3IsCanLookLastWeekRanks:Boolean;
      
      protected var FGVG3Top32Orgs:TGVG3Top32Orgs;
      
      protected var FGVG3BetOrgs:TGVG3BetOrgs;
      
      protected var FGroupType:uint;
      
      protected var FGVG3BattleOrgs:TGVG3BattleOrgs;
      
      protected var FGVG3BattleReports:TGVG2BattleReports;
      
      protected var FBattleCDtime:uint;
      
      protected var FCurrentRound:uint;
      
      protected var FCurrentBetCircle:uint;
      
      protected var FBetOrg:uint;
      
      protected var FBetType:uint;
      
      protected var FUserBetInfos:TUserBetInfos;
      
      protected var FCurrentBetAttOrgID:uint;
      
      protected var FCurrentBetDefOrgID:uint;
      
      protected var FIsCanLookBattleReport:Boolean;
      
      public function TTopOrganizationData()
      {
         super();
         this.FStatusJoinMembers = new TStatusJoinMembers();
         this.FTopOrganizationReports = new TTopOrganizationReports();
         this.FSequenceRankings = new TSequenceRankings();
         this.FJoinOrganizations = new TJoinOrganizations();
         this.FOrganizationTop3Rankings = new TOrganizationTop3Rankings();
         this.FOrganizationReports = new TTopOrganizationReports();
         this.FPersonalReports = new TTopOrganizationReports();
         this.FJoinGVG2MatchOrgs = new TJoinGVG2MatchOrgs();
         this.FStatusJoinGVG2Members = new TStatusJoinMembers();
         this.FGVG2BattleReports = new TGVG2BattleReports();
         this.FGVG2IsBattling = true;
         this.FGVG3Top32Orgs = new TGVG3Top32Orgs();
         this.FGVG3BattleOrgs = new TGVG3BattleOrgs();
         this.FGVG3BattleReports = new TGVG2BattleReports();
         this.FGVG3BetOrgs = new TGVG3BetOrgs();
         this.FUserBetInfos = new TUserBetInfos();
      }
      
      public function get ApplyStatus() : uint
      {
         return this.FApplyStatus;
      }
      
      public function set ApplyStatus(param1:uint) : void
      {
         this.FApplyStatus = param1;
      }
      
      public function get BattleStatus() : uint
      {
         return this.FBattleStatus;
      }
      
      public function set BattleStatus(param1:uint) : void
      {
         this.FBattleStatus = param1;
      }
      
      public function get StatusJoinMembers() : TStatusJoinMembers
      {
         return this.FStatusJoinMembers;
      }
      
      public function set StatusJoinMembers(param1:TStatusJoinMembers) : void
      {
         this.FStatusJoinMembers = param1;
      }
      
      public function get OrgPreliminaryRanking() : uint
      {
         return this.FOrgPreliminaryRanking;
      }
      
      public function set OrgPreliminaryRanking(param1:uint) : void
      {
         this.FOrgPreliminaryRanking = param1;
      }
      
      public function get ApplyName() : String
      {
         return this.FApplyName;
      }
      
      public function set ApplyName(param1:String) : void
      {
         this.FApplyName = param1;
      }
      
      public function get IsSubmitData() : uint
      {
         return this.FIsSubmitData;
      }
      
      public function set IsSubmitData(param1:uint) : void
      {
         this.FIsSubmitData = param1;
      }
      
      public function get TopOrganizationReports() : TTopOrganizationReports
      {
         return this.FTopOrganizationReports;
      }
      
      public function set TopOrganizationReports(param1:TTopOrganizationReports) : void
      {
         this.FTopOrganizationReports = param1;
      }
      
      public function get SequenceRankings() : TSequenceRankings
      {
         return this.FSequenceRankings;
      }
      
      public function set SequenceRankings(param1:TSequenceRankings) : void
      {
         this.FSequenceRankings = param1;
      }
      
      public function get JoinOrganizations() : TJoinOrganizations
      {
         return this.FJoinOrganizations;
      }
      
      public function set JoinOrganizations(param1:TJoinOrganizations) : void
      {
         this.FJoinOrganizations = param1;
      }
      
      public function get OrganizationTop3Rankings() : TOrganizationTop3Rankings
      {
         return this.FOrganizationTop3Rankings;
      }
      
      public function set OrganizationTop3Rankings(param1:TOrganizationTop3Rankings) : void
      {
         this.FOrganizationTop3Rankings = param1;
      }
      
      public function get OrganizationReports() : TTopOrganizationReports
      {
         return this.FOrganizationReports;
      }
      
      public function set OrganizationReports(param1:TTopOrganizationReports) : void
      {
         this.FOrganizationReports = param1;
      }
      
      public function get PersonalReports() : TTopOrganizationReports
      {
         return this.FPersonalReports;
      }
      
      public function set PersonalReports(param1:TTopOrganizationReports) : void
      {
         this.FPersonalReports = param1;
      }
      
      public function get IsBattling() : Boolean
      {
         return this.FIsBattling;
      }
      
      public function set IsBattling(param1:Boolean) : void
      {
         this.FIsBattling = param1;
      }
      
      public function get JoinGVG2MatchOrgs() : TJoinGVG2MatchOrgs
      {
         return this.FJoinGVG2MatchOrgs;
      }
      
      public function set JoinGVG2MatchOrgs(param1:TJoinGVG2MatchOrgs) : void
      {
         this.FJoinGVG2MatchOrgs = param1;
      }
      
      public function get StatusJoinGVG2Members() : TStatusJoinMembers
      {
         return this.FStatusJoinGVG2Members;
      }
      
      public function set StatusJoinGVG2Members(param1:TStatusJoinMembers) : void
      {
         this.FStatusJoinGVG2Members = param1;
      }
      
      public function get ApplyGVG2Name() : String
      {
         return this.FApplyGVG2Name;
      }
      
      public function set ApplyGVG2Name(param1:String) : void
      {
         this.FApplyGVG2Name = param1;
      }
      
      public function get GVG2IsSubmitData() : uint
      {
         return this.FGVG2IsSubmitData;
      }
      
      public function set GVG2IsSubmitData(param1:uint) : void
      {
         this.FGVG2IsSubmitData = param1;
      }
      
      public function get GVG2IsBattling() : Boolean
      {
         return this.FGVG2IsBattling;
      }
      
      public function set GVG2IsBattling(param1:Boolean) : void
      {
         this.FGVG2IsBattling = param1;
      }
      
      public function get GVG2BattleReports() : TGVG2BattleReports
      {
         return this.FGVG2BattleReports;
      }
      
      public function set GVG2BattleReports(param1:TGVG2BattleReports) : void
      {
         this.FGVG2BattleReports = param1;
      }
      
      public function get GVG3MyOrgStatus() : uint
      {
         return this.FGVG3MyOrgStatus;
      }
      
      public function set GVG3MyOrgStatus(param1:uint) : void
      {
         this.FGVG3MyOrgStatus = param1;
      }
      
      public function get GVG3MyOrgName() : String
      {
         return this.FGVG3MyOrgName;
      }
      
      public function set GVG3MyOrgName(param1:String) : void
      {
         this.FGVG3MyOrgName = param1;
      }
      
      public function get GVG3MyOrgRank() : uint
      {
         return this.FGVG3MyOrgRank;
      }
      
      public function set GVG3MyOrgRank(param1:uint) : void
      {
         this.FGVG3MyOrgRank = param1;
      }
      
      public function get GVG3IsCanLookLastWeekRanks() : Boolean
      {
         return this.FGVG3IsCanLookLastWeekRanks;
      }
      
      public function set GVG3IsCanLookLastWeekRanks(param1:Boolean) : void
      {
         this.FGVG3IsCanLookLastWeekRanks = param1;
      }
      
      public function get CurrentBetCircle() : uint
      {
         return this.FCurrentBetCircle;
      }
      
      public function set CurrentBetCircle(param1:uint) : void
      {
         this.FCurrentBetCircle = param1;
      }
      
      public function get GVG3BattleOrgs() : TGVG3BattleOrgs
      {
         return this.FGVG3BattleOrgs;
      }
      
      public function set GVG3BattleOrgs(param1:TGVG3BattleOrgs) : void
      {
         this.FGVG3BattleOrgs = param1;
      }
      
      public function get GVG3BattleReports() : TGVG2BattleReports
      {
         return this.FGVG3BattleReports;
      }
      
      public function set GVG3BattleReports(param1:TGVG2BattleReports) : void
      {
         this.FGVG3BattleReports = param1;
      }
      
      public function get GroupType() : uint
      {
         return this.FGroupType;
      }
      
      public function set GroupType(param1:uint) : void
      {
         this.FGroupType = param1;
      }
      
      public function get GVG3BetOrgs() : TGVG3BetOrgs
      {
         return this.FGVG3BetOrgs;
      }
      
      public function set GVG3BetOrgs(param1:TGVG3BetOrgs) : void
      {
         this.FGVG3BetOrgs = param1;
      }
      
      public function get GVG3Top32Orgs() : TGVG3Top32Orgs
      {
         return this.FGVG3Top32Orgs;
      }
      
      public function set GVG3Top32Orgs(param1:TGVG3Top32Orgs) : void
      {
         this.FGVG3Top32Orgs = param1;
      }
      
      public function get CurrentRound() : uint
      {
         return this.FCurrentRound;
      }
      
      public function set CurrentRound(param1:uint) : void
      {
         this.FCurrentRound = param1;
      }
      
      public function get BetType() : uint
      {
         return this.FBetType;
      }
      
      public function set BetType(param1:uint) : void
      {
         this.FBetType = param1;
      }
      
      public function get UserBetInfos() : TUserBetInfos
      {
         return this.FUserBetInfos;
      }
      
      public function set UserBetInfos(param1:TUserBetInfos) : void
      {
         this.FUserBetInfos = param1;
      }
      
      public function get CurrentBetAttOrgID() : uint
      {
         return this.FCurrentBetAttOrgID;
      }
      
      public function set CurrentBetAttOrgID(param1:uint) : void
      {
         this.FCurrentBetAttOrgID = param1;
      }
      
      public function get CurrentBetDefOrgID() : uint
      {
         return this.FCurrentBetDefOrgID;
      }
      
      public function set CurrentBetDefOrgID(param1:uint) : void
      {
         this.FCurrentBetDefOrgID = param1;
      }
      
      public function get BattleCDtime() : uint
      {
         return this.FBattleCDtime;
      }
      
      public function set BattleCDtime(param1:uint) : void
      {
         this.FBattleCDtime = param1;
      }
      
      public function get BetOrg() : uint
      {
         return this.FBetOrg;
      }
      
      public function set BetOrg(param1:uint) : void
      {
         this.FBetOrg = param1;
      }
      
      public function get IsCanLookBattleReport() : Boolean
      {
         return this.FIsCanLookBattleReport;
      }
      
      public function set IsCanLookBattleReport(param1:Boolean) : void
      {
         this.FIsCanLookBattleReport = param1;
      }
      
      public function Reset() : void
      {
         this.FIsBattling = false;
         this.FGVG2IsBattling = true;
      }
   }
}

