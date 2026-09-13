package Logics.Streamization.TopOrganization
{
   import Foundation.Common.Integer.UInt64;
   import Foundation.Streamization.TUnstreamizer;
   import Foundation.Utilities.TUtilityString;
   import Logics.SLogicsCore;
   import Logics.TopOrganization.TGVG2BattleReport;
   import Logics.TopOrganization.TGVG2BattleReports;
   import Logics.TopOrganization.TGVG3BattleOrg;
   import Logics.TopOrganization.TGVG3BattleOrgs;
   import Logics.TopOrganization.TGVG3BetOrg;
   import Logics.TopOrganization.TGVG3BetOrgs;
   import Logics.TopOrganization.TGVG3Top32Org;
   import Logics.TopOrganization.TGVG3Top32Orgs;
   import Logics.TopOrganization.TJoinGVG2MatchOrg;
   import Logics.TopOrganization.TJoinGVG2MatchOrgs;
   import Logics.TopOrganization.TJoinOrganization;
   import Logics.TopOrganization.TJoinOrganizations;
   import Logics.TopOrganization.TOrgMemberDigest;
   import Logics.TopOrganization.TSequenceRanking;
   import Logics.TopOrganization.TSequenceRankings;
   import Logics.TopOrganization.TStatusJoinMember;
   import Logics.TopOrganization.TStatusJoinMembers;
   import Logics.TopOrganization.TTopOrganizationReport;
   import Logics.TopOrganization.TTopOrganizationReports;
   import Logics.TopOrganization.TUserBetInfo;
   import Logics.TopOrganization.TUserBetInfos;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerTopOrganization extends TUnstreamizer
   {
      
      public function TUnstreamizerTopOrganization()
      {
         super();
      }
      
      protected function UnstreamizationPerformStatusJoinMember(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:ByteArray = null;
         var _loc5_:TStatusJoinMembers = null;
         var _loc6_:TStatusJoinMember = null;
         var _loc7_:int = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         _loc4_ = param1 as ByteArray;
         _loc5_ = param2 as TStatusJoinMembers;
         _loc5_.Clear();
         _loc8_ = uint(_loc4_.readShort());
         _loc7_ = 0;
         while(_loc7_ < _loc8_)
         {
            _loc9_ = _loc4_.readUnsignedInt();
            _loc10_ = _loc4_.readUnsignedInt();
            _loc6_ = new TStatusJoinMember(_loc9_,_loc10_);
            _loc6_.UserName = TUtilityString.FetchUTF(_loc4_);
            _loc6_.UserLevel = _loc4_.readUnsignedInt();
            _loc6_.CommitStatus = _loc4_.readUnsignedInt();
            _loc5_.Add(_loc6_);
            _loc7_++;
         }
      }
      
      protected function UnstreamizationPerformTopOrganizationReport(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:ByteArray = null;
         var _loc5_:TTopOrganizationReports = null;
         var _loc6_:TTopOrganizationReport = null;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:UInt64 = null;
         _loc4_ = param1 as ByteArray;
         _loc5_ = param2 as TTopOrganizationReports;
         _loc6_ = new TTopOrganizationReport();
         _loc7_ = _loc4_.readUnsignedInt();
         _loc8_ = _loc4_.readUnsignedInt();
         _loc9_ = new UInt64(_loc8_,_loc7_);
         _loc6_.ReportID = _loc9_.ToString();
         _loc6_.AttackOrgID = _loc4_.readUnsignedInt();
         _loc6_.AttackOrg = TUtilityString.FetchUTF(_loc4_);
         _loc6_.DefendOrgID = _loc4_.readUnsignedInt();
         _loc6_.DefendOrg = TUtilityString.FetchUTF(_loc4_);
         _loc6_.AttackerID0 = _loc4_.readUnsignedInt();
         _loc6_.AttackerID1 = _loc4_.readUnsignedInt();
         _loc6_.Attacker = TUtilityString.FetchUTF(_loc4_);
         _loc6_.DefenderID0 = _loc4_.readUnsignedInt();
         _loc6_.DefenderID1 = _loc4_.readUnsignedInt();
         _loc6_.Defender = TUtilityString.FetchUTF(_loc4_);
         _loc6_.WinSign = _loc4_.readUnsignedInt();
         _loc6_.SequenceWinCount = _loc4_.readUnsignedInt();
         _loc6_.RestHPPercent = _loc4_.readUnsignedInt();
         _loc6_.LoserRank = _loc4_.readUnsignedInt();
         _loc5_.Add(_loc6_);
      }
      
      protected function UnstreamizationPerformSequenceRanking(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:ByteArray = null;
         var _loc5_:TSequenceRankings = null;
         var _loc6_:TSequenceRanking = null;
         var _loc7_:int = 0;
         var _loc8_:uint = 0;
         _loc4_ = param1 as ByteArray;
         _loc5_ = param2 as TSequenceRankings;
         _loc5_.Clear();
         _loc8_ = uint(_loc4_.readShort());
         _loc7_ = 0;
         while(_loc7_ < _loc8_)
         {
            _loc6_ = new TSequenceRanking();
            _loc6_.Rank = _loc7_ + 1;
            _loc6_.PlayerName = TUtilityString.FetchUTF(_loc4_);
            _loc6_.OrgName = TUtilityString.FetchUTF(_loc4_);
            _loc6_.SequenceCount = _loc4_.readUnsignedInt();
            _loc6_.RewardSilverCoin = _loc4_.readUnsignedInt();
            _loc5_.Add(_loc6_);
            _loc7_++;
         }
      }
      
      protected function UnstreamizationPerformJoinGVG2OrgStatus(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:ByteArray = null;
         var _loc5_:TJoinGVG2MatchOrgs = null;
         var _loc6_:TJoinGVG2MatchOrg = null;
         var _loc7_:int = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         _loc4_ = param1 as ByteArray;
         _loc5_ = param2 as TJoinGVG2MatchOrgs;
         _loc5_.Clear();
         _loc8_ = uint(_loc4_.readShort());
         _loc7_ = 0;
         while(_loc7_ < _loc8_)
         {
            _loc9_ = _loc4_.readUnsignedInt();
            _loc6_ = new TJoinGVG2MatchOrg(_loc9_);
            _loc6_.OrganizaionName = TUtilityString.FetchUTF(_loc4_);
            _loc6_.GVG2Status = _loc4_.readUnsignedInt();
            _loc6_.LoseCount = _loc4_.readUnsignedInt();
            _loc5_.Add(_loc6_);
            _loc7_++;
         }
      }
      
      protected function UnstreamizationPerformOrganizationRankings(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:ByteArray = null;
         var _loc5_:TJoinOrganizations = null;
         var _loc6_:TJoinOrganization = null;
         var _loc7_:int = 0;
         var _loc8_:uint = 0;
         _loc4_ = param1 as ByteArray;
         _loc5_ = param2 as TJoinOrganizations;
         _loc5_.Clear();
         _loc8_ = uint(_loc4_.readShort());
         _loc7_ = 0;
         while(_loc7_ < _loc8_)
         {
            _loc6_ = new TJoinOrganization();
            _loc6_.Rank = _loc4_.readUnsignedInt();
            _loc6_.OrgName = TUtilityString.FetchUTF(_loc4_);
            _loc6_.RestMembers = _loc4_.readUnsignedInt();
            _loc6_.TotalMembers = _loc4_.readUnsignedInt();
            _loc5_.Add(_loc6_);
            _loc7_++;
         }
      }
      
      protected function UnstreamizationPerformStatusJoinGVG2Members(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:ByteArray = null;
         var _loc5_:TStatusJoinMembers = null;
         var _loc6_:TStatusJoinMember = null;
         var _loc7_:int = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         _loc4_ = param1 as ByteArray;
         _loc5_ = param2 as TStatusJoinMembers;
         _loc5_.Clear();
         _loc8_ = uint(_loc4_.readShort());
         _loc7_ = 0;
         while(_loc7_ < _loc8_)
         {
            _loc9_ = _loc4_.readUnsignedInt();
            _loc10_ = _loc4_.readUnsignedInt();
            _loc6_ = new TStatusJoinMember(_loc9_,_loc10_);
            _loc6_.UserName = TUtilityString.FetchUTF(_loc4_);
            _loc6_.UserLevel = _loc4_.readUnsignedInt();
            _loc6_.CommitStatus = _loc4_.readUnsignedInt();
            _loc5_.Add(_loc6_);
            _loc7_++;
         }
      }
      
      protected function UnstreamizationPerformGVG2BattleReports(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:ByteArray = null;
         var _loc5_:TGVG2BattleReports = null;
         var _loc6_:TGVG2BattleReport = null;
         var _loc7_:int = 0;
         var _loc8_:uint = 0;
         _loc4_ = param1 as ByteArray;
         _loc5_ = param2 as TGVG2BattleReports;
         _loc8_ = uint(_loc4_.readShort());
         _loc7_ = 0;
         while(_loc7_ < _loc8_)
         {
            _loc6_ = new TGVG2BattleReport();
            _loc6_.BattleIndex = _loc4_.readUnsignedInt();
            _loc6_.WinnerFightCircles = _loc4_.readUnsignedInt();
            _loc6_.WinnerAgentID = _loc4_.readUnsignedInt();
            _loc6_.WinnerServerID = _loc4_.readUnsignedInt();
            _loc6_.WinnerOrgID = _loc4_.readUnsignedInt();
            _loc6_.WinnerUserID0 = _loc4_.readUnsignedInt();
            _loc6_.WinnerUserID1 = _loc4_.readUnsignedInt();
            _loc6_.WinnerUserName = TUtilityString.FetchUTF(_loc4_);
            _loc6_.LeftHP = _loc4_.readUnsignedInt();
            _loc6_.LoserFIghtCircles = _loc4_.readUnsignedInt();
            _loc6_.LoserAgentID = _loc4_.readUnsignedInt();
            _loc6_.LoserServerID = _loc4_.readUnsignedInt();
            _loc6_.LoserOrgID = _loc4_.readUnsignedInt();
            _loc6_.LoserUserID0 = _loc4_.readUnsignedInt();
            _loc6_.LoserUserID1 = _loc4_.readUnsignedInt();
            _loc6_.LoserUserName = TUtilityString.FetchUTF(_loc4_);
            _loc6_.LoserCount = _loc4_.readUnsignedInt();
            _loc6_.WinnerOrgServerName = TUtilityString.FetchUTF(_loc4_);
            _loc6_.LoserOrgServerName = TUtilityString.FetchUTF(_loc4_);
            _loc6_.WinnerOrgName = TUtilityString.FetchUTF(_loc4_);
            _loc6_.LoserOrgName = TUtilityString.FetchUTF(_loc4_);
            _loc6_.IsRequest = _loc4_.readUnsignedInt();
            _loc5_.Add(_loc6_);
            _loc7_++;
         }
      }
      
      protected function UnstreamizationPerformGVG3LastWeekTop32Orgs(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:ByteArray = null;
         var _loc5_:TGVG3Top32Orgs = null;
         _loc4_ = param1 as ByteArray;
         _loc5_ = param2 as TGVG3Top32Orgs;
         _loc5_.Clear();
         this.CreateTop32Orgs(_loc4_,_loc5_);
      }
      
      protected function UnstreamizationPerformGVG3Top32Orgs(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:ByteArray = null;
         var _loc5_:TGVG3Top32Orgs = null;
         _loc4_ = param1 as ByteArray;
         _loc5_ = param2 as TGVG3Top32Orgs;
         _loc5_.Clear();
         this.CreateTop32Orgs(_loc4_,_loc5_);
      }
      
      protected function UnstreamizationPerformAddGVG3Top32Org(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:ByteArray = null;
         var _loc5_:TGVG3Top32Orgs = null;
         _loc4_ = param1 as ByteArray;
         _loc5_ = param2 as TGVG3Top32Orgs;
         _loc5_.Clear();
         this.CreateTop32Orgs(_loc4_,_loc5_);
      }
      
      protected function UnstreamizationPerformGVG3BetOrgs(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:ByteArray = null;
         var _loc5_:TGVG3BetOrgs = null;
         var _loc6_:int = 0;
         var _loc7_:uint = 0;
         var _loc8_:TGVG3BetOrg = null;
         _loc4_ = param1 as ByteArray;
         _loc5_ = param2 as TGVG3BetOrgs;
         _loc5_.Clear();
         _loc7_ = uint(_loc4_.readShort());
         _loc6_ = 0;
         while(_loc6_ < _loc7_)
         {
            _loc8_ = new TGVG3BetOrg();
            _loc8_.AgentID = _loc4_.readUnsignedInt();
            _loc8_.ServerID = _loc4_.readUnsignedInt();
            _loc8_.OrgID = _loc4_.readUnsignedInt();
            _loc8_.OrgName = TUtilityString.FetchUTF(_loc4_);
            _loc8_.OrgLevel = _loc4_.readUnsignedInt();
            _loc8_.OrgMembersCount = _loc4_.readUnsignedInt();
            _loc8_.TotalBetCount = _loc4_.readUnsignedInt();
            _loc5_.Add(_loc8_);
            _loc6_++;
         }
      }
      
      protected function UnstreamizationPerformGVG3BattleOrgs(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:ByteArray = null;
         var _loc5_:TOrgMemberDigest = null;
         var _loc6_:TGVG3BattleOrgs = null;
         var _loc7_:TGVG3BattleOrg = null;
         var _loc8_:int = 0;
         var _loc9_:uint = 0;
         var _loc10_:int = 0;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         var _loc13_:uint = 0;
         _loc6_ = param2 as TGVG3BattleOrgs;
         _loc6_.Clear();
         _loc4_ = param1 as ByteArray;
         _loc9_ = uint(_loc4_.readShort());
         _loc8_ = 0;
         while(_loc8_ < _loc9_)
         {
            _loc7_ = new TGVG3BattleOrg();
            _loc7_.OrgID = _loc4_.readUnsignedInt();
            _loc7_.OrgName = TUtilityString.FetchUTF(_loc4_);
            _loc7_.ServerName = TUtilityString.FetchUTF(_loc4_);
            _loc7_.OrgMemberCount = _loc4_.readUnsignedInt();
            _loc11_ = uint(_loc4_.readShort());
            _loc10_ = 0;
            while(_loc10_ < _loc11_)
            {
               _loc12_ = _loc4_.readUnsignedInt();
               _loc13_ = _loc4_.readUnsignedInt();
               _loc5_ = new TOrgMemberDigest(_loc12_,_loc13_);
               _loc5_.Level = _loc4_.readUnsignedInt();
               _loc5_.Name = TUtilityString.FetchUTF(_loc4_);
               _loc5_.TemplateID = _loc4_.readUnsignedInt();
               _loc5_.IsThreeWins = 0;
               _loc5_.IsDead = 0;
               _loc5_.SortIndex = _loc10_;
               _loc7_.OrgMemberDigests.Add(_loc5_);
               _loc10_++;
            }
            _loc6_.Add(_loc7_);
            _loc8_++;
         }
      }
      
      protected function UnstreamizationPerformGVG3BattleReports(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:ByteArray = null;
         var _loc5_:TGVG2BattleReports = null;
         var _loc6_:int = 0;
         var _loc7_:uint = 0;
         var _loc8_:TGVG2BattleReport = null;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:TGVG3BattleOrg = null;
         var _loc12_:TOrgMemberDigest = null;
         _loc4_ = param1 as ByteArray;
         _loc5_ = param2 as TGVG2BattleReports;
         _loc5_.Clear();
         _loc7_ = uint(_loc4_.readShort());
         _loc6_ = 0;
         while(_loc6_ < _loc7_)
         {
            _loc8_ = new TGVG2BattleReport();
            _loc8_.WinnerOrgID = _loc4_.readUnsignedInt();
            _loc11_ = SLogicsCore.TopOrganizationData.GVG3BattleOrgs.GetGVG3BattleOrgByIdentifier(_loc8_.WinnerOrgID);
            _loc8_.WinnerOrgName = _loc11_.OrgName;
            _loc8_.WinnerOrgServerName = _loc11_.ServerName;
            _loc8_.WinnerUserID0 = _loc4_.readUnsignedInt();
            _loc8_.WinnerUserID1 = _loc4_.readUnsignedInt();
            _loc12_ = _loc11_.OrgMemberDigests.GetOrgMemberDigestByIdentifier(_loc8_.WinnerUserID0,_loc8_.WinnerUserID1);
            _loc8_.WinnerUserName = _loc12_.Name;
            _loc9_ = _loc4_.readUnsignedInt();
            _loc8_.LeftHP = _loc9_;
            _loc8_.LoserOrgID = _loc4_.readUnsignedInt();
            _loc11_ = SLogicsCore.TopOrganizationData.GVG3BattleOrgs.GetGVG3BattleOrgByIdentifier(_loc8_.LoserOrgID);
            _loc8_.LoserOrgName = _loc11_.OrgName;
            _loc8_.LoserOrgServerName = _loc11_.ServerName;
            _loc8_.LoserUserID0 = _loc4_.readUnsignedInt();
            _loc8_.LoserUserID1 = _loc4_.readUnsignedInt();
            _loc12_ = _loc11_.OrgMemberDigests.GetOrgMemberDigestByIdentifier(_loc8_.LoserUserID0,_loc8_.LoserUserID1);
            _loc8_.LoserUserName = _loc12_.Name;
            _loc10_ = _loc4_.readUnsignedInt();
            _loc8_.IsThreeWins = _loc10_;
            if(_loc10_ == 1)
            {
               _loc11_ = SLogicsCore.TopOrganizationData.GVG3BattleOrgs.GetGVG3BattleOrgByIdentifier(_loc8_.WinnerOrgID);
               if(_loc11_ != null)
               {
                  _loc12_ = _loc11_.OrgMemberDigests.GetOrgMemberDigestByIdentifier(_loc8_.WinnerUserID0,_loc8_.WinnerUserID1);
                  if(_loc12_ != null)
                  {
                     _loc12_.IsThreeWins = _loc10_;
                     _loc12_.LeftHP = _loc9_;
                  }
               }
            }
            _loc5_.Add(_loc8_);
            _loc6_++;
         }
      }
      
      protected function UnstreamizationPerformGVG3BetInfos(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:ByteArray = null;
         var _loc5_:TUserBetInfos = null;
         var _loc6_:TUserBetInfo = null;
         var _loc7_:int = 0;
         var _loc8_:uint = 0;
         _loc4_ = param1 as ByteArray;
         _loc5_ = param2 as TUserBetInfos;
         _loc8_ = uint(_loc4_.readShort());
         _loc7_ = 0;
         while(_loc7_ < _loc8_)
         {
            _loc6_ = new TUserBetInfo();
            _loc6_.Round = _loc4_.readUnsignedInt();
            _loc6_.AttackOrgID = _loc4_.readUnsignedInt();
            _loc6_.DefendOrgID = _loc4_.readUnsignedInt();
            _loc6_.BetOrgID = _loc4_.readUnsignedInt();
            _loc6_.BetType = _loc4_.readUnsignedInt();
            _loc5_.Add(_loc6_);
            _loc7_++;
         }
      }
      
      protected function CreateTop32Orgs(param1:ByteArray, param2:TGVG3Top32Orgs) : void
      {
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:TGVG3Top32Org = null;
         var _loc6_:int = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         _loc4_ = uint(param1.readShort());
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc5_ = new TGVG3Top32Org();
            _loc5_.AgentID = param1.readUnsignedInt();
            _loc5_.ServerID = param1.readUnsignedInt();
            _loc5_.OrgID = param1.readUnsignedInt();
            _loc5_.OrgName = TUtilityString.FetchUTF(param1);
            _loc5_.LoseCircle = param1.readUnsignedInt();
            _loc10_ = param1.readUnsignedInt();
            _loc5_.InitPos = _loc10_ - 1;
            param2.Add(_loc5_);
            _loc3_++;
         }
         param2.Sort();
      }
      
      public function UnstreamizeStatusJoinMember(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerformStatusJoinMember(param1,param2,param3);
      }
      
      public function UnstreamizeTopOrganizationReport(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerformTopOrganizationReport(param1,param2,param3);
      }
      
      public function UnstreamizeSequenceRanking(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerformSequenceRanking(param1,param2,param3);
      }
      
      public function UnstreamizeOrganizationRankings(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerformOrganizationRankings(param1,param2,param3);
      }
      
      public function UnstreamizeJoinGVG2OrgStatus(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerformJoinGVG2OrgStatus(param1,param2,param3);
      }
      
      public function UnstreamizeStatusJoinGVG2Members(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerformStatusJoinGVG2Members(param1,param2,param3);
      }
      
      public function UnstreamizeGVG2BattleReports(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerformGVG2BattleReports(param1,param2,param3);
      }
      
      public function UnstreamizeGVG3Top32Orgs(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerformGVG3Top32Orgs(param1,param2,param3);
      }
      
      public function UnstreamizeAddGVG3Top32Org(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerformAddGVG3Top32Org(param1,param2,param3);
      }
      
      public function UnstreamizeGVG3BetOrgs(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerformGVG3BetOrgs(param1,param2,param3);
      }
      
      public function UnstreamizeGVG3BattleOrgs(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerformGVG3BattleOrgs(param1,param2,param3);
      }
      
      public function UnstreamizeGVG3BattleReports(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerformGVG3BattleReports(param1,param2,param3);
      }
      
      public function UnstreamizeGVG3BetInfos(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerformGVG3BetInfos(param1,param2,param3);
      }
   }
}

