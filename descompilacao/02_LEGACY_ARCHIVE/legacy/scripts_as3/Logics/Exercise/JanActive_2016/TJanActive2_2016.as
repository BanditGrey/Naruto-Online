package Logics.Exercise.JanActive_2016
{
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   
   public class TJanActive2_2016 extends TBaseActivity
   {
      
      public static const TYPE_COIN:int = 1;
      
      public static const TYPE_GOLD:int = 2;
      
      public var Score:int;
      
      public var TreeLevel:int;
      
      public var TreeExp:int;
      
      public var TreeExpMax:int;
      
      public var NeedReset:int;
      
      public var CostList:Vector.<int>;
      
      public var ResetCost:int;
      
      public var UpgradeCost:int;
      
      public var ScorePrice:int;
      
      public var ShowItem:TInventories;
      
      public var FruitList:Vector.<TBaseBox>;
      
      public var RechargeBox:Vector.<TBaseBox>;
      
      public var ConsumeBox:TBaseBox;
      
      public function TJanActive2_2016()
      {
         super();
         this.ConsumeBox = new TBaseBox();
         this.CostList = new Vector.<int>();
         this.FruitList = new Vector.<TBaseBox>();
         this.RechargeBox = new Vector.<TBaseBox>();
      }
      
      public function ChangeStatus() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < this.RechargeBox.length)
         {
            if(this.RechargeBox[_loc1_].Status == TBaseActivity.STATUS_CANNOTGET && TotalRechargeGold >= this.RechargeBox[_loc1_].Price)
            {
               this.RechargeBox[_loc1_].Status = TBaseActivity.STATUS_CANGET;
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this.FruitList.length)
         {
            if(this.FruitList[_loc1_].Status == TBaseActivity.STATUS_CANNOTGET && this.TreeExp >= this.FruitList[_loc1_].Price)
            {
               this.FruitList[_loc1_].Status = TBaseActivity.STATUS_CANGET;
            }
            _loc1_++;
         }
      }
      
      public function ResetTree() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < this.FruitList.length)
         {
            this.FruitList[_loc1_].Status = TBaseActivity.STATUS_CANNOTGET;
            _loc1_++;
         }
         this.TreeExp = 0;
      }
      
      public function get CanUpgrade() : Boolean
      {
         var _loc1_:int = 0;
         if(this.TreeExp < this.TreeExpMax)
         {
            return false;
         }
         _loc1_ = 0;
         while(_loc1_ < this.FruitList.length)
         {
            if(this.FruitList[_loc1_].Status != TBaseActivity.STATUS_GETED)
            {
               return false;
            }
            _loc1_++;
         }
         return true;
      }
      
      public function get CurBoxIndex() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc2_ = int(this.RechargeBox.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(this.RechargeBox[_loc1_].Status == TBaseActivity.STATUS_CANGET)
            {
               return _loc1_;
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(this.RechargeBox[_loc1_].Status == TBaseActivity.STATUS_CANNOTGET)
            {
               return _loc1_;
            }
            _loc1_++;
         }
         return _loc1_ - 1;
      }
   }
}

