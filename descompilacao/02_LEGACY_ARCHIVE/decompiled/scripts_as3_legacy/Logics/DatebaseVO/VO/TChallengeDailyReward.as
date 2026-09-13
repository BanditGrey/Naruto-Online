package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import Logics.DatebaseVO.VO.Json.TChallengeReward;
   import Logics.DatebaseVO.VO.Json.TTaskReward;
   import flash.utils.ByteArray;
   import ghostcat.util.data.Json;
   
   use namespace ResourcesSpace;
   
   public class TChallengeDailyReward extends TDatebaseVO
   {
      
      protected var FTimes:int;
      
      protected var FReward:String;
      
      protected var FReward1:String;
      
      protected var FRewards:Vector.<TTaskReward>;
      
      protected var FRewards1:Vector.<TChallengeReward>;
      
      public function TChallengeDailyReward()
      {
         super();
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
      
      override ResourcesSpace function WriteDataToStream(param1:ByteArray) : void
      {
         param1.writeUnsignedInt(FIdentifier);
         param1.writeUnsignedInt(this.FTimes);
         TUtilityString.FlushUTF(param1,this.FReward);
         TUtilityString.FlushUTF(param1,this.FReward1);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:TTaskReward = null;
         var _loc6_:TChallengeReward = null;
         this.FTimes = param1.readUnsignedInt();
         this.FReward = TUtilityString.FetchUTF(param1);
         _loc2_ = Json.decode(this.FReward) as Array;
         if(_loc2_ != null)
         {
            _loc4_ = _loc2_.length;
            this.FRewards = new Vector.<TTaskReward>(_loc4_);
            _loc3_ = 0;
            while(_loc3_ < _loc4_)
            {
               _loc5_ = new TTaskReward(_loc2_[_loc3_]);
               this.FRewards[_loc3_] = _loc5_;
               _loc3_++;
            }
         }
         this.FReward1 = TUtilityString.FetchUTF(param1);
         _loc2_ = Json.decode(this.FReward1) as Array;
         if(_loc2_ != null)
         {
            _loc4_ = _loc2_.length;
            this.FRewards1 = new Vector.<TChallengeReward>(_loc4_);
            _loc3_ = 0;
            while(_loc3_ < _loc4_)
            {
               _loc6_ = new TChallengeReward(_loc2_[_loc3_]);
               this.FRewards1[_loc3_] = _loc6_;
               _loc3_++;
            }
         }
      }
      
      public function get Times() : int
      {
         return this.FTimes;
      }
      
      public function get Reward() : String
      {
         return this.FReward;
      }
      
      public function get Reward1() : String
      {
         return this.FReward1;
      }
      
      public function get Rewards() : Vector.<TTaskReward>
      {
         return this.FRewards;
      }
      
      public function get Rewards1() : Vector.<TChallengeReward>
      {
         return this.FRewards1;
      }
   }
}

