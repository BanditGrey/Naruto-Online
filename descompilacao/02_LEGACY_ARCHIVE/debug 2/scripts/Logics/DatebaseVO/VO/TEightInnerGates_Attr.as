package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import flash.utils.ByteArray;
   import ghostcat.util.data.Json;
   
   use namespace ResourcesSpace;
   
   public class TEightInnerGates_Attr extends TDatebaseVO
   {
      
      protected var FMajorType:int;
      
      protected var FSequence:int;
      
      protected var FConsumption:int;
      
      protected var FName:String;
      
      protected var FAddAttr:String;
      
      protected var FAddAttrArr:Array;
      
      protected var FBackground:int;
      
      protected var FLabel:int;
      
      public function TEightInnerGates_Attr()
      {
         super();
      }
      
      public function get Label() : int
      {
         return this.FLabel;
      }
      
      public function get Background() : int
      {
         return this.FBackground;
      }
      
      public function get Name() : String
      {
         return this.FName;
      }
      
      public function get MajorType() : int
      {
         return this.FMajorType;
      }
      
      public function get Sequence() : int
      {
         return this.FSequence;
      }
      
      public function get Consumption() : int
      {
         return this.FConsumption;
      }
      
      public function get AddAttr() : String
      {
         return this.FAddAttr;
      }
      
      public function get AddAttrArr() : Array
      {
         return this.FAddAttrArr;
      }
      
      override ResourcesSpace function WriteDataToStream(param1:ByteArray) : void
      {
         param1.writeUnsignedInt(FIdentifier);
         param1.writeUnsignedInt(this.FMajorType);
         param1.writeUnsignedInt(this.FSequence);
         param1.writeUnsignedInt(this.FConsumption);
         TUtilityString.FlushUTF(param1,this.FName);
         TUtilityString.FlushUTF(param1,this.FAddAttr);
         param1.writeUnsignedInt(this.FBackground);
         param1.writeUnsignedInt(this.FLabel);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         this.FMajorType = param1.readUnsignedInt();
         this.FSequence = param1.readUnsignedInt();
         this.FConsumption = param1.readUnsignedInt();
         this.FName = TUtilityString.FetchUTF(param1);
         this.FAddAttr = TUtilityString.FetchUTF(param1);
         this.FAddAttrArr = Json.decode(this.FAddAttr);
         this.FBackground = param1.readUnsignedInt();
         this.FLabel = param1.readUnsignedInt();
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

