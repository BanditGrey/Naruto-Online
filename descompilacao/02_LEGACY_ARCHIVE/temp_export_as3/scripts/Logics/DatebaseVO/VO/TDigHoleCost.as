package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Logics.DatebaseVO.TDatebaseVO;
   import flash.utils.ByteArray;
   
   use namespace ResourcesSpace;
   
   public class TDigHoleCost extends TDatebaseVO
   {
      
      protected var FEquipLv:uint;
      
      protected var FEquipQuality:uint;
      
      protected var FCostItem_Hole1:uint;
      
      protected var FCostItem_Hole2:uint;
      
      protected var FCostItem_Hole3:uint;
      
      protected var FCostItem_Hole4:uint;
      
      protected var FCostItem_Hole5:uint;
      
      protected var FCostItem_Hole6:uint;
      
      protected var FCostItem_Hole7:uint;
      
      protected var FCostItem_Hole8:uint;
      
      protected var FCostItem_Hole9:uint;
      
      protected var FCostItem_Hole10:uint;
      
      protected var FCostCoin_Hole1:uint;
      
      protected var FCostCoin_Hole2:uint;
      
      protected var FCostCoin_Hole3:uint;
      
      protected var FCostCoin_Hole4:uint;
      
      protected var FCostCoin_Hole5:uint;
      
      protected var FCostCoin_Hole6:uint;
      
      protected var FCostCoin_Hole7:uint;
      
      protected var FCostCoin_Hole8:uint;
      
      protected var FCostCoin_Hole9:uint;
      
      protected var FCostCoin_Hole10:uint;
      
      public function TDigHoleCost()
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
         param1.writeUnsignedInt(this.FEquipLv);
         param1.writeUnsignedInt(this.FEquipQuality);
         param1.writeUnsignedInt(this.FCostItem_Hole1);
         param1.writeUnsignedInt(this.FCostItem_Hole2);
         param1.writeUnsignedInt(this.FCostItem_Hole3);
         param1.writeUnsignedInt(this.FCostItem_Hole4);
         param1.writeUnsignedInt(this.FCostItem_Hole5);
         param1.writeUnsignedInt(this.FCostItem_Hole6);
         param1.writeUnsignedInt(this.FCostItem_Hole7);
         param1.writeUnsignedInt(this.FCostItem_Hole8);
         param1.writeUnsignedInt(this.FCostItem_Hole9);
         param1.writeUnsignedInt(this.FCostItem_Hole10);
         param1.writeUnsignedInt(this.FCostCoin_Hole1);
         param1.writeUnsignedInt(this.FCostCoin_Hole2);
         param1.writeUnsignedInt(this.FCostCoin_Hole3);
         param1.writeUnsignedInt(this.FCostCoin_Hole4);
         param1.writeUnsignedInt(this.FCostCoin_Hole5);
         param1.writeUnsignedInt(this.FCostCoin_Hole6);
         param1.writeUnsignedInt(this.FCostCoin_Hole7);
         param1.writeUnsignedInt(this.FCostCoin_Hole8);
         param1.writeUnsignedInt(this.FCostCoin_Hole9);
         param1.writeUnsignedInt(this.FCostCoin_Hole10);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         this.FEquipLv = param1.readUnsignedInt();
         this.FEquipQuality = param1.readUnsignedInt();
         this.FCostItem_Hole1 = param1.readUnsignedInt();
         this.FCostItem_Hole2 = param1.readUnsignedInt();
         this.FCostItem_Hole3 = param1.readUnsignedInt();
         this.FCostItem_Hole4 = param1.readUnsignedInt();
         this.FCostItem_Hole5 = param1.readUnsignedInt();
         this.FCostItem_Hole6 = param1.readUnsignedInt();
         this.FCostItem_Hole7 = param1.readUnsignedInt();
         this.FCostItem_Hole8 = param1.readUnsignedInt();
         this.FCostItem_Hole9 = param1.readUnsignedInt();
         this.FCostItem_Hole10 = param1.readUnsignedInt();
         this.FCostCoin_Hole1 = param1.readUnsignedInt();
         this.FCostCoin_Hole2 = param1.readUnsignedInt();
         this.FCostCoin_Hole3 = param1.readUnsignedInt();
         this.FCostCoin_Hole4 = param1.readUnsignedInt();
         this.FCostCoin_Hole5 = param1.readUnsignedInt();
         this.FCostCoin_Hole6 = param1.readUnsignedInt();
         this.FCostCoin_Hole7 = param1.readUnsignedInt();
         this.FCostCoin_Hole8 = param1.readUnsignedInt();
         this.FCostCoin_Hole9 = param1.readUnsignedInt();
         this.FCostCoin_Hole10 = param1.readUnsignedInt();
      }
      
      public function get EquipLv() : uint
      {
         return this.FEquipLv;
      }
      
      public function get EquipQuality() : uint
      {
         return this.FEquipQuality;
      }
      
      public function get CostItem_Hole1() : uint
      {
         return this.FCostItem_Hole1;
      }
      
      public function get CostItem_Hole2() : uint
      {
         return this.FCostItem_Hole2;
      }
      
      public function get CostItem_Hole3() : uint
      {
         return this.FCostItem_Hole3;
      }
      
      public function get CostItem_Hole4() : uint
      {
         return this.FCostItem_Hole4;
      }
      
      public function get CostItem_Hole5() : uint
      {
         return this.FCostItem_Hole5;
      }
      
      public function get CostItem_Hole6() : uint
      {
         return this.FCostItem_Hole6;
      }
      
      public function get CostItem_Hole7() : uint
      {
         return this.FCostItem_Hole7;
      }
      
      public function get CostItem_Hole8() : uint
      {
         return this.FCostItem_Hole8;
      }
      
      public function get CostItem_Hole9() : uint
      {
         return this.FCostItem_Hole9;
      }
      
      public function get CostItem_Hole10() : uint
      {
         return this.FCostItem_Hole10;
      }
      
      public function get CostCoin_Hole1() : uint
      {
         return this.FCostCoin_Hole1;
      }
      
      public function get CostCoin_Hole2() : uint
      {
         return this.FCostCoin_Hole2;
      }
      
      public function get CostCoin_Hole3() : uint
      {
         return this.FCostCoin_Hole3;
      }
      
      public function get CostCoin_Hole4() : uint
      {
         return this.FCostCoin_Hole4;
      }
      
      public function get CostCoin_Hole5() : uint
      {
         return this.FCostCoin_Hole5;
      }
      
      public function get CostCoin_Hole6() : uint
      {
         return this.FCostCoin_Hole6;
      }
      
      public function get CostCoin_Hole7() : uint
      {
         return this.FCostCoin_Hole7;
      }
      
      public function get CostCoin_Hole8() : uint
      {
         return this.FCostCoin_Hole8;
      }
      
      public function get CostCoin_Hole9() : uint
      {
         return this.FCostCoin_Hole9;
      }
      
      public function get CostCoin_Hole10() : uint
      {
         return this.FCostCoin_Hole10;
      }
   }
}

