package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import flash.utils.ByteArray;
   import ghostcat.util.data.Json;
   
   use namespace ResourcesSpace;
   
   public class TBuffEffect extends TDatebaseVO
   {
      
      protected var FBuffType:int;
      
      protected var FAlterVect:Vector.<uint>;
      
      protected var FBuffkey:int;
      
      protected var FWeight:int;
      
      protected var FContinued:int;
      
      protected var FName:String;
      
      protected var FDescription:String;
      
      protected var FIconUrl:int;
      
      protected var FAlter:String;
      
      public function TBuffEffect()
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
         param1.writeUnsignedInt(this.FBuffType);
         TUtilityString.FlushUTF(param1,this.FAlter);
         param1.writeUnsignedInt(this.FBuffkey);
         param1.writeUnsignedInt(this.FWeight);
         param1.writeUnsignedInt(this.FContinued);
         TUtilityString.FlushUTF(param1,this.FName);
         TUtilityString.FlushUTF(param1,this.FDescription);
         param1.writeUnsignedInt(this.FIconUrl);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:Object = null;
         var _loc6_:Array = null;
         this.FBuffType = param1.readUnsignedInt();
         this.FAlter = TUtilityString.FetchUTF(param1);
         _loc5_ = Json.decode(this.FAlter);
         _loc6_ = _loc5_.alter;
         _loc3_ = int(_loc6_.length);
         this.FAlterVect = new Vector.<uint>(_loc3_);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            this.FAlterVect[_loc2_] = _loc6_[_loc2_];
            _loc2_++;
         }
         this.FBuffkey = param1.readUnsignedInt();
         this.FWeight = param1.readUnsignedInt();
         this.FContinued = param1.readUnsignedInt();
         this.FName = TUtilityString.FetchUTF(param1);
         this.FDescription = TUtilityString.FetchUTF(param1);
         this.FIconUrl = param1.readUnsignedInt();
      }
      
      public function get BuffType() : int
      {
         return this.FBuffType;
      }
      
      public function get AlterVect() : Vector.<uint>
      {
         return this.FAlterVect;
      }
      
      public function get Buffkey() : int
      {
         return this.FBuffkey;
      }
      
      public function get Weight() : int
      {
         return this.FWeight;
      }
      
      public function get Continued() : int
      {
         return this.FContinued;
      }
      
      public function get Name() : String
      {
         return this.FName;
      }
      
      public function get Description() : String
      {
         return this.FDescription;
      }
      
      public function get IconUrl() : int
      {
         return this.FIconUrl;
      }
      
      public function get Alter() : String
      {
         return this.FAlter;
      }
   }
}

