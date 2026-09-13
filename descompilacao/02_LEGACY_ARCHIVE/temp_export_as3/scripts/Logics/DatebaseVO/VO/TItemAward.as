package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import flash.utils.ByteArray;
   import ghostcat.util.data.Json;
   
   use namespace ResourcesSpace;
   
   public class TItemAward extends TDatebaseVO
   {
      
      protected var FSperewards:String;
      
      protected var FSperewardArr:Array;
      
      protected var FRewardNum:int;
      
      public function TItemAward()
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
         TUtilityString.FlushUTF(param1,this.FSperewards);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Object = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         _loc5_ = TUtilityString.FetchUTF(param1);
         _loc4_ = Json.decode(_loc5_);
         var _loc7_:int = 0;
         var _loc8_:* = _loc4_;
         for(_loc6_ in _loc8_)
         {
            this.FSperewardArr = _loc4_[_loc6_];
            this.FRewardNum = int(_loc6_);
         }
      }
      
      public function get SperewardArr() : Array
      {
         return this.FSperewardArr;
      }
      
      public function get Sperewards() : String
      {
         return this.FSperewards;
      }
      
      public function get RewardNum() : int
      {
         return this.FRewardNum;
      }
   }
}

