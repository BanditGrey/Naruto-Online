package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import Logics.DatebaseVO.VO.Json.TDailyTaskReward;
   import flash.utils.ByteArray;
   import ghostcat.util.data.Json;
   
   use namespace ResourcesSpace;
   
   public class TDailyAward extends TDatebaseVO
   {
      
      protected var FMark:int;
      
      protected var FLevel1:int;
      
      protected var FRewardsVect:Vector.<TDailyTaskReward>;
      
      protected var FRewards:String;
      
      public function TDailyAward()
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
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         param1.writeUnsignedInt(FIdentifier);
         param1.writeUnsignedInt(this.FMark);
         param1.writeUnsignedInt(this.FLevel1);
         TUtilityString.FlushUTF(param1,this.FRewards);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Object = null;
         var _loc5_:String = null;
         var _loc6_:Array = null;
         var _loc7_:TDailyTaskReward = null;
         this.FMark = param1.readUnsignedInt();
         this.FLevel1 = param1.readUnsignedInt();
         this.FRewards = TUtilityString.FetchUTF(param1);
         _loc4_ = Json.decode(this.FRewards);
         _loc6_ = _loc4_ as Array;
         _loc3_ = int(_loc6_.length);
         this.FRewardsVect = new Vector.<TDailyTaskReward>(_loc3_);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc7_ = new TDailyTaskReward(_loc6_[_loc2_]);
            this.FRewardsVect[_loc2_] = _loc7_;
            _loc2_++;
         }
      }
      
      public function get RewardsVect() : Vector.<TDailyTaskReward>
      {
         return this.FRewardsVect;
      }
      
      public function get Level1() : int
      {
         return this.FLevel1;
      }
      
      public function get Mark() : int
      {
         return this.FMark;
      }
      
      public function get Rewards() : String
      {
         return this.FRewards;
      }
   }
}

