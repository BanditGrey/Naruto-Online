package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.*;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import flash.utils.ByteArray;
   import ghostcat.util.data.Json;
   
   use namespace ResourcesSpace;
   
   public class TNarutoRoadTask extends TDatebaseVO
   {
      
      protected var FType:int;
      
      protected var FName:String;
      
      protected var FTaskTarget:String;
      
      protected var FDescription:String;
      
      protected var FTaskLocked:String;
      
      protected var FPicture:uint;
      
      protected var FAccept:int;
      
      protected var FRewards:String;
      
      protected var FRewardsVip:String;
      
      protected var FIsgoto:int;
      
      protected var FIsPopTip:int;
      
      protected var FRewardLevel:uint;
      
      protected var FRewardsVect:Array;
      
      protected var FRewardVipLevel:uint;
      
      protected var FRewardsVipVect:Array;
      
      protected var FVipLimit:int;
      
      public function TNarutoRoadTask()
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
         param1.writeUnsignedInt(this.FType);
         TUtilityString.FlushUTF(param1,this.FName);
         TUtilityString.FlushUTF(param1,this.FTaskTarget);
         TUtilityString.FlushUTF(param1,this.FDescription);
         TUtilityString.FlushUTF(param1,this.FTaskLocked);
         param1.writeUnsignedInt(this.FPicture);
         param1.writeUnsignedInt(this.FAccept);
         TUtilityString.FlushUTF(param1,this.FRewards);
         TUtilityString.FlushUTF(param1,this.FRewardsVip);
         param1.writeUnsignedInt(this.FIsgoto);
         param1.writeUnsignedInt(this.FIsPopTip);
         param1.writeUnsignedInt(this.FVipLimit);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         var _loc2_:Array = null;
         this.FType = param1.readUnsignedInt();
         this.FName = TUtilityString.FetchUTF(param1);
         this.FTaskTarget = TUtilityString.FetchUTF(param1);
         this.FDescription = TUtilityString.FetchUTF(param1);
         this.FTaskLocked = TUtilityString.FetchUTF(param1);
         this.FPicture = param1.readUnsignedInt();
         this.FAccept = param1.readUnsignedInt();
         this.FRewards = TUtilityString.FetchUTF(param1);
         this.FRewardsVip = TUtilityString.FetchUTF(param1);
         this.FIsgoto = param1.readUnsignedInt();
         this.FIsPopTip = param1.readUnsignedInt();
         _loc2_ = Json.decode(this.FRewards);
         this.FRewardLevel = _loc2_[0];
         this.FRewardsVect = _loc2_[1];
         _loc2_ = Json.decode(this.FRewardsVip);
         this.FRewardVipLevel = _loc2_[0];
         this.FRewardsVipVect = _loc2_[1];
         this.FVipLimit = param1.readUnsignedInt();
      }
      
      public function get Type() : int
      {
         return this.FType;
      }
      
      public function get Name() : String
      {
         return this.FName;
      }
      
      public function get TaskTarget() : String
      {
         return this.FTaskTarget;
      }
      
      public function get Description() : String
      {
         return this.FDescription;
      }
      
      public function get TaskLocked() : String
      {
         return this.FTaskLocked;
      }
      
      public function get Picture() : uint
      {
         return this.FPicture;
      }
      
      public function get Accept() : int
      {
         return this.FAccept;
      }
      
      public function get Rewards() : String
      {
         return this.FRewards;
      }
      
      public function get RewardsVip() : String
      {
         return this.FRewardsVip;
      }
      
      public function get Isgoto() : int
      {
         return this.FIsgoto;
      }
      
      public function get IsPopTip() : int
      {
         return this.FIsPopTip;
      }
      
      public function get RewardLevel() : int
      {
         return this.FRewardLevel;
      }
      
      public function get RewardsVect() : Array
      {
         return this.FRewardsVect;
      }
      
      public function get RewardVipLevel() : int
      {
         return this.FRewardVipLevel;
      }
      
      public function get RewardsVipVect() : Array
      {
         return this.FRewardsVipVect;
      }
      
      public function get VipLimit() : int
      {
         return this.FVipLimit;
      }
   }
}

