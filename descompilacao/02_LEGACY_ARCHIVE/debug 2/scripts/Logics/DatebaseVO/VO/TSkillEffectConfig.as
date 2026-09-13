package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.*;
   import Foundation.Utilities.*;
   import Logics.DatebaseVO.*;
   import Logics.DatebaseVO.VO.Json.*;
   import flash.utils.*;
   import ghostcat.util.data.*;
   
   use namespace ResourcesSpace;
   
   public class TSkillEffectConfig extends TDatebaseVO
   {
      
      protected var FTiming:uint;
      
      protected var FPivotX:int;
      
      protected var FPivotY:int;
      
      protected var FDurationVect:Vector.<uint>;
      
      protected var FFrame:uint;
      
      protected var FTotleDuration:uint;
      
      protected var FDurations:String;
      
      public function TSkillEffectConfig()
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
         param1.writeUnsignedInt(this.FTiming);
         param1.writeUnsignedInt(this.FPivotX);
         param1.writeUnsignedInt(this.FPivotY);
         TUtilityString.FlushUTF(param1,this.FDurations);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         this.FTiming = param1.readUnsignedInt();
         this.FPivotX = param1.readUnsignedInt();
         this.FPivotY = param1.readUnsignedInt();
         this.FDurations = TUtilityString.FetchUTF(param1);
         this.FDurationVect = Vector.<uint>(Json.decode(this.FDurations));
         this.FTotleDuration = 0;
         _loc3_ = this.FDurationVect.length;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            this.FTotleDuration += this.FDurationVect[_loc2_];
            _loc2_++;
         }
      }
      
      public function get Timing() : uint
      {
         return this.FTiming;
      }
      
      public function get PivotX() : int
      {
         return this.FPivotX;
      }
      
      public function get PivotY() : int
      {
         return this.FPivotY;
      }
      
      public function get DurationVect() : Object
      {
         return this.FDurationVect;
      }
      
      public function get Frame() : uint
      {
         return this.FDurationVect.length;
      }
      
      public function get Durations() : String
      {
         return this.FDurations;
      }
      
      public function get TotleDuration() : uint
      {
         return this.FTotleDuration;
      }
   }
}

