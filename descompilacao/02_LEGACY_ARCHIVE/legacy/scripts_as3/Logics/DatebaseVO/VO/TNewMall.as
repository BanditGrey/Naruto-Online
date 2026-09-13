package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.*;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.*;
   import flash.utils.*;
   import ghostcat.util.data.Json;
   
   use namespace ResourcesSpace;
   
   public class TNewMall extends TDatebaseVO
   {
      
      protected var FType:int;
      
      protected var FName:String;
      
      protected var FItemid:int;
      
      protected var FAmount:int;
      
      protected var FCurrencytype:int;
      
      protected var FPrice:int;
      
      protected var FOriginalPrice:int;
      
      protected var FVipPrice:int;
      
      protected var FIsHot:int;
      
      protected var FSort:int;
      
      protected var FCondition:String;
      
      protected var FConditionArr:Array;
      
      protected var FBuyLimit:String;
      
      protected var FBuyLimitArr:Array;
      
      protected var FTitle:int;
      
      protected var FLimitDisplay:int;
      
      protected var FIsSpecialEffects:int;
      
      protected var FDisplayType:int;
      
      protected var FDisplayValue:String;
      
      protected var FDisplayValueArray:Array;
      
      protected var FHeroid:int;
      
      public function TNewMall()
      {
         super();
      }
      
      override ResourcesSpace function WriteDataToStream(param1:ByteArray) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         param1.writeUnsignedInt(FIdentifier);
         param1.writeUnsignedInt(this.FType);
         TUtilityString.FlushUTF(param1,this.FName);
         param1.writeUnsignedInt(this.FItemid);
         param1.writeUnsignedInt(this.FAmount);
         param1.writeUnsignedInt(this.FCurrencytype);
         param1.writeUnsignedInt(this.FPrice);
         param1.writeUnsignedInt(this.FOriginalPrice);
         param1.writeUnsignedInt(this.FVipPrice);
         param1.writeUnsignedInt(this.FIsHot);
         param1.writeUnsignedInt(this.FSort);
         TUtilityString.FlushUTF(param1,this.FCondition);
         TUtilityString.FlushUTF(param1,this.FBuyLimit);
         param1.writeUnsignedInt(this.FTitle);
         param1.writeUnsignedInt(this.FLimitDisplay);
         param1.writeUnsignedInt(this.FIsSpecialEffects);
         param1.writeUnsignedInt(this.FDisplayType);
         param1.writeUnsignedInt(this.FHeroid);
         TUtilityString.FlushUTF(param1,this.FDisplayValue);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         this.FType = param1.readUnsignedInt();
         this.FName = TUtilityString.FetchUTF(param1);
         this.FItemid = param1.readUnsignedInt();
         this.FAmount = param1.readUnsignedInt();
         this.FCurrencytype = param1.readUnsignedInt();
         this.FPrice = param1.readUnsignedInt();
         this.FOriginalPrice = param1.readUnsignedInt();
         this.FVipPrice = param1.readUnsignedInt();
         this.FIsHot = param1.readUnsignedInt();
         this.FSort = param1.readUnsignedInt();
         this.FCondition = TUtilityString.FetchUTF(param1);
         this.FConditionArr = Json.decode(this.FCondition);
         this.FBuyLimit = TUtilityString.FetchUTF(param1);
         this.FBuyLimitArr = Json.decode(this.FBuyLimit);
         this.FTitle = param1.readUnsignedInt();
         this.FLimitDisplay = param1.readUnsignedInt();
         this.FIsSpecialEffects = param1.readUnsignedInt();
         this.FDisplayType = param1.readUnsignedInt();
         this.FHeroid = param1.readUnsignedInt();
         this.FDisplayValue = TUtilityString.FetchUTF(param1);
         this.FDisplayValueArray = Json.decode(this.FDisplayValue);
      }
      
      public function get DisplayValueArray() : Array
      {
         return this.FDisplayValueArray;
      }
      
      public function get DisplayValue() : String
      {
         return this.FDisplayValue;
      }
      
      public function get Heroid() : int
      {
         return this.FHeroid;
      }
      
      public function get DisplayType() : int
      {
         return this.FDisplayType;
      }
      
      public function get IsSpecialEffects() : int
      {
         return this.FIsSpecialEffects;
      }
      
      public function get LimitDisplay() : int
      {
         return this.FLimitDisplay;
      }
      
      public function get Title() : int
      {
         return this.FTitle;
      }
      
      public function get BuyLimit() : String
      {
         return this.FBuyLimit;
      }
      
      public function get BuyLimitArr() : Array
      {
         return this.FBuyLimitArr;
      }
      
      public function get Condition() : String
      {
         return this.FCondition;
      }
      
      public function get ConditionArr() : Array
      {
         return this.FConditionArr;
      }
      
      public function get Sort() : int
      {
         return this.FSort;
      }
      
      public function get IsHot() : int
      {
         return this.FIsHot;
      }
      
      public function get VipPrice() : int
      {
         return this.FVipPrice;
      }
      
      public function get OriginalPrice() : int
      {
         return this.FOriginalPrice;
      }
      
      public function get Price() : int
      {
         return this.FPrice;
      }
      
      public function get Currencytype() : int
      {
         return this.FCurrencytype;
      }
      
      public function get Amount() : int
      {
         return this.FAmount;
      }
      
      public function get Itemid() : int
      {
         return this.FItemid;
      }
      
      public function get Name() : String
      {
         return this.FName;
      }
      
      public function get Type() : int
      {
         return this.FType;
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
   }
}

