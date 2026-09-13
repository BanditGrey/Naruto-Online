package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.*;
   import Logics.DatebaseVO.VO.Json.*;
   import flash.utils.ByteArray;
   import ghostcat.util.data.*;
   
   use namespace ResourcesSpace;
   
   public class TConfigValue extends TDatebaseVO
   {
      
      protected static const TYPEVALUEINDEX_INT:uint = 0;
      
      protected static const TYPEVALUEINDEX_ARRAY:uint = 1;
      
      protected static const TYPEVALUEINDEX_ARRAYOBJECT:uint = 2;
      
      protected static const TYPEVALUEINDEX_OBJECT:uint = 3;
      
      protected static const TYPEVALUEINDEX_NUMBER:uint = 4;
      
      protected static const TYPEVALUE_INT:String = "int";
      
      protected static const TYPEVALUE_STRING:String = "String";
      
      protected static const TYPEVALUE_FLOAT:String = "float";
      
      protected static const ISCLIENT_STRING:String = "1";
      
      protected var FTypeValue:uint;
      
      protected var FDefineInt:uint;
      
      protected var FDefineNumber:Number;
      
      protected var FDefineVector:Vector.<uint>;
      
      protected var FDefineObjectVector:Vector.<Object>;
      
      protected var FDefineObject:Object;
      
      protected var FIsClient:Boolean;
      
      protected var FValue:String;
      
      protected var FValueType:String;
      
      public function TConfigValue()
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
         param1.writeBoolean(this.FIsClient);
         TUtilityString.FlushUTF(param1,this.FValueType);
         TUtilityString.FlushUTF(param1,this.FValue);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Boolean = false;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:Object = null;
         var _loc8_:Array = null;
         _loc4_ = param1.readBoolean();
         if(!_loc4_)
         {
            return;
         }
         _loc5_ = TUtilityString.FetchUTF(param1);
         _loc6_ = TUtilityString.FetchUTF(param1);
         switch(_loc5_)
         {
            case TYPEVALUE_INT:
               this.FDefineInt = parseInt(_loc6_);
               this.FTypeValue = TYPEVALUEINDEX_INT;
               break;
            case TYPEVALUE_STRING:
               _loc7_ = Json.decode(_loc6_);
               if(_loc7_ is Array)
               {
                  _loc8_ = _loc7_ as Array;
                  _loc3_ = int(_loc8_.length);
                  _loc2_ = 0;
                  while(_loc2_ < _loc3_)
                  {
                     if(!(_loc8_[_loc2_] is int))
                     {
                        this.FTypeValue = TYPEVALUEINDEX_ARRAYOBJECT;
                        break;
                     }
                     _loc2_++;
                  }
                  switch(this.FTypeValue)
                  {
                     case TYPEVALUEINDEX_ARRAYOBJECT:
                        this.FDefineObjectVector = new Vector.<Object>(_loc3_);
                        _loc2_ = 0;
                        while(_loc2_ < _loc3_)
                        {
                           this.FDefineObjectVector[_loc2_] = _loc8_[_loc2_];
                           _loc2_++;
                        }
                        this.FTypeValue = TYPEVALUEINDEX_ARRAYOBJECT;
                        break;
                     default:
                        this.FDefineVector = new Vector.<uint>(_loc3_);
                        _loc2_ = 0;
                        while(_loc2_ < _loc3_)
                        {
                           this.FDefineVector[_loc2_] = _loc8_[_loc2_];
                           _loc2_++;
                        }
                        this.FTypeValue = TYPEVALUEINDEX_ARRAY;
                  }
               }
               else
               {
                  this.FDefineObject = _loc7_;
                  this.FTypeValue = TYPEVALUEINDEX_OBJECT;
               }
               break;
            case TYPEVALUE_FLOAT:
               this.FDefineNumber = parseFloat(_loc6_);
               this.FTypeValue = TYPEVALUEINDEX_NUMBER;
         }
      }
      
      public function get IsClient() : Boolean
      {
         return this.FIsClient;
      }
      
      public function get ValueType() : String
      {
         return this.FValueType;
      }
      
      public function get Value() : Object
      {
         switch(this.FTypeValue)
         {
            case TYPEVALUEINDEX_INT:
               return this.FDefineInt;
            case TYPEVALUEINDEX_ARRAY:
               return this.FDefineVector;
            case TYPEVALUEINDEX_ARRAYOBJECT:
               return this.FDefineObjectVector;
            case TYPEVALUEINDEX_OBJECT:
               return this.FDefineObject;
            case TYPEVALUEINDEX_NUMBER:
               return this.FDefineNumber;
            default:
               return null;
         }
      }
   }
}

