package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Logics.DatebaseVO.TDatebaseVO;
   import flash.utils.ByteArray;
   
   use namespace ResourcesSpace;
   
   public class TDouble11Mall extends TDatebaseVO
   {
      
      protected var FType:int;
      
      protected var FItemtype:int;
      
      protected var FHeroid:int;
      
      protected var FItemid:int;
      
      protected var FMaxbuy:int;
      
      protected var FAmount:int;
      
      protected var FCurrencytype:int;
      
      protected var FPrice:int;
      
      public function TDouble11Mall()
      {
         super();
      }
      
      override ResourcesSpace function ReadDataByXml(param1:XML) : void
      {
         var _loc2_:XML = null;
         var _loc3_:* = undefined;
         var _loc4_:String = null;
         var _loc5_:uint = 0;
         var _loc6_:int = 0;
         _loc5_ = uint(param1.elements().length());
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc2_ = param1.elements()[_loc6_];
            _loc4_ = String(_loc2_.name());
            _loc3_ = _loc2_;
            if(_loc4_ == "id")
            {
               Coerce(uint(_loc3_));
            }
            else
            {
               _loc4_ = "F" + _loc4_;
               if(hasOwnProperty(_loc4_))
               {
                  this[_loc4_] = _loc3_;
               }
               else
               {
                  if(Count_AttributeName.indexOf(_loc4_.slice(1,2)) < 0)
                  {
                     _loc4_ = "F" + _loc4_.slice(1,2).toLocaleUpperCase() + _loc4_.slice(2);
                  }
                  if(hasOwnProperty(_loc4_.slice(1)))
                  {
                     if(this[_loc4_] is Boolean)
                     {
                        this[_loc4_] = Boolean(int(_loc3_));
                     }
                     else
                     {
                        this[_loc4_] = _loc3_;
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
         param1.writeUnsignedInt(this.FType);
         param1.writeUnsignedInt(this.FItemtype);
         param1.writeUnsignedInt(this.FHeroid);
         param1.writeUnsignedInt(this.FItemid);
         param1.writeUnsignedInt(this.FMaxbuy);
         param1.writeUnsignedInt(this.FAmount);
         param1.writeUnsignedInt(this.FCurrencytype);
         param1.writeUnsignedInt(this.FPrice);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         this.FType = param1.readUnsignedInt();
         this.FItemtype = param1.readUnsignedInt();
         this.FHeroid = param1.readUnsignedInt();
         this.FItemid = param1.readUnsignedInt();
         this.FMaxbuy = param1.readUnsignedInt();
         this.FAmount = param1.readUnsignedInt();
         this.FCurrencytype = param1.readUnsignedInt();
         this.FPrice = param1.readUnsignedInt();
      }
      
      public function get Type() : uint
      {
         return this.FType;
      }
      
      public function get Itemtype() : uint
      {
         return this.FItemtype;
      }
      
      public function get Heroid() : uint
      {
         return this.FHeroid;
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
      
      public function get Currencytype() : uint
      {
         return this.FCurrencytype;
      }
      
      public function get Price() : int
      {
         return this.FPrice;
      }
   }
}

