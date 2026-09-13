package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import flash.utils.ByteArray;
   import ghostcat.util.data.Json;
   
   use namespace ResourcesSpace;
   
   public class TSevenHeroDailyAward extends TDatebaseVO
   {
      
      protected var FName:String;
      
      protected var FFreeCount:uint;
      
      protected var FRewards:String;
      
      protected var FCost:String;
      
      protected var FCrit:String;
      
      protected var FStarame:String;
      
      protected var FTips:String;
      
      protected var FRewardVect:Vector.<Object>;
      
      protected var FCostVect:Array;
      
      public function TSevenHeroDailyAward()
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
         TUtilityString.FlushUTF(param1,this.FName);
         param1.writeUnsignedInt(this.FFreeCount);
         TUtilityString.FlushUTF(param1,this.FRewards);
         TUtilityString.FlushUTF(param1,this.FCost);
         TUtilityString.FlushUTF(param1,this.FCrit);
         TUtilityString.FlushUTF(param1,this.FStarame);
         TUtilityString.FlushUTF(param1,this.FTips);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         var _loc2_:Object = null;
         var _loc3_:Object = null;
         this.FName = TUtilityString.FetchUTF(param1);
         this.FFreeCount = param1.readUnsignedInt();
         this.FRewards = TUtilityString.FetchUTF(param1);
         this.FCost = TUtilityString.FetchUTF(param1);
         this.FCrit = TUtilityString.FetchUTF(param1);
         this.FStarame = TUtilityString.FetchUTF(param1);
         this.FTips = TUtilityString.FetchUTF(param1);
         _loc2_ = Json.decode(this.FRewards);
         this.FRewardVect = Vector.<Object>(_loc2_);
         this.FCostVect = this.FCost.split(",") as Array;
      }
      
      public function get Name() : String
      {
         return this.FName;
      }
      
      public function get FreeCount() : uint
      {
         return this.FFreeCount;
      }
      
      public function get Rewards() : String
      {
         return this.FRewards;
      }
      
      public function get Cost() : String
      {
         return this.FCost;
      }
      
      public function get Crit() : String
      {
         return this.FCrit;
      }
      
      public function get Starame() : String
      {
         return this.FStarame;
      }
      
      public function get Tips() : String
      {
         return this.FTips;
      }
      
      public function get RewardVect() : Vector.<Object>
      {
         return this.FRewardVect;
      }
      
      public function get CostVect() : Array
      {
         return this.FCostVect;
      }
   }
}

