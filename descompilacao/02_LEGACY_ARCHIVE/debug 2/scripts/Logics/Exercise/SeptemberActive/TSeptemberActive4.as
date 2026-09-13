package Logics.Exercise.SeptemberActive
{
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   
   public class TSeptemberActive4 extends TBaseActivity
   {
      
      protected var FCurScore:uint;
      
      protected var FFreeCount:int;
      
      protected var FBoxPrice:uint;
      
      protected var FTotalBoxPrice:uint;
      
      protected var FRechargeGold:int;
      
      protected var FRewards:Vector.<TInventories>;
      
      protected var FRewardsIndex:Vector.<uint>;
      
      protected var FItemAID:uint;
      
      protected var FHero:TBaseBox;
      
      protected var FGiftList:Vector.<TBaseBox>;
      
      protected var FHeroGold:Vector.<int>;
      
      protected var FGiftGold:Vector.<int>;
      
      protected var FHeroScore:Vector.<int>;
      
      protected var FGiftScore:Vector.<int>;
      
      public function TSeptemberActive4()
      {
         super();
         this.FRewards = new Vector.<TInventories>();
         this.FRewardsIndex = new Vector.<uint>();
         this.FGiftList = new Vector.<TBaseBox>();
         this.FHeroGold = new Vector.<int>();
         this.FGiftGold = new Vector.<int>();
         this.FHeroScore = new Vector.<int>();
         this.FGiftScore = new Vector.<int>();
      }
      
      public function get RewardsIndex() : Vector.<uint>
      {
         return this.FRewardsIndex;
      }
      
      public function set RewardsIndex(param1:Vector.<uint>) : void
      {
         this.FRewardsIndex = param1;
      }
      
      public function get CurScore() : uint
      {
         return this.FCurScore;
      }
      
      public function set CurScore(param1:uint) : void
      {
         this.FCurScore = param1;
      }
      
      public function get BoxPrice() : uint
      {
         return this.FBoxPrice;
      }
      
      public function set BoxPrice(param1:uint) : void
      {
         this.FBoxPrice = param1;
      }
      
      public function get TotalBoxPrice() : uint
      {
         return this.FTotalBoxPrice;
      }
      
      public function set TotalBoxPrice(param1:uint) : void
      {
         this.FTotalBoxPrice = param1;
      }
      
      public function get Hero() : TBaseBox
      {
         return this.FHero;
      }
      
      public function set Hero(param1:TBaseBox) : void
      {
         this.FHero = param1;
      }
      
      public function get GiftList() : Vector.<TBaseBox>
      {
         return this.FGiftList;
      }
      
      public function set GiftList(param1:Vector.<TBaseBox>) : void
      {
         this.FGiftList = param1;
      }
      
      public function get HeroGold() : Vector.<int>
      {
         return this.FHeroGold;
      }
      
      public function set HeroGold(param1:Vector.<int>) : void
      {
         this.FHeroGold = param1;
      }
      
      public function get GiftGold() : Vector.<int>
      {
         return this.FGiftGold;
      }
      
      public function set GiftGold(param1:Vector.<int>) : void
      {
         this.FGiftGold = param1;
      }
      
      public function get HeroScore() : Vector.<int>
      {
         return this.FHeroScore;
      }
      
      public function set HeroScore(param1:Vector.<int>) : void
      {
         this.FHeroScore = param1;
      }
      
      public function get GiftScore() : Vector.<int>
      {
         return this.FGiftScore;
      }
      
      public function set GiftScore(param1:Vector.<int>) : void
      {
         this.FGiftScore = param1;
      }
      
      public function get FreeCount() : int
      {
         return this.FFreeCount;
      }
      
      public function set FreeCount(param1:int) : void
      {
         this.FFreeCount = param1;
      }
      
      public function get Rewards() : Vector.<TInventories>
      {
         return this.FRewards;
      }
      
      public function set Rewards(param1:Vector.<TInventories>) : void
      {
         this.FRewards = param1;
      }
      
      public function get RechargeGold() : int
      {
         return this.FRechargeGold;
      }
      
      public function set RechargeGold(param1:int) : void
      {
         this.FRechargeGold = param1;
      }
      
      public function get ItemAID() : uint
      {
         return this.FItemAID;
      }
      
      public function set ItemAID(param1:uint) : void
      {
         this.FItemAID = param1;
      }
      
      public function GetNotOpenCount() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < this.FRewardsIndex.length)
         {
            if(this.FRewardsIndex[_loc1_] == 0)
            {
               _loc2_++;
            }
            _loc1_++;
         }
         return _loc2_;
      }
      
      public function GetCurHeroPrice() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc3_ = int(this.FHeroGold.length);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            if(this.FRechargeGold >= this.FHeroGold[_loc3_ - _loc2_ - 1])
            {
               return int(this.FHero.Price - this.FHeroScore[_loc3_ - _loc2_ - 1]);
            }
            _loc2_++;
         }
         return this.FHero.Price;
      }
      
      public function GetCurItemPriceByIndex(param1:int) : int
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _loc4_ = int(this.FGiftGold.length);
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            if(this.FRechargeGold >= this.FGiftGold[_loc4_ - _loc3_ - 1])
            {
               return int(this.FGiftList[param1].Price - this.FGiftScore[_loc4_ - _loc3_ - 1]);
            }
            _loc3_++;
         }
         return this.FGiftList[param1].Price;
      }
      
      public function GetCurHeroLevel() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc2_ = int(this.FHeroGold.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(this.FRechargeGold >= this.FHeroGold[_loc2_ - _loc1_ - 1])
            {
               return _loc2_ - _loc1_ - 1;
            }
            _loc1_++;
         }
         return -1;
      }
      
      public function GetCurGiftLevelByIndex() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc2_ = int(this.FGiftGold.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(this.FRechargeGold >= this.FGiftGold[_loc2_ - _loc1_ - 1])
            {
               return _loc2_ - _loc1_ - 1;
            }
            _loc1_++;
         }
         return -1;
      }
      
      public function ChangeStatus() : void
      {
         if(this.FRechargeGold > this.GetCurHeroPrice() && this.FHero.Status != TBaseActivity.STATUS_GETED)
         {
            this.FHero.Status = TBaseActivity.STATUS_CANGET;
         }
      }
   }
}

