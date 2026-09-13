package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import Logics.DatebaseVO.VO.Json.TDailyTaskReward;
   import flash.utils.ByteArray;
   import ghostcat.util.data.Json;
   
   use namespace ResourcesSpace;
   
   public class TSignContinuous extends TDatebaseVO
   {
      
      protected var FDay:int;
      
      protected var FRound:int;
      
      protected var FVipCondition:int;
      
      protected var FNightPowerCondition:int;
      
      protected var FDesc:String;
      
      protected var FReward:String;
      
      protected var FVipDouble:String;
      
      protected var FNightPowerDouble:String;
      
      protected var FQianDaoRewardsVect:Vector.<TDailyTaskReward>;
      
      protected var FVipRewardsVect:Vector.<TDailyTaskReward>;
      
      protected var FTabooRewardsVect:Vector.<TDailyTaskReward>;
      
      public function TSignContinuous()
      {
         super();
      }
      
      public function get TabooRewardsVect() : Vector.<TDailyTaskReward>
      {
         return this.FTabooRewardsVect;
      }
      
      public function get VipRewardsVect() : Vector.<TDailyTaskReward>
      {
         return this.FVipRewardsVect;
      }
      
      public function get QianDaoRewardsVect() : Vector.<TDailyTaskReward>
      {
         return this.FQianDaoRewardsVect;
      }
      
      public function get NightPowerDouble() : String
      {
         return this.FNightPowerDouble;
      }
      
      public function get VipDouble() : String
      {
         return this.FVipDouble;
      }
      
      public function get Reward() : String
      {
         return this.FReward;
      }
      
      public function get Desc() : String
      {
         return this.FDesc;
      }
      
      public function get Day() : int
      {
         return this.FDay;
      }
      
      public function get Round() : int
      {
         return this.FRound;
      }
      
      public function get VipCondition() : int
      {
         return this.FVipCondition;
      }
      
      public function get NightPowerCondition() : int
      {
         return this.FNightPowerCondition;
      }
      
      override ResourcesSpace function WriteDataToStream(param1:ByteArray) : void
      {
         param1.writeUnsignedInt(FIdentifier);
         param1.writeUnsignedInt(this.FDay);
         param1.writeUnsignedInt(this.FRound);
         param1.writeUnsignedInt(this.FVipCondition);
         param1.writeUnsignedInt(this.FNightPowerCondition);
         TUtilityString.FlushUTF(param1,this.FDesc);
         TUtilityString.FlushUTF(param1,this.FReward);
         TUtilityString.FlushUTF(param1,this.FVipDouble);
         TUtilityString.FlushUTF(param1,this.FNightPowerDouble);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Object = null;
         var _loc4_:Array = null;
         var _loc5_:TDailyTaskReward = null;
         var _loc6_:int = 0;
         this.FDay = param1.readUnsignedInt();
         this.FRound = param1.readUnsignedInt();
         this.FVipCondition = param1.readUnsignedInt();
         this.FNightPowerCondition = param1.readUnsignedInt();
         this.FDesc = TUtilityString.FetchUTF(param1);
         this.FReward = TUtilityString.FetchUTF(param1);
         _loc3_ = Json.decode(this.FReward);
         _loc4_ = _loc3_ as Array;
         _loc2_ = int(_loc4_.length);
         this.FQianDaoRewardsVect = new Vector.<TDailyTaskReward>(_loc2_);
         _loc6_ = 0;
         while(_loc6_ < _loc2_)
         {
            _loc5_ = new TDailyTaskReward(_loc4_[_loc6_]);
            this.FQianDaoRewardsVect[_loc6_] = _loc5_;
            _loc6_++;
         }
         this.FVipDouble = TUtilityString.FetchUTF(param1);
         _loc3_ = Json.decode(this.FVipDouble);
         _loc4_ = _loc3_ as Array;
         _loc2_ = int(_loc4_.length);
         this.FVipRewardsVect = new Vector.<TDailyTaskReward>(_loc2_);
         _loc6_ = 0;
         while(_loc6_ < _loc2_)
         {
            _loc5_ = new TDailyTaskReward(_loc4_[_loc6_]);
            this.FVipRewardsVect[_loc6_] = _loc5_;
            _loc6_++;
         }
         this.FNightPowerDouble = TUtilityString.FetchUTF(param1);
         _loc3_ = Json.decode(this.FNightPowerDouble);
         _loc4_ = _loc3_ as Array;
         _loc2_ = int(_loc4_.length);
         this.FTabooRewardsVect = new Vector.<TDailyTaskReward>(_loc2_);
         _loc6_ = 0;
         while(_loc6_ < _loc2_)
         {
            _loc5_ = new TDailyTaskReward(_loc4_[_loc6_]);
            this.FTabooRewardsVect[_loc6_] = _loc5_;
            _loc6_++;
         }
      }
      
      override ResourcesSpace function ReadDataByXml(param1:XML) : void
      {
         var _loc2_:XML = null;
         var _loc3_:String = null;
         var _loc4_:* = undefined;
         var _loc5_:uint = 0;
         var _loc6_:int = 0;
         _loc5_ = uint(param1.elements().length());
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc2_ = param1.elements()[_loc6_];
            _loc3_ = String(_loc2_.name());
            _loc4_ = _loc2_;
            if(_loc3_ == "id")
            {
               Coerce(uint(_loc4_));
            }
            else
            {
               _loc3_ = "F" + _loc3_;
               if(hasOwnProperty(_loc3_))
               {
                  this[_loc3_] = _loc4_;
               }
               else
               {
                  if(Count_AttributeName.indexOf(_loc3_.slice(1,2)) < 0)
                  {
                     _loc3_ = "F" + _loc3_.slice(1,2).toLocaleUpperCase() + _loc3_.slice(2);
                  }
                  if(hasOwnProperty(_loc3_.slice(1)))
                  {
                     if(this[_loc3_] is Boolean)
                     {
                        this[_loc3_] = Boolean(int(_loc4_));
                     }
                     else
                     {
                        this[_loc3_] = _loc4_;
                     }
                  }
               }
            }
            _loc6_++;
         }
      }
   }
}

