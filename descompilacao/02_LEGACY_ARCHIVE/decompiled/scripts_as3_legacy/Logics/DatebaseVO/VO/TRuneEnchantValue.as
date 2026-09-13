package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.*;
   import Logics.DatebaseVO.*;
   import flash.utils.*;
   
   use namespace ResourcesSpace;
   
   public class TRuneEnchantValue extends TDatebaseVO
   {
      
      protected var FLevel:int;
      
      protected var FColor:int;
      
      protected var FMainattribute:int;
      
      protected var FAssattribute:int;
      
      protected var FEnchantStone:int;
      
      protected var FEnchantStoneNum:int;
      
      protected var FRuneNum:int;
      
      protected var FHoleNum:int;
      
      public function TRuneEnchantValue()
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
         param1.writeUnsignedInt(this.FLevel);
         param1.writeUnsignedInt(this.FColor);
         param1.writeUnsignedInt(this.FMainattribute);
         param1.writeUnsignedInt(this.FAssattribute);
         param1.writeUnsignedInt(this.FEnchantStone);
         param1.writeUnsignedInt(this.FEnchantStoneNum);
         param1.writeUnsignedInt(this.FRuneNum);
         param1.writeUnsignedInt(this.FHoleNum);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         this.FLevel = param1.readUnsignedInt();
         this.FColor = param1.readUnsignedInt();
         this.FMainattribute = param1.readUnsignedInt();
         this.FAssattribute = param1.readUnsignedInt();
         this.FEnchantStone = param1.readUnsignedInt();
         this.FEnchantStoneNum = param1.readUnsignedInt();
         this.FRuneNum = param1.readUnsignedInt();
         this.FHoleNum = param1.readUnsignedInt();
      }
      
      public function get Level() : int
      {
         return this.FLevel;
      }
      
      public function get Color() : int
      {
         return this.FColor;
      }
      
      public function get Mainattribute() : int
      {
         return this.FMainattribute;
      }
      
      public function get Assattribute() : int
      {
         return this.FAssattribute;
      }
      
      public function get EnchantStoneNum() : int
      {
         return this.FEnchantStoneNum;
      }
      
      public function get EnchantStone() : int
      {
         return this.FEnchantStone;
      }
      
      public function get RuneNum() : int
      {
         return this.FRuneNum;
      }
      
      public function get HoleNum() : Number
      {
         return this.FHoleNum;
      }
   }
}

