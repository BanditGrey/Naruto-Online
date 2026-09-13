package Logics.Lottery
{
   import Foundation.Resources.SResourcesCore;
   import Logics.DatebaseVO.VO.TActivityDesc;
   import Logics.Exercise.TBaseActivity;
   import Logics.Inventories.TInventory;
   import Resources.Constants.CONST_DATEBASEVO;
   
   public class TLottery
   {
      
      public static const TYPE_FREE_OUTSIDE:int = 0;
      
      public static const TYPE_FREE_INSIDE:int = 1;
      
      public static const TYPE_GOLD_OUTSIDE:int = 2;
      
      public static const TYPE_GOLD_INSIDE:int = 3;
      
      public static const TYPE_LOTTERY:int = 1;
      
      public static const TYPE_EXCHANGE:int = 2;
      
      protected var FFreeExp:int;
      
      protected var FGoldExp:int;
      
      protected var FPoint:int;
      
      protected var FNextTime:int;
      
      protected var FStage:int;
      
      protected var FBeginTime:int;
      
      protected var FEndTime:int;
      
      protected var FVipLv:int;
      
      protected var FActivityName:String;
      
      protected var FActivityDesc:String;
      
      protected var FOnePrice:int;
      
      protected var FTenPrice:int;
      
      protected var FFiftyPrice:int;
      
      protected var FCDTime:Number;
      
      protected var FGetPoint:int;
      
      protected var FGetProgess:int;
      
      protected var FCostProgress:int;
      
      protected var FLotteryItems:Vector.<TLotteryItem>;
      
      protected var FFreeOutsideItems:Vector.<TLotteryItem>;
      
      protected var FFreeInsideItems:Vector.<TLotteryItem>;
      
      protected var FGoldOutsideItems:Vector.<TLotteryItem>;
      
      protected var FGoldInsideItems:Vector.<TLotteryItem>;
      
      protected var FExchangeItems:Vector.<TExchangeItem>;
      
      protected var FLotteryNews:Vector.<TLotteryNews>;
      
      protected var FLotteryLog:Vector.<TLotteryNews>;
      
      protected var FLotteryEndTime:int;
      
      protected var FHeroList:Vector.<uint>;
      
      public function TLottery()
      {
         super();
         this.FLotteryItems = new Vector.<TLotteryItem>();
         this.FFreeOutsideItems = new Vector.<TLotteryItem>();
         this.FFreeInsideItems = new Vector.<TLotteryItem>();
         this.FGoldOutsideItems = new Vector.<TLotteryItem>();
         this.FGoldInsideItems = new Vector.<TLotteryItem>();
         this.FExchangeItems = new Vector.<TExchangeItem>();
         this.FLotteryLog = new Vector.<TLotteryNews>();
         this.FLotteryNews = new Vector.<TLotteryNews>();
         this.FHeroList = new Vector.<uint>();
      }
      
      public function get Point() : int
      {
         return this.FPoint;
      }
      
      public function set Point(param1:int) : void
      {
         this.FPoint = param1;
      }
      
      public function get FreeExp() : int
      {
         return this.FFreeExp;
      }
      
      public function set FreeExp(param1:int) : void
      {
         this.FFreeExp = param1;
      }
      
      public function get GoldExp() : int
      {
         return this.FGoldExp;
      }
      
      public function set GoldExp(param1:int) : void
      {
         this.FGoldExp = param1;
      }
      
      public function get CDTime() : Number
      {
         return this.FCDTime;
      }
      
      public function set CDTime(param1:Number) : void
      {
         this.FCDTime = param1;
      }
      
      public function get NextTime() : int
      {
         return this.FNextTime;
      }
      
      public function set NextTime(param1:int) : void
      {
         this.FNextTime = param1;
      }
      
      public function get Stage() : int
      {
         return this.FStage;
      }
      
      public function set Stage(param1:int) : void
      {
         this.FStage = param1;
      }
      
      public function get BeginTime() : int
      {
         return this.FBeginTime;
      }
      
      public function set BeginTime(param1:int) : void
      {
         this.FBeginTime = param1;
      }
      
      public function get EndTime() : int
      {
         return this.FEndTime;
      }
      
      public function set EndTime(param1:int) : void
      {
         this.FEndTime = param1;
      }
      
      public function get VipLv() : int
      {
         return this.FVipLv;
      }
      
      public function set VipLv(param1:int) : void
      {
         this.FVipLv = param1;
      }
      
      public function get ActivityName() : String
      {
         return this.FActivityName;
      }
      
      public function set ActivityName(param1:String) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:TActivityDesc = null;
         _loc2_ = int(parseInt(param1));
         if(TBaseActivity.IsRealNumber(param1) && !isNaN(_loc2_) && _loc2_ > 0)
         {
            _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ActivityDesc,_loc2_) as TActivityDesc;
            if(_loc4_)
            {
               _loc3_ = _loc4_.Desc;
               _loc3_ = _loc3_.split("&lt;").join("<");
               _loc3_ = _loc3_.split("&gt;").join(">");
               this.FActivityName = _loc3_;
            }
         }
         else
         {
            this.FActivityName = param1;
         }
      }
      
      public function get ActivityDesc() : String
      {
         return this.FActivityDesc;
      }
      
      public function set ActivityDesc(param1:String) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:TActivityDesc = null;
         _loc2_ = int(parseInt(param1));
         if(TBaseActivity.IsRealNumber(param1) && !isNaN(_loc2_) && _loc2_ > 0)
         {
            _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ActivityDesc,_loc2_) as TActivityDesc;
            if(_loc4_)
            {
               _loc3_ = _loc4_.Desc;
               _loc3_ = _loc3_.split("&lt;").join("<");
               _loc3_ = _loc3_.split("&gt;").join(">");
               this.FActivityDesc = _loc3_;
            }
         }
         else
         {
            this.FActivityDesc = param1;
         }
      }
      
      public function get OnePrice() : int
      {
         return this.FOnePrice;
      }
      
      public function set OnePrice(param1:int) : void
      {
         this.FOnePrice = param1;
      }
      
      public function get TenPrice() : int
      {
         return this.FTenPrice;
      }
      
      public function set TenPrice(param1:int) : void
      {
         this.FTenPrice = param1;
      }
      
      public function get FiftyPrice() : int
      {
         return this.FFiftyPrice;
      }
      
      public function set FiftyPrice(param1:int) : void
      {
         this.FFiftyPrice = param1;
      }
      
      public function get GetPoint() : int
      {
         return this.FGetPoint;
      }
      
      public function set GetPoint(param1:int) : void
      {
         this.FGetPoint = param1;
      }
      
      public function get GetProgess() : int
      {
         return this.FGetProgess;
      }
      
      public function set GetProgess(param1:int) : void
      {
         this.FGetProgess = param1;
      }
      
      public function get CostProgress() : int
      {
         return this.FCostProgress;
      }
      
      public function set CostProgress(param1:int) : void
      {
         this.FCostProgress = param1;
      }
      
      public function get ExchangeItems() : Vector.<TExchangeItem>
      {
         return this.FExchangeItems;
      }
      
      public function set ExchangeItems(param1:Vector.<TExchangeItem>) : void
      {
         this.FExchangeItems = param1;
      }
      
      public function get FreeOutsideItems() : Vector.<TLotteryItem>
      {
         return this.FFreeOutsideItems;
      }
      
      public function set FreeOutsideItems(param1:Vector.<TLotteryItem>) : void
      {
         this.FFreeOutsideItems = param1;
      }
      
      public function get FreeInsideItems() : Vector.<TLotteryItem>
      {
         return this.FFreeInsideItems;
      }
      
      public function set FreeInsideItems(param1:Vector.<TLotteryItem>) : void
      {
         this.FFreeInsideItems = param1;
      }
      
      public function get GoldOutsideItems() : Vector.<TLotteryItem>
      {
         return this.FGoldOutsideItems;
      }
      
      public function set GoldOutsideItems(param1:Vector.<TLotteryItem>) : void
      {
         this.FGoldOutsideItems = param1;
      }
      
      public function get GoldInsideItems() : Vector.<TLotteryItem>
      {
         return this.FGoldInsideItems;
      }
      
      public function set GoldInsideItems(param1:Vector.<TLotteryItem>) : void
      {
         this.FGoldInsideItems = param1;
      }
      
      public function get LotteryItems() : Vector.<TLotteryItem>
      {
         return this.FLotteryItems;
      }
      
      public function set LotteryItems(param1:Vector.<TLotteryItem>) : void
      {
         this.FLotteryItems = param1;
      }
      
      public function get LotteryLog() : Vector.<TLotteryNews>
      {
         return this.FLotteryLog;
      }
      
      public function set LotteryLog(param1:Vector.<TLotteryNews>) : void
      {
         this.FLotteryLog = param1;
      }
      
      public function get LotteryNews() : Vector.<TLotteryNews>
      {
         return this.FLotteryNews;
      }
      
      public function set LotteryNews(param1:Vector.<TLotteryNews>) : void
      {
         this.FLotteryNews = param1;
      }
      
      public function get LotteryEndTime() : int
      {
         return this.FLotteryEndTime;
      }
      
      public function set LotteryEndTime(param1:int) : void
      {
         this.FLotteryEndTime = param1;
      }
      
      public function get HeroList() : Vector.<uint>
      {
         return this.FHeroList;
      }
      
      public function set HeroList(param1:Vector.<uint>) : void
      {
         this.FHeroList = param1;
      }
      
      public function getItemIndexByIdentify(param1:int, param2:int) : int
      {
         var _loc3_:int = 0;
         var _loc4_:Vector.<TLotteryItem> = null;
         var _loc5_:int = 0;
         switch(param1)
         {
            case TYPE_FREE_OUTSIDE:
               _loc4_ = this.FFreeOutsideItems;
               break;
            case TYPE_FREE_INSIDE:
               _loc4_ = this.FFreeInsideItems;
               break;
            case TYPE_GOLD_OUTSIDE:
               _loc4_ = this.FGoldOutsideItems;
               break;
            case TYPE_GOLD_INSIDE:
               _loc4_ = this.FGoldInsideItems;
         }
         _loc5_ = int(_loc4_.length);
         _loc3_ = 0;
         while(_loc3_ < _loc5_)
         {
            if(_loc4_[_loc3_].Identify == param2)
            {
               return _loc4_[_loc3_].SlotId - 1;
            }
            _loc3_++;
         }
         return -1;
      }
      
      public function getItemsIndexByIdentifies(param1:int, param2:Vector.<int>) : Vector.<int>
      {
         var _loc3_:Vector.<int> = null;
         var _loc4_:Vector.<TLotteryItem> = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc8_:int = 0;
         switch(param1)
         {
            case TYPE_FREE_OUTSIDE:
               _loc4_ = this.FFreeOutsideItems;
               break;
            case TYPE_FREE_INSIDE:
               _loc4_ = this.FFreeInsideItems;
               break;
            case TYPE_GOLD_OUTSIDE:
               _loc4_ = this.FGoldOutsideItems;
               break;
            case TYPE_GOLD_INSIDE:
               _loc4_ = this.FGoldInsideItems;
         }
         _loc5_ = int(param2.length);
         _loc6_ = int(_loc4_.length);
         _loc3_ = new Vector.<int>();
         var _loc7_:int = 0;
         while(_loc7_ < _loc5_)
         {
            _loc8_ = 0;
            while(_loc8_ < _loc6_)
            {
               if(_loc4_[_loc8_].Identify == param2[_loc7_])
               {
                  _loc3_.push(_loc4_[_loc8_].SlotId - 1);
                  break;
               }
               _loc8_++;
            }
            _loc7_++;
         }
         return _loc3_;
      }
      
      public function getInventoryByIdentify(param1:int, param2:int) : TInventory
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:TInventory = null;
         if(param1 != TYPE_LOTTERY)
         {
            _loc3_ = int(this.FExchangeItems.length);
            _loc4_ = 0;
            while(true)
            {
               if(_loc4_ < _loc3_)
               {
                  if(this.FExchangeItems[_loc4_].Identify == param2)
                  {
                     break;
                  }
                  _loc4_++;
                  continue;
               }
            }
            return this.FExchangeItems[_loc4_].Inventories.GetInventoryByIndex(0);
         }
         _loc3_ = int(this.FLotteryItems.length);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            if(this.FLotteryItems[_loc4_].Identify == param2)
            {
               return this.FLotteryItems[_loc4_].Inventories.GetInventoryByIndex(0);
            }
            _loc4_++;
         }
         return null;
      }
      
      public function getCostPointByIdentify(param1:int) : int
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TInventory = null;
         _loc2_ = int(this.FExchangeItems.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            if(this.FExchangeItems[_loc3_].Identify == param1)
            {
               return this.FExchangeItems[_loc3_].CostPoint;
            }
            _loc3_++;
         }
         return 0;
      }
   }
}

