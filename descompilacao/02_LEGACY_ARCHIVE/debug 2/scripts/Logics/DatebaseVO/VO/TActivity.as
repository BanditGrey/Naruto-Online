package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.*;
   import Foundation.Utilities.*;
   import Logics.DatebaseVO.*;
   import flash.utils.*;
   import ghostcat.util.data.*;
   
   use namespace ResourcesSpace;
   
   public class TActivity extends TDatebaseVO
   {
      
      protected var FName:String;
      
      protected var FTName:String;
      
      protected var FDesc:String;
      
      protected var FIconType:uint;
      
      protected var FSecondIconType:uint;
      
      protected var FStartIndexVect:Vector.<uint>;
      
      protected var FEndIndexVect:Vector.<uint>;
      
      protected var FSort:uint;
      
      protected var FStartIndex:String;
      
      protected var FEndIndex:String;
      
      public function TActivity()
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
         TUtilityString.FlushUTF(param1,this.FName);
         TUtilityString.FlushUTF(param1,this.FTName);
         TUtilityString.FlushUTF(param1,this.FDesc);
         param1.writeUnsignedInt(this.FIconType);
         param1.writeUnsignedInt(this.FSecondIconType);
         TUtilityString.FlushUTF(param1,this.FStartIndex);
         TUtilityString.FlushUTF(param1,this.FEndIndex);
         param1.writeUnsignedInt(this.FSort);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:Array = null;
         this.FName = TUtilityString.FetchUTF(param1);
         this.FTName = TUtilityString.FetchUTF(param1);
         this.FDesc = TUtilityString.FetchUTF(param1);
         this.FIconType = param1.readUnsignedInt();
         this.FSecondIconType = param1.readUnsignedInt();
         this.FStartIndex = TUtilityString.FetchUTF(param1);
         this.FStartIndexVect = Vector.<uint>(Json.decode(this.FStartIndex));
         this.FEndIndex = TUtilityString.FetchUTF(param1);
         this.FEndIndexVect = Vector.<uint>(Json.decode(this.FEndIndex));
         this.FSort = param1.readUnsignedInt();
      }
      
      public function get Name() : String
      {
         return this.FName;
      }
      
      public function get TName() : String
      {
         return this.FTName;
      }
      
      public function get Desc() : String
      {
         return this.FDesc;
      }
      
      public function get IconType() : uint
      {
         return this.FIconType;
      }
      
      public function get SecondIconType() : uint
      {
         return this.FSecondIconType;
      }
      
      public function get StartIndexVect() : Vector.<uint>
      {
         return this.FStartIndexVect;
      }
      
      public function get EndIndexVect() : Vector.<uint>
      {
         return this.FEndIndexVect;
      }
      
      public function get Sort() : uint
      {
         return this.FSort;
      }
      
      public function get StartIndex() : String
      {
         return this.FStartIndex;
      }
      
      public function get EndIndex() : String
      {
         return this.FEndIndex;
      }
   }
}

