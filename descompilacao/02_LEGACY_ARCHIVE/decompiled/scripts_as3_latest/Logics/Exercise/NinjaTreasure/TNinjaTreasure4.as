package Logics.Exercise.NinjaTreasure
{
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   
   public class TNinjaTreasure4 extends TBaseActivity
   {
      
      public static const EXCHANGE_COUNT:int = 3;
      
      protected var FCurScore1:int;
      
      protected var FCurScore2:int;
      
      protected var FFightGold:int;
      
      protected var FFreeCount:int;
      
      protected var FKillCount:int;
      
      protected var FRefreshGold:int;
      
      protected var FCurBoss:int;
      
      protected var FCurHp:int;
      
      protected var FNinjaData:TBaseBox;
      
      protected var FScoreList:Vector.<int>;
      
      protected var FBossList:Vector.<TBaseBox>;
      
      protected var FExchangeBoxList:Vector.<TBaseBox>;
      
      protected var FFightCountRewardList:Vector.<TBaseBox>;
      
      public function TNinjaTreasure4()
      {
         super();
         this.FScoreList = new Vector.<int>();
         this.FBossList = new Vector.<TBaseBox>();
         this.FExchangeBoxList = new Vector.<TBaseBox>();
         this.FFightCountRewardList = new Vector.<TBaseBox>();
      }
      
      public function get FightGold() : int
      {
         return this.FFightGold;
      }
      
      public function set FightGold(param1:int) : void
      {
         this.FFightGold = param1;
      }
      
      public function get FreeCount() : int
      {
         return this.FFreeCount;
      }
      
      public function set FreeCount(param1:int) : void
      {
         this.FFreeCount = param1;
      }
      
      public function get RefreshGold() : int
      {
         return this.FRefreshGold;
      }
      
      public function set RefreshGold(param1:int) : void
      {
         this.FRefreshGold = param1;
      }
      
      public function get CurBoss() : int
      {
         return this.FCurBoss;
      }
      
      public function set CurBoss(param1:int) : void
      {
         this.FCurBoss = param1;
      }
      
      public function get NinjaData() : TBaseBox
      {
         return this.FNinjaData;
      }
      
      public function set NinjaData(param1:TBaseBox) : void
      {
         this.FNinjaData = param1;
      }
      
      public function get BossList() : Vector.<TBaseBox>
      {
         return this.FBossList;
      }
      
      public function set BossList(param1:Vector.<TBaseBox>) : void
      {
         this.FBossList = param1;
      }
      
      public function get ExchangeBoxList() : Vector.<TBaseBox>
      {
         return this.FExchangeBoxList;
      }
      
      public function set ExchangeBoxList(param1:Vector.<TBaseBox>) : void
      {
         this.FExchangeBoxList = param1;
      }
      
      public function get FightCountRewardList() : Vector.<TBaseBox>
      {
         return this.FFightCountRewardList;
      }
      
      public function set FightCountRewardList(param1:Vector.<TBaseBox>) : void
      {
         this.FFightCountRewardList = param1;
      }
      
      public function get KillCount() : int
      {
         return this.FKillCount;
      }
      
      public function set KillCount(param1:int) : void
      {
         this.FKillCount = param1;
      }
      
      public function get ScoreList() : Vector.<int>
      {
         return this.FScoreList;
      }
      
      public function set ScoreList(param1:Vector.<int>) : void
      {
         this.FScoreList = param1;
      }
      
      public function get CurHp() : int
      {
         return this.FCurHp;
      }
      
      public function set CurHp(param1:int) : void
      {
         this.FCurHp = param1;
      }
      
      public function GetBossIconIndex(param1:int) : int
      {
         var _loc2_:int = 0;
         _loc2_ = int(this.FBossList.length);
         if(_loc2_ > 0)
         {
            return (this.FCurBoss - 1 + param1 + 1) % _loc2_;
         }
         return -1;
      }
      
      public function ChangeStatus() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Boolean = false;
         var _loc4_:TBaseBox = null;
         var _loc5_:int = 0;
         _loc5_ = int(this.FFightCountRewardList.length);
         _loc1_ = 0;
         while(_loc1_ < _loc5_)
         {
            _loc4_ = this.FFightCountRewardList[_loc1_];
            if(_loc4_.Status == TBaseActivity.STATUS_CANNOTGET && this.FKillCount >= _loc4_.Price)
            {
               _loc4_.Status = TBaseActivity.STATUS_CANGET;
            }
            _loc1_++;
         }
         _loc5_ = int(this.FExchangeBoxList.length);
         _loc1_ = 0;
         while(_loc1_ < _loc5_)
         {
            _loc4_ = this.FExchangeBoxList[_loc1_];
            _loc3_ = true;
            if(_loc4_.LimitCount == 0)
            {
               _loc4_.Status = TBaseActivity.STATUS_GETED;
            }
            else
            {
               _loc2_ = 0;
               while(_loc2_ < EXCHANGE_COUNT)
               {
                  if(this.FScoreList[_loc2_] < _loc4_.ExchangeVect[_loc2_])
                  {
                     _loc3_ = false;
                  }
                  _loc2_++;
               }
               if(_loc3_)
               {
                  _loc4_.Status = TBaseActivity.STATUS_CANGET;
               }
               else
               {
                  _loc4_.Status = TBaseActivity.STATUS_CANNOTGET;
               }
            }
            _loc1_++;
         }
         _loc4_ = this.FNinjaData;
         _loc3_ = true;
         if(_loc4_.Status != TBaseActivity.STATUS_GETED)
         {
            _loc2_ = 0;
            while(_loc2_ < EXCHANGE_COUNT)
            {
               if(this.FScoreList[_loc2_] < _loc4_.ExchangeVect[_loc2_])
               {
                  _loc3_ = false;
               }
               _loc2_++;
            }
            if(_loc3_)
            {
               _loc4_.Status = TBaseActivity.STATUS_CANGET;
            }
            else
            {
               _loc4_.Status = TBaseActivity.STATUS_CANNOTGET;
            }
         }
      }
   }
}

