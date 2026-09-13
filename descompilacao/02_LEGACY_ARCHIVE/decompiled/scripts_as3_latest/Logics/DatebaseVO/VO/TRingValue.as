package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import flash.utils.ByteArray;
   
   use namespace ResourcesSpace;
   
   public class TRingValue extends TDatebaseVO
   {
      
      protected var FRingId:int;
      
      protected var FBuildLevel:int;
      
      protected var FExp:int;
      
      protected var FTotalexp:int;
      
      protected var FValue:String;
      
      protected var FCharm:int;
      
      public function TRingValue()
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
         param1.writeInt(this.FRingId);
         param1.writeInt(this.FBuildLevel);
         param1.writeInt(this.FExp);
         param1.writeInt(this.FTotalexp);
         TUtilityString.FlushUTF(param1,this.FValue);
         param1.writeInt(this.FCharm);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         this.FRingId = param1.readInt();
         this.FBuildLevel = param1.readInt();
         this.FExp = param1.readInt();
         this.FTotalexp = param1.readInt();
         this.FValue = TUtilityString.FetchUTF(param1);
         this.FCharm = param1.readInt();
      }
      
      public function get RingId() : int
      {
         return this.FRingId;
      }
      
      public function get BuildLevel() : int
      {
         return this.FBuildLevel;
      }
      
      public function get Exp() : int
      {
         return this.FExp;
      }
      
      public function get Totalexp() : int
      {
         return this.FTotalexp;
      }
      
      public function get Value() : String
      {
         return this.FValue;
      }
      
      public function get Charm() : int
      {
         return this.FCharm;
      }
   }
}

