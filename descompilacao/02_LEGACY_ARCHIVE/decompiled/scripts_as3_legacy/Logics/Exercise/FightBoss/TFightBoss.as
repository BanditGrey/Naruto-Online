package Logics.Exercise.FightBoss
{
   import Logics.Exercise.ConsumeRank.TConsumeRankInfo;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   
   public class TFightBoss extends TBaseActivity
   {
      
      protected var FFreeCount:int;
      
      protected var FLimitCount:int;
      
      protected var FScore:int;
      
      protected var FRound:int;
      
      protected var FCount:int;
      
      protected var FMaxHP:int;
      
      protected var FCurHP:int;
      
      protected var FCost:int;
      
      protected var FCurRank:int;
      
      protected var FBoxList:Vector.<TBaseBox>;
      
      protected var FGiftList:Vector.<TBaseBox>;
      
      protected var FHeroList:Vector.<TBaseBox>;
      
      protected var FRankList:Vector.<TConsumeRankInfo>;
      
      protected var FRankRewardList:Vector.<TBaseBox>;
      
      public function TFightBoss()
      {
         super();
         this.FBoxList = new Vector.<TBaseBox>();
         this.FGiftList = new Vector.<TBaseBox>();
         this.FHeroList = new Vector.<TBaseBox>();
         this.FRankList = new Vector.<TConsumeRankInfo>();
         this.FRankRewardList = new Vector.<TBaseBox>();
      }
      
      public function get FreeCount() : int
      {
         return this.FFreeCount;
      }
      
      public function set FreeCount(param1:int) : void
      {
         this.FFreeCount = param1;
      }
      
      public function get LimitCount() : int
      {
         return this.FLimitCount;
      }
      
      public function set LimitCount(param1:int) : void
      {
         this.FLimitCount = param1;
      }
      
      public function get Score() : int
      {
         return this.FScore;
      }
      
      public function set Score(param1:int) : void
      {
         this.FScore = param1;
      }
      
      public function get Round() : int
      {
         return this.FRound;
      }
      
      public function set Round(param1:int) : void
      {
         this.FRound = param1;
      }
      
      public function get BoxList() : Vector.<TBaseBox>
      {
         return this.FBoxList;
      }
      
      public function set BoxList(param1:Vector.<TBaseBox>) : void
      {
         this.FBoxList = param1;
      }
      
      public function get GiftList() : Vector.<TBaseBox>
      {
         return this.FGiftList;
      }
      
      public function set GiftList(param1:Vector.<TBaseBox>) : void
      {
         this.FGiftList = param1;
      }
      
      public function get HeroList() : Vector.<TBaseBox>
      {
         return this.FHeroList;
      }
      
      public function set HeroList(param1:Vector.<TBaseBox>) : void
      {
         this.FHeroList = param1;
      }
      
      public function get Count() : int
      {
         return this.FCount;
      }
      
      public function set Count(param1:int) : void
      {
         this.FCount = param1;
      }
      
      public function get MaxHP() : int
      {
         return this.FMaxHP;
      }
      
      public function set MaxHP(param1:int) : void
      {
         this.FMaxHP = param1;
      }
      
      public function get CurHP() : int
      {
         return this.FCurHP;
      }
      
      public function set CurHP(param1:int) : void
      {
         this.FCurHP = param1;
      }
      
      public function get Cost() : int
      {
         return this.FCost;
      }
      
      public function set Cost(param1:int) : void
      {
         this.FCost = param1;
      }
      
      public function get CurRank() : int
      {
         return this.FCurRank;
      }
      
      public function set CurRank(param1:int) : void
      {
         this.FCurRank = param1;
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
      
      public function ChangeStatus() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc2_ = int(this.FGiftList.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(this.FGiftList[_loc1_].Status == TBaseActivity.STATUS_CANNOTGET && this.FCount >= this.FGiftList[_loc1_].Price)
            {
               this.FGiftList[_loc1_].Status = TBaseActivity.STATUS_CANGET;
            }
            _loc1_++;
         }
         if(this.FHeroList[0].Status == TBaseActivity.STATUS_CANNOTGET && this.FScore >= this.FHeroList[0].Price)
         {
            this.FHeroList[0].Status = TBaseActivity.STATUS_CANGET;
         }
      }
   }
}

