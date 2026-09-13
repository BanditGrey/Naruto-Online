package Logics.Exercise.HappyTreasure
{
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Lottery.TLotteryNews;
   
   public class THappyTreasure extends TBaseActivity
   {
      
      public static const BOX_TYPE:int = 6;
      
      public static const MAX_BOX:int = 56;
      
      protected var FTotalScore:uint;
      
      protected var FCurScore:uint;
      
      protected var FBoxPrice:uint;
      
      protected var FTotalBoxPrice:uint;
      
      protected var FRewards:TInventories;
      
      protected var FRewardsIndex:Vector.<uint>;
      
      protected var FRewardsLevel:Vector.<uint>;
      
      protected var FNewsList:Vector.<TLotteryNews>;
      
      public var Max:int;
      
      public var RechargeMin:int;
      
      public var RechargeMax:int;
      
      public var ConsumeMin:int;
      
      public var ConsumeMax:int;
      
      protected var FCurBarValue:int;
      
      public var BarItems:Vector.<TBaseBox>;
      
      public function THappyTreasure()
      {
         super();
         this.FRewardsIndex = new Vector.<uint>();
         this.FRewardsLevel = new Vector.<uint>();
         this.FNewsList = new Vector.<TLotteryNews>();
         this.BarItems = new Vector.<TBaseBox>();
      }
      
      public function get Rewards() : TInventories
      {
         return this.FRewards;
      }
      
      public function set Rewards(param1:TInventories) : void
      {
         this.FRewards = param1;
      }
      
      public function get RewardsIndex() : Vector.<uint>
      {
         return this.FRewardsIndex;
      }
      
      public function set RewardsIndex(param1:Vector.<uint>) : void
      {
         this.FRewardsIndex = param1;
      }
      
      public function get TotalScore() : uint
      {
         return this.FTotalScore;
      }
      
      public function set TotalScore(param1:uint) : void
      {
         this.FTotalScore = param1;
      }
      
      public function get CurScore() : uint
      {
         return this.FCurScore;
      }
      
      public function set CurScore(param1:uint) : void
      {
         this.FCurScore = param1;
      }
      
      public function get NewsList() : Vector.<TLotteryNews>
      {
         return this.FNewsList;
      }
      
      public function set NewsList(param1:Vector.<TLotteryNews>) : void
      {
         this.FNewsList = param1;
      }
      
      public function get RewardsLevel() : Vector.<uint>
      {
         return this.FRewardsLevel;
      }
      
      public function set RewardsLevel(param1:Vector.<uint>) : void
      {
         this.FRewardsLevel = param1;
      }
      
      public function get BoxPrice() : uint
      {
         return this.FBoxPrice;
      }
      
      public function set BoxPrice(param1:uint) : void
      {
         this.FBoxPrice = param1;
      }
      
      public function get TotalBoxPrice() : uint
      {
         return this.FTotalBoxPrice;
      }
      
      public function set TotalBoxPrice(param1:uint) : void
      {
         this.FTotalBoxPrice = param1;
      }
      
      public function get CurBarValue() : int
      {
         return this.FCurBarValue;
      }
      
      public function set CurBarValue(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         this.FCurBarValue = param1;
         _loc3_ = int(this.BarItems.length);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            if(this.BarItems[_loc2_].Status == TBaseActivity.STATUS_CANNOTGET && this.FCurBarValue >= this.BarItems[_loc2_].Price)
            {
               this.BarItems[_loc2_].Status = TBaseActivity.STATUS_CANGET;
            }
            _loc2_++;
         }
      }
      
      public function IsPointOpen(param1:int) : Boolean
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc3_ = int(this.RewardsIndex.length);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            if(this.RewardsIndex[_loc2_] == param1)
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      public function GetBoxLevel(param1:int) : int
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc3_ = int(this.RewardsIndex.length);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            if(this.RewardsIndex[_loc2_] == param1)
            {
               return this.FRewardsLevel[_loc2_];
            }
            _loc2_++;
         }
         return -1;
      }
      
      public function ChangeStatus() : void
      {
      }
      
      public function CheckStatus() : Boolean
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc2_ = int(this.BarItems.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(this.BarItems[_loc1_].Status == TBaseActivity.STATUS_CANGET)
            {
               return true;
            }
            _loc1_++;
         }
         return false;
      }
   }
}

