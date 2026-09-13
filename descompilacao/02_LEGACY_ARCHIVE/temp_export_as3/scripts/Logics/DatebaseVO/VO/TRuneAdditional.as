package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.*;
   import Logics.DatebaseVO.*;
   import flash.utils.*;
   
   use namespace ResourcesSpace;
   
   public class TRuneAdditional extends TDatebaseVO
   {
      
      protected var FEquipLevel:int;
      
      protected var FTypeEffect:int;
      
      protected var FTypeEffectValue:Number;
      
      protected var FPercentage:int;
      
      public function TRuneAdditional()
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
         param1.writeUnsignedInt(this.FEquipLevel);
         param1.writeUnsignedInt(this.FTypeEffect);
         param1.writeFloat(this.FTypeEffectValue);
         param1.writeUnsignedInt(this.FPercentage);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         this.FEquipLevel = param1.readUnsignedInt();
         this.FTypeEffect = param1.readUnsignedInt();
         this.FTypeEffectValue = param1.readFloat();
         this.FPercentage = param1.readUnsignedInt();
      }
      
      public function get EquipLevel() : int
      {
         return this.FEquipLevel;
      }
      
      public function get TypeEffect() : int
      {
         return this.FTypeEffect;
      }
      
      public function get TypeEffectValue() : Number
      {
         return this.FTypeEffectValue;
      }
      
      public function get Percentage() : int
      {
         return this.FPercentage;
      }
   }
}

