package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import Processors.Game.Lobby.LostShenqi.TJieXiObject;
   import flash.utils.ByteArray;
   import ghostcat.util.data.Json;
   
   use namespace ResourcesSpace;
   
   public class TLostsacredUpgrade extends TDatebaseVO
   {
      
      protected var FItemid:uint;
      
      protected var FLevel:uint;
      
      protected var FCostItemCount:uint;
      
      protected var FCostlostItemCount:uint;
      
      protected var FAddValue:uint;
      
      protected var FCategory:uint;
      
      protected var FValue:uint;
      
      protected var FPercentage:uint;
      
      protected var FPercentType:uint;
      
      protected var FAddextraValueclient:String;
      
      protected var FAddextraValueArray:Array;
      
      protected var FAddextraValue:String;
      
      protected var FCostsheart:String;
      
      protected var INDEX_Category:uint = 0;
      
      protected var INDEX_VALUE:uint = 1;
      
      protected var INDEX_PERCENT:uint = 2;
      
      protected var INDEX_Divisor:uint = 3;
      
      protected var FJieXiObject:TJieXiObject;
      
      public function TLostsacredUpgrade()
      {
         super();
      }
      
      public function get Itemid() : uint
      {
         return this.FItemid;
      }
      
      public function get Level() : uint
      {
         return this.FLevel;
      }
      
      public function get CostItemCount() : uint
      {
         return this.FCostItemCount;
      }
      
      public function get CostlostItemCount() : uint
      {
         return this.FCostlostItemCount;
      }
      
      public function get AddValue() : uint
      {
         return this.FAddValue;
      }
      
      public function get AddextraValueclient() : String
      {
         return this.FAddextraValueclient;
      }
      
      public function get JieXiObject() : TJieXiObject
      {
         return this.FJieXiObject;
      }
      
      public function get AddextraValueArray() : Array
      {
         return this.FAddextraValueArray;
      }
      
      public function get AddextraValue() : String
      {
         return this.FAddextraValue;
      }
      
      public function get Category() : uint
      {
         return this.FCategory;
      }
      
      public function get Value() : uint
      {
         return this.FValue;
      }
      
      public function get Percentage() : uint
      {
         return this.FPercentage;
      }
      
      public function get PercentType() : uint
      {
         return this.FPercentType;
      }
      
      public function get Costsheart() : String
      {
         return this.FCostsheart;
      }
      
      override ResourcesSpace function WriteDataToStream(param1:ByteArray) : void
      {
         param1.writeUnsignedInt(FIdentifier);
         param1.writeUnsignedInt(this.FItemid);
         param1.writeUnsignedInt(this.FLevel);
         param1.writeUnsignedInt(this.FCostItemCount);
         param1.writeUnsignedInt(this.FCostlostItemCount);
         param1.writeUnsignedInt(this.FAddValue);
         TUtilityString.FlushUTF(param1,this.FAddextraValue);
         TUtilityString.FlushUTF(param1,this.FAddextraValueclient);
         TUtilityString.FlushUTF(param1,this.FCostsheart);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         var _loc2_:Object = null;
         var _loc3_:Array = null;
         this.FItemid = param1.readUnsignedInt();
         this.FLevel = param1.readUnsignedInt();
         this.FCostItemCount = param1.readUnsignedInt();
         this.FCostlostItemCount = param1.readUnsignedInt();
         this.FAddValue = param1.readUnsignedInt();
         this.FAddextraValue = TUtilityString.FetchUTF(param1);
         _loc2_ = Json.decode(this.FAddextraValue);
         if(_loc2_)
         {
            _loc3_ = String(_loc2_.typeEffect).split("_");
            this.FCategory = _loc3_[this.INDEX_Category];
            this.FValue = _loc3_[this.INDEX_VALUE];
            this.FPercentage = _loc3_[this.INDEX_PERCENT];
            this.FPercentType = _loc3_[this.INDEX_Divisor];
         }
         else
         {
            this.FCategory = 0;
            this.FValue = 0;
            this.FPercentage = 0;
            this.FPercentType = 0;
         }
         this.FAddextraValueclient = TUtilityString.FetchUTF(param1);
         if(this.FAddextraValueclient != "")
         {
            _loc2_ = Json.decode(this.FAddextraValueclient);
            this.FAddextraValueArray = _loc2_ as Array;
            this.FJieXiObject = new TJieXiObject(this.FAddextraValueArray);
         }
         else
         {
            this.FAddextraValueArray = null;
            this.FJieXiObject = null;
         }
         this.FCostsheart = TUtilityString.FetchUTF(param1);
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

