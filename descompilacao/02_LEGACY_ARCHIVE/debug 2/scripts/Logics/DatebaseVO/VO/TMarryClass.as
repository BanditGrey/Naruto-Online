package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import flash.utils.ByteArray;
   
   use namespace ResourcesSpace;
   
   public class TMarryClass extends TDatebaseVO
   {
      
      protected var FName:String;
      
      protected var FDesc:String;
      
      protected var FStars:int;
      
      protected var FQuality:int;
      
      protected var FPicture:int;
      
      protected var FNeedCharm:int;
      
      protected var FAllCharm:int;
      
      protected var FValue:String;
      
      protected var FLandNum:int;
      
      protected var FFailRate:int;
      
      protected var FDivorceCost:String;
      
      public function TMarryClass()
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
         TUtilityString.FlushUTF(param1,this.FName);
         TUtilityString.FlushUTF(param1,this.FDesc);
         param1.writeInt(this.FStars);
         param1.writeInt(this.FQuality);
         param1.writeInt(this.FPicture);
         param1.writeInt(this.FNeedCharm);
         param1.writeInt(this.FAllCharm);
         TUtilityString.FlushUTF(param1,this.FValue);
         param1.writeInt(this.FLandNum);
         param1.writeInt(this.FFailRate);
         TUtilityString.FlushUTF(param1,this.FDivorceCost);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         this.FName = TUtilityString.FetchUTF(param1);
         this.FDesc = TUtilityString.FetchUTF(param1);
         this.FStars = param1.readInt();
         this.FQuality = param1.readInt();
         this.FPicture = param1.readInt();
         this.FNeedCharm = param1.readInt();
         this.FAllCharm = param1.readInt();
         this.FValue = TUtilityString.FetchUTF(param1);
         this.FLandNum = param1.readInt();
         this.FFailRate = param1.readInt();
         this.FDivorceCost = TUtilityString.FetchUTF(param1);
      }
      
      public function get Name() : String
      {
         return this.FName;
      }
      
      public function get Desc() : String
      {
         return this.FDesc;
      }
      
      public function get Stars() : int
      {
         return this.FStars;
      }
      
      public function get Quality() : int
      {
         return this.FQuality;
      }
      
      public function get Picture() : int
      {
         return this.FPicture;
      }
      
      public function get NeedCharm() : int
      {
         return this.FNeedCharm;
      }
      
      public function get AllCharm() : int
      {
         return this.FAllCharm;
      }
      
      public function get Value() : String
      {
         return this.FValue;
      }
      
      public function get LandNum() : int
      {
         return this.FLandNum;
      }
      
      public function get FailRate() : int
      {
         return this.FFailRate;
      }
      
      public function get DivorceCost() : String
      {
         return this.FDivorceCost;
      }
   }
}

