package Logics.Exercise.Christmas
{
   import Logics.Exercise.ConsumeRank.TConsumeRankInfo;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   
   public class TChristmasRank extends TBaseActivity
   {
      
      protected static const BOX_COUNT:int = 6;
      
      protected var FScore:int;
      
      protected var FMyRank:int;
      
      protected var FBoxList:Vector.<TBaseBox>;
      
      protected var FHeroList:Vector.<TBaseBox>;
      
      protected var FRankList:Vector.<TConsumeRankInfo>;
      
      protected var FRankRewardList:Vector.<TBaseBox>;
      
      public function TChristmasRank()
      {
         super();
         this.FBoxList = new Vector.<TBaseBox>();
         this.FHeroList = new Vector.<TBaseBox>();
         this.FRankList = new Vector.<TConsumeRankInfo>();
         this.FRankRewardList = new Vector.<TBaseBox>();
      }
      
      public function get BoxList() : Vector.<TBaseBox>
      {
         return this.FBoxList;
      }
      
      public function set BoxList(param1:Vector.<TBaseBox>) : void
      {
         this.FBoxList = param1;
      }
      
      public function get RankList() : Vector.<TConsumeRankInfo>
      {
         return this.FRankList;
      }
      
      public function set RankList(param1:Vector.<TConsumeRankInfo>) : void
      {
         this.FRankList = param1;
      }
      
      public function get RankRewardList() : Vector.<TBaseBox>
      {
         return this.FRankRewardList;
      }
      
      public function set RankRewardList(param1:Vector.<TBaseBox>) : void
      {
         this.FRankRewardList = param1;
      }
      
      public function get Score() : int
      {
         return this.FScore;
      }
      
      public function set Score(param1:int) : void
      {
         this.FScore = param1;
      }
      
      public function get MyRank() : int
      {
         return this.FMyRank;
      }
      
      public function set MyRank(param1:int) : void
      {
         this.FMyRank = param1;
      }
      
      public function get HeroList() : Vector.<TBaseBox>
      {
         return this.FHeroList;
      }
      
      public function set HeroList(param1:Vector.<TBaseBox>) : void
      {
         this.FHeroList = param1;
      }
      
      public function ChangeStatus() : void
      {
      }
   }
}

