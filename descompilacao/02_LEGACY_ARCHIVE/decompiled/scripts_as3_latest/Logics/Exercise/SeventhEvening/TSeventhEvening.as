package Logics.Exercise.SeventhEvening
{
   import Foundation.Resources.SResourcesCore;
   import Logics.DatebaseVO.VO.TActivityDesc;
   import Logics.Exercise.ConsumeRank.TConsumeRankInfo;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.Lottery.TExchangeItem;
   import Resources.Constants.CONST_DATEBASEVO;
   
   public class TSeventhEvening extends TBaseActivity
   {
      
      public static const BOX_COUNT:int = 2;
      
      public static const PERSON_COUNT:int = 3;
      
      public static const BALLON_COUNT:int = 4;
      
      protected var FPerHeartScore:int;
      
      protected var FTotalHeartScore:int;
      
      protected var FMaxTotalHeartScore:int;
      
      protected var FSeventhEveningRewardStatus:int;
      
      protected var FFreeCount:int;
      
      protected var FFreeMaxCount:int;
      
      protected var FMagpie:int;
      
      protected var FHeartRewardName:Vector.<String>;
      
      protected var FFreeHeartRewardName:Vector.<String>;
      
      protected var FHeartReward:TInventories;
      
      protected var FFreeHeartReward:TInventories;
      
      protected var FBallonList:Vector.<TSeventhEveningBallon>;
      
      protected var FExchangeItemList:Vector.<TExchangeItem>;
      
      protected var FExchangeInventories:TInventories;
      
      protected var FRankList:Vector.<TConsumeRankInfo>;
      
      protected var FSeventhEveningBox:TInventory;
      
      protected var FRankInventories:TInventories;
      
      protected var FNeedRankConfig:Boolean;
      
      protected var FNeedExchangeConfig:Boolean;
      
      protected var FHero:TBaseBox;
      
      protected var FTitleList:Vector.<uint>;
      
      public var HeartRewardNameNew:Vector.<String>;
      
      public var FreeHeartRewardNameNew:Vector.<String>;
      
      public function TSeventhEvening()
      {
         super();
         this.FBallonList = new Vector.<TSeventhEveningBallon>(BALLON_COUNT);
         this.FHeartRewardName = new Vector.<String>(PERSON_COUNT);
         this.FFreeHeartRewardName = new Vector.<String>(PERSON_COUNT);
         this.FExchangeItemList = new Vector.<TExchangeItem>();
         this.FRankList = new Vector.<TConsumeRankInfo>();
         this.FTitleList = new Vector.<uint>();
         this.HeartRewardNameNew = new Vector.<String>();
         this.FreeHeartRewardNameNew = new Vector.<String>();
         this.FNeedExchangeConfig = true;
         this.FNeedRankConfig = true;
      }
      
      public function get PerHeartScore() : int
      {
         return this.FPerHeartScore;
      }
      
      public function set PerHeartScore(param1:int) : void
      {
         this.FPerHeartScore = param1;
      }
      
      public function get TotalHeartScore() : int
      {
         return this.FTotalHeartScore;
      }
      
      public function set TotalHeartScore(param1:int) : void
      {
         this.FTotalHeartScore = param1;
      }
      
      public function get HeartReward() : TInventories
      {
         return this.FHeartReward;
      }
      
      public function set HeartReward(param1:TInventories) : void
      {
         this.FHeartReward = param1;
      }
      
      public function get FreeHeartReward() : TInventories
      {
         return this.FFreeHeartReward;
      }
      
      public function set FreeHeartReward(param1:TInventories) : void
      {
         this.FFreeHeartReward = param1;
      }
      
      public function get HeartRewardName() : Vector.<String>
      {
         return this.FHeartRewardName;
      }
      
      public function set HeartRewardName(param1:Vector.<String>) : void
      {
         this.FHeartRewardName = param1;
      }
      
      public function get FreeHeartRewardName() : Vector.<String>
      {
         return this.FFreeHeartRewardName;
      }
      
      public function set FreeHeartRewardName(param1:Vector.<String>) : void
      {
         this.FFreeHeartRewardName = param1;
      }
      
      public function get FreeCount() : int
      {
         return this.FFreeCount;
      }
      
      public function set FreeCount(param1:int) : void
      {
         this.FFreeCount = param1;
      }
      
      public function get FreeMaxCount() : int
      {
         return this.FFreeMaxCount;
      }
      
      public function set FreeMaxCount(param1:int) : void
      {
         this.FFreeMaxCount = param1;
      }
      
      public function get ExchangeItemList() : Vector.<TExchangeItem>
      {
         return this.FExchangeItemList;
      }
      
      public function set ExchangeItemList(param1:Vector.<TExchangeItem>) : void
      {
         this.FExchangeItemList = param1;
      }
      
      public function get RankList() : Vector.<TConsumeRankInfo>
      {
         return this.FRankList;
      }
      
      public function set RankList(param1:Vector.<TConsumeRankInfo>) : void
      {
         this.FRankList = param1;
      }
      
      public function get BallonList() : Vector.<TSeventhEveningBallon>
      {
         return this.FBallonList;
      }
      
      public function set BallonList(param1:Vector.<TSeventhEveningBallon>) : void
      {
         this.FBallonList = param1;
      }
      
      public function get ExchangeInventories() : TInventories
      {
         return this.FExchangeInventories;
      }
      
      public function set ExchangeInventories(param1:TInventories) : void
      {
         this.FExchangeInventories = param1;
      }
      
      public function get MaxTotalHeartScore() : int
      {
         return this.FMaxTotalHeartScore;
      }
      
      public function set MaxTotalHeartScore(param1:int) : void
      {
         this.FMaxTotalHeartScore = param1;
      }
      
      public function get SeventhEveningRewardStatus() : int
      {
         return this.FSeventhEveningRewardStatus;
      }
      
      public function set SeventhEveningRewardStatus(param1:int) : void
      {
         this.FSeventhEveningRewardStatus = param1;
      }
      
      public function get Magpie() : int
      {
         return this.FMagpie;
      }
      
      public function set Magpie(param1:int) : void
      {
         this.FMagpie = param1;
      }
      
      public function get NeedExchangeConfig() : Boolean
      {
         return this.FNeedExchangeConfig;
      }
      
      public function set NeedExchangeConfig(param1:Boolean) : void
      {
         this.FNeedExchangeConfig = param1;
      }
      
      public function get SeventhEveningBox() : TInventory
      {
         return this.FSeventhEveningBox;
      }
      
      public function set SeventhEveningBox(param1:TInventory) : void
      {
         this.FSeventhEveningBox = param1;
      }
      
      public function get RankInventories() : TInventories
      {
         return this.FRankInventories;
      }
      
      public function set RankInventories(param1:TInventories) : void
      {
         this.FRankInventories = param1;
      }
      
      public function get NeedRankConfig() : Boolean
      {
         return this.FNeedRankConfig;
      }
      
      public function set NeedRankConfig(param1:Boolean) : void
      {
         this.FNeedRankConfig = param1;
      }
      
      public function get Hero() : TBaseBox
      {
         return this.FHero;
      }
      
      public function set Hero(param1:TBaseBox) : void
      {
         this.FHero = param1;
      }
      
      public function get TitleList() : Vector.<uint>
      {
         return this.FTitleList;
      }
      
      public function set TitleList(param1:Vector.<uint>) : void
      {
         this.FTitleList = param1;
      }
      
      public function InitNameNew() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:TActivityDesc = null;
         _loc1_ = 0;
         while(_loc1_ < this.HeartRewardNameNew.length)
         {
            _loc2_ = int(parseInt(this.HeartRewardNameNew[_loc1_]));
            if(TBaseActivity.IsRealNumber(this.HeartRewardNameNew[_loc1_]) && !isNaN(_loc2_) && _loc2_ > 0)
            {
               _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ActivityDesc,_loc2_) as TActivityDesc;
               if(_loc4_)
               {
                  _loc3_ = _loc4_.Desc;
                  _loc3_ = _loc3_.split("&lt;").join("<");
                  _loc3_ = _loc3_.split("&gt;").join(">");
                  this.FHeartRewardName[_loc1_] = _loc3_;
               }
               else
               {
                  this.FHeartRewardName[_loc1_] = this.HeartRewardNameNew[_loc1_];
               }
            }
            else
            {
               this.FHeartRewardName[_loc1_] = this.HeartRewardNameNew[_loc1_];
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this.FreeHeartRewardNameNew.length)
         {
            _loc2_ = int(parseInt(this.FreeHeartRewardNameNew[_loc1_]));
            if(TBaseActivity.IsRealNumber(this.FreeHeartRewardNameNew[_loc1_]) && !isNaN(_loc2_) && _loc2_ > 0)
            {
               _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ActivityDesc,_loc2_) as TActivityDesc;
               if(_loc4_)
               {
                  _loc3_ = _loc4_.Desc;
                  _loc3_ = _loc3_.split("&lt;").join("<");
                  _loc3_ = _loc3_.split("&gt;").join(">");
                  this.FHeartRewardName[_loc1_] = _loc3_;
               }
               else
               {
                  this.FHeartRewardName[_loc1_] = this.FreeHeartRewardNameNew[_loc1_];
               }
            }
            else
            {
               this.FHeartRewardName[_loc1_] = this.FreeHeartRewardNameNew[_loc1_];
            }
            _loc1_++;
         }
      }
   }
}

