package Logics.Exercise.GroupBuying
{
   import Foundation.Resources.SResourcesCore;
   import Logics.DatebaseVO.VO.TActivityDesc;
   import Logics.Exercise.TBaseActivity;
   import Resources.Constants.CONST_DATEBASEVO;
   
   public class TGroupBuying extends TBaseActivity
   {
      
      public static const MAX_BOX:int = 4;
      
      public static const TYPE_ITEM:int = 1;
      
      public static const TYPE_BOX:int = 2;
      
      public static const TYPE_HERO:int = 3;
      
      public static const NO_REPORTED:int = 0;
      
      public static const IS_REPORTED:int = 1;
      
      public static const NO_BUY:int = 0;
      
      public static const IS_BOUGHT:int = 1;
      
      protected var FNextTime:int;
      
      protected var FActiveDesc2:String;
      
      protected var FSaleType:int;
      
      protected var FOrigPrice:int;
      
      protected var FIsReported:int;
      
      protected var FCurPeople:int;
      
      protected var FReportLimitGold:int;
      
      protected var FMaxPeople:int;
      
      protected var FMinPeople:int;
      
      protected var FDropGold:int;
      
      protected var FMinPrice:int;
      
      protected var FIsBuy:int;
      
      protected var FBuyPeople:int;
      
      protected var FBuyEndTime:int;
      
      protected var FColorIdx:Vector.<int>;
      
      protected var FHeroID:uint;
      
      public function TGroupBuying()
      {
         super();
         this.FColorIdx = new Vector.<int>();
      }
      
      public function get SaleType() : int
      {
         return this.FSaleType;
      }
      
      public function set SaleType(param1:int) : void
      {
         this.FSaleType = param1;
      }
      
      public function get IsReported() : int
      {
         return this.FIsReported;
      }
      
      public function set IsReported(param1:int) : void
      {
         this.FIsReported = param1;
      }
      
      public function get ActiveDesc2() : String
      {
         return this.FActiveDesc2;
      }
      
      public function set ActiveDesc2(param1:String) : void
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
               this.FActiveDesc2 = _loc3_;
            }
         }
         else
         {
            this.FActiveDesc2 = param1;
         }
      }
      
      public function get CurPeople() : int
      {
         return this.FCurPeople;
      }
      
      public function set CurPeople(param1:int) : void
      {
         this.FCurPeople = param1;
      }
      
      public function get NextTime() : int
      {
         return this.FNextTime;
      }
      
      public function set NextTime(param1:int) : void
      {
         this.FNextTime = param1;
      }
      
      public function get OrigPrice() : int
      {
         return this.FOrigPrice;
      }
      
      public function set OrigPrice(param1:int) : void
      {
         this.FOrigPrice = param1;
      }
      
      public function get ReportLimitGold() : int
      {
         return this.FReportLimitGold;
      }
      
      public function set ReportLimitGold(param1:int) : void
      {
         this.FReportLimitGold = param1;
      }
      
      public function get MaxPeople() : int
      {
         return this.FMaxPeople;
      }
      
      public function set MaxPeople(param1:int) : void
      {
         this.FMaxPeople = param1;
      }
      
      public function get MinPeople() : int
      {
         return this.FMinPeople;
      }
      
      public function set MinPeople(param1:int) : void
      {
         this.FMinPeople = param1;
      }
      
      public function get DropGold() : int
      {
         return this.FDropGold;
      }
      
      public function set DropGold(param1:int) : void
      {
         this.FDropGold = param1;
      }
      
      public function get MinPrice() : int
      {
         return this.FMinPrice;
      }
      
      public function set MinPrice(param1:int) : void
      {
         this.FMinPrice = param1;
      }
      
      public function get ColorIdx() : Vector.<int>
      {
         return this.FColorIdx;
      }
      
      public function set ColorIdx(param1:Vector.<int>) : void
      {
         this.FColorIdx = param1;
      }
      
      public function get HeroID() : uint
      {
         return this.FHeroID;
      }
      
      public function set HeroID(param1:uint) : void
      {
         this.FHeroID = param1;
      }
      
      public function get IsBuy() : int
      {
         return this.FIsBuy;
      }
      
      public function set IsBuy(param1:int) : void
      {
         this.FIsBuy = param1;
      }
      
      public function get BuyPeople() : int
      {
         return this.FBuyPeople;
      }
      
      public function set BuyPeople(param1:int) : void
      {
         this.FBuyPeople = param1;
      }
      
      public function GetNextLevelNeedPeople() : int
      {
         return this.FMinPeople - this.FCurPeople % this.FMinPeople;
      }
      
      public function get CurPrice() : int
      {
         var _loc1_:int = 0;
         _loc1_ = this.FOrigPrice - int(this.FCurPeople / this.FMinPeople) * this.FDropGold;
         if(_loc1_ <= this.FMinPrice)
         {
            _loc1_ = this.MinPrice;
         }
         return _loc1_;
      }
      
      public function get BuyEndTime() : int
      {
         return this.FBuyEndTime;
      }
      
      public function set BuyEndTime(param1:int) : void
      {
         this.FBuyEndTime = param1;
      }
   }
}

