package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import Logics.DatebaseVO.VO.Json.TTaskReward;
   import flash.utils.ByteArray;
   import ghostcat.util.data.Json;
   
   use namespace ResourcesSpace;
   
   public class TNinjafeed extends TDatebaseVO
   {
      
      protected var FName:String;
      
      protected var FBigType:int;
      
      protected var FSmallType:int;
      
      protected var FDesc1:String;
      
      protected var FActAward1:String;
      
      protected var FClientAward1:String;
      
      protected var FDayTime:String;
      
      protected var FIsOn:int;
      
      protected var FInviteNum:int;
      
      protected var FNumAcun:int;
      
      protected var FInviteAward:Vector.<TTaskReward>;
      
      public function TNinjafeed()
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
         param1.writeUnsignedInt(this.FBigType);
         param1.writeUnsignedInt(this.FSmallType);
         TUtilityString.FlushUTF(param1,this.FDesc1);
         TUtilityString.FlushUTF(param1,this.FActAward1);
         TUtilityString.FlushUTF(param1,this.FClientAward1);
         TUtilityString.FlushUTF(param1,this.FDayTime);
         param1.writeUnsignedInt(this.FIsOn);
         param1.writeUnsignedInt(this.FInviteNum);
         param1.writeUnsignedInt(this.FNumAcun);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:TTaskReward = null;
         this.FName = TUtilityString.FetchUTF(param1);
         this.FBigType = param1.readUnsignedInt();
         this.FSmallType = param1.readUnsignedInt();
         this.FDesc1 = TUtilityString.FetchUTF(param1);
         this.FActAward1 = TUtilityString.FetchUTF(param1);
         this.FClientAward1 = TUtilityString.FetchUTF(param1);
         _loc2_ = Json.decode(this.FClientAward1) as Array;
         if(_loc2_ != null)
         {
            _loc4_ = _loc2_.length;
            this.FInviteAward = new Vector.<TTaskReward>(_loc4_);
            _loc3_ = 0;
            while(_loc3_ < _loc4_)
            {
               _loc5_ = new TTaskReward(_loc2_[_loc3_]);
               this.FInviteAward[_loc3_] = _loc5_;
               _loc3_++;
            }
         }
         this.FDayTime = TUtilityString.FetchUTF(param1);
         this.FIsOn = param1.readUnsignedInt();
         this.FInviteNum = param1.readUnsignedInt();
         this.FNumAcun = param1.readUnsignedInt();
      }
      
      public function get Name() : String
      {
         return this.FName;
      }
      
      public function set Name(param1:String) : void
      {
         this.FName = param1;
      }
      
      public function get BigType() : int
      {
         return this.FBigType;
      }
      
      public function set BigType(param1:int) : void
      {
         this.FBigType = param1;
      }
      
      public function get SmallType() : int
      {
         return this.FSmallType;
      }
      
      public function set SmallType(param1:int) : void
      {
         this.FSmallType = param1;
      }
      
      public function get Desc1() : String
      {
         return this.FDesc1;
      }
      
      public function set Desc1(param1:String) : void
      {
         this.FDesc1 = param1;
      }
      
      public function get ActAward1() : String
      {
         return this.FActAward1;
      }
      
      public function set ActAward1(param1:String) : void
      {
         this.FActAward1 = param1;
      }
      
      public function get ClientAward1() : String
      {
         return this.FClientAward1;
      }
      
      public function set ClientAward1(param1:String) : void
      {
         this.FClientAward1 = param1;
      }
      
      public function get DayTime() : String
      {
         return this.FDayTime;
      }
      
      public function set DayTime(param1:String) : void
      {
         this.FDayTime = param1;
      }
      
      public function get IsOn() : int
      {
         return this.FIsOn;
      }
      
      public function set IsOn(param1:int) : void
      {
         this.FIsOn = param1;
      }
      
      public function get InviteNum() : int
      {
         return this.FInviteNum;
      }
      
      public function set InviteNum(param1:int) : void
      {
         this.FInviteNum = param1;
      }
      
      public function get NumAcun() : int
      {
         return this.FNumAcun;
      }
      
      public function set NumAcun(param1:int) : void
      {
         this.FNumAcun = param1;
      }
      
      public function get InviteAward() : Vector.<TTaskReward>
      {
         return this.FInviteAward;
      }
      
      public function set InviteAward(param1:Vector.<TTaskReward>) : void
      {
         this.FInviteAward = param1;
      }
   }
}

