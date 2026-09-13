package Logics.Exercise.FightBoss
{
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   
   public class TFightPoint extends TBaseActivity
   {
      
      public static const GAME_STATUS_NORMAL:int = 0;
      
      public static const GAME_STATUS_HAS_REWARD:int = 1;
      
      public static const GAME_STATUS_RESEET:int = 2;
      
      protected var FScore:int;
      
      protected var FGameStatus:int;
      
      protected var FBoxStatus:int;
      
      protected var FBoxList:Vector.<TBaseBox>;
      
      protected var FHeroList:Vector.<TBaseBox>;
      
      protected var FPointList:Vector.<TBaseBox>;
      
      protected var FCannonList:Vector.<TBaseBox>;
      
      protected var FBoxCount:int;
      
      public function TFightPoint()
      {
         super();
         this.FBoxList = new Vector.<TBaseBox>();
         this.FHeroList = new Vector.<TBaseBox>();
         this.FPointList = new Vector.<TBaseBox>();
         this.FCannonList = new Vector.<TBaseBox>();
      }
      
      public function get Score() : int
      {
         return this.FScore;
      }
      
      public function set Score(param1:int) : void
      {
         this.FScore = param1;
      }
      
      public function get BoxList() : Vector.<TBaseBox>
      {
         return this.FBoxList;
      }
      
      public function set BoxList(param1:Vector.<TBaseBox>) : void
      {
         this.FBoxList = param1;
      }
      
      public function get HeroList() : Vector.<TBaseBox>
      {
         return this.FHeroList;
      }
      
      public function set HeroList(param1:Vector.<TBaseBox>) : void
      {
         this.FHeroList = param1;
      }
      
      public function get PointList() : Vector.<TBaseBox>
      {
         return this.FPointList;
      }
      
      public function set PointList(param1:Vector.<TBaseBox>) : void
      {
         this.FPointList = param1;
      }
      
      public function get CannonList() : Vector.<TBaseBox>
      {
         return this.FCannonList;
      }
      
      public function set CannonList(param1:Vector.<TBaseBox>) : void
      {
         this.FCannonList = param1;
      }
      
      public function get GameStatus() : int
      {
         return this.FGameStatus;
      }
      
      public function set GameStatus(param1:int) : void
      {
         this.FGameStatus = param1;
      }
      
      public function get BoxStatus() : int
      {
         return this.FBoxStatus;
      }
      
      public function set BoxStatus(param1:int) : void
      {
         this.FBoxStatus = param1;
      }
      
      public function get BoxCount() : int
      {
         return this.FBoxCount;
      }
      
      public function set BoxCount(param1:int) : void
      {
         this.FBoxCount = param1;
      }
      
      public function HasAwardGet() : Boolean
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc2_ = int(this.FPointList.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(this.FPointList[_loc1_].Status == TBaseActivity.STATUS_CANGET)
            {
               return true;
            }
            _loc1_++;
         }
         return false;
      }
      
      public function NoPoint() : Boolean
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc2_ = int(this.FPointList.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(this.FPointList[_loc1_].Min > 0)
            {
               return false;
            }
            _loc1_++;
         }
         return true;
      }
      
      public function ChangeStatus() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc2_ = int(this.FPointList.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(this.FPointList[_loc1_].Min == 0 && this.FPointList[_loc1_].Status == TBaseActivity.STATUS_CANNOTGET)
            {
               this.FPointList[_loc1_].Status = TBaseActivity.STATUS_CANGET;
            }
            _loc1_++;
         }
         _loc2_ = int(this.FHeroList.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(this.FHeroList[_loc1_].Status == TBaseActivity.STATUS_CANNOTGET && this.FScore >= this.FHeroList[_loc1_].Price)
            {
               this.FHeroList[_loc1_].Status = TBaseActivity.STATUS_CANGET;
            }
            if(this.FHeroList[_loc1_].Status == TBaseActivity.STATUS_CANGET && this.FScore < this.FHeroList[_loc1_].Price)
            {
               this.FHeroList[_loc1_].Status = TBaseActivity.STATUS_CANNOTGET;
            }
            _loc1_++;
         }
      }
   }
}

