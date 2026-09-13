package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.*;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import flash.utils.ByteArray;
   import ghostcat.util.data.Json;
   
   use namespace ResourcesSpace;
   
   public class TNarutoRoadPackage extends TDatebaseVO
   {
      
      protected var FName:String;
      
      protected var FAccept:String;
      
      protected var FRewardName:String;
      
      protected var FReward:String;
      
      protected var FRewardNumber:String;
      
      protected var FVipLimit:String;
      
      protected var FRewardDiscount:String;
      
      protected var FRewardOriginal:String;
      
      protected var FRewardPrice:String;
      
      protected var FOpenLevel:uint;
      
      protected var FEndLevel:uint;
      
      protected var FBoxNameVect:Vector.<String>;
      
      protected var FRewardVect:Vector.<Array>;
      
      protected var FRewardNumberVect:Vector.<uint>;
      
      protected var FVipLimitVect:Vector.<uint>;
      
      protected var FRewardDiscountVect:Vector.<uint>;
      
      protected var FRewardOriginalVect:Vector.<uint>;
      
      protected var FRewardPriceVect:Vector.<uint>;
      
      public function TNarutoRoadPackage()
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
         TUtilityString.FlushUTF(param1,this.FAccept);
         TUtilityString.FlushUTF(param1,this.FRewardName);
         TUtilityString.FlushUTF(param1,this.FReward);
         TUtilityString.FlushUTF(param1,this.FRewardNumber);
         TUtilityString.FlushUTF(param1,this.FVipLimit);
         TUtilityString.FlushUTF(param1,this.FRewardDiscount);
         TUtilityString.FlushUTF(param1,this.FRewardOriginal);
         TUtilityString.FlushUTF(param1,this.FRewardPrice);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         var _loc2_:Array = null;
         this.FName = TUtilityString.FetchUTF(param1);
         this.FAccept = TUtilityString.FetchUTF(param1);
         this.FRewardName = TUtilityString.FetchUTF(param1);
         this.FReward = TUtilityString.FetchUTF(param1);
         this.FRewardNumber = TUtilityString.FetchUTF(param1);
         this.FVipLimit = TUtilityString.FetchUTF(param1);
         this.FRewardDiscount = TUtilityString.FetchUTF(param1);
         this.FRewardOriginal = TUtilityString.FetchUTF(param1);
         this.FRewardPrice = TUtilityString.FetchUTF(param1);
         _loc2_ = Json.decode(this.FAccept);
         this.FOpenLevel = _loc2_[0];
         this.FEndLevel = _loc2_[1];
         _loc2_ = Json.decode(this.FRewardName);
         this.FBoxNameVect = Vector.<String>(_loc2_);
         _loc2_ = Json.decode(this.FReward);
         this.FRewardVect = Vector.<Array>(_loc2_);
         _loc2_ = Json.decode(this.FRewardNumber);
         this.FRewardNumberVect = Vector.<uint>(_loc2_);
         _loc2_ = Json.decode(this.FVipLimit);
         this.FVipLimitVect = Vector.<uint>(_loc2_);
         _loc2_ = Json.decode(this.FRewardDiscount);
         this.FRewardDiscountVect = Vector.<uint>(_loc2_);
         _loc2_ = Json.decode(this.FRewardOriginal);
         this.FRewardOriginalVect = Vector.<uint>(_loc2_);
         _loc2_ = Json.decode(this.FRewardPrice);
         this.FRewardPriceVect = Vector.<uint>(_loc2_);
      }
      
      public function get Name() : String
      {
         return this.FName;
      }
      
      public function get Accept() : String
      {
         return this.FAccept;
      }
      
      public function get RewardName() : String
      {
         return this.FRewardName;
      }
      
      public function get Reward() : String
      {
         return this.FReward;
      }
      
      public function get RewardNumber() : String
      {
         return this.FRewardNumber;
      }
      
      public function get VipLimit() : String
      {
         return this.FVipLimit;
      }
      
      public function get RewardDiscount() : String
      {
         return this.FRewardDiscount;
      }
      
      public function get RewardOriginal() : String
      {
         return this.FRewardOriginal;
      }
      
      public function get RewardPrice() : String
      {
         return this.FRewardPrice;
      }
      
      public function get OpenLevel() : uint
      {
         return this.FOpenLevel;
      }
      
      public function get EndLevel() : uint
      {
         return this.FEndLevel;
      }
      
      public function get BoxNameVect() : Vector.<String>
      {
         return this.FBoxNameVect;
      }
      
      public function get RewardVect() : Vector.<Array>
      {
         return this.FRewardVect;
      }
      
      public function get RewardNumberVect() : Vector.<uint>
      {
         return this.FRewardNumberVect;
      }
      
      public function get VipLimitVect() : Vector.<uint>
      {
         return this.FVipLimitVect;
      }
      
      public function get RewardDiscountVect() : Vector.<uint>
      {
         return this.FRewardDiscountVect;
      }
      
      public function get RewardOriginalVect() : Vector.<uint>
      {
         return this.FRewardOriginalVect;
      }
      
      public function get RewardPriceVect() : Vector.<uint>
      {
         return this.FRewardPriceVect;
      }
   }
}

