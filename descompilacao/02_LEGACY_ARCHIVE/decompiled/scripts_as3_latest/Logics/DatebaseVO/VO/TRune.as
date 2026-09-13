package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.*;
   import Logics.DatebaseVO.*;
   import flash.utils.*;
   
   use namespace ResourcesSpace;
   
   public class TRune extends TDatebaseVO
   {
      
      protected var FMainType:int;
      
      protected var FMainValue:int;
      
      protected var FMainAdditionalType:int;
      
      protected var FMainAdditionalValue:Number;
      
      protected var FHeroID:int;
      
      protected var FSpecialType:int;
      
      protected var FSpecialValue:Number;
      
      public function TRune()
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
         param1.writeUnsignedInt(FIdentifier);
         param1.writeUnsignedInt(this.FMainType);
         param1.writeUnsignedInt(this.FMainValue);
         param1.writeUnsignedInt(this.FMainAdditionalType);
         param1.writeFloat(this.FMainAdditionalValue);
         param1.writeUnsignedInt(this.FHeroID);
         param1.writeUnsignedInt(this.FSpecialType);
         param1.writeFloat(this.FSpecialValue);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         this.FMainType = param1.readUnsignedInt();
         this.FMainValue = param1.readUnsignedInt();
         this.FMainAdditionalType = param1.readUnsignedInt();
         this.FMainAdditionalValue = param1.readFloat();
         this.FHeroID = param1.readUnsignedInt();
         this.FSpecialType = param1.readUnsignedInt();
         this.FSpecialValue = param1.readFloat();
      }
      
      public function get MainType() : int
      {
         return this.FMainType;
      }
      
      public function get MainValue() : int
      {
         return this.FMainValue;
      }
      
      public function get MainAdditionalType() : int
      {
         return this.FMainAdditionalType;
      }
      
      public function get MainAdditionalValue() : Number
      {
         return this.FMainAdditionalValue;
      }
      
      public function get HeroID() : int
      {
         return this.FHeroID;
      }
      
      public function get SpecialType() : int
      {
         return this.FSpecialType;
      }
      
      public function get SpecialValue() : Number
      {
         return this.FSpecialValue;
      }
   }
}

