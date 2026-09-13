package Logics.TopOrganization
{
   public class TUserBetInfo
   {
      
      protected var FRound:uint;
      
      protected var FAttackOrgID:uint;
      
      protected var FDefendOrgID:uint;
      
      protected var FBetOrgID:uint;
      
      protected var FBetType:uint;
      
      public function TUserBetInfo()
      {
         super();
      }
      
      public function get Round() : uint
      {
         return this.FRound;
      }
      
      public function set Round(param1:uint) : void
      {
         this.FRound = param1;
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
      
      public function get BetOrgID() : uint
      {
         return this.FBetOrgID;
      }
      
      public function set BetOrgID(param1:uint) : void
      {
         this.FBetOrgID = param1;
      }
      
      public function get BetType() : uint
      {
         return this.FBetType;
      }
      
      public function set BetType(param1:uint) : void
      {
         this.FBetType = param1;
      }
   }
}

