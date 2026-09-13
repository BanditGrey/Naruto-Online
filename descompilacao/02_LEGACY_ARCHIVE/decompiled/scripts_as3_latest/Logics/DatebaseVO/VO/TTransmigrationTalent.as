package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.*;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.*;
   import flash.utils.*;
   
   use namespace ResourcesSpace;
   
   public class TTransmigrationTalent extends TDatebaseVO
   {
      
      protected var FName:String;
      
      protected var FDesc:String;
      
      protected var FMaxLevel:int;
      
      protected var FCurLevel:int;
      
      public function TTransmigrationTalent()
      {
         super();
      }
      
      override ResourcesSpace function WriteDataToStream(param1:ByteArray) : void
      {
         param1.writeUnsignedInt(FIdentifier);
         TUtilityString.FlushUTF(param1,this.FName);
         TUtilityString.FlushUTF(param1,this.FDesc);
         param1.writeUnsignedInt(this.FMaxLevel);
         param1.writeUnsignedInt(this.FCurLevel);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         this.FName = TUtilityString.FetchUTF(param1);
         this.FDesc = TUtilityString.FetchUTF(param1);
         this.FMaxLevel = param1.readUnsignedInt();
         this.FCurLevel = param1.readUnsignedInt();
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
      
      public function set Name(param1:String) : void
      {
         this.FName = param1;
      }
      
      public function get Name() : String
      {
         return this.FName;
      }
      
      public function set Desc(param1:String) : void
      {
         this.FDesc = param1;
      }
      
      public function get Desc() : String
      {
         return this.FDesc;
      }
      
      public function set MaxLevel(param1:int) : void
      {
         this.FMaxLevel = param1;
      }
      
      public function get MaxLevel() : int
      {
         return this.FMaxLevel;
      }
      
      public function set CurLevel(param1:int) : void
      {
         this.FCurLevel = param1;
      }
      
      public function get CurLevel() : int
      {
         return this.FCurLevel;
      }
   }
}

