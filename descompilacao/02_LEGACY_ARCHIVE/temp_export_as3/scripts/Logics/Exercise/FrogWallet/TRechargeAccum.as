package Logics.Exercise.FrogWallet
{
   import Foundation.Timing.STimingCore;
   import Logics.Exercise.TBaseActivity;
   
   public class TRechargeAccum extends TBaseActivity
   {
      
      protected var FRebate:Vector.<int>;
      
      protected var FRebateNeedGold:Vector.<int>;
      
      protected var FAmountGold:Vector.<int>;
      
      protected var FBuff:int;
      
      protected var FIsContinued:Boolean;
      
      protected var FMinRechargeLimit:int;
      
      public function TRechargeAccum()
      {
         super();
         this.FRebate = new Vector.<int>();
         this.FRebateNeedGold = new Vector.<int>();
         this.FAmountGold = new Vector.<int>();
      }
      
      public function get Rebate() : Vector.<int>
      {
         return this.FRebate;
      }
      
      public function set Rebate(param1:Vector.<int>) : void
      {
         this.FRebate = param1;
      }
      
      public function get RebateNeedGold() : Vector.<int>
      {
         return this.FRebateNeedGold;
      }
      
      public function set RebateNeedGold(param1:Vector.<int>) : void
      {
         this.FRebateNeedGold = param1;
      }
      
      public function get AmountGold() : Vector.<int>
      {
         return this.FAmountGold;
      }
      
      public function set AmountGold(param1:Vector.<int>) : void
      {
         this.FAmountGold = param1;
      }
      
      public function get Buff() : int
      {
         return this.FBuff;
      }
      
      public function set Buff(param1:int) : void
      {
         this.FBuff = param1;
      }
      
      public function get IsContinued() : Boolean
      {
         return this.FIsContinued;
      }
      
      public function set IsContinued(param1:Boolean) : void
      {
         this.FIsContinued = param1;
      }
      
      public function get MaxPayLimit() : int
      {
         return this.FRebateNeedGold[this.FRebateNeedGold.length - 1];
      }
      
      public function get MinRechargeLimit() : int
      {
         return this.FMinRechargeLimit;
      }
      
      public function set MinRechargeLimit(param1:int) : void
      {
         this.FMinRechargeLimit = param1;
      }
      
      public function GetRebateByGold(param1:int) : int
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _loc4_ = int(this.FRebate.length);
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            if(param1 < this.FRebateNeedGold[_loc3_])
            {
               break;
            }
            _loc3_++;
         }
         if(_loc3_ == 0)
         {
            _loc2_ = 0;
         }
         else
         {
            _loc2_ = this.FRebate[_loc3_ - 1];
         }
         return _loc2_;
      }
      
      public function GetIndexByGold(param1:int) : int
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _loc4_ = int(this.FRebateNeedGold.length);
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            if(param1 < this.FRebateNeedGold[_loc3_])
            {
               break;
            }
            _loc3_++;
         }
         return _loc3_;
      }
      
      public function GetTodayIndex() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = this.GetCurDayIndex();
         return this.GetIndexByGold(this.FAmountGold[_loc2_]);
      }
      
      public function GetRebateByIndex(param1:int) : int
      {
         return this.GetRebateByGold(this.FAmountGold[param1]);
      }
      
      public function GetTotalRebateGold() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc3_ = int(this.FAmountGold.length);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc1_ += this.GetRebateGoldByIndex(_loc2_);
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function GetBuffGold() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc3_ = int(this.FAmountGold.length);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc1_ += this.FAmountGold[_loc2_];
            _loc2_++;
         }
         return int(Math.floor(_loc1_ * this.Buff / 100));
      }
      
      public function GetRebateGoldByIndex(param1:int) : int
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc3_ = this.GetRebateByGold(this.FAmountGold[param1]);
         return int(Math.floor(this.FAmountGold[param1] * _loc3_ / 100));
      }
      
      public function CheckIsContinue() : Boolean
      {
         var _loc2_:int = 0;
         var _loc1_:int = this.GetCurDayIndex();
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            if(this.FAmountGold[_loc2_] < this.FMinRechargeLimit)
            {
               this.FIsContinued = false;
               return this.FIsContinued;
            }
            _loc2_++;
         }
         this.FIsContinued = true;
         if(STimingCore.GetServerTick() > FPayEndTime)
         {
            if(this.FAmountGold[4] < this.FMinRechargeLimit)
            {
               this.FIsContinued = false;
               return this.FIsContinued;
            }
         }
         return this.FIsContinued;
      }
      
      public function GetCurDayIndex() : int
      {
         var _loc1_:Date = new Date(STimingCore.GetClientShowTime(BeginTime) * 1000);
         _loc1_.hours = 0;
         _loc1_.minutes = 0;
         _loc1_.seconds = 0;
         var _loc2_:Date = new Date(STimingCore.GetServerTime() * 1000);
         _loc2_.hours = 0;
         _loc2_.minutes = 0;
         _loc2_.seconds = 0;
         var _loc3_:Number = (_loc2_.valueOf() - _loc1_.valueOf()) / 1000 / 24 / 60 / 60;
         var _loc4_:int = Math.floor(_loc3_);
         if(_loc4_ >= 5)
         {
            _loc4_ = 4;
         }
         return _loc4_;
      }
      
      public function GetRealCurDayIndex() : int
      {
         var _loc1_:Date = new Date(STimingCore.GetClientShowTime(BeginTime) * 1000);
         _loc1_.hours = 0;
         _loc1_.minutes = 0;
         _loc1_.seconds = 0;
         var _loc2_:Date = new Date(STimingCore.GetServerTime() * 1000);
         _loc2_.hours = 0;
         _loc2_.minutes = 0;
         _loc2_.seconds = 0;
         var _loc3_:Number = (_loc2_.valueOf() - _loc1_.valueOf()) / 1000 / 24 / 60 / 60;
         return int(Math.floor(_loc3_));
      }
      
      public function GetNextLimitNeedGold() : Vector.<int>
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc1_:Vector.<int> = new Vector.<int>(2);
         var _loc7_:int = this.GetCurDayIndex();
         var _loc8_:int = this.FAmountGold[_loc7_];
         _loc6_ = int(this.FRebate.length);
         _loc5_ = 0;
         while(_loc5_ < _loc6_)
         {
            if(_loc8_ == this.FRebateNeedGold[_loc5_])
            {
               if(_loc5_ >= _loc6_ - 1)
               {
                  _loc2_ = 0;
                  _loc3_ = this.FRebate[_loc5_];
               }
               else
               {
                  _loc2_ = this.FRebateNeedGold[_loc5_ + 1] - this.FRebateNeedGold[_loc5_];
                  _loc3_ = this.FRebate[_loc5_ + 1];
               }
               break;
            }
            if(_loc8_ < this.FRebateNeedGold[_loc5_])
            {
               _loc2_ = this.FRebateNeedGold[_loc5_] - _loc8_;
               _loc3_ = this.FRebate[_loc5_];
               break;
            }
            _loc5_++;
         }
         if(_loc5_ >= _loc6_)
         {
            _loc2_ = 0;
            _loc3_ = this.FRebate[_loc6_ - 1];
         }
         _loc1_[0] = _loc2_;
         _loc1_[1] = _loc3_;
         return _loc1_;
      }
      
      public function ChangeBoxStatus(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:int = this.GetCurDayIndex();
         FRewardStatus[0] = param2;
         this.FAmountGold[_loc4_] += param3;
      }
   }
}

