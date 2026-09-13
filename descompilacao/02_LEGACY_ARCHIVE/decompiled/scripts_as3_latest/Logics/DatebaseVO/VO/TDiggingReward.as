package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import flash.utils.ByteArray;
   import ghostcat.util.data.Json;
   
   use namespace ResourcesSpace;
   
   public class TDiggingReward extends TDatebaseVO
   {
      
      protected var FReward:String;
      
      protected var FRobLoss:String;
      
      protected var FProbReward:String;
      
      protected var FProbReward2:String;
      
      protected var FMastGetReward:Vector.<Object>;
      
      protected var FOddsGetReward:Vector.<Object>;
      
      protected var FOddsGetReward2:Vector.<Object>;
      
      protected var FLossThings:Vector.<Object>;
      
      public function TDiggingReward()
      {
         super();
      }
      
      public function get Reward() : String
      {
         return this.FReward;
      }
      
      public function get RobLoss() : String
      {
         return this.FRobLoss;
      }
      
      public function get ProbReward() : String
      {
         return this.FProbReward;
      }
      
      public function get ProbReward2() : String
      {
         return this.FProbReward2;
      }
      
      override ResourcesSpace function WriteDataToStream(param1:ByteArray) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         param1.writeUnsignedInt(FIdentifier);
         TUtilityString.FlushUTF(param1,this.FReward);
         TUtilityString.FlushUTF(param1,this.FRobLoss);
         TUtilityString.FlushUTF(param1,this.FProbReward);
         TUtilityString.FlushUTF(param1,this.FProbReward2);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         this.FReward = TUtilityString.FetchUTF(param1);
         this.FRobLoss = TUtilityString.FetchUTF(param1);
         this.FProbReward = TUtilityString.FetchUTF(param1);
         this.FProbReward2 = TUtilityString.FetchUTF(param1);
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
      
      public function get MastGetReward() : Vector.<Object>
      {
         if(this.FMastGetReward == null)
         {
            this.FMastGetReward = Vector.<Object>(Json.decode(this.FReward));
         }
         return this.FMastGetReward;
      }
      
      public function get OddsGetReward() : Vector.<Object>
      {
         if(this.FOddsGetReward == null)
         {
            this.FOddsGetReward = Vector.<Object>(Json.decode(this.FProbReward));
         }
         return this.FOddsGetReward;
      }
      
      public function get OddsGetReward2() : Vector.<Object>
      {
         if(this.FOddsGetReward2 == null)
         {
            this.FOddsGetReward2 = Vector.<Object>(Json.decode(this.FProbReward2));
         }
         return this.FOddsGetReward2;
      }
      
      public function get LossThings() : Vector.<Object>
      {
         if(this.FLossThings == null)
         {
            this.FLossThings = Vector.<Object>(Json.decode(this.FRobLoss));
         }
         return this.FLossThings;
      }
   }
}

