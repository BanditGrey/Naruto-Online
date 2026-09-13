package Logics.DatebaseVO.VO
{
   import Foundation.Common.Integer.UInt64;
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Logics.DatebaseVO.TDatebaseVO;
   import flash.utils.ByteArray;
   
   use namespace ResourcesSpace;
   
   public class THeroExp extends TDatebaseVO
   {
      
      protected var FNeedExp:UInt64;
      
      protected var FAllExp:UInt64;
      
      protected var FFrontlv:int;
      
      protected var FNextlv:int;
      
      public function THeroExp()
      {
         super();
         this.FNeedExp = new UInt64();
         this.FAllExp = new UInt64();
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
                     if(_loc3_ == "FFrontlv" || _loc3_ == "FNextlv")
                     {
                        this[_loc3_] = _loc4_;
                     }
                     else
                     {
                        this[_loc3_] = UInt64.ParseUInt64(_loc4_);
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
         param1.writeUnsignedInt(this.FNeedExp.High);
         param1.writeUnsignedInt(this.FNeedExp.Low);
         param1.writeUnsignedInt(this.FAllExp.High);
         param1.writeUnsignedInt(this.FAllExp.Low);
         param1.writeUnsignedInt(this.FFrontlv);
         param1.writeUnsignedInt(this.FNextlv);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         this.FNeedExp.High = param1.readUnsignedInt();
         this.FNeedExp.Low = param1.readUnsignedInt();
         this.FAllExp.High = param1.readUnsignedInt();
         this.FAllExp.Low = param1.readUnsignedInt();
         this.FFrontlv = param1.readUnsignedInt();
         this.FNextlv = param1.readUnsignedInt();
      }
      
      public function get NeedExp() : UInt64
      {
         return this.FNeedExp;
      }
      
      public function get AllExp() : UInt64
      {
         return this.FAllExp;
      }
      
      public function get Frontlv() : int
      {
         return this.FFrontlv;
      }
      
      public function get Nextlv() : int
      {
         return this.FNextlv;
      }
   }
}

