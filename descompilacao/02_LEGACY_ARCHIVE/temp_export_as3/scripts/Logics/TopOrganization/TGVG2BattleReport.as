package Logics.TopOrganization
{
   public class TGVG2BattleReport
   {
      
      protected var FBattleIndex:int;
      
      protected var FWinnerFightCircles:uint;
      
      protected var FWinnerAgentID:uint;
      
      protected var FWinnerServerID:uint;
      
      protected var FWinnerOrgID:uint;
      
      protected var FWinnerUserID0:uint;
      
      protected var FWinnerUserID1:uint;
      
      protected var FWinnerUserName:String;
      
      protected var FLeftHP:uint;
      
      protected var FLoserFIghtCircles:uint;
      
      protected var FLoserAgentID:uint;
      
      protected var FLoserServerID:uint;
      
      protected var FLoserOrgID:uint;
      
      protected var FLoserUserID0:uint;
      
      protected var FLoserUserID1:uint;
      
      protected var FLoserUserName:String;
      
      protected var FLoserCount:uint;
      
      protected var FWinnerOrgServerName:String;
      
      protected var FLoserOrgServerName:String;
      
      protected var FWinnerOrgName:String;
      
      protected var FLoserOrgName:String;
      
      protected var FIsRequest:uint;
      
      protected var FIsThreeWins:uint;
      
      public function TGVG2BattleReport()
      {
         super();
      }
      
      public function get BattleIndex() : int
      {
         return this.FBattleIndex;
      }
      
      public function set BattleIndex(param1:int) : void
      {
         this.FBattleIndex = param1;
      }
      
      public function get WinnerFightCircles() : uint
      {
         return this.FWinnerFightCircles;
      }
      
      public function set WinnerFightCircles(param1:uint) : void
      {
         this.FWinnerFightCircles = param1;
      }
      
      public function get WinnerAgentID() : uint
      {
         return this.FWinnerAgentID;
      }
      
      public function set WinnerAgentID(param1:uint) : void
      {
         this.FWinnerAgentID = param1;
      }
      
      public function get WinnerServerID() : uint
      {
         return this.FWinnerServerID;
      }
      
      public function set WinnerServerID(param1:uint) : void
      {
         this.FWinnerServerID = param1;
      }
      
      public function get WinnerOrgID() : uint
      {
         return this.FWinnerOrgID;
      }
      
      public function set WinnerOrgID(param1:uint) : void
      {
         this.FWinnerOrgID = param1;
      }
      
      public function get WinnerUserID0() : uint
      {
         return this.FWinnerUserID0;
      }
      
      public function set WinnerUserID0(param1:uint) : void
      {
         this.FWinnerUserID0 = param1;
      }
      
      public function get WinnerUserID1() : uint
      {
         return this.FWinnerUserID1;
      }
      
      public function set WinnerUserID1(param1:uint) : void
      {
         this.FWinnerUserID1 = param1;
      }
      
      public function get WinnerUserName() : String
      {
         return this.FWinnerUserName;
      }
      
      public function set WinnerUserName(param1:String) : void
      {
         this.FWinnerUserName = param1;
      }
      
      public function get LeftHP() : uint
      {
         return this.FLeftHP;
      }
      
      public function set LeftHP(param1:uint) : void
      {
         this.FLeftHP = param1;
      }
      
      public function get LoserFIghtCircles() : uint
      {
         return this.FLoserFIghtCircles;
      }
      
      public function set LoserFIghtCircles(param1:uint) : void
      {
         this.FLoserFIghtCircles = param1;
      }
      
      public function get LoserAgentID() : uint
      {
         return this.FLoserAgentID;
      }
      
      public function set LoserAgentID(param1:uint) : void
      {
         this.FLoserAgentID = param1;
      }
      
      public function get LoserServerID() : uint
      {
         return this.FLoserServerID;
      }
      
      public function set LoserServerID(param1:uint) : void
      {
         this.FLoserServerID = param1;
      }
      
      public function get LoserOrgID() : uint
      {
         return this.FLoserOrgID;
      }
      
      public function set LoserOrgID(param1:uint) : void
      {
         this.FLoserOrgID = param1;
      }
      
      public function get LoserUserID0() : uint
      {
         return this.FLoserUserID0;
      }
      
      public function set LoserUserID0(param1:uint) : void
      {
         this.FLoserUserID0 = param1;
      }
      
      public function get LoserUserID1() : uint
      {
         return this.FLoserUserID1;
      }
      
      public function set LoserUserID1(param1:uint) : void
      {
         this.FLoserUserID1 = param1;
      }
      
      public function get LoserUserName() : String
      {
         return this.FLoserUserName;
      }
      
      public function set LoserUserName(param1:String) : void
      {
         this.FLoserUserName = param1;
      }
      
      public function get LoserCount() : uint
      {
         return this.FLoserCount;
      }
      
      public function set LoserCount(param1:uint) : void
      {
         this.FLoserCount = param1;
      }
      
      public function get WinnerOrgServerName() : String
      {
         return this.FWinnerOrgServerName;
      }
      
      public function set WinnerOrgServerName(param1:String) : void
      {
         this.FWinnerOrgServerName = param1;
      }
      
      public function get LoserOrgServerName() : String
      {
         return this.FLoserOrgServerName;
      }
      
      public function set LoserOrgServerName(param1:String) : void
      {
         this.FLoserOrgServerName = param1;
      }
      
      public function get WinnerOrgName() : String
      {
         return this.FWinnerOrgName;
      }
      
      public function set WinnerOrgName(param1:String) : void
      {
         this.FWinnerOrgName = param1;
      }
      
      public function get LoserOrgName() : String
      {
         return this.FLoserOrgName;
      }
      
      public function set LoserOrgName(param1:String) : void
      {
         this.FLoserOrgName = param1;
      }
      
      public function get IsThreeWins() : uint
      {
         return this.FIsThreeWins;
      }
      
      public function set IsThreeWins(param1:uint) : void
      {
         this.FIsThreeWins = param1;
      }
      
      public function get IsRequest() : uint
      {
         return this.FIsRequest;
      }
      
      public function set IsRequest(param1:uint) : void
      {
         this.FIsRequest = param1;
      }
   }
}

