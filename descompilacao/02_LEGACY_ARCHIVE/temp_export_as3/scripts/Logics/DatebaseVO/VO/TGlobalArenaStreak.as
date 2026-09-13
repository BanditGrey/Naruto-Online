package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import flash.utils.ByteArray;
   import ghostcat.util.data.Json;
   
   use namespace ResourcesSpace;
   
   public class TGlobalArenaStreak extends TDatebaseVO
   {
      
      protected var FRewards:String;
      
      protected var FRewards1:String;
      
      protected var FRewards1Arr:Array;
      
      protected var FRewardArr:Array;
      
      protected var FFrom:int;
      
      protected var FLevel:String;
      
      protected var FLimit:int;
      
      public function TGlobalArenaStreak()
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
         TUtilityString.FlushUTF(param1,this.FLevel);
         param1.writeUnsignedInt(this.FFrom);
         TUtilityString.FlushUTF(param1,this.FRewards);
         TUtilityString.FlushUTF(param1,this.FRewards1);
         param1.writeUnsignedInt(this.FLimit);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         this.FLevel = TUtilityString.FetchUTF(param1);
         this.FFrom = param1.readUnsignedInt();
         this.FRewards = TUtilityString.FetchUTF(param1);
         this.FRewardArr = Json.decode(this.FRewards);
         this.FRewards1 = TUtilityString.FetchUTF(param1);
         this.FRewards1Arr = Json.decode(this.FRewards1);
         this.FLimit = param1.readUnsignedInt();
      }
      
      public function get From() : int
      {
         return this.FFrom;
      }
      
      public function get Rewards() : String
      {
         return this.FRewards;
      }
      
      public function get RewardArr() : Array
      {
         return this.FRewardArr;
      }
      
      public function get Rewards1() : String
      {
         return this.FRewards1;
      }
      
      public function get Rewards1Arr() : Array
      {
         return this.FRewards1Arr;
      }
      
      public function get Limit() : int
      {
         return this.FLimit;
      }
      
      public function get Level() : String
      {
         return this.FLevel;
      }
   }
}

