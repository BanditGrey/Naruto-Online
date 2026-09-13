package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import flash.utils.ByteArray;
   import ghostcat.util.data.Json;
   
   use namespace ResourcesSpace;
   
   public class TEnchantValue extends TDatebaseVO
   {
      
      protected var FLevel:int;
      
      protected var FEquipLevel:String;
      
      protected var FLevelCoefficient:Number;
      
      protected var FType:int;
      
      protected var FTypeCoefficient:Number;
      
      protected var FEnchantConsume:int;
      
      protected var FEnchantSuccessrate:int;
      
      protected var FEnchantStone:String;
      
      protected var FProtectStone:int;
      
      protected var FMinEquipLevel:uint;
      
      protected var FMaxEquipLevel:uint;
      
      protected var FEnchantStones:Vector.<uint>;
      
      public function TEnchantValue()
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
                     this[_loc3_] = _loc4_;
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
         param1.writeUnsignedInt(this.FLevel);
         TUtilityString.FlushUTF(param1,this.FEquipLevel);
         param1.writeFloat(this.FLevelCoefficient);
         param1.writeUnsignedInt(this.FType);
         param1.writeFloat(this.FTypeCoefficient);
         param1.writeUnsignedInt(this.FEnchantConsume);
         param1.writeUnsignedInt(this.FEnchantSuccessrate);
         TUtilityString.FlushUTF(param1,this.FEnchantStone);
         param1.writeUnsignedInt(this.FProtectStone);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Array = null;
         this.FLevel = param1.readUnsignedInt();
         this.FEquipLevel = TUtilityString.FetchUTF(param1);
         this.FLevelCoefficient = param1.readFloat();
         this.FType = param1.readUnsignedInt();
         this.FTypeCoefficient = param1.readFloat();
         this.FEnchantConsume = param1.readUnsignedInt();
         this.FEnchantSuccessrate = param1.readUnsignedInt();
         this.FEnchantStone = TUtilityString.FetchUTF(param1);
         this.FProtectStone = param1.readUnsignedInt();
         _loc3_ = Json.decode(this.FEquipLevel);
         this.FMinEquipLevel = _loc3_[0];
         this.FMaxEquipLevel = _loc3_[1];
         _loc3_ = Json.decode(this.FEnchantStone);
         this.FEnchantStones = Vector.<uint>(_loc3_);
      }
      
      public function get Level() : int
      {
         return this.FLevel;
      }
      
      public function get EquipLevel() : String
      {
         return this.FEquipLevel;
      }
      
      public function get LevelCoefficient() : Number
      {
         return this.FLevelCoefficient;
      }
      
      public function get Type() : int
      {
         return this.FType;
      }
      
      public function get TypeCoefficient() : Number
      {
         return this.FTypeCoefficient;
      }
      
      public function get EnchantConsume() : int
      {
         return this.FEnchantConsume;
      }
      
      public function get EnchantSuccessrate() : int
      {
         return this.FEnchantSuccessrate;
      }
      
      public function get EnchantStone() : String
      {
         return this.FEnchantStone;
      }
      
      public function get ProtectStone() : int
      {
         return this.FProtectStone;
      }
      
      public function get MinEquipLevel() : int
      {
         return this.FMinEquipLevel;
      }
      
      public function get MaxEquipLevel() : int
      {
         return this.FMaxEquipLevel;
      }
      
      public function get EnchantStones() : Vector.<uint>
      {
         return this.FEnchantStones;
      }
   }
}

