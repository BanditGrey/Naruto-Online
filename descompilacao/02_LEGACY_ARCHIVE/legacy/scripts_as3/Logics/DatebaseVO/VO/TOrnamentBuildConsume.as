package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import flash.utils.ByteArray;
   
   use namespace ResourcesSpace;
   
   public class TOrnamentBuildConsume extends TDatebaseVO
   {
      
      protected var FItemId:String;
      
      protected var FCostItems:String;
      
      protected var FAddValue:int;
      
      protected var FAccessoryId:uint;
      
      protected var FAccessoryLevel:uint;
      
      protected var FItemsArr:Array;
      
      public function TOrnamentBuildConsume()
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
         TUtilityString.FlushUTF(param1,this.FItemId);
         TUtilityString.FlushUTF(param1,this.FCostItems);
         param1.writeUnsignedInt(this.FAddValue);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         this.FItemId = TUtilityString.FetchUTF(param1);
         this.FCostItems = TUtilityString.FetchUTF(param1);
         this.FAddValue = param1.readUnsignedInt();
      }
      
      public function get ItemId() : String
      {
         return this.FItemId;
      }
      
      public function get CostItems() : String
      {
         return this.FCostItems;
      }
      
      public function get AddValue() : int
      {
         return this.FAddValue;
      }
      
      public function get ItemsArr() : Array
      {
         var _loc1_:int = 0;
         var _loc2_:Array = null;
         var _loc3_:String = null;
         if(this.FItemsArr == null)
         {
            this.FItemsArr = new Array();
            _loc2_ = this.FCostItems.split("|");
            _loc1_ = 0;
            while(_loc1_ < _loc2_.length)
            {
               _loc3_ = _loc2_[_loc1_] as String;
               this.FItemsArr.push(_loc3_.split("_"));
               _loc1_++;
            }
         }
         _loc3_ = null;
         if(_loc2_)
         {
            _loc2_.length = 0;
            _loc2_ = null;
         }
         return this.FItemsArr;
      }
      
      public function get AccessoryId() : uint
      {
         if(this.FAccessoryId == 0)
         {
            this.FAccessoryId = this.FItemId.split(":")[0];
         }
         return this.FAccessoryId;
      }
      
      public function get AccessoryLevel() : uint
      {
         if(this.FAccessoryLevel == 0)
         {
            this.FAccessoryLevel = this.FItemId.split(":")[1];
         }
         return this.FAccessoryLevel;
      }
   }
}

