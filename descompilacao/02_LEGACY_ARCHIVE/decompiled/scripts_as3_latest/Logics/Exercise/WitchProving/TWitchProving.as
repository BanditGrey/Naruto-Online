package Logics.Exercise.WitchProving
{
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   
   public class TWitchProving extends TBaseActivity
   {
      
      public var Pet:TBaseBox;
      
      public var PetReward:TBaseBox;
      
      public var BarGift:TBaseBox;
      
      public var Fires:Vector.<int>;
      
      public var ShowItems:TInventories;
      
      public var LotteryCount:int;
      
      public var RechargeGift:TBaseBox;
      
      public var Score:int;
      
      public var ReturnGold:int;
      
      public function TWitchProving()
      {
         super();
         this.Pet = new TBaseBox();
         this.PetReward = new TBaseBox();
         this.BarGift = new TBaseBox();
         this.RechargeGift = new TBaseBox();
         this.Fires = new Vector.<int>();
      }
      
      public function ChangeStatus() : void
      {
      }
      
      public function CheckStatus() : Boolean
      {
         return false;
      }
      
      public function get NextNeedNum() : int
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < this.BarGift.ExchangeVect.length)
         {
            if(this.Score < this.BarGift.ExchangeVect[_loc1_])
            {
               break;
            }
            _loc1_++;
         }
         if(_loc1_ >= this.BarGift.ExchangeVect.length)
         {
            return 0;
         }
         return this.BarGift.ExchangeVect[_loc1_] - this.Score;
      }
      
      public function get CurLevel() : int
      {
         var _loc1_:* = 0;
         _loc1_ = int(this.BarGift.ExchangeVect.length - 1);
         while(_loc1_ >= 0)
         {
            if(this.Score >= this.BarGift.ExchangeVect[_loc1_])
            {
               break;
            }
            _loc1_--;
         }
         return _loc1_;
      }
   }
}

