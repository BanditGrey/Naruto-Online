package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.*;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.*;
   import flash.utils.*;
   import ghostcat.util.data.Json;
   
   use namespace ResourcesSpace;
   
   public class TNightPowerPrivilege extends TDatebaseVO
   {
      
      protected var FName:String;
      
      protected var FDescription:String;
      
      protected var FPrice:int;
      
      protected var FNeedlevel:int;
      
      protected var FIcon:int;
      
      protected var FIsHold:int;
      
      protected var FQuickLinks:int;
      
      protected var FDescPrivilege:String;
      
      protected var FType:String;
      
      protected var FTypeValueArr:Array;
      
      protected var FAddAttr:String;
      
      protected var FAddAttrArr:Array;
      
      public function TNightPowerPrivilege()
      {
         super();
      }
      
      override ResourcesSpace function WriteDataToStream(param1:ByteArray) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         param1.writeUnsignedInt(FIdentifier);
         TUtilityString.FlushUTF(param1,this.FName);
         TUtilityString.FlushUTF(param1,this.FDescription);
         param1.writeUnsignedInt(this.FPrice);
         param1.writeUnsignedInt(this.FNeedlevel);
         param1.writeUnsignedInt(this.FIcon);
         param1.writeUnsignedInt(this.FIsHold);
         param1.writeUnsignedInt(this.FQuickLinks);
         TUtilityString.FlushUTF(param1,this.FType);
         TUtilityString.FlushUTF(param1,this.FAddAttr);
         TUtilityString.FlushUTF(param1,this.FDescPrivilege);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         this.FName = TUtilityString.FetchUTF(param1);
         this.FDescription = TUtilityString.FetchUTF(param1);
         this.FPrice = param1.readUnsignedInt();
         this.FNeedlevel = param1.readUnsignedInt();
         this.FIcon = param1.readUnsignedInt();
         this.FIsHold = param1.readUnsignedInt();
         this.FQuickLinks = param1.readUnsignedInt();
         this.FType = TUtilityString.FetchUTF(param1);
         this.FTypeValueArr = Json.decode(this.FType);
         this.FAddAttr = TUtilityString.FetchUTF(param1);
         this.FDescPrivilege = TUtilityString.FetchUTF(param1);
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
      
      public function get Name() : String
      {
         return this.FName;
      }
      
      public function get Description() : String
      {
         return this.FDescription;
      }
      
      public function get Price() : int
      {
         return this.FPrice;
      }
      
      public function get Needlevel() : int
      {
         return this.FNeedlevel;
      }
      
      public function get Icon() : int
      {
         return this.FIcon;
      }
      
      public function get IsHold() : int
      {
         return this.FIsHold;
      }
      
      public function get QuickLinks() : int
      {
         return this.FQuickLinks;
      }
      
      public function get Type() : String
      {
         return this.FType;
      }
      
      public function get AddAttr() : String
      {
         return this.FAddAttr;
      }
      
      public function get DescPrivilege() : String
      {
         return this.FDescPrivilege;
      }
      
      public function get TypeValueArr() : Array
      {
         return this.FTypeValueArr;
      }
   }
}

