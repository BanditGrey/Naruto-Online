package Logics.TopOrganization
{
   public class TGVG3BattleOrg
   {
      
      protected var FOrgID:uint;
      
      protected var FOrgName:String;
      
      protected var FServerName:String;
      
      protected var FOrgMemberCount:uint;
      
      protected var FOrgMemberDigests:TOrgMemberDigests;
      
      public function TGVG3BattleOrg()
      {
         super();
         this.FOrgMemberDigests = new TOrgMemberDigests();
      }
      
      public function get OrgMemberDigests() : TOrgMemberDigests
      {
         return this.FOrgMemberDigests;
      }
      
      public function set OrgMemberDigests(param1:TOrgMemberDigests) : void
      {
         this.FOrgMemberDigests = param1;
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
      
      public function get ServerName() : String
      {
         return this.FServerName;
      }
      
      public function set ServerName(param1:String) : void
      {
         this.FServerName = param1;
      }
      
      public function get OrgMemberCount() : uint
      {
         return this.FOrgMemberCount;
      }
      
      public function set OrgMemberCount(param1:uint) : void
      {
         this.FOrgMemberCount = param1;
      }
   }
}

