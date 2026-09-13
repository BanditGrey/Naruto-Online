package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import Logics.DatebaseVO.VO.Json.TFixedAward;
   import flash.utils.ByteArray;
   import ghostcat.util.data.Json;
   
   use namespace ResourcesSpace;
   
   public class TPlatformReward extends TDatebaseVO
   {
      
      protected var FActivityName:String;
      
      protected var FPlatformID:uint;
      
      protected var FType:uint;
      
      protected var FMember:uint;
      
      protected var FPrivilegeLevel:uint;
      
      protected var FReward:String;
      
      protected var FRewards:Vector.<TFixedAward>;
      
      public function TPlatformReward()
      {
         super();
         this.FRewards = new Vector.<TFixedAward>();
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
         TUtilityString.FlushUTF(param1,this.FActivityName);
         param1.writeUnsignedInt(this.FPlatformID);
         param1.writeUnsignedInt(this.FType);
         param1.writeUnsignedInt(this.FMember);
         param1.writeUnsignedInt(this.FPrivilegeLevel);
         TUtilityString.FlushUTF(param1,this.FReward);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:TFixedAward = null;
         this.FActivityName = TUtilityString.FetchUTF(param1);
         this.FPlatformID = param1.readUnsignedInt();
         this.FType = param1.readUnsignedInt();
         this.FMember = param1.readUnsignedInt();
         this.FPrivilegeLevel = param1.readUnsignedInt();
         this.FReward = TUtilityString.FetchUTF(param1);
         _loc2_ = Json.decode(this.FReward) as Array;
         _loc4_ = _loc2_.length;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc5_ = new TFixedAward(_loc2_[_loc3_]);
            this.FRewards.push(_loc5_);
            _loc3_++;
         }
      }
      
      public function get PlatformID() : uint
      {
         return this.FPlatformID;
      }
      
      public function set PlatformID(param1:uint) : void
      {
         this.FPlatformID = param1;
      }
      
      public function get Type() : uint
      {
         return this.FType;
      }
      
      public function set Type(param1:uint) : void
      {
         this.FType = param1;
      }
      
      public function get Member() : uint
      {
         return this.FMember;
      }
      
      public function set Member(param1:uint) : void
      {
         this.FMember = param1;
      }
      
      public function get PrivilegeLevel() : uint
      {
         return this.FPrivilegeLevel;
      }
      
      public function set PrivilegeLevel(param1:uint) : void
      {
         this.FPrivilegeLevel = param1;
      }
      
      public function get Reward() : String
      {
         return this.FReward;
      }
      
      public function set Reward(param1:String) : void
      {
         this.FReward = param1;
      }
      
      public function get Rewards() : Vector.<TFixedAward>
      {
         return this.FRewards;
      }
      
      public function set Rewards(param1:Vector.<TFixedAward>) : void
      {
         this.FRewards = param1;
      }
      
      public function get ActivityName() : String
      {
         return this.FActivityName;
      }
      
      public function set ActivityName(param1:String) : void
      {
         this.FActivityName = param1;
      }
   }
}

