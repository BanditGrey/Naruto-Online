package Logics.Exercise.Christmas
{
   import Logics.Exercise.TBaseActivity;
   import Processors.Game.Lobby.Exercise.Christmas.TProcessorChristmas;
   
   public class TChristmasDatas
   {
      
      public static const ACTIVITY_1_ID:int = TProcessorChristmas.ACTIVITY_1_ID;
      
      public static const ACTIVITY_2_ID:int = TProcessorChristmas.ACTIVITY_2_ID;
      
      public static const ACTIVITY_3_ID:int = TProcessorChristmas.ACTIVITY_3_ID;
      
      public static const ACTIVITY_4_ID:int = TProcessorChristmas.ACTIVITY_4_ID;
      
      public static const ACTIVITY_5_ID:int = TProcessorChristmas.ACTIVITY_5_ID;
      
      protected var DATE_REFERENCE:Vector.<Class>;
      
      protected var ACTIVITY_COUNT:int = 5;
      
      protected var FActivities:Vector.<TBaseActivity>;
      
      protected var FEndTime:int;
      
      protected var FActivitiesStatus:Vector.<int>;
      
      public function TChristmasDatas()
      {
         var _loc1_:int = 0;
         var _loc2_:Class = null;
         this.DATE_REFERENCE = Vector.<Class>([TChristmasSign,TChristmasCollect,TChristmasColorEgg,TChristmasRank,TChristmasSock]);
         super();
         this.FActivities = new Vector.<TBaseActivity>(this.ACTIVITY_COUNT);
         _loc1_ = 0;
         while(_loc1_ < this.ACTIVITY_COUNT)
         {
            _loc2_ = this.DATE_REFERENCE[_loc1_];
            this.FActivities[_loc1_] = new _loc2_();
            this.FActivities[_loc1_].Identify = _loc1_ + 1;
            _loc1_++;
         }
      }
      
      public function get Activities() : Vector.<TBaseActivity>
      {
         return this.FActivities;
      }
      
      public function set Activities(param1:Vector.<TBaseActivity>) : void
      {
         this.FActivities = param1;
      }
      
      public function get EndTime() : int
      {
         return this.FEndTime;
      }
      
      public function set EndTime(param1:int) : void
      {
         this.FEndTime = param1;
      }
      
      public function get ActivitiesCount() : int
      {
         return this.FActivities.length;
      }
      
      public function GetActivityByIdentify(param1:int) : TBaseActivity
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc3_ = int(this.FActivities.length);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            if(this.FActivities[_loc2_].Identify == param1)
            {
               return this.FActivities[_loc2_];
            }
            _loc2_++;
         }
         return null;
      }
      
      public function GetActivityByIndex(param1:int) : TBaseActivity
      {
         var _loc2_:int = 0;
         if(param1 < this.FActivities.length)
         {
            return this.FActivities[param1];
         }
         return null;
      }
      
      public function GetActivityIndexByIdentify(param1:int) : int
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc3_ = int(this.FActivities.length);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            if(this.FActivities[_loc2_].Identify == param1)
            {
               return _loc2_;
            }
            _loc2_++;
         }
         return -1;
      }
      
      public function RemoveActivityByIdentify(param1:int) : void
      {
         var _loc2_:int = this.GetActivityIndexByIdentify(param1);
         if(_loc2_ == -1)
         {
            return;
         }
         this.FActivities.splice(_loc2_,1);
      }
      
      public function ChangeSingleActivityStatus(param1:int) : Boolean
      {
         var _loc2_:int = 0;
         switch(param1)
         {
            case ACTIVITY_1_ID:
               _loc2_ = (this.FActivities[0] as TChristmasSign).CurStatus;
               break;
            case ACTIVITY_2_ID:
               _loc2_ = this.ChangeCollectActivityStatus();
               break;
            case ACTIVITY_3_ID:
               _loc2_ = this.ChangeColorEggStatus();
               break;
            case ACTIVITY_4_ID:
               _loc2_ = this.ChangeRankStatus();
               break;
            case ACTIVITY_5_ID:
               _loc2_ = this.ChangeSockStatus();
         }
         if(_loc2_ == TBaseActivity.STATUS_CANGET)
         {
            this.FActivities[param1 - 1].NeedShine = TBaseActivity.STATUS_CANGET;
            return true;
         }
         this.FActivities[param1 - 1].NeedShine = TBaseActivity.STATUS_CANNOTGET;
         return false;
      }
      
      public function ChangeCollectActivityStatus() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TChristmasCollect = null;
         _loc3_ = this.FActivities[1] as TChristmasCollect;
         if(_loc3_.Status == TBaseActivity.STATUS_CANGET)
         {
            return TBaseActivity.STATUS_CANGET;
         }
         _loc1_ = 0;
         while(_loc1_ < _loc3_.BoxList.length)
         {
            if(_loc3_.BoxList[_loc1_].Status == TBaseActivity.STATUS_CANGET)
            {
               return TBaseActivity.STATUS_CANGET;
            }
            _loc1_++;
         }
         return TBaseActivity.STATUS_CANNOTGET;
      }
      
      public function ChangeColorEggStatus() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TChristmasColorEgg = null;
         _loc3_ = this.FActivities[2] as TChristmasColorEgg;
         if(_loc3_.Status == TBaseActivity.STATUS_CANGET)
         {
            return TBaseActivity.STATUS_CANGET;
         }
         _loc1_ = 0;
         while(_loc1_ < _loc3_.BoxList.length)
         {
            if(_loc3_.BoxList[_loc1_].Status == TBaseActivity.STATUS_CANGET)
            {
               return TBaseActivity.STATUS_CANGET;
            }
            _loc1_++;
         }
         return TBaseActivity.STATUS_CANNOTGET;
      }
      
      public function ChangeRankStatus() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TChristmasRank = null;
         _loc3_ = this.FActivities[3] as TChristmasRank;
         _loc1_ = 0;
         while(_loc1_ < _loc3_.BoxList.length)
         {
            if(_loc3_.BoxList[_loc1_].Status == TBaseActivity.STATUS_CANGET)
            {
               return TBaseActivity.STATUS_CANGET;
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < _loc3_.HeroList.length)
         {
            if(_loc3_.HeroList[_loc1_].Status == TBaseActivity.STATUS_CANGET)
            {
               return TBaseActivity.STATUS_CANGET;
            }
            _loc1_++;
         }
         return TBaseActivity.STATUS_CANNOTGET;
      }
      
      public function ChangeSockStatus() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TChristmasSock = null;
         _loc3_ = this.FActivities[4] as TChristmasSock;
         return TBaseActivity.STATUS_CANNOTGET;
      }
      
      public function CheckStatus() : Boolean
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < this.ACTIVITY_COUNT)
         {
            if(this.FActivities[_loc1_].NeedShine == TBaseActivity.STATUS_CANGET)
            {
               return true;
            }
            _loc1_++;
         }
         return false;
      }
   }
}

