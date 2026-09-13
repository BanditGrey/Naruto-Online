package Logics.Exercise.Hallowmas
{
   import Logics.Exercise.ConsumeRank.TConsumeRankInfo;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   
   public class THallowmas extends TBaseActivity
   {
      
      protected static const SWEET_COUNT:int = 3;
      
      protected static const HERO_COUNT:int = 2;
      
      protected static const KILL_BOX_COUNT:int = 3;
      
      protected static const EXCHANGE_BOX_COUNT:int = 4;
      
      public static const TYPE_KNIGHT:int = 20;
      
      public static const TYPE_BASE_SWEET:int = 21;
      
      protected var FFreeTimes:int;
      
      protected var FKilledTimes:int;
      
      protected var FCanKillTimes:int;
      
      protected var FCurRank:int;
      
      protected var FHallowmasBoxStatus:int;
      
      protected var FCallGold:int;
      
      protected var FSweetGold:int;
      
      protected var FSweetVect:Vector.<int>;
      
      protected var FRankList:Vector.<TConsumeRankInfo>;
      
      protected var FExchangeItemVect:Vector.<TBaseBox>;
      
      protected var FNinjiaVect:Vector.<TBaseBox>;
      
      protected var FKillBox:Vector.<TBaseBox>;
      
      protected var FKillRank:Vector.<TBaseBox>;
      
      public function THallowmas()
      {
         super();
         this.FSweetVect = new Vector.<int>(SWEET_COUNT);
         this.FNinjiaVect = new Vector.<TBaseBox>(HERO_COUNT);
         this.FRankList = new Vector.<TConsumeRankInfo>();
         this.FExchangeItemVect = new Vector.<TBaseBox>(EXCHANGE_BOX_COUNT);
         this.FKillRank = new Vector.<TBaseBox>();
         this.FKillBox = new Vector.<TBaseBox>(KILL_BOX_COUNT);
      }
      
      public function get FreeTimes() : int
      {
         return this.FFreeTimes;
      }
      
      public function set FreeTimes(param1:int) : void
      {
         this.FFreeTimes = param1;
      }
      
      public function get KilledTimes() : int
      {
         return this.FKilledTimes;
      }
      
      public function set KilledTimes(param1:int) : void
      {
         this.FKilledTimes = param1;
      }
      
      public function get CanKillTimes() : int
      {
         return this.FCanKillTimes;
      }
      
      public function set CanKillTimes(param1:int) : void
      {
         this.FCanKillTimes = param1;
      }
      
      public function get HallowmasBoxStatus() : int
      {
         return this.FHallowmasBoxStatus;
      }
      
      public function set HallowmasBoxStatus(param1:int) : void
      {
         this.FHallowmasBoxStatus = param1;
      }
      
      public function get SweetVect() : Vector.<int>
      {
         return this.FSweetVect;
      }
      
      public function set SweetVect(param1:Vector.<int>) : void
      {
         this.FSweetVect = param1;
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
      
      public function get ExchangeItemVect() : Vector.<TBaseBox>
      {
         return this.FExchangeItemVect;
      }
      
      public function set ExchangeItemVect(param1:Vector.<TBaseBox>) : void
      {
         this.FExchangeItemVect = param1;
      }
      
      public function get NinjiaVect() : Vector.<TBaseBox>
      {
         return this.FNinjiaVect;
      }
      
      public function set NinjiaVect(param1:Vector.<TBaseBox>) : void
      {
         this.FNinjiaVect = param1;
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
      
      public function get CallGold() : int
      {
         return this.FCallGold;
      }
      
      public function set CallGold(param1:int) : void
      {
         this.FCallGold = param1;
      }
      
      public function get SweetGold() : int
      {
         return this.FSweetGold;
      }
      
      public function set SweetGold(param1:int) : void
      {
         this.FSweetGold = param1;
      }
      
      public function CheckEffect() : Boolean
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         this.CheckBoxStatus();
         if(this.FHallowmasBoxStatus == TBaseActivity.STATUS_CANGET)
         {
            return true;
         }
         if(this.FFreeTimes > 0)
         {
            return true;
         }
         _loc1_ = 0;
         while(_loc1_ < KILL_BOX_COUNT)
         {
            if(this.FKillBox[_loc1_].Status == TBaseActivity.STATUS_CANGET)
            {
               return true;
            }
            _loc1_++;
         }
         return false;
      }
      
      public function CheckBoxStatus() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Boolean = false;
         var _loc4_:TBaseBox = null;
         _loc1_ = 0;
         while(_loc1_ < KILL_BOX_COUNT)
         {
            _loc4_ = this.FKillBox[_loc1_];
            if(_loc4_.Status == TBaseActivity.STATUS_CANNOTGET && this.FKilledTimes >= _loc4_.Price)
            {
               _loc4_.Status = TBaseActivity.STATUS_CANGET;
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < EXCHANGE_BOX_COUNT)
         {
            _loc4_ = this.FExchangeItemVect[_loc1_];
            _loc3_ = true;
            if(_loc4_.BuyCount == _loc4_.Count)
            {
               _loc4_.Status = TBaseActivity.STATUS_GETED;
            }
            else
            {
               _loc2_ = 0;
               while(_loc2_ < SWEET_COUNT)
               {
                  if(this.FSweetVect[_loc2_] < _loc4_.ExchangeVect[_loc2_])
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
         _loc1_ = 0;
         while(_loc1_ < HERO_COUNT)
         {
            _loc4_ = this.FNinjiaVect[_loc1_];
            _loc3_ = true;
            if(_loc4_.Status != TBaseActivity.STATUS_GETED)
            {
               _loc2_ = 0;
               while(_loc2_ < SWEET_COUNT)
               {
                  if(this.FSweetVect[_loc2_] < _loc4_.ExchangeVect[_loc2_])
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
      }
   }
}

