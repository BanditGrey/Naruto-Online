package Logics.Exercise.NewLottery
{
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Lottery.TExchangeItem;
   import Logics.Lottery.TLotteryNews;
   
   public class TNewLottery extends TBaseActivity
   {
      
      public static const TAB_FREE:int = 0;
      
      public static const TAB_GOLD:int = 1;
      
      protected var FPoolGold:int;
      
      protected var FNextTime:int;
      
      protected var FCDTime:Number;
      
      protected var FFreeExp:int;
      
      protected var FGoldExp:int;
      
      protected var FScore:int;
      
      protected var FFreeOut:TBaseBox;
      
      protected var FFreeMiddle:TBaseBox;
      
      protected var FFreeInside:TBaseBox;
      
      protected var FGoldOut:TBaseBox;
      
      protected var FGoldMiddle:TBaseBox;
      
      protected var FGoldInside:TBaseBox;
      
      protected var FFreeBox:TBaseBox;
      
      protected var FGoldBox:TBaseBox;
      
      protected var FFreeBar:Vector.<int>;
      
      protected var FGoldBar:Vector.<int>;
      
      protected var FLuckyList:Vector.<Object>;
      
      protected var FHeroList:Vector.<uint>;
      
      protected var FNewsList:Vector.<TLotteryNews>;
      
      protected var FGetIndexList:Vector.<int>;
      
      protected var FExchangeItems:Vector.<TExchangeItem>;
      
      public function TNewLottery()
      {
         super();
         this.FFreeBar = new Vector.<int>();
         this.FGoldBar = new Vector.<int>();
         this.FLuckyList = new Vector.<Object>();
         this.FHeroList = new Vector.<uint>();
         this.FNewsList = new Vector.<TLotteryNews>();
         this.FGetIndexList = new Vector.<int>();
         this.FExchangeItems = new Vector.<TExchangeItem>();
      }
      
      public function get LuckyList() : Vector.<Object>
      {
         return this.FLuckyList;
      }
      
      public function set LuckyList(param1:Vector.<Object>) : void
      {
         this.FLuckyList = param1;
      }
      
      public function get PoolGold() : int
      {
         return this.FPoolGold;
      }
      
      public function set PoolGold(param1:int) : void
      {
         this.FPoolGold = param1;
      }
      
      public function get NextTime() : int
      {
         return this.FNextTime;
      }
      
      public function set NextTime(param1:int) : void
      {
         this.FNextTime = param1;
      }
      
      public function get CDTime() : Number
      {
         return this.FCDTime;
      }
      
      public function set CDTime(param1:Number) : void
      {
         this.FCDTime = param1;
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
      
      public function get FreeBar() : Vector.<int>
      {
         return this.FFreeBar;
      }
      
      public function set FreeBar(param1:Vector.<int>) : void
      {
         this.FFreeBar = param1;
      }
      
      public function get GoldBar() : Vector.<int>
      {
         return this.FGoldBar;
      }
      
      public function set GoldBar(param1:Vector.<int>) : void
      {
         this.FGoldBar = param1;
      }
      
      public function get FreeOut() : TBaseBox
      {
         return this.FFreeOut;
      }
      
      public function set FreeOut(param1:TBaseBox) : void
      {
         this.FFreeOut = param1;
      }
      
      public function get FreeMiddle() : TBaseBox
      {
         return this.FFreeMiddle;
      }
      
      public function set FreeMiddle(param1:TBaseBox) : void
      {
         this.FFreeMiddle = param1;
      }
      
      public function get FreeInside() : TBaseBox
      {
         return this.FFreeInside;
      }
      
      public function set FreeInside(param1:TBaseBox) : void
      {
         this.FFreeInside = param1;
      }
      
      public function get GoldOut() : TBaseBox
      {
         return this.FGoldOut;
      }
      
      public function set GoldOut(param1:TBaseBox) : void
      {
         this.FGoldOut = param1;
      }
      
      public function get GoldMiddle() : TBaseBox
      {
         return this.FGoldMiddle;
      }
      
      public function set GoldMiddle(param1:TBaseBox) : void
      {
         this.FGoldMiddle = param1;
      }
      
      public function get GoldInside() : TBaseBox
      {
         return this.FGoldInside;
      }
      
      public function set GoldInside(param1:TBaseBox) : void
      {
         this.FGoldInside = param1;
      }
      
      public function get HeroList() : Vector.<uint>
      {
         return this.FHeroList;
      }
      
      public function set HeroList(param1:Vector.<uint>) : void
      {
         this.FHeroList = param1;
      }
      
      public function get NewsList() : Vector.<TLotteryNews>
      {
         return this.FNewsList;
      }
      
      public function set NewsList(param1:Vector.<TLotteryNews>) : void
      {
         this.FNewsList = param1;
      }
      
      public function get Score() : int
      {
         return this.FScore;
      }
      
      public function set Score(param1:int) : void
      {
         this.FScore = param1;
      }
      
      public function get FreeBox() : TBaseBox
      {
         return this.FFreeBox;
      }
      
      public function set FreeBox(param1:TBaseBox) : void
      {
         this.FFreeBox = param1;
      }
      
      public function get GoldBox() : TBaseBox
      {
         return this.FGoldBox;
      }
      
      public function set GoldBox(param1:TBaseBox) : void
      {
         this.FGoldBox = param1;
      }
      
      public function get GetIndexList() : Vector.<int>
      {
         return this.FGetIndexList;
      }
      
      public function set GetIndexList(param1:Vector.<int>) : void
      {
         this.FGetIndexList = param1;
      }
      
      public function get ExchangeItems() : Vector.<TExchangeItem>
      {
         return this.FExchangeItems;
      }
      
      public function set ExchangeItems(param1:Vector.<TExchangeItem>) : void
      {
         this.FExchangeItems = param1;
      }
      
      public function GetCurRound(param1:int) : int
      {
         var _loc2_:* = 0;
         var _loc3_:int = 0;
         if(param1 != TAB_FREE)
         {
            _loc3_ = int(this.FGoldBar.length);
            _loc2_ = int(_loc3_ - 1);
            while(true)
            {
               if(_loc2_ >= 0)
               {
                  if(this.FGoldExp >= this.FGoldBar[_loc2_])
                  {
                     break;
                  }
                  _loc2_--;
                  continue;
               }
            }
            return _loc2_ + 1;
         }
         _loc3_ = int(this.FFreeBar.length);
         _loc2_ = int(_loc3_ - 1);
         while(_loc2_ >= 0)
         {
            if(this.FFreeExp >= this.FFreeBar[_loc2_])
            {
               return _loc2_ + 1;
            }
            _loc2_--;
         }
         return 0;
      }
      
      public function GetCountByIndex(param1:int) : int
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < this.FGetIndexList.length)
         {
            if(param1 == this.FGetIndexList[_loc2_])
            {
               _loc3_++;
            }
            _loc2_++;
         }
         return _loc3_;
      }
   }
}

