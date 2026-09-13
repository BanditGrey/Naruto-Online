package Logics.Exercise.ThanksgivingDay
{
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   
   public class TThanksgivingDay4 extends TBaseActivity
   {
      
      public static const CARD_COUNT:int = 40;
      
      protected var FFreeCount:int;
      
      protected var FBoxScore:int;
      
      protected var FCardList:Vector.<int>;
      
      protected var FAgainPrice:int;
      
      protected var FCardPrice:int;
      
      protected var FAllOpenPrice:int;
      
      protected var FBoxList:Vector.<TBaseBox>;
      
      protected var FHero:TBaseBox;
      
      protected var FCard2List:Vector.<int>;
      
      public var EquipList:TInventories;
      
      public function TThanksgivingDay4()
      {
         super();
         this.FCardList = new Vector.<int>();
         this.FBoxList = new Vector.<TBaseBox>();
         this.FCard2List = new Vector.<int>(CARD_COUNT);
      }
      
      public function get BoxScore() : int
      {
         return this.FBoxScore;
      }
      
      public function set BoxScore(param1:int) : void
      {
         this.FBoxScore = param1;
      }
      
      public function get FreeCount() : int
      {
         return this.FFreeCount;
      }
      
      public function set FreeCount(param1:int) : void
      {
         this.FFreeCount = param1;
      }
      
      public function get CardList() : Vector.<int>
      {
         return this.FCardList;
      }
      
      public function set CardList(param1:Vector.<int>) : void
      {
         this.FCardList = param1;
      }
      
      public function get AgainPrice() : int
      {
         return this.FAgainPrice;
      }
      
      public function set AgainPrice(param1:int) : void
      {
         this.FAgainPrice = param1;
      }
      
      public function get CardPrice() : int
      {
         return this.FCardPrice;
      }
      
      public function set CardPrice(param1:int) : void
      {
         this.FCardPrice = param1;
      }
      
      public function get BoxList() : Vector.<TBaseBox>
      {
         return this.FBoxList;
      }
      
      public function set BoxList(param1:Vector.<TBaseBox>) : void
      {
         this.FBoxList = param1;
      }
      
      public function get Hero() : TBaseBox
      {
         return this.FHero;
      }
      
      public function set Hero(param1:TBaseBox) : void
      {
         this.FHero = param1;
      }
      
      public function get Card2List() : Vector.<int>
      {
         return this.FCard2List;
      }
      
      public function set Card2List(param1:Vector.<int>) : void
      {
         this.FCard2List = param1;
      }
      
      public function get AllOpenPrice() : int
      {
         return this.FAllOpenPrice;
      }
      
      public function set AllOpenPrice(param1:int) : void
      {
         this.FAllOpenPrice = param1;
      }
      
      public function ChangeStatus() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc2_ = int(this.FBoxList.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(this.FBoxList[_loc1_].Status == TBaseActivity.STATUS_CANNOTGET && this.FBoxScore >= this.FBoxList[_loc1_].Price)
            {
               this.FBoxList[_loc1_].Status = TBaseActivity.STATUS_CANGET;
            }
            _loc1_++;
         }
      }
      
      public function get OpenAllCount() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < this.FCardList.length)
         {
            if(this.FCardList[_loc1_] == 0)
            {
               _loc2_++;
            }
            _loc1_++;
         }
         return _loc2_ - this.FFreeCount;
      }
      
      public function get NextAwardDiff() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TBaseBox = null;
         var _loc4_:int = 0;
         _loc2_ = int(this.FBoxList.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FBoxList[_loc1_];
            if(_loc3_.Status == TBaseActivity.STATUS_CANNOTGET)
            {
               return int(_loc3_.Price - this.FBoxScore);
            }
            _loc1_++;
         }
         return 0;
      }
      
      public function IsBoxAllGet() : Boolean
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TBaseBox = null;
         _loc2_ = int(this.FBoxList.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FBoxList[_loc1_];
            if(_loc3_.Status == TBaseActivity.STATUS_CANGET)
            {
               return false;
            }
            _loc1_++;
         }
         return true;
      }
   }
}

