package Logics.Exercise.DecActive
{
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   
   public class TDecActive3 extends TBaseActivity
   {
      
      protected var FMyScore:int;
      
      protected var FConsumeScore:int;
      
      protected var FRechargeGold:int;
      
      protected var FBarGold:int;
      
      protected var FScorePrice:int;
      
      protected var FGift:TBaseBox;
      
      protected var FRechargeAdd:Vector.<Object>;
      
      protected var FNeedScore:Vector.<TBaseBox>;
      
      protected var FShowItems:TInventories;
      
      protected var FEquipList:TInventories;
      
      protected var FTitleList:Vector.<uint>;
      
      protected var FBossIndex:int;
      
      protected var FBallIndex:int;
      
      public function TDecActive3()
      {
         super();
         this.FNeedScore = new Vector.<TBaseBox>();
         this.FRechargeAdd = new Vector.<Object>();
         this.FTitleList = new Vector.<uint>();
      }
      
      public function get ShowItems() : TInventories
      {
         return this.FShowItems;
      }
      
      public function set ShowItems(param1:TInventories) : void
      {
         this.FShowItems = param1;
      }
      
      public function get NeedScore() : Vector.<TBaseBox>
      {
         return this.FNeedScore;
      }
      
      public function set NeedScore(param1:Vector.<TBaseBox>) : void
      {
         this.FNeedScore = param1;
      }
      
      public function get Gift() : TBaseBox
      {
         return this.FGift;
      }
      
      public function set Gift(param1:TBaseBox) : void
      {
         this.FGift = param1;
      }
      
      public function get MyScore() : int
      {
         return this.FMyScore;
      }
      
      public function set MyScore(param1:int) : void
      {
         this.FMyScore = param1;
      }
      
      public function get RechargeAdd() : Vector.<Object>
      {
         return this.FRechargeAdd;
      }
      
      public function set RechargeAdd(param1:Vector.<Object>) : void
      {
         this.FRechargeAdd = param1;
      }
      
      public function get ConsumeScore() : int
      {
         return this.FConsumeScore;
      }
      
      public function set ConsumeScore(param1:int) : void
      {
         this.FConsumeScore = param1;
      }
      
      public function get RechargeGold() : int
      {
         return this.FRechargeGold;
      }
      
      public function set RechargeGold(param1:int) : void
      {
         this.FRechargeGold = param1;
      }
      
      public function get ScorePrice() : int
      {
         return this.FScorePrice;
      }
      
      public function set ScorePrice(param1:int) : void
      {
         this.FScorePrice = param1;
      }
      
      public function get BarGold() : int
      {
         return this.FBarGold;
      }
      
      public function set BarGold(param1:int) : void
      {
         this.FBarGold = param1;
      }
      
      public function get BossIndex() : int
      {
         return this.FBossIndex;
      }
      
      public function set BossIndex(param1:int) : void
      {
         this.FBossIndex = param1;
      }
      
      public function get BallIndex() : int
      {
         return this.FBallIndex;
      }
      
      public function set BallIndex(param1:int) : void
      {
         this.FBallIndex = param1;
      }
      
      public function get TitleList() : Vector.<uint>
      {
         return this.FTitleList;
      }
      
      public function set TitleList(param1:Vector.<uint>) : void
      {
         this.FTitleList = param1;
      }
      
      public function get EquipList() : TInventories
      {
         return this.FEquipList;
      }
      
      public function set EquipList(param1:TInventories) : void
      {
         this.FEquipList = param1;
      }
      
      public function CheckStatus() : void
      {
         var _loc1_:int = 0;
         this.FConsumeScore += this.FNeedScore[this.FBallIndex].ExchangeVect[this.FBossIndex];
         _loc1_ = this.FConsumeScore / this.FGift.Price;
         if(_loc1_ > 0)
         {
            this.FConsumeScore %= this.FGift.Price;
            this.FGift.Count += _loc1_;
         }
      }
      
      public function ChangeStatus() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < FShopRewardItems.length)
         {
            if(FShopRewardItems[_loc1_].Status == TBaseActivity.STATUS_CANNOTGET && FShopExchangePoint >= FShopRewardItems[_loc1_].Price)
            {
               FShopRewardItems[_loc1_].Status = TBaseActivity.STATUS_CANGET;
            }
            _loc1_++;
         }
      }
   }
}

