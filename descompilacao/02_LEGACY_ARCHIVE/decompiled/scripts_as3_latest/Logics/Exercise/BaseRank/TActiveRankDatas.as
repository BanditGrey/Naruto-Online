package Logics.Exercise.BaseRank
{
   import Foundation.Resources.SResourcesCore;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TActivityDesc;
   import Logics.Exercise.TBaseActivity;
   import Logics.Inventories.TInventories;
   import Resources.Constants.CONST_DATEBASEVO;
   
   public class TActiveRankDatas
   {
      
      protected static const RANK_COUNT:int = 4;
      
      protected var DATE_REFERENCE:Vector.<Class>;
      
      protected var FActivityID:int;
      
      protected var FActivityIndex:int;
      
      protected var FRankDatas:Vector.<TBaseRank>;
      
      protected var FDescList:Vector.<String>;
      
      protected var FTotalScore:int;
      
      protected var FTodayScore:int;
      
      protected var FTotalRank:int;
      
      protected var FTodayRank:int;
      
      protected var FTodayRewards:Vector.<TInventories>;
      
      protected var FTodaySpecials:Vector.<TInventories>;
      
      protected var FTotalRewards:Vector.<TInventories>;
      
      protected var FTotalSpecials:Vector.<TInventories>;
      
      protected var FTodayCommand:Vector.<int>;
      
      protected var FTotalCommand:Vector.<int>;
      
      protected var FIsEnd:int;
      
      public var DescListNew:Vector.<String>;
      
      public function TActiveRankDatas()
      {
         var _loc1_:int = 0;
         var _loc2_:Class = null;
         this.DATE_REFERENCE = Vector.<Class>([TTodayRank,TYesterdayRank,TTotalRank,TMyRank]);
         super();
         this.FRankDatas = new Vector.<TBaseRank>(RANK_COUNT);
         _loc1_ = 0;
         while(_loc1_ < RANK_COUNT)
         {
            _loc2_ = this.DATE_REFERENCE[_loc1_];
            this.FRankDatas[_loc1_] = new _loc2_();
            this.FRankDatas[_loc1_].Identify = _loc1_ + 1;
            _loc1_++;
         }
         this.FDescList = new Vector.<String>();
         this.FTodayCommand = new Vector.<int>();
         this.FTotalCommand = new Vector.<int>();
         this.FTodayRewards = new Vector.<TInventories>();
         this.FTodaySpecials = new Vector.<TInventories>();
         this.FTotalRewards = new Vector.<TInventories>();
         this.FTotalSpecials = new Vector.<TInventories>();
         this.DescListNew = new Vector.<String>();
      }
      
      public function get RankDatas() : Vector.<TBaseRank>
      {
         return this.FRankDatas;
      }
      
      public function set RankDatas(param1:Vector.<TBaseRank>) : void
      {
         this.FRankDatas = param1;
      }
      
      public function get TotalScore() : int
      {
         return this.FTotalScore;
      }
      
      public function set TotalScore(param1:int) : void
      {
         this.FTotalScore = param1;
      }
      
      public function get TodayScore() : int
      {
         return this.FTodayScore;
      }
      
      public function set TodayScore(param1:int) : void
      {
         this.FTodayScore = param1;
      }
      
      public function get TotalRank() : int
      {
         return this.FTotalRank;
      }
      
      public function set TotalRank(param1:int) : void
      {
         this.FTotalRank = param1;
      }
      
      public function get TodayRank() : int
      {
         return this.FTodayRank;
      }
      
      public function set TodayRank(param1:int) : void
      {
         this.FTodayRank = param1;
      }
      
      public function get DescList() : Vector.<String>
      {
         return this.FDescList;
      }
      
      public function set DescList(param1:Vector.<String>) : void
      {
         this.FDescList = param1;
      }
      
      public function get TodayRewards() : Vector.<TInventories>
      {
         return this.FTodayRewards;
      }
      
      public function set TodayRewards(param1:Vector.<TInventories>) : void
      {
         this.FTodayRewards = param1;
      }
      
      public function get TodaySpecials() : Vector.<TInventories>
      {
         return this.FTodaySpecials;
      }
      
      public function set TodaySpecials(param1:Vector.<TInventories>) : void
      {
         this.FTodaySpecials = param1;
      }
      
      public function get TotalRewards() : Vector.<TInventories>
      {
         return this.FTotalRewards;
      }
      
      public function set TotalRewards(param1:Vector.<TInventories>) : void
      {
         this.FTotalRewards = param1;
      }
      
      public function get TotalSpecials() : Vector.<TInventories>
      {
         return this.FTotalSpecials;
      }
      
      public function set TotalSpecials(param1:Vector.<TInventories>) : void
      {
         this.FTotalSpecials = param1;
      }
      
      public function get TodayCommand() : Vector.<int>
      {
         return this.FTodayCommand;
      }
      
      public function set TodayCommand(param1:Vector.<int>) : void
      {
         this.FTodayCommand = param1;
      }
      
      public function get TotalCommand() : Vector.<int>
      {
         return this.FTotalCommand;
      }
      
      public function set TotalCommand(param1:Vector.<int>) : void
      {
         this.FTotalCommand = param1;
      }
      
      public function get ActivityID() : int
      {
         return this.FActivityID;
      }
      
      public function set ActivityID(param1:int) : void
      {
         this.FActivityID = param1;
      }
      
      public function get ActivityIndex() : int
      {
         return this.FActivityIndex;
      }
      
      public function set ActivityIndex(param1:int) : void
      {
         this.FActivityIndex = param1;
      }
      
      public function get IsEnd() : int
      {
         return this.FIsEnd;
      }
      
      public function set IsEnd(param1:int) : void
      {
         this.FIsEnd = param1;
      }
      
      public function GetRankByIdentify(param1:int) : TBaseRank
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc3_ = int(this.FRankDatas.length);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            if(this.FRankDatas[_loc2_].Identify == param1)
            {
               return this.FRankDatas[_loc2_];
            }
            _loc2_++;
         }
         return null;
      }
      
      public function GetActivityByIndex(param1:int) : TBaseRank
      {
         var _loc2_:int = 0;
         if(param1 < this.FRankDatas.length)
         {
            return this.FRankDatas[param1];
         }
         return null;
      }
      
      public function GetInventoriesByType(param1:int, param2:int, param3:int) : TInventories
      {
         var _loc4_:Vector.<TInventories> = null;
         if(param1 == 3)
         {
            if(param2 == 0)
            {
               _loc4_ = this.FTotalRewards;
            }
            else
            {
               _loc4_ = this.FTotalSpecials;
            }
         }
         else if(param2 == 0)
         {
            _loc4_ = this.FTodayRewards;
         }
         else
         {
            _loc4_ = this.FTodaySpecials;
         }
         if(param3 >= 0 && param3 < _loc4_.length)
         {
            return _loc4_[param3];
         }
         return null;
      }
      
      public function GetCommandByType(param1:int, param2:int) : int
      {
         var _loc3_:Vector.<int> = null;
         if(param1 == 3)
         {
            _loc3_ = this.FTotalCommand;
         }
         else
         {
            _loc3_ = this.FTodayCommand;
         }
         if(param2 >= 0 && param2 < _loc3_.length)
         {
            if(_loc3_[param2] > 0)
            {
               return _loc3_[param2];
            }
            return 0;
         }
         return 0;
      }
      
      public function GetCommandStringByType(param1:int, param2:int) : String
      {
         var _loc3_:int = 0;
         _loc3_ = this.GetCommandByType(param1,param2);
         if(_loc3_ > 0)
         {
            return TUtilityString.Format(this.FDescList[1],_loc3_);
         }
         return "";
      }
      
      public function InitDescListNew() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:TActivityDesc = null;
         if(this.DescListNew.length > 0 && Boolean(this.DescListNew[0]))
         {
            return;
         }
         _loc1_ = 0;
         while(_loc1_ < this.FDescList.length)
         {
            _loc2_ = int(parseInt(this.FDescList[_loc1_]));
            if(TBaseActivity.IsRealNumber(this.FDescList[_loc1_]) && !isNaN(_loc2_) && _loc2_ > 0)
            {
               _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ActivityDesc,_loc2_) as TActivityDesc;
               if(_loc4_)
               {
                  _loc3_ = _loc4_.Desc;
                  _loc3_ = _loc3_.split("&lt;").join("<");
                  _loc3_ = _loc3_.split("&gt;").join(">");
                  this.DescListNew[_loc1_] = _loc3_;
               }
               else
               {
                  this.DescListNew[_loc1_] = this.FDescList[_loc1_];
               }
            }
            else
            {
               this.DescListNew[_loc1_] = this.FDescList[_loc1_];
            }
            _loc1_++;
         }
      }
   }
}

