package Logics.Exercise.BaseRank
{
   public class TRankInfo
   {
      
      protected var FRankDate:int;
      
      protected var FRank:int;
      
      protected var FScore:int;
      
      protected var FRewardIndex:int;
      
      protected var FSpecialStatus:int;
      
      protected var FName:String;
      
      public function TRankInfo()
      {
         super();
      }
      
      public function get RankDate() : int
      {
         return this.FRankDate;
      }
      
      public function set RankDate(param1:int) : void
      {
         this.FRankDate = param1;
      }
      
      public function get Rank() : int
      {
         return this.FRank;
      }
      
      public function set Rank(param1:int) : void
      {
         this.FRank = param1;
      }
      
      public function get Score() : int
      {
         return this.FScore;
      }
      
      public function set Score(param1:int) : void
      {
         this.FScore = param1;
      }
      
      public function get RewardIndex() : int
      {
         return this.FRewardIndex;
      }
      
      public function set RewardIndex(param1:int) : void
      {
         this.FRewardIndex = param1;
      }
      
      public function get SpecialStatus() : int
      {
         return this.FSpecialStatus;
      }
      
      public function set SpecialStatus(param1:int) : void
      {
         this.FSpecialStatus = param1;
      }
      
      public function get Name() : String
      {
         return this.FName;
      }
      
      public function set Name(param1:String) : void
      {
         this.FName = param1;
      }
   }
}

