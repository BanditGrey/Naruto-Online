package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import flash.utils.ByteArray;
   
   use namespace ResourcesSpace;
   
   public class TMasterStone extends TDatebaseVO
   {
      
      protected var FLevel:uint;
      
      protected var FNeedExp:uint;
      
      protected var FAllExp:uint;
      
      protected var FAddValue:String;
      
      protected var FNextId:uint;
      
      protected var FConversionId:uint;
      
      protected var FCostjheart:String;
      
      public function TMasterStone()
      {
         super();
      }
      
      public function get Level() : uint
      {
         return this.FLevel;
      }
      
      public function get NeedExp() : uint
      {
         return this.FNeedExp;
      }
      
      public function get AllExp() : uint
      {
         return this.FAllExp;
      }
      
      public function get AddValue() : String
      {
         return this.FAddValue;
      }
      
      public function get NextId() : uint
      {
         return this.FNextId;
      }
      
      public function get ConversionId() : uint
      {
         return this.FConversionId;
      }
      
      public function get Costjheart() : String
      {
         return this.FCostjheart;
      }
      
      override ResourcesSpace function WriteDataToStream(param1:ByteArray) : void
      {
         param1.writeUnsignedInt(FIdentifier);
         param1.writeUnsignedInt(this.FLevel);
         param1.writeUnsignedInt(this.FNeedExp);
         param1.writeUnsignedInt(this.FAllExp);
         TUtilityString.FlushUTF(param1,this.FAddValue);
         param1.writeUnsignedInt(this.FNextId);
         param1.writeUnsignedInt(this.FConversionId);
         TUtilityString.FlushUTF(param1,this.FCostjheart);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         this.FLevel = param1.readUnsignedInt();
         this.FNeedExp = param1.readUnsignedInt();
         this.FAllExp = param1.readUnsignedInt();
         this.FAddValue = TUtilityString.FetchUTF(param1);
         this.FNextId = param1.readUnsignedInt();
         this.FConversionId = param1.readUnsignedInt();
         this.FCostjheart = TUtilityString.FetchUTF(param1);
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
   }
}

