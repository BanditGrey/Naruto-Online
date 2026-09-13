package Logics.Exercise.NinjaTreasure
{
   import Logics.Exercise.ConsumeRank.TConsumeRankInfo;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   
   public class TNinjaTreasure3 extends TBaseActivity
   {
      
      protected var FScore:int;
      
      protected var FScoreB:int;
      
      protected var FArrestTime:int;
      
      protected var FCurRank:int;
      
      protected var FRefreshCost:int;
      
      protected var FArrestCost:int;
      
      protected var FArrestIndex:int;
      
      protected var FRewardRount:int;
      
      protected var FKeyPatch:int;
      
      protected var FPatchPrice:int;
      
      protected var FArrestCount:int;
      
      protected var FFreeArrestCount:int;
      
      protected var FRewardList:Vector.<TBaseBox>;
      
      protected var FSpecialReward:Vector.<TBaseBox>;
      
      protected var FArrestCountReward:Vector.<TBaseBox>;
      
      protected var FArrestList:Vector.<TBaseBox>;
      
      protected var FBoxList:Vector.<TBaseBox>;
      
      protected var FOpenBoxReward:Vector.<TBaseBox>;
      
      protected var FRankRewardList:Vector.<TBaseBox>;
      
      protected var FRankList:Vector.<TConsumeRankInfo>;
      
      public function TNinjaTreasure3()
      {
         super();
         this.FRewardList = new Vector.<TBaseBox>();
         this.FSpecialReward = new Vector.<TBaseBox>();
         this.FBoxList = new Vector.<TBaseBox>();
         this.FOpenBoxReward = new Vector.<TBaseBox>();
         this.FArrestList = new Vector.<TBaseBox>();
         this.FRankRewardList = new Vector.<TBaseBox>();
         this.FRankList = new Vector.<TConsumeRankInfo>();
         this.FArrestCountReward = new Vector.<TBaseBox>();
      }
      
      public function get Score() : int
      {
         return this.FScore;
      }
      
      public function set Score(param1:int) : void
      {
         this.FScore = param1;
      }
      
      public function get ScoreB() : int
      {
         return this.FScoreB;
      }
      
      public function set ScoreB(param1:int) : void
      {
         this.FScoreB = param1;
      }
      
      public function get ArrestTime() : int
      {
         return this.FArrestTime;
      }
      
      public function set ArrestTime(param1:int) : void
      {
         this.FArrestTime = param1;
      }
      
      public function get CurRank() : int
      {
         return this.FCurRank;
      }
      
      public function set CurRank(param1:int) : void
      {
         this.FCurRank = param1;
      }
      
      public function get RewardList() : Vector.<TBaseBox>
      {
         return this.FRewardList;
      }
      
      public function set RewardList(param1:Vector.<TBaseBox>) : void
      {
         this.FRewardList = param1;
      }
      
      public function get RewardRount() : int
      {
         return this.FRewardRount;
      }
      
      public function set RewardRount(param1:int) : void
      {
         this.FRewardRount = param1;
      }
      
      public function get SpecialReward() : Vector.<TBaseBox>
      {
         return this.FSpecialReward;
      }
      
      public function set SpecialReward(param1:Vector.<TBaseBox>) : void
      {
         this.FSpecialReward = param1;
      }
      
      public function get RefreshCost() : int
      {
         return this.FRefreshCost;
      }
      
      public function set RefreshCost(param1:int) : void
      {
         this.FRefreshCost = param1;
      }
      
      public function get ArrestCost() : int
      {
         return this.FArrestCost;
      }
      
      public function set ArrestCost(param1:int) : void
      {
         this.FArrestCost = param1;
      }
      
      public function get BoxList() : Vector.<TBaseBox>
      {
         return this.FBoxList;
      }
      
      public function set BoxList(param1:Vector.<TBaseBox>) : void
      {
         this.FBoxList = param1;
      }
      
      public function get OpenBoxReward() : Vector.<TBaseBox>
      {
         return this.FOpenBoxReward;
      }
      
      public function set OpenBoxReward(param1:Vector.<TBaseBox>) : void
      {
         this.FOpenBoxReward = param1;
      }
      
      public function get ArrestList() : Vector.<TBaseBox>
      {
         return this.FArrestList;
      }
      
      public function set ArrestList(param1:Vector.<TBaseBox>) : void
      {
         this.FArrestList = param1;
      }
      
      public function get RankRewardList() : Vector.<TBaseBox>
      {
         return this.FRankRewardList;
      }
      
      public function set RankRewardList(param1:Vector.<TBaseBox>) : void
      {
         this.FRankRewardList = param1;
      }
      
      public function get RankList() : Vector.<TConsumeRankInfo>
      {
         return this.FRankList;
      }
      
      public function set RankList(param1:Vector.<TConsumeRankInfo>) : void
      {
         this.FRankList = param1;
      }
      
      public function get ArrestIndex() : int
      {
         return this.FArrestIndex;
      }
      
      public function set ArrestIndex(param1:int) : void
      {
         this.FArrestIndex = param1;
      }
      
      public function get KeyPatch() : int
      {
         return this.FKeyPatch;
      }
      
      public function set KeyPatch(param1:int) : void
      {
         this.FKeyPatch = param1;
      }
      
      public function get PatchPrice() : int
      {
         return this.FPatchPrice;
      }
      
      public function set PatchPrice(param1:int) : void
      {
         this.FPatchPrice = param1;
      }
      
      public function get ArrestCountReward() : Vector.<TBaseBox>
      {
         return this.FArrestCountReward;
      }
      
      public function set ArrestCountReward(param1:Vector.<TBaseBox>) : void
      {
         this.FArrestCountReward = param1;
      }
      
      public function get ArrestCount() : int
      {
         return this.FArrestCount;
      }
      
      public function set ArrestCount(param1:int) : void
      {
         this.FArrestCount = param1;
      }
      
      public function get FreeArrestCount() : int
      {
         return this.FFreeArrestCount;
      }
      
      public function set FreeArrestCount(param1:int) : void
      {
         this.FFreeArrestCount = param1;
      }
      
      public function ChangeStatus() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(this.FScoreB >= this.FSpecialReward[0].Price && this.FSpecialReward[0].Status == TBaseActivity.STATUS_CANNOTGET)
         {
            this.FSpecialReward[0].Status = TBaseActivity.STATUS_CANGET;
         }
         _loc2_ = int(this.FArrestCountReward.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(this.FArrestCount >= this.FArrestCountReward[_loc1_].Price && this.FArrestCountReward[_loc1_].Status == TBaseActivity.STATUS_CANNOTGET)
            {
               this.FArrestCountReward[_loc1_].Status = TBaseActivity.STATUS_CANGET;
            }
            _loc1_++;
         }
      }
   }
}

