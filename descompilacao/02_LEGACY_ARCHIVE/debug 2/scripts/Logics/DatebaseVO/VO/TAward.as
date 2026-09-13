package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.*;
   import Foundation.Utilities.*;
   import Logics.DatebaseVO.*;
   import Logics.DatebaseVO.VO.Json.*;
   import flash.utils.*;
   import ghostcat.util.data.*;
   
   use namespace ResourcesSpace;
   
   public class TAward extends TDatebaseVO
   {
      
      protected var FFixedAwards:Vector.<TFixedAward>;
      
      protected var FFixed:String;
      
      public function TAward()
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
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         param1.writeUnsignedInt(FIdentifier);
         TUtilityString.FlushUTF(param1,this.FFixed);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         var _loc2_:String = null;
         var _loc3_:Object = null;
         var _loc4_:Array = null;
         var _loc5_:int = 0;
         var _loc6_:uint = 0;
         var _loc7_:TFixedAward = null;
         this.FFixed = TUtilityString.FetchUTF(param1);
         _loc3_ = Json.decode(this.FFixed);
         _loc4_ = _loc3_.fixed as Array;
         _loc6_ = _loc4_.length;
         this.FFixedAwards = new Vector.<TFixedAward>(_loc6_);
         _loc5_ = 0;
         while(_loc5_ < _loc6_)
         {
            _loc7_ = new TFixedAward(_loc4_[_loc5_]);
            this.FFixedAwards[_loc5_] = _loc7_;
            _loc5_++;
         }
      }
      
      public function get FixedAwards() : Vector.<TFixedAward>
      {
         return this.FFixedAwards;
      }
      
      public function get Fixed() : String
      {
         return this.FFixed;
      }
   }
}

