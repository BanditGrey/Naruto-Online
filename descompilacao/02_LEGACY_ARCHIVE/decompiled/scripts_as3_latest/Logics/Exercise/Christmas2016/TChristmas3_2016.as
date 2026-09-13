package Logics.Exercise.Christmas2016
{
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   
   public class TChristmas3_2016 extends TBaseActivity
   {
      
      public var Score:int;
      
      public var Count:int;
      
      public var Price:uint;
      
      public var TenPrice:uint;
      
      public var PoolValue:int;
      
      public var PoolMax:int;
      
      public var SweetList:Vector.<TBaseBox>;
      
      public var Gift:TBaseBox;
      
      public var Hero:TBaseBox;
      
      public var Pet:TBaseBox;
      
      public var ItemList:Vector.<TBaseBox>;
      
      public var HeroGold:Vector.<int>;
      
      public var HeroScore:Vector.<int>;
      
      public var ItemGold:Vector.<int>;
      
      public var ItemScore:Vector.<int>;
      
      public var PetGold:Vector.<int>;
      
      public var PetScore:Vector.<int>;
      
      public var StatusList:Vector.<int>;
      
      public var IndexList:Vector.<int>;
      
      public var AmountList:Vector.<int>;
      
      public var AmountList2:Vector.<int>;
      
      public function TChristmas3_2016()
      {
         super();
         this.SweetList = new Vector.<TBaseBox>();
         this.ItemList = new Vector.<TBaseBox>();
         this.HeroGold = new Vector.<int>();
         this.HeroScore = new Vector.<int>();
         this.ItemGold = new Vector.<int>();
         this.ItemScore = new Vector.<int>();
         this.PetGold = new Vector.<int>();
         this.PetScore = new Vector.<int>();
         this.StatusList = new Vector.<int>();
         this.IndexList = new Vector.<int>();
         this.AmountList = new Vector.<int>();
         this.AmountList2 = new Vector.<int>();
      }
      
      public function ChangeStatus() : void
      {
      }
      
      public function GetCurHeroPrice() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc3_ = int(this.HeroGold.length);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            if(TotalRechargeGold >= this.HeroGold[_loc3_ - _loc2_ - 1])
            {
               return int(this.Hero.Price - this.HeroScore[_loc3_ - _loc2_ - 1]);
            }
            _loc2_++;
         }
         return this.Hero.Price;
      }
      
      public function GetCurHeroLevel() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc2_ = int(this.HeroGold.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(TotalRechargeGold >= this.HeroGold[_loc2_ - _loc1_ - 1])
            {
               return _loc2_ - _loc1_ - 1;
            }
            _loc1_++;
         }
         return -1;
      }
      
      public function GetCurPetPrice() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc3_ = int(this.PetGold.length);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            if(TotalRechargeGold >= this.PetGold[_loc3_ - _loc2_ - 1])
            {
               return int(this.Pet.Price - this.PetScore[_loc3_ - _loc2_ - 1]);
            }
            _loc2_++;
         }
         return this.Pet.Price;
      }
      
      public function GetCurPetLevel() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc2_ = int(this.PetGold.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(TotalRechargeGold >= this.PetGold[_loc2_ - _loc1_ - 1])
            {
               return _loc2_ - _loc1_ - 1;
            }
            _loc1_++;
         }
         return -1;
      }
      
      public function GetCurItemPriceByIndex(param1:int) : int
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _loc4_ = int(this.ItemGold.length);
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            if(TotalRechargeGold >= this.ItemGold[_loc4_ - _loc3_ - 1])
            {
               return int(this.ItemList[param1].Price - this.ItemScore[_loc4_ - _loc3_ - 1]);
            }
            _loc3_++;
         }
         return this.ItemList[param1].Price;
      }
      
      public function GetCurGiftLevelByIndex() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc2_ = int(this.ItemGold.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(TotalRechargeGold >= this.ItemGold[_loc2_ - _loc1_ - 1])
            {
               return _loc2_ - _loc1_ - 1;
            }
            _loc1_++;
         }
         return -1;
      }
   }
}

