package Logics.Exercise.WishTree
{
   import Logics.Exercise.ConsumeRank.TConsumeRankInfo;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   
   public class TWishTree extends TBaseActivity
   {
      
      protected static const BOX_COUNT:int = 3;
      
      protected static const REWARD_COUNT:int = 6;
      
      public static const IS_SUCCESSED:int = 0;
      
      public static const IS_FAILED:int = 1;
      
      protected var FFreeTimes:int;
      
      protected var FCurRank:int;
      
      protected var FPoint:int;
      
      protected var FCurLevel:int;
      
      protected var FIsFailed:int;
      
      protected var FWishEndTime:int;
      
      protected var FWishPrice:int;
      
      protected var FRewardList:Vector.<TBaseBox>;
      
      protected var FRankList:Vector.<TConsumeRankInfo>;
      
      protected var FKillBox:Vector.<TBaseBox>;
      
      protected var FKillRank:Vector.<TBaseBox>;
      
      public function TWishTree()
      {
         super();
         this.FRewardList = new Vector.<TBaseBox>(REWARD_COUNT);
         this.FRankList = new Vector.<TConsumeRankInfo>();
         this.FKillRank = new Vector.<TBaseBox>();
         this.FKillBox = new Vector.<TBaseBox>(BOX_COUNT);
      }
      
      public function get FreeTimes() : int
      {
         return this.FFreeTimes;
      }
      
      public function set FreeTimes(param1:int) : void
      {
         this.FFreeTimes = param1;
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
      
      public function get KillBox() : Vector.<TBaseBox>
      {
         return this.FKillBox;
      }
      
      public function set KillBox(param1:Vector.<TBaseBox>) : void
      {
         this.FKillBox = param1;
      }
      
      public function get KillRank() : Vector.<TBaseBox>
      {
         return this.FKillRank;
      }
      
      public function set KillRank(param1:Vector.<TBaseBox>) : void
      {
         this.FKillRank = param1;
      }
      
      public function get Point() : int
      {
         return this.FPoint;
      }
      
      public function set Point(param1:int) : void
      {
         this.FPoint = param1;
      }
      
      public function get CurLevel() : int
      {
         return this.FCurLevel;
      }
      
      public function set CurLevel(param1:int) : void
      {
         this.FCurLevel = param1;
      }
      
      public function get IsFailed() : int
      {
         return this.FIsFailed;
      }
      
      public function set IsFailed(param1:int) : void
      {
         this.FIsFailed = param1;
      }
      
      public function get RewardList() : Vector.<TBaseBox>
      {
         return this.FRewardList;
      }
      
      public function set RewardList(param1:Vector.<TBaseBox>) : void
      {
         this.FRewardList = param1;
      }
      
      public function get WishEndTime() : int
      {
         return this.FWishEndTime;
      }
      
      public function set WishEndTime(param1:int) : void
      {
         this.FWishEndTime = param1;
      }
      
      public function get WishPrice() : int
      {
         return this.FWishPrice;
      }
      
      public function set WishPrice(param1:int) : void
      {
         this.FWishPrice = param1;
      }
      
      public function ChangeStatus() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TBaseBox = null;
         _loc1_ = 0;
         while(_loc1_ < this.FKillBox.length)
         {
            _loc2_ = this.FKillBox[_loc1_];
            if(_loc2_.Status == TBaseActivity.STATUS_CANNOTGET && this.FPoint >= _loc2_.Price)
            {
               _loc2_.Status = TBaseActivity.STATUS_CANGET;
            }
            _loc1_++;
         }
      }
      
      public function CheckStatus() : Boolean
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         this.ChangeStatus();
         if(this.FFreeTimes > 0)
         {
            return true;
         }
         _loc1_ = 0;
         while(_loc1_ < this.FKillBox.length)
         {
            if(this.FKillBox[_loc1_].Status == TBaseActivity.STATUS_CANGET)
            {
               return true;
            }
            _loc1_++;
         }
         return false;
      }
   }
}

