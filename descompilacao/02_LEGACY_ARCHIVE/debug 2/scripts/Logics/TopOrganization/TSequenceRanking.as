package Logics.TopOrganization
{
   public class TSequenceRanking
   {
      
      protected var FRank:uint;
      
      protected var FPlayerName:String;
      
      protected var FOrgName:String;
      
      protected var FSequenceCount:uint;
      
      protected var FRewardSilverCoin:uint;
      
      public function TSequenceRanking()
      {
         super();
      }
      
      public function get PlayerName() : String
      {
         return this.FPlayerName;
      }
      
      public function set PlayerName(param1:String) : void
      {
         this.FPlayerName = param1;
      }
      
      public function get OrgName() : String
      {
         return this.FOrgName;
      }
      
      public function set OrgName(param1:String) : void
      {
         this.FOrgName = param1;
      }
      
      public function get SequenceCount() : uint
      {
         return this.FSequenceCount;
      }
      
      public function set SequenceCount(param1:uint) : void
      {
         this.FSequenceCount = param1;
      }
      
      public function get Rank() : uint
      {
         return this.FRank;
      }
      
      public function set Rank(param1:uint) : void
      {
         this.FRank = param1;
      }
      
      public function get RewardSilverCoin() : uint
      {
         return this.FRewardSilverCoin;
      }
      
      public function set RewardSilverCoin(param1:uint) : void
      {
         this.FRewardSilverCoin = param1;
      }
   }
}

