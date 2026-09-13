package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import flash.utils.ByteArray;
   import ghostcat.util.data.Json;
   
   use namespace ResourcesSpace;
   
   public class TDrawNinja extends TDatebaseVO
   {
      
      protected var FNinjaid:int;
      
      protected var FType:int;
      
      protected var FStar1:String;
      
      protected var FStarVec1:Array;
      
      protected var FStar2:String;
      
      protected var FStarVec2:Array;
      
      protected var FStar3:String;
      
      protected var FStarVec3:Array;
      
      protected var FStar4:String;
      
      protected var FStarVec4:Array;
      
      protected var FStar5:String;
      
      protected var FStarVec5:Array;
      
      protected var FAssess:String;
      
      protected var FName:String;
      
      public function TDrawNinja()
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
         param1.writeUnsignedInt(this.FNinjaid);
         param1.writeUnsignedInt(this.FType);
         TUtilityString.FlushUTF(param1,this.FStar1);
         TUtilityString.FlushUTF(param1,this.FStar2);
         TUtilityString.FlushUTF(param1,this.FStar3);
         TUtilityString.FlushUTF(param1,this.FStar4);
         TUtilityString.FlushUTF(param1,this.FStar5);
         TUtilityString.FlushUTF(param1,this.FAssess);
         TUtilityString.FlushUTF(param1,this.FName);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         this.FNinjaid = param1.readUnsignedInt();
         this.FType = param1.readUnsignedInt();
         this.FStar1 = TUtilityString.FetchUTF(param1);
         this.FStarVec1 = Json.decode(this.FStar1);
         this.FStar2 = TUtilityString.FetchUTF(param1);
         this.FStarVec2 = Json.decode(this.FStar2);
         this.FStar3 = TUtilityString.FetchUTF(param1);
         this.FStarVec3 = Json.decode(this.FStar3);
         this.FStar4 = TUtilityString.FetchUTF(param1);
         this.FStarVec4 = Json.decode(this.FStar4);
         this.FStar5 = TUtilityString.FetchUTF(param1);
         this.FStarVec5 = Json.decode(this.FStar5);
         this.FAssess = TUtilityString.FetchUTF(param1);
         this.FName = TUtilityString.FetchUTF(param1);
      }
      
      public function get Ninjaid() : int
      {
         return this.FNinjaid;
      }
      
      public function get Type() : int
      {
         return this.FType;
      }
      
      public function get Star1() : String
      {
         return this.FStar1;
      }
      
      public function get StarVec1() : Array
      {
         return this.FStarVec1;
      }
      
      public function get Star2() : String
      {
         return this.FStar2;
      }
      
      public function get StarVec2() : Array
      {
         return this.FStarVec2;
      }
      
      public function get Star3() : String
      {
         return this.FStar3;
      }
      
      public function get StarVec3() : Array
      {
         return this.FStarVec3;
      }
      
      public function get Star4() : String
      {
         return this.FStar4;
      }
      
      public function get StarVec4() : Array
      {
         return this.FStarVec4;
      }
      
      public function get Star5() : String
      {
         return this.FStar5;
      }
      
      public function get StarVec5() : Array
      {
         return this.FStarVec5;
      }
      
      public function get Assess() : String
      {
         return this.FAssess;
      }
      
      public function get Name() : String
      {
         return this.FName;
      }
   }
}

