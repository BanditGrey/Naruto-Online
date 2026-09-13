package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Logics.DatebaseVO.TDatebaseVO;
   import flash.utils.ByteArray;
   
   use namespace ResourcesSpace;
   
   public class TItem2item extends TDatebaseVO
   {
      
      protected var FType:int;
      
      protected var FRedeemPoint:int;
      
      protected var FNeedPoint:int;
      
      protected var FItemid:int;
      
      protected var FMaxbuy:int;
      
      protected var FAmount:int;
      
      public function TItem2item()
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
         param1.writeUnsignedInt(FIdentifier);
         param1.writeUnsignedInt(this.FType);
         param1.writeUnsignedInt(this.FRedeemPoint);
         param1.writeUnsignedInt(this.FNeedPoint);
         param1.writeUnsignedInt(this.FItemid);
         param1.writeUnsignedInt(this.FMaxbuy);
         param1.writeUnsignedInt(this.FAmount);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         this.FType = param1.readUnsignedInt();
         this.FRedeemPoint = param1.readUnsignedInt();
         this.FNeedPoint = param1.readUnsignedInt();
         this.FItemid = param1.readUnsignedInt();
         this.FMaxbuy = param1.readUnsignedInt();
         this.FAmount = param1.readUnsignedInt();
      }
      
      public function get Type() : uint
      {
         return this.FType;
      }
      
      public function get NeedPoint() : uint
      {
         return this.FNeedPoint;
      }
      
      public function get RedeemPoint() : uint
      {
         return this.FRedeemPoint;
      }
      
      public function get Itemid() : uint
      {
         return this.FItemid;
      }
      
      public function get Maxbuy() : uint
      {
         return this.FMaxbuy;
      }
      
      public function get Amount() : uint
      {
         return this.FAmount;
      }
   }
}

