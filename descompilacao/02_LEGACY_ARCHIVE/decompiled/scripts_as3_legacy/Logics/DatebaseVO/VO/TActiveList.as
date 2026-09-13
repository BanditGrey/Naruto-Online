package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.*;
   import Foundation.Utilities.*;
   import Logics.DatebaseVO.*;
   import Logics.DatebaseVO.VO.Json.*;
   import flash.utils.*;
   import ghostcat.util.data.*;
   
   use namespace ResourcesSpace;
   
   public class TActiveList extends TDatebaseVO
   {
      
      protected var FClientAwardVect:Vector.<uint>;
      
      protected var FTips:TActiveListTips;
      
      protected var FPrice:uint;
      
      protected var FConditionVect:TActiveListCondition;
      
      protected var FLvLimit:uint;
      
      protected var FIsOn:Boolean;
      
      protected var FType:uint;
      
      protected var FAddAwardNum:uint;
      
      protected var FGetType:uint;
      
      protected var FSort:uint;
      
      protected var FDayTimeVect:Vector.<Object>;
      
      protected var FClientAward:String;
      
      protected var FTip:String;
      
      protected var FCondition:String;
      
      protected var FDayTime:String;
      
      public function TActiveList()
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
         TUtilityString.FlushUTF(param1,this.FClientAward);
         TUtilityString.FlushUTF(param1,this.FTip);
         param1.writeUnsignedInt(this.FPrice);
         TUtilityString.FlushUTF(param1,this.FCondition);
         param1.writeUnsignedInt(this.FLvLimit);
         param1.writeUnsignedInt(int(this.FIsOn));
         param1.writeUnsignedInt(this.FType);
         param1.writeUnsignedInt(this.FAddAwardNum);
         param1.writeUnsignedInt(this.FGetType);
         param1.writeUnsignedInt(this.FSort);
         TUtilityString.FlushUTF(param1,this.FDayTime);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:Array = null;
         this.FClientAward = TUtilityString.FetchUTF(param1);
         _loc5_ = Json.decode(this.FClientAward);
         _loc3_ = int(_loc5_.length);
         this.FClientAwardVect = new Vector.<uint>(_loc3_);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            this.FClientAwardVect[_loc2_] = _loc5_[_loc2_];
            _loc2_++;
         }
         this.FTip = TUtilityString.FetchUTF(param1);
         _loc5_ = Json.decode(this.FTip);
         this.FTips = new TActiveListTips(_loc5_);
         this.FPrice = param1.readUnsignedInt();
         this.FCondition = TUtilityString.FetchUTF(param1);
         this.FConditionVect = new TActiveListCondition(Json.decode(this.FCondition));
         this.FLvLimit = param1.readUnsignedInt();
         this.FIsOn = Boolean(param1.readUnsignedInt());
         this.FType = param1.readUnsignedInt();
         this.FAddAwardNum = param1.readUnsignedInt();
         this.FGetType = param1.readUnsignedInt();
         this.FSort = param1.readUnsignedInt();
         this.FDayTime = TUtilityString.FetchUTF(param1);
         _loc5_ = Json.decode(this.FDayTime);
         _loc3_ = int(_loc5_.length);
         this.FDayTimeVect = new Vector.<Object>(_loc3_);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            this.FDayTimeVect[_loc2_] = _loc5_[_loc2_];
            _loc2_++;
         }
      }
      
      public function get ClientAwardVect() : Vector.<uint>
      {
         return this.FClientAwardVect;
      }
      
      public function get Tips() : TActiveListTips
      {
         return this.FTips;
      }
      
      public function get Price() : uint
      {
         return this.FPrice;
      }
      
      public function get ConditionVect() : TActiveListCondition
      {
         return this.FConditionVect;
      }
      
      public function get LvLimit() : uint
      {
         return this.FLvLimit;
      }
      
      public function get IsOn() : Boolean
      {
         return this.FIsOn;
      }
      
      public function get Type() : uint
      {
         return this.FType;
      }
      
      public function get AddAwardNum() : uint
      {
         return this.FAddAwardNum;
      }
      
      public function get GetType() : uint
      {
         return this.FGetType;
      }
      
      public function get Sort() : uint
      {
         return this.FSort;
      }
      
      public function get Tip() : String
      {
         return this.FTip;
      }
      
      public function get ClientAward() : String
      {
         return this.FClientAward;
      }
      
      public function get Condition() : String
      {
         return this.FCondition;
      }
      
      public function get DayTime() : String
      {
         return this.FDayTime;
      }
      
      public function get DayTimeVect() : Vector.<Object>
      {
         return this.FDayTimeVect;
      }
   }
}

