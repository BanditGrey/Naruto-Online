package Logics.Challenge
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Logics.DatebaseVO.VO.TChallengeWeekReward;
   import Logics.Exercise.ConsumeRank.TConsumeRankInfo;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventorySamples;
   import Resources.Constants.CONST_DATEBASEVO;
   
   public class TChallenge
   {
      
      public var CurBoss:int;
      
      public var Point:int;
      
      public var BeginTime:int;
      
      public var EndTime:int;
      
      public var ChallengeMax:int;
      
      public var CurCount:int;
      
      public var CurPrice:int;
      
      public var TotalCount:int;
      
      public var LimitCount:int;
      
      public var FrontList:Vector.<uint>;
      
      public var MiddleList:Vector.<uint>;
      
      public var BackList:Vector.<uint>;
      
      public var TotalList:Vector.<uint>;
      
      public var CurRank:int;
      
      public var CurHurt:String;
      
      public var RankList:Vector.<TConsumeRankInfo>;
      
      public var DailyReward:Vector.<TBaseBox>;
      
      public var InventorySamples:TInventorySamples;
      
      protected var FChallengeWeekReward:TBins;
      
      public function TChallenge()
      {
         super();
         this.FrontList = new Vector.<uint>();
         this.MiddleList = new Vector.<uint>();
         this.BackList = new Vector.<uint>();
         this.TotalList = new Vector.<uint>();
         this.RankList = new Vector.<TConsumeRankInfo>();
         this.DailyReward = new Vector.<TBaseBox>();
         this.InventorySamples = new TInventorySamples();
      }
      
      public function ChangeStatus() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < this.DailyReward.length)
         {
            if(this.DailyReward[_loc1_].Status == TBaseActivity.STATUS_CANNOTGET && this.TotalCount >= this.DailyReward[_loc1_].Count)
            {
               this.DailyReward[_loc1_].Status = TBaseActivity.STATUS_CANGET;
            }
            _loc1_++;
         }
      }
      
      public function CurRankIndex() : int
      {
         var _loc1_:int = 0;
         var _loc2_:TChallengeWeekReward = null;
         if(this.CurRank == 0)
         {
            return -1;
         }
         if(!this.FChallengeWeekReward)
         {
            this.FChallengeWeekReward = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_ChallengeWeekReward);
         }
         _loc1_ = 0;
         while(_loc1_ < this.FChallengeWeekReward.Count)
         {
            _loc2_ = this.FChallengeWeekReward.GetDatebaseByIndex(_loc1_) as TChallengeWeekReward;
            if(this.CurRank >= _loc2_.Rank[0] && this.CurRank <= _loc2_.Rank[1])
            {
               return _loc1_;
            }
            _loc1_++;
         }
         return _loc1_ - 1;
      }
      
      public function ChangeRewardById(param1:int) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < this.DailyReward.length)
         {
            if(this.DailyReward[_loc2_].Identify == param1)
            {
               this.DailyReward[_loc2_].Status = TBaseActivity.STATUS_GETED;
            }
            _loc2_++;
         }
      }
   }
}

