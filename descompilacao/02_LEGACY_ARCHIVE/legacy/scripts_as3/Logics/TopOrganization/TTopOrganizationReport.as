package Logics.TopOrganization
{
   public class TTopOrganizationReport
   {
      
      protected var FReportID:String;
      
      protected var FAttackOrgID:uint;
      
      protected var FAttackOrg:String;
      
      protected var FDefendOrgID:uint;
      
      protected var FDefendOrg:String;
      
      protected var FAttackerID0:uint;
      
      protected var FAttackerID1:uint;
      
      protected var FAttacker:String;
      
      protected var FDefenderID0:uint;
      
      protected var FDefenderID1:uint;
      
      protected var FDefender:String;
      
      protected var FWinSign:uint;
      
      protected var FSequenceWinCount:uint;
      
      protected var FRestHPPercent:uint;
      
      protected var FLoserRank:uint;
      
      public function TTopOrganizationReport()
      {
         super();
      }
      
      public function get AttackOrg() : String
      {
         return this.FAttackOrg;
      }
      
      public function set AttackOrg(param1:String) : void
      {
         this.FAttackOrg = param1;
      }
      
      public function get DefendOrg() : String
      {
         return this.FDefendOrg;
      }
      
      public function set DefendOrg(param1:String) : void
      {
         this.FDefendOrg = param1;
      }
      
      public function get Attacker() : String
      {
         return this.FAttacker;
      }
      
      public function set Attacker(param1:String) : void
      {
         this.FAttacker = param1;
      }
      
      public function get Defender() : String
      {
         return this.FDefender;
      }
      
      public function set Defender(param1:String) : void
      {
         this.FDefender = param1;
      }
      
      public function get WinSign() : uint
      {
         return this.FWinSign;
      }
      
      public function set WinSign(param1:uint) : void
      {
         this.FWinSign = param1;
      }
      
      public function get SequenceWinCount() : uint
      {
         return this.FSequenceWinCount;
      }
      
      public function set SequenceWinCount(param1:uint) : void
      {
         this.FSequenceWinCount = param1;
      }
      
      public function get RestHPPercent() : uint
      {
         return this.FRestHPPercent;
      }
      
      public function set RestHPPercent(param1:uint) : void
      {
         this.FRestHPPercent = param1;
      }
      
      public function get LoserRank() : uint
      {
         return this.FLoserRank;
      }
      
      public function set LoserRank(param1:uint) : void
      {
         this.FLoserRank = param1;
      }
      
      public function get ReportID() : String
      {
         return this.FReportID;
      }
      
      public function set ReportID(param1:String) : void
      {
         this.FReportID = param1;
      }
      
      public function get AttackOrgID() : uint
      {
         return this.FAttackOrgID;
      }
      
      public function set AttackOrgID(param1:uint) : void
      {
         this.FAttackOrgID = param1;
      }
      
      public function get DefendOrgID() : uint
      {
         return this.FDefendOrgID;
      }
      
      public function set DefendOrgID(param1:uint) : void
      {
         this.FDefendOrgID = param1;
      }
      
      public function get AttackerID0() : uint
      {
         return this.FAttackerID0;
      }
      
      public function set AttackerID0(param1:uint) : void
      {
         this.FAttackerID0 = param1;
      }
      
      public function get AttackerID1() : uint
      {
         return this.FAttackerID1;
      }
      
      public function set AttackerID1(param1:uint) : void
      {
         this.FAttackerID1 = param1;
      }
      
      public function get DefenderID0() : uint
      {
         return this.FDefenderID0;
      }
      
      public function set DefenderID0(param1:uint) : void
      {
         this.FDefenderID0 = param1;
      }
      
      public function get DefenderID1() : uint
      {
         return this.FDefenderID1;
      }
      
      public function set DefenderID1(param1:uint) : void
      {
         this.FDefenderID1 = param1;
      }
   }
}

