package Logics.Exercise.EverydaySale
{
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   
   public class TEverydaySale extends TBaseActivity
   {
      
      public static const SALE_TYPE_ITEM:int = 1;
      
      public static const SALE_TYPE_BOX:int = 2;
      
      protected var FSaleType:int;
      
      protected var FNextTime:int;
      
      protected var FCount:int;
      
      protected var FRechargeGold:int;
      
      protected var FBaseBox:TBaseBox;
      
      protected var FRewards:Vector.<TBaseBox>;
      
      public function TEverydaySale()
      {
         super();
         this.FBaseBox = new TBaseBox();
         this.FRewards = new Vector.<TBaseBox>();
      }
      
      public function get SaleType() : int
      {
         return this.FSaleType;
      }
      
      public function set SaleType(param1:int) : void
      {
         this.FSaleType = param1;
      }
      
      public function get BaseBox() : TBaseBox
      {
         return this.FBaseBox;
      }
      
      public function set BaseBox(param1:TBaseBox) : void
      {
         this.FBaseBox = param1;
      }
      
      public function get NextTime() : int
      {
         return this.FNextTime;
      }
      
      public function set NextTime(param1:int) : void
      {
         this.FNextTime = param1;
      }
      
      public function get Count() : int
      {
         return this.FCount;
      }
      
      public function set Count(param1:int) : void
      {
         this.FCount = param1;
      }
      
      public function get Rewards() : Vector.<TBaseBox>
      {
         return this.FRewards;
      }
      
      public function set Rewards(param1:Vector.<TBaseBox>) : void
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
      
      public function ChangeStatus() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TBaseBox = null;
         _loc1_ = 0;
         while(_loc1_ < this.FRewards.length)
         {
            _loc2_ = this.FRewards[_loc1_];
            if(_loc2_.Status == TBaseActivity.STATUS_CANNOTGET && this.FCount >= _loc2_.Price)
            {
               _loc2_.Status = TBaseActivity.STATUS_CANGET;
            }
            _loc1_++;
         }
         if(this.FBaseBox.Status == TBaseActivity.STATUS_CANNOTGET && this.FRechargeGold >= this.FBaseBox.Price)
         {
            this.FBaseBox.Status = TBaseActivity.STATUS_CANGET;
         }
         if(this.FBaseBox.Status == TBaseActivity.STATUS_CANGET && this.FBaseBox.BuyCount == 0)
         {
            this.FBaseBox.Status = TBaseActivity.STATUS_CANNOTGET;
         }
      }
      
      public function CheckStatus() : Boolean
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         this.ChangeStatus();
         if(this.FBaseBox.Status == TBaseActivity.STATUS_CANGET)
         {
            return true;
         }
         _loc2_ = int(this.FRewards.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(this.FRewards[_loc1_].Status == TBaseActivity.STATUS_CANGET)
            {
               return true;
            }
            _loc1_++;
         }
         return false;
      }
      
      public function GetLimitCount() : int
      {
         var _loc1_:int = 0;
         var _loc2_:TBaseBox = null;
         if(this.FCount >= this.FRewards[this.FRewards.length - 1].Price)
         {
            return -1;
         }
         _loc1_ = 0;
         while(_loc1_ < this.FRewards.length)
         {
            _loc2_ = this.FRewards[_loc1_];
            if(_loc2_.Status == TBaseActivity.STATUS_CANNOTGET)
            {
               return _loc2_.Price - this.FCount;
            }
            _loc1_++;
         }
         return 0;
      }
   }
}

