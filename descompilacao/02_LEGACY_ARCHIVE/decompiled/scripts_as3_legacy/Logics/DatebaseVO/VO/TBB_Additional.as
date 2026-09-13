package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import flash.utils.ByteArray;
   import ghostcat.util.data.Json;
   
   use namespace ResourcesSpace;
   
   public class TBB_Additional extends TDatebaseVO
   {
      
      protected var FBaseAdditional:String;
      
      protected var FNearattackRate:Number;
      
      protected var FStrategyattackRate:Number;
      
      protected var FNeardefenseRate:Number;
      
      protected var FStrategydefenseRate:Number;
      
      protected var FSpeedRate:Number;
      
      protected var FHpRate:Number;
      
      protected var FAdditional:Vector.<uint>;
      
      public function TBB_Additional()
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
         TUtilityString.FlushUTF(param1,this.FBaseAdditional);
         param1.writeFloat(this.FNearattackRate);
         param1.writeFloat(this.FStrategyattackRate);
         param1.writeFloat(this.FNeardefenseRate);
         param1.writeFloat(this.FStrategydefenseRate);
         param1.writeFloat(this.FSpeedRate);
         param1.writeFloat(this.FHpRate);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         var _loc2_:uint = 0;
         this.FBaseAdditional = TUtilityString.FetchUTF(param1);
         this.FNearattackRate = this.SetValueByFloat(param1.readFloat());
         this.FStrategyattackRate = this.SetValueByFloat(param1.readFloat());
         this.FNeardefenseRate = this.SetValueByFloat(param1.readFloat());
         this.FStrategydefenseRate = this.SetValueByFloat(param1.readFloat());
         this.FSpeedRate = this.SetValueByFloat(param1.readFloat());
         this.FHpRate = this.SetValueByFloat(param1.readFloat());
         this.FAdditional = Vector.<uint>(Json.decode(this.FBaseAdditional));
      }
      
      protected function SetValueByFloat(param1:Number) : Number
      {
         var _loc2_:String = null;
         var _loc3_:Number = NaN;
         _loc2_ = param1.toFixed(3);
         return parseFloat(_loc2_);
      }
      
      public function get BaseAdditional() : String
      {
         return this.FBaseAdditional;
      }
      
      public function get NearattackRate() : Number
      {
         return this.FNearattackRate;
      }
      
      public function get StrategyattackRate() : Number
      {
         return this.FStrategyattackRate;
      }
      
      public function get NeardefenseRate() : Number
      {
         return this.FNeardefenseRate;
      }
      
      public function get StrategydefenseRate() : Number
      {
         return this.FStrategydefenseRate;
      }
      
      public function get SpeedRate() : Number
      {
         return this.FSpeedRate;
      }
      
      public function get HpRate() : Number
      {
         return this.FHpRate;
      }
      
      public function get Additional() : Vector.<uint>
      {
         return this.FAdditional;
      }
   }
}

