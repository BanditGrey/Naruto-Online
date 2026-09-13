package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import Logics.DatebaseVO.VO.Json.TFixedAward;
   import flash.utils.ByteArray;
   import ghostcat.util.data.Json;
   
   use namespace ResourcesSpace;
   
   public class TDailyOnlineReward extends TDatebaseVO
   {
      
      protected var FNeedTime:uint;
      
      protected var FReward:String;
      
      protected var FReward_wei:String;
      
      protected var FRewardVector:Vector.<TFixedAward>;
      
      protected var FRewardweiVector:Vector.<TFixedAward>;
      
      protected var FGradeInterval:String;
      
      protected var FGradeIntervalArr:Array;
      
      public function TDailyOnlineReward()
      {
         super();
         this.FRewardVector = new Vector.<TFixedAward>();
         this.FRewardweiVector = new Vector.<TFixedAward>();
      }
      
      public function get NeedTime() : uint
      {
         return this.FNeedTime;
      }
      
      public function get Reward() : String
      {
         return this.FReward;
      }
      
      public function get Reward_wei() : String
      {
         return this.FReward_wei;
      }
      
      public function get GradeInterval() : String
      {
         return this.FGradeInterval;
      }
      
      public function get GradeIntervalArr() : Array
      {
         return this.FGradeIntervalArr;
      }
      
      public function get RewardVector() : Vector.<TFixedAward>
      {
         return this.FRewardVector;
      }
      
      public function get RewardweiVector() : Vector.<TFixedAward>
      {
         return this.FRewardweiVector;
      }
      
      override ResourcesSpace function WriteDataToStream(param1:ByteArray) : void
      {
         param1.writeUnsignedInt(FIdentifier);
         param1.writeUnsignedInt(this.FNeedTime);
         TUtilityString.FlushUTF(param1,this.FReward);
         TUtilityString.FlushUTF(param1,this.FReward_wei);
         TUtilityString.FlushUTF(param1,this.FGradeInterval);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:Array = null;
         var _loc5_:TFixedAward = null;
         this.FNeedTime = param1.readUnsignedInt();
         this.FReward = TUtilityString.FetchUTF(param1);
         _loc4_ = Json.decode(this.FReward);
         _loc2_ = _loc4_.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc5_ = new TFixedAward(_loc4_[_loc3_]);
            this.FRewardVector[_loc3_] = _loc5_;
            _loc3_++;
         }
         this.FReward_wei = TUtilityString.FetchUTF(param1);
         _loc4_ = Json.decode(this.FReward_wei);
         _loc2_ = _loc4_.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc5_ = new TFixedAward(_loc4_[_loc3_]);
            this.FRewardweiVector[_loc3_] = _loc5_;
            _loc3_++;
         }
         this.FGradeInterval = TUtilityString.FetchUTF(param1);
         this.FGradeIntervalArr = Json.decode(this.FGradeInterval);
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

