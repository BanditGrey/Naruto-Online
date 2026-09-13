package Logics.NinjaRelation
{
   public class TNinjaRelationData
   {
      
      protected var FNinjaTeamBuffs:TNinjaTeamBuffs;
      
      protected var FNinjaGroupBuffs:TNinjaGroupBuffs;
      
      public function TNinjaRelationData()
      {
         super();
         this.FNinjaTeamBuffs = new TNinjaTeamBuffs();
         this.FNinjaGroupBuffs = new TNinjaGroupBuffs();
      }
      
      public function get NinjaTeamBuffs() : TNinjaTeamBuffs
      {
         return this.FNinjaTeamBuffs;
      }
      
      public function set NinjaTeamBuffs(param1:TNinjaTeamBuffs) : void
      {
         this.FNinjaTeamBuffs = param1;
      }
      
      public function get NinjaGroupBuffs() : TNinjaGroupBuffs
      {
         return this.FNinjaGroupBuffs;
      }
      
      public function set NinjaGroupBuffs(param1:TNinjaGroupBuffs) : void
      {
         this.FNinjaGroupBuffs = param1;
      }
   }
}

