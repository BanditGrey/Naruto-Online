package Logics.Exercise.GuaGuaLe
{
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   
   public class TGuaGuaLe extends TBaseActivity
   {
      
      protected static const BOX_TYPE:int = 3;
      
      protected static const REWARD_COUNT:int = 9;
      
      protected var FPoint:int;
      
      protected var FCurGold:int;
      
      protected var FFreePointStatus:int;
      
      protected var FFreePoint:int;
      
      protected var FPointRate:int;
      
      protected var FGoldRate:int;
      
      protected var FCreditRegion:Vector.<int>;
      
      protected var FPointRegion:Vector.<int>;
      
      protected var FPointStatus:Vector.<int>;
      
      protected var FBoxVect:Vector.<TBaseBox>;
      
      protected var FIndexReward:Vector.<int>;
      
      public function TGuaGuaLe()
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         super();
         this.FBoxVect = new Vector.<TBaseBox>(BOX_TYPE);
         this.FCreditRegion = new Vector.<int>();
         this.FPointRegion = new Vector.<int>();
         this.FPointStatus = new Vector.<int>();
         this.FIndexReward = new Vector.<int>(REWARD_COUNT);
         _loc2_ = REWARD_COUNT;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.FIndexReward[_loc1_] = _loc1_;
            _loc1_++;
         }
      }
      
      protected function RandomArr(param1:int, param2:int) : Vector.<int>
      {
         var RewardIdx:uint = 0;
         var temp:uint = 0;
         var RewardIndex:int = param1;
         var ChooseIndex:int = param2;
         this.FIndexReward.sort(function():int
         {
            return Math.random() > 0.5 ? 1 : -1;
         });
         RewardIdx = this.FIndexReward.indexOf(RewardIndex);
         temp = uint(this.FIndexReward[ChooseIndex]);
         this.FIndexReward[ChooseIndex] = RewardIndex;
         this.FIndexReward[RewardIdx] = temp;
         return this.FIndexReward;
      }
      
      public function get BoxVect() : Vector.<TBaseBox>
      {
         return this.FBoxVect;
      }
      
      public function set BoxVect(param1:Vector.<TBaseBox>) : void
      {
         this.FBoxVect = param1;
      }
      
      public function get Point() : int
      {
         return this.FPoint;
      }
      
      public function set Point(param1:int) : void
      {
         this.FPoint = param1;
      }
      
      public function get CreditRegion() : Vector.<int>
      {
         return this.FCreditRegion;
      }
      
      public function set CreditRegion(param1:Vector.<int>) : void
      {
         this.FCreditRegion = param1;
      }
      
      public function get PointRegion() : Vector.<int>
      {
         return this.FPointRegion;
      }
      
      public function set PointRegion(param1:Vector.<int>) : void
      {
         this.FPointRegion = param1;
      }
      
      public function get PointStatus() : Vector.<int>
      {
         return this.FPointStatus;
      }
      
      public function set PointStatus(param1:Vector.<int>) : void
      {
         this.FPointStatus = param1;
      }
      
      public function get CurGold() : int
      {
         return this.FCurGold;
      }
      
      public function set CurGold(param1:int) : void
      {
         this.FCurGold = param1;
      }
      
      public function get FreePointStatus() : int
      {
         return this.FFreePointStatus;
      }
      
      public function set FreePointStatus(param1:int) : void
      {
         this.FFreePointStatus = param1;
      }
      
      public function get FreePoint() : int
      {
         return this.FFreePoint;
      }
      
      public function set FreePoint(param1:int) : void
      {
         this.FFreePoint = param1;
      }
      
      public function get PointRate() : int
      {
         return this.FPointRate;
      }
      
      public function set PointRate(param1:int) : void
      {
         this.FPointRate = param1;
      }
      
      public function get GoldRate() : int
      {
         return this.FGoldRate;
      }
      
      public function set GoldRate(param1:int) : void
      {
         this.FGoldRate = param1;
      }
      
      public function GetCurIndex() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc2_ = int(this.FCreditRegion.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(this.FPointStatus[_loc1_] != TBaseActivity.STATUS_GETED)
            {
               return _loc1_;
            }
            _loc1_++;
         }
         return _loc1_;
      }
      
      public function ChangeStatus() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc2_ = int(this.FPointStatus.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(this.FPointStatus[_loc1_] == TBaseActivity.STATUS_CANNOTGET && this.FCurGold >= this.FCreditRegion[_loc1_])
            {
               this.FPointStatus[_loc1_] = TBaseActivity.STATUS_CANGET;
            }
            _loc1_++;
         }
      }
      
      public function CheckEffect() : Boolean
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(this.FFreePointStatus == TBaseActivity.STATUS_CANGET)
         {
            return true;
         }
         _loc2_ = int(this.FPointStatus.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(this.FPointStatus[_loc1_] == TBaseActivity.STATUS_CANGET)
            {
               return true;
            }
            _loc1_++;
         }
         return false;
      }
      
      public function GetShowInventories(param1:int, param2:int, param3:int) : TInventories
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:Vector.<int> = null;
         var _loc7_:TInventories = null;
         var _loc8_:TInventory = null;
         _loc6_ = this.RandomArr(param2,param3);
         _loc7_ = new TInventories();
         _loc4_ = 0;
         while(_loc4_ < REWARD_COUNT)
         {
            _loc8_ = this.FBoxVect[param1].Inventories.GetInventoryByIndex(_loc6_[_loc4_]);
            _loc7_.Add(_loc8_);
            _loc4_++;
         }
         return _loc7_;
      }
   }
}

