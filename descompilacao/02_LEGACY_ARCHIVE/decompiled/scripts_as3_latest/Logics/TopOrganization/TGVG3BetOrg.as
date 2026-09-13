package Logics.TopOrganization
{
   public class TGVG3BetOrg
   {
      
      protected var FAgentID:uint;
      
      protected var FServerID:uint;
      
      protected var FOrgID:uint;
      
      protected var FOrgName:String;
      
      protected var FOrgLevel:uint;
      
      protected var FOrgMembersCount:uint;
      
      protected var FTotalBetCount:uint;
      
      public function TGVG3BetOrg()
      {
         super();
      }
      
      public function get OrgID() : uint
      {
         return this.FOrgID;
      }
      
      public function set OrgID(param1:uint) : void
      {
         this.FOrgID = param1;
      }
      
      public function get OrgName() : String
      {
         return this.FOrgName;
      }
      
      public function set OrgName(param1:String) : void
      {
         this.FOrgName = param1;
      }
      
      public function get OrgLevel() : uint
      {
         return this.FOrgLevel;
      }
      
      public function set OrgLevel(param1:uint) : void
      {
         this.FOrgLevel = param1;
      }
      
      public function get OrgMembersCount() : uint
      {
         return this.FOrgMembersCount;
      }
      
      public function set OrgMembersCount(param1:uint) : void
      {
         this.FOrgMembersCount = param1;
      }
      
      public function get TotalBetCount() : uint
      {
         return this.FTotalBetCount;
      }
      
      public function set TotalBetCount(param1:uint) : void
      {
         this.FTotalBetCount = param1;
      }
      
      public function get AgentID() : uint
      {
         return this.FAgentID;
      }
      
      public function set AgentID(param1:uint) : void
      {
         this.FAgentID = param1;
      }
      
      public function get ServerID() : uint
      {
         return this.FServerID;
      }
      
      public function set ServerID(param1:uint) : void
      {
         this.FServerID = param1;
      }
   }
}

