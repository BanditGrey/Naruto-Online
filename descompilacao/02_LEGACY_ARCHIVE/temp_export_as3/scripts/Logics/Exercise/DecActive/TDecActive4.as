package Logics.Exercise.DecActive
{
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   
   public class TDecActive4 extends TBaseActivity
   {
      
      protected var FEggList:Vector.<TBaseBox>;
      
      protected var FEggIndex:Vector.<int>;
      
      protected var FEggStatus:Vector.<int>;
      
      protected var FPrice:int;
      
      protected var FCount:int;
      
      protected var FAutoPrice:int;
      
      protected var FHalfCount:int;
      
      protected var FResetPrice:int;
      
      protected var FScoreA:int;
      
      protected var FScoreB:int;
      
      protected var FBoxList:Vector.<TBaseBox>;
      
      protected var FHero:TBaseBox;
      
      protected var FExchangeItems:Vector.<TBaseBox>;
      
      protected var FRechargeGold:int;
      
      protected var FNeedGold:int;
      
      protected var FCurIndex:int;
      
      public function TDecActive4()
      {
         super();
         this.FEggList = new Vector.<TBaseBox>();
         this.FEggIndex = new Vector.<int>();
         this.FEggStatus = new Vector.<int>();
         this.FBoxList = new Vector.<TBaseBox>();
         this.FExchangeItems = new Vector.<TBaseBox>();
      }
      
      public function get EggList() : Vector.<TBaseBox>
      {
         return this.FEggList;
      }
      
      public function set EggList(param1:Vector.<TBaseBox>) : void
      {
         this.FEggList = param1;
      }
      
      public function get EggIndex() : Vector.<int>
      {
         return this.FEggIndex;
      }
      
      public function set EggIndex(param1:Vector.<int>) : void
      {
         this.FEggIndex = param1;
      }
      
      public function get Price() : int
      {
         return this.FPrice;
      }
      
      public function set Price(param1:int) : void
      {
         this.FPrice = param1;
      }
      
      public function get AutoPrice() : int
      {
         return this.FAutoPrice;
      }
      
      public function set AutoPrice(param1:int) : void
      {
         this.FAutoPrice = param1;
      }
      
      public function get HalfCount() : int
      {
         return this.FHalfCount;
      }
      
      public function set HalfCount(param1:int) : void
      {
         this.FHalfCount = param1;
      }
      
      public function get ScoreA() : int
      {
         return this.FScoreA;
      }
      
      public function set ScoreA(param1:int) : void
      {
         this.FScoreA = param1;
      }
      
      public function get ScoreB() : int
      {
         return this.FScoreB;
      }
      
      public function set ScoreB(param1:int) : void
      {
         this.FScoreB = param1;
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
      
      public function get ExchangeItems() : Vector.<TBaseBox>
      {
         return this.FExchangeItems;
      }
      
      public function set ExchangeItems(param1:Vector.<TBaseBox>) : void
      {
         this.FExchangeItems = param1;
      }
      
      public function get ResetPrice() : int
      {
         return this.FResetPrice;
      }
      
      public function set ResetPrice(param1:int) : void
      {
         this.FResetPrice = param1;
      }
      
      public function get Count() : int
      {
         return this.FCount;
      }
      
      public function set Count(param1:int) : void
      {
         this.FCount = param1;
      }
      
      public function get EggStatus() : Vector.<int>
      {
         return this.FEggStatus;
      }
      
      public function set EggStatus(param1:Vector.<int>) : void
      {
         this.FEggStatus = param1;
      }
      
      public function get RechargeGold() : int
      {
         return this.FRechargeGold;
      }
      
      public function set RechargeGold(param1:int) : void
      {
         this.FRechargeGold = param1;
      }
      
      public function get NeedGold() : int
      {
         return this.FNeedGold;
      }
      
      public function set NeedGold(param1:int) : void
      {
         this.FNeedGold = param1;
      }
      
      public function get CurIndex() : int
      {
         return this.FCurIndex;
      }
      
      public function set CurIndex(param1:int) : void
      {
         this.FCurIndex = param1;
      }
      
      public function ChangeStatus() : void
      {
         if(this.FHero.Status != TBaseActivity.STATUS_GETED && this.FScoreB >= this.FHero.Price)
         {
            this.FHero.Status = TBaseActivity.STATUS_CANGET;
         }
      }
   }
}

