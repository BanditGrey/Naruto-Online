package Logics.Exercise.RechargeExchange
{
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   
   public class TRechargeExchange extends TBaseActivity
   {
      
      protected var FTotalRecharge:int;
      
      protected var FRechargeVect:Vector.<int>;
      
      protected var FGetBoxVect:Vector.<TBaseBox>;
      
      protected var FBuyBoxVect:Vector.<TBaseBox>;
      
      public function TRechargeExchange()
      {
         super();
         this.FRechargeVect = new Vector.<int>();
         this.FGetBoxVect = new Vector.<TBaseBox>();
         this.FBuyBoxVect = new Vector.<TBaseBox>();
      }
      
      public function get TotalRecharge() : int
      {
         return this.FTotalRecharge;
      }
      
      public function set TotalRecharge(param1:int) : void
      {
         this.FTotalRecharge = param1;
      }
      
      public function get GetBoxVect() : Vector.<TBaseBox>
      {
         return this.FGetBoxVect;
      }
      
      public function set GetBoxVect(param1:Vector.<TBaseBox>) : void
      {
         this.FGetBoxVect = param1;
      }
      
      public function get BuyBoxVect() : Vector.<TBaseBox>
      {
         return this.FBuyBoxVect;
      }
      
      public function set BuyBoxVect(param1:Vector.<TBaseBox>) : void
      {
         this.FBuyBoxVect = param1;
      }
      
      public function get RechargeVect() : Vector.<int>
      {
         return this.FRechargeVect;
      }
      
      public function set RechargeVect(param1:Vector.<int>) : void
      {
         this.FRechargeVect = param1;
      }
      
      public function get CurIndex() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc2_ = this.FRechargeVect.length - 1;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(this.FGetBoxVect[_loc1_].Status == TBaseActivity.STATUS_CANGET || this.FBuyBoxVect[_loc1_].Status == TBaseActivity.STATUS_CANGET && this.FBuyBoxVect[_loc1_].BuyCount < this.FBuyBoxVect[_loc1_].Count)
            {
               return _loc1_;
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(this.FTotalRecharge < this.FRechargeVect[_loc1_ + 1])
            {
               return _loc1_;
            }
            _loc1_++;
         }
         return _loc1_ - 1;
      }
      
      public function CheckBoxStatus() : Boolean
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc2_ = int(this.FGetBoxVect.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(this.FGetBoxVect[_loc1_].Status == TBaseActivity.STATUS_CANGET || this.FBuyBoxVect[_loc1_].Status == TBaseActivity.STATUS_CANGET && this.FBuyBoxVect[_loc1_].BuyCount < this.FBuyBoxVect[_loc1_].Count)
            {
               return true;
            }
            _loc1_++;
         }
         return false;
      }
      
      public function CheckStatus() : Boolean
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc2_ = int(this.FGetBoxVect.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(this.FGetBoxVect[_loc1_].Status == TBaseActivity.STATUS_CANGET)
            {
               return true;
            }
            _loc1_++;
         }
         return false;
      }
   }
}

