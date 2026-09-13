package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import flash.utils.ByteArray;
   import ghostcat.util.data.Json;
   
   use namespace ResourcesSpace;
   
   public class TAwakenSkillConfig extends TDatebaseVO
   {
      
      protected var FName:String;
      
      protected var FType:int;
      
      protected var FQuality:int;
      
      protected var FSkillID:int;
      
      protected var FSynthesis:String;
      
      protected var FSilverSynthesis:int;
      
      protected var FAddValue:String;
      
      protected var FDescription:String;
      
      protected var FNextSkillID:int;
      
      protected var FSynthesisArr:Array;
      
      protected var FAddValueArr:Array;
      
      public function TAwakenSkillConfig()
      {
         super();
      }
      
      override ResourcesSpace function WriteDataToStream(param1:ByteArray) : void
      {
         param1.writeUnsignedInt(FIdentifier);
         TUtilityString.FlushUTF(param1,this.FName);
         param1.writeUnsignedInt(this.FType);
         param1.writeUnsignedInt(this.FQuality);
         param1.writeUnsignedInt(this.FSkillID);
         TUtilityString.FlushUTF(param1,this.FSynthesis);
         param1.writeUnsignedInt(this.FSilverSynthesis);
         TUtilityString.FlushUTF(param1,this.FAddValue);
         TUtilityString.FlushUTF(param1,this.FDescription);
         param1.writeUnsignedInt(this.FNextSkillID);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         this.FName = TUtilityString.FetchUTF(param1);
         this.FType = param1.readUnsignedInt();
         this.FQuality = param1.readUnsignedInt();
         this.FSkillID = param1.readUnsignedInt();
         this.FSynthesis = TUtilityString.FetchUTF(param1);
         this.FSynthesisArr = Json.decode(this.FSynthesis);
         this.FSilverSynthesis = param1.readUnsignedInt();
         this.FAddValue = TUtilityString.FetchUTF(param1);
         if(this.FAddValue != "")
         {
            this.FAddValueArr = Json.decode(this.FAddValue);
         }
         this.FDescription = TUtilityString.FetchUTF(param1);
         this.FNextSkillID = param1.readUnsignedInt();
      }
      
      public function get NextSkillID() : int
      {
         return this.FNextSkillID;
      }
      
      public function get Description() : String
      {
         return this.FDescription;
      }
      
      public function get AddValueArr() : Array
      {
         return this.FAddValueArr;
      }
      
      public function get SynthesisArr() : Array
      {
         return this.FSynthesisArr;
      }
      
      public function get AddValue() : String
      {
         return this.FAddValue;
      }
      
      public function get SilverSynthesis() : int
      {
         return this.FSilverSynthesis;
      }
      
      public function get Synthesis() : String
      {
         return this.FSynthesis;
      }
      
      public function get SkillID() : int
      {
         return this.FSkillID;
      }
      
      public function get Quality() : int
      {
         return this.FQuality;
      }
      
      public function get Type() : int
      {
         return this.FType;
      }
      
      public function get Name() : String
      {
         return this.FName;
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

