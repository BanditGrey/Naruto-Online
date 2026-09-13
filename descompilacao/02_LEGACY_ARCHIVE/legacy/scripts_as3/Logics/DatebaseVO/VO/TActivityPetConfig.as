package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import Logics.DatebaseVO.VO.Json.TAddValue;
   import flash.utils.ByteArray;
   import ghostcat.util.data.Json;
   
   use namespace ResourcesSpace;
   
   public class TActivityPetConfig extends TDatebaseVO
   {
      
      protected var FTitle:String;
      
      protected var FTitleDesc:String;
      
      protected var FTitleType:uint;
      
      protected var FVipLv:uint;
      
      protected var FUsrLv:uint;
      
      protected var FTime:String;
      
      protected var FType:uint;
      
      protected var FImageId:uint;
      
      protected var FAddValue:String;
      
      protected var FTitle2Desc:String;
      
      protected var FTitle3Desc:String;
      
      protected var FAddValues:Vector.<TAddValue>;
      
      protected var FLastTime:Vector.<uint>;
      
      public function TActivityPetConfig()
      {
         super();
         this.FAddValues = new Vector.<TAddValue>();
         this.FLastTime = new Vector.<uint>();
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
         TUtilityString.FlushUTF(param1,this.FTitle);
         TUtilityString.FlushUTF(param1,this.FTitleDesc);
         param1.writeUnsignedInt(this.FVipLv);
         param1.writeUnsignedInt(this.FUsrLv);
         TUtilityString.FlushUTF(param1,this.FTime);
         param1.writeUnsignedInt(this.FType);
         param1.writeUnsignedInt(this.FImageId);
         TUtilityString.FlushUTF(param1,this.FAddValue);
         TUtilityString.FlushUTF(param1,this.FTitle2Desc);
         TUtilityString.FlushUTF(param1,this.FTitle3Desc);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:TAddValue = null;
         this.FTitle = TUtilityString.FetchUTF(param1);
         this.FTitleDesc = TUtilityString.FetchUTF(param1);
         this.FVipLv = param1.readUnsignedInt();
         this.FUsrLv = param1.readUnsignedInt();
         this.FTime = TUtilityString.FetchUTF(param1);
         _loc2_ = Json.decode(this.FTime) as Array;
         if(_loc2_ != null)
         {
            _loc4_ = _loc2_.length;
            _loc3_ = 0;
            while(_loc3_ < _loc4_)
            {
               this.FLastTime[_loc3_] = _loc2_[_loc3_];
               _loc3_++;
            }
         }
         this.FType = param1.readUnsignedInt();
         this.FImageId = param1.readUnsignedInt();
         this.FAddValue = TUtilityString.FetchUTF(param1);
         _loc2_ = Json.decode(this.FAddValue) as Array;
         _loc4_ = _loc2_.length;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc5_ = new TAddValue(_loc2_[_loc3_]);
            this.FAddValues[_loc3_] = _loc5_;
            _loc3_++;
         }
         this.FTitle2Desc = TUtilityString.FetchUTF(param1);
         this.FTitle3Desc = TUtilityString.FetchUTF(param1);
      }
      
      public function get Title() : String
      {
         return this.FTitle;
      }
      
      public function get TitleDesc() : String
      {
         return this.FTitleDesc;
      }
      
      public function get VipLv() : uint
      {
         return this.FVipLv;
      }
      
      public function get UsrLv() : uint
      {
         return this.FUsrLv;
      }
      
      public function get Time() : String
      {
         return this.FTime;
      }
      
      public function get Type() : uint
      {
         return this.FType;
      }
      
      public function get ImageId() : uint
      {
         return this.FImageId;
      }
      
      public function get AddValue() : String
      {
         return this.FAddValue;
      }
      
      public function get AddValues() : Vector.<TAddValue>
      {
         return this.FAddValues;
      }
      
      public function get LastTime() : Vector.<uint>
      {
         return this.FLastTime;
      }
      
      public function get TitleType() : uint
      {
         return this.FTitleType;
      }
      
      public function set TitleType(param1:uint) : void
      {
         this.FTitleType = param1;
      }
      
      public function get Title2Desc() : String
      {
         return this.FTitle2Desc;
      }
      
      public function get Title3Desc() : String
      {
         return this.FTitle3Desc;
      }
   }
}

