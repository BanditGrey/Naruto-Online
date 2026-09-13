package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import flash.utils.ByteArray;
   import ghostcat.util.data.Json;
   
   use namespace ResourcesSpace;
   
   public class TAwakenSkillClassification extends TDatebaseVO
   {
      
      protected var FName:String;
      
      protected var FSynthesis:String;
      
      protected var FType:int;
      
      protected var FHeChengNeedGodsArr:Array;
      
      protected var FQuality:int;
      
      public function TAwakenSkillClassification()
      {
         super();
      }
      
      override ResourcesSpace function WriteDataToStream(param1:ByteArray) : void
      {
         param1.writeUnsignedInt(FIdentifier);
         TUtilityString.FlushUTF(param1,this.FName);
         TUtilityString.FlushUTF(param1,this.FSynthesis);
         param1.writeUnsignedInt(this.FType);
         param1.writeUnsignedInt(this.FQuality);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         this.FName = TUtilityString.FetchUTF(param1);
         this.FSynthesis = TUtilityString.FetchUTF(param1);
         this.FHeChengNeedGodsArr = Json.decode(this.FSynthesis);
         this.FType = param1.readUnsignedInt();
         this.FQuality = param1.readUnsignedInt();
      }
      
      public function get Quality() : int
      {
         return this.FQuality;
      }
      
      public function get HeChengNeedGodsArr() : Array
      {
         return this.FHeChengNeedGodsArr;
      }
      
      public function get Name() : String
      {
         return this.FName;
      }
      
      public function get Synthesis() : String
      {
         return this.FSynthesis;
      }
      
      public function get Type() : int
      {
         return this.FType;
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

