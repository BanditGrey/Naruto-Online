package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Logics.DatebaseVO.TDatebaseVO;
   import flash.utils.ByteArray;
   
   use namespace ResourcesSpace;
   
   public class TSlaveGainExp extends TDatebaseVO
   {
      
      protected var FLevel:uint;
      
      protected var FExtractable:uint;
      
      protected var FPressible:uint;
      
      protected var FOperation:uint;
      
      public function TSlaveGainExp()
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
         param1.writeUnsignedInt(this.FExtractable);
         param1.writeUnsignedInt(this.FPressible);
         param1.writeUnsignedInt(this.FOperation);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         this.FLevel = param1.readUnsignedInt();
         this.FExtractable = param1.readUnsignedInt();
         this.FPressible = param1.readUnsignedInt();
         this.FOperation = param1.readUnsignedInt();
      }
      
      public function get Level() : uint
      {
         return this.FLevel;
      }
      
      public function get Extractable() : uint
      {
         return this.FExtractable;
      }
      
      public function get Pressible() : uint
      {
         return this.FPressible;
      }
      
      public function get Operation() : uint
      {
         return this.FOperation;
      }
   }
}

