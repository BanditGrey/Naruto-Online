package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Logics.DatebaseVO.TDatebaseVO;
   import flash.utils.ByteArray;
   
   use namespace ResourcesSpace;
   
   public class TArchiveCofig extends TDatebaseVO
   {
      
      protected var FTime:uint;
      
      protected var FType:uint;
      
      protected var FCost:uint;
      
      protected var FGetExp:uint;
      
      public function TArchiveCofig()
      {
         super();
      }
      
      override ResourcesSpace function ReadDataByXml(param1:XML) : void
      {
         var _loc4_:XML = null;
         var _loc5_:String = null;
         var _loc6_:* = undefined;
         var _loc2_:uint = uint(param1.elements().length());
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = param1.elements()[_loc3_];
            _loc5_ = String(_loc4_.name());
            _loc6_ = _loc4_;
            if(_loc5_ == "id")
            {
               Coerce(uint(_loc6_));
            }
            else
            {
               _loc5_ = "F" + _loc5_;
               if(hasOwnProperty(_loc5_))
               {
                  this[_loc5_] = _loc6_;
               }
               else
               {
                  if(Count_AttributeName.indexOf(_loc5_.slice(1,2)) < 0)
                  {
                     _loc5_ = "F" + _loc5_.slice(1,2).toLocaleUpperCase() + _loc5_.slice(2);
                  }
                  if(hasOwnProperty(_loc5_.slice(1)))
                  {
                     if(this[_loc5_] is Boolean)
                     {
                        this[_loc5_] = Boolean(int(_loc6_));
                     }
                     else
                     {
                        this[_loc5_] = _loc6_;
                     }
                  }
               }
            }
            _loc3_++;
         }
      }
      
      override ResourcesSpace function WriteDataToStream(param1:ByteArray) : void
      {
         param1.writeUnsignedInt(FIdentifier);
         param1.writeUnsignedInt(this.FTime);
         param1.writeUnsignedInt(this.FType);
         param1.writeUnsignedInt(this.FCost);
         param1.writeUnsignedInt(this.FGetExp);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         this.FTime = param1.readUnsignedInt();
         this.FType = param1.readUnsignedInt();
         this.FCost = param1.readUnsignedInt();
         this.FGetExp = param1.readUnsignedInt();
      }
      
      public function get Time() : uint
      {
         return this.FTime;
      }
      
      public function get Type() : uint
      {
         return this.FType;
      }
      
      public function get Cost() : uint
      {
         return this.FCost;
      }
      
      public function get GetExp() : uint
      {
         return this.FGetExp;
      }
   }
}

