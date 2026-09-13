package Logics.TopOrganization
{
   public class TJoinOrganization
   {
      
      protected var FRank:uint;
      
      protected var FOrgName:String;
      
      protected var FRestMembers:uint;
      
      protected var FTotalMembers:uint;
      
      public function TJoinOrganization()
      {
         super();
      }
      
      public function get Rank() : uint
      {
         return this.FRank;
      }
      
      public function set Rank(param1:uint) : void
      {
         this.FRank = param1;
      }
      
      public function get OrgName() : String
      {
         return this.FOrgName;
      }
      
      public function set OrgName(param1:String) : void
      {
         this.FOrgName = param1;
      }
      
      public function get RestMembers() : uint
      {
         return this.FRestMembers;
      }
      
      public function set RestMembers(param1:uint) : void
      {
         this.FRestMembers = param1;
      }
      
      public function get TotalMembers() : uint
      {
         return this.FTotalMembers;
      }
      
      public function set TotalMembers(param1:uint) : void
      {
         this.FTotalMembers = param1;
      }
   }
}

