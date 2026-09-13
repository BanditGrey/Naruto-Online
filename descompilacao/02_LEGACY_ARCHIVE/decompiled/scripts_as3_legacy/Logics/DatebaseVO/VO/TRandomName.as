package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import flash.utils.ByteArray;
   
   use namespace ResourcesSpace;
   
   public class TRandomName extends TDatebaseVO
   {
      
      protected var FLastNames:Array;
      
      protected var FMaleNames:Array;
      
      protected var FFemaleNames:Array;
      
      protected var FMaleNames2:Array;
      
      protected var FFemaleNames2:Array;
      
      protected var FUrname:String;
      
      protected var FMenName:String;
      
      protected var FMenName2:String;
      
      protected var FFemaleName:String;
      
      protected var FFemaleName2:String;
      
      public function TRandomName()
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
         TUtilityString.FlushUTF(param1,this.FUrname);
         TUtilityString.FlushUTF(param1,this.FMenName);
         TUtilityString.FlushUTF(param1,this.FMenName2);
         TUtilityString.FlushUTF(param1,this.FFemaleName);
         TUtilityString.FlushUTF(param1,this.FFemaleName2);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         var _loc2_:String = null;
         this.FUrname = TUtilityString.FetchUTF(param1);
         this.FLastNames = this.FUrname.split(",");
         this.FMenName = TUtilityString.FetchUTF(param1);
         this.FMaleNames = this.FMenName.split(",");
         this.FMenName2 = TUtilityString.FetchUTF(param1);
         this.FMaleNames2 = this.FMenName2.split(",");
         this.FFemaleName = TUtilityString.FetchUTF(param1);
         this.FFemaleNames = this.FFemaleName.split(",");
         this.FFemaleName2 = TUtilityString.FetchUTF(param1);
         this.FFemaleNames2 = this.FFemaleName2.split(",");
      }
      
      public function get LastNames() : Array
      {
         return this.FLastNames;
      }
      
      public function get MaleNames() : Array
      {
         return this.FMaleNames;
      }
      
      public function get FemaleNames() : Array
      {
         return this.FFemaleNames;
      }
      
      public function get MaleNames2() : Array
      {
         return this.FMaleNames2;
      }
      
      public function get FemaleNames2() : Array
      {
         return this.FFemaleNames2;
      }
      
      public function get Urname() : String
      {
         return this.FUrname;
      }
      
      public function get MenName() : String
      {
         return this.FMenName;
      }
      
      public function get FemaleName() : String
      {
         return this.FFemaleName;
      }
      
      public function get MenName2() : String
      {
         return this.FMenName2;
      }
      
      public function get FemaleName2() : String
      {
         return this.FFemaleName2;
      }
   }
}

