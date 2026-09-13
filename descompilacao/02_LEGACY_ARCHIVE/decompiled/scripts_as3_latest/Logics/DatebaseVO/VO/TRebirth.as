package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import flash.utils.ByteArray;
   import ghostcat.util.data.Json;
   
   use namespace ResourcesSpace;
   
   public class TRebirth extends TDatebaseVO
   {
      
      protected var FName:String;
      
      protected var FNum:int;
      
      protected var FProperty:String;
      
      protected var FAddProperty:Array;
      
      protected var FLevel:int;
      
      protected var FNextid:int;
      
      public function TRebirth()
      {
         super();
         this.FAddProperty = new Array();
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
         param1.writeUnsignedInt(this.FNextid);
         param1.writeUnsignedInt(this.FNum);
         TUtilityString.FlushUTF(param1,this.FProperty);
         param1.writeUnsignedInt(this.FLevel);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         var _loc2_:Object = null;
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         this.FName = TUtilityString.FetchUTF(param1);
         this.FNextid = param1.readUnsignedInt();
         this.FNum = param1.readUnsignedInt();
         this.FProperty = TUtilityString.FetchUTF(param1);
         this.FAddProperty.length = 0;
         _loc2_ = Json.decode(this.FProperty);
         _loc3_ = _loc2_ as Array;
         if(_loc3_)
         {
            _loc4_ = 0;
            while(_loc4_ < _loc3_.length)
            {
               this.FAddProperty.push(_loc3_[_loc4_]);
               _loc4_++;
            }
         }
         this.FLevel = param1.readUnsignedInt();
      }
      
      public function get Name() : String
      {
         return this.FName;
      }
      
      public function get Nextid() : int
      {
         return this.FNextid;
      }
      
      public function get Num() : int
      {
         return this.FNum;
      }
      
      public function get Property() : String
      {
         return this.FProperty;
      }
      
      public function get AddProperty() : Array
      {
         return this.FAddProperty;
      }
      
      public function get Level() : int
      {
         return this.FLevel;
      }
   }
}

