package Logics.TopOrganization
{
   public class TOrganizationTop3Ranking
   {
      
      protected var FRank:uint;
      
      protected var FOrganizaitonName:String;
      
      public function TOrganizationTop3Ranking()
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
      
      public function get OrganizaitonName() : String
      {
         return this.FOrganizaitonName;
      }
      
      public function set OrganizaitonName(param1:String) : void
      {
         this.FOrganizaitonName = param1;
      }
   }
}

