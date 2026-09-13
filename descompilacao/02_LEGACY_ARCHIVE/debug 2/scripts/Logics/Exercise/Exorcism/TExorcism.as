package Logics.Exercise.Exorcism
{
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   
   public class TExorcism extends TBaseActivity
   {
      
      public var MyScore:int;
      
      public var ConsumeScore:int;
      
      public var ScorePrice:int;
      
      public var BossList:Vector.<TBaseBox>;
      
      public var CannonList:Vector.<TBaseBox>;
      
      public var KillBox:Vector.<TBaseBox>;
      
      public var RechargeList:Vector.<TBaseBox>;
      
      public var ShowItems:TInventories;
      
      public var BossIndex:int;
      
      public var BallIndex:int;
      
      public function TExorcism()
      {
         super();
         this.BossList = new Vector.<TBaseBox>();
         this.CannonList = new Vector.<TBaseBox>();
         this.KillBox = new Vector.<TBaseBox>();
         this.RechargeList = new Vector.<TBaseBox>();
      }
      
      public function ChangeStatus() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < this.RechargeList.length)
         {
            if(this.RechargeList[_loc1_].Status == TBaseActivity.STATUS_CANNOTGET && this.ConsumeScore >= this.RechargeList[_loc1_].Price)
            {
               this.RechargeList[_loc1_].Status = TBaseActivity.STATUS_CANGET;
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < ShopRewardItems.length)
         {
            if(ShopRewardItems[_loc1_].Status == TBaseActivity.STATUS_CANNOTGET && ShopExchangePoint >= ShopRewardItems[_loc1_].Price)
            {
               ShopRewardItems[_loc1_].Status = TBaseActivity.STATUS_CANGET;
            }
            _loc1_++;
         }
      }
      
      public function CheckStatus() : Boolean
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < this.RechargeList.length)
         {
            if(this.RechargeList[_loc1_].Status == TBaseActivity.STATUS_CANGET)
            {
               return true;
            }
            _loc1_++;
         }
         return false;
      }
      
      public function Reset() : void
      {
         if(this.BossList[this.BossIndex].Min == 0)
         {
            this.BossList[this.BossIndex].Min = this.BossList[this.BossIndex].Max;
         }
      }
      
      public function GetCurIndex() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc2_ = int(this.RechargeList.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(this.RechargeList[_loc1_].Status != TBaseActivity.STATUS_GETED)
            {
               return _loc1_;
            }
            _loc1_++;
         }
         return _loc1_ - 1;
      }
   }
}

